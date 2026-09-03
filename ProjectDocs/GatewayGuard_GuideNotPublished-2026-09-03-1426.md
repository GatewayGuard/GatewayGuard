<!-- Dated: 2026-09-03 14:26 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# The Guide has no purchase button because it is not published -- and six things to fix while you are in there

- **Document Name:** GatewayGuard_GuideNotPublished
- **Last Modified:** 2026-09-03 14:26 ET
- **Last Editor:** Claude Code (CGDELL)
- **For:** Bill, at the Gumroad editor
- **Covers:** CPM tasks **T-UPG**, **T-TP**
- **Companion to:** `GatewayGuard_GuideVersions-Gumroad-2026-09-02-1841.md`

---

## THE ANSWER

***measured 2026-09-03 14:24, from the two product pages' own data
(`store.gatewayguard.co/l/guide` and `/l/checkup`, the `data-page` payload each
page ships to the browser):***

| | Checkup | The Guide |
|---|---|---|
| **`is_published`** | **`true`** | **`false`** |
| `price_cents` | 1999 | 1299 |
| `is_sales_limited` | false | false |
| `quantity_remaining` | null | null |
| options (versions) | 0 | **5, all present** |

**That single field is the whole difference.** Everything else on the Guide is
set correctly -- the price is there, all five versions are there with their
names and descriptions, each carries `price_difference_cents = 0` as intended,
and none is quantity-limited. Nothing is sold out and nothing is misconfigured.

**The fix is one click: open the Guide in Gumroad and press Publish.** That is
the same step that made Checkup buyable, and Checkup's `is_published: true` is
the proof it works.

*(An unpublished product still serves its page over a direct link, which is why
you can see it and click the versions. It just cannot be bought. That is what
you were looking at.)*

---

## THE CHECKUP TEST PURCHASE WORKED -- CONFIRMED FROM THE RECEIPT

***measured, `Test_Results\You bought GatewayGuard Checkup! ... Gmail.html`:***

| | |
|---|---|
| Order ID | `Lm_y3IZXSlFbBI6nYsBV0Q==` |
| Order date | Sep 3, 2026 |
| Total | **$19.99** |
| Product named on the receipt | **GatewayGuard Checkup** -- correct, matches the licence |
| Buyer email on the seller notice | `admin@gatewayguard.co` |
| Quantity / Referrer | 1 / Direct |

**It was a test sale, not a real charge.** The receipt says so in its own words
-- *"This was a test purchase -- you have not been charged (you are seeing this
message because you are logged in as the creator)"* -- and the seller
notification says *"Because this was a test sale, this amount will not"* be
added to the balance. **The corrected procedure held. No card was used.**

The receipt's own message reads: *"Thank you for choosing GatewayGuard Checkup.
Your download link is below. Nothing is changed on your PC unless you say yes,
and you can read every line of the script yourself."*

**Both files came down** -- the Checkup zip and a 16-point Guide PDF are in
`Test_Results\`.

---

## SIX THINGS TO FIX WHILE YOU ARE IN THERE

**The first two are on the page that takes the money. Fix those before you
publish.**

### 1. The description names the wrong domain

***measured, live on the Guide page right now:***

> *"Free online documentation is available at **gatewayguide.co** (not .com) to
> preview all 19 covered security settings before purchase."*

**`gatewayguide.co` is not our domain. It is `gatewayguard.co`.** The sentence
that exists to stop a `.com` mistake is itself pointing at a site we do not own.
It appears once, in the refund fine print, and the same text is repeated in the
product description.

### 2. The description uses the banned word

***measured, same paragraph:*** *"how to configure it confidently, **whether**
you use Windows 11 Home or Pro."*

Replace the clause:

> ...what each key setting does, why it matters, and how to configure it
> confidently **on both Windows 11 Home and Pro**.

*(Optional, same sentence: "harden your PC" is jargon. "secure your PC" says the
same thing to a senior.)*

### 3. Checkup has no refund policy set at all

***measured:*** Guide `refund_policy` = *"No refunds allowed"*. Checkup
`refund_policy` = **`null`**.

The Guide's matches licence v3.0. **Checkup's is missing**, and v3.0 gives
Checkup a **14-day full refund, no reason required**. A product already
published and already able to take money is publishing no refund terms.

**Also worth a look in the Guide's wording:** *"all standalone guide sales are
final once downloaded."* **"Once downloaded" is a condition**, and it invites
the question of what happens to a buyer who has not downloaded yet. v3.0 sells
the Guide without a refund, full stop.

### 4. Version 1's name has two typing slips

***measured:*** `'12  point - standard print '` -- a **double space** between
"12" and "point", and a **trailing space**.

Replace with exactly:

```
12 point - standard print
```

The other four names are clean.

### 5. Three version descriptions have doubled spaces

| Version | What is there | Fix |
|---|---|---|
| 16 point | leading space, `or  reach`, `to  support@` | single spaces, no leading space |
| 18 point | `a      different one` (six spaces) | `a different one` |
| 20 point | `size?  Write` | `size? Write` |

Copy them fresh from `GatewayGuard_GuideVersions-Gumroad-2026-09-02-1841.md`
rather than hunting the spaces by eye.

### 6. The additional-details table is mis-paired, and one row is now untrue

***measured, the Guide's three rows:***

| Name column | Value column |
|---|---|
| `Format - PDF, five print sizes` | `Works on Windows 11 Home & Pro` |
| `Needs Checkup? - No ` | `The Guide is complete on its own` |
| `Print it Yes -- printing is allowed ` | *(empty)* |

Gumroad renders these as **label / value** pairs. Here the label and its answer
are mashed together in the label, the value column holds something unrelated,
and the third row's value is blank. Compare Checkup's, which are correct pairs.

Suggested rows:

| Name | Value |
|---|---|
| `Format` | `PDF` |
| `Works on` | `Windows 11 Home and Pro` |
| `Needs Checkup?` | `No. The Guide is complete on its own.` |
| `Printing` | `Yes. Print your copy.` |

**`Format - PDF, five print sizes` is now false** under Option B -- a buyer
receives one size, chosen at purchase. That is the listing-copy change already
flagged in the versions document, and this is where it is live.

---

## WHAT I DID NOT CHECK

- ***Not measured:*** how the version files download once the product is
  published -- there is nothing to buy yet.
- ***Not measured:*** the terms-acceptance URL field at checkout. There is still
  no licence page on `gatewayguard.co` for it to point at (**T-EULA**).
- ***Not measured:*** the five real Guide PDFs. The versions currently carry the
  `TESTFILE - ` stand-ins.
