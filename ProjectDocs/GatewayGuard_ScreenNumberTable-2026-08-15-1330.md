<!-- Dated: 2026-08-15 13:30 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# GatewayGuard Screen Number Table -- FT-172

> # SUPERSEDED, 2026-08-15 14:30. DO NOT BUILD FROM THIS FILE.
>
> **The live document is
> `GatewayGuard_ScreenNumberDesign-2026-08-15-1430.md`.**
>
> **Why it was superseded, on the same day it was written.** This file proposes
> **flat numbering** -- branch screens consuming main-line numbers, with gaps
> left where a path skips a branch. Bill chose the **branch-letter** scheme
> instead (8a, 8b), which is better on his own rule 3: branch content never
> consumes a main-line number, so every user walks 1..N unbroken instead of
> seeing gaps that mean nothing to them.
>
> **And it should not have been written yet.** Bill: *"Stop doing work before
> we have 100% agreement on complex issues like this... discuss before you do
> the work."* The requirement was still arriving across five messages while
> this was being produced, which is why it landed with an unresolved cell in
> the middle of it.
>
> **Kept, not deleted,** because the measurements in it are real and
> reproducible (`Tool\Run-ScreenInventory.bat`), and because a superseded
> proposal that says why it lost is worth more than a gap in the record.
> **The numbers in the tables below are dead. The measurements are not.**

- **Document Name:** GatewayGuard_ScreenNumberTable
- **Last Modified:** 2026-08-15 13:30 ET
- **Last Editor:** Claude Code (CGDELL)
- **Status:** **PROPOSAL. Nothing has been built from this.** Check it, change
  it, then it gets built.
- **Source:** the ascii40 source read through the AST
  (`Tool\Run-ScreenInventory.bat`), plus the main-flow call sequence walked
  from the entry point at line 8505.

---

## THE RULES THIS TABLE ENCODES

Bill's, 2026-08-15, in the order he gave them:

1. **One number per screen. Never two screens with the same number.** *"So when
   a user refers to it we know exactly which screen he is talking about."*
2. **Numbers run 1 to X across the whole program**, assigned at BUILD time from
   the viewing order, continuing straight through every branch. Not assigned at
   runtime from what this particular user happened to reach.
3. **The user must never see a number lower than one already seen.**
4. **Skip numbers if you have to.** Gaps are acceptable; going backwards is
   not.
5. **Going back is fine** -- pressing B repaints the previous screen with its
   own lower number, and that is expected, because the user asked for it.
6. `(1 of 2)` / `(3 of 5)` survives as a **group label**, describing a
   multi-page pair. It never does the numbering, and it comes from this table
   rather than being typed into the screen's text.

**Rule 3 is read as applying to FIRST encounters.** A screen you return to
re-shows its own number. This is the reading Claude Code is proceeding on and
it is the one cell Bill has not explicitly confirmed -- see THE OPEN CELL.

---

## WHY A TABLE IS NEEDED AT ALL -- and what was wrong with the last proposal

**The field test plan's diagnosis was wrong and is withdrawn.** It said the
shown-as number *"is written by hand at each call site."* **measured on
ascii40: zero call sites pass a literal number.** `Draw-Box` has no `-Number`
parameter; it calls `Get-ScreenNumber`, which already keeps a lookup table.

So the table Bill asked for in finding 35 half-exists. What is wrong is
**where the number comes from**, not that nobody looks it up:

- `Get-ScreenNumber` counts **at runtime, in encounter order.** The number is a
  property of the RUN, not of the SCREEN. Two users get different numbers for
  the same screen, which is precisely the confusion rule 1 exists to kill.
- **Three screens never reach `Draw-Box` at all** -- bare `Write-Host` at lines
  2833, 2841 and 2852. They are on screen; the counter has never seen them.
  Every screen after them therefore reads LOW by a constant.
- **Eleven numbers are typed by hand into visible text** -- `(Screen 4 of 6)`
  and similar. A typed number cannot agree with a counted one except by luck.

**That constant offset is the whole of findings 3, 4, 6, 7 and 9.** *"Scr 3 ->
4 of 6"*, *"Scr 4 -> 5 of 6"*, *"Scr 5 = 5 of 6"* are not five defects. They
are one arithmetic error seen five times.

**There is also a third numbering surface** nobody had listed: the checklist
header paints `Screen NN -- PAGE p of 2` in its own bar (line 7668).

---

## THE PROPOSED ORDER

Numbers are allocated in blocks, with **gaps left at every branch** so that no
path can force a decrease. `--` in the ID column means the screen has no stable
ID today and needs one.

### Block 1 -- start and intro (1-19)

| No | ID | Screen | Who sees it |
|---|---|---|---|
| 1 | 25 | Resume prompt -- pick up where you left off | only if a checkpoint exists |
| 5 | -- | Welcome to GatewayGuard Checkup | fresh run **(bare Write-Host -- no ID today)** |
| 6 | -- | SCROLLING | fresh run **(bare Write-Host -- no ID today)** |
| 7 | -- | version / build line | fresh run **(bare Write-Host -- no ID today)** |
| 8 | 01 | Font instructions | fresh run, conditional |
| 9 | 28 | Font setup | fresh run |
| 10 | 29 | BEFORE YOU START -- YOUR WINDOW | fresh run |
| 11 | 78 | BEFORE YOU START -- YOUR KEYBOARD | fresh run |
| 12 | 30 | WHAT HAPPENS NEXT -- PLEASE READ | fresh run |
| 13 | 02 | How to scroll back and copy | fresh run |

**Gap 2-4 and 14-19 are deliberate.** The intro is the block most likely to
gain a screen, and a gap means adding one does not renumber the other 60.

### Block 2 -- who and what this machine is (20-39)

| No | ID | Screen | Who sees it |
|---|---|---|---|
| 20 | 31 | Quick re-check before resuming | resuming only |
| 21 | 83 | Are you sure you want to close Checkup? | resuming, and answered N |
| 25 | 05 | Is this your own personal computer? | fresh run only |
| 26 | 32 | Domain-joined warning | fresh run, and domain found |
| 27 | 33 | Administrator access | fresh run, and not admin |
| 30 | 34 | Windows edition | conditional |
| 31 | 35 | RAM | conditional |
| 33 | 36 | Time and date sync | conditional |
| 34 | 37 | Time and date sync -- follow-up | conditional |
| 36 | 09 | System baseline summary | conditional |

**20-21 and 25-27 are mutually exclusive paths** -- resuming, or fresh. No user
sees both, so neither ordering can invert against the other.

### Block 3 -- briefings and scans (40-59)

| No | ID | Screen | Who sees it |
|---|---|---|---|
| 40 | 26 | Security tools briefing | first run |
| 41 | 27 | Scan plan briefing | first run |
| 44 | 10 | Pre-scan gate | conditional |
| 45 | 38 | Defender offline scan | conditional |
| 46 | 39 | Reminder: pre-scan recommended | conditional |
| 47 | 40 | Post-scan guidance | called from inside the pre-scan gate |
| 50 | 41 | Defender primary -- 1 | conditional |
| 51 | 42 | Defender primary -- 2 | conditional |
| 52 | 43 | Defender primary -- 3 | conditional |
| 53 | 44 | Defender primary -- 4 | conditional |
| 54 | 45 | Defender primary -- 5 | conditional |
| 55 | 46 | Defender primary -- 6 | conditional |
| 57 | 13 | Malwarebytes follow-up | conditional |
| 58 | 73 | Malwarebytes follow-up -- 2 | conditional |
| 59 | 47 | Malwarebytes follow-up -- 3 | conditional |

### Block 4 -- settings review (60-74)

| No | ID | Screen | Who sees it |
|---|---|---|---|
| 60 | 48 | Malwarebytes follow-up -- 4 | conditional |
| 62 | 49 | Power / battery warning | on battery only |
| 64 | 50 | Power settings review | conditional |
| 66 | 51 | Apps audit | conditional |
| 68 | 52 | Mode selector | all users |
| 70 | 74 | Scope disclaimer -- intro | conditional |
| 71 | 53 | Scope disclaimer | conditional |
| 72 | 54 | What Checkup does and does not do **(1 of 2)** | conditional |
| 73 | 75 | What Checkup does and does not do **(2 of 2)** | conditional |

**72 and 73 are the group-label case.** They are two pages of one idea, so they
carry `(1 of 2)` and `(2 of 2)` from this table -- and the typed versions at
source lines 6248 and 6287 get deleted.

### Block 5 -- the checklist and applying settings (75-99)

| No | ID | Screen | Who sees it |
|---|---|---|---|
| **75** | **76** | **Checklist, page 1** | **all users, MANY TIMES -- see THE OPEN CELL** |
| **76** | **77** | **Checklist, page 2** | **all users, MANY TIMES -- see THE OPEN CELL** |
| 80 | 55 | Console mode screen | conditional |
| 82 | 56 | Non-recommended selections -- review stage | conditional |
| 83 | 57 | Non-recommended selections -- final stage | conditional |
| 85 | 59 | Console mode -- 2 | conditional |
| 87 | 69 | Console mode -- 3 | conditional |

### Block 6 -- BitLocker, always last (100-129)

**This block needs the closest check and is the least settled.** Fourteen
screens across five functions that call each other -- `Show-BitLockerHomeScreen`
alone holds seven, and `Show-BitLockerWhyEncrypt` and
`Show-BitLockerFinalDecline` are reached from inside it rather than from the
main flow.

| No | ID | Screen |
|---|---|---|
| 100 | 58 | BitLocker decline -- heads up |
| 102 | 60 | Why encrypt |
| 105 | 61 | Home edition -- 1 |
| 106 | 63 | Home edition -- 2 |
| 107 | 62 | Home edition -- 3 |
| 108 | 79 | Home edition -- 4 |
| 109 | 82 | Home edition -- 5 |
| 110 | 80 | Home edition -- 6 |
| 111 | 81 | How to tell if encryption is running |
| 115 | 64 | BitLocker main -- 1 |
| 116 | 65 | BitLocker main -- 2 |
| 117 | 66 | BitLocker main -- 3 |
| 118 | 67 | BitLocker main -- 4 |
| 120 | 68 | BitLocker final decline |

### Block 7 -- wrapping up (130-139)

| No | ID | Screen |
|---|---|---|
| 130 | 70 | Scheduled tasks set up |
| 132 | 23 | Convenience review |
| 133 | 71 | Convenience review -- 2 |
| 135 | 72 | Manual steps |

---

## THE OPEN CELL -- the checklist, and it is the only one

**The checklist is a hub.** `:checklistLoop while ($true)` at line 7808. The
run is: checklist -> pick a setting -> setting screen -> **back to the
checklist** -> next setting -> back again. It is the screen the user spends
most of their time on, and it is returned to dozens of times per run.

Under this table it is screen 75/76, and the settings screens it launches are
higher. **So every return to the checklist shows a lower number than the screen
just left.**

**Skipping numbers cannot fix this**, which is why it survived rule 4: the hub
has ONE number by rule 1, so returning to it shows that number again however
the numbers are allocated. Giving it a fresh higher number on each visit would
mean several screens numbered 75, 79, 83 that are all the same screen -- a
direct breach of rule 1, the requirement Bill has stated three times.

**Three ways out. The third is what this table assumes.**

1. **The hub carries no number.** It says `Checklist` where other screens say
   `Screen 41`. Honest, and it removes the number from the one screen a user is
   most likely to be looking at when they phone for help.
2. **The hub is numbered last** -- give it a number above everything it
   launches. Then the FIRST visit goes down instead, and every later one goes
   up. Worse, not better.
3. **Revisits are exempt.** A screen you have already seen re-shows its own
   number, and that is not "going backwards" -- it is returning somewhere you
   know. Only first encounters must ascend. **This is what the table above
   assumes, and it is consistent with Bill's "going back is fine."**

**If 3 is right, nothing else in this table changes.** If Bill wants 1 or 2,
only the checklist rows move.

---

## WHAT ELSE THE BUILD HAS TO DO

1. **Give the three bare `Write-Host` intro screens stable IDs** and paint them
   through `Draw-Box`, or they stay invisible to the count. **This is the
   single change that removes the constant offset Bill measured.**
2. **Delete all eleven typed numbers** from screen text. The table is the only
   source.
3. **`Get-ScreenNumber` reads this table** instead of counting.
4. **Extend gate 12 to fail the build** if: a screen ID is missing from the
   table, appears twice, names a screen that does not exist, two screens
   resolve to the same number, or any typed `N of M` reappears in screen text.
5. **Update CLAUDE.md**, which currently records the opposite decision -- *"on
   screen the user sees position in their journey."* That was the runtime
   model and this supersedes it.

---

## WHAT IS MEASURED HERE AND WHAT IS NOT

- **measured:** the set of screens, their IDs, their enclosing functions,
  whether each sits inside a branch, the eleven typed numbers, and the
  checklist loop. All from the AST, reproducible with
  `Tool\Run-ScreenInventory.bat`.
- **measured:** the main-flow call sequence, walked from the entry point at
  line 8505.
- **inferred:** the order WITHIN blocks 5 and 6, and every screen title in
  this document. Titles were read from the source but not verified on screen.
- **not established:** that no two screens can appear in opposite orders on
  different paths. Blocks 5 and 6 are where such an inversion would live, and
  the table cannot be trusted until that is checked screen by screen. **A gate
  that walks every path and asserts numbers ascend is the way to prove it, and
  it should be built alongside the table rather than after it.**
