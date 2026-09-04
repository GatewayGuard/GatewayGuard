<!-- Dated: 2026-09-04 10:08 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# EVERY GUMROAD FIELD, AS ONE UNBROKEN LINE -- paste from here, nowhere else

- **Document Name:** GatewayGuard_GumroadPasteText
- **Last Modified:** 2026-09-04 10:08 ET
- **Last Editor:** Claude Code (CGDELL)
- **For:** Bill, to copy straight into Gumroad
- **Replaces, for copying purposes:** the copy blocks in
  `GatewayGuard_GumroadListings-2026-08-25-0015.md`,
  `GatewayGuard_GuideVersions-Gumroad-2026-09-02-1841.md`,
  `GatewayGuard_GumroadBundleAndPacks-2026-09-04-0651.md` and
  `GatewayGuard_StoreCopyRecheck-2026-09-04-0756.md`. Those keep the reasoning.
  **This file is the only place to copy from.**

---

## THE BUG WAS MINE, AND IT EXPLAINS EVERY SPACING DEFECT

**Bill found it, 2026-09-04:** *"All of the previous spacing errors were caused
by this."* **He is right.**

I wrapped every block of copy at about 66 characters to keep the documents tidy.
**Those wraps are real line breaks.** Pasted into a Gumroad box that expects one
line, each break becomes a space -- and where my wrap landed next to an existing
space, it became two. That is exactly the pattern:

| What was on the page | Where my wrap fell |
|---|---|
| `12  point - standard print ` | after `12`, and a trailing break |
| `or  reach for a brighter lamp` | after `or` |
| `a      different one` | after `a` |
| `size?  Write to` | after `size?` |

**I called these "typing slips" three times, in three documents.** They were not.
**They were my formatting, arriving intact.** Corrected in the record.

**The rule from here: any string meant to be pasted is written as ONE PHYSICAL
LINE**, however long, inside a code fence. A blank line inside a block means a
real paragraph break and is intended. Nothing else breaks.

---
---

# 1. CHECKUP

### 1a. Refund fine print -- THIS IS ITEM #3

*Two paragraphs. The blank line between them is deliberate; there are no breaks
inside either one.*

```
If Checkup is not what you expected, write to us within 14 days of buying and we will refund you in full. You do not have to give a reason.

You do not need to prove anything, send us a log file, or let us try to fix the problem first. Email support@gatewayguard.co from the address you bought with and give us your order number. We aim to answer within two business days.
```

**If the box will only take one paragraph, use this instead:**

```
If Checkup is not what you expected, write to us within 14 days of buying and we will refund you in full. You do not have to give a reason. You do not need to prove anything, send us a log file, or let us try to fix the problem first. Email support@gatewayguard.co from the address you bought with and give us your order number. We aim to answer within two business days.
```

### 1b. Refund policy title

```
14-day money back guarantee
```

### 1c. The "whether" sentence -- find and replace in the description

Find:

```
You choose whether to apply it.
```

Replace with:

```
You choose if it is applied.
```

### 1d. The packs sentence -- cut it, or build the packs

The description currently ends with a sentence advertising packs that do not
exist. **Either build the versions in section 3 below, or replace that sentence
with nothing.** Find and delete:

```
Using more than one PC? Packs for 3, 5, and 10 are available at gatewayguard.co.
```

---
---

# 2. THE SECURITY GUIDE

### 2a. The wrong domain -- it is in TWO fields

**Find this in the description AND in the refund fine print:**

```
Free online documentation is available at gatewayguide.co (Not .com) to preview all 19 covered security settings before purchase.
```

**Replace both with:**

```
Free online documentation is available at gatewayguard.co to preview all 19 covered security settings before purchase.
```

*The "(not .com)" is dropped on purpose. It was there to prevent one mistake and
it caused a worse one; a correct address does not need a warning attached.*

### 2b. Refund fine print -- the whole field, corrected

```
All sales final. Every setting the Guide covers is published free at gatewayguard.co, so you can read the whole scope before you buy. Free online documentation is available there to preview all 19 covered security settings before purchase.
```

*"Once downloaded" is gone -- licence v3.0 sells the Guide without a refund, with
no condition attached.*

### 2c. Refund policy title

```
No refunds allowed
```

### 2d. Receipt thank-you message -- ITEM #4

*Replaces what is there now, which is the refund paragraph pasted a second time.*

```
Thank you for choosing the GatewayGuard Windows Security Walkthrough Guide. Your download link is below -- it is the print size you chose, and the words are the same in all five. If the size does not suit you, reply to this email and we will send you a different one, free.
```

### 2e. Details table -- four rows, each cell one line

**Label 1**
```
Format
```
**Value 1**
```
PDF
```

**Label 2**
```
Print size
```
**Value 2**
```
You choose one of five. The words are identical.
```

**Label 3**
```
Works on
```
**Value 3**
```
Windows 11 Home and Pro
```

**Label 4**
```
Needs Checkup?
```
**Value 4**
```
No. The Guide is complete on its own.
```

### 2f. The five version NAMES

```
12 point - standard print
```
```
14 point - bigger print
```
```
16 point - large print
```
```
18 point - extra large print
```
```
20 point - largest print
```

### 2g. The five version DESCRIPTIONS

**12 point**
```
The size of type used in most printed letters and forms. Choose this if ordinary print gives you no trouble. Not the right size? Write to support@gatewayguard.co and we will send you a different one, free.
```

**14 point**
```
A step up from an ordinary printed letter. Choose this if small print has started to tire your eyes. Not the right size? Write to support@gatewayguard.co and we will send you a different one, free.
```

**16 point**
```
Large print. Choose this if you hold pages further away than you used to, or reach for a brighter lamp. Not the right size? Write to support@gatewayguard.co and we will send you a different one, free.
```

**18 point**
```
Extra large print. Choose this if large-print books are what you reach for. Not the right size? Write to support@gatewayguard.co and we will send you a different one, free.
```

**20 point**
```
The largest size we make. Choose this if you use a magnifier for ordinary print, or if a large-print book is still hard work. Not the right size? Write to support@gatewayguard.co and we will send you a different one, free.
```

**Additional amount on all five:**
```
0
```

### 2h. Optional -- the jargon word

Find `harden your PC`, replace with `secure your PC`.

---
---

# 3. THE CHECKUP PACKS -- versions on the Checkup product

**Base price stays $19.99. The amounts below are added to it.**

| Version | Additional amount | Buyer pays | Per PC |
|---|---|---|---|
| One PC | 0 | $19.99 | $19.99 |
| 3 PCs | 15 | $34.99 | $11.66 |
| 5 PCs | 30 | $49.99 | $10.00 |
| 10 PCs | 60 | $79.99 | $8.00 |

### Names

```
One PC
```
```
3 PCs
```
```
5 PCs
```
```
10 PCs
```

### Descriptions

**One PC**
```
Checkup for one computer. Most people want this one.
```

**3 PCs**
```
Checkup for three computers - any three Windows 11 PCs you own. That works out at $11.66 a PC.
```

**5 PCs**
```
Checkup for five computers - any five Windows 11 PCs you own. That works out at $10.00 a PC.
```

**10 PCs**
```
Checkup for ten computers - any ten Windows 11 PCs you own. That works out at $8.00 a PC.
```

### Additional amounts

```
0
```
```
15
```
```
30
```
```
60
```

### The paragraph to add to Checkup's description

*Three paragraphs; the blank lines are intended.*

```
MORE THAN ONE PC

A 3, 5 or 10-PC pack covers that many computers -- any Windows 11 PCs you own. One copy runs on one computer.

If a computer fails and you replace it, email us at support@gatewayguard.co and we will move that licence to the new PC. There is no charge for the move, and we are not going to make you prove anything.
```

---
---

# 4. THE BUNDLE

### 4a. Name

```
GatewayGuard Checkup and Security Walkthrough Guide
```

### 4b. URL

```
bundle
```

### 4c. Summary

```
Checkup and the Guide together, for one PC. Save $2.99 on buying them apart.
```

### 4d. Call to action

```
I want this!
```

### 4e. Price

```
29.99
```

### 4f. Description

*Each paragraph is one line. The blank lines are real paragraph breaks.*

```
The program and the written guide, together, for one PC.

Some people want the work done for them. Some want to read it and do it themselves. Most want a bit of both -- and that is what this is.

WHAT IS IN IT

GatewayGuard Checkup, for one PC. It walks you through 19 Windows 11 security settings one at a time, tells you in plain words what it found, and asks your permission before it changes anything. If you say no, nothing happens.

The GatewayGuard Windows Security Walkthrough Guide, as a PDF in the print size you choose. It covers the same ground on paper -- what each setting does, why it matters, and how to check and change it yourself.

WHY BOTH

Checkup does the work while you watch. The Guide explains it while you read, at your own pace, away from the screen. You can hand the Guide to someone else in the house, or keep it beside you the next time Windows moves something.

Every step in the Guide says what you should see on your screen, what it should say, and what to do if it says something else.

YOU CAN READ EVERY LINE OF CHECKUP

Checkup is a plain text script, not a compiled program you have to trust. You or anyone you trust can open it and read it. It is digitally signed, so Windows can confirm it came from us and has not been altered.

WHAT YOU NEED

Windows 11 Home or Pro, and a PDF reader. Every Windows 11 PC already has one. No account to create, no sign-up, nothing to install.

WHAT YOU GET

Checkup v3.1, for one PC. The Guide in the print size you pick. A log of every choice you made, saved on your own computer. If we issue a fix for the version of Checkup you bought, it is free.
```

### 4g. Details table

**Label 1**
```
Works on
```
**Value 1**
```
Windows 11 Home and Pro
```

**Label 2**
```
What you get
```
**Value 2**
```
Checkup for one PC, and the Guide
```

**Label 3**
```
Guide format
```
**Value 3**
```
PDF, in the print size you choose
```

**Label 4**
```
Source
```
**Value 4**
```
Plain text you can read. Digitally signed.
```

### 4h. Refund -- PICK ONE. The 30 days now on the screen is in neither option.

**OPTION A -- 14 days.** *(recommended -- reasoning in
`GatewayGuard_GumroadBundleAndPacks-2026-09-04-0651.md`)*

Title:
```
14-day money back guarantee
```

Fine print:
```
If the bundle is not what you expected, write to us within 14 days of buying and we will refund the whole purchase. You do not have to give a reason.

You do not need to prove anything, send us a log file, or let us try to fix the problem first. Email support@gatewayguard.co from the address you bought with and give us your order number. We aim to answer within two business days.
```

**OPTION B -- no refund.**

Title:
```
No refunds allowed
```

Fine print:
```
A bundle includes the Guide, which is sold without a refund. Every setting the Guide covers is published free at gatewayguard.co, so you can read the whole scope before you buy. For that reason a bundle purchase is not refundable. If you want Checkup with its 14-day refund, buy Checkup on its own.
```

### 4i. The bundle's five print-size versions

Same names, descriptions and `0` amounts as sections **2f** and **2g** above.
Each version's content is **Checkup's file plus that one Guide PDF**.

---

## AFTER YOU PASTE -- ONE CHECK THAT COSTS NOTHING

Tell me when you have saved, and I will re-read every field from the live pages
and report any string that does not match this file character for character.
**That is a measurement, not a look** -- it catches a stray space no eye will
see, which is the whole reason this file exists.
