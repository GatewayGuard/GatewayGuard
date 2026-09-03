<!-- Dated: 2026-07-21 10:09 EDT -->
# GatewayGuard Test History -- ascii33
- **Document Name:** GatewayGuard_TestHistory-ascii33
- **Last Modified:** 2026-07-21 10:09 EDT
- **Status:** Cumulative Master Document (supersedes all prior versions)
- **Change History Log:**
  - 2026-07-21 10:09: Initial file. HP SANDY overnight field run
    (2026-07-21, 00:58-02:22). Four logs + field notes analyzed.
    FT-108 (Dell BitLocker, chat-only from 2026-07-20 session)
    filed here for the record. New defects FT-109 through FT-117,
    design items D-16 through D-21.

**Build date:** 2026-07-19
**Field test date:** 2026-07-21 (overnight, 00:58-02:22 AM)
**Test machine:** HP Notebook 17-by1xxx (SANDY) -- Win 11 Home, 8 GB RAM
**MachineID:** F7F13A97D58D
**MB state:** Free (companion; Defender primary confirmed by tool)
**Tester:** William F. Burns III
**Logs:** 4 log files (00:58, 01:04, 01:40, 02:07)
**UNRUN BUILD RULE:** CLEARED -- ascii33 field-run 2026-07-21 with
uploaded logs. ascii34 scoping may open.

---

## RUN SUMMARY (4 logs)

| Log | Start | End | Path | Exit |
|-----|-------|-----|------|------|
| 00:58 | Fresh start | 01:03:47 | Font -> checks -> baseline -> pre-scan -> Defender healthy -> MB launched -> Custom/Deep guidance | ABNORMAL -- no footer, empty caller (Ctrl+C per note 12) |
| 01:04 | Resume (DefenderAV) | 01:37:25 | Re-verify -> power settings -> apps audit -> console -> passwords -> scope -> HEADS UP | ABNORMAL -- no footer, empty caller |
| 01:40 | Resume (AppsAudit) | 02:02:14 | HEADS UP -> review -> HEADS UP repeat -> console run -> BitLocker SKIP (3) -> tasks -> complete | CLEAN -- footer written |
| 02:07 | Resume (AppsAudit) | 02:22:55 | Same path -> BitLocker OVERNIGHT (2) -> ERROR 0x8031005A -> tasks -> complete | CLEAN -- footer written |

---

## PRIOR-BUILD ITEMS -- FIELD VERDICTS (ascii33 scoped fixes)

| Scope item | Field verdict |
|------------|---------------|
| FT-93/93b schtasks rewrite | PARTIAL FAIL -- see FT-109. MB Monthly Reminder created GOOD (both runs) -- first field success ever for that task. Quarterly Defender Offline Scan FAILED both runs with a NEW error (path quoting). Per C-25 this item remains OPEN. |
| FT-94 ConvenienceReview ask-before-apply | NOT REACHED -- convenience items skipped this run path. Untested. |
| FT-95 ConvenienceReview copy | NOT REACHED. Untested. |
| D-06 SCREEN-26/27 pre-scan briefings | PARTIAL -- SCREEN-13 Custom Scan rewrite rendered (00:58 log). SCREEN-26/27 not observed in logs; run resumed past them 3 of 4 times. Needs a fresh full run to verify. |
| D-15 overnight scan guidance | RENDERED (00:58 log: "AFTER THE CUSTOM SCAN -- RUN THE DEEP SCAN OVERNIGHT"). Content verify pending Bill's read-through. |
| FT-96/97 status strings | PARTIAL FAIL -- see FT-117 (truncation recurs on HP console). |
| FT-98/C-15 step counter | FAIL -- see FT-116. Note 1: "No screen numbering" visible to user. |
| FT-101 Mark tip placement | FAIL -- note 12: no Mark reminder where user needed to copy; note 16: tip flashed by unreadable on another screen. |
| FT-102 password manager flag | NOT VERIFIABLE this run -- summary screen content not captured in notes. |
| FT-105 IsTamperProtected | NOT VERIFIABLE on HP -- but see FT-115: Memory Integrity "Unknown" indicates related detection gaps on this machine. |

---

## FILED FOR THE RECORD (from 2026-07-20 Dell session, chat-only until now)

| ID | Sev | Description |
|----|-----|-------------|
| FT-108 | R | BitLocker already-encrypted path (Dell discovery, 2026-07-20): four code problems -- (1) already-encrypted path does no recovery-key verification; (2) 48-digit key never displayed on screen; (3) no Microsoft-account backup attempted; (4) sleep restoration after encryption unverified. Dell C: found encrypted from a forgotten session; key was NOT in MS account (local account -- BackupToAAD unavailable); retrieved via manage-bde -protectors C: -get. |

---

## NEW DEFECTS -- ascii33 FIELD RUN (HP SANDY)

### 🔴 BLOCKERS

| ID | Note/Log | Description | Planned fix |
|----|----------|-------------|-------------|
| FT-109 | Logs 01:40 + 02:07 | schtasks Quarterly Defender Offline Scan FAILS: exit -2147467259, "Invalid argument/option - 'Files\Windows'". Root cause: unquoted executable path containing spaces (C:\Program Files\Windows Defender\...) splits at the first space inside the /tr argument. MB Reminder succeeds (its command line survives quoting). FOURTH consecutive build with a task-creation error (FT-73/76/93 lineage). | Wrap the /tr payload in escaped quotes: /tr "\"C:\Program Files\...\MpCmdRun.exe\" -args". Grep every schtasks call for unquoted paths (Fix-Everywhere). Field-verify BOTH tasks exist in Task Scheduler before this item closes (C-25). |
| FT-110 | Log 02:07, note 18/19 | BitLocker enable on Windows 11 Home fails: 0x8031005A "This version of Windows does not support this feature." Enable-BitLocker (manage-bde class) is a Pro feature; Home has Device Encryption only (Settings UI, MS account required). STATE-MATRIX GAP: the enable path was never tested on Home -- prior Home tests skipped (log 01:40) or machine already encrypted. UNVERIFIED -- confirm exact Home-supported cmdlet surface before coding the fix. | Branch on edition (already detected at startup): Pro -> current path; Home -> Device Encryption manual steps (Settings > Privacy & security > Device encryption) + note MS account requirement + recovery key lives in the MS account. Never attempt Enable-BitLocker on Home. Research first per RESEARCH BEFORE STATING. |
| FT-111 | Note 18 screen text | "Could not auto-set sleep -- set manually if leaving overnight" -- the sleep/display auto-set for overnight encryption FAILED on HP, then the flow proceeded saying "Sleep and display are set to Never" anyway -- the success line contradicts the failure line on the same screen. If encryption had started, machine could have slept mid-encryption. | Fix the sleep-set failure (capture why on HP); and make the flow honest: if auto-set fails, do NOT print the "are set to Never" line -- print the manual steps and require acknowledgment. |
| FT-112 | Note 12 | Ctrl+C still terminates the program instantly (user pressed it while trying to copy). FT-24 fix (QuickEdit off) removed one trigger but Ctrl+C itself is not trapped. Combined with FT-113: this is the source of the two abnormal exits. | Investigate [Console]::TreatControlCAsInput or CancelKeyPress handling so Ctrl+C is absorbed or produces a clean "are you sure" exit with footer. Test that Mark-mode copy (Enter) still works. |

### 🟡 FIX BEFORE LAUNCH

| ID | Note/Log | Description | Planned fix |
|----|----------|-------------|-------------|
| FT-113 | Logs 00:58 + 01:04 | Two abnormal ends with NO footer and sleep-deactivation logged with EMPTY caller: "(called from: )". Cleanup finally-block runs but caller name is blank and footer never writes. FT-104 family (silent termination). | Footer must write in the same cleanup path that restores power management; caller parameter must never be empty (pass a literal). |
| FT-114 | Notes 13/14, logs | HEADS UP screen lists "Defender Real-Time VP -- Status: ON" as a not-selected security-critical concern. An item that is already ON and healthy should not be presented as a warning-level skip. Confuses the user ("What would we want to change?"). | HEADS UP list must exclude items whose current status already meets the recommendation. Only flag not-selected items that are actually in a non-recommended state. |
| FT-115 | Logs (all HEADS UP renders) | Memory Integrity "Status: Unknown" on HP. Detection gap on this hardware/edition. UNVERIFIED root cause. | Diagnose on HP: check registry key + Get-CimInstance path used; may need same treatment as FT-105 (better API). |
| FT-116 | Note 1 | Step counter ("Section -- Step N") not visible to user anywhere in the run despite being ascii33 scope item 7. Either Show-StepHeader is not called on these screens or output is overwritten by Clear-Host. | Verify Show-StepHeader call sites; walk the resume path specifically (all 3 resumes bypassed early screens). |
| FT-117 | Note 9 | Checklist truncation recurs on HP: character(s) to the right of "2. Defender Status" cut off. FT-96 fix insufficient at HP console width (8 GB machine, possibly narrower default buffer). | Measure actual console width at runtime; wrap or shorten to fit measured width, not assumed width. |

### 🟢 COPY / MINOR

| ID | Note | Description | Planned fix |
|----|------|-------------|-------------|
| FT-118 | Note 12 | Diagnostic Data status wording: change to "Should Send Required Only" (or equivalent clarity) under Status. ⚠ STATUS-STRING CONTRACT: "Required Only" is a locked token consumed by gate logic -- grep every -match before any rewording, same edit. | Copy change + contract grep. |
| FT-119 | Note 17 | Final screen must state plainly: this ends the program -- go do your manual tasks. Current wording doesn't say the program is ending. | Copy change (USER-FACING CLARITY). |

---

## NEW DESIGN / SCOPE ITEMS

| ID | Note | Description | Status |
|----|------|-------------|--------|
| D-16 | 10 | Edge check for settings #6/#13/#15: ask whether the user uses Microsoft Edge. If not: explain Edge is built into Windows and they may use it someday, so set the protections now as a precaution; provide the steps. | PROPOSED |
| D-17 | 16 | Backup warning before BitLocker: tell the user to back up their system and data BEFORE starting encryption. Add to the BitLocker prep screen ("BEFORE ENABLING BITLOCKER, YOU MUST:" list). | DECIDED -- add |
| D-18 | 17 | Manual-steps final screen: include step-by-step for MB Custom Scan and Deep Scan (the verified instructions from ascii32 investigation), not just "run your scans." | DECIDED -- copy exists, reuse |
| D-19 | 19A | WEBSITE RULE: no one may buy the automated tool until their specific device model is beta tested. Affects download page, compatible page, and purchase flow design. | PROPOSED -- business decision; affects launch scope |
| D-20 | 19B | Windows 11 Home BitLocker handling policy: research Device Encryption support surface, decide product behavior for Home users (manual path vs. unsupported). Feeds FT-110 fix. | RESEARCH REQUIRED |
| D-21 | 15 | HEADS UP appears twice (stage: review, then stage: final) -- by design (C-20 acknowledgements) but reads as a bug to the user. Decide: single acknowledgment, or make the second one visibly different ("Final confirmation"). | DECIDE before ascii34 |

---

## CONFIRMED WORKING (this run)

- Resume flow: three successful resumes (DefenderAV, AppsAudit x2)
- Checkpoint save/restore across abnormal exits
- Fresh-start path: font screens, personal check, admin, edition,
  RAM, time-sync detect + auto-fix, baseline, pre-scan gate
- Defender-primary + MB-companion detection (correct on HP: Defender
  active, MB Free companion)
- MB launch (elevated, inherited) + SCREEN-13 Custom Scan guidance
  + overnight Deep Scan guidance rendered
- Monthly Malwarebytes Reminder task CREATED -- first field success
  in five builds (half of FT-93 lineage closed)
- BitLocker skip path (option 3) with drive/RAM/estimate display
- Clean exit with full footer (logs 3 and 4)
- Continuous log discipline: last line showed exactly where abnormal
  exits occurred, as designed

---

## OPEN QUESTIONS FOR BILL

1. Note 12 says "there were 1 mis-statements Will rerun" -- which
   mis-statement? Not captured elsewhere.
2. Note 20: program appeared to restart showing last 3 screens
   (including the error). Possibly log 4's screens still on scroll-back,
   or a real re-launch. You flagged you were tired -- confirm or drop?
3. Note 19: HP network/DHCP issue -- does the HP have internet
   currently? (Ruled out as FT-110 cause: 0x8031005A is an edition
   error, not a network error -- but the DHCP issue still needs its
   own troubleshooting session.)
4. SCREEN-26/27: not reached in any of the four logs (resumes skipped
   past them; the fresh run ended before them by a different path).
   A fresh full start-over run is needed to field-verify the D-06
   package.

---

## CARRY-FORWARD (unchanged from ascii32 open list)

- FT-99 Back everywhere (note 2 re-confirms user wants it)
- FT-100/D-07 power per-item flow (note 5 re-confirms: "same old screen")
- FT-104 silent-exit diagnosis (now joined by FT-113, same family)
- FT-106, FT-107, D-12 (.txt confirm), D-14
- HP quarantine completion + Deep Scan confirm (18 PUPs)
- Lid-close scan behavior verification
- HP version updates (MB 5.5.7, Win .8655) + fan cleaning + DHCP fix

---

## ASCII34 SCOPE (draft -- pending scoping session)

**Blockers:** FT-109 (schtasks path quoting + Task Scheduler verify),
FT-110/D-20 (Home edition BitLocker branch -- research first),
FT-111 (sleep auto-set honesty), FT-112 (Ctrl+C trap)

**Before launch:** FT-113 (footer on all exits), FT-114 (HEADS UP
excludes healthy items), FT-115 (Memory Integrity detection on HP),
FT-116 (step counter visibility), FT-117 (runtime console width)

**Copy:** FT-118 (contract grep first), FT-119, D-17, D-18

**Decisions needed before build:** D-16 (Edge check), D-19 (website
purchase rule), D-21 (double HEADS UP)

**Field-verify in next run:** SCREEN-26/27 (fresh start-over run),
FT-94/95 (reach ConvenienceReview), FT-102 (summary), ascii33 items
not reached this run.
