# =====================================================================
# FILE:    Check-ProtectionHistory-2026-08-28.ps1
# PURPOSE: Read Defender's Protection History to a FILE, instead of
#          reading it off the screen in the Security app.
#
#          Then answer the question that matters for F4: of the twelve
#          AVTestKit specimens, WHICH ONES WERE DETECTED, and on which
#          drive? A count of 11 does not say which one got away.
#
# READ-ONLY. Reads three sources and writes one report into
# Test_Results\. Changes nothing, scans nothing, quarantines nothing,
# and releases nothing from quarantine.
#
# NEEDS ADMINISTRATOR. Get-MpThreatDetection returns nothing useful
# without it. It does NOT self-elevate.
#
# TESTED: on CGDELL 2026-08-28, which has ZERO detections in its whole
# history -- so the "no detections" path is measured and the
# detection-parsing path is NOT. First real exercise is SANDY.
# =====================================================================

$ErrorActionPreference = 'Continue'

$machine = $env:COMPUTERNAME
$stamp   = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$outDir  = Join-Path (Split-Path $PSScriptRoot -Parent) 'Test_Results'
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force | Out-Null }
$outFile = Join-Path $outDir "ProtectionHistory-$machine-$stamp.txt"

$out = New-Object System.Collections.Generic.List[string]
function W([string]$s) { $out.Add($s); Write-Host $s }

$elevated = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

W ("=" * 70)
W "  DEFENDER PROTECTION HISTORY -- TO A FILE"
W ("=" * 70)
W ("  machine  : " + $machine)
W ("  run at   : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
W ("  elevated : " + $elevated)
if (-not $elevated) {
    W ""
    W "  NOT ELEVATED. Get-MpThreatDetection returns nothing useful this way."
    W "  Close this and use right-click 'Run as administrator' on the .bat."
}
W ""

# ---------------------------------------------------------------------
# 1. Every detection, newest first. This IS Protection History.
# ---------------------------------------------------------------------
W ("-" * 70)
W "  1. DETECTIONS  (Get-MpThreatDetection -- what Protection History shows)"
W ("-" * 70)

$paths = New-Object System.Collections.Generic.List[string]
try {
    $dets = @(Get-MpThreatDetection -EA Stop | Sort-Object InitialDetectionTime -Descending)
    W ("    total detection records : " + $dets.Count)
    W ""
    if ($dets.Count -eq 0) {
        W "    No detections recorded on this machine."
    }
    foreach ($d in $dets) {
        # Resources look like  file:_C:\path\to\thing  -- strip the prefix.
        $res = @($d.Resources) | ForEach-Object { ($_ -replace '^[a-z]+:_', '') }
        foreach ($r in $res) { if ($r) { $paths.Add($r) } }
        W ("    {0}  action-success={1}" -f $d.InitialDetectionTime, $d.ActionSuccess)
        foreach ($r in $res) { W ("        " + $r) }
    }
} catch {
    W ("    Get-MpThreatDetection failed: " + $_.Exception.Message)
    if (-not $elevated) { W "    -- almost certainly because this is not elevated." }
}
W ""

# ---------------------------------------------------------------------
# 2. Threat names.
# ---------------------------------------------------------------------
W ("-" * 70)
W "  2. THREAT NAMES  (Get-MpThreat)"
W ("-" * 70)
try {
    $thr = @(Get-MpThreat -EA Stop)
    if ($thr.Count -eq 0) { W "    none recorded" }
    foreach ($t in $thr) {
        W ("    {0,-45} severity={1} active={2}" -f $t.ThreatName, $t.SeverityID, $t.IsActive)
    }
} catch { W ("    Get-MpThreat failed: " + $_.Exception.Message) }
W ""

# ---------------------------------------------------------------------
# 3. Cross-check from the event log. Independent of the cmdlets.
# ---------------------------------------------------------------------
W ("-" * 70)
W "  3. CROSS-CHECK -- event log 1116 (detected) / 1117 (action taken)"
W ("-" * 70)
try {
    $ev = @(Get-WinEvent -FilterHashtable @{
                LogName = 'Microsoft-Windows-Windows Defender/Operational'
                Id      = 1116, 1117
            } -MaxEvents 60 -EA Stop)
    W ("    events found (cap 60) : " + $ev.Count)
    foreach ($e in $ev) {
        $p = if ($e.Message -match 'Path:\s*(.+)') { $Matches[1].Trim() } else { '' }
        $n = if ($e.Message -match 'Name:\s*(.+)') { $Matches[1].Trim() } else { '' }
        W ("    {0}  id {1}  {2}" -f $e.TimeCreated, $e.Id, $n)
        if ($p) { W ("        " + ($p -replace '^[a-z]+:_', '')) }
    }
} catch { W ("    no 1116/1117 events: " + $_.Exception.Message) }
W ""

# ---------------------------------------------------------------------
# 4. THE ANSWER FOR F4. Which of the twelve specimens were detected?
# ---------------------------------------------------------------------
W ("-" * 70)
W "  4. AVTESTKIT COVERAGE -- WHICH SPECIMENS WERE DETECTED?"
W ("-" * 70)

$placements = @(
    @{ k = '01_plain';   d = 'plain file, plain name';       leaf = '01_plain\specimen.txt' },
    @{ k = '02_renamed'; d = 'renamed extension (.dat)';     leaf = '02_renamed\invoice.dat' },
    @{ k = '03_deep';    d = 'deeply nested folder';         leaf = '03_deep\a\b\c\d\e\buried.txt' },
    @{ k = '04_hidden';  d = 'hidden + system attributes';   leaf = '04_hidden\systemfile.txt' },
    @{ k = '05_archive'; d = 'inside ZIP archive';           leaf = '05_archive\bundle.zip' },
    @{ k = '06_ads';     d = 'ADS (alternate data stream)';  leaf = '06_ads\readme.txt' }
)

$all = ($paths -join "`n")
$missing = New-Object System.Collections.Generic.List[string]

foreach ($drive in 'C', 'D') {
    W ""
    W ("    --- " + $drive + ": ---")
    foreach ($p in $placements) {
        $needle = $drive + ':\AVTestKit\' + $p.k
        $hit = $all -match [regex]::Escape($needle)
        $mark = if ($hit) { 'DETECTED' } else { 'not seen ' }
        W ("      {0}  {1,-30} {2}" -f $mark, $p.d, ($drive + ':\AVTestKit\' + $p.leaf))
        if (-not $hit) { $missing.Add($drive + ': ' + $p.d) }
    }
}

W ""
$found = 12 - $missing.Count
W ("    DETECTED: {0} of 12 placements." -f $found)
if ($missing.Count -gt 0) {
    W ""
    W "    NOT SEEN in Protection History:"
    foreach ($m in $missing) { W ("      - " + $m) }
    W ""
    W "    A placement 'not seen' means it does not appear in the detection"
    W "    records READ ABOVE. Three things can cause that, and they are not"
    W "    the same finding:"
    W "      (a) the scan genuinely did not detect it;"
    W "      (b) it was detected on an EARLIER run and already quarantined,"
    W "          so this run had nothing left to find;"
    W "      (c) the specimen was never written -- check the kit manifest."
    W "    Check the manifest and the detection timestamps before concluding."
}
W ""
W ("=" * 70)
W "  DONE -- nothing on this machine was changed."
W ("=" * 70)

$out | Set-Content -Path $outFile -Encoding UTF8
Write-Host ""
Write-Host ("  Report written to: " + $outFile)
