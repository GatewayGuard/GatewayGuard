<!-- Dated: 2026-08-26 17:30 ET -->
<!-- Editor: Claude Code (CGDELL) -->
<!-- Update 2026-08-28 11:10: FT TABLE added at the top, on Bill's instruction
     -- every FT with its screen number and the key to press. Screen numbers
     derived mechanically: FT located in source, enclosing FUNCTION identified,
     function matched to the screens it draws, number read from
     $script:GGScreenLabels line 1824. 12 testable, 22 not in the build. -->
<!-- Update 2026-08-28 11:35: table REORDERED into journey order, after Bill
     asked whether it was. It was not -- it was grouped by testability. Also
     added where a RESUME actually lands: last checkpoint AppsAudit, and the
     code after it is mode selection, so resume starts at screen 21 and
     FT-178 and FT-175b are unreachable without START OVER. -->
<!-- SUPERSEDES GatewayGuard_FieldChecklist-ascii43-2026-08-22.md.
     Rewritten on Bill's instruction: screen numbers on every FT, and a
     screen-number index at the end -- what to skip, what to look for, one
     line each. The 2026-08-22 file stays for its history; use THIS one at
     the keyboard. -->
# ascii43 Field-Run Instructions -- by screen number

- **Machine:** SANDY (conhost, Home, local account, the 931 GB `D:`, unencrypted)
- **Build:** `Tool\W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1`
- **Findings numbering:** next free FT is **236**.

---

## HOW THE SCREEN NUMBERS IN THIS DOCUMENT WERE DERIVED

**Not by eye.** The number beside every FT below comes from two mechanical
reads of the build, done 2026-08-26:

1. **The number itself** is from `$script:GGScreenLabels`, the static table at
   **line 1824**. That table is the single source of screen numbers -- the log
   prints `[SCREEN-26] (shown as screen 13)` from it, and the number a user
   reads on screen is the same one.
2. **Which screen an FT belongs to** was found by locating every mention of
   that FT in the source and taking its **enclosing function**, then matching
   the function to the screens it draws. Function boundaries, not proximity --
   proximity would have put fixes in `Write-GGBox` on whatever screen happened
   to be defined next.

**Two consequences worth knowing before you trust a number:**

- **A fix inside a shared function has no single screen**, and is marked
  **ALL BOXED SCREENS** rather than given a false one. FT-217 is the example:
  it lives in `Write-GGBox`, so it affects every boxed screen in the tool.
- ***measured:*** **nine of the FTs in the old checklist appear nowhere in the
  build source** -- FT-195a, FT-207, FT-222, FT-223, FT-225, FT-227, FT-229,
  FT-231, FT-235. That **corroborates** the NOT BUILT tags but **does not prove
  them**: the old checklist itself records that one ascii43 fix shipped with no
  comment tag at all. **Absence of a tag is evidence, not proof.**

---

## READ THIS FIRST

**ascii43 is HALF BUILT and is worth running.**

- **In:** F1 keyboard contract, F2 console width, F3 the log, F5 flow and
  sequencing, **part** of F6.
- **Out:** **F4 entirely**, the F5 remnants, the F6 wording block, setting 1
  pause detection, setting 14 three-way plus its Revert string, the setting 6
  rename.
- ***measured 2026-08-26:*** parses with **0 errors**, **9,382 total / 9,002
  non-blank** lines, unchanged since 2026-08-22. **Gates 12, 12b, 24 PASS.**
- **This is a defect hunt, not an acceptance test.** ascii44 is the shipping
  build.

**Before you start, put SANDY back:** phishing protection **box four** is on --
*"Automatically collect website or app content when additional analysis is
needed to help identify security threats."* It sends screen contents to
Microsoft, and **settings 11 and 12 run during this test and exist to reduce
exactly that.** Turn box four **off**; leave the three **"Warn me about"**
boxes on.

**Two things that are NOT problems** -- *measured 2026-08-26:* neither machine
has Windows Update paused and both are on **25H2, 26200.9168**; and SANDY's
**C: and D: are both `FullyDecrypted`, key protectors NONE**, so the one-shot
unencrypted state is intact.

---

## THE FT TABLE -- EVERY FT, ITS SCREEN, AND WHAT TO PRESS

**Added 2026-08-28 on Bill's instruction: "otherwise I don't know what to
check."** Screen numbers derived mechanically -- each FT located in the source,
its **enclosing function** identified, the function matched to the screens it
draws, and the number read from `$script:GGScreenLabels` at line 1824.

**Read this table. Everything below it is detail.**

### WHERE YOUR NEXT RUN STARTS -- READ THIS BEFORE THE TABLE

***measured, `GatewayGuard-Log-2026-08-27_10-45.txt`:*** the last checkpoint
saved was **`AppsAudit`**, at 12:52:13. ***measured, build line 9319:*** the
code immediately after that checkpoint is **mode selection -- screen 21**.

**So RESUME drops you at screen 21. Screens 1 to 20 are skipped.**

**Two testable items are therefore BEHIND you and unreachable on a resume:**

| FT | Screen | Only reachable by |
|---|---|---|
| **FT-178** | 12 | START OVER |
| **FT-175b** | 14a, 15 | START OVER |

**Bill's choice, and both are defensible.** **RESUME** gets you to the ten
remaining checks immediately, including all five on screens 25/26 -- the
highest-value screens in the build. **START OVER** costs the walk back down
through the scan prompts but picks up those two and re-tests the intro screens
at a sensible console width, which the 08-27 run could not do at 60 columns.
**Recommended: START OVER, once, at a proper width** -- FT-236 means every
screen you have seen so far was truncated, so nothing before screen 21 has
actually been tested yet.

### THE TABLE, IN THE ORDER YOU WILL MEET THEM

**Numbered from a START OVER. On a RESUME, begin at screen 21.**

| Order | Screen | FT | Press this | Should happen |
|---|---|---|---|---|
| 1 | **12** | **FT-178** | -- | Encryption status shown. **`D:` will be missing -- F4, not a finding.** *Resume skips this* |
| 2 | **14a, 15** | **FT-175b** | -- | A resume run offers the offline scan. *Resume skips this* |
| 3 | **21** | FT-217 | -- | Mode selector: **no giant box, nothing ending in `..`** |
| 4 | **22** | F6 | -- | Your password answer here must drive **setting 15** later |
| 5 | **25 / 26** | **FT-206** | **`I`** | The "about this run" screen opens. This was the one prompt where `I` used to fail |
| 6 | **25 / 26** | **FT-204** | **`N`** | **Nothing is deselected.** Clear-all moved to `C` |
| 7 | **25 / 26** | **FT-204b** | **`C`** then **`N`** | Asks before wiping. N leaves your selections alone |
| 8 | **25 / 26** | **FT-224b** | **`12`** | Commits on the **second** key, not the first |
| 9 | **25 / 26** | **FT-232** | **`21`** | **Refused out loud.** Out-of-range used to log as accepted and do nothing |
| 10 | **25 / 26 → 25c** | **FT-224** | **`R`** twice | The skipping-encryption heads-up shows **once**. It rendered 3 times in the field |
| 11 | **27** | FT-219 | -- | *"choices can be reviewed in your log"* appears **once, only here** |
| 12 | **27a** | **FT-219** | select, continue | **No second "Apply? Y/N"** for something you already chose. Screen says *"You selected this item, so Checkup is applying it now."* |
| 13 | **22 → 25/26 → 27a** | **FT-221** | say **NO password manager** at 22, then **manually select item 15** | **Setting 15 must NOT be disabled.** Expect *"LEFT ON -- set up a password manager first, or your saved passwords would have nowhere to live."* **This is the safety guard, not a permission question** |
| 14 | **28** | -- | -- | Encryption asked **once**; RAM, drive size, type and time all shown |
| 15 | **30b** | **FT-229** | one key at a time | **NOT BUILT -- LIVE DEFECT.** This screen can be skipped |
| 16 | **31** | **FT-229** | one key at a time | **The one that must not be skipped** -- it tells the user how to confirm encryption is running |
| 17 | **33a** | FT-217 | -- | Convenience review: no giant box |
| -- | **ALL boxed screens** | **FT-217** | -- | **No line may end in `..`.** Lives in `Write-GGBox`, so a failure shows everywhere at once. **This FAILED on 08-27 at 60 columns -- see FT-236** |
| -- | **the `I` screen** | **FT-188** | **`I`** from anywhere | Build ID and Machine ID both correct |

### NOT IN THE BUILD -- 22 FTs. DO NOT TEST, DO NOT REPORT

***measured on the ascii43 source 2026-08-28: each of these appears NOWHERE in
the file.*** They will all fail. None of the failures is a finding.

| FT | Where it would have been | Why not built |
|---|---|---|
| FT-213, FT-214, FT-215 | Gallery only | Developer tool, fixed after launch |
| FT-220 | Settings 9, 12, 13, 17 | Waits on the guide (RULE W-07) |
| FT-226 | Setting 17 | Misfiled -- the reference always existed |
| FT-198 | All screens, input layer | Needs a separate SANDY measurement |
| FT-228 | Setting 15 / 16 apply | Environmental, SANDY local account |
| FT-205 | 25 / 26 | Recommended against. **`Q`** is the no-change exit |
| FT-233 | 30, 31 | Settled by field evidence. No code change |
| FT-230, FT-234, FT-167 | 12, 16, 28-31 | **The whole of F4.** `D:` is invisible everywhere |
| FT-195a, FT-207, FT-222, FT-223, FT-225, FT-227, FT-231, FT-235 | various | F5 remnants and the F6 wording block |
| FT-229 | **30b, 31** | **Not built -- so this defect is LIVE.** Two screens can be skipped when two keys land in the same second. **Go slowly there; screen 31 is the one that tells the user how to confirm encryption is running** |
| FT-184 | Before screen 1 | Time-boxed, unlocated for three builds |

**Two that are not build facts at all:** **FT-236** is a defect in the *old*
checklist document (a bullet contradicting a decision Bill had already made),
and **FT-141** is the *working* fix that makes setting 6 report
"Unknown" -- correct behaviour, not a test.

---

## PART A -- WHAT TO SKIP, WITH ITS SCREEN

Each is a decision, not a gap. **Do not re-report any of these.**

| # | What | Screen | Why it is skipped |
|---|---|---|---|
| 1 | **FT-213 / FT-214 / FT-215** -- Ctrl+A dead, B dead until another key wakes it, mouse wheel stops | **Gallery only -- no customer screen** | `Show-AllScreens.bat` is a developer tool. ***measured:*** none of the three appears in the build source. Fixed after launch |
| 2 | **FT-220** -- "why the current state is bad" missing | **Settings 9, 12, 13, 17** *(checklist items, not separate numbered screens)* | Deferred to ascii44; waits on the guide (RULE W-07) |
| 3 | **FT-226** -- setting 17's guide reference | **Setting 17** (build line 5634) | Misfiled. Setting 17 always had `GuideRef="Keep vs. Disable Table"`. The real defect is a **class** -- settings **10, 11, 12, 17, 18, 19** all point at a table name, not a page. Held until the guide structure is locked |
| 4 | **FT-198** -- M / K / left-click behaviour | **ALL SCREENS** (input layer) | Needs a separate SANDY measurement first |
| 5 | **FT-228** -- Edge will not change settings without a Microsoft account | **Setting 15 / 16 apply path** | Environmental, SANDY local account, not reproduced on CGDELL. One line naming the machine is enough |
| 6 | **FT-205** -- "look but change nothing" path | **Screens 25 / 26** (the checklist) | Recommended against and not built. **Q** is the no-change exit |
| 7 | **FT-233** -- recovery key demanded at reboot | **Screens 30, 31** | Settled by your own field evidence: the TPM releases the key unattended. No code change |
| 8 | **FT-184** -- a flash before screen 1 | **Before screen 1** | Time-boxed, unlocated for three builds. One line if you see it; no hunt |
| 9 | **Setting 6 reports "Unknown -- Tamper Protection blocks this check"** | **Setting 6** | ***measured on SANDY and CGDELL, elevated:*** `WTDS\Components` returns *"CANNOT READ."* Reporting Unknown is the **FT-141 fix working**. The two real defects there are ascii44 work |
| 10 | **F4, the whole second-drive family** -- FT-230, FT-234, FT-167, FT-178 | **Screens 12, 16, 28-31** wherever a drive is named | ***measured:*** the source contains **zero** occurrences of `Start-MpScan`, `FullScan`, "second drive" or "other drives". `D:` will be invisible everywhere. **Four bullets, none of them a finding** |
| 11 | **Setting 14 widgets -- the lock-screen third** | **Setting 14** | Proven automatable on 2026-08-26, but that lands in **ascii44**. ascii43 still writes only the taskbar policy |

---

## PART B -- WHAT TO LOOK FOR, BY FAMILY, WITH SCREENS

Tags carried forward from the 2026-08-22 markup, which was decided by reading
the code path: **[TESTABLE]** a failure here is a real finding ·
**[PARTIAL]** built in one place only · **[NOT BUILT -- SKIP]** it will fail,
do not report · **[FT-236]** the bullet contradicts a decision you already
made -- a defect in the document, not the build.

### F1 -- THE KEYBOARD CONTRACT   *the biggest change. Test it hardest.*

**Screens 25 and 26** (the two checklist pages) carry five of these six.
***measured:*** FT-204, FT-206, FT-219, FT-224 and FT-232 all live in
`Run-ConsoleMode`, the checklist loop.

- **[FT-236]** ~~B is the only "Back" key everywhere; N must not go back~~ --
  **contradicts a decision you already made.** Document defect, not a build
  fact.
- **[TESTABLE]** **N is never destructive on the checklist** -- "deselect all"
  has moved off it. **Screens 25, 26.** *(FT-204 -- the only destructive
  command on that screen.)*
- **[TESTABLE]** **`I` works at every prompt**, including the checklist, and
  opens the "about this run" screen. **Screens 25, 26 → unnumbered `I`
  screen.** *(FT-188, in `Write-PendingErrors`.)*
- **[PARTIAL]** **Every prompt tells you an exit exists.** Built centrally, not
  on every hand-rolled prompt. **ALL SCREENS**, most reliable on boxed ones.
- **[TESTABLE]** **Two-digit vs one-digit is explained** -- typing `12` commits
  on the second key, not the first. **Screens 25, 26.** *(FT-224.)*
- **[TESTABLE]** **An out-of-range number is refused out loud** -- type **21**
  and expect to be told, not ignored. **Screens 25, 26.** *(FT-232.)*

### F2 -- CONSOLE WIDTH

- **[TESTABLE]** **No giant boxes** on the convenience and review screens.
  **Screens 19** (power settings), **21** (mode selector), **27** (review),
  **33a** (convenience review). *(FT-217, in `Write-GGBox` -- so if the fix is
  wrong it is wrong on **ALL BOXED SCREENS**, which is the fastest way to spot
  it.)*

### F3 -- THE LOG   *open it with `Open-My-Log.bat`*

- **[TESTABLE]** **Every entry carries the date**, or a day-change marker.
  **Not a screen -- the log file.**
- **[TESTABLE]** **Absent registry keys read INFO, not ERROR.** **The log.**
  Setting 6 is the one to check: it should read INFO / Unknown, never a fault.
- **[NOT BUILT -- SKIP]** ~~The log header no longer over-promises.~~

### F5 -- FLOW AND SEQUENCING

- **[TESTABLE]** **No asking permission for a change you already selected.**
  **Screen 27a** (applying your changes). *(FT-221, in `Apply-Setting`.)*
- **[TESTABLE]** **The drive-encryption question is asked ONCE**, not on every
  pass. **Screens 28, 29, 25d, 25e.**
- **[TESTABLE]** **A resume run offers the offline scan.** **Screen 14a**
  (reminder: pre-scan recommended, repeat run). *(FT-175b, in
  `Show-PreScanGate`.)*
- **[NOT BUILT -- SKIP]** ~~"1a" should not appear before "1".~~

### F6 -- WORDING AND LOGIC

- **[TESTABLE]** **Setting 15 (browser password saving) ties to your password
  answer.** **Screen 22** (quick question -- your passwords) → **22a** on a
  repeat run.
- **[NOT BUILT -- SKIP]** ~~Applied settings lose their X on the checklist.~~
- **[NOT BUILT -- SKIP]** ~~The block of ~20 wording and screen-splitting
  items.~~ **This is the largest single thing missing from ascii43.** Wording
  you dislike anywhere is very likely already in it -- one line is enough, do
  not catalogue.

---

## PART C -- THE ENCRYPTION PATH   *screens 28 → 31*

SANDY is the only unencrypted machine, so exercise this on the build closest to
launch.

- **Walking the screens costs nothing on Home.** ***measured from SANDY's own
  log:*** on Home, Checkup **changes nothing** -- it shows the manual steps and
  skips. The unencrypted state is spent **only if you follow those steps to
  completion yourself in Windows Settings.**
- **Watch FT-229 on screens 30b and 31.** Two screens can be skipped when two
  keypresses land in the same second. **Screen 31 is the one that tells you how
  to confirm encryption is actually running** -- make sure you see it, and slow
  down through that stretch. *(FT-229 appears nowhere in the source, so treat
  it as unfixed.)*

---

## PART D -- ALREADY CONFIRMED. DO NOT RE-TEST

Both drives detected on the checklist · the log landing in OneDrive with
`Open-My-Log.bat` beside it · the unrecognised-key message appearing · arrow
keys, Page Up / Page Down and Q in the gallery.

---

## PART E -- THE SCREEN INDEX

**All 72 screens, in the order you will meet them.** Numbers are from the table
at build line 1824. Letters are departures from the main line; a screen you
reach from everywhere carries no number.

### E1 -- SCREENS TO LOOK AT

| Screen | ID | What it is | What to check -- one line |
|---|---|---|---|
| **1** | 85 | Welcome / maximize | Box fits the window; no wrap |
| **2** | 86 | Scrolling | Same |
| **3** | 87 | Set your console font | Banner width matches its own border |
| **4** | 28 | FONT CHECK | The characters line up; this is the whole point of the screen |
| **8** | 02 | How to scroll back and copy | The copy tip is **verbatim** the standard wording |
| **12** | 09 | Your system at a glance | **`D:` will be missing -- F4, do not report** |
| **14a** | 39 | Pre-scan recommended (repeat run) | **A resume run offers the offline scan** (FT-175b) |
| **16** | 38 | Defender offline scan | Says *offline*, and does not claim to cover other drives |
| **19** | 50 | Power settings review | **No giant box** (FT-217). It is 50 rendered lines -- a carried oversize screen |
| **21** | 52 | Mode selector | No giant box |
| **22** | 53 | Quick question -- your passwords | Your answer here must drive **setting 15** |
| **22a** | 74 | We remembered your answer | Only on a repeat run; it should match what you said |
| **25** | 76 | Security checklist, page 1 | **F1 lives here.** N not destructive · `I` works · `12` commits on the 2nd key · `21` refused out loud |
| **26** | 77 | Security checklist, page 2 | Same five checks as 25 |
| **27** | 55 | Review your selections | *"your choices can be reviewed in your log"* appears **once, only here** (FT-219) |
| **27a** | 59 | Applying your changes | **No second Y/N** for something you already selected (FT-221) |
| **28** | 61 | Final item: device encryption | Encryption asked **once**; RAM + drive size + type + time all shown |
| **29** | 62 | Your PC meets the requirements | Still true on Home with a local account |
| **30** | 79 | Before you turn it on -- recovery key | Copy tip present |
| **30b** | 80 | How to sign in with a Microsoft account | **FT-229 -- can be skipped if two keys land in one second** |
| **31** | 81 | How to tell if encryption is running | **FT-229 -- the one that must not be skipped. Slow down** |
| **33** | 70 | Automated scan schedule setup | The quarterly task wording; gate 24 says no raw command line is shown |
| **33a** | 23 | Convenience review | No giant box |
| **33c** | 88 | OneDrive offer | Only when there is no OneDrive -- SANDY has one, so expect **not** to see it |
| **(none)** | 84 | About this Checkup run | Press **`I`** from anywhere. Build ID and Machine ID correct (FT-188) |

### E2 -- SCREENS TO SKIP OR JUST WALK

**Skip means: a known-unfixed thing lives here. Do not write it up.**

| Screen | ID | What it is | Verdict |
|---|---|---|---|
| **5** | 29 | Before you start -- your window | Walk it |
| **6** | 78 | Before you start -- your keyboard | Walk it |
| **7** | 30 | What happens next | Walk it -- 28 lines, carried oversize |
| **9** | 05 | Important -- read before continuing | Walk it |
| **10** | 34 | Windows edition detected | Must say **Home** on SANDY |
| **11** | 35 | Your PC -- RAM | Walk it |
| **13** | 26 | Your PC's security tools | Walk it -- 34 lines, carried oversize |
| **14** | 27 | The scans we recommend | Walk it -- 34 lines, carried oversize |
| **15** | 10 | Pre-scan prep checklist | Walk it |
| **17** | 43 | Antivirus status -- healthy | Walk it |
| **18** | 73 | Malwarebytes detected | Expect it -- SANDY has Malwarebytes registered |
| **20** | 51 | Apps audit results | Walk it |
| **23 / 24** | 54 / 75 | What Checkup does and does not do, 1 and 2 of 2 | Walk both |
| **32** | 69 | All selected items processed | Walk it |
| **34** | 72 | Automated steps complete | 55 lines -- the largest carried oversize screen |
| **1a / 1b** | 25 / 31 | Welcome back; quick re-check | Only on a resume run |
| **1c** | 83 | Are you sure you want to close? | Exit confirmation -- try it once |
| **3a** | 01 | Not administrator | **Should not appear.** Run elevated |
| **9a / 9b** | 32 / 33 | Domain-joined; admin required | **Should not appear** on SANDY |
| **11a / 11b** | 36 / 37 | Time and date check / out of sync | Walk if shown |
| **14b** | 40 | Welcome back -- offline scan complete | Resume path only |
| **17a-17e** | 41,42,44,45,46 | Antivirus alternative states | Whichever fires. **41 is 28 lines, carried oversize** |
| **18a-18d** | 13,47,48,49 | Malwarebytes alternatives / battery warning | Whichever fires |
| **25a-25e** | 56,57,58,60,68 | Non-recommended, confirm, skipping encryption, why encrypt, declined | Y/N/S wording is the thing worth a glance |
| **27b-27e** | 64,65,66,67 | BitLocker, Pro only | **Will not appear on SANDY.** Home |
| **28a** | 63 | Device encryption may not be available | Should not fire -- TPM is ready |
| **30a** | 82 | Already signed in with a Microsoft account | SANDY is a **local** account, so expect **30b** instead |
| **33b** | 71 | Convenience review -- result | Walk it |
| **33d** | 89 | How to set up OneDrive | Only reachable from 33c |

### E3 -- THE SHORT VERSION

**If you only have twenty minutes: screens 25 and 26.** Five of the six F1
checks are there, F1 is the biggest behaviour change in the build, and a
failure there is the most likely real finding in this run.

**Then screens 30b and 31**, slowly, for FT-229.

**Everything about `D:` is F4 and is not built. Nothing about widgets is
testable. Setting 6 saying "Unknown" is correct.**
