<!-- Dated: 2026-09-04 07:56 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Store copy re-checked after Bill's edits -- three fixed, five still live

- **Document Name:** GatewayGuard_StoreCopyRecheck
- **Last Modified:** 2026-09-04 07:56 ET
- **Last Editor:** Claude Code (CGDELL)
- **For:** Bill
- **Covers:** CPM task **T-TP**
- **Follows:** `GatewayGuard_StoreTestPurchases-2026-09-03-1529.md`

***All measurements taken 2026-09-04 07:53 from each product page's own data
payload, and from the two receipt PDFs in `Test_Results\`.***

---

## THE SCORECARD

| # | Item | Status |
|---|---|---|
| 1 | `gatewayguide.co` in the Guide | **STILL WRONG -- and now in two places** |
| 2 | "whether" in Checkup's description | **STILL THERE** |
| 3 | Checkup had no refund policy | **FIXED** -- 14-day, and it shows on the receipt |
| 4 | The Guide's receipt had no thank-you | **FIXED** |
| 5 | "whether" in the Guide's description | **FIXED** |
| 6 | Checkup's refund fine print | **NEW -- it is empty** |
| 7 | The Guide's details table | **STILL MIS-PAIRED, plus a new typo** |
| 8 | Version name and description spacing | **STILL THERE, all four** |
| 9 | Guide receipt repeats the refund text twice | **NEW** |

---

## WHAT THE PURCHASES PROVED

**Four test purchases, two per product.** Checkup at 07:28 and 07:39, the Guide
at 07:13 and 07:49. All four were test sales -- *"you have not been charged"* --
and every one names `Reply-To: support@gatewayguard.co` correctly.

| | Checkup | The Guide |
|---|---|---|
| Orders | `NkjRD9n3xt77vPaLkxBu5Q==`, `QLvoGF39fJ9lieaQ07gUEA==` | `EexnXAOKiHZLhJTRh1ToVg==`, `Hh2VMr_pByUv328FIk70pw==` |
| Total | $19.99 | $12.99 |
| Refund shown | **14-day money back guarantee** | No refunds allowed |
| Thank-you message | yes | **yes -- new** |
| Variant | n/a | **`18 point - extra large print`** |

**The variant line is worth noting.** Yesterday's order returned **20 point**;
today's returned **18 point**. Different purchase, different version, correctly
named on the receipt. **The version mechanism is genuinely reading the buyer's
choice**, not repeating a stored value -- which one purchase could not have
shown.

---

## THE FIVE STILL LIVE

### 1. `gatewayguide.co` -- third day, and it has spread

***measured:*** it is now in **two** fields on the Guide, not one:

- the **product description**: *"Free online documentation is available at
  **gatewayguide.co** (Not .com)"*
- the **refund fine print**: the same sentence again, *"(not .com)"*

**Both reached this morning's receipt**, so it is in the buyer's permanent record
twice in one email. **It is `gatewayguard.co`.** The sentence written to prevent
a `.com` mistake is sending people to a domain we do not own, and it is the one
item on this list that costs a real customer something.

### 2. Checkup still says "whether"

***measured, live:*** *"You choose **whether** to apply it."*

Replace with:

```
You choose if it is applied.
```

The Guide's was fixed. This one was in the same note and was missed.

### 3. Checkup's refund fine print is empty -- NEW

***measured:*** `refund_policy.title` = *"14-day money back guarantee"*.
`refund_policy.fine_print` = **blank**.

So the receipt shows the headline with **no terms under it**, while the Guide's
receipt carries a full paragraph. The buyer is told there is a 14-day guarantee
and not told how to use it.

**The wording already exists** -- `GatewayGuard_GumroadListings-2026-08-25-0015.md`,
Checkup's refund section. Paste it into the fine print box:

```
If Checkup is not what you expected, write to us within 14 days of
buying and we will refund you in full. You do not have to give a
reason.

You do not need to prove anything, send us a log file, or let us
try to fix the problem first. Email support@gatewayguard.co from
the address you bought with and give us your order number. We aim
to answer within two business days.
```

### 4. The Guide's receipt says the same thing twice -- NEW

The thank-you block now reads:

> *"Thank you for choosing GatewayGuard Windows Security Walkthrough Guide. If
> you need help or have questions, just reply to the receipt email -- we're
> here.* **All Sales Final: Due to the instant delivery nature of digital
> files...**"

and then the refund block below it repeats **the identical paragraph**.

**The refund text has been pasted into the thank-you field as well as the refund
field.** Take it out of the thank-you -- Gumroad prints the refund policy on its
own. Compare Checkup's, which says something useful instead:

```
Thank you for choosing GatewayGuard Checkup. Your download link is
below. Nothing is changed on your PC unless you say yes, and you
can read every line of the script yourself. If you need help or
have questions, just reply to the receipt email -- we're here.
```

The Guide's equivalent should say what the buyer got, not restate the refund:

```
Thank you for choosing the GatewayGuard Windows Security
Walkthrough Guide. Your download link is below -- it is the print
size you chose, and the words are the same in all five. If the size
does not suit you, reply to this email and we will send you a
different one, free.
```

### 5. The Guide's details table is still mis-paired, and now has a typo

***measured, the three rows as they stand:***

| Label column | Value column |
|---|---|
| `Format - PDF, five print sizes` | `Buyer gets to choose Only One` |
| `Works on Windows 11 Home & Pro` | `Print it Yes -- printing is alllowed` |
| `Needs Checkup? - No` | `The Guide is complete on its own` |

Three things wrong:

- **`alllowed`** -- three l's.
- **Row 1 contradicts itself.** It says *five print sizes* and *choose only one*
  in the same row. Under Option B the buyer receives one. Say that once.
- **The pairing is still inside out.** Rows 1 and 3 put the label and its answer
  both in the label column; row 2 puts two unrelated facts in one row. Gumroad
  renders these as label / value, the way Checkup's four do.

Replace with four clean rows:

| Label | Value |
|---|---|
| `Format` | `PDF` |
| `Print size` | `You choose one of five. The words are identical.` |
| `Works on` | `Windows 11 Home and Pro` |
| `Needs Checkup?` | `No. The Guide is complete on its own.` |

### 6. Version spacing -- unchanged, all four

| Where | What is there |
|---|---|
| Version 1 **name** | `12  point - standard print ` -- double space, trailing space |
| Version 3 desc | leading space, `or  reach`, `to  support@` |
| Version 4 desc | `a      different one` |
| Version 5 desc | `size?  Write` |

Clean text: `GatewayGuard_GuideVersions-Gumroad-2026-09-02-1841.md`.

*(Optional, Guide description: "harden your PC" is still jargon. "secure your
PC".)*

---

## ONE THING THAT IS NOT A COPY DEFECT

**Checkup's description advertises the packs, and the packs do not exist.**
***measured:*** *"Using more than one PC? Packs for 3, 5, and 10 are available at
gatewayguard.co."* ***measured: Checkup has zero versions.*** A published product
taking $19.99 is pointing buyers at three products that cannot be bought.

**Two ways out, and the copy for both is already written:** build the versions
(`GatewayGuard_GumroadBundleAndPacks-2026-09-04-0651.md`, Part 2 -- four names,
four descriptions, four amounts), or cut the sentence until they exist.

---

## THE BUNDLE IS NOT LIVE

***measured 07:53: `store.gatewayguard.co/l/bundle` and `/l/pGuideBundle` both
return HTTP 404.*** Expected -- the copy went to you an hour ago. The bundle's
own open question, and it has to be settled before it publishes: **the refund**,
still showing 30 days, which is in neither drafted option.
