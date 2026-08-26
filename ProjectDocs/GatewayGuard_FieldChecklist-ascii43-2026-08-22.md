<!-- Dated: 2026-08-22 13:40 ET -->
<!-- Editor: Claude Code (CGDELL) -->
<!-- Update 2026-08-21 17:50: F4 second drive decided -- route 3 (cover the
     other drives). READ-FIRST point 2 and the F4 section updated. -->
<!-- Update 2026-08-22 13:40: FT-226 corrected in two places -- the checklist
     said setting 17's guide page number ships in ascii43. It does not; the fix
     was reverted and the finding was misfiled. Left as a testable item it
     would have produced a false field finding. See PART A item 2 and PART C. -->
<!-- Update 2026-08-26 12:40: READ-FIRST point 1 corrected (it still said "not
     built yet"); PART A items 8 and 9 added (setting 6 Unknown is correct
     behaviour, setting 14 widgets not testable); PART E added -- put SANDY
     back before the run. -->
<!-- Update 2026-08-22 14:05: PART B MARKED UP against the half-built ascii43.
     Every bullet tagged TESTABLE / PARTIAL / NOT BUILT / WRONG AS WRITTEN by
     reading the code path -- 11 testable, 1 partial, 8 not built, 1 wrong,
     1 withdrawn.
     Written before any of ascii43 existed, Part B listed every intended fix as
     though it shipped; a run against it would have produced false findings and
     re-tested a decision Bill had already made. -->
# ascii43 Field-Run Instructions -- what to skip, what to look for

- **Document Name:** GatewayGuard_FieldChecklist-ascii43
- **Last Editor:** Claude Code (CGDELL)
- **Machine to run on:** SANDY (conhost, Home, local account, the D: drive, unencrypted)
- **Sources this is built from (not restated -- read them if you want the detail):**
  `GatewayGuard_ascii43BuildPlan-2026-08-21.md` (the six families) and
  `GatewayGuard_FieldTestTriage-ascii42run1-2026-08-21.md` (FT-204 to FT-235).

---

## READ THIS FIRST -- two facts that frame everything below

1. **CORRECTED 2026-08-26. This said "ascii43 IS NOT BUILT YET."** That was
   written on 2026-08-21 and was overtaken the next day by the PART B markup,
   which is the authority. **ascii43 is HALF BUILT and is worth running now.**

   - **In the build:** F1 (keyboard contract), F2 (console width), F3 (the log),
     F5 (flow and sequencing), and **part** of F6.
   - **Not in the build:** **F4 entirely**, the F5 remnants, the F6 wording
     block, setting 1 pause detection, setting 14 three-way plus its Revert
     string, and the setting 6 rename.
   - ***measured 2026-08-26:*** the file parses with **0 errors**, at
     **9,382 total / 9,002 non-blank** lines -- unchanged since 2026-08-22, so
     every PART B tag below still describes the file you will run. **Gates 12,
     12b and 24 all PASS.**
   - **Run it as a defect hunt, not an acceptance test.** It is not the
     shipping build; ascii44 is.

2. **The one decision that was open is now made.** The **second drive (F4)** is
   **route 3 -- Checkup covers the other drives** (Bill, 2026-08-21). See F4
   below for what to look for. Nothing else about this build is open.

---

## PART A -- WHAT TO SKIP (not handled in ascii43; do not re-report these)

Stated so each is a decision, not a gap.

1. **The screen gallery (`Show-AllScreens.bat`).** It is a **developer tool,
   not a customer path.** Its broken keys do **not** ship in ascii43:
   - **FT-213** (Ctrl+A dead), **FT-214** (B dead until another key wakes it),
     **FT-215** (mouse wheel stops). Fixed after launch.
   - *(One cheap half does ship -- see F3: the log-header wording. The gallery
     navigation itself does not.)*

2. **"Why the current state is bad" on settings 9, 12, 13 and 17 (FT-220).**
   **Deferred to ascii44** -- it waits on the guide (RULE W-07). On ascii43
   these four screens still say **what** changes, not **why** the current state
   is bad. **Do not re-report "doesn't explain why" for 9/12/13/17** -- it is
   known and deliberately held.
   - *(**CORRECTED 2026-08-22. This bullet said the FT-226 data fix "IS in
     ascii43." It is not, and the finding itself was misfiled.** Setting 17
     always HAD a guide reference -- `GuideRef="Keep vs. Disable Table"`, in
     ascii40, 41, 42 and 43. The real defect is a **class**: settings **10, 11,
     12, 17, 18 and 19** all point at that same table name, which is not a page
     number, so all six show a reference the reader cannot turn to. The class
     fix is **deferred until the guide structure is locked** -- 17 has already
     moved between sections in one draft revision, and setting 10 has no
     section at all. **Do not report setting 17's guide reference.** Measured:
     `Tool\W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1` line 5634.)*

3. **FT-198** (M / K / left-click behaviour) -- needs a separate SANDY
   measurement before it can be fixed. Not in this build.

4. **FT-228** (Edge will not change settings without a Microsoft-account
   sign-in) -- environmental, seen on SANDY's local account, **not yet
   reproduced on CGDELL.** Not addressed in ascii43. If you hit it again, one
   line naming the machine is enough; do not chase it.

5. **The checklist "look but change nothing" path (FT-205).** Recommended
   against and not built (Q is the no-change exit). If you want it, that is a
   product decision to make first.

6. **FT-233** (recovery key demanded at reboot) -- **settled by your own field
   evidence:** the TPM releases the key unattended on an encrypted machine, no
   prompt. No code change. Nothing to test.

7. **FT-184** (a flash before screen 1) -- **time-boxed.** It has been unlocated
   for three builds. If you see it, one line is plenty; it is not worth a hunt.

8. **ADDED 2026-08-26. Setting 6, Edge Phishing Protection, will report
   "Unknown -- Tamper Protection blocks this check; verify by hand."**
   **That is CORRECT behaviour. Do not report it.**
   - ***measured on SANDY, elevated,*** `SandyChecks-SANDY-2026-08-26_11-14.txt`:
     `WTDS\Components` returns **"CANNOT READ -- Requested registry access is
     not allowed."** CGDELL refuses identically.
   - The build's own line 5931 explains why it can never come right: Checkup
     recommends Tamper Protection, and every machine that follows that advice
     makes this read fail permanently. Reporting **Unknown** instead of
     inventing a verdict is the FT-141 fix working.
   - **Two real defects were found here on 2026-08-26 and are already recorded**
     -- `CanAuto=$true` is untrue, and line 6406 says "turn ON all 3 options"
     beside four visible boxes. **Both are ascii44 work. Neither is a field
     finding.** See `GatewayGuard_FieldResult-PhishingProtection-2026-08-26-1130.md`.

9. **ADDED 2026-08-26. Setting 14's lock-screen third is not built.** Today's
   field test proved the lock screen widget toggle is automatable
   (`GatewayGuard_FieldResult-LockScreenWidgets-2026-08-26-1030.md`), but
   **that finding lands in ascii44.** ascii43 still writes only
   `Policies\Microsoft\Dsh`, the taskbar board. **Nothing about widgets is
   testable on this run.**

---

## PART B -- WHAT TO LOOK FOR (the ascii43 fixes to verify), BY FAMILY

> ### MARKED UP 2026-08-22 -- ascii43 IS HALF BUILT. READ THIS BEFORE TESTING.
>
> **This part was written on 2026-08-21, before any of ascii43 existed**, so it
> lists every intended fix as though all of it ships. It does not. Each bullet
> below now carries a tag, decided by **reading the code path, not by counting
> FT comment tags** -- a missing tag is not proof a fix is missing, and one of
> these was built with no tag at all.
>
> | Tag | Means |
> |---|---|
> | **[TESTABLE]** | The mechanism is in the build. A failure here is a real finding |
> | **[PARTIAL]** | Built in one place, not everywhere the bullet claims. The bullet says where |
> | **[NOT BUILT -- SKIP]** | Not written yet. It WILL fail. **Do not report it** |
> | **[FT-236]** | The bullet contradicts a decision you already made. A defect in THIS document, not a build fact -- so it carries an FT number and gets fixed once, instead of being re-tagged every build. Cloud's point, 2026-08-22 |
>
> **Count, by bullet: 11 testable, 1 partial, 8 not built, 1 defect (FT-236),
> 1 withdrawn -- 22 in all. Four of the eight not-built are the whole of F4.**
> **Families F1, F2, F3 and F5 are worth a run now. F4 is entirely absent.**
>
> Measured against `Tool\W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1`,
> and where a before/after was needed, against
> `Builds\W11-SecurityHardening-v3-ascii42-2026-08-19-1830.ps1`.

The build is six families. Test them roughly in this order.

### F1 -- THE KEYBOARD CONTRACT  *(the biggest behaviour change -- test it hard)*

- **[FT-236]** ~~**B is the ONLY "Back" key, everywhere.** `N` must
  **never** take you back.~~ **This bullet contradicts your own decision.** You
  ruled that **`N = go back` STAYS** as the natural answer in a real Y/N
  question; FT-225 was then scoped down to **the one genuinely inconsistent
  screen**, and that narrowed fix is **not built** (0 occurrences in the
  source). `N = Go back` is correct and deliberate at lines 3825, 6236, 6239,
  7432, 7458, 7461 and 7983. **Do not report any of them.** Nothing in this
  bullet is testable in ascii43.
- **[TESTABLE]** **N is never destructive on the checklist.** "Deselect all" has moved to
  **`C = Clear all`**, and it **asks you to confirm** before wiping. Pressing
  **N should no longer wipe your selections.**
  *(Last run, N destroyed 19 selections five seconds after you made them --
  FT-204. This is the single most important thing to confirm.)*
  **Verified present:** the legend at line 8269, the `C` branch with its Y/N
  confirmation at 8415-8434, and **`N` is no longer a case in the checklist
  switch at all**, so it now does nothing.
- **[TESTABLE]** **`I` works at every prompt, including the checklist** (shown-screens 25/26).
  Press I on the checklist -- it should show your build and Machine ID.
  *(Last run, I was dead on the checklist -- FT-206 / FT-227.)*
- **[PARTIAL]** **Every prompt tells you an exit exists.** Press an
  unrecognised key -- the message should say how to get out. *(FT-207.)*
  **Built in ONE of the three readers.** `Read-ValidKey` prints *"To leave
  Checkup at any time, press Ctrl+C"* (line 2698). **`Pause-ForUser` (line
  2508) and `Read-NavKey` (line 2738) do not** -- and `Pause-ForUser` is the
  reader behind most page prompts. **So: test it at Y/N/S questions, where it
  should work. Do not report its absence on a plain "press Enter to continue"
  page** -- that half is not written.
- **[TESTABLE]** **Two-digit vs one-digit is explained.** Typing "12" commits on the second
  digit; a single digit waits for Enter -- and the screen now **says which.**
  Your Enter after a two-digit number should not be swallowed.
  *(Last run it was discarded five times running -- FT-223.)*
- **[TESTABLE]** **An out-of-range number is refused out loud.** Type **21**
  when there are 19 items -- it should say no, not silently accept it.
  *(FT-232.)* **Verified present**, lines 8763-8770: it prints *"There is no
  item N. Item numbers run 1 to 19."*

### F2 -- CONSOLE WIDTH

- **[TESTABLE]** **No giant boxes.** The convenience / review screens -- Advertising ID,
  Diagnostic data, Edge Startup Boost, Widgets, Edge Password Saving (the
  shown-screen 33b area) -- should **fit your window.** *(Last run, the Edge
  Password Saving box painted 378 characters wide into an 86-column window --
  FT-217. Five of those screens were over-wide; you met the worst one.)*
  **Verified present:** `Write-GGBox` now refuses to paint wider than the
  window and reserves the frame (lines 2130-2141). It also writes a `WARN` to
  your log whenever it truncates a line -- **if the boxes fit but the log
  carries those warnings, say so**, because that means content is being cut
  rather than the screen properly split.

### F3 -- THE LOG  *(open it with `Open-My-Log.bat`)*

- **[TESTABLE]** **Every entry now carries the date** (or a day-change marker). A multi-day
  run should read in forward time order, and **today's run should be findable
  by today's date.** *(Last run, one file spanned three days with time-only
  stamps, so the clock appeared to run backwards and today's log "went missing"
  -- FT-231.)*
  **Verified by before/after, and this one carries NO FT comment tag** -- it was
  found by reading the code, which is why tag-counting is not the check:
  ascii42 line 1731 stamps `'HH:mm:ss'`; ascii43 line 1731 stamps
  `'yyyy-MM-dd HH:mm:ss'`.
- **[NOT BUILT -- SKIP]** ~~**The log header no longer over-promises.**~~
  **It still does, word for word.** The header at line 1720 still reads *"if
  the program ends unexpectedly, the LAST LINE below shows exactly where it
  was"* -- byte-identical to ascii42. **This is the one item in F3 that will
  fail. Do not report it.** *(FT-235.)*
- **[TESTABLE]** **Absent registry keys read as INFO, not ERROR** in your log.
  *(FT-188.)* Shipped in **ascii41** (line 3117), not new here -- so it is a
  carry-forward check, and a failure would be a regression.

### F4 -- THE SECOND DRIVE  *(route 3 -- Checkup COVERS the other drives)*

> **[NOT BUILT -- SKIP THE WHOLE FAMILY.] None of the four items below is in
> ascii43.** Measured on the mechanism rather than on comment tags: the source
> contains **zero** occurrences of `Start-MpScan`, `FullScan`, "second drive",
> "other drives", FT-230 or FT-234. All four bullets will fail, and none of
> those failures is a finding.
>
> **It is also gate-24-blocked**, which is why it is last: the screen wording
> cannot be written until a full scan is measured actually covering `D:` on
> SANDY. `Start-MpWDOScan` has no scope parameter, so that coverage has to come
> from `Start-MpScan -ScanType FullScan`, a full **online** scan -- and the
> screen must say **"full scan of all your drives"**, never "offline scan".
>
> **Kept below, unmarked, as the spec for when it is built.**

On SANDY (which has the 931 GB `D:`), look for all of these:

- **A FULL scan that covers all your drives, D: included.** This is **not** the
  pre-boot "offline" scan -- that one can only do the system drive. The screen
  should say **"full scan of all your drives,"** and warn you it takes a while.
  Confirm it actually runs against `D:`. *(FT-230.)*
- **Encryption status reported for D: too,** not only `C:`. *(FT-167 / FT-178.)*
- **The encryption walkthrough names D:** where it applies.
- **A WinRE guard:** if the offline scan is unavailable (WinRE turned off), the
  tool should say so, not silently do nothing. *(FT-234.)*

**Note (superseded 2026-08-22):** this said the full-scan behaviour would be
measured on SANDY during the build, so that a miss would be a real finding.
**The build did not get that far.** The measurement is still owed, and it is
the thing that unblocks the family.

### F5 -- FLOW AND SEQUENCING

- **[TESTABLE]** **No asking permission for a change you already selected.** After you pick
  item #6 to run, the next screen should **explain how to do it** -- not ask
  "do you want to apply this?" again. *(Your most frequent complaint last run,
  five times -- FT-219.)* **Verified present**, line 8676.
- **[TESTABLE]** **The drive-encryption question is asked ONCE, not on every
  `R`.** Decline it once; pressing R again should not re-ask. *(Last run it
  re-asked three times -- FT-224.)* **Verified present**, line 8459.
- **[NOT BUILT -- SKIP]** ~~**"1a" should not appear before "1".**~~ Not
  written; 0 occurrences of a fix, and screen 25 is still labelled `1a` in the
  label table (line 1861). **It will still happen. Do not report it.**
  *(FT-195a.)*
- **[TESTABLE]** **A resume run offers the offline scan.** *(FT-175b.)*
  **Present since ascii41** -- the offer sits on the repeat/resume branch at
  lines 4319 and 4333, so this is a carry-forward check and a failure would be
  a regression. *(Note: the briefing lists FT-175b among the unbuilt "F5
  remnants". The mechanism IS in the file. If something further was intended
  here it is not written down anywhere I can find -- worth settling before the
  run.)*

### F6 -- WORDING AND LOGIC

- **[TESTABLE]** **Setting 15 (browser password saving) ties to your
  password-manager answer.** It should **not** tell you to turn off browser password saving
  unless you have already said you have a password manager set up -- otherwise
  you would be left with no password store at all. It should read **"Requires
  manual change by you,"** with different wording depending on your earlier
  answer. *(FT-221 -- a logic fix, not just wording.)* **Verified present**,
  lines 6478 and 6485; it logs a `SKIP` naming FT-221 when it declines to
  disable.
- **[NOT BUILT -- SKIP]** ~~**Applied settings lose their X on the
  checklist.**~~ Not written. There is no clear-on-apply path -- the only
  `Selected = $false` writes are the GOOD auto-skip (6178, 6188), two
  Edge-specific cases (6654, 6682) and `C = Clear all` (8429). **The X will
  stay. Do not report it.** *(FT-222 -- it belongs to the unbuilt F6 wording
  block.)*
- ~~**Setting 17 now has a guide page number.**~~ **WITHDRAWN 2026-08-22 --
  this does NOT ship in ascii43 and nothing here is testable.** The fix was
  made, then reverted (`eb972b7`) because FT-226 was misfiled on both halves:
  setting 17 already had a reference, and the real defect is the six-setting
  class described in PART A item 2. **Skip it.**
- **[NOT BUILT -- SKIP]** ~~The block of ~20 wording and screen-splitting items
  from the ascii41 run.~~ **The whole block is unwritten** -- it is the largest
  single piece of ascii43 still outstanding. **Do not work through it.**

---

## PART C -- THEN RUN THE ENCRYPTION PATH ON ascii43

SANDY is the only unencrypted machine, so the encryption path should be
exercised on the build closest to launch.

- **Walking the encryption SCREENS costs nothing on Home.** Correcting an
  earlier premise (measured from SANDY's own log): on Windows 11 Home **Checkup
  changes nothing** -- it only shows you the manual steps and then skips. The
  machine's unencrypted state is spent **only if you follow the on-screen steps
  to completion yourself in Windows Settings**, not by Checkup running.
- **Watch for FT-229:** two encryption screens (shown 30b and 31) can get
  skipped when two keypresses land in the same second. **Screen 31 is the one
  that tells you how to confirm encryption is actually running** -- make sure
  you actually see it, and slow down through that stretch.

---

## PART D -- ALREADY CONFIRMED WORKING (do not bother re-testing)

- Both drives detected on the checklist.
- The log landing in OneDrive with `Open-My-Log.bat` beside it.
- The unrecognised-key message appears.
- In the gallery: arrow keys, Page Up / Page Down, and Q all work.

---

**Findings numbering for this run:** next free FT is **236**. New findings start
there.

---

## PART E -- BEFORE YOU START, PUT SANDY BACK  *(added 2026-08-26)*

**One thing changed on SANDY this morning while answering the widgets and
phishing questions. Undo it, or the field log records a starting state nobody
intended.**

- **Phishing protection box four is ON.** You turned on all four while counting
  them. The fourth reads **"Automatically collect website or app content when
  additional analysis is needed to help identify security threats"** -- it sends
  screen contents to Microsoft. **Settings 11 and 12 run during this test and
  exist to reduce exactly that.** Turn box four back **off**; leave the three
  **"Warn me about"** boxes on.
- **Lock screen widgets are already back off** -- ***measured,***
  `SandyChecks-SANDY-2026-08-26_11-14.txt`: `LockScreenWidgetsEnabled = 0`.
  Nothing to do.

**Two things about SANDY that are NOT problems, so you do not go looking:**

- **Windows Update is not paused on either machine, and both are current.**
  ***measured on SANDY 11:14 and CGDELL 17:03, 2026-08-26:*** every `Pause*`
  value **absent** on both, and both sit on **25H2, build 26200.9168** (CGDELL
  Pro, SANDY Home). CGDELL took **KB5121003** on 2026-08-26 -- the mandatory
  update it had been a month behind on at 26200.8875.
  - *(**This bullet said at 12:40 that CGDELL was still paused to 2026-09-06,
    five days after launch.** Bill cleared it the same afternoon. Corrected
    rather than left, because a stale warning sends someone to fix what is
    already fixed.)*
  - **So the two machines now differ only by edition.** A defect that appears on
    one and not the other is an edition difference or a real bug -- it is no
    longer explainable by patch level.
- **SANDY's unencrypted state is intact.** ***measured:*** TPM True/True/True,
  `PreventDeviceEncryption = 0`, **C: and D: both `FullyDecrypted`, key
  protectors NONE.** PART C's point stands: walking the encryption screens on
  Home costs nothing, because Checkup changes nothing there. **The state is
  spent only if you follow the manual steps to completion yourself.**
