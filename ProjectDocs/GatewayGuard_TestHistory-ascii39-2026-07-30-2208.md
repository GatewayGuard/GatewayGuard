<!-- Dated: 2026-07-30 22:08 EDT -->
# GatewayGuard Test History -- ascii39

- **Document Name:** GatewayGuard_TestHistory-ascii39
- **Last Modified:** 2026-07-30 22:08 EDT
- **Status:** Cumulative Master Document
- **Change History Log:**
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

## 5. OPEN QUESTIONS CARRIED FORWARD

1. **FT-109 is not closed** -- open Task Scheduler on SANDY (gate 21, C-25).
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
