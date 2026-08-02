# Dated: 2026-08-02 14:35 ET
# ================================================================
# FILE:    Check-FreeSpaceWipe-2026-08-02.ps1
# PURPOSE: FT-168, PROBE ONLY. Report which free-space wipe command works on
#          this PC, what the drive is, and how long a wipe would take.
#
# *** THIS SCRIPT CANNOT WIPE ANYTHING. READ-ONLY, NO EXCEPTIONS. ***
#
#   The wipe half was DELIBERATELY REMOVED on 2026-08-02, at Bill's
#   direction, until the encryption field testing is finished.
#
#   WHY: SANDY's encryption is a ONE-SHOT measurement -- no machine in this
#   project has ever been watched through an encryption, and a finished one
#   leaves no recoverable duration. A free-space wipe started by accident
#   would take hours, write across the whole drive, and destroy that
#   measurement. The safest tool during the encryption window is one that
#   is INCAPABLE of the destructive action, not one that merely asks first.
#
#   It was renamed from Measure-FreeSpaceWipe to Check-FreeSpaceWipe in the
#   same edit, because a name promising to MEASURE a wipe it cannot perform
#   is the "pointer that lies" problem this project already has a rule about.
#
#   TO RESTORE THE WIPE HALF LATER: the full version is preserved at
#   scratchpad\wipe-capability-removed-2026-08-02\ as
#   Measure-FreeSpaceWipe-WITH-WIPE.ps1.keep and its paired .bat. Restore
#   both together -- the launcher carries the Stage 2 prompt.
#
# WHAT IT STILL DOES, ALL READ-ONLY:
#   - lists the fixed drives
#   - identifies the real physical disk behind a volume (FT-163 method)
#   - REFUSES to advise wiping an SSD, and says why
#   - reports whether `manage-bde -w` or `cipher /w` is available, WITHOUT
#     running either (asking for help starts nothing -- verified)
#   - prints a time estimate for a wipe that it will not perform
#
# WHY IT EXISTS. Used-space-only encryption leaves data deleted BEFORE
# encryption sitting unencrypted in free space, recoverable with ordinary
# tools. Microsoft's fix is `manage-bde -w`, whose own help says it gives a
# used-space-only volume "the same level of protection as if the volume had
# been encrypted with the full encryption option."
#
# THE OPEN QUESTION THIS ANSWERS: Home-edition support for `manage-bde -w` is
# unconfirmed -- it is documented mainly as a Pro/Enterprise tool. If it is
# unavailable on SANDY, the fallback is `cipher /w`, a plain Windows utility
# with no BitLocker dependency. Which one works is itself the finding.
#
# USAGE: double-click Run-FreeSpaceWipeCheck.bat
# ================================================================

param(
    [string]$Drive = ""
)

$ErrorActionPreference = "Continue"
$stamp  = Get-Date -Format "yyyy-MM-dd_HH-mm"
$outTxt = Join-Path $PSScriptRoot ("FreeSpaceWipe-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")
$L = New-Object System.Collections.Generic.List[string]
function W { param($t="") $L.Add([string]$t); Write-Host $t }
function Save { $L -join "`r`n" | Out-File -FilePath $outTxt -Encoding UTF8 }

W "================================================================"
W " FREE-SPACE WIPE -- PROBE ONLY (FT-168)"
W " Computer : $env:COMPUTERNAME"
W " Run date : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
W " Mode     : READ-ONLY. This tool cannot wipe. The wipe half was"
W "            removed until encryption testing is finished."
W "================================================================"
W ""

$fixed = @()
try {
    $fixed = @(Get-Volume -EA Stop | Where-Object { $_.DriveLetter -and $_.DriveType -eq 'Fixed' } | Sort-Object DriveLetter)
} catch { W "  Could not enumerate volumes: $_"; Save; exit 1 }

if (-not $Drive) {
    W "FIXED DRIVES ON THIS PC:"
    foreach ($v in $fixed) {
        W ("  {0}:  {1,7:N1} GB total, {2,7:N1} GB free  {3}" -f $v.DriveLetter, ($v.Size/1GB), ($v.SizeRemaining/1GB), $v.FileSystemLabel)
    }
    W ""
    W "  That is the list. Nothing has been read or written on any of them yet."
    W "  Next you will be asked which one to LOOK AT. Nothing this tool does"
    W "  can change a drive -- it has no wipe capability at all."
    Save; exit 0
}

$Drive = $Drive.TrimEnd(':').ToUpper()
$vol = $fixed | Where-Object { $_.DriveLetter -eq $Drive } | Select-Object -First 1
if (-not $vol) {
    W ("  {0}: is not a fixed drive on this PC." -f $Drive)
    W "  Fixed drives found: " + $(if ($fixed) { ($fixed | ForEach-Object { $_.DriveLetter + ":" }) -join " " } else { "none" })
    Save; exit 1
}

$freeGB  = [math]::Round($vol.SizeRemaining/1GB, 1)
$totalGB = [math]::Round($vol.Size/1GB, 1)
$usedGB  = [math]::Round(($vol.Size - $vol.SizeRemaining)/1GB, 1)

W ("TARGET: {0}:  {1}" -f $Drive, $(if ($vol.FileSystemLabel) { $vol.FileSystemLabel } else { "(no label)" }))
W ("  total / used / free : {0} GB / {1} GB / {2} GB" -f $totalGB, $usedGB, $freeGB)

# FT-163 method: resolve the disk that actually hosts THIS volume, never
# "the first disk" -- that returns a USB stick on CGDELL.
$media = "Unknown"; $model = ""
try {
    $part = Get-Partition -DriveLetter $Drive -EA Stop
    $disk = Get-Disk -Number $part.DiskNumber -EA Stop
    $pd   = Get-PhysicalDisk | Where-Object { $_.DeviceId -eq [string]$disk.Number } | Select-Object -First 1
    if ($pd) { $media = [string]$pd.MediaType; $model = [string]$pd.FriendlyName }
} catch {}
W ("  drive model         : {0}" -f $model)
W ("  media type          : {0}" -f $media)
W ""

if ($media -match "SSD|Solid") {
    W "VERDICT: DO NOT WIPE FREE SPACE ON THIS DRIVE. It is solid state."
    W ""
    W "  Free-space wiping on an SSD spends a finite number of write cycles"
    W "  for very little benefit. TRIM and wear-levelling mean Windows cannot"
    W "  reliably overwrite the physical memory cells holding the old data, so"
    W "  the wipe costs drive life without reliably achieving the goal."
    W ""
    W "  If this drive needs sanitising, use the manufacturer's own secure-erase"
    W "  tool (Samsung Magician, Crucial Storage Executive, WD Dashboard)."
    Save
    Write-Host ""
    Write-Host "  Report saved to: $outTxt" -ForegroundColor Gray
    exit 0
}
if ($media -notmatch "HDD") {
    W ("  NOTE: media type reported as '{0}', not a clear HDD. A wipe is only" -f $media)
    W "  appropriate on a spinning hard drive."
    W ""
}

# VERIFIED 2026-08-02 measured on CGDELL: `manage-bde.exe -w -?` prints
#   "manage-bde {-WipeFreeSpace|-w} Volume" plus a Description block, and
#   free space was 143.30 GB before and after the call -- asking for help
#   starts nothing.
# VERIFIED 2026-08-02 measured on CGDELL: `cipher.exe /?` lists
#   "/W  Removes data from available unused disk space on the entire volume."
W "WHICH COMMAND WOULD WORK HERE?"
$mbdeOK = $false; $cipherOK = $false
try {
    $h = & manage-bde.exe -w -? 2>&1 | Out-String
    if ($h -match "WipeFreeSpace|Wipes the free space") { $mbdeOK = $true }
    W ("  manage-bde -w  : {0}" -f $(if ($mbdeOK) { "AVAILABLE" } else { "NOT available on this edition" }))
} catch { W ("  manage-bde -w  : not available ({0})" -f $_) }
try {
    $h2 = & cipher.exe /? 2>&1 | Out-String
    if ($h2 -match "/W\s") { $cipherOK = $true }
    W ("  cipher /w      : {0}" -f $(if ($cipherOK) { "AVAILABLE" } else { "NOT available" }))
} catch { W ("  cipher /w      : not available ({0})" -f $_) }
W ""

if (-not $mbdeOK -and -not $cipherOK) {
    W "  Neither command is available on this PC. A free-space wipe is not"
    W "  possible here by built-in means."
    Save; exit 0
}

$chosen = if ($mbdeOK) { "manage-bde" } else { "cipher" }
$passes = if ($chosen -eq "manage-bde") { 1 } else { 3 }
W ("  WOULD USE: {0}" -f $(if ($chosen -eq "manage-bde") { "manage-bde -w $Drive`:   -- single pass, encrypts the free space" } else { "cipher /w:$Drive`:\   -- multi-pass overwrite, expect longer" }))
W ""

W "TIME ESTIMATE -- inferred, not measured"
W "  (arithmetic on assumed drive throughput. The pass count for cipher /w"
W "   could not be confirmed from Microsoft's documentation.)"
foreach ($mbs in 100, 60) {
    $mins = [math]::Round(($freeGB * 1024) / $mbs / 60, 0)
    W ("  at {0,3} MB/s : {1,5} min per pass  x{2} = ~{3:N1} hours for {4} GB of free space" -f $mbs, $mins, $passes, ($mins*$passes/60), $freeGB)
}
W ""
W "  Only a real run produces a real number, and nobody can recover it"
W "  afterwards. That run is deliberately not possible with this version."
W ""
W "NOTHING WAS WRITTEN. This tool has no wipe capability."
Save
Write-Host ""
Write-Host "  Report saved to: $outTxt" -ForegroundColor Gray
