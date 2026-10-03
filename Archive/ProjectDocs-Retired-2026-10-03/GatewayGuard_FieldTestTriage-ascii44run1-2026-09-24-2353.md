# ascii44 field run on SANDY, 2026-09-19/20 -- triage (DRAFT)

<!-- Dated: 2026-09-24 23:53 ET -->
<!-- Editor: Claude Code (CGDELL) -->
- **Checked by Claude Code before filing:** FT-268 re-measured (`/query` returns no CONSOLELOCK index, `/qh` returns AC/DC 0x1) and FT-265 source lines 9812/9815 re-read -- both confirmed. The rest is as the triage pass wrote it.

- **Status:** DRAFT. Nothing in the repository has been edited. Written for Bill's review before any of it becomes an FT entry or a build change.
- **Inputs, all read in full:**
  - Bill's notes: `Test_Results\Ascoo44-test-resiults-2026-09-19=1231.txt` (32 notes)
  - Run logs: `C:\Users\willi\OneDrive\GatewayGuard\Logs\GatewayGuard-Log-2026-09-19_{11-45,12-05,12-35,13-08,13-49,14-04,14-08,14-23}.txt` and `...-2026-09-20_16-31.txt`
  - Build: `Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1`
  - Screenshots named in note 25: `C:\Users\willi\OneDrive\Personal\Pictures\Screenshots\Screenshot (24).png` and `(25).png`
- **There are 9 log files, not 10.** Measured: the Logs folder listing shows 8 files dated 2026-09-19 plus 1 dated 2026-09-20 16-31. All 9 carry `Build: ascii44` and `Computer: SANDY`.
- **Labels:** **measured** = I read it in a log line, a source line, or ran a read-only command, cited inline. **inferred** = reasoning from that evidence; could be wrong. Where I could not settle something, it says **CANNOT DETERMINE** and names what is missing.
- **Two read-only commands were run on CGDELL while writing this** (no admin, nothing changed): `powercfg /query` versus `powercfg /qh` for CONSOLELOCK, and a registry read of the Dsh and DataCollection keys. Their output is quoted where used.

---

## PART 0 -- THE FOUR FINDINGS THAT MATTER MOST

1. **The password-on-wake read has never been able to work, on either machine, and the cause is now measured (new FT-268).** `Get-GGConsoleLockState` runs `powercfg /query`, and CONSOLELOCK is a hidden power setting. `/query` does not list hidden settings; `/qh` does. **Measured on CGDELL 2026-09-24 23:4x:**
   ```
   --- /query ---
   Power Scheme GUID: 381b4222-...  (Balanced)
     GUID Alias: SCHEME_BALANCED
   --- /qh ---
   ... Power Setting GUID: 0e796bdb-100d-47d6-a2d5-f7d2daa51f51  (Require a password on wakeup)
         GUID Alias: CONSOLELOCK
       Current AC Power Setting Index: 0x00000001
       Current DC Power Setting Index: 0x00000001
   ```
   SANDY's logs show the same header-only output every time (for example 13-08 log, 13:09:12: `Raw powercfg output: Power Scheme GUID: 48684d4a-... (HP Recommended)`). **So FT-256's NO_INDEX is not an odd machine state. It is the wrong switch.** FT-256 fixed the verdict, which was right. The read itself was never going to work.
2. **Resume always shows screens 10 and 11 again (new FT-265).** That is why notes 9, 14, 16, 21 and 24 all say "back to screen 10." Measured: `Get-WinEdition` (line 9812) and `Get-RAMStatus` (line 9815) run with no checkpoint test, on every launch, resume included. Every resume log shows SCREEN-34 and SCREEN-35 straight after 1b.
3. **Ctrl+C still ends Checkup with no confirmation and no exit reason in the log (new FT-270, which reopens FT-150).** This happened twice (runs 11-45 and 14-08). Each time the log ends with `called from: PowerShell.Exiting engine event (last-resort cleanup)`. There is no `User confirmed exit` line, and no FT-150 `Ctrl+C arrived as a console signal` line. Bill's note 3 is the same complaint as field note 21 from 2026-07-30, which FT-150 was written to fix.
4. **B does two different things, and Bill expects a third (Decision 1).** B on a page means "look at a picture of the previous screen." It navigates nowhere and re-asks nothing (`Show-LookBack`, line 2149). B at a question works only where that question has its own B. Where B is not available, `Pause-ForUser` swallows it silently (line 2720: "Every other key is silently swallowed"), and nothing is logged. Notes 10, 15, 19, 20, 21, 22, 26 and 27 are all this one gap.

---

## PART 1 -- THE RUNS: HOW MANY, WHEN, AND HOW EACH ENDED

Nine launches. Every one is `Build: ascii44`, `Computer: SANDY`, Machine ID `F7F13A97D58D`.

| Run (log) | Start | Last line | Start mode | Furthest screen | How it ended (measured from the last lines) | Bill's notes |
|---|---|---|---|---|---|---|
| R1 `09-19_11-45` | 11:45:39 | 12:01:32 | 1a -> **S** (start over) | 11 (look-back open) | **Abnormal, no reason logged.** `Sleep prevention deactivated ... (called from: PowerShell.Exiting engine event (last-resort cleanup))`, then the footer. No `[EXIT]` line. Bill: Ctrl+C. | 1-3 |
| R2 `09-19_12-05` | 12:05:05 | 12:21:11 | No checkpoint (fresh) | 16, offline scan **Y** | **By design:** `Starting Defender Offline Scan -- reboot expected` 12:21:06, `Sleep prevention deactivated (called from: Invoke-OfflineScanOffer)` 12:21:11, footer. | 4-8 |
| R3 `09-19_12-35` | 12:35:54 | 13:03:56 | Resume `OfflineScanPending` | 18c | **Window X:** `[13:03:56] [EXIT] SESSION ENDED EARLY -- the window's X (close button) was clicked.` Bill: clicked by accident while scrolling. | 9-13 |
| R4 `09-19_13-08` | 13:08:45 | 13:27:24 | Resume `DefenderAV` | 19 (after N) | **Window X** at 13:27:24, same `[EXIT]` wording. Bill: "lost the program not sure why." | 14-15 |
| R5 `09-19_13-49` | 13:49:03 | 14:03:38 | Resume `DefenderAV` | 21 | **Clean exit:** `Key '3' accepted at: Select-Mode` / `User exited at mode selection`, footer. | 16-20 |
| R6 `09-19_14-04` | 14:04:46 | 14:08:20 | Resume `AppsAudit` | 21 | **Clean exit** at 21 (key 3). | 21 |
| R7 `09-19_14-08` | 14:08:35 | 14:22:50 | 1a -> **S** | 23 (then bare password question) | **Abnormal, no reason logged**, same signature as R1: last key `Nav 'BACK' at: Show-ScopeDisclaimer` 14:22:39, then `PowerShell.Exiting ... (last-resort cleanup)` 14:22:50. Bill: Ctrl+C. | 22 |
| R8 `09-19_14-23` | 14:23:23 | **2026-09-20 16:29:05** | Resume `AppsAudit` -> **GUI (2)** | 34 | **Unrecorded.** A footer was written mid-run at 14:43 (lines 61-64). The run then carried on to screen 33 overnight and screen 34 the next day. The last line is `[SCREEN-72] (shown as screen 34)` with **no footer and no exit reason after it.** See FT-280(a). | 25-26 |
| R9 `09-20_16-31` | 16:31:51 | 18:54:51 | Resume `AppsAudit` (again) -> Console (1) | 34 | Reached screen 34. The last lines are `Sleep prevention deactivated (called from: Run-ConsoleMode)` and the footer. **No crash.** | 26-32 |

**No run crashed with an unhandled error.** Measured: no log contains `UNHANDLED ERROR` (the global catch at line 9944). Two runs ended by Ctrl+C with no record of why (R1, R7). Two ended by the window X (R3, R4). One ended with no record at all (R8). Two ended cleanly at the mode selector (R5, R6). One was the offline-scan reboot (R2). One completed (R9).

**R9 resumed from `AppsAudit` even though R8 had finished the whole run in GUI mode.** That is FT-267: the checkpoint is never cleared after a finished run.

---

## PART 2 -- BILL'S 32 NOTES, ONE BY ONE

### Note 1 -- "Scr 2 -- Scrolling"
- **What Bill saw:** screen 2, the scrolling instruction. No problem is stated.
- **Log:** R1 11-45. The intro screens 1-3 (IDs 85/86/87) are **never logged by ID**. Only `Continue accepted at: Show-FontInstructions` 11:46:02 and `Nav 'NEXT'` 11:46:07 appear. Measured: they print their number through `Write-Host`, not `Draw-Box` (lines 3363, 3371, 3382), so no `[SCREEN-NN]` line is written.
- **Source:** `Show-FontInstructions`, line 3371: `"  SCROLLING  (Screen " + (Get-ScreenNumber -ScreenId "86") + ")"`.
- **Classification:** **CANNOT DETERMINE.** The note names a screen and nothing else. Bill: was there a problem on screen 2, or was this a heading for the notes that follow?
- **Related gap (measured):** screens 1-3 leave no trace in the log. Folded into FT-274.

### Note 2 -- "No Scr # at top -- Set your font etc / scr #4 at the bottom"
- **What Bill saw:** the font page has no screen number at the top, and "Screen 4" appears at the bottom.
- **Log:** R1 11:46:07 `[SCREEN-28] (shown as screen 4) Rendered: FONT CHECK: If this box has clean lines, you are ready.`
- **Source (measured):** `Show-FontInstructions`, lines 3379-3407. The page draws a yellow header box by hand. The number `(Screen 3)` comes on the **fourth** line in DarkGray (3382). The page then ends with a real `Draw-Box -ScreenId "28"` sample box (3403). `Write-GGBox` stamps `[ Screen 4 ]` into that box's top border (2268-2272). **So one page shows two numbers, 3 and 4.** Screen 4 is a sample box inside screen 3, and no page of its own ever carries it.
- **Classification:** **DEFECT** (numbering).
- **Fix:** draw the FONT CHECK sample without a ScreenId (or with a `-NoNumber` path), move "(Screen 3)" onto the header line, and remove ID 28 from `$script:GGScreenLabels`. Renumber by the table rule. **FT-274, ascii45.**

### Note 3 -- "Scr 8 -- letter M did nothing, had to select Mark to initiate copy. Copy did work. Ctrl C exited the pgm"
- **What Bill saw:** the screen-8 copy steps (Alt+Space, E, M) failed at M. He had to click Mark in the menu. Copying worked. Then Ctrl+C ended Checkup.
- **Log (R1, measured):** screen 8 at 11:59:00-11:59:04, then 9, 10, 11. `Look-back opened at: Get-RAMStatus` 11:59:40. Next line 12:01:32: `Sleep prevention deactivated -- ... (called from: PowerShell.Exiting engine event (last-resort cleanup))`, then the footer. **No `User confirmed exit`, no `[EXIT]`, no `Ctrl+C arrived as a console signal ... FT-150` line.**
- **Source:**
  - Screen 8 text, `Show-ScrollCopyTip` line 4045: `"  2. Press E, then M"`. The same "Alt+Space, then E, then M" wording is in the resume tip (3930), the BitLocker tip (9313) and the GUI tip (9678). CLAUDE.md fixes it as the standard wording.
  - Ctrl+C handling: every reader turns key char 3 into `Invoke-CtrlCExit` -> `Confirm-Exit` (Read-ValidKey 2791, Pause-ForUser 2678, Read-NavKey 2865, Show-LookBack 2214, checklist 8900). Signal handling: `GatewayGuard.CtrlHandler.Handle` swallows CTRL_C and appends a `[KEY] Ctrl+C arrived as a console signal` line (3024-3031).
- **What the log proves (measured):** neither path ran. A Ctrl+C read as a key would have shown the confirmation and logged `[EXIT] User confirmed exit` on Y. A Ctrl+C caught by our handler would have logged the FT-150 line. The engine instead shut down in an orderly way (the Exiting event fired). **Inferred:** PowerShell's own console break handler got the signal first and stopped the pipeline. A `PipelineStoppedException` cannot be caught by the script's `try/catch`, and it produces exactly this signature: an Exiting-event footer and nothing else. **Not proven:** why our handler was not called first.
- **Copy step (inferred, not measured):** in the classic console's Edit submenu the accelerator for Mark is probably **K** ("Mar**k**"), not M. That would explain "M did nothing." **Needs one look on SANDY:** press Alt+Space, then E, and read which letter is underlined in "Mark." Do not change the wording until it has been seen.
- **Classification:** Ctrl+C = **DEFECT, reopens FT-150** (new **FT-270**). Copy tip = **WORDING, pending measurement** (part of FT-270's field check).
- **Fix:** (a) Reproduce on CGDELL with a bounded test script: Ctrl+C at a `Read-ValidKey` prompt, before and after using Mark mode, logging `[GatewayGuard.CtrlHandler]::LastEvent`. (b) Also log a line from the `PowerShell.Exiting` action saying no exit path was recorded, so the next occurrence is explicit rather than inferred. (c) Correct the Mark letter in all four places once measured. ascii45.

### Note 4 -- "Scr 10 -- says BitLocker will be handled automatically"
- **What Bill saw:** screen 10 promises automatic BitLocker handling on Home.
- **Log:** SCREEN-34 in every run. R9 18:20:48 shows what actually happens: `[SKIP] BitLocker/Device Encryption: Home edition -- manual path shown across 4 screens, no changes made by Checkup`.
- **Source:** `Get-WinEdition` lines 3738-3739: `"  BitLocker uses Device Encryption on Home -- handled               "`, `"  automatically by Checkup.                                         "`. Screen 11 (`Get-RAMStatus`, 3769-3770) has the same fault: `"  Schedule it to run overnight -- select option 2            "` / `"  (Enable overnight) when you reach the BitLocker screen.    "`. The Home path (screens 28-31) has no option 2.
- **Classification:** **WORDING** (states behaviour the build does not have).
- **Fix:** screen 10 becomes "On Home, encryption is called Device Encryption. Checkup shows you the steps to turn it on yourself." Screen 11's "option 2" line applies only on Pro; show it only there. **FT-278, ascii45.**

### Note 5 -- "Scr 12 -- shows 2 hard drives in correct order"
- **Log:** R2 12:09:53 and R7 14:09:12, `[SCREEN-09] (shown as screen 12) Rendered: YOUR SYSTEM AT A GLANCE`.
- **Classification:** **WORKS AS DESIGNED.** This closes the CLAUDE.md line "Needs one look on SANDY: screen 12's drive order."

### Note 6 -- "Scr 13 -- recommends we add Malwarebytes, no longer true, rewrite. Add C:\ to GG checkup statement"
- **Source:** `Show-SecurityToolsBriefing` lines 4339-4352 ("MALWAREBYTES (we recommend adding it)" plus the 14-day-trial block). "YOUR RECORDS" (4354-4357) says only "saved in your own GatewayGuard folder" and gives no path.
- **Measured:** on SANDY the log is not under `C:\` at all. Every run logs `Log location: C:\Users\willi\OneDrive\GatewayGuard\Logs (OneDrive -- already set up on this PC)`.
- **Classification:** Malwarebytes = **ALREADY KNOWN** (removal decided 2026-09-08; ascii44 predates it). Folder = **WORDING**.
- **Fix:** rewrite screen 13 without Malwarebytes, and print the real folder from `$GGUserDir` / `Split-Path $LogPath`, not a fixed `C:\`. **Inferred:** a fixed `C:\GatewayGuard` would be wrong on every OneDrive machine. Goes with the Malwarebytes removal and the FT-253 wording block, ascii45.

### Note 7 -- "Scr 14 -- wrong in a lot of ways; we recommend Defender Offline and then full scan; no longer MB"
- **Source:** `Show-ScanPlanBriefing` lines 4380-4395. "SCAN 2: MALWAREBYTES CUSTOM SCAN" and "LATER, MONTHLY" both describe Malwarebytes. Measured: the build has 6 matches for `Start-MpScan|FullScan|ScanType`, and none of them is an offer to run a Defender full scan in the flow. The 6 include the FT-175 history comments.
- **Classification:** **ALREADY KNOWN** (Malwarebytes removal) + **DESIGN DECISION NEEDED** (what replaces Scan 2: Decision 6).
- **Fix:** the screen text follows the Decision 6 answer. ascii45.

### Note 8 -- "Scr 16 -- initiated offline scan, did not return, had to reopen Word and Notepad; no indication from PC what happened; showed 14a before running the offline scan"
- **Log (R2, measured):** `[SCREEN-39] (shown as screen 14a) Rendered: REMINDER: PRE-SCAN RECOMMENDED` 12:20:40 -> `Key 'Y' accepted at: Show-PreScanGate` -> `[SCREEN-38] (shown as screen 16)` 12:20:54 -> `Key 'Y'` 12:21:06 -> `Checkpoint saved: OfflineScanPending` -> `Starting Defender Offline Scan -- reboot expected` -> 12:21:11 sleep prevention off, footer. The next launch is R3 at 12:35:54, **14 min 43 s later** (reboot + scan + reboot + relaunch).
- **Source:**
  - 14a appears because this is not a first run. `Show-PreScanGate` (4415 vs 4475) shows the SCREEN-10 prep checklist ("Close all open programs...") **only when `$global:IsFirstRun`**. Repeat runs get SCREEN-39 instead, which says nothing about closing programs. SCREEN-39 is also a Malwarebytes line and an `N = Exit` prompt (4489).
  - Screen 16 (`Invoke-OfflineScanOffer`, 4518-4537) says the PC "will restart automatically." **It never says to save open work.** After Y: `Start-Sleep -Seconds 5` (4547) then `Start-MpWDOScan` (4549).
- **Classification:** **DEFECT.** Unsaved work was lost, and the save warning exists only on the first-run path. 14a showing first is **WORKS AS DESIGNED** (repeat run), but its wording is **ALREADY KNOWN** (Malwarebytes, and N = Exit waits on the X decision).
- **Fix:** add to screen 16: "SAVE AND CLOSE everything you have open first -- Word, Notepad, your browser. The restart will not wait." Then ask the question. Show the prep steps on repeat runs too. **FT-276, ascii45.**

### Note 9 -- "Went back to Scr 10 after I assume offline scan ended"
- **Log (R3, measured):** 1a -> R `resume from checkpoint: OfflineScanPending` -> resume tip pause (`Continue accepted at: Show-ResumePrompt` 12:36:10) -> 1b -> Y -> `[SCREEN-34] (shown as screen 10)` 12:36:21 -> `[SCREEN-35] (shown as screen 11)` 12:37:15 -> `[SCREEN-40] (shown as screen 14b)` 12:37:17.
- **Source:** main flow lines 9812 and 9815 call `Get-WinEdition` and `Get-RAMStatus` with no `Test-CheckpointReached` guard. Every other pre-flight step has one (9818, 9823, 9866, 9879, 9886, 9892, 9902, 9908). Both functions `Clear-Host`, draw a numbered box and `Pause-ForUser` (3730-3743, 3760-3775).
- **Classification:** **DEFECT.** The user is shown screens 10 and 11 as if new, before reaching the place they left.
- **Fix:** on resume, read the edition and RAM silently (the values are still needed later), and skip both screens. Have 1b say where the user is going: "You stopped at screen 19. Checkup will pick up at screen 19." **FT-265, ascii45.**

### Note 10 -- "Scr 14b after Scr 10; B goes back to Scr 11 which looks like it was skipped, B goes back to Scr 10 and then next is 14b again; then it opened Device Security not Protection History; last scan shows 9/14 and Protection History says 'no recent actions'"
- **Log (R3, measured):** screen 11 was on screen for **2 seconds** (rendered 12:37:15, continued 12:37:17). Then 14b 12:37:17. Then **six** `Look-back opened at: Show-PostScanGuidance` between 12:37:29 and 12:44:29. `Continue accepted` 12:44:47 (this starts `windowsdefender://protectionhistory`). `Key 'N'` to "Did you find any items needing action?" 12:50:41.
- **What happened (measured from source):** B on 14b is **look-back**. `Pause-ForUser` 2703-2705 calls `Show-LookBack`, which repaints the saved snapshot of the previous screen (11), then the one before (10). Enter/Space returns to 14b (2215). **Nothing navigated.** That matches exactly what Bill describes. Screen 11 "looked skipped" because it was up for 2 seconds. **Inferred:** a second keypress, or the post-accept drain not catching a fast double-tap.
- **"Opened Device Security":** 4589 `Start-Process "windowsdefender://protectionhistory"`. **CANNOT DETERMINE.** The URI has no VERIFIED comment beside it (measured: 4588-4590), so nothing records that this deep link was ever confirmed to open Protection History. It needs one measured launch on CGDELL and on SANDY.
- **"Last scan 9/14, no recent actions":** **CANNOT DETERMINE** if the offline scan ran. **Inferred:** Windows Security's "last scan" line may not count offline scans, so 9/14 does not prove the scan failed. Checkup read nothing either way. 14b's first line, "Your Defender Offline Scan has finished" (4573), is asserted from the checkpoint alone, not from any reading of Defender.
- **Classification:** look-back behaviour = **WORKS AS DESIGNED, but it is the wrong design for this user** (Decision 1). URI = **DEFECT, unverified external call** (FT-277). The unconfirmed "finished" claim = **DEFECT** (FT-277).
- **Fix:** measure the URI. Replace "has finished" with a real read of the Defender Operational event log after the reboot (bounded, `-MaxEvents`). Say what was found: scan completed or no record found. ascii45.

### Note 11 -- "Scr 17 -- another mis-written screen; talks about Defender + MB being the recommended setup"
- **Log:** R3 12:50:50 `[SCREEN-43] (shown as screen 17) Rendered: OK  ANTIVIRUS STATUS -- HEALTHY SETUP` / `Defender active as primary AV. MB Free installed as companion.`
- **Source:** `Test-DefenderPrimary` lines 4749-4766: `"  This is the RECOMMENDED setup:"` over the Malwarebytes companion lines.
- **Classification:** **ALREADY KNOWN** (Malwarebytes removal; CLAUDE.md "REMOVAL IS GENERALISATION, NOT DELETION": items 2 and 7 must keep a generic third-party-AV read).
- **Fix:** in the removal build, screen 17 says only whether Defender is on and, if another antivirus holds real-time protection, names it neutrally.

### Note 12 -- "I thought we rescoped the start: check Tamper first, then loop Windows Update until finished. Am I even running ascii44? Nothing told me. Log says ascii44."
- **Measured:** the rescoped start is **FT-250** (settle the machine: Tamper Protection -> Update -> nuisance -> signature age -> scans) and **FT-252** (Windows Update). `GatewayGuard_ascii44Scope-WhatsInWhatsNext-2026-09-17-1441.md` records both as **"Not built"** (Block B). Bill ran what the build contains.
- **Build visibility (measured):** the build ID appears on screen 3 in DarkCyan (`Version: ... Build: $BuildID`, line 3385) and on the I screen (2754). **On resume, screen 3 never runs** (9793 `if (-not $global:ResumeFrom) { Show-FontInstructions ... }`). A resumed run never shows the build unless the user presses I.
- **Classification:** rescope = **ALREADY KNOWN** (FT-250/FT-252, Block B, not built). Build visibility = **WORDING / small DEFECT**.
- **Fix:** print `Build: ascii45` on 1a and 1b. Folded into FT-265. FT-250/252 are a scope call for ascii45 (Decision 6).

### Note 13 -- "Scr 18 -- says MB detected, user told twice already; too long; showed a Y answer; hit spacebar and screen showed nothing; tried to scroll back and accidentally ended Checkup"
- **Log (R3, measured):** `[SCREEN-73] (shown as screen 18)` 12:57:38 -> `Key 'Y' accepted at: Show-MalwarebytesFollowUp` 12:59:50 -> `Launched Malwarebytes ...` -> `[SCREEN-48] (shown as screen 18c)` 12:59:50 -> `Look-back opened at: Show-MalwarebytesFollowUp` 13:01:04 -> `[13:03:56] [EXIT] ... the window's X (close button) was clicked.`
- **Source:**
  - SCREEN-73 is 33 content lines (4921-4954). It is on the gate-12b over-26 baseline (CLAUDE.md lists 73).
  - After Y, the code prints `"Click 'Scan' to check for threats."` (4977) **directly under a box that says "do NOT click Scan itself"** (4937). It then draws 18c **under** 18 with no `Clear-Host` (4990-5041). So the Y echo (`Write-Host $ch`, 2835) sits mid-page between two long boxes. **Inferred:** that is the "Y answer" Bill saw.
  - "Spacebar and screen showed nothing": the look-back at 13:01:04 restored a snapshot of a page far taller than the window. **CANNOT DETERMINE** exactly what was painted; `Restore-ScreenSnapshot` (2128-2147) writes from buffer row 0 and does not scroll the view. Same family as FT-259 (window height is never measured).
  - The X click is logged by the FT-160 handler as the window's X.
- **Classification:** **ALREADY KNOWN** (Malwarebytes removal deletes screen 18 and 18c; 73 is on the length baseline). The "Click 'Scan'" contradiction dies with it. Look-back blank = **ALREADY KNOWN**, FT-259 family.
- **Fix:** none separately. The removal build deletes the screen.

### Note 14 -- "Went back to Scr 10 then Scr 11 then 'checking power related settings' with no screen #"
- **Log (R4, measured):** 1b -> SCREEN-34 (10) 13:09:01 -> SCREEN-35 (11) 13:09:04 -> `Password on wake: read produced no setting index (FT-256, NO_INDEX)` 13:09:12 -> `Look-back opened at: Run-PowerSettingsCheck` 13:14:51 -> `Continue accepted at: Run-PowerSettingsCheck` 13:15:05 -> SCREEN-50 (19).
- **Also measured:** screen 18 was **skipped** on this resume. No SCREEN-73 appears, and no `Checkpoint saved: Malwarebytes`. See FT-266.
- **Source:** `Run-PowerSettingsCheck` 5171-5173 (`"  Checking power-related security settings..."`) and 5297-5300 (`"Power settings check complete. The NEXT screen is a long one -- BE SURE TO SCROLL UP..."`, then `Pause-ForUser`). No `Draw-Box`, so no number.
- **Classification:** 10/11 replay = **DEFECT** (FT-265). Unnumbered page = **DEFECT** (FT-275). MB skip = **DEFECT** (FT-266).
- **Fix:** FT-265 as above. FT-275: either drop the pre-page (the long-screen warning is FT-259's job) or give it an ID and a number.

### Note 15 -- "Scr 19 too long; selected N; B did not work; the description at the bottom should read GOOD for those set as recommended; two Wi-Fi devices + an Ethernet adapter -- what did Checkup report on, and shouldn't it report the second Wi-Fi too; lost the program, will resume"
- **Log (R4, measured):** `Power settings: PW=Could not read -- check by hand FastStart=DISABLED -- GOOD WOL=DISABLED -- GOOD Screen=Found: NEVER ... CritBatt=HIBERNATE -- GOOD` 13:15:06. `Key 'N' accepted at: Run-PowerSettingsCheck` 13:16:47. **Then no key of any kind is logged for 10 minutes 37 seconds**, until `[13:27:24] [EXIT] ... the window's X (close button) was clicked.`
- **Which question N answered (measured):** only item [1] Password on wake was not GOOD (5365), so N was the answer to "[1] Password required on wake ... Apply? (Y/N)" (5369). Next came `Apply-PowerSettings` ("-- Password on wake -- skipped") and `Pause-ForUser "  Power settings complete. Press Enter or Space to continue..."` (5424).
- **Why B did nothing (measured from source):** at that pause, B is accepted only if look-back is offered (2652-2658): a previous snapshot must exist **and** have been captured at the current buffer width. If not, B lands in the `# Every other key is silently swallowed` path (2720). No message appears and nothing is logged. **CANNOT DETERMINE which condition failed.** The log shows the window was 60 columns earlier in this run (`Write-GGBox: a line was truncated to fit the window (60 cols)` at 13:09:04). **Inferred:** a resize (maximize) between the two snapshots would turn Back off exactly like this. **Either way, B produced no feedback, and that part is a defect.**
- **"Lost the program":** the log records the window-close signal (type 2 = CTRL_CLOSE, handler line 3045). **Inferred:** an accidental click on X, the same as note 13.
- **Wi-Fi/Ethernet:** `Run-PowerSettingsCheck` 5214-5241 loops **every** `Get-NetAdapter -Physical`, so both Wi-Fi adapters and the Ethernet adapter were examined (**inferred**: -Physical includes disconnected adapters). It reports **one combined verdict** and logs no per-adapter detail. **CANNOT DETERMINE** from the log which adapters had readable wake properties.
- **"Should read GOOD":** the bottom summary lines already say, for example, `[2] Fast Startup -- DISABLED -- GOOD, no change needed.` (5385). **CANNOT DETERMINE** what wording Bill wants. Bill: which line, and what should it say?
- **Length:** SCREEN-50 is on the gate-12b baseline. **ALREADY KNOWN.**
- **Classification:** silent B = **DEFECT** (FT-271). Per-adapter reporting = **DESIGN DECISION** (Decision 10) + a logging **DEFECT** (FT-281). Length = **ALREADY KNOWN**.
- **Fix:** FT-271: when Back is not available, say so: "Back is not available on this screen -- press Enter or Space to continue." Log ignored keys, rate-limited as the checklist already does (8953-8963). FT-281: log each adapter name and each wake property value read.

### Note 16 -- "Pressed a number of keys, one was N, it said to press B to go back; I did and ended up on Scr 10 again -- we need to resume at the screen they left, or explain what happened and what happens next"
- **Log (R5, measured):** 1b rendered 13:50:29. `Key 'N' accepted at: Show-ResumeReverify` 13:51:08 -> `[SCREEN-83] (shown as screen 1c) Rendered: ARE YOU SURE YOU WANT TO CLOSE CHECKUP?` -> `Key 'B' accepted` 13:51:31 -> `Resume re-check: N was not confirmed -- carrying on (FT-171d)` -> re-checks -> `Continue accepted at: Show-ResumeReverify` 13:51:41 -> `[SCREEN-34] (shown as screen 10)`.
- **Source:** 1b's prompt is `"Still YOUR personal computer? (Y = Yes / N = Exit): "` (3964). 1c offers "Press B to go back -- it IS your computer and you want to carry on where you left off" (3982-3983). B is honoured (3995-3997), and then the unconditional screens 10/11 run (FT-265). The "number of keys" before N are not in the log: `Read-ValidKey` prints "That key does nothing here" for them (2809-2815) but **does not log them**.
- **Classification:** B worked as written. Landing on 10 = **DEFECT** (FT-265). Unlogged ignored keys = **DEFECT** (FT-271). N meaning Exit here = **ALREADY KNOWN** (one of the 11 `N = Exit` sites waiting on the X decision).
- **Fix:** FT-265 plus FT-271.

### Note 17 -- "Scr 11 --"
- **Log:** R5 13:55:45 SCREEN-35. No comment given.
- **Classification:** **CANNOT DETERMINE.** **Inferred:** it is the FT-265 replay again.

### Note 18 -- "Power checking settings again, no screen #"
- **Log:** R5 13:55:49 `Password on wake: read produced no setting index`, then `Continue accepted at: Run-PowerSettingsCheck` 13:57:12.
- **Classification:** **DEFECT**, duplicate of note 14 (FT-275).

### Note 19 -- "Scr 19 -- Y this time, and it implies Checkup will change it -- reword. After restart WAKE ON LAN SAID COULD NOT BE READ, perform manually. I hit space bar and then B for back and ended up going FORWARD to Scr 21. Check logs for exact sequence."
- **Exact sequence (R5, measured):**
  ```
  13:57:12 [SCREEN-50] (shown as screen 19) Rendered: POWER SETTINGS -- SECURITY REVIEW
  13:57:59 [KEY] Key 'Y' accepted at: Run-PowerSettingsCheck        <- item [1] Password on wake
  13:57:59 [WARN] Password on wake re-read found no setting index (FT-256)
  13:57:59 [APPLIED] Password on wake: was 'Could not read -- check by hand' -> now 'could not re-read -- check manually'
  13:59:19 [KEY] Continue accepted at: Run-PowerSettingsCheck        <- the space bar
  13:59:19 [STATE] Checkpoint saved: PowerSettings
  13:59:20 [SCREEN-51] (shown as screen 20) Rendered: APPS AUDIT RESULTS
  13:59:45 [KEY] Continue accepted at: Run-AppsAudit                 <- Enter or Space, NOT B
  13:59:45 [STATE] Checkpoint saved: AppsAudit
  13:59:46 [SCREEN-52] (shown as screen 21)
  ```
- **What happened:** the "could not be read" message was about **Password on wake, not Wake on LAN**. WoL read `DISABLED -- GOOD` (13:57:12 INFO line), and the only item offered was [1]. Space left screen 19's result and **screen 20 (Apps Audit) was drawn**. At screen 20, the key accepted 25 seconds later was logged as `Continue accepted`. `Pause-ForUser` writes that line **only** for Enter (13) or Space (32) (2680, 2724). **So the key that moved him to 21 was Enter or Space, not B.** A B at screen 20, had one been pressed, was either swallowed silently (FT-271) or would have logged `Look-back opened`. **Inferred:** a second Space, or a B that was swallowed followed by a Space. Either way Bill never registered screen 20, and the log alone cannot tell the two apart. After FT-271 it will.
- **"Implies Checkup will change it":** screen 19 presents Y as applying a change. After Y, Checkup printed a **green** `"  OK  Password on wake"` over `Now: could not re-read -- check manually` (5474-5476), and logged the line as `[APPLIED]` (5477). A green OK over a result nobody could read is the FT-162 shape.
- **Duplication (measured):** screen 19's three offers change the same things as checklist items 17 (CONSOLELOCK), 18 (HiberbootEnabled) and 19 (WoL). Compare `Apply-PowerSettings` 5446-5536 with `Apply-Setting` cases 17-19, 6999-7073. The user is asked twice about the same settings.
- **Classification:** wrong-subject impression = **WORDING**. Green OK on an unconfirmed result = **DEFECT** (FT-269). Root cause of "could not re-read" = **DEFECT** (FT-268). Forward to 21 = the FT-271 feedback gap (the logged key was Continue). Duplicate offers = **DESIGN DECISION** (Decision 12).
- **Fix:** FT-268 (`/qh`) makes the read and re-read work. FT-269: only print OK when the re-read says REQUIRED; otherwise print "Could not confirm -- check by hand" in yellow and log WARN, not APPLIED.

### Note 20 -- "Scr 21 -- want to go back to check something, can't; will exit and resume"
- **Log (R5):** SCREEN-52 13:59:46, `Key '3'` 14:03:38, `User exited at mode selection`.
- **Source:** `Select-Mode` 9918 accepts only `1`, `2`, `3`. There is no Back. Resume cannot go earlier than the saved checkpoint (`Test-CheckpointReached`, 3882-3892). Once `AppsAudit` is saved, screens 19 and 20 can never be reached again without starting over.
- **Classification:** **DESIGN DECISION NEEDED** (Decision 1). No Back exists here by construction.

### Note 21 -- "Scr 10 then 11 then 21; could not check what I wanted; will exit AGAIN and start over"
- **Log (R6, measured):** resume `AppsAudit` -> 1b -> 10 (14:05:04) -> 11 (14:05:06) -> 21 (14:05:08) -> `3` 14:08:20.
- **Classification:** 10/11 = **DEFECT** (FT-265). Cannot revisit 19/20 = Decision 1. Landing on 21 was the correct checkpoint.

### Note 22 -- "Scr 21 again, selected 2, tried to go back to console select -- could not. Will resume again. Ctrl C ended program"
- **Log (R7, measured):** the log shows **`Key '1' accepted at: Select-Mode` / `Mode selected: Console`** at 14:17:41, not 2. Then SCREEN-53 (22) -> `Y` -> 14:18:33 SCREEN-54 (23 page 1) -> `Nav 'BACK'` 14:18:41 -> `Key 'Y'` 14:18:48 `Password-manager answer revised via Back: True` -> 23 -> `Nav 'NEXT'` -> SCREEN-75 (24) 14:22:30 -> `Nav 'BACK'` 14:22:36 -> 23 -> `Nav 'BACK'` 14:22:39 -> (nothing) -> 14:22:50 `PowerShell.Exiting ... (last-resort cleanup)`.
- **Source:** B on page 23 (`Show-ScopeDisclaimer` 7235-7243) does `Clear-Host` and prints **only** the bare line `"Do you use a password manager? (Y = yes / N = no): "` (7239). There is no box, no screen number and no Back from that line. From 22/23 there is no route back to 21.
- **Classification:** bare re-ask = **DEFECT** (FT-273). No way back to 21 = Decision 1. Ctrl+C with no record = **DEFECT** (FT-270, second occurrence). Mode key: **log says 1**, recorded here so the discrepancy is visible.
- **Fix:** FT-273: B from 23 redraws screen 22 (SCREEN-53) in full, with its number, and 22 gains "B = back to choosing a mode."

### Note 23 -- "Resume asks the same question as before; they cannot be on a different computer; eliminate"
- **Source:** `Show-ResumeReverify` 3955-3964. The design rationale is in FT-47 (3949-3952): "Re-verifying is right; the flash was not." It also relies on Class 5 rule 4 ("resumption re-verifies").
- **Classification:** **DESIGN DECISION NEEDED** (Decision 2).
- **Inferred:** Bill is right that the state file lives on this PC (`$StateFilePath = "$StateDir\gg_state.txt"`, line 1649), so a resume is by construction on the same computer. The ownership answer cannot have changed in a way re-asking would catch. The admin, domain and power re-checks should stay, because they can change. They are already silent unless a problem is found (4001-4021).

### Note 24 -- "Scr 10"
- **Log (R8):** resume `AppsAudit` -> 1b -> SCREEN-34 14:23:34 (on screen **3 minutes**, to 14:26:40) -> 11 -> 21.
- **Classification:** **DEFECT**, FT-265 again.

### Note 25 -- "Scr 21 -- select 2 -- popup (screenshots 24, 25); the msg no longer appears; a lot of added popups, a little confusing; what are the checkboxes on the left for? Need a write-up telling the user what to do with option 2, and what is the advantage of option 2"
- **Log (R8, measured):** `Key '2'` 14:26:46 -> `Get-AllStatuses complete` 14:26:50 -> the form is up until `=== GUI Mode Hardening Run Started ===` 14:40:34 (14 minutes). Then:
  ```
  14:41:01 [ERROR] SILENT ERROR -- fault at: ...:6882 char:17 -- user was at: Apply-Setting -- Requested registry access is not allowed.
  14:41:01 [KEY] Continue accepted at: Apply-Setting          <- a CONSOLE pause during a GUI run
  14:41:01 [INFO] Edge Phishing Protection (all 3) | ... | Result: MANUAL REQUIRED -- registry is protected on this PC (Tamper Protection)
  14:41:43 [MANUAL] Windows Hello (check only) -- Manual action required
  14:41:45 [INFO] Diagnostic Data -- Required Only | Deferred to individual convenience review (FT-94)
  14:42:04 [INFO] Windows Widgets -- Disable | Deferred to individual convenience review (FT-94)
  14:43:14 [APPLIED] Password Required on Wake | ... | Result: ... -- GOOD
  (footer written here)
  14:43:35 [OK] Sleep prevention deactivated ... (called from: unknown (empty call stack))
  14:43:35 [SCREEN-70] (shown as screen 33)
  ```
- **Screenshots 24/25 (measured, by eye):** rows show a checkbox, "N. Name" and a status. Several statuses are **cut off** ("Unknown -- Tamper Protection" with the rest clipped; "Sending extra data -- we will" clipped). **Bad states are coloured green:** "NOT Encrypted -- action", "Not set up -- manual action" and "Enabled -- needs attention" are all green. Source `Run-GUIMode` 9536: `-match "ON|OK|GOOD|..."` is case-insensitive, so "acti**on**" and "attenti**on**" match "ON". Setting 5 (Defender Periodic Scanning) and the Malwarebytes wording in item 2's status are still present (**ALREADY KNOWN**, removal).
- **The popups, counted from source:** per selected item, a Yes/No confirm (9663-9664), then a result box (9668). For a manual item, an info box (9655). Clicking a row opens a details box (9564-9573). At the end, "Run Complete -- Checkup Closing" (9694). `form.Close()` then fires `FormClosing`, which asks **"Are you sure you want to exit? No changes will be saved unless you clicked Run Selected"** (9389-9397), *after* changes were saved. **Inferred:** this last box is confusing by any reading.
- **Item 6 in GUI (measured):** the Tamper-Protection manual steps and `Pause-ForUser` (6889-6901) write to the **console window behind the GUI**. The log shows that pause accepted in the same second, 14:41:01. **Inferred:** the GUI user never saw those steps.
- **Items 12 and 14 in GUI (measured):** `Apply-Setting` defers them ("Saved for your individual review -- you will approve or skip this one next", 6758). **The GUI path never calls `Show-ConvenienceReview`.** Compare 9684-9689 (`Save-Log`, `Set-FirstRunComplete`, `Disable-SleepPrevention`, `Setup-ScheduledTasks`, `Show-ManualSteps`) with console 9331-9334. The promise is never kept.
- **"Advantage of option 2":** screen 21 says only "Recommended for first time users" (8646). This is **ALREADY KNOWN** as Block C1: "GUI mode labelled 'Recommended for first time users' despite never being field run -- Still open."
- **Classification:** **DEFECT** (several, grouped as **FT-280**) + **DESIGN DECISION** (Decision 5, keep GUI or not).

### Note 26 -- "Could not get back to select console 1, will try resume again"
- **Source:** GUI has "Exit" and "RUN SELECTED" and no route back to the mode selector (9608-9632). After Run Selected it hides the form (9687) and continues in the console (screens 33, 34).
- **Log (R8):** screen 33 from 14:43:35 overnight (look-backs at 14:46:48, 14:49:13, then 9/20 16:27:56, 16:28:56). `Continue` 9/20 16:29:05 -> SCREEN-72 (34). **Then nothing.** R9 starts 16:31:51 and **resumes from `AppsAudit`**.
- **Why the end is unrecorded (measured):** `Save-Log` ran at 9684 *before* screens 33 and 34. That set `GGFooterWritten` and `CtrlHandler.FooterDone` (1868-1872), so the later window close and Exiting paths both write nothing (3043, 1860). Why R9 resumed: nothing clears the checkpoint after a finished run (FT-267).
- **Classification:** **DEFECT** (FT-280a mid-run footer, FT-267 checkpoint) + Decision 1/5.

### Note 27 -- "Scr 26-27 -- B & N do nothing. Tamper Protection GOOD; Windows Hello not set up, manual action needed; Edge boost disabled GOOD; Widgets enabled, needs attention (both correct)"
- **Log (R9, measured):** on the checklist (SCREEN-76 = 25, SCREEN-77 = 26): `Checklist: key ignored (N)` 16:39:07, `(N)` 16:39:08, `(B)` 16:39:10, `4+ ignored keys ... burst suppressed (FT-193)` 16:39:11. On page 2: `(M)`, `(M)`, `(B)`, burst 17:00:12-14. There is also a stray `key ignored (')` at 16:38:57.
- **Source:** the checklist reader accepts `R A C Q P I` and digits only (8902-8945). There is no B. The legend lists no B (8843-8846). "That key does nothing here" is printed (8954), so it is not silent.
- **Statuses:** **WORKS AS DESIGNED.** This is the first SANDY field confirmation of the FT-123b fallbacks for items 13 (Edge) and 14 (Widgets). Bill confirms both are correct.
- **Note on numbering:** Bill says "26-27". The checklist is 25-26 by the table (1965-1966). **Inferred:** he meant the checklist pages.
- **Classification:** B/N on the checklist = **DESIGN DECISION** (Decision 1: B should lead back to screen 24). N correctly does nothing under the keys rule.

### Note 28 -- "Selected Encryption and R to run. #6 phishing -- change wording 'You selected this item, so Checkup is applying it now. Applying.' Everywhere we give a guide section title, put in page numbers when we publish. #9 instructions have no line feed, run off the screen. #12 which is it -- Checkup is applying it, or on the next screen? #14 same as 12. #17 what are we doing here -- 'Password required on wake -- enabled for both AC and battery -- GOOD' = intervention -- use consistent wording for all settings"
- **Log (R9, measured):** `'8'` 16:48:21 (6 selected), `'R'` 17:23:06, SCREEN-55 (27), `Y` 17:23:35. Item 6: `SILENT ERROR ... 6882 ... Requested registry access is not allowed` then `MANUAL REQUIRED -- registry is protected`. Item 9 `NOT CONFIGURED -- Manual setup: ...`. 12 and 14 `Deferred to individual convenience review (FT-94)`. 17 `[APPLIED] ... Result: Password required on wake -- enabled for both AC and battery -- GOOD`.
- **Source:**
  - Run loop 9268-9275 prints `"  You selected this item, so Checkup is applying it now."` / `"  Applying..."` for **every** CanAuto item, **before** `Apply-Setting` returns. For 12 and 14 it then returns "Saved for your individual review -- you will approve or skip this one next" (6756-6758). Both statements appear on screen together, one under the other. That is Bill's "which is it."
  - Item 6: the status was already `Unknown -- Tamper Protection blocks this check` (R9 16:35:15). Checkup knew before trying that the write would be refused on this PC, and still said "applying it now."
  - Item 9: `Write-Host "  INSTRUCTIONS: $r"` (9246) prints a string of about 170 characters as one line. The console wraps it mid-word. Nothing breaks the line on purpose.
  - Item 17: case 17 (6999-7005) runs three `powercfg` writes and returns "-- GOOD" **without re-reading anything.** The same FT-162 shape as note 19.
  - Guide references are `"See Guide: Phase 1, Step 4"`-style throughout (for example 6925, 7508).
- **Classification:** "applying it now" before a deferral or a known block = **DEFECT/WORDING** (FT-279). #9 line = **DEFECT** (FT-279). #17 unverified GOOD = **DEFECT** (FT-269). Consistent result wording = **WORDING** (FT-279). Page numbers = **DESIGN DECISION** (Decision 8).
- **Fix:** FT-279: print "applying" only for items actually being written now. For 11-15, print "Saved for the end -- you will be asked about this one." For a Tamper-Protection-blocked item, go straight to "Windows does not allow any program to change this one, so Checkup shows you the exact steps" (the CLAUDE.md permission wording). Wrap manual instructions to the window width. Use one result format for every item: `Was: <read>  ->  Now: <re-read>`, as `Apply-PowerSettings` already does (FT-128), with GOOD only when the re-read confirms it.

### Note 29 -- "Device Encryption -- 'Currently temporarily disabled, will resume automatically next time restart'"
- **Measured:** that sentence does not come from Checkup. The build has no string containing "resume automatically" or "temporarily disabled" (grep `temporarily|resume automatically` finds only unrelated Malwarebytes/Memory-Integrity text at 4683, 4689, 6991). R9 logged `Device Encryption state: Not encrypted (0%), account type: Local -- raw: FullyDecrypted` at 18:15:41.
- **Inferred:** Bill read this in Windows Settings -> Device encryption, between screens 30b and 31 (18:16:04-18:20:48). Windows uses wording like this for *suspended* protection, which does not obviously fit `FullyDecrypted`.
- **Classification:** **CANNOT DETERMINE.** Needs a screenshot of the Windows page plus a read-only `manage-bde -status C:` / `Get-BitLockerVolume` capture from SANDY, as a `.ps1` + `.bat`, written to a file.
- **Why it matters:** if Windows says encryption is paused while Checkup reads "not encrypted," the screen-28 path may be giving the wrong instructions. This links to Block D4 (local-account encryption condition, "needs SANDY, no record found").

### Note 30 -- "Scr 33a -- why are we doing this here? Do it earlier; they selected it, don't make them decide again. Change the previous screens; the next step should show all Checkup changed, and the next screen walk them through the ones needing manual changes. Actual setting was already off -- do we need a new way to check for this?"
- **Log (R9, measured):** SCREEN-23 (33a) 18:33:29 -> SCREEN-71 (33b) `[1 of 2]: Diagnostic Data` 18:33:42 -> `Key 'N'` **18:41:58** (8 minutes 16 s) `User skipped convenience change: Diagnostic Data` -> `[2 of 2]: Windows Widgets` -> `Y` 18:52:17.
- **Source:** FT-94 (6751-6759, 7341-7343) deliberately defers 11-15 to an end-of-run ask. FT-219 (9261-9267, Bill 2026-08-21) says "selecting an item on the checklist IS your approval." **These two rules contradict each other for items 11-15**, and Bill is now asking for FT-219 to win.
- **"Already off":** **inferred** to be Diagnostic Data (the 8-minute pause, then N). Item 12's check (6378) reads **only** the Group Policy value `HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection\AllowTelemetry`. When it is absent it reports `"Sending extra data -- we will limit it"`, a verdict from absence (the FT-123 shape). **Measured on CGDELL 2026-09-24 (read-only):** the policy key exists with no `AllowTelemetry`, while `HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection` holds `AllowTelemetry = 3`, `MaxTelemetryAllowed = 3`. **Inferred, not flip-proven:** the second location is where the Settings toggle writes, and it is the candidate effective-state source, the same way FT-123b found `TaskbarDa` and `Local State`.
- **Classification:** re-ask = **DESIGN DECISION** (Decision 4). Item 12 verdict from absence = **DEFECT** (FT-282). A "what Checkup changed" summary screen = part of Decision 4.
- **Fix:** FT-282: a flip test on SANDY (read, toggle "Send optional diagnostic data" in Settings, read again). Then add the effective-state fallback in the FT-123b shape. Never report "sending extra data" from an absent policy value.

### Note 31 -- "33b -- selected Yes and error msg 'Done: ERROR: Attempted to perform an unauthorized operation.'"
- **Log (R9, measured):**
  ```
  18:52:17 [ERROR] Windows Widgets -- Disable | Before: Enabled -- needs attention | Result: ERROR: Attempted to perform an unauthorized operation.
  18:52:17 [OK] User approved convenience change: Windows Widgets -- ERROR: Attempted to perform an unauthorized operation.
  18:52:17 [ERROR] SILENT ERROR -- fault at: ...ps1:6964 char:17 -- user was at: Show-ConvenienceReview -- Attempted to perform an unauthorized operation.
  ```
- **The exact call that failed (measured):** line 6964, `Set-ItemProperty -Path $rp -Name AllowNewsAndInterests -Value 0 -Type DWord -Force -EA Stop` with `$rp = "HKLM:\SOFTWARE\Policies\Microsoft\Dsh"` (6962). `Apply-Setting` case 14. The call is `Set-ItemProperty`, not the `New-Item` on 6963: had `New-Item` failed to create the key, the error at 6964 would have been "Cannot find path." **Inferred:** so the Dsh key existed (or was created), and **writing the value** was refused. "Attempted to perform an unauthorized operation" is the text of .NET's `UnauthorizedAccessException`, which means an access-control refusal.
- **Why (CANNOT DETERMINE from here):** the process was elevated (`Administrator access confirmed` / `Resume re-check: administrator access confirmed` in R9). **Measured on CGDELL:** the Dsh key does not exist there, and `BUILTIN\Administrators` has FullControl on `HKLM:\SOFTWARE\Policies\Microsoft`. So the refusal is specific to SANDY's Dsh key or to something Windows protects on SANDY. **Guess:** SANDY's Dsh key has an ACL or owner that denies Administrators write. **Needs a read-only probe on SANDY:** `Test-Path`, `Get-Acl` (owner + access list) and `Get-ItemProperty` on `HKLM:\SOFTWARE\Policies\Microsoft\Dsh`, written to a file.
- **Also measured:** FT-123b's item-14 *status* reads the user value `HKCU:\...\Explorer\Advanced\TaskbarDa`, while the *apply* writes the HKLM policy. So even a successful write would leave the check reading a different place than the change was made. **Inferred:** a GOOD after the write would come from the policy branch, which is consistent. Noting it so it is checked, not assumed.
- **The display defect (measured):** `Show-ConvenienceReview` 7398-7399 prints `"  Done: $ggConvResult"` in **green** and logs **`[OK] User approved convenience change`** whatever the result, including `ERROR:`. The user was told "Done" in green over an error.
- **Classification:** write refused = **DEFECT, cause undetermined** (FT-283). Green "Done" / [OK] over an error = **DEFECT** (FT-284).
- **Fix:** FT-284: colour and word the result from its content ("Could not change this -- Windows refused. Nothing was changed." in yellow), and log ERROR. The same rule is already written for the console run at 9272. FT-283: run the probe first, then decide (possibly fall back to `TaskbarDa`, with the FT-123b flip evidence as the VERIFIED basis).

### Note 32 -- "Scr 34 -- change MB or eliminate MB write-up. Need to tell them how to do 2FA or provide a guide page"
- **Source:** `Show-ManualSteps` 7514-7533 (Malwarebytes block) and 7538-7539 (`"  [ ] 2FA -- Enable on all important accounts."` / `"      Authenticator app preferred. Guide: Phase 5"`). Also measured: the same screen says `"[ ] Scheduled Scans -- AUTOMATED: Checkup set up Quarterly Defender Offline Scan"` and `"Your scheduled scans (above) will still run automatically later"` (7541-7553). **That is false.** The quarterly task is a reminder popup, by FT-175's own comment (7675: "So the quarterly task is a REMINDER"). Screen 33 says the same false thing: `"Scheduled: 1st of Jan / Apr / Jul / Oct 2AM"` under "Runs BEFORE Windows loads" (7642-7644).
- **Also measured:** SANDY now carries the **`GatewayGuard - Monthly Malwarebytes Reminder`** task, created twice (R8 14:43:40, R9 18:33:14). The planned one-time removal of that task must include SANDY.
- **Classification:** Malwarebytes = **ALREADY KNOWN**. 2FA = **DESIGN DECISION** (Decision 7). "Scans run automatically" = **WORDING/DEFECT** (FT-278).

---

## PART 3 -- SUMMARY TABLE

| # | Screen | Class | One-line fix |
|---|---|---|---|
| 1 | 2 | CANNOT DETERMINE | Ask Bill what the problem was. Intro screens 1-3 unlogged -> FT-274 |
| 2 | 3/4 | DEFECT FT-274 | Remove the number from the FONT CHECK sample box. Put "Screen 3" in the header |
| 3 | 8 | DEFECT FT-270 (reopens FT-150) + WORDING | Reproduce Ctrl+C exit and instrument it. Measure the Mark accelerator letter, then correct the tip in 4 places |
| 4 | 10 (and 11) | WORDING FT-278 | Home encryption is manual. Drop "handled automatically" and "option 2 (Enable overnight)" |
| 5 | 12 | WORKS | Two drives in the right order. Closes the SANDY look |
| 6 | 13 | ALREADY KNOWN (MB removal) + WORDING | Rewrite without MB. Print the real log folder path |
| 7 | 14 | ALREADY KNOWN + DECISION 6 | Rewrite the scan plan: offline, then what? |
| 8 | 14a/16 | DEFECT FT-276 | "Save and close everything first" on 16. Show prep steps on repeat runs |
| 9 | 1b->10 | DEFECT FT-265 | Resume skips 10/11 and says where it is resuming |
| 10 | 14b | WORKS (look-back) / DEFECT FT-277 | Verify the Protection History URI. Read Defender's log instead of asserting "finished" |
| 11 | 17 | ALREADY KNOWN (MB removal) | Neutral AV status wording |
| 12 | -- | ALREADY KNOWN (FT-250/252, not built) + FT-265 | Scope decision. Show the build on 1a/1b |
| 13 | 18/18c | ALREADY KNOWN (MB removal, length baseline) | Deleted with MB |
| 14 | 10/11, power pre-page | DEFECT FT-265, FT-275, FT-266 | Skip replay. Number or drop the pre-page. Fix checkpoint order |
| 15 | 19 | DEFECT FT-271, FT-281 + DECISION 10 | Say when B is unavailable and log it. Log per-adapter WoL |
| 16 | 1b/1c->10 | DEFECT FT-265, FT-271 | As 9. Log ignored keys |
| 17 | 11 | CANNOT DETERMINE (FT-265 likely) | -- |
| 18 | power pre-page | DEFECT FT-275 | As 14 |
| 19 | 19->20->21 | DEFECT FT-268, FT-269, FT-271 + DECISION 12 | `/qh`. No green OK without confirmation. The key logged at 20 was Continue |
| 20 | 21 | DECISION 1 | Real Back to earlier sections |
| 21 | 10/11/21 | DEFECT FT-265 + DECISION 1 | -- |
| 22 | 21/22/23 | DEFECT FT-273, FT-270 | B from 23 redraws 22 in full. Log says mode 1, not 2 |
| 23 | 1b | DECISION 2 | Drop the ownership Y/N on resume. Keep silent re-checks |
| 24 | 10 | DEFECT FT-265 | -- |
| 25 | 21 -> GUI | DEFECT FT-280 + DECISION 5 (C1) | Fix the GUI defects or remove GUI mode |
| 26 | GUI/34 | DEFECT FT-280a, FT-267 | Footer only at true end. Clear the checkpoint at run end |
| 27 | 25/26 | WORKS (statuses) + DECISION 1 | B on the checklist -> screen 24 |
| 28 | run loop | DEFECT FT-279, FT-269 + DECISION 8 | Honest per-item wording, wrapped text, one Was/Now format |
| 29 | Windows Settings | CANNOT DETERMINE | SANDY probe + screenshot |
| 30 | 33a/33b | DECISION 4 + DEFECT FT-282 | Selection = approval. Item 12 effective-state read |
| 31 | 33b | DEFECT FT-283, FT-284 | Probe the Dsh ACL. Never print a green "Done" over ERROR |
| 32 | 34 (and 33) | ALREADY KNOWN + WORDING FT-278 + DECISION 7 | Remove MB. 2FA guidance. Scans are reminders, not automatic |

---

## PART 4 -- CROSS-CUTTING THEMES

### A. Resume returns to the wrong place, or the right place by the wrong route
Five separate mechanisms, all measured:
1. **Screens 10/11 always replay** (lines 9812, 9815). Notes 9, 14, 16, 17, 21, 24. **FT-265.**
2. **Checkpoint order does not match flow order.** `$global:CheckpointOrder` (3811-3821) lists `"Malwarebytes"` **before** `"DefenderAV"`, while the flow saves `DefenderAV` (9888) **then** `Malwarebytes` (9894). So a resume from `DefenderAV` treats Malwarebytes as done and skips screen 18. Measured: R4 and R5 have no SCREEN-73 and no `Checkpoint saved: Malwarebytes`. A resume from `Malwarebytes` would re-run screen 17. Also, **`OfflineScanDone` is in the order list but is never saved anywhere.** Measured: the only `Save-Checkpoint` calls are 4542, 7484, 9825, 9869, 9888, 9894, 9904, 9910. **FT-266.** (Mostly moot after the MB removal, but the removal build must rebuild this list, not delete one entry from it.)
3. **The checkpoint is never cleared when a run completes.** `Clear-Checkpoint` has exactly one caller, "start over" (3937). R9 was offered and took a resume from `AppsAudit` after R8 had finished. Every later launch on SANDY will open with "partway through -- possibly right before a restart for a Defender Offline Scan" (3911-3912) forever. **FT-267.**
4. **Checkpoints are coarse.** The last one is `AppsAudit`. Anything after screen 21 (22, 23, the checklist, the run) resumes to 21. Decision 3.
5. **1a's wording assumes an offline-scan reboot** for every checkpoint. Folded into FT-265.

### B. Screens without numbers
Measured unnumbered pages the user stops at (each has a `Pause-ForUser` and no `Draw-Box`):
- the power pre-check page, `Run-PowerSettingsCheck` 5171-5300 (notes 14, 18)
- the AC-power status page, `Test-PowerStatus` 5110-5121 (R7 14:10:19)
- the resume tip page after 1a, `Show-ResumePrompt` 3925-3934
- the "Did you find any items needing action?" page after 14b, 4592-4605
- the bare password re-ask after B on 23, 7237-7239 (note 22)
- every per-item page in the console run, 9181-9275 (note 28)

Plus the double number on screen 3/4 (note 2). **FT-275** (the list) and **FT-274** (screen 3/4). Gate 12 cannot see these because it counts `Draw-Box` calls. **Inferred:** the checker should also flag a `Pause-ForUser` with no `Draw-Box` since the previous `Clear-Host`.

### C. Malwarebytes is still throughout the tool's copy
**ALREADY KNOWN**: decided 2026-09-08, ascii44 predates it. Measured scale: 136 lines of the build contain "Malwarebytes". 87 of them have it inside a double-quoted string (a proxy for "user-facing or logged text"; it includes log messages and paths). Screens Bill hit in this run: 7 (pre-flight list item 7), 13, 14, 14a, 14b, 17, 18, 18c, 33, 34, plus the GUI item-2 status. The scheduled task `GatewayGuard - Monthly Malwarebytes Reminder` was **created on SANDY on both 9/19 and 9/20** (R8, R9). The one-time task removal must cover it. CLAUDE.md's warning stands: this is generalisation (a generic real-time-AV read for items 2 and 7), not deletion.

### D. Back
Three readers, three behaviours, measured:
- `Pause-ForUser` (78 sites per CLAUDE.md): B = view-only look-back, *only if offered*. Otherwise it is **silently swallowed** (2720).
- `Read-ValidKey` (60 sites): B works only where the call lists it. Other keys print "That key does nothing here" but are **not logged** (2805-2816).
- `Read-NavKey` (7 sites): B = real one-screen back (intro, scope pages).
- The checklist reader: no B at all (8902-8945). It does print and log ignored keys (8953-8963).

Bill's notes 10, 15, 19, 20, 21, 22, 26, 27 all expect B to mean **"take me back to the previous step so I can change it."** Only `Read-NavKey` and the three hand-built Back sites do that. **FT-271** (feedback and logging) is a defect. **Real Back** is Decision 1.

### E. Offline scan gives no feedback
Nothing warns to save work on repeat runs (FT-276). The reboot comes 5 s after Y. After return, 14b asserts "has finished" without reading anything, and the Protection History link opened a different page (FT-277). Bill could not tell whether the scan ran (note 10: last scan 9/14).

### F. Screens too long
18 (SCREEN-73), 19 (SCREEN-50), 13, 14 (26, 27) and 34 (72) are all on the gate-12b baseline. **ALREADY KNOWN.** The field cost this time was two accidental X-clicks while scrolling (R3 13:03:56 and, inferred, R4 13:27:24) and a look-back that showed "nothing" (note 13). These tie directly to **FT-259** (window height never measured). SANDY's console also opened at **60 columns**: every resume log shows `Write-GGBox: a line was truncated to fit the window (60 cols)` on 1a, 1b, 10 and 11 (for example R4 13:08:46-13:09:04). So the first resume screens lose text to truncation before the user has been told to maximize. FT-217 truncates and logs by design; FT-259's one-key fix is the remedy Bill already chose.

### G. The elevation error at 33b -- what exactly failed
`Apply-Setting` case 14, **line 6964**: `Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name AllowNewsAndInterests -Value 0 -Type DWord -Force -EA Stop`. It threw `UnauthorizedAccessException` ("Attempted to perform an unauthorized operation") in an elevated session. The log's own breadcrumb names it: `fault at: ...ps1:6964 char:17`. The cause is not determinable from the log or from CGDELL (FT-283). The fact that it was shown as a green "Done" and logged `[OK]` is a separate, certain defect (FT-284).

### H. Verdicts and "OK" from reads that did not happen (the FT-162 family, again)
- Screen 19: green "OK Password on wake / Now: could not re-read", logged APPLIED (5474-5477). FT-269.
- Item 17: "-- GOOD" with no re-read (7004). FT-269.
- 14b: "Your Defender Offline Scan has finished" with no read (4573). FT-277.
- Item 12: "Sending extra data" from an absent policy value (6378). FT-282.
- Convenience review: green "Done" over ERROR, logged OK (7398-7399). FT-284.

### I. Log noise on a clean run
Every checklist launch logs `[ERROR] SILENT ERROR -- ... Property EnableSmartScreen does not exist at path HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System` (R7 14:17:44, R8 14:41:01, R9 16:35:24). **Measured:** that is `Get-GGPolicyLock` (3632) reading an expected-absent value. The FT-188 benign filter (3240-3241) matches "does not exist" only in the form "because it does not exist", and "Property X does not exist at path" does not match. Item 6's handled, expected Tamper-Protection refusal also logs `[ERROR] SILENT ERROR ... Requested registry access is not allowed` (6882) although FT-141 handles it. That is the file customers are told to email to support. **FT-285.**

---

## PART 5 -- NEW FT NUMBERS (starting at FT-265)

| FT | Title | Notes | Basis |
|---|---|---|---|
| **FT-265** | Resume always replays screens 10 and 11. 1a/1b never say where the resume will land, and never show the build | 9, 12, 14, 16, 17, 21, 24 | measured, 9812/9815 + every resume log |
| **FT-266** | `CheckpointOrder` has Malwarebytes before DefenderAV (flow is the reverse), so screen 18 is skipped on resume. `OfflineScanDone` is never saved | 14 | measured, 3811-3821, 9888/9894; R4/R5 logs |
| **FT-267** | The checkpoint is never cleared after a completed run, so every later launch offers a stale resume | 26 | measured, only caller 3937; R9 resumed after R8 finished |
| **FT-268** | Password-on-wake read uses `powercfg /query`, which omits the hidden CONSOLELOCK setting, so it is always NO_INDEX. `/qh` returns it. Root cause under FT-256 | 19, 28 | **measured on CGDELL 2026-09-24**; 5150, 5454 |
| **FT-269** | Unconfirmed password-on-wake result shown as green OK / logged APPLIED (screen 19). Item 17 returns "GOOD" with no re-read | 19, 28 | measured, 5474-5477, 7004 |
| **FT-270** | Ctrl+C still ends the session with no confirmation and no exit reason (**reopens FT-150**). Also the Mark-mode copy letter needs measuring | 3, 22 | measured, R1 12:01:32, R7 14:22:50; mechanism inferred |
| **FT-271** | `Pause-ForUser` silently swallows B when look-back is not offered. Neither it nor `Read-ValidKey` logs ignored keys, so "B did not work" cannot be checked from the log | 15, 16, 19 | measured, 2720, 2805-2816 |
| **FT-272** | *(reserved for Decision 1)* Real Back navigation: section-level back on 19, 20, 21, 22, 23, checklist, GUI | 10, 15, 20, 21, 22, 26, 27 | design |
| **FT-273** | B from screen 23 drops to a bare password prompt with no box, no number and no further Back | 22 | measured, 7237-7239 |
| **FT-274** | Screen 3 shows two numbers ("Screen 3" in gray, "[ Screen 4 ]" on the sample box). Screen 4 has no page. Intro screens 1-3 never logged by ID | 1, 2 | measured, 3379-3407; R1 log |
| **FT-275** | Six user-facing pauses with no screen number | 14, 18, 22, 28 | measured, list in Part 4B |
| **FT-276** | Offline scan: no "save your work" warning on screen 16, and the prep checklist is first-run only. The reboot comes 5 s after Y | 8 | measured, 4415/4475, 4518-4549 |
| **FT-277** | 14b claims "scan has finished" without reading anything. The `windowsdefender://protectionhistory` URI is unverified and opened Device Security on SANDY | 10 | measured (source); URI behaviour per Bill |
| **FT-278** | Screen copy that states behaviour the build does not have: 10 ("handled automatically"), 11 ("option 2 Enable overnight" on Home), 21 ("asks Y/N before any change", false since FT-219), 33 and 34 ("scheduled/automatic" offline scan, which is a reminder) | 4, 32 | measured, 3738, 3769, 8641, 7642-7644, 7541-7553 |
| **FT-279** | Console run loop: "applying it now" printed before deferred (11-15) and Tamper-blocked (6) items. Item 9 instructions unwrapped. Inconsistent result wording | 28 | measured, 9246, 9268-9275, 6756-6758 |
| **FT-280** | GUI mode: (a) `Save-Log` mid-run (9684), so the session end goes unrecorded; (b) convenience review never runs, so 12/14 are promised a review that never comes; (c) item 6 manual steps + pause go to the hidden console; (d) bad statuses coloured green ("acti**on**", "attenti**on**" match "ON", 9536); (e) statuses clipped; (f) a "No changes will be saved" exit confirm after changes were saved (9389-9397); (g) no way back to the mode selector | 25, 26 | measured, source + R8 log + screenshots 24/25 |
| **FT-281** | Wake-on-LAN check logs and shows no per-adapter detail (3 adapters on SANDY) | 15 | measured, 5214-5241 |
| **FT-282** | Item 12 (Diagnostic Data) status is a verdict from an absent policy value. Needs an effective-state read (FT-123 family) | 30 | measured, 6378; CGDELL read 2026-09-24 |
| **FT-283** | Widgets write `HKLM\...\Policies\Microsoft\Dsh\AllowNewsAndInterests` refused with UnauthorizedAccess on SANDY, elevated. Cause undetermined | 31 | measured, R9 18:52:17, line 6964 |
| **FT-284** | Convenience review prints green "Done:" and logs `[OK]` over an ERROR result | 31 | measured, 7398-7399 |
| **FT-285** | Log noise: expected-absent `EnableSmartScreen` property and the handled Tamper-Protection refusal both log as `[ERROR] SILENT ERROR` | (logs) | measured, 3240-3241; R7/R8/R9 |

**Reopened:** FT-150 (under FT-270). **Confirmed working in the field for the first time on SANDY:** FT-123b items 13 and 14 (note 27), screen 12 drive order (note 5), FT-171d exit confirm on 1b/1c (note 16), FT-193 burst suppression on the checklist (R9 16:39:11, 17:00:14), FT-203 task read-back (`Reminder settings confirmed by read-back` R8/R9).

---

## PART 6 -- DECISIONS BILL MUST MAKE

1. **What B means.** Today B on a page shows a picture of the previous screen and changes nothing. You and the notes expect B to take you back to the previous *step* so you can change it (screens 19, 20, 21, 22/23, the checklist, GUI).
   **Recommendation:** make **B = go back one step** everywhere a step can be redone. That means real navigation at 19 (re-ask), 21 (from 22), 22 (from 23), the checklist (to 24) and 20 (to 19). Move the picture view to its own key, **`L = look at the previous screen`**. CLAUDE.md FT-259 measured `L` free in every key comparison. The rule "one key, one meaning" then holds. Where a step cannot be redone (after a change is written, after a reboot), say so in words instead of offering B.
2. **Drop the "Still YOUR personal computer?" question on resume (note 23)?**
   **Recommendation: yes.** Store the Machine ID in the state file (it already holds `PM=` and `OD=` lines). On resume, if the ID matches, skip the question and keep the silent admin/domain/power re-checks. If it does not match, ask. This also removes one of the 11 `N = Exit` sites.
3. **How exactly resume should land (note 16).**
   **Recommendation:** keep checkpoint-level resume, but (a) stop replaying 10/11 (FT-265), (b) add checkpoints at screen 21 (mode chosen), 23/24 (scope read) and the checklist (selections saved), and (c) have 1b state "You stopped at screen X. Checkup will continue at screen Y." A photo-exact resume to any screen is not worth the complexity. **Inferred:** mid-screen state (for example a half-answered 19) is not worth persisting.
4. **Convenience items 11-15 (note 30).** FT-94 defers them to 33a/33b. FT-219 (your 2026-08-21 rule) says selecting is approval. They conflict.
   **Recommendation:** FT-219 wins. Apply 11-15 in the main run like every other selected item, and delete 33a/33b. Replace them with a **"What Checkup changed"** summary screen (Was -> Now for each item), then a **"Steps for you to do"** walkthrough, one manual item per screen, as you describe.
5. **GUI mode (Block C1, note 25).** It has seven measured defects (FT-280), was never field run before today, and its only claimed advantage ("recommended for first time users") is unsupported.
   **Recommendation:** **remove option 2 for launch.** Keep the code out of reach, or delete it, so the screen reads "1 = Start, 2 = Exit". Revisit after launch only if a customer asks. Fixing all seven parts costs more than it returns before 2026-10-15.
6. **The scan plan once Malwarebytes is gone (notes 7, 12).** You wrote "Defender Offline, then full scan," and "Tamper first, then Windows Update until finished" (FT-250/FT-252, not built).
   **Recommendation:** order = Tamper Protection check -> Windows Update check-and-instruct -> offline scan offer (with the FT-276 save warning) -> offer a Defender **Full scan** started by Checkup in the background, with plain progress wording. That needs a measured `Start-MpScan -ScanType FullScan` VERIFIED comment (gate 24) before it ships. Confirm this set is ascii45 scope.
7. **2FA on screen 34 (note 32).**
   **Recommendation:** one short on-screen line ("Turn on two-step sign-in for email and banking first -- the guide shows how, page N") plus a guide/website page. Step-by-step 2FA for every provider does not fit a console screen and goes stale.
8. **Guide references (note 28).** "Guide: Phase 1, Step 4" appears across the tool.
   **Recommendation:** when the guide is final (before 2026-10-15), replace every "Phase X, Step Y" with the guide's **section title + page number**, in one pass, from one table in the build. Until then leave them, so the text is not edited twice.
9. **Offline-scan prep on repeat runs (note 8).**
   **Recommendation:** always show the "save and close your work" step before the offline-scan question, first run or not (FT-276).
10. **Wake-on-LAN reporting per adapter (note 15).**
    **Recommendation:** always *log* each adapter and each wake property read (FT-281). On screen, list adapters only when one is ON or unreadable. A GOOD result stays one line.
11. **Item 12 (Diagnostic Data) effective state (note 30).**
    **Recommendation:** approve a SANDY flip test (read-only script before and after you toggle "Send optional diagnostic data" in Settings), then build the fallback. Same method that closed FT-123b.
12. **Screen 19 duplicates checklist items 17/18/19 (note 19).** The same three changes are offered on screen 19 and again on the checklist.
    **Recommendation:** make screen 19 **report-only** (what was found, and why it matters), and let the checklist be the single place those three are changed. That removes the "implies Checkup will change it" confusion and one apply path (FT-242 found the second path was where an unguarded write hid).

---

## PART 7 -- WHAT NEEDS A SANDY MEASUREMENT BEFORE IT CAN BE FIXED

Each as a read-only `.ps1` + `.bat`, output to a file:
1. **FT-283:** `Test-Path`, `Get-Acl` (owner and access) and `Get-ItemProperty` on `HKLM:\SOFTWARE\Policies\Microsoft\Dsh`.
2. **Note 29:** `manage-bde -status C:` and `Get-BitLockerVolume -MountPoint C:`, plus Bill's screenshot of Settings -> Device encryption.
3. **FT-270:** Ctrl+C reproduction: at a Read-ValidKey prompt, with and without first using Mark mode. Log the handler's `LastEvent`. Also read which letter is underlined for "Mark" in Alt+Space -> Edit.
4. **FT-277:** launch `windowsdefender://protectionhistory` on CGDELL and SANDY and record which page opens. Read the Defender Operational log (bounded) for the 2026-09-19 12:21-12:35 window to see if the offline scan recorded anything.
5. **FT-268:** `powercfg /qh SCHEME_CURRENT SUB_NONE CONSOLELOCK` on SANDY, to confirm the index appears there as it does on CGDELL.
6. **FT-282:** the Diagnostic Data flip test (Decision 11).

---

## APPENDIX -- HOW TO REPRODUCE THE KEY CLAIMS

- Resume replays 10/11: any resume log. Search for `resume from checkpoint`, then the next two `[SCREEN-` lines. Source lines 9812, 9815.
- Checkpoint order: source 3811-3821 vs 9886-9895.
- Checkpoint never cleared: grep `Clear-Checkpoint` in the build. One definition (3878), one call (3937).
- `/query` vs `/qh`: `powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK` and `powercfg /qh SCHEME_CURRENT SUB_NONE CONSOLELOCK`, read-only, no admin.
- Note 19 forward-to-21: R5 log lines 58-65. `Continue accepted` is written only for VK 13/32 (source 2680, 2724).
- 33b failure: R9 log lines 142-145. Source line 6962-6964.
- GUI mid-run footer: R8 log lines 59-66. Source line 9684.
- GUI green-on-bad: source 9536. Screenshots 24/25, rows 8, 9, 14.
