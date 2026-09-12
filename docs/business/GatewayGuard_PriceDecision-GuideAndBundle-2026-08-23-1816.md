<!-- Dated: 2026-08-23 18:16 ET -->
# Price Decision — the Guide, and the Checkup + Guide bundle

- **Document Name:** GatewayGuard_PriceDecision-GuideAndBundle
- **Last Modified:** 2026-08-23 18:16 ET
- **Last Editor:** Claude.ai (Cloud)
- **Decided by:** Bill, 2026-08-23
- **Machine:** CGDELL
- **Status:** Decision record. **Two changes, both closed.** Where any other
  document disagrees, this one is right and the other is stale.
- **Written against freshness stamp:** `dd916d0`, generated 2026-08-23 12:47 ET

**Change History Log:**

- 2026-08-23 18:16: Created. Filed in the session the decision was made, per
  FILE-IMMEDIATELY.

---

## 1. THE DECISION

**Bill, 2026-08-23:** *"the one copy of security guide changes to $12.99 and
the bundled price for one copy each of checkup and guide will cost $29.99."*

| Product | Was | Now |
|---|---|---|
| **Security Guide, one copy** | $8.99 | **$12.99** |
| **Bundle — 1 Checkup + 1 Guide** | no price, no record | **$29.99** |

**Everything else is unchanged.** Checkup stays at $19.99 / $34.99 / $49.99 /
$79.99 for 1, 3, 5 and 10 PCs (`PricingReconciliation-2026-07-16.md`, final
2026-06-26). The annual update stays at $12.99 / $22.99 / $32.99 / $51.99
(`GatewayGuard_PriceDecision-Annual-2026-08-21-1445.md`, locked 2026-08-21).

**The bundle arithmetic, stated so nobody has to redo it:** bought separately
the two come to **$32.98**. The bundle saves **$2.99**, which is **9.1%**.

---

## 2. THE ONE THING THAT NEEDS A DECISION BEFORE ANY COPY IS WRITTEN

**$12.99 now names two different products.**

| $12.99 | What it is |
|---|---|
| **The Security Guide** | One-time. A PDF you keep. |
| **The annual Checkup update, 1 PC** | Every year, optional. |

**These will collide on the pricing page**, where both numbers appear within a
few lines of each other, and they will collide in support email. A buyer who
reads *"$12.99"* twice on one screen and is told once that it is forever and
once that it is yearly has been given a reason to distrust the page — and the
whole trust-ladder argument in the marketing plan rests on the page being
plain.

**Three ways out, and it is Bill's call:**

1. **Leave both at $12.99** and never let the two numbers appear without their
   unit attached — *"$12.99 once"* and *"$12.99 a year"*, every time, with no
   bare `$12.99` anywhere on the site. **This is a copy rule that has to hold
   across 19 pages plus the index and download page.**
2. **Move the Guide to a different number** — $11.99 or $13.99 — so the two
   are never confusable.
3. **Move the annual update.** Not recommended: it was locked 2026-08-21 and
   the three multi-PC rates are derived from it, so changing it reopens four
   prices instead of one.

**Recommendation: option 1, with the copy rule written into the marketing
plan's BANNED/APPROVED tables** so it is enforceable by `Run-CopyCheck.bat`
rather than remembered. A bare `$12.99` with no unit becomes a gate failure.

**Not decided here.** This is flagged, not settled.

---

## 3. WHAT THIS CLOSES

**`PricingReconciliation-2026-07-16.md`'s open bundle item.** That document
records under *NOT confirmed / no record*: *"$59.99 bundle: no record in any
project file. Do not use this number in any material until a decision is
logged here."* **This is that decision, and the number is $29.99, not
$59.99.** The $59.99 figure remains unsupported and must not be used.

**A live inconsistency in the licence going to the attorney.**
`GatewayGuard_License-2026-08-04-0120-TEXT.md` already promises a bundle
exists — *"they are purchased separately, though a bundle is also offered"*,
and section 1's *"Purchasing one product does not grant a license to the
other, except where a bundle purchase is made."* **Until today that described
a product with no price and no decision behind it.** It now has both.

---

## 4. WHAT IT DOES NOT CLOSE

- **What the bundle grants.** The obvious reading is one Checkup licence for
  one PC plus one Guide licence. **Nobody has written that down**, and the
  licence's section 1 needs it in the same words the packs get.
- **Bundles for the multi-PC packs.** There is no 3-, 5- or 10-PC bundle
  price. If a Maven buying the $79.99 pack wants the Guide too, the answer
  today is $79.99 + $12.99. **That may be the right answer — it is simply not
  a decision yet.**
- **Guide licence terms.** `MarketingPlan` decision 3 covers how many machines
  a Checkup purchase covers. **The Guide has the same question in a different
  shape** — one household, one person, may it be printed twice — and a PDF is
  harder to bound than a hardware-bound script.
- **The annual update's per-update-versus-yearly wording in the licence.**
  `GatewayGuard_License-2026-08-04-0120-TEXT.md` section 2 says updates are
  *"available separately for $12.99 per update, or as part of an annual update
  subscription if offered at the time of purchase."* That predates the
  2026-08-22 *annual updates only* decision and disagrees with it. **Separate
  from this decision, and it should not reach the attorney as written.**

---

## 5. WHAT MUST BE EDITED — MEASURED, AND NOT COMPLETE

**Grep before editing.** Search `ProjectDocs\` and `WebSite\` for `8.99` and
for `59.99`. The list below is what surfaced in project knowledge, which is a
retrieval and not a grep.

| File | What changes |
|---|---|
| `PricingReconciliation-2026-07-16.md` | The **Security Guide** row: $8.99 → **$12.99**, source *"DECIDED 2026-07-16, revised 2026-08-23"*. Add a **bundle** row at $29.99. The *NOT confirmed* bundle bullet is now answered — rewrite it to point here rather than deleting it, so the $59.99 ban survives |
| `PricingReconciliation-2026-07-16.md`, GUIDE SCOPE section | Two more instances — *"What does $8.99 buy"* and *"is the $8.99 product"* |
| `GatewayGuard_MarketingPlan-2026-08-22-1000.md` §3 | Trust ladder row label **The $8.99 Guide** → **The $12.99 Guide**; and the line beneath the table, *"a buyer who has already paid $8.99"* |
| `GatewayGuard_MarketingPlan-2026-08-22-1000.md` §4 | The Guide-first launch table: *"Security Guide, $8.99, live on Gumroad"* |
| `GatewayGuard_MarketingPlan-2026-08-22-1000.md` §4 | The locked-prices table takes a **bundle** row |
| `GatewayGuard_PricingCopy-2026-08-22-1000.md` | The Guide price wherever it appears, plus a bundle line. **Section 5's dead multi-year block should come out in the same pass** — it was retired 2026-08-22 and is still there |
| `GatewayGuard_License-*-TEXT.md` | Section 1 needs the bundle defined. See section 4 above |
| `WebSite\` | Any page or index build quoting $8.99 for the Guide. **Not visible to me as a count — grep it** |

**Sequencing, and it matters.** `GatewayGuard_MarketingPlanAmendment-2026-08-23-0142.md`
is not yet applied and its block **2a** edits the same trust-ladder row this
decision relabels. **Apply the amendment first, then this price change**, or
do both in one pass. Applying them in the other order will make 2a's anchor
text miss.

---

## 6. WHAT THE CHANGE DOES TO THE TRUST LADDER

*Commentary. Not a decision, and nothing below is applied.*

**The ladder still works, and its middle rung is now less cheap.** The
argument in `MarketingPlan` section 3 is that a buyer proves the company by
spending a small amount before spending a full amount. **At $12.99 against
$19.99, the small amount is 65% of the full one** — where at $8.99 it was 45%.

**Two consequences worth naming before the copy is written:**

1. **The bundle competes with the ladder.** At $29.99 the bundle is $2.99
   cheaper than climbing the ladder in two steps. **A buyer who is ready to
   trust us takes the bundle; a buyer who is not takes the Guide.** That is a
   reasonable place to land — but the pricing page has to present both paths
   without pushing the cautious buyer at the bundle, because the cautious
   buyer is the one the ladder was built for.
2. **The Guide is now the more expensive half of the launch in effort terms**
   and closer in price to the tool. **The five-editions pitch carries more
   weight at $12.99** than it did at $8.99, and the *"finished product"* claim
   in the ladder has to hold up harder. Nothing in the guide's current state
   contradicts that — **but six retrieval gaps closed today is what makes it
   true, and the eleven VERIFY claims are what would make it false.**

---

*End of document.*
