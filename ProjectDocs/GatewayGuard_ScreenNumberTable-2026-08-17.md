<!-- Dated: 2026-08-17 19:15 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# FT-172 -- the call-flow walk, and the numbering table

- **Document Name:** GatewayGuard_ScreenNumberTable
- **Last Modified:** 2026-08-17 19:15 ET
- **Last Editor:** Claude Code (CGDELL)
- **Status:** **BUILT AND SHIPPED IN ascii41, 2026-08-17.** This document is
  question 3 of the design document answered -- the call-flow walk, and the
  table it produced. The design is approved and closed; see
  `GatewayGuard_ScreenNumberDesign-2026-08-15-1430.md`.
- **Where the table now lives:** `$script:GGScreenLabels` in the build. The
  tables below are **generated from `Tool\build_ascii41_ft172.py`**, so this
  document cannot drift from the code. Regenerate rather than hand-edit.
- **Build walked:** `W11-SecurityHardening-v3-ascii40-2026-08-15-0828.ps1`
  (the walk); shipped in `W11-SecurityHardening-v3-ascii41-2026-08-17-2246.ps1`
- **Checked against:** `Test_Results\Logs-Sandy\GatewayGuard-Log-2026-08-17_09-44.txt`
  (31 screens, Home, Console mode) and `..._17-36.txt` (resume path)

---

## THE ANSWER TO BILL'S QUESTION: NO, THE USER NEVER GOES BACK TO A LOWER NUMBER

Bill, 2026-08-17: *"Using the integer solution, does the user ever go back to a
lower integer?"*

**measured: no. Not in BitLocker, and not anywhere else in the program.**

This is the risk the design document called *"the main technical risk"* and
*"NOT established"* -- that two screens might be **first seen in opposite
orders on different paths**, which no single numbering can satisfy. **The walk
found no such pair.** Here is why, case by case.

| Where an inversion could have lived | What the walk found | Verdict |
|---|---|---|
| Console mode vs GUI mode | Both call `Show-BitLockerScreen` -> `Setup-ScheduledTasks` -> `Show-ManualSteps`, in that order. GUI omits SCREEN-69 and SCREEN-23/71 but **reverses nothing**. GUI is a strict subsequence of Console. | Safe |
| Home vs Pro BitLocker | `Show-BitLockerHomeScreen` (61,63,62,79,82,80,81) and the Pro block (64,65,66,67) are mutually exclusive. No user sees both. | Safe |
| Fresh run vs resume | The paths diverge at launch and rejoin at `Get-WinEdition`. A resumer sees SCREEN-25/31/83 and never the intro; a fresh user sees the intro and never 25/31/83. | Safe |
| Declining BitLocker vs accepting | SCREEN-58/60/68 fire only on decline, inside the checklist loop. SCREEN-61-67 fire only on accept, after it. Mutually exclusive. | Safe |
| The checklist hub, returned to dozens of times | Revisits, which Bill exempted on 2026-08-15. | Safe by rule |
| `Test-NonRecommendedSelections` shown at "review" AND "final" | The same function, called twice in one loop -- line 7816 and line 7886. A revisit. | Safe by rule |
| The offline-scan reboot | `Show-PostScanGuidance` (SCREEN-40) renders early on a reboot-resume. Numbering restarts each run, so within-run order is what binds. | Safe |

**Every multi-route case turned out to be a mutually exclusive pair.** That is
precisely the shape the branch-letter scheme was chosen to handle, so the
scheme absorbs all of them without an exception.

**This is measured, not proven.** It is a walk of the call flow by hand,
checked against two field logs. **Build step 4 turns it into a gate that
re-checks it on every build** -- FT-162's lesson stands: a rule with no check
is a wish.

---

## TWO THINGS THE WALK CHANGED

Both are mine to decide under question 3, both are recorded here rather than
buried, because they change what the table looks like.

### 1. "Every user reaches it" is too strict to be usable

The design document defines main line as *"only screens every user reaches
get an integer."* **Applied literally, almost nothing qualifies.** Once
resumes, Home/Pro, checkpoint skips and the six mutually exclusive antivirus
states are counted, the set of screens reached by literally every user is close
to empty -- and the main line would be a handful of integers with everything
else lettered, which is the opposite of what the scheme is for.

**The workable definition, and the one this table uses:**

> **Main line = the canonical journey. A first run, Console mode, nothing
> skipped, no deviation. Branches = departures from it.**

This keeps 1..N gapless for the ordinary user, which was the whole argument for
branch letters over flat numbering. It also matches how Bill talks about it --
*"position in their journey."*

### 2. Mutually exclusive alternatives -- CORRECTED WHILE BUILDING

**The first version of this section was wrong and is withdrawn.** It said
*"mutually exclusive alternatives all take letters -- none takes the
integer"*, generalising from the design document's Home/Pro example. Applying
it to the build broke immediately.

**What broke it.** `Test-DefenderPrimary` paints one of SCREEN-41 to 46 by
antivirus state. Under "none takes the integer", **SCREEN-43 -- the healthy
setup, which is what almost every user sees -- becomes a letter**, and the
main line acquires a hole at the most-visited screen in that stretch. The same
rule made SCREEN-62 ("your PC meets the requirements") a letter while the
failure case sat beside it, equally lettered.

**The Home/Pro precedent does not say what I read into it.** There, screen 8
is a *shared* screen that both editions reach, and the branches hang off it.
There is no shared screen among the six antivirus states -- one of them simply
*is* the journey.

**The rule that is actually consistent, and the one the build uses:**

> **The canonical journey takes integers. Everything off it takes letters.**

That is the definition already committed to in point 1, applied without an
exception. Under it: SCREEN-43 is 17 and 41/42/44/45/46 are 17a-17e; SCREEN-62
is 29 and SCREEN-63 is 28a; Home walks the integers and Pro branches. **No
integer belongs to a screen that the ordinary user does not see**, which is
the property that mattered all along -- I had simply stated it backwards.

---

## THE CANONICAL JOURNEY -- 34 integers, AS BUILT

**These are the values in the shipped table**, generated from
`Tool\build_ascii41_ft172.py` so this document cannot drift from the code.
Walked from the entry point and confirmed against the 2026-08-17 SANDY logs.

**An earlier draft of this section said 30 integers.** It was written before
the build and before the correction in point 2 above -- restoring SCREEN-43
and SCREEN-62 to the main line, and giving the checklist's two pages
consecutive numbers rather than one shared one, took it to 34.

| # | ID | Screen |
|---|---|---|
| **1** | 85 | Welcome / maximize |
| **2** | 86 | Scrolling |
| **3** | 87 | Set your console font |
| **4** | 28 | FONT CHECK |
| **5** | 29 | Before you start -- your window |
| **6** | 78 | Before you start -- your keyboard |
| **7** | 30 | What happens next |
| **8** | 02 | How to scroll back and copy |
| **9** | 05 | Important -- read before continuing |
| **10** | 34 | Windows edition detected |
| **11** | 35 | Your PC -- RAM |
| **12** | 09 | Your system at a glance |
| **13** | 26 | Your PC's security tools |
| **14** | 27 | The scans we recommend |
| **15** | 10 | Pre-scan prep checklist |
| **16** | 38 | Defender offline scan |
| **17** | 43 | Antivirus status -- healthy setup |
| **18** | 73 | Malwarebytes detected |
| **19** | 50 | Power settings -- security review |
| **20** | 51 | Apps audit results |
| **21** | 52 | Mode selector |
| **22** | 53 | Quick question -- your passwords |
| **23** | 54 | What Checkup does and does not do (1 of 2) |
| **24** | 75 | What Checkup does and does not do (2 of 2) |
| **25** | 76 | The security checklist, page 1 |
| **26** | 77 | The security checklist, page 2 |
| **27** | 55 | Review your selections |
| **28** | 61 | Final item: device encryption |
| **29** | 62 | Your PC meets the requirements |
| **30** | 79 | Before you turn it on -- your recovery key |
| **31** | 81 | How to tell if encryption is running |
| **32** | 69 | All selected items processed |
| **33** | 70 | Automated scan schedule setup |
| **34** | 72 | Automated steps complete |

**34 integers, 1..34, gapless.** Bill's approved BitLocker
decision -- integers for the end block -- is rows 28 to 31.

---

## THE BRANCHES -- letters off the integer they follow

One level only, per Bill's 2026-08-17 answer. There is no 8a1.

| Letter | ID | Screen |
|---|---|---|
| **1a** | 25 | Welcome back -- a checkpoint exists |
| **1b** | 31 | Quick re-check before resuming |
| **1c** | 83 | Are you sure you want to close Checkup? |
| **3a** | 01 | Font instructions -- not administrator |
| **9a** | 32 | Domain-joined warning |
| **9b** | 33 | Administrator access required |
| **11a** | 36 | Time and date -- check |
| **11b** | 37 | Time and date -- out of sync |
| **14a** | 39 | Reminder: pre-scan recommended (repeat run) |
| **14b** | 40 | Welcome back -- offline scan complete |
| **17a** | 41 | Antivirus -- alternative state |
| **17b** | 42 | Antivirus -- alternative state |
| **17c** | 44 | Antivirus -- alternative state |
| **17d** | 45 | Antivirus -- alternative state |
| **17e** | 46 | Antivirus -- alternative state |
| **18a** | 13 | Malwarebytes -- alternative state |
| **18b** | 47 | Malwarebytes -- alternative state |
| **18c** | 48 | Malwarebytes -- alternative state |
| **18d** | 49 | Power / battery warning |
| **22a** | 74 | Your passwords -- we remembered your answer |
| **25a** | 56 | Non-recommended selections |
| **25b** | 57 | Non-recommended -- confirm |
| **25c** | 58 | Heads up -- skipping encryption |
| **25d** | 60 | Why encrypt? |
| **25e** | 68 | Encryption declined |
| **27a** | 59 | Applying your changes |
| **27b** | 64 | BitLocker (Windows 11 Pro) |
| **27c** | 65 | BitLocker -- what will happen (Pro) |
| **27d** | 66 | BitLocker -- confirm (Pro) |
| **27e** | 67 | BitLocker enabled (Pro) |
| **28a** | 63 | Your PC does not meet the requirements |
| **30a** | 82 | Recovery key -- variant |
| **30b** | 80 | How to sign in with a Microsoft account |
| **33a** | 23 | Convenience review |
| **33b** | 71 | Convenience review -- result |
| *(none)* | 84 | About this Checkup run (the I key) |

**35 lettered branches and 1 deliberately unnumbered
screen. 70 screens in total**, which
matches gate 12's count exactly: 65 `Draw-Box` screens, 2 hand-drawn checklist
pages, and the 3 intro screens that FT-172 finally gave IDs to.

**Why SCREEN-84 has no number.** The `I` screen is reachable from every
prompt, so it hangs off no integer. Any number would be a claim about where
the user is in their journey, and it would be false everywhere except one
place. Its title says what it is; that is enough.

**Note on the Pro screens (27b-27e).** Pro branches while Home walks the
integers. That is not favouritism -- it is the approved rule applied: the
canonical journey is Home, which is the majority of the target market and the
edition the product is tested on. Both climb, neither has a hole.

---

## WHAT THIS DOES NOT COVER

- **The identity banner (FT-184) is CUT. Bill, 2026-08-17.** It is deleted
  rather than promoted to screen 1, so **the integers above are final and do
  not shift.** Bill's reason disposed of my recommendation: *"no senior
  including me is going to remember that"* -- the build number and Machine ID
  are needed on a support call days later, and no screen shown at launch can
  serve that. They are fetched on demand instead, under **FT-189** (an `I` key
  at every prompt, plus `Open-My-Log.bat`). **The `I` screen takes NO number
  at all** -- an earlier line here said it "takes a letter", which was wrong.
  It is reachable from every prompt, so any letter would anchor it to one
  integer and be false everywhere else.
- **SCREEN-01, 63 and 82 were INFERRED when this table was drafted, and one
  was materially wrong.** Read off the source 2026-08-17 and corrected in both
  the build script and the shipped comments:

  | ID | I had written | It actually is | Trigger |
  |---|---|---|---|
  | 01 | "Font instructions -- not administrator" | "IMPORTANT -- HOW TO RUN GATEWAYGUARD CORRECTLY" | `if (-not $global:IsAdmin)` |
  | 63 | "Your PC does not meet the requirements" | "DEVICE ENCRYPTION MAY NOT BE AVAILABLE ON THIS PC" | `if (-not $allGood)` |
  | 82 | "Recovery key -- variant" | "YOU ARE ALREADY SIGNED IN WITH A MICROSOFT ACCOUNT" | `if ($ggAcct -eq "Microsoft")` |

  **82 is the one that mattered.** It is not a recovery-key screen at all --
  it is the alternative to SCREEN-80, shown when the user already has a
  Microsoft account. The letters survive the correction: 80 and 82 are a
  genuine either/or with no dominant case, so the user climbs 30 -> 30a or
  30b -> 31 either way. That is the Home/Pro shape the design document already
  blessed.
- **`Run-GUIMode` paints no `Draw-Box` screens of its own** -- it is a WPF
  window. Its shared screens are already in the table.

---

## NEXT, IN ORDER

**Built and shipped in ascii41 on 2026-08-17.** Gates 12, 12b and 24 pass;
0 parse errors, 0 duplicate function definitions, 0 typed `N of M` remaining.
Gate 12 counts 70 numbered screens, which matches this table exactly.

**Done:**

1. ~~Confirm the three inferred titles against source.~~ Done -- see above.
   One was wrong.
2. ~~Build the table into the tool.~~ Done -- `$script:GGScreenLabels`,
   `Get-ScreenNumber` reads it, the three intro screens carry IDs 85/86/87,
   all six typed numbers deleted, the checklist logs its own number.

**Still open:**

3. **Extend gate 12 to fail the build** on a screen missing from the table, a
   duplicate label, a gap in the main line, a typed `N of M` reappearing, or
   any path that produces a first-encounter decrease. **The build script
   asserts the first four on every run today** -- duplicate IDs, duplicate
   labels, gapless 1..N, and one-level-only branches -- but a build script only
   checks the build it runs. Gate 12 checks the file. **Until this is done, the
   walk's conclusion is measured and not enforced**, which is exactly the
   "a rule with no check is a wish" position FT-162 earned.
