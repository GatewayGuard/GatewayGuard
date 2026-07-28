# ================================================================
# FILE:    W11-SecurityHardening-v3-ascii18.ps1
# BUILD:   ascii18  |  Version 3.0
# PRODUCT: GatewayGuard Windows 11 Security Hardening Tool
# AUTHOR:  William F. Burns III
#          Former ISO, Port Authority of NY & NJ
#          Senior InfoSec, PSEG of NJ
#          Computer Forensics: EnCase Enterprise, FTK
# WEBSITE: gatewayguard.co
# USE:     Personal computers only. Run as Administrator.
# ================================================================
#Requires -Version 5.1
<#
.SYNOPSIS
    Windows 11 Security Hardening Tool v3.0
    Developed by William F. Burns III
    Former Information Security Officer, Port Authority of New York & New Jersey

.DESCRIPTION
    Automates security settings from the Windows 11 Security Walkthrough Guide.
    FOR PERSONAL COMPUTERS ONLY. No changes made without user approval.
    All actions logged to Desktop.

.NOTES
    Run as Administrator for full functionality.
    Compatible with Windows 11 Home and Pro editions.
#>

# ============================================================
# GLOBALS & INITIALIZATION
# ============================================================
$ScriptVersion  = "3.0"
$BuildID        = "ascii18"
$GuideURL       = "gatewayguard.co"

# AFFILIATE LINK PLACEHOLDERS -- replace with actual affiliate URLs before publishing
$AffiliateMalwarebytes = "https://gatewayguard.co/malwarebytes"     # AFFILIATE PLACEHOLDER
$AffiliateMicrosoft    = "https://gatewayguard.co/microsoft365"      # AFFILIATE PLACEHOLDER

$LogPath        = [Environment]::GetFolderPath('Desktop') + "\GatewayGuard-Log-$(Get-Date -Format 'yyyy-MM-dd_HH-mm').txt"
$FirstRunFlag   = "$env:USERPROFILE\AppData\Local\W11Hardening\firstrun.flag"
$LogEntries     = [System.Collections.Generic.List[string]]::new()

$global:BitLockerKeyGenerated = $false
$global:BitLockerKeyPath      = ""
$global:IsAdmin               = $false
$global:WinEdition            = "Unknown"
$global:IsFirstRun            = $true
$global:RAMGB                 = 0
$global:OnBattery             = $false
$global:SleepPrevented        = $false

# ============================================================
# STARTUP: CMD scroll buffer + screen saver suspension
# ============================================================
# Increase CMD/PowerShell scroll buffer so user can scroll back
try {
    $buf = $Host.UI.RawUI.BufferSize
    if ($buf.Height -lt 3000) { $buf.Height = 3000; $Host.UI.RawUI.BufferSize = $buf }
} catch {}

# Save and disable screen saver for this session
$global:OrigScreenSaverActive  = $null
$global:OrigScreenSaverTimeout = $null
$global:OrigVideoIdle          = $null
function Suspend-ScreenSaver {
    try {
        $desk = "HKCU:\Control Panel\Desktop"
        $global:OrigScreenSaverActive  = (Get-ItemProperty $desk -EA SilentlyContinue).ScreenSaveActive
        $global:OrigScreenSaverTimeout = (Get-ItemProperty $desk -EA SilentlyContinue).ScreenSaveTimeOut
        Set-ItemProperty $desk -Name ScreenSaveActive  -Value "0" -Force -EA SilentlyContinue
        Set-ItemProperty $desk -Name ScreenSaveTimeOut -Value "0" -Force -EA SilentlyContinue
        # Also set display timeout to Never for this session
        $global:OrigVideoIdle = (powercfg /query SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 2>$null) -match "Current AC.*0x(\w+)" | Out-Null
        powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0 2>$null | Out-Null
        powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0 2>$null | Out-Null
        powercfg /S SCHEME_CURRENT 2>$null | Out-Null
    } catch {}
}
function Restore-ScreenSaver {
    try {
        $desk = "HKCU:\Control Panel\Desktop"
        if ($null -ne $global:OrigScreenSaverActive)  { Set-ItemProperty $desk -Name ScreenSaveActive  -Value $global:OrigScreenSaverActive  -Force -EA SilentlyContinue }
        if ($null -ne $global:OrigScreenSaverTimeout) { Set-ItemProperty $desk -Name ScreenSaveTimeOut -Value $global:OrigScreenSaverTimeout -Force -EA SilentlyContinue }
        # Note: display timeout restore left to user -- too risky to guess original value
    } catch {}
}

# ============================================================
# SLEEP PREVENTION API
# ============================================================
Add-Type -Name "PowerMgmt" -Namespace "W11Hardening" -MemberDefinition @"
    [System.Runtime.InteropServices.DllImport("kernel32.dll")]
    public static extern uint SetThreadExecutionState(uint esFlags);
"@ -ErrorAction SilentlyContinue

function Enable-SleepPrevention {
    try {
        $ES_CONTINUOUS       = [uint32]0x80000000
        $ES_SYSTEM_REQUIRED  = [uint32]0x00000001
        $ES_DISPLAY_REQUIRED = [uint32]0x00000002
        [W11Hardening.PowerMgmt]::SetThreadExecutionState($ES_CONTINUOUS -bor $ES_SYSTEM_REQUIRED -bor $ES_DISPLAY_REQUIRED) | Out-Null
        $global:SleepPrevented = $true
        Write-Log -Message "Sleep/shutdown prevention activated" -Status "OK"
    } catch {
        Write-Log -Message "Could not activate sleep prevention: $_" -Status "WARN"
    }
}

function Disable-SleepPrevention {
    try {
        if ($global:SleepPrevented) {
            [W11Hardening.PowerMgmt]::SetThreadExecutionState([uint32]0x80000000) | Out-Null
            $global:SleepPrevented = $false
            Write-Log -Message "Sleep prevention deactivated -- normal power management restored" -Status "OK"
        }
    } catch {}
}

$null = Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action { Disable-SleepPrevention }

# ============================================================
# LOGGING
# ============================================================
function Write-Log {
    param([string]$Message, [string]$Status = "INFO")
    $entry = "[$(Get-Date -Format 'HH:mm:ss')] [$Status] $Message"
    $LogEntries.Add($entry)
    if (Test-Path (Split-Path $LogPath -Parent) -ErrorAction SilentlyContinue) {
        try { $entry | Out-File -FilePath $LogPath -Append -Encoding UTF8 -ErrorAction SilentlyContinue } catch {}
    }
}

function Save-Log {
    try {
        $logDir = Split-Path $LogPath -Parent
        if (-not (Test-Path $logDir)) { New-Item -Path $logDir -ItemType Directory -Force | Out-Null }
        $header = @"
============================================================
  GatewayGuard Windows 11 Security Hardening Tool v$ScriptVersion
  Build: $BuildID
  William F. Burns III | Former ISO, Port Authority NY & NJ
  Website: $GuideURL
  Run Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
  Computer: $env:COMPUTERNAME
  Windows Edition: $global:WinEdition
  Admin Mode: $global:IsAdmin
============================================================

"@
        $header | Out-File -FilePath $LogPath -Encoding UTF8
        $LogEntries | Out-File -FilePath $LogPath -Append -Encoding UTF8
        "`n============================================================"  | Out-File -FilePath $LogPath -Append -Encoding UTF8
        "Log complete. Keep this file -- it is your record of all changes made." | Out-File -FilePath $LogPath -Append -Encoding UTF8
        "If you need support, email this file to: support@gatewayguard.co"       | Out-File -FilePath $LogPath -Append -Encoding UTF8
        "============================================================"           | Out-File -FilePath $LogPath -Append -Encoding UTF8
        try {
            $backupDir = "C:\ProgramData\GatewayGuard\Logs"
            if (-not (Test-Path $backupDir)) { New-Item -Path $backupDir -ItemType Directory -Force | Out-Null }
            Copy-Item -Path $LogPath -Destination ($backupDir + "\" + (Split-Path $LogPath -Leaf)) -Force -EA SilentlyContinue
        } catch {}
    } catch {
        Write-Host "  Note: Could not save log file: $_" -ForegroundColor Yellow
    }
}

# ============================================================
# HELPER: DRAW BOX
# ============================================================
function Draw-Box {
    param(
        [string[]]$Lines,
        [System.ConsoleColor]$Color = "Cyan"
    )
    # Auto-size width to the longest content line (minimum 44)
    $Width = 44
    foreach ($line in $Lines) {
        if ($line -ne "---" -and $line.Length -gt $Width) { $Width = $line.Length }
    }
    $border = "+" + ("=" * $Width) + "+"
    Write-Host $border -ForegroundColor $Color
    foreach ($line in $Lines) {
        if ($line -eq "---") {
            Write-Host $border -ForegroundColor $Color
        } else {
            Write-Host ("|" + $line.PadRight($Width) + "|") -ForegroundColor $Color
        }
    }
    Write-Host $border -ForegroundColor $Color
}

# ============================================================
# HELPER: PAUSE (press any key)
# ============================================================
function Pause-ForUser {
    param([string]$Message = "  Press any key to continue...")
    Write-Host ""
    Write-Host $Message -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# ============================================================
# HELPER: CONFIRM EXIT
# ============================================================
function Confirm-Exit {
    param([string]$Reason = "")
    Write-Host ""
    Write-Host "  Are you sure you want to exit? No changes will be saved." -ForegroundColor Yellow
    if ($Reason) { Write-Host "  $Reason" -ForegroundColor Gray }
    $c = Read-Host "  Exit now? (Y/N)"
    if ($c.ToUpper() -eq "Y") {
        Write-Log -Message "User confirmed exit" -Status "EXIT"
        Disable-SleepPrevention
        Restore-ScreenSaver
        Save-Log
        exit
    }
}

# ============================================================
# SCREEN 0: FONT INSTRUCTIONS (VERY FIRST SCREEN)
# ============================================================
function Show-FontInstructions {
    Clear-Host
    Write-Host ""
    Write-Host "  +==============================================================+" -ForegroundColor Yellow
    Write-Host "  |  STEP 1 OF 2: SET YOUR CONSOLE FONT (takes 30 seconds)       |" -ForegroundColor Yellow
    Write-Host "  +==============================================================+" -ForegroundColor Yellow
    Write-Host ""
    Write-Host ("  Running: " + (Split-Path -Leaf $PSCommandPath)) -ForegroundColor DarkCyan
    Write-Host "  Version: GatewayGuard v$ScriptVersion  Build: $BuildID" -ForegroundColor DarkCyan
    Write-Host ""
    Write-Host "  This tool uses box-drawing characters. For best display:" -ForegroundColor White
    Write-Host ""
    Write-Host "  1. Right-click the title bar of this window" -ForegroundColor Cyan
    Write-Host "  2. Click Properties (or Defaults)" -ForegroundColor Cyan
    Write-Host "  3. Click the Font tab" -ForegroundColor Cyan
    Write-Host "  4. Set Font to: Consolas  or  Lucida Console" -ForegroundColor Cyan
    Write-Host "  5. Set Size to: 14  (or larger if text is hard to read)" -ForegroundColor Cyan
    Write-Host "  6. Click OK" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  WHY: Without the right font, boxes may show as question marks" -ForegroundColor Gray
    Write-Host "  or garbled characters. The tool works either way -- this just" -ForegroundColor Gray
    Write-Host "  makes it easier to read." -ForegroundColor Gray
    Write-Host ""
    Write-Host "  If the boxes below look correct, you are all set:" -ForegroundColor White
    Write-Host ""
    Draw-Box -Color Green -Lines @(
        "  FONT CHECK: If this box has clean lines, you are ready.   ",
        "  +--+  Good: straight lines and corners                    ",
        "  |  |  Good: text is a comfortable reading size            "
    )
    Write-Host ""
    Pause-ForUser "  Font looks good? Press any key to continue..."

    # ── WHAT TO EXPECT: Pre-flight explanation ──
    Clear-Host
    Write-Host ""
    Draw-Box -Color Cyan -Lines @(
        "  WHAT HAPPENS NEXT -- PLEASE READ                          ",
        "---",
        "  This tool runs a series of quick checks before reaching   ",
        "  the main security settings. Some screens appear briefly   ",
        "  and move on automatically -- this is normal.              ",
        "                                                             ",
        "  PRE-FLIGHT CHECKS (you will see these in order):          ",
        "  1. Personal computer confirmation                          ",
        "  2. Domain / corporate network check                       ",
        "  3. Administrator access check                             ",
        "  4. Windows edition detection (Home vs Pro)                ",
        "  5. RAM check                                              ",
        "  6. First-run vs returning user check                      ",
        "  7. Security scan confirmation (Defender + Malwarebytes)   ",
        "  8. Antivirus detection and status                         ",
        "  9. Battery / power status check                           ",
        " 10. Power settings (optional)                              ",
        " 11. Apps audit (installed apps review)                     ",
        "                                                             ",
        "  Screens that require your input will PAUSE and wait.      ",
        "  Quick status confirmations (green OK messages) will show  ",
        "  briefly and move on -- nothing is skipped silently.       ",
        "                                                             ",
        "  After all checks pass, you reach the main security        ",
        "  settings checklist where YOU control what gets changed.   "
    )
    Write-Host ""
    Pause-ForUser "  Ready to begin? Press any key to start pre-flight checks..."
}

# ============================================================
# STEP 1: COMPANY COMPUTER WARNING
# ============================================================
function Test-PersonalComputer {
    Clear-Host
    Write-Host ""
    Draw-Box -Color Red -Lines @(
        "  !  IMPORTANT -- READ BEFORE CONTINUING                    ",
        "---",
        "  THIS TOOL IS FOR PERSONAL COMPUTERS ONLY.                 ",
        "                                                             ",
        "  DO NOT run this tool on:                                   ",
        "  * A computer owned or managed by your employer             ",
        "  * A school or university-managed computer                  ",
        "  * Any computer you do not personally own                   ",
        "  * Computers connected to a corporate network or domain     ",
        "                                                             ",
        "  WHY: This tool modifies Windows security settings at the   ",
        "  system level. On a company PC, these changes may:          ",
        "  * Violate your employer's IT policy                        ",
        "  * Break access to company systems and VPN                  ",
        "  * Trigger security alerts on corporate networks            ",
        "  * Put you in violation of your employment agreement        ",
        "                                                             ",
        "  NOTE: Having a work email added to your personal PC does   ",
        "  NOT make it a company computer -- only if your employer's  ",
        "  IT department manages the PC itself.                       ",
        "                                                             ",
        "  By continuing, you confirm this is YOUR personal PC        ",
        "  and you have the right to modify its settings.             "
    )
    Write-Host ""
    do {
        $confirm = Read-Host "  Is this YOUR personal computer? (Y = Yes / N = Exit)"
        if ($confirm.ToUpper() -eq "N") {
            Write-Host ""
            Write-Host "  Exiting. No changes made." -ForegroundColor Yellow
            Write-Host "  To secure a company PC, contact your IT department." -ForegroundColor Gray
            Write-Host ""
            Write-Log -Message "User confirmed not personal PC -- exit" -Status "EXIT"
            Save-Log
            exit
        }
    } while ($confirm.ToUpper() -ne "Y")
    Write-Log -Message "Personal computer confirmed by user" -Status "CONFIRM"
}

# ============================================================
# STEP 2: DOMAIN CHECK
# ============================================================
function Test-DomainJoin {
    try {
        $cs = Get-WmiObject Win32_ComputerSystem -ErrorAction Stop
        if ($cs.PartOfDomain) {
            $domainName = $cs.Domain
            Clear-Host
            Write-Host ""
            Draw-Box -Color Yellow -Lines @(
                "  !  THIS PC APPEARS TO BE DOMAIN-JOINED                    ",
                "---",
                "  Domain detected: $domainName",
                "                                                             ",
                "  This usually means the PC is managed by an employer,      ",
                "  school, or organization. This tool should NOT be run       ",
                "  on managed or corporate computers.                         ",
                "                                                             ",
                "  If you set up a home lab domain yourself and this IS       ",
                "  your personal PC, you may continue -- but some settings    ",
                "  may conflict with your home domain configuration.          ",
                "                                                             ",
                "  If this PC was provided by an employer or school,          ",
                "  exit now and contact your IT department.                   "
            )
            Write-Host ""
            do {
                $confirm = Read-Host "  Continue? (Y = This is my personal PC / N = Exit)"
                if ($confirm.ToUpper() -eq "N") {
                    Write-Host ""
                    Write-Host "  Exiting. No changes made." -ForegroundColor Yellow
                    Save-Log; exit
                }
            } while ($confirm.ToUpper() -ne "Y")
            Write-Log -Message "Domain-joined PC ($domainName) -- user confirmed personal use" -Status "WARN"
            Pause-ForUser
        } else {
            Write-Log -Message "Domain check passed -- not domain joined" -Status "OK"
        }
    } catch {
        Write-Log -Message "Domain check error: $_" -Status "WARN"
    }
}

# ============================================================
# STEP 3: ADMIN CHECK
# ============================================================
function Test-AdminAccess {
    $global:IsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")

    if (-not $global:IsAdmin) {
        Clear-Host
        Write-Host ""
        Draw-Box -Color Yellow -Lines @(
            "  !  ADMINISTRATOR ACCESS REQUIRED                          ",
            "---",
            "  This tool is running as a STANDARD USER.                  ",
            "  Most security settings require Administrator access.       ",
            "                                                             ",
            "  TO RUN WITH FULL ACCESS:                                   ",
            "  * Close this window                                        ",
            "  * Right-click the tool -> Run as Administrator             ",
            "  * Enter admin password if prompted                         ",
            "                                                             ",
            "  WHAT YOU CAN STILL DO WITHOUT ADMIN:                      ",
            "  * Run Defender and Malwarebytes scans                      ",
            "  * Check Windows Update status                              ",
            "  * Review installed apps list                               ",
            "  * Turn off Advertising ID (your account only)              ",
            "                                                             ",
            "  LIMITED MODE will now run -- admin-only settings           ",
            "  will be skipped and flagged in the log.                    "
        )
        Write-Host ""
        do {
            $cont = Read-Host "  Continue in Limited Mode? (Y = Continue / N = Exit to re-run as Admin)"
            if ($cont.ToUpper() -eq "N") {
                Write-Host "  Close this window and right-click -> Run as Administrator." -ForegroundColor Yellow
                Save-Log; exit
            }
        } while ($cont.ToUpper() -ne "Y")
        Write-Log -Message "Running in Limited Mode (no admin access)" -Status "WARN"
        Pause-ForUser
    } else {
        Write-Host ""
        Write-Host "  OK  Administrator access confirmed -- full access available." -ForegroundColor Green
        Write-Log -Message "Administrator access confirmed" -Status "OK"
        Pause-ForUser
    }
}

# ============================================================
# STEP 4: WINDOWS EDITION DETECTION
# NOTE: Uses WMI ONLY -- Get-WindowsEdition -Online causes infinite loop
# ============================================================
function Get-WinEdition {
    try {
        # Use registry -- fastest and no loop risk
        $regEdition = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -EA Stop).EditionID
        $global:WinEdition = if ($regEdition) { $regEdition } else { "Unknown" }
    } catch {
        try {
            $caption = (Get-WmiObject Win32_OperatingSystem -EA Stop).Caption
            $global:WinEdition = if ($caption -match "Pro") { "Professional" }
                                 elseif ($caption -match "Home") { "Home" }
                                 elseif ($caption -match "Enterprise") { "Enterprise" }
                                 elseif ($caption -match "Education") { "Education" }
                                 else { "Unknown" }
        } catch {
            $global:WinEdition = "Unknown"
        }
    }
    Write-Log -Message "Windows Edition: $global:WinEdition" -Status "INFO"

    $isHome = $global:WinEdition -notmatch "Pro|Enterprise|Education|Business"
    if ($isHome) {
        Clear-Host
        Write-Host ""
        Draw-Box -Color Cyan -Lines @(
            "  WINDOWS EDITION: HOME                                       ",
            "---",
            "  Remote Desktop hosting is not available on Home Edition.    ",
            "  BitLocker uses Device Encryption on Home -- handled         ",
            "  automatically by this tool.                                 "
        )
        Write-Host ""
        Write-Log -Message "Home edition -- Remote Desktop and Group Policy unavailable" -Status "INFO"
        Pause-ForUser
    } else {
        Write-Host ""
        Write-Host "  OK  Windows Edition: $global:WinEdition" -ForegroundColor Green
        Write-Host ""
        Start-Sleep -Seconds 1
    }
}

# ============================================================
# STEP 5: RAM CHECK
# ============================================================
function Get-RAMStatus {
    try {
        $ramBytes = (Get-WmiObject Win32_ComputerSystem).TotalPhysicalMemory
        $global:RAMGB = [math]::Round($ramBytes / 1GB)
        if ($global:RAMGB -le 8) {
            Clear-Host
            Write-Host ""
            Draw-Box -Color Yellow -Lines @(
                "  YOUR PC -- RAM: $($global:RAMGB) GB",
                "---",
                "  All security settings in this tool will run fine.          ",
                "                                                              ",
                "  EXCEPTION -- BITLOCKER ENCRYPTION:                         ",
                "  BitLocker can take several hours on this PC.               ",
                "  Schedule it to run overnight -- select option 2            ",
                "  (Enable overnight) when you reach the BitLocker screen.    ",
                "  Plug into AC power and set Sleep to Never before leaving.  "
            )
            Write-Host ""
            Write-Log -Message "RAM: $($global:RAMGB) GB (minimal)" -Status "WARN"
            Pause-ForUser
        } elseif ($global:RAMGB -le 16) {
            Write-Host ""
            Write-Host "  Your PC has $($global:RAMGB) GB RAM -- most operations will run smoothly." -ForegroundColor Cyan
            Write-Host "  Tip: Schedule scans during idle or overnight times for best results." -ForegroundColor Gray
            Write-Host ""
            Start-Sleep -Seconds 2
            Write-Log -Message "RAM: $($global:RAMGB) GB (moderate)" -Status "INFO"
        } else {
            Write-Log -Message "RAM: $($global:RAMGB) GB (ample)" -Status "INFO"
        }
    } catch {
        $global:RAMGB = 0
        Write-Log -Message "Could not determine RAM: $_" -Status "WARN"
    }
}

# ============================================================
# STEP 6: FIRST RUN CHECK
# ============================================================
function Test-FirstRun {
    $global:IsFirstRun = -not (Test-Path $FirstRunFlag)
}

function Set-FirstRunComplete {
    $dir = Split-Path $FirstRunFlag
    if (-not (Test-Path $dir)) { New-Item -Path $dir -ItemType Directory -Force | Out-Null }
    "$(Get-Date)" | Out-File -FilePath $FirstRunFlag -Encoding UTF8
}

# ============================================================
# STEP 7: PRE-SCAN GATE
# ============================================================
function Show-PreScanGate {
    Clear-Host
    Write-Host ""

    if ($global:IsFirstRun) {
        Draw-Box -Color Red -Lines @(
            "  REQUIRED: COMPLETE BOTH SCANS BEFORE CONTINUING            ",
            "---",
            "  Before applying any security settings, your PC must be     ",
            "  confirmed CLEAN of malware and viruses.                    ",
            "  Applying hardening settings on an infected PC can          ",
            "  hide malware and make it HARDER to detect later.           ",
            "                                                             ",
            "  STEP 1 OF 2: DEFENDER OFFLINE SCAN                        ",
            "  This scan runs BEFORE Windows loads -- catches rootkits    ",
            "  and malware that hide during normal operation.             ",
            "                                                             ",
            "  How to run:                                                ",
            "  1. Open Windows Security (search in Start menu)            ",
            "  2. Click Virus & threat protection                         ",
            "  3. Click Scan options                                      ",
            "  4. Select Microsoft Defender Antivirus (offline scan)      ",
            "  5. Click Scan now -- your PC will restart                  ",
            "  6. Blue scan screen runs 10-20 minutes, then PC reboots    ",
            "  7. Check Windows Security -> Protection history for results",
            "  Guide: Phase 1, Step 2                                     ",
            "                                                             ",
            "  STEP 2 OF 2: MANUAL MALWAREBYTES FREE SCAN                ",
            "  Malwarebytes Free is a helpful companion -- not required,  ",
            "  but it catches PUPs and adware that Defender misses.       ",
            "  Free download: $AffiliateMalwarebytes",
            "                                                             ",
            "  How to run:                                                ",
            "  1. Download and install Malwarebytes Free                  ",
            "  2. On first launch: SKIP real-time protection setup        ",
            "     (shown as: I'll risk it / Not now / Skip)              ",
            "  3. Run a Threat Scan (15-45 minutes)                       ",
            "  4. Quarantine ALL detected items                           ",
            "  5. Confirm Defender is still active in Windows Security    ",
            "  6. If Malwarebytes Free shows as active AV:                ",
            "     Open Malwarebytes -> Settings -> Account ->             ",
            "     Deactivate Premium Trial -> confirm Defender is active  ",
            "  Guide: Phase 3, Step 4                                     "
        )
        Write-Host ""
        Write-Host "  Complete BOTH scans above, then return here to continue." -ForegroundColor Yellow
        Write-Host ""

        do {
            $done = Read-Host "  Have you completed BOTH scans? (Y = Yes, continue / N = Exit to run scans)"
            if ($done.ToUpper() -eq "N") {
                Write-Host ""
                Write-Host "  Please complete both scans first, then relaunch this tool." -ForegroundColor Yellow
                Write-Host "  This ensures your PC is clean before hardening begins." -ForegroundColor Gray
                Write-Host ""
                Write-Log -Message "User exited to complete pre-scans" -Status "EXIT"
                Save-Log; exit
            }
        } while ($done.ToUpper() -ne "Y")
        Write-Log -Message "User confirmed Defender Offline scan and Malwarebytes scan complete" -Status "CONFIRM"

    } else {
        Draw-Box -Color Yellow -Lines @(
            "  REMINDER: PRE-SCAN RECOMMENDED                             ",
            "---",
            "  This is a repeat run of the hardening tool.                ",
            "  For ongoing protection, run monthly:                       ",
            "  * Manual Malwarebytes Free scan ($AffiliateMalwarebytes)",
            "  * Defender Offline Scan quarterly or if issues arise       ",
            "  Guide: Phase 5 -- Scheduled Scanning                       "
        )
        Write-Host ""
        do {
            $cont = Read-Host "  Continue with hardening tool? (Y = Continue / N = Exit)"
            if ($cont.ToUpper() -eq "N") { Save-Log; exit }
        } while ($cont.ToUpper() -ne "Y")
        Write-Log -Message "Repeat run -- user confirmed to continue" -Status "CONFIRM"
    }
}

# ============================================================
# STEP 8: VERIFY DEFENDER IS PRIMARY AV
# Uses SecurityCenter2 WMI ONLY -- no registry
# ============================================================
function Test-DefenderPrimary {
    Clear-Host
    Write-Host ""
    Write-Host "  Checking antivirus status..." -ForegroundColor Cyan
    Write-Host ""

    try {
        $avProducts = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -ErrorAction Stop
        $defender   = $avProducts | Where-Object { $_.displayName -match "Windows Defender|Microsoft Defender" }
        $nonDefender = $avProducts | Where-Object { $_.displayName -notmatch "Windows Defender|Microsoft Defender" }
        $mbFree     = $avProducts | Where-Object { $_.displayName -match "Malwarebytes" }

        # ── Detect Russian / Chinese AV -- strong uninstall recommendation ──
        $riskyAV = $avProducts | Where-Object {
            $dn = $_.displayName
            ($HighRiskAVList | Where-Object { $dn -match $_ }).Count -gt 0
        }
        if ($riskyAV) {
            $riskyName = if ($riskyAV[0].displayName) { $riskyAV[0].displayName } else { "A high-risk antivirus" }
            Clear-Host
            Write-Host ""
            Draw-Box -Color Red -Lines @(
                "  !!!!!  CRITICAL SECURITY WARNING  !!!!!                    ",
                "---",
                "  HIGH-RISK ANTIVIRUS DETECTED: $riskyName",
                "---",
                "  This antivirus is made by a company based in RUSSIA or     ",
                "  CHINA. The U.S. Cybersecurity and Infrastructure Security  ",
                "  Agency (CISA), FBI, and independent security researchers   ",
                "  have documented these products:                            ",
                "                                                              ",
                "  * Sending files and browsing data to foreign servers       ",
                "  * Providing access to foreign government intelligence       ",
                "  * Operating as spyware while appearing as protection       ",
                "                                                              ",
                "  !! YOU ARE AT RISK AS LONG AS THIS SOFTWARE IS INSTALLED  ",
                "                                                              ",
                "  WHAT TO DO -- RIGHT NOW:                                   ",
                "  1. UNINSTALL: Settings -> Apps -> $riskyName -> Uninstall",
                "  2. RESTART your PC after uninstalling                      ",
                "  3. Confirm Microsoft Defender is active in Windows Security",
                "  4. Optional companion: Malwarebytes FREE (manual scans)   ",
                "     $AffiliateMalwarebytes",
                "     (Free version only -- do NOT activate real-time)        ",
                "                                                              ",
                "  Microsoft Defender is a fully capable, FREE antivirus      ",
                "  built into Windows. You do not need a paid foreign product."
            )
            Write-Host ""
            Write-Log -Message "HIGH-RISK AV detected: $riskyName" -Status "WARN"
            do {
                $cont = Read-Host "  Continue anyway? (Y = Yes, continue / N = Exit to uninstall first)"
                if ($cont.ToUpper() -eq "N") {
                    Write-Host ""
                    Write-Host "  Uninstall $riskyName, then relaunch this tool." -ForegroundColor Yellow
                    Disable-SleepPrevention; Save-Log; exit
                }
            } while ($cont.ToUpper() -ne "Y")
            Pause-ForUser
        }

        if ($mbFree) {
            # Malwarebytes Free or trial is registered -- check if it took over real-time
            $mbState = $mbFree[0].productState
            $mbRealtime = ([int]$mbState -band 0x1000) -gt 0
            if ($mbRealtime -and -not $defender) {
                Clear-Host
                Write-Host ""
                Draw-Box -Color Yellow -Lines @(
                    "  !  MALWAREBYTES IS CURRENTLY ACTIVE AS PRIMARY AV        ",
                    "---",
                    "  Malwarebytes Free started a Premium trial and took over  ",
                    "  real-time protection from Microsoft Defender.             ",
                    "                                                            ",
                    "  This needs to be fixed before hardening so that Defender  ",
                    "  is your primary, always-on AV shield.                    ",
                    "                                                            ",
                    "  TO FIX:                                                  ",
                    "  1. Open Malwarebytes                                     ",
                    "  2. Click Settings (gear icon)                            ",
                    "  3. Click Account                                          ",
                    "  4. Click Deactivate Premium Trial                        ",
                    "  5. Close and reopen Windows Security -- Defender          ",
                    "     should now show as active                             ",
                    "                                                            ",
                    "  Malwarebytes Free is a helpful companion for manual      ",
                    "  scans -- it is NOT meant to replace Defender.            ",
                    "  Guide: Phase 3, Step 4                                   "
                )
                Write-Host ""
                do {
                    $cont = Read-Host "  Continue anyway? (Y = Yes / N = Fix this first, then re-run)"
                    if ($cont.ToUpper() -eq "N") {
                        Write-Host "  Fix Defender status, then relaunch this tool." -ForegroundColor Yellow
                        Write-Log -Message "Exited -- Malwarebytes trial taking over real-time protection" -Status "WARN"
                        Disable-SleepPrevention; Save-Log; exit
                    }
                } while ($cont.ToUpper() -ne "Y")
                Write-Log -Message "Continuing with Malwarebytes active as primary AV" -Status "WARN"
                Pause-ForUser
                return
            }
        }

        # Check actual Defender real-time state directly -- most reliable source of truth
        try {
            $mpStatus = Get-MpComputerStatus -EA Stop
            $defenderRTOn = $mpStatus.RealTimeProtectionEnabled
        } catch {
            $defenderRTOn = $false
        }

        # Determine if MB Free is the only non-Defender AV (companion scenario -- OK)
        $nonMbNonDefender = $nonDefender | Where-Object { $_.displayName -notmatch "Malwarebytes" }

        if ($defenderRTOn) {
            # Defender real-time IS on -- this is the healthy state
            if ($mbFree -and -not ($mbFree | Where-Object { ([int]$_.productState -band 0x1000) -gt 0 })) {
                # MB Free installed as companion, not taking over real-time
                Clear-Host
                Write-Host ""
                Draw-Box -Color Green -Lines @(
                    "  OK  ANTIVIRUS STATUS -- HEALTHY SETUP                    ",
                    "---",
                    "  Microsoft Defender: ACTIVE as primary real-time AV       ",
                    "  Malwarebytes Free:  Installed as manual-scan companion    ",
                    "                                                            ",
                    "  This is the RECOMMENDED setup:                           ",
                    "  * Defender provides always-on real-time protection        ",
                    "  * Malwarebytes Free adds manual scan capability for       ",
                    "    catching PUPs and adware Defender sometimes misses      ",
                    "  * Malwarebytes Free does NOT interfere with Defender      ",
                    "                                                            ",
                    "  What you see in Windows Security:                        ",
                    "  Both apps may appear under Virus & threat protection.    ",
                    "  Defender is listed as 'On' -- this is correct.           ",
                    "  Malwarebytes shows as installed but is NOT your primary  ",
                    "  AV shield -- it is a companion tool only.                "
                )
                Write-Host ""
                Write-Log -Message "Defender active as primary AV. MB Free installed as companion." -Status "OK"
                Pause-ForUser
            } else {
                Write-Host ""
                Write-Host "  OK  Microsoft Defender is active as primary AV." -ForegroundColor Green
                Write-Log -Message "Defender confirmed as primary AV" -Status "OK"
                Pause-ForUser
            }
        } elseif ($nonMbNonDefender) {
            # A different 3rd-party AV is active, not MB
            $avName = $nonMbNonDefender[0].displayName
            Clear-Host
            Write-Host ""
            Draw-Box -Color Yellow -Lines @(
                "  !  MICROSOFT DEFENDER IS NOT YOUR PRIMARY ANTIVIRUS     ",
                "---",
                "  Active AV detected: $avName",
                "                                                           ",
                "  Microsoft Defender is not currently the active           ",
                "  real-time protection on this PC.                         ",
                "                                                           ",
                "  You may continue without fixing this, but some           ",
                "  Defender settings may not apply correctly.               ",
                "  Guide: Phase 3, Step 4                                   "
            )
            Write-Host ""
            do {
                $cont = Read-Host "  Continue anyway? (Y = Continue / N = Fix first, then re-run)"
                if ($cont.ToUpper() -eq "N") {
                    Write-Host "  Fix Defender status and relaunch the tool." -ForegroundColor Yellow
                    Write-Log -Message "Exited -- non-Defender AV active: $avName" -Status "WARN"
                    Disable-SleepPrevention; Save-Log; exit
                }
            } while ($cont.ToUpper() -ne "Y")
            Write-Log -Message "Continuing with non-Defender AV active: $avName" -Status "WARN"
            Pause-ForUser
        } else {
            # Defender real-time is off and no known 3rd-party AV
            Clear-Host
            Write-Host ""
            Draw-Box -Color Red -Lines @(
                "  !!  DEFENDER REAL-TIME PROTECTION IS OFF                 ",
                "---",
                "  Microsoft Defender real-time protection is not active.   ",
                "  Your PC may be unprotected from malware and viruses.     ",
                "                                                            ",
                "  TO CHECK AND FIX:                                        ",
                "  1. Open Windows Security (Start -> search 'Windows Security')",
                "  2. Click Virus & threat protection                        ",
                "  3. Under Virus & threat protection settings, click Manage settings",
                "  4. Turn Real-time protection ON                           ",
                "                                                            ",
                "  If Tamper Protection is on, you may need to toggle it    ",
                "  off briefly, enable real-time protection, then re-enable  ",
                "  Tamper Protection.                                        "
            )
            Write-Host ""
            do {
                $cont = Read-Host "  Continue anyway? (Y = Continue / N = Fix Defender first)"
                if ($cont.ToUpper() -eq "N") {
                    Write-Host "  Enable Defender real-time protection, then relaunch." -ForegroundColor Yellow
                    Write-Log -Message "Exited -- Defender real-time protection is OFF" -Status "WARN"
                    Disable-SleepPrevention; Save-Log; exit
                }
            } while ($cont.ToUpper() -ne "Y")
            Write-Log -Message "Continuing with Defender real-time OFF" -Status "WARN"
            Pause-ForUser
        }
    } catch {
        Write-Host "  Could not verify AV status -- continuing with caution." -ForegroundColor Yellow
        Write-Log -Message "AV status check error: $_" -Status "WARN"
        Start-Sleep -Seconds 1
    }
}

# ============================================================
# STEP 9: POWER CHECK & BATTERY DETECTION
# ============================================================
function Test-PowerStatus {
    Clear-Host
    Write-Host ""
    Write-Host "  Checking power status..." -ForegroundColor Cyan

    try {
        $battery = Get-WmiObject -Class Win32_Battery -ErrorAction SilentlyContinue
        $hasBattery = ($null -ne $battery)
        $global:OnBattery = ($hasBattery -and $battery.BatteryStatus -eq 1)
        $batteryPct = if ($hasBattery -and $battery.EstimatedChargeRemaining) { "$($battery.EstimatedChargeRemaining)%" } else { "N/A" }
    } catch {
        $global:OnBattery = $false
        $batteryPct = "Unknown"
        $hasBattery = $false
    }

    Enable-SleepPrevention

    if ($global:OnBattery) {
        Write-Host ""
        Draw-Box -Color Yellow -Lines @(
            "  !  RUNNING ON BATTERY POWER                              ",
            "---",
            "  Battery level: $batteryPct",
            "                                                            ",
            "  Most settings apply in seconds and are safe on battery.  ",
            "                                                            ",
            "  EXCEPTION -- BITLOCKER:                                   ",
            "  BitLocker can take several hours. If the PC loses power   ",
            "  mid-encryption, the drive may be unrecoverable.           ",
            "  Plug in AC power before running BitLocker.                ",
            "                                                            ",
            "  Sleep prevention is now ACTIVE for this session.         "
        )
        Write-Host ""
        Write-Log -Message "Running on battery -- battery level: $batteryPct" -Status "WARN"
        do {
            $cont = Read-Host "  Continue on battery? (Y = Continue / N = Plug in and relaunch)"
            if ($cont.ToUpper() -eq "N") {
                Write-Host ""
                Write-Host "  Plug in AC power and relaunch the tool." -ForegroundColor Yellow
                Disable-SleepPrevention; Save-Log; exit
            }
        } while ($cont.ToUpper() -ne "Y")
    } else {
        Write-Host ""
        if ($hasBattery) {
            Write-Host "  OK  Plugged into AC power -- battery present but not draining." -ForegroundColor Green
            Write-Host "      Battery level: $batteryPct  |  Safe to run all settings including BitLocker." -ForegroundColor DarkGray
        } else {
            Write-Host "  OK  AC power -- desktop PC (no battery detected)." -ForegroundColor Green
        }
        Write-Host "  OK  Sleep prevention active -- PC will not sleep during this run." -ForegroundColor Green
        Write-Host "      (Sleep prevention stays on until the tool finishes or you exit.)" -ForegroundColor DarkGray
        Write-Log -Message "AC power confirmed. Battery present: $hasBattery. Sleep prevention active." -Status "OK"
        Pause-ForUser
    }
}

# ============================================================
# STEP 10: POWER SETTINGS CHECK
# ============================================================
function Run-PowerSettingsCheck {
    Clear-Host
    Write-Host ""
    Write-Host "  Checking power-related security settings..." -ForegroundColor Cyan
    Start-Sleep -Milliseconds 500

    $results = @{}

    # 1. Password on wake
    try {
        $pw = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>$null
        $acVal = if ($pw -match "Current AC Power Setting Index: 0x(\w+)") { [int]"0x$($Matches[1])" } else { $null }
        $results["PasswordOnWake"] = if ($acVal -eq 1) { "REQUIRED -- GOOD" } else { "NOT required -- change recommended" }
    } catch { $results["PasswordOnWake"] = "Unknown" }

    # 2. Fast Startup
    try {
        $fs = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -EA Stop).HiberbootEnabled
        $results["FastStartup"] = if ($fs -eq 0) { "DISABLED -- GOOD" } else { "ENABLED -- change recommended" }
    } catch { $results["FastStartup"] = "Unknown" }

    # 3. Wake on LAN
    try {
        $adapters = Get-NetAdapter -Physical -EA Stop | Where-Object { $_.Status -eq "Up" }
        $wolEnabled = $false
        foreach ($a in $adapters) {
            $wol = Get-NetAdapterPowerManagement -Name $a.Name -EA SilentlyContinue
            if ($wol -and $wol.WakeOnMagicPacket -eq "Enabled") { $wolEnabled = $true }
        }
        $results["WakeOnLAN"] = if ($wolEnabled) { "ENABLED -- change recommended" } else { "DISABLED -- GOOD" }
    } catch { $results["WakeOnLAN"] = "Unknown" }

    # 4. Screen timeout
    try {
        $st = powercfg /query SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 2>$null
        $acTimeout = if ($st -match "Current AC Power Setting Index: 0x(\w+)") { [int]"0x$($Matches[1])" } else { 0 }
        $minutes = [math]::Round($acTimeout / 60)
        $results["ScreenTimeout"] = if ($acTimeout -eq 0) { "NEVER -- set to 5 min recommended" }
                                    elseif ($minutes -le 5) { "${minutes} min -- GOOD" }
                                    else { "${minutes} min -- reduce to 5 min recommended" }
    } catch { $results["ScreenTimeout"] = "Could not read -- set manually" }

    # 5. Critical battery action (laptop only -- skip gracefully on desktops)
    try {
        $battery = Get-WmiObject -Class Win32_Battery -EA SilentlyContinue
        if ($null -eq $battery) {
            $results["CriticalBattery"] = "N/A -- desktop (no battery)"
        } else {
            $cb = powercfg /query SCHEME_CURRENT SUB_BATTERY BATACTIONCRIT 2>$null
            $cbVal = if ($cb -match "Current DC Power Setting Index: 0x(\w+)") { [int]"0x$($Matches[1])" } else { $null }
            $results["CriticalBattery"] = switch ($cbVal) {
                0       { "DO NOTHING -- change to Hibernate recommended" }
                1       { "Sleep -- Hibernate preferred for data safety" }
                2       { "HIBERNATE -- GOOD" }
                3       { "SHUTDOWN -- GOOD" }
                default { "Unknown -- check manually in Power settings" }
            }
        }
    } catch { $results["CriticalBattery"] = "N/A -- desktop (no battery)" }

    # Display results
    Clear-Host
    Write-Host ""
    Draw-Box -Color Cyan -Lines @(
        "  POWER SETTINGS -- SECURITY REVIEW                          ",
        "---",
        "  These settings affect your PC's security between sessions. ",
        "  Review each one below -- changes are optional.             ",
        "---",
        "  [1] Password required on wake:   $($results['PasswordOnWake'])",
        "      WHY: Without this, anyone can open your PC from sleep. ",
        "---",
        "  [2] Fast Startup:                $($results['FastStartup'])",
        "      WHY: Fast Startup skips a full shutdown, which means   ",
        "      Windows does not fully reset between sessions. Disabling",
        "      ensures a clean security state every time you boot.     ",
        "---",
        "  [3] Wake on LAN:                 $($results['WakeOnLAN'])",
        "      WHY: Allows someone on your network to remotely wake   ",
        "      your PC. Safe to disable if you don't use this feature. ",
        "---",
        "  [4] Screen timeout (AC power):   $($results['ScreenTimeout'])",
        "      WHY: A screen that never turns off leaves your PC       ",
        "      visually accessible. Set to 5 min in Settings ->        ",
        "      System -> Power & sleep. (Advisory only -- not changed) ",
        "---",
        "  [5] Critical battery action:     $($results['CriticalBattery'])",
        "      WHY: If the battery dies mid-operation, open files are  ",
        "      lost unless an action is set. Hibernate saves your      ",
        "      session before power runs out. (Desktop PCs show N/A -- ",
        "      laptops will show current setting and offer to change.)  ",
        "---",
        "  Sleep prevention (this session): ACTIVE -- this tool is      ",
        "  keeping your PC awake for the duration of this run.         ",
        "  Normal sleep resumes after you exit or the tool finishes.   "
    )
    Write-Host ""
    Write-Log -Message "Power settings: PW=$($results['PasswordOnWake']) FastStart=$($results['FastStartup']) WOL=$($results['WakeOnLAN']) Screen=$($results['ScreenTimeout']) CritBatt=$($results['CriticalBattery'])" -Status "INFO"

    Write-Host "  Review each setting below and choose Y/N individually." -ForegroundColor Yellow
    Write-Host "  All are optional -- choose what fits your situation." -ForegroundColor Gray
    Write-Host ""

    $powerChoices = @{}

    # 1. Password on wake
    if ($results["PasswordOnWake"] -notmatch "GOOD|N/A") {
        Write-Host "  [1] Password required on wake" -ForegroundColor White
        Write-Host "      Current:  $($results['PasswordOnWake'])" -ForegroundColor Gray
        Write-Host "      Change to: REQUIRED -- prevents unlocked screen access" -ForegroundColor Cyan
        $powerChoices["PasswordOnWake"] = (Read-Host "      Apply? (Y/N)").ToUpper() -eq "Y"
        Write-Host ""
    } else {
        Write-Host "  [1] Password on wake -- $($results['PasswordOnWake']), no change needed." -ForegroundColor Green
        $powerChoices["PasswordOnWake"] = $false
        Write-Host ""
    }

    # 2. Fast Startup
    if ($results["FastStartup"] -notmatch "GOOD|N/A") {
        Write-Host "  [2] Fast Startup" -ForegroundColor White
        Write-Host "      Current:  $($results['FastStartup'])" -ForegroundColor Gray
        Write-Host "      Change to: DISABLED -- ensures clean boot security state" -ForegroundColor Cyan
        $powerChoices["FastStartup"] = (Read-Host "      Apply? (Y/N)").ToUpper() -eq "Y"
        Write-Host ""
    } else {
        Write-Host "  [2] Fast Startup -- $($results['FastStartup']), no change needed." -ForegroundColor Green
        $powerChoices["FastStartup"] = $false
        Write-Host ""
    }

    # 3. Wake on LAN
    if ($results["WakeOnLAN"] -notmatch "GOOD|N/A") {
        Write-Host "  [3] Wake on LAN" -ForegroundColor White
        Write-Host "      Current:  $($results['WakeOnLAN'])" -ForegroundColor Gray
        Write-Host "      Change to: DISABLED -- removes remote wake attack surface" -ForegroundColor Cyan
        Write-Host "      Note: Only disable if you do not use remote wake features." -ForegroundColor DarkYellow
        $powerChoices["WakeOnLAN"] = (Read-Host "      Apply? (Y/N)").ToUpper() -eq "Y"
        Write-Host ""
    } else {
        Write-Host "  [3] Wake on LAN -- $($results['WakeOnLAN']), no change needed." -ForegroundColor Green
        $powerChoices["WakeOnLAN"] = $false
        Write-Host ""
    }

    # 4. Screen timeout (advisory only)
    Write-Host "  [4] Screen timeout: $($results['ScreenTimeout'])" -ForegroundColor Yellow
    Write-Host "      Advisory only -- set manually in:" -ForegroundColor Gray
    Write-Host "      Settings -> System -> Power & sleep -> Screen timeout" -ForegroundColor Gray
    Write-Host ""

    # 5. Critical battery (skip if desktop)
    if ($results["CriticalBattery"] -notmatch "GOOD|N/A|HIBERNATE|SHUTDOWN") {
        Write-Host "  [5] Critical battery action" -ForegroundColor White
        Write-Host "      Current:  $($results['CriticalBattery'])" -ForegroundColor Gray
        Write-Host "      Change to: HIBERNATE -- saves your session if battery dies" -ForegroundColor Cyan
        $powerChoices["CriticalBattery"] = (Read-Host "      Apply? (Y/N)").ToUpper() -eq "Y"
        Write-Host ""
    } else {
        Write-Host "  [5] Critical battery: $($results['CriticalBattery']), no change needed." -ForegroundColor Green
        $powerChoices["CriticalBattery"] = $false
        Write-Host ""
    }

    Apply-PowerSettings -Results $results -Choices $powerChoices
    Pause-ForUser "  Power settings complete. Press any key to continue..."
}

function Apply-PowerSettings {
    param($Results, $Choices)
    Write-Host ""

    if ($Choices["PasswordOnWake"]) {
        try {
            powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null
            powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null
            powercfg /S SCHEME_CURRENT | Out-Null
            Write-Host "  OK  Password on wake -- enabled" -ForegroundColor Green
            Write-Log -Message "Password on wake enabled" -Status "APPLIED"
        } catch { Write-Host "  ERROR Password on wake: $_" -ForegroundColor Red; Write-Log -Message "Password on wake error: $_" -Status "ERROR" }
    } else { Write-Host "  --  Password on wake -- skipped" -ForegroundColor Gray }

    if ($Choices["FastStartup"]) {
        try {
            Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name HiberbootEnabled -Value 0 -Type DWord -Force
            Write-Host "  OK  Fast Startup -- disabled" -ForegroundColor Green
            Write-Log -Message "Fast Startup disabled" -Status "APPLIED"
        } catch { Write-Host "  ERROR Fast Startup: $_" -ForegroundColor Red; Write-Log -Message "Fast Startup error: $_" -Status "ERROR" }
    } else { Write-Host "  --  Fast Startup -- skipped" -ForegroundColor Gray }

    if ($Choices["WakeOnLAN"]) {
        try {
            Get-NetAdapter -Physical -EA Stop | Where-Object { $_.Status -eq "Up" } | ForEach-Object {
                Set-NetAdapterPowerManagement -Name $_.Name -WakeOnMagicPacket Disabled -EA SilentlyContinue
            }
            Write-Host "  OK  Wake on LAN -- disabled" -ForegroundColor Green
            Write-Log -Message "Wake on LAN disabled" -Status "APPLIED"
        } catch { Write-Host "  ERROR Wake on LAN: $_" -ForegroundColor Red; Write-Log -Message "Wake on LAN error: $_" -Status "ERROR" }
    } else { Write-Host "  --  Wake on LAN -- skipped" -ForegroundColor Gray }

    if ($Choices["CriticalBattery"]) {
        try {
            powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_BATTERY BATACTIONCRIT 2 | Out-Null
            powercfg /S SCHEME_CURRENT | Out-Null
            Write-Host "  OK  Critical battery action -- set to Hibernate" -ForegroundColor Green
            Write-Log -Message "Critical battery action set to Hibernate" -Status "APPLIED"
        } catch { Write-Host "  ERROR Critical battery: $_" -ForegroundColor Red; Write-Log -Message "Critical battery error: $_" -Status "ERROR" }
    } else { Write-Host "  --  Critical battery -- skipped" -ForegroundColor Gray }
}

# ============================================================
# KNOWN BAD APPS (PUP publishers)
# Trusted publishers are whitelisted and will NOT be flagged
# ============================================================
$TrustedPublishers = @(
    # Microsoft & Windows
    "Microsoft Corporation", "Microsoft Windows", "Microsoft",
    # Intel
    "Intel Corporation", "Intel(R) Corporation", "Intel(R) pGFX", "Intel",
    # GPU / Graphics
    "NVIDIA Corporation", "NVIDIA",
    "AMD", "Advanced Micro Devices",
    # PC Manufacturers / OEMs
    "Dell", "Dell Inc", "HP", "HP Inc.", "Hewlett-Packard", "Hewlett Packard",
    "Lenovo", "ASUS", "ASUSTek", "Acer", "Samsung", "LG Electronics",
    "MSI", "Micro-Star International", "Razer", "Corsair", "GIGABYTE",
    # Audio / Network / Peripherals
    "Qualcomm", "Qualcomm Technologies",
    "Realtek Semiconductor", "Realtek",
    "Logitech", "SteelSeries", "Razer USA",
    # Printers / Scanners
    "Brother Industries", "Brother", "Brother International",
    "Canon", "Canon Inc.", "Epson", "Seiko Epson",
    "Xerox", "Lexmark", "Ricoh", "Kyocera",
    "HP LaserJet", "HP DeskJet", "HP OfficeJet",
    # USB / Connectivity utilities (OEM-bundled)
    "Netzlink Informationstechnik", "Netzlink",   # httpUsbBridge / USB Network Gate publisher
    "Electronic Team", "Electronic Team Inc",      # USB over Network / httpUsbBridge
    "FabulaTech", "FabulaTech LLC",                # USB redirectors
    "IOGEAR", "Plugable Technologies", "Plugable",
    "StarTech.com", "StarTech",
    # Apple / Google
    "Apple Inc.", "Google LLC", "Google Inc.",
    # Browsers / Productivity
    "Mozilla Corporation", "Mozilla Foundation",
    "Adobe", "Adobe Systems",
    "LibreOffice", "The Document Foundation",
    "OpenOffice", "Apache Software Foundation",
    # Security / Utilities
    "Malwarebytes Corporation", "Malwarebytes",
    "Zoom Video Communications",
    # Gaming
    "Valve Corporation", "Epic Games", "EA Games", "Electronic Arts",
    "Ubisoft", "Activision", "Blizzard Entertainment",
    # Cloud / Sync
    "Dropbox", "Dropbox Inc.", "Box Inc.",
    "Slack Technologies"
)

# AV products based in Russia or China -- strong uninstall recommendation
$HighRiskAVList = @(
    "Kaspersky","KAV","KIS","Kaspersky Lab",
    "Dr.Web","drweb",
    "360 Total Security","Qihoo","360 Security",
    "Baidu Antivirus","Baidu",
    "Tencent","Tencent Security",
    "Rising Antivirus","Rising Internet Security",
    "Comodo"   # flagged for deceptive practices
)

$KnownBadApps = @(
    "Fortect","Reimage","MyCleanPC","OneLaunch","Wave Browser",
    "WaveBrowser","AppSuite","PC Optimizer","Driver Booster",
    "Driver Updater","WinZip Driver","Advanced SystemCare","IObit",
    "PC Accelerate","PC HelpSoft","Segurazo","TotalAV Toolbar",
    "SearchMine","Search Mine","MySearch","MyWay","Conduit",
    "BrowserModifier","Adware","PUP.Optional","OpenCandy",
    "Babylon","Ask Toolbar","Mindspark","Fun Web Products"
)

# ============================================================
# STEP 11: APPS AUDIT
# ============================================================
function Run-AppsAudit {
    Clear-Host
    Write-Host ""
    Write-Host "  Running Apps Audit -- please wait..." -ForegroundColor Cyan
    Write-Log -Message "=== Apps Audit Started ===" -Status "START"

    $installedApps = [System.Collections.Generic.List[PSCustomObject]]::new()
    $cutoffDate = (Get-Date).AddDays(-90)

    $regPaths = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )

    foreach ($path in $regPaths) {
        try {
            Get-ItemProperty $path -ErrorAction SilentlyContinue |
            Where-Object { $_.DisplayName -and $_.DisplayName -ne "" } |
            ForEach-Object {
                $lastUsed = $null
                if ($_.InstallDate) {
                    try { $lastUsed = [datetime]::ParseExact($_.InstallDate, "yyyyMMdd", $null) } catch {}
                }
                $installedApps.Add([PSCustomObject]@{
                    Name        = $_.DisplayName
                    Publisher   = if ($_.Publisher) { $_.Publisher } else { "" }
                    InstallDate = $lastUsed
                    Source      = "Win32"
                    UninstallCmd= $_.UninstallString
                })
            }
        } catch {}
    }

    try {
        Get-AppxPackage -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -notmatch "^Microsoft\." -and $_.SignatureKind -ne "System" } |
        ForEach-Object {
            $installedApps.Add([PSCustomObject]@{
                Name         = $_.Name
                Publisher    = $_.Publisher
                InstallDate  = $null
                Source       = "Store/UWP"
                UninstallCmd = "Remove-AppxPackage -Package '$($_.PackageFullName)'"
            })
        }
    } catch {}

    $redApps    = [System.Collections.Generic.List[PSCustomObject]]::new()
    $yellowApps = [System.Collections.Generic.List[PSCustomObject]]::new()
    $greenApps  = [System.Collections.Generic.List[PSCustomObject]]::new()

    foreach ($app in $installedApps) {
        # Check if publisher is trusted -- skip flagging if so
        $isTrusted = $false
        if ($app.Publisher) {
            foreach ($trusted in $TrustedPublishers) {
                if ($app.Publisher -match [regex]::Escape($trusted)) { $isTrusted = $true; break }
            }
        }

        $isBad = $false
        if (-not $isTrusted) {
            foreach ($bad in $KnownBadApps) {
                if ($app.Name -match [regex]::Escape($bad) -or ($app.Publisher -and $app.Publisher -match [regex]::Escape($bad))) {
                    $isBad = $true; break
                }
            }
        }

        if ($isBad) {
            $redApps.Add($app)
        } elseif ($isTrusted) {
            # Never flag trusted publisher apps as unused -- add to green
            $greenApps.Add($app)
        } elseif ($app.InstallDate -and $app.InstallDate -lt $cutoffDate) {
            $yellowApps.Add($app)
        } else {
            $greenApps.Add($app)
        }
    }

    Clear-Host
    Write-Host ""
    Draw-Box -Color Cyan -Lines @(
        "  APPS AUDIT RESULTS                                          ",
        "---",
        "  RED    = Known suspicious/PUP publisher -- review now       ",
        "  YELLOW = Not used in 90+ days -- consider removing          ",
        "  GREEN  = Recently installed or used -- no action needed     "
    )
    Write-Host ""

    if ($redApps.Count -gt 0) {
        Write-Host "  ----------------------------------------------------------" -ForegroundColor Red
        Write-Host "  RED -- REVIEW IMMEDIATELY ($($redApps.Count) found)" -ForegroundColor Red
        Write-Host "  ----------------------------------------------------------" -ForegroundColor Red
        foreach ($app in $redApps) {
            Write-Host "  * $($app.Name)" -ForegroundColor Red
            if ($app.Publisher) { Write-Host "    Publisher: $($app.Publisher)" -ForegroundColor DarkRed }
            Write-Host "    Recommendation: Uninstall. See Guide: Phase 2" -ForegroundColor DarkRed
        }
        Write-Host ""
        # FIX: Join-String -> -join for PS 5.1 compatibility
        $redNames = ($redApps | ForEach-Object { $_.Name }) -join ", "
        Write-Log -Message "RED apps found: $redNames" -Status "WARN"
    } else {
        Write-Host "  RED -- No known suspicious apps found." -ForegroundColor Green
        Write-Host ""
    }

    if ($yellowApps.Count -gt 0) {
        Write-Host "  ----------------------------------------------------------" -ForegroundColor Yellow
        Write-Host "  YELLOW -- NOT USED IN 90+ DAYS ($($yellowApps.Count) found)" -ForegroundColor Yellow
        Write-Host "  ----------------------------------------------------------" -ForegroundColor Yellow
        foreach ($app in $yellowApps) {
            $daysSince = if ($app.InstallDate) { [int]((Get-Date) - $app.InstallDate).TotalDays } else { "Unknown" }
            Write-Host "  * $($app.Name)" -ForegroundColor Yellow
            Write-Host "    Last activity: ~$daysSince days ago" -ForegroundColor DarkYellow
        }
        Write-Host ""
        Write-Log -Message "YELLOW apps (90+ days): $($yellowApps.Count) found" -Status "INFO"
    } else {
        Write-Host "  YELLOW -- No apps unused for 90+ days found." -ForegroundColor Green
        Write-Host ""
    }

    Write-Host "  GREEN -- $($greenApps.Count) recently used or installed apps -- no action needed." -ForegroundColor Green
    Write-Host ""

    Pause-ForUser

    # Uninstall prompts -- RED
    if ($redApps.Count -gt 0) {
        Clear-Host
        Write-Host ""
        Write-Host "  ----------------------------------------------------------" -ForegroundColor Red
        Write-Host "  UNINSTALL -- Suspicious Apps" -ForegroundColor Red
        Write-Host "  Your approval is required for each." -ForegroundColor Gray
        Write-Host "  ----------------------------------------------------------" -ForegroundColor Red
        Write-Host ""

        foreach ($app in $redApps) {
            Write-Host "  App: $($app.Name)" -ForegroundColor White
            if ($app.Publisher) { Write-Host "  Publisher: $($app.Publisher)" -ForegroundColor Gray }
            Write-Host "  ! Matches a known suspicious publisher. See Guide: Phase 2" -ForegroundColor Red
            Write-Host ""
            $uninstall = Read-Host "  Uninstall $($app.Name)? (Y = Yes / N = Skip / S = Skip all)"
            if ($uninstall.ToUpper() -eq "S") {
                Write-Log -Message "User chose to skip all uninstalls" -Status "SKIP"
                break
            }
            if ($uninstall.ToUpper() -eq "Y") {
                try {
                    if ($app.Source -eq "Store/UWP") {
                        Invoke-Expression $app.UninstallCmd -ErrorAction Stop
                        Write-Host "  OK  Removed: $($app.Name)" -ForegroundColor Green
                        Write-Log -Message "Uninstalled: $($app.Name)" -Status "REMOVED"
                    } elseif ($app.UninstallCmd) {
                        Start-Process cmd -ArgumentList "/c `"$($app.UninstallCmd)`"" -Wait -ErrorAction Stop
                        Write-Host "  OK  Uninstall launched for: $($app.Name)" -ForegroundColor Green
                        Write-Log -Message "Uninstall launched: $($app.Name)" -Status "REMOVED"
                    } else {
                        Write-Host "  Manual uninstall needed: Settings -> Apps -> Installed apps" -ForegroundColor Yellow
                        Write-Log -Message "Manual uninstall needed: $($app.Name)" -Status "MANUAL"
                    }
                } catch {
                    Write-Host "  Error during uninstall: $_" -ForegroundColor Red
                    Write-Host "  Try: Settings -> Apps -> Installed apps -> uninstall manually." -ForegroundColor Gray
                    Write-Log -Message "Uninstall error for $($app.Name): $_" -Status "ERROR"
                }
            } else {
                Write-Log -Message "Skipped uninstall: $($app.Name)" -Status "SKIP"
            }
            Write-Host ""
        }
    }

    if ($yellowApps.Count -gt 0) {
        Write-Host ""
        $reviewYellow = Read-Host "  Review unused apps for removal? (Y/N)"
        if ($reviewYellow.ToUpper() -eq "Y") {
            Write-Host ""
            foreach ($app in $yellowApps) {
                $daysSince = if ($app.InstallDate) { [int]((Get-Date) - $app.InstallDate).TotalDays } else { "Unknown" }
                Write-Host "  App: $($app.Name)" -ForegroundColor White
                Write-Host "  Last activity: ~$daysSince days ago" -ForegroundColor Gray
                $uninstall = Read-Host "  Uninstall? (Y / N / S = skip remaining)"
                if ($uninstall.ToUpper() -eq "S") { Write-Log -Message "User skipped remaining yellow app review" -Status "SKIP"; break }
                if ($uninstall.ToUpper() -eq "Y") {
                    try {
                        if ($app.Source -eq "Store/UWP") {
                            Invoke-Expression $app.UninstallCmd -ErrorAction Stop
                            Write-Host "  OK  Removed: $($app.Name)" -ForegroundColor Green
                            Write-Log -Message "Uninstalled unused app: $($app.Name)" -Status "REMOVED"
                        } elseif ($app.UninstallCmd) {
                            Start-Process cmd -ArgumentList "/c `"$($app.UninstallCmd)`"" -Wait -ErrorAction Stop
                            Write-Host "  OK  Uninstall launched for: $($app.Name)" -ForegroundColor Green
                            Write-Log -Message "Uninstall launched (unused): $($app.Name)" -Status "REMOVED"
                        } else {
                            Write-Host "  Manual uninstall needed: Settings -> Apps -> Installed apps" -ForegroundColor Yellow
                            Write-Log -Message "Manual uninstall needed (unused): $($app.Name)" -Status "MANUAL"
                        }
                    } catch {
                        Write-Host "  Error: $_" -ForegroundColor Red
                        Write-Log -Message "Uninstall error (unused) $($app.Name): $_" -Status "ERROR"
                    }
                } else { Write-Log -Message "Skipped removal of unused app: $($app.Name)" -Status "SKIP" }
                Write-Host ""
            }
        }
    }

    Write-Log -Message "=== Apps Audit Complete ===" -Status "DONE"
    Pause-ForUser "  Apps Audit complete. Press any key to continue..."
}

# ============================================================
# SETTINGS DEFINITIONS (19 settings)
# ============================================================
$Settings = @(
    [PSCustomObject]@{ ID=1;  Name="Windows Update";                    Description="Ensures security patches are current and auto-update is on.";                              GuideRef="Phase 1, Step 1";          Selected=$true;  RequiresAdmin=$false; SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=2;  Name="Defender Real-Time Protection";     Description="Your primary virus and malware shield. Should always be On.";                              GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=3;  Name="Defender Tamper Protection";        Description="Prevents malware from disabling Defender. Manual toggle required in Windows Security.";   GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$false; SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=4;  Name="SmartScreen";                       Description="Blocks known malicious websites and downloads.";                                          GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=5;  Name="Defender Periodic Scanning";        Description="Enables Defender background scans if a 3rd-party AV is your primary protection.";        GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=6;  Name="Phishing Protection (all 3)";       Description="Warns about password reuse, unsafe storage, and malicious sites in Edge.";               GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=7;  Name="Windows Firewall (all profiles)";   Description="Network traffic shield -- Domain, Private, and Public profiles all enabled.";            GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=8;  Name="BitLocker / Device Encryption";     Description="Encrypts your drive. Protects data if PC is lost or stolen.";                            GuideRef="Phase 1, Step 3";          Selected=$false; RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=9;  Name="Windows Hello (check only)";        Description="Checks if PIN or biometrics are configured. Setup done manually -- see Guide.";          GuideRef="Phase 1, Step 4";          Selected=$true;  RequiresAdmin=$false; SkipOnHome=$false; CanAuto=$false; SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=10; Name="Remote Desktop -- Disable";         Description="Disables remote access if unused. Not available on Windows 11 Home.";                    GuideRef="Keep vs. Disable Table";   Selected=$false; RequiresAdmin=$true;  SkipOnHome=$true;  CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=11; Name="Advertising ID -- Turn Off";        Description="Stops Windows from tracking you for ad targeting.";                                      GuideRef="Keep vs. Disable Table";   Selected=$true;  RequiresAdmin=$false; SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=12; Name="Diagnostic Data -- Required Only";  Description="Limits data sent to Microsoft to the minimum required.";                                 GuideRef="Keep vs. Disable Table";   Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=13; Name="Edge Startup Boost and Background"; Description="Stops Edge pre-loading at boot and running in background after close. Saves RAM.";       GuideRef="Phase 1, Step 6, Part D"; Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=14; Name="Windows Widgets -- Disable";        Description="Disables news/weather panel that runs background Edge processes.";                       GuideRef="Phase 1, Step 6, Part F"; Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=15; Name="Edge Password Saving -- Disable";   Description="Turns off Edge password storage. Use a dedicated password manager instead.";            GuideRef="Phase 1, Step 6, Part I"; Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=16; Name="Memory Integrity (Core Isolation)"; Description="Blocks untrusted code from high-security processes. RESTART required after enabling.";  GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=17; Name="Password Required on Wake";         Description="Requires password when PC wakes from sleep. Prevents unlocked screen access.";          GuideRef="Keep vs. Disable Table";   Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=18; Name="Fast Startup -- Disable";           Description="Fast Startup skips a full shutdown. Disabling ensures a clean security state on boot.";  GuideRef="Keep vs. Disable Table";   Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=19; Name="Wake on LAN -- Disable";            Description="Prevents PC from being remotely woken over the network. Disable if not needed.";         GuideRef="Keep vs. Disable Table";   Selected=$false; RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' }
)

$GoodPatterns = "GOOD|ALL ON|ENCRYPTED|CONFIGURED|Required Only|primary AV|N/A on Home|Already"

# ============================================================
# STATUS CHECKS
# ============================================================
# ============================================================
# MALWAREBYTES STATE DETECTION
# ============================================================
function Get-MalwarebytesState {
    # Returns: NotInstalled / FreeCompanion / TrialActive / Unknown
    #
    # FreeCompanion = MB installed, no real-time takeover, Defender still primary
    # TrialActive   = MB Premium Trial active -- took over real-time AV + firewall
    #
    # Detection method:
    #   SecurityCenter2 AntiVirusProduct.productState bit 0x1000 = real-time active
    #   SecurityCenter2 FirewallProduct with MB name = WFC (Premium) managing firewall
    try {
        $avProducts = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
        $mbAV = $avProducts | Where-Object { $_.displayName -match "Malwarebytes" }
        if (-not $mbAV) { return "NotInstalled" }

        # Bit 0x1000 in productState = real-time protection active
        $rtActive = ($mbAV[0].productState -band 0x1000) -eq 0x1000
        if ($rtActive) { return "TrialActive" }

        # Also check FirewallProduct -- MB WFC registers here during Premium Trial
        $fwProducts = Get-WmiObject -Namespace "root\SecurityCenter2" -Class FirewallProduct -EA SilentlyContinue
        $mbFW = $fwProducts | Where-Object { $_.displayName -match "Malwarebytes" }
        if ($mbFW) { return "TrialActive" }

        return "FreeCompanion"
    } catch { return "Unknown" }
}

function Get-AllStatuses {
    foreach ($s in $Settings) {
        $s | Add-Member -NotePropertyName Status -NotePropertyValue "Checking..." -Force -ErrorAction SilentlyContinue
    }

    $isHome = $global:WinEdition -notmatch "Pro|Enterprise|Education|Business"

    foreach ($s in $Settings) {
        if ($s.SkipOnHome -and $isHome) { $s.Status = "N/A on Home Edition -- GOOD"; continue }
        if ($s.RequiresAdmin -and -not $global:IsAdmin) { $s.Status = "Requires Admin Access"; continue }

        switch ($s.ID) {
            1 {
                try { $svc = Get-Service wuauserv -EA Stop; $s.Status = if ($svc.StartType -ne 'Disabled') { "Enabled -- GOOD" } else { "DISABLED -- needs attention" } }
                catch { $s.Status = "Unknown" }
            }
            2 {
                try {
                    $mbSt2 = Get-MalwarebytesState
                    $avP2  = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
                    $mp2   = Get-MpComputerStatus -EA Stop

                    if ($mbSt2 -eq "TrialActive") {
                        # MB Premium Trial took over real-time from Defender
                        $s.Status = "Malwarebytes Premium Trial active -- Defender real-time inactive (by design while trial runs)"
                    } elseif ($mbSt2 -eq "FreeCompanion" -or $mbSt2 -eq "NotInstalled" -or $mbSt2 -eq "Unknown") {
                        # MB Free companion, not installed, or unknown -- check actual Defender state directly
                        if ($mp2.RealTimeProtectionEnabled) {
                            $s.Status = if ($mbSt2 -eq "FreeCompanion") { "ON -- GOOD  (Malwarebytes Free installed as manual-scan companion)" } else { "ON -- GOOD" }
                        } else {
                            # Defender real-time is actually off -- check if a different 3rd-party AV is primary
                            $nd2 = $avP2 | Where-Object { $_.displayName -notmatch "Windows Defender|Microsoft Defender|Malwarebytes" }
                            if ($nd2) {
                                $n2    = if ($nd2[0].displayName) { $nd2[0].displayName } else { "A 3rd-party AV" }
                                $isHR2 = ($HighRiskAVList | Where-Object { $n2 -match $_ }).Count -gt 0
                                $s.Status = if ($isHR2) { "!! CRITICAL RISK: $n2 (Russian/Chinese AV)" } else { "$n2 is active as primary AV -- Defender real-time is off" }
                            } else {
                                $s.Status = "OFF -- needs attention"
                            }
                        }
                    }
                } catch { $s.Status = "Unknown -- could not read Defender status" }
            }
            3 {
                try {
                    $mbSt3 = Get-MalwarebytesState
                    $avP3  = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
                    $nd3   = $avP3 | Where-Object { $_.displayName -notmatch "Windows Defender|Microsoft Defender" }

                    if ($mbSt3 -eq "FreeCompanion") {
                        # MB Free does NOT interfere with Defender -- check Tamper Protection normally
                        $tp = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows Defender\Features" -EA Stop).TamperProtection
                        $s.Status = if ($tp -eq 5) { "ON -- GOOD" } else { "OFF -- enable manually in Windows Security" }
                    } elseif ($mbSt3 -eq "TrialActive") {
                        $s.Status = "Cannot verify -- Malwarebytes Premium Trial is active. Deactivate trial first, then recheck."
                    } elseif ($nd3) {
                        $n3 = if ($nd3[0].displayName) { $nd3[0].displayName } else { "A 3rd-party antivirus" }
                        $s.Status = "Cannot verify -- $n3 is registered as AV. Fix AV first, then recheck."
                    } else {
                        $tp = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows Defender\Features" -EA Stop).TamperProtection
                        $s.Status = if ($tp -eq 5) { "ON -- GOOD" } else { "OFF -- enable manually in Windows Security" }
                    }
                } catch { $s.Status = "Unknown -- check manually in Windows Security" }
            }
            4 {
                try { $ss = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -EA SilentlyContinue).SmartScreenEnabled; $s.Status = if ($ss -ne "Off") { "ON -- GOOD" } else { "OFF -- needs attention" } }
                catch { $s.Status = "Unknown" }
            }
            5 {
                try {
                    $mbSt5   = Get-MalwarebytesState
                    $avP5    = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA Stop
                    $nd5     = $avP5 | Where-Object { $_.displayName -notmatch "Windows Defender|Microsoft Defender" }

                    if ($mbSt5 -eq "FreeCompanion") {
                        # MB Free -- Defender is still primary -- no periodic scan needed
                        $s.Status = "Defender is primary AV -- GOOD  (Malwarebytes Free companion also installed)"
                    } elseif ($mbSt5 -eq "TrialActive") {
                        # MB Premium Trial took over real-time -- periodic scanning IS recommended
                        try {
                            $ps = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows Defender" -EA SilentlyContinue).PassiveMode
                            $s.Status = if ($ps -eq 1) { "Malwarebytes Trial active -- enable Defender periodic scanning" } else { "Malwarebytes Trial detected -- check Defender periodic scan setting" }
                        } catch { $s.Status = "Malwarebytes Trial active -- check Defender settings" }
                    } elseif ($nd5) {
                        # Other 3rd-party AV
                        try {
                            $ps = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows Defender" -EA SilentlyContinue).PassiveMode
                            $s.Status = if ($ps -eq 1) { "3rd-party AV active -- enable periodic scanning" } else { "3rd-party AV detected -- check Defender settings" }
                        } catch { $s.Status = "3rd-party AV active -- check Defender settings" }
                    } else {
                        $s.Status = "Defender is primary AV -- GOOD, periodic scan not needed"
                    }
                } catch { $s.Status = "Unknown" }
            }
            6 {
                try {
                    $pp = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components" -EA SilentlyContinue
                    if ($null -eq $pp) {
                        $s.Status = "Not configured -- all 3 need to be enabled"
                    } else {
                        $svcOn  = ($pp.ServiceEnabled -eq 1)
                        $malOn  = ($pp.NotifyMalicious -eq 1)
                        $pwOn   = ($pp.NotifyPasswordReuse -eq 1)
                        $appOn  = ($pp.NotifyUnsafeApp -eq 1)
                        if ($svcOn -and $malOn -and $pwOn -and $appOn) {
                            $s.Status = "All 3 ON -- GOOD"
                        } elseif (-not $svcOn) {
                            $s.Status = "Service OFF -- all 3 need attention"
                        } else {
                            $missing = @()
                            if (-not $malOn) { $missing += "malicious sites" }
                            if (-not $pwOn)  { $missing += "password reuse" }
                            if (-not $appOn) { $missing += "unsafe apps" }
                            $s.Status = "Partial -- missing: $($missing -join ', ')"
                        }
                    }
                } catch { $s.Status = "Not configured -- needs attention" }
            }
            7 {
                try {
                    $fw    = Get-NetFirewallProfile -EA Stop
                    $allOn = ($fw | Where-Object { -not $_.Enabled }).Count -eq 0
                    $mbSt7 = Get-MalwarebytesState
                    if ($mbSt7 -eq "TrialActive") {
                        # MB WFC manages the firewall UI during Premium Trial
                        # Underlying Windows Firewall engine should still be ON
                        $s.Status = if ($allOn) { "ALL ON -- GOOD  (Malwarebytes WFC managing interface)" } else { "One or more profiles OFF -- needs attention  (Malwarebytes WFC detected)" }
                    } else {
                        $s.Status = if ($allOn) { "ALL ON -- GOOD" } else { "One or more profiles OFF -- needs attention" }
                    }
                } catch { $s.Status = "Unknown" }
            }
            8 {
                try { $bl = Get-BitLockerVolume -MountPoint $env:SystemDrive -EA Stop; $s.Status = if ($bl.ProtectionStatus -eq "On") { "ENCRYPTED -- GOOD" } else { "NOT Encrypted -- action available" } }
                catch { $s.Status = "Check manually in Windows Security" }
            }
            9 {
                $ngc = Test-Path "$env:LOCALAPPDATA\Microsoft\NGC"
                $s.Status = if ($ngc) { "Configured -- GOOD" } else { "Not set up -- manual action needed" }
            }
            10 {
                try { $rd = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -EA Stop).fDenyTSConnections; $s.Status = if ($rd -eq 1) { "DISABLED -- GOOD" } else { "Enabled -- consider disabling" } }
                catch { $s.Status = "Unknown" }
            }
            11 {
                try { $ai = (Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -EA Stop).Enabled; $s.Status = if ($ai -eq 0) { "OFF -- GOOD" } else { "ON -- needs attention" } }
                catch { $s.Status = "ON (default) -- needs attention" }
            }
            12 {
                try { $dd = (Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -EA SilentlyContinue).AllowTelemetry; $s.Status = if ($null -ne $dd -and $dd -le 1) { "Required Only -- GOOD" } else { "Not restricted (default) -- needs attention" } }
                catch { $s.Status = "Not restricted (default) -- needs attention" }
            }
            13 {
                try { $ep = Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -EA SilentlyContinue; $s.Status = if ($ep -and $ep.StartupBoostEnabled -eq 0 -and $ep.BackgroundModeEnabled -eq 0) { "DISABLED -- GOOD" } else { "Enabled (default) -- needs attention" } }
                catch { $s.Status = "Enabled (default) -- needs attention" }
            }
            14 {
                try { $w = (Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -EA SilentlyContinue).AllowNewsAndInterests; $s.Status = if ($null -ne $w -and $w -eq 0) { "DISABLED -- GOOD" } else { "Enabled (default) -- needs attention" } }
                catch { $s.Status = "Enabled (default) -- needs attention" }
            }
            15 {
                try { $ep = (Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -EA SilentlyContinue).PasswordManagerEnabled; $s.Status = if ($null -ne $ep -and $ep -eq 0) { "DISABLED -- GOOD" } else { "Enabled (default) -- needs attention" } }
                catch { $s.Status = "Enabled (default) -- needs attention" }
            }
            16 {
                try { $mi = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -EA Stop).Enabled; $s.Status = if ($mi -eq 1) { "ON -- GOOD" } else { "OFF -- needs attention" } }
                catch { $s.Status = "Unknown" }
            }
            17 {
                try { $pw = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>$null; $acVal = if ($pw -match "Current AC Power Setting Index: 0x(\w+)") { [int]"0x$($Matches[1])" } else { $null }; $s.Status = if ($acVal -eq 1) { "REQUIRED -- GOOD" } else { "Not required -- needs attention" } }
                catch { $s.Status = "Unknown" }
            }
            18 {
                try { $fs = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -EA Stop).HiberbootEnabled; $s.Status = if ($fs -eq 0) { "DISABLED -- GOOD" } else { "Enabled -- needs attention" } }
                catch { $s.Status = "Unknown" }
            }
            19 {
                try {
                    $adapters = Get-NetAdapter -Physical -EA Stop | Where-Object { $_.Status -eq "Up" }
                    $wolOn = $false
                    foreach ($a in $adapters) { $wol = Get-NetAdapterPowerManagement -Name $a.Name -EA SilentlyContinue; if ($wol -and $wol.WakeOnMagicPacket -eq "Enabled") { $wolOn = $true } }
                    $s.Status = if ($wolOn) { "Enabled -- consider disabling" } else { "DISABLED -- GOOD" }
                } catch { $s.Status = "Unknown" }
            }
        }
    }

    # Auto-deselect items already at recommended setting
    foreach ($s in $Settings) {
        if ($s.Status -match "GOOD") { $s.Selected = $false }
    }
    # BitLocker -- never auto-select
    ($Settings | Where-Object { $_.ID -eq 8 }).Selected = $false
}

# ============================================================
# NON-RECOMMENDED WARNING  (Y / N / S)
# ============================================================
function Test-NonRecommendedSelections {
    param([string]$Stage = "checklist")

    $criticalDeselected = $Settings | Where-Object {
        $_.SecurityCritical -and
        -not $_.Selected -and
        $_.Status -notmatch "GOOD|N/A|Requires Admin|ENCRYPTED|primary AV"
    }

    if ($criticalDeselected.Count -eq 0) { return $true }

    Clear-Host
    Write-Host ""
    Draw-Box -Color Yellow -Lines @(
        "  HEADS UP -- SOME SECURITY-CRITICAL ITEMS ARE NOT SELECTED  ",
        "---",
        "  The items below are not selected for this run.             ",
        "  These are flagged as important security settings.          ",
        "                                                             ",
        "  That is completely fine -- you know your setup best.       ",
        "  We just want to make sure these are intentional choices    ",
        "  and not accidental ones.                                   "
    )
    Write-Host ""
    foreach ($item in $criticalDeselected) {
        Write-Host "  Item $($item.ID): $($item.Name)" -ForegroundColor White
        Write-Host "         Status: $($item.Status)" -ForegroundColor Red
        Write-Host "         Guide:  $($item.GuideRef)" -ForegroundColor Gray
        Write-Host ""
    }
    Write-Host "  Y = These are intentional -- continue" -ForegroundColor White
    Write-Host "  N = Go back and review my selections" -ForegroundColor White
    Write-Host "  S = Show me what each item does before I decide" -ForegroundColor White
    Write-Host ""

    do {
        $resp = Read-Host "  Your choice (Y / N / S)"
        switch ($resp.ToUpper()) {
            "S" {
                Write-Host ""
                foreach ($item in $criticalDeselected) {
                    Write-Host "  Item $($item.ID): $($item.Name)" -ForegroundColor Yellow
                    Write-Host "  Why recommended: $($item.Description)" -ForegroundColor Gray
                    Write-Host "  Guide reference: $($item.GuideRef)" -ForegroundColor Cyan
                    Write-Host ""
                }
            }
            "Y" {
                foreach ($item in $criticalDeselected) {
                    Write-Log -Message "NOTED: User chose not to apply: $($item.Name) -- Status: $($item.Status)" -Status "NOTED"
                }
                Write-Log -Message "User confirmed intentional skip of security-critical items at stage: $Stage" -Status "NOTED"
                return $true
            }
            "N" { return $false }
        }
    } while ($resp.ToUpper() -notin "Y","N")
    return $true
}

# ============================================================
# APPLY SETTING
# ============================================================
function Apply-Setting {
    param([PSCustomObject]$Setting)

    $before = $Setting.Status
    $isHome = $global:WinEdition -notmatch "Pro|Enterprise|Education|Business"

    if ($Setting.Status -match "GOOD") {
        Write-Log -Message "$($Setting.Name) | Already correct: $before" -Status "GOOD"
        return "Already at recommended setting -- GOOD, no change needed"
    }
    if (-not $Setting.CanAuto) {
        Write-Log -Message "$($Setting.Name) | Manual action required" -Status "MANUAL"
        return "Manual action required -- see Guide: $($Setting.GuideRef)"
    }
    if ($Setting.RequiresAdmin -and -not $global:IsAdmin) {
        Write-Log -Message "$($Setting.Name) | Skipped -- no admin" -Status "SKIP"
        return "Skipped -- Administrator access required"
    }
    if ($Setting.SkipOnHome -and $isHome) {
        Write-Log -Message "$($Setting.Name) | Skipped -- Home edition" -Status "SKIP"
        return "Skipped -- not available on Windows 11 Home"
    }

    $result = "No change"

    switch ($Setting.ID) {
        1 {
            try {
                Set-Service -Name wuauserv -StartupType Automatic -EA Stop
                Start-Service -Name wuauserv -EA SilentlyContinue
                Set-Service -Name UsoSvc -StartupType Automatic -EA SilentlyContinue
                $result = "Windows Update service set to Automatic and started -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        2 {
            try {
                $mbSt2a  = Get-MalwarebytesState
                $avPA2   = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
                $ndA2    = $avPA2 | Where-Object { $_.displayName -notmatch "Windows Defender|Microsoft Defender" }

                if ($mbSt2a -eq "FreeCompanion") {
                    # MB Free is NOT blocking Defender -- enable Defender RT normally
                    Set-MpPreference -DisableRealtimeMonitoring $false -EA Stop
                    $result = "Defender Real-Time Protection enabled -- GOOD  (Malwarebytes Free companion remains installed for manual scans)"
                } elseif ($mbSt2a -eq "TrialActive") {
                    $result = "NOTE: Malwarebytes Premium Trial is currently handling real-time protection. Defender cannot run simultaneously. TO FIX: Open Malwarebytes -> Settings (gear icon) -> Account -> Deactivate Premium Trial. Defender will automatically become primary AV. Then rerun this tool to confirm. See Guide: Phase 3, Step 4"
                } elseif ($ndA2) {
                    $avName   = if ($ndA2[0].displayName) { $ndA2[0].displayName } else { "A 3rd-party antivirus" }
                    $isHiRisk = ($HighRiskAVList | Where-Object { $avName -match $_ }).Count -gt 0
                    if ($isHiRisk) {
                        $result = "!! CRITICAL SECURITY RISK: $avName is a Russian or Chinese antivirus. This software may be sending your files and browsing data to foreign government servers. ACTION REQUIRED: (1) Uninstall $avName -- Settings -> Apps -> $avName -> Uninstall. (2) Restart your PC. (3) Confirm Defender is active in Windows Security. Microsoft Defender is a fully capable free AV -- you do not need this product. See Guide: Phase 3, Step 4"
                    } else {
                        $result = "$avName is registered as an antivirus. Defender real-time cannot run simultaneously with another active AV. See Guide: Phase 3, Step 4"
                    }
                } else {
                    Set-MpPreference -DisableRealtimeMonitoring $false -EA Stop
                    $result = "Defender Real-Time Protection enabled -- GOOD"
                }
            } catch { $result = "ERROR: $_ -- If a 3rd-party AV is active, Defender real-time cannot be enabled simultaneously" }
        }
        3 {
            $mbSt3a = Get-MalwarebytesState
            $avPA3  = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
            $ndA3   = $avPA3 | Where-Object { $_.displayName -notmatch "Windows Defender|Microsoft Defender" }

            if ($mbSt3a -eq "FreeCompanion") {
                # MB Free does NOT interfere with Defender -- give normal Tamper Protection instructions
                $result = "MANUAL ACTION REQUIRED: Windows Security -> Virus & threat protection -> Virus & threat protection settings -> Tamper Protection -> On. (Malwarebytes Free does not affect this setting.) See Guide: Phase 1, Step 2"
            } elseif ($mbSt3a -eq "TrialActive") {
                $result = "Malwarebytes Premium Trial is active -- Tamper Protection cannot be verified while it holds real-time AV control. STEP 1: Open Malwarebytes -> Settings (gear icon) -> Account -> Deactivate Premium Trial. STEP 2: Confirm Defender is active in Windows Security. STEP 3: Enable Tamper Protection: Windows Security -> Virus & threat protection settings -> Tamper Protection -> On. See Guide: Phase 1, Step 2"
            } elseif ($ndA3) {
                $avName = if ($ndA3[0].displayName) { $ndA3[0].displayName } else { "A 3rd-party antivirus" }
                $result = "NOTE: $avName is registered as an AV. Tamper Protection cannot be verified while another AV is active. Fix AV status first, then: Windows Security -> Virus & threat protection settings -> Tamper Protection -> On. See Guide: Phase 1, Step 2"
            } else {
                $result = "MANUAL ACTION REQUIRED: Windows Security -> Virus & threat protection -> Virus & threat protection settings -> Tamper Protection -> On. See Guide: Phase 1, Step 2"
            }
        }
        4 {
            try {
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name SmartScreenEnabled -Value "Warn" -Force -EA Stop
                $result = "SmartScreen set to Warn (recommended) -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        5 {
            try {
                $mbSt5a = Get-MalwarebytesState
                $avPA5  = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
                $ndA5   = $avPA5 | Where-Object { $_.displayName -notmatch "Windows Defender|Microsoft Defender" }

                if ($mbSt5a -eq "FreeCompanion") {
                    # MB Free -- Defender is primary real-time AV -- no periodic scan needed
                    $result = "Defender is your primary AV -- real-time protection covers this. Malwarebytes Free is installed as a companion for manual scans (which is good). No change needed -- GOOD"
                } elseif ($mbSt5a -eq "TrialActive") {
                    $result = "Malwarebytes Premium Trial is active as your real-time AV. RECOMMENDED: Enable Defender periodic scanning as a second layer: Windows Security -> Virus & threat protection -> Microsoft Defender Antivirus options -> Periodic scanning -> On. Note: When trial expires (14 days), Malwarebytes reverts to Free -- Defender will resume as primary AV automatically. See Guide: Phase 1, Step 2"
                } elseif ($ndA5) {
                    $avName = if ($ndA5[0].displayName) { $ndA5[0].displayName } else { "A 3rd-party antivirus" }
                    $result = "3rd-party AV ($avName) is registered. MANUAL ACTION: Windows Security -> Virus & threat protection -> Microsoft Defender Antivirus options -> Periodic scanning -> On. See Guide: Phase 1, Step 2"
                } else {
                    $result = "Defender is your primary AV -- real-time protection covers this. No change needed -- GOOD"
                }
            } catch { $result = "ERROR: $_" }
        }
        6 {
            try {
                $rp = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components"
                if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                Set-ItemProperty -Path $rp -Name ServiceEnabled      -Value 1 -Type DWord -Force
                Set-ItemProperty -Path $rp -Name NotifyMalicious      -Value 1 -Type DWord -Force
                Set-ItemProperty -Path $rp -Name NotifyPasswordReuse  -Value 1 -Type DWord -Force
                Set-ItemProperty -Path $rp -Name NotifyUnsafeApp      -Value 1 -Type DWord -Force
                $result = "All 3 phishing protection options enabled (malicious sites, password reuse, unsafe apps) -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        7 {
            try {
                Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True -EA Stop
                $mbSt7a = Get-MalwarebytesState
                if ($mbSt7a -eq "TrialActive") {
                    $result = "All firewall profiles confirmed ON (Domain, Private, Public) -- GOOD. NOTE: Malwarebytes Windows Firewall Control (WFC) is managing the firewall interface during your Premium Trial -- this is normal. The underlying Windows Firewall engine remains active and your PC is protected."
                } else {
                    $result = "All firewall profiles enabled (Domain, Private, Public) -- GOOD"
                }
            } catch { $result = "ERROR: $_" }
        }
        8 {
            $result = "BitLocker is handled via the dedicated BitLocker screen at the end of this run."
        }
        9 {
            $ngc = Test-Path "$env:LOCALAPPDATA\Microsoft\NGC"
            if ($ngc) {
                $result = "Windows Hello is already configured -- GOOD, no action needed"
            } else {
                $result = "NOT CONFIGURED -- Manual setup: Settings -> Accounts -> Sign-in options -> set up PIN or fingerprint/face. A PIN is the minimum. See Guide: Phase 1, Step 4"
            }
        }
        10 {
            try {
                Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name fDenyTSConnections -Value 1 -Force -EA Stop
                Disable-NetFirewallRule -DisplayGroup "Remote Desktop" -EA SilentlyContinue
                $result = "Remote Desktop disabled -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        11 {
            try {
                $rp = "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
                if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                Set-ItemProperty -Path $rp -Name Enabled -Value 0 -Type DWord -Force
                $result = "Advertising ID disabled -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        12 {
            try {
                $rp = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
                if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                Set-ItemProperty -Path $rp -Name AllowTelemetry -Value 1 -Type DWord -Force
                $result = "Diagnostic data set to Required Only -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        13 {
            try {
                $rp = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
                if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                Set-ItemProperty -Path $rp -Name StartupBoostEnabled   -Value 0 -Type DWord -Force
                Set-ItemProperty -Path $rp -Name BackgroundModeEnabled  -Value 0 -Type DWord -Force
                $result = "Edge startup boost and background mode disabled -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        14 {
            try {
                $rp = "HKLM:\SOFTWARE\Policies\Microsoft\Dsh"
                if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                Set-ItemProperty -Path $rp -Name AllowNewsAndInterests -Value 0 -Type DWord -Force
                $result = "Windows Widgets disabled -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        15 {
            try {
                $rp = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
                if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                Set-ItemProperty -Path $rp -Name PasswordManagerEnabled -Value 0 -Type DWord -Force
                $result = "Edge password saving disabled. Use a dedicated password manager. See Guide: Phase 5 at $GuideURL"
            } catch { $result = "ERROR: $_" }
        }
        16 {
            try {
                $avP16  = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
                $nd16   = $avP16 | Where-Object { $_.displayName -notmatch "Windows Defender|Microsoft Defender" }
                $av16   = if ($nd16 -and $nd16[0].displayName) { $nd16[0].displayName } else { "" }
                $drNote = if ($av16) { " NOTE: $av16 drivers may conflict with Memory Integrity. If Windows shows driver compatibility errors after restart, temporarily disable Memory Integrity (same path) until $av16 updates its drivers." } else { "" }

                $rp = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"
                if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                Set-ItemProperty -Path $rp -Name Enabled -Value 1 -Type DWord -Force
                $result = "Memory Integrity enabled -- RESTART REQUIRED to take effect.$drNote See Guide: Phase 1, Step 2"
            } catch { $result = "ERROR: $_" }
        }
        17 {
            try {
                powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null
                powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null
                powercfg /S SCHEME_CURRENT | Out-Null
                $result = "Password required on wake -- enabled for both AC and battery -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        18 {
            try {
                Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name HiberbootEnabled -Value 0 -Type DWord -Force
                $result = "Fast Startup disabled -- full clean shutdown now active -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        19 {
            try {
                Get-NetAdapter -Physical -EA Stop | Where-Object { $_.Status -eq "Up" } | ForEach-Object {
                    Set-NetAdapterPowerManagement -Name $_.Name -WakeOnMagicPacket Disabled -EA SilentlyContinue
                }
                $result = "Wake on LAN disabled on all active network adapters -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
    }

    Write-Log -Message "$($Setting.Name) | Before: $before | Result: $result" -Status "APPLIED"
    return $result
}

# ============================================================
# SCOPE DISCLAIMER
# ============================================================
function Show-ScopeDisclaimer {
    # Ensure sleep prevention is active (in case it failed at startup)
    if (-not $global:SleepPrevented) { Enable-SleepPrevention }

    Write-Host ""
    Draw-Box -Color Gray -Lines @(
        "  WHAT THIS TOOL DOES AND DOES NOT DO                      ",
        "---",
        "  HARDENS security -- turns risky features OFF and         ",
        "  security features ON.                                    ",
        "                                                           ",
        "  Does NOT restore convenience features (Widgets, Edge     ",
        "  boost, etc.). Those can be re-enabled in Settings        ",
        "  at any time if you change your mind.                     ",
        "                                                           ",
        "  Edition: $global:WinEdition",
        "  Admin:   $(if ($global:IsAdmin) { 'Full access -- all settings available' } else { 'Limited -- some settings skipped' })",
        "  Power:   $(if ($global:OnBattery) { 'BATTERY -- plug in before BitLocker' } else { 'AC power OK' })  Sleep: $(if ($global:SleepPrevented) { 'ACTIVE' } else { 'inactive' })"
    )
    Write-Host ""
    Pause-ForUser
}

# ============================================================
# MANUAL STEPS REMINDER
# ============================================================
function Show-ManualSteps {
    Write-Host ""
    Draw-Box -Color Cyan -Lines @(
        "  AUTOMATED STEPS COMPLETE                                  ",
        "  These items require YOUR personal action:                 ",
        "---",
        "  [ ] Tamper Protection  -- Windows Security -> V&T          ",
        "      protection settings -> Tamper Protection -> ON          ",
        "      Guide: Phase 1, Step 2                                ",
        "                                                            ",
        "  [ ] Windows Hello      -- Settings -> Accounts ->          ",
        "      Sign-in options -> set up PIN or biometrics           ",
        "      Guide: Phase 1, Step 4                                ",
        "                                                            ",
        "  [ ] Malwarebytes Free  -- Helpful companion for scans.    ",
        "      Not required, but catches what Defender misses.       ",
        "      Skip the real-time trial -- manual scans only.        ",
        "      $AffiliateMalwarebytes",
        "      Guide: Phase 3, Step 4                                ",
        "                                                            ",
        "  [ ] Password Manager   -- Install, migrate passwords.     ",
        "      Guide: Phase 5                                        ",
        "                                                            ",
        "  [ ] 2FA                -- Enable on all important accounts.",
        "      Authenticator app preferred. Guide: Phase 5           ",
        "                                                            ",
        "  [ ] Scheduled Scans    -- AUTOMATED: GatewayGuard set up  ",
        "      Quarterly Defender Offline Scan (Jan/Apr/Jul/Oct)     ",
        "      + Monthly Malwarebytes reminder (1st of month)        ",
        "      Verify: Task Scheduler -> GatewayGuard tasks          ",
        "---",
        "  Log saved to Desktop: $(Split-Path $LogPath -Leaf)",
        "  Guide and support: $GuideURL"
    )
    Write-Host ""
}


# ============================================================
# SCHEDULED SECURITY TASKS
# ============================================================
function Setup-ScheduledTasks {
    Clear-Host
    Write-Host ""
    Draw-Box -Color Cyan -Lines @(
        "  AUTOMATED SCAN SCHEDULE SETUP                            ",
        "  Setting up automatic security scans...                   ",
        "---",
        "  (1) Quarterly Defender Offline Scan                      ",
        "      Runs BEFORE Windows loads -- catches rootkits.       ",
        "      Scheduled: 1st of Jan / Apr / Jul / Oct @ 2 AM       ",
        "                                                            ",
        "  (2) Monthly Malwarebytes Free Reminder                   ",
        "      Popup reminder to run your manual MB scan.           ",
        "      Scheduled: 1st of each month @ 10 AM                 "
    )
    Write-Host ""
    Write-Host "  Setting up tasks -- please wait..." -ForegroundColor Yellow
    Write-Host ""

    $results = @()

    # --- Task 1: Quarterly Defender Offline Scan ---
    try {
        $mpCmd = "$env:ProgramFiles\Windows Defender\MpCmdRun.exe"
        if (-not (Test-Path $mpCmd)) { $mpCmd = "MpCmdRun.exe" }

        $action1  = New-ScheduledTaskAction -Execute $mpCmd -Argument "-Scan -ScanType 4"
        $trigger1 = New-ScheduledTaskTrigger -Monthly -Month 1,4,7,10 -DaysOfMonth 1 -At "02:00AM"
        $settings1 = New-ScheduledTaskSettingsSet -StartWhenAvailable -WakeToRun $false -RunOnlyIfNetworkAvailable $false
        $principal1 = New-ScheduledTaskPrincipal -RunLevel Highest -UserId "SYSTEM"

        $null = Register-ScheduledTask `
            -TaskName    "GatewayGuard - Quarterly Defender Offline Scan" `
            -Action      $action1 `
            -Trigger     $trigger1 `
            -Settings    $settings1 `
            -Principal   $principal1 `
            -Description "GatewayGuard: Flags Defender Offline Scan for next PC restart. Scan runs BEFORE Windows loads to catch rootkits. Quarterly (Jan/Apr/Jul/Oct)." `
            -Force -EA Stop

        $results += @{ Text = "  [OK] Quarterly Defender Offline Scan scheduled (Jan/Apr/Jul/Oct, 1st @ 2AM)"; Color = "Green" }
        Write-Log -Message "Scheduled task created: GatewayGuard - Quarterly Defender Offline Scan" -Status "GOOD"
    } catch {
        $results += @{ Text = "  [!] Quarterly scan task -- could not create: $_"; Color = "Yellow" }
        Write-Log -Message "Scheduled task ERROR: Quarterly Defender Offline Scan -- $_" -Status "ERROR"
    }

    # --- Task 2: Monthly Malwarebytes Reminder ---
    try {
        $scriptDir = "C:\ProgramData\GatewayGuard"
        if (-not (Test-Path $scriptDir)) { New-Item -Path $scriptDir -ItemType Directory -Force | Out-Null }

        $reminderCode = @"
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show(
    "MONTHLY SECURITY REMINDER -- GatewayGuard``n``n" +
    "Please run your Malwarebytes Free scan this month:``n``n" +
    "  1. Open Malwarebytes``n" +
    "  2. Click 'Scan Now'``n" +
    "  3. Review and quarantine any threats found``n``n" +
    "This scan takes 15-45 minutes.``n" +
    "Best done when you are not actively using the PC.``n``n" +
    "Malwarebytes Free does NOT scan automatically.``n" +
    "This monthly reminder is your prompt to run it manually.",
    "GatewayGuard -- Monthly Malwarebytes Reminder",
    [System.Windows.Forms.MessageBoxButtons]::OK,
    [System.Windows.Forms.MessageBoxIcon]::Information
) | Out-Null
"@
        $reminderCode | Out-File -FilePath "$scriptDir\MBReminder.ps1" -Encoding UTF8 -Force

        $action2   = New-ScheduledTaskAction -Execute "powershell.exe" `
            -Argument "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$scriptDir\MBReminder.ps1`""
        $trigger2  = New-ScheduledTaskTrigger -Monthly -DaysOfMonth 1 -At "10:00AM"
        $settings2 = New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable $false
        # Run in the logged-in user context so the popup appears on their desktop
        $principal2 = New-ScheduledTaskPrincipal -RunLevel Limited -LogonType InteractiveToken

        $null = Register-ScheduledTask `
            -TaskName   "GatewayGuard - Monthly Malwarebytes Reminder" `
            -Action     $action2 `
            -Trigger    $trigger2 `
            -Settings   $settings2 `
            -Principal  $principal2 `
            -Description "GatewayGuard: Monthly popup reminder to run a Malwarebytes Free manual scan. Malwarebytes Free cannot scan automatically -- this reminder keeps you on schedule." `
            -Force -EA Stop

        $results += @{ Text = "  [OK] Monthly Malwarebytes reminder scheduled (1st of each month @ 10AM)"; Color = "Green" }
        Write-Log -Message "Scheduled task created: GatewayGuard - Monthly Malwarebytes Reminder" -Status "GOOD"
    } catch {
        $results += @{ Text = "  [!] Monthly MB reminder task -- could not create: $_"; Color = "Yellow" }
        Write-Log -Message "Scheduled task ERROR: Monthly Malwarebytes Reminder -- $_" -Status "ERROR"
    }

    foreach ($r in $results) { Write-Host $r.Text -ForegroundColor $r.Color }

    Write-Host ""
    Write-Host "  IMPORTANT -- HOW THE OFFLINE SCAN WORKS:" -ForegroundColor White
    Write-Host "  The quarterly task runs MpCmdRun.exe -ScanType 4 which SCHEDULES" -ForegroundColor Gray
    Write-Host "  the offline scan for your NEXT PC restart. You will see:" -ForegroundColor Gray
    Write-Host "    'Microsoft Defender Offline' screen on startup" -ForegroundColor DarkCyan
    Write-Host "  The scan runs before Windows fully loads -- this is intentional" -ForegroundColor Gray
    Write-Host "  and allows it to catch rootkits Defender cannot see at runtime." -ForegroundColor Gray
    Write-Host ""
    Write-Host "  To view scheduled tasks: Task Scheduler -> Task Scheduler Library" -ForegroundColor DarkGray
    Write-Host "  Look for 'GatewayGuard' tasks." -ForegroundColor DarkGray
    Write-Host ""
    Pause-ForUser
}

# ============================================================
# BITLOCKER TIME ESTIMATE
# ============================================================
function Get-BitLockerTimeEstimate {
    try {
        $cDrive = Get-PSDrive C -EA Stop
        $driveGB = [math]::Round(($cDrive.Used + $cDrive.Free) / 1GB)
        $disk = Get-PhysicalDisk -EA SilentlyContinue | Select-Object -First 1
        $isSSD = ($disk -and $disk.MediaType -match "SSD|Solid")
        $ramGB = if ($global:RAMGB -gt 0) { $global:RAMGB } else { 8 }

        if ($isSSD) {
            if ($ramGB -le 8)      { $estimate = "1-3 hours";     $severity = "medium" }
            elseif ($ramGB -le 16) { $estimate = "45 min-2 hours"; $severity = "medium" }
            else                   { $estimate = "20-60 minutes";  $severity = "low" }
        } else {
            $minH = [math]::Max(2, [math]::Round($driveGB / 200))
            $maxH = [math]::Max(4, [math]::Round($driveGB / 80))
            $estimate = "$minH-$maxH hours"
            $severity = if ($maxH -ge 6) { "high" } else { "medium" }
        }

        return [PSCustomObject]@{
            DriveGB   = $driveGB
            DriveType = if ($isSSD) { "SSD (solid state)" } elseif ($disk) { "HDD (hard drive)" } else { "Unknown type" }
            RAMGB     = $ramGB
            Estimate  = $estimate
            Severity  = $severity
        }
    } catch {
        return [PSCustomObject]@{ DriveGB=0; DriveType="Unknown"; RAMGB=$global:RAMGB; Estimate="several hours"; Severity="high" }
    }
}

function Save-BitLockerKey {
    param($Key)
    $global:BitLockerKeyPath = "$env:USERPROFILE\Desktop\BitLocker-Recovery-Key-$(Get-Date -Format 'yyyy-MM-dd').txt"
    @"
========================================================
  BITLOCKER / DEVICE ENCRYPTION RECOVERY KEY
  Generated: $(Get-Date)
  Computer:  $env:COMPUTERNAME
  Windows:   $global:WinEdition
========================================================

  Recovery Key ID: $($Key.KeyProtectorId)
  Recovery Key:    $($Key.RecoveryPassword)

========================================================
  !  YOU MUST DO BOTH OF THE FOLLOWING:

  1. COPY THIS FILE TO A USB DRIVE
     Store the USB somewhere SAFE -- NOT near this PC.

  2. PRINT THIS PAGE
     Store the printout SEPARATELY from the computer.
     Suggested: fireproof box, safe, or bank.

  IF WINDOWS ASKS FOR THIS KEY AT STARTUP AND YOU
  CANNOT PROVIDE IT, YOUR FILES CANNOT BE RECOVERED.
  There are NO exceptions. No one can help you.

  See Guide: Phase 1, Step 3 at $GuideURL
========================================================
"@ | Out-File -FilePath $global:BitLockerKeyPath -Encoding UTF8
}

# ============================================================
# BITLOCKER DEDICATED SCREEN (always LAST)
# ============================================================
function Show-BitLockerScreen {
    try {
        $vol = Get-BitLockerVolume -MountPoint $env:SystemDrive -EA Stop
        if ($vol.ProtectionStatus -eq "On") {
            Write-Host ""
            Write-Host "  BitLocker / Device Encryption: Already enabled -- GOOD" -ForegroundColor Green
            Write-Log -Message "BitLocker already enabled -- no change needed" -Status "GOOD"
            Pause-ForUser
            return
        }
    } catch {}

    # --- Re-check power status NOW (may have changed since pre-flight) ---
    try {
        $blBatt = Get-WmiObject -Class Win32_Battery -EA SilentlyContinue
        $blOnBattery = ($null -ne $blBatt -and $blBatt.BatteryStatus -eq 1)
        $blBattPct   = if ($null -ne $blBatt -and $blBatt.EstimatedChargeRemaining) { "$($blBatt.EstimatedChargeRemaining)%" } else { "N/A" }
        $global:OnBattery = $blOnBattery
    } catch {
        $blOnBattery = $global:OnBattery
        $blBattPct   = "Unknown"
    }

    # --- If on battery, require AC power BEFORE showing options ---
    if ($blOnBattery) {
        Clear-Host
        Write-Host ""
        Draw-Box -Color Red -Lines @(
            "  !!  BITLOCKER REQUIRES AC POWER                       ",
            "---",
            "  You are currently running on BATTERY ($blBattPct).    ",
            "                                                         ",
            "  BitLocker can take several hours. If your PC loses     ",
            "  power mid-encryption, the drive may be unrecoverable.  ",
            "                                                         ",
            "  Please plug into AC power before continuing.           "
        )
        Write-Host ""
        Write-Host "  Plug in AC power, then press any key to continue..." -ForegroundColor Yellow
        Write-Host "  Or press S to skip BitLocker for now." -ForegroundColor Gray
        Write-Host ""
        $blKey = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        if ($blKey.Character -match "^[Ss]$") {
            Write-Host "  BitLocker skipped. Enable later via Settings -> Privacy & security -> Device encryption." -ForegroundColor Yellow
            Write-Log -Message "BitLocker skipped -- on battery, user chose to skip" -Status "SKIP"
            Pause-ForUser
            return
        }
        # Re-check after user plugged in
        $blBatt2 = Get-WmiObject -Class Win32_Battery -EA SilentlyContinue
        if ($null -ne $blBatt2 -and $blBatt2.BatteryStatus -eq 1) {
            Write-Host ""
            Write-Host "  Still on battery -- skipping BitLocker for safety." -ForegroundColor Red
            Write-Log -Message "BitLocker skipped -- still on battery after prompt" -Status "SKIP"
            Pause-ForUser
            return
        }
        $global:OnBattery = $false
        $blOnBattery = $false
    }

    $info = Get-BitLockerTimeEstimate
    $blPowerStatus = if ($blOnBattery) { "BATTERY ($blBattPct) -- plug in AC power" } else { "AC power -- OK to proceed" }

    Clear-Host
    Write-Host ""
    Draw-Box -Color Cyan -Lines @(
        "  FINAL ITEM: BitLocker / Device Encryption",
        "  Guide: Phase 1, Step 3  |  $GuideURL",
        "---",
        "  BitLocker encrypts your entire drive. If your PC is lost",
        "  or stolen, no one can read your files without your",
        "  password. A recovery key will be saved to your Desktop.",
        "  You MUST copy it to USB and print it before finishing.",
        "---",
        "  YOUR PC:",
        "  RAM:    $($info.RAMGB) GB $(if ($info.RAMGB -le 8) { '(minimal -- encryption will be slow)' } elseif ($info.RAMGB -le 16) { '(moderate)' } else { '(ample)' })",
        "  Drive:  $($info.DriveGB) GB $($info.DriveType)",
        "  Time estimate: $($info.Estimate)",
        "  Power:  $blPowerStatus"
    )
    Write-Host ""

    switch ($info.Severity) {
        "low"    { Write-Host "  [1] Enable now -- $($info.Estimate), minimal impact" -ForegroundColor Green }
        "medium" { Write-Host "  [1] Enable now -- $($info.Estimate), some slowdown while encrypting" -ForegroundColor Yellow }
        "high"   { Write-Host "  [1] Enable now -- $($info.Estimate), significant slowdown expected" -ForegroundColor Red }
    }
    Write-Host "      Sleep will be set to Never automatically. PC must stay ON and plugged in." -ForegroundColor DarkGray
    Write-Host ""

    switch ($info.Severity) {
        "low"    { Write-Host "  [2] Enable overnight -- fine if you prefer" -ForegroundColor White }
        "medium" { Write-Host "  [2] Enable overnight -- convenient for this time estimate" -ForegroundColor White }
        "high"   { Write-Host "  [2] Enable overnight -- RECOMMENDED for your PC" -ForegroundColor Cyan }
    }
    Write-Host "      Sleep will be set to Never automatically. Check Desktop log in the morning." -ForegroundColor DarkGray
    Write-Host ""

    Write-Host "  [3] Skip for now -- enable manually when ready:" -ForegroundColor White
    Write-Host "      Settings -> Privacy & security -> Device encryption -> On" -ForegroundColor DarkGray
    Write-Host ""

    do { $choice = Read-Host "  Choose option (1, 2, or 3)" } while ($choice -notin "1","2","3")

    if ($choice -eq "3") {
        Write-Host ""
        Write-Host "  BitLocker skipped. Enable later via Device encryption in Settings." -ForegroundColor Yellow
        Write-Log -Message "BitLocker skipped by user. Drive: $($info.DriveGB)GB $($info.DriveType), RAM: $($info.RAMGB)GB, Estimate: $($info.Estimate)" -Status "SKIP"
        Pause-ForUser
        return
    }

    # --- Set sleep/display to Never before starting BitLocker ---
    Write-Host ""
    Write-Host "  Setting Sleep and Display to Never for encryption..." -ForegroundColor Cyan
    try {
        # Save original AC sleep and display timeout values
        $blOrigSleepRaw = powercfg /query SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 2>$null
        $blOrigDisplayRaw = powercfg /query SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 2>$null
        $blOrigSleep = if ($blOrigSleepRaw -match "Current AC Power Setting Index: 0x(\w+)") { [int]"0x$($Matches[1])" } else { 0 }
        $blOrigDisplay = if ($blOrigDisplayRaw -match "Current AC Power Setting Index: 0x(\w+)") { [int]"0x$($Matches[1])" } else { 0 }

        # Set both to Never (0 = never)
        powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0 | Out-Null
        powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0 | Out-Null
        powercfg /S SCHEME_CURRENT | Out-Null
        Write-Host "  Sleep: Never  |  Display: Never  (will restore after encryption)" -ForegroundColor Green
        $blSleepChanged = $true
    } catch {
        Write-Host "  Note: Could not auto-set sleep -- set manually if leaving overnight." -ForegroundColor Yellow
        $blSleepChanged = $false
        $blOrigSleep = 0
        $blOrigDisplay = 0
    }
    Write-Host ""

    if ($choice -eq "2") {
        Write-Host "  Starting encryption -- PC will continue overnight." -ForegroundColor Cyan
        Write-Host "  Sleep and display are set to Never. Check Desktop log in the morning." -ForegroundColor Yellow
    }

    try {
        Enable-BitLocker -MountPoint $env:SystemDrive -RecoveryPasswordProtector -EA Stop | Out-Null
        $key = (Get-BitLockerVolume -MountPoint $env:SystemDrive).KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }
        Save-BitLockerKey -Key $key
        $global:BitLockerKeyGenerated = $true
        Write-Log -Message "BitLocker enabled. Drive: $($info.DriveGB)GB $($info.DriveType), RAM: $($info.RAMGB)GB, Estimate: $($info.Estimate), Mode: $(if ($choice -eq '2') { 'overnight' } else { 'now' })" -Status "APPLIED"

        Write-Host ""
        Draw-Box -Color Red -Lines @(
            "  !  BITLOCKER RECOVERY KEY -- CRITICAL ACTION REQUIRED    ",
            "---",
            "  Recovery key saved to your Desktop:                      ",
            "  $(Split-Path $global:BitLockerKeyPath -Leaf)",
            "                                                           ",
            "  YOU MUST DO BOTH OF THE FOLLOWING RIGHT NOW:            ",
            "                                                           ",
            "  1. COPY the file to a USB drive stored AWAY from this   ",
            "     PC -- not in a drawer next to it.                     ",
            "                                                           ",
            "  2. PRINT the file and store the printout separately      ",
            "     from your PC -- fireproof box, safe, or bank.         ",
            "                                                           ",
            "  IF WINDOWS ASKS FOR THIS KEY AT STARTUP AND YOU         ",
            "  CANNOT PROVIDE IT, YOUR FILES CANNOT BE RECOVERED.      ",
            "  No exceptions. No one can help you without this key.    "
        )
        Write-Host ""
        Pause-ForUser "  Press any key ONLY after you have SAVED and PRINTED the recovery key..."
        $global:BitLockerKeyGenerated = $false
    } catch {
        Write-Host ""
        Write-Host "  ERROR: $_" -ForegroundColor Red
        Write-Host "  To enable manually: Settings -> Privacy & security -> Device encryption" -ForegroundColor Yellow
        Write-Log -Message "BitLocker error: $_" -Status "ERROR"
        Pause-ForUser
    }

    # --- Restore original sleep/display settings ---
    if ($blSleepChanged) {
        try {
            powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_SLEEP STANDBYIDLE $blOrigSleep | Out-Null
            powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE $blOrigDisplay | Out-Null
            powercfg /S SCHEME_CURRENT | Out-Null
            $restoreMsg = if ($blOrigSleep -eq 0) { "Never" } else { "$([math]::Round($blOrigSleep/60)) min" }
            Write-Log -Message "BitLocker: restored sleep to original setting ($restoreMsg)" -Status "INFO"
        } catch {
            Write-Log -Message "BitLocker: could not restore sleep settings -- $_" -Status "WARN"
        }
    }
}

# ============================================================
# MODE SELECTOR
# ============================================================
function Show-ModeSelector {
    Clear-Host
    Write-Host ""
    Draw-Box -Color Cyan -Lines @(
        "  GatewayGuard Windows 11 Security Hardening Tool v$ScriptVersion    ",
        "  William F. Burns III                                     ",
        "  Former Information Security Officer                       ",
        "  Port Authority of New York & New Jersey                   ",
        "---",
        "  No changes are made without your approval.                ",
        "  A complete log is saved to your Desktop after each run.   ",
        "  Guide and support: $GuideURL",
        "---",
        "  SELECT A MODE:                                            ",
        "                                                            ",
        "  [1] CONSOLE MODE                                          ",
        "      Text-based checklist in this window. Shows each       ",
        "      setting, its live status, and asks Y/N before any     ",
        "      change. Fast and fully transparent.                   ",
        "                                                            ",
        "  [2] GUI MODE                                              ",
        "      Opens a visual window with checkboxes and color-coded ",
        "      status indicators. Recommended for first time users.  ",
        "                                                            ",
        "  [3] EXIT                                                  ",
        "                                                            ",
        "  Admin status: $(if ($global:IsAdmin) { 'FULL ACCESS OK' } else { 'LIMITED MODE -- some settings unavailable' })",
        "  Edition: $global:WinEdition"
    )
    Write-Host ""
}

# ============================================================
# CONSOLE MODE
# ============================================================
function Run-ConsoleMode {
    trap {
        Write-Host ""
        Write-Host "  ERROR: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "  Line: $($_.InvocationInfo.ScriptLineNumber)" -ForegroundColor Red
        Pause-ForUser "  Press any key to exit..."
        Disable-SleepPrevention
        Save-Log
        exit
    }

    Clear-Host
    Write-Host ""
    Write-Host "  Checking current settings -- please wait..." -ForegroundColor Yellow
    Get-AllStatuses
    Show-ScopeDisclaimer

    :checklistLoop while ($true) {
        Clear-Host
        Write-Host ""
        Write-Host "  +--+----------------------------------------+--------------------+" -ForegroundColor Cyan
        Write-Host "  |  | GatewayGuard Security Hardening v3.0   | Console Mode       |" -ForegroundColor Cyan
        Write-Host "  +--+----------------------------------------+--------------------+" -ForegroundColor Cyan
        Write-Host "  |  | Setting                                | Status             |" -ForegroundColor Cyan
        Write-Host "  +--+----------------------------------------+--------------------+" -ForegroundColor Cyan

        foreach ($s in $Settings) {
            $chk      = if ($s.Selected) { "[X]" } else { "[ ]" }
            $auto     = if (-not $s.CanAuto) { "*" } elseif ($s.RequiresAdmin -and -not $global:IsAdmin) { "!" } else { "" }
            $nameStr  = ("{0} {1,2}. {2}" -f $chk, $s.ID, ($s.Name + $auto))
            $nameStr  = if ($nameStr.Length -gt 40) { $nameStr.Substring(0,40) } else { $nameStr.PadRight(40) }
            $statusStr = if ($s.Status.Length -gt 20) { $s.Status.Substring(0,20) } else { $s.Status.PadRight(20) }
            $statusColor = if ($s.Status -match "GOOD") { "Green" }
                           elseif ($s.Status -match "needs attention|OFF --") { "Yellow" }
                           elseif ($s.Status -match "ERROR|risk") { "Red" }
                           else { "Gray" }
            $nameColor = if ($s.SecurityCritical -and -not $s.Selected -and $s.Status -notmatch "GOOD|N/A|ENCRYPTED|primary") { "Red" } else { "White" }
            Write-Host "  | " -ForegroundColor Cyan -NoNewline
            Write-Host $nameStr -ForegroundColor $nameColor -NoNewline
            Write-Host " | " -ForegroundColor Cyan -NoNewline
            Write-Host $statusStr -ForegroundColor $statusColor -NoNewline
            Write-Host " |" -ForegroundColor Cyan
        }

        Write-Host "  +--+----------------------------------------+--------------------+" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  * = Manual action only   ! = Requires admin   [X] = Will be applied" -ForegroundColor DarkGray
        Write-Host "  Green = Already correct   Yellow = Needs attention   Red = Security risk" -ForegroundColor DarkGray
        Write-Host ""
        Write-Host "  Commands:" -ForegroundColor Yellow
        Write-Host "    R = Run selected items     [number] = toggle item on/off" -ForegroundColor Yellow
        Write-Host "    A = Select all             N = Deselect all    Q = Quit" -ForegroundColor Yellow
        Write-Host ""

        $userInput = Read-Host "  Enter command"

        switch ($userInput.ToUpper()) {
            "A" { $Settings | ForEach-Object { $_.Selected = $true } }
            "N" { $Settings | ForEach-Object { $_.Selected = $false } }
            "Q" { Confirm-Exit "All changes from this session would be lost."; continue checklistLoop }
            "R" {
                $selectedCount = ($Settings | Where-Object { $_.Selected }).Count
                if ($selectedCount -eq 0) {
                    Write-Host ""
                    Write-Host "  Nothing selected. Type a number to toggle, or A to select all." -ForegroundColor Yellow
                    Pause-ForUser
                    continue checklistLoop
                }

                $proceed = Test-NonRecommendedSelections -Stage "review"
                if (-not $proceed) { continue checklistLoop }

                Clear-Host
                Write-Host ""
                Draw-Box -Color Cyan -Lines @(
                    "  REVIEW YOUR SELECTIONS -- NO CHANGES MADE YET           ",
                    "---",
                    "  Items marked [X] WILL be applied.                       ",
                    "  Items marked [ ] will be SKIPPED.                       ",
                    "  BitLocker (if selected) is always handled last.         "
                )
                Write-Host ""
                foreach ($s in $Settings) {
                    $chk      = if ($s.Selected) { "[X] WILL APPLY" } else { "[ ] SKIPPED   " }
                    $critical = if ($s.SecurityCritical -and -not $s.Selected -and $s.Status -notmatch "GOOD|N/A|ENCRYPTED|primary") { " !! SECURITY RISK" } else { "" }
                    $color    = if ($s.Selected) { "White" } elseif ($critical) { "Red" } else { "DarkGray" }
                    $statusShort = if ($s.Status.Length -gt 24) { $s.Status.Substring(0,24) } else { $s.Status }
                    Write-Host ("  {0} {1,2}. {2,-35} {3}{4}" -f $chk, $s.ID, $s.Name, $statusShort, $critical) -ForegroundColor $color
                }
                Write-Host ""
                Write-Host "  $selectedCount item(s) will be applied. Y/N prompt shown for each." -ForegroundColor Yellow
                Write-Host ""

                do {
                    $finalCheck = Read-Host "  Ready to proceed? (Y = Start / N = Go back / Q = Quit)"
                    switch ($finalCheck.ToUpper()) {
                        "Q" { Confirm-Exit; continue checklistLoop }
                        "N" { continue checklistLoop }
                    }
                } while ($finalCheck.ToUpper() -ne "Y")

                $proceed2 = Test-NonRecommendedSelections -Stage "final"
                if (-not $proceed2) { continue checklistLoop }

                Write-Host ""
                Write-Host "  Starting -- $selectedCount item(s) to process..." -ForegroundColor Cyan
                Write-Log -Message "=== Console Mode Hardening Run Started ===" -Status "START"

                $goodItems = [System.Collections.Generic.List[PSCustomObject]]::new()

                foreach ($s in ($Settings | Where-Object { $_.Selected -and $_.ID -ne 8 })) {
                    if ($s.Status -match "GOOD") {
                        Write-Host ""
                        Write-Host "  ----------------------------------------------------------------" -ForegroundColor DarkGray
                        Write-Host "  [$($s.ID)] $($s.Name)" -ForegroundColor White
                        Write-Host "  Current: $($s.Status)" -ForegroundColor Green
                        Write-Host "  What:    $($s.Description)" -ForegroundColor Gray
                        Write-Host ""
                        Write-Host "  This setting is already at the recommended state." -ForegroundColor Green
                        Write-Host "  N = Skip   Y = Change this setting   B = Back to checklist" -ForegroundColor White
                        $goodResp = Read-Host "  Choice (N/Y/B)"
                        switch ($goodResp.ToUpper()) {
                            "B" { continue checklistLoop }
                            "Y" {
                                Write-Host ""
                                if ($s.SecurityCritical) {
                                    Write-Host "  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" -ForegroundColor Red
                                    Write-Host "  !!  SECURITY CRITICAL WARNING                             !!" -ForegroundColor Red
                                    Write-Host "  !!  $($s.Name) is a critical security protection.".PadRight(63) + "!!" -ForegroundColor Red
                                    Write-Host "  !!  Changing or disabling this WILL reduce your security.!!" -ForegroundColor Red
                                    Write-Host "  !!  Only proceed if you have a specific technical reason. !!" -ForegroundColor Red
                                    Write-Host "  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" -ForegroundColor Red
                                } else {
                                    Write-Host "  !! WARNING: This setting is already correctly configured." -ForegroundColor Yellow
                                    Write-Host "     Changing it may reduce your security protection." -ForegroundColor Yellow
                                    Write-Host "     Only continue if you have a specific reason to change it." -ForegroundColor Yellow
                                }
                                Write-Host ""
                                $warnResp = Read-Host "  Continue and change this setting? (Y = Yes, I understand the risk / N = Cancel)"
                                if ($warnResp.ToUpper() -eq "Y") {
                                    Write-Host "  Applying..." -ForegroundColor Cyan
                                    $result = Apply-Setting -Setting $s
                                    Write-Host "  Result: $result" -ForegroundColor Cyan
                                    Write-Log -Message "$($s.Name) -- changed by user despite GOOD status" -Status "CHANGED"
                                    Pause-ForUser
                                } else {
                                    Write-Host "  Cancelled -- no change made." -ForegroundColor Gray
                                    $goodItems.Add($s)
                                    Write-Log -Message "$($s.Name) -- already correct, user cancelled change" -Status "GOOD"
                                }
                            }
                            default {
                                $goodItems.Add($s)
                                Write-Log -Message "$($s.Name) -- already correct, skipped" -Status "GOOD"
                            }
                        }
                        continue
                    }

                    Write-Host ""
                    Write-Host "  ----------------------------------------------------------------" -ForegroundColor DarkGray
                    Write-Host "  [$($s.ID)] $($s.Name)" -ForegroundColor White
                    Write-Host "  Guide:   $($s.GuideRef)" -ForegroundColor Yellow
                    Write-Host "  Current: $($s.Status)" -ForegroundColor $(if ($s.Status -match "GOOD") { "Green" } elseif ($s.Status -match "needs") { "Yellow" } else { "Gray" })
                    Write-Host "  What:    $($s.Description)" -ForegroundColor Gray

                    # ── Convenience feature WHY explanation ──
                    switch ($s.ID) {
                        11 {
                            Write-Host ""
                            Write-Host "  WHY TURN THIS OFF:" -ForegroundColor Cyan
                            Write-Host "  Windows assigns each account an Advertising ID and uses it" -ForegroundColor Gray
                            Write-Host "  to track your activity across apps and websites to serve" -ForegroundColor Gray
                            Write-Host "  targeted ads. Turning it off stops this tracking entirely." -ForegroundColor Gray
                            Write-Host "  You still see ads -- they just won't be targeted to you." -ForegroundColor Gray
                        }
                        12 {
                            Write-Host ""
                            Write-Host "  WHY RESTRICT THIS:" -ForegroundColor Cyan
                            Write-Host "  By default, Windows sends detailed diagnostic data to" -ForegroundColor Gray
                            Write-Host "  Microsoft including app usage, browsing habits, and" -ForegroundColor Gray
                            Write-Host "  error reports. 'Required Only' limits this to the minimum" -ForegroundColor Gray
                            Write-Host "  needed for Windows to function. Windows continues to work" -ForegroundColor Gray
                            Write-Host "  normally -- Microsoft just receives less about your usage." -ForegroundColor Gray
                        }
                        13 {
                            Write-Host ""
                            Write-Host "  WHY TURN THIS OFF:" -ForegroundColor Cyan
                            Write-Host "  Edge Startup Boost launches Edge processes in the background" -ForegroundColor Gray
                            Write-Host "  every time your PC boots, even if you never open Edge." -ForegroundColor Gray
                            Write-Host "  Background mode keeps Edge running after you close it." -ForegroundColor Gray
                            Write-Host "  Both waste RAM and CPU. Turning them off does NOT remove" -ForegroundColor Gray
                            Write-Host "  Edge -- it just stops it from running when you don't use it." -ForegroundColor Gray
                        }
                        14 {
                            Write-Host ""
                            Write-Host "  WHY DISABLE WIDGETS:" -ForegroundColor Cyan
                            Write-Host "  The Windows Widgets panel (news, weather, stocks) runs" -ForegroundColor Gray
                            Write-Host "  background Edge WebView2 processes at all times, consuming" -ForegroundColor Gray
                            Write-Host "  RAM even when the panel is closed. It also sends browsing" -ForegroundColor Gray
                            Write-Host "  behavior data to Microsoft. Disabling Widgets does NOT" -ForegroundColor Gray
                            Write-Host "  affect the taskbar, Start menu, or any other feature." -ForegroundColor Gray
                        }
                        15 {
                            Write-Host ""
                            Write-Host "  WHY DISABLE EDGE PASSWORD SAVING:" -ForegroundColor Cyan
                            Write-Host "  Browser-saved passwords are stored with minimal encryption" -ForegroundColor Gray
                            Write-Host "  and are vulnerable if someone gains access to your PC or" -ForegroundColor Gray
                            Write-Host "  if Edge is compromised by malware. A dedicated password" -ForegroundColor Gray
                            Write-Host "  manager (Bitwarden, 1Password, etc.) uses stronger" -ForegroundColor Gray
                            Write-Host "  encryption and works across all browsers and devices." -ForegroundColor Gray
                            Write-Host "  Turning this off does NOT delete saved passwords -- it" -ForegroundColor Gray
                            Write-Host "  just stops Edge from saving new ones going forward." -ForegroundColor Gray
                        }
                    }

                    if ($s.ID -eq 16) {
                        Write-Host "  NOTE: Memory Integrity requires a RESTART after enabling." -ForegroundColor Yellow
                    }

                    if (-not $s.CanAuto) {
                        Write-Host ""
                        Write-Host "  Manual action required -- cannot be automated." -ForegroundColor Red
                        $r = Apply-Setting -Setting $s
                        Write-Host "  INSTRUCTIONS: $r" -ForegroundColor Yellow
                        Pause-ForUser
                        continue
                    }
                    if ($s.RequiresAdmin -and -not $global:IsAdmin) {
                        Write-Host "  SKIPPED: Administrator access required." -ForegroundColor Gray
                        Write-Log -Message "$($s.Name) skipped -- no admin" -Status "SKIP"
                        continue
                    }
                    if ($s.SkipOnHome -and ($global:WinEdition -notmatch "Pro|Enterprise|Education")) {
                        Write-Host "  SKIPPED: Not available on Windows 11 Home." -ForegroundColor Gray
                        Write-Log -Message "$($s.Name) skipped -- Home edition" -Status "SKIP"
                        continue
                    }

                    Write-Host ""
                    Write-Host "  Y = Apply this change   N = Skip   B = Back to checklist" -ForegroundColor White
                    $confirm = Read-Host "  Apply? (Y/N/B)"
                    switch ($confirm.ToUpper()) {
                        "B" { continue checklistLoop }
                        "N" {
                            Write-Host "  Skipped." -ForegroundColor Gray
                            Write-Log -Message "$($s.Name) -- Skipped by user" -Status "SKIP"
                            continue
                        }
                    }
                    Write-Host "  Applying..." -ForegroundColor Cyan
                    $result = Apply-Setting -Setting $s
                    $resultColor = if ($result -match "GOOD|enabled|disabled|set to|Already") { "Green" } elseif ($result -match "NOTE:|MANUAL|manual") { "Yellow" } else { "Red" }
                    Write-Host ""
                    Write-Host "  Result: $result" -ForegroundColor $resultColor
                    Pause-ForUser
                }

                if ($goodItems.Count -gt 0) {
                    Write-Host ""
                    Draw-Box -Color Green -Lines @(
                        "  ALREADY CORRECT -- AUTO-SKIPPED ($($goodItems.Count) items)            ",
                        "---",
                        "  These settings were already at the recommended state     ",
                        "  and did not need to be changed:                          "
                    )
                    foreach ($item in $goodItems) {
                        Write-Host "  OK  $($item.ID). $($item.Name) -- $($item.Status)" -ForegroundColor Green
                    }
                    Write-Host ""
                    $changeGood = Read-Host "  Want to review or change any of these? (Y/N)"
                    if ($changeGood.ToUpper() -eq "Y") {
                        foreach ($item in $goodItems) {
                            Write-Host ""
                            Write-Host "  $($item.ID). $($item.Name)" -ForegroundColor White
                            Write-Host "  Status: $($item.Status)" -ForegroundColor Green
                            Write-Host "  Description: $($item.Description)" -ForegroundColor Gray
                            $reapply = Read-Host "  Force re-apply anyway? (Y/N)"
                            if ($reapply.ToUpper() -eq "Y") {
                                $item.Status = "Forced re-apply by user"
                                $result = Apply-Setting -Setting $item
                                Write-Host "  Result: $result" -ForegroundColor Cyan
                            }
                        }
                    }
                    Pause-ForUser
                }

                $blSetting = $Settings | Where-Object { $_.ID -eq 8 }
                if ($blSetting -and $blSetting.Selected) {
                    Show-BitLockerScreen
                }

                Write-Host ""
                Draw-Box -Color Green -Lines @(
                    "  ALL SELECTED ITEMS PROCESSED                           ",
                    "  Log saved to Desktop.                                  ",
                    "  See manual steps below for items needing your action.  "
                )
                Setup-ScheduledTasks
                Show-ManualSteps
                Disable-SleepPrevention
                Restore-ScreenSaver
                Save-Log
                Set-FirstRunComplete
                Pause-ForUser "  Press any key to exit..."
                return
            }
            default {
                if ($userInput -match '^\d+$') {
                    $id = [int]$userInput
                    $item = $Settings | Where-Object { $_.ID -eq $id }
                    if ($item) { $item.Selected = -not $item.Selected }
                }
            }
        }
    }
}

# ============================================================
# GUI MODE  (Garamond font throughout)
# ============================================================
function Run-GUIMode {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    Write-Host "  Checking current settings -- please wait..." -ForegroundColor Yellow
    Get-AllStatuses

    $form = New-Object System.Windows.Forms.Form
    $form.Text    = "GatewayGuard -- Windows 11 Security Hardening Tool v$ScriptVersion -- $global:WinEdition"
    $form.Size    = New-Object System.Drawing.Size(900, 780)
    $form.StartPosition = "CenterScreen"
    $form.BackColor = [System.Drawing.Color]::FromArgb(28, 28, 28)
    $form.ForeColor = [System.Drawing.Color]::White
    $form.Font    = New-Object System.Drawing.Font("Garamond", 9)
    $form.FormBorderStyle = "FixedDialog"
    $form.MaximizeBox = $false

    $form.Add_FormClosing({
        param($sender, $e)
        $resp = [System.Windows.Forms.MessageBox]::Show(
            "Are you sure you want to exit?`n`nNo changes will be saved unless you clicked Run Selected.",
            "Confirm Exit", "YesNo", "Question"
        )
        if ($resp -eq "No") { $e.Cancel = $true }
        else { Disable-SleepPrevention; Save-Log }
    })

    $lblTitle = New-Object System.Windows.Forms.Label
    $lblTitle.Text = "GatewayGuard -- Windows 11 Security Hardening Tool v$ScriptVersion"
    $lblTitle.Font = New-Object System.Drawing.Font("Garamond", 14, [System.Drawing.FontStyle]::Bold)
    $lblTitle.ForeColor = [System.Drawing.Color]::FromArgb(0,180,255)
    $lblTitle.Location = New-Object System.Drawing.Point(15, 10)
    $lblTitle.Size = New-Object System.Drawing.Size(860, 28)
    $form.Controls.Add($lblTitle)

    $lblAuthor = New-Object System.Windows.Forms.Label
    $lblAuthor.Text = "William F. Burns III  |  Former ISO, Port Authority of NY & NJ  |  $GuideURL"
    $lblAuthor.Font = New-Object System.Drawing.Font("Garamond", 9)
    $lblAuthor.ForeColor = [System.Drawing.Color]::Silver
    $lblAuthor.Location = New-Object System.Drawing.Point(15, 42)
    $lblAuthor.Size = New-Object System.Drawing.Size(860, 18)
    $form.Controls.Add($lblAuthor)

    $adminColor = if ($global:IsAdmin) { [System.Drawing.Color]::FromArgb(0,200,100) } else { [System.Drawing.Color]::Orange }
    $lblStatus = New-Object System.Windows.Forms.Label
    $lblStatus.Text = "Edition: $global:WinEdition  |  Admin: $(if ($global:IsAdmin) { 'Full Access OK' } else { 'Limited Mode -- some settings unavailable' })"
    $lblStatus.Font = New-Object System.Drawing.Font("Garamond", 9, [System.Drawing.FontStyle]::Italic)
    $lblStatus.ForeColor = $adminColor
    $lblStatus.Location = New-Object System.Drawing.Point(15, 62)
    $lblStatus.Size = New-Object System.Drawing.Size(860, 18)
    $form.Controls.Add($lblStatus)

    $lblNote = New-Object System.Windows.Forms.Label
    $lblNote.Text = "Select settings to apply. No changes made without approval. Log saved to Desktop after run."
    $lblNote.Font = New-Object System.Drawing.Font("Garamond", 9, [System.Drawing.FontStyle]::Italic)
    $lblNote.ForeColor = [System.Drawing.Color]::FromArgb(255,200,0)
    $lblNote.Location = New-Object System.Drawing.Point(15, 82)
    $lblNote.Size = New-Object System.Drawing.Size(860, 18)
    $form.Controls.Add($lblNote)

    $lblScope = New-Object System.Windows.Forms.Label
    $lblScope.Text = "This tool turns risky features OFF and security features ON. Features can be re-enabled in Windows Settings at any time."
    $lblScope.Font = New-Object System.Drawing.Font("Garamond", 8, [System.Drawing.FontStyle]::Italic)
    $lblScope.ForeColor = [System.Drawing.Color]::FromArgb(180,180,180)
    $lblScope.Location = New-Object System.Drawing.Point(15, 102)
    $lblScope.Size = New-Object System.Drawing.Size(860, 16)
    $form.Controls.Add($lblScope)

    $sep = New-Object System.Windows.Forms.Label
    $sep.BorderStyle = "Fixed3D"
    $sep.Location = New-Object System.Drawing.Point(10, 122)
    $sep.Size = New-Object System.Drawing.Size(864, 2)
    $form.Controls.Add($sep)

    $panel = New-Object System.Windows.Forms.Panel
    $panel.Location = New-Object System.Drawing.Point(10, 126)
    $panel.Size = New-Object System.Drawing.Size(864, 570)
    $panel.AutoScroll = $true
    $panel.BackColor = [System.Drawing.Color]::FromArgb(28, 28, 28)
    $form.Controls.Add($panel)

    foreach ($col in @(
        @{Text="Select"; X=5; W=50},
        @{Text="Setting / Description / Guide Reference"; X=60; W=530},
        @{Text="Current Status"; X=605; W=245}
    )) {
        $lbl = New-Object System.Windows.Forms.Label
        $lbl.Text = $col.Text
        $lbl.Font = New-Object System.Drawing.Font("Garamond", 9, [System.Drawing.FontStyle]::Bold)
        $lbl.ForeColor = [System.Drawing.Color]::FromArgb(0,180,255)
        $lbl.Location = New-Object System.Drawing.Point($col.X, 5)
        $lbl.Size = New-Object System.Drawing.Size($col.W, 18)
        $panel.Controls.Add($lbl)
    }

    $checkboxes = @{}
    $yPos = 28

    foreach ($s in $Settings) {
        $isSkipped = ($s.SkipOnHome -and ($global:WinEdition -notmatch "Pro|Enterprise|Education")) -or ($s.RequiresAdmin -and -not $global:IsAdmin)

        $rowBg = New-Object System.Windows.Forms.Panel
        $rowBg.Location = New-Object System.Drawing.Point(0, $yPos - 2)
        $rowBg.Size = New-Object System.Drawing.Size(848, 56)
        $rowBg.BackColor = if ($isSkipped) { [System.Drawing.Color]::FromArgb(35,35,35) } elseif ($s.ID % 2 -eq 0) { [System.Drawing.Color]::FromArgb(38,38,38) } else { [System.Drawing.Color]::FromArgb(28,28,28) }
        $panel.Controls.Add($rowBg)

        $cb = New-Object System.Windows.Forms.CheckBox
        $cb.Checked = $s.Selected -and -not $isSkipped
        $cb.Enabled = -not $isSkipped
        $cb.Location = New-Object System.Drawing.Point(15, 16)
        $cb.Size = New-Object System.Drawing.Size(20, 20)
        $cb.Tag = $s.ID
        $rowBg.Controls.Add($cb)
        $checkboxes[$s.ID] = $cb

        $nameText = "$($s.ID). $($s.Name)$(if (-not $s.CanAuto) { ' *' })$(if ($isSkipped) { ' [UNAVAILABLE]' })"
        $lblName = New-Object System.Windows.Forms.Label
        $lblName.Text = $nameText
        $lblName.Font = New-Object System.Drawing.Font("Garamond", 10, [System.Drawing.FontStyle]::Bold)
        $lblName.ForeColor = if ($isSkipped) { [System.Drawing.Color]::DimGray } else { [System.Drawing.Color]::White }
        $lblName.Location = New-Object System.Drawing.Point(45, 4)
        $lblName.Size = New-Object System.Drawing.Size(545, 20)
        $rowBg.Controls.Add($lblName)

        $lblDesc = New-Object System.Windows.Forms.Label
        $lblDesc.Text = $s.Description
        $lblDesc.Font = New-Object System.Drawing.Font("Garamond", 9)
        $lblDesc.ForeColor = if ($isSkipped) { [System.Drawing.Color]::DimGray } else { [System.Drawing.Color]::Silver }
        $lblDesc.Location = New-Object System.Drawing.Point(45, 24)
        $lblDesc.Size = New-Object System.Drawing.Size(545, 16)
        $rowBg.Controls.Add($lblDesc)

        $lblGuide = New-Object System.Windows.Forms.Label
        $lblGuide.Text = "Guide: $($s.GuideRef)"
        $lblGuide.Font = New-Object System.Drawing.Font("Garamond", 8, [System.Drawing.FontStyle]::Italic)
        $lblGuide.ForeColor = if ($isSkipped) { [System.Drawing.Color]::DimGray } else { [System.Drawing.Color]::FromArgb(255,200,0) }
        $lblGuide.Location = New-Object System.Drawing.Point(45, 40)
        $lblGuide.Size = New-Object System.Drawing.Size(545, 14)
        $rowBg.Controls.Add($lblGuide)

        $statusColor = if ($s.Status -match "ON|OK|GOOD|ENCRYPTED|CONFIGURED|ALL ON|DISABLED -- GOOD|Required Only|primary|N/A") {
            [System.Drawing.Color]::FromArgb(0,200,100)
        } elseif ($s.Status -match "OFF|NOT SET|PARTIAL|FULL|DEFAULT|action needed|Enabled \(default\)") {
            [System.Drawing.Color]::FromArgb(255,100,100)
        } elseif ($isSkipped) {
            [System.Drawing.Color]::DimGray
        } else {
            [System.Drawing.Color]::Orange
        }

        $lblStat = New-Object System.Windows.Forms.Label
        $lblStat.Text = $s.Status
        $lblStat.Font = New-Object System.Drawing.Font("Garamond", 9, [System.Drawing.FontStyle]::Bold)
        $lblStat.ForeColor = $statusColor
        $lblStat.Location = New-Object System.Drawing.Point(600, 18)
        $lblStat.Size = New-Object System.Drawing.Size(245, 20)
        $rowBg.Controls.Add($lblStat)

        $yPos += 60
    }

    $lblLegend = New-Object System.Windows.Forms.Label
    $lblLegend.Text = "* = Manual action required    UNAVAILABLE = Not supported on this edition or requires admin"
    $lblLegend.Font = New-Object System.Drawing.Font("Garamond", 8, [System.Drawing.FontStyle]::Italic)
    $lblLegend.ForeColor = [System.Drawing.Color]::Silver
    $lblLegend.Location = New-Object System.Drawing.Point(45, $yPos + 4)
    $lblLegend.Size = New-Object System.Drawing.Size(790, 14)
    $panel.Controls.Add($lblLegend)

    $btnCheckAll = New-Object System.Windows.Forms.Button
    $btnCheckAll.Text = "Check All"
    $btnCheckAll.Location = New-Object System.Drawing.Point(10, 707)
    $btnCheckAll.Size = New-Object System.Drawing.Size(100, 32)
    $btnCheckAll.BackColor = [System.Drawing.Color]::FromArgb(50,50,50)
    $btnCheckAll.ForeColor = [System.Drawing.Color]::White
    $btnCheckAll.FlatStyle = "Flat"
    $btnCheckAll.Add_Click({ $checkboxes.Values | Where-Object { $_.Enabled } | ForEach-Object { $_.Checked = $true } })
    $form.Controls.Add($btnCheckAll)

    $btnClear = New-Object System.Windows.Forms.Button
    $btnClear.Text = "Clear All"
    $btnClear.Location = New-Object System.Drawing.Point(118, 707)
    $btnClear.Size = New-Object System.Drawing.Size(100, 32)
    $btnClear.BackColor = [System.Drawing.Color]::FromArgb(50,50,50)
    $btnClear.ForeColor = [System.Drawing.Color]::White
    $btnClear.FlatStyle = "Flat"
    $btnClear.Add_Click({ $checkboxes.Values | ForEach-Object { $_.Checked = $false } })
    $form.Controls.Add($btnClear)

    $btnRun = New-Object System.Windows.Forms.Button
    $btnRun.Text = "RUN SELECTED"
    $btnRun.Location = New-Object System.Drawing.Point(648, 707)
    $btnRun.Size = New-Object System.Drawing.Size(140, 32)
    $btnRun.BackColor = [System.Drawing.Color]::FromArgb(0,120,60)
    $btnRun.ForeColor = [System.Drawing.Color]::White
    $btnRun.FlatStyle = "Flat"
    $btnRun.Font = New-Object System.Drawing.Font("Garamond", 10, [System.Drawing.FontStyle]::Bold)
    $form.Controls.Add($btnRun)

    $btnExit = New-Object System.Windows.Forms.Button
    $btnExit.Text = "Exit"
    $btnExit.Location = New-Object System.Drawing.Point(796, 707)
    $btnExit.Size = New-Object System.Drawing.Size(78, 32)
    $btnExit.BackColor = [System.Drawing.Color]::FromArgb(120,30,30)
    $btnExit.ForeColor = [System.Drawing.Color]::White
    $btnExit.FlatStyle = "Flat"
    $btnExit.Add_Click({
        $resp = [System.Windows.Forms.MessageBox]::Show(
            "Are you sure you want to exit?`n`nNo changes will be saved unless you clicked Run Selected.",
            "Confirm Exit", "YesNo", "Question"
        )
        if ($resp -eq "Yes") { Disable-SleepPrevention; Save-Log; $form.Close() }
    })
    $form.Controls.Add($btnExit)

    $btnRun.Add_Click({
        $selectedIDs = $checkboxes.Keys | Where-Object { $checkboxes[$_].Checked }
        if ($selectedIDs.Count -eq 0) {
            [System.Windows.Forms.MessageBox]::Show("No settings selected. Please check at least one.", "Nothing Selected", "OK", "Warning")
            return
        }

        Write-Log -Message "=== GUI Mode Hardening Run Started ===" -Status "START"
        $btnRun.Enabled = $false
        $btnRun.Text = "Running..."

        foreach ($id in ($selectedIDs | Sort-Object)) {
            if ($id -eq 8) { continue }
            $s = $Settings | Where-Object { $_.ID -eq $id }

            if ($s.Status -match "GOOD") {
                Write-Log -Message "$($s.Name) -- already correct, skipped" -Status "GOOD"
                continue
            }

            if (-not $s.CanAuto) {
                [System.Windows.Forms.MessageBox]::Show(
                    "$($s.Name) requires manual action.`n`n$($s.Description)`n`nSee Guide: $($s.GuideRef) at $GuideURL",
                    "Manual Action Required -- $($s.Name)", "OK", "Information"
                )
                Write-Log -Message "$($s.Name) -- Manual action required" -Status "MANUAL"
                continue
            }

            $msg = "Apply: $($s.Name)?`n`n$($s.Description)`n`nCurrent status: $($s.Status)`n`nGuide: $($s.GuideRef)"
            $confirm = [System.Windows.Forms.MessageBox]::Show($msg, "Confirm -- $($s.Name)", "YesNo", "Question")

            if ($confirm -eq "Yes") {
                $result = Apply-Setting -Setting $s
                [System.Windows.Forms.MessageBox]::Show("Result:`n$result", "Applied -- $($s.Name)", "OK", "Information")
            } else {
                Write-Log -Message "$($s.Name) -- Skipped by user" -Status "SKIP"
            }
        }

        if ($checkboxes.ContainsKey(8) -and $checkboxes[8].Checked) {
            $form.Hide()
            Show-BitLockerScreen
        }

        Save-Log
        Set-FirstRunComplete
        Disable-SleepPrevention
        $form.Hide()
        Setup-ScheduledTasks
        Show-ManualSteps

        [System.Windows.Forms.MessageBox]::Show(
            "All selected settings processed.`n`nLog: $(Split-Path $LogPath -Leaf)`n`nSee the console window for your manual steps checklist.`n`nGuide: $GuideURL",
            "Run Complete", "OK", "Information"
        )
        $form.Close()
    })

    $form.ShowDialog() | Out-Null
}

# ============================================================
# MAIN ENTRY POINT
# Pre-flight sequence (in order):
# 1. Font instructions  2. Company PC warning  3. Domain check
# 4. Admin check  5. Edition detection  6. RAM check
# 7. First run  8. Pre-scan gate  9. Defender AV check
# 10. Power check  11. Power settings  12. Apps audit
# Then: mode selection -> Run-ConsoleMode or Run-GUIMode
# BitLocker is always LAST inside the mode functions
# ============================================================
Clear-Host
Write-Host ""
Write-Host "  GatewayGuard Windows 11 Security Hardening Tool v$ScriptVersion -- $BuildID" -ForegroundColor DarkGray
Write-Host "  File: $(Split-Path -Leaf $PSCommandPath)" -ForegroundColor DarkGray
Write-Host "  $(Get-Date -Format 'yyyy-MM-dd HH:mm')" -ForegroundColor DarkGray
Write-Host ""
Write-Log -Message "Tool launched v$ScriptVersion build $BuildID" -Status "START"

# Activate sleep/screen prevention immediately -- before any screen is shown
Enable-SleepPrevention
Suspend-ScreenSaver

# 1. Font instructions (very first screen)
Show-FontInstructions

# 2-4. Computer / domain / admin checks
Test-PersonalComputer
Test-DomainJoin
Test-AdminAccess

# 5. Edition detection (WMI ONLY -- no Get-WindowsEdition)
Get-WinEdition

# 6. RAM check
Get-RAMStatus

# 7. First run flag
Test-FirstRun

# 8. Pre-scan gate
Show-PreScanGate

# 9. Defender primary AV check
Test-DefenderPrimary

# 10. Power check and sleep prevention
Test-PowerStatus

# 11. Power settings review
Run-PowerSettingsCheck

# 12. Apps audit
Run-AppsAudit

# Mode selection
Show-ModeSelector
do {
    $choice = Read-Host "  Enter choice (1, 2, or 3)"
    if ($choice -notin "1","2","3") {
        Write-Host "  Please enter 1, 2, or 3." -ForegroundColor Yellow
    }
} while ($choice -notin "1","2","3")

Write-Log -Message "Mode selected: $(if ($choice -eq '1') { 'Console' } elseif ($choice -eq '2') { 'GUI' } else { 'Exit' })" -Status "INFO"

switch ($choice) {
    "1" { Run-ConsoleMode }
    "2" { Run-GUIMode }
    "3" {
        Write-Host ""
        Write-Host "  Exiting. No changes made." -ForegroundColor Gray
        Write-Host ""
        Write-Log -Message "User exited at mode selection" -Status "EXIT"
        Disable-SleepPrevention
        Save-Log
        exit
    }
}

# ============================================================
# PRE-BUILD AUDIT: Verify all 15 required functions are present
# (run this block manually to verify before shipping)
# ============================================================
# $requiredFunctions = @(
#     'Enable-SleepPrevention','Disable-SleepPrevention','Get-RAMStatus',
#     'Get-WinEdition','Test-DefenderPrimary','Get-AllStatuses','Apply-Setting',
#     'Run-ConsoleMode','Run-GUIMode','Show-BitLockerScreen','Write-Log',
#     'Save-Log','Draw-Box','Test-PersonalComputer','Test-AdminAccess'
# )
# $defined = (Get-Command -CommandType Function).Name
# $requiredFunctions | ForEach-Object {
#     $status = if ($_ -in $defined) { 'OK' } else { 'MISSING' }
#     Write-Host "  $status  $_"
# }
