<!-- Dated: 2026-08-07 13:30 EDT -->
# GatewayGuard -- Coding Standards
- **Document Name:** GatewayGuard_CodingStandards
- **Last Modified:** 2026-08-07 13:30 EDT
- **Status:** Cumulative Master Document (supersedes all prior dates)
- **Change History Log:**
  - 2026-08-07 13:30: **FILE STRUCTURE RULES rewritten for the consolidation.**
    The personal OneDrive copy of the tree was retired and the business copy
    renamed `GatewayGuide` -> `GatewayGuard`, ending the two-tree arrangement
    that had them drifting within hours of each other. The single root is now
    `C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\`. The long-standing
    note that "the folder is spelled GatewayGuide and always has been" is
    retired with the folder -- it was true and load-bearing right up until it
    was not, which is the reason this section names the path rather than
    assuming the reader knows it.
    Also recorded: the **GitHub remote now exists** --
    `GatewayGuard/GatewayGuard`, **private**, first push 2026-08-07 with 21
    commits and 702 files. Until that push the repository lived only inside the
    folder it was protecting, with the two local copies three commits behind it.
    See RECOVERY POINTS, which now lists the remote as recovery point 0.
  - 2026-08-07 12:23: Three corrections, all the same shape -- a fix that
    landed in one governing document and not in its neighbours.
    **(1) The CGDELL machine-state line under RESEARCH BEFORE STATING was
    stale.** It read "CGDELL carries Defender, BitLocker, TPM, Secure Boot
    **off**". CGDELL was measured 2026-08-02 as **fully encrypted**, signed in
    with a **Microsoft account** (TestHistory-ascii39, FT-143/144/145). The
    identical claim was corrected in ProjectInstructions on 2026-08-06 at
    17:27; this document was edited at 17:00 the same day and missed it, so
    the stale line outlived its own correction. It is the line that produced a
    false "your machine has encrypted itself" warning to Bill on 2026-08-06.
    Replaced with a **pointer** to the ENCRYPTION STATE MATRIX rather than a
    second copy of the facts -- a restated fact is a fact that can go stale on
    its own, which is exactly what happened here.
    **(2) SESSION END CHECKLIST said "All 23 mandatory pre-build gates".**
    Gate 24 was added to this same document on 2026-08-02 and the checklist
    was not updated with it. A checklist that stops at 23 never asks about the
    gate that caught FT-162.
    **(3) Gate 6 was titled "Build ID Triple Agreement" and listed four
    locations.** Playbook Appendix A item 9 requires **five** -- it adds the
    "Current build" line in CLAUDE.md, added 2026-07-26 precisely because that
    line had drifted six builds stale. Retitled, corrected to five, and the
    Run-GatewayGuard.bat reference kept as the separate paired-file check it
    actually is (Playbook item 10), so the count cannot drift to six.
  - 2026-08-06 17:00: FILE STRUCTURE RULES corrected, and the post-move path
    recorded. The documented tree root read `...\OneDrive\GatewayGuard\`; the
    folder is `GatewayGuide` and always has been, so the one path this document
    states about itself was wrong. Found by the M365 migration Phase 4 grep,
    which also found the real defect: the `.ps1` integrity hook -- the Class 7
    gate earned by the ascii34 corruption -- was registered in
    `.claude\settings.local.json` by absolute path
    (`C:\Users\willi\onedrive\gatewayguide\...`). Moving the tree would have
    stopped it running, and a gate that stops running says nothing. It is now
    `${CLAUDE_PROJECT_DIR}`, verified by observation, not assumed: a probe
    `.ps1` was written and the hook returned `PS1 INTEGRITY OK`. **The general
    rule: a check that is wired up by absolute path is one folder move away
    from being a wish.** See also GATE 24 -- same failure shape, different
    surface.
  - 2026-08-02 07:41: Added GATE 24 -- EXTERNAL COMMAND VERIFICATION, the
    mechanical enforcement of RESEARCH BEFORE STATING, earned by FT-162
    (`MpCmdRun.exe -Scan -ScanType 4` -- a flag that does not exist, shipped
    in the quarterly scheduled task AND asserted on screen to the user; the
    scan has never run on any machine while the log said [GOOD] every time).
    Extended RESEARCH BEFORE STATING to state that a command flag IS a
    factual claim, that parameter NAMES need verifying too, and that CGDELL
    is the test bench. Checker: `Tool2\Check-ExternalCommands-2026-08-02.ps1`,
    launcher `Run-ExternalCommandCheck.bat`.
  - 2026-07-26 06:19: Added guide-wording requirement to the HTML
    DELIVERY GATE (pre-build step 3 and new report line H-4), mirroring
    WebsiteStandards RULE W-07. Website copy must match the written
    guide; the SettingsToGuideMap is an index, not a content source.
  - 2026-07-26 06:19: PYTHON EDITING RULES expanded (rules 4a, 6a, 6b,
    and scope note) after the 2026-07-25 ascii34 corruption incident.
    Root finding: brace balance CANNOT detect duplication-class damage
    -- the corrupted file measured 47,232 open / 47,232 close braces,
    perfectly balanced, while being 41x oversized and unparseable.
    Added line-count/size assertions and a mandatory parse check, and
    put lint/cleanup passes explicitly in scope of the wrapper rule.
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
3. **Read the actual guide section for the setting the page covers, and
   match its wording** (WebsiteStandards RULE W-07, effective
   2026-07-26). **The guide wins on substance; plain English wins on
   expression** -- match its facts, setting names and menu paths
   exactly, but write the sentences for a non-technical senior.
   **REMOVE technical jargon rather than explaining it** (RULE W-08):
   leave the plain English version only -- kernel becomes "this part",
   sealed room becomes "locked file location", hypervisor/VBS/
   virtualization are cut entirely in favour of describing the effect.
   KEEP literal on-screen labels exact ("Memory integrity", "Core
   isolation", "Device security") -- the reader must find them on their
   own screen. Load-bearing phrases (warnings, exact paths, anything
   that changes meaning if reworded) stay verbatim. Also per W-08: no
   pedantic phrasing; every check step states the desired state AND the
   fix; no dead-end instructions; copy buttons wherever the reader is
   told to copy something. GatewayGuard_SettingsToGuideMap.md is an INDEX -- use it
   to find the right guide section, then read that section. Writing a
   page from the map produces copy that covers the right topics in the
   wrong words. Where the tool's own on-screen copy already says
   something, reuse the tool's wording. Where the guide has no coverage
   for a setting (Fast Startup #18, Wake on LAN #19), original copy is
   expected -- flag it in the page's Change History comment.

**Before presenting any HTML file, Claude must show this report:**
```
HTML DELIVERY GATE RESULTS
H-1 Corruption grep (W-02): [PASSED -- 0 issues] or [list findings]
H-2 Browser check instruction (W-03): [INCLUDED in response]
H-3 W3C validation instruction (W-04): [INCLUDED in response]
H-4 Guide-wording source (W-07): [guide section cited] or
    [NO GUIDE COVERAGE -- original copy, flagged in file header]
Gate status: [ALL PASSED -- file ready for delivery]
```
A page whose wording source cannot be named has NOT passed the gate --
"written from the settings map" is a FAIL, not a source.

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

### 6. Build ID Agreement -- FIVE locations (Playbook Appendix A item 9)
The build ID appears in five places. All five must agree, and all five are
updated in the SAME edit that increments the build:

1. The .ps1 **filename** itself
2. `# FILE:` header -- matches the new build filename
3. `# BUILD:` header -- matches the new build name
4. `$BuildID` variable -- matches the new build name
5. The **"Current build" line in CLAUDE.md**

**Location 5 is the one that gets forgotten, and it is the one that lies to
the next session.** CLAUDE.md sat at ascii28 while the tree was on ascii34 --
six builds stale, on the very line instructing the reader to confirm the build
number before any edit session. A pointer that lies is worse than no pointer.
That is why the Playbook raised this check from four locations to five on
2026-07-26.

**Separately -- this is a paired-file check, not a sixth ID location:**
Run-GatewayGuard.bat references its .ps1 by exact filename and must be
corrected in the same edit (Playbook Appendix A item 10; CROSS-FILE SYNC
below). It is named here so it is not missed, not to make six.

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

### 24. External Command Verification (anchored: FT-162)
**MECHANICAL. Run `Tool2\Run-ExternalCommandCheck.bat` before every build.**

**24a -- every external command carries its evidence.** Any invocation of
MpCmdRun, schtasks, powercfg, manage-bde, reagentc, bcdedit, netsh, wmic,
cipher, gpupdate, dism or sfc must have a VERIFIED comment within 20 lines
above it:

```powershell
# VERIFIED 2026-08-02 measured on CGDELL: MpCmdRun -Scan -ScanType accepts
#   0-3 only; ScanType 4 returns 0x80070667 invalid command line in 0.0s.
```

Basis must be **measured** (it was run, output recorded) or **sourced**
(primary documentation, URL in the comment). **`inferred` and `guess` are not
shippable bases.** Add any new external binary to the checker's `$ggBins`
list in the same edit -- a binary the gate does not know about is invisible
to it, which is the one way to defeat this check.

**24b -- no raw command line in front of the user.** A screen may not show
an .exe name followed by switches. The plain-language rule says delete jargon
rather than explain it, and a command line the user cannot evaluate is the
purest form of it. A deliberate "type this yourself" instruction is allowed
and declared inline: `# GATE24-OK: <reason>`.

**A FLAG IS A FACTUAL CLAIM.** RESEARCH BEFORE STATING (below) already
covered this and was already mandatory. It did not hold, because nothing
checked it. What shipped: `MpCmdRun.exe -Scan -ScanType 4` in the quarterly
scheduled task, plus an on-screen sentence telling the user it "SCHEDULES the
offline scan for your NEXT PC restart". ScanType 4 does not exist. Measured
2026-08-02: `0x80070667 -- Invalid command line argument`, 0.0 seconds, no
scan, no state change, nothing queued. **The quarterly Defender scan never
ran on any machine**, and `[GOOD] Scheduled task created` was logged every
time. The correct call, `Start-MpWDOScan`, was already in the same file.

Ratchet: existing unverified calls sit in a named baseline inside the
checker. Any call not in that baseline fails the build. The list may only
get shorter.

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

**There is ONE tree, and this is where it is (as of 2026-08-07):**

```
C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\
├── Tool\          -- current active build only (.ps1 + .bat)
├── Builds\        -- archive of latest build only
├── ProjectDocs\   -- notes, checklist, standards, research
└── WebSite\       -- website planning docs
```

**The two-tree arrangement is over.** The tree used to exist in both OneDrives
at once -- personal and business -- and they drifted within hours of each
other. On 2026-08-07 the personal copy was deleted and the business copy was
renamed `GatewayGuide` -> `GatewayGuard`. Anything still describing "the
personal copy" or instructing you to edit one of two copies is stale; there is
one tree and one remote.

**The folder used to be spelled `GatewayGuide`** -- the one thing in this
project not spelled `GatewayGuard`. That is retired with the folder. It is
recorded here rather than deleted because scripts, logs and documents written
before 2026-08-07 name the old spelling, and a reader who meets it needs to
know it was real rather than a typo.

**That path contains spaces.** Anything naming it must quote it. Nothing does
today, and nothing should start: all 13 launchers in `Tool\` use
`cd /d "%~dp0"` and relocate cleanly, and no script in `Tool\` depends on an
absolute path. Do not add one. Where a tool outside `Tool\` must reach the
project root -- a Claude Code hook, for instance -- use the
`${CLAUDE_PROJECT_DIR}` placeholder rather than typing the path.

**Do not hardcode the root folder's NAME either.** `Check-OneDriveSync` probed
for the literal string `GatewayGuide` and would have reported "NO PROJECT TREE
ON THIS MACHINE" on every machine the moment the rename landed -- a check that
silently stops finding what it was written to find, which is the same failure
as the absolute-path hook the Phase 4 grep caught. It now probes both names,
newest first. Any future tool that must locate the tree does the same.

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
- [ ] All 24 mandatory pre-build gates passed (for .ps1) -- gates 1-24,
      including gate 24 (external command verification, run mechanically
      via `Tool2\Run-ExternalCommandCheck.bat`)
- [ ] HTML Delivery Gate H-1/H-2/H-3/H-4 reported (for .html)
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

**SCOPE (effective 2026-07-26): these rules govern EVERY edit to a .ps1
build file with no exceptions -- feature work, defect fixes, AND lint or
cleanup passes.** A "cosmetic" edit is not exempt. The 2026-07-25
ascii34 corruption happened during a PSScriptAnalyzer cleanup pass that
was treated as too trivial to need the wrapper; it was applied as a bulk
raw-PowerShell string replace and duplicated the file's content roughly
40x, producing a 13.7 MB / 228,739-line unparseable file from a 341 KB /
5,574-line source. Cosmetic intent does not reduce mechanical risk.

When editing large .ps1 files:
1. ALWAYS copy to -work.ps1 first
2. Normalize line endings before editing: .replace('\r\n', '\n')
3. Write back as CRLF: .replace('\n', '\r\n')
4. Use str.replace() with count assertions for every substitution:
   assert d.count(old) == N before replacing -- never replace blind
4a. Bound every replacement. `str.replace(old, new)` with no count
   argument replaces EVERY occurrence; pass an explicit count so the
   call cannot run away (`d.replace(old, new, N)` where N is the same
   asserted number from rule 4). An unbounded replace against a pattern
   that turns out to be more common than expected is the single most
   destructive edit available.
5. If count is wrong, investigate before proceeding -- never adjust
   the expected count to make the assertion pass
6. Run brace balance check after every edit session
6a. **Brace balance is NOT sufficient on its own.** Duplication-class
   damage copies whole balanced blocks, so it stays balanced by
   construction and passes this check cleanly. Measured on the
   2026-07-25 corruption: GOOD file 1,152 open / 1,152 close; CORRUPT
   file 47,232 open / 47,232 close -- both "balanced," one destroyed.
   Brace balance detects truncation and unclosed insertions. It cannot
   detect duplication. Rules 6b and 6c exist because of this.
6b. **Size assertion after every edit session.** Capture line count and
   byte size BEFORE the edit; assert the delta afterward is within the
   range the edit could plausibly produce. A lint pass touching 58 sites
   changes tens of lines, not tens of thousands. Any delta beyond about
   +/-10% of the original is a stop-and-investigate event, not a warning.
   ```python
   before = len(open(path, encoding='utf-8-sig').read().splitlines())
   # ... perform edits ...
   after  = len(open(path, encoding='utf-8-sig').read().splitlines())
   assert abs(after - before) <= max(50, before * 0.10), \
       f"SIZE ASSERTION FAILED: {before} -> {after} lines. STOP."
   ```
6c. **Parse check after every edit session.** The file must parse before
   the session is considered done. This is the cheapest catastrophic-
   damage detector available and it costs about a second:
   ```powershell
   $e=$null; $t=$null
   [System.Management.Automation.Language.Parser]::ParseFile($path,[ref]$t,[ref]$e)
   $e.Count   # must be 0
   ```
   A non-zero count means STOP -- do not attempt to hand-patch a file
   that no longer parses. Recover from a known-good copy instead
   (see RECOVERY POINTS below).
7. Confirm UTF-8 BOM present in output file

---

## RECOVERY POINTS (effective 2026-07-26)

Know where the last known-good copy is BEFORE starting a risky edit.
Established during the 2026-07-25 ascii34 recovery:

**0. The GitHub remote -- the only OFFSITE copy (added 2026-08-07).**
`GatewayGuard/GatewayGuard`, **private**, org-owned. Every other recovery point
on this list lives on the same machine as the thing it protects, or inside the
folder it protects. Until 2026-08-07 the repository was inside the project
folder with no remote at all, and both local copies were three commits behind
it -- so deleting one folder would have destroyed 21 commits, including the
only backup of 77 field logs. Recover a file with
`git checkout <commit> -- <path>`, or the whole tree with `git clone`.
**Push after any session that produces work worth keeping.** A remote that is
21 commits stale is a recovery point for a version you no longer have.

**1. Claude Code file history -- the fastest recovery, per-file and
per-version:**
```
C:\Users\willi\.claude\file-history\<session-id>\<file-hash>@v<N>
```
Versions increment with each edit Claude makes in that session, so the
version immediately before a bad edit is the pre-damage state. Verify a
candidate before restoring: line count, parse check, and a known-unique
string count (e.g. an FT-number that should appear once or twice, not 80
times). Restore with a byte-for-byte `Copy-Item`, then confirm SHA256
matches the snapshot.

**2. OneDrive version history -- USE WITH CAUTION.**
Right-clicking a single file and choosing Version History can surface an
ACCOUNT-LEVEL "restore your files" flow rather than a per-file one. On
2026-07-25 that flow offered to delete 2,801 files to roll the whole
OneDrive back to an earlier point -- catastrophically out of proportion
to recovering one file, and destructive to unrelated work. If a restore
dialog proposes deleting files in the hundreds or thousands, CANCEL IT.
That is a folder/account rollback, not a file restore. Prefer recovery
point 1; it is surgical and verifiable.

**3. The prior build.** Every ascii build is retained under `Tool\`, so
the previous build is always a fallback -- at the cost of losing the
current build's work.

**Preserve the damaged file.** Move it to `Tool\_corrupt\` rather than
deleting it, so the failure mechanism can be studied. It is evidence.

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

### A COMMAND FLAG IS A FACTUAL CLAIM (added 2026-08-02, FT-162)

The flags and flag VALUES passed to an external program are claims about that
program, and they fall under this rule exactly as prose claims do. **Never
write a flag you have not seen in that program's own `-?` output, or run.**

**TEST ON A REAL MACHINE FIRST -- AND CHOOSE THE MACHINE BY THE STATE THE
CLAIM DEPENDS ON.** CGDELL is the usual bench: it is the primary dev machine,
it carries Defender and a **trial-expired** Malwarebytes, and most questions
about this tool's subject matter can be settled there in seconds.

**Do not restate any machine's encryption, account, or firmware state in this
document.** The single authoritative statement of fleet state is the
**ENCRYPTION STATE MATRIX** in `GatewayGuard_ProjectInstructions-*.md`
(MACHINE CHECK section), and a measurement in the current
`GatewayGuard_TestHistory-ascii*.md` outranks even that. Read one of those
before reasoning from any machine's state. A restated fact is a fact that can
go stale on its own.

**What CGDELL cannot settle.** CGDELL is **fully encrypted** (measured
2026-08-02, FT-143/144/145), so it cannot reach the Home / unencrypted /
local-account branch of item 8 -- the FT-110 path and the FT-144 danger case.
**SANDY is the only machine in the fleet that can**, and its value for that
branch is spent permanently the first time encryption actually completes on
it. A claim about the unencrypted path cannot be settled on CGDELL no matter
how convenient CGDELL is.

The asymmetry that governs everything here: **checking costs seconds, a wrong
assertion costs a build.** Prefer running the check over asking Bill to run
it; asking costs a round trip and his time. Say plainly when something cannot
be tested on any available machine.

*(The prior version of this paragraph asserted CGDELL carried BitLocker, TPM
and Secure Boot **off**. That was false, and already four days out of date
when it was written. See MACHINE-STATE CURRENCY in ProjectInstructions.)*

**Verify the parameter NAME too, not just the behaviour.** On 2026-08-02 the
fix for FT-161 was first written as
`New-ScheduledTaskSettingsSet -DisallowStartIfOnBatteries:$false`. That
parameter does not exist -- the real one is `-AllowStartIfOnBatteries`. It was
caught only because the command was run before being written into scope. A
plausible-looking parameter name is a guess wearing a lab coat.

**Every verified call records its evidence in a comment beside it**
(`# VERIFIED <date> measured|sourced: ...`), and **gate 24 enforces it
mechanically.** This rule predates FT-162 and did not prevent it, because
nothing checked it. Rules the toolchain cannot test are aspirations; this
project's own screen-coverage checker says it plainly -- *a gate with no
check is a wish.*

VERIFIED FINDINGS (2026-07-19, all three machines):
- Deep Scan ignores the "Scan for rootkits" toggle -- confirmed
  by report field "Rootkits: Disabled" even with toggle ON
- Custom Scan checkbox controls rootkits -- report-verified
- MBAMService holds SYSTEM power request during scans (no sleep)
- MB Free / trial-expired mode: Deep and Custom Scan still work
- IsTamperProtected = True on Dell (Tamper Protection ON)
