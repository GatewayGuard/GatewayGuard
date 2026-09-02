<!-- Dated: 2026-09-02 15:04 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Refund policy -- the rationale, the copy, and where the structure breaks

- **Document Name:** GatewayGuard_RefundPolicyRationale
- **Last Modified:** 2026-09-02 15:04 ET
- **Last Editor:** Claude Code (CGDELL)
- **Asked for by Bill, 2026-09-02:** *"come back with a rationale policy where no
  refund on guide and 14 days on checkup and a refund policy for the bundle"*
- **Prompted by:** a Gemini exchange Bill supplied the same day
- **Supersedes for decision purposes:** the 30-day decision of 2026-08-24

---

## THE SHORT VERSION

**Gemini's analysis is well argued and three of the facts under it are wrong for
Gumroad.** The one that matters most:

***sourced, Gumroad Help Center:*** *"Gumroad reserves the right to issue
refunds within **90 days** of purchase, at its discretion, to prevent
chargebacks."*

**So "All sales final" is not a thing you can enforce on Gumroad.** You can
publish it -- *"If you want to have a 'No refunds' policy, that's fine"* -- but
Gumroad can refund over your head for 90 days, and the buyer can chargeback
through their bank indefinitely.

**Which means the real choice is not "refund or no refund."** It is:

> **Refund on your terms, or refund on Gumroad's terms with a chargeback
> attached.**

**The requested structure can be written and is below.** It has one hole at the
bundle that cannot be patched, and the simplest fix makes the whole policy
shorter. **Both versions are drafted -- Bill picks.**

---

# PART 1 -- THE THREE FACTS THAT CHANGE THE ANSWER

## Fact 1: you cannot make a sale final on Gumroad

| Claim | Verdict |
|---|---|
| Gemini: *"All sales final... due to instant delivery"* is a workable policy | **Publishable, not enforceable.** Gumroad refunds at its own discretion for 90 days |
| Gemini: high refund rates risk account review | **Correct**, and worth respecting |
| Gemini: *"processing fees are non-refundable... roughly $0.70--$0.90"* | **Correct.** ***sourced:*** *"Gumroad returns the Gumroad fee minus the fee charged by their payments processor."* On $12.99 that is about **68c**; on $19.99, about **88c**. **There is no fee for issuing the refund itself** |

**What "all sales final" actually buys you:** it stops the *honest* buyer from
asking. The unhappy one goes to Gumroad, or to their bank.

**And a chargeback is strictly worse than a refund.** It costs the sale, a
dispute fee, and a mark on the store's risk score -- the same risk score Gemini
correctly warns can put payouts on hold. **A published refusal converts polite
requests into chargebacks.** That is the opposite of protecting the account.

## Fact 2: the instructions are free, so there is nothing to steal

**Bill's own point, and Gemini agreed with it before contradicting itself.**

All 19 settings are being published free on the website. Gemini: *"Opportunistic
download-and-refund buyers will simply read the free web version. The people who
pay $12.99 or $19.99 do so explicitly because they value the convenience."*

**Then, four answers later, it recommended "All Sales Final" for the Guide
anyway.** That is an internal contradiction, and the earlier half is the correct
half.

***The entire case for locking down the Guide is "buy it, read it, refund it."
That abuse is pointless when the same words are free on the website.*** The
$12.99 buys an offline PDF in five print sizes. A refunder gains nothing they
could not have had for nothing.

## Fact 3: this project already tried conditional refunds, and withdrew them

**Gemini's central recommendation is a conditional refund** -- *"if the software
fails to execute, throws unresolved script errors, or encounters compatibility
issues... that our support team cannot resolve."*

**That is what the licence said in the 7 August draft, and it was deliberately
removed on 24 August.** ***sourced, `License-2026-08-25-1400-TEXT.md`, change
note 2:*** *"The August 7 draft filled it with a sales-are-final rule carrying
three named exceptions and a log-file requirement. **That has been
withdrawn.**"*

**And the reason was written down** -- ***sourced,
`Decisions-RefundAndTerms-2026-08-22-1510.md`:***

> *"**Any condition at all.** 'No questions asked' earns its keep only if there
> are none. A single hedge undoes the whole sentence."*

### Why the condition is wrong for THIS buyer, specifically

**Gemini's condition is "the software fails to execute."** Consider the actual
customer: a seventy-eight-year-old buys Checkup, runs it, and finds it
confusing or not what they pictured.

**The software executed perfectly. They get nothing.**

**That is the single customer most likely to feel misled, and they are the
customer this product exists for.** A policy that pays out only on technical
failure protects against the one thing that will rarely happen and refuses the
thing that will.

**It is also the wrong shape in front of a regulator.** The audience is elderly
Americans; the policy would require the buyer to prove a technical failure by
email, arguing with a solo seller. The attorney already has an FTC Act Section 5
question open on the PC-binding clause. **This would be a second one, and a
worse one.**

---

# PART 2 -- THE POLICY AS ASKED FOR

**Guide: no refund. Checkup: 14 days. Bundle: stated below.**

## Where it holds up

- **14 days on Checkup is the right length.** Gemini is right that 30 days is a
  physical-goods and SaaS convention. Two weeks is ample to run a checkup tool,
  and it shortens the window in which a buyer forgets what they bought
- **The support-cost argument is real.** At $12.99, a single back-and-forth
  email costs more than the sale
- **Free online documentation genuinely lowers refund pressure** -- nobody buys
  by mistake when they can read the whole scope first

## Where it breaks: the bundle, and it cannot be patched

**Bundle $29.99 = Checkup $19.99 + Guide $12.99**, a $2.99 saving.

**If the Guide alone is non-refundable and the bundle is refundable, you have
built an arbitrage:**

> A buyer who wants the Guide and might want their money back buys **the bundle**
> -- because that route is refundable and the Guide alone is not.

**And the alternative is worse.** Make the bundle non-refundable to close the
hole, and now the software carries no guarantee whenever it is bought in a
bundle -- which is the route you most want people to take.

**Splitting the difference is worse still.** Refunding "the Checkup portion" of
a $29.99 bundle means computing Checkup's discounted share -- **$18.18** -- and
explaining that arithmetic to a senior by email. **At this price the support
time exceeds the money in dispute.**

**There is no arrangement of "Guide never, Checkup sometimes" that closes this.**
The bundle is one purchase and the policy has two rules for it.

## The requested policy, written out anyway

**This is usable. The bundle clause below picks the least-bad option --
refundable in full -- and accepts the arbitrage.**

```
GatewayGuard Refund Policy

Checkup -- $19.99
If Checkup is not what you expected, write to us within 14 days of
buying and we will refund you in full. You do not have to give a
reason.

The Guide -- $12.99
Every setting the Guide covers is explained free on our website, so
you can read the whole of it before you decide. Because of that, the
Guide is sold without a refund.

Checkup and the Guide together -- $29.99
The 14-day refund covers the whole bundle. If it is not what you
expected, write to us within 14 days and we will refund the full
$29.99.

To ask for a refund, email support@gatewayguard.co from the address
you bought with. Give us your order number. We aim to answer within
two business days.
```

---

# PART 3 -- WHAT I RECOMMEND INSTEAD, AND IT IS SHORTER

**One rule, three products, no arbitrage, no arithmetic:**

```
GatewayGuard Refund Policy

If what you bought is not what you expected, write to us within
14 days and we will refund you in full. You do not have to give a
reason.

This covers Checkup, the Guide, and the two bought together.

To ask for a refund, email support@gatewayguard.co from the address
you bought with. Give us your order number. We aim to answer within
two business days.
```

**Four lines. Nothing to interpret, nothing to argue about, and nothing a buyer
can game.**

## Why this is the better business decision, not just the simpler one

1. **The exposure is trivial and calculable.** ***calculated:*** at a 3% refund
   rate -- the high end of what Gemini cites -- 100 Guide sales produce 3
   refunds costing **$2.04 in unrecovered processing fees.** That is the entire
   downside being protected against.

2. **It is already the pitch, and the pitch is the product.** ***sourced,
   `MarketingPlan` section 3:*** the trust ladder promises the skeptic *"read
   every line after you buy, and return it if you do not like what you find."*
   **Checkup ships as readable source precisely so a suspicious buyer can
   verify it.** A refund refusal on the companion Guide argues against your own
   central promise.

3. **The audience's central fear is being scammed.** ***sourced, the 22-Aug
   decision:*** *"For an audience whose central fear is being scammed, a visible
   unconditional refund does marketing work, not just legal work."* **A senior
   who reads "sold without a refund" on a security product from a company they
   have never heard of does not buy it.** The lost sales will exceed the
   refunds, and they will be invisible.

4. **It keeps the chargeback rate down**, which is the account risk Gemini
   correctly identified. Refunds you grant are cheap; disputes you force are
   not.

5. **It survives the attorney unchanged.** The consult questions, the licence
   Section 9, and the website all currently describe one unconditional window.
   **Changing the number from 30 to 14 is one word. Changing the shape is a
   rewrite of the clause, the consult questions, and three marketing
   documents.**

---

# PART 4 -- TWO THINGS IN GEMINI'S COPY THAT MUST NOT BE PUBLISHED AS WRITTEN

## The 25% figure does not match the record

**Bill told Gemini** *"tamper protection [forces] manual changes on about 25% of
the settings"*, and Gemini built landing-page copy on it -- *"75% Automated...
25% Guided Manual Precision."*

***measured, the reviewed Gumroad listing copy:*** *"Where Windows will not let
any program make a change, Checkup shows you the exact steps and waits while you
do it yourself. **There are two settings like that**, and Checkup says so rather
than pretending."*

**Two of nineteen is about 11%, not 25%.** ***Not measured: an independent
recount from the ascii43 source*** -- the two figures disagree and one of them
is going on a sales page. **Settle it before either number is published.**

## The register is wrong for the audience

Gemini's copy says *"runs elevated PowerShell scripts to instantly verify,
harden, and apply optimal security preferences across the registry, Defender
policies, and system services."*

**That is written for an administrator.** The house rule is plain English with
jargon deleted rather than explained. **The idea underneath it is genuinely
good, though, and worth keeping:**

> *Windows deliberately blocks programs from silently changing its most
> important security settings. That protection is doing its job. For those
> settings, Checkup shows you exactly what to change and waits while you do it.*

**That reframes a limitation as evidence of good behaviour, which is Gemini's
best contribution here.** It belongs on the product page in that voice.

---

# WHAT IS NEEDED FROM BILL

**One line settles it:**

- **"as asked"** -- Part 2 goes in: Guide non-refundable, Checkup 14 days,
  bundle refundable in full
- **"one rule"** -- Part 3 goes in: 14 days on everything

**Then, either way:**

1. Licence Section 9 is rewritten -- **it currently covers both products in one
   sentence at 30 days**, so it changes under either choice
2. Both Gumroad refund toggles are set -- **per product, two of them**
3. The consult question list gains one line, so the attorney reviews the final
   shape rather than the withdrawn one
4. **The 25%-versus-two-settings discrepancy is settled before any sales copy
   quotes either number**
