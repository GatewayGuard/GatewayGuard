<!-- Dated: 2026-08-17 18:30 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii40 -- Field Test Run 1 triage

- **Document Name:** GatewayGuard_FieldTestTriage-ascii40run1
- **Last Modified:** 2026-08-17 18:30 ET
- **Last Editor:** Claude Code (CGDELL)
- **Build under test:** ascii40 (`W11-SecurityHardening-v3-ascii40-2026-08-15-0828.ps1`)
- **Machine:** SANDY, HP Laptop 17-by1xxx, Windows 11 **Home** (Core), 8 GB RAM
- **Sources:**
  - `Test_Results\Ascii40_Test_Run1-2026-08-17-1006.txt` -- Bill's 11 findings
  - `Test_Results\Logs-Sandy\GatewayGuard-Log-2026-08-17_09-44.txt` -- run 1, 58 minutes, 31 screens
  - `Test_Results\Logs-Sandy\GatewayGuard-Log-2026-08-17_17-36.txt` -- run 2, 6 minutes, resume then exit

**This is the first field run of ascii40.** Everything before this was bench
evidence on CGDELL.

---

## THE HEADLINE: NO CRASH, IN EITHER RUN

**measured.** Two runs on the machine that crashed three times under ascii39.
Run 1 lasted **58 minutes across 31 screens**, with the mouse in use
throughout. Run 2 ran 6 minutes and exited cleanly on the user's own
confirmation. **Neither log ends mid-flow. Both wrote their footer.**

Bill's ascii39 findings 14, 15, 39 -- *"right clicked and the program
crashed"*, *"right clicked twice and pgm crashed again"*, *"Checkup is gone"*
-- did not recur.

**FT-171 is confirmed fixed in the field.** That was the launch blocker.

Bill's finding 1b confirms the thing that was at risk: *"wheel still scrolls
perfectly."* Clearing `ENABLE_MOUSE_INPUT` removed mouse events from the input
buffer **without** disabling wheel scrolling of the console buffer. That
was the open question on FT-171a and it is now answered from the field.

---

## ALSO CONFIRMED FIXED

### FT-175a -- the quarterly scan task. FIXED, PROVEN IN TASK SCHEDULER.

Bill's finding 6: *"GG Monthly set to 9/1 and every month thereafter.
Quarterly set to 10/1 and every quarter thereafter."*

**This is the finding that matters most after the crash.** `ScanType 4` never
existed, the task never ran, and the log printed `[GOOD] Scheduled task
created` every time for months. Bill has now read the **real next-run times
out of Task Scheduler** -- which is the only evidence that was ever going to
settle it. Both tasks exist, both are scheduled, both recur.

The lesson stands and is now paid for: **the log claiming success is not
evidence. The external system's own state is.**

### FT-171d -- exit on a bare N. FIXED, PROVEN.

Bill's finding 10: *"Resumed, said no to my personal computer. Next msg do you
want to close Checkup - said Y, pgm closed."*

**That is the new SCREEN-83 behaving exactly as designed.** Under ascii39 a
bare `N` at the resume re-check exited the program with no confirmation.
Log run 2, lines 26-29:

```
[17:40:38] [KEY] Key 'N' accepted at: Show-ResumeReverify
[17:40:38] [SCREEN] [SCREEN-83] Rendered: ARE YOU SURE YOU WANT TO CLOSE CHECKUP?
[17:42:00] [KEY] Key 'Y' accepted at: Show-ResumeReverify
[17:42:00] [EXIT] Resume re-check: user said not personal PC, and confirmed the exit
```

Not a defect. Recorded because a confirmed fix is worth as much as a found
bug, and this one has a field witness now.

### FT-173 -- going back. NEARLY FIXED.

Bill's finding 2: *"B Back works on every screen so far, except 19 your
passwords."*

Under ascii39 this was three separate complaints (findings 10, 23, 33 --
*"I needed to go back and could not"*, *"wanted to go back could not, fix this
for all screens"*, *"ascii40 must allow going back on all screens"*). It is
now **down to one screen.** See FT-173-residual below.

---

## OPEN DEFECTS -- all located in source, all measured

### FT-184 (NEW) -- the identity banner is painted and then erased

**Bill's finding 1a:** *"something flashes by before you get to screen 1
welcome back."* Also ascii39 finding 1. Reported twice; now located.

**measured**, `W11-SecurityHardening-v3-ascii40-2026-08-15-0828.ps1`:

| Line | What happens |
|---|---|
| 8476 | `Clear-Host` |
| 8478 | `"Please wait -- checking your system..."` |
| 8484 | `Clear-Host` |
| 8486-8489 | Four DarkGray lines: build, filename, machine + Machine ID, timestamp |
| 8536 | `Show-ResumePrompt` |
| 3328 | `Clear-Host` -- **wipes the banner** |
| 3330 | SCREEN-25 painted |

The banner is on screen for a fraction of a second between two `Clear-Host`
calls. **That is the flash.** It is not a glitch, it is a designed screen that
nobody gets to read.

**This corrects an item in the FT-172 design document.** That document says
*"the build number is nearly invisible -- `ascii40` appears on screen twice,
both in the colours this file reserves for de-emphasized chrome."* One of
those two appearances is this banner, and it is not de-emphasized, it is
**erased**. The Machine ID goes with it -- the one string support would ask a
caller to read out.

**RESOLVED 2026-08-17. The banner is CUT, and replaced by FT-189.**

Bill: *"no senior including me is going to remember that. Better you provide a
button the user can select and read it right off the screen, or a file the user
can open in Notepad."*

**He is right, and it disposes of the option I recommended.** I had proposed
promoting the banner to screen 1. That fails for a reason no amount of screen
design fixes: **the information is needed during a support call, which happens
hours or days after the run.** A screen shown at launch -- however long it is
held -- is being asked to work as memory, and it cannot. Cutting the flash was
never the hard part; making the build number and Machine ID *retrievable* is.

The banner is deleted. **The table's integers do not shift.** See FT-189.

### FT-173-residual -- SCREEN-53 has no Back option

**Bill's finding 2**, the one screen where B fails.

**measured**, line 6208:

```powershell
$pmAns = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Do you use a password manager? (Y = yes / N = no): "
```

**No `B`.** This is a direct breach of the standing rule in `CLAUDE.md`:
*"Back option at every prompt -- no dead ends."*

Worth noting the shape of it: `Show-ScopeDisclaimer` already handles Back
correctly further down (line 6273 re-asks this very question when the user
backs out of page 1). The Back path exists. **The screen that asks the
question first is the only one that cannot reach it.**

### It is not one screen. It is 34. -- measured 2026-08-17

Bill found one because it is the one where he wanted to go back. **The defect
is everywhere `Read-ValidKey` is called.**

**measured**, every key set passed to `Read-ValidKey` in the build:

| Key set | Prompts |
|---|---|
| `Y,N` | **34** |
| `Y,N,S` | 5 |
| `1,2,3` | 2 |
| **`Y,N,B`** | **2** |
| `E,R` | 1 |
| `Y,N,Q` | 1 |
| `R,S` | 1 |

**Two prompts out of 46 accept B.**

**And `Read-ValidKey` has no Back handling of its own** -- line 2329 is
`while ($ch -notin $ValidKeys)`, a bare loop. An unrecognised key is **silently
discarded with no message at all.** So a user pressing B at any of the other 44
prompts gets no response, no explanation, and no way to tell whether the key
registered. That is a dead end by this project's own definition, and it is
*invisible* -- which is why it has survived this long and why Bill met it only
once.

**The fix belongs in `Read-ValidKey` itself, not at 44 call sites.** The
precedent is already in this build: the 26-line rule's trailing blank line is
produced centrally in `Write-GGBox` *"so a new screen gets it automatically and
cannot forget it."* Same reasoning, same place to put it. **One change closes
FT-173 completely and makes it impossible to reintroduce.**

Where B is genuinely meaningless -- the very first screen -- it should say so
rather than ignore the key.

### FT-178 -- only one disk is reported

**Bill's finding 3:** *"The screen showing user's pc configuration, only shows
one disk still."* SANDY has two. Also ascii39 finding 13. Unfixed.

**measured**, line 3625, in `Show-SystemBaselineSummary`:

```powershell
$disk = Get-CimInstance -ClassName Win32_DiskDrive -EA SilentlyContinue | Select-Object -First 1
```

`Select-Object -First 1`. It is not failing to detect the second disk -- it is
**discarding it by construction.**

There is a second instance of the same pattern at line 6737, in the BitLocker
size estimator:

```powershell
$disk = Get-PhysicalDisk -EA SilentlyContinue | Select-Object -First 1
```

That one is less wrong -- the estimate is about the system drive -- but it
picks the *first enumerated* disk, not necessarily `C:`. On a two-disk machine
it can describe the wrong drive's media type. **Both should be fixed together;
they are the same mistake made twice.**

### FT-175b -- the offline scan is never offered on a repeat run

**Bill's finding 5:** *"Defender offline scan was offered - have to go back and
recheck, I believe I said no to both Defender and MB."*

**The log settles it, and the answer is the opposite of what Bill remembers.**

**measured**, run 1 log: the Malwarebytes decline is recorded --
`[SKIP] User skipped Malwarebytes scan`. **There is no corresponding Defender
line.** `[SKIP] User skipped Defender Offline Scan` does not appear, and
neither does SCREEN-38. The screens run 13 -> 14 -> 15 as
SCREEN-39 -> SCREEN-43 -> SCREEN-73.

**Root cause, measured.** `Show-PreScanGate` has two branches:

- **First-run branch** -- prep checklist, then SCREEN-38, the actual
  Y/N offer, line 3864.
- **Repeat-run branch** -- line 3907, SCREEN-39 `REMINDER: PRE-SCAN
  RECOMMENDED`. **It contains no offer at all.**

The log shows `SCREEN-39` and `[CONFIRM] Repeat run -- user confirmed to
continue`. Bill took the repeat branch, so the offer was never on screen.
What he is remembering is SCREEN-39, which talks about scans without offering
one, and the Malwarebytes screen, which he did decline.

**This is ascii39 finding 38 unchanged** -- *"Defender offline scan run was
missing. Fix this and check if running resume had anything to do with it."*
**It did.** Bill's own hypothesis was right and is now proven.

Bill's ascii39 instruction stands: *"Should always get option to run offline
scan Y or N."* The repeat branch has to offer it.

### FT-185 (NEW) -- checklist item 6 is named for a setting that no longer exists

**Bill's finding 4:** *"Screen 22, Setting 6 -- should say Edge MS SmartScreen
Phishing check, Status -> On Good."* Also ascii39 finding 37.

Two separate problems under one item.

**(a) The name is wrong.** Edge's three-level phishing control no longer
exists; the protection is Windows SmartScreen. The item still carries the old
name.

**(b) The status cannot be read where it is being read.** From the run 1 log:

```
[10:06:07] [INFO] Item 6 (Edge phishing protection): registry read BLOCKED by
                  Tamper Protection -- reporting Unknown rather than a fault (FT-141)
```

**measured**, line 5486 -- the read is against
`HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components`, which
Tamper Protection blocks. The FT-141 handling is correct and should stay --
reporting `Unknown` rather than inventing an answer is exactly right. **But
`Unknown` is not a useful answer to give a user, and Bill has confirmed the
real state is On.**

**A different read path is needed and I have not verified one.** *unverified.*
I can settle it on CGDELL in minutes -- it has Tamper Protection on and
Defender active. **No key will be written into the build until it has been
read on a live machine**, per the rule FT-162 earned.

### FT-186 (NEW) -- the Settings route is not universal

**Bill's findings 7 and 8.** Both are the same fix.

**Finding 7, screen 27 (SCREEN-80), measured line 7145:**

> `"  1. Press the Windows key, then click Settings (the gear) "`

Bill: *"change wording to 'type settings, which will work on all PCs'."*
**He is right.** The gear's position depends on the Start menu layout, which
varies by PC and by Windows update. Typing does not.

**Finding 8, screen 28 (SCREEN-81), measured line 7175:**

> `"  1. Press the Windows key, type  Device Encryption         "`

Bill: *"change wording to 'type settings and then device encryption
settings'."* Searching Start for "Device Encryption" often returns nothing on
Home; searching **inside** Settings finds it.

**One route, used everywhere: Windows key -> type `settings` -> Enter -> search
within Settings.** This is a D-18 case -- the build should say it one way, and
it currently says it two.

### FT-187 (NEW) -- the look-back wall

**Bill's finding 9:** *"Pressed B back to screen 24, next B went to a screen
saying no more going back."*

Run 1 log, final two lines -- the look-back opened twice at `Run-ConsoleMode`
and no screen re-rendered. This is the same wall as ascii39 findings 11, 18
and 19 (*"That earlier screen cannot be shown again"*). It was folded into
FT-171 during ascii39 triage, which was wrong -- **it is a history-retention
limit, not an input defect**, and FT-171 being fixed did not touch it.

Filed separately so it stops being invisible inside a closed item.

### FT-188 (NEW) -- absent registry keys are logged as ERROR in the customer's log

**Found in the log, not reported by Bill.** Run 1, four consecutive lines at
10:06:09:

```
[ERROR] SILENT ERROR at Show-ScopeDisclaimer: Requested registry access is not allowed.
[ERROR] SILENT ERROR at Show-ScopeDisclaimer: Cannot find path 'HKLM:\...\Edge' because it does not exist.
[ERROR] SILENT ERROR at Show-ScopeDisclaimer: Cannot find path 'HKLM:\...\Dsh' because it does not exist.
[ERROR] SILENT ERROR at Show-ScopeDisclaimer: Cannot find path 'HKLM:\...\Edge' because it does not exist.
```

**measured** -- lines 5486, 5587, 5603, 5617. Three of the four are
`-EA SilentlyContinue` reads of policy keys that **are absent on a normal home
PC and are expected to be absent.** The code handles them correctly and
reports `Unknown`. The user saw nothing wrong, and nothing was wrong.

**But the log says `ERROR` four times, and the log is the file the user is told
to email to support.** A clean run should not look like a broken one. These
are `INFO`, not `ERROR`.

---

### FT-189 (NEW) -- the user must be able to FETCH their build and Machine ID

**Bill, 2026-08-17**, replacing FT-184's proposed fix: *"provide a button the
user can select and read it right off the screen, or a file the user can open
in Notepad."*

**The requirement, stated properly:** the build number and Machine ID are
support-call information. They are needed **later**, by a person who is on the
phone and does not have the run in front of them. Anything that shows them
once, at launch, is asking a screen to work as memory.

**Both halves of Bill's instruction should be built. They serve different
moments.**

**(a) The button -- an `I` key available at every prompt.**

**measured 2026-08-17: `I` is free.** Keys currently in use as valid keys
anywhere in the build are **B, E, N, Q, R, S, Y**, plus the checklist's **P**
and **A** and the digits **1, 2, 3**. `I` collides with nothing.

It paints a small screen carrying the build, the Machine ID, the full log path,
and how to open the log. Under FT-172 it is a branch screen and takes a letter,
not an integer -- it is reachable from everywhere and is on nobody's main line.

**It goes inside `Read-ValidKey` and `Read-NavKey`, not at the call sites.**
Same argument as the FT-173 fix above, and the two changes should be made
together in the same place -- they are the same omission with two symptoms.

**(b) The file -- already exists, and is not findable.**

The log header already carries all of it:

```
  Build: ascii40
  Computer: SANDY
  Machine ID: F7F13A97D58D
  Run Date: 2026-08-17 09:44:08
```

**So the file half of Bill's request is 90% built and 0% delivered** -- it sits
at `C:\GatewayGuard\Logs\GatewayGuard-Log-<timestamp>.txt`, which a senior
cannot be expected to navigate to. **Ship an `Open-My-Log.bat`** in
`C:\GatewayGuard\` that opens the newest log in Notepad on a double-click, and
name it on the `I` screen and in the closing screen.

This is Bill's ascii39 finding 7 arriving again from a different direction --
*"add 'which you can open in Notepad'"*. Same instinct, and it was right then
too.

**Launcher rules apply** (`CLAUDE.md`): no date in the name, `cd /d "%~dp0"`,
never self-elevate, Enter-only wait rather than `pause`, CRLF endings.

---

## ONE MORE THING, FOR FT-172

**measured**, run 1 log. The checklist logs no position number:

```
[10:11:50] [SCREEN] [SCREEN-75] (shown as screen 21) Rendered: ...page 2 of 2
[10:11:52] [SCREEN] [SCREEN-76] Checklist render: page 1, window width 121, ...
[10:31:30] [SCREEN] [SCREEN-55] (shown as screen 23) Rendered: REVIEW YOUR SELECTIONS
```

**21 -> 23. Screen 22 is missing from the log entirely** -- yet Bill calls the
checklist "screen 22" in finding 4, because the checklist paints its own
number in its own header bar (source line 7668) and that surface is not logged.

This is the **third numbering surface** the FT-172 design document flagged, now
caught in the field: the number the user reads out to support does not appear
in the log support would be reading. **Add it to the FT-172 build list.**

---

## WHERE ascii40 STANDS

**Fixed and proven in the field:** FT-171 (all six parts -- no crash, wheel
works, no bare-N exit), FT-175a (scheduled tasks real).

**Open, all located in source:** FT-173-residual, FT-175b, FT-178, FT-184,
FT-185, FT-186, FT-187, FT-188. Plus FT-172, still in design.

**Nothing found in this run is a crash, a data-loss risk, or a wrong system
change.** Every open item is a missing offer, a missing Back, a wrong count, a
wrong word, or a log label. That is a materially different position from
ascii39.
