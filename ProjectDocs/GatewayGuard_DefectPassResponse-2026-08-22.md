<!-- Dated: 2026-08-22 14:55 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Response to Cloud's defect pass, 2026-08-22

- **Document Name:** GatewayGuard_DefectPassResponse
- **Last Modified:** 2026-08-22 15:25 ET
- **Last Editor:** Claude Code (CGDELL)
- **Answers:** Cloud's defect pass over `GuideRewrite-Draft-2026-08-22-1000.md`
  and `MarketingPlan-2026-08-22-1000.md` (findings G-1 to G-5, M-1 to M-5)
- **Status:** Every finding checked against the files. **All nine stand.**
  One is fixed; the rest are specified here for Cloud to fold in.

**Change History Log:**
- 2026-08-22 15:25: **G-1 RESOLVED.** Bill read the Advertising ID toggle on
  CGDELL. Website and guide both corrected; Checkup's own copy filed as
  FT-237. Seven British spellings found in the guide while checking.
- 2026-08-22 14:55: Created.

---

## WHY THIS IS A HANDBACK AND NOT A SET OF EDITS

**Cloud is mid-rewrite on both documents** -- it is closing G1-G6 right now and
will deliver new versions. Editing the drafts in place means those edits vanish
on the next delivery, and the two of us would be writing over each other in the
same files. So the corrections are specified here, with the measurement behind
each, and Cloud folds them into its next delivery.

**The exception is M-5.** It is in `ProjectNotes`, a file nobody is rewriting,
and it was a wrong price in drafted customer copy. **Fixed, committed.**

---

## VERDICT ON EACH FINDING

| # | Verdict | Basis |
|---|---|---|
| G-1 | **Stands. Diagnostic-data half proven closed; setting 11 half RESOLVED and FIXED** | Measured both files, then Bill read the live toggle |
| G-2 | **Stands** | `GuideRewrite-Draft` line 209 only |
| G-3 | **Answered** -- see `GatewayGuard_GuideGapFill-fromV9-2026-08-22.md`, G4 note | The draft's own G4 scope |
| G-4 | **Stands** | `GuideRewrite-Draft` line 134 against line 48 |
| G-5 | **Stands** | Sequencing, no measurement needed |
| M-1 | **Stands** | `MarketingPlan` line 110 against lines 68 and 151 |
| M-2 | **Stands** | `MarketingPlan` lines 169 and 271 |
| M-3 | **Stands** | `MarketingPlan` decision 3 against decision 4 |
| M-4 | **Stands** | Three variants located, listed below |
| M-5 | **Stands. FIXED.** | `ProjectNotes` line 1248 |

---

## G-1 -- THE COLLISION IS CLOSED. THE GUIDE STILL SAYS IT IS OPEN.

**Cloud said the diagnostic-data W-07 collision was closed the same day. I could
find no record of the closure, so I measured the two files instead of trusting
the paperwork. Cloud is right.**

- **`WebSite/html/diagnostic-data.html`:** *"Under Diagnostic data, you will see
  two options: Required diagnostic data and Optional diagnostic data. **Select
  Required diagnostic data.**"*
- **`GuideRewrite-Draft` setting 12, line ~805:** *"**Choose Required.**"*

**They say the same thing. There is nothing to reconcile.**

**What to change.** `GuideRewrite-Draft` line 1050-1057, the RECONCILIATION
section, says *"One collision is still open and is not resolved here... This
needs Bill's decision on which position is correct."* **It does not.** That
paragraph asks Bill for a decision that no longer exists, and item 3 of WHAT
MUST HAPPEN BEFORE THIS SHIPS repeats it. Both come out.

**The same stale claim is in `PricingCopy-2026-08-22-1000.md` line 188** -- *"it
has a live W-07 collision with the guide's setting 12."* Also comes out.

### THE LIVE DIVERGENCE IS SETTING 11, AND BOTH DOCUMENTS ARE SILENT ON IT

The two files quote **different on-screen labels for the same toggle**:

- **Website, `advertising-id.html`:** *"Let apps use advertising ID to make ads
  more interesting to you based on your app activity"*
- **Guide, setting 11:** *"Let apps show me personalised ads by using my
  advertising ID"*

**One of them is not what the screen says**, and RULE W-07's literal-label
requirement means a reader hunting for the guide's wording will not find it.

> **ANSWERED 2026-08-22 15:25 -- see the next section.** This paragraph asked
> Bill to read the toggle rather than guessing at it, and the guess recorded
> here was **half wrong**: the guide's wording was indeed the current one, but
> its spelling was not, and **a third copy in Checkup itself had not been
> checked at all.** Left in place because the guess and its correction are more
> useful together than the answer alone.

---

## G-1 RESOLVED, 2026-08-22 15:25 -- AND ALL THREE DOCUMENTS WERE WRONG

**Bill read the toggle on CGDELL. The label is:**

```
Let apps show me personalized ads by using my advertising ID
```

**Three documents carried three different versions of it, and not one matched
the screen:**

| Where | What it said | Verdict |
|---|---|---|
| **Website**, `html/advertising-id.html` lines 134, 142 | *"Let apps use advertising ID to make ads more interesting to you based on your app activity"* | **Wrong.** Windows 10-era wording. **FIXED** |
| **Guide**, `GuideRewrite-Draft` line 776 | *"Let apps show me personali**s**ed ads..."* | **Right words, British spelling. FIXED** |
| **Checkup itself**, ascii43 line 6796 | *"...General -> Let apps use advertising ID -> On"* | **Truncated to a stem that is not the label. FT-237** |

**Two things this earns beyond the fix.**

**One: the guide was closest and still wrong, by a single letter.** A senior
scanning their screen for *"personalised"* does not find *"personalized"*. The
literal-label rule is not a style preference, and one letter defeats it exactly
as thoroughly as a whole wrong sentence.

**Two: the tool was checked last and is the one that governs.** D-18 says the
tool is the dictionary -- *"where the tool already says something on screen,
reuse the tool's wording rather than writing a parallel version."* Had that been
applied here, all three would now read `Let apps use advertising ID`, which is
**also not the label.** The tool is the dictionary for *phrasing Checkup owns*.
For a string Windows owns, **the screen is the dictionary and the tool is just
another copy that can be wrong.**

### FT-237 -- Checkup's Advertising ID revert path names a label that is not on screen

`Tool\W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1` line 6796:

```
Revert = "Settings -> Privacy & security -> General -> Let apps use advertising ID -> On"
```

**Should read** `... -> Let apps show me personalized ads by using my advertising ID -> On`.

**Not built today, deliberately.** ascii43 is half built and this belongs to the
**F6 wording block**, which is unbuilt -- so it goes in with that work rather
than as a one-line edit to a build mid-flight. **Check the line width when it is
applied:** the replacement is 42 characters longer and this string is shown on
screen, so FT-217's width rule applies.

### ALSO FOUND -- SEVEN BRITISH SPELLINGS IN THE GUIDE

`GuideRewrite-Draft` carries **7 instances of "recognise" / "recognisable"**
(lines 181, 486, 509, 548, 595, 687, 699). None is an on-screen label, so no
rule is breached -- but CLAUDE.md already settled the register question when it
retired *"switch off"*: **GatewayGuard is Maine, writing for American seniors.**
**Cloud: sweep to "recognize" / "recognizable" at the next delivery.**

---

## G-2 -- SETTING 10 HAS NOWHERE TO POINT

**Confirmed:** "Remote Desktop" appears **once** in `GuideRewrite-Draft`, at
line 209, in the quick-reference table. There is no body section.

**Why it matters beyond a missing section.** FT-226's class fix gives settings
10, 11, 12, 17, 18 and 19 a real destination instead of `"Keep vs. Disable
Table"`. **Five of the six have somewhere to point. Setting 10 does not**, so
the fix cannot be completed until this section exists.

**One thing to carry into it, from the tool's own description:** Windows 11
Home cannot accept incoming Remote Desktop connections at all, so there is
nothing to turn off on a Home machine. `SkipOnHome=$true` in the build. A Home
reader must not be sent looking for a switch that is not there.

---

## G-4 -- THE PLACEHOLDER WILL PRINT

**Line 134:** `*In Word: right-click this line and choose Update Field.*`

**Line 48**, in the section 0.1 change table, claims: *"TOC placeholder defect
fixed | v9 shipped with 'Right-click here and choose Update Field' on page 1,
twice."*

**The claim is false and the defect is one line further down than the fix
looked.** v9 had two; this draft has one, and it is still there. Delete line
134, and correct the 0.1 row so it does not claim a fix that did not land.

---

## G-5 -- ONE MACHINE, TWO JOBS, AND THE ORDER MATTERS

SANDY's unencrypted state is promised to two things: the **ascii43 field run**
(the encryption path in PART C) and the **BitLocker recovery-key VERIFY
measurement**. **Encrypting it once satisfies both, but only in one order.**

**Run ascii43 first, and take the recovery-key measurement on the same enable.**
Reverse the order and the field run loses the unencrypted starting state, which
cannot be recovered without decrypting the drive again.

**A second reason to run ascii43 first:** SANDY is the only machine with the
931 GB `D:`, and F4's screen wording is gate-24-blocked until a full scan is
measured covering `D:` there. Same trip.

---

## M-1 -- A PAGE COUNT, IN THE DOCUMENT THAT BANS PAGE COUNTS

**Line 110:** *"The company delivers a finished product for money, and the
writing holds up **over 49 pages**."*

Against its own rules, in the same file:

- **Line 68:** *`"Only X pages"` -- any page count | Changes every revision, and
  the number does not support the claim.*
- **Line 151:** *"**Do not state a page count in any marketing copy.**"*

**Fix:** cut the page count. *"...and the writing holds up."* The sentence is
about the company delivering a finished product; the number adds nothing and
breaks the rule two sections above it.

---

## M-2 -- A COUNTDOWN, WHICH RE-STALES EVERY DAY

**Line 169:** `## 4. LAUNCH -- SEVENTEEN DAYS`
**Line 271:** *"Everything in section 4 depends on it. Seventeen days"*

Written 2026-08-22 against a **2026-09-01** launch, so it was already **ten**
days when Cloud read it, not seventeen.

**Fix, and it is the general one:** state the date, never the interval.
`## 4. LAUNCH -- 2026-09-01` and *"Everything in section 4 depends on it.
Launch is 2026-09-01."* A date cannot go stale; a countdown is wrong the
morning after it is written.

---

## M-3 -- DECISION 3 NEVER CAUGHT UP WITH THE PRICE LOCK

**Decision 3** reads *"Multi-PC licence terms -- Must appear in the listing."*

**Decision 4, four rows below, says the multi-PC rates are settled:** *"$12.99/yr
for 1 PC, locked 2026-08-21, with 3, 5 and 10-PC rates derived."* And the
one-time packs have been final since 2026-06-26 -- $19.99 / $34.99 / $49.99 /
$79.99 (`PricingReconciliation-2026-07-16.md`).

**So the prices are not what is open.** What is open is the **licence terms** --
how many machines one purchase covers, whether it is per-household or
per-person, and what happens when a buyer replaces a PC. Decision 3 should say
that, or it reads as a pricing question that was answered yesterday.

---

## M-4 -- THREE VARIANTS OF ONE APPROVED SENTENCE

| Where | Wording |
|---|---|
| `MarketingPlan` line 54 | **"One-time purchase. Updates are optional."** -- tagged *Anywhere* |
| `MarketingPlan` lines 79, 276, 303 | **"One-time purchase, yours to keep. Annual updates are optional."** -- tagged *the approved replacement* |
| `PricingCopy` line 143 | **"One-time purchase, yours to keep. Annual updates are optional."** |

Two distinct sentences, both marked approved, in the same file. **This is Bill's
call, not a defect Cloud can resolve** -- but the long form is the one the
PricingCopy already uses and the one that names the annual charge, which is the
whole reason the old "No subscription -- ever" line had to go.

**Recommendation: keep the long form everywhere. Delete the line 54 short
form.**

### AND ONE FINDING NEITHER OF US FILED -- THE FALSE CLAIM IS STILL LIVE

`MarketingPlan` line 79 calls **"No subscription -- ever"** *"false as of
2026-08-21 and the highest-priority string on the site."*

**It is still on the site, in the place search engines read:**

`WebSite/GatewayGuard_index-2026-07-21-1625.html` line 17 --
`<meta name="description" content="... One-time purchase, no subscription." />`

A meta description is not body copy, so a body-copy sweep would not have found
it. **It is what Google prints under the search result.** Not fixed here --
`WebSite/` edits go through the website-copy rule and this is customer-facing.
**Say the word and it is a one-line change.**

---

## M-5 -- FIXED

`ProjectNotes-2026-08-09-1435.md` line 1248 was drafted **customer copy** reading
*"$9.99/year -- less than one month of any antivirus subscription."* Now
**$12.99/year**, with a note saying why.

The other `$9.99` figures in that file (lines ~1199, ~1231) are **working
estimates inside a revenue projection**, not customer copy. Left as they are and
capped with a **PRICE SUPERSEDED** banner naming the $12.99 lock -- rewriting
the reasoning would hide how the number was reached, which is the point of a
notes document.

---

## WHAT IS LEFT FOR WHOM

**Bill, and only Bill:**
1. **Read the Advertising ID toggle** on CGDELL -- Settings > Privacy & security
   > General. Ten seconds, and it settles G-1's live half.
2. **M-4** -- confirm the long form and drop the short one.
3. **Whether to fix the meta description** on the index page.

**Cloud:** fold G-1, G-2, G-4, M-1, M-2, M-3 into the next delivery of the two
documents.

**Claude Code:** the meta description on Bill's word; and the F4 SANDY
measurement when the machine is next in front of him.
