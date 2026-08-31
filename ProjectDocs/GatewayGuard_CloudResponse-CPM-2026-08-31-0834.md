<!-- Dated: 2026-08-31 08:34 ET -->
<!-- Editor: Claude Cloud -->
# Cloud's answer to the CPM request -- where I think the critical path is wrong

- **Document Name:** GatewayGuard_CloudResponse-CPM
- **Last Modified:** 2026-08-31 08:34 ET
- **Last Editor:** Claude Cloud
- **Machine:** CGDELL
- **Status:** RESEARCH AND OPINION. Not a governing document. Amends no rule.
- **Answers:** `GatewayGuard_CloudRequest-CPM-2026-08-30-2200.md`, all six questions
- **Written under:** `GatewayGuard_CloudWorkingRules-2026-08-25-1400.md`

**Session clock note.** Bill gave the session clock as **2026-08-31 08:34 ET** and
that is what names this file. `CURRENT.md` regenerated twice afterwards, at 08:57
and 09:31, so a commit I read is stamped later than this filename. Deliberate, not
drift -- the rule is that the clock Bill gives stands for the session.

---

## PROVENANCE -- WORKING RULES, STEPS 1 TO 5

```
Sync stamp     : Generated 2026-08-31 09:31 ET | 8747a50 | made 2026-08-31 08:58 ET |
                 "CURRENT.md put its rows first, because Cloud could never retrieve them"
                 All 53 rows received, all eight group counts match: 6+4+4+6+9+9+5+10.

Base files     : GatewayGuard_CloudRequest-CPM-2026-08-30-2200.md
                   -- CURRENT.md row "Cloud request". MATCHES.
                   -- reached me TWICE: uploaded by Bill, and via the connector.
                 GatewayGuard_FieldTestTriage-ascii43run2-2026-08-30-1723.md
                   -- CURRENT.md row "Field test triage (latest)", 4 older. MATCHES.
                 GatewayGuard_ResponseToBillsNotes-ascii43-2026-08-30-1815.md
                   -- CURRENT.md row "Response to Bill's field notes", 0 older. MATCHES.

How I read them: CPM request -- IN FULL, from Bill's upload.
                 Both triage documents -- FRAGMENTS ONLY, via connector search.
                 Everything else below -- fragments.

Could not see  : - The guide. I have not opened a single line of
                   GuideRewrite-Draft-2026-08-22-1000.md. Every guide claim below
                   is reasoning about a document I have not read. This is the
                   largest hole in this answer and it lands hardest on Q1 and Q2.
                 - ResponseToBillsNotes: I read the verdict key and items 1-3 of 41.
                   I have NOT read items 4-41.
                 - FieldTestTriage run2: FT-242 in full, FT-243, FT-244 partial,
                   Part 2 section G, Part 3 opening. I have NOT read FT-245 to
                   FT-247, or Parts 2 A-F.
                 - The 29 VERIFY markers. I do not know what they say.
                 - GatewayGuard_CPM_Schedule-2026-08-02-1201.md. Not opened.

CARRIED FORWARD, AND ONE OF THEM IS ON A SUPERSEDED FILE -- flagging under Rule 4:
  "Licence v2.4 grants corrections free."
     Read in GatewayGuard_DecisionsForBill-2026-08-25-1620.md.
     CURRENT.md names -2026-08-26-0302.md as live, with 2 older.
     SO I READ A SUPERSEDED VERSION. Q4 leans on this claim. CONFIRM IT
     against the live file and against licence v2.4 before acting on Q4.
```

---

## THE SHORT VERSION

**Your central claim is right and I am not going to attack it.** The constraint is
Bill-hours. I would go further: it is *contiguous* Bill-hours, which is a scarcer
resource than the total suggests.

**Where I think you are wrong, in order of how much it costs:**

1. **The Guide is not build-independent, and the dependency runs the direction you
   did not check.** Q1.
2. **Your own truth-telling principle disqualifies your own recommendation.** 29
   VERIFY markers in the product you propose to ship first. Q1.
3. **There is a circular dependency ending in a post-freeze build change.** Nobody
   has drawn it. Q5.
4. **FT-242 is a class, not a defect, and you are proposing to fix an instance.** Q3.
5. **The 17-23 hours has no rework term**, and your own data says what the term is. Q6.

---

## Q1 -- SPLIT LAUNCH OR SINGLE LAUNCH ON 15 SEPTEMBER

**Split -- but not the split you proposed, and not for the reason you gave.**

### First, the thing that has to be said

You wrote that eight registry writes **cannot ship** because a security tool that
reports success it did not achieve damages the brand. I agree completely. Then you
recommended shipping, as the lead product, **a guide carrying 29 VERIFY markers.**

***sourced, your own section 1:*** *"1,976 lines written; measured: 29 VERIFY
markers, 21 blank page-number cells."*

**A VERIFY marker is an unverified factual claim about what Windows does.** Apply
your own test to it:

| | FT-242 | An unverified guide instruction |
|---|---|---|
| What goes wrong | A log line says GOOD when the write was refused | A reader changes a real setting on a real PC |
| Is there a record | Yes -- the log, and a SILENT ERROR line | **No. Nothing is logged. Nobody knows.** |
| Who can catch it | Support, reading the log | **Nobody** |
| Reversible | The setting is unchanged; only the report is wrong | The setting IS changed, possibly wrongly |

**The guide is the worse truth-telling risk, not the lesser one.** The tool at
least writes down what it did. A guide is advice a person acts on manually with no
record at all, and Checkup's audience is non-technical seniors who will not
second-guess it.

**So the split as proposed ships the product with the weaker verification story
first.** I do not think you saw this, because you costed the guide as a *reading*
task -- item 6, "read and approve the guide, 4-6 h" -- and 29 VERIFY markers is
not a reading task. It is a measurement task, on live Windows 11 hardware, and it
is not on your list anywhere.

**Basis: inferred**, and the inference rests on VERIFY meaning what it means
elsewhere in this project. **I have not read the guide.** If most of the 29 are
cosmetic -- cross-references, page numbers, formatting -- this whole argument
collapses and you should say so. **That is the single fact that would change my
mind, and it is one grep away from you and unreachable from me.**

### Second, the dependency you did not check

You wrote: *"No build dependency, no screenshots, no signing, no field run."*

**The dependency runs guide-to-build, not build-to-guide.**

***sourced, `GatewayGuard_FieldChecklist-ascii43-2026-08-22.md`, PART A item 2:***
settings **10, 11, 12, 17, 18 and 19** all carry `GuideRef="Keep vs. Disable
Table"`, which is not a page. The fix is **deferred until the guide structure is
LOCKED**, because setting 17 already moved between sections in one draft revision
and setting 10 has no section at all.

**So locking the guide is a precondition for a build fix.** Ship the guide on 15
September and you have locked its structure -- which unblocks the FT-226 class fix,
which is a change to six settings' on-screen strings, **which lands after the
freeze.** More on this in Q5, where it closes into a loop.

### Third, a pricing problem nobody has raised

***sourced, project pricing:*** Guide $12.99 once, Checkup $19.99 once, bundle
$29.99 once.

Under the split, a customer who buys the Guide on 15 September and Checkup in
October pays **$32.98**. A customer who waits for the bundle pays **$29.99**.
**Your earliest supporters pay a $2.99 premium for being early.**

That needs a decision before the Guide goes on sale, not after:

- Retroactive bundle credit for Guide buyers? (Gumroad discount codes; workable)
- Bundle unlisted until both products ship? (Simplest; costs the bundle's
  conversion advantage on the biggest traffic day)
- Guide buyers get a code for $17.00 off Checkup? (Arithmetic works; needs a
  mechanism to deliver it)

**None is hard. All of them are impossible to retrofit once money has moved.**

### What I actually recommend

**Split, with the Guide as the 15 September product -- conditional on closing all
29 VERIFY markers first.** If they cannot be closed in the window, **do not ship
either half on 15 September**; move the date rather than ship unverified security
advice to seniors.

**Two things the split buys that you undersold:**

1. **The checkout gets rehearsed with a product that has no support burden.** A PDF
   generates almost no support email. A security tool on 200 unknown PCs generates a
   lot. Rehearsing the store on the quiet product is worth more than you claimed.
2. **It converts a hard deadline into a soft one for the build.** That is the whole
   value, and it is real.

**What would change my mind:** the 29 markers being cosmetic; or evidence that the
Guide does not stand alone commercially and reads as a manual for a product nobody
can buy. I cannot judge the second without reading it.

---

## Q2 -- WHAT DO 19 SCREENSHOTS ACTUALLY COST

**Your 3-5 hours is low by roughly a factor of three. I would plan 10-14 hours
across at least two sessions, and the variance is enormous.**

**Basis: inferred.** Nobody here has done it, including me. Here is the
decomposition so you can attack the parts rather than the number.

| Component | Estimate | Why |
|---|---|---|
| One-time setup -- clean state, 175 columns, consistent theme, capture tool | **0.5-1 h** | Every shot must match or the guide looks amateur |
| **Branch traversal** | **2-4 h** | See below. This is the part your estimate omits |
| Capture, crop, name, file -- 19 shots | **2.5-4 h** | 8-13 min each once you are at the screen |
| **Retakes** | **3-5 h** | See below. This is the other part |
| Insertion and layout into the guide | **1.5-2 h** | 21 page-number cells depend on it |

### Branch traversal is the cost you did not see

**Checkup is a sequential program.** You cannot jump to setting 14; you walk
screens 1 through 13 to reach it. Worse, **some screens exist only on some
branches.**

***measured, your own FT-243:*** the log notice sits inside
`Show-BitLockerFinalDecline` -- **screen 25e, reachable only by declining drive
encryption.** ***measured, run log `2026-08-30_11-04`:*** Bill reached 25e at
14:50:03 and screen 27 at 14:50:52.

So a full screenshot set requires **at least two complete passes** -- an accept
path and a decline path -- and possibly a Home-vs-Pro pass and an
encrypted-vs-unencrypted pass. Each pass is a full walk of the program. Bill's own
run took from 11:04 to 16:40.

### The retake rate is a function of F6, and F6 is unbuilt

**This is the part I most want you to think about.** Retakes are not a fixed
overhead. They are driven by how many wording defects survive to the signed build.

***sourced, your own ResponseToBillsNotes verdict key:*** the dominant verdict
across Bill's 41 items is **WORDING**. ***sourced, ascii43 build plan:*** F6 is the
wording and screen-splitting block, **the largest, touching most screens, and not
built.**

**Take screenshots from a build with F6 unbuilt and you are photographing text you
already know is going to change.** The retake rate approaches 100% on the affected
screens.

### The trap: the build ID is in the picture

If the build ID renders on screen or in a visible header, **every screenshot is
stamped with the build it came from.** One post-screenshot increment invalidates
the whole set. ***measured, DecisionsForBill:*** the increment touches **five build-ID
locations.**

**Cheap mitigation, decide before the first shot:** either crop the build ID out of
every capture, or accept that no build increment may follow the screenshots. The
second is a real freeze; the first costs nothing.

---

## Q3 -- IS "EIGHT WRITES CANNOT SHIP" PROPORTIONATE

**Yes. And you are still understating it, because you have framed a class as a
defect.**

### Where I agree, without reservation

***measured, your triage, `2026-08-30_11-04`, 16:34:21:*** three consecutive lines
-- `GOOD`, `GOOD`, then `SILENT ERROR ... unauthorized operation` at line 6472. The
same second.

***measured, item 6, twelve lines away:*** four writes with `-EA Stop`, correctly
reporting `MANUAL REQUIRED -- registry is protected on this PC`.

**The build already contains the correct pattern and the incorrect pattern twelve
lines apart, and the log tells the customer to email the file to support.** That
cannot ship. Your position is proportionate and I would not soften it.

### Where you are wrong -- "the one defect"

Your section 5 calls it *"the one defect that damages the brand."* **It is not one
defect. It is at least the fourth instance of one class**, and three of the others
are in your own documents:

| Instance | What it says | What is true |
|---|---|---|
| **FT-242** | `Widgets disabled -- GOOD` | The write was refused |
| **FT-203** | `[GOOD] Scheduled task created` | Both tasks carry `DisallowStartIfOnBatteries` and never run on battery |
| **FT-162** | `ScanType 4` | Shipped broken for months |
| **FT-188** | `[ERROR] ... does not exist` x4 | Nothing is wrong; the keys are expected to be absent |

***sourced, your own triage, section G, screen 33:*** both scheduled tasks report
`[GOOD] Scheduled task created` and **"FT-203 is still live in this build ...
Another instance of the FT-242 shape."** You wrote that and then costed only the
eight writes.

**FT-188 is the mirror image and belongs in the same fix.** A clean run that prints
`ERROR` four times is the same failure pointed the other way: **the log does not
correspond to reality in either direction.**

### So the fix is not four characters in eight places

**It is: eight writes, plus FT-203, plus FT-188, plus a gate.**

**The gate is the part I would argue hardest for**, because this project has already
written down why:

> ***sourced, `_READ-FIRST-Briefing`, section 5:*** *"Every rule that held on
> 2026-08-13 had machinery. Every rule broken was one someone had to remember."*

**Proposed: `Run-LogTruthCheck.bat`.** For every `$result = "... GOOD"` assignment
in `Apply-Setting`, assert that the write immediately preceding it carries
`-EA Stop`. Fail the build otherwise. Run it as a **ratchet** with today's baseline
of 8, exactly like gates 12/12b -- **the number is only ever allowed to go down.**

**Without the gate you have fixed eight instances of a defect that has recurred
four times across four builds.** With it, the class is closed and the ninth instance
cannot be written.

**Cost:** an afternoon of Claude Code's time, zero Bill-hours, and it is the kind of
mechanical check the parse-check pattern here has already proved twice.

---

## Q4 -- IS DEFERRING F6 TO THE FIRST ANNUAL UPDATE DEFENSIBLE

**No -- but not for the reason you are expecting, and the objection may be
contractual rather than editorial.**

### The contractual objection, and it needs your confirmation

***sourced -- BUT FROM A SUPERSEDED FILE, see PROVENANCE:***
`GatewayGuard_DecisionsForBill-2026-08-25-1620.md` records **"Licence v2.4 built --
... corrections free."**

**If v2.4 grants corrections free, F6 cannot be deferred *to the annual update* at
all**, because F6 is corrections. It would ship free regardless, and the deferral
question collapses into "ship it now or ship it in a free patch later" -- a
scheduling question with no revenue attached.

**CONFIRM THIS.** `CURRENT.md` names `-2026-08-26-0302.md` as the live
DecisionsForBill and I read the 08-25 one. Check it against the live file and
against `GatewayGuard_License-2026-08-25-1400-TEXT.md` Section 12. **If corrections
are free, half of Q4 is already answered by the contract.**

### The editorial objection

**F6 is not one thing, and treating it as one block is what makes the question look
binary.** From Bill's notes, at least two populations:

**Load-bearing -- ship in ascii44:**

- Anything under **PL-3**: every setting-change sentence must name the permission.
  A senior approving a change without understanding what it grants is the central
  risk this product exists to reduce.
- ***sourced, Bill screen 22:*** *"the screen tells the user to see the guide but
  does not say where to look."* An instruction that cannot be followed is a defect,
  not a wording preference.
- ***sourced, Bill screens 11-14:*** explain **why** steps 1-4 are shown. Your own
  response calls this *"the plain-language rule"* and agrees strongly.

**Not load-bearing -- defer freely:**

- ***sourced, Bill screen 26:*** *"screen positioning too wide"* -- name column
  given 126 for 41 characters. Ugly; harms nobody.
- Screen-length complaints (27, 33a).
- *"Remove 'applying' next to Xs that will be applied."*

**Is wording load-bearing for THIS product in a way it would not be for others?
Yes, and specifically:** the buyer cannot verify the tool's claims. A developer
running a hardening script reads the source. A 74-year-old reads the screen and
presses Y. **The screen is the entire product surface for the actual customer.**
Ambiguous wording here is not polish -- it is the mechanism by which someone
approves a change they did not understand.

**But that argument applies to the permission-naming half of F6, not to column
geometry.** Split it, ship the first half, defer the second, and stop treating F6 as
an atom.

---

## Q5 -- WHAT YOU MISSED

Seven. The first is the one I would act on today.

### 1. A circular dependency ending in a post-freeze build change

**Nobody has drawn this and it closes into a loop:**

```
  FREEZE the build
       |
       v
  SIGN it
       |
       v
  SCREENSHOTS x19  (must show final wording)
       |
       v
  GUIDE LAYOUT     (19 images change pagination)
       |
       v
  PAGE NUMBERS     (21 blank cells finally fillable)
       |
       v
  GUIDE STRUCTURE LOCKED
       |
       v
  FT-226 CLASS FIX -- six settings' GuideRef strings point at real pages
       |
       v
  *** BUILD CHANGE, AFTER THE FREEZE ***
       |
       v
  Those six settings' screens now render different text
       |
       v
  SCREENSHOTS OF THOSE SIX ARE STALE  ------> back to SCREENSHOTS
```

***sourced, FieldChecklist ascii43 PART A item 2:*** the FT-226 class fix is
**deferred until the guide structure is locked**, and it touches settings 10, 11,
12, 17, 18 and 19.

**The break is one cheap decision, and it should be made before anything else on
this list:**

> **Decide the permanent format of `GuideRef` now.** If GuideRef carries a
> **section name** (`"Phase 2, Step 4"`), it never depends on pagination and the
> loop never closes. If it carries a **page number**, the loop is real and one of
> the two arms has to be cut.

***sourced, your own ResponseToBillsNotes item 3:*** 17 "See Guide" pointers exist
and the sampled ones carry locations like `See Guide: Phase 2` -- **section names,
not page numbers.** So the mechanism already does the right thing and the FT-226
fix may only need the six wrong values corrected to section names, with pagination
never entering it.

**If that is right, this is a 20-minute fix with no guide dependency at all, and it
has been parked behind a guide lock it never needed.** Worth checking before
ascii44 is scoped. **Basis: inferred, from a fragment.**

### 2. SANDY is a three-way conflict, not a two-way

You have it as: field run before encryption, one-way door. **True but incomplete.**
Claims on SANDY, at least:

1. The ascii44 field run
2. `Run-ConsoleInputModeCheck.bat` -- ***sourced, ascii43 build plan:*** must run on
   SANDY, not CGDELL, because SANDY is conhost and CGDELL is Windows Terminal
3. FT-198 (M / K / left-click) -- ***sourced, FieldChecklist PART A item 3:***
   needs a separate SANDY measurement
4. Some subset of the 29 VERIFY markers, if any concern Home edition or unencrypted
   state
5. The unencrypted branch of item 8
6. The encryption run itself, **which ends 1 through 5 permanently**

**Write the list before the encryption run, not after.** One question:

> **"What is the last thing that needs SANDY unencrypted?"**

Get it wrong and the unencrypted branch cannot be retested before launch at any
price. This is the only genuinely irreversible item on the whole plan.

### 3. The attorney review does not appear in your table

***sourced, project record:*** attorney review of the **refund policy** has been
flagged as the only genuine store blocker, with real lead time.

**Your nine-row Bill-hours table does not contain it.** If the consult has not been
sent, and LegalZoom turnaround is five to ten business days, **it lands after 15
September** -- and it gates the store, which gates both halves of the split.

**This is the payout-method failure repeating.** You wrote that you were worried
about *"a launch dependency nobody has written down -- the way the payout method
was invisible until Bill's own store page said it."* **This is that dependency, and
it is invisible in exactly the same way: it is not a task, so it is not on a task
list.** Basis: inferred from project record; **confirm the consult's status.**

### 4. Zero hours budgeted for the support inbox

The licence and the log footer both tell customers to email
`support@gatewayguard.co`. Launch week support is Bill-hours, it arrives
unscheduled, and it lands in the window where everything else is already late.
**Even 30 minutes a day for the first ten days is five hours** -- a quarter of your
whole estimate, entirely unbudgeted.

### 5. The token has a lockout counter

You flagged that the cert *"may not be plugged in."* The larger risk: **SafeNet
eTokens lock after a small number of failed PIN attempts**, and on some
configurations the lock is not recoverable without reissue. Last verified use was
**2026-08-14** -- seventeen days.

**Test it this week, not on signing day**, and confirm the PIN is recorded outside
the machine. A reissue is a multi-week path and it would end the date on its own.
**Basis: inferred** -- I have not measured this token's policy.

### 6. Bundle pricing under a split launch

Covered in Q1. Early Guide buyers pay $32.98 against the bundle's $29.99. Decide
before money moves.

### 7. Your Bill-hours table has no triage row

Covered in Q6. It is the single largest missing term.

---

## Q6 -- IS 17-23 HOURS OVER 12 WORKING DAYS REALISTIC

**The hours are plausible for the tasks listed. The schedule is not, for three
reasons -- and only the first is about the number.**

### 1. There is no rework term, and your own data says how big it is

***measured, your own section 5:*** ascii41's field run produced **38 findings**.
ascii42's produced **32**. ascii43's has produced **~47** (6 from logs, ~41 from
Bill's notes).

**So a field run reliably generates 30 to 47 findings.** You budget 4-6 hours for
the run itself and 1-2 Claude Code days to fix -- and **zero Bill-hours for
triaging what it produces.**

But triage is not free and it is not yours. It is Bill reading verdicts, making
YOURS calls, and re-testing. ***sourced:*** your own ResponseToBillsNotes needed a
whole document to answer 41 items, and the verdict key has a **YOURS** category
precisely because some of them can only be decided by him.

**Estimate the missing term at 3-6 Bill-hours per field run**, on top of the run.
**That alone takes 17-23 to 20-29.**

### 2. The hours are not fungible, and that is the real constraint

20 hours over 12 days is 1.7 hours a day. **That framing is wrong**, because at
least three items are single-block tasks that cannot be done in 90-minute slices:

| Task | Why it needs a contiguous block |
|---|---|
| Field run, 4-6 h | Bill's own ascii43 run went 11:04 to 16:40. Splitting it loses machine state and the run's own continuity |
| Guide read, 4-6 h | Reviewing 1,976 lines in fragments loses the thread that makes review worth doing |
| Screenshots, 10-14 h | Every session needs the setup re-done; splitting multiplies the fixed cost |

**The question is not "does Bill have 25 hours." It is "does Bill have four or five
full days."** Those are different questions with different answers, and the second
is the one the schedule depends on. **Ask him that directly** -- it is a better
input to the CPM than any estimate either of us can produce.

### 3. Every path runs through one irreversible node

Your critical path is a single chain with **no parallel arm** and a one-way door in
the middle. Nothing after the SANDY field run can start before it, and the run
cannot be repeated once SANDY is encrypted.

**A single-chain plan with a one-way door has no float anywhere.** A three-day slip
at the field run is a three-day slip at launch, with nothing to absorb it.

**The split launch is the only structural fix available**, and this is a stronger
argument for it than the ones you gave: **it creates a second, independent arm.**
That is what makes it worth doing, more than the marketing or the rehearsal.

### My number

**30 to 40 Bill-hours**, with rework, support, and the items above. **15 September
is achievable for the Guide half only, and only if the 29 VERIFY markers are
mostly already closed.**

**What would change my mind:** the markers being cosmetic; Bill confirming four or
five clear full days in the window; and the attorney consult already being out.
**Any one of those moves the answer. All three would make me agree with your
original estimate.**

---

## WHERE I AGREE WITH YOU, BRIEFLY

Worth stating so the disagreements above have a baseline.

- **Bill-hours as the unit.** Correct, and it is the right reframe.
- **FT-242 first in the ascii44 order.** Correct, ordered by cost of being wrong
  rather than effort. I would add FT-203, FT-188 and the gate beside it.
- **Screenshots cannot precede the freeze.** Correct, and stronger than you argued
  -- see the build-ID trap.
- **The certificate reframing the risk picture.** Correct, with the token caveat.
- **Guide approval being on no plan.** Correct, and it is the best catch in your
  document. My only quarrel is that you then costed it as reading.
- **Not re-opening the Gumroad terms question.** Understood and untouched.

---

## THE QUESTIONS -- ONE NUMBERED LIST, AS THE WORKING RULES REQUIRE

Each states the assumption I made and what changes if the other answer is right.

1. **What are the 29 VERIFY markers?** *Assumed:* factual claims about Windows
   behaviour requiring live measurement. *If cosmetic:* Q1's central objection
   collapses, the split is straightforwardly right, and Q6 drops toward your
   estimate. **This is the highest-value grep on the list.**

2. **Does `GuideRef` carry section names or page numbers?** *Assumed:* section
   names, from your own sampling. *If page numbers:* the Q5 loop is real and one arm
   must be cut before the freeze.

3. **Does licence v2.4 grant corrections free?** *Assumed:* yes, from a **superseded**
   DecisionsForBill. *If no:* Q4's contractual argument disappears and the deferral
   question is genuinely editorial.

4. **Has the refund-policy attorney consult been sent?** *Assumed:* not yet.
   *If sent:* it may clear in time and drops off the critical path. *If not:* it is
   the earliest thing that should happen today.

5. **How many clear full days does Bill have between now and 15 September?**
   *Assumed:* fewer than five. *If more:* the contiguous-block objection in Q6
   weakens substantially.

6. **Does the build ID render on any screen that will be photographed?**
   *Assumed:* yes somewhere. *If no:* the build-ID trap disappears and one freeze
   constraint relaxes.

7. **What is the last thing that needs SANDY unencrypted?** *Assumed:* nobody has
   enumerated it. *If someone has:* point me at the list and I will check it against
   the open items.

8. **Is the Guide commercially standalone, or does it read as a manual for a product
   nobody can buy yet?** *Assumed:* standalone, since it is priced standalone.
   *If not:* the split's first impression problem is real and I have understated it.

9. **Are FT-245 through FT-247 in the same class as FT-242?** *Assumed:* unknown --
   I did not read them. *If yes:* the gate in Q3 gets more valuable and the ascii44
   scope grows.

10. **Should the Q3 gate be built before ascii44 or alongside it?** *Assumed:*
    before, so the fix is verified by machinery rather than by review. *If after:*
    the eight writes get fixed by hand and reviewed by hand, which is how the
    previous three instances got through.
