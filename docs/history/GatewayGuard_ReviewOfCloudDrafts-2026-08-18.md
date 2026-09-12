<!-- Dated: 2026-08-18 03:10 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Review of Cloud's two drafts — the Guide rewrite and the Marketing Plan

- **Document Name:** GatewayGuard_ReviewOfCloudDrafts
- **Last Modified:** 2026-08-18 03:10 ET
- **Last Editor:** Claude Code (CGDELL)
- **Reviewing:** `GatewayGuard_GuideRewrite-Draft-2026-08-15-1838.md` (1,471 lines)
  and `GatewayGuard_MarketingPlan-2026-08-15-1838.md`
- **Requested by Bill 2026-08-18**, including a specific question about moving
  the front-of-guide help section to an addendum.

---

## PART 1 — BILL'S QUESTION: MOVE THE HELP SECTION TO THE BACK?

**Bill:** *"If they have the guide they have purchased it and are looking to do
the work, not be warned about a lot of scary things."*

**He is right about roughly 32 of the 37 lines, and wrong about about 5.**
The section should be split, not moved whole.

### The strongest argument for Bill's position is inside Cloud's own other document

**The Marketing Plan, section 5, channel 2:**

> *"Avoid fear. This audience is already frightened, and frightening them
> further is how they end up on the phone with the scammer."*

**The Guide opens with 37 lines of fear** — money missing, ransomware,
compromised email, stalking — before the reader checks a single setting. **The
two documents Bill asked me to review disagree with each other**, and the
marketing plan has the better of it, because it names the actual failure mode:
a frightened senior is a senior who calls the number in the pop-up.

**Three more reasons it belongs at the back:**

1. **Most readers match none of the five conditions.** The majority reads a
   page of alarm that does not apply to them, before any payoff.
2. **It delays the first win.** Step 1 is Windows Update — two minutes, visibly
   successful, and it teaches the reader that this is manageable. That is the
   moment that gets someone to Step 2. Nothing should stand in front of it.
3. **The buyer has already decided.** Front-loaded danger is a tactic for the
   undecided. This reader has paid. What they need first is competence, not
   caution.

### What must stay at the front, and it is short

**Three of the five items are not "when to ask for help". They are
"do not start this guide at all".** They have to arrive before the reader
acts, because acting is the harm:

- **Files renamed and a ransom demanded** — *"do not restart the computer"* is
  useless after they have restarted the computer.
- **This is a work computer** — telling IT afterwards is not telling IT.
- **Money missing from a bank or card** — calling the bank is more urgent than
  any setting in the book, and it is time-sensitive.

**Five lines, framed as a gate rather than a warning.** Something like: *"Three
situations mean this guide is not your next step. If any is true, do that
instead and come back after."* Then the pointer to the full section at the
back.

**The other two — compromised email, and stalking/abuse — belong at the
back.** Both need considered reading rather than a glance, and neither is made
worse by being read an hour later. The stalkerware guidance in particular
deserves more room than a bullet, and it will get it in an addendum.

### Also keep at the front: "The one rule that matters most"

**Not a warning — an operating instruction**, and it governs the reader's
behaviour for the whole hour: *do not delete what you do not recognise, write
it down, keep going.* It is short, calm, and it prevents the single most
expensive mistake a reader can make. It stays.

### One dependency that breaks if this moves

**Line 141:** *"take your list to the When to ask for help section near the
front of this guide."* Move the section and that sentence is wrong. There is
also line 148, *"This section is near the front on purpose,"* which becomes
self-contradicting. **Both need editing in the same pass as the move** — this
is the FT-172 lesson in prose: a pointer that lies is worse than no pointer.

---

## PART 2 — THE GUIDE, EVERYTHING ELSE

### The draft is in good shape, and this is measured rather than impression

**Copy rules — measured 2026-08-18 on the draft:**

| Rule | Result |
|---|---|
| "whether" / "whereas" banned | **1 occurrence**, and it is in Cloud's own note *about* the rule, not in the guide body |
| "switch" as a verb | **0** |
| "turn on/off" — the approved verb | **24** |

**Cloud followed the rules.** That is worth saying plainly, because the
previous website pass had 26 instances of "whether" across 18 pages.

### The most useful thing in the draft: it is right where the TOOL is wrong

**Setting 6, Enhanced Phishing Protection.** The guide places it at:

> Windows Security › App & browser control › Reputation-based protection

**That is Windows, not Edge — and it is correct.** Checkup reads an Edge
registry key for this item, gets blocked by Tamper Protection, and reports
`Unknown`. That is **FT-185**, which I deliberately left out of ascii41 today
because I had no verified replacement read.

**The guide just supplied the place to look.** The setting lives under
Windows Security's reputation-based protection, so the tool is reading the
wrong product entirely. That converts FT-185 from "needs research" to "needs
one verified registry read", and Bill's ascii39 finding 37 — *"no longer
exists in Edge, Edge using windows smartscreen"* — was right all along.

### Cloud's reconciliation work is the strongest part

Twelve corrections taken from the 19 website pages, and **it removed a false
instruction** (Fast Startup does not need a restart; it takes effect at the
next shutdown). It also caught a tone error worth noting: **Wake on LAN is a
choice, not a harden** — the tool ships it unselected, and the draft had said
turn it off. That is the guide being corrected *by* the build, which is RULE
W-07 working in the direction it was designed for.

**It also found a systematic gap honestly:** the guide had no undo
instructions anywhere, while all 19 website pages carry *How to revert it*.

### The two footer items Cloud flagged are the same two in the Marketing Plan

Both documents independently reached *"No subscription — ever"* versus
**$12.99/yr** and the *"source code is included"* phrasing. **They agree, so
this is not a judgment call — it is a live inaccuracy on the site today.**

---

## PART 3 — THE MARKETING PLAN

### What it gets right, and it is most of it

**The licence consequence is named rather than papered over.** *"Nobody can
audit the code before buying... this is a real cost and it should be named."*
That is the correct instinct and it is rare in a marketing document.

**The banned-claims table is the operative part** and it is doing real work.
*"100% Free"* and *"independent tech volunteers"* in existing flyer drafts are
not tone problems, they are false statements about a company selling a
licensed product. **"Retire them rather than patch them"** is right — the
premise is wrong, not the wording.

**Guide-first launch is the right call**, and for the reason given: two
launches produce two moments of attention, one slipped launch produces none.

### Where I would push back — one thing, and it matters

**The plan says the pre-purchase trust argument is gone. It is not gone; it
moved, and the plan does not name where it went.**

There is a **trust ladder** already built and paid for:

| Step | Cost to buyer | What it proves |
|---|---|---|
| 19 free setting pages | free | The explanations are real and plain-English |
| Security Guide | $8.99 | The company delivers what it describes |
| Checkup | $19.99 | — by then already earned |

**A reader who works through the free pages and then buys the $8.99 guide has
audited the company, which is what they actually wanted to audit.** Almost
nobody was ever going to read PowerShell. The plan says this in passing about
the senior audience, then does not carry it into the strategy.

**Recommendation:** state the ladder explicitly in section 3, and price and
sequence the guide as the trust purchase rather than as the first of two
independent products. It changes nothing operationally and it answers the
reviewer question in section 5 better than the current answer does.

### The real blocker in section 7 is decision 2

**Refund policy.** A store cannot open without one, and the plan correctly
notes that a downloaded, readable product makes the usual answer non-obvious.
**Fourteen days.** Decisions 1, 5 and 6 are quick; 3 and 4 can ship after
launch. **This one cannot**, and it is listed alongside them as if it were
peer.

### One task in the guide's closing note is mine, and nobody has scheduled it

Cloud's draft ends with: *"every measurement re-verified by Claude Code."*

**That is roughly 19 settings paths, plus the timings and the greyed-out-box
behaviours, checked against a live Windows 11 machine.** It is real work, it
is on the critical path for a September 1 guide launch, and it currently
appears in no plan. **It should be a scheduled item, not a closing sentence.**

---

## SUMMARY — WHAT I WOULD DO

1. **Split the help section.** Five lines stay as a "do not start" gate; the
   rest becomes the addendum Bill described. Fix lines 141 and 148 in the same
   pass.
2. **Fix the two footer lines** on the live site. Both documents agree they
   are wrong today.
3. **Use the guide to close FT-185** — it names the correct location for
   Enhanced Phishing Protection, which the tool has been reading in the wrong
   product.
4. **Decide the refund policy this week.** It is the only section 7 item that
   genuinely blocks the store.
5. **Schedule the measurement re-verification.** Nineteen settings, on a real
   machine, before the guide ships.
6. **Name the trust ladder** in the marketing plan's positioning section.
