$ErrorActionPreference = 'Stop'

$checks = @(
    @{ Name = 'Codex global memory entry'; Path = 'D:\Codex\home\AGENTS.md'; Pattern = 'memory-policy\.md' },
    @{ Name = 'Vault global rules'; Path = 'D:\Codex\vault\00_System\Codex\global-rules.md'; Pattern = 'D:\\Codex\\vault' },
    @{ Name = 'Memory policy'; Path = 'D:\Codex\vault\00_System\Codex\memory-policy.md'; Pattern = 'status: reviewed' },
    @{ Name = 'Feedback event schema'; Path = 'D:\Codex\vault\00_System\Codex\feedback-event-schema.md'; Pattern = 'event_id:' },
    @{ Name = 'Daily review template'; Path = 'D:\Codex\vault\00_System\Codex\daily-review-template.md'; Pattern = 'status: candidate' },
    @{ Name = 'Candidate inbox'; Path = 'D:\Codex\vault\00_Inbox'; Pattern = $null },
    @{ Name = 'Project memory root'; Path = 'D:\Codex\vault\30_Projects'; Pattern = $null }
)

$failed = $false
foreach ($check in $checks) {
    $exists = Test-Path -LiteralPath $check.Path
    $matches = $exists
    if ($exists -and $check.Pattern) {
        $matches = [bool](Select-String -LiteralPath $check.Path -Pattern $check.Pattern -Quiet)
    }

    $status = if ($exists -and $matches) { 'PASS' } else { 'FAIL' }
    Write-Output ("{0} {1}: {2}" -f $status, $check.Name, $check.Path)
    if ($status -eq 'FAIL') { $failed = $true }
}

if ($failed) {
    throw 'Obsidian memory configuration validation failed.'
}

Write-Output 'Obsidian memory configuration is ready.'
