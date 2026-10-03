# ============================================================
# GatewayGuard BitLocker Overnight Encryption (Standalone)
# Dated: 2026-07-13 22:36 EDT
# William F. Burns III | GatewayGuard
# Purpose: Encrypt drive C: with BitLocker tonight, unattended.
#          Standalone -- does NOT require the v3.1 hardening tool.
# Compatibility: Windows PowerShell 5.1, Windows 11 Pro, ASCII only
# Run: Right-click -> Run with PowerShell (as Administrator)
# ============================================================

$ErrorActionPreference = 'Stop'

# ---------- Logging ----------
$stamp   = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$logPath = Join-Path $env:USERPROFILE ("Documents\GatewayGuard-BitLocker-Log-" + $stamp + ".txt")

function Write-Log {
    param([string]$Level, [string]$Message)
    $line = -join ("[", (Get-Date -Format 'HH:mm:ss'), "] [", $Level, "] ", $Message)
    Write-Host $line
    Add-Content -Path $logPath -Value $line -Encoding ASCII
}

# ---------- Keep-awake (prevents sleep while encrypting) ----------
Add-Type -Name Power -Namespace GG -MemberDefinition @'
[DllImport("kernel32.dll", SetLastError = true)]
public static extern uint SetThreadExecutionState(uint esFlags);
'@
function Set-KeepAwake {
    # ES_CONTINUOUS (0x80000000) + ES_SYSTEM_REQUIRED (0x00000001)
    [GG.Power]::SetThreadExecutionState([uint32]2147483649) | Out-Null
}
function Clear-KeepAwake {
    # ES_CONTINUOUS only -- releases the requirement
    [GG.Power]::SetThreadExecutionState([uint32]2147483648) | Out-Null
}

try {
    Write-Log 'START' 'GatewayGuard BitLocker Overnight Encryption launched'

    # ---------- Admin check ----------
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    $pr = New-Object Security.Principal.WindowsPrincipal($id)
    if (-not $pr.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Log 'ERROR' 'Not running as Administrator. Right-click the script and choose Run as Administrator.'
        Read-Host 'Press Enter to exit'
        exit 1
    }
    Write-Log 'OK' 'Administrator access confirmed'

    # ---------- AC power check ----------
    $onAC = $true
    $battery = Get-CimInstance -ClassName Win32_Battery -ErrorAction SilentlyContinue
    if ($battery) {
        # BatteryStatus 2 = on AC power
        if ($battery.BatteryStatus -ne 2) { $onAC = $false }
    }
    if (-not $onAC) {
        Write-Log 'WARN' 'Laptop appears to be on battery. Plug in AC power before continuing.'
        $ans = Read-Host 'Type Y to continue anyway, anything else to exit'
        if ($ans -ne 'Y' -and $ans -ne 'y') { exit 1 }
    } else {
        Write-Log 'OK' 'AC power confirmed'
    }

    # ---------- TPM check ----------
    $tpm = Get-Tpm
    if (-not $tpm.TpmPresent -or -not $tpm.TpmReady) {
        Write-Log 'ERROR' 'TPM is not present or not ready. Open tpm.msc to check, then re-run.'
        Read-Host 'Press Enter to exit'
        exit 1
    }
    Write-Log 'OK' 'TPM present and ready'

    Set-KeepAwake
    Write-Log 'OK' 'Sleep prevention activated for this session'

    # ---------- Current BitLocker status ----------
    $vol = Get-BitLockerVolume -MountPoint 'C:'
    Write-Log 'INFO' (-join ('C: status: ', $vol.VolumeStatus, ' | Protection: ', $vol.ProtectionStatus, ' | ', $vol.EncryptionPercentage, ' percent encrypted'))

    if ($vol.VolumeStatus -eq 'FullyEncrypted' -and $vol.ProtectionStatus -eq 'On') {
        Write-Log 'OK' 'C: is already fully encrypted with protection ON. Nothing to do.'
        Clear-KeepAwake
        Read-Host 'Press Enter to exit'
        exit 0
    }

    if ($vol.VolumeStatus -eq 'FullyEncrypted' -and $vol.ProtectionStatus -eq 'Off') {
        Write-Log 'INFO' 'C: is encrypted but protection is suspended. Resuming protection.'
        Resume-BitLocker -MountPoint 'C:' | Out-Null
        Write-Log 'OK' 'Protection resumed. Done.'
        Clear-KeepAwake
        Read-Host 'Press Enter to exit'
        exit 0
    }

    # ---------- Recovery key: create FIRST, save BEFORE encrypting ----------
    if ($vol.VolumeStatus -eq 'FullyDecrypted') {
        Write-Log 'INFO' 'Adding recovery password protector (your emergency key)'
        Add-BitLockerKeyProtector -MountPoint 'C:' -RecoveryPasswordProtector | Out-Null
    }

    $vol = Get-BitLockerVolume -MountPoint 'C:'
    $rp  = $vol.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' } | Select-Object -First 1
    if ($rp) {
        $keyFile = Join-Path $env:USERPROFILE ("Desktop\BitLocker-Recovery-Key-CGDELL-2026-07-13.txt")
        $keyText = @(
            'BitLocker Recovery Key -- CGDELL (Dell Latitude 5430)'
            (-join ('Saved: ', (Get-Date -Format 'yyyy-MM-dd HH:mm')))
            ''
            (-join ('Key ID:       ', $rp.KeyProtectorId))
            (-join ('Recovery Key: ', $rp.RecoveryPassword))
            ''
            'STORE A COPY OFF THIS COMPUTER: Proton Pass, a printout, or a USB stick.'
            'If Windows ever asks for the recovery key at boot, this 48-digit number is the answer.'
        ) -join "`r`n"
        Set-Content -Path $keyFile -Value $keyText -Encoding ASCII
        Write-Log 'OK' (-join ('Recovery key saved to: ', $keyFile))
        Write-Host ''
        Write-Host '  *** IMPORTANT: Copy the recovery key file on your Desktop to Proton Pass ***'
        Write-Host '  *** or another device BEFORE you go to bed. Do not skip this step.      ***'
        Write-Host ''
    } else {
        Write-Log 'ERROR' 'Could not create or find a recovery password protector. Stopping -- do not encrypt without a recovery key.'
        Clear-KeepAwake
        Read-Host 'Press Enter to exit'
        exit 1
    }

    # ---------- Start encryption ----------
    if ($vol.VolumeStatus -eq 'FullyDecrypted') {
        Write-Log 'INFO' 'Starting encryption: XTS-AES 256, full drive, no reboot hardware test'
        Enable-BitLocker -MountPoint 'C:' -EncryptionMethod XtsAes256 -TpmProtector -SkipHardwareTest | Out-Null
        Write-Log 'OK' 'Encryption started'
    } elseif ($vol.VolumeStatus -eq 'EncryptionInProgress') {
        Write-Log 'INFO' 'Encryption already in progress -- monitoring until complete'
    } elseif ($vol.VolumeStatus -eq 'EncryptionPaused') {
        Write-Log 'INFO' 'Encryption was paused -- resuming'
        Resume-BitLocker -MountPoint 'C:' | Out-Null
    }

    # ---------- Monitor until done (safe to leave overnight) ----------
    Write-Host ''
    Write-Host '  Leave the laptop plugged in and the lid open. Encryption runs in the'
    Write-Host '  background; this window shows progress and keeps the machine awake.'
    Write-Host ''
    $lastPct = -1
    do {
        Start-Sleep -Seconds 60
        Set-KeepAwake
        $vol = Get-BitLockerVolume -MountPoint 'C:'
        if ($vol.EncryptionPercentage -ne $lastPct) {
            Write-Log 'INFO' (-join ('Progress: ', $vol.EncryptionPercentage, ' percent encrypted'))
            $lastPct = $vol.EncryptionPercentage
        }
    } while ($vol.VolumeStatus -ne 'FullyEncrypted')

    Write-Log 'OK' 'C: is FULLY ENCRYPTED. BitLocker protection is active.'
    Write-Log 'DONE' 'Finished normally'
}
catch {
    Write-Log 'ERROR' (-join ('Unhandled error: ', $_.Exception.Message))
    Write-Log 'ERROR' ($_.ScriptStackTrace)
}
finally {
    Clear-KeepAwake
}

Read-Host 'Press Enter to close'
