<!-- Dated: 2026-08-25 10:10 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Review of Cloud's licence v2.2

- **Document Name:** GatewayGuard_ReviewOfLicenceV22
- **Last Modified:** 2026-08-25 10:10 ET
- **Reviews:** `ProjectDocs/GatewayGuard_License-2026-08-25-0921.docx` (Cloud)
  and `GatewayGuard_CloudHandoff-2026-08-25-0921.md`
- **Status:** **Do not send v2.2 to the attorney yet.** One clause describes
  something the product does not do.

---

## 1. CLOUD CAUGHT A REAL DEFECT IN MY FILE, AND IT WAS RIGHT

**Verified, both halves.**

*measured:* the phrase **"withdrawn on the attorney's advice and Bill's
judgment"** appears in `GatewayGuard_License-2026-08-07-0726-TEXT.md` line 26
**and in my `GatewayGuard_License-2026-08-24-1210-TEXT.md` line 32.**

*measured, same file line 198:* the attorney's actual recorded comment was that
the binding clause **should be tested against Section 5 of the FTC Act** — not
that it should be removed.

**So the attribution is unsupported, and I carried it forward.** I rewrote
Section 9 and change-log entry 2 and **read straight past entry 1**, which
claimed the attorney advised something the notes do not show.

**This is the same error I made yesterday on hover-to-open** — inheriting a
sourced-looking claim and passing it on without checking it. Twice in two days,
same shape. **The rule is not "verify what you write". It is "verify what you
carry".**

## 2. ONE THING IN THE HANDOFF I CANNOT VERIFY, AND IT MATTERS BECAUSE OF §1

Cloud quotes Bill's 2026-08-04 note on PC binding as:

> *"I am uncomfortable with this as it may lead to many requests. Not a good
> idea. Re-write..."*

***measured:* that sentence appears nowhere in the repository** — not in the
consult notes, not in `ProjectDocs/`, not in `Notes/`. The only occurrence is
inside Cloud's own handoff.

**It is probably real** — Bill says things to Cloud that never reach a file, and
Cloud can see its own conversation history. **But it cannot be verified here**,
and a document whose central finding is *"the attribution was invented"* is the
one place to be strictest about its own sourcing.

**Bill: did you say that, roughly?** If yes, it should be written into the
consult notes so the next session can find it. If it is a reconstruction, the
binding decision needs re-confirming before v2.2 goes anywhere.

---

## 3. THE FINDING THAT STOPS v2.2 — SECTION 2 DESCRIBES SOMETHING CHECKUP DOES NOT DO

**Section 2, as restored:**

> *"The first time you run Checkup, it makes a note of the computer it is
> running on, **and from then on it runs on that computer**."*

***measured on ascii43. That is not true.***

`Get-MachineIdentity` (line 3140) derives a 12-character SHA-256 hash of the
hardware UUID, salted `"GatewayGuard|"`. **It is displayed on screen and
written to the log. It is never compared to anything, never stored for
comparison, and never gates execution.**

*measured:* every reference to `$global:MachineID` outside comments is an
assignment or a `Write-Host`. **There is no check anywhere.**

**And the build says so itself**, in the function's own header comment at line
3139:

> *"Same fingerprint concept **planned** for licensing."*

**Planned. Not built. Checkup runs on any PC, every time.**

### WHY THIS IS THE MOST SERIOUS THING IN THE REVIEW

**It is the Tamper Protection defect at legal scale.** The website claimed
Checkup could turn on a setting it cannot; the fix was a copy change. **Here a
signed contract tells the buyer their licence is technically enforced when it
is not.**

Three consequences, in order:

1. **It is a false statement in a consumer contract**, made to explain why the
   price is one-time. **The justification sentence rests on it** — *"it is what
   lets us sell Checkup once, at a price a household can afford."*
2. **Cloud's 4a question is bigger than Cloud framed it.** Cloud asked whether
   the tool can reissue. **There is nothing to reissue, because nothing is
   issued.** The whole reissue paragraph — free, unlimited, no proof — describes
   an administrative process for a thing that does not exist.
3. **A reader who opens the script can see this.** We sell auditability. **The
   one clause a technically-minded buyer could check against the source is the
   one that does not match it.**

### THE THREE WAYS OUT — BILL'S CALL, AND IT IS NOT A WORDING FIX

| | What it means | Cost |
|---|---|---|
| **A. Build the binding** | Implement the check before launch | **New code in an untested build, 7 days out. My recommendation is no** |
| **B. Say what is true** | The licence is per-PC **by these terms**, not enforced by software. Keep the honour-system framing Section 9 already uses about deleted copies | **A wording change today.** Consistent with the product's voice |
| **C. Restore binding on paper, build it later** | Leave the sentence, ship unenforced | **This is the current position and it is the worst one.** It is the only option that puts an untrue sentence in a contract |

**My recommendation is B**, and it costs nothing this week. Section 9 already
says *"we are aware we cannot check this, and we are not going to try"* about
deleted copies. **The same honesty about the PC note would read as consistent
rather than as a climbdown** — and it keeps the one-time-price justification,
which does not actually depend on enforcement.

---

## 4. WHAT v2.2 GETS RIGHT — AND IT IS MOST OF IT

**Section 1 covering all products is the right structural change.** The
agreement was named for Checkup and had to cover the Guide; it now covers both
and provides for future ones.

**The PC-binding rewrite is genuinely better writing**, whatever happens to its
truth. The old version led with the mechanism — *"records a hardware
identifier"* — which reads as a lock. The new order is: what the note is, what
it is **not** (no name, no email, no account), why it exists, and what happens
when a PC is replaced. **That is the right order for a nervous buyer**, and it
is the same "say who authorised it" instinct the website rules already require.

**Removing prices from Section 2 is correct** and I should have done it in the
1210 pass. Prices change; a contract that carries them goes stale on its own.

**Section 9 survived unchanged**, which is the right call — it was rewritten
yesterday against Bill's decision and nothing since has disturbed it.

**And Section 13 was left alone rather than quietly patched.** *Cloud's
reasoning is correct:* a carve-out is exactly the hedge the decision record
warns against, and it is the attorney's call. **Flagging it and stopping is
better work than fixing it would have been.**

*measured:* the `.docx` is clean — 24 real em-dashes, proper curly quotes,
**zero replacement characters.** No encoding damage.

---

## 5. BLOCK 1 — WHO OWNS THE MASTER

**Cloud offers Option A (I apply changes 1-9 to the 1210 master) or Option B
(Cloud's file becomes the master). Cloud prefers A.**

**Agreed — Option A, and Cloud's reason is the right one.** Its file was
reconstructed from the readable twin because the connector does not index
`.docx`, so it inherits any drift between master and twin. **I can read both.**

*Confirmed for Cloud's provenance caveat:* **the twin did match the master.** I
generated it from the `.docx` in the same run that produced the `.docx`, and
the read-back verified the old wording gone and the new present. **v2.2's base
is sound.**

**Sequence I propose:**

1. **Settle §3 first.** No point restoring a binding clause and then rewriting
   it two days later.
2. Apply changes 1, 2, 4, 5, 6, 7, 8, 9 to the 1210 master through an
   assert-guarded script, as before.
3. Apply change 3 — PC binding — **in whichever form §3 lands on.**
4. Regenerate the twin, add a `CURRENT.md` row, retire the two withdrawn
   drafts.

---

## 6. BLOCK 2 — THE FILES TO RETIRE

**Agreed, with one correction.** Cloud lists three to retire. **All three are
untracked and none has ever been committed** — *measured.* **So there is
nothing to retire; there is only something not to commit.** They stay on disk,
out of the repository.

**And Cloud is right that `GatewayGuard_AttorneyConsultNotes-2026-08-07-0726.md`
should be kept and corrected**, not discarded — the attorney's answers in it are
valid. **The one line to fix is the binding attribution**, and it should be
corrected in the same pass as §1 above.

---

## 7. WHAT I AM NOT DOING, AND WHY

**Not applying any of it yet.** The binding question decides how Section 2
reads, and Section 2 is one of the nine changes. **Applying eight and holding
one leaves the master in a state neither version describes.**

**Not running the copy checks yet** (Cloud's Block 3). Worth doing, but the
text is going to move.

**One early answer on Cloud's forever-family question:** *"we will never make
your existing copy stop working"* is **a promise about our conduct, not a claim
the product lasts forever.** Cloud's reading is right. **But it is now
load-bearing for a different reason** — with no enforcement in the build, it is
one of the few sentences that is unambiguously true, and it should stay.

---

## 8. THE THREE THINGS I NEED FROM BILL

1. **Section 2 — build the binding, or say what is true?** *(§3 above. My
   recommendation: say what is true.)* **Nothing else moves until this does.**
2. **Did you say the "uncomfortable / not a good idea / re-write" line to
   Cloud?** *(§2.)* If yes I will write it into the consult notes so it stops
   being unverifiable.
3. **Option A confirmed for the master?** *(§5.)* I will assume yes unless told
   otherwise — it is the safer lineage and Cloud prefers it too.
