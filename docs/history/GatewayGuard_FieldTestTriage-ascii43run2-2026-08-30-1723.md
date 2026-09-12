# ascii43 field run -- the complete run, triaged

# Dated: 2026-08-30 17:23 ET

**Editor:** Claude Code (CGDELL)
**Supersedes nothing.** `GatewayGuard_FieldTestTriage-ascii43run1-2026-08-28-0930.md`
covers the first three sessions and stays valid. This file covers **the two
sessions nobody had looked at**, and **Bill's own written notes**, which had
never been triaged at all.

---

## WHAT THIS IS, AND WHY IT EXISTS

The run-1 triage closed with a section headed **STILL AHEAD IN THIS RUN**,
listing screens 27, 28-31 and 33 as not yet reached.

**They were reached.** The run continued for two more sessions and **finished
today at 16:40**, through screen 34, the last screen in the program.

***measured, `C:\Users\willi\OneDrive\GatewayGuard\Logs`, listed 2026-08-30
17:15:*** five ascii43 logs exist. **Three had been copied to
`Test_Results\FieldRun-ascii43\`. Two had not:**

| Log | Lines | Reached | Status before today |
|---|---|---|---|
| `2026-08-26_18-07` | 109 | screen 16 | triaged |
| `2026-08-26_19-43` | 86 | screen 14b, X-clicked | triaged |
| `2026-08-27_10-45` | 328 | screen 26 | triaged |
| **`2026-08-28_17-29`** | **125** | **screen 22** | **never seen** |
| **`2026-08-30_11-04`** | **253** | **screen 34 -- THE END** | **never seen** |

Both are now copied into `Test_Results\FieldRun-ascii43\`.

**And Bill's own notes had never been read by anyone.**
***measured:*** `Test_Results\Ascii43-Test-Results=2-026-08-26-1701.docx` and
`...-2.docx`, written **today at 12:36 and 16:52**, are **untracked** -- in no
commit, so in no push and no sync. ***measured:*** zero references to either
filename anywhere in `ProjectDocs\`, and zero hits in the run-1 triage or the
session log for thirteen distinctive phrases they contain. **The `-2` file is
the fuller one and is the one to work from.** It carries roughly **34
screen-by-screen entries** plus a **20-point research list**.

**The good news first.** ***measured, `2026-08-30_11-04`:*** **zero
truncation warnings in 253 lines.** Bill widened the console as the run-1
triage asked. The window ran at **175 columns** throughout. This is the first
ascii43 log that measures content instead of measuring truncation.

---

# PART 1 -- WHAT THE NEW LOGS SHOW THAT NOBODY KNEW

## FT-242 -- EIGHT REGISTRY WRITES CANNOT FAIL, SO A FAILED CHANGE IS LOGGED AS GOOD

**Severity: HIGH. This is the FT-162 shape -- the log says the work was done
and the work was not done.**

***measured, `GatewayGuard-Log-2026-08-30_11-04.txt`, 16:34:21, three
consecutive lines:***

```
[APPLIED] Windows Widgets -- Disable | Before: Unknown -- could not check | Result: Windows Widgets disabled -- GOOD
[OK] User approved convenience change: Windows Widgets -- Windows Widgets disabled -- GOOD
[ERROR] SILENT ERROR at Show-ConvenienceReview: Attempted to perform an unauthorized operation. | At ...ascii43...ps1:6472 char:17
```

**The same second. GOOD, then GOOD again, then the failure that says it was
not good.**

### The mechanism, and it is exact

***measured, ascii43 source, line 6472:***

```powershell
Set-ItemProperty -Path $rp -Name AllowNewsAndInterests -Value 0 -Type DWord -Force
```

**There is no `-EA Stop`.** In PowerShell a `Set-ItemProperty` failure is
**non-terminating** by default, so it does not throw, so the enclosing
`catch` never runs -- and execution falls straight through to the next line,
which is:

```powershell
$result = "Windows Widgets disabled -- GOOD"
```

**The `catch { $result = "ERROR: $_" }` wrapper is decorative. It cannot
fire.**

### The build already knows the right pattern, twelve lines away

***measured, same file, item 6 (Edge phishing), lines 6394-6397:*** every one
of the four writes carries **`-EA Stop`**, and it is caught properly:

```powershell
Set-ItemProperty -Path $rp -Name ServiceEnabled -Value 1 -Type DWord -Force -EA Stop
...
} catch [System.Security.SecurityException] {
    $result = "MANUAL REQUIRED -- registry is protected on this PC (Tamper Protection)"
```

***measured in the same run, 15:14:37:*** that item reported
**`MANUAL REQUIRED -- registry is protected on this PC`** -- correct, honest,
and exactly what the customer needs. **The difference between the honest
report and the false one is four characters.**

### The full audit -- 8 of 14 writes are unguarded

***measured, `Apply-Setting`, lines 6200-6600:***

| Line | Setting | `-EA Stop` |
|---|---|---|
| 6363 | -- | **yes** |
| 6394-6397 | 6, Edge phishing | **yes** (4 writes) |
| 6438 | -- | **yes** |
| 6447 | -- | **NO** |
| 6455 | -- | **NO** |
| 6463, 6464 | 13, Edge startup boost + background | **NO** (2 writes) |
| **6472** | **14, Widgets** | **NO** -- *this is the one that failed in the field* |
| 6489 | -- | **NO** |
| 6503 | -- | **NO** |
| 6517 | -- | **NO** |

**Six guarded, eight not.**

### Bill saw this happen and wrote it down

**Bill, screen 34:** *"I checked edge startup boost no change, still off."*

***measured, 16:34:15, item 13:***
`Before: Unknown -- could not check | Result: Edge startup boost and
background mode disabled -- GOOD`.

**"Before: Unknown -- could not check", then "GOOD".** The tool could not read
the setting before, did not read it after, and reported success. Lines 6463
and 6464 are two of the eight unguarded writes.

### Why this one outranks everything else in this file

Section 9 of the licence and the log footer both tell the customer to email
this log to `support@gatewayguard.co`. **A customer whose Widgets write is
blocked gets a log saying `GOOD`.** Neither they nor support can tell it
failed -- except for a `SILENT ERROR` line 200 lines away with a line number
in it.

**Checkup's central promise is that it tells you plainly what it did. Eight
writes currently cannot tell the truth about failing.**

### Fix, for ascii44

Add **`-EA Stop`** to all eight, and move each `$result = "... GOOD"` so it
only runs if the write returned. The `catch` blocks already exist and already
say the right thing -- they just have to be reachable. **This is a mechanical,
low-risk change and it is the single highest-value fix on the board.**

---

## FT-243 -- THE REQUIRED LOG NOTICE IS ON THE WRONG SCREEN, AND HALF THE USERS NEVER SEE IT

**Severity: medium. It is a documented product rule, and it is breached.**

**The rule, `CLAUDE.md`, Product Rules:** *"For your protection, your choices
can be reviewed in your log" -- shown **once only**, **on the review
screen**.*

**Bill, screen 27:** *"Did not see this on the Screen -- choices can be
reviewed in your log."*

**He is right, and the source says why.**

***measured, ascii43 source: exactly one occurrence, line 7428*** -- and it is
inside **`Show-BitLockerFinalDecline`** (function begins line 7408), which is
**screen 25e, "YOUR CHOICE IS NOTED -- NO ENCRYPTION WILL BE APPLIED"**.

It is not on screen 27. It is on the screen you reach **only by declining
drive encryption**.

**So a user who ACCEPTS encryption never sees the notice at all.** The
"once only" half is implemented correctly -- `$script:GGLogNoticeShown` guards
it -- but it is guarding the wrong screen.

***measured, `2026-08-30_11-04`:*** Bill reached screen 25e at 14:50:03 and
screen 27 at 14:50:52. He saw the line, on the screen before the one the rule
names, which is exactly why it read as missing from screen 27.

**Fix:** move it to the review screen render, keep the `GGLogNoticeShown`
guard.

---

## FT-244 -- SCREEN 32 IS DRAWN AND NEVER PAUSED

**Severity: medium. It breaches the standing screen rule, and Bill noticed the
symptom without being able to name it.**

**Bill, screen 33:** *"Is there a screen 32."*

**Yes -- and he never got to read it.**

***measured, `2026-08-30_11-04`, both at 16:09:43, the same second, with no
keypress between them:***

```
[SCREEN] [SCREEN-69] (shown as screen 32) Rendered: ALL SELECTED ITEMS PROCESSED
[SCREEN] [SCREEN-70] (shown as screen 33) Rendered: AUTOMATED SCAN SCHEDULE SETUP
```

***measured, source, lines 8735-8741:***

```powershell
Draw-Box -ScreenId "69" -Color White -Lines @(
    "  ALL SELECTED ITEMS PROCESSED                           ",
    ...
)
Setup-ScheduledTasks
```

**The box is drawn and the next function is called immediately. There is no
`Pause-ForUser`.**

`CLAUDE.md`, Screen / UX Standards: **"All screens need pauses before
proceeding."** Screen 32 does not have one.

**Same family, same run.** Bill: *"Scr 34 - appeared at a bottom of Scr 3b.
Fix this."* ***measured, 16:40:14:*** screen 34 renders in the same second the
convenience review returns -- the two share a screen with no clear between.
And in `2026-08-28_17-29`, ***measured 17:33:21 to 17:33:23:*** **screens 4,
5, 6, 7 and 8 all rendered inside two seconds** on buffered `Nav 'NEXT'`
keys. **Five screens the user could not have read.**

---

## FT-245 -- THERE ARE THREE SILENT-ERROR SITES, NOT ONE

**Severity: medium. Extends FT-237, which found one of them.**

FT-237 recorded the `[ERROR] SILENT ERROR` at **line 5946** (the setting-6
status read). ***measured across the two new logs, there are three distinct
sites, all on a healthy machine:***

| Line | Where | When | Message |
|---|---|---|---|
| **5946** | `Get-AllStatuses` -- WTDS status read | every run, at screen 22 | `Requested registry access is not allowed` |
| **6394** | `Apply-Setting` item 6 -- WTDS write | 15:03:51, start of hardening | `Requested registry access is not allowed` |
| **6472** | `Apply-Setting` item 14 -- Widgets write | 16:34:21 | `Attempted to perform an unauthorized operation` |

**All three write `[ERROR]` into the file we tell customers to email us.**

**6394 is benign** -- it is the guarded write, it is caught, and the user
correctly sees `MANUAL REQUIRED`. The `[ERROR]` line is noise.
**6472 is not benign** -- it is FT-242, and it is the one place where the
error line is the *only* evidence that a change failed.

**The breadcrumb is still wrong, as FT-237 recorded.** All three say
**`at Show-ScopeDisclaimer`** or **`at Show-ConvenienceReview`** -- where the
user was, not where the fault was. The real location is the line number in
the text.

---

## FT-246 -- "PASSWORD ON WAKE" RE-READ FAILS TWICE, SUCCEEDS ONCE

**Severity: medium. Intermittent, which is why it needs recording rather than
guessing at.**

**Bill, screen 19:** *"The log says Checkup could not reread the setting;
determine whether the setting can be read reliably."*

***measured across three runs:***

| Run | Result |
|---|---|
| `2026-08-27 12:46:21` | `was 'NOT required' -> now 'could not re-read -- check manually'` |
| `2026-08-29 07:50:01` | `was 'NOT required' -> now 'could not re-read -- check manually'` |
| **`2026-08-30 15:31:56`** | **`Result: Password required on wake -- enabled for both AC and battery -- GOOD`** |

**Same machine, same setting, same build. Two failures and one success.**

**Not measured: why.** The difference is not in the log. Candidates worth
checking before writing any code -- the re-read happening too soon after the
write, and the run at 15:31 following a full `powercfg` cycle the earlier two
did not. **Do not fix this by guessing;** it is cheap to instrument the
re-read with a retry and log both attempts.

**Note this is a real applied change, not a convenience item** -- so unlike
FT-242, when it says "could not re-read" it is being honest. That is the
system working. The defect is the unreliability, not the reporting.

---

## FT-247 -- THE NUMBERING GOES BACKWARDS FROM 26 TO 25c, AND THERE IS NO 30a

**Severity: medium. It is the exact failure FT-172's scheme was built to
prevent.**

**Bill, screen 25d:** *"Change to 26d and is there an 25abc. Change them as
well otherwise it looks to user like you went backwards."*
**Bill, screen 30b:** *"is there a scr 30a?"*

**Both are right, and both are measurable.**

### 26 -> 25c is a first-encounter decrease

***measured, `2026-08-30_11-04`, 14:27:59 to 14:36:31:***

```
14:27:59  [SCREEN-77] (shown as screen 26)  Checklist render: page 2
14:36:31  [KEY] Checklist command 'R' accepted
14:36:31  [SCREEN-58] (shown as screen 25c) HEADS UP -- YOU HAVE NOT SELECTED DRIVE ENCRYPTION
```

**First encounter of 25c in the whole run, and the user arrived from 26.**
The `R` (review) command is offered on **both** pages of the checklist, so
anyone sitting on page 2 -- screen 26 -- who reviews without selecting
encryption lands on a screen numbered **25c**.

`CLAUDE.md`: *"only **first encounters** must ascend"*. This is a first
encounter, and it descends.

**The whole 25c/25d/25e block is reachable from 26**, so Bill's instinct to
renumber them 26c/26d/26e is the right shape. The design doc
`GatewayGuard_ScreenNumberDesign-2026-08-15-1430.md` should decide it, not
this file -- but the field evidence now exists.

### 30 -> 30b, with no 30a

***measured, same log:*** `SCREEN-79` is shown as **30**, `SCREEN-80` is shown
as **30b**. **Nothing is shown as 30a.** To a reader, a screen is missing.

**Bill also asked, screen 29:** *"Scr # is in a different place, change it so
it appears in the same place as every other screen, do this for screens 25 &
28 and check every other screen."* That is a separate, mechanical pass, and
`Tool2\Check-ScreenCoverage-2026-07-30.ps1` is the right place to enforce it.

---

## THINGS THE LOG CONFIRMS THAT ARE **NOT** DEFECTS

Recorded so nobody re-opens them.

- **Bill, screens 25-26:** *"enter `12`, and it removes the X on setting 12
  immediately and did not say anything new."* ***measured, 14:29:22:***
  `Checklist command '12' accepted` -> `5 item(s) selected`, down from 6.
  **Two-digit entry commits on the second key and works.** The checklist
  question that asked about this is answered: it behaves as designed.
- **Out-of-range rejection works.** ***measured, 14:34:31:***
  `Checklist command '21'` -> `item number out of range (21) -- rejected`.
  FT-232's fix is confirmed in the field.
- **Burst suppression works.** ***measured, 14:14:46:*** three ignored keys in
  one second, then `4+ ignored keys in one prompt -- burst suppressed
  (FT-193)`.
- **The password-manager guard works.** ***measured, 11:08:47:***
  `No password manager -- Edge Password Saving (ID 15) deselected, left ON`.
  That is FT-221 doing its job.
- **Encryption prerequisites read correctly.** ***measured, 15:38:24:***
  `TPM: True, SecureBoot: True, WinRE: True`. Bill asked *"HOW DO WE KNOW"*
  next to each -- see Part 2E, it is a wording request, not a fault.
- **Windows key / PrintScreen being swallowed is real but handled.**
  ***measured, 12:56:55 and elsewhere:*** `Checklist: key ignored ( )`. The
  key is consumed and rejected rather than acted on. **Bill's complaint that
  it "is accepted as an entry" is about there being no way to screenshot**,
  which is a genuine usability point -- but nothing is being wrongly selected.

---

# PART 2 -- BILL'S NOTES, TRIAGED

These are from `Ascii43-Test-Results=2-026-08-26-1701-2.docx`, **never
previously read**. Grouped by what has to happen, not by screen order.

## A. Repeats a decision the user already made -- the FT-219 family

**This is the single most repeated complaint in Bill's notes.**

- **Screen 33a, Edge startup boost:** *"asked if you wanted to make the
  change. Wrong. User already selected it. We should just be showing how to
  change it not reasking something he already approved."*
- **Screens 13-14:** *"Defender and Malwarebytes screens appeared again.
  Since both scans ran during the previous test, determine whether users need
  to see these screens again."*
- **Screen 18:** *"Can Checkup again determine what the user did
  previously?"*
- **Screen 14a:** *"Explain that one or both scans may have been run during a
  previous session. If Checkup already handled the results, explain the user
  may not need to run them again."*
- **Screen 22:** *"Checkup asked for the password again, and I entered M
  again. Fix this repeated prompt."* ***measured, `2026-08-27_10-45`, three
  answers to the same question at 12:55:16, 12:59:24 and 12:59:57*** --
  though in that instance Bill reached it by pressing Back, which is
  legitimate.

**FT-219 is "selection = approval" and it is already built in ascii43.** These
say it did not go far enough: it covers the checklist, not the convenience
review or the repeat-run case.

## B. Wording that states what Checkup will and will not do

Bill converged on **one sentence he wants used everywhere**:

> **"These must be set manually, Checkup will show you how."**

He asks for it on **settings 6 and 9**, on the **6-item manual block**, on
**screen 28 (Home encryption)**, and on **screens 13, 14 and 17**. He also
wants:

- **Screen 19:** *"Avoid telling users that Checkup is simply skipping these
  items. Instead, explain that Checkup will guide them through any settings
  Microsoft requires users to change manually."*
- **Screen 23:** *"The screen says 'what you saw,' but the user did not see
  anything."* And: state that **tamper protection is essential** and
  **Windows Hello strongly recommended**.
- **Setting 6:** *"Says Checkup is applying this now -- not true. Remove
  this."* **This is FT-242's cousin in prose -- the screen claims an action
  that does not happen.**
- **Screen 34:** *"Says automated scans are finished ... Terminology is
  incorrect."* ***measured:*** the screen is titled **AUTOMATED STEPS
  COMPLETE** and **no scan ran in that session** -- both the offline scan and
  Malwarebytes were skipped, at 18:44:32 and 18:53:09.

**This is the F6 wording block, and Bill has now written most of it for us.**

## C. Exit and navigation keys

- **`X` for Exit, not `N`** -- asked twice (screen 14a, both passes), with
  `Q`/`E` as fallbacks.
- **`B` for Back, not `N`** -- screen 27: *"Don't use N to go back use B,
  Change everywhere it is needed."* ***measured, 14:51:09 and 15:02:09:***
  `Key 'N' accepted at: Run-ConsoleMode` returns from the review screen to the
  checklist. **N is Back at the review screen today.**
- **Screen 16:** no Back button; pressing space then B produced two screens
  Bill captured as screenshots 21 and 22 in
  `C:\Users\willi\OneDrive\Personal\Pictures\Screenshots`. **Those two
  screenshots have not been examined and are not in the repository.**
- **Screen 18:** *"After selecting N, I still had to press the spacebar.
  Check for this issue throughout the program."*
- **Screen 12:** *"I had to press the spacebar twice ... I could not return
  to Scr 12."*

**This collides with a settled decision.** `CLAUDE.md` and FT-236 record
Bill's own earlier ruling that **`N = go back` stays in real Y/N questions**.
Screen 27's prompt is a real Y/N question. **Two of Bill's rulings now point
opposite ways, on the same key.** It is in Part 4.

## D. Screen 12, the drive list -- the second-drive work

- Drives shown as **Drive 1 / Drive 2**; are those Checkup's labels or
  Windows'?
- **The SSD is listed as Drive 2.** Bill wants the order reversed so the
  238 GB SSD is Drive 1.
- Wanted format: **"Drive 1 - 1 TB HDD"**, **"Drive 2 - 256 GB SSD"**.
- **Explain base-10 vs base-2** so a buyer who paid for "256 GB" and sees
  238 GB does not think Checkup miscounted.
- **List both Defender and Malwarebytes** under antivirus.

**This belongs with F4, the second-drive block, which is now unblocked.**

## E. Encryption path -- needs a live encryption run to settle

- **Screen 29:** *"TPM: READY -- GOOD -- HOW DO WE KNOW"*, same for Secure
  Boot and WinRE. **And: what do we do if one is NOT on? Need step by step
  instructions for each.** ***measured:*** the tool reads all three correctly;
  what is missing is the remedy path when one reads False.
- **Screen 30:** second paragraph *"needs to be checked when we run encryption
  on Sandy."*
- **Screen 31:** *"Need to verify when encrypting Sandy."*
- **Screen 25d:** *"Add save to USB Drive."* And: **"Will encryption encrypt a
  plugged in USB drive during encryption? Add this to ascii44 as something to
  check."**
- **Screen 28:** *"On Home the user needs to turn on encryption themselves.
  Tell them this ... research this is true on all Win 11 Home computers."*

**ORDER STILL MATTERS.** SANDY is the only unencrypted machine, and encrypting
it spends that state permanently. The field run is now **complete**, so that
constraint has lifted -- but the guide's encryption VERIFY markers and these
five items should be settled in **one** encryption run, not several.

## F. The 20-point research list ("Aside")

Bill's largest single request, and **none of it is a defect** -- it is a
research and design brief. He asks for **a plan in a `.md` before any of it is
built**. Summarised:

1. **Reorder the run:** tamper protection check first, then Windows Update to
   completion, then enable both blocking sub-options, **then** the scans.
2. **Can tamper protection be detected indirectly** by trying a read that
   fails when it is on? *(This project already has that evidence --
   ***measured on both machines***, `WTDS\Components` is unreadable when
   Tamper Protection is on. It is a usable signal.)*
3. **Can Checkup apply Windows updates automatically?**
4. **Is Malwarebytes still needed** now Defender detects PUPs with blocking
   enabled? *"If Checkup can work well without Malwarebytes, it will be
   simpler and faster."* **This is a product-scope question with pricing and
   licence consequences, not a build question.**
5. **Recover the 18 PUPs Malwarebytes found on SANDY** for use as test
   specimens.
6. **Password managers vs browser password managers** -- expert consensus, and
   whether users should be told to set one up *before* running Checkup.
7. **Password change frequency**, and the argument for leaving a strong
   password alone when 2FA is on.
8. **2FA for banking / investment / credit cards**; **authenticator apps vs
   SMS**; whether the code display time can be extended; the observation that
   an old code sometimes still works briefly.

**Deliverable Bill asked for: a plan, in a `.md`, shown to him before
building.** Not started.

## G. Smaller items, listed so they are not lost

- **Screen 1:** *"No flash appeared."* -- **FT-184 did not reproduce.** Worth
  recording as a negative result.
- **Screen 11:** top sentence to become *"All security setting changes made by
  Checkup have been thoroughly tested."*; clarify sleep-mode setup; clarify
  overnight scan scheduling guidance.
- **Screens 11-14:** explain **why** steps 1-4 are shown and how they help;
  add guide-page references.
- **Screen 14a:** add *"run"* after *"protection"*; for the Malwarebytes scan
  use *"With your approval, Checkup will run it for you"*; add **"Run"**
  before *quarterly* and *monthly*; explain why exit is offered here.
- **Screen 20:** *"Something flashed briefly, possibly a running-apps
  message."*
- **Screen 22:** *"the screen tells the user to see the guide but does not say
  where to look."* Use *"Press Enter or Space to continue Checkup."*
- **Screen 24:** can Checkup **uninstall apps** with approval? If not, say how
  and where. **Every screen supporting `I` should show it as an option**, and
  users should be told to write down the info **and the screen number**.
- **Screen 26:** *"Screen positioning too wide."* ***measured and he is
  right:*** at window 175, `name 126 (content needed 41), status 38`. **The
  name column is given 126 columns for 41 characters of content** -- 85
  wasted. Screen 25 splits the same window `name 70 / status 94`. The two
  pages of one checklist use different geometry.
- **Screen 26:** settings **12-15 and 17** should use screen 26's status
  wording.
- **Screen 25e:** *"Went back and selected 8 on Screen 26 and it flashed but
  did not give 8 and X. Had to use P to go back to screen 25."* ***measured,
  14:53:03 to 14:53:33:*** item 8 toggled **four times** in 30 seconds across
  both pages -- selected, deselected, reselected. **Item 8 is Drive
  Encryption, which is also driven by the 25c/25e decline flow, so two
  controls move the same flag.** Real defect, needs a build fix.
- **Screen 27:** *"Screen too long."*; *"Remove 'applying' next to Xs that
  will be applied."*; *"give page numbers in the guide."*
- **Screen 33:** *"Set up an auto check for the user and tell them the answer
  and what to do if either is not set up."* ***measured, 16:09:43-44:*** both
  scheduled tasks report `[GOOD] Scheduled task created`. **FT-203 is still
  live in this build** -- both carry `DisallowStartIfOnBatteries` and will
  never run on battery, while the log says GOOD. **Another instance of the
  FT-242 shape.**
- **Screen 33a:** *"too long"*.

---

# PART 3 -- WHAT I WOULD BUILD, IN ORDER

**ascii44, ordered by cost of being wrong, not by effort.**

1. **FT-242 -- add `-EA Stop` to the eight unguarded writes.** Mechanical,
   low risk, and it stops the product lying in the customer's support file.
   **Do this first.**
2. **FT-203 -- the scheduled-task battery flags.** Same shape, already
   measured, fix already written in
   `GatewayGuard_ScheduledTaskDefects-2026-08-20.md`.
3. **FT-244 -- pause on screen 32**, and the screen-34 overlap.
4. **FT-243 -- move the log notice to the review screen.**
5. **F4, the second drive** -- now unblocked, and Bill's screen-12 list
   (Part 2D) is the specification for it.
6. **The F6 wording block** -- Bill has written most of the replacement copy
   himself in Part 2B. His one sentence, *"These must be set manually, Checkup
   will show you how,"* resolves five separate screens.
7. **FT-247 -- the numbering**, decided in the design doc first.
8. **FT-246 -- instrument the password-on-wake re-read.** Log both attempts
   before attempting a fix.
9. **The research plan** Bill asked for in Part 2F, as a `.md`, before any of
   it is built.

**Not in ascii44:** the encryption items in Part 2E, which need a live
encryption run on SANDY, and Part 2F, which needs the plan approved first.

---

# PART 4 -- WHAT NEEDS BILL, AND NOTHING CAN PROCEED WITHOUT IT

1. ~~**`N` cannot be both "Back" and "No".**~~ **ANSWERED BY BILL,
   2026-08-30 -- see below. This item is closed.**
2. **Is Malwarebytes still in the product?** Part 2F item 4. It touches
   pricing copy, the licence, the guide and four screens. **Research can
   inform it; only Bill can decide it.**
3. **Screen 12 drive order** -- reverse it so the SSD is Drive 1, as asked?
   It is a one-line change but it is what the customer sees first.
4. **The two screenshots** (21 and 22, screen 16, in
   `OneDrive\Personal\Pictures\Screenshots`) **have never been looked at.**
   They are the only record of whatever happened at screen 16. Put them in
   `Test_Results\` and they can be triaged.

---

# PART 5 -- BILL'S RULING ON THE KEYS, AND THE MEASURED SCOPE

**Bill, 2026-08-30:** *"N always means no and B should always be used to say
back."*

**This closes Part 4 item 1 and reverses the earlier ruling.** FT-236 recorded
that *"`N = go back` stays as the natural answer in real Y/N questions"* and
treated the ascii43 field checklist's demand -- *"B is the ONLY Back key, N
must never take you back"* -- as a defect in the checklist. **The checklist
was right.** FT-236 is withdrawn on its premise; the build moves, not the
checklist. Recorded in `CLAUDE.md` under Product Rules.

## Where Back already works, and where it does not

**Checked all four key readers, because checking only one is how this was got
wrong on 2026-08-17.**

| Reader | Call sites | Handles Back? |
|---|---|---|
| `Pause-ForUser` | 76 | **Yes** -- offers Back via `$ggCanBack`, gated by FT-146 so it only appears where it can actually deliver |
| `Read-NavKey` | 6 | **Yes** -- `if ($ch -eq "B") { $result = "BACK" }` |
| `Confirm-Exit` | 10 | n/a -- exit confirmation, correctly has no Back |
| **`Read-ValidKey`** | **47** | **1 of 47** |

**So Back works on PAGES and not at QUESTIONS**, which is exactly the shape
the 2026-08-17 correction in `CLAUDE.md` describes. The work is confined to
`Read-ValidKey`.

**The model already in the build, line 8548 -- the only site of 47 that has
it:**

```powershell
$goodResp = Read-ValidKey -ValidKeys @("Y","N","B") -Prompt "Choice (Y = Re-apply / N = Skip / B = Back): "
```

## The 7 sites where N means "go back" -- these change

***measured, ascii43 source, 2026-08-30:***

| Line | Current prompt |
|---|---|
| 3825 | `Close Checkup? (Y = close / N = go back)` |
| 6239 | `Your choice (Y = Continue / N = Go back / S = Show me each item)` |
| 6642 | `Still correct? (Y = yes, continue / N = no, ask me again)` |
| 7432 | `Continue WITHOUT encryption? (Y = Yes, continue / N = Go back and select it)` |
| 7461 | `Your choice (Y = Continue / N = Go back / S = Show me)` |
| 7983 | `Have you set Sleep and Display to Never manually? (Y = Yes, continue / N = No, go back)` |
| **8522** | **`Ready to proceed? (Y = Start / N = Go back / Q = Quit)`** -- **screen 27, the one Bill hit** |

**Note 6642 and 7983 are not simple swaps.** Both ask a real question whose
honest answer is "no", and *then* go back as a consequence. They need `B`
added **and** the `N` branch rewritten to mean no -- not `N` relabelled.

## The 11 sites where N means "exit" -- these WAIT

***measured:*** lines 3419, 3466, 3513, 3803, 4271, 4315, 4489, 4538, 4621,
4687, 4928.

**Bill asked for `X` = Exit at screens 14a and 18, with `Q` or `E` as
fallbacks. That is not decided.** Until it is, these keep `N`.

**Do not fold the two changes into one pass.** `N` currently means three
things across 30 of the 47 sites -- No at 12, Back at 7, Exit at 11 -- and
changing two of the three at once is how the confusion comes back wearing a
different letter. **B first, alone, and field-run it.**

## What this costs

**7 prompts rewritten, 7 `ValidKeys` arrays extended, and the `N` branch
rewritten at 2 of them.** Every change is inside `Read-ValidKey` call sites,
every one goes through `gg_edit.py` assert-guarded, and the pattern to copy is
already in the file. **This is a contained change and it should go in
ascii44 with FT-242.**

---

# APPENDIX -- HOW TO REPRODUCE ANY CLAIM IN THIS FILE

Every measurement above names its file and timestamp. The five logs are in
`Test_Results\FieldRun-ascii43\`. Bill's notes are the `-2.docx` in
`Test_Results\`. Source line numbers are against
`Tool\W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1`.

**Next free FT number after this file: 248.**
