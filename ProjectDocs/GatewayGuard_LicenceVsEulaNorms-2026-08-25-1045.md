<!-- Dated: 2026-08-25 10:45 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Our licence measured against standard EULA practice

- **Document Name:** GatewayGuard_LicenceVsEulaNorms
- **Last Modified:** 2026-08-25 10:45 ET
- **Question, Bill 2026-08-25:** compare our EULA to the standard description of
  what a EULA names and scopes
- **Measured against:** `GatewayGuard_License-2026-08-25-0921.docx` (v2.2) and
  its unchanged sections in `GatewayGuard_License-2026-08-24-1210-TEXT.md`
- **Note:** v2.2 was open in Word during this review, so Sections 3 to 8 were
  read from the 1210 twin. **Cloud's change list states those sections are
  unchanged**, apart from Section 4's PC-migration bullet.

---

## THE SCORE

| Standard practice | Ours | Verdict |
|---|---|---|
| **1. Product identification and definitions** | Products named and defined; **no version number, no components** | **PARTIAL -- two real gaps** |
| **2. Scope of the licence** | Sections 3, 4 and 5 are unusually explicit | **STRONGER THAN TYPICAL** |
| **3. Third-party and bundled components** | **Nothing. Not one mention** | **THE REAL GAP** |
| **4. Keeps technical detail out** | Mostly. Two places lean in | **GOOD, with a caveat that is not in the standard list at all** |

**We are stronger than a typical consumer EULA on scope and weaker on
identification. And the biggest problem with the document is one this standard
description does not mention.**

---

## 1. PRODUCT IDENTIFICATION -- PARTIAL

### What we do well

Section 1 names both products, gives each a defined short form, and **says
which sections apply to which** -- Checkup in Sections 2 to 4, the Guide in
Section 5. It also provides for future products. **That is exactly the
ambiguity-prevention the standard describes, and v2.2 added it.**

### GAP 1 -- NO VERSION NUMBER ANYWHERE

***measured:* zero occurrences of `v3.1`, `version 3`, or any version number in
the entire agreement.**

Section 2 says only *"This license covers the version you bought."* **A floating
reference with nothing to point at.** The standard specifically calls for
version numbers, and **our own house rule requires v3.1 in all user-facing
text** -- the licence is the one user-facing document that omits it.

**Why it matters here more than usual.** We sell **annual updates as a separate
purchase**. Section 2 says the licence covers *"the version you bought"* and
that an updated version *"is a separate purchase"*. **With no version named,
there is nothing on paper distinguishing what a buyer got in year one from what
they must pay for in year two.** That is the exact dispute the clause exists to
prevent.

**Fix:** name the version on purchase. *"This licence covers GatewayGuard
Checkup version 3.1"* -- or, better for a document that outlives a build, *"the
version identified in your receipt and shown on Checkup's first screen."*

### GAP 2 -- THE PRODUCT IS MORE THAN ONE FILE, AND THE LICENCE NAMES ONE

Section 1 defines Checkup as *"delivered as a PowerShell script"* and the Guide
as *"a PDF document."* **Neither is the whole product.**

- ***measured:* Checkup ships with a `.bat` launcher** -- `Run-GatewayGuard.bat`
  -- so the buyer double-clicks rather than typing. **Is the launcher licensed?
  The agreement does not say.**
- **Checkup writes log files** to the user's PC. Section 7 and Section 9 both
  refer to *"your log file"*. **The agreement never says who owns the log.** For
  a product whose selling point is a record of what you approved, **that is
  worth one sentence.**
- ***The Guide is five PDFs, not one.*** Five print sizes, same words. Section 5
  licenses *"the Guide"* and Section 3 permits *"one backup copy"* and *"print
  one copy"*. **Does a buyer get one of the five, or all five? Can they print
  one copy of each, or one copy total?** *measured, the pricing page:* they
  receive all five.

**These are the "modules, components, or companion tools" the standard names.
We have three and list none.**

---

## 2. SCOPE -- STRONGER THAN THE STANDARD ASKS FOR

**Sections 3 and 4 are better than most consumer EULAs**, and worth saying so
plainly since the rest of this document is critical.

Section 3 grants, in plain words: install and run on the licensed PC as often as
you like; **open and read the source code**; keep one backup; and **quote short
portions in a review or when asking for help online, with credit.** *That last
one is unusual and generous, and it is the right instinct for a product sold on
auditability.*

Section 4's prohibitions are equally concrete, and two are commercially
important and easy to omit: **no use on business, school, government or
organisation computers**, and **no using Checkup to provide paid services to
other people.** *Both close real revenue leaks.*

**The standard's framing -- client-side versus server components versus APIs --
does not map to us**, and that is not a gap. There is no server and no API.
**Do not let a boilerplate reviewer add clauses for components that do not
exist.**

---

## 3. THIRD-PARTY COMPONENTS -- THE REAL GAP

***measured:* the agreement contains zero mentions of Malwarebytes, Microsoft
Defender, or any third party. No exclusions clause. No schedule.**

### Why that is a problem for this product specifically

**Checkup does not merely mention third-party software. It detects it and
launches it.** *measured, build function `Show-MalwarebytesFollowUp`:* Checkup
checks whether Malwarebytes is installed, adjusts what it recommends based on
what it finds, and **opens the Malwarebytes application to its scan screen.**

**So a buyer's experience of our product includes another company's product
starting up.** And Checkup's whole job is turning Microsoft's security settings
on and off.

**Nothing in the agreement disclaims either.** No statement that we do not
supply, warrant or support them; that their own terms govern; or that we are
not responsible if Microsoft changes a setting we recommended.

### Two sentences would close it

> **Other companies' software.** Checkup checks and changes settings that
> belong to Windows, and it can detect and open Malwarebytes if you have it.
> We do not supply, own or support those products, and your use of them is
> governed by their own terms, not this agreement.
>
> **No third-party code is included.** Checkup is our own work. It contains no
> other company's code and no open-source components.

**The second sentence needs verifying before it ships** -- *I believe it is true
of a PowerShell script calling Windows cmdlets, but I have not audited the file
for borrowed code, and this is a contract.* **Do not publish it on my belief.**

---

## 4. TECHNICAL DETAIL -- GOOD, AND ONE PLACE TO WATCH

**The standard says EULAs should leave system requirements and operating
instructions to the documentation. We mostly do.** No system requirements, no
install steps, no operating manual.

**Two places lean technical, and only one is a problem:**

- **Section 2's *"delivered as a PowerShell script (a .ps1 file). The source
  code is fully readable in any text editor."*** **Keep it.** It is not deep
  specification -- it is the factual basis of the trust promise the whole
  product rests on.
- **Section 7, the programs review.** It describes how a feature behaves. **Worth
  the attorney's eye** for whether it belongs in a contract or a manual --
  though there is a real argument that a feature which reads what is installed
  on someone's PC *should* be described in the agreement that authorises it.

---

## AND THE THING THE STANDARD DOES NOT MENTION, WHICH IS OUR BIGGEST PROBLEM

***measured: v2.2 contains eight `DECISION NEEDED` callouts.*** They are
internal notes -- written to Bill, quoting his own consult, naming prices and
unresolved arguments -- **sitting inside the customer contract.**

**No EULA standard covers this because no shipped EULA has it.** They must all
be resolved and deleted before a buyer sees a word of it, and **that is a
bigger, more certain problem than any gap above.**

**The related risk:** it makes v2.2 unsendable to the attorney as-is without
explanation, which is why the revised refund consult carries **excerpts**
rather than the whole agreement.

---

## WHAT I WOULD DO, IN ORDER

1. **Settle the PC-binding question** *(Section 2 currently describes something
   Checkup does not do -- see the v2.2 review)*. Nothing else in Section 2
   should be touched until that lands.
2. **Name the version**, and tie it to the receipt rather than to a number that
   ages.
3. **Add the components sentence** -- launcher, log files, five Guide sizes.
4. **Add the third-party sentence**, once the no-borrowed-code claim is checked.
5. **Resolve and delete all eight callouts.** *Q5 is already answered* -- Bill's
   verbatim notes, item 7: *"Allow them to make a 2nd copy for security for
   future."*
6. **Then** send it to the attorney.

**Items 2, 3 and 4 are half a day of wording and they are not on the critical
path.** Item 1 is, and item 5 is the one that stops it shipping.
