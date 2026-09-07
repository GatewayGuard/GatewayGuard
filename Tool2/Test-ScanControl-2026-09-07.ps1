# =====================================================================
#  Test-ScanControl-2026-09-07.ps1
#
#  THE CONTROL FOR THE PUA COMPARISON. Run it straight after
#  Test-PUAComparison-2026-09-07.ps1, and before the Malwarebytes scan.
#
#  WHY IT EXISTS. On 2026-09-07 Defender reported nothing at all on six
#  real PUP installers -- not on write, and not on a custom scan. That
#  result is worthless on its own, because two dull explanations produce
#  exactly the same output as a real miss:
#
#    1. The scan never actually looked at that folder.
#    2. The folder exclusion silenced the scan after all, despite
#       MpCmdRun's help saying -DisableRemediation ignores exclusions.
#
#  This kills both, using a specimen whose detection is GUARANTEED.
#
#  THE SPECIMEN IS EICAR -- a 68-byte text string the antivirus industry
#  has agreed since 1991 that every scanner must flag. It is NOT malware.
#  It contains no code and can do nothing. See https://www.eicar.org.
#  Because detection is guaranteed, a miss has only one explanation left:
#  the scan did not look. That is precisely what needs ruling out.
#
#  The string is assembled from fragments at runtime, the same way
#  Make-AVTestKit-2026-08-21.ps1 does it, so THIS FILE's own bytes never
#  contain the signature and no scanner will quarantine the script.
#
#  TWO CONTROLS:
#    A. Real-time, on write, in a folder that is NOT excluded.
#       Expect TAKEN. If EICAR survives here, real-time protection is
#       not working, and Phase 2 of the PUA test proved nothing.
#    B. On-demand custom scan of the EXCLUDED PUA folder, with the
#       identical command the PUA test used.
#       Expect FOUND. If EICAR is found inside the excluded folder, then
#       the scan looks AND the exclusion really is ignored -- so the six
#       PUP results were real verdicts.
#
#  It cleans up after itself: the EICAR files are removed and their
#  absence is verified, so the Malwarebytes scan that follows sees only
#  the six specimens.
#
#  Needs administrator (it reads Defender state and runs MpCmdRun).
#  Never elevates itself.
# =====================================================================

param(
    [string]$TestRoot = "C:\AVTestKit",
    [int]   $WaitSeconds = 20
)

$ErrorActionPreference = "Continue"
$ProgressPreference    = "SilentlyContinue"

$ggProtected = Join-Path $TestRoot "07_pua"
$ggCtlRtp    = Join-Path $TestRoot "07_ctl_rtp"

# -- assemble the EICAR test string from fragments (see header) --------
# None of these fragments is the signature; only the join is, and the
# join happens in memory, never in this file's bytes.
$f1 = 'X5O!P%@AP[4\P'
$f2 = 'ZX54(P^)7CC)7'
$br = [char]0x7D
$f3 = '$EICAR-STANDARD-ANTIVIRUS-'
$f4 = 'TEST-FILE!$H+H*'
$EICAR = $f1 + $f2 + $br + $f3 + $f4

$ggStamp  = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ggRoot   = Split-Path $PSScriptRoot -Parent
$ggOutDir = Join-Path $ggRoot "Test_Results"
if (-not (Test-Path $ggOutDir)) { New-Item -ItemType Directory -Path $ggOutDir -Force | Out-Null }
$ggOut = Join-Path $ggOutDir "ScanControl-$env:COMPUTERNAME-$ggStamp.txt"

$ggLines = New-Object System.Collections.ArrayList
function Add-Line { param([string]$T = "") ; $null = $ggLines.Add($T) ; Write-Host $T }
function Save-Now { ($ggLines -join "`r`n") | Out-File -FilePath $ggOut -Encoding UTF8 }

Add-Line "======================================================================"
Add-Line "  SCAN CONTROL -- was Defender actually looking?"
Add-Line "  $env:COMPUTERNAME   $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Add-Line "======================================================================"
Add-Line ""
Add-Line "  Specimen: the EICAR test string. 68 bytes of text, no code, not"
Add-Line "  malware. Every scanner is built to flag it. A miss here can only"
Add-Line "  mean the scan did not look."
Add-Line ""

$ggId   = [Security.Principal.WindowsIdentity]::GetCurrent()
$ggElev = (New-Object Security.Principal.WindowsPrincipal($ggId)).IsInRole(
            [Security.Principal.WindowsBuiltInRole]::Administrator)
Add-Line ("  Administrator: {0}" -f $ggElev)
if (-not $ggElev) {
    Add-Line ""
    Add-Line "  STOPPED. Right-click Run-ScanControl.bat and choose"
    Add-Line "  'Run as administrator'."
    Save-Now ; exit 1
}

$ggPref = Get-MpPreference
$ggStat = Get-MpComputerStatus
Add-Line ("  Real-time protection : {0}" -f $ggStat.RealTimeProtectionEnabled)
Add-Line ("  PUA protection       : {0}" -f $ggPref.PUAProtection)
$ggEx = @($ggPref.ExclusionPath | Where-Object { $_ })
Add-Line ("  Exclusions in force  : {0}" -f $(if ($ggEx.Count -eq 0) { "none" } else { $ggEx -join " | " }))
Add-Line ""

# =====================================================================
#  CONTROL A -- real-time protection, on write, NOT excluded
# =====================================================================
Add-Line "----------------------------------------------------------------------"
Add-Line "  CONTROL A -- REAL-TIME PROTECTION, ON WRITE"
Add-Line "----------------------------------------------------------------------"
Add-Line ""
Add-Line ("  Folder (NOT excluded): {0}" -f $ggCtlRtp)
Add-Line "  Expect TAKEN. If it survives, real-time protection is not working"
Add-Line "  and the PUA write test proved nothing."
Add-Line ""

if (-not (Test-Path -LiteralPath $ggCtlRtp)) { New-Item -ItemType Directory -Path $ggCtlRtp -Force | Out-Null }
$ggCtlFile = Join-Path $ggCtlRtp "control.txt"
$ggT0 = Get-Date
try { [IO.File]::WriteAllText($ggCtlFile, $EICAR) } catch {
    Add-Line ("  The write itself was blocked: {0}" -f $_.Exception.Message)
    Add-Line "  That is real-time protection acting at write time. Counts as TAKEN."
}
Start-Sleep -Seconds $WaitSeconds

$ggASurvived = Test-Path -LiteralPath $ggCtlFile
if ($ggASurvived) {
    Add-Line "  RESULT: KEPT."
    Add-Line "  Defender real-time did NOT take a file it is guaranteed to detect."
    Add-Line "  Real-time protection is not doing its job on this machine, and"
    Add-Line "  the PUA write-test result cannot be trusted."
} else {
    Add-Line "  RESULT: TAKEN."
    Add-Line "  Real-time protection works. So when it left all six PUPs alone,"
    Add-Line "  that was a decision, not a failure."
}
Add-Line ""

$ggNew = @(Get-MpThreat -EA SilentlyContinue | Where-Object { $_.InitialDetectionTime -ge $ggT0 })
if ($ggNew.Count -gt 0) {
    Add-Line "  Defender named it:"
    foreach ($t in $ggNew) { Add-Line ("    {0}   ({1})" -f $t.ThreatName, $t.InitialDetectionTime) }
} else {
    Add-Line "  Defender logged no new threat record for this."
}
Add-Line ""
Save-Now

# =====================================================================
#  CONTROL B -- the same scan command, on the EXCLUDED folder
# =====================================================================
Add-Line "----------------------------------------------------------------------"
Add-Line "  CONTROL B -- THE ON-DEMAND SCAN, INSIDE THE EXCLUDED FOLDER"
Add-Line "----------------------------------------------------------------------"
Add-Line ""

if (-not (Test-Path -LiteralPath $ggProtected)) {
    Add-Line ("  {0} does not exist. Run Run-PUAComparison.bat first." -f $ggProtected)
    Save-Now ; exit 1
}

$ggCtlB = Join-Path $ggProtected "control.txt"
try { [IO.File]::WriteAllText($ggCtlB, $EICAR) } catch {
    Add-Line ("  Could not write the control file: {0}" -f $_.Exception.Message)
}
if (-not (Test-Path -LiteralPath $ggCtlB)) {
    Add-Line "  The control file did not survive being written into the EXCLUDED"
    Add-Line "  folder. That would mean the exclusion is not in force at all."
    Save-Now ; exit 1
}
Add-Line ("  Control file written into the excluded folder: {0}" -f $ggCtlB)
Add-Line ""

# VERIFIED 2026-09-07 measured on CGDELL from MpCmdRun.exe -h. This is
# character-for-character the command Test-PUAComparison used on the six
# specimens, so the two results are comparable.
$ggMpCmd = Join-Path $env:ProgramFiles "Windows Defender\MpCmdRun.exe"
Add-Line "  Running the identical command the PUA test ran:"
Add-Line ("    MpCmdRun.exe -Scan -ScanType 3 -File `"{0}`" -DisableRemediation" -f $ggProtected)
Add-Line ""

$ggScanOut = & $ggMpCmd -Scan -ScanType 3 -File $ggProtected -DisableRemediation 2>&1
$ggRc = $LASTEXITCODE

Add-Line ("  Exit code {0}." -f $ggRc)
Add-Line "  --- MpCmdRun output, verbatim ---"
foreach ($l in $ggScanOut) { $t = "$l" ; if ($t.Trim() -ne "") { Add-Line ("  | {0}" -f $t) } }
Add-Line "  --- end of output ---"
Add-Line ""

$ggText = ($ggScanOut | ForEach-Object { "$_" }) -join " "
$ggFound = ($ggText -match "EICAR") -or ($ggRc -eq 2) -or ($ggText -match "found [1-9]")

if ($ggFound) {
    Add-Line "  RESULT: FOUND."
    Add-Line ""
    Add-Line "  Both dull explanations are dead:"
    Add-Line "    - the scan DOES look at this folder, and"
    Add-Line "    - -DisableRemediation really does ignore the exclusion."
    Add-Line ""
    Add-Line "  So Defender's 'no threats' on the six PUP installers was a real"
    Add-Line "  verdict. It looked at them and did not object."
} else {
    Add-Line "  RESULT: NOT FOUND."
    Add-Line ""
    Add-Line "  The scan missed a file every scanner is built to detect. So the"
    Add-Line "  scan was NOT looking properly, and the six PUP results say"
    Add-Line "  nothing about Defender. Most likely the exclusion is silencing"
    Add-Line "  it after all."
    Add-Line ""
    Add-Line "  NEXT: remove the exclusion with Run-PUATestCleanup.bat, re-stage"
    Add-Line "  with real-time protection turned off by hand, and scan again."
}
Add-Line ""

# ---- clean the control files away ------------------------------------
Add-Line "  CLEANUP"
Remove-Item -LiteralPath $ggCtlB -Force -EA SilentlyContinue
if (Test-Path -LiteralPath $ggCtlB) {
    Add-Line ("    STILL THERE: {0}" -f $ggCtlB)
    Add-Line  "    Remove it before the Malwarebytes scan or it will show up"
    Add-Line  "    in the results and confuse the comparison."
} else {
    Add-Line "    control file removed from the PUA folder -- Malwarebytes will"
    Add-Line "    see only the six specimens."
}
Remove-Item -LiteralPath $ggCtlRtp -Recurse -Force -EA SilentlyContinue
if (Test-Path -LiteralPath $ggCtlRtp) { Add-Line ("    STILL THERE: {0}" -f $ggCtlRtp) }
else { Add-Line "    control folder removed." }

$ggLeft = @(Get-ChildItem -LiteralPath $ggProtected -File -Force -EA SilentlyContinue)
Add-Line ""
Add-Line ("  Files now in the PUA folder: {0}" -f $ggLeft.Count)
foreach ($f in $ggLeft) { Add-Line ("    {0}" -f $f.Name) }
Add-Line ""
Add-Line "======================================================================"
Add-Line ("  Saved to: {0}" -f $ggOut)
Add-Line "======================================================================"
Save-Now
