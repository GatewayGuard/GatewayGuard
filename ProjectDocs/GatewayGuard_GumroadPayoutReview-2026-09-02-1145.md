<!-- Dated: 2026-09-02 11:45 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Gumroad payout settings -- review

- **Document Name:** GatewayGuard_GumroadPayoutReview
- **Last Modified:** 2026-09-02 11:45 ET
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

## 1. "PAY TO THE ORDER OF" -- CHECK THIS BEFORE ANYTHING ELSE

**The field reads `William F Burns IIi`. Gumroad's own note under it says the
name *"Must exactly match the name on your bank account."***

**Two separate problems, and either one can bounce a payout.**

### a. It ends in a lowercase i

`IIi` where the beneficial-owner section on the same page reads `William F
Burns III`. It may be an artifact of copying the page rather than what is
actually stored. **Look at the field on screen and confirm.**

### b. It names a person, and the record says the account belongs to the company

***sourced, `BankLetterRequest-2026-08-02-1820-TEXT.md`:*** the letter Bill
requested is headed *"Request for Bank Manager Letter -- **GatewayGuard LLC
Business Account**"* and asks the bank to confirm *"the account type (**business
checking**)"*.

**So the record describes a business checking account titled to GatewayGuard
LLC, while Gumroad is set to pay an individual.** The rest of the page agrees
with the company reading -- Account type **Business**, Legal business name
**GatewayGuard LLC**, Type **LLC**, a business Tax ID.

***Not measured: which account was actually linked.*** It may be a personal
account, in which case the individual name is right and there is nothing to fix.

**What to do:** look at how the bank has the account titled -- on a statement,
or in online banking -- and make this field say exactly that. **If the account
is titled GatewayGuard LLC, this field should say GatewayGuard LLC.**

**Why it matters more than it looks.** A deposit whose payee name does not match
the account title can be returned by the receiving bank. It would not fail at
Gumroad, where it would be visible -- **it would fail weeks later, at the bank,
after the first real sales.**

---

## 2. THE PAYOUT THRESHOLD IS SET FIVE TIMES HIGHER THAN IT NEEDS TO BE

**Set to `$500`. The page says: *"The minimum payout threshold for United States
is $100."***

**Nothing pays out until the balance reaches the threshold.** ***calculated
from the fees printed on that same page*** -- direct sales cost
`10% + 50c + 2.9% + 30c`:

| Product | Price | Fees | You keep | Sales to reach $500 | Sales to reach $100 |
|---|---|---|---|---|---|
| Checkup | $19.99 | $3.38 | **$16.61** | **31** | **7** |
| Guide | $12.99 | $2.48 | **$10.51** | **48** | **10** |

**So at $500 the Guide has to sell forty-eight copies before a single dollar
moves. At $100 it is ten.**

**For a product with no customers yet, that is the difference between seeing
money in the first month and seeing it in the first quarter.** There is no
benefit to the higher number -- the money is not earning anything sitting at
Gumroad, and a first payout landing is itself a test that the bank details work.

**Recommendation: change it to $100.** One field, no downside.

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

## THE ORDER TO DO THESE IN

1. **Confirm the publish warning is gone** on both products -- ten seconds, and
   it tells you the payout method actually took
2. **Fix "Pay to the order of"** to match the bank exactly
3. **Threshold $500 -> $100**
4. **Weekly schedule** if it is offered
5. Then the upload and test purchase, per
   `GatewayGuard_StoreTestFiles-2026-09-02-1119.md`

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
