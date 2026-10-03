<!-- Dated: 2026-08-24 12:10 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Refund policy -- what changed, and what to ask the attorney

- **Document Name:** GatewayGuard_AttorneyNote-RefundPolicy
- **Last Modified:** 2026-08-24 12:10 ET
- **For:** the follow-up legal consult
- **The document under review:** `Masters\GatewayGuard_License-2026-08-24-1210.docx`
  (readable twin: `ProjectDocs\GatewayGuard_License-2026-08-24-1210-TEXT.md`)
- **Authority for the change:** `GatewayGuard_Decisions-RefundAndTerms-2026-08-22-1510.md`
  -- Bill, 2026-08-22: *"go with 30 day."*

---

## 1. WHAT CHANGED, IN ONE PARAGRAPH

**Section 9 said "sales are final" with three named exceptions and a log-file
requirement. It now gives a full refund on request within 30 days, no reason
required.** The old text was written before Bill's decision and contradicted
it. The change log at the top of the agreement described the old rule and has
been rewritten to match; nothing else in the agreement was touched, including
the four live `DECISION NEEDED` blocks on Q2(d), Q5, Q9 and Q10.

**The old and new text are both reproduced in section 5 below** so the attorney
can see exactly what was withdrawn.

---

## 2. THE SUGGESTIONS -- WHAT I WOULD PUT TO THE ATTORNEY

Ordered by how much they could cost if they go unasked.

### 2.1 Does a no-questions policy create a warranty we did not intend?

**This is the one I would ask first.** Section 6 makes limited promises and
Section 8 disclaims the rest. Section 9 now says we refund if the product *"is
not what you expected."*

**Does "not what you expected" import a fitness-for-purpose standard through
the back door**, and does it sit badly beside the "as is" language in Section
8? If so, the fix is probably a sentence saying the refund is offered as a
matter of policy and is not an admission or a warranty. **Ask whether that
sentence helps or whether it just draws attention.**

### 2.2 The product is readable source code. A refund cannot un-give it.

**This is the unusual fact and the attorney needs it stated plainly.** Checkup
ships as plaintext PowerShell -- deliberately, because auditability is the
selling point. A refunded customer keeps a working, readable copy.

We have chosen to accept that. **The question is whether the agreement should
say anything about it at all.** Section 9 currently asks the buyer to delete
their copies and openly admits we cannot check. **Is that admission wise or
unwise?** It is honest and it fits the brand, but an attorney may see it as
volunteering that the term is unenforceable.

### 2.3 EU and UK buyers, and the 14-day withdrawal right

*Sourced, and already flagged in the August 7 draft's own note:* buyers in the
EU and UK often hold a 14-day right to withdraw, **unless it is waived at
checkout for an instant download.**

**Two questions.** Does Gumroad actually capture that waiver at checkout, and
if not, does our 30-day policy simply absorb the issue by being more generous?
**And do we sell to the EU and UK at all?** If Bill would rather not, that is a
Gumroad setting and a much simpler answer than a legal one.

### 2.4 Gumroad can refund over our heads, for longer than we say

*Sourced:* Gumroad reserves the right to issue refunds within **90 days** at
its own discretion, to head off chargebacks. Our policy says 30.

**So the agreement describes something we do not fully control.** Section 9 now
says so in a sentence. **Is that sentence sufficient, or does the agreement
need to be explicit that Gumroad's terms govern the payment and ours govern
the licence?**

### 2.5 What happens to the licence on a Gumroad-initiated refund?

Ours ends when *we* refund. **If Gumroad refunds on day 75 without asking us,
does the licence end then too?** As drafted it is not clear. **This is a real
gap**, not a hypothetical -- Gumroad's discretion is documented.

### 2.6 Multi-PC packs -- is a refund all or nothing?

The packs run to 10 PCs at $79.99. **If a buyer wants a refund on a 5-PC pack
after installing on two, is that a full refund, a partial one, or nothing?**
The agreement is silent. **My suggestion is full refund, all or nothing, on the
same 30 days** -- partial refunds need pro-rata arithmetic, a support
conversation, and a way to revoke two licences we have no way to revoke. **But
it should be a decision, not a silence.**

### 2.7 The annual update -- does 30 days work for a renewal?

Annual updates are $12.99 a year. **A renewal is delivered immediately and is
worth less than the original purchase.** Does the same 30-day window apply?
**And can a buyer refund an update and keep using the version they already
had?** Presumably yes, since the old version still runs. **Confirm that is
intended**, because it means an update can be tried and returned each year.

### 2.8 Maine law -- the original question, still unanswered

The August 4 draft asked *"what Maine law requires, if anything, for a digital
software product sold to consumers."* **It has never been answered.** A 30-day
no-questions policy is almost certainly more generous than anything required,
**but "almost certainly" is not an answer and this is the second consult.**

---

## 3. THINGS I DELIBERATELY DID NOT CHANGE, AND WHY

- **The four other `DECISION NEEDED` blocks** -- Q2(d) checkout wording, Q5
  backup copies, Q9 removed absolute claims, Q10 launch timing for the programs
  review. **None is a refund question.** They are live and belong in the same
  consult.
- **Section 11, Ending This License**, which says ending the licence does not
  entitle you to a refund *"except as provided in Section 9."* That cross-
  reference still resolves correctly.
- **The font.** The agreement is Calibri 11pt, and the house document standard
  is Garamond 14pt. **It is a legal document on the attorney's template and I
  am not restyling it mid-consult.** Worth raising once the text settles.

---

## 4. WHAT BILL STILL HAS TO DO HIMSELF

**The Gumroad account setting. Nothing in this document has any effect until it
is set.** Gumroad offers none / 7 / 14 / 30 / 183 days; **set it to 30.**
Account-wide, browser only, his login.

**Until that is done, the agreement and the website both promise a window the
platform is not configured to honour** -- which is a worse position than
before, because previously nothing was promised anywhere.

---

## 5. THE TEXT, OLD AND NEW

### WAS (August 7 draft, Section 9)

> Checkup and the Guide are downloadable files. Once the download reaches you,
> we cannot take it back, so sales are final — with the three exceptions below.
>
> We will refund your purchase in full if any of these apply and you contact us
> within 30 days of buying:
>
> - You were charged twice for the same product.
> - Your download never arrived, or the file would not open, and we could not
>   fix it for you.
> - Checkup will not run on your PC, your PC runs a version of Windows 11
>   listed at gatewayguard.co/compatible, and our support could not get it
>   running.
>
> For the third case, send us the log file that Checkup creates on your PC so
> we can see what happened. The Guide shows you where to find the log file.
>
> To ask for a refund, email support@gatewayguard.co with your order number and
> a short description of the problem.
>
> If we approve a refund, your license ends. Delete every copy of the product
> you have, including your backup copy.
>
> If you bought through Gumroad, Gumroad processes the payment and may also
> issue refunds under its own policy.

### IS NOW

> Checkup and the Guide are downloadable files. If either one is not what you
> expected, write to us within 30 days of buying and we will refund you in
> full. You do not have to give a reason.
>
> You do not need to prove anything, send us a log file, or let us try to fix
> the problem first. If you would like to tell us what went wrong we are glad
> to hear it, because it is how the product improves — but it is not a
> condition of your refund.
>
> To ask for a refund, email support@gatewayguard.co from the address you
> bought with, or use the refund link in your Gumroad receipt. Give us your
> order number. We aim to answer within two business days.
>
> When we refund you, your license ends and you should delete the copies you
> have, including any backup. We are aware we cannot check this, and we are not
> going to try. We are asking you to be straight with us, in the same way we
> are being straight with you.
>
> If you bought through Gumroad, Gumroad handles the payment and may also issue
> a refund under its own policy, which can run longer than our 30 days. Nothing
> here takes away any right you have under the consumer law where you live.

---

## 6. EVERYWHERE THE POLICY NOW APPEARS

| Where | State |
|---|---|
| `Masters\GatewayGuard_License-2026-08-24-1210.docx` Section 9 | **Rewritten today** |
| Same file, change-log entry 2 | **Rewritten today** -- it described the old rule |
| `WebSite\html\GatewayGuard_PricingSectionHtml-2026-08-23-1816.html` | **Added today.** *measured 2026-08-24: the website carried zero mentions of refunds anywhere before this* |
| `GatewayGuard_MarketingPlan-2026-08-22-1000.md` | Already correct -- it is the source the other two were copied from |
| **Gumroad account setting** | **NOT SET. Bill's job, and the only one that controls anything** |
