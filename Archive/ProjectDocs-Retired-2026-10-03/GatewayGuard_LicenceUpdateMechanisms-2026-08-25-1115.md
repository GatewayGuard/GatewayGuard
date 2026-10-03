<!-- Dated: 2026-08-25 11:15 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# The three no-reissue mechanisms, tested against our licence

- **Document Name:** GatewayGuard_LicenceUpdateMechanisms
- **Last Modified:** 2026-08-25 11:15 ET
- **Tests:** Gemini's three mechanisms for keeping a EULA valid across versions
- **Companion to:** `GatewayGuard_LicenceVsEulaNorms-2026-08-25-1045.md`
- **Status:** **Two of three fail, and testing the third found something bigger
  than all of it.**

---

## THE SCORE

| Mechanism | Ours | Verdict |
|---|---|---|
| **1. Broad product definition** -- *"together with all updates, patches, replacement versions"* | Narrow, deliberately | **FAILS -- but the failure is half right and half a real defect** |
| **2. Version-independent language** | No version in the contract; specifics live on the website | **PASSES CLEANLY** |
| **3. Changes-to-Terms clause, with click-Accept** | **Absent** | **FAILS** |

**And testing mechanism 3 turned up the thing that matters most:
*measured, nobody ever sees or accepts this agreement.*** See the last section.

---

## 1. BROAD PRODUCT DEFINITION -- WE ARE HALF RIGHT AND HALF WRONG

**The standard:** define the Software to include *"all updates, bug fixes,
patches, modifications, enhancements, and replacement versions"*, so a new
patch does not create a new agreement.

**Ours:** *"This license covers the version you bought."* **Narrow.**

### THE HALF THAT IS RIGHT, AND IT IS DELIBERATE

**We cannot adopt the standard definition, and we should not.** *"Together with
all replacement versions"* would grant every buyer a licence to the 2027
version. **That is the product we sell separately for $12.99 a year.** A broad
definition would give it away.

**Gemini's framing assumes the ordinary model -- buy once, all future updates
included. Ours is the opposite by design.** Narrow is commercially correct.

### THE HALF THAT IS A REAL DEFECT -- PATCHES ARE NOT NEW VERSIONS

**The standard bundles three different things: patches, bug fixes, and
replacement versions. We treat all three the same way, and only one of them
should be a separate purchase.**

**If we ship a correction to v3.1 -- call it v3.1.1, fixing a defect the field
run finds -- is the buyer licensed to run it?**

***measured:* the agreement is silent.** No mention of corrections, bug fixes,
or patches anywhere. Under *"the version you bought"*, **a fix to their own
version is arguably a different version they did not buy.**

**That is absurd as a commercial position and nobody intends it**, but it is
what the words say.

### AND I MADE IT WORSE YESTERDAY

***measured:* the Gumroad listing I wrote on 2026-08-25 promises **"Free
updates within the same version."*** ***measured:* the licence grants no such
thing.**

**So the store page promises a right the contract does not give.** That is the
same defect class as the website's Tamper Protection claim, and **I introduced
it**, in the document whose whole point was matching the store to the licence.

### THE FIX -- ONE SENTENCE, AND IT KEEPS THE BUSINESS MODEL

> **Fixes to your version.** Your licence covers the version you bought and any
> corrections we issue for that same version, at no charge. **A new annual
> version for a new Windows release is a separate product and a separate
> purchase.**

**That draws the line where the money is** -- free within a version, paid across
versions -- and it makes the store listing true.

---

## 2. VERSION-INDEPENDENT LANGUAGE -- WE PASS, CLEANLY

*measured, all four tests:*

| Test | Result |
|---|---|
| Version numbers in the contract body | **None** |
| Product referred to by trade name | **Yes** -- "GatewayGuard Checkup ('Checkup')" |
| System requirements in the contract | **None** |
| Specifics relegated to external documentation | **Yes** -- *"Updated terms and current prices are listed at gatewayguard.co"* |

**This is the mechanism I told Bill yesterday we were failing.** We were not.
**Withdrawn, and recorded in the companion document.**

**One consequence worth stating, because it looks like an inconsistency and is
not:** the **Gumroad listing does name "Checkup v3.1", and that is correct.**
Gemini's own wording puts version specifics in *"release notes, read-me files,
or website specifications"* -- a store page is exactly that. **Version in the
shop: right. Version in the contract: wrong.**

---

## 3. CHANGES-TO-TERMS CLAUSE -- ABSENT, AND IT WAS NEVER DECIDED

***measured:* no "we may update this agreement", no "the current version is
posted at", no modifications clause of any kind.**

**And it was on the list.** *measured, the 1210 appendix:* Question 11 of the
4 August cover note included **"a mechanism for changing terms in future
versions"**, and the appendix reads *"Confirm they were declined rather than
simply not reached."* **Nobody confirmed.**

**This is now question B6 of the revised refund consult.**

---

## AND THE THING THAT OUTRANKS ALL THREE

**Gemini's mechanism 3 assumes a click-Accept exists to hang the change on.
Testing that assumption produced this:**

***measured, ascii43:* the words "license agreement", "EULA", "terms of use",
"accept the terms" and "I agree" appear NOWHERE in the build.**

***measured:* no page anywhere in `WebSite/` mentions a licence agreement or a
EULA.**

### SO NOBODY EVER SEES IT, AND NOBODY EVER ACCEPTS IT

- **Checkup never shows it.** No acceptance screen, no first-run terms, nothing.
- **The website does not carry it.** There is no licence page.
- **The only remaining place is Gumroad**, and nothing in our tree puts it there.

**An agreement nobody is shown and nobody accepts is of doubtful use, whatever
its wording says.** Every question in the refund consult -- what binds the
buyer, what the licence grants, when it ends -- **presumes a contract the buyer
entered into.**

**This is not a drafting gap. It is a question about whether there is a contract
at all**, and it belongs at the top of the attorney call rather than inside it.

### IT IS ON THE PLAN, AND ONLY AS FIVE WORDS

*measured, the 02-Aug CPM, task **T-LP**:* *"Launch prep: pricing locked,
Gumroad live, **EULA posted**"* -- marked **CRITICAL**.

**So "EULA posted" is on the critical path and has been since 24 July.** No page
exists, no acceptance mechanism exists, and **"posted" is not the same as
"accepted"** -- which is the distinction Gemini's mechanism 3 turns on.

---

## WHAT I RECOMMEND, AND WHAT I DO NOT

**Do now, before the attorney call -- half a day, not on the critical path:**

1. **Add the fixes-to-your-version sentence** *(section 1)*. It makes the store
   listing true and costs nothing commercially.
2. **Add a changes-to-terms clause** *(section 3)*, worded so the attorney can
   accept or replace it rather than draft from nothing.

**Ask the attorney, and do not guess at it:**

3. **How does a buyer accept this agreement?** Presented at Gumroad checkout, on
   a licence page linked from the receipt, on Checkup's first screen, or some
   combination. **This decides how mechanism 3 works and whether the contract
   binds.** *It also touches the product: a first-run acceptance screen is a
   build change, and the build freezes Thursday.*

**Do NOT do:**

4. **Do not broaden the product definition** to the standard *"including all
   replacement versions"* wording. **It would give away the annual update.** If
   a boilerplate reviewer proposes it, the answer is the narrower sentence in
   section 1.
