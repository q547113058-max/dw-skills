param(
  [Parameter(Position = 0)]
  [ValidateSet("check", "mark", "update")]
  [string]$Action = "check",

  [string]$Skill = "all",

  [int]$MaxAgeDays = 0,

  [string]$StatePath = "",

  [switch]$IncludeCandidates
)

$ErrorActionPreference = "Stop"

if (-not $StatePath) {
  $StatePath = Join-Path $PSScriptRoot "..\work\skill-update-state.json"
}

$ActiveSkills = @(
  [pscustomobject]@{ Name = "graphify"; Source = "https://github.com/safishamsi/graphify"; LocalPath = "C:\Users\54711\.codex\skills\graphify\SKILL.md"; Kind = "github-skill"; Policy = "monthly"; IntervalDays = 30; Scope = "active" },
  [pscustomobject]@{ Name = "vpn-mihomo"; Source = "local-private"; LocalPath = "C:\Users\54711\.codex\skills\vpn-mihomo\SKILL.md"; Kind = "local-private"; Policy = "before-use"; IntervalDays = 0; Scope = "active" },
  [pscustomobject]@{ Name = "github"; Source = "https://cli.github.com/"; LocalPath = "C:\Users\54711\.codex\skills\github\SKILL.md"; Kind = "tool"; Policy = "before-use"; IntervalDays = 0; Scope = "active" }
)

$CandidateSkills = @(
  [pscustomobject]@{ Name = "codegraph"; Source = "https://github.com/colbymchenry/codegraph"; LocalPath = ""; Kind = "candidate"; Policy = "explicit"; IntervalDays = 0; Scope = "candidate" },
  [pscustomobject]@{ Name = "agentmemory"; Source = "https://github.com/rohitg00/agentmemory"; LocalPath = ""; Kind = "candidate"; Policy = "explicit"; IntervalDays = 0; Scope = "candidate" },
  [pscustomobject]@{ Name = "ponytail"; Source = "https://github.com/DietrichGebert/ponytail"; LocalPath = ""; Kind = "candidate"; Policy = "explicit"; IntervalDays = 0; Scope = "candidate" },
  [pscustomobject]@{ Name = "superpowers"; Source = "https://github.com/obra/superpowers"; LocalPath = ""; Kind = "candidate"; Policy = "explicit"; IntervalDays = 0; Scope = "candidate" }
)

function Read-State {
  if (-not (Test-Path -LiteralPath $StatePath)) { return @{} }
  $raw = Get-Content -Raw -LiteralPath $StatePath
  if (-not $raw.Trim()) { return @{} }

  $json = $raw | ConvertFrom-Json
  $state = @{}
  foreach ($prop in $json.PSObject.Properties) {
    $state[$prop.Name] = $prop.Value
  }
  return $state
}

function Write-State([hashtable]$State) {
  $dir = Split-Path -Parent $StatePath
  if ($dir) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
  $State | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $StatePath -Encoding utf8
}

function Get-LocalRoot([string]$Path) {
  if (-not $Path) { return "" }
  if ($Path.EndsWith("SKILL.md")) { return Split-Path -Parent $Path }
  return $Path
}

function Get-GitHubSlug([string]$Url) {
  if ($Url -match "github\.com/([^/]+/[^/#?]+)") {
    return ($Matches[1] -replace "\.git$", "")
  }
  return ""
}

function Get-GitHubTreeSource([string]$Url) {
  if ($Url -match "github\.com/([^/]+)/([^/]+)/tree/([^/]+)/(.*)$") {
    return [pscustomobject]@{
      Slug = $Matches[1] + "/" + $Matches[2]
      Ref = $Matches[3]
      Path = $Matches[4].Trim("/")
    }
  }
  return $null
}

function Get-RemoteSha([string]$Url) {
  $tree = Get-GitHubTreeSource $Url
  if ($tree) {
    foreach ($candidate in @("$($tree.Path)/SKILL.md", $tree.Path)) {
      try {
        $encoded = [Uri]::EscapeDataString($candidate).Replace("%2F", "/")
        $result = gh api "repos/$($tree.Slug)/contents/$encoded`?ref=$($tree.Ref)" --jq .sha 2>$null
        if ($result) { return $result }
      } catch { continue }
    }
  }

  $slug = Get-GitHubSlug $Url
  if (-not $slug) { return "" }
  try {
    $branch = gh api "repos/$slug" --jq .default_branch 2>$null
    if (-not $branch) { return "" }
    return (gh api "repos/$slug/commits/$branch" --jq .sha 2>$null)
  } catch { return "" }
}

function Get-LocalSha([string]$Path) {
  $root = Get-LocalRoot $Path
  if (-not $root -or -not (Test-Path -LiteralPath $root)) { return "" }
  try { return (git -C $root rev-parse HEAD 2>$null) } catch { return "" }
}

function Test-Due($Entry, $Record, [datetime]$Now) {
  if ($Entry.Policy -in @("before-use", "explicit")) { return $true }
  if (-not $Record -or -not $Record.lastChecked) { return $true }
  $days = if ($MaxAgeDays -gt 0) { $MaxAgeDays } else { $Entry.IntervalDays }
  try {
    $last = [datetime]$Record.lastChecked
    return (($Now - $last).TotalDays -ge $days)
  } catch { return $true }
}

$allSkills = if ($IncludeCandidates) { @($ActiveSkills) + @($CandidateSkills) } else { $ActiveSkills }
$selected = if ($Skill -eq "all") { $allSkills } else { $allSkills | Where-Object { $_.Name -eq $Skill } }
if (-not $selected) {
  $hint = if ($IncludeCandidates) { "" } else { " Use -IncludeCandidates for candidate skills." }
  throw "Unknown or inactive skill '$Skill'.$hint"
}

$now = Get-Date
$state = Read-State
$results = foreach ($entry in $selected) {
  $record = $state[$entry.Name]
  $due = Test-Due $entry $record $now
  $shouldProbe = $due -or $Action -in @("mark", "update")
  $localRoot = Get-LocalRoot $entry.LocalPath
  $exists = [bool]($localRoot -and (Test-Path -LiteralPath $localRoot))
  $localSha = if ($shouldProbe) { Get-LocalSha $entry.LocalPath } elseif ($record) { $record.localSha } else { "" }
  $remoteSha = if ($shouldProbe -and $entry.Kind -notin @("local-private", "tool")) { Get-RemoteSha $entry.Source } elseif ($record) { $record.remoteSha } else { "" }
  $succeeded = $false
  $status = "not-due"
  $note = "Checked recently; no source probe was needed."

  if ($shouldProbe) {
    switch ($entry.Kind) {
      "candidate" {
        $succeeded = [bool]$remoteSha
        $status = if ($succeeded) { "candidate-source-ok" } else { "check-failed" }
        $note = if ($succeeded) { "Candidate source is reachable; no runtime was installed." } else { "Could not retrieve the candidate source revision." }
      }
      "design-library" {
        $succeeded = [bool]$remoteSha
        $status = if ($succeeded) { "reference-source" } else { "check-failed" }
        $note = if ($succeeded) { "Remote design library is reachable; fetch only matched references." } else { "Could not retrieve the design library revision." }
      }
      "local-private" {
        $succeeded = $exists
        $status = if ($succeeded) { "local-private" } else { "missing-local" }
        $note = if ($succeeded) { "Local private skill exists; secrets were not inspected or recorded." } else { "Local private skill path is missing." }
      }
      "tool" {
        $succeeded = [bool](Get-Command gh -ErrorAction SilentlyContinue)
        $status = if ($succeeded) { "tool-available" } else { "missing-tool" }
        $note = if ($succeeded) { "GitHub CLI is available; authenticate only for an authorized operation." } else { "GitHub CLI is not available." }
      }
      default {
        $succeeded = $exists -and [bool]$remoteSha
        if (-not $exists) {
          $status = "missing-local"
          $note = "Local skill path is missing."
        } elseif (-not $remoteSha) {
          $status = "check-failed"
          $note = "Could not retrieve the remote revision; lastChecked was not advanced."
        } elseif ($localSha -and $localSha -ne $remoteSha) {
          $status = "remote-differs"
          $note = "Local git checkout differs from remote; review before updating."
        } elseif (-not $localSha) {
          $status = "not-git"
          $note = "Local skill is not a git checkout; compare source manually."
        } else {
          $status = "up-to-date"
          $note = "Local and remote revisions match."
        }
      }
    }
  }

  if ($Action -in @("mark", "update")) {
    $newRecord = [ordered]@{
      lastAttempt = $now.ToString("o")
      lastCheckSucceeded = $succeeded
      source = $entry.Source
      localPath = $entry.LocalPath
      kind = $entry.Kind
      scope = $entry.Scope
      policy = $entry.Policy
      status = $status
      localSha = $localSha
      remoteSha = $remoteSha
      note = $note
    }
    if ($succeeded) {
      $newRecord.lastChecked = $now.ToString("o")
    } elseif ($record -and $record.lastChecked) {
      $newRecord.lastChecked = $record.lastChecked
    }
    $state[$entry.Name] = $newRecord
  }

  $reportedLastChecked = if ($Action -in @("mark", "update") -and $succeeded) {
    $now.ToString("o")
  } elseif ($record) {
    $record.lastChecked
  } else {
    ""
  }

  [pscustomobject]@{
    Skill = $entry.Name
    Scope = $entry.Scope
    Policy = $entry.Policy
    Due = $due
    CheckSucceeded = if ($shouldProbe) { $succeeded } else { $null }
    Status = $status
    LastChecked = $reportedLastChecked
    Note = $note
  }
}

if ($Action -in @("mark", "update")) { Write-State $state }
$results | Format-Table -AutoSize
