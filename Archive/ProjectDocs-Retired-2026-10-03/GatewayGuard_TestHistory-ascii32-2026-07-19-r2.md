<!-- Dated: 2026-07-19 16:50 EDT -->
<!-- File: GatewayGuard_TestHistory-ascii32-2026-07-19-r2.md -->
<!-- Source: 3 log files (07:43, 08:09, 08:57) + Ascii32_test_Results-2026-07-18-09-05.docx
     + MB scan reports (Threat 2026-07-16 02:41, Deep 2026-07-16 09:54)
     Field run: 2026-07-19, Dell Latitude 5430 (CGDELL), Win 11 Pro
     Tester: William F. Burns III -->

# GatewayGuard Test History -- ascii32
**Build date:** 2026-07-17
**Field test date:** 2026-07-19
**Test machine:** Dell Latitude 5430 (CGDELL) -- Win 11 Pro, 32 GB RAM
**MachineID:** 565F4EC4F822
**MB state:** Trial expired (License: Expired confirmed in scan reports)
**Tester:** William F. Burns III
**Logs:** 3 log files (07:43, 08:09, 08:57)
**UNRUN BUILD RULE:** Cleared -- ascii32 field-run 2026-07-19.

---

## DEFECTS FIXED IN THIS BUILD (from ascii31 findings)

| ID | Description | Fix | Field verdict |
|----|-------------|-----|---------------|
| FT-80 | Pre-scan N mislabeled as exit | Relabeled; S=Skip prominent | Not re-tested this run |
| FT-81 | MB URL cert error | Changed to malwarebytes.com | Not re-tested this run |
| FT-83 | Baseline screen content below fold | Scroll indicator added | Not flagged this run |
| FT-88 | Screen flash before Quick Question | Clear-Host removed | Not flagged this run |
| G-01 | Screen numbering | [SCREEN-NN] logged | PARTIAL -- logged but NOT displayed on screen (FT-98) |
| G-02 | Mark mode copy reminders (x3) | Added | WORKING but one placement wrong (FT-101) |
| G-03 | Periodic scanning neutral copy | Rewritten | Not flagged this run |

---

## DEFECTS FOUND IN ascii32 FIELD TEST

### 🔴 BLOCKERS

| ID | Note # | Description | Planned fix |
|----|--------|-------------|-------------|
| FT-93 | 13,14 | Scheduled task ERROR both runs: "A positional parameter cannot be found that accepts argument 'False'" -- BOTH tasks (Quarterly Defender Offline, Monthly MB Reminder) fail to create. THIRD consecutive build with task-creation errors (FT-73/76 lineage). Feature has NEVER been field-confirmed working. | Grep Setup-ScheduledTasks for the 'False' argument; likely a boolean passed positionally to a cmdlet parameter. Field-verify in Task Scheduler before ship. |
| FT-94 | 16 | ConvenienceReview: Advertising ID changed WITHOUT asking user first -- user saw it only after the fact | Restructure: ask-then-apply, never apply-then-review |
| FT-95 | 16 | ConvenienceReview copy incomprehensible: "Why keep the change / revert it" -- user (the developer!) could not understand it | Complete copy rewrite; every choice states its outcome (USER-FACING CLARITY) |

### 🟡 FIX BEFORE LAUNCH

| ID | Note # | Description | Planned fix |
|----|--------|-------------|-------------|
| FT-96 | 12 | Status text truncated mid-word on checklist ("..") at unreadable points -- Tamper Protection, Phishing Protection, Diagnostic Data all affected | Shorten status strings to fit column; full text on item's own screen |
| FT-97 | 12 | "Diagnostic data required only -- not restricted" wording meaningless to user | Plain-English rewrite of all status strings (neighbor test) |
| FT-98 | 2,5,7,11 | Screen numbers logged as [SCREEN-NN] but NOT displayed on screen -- G-01 required both | Add "Screen NN" to Draw-Box header display |
| FT-99 | 2,5 | No Back button on most screens | Extend Back navigation; audit which screens lack it |
| FT-100 | 6,7 | Power settings review: all items dumped at once at end; user given no per-item choice for Fast Startup, WoL, screen timeout, critical battery | Per-item flow: setting description + choice immediately after, one at a time (D-07) |
| FT-101 | 13,18 | Mark mode copy tip fires on a blank screen with nothing to copy (after Y at security-critical warning) | Move/remove that instance; tip only on screens with copyable content |
| FT-102 | 18 | Summary says "install password manager" even though user answered Y (has one) at passwords screen | Summary must check $HasPasswordManager flag |
| FT-103 | 18 | MB explanation appears at END summary; belongs in pre-scan briefing at the beginning | Covered by D-06 pre-scan redesign |

### 📋 DESIGN / SCOPE DECISIONS (new this round)

| ID | Note # | Description | Status |
|----|--------|-------------|--------|
| D-06 | 1,3,18 | Pre-scan explanation screen: Defender + MB + what/why BEFORE any scan screens; Defender first, MB second | DECIDED -- spec below |
| D-07 | 6,7 | Power settings per-item choice flow | DECIDED -- per-item, choice follows description |
| D-08 | 15 | Skip option at post-scan screen if scans already run | DECIDED -- add skip |
| D-09 | 4 | Sleep prevention: tell user what it was set to and what changed | DECIDED -- add to power screen |
| D-10 | 14 | Wording: "monthly reminder to run your Malwarebytes deep scan" everywhere | DECIDED -- locked |
| D-11 | new | Rootkit toggle: user turns it ON manually; GatewayGuard NEVER touches MB settings programmatically | DECIDED -- see MB verification below |
| D-12 | new | Downloadable reference card: GatewayGuard-QuickReference.txt in Documents\GatewayGuard\ alongside log | PROPOSED -- format pending confirmation |
| D-13 | new | Tell user about log file location EARLY (pre-scan or window setup), not only at end | DECIDED |

---

## MB SCAN VERIFICATION (field-tested, Dell, 2026-07-16 reports + 2026-07-19 re-run)

### Report evidence

| | Threat Scan 07-16 02:41 | Deep Scan 07-16 09:54 |
|---|---|---|
| License | Trial | **Expired** |
| Scan Options -> Rootkits | **Disabled** | **Disabled** |
| Objects scanned | 178,513 | 407,728 |
| Duration | 2 min 15 sec | 46 min 17 sec |
| Drives | (default) | C:\ and D:\ |

### VERIFIED FINDINGS

1. **Deep Scan does NOT include rootkit checking by itself.** The Deep Scan
   report explicitly shows "Rootkits: Disabled." The "Scan for rootkits"
   toggle (Settings -> Security) governs ALL scan types. The 2021 forum
   claim that deep scan = threat scan + rootkits is WRONG for the current
   product (v5.6.2.268).
2. **"Scan for rootkits" was OFF by default** in trial-expired/Free mode
   on the Dell. Bill had to turn it on manually.
3. **Deep Scan IS available in trial-expired (Free-equivalent) mode.**
   The 09:54 Deep Scan ran with License: Expired. Free users CAN run
   monthly deep scans -- tool copy is safe.
4. **User verification method:** every MB scan report has a
   "-Scan Options-" section showing "Rootkits: Enabled/Disabled."
   Reference card instructs: check the report shows Rootkits: Enabled.
5. **Field time estimates (Dell, 407K objects, C:+D:):**
   Threat ~2 min; Deep (no rootkits) ~46 min; Deep WITH rootkits:
   PENDING -- re-run with toggle ON in progress 2026-07-19.

### DECISION (D-11): GatewayGuard NEVER programmatically modifies MB settings.
MB self-protection blocks external modification (same mechanism that
flagged our self-elevating .bat). Attempting it would (a) fail or
(b) look exactly like malware behavior. User performs the toggle
manually with tool-provided steps. This is both the technically
correct and trust-correct answer.

### CONFIRMED ROOTKIT TOGGLE COPY (ships in ascii33 + website):

    One-time setup before your first deep scan -- turn on rootkit checking:
    1. Open Malwarebytes
    2. Click the gear icon (Settings)
    3. Click the Security tab
    4. Turn ON "Scan for rootkits"
    You only do this once -- it stays on for all future scans.

    What's a rootkit? A rootkit is one of the sneakiest kinds of
    malicious software. It buries itself deep inside Windows -- deeper
    than most security programs can see -- and then hides itself, and
    often hides other malicious programs too. Your PC can be infected
    and everything still looks normal. Normal scans can miss rootkits
    because rootkits actively hide from them. Turning this setting on
    tells Malwarebytes to look in the places rootkits hide.

### CONFIRMED DEEP SCAN INSTRUCTIONS (verified against MB Help Center,
### updated June 30, 2026):
    1. Open Malwarebytes
    2. Next to the Scan button, click the three dots (do NOT click
       Scan -- that runs a Threat Scan instead)
    3. Click Advanced Scan
    4. Click Deep Scan -- it starts automatically
    5. When done, the MB icon flashes in the system tray; open the
       app to review results
    Source: help.malwarebytes.com article 39240775526171

---

## CONFIRMED WORKING (this run)

- Resume flow (R, re-verify, checkpoint restore) -- two successful resumes
- Start-over (S, checkpoint clear)
- BitLocker already-enabled detection
- Mode selection, Apps Audit, power settings check
- ConvenienceReview renders and loops (copy/flow defective per FT-94/95)
- Continuous log with complete footer on normal exit
- Sleep prevention activate/deactivate with call-site logging
- [SCREEN-NN] log entries (display portion missing -- FT-98)

---

## RECURRING DEFECT PATTERN ANALYSIS (ascii30 -> ascii32)
### Why the same classes of defect keep re-appearing

**PATTERN A -- Fixed in one place, not everywhere.**
FT-67 -> FT-71 (same null-Status bug, second location). FT-73 -> FT-93
(task parameter errors persist through a "fix"). RULE: after any fix,
grep the full file for the same pattern; apply everywhere in the same
build; log "applied at N locations: [list]".

**PATTERN B -- Screen copy written once, never re-read as the user.**
FT-95/96/97: status strings and review copy made sense at write time,
failed in front of a real user. RULE: before ship, read every user-
facing string as a non-technical senior seeing it cold. If the meaning
isn't predictable, rewrite. (This is the USER-FACING CLARITY rule
applied as a build gate, not just a writing guideline.)

**PATTERN C -- Scoped in discussion, not in code.**
D-07 discussed in ascii31 scoping, unchanged in ascii32 (FT-100).
G-01 half-implemented (logged, not displayed -- FT-98). RULE: a scoped
item must name the target function and the specific behavior change.
"Fix the power flow" is not scope; "Run-PowerSettingsCheck presents
one setting per screen with its choice prompt" is. At build time,
diff the scope list against the change list -- every scoped item
either appears in the changes or is explicitly deferred with a reason.

**PATTERN D -- New screen ignores existing state.**
FT-102: password-manager answer captured, summary never checked it.
RULE: every conditional screen carries a comment naming its state
variable (# Depends on: $global:HasPasswordManager). Pre-build audit
greps these comments and confirms the variable is set upstream.

**PATTERN E -- [ERROR] in log treated as done.**
FT-93 is the third build with scheduled-task ERROR lines. The feature
has never once been confirmed working. RULE: a feature with [ERROR]
lines in any field log is OPEN until a field run shows the error gone
AND the outcome verified (tasks visible in Task Scheduler). Add to
field test checklist: open Task Scheduler, confirm both GatewayGuard
tasks exist.

**These five rules go into CodingStandards.md as the ascii33 additions.**

---

## STATE MATRIX COVERAGE (ascii32)

| State | Covered this run | Notes |
|-------|-----------------|-------|
| Win 11 Pro | ✅ | Dell |
| Win 11 Home | ❌ | SANDY not run this cycle |
| MB Trial expired | ✅ | Dell -- scan reports confirm License: Expired |
| MB Absent | ❌ | SANDY not run |
| BitLocker encrypted | ✅ | Dell |
| Fresh run | ✅ | 07:43 log (start-over) |
| Resume run | ✅ | 08:09, 08:57 logs |
| Deep Scan in Free mode | ✅ | 07-16 report, License: Expired |
| Deep Scan WITH rootkits | ⏳ | Re-run in progress 2026-07-19 |

---

## ASCII33 SCOPE (draft -- pending scoping session)

**Blockers first:**
| Item | Type |
|------|------|
| FT-93 -- scheduled task 'False' parameter | 🔴 Code fix + Task Scheduler field verify |
| FT-94 -- ConvenienceReview ask-before-apply | 🔴 Flow restructure |
| FT-95 -- ConvenienceReview copy rewrite | 🔴 Copy |

**Pre-scan redesign (D-06 package):**
| Item | Type |
|------|------|
| New pre-scan briefing screen(s): Defender, MB, 14-day trial, what we ask and why | New screens |
| Rootkit toggle instructions + plain-English explanation | Copy (verified) |
| Deep scan instructions (3-dots -> Advanced -> Deep) | Copy (verified) |
| Defender-first screen order (FT-85 carryover) | Flow reorder |
| Skip option if scans already run (D-08) | Flow |
| Log file location told early (D-13) | Copy |
| D-10 wording everywhere | Copy |

**Clarity fixes:**
FT-96, FT-97, FT-98, FT-101, FT-102

**Larger items (may defer to ascii34):**
FT-99 (Back everywhere), FT-100/D-07 (power per-item flow),
D-12 (reference card -- format decision pending)

---

## NOTES
- Highest-value finding this round: MB rootkit toggle verification --
  prevented shipping wrong guidance ("deep scan covers rootkits") that
  would have left every user's rootkit checking silently OFF.
- FT-94 is the most serious trust defect to date: the tool made a
  change without asking. Core promise is "nothing without your OK."
- FT-93 pattern (task errors across 3 builds) triggered PATTERN E rule.
- Website work advanced in parallel this session: 7 of 19 guide pages
  built (windows-update, defender-realtime, tamper-protection,
  smartscreen, phishing-protection, firewall, bitlocker).
- Website TODO logged: add MB deep-scan/rootkit guide page and Defender
  offline scan guide page; tool links directly to them once live.


---
---

# R2 ADDITIONS -- AFTERNOON SESSION 2026-07-19
(Everything below supersedes conflicting items above.)

## NEW DEFECTS (from comparison of test notes vs. morning catalog)

| ID | Sev | Description |
|----|-----|-------------|
| FT-104 | R | Silent termination mid-ConvenienceReview: 08:09 log ends 08:33:56 with NO footer after user stepped away. No ERROR line -- non-exception exit path (FT-82 family). Exit-path diagnosis required before fix (deferred to ascii34 boundary). Spawned rule C-21 (protection parity). |
| FT-105 | Y | Tamper Protection shows "Status: Unknown" though ON (Dell). VERIFIED FIX: Get-MpComputerStatus IsTamperProtected returned True on Dell. Detection switches to this API. MOVED INTO ascii33. |
| FT-106 | Y | Scope disclaimer references apps/files content after Apps Audit already ran (note 11). Deferred. |
| FT-107 | Y | Password-manager question re-asked on every resume (3x in one morning); answer not persisted with checkpoint. Deferred, related FT-102. |
| D-14 | list | P (page) vs B (back) key inconsistency (note 12). Deferred. |

Clarifications still owed by Bill: note 15 "change AND to N in quotes"
(unparseable); note 15 BitLocker "nothing came up" (logs show correct
already-encrypted behavior -- confirm resolved).

## FT-93 ROOT CAUSE -- DIAGNOSED (both bugs)
Bug 1: $false passed positionally to switch parameters at lines 3708 /
3756 (-WakeToRun $false, -RunOnlyIfNetworkAvailable $false) -> the
exact logged error. Rule C-14.
Bug 2 (FT-93b): -Once triggers dated in current year = tasks die after
2026 (quarterly: only Oct 1 2026 would ever fire); past dates may fire
immediately via -StartWhenAvailable. Fix: schtasks.exe /sc monthly
(natively recurring). Rule C-14a. Scheduled-task copy also carries
obsolete "Scan Now" wording -- rewritten in ascii33 with Custom Scan
steps.

## MB SCAN INVESTIGATION -- FINAL (supersedes morning section)
- Deep Scan does NOT check rootkits, toggle on or off (Dell reports
  7/16 + 7/19 re-run; IdeaPad 7/19). Deep-Scan-only guidance is dead.
- Custom Scan checkbox = only user-controllable rootkit scan; verified
  on Dell (5.6.2), IdeaPad (5.6.1), HP (5.5.7). Report line "Rootkits:
  Enabled" is the user verification.
- MBAMService holds SYSTEM power request during scans (powercfg,
  IdeaPad) -- sleep cannot interrupt; screen turns off normally
  (observed, HP). Overnight scans need zero settings changes. Lid-close
  UNVERIFIED -- instruction says leave lid open.
- D-15 locked: Custom first (all drives + rootkits), Deep after /
  overnight; 8 GB machines one scan per night. If threats found:
  Quarantine -> Deep Scan confirms (MB-official order).
- License strings in the wild: Trial / Expired / Free.

## SCAN TIME STATS (C-26)
| Scan | Machine | RAM | Rootkits | Objects | Drives | Duration |
|------|---------|-----|----------|---------|--------|----------|
| Threat | Dell | 32GB | Dis | 178,513 | -- | 2m15s |
| Deep | Dell | 32GB | Dis | 407,728 | C:+D: | 46m17s |
| Deep | Dell | 32GB | Dis | 412,776 | C:+D: | 43m25s |
| Custom | Dell | 32GB | En | 406,832 | C:+D: | 25m32s |
| Custom | IdeaPad | 8GB | En | 822,821 | C: | 56m27s |
| Deep | IdeaPad | 8GB | Dis | 821,838 | C: | 23m29s |
| Custom | HP | 8GB | En | 635,982 | C:+D: | 46m37s |
Durations invert between machines across scan types -- copy stays
machine-agnostic: "about 25 minutes to an hour depending on your PC."

## HP FIELD INCIDENT -- 18 PUP DETECTIONS
Custom Scan on HP found 18 dormant PUP installers on D: (13x
DllFilesFixer dupes, 3x Wave Browser, 1x TotalAV, 1x ZoomInfo),
"No Action By User" -- proving detection is not cleanup. Copy rule:
"Finding is not fixing -- quarantining is fixing." Cleanup: quarantine
all; check installed apps for Wave/TotalAV; Deep Scan to confirm.
HP behind on versions (MB 5.5.7, Win .8655) -- update. HP License:
Trial (mystery re-trial unresolved; stays out of guidance).

## MACHINE NAME MAPPING (authoritative)
CGDELL = Dell Latitude 5430 (32GB). SANDY = HP Notebook 17 (8GB).
Sandy3 = Lenovo IdeaPad (8GB). No Sandy2/Sandy4.

## RULES CREATED THIS SESSION (approved; full text in
## CodingStandards_Additions-2026-07-19.md)
C-14 switch params, C-14a schtasks, C-15 internal IDs never
user-facing (+display format: section label + step #), C-16 screen
header block, C-17 journey order, C-18 spaced stable numbering, C-19
reviewer test, C-20 skips acknowledged, C-21 protection parity, C-22
fix everywhere, C-23 read strings as user, C-24 scope names function,
C-25 error lines mean open, C-26 time attribution, C-27 hands off
third-party security settings.

## ASCII33 SCOPE -- LOCKED (10 items)
1. FT-93 + FT-93b schtasks rewrite (+ popup copy rewrite w/ Custom
   Scan steps)
2. FT-94 ConvenienceReview ask-before-apply
3. FT-95 ConvenienceReview copy rewrite
4. D-06 package: SCREEN-26/27 briefings, SCREEN-13 rewrite (Custom
   Scan + rootkit steps), Defender-first order, D-08 skip gate + C-20
   acknowledgements, D-13 log location early, D-10 wording
5. D-15 scan guidance copy incl. overnight + screen/lid lines +
   quarantine line
6. FT-96/97 status string fixes
7. FT-98 -> C-15 step counter (section label + step #)
8. FT-101 Mark-mode tip placement
9. FT-102 summary honors $HasPasswordManager
10. FT-105 IsTamperProtected detection
DEFERRED: FT-99, FT-100/D-07, FT-104 (diagnosis first), FT-106,
FT-107, D-14, D-12 build (txt default pending confirm), structure
pass (C-17/C-18 migration -- own build, no other changes).
