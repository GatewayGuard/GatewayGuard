<!-- Dated: 2026-08-22 15:10 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Decisions -- refund policy, and annual updates only

- **Document Name:** GatewayGuard_Decisions-RefundAndTerms
- **Last Modified:** 2026-08-23 01:50 ET
- **Last Editor:** Claude Code (CGDELL)
- **Decided by:** Bill, 2026-08-22
- **Status:** **SETTLED.** Both decisions are closed. This document is the
  authority for each; where any other document disagrees, this one is right and
  the other is stale.

**Change History Log:**
- 2026-08-23 01:50: **Decision 3 added -- "no questions asked" supersedes EULA
  Section 9.** The two policies conflicted and nothing had compared them.
- 2026-08-22 15:10: Created. Bill settled both in one message.

---

## WHY THIS IS A SEPARATE DOCUMENT

Both decisions belong to documents **Claude Cloud is actively rewriting** --
`MarketingPlan-2026-08-22-1000.md` and `PricingCopy-2026-08-22-1000.md`. A
decision written only into a file that is about to be re-delivered is a decision
that can quietly vanish. **Governing documents are Claude Code's to author**, so
the decision lives here and the other documents cite it.

---

## DECISION 1 -- ANNUAL UPDATES ONLY. NO MULTI-YEAR PRE-PAY.

**Bill, 2026-08-22:** *"annual update only, drop multi-year."*

**There is one renewal product: a yearly update.** These four prices, locked
2026-08-21 and derived in `GatewayGuard_PriceDecision-Annual-2026-08-21-1445.md`:

| PCs | Annual updates |
|---|---|
| 1 | **$12.99** |
| 3 | **$22.99** |
| 5 | **$32.99** |
| 10 | **$51.99** |

One-time purchase prices are unchanged and have been final since 2026-06-26 --
**$19.99 / $34.99 / $49.99 / $79.99** for 1, 3, 5 and 10 PCs
(`PricingReconciliation-2026-07-16.md`).

### WHAT THIS CLOSES

- **`MarketingPlan` section 7, decision 7** -- *"Multi-year pre-pay -- which
  terms exist, what each costs, and how '10% per year' applies (flat, or
  deepening with the term)."* **CLOSED. The question is removed, not answered:
  there are no multi-year terms, so there is no discount rule to settle.**
- **`PricingCopy` section 5**, the held multi-year block, is **retired. It never
  publishes.** It is already marked DO NOT PUBLISH, so nothing is live; the
  `[[TIERS]]`, `[[TERM]]`, `[[PRICE]]` and `[[SAVING]]` tokens are now dead and
  the section comes out at the next delivery rather than being filled in.
- **`_READ-FIRST-Briefing` open item 12** -- *"Annual Updates pricing is still
  open"* -- was already stale after the 2026-08-21 lock. **Now closed twice
  over.**

### WHAT IT DOES NOT CLOSE

- **`MarketingPlan` decision 3, multi-PC licence terms.** Still open, and this
  decision does not touch it. What is open there is **not the prices** -- those
  are locked above -- but **the terms**: how many machines one purchase covers,
  whose machines, household or per-person, and what happens when a buyer
  replaces a PC. The packs run to $79.99, which is enough money that the terms
  will be read. *(This is Cloud's finding M-3, and it stands.)*
- **`MarketingPlan` decision 4, the delivery mechanism.** `FP-21`. A price with
  no way for a buyer to receive and pay for the update is still a promise the
  store cannot keep.

### WHY DROPPING IT IS THE RIGHT CALL, NOT JUST THE QUICK ONE

**One renewal price is one thing to explain.** The product is bought by people
whose stated fear is signing up to something they cannot get out of. A pre-pay
ladder is the exact shape of the thing they are afraid of, and the held copy had
to spend its last and most important sentence -- *"your copy of Checkup never
expires"* -- reassuring them about it. **Removing the ladder removes the need
for the reassurance.**

It also removes a maintenance burden nobody costed: three more prices to keep
consistent across the site, the listing, the guide and the plan, each one
another place to go stale. This project has spent real time this week on
exactly that failure.

---

## DECISION 2 -- REFUNDS: 30 DAYS, NO QUESTIONS ASKED

**Bill, 2026-08-22:** *"go with 30 day."*

**This closes `MarketingPlan` section 7 decision 2 -- named there as the only
genuine store-opening blocker.**

### THE FACT THAT DECIDED IT

**"No refunds" was never actually available.** *Sourced, Gumroad, checked
2026-08-22:*

- Gumroad **reserves the right to refund within 90 days at its own discretion**,
  to head off chargebacks.
- **Card networks allow a chargeback at any time**, whatever the seller's policy
  says.
- **Too many successful disputes put the seller account at risk of suspension.**

So a restrictive policy does not prevent refunds. **It converts some of them
into chargebacks** -- the same money out, plus fees, plus a bad review, plus
risk to the account. It is unenforceable theatre that costs trust and buys
nothing.

### THE SETTING

Gumroad offers **none / 7 / 14 / 30 / 183 days**. Set it to **30**.

**Treat it as account-wide.** *The sources disagree and this is not settled:*
one says per-product policies were sunset 2025-03-31, another describes a
per-product toggle on the product edit page. **It does not matter here** -- the
same 30 days is right for the Guide, Checkup and the annual updates, so the
account-wide setting covers all three whichever is true. Recorded rather than
resolved, because a claim with two sources against each other is not a fact.

**Why not the others:**

- **7 or 14 is too short for this buyer.** A senior buys on a Tuesday, means to
  get to it at the weekend, then the weekend after. Fourteen days can be gone
  before they have opened it. **A refund window that expires before first use
  reads as a trick**, which is the opposite of what it is for.
- **183 days is too long** for something fully consumed on the first run.
- **30 days is the window buyers already expect**, covers the realistic delay,
  and ends before the value has been taken.

### WHAT IT COSTS

**Gumroad keeps its 10% commission and the $0.50 flat fee on a refund**, so a
returned $19.99 sale costs about **$2.50**, not nothing.

Against the plan's own projection of 1,000 first-year sales, a 5% refund rate
is roughly **$125 in fees plus $999 returned, against $19,990**. Digital-goods
refund rates usually run in low single figures, so that is a conservative
reading. **This is not a number that should shape the policy.**

### THE PUBLISHED COPY

Approved wording. It goes on the product page and the download page, and the
EULA is linked from both.

```
Refunds -- 30 days, no questions asked.

If Checkup is not what you expected, write to us within 30 days of
buying and we will refund you in full. You do not have to give a
reason.

Because the full source code is included and readable, you will
have already downloaded it. That is deliberate -- you are meant to
be able to check what it does before you trust it. We ask that you
delete your copy when we refund you, and your licence ends at that
point.
```

**House-rule check on that copy:** no *whether*, no *whereas*, no jargon, no
dead end, and it says plainly what happens and what is asked in return. The
second paragraph exists because a buyer who has downloaded readable source will
wonder how a refund can possibly work -- **answer it on the page rather than
leaving them to guess.**

### WHAT STAYS UNPUBLISHED

- **Serial-abuse handling.** Refund anyone once. Quietly decline a repeat buyer
  who refunds repeatedly. **This never appears in the policy** -- published fine
  print frightens honest buyers and does not stop dishonest ones.
- **Any condition at all.** *"No questions asked"* earns its keep only if there
  are none. A single hedge undoes the whole sentence.

### THE REASON THIS IS WORTH MORE THAN IT COSTS

**It is already the pitch.** The trust ladder promises the skeptic *"read every
line after you buy, and return it if you do not like what you find"*
(`MarketingPlan` section 3). Without a refund policy behind it, that promise is
not backed. **With one, the most cautious buyer in the market is being handed
the reassurance they came looking for.** For an audience whose central fear is
being scammed, a visible unconditional refund does marketing work, not just
legal work.

---

## DECISION 3 -- "NO QUESTIONS ASKED" SUPERSEDES EULA SECTION 9

**Bill, 2026-08-23: "go with no questions asked."**

**This is a correction to a conflict I created and did not spot.** When decision
2 was written on 2026-08-22 I recommended an unconditional 30-day refund
**without reading the licence agreement, which already contained a refund
policy** -- Section 9 of `GatewayGuard_License-2026-08-07-0726`, written on the
attorney's advice after the 2026-08-04 consultation. I worked from the marketing
plan, which listed the refund policy as an open decision. **The EULA had
answered it two weeks earlier. Both documents were in `ProjectDocs\`.**

### WHAT DISAGREED

| | EULA Section 9 | Decision 2, now ratified |
|---|---|---|
| Basis | **"Sales are final"**, three named exceptions | **"No questions asked"** |
| Conditions | Double charge / download never arrived / will not run on a listed-compatible PC | **None** |
| Evidence | Log file required for the third exception | None |
| Window | 30 days | 30 days |

**The window was the only part that agreed.** Everything else was opposite.

### THE REPLACEMENT TEXT FOR SECTION 9

**Drop this into the `.docx` master, `Masters\GatewayGuard_License-*.docx`.**
Not applied by Claude Code: the `-TEXT.md` in `ProjectDocs\` is a **generated
twin** and the next regeneration would overwrite any edit made to it. The
`.docx` is the master and it is a legal document.

```
9. Refunds

If you are not happy with what you bought, tell us within 30 days of
your purchase and we will refund you in full. You do not have to give
a reason.

Email support@gatewayguard.co with your order number.

Checkup and the Guide are downloadable files, so you will already have
them. That is deliberate -- you are meant to be able to read every line
of what you bought before you decide to trust it. If we refund you,
your licence ends, and we ask you to delete every copy you have,
including any backup copy.

If you bought through Gumroad, Gumroad processes the payment and may
also issue refunds under its own policy.
```

### WHAT THIS SETTLES, AND WHAT IT DOES NOT

**Section 9 carried a `DECISION NEEDED -- refund terms` block with three
parts. Two are now closed and one is gone:**

- **(a) The 30-day window** -- *"14 and 30 days are both common."* **CLOSED: 30.**
- **(b) The three exceptions** -- **GONE.** An unconditional policy has no
  exceptions to tune.
- **(c) The log-file location** -- **no longer a refund question.** It was only
  needed to evidence the third exception. It remains an open question for the
  Guide, which has to tell a reader where their log is for other reasons.

**AND IT QUIETLY SOLVES A PROBLEM SECTION 9 FLAGGED AND I HAD MISSED.** The
EULA's own note warns that **buyers in the EU and UK often hold a 14-day
withdrawal right** unless it is waived at checkout for instant downloads. **A
no-questions-asked 30-day policy is strictly more generous than a 14-day
statutory right, so it satisfies it without any special handling.** The
conditional version did not, and would have needed a carve-out.

### STILL FOR THE ATTORNEY, AND THIS IS THE ONE THING NOT TO SKIP

**Section 9 as it stands was written on the attorney's advice.** Replacing it
with a broader promise is Bill's commercial call and a reasonable one -- but
**the attorney recommended the narrow version and has not seen the broad one.**
Two points to put in front of them:

1. **The broad policy gives away more than the narrow one and that is
   deliberate**, because the product's central promise is that a buyer can read
   the source after purchase and return it if they do not like what they find.
   The narrow version did not back that promise.
2. **It is also more enforceable in practice.** *Sourced 2026-08-22:* Gumroad
   refunds at its own discretion within 90 days and card networks allow
   chargebacks regardless, so a narrow policy does not prevent refunds -- it
   converts them into chargebacks, which cost more and threaten the seller
   account.

---

## ACTIONS, AND WHOSE THEY ARE

**Bill:**
1. **Set the Gumroad account refund policy to 30 days.** It is account-wide, so
   this is one setting, once. **Neither Claude can do this** -- it is a
   browser-only setting on Bill's own account.
   - gumroad.com > sign in > **Settings** > the refund policy section > set the
     refund period to **30 days**. **Leave the optional fine print blank.**
   - **Check what it says before changing it.** *Sourced 2026-08-22:* Gumroad
     switched every store to a 30-day money-back guarantee at some point,
     including stores selling only digital goods. It may already be right.
   - *One caveat, because the sources disagree:* one says per-product policies
     were retired 2025-03-31, another describes a per-product toggle on the
     product edit page. **Set the account-wide one either way** -- that is the
     policy decided here.
2. **REPLACE EULA SECTION 9 in the `.docx` master** with the text in decision
   3 below, and **take it to the attorney** -- they wrote the narrow version and
   have not seen the broad one. *(This item said "show the refund clause to the
   attorney" when it was written, which understated the job: at that point I did
   not know Section 9 existed.)*

**Claude Cloud, at the next delivery:**
3. `MarketingPlan` -- close decisions 2 and 7 in section 7, citing this
   document. Decision 2 is no longer the store-opening blocker.
4. `PricingCopy` -- delete section 5 and the four dead tokens. Add the refund
   block above to the product page and download page copy.

**Claude Code:**
5. Briefing open item 12 -- closed. *(Done, this commit.)*
6. Apply the refund copy to `WebSite\` when Bill says the pages are being
   touched, under the website-copy rule.

---

## ONE THING NEITHER DECISION SETTLES

**How a buyer actually receives and pays for a yearly update is still unbuilt**
-- `FP-21`, `MarketingPlan` decision 4. The site now sells a $12.99 renewal.
**Until there is a mechanism behind it, that is a promise the store cannot
keep**, and it is a larger hole than either decision closed today.
