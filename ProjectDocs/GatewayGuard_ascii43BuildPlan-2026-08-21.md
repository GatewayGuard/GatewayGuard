<!-- Dated: 2026-08-21 17:50 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii43 Build Plan -- everything outstanding from ascii39 on

- **Document Name:** GatewayGuard_ascii43BuildPlan
- **Last Modified:** 2026-08-21 17:50 ET
- **Last Editor:** Claude Code (CGDELL)
- **Update 2026-08-21 17:50:** F4 route **decided by Bill -- route 3, cover the
  other drives.** Section 3 F4 and section 7 updated with the decomposition and
  the measured scan constraint. Next-free-FT corrected 233 -> 236.
- **Asked for by Bill, 2026-08-21:** *"I want the next build to incorporate all
  the outstanding test results from ascii39 on."*
- **Base:** ascii42 -- `Tool\W11-SecurityHardening-v3-ascii42-2026-08-19-1830.ps1`,
  8,921 non-blank / 9,301 total
- **Launch:** 2026-09-01. **Eleven days.**

**This plan does not restate the findings.** They live in three triage
documents and are not copied here, because a copy goes stale and this project
has been bitten by exactly that. This document is the **grouping and the
order**. The detail is in:

- `GatewayGuard_FieldTestTriage-ascii40run1-2026-08-17.md`
- `GatewayGuard_ascii41Findings-FixedOrNot-2026-08-19.md` (the 32 not fixed)
- `GatewayGuard_FieldTestTriage-ascii42run1-2026-08-21.md` (FT-204 to FT-232)

---

## 1. WHAT IS ACTUALLY OUTSTANDING

| Run | Findings | Still open |
|---|---|---|
| ascii39 | 49 numbered, plus FT-161 to FT-169 | the FT-167 disk lineage, FT-109/FT-161 task verification |
| ascii40 | 11 findings, FT-171 to FT-192 | FT-184, FT-173-residual, FT-178, FT-175b, FT-186, FT-187, FT-188, FT-192 |
| ascii41 | 38 findings | **32** -- 10 located and filed, 21 wording and content, 1 research |
| ascii42 | -- | **29** -- FT-204 to FT-232 |

**Roughly seventy open items.** But that number is misleading, and acting on
it as seventy separate edits is the wrong way to build this.

---

## 2. THE THING THAT MAKES THIS BUILDABLE

**They are not seventy defects. They are six families plus a wording block,
and the same underlying fault has been reported under many numbers.**

Three examples, and this is measured against the triage documents rather than
asserted:

- **Console width.** FT-199 (*"characters cut off at the end of each item"*,
  ascii41 finding 36), ascii41 finding 31 (*"column widths"*), and FT-217 (the
  378-character box) are **one fault**: the tool has no single answer to "how
  wide is the window." The checklist measures it and truncates; `Write-GGBox`
  does not. One fix closes all three.
- **The second drive.** FT-167 (ascii39), FT-178 (ascii40, *"only one disk is
  reported"*), ascii41 finding 16 (*"can the offline scan cover all drives"* --
  recorded as **research not started**), and FT-230 (today). **Bill has now
  raised this four times across four builds.** It is one product decision, not
  four bugs.
- **What a key means.** FT-196 (*"still have to press Enter after a letter"*),
  ascii41 finding 9 (*"no B on that prompt"*), FT-173-residual, FT-204 (`N`
  wipes the checklist), FT-206 (`I` dead on the checklist), FT-207 (no exit
  advertised), FT-223 (Enter discarded after two digits), FT-225 (`N` means
  Back on screen 27), FT-232 (out-of-range number silently accepted). **Nine
  numbers, one fault:** the tool has no keyboard contract, so every screen
  invents one.

**So the build is six coherent changes, not seventy scattered ones.** That
also rescues Playbook Class 6 rule 3 -- one change class per build -- which a
seventy-edit scatter would flatly break.

---

## 3. THE SIX FAMILIES, IN BUILD ORDER

Ordered by **risk of shipping it wrong**, not by how loud the finding was.

### F1 -- THE KEYBOARD CONTRACT

*Closes: FT-204, FT-206, FT-207, FT-223, FT-225, FT-232, FT-196,
FT-173-residual, ascii41 findings 9 and 27.*

One rule written once and applied everywhere:

- **`B` is Back. Always. Only.** `N` never means Back -- FT-225.
- **`N` is never destructive.** Deselect-all moves to `C = Clear all`, and
  confirms -- FT-204.
- **`I` works at every prompt**, including the checklist's own reader --
  FT-206.
- **Every prompt states its exit.** One edit in the unrecognised-key message
  covers all 47 `Read-ValidKey` prompts -- FT-207.
- **Letters commit on the keypress; numbers commit on the second digit or
  Enter, and say so** -- FT-223, FT-196.
- **An out-of-range number is rejected out loud** -- FT-232.

**Highest value in the build.** It is also the family most likely to be got
subtly wrong, which is why it goes first while attention is fresh.

### F2 -- CONSOLE WIDTH

*Closes: FT-217, FT-199, ascii41 finding 31.*

`Write-GGBox` splits each line on its embedded newlines **before** measuring,
and clamps the result to the window width. **The technique already exists in
this file** -- the checklist logs `window 86, name 24 (content needed 51)` and
truncates to fit. Reuse it; do not invent a second one (D-18 pointed inward).

Add a **width check to gate 12b**, which today counts lines only. A box wider
than the window fails the build.

### F3 -- THE LOG

*Closes: FT-231, FT-188.*

- **Date on every entry**, or a day-change marker. One format string in
  `Write-Log`. Without it a multi-day session hides inside a file named for
  the day the window opened -- which is what happened to this run, and cost
  two sessions searching for a file that does not exist.
- **Absent registry keys stop being logged as ERROR** in the customer's log --
  FT-188.

**Smallest family, and it protects every future field run.** Do it early so
the ascii43 run itself benefits.

### F4 -- THE SECOND DRIVE

*Closes: FT-167, FT-178, FT-230, FT-234, ascii41 finding 16.*

**DECIDED, Bill 2026-08-21: route 3 -- cover the other drives.** Not route 2's
warn-once. The widest of the six families and the one that must be field-run on
SANDY before it is trusted.

**"Cover them" splits across the three surfaces that today see only `C:`:**

| Surface | Build | Basis |
|---|---|---|
| **AV coverage** (FT-230) | Keep the offline scan for the boot/rootkit job on `C:`; **add `Start-MpScan -ScanType FullScan`** (covers all mounted fixed drives, `D:` included) when a second fixed drive is detected | see constraint below |
| **Encryption status** (FT-167/178) | Report **each** fixed drive's encryption state, not only `C:` | the build already enumerates every disk since FT-178 |
| **Encryption walkthrough (Home)** | Extend the manual-steps screens to name `D:` as well | wording on existing screens |
| **FT-234** | If WinRE is disabled the offline scan silently does nothing -- guard it here | same class as the ScanType-4 defect (FT-162) |

**The measured constraint that shaped this.** *measured on CGDELL 2026-08-21:*
`Start-MpWDOScan` (the offline scan Checkup runs today) has **no scope, path or
drive parameter** -- it cannot be aimed at a volume. `Start-MpScan` **does**
take `-ScanType {FullScan | QuickScan | CustomScan}` and `-ScanPath`. So D:
coverage comes from a **full online scan, not the pre-boot offline scan.** That
is the correct tool for `D:` regardless: `D:` is a **data drive, not bootable**,
so the offline scan's rootkit job never applied to it. **The screen wording
must say "full scan of all your drives," not "offline scan."**

**Gate 24 prerequisite, and it is a hard gate.** The behavioural claim that a
full scan actually completes and covers `D:` **must be measured on SANDY**
(which has the 931 GB `D:`; CGDELL has no large second drive) **before any
screen text claims coverage.** The cmdlet surface is measured; the behaviour is
not yet. A full scan is also slow -- the screen must set that expectation.

### F5 -- FLOW AND SEQUENCING

*Closes: FT-219, FT-224, FT-197, FT-195, FT-195(a), FT-175b, FT-184.*

- **Stop asking permission for a change the user already selected** --
  FT-219, reported five times in one run, the most frequent complaint on
  record.
- **Ask the encryption question once, not on every `R`** -- FT-224, measured
  three renders in one session after the decline was already `[NOTED]`.
- **`1a` must not render before `1`** -- FT-195(a).
- **The offline scan gate on a resume** -- FT-175b, a known incomplete fix.
- **FT-184**, the flash before screen 1, unlocated after three builds. **Time-
  box it.** If it is not found in the budget agreed below, it is recorded and
  carried, not chased.

### F6 -- WORDING AND SCREEN SPLITTING

*Closes: the 21-item block from ascii41, plus FT-220, FT-221, FT-226.*

**The largest block by count and the lowest risk by nature.** None of it is
blocked on anything. Two items in it are not wording at all and must not be
treated as such:

- **FT-221** -- setting 15 must read the password-manager answer the tool
  already has. Turning off browser password saving before a manager exists
  leaves the user with **no password store at all**.
- **FT-220** -- settings 9, 12, 13 and 17 never say why the current state is
  bad. **The guide is silent too**, so this moves under RULE W-07 with the
  guide, not ahead of it.

---

## 4. WHAT IS DELIBERATELY NOT IN ascii43

Stated so it is a decision and not an omission.

- **FT-214, FT-215, FT-213 -- the screen gallery.** `Show-AllScreens.bat` is a
  **developer tool**, not a customer path. Its `B` key and mouse wheel do not
  ship. Fix after launch unless Bill says otherwise.
- **FT-198** (`M`/`K`/left-click) -- needs measuring on SANDY first, and
  ascii41's own record says so.
- **FT-228** (Edge needs a Microsoft account) -- environmental, not yet
  reproduced on a second machine.
- **The checklist "change nothing" path** -- recommended against in the ascii42
  triage; Bill's call and not yet made.

---

## 5. HOW IT GETS BUILT WITHOUT BREAKING

**This is the part that matters most, because a seventy-item build is exactly
how ascii34 was corrupted on 2026-07-25.**

- **Every edit through `Tool2\gg_edit.py`.** Assert-guarded. **No cosmetic
  exemption** -- the ascii34 corruption came from a lint pass.
- **One family per commit**, six commits, each independently revertable. If F6
  goes wrong, F1 through F5 survive.
- **After every family:** `[Parser]::ParseFile` clean, line count plausible,
  and gates 12/12b/24/25 run. Brace balance is *not* sufficient -- the
  corrupted ascii34 was perfectly balanced and destroyed.
- **`Run-ScreenCoverageCheck.bat`, `Run-ExternalCommandCheck.bat`,
  `Run-CopyCheck.bat`, `Run-GGEditSelfTest.bat`** before the build is called
  done.
- **`Run-ConsoleInputModeCheck.bat` on SANDY**, not CGDELL. The two machines
  differ in the way that matters -- SANDY is conhost, CGDELL is Windows
  Terminal.

**The honest risk.** ascii42 changed four things and shipped two defects that
made the checklist unusable. ascii43 as scoped changes six families touching
most of the file. **The families are what makes it survivable, and the
per-family commit is what makes it recoverable** -- but this is a large build
eleven days from launch, and it should be field run before it is trusted.

**If the schedule tightens, cut from the bottom.** F6 is the biggest and the
safest to defer; F1, F2 and F3 are the ones that make the tool behave like a
finished product.

---

## 6. DECISIONS TAKEN, 2026-08-21

### ascii44 WILL FOLLOW -- ascii43 is not the shipping build

**Bill, 2026-08-21.** ascii43 is built in full, field run on SANDY, and a
smaller ascii44 ships on 2026-09-01.

**This is what makes the plan above safe.** F6 -- the wording and
screen-splitting block, the largest and the one touching the most screens --
can go into ascii43 rather than being gambled on or deferred, because the
field run catches what it breaks. Without the follow-up build the correct
plan was a much smaller ascii43.

**It costs schedule.** The run and ascii44 need roughly four of the eleven
remaining days, so ascii43 has to be finished and handed over with time to
spare. Section 5's per-family commits are what make that recoverable if a
family has to be dropped late.

### FT-220 WAITS FOR THE GUIDE -- W-07 applied strictly

**Bill, 2026-08-21: wait for the guide rewrite before FT-220.**

Settings 9, 12, 13 and 17 ship in ascii43 **exactly as they are**. They state
what will change and not why the current state is bad. **That is thin, and it
is not wrong** -- nothing on those screens is incorrect.

**This is the strictly correct reading of RULE W-07:** the guide settles
substance, the screens follow it. Writing the explanations into the tool first
would mean inventing substance in the screens and then making the guide agree
with it afterwards, which is the drift W-07 exists to prevent, pointed inward.

**So FT-220 moves out of F6 and becomes ascii44 scope**, gated on the guide
rewrite from v9 landing. Commissioned from Cloud 2026-08-21 --
`Cloud-GuideRewrite-2026-08-21.txt` names the four settings and exactly what
the guide must answer for each.

**FT-221 is NOT affected and stays in ascii43.** It is not a wording item: the
tool already knows the user's password-manager answer and ignores it, and
turning off browser password saving before a manager exists leaves them with
no password store at all. That is a logic fix and needs no guide text.

**FT-226 stays in ascii43 in part.** Setting 17's missing `GuideRef` is a
data fix in the settings table and does not wait. Its *explanation* waits with
FT-220.

---

## 7. NOTHING BLOCKS THE BUILD -- F4's DECISION IS MADE

**The second drive is decided: route 3, cover the other drives** (Bill,
2026-08-21). See section 3 F4 for the decomposition. **One gate-24 prerequisite
remains inside F4, not blocking the other five families:** the full-scan
behaviour must be measured on SANDY before F4's screen text claims coverage.

Everything else starts now.

**Next free FT number: 236.** *(Corrected from 233 -- FT-233 and FT-234 were
assigned in the offline-scan research and FT-235 in the ascii42 triage
section L.)*
