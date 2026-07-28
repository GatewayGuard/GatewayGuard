# GatewayGuard -- PowerShell Coding Standards
**Created:** 27-Jun-2026
**Purpose:** Things to ALWAYS check and do when building each ascii version.
             Review this before starting any new build.

---

## MANDATORY CHECKS BEFORE RELEASING ANY BUILD

### 1. Brace Balance
```python
content.count('{') == content.count('}')
```
Must be equal. Any mismatch = broken script.

### 2. Function Count
Every required function must appear EXACTLY ONCE:
- Enable-SleepPrevention, Disable-SleepPrevention
- Get-RAMStatus, Get-WinEdition, Get-TamperProtectionState
- Get-MalwarebytesState, Test-DefenderPrimary
- Get-AllStatuses, Apply-Setting
- Run-ConsoleMode, Run-GUIMode
- Show-BitLockerScreen, Show-ScopeDisclaimer
- Show-ConvenienceReview, Show-ManualSteps
- Write-Log, Save-Log, Draw-Box
- Test-PersonalComputer, Test-AdminAccess
- Setup-ScheduledTasks
- Read-ValidKey, Pause-ForUser

### 3. Read-Host Check
```python
content.count("Read-Host") == 0
```
Zero Read-Host calls allowed. All input via Read-ValidKey only.

### 4. Press Any Key Check
```python
"press any key" not in content.lower()
```
Zero "press any key" references allowed in user-facing strings.

### 5. Build ID Updated
- FILE: header matches new build name
- BUILD: header matches new build name
- $BuildID variable matches new build name
- .bat file references correct .ps1 filename

### 6. Date Format in Filenames
Format: W11-SecurityHardening-v3-ascii22-2026-06-27.ps1
Always include date in YYYY-MM-DD format (ISO 8601).

---

## INPUT HANDLING RULES

### Read-ValidKey -- always use for ALL input
```powershell
$ch = Read-ValidKey -ValidKeys @("Y","N","B") -Prompt "Your choice (Y/N/B): "
```
- NEVER use Read-Host
- ALWAYS wrap in try/catch (already in function)
- ALWAYS include "B" for Back where back navigation is valid
- ALWAYS use ToUpper() -- already handled in function

### Valid key sets by context:
| Context | ValidKeys |
|---------|-----------|
| Yes/No only | @("Y","N") |
| Yes/No/Back | @("Y","N","B") |
| Yes/No/Skip | @("Y","N","S") |
| Yes/No/Quit | @("Y","N","Q") |
| Menu 1-3 | @("1","2","3") |
| Main chart | R/A/N/Q + numbers 1-19 (special handler) |

### Pause-ForUser -- for read-only screens
```powershell
Pause-ForUser "  Press Enter or Space to continue..."
```
- ALWAYS provide explicit message -- never use default
- Only Enter (VK 13) and Space (VK 32) accepted
- Numpad Enter also accepted (same VK code)
- Wrapped in try/catch -- fallback to Read-Host

### NEVER say:
- "Press any key"
- "Hit any key"
- "Press a key"

### ALWAYS say:
- "Press Enter or Space to continue..."
- "Press Enter or Space to [specific action]..."

---

## DISPLAY RULES

### Draw-Box
- Default color: White (black border, white text)
- Color only for status differentiation in charts
- Auto-sizes to longest line (minimum 44 chars)
- Use "---" to separate header from body
- Max line width: 120 chars (console window width)
- Lines longer than 120 chars: wrap to next line with 4-space indent

### Date Format
- User-facing displays: DD-MMM-YYYY (27-Jun-2026)
- Filenames: YYYY-MM-DD (2026-06-27)
- Log entries: YYYY-MM-DD HH:mm (2026-06-27 14:32)
- NEVER use MM/DD/YYYY (US-only format)

### Status colors in chart:
- Green: GOOD, already correct, no action needed
- Yellow: Needs attention, recommended change
- Red: Critical, security risk
- White: Neutral, informational
- Gray: N/A, skipped, manual only

### Settings chart columns:
- Name column: 52 chars
- Status column: 36 chars
- Total width fits 120-char console

---

## SETTINGS CHART RULES

### Auto-deselect GOOD items
Items with status matching "-- GOOD|N/A on Home|ENCRYPTED|ALL ON" must be:
- Selected = $false (unchecked)
- Shown in GREEN in chart
- NOT included in WILL APPLY section of review

### BitLocker (ID=8) special rule
- NEVER auto-select regardless of status
- Always require explicit user selection
- Reason: risk of encryption without recovery key saved

### Review screen grouping:
1. WILL BE APPLIED (white) -- [X] items
2. ALREADY GOOD -- no change needed (green) -- [ ] items
3. SECURITY RISK -- deselected (red) -- critical items user unchecked

---

## NAVIGATION RULES

### Back button (B key)
- Available on every setting detail screen
- Returns to main checklist/chart
- Available on pre-flight screens where appropriate
- NOT available on: crash screens, exit screens, BitLocker key screens

### Q = Quit
- Available on main chart and setting screens
- Always confirms before quitting
- Saves log before exit

### S = Skip
- Only available on apps audit uninstall prompts
- NOT available on main security settings (would bypass security)
- If user types S on Y/N screen: silently ignore (already handled by ValidKeys)

---

## PRE-RUN INSTRUCTIONS (shown at startup)

### Order:
1. Admin check -- if not admin, show how to run as administrator
2. Window setup -- maximize, scroll arrows, Enter/Space
3. Font check -- Consolas/Courier New verification
4. "What happens next" -- pre-flight checklist overview
5. Ready to begin prompt

### Admin screen must include:
- Right-click -> Run as administrator steps
- Unknown publisher warning explanation
- UAC "allow changes" prompt explanation
- "This is normal and expected" reassurance

---

## FILE STRUCTURE RULES

### OneDrive folder structure:
```
C:\Users\willi\OneDrive\GatewayGuard\
├── Tool\          -- current active build only (.ps1 + .bat)
├── Builds\        -- archive of latest build only
├── ProjectDocs\   -- notes, checklist, standards, research
└── Website\       -- website planning docs
```

### File naming:
- Script: W11-SecurityHardening-v3-ascii22-2026-06-27.ps1
- Launcher: Run-GatewayGuard.bat (no version in name -- always current)
- Notes: GatewayGuard_ProjectNotes.md (no version -- always current)

### Always deliver:
- .ps1 file WITH date in name
- Updated Run-GatewayGuard.bat pointing to new .ps1
- Updated GatewayGuard_ProjectNotes.md
- Updated GatewayGuard_Checklist.txt if checklist changed

---

## SESSION START CHECKLIST

At the start of each coding session, user uploads:
- [ ] Latest .ps1 build
- [ ] GatewayGuard_ProjectNotes.md

Claude should:
- [ ] Confirm build ID and line count match expected
- [ ] Copy to -work.ps1 before any edits
- [ ] Run brace balance check before starting
- [ ] Run function count check before starting

---

## SESSION END CHECKLIST

Before presenting final output:
- [ ] Brace balance verified (open == close)
- [ ] All required functions present exactly once
- [ ] Read-Host count = 0
- [ ] "press any key" count = 0
- [ ] Build ID updated in FILE:, BUILD:, and $BuildID
- [ ] Date in filename
- [ ] .bat file updated to match new .ps1 name
- [ ] ProjectNotes.md updated with session summary
- [ ] All output files presented via present_files

---

## KNOWN ISSUES LOG

### productState 0x1000 bit (RESOLVED ascii20)
MB Free sets this bit even as companion -- NEVER use to detect MB state.
Use Get-MpComputerStatus.RealTimeProtectionEnabled instead.

### Read-ValidKey crashes (FIXED ascii22)
RawUI.ReadKey() can crash when console is launched via UAC elevation.
Fix: wrap in try/catch with Read-Host fallback.

### Phishing Protection registry (OPEN)
HKLM:\...\WTDS\Components is Tamper Protected on some systems.
Catches SecurityException and shows manual steps instead.

### Ghost SC2 entries (OPEN)
Uninstalled AV can leave stale SecurityCenter2 entries.
Cross-check SC2 against Win32_Product to detect (note: Win32_Product is SLOW ~60sec).

### Win32_Product performance (KNOWN)
Takes 30-60 seconds due to Windows Installer consistency check.
Use only when necessary -- not on every run.

---

## PYTHON EDITING RULES

When editing large .ps1 files:
1. ALWAYS copy to -work.ps1 first
2. Use content.find() + index-based replacement for large blocks
3. Use str.replace() for simple string substitutions
4. NEVER use str_replace tool on files with mixed quotes or escape chars
5. Always verify replacement succeeded (check "REPLACED OK" output)
6. Run brace balance check after every edit session
