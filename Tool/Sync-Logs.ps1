# Sync-Logs.ps1
# Dated: 2026-08-12 16:20 ET
# Copies Checkup's logs from C:\GatewayGuard\Logs into OneDrive at
# Test_Results\Logs\<MACHINE>\ so nothing is stranded on one laptop.
#
# READ-ONLY with respect to Checkup. It never deletes from C:\GatewayGuard\,
# never writes there, and cannot disturb a run or a resume. Checkup tells the
# user on screen to keep that log file and email it to support -- so this
# copies, it does not move.
#
# Run it ON the machine that produced the logs. SANDY's logs are on SANDY.

$ErrorActionPreference = 'Stop'

$machine = $env:COMPUTERNAME
$live    = 'C:\GatewayGuard\Logs'
$root    = 'C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard'
$dest    = Join-Path $root ("Test_Results\Logs\" + $machine)
$report  = Join-Path $dest ("_SyncLogs-" + (Get-Date -Format 'yyyy-MM-dd_HH-mm') + ".txt")

$out = New-Object System.Collections.Generic.List[string]
function Say([string]$s) { $out.Add($s); Write-Output $s }

Say "Sync-Logs -- $machine -- $(Get-Date -Format 'yyyy-MM-dd HH:mm') ET"
Say ""

# --- elevation: report it, never request it (Malwarebytes flagged self-elevation) ---
$admin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
         ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
Say ("Running elevated: " + $(if ($admin) { "yes" } else { "no -- not needed for this" }))

# --- preconditions, each with a plain answer if it fails ---
if (-not (Test-Path -LiteralPath $live)) {
    Say ""
    Say "STOPPED. Checkup's log folder was not found:"
    Say "    $live"
    Say "That folder is created the first time Checkup runs on a PC."
    Say "If Checkup has never run on $machine, there is nothing to copy yet."
    $out | Out-File -FilePath (Join-Path $env:TEMP 'SyncLogs-failed.txt') -Encoding UTF8
    return
}
if (-not (Test-Path -LiteralPath $root)) {
    Say ""
    Say "STOPPED. The OneDrive project folder was not found:"
    Say "    $root"
    Say "This PC is either not signed in to the GatewayGuard LLC business"
    Say "OneDrive, or that folder is not set to sync. Open OneDrive from the"
    Say "taskbar, check it says 'GatewayGuard LLC', and that it is up to date."
    Say "Nothing was copied. Nothing was changed."
    $out | Out-File -FilePath (Join-Path $env:TEMP 'SyncLogs-failed.txt') -Encoding UTF8
    return
}
if (-not (Test-Path -LiteralPath $dest)) { New-Item -ItemType Directory -Path $dest -Force | Out-Null }

Say "From: $live"
Say "To:   $dest"
Say ""

# --- copy, skipping anything already present and byte-identical ---
$src = @(Get-ChildItem -LiteralPath $live -File -Recurse -EA SilentlyContinue)
Say ("Log files found: " + $src.Count)

$copied = 0; $same = 0; $renamed = 0
foreach ($f in $src) {
    $target = Join-Path $dest $f.Name
    if (Test-Path -LiteralPath $target) {
        $h1 = (Get-FileHash -LiteralPath $f.FullName -Algorithm SHA256).Hash
        $h2 = (Get-FileHash -LiteralPath $target     -Algorithm SHA256).Hash
        if ($h1 -eq $h2) { $same++; continue }
        # Same name, different content -- keep both rather than overwrite.
        $target = Join-Path $dest ($f.BaseName + '-' + $f.LastWriteTime.ToString('yyyyMMdd-HHmmss') + $f.Extension)
        $renamed++
    }
    Copy-Item -LiteralPath $f.FullName -Destination $target -Force
    $a = (Get-FileHash -LiteralPath $f.FullName -Algorithm SHA256).Hash
    $b = (Get-FileHash -LiteralPath $target     -Algorithm SHA256).Hash
    if ($a -ne $b) { throw "ABORT: copy did not verify for $($f.Name). Nothing was deleted -- the original is untouched." }
    $copied++
    Say ("  copied  " + $f.Name)
}

Say ""
Say "Copied and verified: $copied"
Say "Already there:       $same"
if ($renamed -gt 0) { Say "Kept under a new name (same name, different content): $renamed" }
Say ""
Say "Nothing was removed from $live. Checkup's own copies are untouched."
Say "Total now in ${dest}: $((Get-ChildItem -LiteralPath $dest -File | Measure-Object).Count) files"

$out | Out-File -FilePath $report -Encoding UTF8
Write-Output ""
Write-Output "Report written to: $report"
