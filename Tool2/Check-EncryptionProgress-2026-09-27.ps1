# Check-EncryptionProgress-2026-09-27.ps1
# Dated: 2026-09-27 13:27 ET
# Editor: Claude Code (CGDELL)
# Purpose: show, for every drive, how far encryption or decryption has got.
#          Bill is turning Device Encryption off on SANDY (2026-09-27) so the
#          ascii45 field run starts unencrypted (FT-289). The run should wait
#          until every drive reads "FullyDecrypted, 0%".
# READ-ONLY. Changes nothing. Run as administrator.
# Output: on screen, and Test_Results\EncryptionProgress-<machine>-<stamp>.txt

$out = Join-Path (Split-Path -Parent $PSScriptRoot) ("Test_Results\EncryptionProgress-" + $env:COMPUTERNAME + "-" + (Get-Date -Format "yyyy-MM-dd_HH-mm") + ".txt")
$L = New-Object System.Collections.Generic.List[string]
function Add($s) { $L.Add([string]$s); Write-Host $s }
Add "ENCRYPTION PROGRESS -- $env:COMPUTERNAME -- $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
Add ""
$allClear = $true
try {
    foreach ($v in @(Get-BitLockerVolume -EA Stop)) {
        $plain = switch ([string]$v.VolumeStatus) {
            "FullyDecrypted"          { "NOT encrypted -- done" }
            "DecryptionInProgress"    { "decrypting -- still working" }
            "FullyEncrypted"          { "encrypted" }
            "EncryptionInProgress"    { "encrypting -- still working" }
            default                   { [string]$v.VolumeStatus }
        }
        Add ("  Drive {0,-4} {1,5}% encrypted   {2}   (protection {3})" -f $v.MountPoint, $v.EncryptionPercentage, $plain, $v.ProtectionStatus)
        if ([string]$v.VolumeStatus -ne "FullyDecrypted") { $allClear = $false }
    }
} catch { Add "  Could not read (run as administrator): $($_.Exception.Message)"; $allClear = $false }
Add ""
if ($allClear) { Add "  ALL DRIVES ARE DECRYPTED. SANDY is ready for the field run." }
else { Add "  Not finished yet. Leave the PC on and plugged in, and run this again later." }
$L | Out-File -FilePath $out -Encoding UTF8
Write-Host ""
Write-Host "Saved to: $out"
