<!-- Dated: 2026-08-21 17:50 ET -->
<!-- Editor: Claude Code (CGDELL) -->
<!-- Update 2026-08-21 17:50: F4 second drive decided -- route 3 (cover the
     other drives). READ-FIRST point 2 and the F4 section updated. -->
# ascii43 Field-Run Instructions -- what to skip, what to look for

- **Document Name:** GatewayGuard_FieldChecklist-ascii43
- **Last Editor:** Claude Code (CGDELL)
- **Machine to run on:** SANDY (conhost, Home, local account, the D: drive, unencrypted)
- **Sources this is built from (not restated -- read them if you want the detail):**
  `GatewayGuard_ascii43BuildPlan-2026-08-21.md` (the six families) and
  `GatewayGuard_FieldTestTriage-ascii42run1-2026-08-21.md` (FT-204 to FT-235).

---

## READ THIS FIRST -- two facts that frame everything below

1. **ascii43 IS NOT BUILT YET.** This is the checklist to use once it is. It is
   also the scope confirmation: if anything in "what to look for" is not what
   you expect ascii43 to do, say so before I build, not after.

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
   - *(Setting 17's missing guide page number, FT-226, is a data fix and IS in
     ascii43 -- see F6. Only the explanation waits.)*

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

---

## PART B -- WHAT TO LOOK FOR (the ascii43 fixes to verify), BY FAMILY

The build is six families. Test them roughly in this order.

### F1 -- THE KEYBOARD CONTRACT  *(the biggest behaviour change -- test it hard)*

- **B is the ONLY "Back" key, everywhere.** `N` must **never** take you back.
  *(Last run, screen 27 used N for Back -- FT-225. Now it should be B.)*
- **N is never destructive on the checklist.** "Deselect all" has moved to
  **`C = Clear all`**, and it **asks you to confirm** before wiping. Pressing
  **N should no longer wipe your selections.**
  *(Last run, N destroyed 19 selections five seconds after you made them --
  FT-204. This is the single most important thing to confirm.)*
- **`I` works at every prompt, including the checklist** (shown-screens 25/26).
  Press I on the checklist -- it should show your build and Machine ID.
  *(Last run, I was dead on the checklist -- FT-206 / FT-227.)*
- **Every prompt tells you an exit exists.** Press an unrecognised key -- the
  message should now say how to get out. *(FT-207.)*
- **Two-digit vs one-digit is explained.** Typing "12" commits on the second
  digit; a single digit waits for Enter -- and the screen now **says which.**
  Your Enter after a two-digit number should not be swallowed.
  *(Last run it was discarded five times running -- FT-223.)*
- **An out-of-range number is refused out loud.** Type **21** when there are 19
  items -- it should say no, not silently accept it. *(FT-232.)*

### F2 -- CONSOLE WIDTH

- **No giant boxes.** The convenience / review screens -- Advertising ID,
  Diagnostic data, Edge Startup Boost, Widgets, Edge Password Saving (the
  shown-screen 33b area) -- should **fit your window.** *(Last run, the Edge
  Password Saving box painted 378 characters wide into an 86-column window --
  FT-217. Five of those screens were over-wide; you met the worst one.)*

### F3 -- THE LOG  *(open it with `Open-My-Log.bat`)*

- **Every entry now carries the date** (or a day-change marker). A multi-day
  run should read in forward time order, and **today's run should be findable
  by today's date.** *(Last run, one file spanned three days with time-only
  stamps, so the clock appeared to run backwards and today's log "went missing"
  -- FT-231.)*
- **The log header no longer over-promises.** It should not claim the last line
  always shows where the program was, because a hard kill writes no such line.
  *(FT-235, the part that ships.)*
- **Absent registry keys read as INFO, not ERROR** in your log. *(FT-188.)*

### F4 -- THE SECOND DRIVE  *(route 3 -- Checkup COVERS the other drives)*

On SANDY (which has the 931 GB `D:`), look for all of these:

- **A FULL scan that covers all your drives, D: included.** This is **not** the
  pre-boot "offline" scan -- that one can only do the system drive. The screen
  should say **"full scan of all your drives,"** and warn you it takes a while.
  Confirm it actually runs against `D:`. *(FT-230.)*
- **Encryption status reported for D: too,** not only `C:`. *(FT-167 / FT-178.)*
- **The encryption walkthrough names D:** where it applies.
- **A WinRE guard:** if the offline scan is unavailable (WinRE turned off), the
  tool should say so, not silently do nothing. *(FT-234.)*

**Note:** the full-scan behaviour is measured on SANDY **during the build**,
before it ships -- so by the time you run ascii43 it is already verified. If any
of the four above is missing, or the full scan does not touch `D:`, that is a
real finding.

### F5 -- FLOW AND SEQUENCING

- **No asking permission for a change you already selected.** After you pick
  item #6 to run, the next screen should **explain how to do it** -- not ask
  "do you want to apply this?" again. *(Your most frequent complaint last run,
  five times -- FT-219.)*
- **The drive-encryption question is asked ONCE, not on every `R`.** Decline it
  once; pressing R again should not re-ask. *(Last run it re-asked three times
  -- FT-224.)*
- **"1a" should not appear before "1".** *(FT-195a.)*
- **A resume run offers the offline scan.** *(FT-175b.)*

### F6 -- WORDING AND LOGIC

- **Setting 15 (browser password saving) ties to your password-manager
  answer.** It should **not** tell you to turn off browser password saving
  unless you have already said you have a password manager set up -- otherwise
  you would be left with no password store at all. It should read **"Requires
  manual change by you,"** with different wording depending on your earlier
  answer. *(FT-221 -- a logic fix, not just wording.)*
- **Applied settings lose their X on the checklist.** After you apply a
  setting, its checkbox X should clear, so on the way back you can see what is
  still unhandled. *(FT-222.)*
- **Setting 17 now has a guide page number.** *(FT-226 -- the data fix ships;
  the explanation waits with FT-220.)*
- The block of ~20 wording and screen-splitting items from the ascii41 run.

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
