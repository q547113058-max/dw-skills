param(
  [Parameter(Position = 0)]
  [ValidateSet("check", "mark", "update")]
  [string]$Action = "check",

  [string]$Skill = "all",

  [int]$MaxAgeDays = 7,

  [string]$StatePath = ""
)

$ErrorActionPreference = "Stop"

if (-not $StatePath) {
  $StatePath = Join-Path $PSScriptRoot "..\work\skill-update-state.json"
}

$Skills = @(
  [pscustomobject]@{ Name = "frontend-design"; Source = "https://github.com/anthropics/skills/tree/main/skills/frontend-design"; LocalPath = "C:\Users\54711\.codex\skills\frontend-design\SKILL.md"; Kind = "github-skill" },
  [pscustomobject]@{ Name = "awesome-design-md"; Source = "https://github.com/VoltAgent/awesome-design-md"; LocalPath = ""; Kind = "design-library" },
  [pscustomobject]@{ Name = "taste-skill"; Source = "https://github.com/Leonxlnx/taste-skill"; LocalPath = "C:\Users\54711\.codex\skills\taste-skill\SKILL.md"; Kind = "github-skill" },
  [pscustomobject]@{ Name = "codegraph"; Source = "https://github.com/colbymchenry/codegraph"; LocalPath = ""; Kind = "pending" },
  [pscustomobject]@{ Name = "graphify"; Source = "https://github.com/safishamsi/graphify"; LocalPath = "C:\Users\54711\.codex\skills\graphify\SKILL.md"; Kind = "github-skill" },
  [pscustomobject]@{ Name = "agentmemory"; Source = "https://github.com/rohitg00/agentmemory"; LocalPath = ""; Kind = "pending" },
  [pscustomobject]@{ Name = "ponytail"; Source = "https://github.com/DietrichGebert/ponytail"; LocalPath = ""; Kind = "pending" },
  [pscustomobject]@{ Name = "superpowers"; Source = "https://github.com/obra/superpowers"; LocalPath = ""; Kind = "pending" },
  [pscustomobject]@{ Name = "vpn-mihomo"; Source = "local-private"; LocalPath = "C:\Users\54711\.codex\skills\vpn-mihomo\SKILL.md"; Kind = "local-private" },
  [pscustomobject]@{ Name = "github"; Source = "https://cli.github.com/"; LocalPath = "C:\Users\54711\.codex\skills\github\SKILL.md"; Kind = "tool" }
)

function Read-State {
  if (-not (Test-Path -LiteralPath $StatePath)) {
    return @{}
  }

  $raw = Get-Content -Raw -LiteralPath $StatePath
  if (-not $raw.Trim()) {
    return @{}
  }

  $json = $raw | ConvertFrom-Json
  $state = @{}
  foreach ($prop in $json.PSObject.Properties) {
    $state[$prop.Name] = $prop.Value
  }
  return $state
}

function Write-State([hashtable]$State) {
  $dir = Split-Path -Parent $StatePath
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  $State | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $StatePath -Encoding utf8
}

function Get-LocalRoot([string]$Path) {
  if (-not $Path) { return "" }
  if ($Path.EndsWith("SKILL.md")) {
    return Split-Path -Parent $Path
  }
  return $Path
}

function Get-GitHubSlug([string]$Url) {
  if ($Url -match "github\.com/([^/]+/[^/#?]+)") {
    return $Matches[1].TrimEnd(".git")
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
      } catch {
        continue
      }
    }
  }

  $slug = Get-GitHubSlug $Url
  if (-not $slug) { return "" }

  try {
    $branch = gh api "repos/$slug" --jq .default_branch 2>$null
    if (-not $branch) { return "" }
    return (gh api "repos/$slug/commits/$branch" --jq .sha 2>$null)
  } catch {
    return ""
  }
}

function Get-LocalSha([string]$Path) {
  $root = Get-LocalRoot $Path
  if (-not $root -or -not (Test-Path -LiteralPath $root)) { return "" }
  if (-not (Test-Path -LiteralPath (Join-Path $root ".git"))) { return "" }

  try {
    return (git -C $root rev-parse HEAD 2>$null)
  } catch {
    return ""
  }
}

function Test-Due($Record, [datetime]$Now) {
  if (-not $Record -or -not $Record.lastChecked) { return $true }
  try {
    $last = [datetime]$Record.lastChecked
    return (($Now - $last).TotalDays -ge $MaxAgeDays)
  } catch {
    return $true
  }
}

$now = Get-Date
$state = Read-State
$selected = if ($Skill -eq "all") {
  $Skills
} else {
  $Skills | Where-Object { $_.Name -eq $Skill }
}

if (-not $selected) {
  throw "Unknown skill '$Skill'."
}

$results = foreach ($entry in $selected) {
  $record = $state[$entry.Name]
  $due = Test-Due $record $now
  $localRoot = Get-LocalRoot $entry.LocalPath
  $exists = [bool]($localRoot -and (Test-Path -LiteralPath $localRoot))
  $localSha = Get-LocalSha $entry.LocalPath
  $remoteSha = if ($Action -in @("mark", "update") -or $due) { Get-RemoteSha $entry.Source } else { if ($record) { $record.remoteSha } else { "" } }
  $status = "checked"
  $note = ""

  if ($entry.Kind -eq "pending") {
    $status = "pending-config"
    $note = "No local path configured; review source before installation."
  } elseif ($entry.Kind -eq "design-library") {
    $status = "reference-source"
    $note = "Remote DESIGN.md library; fetch only the matched design-md slug on demand."
  } elseif ($entry.Kind -eq "local-private") {
    $status = "local-private"
    $note = "Local private skill; do not upload secrets while updating public docs."
  } elseif (-not $exists) {
    $status = "missing-local"
    $note = "Local path is missing."
  } elseif ($localSha -and $remoteSha -and $localSha -ne $remoteSha) {
    $status = "remote-differs"
    $note = "Local git checkout differs from remote; update manually after review."
  } elseif ($entry.Kind -eq "tool") {
    $status = "tool-check"
    $note = "Check installed CLI/plugin version separately when needed."
  } elseif (-not $localSha) {
    $status = "not-git"
    $note = "Local skill is not a git checkout; compare source manually if update is due."
  }

  if ($Action -in @("mark", "update")) {
    $state[$entry.Name] = [ordered]@{
      lastChecked = $now.ToString("o")
      source = $entry.Source
      localPath = $entry.LocalPath
      kind = $entry.Kind
      status = $status
      localSha = $localSha
      remoteSha = $remoteSha
      note = $note
    }
  }

  [pscustomobject]@{
    Skill = $entry.Name
    Due = $due
    Status = $status
    LastChecked = if ($record) { $record.lastChecked } else { "" }
    LocalExists = $exists
    RemoteSha = if ($remoteSha) { $remoteSha.Substring(0, [Math]::Min(12, $remoteSha.Length)) } else { "" }
    Note = $note
  }
}

if ($Action -in @("mark", "update")) {
  Write-State $state
}

$results | Format-Table -AutoSize
