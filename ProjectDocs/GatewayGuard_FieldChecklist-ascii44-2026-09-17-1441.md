<!-- Dated: 2026-09-17 14:41 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii44 Field-Run Checklist -- screen order and what to watch for

- **Document Name:** GatewayGuard_FieldChecklist-ascii44
- **Dated:** 2026-09-17 14:41 ET
- **Editor:** Claude Code (CGDELL)
- **Build:** `Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1`
- **Status:** ascii44 has never been field run. This is the first checklist
  for it.
- **Bill's questions this answers:** (2) what order will I see and be asked
  to do things, (3) a checklist by screen number telling me what to look for.

---

## HOW THE NUMBERS AND ORDER WERE DERIVED -- NOT BY EYE

**The order is `$script:GGScreenLabels`, the build's own static table,
line 1939.** Per the project's own screen-numbering rule, this table is
written in the position the user reaches each screen, so it IS the viewing
order -- integers for the first-run canonical journey, letters for
departures from it (resume, branches, alternate states). This is the same
table the running log reads from, so the number below is the exact number
you will see on your screen.

**The FT/watch-for notes were checked against the build source just now**,
grepping each FT comment and matching its enclosing function to the screen
table (`Tool2\Run-ScreenInventory.bat`, fixed today -- see FT-264 -- and
re-run clean). Where a note says "not confirmed," that means the mapping
could not be pinned to one screen with confidence, not that nothing is
wrong there.

**This is a defect-watch checklist, not a script.** It does not tell you
what to click -- it tells you what has changed or is still uncertain at
each point, so you know whether what you see on screen is expected.

---

## BEFORE YOU START

- Run as **Administrator**. As of today (FT-261), Checkup will not run any
  other way -- if it is not elevated, screen 1 (below) shows instructions
  and closes. This is new since the last time anyone ran a build here.
- **Phishing protection, box four.** If you have turned on "Automatically
  collect website or app content..." on this PC, turn it back off before
  the run (see `GatewayGuard_SettingsLocationList-2026-09-08-2130.md`).
  It is not part of setting 6 and Checkup does not ask for it.
- **Malwarebytes is out of Checkup entirely** as of 2026-09-08. If this
  machine still has a Malwarebytes scheduled task or reminder from an
  older build, that is expected leftover, not a new defect -- see CLAUDE.md,
  Approved Products.

---

## THE CANONICAL JOURNEY -- SCREENS 1 THROUGH 34

| # | What it shows | Watch for |
|---|---|---|
| 1 | Welcome / maximize the window | -- |
| 2 | Scrolling instructions | -- |
| 3 | Set your console font | -- |
| 4 | Font check | -- |
| 5 | Before you start -- your window | -- |
| 6 | Before you start -- your keyboard | -- |
| 7 | What happens next | -- |
| 8 | How to scroll back and copy | Confirm the copy-tip wording matches verbatim across all three places it should appear (User-Facing Clarity Rule, CLAUDE.md). |
| 9 | Important -- read before continuing | -- |
| 10 | Windows edition detected | -- |
| 11 | Your PC -- RAM | -- |
| 12 | Your system at a glance | **Drive order:** screen 12 should show your SSD as Drive 1 (fixed this build, A8). If this PC has more than one drive, this is the one screen that still needs a look on a multi-drive machine -- CGDELL only has one disk, so this has never been observed with more than one drive present. |
| 13 | Your PC's security tools | -- |
| 14 | The scans we recommend | -- |
| 15 | Pre-scan prep checklist | -- |
| 16 | Defender offline scan | -- |
| 17 | Antivirus status -- healthy setup | If this PC has a third-party antivirus or Malwarebytes installed, you may land on one of the alternate screens 17a-17e instead (see branches below) rather than this one. |
| 18 | Malwarebytes detected | Malwarebytes is out of the tool as of 2026-09-08 -- if this screen or its 18a-18d branches still reference it, that is expected legacy content for a machine that already has it installed, not a place Checkup is newly recommending it. |
| 19 | Power settings -- security review | **This is where the password-required-on-wake reading happens** (FT-255/FT-256, fixed 2026-09-08). Watch for the wording to say REQUIRED, NOT REQUIRED, or an honest "could not be read" -- never a flat "NOT required" produced from an empty read. This is the single most field-tested fix in ascii44; confirming it here is high value. |
| 20 | Apps audit results | If nuisance/PUA blocking or scan-signature-age were going to be checked, this is where they would show up -- they are not built yet (see the scope document), so their absence here is expected, not a defect. |
| 21 | Mode selector | Confirm whether "Recommended for first time users" still appears on GUI mode -- this label is still an open question (Block C1) and GUI mode itself has never been field run. |
| 22 | Quick question -- your passwords | -- |
| 23 | What Checkup does and does not do (1 of 2) | This screen's page number is hand-typed in the source text, not read from the screen table -- if you ever see it disagree with what the table would say, that is worth reporting on its own. |
| 24 | What Checkup does and does not do (2 of 2) | Same hand-typed-number caveat as 23. |
| 25 | The security checklist, page 1 | -- |
| 26 | The security checklist, page 2 | -- |
| 27 | Review your selections | **This is the screen Bill hit with the Back-key defect (A3).** Confirm `B` goes back here and `N` never does. This is also where Setting 6 (phishing), Setting 3 (Tamper Protection) and Setting 9 (Windows Hello) will show their manual-instruction text if Windows blocks the automatic change -- **this is the highest-value screen to watch closely today**: Tamper Protection and Windows Hello's specific instructions have never been shown to any user before today's fix (FT-263), and Setting 6's wording changed today too (FT-262). |
| 28 | Final item: device encryption | -- |
| 29 | Your PC meets the requirements | -- |
| 30 | Before you turn it on -- your recovery key | -- |
| 31 | How to tell if encryption is running | -- |
| 32 | All selected items processed | This is where `Apply-Setting` finishes for every item -- if any setting silently reports success it did not achieve, this is the screen that would show it (FT-242 fixed the eight known cases; watch for a ninth). |
| 33 | Automated scan schedule setup | **FT-203, fixed** -- the two reminder tasks used to silently never fire on a laptop running on battery. If you are testing on a laptop, testing this on battery power (not just plugged in) is the only way this fix actually gets exercised. |
| 34 | Automated steps complete | **FT-244, fixed** -- this screen used to paint on top of the previous one with no pause. Confirm it clears the screen cleanly before showing its own content. |

---

## BRANCHES -- WHAT YOU MIGHT SEE INSTEAD, AND WHY

| Shown as | Reached from | What it is | Watch for |
|---|---|---|---|
| 1a | Screen 1, on a second run | Welcome back -- a checkpoint exists | -- |
| 1b | Screen 1a | Quick re-check before resuming | **This is where FT-261's actual defect lived.** On resume, this is the ONLY path that reaches the admin check (`Test-AdminAccess`) -- a fresh run's screen 3a below catches it first. If you resume a session while not running as Administrator, confirm you get the same "close and relaunch as Administrator" screen as 3a, not a "Continue in Limited Mode?" prompt. That prompt should no longer exist anywhere in the build. |
| 1c | Screen 1a/1b | Are you sure you want to close Checkup? | -- |
| 3a | Screen 3, if not Administrator | Not administrator -- how to run Checkup correctly | **New as of today (FT-261) at this exact screen: this now says Checkup will not run without Administrator, full stop.** No "Limited Mode" option should appear here or anywhere else. |
| 9a | After the admin check | Domain-joined warning | -- |
| 9b | -- | Administrator access required | Same screen family as 3a/1b -- see FT-261 note above. |
| 11a | -- | Time and date -- check | -- |
| 11b | -- | Time and date -- out of sync | **FT-254, raised, not fixed.** `Test-TimeDateSync` prints success after four unguarded calls -- if a real out-of-sync condition doesn't get caught here, that is the known, still-open defect, not a surprise. |
| 14a | On a repeat run | Reminder: pre-scan recommended | -- |
| 14b | On a repeat run | Welcome back -- offline scan complete | -- |
| 17a-17e | Screen 17, alternate antivirus states | Antivirus -- alternative state | -- |
| 18a-18c | Screen 18, alternate Malwarebytes states | Malwarebytes -- alternative state | See screen 18's note -- legacy content, not a new recommendation. |
| 18d | -- | Power / battery warning | -- |
| 22a | Screen 22 | Your passwords -- we remembered your answer | This is exactly the setting whose "why" wording (Block C3) is still an open question -- worth reading closely even though the behavior itself is settled. |
| 25a | Screen 25/26 | Non-recommended selections | Part of the Back-key fix (A3) -- one of the two sites needing more than a simple key swap; confirm `N` means no here, not "go back." |
| 25b | Screen 25a | Non-recommended -- confirm | Same as 25a. |
| 25c | Screen 25/26 | Heads up -- skipping encryption | This screen's number (25c, not a backwards jump to 26) is itself a fix (B7/FT-247) -- confirm the numbering reads in order rather than jumping backward. |
| 25d | -- | Why encrypt? | -- |
| 25e | -- | Encryption declined | One of the five Back-key sites (A3). |
| 27a | Screen 27 | Applying your changes | Where FT-242's fix is exercised live -- watch the log, not just the screen, for anything reported GOOD without a matching change. |
| 27b-27e | BitLocker, Pro only | BitLocker screens | -- |
| 28a | -- | Device encryption may not be available on this PC | Related to Block D4 (local-account encryption condition) -- still not confirmed measured on SANDY. |
| 30a | -- | Already signed in with a Microsoft account | Same Block D4 area. |
| 30b | -- | How to sign in with a Microsoft account | Same. |
| 33a | -- | Convenience review | -- |
| 33b | -- | Convenience review -- result | -- |
| 33c | Only when there is no OneDrive | OneDrive offer | -- |
| 33d | -- | How to set up OneDrive | -- |
| *(unnumbered)* | Reachable from anywhere, the `I` key | About this Checkup run | Deliberately carries no number -- this is by design (FT-189), not an omission. |

---

## THINGS THAT ARE NOT ON THIS LIST BECAUSE THEY ARE NOT BUILT YET

If you don't see any of these, that is correct, not a gap in your run:

- Nuisance/PUA-software blocking being read or set (Block B1)
- A stale-antivirus-signature warning before a scan (Block B2)
- A "settle the machine first" run order across Tamper Protection, Update,
  nuisance blocking, signatures, then scans (Block B3)
- Windows Update actually checking or offering to install anything beyond
  status (Block B5)
- A second-drive scan on a multi-drive PC (Block D1, F4)
- `X` = Exit as its own key anywhere (undecided, not in ascii44)

---

## IF SOMETHING LOOKS WRONG

Note the **shown-as screen number** (the number in the title, e.g. "Screen
19"), not the internal ID -- the log records both, but the number you read
on screen is the one that matters for reporting it back. Use the format
this project has used for every prior field run: what you expected, what
you saw, and the exact screen number.

---

## SOURCES

- `$script:GGScreenLabels`, `Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1`
  line 1939 -- the screen order and shown-as numbers, read directly, not
  retyped from an older table.
- `Test_Results\ScreenInventory-ascii44-2026-09-06-1214.txt` -- the
  mechanical screen/function inventory this checklist's structure was
  checked against, produced by `Tool2\Run-ScreenInventory.bat` (fixed
  today, FT-264).
- `GatewayGuard_ascii44Scope-WhatsInWhatsNext-2026-09-17-1441.md` -- the
  companion document on what is and isn't built.
- CLAUDE.md, "Current build: ascii44" -- every FT cited above traced to its
  own comment in the live source, not recalled from memory.
