# Dated: 2026-08-07 00:09 ET
# File: Collect-CheckupLogs-2026-08-07.ps1
#
# WHAT IT DOES: copies Checkup's run logs into the project's Test_Results
# folder, so OneDrive syncs them back automatically and there is no USB round
# trip after a field test.
#
# WHY IT EXISTS: Checkup writes its log to C:\GatewayGuard\Logs\, which is NOT
# inside any OneDrive folder and never syncs. That path is deliberate -- it is a
# fixed recovery point and must not move (CLAUDE.md). So the log is brought to
# the synced folder instead of the folder being moved to the log.
#
# COPY ONLY. It never deletes, moves, or edits a log. The originals stay exactly
# where Checkup put them. Running it twice is harmless -- a log already copied is
# skipped, so nothing is overwritten and nothing is duplicated.
#
# DOES NOT NEED ADMINISTRATOR.
#
# NO EXTERNAL COMMANDS -- nothing for gate 24 to verify.
#
# PS 5.1 COMPATIBLE: -join only, no Join-String, no ternary.

$ErrorActionPreference = 'Continue'

$src = 'C:\GatewayGuard\Logs'

# Test_Results sits beside Tool\, one level up from this script.
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projRoot  = Split-Path -Parent $scriptDir
$dstRoot   = Join-Path $projRoot 'Test_Results'
$dst       = Join-Path $dstRoot ('Logs-' + $env:COMPUTERNAME)

Write-Host ""
Write-Host "================================================================"
Write-Host " COLLECT CHECKUP LOGS -- copy only, deletes nothing"
Write-Host "================================================================"
Write-Host ("  Computer : " + $env:COMPUTERNAME)
Write-Host ("  From     : " + $src)
Write-Host ("  To       : " + $dst)
Write-Host ""

if (-not (Test-Path -LiteralPath $src)) {
    Write-Host "  There is no C:\GatewayGuard\Logs folder on this computer."
    Write-Host "  That means Checkup has not been run here yet. Nothing to collect."
    Write-Host ""
    return
}

$logs = @(Get-ChildItem -LiteralPath $src -File -Filter '*.txt' -ErrorAction SilentlyContinue)
if ($logs.Count -eq 0) {
    Write-Host "  The logs folder exists but has no .txt logs in it. Nothing to collect."
    Write-Host ""
    return
}

if (-not (Test-Path -LiteralPath $dstRoot)) {
    Write-Host "  The Test_Results folder is missing, so this does not look like the"
    Write-Host "  project folder. Expected it here:"
    Write-Host ("    " + $dstRoot)
    Write-Host "  Put this script back in the project's Tool folder and run it again."
    Write-Host ""
    return
}
if (-not (Test-Path -LiteralPath $dst)) {
    New-Item -ItemType Directory -Path $dst -Force | Out-Null
}

$copied  = 0
$skipped = 0
foreach ($f in $logs) {
    $target = Join-Path $dst $f.Name
    $already = $false
    if (Test-Path -LiteralPath $target) {
        # same name AND same size = already collected. Size is enough here:
        # Checkup never rewrites a log once its run has finished.
        $t = Get-Item -LiteralPath $target
        if ($t.Length -eq $f.Length) { $already = $true }
    }
    if ($already) {
        $skipped = $skipped + 1
    } else {
        Copy-Item -LiteralPath $f.FullName -Destination $target -Force
        $copied = $copied + 1
    }
}

$bytes = 0
foreach ($f in $logs) { $bytes = $bytes + $f.Length }

Write-Host ("  Logs found on this computer : " + $logs.Count)
Write-Host ("  Newly copied                : " + $copied)
Write-Host ("  Already collected, skipped  : " + $skipped)
Write-Host ("  Total size                  : " + ("{0:N1}" -f ($bytes/1KB)) + " KB")
Write-Host ""
Write-Host ("  Newest log : " + (@($logs | Sort-Object LastWriteTime -Descending)[0].Name))
Write-Host ""
Write-Host "  The originals are untouched in C:\GatewayGuard\Logs."
Write-Host ""
Write-Host "  WHAT HAPPENS NEXT: OneDrive syncs the Test_Results folder, so these"
Write-Host "  logs reach the other computer on their own. Watch the cloud icon in"
Write-Host "  the notification area, bottom right. When it says your files are"
Write-Host "  synced, they have arrived. If sync is turned off on this computer,"
Write-Host "  nothing will leave it -- turn sync back on first."
Write-Host ""
