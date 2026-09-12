# =====================================================================
#  Test-PUAComparison-2026-09-07.ps1
#
#  DEFENDER vs MALWAREBYTES, ON SIX REAL PUP SPECIMENS.
#
#  THIS SCRIPT IS NOT READ-ONLY. It does three things that change the
#  machine, and every one of them is undone by Run-PUATestCleanup.bat:
#
#    1. Adds a Microsoft Defender folder EXCLUSION for the test folder.
#    2. Copies six known PUP installers into that folder.
#    3. Copies the same six into a SECOND folder that is NOT excluded,
#       to see what Defender real-time protection does on write.
#
#  NOTHING IS EVER EXECUTED. These are installers. Running one installs
#  the thing. There is no Start-Process, no Invoke-Item, no & on any
#  specimen anywhere in this file. The scanners are pointed at the
#  folder; the files are only ever read.
#
#  THE SPECIMENS ARE THE REAL ARTICLE, not EICAR. They are the six
#  distinct files Malwarebytes flagged on SANDY on 2026-07-19, recovered
#  from the E: and G: backup drives on 2026-09-06 and confirmed by
#  SHA-256. The originals stay on those drives untouched, so anything a
#  scanner removes here can be re-staged by running this again.
#
#  WHY AN EXCLUSION, AND WHY IT DOES NOT SPOIL THE DEFENDER RESULT.
#  Real-time protection would remove the specimens before Malwarebytes
#  ever saw them, and then the comparison measures nothing. The
#  exclusion stops that. It does NOT blind the Defender scan, because
#  MpCmdRun's own help says of -DisableRemediation: "File exclusions are
#  ignored." So the on-demand scan still looks, still opens the archive,
#  and reports without acting.
#
#  UNDO: Tool2\Run-PUATestCleanup.bat -- removes both folders and the
#  exclusion, and verifies both are gone.
# =====================================================================

param(
    [string]$TestRoot    = "C:\AVTestKit",
    [switch]$SkipWriteTest,
    [switch]$NoExclusion,
    [int]   $WriteTestWaitSeconds = 25
)

# -NoExclusion stages the six specimens with NOTHING holding Defender
# back -- no folder exclusion at all. That is the honest picture of what
# happens to a home machine when these files land on it. The originals on
# G: are untouched, so if Defender takes the copies, nothing is lost and
# the test can simply be run again.
if ($NoExclusion) { $SkipWriteTest = $true }   # the whole run IS the write test

$ErrorActionPreference = "Continue"
$ProgressPreference    = "SilentlyContinue"

$ggProtected = Join-Path $TestRoot "07_pua"
$ggWriteDir  = Join-Path $TestRoot "07_pua_rtp"

# ---- the six specimens -----------------------------------------------
# Source paths measured 2026-09-06 by Find-PUASamples-2026-09-06.ps1;
# full list in Test_Results\PUASampleSearch-CGDELL-2026-09-06_16-42.txt
#
# EACH SPECIMEN CARRIES SEVERAL SOURCES, and the first reachable one whose
# SHA-256 matches is used. The backup drives come and go -- one dropped off
# mid-run on 2026-09-07 -- and one list of single paths turns that into a
# dead stop when a second copy was sitting right there.
#
# G: IS THE DRIVE THAT MATTERS. Five of the six exist only on G:. E: holds
# nothing but extra copies of clientsetup_d-0.exe.
$ggSpec = @(
  @{ Name = "clientsetup_d-0.exe"
     MB   = "PUP.Optional.DllFilesFixer"
     Sha  = "6B1A9C62C1C0E084EA30BD9CBE991FE859938FEA3A67378CB0ABF400AC264816"
     Src  = @("G:\May-2023\Documents - Copy\LOANS\Downloads\clientsetup_d-0.exe",
              "G:\OLD_PC\Documents - Copy\LOANS\Downloads\clientsetup_d-0.exe",
              "E:\Users\willi\Downloads\clientsetup_d-0.exe",
              "E:\Users\willi\Documents\LOANS\Downloads\clientsetup_d-0.exe") }

  @{ Name = "claimid800393432willianf_burnsiii.zip"
     MB   = "PUP.Optional.DllFilesFixer"
     Sha  = "729D0208A13395F818FF20BFC1B14B0CE918F1744FBA8D36E132253E1B18F341"
     Src  = @("G:\May-2023\Documents - Copy\VA LOAN\Downloads\claimid800393432willianf_burnsiii.zip",
              "G:\OLD_PC\Documents - Copy\VA LOAN\Downloads\claimid800393432willianf_burnsiii.zip") }

  @{ Name = "Wave Browser.exe"
     MB   = "PUP.Optional.Wave"
     Sha  = "81B9CC993AD57F3D16146842665B8C82A2C29D7E571F38CF14A4AB2B24148ECB"
     Src  = @("G:\May-2023\Downloads\Wave Browser.exe",
              "G:\May-2023\Downloads\Wave Browser (1).exe") }

  @{ Name = "Wave Browser (2).exe"
     MB   = "PUP.Optional.Wave"
     Sha  = "216D4BCEA4BBE226F0C610C59B911CF9351FEA34178A1F8EC04DAD99F4F1BDBC"
     Src  = @("G:\May-2023\Downloads\Wave Browser (2).exe") }

  @{ Name = "TotalAV.exe"
     MB   = "PUP.Optional.TotalAV"
     Sha  = "3B0CACDA195CD3F1A50EE5C9842E14753E92A4E63DE75AD7C15BAA16C0A8A688"
     Src  = @("G:\May-2023\Downloads\TotalAV.exe") }

  @{ Name = "ZoomInfoContactContributor.exe"
     MB   = "PUP.Optional.ZoomInfo"
     Sha  = "71DE08D14B90196B02293DDCA105DC367837280BEE2224815E35FF7F17363C48"
     Src  = @("G:\May-2023\Downloads\ZoomInfoContactContributor.exe") }
)

# Pick the first source that is actually there. Returns "" if none is.
function Get-GGSource {
    param($Spec)
    foreach ($p in $Spec.Src) { if (Test-Path -LiteralPath $p) { return $p } }
    return ""
}

# ---- output ----------------------------------------------------------
$ggStamp  = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ggRoot   = Split-Path $PSScriptRoot -Parent
$ggOutDir = Join-Path $ggRoot "Test_Results"
if (-not (Test-Path $ggOutDir)) { New-Item -ItemType Directory -Path $ggOutDir -Force | Out-Null }
$ggOut = Join-Path $ggOutDir "PUAComparison-$env:COMPUTERNAME-$ggStamp.txt"

$ggLines = New-Object System.Collections.ArrayList
function Add-Line { param([string]$T = "") ; $null = $ggLines.Add($T) ; Write-Host $T }
function Save-Now { ($ggLines -join "`r`n") | Out-File -FilePath $ggOut -Encoding UTF8 }

Add-Line "======================================================================"
Add-Line "  DEFENDER vs MALWAREBYTES -- SIX REAL PUP SPECIMENS"
Add-Line "  $env:COMPUTERNAME   $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Add-Line "======================================================================"
Add-Line ""
Add-Line "  Nothing is executed. The specimens are read, never run."
Add-Line "  Undo everything: Run-PUATestCleanup.bat"
Add-Line ""

# ---- elevation -------------------------------------------------------
$ggId   = [Security.Principal.WindowsIdentity]::GetCurrent()
$ggElev = (New-Object Security.Principal.WindowsPrincipal($ggId)).IsInRole(
            [Security.Principal.WindowsBuiltInRole]::Administrator)
Add-Line "  Running as   : $($ggId.Name)"
Add-Line "  Administrator: $ggElev"
Add-Line ""
if (-not $ggElev) {
    Add-Line "  STOPPED. Adding a Defender exclusion needs administrator rights."
    Add-Line "  Close this window, right-click Run-PUAComparison.bat and choose"
    Add-Line "  'Run as administrator', then run it again."
    Add-Line ""
    Add-Line "  This script never elevates itself, on purpose."
    Save-Now
    exit 1
}

# =====================================================================
#  BEFORE -- what the machine looked like when we started
# =====================================================================
Add-Line "----------------------------------------------------------------------"
Add-Line "  BEFORE STATE"
Add-Line "----------------------------------------------------------------------"
$ggStatus = Get-MpComputerStatus
$ggPref   = Get-MpPreference
Add-Line ("  Defender real-time protection : {0}" -f $ggStatus.RealTimeProtectionEnabled)
Add-Line ("  Defender running mode         : {0}" -f $ggStatus.AMRunningMode)
Add-Line ("  Signature version             : {0}" -f $ggStatus.AntivirusSignatureVersion)
Add-Line ("  Signatures last updated       : {0}" -f $ggStatus.AntivirusSignatureLastUpdated)
Add-Line ("  PUA protection (PUAProtection): {0}   (0=off 1=block 2=audit)" -f $ggPref.PUAProtection)
# @($null) has Count 1 in PowerShell, so an empty exclusion list printed a
# blank line that read like a nameless exclusion. Filter the nulls out.
$ggExBefore = @($ggPref.ExclusionPath | Where-Object { $_ })
if ($ggExBefore.Count -eq 0) { Add-Line "  Existing folder exclusions    : none" }
else { foreach ($e in $ggExBefore) { Add-Line ("  Existing folder exclusion     : {0}" -f $e) } }

$ggMbExe = "C:\Program Files\Malwarebytes\Anti-Malware\Malwarebytes.exe"
if (Test-Path -LiteralPath $ggMbExe) {
    Add-Line ("  Malwarebytes version          : {0}" -f (Get-Item -LiteralPath $ggMbExe).VersionInfo.ProductVersion)
} else { Add-Line "  Malwarebytes                  : NOT INSTALLED at the usual path" }
$ggMbSvc = Get-Service -Name "MBAMService" -EA SilentlyContinue
if ($ggMbSvc) { Add-Line ("  Malwarebytes service          : {0}" -f $ggMbSvc.Status) }
else          { Add-Line  "  Malwarebytes service          : not found" }
Add-Line ""

# ---- which backup drives are actually here right now ------------------
Add-Line "  Backup drives:"
foreach ($d in @("G:", "E:")) {
    $here = Test-Path -LiteralPath ($d + "\")
    $note = if ($d -eq "G:") { "holds five of the six specimens -- REQUIRED" }
            else { "holds extra copies of one specimen only -- optional" }
    Add-Line ("    {0}  {1,-12}  {2}" -f $d, $(if ($here) { "ATTACHED" } else { "NOT HERE" }), $note)
}
Add-Line ""

# ---- confirm every specimen has a reachable source --------------------
Add-Line "  Specimen sources (first reachable copy of each):"
$ggMissing = 0
foreach ($s in $ggSpec) {
    $src = Get-GGSource $s
    if ($src -ne "") { Add-Line ("    OK      {0}" -f $src) }
    else {
        Add-Line ("    MISSING {0}" -f $s.Name)
        foreach ($p in $s.Src) { Add-Line ("            looked at: {0}" -f $p) }
        $ggMissing++
    }
}
Add-Line ""
if ($ggMissing -gt 0) {
    Add-Line "  STOPPED. $ggMissing of $($ggSpec.Count) specimen(s) have no reachable copy."
    Add-Line ""
    Add-Line "  NOTHING HAS BEEN CHANGED. No exclusion was added and no file was"
    Add-Line "  copied -- this check runs before either of those."
    Add-Line ""
    Add-Line "  Plug the G: backup drive back in and run this again. G: is the"
    Add-Line "  one that matters; E: only carries duplicates."
    Save-Now
    exit 1
}

# =====================================================================
#  PHASE 1 -- exclusion FIRST, then stage the protected set
# =====================================================================
Add-Line "----------------------------------------------------------------------"
Add-Line "  PHASE 1 -- EXCLUSION, THEN STAGE"
Add-Line "----------------------------------------------------------------------"
Add-Line ""
Add-Line "  The exclusion goes on BEFORE any file is copied. The other order"
Add-Line "  loses the specimens to real-time protection on the way in."
Add-Line ""

if (-not (Test-Path -LiteralPath $ggProtected)) {
    New-Item -ItemType Directory -Path $ggProtected -Force | Out-Null
}
Add-Line ("  Test folder : {0}" -f $ggProtected)

if ($NoExclusion) {
    Add-Line "  Exclusion   : NONE -- deliberately. Defender is not being held"
    Add-Line "                back at all. If it wants these files, it takes them."
    $ggStillOn = @((Get-MpPreference).ExclusionPath | Where-Object { $_ -eq $ggProtected })
    if ($ggStillOn.Count -gt 0) {
        Add-Line ""
        Add-Line "  STOPPED. An exclusion for this folder is STILL in force, so the"
        Add-Line "  run would not test what it claims to. Run Run-PUATestCleanup.bat"
        Add-Line "  first. Nothing has been staged."
        Save-Now
        exit 1
    }
} else {
    Add-MpPreference -ExclusionPath $ggProtected -EA SilentlyContinue

    # Read it back. If it did not register we stop, before copying anything.
    $ggNow = @((Get-MpPreference).ExclusionPath)
    if ($ggNow -contains $ggProtected) {
        Add-Line "  Exclusion   : REGISTERED and read back from Defender."
    } else {
        Add-Line "  Exclusion   : DID NOT REGISTER."
        Add-Line ""
        Add-Line "  STOPPED before copying anything. Tamper Protection can block"
        Add-Line "  this. Nothing has been staged, so nothing is at risk."
        Save-Now
        exit 1
    }
}
Add-Line ""

$ggStaged = 0
foreach ($s in $ggSpec) {
    $dest = Join-Path $ggProtected $s.Name
    $src  = Get-GGSource $s
    if ($src -eq "") { Add-Line ("  FAILED  {0}  -- source vanished mid-run" -f $s.Name) ; continue }
    Copy-Item -LiteralPath $src -Destination $dest -Force -EA SilentlyContinue
    if (-not (Test-Path -LiteralPath $dest)) {
        Add-Line ("  FAILED  {0}  -- copy did not land" -f $s.Name)
        continue
    }
    $h = ""
    try { $h = (Get-FileHash -LiteralPath $dest -Algorithm SHA256 -EA Stop).Hash.ToUpper() } catch { $h = "UNREADABLE" }
    if ($h -eq $s.Sha) {
        Add-Line ("  STAGED  {0}" -f $s.Name)
        Add-Line ("          SHA-256 verified -- this is the file Malwarebytes flagged")
        $ggStaged++
    } else {
        Add-Line ("  WRONG   {0}  -- hash {1} does not match the scan report" -f $s.Name, $h)
    }
}
Add-Line ""
Add-Line ("  Staged and verified: {0} of {1}" -f $ggStaged, $ggSpec.Count)
Add-Line ""
Save-Now

# =====================================================================
#  PHASE 2 -- what Defender REAL-TIME does on write (not excluded)
# =====================================================================
if ($SkipWriteTest) {
    Add-Line "  PHASE 2 skipped (-SkipWriteTest)."
    Add-Line ""
} else {
    Add-Line "----------------------------------------------------------------------"
    Add-Line "  PHASE 2 -- DEFENDER REAL-TIME PROTECTION, ON WRITE"
    Add-Line "----------------------------------------------------------------------"
    Add-Line ""
    Add-Line "  This is the question a home user actually cares about: if one of"
    Add-Line "  these lands on the machine, does Defender take it by itself?"
    Add-Line ""
    Add-Line ("  Folder (NOT excluded): {0}" -f $ggWriteDir)
    Add-Line ("  Waiting {0} seconds after the copy, then looking." -f $WriteTestWaitSeconds)
    Add-Line ""

    if (-not (Test-Path -LiteralPath $ggWriteDir)) {
        New-Item -ItemType Directory -Path $ggWriteDir -Force | Out-Null
    }
    $ggT0 = Get-Date
    foreach ($s in $ggSpec) {
        $src = Get-GGSource $s
        if ($src -ne "") {
            Copy-Item -LiteralPath $src -Destination (Join-Path $ggWriteDir $s.Name) -Force -EA SilentlyContinue
        }
    }
    Start-Sleep -Seconds $WriteTestWaitSeconds

    $ggEaten = 0
    foreach ($s in $ggSpec) {
        $p = Join-Path $ggWriteDir $s.Name
        if (Test-Path -LiteralPath $p) {
            Add-Line ("  KEPT   {0}" -f $s.Name)
            Add-Line  "         Defender real-time did NOT act on it."
        } else {
            Add-Line ("  TAKEN  {0}" -f $s.Name)
            Add-Line  "         Defender real-time removed it on write."
            $ggEaten++
        }
    }
    Add-Line ""
    Add-Line ("  Removed by real-time protection: {0} of {1}" -f $ggEaten, $ggSpec.Count)
    Add-Line ""

    $ggThreats = @(Get-MpThreat -EA SilentlyContinue | Where-Object {
                     $_.InitialDetectionTime -ge $ggT0 })
    if ($ggThreats.Count -eq 0) {
        Add-Line "  Defender logged no new threat during this phase."
    } else {
        Add-Line "  Defender's own names for what it took:"
        foreach ($t in $ggThreats) {
            Add-Line ("    {0}" -f $t.ThreatName)
            Add-Line ("       severity {0}   detected {1}" -f $t.SeverityID, $t.InitialDetectionTime)
        }
    }
    Add-Line ""

    Remove-Item -LiteralPath $ggWriteDir -Recurse -Force -EA SilentlyContinue
    if (Test-Path -LiteralPath $ggWriteDir) {
        Add-Line "  NOTE: the write-test folder could not be removed. The cleanup"
        Add-Line "        script will take it."
    } else {
        Add-Line "  Write-test folder removed. Only the protected set remains."
    }
    Add-Line ""
}
Save-Now

# =====================================================================
#  PHASE 3 -- Defender ON-DEMAND custom scan, no action taken
# =====================================================================
Add-Line "----------------------------------------------------------------------"
Add-Line "  PHASE 3 -- DEFENDER ON-DEMAND SCAN OF THE PROTECTED FOLDER"
Add-Line "----------------------------------------------------------------------"
Add-Line ""

# VERIFIED 2026-09-07 measured on CGDELL, from MpCmdRun.exe -h verbatim:
#   -Scan [-ScanType value]  3  File and directory custom scan
#   [-File <path>]           the file or directory to be scanned
#   [-DisableRemediation]    valid only for custom scan. When specified:
#                              - File exclusions are ignored.
#                              - Archive files are scanned.
#                              - Actions are not applied after detection.
#                              - The console output will show the list of
#                                detections from the custom scan.
# Exit code 2 means malware was found and not remediated -- which is
# exactly what a successful run of this test looks like.
$ggMpCmd = Join-Path $env:ProgramFiles "Windows Defender\MpCmdRun.exe"
if (-not (Test-Path -LiteralPath $ggMpCmd)) {
    Add-Line "  MpCmdRun.exe not found. Skipping the on-demand scan."
} else {
    Add-Line "  Command:"
    Add-Line ("    MpCmdRun.exe -Scan -ScanType 3 -File `"{0}`" -DisableRemediation" -f $ggProtected)
    Add-Line ""
    Add-Line "  -DisableRemediation means Defender REPORTS and does not act, and"
    Add-Line "  it ignores the folder exclusion, so this is a real verdict."
    Add-Line ""

    $ggScanT0 = Get-Date
    $ggScanOut = & $ggMpCmd -Scan -ScanType 3 -File $ggProtected -DisableRemediation 2>&1
    $ggScanRc  = $LASTEXITCODE
    $ggScanSec = [math]::Round(((Get-Date) - $ggScanT0).TotalSeconds, 1)

    Add-Line ("  Scan finished in {0} seconds, exit code {1}." -f $ggScanSec, $ggScanRc)
    Add-Line ""
    Add-Line "  --- MpCmdRun output, verbatim ---"
    foreach ($l in $ggScanOut) {
        $txt = "$l"
        if ($txt.Trim() -ne "") { Add-Line ("  | {0}" -f $txt) }
    }
    Add-Line "  --- end of output ---"
    Add-Line ""

    switch ($ggScanRc) {
        0 { Add-Line "  Exit code 0: the scan completed and found nothing to report." }
        2 { Add-Line "  Exit code 2: malware found and not remediated. Expected here." }
        default { Add-Line ("  Exit code {0}: see MpCmdRun -h for the meaning." -f $ggScanRc) }
    }
    Add-Line ""
}

# ---- the protected set must have survived the scan -------------------
$ggLeft = 0
foreach ($s in $ggSpec) { if (Test-Path -LiteralPath (Join-Path $ggProtected $s.Name)) { $ggLeft++ } }
Add-Line ("  Specimens still present after the scan: {0} of {1}" -f $ggLeft, $ggSpec.Count)
if ($ggLeft -lt $ggSpec.Count) {
    Add-Line "  Some were removed anyway. Re-run this script to re-stage them --"
    Add-Line "  the originals on E: and G: are untouched."
}
Add-Line ""
Save-Now

# =====================================================================
#  NEXT -- Malwarebytes, which has no command line we can drive
# =====================================================================
Add-Line "======================================================================"
Add-Line "  NEXT STEP -- THE MALWAREBYTES HALF"
Add-Line "======================================================================"
Add-Line ""
Add-Line "  Malwarebytes Free has no command line, so this half is done in its"
Add-Line "  window. It takes about a minute."
Add-Line ""
Add-Line "    1. Open Malwarebytes."
Add-Line "    2. Click Scan on the left, then Advanced scanners,"
Add-Line "       then Configure Scan under Custom Scan."
Add-Line "    3. Tick ONLY this folder in the tree:"
Add-Line ("         {0}" -f $ggProtected)
Add-Line "    4. Make sure 'Scan for rootkits' and 'Scan within archives'"
Add-Line "       are turned on. The archive option matters -- one specimen"
Add-Line "       is a .zip."
Add-Line "    5. Start the scan."
Add-Line "    6. When it lists what it found, DO NOT quarantine. Close the"
Add-Line "       results instead. The names are what we came for, and the"
Add-Line "       files are needed again for the write-up."
Add-Line ""
Add-Line "  Then run Run-MBScanResult.bat. It reads Malwarebytes' own result"
Add-Line "  file and writes the list of names beside this one."
Add-Line ""
Add-Line "======================================================================"
Add-Line "  WHEN THE WHOLE TEST IS DONE: Run-PUATestCleanup.bat"
Add-Line "  It removes the folder and the Defender exclusion, and proves both"
Add-Line "  are gone. An exclusion left behind is a real hole in a real"
Add-Line "  machine, so do not skip it."
Add-Line "======================================================================"
Add-Line ""
Add-Line ("  Saved to: {0}" -f $ggOut)
Save-Now
