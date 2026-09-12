# Draft clauses for the licence -- for Bill and the attorney

# Dated: 2026-08-28 14:00 ET

**These are DRAFTS. Nothing here has been added to the agreement.**
`GatewayGuard_License-2026-08-25-1400-TEXT.md` (v2.4) is untouched.

**This is not legal advice.** Every clause below needs the attorney's eye before
it ships. They are written so he has something to react to instead of a
description of something to write, which is faster and cheaper than starting
from a blank page.

**Written in the agreement's own voice** -- second person, short sentences, no
Latin, no "hereinafter". Compare Section 2's *"You are buying a license to use
Checkup -- not Checkup itself"* and Section 1's *"Your log file is yours."*
**That register is the point.** A contract a 70-year-old can read is the same
promise as a screen they can read.

**Where each came from:** `GatewayGuard_LicenceComparison-2026-08-28-1330.md`.

---

## DRAFT A -- FEEDBACK  *(new section; suggest 13, renumbering the rest)*

**Fills the gap against Malwarebytes §13.** Bill is one person whose customers
will email suggestions, and some of those will ship.

> ### 13. Ideas You Send Us
>
> If you send us an idea, a suggestion, or a request for a feature, we may use
> it. You are not giving up anything you own by writing to us, and we are not
> obliged to use it or to pay for it.
>
> We say this because Checkup is made by one person who reads every email. Good
> ideas from customers do get built. If we build yours, we own what we build,
> and you are welcome to tell people it was your idea.

**Notes for the attorney:**

- **Second paragraph is unusual and deliberate.** The standard clause is a bare
  grant of rights and reads as a grab. This one says why it exists and gives the
  customer something back. **If it weakens the clause legally, cut it -- but say
  so, because it is doing work for the brand.**
- **Deliberately narrower than Malwarebytes.** Theirs also takes a licence to use
  a business customer's trade name and logo in marketing. **We do not want that**
  -- we sell to households, and a name-and-logo clause in a consumer agreement
  invites suspicion.
- **Not covered here:** what happens if two customers send the same idea, or if
  an idea arrives that we were already building. **Ask whether that needs saying.**

---

## DRAFT B -- PRIVACY  *(new section; suggest 14)*

**Fills the gap against Malwarebytes §7.** ***measured: the word "privacy"
appears zero times in v2.4.***

**This clause cannot ship alone.** It points at a privacy policy, and **no
privacy policy exists.** Outline for that document is at the end.

> ### 14. Your Privacy
>
> **What Checkup collects: nothing.** Checkup does not send us your files, your
> settings, your log, or anything about your computer. The log it writes stays on
> your PC. We cannot read it unless you choose to email it to us.
>
> **What we collect when you buy.** Buying from us means giving your name, email
> address and payment details to our payment provider. They handle the payment
> and pass us your name and email so we can send you your download and support
> you if something goes wrong. **We never see your card number.**
>
> **What we do with your email address.** We use it to send you your purchase,
> to answer you if you write to us, and to tell you when a new annual version is
> available or when something about your product changes. **We do not sell it,
> rent it, or give it to anyone for their own use.**
>
> **How we handle all of it** is set out in full at gatewayguard.co/privacy.

**Notes for the attorney:**

1. **"We never see your card number" must be checked against the Gumroad
   arrangement before it ships.** ***Not measured.*** If Gumroad is merchant of
   record the sentence is almost certainly true, but **it is a factual claim
   about someone else's system and it is not ours to assume.**
2. **The third paragraph interacts with the email-list plan** in the licence
   Appendix -- notifying every past installer when an annual update ships,
   scaling to 100,000 addresses. The Appendix already records the research: a
   message whose only content is warranty, safety or security information, or
   notice of a change in terms, is treated as transactional and exempt from most
   CAN-SPAM requirements; **adding a sales pitch to the same message makes it
   commercial.** The draft is worded to stay on the transactional side.
   **Confirm that is what he wants.**
3. **The policy at `/privacy` does not exist and neither does the page.** See
   the outline below.

---

## DRAFT C -- SECTION 5, THE PRINTED COPY  *(three options; Bill picks one)*

**The problem, in one line:** *measured on our own pricing page*, the Guide
comes in **five sizes so people can read it** -- and Section 5 allows **one**
printed copy, of one size. **A couple who need different sizes cannot both have
one.**

**Current wording:**

> *"Print one copy for your own use."*

### Option 1 -- one copy per person in the household  *(recommended)*

> Print one copy for each person in your household who will use it. If two of
> you need different sizes, print the size each of you needs.

**Why this one.** It solves the case that actually happens, keeps the household
boundary the rest of Section 5 already uses, and it is a countable rule -- a
customer can tell if they are inside it.

### Option 2 -- a reasonable number for your own household

> Print as many copies as your own household needs. Do not print copies for
> anyone else.

**Closest to VMware's wording.** Simplest to read, hardest to enforce. **If
enforcement is not the point, this is the kindest version.**

### Option 3 -- leave it at one, and say why

> Print one copy for your own use, in whichever of the five sizes suits you
> best.

**Only defensible if the one-copy limit is deliberate.** ***It currently reads as
an oversight***, because Section 1 goes out of its way to say the five sizes are
one product.

**Section 1 needs a matching edit whichever is chosen.** It currently says: *"the
one printed copy Section 5 allows is one copy of the size you choose."*

---

## WHAT THE PRIVACY POLICY NEEDS -- OUTLINE, NOT A DRAFT

**A policy is a bigger document than a clause and it should be written once, by
someone who knows what applies.** Maine has no general consumer privacy statute
as of this writing; **selling to other states may bring their rules with it, and
that is an attorney question, not one I can settle.**

**What it has to answer:**

1. **What is collected, by whom** -- us, and the payment provider separately.
2. **Why**, for each item.
3. **How long it is kept**, and what happens when someone asks for deletion.
4. **Who else sees it** -- the payment provider, and the email service if one is
   used.
5. **How to reach us about it** -- `support@gatewayguard.co`.
6. **Cookies and analytics on gatewayguard.co**, if any. ***Not measured: whether
   the site carries any analytics at all.*** **Check before writing this part** --
   the honest answer may be "none", which is a selling point worth stating.

**The one line worth carrying into it:** Checkup itself collects nothing. That is
unusual, it is true, and most privacy policies cannot say it.

---

## WHAT IS STILL NOT DRAFTED, AND WHY

**The bare "Remove" margin note** in the licence file, after the programs-review
entry. **Two readings -- remove Section 7, or remove that change-log entry --
and they are entirely different edits. Still not guessed at.**

**Multi-PC pack scope** -- one household, one person, or any PC the buyer owns.
**A product decision, not a drafting one.** The packs run to $79.99, which is
enough that a buyer will read the sentence carefully.

**Arbitration, entire-agreement, assignment, export** -- already in the
agreement's own Appendix, marked *"confirm they were declined rather than simply
not reached."* **That question is for the attorney and drafting them first would
prejudge it.**
