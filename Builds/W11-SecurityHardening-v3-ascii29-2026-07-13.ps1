# Dated: 2026-07-13 23:21 ET
# ================================================================
# FILE:    W11-SecurityHardening-v3-ascii29-2026-07-13.ps1
# BUILD:   ascii29  |  Version 3.1
# PRODUCT: GatewayGuard Windows 11 Security Hardening Tool
# AUTHOR:  William F. Burns III
#          Former ISO, Port Authority of NY & NJ
#          Senior InfoSec, PSEG of NJ
#          Computer Forensics: EnCase Enterprise, FTK
# WEBSITE: gatewayguard.co
# USE:     Personal computers only. Run as Administrator.
# CHANGES FROM ascii28 (2026-07-13 night-session logs, 22:11 and 22:16):
#   FT-65:  S-key flood at the security-critical HEADS UP screen root-
#           caused: the menu said 'S = Show me what each item does' but
#           the PROMPT said 'S = Skip' -- contradictory labels. Tester
#           pressed/held S expecting to skip; each buffered auto-repeat
#           re-dumped every explanation with no screen clear and no exit
#           except Y/N (52 accepted 'S' keys in ~2.5 min in the 22:16
#           log). Labels now agree, S clears and re-renders the screen,
#           and buffered repeats are drained AFTER an accepted S -- a
#           targeted post-accept drain, NOT the FT-29 global pre-read
#           flush (which ate first keypresses and stays removed).
#   FT-66:  GLOBAL ERROR TRAP added. Both 7/13 sessions died with NO
#           error line in the log -- a terminating error closes the
#           console instantly when launched from the .bat. The whole
#           main flow now runs in one try/catch: unhandled errors are
#           logged with location + stack trace, the log footer is
#           written, cleanup runs, and the window stays open.
#   FT-67:  BitLocker decision flow added at review (console mode):
#           if the drive is NOT encrypted and item 8 is not selected,
#           a dedicated HEADS UP explains what encryption protects
#           against, S shows the full plain-English write-up, and a
#           second confirmation screen notes the decline (NOTED) --
#           with a go-back path at every step to select item 8.
#   FT-68:  Review-listing hardening: Status now [string]-cast before
#           .Length/.Substring (an array or null Status could throw
#           with no trap -- the switch-Wildcard duplicate-array lesson),
#           plus a breadcrumb log line bracketing the review listing.
#   FT-69:  Ctrl+C now opens the exit confirmation (Confirm-Exit)
#           instead of being silently ignored. FT-24 stopped Ctrl+C
#           from KILLING the tool; testers then reported 'Ctrl+C does
#           nothing'. It now asks 'Are you sure you want to exit?' --
#           an accidental copy attempt still cannot end the session.
#   FT-70:  Show-ConvenienceReview was called TWICE back-to-back at the
#           end of console mode -- users saw the screen twice. Deduped.
# CHANGES FROM ascii27 (round-5 field test + 7-log analysis, 2026-07-12/13):
#   FT-46:  Ctrl+C REGRESSION root-caused -- the PowerShell console host
#           resets console input mode on its own reads, silently undoing
#           TreatControlCAsInput set once at startup. Now RE-ASSERTED
#           inside every key-reading routine, immediately before each read.
#   FT-47:  Resume no longer replays the personal-PC / admin / power
#           screens in a flash -- ONE quiet re-check screen instead
#           (Show-ResumeReverify). Full screens still show on problems.
#   FT-63:  Startup selection-freeze made visible: launch-to-init delays
#           over 60s now log a WARN (the 84-minute frozen launch in the
#           7/12 logs would have self-diagnosed). New scroll/copy tip
#           screen teaches Mark mode AND that it pauses the program.
#   FT-41/45: Scroll & copy tip screen added after window setup --
#           QuickEdit-off killed mouse copy by design; Mark mode
#           (Alt+Space, E, M ... Esc) is the sanctioned method.
#   FT-61:  Screen-timeout / critical-battery readers rebuilt: stderr
#           captured (2>&1) instead of hidden, hex parsed UNSIGNED
#           ([Convert]::ToUInt32 -- the 0x80000003 lesson again),
#           0xFFFFFFFF treated as Never, and raw powercfg output logged
#           BEFORE anything that can throw (FT-36's diagnostic never
#           fired because the throw happened first).
#   FT-38:  Malwarebytes-detected screen now recommends the DEEP scan
#           with rootkit checking, with click-by-click instructions;
#           trial box corrected -- Deep Scan also works on Free.
#   FT-39:  Wake-on-LAN review now pairs with Remote Desktop: both
#           'let someone in from outside' features strongly recommended
#           OFF, with the tech-support-scam warning spelled out.
#   FT-42:  Immediate 'Confirmed -- checking this PC...' feedback after
#           the personal-PC Y (users pressed Enter again during the
#           silent WMI pause; the stray Enter then skipped a screen).
#   FT-43:  Screen-timeout wording untangled from the tool's temporary
#           sleep-prevention (they read as contradicting each other).
#   FT-44:  Critical-battery message no longer implies the hibernate
#           FEATURE was toggled -- it sets the critical-battery ACTION.
#   FT-52:  Back navigation extended: scope screen (B returns to the
#           password question) and two-page checklist (P = other page).
#   FT-54:  'Checking setting N of 19...' live progress during status
#           checks (blinking cursor looked like a hang).
#   FT-55:  'What this tool does' claims corrected -- Tamper Protection,
#           Windows Hello, and screen timeout moved to a new 'checks but
#           cannot change -- shows you the steps' section.
#   FT-56:  Checklist width adapts to the window -- Setting column
#           42->63, Status 28->38 on maximized consoles (>=116 cols).
#   FT-58:  Checklist split into two pages (room to grow past 19 items);
#           Tamper status wording: 'check again after the trial ends'.
#   FT-60:  Periodic-scanning status wording fixed (manual toggle;
#           steps on the item's own screen).
#   FT-49/64: Instrumentation -- every Draw-Box screen renders a [SCREEN]
#           log line; the console-mode error trap now LOGS the error and
#           line number before exiting (the 16:11 silent exit wrote the
#           error to screen only); Disable-SleepPrevention logs its
#           caller; mode selection wrapped in Select-Mode so key logs
#           name the screen, not the script file.
# CHANGES FROM ascii26 (log analysis, 2026-07-12 -- ascii26 never field-run):
#   FT-37:  ROOT CAUSE of both Defender false alarms: "return if (...)" is
#           invalid PowerShell -- threw at runtime, swallowed by catch,
#           Get-MalwarebytesState returned "Unknown" whenever Defender RT
#           was off. Fixed; trial detection now actually runs.
#   FT-35:  Resume prompt now skipped in non-admin sessions -- an
#           accidental non-admin launch could previously START OVER and
#           wipe a real checkpoint (seen in the 22:30 field log)
#   FT-36:  powercfg parse failures (Screen timeout / Critical battery
#           "Could not read" on the Dell) now log raw powercfg output
#           so the next log shows exactly why
# CHANGES FROM ascii25 (round-4 field test, 2026-07-11 10:50 PM ET):
#   FT-29:  KEY-EATING FIX -- input-buffer flush removed from all prompts
#           (it was swallowing the first keypress; "press twice" reports).
#           QuickEdit-off + Ctrl+C handling remain the walk-away protections
#   FT-30:  Defender-off alarm now checks Security Center first: if
#           Malwarebytes is registered as the active AV, a calm handoff
#           explanation shows instead of the alarm (round-4 repeat fixed)
#   FT-31:  Password manager question added before the checklist; without
#           one, Edge Password Saving [E] is deselected and left ON
#   FT-32:  Status table cuts now marked with ".." + legend (was silently
#           chopping text on items 3,5,6,7,12,13,14,17)
#   FT-33:  Status #2 fall-through fixed (unknown MB states left
#           "Checking..." on screen)
#   Item 21: Status #5 healthy wording now "OFF is correct here -- GOOD"
#           (periodic scanning OFF is right when Defender is primary)
#   Items 9/10: scroll-to-top warning before the power settings screen +
#           scroll-down review reminder near its bottom
#   Items 13/14/16: "(ends in .co -- NOT .com)" on mode screen; SCROLL UP
#           AND THEN DOWN notices before the scope and checklist screens
#   Item 19: after-trial Tamper Protection reminder in the MB trial box
#   Item 26: Edge password manual check path added to setting description
# CHANGES FROM ascii24 (round-3 field test, 2026-07-11 ~1:30 PM ET):
#   FT-21:  Time check -- after answering N, the follow-up "open Settings?"
#           question is now in a yellow box (was easy to miss)
#   FT-22:  Malwarebytes launch confirmed elevated (inherits admin from
#           this tool); manual-launch fallback now includes right-click
#           Run-as-administrator steps
#   FT-23:  FALSE ALARM FIX -- a failed Defender status check used to be
#           treated as "Defender is OFF" and fired the scary warning;
#           unknown state now gets a calm informational message instead
#   FT-24:  Ctrl+C no longer kills the program (TreatControlCAsInput);
#           WINDOW SETUP now tells users everything is saved in the log
#           so nothing needs copying off screens
#   FT-25:  Not running as admin now shows instructions then CLOSES
#           (limited mode removed); select-then-right-click wording added
#   FT-26:  Immediate "Please wait -- checking your system..." at launch
#           (3-5 s hardware query gap looked like a hang)
#   FT-27:  WINDOW SETUP item 1: "IF YOU HAVEN'T MAXIMIZED THIS WINDOW
#           YET, DO IT NOW!"
#   FT-28:  Time screen explains the "(UTC-05:00)" winter-label confusion
#   FT-11+: Overnight deep-scan recommendation added after Malwarebytes
#           launch (field evidence: deep scan found 6 items quick scans
#           missed)
# CHANGES FROM ascii23 (see FieldTestNotes-2026-07-11 for full detail):
#   FT-01:  Session-ending mitigations -- input buffer flushed before every
#           key prompt (stale keys from focus switches discarded), console
#           QuickEdit mode disabled at launch, every accepted keypress now
#           logged with its screen name for diagnosis
#   FT-04:  Screen order fixed -- Welcome/maximize FIRST, then scroll
#           instruction, THEN font setup, then window setup, then overview
#   FT-05/06: Final scroll wording ("AND FOLLOWING WINDOWS", mouse wheel /
#           little arrows on the right side); WINDOW SETUP item 3 now says
#           "TOP and BOTTOM"
#   FT-10:  Maximize wording now includes Windows key + Up arrow
#   FT-18:  Back navigation (B key) added across the intro sequence --
#           full app-wide Back deferred to a future build
#   FT-19:  Machine make/model + unique machine ID (hash of hardware UUID,
#           ties only to this PC) shown at launch and written into the log
#           header; log is written to disk continuously from launch
#   FT-20:  Visible S = Skip on the "Before we scan your PC" gate
# ================================================================
#Requires -Version 5.1
<#
.SYNOPSIS
    Windows 11 Security Hardening Tool v3.1
    Developed by William F. Burns III
    Former Information Security Officer, Port Authority of New York & New Jersey

.DESCRIPTION
    Automates security settings from the Windows 11 Security Walkthrough Guide.
    FOR PERSONAL COMPUTERS ONLY. No changes made without user approval.
    All actions logged to C:\GatewayGuard\Logs\ (with a backup copy in
    C:\ProgramData\GatewayGuard\Logs).

.NOTES
    Run as Administrator for full functionality.
    Compatible with Windows 11 Home and Pro editions.
#>

# ============================================================
# GLOBALS & INITIALIZATION
# ============================================================
$ScriptVersion  = "3.1"
$BuildID        = "ascii29"
$GuideURL       = "gatewayguard.co"

# STATE/RESUME SYSTEM (UX-05, UX-06) -- survives the offline-scan reboot
$StateDir       = "C:\GatewayGuard"
$StateFilePath  = "$StateDir\gg_state.txt"

# AFFILIATE LINK PLACEHOLDERS -- replace with actual affiliate URLs before publishing
$AffiliateMalwarebytes = "https://gatewayguard.co/malwarebytes"     # AFFILIATE PLACEHOLDER
$AffiliateMicrosoft    = "https://gatewayguard.co/microsoft365"      # AFFILIATE PLACEHOLDER

$LogPath        = "C:\GatewayGuard\Logs\GatewayGuard-Log-$(Get-Date -Format 'yyyy-MM-dd_HH-mm').txt"
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
$script:GGLogNoticeShown      = $false   # FT-67 (ascii29): once-per-session log notice
$script:GGInConfirmExit       = $false   # FT-69 (ascii29): Ctrl+C recursion guard

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
        # BUGFIX ascii23 (2026-07-09, take 3): confirmed root cause via
        # actual test log -- PowerShell parses the HEX literal 0x80000003
        # as a NEGATIVE signed Int32 (-2147483645) first, and [uint32]
        # performs a CHECKED conversion that rejects negative values
        # outright (it does not reinterpret bits). Using the equivalent
        # DECIMAL literal instead avoids the sign ambiguity entirely --
        # PowerShell parses a bare decimal > Int32.MaxValue as a positive
        # Int64, which casts to [uint32] cleanly.
        $flags = [uint32]2147483651   # decimal equivalent of 0x80000003
        [W11Hardening.PowerMgmt]::SetThreadExecutionState($flags) | Out-Null
        $global:SleepPrevented = $true
        Write-Log -Message "Sleep/shutdown prevention activated" -Status "OK"
    } catch {
        Write-Log -Message "Could not activate sleep prevention: $_" -Status "WARN"
    }
}

function Disable-SleepPrevention {
    try {
        if ($global:SleepPrevented) {
            $flags = [uint32]2147483648   # decimal equivalent of 0x80000000 -- see Enable-SleepPrevention note
            [W11Hardening.PowerMgmt]::SetThreadExecutionState($flags) | Out-Null
            $global:SleepPrevented = $false
            # FT-49 instrumentation (ascii28): name the caller -- this line was
            # the ONLY trace of the 16:11 silent exit in the 7/12 logs.
            $ggSpCaller = try { (Get-PSCallStack)[1].Command } catch { "unknown" }
            Write-Log -Message "Sleep prevention deactivated -- normal power management restored (called from: $ggSpCaller)" -Status "OK"
        }
    } catch {}
}

$null = Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action {
    Disable-SleepPrevention
    # Always attempt a backup copy on exit, even abnormal ones -- Save-Log's
    # backup copy only ran on a clean exit before, so a crash or the FT-01
    # Alt-Tab bug meant no backup at all. This is a best-effort safety net.
    try {
        if ($script:LogPath -and (Test-Path $script:LogPath)) {
            $backupDir = "C:\ProgramData\GatewayGuard\Logs"
            if (-not (Test-Path $backupDir)) { New-Item -Path $backupDir -ItemType Directory -Force | Out-Null }
            Copy-Item -Path $script:LogPath -Destination ($backupDir + "\" + (Split-Path $script:LogPath -Leaf)) -Force -EA SilentlyContinue
        }
    } catch {}
}

# ============================================================
# LOGGING
# ============================================================
function Initialize-LogFile {
    # Writes the session header IMMEDIATELY at launch, not retroactively at
    # the end (Save-Log's old behavior). This ensures every log file has a
    # header even if the session ends abnormally (crash, forced close, or
    # the FT-01 Alt-Tab session-ending bug) -- previously, an abnormal exit
    # meant Save-Log never ran and the log was left with no header at all.
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
  Machine:  $global:MachineMake $global:MachineModel
  Machine ID: $global:MachineID (unique to this PC -- a code derived from
              this computer's hardware; it identifies this PC only)
  NOTE: This log is written continuously from launch until the program
        finishes or stops -- if the program ends unexpectedly, the LAST
        LINE below shows exactly where it was.
============================================================

"@
        $header | Out-File -FilePath $LogPath -Encoding UTF8
    } catch {}
}

function Write-Log {
    param([string]$Message, [string]$Status = "INFO")
    $entry = "[$(Get-Date -Format 'HH:mm:ss')] [$Status] $Message"
    $LogEntries.Add($entry)
    if (Test-Path (Split-Path $LogPath -Parent) -ErrorAction SilentlyContinue) {
        try { $entry | Out-File -FilePath $LogPath -Append -Encoding UTF8 -ErrorAction SilentlyContinue } catch {}
    }
}

function Save-Log {
    # Header is now written by Initialize-LogFile at launch -- this only
    # appends the closing footer for a clean/normal session end.
    try {
        $logDir = Split-Path $LogPath -Parent
        if (-not (Test-Path $logDir)) { New-Item -Path $logDir -ItemType Directory -Force | Out-Null }
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
        [System.ConsoleColor]$Color = "White",
        [System.ConsoleColor]$TextColor = "White"
    )
    # Auto-size width to the longest content line (minimum 44)
    $Width = 44
    foreach ($line in $Lines) {
        if ($line -ne "---" -and $line.Length -gt $Width) { $Width = $line.Length }
    }
    $border = "+" + ("=" * $Width) + "+"
    $isHeader = $true
    Write-Host $border -ForegroundColor $Color
    foreach ($line in $Lines) {
        if ($line -eq "---") {
            Write-Host $border -ForegroundColor $Color
            $isHeader = $false
        } else {
            $lineColor = if ($isHeader) { $Color } else { $TextColor }
            Write-Host ("|" + $line.PadRight($Width) + "|") -ForegroundColor $lineColor
        }
    }
    Write-Host $border -ForegroundColor $Color
    # FT-49 instrumentation (ascii28): every rendered box logs its title so
    # an unexpected exit shows exactly which screen was on-screen last.
    try { if ($Lines -and $Lines[0] -ne "---") { Write-Log -Message ("Rendered: " + $Lines[0].Trim()) -Status "SCREEN" } } catch {}
}

# ============================================================
# HELPER: PAUSE (Enter or Space only)
# ============================================================
function Pause-ForUser {
    param([string]$Message = "  Press Enter or Space to continue...")
    if ($Message) { Write-Host "" ; Write-Host $Message -ForegroundColor White }
    try {
        # FT-29 (2026-07-12): buffer flush REMOVED -- it was eating the first
        # keypress whenever the user pressed a key during screen pacing
        # (field-reported 5+ times as "had to press twice"). QuickEdit-off
        # and Ctrl+C handling remain as the FT-01 walk-away protections.
        # FT-46 (ascii28): the console host RESETS input mode on its own
        # reads, undoing TreatControlCAsInput -- re-assert before every read.
        try { [Console]::TreatControlCAsInput = $true } catch {}
        do {
            $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            # FT-69 (ascii29): Ctrl+C opens the exit confirmation
            if ($k.Character -eq [char]3) { Invoke-CtrlCExit }
            # Accept: Enter (13), Space (32), Numpad Enter (13 via numpad)
        } while ($k.VirtualKeyCode -notin @(13, 32))
        # FT-01 diagnostic breadcrumb: log every accepted continue key with
        # the screen (calling function) it came from.
        try { Write-Log -Message ("Continue accepted at: " + (Get-PSCallStack)[1].Command) -Status "KEY" } catch {}
    } catch {
        # Fallback if RawUI unavailable -- use Read-Host silently
        $null = Read-Host
    }
}

# ── READ-VALIDKEY: locked input -- only accepts specified valid keys ──
# All other keypresses silently swallowed -- no accidental triggers
# Crash-protected with try/catch fallback
function Read-ValidKey {
    param(
        [string[]]$ValidKeys,
        [string]$Prompt = ""
    )
    if ($Prompt) { Write-Host "  $Prompt" -ForegroundColor White -NoNewline }
    try {
        # FT-29 (2026-07-12): buffer flush removed -- was eating first keypress
        # FT-46 (ascii28): re-assert Ctrl+C-as-input before every read
        try { [Console]::TreatControlCAsInput = $true } catch {}
        do {
            $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            $ch = $k.Character.ToString().ToUpper()
            # FT-69 (ascii29): Ctrl+C opens the exit confirmation
            if ($k.Character -eq [char]3) { Invoke-CtrlCExit }
            # Special case: Enter key (VK 13) -- map to Y if Y is in ValidKeys as fallback
            if ($k.VirtualKeyCode -eq 13 -and "Y" -in $ValidKeys -and $ch -eq "") {
                $ch = "Y"
            }
        } while ($ch -notin $ValidKeys)
        Write-Host $ch -ForegroundColor Cyan
        # FT-01 diagnostic breadcrumb
        try { Write-Log -Message ("Key '" + $ch + "' accepted at: " + (Get-PSCallStack)[1].Command) -Status "KEY" } catch {}
        return $ch
    } catch {
        # Fallback: use Read-Host if RawUI unavailable (e.g. ISE, redirected console)
        Write-Host ""
        do {
            $fallback = (Read-Host "  Enter choice ($($ValidKeys -join '/'))").ToUpper().Trim()
        } while ($fallback -notin $ValidKeys)
        return $fallback
    }
}

# ── READ-NAVKEY (FT-18, 2026-07-11): forward/back navigation ──
# Returns "NEXT" for Enter/Space, "BACK" for B. All other keys ignored.
function Read-NavKey {
    param([string]$Prompt = "  Press Enter or Space to continue, or B to go back one screen: ")
    if ($Prompt) { Write-Host $Prompt -ForegroundColor White }
    try {
        # FT-29 (2026-07-12): buffer flush removed -- was eating first keypress
        # FT-46 (ascii28): re-assert Ctrl+C-as-input before every read
        try { [Console]::TreatControlCAsInput = $true } catch {}
        do {
            $k  = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            $vk = $k.VirtualKeyCode
            $ch = $k.Character.ToString().ToUpper()
            # FT-69 (ascii29): Ctrl+C opens the exit confirmation
            if ($k.Character -eq [char]3) { Invoke-CtrlCExit }
        } while (($vk -notin @(13, 32)) -and ($ch -ne "B"))
        $result = "NEXT"
        if ($ch -eq "B") { $result = "BACK" }
        try { Write-Log -Message ("Nav '" + $result + "' at: " + (Get-PSCallStack)[1].Command) -Status "KEY" } catch {}
        return $result
    } catch {
        Write-Host ""
        do {
            $fb = (Read-Host "  Type B then Enter to go back, or just press Enter to continue").ToUpper().Trim()
        } while ($fb -notin @("", "B"))
        if ($fb -eq "B") { return "BACK" }
        return "NEXT"
    }
}

# ── DISABLE-QUICKEDIT (FT-01 mitigation, 2026-07-11) ──
# Console QuickEdit mode: a single CLICK inside the window enters text-
# selection mode, which PAUSES the program and swallows the next keypress.
# A user clicking back into the window after using Notepad hits this every
# time. Disabling it for this session removes a whole class of "the program
# froze/ended when I came back" reports.
function Disable-QuickEdit {
    try {
        $sig = @'
[DllImport("kernel32.dll", SetLastError=true)]
public static extern IntPtr GetStdHandle(int nStdHandle);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool GetConsoleMode(IntPtr hConsoleHandle, out uint lpMode);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool SetConsoleMode(IntPtr hConsoleHandle, uint dwMode);
'@
        $k32 = Add-Type -MemberDefinition $sig -Name "ConsoleMode" -Namespace "GatewayGuard" -PassThru
        $handle = $k32::GetStdHandle(-10)   # STD_INPUT_HANDLE
        $mode = [uint32]0
        if ($k32::GetConsoleMode($handle, [ref]$mode)) {
            # Clear ENABLE_QUICK_EDIT_MODE (64), keep ENABLE_EXTENDED_FLAGS (128).
            # DECIMAL literals only -- hex literals near the sign bit caused the
            # ascii23 0x80000003 bug (PowerShell parses hex as SIGNED Int32).
            # 4294967231 = all bits set except bit 6 (QuickEdit).
            $newMode = [uint32](($mode -band [uint32]4294967231) -bor [uint32]128)
            [void]$k32::SetConsoleMode($handle, $newMode)
            Write-Log -Message "QuickEdit mode disabled for this session (FT-01 mitigation)" -Status "OK"
        }
    } catch {
        Write-Log -Message "Could not disable QuickEdit mode (non-fatal): $_" -Status "WARN"
    }
}

# ── GET-MACHINEIDENTITY (FT-19, 2026-07-11) ──
# Identifies the machine make/model and derives a short unique ID from the
# hardware UUID. The ID is a truncated SHA-256 HASH -- it ties only to this
# specific PC but never exposes the raw hardware UUID/serial in a log the
# user might share. Same fingerprint concept planned for licensing.
function Get-MachineIdentity {
    $global:MachineMake  = ""
    $global:MachineModel = ""
    $global:MachineID    = "UNKNOWN"
    try {
        $cs = Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop
        $global:MachineMake  = ("" + $cs.Manufacturer).Trim()
        $global:MachineModel = ("" + $cs.Model).Trim()
    } catch {}
    try {
        $uuid = (Get-CimInstance -ClassName Win32_ComputerSystemProduct -ErrorAction Stop).UUID
        if ($uuid) {
            $sha   = [System.Security.Cryptography.SHA256]::Create()
            $bytes = $sha.ComputeHash([System.Text.Encoding]::UTF8.GetBytes("GatewayGuard|" + $uuid))
            $hex   = -join ($bytes | ForEach-Object { $_.ToString("X2") })
            $global:MachineID = $hex.Substring(0, 12)
        }
    } catch {}
}

# ============================================================
# HELPER: CONFIRM EXIT
# ============================================================
function Confirm-Exit {
    param([string]$Reason = "")
    Write-Host ""
    Write-Host "  Are you sure you want to exit? No changes will be saved." -ForegroundColor Yellow
    if ($Reason) { Write-Host "  $Reason" -ForegroundColor Gray }
    $c = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Exit now? (Y/N): "
    if ($c.ToUpper() -eq "Y") {
        Write-Log -Message "User confirmed exit" -Status "EXIT"
        Disable-SleepPrevention
        Restore-ScreenSaver
        Save-Log
        exit
    }
}

# FT-69 (ascii29): Ctrl+C -> exit confirmation. FT-24 made Ctrl+C an
# ordinary input key so it could no longer KILL the tool mid-session;
# field feedback then flipped to 'Ctrl+C does nothing'. Middle ground:
# Ctrl+C now opens Confirm-Exit, which asks before exiting -- so an
# accidental copy attempt still cannot end the session. The guard flag
# prevents recursion (Ctrl+C pressed AT the exit prompt is ignored).
function Invoke-CtrlCExit {
    if ($script:GGInConfirmExit) { return }
    $script:GGInConfirmExit = $true
    try { Confirm-Exit "You pressed Ctrl+C." } finally { $script:GGInConfirmExit = $false }
}

# ============================================================
# SCREEN 0: FONT INSTRUCTIONS (VERY FIRST SCREEN)
# ============================================================
function Show-FontInstructions {
    Clear-Host
    Write-Host ""

    # ── ADMIN CHECK: If not running as admin, show clear instructions ──
    if (-not $global:IsAdmin) {
        Draw-Box -Color White -Lines @(
            "  IMPORTANT -- HOW TO RUN GATEWAYGUARD CORRECTLY              ",
            "---",
            "  GatewayGuard must be run as Administrator to work properly. ",
            "                                                               ",
            "  HOW TO RUN AS ADMINISTRATOR:                                ",
            "  1. Close this window                                        ",
            "  2. Find the Run-GatewayGuard.bat file in your folder        ",
            "  3. Click it ONCE to select it, then RIGHT-CLICK on it       ",
            "     (right-clicking always shows the administrator option)    ",
            "  4. Select 'Run as administrator'                             ",
            "  5. Click YES when Windows asks 'Do you want to allow        ",
            "     this app to make changes to your device?'                ",
            "                                                               ",
            "  ABOUT THE 'UNKNOWN PUBLISHER' WARNING:                      ",
            "  Windows may show a blue or orange warning saying             ",
            "  'Windows protected your PC' or 'Unknown publisher'.         ",
            "  This is normal for downloaded .bat files.                   ",
            "  Click 'More info' then 'Run anyway' to continue.            ",
            "  GatewayGuard's full source code is visible -- open the      ",
            "  .ps1 file in Notepad to see exactly what it does.           "
        )
        Write-Host ""
        # FT-25 (2026-07-11): limited mode REMOVED -- running without admin
        # meant settings silently could not apply. The tool now closes so
        # the user relaunches it correctly.
        Pause-ForUser "  Press Enter or Space to CLOSE this window, then re-run as Administrator..."
        Write-Log -Message "Not running as Administrator -- instructions shown, tool closed" -Status "EXIT"
        Disable-SleepPrevention; Save-Log; exit
    }

    # ── INTRO SEQUENCE (FT-04 order fix + FT-18 Back navigation, 2026-07-11) ──
    # Order: 1 Welcome/maximize  2 Scroll  3 Font  4 Window setup  5 Overview.
    # B goes back one screen (except on the first screen).
    $introScreens = @(
        {   # Screen 1 of 5: Welcome + maximize (FT-10 final wording)
            Write-Host "  Welcome to GatewayGuard.  (Screen 1 of 5)" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "  For the best experience, please maximize this window now" -ForegroundColor White
            Write-Host "  by clicking the square button in the upper right corner" -ForegroundColor White
            Write-Host "  of this window, or hold the Windows key and press the" -ForegroundColor White
            Write-Host "  Up arrow." -ForegroundColor White
        },
        {   # Screen 2 of 5: Scroll instruction (FT-05/06 final wording)
            Write-Host "  SCROLLING  (Screen 2 of 5)" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "  Now scroll to the TOP and BOTTOM of this window AND" -ForegroundColor White
            Write-Host "  FOLLOWING WINDOWS -- use your mouse wheel, or click the" -ForegroundColor White
            Write-Host "  little arrows on the right side of the window -- so you" -ForegroundColor White
            Write-Host "  don't miss anything." -ForegroundColor White
        },
        {   # Screen 3 of 5: Font setup (FT-04: now AFTER the welcome screens)
            Write-Host "  +==============================================================+" -ForegroundColor Yellow
            Write-Host "  |  STEP 1 OF 2: SET YOUR CONSOLE FONT (takes 30 seconds)       |" -ForegroundColor Yellow
            Write-Host "  +==============================================================+" -ForegroundColor Yellow
            Write-Host "  (Screen 3 of 5)" -ForegroundColor DarkGray
            Write-Host ""
            Write-Host ("  Running: " + (Split-Path -Leaf $PSCommandPath)) -ForegroundColor DarkCyan
            Write-Host "  Version: GatewayGuard v$ScriptVersion  Build: $BuildID" -ForegroundColor DarkCyan
            Write-Host ("  This PC: " + $global:MachineMake + " " + $global:MachineModel + "  |  Machine ID: " + $global:MachineID) -ForegroundColor DarkCyan
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
            Draw-Box -Color White -Lines @(
                "  FONT CHECK: If this box has clean lines, you are ready.   ",
                "  +--+  Good: straight lines and corners                    ",
                "  |  |  Good: text is a comfortable reading size            "
            )
        },
        {   # Screen 4 of 5: Window setup reference (FT-06: TOP and BOTTOM)
            Draw-Box -Color White -Lines @(
                "  BEFORE YOU START -- WINDOW SETUP  (Screen 4 of 5)             ",
                "---",
                "  For the best experience please do the following:              ",
                "                                                                 ",
                "  1. IF YOU HAVEN'T MAXIMIZED THIS WINDOW YET, DO IT NOW!       ",
                "     Click the small SQUARE icon at the TOP RIGHT of this       ",
                "     window (next to the X close button) to go full screen.     ",
                "     OR press Windows key + Up arrow.                           ",
                "                                                                 ",
                "  2. SCROLLING: Some screens are longer than your window.       ",
                "     To scroll UP or DOWN use your mouse scroll wheel.          ",
                "     Scroll arrows also appear at the TOP RIGHT and BOTTOM      ",
                "     RIGHT corners of the window. If the bottom arrow           ",
                "     disappears, move your mouse to the bottom right corner     ",
                "     and it will reappear.                                       ",
                "     PAGE UP / PAGE DOWN keys also scroll quickly.              ",
                "                                                                 ",
                "  3. ALWAYS scroll to the TOP and BOTTOM of every screen        ",
                "     before pressing Enter or Space to continue -- there may    ",
                "     be important information beyond what you can first see.    ",
                "                                                                 ",
                "  4. KEYBOARD: Use ENTER or SPACE BAR to continue on screens   ",
                "     that just need you to read and move on. When asked for     ",
                "     a choice (Y/N/B etc) press that letter key only --         ",
                "     no need to press Enter afterwards.                         ",
                "                                                                 ",
                "  5. GOING BACK: On these setup screens, press B to go back    ",
                "     one screen if you missed something.                        ",
                "                                                                 ",
                "  6. COPYING: You never need to copy anything off these         ",
                "     screens -- everything is saved automatically to your       ",
                "     log file in C:\GatewayGuard\Logs.                          "
            )
        },
        {   # Screen 5 of 5: What happens next
            Draw-Box -Color White -Lines @(
                "  WHAT HAPPENS NEXT -- PLEASE READ  (Screen 5 of 5)         ",
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
        }
    )

    $screenIdx = 0
    while ($screenIdx -lt $introScreens.Count) {
        Clear-Host
        Write-Host ""
        & $introScreens[$screenIdx]
        Write-Host ""
        if ($screenIdx -eq 0) {
            Pause-ForUser "  Press Enter or Space to continue..."
            $screenIdx++
        } else {
            $nav = Read-NavKey
            if ($nav -eq "BACK") { $screenIdx-- } else { $screenIdx++ }
        }
    }
}

# ============================================================
# STEP 1: COMPANY COMPUTER WARNING
# ============================================================
function Test-PersonalComputer {
    Clear-Host
    Write-Host ""
    Draw-Box -Color White -Lines @(
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
        $confirm = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Is this YOUR personal computer? (Y = Yes / N = Exit): "
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
    # FT-42 (ascii28): the next checks run silently for a second or two --
    # without immediate feedback, users pressed Enter again thinking the Y
    # hadn't registered, and that stray Enter then skipped the next screen.
    Write-Host ""
    Write-Host "  Confirmed -- checking this PC..." -ForegroundColor Green
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
            Draw-Box -Color White -Lines @(
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
                $confirm = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue? (Y = This is my personal PC / N = Exit): "
                if ($confirm.ToUpper() -eq "N") {
                    Write-Host ""
                    Write-Host "  Exiting. No changes made." -ForegroundColor Yellow
                    Save-Log; exit
                }
            } while ($confirm.ToUpper() -ne "Y")
            Write-Log -Message "Domain-joined PC ($domainName) -- user confirmed personal use" -Status "WARN"
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
        Draw-Box -Color White -Lines @(
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
            $cont = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue in Limited Mode? (Y = Continue / N = Exit): "
            if ($cont.ToUpper() -eq "N") {
                Write-Host "  Close this window and right-click -> Run as Administrator." -ForegroundColor Yellow
                Save-Log; exit
            }
        } while ($cont.ToUpper() -ne "Y")
        Write-Log -Message "Running in Limited Mode (no admin access)" -Status "WARN"
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
    # Build friendly edition label: keep EditionID (Core, Professional etc) + add Windows 11 label
    # BUGFIX ascii23 (2026-07-10): missing 'break' meant "Professional" matched
    # BOTH *Professional* and *Pro* cases -- switch-as-expression returned both
    # results as an array, which then printed as duplicated text when
    # interpolated into a string ("Professional -- Windows 11 Pro Professional
    # -- Windows 11 Pro"). Added explicit break to each case.
    $global:WinEditionFriendly = switch -Wildcard ($global:WinEdition) {
        "*Core*"           { "$global:WinEdition -- Windows 11 Home"; break }
        "*Home*"           { "$global:WinEdition -- Windows 11 Home"; break }
        "*Professional*"   { "$global:WinEdition -- Windows 11 Pro"; break }
        "*Pro*"            { "$global:WinEdition -- Windows 11 Pro"; break }
        "*Enterprise*"     { "$global:WinEdition -- Windows 11 Enterprise"; break }
        "*Education*"      { "$global:WinEdition -- Windows 11 Education"; break }
        default            { $global:WinEdition }
    }

    Write-Log -Message "Windows Edition: $global:WinEditionFriendly" -Status "INFO"

    $isHome = $global:WinEdition -notmatch "Pro|Enterprise|Education|Business"
    if ($isHome) {
        Clear-Host
        Write-Host ""
        Draw-Box -Color White -Lines @(
            "  WINDOWS EDITION DETECTED                                          ",
            "---",
            "  Edition: $global:WinEditionFriendly                              ",
            "                                                                    ",
            "  Remote Desktop hosting is not available on Home Edition.          ",
            "  BitLocker uses Device Encryption on Home -- handled               ",
            "  automatically by this tool.                                       "
        )
        Write-Host ""
        Write-Log -Message "Home edition -- Remote Desktop and Group Policy unavailable" -Status "INFO"
        Pause-ForUser
    } else {
        Write-Host ""
        Write-Host "  OK  Windows Edition: $global:WinEditionFriendly" -ForegroundColor Green
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
            Draw-Box -Color White -Lines @(
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
# STATE / RESUME SYSTEM (UX-05, UX-06)
# Survives the offline-scan reboot. Ordered checkpoints -- when
# resuming, we skip everything at or before the saved checkpoint
# and jump straight back into the flow at the right spot.
# ============================================================
$global:CheckpointOrder = @(
    "Baseline",
    "PreScanPrep",
    "OfflineScanPending",
    "OfflineScanDone",
    "Malwarebytes",
    "DefenderAV",
    "PowerSettings",
    "AppsAudit"
)

function Save-Checkpoint {
    param([Parameter(Mandatory)][string]$Checkpoint)
    if (-not (Test-Path $StateDir)) { New-Item -Path $StateDir -ItemType Directory -Force | Out-Null }
    $Checkpoint | Out-File -FilePath $StateFilePath -Encoding UTF8 -Force
    Write-Log -Message "Checkpoint saved: $Checkpoint" -Status "STATE"
}

function Get-SavedCheckpoint {
    if (Test-Path $StateFilePath) {
        try { return (Get-Content -Path $StateFilePath -Raw -EA Stop).Trim() } catch { return $null }
    }
    return $null
}

function Clear-Checkpoint {
    if (Test-Path $StateFilePath) { Remove-Item -Path $StateFilePath -Force -EA SilentlyContinue }
}

function Test-CheckpointReached {
    # Returns $true if $global:ResumeFrom checkpoint is at or before $Checkpoint
    # in CheckpointOrder -- meaning this step should be SKIPPED because it was
    # already completed before the reboot.
    param([Parameter(Mandatory)][string]$Checkpoint)
    if (-not $global:ResumeFrom) { return $false }
    $resumeIdx = $global:CheckpointOrder.IndexOf($global:ResumeFrom)
    $checkIdx  = $global:CheckpointOrder.IndexOf($Checkpoint)
    if ($resumeIdx -lt 0 -or $checkIdx -lt 0) { return $false }
    return $checkIdx -le $resumeIdx
}

function Show-ResumePrompt {
    # Checks for a saved checkpoint at launch. If found, asks the user
    # whether to resume or start fresh. Sets $global:ResumeFrom accordingly.
    # FT-35 (2026-07-12): non-admin sessions exit at the intro anyway, but
    # this prompt ran BEFORE that gate -- so an accidental non-admin
    # double-click could START OVER and wipe a real checkpoint (happened in
    # the 2026-07-11 22:30 field log). Non-admin runs now skip this prompt
    # and leave the checkpoint untouched.
    if (-not $global:IsAdmin) { return }
    $saved = Get-SavedCheckpoint
    if ($saved -and ($saved -in $global:CheckpointOrder)) {
        Clear-Host
        Write-Host ""
        Draw-Box -Color White -Lines @(
            "  WELCOME BACK                                              ",
            "---",
            "  It looks like you've run GatewayGuard before and were      ",
            "  partway through -- possibly right before a restart for a  ",
            "  Defender Offline Scan.                                    ",
            "                                                            ",
            "  [R] Resume where you left off (recommended)              ",
            "  [S] Start over from the beginning                        "
        )
        Write-Host ""
        $choice = Read-ValidKey -ValidKeys @("R","S") -Prompt "Resume or start over? (R/S): "
        if ($choice.ToUpper() -eq "R") {
            $global:ResumeFrom = $saved
            Write-Log -Message "User chose to RESUME from checkpoint: $saved" -Status "STATE"
            # FT-08: resuming skips the original maximize/scroll instructions
            # entirely, so the reminder needs to happen here instead.
            Write-Host ""
            Write-Host "  Tip: press Windows+Up Arrow, or click the maximize box" -ForegroundColor Gray
            Write-Host "  (top-right corner), to make this window full-screen again." -ForegroundColor Gray
            Write-Host ""
            Pause-ForUser
        } else {
            $global:ResumeFrom = $null
            Clear-Checkpoint
            Write-Log -Message "User chose to START OVER -- checkpoint cleared" -Status "STATE"
        }
    } else {
        $global:ResumeFrom = $null
    }
}

# ============================================================
# RESUME QUICK RE-CHECK (FT-47, ascii28)
# ============================================================
function Show-ResumeReverify {
    # FT-47 (ascii28): resuming used to replay Test-PersonalComputer,
    # Test-AdminAccess, and Test-PowerStatus as full flashing screens
    # (every resume run in the 7/12 logs). Re-verifying is right; the
    # flash was not. One quiet screen now; full screens only on problems.
    Clear-Host
    Write-Host ""
    Draw-Box -Color White -Lines @(
        "  QUICK RE-CHECK BEFORE RESUMING                            ",
        "---",
        "  Because you're resuming, we re-verify the basics on this   ",
        "  ONE screen instead of replaying each earlier screen:       ",
        "  your personal-PC answer, Administrator access, and         ",
        "  power/battery state.                                       "
    )
    Write-Host ""
    $rc = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Still YOUR personal computer? (Y = Yes / N = Exit): "
    if ($rc.ToUpper() -eq "N") {
        Write-Host ""
        Write-Host "  Exiting. No changes made." -ForegroundColor Yellow
        Write-Log -Message "Resume re-check: user said not personal PC -- exit" -Status "EXIT"
        Disable-SleepPrevention
        Save-Log
        exit
    }
    Write-Host "  Confirmed -- re-checking this PC..." -ForegroundColor Green
    Write-Log -Message "Resume re-check: personal computer reconfirmed" -Status "CONFIRM"
    Test-DomainJoin   # stays silent unless a domain problem is found
    if ($global:IsAdmin) {
        Write-Host "  OK  Administrator access confirmed." -ForegroundColor Green
        Write-Log -Message "Resume re-check: administrator access confirmed" -Status "OK"
    } else {
        Test-AdminAccess   # a real problem -- worth the full screen
    }
    # Power/battery -- quiet unless on battery (that warning matters)
    try {
        $rvBatt = Get-WmiObject -Class Win32_Battery -ErrorAction SilentlyContinue
        $global:HasBattery = ($null -ne $rvBatt)
        $global:OnBattery  = ($global:HasBattery -and $rvBatt.BatteryStatus -eq 1)
        $global:BatteryPct = if ($global:HasBattery -and $rvBatt.EstimatedChargeRemaining) { "$($rvBatt.EstimatedChargeRemaining)%" } else { "N/A" }
    } catch { $global:OnBattery = $false; $global:HasBattery = $false; $global:BatteryPct = "Unknown" }
    Enable-SleepPrevention
    if ($global:OnBattery) {
        Test-PowerStatus   # full battery warning screen -- worth showing
    } else {
        Write-Host "  OK  AC power confirmed (battery: $($global:BatteryPct)). Sleep prevention active." -ForegroundColor Green
        Write-Log -Message "Resume re-check: AC power confirmed ($($global:BatteryPct)). Sleep prevention active." -Status "OK"
    }
    Write-Host ""
    Pause-ForUser "  All re-checked. Press Enter or Space to continue where you left off..."
}

# ============================================================
# SCROLL & COPY TIP (FT-41/FT-45/FT-63, ascii28)
# ============================================================
function Show-ScrollCopyTip {
    # QuickEdit is OFF on purpose (FT-01 walk-away fix) -- which also turns
    # off mouse highlighting and right-click copy. Mark mode is the
    # sanctioned method, and it PAUSES the program while active -- that must
    # be taught, or it reads as a hang (FT-63: the 84-minute frozen launch).
    Clear-Host
    Write-Host ""
    Draw-Box -Color White -Lines @(
        "  HOW TO SCROLL BACK (AND COPY) IN THIS WINDOW              ",
        "---",
        "  Mouse highlighting and right-click copy are switched OFF   ",
        "  in this window ON PURPOSE -- a stray click used to freeze  ",
        "  the program mid-run. Here is the safe way instead:         ",
        "                                                             ",
        "  TO SCROLL BACK AND RE-READ EARLIER TEXT:                   ",
        "  1. Press Alt + Spacebar (a small menu opens, top-left)     ",
        "  2. Press E, then M                                         ",
        "  3. Up/Down arrows and Page Up/Page Down now scroll         ",
        "  4. Press Esc when you are done                             ",
        "                                                             ",
        "  IMPORTANT: while you are scrolling this way, the program   ",
        "  PAUSES and waits for you. It is not stuck -- press Esc     ",
        "  and it carries on exactly where it was. (Ctrl+Arrow        ",
        "  scrolling does NOT work in this window -- use the steps    ",
        "  above.)                                                    ",
        "                                                             ",
        "  AND RELAX: everything on every screen is also saved into   ",
        "  your log file automatically -- you never NEED to copy      ",
        "  anything off the screen by hand.                           "
    )
    Write-Host ""
    Pause-ForUser
}

# ============================================================
# TIME & DATE SYNC CHECK (UX-08)
# ============================================================
function Test-TimeDateSync {
    Write-Host ""
    Write-Host "  Checking your computer's time and date settings..." -ForegroundColor Cyan

    try {
        $tzAuto = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\tzautoupdate" -Name "Start" -EA SilentlyContinue).Start
        $w32Time = Get-Service -Name "W32Time" -EA SilentlyContinue
        $timeAutoOK = ($w32Time -and $w32Time.StartType -ne "Disabled")
        $tzAutoOK   = ($tzAuto -ne 4)   # 4 = disabled, 3 = automatic

        if (-not $timeAutoOK -or -not $tzAutoOK) {
            Write-Host ""
            Draw-Box -Color White -Lines @(
                "  !  TIME/DATE SYNC ISSUE DETECTED                          ",
                "---",
                "  Your computer's automatic time or time zone setting is    ",
                "  turned off. This can affect Windows Update, security      ",
                "  certificates, and scheduled scans.                        ",
                "                                                            ",
                "  GatewayGuard will turn these back on now.                 "
            )
            try {
                Set-Service -Name "W32Time" -StartupType Automatic -EA SilentlyContinue
                Start-Service -Name "W32Time" -EA SilentlyContinue
                w32tm /resync /force | Out-Null
                Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\tzautoupdate" -Name "Start" -Value 3 -EA SilentlyContinue
                Write-Host "  Time sync settings corrected." -ForegroundColor Green
                Write-Log -Message "Time/timezone auto-sync corrected" -Status "FIXED"
            } catch {
                Write-Host "  Could not correct automatically -- see Settings > Time & Language." -ForegroundColor Yellow
                Write-Log -Message "Time/timezone auto-fix failed: $_" -Status "WARN"
            }
        }

        $currentTime = Get-Date -Format "dddd, MMMM d, yyyy -- h:mm tt"
        $currentTZ   = (Get-TimeZone).DisplayName
        Write-Host ""
        Write-Host "  Detected time: $currentTime" -ForegroundColor White
        Write-Host "  Time zone:     $currentTZ" -ForegroundColor White
        Write-Host ""
        $confirm = Read-ValidKey -ValidKeys @("Y","N") -Prompt "  Does this look correct? (Y/N): "

        if ($confirm.ToUpper() -eq "N") {
            # FIX (2026-07-10): previously this just told the user to go fix
            # it manually with no actual help. Now offers to open Windows'
            # own Date & Time settings panel -- a real GUI, already trusted,
            # already handles time zone and DST correctly. Applies to BOTH
            # Console and GUI mode since this function runs once centrally
            # before mode selection.
            Write-Log -Message "User flagged time/date as INCORRECT after auto-fix attempt" -Status "WARN"
            # FT-21 (2026-07-11): after answering N, the follow-up question was
            # easy to miss ("it blinked and just sat there") -- now boxed.
            Write-Host ""
            Draw-Box -Color Yellow -Lines @(
                "  FIX THE TIME NOW?                                         ",
                "---",
                "  GatewayGuard can open Windows' own Date & Time settings   ",
                "  so you can correct it, then come right back here.         "
            )
            Write-Host ""
            $openSettings = Read-ValidKey -ValidKeys @("Y","N") -Prompt "  Open Date & Time settings now? (Y = Open / N = Skip): "

            if ($openSettings.ToUpper() -eq "Y") {
                Start-Process "ms-settings:dateandtime"
                Write-Host ""
                Write-Host "  Windows Settings should now be open. Make your correction," -ForegroundColor White
                Write-Host "  then come back here." -ForegroundColor White
                Pause-ForUser "  Press Enter or Space once you've corrected the time..."

                # Re-check after giving them a chance to fix it
                $recheckTime = Get-Date -Format "dddd, MMMM d, yyyy -- h:mm tt"
                $recheckTZ   = (Get-TimeZone).DisplayName
                Write-Host ""
                Write-Host "  Time now shows: $recheckTime" -ForegroundColor White
                Write-Host "  Time zone:      $recheckTZ" -ForegroundColor White
                Write-Host ""
                # FT-28 (2026-07-11): the "(UTC-05:00)" in the zone name is the
                # zone's WINTER offset label -- it never changes, even in summer
                # when clocks are one hour ahead. Field-confirmed confusion.
                Write-Host "  NOTE: The '(UTC-05:00)' part is just the zone's winter label --" -ForegroundColor Gray
                Write-Host "  it stays the same all year. In summer, Windows automatically" -ForegroundColor Gray
                Write-Host "  runs one hour ahead. If the day, date, and time above are" -ForegroundColor Gray
                Write-Host "  right, everything is correct." -ForegroundColor Gray
                Write-Host ""
                $reconfirm = Read-ValidKey -ValidKeys @("Y","N") -Prompt "  Does this look correct now? (Y/N): "
                if ($reconfirm.ToUpper() -eq "Y") {
                    Write-Log -Message "Time/date corrected by user via Settings panel: $recheckTime $recheckTZ" -Status "FIXED"
                    Write-Host "  Great -- time and date look correct now." -ForegroundColor Green
                } else {
                    Write-Log -Message "Time/date still flagged incorrect after Settings panel -- continuing anyway" -Status "WARN"
                    Write-Host "  Continuing anyway -- you can fix this anytime in Settings > Time & Language." -ForegroundColor Yellow
                }
            } else {
                Write-Host "  Continuing without correcting -- you can fix this anytime in Settings > Time & Language." -ForegroundColor Gray
                Write-Log -Message "User declined to open Date & Time settings" -Status "SKIP"
            }
        } else {
            Write-Log -Message "Time/date confirmed correct by user: $currentTime $currentTZ" -Status "OK"
        }
    } catch {
        Write-Host "  Could not verify time/date settings -- continuing." -ForegroundColor Yellow
        Write-Log -Message "Time/date check error: $_" -Status "WARN"
    }
}

# ============================================================
# SYSTEM BASELINE SUMMARY (UX-10)
# Shown once, up front, before any security checks. Builds trust
# that GatewayGuard knows what machine it's working on, and
# captures baseline state for troubleshooting.
# Reference: GatewayGuard_SystemBaseline_Diagnostic.ps1
# ============================================================
function Show-SystemBaselineSummary {
    Clear-Host
    Write-Host ""
    Write-Host "  Gathering system information..." -ForegroundColor Cyan
    Write-Host ""

    $lines = @("  YOUR SYSTEM AT A GLANCE                                   ", "---")

    try {
        $cs = Get-CimInstance -ClassName Win32_ComputerSystem -EA SilentlyContinue
        $lines += "  Make/Model:   $($cs.Manufacturer) $($cs.Model)"
    } catch { $lines += "  Make/Model:   Could not detect" }

    $lines += "  Windows:      $global:WinEdition"
    $lines += "  RAM:          $($global:RAMGB) GB"

    try {
        $cpu = Get-CimInstance -ClassName Win32_Processor -EA SilentlyContinue | Select-Object -First 1
        $lines += "  Processor:    $($cpu.Name)"
    } catch { $lines += "  Processor:    Could not detect" }

    try {
        $disk = Get-CimInstance -ClassName Win32_DiskDrive -EA SilentlyContinue | Select-Object -First 1
        $sizeGB = [math]::Round($disk.Size / 1GB, 0)
        $lines += "  Storage:      $sizeGB GB ($($disk.MediaType))"
    } catch { $lines += "  Storage:      Could not detect" }

    try {
        $batt = Get-CimInstance -ClassName Win32_Battery -EA SilentlyContinue
        if ($batt) {
            $lines += "  Battery:      $($batt.EstimatedChargeRemaining)% charged"
            if ($batt.EstimatedChargeRemaining -lt 50 -and -not $global:OnBattery) {
                $lines += "                (Consider plugging in before scans/BitLocker)"
            }
        } else {
            $lines += "  Battery:      Desktop (no battery detected)"
        }
    } catch { $lines += "  Battery:      Could not detect" }

    try {
        $av = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
        $avNames = ($av | Select-Object -ExpandProperty displayName) -join ", "
        $lines += "  Antivirus:    $(if ($avNames) { $avNames } else { 'None registered' })"
    } catch { $lines += "  Antivirus:    Could not detect" }

    try {
        $wu = Get-Service -Name "wuauserv" -EA SilentlyContinue
        $lines += "  Windows Update service: $($wu.Status)"
    } catch { $lines += "  Windows Update service: Could not detect" }

    try {
        $bl = Get-BitLockerVolume -MountPoint "C:" -EA SilentlyContinue
        $blStatus = if ($bl) { $bl.ProtectionStatus } else { "Not available (Home edition uses Device Encryption instead)" }
        $lines += "  BitLocker/Encryption: $blStatus"
    } catch { $lines += "  BitLocker/Encryption: Could not detect" }

    Draw-Box -Color White -Lines $lines
    Write-Host ""
    Write-Log -Message "System Baseline Summary displayed" -Status "INFO"
    Pause-ForUser "  Press Enter or Space to continue..."
}

# ============================================================
# STEP 7: PRE-SCAN GATE
# ============================================================
function Show-PreScanGate {
    # If resuming right after an offline-scan reboot, skip straight to
    # post-scan guidance (UX-07) instead of showing the whole gate again.
    if ($global:ResumeFrom -eq "OfflineScanPending") {
        Show-PostScanGuidance
        return
    }

    Clear-Host
    Write-Host ""

    if ($global:IsFirstRun) {
        # Pre-scan prep checklist (UX-11)
        Draw-Box -Color White -Lines @(
            "  BEFORE WE SCAN YOUR PC                                     ",
            "---",
            "  Before applying any security settings, your PC must be     ",
            "  confirmed CLEAN of malware and viruses. Applying hardening ",
            "  settings on an infected PC can hide malware and make it    ",
            "  HARDER to detect later.                                    ",
            "                                                             ",
            "  Before we begin scanning, please:                         ",
            "  1. Close all open programs and browser windows            ",
            "  2. Plug in your power adapter if you are on a laptop      ",
            "  3. Do not use the computer while scanning                 ",
            "  4. Do not turn off or restart the computer during the scan",
            "                                                             ",
            "  Already scanned this PC recently? Press S to skip the      ",
            "  scanning step. Only skip if scans came back clean.         "
        )
        Write-Host ""
        # FT-20 (2026-07-11): visible S = Skip, for repeat runs / testing
        do {
            $ready = Read-ValidKey -ValidKeys @("Y","N","S") -Prompt "Ready to continue? (Y = Yes / N = Exit to prepare / S = Skip scans): "
            if ($ready.ToUpper() -eq "N") {
                Write-Host "  Take your time. Relaunch GatewayGuard when you're ready." -ForegroundColor Yellow
                Write-Log -Message "User exited at pre-scan prep checklist" -Status "EXIT"
                Disable-SleepPrevention; Save-Log; exit
            }
            if ($ready.ToUpper() -eq "S") {
                Write-Host ""
                Write-Host "  Skipping the scanning step. Only do this if this PC was" -ForegroundColor Yellow
                Write-Host "  already scanned recently and came back clean." -ForegroundColor Yellow
                Write-Log -Message "Scan gate SKIPPED by user (S key)" -Status "WARN"
                Pause-ForUser
                return
            }
        } while ($ready.ToUpper() -ne "Y")

        # Automated offline scan confirmation (UX-04, UX-09)
        Clear-Host
        Write-Host ""
        Draw-Box -Color White -Lines @(
            "  DEFENDER OFFLINE SCAN                                      ",
            "---",
            "  GatewayGuard can start a Windows Defender Offline Scan     ",
            "  for you now. This scan runs BEFORE Windows loads, so it    ",
            "  catches rootkits and malware that hide during normal use.  ",
            "                                                             ",
            "  IMPORTANT -- WHAT WILL HAPPEN:                            ",
            "  * Your computer will restart automatically                ",
            "  * This GatewayGuard window will close during the restart  ",
            "  * A blue scan screen will run for 10-20 minutes            ",
            "  * Your computer will then restart again to the desktop    ",
            "  * When you're back at the desktop, run GatewayGuard again ",
            "    -- it will automatically pick up right where you left   ",
            "    off. You do NOT need to start over.                     ",
            "                                                             ",
            "  Scan time varies by computer. A fast scan on a clean       ",
            "  machine is normal. A slower scan just means more files to  ",
            "  check -- that's normal too. Please be patient.             "
        )
        Write-Host ""
        $scanConfirm = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Start the offline scan now? (Y/N): "

        if ($scanConfirm.ToUpper() -eq "Y") {
            Save-Checkpoint -Checkpoint "OfflineScanPending"
            Write-Log -Message "Starting Defender Offline Scan -- reboot expected" -Status "INFO"
            Write-Host ""
            Write-Host "  Starting the offline scan. Your computer will restart" -ForegroundColor Green
            Write-Host "  in a few seconds. See you on the other side!" -ForegroundColor Green
            Start-Sleep -Seconds 5
            Disable-SleepPrevention
            Start-MpWDOScan
            # Script effectively ends here -- the reboot takes over.
            exit
        } else {
            Write-Host ""
            Write-Host "  Offline scan skipped. You can run this from GatewayGuard" -ForegroundColor Gray
            Write-Host "  anytime, or manually via Windows Security > Virus & threat" -ForegroundColor Gray
            Write-Host "  protection > Scan options." -ForegroundColor Gray
            Write-Log -Message "User skipped Defender Offline Scan" -Status "SKIP"
            Pause-ForUser "  Press Enter or Space to continue..."
        }

    } else {
        Draw-Box -Color White -Lines @(
            "  REMINDER: PRE-SCAN RECOMMENDED                             ",
            "---",
            "  This is a repeat run of the hardening tool.                ",
            "  For ongoing protection, run monthly:                       ",
            "  * Malwarebytes scan (GatewayGuard can launch this for you) ",
            "  * Defender Offline Scan quarterly or if issues arise       ",
            "  Guide: Phase 5 -- Scheduled Scanning                       "
        )
        Write-Host ""
        do {
            $cont = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue with hardening tool? (Y = Continue / N = Exit): "
            if ($cont.ToUpper() -eq "N") { Save-Log; exit }
        } while ($cont.ToUpper() -ne "Y")
        Write-Log -Message "Repeat run -- user confirmed to continue" -Status "CONFIRM"
    }
}

# ============================================================
# POST-SCAN GUIDANCE (UX-07)
# Runs when resuming right after the offline-scan reboot.
# ============================================================
function Show-PostScanGuidance {
    Clear-Host
    Write-Host ""
    Draw-Box -Color White -Lines @(
        "  WELCOME BACK -- OFFLINE SCAN COMPLETE                     ",
        "---",
        "  Your Defender Offline Scan has finished. Here's how to     ",
        "  see the results:                                          ",
        "                                                             ",
        "  1. We'll open Windows Security to Protection History now   ",
        "  2. Look for any items listed under Recent Actions          ",
        "                                                             ",
        "  WHAT TO LOOK FOR:                                          ",
        "  * 'Quarantined' or 'Removed' -- good news, Defender         ",
        "    already handled it. No action needed.                   ",
        "  * 'Allowed' -- Defender saw something suspicious but        ",
        "    didn't block it. If you don't recognize it, we'll run    ",
        "    Malwarebytes next as a second opinion.                  ",
        "  * 'No Recent Actions' -- your scan came back clean.        "
    )
    Write-Host ""
    Pause-ForUser "  Press Enter or Space to open Protection History..."
    Start-Process "windowsdefender://protectionhistory"
    Start-Sleep -Seconds 2

    Write-Host ""
    do {
        $result = Read-ValidKey -ValidKeys @("Y","N") -Prompt "  Did you find any items needing action? (Y/N): "
    } while ($result.ToUpper() -notin @("Y","N"))

    if ($result.ToUpper() -eq "Y") {
        Write-Host ""
        Write-Host "  Write down the threat name shown in Protection History." -ForegroundColor Yellow
        Write-Host "  We'll continue with Malwarebytes next as a second opinion." -ForegroundColor Yellow
        Write-Log -Message "Post-scan: user found items needing action in Protection History" -Status "WARN"
    } else {
        Write-Log -Message "Post-scan: Protection History clean or already handled" -Status "OK"
    }
    Pause-ForUser "  Press Enter or Space to continue..."
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
            Draw-Box -Color White -Lines @(
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
                $cont = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue anyway? (Y = Continue / N = Exit to uninstall first): "
                if ($cont.ToUpper() -eq "N") {
                    Write-Host ""
                    Write-Host "  Uninstall $riskyName, then relaunch this tool." -ForegroundColor Yellow
                    Disable-SleepPrevention; Save-Log; exit
                }
            } while ($cont.ToUpper() -ne "Y")
            Pause-ForUser
        }

        if ($mbFree) {
            # Check if MB took over real-time -- use Get-MpComputerStatus (reliable)
            # NOT productState 0x1000 bit -- MB Free also sets that bit (confirmed HP 17-by1xxx)
            $defRT = $false
            try { $defRT = (Get-MpComputerStatus -EA Stop).RealTimeProtectionEnabled } catch {}
            if (-not $defRT -and -not $defender) {
                Clear-Host
                Write-Host ""
                # FT-12 (2026-07-10): reframed from "this needs to be fixed"
                # to "this is expected and fine" -- a Malwarebytes trial
                # temporarily taking over real-time protection is a normal,
                # temporary state, not a problem. Defender resumes control
                # automatically once the trial ends or is deactivated.
                Draw-Box -Color White -Lines @(
                    "  MALWAREBYTES TRIAL IS CURRENTLY HANDLING PROTECTION      ",
                    "---",
                    "  Malwarebytes started a Premium trial and is temporarily   ",
                    "  handling real-time protection instead of Defender.       ",
                    "  THIS IS NORMAL AND OK -- not a problem to fix right now.  ",
                    "                                                            ",
                    "  Windows only allows ONE app to handle real-time           ",
                    "  protection at a time. Microsoft Defender will              ",
                    "  automatically become active again once the Malwarebytes  ",
                    "  trial ends (or if you deactivate it early).              ",
                    "                                                            ",
                    "  IN THE MEANTIME: you can still run daily Malwarebytes    ",
                    "  scans manually for protection.                           ",
                    "                                                            ",
                    "  If you'd like Defender back sooner (optional):           ",
                    "  Open Malwarebytes -> Settings (gear) -> Account ->        ",
                    "  Deactivate Premium Trial                                  ",
                    "                                                            ",
                    "  Tamper Protection is a SEPARATE setting from real-time    ",
                    "  protection -- worth checking it's still ON in Windows     ",
                    "  Security regardless of which AV is currently active.      ",
                    "  Guide: Phase 3, Step 4                                   "
                )
                Write-Host ""
                do {
                    $cont = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue? (Y = Continue / N = I'll deactivate the trial first): "
                    if ($cont.ToUpper() -eq "N") {
                        Write-Host "  Take your time -- relaunch this tool once you're ready." -ForegroundColor Yellow
                        Write-Log -Message "Exited -- user chose to deactivate MB trial first" -Status "INFO"
                        Disable-SleepPrevention; Save-Log; exit
                    }
                } while ($cont.ToUpper() -ne "Y")
                Write-Log -Message "Continuing -- Malwarebytes trial active as primary AV (expected, not an error)" -Status "OK"
                Pause-ForUser
                return
            }
        }

        # Check actual Defender real-time state directly -- most reliable source of truth
        # FT-23 (2026-07-11): a FAILED check used to default to "off" and fire
        # the scary DEFENDER IS OFF alarm even when Defender was fine
        # (field-confirmed false alarm right after the Malwarebytes check).
        # Unknown is now tracked separately and gets a calm message instead.
        $defenderRTUnknown = $false
        try {
            $mpStatus = Get-MpComputerStatus -EA Stop
            $defenderRTOn = $mpStatus.RealTimeProtectionEnabled
        } catch {
            $defenderRTOn = $false
            $defenderRTUnknown = $true
            Write-Log -Message "Get-MpComputerStatus failed -- Defender state UNKNOWN, not assuming OFF: $_" -Status "WARN"
        }

        # Determine if MB Free is the only non-Defender AV (companion scenario -- OK)
        $nonMbNonDefender = $nonDefender | Where-Object { $_.displayName -notmatch "Malwarebytes" }

        if ($defenderRTOn) {
            # Defender real-time IS on -- this is the healthy state
            if ($mbFree) {
                # MB registered in SC2 but Defender RT is on -- MB is companion only
                Clear-Host
                Write-Host ""
                Draw-Box -Color White -Lines @(
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
            Draw-Box -Color White -Lines @(
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
                $cont = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue anyway? (Y = Continue / N = Fix first then re-run): "
                if ($cont.ToUpper() -eq "N") {
                    Write-Host "  Fix Defender status and relaunch the tool." -ForegroundColor Yellow
                    Write-Log -Message "Exited -- non-Defender AV active: $avName" -Status "WARN"
                    Disable-SleepPrevention; Save-Log; exit
                }
            } while ($cont.ToUpper() -ne "Y")
            Write-Log -Message "Continuing with non-Defender AV active: $avName" -Status "WARN"
            Pause-ForUser
        } elseif ($defenderRTUnknown) {
            # FT-23: could not VERIFY Defender -- do not alarm, do not block
            Write-Host ""
            Write-Host "  Could not verify Defender's status just now -- this is usually" -ForegroundColor Yellow
            Write-Host "  temporary. To check yourself: open Windows Security and look" -ForegroundColor Yellow
            Write-Host "  under Virus & threat protection." -ForegroundColor Yellow
            Write-Log -Message "Defender state unverifiable -- informational message shown, continuing" -Status "WARN"
            Pause-ForUser
        } elseif ($nonDefender | Where-Object { $_.displayName -match "Malwarebytes" }) {
            # FT-30 (2026-07-12): Defender RT is off but MALWAREBYTES is
            # registered in Security Center -- MB has taken over real-time
            # protection (normal during a Premium trial). Round-4 field test
            # showed the scary alarm firing here because the MB state check
            # missed the trial. This is a handoff, not an emergency.
            Write-Log -Message ("FT-30 context: mbState=" + (Get-MalwarebytesState) + " SC2=[" + (($nonDefender | ForEach-Object { $_.displayName }) -join "; ") + "]") -Status "INFO"
            Clear-Host
            Write-Host ""
            Draw-Box -Color White -Lines @(
                "  ANTIVIRUS STATUS -- MALWAREBYTES IS ON DUTY               ",
                "---",
                "  Malwarebytes is currently providing your real-time         ",
                "  protection, so Windows Defender's real-time shield is       ",
                "  standing down. This is NORMAL -- Windows only allows one    ",
                "  real-time antivirus at a time, and your PC IS protected.    ",
                "                                                              ",
                "  When the Malwarebytes trial ends, Defender takes over       ",
                "  again automatically. Two things to check at that point:     ",
                "  1. Defender real-time protection is back ON                 ",
                "  2. Tamper Protection is ON (the trial can leave it off)     ",
                "  Both live in Windows Security -> Virus & threat protection. "
            )
            Write-Host ""
            Write-Log -Message "Defender RT off, Malwarebytes registered in SC2 -- handoff explanation shown (no alarm)" -Status "OK"
            Pause-ForUser
        } else {
            # Defender real-time is CONFIRMED off and NOTHING registered to replace it
            Write-Log -Message ("Defender-off ALARM context: mbState=" + (Get-MalwarebytesState) + " SC2 count=" + (@($nonDefender).Count)) -Status "WARN"
            Clear-Host
            Write-Host ""
            Draw-Box -Color White -Lines @(
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
                $cont = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue anyway? (Y = Continue / N = Fix Defender first): "
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
# MALWAREBYTES DETECT-AND-LAUNCH FOLLOW-UP (UX-06, OBS-01)
# Replaces ascii22's manual-only Malwarebytes instructions.
# Note: Malwarebytes has no officially documented cmdlet to trigger
# a scan (unlike Defender's Start-MpWDOScan) -- this launches the
# app to the scan screen; the user still clicks "Scan" themselves.
# ============================================================
function Show-MalwarebytesFollowUp {
    Clear-Host
    Write-Host ""
    Write-Host "  Checking for Malwarebytes..." -ForegroundColor Cyan
    Write-Host ""

    $mbState = Get-MalwarebytesState

    if ($mbState -eq "NotInstalled") {
        Draw-Box -Color White -Lines @(
            "  MALWAREBYTES NOT DETECTED                                 ",
            "---",
            "  Malwarebytes Free is a companion scanner that catches      ",
            "  PUPs and adware Defender sometimes misses. It's optional   ",
            "  but recommended -- takes about 5-10 minutes.               "
        )
        Write-Host ""
        $getMb = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Open the Malwarebytes download page now? (Y/N): "
        if ($getMb.ToUpper() -eq "Y") {
            Start-Process $AffiliateMalwarebytes
            Write-Host ""
            Write-Host "  A PERMISSIONS BOX MAY APPEAR during install -- please respond" -ForegroundColor Yellow
            Write-Host "  to it promptly. It will disappear after a few minutes if left" -ForegroundColor Yellow
            Write-Host "  unanswered. If that happens, search 'Malwarebytes' in the" -ForegroundColor Yellow
            Write-Host "  Windows search bar to bring the box back." -ForegroundColor Yellow
            Write-Log -Message "User opened Malwarebytes download page" -Status "INFO"
            Write-Host ""
            Write-Host "  Once it's installed, come back and run GatewayGuard again" -ForegroundColor White
            Write-Host "  to continue with a scan." -ForegroundColor White
        } else {
            Write-Log -Message "User skipped Malwarebytes install" -Status "SKIP"
        }
        Pause-ForUser "  Press Enter or Space to continue..."

    } else {
        # Already installed (FreeCompanion, TrialActive, or Unknown-but-present)
        Draw-Box -Color White -Lines @(
            "  MALWAREBYTES DETECTED ON THIS PC                          ",
            "---",
            "  GatewayGuard can open Malwarebytes now. We recommend the   ",
            "  DEEP scan -- in our own testing it found problems the      ",
            "  quick scan had already called clean.                       ",
            "                                                             ",
            "  HOW TO RUN IT (once Malwarebytes opens):                   ",
            "  1. First, turn ON rootkit checking: click the Settings     ",
            "     gear (top right), choose Security, and switch ON        ",
            "     'Scan for rootkits' -- it stays off unless you set it.  ",
            "  2. Go back to the main screen and click Scan.              ",
            "  3. Let it finish -- 30 minutes to a few hours is normal.   "
        )
        Write-Host ""
        $runMb = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Open Malwarebytes now? (Y/N): "
        if ($runMb.ToUpper() -eq "Y") {
            Write-Host ""
            Write-Host "  A PERMISSIONS BOX MAY APPEAR -- please respond promptly." -ForegroundColor Yellow
            Write-Host "  It will disappear after a few minutes if left unanswered." -ForegroundColor Yellow
            Write-Host "  If that happens, search 'Malwarebytes' in the Windows" -ForegroundColor Yellow
            Write-Host "  search bar to bring it back." -ForegroundColor Yellow
            Write-Host ""

            $mbPaths = @(
                "$env:ProgramFiles\Malwarebytes\Anti-Malware\mbam.exe",
                "${env:ProgramFiles(x86)}\Malwarebytes\Anti-Malware\mbam.exe"
            )
            $mbExe = $mbPaths | Where-Object { Test-Path $_ } | Select-Object -First 1

            if ($mbExe) {
                # FT-22 (2026-07-11): this tool runs elevated, and a program
                # started from an elevated process INHERITS Administrator --
                # so Malwarebytes launched here is already running as admin.
                Start-Process $mbExe
                Write-Host "  Malwarebytes should now be open (with Administrator rights," -ForegroundColor Green
                Write-Host "  inherited from this tool). Click 'Scan' to check for threats." -ForegroundColor Green
                Write-Log -Message "Launched Malwarebytes at $mbExe (elevated, inherited from tool)" -Status "INFO"
                Write-Host ""
                Write-Host "  The scan may take 5-45 minutes depending on your computer." -ForegroundColor Gray
                Write-Host "  A fast scan on a clean machine is normal." -ForegroundColor Gray

                # FT-11: Malwarebytes trial-specific guidance -- the upgrade
                # nag box and Deep Scan availability are both trial-only
                # behaviors that need explaining, or users may be tempted to
                # pay for an upgrade they don't need, or miss the deeper
                # scan option entirely once the trial ends.
                if ($mbState -eq "TrialActive") {
                    Write-Host ""
                    Draw-Box -Color White -Lines @(
                        "  MALWAREBYTES TRIAL -- WHAT TO EXPECT                     ",
                        "---",
                        "  You may see a box asking you to upgrade to Premium.       ",
                        "  You do NOT need to upgrade -- just click the X to close   ",
                        "  that box. Windows Defender (already explained earlier)    ",
                        "  is your primary protection either way.                    ",
                        "                                                            ",
                        "  The DEEPER scan works during the trial AND on the free    ",
                        "  version after the trial ends -- confirmed on our own test  ",
                        "  machines. To use it: click Scan options, then choose Deep  ",
                        "  Scan or a Custom Scan with all drives checked.             ",
                        "                                                            ",
                        "  AFTER THE TRIAL ENDS: open Windows Security and check      ",
                        "  that Tamper Protection is back ON -- the trial handoff     ",
                        "  can leave it off.                                          "
                    )
                    Write-Log -Message "Malwarebytes trial detected -- showed upgrade-nag and Deep Scan guidance" -Status "INFO"
                }

                # FT-11 extension (2026-07-11, field evidence): on a test PC
                # already scanned CLEAN by Defender and a Malwarebytes quick
                # scan, a deeper scan later found 6 more detections. The quick
                # scan is a start -- the deep scan is the real answer.
                Write-Host ""
                Draw-Box -Color White -Lines @(
                    "  GO DEEPER -- RUN THE BIG SCAN OVERNIGHT (RECOMMENDED)     ",
                    "---",
                    "  The quick scan is a good start, but it does not check      ",
                    "  everything. In our own testing, a deeper scan found        ",
                    "  several problems on a computer the quick scans had         ",
                    "  already called clean.                                      ",
                    "                                                             ",
                    "  TONIGHT, BEFORE BED:                                       ",
                    "  1. Open Malwarebytes and click Scan options (or the        ",
                    "     arrow next to Scan)                                     ",
                    "  2. Choose the deepest option shown -- Deep Scan, or a      ",
                    "     Custom Scan with ALL your drives checked                ",
                    "  3. Plug the computer in to power                           ",
                    "  4. Stop Windows from sleeping mid-scan: open Settings >    ",
                    "     System > Power & battery > Screen and sleep, and set    ",
                    "     'Sleep' to Never. (Set it back to normal tomorrow.)     ",
                    "  5. Start the scan and go to bed -- check results in the    ",
                    "     morning                                                 "
                )
                Write-Log -Message "Overnight deep-scan recommendation shown (FT-11 ext)" -Status "INFO"
            } else {
                # FT-22 (2026-07-11): manual-launch fallback now includes the
                # right-click step so it still runs as Administrator.
                Write-Host "  Malwarebytes is installed but wasn't found at the usual" -ForegroundColor Yellow
                Write-Host "  location. To open it with full rights:" -ForegroundColor Yellow
                Write-Host "  1. Click Start and type: Malwarebytes" -ForegroundColor White
                Write-Host "  2. Click it ONCE to select it, then RIGHT-CLICK it" -ForegroundColor White
                Write-Host "  3. Choose 'Run as administrator'" -ForegroundColor White
                Write-Log -Message "Malwarebytes detected but executable not found at expected paths -- manual run-as-admin steps shown" -Status "WARN"
            }
        } else {
            Write-Log -Message "User skipped Malwarebytes scan (already installed, state: $mbState)" -Status "SKIP"
        }
        Pause-ForUser "  Press Enter or Space to continue..."
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
        $global:HasBattery = $hasBattery   # Store globally for power settings screen
        $global:OnBattery = ($hasBattery -and $battery.BatteryStatus -eq 1)
        $batteryPct = if ($hasBattery -and $battery.EstimatedChargeRemaining) { "$($battery.EstimatedChargeRemaining)%" } else { "N/A" }
        $global:BatteryPct = $batteryPct   # Store globally for power settings screen
    } catch {
        $global:OnBattery = $false
        $batteryPct = "Unknown"
        $hasBattery = $false
    }

    Enable-SleepPrevention

    if ($global:OnBattery) {
        Write-Host ""
        Draw-Box -Color White -Lines @(
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
            $cont = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue on battery? (Y = Continue / N = Plug in and relaunch): "
            if ($cont.ToUpper() -eq "N") {
                Write-Host ""
                Write-Host "  Plug in AC power and relaunch the tool." -ForegroundColor Yellow
                Disable-SleepPrevention; Save-Log; exit
            }
        } while ($cont.ToUpper() -ne "Y")
    } else {
        Write-Host ""
        if ($hasBattery) {
            Write-Host "  OK  Plugged into AC power." -ForegroundColor Green
            Write-Host "      Battery: $batteryPct charged and plugged in" -ForegroundColor White
            Write-Host "      Safe to run all settings including BitLocker." -ForegroundColor White
        } else {
            Write-Host "  OK  AC power -- desktop PC (no battery detected)." -ForegroundColor Green
        }
        Write-Host "  OK  Sleep prevention: SET BY THIS TOOL for this session." -ForegroundColor Green
        Write-Host "      Your original sleep setting will be restored automatically when GatewayGuard exits." -ForegroundColor White
        Write-Log -Message "AC power confirmed. Battery present: $hasBattery ($batteryPct). Sleep prevention active." -Status "OK"
        Pause-ForUser "  Press Enter or Space to continue..."
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
        $acVal = if ($pw -match "Current AC Power Setting Index: 0x(\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { $null }
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

    # 4. Screen timeout (READ ONLY -- this tool does not change screen timeout)
    # FT-61 (ascii28): both powercfg reads failed on the Dell and the FT-36
    # diagnostic never fired -- the parse could THROW before reaching the
    # logging line (hex-to-Int32 conversion: the 0x80000003 lesson again),
    # and 2>$null hid powercfg's own error text. Fix: capture stderr via
    # 2>&1, convert hex UNSIGNED, treat 0xFFFFFFFF as Never, and log raw
    # output BEFORE anything that can throw.
    try {
        $st = cmd /c "powercfg /query SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 2>&1"
        if (($st | Out-String) -match "Current AC Power Setting Index: 0x([0-9A-Fa-f]+)") {
            $acTimeout = [Convert]::ToUInt32($Matches[1], 16)
            if ($acTimeout -eq [uint32]4294967295) { $acTimeout = [uint32]0 }   # 0xFFFFFFFF = Never
        } else {
            $stRaw = (($st | Select-Object -First 4) -join " | ")
            Write-Log -Message "FT-61 powercfg VIDEOIDLE gave no readable value. Raw: $stRaw" -Status "WARN"
            throw "no readable value from powercfg"
        }
        $minutes = [math]::Round($acTimeout / 60)
        # NOTE: prefix "Found:" makes clear this was READ from system, not set by this tool
        $results["ScreenTimeout"] = if ($acTimeout -eq 0) { "Found: NEVER (your existing setting) -- recommend 5 min: Settings -> System -> Power & sleep" }
                                    elseif ($minutes -le 5) { "Found: ${minutes} min -- GOOD (this is your existing setting -- tool did not change it)" }
                                    else { "Found: ${minutes} min (your existing setting) -- recommend reducing to 5 min: Settings -> System -> Power & sleep" }
    } catch { $results["ScreenTimeout"] = "Could not read -- check manually in Settings -> System -> Power & sleep" }

    # 5. Critical battery action (laptop only -- skip gracefully on desktops)
    # Use $global:HasBattery set during step 9 power check -- avoids re-querying WMI
    try {
        $hasBatteryPS = if ($null -ne $global:HasBattery) { $global:HasBattery } else {
            $null -ne (Get-WmiObject -Class Win32_Battery -EA SilentlyContinue)
        }
        if (-not $hasBatteryPS) {
            $results["CriticalBattery"] = "N/A -- desktop (no battery)"
        } else {
            # FT-61 (ascii28): same rebuild as the screen-timeout read above --
            # 2>&1 capture, unsigned hex, raw output logged BEFORE any throw.
            $cb = cmd /c "powercfg /query SCHEME_CURRENT SUB_BATTERY BATACTIONCRIT 2>&1"
            $cbVal = $null
            if (($cb | Out-String) -match "Current DC Power Setting Index: 0x([0-9A-Fa-f]+)") {
                $cbVal = [Convert]::ToUInt32($Matches[1], 16)
            } else {
                $cbRaw = (($cb | Select-Object -First 6) -join " | ")
                Write-Log -Message "FT-61 powercfg BATACTIONCRIT gave no readable value. Raw: $cbRaw" -Status "WARN"
            }
            $results["CriticalBattery"] = switch ($cbVal) {
                0       { "DO NOTHING -- change to Hibernate recommended" }
                1       { "Sleep -- Hibernate preferred for data safety" }
                2       { "HIBERNATE -- GOOD" }
                3       { "SHUTDOWN -- GOOD" }
                default { "Unknown -- check manually in Power settings" }
            }
        }
    } catch { $results["CriticalBattery"] = "Could not read -- check manually in Power settings" }

    # FT-34 (2026-07-12): warn BEFORE the long screen appears
    Write-Host ""
    Write-Host "  Power settings check complete. The NEXT screen is a long one --" -ForegroundColor Yellow
    Write-Host "  BE SURE TO SCROLL UP TO THE TOP of it before reading." -ForegroundColor Yellow
    Pause-ForUser "  Press Enter or Space to see the power settings review..."

    # Display results
    Clear-Host
    Write-Host ""
    Draw-Box -Color White -Lines @(
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
        "      WHY: Lets your PC be woken up remotely. Wake on LAN and ",
        "      REMOTE DESKTOP are the two 'let someone in from outside'",
        "      features -- almost no home user needs either one, and we",
        "      strongly recommend BOTH be OFF. (Remote Desktop gets its ",
        "      own item on the security checklist coming up.)           ",
        "      IF ANYONE EVER PHONES YOU and asks you to turn remote    ",
        "      access ON or to install a remote-control program --      ",
        "      hang up. That is the single most common scam used        ",
        "      against home computer users today.                       ",
        "---",
        "  [4] Screen timeout (AC power):   $($results['ScreenTimeout'])",
        "      WHY: A screen that never turns off leaves your PC       ",
        "      visually accessible. Set to 5 min in Settings ->        ",
        "      System -> Power & sleep. (Advisory only -- not changed.)",
        "      NOTE: this is DIFFERENT from the temporary stay-awake    ",
        "      protection this tool switched on for this session --     ",
        "      that one is automatic and undoes itself when the tool    ",
        "      exits. Screen timeout is yours to set once, by hand.     ",
        "---",
        "  [5] Critical battery action:     $($results['CriticalBattery'])",
        "      WHY: If the battery dies mid-operation, open files are  ",
        "      lost unless an action is set. Hibernate saves your      ",
        "      session before power runs out. (Desktop PCs show N/A -- ",
        "      laptops will show current setting and offer to change.)  ",
        "---",
        "  SCROLL DOWN and REVIEW EACH setting above before you        ",
        "  continue -- each one shows its current state and WHY it      ",
        "  matters.                                                     ",
        "---",
        "  Sleep prevention (this session): SET BY THIS TOOL (not your prior setting)   ",
        "  Your original sleep setting will be restored when tool exits.               ",
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
        $powerChoices["PasswordOnWake"] = (Read-ValidKey -ValidKeys @("Y","N") -Prompt "Apply? (Y/N): ") -eq "Y"
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
        $powerChoices["FastStartup"] = (Read-ValidKey -ValidKeys @("Y","N") -Prompt "Apply? (Y/N): ") -eq "Y"
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
        $powerChoices["WakeOnLAN"] = (Read-ValidKey -ValidKeys @("Y","N") -Prompt "Apply? (Y/N): ") -eq "Y"
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
        $powerChoices["CriticalBattery"] = (Read-ValidKey -ValidKeys @("Y","N") -Prompt "Apply? (Y/N): ") -eq "Y"
        Write-Host ""
    } else {
        Write-Host "  [5] Critical battery: $($results['CriticalBattery']), no change needed." -ForegroundColor Green
        $powerChoices["CriticalBattery"] = $false
        Write-Host ""
    }

    Apply-PowerSettings -Results $results -Choices $powerChoices
    Pause-ForUser "  Power settings complete. Press Enter or Space to continue..."
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
            Write-Host "  OK  Critical battery ACTION set: if the battery ever runs" -ForegroundColor Green
            Write-Host "      critically low, the PC will HIBERNATE (save your session" -ForegroundColor Green
            Write-Host "      safely first). NOTE: this does NOT turn the hibernate" -ForegroundColor Green
            Write-Host "      feature itself on or off -- it only sets what happens" -ForegroundColor Green
            Write-Host "      when the battery is nearly empty." -ForegroundColor Green
            Write-Log -Message "Critical battery ACTION set to Hibernate (FT-44: does not toggle the hibernate feature itself)" -Status "APPLIED"
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
    "Slack Technologies",
    # Communication / Email
    "Proton AG", "ProtonMail", "Proton Mail", "Proton",
    "Zoom Video Communications", "Zoom",
    "Microsoft Teams", "Skype",
    # Remote Access (legitimate)
    "Google LLC",  # Chrome Remote Desktop
    "RealVNC", "TeamViewer", "AnyDesk",
    # Card / Hobby software
    "Software Enterprises",  # Convention card editors
    "Bridge Baron", "Deep Finesse",
    # Brother specific
    "Brother Industries", "Brother",
    "Brother PowerEngage", "PowerEngage"
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
    Draw-Box -Color White -Lines @(
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
            $uninstall = Read-ValidKey -ValidKeys @("Y","N","S") -Prompt "Uninstall $($app.Name)? (Y = Yes / N = Skip / S = Skip all): "
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
        $reviewYellow = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Review unused apps for removal? (Y/N): "
        if ($reviewYellow.ToUpper() -eq "Y") {
            Write-Host ""
            foreach ($app in $yellowApps) {
                $daysSince = if ($app.InstallDate) { [int]((Get-Date) - $app.InstallDate).TotalDays } else { "Unknown" }
                Write-Host "  App: $($app.Name)" -ForegroundColor White
                Write-Host "  Last activity: ~$daysSince days ago" -ForegroundColor Gray
                $uninstall = Read-ValidKey -ValidKeys @("Y","N","S") -Prompt "Uninstall? (Y = Yes / N = Skip / S = Skip remaining): "
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
    Pause-ForUser "  Apps Audit complete. Press Enter or Space to continue..."
}

# ============================================================
# SETTINGS DEFINITIONS (19 settings)
# ============================================================
$Settings = @(
    [PSCustomObject]@{ ID=1;  Name="Windows Update";                    Description="Ensures security patches are current and auto-update is on.";                              GuideRef="Phase 1, Step 1";          Selected=$true;  RequiresAdmin=$false; SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=2;  Name="Defender Real-Time VP (Virus Protection)";     Description="Your primary virus and malware shield. Should always be On.";                              GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=3;  Name="Tamper Protection (Defender)";        Description="Prevents malware from disabling Defender. Manual toggle required in Windows Security.";   GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$false; SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=4;  Name="SmartScreen";                       Description="Blocks known malicious websites and downloads.";                                          GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=5;  Name="Defender Periodic Scanning";        Description="Enables Defender background scans if a 3rd-party AV is your primary protection.";        GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=6;  Name="Phishing Protection (all 3)";       Description="Warns about password reuse, unsafe storage, and malicious sites in Edge.";               GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=7;  Name="Defender Firewall Protection (all profiles)";   Description="Network traffic shield -- Domain, Private, and Public profiles all enabled.";            GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=8;  Name="BitLocker / Device Encryption";     Description="Encrypts your drive. Protects data if PC is lost or stolen.";                            GuideRef="Phase 1, Step 3";          Selected=$false; RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=9;  Name="Windows Hello (check only)";        Description="Checks if PIN or biometrics are configured. Setup done manually -- see Guide.";          GuideRef="Phase 1, Step 4";          Selected=$true;  RequiresAdmin=$false; SkipOnHome=$false; CanAuto=$false; SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=10; Name="Remote Desktop -- Disable";         Description="Disables remote access if unused. Not available on Windows 11 Home.";                    GuideRef="Keep vs. Disable Table";   Selected=$false; RequiresAdmin=$true;  SkipOnHome=$true;  CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=11; Name="Advertising ID -- Turn Off";        Description="Stops Windows from tracking you for ad targeting.";                                      GuideRef="Keep vs. Disable Table";   Selected=$true;  RequiresAdmin=$false; SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=12; Name="Diagnostic Data -- Required Only";  Description="Limits data sent to Microsoft to the minimum required.";                                 GuideRef="Keep vs. Disable Table";   Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=13; Name="Edge Startup Boost and Background"; Description="Stops Edge pre-loading at boot and running in background after close. Saves RAM.";       GuideRef="Phase 1, Step 6, Part D"; Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=14; Name="Windows Widgets -- Disable";        Description="Disables news/weather panel that runs background Edge processes.";                       GuideRef="Phase 1, Step 6, Part F"; Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=15; Name="Edge Password Saving -- Disable";   Description="Turns off Edge password storage. Use a dedicated password manager instead. Check manually: Edge -> Settings -> Profiles -> Passwords.";            GuideRef="Phase 1, Step 6, Part I"; Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
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
function Get-TamperProtectionState {
    # Reads Tamper Protection directly from registry
    # Works even when 3rd party AV is managing VP (MB hides the toggle in Windows Security UI)
    # Returns: "On" / "Off" / "Unknown"
    try {
        $tp = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Defender\Features" -Name "TamperProtection" -EA Stop
        switch ($tp.TamperProtection) {
            5 { return "On" }
            4 { return "Off" }
            0 { return "Off" }
            default { return "Unknown" }
        }
    } catch { return "Unknown" }
}

function Get-MalwarebytesState {
    # Returns: NotInstalled / FreeCompanion / TrialActive / Unknown
    #
    # FreeCompanion = MB Free installed -- Defender is still primary RT protection
    # TrialActive   = MB Premium Trial active -- took over RT from Defender
    #
    # DETECTION METHOD (revised ascii20):
    #   The productState 0x1000 bit is NOT reliable -- MB Free also sets it on some
    #   systems (confirmed HP Laptop 17-by1xxx: MB Free productState=0x061000).
    #
    #   Primary: Check Defender RT directly via Get-MpComputerStatus.
    #     If Defender RT is ON  -> MB is FreeCompanion regardless of productState
    #     If Defender RT is OFF -> MB likely took over -> check further for TrialActive
    #
    #   Secondary (when Defender RT is off): firewall registration + service state
    try {
        # Step 1: Is MB even registered in SecurityCenter2?
        $avProducts = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
        $mbAV = $avProducts | Where-Object { $_.displayName -match "Malwarebytes" }
        if (-not $mbAV) { return "NotInstalled" }

        # Step 2: Check Defender real-time state directly -- most reliable source of truth
        try {
            $mp = Get-MpComputerStatus -EA Stop
            $defenderRT = $mp.RealTimeProtectionEnabled
        } catch {
            $defenderRT = $false
        }

        if ($defenderRT) {
            # Defender RT is ON -- MB is not taking over real-time, it is a companion
            return "FreeCompanion"
        }

        # Step 3: Defender RT is OFF -- check if MB Premium Trial actually took over
        $mbPremium = $false

        # MB WFC (Windows Firewall Control) only registers as FirewallProduct during Premium Trial
        try {
            $fwProducts = Get-WmiObject -Namespace "root\SecurityCenter2" -Class FirewallProduct -EA SilentlyContinue
            $mbFW = $fwProducts | Where-Object { $_.displayName -match "Malwarebytes" }
            if ($mbFW) { $mbPremium = $true }
        } catch {}

        # MBAMService running + Defender RT off is a strong indicator of Premium Trial
        try {
            $mbSvc = Get-Service "MBAMService" -EA Stop
            if ($mbSvc.Status -eq "Running") { $mbPremium = $true }
        } catch {}

        # FT-37 (2026-07-12): was "return if (...)" -- INVALID PowerShell that
        # threw at runtime, got swallowed by the outer catch, and made this
        # function return "Unknown" whenever Defender RT was off. That single
        # line caused BOTH field-reported Defender false alarms (state:
        # Unknown in the 2026-07-11 logs, Dell Latitude 5430).
        if ($mbPremium) { return "TrialActive" } else { return "FreeCompanion" }

    } catch { return "Unknown" }
}

function Get-AllStatuses {
    foreach ($s in $Settings) {
        $s | Add-Member -NotePropertyName Status -NotePropertyValue "Checking..." -Force -ErrorAction SilentlyContinue
    }

    $isHome = $global:WinEdition -notmatch "Pro|Enterprise|Education|Business"

    # FT-54 (ascii28): the checks took long enough that a blinking cursor
    # looked like a hang -- live progress line added.
    $ggChkNum = 0
    foreach ($s in $Settings) {
        $ggChkNum++
        try { Write-Host ("`r  Checking setting $ggChkNum of $($Settings.Count)...   ") -ForegroundColor Cyan -NoNewline } catch {}
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
                    } else {
                        # FT-33 (2026-07-12): was elseif on three named states --
                        # any OTHER value fell through leaving "Checking..." on
                        # screen. Now everything non-trial checks Defender directly.
                        # MB Free companion, not installed, or unknown -- check actual Defender state directly
                        if ($mp2.RealTimeProtectionEnabled) {
                            $s.Status = if ($mbSt2 -eq "FreeCompanion") { "ON -- Defender RT-VP active  (Malwarebytes Free = manual scan companion only)" } elseif ($mbSt2 -eq "TrialActive") { "ON via 3rd-party VP -- Malwarebytes Premium Trial active" } else { "ON -- GOOD" }
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
                # Tamper Protection is always readable via registry regardless of which AV is active
                $tpState = Get-TamperProtectionState
                $mbSt3   = Get-MalwarebytesState
                switch ($tpState) {
                    "On"  {
                        $s.Status = if ($mbSt3 -eq "FreeCompanion") {
                            "ON -- GOOD  (readable via registry even with Malwarebytes Free installed)"
                        } elseif ($mbSt3 -eq "TrialActive") {
                            "ON -- GOOD  (verified via registry -- Malwarebytes Premium Trial active)"
                        } else {
                            "ON -- GOOD"
                        }
                    }
                    "Off" {
                        $s.Status = if ($mbSt3 -eq "TrialActive") {
                            "OFF while MB trial runs -- check again AFTER the trial ends: Windows Security -> V&T protection settings"
                        } else {
                            "OFF -- enable manually: Windows Security -> Virus & threat protection settings -> Tamper Protection -> On"
                        }
                    }
                    default { $s.Status = "Unknown -- check manually in Windows Security -> Virus & threat protection settings" }
                }
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
                        $s.Status = "OFF is correct here -- GOOD"   # Defender primary; MB Free is manual-scan companion only
                    } elseif ($mbSt5 -eq "TrialActive") {
                        # MB Premium Trial took over real-time -- periodic scanning IS recommended
                        try {
                            $ps = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows Defender" -EA SilentlyContinue).PassiveMode
                            # FT-60 (ascii28): the toggle is MANUAL-ONLY (no supported
                            # scripted method) -- say so, and point at the steps.
                            $s.Status = "MB Trial is primary -- turn ON by hand (steps on this item's screen)"
                        } catch { $s.Status = "MB Trial is primary -- turn ON by hand (steps on this item's screen)" }
                    } elseif ($nd5) {
                        # Other 3rd-party AV
                        try {
                            $ps = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows Defender" -EA SilentlyContinue).PassiveMode
                            $s.Status = if ($ps -eq 1) { "3rd-party AV active -- enable periodic scanning" } else { "3rd-party AV detected -- check Defender settings" }
                        } catch { $s.Status = "3rd-party AV active -- check Defender settings" }
                    } else {
                        $s.Status = "OFF is correct here -- GOOD"   # Defender is primary; periodic scan only applies when a 3rd-party AV runs
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
                try { $pw = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>$null; $acVal = if ($pw -match "Current AC Power Setting Index: 0x(\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { $null }; $s.Status = if ($acVal -eq 1) { "REQUIRED -- GOOD" } else { "Not required -- needs attention" } }
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
    try { Write-Host ("`r  All $($Settings.Count) settings checked.                    ") -ForegroundColor Green } catch {}

    # Auto-deselect items already at recommended setting
    foreach ($s in $Settings) {
        if ($s.Status -match "GOOD") { $s.Selected = $false }
    }
    # BitLocker -- never auto-select
    ($Settings | Where-Object { $_.ID -eq 8 }).Selected = $false

    # ── Auto-deselect items already at recommended state ──
    # GOOD items show green and are skipped by default
    # User can still manually select [number] to re-apply if needed
    foreach ($s in $Settings) {
        if ($s.Status -match "-- GOOD|N/A on Home|ENCRYPTED -- GOOD|ALL ON -- GOOD") {
            $s.Selected = $false
        }
    }
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

    # FT-65 (ascii29): the prompt label said 'S = Skip' while the menu
    # said 'S = Show me what each item does' -- contradictory labels
    # (root cause of the 2026-07-13 52-keypress S flood). Labels now
    # agree, S clears and re-renders instead of piling text, and any
    # buffered auto-repeat keys are drained AFTER S is accepted so one
    # held key cannot answer the next prompt. This is a targeted post-
    # accept drain -- NOT the FT-29 global pre-read flush, which ate
    # first keypresses and stays removed.
    do {
        Clear-Host
        Write-Host ""
        Draw-Box -Color White -Lines @(
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
        $resp = Read-ValidKey -ValidKeys @("Y","N","S") -Prompt "Your choice (Y = Continue / N = Go back / S = Show me each item): "
        if ($resp.ToUpper() -eq "S") {
            # Drain buffered auto-repeats of the accepted key (FT-65)
            try { while ($Host.UI.RawUI.KeyAvailable) { $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") } } catch {}
            Clear-Host
            Write-Host ""
            Draw-Box -Color White -Lines @(
                "  WHAT EACH ITEM DOES -- AND WHY IT IS RECOMMENDED         ",
                "---",
                "  Details for each item you have not selected:             "
            )
            Write-Host ""
            foreach ($item in $criticalDeselected) {
                Write-Host "  Item $($item.ID): $($item.Name)" -ForegroundColor Yellow
                Write-Host "  Why recommended: $($item.Description)" -ForegroundColor Gray
                Write-Host "  Guide reference: $($item.GuideRef)" -ForegroundColor Cyan
                Write-Host ""
            }
            Pause-ForUser "  Press Enter or Space to return to the HEADS UP screen..."
        }
    } while ($resp.ToUpper() -eq "S")

    if ($resp.ToUpper() -eq "Y") {
        foreach ($item in $criticalDeselected) {
            Write-Log -Message "NOTED: User chose not to apply: $($item.Name) -- Status: $($item.Status)" -Status "NOTED"
        }
        Write-Log -Message "User confirmed intentional skip of security-critical items at stage: $Stage" -Status "NOTED"
        return $true
    }
    return $false   # N = go back and review selections
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
                $result = "Malwarebytes Premium Trial is active -- Tamper Protection cannot be verified while the trial holds real-time AV control. EASIEST PATH: wait for the trial to end (it reverts to Free automatically -- nothing to do), then check again: Windows Security -> Virus & threat protection settings -> Tamper Protection -> On. In a hurry? End the trial early inside Malwarebytes: Settings (gear icon) -> Account -> Deactivate Premium Trial. See Guide: Phase 1, Step 2"
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
            # Enhanced Phishing Protection -- WTDS registry
            # Key may be Tamper Protected -- catch PermissionDenied and show manual steps
            try {
                $rp = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components"
                if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                Set-ItemProperty -Path $rp -Name ServiceEnabled      -Value 1 -Type DWord -Force -EA Stop
                Set-ItemProperty -Path $rp -Name NotifyMalicious      -Value 1 -Type DWord -Force -EA Stop
                Set-ItemProperty -Path $rp -Name NotifyPasswordReuse  -Value 1 -Type DWord -Force -EA Stop
                Set-ItemProperty -Path $rp -Name NotifyUnsafeApp      -Value 1 -Type DWord -Force -EA Stop
                $result = "All 3 phishing protection options enabled -- GOOD"
            } catch [System.Security.SecurityException] {
                $result = "MANUAL REQUIRED -- registry is protected on this PC (Tamper Protection)"
                Write-Host ""
                Write-Host "  NOTE: Phishing Protection registry is protected on this PC." -ForegroundColor Yellow
                Write-Host "  Enable manually:" -ForegroundColor Yellow
                Write-Host "  1. Windows Security -> App & browser control" -ForegroundColor Gray
                Write-Host "  2. Reputation-based protection settings" -ForegroundColor Gray
                Write-Host "  3. Under Phishing protection -> turn ON all 3 options" -ForegroundColor Gray
                Write-Host "  Full guide: gatewayguard.co/guide/phishing-protection" -ForegroundColor Cyan
                Write-Host ""
                Pause-ForUser "  Press Enter or Space to continue..."
            } catch {
                $result = "Could not enable -- check manually in Windows Security -> App & browser control"
            }
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

    # BUGFIX ascii23 (2026-07-10): status was hardcoded to "APPLIED" no matter
    # what actually happened -- a setting blocked by a 3rd-party AV, requiring
    # manual action, or erroring out was still logged as [APPLIED], which
    # contradicts the Result text and misleads anyone reading the log.
    $logStatus = if ($result -match "^ERROR:") { "ERROR" }
                 elseif ($result -match "^!! CRITICAL") { "CRITICAL" }
                 elseif ($result -match "^MANUAL ACTION REQUIRED") { "MANUAL" }
                 elseif ($result -match "^NOTE:|cannot run simultaneously|cannot be verified|cannot be enabled simultaneously") { "BLOCKED" }
                 elseif ($result -match "-- GOOD") { "APPLIED" }
                 else { "INFO" }
    Write-Log -Message "$($Setting.Name) | Before: $before | Result: $result" -Status $logStatus
    return $result
}

# ============================================================
# SCOPE DISCLAIMER
# ============================================================
function Show-ScopeDisclaimer {
    # Ensure sleep prevention is active (in case it failed at startup)
    if (-not $global:SleepPrevented) { Enable-SleepPrevention }

    # FT-31 (2026-07-12): ask about a password manager BEFORE the checklist.
    # Turning off Edge's password saving only makes sense if passwords live
    # somewhere safer. Without a manager, that change could lock people out
    # of their own accounts -- so the [E] item adapts to this answer.
    Clear-Host
    Write-Host ""
    Draw-Box -Color White -Lines @(
        "  QUICK QUESTION -- YOUR PASSWORDS                            ",
        "---",
        "  Do you use a PASSWORD MANAGER -- a separate app such as     ",
        "  Bitwarden, 1Password, or KeePass -- to store your           ",
        "  passwords?                                                  ",
        "                                                              ",
        "  WHY WE ASK: One of the later settings turns OFF the web     ",
        "  browser's built-in password saving, because browsers are    ",
        "  a common target for password-stealing malware. But that     ",
        "  only makes sense if your passwords already live somewhere   ",
        "  safer. If you don't have a password manager yet, we will    ",
        "  LEAVE the browser's password saving alone so you don't      ",
        "  lose access to your accounts."
    )
    Write-Host ""
    $pmAns = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Do you use a password manager? (Y/N): "
    $global:HasPasswordManager = ($pmAns.ToUpper() -eq "Y")
    if (-not $global:HasPasswordManager) {
        $eSetting = $Settings | Where-Object { $_.ID -eq 15 }
        if ($eSetting) { $eSetting.Selected = $false }
        Write-Host ""
        Write-Host "  Understood -- Edge's password saving will be LEFT ON for now." -ForegroundColor Green
        Write-Host "  When you're ready, a password manager is strongly recommended --" -ForegroundColor Gray
        Write-Host "  see the Guide for how to set one up, then re-run this tool." -ForegroundColor Gray
        Write-Log -Message "No password manager -- Edge Password Saving (ID 15) deselected, left ON" -Status "INFO"
    } else {
        Write-Log -Message "User has a password manager -- Edge Password Saving change stays available" -Status "INFO"
    }
    Write-Host ""
    Pause-ForUser

    # FT-52/FT-55 (ascii28): B on this screen returns to the password
    # question above (testers asked for it); claims corrected -- items the
    # tool cannot change are now listed as exactly that.
    $ggScopeNav = "NEXT"
    do {
    Clear-Host
    Write-Host ""
    Draw-Box -Color White -Lines @(
        "  WHAT THIS TOOL DOES AND DOES NOT DO                               ",
        "---",
        "  HOW THIS WORKS:                                                   ",
        "  The previous pre-flight screens READ your current settings.       ",
        "  What you saw was what was FOUND on your PC -- nothing was         ",
        "  changed yet. Changes only happen after you approve each item      ",
        "  in the security checklist on the next screen.                     ",
        "                                                                    ",
        "  WHAT IT CHANGES (each one only with your approval):              ",
        "  * Security features ON  (Defender virus protection, SmartScreen, ",
        "    Firewall, Memory Integrity, BitLocker if you choose it)        ",
        "  * Risky features OFF    (Remote Desktop, Wake-on-LAN,            ",
        "    Fast Startup)                                                  ",
        "  * Privacy settings      (Advertising ID, Diagnostic Data)        ",
        "                                                                    ",
        "  WHAT IT CHECKS BUT CANNOT CHANGE -- Windows insists a human      ",
        "  does these; the tool shows you the exact steps instead:          ",
        "  * Tamper Protection   * Windows Hello (PIN)   * Screen timeout   ",
        "                                                                    ",
        "  CONVENIENCE FEATURES -- YOU WILL BE ASKED AT THE END:            ",
        "  The following are RECOMMENDED to turn off for security/privacy.   ",
        "  After all settings run, you will review each one individually     ",
        "  and decide whether to KEEP the change or REVERT it:              ",
        "                                                                    ",
        "  [A] Advertising ID      -- Stops Windows tracking you for ads    ",
        "  [B] Diagnostic Data     -- Limits data sent to Microsoft         ",
        "  [C] Edge Startup Boost  -- Stops Edge loading on every boot      ",
        "  [D] Windows Widgets     -- Stops background Edge/news processes  ",
        $(if ($global:HasPasswordManager) { "  [E] Edge Password Save  -- Keeps passwords out of the browser    " } else { "  [E] Edge Password Save  -- SKIPPED: set up a password manager 1st" }),
        "                                                                    ",
        "  WHAT IT DOES NOT DO:                                             ",
        "  * Does not uninstall apps (only flags suspicious ones for you)   ",
        "  * Does not change your browser, passwords, or accounts           ",
        "  * Does not affect your files, documents, or personal data        ",
        "  * Does not make changes you cannot reverse                       ",
        "                                                                    ",
        "  Edition: $global:WinEditionFriendly",
        "  Admin:   $(if ($global:IsAdmin) { 'Full access -- all settings available' } else { 'Limited -- some settings skipped' })",
        "  Power:   $(if ($global:OnBattery) { 'BATTERY -- plug in before BitLocker' } else { 'AC power OK' })  Sleep: $(if ($global:SleepPrevented) { 'ACTIVE' } else { 'inactive' })"
    )
    Write-Host ""
    Write-Host "  SCROLL UP AND THEN DOWN ON THE NEXT SCREEN -- it is longer" -ForegroundColor Yellow
    Write-Host "  than one window." -ForegroundColor Yellow
    Write-Host ""
    $ggScopeNav = Read-NavKey -Prompt "  Read the above, then press Enter or Space for the security checklist, or B to go back to the password question: "
    if ($ggScopeNav -eq "BACK") {
        # Re-ask the password-manager question, then loop to this screen
        Clear-Host
        Write-Host ""
        $pmAns2 = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Do you use a password manager? (Y/N): "
        $global:HasPasswordManager = ($pmAns2.ToUpper() -eq "Y")
        $eSetting2 = $Settings | Where-Object { $_.ID -eq 15 }
        if ($eSetting2) { $eSetting2.Selected = $global:HasPasswordManager }
        Write-Log -Message "Password-manager answer revised via Back: $($global:HasPasswordManager)" -Status "INFO"
    }
    } while ($ggScopeNav -eq "BACK")
}

# ============================================================
# CONVENIENCE FEATURES REVIEW (end of run -- option B: one at a time)
# ============================================================
function Show-ConvenienceReview {
    $convItems = @(
        @{
            ID      = 11
            Name    = "Advertising ID"
            What    = "Turned OFF -- Windows can no longer track your activity for ad targeting."
            Why     = "Windows assigns each account an Advertising ID and shares it across apps`n  and websites to serve targeted ads. Turning it off stops this tracking.`n  You still see ads -- they just won't be personalized to you."
            Revert  = "Settings -> Privacy & security -> General -> Let apps use advertising ID -> On"
            RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
            RegName = "Enabled"
            RevertVal = 1
            RevertType = "DWord"
        },
        @{
            ID      = 12
            Name    = "Diagnostic Data"
            What    = "Set to REQUIRED ONLY -- Windows sends minimum data to Microsoft."
            Why     = "By default Windows sends detailed usage, browsing habits and error reports`n  to Microsoft. Required Only limits this to the minimum for Windows to work.`n  Windows continues to function normally with this setting."
            Revert  = "Settings -> Privacy & security -> Diagnostics & feedback -> Diagnostic data -> Full"
            RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
            RegName = "AllowTelemetry"
            RevertVal = 3
            RevertType = "DWord"
        },
        @{
            ID      = 13
            Name    = "Edge Startup Boost and Background Running"
            What    = "DISABLED -- Edge no longer launches on every boot or runs after you close it."
            Why     = "Edge Startup Boost launches background Edge processes every time your PC`n  boots, even if you never open Edge. Background mode keeps Edge running`n  after you close it. Both waste RAM and CPU. Edge still works normally`n  when you open it -- it just won't pre-load without you asking."
            Revert  = "Open Edge -> Settings (three dots) -> System and performance ->`n           Startup boost -> On  AND  Continue running background apps -> On"
            RegPath = $null  # Edge settings via registry are user-specific -- manual revert only
            RegName = $null
            RevertVal = $null
            RevertType = $null
        },
        @{
            ID      = 14
            Name    = "Windows Widgets"
            What    = "DISABLED -- The news/weather panel is turned off."
            Why     = "The Widgets panel runs background Edge WebView2 processes at all times,`n  consuming RAM even when the panel is closed. It also sends browsing`n  behavior data to Microsoft. Disabling Widgets does NOT affect the`n  taskbar, Start menu, or any other feature."
            Revert  = "Settings -> Personalization -> Taskbar -> Widgets -> On"
            RegPath = $null
            RegName = $null
            RevertVal = $null
            RevertType = $null
        },
        @{
            ID      = 15
            Name    = "Edge Password Saving"
            What    = "DISABLED -- Edge will no longer offer to save passwords."
            Why     = "Browser-saved passwords are stored with minimal encryption and are`n  vulnerable if someone accesses your PC or if Edge is compromised.`n  A dedicated password manager (Bitwarden, 1Password) uses stronger`n  encryption and works across all browsers and devices.`n  NOTE: This does NOT delete any passwords already saved in Edge."
            Revert  = "Open Edge -> Settings -> Passwords -> Offer to save passwords -> On"
            RegPath = $null
            RegName = $null
            RevertVal = $null
            RevertType = $null
        }
    )

    # Only review items that were actually applied in this session
    $applied = $Settings | Where-Object { $_.ID -in (11,12,13,14,15) -and $_.Status -match "GOOD|applied|disabled|set" }
    if ($applied.Count -eq 0) { return }  # Nothing was applied -- skip review

    Clear-Host
    Write-Host ""
    Draw-Box -Color White -Lines @(
        "  CONVENIENCE FEATURES -- YOUR REVIEW                              ",
        "---",
        "  The following changes were made during this session.             ",
        "  All are RECOMMENDED for security and privacy.                    ",
        "                                                                   ",
        "  You will review each one individually.                           ",
        "  For each item:                                                   ",
        "    Y = Keep the change (recommended)                              ",
        "    N = Revert it -- undo the change and restore the original      "
    )
    Write-Host ""
    Pause-ForUser "  Press Enter or Space to review each item..."

    foreach ($ci in $convItems) {
        # Only show items that were applied
        $appliedItem = $Settings | Where-Object { $_.ID -eq $ci.ID -and $_.Status -match "GOOD|applied|disabled|set" }
        if (-not $appliedItem) { continue }

        Clear-Host
        Write-Host ""
        Draw-Box -Color White -Lines @(
            "  CONVENIENCE FEATURE [$($ci.ID) of 5]: $($ci.Name)          ",
            "---",
            "  WHAT WAS DONE:                                              ",
            "  $($ci.What)                                                 ",
            "---",
            "  WHY THIS IS RECOMMENDED:                                    ",
            "  $($ci.Why)                                                  ",
            "---",
            "  TO REVERT MANUALLY IF YOU CHOOSE N:                        ",
            "  $($ci.Revert)                                               "
        )
        Write-Host ""
        Write-Host "  Y = Keep this change (recommended)" -ForegroundColor White
        Write-Host "  N = Revert it now -- restore the original setting" -ForegroundColor White
        Write-Host ""

        do {
            $resp = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Your choice (Y = Keep / N = Revert): "
        } while ($resp.ToUpper() -notin @("Y","N"))

        if ($resp.ToUpper() -eq "N") {
            if ($ci.RegPath -and $ci.RegName -and $null -ne $ci.RevertVal) {
                try {
                    Set-ItemProperty -Path $ci.RegPath -Name $ci.RegName -Value $ci.RevertVal -Type $ci.RevertType -Force -EA Stop
                    Write-Host "  Reverted: $($ci.Name) restored to original setting." -ForegroundColor Yellow
                    Write-Log -Message "User reverted convenience feature: $($ci.Name)" -Status "INFO"
                } catch {
                    Write-Host "  Could not auto-revert -- please restore manually:" -ForegroundColor Yellow
                    Write-Host "  $($ci.Revert)" -ForegroundColor Gray
                    Write-Log -Message "Auto-revert failed for $($ci.Name): $_" -Status "WARN"
                }
            } else {
                Write-Host "  This setting requires manual revert:" -ForegroundColor Yellow
                Write-Host "  $($ci.Revert)" -ForegroundColor Gray
                Write-Log -Message "User chose to revert $($ci.Name) -- manual action required" -Status "INFO"
            }
            Start-Sleep -Milliseconds 1500
        } else {
            Write-Host "  Kept: $($ci.Name) change retained." -ForegroundColor Green
            Write-Log -Message "User kept convenience feature change: $($ci.Name)" -Status "OK"
            Start-Sleep -Milliseconds 800
        }
    }

    Write-Host ""
    Write-Host "  Convenience feature review complete." -ForegroundColor White
    Write-Host ""
    Pause-ForUser "  Press Enter or Space to see your manual steps checklist..."
}

# ============================================================
# MANUAL STEPS REMINDER
# ============================================================
function Show-ManualSteps {
    Write-Host ""
    Draw-Box -Color White -Lines @(
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
        "  Log saved to C:\GatewayGuard\Logs\: $(Split-Path $LogPath -Leaf)",
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
    Draw-Box -Color White -Lines @(
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
# ============================================================
# BITLOCKER DECISION FLOW (FT-67, ascii29)
# Shown at review (console mode) when the drive is NOT encrypted
# and item 8 is not selected: HEADS UP -> full write-up (S) ->
# final confirmation. N at either screen returns to the checklist.
# ============================================================
function Show-BitLockerWhyEncrypt {
    Clear-Host
    Write-Host ""
    Draw-Box -Color White -Lines @(
        "  DRIVE ENCRYPTION (BitLocker) -- WHAT IT IS, WHY IT MATTERS ",
        "---",
        "  WHAT IT DOES                                               ",
        "  BitLocker is built into Windows. It scrambles (encrypts)   ",
        "  everything on your hard drive. Only this computer,         ",
        "  unlocked with your normal sign-in, can unscramble it.      ",
        "                                                             ",
        "  WHY WE RECOMMEND IT                                        ",
        "  If your laptop is ever lost or stolen, a thief can pull    ",
        "  out the drive, connect it to another computer, and read    ",
        "  every file on it -- taxes, banking, photos -- without      ",
        "  ever knowing your Windows password. Encryption closes      ",
        "  that door: a stolen encrypted drive is unreadable.         ",
        "                                                             ",
        "  WHAT IT COSTS YOU                                          ",
        "  * One overnight run. It never needs to run again.          ",
        "  * No noticeable slowdown on a modern PC.                   ",
        "  * You MUST keep your recovery key. The tool saves it for   ",
        "    you and shows you where. Keep a copy OFF this computer   ",
        "    -- printed, or in your password manager.                 ",
        "                                                             ",
        "  THE ONE REAL RISK                                          ",
        "  If Windows ever asks for the recovery key at startup and   ",
        "  you cannot find it, your files stay locked. That is why    ",
        "  saving the key is step one, BEFORE anything is encrypted.  ",
        "                                                             ",
        "  RECOMMENDATION: Turn this ON. For a laptop, this is one    ",
        "  of the most valuable protections in this entire tool.      "
    )
    Pause-ForUser "  Press Enter or Space to return..."
}

function Show-BitLockerFinalDecline {
    Clear-Host
    Write-Host ""
    Draw-Box -Color White -Lines @(
        "  YOUR CHOICE IS NOTED -- NO ENCRYPTION WILL BE APPLIED      ",
        "---",
        "  That is entirely your call -- this is your computer, and   ",
        "  this tool never applies anything you did not choose.       ",
        "                                                             ",
        "  Two things worth knowing:                                  ",
        "                                                             ",
        "  1. You can turn encryption on any time. Run this tool      ",
        "     again and select item 8, Drive Encryption. One          ",
        "     overnight run and it is done.                           ",
        "                                                             ",
        "  2. Until then, treat this laptop like a wallet: know       ",
        "     where it is, especially when traveling.                 "
    )
    Write-Host ""
    if (-not $script:GGLogNoticeShown) {
        Write-Host "  For your protection, your choices can be reviewed in your log." -ForegroundColor Gray
        Write-Host ""
        $script:GGLogNoticeShown = $true
    }
    $fd = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue WITHOUT encryption? (Y = Yes, continue / N = Go back and select it): "
    if ($fd.ToUpper() -eq "N") { return "GoBack" }
    Write-Log -Message "NOTED: User chose not to apply: Drive Encryption (BitLocker) -- Status: not encrypted -- can be enabled later by re-running the tool" -Status "NOTED"
    return "Skip"
}

function Show-BitLockerDeclineHeadsUp {
    do {
        Clear-Host
        Write-Host ""
        Draw-Box -Color White -Lines @(
            "  HEADS UP -- YOU HAVE NOT SELECTED DRIVE ENCRYPTION        ",
            "---",
            "  Drive encryption (item 8, BitLocker) is not selected.     ",
            "                                                            ",
            "  Everything else this tool does protects a computer that   ",
            "  is in your hands. Encryption is the one item that         ",
            "  protects your files if the computer LEAVES your hands --  ",
            "  lost, stolen, or sold without being wiped.                ",
            "                                                            ",
            "  Without it, anyone holding this laptop can read your      ",
            "  files by connecting the drive to another computer.        ",
            "  Your Windows password does not stop that.                 "
        )
        Write-Host ""
        Write-Host "  Y = Continue WITHOUT encryption" -ForegroundColor White
        Write-Host "  N = Go back and select encryption" -ForegroundColor White
        Write-Host "  S = Show me the full explanation" -ForegroundColor White
        Write-Host ""
        $bd = Read-ValidKey -ValidKeys @("Y","N","S") -Prompt "Your choice (Y = Continue / N = Go back / S = Show me): "
        if ($bd.ToUpper() -eq "S") {
            # Drain buffered auto-repeats of the accepted key (FT-65)
            try { while ($Host.UI.RawUI.KeyAvailable) { $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") } } catch {}
            Show-BitLockerWhyEncrypt
        }
    } while ($bd.ToUpper() -eq "S")
    if ($bd.ToUpper() -eq "N") { return "GoBack" }
    return Show-BitLockerFinalDecline
}

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
        Draw-Box -Color White -Lines @(
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
        Write-Host "  Plug in AC power, then press Enter or Space to continue..." -ForegroundColor Yellow
        Write-Host "  Or press S to skip BitLocker for now." -ForegroundColor Gray
        Write-Host ""
        # BUGFIX ascii23 (2026-07-10, FT-01): same unprotected-ReadKey issue
        # as the main checklist -- see note there for full explanation.
        # FT-46 (ascii28): re-assert Ctrl+C-as-input before every read
        try { [Console]::TreatControlCAsInput = $true } catch {}
        try {
            $blKey = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        } catch {
            Write-Log -Message "ReadKey failed on BitLocker battery screen (focus loss?) -- falling back: $_" -Status "WARN"
            $blFallback = Read-Host
            $blKey = [PSCustomObject]@{ Character = if ($blFallback.Length -gt 0) { $blFallback.Substring(0,1) } else { "" } }
        }
        # FT-69 (ascii29): Ctrl+C opens the exit confirmation
        if ($blKey.Character -eq [char]3) { Invoke-CtrlCExit }
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

    # Pre-BitLocker prep checklist (UX-11) -- explicit confirmation required
    Clear-Host
    Write-Host ""
    Draw-Box -Color White -Lines @(
        "  BEFORE ENABLING BITLOCKER, YOU MUST:                      ",
        "---",
        "  1. Save your Recovery Key -- you will need it if you ever  ",
        "     get locked out                                         ",
        "  2. Print your Recovery Key and store it with your          ",
        "     important documents (birth certificate, passport,       ",
        "     insurance papers) -- NOT near your computer             ",
        "  3. Also save it to your Microsoft account as a backup      ",
        "  4. Plug in your power adapter -- encryption can take a     ",
        "     long time                                               ",
        "  5. Do not turn off, restart, or close the lid during       ",
        "     encryption                                              ",
        "                                                             ",
        "  WARNING: If you lose your Recovery Key and get locked out, ",
        "  your data CANNOT be recovered by anyone -- not even        ",
        "  Microsoft.                                                 "
    )
    Write-Host ""
    $blPrepConfirm = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Have you saved and printed your Recovery Key plan? (Y/N): "
    if ($blPrepConfirm.ToUpper() -eq "N") {
        Write-Host ""
        Write-Host "  BitLocker skipped for now. Enable later once you're ready." -ForegroundColor Yellow
        Write-Log -Message "BitLocker skipped -- user not ready for Recovery Key prep" -Status "SKIP"
        Pause-ForUser
        return
    }

    Clear-Host
    Write-Host ""
    Draw-Box -Color White -Lines @(
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
    Write-Host "      Sleep will be set to Never automatically. Check the GatewayGuard log (C:\GatewayGuard\Logs) in the morning." -ForegroundColor DarkGray
    Write-Host ""

    Write-Host "  [3] Skip for now -- enable manually when ready:" -ForegroundColor White
    Write-Host "      Settings -> Privacy & security -> Device encryption -> On" -ForegroundColor DarkGray
    Write-Host ""

    $choice = Read-ValidKey -ValidKeys @("1","2","3") -Prompt "Choose option (1, 2, or 3): "

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
        $blOrigSleep = if ($blOrigSleepRaw -match "Current AC Power Setting Index: 0x(\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { 0 }
        $blOrigDisplay = if ($blOrigDisplayRaw -match "Current AC Power Setting Index: 0x(\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { 0 }

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
        Write-Host "  Sleep and display are set to Never. Check the GatewayGuard log (C:\GatewayGuard\Logs) in the morning." -ForegroundColor Yellow
    }

    try {
        Enable-BitLocker -MountPoint $env:SystemDrive -RecoveryPasswordProtector -EA Stop | Out-Null
        $key = (Get-BitLockerVolume -MountPoint $env:SystemDrive).KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }
        Save-BitLockerKey -Key $key
        $global:BitLockerKeyGenerated = $true
        Write-Log -Message "BitLocker enabled. Drive: $($info.DriveGB)GB $($info.DriveType), RAM: $($info.RAMGB)GB, Estimate: $($info.Estimate), Mode: $(if ($choice -eq '2') { 'overnight' } else { 'now' })" -Status "APPLIED"

        Write-Host ""
        Draw-Box -Color White -Lines @(
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
        Pause-ForUser "  Press Enter or Space ONLY after you have SAVED and PRINTED the recovery key..."
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
    Draw-Box -Color White -Lines @(
        "  GatewayGuard Windows 11 Security Hardening Tool v$ScriptVersion    ",
        "  William F. Burns III                                     ",
        "  Former Information Security Officer                       ",
        "  Port Authority of New York & New Jersey                   ",
        "---",
        "  No changes are made without your approval.                ",
        "  A complete log is saved to C:\GatewayGuard\Logs\ after each run.  ",
        "  Guide and support: $GuideURL  (ends in .co -- NOT .com)   ",
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
        "  Edition: $global:WinEditionFriendly"
    )
    Write-Host ""
}

# ============================================================
# CONSOLE MODE
# ============================================================
function Run-ConsoleMode {
    trap {
        # FT-49 (ascii28): this trap used to write the error to the SCREEN
        # only -- an unattended or missed error produced the 7/12 'silent
        # exit' with nothing in the log but the sleep-prevention line.
        # The log now records the error, the line, and the exit reason.
        try {
            Write-Log -Message ("Console mode error: " + $_.Exception.Message + " (line " + $_.InvocationInfo.ScriptLineNumber + ")") -Status "ERROR"
            Write-Log -Message "Exiting via console-mode error trap" -Status "EXIT"
        } catch {}
        Write-Host ""
        Write-Host "  ERROR: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "  Line: $($_.InvocationInfo.ScriptLineNumber)" -ForegroundColor Red
        Pause-ForUser "  Press Enter or Space to exit..."
        Disable-SleepPrevention
        Save-Log
        exit
    }

    Clear-Host
    Write-Host ""
    Write-Host "  Checking current settings -- please wait..." -ForegroundColor Yellow
    Get-AllStatuses
    Write-Host ""
    Write-Host "  SCROLL UP AND THEN DOWN ON THE NEXT SCREEN -- it explains" -ForegroundColor Yellow
    Write-Host "  exactly what this tool does and does not do." -ForegroundColor Yellow
    Start-Sleep -Milliseconds 1500
    Show-ScopeDisclaimer

    :checklistLoop while ($true) {
        Clear-Host
        Write-Host ""
        # FT-56/FT-58 (ascii28): the ascii23-era table was fixed at 79 chars
        # for unmaximized 80-column consoles -- on the maximized window this
        # tool INSISTS on, that used barely half the width. Width now adapts
        # to the real window (63/38 columns when >=116 wide, else the safe
        # 42/28), and the list is split into two pages (P = other page) with
        # room to grow past 19 items.
        $ggNameW = 42; $ggStatW = 28
        try { if ($Host.UI.RawUI.WindowSize.Width -ge 116) { $ggNameW = 63; $ggStatW = 38 } } catch {}
        $ggBorder = "  +" + ("-" * ($ggNameW + 2)) + "+" + ("-" * ($ggStatW + 2)) + "+"
        if (-not $script:ChecklistPage) { $script:ChecklistPage = 1 }
        $ggPageItems = if ($script:ChecklistPage -eq 1) { $Settings | Where-Object { $_.ID -le 10 } } else { $Settings | Where-Object { $_.ID -ge 11 } }
        Write-Host $ggBorder -ForegroundColor White
        Write-Host ("  | " + "GatewayGuard Security Hardening v$ScriptVersion".PadRight($ggNameW) + " | " + ("Console -- PAGE $($script:ChecklistPage) of 2").PadRight($ggStatW) + " |") -ForegroundColor White
        Write-Host $ggBorder -ForegroundColor White
        Write-Host ("  | " + "Setting".PadRight($ggNameW) + " | " + "Status".PadRight($ggStatW) + " |") -ForegroundColor White
        Write-Host $ggBorder -ForegroundColor White

        foreach ($s in $ggPageItems) {
            $chk      = if ($s.Selected) { "[X]" } else { "[ ]" }
            $auto     = if (-not $s.CanAuto) { "*" } elseif ($s.RequiresAdmin -and -not $global:IsAdmin) { "!" } else { "" }
            $nameStr  = ("{0} {1,2}. {2}" -f $chk, $s.ID, ($s.Name + $auto))
            # FT-32 (2026-07-12): long text was being cut off with no warning
            # (field: items 3,5,6,7,12,13,14,17 looked garbled). Cuts are now
            # marked with ".." and the legend explains where the full text is.
            $nameStr  = if ($nameStr.Length -gt $ggNameW) { $nameStr.Substring(0, $ggNameW - 2) + ".." } else { $nameStr.PadRight($ggNameW) }
            $statusStr = if ($s.Status.Length -gt $ggStatW) { $s.Status.Substring(0, $ggStatW - 2) + ".." } else { $s.Status.PadRight($ggStatW) }
            $statusColor = if ($s.Status -match "GOOD") { "Green" }
                           elseif ($s.Status -match "needs attention|OFF --") { "Yellow" }
                           elseif ($s.Status -match "ERROR|risk") { "Red" }
                           else { "Gray" }
            $nameColor = if ($s.SecurityCritical -and -not $s.Selected -and $s.Status -notmatch "GOOD|N/A|ENCRYPTED|primary") { "Red" } else { "White" }
            Write-Host "  | " -ForegroundColor White -NoNewline
            Write-Host $nameStr -ForegroundColor $nameColor -NoNewline
            Write-Host " | " -ForegroundColor White -NoNewline
            Write-Host $statusStr -ForegroundColor $statusColor -NoNewline
            Write-Host " |" -ForegroundColor White
        }

        Write-Host $ggBorder -ForegroundColor White
        Write-Host ""
        Write-Host ("  Showing items $(if ($script:ChecklistPage -eq 1) { '1-10. Press P to see items 11-19.' } else { '11-19. Press P to see items 1-10.' }) Selections on BOTH pages count.") -ForegroundColor Yellow
        Write-Host "  * = Manual action only   ! = Requires admin   [X] = Will be applied" -ForegroundColor DarkGray
        Write-Host "  .. = text shortened to fit -- the full status appears on that item's" -ForegroundColor DarkGray
        Write-Host "       own screen when it runs (and in your log file)" -ForegroundColor DarkGray
        Write-Host "  Green = Already correct   Yellow = Needs attention   Red = Security risk" -ForegroundColor DarkGray
        Write-Host ""
        Write-Host "  Commands:" -ForegroundColor Yellow
        Write-Host "    R = Run selected items     [number] = toggle item on/off" -ForegroundColor Yellow
        Write-Host "    A = Select all             N = Deselect all    Q = Quit" -ForegroundColor Yellow
        Write-Host "    P = show the other page of the list" -ForegroundColor Yellow
        Write-Host ""

        # Main command input -- special handler for R/A/N/Q + multi-digit numbers
        # BUGFIX ascii23 (2026-07-10, FT-01): these two ReadKey calls had NO
        # try/catch, unlike every other ReadKey in the script. If ReadKey
        # throws (observed when the console loses/regains focus, e.g. after
        # Alt-Tab), this was an UNCAUGHT terminating error -- which ends the
        # whole script. This is very likely the real cause of "session ends
        # unexpectedly" reported multiple times on this exact screen (the
        # main checklist, where users spend the most time and are most
        # likely to Alt-Tab away to check something). Now wrapped with the
        # same safe fallback pattern already used in Read-ValidKey/Pause-ForUser.
        Write-Host "  Enter command (R/A/N/Q/P or item number 1-19): " -ForegroundColor White -NoNewline
        $userInput = ""
        $firstKey = $null   # FT-69 (ascii29): never test a stale key object
        # FT-46 (ascii28): re-assert Ctrl+C-as-input before every read
        try { [Console]::TreatControlCAsInput = $true } catch {}
        try {
            $firstKey = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            $firstCh = $firstKey.Character.ToString().ToUpper()
        } catch {
            Write-Log -Message "ReadKey failed (focus loss?) -- falling back to Read-Host: $_" -Status "WARN"
            $fallbackInput = (Read-Host).ToUpper().Trim()
            $firstCh = if ($fallbackInput.Length -gt 0) { $fallbackInput.Substring(0,1) } else { "" }
        }

        # FT-69 (ascii29): Ctrl+C opens the exit confirmation
        if ($firstKey -and $firstKey.Character -eq [char]3) { Invoke-CtrlCExit; continue checklistLoop }

        if ($firstCh -in @("R","A","N","Q","P")) {
            $userInput = $firstCh
            Write-Host $userInput -ForegroundColor Cyan
        } elseif ($firstCh -match "[1-9]") {
            Write-Host $firstCh -ForegroundColor Cyan -NoNewline
            # Could be 1-9 or start of 10-19
            try {
                $secondKey = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
                $secondCh = $secondKey.Character.ToString()
                $secondVK = $secondKey.VirtualKeyCode
            } catch {
                Write-Log -Message "ReadKey failed on second digit (focus loss?) -- treating as Enter: $_" -Status "WARN"
                $secondCh = ""
                $secondVK = 13
            }
            if ($secondCh -match "[0-9]") {
                $userInput = "$firstCh$secondCh"
                Write-Host $secondCh -ForegroundColor Cyan
            } elseif ($secondVK -in @(13,32)) {
                # Enter or Space after single digit
                $userInput = $firstCh
                Write-Host ""
            } else {
                $userInput = $firstCh
                Write-Host ""
            }
        } else {
            $userInput = ""  # Invalid -- swallow silently
            Write-Host ""
        }

        switch ($userInput.ToUpper()) {
            "P" { $script:ChecklistPage = if ($script:ChecklistPage -eq 1) { 2 } else { 1 } }
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

                # FT-67 (ascii29): dedicated BitLocker decision flow --
                # only when the drive is NOT encrypted and item 8 is
                # not selected. N at either screen returns here so the
                # user can type 8 and select it.
                $blItem = $Settings | Where-Object { $_.ID -eq 8 } | Select-Object -First 1
                if ($blItem -and -not $blItem.Selected -and $blItem.Status -match "NOT Encrypted") {
                    $blDecision = Show-BitLockerDeclineHeadsUp
                    if ($blDecision -eq "GoBack") {
                        Write-Host ""
                        Write-Host "  Back at the checklist -- type 8 to select Drive Encryption." -ForegroundColor Cyan
                        Pause-ForUser "  Press Enter or Space to return to the checklist..."
                        continue checklistLoop
                    }
                }

                Clear-Host
                Write-Host ""
                Draw-Box -Color White -Lines @(
                    "  REVIEW YOUR SELECTIONS -- NO CHANGES MADE YET           ",
                    "---",
                    "  Items marked [X] WILL be applied.                       ",
                    "  Items marked [ ] will be SKIPPED.                       ",
                    "  BitLocker (if selected) is always handled last.         "
                )
                Write-Host ""
                # Group items for clarity: WILL APPLY / ALREADY GOOD / SKIPPED
                Write-Host "  WILL BE APPLIED:" -ForegroundColor White
                $applyItems = $Settings | Where-Object { $_.Selected }
                if ($applyItems) {
                    foreach ($s in $applyItems) {
                        $statusShort = [string]$s.Status; if ($statusShort.Length -gt 28) { $statusShort = $statusShort.Substring(0,28) }   # FT-68 (ascii29): [string] guard
                        Write-Host ("  [X] APPLYING  {0,2}. {1,-38} {2}" -f $s.ID, $s.Name, $statusShort) -ForegroundColor White
                    }
                } else {
                    Write-Host "  (none selected)" -ForegroundColor DarkGray
                }
                Write-Host ""
                Write-Host "  ALREADY GOOD -- no change needed:" -ForegroundColor Green
                $goodItems2 = $Settings | Where-Object { -not $_.Selected -and $_.Status -match "-- GOOD|ENCRYPTED -- GOOD|ALL ON -- GOOD|N/A on Home" }
                if ($goodItems2) {
                    foreach ($s in $goodItems2) {
                        $statusShort = [string]$s.Status; if ($statusShort.Length -gt 28) { $statusShort = $statusShort.Substring(0,28) }   # FT-68 (ascii29): [string] guard
                        Write-Host ("  [ ] GOOD      {0,2}. {1,-38} {2}" -f $s.ID, $s.Name, $statusShort) -ForegroundColor Green
                    }
                }
                Write-Host ""
                $critSkipped = $Settings | Where-Object { -not $_.Selected -and $_.Status -notmatch "-- GOOD|ENCRYPTED|ALL ON|N/A" -and $_.SecurityCritical }
                if ($critSkipped) {
                    Write-Host "  SECURITY RISK -- deselected:" -ForegroundColor Red
                    foreach ($s in $critSkipped) {
                        Write-Host ("  [ ] !! RISK   {0,2}. {1}" -f $s.ID, $s.Name) -ForegroundColor Red
                    }
                    Write-Host ""
                }
                Write-Host ""
                Write-Host "  $selectedCount item(s) will be applied. Y/N prompt shown for each." -ForegroundColor Yellow
                Write-Host ""
                Write-Log -Message "Review listing rendered -- awaiting Ready-to-proceed" -Status "INFO"   # FT-68 (ascii29): brackets the listing loop in the log

                do {
                    $finalCheck = Read-ValidKey -ValidKeys @("Y","N","Q") -Prompt "Ready to proceed? (Y = Start / N = Go back / Q = Quit): "
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
                        $goodResp = Read-ValidKey -ValidKeys @("Y","N","B") -Prompt "Choice (Y = Re-apply / N = Skip / B = Back): "
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
                                $warnResp = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue and change this setting? (Y = Yes I understand / N = Cancel): "
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
                    $confirm = Read-ValidKey -ValidKeys @("Y","N","B") -Prompt "Apply? (Y = Yes / N = Skip / B = Back): "
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
                    Draw-Box -Color White -Lines @(
                        "  ALREADY CORRECT -- AUTO-SKIPPED ($($goodItems.Count) items)            ",
                        "---",
                        "  These settings were already at the recommended state     ",
                        "  and did not need to be changed:                          "
                    )
                    foreach ($item in $goodItems) {
                        Write-Host "  OK  $($item.ID). $($item.Name) -- $($item.Status)" -ForegroundColor Green
                    }
                    Write-Host ""
                    $changeGood = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Want to review or change any of these? (Y/N): "
                    if ($changeGood.ToUpper() -eq "Y") {
                        foreach ($item in $goodItems) {
                            Write-Host ""
                            Write-Host "  $($item.ID). $($item.Name)" -ForegroundColor White
                            Write-Host "  Status: $($item.Status)" -ForegroundColor Green
                            Write-Host "  Description: $($item.Description)" -ForegroundColor Gray
                            $reapply = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Force re-apply anyway? (Y/N): "
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
                Draw-Box -Color White -Lines @(
                    "  ALL SELECTED ITEMS PROCESSED                           ",
                    "  Log saved to C:\GatewayGuard\Logs\.                          ",
                    "  See manual steps below for items needing your action.  "
                )
                Setup-ScheduledTasks
                Show-ConvenienceReview   # FT-70 (ascii29): was called twice back-to-back -- deduped
                Show-ManualSteps
                Disable-SleepPrevention
                Restore-ScreenSaver
                Save-Log
                Set-FirstRunComplete
                Pause-ForUser "  Press Enter or Space to exit..."
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
    $form.Text    = "GatewayGuard -- Windows 11 Security Hardening Tool v$ScriptVersion -- $global:WinEditionFriendly"
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
    $lblNote.Text = "Select settings to apply. No changes made without approval. Log saved to C:\GatewayGuard\Logs\ after run."
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

    # BUGFIX ascii23 (2026-07-10): with ~20 rows x 6 controls each (~120+
    # child controls) inside a scrollable panel, WinForms can visibly
    # flicker, go blank, or freeze during scroll without double-buffering
    # and layout suspension. DoubleBuffered is a protected property, so it
    # needs reflection to set from PowerShell.
    try {
        $dbFlags = [System.Reflection.BindingFlags]::SetProperty -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::NonPublic
        $panel.GetType().InvokeMember("DoubleBuffered", $dbFlags, $null, $panel, @($true)) | Out-Null
    } catch {}
    $panel.SuspendLayout()

    foreach ($col in @(
        @{Text="Select"; X=5; W=50},
        @{Text="Setting (click row for details)"; X=60; W=530},
        @{Text="Current Status"; X=605; W=245}
    )) {
        $lbl = New-Object System.Windows.Forms.Label
        $lbl.Text = $col.Text
        $lbl.Font = New-Object System.Drawing.Font("Garamond", 11, [System.Drawing.FontStyle]::Bold)
        $lbl.ForeColor = [System.Drawing.Color]::FromArgb(0,180,255)
        $lbl.Location = New-Object System.Drawing.Point($col.X, 5)
        $lbl.Size = New-Object System.Drawing.Size($col.W, 22)
        $panel.Controls.Add($lbl)
    }

    # Shared tooltip control -- shows Description + Guide Reference on hover.
    # Long AutoPopDelay so it stays up long enough to actually read.
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.AutoPopDelay = 15000
    $tooltip.InitialDelay = 400
    $tooltip.ReshowDelay = 200
    $tooltip.IsBalloon = $true

    $checkboxes = @{}
    $yPos = 28
    # DIAGNOSTIC (2026-07-10): if the yPos bug recurs, this will tell us
    # exactly what it actually is at the moment of first use, instead of
    # guessing from a downstream error message.
    Write-Log -Message "DIAG: yPos initialized as type $($yPos.GetType().FullName), value=$yPos, count=$(@($yPos).Count)" -Status "INFO"

    foreach ($s in $Settings) {
        $isSkipped = ($s.SkipOnHome -and ($global:WinEdition -notmatch "Pro|Enterprise|Education")) -or ($s.RequiresAdmin -and -not $global:IsAdmin)

        $rowBg = New-Object System.Windows.Forms.Panel
        # BUGFIX ascii23 (2026-07-09): $yPos was intermittently becoming
        # System.Object[] instead of a scalar int, causing "op_Subtraction
        # not found" crashes. Root cause not pinned down via static review --
        # forcing an explicit [int] cast here makes the crash structurally
        # impossible regardless of cause, and will throw a clearer error
        # pointing at the real culprit if something upstream is still wrong.
        if (@($yPos).Count -gt 1) {
            Write-Log -Message "DIAG: yPos CORRUPTED at row for '$($s.Name)' -- type=$($yPos.GetType().FullName) value=$($yPos -join ',')" -Status "WARN"
        }
        # UX REDESIGN (2026-07-10): rows now show only Name + Status, in much
        # larger text. Description and Guide Reference are no longer always
        # visible -- shown via a hover tooltip AND a click popup (both, since
        # hover alone isn't discoverable for everyone). Row height shrunk from
        # 56 to 40 accordingly.
        $rowBg.Location = New-Object System.Drawing.Point(0, ([int]@($yPos)[0] - 2))
        $rowBg.Size = New-Object System.Drawing.Size(848, 40)
        $rowBg.BackColor = if ($isSkipped) { [System.Drawing.Color]::FromArgb(35,35,35) } elseif ($s.ID % 2 -eq 0) { [System.Drawing.Color]::FromArgb(38,38,38) } else { [System.Drawing.Color]::FromArgb(28,28,28) }
        $rowBg.Cursor = [System.Windows.Forms.Cursors]::Hand
        $panel.Controls.Add($rowBg)

        $cb = New-Object System.Windows.Forms.CheckBox
        $cb.Checked = $s.Selected -and -not $isSkipped
        $cb.Enabled = -not $isSkipped
        $cb.Location = New-Object System.Drawing.Point(15, 9)
        $cb.Size = New-Object System.Drawing.Size(22, 22)
        $cb.Tag = $s.ID
        $rowBg.Controls.Add($cb)
        $checkboxes[$s.ID] = $cb

        $nameText = "$($s.ID). $($s.Name)$(if (-not $s.CanAuto) { ' *' })$(if ($isSkipped) { ' [UNAVAILABLE]' })"
        $lblName = New-Object System.Windows.Forms.Label
        $lblName.Text = $nameText
        $lblName.Font = New-Object System.Drawing.Font("Garamond", 13, [System.Drawing.FontStyle]::Bold)
        $lblName.ForeColor = if ($isSkipped) { [System.Drawing.Color]::DimGray } else { [System.Drawing.Color]::White }
        $lblName.Location = New-Object System.Drawing.Point(45, 7)
        $lblName.Size = New-Object System.Drawing.Size(545, 26)
        $lblName.Cursor = [System.Windows.Forms.Cursors]::Hand
        $rowBg.Controls.Add($lblName)

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
        $lblStat.Font = New-Object System.Drawing.Font("Garamond", 12, [System.Drawing.FontStyle]::Bold)
        $lblStat.ForeColor = $statusColor
        $lblStat.Location = New-Object System.Drawing.Point(600, 9)
        $lblStat.Size = New-Object System.Drawing.Size(245, 24)
        $rowBg.Controls.Add($lblStat)

        # Hover tooltip -- attach to row, name, and status so it works no
        # matter where on the row the cursor lands.
        $detailText = "$($s.Description)`n`nGuide: $($s.GuideRef)"
        $tooltip.SetToolTip($rowBg, $detailText)
        $tooltip.SetToolTip($lblName, $detailText)
        $tooltip.SetToolTip($lblStat, $detailText)

        # Click popup -- more discoverable than hover for many users.
        # Attached to row, name, and status labels so clicking anywhere on
        # the row works, not just an exact pixel-perfect spot.
        $detailPopupHandler = {
            [System.Windows.Forms.MessageBox]::Show(
                "$($s.Description)`n`nGuide reference: $($s.GuideRef)",
                "$($s.ID). $($s.Name)",
                "OK", "Information"
            ) | Out-Null
        }.GetNewClosure()
        $rowBg.Add_Click($detailPopupHandler)
        $lblName.Add_Click($detailPopupHandler)
        $lblStat.Add_Click($detailPopupHandler)

        $yPos = [int](@($yPos)[0]) + 44
    }

    $panel.ResumeLayout($true)

    $lblLegend = New-Object System.Windows.Forms.Label
    $lblLegend.Text = "* = Manual action required    UNAVAILABLE = Not supported on this edition or requires admin"
    $lblLegend.Font = New-Object System.Drawing.Font("Garamond", 8, [System.Drawing.FontStyle]::Italic)
    $lblLegend.ForeColor = [System.Drawing.Color]::Silver
    $lblLegend.Location = New-Object System.Drawing.Point(45, ([int](@($yPos)[0]) + 4))
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
# 0. Resume check  1. Opening/maximize/scroll (UX-01,02,03)  2. Font instructions
# 3. Company PC warning  4. Domain check  5. Admin check
# 6. Edition detection  7. RAM check  8. Time/date check (UX-08)
# 9. System Baseline Summary (UX-10)  10. First run  11. Pre-scan gate
# 12. Defender AV check  13. Power check  14. Power settings  15. Apps audit
# Then: mode selection -> Run-ConsoleMode or Run-GUIMode
# BitLocker is always LAST inside the mode functions
# ============================================================
# FT-66 (ascii29): GLOBAL ERROR TRAP. Both 7/13 sessions died with NO
# error line in the log -- a terminating error closes the console window
# instantly when launched from the .bat, so the crash is invisible and
# the log's last line is just whatever screen rendered last. The entire
# main flow now runs inside one try/catch: any unhandled error is
# written to the log with its location and stack trace, the log footer
# is saved, cleanup runs, and the window STAYS OPEN so the user (and
# the field-test log) can see exactly what happened.
try {

# FT-26 (2026-07-11): hardware queries below take 3-5 seconds on some PCs.
# Show something IMMEDIATELY so the user knows the tool is alive.
Clear-Host
Write-Host ""
Write-Host "  Please wait -- checking your system..." -ForegroundColor Cyan

# FT-19 (2026-07-11): identify the machine BEFORE anything renders or logs,
# so the launch header and the log header both carry it from line one.
Get-MachineIdentity

Clear-Host
Write-Host ""
Write-Host "  GatewayGuard Windows 11 Security Hardening Tool v$ScriptVersion -- $BuildID" -ForegroundColor DarkGray
Write-Host "  File: $(Split-Path -Leaf $PSCommandPath)" -ForegroundColor DarkGray
Write-Host "  This PC: $global:MachineMake $global:MachineModel  |  Machine ID: $global:MachineID" -ForegroundColor DarkGray
Write-Host "  $(Get-Date -Format 'yyyy-MM-dd HH:mm')" -ForegroundColor DarkGray
Write-Host ""
Initialize-LogFile
# FT-63 (ascii28): the log FILENAME is stamped in the first instant of
# launch; this header moments later. The 7/12 logs showed an 84-minute gap
# between the two -- the console was frozen in text-selection (Mark) mode,
# which pauses the program whenever it writes. Make that self-diagnosing.
try {
    $ggLaunchStamp = [datetime]::ParseExact((([System.IO.Path]::GetFileNameWithoutExtension($LogPath)) -replace '^GatewayGuard-Log-',''), 'yyyy-MM-dd_HH-mm', $null)
    $ggInitDelaySec = ((Get-Date) - $ggLaunchStamp).TotalSeconds
    if ($ggInitDelaySec -gt 60) {
        Write-Log -Message ("FT-63: startup was delayed {0:N0} minute(s) between launch and initialization -- console was likely frozen in text-selection (Mark) mode; Esc releases it" -f ($ggInitDelaySec/60)) -Status "WARN"
    }
} catch {}
Write-Log -Message "Tool launched v$ScriptVersion build $BuildID" -Status "START"
Write-Log -Message "Machine: $global:MachineMake $global:MachineModel | MachineID: $global:MachineID" -Status "INFO"

# FT-01 mitigation (2026-07-11): kill console QuickEdit for this session --
# a click back into the window was pausing the program and eating keys.
Disable-QuickEdit

# FT-24 (2026-07-11): with QuickEdit off, Ctrl+C sends a BREAK signal that
# instantly terminates the program (field-confirmed: tester pressed Ctrl+C
# to copy a screen and the tool died). Treat Ctrl+C as ordinary input
# instead -- the key prompts simply ignore it.
try { [Console]::TreatControlCAsInput = $true } catch {}

# Detect admin status IMMEDIATELY -- must happen before Show-FontInstructions,
# which checks $global:IsAdmin. (BUGFIX ascii23: this used to run too late,
# so the "run as Administrator" warning showed even when already elevated.)
$global:IsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")

# Activate sleep/screen prevention immediately -- before any screen is shown
Enable-SleepPrevention
Suspend-ScreenSaver

# 0. Resume check (UX-05, UX-06) -- must happen before anything else renders
Show-ResumePrompt

# 1-2. Intro sequence (FT-04 order, 2026-07-11): Welcome/maximize -> scroll
# -> font setup -> window setup -> overview, with B = Back navigation
# (FT-18). Skipped entirely if resuming -- the user has already seen it.
if (-not $global:ResumeFrom) {
    Show-FontInstructions
    # FT-41/45 (ascii28): scroll & copy instructions, incl. the Mark-mode
    # pause behavior (FT-63)
    Show-ScrollCopyTip
}

# 3-5. Computer / domain / admin checks. FT-47 (ascii28): on RESUME these
# used to replay as full flashing screens -- one quiet re-check screen now.
# Fresh runs still get the full sequence.
if ($global:ResumeFrom) {
    Show-ResumeReverify
} else {
    Test-PersonalComputer
    Test-DomainJoin
    Test-AdminAccess
}

# 6. Edition detection (WMI ONLY -- no Get-WindowsEdition)
Get-WinEdition

# 7. RAM check
Get-RAMStatus

# 8. Time & date sync check (UX-08) -- skip if already done before reboot
if (-not (Test-CheckpointReached -Checkpoint "Baseline")) {
    Test-TimeDateSync
}

# 9. System Baseline Summary (UX-10) -- Step 0 concept, shown once up front
if (-not (Test-CheckpointReached -Checkpoint "Baseline")) {
    Show-SystemBaselineSummary
    Save-Checkpoint -Checkpoint "Baseline"
}

# 10. First run flag
Test-FirstRun

# 11. Pre-scan gate -- now a real automated flow (UX-04,05,06,07,09,11),
# replaces ascii22's old manual-instructions-only version.
if (-not (Test-CheckpointReached -Checkpoint "OfflineScanDone")) {
    Show-PreScanGate
}

# 11b. Malwarebytes detect-and-launch (UX-06 standalone checkpoint)
if (-not (Test-CheckpointReached -Checkpoint "Malwarebytes")) {
    Show-MalwarebytesFollowUp
    Save-Checkpoint -Checkpoint "Malwarebytes"
}

# 12. Defender primary AV check
if (-not (Test-CheckpointReached -Checkpoint "DefenderAV")) {
    Test-DefenderPrimary
    Save-Checkpoint -Checkpoint "DefenderAV"
}

# 13. Power check and sleep prevention (FT-47: a resume already did this
# quietly inside Show-ResumeReverify)
if (-not $global:ResumeFrom) { Test-PowerStatus }

# 14. Power settings review
if (-not (Test-CheckpointReached -Checkpoint "PowerSettings")) {
    Run-PowerSettingsCheck
    Save-Checkpoint -Checkpoint "PowerSettings"
}

# 15. Apps audit
if (-not (Test-CheckpointReached -Checkpoint "AppsAudit")) {
    Run-AppsAudit
    Save-Checkpoint -Checkpoint "AppsAudit"
}

# Mode selection (FT-64, ascii28: wrapped in a function so the key log names
# the screen -- it used to print the script filename as the location)
function Select-Mode {
    Show-ModeSelector
    do {
        $smChoice = Read-ValidKey -ValidKeys @("1","2","3") -Prompt "Enter choice (1, 2, or 3): "
    } while ($smChoice -notin "1","2","3")
    return $smChoice
}
$choice = Select-Mode

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


# FT-66 (ascii29): global error trap -- see comment at try above
} catch {
    try {
        Write-Log -Message ("UNHANDLED ERROR: " + $_.Exception.Message) -Status "ERROR"
        Write-Log -Message ("Location: " + (($_.InvocationInfo.PositionMessage -split "\r?\n")[0])) -Status "ERROR"
        Write-Log -Message ("Stack: " + $_.ScriptStackTrace) -Status "ERROR"
    } catch {}
    try { Save-Log } catch {}
    try { Disable-SleepPrevention } catch {}
    try { Restore-ScreenSaver } catch {}
    Write-Host ""
    Write-Host "  Something went wrong and the program cannot continue." -ForegroundColor Red
    Write-Host "  The details were saved to your log file:" -ForegroundColor Yellow
    Write-Host "  $LogPath" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  Press Enter or Space to close this window..." -ForegroundColor White
    try { do { $ggErrKey = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") } while ($ggErrKey.VirtualKeyCode -notin @(13, 32)) } catch { $null = Read-Host }
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
