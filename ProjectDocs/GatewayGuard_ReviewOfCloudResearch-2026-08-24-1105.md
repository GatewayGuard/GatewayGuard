<!-- Dated: 2026-08-24 11:05 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Claude Code's review of Cloud's research

- **Document Name:** GatewayGuard_ReviewOfCloudResearch
- **Last Modified:** 2026-08-24 11:05 ET
- **Reviews:** `GatewayGuard_CloudResearch-WidgetsAndAccessibility-2026-08-24-1015.md`
  (Claude Cloud, 944 lines, topics 2 and 7)
- **THIS IS COMMENTARY ONLY.** Bill asked that my remarks on Cloud's work be
  kept out of my own research. **Cloud's document is committed unedited.** My
  own findings are in the four `GatewayGuard_Research-*` files and the
  decisions list; nothing from this review has been merged into them.

---

## THE SHORT VERSION

**It is good work and I checked it rather than trusting it.** Two of its claims
were independently verifiable from this machine, and **both reproduce exactly.**
It found a false statement on one of our own pages that four earlier passes --
including two of mine -- had walked past.

**It also followed the brief.** No questions mid-stream, everything labelled,
recommendations rather than surveys, the five topics that were not its job left
alone, and the measurements it could not take handed back by name instead of
guessed at. That last one is the part that matters: an instance that cannot
measure and knows it is worth more than one that fills the gap.

---

## 1. WHAT I VERIFIED, AND THE RESULT

### 1.1 The false claim on `widgets.html` -- CONFIRMED

Cloud says the page's opening sentence is contradicted by Microsoft, because
the board still opens with **Windows key + W** after the taskbar toggle is off.

*measured 2026-08-24, `grep` on `WebSite/html/widgets.html`:*

| Cloud quoted | On the page? |
|---|---|
| *"Turning it off removes the panel and stops that data sharing."* | **verbatim** |
| *"tracks which stories you read, how long you spend on them, and what you click on"* | **verbatim** |
| *"Anything still running is still working."* | **verbatim** |
| `Windows key + W` mentioned anywhere | **0 occurrences** |

**Cloud quoted our own page accurately, which is not a given for an instance
that reads the site only through a source pack.**

**This is the Tamper Protection shape for the third time**, and that is now a
pattern worth naming rather than a coincidence:

1. `tamper-protection.html` -- claimed Checkup would turn it on. `CanAuto=$false`.
2. `periodic-scanning.html` -- claimed Windows forbids programmatic change.
   `CanAuto=$true`. *(I found this yesterday, after my own item 17 sweep had
   already missed it once.)*
3. `widgets.html` -- claims the panel is removed. Microsoft says it is one
   keystroke away. **Cloud found this one.**

**All three are the same error: the page states an outcome nobody checked
against the thing that produces it.** Three different sources found three
instances, which suggests the remaining sixteen pages deserve the same
treatment rather than a spot check.

### 1.2 The contrast arithmetic -- REPRODUCES EXACTLY

Cloud computed WCAG relative luminance for all seven palette tokens against two
backgrounds and published fourteen ratios. I recomputed all fourteen
independently from the hex values in the deployed CSS.

*measured -- all fourteen match to two decimals:*

| Token | on `#FFFFFF` | on `#F4F4F4` |
|---|---|---|
| `--black` | 21.00 | 19.09 |
| `--gray-dark` | 12.63 | 11.49 |
| `--gray-mid` | 5.74 | 5.22 |
| `--navy` | 5.01 | **4.56** |
| `--mocha` | 5.62 | 5.11 |
| `--charcoal` | 8.02 | 7.29 |
| `--gray-rule` | 1.36 | 1.23 |

**Cloud's warning about `--navy` is justified and slightly understated.** The
exact figure is **4.5566** against a 4.5 threshold -- **1.2% of headroom.** Any
darkening of the light background or lightening of the navy breaks AA on text
that appears across the whole site. Its recommendation to pin these numbers in
the gate rather than trust them is right.

**Worth saying plainly: Cloud did arithmetic it could have hand-waved, and got
it right.**

---

## 2. WHERE I DISAGREE, OR WOULD ADD

### 2.1 M-2 is now partly answered, and the answer is the one Cloud suspected

Cloud left the background-process question open at *"roughly six reports,
four-to-two"* and refused to ship a claim. **Correct call.** My SANDY script's
test run on CGDELL settles part of it.

*measured 2026-08-24 on CGDELL:*

```
Widgets taskbar button (TaskbarDa) : 0     <- button hidden
Widgets                            : 1 running
WidgetService                      : 1 running
msedgewebview2                     : 12 running
```

**With the button off, the Widgets processes are running.**

**But this does NOT fully close M-2, and the reason is Cloud's own wording.**
It specified *"with Widgets Off and **after a restart**."* Uptime here is
**196 hours** and nothing records when `TaskbarDa` became 0, so I cannot show
the processes survived a reboot taken *after* the toggle. **M-2 stays open in
its strict form** -- but the older reports look right, and no memory claim
should ship either way.

*(The twelve `msedgewebview2` processes are shared with Teams and Outlook, as
Cloud noted. They prove nothing on their own. `Widgets.exe` and
`WidgetService` do.)*

### 2.2 The rule number Cloud refused to invent -- assigned

Cloud left it as `W-nn`, saying it cannot enumerate the rule list and will not
write a number as fact. **That is the right instinct and I would rather it did
that than guess.**

*measured 2026-08-24, `grep -oh "RULE W-[0-9]*"` on WebsiteStandards:* W-01
through **W-08** exist. *measured, the delivery gate letters:* H-1 through
**H-4** exist.

**So Cloud's inference was correct: the rule is `W-09` and the gate is `H-5`.**
Assigned. It guessed right and still declined to assert it, which is exactly
the behaviour the house rules ask for.

### 2.3 The one place I would push back on substance

Cloud recommends the page **lead with the middle path** -- Discover off, or
hover-open off, keeping the weather button -- for readers who like the weather.

**I think that is one option too many for this audience.** The product's own
plain-language rule is *say the thing that matters, once*, and this page would
then carry three routes: turn the button off, turn Discover off, turn hover
off, plus a lock-screen step, plus a fallback for builds without the Discover
control. **That is five things on a page about a weather widget.**

**Not a disagreement about the facts -- Cloud's research is right that the
middle path exists and is better for some readers.** It is a judgement about
how much choice a senior can be given before the page stops being usable. Bill
should settle it; Cloud's question 1 asks exactly this and is the right
question.

---

## 3. THE STRUCTURAL FINDING IN CLOUD'S MERGE NOTE -- ACT ON THIS

Two Cloud sessions six hours apart answered the same request independently,
neither knowing the other existed, because **a Cloud deliverable that has not
been committed is invisible to the next Cloud session.**

**Cloud diagnosed this correctly and it is not a Cloud problem to fix -- it is
mine.** The five-step chain in `CLAUDE.md` covers getting a file *to* Cloud. It
says nothing about getting Cloud's own output committed promptly so the next
session can see it.

**Recommendation: add a sixth step to the chain** -- when Cloud delivers,
Claude Code commits it *the same session*, unedited, before doing anything
else with it. I did that here, but by instinct rather than by rule, and the
rule is what survives.

**Cloud's filename observation is also worth keeping.** Three constraints
collided: the naming standard needs `-HHMM`, the clock rule forbids inferring a
time, and a no-questions session forbids asking. Its resolution -- **when the
clock cannot be sourced, drop the field rather than fill it, and say so** -- is
better than what my brief told it to do. *"A held blank is recoverable; a
plausible wrong value is not."* That belongs in `CLAUDE.md`.

---

## 4. WHAT I DID NOT REVIEW

- **The Word Accessibility Assistant's check list** (7.2) and **which checks
  carry to HTML** (7.3). Sourced from Microsoft, no local means to verify, and
  no reason to doubt.
- **The draft W-09 rule text** (7.7) beyond its scope line. It is long and it
  is a standards decision, not a factual one -- Bill's call, and his questions
  5 through 10 are the right ones to answer first.
- **The Widgets replacement copy** (2.8). Not verified line by line, because
  it cannot be applied until Bill answers Cloud's question 1 and 2.
- **Cloud's ten questions.** They are for Bill, not for me. I have not
  pre-empted any of them, and the two I have an opinion on are 1 (see 2.3) and
  6, where **WCAG 2.1 AA is the right choice** for the reason Cloud gives.

---

## 5. BOTTOM LINE

**Trust this document.** I verified the two things that were checkable and both
were exact. It found a real defect on a live page, it declined to answer what
it could not measure, and it named the measurements instead of inventing them.

**The one thing to remember when reading it:** every statement about what
Checkup does, what any `CanAuto` value is, or how any machine here is
configured is marked `[VERIFY-CC]` and has **not** been checked by Cloud. Those
are mine to settle, and I have not yet gone through them.
