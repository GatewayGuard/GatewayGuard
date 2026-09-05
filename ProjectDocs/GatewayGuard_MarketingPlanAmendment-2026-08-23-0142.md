<!-- Dated: 2026-08-23 01:42 ET -->
# Marketing Plan — amendment closing M-1, M-2, M-3

- **Document Name:** GatewayGuard_MarketingPlanAmendment
- **Last Modified:** 2026-08-23 01:42 ET
- **Last Editor:** Claude.ai (Cloud)
- **Machine:** CGDELL
- **Amends:** `GatewayGuard_MarketingPlan-2026-08-22-1000.md`
- **Supersedes:** `GatewayGuard_MarketingPlanAmendment-2026-08-22-1000.md`, which has been applied
- **Answers:** `GatewayGuard_DefectPassResponse-2026-08-22-1525.md`, findings M-1 to M-4
- **Status:** Block replacements. Claude Code applies and commits.
- **Written against freshness stamp:** `e4a4654`, generated 2026-08-23 01:36 ET

**Change History Log:**

- 2026-08-23 01:42: **Reissued. Content unchanged; pointers corrected.** The
  refund/terms decision record and the defect pass response were both renamed
  with `-HHMM` suffixes in commit `e4a4654`. Blocks 2e and 2f cited the old
  names. Now `-1510` and `-1525`. **Supersedes
  `GatewayGuard_MarketingPlanAmendment-2026-08-22-2307.md` (superseded; now `GatewayGuard_MarketingPlanAmendment-2026-08-23-1816.md`).**

- 2026-08-22 23:07: Created. Closes the three marketing findings handed back to
  Cloud, plus M-4's residual short form. **Line numbers throughout are Claude
  Code's measurements**, quoted from `DefectPassResponse`, not counted by me.

---

## 1. WHY THIS IS AN AMENDMENT AGAIN

Third time, and the reason has not changed: **I have not read the 08-22 plan
end to end this session.** I read section 2's tables, section 3's ladder,
sections 4 through 7, and section 8. Sections 1 and the back half of 5 came
through search results only. A reissue built on that would silently drop
whatever I did not retrieve and would look complete. READ-BEFORE-PRODUCING
forbids it.

**One convention change, and it is the lesson from last time.** The 08-22 10:00
amendment raised M-2 and M-3 in its commentary sections rather than as numbered
blocks. Claude Code correctly applied only the blocks, so both findings survived
into the next version and I filed them again as defects the following morning.

> **Rule, going forward: anything I want applied goes in a numbered block.
> Commentary is commentary and will not be applied.** Sections 4 and 5 below are
> commentary and are marked as such.

---

## 2. BLOCK REPLACEMENTS

### 2a. M-1 — the page count, line 110

Section 3, trust ladder table, the $8.99 Guide rung.

**Currently:**

> The company delivers a finished product for money, and the writing holds up over 49 pages

**Replace the cell with:**

```
The company delivers a finished product for money, and the writing holds up
```

**Why the number comes out rather than getting corrected.** Section 2 line 68
bans any page count, and line 151 repeats the ban in its own sentence. The
rung's claim is that the company ships something finished; the count adds
nothing to that and breaks a rule stated twice in the section above it. It would
also need re-measuring at every revision, which is the reason for the ban.

---

### 2b. M-2 — the countdown, lines 169 and 271

**Line 169, currently:**

> ## 4. LAUNCH -- SEVENTEEN DAYS

**Replace with:**

```
## 4. LAUNCH -- TARGET 2026-09-01
```

**Line 271, section 7 decision 1, currently:**

> Everything in section 4 depends on it. Seventeen days

**Replace the cell with:**

```
Everything in section 4 depends on it. Target is 2026-09-01
```

**The general rule, and it is worth writing into the plan rather than only
fixing the instance: state the date, never the interval.** A countdown is wrong
the morning after it is written and nothing reports it. This one was written on
2026-08-22 against a 2026-09-01 launch and said seventeen, which was already ten
on the day it was filed.

---

### 2c. M-3 — decision 3, which reads as a pricing question

Section 7, decision 3.

**Currently:**

> | 3 | **Multi-PC licence terms** | Must appear in the listing |

**Replace the row with:**

```
| 3 | **Multi-PC licence terms.** The prices are settled -- $19.99 / $34.99 / $49.99 / $79.99 to buy, and $12.99 / $22.99 / $32.99 / $51.99 a year to keep current. **What one purchase actually covers is not.** How many machines, whose machines, household or per-person, and what happens when a buyer replaces a PC | The packs run to $79.99, which is enough money that the terms will be read. The yearly update is now sold per pack too, so the listing has to say how many machines a $22.99 renewal covers |
```

**Why it needed rewording rather than leaving open.** Decision 4, four rows
below, states the multi-PC rates as settled. Read together, decision 3 looks
like a pricing question that was answered the day before. **The prices are
closed and the terms are open**, and the row should say which.

*Prices sourced: `PricingReconciliation-2026-07-16.md` (one-time, final
2026-06-26) and `GatewayGuard_PriceDecision-Annual-2026-08-21-1445.md` (annual,
locked 2026-08-21). Neither figure is from memory.*

---

### 2d. M-4 residual — the short form at line 54

**Conditional. Apply only if it is still present.** `DefectPassResponse` records
that Bill chose the long form and that the index meta description was fixed. It
does not record the line 54 deletion, so this may already be done.

Section 2, APPROVED table.

**Delete the row:**

> | **One-time purchase. Updates are optional.** | Anywhere |

**Keep** the long form, which names the annual charge:

```
One-time purchase, yours to keep. Annual updates are optional.
```

**Two approved sentences doing one job is how the footer drifted in the first
place.** The long form is the one `PricingCopy` already uses in three places,
and it is the one that says out loud that there is a yearly charge — which is
the entire reason *"No subscription — ever"* had to go.

---

### 2e. Section 7 decision 7 — close it

Not one of the numbered findings. **It is closed by a decision filed after the
plan was written**, and leaving it open would send someone to settle a question
that no longer exists.

`GatewayGuard_Decisions-RefundAndTerms-2026-08-22-1510.md` records Bill's
2026-08-22 instruction: *"annual update only, drop multi-year."*

**Replace the decision 7 row with:**

```
| 7 | ~~Multi-year pre-pay terms and the "10% per year" rule~~ | **CLOSED 2026-08-22.** Bill: annual updates only, no multi-year pre-pay. The question is removed rather than answered -- there are no multi-year terms, so there is no discount rule to settle. Authority: `GatewayGuard_Decisions-RefundAndTerms-2026-08-22-1510.md` |
```

---

### 2f. Section 7 decision 2 — close it

Same authority, same reason. **This is the row that has been called the only
genuine store-opening blocker in every review since 2026-08-18**, so it should
not be left reading as open.

**Replace the decision 2 row with the settled position recorded in
`GatewayGuard_Decisions-RefundAndTerms-2026-08-22-1510.md`.**

> **CLAUDE CODE: do not write this row from this file.** I have read that
> document's decision 1 in full and only the opening of decision 2. Take the
> refund wording from the decision document itself so the plan quotes the
> authority rather than my partial read of it.

---

## 3. THE FOOTNOTE THAT SHOULD OUTLIVE THIS AMENDMENT

Add beneath section 2's BANNED table:

```
**A claim about a number is a claim.** Page counts, day counts and price
counts all go stale on their own schedule and nothing in the repository
reports it. Where a figure has to appear, state the source it came from
and the date it was measured, or state the date the count runs to. A bare
number in marketing copy is a claim with no owner.
```

**Earned three times in eight days:** the ink-saver line that a measurement did
not support, the 49-page count in a document that bans page counts, and a
seventeen-day countdown that was ten days wrong when it was filed.

---

## 4. COMMENTARY — WHAT THIS AMENDMENT DOES NOT TOUCH

*Not blocks. Nothing here is applied.*

- **Sections 1 and the back half of 5.** Not read in full this session.
- **Section 3's five-editions pitch and the trust ladder** beyond the one cell
  in 2a.
- **Channels 1, 2, 3 and 5.**
- **Decisions 1, 4 and 5.** Decision 1 is the launch shape and is Bill's;
  decision 4's delivery mechanism (`FP-21`) is genuinely open; decision 5 is a
  recommendation waiting on a yes.
- **Section 4's pre-launch task list.** It still names fixing the flyer drafts
  and `MarketResearch.md`. I have no evidence either way on whether those
  landed, and I am not marking them done from an absence of mention.

---

## 5. COMMENTARY — ONE THING WORTH RAISING

*Not a block.*

**The refund decision removes the launch's last hard blocker, and that makes
the guide the critical path on its own.**

Every review since 2026-08-18 has named the refund policy as the only thing that
could stop a store opening. It is settled. What is left between here and a
2026-09-01 guide launch is the guide itself: **six retrieval gaps, eleven
unmeasured VERIFY claims, one setting with no body section, and a placeholder
that will print.** Two of the eleven can cost a reader their files if wrong.

The gap-fill source is written and committed. The corrections are specified. The
measurements are the part nobody has scheduled, and they need a machine and an
hour rather than a document.

**That is not a marketing decision and I am not making it.** But section 4's
launch shape rests on the guide being the easy half, and it is now the only
half.

---

*End of document.*
