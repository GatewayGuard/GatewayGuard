<!-- Dated: 2026-07-30 15:18 EDT -->
# GatewayGuard Test History -- ascii38

- **Document Name:** GatewayGuard_TestHistory-ascii38
- **Last Modified:** 2026-07-30 15:18 EDT
- **Status:** Cumulative Master Document
- **Change History Log:**
  - 2026-07-30 15:18: Initial file. HP SANDY field run (2026-07-30,
    10:51-13:52), three logs plus numbered field notes. FT-110 and FT-109
    CLEARED. New defects FT-146 through FT-152. Findings FT-140 through
    FT-145 (Dell, 2026-07-29 diagnostic session) filed here for the record.

**Build under test:** `Tool\W11-SecurityHardening-v3-ascii38-2026-07-29-1830.ps1`
**Build date:** 2026-07-29 18:30 ET (7,159 non-blank / 7,505 lines, 0 parse errors)
**Field test date:** 2026-07-30, 10:51-13:52
**Test machine:** HP Laptop 17-by1xxx (SANDY) -- Win 11 **Home**, 8 GB, build 26200
**MachineID:** F7F13A97D58D
**MB state:** Installed 5.6.3.277, **registered in SecurityCenter2** (productState 393216)
**Tester:** William F. Burns III
**Logs:** 3 (10:51, 12:29, 13:41) + `Ascoo38-Test-HP-Sandy-2026-07-30=1045.txt`

**UNRUN BUILD RULE:** **CLEARED.** ascii38 field-run with uploaded logs.
ascii39 scoping may open.

> **Note on the backlog this clears.** ascii34, ascii35, ascii36 and ascii37
> never received a TestHistory document. This is the first since ascii33
> (2026-07-21). It does not retroactively clear those builds -- it clears
> ascii38, and closes two items that had been carried since ascii33.

---

## 1. THE HEADLINE -- TWO LONG-STANDING BLOCKERS CLEARED

### FT-110 / D-20 -- Windows 11 Home BitLocker path: **PASS**

Open since 2026-07-21 (ascii33). Blocked from testing since 2026-07-25
because no unencrypted Home machine was available. Log 13:41:

```
[13:43:32] [SCREEN-61] (shown as screen 12) FINAL ITEM: DEVICE ENCRYPTION (Windows 11 Home)
[13:43:33] [GOOD]  Device Encryption prereq check -- TPM: True, SecureBoot: True, WinRE: True
[13:43:33] [SCREEN-62] (shown as screen 13) YOUR PC MEETS THE REQUIREMENTS
[13:43:33] [SKIP]  BitLocker/Device Encryption: Home edition -- manual path shown, no changes made by this tool
```

Every pass condition met:

| Condition | Result |
|---|---|
| Home branch renders | PASS -- SCREEN-61 |
| `Enable-BitLocker` never called | PASS -- no call, `[SKIP]` logged instead |
| 0x8031005A never appears | PASS -- absent from all three logs |
| Three prerequisites checked and shown | PASS -- TPM/SecureBoot/WinRE, all True |
| Tells user to sign in with a Microsoft account | PASS -- SCREEN-62 |

**Not yet verified:** that the recovery key actually lands at
account.microsoft.com/devices/recoverykey. Sandy was NOT encrypted during
this run, so nothing was escrowed to check. That half stays open and is
tracked under FT-144.

### FT-109 -- Scheduled tasks: **PASS** (first success in five builds)

```
[13:51:57] [GOOD] Scheduled task created: GatewayGuard - Quarterly Defender Offline Scan
[13:51:57] [GOOD] Scheduled task created: GatewayGuard - Monthly Malwarebytes Reminder
```

The Quarterly Defender Offline Scan has failed in **every** build since
ascii32 -- the FT-73 / FT-76 / FT-93 / FT-109 lineage, four consecutive
builds of task-creation errors. Both tasks now report GOOD with no ERROR
line anywhere in the run.

**STILL OPEN under C-25 / gate 21.** A clean build is not evidence of a
working feature. This item does not close until Task Scheduler is opened on
SANDY and both tasks are confirmed present with correct actions. That check
has not been done.

---

## 2. RUN SUMMARY

| Log | Start | End | Path | Exit |
|---|---|---|---|---|
| 10:51 | 10:51:11 | 11:40:00 | Fresh start (S) -> font screens -> personal/admin/edition/RAM -> time sync -> baseline -> **briefings** -> pre-scan -> AV healthy -> **MB detected** -> power -> apps audit -> mode select -> checklist | **ABNORMAL** -- no footer, no exit line. Ends on repeated checklist renders at width 86 |
| 12:29 | 12:29:33 | 13:35:02 | Resume (AppsAudit) -> re-check -> edition -> RAM -> mode -> passwords -> scope 1/2 + Back + 2/2 -> checklist page flips | **ABNORMAL** -- Ctrl+C in Mark mode. **Footer WAS written** by the PowerShell.Exiting last-resort handler |
| 13:41 | 13:41:59 | 13:52:27 | Resume (AppsAudit) -> ... -> checklist -> N, 8, R -> HEADS UP -> review -> HEADS UP -> **BitLocker Home** -> **tasks created** -> look-back opened | **ABNORMAL** -- **no footer at all.** Last line is `Look-back opened at: Setup-ScheduledTasks` |

**The difference between logs 2 and 3 matters diagnostically.** Log 2's
Ctrl+C exit still produced a footer, because the `PowerShell.Exiting` engine
event fired (FT-113 working as designed). Log 3 produced nothing at all --
the process died in a way that bypassed even the Exiting handler.

### THE CRASH, RESOLVED -- it was not a Checkup fault

**Evidence (`Cmd-CRash-Check-3.txt`, 500-event dump of
Microsoft-Windows-PowerShell/Operational on SANDY):**

| Time | Event | Meaning |
|---|---|---|
| 13:42:32-33 | dozens of 4104 + one 4103 | Add-Type compiling repeatedly (see FT-148) |
| 13:42:57 | **one** 4100 Warning "Error Message = System error" | a swallowed pipeline error -- see FT-159 |
| **13:52:27** | **NOTHING** | the crash moment |
| 16:38:54-55 | 40961 / 53504 / 40962 | a later, unrelated session starting |

**There is no PowerShell event of any kind at 13:52.** An unhandled
exception in `Show-LookBack` -- or anywhere else in the script -- would have
written a 4100 error event. None exists.

That is the signature of an **external process kill**: `CTRL_CLOSE_EVENT`,
raised by clicking the window's X. It produces no PowerShell error record and
does not reliably run the `Exiting` handler, which is exactly why log 3 has
no footer while log 2's Ctrl+C exit does.

**The tester's own hypothesis was correct** -- "I believe I caused the last
crash with an inadvertent pass over the X in the top right hand part of the
terminal window." Recorded because the initial analysis in this document
blamed ascii38's look-back code, and that was wrong.

**Consequences:**
1. FT-147 is a latent defect, not this crash. Fix it anyway.
2. **Look-back is not implicated in the crash at all.** FT-146 remains open on
   its own merits (the navigation is wrong), but it is not a crash risk on
   this evidence, which lowers its priority relative to FT-149 and FT-150.
3. **A stray click on the X kills the tool with no footer.** That is worth
   its own item -- a senior brushing the close button loses their session
   silently. See FT-160.

---

## 3. ascii38 SCOPE ITEMS -- FIELD VERDICTS

| Item | Verdict | Evidence |
|---|---|---|
| **FT-132** screen numbers track position | **PASS** | Screens numbered 1..17 sequentially in log 10:51; `[SCREEN-25] (shown as screen 1)`, `[SCREEN-02] (shown as screen 5)`. Tester's notes cite screen numbers throughout -- the stated purpose of the change |
| **FT-133** look-back | **FAIL** | Opened 4 times across the run. Notes 4, 5, 6 describe it misbehaving at every use. See FT-146, FT-147 |
| **FT-134** Pause default message + Back offer | **PARTIAL** | Back offer appears everywhere as intended, but the offer is made on screens where look-back then fails (FT-146) |
| **FT-135** write-loop stall mitigation | **PASS on stall, FAIL on noise** | `Get-AllStatuses` completed in 7s (12:30:37-44) and 7s (13:42:26-33) vs 15m42s in ascii37. But logs "QuickEdit mode disabled" **20 times per run** -- see FT-148 |
| **FT-136** Checkup rename | **PARTIAL** | Log header and mode selector correct. Note 6: a screen "uses the term tool not Checkup". See FT-152 |
| **FT-137** Gallery mode | **NOT TESTED** | Not exercised this run |
| **FT-138** gate-12 coverage check | **PASS** (build-time) | 58 Draw-Box screens, 58 tagged, 0 duplicates, + 2 hand-drawn |
| **FT-121** briefing gate (ascii37) | **PASS** | SCREEN-26 and SCREEN-27 rendered as screens 10 and 11 |
| **FT-125** checklist instrumentation (ascii37) | **PASS** | Every render and command logged with page, width and selection count. This is what made the width-86 truncation diagnosable |
| **FT-113** footer on abnormal exit (ascii34) | **PARTIAL** | Worked for Ctrl+C (log 2), failed entirely for the crash (log 3) |

---

## 4. NEW DEFECTS -- ascii38 FIELD RUN

### BLOCKERS

| ID | Note/Log | Description | Planned fix |
|---|---|---|---|
| **FT-147** | Log 13:41 | **DOWNGRADED 2026-07-30 17:20 -- this is a latent defect, NOT the cause of the crash.** `$Host.UI.RawUI.ReadKey` inside `Show-LookBack` has **no try/catch**, reintroducing the exact ascii23 FT-01 defect the checklist loop carries a long comment about. It will bite on a focus loss or resize eventually. It did not bite here -- see "THE CRASH, RESOLVED" below. | Wrap every ReadKey in `Show-LookBack` with the same protection pattern used by Read-ValidKey / Pause-ForUser / the checklist reader. |
| **FT-149** | Note 7, log 11:27:39-42 | **Keypresses queue and skip screens.** Log shows MB DETECTED -> N -> Continue -> power settings -> N -> N -> Continue -> apps audit -> Continue inside **three seconds**. The tester cannot have read those screens. Note 7: "Space bar caused something to flash by perhaps more then one screen." A user can skip past security decisions without seeing them. | Root-cause whether this is buffered input, auto-repeat, or a missing drain. FT-29 forbids a global pre-read flush; the FT-65 targeted post-accept drain is the sanctioned pattern. |
| **FT-150** | Note 21, log 12:29 | **Ctrl+C in Mark mode terminates the tool.** Tester turned on Mark to copy (as OUR OWN copy tip instructs), copy did not work, Ctrl+C ended the program. FT-112's protection does not hold in Mark mode. The tool's own guidance leads users into this. | Either make Mark-mode copy work as documented, or stop telling users to use Mark mode and provide a different copy route (e.g. write the screen to a file on demand). |

### FIX BEFORE LAUNCH

| ID | Note/Log | Description | Planned fix |
|---|---|---|---|
| **FT-146** | Notes 4, 5, 6 | **Look-back navigation is wrong in practice.** "Can't go back because screen size was changed" on first use; a Back offer that immediately answers "this is as far back as you can go"; space returning the user to "is this your personal computer?" to re-answer; and after going forward and back again, that screen is skipped. The snapshot/restore primitive works in isolation (proven 2026-07-29) but the navigation around it does not. | Redesign. The buffer-snapshot approach is fragile against resize and does not model "where am I". Reconsider against a simple screen-history of Draw-Box definitions plus explicit re-render, accepting that loose Write-Host lines are lost, OR gate look-back to screens where it can be exact. |
| **FT-151** | Note 14, logs | **FT-117 recurrence: status column truncated at BOTH widths.** Missing characters on items 6, 8, 9 in the status column and item 7b on the left. At window width 86 the split gives name 45 / status 30, and "Not configured -- all 3 need to be enabled" is 41 characters. Tester: "need to expand/widen to accommodate length. there is room." He is right -- the 60/40 split is **fixed**, not content-driven, so the name column holds slack the status column needs. | Size both columns from actual content each render, with the status column taking priority (statuses are gate-consumed strings; names are not). |
| **FT-148** | Logs + `Cmd-CRash-Check-3.txt` | **20 C# COMPILATIONS PER RUN, not just log spam.** `Disable-QuickEdit` calls `Add-Type -MemberDefinition` every time it runs, compiling the kernel32 P/Invoke wrapper from source. ascii38's FT-135 fix calls it **once per item**, so `Get-AllStatuses` compiles the same type 19-20 times. Windows' own event log confirms it: dozens of 4104 "Creating Scriptblock text" plus 4103 CommandInvocation(Add-Type) all inside one second at 13:42:32-33. Costly on an 8 GB machine, and it floods both our log and the OS event log. Introduced by ascii38. | Cache the compiled type in a script variable and reuse it; log the QuickEdit line once per session, not once per item. |
| **FT-159** | `Cmd-CRash-Check-3.txt` | **A swallowed PowerShell error during the run.** One 4100 Warning, "Error Message = System error", at **13:42:57** -- precisely the HEADS UP -> review handoff (`Key 'Y' at Test-NonRecommendedSelections` -> `SCREEN-55 REVIEW YOUR SELECTIONS`). Nothing about it reaches the Checkup log. A Class 1 invisible failure: the tool generated a real error and carried on silently. Full message text not yet captured. | Capture the full 4100 message, locate the swallowing `-EA SilentlyContinue` or empty catch in that path, and make it log. |
| **FT-160** | Crash analysis | **A stray click on the window's X kills Checkup with no footer.** Confirmed cause of the 13:52 crash. `CTRL_CLOSE_EVENT` bypasses the `PowerShell.Exiting` handler, so FT-113's footer safety net does not fire. A senior brushing the close button loses their session and their log ends mid-sentence. | Register a `CTRL_CLOSE_EVENT` / `SetConsoleCtrlHandler` handler so the footer and cleanup still run in the grace period Windows allows (~5s). Cannot prevent the close -- but the log must not end silently. |
| **FT-152** | Note 6 | **Rename incomplete.** At least one screen still says "tool" where it should say "Checkup". The ascii38 rename covered 32 asserted strings; this was not among them. | Re-audit user-facing strings for "tool" used as the product name (distinct from "tool" used generically). |

### COPY / MINOR

| ID | Note | Description |
|---|---|---|
| **FT-153** | 3, 10, 11, 22 | Screens still too long: font screen 4 of 5; "what this tool does" 1 of 2 last line needs 3 bullets with blank lines; SCREEN-61 Device Encryption. **New rule from Bill: 26 lines maximum per screen, and every screen ends with a blank line.** Supersedes ascii37 note 12's 25-line rule. |
| **FT-154** | 7 | Pre-scan screen still lists Malwarebytes before Defender. Defender must read first. Carried from ascii37 note 6, still open. Check the guide carries the same order. |
| **FT-155** | 14 | Item 6 status label should read "edge phishing protection", not the current wording. Related to FT-142. |
| **FT-156** | 22 | Device Encryption screen copy is inadequate: no step-by-step for signing in to a Microsoft account; no answer for users who do not have one; does not say whether the recovery key is saved before or after encryption; does not tell the user how to check whether encryption is running; does not say whether to reboot or quit Checkup. Tester: "Users will feel lost." Also: expanding the window turns this screen "into an unreadable mess". |
| **FT-157** | 6 | Remote Desktop claimed unavailable on Home. Tester supplied two sources suggesting otherwise -- needs research before the claim ships. |
| **FT-158** | 21 | Ctrl+Z in the admin terminal erases rather than undoing (environment note, not a Checkup defect -- recorded so it is not re-reported). |

---

## 5. CARRIED FROM THE 2026-07-29 DIAGNOSTIC SESSION (Dell + Sandy)

Filed here for the record. Found by direct measurement, not by a Checkup run.

| ID | Description | Status |
|---|---|---|
| **FT-140** | **Malwarebytes detection uses SecurityCenter2 registration as a proxy for "installed".** MB **deregisters from SC2 when its trial expires.** Dell (trial expired): absent from SC2, MB 5.6.3.277 installed and MBAMService running, Checkup reports NOT DETECTED and offers a download. Sandy (registered, productState 393216): Checkup correctly reports DETECTED this run. **The bug is invisible during evaluation and universal afterwards** -- every user reaches trial-expiry. | Confirmed on two machines |
| **FT-141** | **Item 6 reports "Not configured" from a check that was BLOCKED.** `WTDS\Components` read with `-EA SilentlyContinue`; Tamper Protection throws SecurityException; null falls through to a definite BAD. Reproduced on **both** machines. Since Tamper Protection is something Checkup **recommends turning on**, this read can never succeed for a correctly-hardened user -- the detection method is unusable, not merely fragile. | Confirmed both machines |
| **FT-142** | Tool calls the third phishing toggle "unsafe apps"; the on-screen label is "Warn me about unsafe password storage". CLAUDE.md requires literal on-screen labels be exact. Sandy's real state captured in note 20. | Open |
| **FT-143** | **Secure Boot is only checked on Home, inside the BitLocker prerequisite block.** On Pro that code never runs, so Secure Boot being **Off on the Dell** has never been surfaced in 38 builds. Its fix must be gated behind recovery-key retrieval -- changing Secure Boot on an encrypted machine can trigger a BitLocker recovery prompt. | Open |
| **FT-144** | **Home Device Encryption can start with no recovery key anywhere.** Field-confirmed 2026-07-29: Sandy encrypted on a **local account**, with no key in any Microsoft account. Windows prompts for a Microsoft account but does not require one before encrypting. Checkup must detect local vs Microsoft account (`Get-LocalUser | Where PrincipalSource`) and treat the key check as a **precondition**, not a follow-up. Also: user must be **online** when enabling, or the key cannot be uploaded. | Open |
| **FT-145** | **Windows shows a progress bar when encrypting and nothing when decrypting.** Tester was left unable to determine whether it was safe to reboot. Checkup can report `ConversionStatus` / `EncryptionPercentage` in three lines and fill a gap Windows leaves open on the exact edition our users have. | Open |

---

## 6. CONFIRMED WORKING (this run)

- **Fresh-start path end to end** -- font screens, personal computer check,
  admin, edition, RAM, time sync, baseline, briefings, pre-scan gate
- **Resume path, twice** (both from AppsAudit)
- **Screen numbering** -- sequential, no gaps, revisits keep their number
- **Briefing screens on a resumed/repeat run** (FT-121, third-occurrence
  defect, now closed)
- **Home edition detection** -- `Core` -> "Windows 11 Home", correct
- **Malwarebytes DETECTED** on a machine where it is registered (SCREEN-73)
- **Antivirus status HEALTHY SETUP** (SCREEN-43) -- Defender primary, MB companion
- **Memory Integrity "OFF -- needs attention"** -- correct for Sandy, and the
  fix that closes FT-115
- **Wake on LAN "Enabled"** -- correct; Ethernet has Magic Packet and Pattern
  Match on even though the link is down (the FT-120b fix working on different
  hardware, with a USB adapter reporting "Unsupported" and not misread)
- **HEADS UP + review + second HEADS UP** flow
- **Device Encryption Home branch** (FT-110)
- **Both scheduled tasks created** (FT-109)
- **Checklist instrumentation** -- page, width, selection count on every render
- **Footer on Ctrl+C exit** with a named caller

---

## 7. STATE MATRIX COVERAGE

| State | Covered | Machine |
|---|---|---|
| Win 11 **Home** | **YES -- first time** | SANDY |
| Win 11 Pro | YES | CGDELL |
| Home + **unencrypted** | **YES -- first time** | SANDY |
| Home + already encrypted | YES (diagnostic only) | Sandy3 (IdeaPad) |
| Pro + already encrypted | YES | CGDELL |
| MB **registered** in SC2 | **YES -- first time** | SANDY |
| MB installed but **deregistered** (trial expired) | YES (diagnostic only) | CGDELL |
| Secure Boot **On** | YES | SANDY |
| Secure Boot **Off** | YES | CGDELL |
| Kernel DMA Protection On / Off | YES / YES | CGDELL / SANDY |
| Memory Integrity running / off | YES / YES | CGDELL / SANDY |
| Defender **stopped** (finding 3.8) | **NO** | none available |
| Local account | YES | SANDY |
| Microsoft account | YES | CGDELL |

---

## 8. MACHINE DATA CAPTURED (for C-26 and future reference)

**SANDY** -- HP Laptop 17-by1xxx, 8 GB, Win 11 Home build 26200, SKU 101,
EditionID `Core`. TPM True, Secure Boot **On**, WinRE configured, Kernel DMA
Protection **Off**, VBS not enabled, Automatic Device Encryption Support
"Meets prerequisites". Tamper Protection True. MB 5.6.3.277 registered in
SC2. Local account. Ethernet (Realtek) Magic Packet + Pattern Match Enabled;
TP-Link USB WiFi reports wake properties "Unsupported".

**Sandy's real security settings** (note 20, the pairing the registry could
not give us because the key is tamper-blocked):

- Smart App Control / Balanced protection from untrusted apps: **off**
- SmartScreen for Microsoft Edge: **off**
- Phishing protection: **on**; "warn me about malicious apps and sites"
  **checked**; "warn me about password reuse" **not checked**; "warn me about
  unsafe password storage" **not checked**; "automatically collect website or
  app content when additional analysis is needed" **checked**
- Potentially unwanted app blocking: **on**
- SmartScreen for Microsoft Store apps: **on**
- Edge: password saving **off**, startup boost **off** -- and **neither
  appears in the Edge Preferences file**, while the Dell (password saving off)
  **does** have `credentials_enable_service = False`. Inconsistent across two
  machines; see open question 3.

---

## 9. OPEN QUESTIONS

1. **FT-109 is not closed.** Open Task Scheduler on SANDY and confirm both
   GatewayGuard tasks exist with correctly quoted action paths (C-25).
2. **FT-110's second half is not closed.** The recovery key reaching
   account.microsoft.com/devices/recoverykey has still never been observed,
   because Sandy was unencrypted during the run and is on a local account.
3. **Edge settings cannot be read reliably.** `startup_boost_enabled` is
   absent on both machines despite boost being off on both -- so it is the
   wrong key. `credentials_enable_service` is present on the Dell and absent
   on Sandy despite the same UI state. Per RESEARCH BEFORE STATING and gate
   13, items 13 and 15 should keep reporting **Unknown** with manual steps
   rather than be coded against this.
4. **Finding 3.8 remains untestable** -- no machine with Defender stopped.
5. **Note 7's "flash by" and the 11:27 burst** -- is FT-149 buffered input,
   auto-repeat, or something else? Needs a deliberate reproduction.
6. **Remote Desktop on Home** (FT-157) -- tester supplied two sources
   contradicting our claim. Research before the copy ships.

---

## 10. ascii39 SCOPE (draft -- pending scoping session)

**Blockers first -- all three are regressions or hazards introduced or
exposed by ascii38, and two of them are in code added by ascii38:**

| Item | Type |
|---|---|
| FT-149 keypresses skipping screens | Input handling -- users can miss security decisions. **Now the top blocker**, since the crash turned out not to be ours |
| FT-150 Ctrl+C kills the tool in Mark mode | Input handling -- our own copy tip causes it |
| FT-160 X-click kills the tool with no footer | Console control handler -- cannot prevent, must survive it |
| FT-159 swallowed error at the review handoff | Class 1 -- a real error the tool hid |
| FT-148 20 C# compilations per run | Regression introduced by ascii38 |
| FT-147 unguarded ReadKey in look-back | Latent -- fix, but it did not cause the crash |
| FT-146 look-back navigation redesign | Design decision. **Priority lowered** -- annoying, not dangerous |

**Detection truthfulness (the FT-120 family, now five instances):**
FT-140 (Malwarebytes), FT-141 (phishing blocked read), FT-143 (Secure Boot
never checked on Pro).

**Home encryption safety:** FT-144 (key as precondition, local-account
detection, online requirement), FT-145 (conversion progress), FT-156 (the
screen's copy).

**Layout and copy:** FT-151 (content-driven columns), FT-153 (26-line rule +
trailing blank line), FT-152 (rename misses), FT-154, FT-155, FT-148.

**Deliberately NOT in ascii39 unless Bill says otherwise:** the Gallery is
untested (FT-137) and should be exercised before more work lands on it.

**Class 6 rule 3 note:** ascii39 as drafted mixes input handling, detection
and copy. That is three change classes. Recommend splitting -- input
handling and the crash first, since a build that can crash on the last screen
cannot produce a complete field run.

---

## 11. FOR THE NEXT NOTES UPDATE (research items, not build items)

| Item | Detail |
|---|---|
| **Mouse and trackpad settings for seniors** | Bill, 2026-07-30. All three test machines have a laptop trackpad; Bill prefers a wireless mouse for control. Both input devices **drag a folder into another folder instantly with no warning**, and both can **start an unwanted copy**. The pointer "jumps around like it has a mind of its own". This is a real data-loss risk for the target user -- an accidental drag can move a folder somewhere the user cannot find it, silently. Deep research needed post-launch on: trackpad sensitivity and palm-rejection settings, drag-lock and drag threshold, "ClickLock", pointer precision/acceleration, and whether Windows can be configured to confirm drag-and-drop moves. Destination: ProjectNotes, the tips page on the website, and possibly a Checkup convenience item. |
| **Deep research backlog** | Bill wants a single post-launch research pass covering the mouse item above plus the other tips identified across testing (keyboard arrow/word navigation, repeat delay and rate at `control keyboard`, console copy behaviour per host). |
| **Console host detection** | Whether Checkup is running under Windows Terminal or classic conhost changes what the copy instructions must say -- Mark mode (Alt+Space, E, M) exists only in conhost, and Ctrl+C behaves differently in each. `$env:WT_SESSION` distinguishes them. See FT-150 and the Mark-mode failure in note 21. If confirmed, the copy tip locked verbatim in three places by CLAUDE.md is wrong for the default Windows 11 environment. |
