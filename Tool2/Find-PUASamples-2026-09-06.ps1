# =====================================================================
#  Find-PUASamples-2026-09-06.ps1
#
#  SEARCHES THE ATTACHED BACKUP DRIVES FOR THE 18 PUP DETECTIONS FROM
#  SANDY'S 2026-07-19 MALWAREBYTES CUSTOM SCAN.
#
#  Source of the list, and it is better than a list of names -- it carries
#  MD5 and SHA-256 for every detection:
#      "C:\Users\willi\OneDrive - GatewayGuard LLC\claude\Desktop\
#       Malwarebytes Custom Scan Report 2026-07-19 150517.txt"
#
#  READ-ONLY. It enumerates files and computes hashes. It does not open,
#  execute, copy, move, rename or delete anything. There is no Remove-,
#  Copy-, Move- or Start-Process anywhere in this file.
#
#  THE 18 DETECTIONS ARE ONLY 6 DISTINCT FILES. Twelve of the eighteen are
#  the same CLIENTSETUP_D-0.EXE found down twelve nested copies of the same
#  backup tree -- identical SHA-256. So hashes, not names, are what to
#  match on: a copy that was renamed still matches, and a different file
#  that happens to share a name does not.
#
#  WHY IT MATCHES ON HASH AS WELL AS NAME: a backup drive holds copies made
#  by people, and people rename things. Name-only would miss
#  "clientsetup_d-0 (1).exe" and would wrongly claim a hit on any unrelated
#  file called TOTALAV.EXE.
#
#  -HashSweep does a second, slower pass: hash EVERY .exe and .zip on the
#  drive and match on content alone. Use it if the name pass finds nothing.
#
#  Output goes to Test_Results\ so nothing is truncated on screen.
# =====================================================================

param(
    [string[]]$Drives   = @("E:\", "G:\"),
    [switch]  $HashSweep
)

$ErrorActionPreference = "Continue"
$ProgressPreference    = "SilentlyContinue"

# ---- the 6 distinct specimens, from the scan report ------------------
$ggWanted = @(
  @{ Name = "CLIENTSETUP_D-0.EXE";                    Threat = "PUP.Optional.DllFilesFixer"; Copies = 12
     Sha  = "6B1A9C62C1C0E084EA30BD9CBE991FE859938FEA3A67378CB0ABF400AC264816" }
  @{ Name = "CLAIMID800393432WILLIANF_BURNSIII.ZIP";  Threat = "PUP.Optional.DllFilesFixer"; Copies = 1
     Sha  = "729D0208A13395F818FF20BFC1B14B0CE918F1744FBA8D36E132253E1B18F341" }
  @{ Name = "WAVE BROWSER.EXE";                       Threat = "PUP.Optional.Wave";          Copies = 2
     Sha  = "81B9CC993AD57F3D16146842665B8C82A2C29D7E571F38CF14A4AB2B24148ECB" }
  @{ Name = "WAVE BROWSER (2).EXE";                   Threat = "PUP.Optional.Wave";          Copies = 1
     Sha  = "216D4BCEA4BBE226F0C610C59B911CF9351FEA34178A1F8EC04DAD99F4F1BDBC" }
  @{ Name = "TOTALAV.EXE";                            Threat = "PUP.Optional.TotalAV";       Copies = 1
     Sha  = "3B0CACDA195CD3F1A50EE5C9842E14753E92A4E63DE75AD7C15BAA16C0A8A688" }
  @{ Name = "ZOOMINFOCONTACTCONTRIBUTOR.EXE";         Threat = "PUP.Optional.ZoomInfo";      Copies = 1
     Sha  = "71DE08D14B90196B02293DDCA105DC367837280BEE2224815E35FF7F17363C48" }
)

# Every name that appeared in the report, including the numbered duplicates.
$ggNames = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::OrdinalIgnoreCase)
foreach ($n in @("CLIENTSETUP_D-0.EXE","CLAIMID800393432WILLIANF_BURNSIII.ZIP",
                 "WAVE BROWSER.EXE","WAVE BROWSER (1).EXE","WAVE BROWSER (2).EXE",
                 "TOTALAV.EXE","ZOOMINFOCONTACTCONTRIBUTOR.EXE")) { [void]$ggNames.Add($n) }

$ggShaMap = @{}
foreach ($w in $ggWanted) { $ggShaMap[$w.Sha.ToUpper()] = $w }

# ---- output ----------------------------------------------------------
$ggStamp  = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ggRoot   = Split-Path $PSScriptRoot -Parent
$ggOutDir = Join-Path $ggRoot "Test_Results"
if (-not (Test-Path $ggOutDir)) { New-Item -ItemType Directory -Path $ggOutDir -Force | Out-Null }
$ggOut = Join-Path $ggOutDir "PUASampleSearch-$env:COMPUTERNAME-$ggStamp.txt"

$ggLines = New-Object System.Collections.ArrayList
function Add-Line { param([string]$T = "") ; $null = $ggLines.Add($T) ; Write-Host $T }

Add-Line "======================================================================"
Add-Line "  SEARCH FOR THE 2026-07-19 MALWAREBYTES PUP DETECTIONS"
Add-Line "  $env:COMPUTERNAME   $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Add-Line "  READ-ONLY -- nothing is opened, run, copied, moved or deleted."
Add-Line "======================================================================"
Add-Line ""
Add-Line "  The report listed 18 detections. They are 6 DISTINCT files:"
foreach ($w in $ggWanted) {
    Add-Line ("    {0,-40} {1,-28} x{2}" -f $w.Name, $w.Threat, $w.Copies)
}
Add-Line ""
Add-Line "  All 18 were on SANDY's D: and every one says 'No Action By User'."
Add-Line "  Scan report header: Threats Quarantined: 0."
Add-Line ""

$ggHits = New-Object System.Collections.ArrayList

foreach ($drv in $Drives) {
    Add-Line "----------------------------------------------------------------------"
    Add-Line "  DRIVE $drv"
    Add-Line "----------------------------------------------------------------------"
    if (-not (Test-Path -LiteralPath $drv)) {
        Add-Line "  NOT PRESENT -- skipped."
        Add-Line ""
        continue
    }

    $ggSeen = 0
    $ggExeZip = New-Object System.Collections.ArrayList
    $ggNameHits = New-Object System.Collections.ArrayList
    $ggT0 = Get-Date

    # ONE recursive pass. Seven separate -Filter passes would walk the disk
    # seven times; this walks it once and tests each name in memory.
    Get-ChildItem -LiteralPath $drv -Recurse -File -Force -EA SilentlyContinue |
      ForEach-Object {
        $ggSeen++
        if ($ggNames.Contains($_.Name)) { [void]$ggNameHits.Add($_) }
        elseif ($HashSweep) {
            $ext = $_.Extension.ToLower()
            if ($ext -eq ".exe" -or $ext -eq ".zip") { [void]$ggExeZip.Add($_) }
        }
      }

    $ggSecs = [math]::Round(((Get-Date) - $ggT0).TotalSeconds)
    Add-Line ("  Files enumerated : {0:N0}   ({1} sec)" -f $ggSeen, $ggSecs)
    Add-Line ("  Name matches     : {0}" -f $ggNameHits.Count)
    Add-Line ""

    foreach ($f in $ggNameHits) {
        $sha = ""
        try { $sha = (Get-FileHash -LiteralPath $f.FullName -Algorithm SHA256 -EA Stop).Hash.ToUpper() }
        catch { $sha = "COULD NOT HASH: $_" }
        $known = $ggShaMap.ContainsKey($sha)
        $verdict = if ($known) { "*** CONFIRMED -- SHA-256 matches the scan report ***" }
                   else { "name matches, CONTENT DOES NOT -- a different file with the same name" }
        Add-Line ("  {0}" -f $f.FullName)
        Add-Line ("     size {0:N0} bytes   modified {1}" -f $f.Length, $f.LastWriteTime)
        Add-Line ("     SHA-256 {0}" -f $sha)
        Add-Line ("     {0}" -f $verdict)
        Add-Line ""
        if ($known) {
            [void]$ggHits.Add([PSCustomObject]@{
                Drive = $drv; Path = $f.FullName; Sha = $sha
                Threat = $ggShaMap[$sha].Threat; Specimen = $ggShaMap[$sha].Name })
        }
    }

    if ($HashSweep) {
        Add-Line ("  HASH SWEEP: {0:N0} .exe/.zip files to hash. This is the slow pass." -f $ggExeZip.Count)
        $ggN = 0
        foreach ($f in $ggExeZip) {
            $ggN++
            try {
                $sha = (Get-FileHash -LiteralPath $f.FullName -Algorithm SHA256 -EA Stop).Hash.ToUpper()
                if ($ggShaMap.ContainsKey($sha)) {
                    Add-Line ("  *** CONTENT MATCH (renamed copy) ***")
                    Add-Line ("     {0}" -f $f.FullName)
                    Add-Line ("     is {0} -- {1}" -f $ggShaMap[$sha].Name, $ggShaMap[$sha].Threat)
                    Add-Line ""
                    [void]$ggHits.Add([PSCustomObject]@{
                        Drive = $drv; Path = $f.FullName; Sha = $sha
                        Threat = $ggShaMap[$sha].Threat; Specimen = $ggShaMap[$sha].Name })
                }
            } catch { }
        }
        Add-Line ("  Hash sweep complete -- {0:N0} files hashed." -f $ggN)
        Add-Line ""
    }
}

# ---- summary ---------------------------------------------------------
Add-Line "======================================================================"
Add-Line "  RESULT"
Add-Line "======================================================================"
Add-Line ""
if ($ggHits.Count -eq 0) {
    Add-Line "  NOTHING FOUND on the drives searched."
    Add-Line ""
    if (-not $HashSweep) {
        Add-Line "  This was the NAME pass only. A copy that was renamed would not"
        Add-Line "  have been seen. Run again with -HashSweep to match on content."
    } else {
        Add-Line "  This included the content sweep, so a renamed copy would have"
        Add-Line "  been found. These specimens are not on these drives."
    }
} else {
    Add-Line ("  {0} FILE(S) CONFIRMED BY SHA-256:" -f $ggHits.Count)
    Add-Line ""
    $ggBySpec = $ggHits | Group-Object Specimen
    foreach ($g in $ggBySpec) {
        Add-Line ("  {0}  --  {1} cop(y/ies)" -f $g.Name, $g.Count)
        foreach ($h in $g.Group) { Add-Line ("      {0}" -f $h.Path) }
        Add-Line ""
    }
    Add-Line "  DISTINCT SPECIMENS RECOVERED: $($ggBySpec.Count) of 6"
    Add-Line ""
    Add-Line "  These are the real samples the Defender-vs-Malwarebytes comparison"
    Add-Line "  needs. LEAVE THEM WHERE THEY ARE for now -- copying them anywhere"
    Add-Line "  is a decision for Bill, not for this script."
}
Add-Line ""
Add-Line "======================================================================"
Add-Line "  Saved to: $ggOut"
Add-Line "======================================================================"

$ggLines -join "`r`n" | Out-File -FilePath $ggOut -Encoding UTF8
