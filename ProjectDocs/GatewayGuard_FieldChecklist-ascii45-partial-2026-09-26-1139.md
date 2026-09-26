<!-- Dated: 2026-09-26 11:39 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii45 -- PARTIAL test checklist (Blocks A, B and C1 only)

- **Build:** `Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1`,
  as of commit `90c1897` (2026-09-26). **Not finished** -- Blocks C (rest), D, E
  and F are still to build.
- **What this checklist is for:** checking the parts that ARE done, so problems
  surface now instead of in the full field run. It is **optional**. The real
  ascii45 field run, with its own full checklist, comes when the build is
  finished (plan: ascii45 to SANDY 2026-10-03).
- **Where to run it:** CGDELL is fine. On SANDY it is fine too, **but do not
  turn on encryption on SANDY** -- the full run needs it unencrypted.
- **How to start:** double-click `Tool2\Run-GatewayGuard.bat` (it now points at
  ascii45). To look at screens without running anything:
  `Tool2\Show-AllScreens.bat`.
- **Working document** -- plain Markdown, used at the keyboard.

## The four marks

| Mark | Means |
|---|---|
| **CHECK** | Changed in ascii45. Test it and write down what you see. |
| **SKIP** | Will change again later in ascii45. Don't report it yet. |
| **LOOK** | Not changed. A quick look is fine; report only something new. |
| **GONE** | Removed. It must **not** appear. If it does, that is a finding. |

**Expected, not a finding:** the screen numbers now jump **17 -> 19** and there
is an **18d** with no 18. Screens 17b, 17d, 18, 18a-c were removed; the
numbers are fixed once, after Block E.

---

## Screen by screen

| Screen | What it is | Mark | What to check |
|---|---|---|---|
| 1 | Welcome / maximize | LOOK | |
| 2 | Scrolling | LOOK | |
| 3 | Set your console font | SKIP | Two screen numbers on it (FT-274) -- later |
| 4 | Font check | SKIP | Same (FT-274) |
| 5 | Before you start -- your window | LOOK | |
| 6 | Before you start -- your keyboard | LOOK | |
| 7 | What happens next | **CHECK** | Item 7 reads "Security scan confirmation **(Defender)**" -- no Malwarebytes |
| 8 | How to scroll back and copy | SKIP | The "M" letter for Mark waits on your SANDY check (FT-270) |
| 9 | Important -- read before continuing | **CHECK** | Prompt says **Y = Yes / X = Exit**. Press **X**: it must ask "Exit now? (Y/N)". Press **N**: you are back at the same question. Then **Y** |
| 9a | Domain-joined warning | **CHECK** *(only on a work-joined PC -- you will not see it at home)* | Y / **X = Exit**, X asks first |
| 9b | Administrator access required | LOOK | |
| 10 | Windows edition detected | **CHECK** *(on Home -- SANDY)* | Says "On Home, encryption is called Device Encryption. Checkup shows you the steps to turn it on yourself." **Not** "handled automatically" |
| 11 | Your PC -- RAM | **CHECK** *(when it warns encryption may take hours -- SANDY)* | Says "Checkup shows the time estimate and your choices when you reach the encryption screen at the end." **No** "option 2" |
| 11a / 11b | Time and date | LOOK | If Checkup has to fix the time, it should say "checked again and confirmed" -- or explain in yellow what did not take |
| 12 | Your system at a glance | LOOK | |
| 13 | Your PC's security tools | **CHECK** | **No Malwarebytes, no 14-day trial.** Has a short "ANOTHER ANTIVIRUS ALREADY INSTALLED?" part. Fits on the screen |
| 14 | The scan we recommend | **CHECK** | Only the **Defender Offline Scan**, with the rootkit explanation. **No Malwarebytes.** Fits on the screen |
| 14a | Reminder (repeat run) | **CHECK** | No Malwarebytes bullet. Prompt **Y = Continue / X = Exit**; X asks first |
| 14b | Welcome back -- offline scan complete | **CHECK** (part) | "'Allowed' ... write down its name -- the guide shows what to do next." **No Malwarebytes.** SKIP the "scan has finished" claim and which page the link opens (FT-277, later) |
| 15 | Pre-scan prep checklist | **CHECK** (part) | Prompt **Y = Scan now / S = Skip scan / X = Exit to prepare**. Press X: the confirm is **X = Exit the tool / B = Back** -- B must return you. SKIP the missing "save your work" warning (later, E5) |
| 16 | Defender offline scan | SKIP | Block E reorders the scans |
| 17 | Antivirus status -- healthy setup | **CHECK** | With only Defender: one green line "OK Microsoft Defender is active as primary AV". With another antivirus also listed: this screen, saying the other one "is not in charge" |
| 17a / 17c / 17e | Antivirus -- other states | **CHECK** *(only if they appear)* | Prompts use **X = Exit ...**; X asks first. 17a never suggests Malwarebytes |
| 17b, 17d | Malwarebytes trial / on duty | **GONE** | Must not appear |
| 18, 18a, 18b, 18c | Malwarebytes screens | **GONE** | Must not appear |
| 18d | Power / battery warning | **CHECK** *(laptop, unplugged)* | **Y = Continue / X = Exit to plug in first**; X asks first |
| 19 | Power settings -- security review | **CHECK** (part) | Password on wake: where it is set, it must now read **REQUIRED -- GOOD**, not "Could not read". If you apply it: green **OK** only when confirmed, otherwise a yellow WARN. SKIP the rest of screen 19 (becomes report-only later) |
| 20 | Apps audit results | LOOK | |
| 21 | Start screen | **CHECK** | Only **[1] START** and **[X] EXIT**. **No GUI mode.** X asks first; N brings the screen back. Fits on the screen |
| 22 / 22a | Your passwords | LOOK | |
| 23 / 24 | What Checkup does and does not do | LOOK | |
| 25 / 26 | The checklist | **CHECK** (part) | **No item 5.** Type **5**: "Item 5 is no longer part of Checkup." Item 17 shows **REQUIRED -- GOOD** where set. SKIP the Back key (Block C, later) |
| 25a-25e | Heads-up / encryption screens | LOOK | |
| 27 | Review your selections | LOOK | SKIP the Back key |
| 27a | Applying your changes | **CHECK** | Each item shows "**Working on this item...**" -- never "applying it now". Items 11-15 show their "saved for your review" result in **cyan, not red**. Item 9's steps wrap -- nothing runs off the right edge. Item 17: "...confirmed -- GOOD" |
| 27b-27e | BitLocker (Pro) | LOOK | **Do not turn encryption on** |
| 28-31, 28a, 30a, 30b | Device encryption | LOOK | **Do not turn encryption on (SANDY)** |
| 32 | All selected items processed | LOOK | |
| 33 | Scan reminder setup | **CHECK** | Title "SCAN REMINDER SETUP". Only the **quarterly Defender Offline Scan** reminder. **No monthly Malwarebytes reminder.** **On SANDY:** "[OK] An old monthly reminder from an earlier version was removed" |
| 33a / 33b | Convenience review | **CHECK** (part) | A change Windows refuses shows **red "Not changed:"** -- never a green "Done:". SKIP the wording (these screens are replaced later) |
| 33c / 33d | OneDrive | LOOK | |
| 34 | Automated steps complete | **CHECK** (part) | **No Malwarebytes item.** "Scan reminders -- Checkup set up popups for a quarterly Defender Offline Scan". The closing says reminders "will still pop up later". SKIP the 2FA line (later) |
| 1a | Welcome back -- a checkpoint exists | SKIP | Resume is Block D |
| 1b | Quick re-check before resuming | **CHECK** (key only) | "Still YOUR personal computer?" now **Y = Yes / X = Exit**. SKIP everything else (Block D removes this question) |
| 1c | Are you sure you want to close Checkup? | **CHECK** | Appears after X on 1b; B goes back |
| 3a | Not administrator | LOOK | |

## Anywhere

| Check | Mark |
|---|---|
| **Ctrl+C** | SKIP -- waits on your SANDY test (FT-270) |
| **B = Back one step, L = look back, F = fix the screen** | SKIP -- Block C, not built yet |
| **Resume lands in the right place** | SKIP -- Block D |
| **The log** (`...\GatewayGuard\Logs\`): no `[ERROR] SILENT ERROR` line about **EnableSmartScreen**, and none about item 6's "registry access is not allowed" | **CHECK** |
| **The log**: item 6 shows an INFO line "protected by Tamper Protection -- expected" | **CHECK** (only if item 6 is selected and Windows blocks it) |
| **On SANDY, after the run:** Task Scheduler has **no** "GatewayGuard - Monthly Malwarebytes Reminder" | **CHECK** |

## Full-screen tests (added 2026-09-26 -- ascii45 C9, not built yet)

These run BEFORE the full-screen launch is built, so its screens are written
from what Windows Terminal actually does.

| Test | Where | What to do | Mark |
|---|---|---|---|
| **Copy and selection** | CGDELL | Double-click `Tool2\Run-TestWtCopySelect.bat`. A full-screen window opens with three steps: highlight some lines for about 5 seconds; press Ctrl+C while they are highlighted; click to clear the highlight, wait 5 seconds, press Ctrl+C again. The results file in `Test_Results\WtCopySelect-...txt` records by itself whether highlighting paused the program and whether the copy worked. | **CHECK** |
| **Is Windows Terminal on SANDY** | SANDY | Nothing extra -- step 7 of `Tool2\Run-MeasureSandyForAscii45.bat` reads it. | **CHECK** |

**There is no X in full screen.** The test window closes by itself. If you
ever need to leave full screen: **Alt+Enter**.

## Write down, for each CHECK

- The screen number, what you pressed, what you saw.
- Anything marked GONE that appeared.
- Put your notes in `Test_Results\` and tell Claude Code.
