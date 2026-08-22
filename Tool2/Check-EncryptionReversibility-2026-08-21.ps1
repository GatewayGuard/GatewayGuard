# Dated: 2026-08-21 07:58 ET
# ================================================================
# FILE:    Check-EncryptionReversibility-2026-08-21.ps1
# PURPOSE: Answer one question before SANDY's encryption test is spent:
#          if Checkup encrypts this drive, can it be put back?
#
# READ-ONLY. Changes nothing. Does not encrypt, decrypt, or touch any
# setting. Does not self-elevate (Malwarebytes exploit-payload flag).
# Writes its findings to a file so nothing is truncated on screen.
# ================================================================

$ErrorActionPreference = "Continue"

$machine = $env:COMPUTERNAME
$stamp   = Get-Date -Format "yyyy-MM-dd_HH-mm"
$outDir  = Join-Path $PSScriptRoot "..\Test_Results"
if (-not (Test-Path $outDir)) { $outDir = $PSScriptRoot }
$outFile = Join-Path $outDir ("EncryptionState-" + $machine + "-" + $stamp + ".txt")

$L = New-Object System.Collections.Generic.List[string]
function Add-Line { param([string]$t = "") ; $L.Add($t) ; Write-Host $t }

Add-Line "================================================================"
Add-Line " ENCRYPTION STATE AND REVERSIBILITY -- $machine"
Add-Line " Run: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ET"
Add-Line " READ-ONLY. Nothing was changed."
Add-Line "================================================================"
Add-Line ""

# -- elevation: report, never acquire -----------------------------
$elevated = $false
try {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    $pr = New-Object Security.Principal.WindowsPrincipal($id)
    $elevated = $pr.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
} catch {}
Add-Line ("Elevated: " + $(if ($elevated) { "YES" } else { "no -- some rows may read 'access denied', which is expected" }))
Add-Line ""

# -- edition, because Home and Pro decrypt by different routes ----
Add-Line "--- WINDOWS EDITION ---"
try {
    $os = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
    Add-Line ("  Caption: " + $os.Caption)
    Add-Line ("  Version: " + $os.Version + "  Build: " + $os.BuildNumber)
} catch { Add-Line ("  Could not read: " + $_.Exception.Message) }
Add-Line ""

# -- the central measurement --------------------------------------
# VERIFIED 2026-08-21 measured on CGDELL: 'manage-bde -status' runs
# UNELEVATED and returns Conversion Status, Percentage Encrypted,
# Protection Status and Key Protectors for every volume.
Add-Line "--- manage-bde -status (all volumes) ---"
try {
    $bde = & manage-bde.exe -status 2>&1
    foreach ($line in $bde) { Add-Line ("  " + $line) }
} catch { Add-Line ("  manage-bde unavailable: " + $_.Exception.Message) }
Add-Line ""

# -- drive hardware, because decrypt TIME is the practical cost ---
Add-Line "--- PHYSICAL DISKS (decrypt time depends on this) ---"
try {
    Get-PhysicalDisk -ErrorAction Stop | ForEach-Object {
        Add-Line ("  " + $_.FriendlyName + " | MediaType: " + $_.MediaType +
                  " | Size: " + [math]::Round($_.Size / 1GB, 1) + " GB | Bus: " + $_.BusType)
    }
} catch { Add-Line ("  Could not read: " + $_.Exception.Message) }
Add-Line ""

Add-Line "--- FIXED VOLUMES ---"
try {
    Get-Volume -ErrorAction Stop |
        Where-Object { $_.DriveType -eq "Fixed" -and $_.DriveLetter } |
        ForEach-Object {
            Add-Line ("  " + $_.DriveLetter + ": " + $_.FileSystemLabel +
                      " | Size: " + [math]::Round($_.Size / 1GB, 1) + " GB" +
                      " | Free: " + [math]::Round($_.SizeRemaining / 1GB, 1) + " GB")
        }
} catch { Add-Line ("  Could not read: " + $_.Exception.Message) }
Add-Line ""

# -- TPM: relevant to whether encryption can engage at all --------
Add-Line "--- TPM ---"
try {
    $tpm = Get-Tpm -ErrorAction Stop
    Add-Line ("  Present: "  + $tpm.TpmPresent)
    Add-Line ("  Ready: "    + $tpm.TpmReady)
    Add-Line ("  Enabled: "  + $tpm.TpmEnabled)
} catch { Add-Line ("  Could not read (often needs elevation): " + $_.Exception.Message) }
Add-Line ""

# -- is Device Encryption even offered on this machine? -----------
Add-Line "--- DEVICE ENCRYPTION SUPPORT ---"
try {
    $rk = "HKLM:\SYSTEM\CurrentControlSet\Control\BitLocker"
    if (Test-Path $rk) {
        $p = Get-ItemProperty -Path $rk -ErrorAction Stop
        if ($null -ne $p.PreventDeviceEncryption) {
            Add-Line ("  PreventDeviceEncryption = " + $p.PreventDeviceEncryption +
                      "  (1 means Windows will not auto-encrypt this PC)")
        } else {
            Add-Line "  PreventDeviceEncryption: not set (the default)"
        }
    } else {
        Add-Line "  No BitLocker policy key present (the default)"
    }
} catch { Add-Line ("  Could not read: " + $_.Exception.Message) }
Add-Line ""

# -- the actual answer to the question ----------------------------
Add-Line "--- WHAT THIS MEANS FOR THE TEST ---"
Add-Line "  Read the 'Conversion Status' rows above."
Add-Line ""
Add-Line "  FullyDecrypted  = this drive has never been encrypted, or was"
Add-Line "                    decrypted. This is the state SANDY's test needs."
Add-Line "  FullyEncrypted  = the unencrypted-machine test is spent for now."
Add-Line ""
Add-Line "  The reverse route, if it is ever needed, is Settings >"
Add-Line "  Privacy & security > Device encryption > turn it Off, which"
Add-Line "  decrypts in place. Time scales with drive size and type -- see"
Add-Line "  the PHYSICAL DISKS rows. On a hard disk rather than an SSD this"
Add-Line "  is hours, not minutes."
Add-Line ""
Add-Line "  NOT MEASURED, and it is the thing worth confirming on SANDY"
Add-Line "  itself: that the Device encryption toggle is actually PRESENT"
Add-Line "  in Settings on that machine. Look for it before encrypting,"
Add-Line "  not after."
Add-Line ""
Add-Line "================================================================"
Add-Line (" Saved to: " + $outFile)
Add-Line "================================================================"

try {
    ($L -join "`r`n") | Out-File -FilePath $outFile -Encoding UTF8
} catch {
    Write-Host ("  Could not write the file: " + $_.Exception.Message) -ForegroundColor Yellow
}
