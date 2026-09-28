<!-- Dated: 2026-09-27 11:42 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii45 -- PARTIAL test checklist, updated (everything built through 2026-09-27)

- **Replaces** `GatewayGuard_FieldChecklist-ascii45-partial-2026-09-26-1139.md`,
  which covered only Blocks A, B and C1.
- **Build:** `Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1`, as of
  commit `19475d0` (2026-09-28 07:5x -- items 8 and 17 fixed). **Updated 2026-09-28 08:04.**
  **Not finished:** Block F (wording and screens, now including the start order
  Bill asked for) and the screen renumber pass.
- **This is not the final SANDY field checklist.** That one is written when the
  build is finished. This one lets you test what IS built, now.
- **Where:** CGDELL or SANDY. **On SANDY, do not turn on encryption** -- the
  full run needs it unencrypted.
- **How to start:** right-click `Tool2\Run-GatewayGuard.bat` -> Run as
  administrator. **It now shows a short "opens full screen" note; press Enter
  and Checkup opens full screen (C9).** It must still be running as
  administrator there (it is not, if screen 3a appears). To look at screens without running anything:
  `Tool2\Show-AllScreens.bat`.
- **Working document** -- plain Markdown, used at the keyboard.

## The four marks

| Mark | Means |
|---|---|
| **CHECK** | Changed in ascii45. Test it and write down what you see. |
| **SKIP** | Will change again before the field run. Don't report it yet. |
| **LOOK** | Not changed. A quick look is fine; report only something new. |
| **GONE** | Removed. It must **not** appear. If it does, that is a finding. |

**Expected, not findings:** screen numbers jump **17 -> 19** and there is an
**18d** with no 18. The six NEW screens carry temporary numbers **14c, 14d,
14e, 14f, 14g, 16a**. All numbers are fixed in the renumber pass.

---

## Keys -- test these anywhere

| Key | What it must do | Mark |
|---|---|---|
| **B** | Goes back one STEP so you can change an answer: screen 20 -> 19, 21 -> 20, 22 -> 21, 23 -> 22, 24 -> 23, and from the checklist -> 24. Where there is no step to go back to, it SAYS so: "There is no step to go back to from this screen." B must never do nothing silently | **CHECK** |
| **L** | Shows the previous screen again, exactly as it was. Nothing is changed. Enter brings you back | **CHECK** |
| **F** | Fixes the screen: redraws it to fit the window. Try it after making the window narrower or shorter. A screen taller than the window is shown in parts ("Press Enter or Space for the rest") | **CHECK** |
| **Ctrl+C** | Asks "Are you sure you want to close Checkup?" -- never closes Checkup straight away. N carries on where you were. Try it on a page, at a question, and on the checklist | **CHECK** |
| **I** | Shows build and Machine ID | LOOK |
| **X** | Exit -- always asks first | LOOK |

## Screen by screen

| Screen | What it is | Mark | What to check |
|---|---|---|---|
| 1-2 | Welcome, scrolling | **CHECK** | **Full screen (C9):** screen 1 says there is no X, how to leave (X or Alt+F4) and Alt+Enter; screen 2 says mouse wheel or Ctrl+Shift+Page Up/Down. Press **F**: the screen redraws |
| 3, 4 | Text size | **CHECK** | Full screen: "MAKE THE TEXT EASY TO READ" -- Ctrl and + bigger, Ctrl and - smaller, Ctrl and 0 normal, then F. Try them |
| 5 | Your window | LOOK | |
| 6 | Your keyboard | **CHECK** | Item 5 now reads "B, L AND F" and explains all three |
| 7 | What happens next | LOOK | |
| 8 | How to scroll back and copy | **CHECK** | Full screen: highlight with the mouse, press Ctrl+C. **Try it**: the highlight goes and Checkup keeps running; paste into Notepad to see it copied |
| 9 / 9a / 9b | Pre-flight | LOOK | |
| 10 | Windows edition | **CHECK** *(SANDY: Home)* | Shown on a normal run. **Not shown when resuming** |
| 11 | RAM | **CHECK** | Same: not shown when resuming |
| 11a/11b, 12 | Time, system summary | LOOK | |
| 13, 14 | Security tools, the scan we recommend | LOOK | |
| **14c** | Tamper Protection is off | **CHECK** *(only if it is off)* | Gives the four steps. Y = check again, N = continue without it |
| **14d** | Windows Update -- updates waiting | **CHECK** *(when Windows has updates)* | Lists them. **Y: a turning mark and a timer run while they download and install** -- it can take many minutes. N skips them. It checks again after installing, until none are left |
| **14e** | Restart needed to finish the updates | **CHECK** *(only if an update needs it)* | Y restarts (save your work first). After the restart run Checkup again: it continues with the update check |
| **14f** | Unwanted app blocking is not on | **CHECK** | Explains it. Y turns it on and says "confirmed". Check afterwards in Windows Security -> App & browser control -> Reputation-based protection settings -> Potentially unwanted app blocking: **Block apps** should be on |
| **14g** | Before the scan -- what Checkup checked | **CHECK** | One line each for Tamper Protection, Windows Update, unwanted app blocking, virus definitions. OK = safe, NOTE = needs you |
| 14a | Reminder (repeat run) | LOOK | |
| 15 | Pre-scan prep | LOOK | S = skip also skips the full scan offer (16a) |
| 16 | Defender offline scan | **CHECK** | New lines: "SAVE AND CLOSE YOUR WORK FIRST. The restart comes about five seconds after you press Y." |
| 14b | After the offline scan | **CHECK** *(only after an offline scan)* | Title "WELCOME BACK -- AFTER THE OFFLINE SCAN". It must **not** say the scan "has finished" |
| **16a** | Full scan of every drive | **CHECK** | Y: "Full scan started ... runs in the background". **On SANDY it covers the second (1 TB) drive and can take hours.** Checkup carries on meanwhile. Results: Windows Security -> Virus & threat protection -> Protection history |
| 17 / 17a / 17c / 17e | Antivirus status | LOOK | |
| 17b, 17d, 18, 18a-c | Malwarebytes screens | **GONE** | Must not appear |
| 18d | Power / battery | LOOK | |
| 19 | Power settings | **CHECK** (part) | Password on wake: **REQUIRED -- GOOD** only when it is on both plugged in AND on battery. SKIP the rest (Block F makes it report-only) |
| 20 | Apps audit | **CHECK** | Ends with "Or press B to go back to the power settings review" -- B shows screen 19 again |
| 21 | Start screen | **CHECK** | Now has **[B] BACK -- to the apps review**. B works |
| 22 / 22a | Your passwords | **CHECK** | Prompt offers B = back to the start screen |
| 23, 24 | What Checkup does | **CHECK** | B from 23 shows screen 22 **in full** (box and number), not a bare question |
| 25 / 26 | The checklist | **CHECK** | Legend shows "B = go back one page" and "F = fix the screen". **Item 9 (Windows Hello):** if you last signed in with your PIN it says "You sign in with Windows Hello -- GOOD"; if you last used your password it gives the yellow "MANUAL CHECK ... press the Windows key + L ..." steps. **Item 17:** GOOD only when both values are on **Item 17** on CGDELL must now say **"Only after 15 min away -- needs attention"** (Settings' "If you've been away" is 15 minutes there) -- NOT "REQUIRED -- GOOD". If you select it and run it, Settings should then show **Every Time**. **Item 8** on CGDELL must say **"Encrypted, protection OFF -- needs attention"**, not "NOT Encrypted" |
| 27 | Review | LOOK | |
| 27a | Applying | LOOK | |
| 27b-31 | BitLocker / Device Encryption | LOOK | **Do not turn encryption on (SANDY)** |
| **27f** | **Drive already encrypted, protection off** (new, FT-297) | **CHECK** *(CGDELL, item 8 selected)* | Must appear INSTEAD of the BitLocker steps. It must NOT show a new recovery key and must NOT say encryption has started. It tells you: Manage BitLocker -> Resume protection, and Back up your recovery key. Checkup changes nothing here |
| 32, 33 | Processed, scan reminder | LOOK | |
| 33a/33b | Convenience review | SKIP | Replaced in Block F |
| 34 | Automated steps complete | LOOK | SKIP the 2FA line (Block F) |

## Already known -- no need to report again

Found in Bill's CGDELL runs 2026-09-27 and 09-28, recorded in the plan (F12-F20), not yet built:

| What you will see | Plan |
|---|---|
| Tamper Protection is checked first but silently; the antivirus check comes after the scans; 14g has no antivirus line | FT-290, FT-298 -- your order: Tamper, virus protection, app blocking, Windows Update, each shown as it happens |
| Two pages with no screen number after screen 15 (antivirus OK, power check) | FT-298 |
| "Sleep prevention: SET BY THIS TOOL ... will be restored" -- it changes no setting | FT-291 |
| Screen 19: the screen-timeout line appears right after your answer | FT-293 -- moves to the review screen |
| Wake on LAN still "Enabled" on the checklist after Checkup turned it off | FT-292 |
| Items 13 and 14 "Unknown -- could not check" | FT-295 |
| Checklist order: Windows Update, Defender, Tamper | FT-296 -- becomes Tamper, Defender, Windows Update |
| Screen 7's list of checks is out of date | F11 |

## Resume -- CHECK

Stop Checkup partway (X, then Y), then run it again and choose **R = Resume**:

| Check | What must happen |
|---|---|
| Screen 1b | Says **"Checkup will continue at: ..."** and names the place |
| "Still YOUR personal computer?" | **Not asked** on the same PC -- a green "Same computer as before" line instead |
| Screens 10 and 11 | **Not shown again** |
| Stopped at the checklist | Resume goes straight back to the checklist, **with your ticks as you left them** |
| Stopped at screen 23 or 24 | Resume goes to 23 without asking the password question again |
| A run you finished to the end | The next run starts fresh -- **no "Welcome back"** screen |

## The log -- CHECK

`...\GatewayGuard\Logs\`, newest file:

- Every key that did nothing appears as a line "Key 'X' IGNORED at: ...".
- "Ctrl+C guard armed" near the top.
- Item 9: a line "Item 9 (Windows Hello): HELLO" or "NOT_CONFIRMED" with the reason.
- No `[ERROR] SILENT ERROR` about EnableSmartScreen or item 6.
- On SANDY after the run: Task Scheduler has **no** "GatewayGuard - Monthly Malwarebytes Reminder".

## Write down, for each CHECK

- The screen number, what you pressed, what you saw.
- Anything marked GONE that appeared.
- Put your notes in `Test_Results\` and tell Claude Code.
