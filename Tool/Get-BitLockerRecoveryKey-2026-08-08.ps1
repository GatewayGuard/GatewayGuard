# Dated: 2026-08-08 19:02 ET
# FILE: Get-BitLockerRecoveryKey-2026-08-08.ps1
#
# READ-ONLY. Reads the BitLocker recovery key(s) already on this machine.
# It does NOT rotate, create, delete or change any protector. Nothing about
# the encryption is altered.
#
# Why this exists: account.microsoft.com/devices/recoverykey went into a
# sign-in loop on 2026-08-08. The key does not require that website -- while
# the drive is unlocked, Windows can read it locally.
#
# WHERE THE OUTPUT GOES -- read this:
#   C:\GG-RecoveryKey\   -- deliberately OUTSIDE the project tree.
# The project tree syncs to OneDrive and pushes to GitHub, and a recovery key
# committed to git is permanent in its history. This file must NOT go there.
# Copy it to the USB drive or print it, then delete the local copy.

$ErrorActionPreference = 'Stop'

$OutDir = 'C:\GG-RecoveryKey'
$stamp  = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$OutFile = Join-Path $OutDir ("RecoveryKey-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

$lines = New-Object System.Collections.Generic.List[string]
function Add-Line($s) { $lines.Add($s); Write-Host $s }

Add-Line '================================================================'
Add-Line ' BITLOCKER RECOVERY KEY -- read-only, changes nothing'
Add-Line '================================================================'
Add-Line ("  Computer : " + $env:COMPUTERNAME)
Add-Line ("  User     : " + $env:USERNAME)
Add-Line ("  Run date : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))

# ---------- elevation: report, never self-elevate ----------
$id  = [Security.Principal.WindowsIdentity]::GetCurrent()
$adm = (New-Object Security.Principal.WindowsPrincipal($id)).IsInRole(
           [Security.Principal.WindowsBuiltInRole]::Administrator)
Add-Line ("  Administrator : " + $adm)
if (-not $adm) {
    Add-Line ''
    Add-Line '  NOT ELEVATED. Windows will not reveal recovery passwords.'
    Add-Line '  Close this, right-click the .bat and choose Run as administrator.'
    Add-Line ''
    Read-Host '  Press Enter to close'
    exit 1
}

Add-Line ''
$found = 0

try {
    $vols = Get-BitLockerVolume -ErrorAction Stop |
            Where-Object { $_.VolumeType -eq 'OperatingSystem' -or $_.MountPoint -match '^[A-Z]:$' }
} catch {
    Add-Line ("  Get-BitLockerVolume failed: " + $_.Exception.Message)
    $vols = @()
}

foreach ($v in $vols) {
    Add-Line ('---- ' + $v.MountPoint + ' ----')
    Add-Line ('  protection status : ' + $v.ProtectionStatus)
    Add-Line ('  encryption        : ' + $v.VolumeStatus + '  (' + $v.EncryptionPercentage + '%)')
    Add-Line ('  method            : ' + $v.EncryptionMethod)

    $rp = @($v.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' })
    if ($rp.Count -eq 0) {
        Add-Line '  RECOVERY PASSWORD : none on this volume'
    }
    foreach ($p in $rp) {
        $found++
        Add-Line ''
        Add-Line ('  Key Protector ID  : ' + $p.KeyProtectorId)
        Add-Line ('  RECOVERY PASSWORD : ' + $p.RecoveryPassword)
    }
    Add-Line ''
}

Add-Line '================================================================'
if ($found -eq 0) {
    Add-Line '  NO RECOVERY PASSWORD FOUND.'
    Add-Line '  The drive may be encrypted with a different protector type.'
    Add-Line '  Send this output to Claude before changing any account.'
} else {
    Add-Line ("  " + $found + " recovery password(s) found.")
    Add-Line ''
    Add-Line '  WRITE THIS DOWN OR COPY IT OFF THIS MACHINE NOW.'
    Add-Line '  A recovery key stored only on the drive it unlocks is no use'
    Add-Line '  on the day that drive will not unlock.'
    Add-Line ''
    Add-Line '  Do NOT put this file in the project folder -- it syncs to'
    Add-Line '  OneDrive and pushes to GitHub, where git history keeps it'
    Add-Line '  forever.'
}
Add-Line '================================================================'

if (-not (Test-Path -LiteralPath $OutDir)) {
    New-Item -ItemType Directory -Path $OutDir -Force | Out-Null
}
$lines -join "`r`n" | Set-Content -LiteralPath $OutFile -Encoding UTF8
Write-Host ''
Write-Host ("  Saved to: " + $OutFile)
Write-Host '  Copy it to the USB drive or print it, then delete the local copy.'
Write-Host ''
Read-Host '  Press Enter to close'
