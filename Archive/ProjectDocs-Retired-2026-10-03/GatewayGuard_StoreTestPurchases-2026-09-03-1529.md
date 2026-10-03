<!-- Dated: 2026-09-03 15:29 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Both test purchases went through -- what the two receipts prove, and the seven defects still live

- **Document Name:** GatewayGuard_StoreTestPurchases
- **Last Modified:** 2026-09-03 15:29 ET
- **Last Editor:** Claude Code (CGDELL)
- **For:** Bill
- **Covers:** CPM task **T-TP**
- **Closes:** `GatewayGuard_GuideNotPublished-2026-09-03-1426.md` -- the Guide is
  published, ***measured 15:27: `is_published: true`***, and the purchase below
  proves it.

---

## THE CHAIN WORKS, BOTH PRODUCTS

| | Checkup | The Guide |
|---|---|---|
| Order ID | `Lm_y3IZXSlFbBI6nYsBV0Q==` | `oRdas6pjue4Bh-DGiv6aoA==` |
| Order date | Sep 3, 2026 | Sep 3, 2026, 15:18 ET |
| Total | **$19.99** | **$12.99** |
| Product name on receipt | correct | correct |
| **Variant named** | n/a | **`20 point - largest print`** |
| Refund block shown | **none** | *"No refunds allowed"* |
| Thank-you message | **yes** | **none** |
| Test sale, no charge | yes | yes |
| Reply-To | -- | `support@gatewayguard.co` -- correct |

**The version mechanism works, and that was the thing that had to.** Under
Option B a buyer receives one print size, and the receipt has to say which one,
or the buyer has no record of what they bought. **It does: `Variant: 20 point -
largest print`.** The description does not appear on the receipt -- only the
name -- which is another reason the name has to carry the meaning on its own.

**Both were test sales.** Gumroad's own words: *"This was a test purchase -- you
have not been charged (you are seeing this message because you are logged in as
the creator)."*

Receipts filed: `Test_Results\You bought GatewayGuard Windows Security
Walkthrough Guide!.eml` (and an identical copy in `Store_TestFiles\`), and the
Checkup receipt saved as Gmail HTML alongside it.

---

## SEVEN DEFECTS, ALL STILL LIVE -- ***measured 15:27 on both pages***

**Ranked by who sees them and how permanent it is.**

### 1. `gatewayguide.co` is in the buyer's receipt

***measured, the Guide's refund fine print, reproduced verbatim in the receipt
email:***

> *"Free online documentation is available at **gatewayguide.co** (not .com) to
> preview all 19 covered security settings before purchase."*

**That is not our domain. It is `gatewayguard.co`.** I placed this on the product
page last time; the receipt raises it, because a receipt is the buyer's
permanent record and we cannot edit one already sent. **It is in the refund
policy field, not the description** -- that is why it survived; the page shows
the two together.

The sentence exists to prevent a `.com` mistake and is itself sending people to
a site we do not own.

### 2. "whether" is in BOTH product descriptions

***measured:***

- **Guide:** *"how to configure it confidently, **whether** you use Windows 11
  Home or Pro."*
  Replace with: *"...how to configure it confidently **on both Windows 11 Home
  and Pro**."*
- **Checkup:** *"You choose **whether** to apply it."*
  Replace with: *"**You choose if it is applied.**"*

Checkup's is new -- I only scanned the Guide last time. **Checkup has been
published and selling with it.**

### 3. Checkup still publishes no refund terms

***measured:*** Checkup `refund_policy` = **none set**. The Guide's is set and
correct.

Licence v3.0 gives Checkup a **14-day full refund, no reason required**. The
product taking $19.99 states nothing.

### 4. The Guide's receipt has no thank-you message

Checkup's receipt carries one: *"Thank you for choosing GatewayGuard Checkup.
Your download link is below. Nothing is changed on your PC unless you say yes,
and you can read every line of the script yourself. If you need help or have
questions, just reply to the receipt email -- we're here."*

**The Guide's receipt goes straight from the price to the download link.** The
field is set on one product and empty on the other.

### 5. The Guide's refund wording carries a condition v3.0 does not

*"all standalone guide sales are final **once downloaded**."* v3.0 sells the
Guide without a refund, full stop. "Once downloaded" invites the question of
what a buyer who has not downloaded is owed.

### 6. Version 1's name, and three descriptions, carry stray spaces

***measured, unchanged since yesterday:***

| Where | What is there |
|---|---|
| Version 1 **name** | `12  point - standard print ` -- double space, trailing space |
| Version 3 desc | leading space, `or  reach`, `to  support@` |
| Version 4 desc | `a      different one` (six spaces) |
| Version 5 desc | `size?  Write` |

Correct text: `GatewayGuard_GuideVersions-Gumroad-2026-09-02-1841.md`.

### 7. The additional-details table is mis-paired, and one row is untrue

***measured, unchanged:***

| Name column | Value column |
|---|---|
| `Format - PDF, five print sizes` | `Works on Windows 11 Home & Pro` |
| `Needs Checkup? - No ` | `The Guide is complete on its own` |
| `Print it Yes -- printing is allowed ` | *(empty)* |

Label and answer are mashed into the label; the value column holds something
unrelated; one value is blank. **And `five print sizes` is false under Option B**
-- a buyer receives one.

Suggested rows: `Format` / `PDF` -- `Works on` / `Windows 11 Home and Pro` --
`Needs Checkup?` / `No. The Guide is complete on its own.` -- `Printing` /
`Yes. Print your copy.`

*(Optional, Guide description: "harden your PC" is jargon. "secure your PC" says
it plainly.)*

---

## TWO OBSERVATIONS, NEITHER A DEFECT YET

**The receipt links point at `gatewayguard.gumroad.com/l/guide`, not
`store.gatewayguard.co/l/guide`.** ***measured, every product link in the Guide
receipt.*** The custom domain works on the web, but Gumroad's receipt email uses
its own subdomain. **A buyer's permanent record therefore names a gumroad.com
address rather than ours.** ***Not measured: if this is configurable.*** Worth
one look in the settings before deciding it cannot be changed.

**A stray copy of `Test_Results\` now sits inside `Store_TestFiles\`** --
`Store_TestFiles\Test_Results\`, created 14:23 today, holding old test output
back to July. It looks like an accidental drag. **It is untracked and I have not
touched it.** Say the word and I will remove it.

---

## THE DOWNLOAD -- ALL FOUR QUESTIONS NOW ANSWERED

***Added 2026-09-04. Bill downloaded the purchased file and it is in
`Test_Results\`. Every open question from the test purchase is closed, and all
four answers are good.***

**1. It delivers ONE file, and it is the size that was bought.**
***measured, the download page for order `oRdas6pjue4Bh-DGiv6aoA==`
(`gumroad.com/d/8013fce3f54425a3c19de0d2f44e456f`): `content_items` holds
exactly one entry*** -- `TESTFILE - GatewayGuard Guide - 20 point print
(largest)`, PDF, 69,251 bytes, 3 pages. **Not all five.**

**This was the biggest open risk and it could easily have gone the other way.**
The upload instructions in `GatewayGuard_StoreTestFiles-2026-09-02-1119.md` said
*"upload all five ... they can be dragged in together"* -- written before Option
B, and files dropped without a version selected attach to the **product**, which
would give every buyer all five and breach the licence. **The store was built
correctly anyway.** That instruction is now corrected in place.

**2. The filename survives Gumroad exactly.** ***measured:***

```
TESTFILE - GatewayGuard Guide - 20 point print (largest).pdf
```

Spaces, hyphens and parentheses all intact -- nothing rewritten, nothing
escaped, no hash appended. **This closes the question flagged as unmeasured on
2026-09-02**, and it means the descriptive filenames are safe to use for the
real files.

**3. The file is byte-for-byte the file that was uploaded.**
***measured:*** MD5 `2f31443968084e26e1f85d4e2eca67f4` on the downloaded copy
and on the source in `Store_TestFiles\`. Gumroad does not re-encode, watermark
or alter a PDF.

**4. It opens, and it is genuinely 20 point.** ***measured:*** not encrypted, 3
pages, real selectable text, Garamond and Garamond-Bold, US Letter 612 x 792,
body type resolving to **19.99 pt**.

*(The 16-point PDF sitting in `Test_Results\` is byte-identical to its source
too, so it was copied by hand rather than bought -- it predates the Guide being
published. Nothing to chase.)*

---

## WHAT IS STILL NOT MEASURED

***The download questions are all answered -- see the section above.*** What
remains:

- ***Not measured:*** the terms-acceptance URL field at checkout. There is still
  no licence page on `gatewayguard.co` for it to point at (**T-EULA**).
- ***Not measured:*** the five real Guide PDFs. The versions still carry the
  `TESTFILE - ` stand-ins, so the whole chain is proven with placeholders and
  has to be re-run once the real files exist -- though only the files change,
  not the setup.
- ***Not measured:*** if the receipt's `gumroad.com` links can be pointed at the
  custom domain.
