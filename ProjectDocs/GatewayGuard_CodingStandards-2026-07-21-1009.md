<!-- Dated: 2026-07-21 10:09 EDT -->
# GatewayGuard -- Coding Standards
- **Document Name:** GatewayGuard_CodingStandards
- **Last Modified:** 2026-07-21 10:09 EDT
- **Status:** Cumulative Master Document (supersedes all prior dates)
- **Change History Log:**
  - 2026-07-21 10:09: Added READ-BEFORE-PRODUCING rule to DOCUMENT
    REVISION RULE and SESSION START CHECKLIST. Claude must read the
    current version of any document from project knowledge before
    producing an updated version. Added to HTML DELIVERY GATE: current
    HTML file must be read from project knowledge before rebuilding.
    Full delete-and-replace delivery required for all files.
  - 2026-07-21 09:33: Added HTML DELIVERY GATE (H-1, H-2, H-3).
    Renamed from "PowerShell Coding Standards" to "Coding Standards"
    since file now governs both .ps1 and .html build output.
  - 2026-07-20: Added FILE NAMING & VERSIONING rule (YYYY-MM-DD-HHMM).
    Eliminates -r2, _addendum, _additions variants forever. Supersedes
    and absorbs CodingStandards_Additions-2026-07-17.md.
  - 2026-07-19: Full merge of all rules through ascii33. C-14 through
    C-27, pre-build gates 15-23, session checklists, verified findings.
  - 2026-07-17: CodingStandards_Additions file created (now absorbed).
  - 2026-06-27: Initial baseline standards established.

---

## FILE NAMING & VERSIONING (effective 2026-07-20)

**One unique filename per document type, forever.**

**Filename syntax:** `[ProjectName]_[DocumentType]-YYYY-MM-DD-HHMM.ext`
**Example:** `GatewayGuard_CodingStandards-2026-07-21-1009.md`

- The core descriptive name of a file never changes across its lifetime.
- The filename always ends with `-YYYY-MM-DD-HHMM` before the extension.
  Date AND time are both required -- date alone is not sufficient because
  multiple versions can be produced on the same day.
- When a file is updated, both the date and time in the filename change
  to reflect the current edit. Nothing else in the name changes.
- No `-r2`, `-r3`, `_addendum`, `_additions`, `_patch`, or any other
  variant suffix. Ever. For any file type.
- Every update is a complete replacement file with the new date-time. The
  new file supersedes the prior version. Upload it; the old one is retired.
- Every file maintains a cumulative Change History Log in its header.
  All history lives inside the file -- never in separate patch or
  addendum files.
- Before producing any file, Claude must ask Bill for the current date
  and time. Both the filename and the internal header come from that
  answer. Claude never infers the date or time from UTC chat metadata,
  system clocks, or conversation context -- these do not reliably reflect
  US Eastern Time and can differ by a calendar day.
- Exception -- script builds: the ascii build name is part of the .ps1
  filename (e.g., ascii33, ascii34) and increments with each build.
  Format: `W11-SecurityHardening-v3-ascii34-YYYY-MM-DD-HHMM.ps1`
- Exception -- Run-GatewayGuard.bat: no date-time in filename (always-
  current launcher). Date and time live in its internal header only.
- This rule supersedes all prior naming conventions including the old
  date-only format and the -r2/-r3 revision suffix convention.

**Timestamp rule:**
Before producing any file -- because the filename date and the internal
header date+time both come from the same answer -- Claude must ask Bill
for the current date and time. Claude never infers, assumes, or derives
the date from UTC chat metadata, system clocks, or conversation context.
UTC chat timestamps routinely differ from US Eastern Time by hours or a
day. The filename date is not decoration -- it is the version identifier.
A wrong date in the filename means a wrong version label. If Bill has
not provided the date and time in this session, Claude asks before
producing any output file, no exceptions.

---

## DOCUMENT REVISION RULE (effective 2026-07-20)

This rule governs ALL revisions and additions to every GatewayGuard
document, file, and standard -- CodingStandards, ProjectNotes,
WebsiteStandards, NamingStandard, TestHistory, PreScanSpec, or any
other file -- going forward without exception.

**Never create a separate addendum, additions, patch, or revision file.**

When any document needs updating, the process is always:
1. READ the current version of the document from project knowledge
   first. Never produce an updated version from memory or a prior
   session's output. The file in project knowledge is the only
   authoritative source.
2. Integrate new content directly into the body of the document.
3. Update the Change History Log at the top with a one-line summary
   of what changed and the date-time.
4. Update the filename date-time to reflect the current edit.
5. Deliver as a complete self-contained replacement file -- every
   section, every rule, nothing omitted.
6. Bill uploads the new file; the prior version is retired.

**No partial files. No diffs. No "add this to the bottom of X."**
Every delivered file must be complete and self-contained so Bill can
do a full delete and replace with zero assembly required.

---

## HTML DELIVERY GATE (effective 2026-07-21)

This gate governs ALL HTML file builds and is the HTML equivalent of
the MANDATORY PRE-BUILD GATES for .ps1 files. No HTML file is
presented as complete until all steps are done and reported in the
same response. A skipped or failed step blocks delivery.

**Before building or updating any HTML file:**
1. Read GatewayGuard_WebsiteStandards.md from project knowledge.
2. If the file already exists, read the current version from project
   knowledge before producing the replacement.

**Before presenting any HTML file, Claude must show this report:**
```
HTML DELIVERY GATE RESULTS
H-1 Corruption grep (W-02): [PASSED -- 0 issues] or [list findings]
H-2 Browser check instruction (W-03): [INCLUDED in response]
H-3 W3C validation instruction (W-04): [INCLUDED in response]
Gate status: [ALL PASSED -- file ready for delivery]
```

**H-1 -- Corruption grep (W-02):**
Run both grep checks and report results:
  grep -n 'class="\([^"]*\)"><[^>]*class="\1"' file.html
  grep -n '#[0-9]\{4,5\};' file.html
Any hit that is NOT a valid HTML entity (&#NNNNN;) must be fixed
before delivery.

**H-2 -- Browser check instruction (W-03):**
Every HTML delivery response must include:
"Open this file in Chrome or Edge on your PC before pushing to
GitHub. Claude's preview does not render CSS."

**H-3 -- W3C validation instruction (W-04):**
Every HTML delivery response must include:
"Validate at https://validator.w3.org -- use Validate by Direct
Input, paste the file content, click Check. Fix all errors before
pushing. Warnings are acceptable; errors are not."

---

## MANDATORY PRE-BUILD GATES (.ps1)

Before any .ps1 build is presented as complete ALL of the following
must pass. A failed check blocks the build from being delivered.

### 0. Read required documents first
Before any build:
- Read GatewayGuard_CodingStandards.md from project knowledge in full.
- Read GatewayGuard_DefectPreventionPlaybook.md Appendix A AND class
  descriptions from project knowledge.
- Read the current .ps1 build file from project knowledge if updating
  an existing build.

### 1. PSScriptAnalyzer (Appendix A item 0 -- mandatory)
Install-Module PSScriptAnalyzer -Scope CurrentUser (once, on the Dell)
Invoke-ScriptAnalyzer -Path .\[buildfile].ps1
No errors or warnings allowed to ship without documented justification.

### 2. Brace Balance
```python
content.count('{') == content.count('}')
```
Must be equal. Any mismatch = broken script.

### 3. Function Count
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
- Show-SecurityToolsBriefing, Show-ScanPlanBriefing (ascii33+)
- Show-StepHeader (ascii33+)

### 4. Read-Host Check
```python
content.count("Read-Host") == 0
```
Zero Read-Host calls in main logic. All input via Read-ValidKey only.
(Exception: Pause-ForUser fallback -- already wrapped, document it.)

### 5. Press Any Key Check
```python
"press any key" not in content.lower()
```
Zero "press any key" references in any user-facing string.

### 6. Build ID Triple Agreement
- # FILE: header matches new build filename
- # BUILD: header matches new build name
- $BuildID variable matches new build name
- Run-GatewayGuard.bat references correct .ps1 filename
All four must agree. Never update one without updating all.

### 7. Date-Time in Filename
Format: W11-SecurityHardening-v3-ascii33-2026-07-21-1009.ps1
Always YYYY-MM-DD-HHMM. Date AND time required -- date alone is not
sufficient. Filename date-time and internal header date-time must match.

### 8. Label Consistency (anchored: FT-65)
Every key label in a MENU must match the label in the PROMPT on
the same or immediately following screen. For every Read-ValidKey
call, the screen content immediately before it must show every
ValidKey character with the SAME one-word description.
Grep: every Read-ValidKey -ValidKeys list; cross-check against
the Draw-Box or Write-Host content above it. Zero mismatches.

### 9. [string] Cast Before Status Use (anchored: FT-68, FT-71)
Every use of $s.Status (or similar) in .Length, .Substring, -match,
-eq, string interpolation must be preceded by [string] cast.
Grep: .Status.Length and .Status.Substring without [string] = zero.

### 10. No Sleep in Interactive Loops (anchored: FT-75, FT-79)
Start-Sleep is PROHIBITED inside any Show-* or Run-* function.
Grep: Start-Sleep in Show-* and Run-* functions = zero.
(Intentional startup countdown in Show-PreScanGate exit path is
documented exception -- carries a comment explaining why.)

### 11. URL Live Test (anchored: FT-81)
Every hardcoded URL in the script must be browser-tested before
ship. gatewayguard.co/[path] URLs must be live and SSL-valid.
Never hardcode a path that is not yet live. Use direct third-party
URLs until the redirect exists.

### 12. Screen Number Log Lines
Every Draw-Box screen must log [SCREEN-NN] with its title.
Master screen list maintained in build header. Numbers are fixed
forever -- new screens append at the end, never renumber.

### 13. State-Matrix Coverage
Every new state branch (MB state, encryption, edition, tamper)
must have a documented test result in the test history before ship.
Do not code against assumed behavior.

### 14. Fix Everywhere Grep (anchored: FT-67->71, FT-73->93)
After any fix, grep the full file for the same pattern and apply
everywhere in the same build. Log: "FT-XX fix applied at N
locations: [list]." Partial fix = deferred defect.

### 15. Switch Parameter Syntax (anchored: FT-93, C-14)
Grep: `-[A-Za-z]+ \$(true|false)` -- review every hit.
Switch parameters (New-ScheduledTaskSettingsSet etc.) must NEVER
receive a positional $true/$false. Use omission or colon syntax.

### 16. No New-ScheduledTaskTrigger for Recurring Tasks (anchored: FT-93b)
Grep: New-ScheduledTaskTrigger -- zero allowed for recurring tasks.
All recurring schedules use schtasks.exe /sc monthly (or /sc weekly
etc.). Once triggers die after their year and may fire at creation.

### 17. Protection Parity Inventory (anchored: FT-104, C-21)
Build header must contain a PROTECTION INVENTORY listing every
protective mechanism and which functions implement it. Every Show-*
and Run-* function must appear in the inventory (applied or N/A
with reason per C-16 PROTECTED BY line).

### 18. Internal IDs Never User-Facing (anchored: FT-98, C-15)
Walk any path through the tool (including paths with skipped
conditional screens) -- every number the user sees must count
1, 2, 3... with no gaps, jumps, or repeats. User display format:
"Section -- Step N" (live runtime counter). SCREEN-NN stays
log-only. Zero internal IDs in any user-facing string.

### 19. Scope vs Delivered Check
At build time, diff the scoped item list against the change list.
Every scoped item either appears in the changes or is explicitly
deferred with a reason. "We will fix it" with no function named
is not scope.

### 20. Read Every String as the User (anchored: FT-94/95/96/97)
Before ship: read every user-facing string as a non-technical
senior encountering it cold. Status strings, key prompts, and
review copy are the high-risk zones. Rewrite before shipping if
meaning is not instantly predictable. Apply the neighbor test:
"Would a non-technical neighbor understand this in 5 seconds?"

### 21. Error Lines Mean OPEN (anchored: FT-93 x3 builds, C-25)
A feature that produced [ERROR] lines in any prior field log is
OPEN until a new field run shows the error gone AND the outcome
verified externally (e.g., Task Scheduler confirms both tasks
exist). A clean build is not evidence of a working feature.

### 22. Convenience Items: Ask Before Apply (anchored: FT-94)
Settings with IDs 11-15 must NEVER be applied in the main
hardening run. The $script:GGConvPhase guard in Apply-Setting
enforces this. Show-ConvenienceReview is the ONLY caller that
sets GGConvPhase = $true. Verify this guard is intact.

### 23. Status-String Contract
Status strings are consumed by gate logic (-match patterns in
$GoodPatterns, color-match regexes). NEVER reword a status
string without grepping every -match and color check that
consumes it in the same edit. The following tokens are locked:
GOOD, Required Only, ENCRYPTED, ALL ON, primary, N/A on Home.

---

## INPUT HANDLING RULES

### Read-ValidKey -- always use for ALL input
```powershell
$ch = Read-ValidKey -ValidKeys @("Y","N","B") -Prompt "Your choice (Y/N/B): "
```
- NEVER use Read-Host in main logic
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

### USER-FACING CLARITY (anchored: Mark-mode tip, FT-95/96/97)
Every instruction, menu option, or key prompt shown to the user must
state the outcome of every choice explicitly. Never use ambiguous
completions like "press X when done" -- spell out what each key or
action does. Test: can the user predict exactly what will happen
before they act?

Example (correct):
  "Press Enter to copy. Press Esc to exit without copying."
Example (wrong):
  "Press Enter or Esc when done."

---

## CODING STANDARDS (C-series)

### Screen structure (C-16, anchored: FT-72)
Every Show-* and Run-* function begins with:
```powershell
# PROTECTED BY: [global try | local trap | none -- reason]
# Depends on: [$global:VarName -- what value triggers this screen]
```

### Journey order (C-17, approved 2026-07-19)
Code order in the file must match the user's journey order. Functions
appear in the order the user encounters them: pre-flight, scan,
checklist, convenience, BitLocker, summary. Utility functions
(Write-Log, Draw-Box, Read-ValidKey, etc.) in a dedicated section
at the top. Never scatter related screens across the file.

### Spaced stable numbering (C-18, approved 2026-07-19)
Setting IDs use spaced numbering to allow future insertions without
renumbering. One dedicated structure-pass build performs any migration.
Renumbering after the structure pass is prohibited.

### Reviewer test (C-19, approved 2026-07-19)
Before any build ships: could an outside programmer, reading the
file cold, describe what each screen does from its header alone,
and follow the file top-to-bottom as the user's journey?

### Internal IDs never user-facing (C-15, anchored: FT-98/FT-72)
- Internal ID -> log only: [SCREEN-13]
- User display -> runtime counter only: "Scans -- Step 9"
- No screen, prompt, or message ever shows an internal ID to user
- Display format (locked 2026-07-19): "Section -- Step N"

### Hands off third-party security settings (C-27, anchored: D-11)
GatewayGuard never programmatically modifies another security
product's settings (Malwarebytes, etc.). Give the user exact manual
steps instead.

### Scheduling: schtasks.exe only (C-14a, anchored: FT-93b)
For any monthly/quarterly/recurring schedule, use schtasks.exe.
Do not build recurring schedules from New-ScheduledTaskTrigger.

### Switch parameters: never pass positional $true/$false (C-14)
WRONG: -WakeToRun $false
RIGHT: omit (defaults to false) or use colon syntax: -WakeToRun:$false

### Time estimates carry their machine (C-26, approved 2026-07-19)
Every scan/operation duration names the machine class it was measured
on (machine + RAM). No unattributed times.

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
- Script: W11-SecurityHardening-v3-ascii33-2026-07-21-1009.ps1
- Launcher: Run-GatewayGuard.bat (no date-time in name -- always current)
- All other files: [ProjectName]_[DocumentType]-YYYY-MM-DD-HHMM.ext

### Always deliver:
- .ps1 file WITH date-time in name
- Updated Run-GatewayGuard.bat pointing to new .ps1
- Updated GatewayGuard_ProjectNotes.md
- Updated GatewayGuard_Checklist.txt if checklist changed

### Cross-file sync rule
Run-GatewayGuard.bat references its paired .ps1 by exact filename.
Any time the .ps1 is renamed or rebuilt, the .bat filename reference
must be corrected in the SAME response -- never leave a .bat
pointing to a superseded filename.

---

## SESSION START CHECKLIST

Claude must, before producing any output:
- [ ] Ask which machine Bill is working on
- [ ] Ask for current date and time before producing any file
- [ ] For any document update: read the current version from project
      knowledge first -- never produce from memory or prior output
- [ ] For .ps1 builds: read CodingStandards.md from project knowledge
- [ ] For .ps1 builds: read DefectPreventionPlaybook.md Appendix A
      AND class descriptions from project knowledge
- [ ] For HTML work: read WebsiteStandards.md from project knowledge
- [ ] For HTML work: read the current HTML file from project knowledge
      if it already exists
- [ ] Confirm no open BLOCKED items from last test history

---

## SESSION END CHECKLIST

Before presenting final output:
- [ ] All 23 mandatory pre-build gates passed (for .ps1)
- [ ] HTML Delivery Gate H-1/H-2/H-3 reported (for .html)
- [ ] PSScriptAnalyzer run; any warnings documented
- [ ] Brace balance verified (open == close)
- [ ] All required functions present exactly once
- [ ] Read-Host count = 0 in main logic
- [ ] "press any key" count = 0
- [ ] Build ID updated in FILE:, BUILD:, $BuildID, and .bat
- [ ] Date-time in filename and internal header match
- [ ] .bat file updated to match new .ps1 name
- [ ] Every user-facing string read as the user (neighbor test)
- [ ] Status-string contract: no locked token reworded
- [ ] Scope vs delivered: every item shipped or explicitly deferred
- [ ] Error lines from prior logs: confirmed resolved or still OPEN
- [ ] All output files presented via present_files
- [ ] Stated-vs-delivered check run before sign-off
- [ ] File delivered as complete self-contained replacement
      (full delete and replace -- never an addendum or diff)

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
Cross-check SC2 against Win32_Product to detect
(note: Win32_Product is SLOW ~60sec -- use only when necessary).

### Scheduled tasks: FT-93 RESOLVED ascii33
Both tasks now use schtasks.exe /sc monthly. Task Scheduler
verification added to field test checklist (C-25 rule).

### ConvenienceReview silent apply: FT-94 RESOLVED ascii33
Items 11-15 deferred from main run; $script:GGConvPhase guard
added to Apply-Setting. Ask-before-apply enforced.

### Tamper Protection detection: FT-105 RESOLVED ascii33
Get-MpComputerStatus.IsTamperProtected is now the primary method
(registry fallback kept). Verified True on Dell 2026-07-19.

---

## PYTHON EDITING RULES

When editing large .ps1 files:
1. ALWAYS copy to -work.ps1 first
2. Normalize line endings before editing: .replace('\r\n', '\n')
3. Write back as CRLF: .replace('\n', '\r\n')
4. Use str.replace() with count assertions for every substitution:
   assert d.count(old) == N before replacing -- never replace blind
5. If count is wrong, investigate before proceeding -- never adjust
   the expected count to make the assertion pass
6. Run brace balance check after every edit session
7. Confirm UTF-8 BOM present in output file

---

## RESEARCH BEFORE STATING

No factual claim about external system behavior (MB, Windows,
Defender, third-party tools) is coded into the tool or written into
user-facing copy until verified against a primary source:
  - Microsoft docs
  - MB support forums or help center
  - Live machine test with report or output as evidence
  - Web search with URL cited

If unverified, say "check whether [X]" not "this will [X]."

VERIFIED FINDINGS (2026-07-19, all three machines):
- Deep Scan ignores the "Scan for rootkits" toggle -- confirmed
  by report field "Rootkits: Disabled" even with toggle ON
- Custom Scan checkbox controls rootkits -- report-verified
- MBAMService holds SYSTEM power request during scans (no sleep)
- MB Free / trial-expired mode: Deep and Custom Scan still work
- IsTamperProtected = True on Dell (Tamper Protection ON)
