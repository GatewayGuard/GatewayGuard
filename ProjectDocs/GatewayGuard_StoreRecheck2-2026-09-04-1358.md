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

---

## UPDATE 15:34 -- CHECKUP AND THE GUIDE ARE 100%. THE BUNDLE IS EMPTY.

***measured 15:32 from all three product pages' data payloads.***

### Items 1-6: DONE

| | |
|---|---|
| Checkup fine print | `within 14 days` -- ***measured: `14 ways` now occurs 0 times*** |
| Guide description | **`once downloaded` paragraph deleted** |
| Every version name, description and attribute, both products | **zero stray spaces, zero trailing spaces, zero asterisks, zero line breaks** |
| Prices | Checkup `0/1500/3000/6000`, Guide five zeroes, bundle `2999` |

**Both live products are clean. Nothing outstanding on either.**

### The bundle -- four things, and the first one stops everything

**1. IT IS EMPTY.** ***measured: `bundle_products: []`.*** It is a Gumroad
bundle product with **no products in it**. A buyer who paid $29.99 today would
receive nothing. Add Checkup and the Guide on the Content tab.

**2. It is not published.** ***measured: `is_published: false`.*** Same state
the Guide was in on 2026-09-03 -- the page loads over a direct link and cannot
be bought. Publish after 1, 3 and 4 are settled, not before.

**3. No refund policy is set at all.** ***measured: `refund_policy: none`.***
The 30-day badge is gone, which is right, but nothing replaced it. **This is
still the open decision** -- Option A (14 days) or Option B (no refund), both
written out in section 4h. **My recommendation is A.** Whatever you pick has to
match licence Section 9 word for word.

**4. How does a bundle buyer choose their print size?** ***Not measured -- and
it is the one thing I cannot see from here.*** The Guide has five versions;
this bundle has none. When you add the Guide on the Content tab, Gumroad will
either let the buyer pick at checkout or make you pick one size for everybody.
**If it makes you pick, every bundle buyer gets the same size**, and that breaks
the promise Option B put in the licence. **Tell me what the screen offers and I
will work out the route.**

### The description is right, with one word worth changing

The text pasted cleanly -- clean paragraphs, no stray spaces. Two notes:

- **`If we issue a change for the version of Checkup you bought, it is free.`**
  Mine said **`a fix`**, and the difference matters: the licence deliberately
  separates a **fix** to your version (free) from a **new annual version**
  (a separate purchase). *"A change"* can be read as promising the annual
  update. **Put `fix` back.**
- The opening line `The program and the written guide, together, for one PC.`
  is not there; it now opens on *"Some people want the work done for them."*
  Fine if deliberate.

### The attributes lost the two most important facts

***measured, the two rows now live:***

| | |
|---|---|
| `Works on Windows 11 Home and Pro` | `Plain text you can read.` |
| `Digitally signed - Verifies the creator's identity.` | `Ensures the program has not been altered.` |

**Nothing there says what the buyer receives.** Row 2 is also back to the
label-with-dash shape, and both its cells are about signing, so the row says one
thing twice. Section 4g's three rows cover what you get, the print size, the
platform and the signing -- **and the print-size row is the one a bundle buyer
most needs to see.**

---

## UPDATE 16:32 -- THE ANSWER: NO, A BUNDLE HOLDS ONE VARIANT PER PRODUCT

***measured 16:30, the published bundle's own data:***

```
bundle_products:
  GatewayGuard Windows Security Walkthrough Guide   variant: "12 point - standard print"
  GatewayGuard Checkup                              variant: "One PC"
```

**One `variant` field per included product. Not a list.** Bill asked if all five
could be selected: **they cannot.** Gumroad's bundle asks the SELLER to pick one
version of each included product, and the buyer never sees a choice.

**So today every bundle buyer receives 12 point -- the smallest of the five.**

### THIS MAKES TWO LIVE SENTENCES FALSE, ON A PUBLISHED PRODUCT

***measured, the bundle description as it stands:***

- *"The GatewayGuard Windows Security Walkthrough Guide, as a PDF **in the print
  size you choose**."*
- *"The Guide **in the print size you pick**."*

**Neither is true.** The bundle is published and can take money, so this is the
Tamper Protection shape on the page that takes the money -- the exact failure
the briefing names as open item 0a. **It has to be fixed today, whichever route
is chosen below.**

**And 12 point is the worst of the five to have fixed.** The sizes exist as a
vision accommodation. A large-print reader sent 12 point cannot read what they
bought; a 12-point reader sent 18 point can read it perfectly well. **If one
size must be fixed, it should be a large one.**

### FOUR ROUTES

**1. Give the BUNDLE its own five versions.** ***Not measured -- I cannot see if
Gumroad offers "Add version" on a bundle product.*** ***measured: the bundle has
`options: []`, so none exist today.*** If the control is there, five bundle
versions each pointing at a different Guide variant restores the choice exactly.
**Cleanest if it exists. Look for the Versions section on the bundle's edit
page and tell me.**

**2. Five separate bundle products**, one per size. Certain to work, and ugly:
five listings, five prices to keep in step, and a storefront of near-duplicates.
**Only if route 1 does not exist and route 3 is rejected.**

**3. Fix one size, say so plainly, and keep the free swap.** *(recommended for
today)* Set the bundle's Guide variant to **16 point - large print** and replace
both sentences:

```
The GatewayGuard Windows Security Walkthrough Guide, as a PDF in 16 point large print. It covers the same ground on paper -- what each setting does, why it matters, and how to check and change it yourself. If a different size suits you better, reply to your receipt and we will send it free.
```

```
Checkup v3.1, for one PC. The Guide in 16 point large print, with a free swap to any of the other four sizes. A log of every choice you made, saved on your own computer. If we issue a fix for the version of Checkup you bought, it is free.
```

**The free-swap sentence is not a workaround** -- it is already the promise in
licence Option B and on all five Guide versions. This route just makes the
bundle say it out loud.

**4. Put all five in the bundle.** Contradicts your own Option B answer, so it
reopens a settled decision. **Not recommended, and listed only so the choice is
complete.**

### TWO OTHER THINGS ON THE PUBLISHED BUNDLE

**The refund is still not set.** ***measured: `refund_policy: none`, on a
product that is now published and can take money.*** Checkup states 14 days and
the Guide states no refund; the bundle states nothing. **Option A or B, section
4h. This is the last open decision.**

**`a change` is still there** where it should read `a fix` -- the licence
separates a free fix to your version from a paid new annual version, and
*"a change"* can be read as promising the annual update.

*Confirmed right: published, $29.99 against $32.98 apart -- saves $2.99 exactly
as decided -- and both products are attached with Checkup on `One PC`.*

---

## UPDATE 18:55 -- THE BUNDLE WORKS. BUYER PICKS THE PRINT SIZE, PROVEN BY PURCHASE.

***measured 18:52 from `store.gatewayguard.co/l/digital` and from
`Test_Results\Gmail - You bought GatewayGuard Checkup and Security Walkthrough Guide!.pdf`.***

**The rebuild as a normal digital product did exactly what it was supposed to.**

| | |
|---|---|
| Type / published | **digital**, **published** |
| Price | **$29.99** -- against $32.98 apart, saves $2.99 |
| **Versions** | **5**, all five print sizes, `0` additional amount on each |
| Order | `ygejIi8e4fQA0kNdzGUIOQ==`, 18:35, **$29.99** |
| **Variant on the receipt** | **`12 point - standard print`** |
| Refund | **`14-day money back guarantee`**, full fine print present |

**The buyer chose a print size and the receipt recorded it.** That is the whole
thing the last two days were about, and it is done.

**Three other things came right in the same pass:**

- **The two sentences that were false yesterday are now true.** *"as a PDF in
  the print size you choose"* and *"The Guide in the print size you pick"* -- the
  product can now do what they say. **Nothing to change.**
- **`issue a fix` is back**, so the description no longer reads as promising the
  paid annual version.
- **The attributes carry what the buyer receives**, including a print-size row.

**The bundle refund decision is MADE: Option A, 14 days.** It matches Checkup
and the recommendation. **Licence Section 9 now has to be finalised with Option
A's paragraph** -- that is one of the two DECISION NEEDED markers blocking
licence v3.0, and it can now come out.

---

### THREE SPACING SLIPS, ALL ON NEW TEXT

***measured:***

| Where | What is there |
|---|---|
| Version 1 description | `and we will     send you a different one` -- **five spaces** |
| Attribute 1, right cell | `The Guide - you pick the print size ` -- **trailing space** |
| Attribute 3, left cell | `Digitally signed - Verifies the creator's identity. ` -- **trailing space** |

Version 1's is section **2f**, version 1 description, one clean line. The two
attribute cells only need the trailing space deleted.

*Attribute row 3 also says one thing twice -- both cells are about the
signature. Section 4g's third row pairs `Checkup is plain text you can read`
with `It is digitally signed by us`, which is two facts. Your call.*

### THE URL IS `digital`, WHICH IS A GUMROAD WORD, NOT A PRODUCT NAME

***measured: the live address is `store.gatewayguard.co/l/digital`.***

`bundle` is still held by the **old bundle-type product**, which is unpublished
and now does nothing. **Delete or rename that one, then move this product to
`bundle`.** Do it before any real sale -- a changed URL after real customers
hold the old link is a support problem, and right now the only purchase is a
test.

### THE DOWNLOAD DID NOT FINISH -- STILL UNVERIFIED

***measured: no bundle download reached `Test_Results\`.*** What is in
`Downloads` is **`Unconfirmed 29519.crdownload`, 3,059 bytes, 18:41** -- an
interrupted download, and 3,059 bytes is the size of the Checkup zip.

**So the one thing still unproven is the thing the new structure exists for:**

- **Does the 12-point purchase deliver TWO files** -- the Checkup zip and the
  12-point Guide PDF -- **and only those two?**
- **Not five PDFs, and not a zip inside a zip.**

Open the receipt's **View content** again, let both files finish, and drop them
in `Test_Results\`. I will confirm what a buyer actually receives.

---

## UPDATE 19:10 -- THE DOWNLOAD IS CORRECT. THE WHOLE CHAIN IS PROVEN ON ALL THREE PRODUCTS.

***measured 19:08 from the buyer's own download page for order
`ygejIi8e4fQA0kNdzGUIOQ==` (`gumroad.com/d/4db9e590439ccec291433c2c3f963ece`,
the link taken out of the receipt PDF), and from the two files in
`Test_Results\`.***

### Exactly two files, and exactly the right two

```
FILES OFFERED TO THIS BUYER: 2
   TESTFILE - GatewayGuard Guide - 12 point print (smallest).pdf   65,925 bytes
   TESTFILE - GatewayGuard Checkup v3.1.zip                          3,059 bytes
```

**Not five PDFs. Not a zip inside a zip. The Guide file matches the version
bought.** That is the structure doing its job.

**Both are byte-identical to what was uploaded:**

| File | MD5 downloaded | MD5 source |
|---|---|---|
| Checkup zip | `01734b64d6eb3d8f2b9b6211fa4806bc` | same |
| 12-point PDF | `7730d19e6d0fbfe15493b4287cac05ac` | same |

**The zip opens and holds the four files the licence names** -- the starter
`.bat`, the `.ps1`, the read-me and the licence placeholder. **The PDF is
genuinely 12 point** -- body type resolving to 12.00 pt on US Letter.

*The `(1)` in `TESTFILE - GatewayGuard Checkup v3.1 (1).zip` on disk is Chrome
adding a suffix because that filename already existed in the folder. ***measured:
Gumroad delivers it as `TESTFILE - GatewayGuard Checkup v3.1.zip`.*** Nothing to
fix.*

### THIS ALSO PROVES THE FIX FOR THE 10-PC PACK

**The bundle attaches the SAME Checkup zip to five versions, and a buyer
receives one copy of it.** That is exactly what the four Checkup pack versions
need. ***measured 2026-09-04, and unchanged: the 10-PC pack still delivers
`10PCs.zip`, ten byte-identical copies nested inside a zip.*** **Attach the one
zip to all four pack versions and it will behave the way the bundle just did.**

### BOTH LICENCE MARKERS ARE NOW ANSWERED

The two DECISION NEEDED markers blocking licence v3.0 were **the Guide's print
sizes** and **the bundle refund**.

- **Print sizes: Option B**, answered 2026-09-02 -- *"NO, ONLY ONE HE CHOOSES"*
  -- and now built and proven in the store.
- **Bundle refund: Option A**, ***measured on the live product: `14-day money
  back guarantee` with the full fine print.***

**v3.0 can be finalised.** Section 1, Section 5 and Section 9 take the Option B
and Option A paragraphs already drafted in full. **Say the word and I will
apply them.**

### WHAT IS LEFT ON THE STORE

1. **Three spacing slips** -- five spaces in version 1's description, a trailing
   space on two attribute cells.
2. **The URL is `digital`.** Free `bundle` from the old bundle-type product and
   move this one to it, before any real sale.
3. **The 10-PC pack still ships ten copies of one file.**

---

## UPDATE 19:20 -- THE STORE MEASURES CLEAN. ONE ITEM LEFT.

***measured 19:18 across all three published products -- every version name,
every version description, every attribute cell, every description and every
refund fine print.***

| Product | URL | Price | Versions | Refund | Result |
|---|---|---|---|---|---|
| Checkup | `/l/checkup` | $19.99 | 4 | 14-day money back guarantee | **CLEAN** |
| The Guide | `/l/guide` | $12.99 | 5 | No refunds allowed | **CLEAN** |
| The bundle | `/l/bundle` | $29.99 | 5 | 14-day money back guarantee | **CLEAN** |

**TOTAL PROBLEMS ACROSS THE STORE: 0.**

Checked for: leading and trailing spaces, doubled spaces, stray `**` asterisks,
and every phrase that has been wrong at some point in the last three days --
`gatewayguide`, `whether`, `harden`, `once downloaded`, `14 ways`, `(Not .com)`,
`issue a change`, `ard work`. **None of them appears anywhere.**

### The URL is fixed

***measured: the storefront lists the bundle at `store.gatewayguard.co/l/bundle`,
and that address serves the new five-version digital product.***

`/l/digital` **also still resolves to the same product**. Gumroad keeps the
previous custom URL working as an alias, so the test receipt's link is not
broken. **Nothing to clean up** -- it is one product with two addresses, and the
storefront and every new receipt will use `/l/bundle`.

### ONE ITEM LEFT ON THE WHOLE STORE

**The 10-PC Checkup pack still delivers ten copies of one file.**
***measured 2026-09-04 and unchanged: `10PCs.zip` is a zip holding ten
byte-identical copies of the Checkup zip, named `- Copy` through
`- Copy (10)`.***

**The bundle has now proved the fix.** It attaches the same Checkup zip to five
versions and a buyer receives exactly one copy of it -- ***measured on order
`ygejIi8e4fQA0kNdzGUIOQ==`: two files offered, one of them that single zip.***
**Do the same on the four pack versions: one Checkup zip, attached to each.**

Then buy the 10-PC version once and I will read the download page, the same way
I read the bundle's.

---

## UPDATE 19:30 -- THE 10-PC PACK IS FIXED. EVERY PRODUCT IS NOW PROVEN BY PURCHASE.

***measured 19:28 from the 10-PC buyer's own download page
(`gumroad.com/d/d86a4f7488d63783a8409c5b0271d78a`, token recovered from the
receipt PDF's raw bytes), and from the files in `Test_Results\`.***

```
FILES OFFERED TO THIS 10-PC BUYER: 1
   TESTFILE - GatewayGuard Checkup v3.1.zip   3,059 bytes
```

**One file. Not ten. Not nested.** The last time this version was bought it
delivered `10PCs.zip` holding ten byte-identical copies named `- Copy` through
`- Copy (10)`. **That is gone.**

| | |
|---|---|
| Order | `5Uuzp504LaeHV3rE7w6iZw==` |
| Total | **$79.99** -- the decided 10-PC price |
| Variant on the receipt | **`10 PCs`** -- **no asterisks** |
| Receipt refund text | **once** |
| Receipt thank-you | **present** |
| Zip MD5 | `01734b64d6eb3d8f2b9b6211fa4806bc` -- **identical to the uploaded source** |
| Zip contents | the four files the licence names: the `.bat`, the `.ps1`, the read-me, the licence placeholder |

---

## THE STORE IS DONE -- ALL THREE PRODUCTS PROVEN END TO END

**Every one has been bought, and in each case the download page was read
directly rather than trusted.**

| Product | Price | Versions | Refund | Bought | Files delivered |
|---|---|---|---|---|---|
| Checkup | $19.99 | 4 | 14-day | `5Uuzp504LaeHV3rE7w6iZw==` at $79.99 on the 10-PC version | **1** -- the Checkup zip |
| The Guide | $12.99 | 5 | none | `oRdas6pjue4Bh-DGiv6aoA==`, `NHP951KeZRn-KjboUFw1aw==` | **1** -- the chosen print size only |
| The bundle | $29.99 | 5 | 14-day | `ygejIi8e4fQA0kNdzGUIOQ==` | **2** -- Checkup plus the chosen print size |

**Copy: zero problems across the store**, measured 19:18 -- no stray spaces, no
trailing spaces, no asterisks, and none of the eight phrases that have been
wrong at some point in the last three days.

**Four different print sizes have come back on four different purchases** -- 20,
18, 12 and 12 -- so the version mechanism is reading the buyer's choice, not
repeating a stored value.

---

## THE ONE THING NOT YET CONFIRMED

**The bundle's receipt message.** ***measured on the 18:35 bundle receipt: the
refund paragraph printed twice and no thank-you appeared.*** The replacement is
section **4j** of the paste file. **The next bundle purchase will show whether
it took** -- Checkup's and the Guide's receipts are both already correct, one
refund paragraph and one thank-you each.

## AND THE LICENCE IS UNBLOCKED

Both DECISION NEEDED markers on v3.0 are answered and now built:

- **Print sizes -- Option B.** Answered 2026-09-02, and ***proven in the field:
  a Guide buyer receives one size, the one they chose.***
- **Bundle refund -- Option A.** ***measured live: 14-day money back guarantee
  with the full fine print.***

**Sections 1, 5 and 9 can take the paragraphs already drafted in full.**

---

## UPDATE 19:58 -- EVERYTHING ON THE LIST IS CLOSED. THE STORE IS FINISHED.

***measured 19:56 from the bundle buyer's own download page
(`gumroad.com/d/4989d0ea539a8c01c1add2046bff3a38`) and from the receipt PDF.***

### The receipt no longer says it twice

| | Before, 18:35 | Now, 19:53 |
|---|---|---|
| Refund paragraph | **2x** | **1x** |
| Thank-you message | **absent** | **present**, section 4j verbatim |

The message reads as written: *"Your download link is below and holds two files
- Checkup, and the Guide in the print size you chose... If the print size does
not suit you, reply to this email and we will send you a different one, free."*

### And it delivered the right two files

```
FILES OFFERED TO THIS BUNDLE BUYER: 2
   TESTFILE - GatewayGuard Guide - 14 point print.pdf   68,709 bytes
   TESTFILE - GatewayGuard Checkup v3.1.zip              3,059 bytes
```

Order `bKTU8Nul-_tGaDmjYB3Sjw==`, **$29.99**, variant **`14 point - bigger
print`**.

**This is a stronger test than the first bundle purchase.** That one bought 12
point, which is the first version in the list -- a wrong mapping could still
have looked right. **This one bought the second version and received the 14
point file**, 68,709 bytes, matching the 14-point source exactly. **The
version-to-file mapping is correct, not coincidental.**

---

## FINAL STATE -- ALL THREE PRODUCTS, MEASURED NOT ASSUMED

| Product | URL | Price | Versions | Refund | Files delivered |
|---|---|---|---|---|---|
| Checkup | `/l/checkup` | $19.99 | 4 | 14-day | **1** -- the Checkup zip |
| The Guide | `/l/guide` | $12.99 | 5 | none | **1** -- the chosen print size |
| The bundle | `/l/bundle` | $29.99 | 5 | 14-day | **2** -- Checkup plus the chosen size |

- **Six test purchases**, every download page read directly rather than trusted.
- **Four distinct print sizes returned** -- 20, 18, 12, 14 -- across Guide and
  bundle purchases.
- **Every delivered file byte-identical** to its uploaded source.
- **Copy: zero problems** -- no stray or trailing spaces, no asterisks, and none
  of the eight phrases that were wrong at some point in the last three days.
- **Every receipt correct** -- one refund paragraph, one thank-you, the variant
  named, no charge taken.

**Nothing on the store list remains open.**

## WHAT IS NEXT

**Licence v3.0.** Both DECISION NEEDED markers are answered *and now proven in
the field*:

- **Print sizes, Option B** -- a buyer receives the one size they chose,
  demonstrated on four different sizes.
- **Bundle refund, Option A** -- 14 days, live and printing on receipts.

**Sections 1, 5 and 9 take paragraphs already drafted in full.** Then the
`.docx` is rebuilt from the Markdown, which v3.0 made the source.

**Still ahead of the real launch**, unchanged by today: the five real Guide PDFs
and the signed Checkup build replace the `TESTFILE - ` stand-ins, and the
licence needs a public web page for the checkout terms field (**T-EULA**).
***measured 2026-09-02 and not re-checked: there is no licence page on
gatewayguard.co.***
