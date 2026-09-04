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

---

## UPDATE 14:17 -- THE GUIDE IS ALMOST CLEAN, CHECKUP IS UNTOUCHED, AND BOTH PREDICTIONS LANDED

***measured 14:15 from both product pages, and from
`Test_Results\Gmail - You bought GatewayGuard Checkup!.pdf`.***

### The pack purchase works, and it proved both open questions

Order `ymY-t7oR6YmC9vttlPHtsA==`, 13:20, **$79.99** -- the 10-PC price is exactly
right, and the receipt carries a `Variant` line as the Guide's does.

**Both things I could not check yesterday are now confirmed, and both are bad:**

1. ***measured, the receipt prints the variant as:*** `**10 PCs**` -- **the
   asterisks reach the buyer.** They are in the receipt email, which cannot be
   edited after sending.
2. ***measured, the receipt prints:*** *"Email **support@gatewayguard.co (Not
   .com)** from the address you bought with"* -- **the warning reaches the buyer
   attached to the email address.**

### The Guide -- three of four fixed

| Version | Before | Now |
|---|---|---|
| 1 name | `12  point - standard print ` | `12 point - standard print ` -- **double space gone, trailing space remains** |
| 2 | OK | **OK** |
| 3 desc | leading space, `or  reach` | **OK** |
| 4 desc | `a      different one` | **OK** |
| 5 desc | `size?  Write` | **still there, and worse** |

**Version 5 picked up a new fault while being edited by hand.**
***measured, live:***

> *"...if a large-print book is still **ard** work. Not the right size?&nbsp;&nbsp;Write to*
> *support@gatewayguard.co..."*

**The `h` is missing from "hard".** There is also still the double space after
`size?`, and a line break before `support@`. **This is the third version of that
one sentence.** Clear the box and paste section 2f's version 5 description
whole -- do not repair it in place.

### Checkup -- nothing was re-pasted

***measured, all unchanged:*** the four names still carry `**` asterisks, the
fine print still says `(Not .com)`, the `3 PCs` description still ends with a
line break.

*The four line breaks inside the fine print turn out not to matter -- the
receipt prints the whole thing as one paragraph. Dropped from the list.*

### What is left, in order

1. **Checkup: re-paste the four version names** from section 3. They reach
   buyers with asterisks.
2. **Checkup: re-paste the refund fine print** from section 1a. Remove
   `(Not .com)`.
3. **Checkup: re-paste the `3 PCs` description** from section 3.
4. **Guide: re-paste version 5's description** from section 2f, and clear the
   trailing space from version 1's name.
5. **The 10-PC pack still delivers ten copies of one file.** Unchanged. Attach
   the single Checkup zip to all four versions.
6. **The Guide's refund still says "final once downloaded."** Section 2b.
7. **The bundle is still 404.**

---

## UPDATE 15:10 -- ITEMS 1-5 ARE CLEAN. TWO THINGS LEFT.

***measured 15:08 from both product pages' data payloads.***

### Everything re-pasted is correct

| | |
|---|---|
| Checkup version names | `One PC` `3 PCs` `5 PCs` `10 PCs` -- **asterisks gone** |
| Checkup `(Not .com)` | **gone** |
| Checkup `3 PCs` trailing break | **gone** |
| Guide version 1 name | `12 point - standard print` -- **trailing space gone** |
| Guide version 5 | **`hard work` restored**, double space and line break gone |
| Guide versions 2, 3, 4 | clean |
| Guide `harden` | **changed to `secure`** -- not asked for, and right |
| All amounts | `0 / 1500 / 3000 / 6000` and five zeroes on the Guide |

**Zero stray spaces, zero trailing spaces, zero asterisks across every name,
description and attribute on both products.**

### WHY YOU COULD NOT FIND #6 -- you already fixed it, in the field I named

***measured, the Guide's refund fine print, now exactly section 2b:***

> *"All sales final. Every setting the Guide covers is published free at
> gatewayguard.co, so you can read the whole scope before you buy..."*

**That field is right.** The `once downloaded` sentence I am still seeing is
somewhere else -- **it is the last paragraph of the product DESCRIPTION**:

> *"All Sales Final: Due to the instant delivery nature of digital files
> (PDF/reference guides), all standalone guide sales are final once downloaded.
> Free online documentation is available at gatewayguard.co to preview all 19
> covered security settings before purchase."*

**Delete that paragraph from the description.** It is the old refund text
duplicated, and Gumroad prints the refund policy by itself -- so the buyer reads
the same terms twice, in two different wordings, one of which carries a
condition licence v3.0 does not have. **This is the same duplication that was in
the Guide's receipt thank-you, now living in the description.**

### ONE NEW ONE, AND IT IS IN THE REFUND TERMS

***measured, Checkup's fine print:*** *"write to us within **14 ways** of
buying"*

**`ways` should be `days`.** ***measured: `14 days` occurs 0 times, `14 ways`
occurs 1 time.*** It is one letter, in the sentence that states the refund
window, so it is worth a clean re-paste of the whole field from section 1a
rather than a one-character edit.

### Then item 7

Items 1-5 are done, 6 is the description paragraph above, and the `14 ways`
typo joins them. **The 10-PC pack content is still unverified** -- the last
download was ten copies of one file, and only a fresh pack purchase shows if
that changed.
