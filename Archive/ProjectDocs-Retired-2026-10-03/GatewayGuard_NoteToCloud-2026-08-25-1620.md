<!-- Dated: 2026-08-25 16:20 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Note to Cloud — session close, 2026-08-25

- **Document Name:** GatewayGuard_NoteToCloud
- **Last Modified:** 2026-08-25 16:20 ET
- **From:** Claude Code (CGDELL)
- **Supersedes, for reading order:** nothing. **Read this first, then the
  research brief.**
- **Your work is not blocked.** Everything you need is synced.

---

## 1. YOUR SYNC IS GOOD, AND YOU PROVED IT THREE WAYS

| Check | Result |
|---|---|
| Your four stamp values against `CURRENT.md` on disk | **Match, character for character** |
| Is `cd1199f` the parent of HEAD? | ***measured:*** `git rev-parse --short HEAD^` = `cd1199f`. **Yes** |
| The session-log heading in your snapshot | **Matches what was written at 14:00 and pushed in `70058ee`, word for word** |

**You are current through `70058ee`.** Start work.

### One correction, and it is a naming correction, not a method correction

You called the third check a **sentinel check** and said the heading is one
`CURRENT.md` names.

***measured:*** `CURRENT.md` has a Session log row naming **the filename**
only, line 41. ***measured:*** `grep -i "sentinel"` across `CURRENT.md`, the
briefing, both `ProjectInstructions` and `CLAUDE.md` returns **one hit** —
`CURRENT.md` line 24, which says the stamp *"replaces a sentinel phrase that
could only say stale or not stale."* **The mechanism was retired. There is no
sentinel to pass.**

**The check you ran is real and it is stronger than the stamp.** The stamp
proves *which commit generated `CURRENT.md`*. **Your heading match proves the
payload arrived** — a different and harder claim. **Keep doing it. Call it a
heading match against the session log.**

**Why this is worth a paragraph rather than a shrug:** it is Rule 4's exact
shape, on the day Rule 4 was written. *"The heading `CURRENT.md` names"* reads
as sourced, nothing checked it, **and it reached the right answer anyway.**
That is the version that survives into the next session as a fact, and the
damage is not the wrong answer — it is that someone later goes hunting for a
row that was deleted weeks ago.

---

## 2. WHERE YOU PICK UP

**Two files, in this order:**

1. **`GatewayGuard_CloudResearchBrief-Licence-2026-08-25-1400.md`** — fourteen
   questions in five parts, and what changed since your 09:21 handoff.
2. **`GatewayGuard_License-2026-08-25-1400-TEXT.md`** — **version 2.4**, the base
   for every question. Confirm its `CURRENT.md` row before you start.

**You have read `GatewayGuard_CloudWorkingRules-2026-08-25-1400.md`. You have
done steps 1 and half of 3. Steps 2, 4 and 5 are still owed** — name your base
and its row, list every factual sentence you carry forward from an older draft
with the primary source for each, and say what you could not see.

**Step 3 matters most here.** The licence master is a `.docx` and the connector
does not index it. **Say so out loud, read the twin, and hand back a numbered
change list against `GatewayGuard_License-2026-08-25-1400`. Do not produce a
`.docx`.** That is Rule 3, and it is the rule written from what happened to
v2.2.

---

## 3. WHAT WAS SETTLED WHILE YOU WERE OFF

**Your Block 1: Option A.** Your changes 1–9 went onto the 1210 master through
`Tool2/build_license_v24_2026-08-25.py` — 42 assert-guarded changes, every
anchor verified before writing, read back afterwards. **Your `.docx` is
reference only and is not committed. Your reasoning for preferring A was
right.**

**Your provenance caveat is resolved: the twin did match the master.** It was
generated from the `.docx` in the same run that produced it. **v2.2's base was
sound**, and saying so voluntarily is the only reason anyone could check.

**Your Block 2, corrected: there was nothing to retire.** All three files are
untracked and have never been committed. They stay on disk, out of the
repository.

**Your item 4 was right and I was wrong to cut it.** I dropped the terms-change
question from the refund consult as off-topic. Testing showed refunds are the
term most likely to change. **Restored as question B6, and the clause itself is
now drafted as Section 12.**

**Your 4b is in the document** as a DECISION NEEDED under Section 14, worded as
your own reasoning — a carve-out is the hedge the 22 August decision warns
against, so it goes to the attorney rather than being patched quietly.

**Your 4a is answered by Bill, not by us.** He typed *"We will reissue for a
small fee"* into the v2.2 file. The free-and-unlimited promise is gone; the
amount is not set and is not in the contract.

**Bill has confirmed: binding stays.** Your reading of his 2026-08-04 note was
the contested one. He settled it directly, so it no longer rests on anyone's
interpretation.

---

## 4. THE ONE PLACE YOUR WORDING WAS NOT USED

Your Section 2 read: *"it makes a note of the computer it is running on, **and
from then on it runs on that computer**."*

***measured on ascii43:*** `Get-MachineIdentity` (line 3140) derives a
12-character SHA-256 hash of the hardware UUID and writes it to the screen and
the log. **Every reference to `$global:MachineID` outside comments is an
assignment or a `Write-Host`. It is never compared to anything.** The build's
own header comment at line 3139 reads *"Same fingerprint concept **planned** for
licensing."*

**Checkup runs on any PC, every time.**

**Binding stays, and your whole structure survives** — what the note is, what it
is *not*, why it exists, what happens when a PC is replaced. The clause now says
**"your license belongs to that computer"** — a statement about the licence,
which is true — instead of one about the software, which is not. **The gap is a
DECISION NEEDED in the same section rather than hidden.**

---

## 5. THE FINDING THAT OUTRANKS THE BRIEF

***measured on ascii43, 2026-08-25:*** the strings **"license agreement"**,
**"EULA"**, **"terms of use"**, **"accept the terms"** and **"I agree"** appear
**nowhere in the build**. ***measured:*** **no page in `WebSite/` mentions a
licence agreement.**

**Nobody is ever shown this agreement, and nobody ever accepts it.**

It has been on the critical path as five words since 24 July — task **T-LP**,
*"EULA posted"*. **Posted is not accepted.** Every other question in the brief
assumes a contract the buyer entered into, which is why **Part A comes first.**

---

## 6. WHAT NOT TO DO

- **No `.docx`.** Rule 3. A numbered change list instead.
- **Do not touch Section 13 or 14.** Both flags are deliberate and both are the
  attorney's.
- **Do not broaden the product definition** to *"including all updates, patches,
  and replacement versions"*. **It gives away the annual update, which is the
  renewal business.** If a source recommends it, say why we decline.
- **Do not add a refund hedge anywhere.** *"No questions asked earns its keep
  only if there are none."*
- **Do not answer questions 6, 13 or 14 as settled law.** Research them, then
  say plainly the decision is the attorney's.
- **Hold every question of your own to the end**, in one numbered list.
