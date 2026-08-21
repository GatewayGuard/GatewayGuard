<!-- Dated: 2026-08-21 10:20 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii42 Field Test -- Run 1 Triage

- **Document Name:** GatewayGuard_FieldTestTriage-ascii42run1
- **Last Modified:** 2026-08-21 10:20 ET
- **Last Editor:** Claude Code (CGDELL)
- **Build:** ascii42 -- `Tool\W11-SecurityHardening-v3-ascii42-2026-08-19-1830.ps1`
- **Machine:** SANDY (HP 17-by1955cl, Win 11 Home, local account `panther`,
  both drives unencrypted, conhost not Windows Terminal)
- **Source:** `Test_Results\Ascii42-test-results-2026-08-21-.odt`, Bill's
  notes taken at the keyboard during the run
- **Run status:** **The run continued past the checklist** after the first
  batch of notes was handed over. Bill ran items 6, 9, 12, 13, 14, 15 and 17,
  reached the convenience review (shown-screen 33b), and **the run ended there
  when Ctrl+C in Mark mode closed the program** -- FT-218. Sections A-E below
  cover the first half; **section H covers items 12-26 of Bill's notes** and
  is where the heaviest findings are.
- **Encryption:** not reached in this run. **See section I -- the premise
  that running it would spend SANDY's unencrypted state is WRONG, and the
  evidence was already in the repository.**

**Run log not yet available.** The tool writes to
`<user folder>\GatewayGuard\Logs\`, which on SANDY is the personal OneDrive
folder. As of 10:20 ET that folder holds 14 logs and **none dated
2026-08-21** -- SANDY has not synced. Harvest it when it arrives; several
findings below can be confirmed or refuted from it.

---

## HOW TO READ THE BASIS LABELS

Per CLAUDE.md, every claim carries how it was established.

| Label | Means |
|---|---|
| **field** | Bill observed it on SANDY. The field wins. |
| **source** | Located in the ascii42 source, file and line given |
| **field, unlocated** | Reported, not yet found in the source. Not a doubt about the report -- a gap in my analysis |

---

## A. THE CHECKLIST -- WHERE THE RUN STOPPED

### FT-204 -- `N` on the checklist silently discards every selection

**Basis: field + source, line 8368.**

```
"N" { $Settings | ForEach-Object { $_.Selected = $false } }
```

No confirmation, no undo, instant, and it clears **both pages**. The legend
presents it as an ordinary command beside `A = Select all`:

```
A = Select all             N = Deselect all    Q = Quit
```

**Why this is more than a stray keypress.** Everywhere else in Checkup `N`
is the safe answer -- no, skip, go back, do not change my system, across
roughly 40 prompts. On this one screen it destroys everything Checkup
computed. That fails the User-Facing Clarity Rule on its own test: a user
cannot predict what the key does, because it means the opposite of what it
means everywhere else.

**This has been reported before and was not fixed.** The FT-125 comment ten
lines above the handler quotes field note 14 from 2026-07-27 verbatim:
*"selected N to turn off all selections and screen flickered ... then
displayed screen showing R had been selected and when i hit space bar pgm
crashed."* The response then was to add **logging** to the checklist reader.
The key itself was never guarded. FT-124 also removed Enter-as-Yes in ascii37
partly to explain field note 10, *"somehow all selections were removed while
I was typing notes"* -- which may have been this key all along, meaning that
fix addressed the wrong mechanism.

**Fix for ascii43:** move the command to `C = Clear all selections`, and
confirm before wiping. It is the only command on that screen that destroys
work and the only one with no confirmation -- `Q` has one.

### FT-205 -- once nothing is selected, the only ways on are re-select or quit

**Basis: field + source, line 8373.**

```
"R" {
    $selectedCount = ($Settings | Where-Object { $_.Selected }).Count
    if ($selectedCount -eq 0) {
        "  Nothing is selected, so there is nothing to run."
        "  Type an item number to select that item, or A to select all."
```

Bill's words: *"it forces me to run something."* Accurate. After FT-204
wipes the list, `R` refuses to advance, so the choices are to rebuild the
selections by hand or `Q` out of the tool. **There is no path through the
checklist that changes nothing.**

**Open product decision, Bill's call:** should a "look through everything and
change nothing" path exist? My recommendation is **no** -- the checklist with
its statuses *is* the review, `Q` is the no-change exit, and
`Show-AllScreens.bat` covers walkthroughs. Adding a branch means new screens
in a build already carrying ~20 open findings 11 days from launch. Recorded
as a decision, not actioned.

### FT-206 -- the `I` key does nothing on shown-screens 25 and 26

**Basis: field + source.** `Show-CheckupInfo` has exactly **two** call
sites -- line 2551 inside `Pause-ForUser`, line 2667 inside `Read-ValidKey`.
The checklist uses its own hand-rolled reader, because it must accept
two-digit item numbers, and that reader handles **only Ctrl+C** (lines 8287
and 8312). So FT-189's promise that `I` works from any prompt is not true of
the checklist.

The promise is made on screen. `Read-ValidKey` line 2675 prints *"Press I at
any time to see your build and Machine ID."* **"At any time" is wrong**, and
the two screens where it fails are the busiest in the tool.

### FT-207 -- no prompt in the build says an exit exists

**Basis: source.** Ctrl+C opens the exit confirmation from every question
(`Read-ValidKey` line 2648) and the checklist has `Q` (line 8370). **Measured:
44 of the 47 `Read-ValidKey` prompts list neither `Q` nor `B` in their key
list.**

That figure needs care and is deliberately not being reported as "44 dead
ends" -- most of the 44 are Y/N questions where `N` *is* the exit ("N =
Exit", "N = Go back"), and Ctrl+C works at all 47 because it is caught before
the valid-key check. The defect is that **nothing on screen ever says so.**
When a key is not accepted, the message names the valid keys and offers `I`,
and never mentions Ctrl+C.

**Fix for ascii43:** add the exit line to the unrecognised-key message in
`Read-ValidKey`. One edit, covers all 47 prompts, and does not require
bolting a Back onto questions that correctly have none.

---

## B. SCREENS WITH NO NUMBER -- AND THE GATE THAT CANNOT SEE THEM

### FT-208 -- at least two screens the user meets carry no screen number

**Basis: field + source.** Bill logged two:

- *"Checking power-related -- no scr #"*
- *"Your settings -- step 6 -- no Scr # no back allowed"*

**The mechanism, and it matters more than the two screens.** Gate 12
(`Check-ScreenCoverage`) audits **`Draw-Box` calls** and verifies each carries
a `-ScreenId`. Measured: in the whole power block, lines 4928-5372, there is
**exactly one** `Draw-Box` call -- line 5054, `ScreenId "50"`.
`Apply-PowerSettings` (5175-5372) paints its output with bare `Write-Host`.

**So a screen assembled from bare `Write-Host` is invisible to gate 12.**
"70 screen IDs, all unique, gate 12 PASS" is not the same statement as "every
screen the user meets has a number", and ascii42 shipped believing it was.
The checklist is already documented as the one screen that bypasses
`Draw-Box`; it is not the only one.

**This is the class, not the instance.** Before ascii43, the count of
user-visible screens needs establishing by a method that does not assume
`Draw-Box`. I have not done that audit and am not guessing at the number.

---

## C. NAVIGATION -- BACK

### FT-209 -- shown-screen 14a traps the user with only Y or N

**Basis: field.** *"hit space bar few times ended up on 14a -- won't go back.
Pre-scan recommended. Only press Y or N to exit."* Shown-as 14a is
`SCREEN-39`, the repeat-run pre-scan reminder. Reached by pressing Space
through preceding screens, with no way back to what he had been reading.

### FT-210 -- the power "Your settings" screen offers no Back

**Basis: field.** Same screen as FT-208's second half. It ends with the
standard *"Press Enter or Space to continue... Or press B to look back"*
line, and Bill records **no back allowed** at the point he needed it.
**field, unlocated** -- I have not yet separated "B was not offered" from "B
was offered and did nothing", and the run log will settle it.

### FT-211 -- shown-screen 22 back behaviour is inconsistent

**Basis: field.** *"Scr 22 -- no going back. Selected Y and hit B and it went
back."* So `B` worked, but only after answering. Before answering it did not.
Consistent with the known class **Back works on pages, not at questions**,
carried over unfixed from the ascii41 run.

### FT-212 -- shown-screen 11 repeated, and the two `N` answers behaved differently

**Basis: field.** *"Scr 11 -- repeated, shown twice. Responded N, showed time,
went back. Responded N again, did not show time again and it moved on."*
Shown-as 11a/11b are `SCREEN-36`/`SCREEN-37`, the time and date check. The
same key produced two different outcomes on what the user reads as the same
screen. **field, unlocated.**

---

## D. THE SCREEN GALLERY -- `Show-AllScreens.bat`

Two separate launches, consistent between them.

### FT-213 -- `Ctrl+A` does nothing

**Basis: field.** Both runs.

### FT-214 -- `B` is dead until an unrelated key is pressed

**Basis: field, both runs.** *"B did not work ... tried j and it seemed to
work. After that B worked."* And on the restart: *"B and mouse wheel did
nothing ... Tried j it worked and B key started working."*

**Reproduced twice with the same trigger key**, which makes this the most
diagnosable finding in the run. A reader that ignores input until some other
key wakes it is the same family as FT-171's input-gate work.

### FT-215 -- mouse wheel scrolls one direction, then stops entirely

**Basis: field, both runs.** *"mouse wheel scroll forward and back, only went
forward ... Could no longer scroll with mouse wheel."* On the second run the
wheel did nothing at all from the start.

**This is expected to interact with the FT-171a change.** Briefing section 2
records that ascii42 clears `ENABLE_MOUSE_INPUT`, and the 21:08 log confirms
it fires: *"QuickEdit AND mouse input reporting disabled for this session
(FT-01, FT-171a)."* Whether wheel scrolling of the **window** should survive
that is the open question -- section 2 argues it should, because the wheel
belongs to the console host and the build never reads a mouse event.
**The field says it does not survive.** That contradiction has to be resolved
before ascii43, and the field wins.

### FT-216 -- arrows, Page Up/Down and `Q` all work

**Basis: field, both runs.** Recorded so the working set is not re-tested.

---

## E. ALREADY KNOWN, RECONFIRMED

### The gallery start-up freeze -- evidence recovered

The briefing's open item 1 calls
`GatewayGuard-Log-2026-08-19_21-08.txt` uncollected and unreadable from
CGDELL. **It is readable.** It sits in the personal OneDrive log folder and
Checkup diagnosed its own freeze:

```
[21:09:00] [WARN] FT-63: startup was delayed 1 minute(s) between launch
           and initialization -- console was likely frozen in
           text-selection (Mark) mode; Esc releases it
[21:09:00] [START] SCREEN GALLERY opened (review mode -- no checks run)
[21:41:41] [EXIT] SCREEN GALLERY closed
```

**Esc is the release.** The open item can be closed as diagnosed; what
remains is preventing the console from entering Mark mode at launch.

### Shown-screen 24 reports sleep active

**Basis: field.** *"Scr 24 -- says sleep active."* Recorded; no action
determined. **field, unlocated.**

---

## F. WHERE THE LOGS ACTUALLY LIVE

**Checkup writes its log outside the repository**, to
`<user folder>\GatewayGuard\Logs\`. On both machines that resolves to the
**personal** OneDrive, not the `OneDrive - GatewayGuard LLC` folder that
holds the repo. The logs replicate to CGDELL by themselves and are readable
there -- but git has never seen them, so **Cloud has never seen them.**

That is the mechanism behind the recurring "field logs arrive untracked"
failure recorded in briefing section 8a. As of 10:20 ET that folder holds 14
logs: 4 ascii41 (SANDY) and 10 ascii42 (7 CGDELL, 3 SANDY).

**Harvesting them into `Test_Results\` should be mechanical, not
remembered.** A guard nobody runs is a wish.

---

## G. WHAT ascii43 SHOULD CARRY, IN ORDER

1. **FT-218** -- Ctrl+C must not end the session while the user is trying to
   copy. It cost the rest of this run, and the build's own log claims this was
   fixed in FT-150.
2. **FT-217** -- split box lines on the newline before measuring, and clamp
   the width. Five convenience screens are over-wide, one at 378 characters.
   Add a width check to gate 12b, which currently measures only lines.
3. **FT-204** -- move deselect-all off `N`, and confirm before wiping.
   Smallest edit, largest protection, twice-reported.
4. **FT-225 with FT-204** -- **make `B` the only Back key, everywhere.** `N`
   currently means skip, exit, go back and deselect-all depending on the
   screen. One key, four meanings, and two separate findings in this run.
5. **FT-219** -- stop asking permission for a change the user already
   selected. Reported five times; the most frequent complaint in the run.
6. **FT-207** -- say the exit exists in the unrecognised-key message.
   One edit, all 47 prompts.
7. **FT-206 / FT-227** -- make `I` work on the checklist, or stop promising
   "at any time" on screens where it does not.
8. **FT-221 / FT-220** -- tie setting 15 to the password-manager answer, and
   say why the current state is bad on settings 9, 12, 13 and 17. The guide is
   silent on these too, so it moves in the same pass.
9. **FT-214 / FT-215** -- the gallery reader. Reproduced twice with a known
   trigger key, and FT-215 contradicts the briefing's mouse-flag reasoning,
   which has to be settled either way.
10. **FT-208** -- establish the real count of user-visible screens by a method
    that does not assume `Draw-Box`, then number the ones that have no number.
11. **FT-222 / FT-223 / FT-224 / FT-226** -- the checklist state and
    consistency block.
12. The carried block from ascii41 -- FT-203, and the ~20 wording and
    screen-splitting findings.

**Then field-run ascii43 on SANDY, and run the encryption path on that
build.** SANDY's unencrypted state is spent once and should be spent on the
build closest to launch.

---

## H. THE SECOND HALF OF THE RUN -- ITEMS 12 TO 26

Bill ran items **6, 9, 12, 13, 14, 15 and 17** from the checklist and worked
through to the convenience review. These are the findings from that stretch.

### FT-217 -- a box line containing a newline is measured as one line, and blows the box to 378 characters

**Basis: field + source, and this is the most precisely located finding in
the run.**

Bill pasted the screen. **Measured on his paste: every border and content
line of shown-screen 33b is exactly 378 characters wide.**

`Write-GGBox`, lines 2119-2122:

```
$Width = 44
foreach ($line in $Lines) {
    if ($line -ne "---" -and ([string]$line).Length -gt $Width) { $Width = ([string]$line).Length }
}
```

**There is no upper bound, and `.Length` does not know about newlines.** The
convenience items embed PowerShell newline escapes in their prose so it will
wrap. Line 6804, the Edge Password Saving item -- **the exact screen Bill
pasted** -- holds a `Why` string of **328 characters** with a backtick-n in
the middle. `Write-GGBox` measures the whole thing as a single 328-character
line, adds the padding, and paints a 378-wide box on a console perhaps 120
columns across.

**Six strings across five convenience items carry embedded newlines and are
all over-length**, measured on the ascii42 source:

| Line | Field | Length |
|---|---|---|
| 6760 | Why -- Advertising ID | 211 |
| 6771 | Why -- Diagnostic data | 214 |
| 6782 | Why -- Edge Startup Boost | 285 |
| 6783 | Revert -- Edge Startup Boost | 140 |
| 6793 | Why -- Widgets | 257 |
| **6804** | **Why -- Edge Password Saving** | **328** |

So **five of the convenience screens are over-wide**, not one. Bill met the
worst of them.

**Why no gate caught it.** Gate 12b measures screens in **lines**, not
columns. Nothing in the build measures box **width** at all, and
`Write-GGBox` is documented as guarding width regressions (FT-117, FT-122)
while having no maximum.

**Fix for ascii43:** split on the newline before measuring, so a two-line
string counts as two lines; and clamp `$Width` to the console width with a
loud failure rather than a silent 378. Add a width check to gate 12b.

### FT-218 -- Ctrl+C in Mark mode ended the program

**Basis: field.** *"tried mark and highlighted but did not copy tried mark
again highlighted and hit cntl-c and pgm ended."*

**This is the single most damaging finding in the run**, because it ended
the session and cost the rest of the test.

**It also sits against a claim the build makes about itself.** Every log
opens with:

```
[OK] Console control handler registered -- Ctrl+C in Mark mode can no longer
     end the session (FT-150), and closing the window still writes the log footer
```

**The field says otherwise.** The likely path is that Ctrl+C reached
`Read-ValidKey` line 2648, opened `Confirm-Exit`, and the confirmation was
answered -- so the program ended "legitimately" while the user believed they
were pressing copy. Either way the user's intent was **copy** and the outcome
was **exit**.

**The deeper problem: Ctrl+C is what copy means to everyone.** Checkup's own
documented copy sequence is Alt+Space, E, M, select, then **Enter** to copy.
Nothing on screen says Enter is the copy key and Ctrl+C is the quit key, and
the natural key does the destructive thing. **field, unlocated** as to
whether Confirm-Exit was shown; the run log will settle it.

### FT-219 -- the tool asks permission for a change the user already selected

**Basis: field, reported five separate times** -- against settings 6, 12, 13,
15 and again in Bill's item 24. His words: *"asks if I want to apply this
change, but above already said verify by hand, and before that the user
selected #6 to run, so next screen should have been the screen explaining how
to do it."*

And: *"Says you will approve or skip this one next. That is not next."* The
screen promises the next screen will be the approve/skip step, and it is not.

This is the highest-frequency complaint in the run and it is a flow defect,
not a wording one: **selection, advisory and consent are being asked in an
order that repeats itself.**

### FT-220 -- settings state what will change but not why the current state is bad

**Basis: field, four settings** -- 9, 12, 13 and 17. *"Doesn't explain why
this is not good. Fix this."*

Setting 9 is the sharpest case: *"on SANDY the PIN for restart sign-on is
active and also for sleep or hibernate continuation. Does not explain here or
in the guide why they should do this, why they need to use the MS account,
and why not using the MS account is bad."*

**Neither the tool nor the guide answers it**, so this is a RULE W-07 item as
well as a screen item -- the guide and the screens have to agree, and right
now they agree by both being silent.

### FT-221 -- setting 15 does not tie into the password-manager answer

**Basis: field.** *"it doesn't tie into the P/W manager selection. We don't
want them turning it off until they have a password manager set up and the
Edge and other browser passwords imported into it."*

Checkup already asks whether the user has a password manager (shown-screen
22, `SCREEN-53`). Turning off browser password saving before that is in place
**leaves the user with no password store at all**, which is worse than where
they started.

Bill's item 24 adds the wording fix: setting 15 should say **"Requires manual
change by you"**, and should carry **two different wordings** depending on the
earlier password-manager answer.

### FT-222 -- an applied setting keeps its X on the checklist

**Basis: field.** *"When we apply a setting the X should also be removed, so
if you go back only the settings you haven't handled still have an X in their
box."*

Correct, and it interacts with FT-204: after the deselect-all wipe, there is
no way to tell what has already been applied from what has not.

### FT-223 -- two-digit selections apply instantly, one-digit selections do not

**Basis: field.** *"selecting 12 and 13 it instantly removed the X when you
type the second digit. On previous screen you still had to hit spacebar or
enter. Which it doesn't tell you."*

The checklist reader must accept two-digit numbers, so it commits on the
second keystroke. Single digits wait for Enter. **The user is given no way to
know which behaviour they are getting**, which is the User-Facing Clarity Rule
test again.

### FT-224 -- the encryption question is asked again after it was already answered

**Basis: field.** *"Removed all applied X's and typed R, went next to 25c and
re-asked about drive encryption. This is not necessary as the user had already
gone through this once. Same thing with screen 25e. Also can't go back on this
screen."*

Shown-screens 25c and 25e are `SCREEN-58` and `SCREEN-68`. Two defects in one:
the question repeats, and the screen has no Back.

### FT-225 -- shown-screen 27 uses N for "go back", inconsistently

**Basis: field.** *"On this screen N is go back. Inconsistent. Use B."*

**This is FT-204's problem from the other direction.** `N` means skip, exit,
go back and deselect-all depending on which screen you are standing on.
**One key, four meanings.** Bill's instruction is the right one: Back is `B`,
everywhere.

### FT-226 -- setting 17 has no guide page number and no explanation, and Y did nothing

**Basis: field.** *"Setting 17 -- No guide page number -- No explanation. Y
did nothing, hit spacebar."* The missing `GuideRef` is checkable in the source
and has not yet been checked. **field, unlocated.**

### FT-227 -- `I` works on the setting screens but not on the checklist, and Back is erratic between them

**Basis: field, and it confirms FT-206 from the field.** *"Setting 14 -- tried
I and it worked, but to go back spacebar and enter did nothing. B went back to
screen 26 where I did not work again."*

So `I` works where `Read-ValidKey` is the reader and fails on the checklist,
exactly as the source predicted. Bill crossed that boundary and felt it.

### FT-228 -- Edge settings cannot be changed without a Microsoft account sign-in

**Basis: field.** *"Checked Edge and it won't let me do anything to Edge
Settings unless I sign in to MS account."*

Environmental, on a machine deliberately running a **local account**. If Edge
hardening cannot be applied on a local account, the tool must say so rather
than offering the change. **Not yet reproduced on CGDELL; worth confirming
there, where a Microsoft account is signed in.**

### Not a defect -- a business decision for Cloud

Bill's item 15: *"when we sell the guide to someone we need to put their name
on every page -- licensed to John Doe, for personal use only, or some such
wording."*

Per-buyer watermarking of the guide. **This is Cloud's lane** (licensing and
product packaging) and is recorded here only so it is not lost. It is not an
FT and no build work follows from it.

---

---

## I. CHECKUP DOES NOT ENCRYPT ON WINDOWS 11 HOME -- CORRECTING A PREMISE

**Basis: measured, `Test_Results\Logs-Harvested\GatewayGuard-Log-2026-08-18_16-18.txt`,
SANDY, ascii41, lines 513-524.**

```
[22:31:15] [INFO] Device Encryption state: Not encrypted (0%), account type:
           Local -- raw: FullyDecrypted
[22:31:29] [GOOD] Device Encryption prereq check -- TPM: True, SecureBoot:
           True, WinRE: True
[22:49:23] [SKIP] BitLocker/Device Encryption: Home edition -- manual path
           shown across 4 screens, no changes made by Checkup
```

**On Windows 11 Home, Checkup changes nothing.** It renders SCREEN-61, 62, 79,
80 and 81 -- the requirements, the recovery key, the Microsoft account route
and how to tell encryption is running -- and then skips. SANDY is Home.

**What this corrects.** Both the briefing and this session's advice treated
SANDY's unencrypted state as something a Checkup run could spend, and the
recommendation on 2026-08-21 was to hold the encryption path for ascii43 to
protect it. **There was nothing to protect.** The path can be walked on any
build at no cost. The state is spent only if Bill follows the on-screen
instructions to completion in Windows Settings himself.

**Briefing section 4 should be corrected**: *"Its value is spent permanently
the first time encryption completes on it"* is true of the machine, but it is
**not** a reason to avoid running Checkup's encryption screens.

**How this was missed.** The advice was given three times before anyone read
the log, and the log had been in the personal OneDrive folder since
2026-08-18. This is the CLAUDE.md rule about state claims carrying their
source, failing in the ordinary way -- reasoning from the fleet table instead
of from a run record.

### FT-229 -- two encryption screens were never seen by the user

**Basis: measured, same log.** SCREEN-79 rendered at **22:31:41**. The next
key was accepted at **22:49:23** -- eighteen minutes later -- and then
SCREEN-80, a second accepted key, SCREEN-81 and the SKIP **all carry the
timestamp 22:49:23.**

Two keypresses in the same second advanced three screens. **The user did not
read screen 30b or screen 31**, and screen 31 is the one that tells them how
to confirm encryption is actually running. This is the FT-171 input-queue
pattern reaching the most consequential screens in the tool.

---

## J. THE SECOND DRIVE IS INVISIBLE TO THE WHOLE TOOL

### FT-230 -- the offline scan covers only `C:`, and no screen says so

**Basis: field (Bill, 2026-08-21) + source.**

The build calls `Start-MpWDOScan` bare, line 4349, with no scope argument.
**Whether Defender's offline environment covers non-system fixed volumes is
NOT MEASURED here** -- it is a claim about Defender, not about Checkup, and
per gate 24's rule it does not get asserted without evidence. Bill reports
from the field that it does `C:` only. **The field wins until measured
otherwise.**

**But the defect does not depend on settling that**, which is why it is
written up now. The offline scan screen, lines 4319-4340, tells the user the
scan *"runs BEFORE Windows loads"*, how long the blue screen lasts, and that
scan time varies. **It says nothing whatsoever about which drives are
covered.** A user with a second data drive is given no way to know it was
skipped.

**This is the third face of FT-167, and that is the real finding.**

| Where | What only sees `C:` |
|---|---|
| FT-167 | Encryption status -- confirmed by ascii39 field finding 13 |
| **FT-230** | **The offline scan** |
| section I | The Home encryption walkthrough, which describes encrypting "your drive", singular |

**SANDY carries a second fixed drive `D:`, 931.5 GB, fully decrypted** --
briefing section 4, measured 2026-08-11. On that machine the tool reports on
roughly a fifth of the storage and describes the result as if it covered the
computer.

**This is a product-scope question, not just a wording fix, and it is Bill's
call.** Three routes:

1. **Say so plainly.** Cheapest and honest -- every scan and encryption
   screen names the drive it covers, and says what to do about the others.
   Fixes the misleading part without widening the tool.
2. **Detect additional fixed drives and warn once.** A single screen: "this PC
   has a second drive, `D:`. Checkup does not check it. Here is how to."
   Costs one screen and a `Get-Volume` call the build already makes.
3. **Cover them.** Widest, and it changes what the product is.

**Recommendation: 2.** It closes the honesty gap, it is one screen, and it
scales to any machine rather than being written for SANDY. Route 1 alone
leaves a senior with a 931 GB drive nobody ever mentioned.

**A prior claim to re-examine while doing this:** the ascii39 quarterly task
shipped a scan that never ran for months while the log printed `[GOOD]`
(FT-162). Scope claims about scans have already been wrong here once.

---

## K. THE RUN LOG -- WHAT IT PROVED, AND THE ONE THING IT REFUTED

**Source: `Test_Results\Logs-Harvested\GatewayGuard-Log-2026-08-19_21-48.txt`,
334 lines, SANDY, ascii42.** Everything in this section is measured from it.

### FT-231 -- the log is named at launch and its entries carry no date, so a multi-day session hides inside a file named days earlier

**This is why the logs appeared to be missing, and it is the first thing to
fix.**

That one file covers **three calendar days**. It opens `Run Date: 2026-08-19
21:48:21` and its last line is `10:12:01` on **2026-08-21**. **Measured: 314
entries carry a time-only prefix and ZERO carry a date.** So read top to
bottom the clock appears to run backwards:

```
[21:48:22]  SCREEN-25 WELCOME BACK              <- 2026-08-19
[10:25:57]  Key 'S' -- START OVER               <- 2026-08-20
[11:37:00]  Checklist command 'R'               <- 2026-08-20
[07:43:43]  Look-back opened                    <- 2026-08-21
[10:12:01]  Sleep prevention deactivated        <- 2026-08-21
```

**Three consequences, in order of cost:**

1. **Today's field run is invisible to anyone looking for today's file.** Two
   sessions were spent this morning searching for a log dated 2026-08-21. It
   does not exist and never will -- the work is inside the 08-19 file. The
   filename is stamped once, at launch.
2. **The footer tells the user to email this file to
   `support@gatewayguard.co`.** Support would receive a log whose timestamps
   jump backwards twice, with nothing on any line explaining why.
3. **Any duration read from it is wrong.** "18 minutes on the recovery key
   screen" in section I is unsafe for exactly this reason -- across a day
   boundary the arithmetic is meaningless.

**Fix for ascii43:** put the date in every entry prefix, or at minimum write a
day-change marker when the date rolls over. The cheapest correct fix is
`yyyy-MM-dd HH:mm:ss` in `Write-Log`, which is one format string.

### FT-232 -- an out-of-range item number is accepted and does nothing

**Measured, 09:18:51.** There are 19 items. Bill typed **21**:

```
[09:18:51] [KEY] Checklist command '21' accepted at: Run-ConsoleMode
[09:18:51] [SCREEN] SCREEN-76 ... 3 item(s) selected
```

Three selected before, three after. The command was **logged as accepted**,
changed nothing, and told the user nothing. Compare the neighbouring lines,
where an unrecognised key at least logs `key ignored`. A number outside the
range is worse than an unknown key: it looks like it worked.

### FT-218 IS CORRECTED -- Ctrl+C did NOT go through the exit confirmation

**The triage above guessed wrong and the log refutes it.** Section H said the
likely path was Ctrl+C reaching `Read-ValidKey`, opening `Confirm-Exit`, and
the confirmation being answered. **Measured: the log contains no `[EXIT]`
line, no `Confirm-Exit`, and no accepted exit key anywhere in 334 lines.** It
ends:

```
[10:09:59] SCREEN-71 (shown as screen 33b) Rendered: YOUR CHOICE [1 of 1]: Edge Password Saving
[10:12:01] [OK] Sleep prevention deactivated -- normal power management restored
           (called from: PowerShell.Exiting engine event (last-resort cleanup))
```

**Only the last-resort cleanup handler ran.** The process was terminated; it
did not exit through its own code path. So **FT-150 is false in the field** --
every log opens by claiming *"Ctrl+C in Mark mode can no longer end the
session"* and this log is the counter-example, written by the build that makes
the claim.

**This is the same shape as the ascii39 "crashes" in briefing section 2, with
the opposite answer.** There, the logs proved Checkup exited through its own
code and no crash occurred. Here the log proves the reverse: no code path ran,
so something outside the program ended it. **The method that settled both was
reading the log rather than reasoning about the source.**

### What the log confirms outright

| Finding | Measured evidence |
|---|---|
| **FT-204** | `07:58:57 'A' -> 19 item(s) selected`, then `07:59:02 'N' -> 0 item(s) selected`. **Nineteen selections destroyed five seconds after being made.** Also at 11:25:29-11:25:33, eight wiped. |
| **FT-206** | **`I` ignored 7 times** on the checklist, across two sessions. `B` ignored twice. |
| **FT-224** | **SCREEN-58 rendered 3 times.** The encryption question is re-asked on *every* `R`, not once -- 08:10, 09:23, 09:49, each after the decline was already `[NOTED]`. |
| **FT-223** | `08:09:34 '12' accepted` then `08:09:35 key ignored (newline)`. Bill's Enter was discarded after every two-digit entry, five times running. |
| **FT-219** | Item 6 sat from `08:17:51` to `08:40:24` -- **22 minutes on one screen** -- ending in `MANUAL REQUIRED -- registry is protected on this PC (Tamper Protection)`. |
| **FT-203** | `10:08:11 [GOOD] Scheduled task created` for both reminders, exactly as FT-203 predicts: the log says GOOD for tasks that will never fire on battery. |

### FT-217 -- the fix already exists in this file

**Measured:** `[11:25:26] [INFO] Checklist columns: window 86, name 24
(content needed 51), status 51 (content needed 94)`.

**The console window was 86 columns and the checklist knew it.** It measures
the window, works out that it needs 51 and 94, and truncates to fit.
`Write-GGBox` does none of that -- which is how the same run painted a box
**378 characters wide into an 86-column window.**

So ascii43 does not need a new technique for FT-217. **It needs
`Write-GGBox` to do what the checklist renderer already does eleven hundred
lines away.**

---

**Next free FT number after this run: 233.**
