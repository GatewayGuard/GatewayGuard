<!-- Dated: 2026-09-16 15:12 ET -->
# Guide Part 3 reviewed -- a real numbering bug found, hold confirmed

- **Document Name:** GatewayGuard_GuidePart3Review-ForCloud
- **Dated:** 2026-09-16 15:12 ET
- **Editor:** Claude Code (CGDELL)
- **For:** Claude Cloud
- **Reviews:** `Co-Pilot part 3 Additional Security and Priv-2026-09-16-1448.txt`,
  checked the same way Parts 1 and 2 were on 09-16 -- against the live draft
  and against the build.
- **Status:** All three parts of Copilot's rewrite have now been checked.
  The hold from earlier today stands, and this raises why.

---

## THE HEADLINE FINDING

**Four settings carry the wrong number, in two different places, and it
directly breaks a rule Copilot's own Part 1 states.**

| Setting | Real Checkup ID | Wrongly labelled |
|---|---|---|
| Memory Integrity (Part 2) | 16 | 10 |
| Password Required on Wake (Part 2) | 17 | 11 |
| Fast Startup (Part 3) | 18 | 16 |
| Wake on LAN (Part 3) | 19 | 17 |

**Setting 10 now means two different things in the same document** --
Memory Integrity in Part 2's heading, Remote Desktop in Part 3's heading.
A reader told to check "Setting 16" for Fast Startup would find Memory
Integrity on Checkup's own screen instead.

**Cause, measured:** Part 2 and Part 3 both numbered settings by "the Nth
one this document happens to cover," not by Checkup's real ID. That tracked
correctly by coincidence through Firewall/BitLocker/Hello, then diverged
the moment Memory Integrity was reached — the real ID jumps from 9 to 16
because setting 5 is gone and 10-15 live in Part 3, not Part 2 — and never
came back into alignment.

**Part 1 is not part of the error.** ***Measured: its own quick-reference
table already has 16-19 correct*** -- Memory Integrity, Password Required
on Wake, Fast Startup, Wake on LAN, in that order. It is Part 2's and Part
3's section headings that drifted from Part 1's own table, and from the
rule that table itself states: *"Setting numbers match GatewayGuard
Checkup... should not be renumbered without a product decision."*

**This is disqualifying on its own.** A dropped VERIFY marker ships an
unmeasured claim; a wrong setting number actively sends the reader to the
wrong screen the first time they use the table.

---

## THE SAME TWO GAPS AS PARTS 1 AND 2, CONFIRMED AGAIN

***Measured, Part 3:*** 0 VERIFY markers, 0 "with your approval" mentions.

**Two real VERIFY claims specific to Part 3's settings were dropped**,
checked against the live draft:

- **Diagnostic Data (12):** the live draft flags *"Windows sends the larger
  level unless told otherwise"* and *"your computer receives exactly the
  same updates either way"* as unmeasured. Part 3 states both as fact.
- **Edge Startup Boost (13):** the live draft flags *"Edge is still running
  after you have closed it"* as unmeasured. Part 3 states it as fact.

**"With your approval" is absent for all eight settings**, including three
that are genuinely `CanAuto=$true` in the build (Edge Startup Boost,
Widgets, Edge Password Saving) -- the guide describes these as manual steps
for something Checkup can do with permission.

---

## ONE THING COPILOT GOT RIGHT WITHOUT BEING ASKED

Part 3 already includes a grey-control note, written before it had seen the
Smart App Control decision:

> A Note About Gray or Locked Controls... "This setting is managed by your
> organization" or "This setting is managed by Smart App Control"... If
> GatewayGuard reports that the setting is already configured correctly, no
> further action is usually required.

**This matches the decision made the same afternoon** (`CLAUDE.md`'s
FT-260 entry), and is broader in a good way -- it also covers "managed by
your organization," which a home PC can occasionally show for unrelated
reasons. No changes recommended; it is ready for the reconciliation pack
as written.

---

## WHAT THIS MEANS FOR THE RECONCILIATION PACK

**Hold confirmed, now with a concrete reason beyond "wait for Part 3."**
The pack needs to, at minimum:

1. **Renumber the four wrong section headings** to 16, 17, 18, 19 --
   Memory Integrity, Password Required on Wake (Part 2), Fast Startup,
   Wake on LAN (Part 3).
2. **Restore the VERIFY markers** found dropped in Part 2 (BitLocker,
   Windows Hello area) and now Part 3 (Diagnostic Data x2, Edge Startup
   Boost x1).
3. **Add the missing permission line** across all three parts.
4. **Carry forward Setting 5's wording and the Smart App Control note**,
   both already decided and filed in
   `GatewayGuard_CoPilotGuideReview-Comments-2026-09-16-1140.md`.

**Full detail, every measurement, in that same file** -- this document is
the handoff pointer, not a duplicate of it.

---

## SOURCES

- `Co-Pilot part 3 Additional Security and Priv-2026-09-16-1448.txt`
- `Co-Pilot-Part1-Guide-2026-09-16-1011.txt` and
  `Guide-Part 2 Core Security Settings-2026-09-16-1122.txt` -- for the
  numbering cross-check.
- `GatewayGuard_GuideRewrite-Draft-2026-08-22-1000.md` -- the VERIFY
  markers checked against.
- `GatewayGuard_CoPilotGuideReview-Comments-2026-09-16-1140.md` -- the full
  record, all three parts, updated with today's findings.
