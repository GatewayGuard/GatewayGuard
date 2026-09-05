<!-- Dated: 2026-08-02 13:35 EDT -->
# GatewayGuard Test History -- ascii39

- **Document Name:** GatewayGuard_TestHistory-ascii39
- **Last Modified:** 2026-08-02 11:16 EDT
- **Status:** Cumulative Master Document
- **Change History Log:**
  - 2026-08-02 11:16: **FT-165 and FT-166 OPENED (ascii40 scope).** Checkup guards a
    door Windows 11 Home does not have (Remote Desktop) and says nothing at
    all about the one that reaches our users -- Quick Assist appears ZERO
    times in the ascii39 source, is installed by default on Home, and is a
    documented social-engineering vector. FT-165: check and disable Remote
    Assistance (`fAllowToGetHelp`, unset on CGDELL, exists on BOTH editions).
    FT-166: Quick Assist as a convenience item with the trade-off stated --
    never a silent removal. Also records the same-day website correction and
    the guide feed-back owed under W-07. See section 5d.
  - 2026-08-02 13:35: **FT-167, FT-168, FT-169 OPENED.** FT-167: Checkup only ever
    reads C:, so a Pro machine with a second fixed drive is told
    ENCRYPTED -- GOOD while that drive sits in the clear (SANDY has an
    internal fixed 1 TB D:). FT-168: the free-space remnant gap -- use the
    Windows built-in `manage-bde -w`, NOT a third-party wiper; researched
    concerns recorded (never on SSD; Home support unconfirmed). FT-169:
    the 'set once, protected forever' reassurance line, measured on CGDELL,
    for ascii40 + guide + website + marketing. Sections 5e, 5f, 5g.
  - 2026-08-02 09:14: **FT-163 and FT-164 OPENED** -- the BitLocker time estimate
    reads the WRONG DISK (`Get-PhysicalDisk | Select -First 1` returns an
    attached USB stick, not the volume's own disk -- measured on CGDELL) and
    keys its SSD estimate off RAM rather than drive size or used space.
    Also records that a finished encryption leaves NO recoverable duration
    (no start/complete events; Operational log ships disabled), so SANDY's
    upcoming encryption is the only chance at a first measured data point.
    Tooling shipped: `Measure-Encryption-2026-08-02.ps1`. See section 5c.
  - 2026-08-02 07:41: **FT-162 OPENED (blocker)** -- `MpCmdRun.exe -Scan
    -ScanType 4` is not a valid flag; measured 0x80070667 invalid command
    line, 0.0s, no scan. **The quarterly Defender scan has never run on any
    machine** while the log said [GOOD] every time. Records Bill's ascii40
    decisions and the process fix (gate 24 + the rule extension in all three
    governing documents). See section 5b.
  - 2026-08-02 06:28: **FT-109 CLOSED** by external verification on SANDY
    (gate 21 / C-25 satisfied at last -- open since ascii32). **FT-161 OPENED:
    both scheduled tasks are created correctly and can still never run on a
    laptop.** Records the false FAIL produced by the first version of the
    verification script and its correction. See section 5a.
  - 2026-07-30 22:08: Initial file. ascii39 BUILD RECORD -- scope vs delivered
    (gate 19) for all 20 items carried out of the ascii38 field run, the
    build-time verification evidence, and the field test plan. **No field run
    yet.** Supersedes nothing; the ascii38 TestHistory
    (`-2026-07-30-1518`) remains the record of the run that produced this scope.

**Build:** `Tool\W11-SecurityHardening-v3-ascii39-2026-07-30-2208.ps1`
**Build date:** 2026-07-30 22:08 ET
**Built on:** CGDELL (Windows 11 Pro)
**Size:** 8,448 total / **8,075 non-blank** lines / 508,318 bytes
**Predecessor:** ascii38 -- 7,505 total / 7,159 non-blank / 443,874 bytes
**Delta:** +943 lines
**Scope decision:** Bill, 2026-07-30 -- *"do ALL 20"*

> ## UNRUN BUILD RULE -- ascii39 HAS NOT BEEN FIELD-TESTED
>
> Playbook Class 6 rule 3: *"an untested build is not a build, it is a
> liability. Never let two builds stack unrun."* ascii39 must be field-run
> before ascii40 is scoped.

---

## 0. THE SCOPE DECISION, RECORDED

The ascii38 TestHistory §10 recommended **splitting** this work, and Playbook
Class 6 rule 3 requires one change class per build. The recommendation was put
to Bill on 2026-07-30 with three options; he chose all 20 items in one build.

**What that costs, stated plainly:** ascii39 mixes three change classes --
console/input handling, detection truthfulness, and copy/layout. If a field
failure appears, the first question becomes *which class caused it*, and the
attribution that Class 6 rule 3 exists to protect is weaker here than in
ascii38. The same note is written into the .ps1 header so it cannot be lost.

This is recorded as a decision, not a complaint. It is also why section 4's
field test plan is ordered by change class rather than by screen order.

---

## 1. SCOPE VS DELIVERED (gate 19)

All 20 items shipped. Nothing from the agreed list was deferred.

### Blockers

| ID | What it was | Delivered | Build-time evidence |
|---|---|---|---|
| **FT-150** | Ctrl+C in Mark mode killed the tool -- caused by our own copy tip | `Register-ConsoleCtrl`: a C# `SetConsoleCtrlHandler` that swallows `CTRL_C_EVENT` / `CTRL_BREAK_EVENT` and returns TRUE, so Windows does not terminate | **measured** -- handler installs (`True`), type loads, idempotent on re-registration |
| **FT-160** | Clicking the X killed the tool with no footer | Same handler writes the log footer on `CTRL_CLOSE_EVENT` / logoff / shutdown, from C# using `System.IO` (the handler thread has no PowerShell runspace) | **measured end-to-end** -- see §2 |
| **FT-149** | Keypresses queued and skipped screens; user can miss security decisions | `Clear-PendingKeys` -- targeted **post-accept** drain in all three hardened readers; bounded to 256 keys / 200 ms | **measured** -- returns in 7 ms with nothing queued. Real behaviour needs the field |
| **FT-159** | A real error the tool hid (4100 at 13:42:57) | `Write-PendingErrors` drains new `$Error` entries to the log at every prompt, naming the screen. **The class is closed, not the instance** | **measured** -- a deliberately caused silent error was captured with file and line |
| **FT-148** | 20 C# compilations per run (ascii38 regression) | Compiled kernel32 type cached in `$script:GGK32`; QuickEdit line logged once per session | **inferred** from the code path; confirm by 4104 event count in the next run |
| **FT-147** | Unguarded `ReadKey` in `Show-LookBack` -- the ascii23 FT-01 defect reintroduced | Every read guarded: try/catch, mode re-assert before each read, failure returns instead of throwing | **sourced** -- pattern matches `Read-ValidKey` / `Pause-ForUser` |
| **FT-146** | Look-back offered where it could not deliver (notes 4, 5, 6) | **Gated, not redesigned.** Back is offered only when a previous snapshot exists *at the current buffer width*. The dead ends are unreachable because the offer is not made | Redesign explicitly deferred -- see §3 |

### Detection truthfulness (the FT-120 family)

| ID | What it was | Delivered | Build-time evidence |
|---|---|---|---|
| **FT-140** | MB detection used SecurityCenter2 registration as a proxy for "installed" -- and MB deregisters at trial expiry | Four independent installed-checks: SC2, MBAMService, uninstall entries in **both** hives, program file on disk | **measured on the machine that exhibits the bug.** See §2 |
| **FT-141** | Item 6 reported a definite BAD from a read blocked by Tamper Protection | `-EA Stop` plus a catch that distinguishes **blocked** from **absent**; blocked now reports Unknown with manual steps | **sourced** -- the CGDELL/SANDY reproduction is in the ascii38 record |
| **FT-143** | Secure Boot only ever checked on Home, inside the BitLocker prereq block | Read on every edition, shown in the system baseline. **Reported, never changed** -- changing it on an encrypted machine can trigger a recovery prompt | **measured** -- reads `False` on CGDELL. See §2 |
| **FT-142** | Third phishing toggle called "unsafe apps" | Now "unsafe password storage", the literal on-screen label from field note 20 | **sourced** -- tester's own screen capture |
| **FT-157** | Remote Desktop claimed unavailable on Home; tester supplied contradicting sources | Copy now distinguishes **hosting** (Pro and above) from the **client** (works on Home). Tester was half right and so were we | **sourced** -- Microsoft Learn, researched 2026-07-30 |

### Home encryption safety

| ID | What it was | Delivered | Build-time evidence |
|---|---|---|---|
| **FT-144** | Home encryption can start with no recovery key anywhere (field-confirmed on SANDY, local account) | `Get-SignInAccountType` detects local vs Microsoft account; the key is presented as a **precondition**, with the online requirement stated | **measured** -- returns `Microsoft` on CGDELL, cross-checked against `Get-LocalUser` `PrincipalSource` |
| **FT-145** | Windows shows a progress bar when encrypting and nothing when decrypting | `Get-EncryptionProgress` reports state and percentage, with a `manage-bde` fallback for Home | **measured** -- `Encrypted / 100 / FullyEncrypted` on CGDELL |
| **FT-156** | Device Encryption screen inadequate -- "Users will feel lost" | Rebuilt as **four** screens: what it is + current state; requirements; the recovery key as a precondition; step-by-step sign-in (both cases) and how to check it is running | New screens 79, 80, 81, 82 |

### Layout and copy

| ID | What it was | Delivered |
|---|---|---|
| **FT-151** | FT-117 recurrence -- status column truncated at both widths | Both columns sized from **actual page content** every render, header row included. When they cannot both fit, **status wins** (gate-consumed strings); name keeps a 24-column floor. Column widths logged every render |
| **FT-153** | Screens too long; new rule -- 26 lines max, every screen ends blank | Trailing blank line produced **centrally in `Write-GGBox`**, so a future screen cannot forget it. Intro window screen split (now 6 intro screens, new SCREEN-78); "what Checkup does" closing line is three bullets with air; Device Encryption rebuilt as four. **New mechanical gate 12b** -- see §3 |
| **FT-152** | Rename incomplete -- screens still said "this tool" | 25 user-facing strings corrected. Log messages deliberately left alone (not user-facing; changing them breaks cross-build log greps) |
| **FT-154** | Pre-scan reminder listed Malwarebytes before Defender | Reversed on SCREEN-39; Defender reads first |
| **FT-155** | Item 6 should say Edge phishing protection | Renamed "Edge Phishing Protection (all 3)"; description updated |
| **FT-158** | Ctrl+Z in the admin terminal | Environment behaviour, not a Checkup defect. Recorded so it is not re-reported |

---

## 2. BUILD-TIME VERIFICATION -- WHAT WAS ACTUALLY PROVEN

Read-only harnesses extracted the **shipped function text via the AST**, so
these exercise the bytes that ship, not a retyped copy.

### FT-160 proven end-to-end

A child console was launched running the real `Register-ConsoleCtrl`, then sent
`WM_CLOSE` -- exactly what the X button sends. (`Stop-Process` was deliberately
not used: it calls `TerminateProcess`, which raises no console control event and
would have proven nothing.)

```
[22:53:46] [OK] Console control handler registered ...
READY
[22:53:46] [EXIT] SESSION ENDED EARLY -- the window's X (close button) was clicked.
============================================================
Log complete. Keep this file -- it is your record of all changes made.
============================================================
```

**The exact failure mode from 2026-07-30 13:52 now writes a complete footer
naming its own cause.**

### FT-140 proven on the machine that has the bug

CGDELL is the trial-expired case that made this invisible for 38 builds:

| Signal | Value |
|---|---|
| Registered in SecurityCenter2 | **False** |
| MBAMService | **Running** |
| mbam.exe on disk | **True** |
| ascii38 result | `NotInstalled` (offers a download of software already installed) |
| **ascii39 result** | **`FreeCompanion`**, via the MBAMService fallback |

### FT-143 -- the finding that was never surfaced

`Confirm-SecureBootUEFI` returns **False** on CGDELL. Secure Boot has been off
on the primary test machine for 38 builds and the tool never said so, because
the only call site was inside the Home-only BitLocker prerequisite block.

### Other measured results (CGDELL)

- `Get-SignInAccountType` -> `Microsoft`, cross-checked against `Get-LocalUser`
  `PrincipalSource` = `MicrosoftAccount`
- `Get-EncryptionProgress` -> `Encrypted / 100 / FullyEncrypted`
- `Write-PendingErrors` captured a deliberately caused silent error with file
  and line number
- `Clear-PendingKeys` returned in 7 ms with an empty buffer
- `FooterDone` handshake settable from PowerShell (double-footer guard works
  in both directions)

### Gate results

| Gate | Result |
|---|---|
| Parse errors (`Parser::ParseFile`) | **0** |
| Size assertion (rule 6b) | +943 lines, inside the asserted bound |
| Brace balance | 1,487 / 1,487 |
| Unique-string spot check | `FT-116` 7 -> 9 (two new citations; no duplication) |
| Duplicate function definitions | **0** |
| Required functions exactly once (gate 3) | **26 / 26 PASS** |
| `press any key` (gate 5) | 0 |
| `Join-String` | 0 |
| `Read-Host` | 9 -- unchanged from ascii38, all documented fallbacks |
| Build ID agreement (gate 6) | all **five** locations, incl. CLAUDE.md |
| Non-ASCII lines | **9** -- the documented ascii28 legacy baseline, not grown |
| PSScriptAnalyzer | **0 errors** (744 warnings vs ascii38's 722; delta is 19 best-effort empty catches, 1 global read, 2 plural nouns) |
| Gate 12 screen coverage | **PASS** -- 65 screens, 0 untagged, 0 duplicates |
| Gate 12b 26-line rule | **PASS** -- 10 carried, 0 new |
| Paired-file sync (item 10) | all three `.bat` launchers updated; 0 stale ascii38 references |
| Archive byte-identical | SHA256 match, `Tool\` == `Builds\` |

**One gate caught a real defect during the build:** gate 12 failed the first
run because SCREEN-80 was used in both branches of the account-type test. Fixed
at source and rebuilt -- the output was never hand-patched.

---

## 3. DEFERRED, WITH REASONS (gate 19)

| Item | Reason |
|---|---|
| **FT-146 look-back redesign** | Gated this build instead. A screen-history navigation model is a build of its own and needs its own field run. The dead ends the tester hit are unreachable now because the offer is not made |
| **FT-137 Gallery mode** | Untested in the field. Deliberately not touched so the next run exercises it as ascii38 shipped it |
| **FT-109 scheduled tasks** | **Still open under gate 21.** Not touched. Does not close until Task Scheduler is opened on SANDY and both tasks are confirmed present with correct actions. A clean build is not evidence |
| **FT-110 second half** | The recovery key reaching `account.microsoft.com/devices/recoverykey` has still never been observed. FT-144 is the groundwork; the observation is owed |
| **10 oversized screens** | 72, 50, 73, 26, 27, 65, 60, 41, 30, 52 -- all **newly surfaced** by applying the new 26-line rule mechanically, none named in the 20 items. Splitting ten more screens inside a build already mixing three change classes is exactly what Class 6 rule 3 warns about. They are now in a **named baseline in the checker**, reported on every run, and no *new* oversized screen can be added |
| **Console host detection** (`$env:WT_SESSION`) | **measured** 2026-07-30: SANDY runs classic conhost, so the Mark-mode copy tip is correct there. Whether it is correct under Windows Terminal is unresolved, and the tip is locked verbatim in three places by CLAUDE.md -- a documentation decision, not a code one |

---

## 4. FIELD TEST PLAN -- ORDERED BY CHANGE CLASS

Because this build mixes three classes, test them in this order so a failure is
attributable.

### A. Console and input survival (the blockers)

1. **FT-160:** part-way through a run, click the window's **X**. Reopen the log
   -- it must end with `SESSION ENDED EARLY -- the window's X ... was clicked`
   followed by the full footer.
2. **FT-150:** enter Mark mode (Alt+Space, E, M) and press **Ctrl+C**. The tool
   must **keep running**. Press Esc to leave Mark mode and carry on.
3. **FT-149:** at a screen that takes a moment, tap Space five or six times
   while it is working. Only **one** screen may advance. Log should show
   `Discarded N keypress(es)`.
4. **FT-147/146:** press **B** wherever it is offered; confirm it never answers
   "as far back as you can go". Resize the window, then look for B -- it should
   **not be offered** at the changed width.
5. **FT-148:** after the run, count 4104 events in the PowerShell Operational
   log during `Get-AllStatuses`. Should be a handful, not dozens.
6. **FT-159:** grep the log for `SILENT ERROR`. **Any hit is a finding** -- that
   is the point. Report the text verbatim.

### B. Detection truthfulness -- best tested on CGDELL

7. **FT-140:** item 2 must report Malwarebytes as detected on the Dell despite
   the expired trial. It must **not** offer a download.
8. **FT-143:** the system baseline must show `Secure Boot: OFF` on the Dell,
   with the recovery-key warning.
9. **FT-141:** item 6 must read `Unknown -- Tamper Protection blocks this
   check`, not "Not configured", on a machine with Tamper Protection on.
10. **FT-151:** run at a **narrow** window (~86 columns) and confirm no status
    text is cut. The log line `Checklist columns:` records what it chose.

### C. Home encryption and copy -- needs SANDY

11. **FT-144/145/156:** walk the four Device Encryption screens on SANDY. The
    account type must read **Local**, and the recovery-key screen must appear
    *before* the sign-in steps.
12. **FT-153/152/154/155:** read the intro (now **6** screens), the pre-scan
    reminder (Defender first), item 6's name, and confirm every screen ends
    with a blank line.

---

## 5a. FT-109 CLOSED / FT-161 OPENED -- SANDY, 2026-08-02

**Evidence:** `Test_Results\ScheduledTasks-SANDY-2026-08-02_06-24.txt`, produced
by `Tool2\Check-ScheduledTasks-2026-08-02.ps1` (rev 2). Read-only.

### FT-109: CLOSED

Open since ascii32 -- the FT-73 / FT-76 / FT-93 / FT-109 lineage, five builds
of task-creation failures. Gate 21 required external confirmation because *"a
clean build is not evidence of a working feature."* It now has it:

| Check | Quarterly Defender Offline Scan | Monthly Malwarebytes Reminder |
|---|---|---|
| Exists | YES | YES |
| State | Ready | Ready |
| Run as | SYSTEM / Highest | willi / Limited |
| Trigger | Monthly Jan/Apr/Jul/Oct, day 1, 02:00 | Monthly all 12, day 1, 10:00 |
| Action path resolves | **YES** -- `C:\Program Files\Windows Defender\MpCmdRun.exe` | **YES** -- `powershell.exe` via PATH |
| Script target exists | n/a | YES -- `C:\ProgramData\GatewayGuard\MBReminder.ps1` |

The FT-93 quoting defect is genuinely gone. Both action paths survive.

### THE VERIFICATION SCRIPT ITSELF PRODUCED A FALSE FAIL

Recorded because it is a defect in our own tooling and it is instructive.

The first SANDY run (05:59) reported the Quarterly task's program as
**"DOES NOT EXIST"** and failed it. **That was wrong.** `Test-Path` had been
handed the path with its surrounding quotes still attached; Task Scheduler
strips those.

**Disproved by measurement, not argument:** the `GoogleUpdaterTaskSystem` task
on CGDELL stores its Command as `"C:\Program Files (x86)\...\updater.exe"` --
quotes included -- and ran successfully with `LastTaskResult 0` at 2026-08-02
05:52:32. Quoting is tolerated.

**This is FT-120 / FT-123 / FT-141 for the fourth time**: *a check that could
not establish the state invented a definite answer instead of reporting
Unknown.* Committed inside the tool written to catch exactly that. The rule
does not only apply to the build -- it applies to anything that reports a
state, including our own instrumentation.

Corrected in rev 2 (quote stripping + `%ProgramFiles%` expansion). The
genuinely broken split path is still caught -- re-verified against
`C:\Program`, which still reports DOES NOT EXIST, so FT-109 detection is not
weakened.

### FT-161 (NEW) -- BOTH TASKS ARE CREATED CORRECTLY AND CAN NEVER RUN

**This is the more serious finding, and it was never on anyone's list.**

Both tasks carry these settings, which are **schtasks.exe defaults that the
build never overrides**:

| Setting | Value | Consequence |
|---|---|---|
| `DisallowStartIfOnBatteries` | **True** | will not start on battery |
| `StopIfGoingOnBatteries` | **True** | killed if unplugged mid-run |
| `WakeToRun` | **False** | will not wake a sleeping PC |
| `StartWhenAvailable` | **False** | a missed run is never retried |

**Field-observed, not theorised:** the Malwarebytes reminder **did fire** on
2026-08-01 at 14:55:49 and returned `0x800710E0` -- Win32 4320, *"The operator
or administrator has refused the request"* -- Task Scheduler declining because
a power condition was not met.

**The quarterly Defender scan is worse.** It is scheduled for **02:00**, when a
home laptop is almost certainly asleep. `WakeToRun` false means it will not
wake. `StartWhenAvailable` false means it will not retry when the lid opens at
08:00. **On a laptop, that task will essentially never run -- and the log will
say `[GOOD] Scheduled task created` every single time.** A Class 1 invisible
failure wearing the uniform of a success.

Every target machine is a home laptop. This affects all of them.

**Verified fix for ascii40** (measured on CGDELL 2026-08-02, not assumed --
the first parameter name tried, `-DisallowStartIfOnBatteries`, does not
exist):

```powershell
$ggSet = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries `
                                      -DontStopIfGoingOnBatteries `
                                      -StartWhenAvailable
Set-ScheduledTask -TaskName $ggT1Name -Settings $ggSet
```

Confirmed to produce `DisallowStartIfOnBatteries False`,
`StopIfGoingOnBatteries False`, `StartWhenAvailable True`. All three are
**switch parameters used by presence**, which satisfies C-14 (never pass a
positional `$true`/`$false` to a switch). Gate 16 is unaffected -- schtasks.exe
still creates the recurring schedule; this only adjusts settings afterwards.

**One design question for Bill, not a settings fix.** `WakeToRun` is
deliberately left alone above. A Defender Offline Scan **reboots the machine
into a pre-boot scanner**. Waking a sleeping laptop at 02:00 to do that -- in a
bag, on a bed, thermally enclosed -- is not obviously safe, and a senior who
finds their laptop hot and rebooting at 2 AM will not read it as protection.
`StartWhenAvailable` alone may be the better answer: run it the next time the
machine is genuinely awake and plugged in. **Decide before ascii40.**

---

## 5b. FT-162 (NEW, BLOCKER) -- THE QUARTERLY SCAN HAS NEVER RUN

**Measured on CGDELL, 2026-08-02 06:51.** Not inferred.

The quarterly task's action is:

```
"C:\Program Files\Windows Defender\MpCmdRun.exe" -Scan -ScanType 4
```

**`-ScanType 4` is not a valid scan type.** MpCmdRun's own `-?` output on
Windows 11 build 26200 documents exactly four values:

| Value | Meaning |
|---|---|
| 0 | Default, according to your configuration |
| 1 | Quick scan |
| 2 | Full system scan |
| 3 | File and directory custom scan |

Running it:

```
CmdTool: Failed with hr = 0x80070667
CmdTool: Invalid command line argument
```

`0x80070667` = 1639 = `ERROR_INVALID_COMMAND_LINE`. **Elapsed: 0.0 seconds.**
`Get-MpComputerStatus` before and after is byte-for-byte unchanged. No scan
started, no offline scan queued, no reboot pending.

**Consequences, in order of severity:**

1. **The quarterly Defender Offline Scan has never run on any machine**, for
   as long as this task has shipped. It fails instantly, every time.
2. **The log says `[GOOD] Scheduled task created` every time.** A Class 1
   invisible failure wearing the uniform of a success -- and it survived
   FT-73, FT-76, FT-93 and FT-109, four generations of work on this exact
   feature, because every one of them asked *"was the task created?"* and
   none asked *"does the command work?"*
3. **The tool asserts the false claim to the user's face.** SCREEN text:
   *"The quarterly task runs MpCmdRun.exe -ScanType 4 which SCHEDULES the
   offline scan for your NEXT PC restart. You will see: 'Microsoft Defender
   Offline' screen on startup."* Every clause after "runs" is untrue. It also
   puts a raw command line in front of a senior, which the plain-language
   rule says to delete rather than explain.
4. **The correct call was already in the same file.** `Show-PreScanGate` uses
   `Start-MpWDOScan` for the interactive offline scan -- the supported
   method, twelve hundred lines from the broken one.

**What the user would have seen, had it worked** (asked 2026-08-02): nothing
at all. The task runs as SYSTEM in session 0, which is isolated from the
desktop -- no window, no notification, no output. Contrast the Malwarebytes
reminder in the same function, which deliberately runs as the interactive
user so its MessageBox appears. **And they could not have postponed it:** no
prompt, no "remind me later", and once an offline scan is queued it runs at
the next restart. A senior would meet an unexplained blue pre-boot scanner
weeks after Checkup arranged it.

### Decisions for ascii40 (Bill, 2026-08-02)

- **`StartWhenAvailable` only. No `WakeToRun`.** Nothing wakes a laptop at
  02:00 to reboot it into a pre-boot scanner.
- **Recommended, pending Bill's call: make it a REMINDER, not a silent
  action** -- the same MessageBox pattern as the Malwarebytes task, running
  as the interactive user, explaining what an offline scan is and how to
  start it when *they* choose. That matches the product's own promise
  (*"Checkup never applies anything you did not choose"*) and removes the
  surprise-reboot problem rather than scheduling around it.
- Delete the false on-screen sentence entirely.

### The process fix, shipped 2026-08-02

RESEARCH BEFORE STATING already forbade this and had been mandatory for
weeks. **It did not hold, because nothing checked it.** Enforcement is now
mechanical:

- **Gate 24** in CodingStandards, run by `Tool2\Run-ExternalCommandCheck.bat`.
  24a fails any external command without a `# VERIFIED <date>
  measured|sourced:` comment within 20 lines. 24b fails any screen showing
  the user a raw command line (`# GATE24-OK: <reason>` declares a deliberate
  "type this" instruction).
- **Verified against ascii39: the checker flags line 6445 on BOTH counts** --
  the unverified `MpCmdRun` call and the false user-facing sentence. It would
  have caught FT-162 before the build shipped.
- The rule was extended in all three governing documents (CLAUDE.md,
  CodingStandards, ProjectInstructions) to say plainly that **a command flag,
  and a parameter name, is a factual claim** -- and that CGDELL is the bench.
  The FT-161 fix itself proved the point the same morning:
  `-DisallowStartIfOnBatteries` was written first and does not exist
  (`-AllowStartIfOnBatteries` does), caught only by running it.

---

## 5c. FT-163 / FT-164 -- THE BITLOCKER TIME ESTIMATE IS BUILT ON TWO WRONG INPUTS

Found 2026-08-02 while answering a question about predicting encryption time.
Both are in `Get-BitLockerTimeEstimate`, which feeds the BitLocker screen --
one of the few screens CLAUDE.md specifies by name ("must show: RAM size,
drive size, drive type, estimated time").

### FT-163 -- the tool reads the WRONG DISK

```powershell
$disk = Get-PhysicalDisk -EA SilentlyContinue | Select-Object -First 1
$isSSD = ($disk -and $disk.MediaType -match "SSD|Solid")
```

**Measured on CGDELL, 2026-08-02:** that returns an **8 GB USB stick** with
`MediaType: Unspecified`, `BusType: USB` — not the 238 GB KIOXIA NVMe SSD
hosting C:. So `$isSSD` is false, the machine is labelled **"HDD (hard
drive)"** on screen, and the HDD time formula is applied to an NVMe SSD —
purely because a USB drive happened to be plugged in.

| | |
|---|---|
| What `Select -First 1` picks | (blank name), USB, Unspecified, 8 GB |
| What actually hosts C: | KBG50ZNS256G NVMe KIOXIA, **SSD**, NVMe, 238 GB |

This is nondeterministic in the worst way: the answer depends on what is
plugged in at the moment the user runs Checkup. A senior with a backup drive
or a photo-card reader attached gets a different answer than one without.

**Fix:** resolve the disk that actually hosts the volume —
`C: -> Get-Partition -> DiskNumber -> Get-Disk -> Get-PhysicalDisk`. Already
implemented and field-proven in `Tool2\Measure-Encryption-2026-08-02.ps1`,
which also reports when other disks are attached so the condition is visible.

### FT-164 -- the SSD estimate keys off RAM, which is nearly irrelevant

```powershell
if ($isSSD) {
    if ($ramGB -le 8)      { $estimate = "1-3 hours" }
    elseif ($ramGB -le 16) { $estimate = "45 min-2 hours" }
    else                   { $estimate = "20-60 minutes" }
}
```

Drive size never enters the SSD branch. **A 256 GB SSD and a 2 TB SSD with
the same 8 GB of RAM are both quoted "1-3 hours."** RAM is not what governs
encryption speed — drive throughput, CPU AES support, and above all **how
much data there is** do.

And used space is the input nobody is looking at. CGDELL: **236 GB volume,
91.6 GB used — 39%.** Windows Device Encryption converts used space first, so
the difference between "encrypt the used space" and "encrypt the whole
volume" is a factor of two and a half on this machine alone.

The HDD branch at least divides by drive size (`driveGB/200` to `driveGB/80`
hours), so it is wrong in a smaller way.

### Why there is no measured number to replace them with

**A finished encryption leaves no duration behind. Verified on CGDELL,
2026-08-02:**

| Evidence | Result |
|---|---|
| `BitLocker Management` log, event 769 | "encryption will occur when the computer is restarted" — 07-14 09:42:52 |
| A "started" or "completed" event | **none exists**; next event is 29 hours later and unrelated |
| Events 24577 / 24578 / 24579 | **0 present** on this OS |
| `BitLocker/BitLocker Operational` log | **`IsEnabled: False`** — ships disabled, recorded nothing |

**The Dell's and the IdeaPad's encryption times are unrecoverable.** The only
way to obtain a real figure is to sample `EncryptionPercentage` while a drive
converts — which makes SANDY's upcoming encryption the single opportunity to
capture the project's first measured data point.

**Tooling shipped for it:** `Tool2\Measure-Encryption-2026-08-02.ps1` +
`Run-EncryptionMeasure.bat`. Started before encryption begins, it samples
every 60s to CSV and reports elapsed time, %/min, and GB/min against both
used and total volume. On an already-encrypted machine it still captures a
baseline profile row, so the IdeaPad can contribute without being touched.

**CGDELL baseline row (measured 2026-08-02):** 236 GB volume / 91.6 GB used
(39%) / KIOXIA KBG50ZNS256G NVMe SSD 238 GB / XTS-AES 128 / i7-1265U 10c12t /
32 GB RAM / Win 11 Pro.

### Position for ascii40

Fix FT-163 (wrong disk — unambiguous bug). For FT-164, **do not replace one
unmeasured model with another.** Until two or three measured rows exist, the
screen should present the figure as approximate and say what it depends on
(how full the drive is), rather than quoting a confident range built from a
variable that does not govern the outcome. This is FT-162's lesson one
severity down: an estimate asserted with more confidence than its evidence
supports. C-26 already requires that every time estimate name the machine it
was measured on — no current estimate can satisfy that, because none was
measured at all.

---

## 5d. FT-165 / FT-166 -- THE REMOTE-ACCESS DOOR CHECKUP DOES NOT WATCH

Raised 2026-08-02 out of the Remote Desktop website rewrite. Both are
**scope items for ascii40**, not defects in shipped behaviour.

### The gap, stated plainly

Checkup item 10 guards **Remote Desktop** -- a door that **does not exist on
Windows 11 Home at all**, and that on Pro is already shut by default
(`fDenyTSConnections = 1`, measured on CGDELL). Meanwhile the route that
actually reaches our users -- a phone call plus a consent click -- gets **no
coverage anywhere in the run**.

**Measured 2026-08-02: `Quick Assist` appears ZERO times in the ascii39
source.** It is installed by default on Windows 11 including Home
(`MicrosoftCorporationII.QuickAssist 2.0.35.0`, present on CGDELL), and
Microsoft's own security team has published on threat actors misusing it for
social engineering that ends in ransomware.

The Apps Audit already lists `TeamViewer`, `AnyDesk` and `RealVNC` under
"Remote Access (legitimate)" -- so third-party tools are covered. The
Microsoft-supplied one is not.

### FT-165 -- Remote Assistance is never checked (new setting item)

`fAllowToGetHelp` governs "Allow Remote Assistance connections to this
computer". **Measured on CGDELL: the value is not set at all** -- so the
machine runs on whatever Windows defaults to, and Checkup has never looked.
`msra.exe` is present on the machine.

| | |
|---|---|
| Key | `HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server` |
| Value | `fAllowToGetHelp` (DWORD) |
| Wanted | `0` -- Remote Assistance connections blocked |
| CGDELL now | **not set** |
| Edition | exists on Home **and** Pro, unlike item 10 |

Cheap, reversible, no realistic downside -- Remote Assistance is legacy and
almost nobody uses it deliberately. Recommend a new setting item (next free
ID **20**; note C-18's spaced numbering was never actually applied, IDs run
1-19 contiguous, so 20 is the natural append).

### FT-166 -- Quick Assist: educate, and offer removal as a CHOICE

**Do not silently remove it.** Two reasons, both real:

1. Quick Assist is also how a trusted grandchild helps them. Removing it
   removes the lifeline along with the risk.
2. It is a Store app and can return at the next feature update. A "fix" that
   quietly reverts is worse than none, because the log will claim it was
   applied. That is the FT-162 failure pattern -- a `[GOOD]` line for
   something that is not true any more.

**Measured:** `NonRemovable: False`, so
`Get-AppxPackage MicrosoftCorporationII.QuickAssist | Remove-AppxPackage`
does work. It just should not be the default.

Recommended shape:
- A **convenience item** (the 11-15 ask-before-apply band, gate 22), never
  applied in the main run.
- The screen states the trade-off in the user's terms: *this is how a family
  member can help you, and it is also what a scammer will ask you to open.*
- The **primary deliverable is copy, not a switch.** No setting stops a
  determined scam call -- someone with a senior on the phone can talk them
  through installing anything. Removing Quick Assist adds a step; it does not
  close the door. The sentence that actually works is **"Microsoft will never
  call you. Hang up."**

### Why the switches are secondary -- state this in the build header

FT-165 and FT-166 together reduce surface. Neither is the fix. Recording it
here so the next build does not mistake a hardened registry value for a
solved problem: **the defence against consent-based remote access is the
user knowing to hang up.** Everything else is friction bought around that.

### Carried across to the website the same day

`WebSite\html\remote-desktop.html` was corrected 2026-08-02 (FT-157 plus this
material): the false claim *"Remote Desktop is not available on Windows 11
Home"* removed; the Home box now says nothing can connect **in** while naming
Quick Assist as the consent-based exception and the scam it enables; a new
section covers connecting **out** with the recommendation *"nothing can
connect in to this PC, unless you let them. Never let them unless you started
the contact yourself."*

**H-4 status: no guide conflict.** `GatewayGuard_SettingsToGuideMap.md` records
the guide's Remote Desktop coverage as *"BRIEF -- needs expansion for Pro
edition explanation"* -- one quick-reference line. The website copy is
therefore original under the W-07 exception, and **owes a feed-back into the
written guide**, which the map is already asking for. Track that with FT-165.

---

## 5e. FT-167 -- CHECKUP ONLY EVER SEES C:, ON A MACHINE THAT MAY HAVE FOUR DRIVES

Raised 2026-08-02 by Bill: *"SANDY (C: 250GB, D: 1TB) and many other PCs have
multiple hard drives and perhaps partitions. What will get encrypted?"*

### What Checkup does -- measured from the source

**Every encryption call in ascii39 targets the system drive and nothing else:**

| Line | Call |
|---|---|
| 3438 | `Get-BitLockerVolume -MountPoint "C:"` |
| 5326 | `Get-BitLockerVolume -MountPoint $env:SystemDrive` -- **this is the item 8 status** |
| 6695, 6926 | `Get-BitLockerVolume -MountPoint $env:SystemDrive` |
| 6710 | `manage-bde.exe -status $env:SystemDrive` |
| **7168** | **`Enable-BitLocker -MountPoint $env:SystemDrive`** |

There is no enumeration of volumes anywhere. A second fixed drive is invisible
to Checkup at every stage: the check, the screen, the action, and the log.

### The consequence differs by edition, and Pro is the worse case

**Windows 11 Pro.** Checkup calls `Enable-BitLocker` on C: only. A 1 TB D:
full of photographs stays in the clear, and item 8 then reports
**`ENCRYPTED -- GOOD`** -- because the status check also only reads C:. The
user is told their PC is encrypted while their data drive is not.

**Windows 11 Home.** Windows itself does the work, and *sourced* (Microsoft
Support, "Device Encryption in Windows"): Device Encryption covers **the OS
drive and fixed data drives**, excluding external and USB drives. So Home may
end up *better* covered than Pro -- the opposite of what anyone would assume.

**NOT YET VERIFIED IN THE FIELD.** The Microsoft wording distinguishes drives
being *initialized with a clear key* from being *encrypted*, and no machine in
this project has ever been watched through a Home encryption with a second
fixed drive attached. **SANDY's upcoming encryption is the chance to settle
it** -- see the added field-test step.

### The copy is singular throughout

Checkup's encryption copy says **"your drive"**, never "your drives":

- `"Encrypts your drive. Protects data if PC is lost or stolen."` (item 8)
- `"Encryption scrambles everything on your drive..."`
- `"...everything on your hard drive."`
- `"Drive:  NNN GB <type>"` -- one drive, from `Get-PSDrive C`

The only place Checkup says **"CHECK ALL your drives (C:, D:, and any
others)"** is the *Malwarebytes scan* instructions. Encryption -- where it
matters more -- never mentions a second drive at all.

### Fix for ascii40

1. **Enumerate fixed volumes**, not just `$env:SystemDrive`:
   `Get-BitLockerVolume | Where-Object { $_.VolumeType -ne 'Removable' }`,
   cross-checked against `Get-Volume ... DriveType -eq 'Fixed'` so USB sticks
   are excluded. On CGDELL right now that correctly separates C: (Fixed,
   OperatingSystem) from D: (Removable, USB stick).
2. **Item 8's status must reflect every fixed drive**, not just C:. A machine
   with C: encrypted and D: not is **not** `ENCRYPTED -- GOOD`. Proposed:
   `PARTIALLY ENCRYPTED -- C: yes, D: no`. Note this touches the
   Status-String Contract (gate 23) -- `ENCRYPTED` is a locked token, so every
   `-match` consumer must be checked in the same edit.
3. **The BitLocker screen must list each fixed drive** with its size and
   state, and the time estimate must total them -- which also interacts with
   FT-163/164, since that estimate currently reads the wrong disk *and*
   ignores used space.
4. **Say it plainly on Pro:** encrypting C: does not encrypt D:, and here is
   how to encrypt D: as well.
5. External/USB drives stay out of scope (BitLocker To Go is a separate
   feature and a separate decision). Say so rather than staying silent.

### Field-test step added

SANDY has C: 250 GB and D: 1 TB. After the encryption in Phase 4, record
`Get-BitLockerVolume | Select MountPoint, VolumeType, VolumeStatus,
EncryptionPercentage` for **every** volume. That single reading answers
whether Home Device Encryption covers a second fixed drive -- a question this
project has never been able to answer, and one that decides how much of
FT-167 is a Pro-only defect.

---

## 5f. FT-168 -- FREE-SPACE WIPE: THE REMNANT GAP, AND WHY *NOT* TO SHIP ERASER

Bill's proposal, 2026-08-02: users worry about what is recoverable from free
space; recommend a wiper. He has done this before at scale -- a nuclear plant
contractor incident, 8 TB server plus a dozen workstations, sanitised with
**Eraser** after backing up everything legitimate.

**The instinct is right and the gap is real.** Used-space-only encryption
leaves data deleted *before* encryption sitting unencrypted in free space and
recoverable with ordinary forensic tools. On SANDY's D: that is **852 GB of
free space on a drive in service since 2019.**

### Use the Windows built-in, not a third-party wiper

**`manage-bde -w` exists for exactly this.** Microsoft's own help text:

> *"Wipes the free space on the volume removing any data fragments that may
> have existed in the space. If used with a volume that was encrypted using
> the data only option **provides the same level of protection as if the
> volume had been encrypted with the full encryption option**."*

`cipher /w` is the equivalent for volumes that are not BitLocker-encrypted.

**Why not Eraser, despite it being good software.** It is genuine, still
maintained (Heidi Computers Ltd, **Ireland** -- `eraser.heidi.ie`, v6.2.0.2996,
April 2025, GPL). Note the source: Bill recalled it as "heise.de", which is
Heise Medien, a German publisher whose portal *mirrors* software. For a
security tool published to seniors, point at the vendor, never a mirror.

The reason to decline is the audience:

1. **Eraser's purpose is irrecoverable destruction, and it wipes files and
   folders as readily as free space.** Bill's use was an IT professional,
   with backups verified first, deliberately sanitising. A 75-year-old
   following written steps is a different risk profile -- one wrong selection
   and the family photographs are gone beyond any recovery service.
   `manage-bde -w` has no such mode; it touches free space only.
2. No download, no installer, no supply chain to still be trustworthy in
   three years when the guide is still online.
3. CLAUDE.md's approved-products rule is written for AV, but its spirit --
   name only vetted products, state country of origin -- applies here too.

### RESEARCHED CONCERNS -- both real, both change the advice

**1. NEVER run it on an SSD.** *Sourced:* free-space wiping consumes finite
write cycles for little benefit, because TRIM plus wear-levelling means the
operating system cannot reliably overwrite the physical cells holding the old
data. Manufacturer secure-erase (Samsung Magician, Crucial, WD) is the correct
tool on solid state. **This makes the advice drive-type-dependent, which the
copy must say plainly.** CGDELL is NVMe SSD -- it must not be used to test
this.

**2. Home-edition support is UNCONFIRMED and is a potential blocker.**
*Sourced:* `manage-bde -status`, suspend/resume and `Disable-BitLocker` are
reported working on Home. **`-w` specifically is not confirmed anywhere.**
manage-bde is documented as primarily a Pro/Enterprise/Education tool. If
`-w` refuses on Home, the tip is useless to most of our users and the answer
becomes `cipher /w` instead -- which is a plain Windows utility with no
BitLocker dependency.

**3. A contradiction to resolve.** One source states Device Encryption is
available on Home only with TPM **and modern standby**. Our own ascii38 run
found msinfo32 reporting *"Automatic Device Encryption Support: Meets
prerequisites"* on SANDY, and `Test-DeviceEncryptionPrereq` checks TPM,
Secure Boot and WinRE -- **not** modern standby. Later Windows 11 releases
are understood to have relaxed the hardware bar. **Unverified either way.**
SANDY's `powercfg /a` settles it, and `Measure-Encryption` now reports it.

### The cost is not extra -- it is the same work, moved

`manage-bde -w` writes across the whole free space, so on SANDY's D: that is
~852 GB -- about what full-disk encryption would have cost up front. The real
choice is **full-disk now** or **used-space-only now plus `-w` later**. Same
total work, same end state. Worth saying in the copy, because "full disk takes
longer" reads as a penalty until you know the alternative costs the same.

### Deliverables

- **Tip for `tips.html`:** *"Anything you deleted before turning encryption on
  may still be recoverable. Here is the one command that fixes it."* Built-in,
  one line, no download. **Must state: hard drives yes, solid-state no.**
- **Candidate Checkup item -- treat with care.** It is long-running (hours),
  must never run on an SSD, and must never be triggered without the user
  understanding the time cost. If it ships, it belongs in the
  ask-before-apply convenience band (gate 22), never in the main run.
- **Test before 2026-09-01** on SANDY's D: **after** encryption completes.
  Never on CGDELL.

---

## 5g. FT-169 -- "SET ONCE, PROTECTED FOREVER": THE REASSURANCE NOBODY IS TELLING THEM

**Ship this line in ascii40, the guide, the website, AND the marketing copy.**
Bill, 2026-08-02.

> **No maintenance, no second encryption pass, no "top-up." Every file you
> save from now on is encrypted automatically.**

### Why it belongs everywhere

A senior who has just been told their drive is encrypted has an obvious next
worry: *does it wear off? Do I have to do it again when the drive fills up?
Is there a subscription?* Nobody answers that, so the worry stays. It is one
sentence, and it converts a completed task into permanent peace of mind.

It is also the honest counterweight to FT-168. That item tells the user
something uncomfortable -- material deleted **before** encryption may still be
recoverable. Left alone, that reads as "encryption is leaky." Paired with this
line, the true picture lands: **everything from this moment forward is
covered, permanently, with nothing more to do.**

### It is a MEASURED claim, not a marketing one

Verified on CGDELL, 2026-08-02, across this session:

| | |
|---|---|
| Used space, first reading | 91.6 GB |
| Used space, later reading | **92.7 GB** (~1.1 GB written during the day) |
| `EncryptionPercentage` | **100** -- unchanged |
| `VolumeStatus` | `FullyEncrypted` -- unchanged |
| `ProtectionStatus` | `On` -- unchanged |
| `manage-bde -status` | "Fully Encrypted", "100.0%" -- agrees |

New data was written and the figure did not move. That is the claim,
demonstrated on our own machine rather than asserted from documentation --
which is what lets it go in marketing without breaching RESEARCH BEFORE
STATING.

### Where it goes

| Destination | Placement |
|---|---|
| **ascii40** | The Device Encryption screens -- on the "how to tell it is running" screen, after the user confirms it is on. That screen currently ends on mechanics; it should end on reassurance |
| **Guide** | The Device Encryption / BitLocker section, immediately after the "how to confirm it worked" steps |
| **Website** | `bitlocker.html` -- same position, after the confirmation steps |
| **Marketing** | T-MK. Reads naturally as **"Set it once. Protected forever."** A genuine differentiator: no subscription, no upkeep, no expiry -- unusual to be able to say honestly in security |

### The approved tagline (Bill, 2026-08-02)

> ## **Set it once. Protected forever.**
>
> **No subscription. No upkeep. No expiry.**

Use across ascii40, the guide, the website and marketing.

### *** SCOPE THIS CLAIM TO THE ENCRYPTION, NOT TO CHECKUP ***

**Read before this goes into any marketing copy.**

"No subscription, no upkeep, no expiry" is **completely true of the
encryption** -- Device Encryption and BitLocker are Windows features, free,
permanent, with nothing to renew.

**It is NOT yet established as true of GatewayGuard Checkup itself.** CPM open
decision 1 carries **Annual Updates pricing at a working number of
$12.99/update**. A reader who meets "No subscription. No upkeep. No expiry."
on a GatewayGuard page will reasonably take it as a statement about
GatewayGuard, and then meets a paid-update model. That is a business-model
accuracy problem (ProjectInstructions, BUSINESS MODEL ACCURACY), and the kind
a customer is entitled to complain about.

**Two safe framings -- Bill to choose:**

**(a) Scoped to the encryption. Safe today, no decision needed.**
> **Set it once. Protected forever.**
> The encryption you switch on today needs no subscription, no upkeep, and
> never expires. Every file you save from now on is encrypted automatically.

**(b) Extended to Checkup. Requires the pricing decision to be settled first,
and requires that "optional paid updates" genuinely does not read as a
subscription.**

**Recommendation: use (a) everywhere until CPM decision 1 is closed.** It
loses nothing -- the reassurance the user actually wants is about their data,
not the invoice -- and it cannot age into a false claim.

### Wording rules that apply

- No "whether" or "whereas" (banned 2026-08-02).
- Name the user's permission where a change is described.
- Keep it plain: *"Every file you save from now on is encrypted
  automatically"* beats any phrasing containing "on-the-fly" or "transparent
  encryption."

---

## 5h. FT-170 -- CHECKUP CREATES TWO FOLDERS ON THE USER'S C: DRIVE AND NEVER SAYS SO

**Raised by Bill, 2026-08-07.** His words: *"Checkup tool needs to setup
c:\gatewayguard\logs automatically with users approval of course."*

**The first half is already done. The second half is the whole defect.**

### What the build actually does -- measured in ascii39

The folder is created automatically, in three places, all silent:

| Line | Creates | How |
|---|---|---|
| 1530 | `C:\GatewayGuard\Logs` | `New-Item -ItemType Directory -Force`, inside a `try` |
| 1571 | `C:\GatewayGuard\Logs` | same, in the second write path |
| 1583 | `C:\ProgramData\GatewayGuard\Logs` | same -- a **second** folder nobody has been told about |

So Checkup does not need to *learn* to create the folder. It creates **two**
folders, one of them at the root of the user's C: drive, and mentions neither
before doing it. The user is told the log *exists* -- screens at lines 2733,
3527 and 6287 name the path -- but only **after** the folder has been made.

### Why this is a defect and not a nicety

The product's central promise is *"Checkup never applies anything you did not
choose."* CLAUDE.md turned that into a writing rule on 2026-08-02: **every
sentence describing what Checkup does to a machine names the user's
permission.** Creating a directory at the root of `C:` is a change to the
machine. It is currently the one change Checkup makes that it never asks about.

The audience makes it worse, not better. This tool is for a nervous
non-technical senior who has just been taught to be suspicious of software. A
new folder appearing at the top of their C: drive, unexplained, is precisely
the shape of the thing they have been told to worry about. The tool that
teaches vigilance should not be the thing that trips it.

### The second, quieter half: it fails invisibly

Both creations sit inside `try` blocks with no failure branch. If the directory
cannot be made -- permissions, a policy-locked root, a full disk -- logging
degrades silently and the run continues. That is a **Class 1 invisible
failure**, the same family as FT-161 and FT-162: the log said `[GOOD]` while
nothing had happened. A tool whose entire support story is "check the log"
must never lose its log quietly.

### What ascii40 owes

1. **Ask first, once.** Before the first write, a screen that names **both**
   paths, says what is written there (a plain-text record of this run, nothing
   else), says nothing else is ever written to them, and asks permission in the
   tool's own words -- "turn on", not "switch".
2. **Offer somewhere else, not a dead end.** If the answer is no, do not simply
   proceed without a log. Offer the user's own Documents folder as an
   alternative, and say plainly what is lost if they decline entirely: no record
   to consult, and nothing to send if they ever ask for help.
3. **Say so when it fails.** Replace the silent `try` with a visible message
   naming the folder that could not be created and where the log went instead.
4. **Disclose `C:\ProgramData\GatewayGuard\Logs` as well.** It is a real second
   copy on the user's disk and has never been mentioned on any screen.
5. **Do not move or rename either path.** `C:\GatewayGuard\` is a fixed recovery
   point (CLAUDE.md). This is a disclosure and consent defect, not a path
   defect. The fix is in what the user is told, not in where the file goes.

**Related:** the same "say who authorized it" rule that produced the 2026-08-02
website pass. This is that rule pointed at the tool's own behaviour rather than
at its copy.

---

## 5. OPEN QUESTIONS CARRIED FORWARD

1. ~~**FT-109 is not closed**~~ -- **CLOSED 2026-08-02**, see section 5a.
   Replaced by **FT-161** (power conditions), which is open.
2. **FT-110's second half** -- the recovery key has still never been observed
   reaching a Microsoft account.
3. **Edge settings (items 13, 15)** remain unreliable across machines. Per gate
   13 they keep reporting Unknown with manual steps rather than being coded
   against inconsistent registry evidence.
4. **Finding 3.8 untestable** -- no machine with Defender stopped.
5. **FT-159's original error** -- the 13:42:57 "System error." was NOT traced to
   a call. ascii39 instruments the class rather than guessing the instance; the
   next run should name it.
6. **Mouse/trackpad settings for seniors** -- post-launch research item, carried
   from the ascii38 record.
