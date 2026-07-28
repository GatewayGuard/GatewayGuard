# ============================================================
# GATEWAYGUARD -- SYSTEM BASELINE DIAGNOSTIC
# Run this in PowerShell before running the main GatewayGuard tool
# Right-click PowerShell -> Run as Administrator for best results
# ============================================================

Write-Host ""
Write-Host "  GATEWAYGUARD -- SYSTEM BASELINE DIAGNOSTIC" -ForegroundColor White
Write-Host "  ============================================" -ForegroundColor White
Write-Host ""

# ------------------------------------------------------------
# SECTION 1: SYSTEM BASICS
# ------------------------------------------------------------
Write-Host "  [1] SYSTEM BASICS" -ForegroundColor Cyan
Write-Host "  -----------------" -ForegroundColor Cyan
Get-ComputerInfo | Select-Object CsManufacturer, CsModel, OsName, OsVersion, CsTotalPhysicalMemory | Format-List
Write-Host ""

# ------------------------------------------------------------
# SECTION 2: WINDOWS EDITION
# ------------------------------------------------------------
Write-Host "  [2] WINDOWS EDITION" -ForegroundColor Cyan
Write-Host "  -------------------" -ForegroundColor Cyan
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | Select-Object EditionID, ProductName, CurrentBuild | Format-List
Write-Host ""

# ------------------------------------------------------------
# SECTION 3: PROCESSOR
# ------------------------------------------------------------
Write-Host "  [3] PROCESSOR" -ForegroundColor Cyan
Write-Host "  -------------" -ForegroundColor Cyan
Get-WmiObject Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors | Format-List
Write-Host ""

# ------------------------------------------------------------
# SECTION 4: STORAGE
# ------------------------------------------------------------
Write-Host "  [4] STORAGE" -ForegroundColor Cyan
Write-Host "  -----------" -ForegroundColor Cyan
Get-PhysicalDisk | Select-Object FriendlyName, MediaType, @{N="Size(GB)";E={[math]::Round($_.Size/1GB,1)}} | Format-List
Write-Host ""

# ------------------------------------------------------------
# SECTION 5: BATTERY STATUS
# ------------------------------------------------------------
Write-Host "  [5] BATTERY STATUS" -ForegroundColor Cyan
Write-Host "  ------------------" -ForegroundColor Cyan
$battery = Get-WmiObject -Class Win32_Battery
if ($battery) {
    $battery | Select-Object Name, BatteryStatus, EstimatedChargeRemaining | Format-List
} else {
    Write-Host "  No battery detected (desktop PC or battery not reporting)" -ForegroundColor Yellow
}
Write-Host ""

# ------------------------------------------------------------
# SECTION 6: ANTIVIRUS REGISTERED IN WINDOWS SECURITY CENTER
# ------------------------------------------------------------
Write-Host "  [6] ANTIVIRUS REGISTERED" -ForegroundColor Cyan
Write-Host "  ------------------------" -ForegroundColor Cyan
Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct | Select-Object displayName, productState | Format-List
Write-Host ""

# ------------------------------------------------------------
# SECTION 7: WINDOWS DEFENDER STATUS
# ------------------------------------------------------------
Write-Host "  [7] WINDOWS DEFENDER STATUS" -ForegroundColor Cyan
Write-Host "  ---------------------------" -ForegroundColor Cyan
Get-MpComputerStatus | Select-Object AMServiceEnabled, AntispywareEnabled, AntivirusEnabled, RealTimeProtectionEnabled, TamperProtectionSource | Format-List
Write-Host ""

# ------------------------------------------------------------
# SECTION 8: WINDOWS UPDATE STATUS
# ------------------------------------------------------------
Write-Host "  [8] WINDOWS UPDATE SERVICE" -ForegroundColor Cyan
Write-Host "  --------------------------" -ForegroundColor Cyan
Get-Service wuauserv | Select-Object Name, Status, StartType | Format-List
Write-Host ""

# ------------------------------------------------------------
# SECTION 9: TIME AND DATE SYNC
# ------------------------------------------------------------
Write-Host "  [9] TIME AND DATE SYNC" -ForegroundColor Cyan
Write-Host "  ----------------------" -ForegroundColor Cyan
Get-Service W32Time | Select-Object Name, Status | Format-List
w32tm /query /status 2>$null | Select-String "Source|Last Successful"
Write-Host ""

# ------------------------------------------------------------
# SECTION 10: BITLOCKER / DEVICE ENCRYPTION STATUS
# ------------------------------------------------------------
Write-Host "  [10] BITLOCKER / DEVICE ENCRYPTION" -ForegroundColor Cyan
Write-Host "  -----------------------------------" -ForegroundColor Cyan
try {
    Get-BitLockerVolume | Select-Object MountPoint, VolumeStatus, EncryptionPercentage, ProtectionStatus | Format-List
} catch {
    Write-Host "  BitLocker not available on this edition or not configured" -ForegroundColor Yellow
}
Write-Host ""

# ------------------------------------------------------------
# DONE
# ------------------------------------------------------------
Write-Host "  ============================================" -ForegroundColor White
Write-Host "  BASELINE DIAGNOSTIC COMPLETE" -ForegroundColor White
Write-Host "  Copy and paste the above results for logging" -ForegroundColor Gray
Write-Host "  ============================================" -ForegroundColor White
Write-Host ""
Pause
