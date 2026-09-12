<!-- Dated: 2026-09-08 09:01 ET -->
# What Checkup Cannot READ vs What It Cannot CHANGE

- **Document Name:** GatewayGuard_SettingsReadVsChange
- **Dated:** 2026-09-08 09:01 ET
- **Editor:** Claude Code (CGDELL)
- **Written for:** Claude Cloud, which asked the question on 2026-09-08
- **Measured against:** `Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1`
  -- the live build. Every line number below is that file.

---

## THE SHORT ANSWER

**They are two different axes, and neither one is the axis where this
project's defects have actually been.**

- **Cannot change: 2 settings by design, 5 more conditionally.**
- **Cannot read: 1 setting is refused outright on this machine, and 9 more
  can return "Unknown" when a read fails.**
- **THE THIRD CATEGORY IS THE DANGEROUS ONE, and it is neither of the above:
  reads that SUCCEED and are WRONG.** Every wrong-verdict defect found in the
  last month lives here, not in the two lists Cloud asked for.

**One setting -- Edge phishing protection, item 6 -- is in all three at
once.** It is the sharpest example in the build and the best single case to
reason from.

---

## 1. CANNOT CHANGE -- BY DESIGN, DECLARED IN THE BUILD

The settings table carries a `CanAuto` flag per item. ***Measured: 19 items,
exactly 2 declared `CanAuto=$false`.***

| # | Setting | Why not | Line |
|---|---|---|---|
| 3 | Tamper Protection | **Windows refuses programmatic change. That IS the feature** -- a setting a program could turn off would not be tamper protection. Checkup shows the Windows Security path instead. | 5804, 6645 |
| 9 | Windows Hello | Enrolling a PIN, a fingerprint or a face **requires the person at the machine.** Checkup checks if it is set up and gives the Settings path. | 5810, 6727 |

**For both, Checkup shows the exact steps rather than pretending.** That is
the standing wording rule: *"Windows does not allow any program to change this
one, so Checkup shows you the exact steps to do it yourself."*

---

## 2. CANNOT CHANGE -- CONDITIONALLY, ON SOME MACHINES

**These are declared changeable and usually are. They fail for a reason that
is not Windows saying no.**

| # | Setting | What blocks it |
|---|---|---|
| 6 | Edge phishing protection | **Tamper Protection refuses the four registry writes.** Checkup attempts them, catches the refusal, and says `MANUAL REQUIRED -- registry is protected on this PC`, then prints the Windows Security path. Lines 6686-6704. |
| 2 | Defender real-time protection | **Another product holds the slot.** Defender cannot run real-time alongside an active third-party AV or a Malwarebytes Premium trial. Line 6623. |
| 5 | Defender periodic scanning | Same family -- manual while a trial or third-party AV is primary. Line 6672. |
| 16 | Memory Integrity | **The write succeeds; the setting does not take effect until a RESTART.** Changed, but not yet true. Lines 6795-6798. |
| 8 | BitLocker | Not a technical block -- **product rule.** It has its own screen and never starts without explicit permission. Line 6720. |

---

## 3. CANNOT READ

**One is refused outright on this machine.** The rest return `Unknown` when a
read fails, which is honest but is not an answer.

### Refused, measured, not theoretical

**Item 6, Edge phishing protection.** ***Measured on CGDELL 2026-09-07,
`Test_Results\PhishingStates-CGDELL-2026-09-07_16-11.txt`: the key exists and
all four values -- `ServiceEnabled`, `NotifyMalicious`, `NotifyPasswordReuse`,
`NotifyUnsafeApp` -- read NOT SET, while Bill confirmed on screen that all
four were ticked ON.***

**So for this setting the registry is not merely blocked. It is not the source
of truth.** Checkup answers `Unknown -- Tamper Protection blocks this check;
verify by hand`, which is the correct answer and was put there deliberately
(FT-141, line 6185).

### Can return Unknown when the read fails

| # | Setting | What it says |
|---|---|---|
| 4 | SmartScreen | `Unknown -- could not read; check by hand` (line 6111) |
| 3 | Tamper Protection | `Could not read -- check in Windows Security`; also **cannot be verified at all while a Malwarebytes Premium trial holds AV control** (6074, 6647) |
| 2 | Defender real-time | `Unknown -- could not read Defender status` (6051) |
| 13 | Edge startup boost / background | `Unknown -- could not check` (6277) |
| 14 | Widgets | `Unknown -- could not check` (6291) |
| 15 | Edge password saving | `Unknown -- could not check` (6305) |
| 19 | Wake on LAN | `Unknown -- could not check` (6375) |
| 8 | BitLocker | `Check manually in Windows Security` (6230) |
| -- | Secure Boot (system report, not a checklist item) | `Could not read (common on older BIOS PCs)` (4286) |
| -- | Screen timeout, critical battery | `Could not read -- check manually` (5208, 5237) |

**One of these is a known open defect.** Item 17, password required on wake,
reads `powercfg`, and ***`powercfg` can return no CONSOLELOCK block at all --
in which case the status is reported from a read that produced nothing.***
Raised as FT-256, instrumented, **not fixed**, reason recorded in the build
header.

---

## 4. THE CATEGORY CLOUD DID NOT ASK ABOUT, AND IT IS WHERE THE DEFECTS ARE

**A read that succeeds can still be wrong, and a wrong read is worse than a
failed one, because nothing reports it.**

**The worst shape is a wrong GOOD.** A GOOD deselects the item, so **the user
is never offered the fix.** Two of these were found and fixed in ascii44 in
the last two days:

- **FT-257 -- SmartScreen reported "ON -- GOOD" from a value that was not
  there.** The test was `$ss -ne "Off"`, and an absent value is `$null`, which
  is not `"Off"`. ***Measured on CGDELL 2026-09-07: the value was absent while
  Windows Security was posting a warning asking for reputation checking to be
  turned on.*** `-EA SilentlyContinue` made it worse -- a **refused** read also
  landed as `$null`, so **blocked and absent both reported GOOD.** Now `-EA Stop`
  with a typed catch and five distinct answers (lines 6096-6119).
- **FT-258 -- a Group Policy beats the switch in Windows Security.** A value
  under `HKLM\SOFTWARE\Policies` forces the setting, so the user clicks the
  switch, nothing happens, and they conclude they did it wrong. `Get-GGPolicyLock`
  (line 3613) now reports when a policy is **forcing** a setting; wired at three
  points (6423, 6428, 6446). **Every key was read out of Windows' own
  `PolicyDefinitions\*.admx`**, never remembered.

**The mirror shape also exists and is not yet addressed.** Items 11
(Advertising ID) and 12 (Diagnostic Data) read with `-EA SilentlyContinue`, and
their catch reports **"needs attention"** (lines 6241-6242, 6252-6253). **A
blocked read there produces a false BAD.** That is the safer direction -- it
offers a fix that may be unnecessary rather than hiding one that is needed --
but it is still a verdict from a read that did not happen, and it should be
named rather than left as a happy accident.

---

## 5. WHAT THIS MEANS FOR ANY SENTENCE WE WRITE FOR CUSTOMERS

1. **"Checkup checks X" and "Checkup can fix X" are separate promises.** Item
   6 is checked, cannot be reliably read, and cannot be written on a machine
   with Tamper Protection on. Any copy that implies it is fixed automatically
   is wrong on this machine.
2. **Where Checkup cannot change something, it must show the steps** -- that
   is already the rule and the build already does it in all seven cases above.
3. **Where Checkup cannot READ something, "Unknown" must reach the user as
   Unknown**, never as GOOD. That is FT-141 and FT-257, and both were real
   defects that shipped.
4. **A GOOD that comes from a blocked read is the failure mode to hunt.** It
   is silent, it deselects the item, and the user never learns the fix
   existed.

---

## 6. THE OTHER HALF OF CLOUD'S MESSAGE

Cloud said it needs `GatewayGuard_NoteToCloud-2026-09-05-1130.md` and the full
`GatewayGuard_AVTestFindings-2026-09-07-1808.md` before answering section 7.

***Measured 2026-09-08 09:00: both are tracked, committed, clean, and pushed
-- 0 unpushed commits.*** Both live in `ProjectDocs\`, which is in the
connector scope. **Nothing needs to be produced or moved.** They reach Cloud on
the next manual sync, and not before it.

- `GatewayGuard_NoteToCloud-2026-09-05-1130.md` -- 9 KB, 204 lines. This IS
  the current one; `CURRENT.md` names it, with 3 older versions retired.
- `GatewayGuard_AVTestFindings-2026-09-07-1808.md` -- 27 KB, 549 lines,
  including section 0's file index and the seven questions in section 7.

---

## SOURCES

- `Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1` -- every line
  number above.
- `Test_Results\PhishingStates-CGDELL-2026-09-07_16-11.txt` -- the item 6
  measurement, including what the screen showed against what the registry held.
- `Test_Results\ReputationSettings-CGDELL-2026-09-07_13-25.txt` -- the
  SmartScreen values as found.
- Build header, FT-141, FT-256, FT-257, FT-258 -- each carries its own
  measurement and its reason.
