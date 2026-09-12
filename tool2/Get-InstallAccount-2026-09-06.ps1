# =====================================================================
#  Get-InstallAccount-2026-09-06.ps1
#
#  ANSWERS BILL'S QUESTION 7: "Can you tell what account was active when
#  Windows was installed?" -- and, in the same pass, 7(a) "you need to know
#  if the drive is already encrypted."
#
#  READ-ONLY. It changes NOTHING. Every command below either reads the
#  registry, lists accounts, or asks Windows for a status. There is not one
#  Set-, New-, Remove- or Enable- anywhere in this file.
#
#  Does NOT need administrator for most of it. The BitLocker section needs
#  admin and says so plainly if it does not have it, rather than reporting
#  a blank as if it were an answer.
#
#  Output goes to a file in Test_Results\ so nothing is truncated on screen.
#
#  MEASURED ON CGDELL 2026-09-06 -- this script's own findings there:
#     InstallDate      2026-06-30 20:54:04
#     RegisteredOwner  a Microsoft-account email address
#     Only user profile on the machine belongs to an account whose
#     PrincipalSource is MicrosoftAccount
#  Two independent signals, agreeing. SANDY is the one we need.
# =====================================================================

$ErrorActionPreference = "Continue"

$ggStamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ggName  = $env:COMPUTERNAME
$ggRoot  = Split-Path $PSScriptRoot -Parent
$ggOutDir = Join-Path $ggRoot "Test_Results"
if (-not (Test-Path $ggOutDir)) { New-Item -ItemType Directory -Path $ggOutDir -Force | Out-Null }
$ggOut = Join-Path $ggOutDir "InstallAccount-$ggName-$ggStamp.txt"

$ggLines = New-Object System.Collections.ArrayList
function Add-Line { param([string]$T = "") ; $null = $ggLines.Add($T) ; Write-Host $T }

Add-Line "======================================================================"
Add-Line "  INSTALL ACCOUNT AND ENCRYPTION STATUS  --  $ggName"
Add-Line "  $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')   READ-ONLY, nothing changed"
Add-Line "======================================================================"
Add-Line ""

# ---- is this session elevated? Say so, never assume -------------------
$ggElev = $false
try {
    $ggId = [Security.Principal.WindowsIdentity]::GetCurrent()
    $ggElev = (New-Object Security.Principal.WindowsPrincipal $ggId).IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator)
} catch {}
Add-Line "  Running elevated: $ggElev"
if (-not $ggElev) {
    Add-Line "  -> The encryption section below needs administrator. It will say"
    Add-Line "     'could not read' rather than report a blank as an answer."
}
Add-Line ""

# ---- 1. WHEN WAS WINDOWS INSTALLED ------------------------------------
Add-Line "----------------------------------------------------------------------"
Add-Line "  1. WHEN WAS WINDOWS INSTALLED"
Add-Line "----------------------------------------------------------------------"
$ggInstall = $null
try {
    $cv = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -EA Stop
    if ($cv.InstallDate) {
        $ggInstall = [DateTimeOffset]::FromUnixTimeSeconds([int64]$cv.InstallDate).LocalDateTime
        Add-Line "  InstallDate      : $ggInstall"
    } else {
        Add-Line "  InstallDate      : not present"
    }
    Add-Line "  RegisteredOwner  : $($cv.RegisteredOwner)"
    Add-Line "  EditionID        : $($cv.EditionID)"
    Add-Line "  DisplayVersion   : $($cv.DisplayVersion)"
    Add-Line ""
    Add-Line "  READ THIS: if RegisteredOwner is an EMAIL ADDRESS, a Microsoft"
    Add-Line "  account was used when Windows was set up. If it is a plain name"
    Add-Line "  or blank or an OEM's name, that is a local-account setup OR a"
    Add-Line "  manufacturer image -- which is why signal 2 below matters."
} catch {
    Add-Line "  Could not read the CurrentVersion key: $_"
}
Add-Line ""

# ---- 2. WHICH ACCOUNTS EXIST, AND WHAT KIND ----------------------------
Add-Line "----------------------------------------------------------------------"
Add-Line "  2. THE ACCOUNTS ON THIS PC  --  Local or MicrosoftAccount"
Add-Line "----------------------------------------------------------------------"
try {
    $ggUsers = Get-LocalUser -EA Stop
    foreach ($u in $ggUsers) {
        Add-Line ("  {0,-22} Enabled={1,-6} Source={2}" -f $u.Name, $u.Enabled, $u.PrincipalSource)
    }
    $ggMsa = @($ggUsers | Where-Object { $_.PrincipalSource -eq 'MicrosoftAccount' })
    Add-Line ""
    Add-Line "  Microsoft accounts found: $($ggMsa.Count)"
} catch {
    Add-Line "  Could not list local users: $_"
}
Add-Line ""

# ---- 3. WHICH PROFILE CAME FIRST --------------------------------------
# The profile FOLDER is created the first time an account actually signs in,
# which is the moment that matters. Account creation time is not the same
# thing, and PasswordLastSet is not creation time at all -- do not use it.
Add-Line "----------------------------------------------------------------------"
Add-Line "  3. PROFILE FOLDERS, OLDEST FIRST  --  who signed in first"
Add-Line "----------------------------------------------------------------------"
$ggBuiltIn = @('Public','Default','Default User','All Users','defaultuser0','WDAGUtilityAccount')
try {
    $ggProfiles = Get-ChildItem C:\Users -Directory -Force -EA Stop |
                  Sort-Object CreationTime
    foreach ($p in $ggProfiles) {
        $tag = if ($ggBuiltIn -contains $p.Name) { "  (built-in, ignore)" } else { "" }
        $gap = ""
        if ($ggInstall -and -not ($ggBuiltIn -contains $p.Name)) {
            $mins = [math]::Round(($p.CreationTime - $ggInstall).TotalMinutes)
            $gap = "   [$mins min after install]"
        }
        Add-Line ("  {0,-22} {1}{2}{3}" -f $p.Name, $p.CreationTime, $gap, $tag)
    }
    Add-Line ""
    $ggFirst = $ggProfiles | Where-Object { $ggBuiltIn -notcontains $_.Name } |
               Select-Object -First 1
    if ($ggFirst) {
        Add-Line "  FIRST REAL PROFILE: $($ggFirst.Name)"
        try {
            $ggFU = Get-LocalUser -Name $ggFirst.Name -EA Stop
            Add-Line "  Its account type  : $($ggFU.PrincipalSource)"
            Add-Line ""
            if ($ggFU.PrincipalSource -eq 'MicrosoftAccount') {
                Add-Line "  => SIGNAL 2 SAYS: a MICROSOFT ACCOUNT signed in first."
            } else {
                Add-Line "  => SIGNAL 2 SAYS: a LOCAL account signed in first."
            }
        } catch {
            Add-Line "  Its account type  : could not match a local user by that name."
            Add-Line "  (A renamed or domain profile does this. Not conclusive.)"
        }
    }
} catch {
    Add-Line "  Could not read C:\Users: $_"
}
Add-Line ""

# ---- 4. IS THE DRIVE ALREADY ENCRYPTED --------------------------------
# Bill, question 7a: "you need to know if the drive is already encrypted.
# If already installed this is a moot question."
Add-Line "----------------------------------------------------------------------"
Add-Line "  4. IS ANY DRIVE ALREADY ENCRYPTED  --  question 7(a)"
Add-Line "----------------------------------------------------------------------"
if (-not $ggElev) {
    Add-Line "  COULD NOT READ -- this needs administrator."
    Add-Line "  Right-click the .bat and choose Run as administrator, then re-run."
} else {
    try {
        $ggVols = Get-BitLockerVolume -EA Stop
        foreach ($v in $ggVols) {
            Add-Line ("  {0,-4} Protection={1,-10} Status={2,-22} Method={3}" -f `
                      $v.MountPoint, $v.ProtectionStatus, $v.VolumeStatus, $v.EncryptionMethod)
            foreach ($kp in $v.KeyProtector) {
                Add-Line ("       key protector: {0}" -f $kp.KeyProtectorType)
            }
        }
        Add-Line ""
        $ggOn = @($ggVols | Where-Object { $_.ProtectionStatus -eq 'On' })
        if ($ggOn.Count -gt 0) {
            Add-Line "  => $($ggOn.Count) volume(s) ALREADY ENCRYPTED."
            Add-Line "     Bill's 7(a): for those, the 'should we turn it on' question is moot."
        } else {
            Add-Line "  => NOTHING is encrypted on this machine."
        }
    } catch {
        Add-Line "  Get-BitLockerVolume failed: $_"
        Add-Line "  (Windows Home reports Device Encryption differently -- see below.)"
    }
    # Device Encryption capability, which is the Home-edition path
    try {
        $ggDe = Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\BitLocker' -EA SilentlyContinue
        if ($null -ne $ggDe -and $null -ne $ggDe.PreventDeviceEncryption) {
            Add-Line ""
            Add-Line "  PreventDeviceEncryption = $($ggDe.PreventDeviceEncryption)"
        }
    } catch {}
}
Add-Line ""

# ---- 5. WHAT THIS MACHINE CAN AND CANNOT PROVE ------------------------
Add-Line "----------------------------------------------------------------------"
Add-Line "  5. WHAT THIS IS AND IS NOT EVIDENCE OF"
Add-Line "----------------------------------------------------------------------"
Add-Line "  TWO SIGNALS, and they are independent:"
Add-Line "    1. RegisteredOwner -- an email address means a Microsoft account"
Add-Line "       was used at setup."
Add-Line "    2. The FIRST profile folder's account type."
Add-Line ""
Add-Line "  WHEN THEY AGREE, that is as close to proof as this machine offers."
Add-Line "  WHEN THEY DISAGREE, believe neither on its own and say so. The"
Add-Line "  usual cause is a manufacturer image, which stamps RegisteredOwner"
Add-Line "  before the customer ever sees the PC."
Add-Line ""
Add-Line "  WHAT THIS CANNOT TELL YOU: whether the person was OFFERED"
Add-Line "  encryption during setup. Nothing on the machine records the"
Add-Line "  question, only the outcome. That is Bill's 7(c) and it is a"
Add-Line "  documentation question, not a measurement."
Add-Line ""
Add-Line "======================================================================"
Add-Line "  Saved to: $ggOut"
Add-Line "======================================================================"

$ggLines -join "`r`n" | Out-File -FilePath $ggOut -Encoding UTF8
