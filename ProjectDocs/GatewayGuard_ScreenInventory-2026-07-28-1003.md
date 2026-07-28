<!-- Dated: 2026-07-28 10:03 EDT -->
# GatewayGuard -- Master Screen Inventory
- **Document Name:** GatewayGuard_ScreenInventory
- **Last Modified:** 2026-07-28 10:03 EDT
- **Build inventoried:** `W11-SecurityHardening-v3-ascii36-2026-07-27-1655.ps1`
  (5,808 non-blank / 6,134 total lines, 0 parse errors)
- **Status:** Working document. Plain Markdown per CLAUDE.md scope exception
  (docs used at the keyboard carry no font or typography requirements).
- **Supersedes:** nothing. First complete screen inventory for the project.
- **Change History Log:**
  - 2026-07-28 10:03: Initial inventory. All 56 Draw-Box screens extracted
    in journey order with line numbers, render conditions, and current
    log IDs. Proposed IDs assigned to the 45 unnumbered screens.

---

## WHY THIS DOCUMENT EXISTS

Field note 3 (2026-07-27): *"we need screen numbering and then a digital
document listing all screens in order and then showing all screens in order.
Only way we will ever get this straight."*

This is the first half -- the ordered list. The second half (each screen's
actual rendered content, in order) is a separate document.

This also satisfies **CodingStandards gate 12**, which has been a mandatory
pre-build gate for some time and has never passed: *"Every Draw-Box screen
must log [SCREEN-NN] with its title. Master screen list maintained in build
header. Numbers are fixed forever -- new screens append at the end, never
renumber."*

---

## HEADLINE NUMBERS

| Measure | Count |
|---|---|
| Total Draw-Box screens in ascii36 | **56** |
| Screens that log a `[SCREEN-NN]` ID | **11** |
| Screens with **no** ID -- invisible in logs | **45** (80%) |
| Duplicate IDs | **1** (SCREEN-13 used twice) |
| Highest ID in use | **27** -- new IDs start at 28 |

---

## THREE FINDINGS THAT CHANGE THE FIX

### 1. The Defender/Malwarebytes "wrong order" has a different cause than assumed

Field note 3 said the Defender and MB screens were out of order, and that the
tool should explain Defender and MB *first*, then ask about the offline scan.

**The code already does that.** Main block, line 6027:

```powershell
if ($global:IsFirstRun -and -not (Test-CheckpointReached -Checkpoint "Briefing")) {
    Show-SecurityToolsBriefing   # SCREEN-26 -- explains Defender + MB
    Show-ScanPlanBriefing        # SCREEN-27 -- explains the scans
}
```

The briefing is gated on **first run only**. The 2026-07-27 session was a
repeat run (log: *"Repeat run -- user confirmed to continue"*), so
`$global:IsFirstRun` was false and **both briefing screens were skipped**.
Neither SCREEN-26 nor SCREEN-27 appears in either log from that date.

The sequence is not misordered. The explanation is conditional and the tester
was not receiving it. Same cause as the ascii34 test plan's note that
SCREEN-26/27 were *"not observed in any of four ascii33 logs."* Third
occurrence.

**Implication:** renumbering screens will not fix note 3. The briefing gate
is the fix. These are two separate defects that presented as one.

### 2. Six unnumbered mutually-exclusive screens in the AV check

`Test-DefenderPrimary` renders one of **six** different screens depending on
antivirus state. None carries an ID:

| Line | Screen | State it represents |
|---|---|---|
| 2138 | `!!!!! CRITICAL SECURITY WARNING !!!!!` | no AV protection at all |
| 2191 | `MALWAREBYTES TRIAL IS CURRENTLY HANDLING PROTECTION` | MB Premium trial active |
| 2254 | `OK ANTIVIRUS STATUS -- HEALTHY SETUP` | Defender primary + MB companion |
| 2286 | `! MICROSOFT DEFENDER IS NOT YOUR PRIMARY ANTIVIRUS` | third-party AV present |
| 2326 | `ANTIVIRUS STATUS -- MALWAREBYTES IS ON DUTY` | MB registered as primary |
| 2348 | `!! DEFENDER REAL-TIME PROTECTION IS OFF` | Defender RT disabled |

This is the single largest blind spot in the tool. When an unexpected AV
screen appears, there is currently no way to determine from the log which of
the six fired. Numbering these is the highest-value part of the work.

### 3. Log IDs do not follow journey order -- and that is correct

SCREEN-25 renders first (resume prompt), SCREEN-01 second. SCREEN-26/27
render before SCREEN-10.

This is not a defect. It is the "numbers are fixed forever, new screens
append at the end" rule working as designed -- 25, 26 and 27 were added after
01-24 already existed. **Do not renumber to fix this.** The ID is a stable
identifier, not a position. Journey position is what this document provides.

---

## OPEN DESIGN QUESTION -- NEEDS BILL'S DECISION

The ascii35 candidate list (FieldTestPlan-ascii34, line 217) scopes screen
numbering in three parts:

- **(a)** display the ID on screen to the user
- **(b)** fill the gaps so every screen logs an ID
- **(c)** fix the duplicate SCREEN-13

**Parts (b) and (c) are uncontroversial** -- additive `Write-Log` lines, no
layout risk, no rule conflict. This document supplies everything needed to
do them.

**Part (a) conflicts with an existing standard.** CodingStandards gate 18 /
C-15 states: *"Internal ID -> log only: [SCREEN-13]. User display -> runtime
counter only. No screen, prompt, or message ever shows an internal ID to
user."* Part (a) asks for exactly what that rule prohibits.

Both positions are defensible. The rule exists so users never see confusing
internal numbers with gaps in them. The request exists so a user on a support
call can say which screen they are stuck on -- and it is a stated **launch
requirement**.

A possible resolution, for consideration only -- not adopted: show a
**support code** rather than the internal ID, e.g. `[GG-13]` in a footer,
where the code equals the SCREEN-NN. That satisfies the support-call need
while keeping the "no bare internal IDs in prose" intent. This needs Bill's
ruling before any screen-render code changes.

**Do not begin part (a) until this is settled.**

---

## PHASE 1 -- PRE-FLIGHT SEQUENCE

Driven by the main block, lines 5981-6083. "Step" numbers are the author's
own comment numbering in that block.

| # | Screen title | Function | Line | Log ID | Renders when |
|---|---|---|---|---|---|
| 1 | WELCOME BACK | Show-ResumePrompt | 1521 | **SCREEN-25** | always (step 0) |
| 2 | IMPORTANT -- HOW TO RUN GATEWAYGUARD CORRECTLY | Show-FontInstructions | 1035 | **SCREEN-01** | fresh run only |
| 3 | FONT CHECK: If this box has clean lines... | Show-FontInstructions | 1111 | *proposed 28* | fresh run only |
| 4 | BEFORE YOU START -- WINDOW SETUP (Screen 4 of 5) | Show-FontInstructions | 1118 | *proposed 29* | fresh run only |
| 5 | WHAT HAPPENS NEXT -- PLEASE READ (Screen 5 of 5) | Show-FontInstructions | 1154 | *proposed 30* | fresh run only |
| 6 | HOW TO SCROLL BACK (AND COPY) IN THIS WINDOW | Show-ScrollCopyTip | 1623 | **SCREEN-02** | fresh run only |
| 7 | QUICK RE-CHECK BEFORE RESUMING | Show-ResumeReverify | 1568 | *proposed 31* | **resume only** |
| 8 | ! IMPORTANT -- READ BEFORE CONTINUING | Test-PersonalComputer | 1207 | **SCREEN-05** | fresh run only |
| 9 | ! THIS PC APPEARS TO BE DOMAIN-JOINED | Test-DomainJoin | 1264 | *proposed 32* | only if domain-joined |
| 10 | ! ADMINISTRATOR ACCESS REQUIRED | Test-AdminAccess | 1307 | *proposed 33* | only if not admin |
| 11 | WINDOWS EDITION DETECTED | Get-WinEdition | 1387 | *proposed 34* | always (step 6) |
| 12 | YOUR PC -- RAM: n GB | Get-RAMStatus | 1417 | *proposed 35* | always (step 7) |
| 13 | ! TIME/DATE SYNC ISSUE DETECTED | Test-TimeDateSync | 1667 | *proposed 36* | only if clock wrong |
| 14 | FIX THE TIME NOW? | Test-TimeDateSync | 1708 | *proposed 37* | only if clock wrong |
| 15 | YOUR SYSTEM AT A GLANCE | Show-SystemBaselineSummary | 1824 | **SCREEN-09** | unless Baseline checkpoint |
| 16 | YOUR PC'S SECURITY TOOLS -- A QUICK INTRODUCTION | Show-SecurityToolsBriefing | 1852 | **SCREEN-26** | **FIRST RUN ONLY -- see finding 1** |
| 17 | THE SCANS WE RECOMMEND -- AND WHY | Show-ScanPlanBriefing | 1894 | **SCREEN-27** | **FIRST RUN ONLY -- see finding 1** |
| 18 | BEFORE WE SCAN YOUR PC | Show-PreScanGate | 1946 | **SCREEN-10** | unless OfflineScanDone |
| 19 | DEFENDER OFFLINE SCAN | Show-PreScanGate | 2005 | *proposed 38* | unless OfflineScanDone |
| 20 | REMINDER: PRE-SCAN RECOMMENDED | Show-PreScanGate | 2049 | *proposed 39* | repeat runs |
| 21 | WELCOME BACK -- OFFLINE SCAN COMPLETE | Show-PostScanGuidance | 2075 | *proposed 40* | after offline-scan reboot |
| 22 | !!!!! CRITICAL SECURITY WARNING !!!!! | Test-DefenderPrimary | 2138 | *proposed 41* | no AV at all |
| 23 | MALWAREBYTES TRIAL IS CURRENTLY HANDLING PROTECTION | Test-DefenderPrimary | 2191 | *proposed 42* | MB trial active |
| 24 | OK ANTIVIRUS STATUS -- HEALTHY SETUP | Test-DefenderPrimary | 2254 | *proposed 43* | Defender primary + MB companion |
| 25 | ! MICROSOFT DEFENDER IS NOT YOUR PRIMARY ANTIVIRUS | Test-DefenderPrimary | 2286 | *proposed 44* | third-party AV |
| 26 | ANTIVIRUS STATUS -- MALWAREBYTES IS ON DUTY | Test-DefenderPrimary | 2326 | *proposed 45* | MB primary |
| 27 | !! DEFENDER REAL-TIME PROTECTION IS OFF | Test-DefenderPrimary | 2348 | *proposed 46* | Defender RT off |
| 28 | MALWAREBYTES NOT DETECTED | Show-MalwarebytesFollowUp | 2400 | **SCREEN-13** | MB not found |
| 29 | MALWAREBYTES DETECTED ON THIS PC | Show-MalwarebytesFollowUp | 2428 | **SCREEN-13 (DUPLICATE)** | MB found |
| 30 | MALWAREBYTES TRIAL -- WHAT TO EXPECT | Show-MalwarebytesFollowUp | 2497 | *proposed 47* | MB trial active |
| 31 | AFTER THE CUSTOM SCAN -- RUN THE DEEP SCAN OVERNIGHT | Show-MalwarebytesFollowUp | 2526 | *proposed 48* | after custom scan |
| 32 | ! RUNNING ON BATTERY POWER | Test-PowerStatus | 2592 | *proposed 49* | fresh run + on battery |
| 33 | POWER SETTINGS -- SECURITY REVIEW | Run-PowerSettingsCheck | 2761 | *proposed 50* | unless PowerSettings checkpoint |
| 34 | APPS AUDIT RESULTS | Run-AppsAudit | 3124 | *proposed 51* | unless AppsAudit checkpoint |
| 35 | GatewayGuard ... Tool v3.1 (mode selector) | Show-ModeSelector | 5081 | *proposed 52* | always |

**Duplicate-ID resolution for #29:** SCREEN-13 stays with "MALWAREBYTES NOT
DETECTED" (line 2400), which is the older assignment. "MALWAREBYTES DETECTED
ON THIS PC" (line 2428) takes a new ID. This preserves the meaning of
SCREEN-13 in all historical logs, including the 2026-07-27 run.

---

## PHASE 2 -- CONSOLE MODE

Driven by `Run-ConsoleMode`, lines 5113-5592. This is mode 1, the path taken
in every field log to date.

| # | Screen title | Function | Line | Log ID | Renders when |
|---|---|---|---|---|---|
| 36 | QUICK QUESTION -- YOUR PASSWORDS | Show-ScopeDisclaimer | 4062 | *proposed 53* | always |
| 37 | WHAT THIS TOOL DOES AND DOES NOT DO | Show-ScopeDisclaimer | 4101 | *proposed 54* | always |
| 38 | REVIEW YOUR SELECTIONS -- NO CHANGES MADE YET | Run-ConsoleMode | 5310 | *proposed 55* | always (main checklist) |
| 39 | HEADS UP -- SOME SECURITY-CRITICAL ITEMS ARE NOT SELECTED | Test-NonRecommendedSelections | 3679 | *proposed 56* | critical item deselected |
| 40 | WHAT EACH ITEM DOES -- AND WHY IT IS RECOMMENDED | Test-NonRecommendedSelections | 3706 | *proposed 57* | user presses S |
| 41 | HEADS UP -- YOU HAVE NOT SELECTED DRIVE ENCRYPTION | Show-BitLockerDeclineHeadsUp | 4663 | *proposed 58* | BitLocker deselected |
| 42 | ALREADY CORRECT -- AUTO-SKIPPED (n items) | Run-ConsoleMode | 5519 | *proposed 59* | any GOOD items exist |
| 43 | DRIVE ENCRYPTION (BitLocker) -- WHAT IT IS, WHY IT MATTERS | Show-BitLockerWhyEncrypt | 4596 | *proposed 60* | BitLocker reached |
| 44 | FINAL ITEM: DEVICE ENCRYPTION (Windows 11 Home) | Show-BitLockerHomeScreen | 4722 | *proposed 61* | **Home edition only** |
| 45 | YOUR PC MEETS THE REQUIREMENTS | Show-BitLockerHomeScreen | 4747 | *proposed 62* | Home + prereqs pass |
| 46 | DEVICE ENCRYPTION MAY NOT BE AVAILABLE ON THIS PC | Show-BitLockerHomeScreen | 4763 | *proposed 63* | Home + prereqs fail |
| 47 | !! BITLOCKER REQUIRES AC POWER | Show-BitLockerScreen | 4824 | *proposed 64* | Pro + on battery |
| 48 | BEFORE ENABLING BITLOCKER, YOU MUST: | Show-BitLockerScreen | 4876 | *proposed 65* | Pro edition |
| 49 | FINAL ITEM: BitLocker / Device Encryption | Show-BitLockerScreen | 4925 | *proposed 66* | Pro edition |
| 50 | ! BITLOCKER RECOVERY KEY -- CRITICAL ACTION REQUIRED | Show-BitLockerScreen | 5032 | *proposed 67* | encryption started |
| 51 | YOUR CHOICE IS NOTED -- NO ENCRYPTION WILL BE APPLIED | Show-BitLockerFinalDecline | 4632 | *proposed 68* | BitLocker declined |
| 52 | ALL SELECTED ITEMS PROCESSED | Run-ConsoleMode | 5559 | *proposed 69* | always |
| 53 | AUTOMATED SCAN SCHEDULE SETUP | Setup-ScheduledTasks | 4393 | *proposed 70* | always |
| 54 | CONVENIENCE CHOICES -- NOTHING CHANGED YET | Show-ConvenienceReview | 4232 | **SCREEN-23** | always |
| 55 | YOUR CHOICE [n of m]: (item name) | Show-ConvenienceReview | 4256 | *proposed 71* | per convenience item |
| 56 | AUTOMATED STEPS COMPLETE | Show-ManualSteps | 4302 | *proposed 72* | always |

---

## KNOWN GAP IN THIS INVENTORY

`Run-GUIMode` (lines 5593-6075, mode 2) has **not** been inventoried. Every
field log to date uses mode 1 (Console), so the console path was covered
first. GUI mode needs its own pass before the numbering work is called
complete. Flagged rather than silently omitted.

---

## WHAT TO DO WITH THIS DOCUMENT

1. **Review the proposed IDs 28-72.** They are assigned in journey order
   purely for readability; any ordering works, since IDs are identifiers and
   not positions. Only requirement: never reuse or renumber once shipped.
2. **Settle the part (a) design question above** before any screen-render
   code is touched.
3. **Parts (b) and (c) can proceed immediately** -- 45 additive `Write-Log`
   lines and one duplicate resolution. No layout risk, satisfies gate 12.
4. **Treat finding 1 as a separate defect** from numbering. The briefing gate
   at line 6027 is what produced note 3, and renumbering will not address it.
5. The companion document -- each screen's rendered content, in this order --
   is the second half of field note 3's request.
