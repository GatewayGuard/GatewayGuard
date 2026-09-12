# Dated: 2026-08-07 10:08 ET
# File: Rotate-BitLockerKey-2026-08-07.ps1
#
# ============================================================================
#  THIS SCRIPT CHANGES YOUR COMPUTER. It is NOT read-only.
#  It replaces the BitLocker recovery key on drive C:.
# ============================================================================
#
# WHY: the current recovery key for CGDELL was found in plain text inside a
# project note (Notes\LAtest Notes_2026-07-25.txt), committed to git since the
# first commit, and therefore copied into the personal OneDrive cloud, the
# business OneDrive cloud, Sandy3, a USB stick and a local backup. Scrubbing the
# file cannot un-copy it. Replacing the key makes every one of those copies
# worthless in a single step.
#
# VERIFIED 2026-08-07 measured on CGDELL: the RecoveryPassword protector on C:
# is {85D80E2E-95B0-47B0-9A5E-FD6AED29619A}, which is byte-for-byte the Key ID
# printed in that note. The exposed key is the live one.
#
# THE SAFETY ORDER -- this is the whole design:
#   1. ADD a new recovery key.
#   2. SHOW it to you and make you confirm you have saved it.
#   3. Only THEN delete the old one.
# There is never a moment when the drive has no recovery key. If you stop
# part-way, you stop in a safe state with BOTH keys working.
#
# THE NEW KEY IS NEVER WRITTEN TO A FILE. Writing it to disk is what caused this
# problem. It is shown on screen once. The results file records only the
# protector IDs -- never the key itself.
#
# NEEDS ADMINISTRATOR. The launcher does not self-elevate (a self-elevating .bat
# was flagged by Malwarebytes as an exploit payload, field-confirmed 2026-07-04).
# Right-click the launcher and choose "Run as administrator".
#
# VERIFIED 2026-08-07 measured on CGDELL -- every cmdlet used below exists and
# these are its real parameters, read from Get-Command, not assumed:
#   Add-BitLockerKeyProtector    [-MountPoint] <string[]> -RecoveryPasswordProtector
#   Remove-BitLockerKeyProtector [-MountPoint] <string[]> [-KeyProtectorId] <string>
#   Get-BitLockerVolume          -MountPoint <string[]>
#
# PS 5.1 COMPATIBLE: -join only, no Join-String, no ternary.

$ErrorActionPreference = 'Stop'
$Mount = 'C:'

# ---------- results file: IDs only, never the key ----------
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$outDir    = Join-Path (Split-Path -Parent $scriptDir) 'Test_Results'
if (-not (Test-Path -LiteralPath $outDir)) { $outDir = $scriptDir }
$outFile = Join-Path $outDir ("BitLockerKeyRotation-" + $env:COMPUTERNAME + "-" + (Get-Date -Format 'yyyy-MM-dd_HH-mm') + ".txt")
$R = New-Object System.Collections.Generic.List[string]
function Say { param([string]$T) $R.Add($T); Write-Host $T }

Say ""
Say "================================================================"
Say " ROTATE THE BITLOCKER RECOVERY KEY -- THIS CHANGES YOUR COMPUTER"
Say "================================================================"
Say ("  Computer : " + $env:COMPUTERNAME)
Say ("  Drive    : " + $Mount)
Say ("  Started  : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Say ""

# ---------- 1. administrator ----------
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Say "  STOPPED. This window is not running as administrator."
    Say ""
    Say "  Nothing has been changed."
    Say ""
    Say "  To fix it: close this window. Find Run-RotateBitLockerKey.bat,"
    Say "  RIGHT-CLICK it, and choose 'Run as administrator'. Then answer Yes"
    Say "  to the Windows prompt that appears."
    Say ""
    return
}
Say "  Administrator : yes"

# ---------- 1a. refuse to run unless a REAL person is at a REAL console ----------
# EARNED 2026-08-07, the same morning this script was written. Claude ran it from
# a tool session believing that session was unelevated. It was not. The script
# did exactly what it was told, added a real key, and printed it into a chat
# transcript -- creating a second copy of the very problem it exists to fix.
# The admin check is not enough: an automated session can be elevated too.
# [Console]::IsInputRedirected is TRUE whenever stdin is a pipe rather than a
# keyboard, which is exactly what an automated caller looks like and is exactly
# what a double-clicked launcher does NOT look like.
if ([Console]::IsInputRedirected) {
    Say ""
    Say "  STOPPED. This script is not being run by a person at a keyboard."
    Say ""
    Say "  It shows a recovery key on screen and needs a typed confirmation"
    Say "  before it removes anything. Run from an automated session and that"
    Say "  key ends up in a log or a transcript -- which is the exact problem"
    Say "  this script exists to fix."
    Say ""
    Say "  Nothing has been changed."
    Say ""
    Say "  To run it properly: find Run-RotateBitLockerKey.bat in this folder,"
    Say "  RIGHT-CLICK it, and choose 'Run as administrator'."
    Say ""
    Set-Content -LiteralPath $outFile -Value ($R -join "`r`n") -Encoding ASCII
    return
}
Say "  Real console  : yes"

# ---------- 2. is the drive actually encrypted ----------
$vol = $null
try { $vol = Get-BitLockerVolume -MountPoint $Mount } catch { }
if (-not $vol) {
    Say "  STOPPED. Windows did not report any BitLocker information for C:."
    Say "  Nothing has been changed. Send this file to Claude."
    Say ""
    Set-Content -LiteralPath $outFile -Value ($R -join "`r`n") -Encoding ASCII
    return
}
Say ("  Volume status : " + $vol.VolumeStatus + " / " + $vol.EncryptionPercentage + "% / protection " + $vol.ProtectionStatus)

if ($vol.ProtectionStatus -ne 'On') {
    Say ""
    Say "  STOPPED. BitLocker protection is not On for this drive."
    Say "  Rotating a recovery key only makes sense on a protected drive."
    Say "  Nothing has been changed. Send this file to Claude."
    Say ""
    Set-Content -LiteralPath $outFile -Value ($R -join "`r`n") -Encoding ASCII
    return
}

# ---------- 3. the recovery keys that exist right now ----------
$oldRP = @($vol.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' })
Say ""
Say "---- Recovery keys on this drive before any change ----"
if ($oldRP.Count -eq 0) {
    Say "  NONE. There is no recovery key to replace."
    Say "  This script only replaces an existing key; it will add one and stop."
} else {
    foreach ($p in $oldRP) { Say ("  " + $p.KeyProtectorId) }
}
Say ("  Count : " + $oldRP.Count)

# ---------- 4. ADD the new key FIRST ----------
Say ""
Say "---- Step 1 of 3: adding a NEW recovery key ----"
Say "  (the old one still works until the very last step)"
$added = $null
try {
    $added = Add-BitLockerKeyProtector -MountPoint $Mount -RecoveryPasswordProtector
} catch {
    Say ""
    Say ("  STOPPED. Windows refused to add a new recovery key: " + $_.Exception.Message)
    Say "  Nothing has been changed. Your existing key still works."
    Say ""
    Set-Content -LiteralPath $outFile -Value ($R -join "`r`n") -Encoding ASCII
    return
}

# re-read from Windows rather than trusting the return value
$vol2  = Get-BitLockerVolume -MountPoint $Mount
$allRP = @($vol2.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' })
$oldIds = @()
foreach ($p in $oldRP) { $oldIds += $p.KeyProtectorId }
$newRP = @($allRP | Where-Object { $oldIds -notcontains $_.KeyProtectorId })

if ($newRP.Count -ne 1) {
    Say ""
    Say ("  STOPPED. Expected exactly 1 new recovery key, found " + $newRP.Count + ".")
    Say "  Nothing has been deleted. Your existing key still works."
    Say "  Send this file to Claude before doing anything else."
    Say ""
    foreach ($p in $allRP) { Say ("    present: " + $p.KeyProtectorId) }
    Set-Content -LiteralPath $outFile -Value ($R -join "`r`n") -Encoding ASCII
    return
}

$new = $newRP[0]
Say ("  New key added. Its ID: " + $new.KeyProtectorId)

# ---------- 5. SHOW it, and make Bill confirm he saved it ----------
Write-Host ""
Write-Host "================================================================"
Write-Host " Step 2 of 3: WRITE THIS DOWN NOW"
Write-Host "================================================================"
Write-Host ""
Write-Host "  This is your NEW recovery key. It is shown once and is never"
Write-Host "  saved to any file by this script."
Write-Host ""
Write-Host ("  Key ID       : " + $new.KeyProtectorId)
Write-Host ""
Write-Host ("  RECOVERY KEY : " + $new.RecoveryPassword)
Write-Host ""
Write-Host "  Save it in BOTH places:"
Write-Host ""
Write-Host "   1. Your Microsoft account -- the safest place, because it"
Write-Host "      cannot be lost with this computer:"
Write-Host "        Control Panel  >  System and Security  >"
Write-Host "        BitLocker Drive Encryption  >  Back up your recovery key"
Write-Host "        >  Save to your Microsoft account"
Write-Host ""
Write-Host "   2. On paper, somewhere away from this computer."
Write-Host ""
Write-Host "  DO NOT save it into the GatewayGuide folder, OneDrive, or any"
Write-Host "  file on this PC. That is exactly what went wrong last time."
Write-Host ""
Write-Host "  NOTE: this key is now in this window's scrollback. Close this"
Write-Host "  window when you are done, and do not screen-share it."
Write-Host ""

$answer = ''
$tries  = 0
while ($answer -ne 'SAVED' -and $answer -ne 'STOP' -and $tries -lt 5) {
    Write-Host "  Type SAVED once you have stored the key, or STOP to leave both"
    Write-Host "  keys in place and change nothing further."
    # null-guard: Read-Host returns $null when there is no console to read
    # from, and .Trim() on $null throws. Treat it as "no answer given", which
    # falls through to the STOP path and leaves both keys in place.
    $raw = Read-Host "  Your answer"
    if ($null -eq $raw) { $raw = '' }
    $answer = $raw.Trim().ToUpper()
    $tries = $tries + 1
}

if ($answer -ne 'SAVED') {
    Say ""
    Say "---- Step 3 of 3: SKIPPED ----"
    Say "  You did not confirm, so the OLD key was NOT deleted."
    Say ""
    Say "  Your drive now has TWO working recovery keys:"
    foreach ($p in $oldRP) { Say ("    old (exposed) : " + $p.KeyProtectorId) }
    Say             ("    new           : " + $new.KeyProtectorId)
    Say ""
    Say "  This is a SAFE state -- you can still unlock the drive either way."
    Say "  But the exposed key still works, so the job is not finished."
    Say "  Run this script again when you have the new key written down."
    Say ""
    Set-Content -LiteralPath $outFile -Value ($R -join "`r`n") -Encoding ASCII
    return
}

# ---------- 6. delete the old key(s) ----------
Say ""
Say "---- Step 3 of 3: removing the old recovery key ----"
$removed = 0
$failed  = 0
foreach ($p in $oldRP) {
    try {
        Remove-BitLockerKeyProtector -MountPoint $Mount -KeyProtectorId $p.KeyProtectorId | Out-Null
        Say ("  removed : " + $p.KeyProtectorId)
        $removed = $removed + 1
    } catch {
        Say ("  FAILED to remove " + $p.KeyProtectorId + " -- " + $_.Exception.Message)
        $failed = $failed + 1
    }
}

# ---------- 7. prove the final state ----------
$vol3   = Get-BitLockerVolume -MountPoint $Mount
$finalRP = @($vol3.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' })

Say ""
Say "================================================================"
Say " RESULT"
Say "================================================================"
Say ("  Protection status      : " + $vol3.ProtectionStatus)
Say ("  Old keys removed       : " + $removed)
Say ("  Old keys that FAILED   : " + $failed)
Say ("  Recovery keys remaining: " + $finalRP.Count)
foreach ($p in $finalRP) { Say ("    " + $p.KeyProtectorId) }
Say ""

$goodId = $false
foreach ($p in $finalRP) { if ($p.KeyProtectorId -eq $new.KeyProtectorId) { $goodId = $true } }

if ($goodId -and $finalRP.Count -eq 1 -and $failed -eq 0 -and $vol3.ProtectionStatus -eq 'On') {
    Say "  DONE. The exposed key no longer opens this drive."
    Say "  The only recovery key that works now is the one you just saved."
} else {
    Say "  NOT FINISHED -- read the numbers above and send this file to Claude."
    Say "  Your drive is still protected and still has at least one working key."
}
Say ""
Say "  Reminder: back the new key up to your Microsoft account if you have"
Say "  not already, using the Control Panel path shown earlier."
Say ""
Say ("  This file records protector IDs only. It does NOT contain the key.")
Say ("  Saved to: " + $outFile)
Say ""

Set-Content -LiteralPath $outFile -Value ($R -join "`r`n") -Encoding ASCII
