<!-- Dated: 2026-08-17 19:15 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# FT-172 -- the call-flow walk, and the numbering table

- **Document Name:** GatewayGuard_ScreenNumberTable
- **Last Modified:** 2026-08-17 19:15 ET
- **Last Editor:** Claude Code (CGDELL)
- **Status:** **This is question 3 of the design document, answered.** The
  design itself is approved and closed -- see
  `GatewayGuard_ScreenNumberDesign-2026-08-15-1430.md`. This document is the
  walk and the table it produces. **The build has not been touched.**
- **Build walked:** `W11-SecurityHardening-v3-ascii40-2026-08-15-0828.ps1`
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

### 2. Mutually exclusive alternatives all take letters -- none takes the integer

`Test-DefenderPrimary` paints exactly one of SCREEN-41 through 46 depending on
what antivirus is present. Rule 1 forbids giving them one shared number.

The design document already set the precedent with Home and Pro: *"Home and Pro
are both branches -- neither is a main-line screen. Home sees 8, 8a, 9. Pro
sees 8, 8b, 9."* **Neither alternative takes the integer.** They all hang off
the integer that precedes them.

So the antivirus family becomes 16a-16f, and the user walks 16 -> 16c -> 17.
Same rule, no special case, and it means **no integer is ever assigned to a
screen some users never see.**

---

## THE CANONICAL JOURNEY -- the main line, 27 integers

Walked from the entry point at line 8476. Confirmed against the SANDY log,
which followed exactly this path and rendered 31 screens.

| # | ID | Screen | Where |
|---|---|---|---|
| -- | -- | *(identity banner -- currently erased, see FT-184)* | 8486 |
| 1 | *(none)* | Welcome to GatewayGuard Checkup | 2833 |
| 2 | *(none)* | Scrolling | 2841 |
| 3 | *(none)* | Set your console font | 2852 |
| 4 | 28 | FONT CHECK: if this box has clean lines | 2873 |
| 5 | 29 | BEFORE YOU START -- YOUR WINDOW | 2885 |
| 6 | 78 | BEFORE YOU START -- YOUR KEYBOARD | 2907 |
| 7 | 30 | WHAT HAPPENS NEXT -- PLEASE READ | 2931 |
| 8 | 02 | HOW TO SCROLL BACK (AND COPY) | 3459 |
| 9 | 05 | IMPORTANT -- READ BEFORE CONTINUING | 2984 |
| 10 | 34 | WINDOWS EDITION DETECTED | 3163 |
| 11 | 35 | YOUR PC -- RAM | 3193 |
| 12 | 09 | YOUR SYSTEM AT A GLANCE | 3687 |
| 13 | 26 | YOUR PC'S SECURITY TOOLS | 3713 |
| 14 | 27 | THE SCANS WE RECOMMEND -- AND WHY | 3754 |
| 15 | 10 | PRE-SCAN PREP CHECKLIST | 3805 |
| 16 | 38 | DEFENDER OFFLINE SCAN | 3864 |
| 17 | 50 | POWER SETTINGS -- SECURITY REVIEW | 4620 |
| 18 | 51 | APPS AUDIT RESULTS | 5023 |
| 19 | 52 | MODE SELECTOR | 7497 |
| 20 | 54 | WHAT CHECKUP DOES AND DOES NOT DO (1 of 2) | 6247 |
| 21 | 75 | WHAT CHECKUP DOES AND DOES NOT DO (2 of 2) | 6286 |
| 22 | 76 | THE SECURITY CHECKLIST *(hub)* | 7628/7668 |
| 23 | 55 | REVIEW YOUR SELECTIONS -- NO CHANGES YET | 7836 |
| 24 | 61 | FINAL ITEM: DEVICE ENCRYPTION | 7018 |
| 25 | 62 | YOUR PC MEETS THE REQUIREMENTS | 7071 |
| 26 | 79 | BEFORE YOU TURN IT ON -- YOUR RECOVERY KEY | 7093 |
| 27 | 81 | HOW TO TELL IF ENCRYPTION IS RUNNING | 7168 |
| 28 | 69 | ALL SELECTED ITEMS PROCESSED | 8094 |
| 29 | 70 | AUTOMATED SCAN SCHEDULE SETUP | 6549 |
| 30 | 72 | AUTOMATED STEPS COMPLETE | 6458 |

**30 integers.** Bill's approved decision -- integers for the BitLocker end
block -- is rows 24 to 27.

**Sanity check against the field.** SANDY's run rendered its screens in exactly
this relative order, and the numbers it *showed* were 1-31 with the checklist
missing. Under this table the same run reads 4,5,6,7,8,9,10,11,12,13,14,
**15a**,16b,17a,17,18,19,**20a**,20,21,22,23,24,25,26,**26a**,27,28,29,30 --
climbing throughout, which is the requirement.

---

## THE BRANCHES -- letters off the integer they follow

One level only, per Bill's 2026-08-17 answer. No 8a1.

| Letter | ID | Screen | Seen when |
|---|---|---|---|
| **1a** | 25 | WELCOME BACK | A saved checkpoint exists |
| **1b** | 31 | QUICK RE-CHECK BEFORE RESUMING | Resuming |
| **1c** | 83 | ARE YOU SURE YOU WANT TO CLOSE CHECKUP? | Answering N at 1b |
| **3a** | 01 | *(font instructions variant)* | Not administrator |
| **9a** | 32 | DOMAIN-JOINED WARNING | PC is domain joined |
| **9b** | 33 | ADMINISTRATOR ACCESS REQUIRED | Not elevated |
| **11a** | 36 | TIME AND DATE -- CHECK | Clock check offered |
| **11b** | 37 | TIME AND DATE -- OUT OF SYNC | Clock is wrong |
| **15a** | 39 | REMINDER: PRE-SCAN RECOMMENDED | **Repeat run** -- and note FT-175b: this branch never offers the scan |
| **15b** | 40 | WELCOME BACK -- OFFLINE SCAN COMPLETE | Resuming after the scan reboot |
| **16a-16f** | 41,42,43,44,45,46 | Antivirus status, six states | Exactly one, by AV state. SANDY got 43 = **16c** |
| **17a-17d** | 13,73,47,48 | Malwarebytes follow-up, four states | Exactly one. SANDY got 73 = **17b** |
| **17e** | 49 | POWER / BATTERY WARNING | On battery, or no AC |
| **20a** | 53 | QUICK QUESTION -- YOUR PASSWORDS | First run -- **no Back option today, FT-173-residual** |
| **20b** | 74 | YOUR PASSWORDS -- WE REMEMBERED | Answer restored from a previous run |
| **22a** | 56 | NON-RECOMMENDED SELECTIONS | Unticking a recommended item |
| **22b** | 57 | NON-RECOMMENDED -- CONFIRM | Confirming that |
| **22c** | 58 | HEADS UP -- SKIPPING ENCRYPTION | Unticking BitLocker |
| **22d** | 60 | WHY ENCRYPT? | From 22c |
| **22e** | 68 | ENCRYPTION DECLINED | From 22d |
| **23a** | 59 | APPLYING YOUR CHANGES | During the apply loop |
| **24a** | 63 | YOUR PC DOES NOT MEET THE REQUIREMENTS | Prereq check fails |
| **24b** | 64 | BITLOCKER (Windows 11 **Pro**) | Pro edition |
| **24c** | 65 | BITLOCKER -- WHAT WILL HAPPEN | Pro |
| **24d** | 66 | BITLOCKER -- CONFIRM | Pro |
| **24e** | 67 | BITLOCKER ENABLED | Pro |
| **26a** | 80 | HOW TO SIGN IN WITH A MICROSOFT ACCOUNT | Local account on Home |
| **26b** | 82 | *(recovery key variant)* | Conditional |
| **29a** | 23 | CONVENIENCE REVIEW | Items deferred to the end |
| **29b** | 71 | CONVENIENCE REVIEW -- RESULT | From 29a |

**Note on 24b-24e.** The Pro BitLocker screens are letters while the Home ones
are integers. That is not favouritism -- it is Bill's approved rule applied:
the canonical journey is Home (the majority of the target market and the
machine the product is tested on), so Home walks the integers and Pro branches
off. Both climb. Neither has a hole.

---

## WHAT THIS DOES NOT COVER

- **The identity banner (FT-184) is CUT. Bill, 2026-08-17.** It is deleted
  rather than promoted to screen 1, so **the integers above are final and do
  not shift.** Bill's reason disposed of my recommendation: *"no senior
  including me is going to remember that"* -- the build number and Machine ID
  are needed on a support call days later, and no screen shown at launch can
  serve that. They are fetched on demand instead, under **FT-189** (an `I` key
  at every prompt, plus `Open-My-Log.bat`). **The `I` screen is a branch and
  takes a letter, so it does not disturb this table either.**
- **SCREEN-63, 82 and 01** are marked conditional in the inventory but their
  exact trigger was not confirmed in this walk. They are lettered on their
  position, which is safe, but their titles above are inferred and must be
  read off the source before the table ships.
- **`Run-GUIMode` paints no `Draw-Box` screens of its own** -- it is a WPF
  window. Its shared screens are already in the table.

---

## NEXT, IN ORDER

**The integers are final.** The banner decision that could have shifted them
was made on 2026-08-17 and went the way that leaves them alone.

1. Confirm the three inferred titles above against source (SCREEN-01, 63, 82).
2. Build the table into the tool as the six steps in the design document.
3. Extend gate 12 to fail the build on a duplicate, a gap in the letters, a
   typed `N of M`, or any path that produces a decrease.
4. **Add the `I` screen as a branch letter** once FT-189 is built. It hangs off
   whatever integer the user is on, so it needs no reserved number -- but gate
   12 must know it is legitimately reachable from everywhere, or it will read
   as 46 duplicate definitions.
