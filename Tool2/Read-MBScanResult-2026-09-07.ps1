# =====================================================================
#  Read-MBScanResult-2026-09-07.ps1
#
#  READS WHAT MALWAREBYTES FOUND, from its own result file.
#
#  READ-ONLY. It opens one JSON file that Malwarebytes wrote and prints
#  what is in it. It changes nothing, scans nothing and deletes nothing.
#
#  Malwarebytes Free has no command line, so the scan itself is run in
#  its window. It records every scan as JSON under
#  C:\ProgramData\Malwarebytes\MBAMService\ScanResults\ -- one file per
#  scan, named with a GUID. This reads the newest one.
#
#  The file starts with a 64-character hash line before the JSON, so the
#  text is taken from the first { onward.
#
#  Structure, measured 2026-09-07 on CGDELL against the 2026-07-19 file:
#    threats[]                  one entry per detection
#      threatName               "PUP.Optional.Wave" and the like
#      mainTrace.objectPath     the file it found
#      mainTrace.objectSha256   its hash -- how we match our specimens
#      mainTrace.cleanAction    what the user chose
# =====================================================================

param(
    [string]$ResultsDir = "C:\ProgramData\Malwarebytes\MBAMService\ScanResults",
    [string]$MatchFolder = "C:\AVTestKit\07_pua",
    [int]   $Newest = 1
)

$ErrorActionPreference = "Continue"

$ggStamp  = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ggRoot   = Split-Path $PSScriptRoot -Parent
$ggOutDir = Join-Path $ggRoot "Test_Results"
if (-not (Test-Path $ggOutDir)) { New-Item -ItemType Directory -Path $ggOutDir -Force | Out-Null }
$ggOut = Join-Path $ggOutDir "MBScanResult-$env:COMPUTERNAME-$ggStamp.txt"

$ggLines = New-Object System.Collections.ArrayList
function Add-Line { param([string]$T = "") ; $null = $ggLines.Add($T) ; Write-Host $T }

Add-Line "======================================================================"
Add-Line "  WHAT MALWAREBYTES FOUND -- read from its own scan record"
Add-Line "  $env:COMPUTERNAME   $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Add-Line "  READ-ONLY -- nothing is scanned, changed or removed."
Add-Line "======================================================================"
Add-Line ""

if (-not (Test-Path -LiteralPath $ResultsDir)) {
    Add-Line "  Malwarebytes scan results folder not found:"
    Add-Line ("    {0}" -f $ResultsDir)
    Add-Line ""
    Add-Line "  Either Malwarebytes is not installed, or it has never run a scan."
    ($ggLines -join "`r`n") | Out-File -FilePath $ggOut -Encoding UTF8
    exit 1
}

$ggFiles = @(Get-ChildItem -LiteralPath $ResultsDir -Filter "*.json" -EA SilentlyContinue |
             Sort-Object LastWriteTime -Descending | Select-Object -First $Newest)

if ($ggFiles.Count -eq 0) {
    Add-Line "  No scan records in that folder yet. Run a scan first."
    ($ggLines -join "`r`n") | Out-File -FilePath $ggOut -Encoding UTF8
    exit 1
}

foreach ($f in $ggFiles) {
    Add-Line "----------------------------------------------------------------------"
    Add-Line ("  SCAN RECORD  {0}" -f $f.Name)
    Add-Line ("  written      {0}" -f $f.LastWriteTime)
    Add-Line "----------------------------------------------------------------------"

    $raw = ""
    try { $raw = Get-Content -LiteralPath $f.FullName -Raw -EA Stop } catch {
        Add-Line ("  Could not read it: {0}" -f $_.Exception.Message) ; continue
    }
    $brace = $raw.IndexOf("{")
    if ($brace -lt 0) { Add-Line "  No JSON in this file." ; continue }

    $j = $null
    try { $j = $raw.Substring($brace) | ConvertFrom-Json -EA Stop } catch {
        Add-Line ("  Could not parse it: {0}" -f $_.Exception.Message) ; continue
    }

    Add-Line ""
    Add-Line ("  Malwarebytes version : {0}" -f $j.applicationVersion)
    Add-Line ("  Licence state        : {0}" -f $j.licenseState)
    Add-Line ("  Database version     : {0}" -f $j.rulesVersion)
    Add-Line ("  Detection date/time  : {0}" -f $j.detectionDateTime)
    if ($j.sourceDetails) {
        Add-Line ("  Objects scanned      : {0:N0}" -f [int]$j.sourceDetails.objectsScanned)
        Add-Line ("  Scan ended           : {0}" -f $j.sourceDetails.scanEndTime)
        if ($j.sourceDetails.scanOptions) {
            $ggWhat = @($j.sourceDetails.scanOptions.filesToScan)
            Add-Line ("  Told to scan         : {0}" -f (($ggWhat) -join ", "))
            Add-Line ("  PUP handling         : {0}" -f $j.sourceDetails.scanOptions.pupHandling)
            Add-Line ("  PUM handling         : {0}" -f $j.sourceDetails.scanOptions.pumHandling)
            Add-Line ("  Scan inside archives : {0}" -f $j.sourceDetails.scanOptions.scanArchives)
        }
    }
    Add-Line ""

    $ggThreats = @($j.threats)
    Add-Line ("  DETECTIONS IN THIS SCAN: {0}" -f $ggThreats.Count)
    Add-Line ""

    if ($ggThreats.Count -eq 0) { Add-Line "  Malwarebytes reported nothing." ; Add-Line "" ; continue }

    # --- the ones inside our test folder, which is the actual answer ---
    $ggMine = @($ggThreats | Where-Object {
                  $_.mainTrace -and $_.mainTrace.objectPath -and
                  $_.mainTrace.objectPath.ToUpper().StartsWith($MatchFolder.ToUpper()) })

    Add-Line ("  IN THE TEST FOLDER ({0}): {1}" -f $MatchFolder, $ggMine.Count)
    Add-Line ""
    foreach ($t in $ggMine) {
        Add-Line ("    {0}" -f $t.mainTrace.objectPath)
        Add-Line ("       Malwarebytes calls it : {0}" -f $t.threatName)
        Add-Line ("       SHA-256               : {0}" -f $t.mainTrace.objectSha256)
        Add-Line ("       size                  : {0:N0} bytes" -f [long]$t.mainTrace.objectSize)
        # NOT "action taken". Measured 2026-09-08: cleanAction read
        # "quarantine" for all six while the text report said "No Action
        # By User" and all six files were still on disk. It is what
        # Malwarebytes WOULD do, not what it did.
        Add-Line ("       it would         : {0}" -f $t.mainTrace.cleanAction)
        if ($t.mainTrace.archiveMember) {
            Add-Line ("       inside the archive    : {0}" -f $t.mainTrace.archiveMember)
        }
        Add-Line ""
    }

    if ($ggMine.Count -eq 0) {
        Add-Line "    Nothing in the test folder was reported."
        Add-Line ""
        Add-Line "    Check the scan was actually pointed at that folder -- the"
        Add-Line "    'Told to scan' line above says what it was given."
        Add-Line ""
    }

    # --- everything else, summarised, so it is not mistaken for our result ---
    $ggOther = @($ggThreats | Where-Object { $ggMine -notcontains $_ })
    if ($ggOther.Count -gt 0) {
        Add-Line ("  ELSEWHERE ON THE MACHINE: {0} detection(s), by name:" -f $ggOther.Count)
        foreach ($g in ($ggOther | Group-Object threatName | Sort-Object Count -Descending)) {
            Add-Line ("    {0,5}  {1}" -f $g.Count, $g.Name)
        }
        Add-Line ""
        Add-Line "  These are not part of the test. They are listed so the count"
        Add-Line "  above is not read as our six."
        Add-Line ""
    }
}

Add-Line "======================================================================"
Add-Line ("  Saved to: {0}" -f $ggOut)
Add-Line "======================================================================"

($ggLines -join "`r`n") | Out-File -FilePath $ggOut -Encoding UTF8
