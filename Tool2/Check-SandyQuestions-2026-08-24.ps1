# FILE:    Check-SandyQuestions-2026-08-24.ps1
# Dated:   2026-08-24 11:05 ET
# PURPOSE: Collect, in one pass, every open measurement that needs SANDY.
#
# READ-ONLY. This script changes NOTHING. It reads state and writes one
# report file. Safe to run on a machine you are about to field-test.
#
# Runs fine WITHOUT administrator. Three checks need admin and say so
# rather than failing silently. It does NOT self-elevate -- the
# Malwarebytes exploit-payload flag stands.
#
# WHY IT EXISTS: six questions accumulated across Q7, items 14, 15 and 20,
# and Cloud handed back four more on Widgets. All need the same machine and
# the same trip. Six lookups and a second visit is how a measurement gets
# skipped.
#
# ORDER MATTERS ON SANDY AND THIS SCRIPT DOES NOT ENFORCE IT:
#   1. ascii43 field run          <- needs the machine as it is
#   2. F4 full scan covering D:   <- needs the second drive
#   3. THIS SCRIPT                <- read-only, changes nothing
#   4. Only then encrypt          <- ends the starting condition for good
# Steps 1-3 are all non-destructive. Step 4 is not, and cannot be undone
# for testing purposes: SANDY is the only unencrypted machine here.

$ErrorActionPreference = "Continue"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Machine   = $env:COMPUTERNAME
$Stamp     = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ReportDir = Join-Path (Split-Path -Parent $ScriptDir) "Test_Results"
$Report    = Join-Path $ReportDir "SandyChecks-$Machine-$Stamp.txt"

$L = New-Object System.Collections.Generic.List[string]
function Say([string]$t = "") { $L.Add($t); Write-Host $t }
function Head([string]$t) { Say ""; Say ("-" * 70); Say "  $t"; Say ("-" * 70) }
function Val([string]$k, $v) { Say ("    {0,-38} {1}" -f $k, $(if ($null -eq $v -or "$v" -eq "") { "<absent>" } else { $v })) }

$identity  = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($identity)
$isAdmin   = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

Say ("=" * 70)
Say "  SANDY QUESTIONS -- one pass, read-only"
Say ("=" * 70)
Say "  machine   : $Machine"
Say "  run at    : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Say "  elevated  : $isAdmin"
if (-not $isAdmin) {
    Say ""
    Say "  NOT ELEVATED. Checks 3, 4 and 6 may come back blank."
    Say "  That is fine for a first pass. To get everything, close this and"
    Say "  right-click Run-SandyChecks.bat > Run as administrator."
}

# ---- machine identity, needed to read every answer below ----
Head "0. WHAT MACHINE IS THIS"
$os = Get-CimInstance Win32_OperatingSystem
$ubr = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -EA SilentlyContinue).UBR
Val "edition" $os.Caption
Val "build" "$($os.BuildNumber).$ubr"
Val "display version" (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -EA SilentlyContinue).DisplayVersion
$u = Get-CimInstance Win32_UserAccount -Filter "Name='$env:USERNAME' AND LocalAccount=True" -EA SilentlyContinue
Val "current user is a LOCAL account" $(if ($u) { "YES -- $($u.Name)" } else { "NO -- Microsoft or domain account" })

# ---- 1. Q7 : Device Encryption on Home + a local account ----
Head "1. Q7 -- CAN THIS MACHINE ENCRYPT? (Device Encryption / BitLocker)"
Say "    Question: on Home with a local account, is encryption even offered?"
Say ""
try {
    $tpm = Get-Tpm -EA Stop
    Val "TPM present / ready / enabled" "$($tpm.TpmPresent) / $($tpm.TpmReady) / $($tpm.TpmEnabled)"
} catch { Val "TPM" "could not read (needs admin)" }
Val "PreventDeviceEncryption" (Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\BitLocker' -Name PreventDeviceEncryption -EA SilentlyContinue).PreventDeviceEncryption
try {
    foreach ($v in (Get-BitLockerVolume -EA Stop)) {
        $prot = ($v.KeyProtector | ForEach-Object { $_.KeyProtectorType }) -join ', '
        Val "$($v.MountPoint) status" "$($v.VolumeStatus) / protection $($v.ProtectionStatus) / $($v.EncryptionPercentage)%"
        Val "$($v.MountPoint) key protectors" $(if ($prot) { $prot } else { "NONE" })
    }
} catch { Val "Get-BitLockerVolume" "failed -- $($_.Exception.Message)" }
Say ""
Say "    >> LOOK WITH YOUR EYES, AND WRITE THE ANSWER ON THIS SHEET:"
Say "       Settings > Privacy & security."
Say "       Is there a 'Device encryption' entry?   YES / NO  ..............."
Say "       (If yes, is the toggle On or Off?       ON / OFF ...............)"

# ---- 2 and 3. Item 15 : phishing protection on Home ----
Head "2 + 3. ITEM 15 -- DOES PHISHING PROTECTION EXIST ON THIS MACHINE?"
Say "    Question: Microsoft's edition table does not list Home. Checkup"
Say "    applies setting 6 on Home anyway (SkipOnHome is false)."
Say ""
$wtds = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components"
try {
    $w = Get-ItemProperty $wtds -EA Stop
    Say "    WTDS\Components READ OK:"
    foreach ($n in 'NotifyMalicious','NotifyPasswordReuse','NotifyUnsafeApp','ServiceEnabled','CaptureThreatWindow') {
        Val "  $n" $w.$n
    }
} catch {
    Val "WTDS\Components" "CANNOT READ -- $($_.Exception.Message.Split([char]10)[0])"
    Say "    (On CGDELL this refuses even when elevated. If it also refuses"
    Say "     here, Checkup's setting 6 cannot apply on either machine.)"
}
Val "Smart App Control (VerifiedAndReputablePolicyState)" (Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\CI\Policy' -Name VerifiedAndReputablePolicyState -EA SilentlyContinue).VerifiedAndReputablePolicyState
Say ""
Say "    >> LOOK WITH YOUR EYES, AND WRITE THE ANSWER:"
Say "       Windows Security > App & browser control."
Say "       Is there a 'Phishing protection' section?    YES / NO ..........."
Say "       If yes, how many checkboxes under it?        3 / 4  ..........."
Say "       Is its main toggle On or Off?                ON / OFF .........."

# ---- 4. Item 20 : the Realtek adapter and its property names ----
Head "4. ITEM 20 -- WAKE ON LAN ON EVERY ADAPTER, INCLUDING DISABLED ONES"
Say "    Measured on CGDELL: a DISABLED adapter can still be read and written."
Say "    So 'it was disabled' does not explain the SANDY miss. The likely"
Say "    cause is the Realtek driver using different property names."
Say ""
foreach ($a in (Get-NetAdapter -Physical -EA SilentlyContinue | Sort-Object Name)) {
    Say "    ADAPTER: $($a.Name)"
    Val "  description" $a.InterfaceDescription
    Val "  status / admin" "$($a.Status) / $($a.AdminStatus)"
    $pm = Get-NetAdapterPowerManagement -Name $a.Name -EA SilentlyContinue
    if ($pm) { Val "  PowerManagement" "MagicPacket=$($pm.WakeOnMagicPacket)  Pattern=$($pm.WakeOnPattern)" }
    else     { Val "  PowerManagement" "no power management section" }
    $props = Get-NetAdapterAdvancedProperty -Name $a.Name -EA SilentlyContinue |
             Where-Object { $_.DisplayName -match 'Wake|WOL|Magic|Shutdown' }
    if ($props) {
        foreach ($p in $props) { Val "  [advanced] $($p.DisplayName)" $p.DisplayValue }
    } else {
        Val "  [advanced] wake-related properties" "NONE FOUND <- this is the answer if Realtek"
    }
    Say ""
}

# ---- 5. Item 14 : periodic scanning ----
Head "5. ITEM 14 -- IS THE PERIODIC SCANNING TOGGLE EVEN PRESENT?"
Say "    Expected: absent, because Defender is primary here. It only appears"
Say "    when another antivirus runs its own real-time protection."
Say ""
try {
    $s = Get-MpComputerStatus -EA Stop
    Val "AMRunningMode" $s.AMRunningMode
    Val "RealTimeProtectionEnabled" $s.RealTimeProtectionEnabled
    Val "IsTamperProtected" $s.IsTamperProtected
} catch { Val "Get-MpComputerStatus" "failed -- needs admin?" }
Val "PassiveMode" (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows Defender' -Name PassiveMode -EA SilentlyContinue).PassiveMode
Say "    Registered antivirus products:"
$avs = Get-CimInstance -Namespace root\SecurityCenter2 -ClassName AntiVirusProduct -EA SilentlyContinue
if ($avs) { foreach ($av in $avs) { Val "  $($av.displayName)" ("state 0x{0:X6}" -f $av.productState) } }
else { Val "  (none readable)" "" }

# ---- 6. Q8 : update pause ----
Head "6. Q8 -- ARE UPDATES PAUSED ON THIS MACHINE?"
Say "    CGDELL is paused 2026-08-01 to 2026-09-06. Launch is 2026-09-01."
Say ""
$ux = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
foreach ($n in 'PauseUpdatesStartTime','PauseUpdatesExpiryTime','PauseFeatureUpdatesEndTime','PauseQualityUpdatesEndTime') {
    Val $n (Get-ItemProperty $ux -Name $n -EA SilentlyContinue).$n
}
Say "    Advanced options, the three toggles:"
Val "  Get me up to date" (Get-ItemProperty $ux -Name IsContinuousInnovationOptedIn -EA SilentlyContinue).IsContinuousInnovationOptedIn
Val "  Download over metered connections" (Get-ItemProperty $ux -Name AllowAutoWindowsUpdateDownloadOverMeteredNetwork -EA SilentlyContinue).AllowAutoWindowsUpdateDownloadOverMeteredNetwork
Val "  Notify when a restart is required" (Get-ItemProperty $ux -Name RestartNotificationsAllowed2 -EA SilentlyContinue).RestartNotificationsAllowed2
Val "  Receive updates for other MS products" (Get-ItemProperty $ux -Name AllowMUUpdateService -EA SilentlyContinue).AllowMUUpdateService

# ---- 7. Cloud's Widgets measurements -- same trip, so same script ----
Head "7. CLOUD'S WIDGETS QUESTIONS (M-2 to M-5) -- SAME TRIP"
Say "    Not part of the original six. Included because they need this"
Say "    machine and it would be a wasted journey to come back for them."
Say ""
Val "Widgets taskbar button (TaskbarDa)" (Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarDa -EA SilentlyContinue).TaskbarDa
Say "    (1 = button shown, 0 = hidden)"
Say ""
Say "    M-2 -- are the processes actually running right now?"
foreach ($pn in 'Widgets','msedgewebview2','WidgetService') {
    $procs = @(Get-Process -Name $pn -EA SilentlyContinue)
    Val "  $pn" $(if ($procs.Count) { "$($procs.Count) running" } else { "not running" })
}
Say ""
Say "    M-3 -- lock screen widgets"
Val "  LockScreenWidgetsEnabled" (Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Lock Screen' -Name LockScreenWidgetsEnabled -EA SilentlyContinue).LockScreenWidgetsEnabled
Say ""
Say "    >> LOOK WITH YOUR EYES, AND WRITE THE ANSWER:"
Say "       M-3  Settings > Personalization > Lock screen."
Say "            Is there a 'Widgets' section?   YES / NO ................"
Say "            Its exact on-screen label: ............................."
Say "       M-4  Open the Widgets board. Is there a Dashboards or Discover"
Say "            control in its settings?        YES / NO ................"
Say "       M-5  Does the board open when you HOVER the taskbar button,"
Say "            without clicking?               YES / NO ................"

# ---- close ----
Say ""
Say ("=" * 70)
Say "  DONE -- nothing on this machine was changed."
Say ("=" * 70)
Say ""
Say "  Six checks answered from the registry and the system. Five more need"
Say "  your eyes -- they are the lines with dots to write on."
Say ""
Say "  Print this file, or just tell Claude Code the answers to the"
Say "  eye-checks and it will fold them in."
Say ""

if (-not (Test-Path $ReportDir)) { New-Item -Path $ReportDir -ItemType Directory -Force | Out-Null }
$L -join "`r`n" | Out-File -FilePath $Report -Encoding UTF8
Write-Host "  Report written: $Report"
Write-Host ""
