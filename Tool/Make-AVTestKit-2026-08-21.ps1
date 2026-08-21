# Dated: 2026-08-21 14:10 ET
# ================================================================
# FILE:    Make-AVTestKit-2026-08-21.ps1
# PURPOSE: Stage HARMLESS, industry-standard antivirus TEST specimens
#          across C: and D:, in a matrix of locations, so you can measure
#          which scan (Defender offline / Defender full / Malwarebytes
#          custom / Malwarebytes deep) finds what, and on which drive.
#
# THESE ARE NOT MALWARE. Every specimen is the EICAR test string -- a
# 68-byte text file that AV engines are DELIBERATELY built to flag. It
# contains no code, cannot execute anything harmful, and is the sanctioned
# way (since 1991) to test detection without risk. See https://www.eicar.org.
#
# The EICAR string is assembled from fragments at runtime so THIS script
# file is not itself flagged by the AV on the machine that stores it.
#
# NO real virus. NO rootkit. NO code that hides or persists. The "hidden"
# specimens use ordinary NTFS features (hidden attribute, Alternate Data
# Streams, nested folders, archives) to test SCAN THOROUGHNESS -- not to
# evade anything. That is the whole point: a guaranteed-detected specimen
# in a hard-to-reach place isolates COVERAGE as the only variable.
#
# Reversible: Remove-AVTestKit-2026-08-21.ps1 deletes everything this
# writes. Does not self-elevate. Writes a manifest so you know what is where.
# ================================================================

param(
    [switch]$DryRun,                       # show the plan, write nothing
    [string[]]$Drives = @("C","D")         # which drive roots to stage on
)

$ErrorActionPreference = "Continue"
$stamp = Get-Date -Format "yyyy-MM-dd_HH-mm"

# -- assemble the EICAR test string from fragments (see header) ----
# None of these fragments is the signature; only the join is, and the
# join happens in memory, never in this file's bytes.
$f1 = 'X5O!P%@AP[4\P'
$f2 = 'ZX54(P^)7CC)7'
$br = [char]0x7D                        # the closing-brace char, built from its
                                        # code so the brace count stays balanced
$f3 = '$EICAR-STANDARD-ANTIVIRUS-'
$f4 = 'TEST-FILE!$H+H*'
$EICAR = $f1 + $f2 + $br + $f3 + $f4     # 68 bytes, the standard test file

$manifest = New-Object System.Collections.Generic.List[object]
$log = New-Object System.Collections.Generic.List[string]
function Say { param([string]$t="") ; $log.Add($t) ; Write-Host $t }

Say "================================================================"
Say " AV SCAN COVERAGE TEST KIT -- $env:COMPUTERNAME -- $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
if ($DryRun) { Say " DRY RUN -- showing the plan, writing nothing." }
Say " Specimens are the EICAR test string. Not malware. Fully reversible."
Say "================================================================"
Say ""

# -- helper: write EICAR into a file, honestly report if it survived
function Place {
    param([string]$Path, [string]$How)
    $dir = Split-Path $Path -Parent
    if ($DryRun) {
        $manifest.Add([pscustomobject]@{ Location=$Path; Technique=$How; Survived="(dry run)" })
        Say ("  PLAN  [" + $How + "]  " + $Path)
        return
    }
    try {
        if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
        [IO.File]::WriteAllText($Path, $EICAR)
        Start-Sleep -Milliseconds 400          # give real-time protection a moment
        $survived = Test-Path $Path
        $manifest.Add([pscustomobject]@{ Location=$Path; Technique=$How; Survived=$survived })
        Say ("  " + $(if ($survived) {"KEPT "} else {"EATEN"}) + " [" + $How + "]  " + $Path)
    } catch {
        $manifest.Add([pscustomobject]@{ Location=$Path; Technique=$How; Survived=("ERROR: " + $_.Exception.Message) })
        Say ("  ERROR [" + $How + "]  " + $Path + "  -- " + $_.Exception.Message)
    }
}

# -- helper: EICAR inside an Alternate Data Stream on an innocent host
function PlaceADS {
    param([string]$HostFile, [string]$Stream)
    if ($DryRun) {
        $manifest.Add([pscustomobject]@{ Location=($HostFile+":"+$Stream); Technique="ADS (alternate data stream)"; Survived="(dry run)" })
        Say ("  PLAN  [ADS]  " + $HostFile + ":" + $Stream)
        return
    }
    try {
        $dir = Split-Path $HostFile -Parent
        if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
        Set-Content -Path $HostFile -Value "This is an ordinary file. The test specimen is in an alternate data stream." -Encoding Ascii
        Set-Content -Path $HostFile -Stream $Stream -Value $EICAR
        Start-Sleep -Milliseconds 400
        $survived = $false
        try { $null = Get-Content -Path $HostFile -Stream $Stream -ErrorAction Stop; $survived = $true } catch {}
        $manifest.Add([pscustomobject]@{ Location=($HostFile+":"+$Stream); Technique="ADS (alternate data stream)"; Survived=$survived })
        Say ("  " + $(if ($survived) {"KEPT "} else {"EATEN"}) + " [ADS]  " + $HostFile + ":" + $Stream)
    } catch {
        Say ("  ERROR [ADS]  " + $HostFile + "  -- " + $_.Exception.Message)
    }
}

# -- helper: EICAR inside a ZIP archive
function PlaceZip {
    param([string]$ZipPath)
    if ($DryRun) {
        $manifest.Add([pscustomobject]@{ Location=$ZipPath; Technique="inside ZIP archive"; Survived="(dry run)" })
        Say ("  PLAN  [ZIP]  " + $ZipPath)
        return
    }
    try {
        $dir = Split-Path $ZipPath -Parent
        if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
        $tmp = Join-Path $env:TEMP ("eicar_" + $stamp + ".txt")
        [IO.File]::WriteAllText($tmp, $EICAR)
        if (Test-Path $ZipPath) { Remove-Item $ZipPath -Force }
        Compress-Archive -Path $tmp -DestinationPath $ZipPath -Force
        Remove-Item $tmp -Force -ErrorAction SilentlyContinue
        Start-Sleep -Milliseconds 400
        $survived = Test-Path $ZipPath
        $manifest.Add([pscustomobject]@{ Location=$ZipPath; Technique="inside ZIP archive"; Survived=$survived })
        Say ("  " + $(if ($survived) {"KEPT "} else {"EATEN"}) + " [ZIP]  " + $ZipPath)
    } catch {
        Say ("  ERROR [ZIP]  " + $ZipPath + "  -- " + $_.Exception.Message)
    }
}

# -- the matrix, applied to each requested drive that actually exists ---
foreach ($d in $Drives) {
    $root = ($d + ":\")
    if (-not (Test-Path $root)) { Say ("  SKIP  " + $root + " -- no such drive on this machine"); Say ""; continue }
    $base = Join-Path $root "AVTestKit"
    Say ("--- " + $root + " ---")

    Place  (Join-Path $base "01_plain\specimen.txt")                    "plain file, plain name"
    Place  (Join-Path $base "02_renamed\invoice.dat")                   "renamed extension (.dat)"
    Place  (Join-Path $base "03_deep\a\b\c\d\e\buried.txt")             "deeply nested folder"
    $hid = Join-Path $base "04_hidden\systemfile.txt"
    Place  $hid                                                          "hidden + system attributes"
    if (-not $DryRun -and (Test-Path $hid)) {
        try { (Get-Item $hid -Force).Attributes = 'Hidden,System' } catch {}
    }
    PlaceZip (Join-Path $base "05_archive\bundle.zip")
    # ADS only works on NTFS; C: always is, D: usually is
    PlaceADS (Join-Path $base "06_ads\readme.txt") "hidden"

    Say ""
}

# -- write the manifest next to this script (never contains EICAR) -----
$outDir  = Join-Path $PSScriptRoot "..\Test_Results"
if (-not (Test-Path $outDir)) { $outDir = $PSScriptRoot }
$manFile = Join-Path $outDir ("AVTestKit-Manifest-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

Say "================================================================"
Say " MANIFEST"
Say "================================================================"
foreach ($m in $manifest) { Say ("  " + $m.Survived.ToString().PadRight(6) + " " + $m.Technique.PadRight(28) + " " + $m.Location) }
Say ""
Say " KEPT  = specimen is on disk now (real-time protection did NOT take it)"
Say " EATEN = real-time protection removed it on write -- itself a result"
Say ""
Say (" Manifest saved: " + $manFile)
Say ""
Say " NEXT: follow ProjectDocs\GatewayGuard_AVScanCoverageTest-2026-08-21.md"
Say " Clean up when done: Run-AVTestKitCleanup.bat"

if (-not $DryRun) {
    try { ($log -join "`r`n") | Out-File -FilePath $manFile -Encoding UTF8 } catch { Write-Host "  could not write manifest: $($_.Exception.Message)" }
}
