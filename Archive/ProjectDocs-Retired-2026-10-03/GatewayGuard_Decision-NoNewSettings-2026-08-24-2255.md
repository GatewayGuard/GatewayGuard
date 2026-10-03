<!-- Dated: 2026-08-24 22:55 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Decision: no new settings before launch. Nineteen is the number.

- **Document Name:** GatewayGuard_Decision-NoNewSettings
- **Last Modified:** 2026-08-24 22:55 ET
- **Bill, 2026-08-24:** *"Made a decision tonight, we are not going to add any
  new settings. Just add to notes and marketing that in the future we will be
  testing and adding new usefull settings."*
- **Status:** **DECIDED.** This closes three open questions and reverses one
  answer given earlier the same day.

---

## THE DECISION

**Checkup ships with nineteen settings. No additions before launch.** Anything
found worth adding goes on a list for a future update, and the product says so
in plain language rather than silently.

**Launch is 1 September 2026 -- eight days.** *measured:* ascii43 is
**half built and has never been field run**. Adding settings to an untested
build widens what a failed field run has to explain, on the one build there is
no time to test twice. **The decision protects the field run more than it
costs the product.**

---

## WHAT THIS CLOSES

### 1. Q4 IS REVERSED -- AND IT WAS ANSWERED THE OTHER WAY THIS MORNING

**Earlier today, 2026-08-24, Bill answered Q4: *"Add them"*** -- cloud
protection and automatic sample submission, taking Checkup from 19 settings to
21.

**Tonight's decision reverses that.** Both are **out** for launch and go on the
future list.

**Recorded prominently because the record must not carry two answers.** The
morning answer is superseded, not forgotten -- the reasoning behind it still
holds and is why both belong high on the future list. *Sourced, Microsoft:* the
recommended combination is quick scan **plus real-time protection plus cloud
protection**, so cloud protection is a genuinely good candidate. **It is a
timing decision, not a merit decision.**

### 2. THE LOCK SCREEN DOES NOT BECOME SETTING 20

Today's Widgets work found that the lock screen shows the same news and adverts
**before sign-in**, on both test machines, and that Checkup does nothing about
it. The open question was inside setting 14 or its own setting.

**Answered: not its own setting.** Two options remain, and neither adds to the
count:

- **Fold it into setting 14** as steps the user is shown, or
- **Guide and website only**, with setting 14 unchanged.

**My recommendation is inside setting 14**, because it is the same feature and
the same content, and a reader who turns Widgets off and still sees the feed on
their lock screen has been half-served.

### 3. ITEM 15'S FOURTH PHISHING ITEM STAYS EXPLAINED, NOT ADDED

Already the recommendation, now settled by scope as well. The fourth item --
the automatic content collection checkbox -- gets explained on the page and
left alone. **No new setting.**

### 4. Q8 / ITEM 23 -- ALREADY DEFERRED, NOW CONSISTENT

Windows Update Advanced options was deferred by Bill on 2026-08-24 with his own
reasoning. **Tonight's decision makes that the general rule rather than a
one-off.**

**One thing this does NOT close.** The **update-pause blind spot** is not a new
setting -- *measured:* nothing in the build reads `PauseUpdatesExpiryTime`, so
setting 1 can report Windows Update healthy on a machine unpatched for weeks.
**That is a defect in an existing setting and it stays in F6.**

---

## WHAT STILL GETS BUILT -- THIS IS NOT A FREEZE

**"No new settings" is not "no changes".** Everything below is a fix or a
wording change to one of the existing nineteen, and none of it adds to the
count:

| | |
|---|---|
| **Setting 14** -- the three-way Widgets choice and its approval screen | Reshapes an existing setting |
| **Setting 14** -- the wrong Revert string at line 6830 | Fixes a dead end |
| **Setting 1** -- detect paused updates | Fixes a `[GOOD]` printed over nothing |
| **Setting 5** -- the page's false "Windows does not allow" claim | Already fixed today |
| **Setting 6** -- rename from "Edge Phishing Protection" | The name is factually wrong |
| **F4** -- the full scan, with approval | Completes route 3 of an existing scan step |
| **F5, F6** | Unchanged |

---

## THE FORWARD-LOOKING LINE -- WHERE IT GOES AND WHAT IT SAYS

Bill: *"add to notes and marketing that in the future we will be testing and
adding new usefull settings."*

**This is not a small addition.** It converts a limitation into a commitment,
and it is the honest frame for a product that has deliberately stopped at
nineteen.

### FOR THE WEBSITE AND THE GUIDE

Extends what Bill already approved for **item 19**, where his instruction was
to *"add 'in the future'"*:

> **More settings are coming.** Checkup covers nineteen settings today. There
> are others we are still testing, and we will not add one until we are
> confident it helps and cannot cause you a problem. When a setting earns its
> place, it arrives in the yearly update along with an explanation of what it
> does and why.

### FOR THE MARKETING PLAN

> **Nineteen settings, chosen deliberately.** GatewayGuard tests a setting on
> real machines before it recommends it. Settings that have not finished
> testing are not in the product -- they are on the list for a future update.
> **A short list you can trust is worth more than a long one you cannot.**

**Why that last sentence matters commercially:** the obvious competitive attack
on a nineteen-setting product is that some free debloat script touches two
hundred. **The answer is not to match the number.** It is to say plainly that
each of ours was measured, which is the same argument the source-visible
promise already makes. **The scope decision and the brand argument are the same
argument.**

### FOR THE NOTES -- THE FUTURE LIST ITSELF

**Started here, so it exists as a real list rather than an intention.**
Everything found worth adding, with the reason and the evidence:

| Candidate | Where it came from | Why it is a candidate |
|---|---|---|
| **Cloud protection** | Q4, Bill said add 2026-08-24 | *Sourced:* Microsoft pairs it with quick scan and real-time protection as the recommended combination |
| **Automatic sample submission** | Q4, same | Same source; the pair are documented together |
| **Lock screen status** -- "Weather and more" | Today's M-3 | *measured:* both machines show news and adverts **before sign-in**, and nothing in Checkup touches it |
| **Windows Update Advanced options** (3 items) | Q8 / item 23 | Bill deferred with his own reasoning; only one of the three is worth recommending |
| **Reputation-based protection, 4th item** | Item 15 | Data collection, not protection. Explained on the page instead |
| **Advanced firewall / inbound rules** | Q6 | **Bill: "forget about it."** Recorded as rejected, not pending |

**A rejected candidate stays on the list, marked rejected.** Otherwise it gets
re-raised every few months by whoever notices it missing -- which is exactly
what happened with the multi-year pre-pay question.

---

## WHAT I NEED FROM BILL

**One thing, and only because it reverses this morning:** **is Q4 out?**
Cloud protection and automatic sample submission were answered *"Add them"*
today and are now excluded by tonight's decision. **I have recorded them as
out and on the future list.** If tonight's rule was meant to spare them, say so
and I will move them back.

Everything else follows without a question.
