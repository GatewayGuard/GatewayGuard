<!-- Dated: 2026-09-02 11:19 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Test files for both products -- what they are, and how to put them on Gumroad

- **Document Name:** GatewayGuard_StoreTestFiles
- **Last Modified:** 2026-09-02 12:33 ET
- **Last Editor:** Claude Code (CGDELL)
- **For:** Bill, before the first test purchase
- **Covers:** CPM tasks **T-UPG**, **T-UPC**, **T-TP**
- **Companion to:** `GatewayGuard_GumroadTestPurchase-2026-09-02-1040.md`

---

## WHY THESE EXIST

**A test purchase cannot prove a download that has nothing to download.** Bill,
2026-09-02: *"we don't have product files setup yet that would be downloaded at
gumroad."*

These stand in for the real files so the whole chain can be tested now --
checkout, receipt, download link, extraction, and the file opening -- **without
waiting for the signed build or the finished Guide.**

**They are not the products and cannot be mistaken for them.** Every filename
begins `TESTFILE-`, and every file says what it is on its first line.

---

## WHAT WAS BUILT

**All six sit in `Store_TestFiles\` at the top of the project.** That folder is
deliberately **outside** the Claude Cloud connector scope.

### The Guide -- five PDFs

| File | Size | Pages |
|---|---|---|
| `TESTFILE - GatewayGuard Guide - 12 point print (smallest).pdf` | 65,925 bytes | 1 |
| `TESTFILE - GatewayGuard Guide - 14 point print.pdf` | 68,709 bytes | 2 |
| `TESTFILE - GatewayGuard Guide - 16 point print.pdf` | 68,330 bytes | 2 |
| `TESTFILE - GatewayGuard Guide - 18 point print.pdf` | 66,837 bytes | 2 |
| `TESTFILE - GatewayGuard Guide - 20 point print (largest).pdf` | 69,251 bytes | 3 |

***Renamed 2026-09-02*** from `TESTFILE-GatewayGuard-Guide-12pt.pdf` and so on
-- see the font section below for why.

**Five sizes, because that is what the real Guide is.** ***sourced,
`MarketingSourcePack-2026-08-13-1427.md`:*** *"includes five print sizes (12,
14, 16, 18, and 20 pt)"*, and the licence: *"supplied as PDF files with
identical wording in five print sizes."*

***measured on each file:*** valid PDF, **US Letter 8.5 x 11 inches**, real
selectable text rather than a picture of text, Garamond, 0.9-inch margins.
**The page count rising with the print size is not a defect** -- it is the same
words in bigger type, which is exactly what the real Guide will do, and it is
worth seeing before the real export.

**Five files also tests something one file would not:** that Gumroad lists them
all, that the buyer can tell them apart, and that the "Download all" button
appears.

### Checkup -- one zip

`TESTFILE - GatewayGuard Checkup v3.1.zip` -- **3,059 bytes**, containing:

| Inside the zip | What it stands in for |
|---|---|
| `TEST-Run-GatewayGuard.bat` | the starter file |
| `TEST-W11-SecurityHardening-v3.1.ps1` | the script |
| `READ-ME-FIRST.txt` | the start-here sheet |
| `LICENCE-PLACEHOLDER.txt` | the licence |

**That list comes from the licence, not from me.** ***sourced:*** *"Your
Checkup license covers the script, the starter file that launches it, and any
correction we issue for that same version."*

***measured:*** zip integrity OK; the `.ps1` parses with **0 errors**; the
`.bat` is **CRLF** (38 CR, 38 LF) and **does not self-elevate** -- the
Malwarebytes exploit-payload rule holds even in a throwaway test file.

**The script reads nothing and writes nothing.** It prints a message naming the
six steps that had to work for you to be reading it, shows the Windows and
PowerShell versions, and waits for Enter.

**SHA-256 of the zip:**
`0a0319bc364a787e910554476cf6a2d0130073f5b626b352cafb3cca32d03397`

---

## HOW TO PUT THEM ON GUMROAD

***sourced, Gumroad Help Center:*** *"To upload files to your product's Content
tab, click **Next: Customize**, then click **Content** to upload your file(s).
You can upload files from your hard drive or from Dropbox."*

**Do this twice -- once per product. They are separate uploads.**

### The Guide

1. Sign in at **gumroad.com** and open **Products**
2. Click **GatewayGuard Windows Security Walkthrough Guide**
3. Click **Next: Customize**, then the **Content** tab
4. Upload **all five** `TESTFILE - GatewayGuard Guide - *.pdf` files from
   `Store_TestFiles\`. They can be dragged in together
5. Check they are listed **12, 14, 16, 18, 20** in that order. If Gumroad sorts
   them some other way, drag them into order -- **a reader looking for large
   print should not have to hunt**
6. **Save**

### Checkup

1. Open **GatewayGuard Checkup**
2. Click **Next: Customize**, then **Content**
3. Upload the single file `TESTFILE - GatewayGuard Checkup v3.1.zip`
4. **Save**

**If the labels on your screen do not match the above, stop and tell me what
they say.** Gumroad changes this interface, and I would rather correct these
steps than have you guess at them.

### Limits, so you know there is no problem here

***sourced, Gumroad Help Center:***

- Priced above $0.99: **the largest single file is 16 GB**
- **"You can add as many files as you want to each product"**
- The **"Download all"** button appears only if the product's total content is
  **under 500 MB**

**Our largest file is 69 KB.** Nothing here comes close to any limit, and the
real files will not either -- the Guide is five PDFs and Checkup is a small
script.

---

## THE FILENAMES CANNOT CARRY THE GUIDE'S FONT -- BUT THEY CAN CARRY ITS WORDS

**Bill asked, 2026-09-02: *"can the store test files filenames display in the
font of the security guide?"***

### The font: no, and Gumroad says so directly

***sourced, Gumroad Help Center:*** you *"can choose from different font styles,
accents, and background colors from your profile settings"*, and those
*"will apply to your profile, product, posts, and emails; **but not to your
product's content**."*

**The file list a buyer downloads from is product content.** So it renders in
Gumroad's own typeface and there is no setting that changes it. ***Also not
measured: whether Garamond is even among the fonts Gumroad offers*** -- their
list is a short set of web fonts, and a book face like Garamond is unlikely to
be on it.

**What the font setting DOES reach is worth knowing:** the profile, the product
page, the posts and the emails. **So the page the buyer reads before buying,
and the receipt they get afterwards, can carry a chosen face** even though the
download list cannot.

### What you fully control is the filename itself -- and that matters more

**A filename is the only text on that page you write.** The buyer sees it in the
download list, in the receipt, and again in their Downloads folder six months
later when they have forgotten what they bought.

***`TESTFILE-GatewayGuard-Guide-12pt.pdf` is not written for a
seventy-eight-year-old.*** It is written for a developer: no spaces, an
abbreviation, and no clue which of the five to open.

**Renamed 2026-09-02, and the real files should follow the same shape:**

| Real product filename |
|---|
| `GatewayGuard Guide - 12 point print (smallest).pdf` |
| `GatewayGuard Guide - 14 point print.pdf` |
| `GatewayGuard Guide - 16 point print.pdf` |
| `GatewayGuard Guide - 18 point print.pdf` |
| `GatewayGuard Guide - 20 point print (largest).pdf` |

**Why each part is there:** real spaces because this is prose a person reads;
*"point print"* rather than `pt` because the abbreviation is jargon; and
**(smallest) / (largest) at the two ends** because a reader who needs large
print should not have to work out that 20 beats 12. **They still sort in order**,
since the numbers are two digits throughout.

**The test files now carry the same shape**, so the test purchase actually tests
what the buyer will see rather than something that will be replaced.

### And there is a place to put the Guide's own words

***sourced:*** the Content tab takes **rich text blocks** -- *"you can provide
additional context before a section or type a page with Rich text blocks, and
the formatting bar allows you to add lists, code blocks, quotes, links, buttons,
and more."*

**So a short block can sit above the five files**, in the Guide's voice, saying
which one to pick. Something like: *"Five copies of the same guide, in five
sizes. If you wear reading glasses, start with 18 or 20 point."*

**That is the answer to what Bill was reaching for.** The font cannot follow the
Guide onto that page. **The Guide's plain-English voice can.**

---

## DO NOT USE GUMROAD "VERSIONS" FOR THE FIVE PRINT SIZES

> **SUPERSEDED 2026-09-02 18:41 by Bill's licence answer. DO NOT FOLLOW
> THIS SECTION.** It was measured against licence **v2.4** -- *"your Guide
> license covers all five print sizes"* -- and that is what made Versions
> the wrong feature. Bill then answered the open decision **Option B**,
> *"NO, ONLY ONE HE CHOOSES"*, and Option B says in terms that the Gumroad
> product **must** be built as five versions. **Versions is now correct.**
> Names, descriptions and filenames:
> `GatewayGuard_GuideVersions-Gumroad-2026-09-02-1841.md`.
>
> **Kept in place rather than deleted**, because the reasoning is sound and
> the only thing that changed is the contract it was measured against.

**Added 2026-09-02, after Bill put Gemini's description of the Versions feature
to me. Gemini describes the feature accurately. Applying it here would
contradict the licence.**

### The feature is real, and Gemini has it mostly right

***sourced, Gumroad Help Center:*** *"You can add multiple versions by clicking
the 'Add version' button. Give your version a name, description, an additional
amount over the base product price, and a quantity if you wish to limit the
sales of the version."* Content is attached per version -- *"switch to the
'Content' tab and select the version you'd like to add content for."*

| Gemini's claim | Verdict |
|---|---|
| Gumroad has a native Versions feature | **Correct** |
| Separate files can be attached to each version | **Correct**, sourced above |
| Pricing can differ per version | **Correct**, though the mechanism is *"an additional amount over the base product price"*, not a free-standing price |
| The buyer picks from a dropdown and receives only that version | **Correct -- and that is precisely the problem** |
| *"you can enable versions and add **up to 5** distinct options"* | ***Not documented.*** Gumroad's own article describes "Add version" with **no stated maximum**. **The number 5 is the number in the question that was asked** -- so it most likely came from the prompt rather than from Gumroad. Treat it as unverified |

Gemini also guessed at the product -- *"your different Windows security
hardening guides or target tiers"*. There is one Guide, in five print sizes.

### Why it is the wrong feature here, and it is not a preference

***sourced, the current licence, Section 1:***

> *"Your Guide license covers **all five print sizes** -- they are one product,
> not five, and the one printed copy Section 5 allows is one copy of the size
> you choose."*

**Versions would deliver one. The licence promises five.** That is a
contractual mismatch, not a layout choice, and it would be discovered by
whichever buyer read the agreement.

**The question was already asked and settled.**
`LicenceVsEulaNorms-2026-08-25-1045.md` raised it directly -- *"Does a buyer
get one of the five, or all five?"* -- and answered it *"measured, the pricing
page: they receive all five."* The licence was then written to say so.

**And it is the wrong shape for this buyer anyway.** The five sizes are a
**vision accommodation**. A senior choosing from a dropdown is choosing before
they have seen any of them -- and a reader who picks 14 pt, finds it too small,
and has to return to the store has been failed by the product. **Give them all
five and let them open the one that suits.** That is what "not a dead end"
means here.

**Five files on one product, as written above. No versions.**

### WHERE VERSIONS *IS* THE RIGHT ANSWER -- AND IT HAS NO TASK

**The multi-PC packs.** Checkup for 1, 3, 5 and 10 PCs: genuinely different
scope, genuinely different price, and the licence already carries terms for
them -- *"A 3-PC, 5-PC, or 10-PC pack covers that..."*, Section 2, plus an open
attorney question on whether a pack refund is all-or-nothing.

**That is exactly what Versions is for**, and Gemini's description would apply
cleanly to it.

***measured against CPM Rev 8, 2026-09-02: the multi-PC packs have no task at
all.*** They appear in three attorney documents and in the Checkup listing copy
that is already written -- *"Using more than one PC? There are packs for 3, 5
and 10 at gatewayguard.co"* -- **so the store copy advertises products that do
not exist.**

**Not urgent: Checkup ships after 15-Sep, so this is off the Guide's path.**
But the sentence promising the packs must not go live before the packs do.
Added to the schedule as **T-PACK**.

---

## THEN RUN THE TEST PURCHASE

Full procedure: `GatewayGuard_GumroadTestPurchase-2026-09-02-1040.md`.
**Never with your own credit card** -- stay logged in and Gumroad substitutes
a test card.

**Buy both products.** Then work through this list and write down what happened,
because this is the only pass where finding a problem is free:

| # | What to check | Why it matters |
|---|---|---|
| 1 | Did the receipt email arrive, and at which address? | The buyer's only proof of purchase |
| 2 | Does the receipt name the product correctly? | Both names now match the licence -- confirm Gumroad agrees |
| 3 | Did the download link work from the email, not just from the browser you bought in? | A buyer opens the link on a different day, on a different device |
| 4 | Are all five Guide PDFs there, in order? | The large-print reader is the one who needs this |
| 5 | Did a PDF open, and is the text sharp? | Proves the export route works before the real export |
| 6 | Did the browser warn you while downloading the zip? | **The zip is the risky one** |
| 7 | Did SmartScreen or Defender or Malwarebytes object? | See below |
| 8 | Did the zip extract, and did the `.bat` run? | The buyer's very first minute with the product |
| 9 | Does the test sale appear in the **sales CSV export**? | ***sourced:*** test sales are held out of the Audience dashboard, so the licence-acceptance check may need another route |

### Number 6 and 7 are the ones I would watch

**A zip holding a `.bat` and a `.ps1` is the shape antivirus software looks at
hardest**, and the delivery chain has four places it can be stopped: Gumroad,
the browser download, SmartScreen, and the antivirus. **None of them has ever
been tested with this product.**

**A warning here does not predict the real product**, because the real Checkup
is signed and this test file is not. What it does tell you is **where in the
chain the friction sits** -- and that is worth knowing while there is still
time to change the packaging.

---

## THE PART THAT MATTERS MOST -- TAKE THEM OFF AGAIN

**A test file left attached at launch would be sold to a real customer.**

**Remove every one of these before either product goes live**, and replace them
in the same sitting with the real files:

- **The Guide** -- the five real PDFs from the export (CPM task **T-GX**)
- **Checkup** -- the real package built from the signed build (**T-PKG**)

**The safeguard is in the filenames.** Every file begins `TESTFILE-`. If you
ever look at a live product's Content tab and see that word, something has gone
wrong -- and it is visible at a glance rather than needing to be checked.

**Add this to the launch-day checklist**, above "publish": *open both Content
tabs and confirm no filename contains TESTFILE.*

---

## WHAT THESE FILES DO NOT PROVE

- **That a real card is charged, or that money reaches the bank.** ***sourced,
  Gumroad:*** *"just ask"* their support to confirm the payout works. One
  email, and it carries no suspension risk.
- **Anything about the real Checkup's antivirus behaviour**, because this test
  file is unsigned and the real one is signed.
- **Anything about the real Guide's content or layout.** These are one to three
  pages of placeholder text.

**They prove the plumbing. That is all they are for, and the plumbing has never
been tested once.**
