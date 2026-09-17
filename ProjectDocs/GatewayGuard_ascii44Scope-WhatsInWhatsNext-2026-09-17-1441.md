<!-- Dated: 2026-09-17 14:41 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii44 -- what is actually in it, and what is left for ascii45

- **Document Name:** GatewayGuard_ascii44Scope-WhatsInWhatsNext
- **Dated:** 2026-09-17 14:41 ET
- **Editor:** Claude Code (CGDELL)
- **Bill's question:** "what is in ascii44 vs what is scheduled for ascii45."
- **How this was built:** cross-checked `GatewayGuard_ascii44BuildPlan-2026-09-05-1130.md`
  (the plan, written before any of ascii44 was built) against the live build
  source, grepping for every FT number and feature it named. Not answered
  from memory -- the plan and the code disagree in a few places, and those
  disagreements are called out below rather than smoothed over.

---

## THE HEADLINE

**The plan's Block A shipped. Block B did not ship at all -- not one item.**
Blocks C and D were always waiting on Bill or on SANDY and still are.
Separately, a long list of things NOT in the original plan got found and
fixed through live measurement sessions between 09-06 and today, several of
them more serious than anything Block B was asking for.

---

## BLOCK A (the plan's highest-priority block) -- ALL SEVEN BUILT, MEASURED

| # | What | Status |
|---|---|---|
| A1 | FT-242, eight registry writes with no error trap | **Built.** "Eight were the audited set; the ninth was in `Apply-PowerSettings`, a second apply path the triage did not check." |
| A2 | FT-203, reminders never fire on battery | **Built.** `Set-GGTaskSettings` fixes the three settings after the task is created. |
| A3 | `B` is the only Back key, 7 prompts | **Built.** Five of the seven sites (the two "no" is a real answer" ones needed more than a swap; not confirmed both landed -- worth re-checking during the field run). |
| A4 | FT-244, screen drawn and never paused | **Built.** `Show-ManualSteps` (screen 34) now clears the screen like every other wrap-up screen. |
| A5 | FT-243, log notice on a screen users skip | **Built.** Moved to the review screen. |
| A6 | FT-245, silent-error breadcrumb wrong | **Built.** Now names where the fault was, not where the user was. |
| A7 | FT-246, instrument the password-on-wake re-read | **Built, and it went further than planned.** Logging the two attempts (as asked) led to finding the actual defect -- FT-255/FT-256, a parse that could never populate `$Matches` at all. Fixed, not just logged. |
| A8 | Screen 12, SSD is Drive 1 | **Built.** |

---

## BLOCK B (the plan's second block, "nothing blocked") -- NONE OF IT SHIPPED

***Measured just now: zero occurrences of `PUAProtection`, `AntivirusSignatureAge`/`SignatureAge`,
or `Microsoft.Update.Session` anywhere in the ascii44 source.*** These are
the exact strings the plan's B1, B2 and B5 said to add. They are not there.

| # | What | Status |
|---|---|---|
| B1 | FT-248, nuisance-software blocking never read | **Not built.** No `PUAProtection` read exists. |
| B2 | FT-249, stale-signature scan means nothing | **Not built.** No signature-age check exists. |
| B3 | FT-250, settle the machine before reading (Tamper Protection -> Update -> nuisance -> signature age -> scans) | **Not built.** The run order the plan asked for was never assembled -- there was nothing to reorder around, since B1/B2 don't exist. |
| B4 | FT-251, setting 6 says "manual required" with no reason | **Effectively done, but not as planned, and 12 days later than planned.** The plan's own instruction -- "leave `CanAuto` alone, change the wording only" -- is exactly what FT-262 did today, arrived at independently through Bill's screenshot rather than by working this list. The written record: `GatewayGuard_FieldResult-PhishingProtection-2026-08-26-1130.md` had already drafted the fix on 08-26 and it sat unread until today. |
| B5 | FT-252, Windows Update check-and-instruct | **Not built.** No Windows Update Agent COM code exists. |
| B6 | FT-253, the F6 wording block (~20 items) | **Not built.** The plan called this "the largest single block of remaining work." Still outstanding. |
| B7 | FT-247, screen numbering goes backwards (26 -> 25c) | **Built.** Screen ID `58` = shown-as `25c` exists correctly in the current table, in the right position. |

---

## BLOCK C (blocked on Bill) -- ONE RESOLVED DIFFERENTLY, TWO STILL OPEN

| # | What | Status |
|---|---|---|
| C1 | GUI mode labelled "Recommended for first time users" despite never being field run | **Still open.** No evidence either the label was removed or GUI mode was dropped. Needs a decision before any field run that might touch mode 2. |
| C2 | Malwarebytes in or out of the tool | **Resolved, but not by the planned route.** The plan wanted a one-afternoon SANDY comparison test first (Block D2) to decide. Bill decided outright on 2026-09-08 instead: **Malwarebytes is out of Checkup entirely**, guide-only. The comparison test did happen (2026-09-07/08, informing the decision) even though the decision itself came before the plan's own sequencing expected it to. |
| C3 | The password-manager "why" text (browser manager framed as a single point of failure vs. NCSC calling it a good choice) | **Not confirmed resolved.** Worth checking the current guide/website wording against this open question before the field run. |

---

## BLOCK D (blocked on a measurement, not a person)

| # | What | Status |
|---|---|---|
| D1 | F4, the second drive (Route 3: Checkup scans it too) | **Still not built.** CLAUDE.md's own "still to build" line names F4 explicitly, current as of this build. |
| D2 | The Malwarebytes comparison test | **Done.** 2026-09-07/08, Defender 0 of 6 vs. Malwarebytes 6 of 6 on the same twelve files -- this is what actually decided C2. |
| D3 | The USB-drive sentence (needs a live SANDY measurement) | **Not confirmed.** No record found of this measurement having been taken. |
| D4 | The encryption screens' local-account condition | **Not confirmed.** Same -- needs SANDY, no record found. |

---

## WHAT WASN'T IN THE PLAN AT ALL, AND GOT FOUND ANYWAY

The actual work between the plan (09-05) and today did not follow Block
A -> B -> C -> D in order. After Block A, work shifted to live measurement
sessions on CGDELL that surfaced defects nobody had scoped:

- **FT-255 / FT-256** (fixed) -- the powercfg parse that could never read
  password-on-wake correctly. Grew out of A7.
- **FT-257** (fixed) -- SmartScreen reporting "ON -- GOOD" from a value that
  was never there.
- **FT-258 / FT-258b** (fixed) -- the Group Policy override check, and the
  firewall Public-profile miscount it caught along the way.
- **Setting 5 removed, Malwarebytes removed from the tool** -- both
  2026-09-08 product decisions, neither one anticipated by the plan.
- **FT-259** (raised, deferred by Bill: "build the height check later") --
  Checkup never checks whether the window is tall enough to show a screen.
- **FT-260** (decided 2026-09-16: no 20th setting; detection gap raised,
  deliberately not fixed) -- Smart App Control locks a setting the policy
  check cannot see.
- **FT-261, FT-262, FT-263, FT-264** (all fixed 2026-09-17, today) --
  closing the resume-path admin gap, the phishing-protection wording (which
  turned out to be B4/FT-251 under a new number), Tamper Protection and
  Windows Hello's manual instructions never reaching a user, and two broken
  Tool2 utility scripts.
- **FT-123b, items 13 and 14 (both fixed 2026-09-17, today)** -- a separate,
  older open item (from Cloud's 2026-09-16 Copilot review, not the 09-05
  build plan): items 13 (Edge Startup Boost/Background) and 14 (Widgets)
  reported "Unknown -- could not check" whenever Checkup's own policy had
  never been set, because Copilot's proposed effective-state key names
  hadn't held up when checked against the file Cloud's measurement script
  read. Bill ran that script himself. Item 14 (Widgets) came back
  flip-proven -- `TaskbarDa` read 1, then 0 when he turned Widgets off in
  Windows' own settings, then 1 again when he turned it back on. Item 13
  turned out to need a different file entirely (`Local State`, shared
  across Edge profiles, not the per-profile `Preferences` file the script
  checked) -- found by investigating a "nothing changed" result instead of
  accepting it. Both now have a real effective-state reader, mirroring the
  one already built for item 15 on 09-16. Full detail: CLAUDE.md's FT-123b
  entry.
- **"Back replays a photograph, not the words"** (raised, not fixed) --
  resizing the window during a run breaks Back.
- **FT-254** (raised, not fixed) -- `Test-TimeDateSync` prints success after
  four unguarded calls.

---

## SO: WHAT SHOULD ascii45 BE SCOPED AS

**Everything in this list is a candidate. Bill's call which of these go in,
same as Block C/D always were.**

1. Block B in full -- FT-248, FT-249, FT-250, FT-252, FT-253 (the F6 wording
   block is still "the largest single block of remaining work").
2. Block C1 (GUI mode label/removal decision) and C3 (password-manager
   wording) -- both still open.
3. Block D1 (F4, second drive), D3 (USB-drive sentence), D4 (local-account
   encryption condition) -- all three still need a SANDY measurement.
4. FT-259 (window height/one-key-fix), deferred by Bill's own instruction
   until "later" -- this is later.
5. FT-260's detection gap -- deliberately deferred pending a second real
   instance of the same lock mechanism; check whether one has turned up.
6. The "Back replays a photograph" screen-resize defect.
7. FT-254, `Test-TimeDateSync`'s unguarded calls.
8. The mouse-setting further testing Bill deferred until "after the website
   and the guide, before launch" -- check whether that condition is now met.

---

## SOURCES

- `GatewayGuard_ascii44BuildPlan-2026-09-05-1130.md` -- the plan.
- `Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1` -- grepped
  directly for every FT number and feature string named above.
- `CLAUDE.md`, "Current build: ascii44" section -- the running record of
  what was actually built, cross-checked against the plan rather than
  taken as the only source.
