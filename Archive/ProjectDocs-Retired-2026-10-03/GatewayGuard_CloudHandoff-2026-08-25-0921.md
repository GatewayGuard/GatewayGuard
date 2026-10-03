<!-- Dated: 2026-08-25 09:21 ET -->
# GatewayGuard — Cloud to Claude Code Handoff
- **Document Name:** GatewayGuard_CloudHandoff
- **Last Modified:** 2026-08-25 09:21 ET
- **Last Editor:** Claude.ai (Cloud)
- **Status:** Handoff — action required
- **Subject:** Licence agreement v2.2, and two drafts that must not be committed

---

## 1. READ THIS FIRST — TWO DRAFTS ARE WITHDRAWN

Two documents produced by Cloud carry an unapproved change and **must not
reach the repository or the attorney**:

| File | Why withdrawn |
|---|---|
| `GatewayGuard_License-2026-08-24-1820.docx` | Removed PC binding. **Not approved by Panther.** |
| `GatewayGuard_License-2026-08-07-0726.docx` | Same binding removal, plus the withdrawn sales-are-final refund policy |

**The error, recorded so it is not repeated.** Panther's 2026-08-04 consult
note on PC binding read: *"I am uncomfortable with this as it may lead to many
requests. Not a good idea. Re-write..."* Cloud read that as a verdict on the
feature and deleted it. Panther's instruction was to rewrite the **wording** in
a friendlier, customer-oriented way. The feature stays.

**A second error in the same edit.** The v2.0 change log stated the removal was
*"withdrawn on the attorney's advice and Bill's judgment."* The attorney's only
recorded comment on binding is under Q3 of the 2026-08-04 notes — that the
clause should be tested against Section 5 of the FTC Act, which says nothing
about physical hardware. **That is not advice to remove it.** The attribution
was invented.

**Action:** grep `ProjectDocs/` and `Masters/` for the phrase
`withdrawn on the attorney's advice`. It appeared in the 2026-08-07 draft and
was carried into `GatewayGuard_License-2026-08-24-1210`. It may also be in
`GatewayGuard_AttorneyConsultNotes-2026-08-07-0726.md`, which Cloud produced
the same session.

---

## 2. THE CURRENT LICENCE

**`GatewayGuard_License-2026-08-25-0921.docx` — version 2.2.**

Supersedes `GatewayGuard_License-2026-08-24-1210`. The 1820 draft is skipped
entirely and never enters the chain.

### Provenance caveat — please verify before trusting this

Cloud **could not read** `Masters/GatewayGuard_License-2026-08-24-1210.docx`.
The connector does not index `.docx`. Version 2.2 was reconstructed from
`ProjectDocs/GatewayGuard_License-2026-08-24-1210-TEXT.md` plus that file's
stated diff (Section 9 rewritten, change-log entry 2 rewritten, everything
else untouched).

**If the twin had drifted from the master, v2.2 inherits the drift.** Confirm
the twin matched before treating this as a valid supersession.

### What changed from 1210

| # | Change | Basis |
|---|---|---|
| 1 | Title is now **GATEWAYGUARD LLC — PRODUCT LICENSE AGREEMENT**. Footer matches. | Panther, this session — must cover the Guide and future products, not just Checkup |
| 2 | Section 1 states the agreement covers every product GatewayGuard sells, names the two that exist, and provides for future ones | Same |
| 3 | **PC binding restored**, rewritten customer-first | Panther, this session |
| 4 | Section 4 no-transfer bullet regains the PC-migration carve-out | Consequential to 3 |
| 5 | Change-log entry 1 rewritten — binding stays, wording changed, FTC §5 test noted as outstanding | Corrects the invented attribution |
| 6 | Prices and the subscription reference removed from Section 2 | Panther, this session; `GatewayGuard_Decisions-RefundAndTerms-2026-08-22-1510` (annual only, drop multi-year) |
| 7 | Change-log entry 7 added, explaining the price removal | Convention |
| 8 | Two new DECISION NEEDED callouts — what the bundle grants; multi-PC pack terms | `GatewayGuard_PriceDecision-GuideAndBundle-2026-08-23-1816` |
| 9 | Section 9 callout expanded — licence status on a Gumroad-initiated refund; all-or-nothing on multi-PC packs | `GatewayGuard_AttorneyNote-RefundPolicy-2026-08-24-1210` 2.5, 2.6 |

Section 9's body, Sections 6 through 8, and the Q5/Q9/Q10 callouts are
unchanged from 1210.

### How PC binding now reads

The original led with the mechanism — *"Checkup records a hardware identifier
from the first PC it is run on"* — which reads to a nervous buyer as a lock.
The rule is unchanged. The order is not. Section 2 now gives, in this sequence:
what the note is in plain terms, what it is **not** (no name, no email, no
account), why it exists (it is what allows a one-time price), what happens when
a PC is replaced, and how multi-PC packs work.

---

## 3. NUMBERED BLOCKS — APPLY THESE

**Block 1 — decide who owns the master.**

`GatewayGuard_License-2026-08-25-0921.docx` is a **Cloud-authored `.docx`**.
The 1210 master is Claude Code's. Two options:

```
Option A (Cloud prefers):
  Claude Code applies changes 1-9 above to Masters/GatewayGuard_License-2026-08-24-1210.docx
  and regenerates the twin. Cloud's .docx is reference only and is not committed.

Option B:
  Cloud's .docx becomes Masters/GatewayGuard_License-2026-08-25-0921.docx,
  Claude Code generates ProjectDocs/GatewayGuard_License-2026-08-25-0921-TEXT.md,
  and CURRENT.md gains a row.
```

**Option A is safer** — it keeps a single authoring lineage for the master and
avoids committing a file built from a reconstruction.

**Block 2 — retire three files.**

```
GatewayGuard_License-2026-08-24-1820.docx          withdrawn, do not commit
GatewayGuard_License-2026-08-07-0726.docx          withdrawn, do not commit
GatewayGuard_AttorneyQuestions-2026-08-07-0726.docx  Consult A built on the withdrawn refund policy
```

`GatewayGuard_AttorneyConsultNotes-2026-08-07-0726.md` is **worth keeping** —
the attorney's answers are valid. Only the binding attribution in it is wrong.
Correct that line rather than discarding the file.

**Block 3 — run the copy checks against v2.2.**

```
Run-CopyCheck.bat  (or equivalent) against the v2.2 text, specifically:
  - forever-family ban: does "we will never make your existing copy stop working" trip it?
    Cloud's read: it is a statement about our conduct, not a claim the product lasts
    forever. Adjacent enough that the checker may not draw that line. Needs a ruling.
  - UNIT RULE: no bare figures. v2.2 has no dollar amount in the operative terms.
    The one $79.99 is inside an internal DECISION NEEDED callout.
  - banned phrase "no subscription": absent.
```

---

## 4. OPEN — NEEDS PANTHER OR THE ATTORNEY

### 4a. The reissue promise is unbounded (highest priority)

Section 2 now promises license moves that are **free, unlimited, and require no
proof**. That is the friendliest version and it keeps support out of an argument
with a bereaved widow about a dead laptop. It is also a promise made in a
contract with no ceiling.

**Two confirmations needed before this ships:**

1. Panther confirms the promise as written.
2. **The tool can actually reissue.** If it cannot, that sentence is a promise
   we cannot keep. Cloud has not measured this and will not assert it.

### 4b. Section 13 contradicts Section 9

Section 13 reads: *"Ending the license does not entitle you to a refund except
as described in Section 9."*

That wording was written when Section 9 was the narrow sales-are-final rule with
three named exceptions. **Section 9 no longer has exceptions to point at.** As
it stands, a customer whose licence was terminated for breach appears to be
pointed at an unconditional 30-day refund right.

Not a wording cleanup. `GatewayGuard_Decisions-RefundAndTerms-2026-08-22-1510`
records that *"no questions asked earns its keep only if there are none. A
single hedge undoes the whole sentence."* Adding a Section 13 carve-out is that
hedge. Left untouched pending a decision.

**General point for whoever edits refunds next:** a refund change is never
confined to Section 9. Section 13 holds the only cross-reference in the
agreement, and change-log entry 2 describes the policy. The 1210 edit rewrote
Section 9 and entry 2; there is no evidence Section 13 was reviewed.

### 4c. FTC Act § 5 test is live again

With binding restored, the attorney's 2026-08-04 instruction stands: test the
clause against Section 5 of the FTC Act, 15 U.S.C. § 45. The Maine
consumer-protection question on hardware-bound software returns with it.

This belongs in the refund consult, not a separate call — for a buyer whose PC
died on day 31, binding and refunds are one conversation.

### 4d. The eight DECISION NEEDED callouts in v2.2

```
Section 1  — what the bundle grants; no bundle price for the 3/5/10-PC packs
Section 2  — multi-PC pack terms: one household, one person, or any PC the buyer owns
Section 2  — the reissue promise (see 4a)
Section 3  — Q5: was "a 2nd copy for security" the one backup copy already granted?
Section 6  — Q9: two softened warranties, confirm or restore
Section 7  — Q10: does the programs review ship at launch?
Section 9  — licence status on a Gumroad-initiated refund outside our 30 days
Section 9  — is a multi-PC pack refund all or nothing after partial install?
```

---

## 5. NOT YET BUILT

**The refund consult document.** Panther asked that unasked questions from the
2026-08-04 consult be bundled into later consults, and that the next consult be
the refund policy. Cloud identified seven combinable questions:

```
1. Gumroad as merchant of record — the root question under AttorneyNote 2.4 and 2.5
2. Chargeback risk to the Gumroad account — highest stakes, not in the note
3. Arbitration (from Q11) — the dispute path when a refund is refused
4. Terms-change mechanism (from Q11) — refunds are the term most likely to change
5. Liability cap (original Q5) — the cap is "amount paid"; a full refund is that amount
6. Bundle refunds — all or nothing?
7. Section 13 cross-reference (see 4b)
Plus: Q6 "no minimum of what" and Q8 "qualify in terms of" — unfinished since 2026-08-04
Plus: FTC Act § 5 test (see 4c), now live again
```

Merging these with the eight items in
`GatewayGuard_AttorneyNote-RefundPolicy-2026-08-24-1210` gives roughly thirteen
questions on one topic. AttorneyNote 2.4 and 2.5 fold under item 1 rather than
being asked separately. **Not built — awaiting go-ahead.**

---

## 6. WHAT CLOUD DID NOT DO

- Did not read `Masters/GatewayGuard_License-2026-08-24-1210.docx` — `.docx` is
  not indexed by the connector
- Did not verify the tool's reissue capability
- Did not touch Section 13
- Did not run `Run-CopyCheck.bat` — no checkout in the container
- Did not commit anything
