<!-- Dated: 2026-07-28 10:03 EDT -->
# GatewayGuard -- Screen Contents, In Order

- **Document Name:** GatewayGuard_ScreenContents
- **Last Modified:** 2026-07-28 10:03 EDT
- **Build:** `W11-SecurityHardening-v3-ascii36-2026-07-27-1655.ps1`
- **Status:** Working document. Plain Markdown per CLAUDE.md scope exception.
- **Companion to:** `GatewayGuard_ScreenInventory-2026-07-28-1003.md`
- **Supersedes:** nothing. First screen-contents document for the project.
- **Change History Log:**
  - 2026-07-28 10:03: Initial extraction. All 56 Draw-Box screens, verbatim
    from source, in user-journey order.

---

## WHAT THIS IS

The second half of field note 3 (2026-07-27): *"a digital document listing
all screens in order and then showing all screens in order."*

The companion inventory document is the **list**. This is the **screens** --
every box, in the order the user meets them, with its content exactly as it
appears in the source.

## HOW THE TWO DOCUMENTS DIVIDE

To stop them drifting apart, each owns different facts:

| Fact | Lives in |
|---|---|
| Journey position, render conditions, proposed IDs, analysis | **Inventory** |
| Actual screen content, function, line range, current log ID | **This document** |

If a screen's render condition changes, update the inventory. If its wording
changes, update this one. Screens are numbered identically in both.

## READING NOTES

- Content is extracted **verbatim** from the source, including the
  `Draw-Box -Lines @(` wrapper, so each block can be located and edited
  directly. Line ranges are given for exactly that purpose.
- `"---"` inside a box is a horizontal rule drawn by `Draw-Box`, not text.
- PowerShell variables are shown **unexpanded** -- `$($global:RAMGB)` renders
  as the actual number at runtime. Anything in `$(...)` is filled in live.
- Trailing spaces inside box strings are load-bearing: they pad each line to
  the box width. They have been preserved.
- Screens are mutually exclusive where noted in the inventory. A single run
  will never show all 56 -- the Defender block alone has six alternatives of
  which exactly one fires.

## KNOWN GAP

`Run-GUIMode` (mode 2, lines 5593-6075) is **not** included. Every field log
to date uses mode 1 (Console). GUI mode needs its own extraction pass before
this document is complete. Flagged rather than silently omitted.

---

# PHASE -- PRE-FLIGHT

## 1. WELCOME BACK

**Function:** `Show-ResumePrompt`  |  **Line:** 1521-1530  |  **Log ID:** SCREEN-25

```text
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
```

## 2. IMPORTANT -- HOW TO RUN GATEWAYGUARD CORRECTLY

**Function:** `Show-FontInstructions`  |  **Line:** 1035-1056  |  **Log ID:** SCREEN-01

```text
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
```

## 3. FONT CHECK: If this box has clean lines, you are ready.

**Function:** `Show-FontInstructions`  |  **Line:** 1111-1115  |  **Log ID:** (none - unnumbered)

```text
            Draw-Box -Color White -Lines @(
                "  FONT CHECK: If this box has clean lines, you are ready.   ",
                "  +--+  Good: straight lines and corners                    ",
                "  |  |  Good: text is a comfortable reading size            "
            )
```

## 4. BEFORE YOU START -- WINDOW SETUP  (Screen 4 of 5)

**Function:** `Show-FontInstructions`  |  **Line:** 1118-1151  |  **Log ID:** (none - unnumbered)

```text
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
```

## 5. WHAT HAPPENS NEXT -- PLEASE READ  (Screen 5 of 5)

**Function:** `Show-FontInstructions`  |  **Line:** 1154-1180  |  **Log ID:** (none - unnumbered)

```text
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
```

## 6. HOW TO SCROLL BACK (AND COPY) IN THIS WINDOW

**Function:** `Show-ScrollCopyTip`  |  **Line:** 1623-1645  |  **Log ID:** (none - unnumbered)

```text
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
```

## 7. QUICK RE-CHECK BEFORE RESUMING

**Function:** `Show-ResumeReverify`  |  **Line:** 1568-1575  |  **Log ID:** (none - unnumbered)

```text
    Draw-Box -Color White -Lines @(
        "  QUICK RE-CHECK BEFORE RESUMING                            ",
        "---",
        "  Because you're resuming, we re-verify the basics on this   ",
        "  ONE screen instead of replaying each earlier screen:       ",
        "  your personal-PC answer, Administrator access, and         ",
        "  power/battery state.                                       "
    )
```

## 8. !  IMPORTANT -- READ BEFORE CONTINUING

**Function:** `Test-PersonalComputer`  |  **Line:** 1207-1231  |  **Log ID:** (none - unnumbered)

```text
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
```

## 9. !  THIS PC APPEARS TO BE DOMAIN-JOINED

**Function:** `Test-DomainJoin`  |  **Line:** 1264-1279  |  **Log ID:** (none - unnumbered)

```text
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
```

## 10. !  ADMINISTRATOR ACCESS REQUIRED

**Function:** `Test-AdminAccess`  |  **Line:** 1307-1326  |  **Log ID:** (none - unnumbered)

```text
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
```

## 11. WINDOWS EDITION DETECTED

**Function:** `Get-WinEdition`  |  **Line:** 1387-1395  |  **Log ID:** (none - unnumbered)

```text
        Draw-Box -Color White -Lines @(
            "  WINDOWS EDITION DETECTED                                          ",
            "---",
            "  Edition: $global:WinEditionFriendly                              ",
            "                                                                    ",
            "  Remote Desktop hosting is not available on Home Edition.          ",
            "  BitLocker uses Device Encryption on Home -- handled               ",
            "  automatically by this tool.                                       "
        )
```

## 12. YOUR PC -- RAM: $($global:RAMGB) GB

**Function:** `Get-RAMStatus`  |  **Line:** 1417-1427  |  **Log ID:** (none - unnumbered)

```text
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
```

## 13. !  TIME/DATE SYNC ISSUE DETECTED

**Function:** `Test-TimeDateSync`  |  **Line:** 1667-1675  |  **Log ID:** (none - unnumbered)

```text
            Draw-Box -Color White -Lines @(
                "  !  TIME/DATE SYNC ISSUE DETECTED                          ",
                "---",
                "  Your computer's automatic time or time zone setting is    ",
                "  turned off. This can affect Windows Update, security      ",
                "  certificates, and scheduled scans.                        ",
                "                                                            ",
                "  GatewayGuard will turn these back on now.                 "
            )
```

## 14. FIX THE TIME NOW?

**Function:** `Test-TimeDateSync`  |  **Line:** 1708-1713  |  **Log ID:** (none - unnumbered)

```text
            Draw-Box -Color Yellow -Lines @(
                "  FIX THE TIME NOW?                                         ",
                "---",
                "  GatewayGuard can open Windows' own Date & Time settings   ",
                "  so you can correct it, then come right back here.         "
            )
```

## 15. ** If any lines above look cut off, SCROLL UP to see them:

**Function:** `Show-SystemBaselineSummary`  |  **Line:** 1824-1884  |  **Log ID:** (none - unnumbered)

```text
    Draw-Box -Color White -Lines $lines
    Write-Host ""
    # FT-83 (ascii32): three baseline lines were hidden below the fold with a
    # live-but-invisible prompt. Explicit scroll notice added before the prompt.
    Write-Host "  ** If any lines above look cut off, SCROLL UP to see them:" -ForegroundColor Yellow
    Write-Host "     press Alt+Spacebar, then E, then M, then use the Up/Down" -ForegroundColor Yellow
    Write-Host "     arrow keys. Press Esc when done -- the tool will continue." -ForegroundColor Yellow
    Write-Host ""
    Write-Log -Message "System Baseline Summary displayed" -Status "INFO"
    Write-Log -Message "[SCREEN-09] Rendered: System Baseline Summary" -Status "SCREEN"
    Pause-ForUser "  Press Enter or Space to continue..."
}

# ============================================================
# STEP 7: PRE-SCAN GATE
# ============================================================
# ============================================================
# SCREEN-26 + SCREEN-27: SECURITY TOOLS BRIEFING (D-06, ascii33)
# Plain-English introduction to Defender + Malwarebytes + the scan
# plan BEFORE any scan screens. Includes D-13 (log location told
# early), the 14-day trial explanation, and the field-verified
# rootkit/Custom Scan guidance (2026-07-19, all three machines).
# ============================================================
function Show-SecurityToolsBriefing {
    Clear-Host
    Write-Host ""
    Show-StepHeader -Key "Briefing1" -Section "Scans"
    Write-Log -Message "[SCREEN-26] Rendered: Your Security Tools (briefing 1 of 2)" -Status "SCREEN"
    Draw-Box -Color White -Lines @(
        "  YOUR PC'S SECURITY TOOLS -- A QUICK INTRODUCTION           ",
        "---",
        "  Before we change anything, here is what protects your PC   ",
        "  and how the pieces fit together.                           ",
        "                                                             ",
        "  WINDOWS DEFENDER (already on your PC)                      ",
        "  Windows comes with a built-in antivirus called Microsoft   ",
        "  Defender. It is free, already installed, and watches your  ",
        "  PC in real time -- every file you open, every download,    ",
        "  every program you run. GatewayGuard will make sure it is   ",
        "  set up correctly.                                          ",
        "                                                             ",
        "  MALWAREBYTES (we recommend adding it)                      ",
        "  Malwarebytes is a separate free program that works         ",
        "  alongside Defender. Defender watches in real time;         ",
        "  Malwarebytes runs deeper scans when you ask for one --     ",
        "  looking for threats that hide from real-time scanners.     ",
        "  They work together without conflict.                       ",
        "                                                             ",
        "  ABOUT THE 14-DAY TRIAL (important -- please read)          ",
        "  When you first install Malwarebytes, it starts a free      ",
        "  14-day trial of the paid version. After 14 days the trial  ",
        "  ends BY ITSELF -- you do not need to do anything, and      ",
        "  nothing breaks. Malwarebytes switches to its free mode,    ",
        "  Defender takes back real-time protection, and the deeper   ",
        "  scans stay available to you permanently, at no cost.       ",
        "                                                             ",
        "  YOUR RECORDS                                               ",
        "  GatewayGuard keeps a record of everything it does, saved   ",
        "  in C:\GatewayGuard\Logs. If you ever need help, that      ",
        "  file shows exactly what happened on your PC.               "
    )
```

## 16. YOUR PC'S SECURITY TOOLS -- A QUICK INTRODUCTION

**Function:** `Show-SecurityToolsBriefing`  |  **Line:** 1852-1884  |  **Log ID:** SCREEN-26

```text
    Draw-Box -Color White -Lines @(
        "  YOUR PC'S SECURITY TOOLS -- A QUICK INTRODUCTION           ",
        "---",
        "  Before we change anything, here is what protects your PC   ",
        "  and how the pieces fit together.                           ",
        "                                                             ",
        "  WINDOWS DEFENDER (already on your PC)                      ",
        "  Windows comes with a built-in antivirus called Microsoft   ",
        "  Defender. It is free, already installed, and watches your  ",
        "  PC in real time -- every file you open, every download,    ",
        "  every program you run. GatewayGuard will make sure it is   ",
        "  set up correctly.                                          ",
        "                                                             ",
        "  MALWAREBYTES (we recommend adding it)                      ",
        "  Malwarebytes is a separate free program that works         ",
        "  alongside Defender. Defender watches in real time;         ",
        "  Malwarebytes runs deeper scans when you ask for one --     ",
        "  looking for threats that hide from real-time scanners.     ",
        "  They work together without conflict.                       ",
        "                                                             ",
        "  ABOUT THE 14-DAY TRIAL (important -- please read)          ",
        "  When you first install Malwarebytes, it starts a free      ",
        "  14-day trial of the paid version. After 14 days the trial  ",
        "  ends BY ITSELF -- you do not need to do anything, and      ",
        "  nothing breaks. Malwarebytes switches to its free mode,    ",
        "  Defender takes back real-time protection, and the deeper   ",
        "  scans stay available to you permanently, at no cost.       ",
        "                                                             ",
        "  YOUR RECORDS                                               ",
        "  GatewayGuard keeps a record of everything it does, saved   ",
        "  in C:\GatewayGuard\Logs. If you ever need help, that      ",
        "  file shows exactly what happened on your PC.               "
    )
```

## 17. THE SCANS WE RECOMMEND -- AND WHY

**Function:** `Show-ScanPlanBriefing`  |  **Line:** 1894-1926  |  **Log ID:** SCREEN-27

```text
    Draw-Box -Color White -Lines @(
        "  THE SCANS WE RECOMMEND -- AND WHY                          ",
        "---",
        "  Before hardening your settings, we want your PC confirmed  ",
        "  clean. A scan AFTER hardening cannot undo an infection     ",
        "  that is already there.                                     ",
        "                                                             ",
        "  SCAN 1: DEFENDER OFFLINE SCAN (15-20 minutes)              ",
        "  Runs BEFORE Windows loads -- so threats cannot hide the    ",
        "  way they can once Windows is running. Your PC restarts     ",
        "  by itself, scans, and comes back. GatewayGuard picks up    ",
        "  right where you left off.                                  ",
        "                                                             ",
        "  SCAN 2: MALWAREBYTES CUSTOM SCAN (25 min to an hour)       ",
        "  After installing Malwarebytes you will run a Custom Scan   ",
        "  with 'Scan for rootkits' CHECKED and ALL drives selected.  ",
        "  We will give you the exact steps when it is time.          ",
        "                                                             ",
        "  What is a rootkit? One of the sneakiest kinds of           ",
        "  malicious software. It buries itself deep inside Windows   ",
        "  -- deeper than most security programs can see -- then      ",
        "  hides itself, and often hides other malicious programs     ",
        "  too. Your PC can be infected and everything still LOOKS    ",
        "  normal. The Custom Scan looks in the places rootkits hide. ",
        "                                                             ",
        "  LATER, MONTHLY: run that same Custom Scan, then a Deep     ",
        "  Scan overnight. Overnight scans are safe -- Malwarebytes   ",
        "  keeps the PC awake by itself. Just plug in and leave the   ",
        "  lid open; the screen may go dark, the scan keeps going.    ",
        "                                                             ",
        "  Already ran your scans today? You can skip ahead on the    ",
        "  next screen.                                               "
    )
```

## 18. BEFORE WE SCAN YOUR PC

**Function:** `Show-PreScanGate`  |  **Line:** 1946-1962  |  **Log ID:** SCREEN-10

```text
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
```

## 19. DEFENDER OFFLINE SCAN

**Function:** `Show-PreScanGate`  |  **Line:** 2005-2024  |  **Log ID:** (none - unnumbered)

```text
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
```

## 20. REMINDER: PRE-SCAN RECOMMENDED

**Function:** `Show-PreScanGate`  |  **Line:** 2049-2057  |  **Log ID:** (none - unnumbered)

```text
        Draw-Box -Color White -Lines @(
            "  REMINDER: PRE-SCAN RECOMMENDED                             ",
            "---",
            "  This is a repeat run of the hardening tool.                ",
            "  For ongoing protection, run monthly:                       ",
            "  * Malwarebytes scan (GatewayGuard can launch this for you) ",
            "  * Defender Offline Scan quarterly or if issues arise       ",
            "  Guide: Phase 5 -- Scheduled Scanning                       "
        )
```

## 21. WELCOME BACK -- OFFLINE SCAN COMPLETE

**Function:** `Show-PostScanGuidance`  |  **Line:** 2075-2091  |  **Log ID:** (none - unnumbered)

```text
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
```

## 22. !!!!!  CRITICAL SECURITY WARNING  !!!!!

**Function:** `Test-DefenderPrimary`  |  **Line:** 2138-2164  |  **Log ID:** (none - unnumbered)

```text
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
```

## 23. MALWAREBYTES TRIAL IS CURRENTLY HANDLING PROTECTION

**Function:** `Test-DefenderPrimary`  |  **Line:** 2191-2214  |  **Log ID:** (none - unnumbered)

```text
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
```

## 24. OK  ANTIVIRUS STATUS -- HEALTHY SETUP

**Function:** `Test-DefenderPrimary`  |  **Line:** 2254-2271  |  **Log ID:** (none - unnumbered)

```text
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
```

## 25. !  MICROSOFT DEFENDER IS NOT YOUR PRIMARY ANTIVIRUS

**Function:** `Test-DefenderPrimary`  |  **Line:** 2286-2297  |  **Log ID:** (none - unnumbered)

```text
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
```

## 26. ANTIVIRUS STATUS -- MALWAREBYTES IS ON DUTY

**Function:** `Test-DefenderPrimary`  |  **Line:** 2326-2339  |  **Log ID:** (none - unnumbered)

```text
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
```

## 27. !!  DEFENDER REAL-TIME PROTECTION IS OFF

**Function:** `Test-DefenderPrimary`  |  **Line:** 2348-2363  |  **Log ID:** (none - unnumbered)

```text
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
```

## 28. MALWAREBYTES NOT DETECTED

**Function:** `Show-MalwarebytesFollowUp`  |  **Line:** 2400-2406  |  **Log ID:** SCREEN-13

```text
        Draw-Box -Color White -Lines @(
            "  MALWAREBYTES NOT DETECTED                                 ",
            "---",
            "  Malwarebytes Free is a companion scanner that catches      ",
            "  PUPs and adware Defender sometimes misses. It's optional   ",
            "  but recommended -- takes about 5-10 minutes.               "
        )
```

## 29. MALWAREBYTES DETECTED ON THIS PC

**Function:** `Show-MalwarebytesFollowUp`  |  **Line:** 2428-2461  |  **Log ID:** SCREEN-13

```text
        Draw-Box -Color White -Lines @(
            "  MALWAREBYTES DETECTED ON THIS PC                          ",
            "---",
            "  GatewayGuard can open Malwarebytes now. Run the CUSTOM     ",
            "  SCAN -- it is the only scan where YOU control rootkit      ",
            "  checking, and the only one we could verify checks          ",
            "  rootkits (confirmed on our own test machines).             ",
            "                                                             ",
            "  ONE-TIME CHECK FIRST (once Malwarebytes opens):            ",
            "  Click the gear icon (Settings) -> Security -> make sure    ",
            "  'Potentially unwanted items' is set to ALWAYS. This makes  ",
            "  sure junk programs get offered for removal, not just       ",
            "  listed.                                                    ",
            "                                                             ",
            "  HOW TO RUN THE CUSTOM SCAN:                                ",
            "  1. Next to the Scan button, click the three dots           ",
            "     (do NOT click Scan itself -- that runs a quicker scan   ",
            "     that does NOT check rootkits)                           ",
            "  2. Click Advanced Scan, then Custom Scan                   ",
            "  3. CHECK the box 'Scan for rootkits'                       ",
            "  4. CHECK ALL your drives (C:, D:, and any others)          ",
            "  5. Start the scan -- about 25 minutes to an hour           ",
            "                                                             ",
            "  WHEN IT FINISHES -- THIS PART MATTERS:                     ",
            "  If anything was found, click QUARANTINE right then, on     ",
            "  that results screen. If you close it first, Malwarebytes   ",
            "  only keeps a record -- you would have to scan all over     ",
            "  again to remove anything. Finding is not fixing --         ",
            "  quarantining is fixing.                                    ",
            "                                                             ",
            "  Afterward you can confirm rootkits were checked: open the  ",
            "  scan report -- under 'Scan Options' it should say          ",
            "  'Rootkits: Enabled'.                                       "
        )
```

## 30. MALWAREBYTES TRIAL -- WHAT TO EXPECT

**Function:** `Show-MalwarebytesFollowUp`  |  **Line:** 2497-2513  |  **Log ID:** (none - unnumbered)

```text
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
```

## 31. AFTER THE CUSTOM SCAN -- RUN THE DEEP SCAN OVERNIGHT

**Function:** `Show-MalwarebytesFollowUp`  |  **Line:** 2526-2548  |  **Log ID:** (none - unnumbered)

```text
                Draw-Box -Color White -Lines @(
                    "  AFTER THE CUSTOM SCAN -- RUN THE DEEP SCAN OVERNIGHT      ",
                    "---",
                    "  The Deep Scan examines everything more thoroughly. Run     ",
                    "  it after the Custom Scan -- overnight is perfect.          ",
                    "                                                             ",
                    "  TONIGHT, BEFORE BED:                                       ",
                    "  1. Open Malwarebytes -- three dots next to Scan ->         ",
                    "     Advanced Scan -> Deep Scan                              ",
                    "  2. Plug the computer in to power                           ",
                    "  3. Leave the lid OPEN (on a laptop)                        ",
                    "  4. Start the scan and go to bed                            ",
                    "                                                             ",
                    "  You do NOT need to change any sleep settings --            ",
                    "  Malwarebytes keeps the PC awake by itself while it         ",
                    "  scans. Your screen may go dark to save power; that is      ",
                    "  normal, the scan keeps running underneath. Do not press    ",
                    "  the power button -- just check the results in the          ",
                    "  morning.                                                   ",
                    "                                                             ",
                    "  On a PC with 8 GB of memory or less: run one scan per      ",
                    "  night -- Custom Scan tonight, Deep Scan tomorrow night.    "
                )
```

## 32. !  RUNNING ON BATTERY POWER

**Function:** `Test-PowerStatus`  |  **Line:** 2592-2605  |  **Log ID:** (none - unnumbered)

```text
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
```

## 33. POWER SETTINGS -- SECURITY REVIEW

**Function:** `Run-PowerSettingsCheck`  |  **Line:** 2761-2808  |  **Log ID:** (none - unnumbered)

```text
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
```

## 34. APPS AUDIT RESULTS

**Function:** `Run-AppsAudit`  |  **Line:** 3124-3130  |  **Log ID:** (none - unnumbered)

```text
    Draw-Box -Color White -Lines @(
        "  APPS AUDIT RESULTS                                          ",
        "---",
        "  RED    = Known suspicious/PUP publisher -- review now       ",
        "  YELLOW = Not used in 90+ days -- consider removing          ",
        "  GREEN  = Recently installed or used -- no action needed     "
    )
```

## 35. GatewayGuard Windows 11 Security Hardening Tool v$ScriptVersion

**Function:** `Show-ModeSelector`  |  **Line:** 5081-5106  |  **Log ID:** (none - unnumbered)

```text
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
```


# PHASE -- CONSOLE MODE

## 36. QUICK QUESTION -- YOUR PASSWORDS

**Function:** `Show-ScopeDisclaimer`  |  **Line:** 4062-4076  |  **Log ID:** (none - unnumbered)

```text
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
```

## 37. WHAT THIS TOOL DOES AND DOES NOT DO

**Function:** `Show-ScopeDisclaimer`  |  **Line:** 4101-4141  |  **Log ID:** (none - unnumbered)

```text
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
```

## 38. REVIEW YOUR SELECTIONS -- NO CHANGES MADE YET

**Function:** `Run-ConsoleMode`  |  **Line:** 5310-5316  |  **Log ID:** (none - unnumbered)

```text
                Draw-Box -Color White -Lines @(
                    "  REVIEW YOUR SELECTIONS -- NO CHANGES MADE YET           ",
                    "---",
                    "  Items marked [X] WILL be applied.                       ",
                    "  Items marked [ ] will be SKIPPED.                       ",
                    "  BitLocker (if selected) is always handled last.         "
                )
```

## 39. HEADS UP -- SOME SECURITY-CRITICAL ITEMS ARE NOT SELECTED

**Function:** `Test-NonRecommendedSelections`  |  **Line:** 3679-3688  |  **Log ID:** (none - unnumbered)

```text
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
```

## 40. WHAT EACH ITEM DOES -- AND WHY IT IS RECOMMENDED

**Function:** `Test-NonRecommendedSelections`  |  **Line:** 3706-3710  |  **Log ID:** (none - unnumbered)

```text
            Draw-Box -Color White -Lines @(
                "  WHAT EACH ITEM DOES -- AND WHY IT IS RECOMMENDED         ",
                "---",
                "  Details for each item you have not selected:             "
            )
```

## 41. HEADS UP -- YOU HAVE NOT SELECTED DRIVE ENCRYPTION

**Function:** `Show-BitLockerDeclineHeadsUp`  |  **Line:** 4663-4676  |  **Log ID:** (none - unnumbered)

```text
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
```

## 42. ALREADY CORRECT -- AUTO-SKIPPED ($($goodItems.Count) items)

**Function:** `Run-ConsoleMode`  |  **Line:** 5519-5524  |  **Log ID:** (none - unnumbered)

```text
                    Draw-Box -Color White -Lines @(
                        "  ALREADY CORRECT -- AUTO-SKIPPED ($($goodItems.Count) items)            ",
                        "---",
                        "  These settings were already at the recommended state     ",
                        "  and did not need to be changed:                          "
                    )
```

## 43. DRIVE ENCRYPTION (BitLocker) -- WHAT IT IS, WHY IT MATTERS

**Function:** `Show-BitLockerWhyEncrypt`  |  **Line:** 4596-4625  |  **Log ID:** (none - unnumbered)

```text
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
```

## 44. FINAL ITEM: DEVICE ENCRYPTION (Windows 11 Home)

**Function:** `Show-BitLockerHomeScreen`  |  **Line:** 4722-4733  |  **Log ID:** (none - unnumbered)

```text
    Draw-Box -Color White -Lines @(
        "  FINAL ITEM: DEVICE ENCRYPTION (Windows 11 Home)           ",
        "  Guide: Phase 1, Step 3  |  $GuideURL",
        "---",
        "  Windows 11 Home does not include full BitLocker           ",
        "  management -- it uses Device Encryption instead. Same     ",
        "  underlying encryption, but it turns on AUTOMATICALLY,     ",
        "  once your PC meets the requirements below AND you are     ",
        "  signed in to Windows with a Microsoft account.            ",
        "  This tool checks your PC and guides you to the sign-in    ",
        "  step -- Windows itself turns encryption on, not this tool."
    )
```

## 45. YOUR PC MEETS THE REQUIREMENTS

**Function:** `Show-BitLockerHomeScreen`  |  **Line:** 4747-4761  |  **Log ID:** (none - unnumbered)

```text
        Draw-Box -Color Green -Lines @(
            "  YOUR PC MEETS THE REQUIREMENTS                            ",
            "---",
            "  Sign in to Windows with a Microsoft account (not a local  ",
            "  account) -- Settings -> Accounts -> Your info.            ",
            "  Windows will then turn on Device Encryption automatically.",
            "  This tool does NOT turn it on for you -- Windows does,    ",
            "  based on your sign-in.                                    ",
            "                                                            ",
            "  AFTER signing in, CONFIRM your recovery key was saved:    ",
            "  In a browser, go to account.microsoft.com/devices/        ",
            "  recoverykey and check this PC is listed there.            ",
            "  If it is NOT listed, encryption is not protecting you --  ",
            "  do not rely on it until the key appears there."
        )
```

## 46. DEVICE ENCRYPTION MAY NOT BE AVAILABLE ON THIS PC

**Function:** `Show-BitLockerHomeScreen`  |  **Line:** 4763-4774  |  **Log ID:** (none - unnumbered)

```text
        Draw-Box -Color Yellow -Lines @(
            "  DEVICE ENCRYPTION MAY NOT BE AVAILABLE ON THIS PC         ",
            "---",
            "  One or more requirements above are not met. Some PCs      ",
            "  cannot use Device Encryption no matter what settings are  ",
            "  changed.                                                  ",
            "                                                            ",
            "  For the exact reason, check yourself:                    ",
            "  1. Press the Windows key, type msinfo32, press Enter      ",
            "  2. Look for 'Device Encryption Support' in the list       ",
            "  3. It will state the specific reason if not supported    "
        )
```

## 47. !!  BITLOCKER REQUIRES AC POWER

**Function:** `Show-BitLockerScreen`  |  **Line:** 4824-4833  |  **Log ID:** (none - unnumbered)

```text
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
```

## 48. BEFORE ENABLING BITLOCKER, YOU MUST:

**Function:** `Show-BitLockerScreen`  |  **Line:** 4876-4907  |  **Log ID:** (none - unnumbered)

```text
    Draw-Box -Color White -Lines @(
        "  BEFORE ENABLING BITLOCKER, YOU MUST:                      ",
        "---",
        "  1. Back up your important files first -- copy anything     ",
        "     you cannot afford to lose, BEFORE encryption starts.    ",
        "     Simplest way -- copy to a USB or external drive:        ",
        "       a. Plug in the USB or external drive                 ",
        "       b. Press the Windows key + E to open File Explorer    ",
        "       c. Open your Documents, Pictures, Desktop, and        ",
        "          Downloads folders                                 ",
        "       d. Select the files, then drag them onto your USB     ",
        "          drive (listed under 'This PC') -- or copy them     ",
        "          [Ctrl+C], open the drive, and paste [Ctrl+V]       ",
        "       e. Wait for the copy to finish before removing the    ",
        "          drive                                              ",
        "     Already use OneDrive? Files inside your OneDrive        ",
        "     folder are already backed up automatically.             ",
        "  2. Save your Recovery Key -- you will need it if you ever  ",
        "     get locked out                                         ",
        "  3. Print your Recovery Key and store it with your          ",
        "     important documents (birth certificate, passport,       ",
        "     insurance papers) -- NOT near your computer             ",
        "  4. Also save it to your Microsoft account as a backup      ",
        "  5. Plug in your power adapter -- encryption can take a     ",
        "     long time                                               ",
        "  6. Do not turn off, restart, or close the lid during       ",
        "     encryption                                              ",
        "                                                             ",
        "  WARNING: If you lose your Recovery Key and get locked out, ",
        "  your data CANNOT be recovered by anyone -- not even        ",
        "  Microsoft.                                                 "
    )
```

## 49. FINAL ITEM: BitLocker / Device Encryption

**Function:** `Show-BitLockerScreen`  |  **Line:** 4925-4939  |  **Log ID:** (none - unnumbered)

```text
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
```

## 50. !  BITLOCKER RECOVERY KEY -- CRITICAL ACTION REQUIRED

**Function:** `Show-BitLockerScreen`  |  **Line:** 5032-5049  |  **Log ID:** (none - unnumbered)

```text
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
```

## 51. YOUR CHOICE IS NOTED -- NO ENCRYPTION WILL BE APPLIED

**Function:** `Show-BitLockerFinalDecline`  |  **Line:** 4632-4646  |  **Log ID:** (none - unnumbered)

```text
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
```

## 52. ALL SELECTED ITEMS PROCESSED

**Function:** `Run-ConsoleMode`  |  **Line:** 5559-5563  |  **Log ID:** (none - unnumbered)

```text
                Draw-Box -Color White -Lines @(
                    "  ALL SELECTED ITEMS PROCESSED                           ",
                    "  Log saved to C:\GatewayGuard\Logs\.                          ",
                    "  See manual steps below for items needing your action.  "
                )
```

## 53. AUTOMATED SCAN SCHEDULE SETUP

**Function:** `Setup-ScheduledTasks`  |  **Line:** 4393-4405  |  **Log ID:** (none - unnumbered)

```text
    Draw-Box -Color White -Lines @(
        "  AUTOMATED SCAN SCHEDULE SETUP                            ",
        "  Setting up automatic security scans...                   ",
        "---",
        "  (1) Quarterly Defender Offline Scan                      ",
        "      Runs BEFORE Windows loads -- catches deeply hidden   ",
        "      threats. Scheduled: 1st of Jan / Apr / Jul / Oct 2AM ",
        "                                                            ",
        "  (2) Monthly reminder to run your Malwarebytes scans      ",
        "      A popup on the 1st of each month reminding you to    ",
        "      run the Custom Scan (with rootkit checking) and the  ",
        "      Deep Scan. The popup includes the exact steps.       "
    )
```

## 54. CONVENIENCE CHOICES -- NOTHING CHANGED YET

**Function:** `Show-ConvenienceReview`  |  **Line:** 4232-4241  |  **Log ID:** SCREEN-23

```text
    Draw-Box -Color White -Lines @(
        "  CONVENIENCE CHOICES -- NOTHING CHANGED YET                       ",
        "---",
        "  The next few screens cover privacy and convenience settings.     ",
        "  All are RECOMMENDED, but they are YOUR choice.                   ",
        "                                                                   ",
        "  NO change is made until you approve it. For each item:           ",
        "    Y = Make this change now (recommended)                         ",
        "    N = Skip it -- leave that setting exactly as it is             "
    )
```

## 55. YOUR CHOICE [$ggCIIdx of $ggCITotal]: $($ci.Name)

**Function:** `Show-ConvenienceReview`  |  **Line:** 4256-4267  |  **Log ID:** (none - unnumbered)

```text
        Draw-Box -Color White -Lines @(
            "  YOUR CHOICE [$ggCIIdx of $ggCITotal]: $($ci.Name)          ",
            "---",
            "  WHAT THIS CHANGE WILL DO (nothing done yet):                ",
            "  $($ci.What)                                                 ",
            "---",
            "  WHY WE RECOMMEND IT:                                        ",
            "  $($ci.Why)                                                  ",
            "---",
            "  IF YOU EVER WANT TO UNDO IT LATER:                          ",
            "  $($ci.Revert)                                               "
        )
```

## 56. AUTOMATED STEPS COMPLETE

**Function:** `Show-ManualSteps`  |  **Line:** 4302-4355  |  **Log ID:** (none - unnumbered)

```text
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
        "      SCAN 1 -- CUSTOM SCAN (checks for rootkits):           ",
        "        1. Open Malwarebytes                                ",
        "        2. Next to the Scan button, click the three dots    ",
        "           (do NOT click Scan itself)                       ",
        "        3. Click Advanced Scan, then Custom Scan            ",
        "        4. CHECK the box 'Scan for rootkits'                ",
        "        5. CHECK ALL your drives (C:, D:, and any others)   ",
        "        6. Start the scan -- about 25 min to an hour        ",
        "        7. If anything is found: click QUARANTINE right     ",
        "           then                                             ",
        "      SCAN 2 -- DEEP SCAN (run it overnight):                ",
        "        Three dots -> Advanced Scan -> Deep Scan.            ",
        "        Start it before bed and leave the lid open. The     ",
        "        screen may go dark -- the scan keeps running.       ",
        "                                                            ",
        $(if ($global:HasPasswordManager) { "  [x] Password Manager   -- You said you already use one.    " } else { "  [ ] Password Manager   -- Install, migrate passwords.     " }),
        $(if ($global:HasPasswordManager) { "      Good -- keep using it for every account.              " } else { "      Guide: Phase 5                                        " }),
        "                                                            ",
        "  [ ] 2FA                -- Enable on all important accounts.",
        "      Authenticator app preferred. Guide: Phase 5           ",
        "                                                            ",
        "  [ ] Scheduled Scans    -- AUTOMATED: GatewayGuard set up  ",
        "      Quarterly Defender Offline Scan (Jan/Apr/Jul/Oct)     ",
        "      + monthly reminder to run your Malwarebytes scans     ",
        "      (Custom Scan with rootkits, then Deep Scan overnight) ",
        "      Verify: Task Scheduler -> GatewayGuard tasks          ",
        "---",
        "  Log saved to C:\GatewayGuard\Logs\: $(Split-Path $LogPath -Leaf)",
        "  Guide and support: $GuideURL",
        "---",
        "  GATEWAYGUARD IS NOW FINISHED FOR THIS SESSION.               ",
        "  The program will close after this screen -- complete the    ",
        "  items above on your own time. Your scheduled scans (above)  ",
        "  will still run automatically later -- everything else       ",
        "  requires you to run GatewayGuard again.                     "
    )
```

