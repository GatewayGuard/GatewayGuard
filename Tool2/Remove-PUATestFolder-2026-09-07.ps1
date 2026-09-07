# =====================================================================
#  Remove-PUATestFolder-2026-09-07.ps1
#
#  UNDOES EVERYTHING Test-PUAComparison-2026-09-07.ps1 DID.
#
#  It removes the two test folders and the Defender folder exclusion,
#  then READS BOTH BACK to prove they are gone. An exclusion left behind
#  is a real hole in a real machine, which is why this verifies rather
#  than assuming.
#
#  It does not touch the originals on E: and G:, and it does not touch
#  anything under C:\AVTestKit that it did not create.
#
#  Needs administrator, only to remove the exclusion. It never elevates
#  itself.
# =====================================================================

param(
    [string]$TestRoot = "C:\AVTestKit"
)

$ErrorActionPreference = "Continue"

$ggProtected = Join-Path $TestRoot "07_pua"
$ggWriteDir  = Join-Path $TestRoot "07_pua_rtp"

$ggStamp  = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ggRoot   = Split-Path $PSScriptRoot -Parent
$ggOutDir = Join-Path $ggRoot "Test_Results"
if (-not (Test-Path $ggOutDir)) { New-Item -ItemType Directory -Path $ggOutDir -Force | Out-Null }
$ggOut = Join-Path $ggOutDir "PUATestCleanup-$env:COMPUTERNAME-$ggStamp.txt"

$ggLines = New-Object System.Collections.ArrayList
function Add-Line { param([string]$T = "") ; $null = $ggLines.Add($T) ; Write-Host $T }

Add-Line "======================================================================"
Add-Line "  PUA TEST CLEANUP"
Add-Line "  $env:COMPUTERNAME   $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Add-Line "======================================================================"
Add-Line ""

$ggId   = [Security.Principal.WindowsIdentity]::GetCurrent()
$ggElev = (New-Object Security.Principal.WindowsPrincipal($ggId)).IsInRole(
            [Security.Principal.WindowsBuiltInRole]::Administrator)
Add-Line ("  Administrator: {0}" -f $ggElev)
Add-Line ""

# ---- 1. the folders --------------------------------------------------
Add-Line "  FOLDERS"
foreach ($d in @($ggProtected, $ggWriteDir)) {
    if (Test-Path -LiteralPath $d) {
        $n = @(Get-ChildItem -LiteralPath $d -Recurse -File -Force -EA SilentlyContinue).Count
        Remove-Item -LiteralPath $d -Recurse -Force -EA SilentlyContinue
        if (Test-Path -LiteralPath $d) { Add-Line ("    STILL THERE  {0}" -f $d) }
        else { Add-Line ("    removed      {0}   ({1} file(s))" -f $d, $n) }
    } else {
        Add-Line ("    not present  {0}" -f $d)
    }
}
# AVTestKit itself only goes if it is now empty -- the EICAR kit may own it.
if (Test-Path -LiteralPath $TestRoot) {
    $rest = @(Get-ChildItem -LiteralPath $TestRoot -Force -EA SilentlyContinue)
    if ($rest.Count -eq 0) {
        Remove-Item -LiteralPath $TestRoot -Force -EA SilentlyContinue
        Add-Line ("    removed      {0}   (it was empty)" -f $TestRoot)
    } else {
        Add-Line ("    kept         {0}   ({1} other item(s) in it -- not ours)" -f $TestRoot, $rest.Count)
    }
}
Add-Line ""

# ---- 2. the exclusion ------------------------------------------------
Add-Line "  DEFENDER EXCLUSION"
if (-not $ggElev) {
    Add-Line "    CANNOT REMOVE IT -- this needs administrator."
    Add-Line "    Right-click Run-PUATestCleanup.bat, 'Run as administrator',"
    Add-Line "    and run it again. THE EXCLUSION IS STILL IN PLACE until you do."
} else {
    $before = @((Get-MpPreference).ExclusionPath)
    if ($before -contains $ggProtected) {
        Remove-MpPreference -ExclusionPath $ggProtected -EA SilentlyContinue
    } else {
        Add-Line "    It was not there to begin with."
    }
    $after = @((Get-MpPreference).ExclusionPath)
    if ($after -contains $ggProtected) {
        Add-Line ("    STILL EXCLUDED: {0}" -f $ggProtected)
        Add-Line  "    Remove it by hand: Windows Security -> Virus and threat"
        Add-Line  "    protection -> Manage settings -> Exclusions."
    } else {
        Add-Line ("    removed and verified gone: {0}" -f $ggProtected)
    }
    if ($after.Count -eq 0) { Add-Line "    Defender now has no folder exclusions at all." }
    else { foreach ($e in $after) { Add-Line ("    remaining exclusion: {0}" -f $e) } }
}
Add-Line ""

# ---- 3. what the scanners are still holding --------------------------
Add-Line "  QUARANTINE"
$ggQ = @(Get-MpThreat -EA SilentlyContinue)
if ($ggQ.Count -eq 0) {
    Add-Line "    Defender is holding no threat records."
} else {
    Add-Line ("    Defender has {0} threat record(s). The recent ones:" -f $ggQ.Count)
    foreach ($t in ($ggQ | Sort-Object InitialDetectionTime -Descending | Select-Object -First 10)) {
        Add-Line ("      {0}   {1}" -f $t.InitialDetectionTime, $t.ThreatName)
    }
    Add-Line ""
    Add-Line "    To clear them: Windows Security -> Virus and threat protection"
    Add-Line "    -> Protection history."
}
Add-Line ""
Add-Line "    Malwarebytes keeps its own quarantine. If anything was"
Add-Line "    quarantined there, clear it in the Malwarebytes window under"
Add-Line "    Detection History."
Add-Line ""
Add-Line "======================================================================"
Add-Line "  The specimens on E: and G: were never touched. The test can be"
Add-Line "  staged again at any time with Run-PUAComparison.bat."
Add-Line "======================================================================"
Add-Line ""
Add-Line ("  Saved to: {0}" -f $ggOut)

($ggLines -join "`r`n") | Out-File -FilePath $ggOut -Encoding UTF8
