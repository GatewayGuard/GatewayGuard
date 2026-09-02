<!-- Dated: 2026-09-02 11:45 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Gumroad payout settings -- review

- **Document Name:** GatewayGuard_GumroadPayoutReview
- **Last Modified:** 2026-09-02 12:18 ET
- **Last Editor:** Claude Code (CGDELL)
- **For:** Bill
- **Covers:** CPM task **T-PAY2**
- **Basis:** Bill pasted the Settings -> Payments page, 2026-09-02. **I cannot
  see the Gumroad account** -- everything here is read from that paste and
  checked against the project record.

**No account numbers, routing numbers, tax IDs or dates of birth are recorded
in this document or anywhere in the repository.** They were in the pasted page
and are deliberately left out.

---

## THE HEADLINE -- THIS UNBLOCKS THE STORE

**The payout method was the one thing stopping either product from
publishing.** The product page said so in Bill's own screenshot on 2026-08-25:

> *"You haven't connected a payout method yet, so you won't be able to publish
> this product for sale."*

**Bank account details are now entered.** ***Not yet confirmed: that Gumroad has
accepted and verified them.***

**The test that settles it, and it takes ten seconds:** open either product and
see if that warning is gone. **If it is, both products can publish** and the
whole chain behind T-PAY2 is free to move.

---

## 1. DONE 2026-09-02 -- PAYEE NAME SET TO GatewayGuard LLC

**Bill set "Pay to the order of" to `GatewayGuard LLC`.**

**That agrees with everything else on the page** -- Account type Business, Legal
business name GatewayGuard LLC, Type LLC, a business Tax ID -- **and with the
record**: ***sourced, `BankLetterRequest-2026-08-02-1820-TEXT.md`***, the bank
letter concerns the *"GatewayGuard LLC Business Account"*, type *"business
checking"*.

### One thing still worth thirty seconds -- the exact spelling

Gumroad's note is *"Must exactly match the name on your bank account."* **Banks
are literal about this.** `GatewayGuard LLC`, `GatewayGuard, LLC` and
`GATEWAYGUARD LLC` are three different strings, and the bank chose one when the
account was opened.

**Open a statement or online banking, read the account title, and make the
Gumroad field match it character for character.** ***Not measured: how Maine
Community Bank titles it.***

**Why it is worth the look even now that the name is right in principle:** a
payee mismatch is accepted by Gumroad and returned by the receiving bank, weeks
later, after the first real sales.

---

## 1a. "SAME AS BUSINESS" -- TICK IT ONLY IF THE BUSINESS ADDRESS IS WHERE BILL LIVES

**Bill asked, 2026-09-02.**

**What that section is for.** The block beneath it -- name, address, date of
birth, last four of the SSN -- is **identity verification on the individual
behind the company**, not company information. A payment processor is required
to confirm a real person, against government records. **So those fields must be
the person's own true details**, whatever the company's are.

***Not measured: exactly which fields Gumroad's checkbox copies.*** From the
page layout it sits directly above the address fields and most likely copies
the business address into the representative's. It has not been seen in
operation here.

### The answer

**The two addresses in the pasted page are already identical**, so ticking it
changes nothing today. What it changes is the future: **edit the business
address later and the personal one follows silently.**

| Situation | Do |
|---|---|
| The Brunswick address **is** Bill's home | **Ticking it is accurate and harmless.** Convenience only |
| The business address is ever moved to a registered-agent service, a PO box, or an office, while Bill still lives elsewhere | **Leave it unticked.** A coupled personal address would quietly become wrong, and identity verification is exactly what breaks |

***inferred, not confirmed:*** the record describes a *"Noncommercial Registered
Agent at Brunswick ME address"* -- in Maine that is normally the owner at their
own address, which fits a home-based single-member LLC. **Bill knows; the record
does not.**

**Recommendation: leave it unticked.** The fields are already correct and
identical, so the box buys nothing today, and unticked keeps the personal
identity details from following a business address that may one day move.

---

## 2. DONE 2026-09-02 -- THRESHOLD LOWERED TO $100

**Bill changed it from $500 to $100**, the US minimum.

***calculated from the fees printed on the settings page*** -- direct sales
cost `10% + 50c + 2.9% + 30c`:

| Product | Price | Fees | You keep | Sales to first payout |
|---|---|---|---|---|
| Checkup | $19.99 | $3.38 | **$16.61** | **7** |
| Guide | $12.99 | $2.48 | **$10.51** | **10** |

**At $500 the Guide would have needed forty-eight sales before a dollar moved.
It now needs ten.** For a product with no customers yet, that is the difference
between money arriving in the first month and in the first quarter -- and the
first payout landing is itself the proof that the bank details work.

---

## 3. SCHEDULE IS MONTHLY

**Compounding item 2.** Even once the threshold is met, payment waits for the
monthly run.

***Not measured: which options that dropdown offers.*** The page only shows what
is selected, plus a note that **daily** needs *"more than 4 previous payouts"*
-- so daily is not available yet regardless.

**If weekly is offered, take it.** With the threshold at $100 it would mean
money arriving within days of the sales that earned it, which matters for a
first launch far more than it will later.

---

## 4. TWO THINGS THAT ARE NOT ON THIS PAGE BUT BELONG WITH IT

### PayPal at checkout -- worth a look, for this buyer specifically

The page notes: *"Looking for PayPal Connect? It moved to Checkout settings --
it lets buyers pay with PayPal at checkout and is separate from how you receive
payouts."*

**Our buyer is a non-technical senior**, and a good number of them will reach
for PayPal rather than type a card number into a site they met five minutes
ago. **That is the same trust problem the custom domain was bought to solve**,
and this is the other half of it.

***Not measured: whether Gumroad's PayPal Connect carries extra fees or
conditions.*** Worth checking before turning it on -- but worth checking.

### Gumroad Discover takes 30%, not 10%

Printed on the page: *"Direct sales: 10% + 50c... Discover sales: **30%
flat**."*

***calculated:*** on a $19.99 Checkup sale, direct costs **$3.38** and Discover
costs **$6.00** -- $2.62 more.

**This is not a mistake to fix, it is a choice to make knowingly.** Discover is
Gumroad's own marketplace: those are buyers who would not otherwise have found
us. **30% of a sale that would not have happened is better than 10% of
nothing** -- but it is the wrong economics if the customer came from our own
website and merely passed through Discover on the way.

**Decide it per product**, when the products are published.

---

## WHAT IS CORRECT, SO IT IS NOT RE-CHECKED

| Setting | State | Checked against |
|---|---|---|
| Account type | **Business** | The record throughout |
| Legal business name | **GatewayGuard LLC** | `CLAUDE.md` -- "LLC: GatewayGuard LLC (Maine)" |
| Entity type | **LLC** | Same |
| State | **Maine** | Same |
| Business Tax ID | entered | -- |
| Beneficial owner | one, **100%**, CEO | Correct for a single-member LLC |
| Pause payouts | **not engaged** | -- |
| Currency | **USD** | -- |

**The two local-currency toggles are a low-value decision either way.**
GatewayGuard is written for American seniors, names USA antivirus products, and
sells from a `.co` domain in Maine. International buyers will be rare. Leaving
them off is fine; turning them on costs nothing either.

---

## WHAT IS LEFT

**Ranked. The first one is the only one that gates anything.**

1. **Open either product and confirm the "you haven't connected a payout method"
   warning is gone.** Ten seconds. It is the only real test that the payout
   method took, and **both products stay unpublishable until it passes**
2. **Match the payee name to the bank's exact account title** -- item 1 above
3. **Weekly schedule** if the dropdown offers it. Daily needs four previous
   payouts, so it is unavailable regardless
4. Then the upload and test purchase, per
   `GatewayGuard_StoreTestFiles-2026-09-02-1119.md`

**No deadline, decide when convenient:** the "same as business" box (leave it),
PayPal at checkout, Discover at 30%, and the two local-currency toggles.

---

## ONE HOUSEKEEPING NOTE

**The pasted page carried a full routing number, the business address, a phone
number and a date of birth.** The account number, tax ID and SSN were masked by
Gumroad, so the exposure is limited -- **but a routing number plus an account
number is enough to originate a debit**, and the account number is one careless
paste away.

**Nothing financial from that page has been written into this repository**, and
it will not be. **In future, describing the setting is enough** -- *"threshold
is set to $500"* tells me everything I need, without the numbers travelling
anywhere.
