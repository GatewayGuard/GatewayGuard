<!-- Dated: 2026-08-21 12:05 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii43 Build Plan -- everything outstanding from ascii39 on

- **Document Name:** GatewayGuard_ascii43BuildPlan
- **Last Modified:** 2026-08-21 12:05 ET
- **Last Editor:** Claude Code (CGDELL)
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

*Closes: FT-167, FT-178, FT-230, ascii41 finding 16.*

**Blocked on one decision from Bill, and only one.** Three routes are set out
in the ascii42 triage section J; the recommendation there is **route 2** --
detect additional fixed drives and warn once on a single screen, naming what
Checkup does and does not cover.

The research half of ascii41 finding 16 -- whether Defender's offline scan can
be pointed at other volumes -- **has never been started** and must be settled
by measurement before any screen text claims anything. Gate 24 applies: a
scan-scope claim is a claim about an external program.

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

- **Every edit through `Tool\gg_edit.py`.** Assert-guarded. **No cosmetic
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

## 6. WHAT IS NEEDED FROM BILL BEFORE F4

**One answer, and only F4 waits on it.** Everything else starts now.

**The second drive -- which route?** Say so and F4 goes in with the rest.
Recommendation: route 2, warn once on one screen.

**Next free FT number: 233.**
