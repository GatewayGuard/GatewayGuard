<!-- Dated: 2026-09-25 16:38 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii45 -- the build plan

- **Document Name:** GatewayGuard_ascii45BuildPlan
- **Base:** `Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1`.
  ***Measured 2026-09-25: 9,582 non-blank lines / 9,973 total, 89 functions.***
- **Sources:**
  - `GatewayGuard_FieldTestTriage-ascii44run1-2026-09-24-2353.md` (FT-265 to FT-285, twelve decisions, Part 7)
  - `GatewayGuard_CloudReview-ascii44Triage-GuidePart3-Part4-2026-09-25-1308.md` (Part A)
  - `GatewayGuard_ascii44Scope-WhatsInWhatsNext-2026-09-17-1441.md` (what ascii44 did not ship)
  - `GatewayGuard_ascii44BuildPlan-2026-09-05-1130.md` (Block B text and "NOT IN ascii44")
  - Session log 2026-09-25 14:50 (Bill's scope) and `CLAUDE.md`
- **Status:** PLAN. Nothing built. Blocks A to D need no decision from Bill
  and nothing from SANDY -- they can start today.

---

## BILL'S SCOPE, 2026-09-25, IN HIS WORDS

- *"We will make the launch date."* -- **2026-10-15 holds.**
- *"Include the future loop and other items in ascii45 as well."* --
  **everything ships in ascii45**, including Windows Update apply-and-loop and
  Checkup starting the full Defender scan, which Cloud had moved to after
  launch.
- *"Use X."* -- **`X` = Exit.** `N` = No only, `B` = Back only.
- *"Remove AV names."* -- **Microsoft Defender is the only product named**,
  on any screen.

**The honest risk, stated once.** This is the largest build this project has
attempted. Cloud's warning (A-13) is on the record: ascii45 needs its own
SANDY field run and a triage before 10-15. **The schedule at the end of this
plan is what makes that possible, and it has no slack.** If a block runs
long, the order below says what is cut last.

**Next free FT number: 286.** Next free screen ID: re-measure with
`Tool2\Run-ScreenCoverageCheck.bat` before the first new screen (the last
recorded value, 90, is from ascii43).

---

## THE ORDERING PRINCIPLE -- same as ascii44

**By cost of being wrong, not by effort.** A screen that says GOOD about
something Checkup never confirmed reaches a customer's decisions. A key that
does the wrong thing reaches their patience. **Wrong verdicts first, then
removals (they shrink everything after them), then navigation, then the new
start sequence, then wording.**

---
---

# BLOCK A -- WRONG VERDICTS AND FALSE SUCCESS (highest cost; nothing blocked)

| # | FT | Fix | Source |
|---|---|---|---|
| A1 | **FT-268** | Password-on-wake: read with `powercfg /qh`, not `/query`, at both sites (5150, 5454). `Get-GGConsoleLockState` keeps its four states. ***Measured CGDELL 09-24 and 09-25: `/qh` returns AC/DC 0x1; `/query` returns nothing.*** VERIFIED comment for gate 24. **SANDY confirmation is Part 7 step 5** -- build it now, the SANDY read confirms it | triage Part 5 |
| A2 | **FT-269** | Screen 19 and item 17 print GOOD / APPLIED only after a re-read confirms the value. Unconfirmed = yellow "could not confirm" | 5474-5477, 7004 |
| A3 | **FT-284** | Convenience review prints green "Done" over an ERROR result. Colour and wording follow the result | 7398-7399 |
| A4 | **FT-278** | Five screens promise behaviour the build lacks (10 "handled automatically", 11 "option 2 overnight" on Home, 21 "asks Y/N before any change", 33/34 "scheduled/automatic" offline scan). Rewrite each to what the build does | 3738, 3769, 8641, 7541-7553, 7642-7644 |
| A5 | **FT-279** | "Applying it now" printed before items that are then deferred or blocked. Print the real outcome per item | 9246, 9268-9275, 6756-6758 |
| A6 | **FT-254** | `Test-TimeDateSync` prints success after four unguarded calls | ascii44 carry-over |
| A7 | **FT-285** | Two expected conditions log as `[ERROR] SILENT ERROR`. Log them as INFO so a real error stands out | 3240-3241 |

---

# BLOCK B -- REMOVALS (do these before C; they shrink C)

Cloud A-5: removing the GUI removes a third of the Back-key work. **Sequence B before C.**

| # | What | Notes |
|---|---|---|
| B1 | **GUI mode out** (Decision 5). Screen reads "1 = Start, X = Exit". FT-280's seven defects become moot | Update `ScreenNumberTable` (screen 21 loses its second branch). Grep website, licence and store copy for "two modes"/"GUI"/"option 2" -- measure, do not assume |
| B2 | **Malwarebytes out of the tool** (decided 2026-09-08; **product names out, 09-25**) | **Generalise, do not delete.** `Get-MalwarebytesState` has 13 call sites and items 2 and 7 change verdict on it. Replace with a generic "which product holds real-time protection" read from `root\SecurityCenter2 AntiVirusProduct`, **or FT-30, FT-33 and FT-114 return for every Norton, McAfee or Bitdefender customer.** Screens name no third-party product (CLAUDE.md) |
| B3 | **Remove the `GatewayGuard - Monthly Malwarebytes Reminder` task**, and **remove it once from machines that already have it**. ***Measured: SANDY was given it twice (triage)*** | Read-back after removal, same pattern as FT-203 |
| B4 | The four Malwarebytes screens go; screen numbers re-flow per the FT-172 table rules | Gate 12 |

---

# BLOCK C -- KEYS AND NAVIGATION (nothing blocked except C7)

| # | FT / Decision | Fix |
|---|---|---|
| C1 | **`X` = Exit** (Bill, 09-25) | ***Measured: `X` is in no key comparison in ascii44.*** Every `N = Exit` becomes `X = Exit` -- 11 sites per the 08-30 count, 6 found by prompt wording on 09-25; **re-count all before editing.** Every exit keeps the FT-171d confirmation |
| C2 | **FT-271** (ships with C3 -- Cloud A-1) | `Pause-ForUser` and `Read-ValidKey` log every ignored key, so "B did nothing" can be checked from the log |
| C3 | **FT-272 / Decision 1** | `B` = go back one **step** where a step can be redone (19, 20, 21, 22, 23, checklist). Where it cannot (after a write, after a reboot) say so: *"This step is done and cannot be reopened. Press Enter to continue."* |
| C4 | **`L` = look at the previous screen** (Decision 1) | The current picture-replay moves from B to L. ***Measured (FT-259): `L` is free*** |
| C5 | **FT-273** | B from screen 23 drops to a bare password prompt -- give it its box, number and Back |
| C6 | **FT-259 -- `F` = Fix the screen** (Bill 2026-09-07: *"one key that resets the screen"*) | At every prompt (the three readers): re-measure width **and height**, redraw the current screen from its stored text, page it if taller than the window. **Needs the "store text, not a photograph" change** (below), which also fixes Back breaking after a resize |
| C7 | **FT-270 -- Ctrl+C ends with no confirmation** (reopens FT-150) | Reproduce on CGDELL first; the SANDY observation (Part 7 step 3) confirms. Also the Mark-mode letter **BUILT 2026-09-27 (C7 `17c57e2`, C7b `ae7cf99`).** ***Measured:*** TreatControlCAsInput alone fails in Windows Terminal; a CancelKeyPress handler catches the signal; but every `ReadKey` also needs **AllowCtrlC**, or PowerShell's reader stops the program after the catch (Bill's tests A-D ended; A re-run with AllowCtrlC at 15:44 survived both steps and copy worked -- `Test_Results/CtrlCRepro-Built-CGDELL-2026-09-27_15-44-46.txt`). **Seen in real Checkup by Bill 2026-09-27 ~15:50:** Ctrl+C on screen 7 showed "You pressed Ctrl+C. Exit now? (Y/N)". Done. |
| C9 | **Full-screen launch -- IN SCOPE (Bill, 2026-09-26: "add full screen to ascii45")** | `Run-GatewayGuard.bat` starts Checkup with `wt -w new -F` (***measured on CGDELL, `Test_Results\WtFullscreen-CGDELL-2026-09-26_12-03.txt`***), falling back to the normal window where Windows Terminal is missing. Then: screens 3/4 (font) and 8 (copy) rewritten for Windows Terminal from measured behaviour; one line on screen saying how to leave without an X. **Needs first:** Bill's copy/selection test on CGDELL (`Tool2\Run-TestWtCopySelect.bat`) and the SANDY script's Windows Terminal check. ***Measured 2026-09-26 while building that test: a script path containing spaces does NOT survive `wt`'s own argument parsing, nor does a `-d` folder ending in `\.`; what works is `-d "<folder without trailing backslash>"` plus the script named without its path.*** `Run-GatewayGuard.bat` must use the same form -- the project folder has spaces ("OneDrive - GatewayGuard LLC"). ***Also measured, the hard way (Bill was stuck in it, 2026-09-26): when a `wt -F` launch FAILS, Windows Terminal leaves the error ("The system cannot find the file specified ... 0x80070002") on a FULL-SCREEN window with no X.*** Cause that time: Claude Code's smoke test passed an unquoted title, so wt tried to run "copy". **C9 therefore must:** check the build file exists before launching; use only the tested quoting; and say, in the launcher window before it opens, "If you are ever stuck in a full-screen window: Alt+F4 closes it, Alt+Enter leaves full screen." Removes FT-259's short window on this PC and the accidental window-close that ended two of nine ascii44 runs **Copy test RUN by Bill on CGDELL 2026-09-27 10:49** (`Test_Results\WtCopySelect-CGDELL-2026-09-27_10-49.txt`): ***measured*** in Windows Terminal (WT_SESSION True) -- highlighting does NOT pause the program (longest gap 0.53 s vs 0.5); Ctrl+C with text highlighted COPIES it (clipboard held the highlighted instruction line) and clears the highlight; Ctrl+C with nothing highlighted ENDED the unguarded test program. The test's own "copy worked: False" line was wrong -- it only looked for tick lines. **So screens 3/4/8 can say: highlight with the mouse, press Ctrl+C.** Checkup's Ctrl+C guard in Windows Terminal is C7: `Tool2\Run-TestWtCtrlC.bat`. |
| C8 | Store each screen's **text lines**, not only the buffer picture | 67 of 72 screens go through one shared routine that already holds the text; 5 hand-drawn (IDs 76, 77, 85, 86, 87). Enables C6 and makes Back survive a resize |

---

# BLOCK D -- RESUME (nothing blocked)

| # | FT / Decision | Fix |
|---|---|---|
| D1 | **FT-265** | Screens 10 and 11 stop replaying on resume (`Get-WinEdition` 9812, `Get-RAMStatus` 9815 run unconditionally today) |
| D2 | **FT-266** | `CheckpointOrder` has Malwarebytes before DefenderAV (reverse of the flow); `OfflineScanDone` never saved. Re-order after B2 removes Malwarebytes |
| D3 | **FT-267** | Clear the checkpoint when a run completes |
| D4 | **Decision 2** -- drop "Still YOUR personal computer?" on resume | Store the Machine ID in the state file; skip the question when it matches, ask when it does not. ***Measured 09-25: `$StateDir = "C:\GatewayGuard"` (line 1602), not OneDrive*** -- Cloud's reason for keeping the question does not apply, but the Machine-ID check stays as cheap insurance |
| D5 | **Decision 3** -- checkpoints at 21, 23/24 and the checklist; 1b says "You stopped at screen X. Checkup will continue at screen Y." | **The checklist selections live in memory today (FT-204)** -- persisting them is new state and new code (Cloud A-3). Listed as work, not a checkpoint name |

---

# BLOCK E -- THE NEW START SEQUENCE (the largest block; mostly new code)

**The order Bill set (note 12, Decision 6) plus Cloud's PUA step:**
**Tamper Protection -> Windows Update until finished -> PUA blocking on ->
signature age -> offline-scan offer -> full scan started by Checkup.**

| # | FT | What | Evidence needed before it ships |
|---|---|---|---|
| E1 | **FT-250** | Tamper Protection read first; everything after it reads a settled machine | existing read |
| E2 | **FT-252 upgraded to apply-and-loop** (Bill 09-25) | Windows Update: check, **install with approval, restart, repeat until nothing is left**. Must survive the restarts (resume, Block D). Plain progress wording | Windows Update Agent COM calls: **VERIFIED comment for every call (gate 24)**, measured on CGDELL. The loop's resume path is the riskiest code in the build |
| E3 | **FT-248** | Read `PUAProtection`; offer to turn it on, with approval, before any scan (Cloud A-6, *sourced Microsoft*) | `Set-MpPreference -PUAProtection` measured on CGDELL |
| E4 | **FT-249** | Signature age before a scan; a scan on stale definitions does not print "clean" | `Get-MpComputerStatus` fields measured |
| E5 | **FT-276 / Decision 9** | "Save and close your work" before the offline-scan question, every run. ***Measured: the reboot comes 5 s after Y*** | -- |
| E6 | **Full scan started by Checkup** (Bill 09-25; Cloud had it ascii46) | `Start-MpScan -ScanType FullScan` in the background with plain wording; **covers every drive, which is how F4 (second drive) gets done** | **VERIFIED comment -- measured on CGDELL, and the `D:` coverage measured on SANDY** (the ascii43 gate-24 block on F4 still applies). ***Measured: SANDY has a 1 TB HDD*** -- the wording must say it can take hours |
| E7 | **FT-277** | 14b stops asserting "scan finished"; reads `FullScanEndTime` / `QuickScanEndTime` (Cloud A-6). The Protection history link waits on Part 7 step 4 | ***Measured 09-25: `Get-MpComputerStatus` exposes the fields*** |

---

# BLOCK F -- SCREENS, WORDING AND GUIDE LINKS

| # | FT / Decision | Fix |
|---|---|---|
| F1 | **Decision 4** | Items 11-15 apply in the main run (FT-219 wins). 33a/33b are replaced by **"What Checkup changed"** (Was -> Now per item, ERROR in yellow) and **"Steps for you to do"** (one manual item per screen). Must print the manual revert for 13, 14, 15 (`RegPath = $null`) |
| F2 | Stale `Revert` strings (Cloud) | Setting 11 still says "General" (measured path: Recommendations and offers); 13 names old toggle labels. They become guide Part 4 §4.2 verbatim |
| F3 | **Decision 12** | Screen 19 report-only; the checklist is the one place 17-19 change. Its three Y/N prompts go too |
| F4 | **FT-274, FT-275** | Screen 3's two numbers; six unnumbered pauses get IDs in the table |
| F5 | **Decision 8 (as amended by Cloud)** | Every `GuideRef` becomes the **setting number** ("Setting 14") -- five print sizes means no page number can be right. Includes the six `"Keep vs. Disable Table"` refs. One table, one pass |
| F6 | **Decision 7** | Screen 34: one line on two-step sign-in pointing at guide Part 5 |
| F7 | **Decision 10 / FT-281** | Wake on LAN: log every adapter and wake property; show adapters only when one is ON or unreadable, named as Device Manager names them |
| F8 | **FT-253 -- the F6 wording block** (~20 items + FT-222, FT-237) | Carried from ascii43/44 unbuilt. Includes the Advertising ID stem label (FT-237) |
| F9 | F5 remnants: FT-195a, FT-175b, FT-225 | Carried |
| F11 | **Screen 7's list of checks is out of date** (Bill's paste, 2026-09-27 15:50) | It still lists the ascii44 order and says "7. Security scan confirmation (Defender)". Rewrite it for the Block E start sequence: Tamper Protection, Windows Update, unwanted-app blocking, virus definitions, offline scan offer, full scan -- and drop what no longer happens. Same line count (25) |
| F12 / FT-290 | **Start order and visibility** (Bill's CGDELL test run 2026-09-27, log `GatewayGuard-Log-2026-09-27_18-21.txt`) | Bill: "Did not check tamper protection first, did windows update ... and then said tamper protection was on." ***Measured in the log:*** Tamper WAS read first (18:22:16) but silently -- a Tamper-On result shows nothing until the summary. **Bill's order:** Tamper Protection -> virus protection (Defender real-time, today checked later, after the scans, in Test-DefenderPrimary) -> unwanted-app blocking -> Windows Update -> definitions; **each result shown on screen as it happens**, not only in the summary |
| F13 / FT-291 | **Sleep-prevention wording is false** (Bill: "doesn't tell you what it was and what it set it to") | ***Measured, code:*** `Enable-SleepPrevention` only calls `SetThreadExecutionState` -- it keeps the PC awake while Checkup runs and changes NO setting. Test-PowerStatus says "Sleep prevention: SET BY THIS TOOL ... Your original sleep setting will be restored", which implies a setting was changed. Say instead that Checkup keeps the PC awake while it runs and does not change your sleep settings |
| F14 / FT-292 | **Wake on LAN: two layers disagree; errors in the log** | ***Measured on CGDELL 19:53-20:1x:*** Checkup turned off Wi-Fi "Wake on Magic Packet" and "Wake on Pattern Match" (both now read Disabled) and said "disabled (2 settings)" -- true. But (a) 4 `[ERROR] SILENT ERROR` lines were logged for wake properties that do not exist on the Ethernet adapter (harmless, FT-285 family); (b) `Get-NetAdapterPowerManagement` still reads WakeOnMagicPacket/WakeOnPattern = Enabled for the Wi-Fi, and Checkup's read (Run-PowerSettingsCheck ~5840) counts that layer, so it will keep saying ENABLED after its own fix [**WITHDRAWN 2026-09-28 -- wrong.** Measured 08:1x: the checklist read uses that layer only for adapters with no named wake settings, and reads "DISABLED -- GOOD" on CGDELL; Bill's "Enabled" screen was most likely from before his 19:53 change]; (c) `powercfg /devicequery wake_armed` lists only "USB4 Root Router" -- the Wi-Fi is NOT allowed to wake the PC. Bill saw the four WoWLAN items "all enabled" in Device Manager (timing vs the 19:53 change to be confirmed). Decide the one reading that means "this PC can be woken over the network" -- likely wake_armed -- and fold into F7 |
| F15 / FT-293 | **Screen timeout line reads like the answer to N** | After N to the Wake-on-LAN question (18:41:48) screen 19 printed the advisory "[4] Screen timeout: Found: NEVER ... recommend 5 min" -- Checkup never changes it, but Bill read it as a reply. **Bill: "MOVE TO PREVIOUS SCREEN"** -- show it on the review screen, before the questions, saying plainly that Checkup does not change it |
| F16 / FT-294 | **Item 17 says GOOD while a wake within 15 minutes needs no password -- a WRONG GOOD** | Bill: "if you have been away sign-on requirement is set to 15 minutes". ***Measured on CGDELL 2026-09-27:*** `HKCU\Control Panel\Desktop` DelayLockInterval = 900 (15 min, matching Settings); `powercfg /a`: Standby (S0 Low Power Idle) -- Modern Standby. Item 17 reads only CONSOLELOCK (AC 1, DC 1) and said REQUIRED -- GOOD. *Inferred:* on Modern Standby the Settings choice is DelayLockInterval, and CONSOLELOCK alone does not mean a password on every wake. **GOOD must need both.** Research DelayLockInterval (0 = every time?), flip-test it on CGDELL, then fix the read and the apply |
| F17 / FT-295 | **Items 13 (Edge startup boost) and 14 (Widgets) say "Unknown" on a PC at defaults** | ***Measured on CGDELL:*** no Edge policy, Edge `Local State` has no startup_boost / background_mode values, no TaskbarDa and no Dsh policy -- nothing stored, so Checkup honestly cannot tell ("absent = default" already broke once). Unknown is safe but unhelpful: give the person the one-line way to look, like item 9 |
| F18 / FT-296 | **Checklist order** (Bill: "change order 1. tamper 2. defender 3. windows updates") | Screen 25 lists 1 Windows Update, 2 Defender, 3 Tamper. Show Tamper, Defender, Windows Update first, matching the start sequence. **Display order only -- the item NUMBERS stay** (logs name items by ID; CLAUDE.md, do not renumber) |
| -- | Bill's other checklist notes, 2026-09-27 | **Item 8** "NOT Encrypted" on CGDELL, which is 100% encrypted with protection Off -- FT-289 wording, already planned. **Item 9** "Not confirmed": ***measured*** CGDELL's last sign-in was by password ({60B78E88...}), so Checkup asks -- working as designed; the question tells him how to look. **Item 4** SmartScreen "Not configured" while Smart App Control is in evaluation mode -- the known FT-260 gap (Smart App Control governs it; deliberately not built). **Item 19** "Enabled -- consider disabling" after he said Y -- FT-292 (b) |
| -- | **Still to identify:** Bill's "after saying VP on it displayed a second message saying it was on" | The log shows one "Defender confirmed as primary AV" (18:31:46) -- which two screens is not determinable from the log. Ask Bill |
| F19 / FT-297 | **CRITICAL: item 8 on an already-encrypted drive adds a recovery key and claims encryption started** (Bill's CGDELL re-run 2026-09-28, log `GatewayGuard-Log-2026-09-28_06-57.txt`) | Bill: "it did not recognize that the disk was encrypted, instead provided a bitlocker key and proceeded as if the system needed to be and is being encrypted." ***Measured on CGDELL 2026-09-28 07:33:*** C: FullyEncrypted 100%, ProtectionStatus **Off** -- unchanged by the run. Key protectors: Tpm + **five** RecoveryPassword (inferred: one per test run that reached Enable-BitLocker). Log 07:21:28: `[APPLIED] BitLocker enabled ... Estimate: 20-60 minutes` -- false: `Enable-BitLocker` on an encrypted volume only added a protector. The key was saved to `%USERPROFILE%\OneDrive\GatewayGuard\BitLocker-Recovery-Key-2026-09-28.txt` (Bill must keep it). **Fix:** item 8 reads VolumeStatus AND ProtectionStatus -- "encrypted, protection off" is its own state (same as FT-289 on SANDY); never call Enable-BitLocker on an encrypted volume; offer to turn protection back on instead, only after measuring on CGDELL what that does with Secure Boot off (event 811: "cannot use Secure Boot for integrity"); never add a second recovery key -- point to the existing one. Whether to remove CGDELL's extra keys is Bill's decision |
| F20 / FT-298 | **Two pages with no screen number after 15, and no antivirus line on 14g** (Bill, 2026-09-28) | ***Measured in the log:*** after 15, Test-DefenderPrimary prints "OK Microsoft Defender is active as primary AV" with a pause but no box (07:02:24), then Test-PowerStatus prints the power lines with a pause but no box -- neither has an ID or number (part of FT-275's unnumbered pauses). Bill: "Check AV on 14g" -- the antivirus check belongs in the start sequence and on the 14g summary (with FT-290's order); these two pages then either get IDs or fold into 14g |
| F10 | **FT-220** | Waits on the guide text (W-07) -- the guide Parts 4-5 draft is with Cloud |

**BUILT 2026-09-28 (Bill: "build block F and the renumber pass").** Commits
`d4cca6d` (F11, F12/F20 order, F18), `0cd0b74` (F3, F7, F13, F14, F15, F17),
batch 3a (F4/FT-274/275, FT-298 box 98, F6), batch 3b (FT-275 antivirus pages;
password-manager names out, per CLAUDE.md), F1+F2 (screens 99 and 100; undo
text = guide 4.2 rows 11-15; Ready prompt Q -> X), F5, F8/F9, and the renumber
(`da15aea`). **Open:** F10 (guide text). **Not built, needs Bill:** screen 11's
"All security setting changes made by Checkup have been thoroughly tested"
(Bill's 08-26 note) -- the field record this week (FT-294, FT-297) does not
support that claim yet. **F8, measured against this build:** most of the ~20
items went with the screens they were about (Malwarebytes, 33a, the N keys,
FT-279); what remained is in `Tool2\build_ascii45_F8F9_wording.py`. **F9:**
FT-225 closed by the keys rule; FT-175b's offer is in `Show-PreScanGate`
(nothing further written down anywhere); FT-195a fixed by the renumber (1a ->
0a). **Renumber:** main line 1-37 with no gaps; the order and the conditions
behind it are in the wrapper's docstring. Checklist:
`ProjectDocs\GatewayGuard_FieldChecklist-ascii45-partial-2026-09-28-0836.md`.

---

# BLOCK I -- CO-PILOT'S ascii45 REVIEW, 2026-09-28 (checked against the source)

Co-Pilot withdrew its item 8, 9, 12 and 17 criticisms after reading the real
ascii45 file. Its three remaining points were each checked against the source
and **all three are right**. Measured, read-only, CGDELL 2026-09-28 08:51:
`Test_Results\Items1-4-13-CGDELL-2026-09-28_08-51.txt` (`Tool2\Run-MeasureItems1-4-13.bat`).

| # | FT | Finding (source) | Status |
|---|---|---|---|
| I1 | **FT-299** | **Item 1 says GOOD from the service start type alone** -- `Get-AllStatuses` case 1: `StartType -ne 'Disabled'` -> "Enabled -- GOOD". Paused updates, an auto-update policy, and updates the person declined at screen 14g are never looked at, though the start sequence (`Invoke-WindowsUpdateLoop`) knows its own outcome. **A possible wrong GOOD.** CGDELL: wuauserv Manual/Stopped (Windows' normal state), no AU policy, no pause values | **BUILT 2026-09-28** (`build_ascii45_ft299_item1_pause.py`). Flip test by Bill on CGDELL: Pause writes `UX\Settings\PauseUpdatesExpiryTime` ('2026-10-05T13:02:18Z'), Resume removes it (Items1-4-13-CGDELL 09-02/09-03/09-06). Item 1 now: Disabled / policy (NoAutoUpdate=1, sourced) / PAUSED until <date> / Unknown if unreadable / GOOD. Pause or policy -> steps on screen 35; service change read back. Declined updates at 14g deliberately not counted |
| I2 | **FT-300** | **Item 4 reads and writes ONE toggle** (`Explorer\SmartScreenEnabled`, "Check apps and files") but its description says "websites and downloads", and guide 4.2 says Checkup "turned the protections on" (four toggles). Apply also said GOOD without reading back | **Re-read BUILT** (`build_ascii45_ft300_item4_reread.py`). **Scope needs Bill/Cloud:** extend item 4 to Edge SmartScreen (candidate `HKCU\...\Edge\SmartScreenEnabled` = '1' on CGDELL, not flip-proven) and Store apps, OR narrow the item and guide wording to "Check apps and files". Unwanted app blocking is already its own start check (E3) |
| I3 | **FT-301** | **Item 13's Local State field is unproven -- and absent.** CGDELL's `startup_boost` has only `default_last_launch` and `last_browser_open_time`; no `enabled`, no `background_mode` section. Item 13 reads the Edge policy first (both 0 on CGDELL -> GOOD, sound), and the Local State branch can only say GOOD when both fields are found false, else Unknown -- **no wrong GOOD possible today** | **Flip test on SANDY** (no Edge policy there, not measured): run the measure script, turn Startup boost off in Edge, close Edge fully, run it again |

---

# BLOCK G -- BLOCKED ON A SANDY MEASUREMENT

**All six are in one script:** `Tool2\Run-MeasureSandyForAscii45.bat`
(read-only; run as administrator). ***Tested on CGDELL 2026-09-25 16:36,
output `Test_Results\SandyForAscii45-CGDELL-2026-09-25_16-36.txt`.***

| # | Measurement | Unblocks |
|---|---|---|
| G1 | FT-283 -- owner and permissions on `HKLM\...\Policies\Microsoft\Dsh` | Widgets write fix |
| G2 | Note 29 -- `manage-bde -status C:`, `Get-BitLockerVolume` | the encryption wording |
| G3 | FT-270 -- Ctrl+C and the Mark letter (by hand) | C7 |
| G4 | FT-277 -- which page the Protection history link opens; the 09-19 Defender log | E7 |
| G5 | FT-268 -- `/qh` on SANDY | confirms A1 |
| G6 | FT-282 -- the Diagnostic Data flip test | item 12 fallback read (Decision 11) |

**Block G results -- SANDY, run by Bill 2026-09-27 12:45** (`Test_Results/SandyForAscii45-SANDY-2026-09-27_12-45.txt`), all ***measured***:

| # | Result | Consequence |
|---|---|---|
| G1 FT-283 | `Policies\Microsoft\Dsh` exists; Administrators have FullControl (inherited) | The ascii44 UnauthorizedAccess on the Widgets write is NOT the key's permissions. Cause still open |
| G2 note 29 | C: 100% encrypted, protection Off, RecoveryPassword only. Windows log: encryption started 09-20 18:22 on C: and D:, key backup to a Microsoft account failed at every sign-in since | FT-289 (H7) |
| G3 FT-270 | Superseded by CGDELL tests 09-27: the old guard fails in Windows Terminal, the signal handler works | C7 built |
| G4 FT-277 | `windowsdefender://protectionhistory` opens Windows Security **Home** (Bill). Defender log 09-19 12:21: event 2030, offline scan configured for next reboot; last full scan 08-28 | 14b must give the manual route to Protection history |
| G5 FT-268 | `/query`: no index; `/qh`: AC 1, DC 1 | The fix works on SANDY too |
| G6 FT-282 | Switch OFF on SANDY -> `CurrentVersion\Policies\DataCollection` AllowTelemetry = 1; ON on CGDELL -> 3; Group Policy value absent on both | **Built 2026-09-27** (item 12 reads it) |
| step 7, C9 | SANDY has Windows Terminal 1.24.11911.0; default terminal not set, same as CGDELL | C9 can launch full screen on SANDY |

**Also SANDY-only, measured during the ascii45 field run itself:** D3 (the USB
sentence), D4 (the encryption local-account condition), and the live
encryption at the end of the run. **Do not encrypt SANDY before the ascii45
run** (2026-09-25).

---

# OPEN -- WAITING ON BILL

1. **Full-screen launch** (no window X to click). Two of nine ascii44 runs
   ended by the window closing. **Tested on CGDELL 2026-09-26 at Bill's
   request -- it works:** ***measured, `Test_Results\WtFullscreen-CGDELL-2026-09-26_12-03.txt`:
   `wt -w new -F` (sourced, Microsoft Learn) opens a window covering the whole
   screen with no title bar; administrator rights carry over from an elevated
   launch; the window is 133 x 37 (the normal window on 09-07 was 81 x 21, so
   26-line screens now fit -- most of FT-259 on this PC); it closes by itself
   when Checkup ends.*** **Still to check before the launcher changes:** a
   launch from the .bat run as administrator (inferred the same); SANDY has
   Windows Terminal; how copying works there (screen 8 teaches the classic
   console's Alt+Space, E, M) and what Ctrl+C does with text selected; whether
   selecting text pauses Checkup (FT-63 was a classic-console behaviour); and
   screens 3/4, whose font steps are for the classic console. Plus an
   on-screen line saying how to leave. **Now in scope as C9** (Bill,
   2026-09-26).

# NOT IN ascii45

- **FT-260's general detection gap** -- deliberately deferred until a second
  real instance of a non-policy lock turns up.
- **The mouse settings** -- `Tool2` scripts, not the build; Bill's timing is
  "after the website and guide, before launch."
- **FT-280** -- moot once B1 removes GUI mode.

---

# THE MECHANICS -- DO NOT SKIP THESE

Unchanged from ascii44 and every build before it:

1. **Every edit through `gg_edit.py`, assert-guarded.** No exemption for
   wording passes.
2. **One family per commit.**
3. **The build number moves in five places together:** filename, `FILE:`
   header, `BUILD:` header, `$BuildID`, the `CLAUDE.md` line.
4. **After every edit session:** parse = 0 errors and a plausible line count.
   Brace balance is not enough.
5. **Gates from `Tool2\`:** 12 and 12b (`Run-ScreenCoverageCheck.bat`), 24
   (`Run-ExternalCommandCheck.bat` -- **E2, E3, E4 and E6 all add external
   commands; this gate matters more than ever**), `Run-DocCheck.bat`,
   `Run-RepoHealthCheck.bat`.
6. **Every new external command carries `# VERIFIED YYYY-MM-DD measured on
   <machine>: ...` beside it.** FT-162 is why.
7. **26 lines per screen**, against the ten-screen baseline.
8. **A field checklist for the SANDY run, written before the run.**

---

# BLOCK H -- CO-PILOT'S CODE REVIEW OF ascii45, CHECKED (2026-09-26 13:44)

Co-Pilot reviewed the ascii45 code (not the history comments) and rated
settings 1, 4, 6, 8, 12 and 13 "conditional" and 9 "needs more work". Each
claim was checked against the code before anything went into this plan.

| # | Claim | Checked against | Verdict | Where |
|---|---|---|---|---|
| **H1 / FT-286** | Item 9 (Windows Hello) equates a folder with Hello | `Get-AllStatuses` line ~6012 and the apply case ~6550: `Test-Path "$env:LOCALAPPDATA\Microsoft\NGC"` | **Checkup is wrong on CGDELL. Settled by Bill at the keyboard, 2026-09-26 ~14:05: he signs in with a short PIN every day -- to what he calls his Microsoft account. ***Measured 14:10: that account IS Dad.*** CGDELL has one user folder, `C:\Users\willi`, belonging to Dad; Dad's settings carry Bill's Microsoft email; and every keyboard sign-in in the last three days (09-25 16:20, 17:37, 20:17; 09-26 08:49) was Dad. Windows lists Dad as a local account. One account, two names.** ***Measured:*** Security log 4624 -- Dad, interactive, 08:49:40 -- and the Hello log 5001/5702 "PIN protector = true" in **the same second**, and again 09-25 20:17. Checkup's folder **does not exist** on CGDELL, so it says "Not set up". **Three Windows sources disagree with each other:** Settings -> Sign-in options says **every** Hello option is "not available" (Bill); `dsregcmd /status` says `NgcSet : NO`; the PIN works. So **neither Settings nor `dsregcmd` can be the read** -- both deny a PIN that works. **Record of my errors:** 13:44 I said CGDELL has Hello (right); 13:52 I withdrew that on `dsregcmd` alone (wrong -- I trusted a Windows tool over the field, and "the field wins" is the rule). Likely history, *inferred*: the PIN was made while Dad was a Microsoft account; after the switch to local, the PIN still works but Settings cannot manage it (`DevicePasswordLessBuildVersion = 2`, the Microsoft-account-only Hello setting, is still on). **Candidate read:** `LogonUI\LastLoggedOnProvider` = the Hello provider `{D6886603-...}` **and** `LastLoggedOnUserSID` = the account Checkup runs as -> "you signed in with Windows Hello -- GOOD"; anything else -> "not seen -- check by hand" (never GOOD). **Flip test before building, by Bill:** at the next sign-in, choose Sign-in options -> password; re-read (expect the password provider); then sign in with the PIN; re-read (expect Hello). **Weakness to say out loud:** it reports how you last signed in, not what is set up, so it goes stale if a PIN is removed after sign-in. **Co-Pilot's answer, 14:30:** agrees the folder check fails and that `NgcSet` is the business-Hello state, not a home PIN; calls the DevicePasswordLess cause unverified. **Rejected parts:** it says the folder can exist with no PIN (CGDELL is the opposite -- missing folder, working PIN); its fallback sends users to Settings, which is wrong on CGDELL; no links. **Plan:** GOOD only when the last-sign-in read passes the flip test; otherwise never GOOD -- ask the person: *\"When you sign in to Windows, do you type a short PIN or use your face or fingerprint? If yes, you are set. If you type your full password, set up a PIN: Settings -> Accounts -> Sign-in options -> PIN (Windows Hello).\"* **Flip test, Bill, 2026-09-26 14:48-14:49 (read 14:51):** password sign-in at **14:48:35** -- Security 4624 for Dad, **no** Hello event; PIN sign-in at **14:49:33** -- 4624 plus Hello 5002/5702 (\"PIN protector = true\")/5001 **in the same second**. So the Hello log tells PIN from password -- ***measured, both directions***. `LastLoggedOnProvider` reads the Hello provider after the PIN sign-in (half proven); its password half was not read, because the PIN sign-in came before the read. **Password half, 14:53:51 (read 14:54):** Dad signed in with the password; `LastLoggedOnProvider` flipped to `{60B78E88-EAD8-445C-9CFD-0B87F74EA6CD}` (a different provider from Hello's `{D6886603-...}`), with no Hello event. ***Measured, both directions: the read flips.*** **DECIDED FOR ascii45:** item 9 reads `LastLoggedOnProvider`; GOOD only when it is the Hello provider **and** `LastLoggedOnUserSID` is the account Checkup runs as. Anything else is never GOOD: Checkup asks the person the sign-in question. **Known limits, to say in the code comment:** someone who has a PIN but last used a password is asked (safe); a PIN removed after sign-in stays GOOD until the next sign-in **or unlock**. **Unlock test, Bill, 15:03-15:04 (read 16:14):** password sign-in 15:03:54 (no Hello event), **Win+L**, one failed PIN try 15:04:14 (Hello 7001), PIN unlock 15:04:21 (Hello 5001/5702); the record then read the Hello provider. ***Measured: unlocking updates the record*** (logged as type 2, not type 7; lock events 4800/4801 are not audited on CGDELL). **Still untested, none can give a wrong GOOD except where marked:** face / fingerprint (no hardware; expected Hello, *guess*); security key and picture password (expected non-Hello, so the question); a Microsoft account never converted, and a local account never Microsoft (`localuser`); Windows Home (SANDY); automatic sign-in (non-Hello, so the question); another user signed in last, or a standard user elevating with an admin's password (SID mismatch, so the question). Test the Home and Microsoft-account cases in the SANDY run. | ascii45: build it |
| **H2 / FT-287** | Item 17 reads only the plugged-in (AC) value | `Get-GGConsoleLockState`: matches only `Current AC Power Setting Index` | **Correct.** A laptop on battery uses the DC value. **Fix in ascii45:** read both; GOOD only when both are 1. | ascii45 |
| **H3 / FT-288** | Item 1 checks that the update service is allowed to run, not that updates are current | line ~5851: `Get-Service wuauserv` StartType only | **Correct.** Block E2 (the Windows Update loop) already checks for updates; item 1 should report from the same read. | E2 / ascii46 |
| H4 | Item 12 reads only the policy value | line ~6030: `Policies\...\DataCollection` only | **Correct, already planned** -- Decision 11 / G6. | G6 |
| H5 | Item 4 reads one SmartScreen layer | `SmartScreenEnabled` plus the `EnableSmartScreen` policy lock (line ~6265) | Correct that it reads one layer. The Edge and unwanted-app layers are item 6 and E3 (PUA). **No new work.** | -- |
| H6 | Item 13 Edge values "inferred, not flip-proven" | the build's own comments | Correct; they say so. Flip test when Edge is next touched. | ascii46 |
| **H7 / FT-289** | SANDY: drive encrypted, protection Off, "suspended until next restart" | SANDY measurements 2026-09-27: `Test_Results/SandyForAscii45-SANDY-2026-09-27_12-45.txt`, `WhoEncrypted-SANDY-2026-09-27_13-16.txt`; Checkup log `FieldRun-ascii44/GatewayGuard-Log-2026-09-20_16-31.txt` | ***Measured:*** Checkup read 0% at 09-20 18:15, showed its 4 Home screens (they run no command -- ascii44 source), and sat idle on screen 32 from 18:21:51. At **18:22:26** Windows logged "Device Encryption initialized by user" for **C: and D:**; then "Failed to backup ... recovery information ... to your Microsoft account" (898) and "Failed to automatically enable Device Encryption" (4103) -- repeated at every sign-in since (09-22, 09-24, 09-25 x4, 09-26, 09-27). Now 100% encrypted, protection Off, only a RecoveryPassword protector. **Bill did not turn it on** (his statement); the log cannot say what was clicked. *Inferred:* on a LOCAL account Device Encryption encrypts but cannot turn protection on, because the key cannot go to a Microsoft account; Settings' "resumes at next restart" is wrong here (three restarts, still off). **Fix:** item 8 must not call this "NOT ENCRYPTED" -- say encrypted but not protected, and why; the Home screens must say a local account cannot finish Device Encryption, and show how to save the recovery key. **DECIDED -- Bill, 2026-09-27 13:26: "i think i should turn it off".** SANDY is decrypted before the field run (Settings -> Device encryption -> Off); the run waits until `Tool2/Run-CheckEncryptionProgress.bat` reads every drive FullyDecrypted. **DONE -- Bill, 2026-09-27 ~16:00: on SANDY both drives read 0%, not encrypted.** SANDY starts the field run unencrypted. **What started it -- SANDY logs, `Test_Results/EncryptionStart-SANDY-2026-09-27_17-00.txt`:** every encryption event 18:22:25-29 is under Panther's account (SID ...-1001) and process 8832; C: and D: together; then key backup to a Microsoft account failed, error 0x80070525, and three more processes logged "Failed to automatically enable". No app-launch, Microsoft-account or work-account events 18:10-18:30; program starts are not recorded on this PC, so **process 8832 cannot be named**. Not Checkup: its log shows it waiting at screen 32 18:21:51-18:33:05; its Home path has no encryption command; and Checkup's own change at 18:11:23 (password on wake) appears in SANDY's System log that same second, while nothing of Checkup's appears at 18:22. **Cause: undetermined.** Option for the field run (Bill's choice, not done): turn on Windows' process-start auditing on SANDY so a repeat names the program. | Block F |
| -- | Items 2, 3, 7, 10, 11, 14-16, 18, 19 accurate | -- | No change. | -- |

**The lesson from H1:** Windows' own tools can disagree with what the user
does at the keyboard. Settings and `dsregcmd` both denied a PIN Bill uses
every day, and I believed them over the field for twenty minutes. **Ask how
the user actually signs in before trusting any tool's answer** -- and a read
goes into Checkup only after it has been flipped both ways.

---

# THE SCHEDULE -- *inferred*, a proposal, no slack

| Dates | What |
|---|---|
| 09-25 to 09-26 | Block A; Bill runs the SANDY measurement script |
| 09-27 to 09-28 | Block B, then C |
| 09-29 to 09-30 | Block D; Block E1, E3-E5, E7 |
| 10-01 to 10-02 | **E2 (Windows Update loop) and E6 (full scan)** -- the riskiest code; measured on CGDELL first. Block F |
| 10-03 | Gates, field checklist, ascii45 to SANDY |
| 10-04 to 10-06 | **SANDY field run**, encryption last |
| 10-07 to 10-09 | Triage and fixes -> **ascii46** |
| 10-10 to 10-14 | ascii46 confirmation run, code signing, store listing |
| **10-15** | **Launch** |

**If something must give, cut from the bottom of Block F first, then C6/C8
(the F key), never Block A.**

---

# WHAT I WOULD START ON TODAY

**A1 (FT-268), then the rest of Block A.** A1 is one command switch at two
sites, measured twice already, and it turns a setting that has never been
readable on any machine into one that is.
