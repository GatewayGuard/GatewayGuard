# =====================================================================
# FILE:    Check-FullScanCoverage-2026-08-27.ps1
# PURPOSE: Find the Defender full-scan evidence and answer ONE question --
#          did the full scan actually cover the D: drive?
#
#          This is the gate-24 prerequisite for F4. Until it is answered
#          with measured evidence, no Checkup screen may claim coverage of
#          any drive but C:.
#
# READ-ONLY. It reads three sources and writes one report into
# Test_Results\. It changes nothing, scans nothing, and starts nothing.
#
# NEEDS ADMINISTRATOR to read the MPLog folder. It does NOT self-elevate
# (the Malwarebytes exploit-payload flag stands). It reports what it could
# not read rather than failing silently.
# =====================================================================

$ErrorActionPreference = 'Continue'

$machine = $env:COMPUTERNAME
$stamp   = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$outDir  = Join-Path (Split-Path $PSScriptRoot -Parent) 'Test_Results'
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force | Out-Null }
$outFile = Join-Path $outDir "FullScanCoverage-$machine-$stamp.txt"

$out = New-Object System.Collections.Generic.List[string]
function W([string]$s) { $out.Add($s); Write-Host $s }

$elevated = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

W ("=" * 70)
W "  DEFENDER FULL SCAN -- DID IT COVER D: ?"
W ("=" * 70)
W ("  machine   : " + $machine)
W ("  run at    : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
W ("  elevated  : " + $elevated)
if (-not $elevated) {
    W ""
    W "  NOT ELEVATED. The MPLog folder will not be readable, and that is"
    W "  the section that answers the question. Close this and use the"
    W "  right-click 'Run as administrator' option on the .bat."
}
W ""

# ---------------------------------------------------------------------
# 1. The drives that exist, so 'D: not found' can be told from
#    'D: not scanned'.
# ---------------------------------------------------------------------
W ("-" * 70)
W "  1. WHAT DRIVES ARE ON THIS MACHINE"
W ("-" * 70)
try {
    Get-Volume -EA Stop |
        Where-Object { $_.DriveLetter } |
        Sort-Object DriveLetter |
        ForEach-Object {
            W ("    {0}:  {1,-12} {2,8:N1} GB total  {3,8:N1} GB free  [{4}]" -f `
                $_.DriveLetter, $_.FileSystemLabel, `
                ($_.Size/1GB), ($_.SizeRemaining/1GB), $_.DriveType)
        }
} catch { W ("    could not read volumes: " + $_.Exception.Message) }
W ""

# ---------------------------------------------------------------------
# 2. Defender's own record of the last full scan.
# ---------------------------------------------------------------------
W ("-" * 70)
W "  2. DEFENDER'S RECORD OF THE LAST FULL SCAN"
W ("-" * 70)
try {
    $st = Get-MpComputerStatus -EA Stop
    W ("    FullScanStartTime   : " + $(if ($st.FullScanStartTime) { $st.FullScanStartTime } else { '<never recorded>' }))
    W ("    FullScanEndTime     : " + $(if ($st.FullScanEndTime)   { $st.FullScanEndTime }   else { '<never recorded>' }))
    if ($st.FullScanStartTime -and $st.FullScanEndTime) {
        $dur = $st.FullScanEndTime - $st.FullScanStartTime
        W ("    DURATION            : " + ("{0:hh\:mm\:ss}" -f $dur))
    }
    W ("    FullScanAge (days)  : " + $st.FullScanAge)
    W ("    QuickScanEndTime    : " + $st.QuickScanEndTime)
    W ("    AMRunningMode       : " + $st.AMRunningMode)
} catch { W ("    Get-MpComputerStatus failed: " + $_.Exception.Message) }
W ""

# ---------------------------------------------------------------------
# 3. Scan start / finish events. Bounded -- never an open-ended query.
# ---------------------------------------------------------------------
W ("-" * 70)
W "  3. SCAN EVENTS (1000 = started, 1001 = finished), newest 12"
W ("-" * 70)
try {
    $ev = Get-WinEvent -FilterHashtable @{
              LogName = 'Microsoft-Windows-Windows Defender/Operational'
              Id      = 1000, 1001
          } -MaxEvents 12 -EA Stop
    foreach ($e in $ev) {
        $type = if ($e.Message -match 'Scan Type:\s*(.+)')      { $Matches[1].Trim() } else { '?' }
        $parm = if ($e.Message -match 'Scan Parameters:\s*(.+)') { $Matches[1].Trim() } else { '' }
        W ("    {0}  id {1}  {2} {3}" -f $e.TimeCreated, $e.Id, $type, $parm)
    }
    if (-not $ev) { W "    no scan events found" }
} catch { W ("    could not read the Defender event log: " + $_.Exception.Message) }
W ""

# ---------------------------------------------------------------------
# 4. THE ANSWER. MPLog records the paths actually touched.
# ---------------------------------------------------------------------
W ("-" * 70)
W "  4. DID IT TOUCH D: ?  (from MPLog -- the paths actually scanned)"
W ("-" * 70)
$sup = Join-Path $env:ProgramData 'Microsoft\Windows Defender\Support'
if (-not (Test-Path $sup)) {
    W "    MPLog folder not found. Cannot answer."
} else {
    try {
        $log = Get-ChildItem $sup -Filter 'MPLog-*.log' -EA Stop |
               Sort-Object LastWriteTime -Descending | Select-Object -First 1
        if (-not $log) { W "    no MPLog-*.log present" }
        else {
            W ("    reading : " + $log.Name + "  (" + [math]::Round($log.Length/1MB,1) + " MB, last written " + $log.LastWriteTime + ")")
            W ""
            # Bounded on both sides: at most 400 matching lines per drive.
            foreach ($dl in @('C','D','E')) {
                $hits = Select-String -Path $log.FullName -Pattern ("\b" + $dl + ":\\") `
                            -SimpleMatch:$false -EA SilentlyContinue |
                        Select-Object -First 400
                $n = @($hits).Count
                $flag = if ($n -gt 0) { 'YES' } else { 'no ' }
                W ("    {0}:  {1}  -- {2} matching line(s){3}" -f $dl, $flag, $n, $(if ($n -ge 400) { ' (capped at 400 -- there are more)' } else { '' }))
                if ($n -gt 0) {
                    $hits | Select-Object -First 3 | ForEach-Object {
                        $line = ($_.Line -replace '\s+', ' ').Trim()
                        if ($line.Length -gt 150) { $line = $line.Substring(0,150) + '...' }
                        W ("           e.g. " + $line)
                    }
                }
            }
            W ""
            W "    NOTE ON READING THIS. A D: path in MPLog proves Defender"
            W "    TOUCHED that drive at some point in this log's lifetime. It"
            W "    does NOT by itself prove the FULL SCAN did it -- real-time"
            W "    protection writes here too. Compare the timestamps in"
            W "    section 2 against the log's own entries before concluding."
        }
    } catch {
        W ("    could not read MPLog: " + $_.Exception.Message)
        if (-not $elevated) { W "    -- almost certainly because this is not running as administrator." }
    }
}
W ""
W ("=" * 70)
W "  DONE -- nothing on this machine was changed."
W ("=" * 70)

$out | Set-Content -Path $outFile -Encoding UTF8
Write-Host ""
Write-Host ("  Report written to: " + $outFile)
