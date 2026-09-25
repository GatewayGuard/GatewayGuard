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
| C7 | **FT-270 -- Ctrl+C ends with no confirmation** (reopens FT-150) | Reproduce on CGDELL first; the SANDY observation (Part 7 step 3) confirms. Also the Mark-mode letter |
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
| F10 | **FT-220** | Waits on the guide text (W-07) -- the guide Parts 4-5 draft is with Cloud |

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

**Also SANDY-only, measured during the ascii45 field run itself:** D3 (the USB
sentence), D4 (the encryption local-account condition), and the live
encryption at the end of the run. **Do not encrypt SANDY before the ascii45
run** (2026-09-25).

---

# OPEN -- WAITING ON BILL

1. **Full-screen launch** (no window X to click). Two of nine ascii44 runs
   ended by the window closing. Needs a CGDELL test of the `wt` full-screen
   option and of administrator rights carrying over, plus an on-screen exit
   line. **Not in scope until Bill says so.**

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
