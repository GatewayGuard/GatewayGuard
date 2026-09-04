<!-- Dated: 2026-09-04 13:58 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Second re-check -- seven fixed, and the 10-PC pack is shipping ten copies of one file

- **Document Name:** GatewayGuard_StoreRecheck2
- **Last Modified:** 2026-09-04 13:58 ET
- **Last Editor:** Claude Code (CGDELL)
- **For:** Bill
- **Covers:** CPM tasks **T-TP**, **T-PACK**
- **Follows:** `GatewayGuard_StoreCopyRecheck-2026-09-04-0756.md`

***All measurements taken 2026-09-04 13:56, from each product page's own data
payload, from `Test_Results\10PCs.zip`, and from the receipt PDF in
`Test_Results\`.***

---

## FIXED -- SEVEN

| | |
|---|---|
| Checkup's refund fine print | **filled** -- it was empty |
| Checkup's "whether" | **gone** -- reads *"You choose if it is applied."* |
| Checkup advertising packs that did not exist | **gone from the description, and the packs now exist** |
| The four pack versions | **built**, amounts `0 / 1500 / 3000 / 6000` cents = **$19.99 / $34.99 / $49.99 / $79.99** exactly as decided |
| `gatewayguide.co` | **gone from both Guide fields** |
| The Guide's details rows | **rebuilt in the two-details-per-row shape** |
| The Guide's receipt | ***measured: zero occurrences of `gatewayguide` or `(Not .com)`*** |

**The newest Guide purchase** -- order `NHP951KeZRn-KjboUFw1aw==`, 13:49,
$12.99, variant **`12 point - standard print`**. Third different print size
across three purchases (20, 18, 12). The version mechanism is sound.

---

## THE ONE THAT MATTERS -- THE 10-PC PACK SHIPS TEN COPIES OF THE SAME FILE

***measured, `Test_Results\10PCs.zip`, 30,316 bytes:*** it is a zip containing
**ten more zips**, every one **3,059 bytes and byte-identical** to the single
Checkup zip:

```
TESTFILE - GatewayGuard Checkup v3.1 - Copy.zip
TESTFILE - GatewayGuard Checkup v3.1 - Copy (2).zip
...
TESTFILE - GatewayGuard Checkup v3.1 - Copy (10).zip
```

**A pack sells more licences, not more files.** The licence says so in its own
words -- *"A 3-PC, 5-PC, or 10-PC pack covers that many computers"* -- and your
own answer to the multi-PC decision says *"it will only run on that one
computer."* **Nothing about buying ten licences requires ten files.**

**Four reasons this has to change before anyone real buys a pack:**

1. **The buyer cannot tell which one to use.** Ten identical files, named `Copy
   (2)` through `Copy (10)`. **That is a dead end**, and it is the exact failure
   the house rule forbids: never leave a reader with a choice they have no way
   to make.
2. **Those names are Windows' duplicate-file names.** `- Copy (7)` reads as a
   mistake to anybody, because that is what it normally is.
3. **It is a zip inside a zip.** The buyer extracts twice, and Windows will not
   run anything from inside the inner one until they do. **Two extra steps for
   the least technical customer we have.**
4. **It quietly contradicts the licence.** A buyer given ten files reasonably
   concludes each is for one PC and they are somehow different. They are not.

**The fix: attach the SAME single Checkup zip to all four versions.** Gumroad
allows one file on many versions. The versions differ by price and by the
licence they grant, and by nothing else.

*If you want the buyer to hold something confirming what they bought, add one
small text file naming the pack size -- but the program is one file.*

---

## THREE NEW COPY DEFECTS, ALL FROM PASTING

### 1. The pack names contain literal asterisks

***measured, live:***

```
**One PC**
**3 PCs**
**5 PCs**
**10 PCs**
```

**Those asterisks are in the version names**, so the dropdown shows them to
buyers. They are Markdown bold markers from a heading in my paste file.

**This one is my fault and the file is fixed.** The headings there now read
*"Pack 1 -- paste into the NAME box"*, so no heading is ever the same text as
the value. Re-paste the four names from the corrected section 3.

### 2. Checkup's fine print now warns about the wrong thing

***measured, live:*** *"Email **support@gatewayguard.co (Not .com)** from the
address you bought with..."*

**The "(Not .com)" has been attached to the email address.** It was written for
a web address, and on an email address it reads as though the address itself has
a suffix. **My text has no "(Not .com)" anywhere** -- see section 1a. Re-paste
the field.

### 3. Small spacing left over in Checkup

- The fine print has **four line breaks** between the two paragraphs, not one
  blank line.
- The **3 PCs** description ends with a **trailing line break**.

Both go away on a clean re-paste. **Clear the box first** -- Ctrl+A, Delete --
then paste.

---

## STILL OUTSTANDING FROM THE LAST LIST

### The five Guide versions were never re-pasted

***measured, live, unchanged from this morning:***

| Version | What is there |
|---|---|
| 1 **name** | `12  point - standard print ` -- double space, trailing space |
| 3 desc | leading space, `or  reach` |
| 4 desc | `a      different one` |
| 5 desc | `size?  Write` |

*The receipt prints `12 point - standard print` with single spaces, but that is
PDF text extraction collapsing whitespace, not evidence of a fix. The live data
is what counts, and it still has the double space.*

Corrected text is in section **2f**, now with a NAME box and a DESCRIPTION box
labelled separately for each of the five.

### The Guide's refund still carries a condition v3.0 does not

***measured:*** *"all standalone guide sales are final **once downloaded**."*
Only the domain was changed; the rest of the field is the old text. Licence v3.0
sells the Guide without a refund, with no condition attached. **Full replacement
in section 2b.**

### The bundle is still not live

***measured 13:56: `store.gatewayguard.co/l/bundle` returns HTTP 404.*** Its
refund is still the open decision.

---

## ONE THING I COULD NOT CHECK

**No Checkup receipt was saved for the 10-PC purchase.** The newest Checkup
receipt in `Test_Results\` is from **07:52**, before this morning's edits. So
two things are unconfirmed:

- **Does the receipt name the pack version?** The Guide's receipt carries a
  `Variant` line; Checkup's should now carry one too, and it should say
  `10 PCs` -- or `**10 PCs**`, asterisks and all, which is the point.
- **Does the `(Not .com)` defect appear in a buyer's receipt?** It is in the
  refund fine print, and the Guide's fine print does print in the receipt.

**Save that receipt and I will read both.**
