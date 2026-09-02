<!-- Dated: 2026-09-02 11:19 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Test files for both products -- what they are, and how to put them on Gumroad

- **Document Name:** GatewayGuard_StoreTestFiles
- **Last Modified:** 2026-09-02 11:19 ET
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
| `TESTFILE-GatewayGuard-Guide-12pt.pdf` | 65,925 bytes | 1 |
| `TESTFILE-GatewayGuard-Guide-14pt.pdf` | 68,709 bytes | 2 |
| `TESTFILE-GatewayGuard-Guide-16pt.pdf` | 68,330 bytes | 2 |
| `TESTFILE-GatewayGuard-Guide-18pt.pdf` | 66,837 bytes | 2 |
| `TESTFILE-GatewayGuard-Guide-20pt.pdf` | 69,251 bytes | 3 |

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

`TESTFILE-GatewayGuard-Checkup-v3.1.zip` -- **3,059 bytes**, containing:

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
4. Upload **all five** `TESTFILE-GatewayGuard-Guide-*.pdf` files from
   `Store_TestFiles\`. They can be dragged in together
5. Check they are listed **12, 14, 16, 18, 20** in that order. If Gumroad sorts
   them some other way, drag them into order -- **a reader looking for large
   print should not have to hunt**
6. **Save**

### Checkup

1. Open **GatewayGuard Checkup**
2. Click **Next: Customize**, then **Content**
3. Upload the single file `TESTFILE-GatewayGuard-Checkup-v3.1.zip`
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
