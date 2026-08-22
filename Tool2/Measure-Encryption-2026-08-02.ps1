# Dated: 2026-08-02 13:05 ET
# ================================================================
# FILE:    Measure-Encryption-2026-08-02.ps1
# PURPOSE: Capture the data needed to PREDICT how long encryption takes,
#          and -- if encryption is running -- measure it as it happens.
#          Covers EVERY FIXED DRIVE, not just C:.
#
# REVISION 2026-08-02 13:05 -- MULTI-DRIVE. The first version of this script
#   sampled `Get-BitLockerVolume -MountPoint C:` and nothing else. That is
#   precisely the FT-167 defect it was written to investigate, committed
#   inside the investigating tool. SANDY has an internal fixed 1 TB D: beside
#   its 250 GB C:, so a C:-only reading would have missed 80% of the machine
#   and produced a "measured" timing that was measuring the wrong thing.
#   Now enumerates every FIXED volume and reports each separately.
#
# WHY LIVE SAMPLING IS THE ONLY WAY. Measured on CGDELL 2026-08-02: a finished
# encryption leaves NO recoverable duration. The BitLocker Management log has
# event 769 ("encryption will occur when the computer is restarted") and then
# nothing -- no "started", no "completed". Events 24577/24578/24579 do not
# exist on this OS, and the BitLocker Operational log ships DISABLED. So the
# Dell's and the IdeaPad's encryption times are gone for good.
#
# CORRECT DISK RESOLUTION (FT-163). Checkup's Get-BitLockerTimeEstimate uses
# `Get-PhysicalDisk | Select-Object -First 1`, which on CGDELL returns an 8 GB
# USB stick instead of the 238 GB NVMe SSD hosting C:. This script resolves
# each volume -> partition -> disk number -> physical disk instead.
#
# REMOVABLE DRIVES ARE EXCLUDED deliberately. Device Encryption and BitLocker
# cover the OS drive and FIXED data drives; USB sticks are BitLocker To Go, a
# separate feature and a separate decision.
#
# READ-ONLY. Reads BitLocker status and hardware inventory. It never starts,
# stops or changes encryption, and changes no setting.
#
# USAGE: double-click Run-EncryptionMeasure.bat
#        START IT BEFORE turning encryption on, and leave the window open.
# ================================================================

param(
    [int]$IntervalSeconds = 60,
    [int]$MaxHours = 24
)

$ErrorActionPreference = "Continue"
$stamp  = Get-Date -Format "yyyy-MM-dd_HH-mm"
$outTxt = Join-Path $PSScriptRoot ("EncryptionProfile-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")
$outCsv = Join-Path $PSScriptRoot ("EncryptionSamples-" + $env:COMPUTERNAME + "-" + $stamp + ".csv")
$L = New-Object System.Collections.Generic.List[string]
function W { param($t="") $L.Add([string]$t); Write-Host $t }

W "================================================================"
W " ENCRYPTION PROFILE AND TIMING -- ALL FIXED DRIVES (read-only)"
W " Computer : $env:COMPUTERNAME"
W " Run date : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
W " Checker  : Measure-Encryption-2026-08-02 (rev 2 -- multi-drive)"
W "================================================================"
W ""

# ---------------------------------------------------------------- helpers --
function Get-FixedVolumes {
    # Every FIXED volume with a drive letter. Removable/USB excluded on
    # purpose -- see the header note.
    $out = @()
    try {
        foreach ($v in (Get-Volume -EA Stop | Where-Object { $_.DriveLetter -and $_.DriveType -eq 'Fixed' })) {
            $out += [PSCustomObject]@{
                Letter = [string]$v.DriveLetter
                Label  = [string]$v.FileSystemLabel
                SizeGB = [math]::Round($v.Size/1GB, 1)
                UsedGB = [math]::Round(($v.Size - $v.SizeRemaining)/1GB, 1)
            }
        }
    } catch {}
    return $out | Sort-Object Letter
}

function Get-VolState {
    param([string]$Letter)
    $r = [PSCustomObject]@{ Status="Unknown"; Percent=-1; Method=""; Source="" }
    try {
        $v = Get-BitLockerVolume -MountPoint ($Letter + ":") -EA Stop
        $r.Status  = [string]$v.VolumeStatus
        $r.Percent = [double]$v.EncryptionPercentage
        $r.Method  = [string]$v.EncryptionMethod
        $r.Source  = "Get-BitLockerVolume"
        return $r
    } catch {}
    try {
        # VERIFIED 2026-08-02 measured on CGDELL: `manage-bde.exe -status C:`
        #   returns "Conversion Status: Fully Encrypted", "Percentage
        #   Encrypted: 100.0%", "Encryption Method: XTS-AES 128". Present on
        #   Windows 11 Home as well as Pro, which is why it is the fallback.
        #   -status is read-only; it reports and changes nothing.
        $o = & manage-bde.exe -status ($Letter + ":") 2>&1 | Out-String
        if ($o -match "Percentage Encrypted:\s*([0-9.]+)") { $r.Percent = [double]$Matches[1] }
        if ($o -match "Conversion Status:\s*(.+)")        { $r.Status  = $Matches[1].Trim() }
        if ($o -match "Encryption Method:\s*(.+)")        { $r.Method  = $Matches[1].Trim() }
        $r.Source = "manage-bde"
    } catch {}
    return $r
}

# ---------------------------------------------------------------- profile --
$vols = @(Get-FixedVolumes)
W ("FIXED DRIVES FOUND: {0}" -f $vols.Count)
if ($vols.Count -eq 0) { W "  none -- cannot proceed."; $L -join "`r`n" | Out-File $outTxt -Encoding UTF8; return }
W ""

foreach ($v in $vols) {
    W ("--- {0}: {1} ---" -f $v.Letter, $(if ($v.Label) { $v.Label } else { "(no label)" }))
    W ("  size / used         : {0} GB / {1} GB  ({2:N0}% full)" -f $v.SizeGB, $v.UsedGB, $(if ($v.SizeGB) { $v.UsedGB/$v.SizeGB*100 } else { 0 }))
    # FT-163: resolve the disk that actually hosts THIS volume.
    try {
        $part = Get-Partition -DriveLetter $v.Letter -EA Stop
        $disk = Get-Disk -Number $part.DiskNumber -EA Stop
        $pd   = Get-PhysicalDisk | Where-Object { $_.DeviceId -eq [string]$disk.Number } | Select-Object -First 1
        W ("  disk number         : {0}" -f $part.DiskNumber)
        W ("  drive model         : {0}" -f $pd.FriendlyName)
        W ("  media type / bus    : {0} / {1}" -f $pd.MediaType, $pd.BusType)
        W ("  physical size       : {0:N0} GB" -f ($pd.Size/1GB))
    } catch { W ("  disk                : could not resolve ({0})" -f $_) }
    $st = Get-VolState -Letter $v.Letter
    W ("  encryption status   : {0}" -f $st.Status)
    W ("  percent encrypted   : {0}" -f $st.Percent)
    W ("  method              : {0}" -f $st.Method)
    W ("  read via            : {0}" -f $st.Source)
    W ""
}

# --- WILL THIS BE USED-SPACE-ONLY, OR FULL DISK? -------------------------
# This single fact decides the duration, and it is decided by the HARDWARE.
# SOURCED (Microsoft Learn, "BitLocker drive encryption in Windows 11 for
# OEMs"): when BitLocker is enabled SILENTLY -- which is what Device
# Encryption does on Home -- Windows uses USED-SPACE-ONLY on modern standby
# devices and FULL DISK on non-modern-standby devices.
#
# The difference is not marginal. On SANDY's 1 TB D: with 79 GB used, that is
# 79 GB of work versus roughly 931 GB -- about twelvefold.
#
# VERIFIED 2026-08-02 measured on CGDELL: `powercfg.exe /a` prints "The
#   following sleep states are available on this system:" followed by
#   "Standby (S0 Low Power Idle) Network Connected" on a modern standby
#   machine, and lists S1/S2/S3 as unavailable. /a is read-only -- it reports
#   available sleep states and changes nothing.
W ""
W "ENCRYPTION MODE PREDICTION"
try {
    $pcfg = & powercfg.exe /a 2>&1 | Out-String
    if ($pcfg -match "Standby \(S0 Low Power Idle\)") {
        W "  sleep support       : Modern Standby (S0 Low Power Idle)"
        W "  predicted mode      : USED-SPACE-ONLY -- only the space in use is encrypted"
        W "  => estimate the time from the USED figures above, not the volume sizes."
    } elseif ($pcfg -match "(?m)^\s*Standby \(S3\)\s*$") {
        W "  sleep support       : S3 (not Modern Standby)"
        W "  predicted mode      : *** FULL DISK -- the WHOLE volume is encrypted ***"
        W "  => estimate the time from the VOLUME sizes above, not the used figures."
        W "  => On a large, mostly-empty drive this is dramatically longer."
    } else {
        W "  sleep support       : could not classify from powercfg output"
        W "  predicted mode      : unknown -- treat the volume size as the work to do"
    }
} catch { W ("  powercfg unavailable: {0}" -f $_) }
W ""

try {
    $cpu = Get-CimInstance Win32_Processor -EA Stop | Select-Object -First 1
    W ("CPU  : {0}  ({1} cores / {2} threads)" -f $cpu.Name.Trim(), $cpu.NumberOfCores, $cpu.NumberOfLogicalProcessors)
} catch {}
try { W ("RAM  : {0:N0} GB" -f ((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB)) } catch {}
try { W ("Edition: {0}" -f (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').EditionID) } catch {}
W ""

# ------------------------------------------------------------- converting? --
$states = @{}
foreach ($v in $vols) { $states[$v.Letter] = Get-VolState -Letter $v.Letter }
$converting = @($vols | Where-Object { $states[$_.Letter].Status -match "InProgress|in Progress|Encrypting|Decrypting" })

if ($converting.Count -eq 0) {
    W "NOT CONVERTING RIGHT NOW -- profile captured, nothing to time."
    W ""
    $enc  = @($vols | Where-Object { $states[$_.Letter].Percent -ge 100 })
    $bare = @($vols | Where-Object { $states[$_.Letter].Percent -lt 100 })
    W ("  encrypted     : {0}" -f $(if ($enc.Count)  { ($enc  | ForEach-Object { $_.Letter + ":" }) -join " " } else { "none" }))
    W ("  NOT encrypted : {0}" -f $(if ($bare.Count) { ($bare | ForEach-Object { $_.Letter + ":" }) -join " " } else { "none" }))
    W ""
    if ($bare.Count -and $enc.Count) {
        W "  *** FT-167: this machine is PARTIALLY encrypted. Checkup reads only ***"
        W "  *** the system drive, so item 8 would report ENCRYPTED -- GOOD and  ***"
        W "  *** say nothing about the drive(s) listed as NOT encrypted above.   ***"
        W ""
    }
    if ($enc.Count -eq $vols.Count) {
        W "  All fixed drives are encrypted. Their ORIGINAL durations cannot be"
        W "  recovered -- Windows keeps no start/complete event and the BitLocker"
        W "  Operational log ships disabled. This profile is still a useful"
        W "  baseline row for the timing model."
    } else {
        W "  To capture a real timing, START THIS SCRIPT FIRST, leave it running,"
        W "  then turn encryption on. It samples every $IntervalSeconds seconds."
    }
} else {
    W ("SAMPLING {0} drive(s) every {1}s (max {2}h). Leave this window open." -f $converting.Count, $IntervalSeconds, $MaxHours)
    W ("Converting now: {0}" -f (($converting | ForEach-Object { $_.Letter + ":" }) -join " "))
    W "Press Ctrl+C to stop early -- samples already written are kept."
    W ""
    "Timestamp,ElapsedMin,Drive,Percent,PercentPerMin,GBDone,ProjectedTotalMin,ProjectedFinish" | Out-File -FilePath $outCsv -Encoding UTF8
    $t0 = Get-Date
    $p0 = @{}; foreach ($v in $converting) { $p0[$v.Letter] = $states[$v.Letter].Percent }
    $done = @{}
    $deadline = $t0.AddHours($MaxHours)

    while ((Get-Date) -lt $deadline) {
        Start-Sleep -Seconds $IntervalSeconds
        $now = Get-Date
        $elapsed = ($now - $t0).TotalMinutes
        $allDone = $true
        foreach ($v in $converting) {
            $ltr = $v.Letter
            if ($done.ContainsKey($ltr)) { continue }
            $s = Get-VolState -Letter $ltr
            $delta = $s.Percent - $p0[$ltr]
            $rate  = if ($elapsed -gt 0) { $delta / $elapsed } else { 0 }
            $gb    = [math]::Round($v.SizeGB * $s.Percent / 100, 1)
            $proj  = if ($rate -gt 0) { [math]::Round((100 - $p0[$ltr]) / $rate, 0) } else { 0 }
            $fin   = if ($rate -gt 0) { $t0.AddMinutes($proj).ToString("yyyy-MM-dd HH:mm") } else { "unknown" }
            ("{0},{1:N1},{2},{3:N1},{4:N3},{5},{6},{7}" -f $now.ToString("yyyy-MM-dd HH:mm:ss"), $elapsed, $ltr, $s.Percent, $rate, $gb, $proj, $fin) |
                Out-File -FilePath $outCsv -Append -Encoding UTF8
            Write-Host ("  {0}  {1}:  {2,5:N1}%  ({3:N2}%/min)  ~{4} GB  finish ~{5}" -f `
                $now.ToString("HH:mm:ss"), $ltr, $s.Percent, $rate, $gb, $fin) -ForegroundColor Cyan
            if ($s.Percent -ge 100 -or $s.Status -match "FullyEncrypted|Fully Encrypted") {
                $mins = [math]::Round($elapsed, 1)
                $done[$ltr] = $mins
                W ""
                W ("  *** {0}: COMPLETE in {1} minutes ({2:N2} hours) ***" -f $ltr, $mins, ($mins/60))
                W ("      {0} GB volume / {1} GB used" -f $v.SizeGB, $v.UsedGB)
                if ($mins -gt 0) {
                    W ("      throughput: {0:N2} GB/min on used, {1:N2} GB/min on volume" -f ($v.UsedGB/$mins), ($v.SizeGB/$mins))
                }
                W ""
            } else { $allDone = $false }
        }
        if ($allDone) { break }
    }

    W "================================================================"
    W " RESULT -- THE NUMBERS THIS PROJECT HAS NEVER HAD"
    W "================================================================"
    foreach ($v in $converting) {
        $ltr = $v.Letter
        if ($done.ContainsKey($ltr)) {
            W ("  {0}:  {1} minutes  ({2:N2} h)  for {3} GB volume / {4} GB used" -f $ltr, $done[$ltr], ($done[$ltr]/60), $v.SizeGB, $v.UsedGB)
        } else {
            W ("  {0}:  did not finish within the sampling window -- see the CSV" -f $ltr)
        }
    }
    W ""
    W "  Put these rows in the TestHistory. Two or three and the BitLocker"
    W "  screen can quote a measured range instead of a guess."
}

W ""
W "  Samples CSV : $outCsv"
W "================================================================"
$L -join "`r`n" | Out-File -FilePath $outTxt -Encoding UTF8
Write-Host ""
Write-Host "  Profile saved to: $outTxt" -ForegroundColor Gray
Write-Host "  Read-only: nothing was created, changed or deleted." -ForegroundColor Gray
