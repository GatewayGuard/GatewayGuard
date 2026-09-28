<!-- Dated: 2026-09-28 08:36 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii45 -- test checklist, after Block F and the renumber pass

- **Replaces** `GatewayGuard_FieldChecklist-ascii45-partial-2026-09-27-1142.md`.
  **Every screen number from 4 onward has changed** -- the map is below.
- **Build:** `Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1`, commit
  `da15aea` (2026-09-28), **plus FT-299/300/301 (items 1, 4, 13), added to this list 2026-09-28 12:0x.** Blocks A-F built. **Still open:** F10 (waits on the
  guide text from Cloud) and C7/C9 confirmations on SANDY.
- **Where:** CGDELL or SANDY. **On SANDY, do not turn on encryption.**
- **How to start:** right-click `Tool2\Run-GatewayGuard.bat` -> Run as
  administrator, press Enter at the "opens full screen" note. To look at
  screens without running anything: `Tool2\Show-AllScreens.bat`.
- **SANDY, after the run:** program-start logging is still on there. Turn it
  off with `Tool2\Run-ProgramStartLogging-OFF.bat` (as administrator) when the
  encryption question is settled.
- **Working document** -- plain Markdown, used at the keyboard.

## The marks

| Mark | Means |
|---|---|
| **CHECK** | Changed in ascii45. Test it and write down what you see. |
| **LOOK** | Not changed. Report only something new. |
| **GONE** | Removed. If it appears, that is a finding. |

## The new screen numbers

Numbers now run **1 to 37 with no gaps** on a normal first run. Letters
(14a, 26c ...) are screens only some PCs see. **A number must never go DOWN
the first time you meet a screen** -- if it does, write down both numbers.

| Old | New | Screen |
|---|---|---|
| 1a | **0a** | Welcome back (a checkpoint exists) -- now comes before 1 honestly |
| 4 | -- | Gone: the font sample no longer carries its own number |
| 5-8 | 4-7 | Window, keyboard, what happens next, scroll and copy |
| 9 / 9a / 9b | 8 / 8a / 8b | Pre-flight |
| 10, 11, 11a/b, 12, 13, 14 | 9, 10, 10a/b, 11, 12, 13 | Edition, RAM, time, summary, tools, scans |
| 14h | **14** | Checking your PC's protection, step by step |
| 14c | 14a | Tamper Protection is off |
| 17 / 17a / 17c / 17e | 14b / 14c / 14d / 14e | Antivirus (only when another product is installed) |
| 14f | 14f | Unwanted app blocking |
| 14d / 14e | 14g / 14h | Updates waiting / restart needed |
| 14g | **15** | Before the scan -- what Checkup checked |
| 15 / 14a | 16 / 16a | Pre-scan prep / repeat-run reminder |
| 16 / 14b | 17 / 17a | Offline scan / after the offline scan |
| 16a | 18 | Full scan of every drive |
| (no number) / 18d | **19** / 19a | Power check (plugged in) / on battery |
| 19, 20, 21 | 20, 21, 22 | Power settings, apps, start screen |
| 22 / 22a, 23, 24 | 23 / 23a, 24, 25 | Passwords, what Checkup does 1 and 2 |
| 25 / 26, 25a-25e | 26 / 27, 26a-26e | The checklist and its R-branch screens |
| 27, 27a, 27f, 27b-27e | 28, 28a, **28b**, 28c-28f | Review, re-offered, already encrypted, BitLocker Pro |
| 28, 28a, 29, 30, 30a/b, 31 | 29, 29a, 30, 31, 31a/b, 32 | Device Encryption (Home) |
| 32 | 33 | All selected items processed |
| 33a / 33b | **34 / 35** | NEW: What Checkup changed / Steps for you to do |
| 33, 33c/d, 34 | 36, 36a/b, 37 | Scan reminders, OneDrive, finished |

## Keys -- test anywhere

| Key | What it must do | Mark |
|---|---|---|
| **B** | Back one STEP: 21 -> 20, 22 -> 21, 23 -> 22, 24 -> 23, 25 -> 24, checklist -> 25. On screens 34 and 35 (page 2 onward), back one page. Where there is nothing to go back to it SAYS so | **CHECK** |
| **L** | Shows the previous screen again. Nothing changes | **CHECK** |
| **F** | Redraws the screen to fit the window | **CHECK** |
| **Ctrl+C** | Asks "Are you sure you want to close Checkup?" -- never closes straight away | **CHECK** |
| **X** | Exit, always asks first. **Screen 28 (Review) now says X = Exit, not Q** | **CHECK** |
| **I** | Build and Machine ID | LOOK |

## Screen by screen

| Screen | What it is | Mark | What to check |
|---|---|---|---|
| 1-2 | Welcome, scrolling | LOOK | Full screen notes, F redraws |
| **3** | Text size | **CHECK** | The FONT CHECK sample box has **no screen number of its own**. Only "3" shows |
| 4, 5 | Window, keyboard | LOOK | |
| **6** | What happens next | **CHECK** | Lists the new order: Tamper Protection, virus protection, app blocking, Windows Update, definitions, then the scans |
| 7-13 | | LOOK | |
| **14** | Checking your PC's protection | **CHECK** | Shows each check **as it happens**, in this order: **Tamper Protection, virus protection (Microsoft Defender), unwanted app blocking, Windows Update, virus definitions** |
| 14a | Tamper Protection is off | **CHECK** *(only if off)* | Four steps; Y = check again |
| 14b-14e | Antivirus | **CHECK** *(only with another antivirus)* | With Defender alone there is **no** separate antivirus page any more -- the result is a line on 14 and 15 |
| 14f | Unwanted app blocking | **CHECK** *(only if off)* | Y turns it on and says "confirmed" |
| 14g / 14h | Updates / restart | **CHECK** *(when Windows has updates)* | Turning mark and timer while installing |
| **15** | What Checkup checked | **CHECK** | One line each: Tamper, **virus protection**, app blocking, Windows Update, definitions |
| 16, 16a, 17, 17a | Scans | LOOK | |
| 18 | Full scan | LOOK | |
| **19** | Power check | **CHECK** *(plugged in)* | Now a box with a number. Says Checkup keeps the PC awake while it runs and **does not change your sleep settings** |
| **20** | Power settings | **CHECK** | **A report only -- no Y/N questions** for password on wake, Fast Startup or Wake on LAN ("change only on the security checklist, items 17-19"). Critical battery still asks. The screen-timeout advice is in the box, "Checkup never changes this". **No "next screen is long, scroll up" page before it** |
| 21 | Apps audit | LOOK | B -> 20 |
| 22 | Start screen | LOOK | |
| **23 / 23a** | Your passwords | **CHECK** | **No password-manager product is named.** If you answer N: "the guide, Part 5, shows how to set one up" |
| **24** | What Checkup does (1 of 2) | **CHECK** | "The screens so far only READ your settings -- nothing changed." Tamper Protection "essential, keep it on"; Windows Hello "strongly recommended"; "these must be set by hand, and Checkup will show you how" |
| **25** | What Checkup does (2 of 2) | **CHECK** | Convenience features: "CHANGED ONLY IF YOU SELECT THEM ... At the end, Checkup shows what changed and how to put each one back" |
| **26 / 27** | The checklist | **CHECK** | **Order: 3 Tamper, 2 Defender, 1 Windows Update first**, then 4 onward. Items 13 and 14 at defaults: "Unknown -- nothing stored; select it to set it off". Item 17 on CGDELL: "Only after 15 min away -- needs attention". Item 8 on CGDELL: "Encrypted, protection OFF -- needs attention". "Guide:" lines say **"Setting 14"** etc. -- never "Phase" or "Keep vs. Disable Table" |
| **26 / 27, items 1, 4, 13** | Fixed after Co-Pilot's review (FT-299-301) | **CHECK** | **Item 1:** GOOD normally; if you pause updates first (Settings -> Windows Update -> Pause), it must say **"PAUSED until <date> -- needs attention"**, and running it puts **"Resume updates"** on screen 35 -- resume afterwards. **Item 4:** after running, "Check apps and files set to Warn (recommended) -- GOOD". **Item 13:** SANDY has only one of the two Edge policy values now -- it must say **"DISABLED -- GOOD"**, not "Enabled" |
| **28** | Review | **CHECK** | Rows show "[X]" with **no "APPLYING"**. Prompt: Y = Start / B = Go back / **X = Exit** |
| **run** | Each item as it runs | **CHECK** | **Items 11-15 are changed now, with the rest** -- no question at the end. An item Windows will not let Checkup change says "Windows does not allow any program to change this one, so Checkup shows you the exact steps to do it yourself, at the end" |
| 28a | Already correct, re-offered | LOOK | |
| **28b** | Drive already encrypted, protection off | **CHECK** *(CGDELL, item 8)* | Instead of the BitLocker steps; no new recovery key; Checkup changes nothing |
| 28c-32 | Encryption | LOOK | **Do not turn encryption on (SANDY)**. Screen 29 (Home): "Checkup cannot turn it on -- if it is off, it must be turned on by hand, and Checkup will show you how" |
| 33 | All items processed | **CHECK** | "Next: what Checkup changed, then any steps for you." |
| **34** | **What Checkup changed** (NEW) | **CHECK** | Each item you ran: **Was:** and **Now:**. Green = changed. **Yellow = not changed** (an error, or yours to do). For 11-15 changed: "To put it back: ..." with the exact clicks. More than fits -> pages; B goes back a page |
| **35** | **Steps for you to do** (NEW) | **CHECK** *(when any item is yours to do)* | **One item per screen**, "(1 of N)", with the exact steps |
| 36, 36a/b | Scan reminders, OneDrive | LOOK | |
| **37** | Finished | **CHECK** | Title "CHECKUP IS FINISHED -- STEPS ONLY YOU CAN DO" (not "AUTOMATED STEPS COMPLETE"). Two-step sign-in line points to the guide, Part 5 |
| 33a / 33b (old) | Convenience review | **GONE** | Must not appear |

## Checklist after going back

Start a run, let a few items change, then press **B** at a GOOD item's
question to return to the checklist: **the items Checkup already changed no
longer have an X** (FT-222), so pressing R does not change them twice.

## Resume -- CHECK

Stop partway (X, then Y), run again, choose **R**:

| Check | What must happen |
|---|---|
| Screen **0a** then **1b** | 1b says "Checkup will continue at: ..." |
| Choose **S** (start over) at 0a | Screen 1 follows -- the number goes UP (0a -> 1) |
| Screens 9 and 10 | Not shown again |
| Stopped at the checklist | Back to the checklist, ticks as you left them |
| A finished run | Next run starts fresh, no "Welcome back" |

## The log -- CHECK

- Near the top: `[SCREEN-85] (shown as screen 1)`, then 86 and 87 -- **screens 1-3 are now logged**.
- A "Wake on LAN read:" line for every network adapter, and **no** `[ERROR] SILENT ERROR` lines about wake settings.
- One "Changed summary:" line per item you ran, with Was and Now.
- Keys that did nothing: "Key 'X' IGNORED at: ...".

## Write down, for each CHECK

- The screen number, what you pressed, what you saw.
- Anything marked GONE that appeared, and any number that went down.
- Notes into `Test_Results\`, then tell Claude Code.
