<!-- Dated: 2026-09-02 18:41 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# The Guide's five print sizes as Gumroad versions -- names, descriptions and filenames

- **Document Name:** GatewayGuard_GuideVersions-Gumroad
- **Last Modified:** 2026-09-02 18:41 ET
- **Last Editor:** Claude Code (CGDELL)
- **For:** Bill, to type straight into Gumroad
- **Covers:** CPM tasks **T-UPG**, **T-PKG**
- **Supersedes:** the section *DO NOT USE GUMROAD "VERSIONS" FOR THE FIVE PRINT
  SIZES* in `GatewayGuard_StoreTestFiles-2026-09-02-1119.md`. See WHY THIS
  REVERSED below.


> **DO NOT COPY FROM THIS FILE. 2026-09-04.** Every block of copy here is
> hard-wrapped at about 66 characters, and **those wraps are real line
> breaks** -- pasted into a Gumroad box they arrive as stray and doubled
> spaces. Bill traced every spacing defect on the store to exactly this.
> **Paste only from `GatewayGuard_GumroadPasteText-2026-09-04-1008.md`,**
> where each field is one unbroken line. This file keeps the reasoning.

---

## WHY THIS REVERSED

That section was written on 2026-09-02 against **licence v2.4**, which said
*"Your Guide license covers all five print sizes."* Versions delivers one, so
Versions was the wrong feature and the section said so.

**Bill answered the open decision the same day.** Against the DECISION NEEDED
marker in `GatewayGuard_License-BILLS-ANSWERS-2026-09-02-1553-TEXT.md`, line 68,
he wrote: ***"NO, ONLY ONE HE CHOOSES"*** -- Option B.

Option B's own note says what follows: *"the Gumroad product must be built as
five versions rather than five files."* **So the mismatch is gone and Versions
is now the correct feature.** Nothing about the earlier reasoning was wrong; the
contract it was measured against changed.

---

## THE FIELDS GUMROAD GIVES YOU

***sourced, Gumroad Help Center:*** *"You can add multiple versions by clicking
the 'Add version' button. Give your version a name, description, an additional
amount over the base product price, and a quantity if you wish to limit the
sales of the version."* Files attach per version -- content is added on the
Content tab, selecting the version first.

So each row below fills four things: **Name**, **Description**, **Additional
amount**, and one **file** on the Content tab.

**Additional amount is $0 on all five, and leave Quantity blank.** The five
sizes are a vision accommodation, not an upgrade. Charging more for large print
charges the reader who needs it most.

---

## THE FIVE VERSIONS

### 1

| Field | What to enter |
|---|---|
| **Name** | `12 point - standard print` |
| **Description** | `The size of type used in most printed letters and forms. Choose this if ordinary print gives you no trouble. Not the right size? Write to support@gatewayguard.co and we will send you a different one, free.` |
| **Additional amount** | `0` |
| **File** | `GatewayGuard Windows Security Walkthrough Guide - 12 point (standard print).pdf` |

### 2

| Field | What to enter |
|---|---|
| **Name** | `14 point - bigger print` |
| **Description** | `A step up from an ordinary printed letter. Choose this if small print has started to tire your eyes. Not the right size? Write to support@gatewayguard.co and we will send you a different one, free.` |
| **Additional amount** | `0` |
| **File** | `GatewayGuard Windows Security Walkthrough Guide - 14 point (bigger print).pdf` |

### 3

| Field | What to enter |
|---|---|
| **Name** | `16 point - large print` |
| **Description** | `Large print. Choose this if you hold pages further away than you used to, or reach for a brighter lamp. Not the right size? Write to support@gatewayguard.co and we will send you a different one, free.` |
| **Additional amount** | `0` |
| **File** | `GatewayGuard Windows Security Walkthrough Guide - 16 point (large print).pdf` |

### 4

| Field | What to enter |
|---|---|
| **Name** | `18 point - extra large print` |
| **Description** | `Extra large print. Choose this if large-print books are what you reach for. Not the right size? Write to support@gatewayguard.co and we will send you a different one, free.` |
| **Additional amount** | `0` |
| **File** | `GatewayGuard Windows Security Walkthrough Guide - 18 point (extra large print).pdf` |

### 5

| Field | What to enter |
|---|---|
| **Name** | `20 point - largest print` |
| **Description** | `The largest size we make. Choose this if you use a magnifier for ordinary print, or if a large-print book is still hard work. Not the right size? Write to support@gatewayguard.co and we will send you a different one, free.` |
| **Additional amount** | `0` |
| **File** | `GatewayGuard Windows Security Walkthrough Guide - 20 point (largest print).pdf` |

---

## WHY THE NAMES AND FILENAMES ARE SHAPED THIS WAY

**The number comes first so the ladder is obvious**, and the plain word comes
after because *"16 point"* on its own tells a senior nothing. Together they let
someone pick correctly without knowing what a point is.

**The filename repeats the full product name.** That is the same reason the test
files were renamed on 2026-09-02: the buyer reads that filename in their
download list, in the receipt, and in their Downloads folder six months later,
and by then *"Guide-16pt.pdf"* could be anything.

**Every description ends with the free-swap sentence.** That is not a courtesy
-- it is the promise Option B makes in the licence: *"If the size you chose does
not suit you, write to us at support@gatewayguard.co and we will send you a
different one at no charge."* A dropdown asks the reader to choose before they
have seen anything, so the way back has to be on the same screen as the choice.

**"Bigger print" rather than "larger print" at 14 point**, so it cannot be
misread as a comparative against *"large print"* one row below it.

---

## THE FILES ARE WHAT THE NAMES SAY -- MEASURED

***measured 2026-09-02 on the five files in `Store_TestFiles`, reading the PDF
content streams:*** each carries a content matrix of `.23999999` by `3.125` =
**0.75**, so the body-text `Tf` values resolve as:

| File | Body `Tf` | times 0.75 | Page |
|---|---|---|---|
| 12 point | 16.0 | **12.00 pt** | 612 x 792 (US Letter) |
| 14 point | 18.66 | **13.99 pt** | 612 x 792 |
| 16 point | 21.33 | **16.00 pt** | 612 x 792 |
| 18 point | 24.0 | **18.00 pt** | 612 x 792 |
| 20 point | 26.66 | **20.00 pt** | 612 x 792 |

Body face is `Garamond`, headings `Garamond-Bold`. **The numbers in the names
are true**, which matters, because a version name is a factual claim to a buyer
who chose it for their eyesight.

**One thing to look at in the real export:** the 12-point test file also renders
**11 runs at 9 point**. In a test file that is a footer. In the real Guide it
would sit below the project's own 14-point minimum, on the edition bought by the
reader least able to spare it. Worth a look when the real files are exported.

---

## FOUR THINGS THIS DEPENDS ON

1. **The five real PDFs do not exist yet.** These filenames describe the real
   export; `Store_TestFiles` holds the `TESTFILE - ` stand-ins. The names here
   are the test names with `TESTFILE - ` removed and the product's full name put
   in.
2. **The listing copy has to change.** It currently promises *"The Guide in five
   print sizes. Yours to keep, and yours to print"* -- true under the old
   licence, false under Option B. Same for *"Format: PDF, five print sizes"* in
   the additional-details table. Both are in
   `GatewayGuard_GumroadListings-2026-08-25-0015.md`.
3. **The sampler page Bill asked for.** His own mark-up: *"CREATE ADDITION ON
   WEBSITE THAT WILL SHOW THE SAME PARAGRAPH IN ALL FONTS AND ASK THE BUYER TO
   DETERMINE WHICH ONE THEY PREFER BEFORE GOING TO GUMROAD."* The descriptions
   above stand on their own without it, but the sampler is what turns a guess
   into a choice. It has no task on the CPM.
4. ***Not measured: how Gumroad renders these filenames on download.*** They
   carry spaces and parentheses. Some stores rewrite those. Check the downloaded
   filename after the test purchase and tell me what it says, rather than
   assuming it survives.
