<!-- Dated: 2026-07-26 06:19 ET -->
# GatewayGuard Defect Prevention Playbook
**File:** GatewayGuard_DefectPreventionPlaybook-2026-07-26-0619.md
**Author:** William F. Burns III | GatewayGuard
**Audience:** Developer-facing (expert audience -- technical language applies)
**Purpose:** Distill FT-01 through FT-70 into durable rules that prevent
repeat defects in the ascii builds and in future GatewayGuard software
projects. Every rule below is anchored to a defect that actually happened.

**Change History Log:**
- 2026-07-26 06:19 ET: Added CLASS 7 -- BUILD-TOOLING FAILURES, earned by
  the 2026-07-25 ascii34 corruption. Added Pre-Build Audit item 11 (parse
  check + size sanity). Added Class 6 rule 5 (close the defect that was
  reported), earned by FT-116. Six classes became seven.
- 2026-07-25 19:36 ET: Added USER-FACING CLARITY rule to Class 3 (rule 5
  and updated Verification). No other content changed.

---

## THE SEVEN FAILURE CLASSES

Seventy field-test items reduce to six recurring classes of runtime defect,
plus one class that damages the source itself. New code should be checked
against all seven before it ships.

### CLASS 1 -- INVISIBLE FAILURES (the most expensive class)

**What happened:** FT-37 -- one line of invalid PowerShell (`return if`)
threw silently at runtime for weeks, producing false DEFENDER IS OFF alarms.
2026-07-13 -- two session crashes left zero error lines in the log; the
console window closed instantly and the only evidence was "the last screen
that rendered." FT-36 -- a diagnostic log line never fired because the throw
happened before it.

**The rules:**
1. Every program has exactly one top-level try/catch that logs the exception
   message, location, and script stack trace, saves the log footer, runs
   cleanup, and HOLDS THE WINDOW OPEN. A crash the user cannot screenshot is
   a crash you cannot fix. (Implemented as FT-66 in ascii29.)
2. Log BEFORE the operation that can throw, not after (FT-61 lesson: the
   raw powercfg output is now logged before parsing).
3. Never let a catch block be empty on a code path that changes program
   behavior. Empty catch is acceptable only for cosmetic/best-effort actions.
4. Expert anchor: "fail fast, fail loudly" -- a program that dies visibly at
   the fault line is debugged in minutes; one that limps past it silently is
   debugged in weeks. FT-37 cost multiple field-test rounds.

**Verification:** Kill test -- deliberately inject `throw "test"` at three
random points in a release candidate; confirm all three produce a logged
ERROR line with stack trace and a held-open window. Remove before shipping.

### CLASS 2 -- CONSOLE INPUT MACHINERY

**What happened:** FT-01 (QuickEdit click froze sessions for 9 hours),
FT-24 (Ctrl+C killed the tool mid-session), FT-29 (a buffer flush ate first
keypresses), FT-46 (the console host silently resets input mode, undoing
TreatControlCAsInput), FT-65 (keyboard auto-repeat flooded a prompt with 52
accepted keys in 2.5 minutes).

**The rules:**
1. ALL key input goes through the hardened readers (Read-ValidKey,
   Pause-ForUser, Read-NavKey). No raw ReadKey outside them without the
   full protection pattern (try/catch, mode re-assert, Ctrl+C handling).
2. NO global pre-read buffer flush -- FT-29 proved it eats legitimate
   early keypresses. When flooding is possible (a key that returns to the
   same prompt), use a TARGETED post-accept drain: after accepting the key,
   drain KeyAvailable, then continue. Drain after accept, never before read.
3. Re-assert console modes (TreatControlCAsInput) immediately before every
   read -- the host resets them on its own reads (FT-46).
4. Any key that loops back to its own prompt (like S = show explanation)
   must clear and re-render the screen -- appending output turns auto-repeat
   into an avalanche (FT-65).
5. Ctrl+C is neither fatal (FT-24) nor dead (7/13 field report): it opens
   the exit confirmation. Guard against recursion at the confirmation's own
   prompt. (Implemented as FT-69 in ascii29.)
6. Expert anchor: console input on Windows is shared mutable state between
   your program and the host. Treat every read as if the mode flags were
   just reset and the buffer may contain stale keys -- because both are true.

**Verification:** Hold-key test on every looping prompt (hold the hotkey for
five seconds -- screen must remain readable and one keypress must equal one
action). Ctrl+C test at five random screens. Alt-Tab-away-and-back test at
the checklist.

### CLASS 3 -- CONTRADICTORY OR DRIFTING USER-FACING TEXT

**What happened:** FT-65's root cause was not code -- it was COPY. The menu
said "S = Show me what each item does"; the prompt two lines below said
"S = Skip." The tester believed the prompt, and the resulting confusion
looked like a program loop. Also FT-43 (screen-timeout wording contradicted
sleep-prevention wording on the same screen) and FT-55 (the "what this tool
does" claims drifted from what the tool actually did). The Mark-mode copy tip
(ascii31+) revealed a related class of failure: prompts that named a key
without stating what happens when you press it -- or what happens if you
don't -- leaving a senior user unable to predict the outcome before acting.

**The rules:**
1. A hotkey's meaning is written ONCE per screen. If the menu explains the
   keys, the prompt says only "Your choice (Y/N/S):" -- or the prompt
   restates the SAME words, copied, not retyped.
2. The letter S is overloaded in this codebase (Skip on some screens, Show
   on others). That is acceptable ONLY if each screen is internally
   consistent. Pre-ship check: grep every `ValidKeys` line, read the prompt
   and menu for each, confirm they agree.
3. Any screen that makes a claim about tool behavior ("this tool does X")
   gets re-verified against the code whenever the referenced feature
   changes (FT-55).
4. Expert anchor: users trust the words nearest the cursor. In a conflict
   between a menu and a prompt, the prompt wins -- so the prompt must never
   be wrong.
5. USER-FACING CLARITY: Every prompt, key label, and instruction shown to
   the user must state the outcome of EACH choice explicitly -- including
   what happens if the user does NOT take the primary action. Never write
   "press X when done" if X and "done" mean different things depending on
   context. Never name a key without naming its result. Test: can a
   non-technical senior user predict exactly what will happen before they
   press the key?

   Correct: "Press Enter to copy. Press Esc to exit without copying."
   Wrong:   "Press Enter or Esc when done."

   This applies to every piece of user-facing text: prompts, key labels,
   status strings, tip lines, review copy, and confirmation screens. When
   two or more keys are presented, every key gets its own outcome stated.

**Verification:** The hotkey-consistency grep (Appendix A) plus a read-aloud
pass of every changed screen: read it as a first-time senior user would. For
every prompt naming two or more keys, confirm EACH key has an explicit stated
outcome -- not just the primary action.

### CLASS 4 -- WINDOWS / POWERSHELL SHARP EDGES

**What happened:** The 0x80000003 bug (PowerShell parses hex literals as
SIGNED Int32 -- a hex constant near the sign bit went negative before the
[uint32] cast). The $yPos crash (a variable silently became a multi-element
array; GUI positioning then threw). The switch -Wildcard missing `break`
(`*Professional*` matched two patterns and returned a duplicated array).
FT-61 (powercfg errors were hidden because stderr was not captured; 0xFFFFFFFF
was not treated as "Never").

**The rules:**
1. DECIMAL literals only for any constant at or near bit 31
   (2147483648, not 0x80000000). Already codified; re-check every new
   P/Invoke or console-mode constant.
2. Cast at boundaries: any value read from WMI, registry, powercfg, or a
   pipeline that COULD be an array gets [string], [int], or
   Select-Object -First 1 before property/method access. The ascii29 review
   listing now does this (FT-68) -- apply the pattern everywhere a value
   crosses from "queried" to "used."
3. Every `switch -Wildcard` branch ends in `break`. No exceptions.
4. External commands: capture stderr (2>&1), log the RAW output before
   parsing it, and treat sentinel values (0xFFFFFFFF = Never) explicitly.
5. PS 5.1 only: no Join-String, no ternary, no null-coalescing. The target
   machine is the oldest supported Windows 11 Home box, not the dev box.
6. Expert anchor: PowerShell's type system is helpful until it is not.
   Defensive casting at input boundaries is cheaper than any debugging
   session it prevents.

**Verification:** Appendix A grep suite (hex-literal scan, switch -Wildcard
break scan) on every build.

### CLASS 5 -- STATE, RESUME, AND CHECKPOINT COMPLEXITY

**What happened:** FT-35 -- an accidental non-admin double-click reached the
resume prompt and could wipe a real checkpoint by choosing "start over."
FT-47 -- resume replayed full screens in a flash, alarming users. The 7/13
log confusion -- two sessions on consecutive nights hit the same screens at
nearly the same clock times, and distinguishing them required comparing
status-string wording between builds.

**The rules:**
1. State files carry the MINIMUM: the checkpoint name. Never persist or
   restore presentation state, log paths, or anything about the previous
   session's environment. Each launch owns its own log file, unconditionally.
2. Destructive state actions (clearing a checkpoint) sit behind the same
   gates as destructive system actions: admin check first (FT-35), explicit
   confirmation always.
3. Every log header carries build ID, run date, and machine ID (FT-19) --
   this is what made the 7/13 log analysis possible at all. Keep it.
4. Resume re-verifies cheap safety facts quietly (FT-47's one-screen
   re-check), and re-verifies them ALL -- resumption is a new session on
   possibly-changed hardware.

**Verification:** Resume matrix per release: fresh run, resume-after-reboot,
resume-after-crash, non-admin double-click, start-over. Five paths, every
build that touches state code.

### CLASS 6 -- EXTRA MACHINERY (the flush-bug lesson, generalized)

**What happened:** FT-29 -- a buffer flush added to fix one problem created
a worse one (eaten keypresses) and took five field reports to root-cause.
The back-navigation decision consciously chose extending an existing
mechanism over adding a test-only counter mode for the same reason.

**The rules:**
1. Before adding a compensating mechanism, ask: can the underlying cause be
   REMOVED instead? Removal beat addition in FT-01 (disable QuickEdit),
   FT-29 (delete the flush), and FT-65 (fix the label, not the keyboard).
2. Every new mechanism must name the failure it prevents AND the new
   failures it could cause, in its code comment, before it merges.
3. One change class per build where possible. ascii26 was superseded without
   ever being run -- an untested build is not a build, it is a liability.
   Never let two builds stack unrun.
4. Expert anchor: every line of code is a liability until field-tested.
   The cheapest defect is the mechanism you did not add.
5. CLOSE THE DEFECT THAT WAS REPORTED, not a proxy for it. Before marking
   a field-reported item fixed, re-read the ORIGINAL field note verbatim
   and confirm the change satisfies what was actually asked for. A fix
   aimed at an adjacent symptom is the worst outcome available: it adds
   machinery, consumes a build slot, and closes the ticket while leaving
   the user's problem exactly where it was.

   **What earned this (FT-116):** field note 1 read "No screen numbering"
   -- the tester wanted stable screen IDs he could cite in notes. It was
   filed as FT-116 and closed in ascii34 by changing the "Section -- Step
   N" counter from DarkCyan to Cyan so it would be more visible. That is
   a different thing: a step counter is not a screen ID, and the reported
   need was never met. It surfaced again on 2026-07-26 only because the
   tester asked whether screens were numbered -- nine months of build
   cycles could have passed with the item marked RESOLVED.

**Verification:** Changelog review -- if a build's change list mixes input
handling + state + UI copy + new features, split it. For every item marked
RESOLVED this build, paste the original field note next to the fix
description and confirm they match.

### CLASS 7 -- BUILD-TOOLING FAILURES (the edit that destroys the source)

**Why this class exists:** Classes 1-6 all describe ways the PROGRAM
misbehaves at runtime. None of them cover the toolchain damaging the
source file itself -- and on 2026-07-25 that is exactly what happened.
By this playbook's own method (no defect without a rule), it earns a class.

**What happened:** A PSScriptAnalyzer cleanup pass on ascii34 -- 40
empty-catch and 18 WMI findings, purely cosmetic work -- was applied as a
bulk raw-PowerShell string replace instead of the assert-guarded Python
wrapper the standards require. The replace ran away and duplicated the
file's content roughly 40x: 341 KB / 5,574 lines became 13.7 MB / 228,739
lines, no longer parseable. "FT-116" appeared 82 times where it should
appear twice. The damage was not noticed by any gate -- it surfaced when
the lint tool itself started reporting parse errors.

**The rules:**
1. The assert-guarded Python wrapper governs EVERY .ps1 edit, with no
   cosmetic exemption. Lint passes, comment fixes, and whitespace cleanups
   carry the same mechanical risk as feature work, because the mechanism
   that destroys the file does not know or care what the edit meant.
   (Full procedure: CodingStandards, PYTHON EDITING RULES.)
2. Every replacement is BOUNDED. An unbounded `str.replace(old, new)`
   against a pattern more common than expected is the most destructive
   single operation available in this workflow. Pass an explicit count.
3. BRACE BALANCE CANNOT DETECT THIS CLASS. Duplication copies whole
   balanced blocks, so it remains balanced by construction. Measured on
   the corrupted file: 47,232 open / 47,232 close -- perfectly balanced,
   completely destroyed. The brace check that had been the standing
   post-edit verification passed cleanly on a 41x-oversized file. Any
   integrity check whose failure mode is "still passes when the file is
   ruined" is not an integrity check.
4. The two checks that DO detect it, both mandatory after every edit
   session: a size assertion (line count / byte size delta within what
   the edit could plausibly produce) and a parse check
   (`[Parser]::ParseFile` must return 0 errors). Together they cost about
   a second and would have caught this instantly.
5. When a file is found corrupted, STOP. Do not hand-patch a damaged file
   -- that compounds the damage and destroys evidence of the mechanism.
   Identify a verified known-good recovery point, restore byte-for-byte,
   confirm by hash, and preserve the damaged copy. (Recovery points:
   CodingStandards, RECOVERY POINTS.)
6. Know the recovery point BEFORE starting a risky edit, not after. The
   difference between a ten-minute recovery and a lost night is whether
   you already knew where the last known-good copy was.
7. Expert anchor: the build tooling is production code. It operates on the
   only asset that matters and it runs unattended and unverified. Hold it
   to the same standard as the program it builds -- an unverified edit is
   an unverified write to the source of truth.

**Verification:** After every edit session, in this order -- size
assertion, parse check, brace balance, then the unique-string spot check
(pick an identifier that should appear a known number of times and count
it). Report all four. A skipped check blocks the build.

---

## THE PRE-BUILD AUDIT (run on EVERY build before it ships)

The audit that shipped ascii29 is now the floor, not the ceiling:

1. No duplicate function definitions; all required functions present.
2. Zero "press any key" strings; all input via the hardened readers.
3. No `| Join-String`; PS 5.1 compatibility scan.
4. Hex-literal scan near bit 31; decimal constants confirmed.
5. `switch -Wildcard` branches all end in `break`.
6. Hotkey label consistency: every ValidKeys prompt agrees with its menu.
7. Brace balance unchanged by the diff (delta must be zero for balanced
   insertions).
8. Non-ASCII scan: user-facing strings pure ASCII (comment-only exceptions
   documented -- 9 legacy `--` box-drawing separator comment lines carried
   from ascii28).
9. Build ID check across all FIVE locations: filename, FILE: header,
   BUILD: header, $BuildID variable, AND the "Current build" line in
   CLAUDE.md -- all match; internal Dated: matches filename date.
   (CLAUDE.md added 2026-07-26: it had drifted to ascii28 while the tree
   was on ascii34 -- six builds stale, on the very line instructing
   "always confirm current build number before any edit session." A
   pointer that lies is worse than no pointer.)
10. Paired-file check: Run-GatewayGuard.bat references the exact new .ps1
    filename, updated in the same edit.
11. FILE INTEGRITY (added 2026-07-26, Class 7): the build parses with zero
    errors, and its line count is within the plausible range for this
    build's changes. Run BOTH -- neither alone is sufficient, and brace
    balance is not a substitute for either:
    ```powershell
    $e=$null; $t=$null
    [System.Management.Automation.Language.Parser]::ParseFile($p,[ref]$t,[ref]$e)
    $e.Count                                        # must be 0
    (Get-Content $p | Measure-Object -Line).Lines   # must be plausible
    ```

Appendix A contains the exact commands so this runs identically every time.

---

## CARRY-FORWARD KIT FOR FUTURE PROJECTS

Any new GatewayGuard software project starts with these four assets, not
from a blank file:

1. **Hardened input module** -- Read-ValidKey / Pause-ForUser / Read-NavKey /
   Invoke-CtrlCExit exactly as shipped in ascii29. These functions encode
   FT-01, FT-24, FT-29, FT-46, FT-65, and FT-69. Rewriting them from memory
   re-earns those bugs.
2. **Logger with trap** -- Initialize-LogFile (header at launch, not at
   exit), Write-Log with KEY/SCREEN/NOTED/ERROR breadcrumbs, Save-Log
   footer, and the FT-66 global trap wrapping main.
3. **The audit script** (Appendix A) adapted to the new project's function
   list.
4. **This playbook** -- reviewed at project start, updated whenever a new
   FT class emerges. A defect that repeats after being written down here is
   a process failure, not a code failure.

---

## APPENDIX A -- AUDIT COMMANDS

Run from the folder containing the build (Git Bash, WSL, or any grep):

```
# 1. Duplicate functions
grep -o "^function [A-Za-z-]*" BUILD.ps1 | sort | uniq -d

# 2. Forbidden phrases and cmdlets
grep -ci "press any key" BUILD.ps1        # must be 0
grep -c "| Join-String" BUILD.ps1          # must be 0

# 3. Hex literals near the sign bit (review every hit)
grep -n "0x[89A-Fa-f][0-9A-Fa-f]\{7\}" BUILD.ps1

# 4. switch -Wildcard branches (review each for break)
grep -n -A20 "switch -Wildcard" BUILD.ps1

# 5. Hotkey consistency (read each hit's menu vs prompt)
grep -n "ValidKeys" BUILD.ps1

# 6. Build ID agreement
grep -n "BuildID\|^# FILE:\|^# BUILD:\|^REM CURRENT BUILD" BUILD.ps1 Run-GatewayGuard.bat

# 7. Non-ASCII scan (Python)
python3 -c "import io;d=io.open('BUILD.ps1','r',encoding='utf-8-sig').read();print([l[:60] for l in d.splitlines() if any(ord(c)>127 for c in l)])"
```

**8. File integrity (audit item 11 -- PowerShell, not grep).** Run after
every edit session and before every ship:

```powershell
$p = "BUILD.ps1"

# Parse check -- must be 0
$e=$null; $t=$null
[System.Management.Automation.Language.Parser]::ParseFile($p,[ref]$t,[ref]$e) | Out-Null
"Parse errors : " + $e.Count

# Size sanity -- must be plausible for this build
# NOTE: use ONE method consistently. Measure-Object -Line does NOT count
# blank lines; .Count does. On ascii34 they report 5,574 vs 5,900 -- a
# 326-line gap that is pure blank lines, not a change. Mixing methods
# between the "before" and "after" reading makes the delta meaningless.
# Project convention: the ascii NN-line figure quoted in headers and in
# CLAUDE.md is the Measure-Object -Line (non-blank) number.
"Lines non-blank : " + (Get-Content $p | Measure-Object -Line).Lines
"Lines total     : " + [System.IO.File]::ReadAllLines($p).Length
"Bytes           : " + (Get-Item $p).Length

# Brace balance -- necessary, NOT sufficient (see Class 7 rule 3)
$txt = [System.IO.File]::ReadAllText($p)
"Braces       : {0} open / {1} close" -f `
  ([regex]::Matches($txt,'\{')).Count, ([regex]::Matches($txt,'\}')).Count

# Unique-string spot check -- catches duplication that balances
"FT-116 count : " + (Select-String -Path $p -Pattern 'FT-116' -SimpleMatch).Count
```

**Reference values for ascii34 (known good):** 0 parse errors, 5,574
non-blank lines (5,900 total), 349,398 bytes, 1,152/1,152 braces, FT-116
appears 2 times, SHA256 recorded at restore.

**The corrupted 2026-07-25 file measured:** parse errors present, 228,739
lines, 13.7 MB, 47,232/47,232 braces, FT-116 appearing 82 times.

Note which checks distinguished them and which did not:

| Check | Good | Corrupt | Caught it? |
|---|---|---|---|
| Parse errors | 0 | present | **YES** |
| Line count | 5,574 | 228,739 | **YES** |
| Byte size | 349 KB | 13.7 MB | **YES** |
| Unique-string count (FT-116) | 2 | 82 | **YES** |
| Brace balance | 1,152/1,152 | 47,232/47,232 | **NO -- both balanced** |

The one check that was actually in the standing procedure is the one
that failed to fire. That is the whole lesson of Class 7.

---

*A closing note on method: every rule in this playbook exists because a
specific numbered field test earned it. That is the discipline to keep --
no rule without a defect, no defect without a rule.*
