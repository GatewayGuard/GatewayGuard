# Dated: 2026-07-29 19:10 EDT
# ================================================================
# FILE:    Check-HomeEdition-2026-07-29.ps1
# PURPOSE: Answer, in about two minutes, the detection questions that have
#          been open for four builds because no Windows 11 HOME machine has
#          ever run Checkup.
#
# WHY THIS EXISTS: FT-115 (Memory Integrity reporting "Unknown") and the whole
# Home branch have been unverifiable since ascii34. A full field run on Sandy3
# would cost an evening; every question below is a READ, so it costs minutes.
#
# THIS SCRIPT CHANGES NO SETTING ON THIS PC. There is no Set-, New-,
# Remove-, Enable- or Disable- call against any system setting anywhere in
# it, and a build-time check enforces that.
# It does write two FILES, and neither is a system change: its own
# transcript next to itself, and a temporary msinfo32 report in %TEMP%
# which it deletes again. Said precisely rather than claiming 'changes
# nothing', because a header that is almost true is worse than one that
# is exact -- you are about to run this on a machine you care about.
#
# IT REPORTS FAILURES INSTEAD OF HIDING THEM. Every probe catches its own
# exception and prints the exception TYPE and MESSAGE, because on several of
# these questions "what does it throw" IS the answer -- that is the whole of
# finding 3.8 (Get-MpPreference throwing 0x800106ba on a stopped-Defender
# machine while -EA SilentlyContinue turns it into a silent wrong answer).
#
# PRIVACY: the Edge section reads THREE named settings from Edge's Preferences
# file and nothing else. It does not read history, passwords, or browsing data.
#
# HOW TO RUN -- right-click PowerShell, Run as administrator, then:
#   powershell -NoProfile -ExecutionPolicy Bypass -File .\Check-HomeEdition-2026-07-29.ps1
# It works without admin, but several probes will report "needs admin" instead
# of an answer. Admin gives the complete picture.
#
# It writes a transcript next to itself. Send me that file.
# ================================================================

$ErrorActionPreference = "Continue"
$out = New-Object System.Collections.ArrayList

function Say {
    param([string]$Text, [System.ConsoleColor]$Color = "Gray")
    Write-Host $Text -ForegroundColor $Color
    $null = $out.Add($Text)
}
function Section { param([string]$Title) Say ""; Say ("=" * 68) "Cyan"; Say $Title "Cyan"; Say ("=" * 68) "Cyan" }
function Probe {
    # Runs a read and reports the value, or the exception if it throws.
    param([string]$Label, [scriptblock]$Block)
    try {
        $v = & $Block
        if ($null -eq $v -or ($v -is [string] -and $v -eq "")) { Say ("  {0,-42} : <null / empty>" -f $Label) "Yellow" }
        else { Say ("  {0,-42} : {1}" -f $Label, ($v -join ", ")) }
    } catch {
        Say ("  {0,-42} : THREW {1}" -f $Label, $_.Exception.GetType().Name) "Red"
        Say ("  {0,-42}   {1}" -f "", $_.Exception.Message) "Red"
    }
}

$isAdmin = $false
try {
    $isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
              ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
} catch {}

Clear-Host
Section "GATEWAYGUARD CHECKUP -- HOME EDITION DIAGNOSTIC (read-only)"
Say ("  Run date        : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Say ("  Computer        : " + $env:COMPUTERNAME)
Say ("  Running as admin: " + $isAdmin) $(if ($isAdmin) { "Green" } else { "Yellow" })
if (-not $isAdmin) { Say "  NOTE: several probes below will report 'needs admin' instead of a value." "Yellow" }

# ---------------------------------------------------------------- A. identity
Section "A. MACHINE IDENTITY (for the test record)"
Probe "Make"                { (Get-CimInstance Win32_ComputerSystem -EA Stop).Manufacturer }
Probe "Model"               { (Get-CimInstance Win32_ComputerSystem -EA Stop).Model }
Probe "RAM (GB)"            { [math]::Round((Get-CimInstance Win32_ComputerSystem -EA Stop).TotalPhysicalMemory / 1GB, 0) }
Probe "Windows caption"     { (Get-CimInstance Win32_OperatingSystem -EA Stop).Caption }
Probe "Windows build"       { (Get-CimInstance Win32_OperatingSystem -EA Stop).BuildNumber }
Probe "OperatingSystemSKU"  { (Get-CimInstance Win32_OperatingSystem -EA Stop).OperatingSystemSKU }
Probe "Edition (registry)"  { (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -EA Stop).EditionID }
Say ""
Say "  Checkup decides Home vs Pro with this test:" "DarkGray"
Probe "  -notmatch Pro|Enterprise|Education = HOME" {
    $ed = (Get-CimInstance Win32_OperatingSystem -EA Stop).Caption
    if ($ed -notmatch "Pro|Enterprise|Education|Business") { "TRUE -- treated as HOME" } else { "FALSE -- treated as PRO" }
}

# ------------------------------------------------------- B. FT-115 mem integrity
Section "B. FT-115 -- MEMORY INTEGRITY (the four-build-old question)"
Say "  Checkup tries Win32_DeviceGuard first, then the registry, then gives up" "DarkGray"
Say "  and reports 'Unknown'. We need to see which step fails here." "DarkGray"
Say ""
Probe "DeviceGuard class reachable"      { if (Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard -EA Stop) { "yes" } }
Probe "SecurityServicesConfigured"       { (Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard -EA Stop).SecurityServicesConfigured }
Probe "SecurityServicesRunning"          { (Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard -EA Stop).SecurityServicesRunning }
Probe "  -> contains 2 (Checkup's test)" {
    $r = (Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard -EA Stop).SecurityServicesRunning
    if ($r -contains 2) { "YES -> would report 'ON -- GOOD'" } else { "NO -> would report 'OFF -- needs attention'" }
}
Probe "VBS status (0=off 1=enabled 2=running)" { (Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard -EA Stop).VirtualizationBasedSecurityStatus }
Say ""
Probe "HVCI registry Enabled" { (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -EA Stop).Enabled }
Probe "HVCI registry WasEnabledBy" { (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -EA Stop).WasEnabledBy }
Say ""
Say "  WHAT TO COMPARE: what does Windows Security itself show under" "Yellow"
Say "  Device security > Core isolation > Memory integrity? On/Off/not present?" "Yellow"
Say "  If the screen says On but both probes above fail, that is FT-115 exactly." "Yellow"

# ----------------------------------------------------- C. FT-105 tamper protection
Section "C. FT-105 -- TAMPER PROTECTION (never verified on Home)"
Probe "IsTamperProtected (Checkup's method)" { (Get-MpComputerStatus -EA Stop).IsTamperProtected }
Probe "Registry TamperProtection"            { (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows Defender\Features" -EA Stop).TamperProtection }

# --------------------------------------------------------- D. finding 3.8 Defender
Section "D. FINDING 3.8 -- DOES Get-MpPreference THROW HERE?"
Say "  On a machine with Defender stopped this throws 0x800106ba, and every" "DarkGray"
Say "  call wrapped in -EA SilentlyContinue then produces a silent wrong" "DarkGray"
Say "  answer. This is a Class 1 risk we have never been able to test." "DarkGray"
Say ""
Probe "Get-MpComputerStatus reachable"   { if (Get-MpComputerStatus -EA Stop) { "yes" } }
Probe "AMRunningMode"                    { (Get-MpComputerStatus -EA Stop).AMRunningMode }
Probe "RealTimeProtectionEnabled"        { (Get-MpComputerStatus -EA Stop).RealTimeProtectionEnabled }
Probe "AntivirusEnabled"                 { (Get-MpComputerStatus -EA Stop).AntivirusEnabled }
Probe "Get-MpPreference reachable"       { if (Get-MpPreference -EA Stop) { "yes -- does NOT throw here" } }
Probe "DisableRealtimeMonitoring"        { (Get-MpPreference -EA Stop).DisableRealtimeMonitoring }
Probe "Defender service (WinDefend)"     { (Get-Service WinDefend -EA Stop).Status }

# ------------------------------------------------- E. Home BitLocker / FT-110/108
Section "E. HOME ENCRYPTION -- FT-110 and FT-108"
Say "  FT-110 is the Home BitLocker ENABLE path: Enable-BitLocker is a Pro-only" "DarkGray"
Say "  cmdlet and threw 0x8031005A on Home in ascii33. Which half of FT-110 this" "DarkGray"
Say "  machine can test depends entirely on whether it is ALREADY encrypted, so" "DarkGray"
Say "  that is measured below rather than assumed." "DarkGray"
Say ""
if (-not $isAdmin) {
    Say "  SKIPPED -- needs admin. Re-run as administrator for this section." "Yellow"
} else {
    Probe "Get-BitLockerVolume C: available" { if (Get-BitLockerVolume -MountPoint C: -EA Stop) { "yes (cmdlet present on Home)" } }
    Probe "ProtectionStatus"                 { (Get-BitLockerVolume -MountPoint C: -EA Stop).ProtectionStatus }
    Probe "VolumeStatus"                     { (Get-BitLockerVolume -MountPoint C: -EA Stop).VolumeStatus }
    Probe "EncryptionMethod"                 { (Get-BitLockerVolume -MountPoint C: -EA Stop).EncryptionMethod }
    Probe "KeyProtector types present"       { (Get-BitLockerVolume -MountPoint C: -EA Stop).KeyProtector | ForEach-Object { $_.KeyProtectorType } }
    Say ""
    Say "  manage-bde -status C: (raw, stderr captured):" "DarkGray"
    try {
        $mb = & manage-bde -status C: 2>&1
        foreach ($l in $mb) { Say ("    " + $l) }
    } catch { Say ("    THREW " + $_.Exception.Message) "Red" }
}
Say ""
Probe "TPM present"      { (Get-CimInstance -Namespace root\cimv2\Security\MicrosoftTpm -ClassName Win32_Tpm -EA Stop).IsEnabled_InitialValue }
Probe "Secure Boot"      { Confirm-SecureBootUEFI }
Say ""
Say "  WHAT THIS MACHINE CAN TEST FOR FT-110 -- derived from the state above:" "White"
try {
    $ggEnc = "unknown"
    try { $ggEnc = [string](Get-BitLockerVolume -MountPoint C: -EA Stop).VolumeStatus } catch {}
    $ggHome = ((Get-CimInstance Win32_OperatingSystem -EA SilentlyContinue).Caption -notmatch "Pro|Enterprise|Education|Business")
    Say ("    Edition treated as : " + $(if ($ggHome) { "HOME" } else { "PRO" }))
    Say ("    Volume status      : " + $ggEnc)
    if (-not $ggHome) {
        Say "    -> PRO. Cannot test FT-110 at all; FT-110 is Home-only logic." "Yellow"
    } elseif ($ggEnc -match "FullyEncrypted|EncryptionInProgress") {
        Say "    -> HOME and ALREADY ENCRYPTED. This machine takes the" "Yellow"
        Say "       already-encrypted branch and never reaches the enable code, so" "Yellow"
        Say "       it CANNOT clear FT-110. It CAN test the already-encrypted HOME" "Yellow"
        Say "       path and the recovery-key location, which no machine has done." "Yellow"
    } elseif ($ggEnc -match "FullyDecrypted") {
        Say "    -> HOME and NOT ENCRYPTED. THIS IS THE FT-110 MACHINE." "Green"
        Say "       It is the only state that reaches the enable path. Run Checkup" "Green"
        Say "       to the BitLocker screen and confirm: Enable-BitLocker is NEVER" "Green"
        Say "       called, 0x8031005A NEVER appears, the three prerequisites are" "Green"
        Say "       shown (TPM, Secure Boot, WinRE), and the screen tells you to" "Green"
        Say "       sign in with a Microsoft account. Then verify the key actually" "Green"
        Say "       lands at account.microsoft.com/devices/recoverykey." "Green"
    } else {
        Say ("    -> could not determine encryption state (" + $ggEnc + ")." ) "Yellow"
    }
} catch { Say ("    could not derive: " + $_.Exception.Message) "Red" }
Say ""
Say "  SAFETY, BEFORE ANY SECURE BOOT CHANGE ON AN ENCRYPTED MACHINE:" "Red"
Say "  Secure Boot state is one of the measurements the TPM seals against." "Red"
Say "  Turning it on can make the TPM refuse to release the key on next boot," "Red"
Say "  leaving a 48-digit recovery prompt. Retrieve and store the recovery key" "Red"
Say "  OFF this machine first. Recovery key first, Secure Boot second, always." "Red"
Say ""
Say "  ALSO CHECK BY HAND: Settings > Privacy & security > Device encryption." "Yellow"
Say "  Is that page present at all, and what does it say? And does the key" "Yellow"
Say "  appear at account.microsoft.com/devices/recoverykey for this PC?" "Yellow"

# ----------------------------------------------- F. FT-123b items 13/14/15
Section "F. FT-123b -- WHAT ITEMS 13, 14 AND 15 SHOULD ACTUALLY READ"
Say "  ascii38 reports these as 'Unknown -- could not check' when the HKLM" "DarkGray"
Say "  policy key is absent, which is honest but unhelpful. To read the REAL" "DarkGray"
Say "  state we need a verified source, which is what this section gathers." "DarkGray"
Say ""
Say "  -- item 14, Widgets --"
Probe "HKLM policy AllowNewsAndInterests" { (Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -EA Stop).AllowNewsAndInterests }
Probe "HKCU Advanced TaskbarDa"           { (Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -EA Stop).TaskbarDa }
Say ""
Say "  -- items 13 and 15, Edge --"
Probe "HKLM policy StartupBoostEnabled"    { (Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -EA Stop).StartupBoostEnabled }
Probe "HKLM policy BackgroundModeEnabled"  { (Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -EA Stop).BackgroundModeEnabled }
Probe "HKLM policy PasswordManagerEnabled" { (Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -EA Stop).PasswordManagerEnabled }
Say ""
Say "  Edge Preferences file -- THREE named settings only, no browsing data:" "DarkGray"
$prefPath = Join-Path $env:LOCALAPPDATA "Microsoft\Edge\User Data\Default\Preferences"
if (-not (Test-Path $prefPath)) {
    Say "    Preferences file not found at the default profile path." "Yellow"
} else {
    try {
        $j = Get-Content $prefPath -Raw -EA Stop | ConvertFrom-Json
        Say ("    startup_boost_enabled     : " + $(if ($null -ne $j.startup_boost_enabled) { $j.startup_boost_enabled } else { "<not present>" }))
        Say ("    background_mode.enabled   : " + $(if ($null -ne $j.background_mode) { $j.background_mode.enabled } else { "<not present>" }))
        Say ("    credentials_enable_service: " + $(if ($null -ne $j.credentials_enable_service) { $j.credentials_enable_service } else { "<not present>" }))
    } catch {
        Say ("    Could not read/parse Preferences: " + $_.Exception.Message) "Red"
    }
}
Say ""
Say "  TELL ME what these three are actually set to in Edge's own settings," "Yellow"
Say "  so the file values can be matched to the real UI state before anything" "Yellow"
Say "  is coded against them (gate 13 needs that pairing, not a guess)." "Yellow"

# ------------------------------------------------------- G. FT-120 Wake on LAN
Section "G. FT-120 -- WAKE ON LAN ON THIS HARDWARE"
try {
    foreach ($a in @(Get-NetAdapter -Physical -EA Stop)) {
        Say ("  Adapter: " + $a.Name + "  [" + $a.Status + "]  " + $a.InterfaceDescription) "White"
        try {
            $props = @(Get-NetAdapterAdvancedProperty -Name $a.Name -EA Stop |
                Where-Object { $_.DisplayName -match 'Wake on Magic Packet|Wake on Pattern Match|Wake from S0ix' })
            if ($props.Count -eq 0) { Say "    (no wake properties exposed via AdvancedProperty)" "Yellow" }
            foreach ($p in $props) { Say ("    " + $p.DisplayName.PadRight(38) + " = " + $p.DisplayValue) }
        } catch { Say ("    AdvancedProperty THREW " + $_.Exception.GetType().Name + ": " + $_.Exception.Message) "Red" }
        try {
            $pm = Get-NetAdapterPowerManagement -Name $a.Name -EA Stop
            Say ("    PowerManagement WakeOnMagicPacket   = " + $pm.WakeOnMagicPacket)
            Say ("    PowerManagement WakeOnPattern       = " + $pm.WakeOnPattern)
        } catch { Say ("    PowerManagement THREW " + $_.Exception.GetType().Name) "Red" }
    }
} catch { Say ("  Get-NetAdapter THREW " + $_.Exception.Message) "Red" }

# ------------------------------------------------- H. finding 3.6 MB branch trace
Section "H. FINDING 3.6 -- ANTIVIRUS REGISTRATION (the MB branch bug)"
Say "  Checkup reported 'MALWAREBYTES NOT DETECTED' on a machine where MB was" "DarkGray"
Say "  installed and running. This is the raw data its branch logic reads." "DarkGray"
Say ""
try {
    $av = @(Get-CimInstance -Namespace root\SecurityCenter2 -ClassName AntiVirusProduct -EA Stop)
    if ($av.Count -eq 0) { Say "  SecurityCenter2 lists NO antivirus products." "Yellow" }
    foreach ($p in $av) {
        Say ("  displayName  : " + $p.displayName) "White"
        Say ("    productState (dec) : " + $p.productState)
        Say ("    productState (hex) : 0x" + ("{0:X6}" -f [int]$p.productState))
        Say ("    pathToSignedExe    : " + $p.pathToSignedProductExe)
    }
} catch { Say ("  SecurityCenter2 query THREW " + $_.Exception.Message) "Red" }
Say ""
Probe "Malwarebytes service (MBAMService)" { (Get-Service MBAMService -EA Stop).Status }
Probe "MB installed (registry uninstall)" {
    $k = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall","HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" -EA SilentlyContinue |
         ForEach-Object { Get-ItemProperty $_.PSPath -EA SilentlyContinue } |
         Where-Object { $_.DisplayName -match "Malwarebytes" }
    if ($k) { ($k | ForEach-Object { $_.DisplayName + " " + $_.DisplayVersion }) } else { "not found in uninstall keys" }
}

# ------------------------------------------- I. FT-141/FT-142 phishing protection
Section "I. FT-141 -- PHISHING PROTECTION (item 6): READ OR BLOCKED?"
Say "  Checkup reads this key with -EA SilentlyContinue. On the Dell the read" "DarkGray"
Say "  THROWS SecurityException because Tamper Protection blocks it, the null" "DarkGray"
Say "  falls through, and the tool reports 'Not configured -- all 3 need to be" "DarkGray"
Say "  enabled' -- a definite BAD from a check that never ran. Here the" "DarkGray"
Say "  exception is REPORTED, which is the whole point." "DarkGray"
Say ""
$wtds = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components"
try {
    $pp = Get-ItemProperty $wtds -EA Stop
    Say "  Key IS readable on this PC." "Green"
    Say ""
    Say "  Every value present under the key:" "White"
    $pp.PSObject.Properties | Where-Object { $_.Name -notmatch '^PS' } | Sort-Object Name |
        ForEach-Object { Say ("    {0,-28} = {1}" -f $_.Name, $_.Value) }
    Say ""
    Say "  What Checkup would report from these values:" "White"
    $svcOn = ($pp.ServiceEnabled -eq 1); $malOn = ($pp.NotifyMalicious -eq 1)
    $pwOn  = ($pp.NotifyPasswordReuse -eq 1); $appOn = ($pp.NotifyUnsafeApp -eq 1)
    if ($svcOn -and $malOn -and $pwOn -and $appOn) { Say "    'All 3 ON -- GOOD'" }
    elseif (-not $svcOn) { Say "    'Service OFF -- all 3 need attention'" }
    else {
        $m = @(); if (-not $malOn) { $m += "malicious sites" }
        if (-not $pwOn) { $m += "password reuse" }; if (-not $appOn) { $m += "unsafe apps" }
        Say ("    'Partial -- missing: " + ($m -join ", ") + "'")
    }
} catch [System.Security.SecurityException] {
    Say "  BLOCKED -- SecurityException: Tamper Protection is protecting this key." "Red"
    Say "  Checkup would swallow this and report 'Not configured' (FT-141)." "Red"
} catch {
    Say ("  Read failed: " + $_.Exception.GetType().Name + " -- " + $_.Exception.Message) "Red"
}
Say ""
Say "  FT-142 -- LABEL CHECK. Checkup calls the third toggle 'unsafe apps'." "Yellow"
Say "  On the Dell the actual on-screen label is 'Warn me about unsafe" "Yellow"
Say "  password storage'. Windows Security > App & browser control >" "Yellow"
Say "  Reputation-based protection > Phishing protection. WRITE DOWN the exact" "Yellow"
Say "  label of every toggle on that screen and whether each is On or Off --" "Yellow"
Say "  that pairing is what lets the registry values be mapped to the labels" "Yellow"
Say "  the user actually sees, which gate 13 requires before anything is coded." "Yellow"

# ------------------------------------ J. Memory integrity vs Kernel DMA Protection
Section "J. MEMORY INTEGRITY vs KERNEL DMA PROTECTION (two different things)"
Say "  These are SEPARATE features that sit next to each other on the Device" "DarkGray"
Say "  security page, and confusing them is easy:" "DarkGray"
Say "    Memory integrity      -- under Core isolation. Section B above." "DarkGray"
Say "    Kernel DMA Protection -- its own row. Blocks attacks through external" "DarkGray"
Say "                             plug-in ports. Often Off, or not shown." "DarkGray"
Say "  Read below from msinfo32's own fields -- the same authority the" "DarkGray"
Say "  BitLocker code already defers to for Device Encryption Support." "DarkGray"
Say ""
$rpt = Join-Path $env:TEMP ("ggmsinfo-" + (Get-Date -Format 'HHmmss') + ".txt")
try {
    Say "  Running msinfo32 (this takes 10-30 seconds)..." "Gray"
    Start-Process -FilePath "msinfo32.exe" -ArgumentList ("/report `"" + $rpt + "`"") -Wait -WindowStyle Hidden
    if (Test-Path $rpt) {
        $txt = Get-Content $rpt -EA Stop
        foreach ($field in 'Kernel DMA Protection', 'Device Encryption Support',
                           'Virtualization-based security', 'Secure Boot State',
                           'BIOS Mode', 'A hypervisor has been detected') {
            $line = $txt | Where-Object { $_ -match [regex]::Escape($field) } | Select-Object -First 1
            if ($line) { Say ("    " + $line.Trim()) }
            else { Say ("    {0,-32} : <not reported by msinfo32>" -f $field) "Yellow" }
        }
        Remove-Item $rpt -Force -EA SilentlyContinue
    } else {
        Say "    msinfo32 produced no report file." "Yellow"
    }
} catch {
    Say ("    msinfo32 failed: " + $_.Exception.Message) "Red"
    Say "    Check by hand: Windows key, type msinfo32, Enter. Look at the" "Yellow"
    Say "    System Summary list for 'Kernel DMA Protection'." "Yellow"
}
Say ""
Say "  COMPARE with Section B. If Memory integrity is ON there but the Device" "Yellow"
Say "  security page shows something Off, the Off row is almost certainly" "Yellow"
Say "  Kernel DMA Protection -- a different feature, not a Checkup fault." "Yellow"

# ------------------------------------------------------------------ write it out
Section "DONE -- NOTHING ON THIS PC WAS CHANGED"
$stamp = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$file  = Join-Path $PSScriptRoot ("HomeDiagnostic-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")
try {
    $out | Out-File -FilePath $file -Encoding UTF8
    Write-Host ""
    Write-Host ("  Saved to: " + $file) -ForegroundColor Green
    Write-Host "  Send me that file, plus your answers to the three YELLOW questions:" -ForegroundColor Green
    Write-Host "    1. What Windows Security shows for Memory integrity (section B)" -ForegroundColor Yellow
    Write-Host "    2. Whether Settings has a Device encryption page, and what it says (E)" -ForegroundColor Yellow
    Write-Host "    3. The real Edge settings for boost / background / password saving (F)" -ForegroundColor Yellow
    Write-Host "    4. The EXACT label and On/Off of every phishing toggle (section I)" -ForegroundColor Yellow
    Write-Host "    5. What the Device security page shows, row by row (section J)" -ForegroundColor Yellow
} catch {
    Write-Host ("  Could not save the transcript: " + $_.Exception.Message) -ForegroundColor Red
    Write-Host "  Copy the text above instead (Alt+Space, E, M to mark, Enter to copy)." -ForegroundColor Yellow
}
Write-Host ""
