<!-- Dated: 2026-08-31 14:39 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# **GATEWAYGUARD -- CRITICAL PATH METHOD (CPM) SCHEDULE**

- **Document Name:** GatewayGuard_CPM_Schedule
- **Revision 8 -- 31-Aug-2026 (14:39 ET)**
- **Last Editor:** Claude Code (CGDELL)
- **Supersedes:** `GatewayGuard_CPM_Schedule-2026-08-02-1201.md` (Rev 7), which
  was computed against **01-Sep** and against **ascii39**. Every float figure in
  it is wrong. **This revision is a full rebaseline, not an edit.**
- **Inputs:** Bill's six task additions (2026-08-31); Cloud's review
  `GatewayGuard_CloudResponse-CPM-2026-08-31-0834.md`; my request
  `GatewayGuard_CloudRequest-CPM-2026-08-30-2200.md`.

---

## **BASELINE**

| | |
|---|---|
| Baseline date | **Mon 31-Aug-2026** |
| Target launch | **Tue 15-Sep-2026** |
| **Working days available** | ***measured:*** **11 full working days** (Mon 31-Aug through Mon 14-Sep), launch on the 12th |
| Current build | **ascii43** -- half built, never frozen, never signed |
| Guide | 1,976 lines; ***measured:*** **29 VERIFY markers**, **25 page-number holes** (4 `page 00` + 21 blank table cells) |
| Website | ***measured:*** **20 files** in `WebSite\html\`. Copy pass done on **zero** |
| Store | **Payout method not connected.** No purchase has ever been made |
| Code-signing cert | DONE -- DigiCert on SafeNet token, valid to 2027-08-16. **Last used 2026-08-14, 17 days ago** |

**Day 0 = Mon 31-Aug.** All ES/EF/LS/LF below are in working days from day 0.
Launch is **day 11**.

```
 0  Mon 31-Aug      6  Mon 07-Sep
 1  Tue 01-Sep      7  Tue 08-Sep
 2  Wed 02-Sep      8  Wed 09-Sep
 3  Thu 03-Sep      9  Thu 10-Sep
 4  Fri 04-Sep     10  Mon 14-Sep
                   11  Tue 15-Sep  *** LAUNCH ***
```

---

## **WHAT CHANGED FROM REVISION 7 -- AND THREE MEASUREMENTS THAT MOVED THE PLAN**

Rev 7 is four weeks and four builds old. Rather than list every difference,
here is what a reader needs to know that Rev 7 could not have said.

**Cloud reviewed my draft thinking and raised ten questions. Five are now
answered from disk. Three of the five change the shape of this schedule.**

### 1. THE CIRCULAR DEPENDENCY DOES NOT EXIST -- and it was the worst thing on the board

Cloud drew a loop: freeze, sign, screenshots, guide layout, page numbers, guide
structure locked, FT-226 fix, **a build change after the freeze**, those
screenshots are now stale, back to screenshots. A loop with a freeze inside it
has no exit.

***measured, `Tool\W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1`, all
19 `GuideRef` values:*** **13 already carry real section names**
(`"Phase 1, Step 2"`, `"Phase 1, Step 6, Part D"`). **Six carry
`"Keep vs. Disable Table"`** -- a table name that does not exist in the guide
under that name.

***measured, `GatewayGuard_GuideRewrite-Draft-2026-08-22-1000.md`:*** all six
destinations **exist in the draft today** -- `## Remote Desktop -- setting 10`
(line 1139), `## Advertising ID -- setting 11` (1175), `## Diagnostic Data --
setting 12` (1198), `## Password required on wake -- setting 17` (1291),
`## Fast Startup -- setting 18` (1337), `## Wake on LAN -- setting 19` (1356).
The quick-reference table is at line 283 under the heading
`## Quick-reference table`.

**So the mechanism already does the right thing and always did.** The FT-226
fix is **six string replacements to section names that exist right now**. It
carries **no pagination dependency, no guide lock, and no
build-change-after-freeze.** It has been parked behind a guide lock it never
needed.

**Task T-226 below: 0.1 days, no predecessors. It is the cheapest item on this
plan and it deletes the only loop in the network.**

### 2. THE 29 VERIFY MARKERS ARE NOT COSMETIC -- Cloud's objection stands

Cloud said this was the highest-value check on its list, and that its whole Q1
argument collapsed if the markers turned out cosmetic. **They are not.**

***measured, 29 occurrences:*** they are factual claims about Windows
behaviour -- BitLocker key escrow into a Microsoft account (lines 494, 503,
517); local-account password reset having no path and no support line (582,
602, 624, 633, 636); a PIN not requiring a Microsoft account (624); Find My
Device (659); Edge settings paths (786); Remote Desktop, written with **no v9
source at all** (1159); diagnostic data (1206, 1213, 1224); and **sleep versus
hibernate and the BitLocker recovery-key prompt (1316, 1320, 1323)**.

***sourced, the guide's own line 178:*** *"None has been measured."*
***sourced, its own line 1963:*** *"Measure every VERIFY claim on live Windows
11, both the local-account and Microsoft-account cases. BitLocker recovery key
and sleep-versus-hibernate first -- those two can cost a reader their files."*

**Cloud's central point survives: the Guide is the worse truth-telling risk,
not the lesser one.** A wrong tool line is written into a log somebody can
read. A wrong guide line is acted on by a senior with no record at all.

**But the work is smaller than Cloud feared, because most of it is not Bill's.**
A claim about what a registry key or a Windows dialog does is measurable here,
on this machine. Only the Microsoft-account states and the Home-edition cases
need Bill and SANDY. **T-VF1 splits the 29 on exactly that line before any
measuring starts.**

### 3. THE BUILD-ID TRAP IS REAL BUT SMALL

Cloud warned that if the build ID renders on a photographed screen, one build
increment invalidates the whole screenshot set.

***measured, `$BuildID` renders on exactly two screens:*** **SCREEN-84**, the
"about this run" screen (line 2639), and **SCREEN-87**, the console-font screen
(line 3263), which also prints the **script filename** -- and the filename
carries the build ID too. Line 1711 is the **log header**, not a screen.

**Neither is a setting screen.** The 19 setting screenshots are unaffected by a
build increment. Only a photograph of the opening font screen or the
about-this-run screen would be stamped. **Mitigation: do not photograph
SCREEN-84 or SCREEN-87, or crop those two lines.** No freeze constraint is
needed for this. Cost: zero.

### 4. THE GUIDE EMBEDS NO SCREENSHOTS -- so it really is build-independent

***measured:*** **zero** image references and **zero** occurrences of the word
"screenshot" in the 1,976-line draft. The 19 screenshots are a **website**
deliverable, not a guide deliverable.

**Combined with finding 1, the split launch is structurally clean:** with T-226
done, nothing the Guide needs waits on the build, and nothing the build needs
waits on the Guide.

### 5. CORRECTIONS ARE FREE UNDER THE LICENCE -- Cloud's Q4 confirmed

Cloud flagged that it had read this from a **superseded** file and asked for it
to be confirmed. ***measured, `GatewayGuard_License-2026-08-25-1400-TEXT.md`,
line 84:*** *"If we issue a correction to the version you bought -- a fix for a
defect, not a new annual version -- you are licensed to run it, at no charge."*

**Confirmed.** So deferring the F6 wording block "to the annual update" earns
nothing -- it would ship free regardless. **F6's timing is a pure scheduling
call with no revenue attached**, which is a simpler question than the one we
were asking.

### 6. FT-242 IS A CLASS, NOT A DEFECT -- Cloud is right, and it changes ascii44's scope

***measured, FT-245:*** three distinct silent-error sites, not one -- line 5946
(status read, every run), 6394 (guarded write, benign noise), and **6472 (the
Widgets write, and the only place where the error line is the sole evidence
that a change failed)**. Add FT-203 (both scheduled tasks report `[GOOD]` and
never run on battery) and FT-188 (four `[ERROR]` lines on a clean run where
nothing is wrong).

**The log fails to correspond to reality in both directions.** Cloud's proposed
gate is adopted as **T-GATE**: `Run-LogTruthCheck.bat`, asserting that every
`$result = "... GOOD"` in `Apply-Setting` is preceded by a write carrying
`-EA Stop`, run as a ratchet from a baseline of 8. Zero Bill-hours. **It goes
in before ascii44, not after** -- the previous three instances of this class
were fixed by hand and reviewed by hand, which is how the fourth got through.

---

## **THE STRATEGIC RECOMMENDATION**

**SPLIT THE LAUNCH. The Guide ships Tue 15-Sep. Checkup ships on a stated date
after it.**

I recommended this in the request; Cloud agreed but attached a condition; the
measurements above let me put a firmer version of it than either of us had.

**Why, in the order the reasons actually weigh:**

1. **A single-chain plan with a one-way door in it has no float anywhere.**
   This is Cloud's strongest argument and it is better than the marketing ones
   I gave. Everything after the SANDY field run waits on it, and the run cannot
   be repeated once SANDY is encrypted. A three-day slip at the field run is a
   three-day slip at launch, with nothing to absorb it. **The split creates a
   second, independent arm -- that is what it is for.**
2. **The build carries roughly 50 open items and has never been frozen.**
   ***measured:*** ascii41's run produced 38 findings, ascii42's produced 32,
   ascii43's produced about 47. A build carrying that much change generates
   more on its next run. Forcing a freeze on it against a countdown is how the
   FT-242 class got in.
3. **The checkout has never been rehearsed, and it can be rehearsed on the
   quiet product.** A PDF generates almost no support email; a security tool on
   unknown PCs generates a lot.
4. **It removes the pressure to ship a tool whose log can currently claim a
   change it did not make.**

**The condition, and it is Cloud's and I agree with it: the 29 VERIFY markers
must close first.** If they cannot close in the window, **do not ship either
half on 15-Sep** -- move the date rather than put unverified security advice in
front of seniors. That is the same principle that says the eight registry
writes cannot ship, pointed at our own document instead of at the build.

**The go/no-go gate is T-VF4, and it lands on day 4.** That leaves six working
days of visible warning before launch day.

### The pricing problem Cloud raised, and the answer

Under a split, a customer who buys the Guide on 15-Sep and Checkup in October
pays **$32.98**. A customer who waits for the bundle pays **$29.99**. **Your
earliest supporters would pay a $2.99 premium for being early.**

**Recommendation: list the bundle only when both products ship, and give every
Guide buyer a Gumroad discount code for $17.00 off Checkup at Checkup's
launch.** The arithmetic lands them at $29.99 exactly, it costs nothing today,
and it turns the split from something to apologise for into a reason to buy
early. **It is impossible to retrofit once money has moved**, so it is decided
before the store opens, not after. It is task **T-GR2**.

---

## **THE SIX TASKS BILL ADDED, 2026-08-31**

Every one is in the table below with an ID. The mapping is stated here so
nothing is quietly dropped.

| Bill's item | CPM ID | Task |
|---|---|---|
| **2a** | **T-WR1 / T-WR2 / T-WR3** | Review task for `WebSite\html\` -- ***measured, 20 files*** |
| **2b** | **T-GR1 / T-GR2** | Setup task for Gumroad's two products -- Checkup and the Guide |
| **2c** | **T-LZ1 / T-LZ2 / T-LZ3** | Bill reviews the consult questions; the LegalZoom consult; final EULA edits |
| **2d** | **T-PAY1 / T-PAY2 / T-PAY3** | Research Gumroad's payment processing, and wire it into the website and Gumroad so sales can occur |
| **2e** | **T-RS** | ascii43 test-results research conducted |
| **2f** | **T-RR** | Response to the ascii43 test results, with recommendations based on that research |

---

## **TASK TABLE**

Working days from day 0 (Mon 31-Aug). **B** = Bill at the keyboard.
**C** = Claude Code. A star marks the critical path to the 15-Sep Guide launch.

| **ID** | **Task** | **Who** | **Dur** | **Pred.** | **ES** | **EF** | **LS** | **LF** | **Float** |
|---|---|---|---|---|---|---|---|---|---|
| **LEGAL AND STORE -- Bill's 2b, 2c, 2d** | | | | | | | | | |
| T-LZ1 | **Bill reviews the 10 consult questions** -- `AttorneyConsult2-Revised-RefundAndGumroad-2026-08-25-1010.md` | B | 0.25 | -- | 0 | 0.25 | 0 | 0.25 | **0 (CRITICAL)** |
| T-LZ2 | **LegalZoom consult -- book and hold** | B | **3-10** | T-LZ1 | 0.25 | 3.25-10.25 | 0.25 | 3.25-10.25 | **0 (CRITICAL) LONGEST POLE** |
| T-LZ3 | Final EULA edits from the consult answers | C+B | 0.5 | T-LZ2 | 3.25 | 3.75 | 8.75 | 9.25 | 5.5 |
| T-PAY1 | **Research Gumroad payment processing** -- payout, fees, tax handling, file delivery, receipts, refund mechanics | C | 0.5 | -- | 0 | 0.5 | 1.5 | 2.0 | 1.5 |
| T-PAY2 | **Bill connects the payout method** -- ***nothing publishes until this is done*** | B | 0.15 | T-PAY1 | 0.5 | 0.65 | 2.0 | 2.15 | 1.5 |
| T-GR1 | **Gumroad: set up both products** -- name, URL slug, description, pricing, **refund toggle twice** (***measured: it is per-product, not account-wide***). Copy already written in `GumroadListings-2026-08-25-0015.md` | B | 0.25 | T-PAY2 | 0.65 | 0.9 | 2.15 | 2.4 | 1.5 |
| T-GR2 | **Decide and build the early-buyer bundle credit** -- a $17.00 code for Guide buyers | B+C | 0.15 | T-GR1 | 0.9 | 1.05 | 2.4 | 2.55 | 1.5 |
| T-PAY3 | **Wire checkout into the website** -- buy links, file delivery, receipt text, EULA link | C+B | 0.5 | T-GR2, T-LZ3 | 3.75 | 4.25 | 9.25 | 9.75 | 5.5 |
| T-TP | **Test purchase with a real card, then refund it** | B | 0.15 | T-PAY3 | 4.25 | 4.4 | 9.75 | 9.9 | 5.5 |
| **THE GUIDE -- the 15-Sep product** | | | | | | | | | |
| T-VF1 | **Triage the 29 VERIFY markers** -- split into Claude-measurable and Bill-only | C | 0.25 | -- | 0 | 0.25 | 0.5 | 0.75 | 0.5 |
| T-VF2 | Measure the Claude-measurable subset on CGDELL | C | 1.0 | T-VF1 | 0.25 | 1.25 | 0.75 | 1.75 | 0.5 |
| T-VF3 | **Measure the Bill-only subset** -- Microsoft-account states, Home edition on SANDY | B | 0.3 | T-VF1 | 0.25 | 0.55 | 1.45 | 1.75 | 1.2 |
| T-VF4 | **Apply the answers; remove all 29 markers.** *** GO / NO-GO GATE *** | C | 0.5 | T-VF2, T-VF3 | 1.25 | 1.75 | 1.75 | 2.25 | 0.5 |
| T-GPG | **Fill 25 page-number holes** -- 4 in running text, 21 table cells, at export | C | 0.5 | T-VF4 | 1.75 | 2.25 | 2.25 | 2.75 | 0.5 |
| T-GA | **Bill reads and approves the guide, 1,976 lines** -- ***4-6 h, one contiguous block*** | B | **0.75** | T-GPG | 2.25 | 3.0 | 2.75 | 3.5 | 0.5 |
| T-GX | Export the guide -- PDF, all five print sizes | C | 0.5 | T-GA | 3.0 | 3.5 | 3.5 | 4.0 | 0.5 |
| **WEBSITE -- Bill's 2a** | | | | | | | | | |
| T-WR1 | **Bill picks the item-2 phrasing** -- three options in `HtmlWebsiteReview-2026-08-22-2220.md`; **option 2 recommended.** *The cheapest unblock on the board* | B | 0.1 | -- | 0 | 0.1 | 4.4 | 4.5 | 4.4 |
| T-WR2 | **Copy pass, 19 pages** -- items 2, 3, 6, 8, 13, 18, 19, 21. Done on zero so far | C | 1.5 | T-WR1 | 0.1 | 1.6 | 4.5 | 6.0 | 4.4 |
| T-WPR | **Fix the pricing page's false claim** -- it says the annual update *"scans your drives again"*; ***measured against ascii43: Checkup reads `C:` only*** | C | 0.25 | -- | 0 | 0.25 | 5.75 | 6.0 | 5.75 |
| T-WR3 | **Bill reviews `WebSite\html\` -- all 20 files** | B | 0.25 | T-WR2, T-WPR | 1.6 | 1.85 | 6.0 | 6.25 | 4.4 |
| T-WQA | Site QA -- links, nav, buy buttons, download, hash placeholder, mobile | C+B | 0.5 | T-WR3, T-PAY3 | 4.25 | 4.75 | 6.25 | 6.75 | 2.0 |
| **LAUNCH -- the Guide** | | | | | | | | | |
| T-GO1 | **GUIDE LAUNCH -- Tue 15-Sep** | B | 0 | T-GX, T-TP, T-WQA | 4.75 | 4.75 | 11 | 11 | **6.25** |
| **BUILD -- ascii44, off the 15-Sep path -- Bill's 2e, 2f** | | | | | | | | | |
| T-RS | **ascii43 test-results research** -- Bill's 20-point list from his field notes | C | 1.5 | -- | 0 | 1.5 | -- | -- | *post-15-Sep* |
| T-RR | **Response to the ascii43 results, with recommendations from that research** | C | 0.5 | T-RS | 1.5 | 2.0 | -- | -- | *post-15-Sep* |
| T-BD | **Bill's decisions from T-RR** -- `X` for Exit; **is Malwarebytes in the product at all**; screen-12 drive order | B | 0.15 | T-RR | 2.0 | 2.15 | -- | -- | *post-15-Sep* |
| T-226 | **Fix the six `GuideRef` values to real section names** -- unblocked, see finding 1 | C | 0.1 | -- | 0 | 0.1 | -- | -- | *any time* |
| T-GATE | **Build `Run-LogTruthCheck.bat`** -- the FT-242 class gate, ratchet from 8 | C | 0.5 | -- | 0 | 0.5 | -- | -- | *before T-44* |
| T-TOK | **Test the SafeNet token; confirm the PIN is recorded off-machine** | B | 0.05 | -- | 0 | 0.05 | -- | -- | **DO IT THIS WEEK** |
| T-SL | **Enumerate what still needs SANDY unencrypted** -- write the list before the run, not after | C+B | 0.25 | -- | 0 | 0.25 | -- | -- | *before T-ENC* |
| T-44 | **Build ascii44** -- FT-242 with FT-203, FT-188 and FT-245; FT-244; FT-243; the B-for-Back pass; F4 second drive; the load-bearing half of F6 | C | 3.0 | T-BD, T-GATE, T-226 | 2.15 | 5.15 | -- | -- | |
| T-44T | **Field-run ascii44 on SANDY** -- ***4-6 h, one contiguous block*** | B | 0.75 | T-44, T-SL | 5.15 | 5.9 | -- | -- | |
| T-44R | **Triage what the run produces** -- ***the term that was missing: 3-6 Bill-hours*** | B+C | 0.75 | T-44T | 5.9 | 6.65 | -- | -- | |
| T-ENC | **SANDY encryption and timing capture -- ONE-WAY DOOR** | B | 0.15 | T-44T, T-SL | 5.9 | 6.05 | -- | -- | |
| T-FRZ | **FEATURE FREEZE** | B | 0 | T-44R | 6.65 | 6.65 | -- | -- | |
| T-SN | Sign the release build | B | 0.15 | T-FRZ, T-TOK | 6.65 | 6.8 | -- | -- | |
| T-SC | SmartScreen smoke test | B | 0.1 | T-SN | 6.8 | 6.9 | -- | -- | |
| T-SS | **19 screenshots from the signed build** -- ***10-14 h, at least two full passes*** | B | **1.75** | T-SN | 6.8 | 8.55 | -- | -- | |
| T-CQA | Final integration QA -- Checkup against the website, all three machines | C+B | 0.5 | T-SC, T-SS | 8.55 | 9.05 | -- | -- | |
| T-GO2 | **CHECKUP LAUNCH -- a stated date after 15-Sep** | B | 0 | T-CQA | 9.05 | 9.05 | -- | -- | |
| **RUNNING** | | | | | | | | | |
| T-SUP | **Launch-week support inbox** -- 30 min/day for 10 days = **5 Bill-hours, previously unbudgeted** | B | 0.6 | T-GO1 | 11 | -- | -- | -- | *from launch* |

---

## **CRITICAL PATH**

```
  T-LZ1   Bill reviews the consult questions      0.25 d
    |
    v
  T-LZ2   LEGALZOOM CONSULT                       3-10 d   <-- the whole plan turns on this
    |
    v
  T-LZ3   Final EULA edits                        0.5 d
    |
    v
  T-PAY3  Wire checkout into the website          0.5 d
    |
    v
  T-TP    Test purchase, then refund it           0.15 d
    |
    v
  T-GO1   GUIDE LAUNCH -- Tue 15-Sep
```

**Critical path length: 4.4 working days if the consult clears in 3;
11.4 working days if it takes 10.**

| Consult turnaround | Path length | Float to 15-Sep |
|---|---|---|
| 3 business days | 4.4 d | **+6.6 d -- comfortable** |
| 5 business days | 6.4 d | **+4.6 d -- workable** |
| 8 business days | 9.4 d | **+1.6 d -- no room for anything** |
| 10 business days | 11.4 d | **-0.4 d -- THE DATE IS GONE** |

**This is the entire schedule risk in one table, and it is the thing Cloud
caught that I had missed.** ***Its words, and they are exactly right:*** *"This
is the payout-method failure repeating. It is not a task, so it is not on a
task list."*

**The Guide arm finishes on day 3.5. The website arm finishes on day 4.75.
Neither is close to binding.** The product is not what threatens the date. **The
consult is.**

---

## **THE ONE DECISION I NEED FROM BILL, AND IT IS WORTH REAL MONEY**

**Does the LegalZoom consult gate the launch, or follow it?**

**The case for it not gating:** ***sourced, the briefing:*** the refund policy
is **already decided** -- 30 days, no questions asked -- and it is recorded
there that this *"was the ONLY genuine store-opening blocker."* The decision is
made. The consult **reviews** that decision; it does not create it. The licence
exists at v2.4 and is complete enough to sell under.

**The case for it gating:** it covers the refund policy and the Gumroad terms,
it is the document a customer is bound by, and finding out afterwards that a
clause is wrong means amending terms people have already accepted.

**My recommendation: launch on the decided policy, and treat the consult as a
fast-follow.** That converts the top row of the critical path from a 3-to-10
day unknown into float, and it makes the plan robust instead of hostage to a
third party's calendar.

**What it costs if I am wrong:** an amended EULA published after some customers
have bought under the old one, and the Gumroad refund settings possibly changed
once. **Recoverable, and cheap at the volumes involved in launch week.**

**Either way, T-LZ1 and booking T-LZ2 should happen today** -- if the consult
turns out to be quick, the question never has to be answered at all.

---

## **BILL-HOURS -- THE UNIT, REBUILT**

Cloud's central correction: my 17-23 hours had no rework term and treated the
hours as fungible. Both are fixed here.

| # | Task | Hours | Confidence |
|---|---|---|---|
| 1 | Review the 10 consult questions | 2 | high |
| 2 | The LegalZoom consult itself | 1 | high |
| 3 | Connect payout; set up 2 products; 2 refund toggles; bundle credit | 1.5 | high |
| 4 | Test purchase and refund | 1 | high |
| 5 | Measure the Bill-only VERIFY claims | 2.5 | medium |
| 6 | **Read and approve the guide -- one contiguous block** | **4-6** | low |
| 7 | Pick the website phrasing; review all 20 `html` files | 2.5 | medium |
| 8 | Site QA with the buy buttons live | 1.5 | medium |
| 9 | Test the token | 0.5 | high |
| | **SUBTOTAL TO THE GUIDE LAUNCH** | **16.5-18.5** | |
| 10 | Decisions from the ascii43 research response | 1.5 | high |
| 11 | **Field-run ascii44 on SANDY -- one contiguous block** | **4-6** | low |
| 12 | **Triage what that run produces** -- ***the missing term. 30-47 findings, every time*** | **3-6** | low |
| 13 | SANDY encryption | 1 + overnight | medium |
| 14 | Sign; SmartScreen | 1 | medium |
| 15 | **19 screenshots -- at least two full passes** | **10-14** | **lowest** |
| 16 | Final integration QA | 1.5 | medium |
| 17 | **Launch-week support inbox** -- 30 min/day for 10 days | **5** | medium |
| | **TOTAL, BOTH LAUNCHES** | **44.5-56.5** | |

**Cloud's number was 30-40 and it was closer than mine.** The difference is
support, and the second field run's triage.

**But the total is the wrong question, and this is Cloud's best point in the
whole review.** Three tasks cannot be done in 90-minute slices -- the guide
read, the field run, and the screenshots. Splitting them loses the machine
state, or loses the thread that makes the review worth doing.

> **The question is not "does Bill have 45 hours." It is "does Bill have four
> or five clear full days between now and 15 September?"**

**16.5 to 18.5 hours to get the Guide out is about three clear days.** That is
the number that matters for the date on the table, and it is achievable.

---

## **RISK FLAGS**

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| **LegalZoom turnaround exceeds 8 business days** | **Unknown -- unstarted** | **HIGH -- takes the date** | Book today. Decide the gating question above |
| **The 29 VERIFY markers do not close** | Medium | **HIGH -- no-go on both halves** | T-VF1 triages them on day 0; the gate lands day 4, six days of warning |
| **SafeNet token locked, or the PIN lost** | Low | **SEVERE -- reissue is a multi-week path** | T-TOK this week. ***Not measured: this token's lockout policy*** |
| **Payout method blocks publishing** | **Certain today** | HIGH | T-PAY2. It is fifteen minutes and it is not done |
| **ascii44's field run produces 30-47 findings** | **Certain -- it has three times running** | Medium | T-44R budgets 3-6 h. It is off the 15-Sep path, which is the point of the split |
| **SANDY encrypted before something needed it unencrypted** | Medium | **IRREVERSIBLE** | T-SL writes the list first. **This is the only genuinely one-way item on the plan** |
| **Screenshots take 14 h, not 5** | **Likely** | Medium | Off the 15-Sep path. Do not photograph SCREEN-84 or SCREEN-87 |
| **Early Guide buyers pay $32.98 against the $29.99 bundle** | Certain, if unaddressed | Medium -- goodwill | T-GR2. **Impossible to retrofit once money moves** |
| **A ninth instance of the FT-242 class** | Medium | HIGH | T-GATE. Four instances across four builds were each fixed by hand and reviewed by hand |
| **Launch-week support swamps Bill** | Medium | Medium | 5 h budgeted. A PDF generates far less than a security tool -- another reason the Guide goes first |

---

## **IMMEDIATE NEXT ACTIONS -- Mon 31-Aug and Tue 01-Sep**

| # | Action | Owner | Unblocks | Cost |
|---|---|---|---|---|
| 1 | **Review the 10 consult questions and book LegalZoom** | **Bill** | **The entire critical path** | 2 h |
| 2 | **Connect the Gumroad payout method** | **Bill** | Everything commercial. Nothing publishes without it | 15 min |
| 3 | **Plug in the SafeNet token and confirm it reads** | **Bill** | Removes the only unrecoverable infrastructure risk | 30 min |
| 4 | **Pick the website phrasing -- option 2 recommended** | **Bill** | 19 pages of held copy work | 5 min |
| 5 | Triage the 29 VERIFY markers into who measures each | Claude Code | The go/no-go gate | -- |
| 6 | Fix the six `GuideRef` values | Claude Code | Deletes the loop | -- |
| 7 | Research Gumroad payment processing | Claude Code | T-PAY2, T-GR1 | -- |
| 8 | Start the ascii43 research -- Bill's 20-point list | Claude Code | T-RR, and then ascii44 | -- |

**Items 1 to 4 are two hours and fifty minutes of Bill's time, and they unblock
everything else on this page.** Nothing else he does this week is worth more
than those four.

---

## **OPEN DECISIONS**

| # | Decision | Note |
|---|---|---|
| 1 | **Does the consult gate the launch?** | The one that matters. Recommendation above |
| 2 | **Is Malwarebytes in the product at all?** | Bill's own research list asks it. It touches pricing, the licence, the guide and four screens. **Feeds T-44** |
| 3 | `X` for Exit at screens 14a and 18 | The 11 `N = Exit` sites wait on it. **Not folded into the B-for-Back pass** -- one key at a time |
| 4 | Screen 12 drive order -- reverse it so the SSD is Drive 1 | Bill's field note |
| 5 | **Checkup's launch date** | Stated publicly when the Guide launches, or held back |
| 6 | Bundle listed now, or held until both ship | T-GR2 recommends held, with a $17.00 credit |

---

## **WHAT I STILL CANNOT VERIFY -- BILL TO CONFIRM**

| # | Item | Why it matters |
|---|---|---|
| 1 | **Has the LegalZoom consult been booked or sent?** | ***Not measured.*** The document is written and ready. Nothing in the repository says it went out. **It is the top of the critical path** |
| 2 | **Does the SafeNet token still read, and is the PIN recorded off-machine?** | ***Last verified use 2026-08-14.*** A reissue would end the date on its own |
| 3 | **How many clear full days does Bill have before 15-Sep?** | Three tasks cannot be sliced. **A better input to this plan than any estimate either Claude can produce** |
| 4 | **Is the Guide commercially standalone**, or does it read as a manual for a product nobody can buy yet? | Cloud could not judge it without reading it. I cannot judge it for a buyer |

---

## **DECISIONS LOGGED THIS REVISION**

**DECISION (31-Aug-2026):** **The FT-226 circular dependency does not exist.**
***Measured:*** `GuideRef` carries section names, 13 of 19 already correct, and
all six broken destinations exist in the current draft. The fix is six string
replacements with no guide lock and no post-freeze build change. **T-226 is
0.1 days and has no predecessors.**

**DECISION (31-Aug-2026):** **The 29 VERIFY markers are a go/no-go gate on the
Guide launch.** ***Measured:*** they are unmeasured factual claims about
Windows behaviour, two of which can cost a reader their files. If they do not
close, neither half ships on 15-Sep.

**DECISION (31-Aug-2026):** **`Run-LogTruthCheck.bat` is built before ascii44,
not after.** FT-242, FT-203, FT-162 and FT-188 are four instances of one class
across four builds, each caught by review after shipping. ***Sourced, the
briefing:*** *"Every rule that held on 2026-08-13 had machinery. Every rule
broken was one someone had to remember."*

**DECISION (31-Aug-2026):** **F6's deferral carries no revenue.** ***Measured,
licence line 84:*** corrections ship free. The load-bearing half of F6 --
permission-naming, the screen-22 pointer that names no destination, and the
why-these-steps explanations -- goes into ascii44. Column geometry and
screen-length complaints defer freely.

**DECISION (31-Aug-2026):** **Do not photograph SCREEN-84 or SCREEN-87.**
***Measured:*** they are the only two screens carrying the build ID. Excluding
them means a build increment cannot invalidate the screenshot set, and no
freeze constraint is needed to protect it.

**Revision history:** Rev 1-3 (pre-Dell to ascii22), Rev 4 (15-Jul, ascii31),
Rev 5 (24-Jul, ascii33), Rev 6 (30-Jul, ascii39), Rev 7 (02-Aug, ascii39, built
against 01-Sep), **Rev 8 (31-Aug, ascii43, rebaselined to 15-Sep, split launch,
Bill's six tasks added, Cloud's review folded in).**
