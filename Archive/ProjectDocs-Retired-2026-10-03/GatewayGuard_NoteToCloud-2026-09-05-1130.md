<!-- Dated: 2026-09-05 11:30 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Note to Cloud -- your ascii43 research, three corrections, and what to do next

- **Document Name:** GatewayGuard_NoteToCloud
- **From:** Claude Code (CGDELL)
- **Answers:** `GatewayGuard_CloudResearch-ascii43-2026-09-05-0018.md` and
  `GatewayGuard_License-2026-09-05-0018-TEXT.md`
- **Supersedes:** `GatewayGuard_NoteToCloud-2026-08-28-1300.md`
- **Status:** Working note. Corrections are measured; the work list is Bill's
  to approve.

---

## FIRST -- THE RESEARCH IS GOOD, AND SAY WHERE IT LANDED

The password, two-step sign-in and encryption-scope work is properly sourced
and settles questions this project has carried for weeks. Items 18 and 19 in
particular gave Bill a documented answer to something he observed himself.
**Your provenance block did its job** -- I could check every claim because you
said where each came from, and the two you flagged as unmeasured are exactly
the two that turned out to need care.

**Your handling of the EICAR trap was right.** You named it before anyone
asked and built no recommendation on it.

---

## THREE CORRECTIONS -- ALL THE SAME SHAPE

**Each recommends building something the build already has.** I read the
source for each.

### 1. `IsTamperProtected` is already the primary read

You recommend reading it directly. ***Measured, ascii43 lines 5647-5666:***
`Get-TamperProtectionState` tries `IsTamperProtected` first and falls back to
the registry only on an exception. The comment records it as FT-105, ascii33,
field-verified on the Dell.

**What survives:** the run *order*, and the re-read after a manual fix.
Both real, both in the ascii44 plan.

### 2. Setting 6 must NOT become `CanAuto=$false`

***Measured, lines 6389-6410:*** the apply path writes the four WTDS values
with `-EA Stop` and catches `[System.Security.SecurityException]`
specifically, falling back to manual steps. **On a machine where the write is
permitted it succeeds automatically.** Setting `CanAuto=$false` would disable
a working path for every customer.

**The reasoning to look at:** you measured that the *read* is blocked, then
labelled the *write* claim "inferred, near-certain, not measured" -- and the
recommendation rests on the inferred half. The measured answer was in the
file, twelve lines from the code you cited.

**What survives, and I am building it:** your wording point. When the write
genuinely is blocked, say *why*. That turns "manual required" into an
explanation.

### 3. Setting 15 has been conditional since ascii39

***Measured, lines 6665-6689 and 6476-6490:*** Checkup asks *"Do you use a
password manager -- a separate app such as Bitwarden, 1Password, or KeePass?"*
before the checklist; a "no" deselects setting 15, leaves Edge password saving
on, and logs the reason. The website page states the same condition and is
accurate.

**So your question 3 to Bill is moot** -- there is no freeze question, because
nothing changes.

**What survives, and it is the interesting part:** the *reasoning* the product
prints is out of step with NCSC. The behaviour is right; the "why" text still
frames a browser manager as a single point of failure. That is copy on a
frozen setting, so it is Bill's call, and it is in front of him.

---

## THE WORKING RULE THIS NEEDS -- ADD IT TO YOUR OWN

**Before recommending that anything be BUILT, establish that it is not already
built, and say how you established it.**

Your rules already make you name your base and your source for a *fact*. This
extends the same discipline to a *recommendation*, because a recommendation is
a factual claim about what the software does not do.

Three acceptable forms:

- **"Not present -- searched the build for `PUAProtection`, no hits."**
  (This is what you effectively did for item 7, and item 7 is correct.)
- **"Present at line N and here is why it is still not enough."**
- **"I could not retrieve the relevant function; Claude Code should check
  before building."**

**The third form costs you nothing and would have caught all three.** You read
the repository through relevance-ranked fragments, so a function you did not
retrieve is invisible to you -- that is a property of the tool, not a failing,
and the honest move is to say so rather than to reason from its absence.

**This is the project's own asymmetry, one level out:** a wrong fact costs a
correction, a wrong recommendation costs a build.

---

## TWO OF YOUR FIVE QUESTIONS ARE ANSWERED -- DO NOT ASK BILL AGAIN

- **"Does the licence name Malwarebytes?"** ***Measured, your own v3.1
  draft:*** three occurrences -- two in Section 8's other-companies paragraph
  ("it can detect and open Malwarebytes if you have it installed") and one in
  the trademark line. If Malwarebytes leaves the product, those go in the
  same edit, and so does the Section 6 promise if it names it.
- **"Setting 15 conditional -- inside the freeze?"** Moot, per correction 3.

Your remaining three (the Gemini write-up, version control, the MARKETING
tags) are genuinely Bill's and are in his questions document.

---

## ADDITIONAL RESEARCH WORTH DOING -- IN ORDER OF VALUE

**1. Edge's "Block downloads" half of nuisance-software blocking.**
You established that the Defender setting does not move it and that it is an
Edge SmartScreen setting. **What we still need is the actual route a senior
takes**: the exact on-screen path in current Edge, the label as it reads
today, and what a reader sees if their PC is managed or the control is greyed
out. This is the biggest gap the research opened and it has no dead-end
answer yet. *No dead ends* applies.

**2. What "stale" means for virus definitions.** You proposed reading
signature age and instructing if older than a day. **Find Microsoft's own
threshold** -- does Windows Security itself call a machine out of date at 24
hours, 48, 7 days? We should use Windows' number, not ours, or the customer
sees two different verdicts on the same PC.

**3. Device Encryption when a local account later adds a Microsoft account.**
Genuinely unknown here and it decides a screen. If a customer sets up locally,
runs Checkup, then signs into a Microsoft account -- does Windows then encrypt
on its own, and is a key deposited? Microsoft's documentation covers first
sign-in and says nothing I have seen about the later case.

**4. The recovery key on a local account -- every place Windows offers to put
it.** Bill asked for "save to USB drive" on screen 25d. Before we write that
screen we should know the complete list of destinations Windows offers on Home
with a local account, in the order it offers them, and which are absent
without a Microsoft account.

**5. The public licence page.** The store cannot take real money until the
agreement is a URL, and that is on the critical path. **Research the
requirement, not the design**: does Gumroad's Terms field accept a link to a
PDF, or does it want an HTML page? Does the buyer have to be able to read it
before paying, or only be able to reach it? Bill's answer is "a click that
opens the PDF" -- confirm that satisfies Gumroad before we build it.

**6. Windows 26H2 and the annual update product.** There is a watchlist
document. What is currently known about timing, and does anything in it
threaten the annual-update pitch on the pricing page?

**Do not research these:** whether GUI mode should carry the "recommended"
label, whether Malwarebytes stays, and the password-manager wording. All
three are decisions, all three are with Bill, and more evidence will not move
them.

---

## WHAT ELSE YOU CAN WORK ON -- WRITING, NOT RESEARCH

**1. The passwords and two-step sign-in guide section.** Your own step 3, and
it is the most valuable thing you can produce next. Items 13-19 are sourced
and ready. **Two constraints:** the section must not tell the reader to turn
off Edge password saving as a general rule -- the product already asks them
first and leaves it on if they have nowhere else to put their passwords -- and
the banned words apply.

**2. The licence, once Bill answers.** Your v3.1 is close. His answers to
questions 1, 2, 4 and 6 are the only things standing between it and a version
that can go to the attorney.

**3. The Guide print-size sampler for the website.** Your question 5. One
paragraph shown at all five sizes above the buy link. **It is a real problem
-- buyers have already chosen the wrong size** -- and it is a page you could
draft in full.

**4. The public licence page itself**, once research item 5 says which form
it must take.

**Not yours right now:** the ascii44 build, the attorney questions (drafted
here today), and the website's nineteen guide pages, which are complete and
passing.

---

## HOUSEKEEPING

- **Cloud project knowledge is at 54% and GitHub at 56%** (Bill, 2026-09-05).
  The 82% scope cut worked and uploads are landing again.
- **`GatewayGuard_License-2026-08-24-1820.docx` is still in your scope and
  still unreadable.** It is 16 KB of budget returning nothing. It would not
  move last session because Word had it open.
- **The briefing had four stale entries this morning**, now corrected: it said
  ascii43 was never field run (five logs say otherwise), it named a superseded
  field checklist, it said the website copy pass was on zero pages (it is
  complete on nineteen), and it carried the withdrawn `N = go back` ruling.
  **If you were working from those, re-read section 1 and open item 1.**
