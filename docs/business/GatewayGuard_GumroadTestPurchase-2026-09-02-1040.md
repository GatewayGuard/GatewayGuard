<!-- Dated: 2026-09-02 10:40 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# How to test the checkout -- and why NOT to use your own credit card

- **Document Name:** GatewayGuard_GumroadTestPurchase
- **Last Modified:** 2026-09-02 10:40 ET
- **Last Editor:** Claude Code (CGDELL)
- **For:** Bill, before the first real sale
- **Covers:** CPM task **T-TP**
- **Source:** Gumroad Help Center, *"Testing a purchase"*, supplied by Bill
  2026-09-02. Everything below marked ***sourced*** is quoted from it.

---

## THE CORRECTION -- AND IT WAS MINE

**The record has told you, since 2026-08-25 and in six separate documents, to
buy your own product with a real credit card and then refund it. I repeated it
to you again on 2026-09-01. That advice is wrong, and it is not a small kind of
wrong.**

***sourced, Gumroad Help Center:***

> *"WARNING: Don't use your credit card to purchase your own items...do a test
> purchase instead!"*

> *"Identity thieves will sometimes use payment platforms (Gumroad, PayPal,
> etc.) to test stolen credit cards - charging themselves on different cards to
> see which ones can be used for fraud. When you create a product on Gumroad
> and start charging your own credit card for it, it appears exactly the same
> as money laundering to our security systems, **and your account may be
> automatically suspended as a result.**"*

> *"If you run actual sales on your products, and we discover this, we are
> required by our banking partners to refund these sales."*

**So the test I recommended, run on launch week, could have suspended the
account that takes the money -- automatically, and at the worst possible
moment.** The reasoning behind it was sound and the conclusion was still wrong:
a real card proves more than a test card, therefore use a real card. **Nobody
checked what the platform said about it**, and the platform has a page titled
exactly that question.

**This is the project's own named failure**, from `CLAUDE.md`: a flag or a
procedure belonging to an external program is a factual claim about that
program, and it does not get written until it has been read in that program's
own documentation. It was written six times instead.

**Bill found this, not me.**

---

## WHAT TO DO INSTEAD -- FIVE STEPS, NO CARD

***sourced, all five steps:***

1. **Stay logged in to your Gumroad account.** This is the whole mechanism --
   Gumroad recognises you as the seller and substitutes a test card.
2. Go to your product's page in the dashboard, then **click the link beneath
   the product name** to open the buyer's purchase page.
3. Click **"I want this!"** to reach the checkout.
4. On the checkout page the payment method reads **"Test card"**. If it says
   anything else, stop -- you are not logged in as the seller.
5. Click **Pay**.

> *"You will not be charged for anything you buy from yourself while logged
> into your account."*

**Alternative, also sourced:** a **100% discount code**. Same result, no charge.

**Do this twice -- once for Checkup, once for the Guide.** They are separate
products with separate files, separate receipts and separate refund toggles,
and testing one proves nothing about the other. That is the same failure mode
as the two refund toggles.

---

## WHAT THE TEST PURCHASE PROVES

***sourced:***

- **The checkout works and completes.**
- **Both emails send** -- *"you will receive emails notifying you of both your
  sale and your purchase."*
- **What the customer actually sees**, end to end, which is the other reason to
  do it.
- **File delivery -- BUT ONLY ONCE A FILE IS ATTACHED.** ***sourced:*** *"You
  can also use the test purchase feature to download your own files and give
  peace of mind that things are working correctly."*

  ***Bill, 2026-09-02: "we don't have product files setup yet that would be
  downloaded at gumroad."*** **So today a test purchase cannot prove this
  half.** It is still worth running now for the checkout and the emails, and
  **run again after each file is uploaded.** Test purchases are free and
  unlimited, so two costs nothing.

  ***not measured: whether Gumroad will even complete a purchase of a product
  with no file attached.*** The test purchase itself settles that, which is
  another reason to run it before launch week rather than during it.

**So: two of the four unknowns close today, at zero risk. The third closes when
the files are uploaded.**

---

## WHAT IT DOES NOT PROVE -- AND THE RIGHT WAY TO CLOSE THE REST

### 1. That a real card is charged, and that money reaches the bank

***inferred:*** the test card is a stub. It cannot exercise a real
authorization, and it cannot move money.

**Gumroad's own answer to this, and it is explicit** -- ***sourced:***

> *"If you are concerned that your bank account or PayPal will not be
> successfully paid out by Gumroad, please notify us so we can verify that
> everything is working. **Do not attempt to work around the system - just
> ask!**"*

**So the step that replaces the real-card purchase is: email Gumroad support
and ask them to confirm the payout method is working.** It costs one message,
it carries no suspension risk, and it is the route the platform asks for by
name.

### 2. That the refund button does what it says

***not measured.*** A test purchase is $0, and it is unclear a $0 sale can be
refunded at all. **Ask this in the same message to support** -- one message,
two questions.

### 3. That the licence acceptance lands in the sales CSV

**This one is new, and it is a problem the old plan did not have.**

The licence work has a step reading *"Make a test purchase and confirm the
acceptance is recorded in the sales CSV"* -- it appears in
`GatewayGuard_CloudResearch-Licence-2026-08-25-1435.md` twice and in
`GatewayGuard_DecisionsForBill-2026-08-26-0302.md`.

***sourced:*** *"This test sale will not be displayed in your Audience
Dashboard alongside your other sales."*

***inferred:*** if the test sale is held apart from the real ones, **it may not
appear in the exported CSV either** -- in which case a test purchase cannot
prove the acceptance is recorded, and that verification needs another route.

**Check the CSV export straight after the test purchase and see if the row is
there.** Thirty seconds, and it either closes the question or turns it into a
third thing to ask support.

---

## WHAT CHANGES IN THE SCHEDULE

**T-TP gets cheaper and safer, and it grows a support round trip.**

| | Before | Now |
|---|---|---|
| The act | Buy with a real card, then refund | Test purchase, twice, no card |
| Bill-hours | 1.0 | **0.5** |
| Risk | **Account suspension** | none |
| New dependency | -- | **One email to Gumroad support**, sent early because a reply is not instant |

**Send the support message now rather than in launch week.** It is the only
part with a waiting time in it, and it is the same mistake as leaving the DNS
propagation window until the end.

---

## WHERE THE WRONG ADVICE STILL SITS

Corrected in place, each pointing here:

- `GatewayGuard_CPM_Schedule-2026-08-31-1439.md` -- task **T-TP**, the critical
  path diagram, and the Bill-hours table
- `GatewayGuard_DecisionsForBill-2026-08-26-0302.md` -- item 4
- `GatewayGuard_DecisionsForBill-2026-08-25-1620.md` -- item 3 *(superseded)*
- `GatewayGuard_LaunchPlan-2026-08-14-0107.md` -- item **C4**
- `GatewayGuard_CPM_FinalWeek-2026-08-24-2330.md` -- Mon 31 row, and the float
  section *(superseded)*
- `GatewayGuard_GumroadListings-2026-08-25-0015.md` -- the "do this first"
  checklist, item 3

**Left as written, deliberately:** `GatewayGuard_SessionLog-2026-08-13-1433.md`
and `GatewayGuard_CloudRequest-CPM-2026-08-30-2200.md`. Those are a record of
what was said at the time, and rewriting history hides that the mistake was
made.
