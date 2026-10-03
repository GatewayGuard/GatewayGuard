<!-- Dated: 2026-08-25 14:00 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Research brief for Cloud — the licence questions raised on 2026-08-25

- **Document Name:** GatewayGuard_CloudResearchBrief-Licence
- **Last Modified:** 2026-08-25 14:00 ET
- **From:** Claude Code (CGDELL)
- **To:** Claude Cloud
- **Read first:** `GatewayGuard_CloudWorkingRules-2026-08-25-1400.md`
- **Base document for every question below:**
  `GatewayGuard_License-2026-08-25-1400-TEXT.md` (**version 2.4**). Confirm its
  row in `CURRENT.md` before you start.

---

## WHAT HAPPENED SINCE YOUR 09:21 HANDOFF

**Block 1 answered: Option A.** Your changes 1 through 9 were applied to
`Masters/GatewayGuard_License-2026-08-24-1210.docx` by
`Tool2/build_license_v24_2026-08-25.py`, an assert-guarded script that verifies
every anchor before writing and reads the file back afterwards. **Your `.docx`
is reference only and is not committed.** Your reasoning for preferring A was
right and your provenance caveat is what made it checkable.

**Your provenance caveat is resolved: the twin did match the master.** It was
generated from the `.docx` in the same run that produced it. **v2.2's base was
sound.**

**Block 2 corrected: there was nothing to retire.** All three files you listed
are untracked and have never been committed. They stay on disk, out of the
repository.

**Your 4b finding is in the document** as a DECISION NEEDED under Section 14,
worded as your reasoning: a carve-out is the hedge the August 22 decision warns
against, so it goes to the attorney rather than being patched.

**Your item 4 on the terms-change mechanism was right and I was wrong to cut
it.** I dropped it from the refund consult as off-topic. Testing showed refunds
are the term most likely to change, so it is restored as question B6, and the
clause itself is now drafted as Section 12.

**Bill has confirmed: binding stays.** Your reading of his 2026-08-04 note was
the contested one, and he has now settled it directly.

---

## WHAT IS NEW IN v2.4, SO YOU ARE NOT RESEARCHING A DEAD DRAFT

| # | Change | Why |
|---|---|---|
| A | **Licence moves now carry a small fee**, listed at gatewayguard.co | Bill typed *"We will reissue for a small fee"* into the v2.2 file. Replaces the free-and-unlimited promise your 4a flagged |
| B | **New Section 12, Changes to This Agreement** | Your item 4; the clause that spares a reissue. Old 12/13/14 became 13/14/15 |
| C | **Section 2 gains "Fixes to your version"** — corrections free, new annual version a separate purchase | The agreement was silent on patches, so a fix to the buyer's own version read as a version they had not bought |
| D | **Section 1 gains "What comes with each product" and "Your log file is yours"** | The launcher, the five Guide print sizes, and log ownership were all unnamed |
| E | **Section 8 gains two third-party paragraphs** | Checkup opens Malwarebytes and changes Microsoft's settings, and nothing disclaimed either |
| F | **Section 2's binding sentence states the licence rule, not a software behaviour** | See the warning immediately below |
| G | `can change or reset` → `may change or reset`, both places | Bill typed *"Say MS may change"* |

### THE ONE PLACE I DID NOT WRITE YOUR WORDING, AND WHY

Your Section 2 read: *"it makes a note of the computer it is running on, **and
from then on it runs on that computer**."*

***measured on ascii43:*** `Get-MachineIdentity` (line 3140) derives a
12-character SHA-256 hash of the hardware UUID and writes it to the screen and
the log. **Every reference to `$global:MachineID` outside comments is an
assignment or a `Write-Host`. It is never compared to anything.** The build's own
header comment at line 3139 reads *"Same fingerprint concept **planned** for
licensing."*

**So Checkup runs on any PC, every time.** Binding stays as Bill instructed, and
v2.4 keeps the whole friendly structure you wrote — but the clause now says
*"your license belongs to that computer"*, which is a statement about the
licence and is true, instead of a statement about what the software does, which
is not. **The gap is recorded in a DECISION NEEDED in the same section rather
than hidden.**

---

## THE FINDING THAT OUTRANKS EVERYTHING ELSE IN THIS BRIEF

***measured on ascii43, 2026-08-25:*** the strings **"license agreement"**,
**"EULA"**, **"terms of use"**, **"accept the terms"** and **"I agree"** appear
**nowhere** in the build. ***measured:*** **no page in `WebSite/` mentions a
licence agreement at all.**

**Nobody is ever shown this agreement, and nobody ever accepts it.**

The launch plan carries **"EULA posted"** as a critical task and has since
24 July. **Posted is not accepted**, and every question below assumes a contract
the buyer entered into. **Question 1 is therefore the one that matters most.**

---

# THE RESEARCH QUESTIONS

**Hold every question of your own until you have finished all fourteen.** Then
put them in one numbered list at the end.

**For each item: what does the research actually say, what do comparable
vendors actually do, and what do you recommend for us — in that order.** Where
the answer is "this is a legal judgment, not a research finding", say so and
route it to the attorney rather than answering it.

---

## PART A — HOW A BUYER ACCEPTS (the blocking group)

**1. How does a downloadable-software buyer become bound to a EULA in the US?**
Clickwrap versus browsewrap versus a link in a receipt. What do the leading US
cases actually require — *Specht v. Netscape*, *Nguyen v. Barnes & Noble*,
*Meyer v. Uber* and anything more recent. **What is the minimum that reliably
binds a consumer who downloads a file?**

**2. What can Gumroad actually do?** Can a seller present their own terms at
checkout, require a tick, or attach them to the receipt? Is there a product
field for it? **Answer from Gumroad's own documentation and from what sellers
report doing, and say which.** This is the practical constraint on question 1.

**3. What do comparable small publishers do** — one-person or small-team
Windows utilities sold once, not by subscription, through Gumroad, Paddle,
Lemon Squeezy or their own site? **Find five and describe exactly where their
licence appears and whether the buyer has to do anything.**

**4. Is a first-run acceptance screen worth building?** What do comparable
tools do on first launch, and does an in-product acceptance add anything legally
once the buyer has already paid and downloaded? **Bill needs the cost/benefit,
because the build freezes this week and a new screen is a build change.**

---

## PART B — PER-PC BINDING WITHOUT TECHNICAL ENFORCEMENT

**5. Is a stated per-PC licence with no software enforcement common, and is it
defensible?** Our position after v2.4 is that the one-PC rule is a term of the
agreement, not a lock. **Who else does this, and how do they word it?**

**6. FTC Act Section 5 (15 U.S.C. § 45) and hardware-bound consumer software.**
The attorney's outstanding instruction from 2026-08-04. **What is the actual
exposure, and what wording reduces it?** Add the Maine Unfair Trade Practices
Act, 5 M.R.S. § 207, since we are a Maine LLC selling to Maine residents.

**7. Licence transfer or reactivation fees.** Bill's decision is a small fee for
moving a licence to a replacement PC. **What do comparable vendors charge, how
do they word it, and are there consumer-protection limits on charging a fee to
restore access to something already bought?** *Note the sympathetic case the
wording has to survive: a widow with a dead laptop.*

---

## PART C — UPDATES, VERSIONS AND CHANGING TERMS

**8. The free-fix versus paid-new-version boundary.** We now grant free
corrections to the version bought, and charge for the annual version that
follows a new Windows release. **How do annual-version vendors word that
boundary — tax software, backup tools, disk utilities?** We need language that
does not let a buyer argue the annual version is a "fix".

**9. Terms-change clauses in one-time-purchase consumer EULAs.** Our new
Section 12 is deliberately narrow: a change applies only to a later purchase,
never to one already made. **Is that the standard shape, or do publishers
reserve broader rights? What is enforceable without a live account to notify
through?** We have no accounts and no login.

**10. Does the narrow form actually spare us a reissue?** A buyer accepts in
2026 and buys the 2027 update. **Which agreement governs the 2027 purchase, and
does Section 12 as drafted settle it cleanly?** This case arrives twelve months
out for every customer at once.

---

## PART D — DISCLAIMERS AND CLAIMS

**11. Third-party disclaimers where a product detects and opens another
vendor's application.** Checkup opens Malwarebytes to its scan screen and
changes Microsoft's settings. **What is the standard wording, and is naming
Malwarebytes in the agreement a trademark problem?**

**12. Is "contains no third-party code and no open-source components" a claim
worth making?** ***measured:*** Checkup's only `Add-Type` uses are inline
Windows API declarations and Microsoft assemblies that ship with Windows —
`System.Windows.Forms` and `System.Drawing`. Nothing is bundled. **But is
standard practice to say this, or to stay silent?** A claim we do not need is a
claim that can be wrong later.

---

## PART E — REFUNDS, WHICH JOIN THE SAME CALL

**13. Gumroad as merchant of record.** Who is the seller of record, who owes the
refund, and what is the chargeback exposure to the Gumroad account if we refund
generously? **This is the root question under our refund consult and it is not
in the attorney note.**

**14. Does a 30-day no-questions-asked refund change the binding analysis?**
Our own argument has been that the refund is the practical protection that makes
binding tolerable. **If the refund window has closed and the PC has died, what
is the buyer left with?** *That is the case the whole design has to survive, and
it is why binding and refunds belong in one conversation.*

---

## WHAT NOT TO DO

- **Do not produce a `.docx`.** Rule 3. Hand back a numbered change list against
  `GatewayGuard_License-2026-08-25-1400`.
- **Do not touch Section 13 or 14.** Both are flagged for the attorney and both
  flags are deliberate.
- **Do not broaden the product definition** to the standard *"including all
  updates, patches, and replacement versions"*. **It would give away the annual
  update, which is the whole renewal business.** If a source recommends it, say
  why we should decline it.
- **Do not add a refund hedge anywhere.** *"No questions asked earns its keep
  only if there are none. A single hedge undoes the whole sentence."*
- **Do not answer questions 6, 13 or 14 as settled law.** Research them, then
  say plainly that the decision is the attorney's.
