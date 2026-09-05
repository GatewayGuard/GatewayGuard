<!-- Dated: 2026-09-04 20:00 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Cloud request -- do the research Bill asked for in the ascii43 test results

- **Document Name:** GatewayGuard_CloudRequest-ascii43Research
- **Last Modified:** 2026-09-04 20:00 ET
- **Last Editor:** Claude Code (CGDELL)
- **From:** Bill, via Claude Code
- **To:** Claude Cloud
- **Source of the requests:** `Test_Results\Ascii43-Test-Results-2026-08-26-1701-2-TEXT.md`
- **Claude Code's replies to the same notes:** `GatewayGuard_ResponseToBillsNotes-ascii43-2026-08-30-1815.md`

---

## WHAT BILL IS ASKING FOR

**Bill, 2026-09-04:** *"Mark a note to Claude Cloud to do all the research
requested in my ascii43 test results and report back findings and his
recommendation."*

**So: findings AND a recommendation on each item.** Not a summary of what is
known -- a position, with the evidence that supports it and the evidence that
argues against it.

**Read `GatewayGuard_CloudWorkingRules-2026-08-25-1400.md` first.** Rules 5 and
6 govern this deliverable: **every state claim carries its source in the
sentence**, and **provenance is announced at the top**. A recommendation with no
sourced basis is worth less than no recommendation, because it looks the same.

**Rule 8 applies too: hold questions to the end.** Do the work you can do, and
put what you could not settle in one list at the bottom.

---

## THE MAIN ITEM -- BILL'S 20-POINT LIST, VERBATIM

**This is quoted exactly as Bill wrote it**, from the "Aside" in the ascii43
test results. It is one paragraph in the original; the numbering is his.

> 1. Checkup's first step should be to have the user manually check tamper
>    protection and enable it if needed.
> 2. If we cannot read that setting directly, determine whether we can tell
>    whether tamper protection is off by trying to read items that should be
>    blocked when it is on.
> 3. Checkup should then check for Windows updates.
> 4. Continue running Windows updates until Windows reports that the system is
>    current.
> 5. Determine whether Checkup can check and apply those updates automatically.
> 6. Only after that should the four scans run.
> 7. Check and enable both blocking sub-options before any scan begins.
> 8. Research any other settings that should be checked or enabled before scans
>    run, including the console option 1 versus option 2 decision.
> 9. Research whether Malwarebytes is still needed now that Defender can detect
>    PUPs and similar threats when blocking is enabled.
> 10. Find the facts and design tests to confirm the best approach.
> 11. If Checkup can work well without Malwarebytes, it will be simpler and
>     faster to use.
> 12. Determine whether we can recover the 18 PUPs Malwarebytes found on Sandy
>     and use them for testing.
> 13. Research expert guidance on password managers versus browser password
>     managers.
> 14. Depending on the consensus, we may need to advise users before running
>     Checkup to set up a password manager and turn off browser password saving.
> 15. Research how often experts recommend changing passwords, including the
>     arguments for and against keeping a very strong password unchanged when
>     2FA is enabled.
> 16. Our recommendation should follow expert consensus and include using
>     two-factor authentication for banking, investment, and credit card
>     accounts.
> 17. Explain authenticator apps versus text-message codes.
> 18. For authenticator apps, determine whether the display time can be extended
>     beyond a few seconds.
> 19. Note that on some accounts, a previous code may still work briefly after a
>     new code appears.
> 20. Develop a plan for doing the above and show it to me in a .md.

**Item 20 is the deliverable.** The other nineteen are its content.

---

## FOUR MORE RESEARCH ASKS, ELSEWHERE IN THE SAME DOCUMENT

**These are separate from the twenty and are just as explicit.**

**A. Does encryption reach a plugged-in USB drive?** *(Scr 25d, item 3)*
> *"Will encryption encrypt a plugged in USB drive during encryption."*

**Claude Code's unverified understanding, which you should treat as a
hypothesis to test and not as a starting point:** Device Encryption on Home
covers internal fixed drives only, and removable drives need BitLocker To Go,
which Home does not offer. ***Not measured. Do not repeat it unless you can
source it.***

**B. Must the user turn on encryption themselves on every Windows 11 Home
PC?** *(Scr 28, item 1)*
> *"on home the user needs to turn on encryption themselves... True on Sandy,
> research this is true on all win 11 home computers."*

**Bill has one machine's behaviour and wants to know if it generalises.** This
one has a direct product consequence: six screens are due to be rewritten to
say *"These must be set manually, Checkup will show you how"*, and that
sentence is only honest if the answer is yes.

**C. What is Tamper Protection actually blocking?** *(Scr 25, item 1)*
> *"Setting # 6 what are you checking when you say TP blocks this. See below
> gemini write up. If truly blocked then change wording to 'Must be set
> manually - Checkup will show you how.' Also change Setting 9 to same
> wording."*

**The wording change waits on the finding.** Bill's own note points at a Gemini
write-up further down the same file -- **read it and say where you agree and
where you do not**, rather than restating it.

**D. Anything else that must be set before a scan runs** *(item 8 of the
twenty)*, **including the console option 1 versus option 2 decision.** That
last clause is the part most likely to be skipped; do not skip it.

---

## WHAT CLAUDE CODE ALREADY MEASURED -- START FROM THIS, DO NOT REDO IT

**All of the following are measured, with sources, in
`GatewayGuard_ResponseToBillsNotes-ascii43-2026-08-30-1815.md` section 23.**

| Item | What is already known |
|---|---|
| **1** (order of the run) | ***measured:*** Windows turned real-time protection back on by itself mid-test (FT-239), and the WTDS registry cannot be read while Tamper Protection is on. **The machine's state changes underneath the tool.** Claude Code's view: this is the most valuable item in the list |
| **2** (detect TP indirectly) | ***measured on both machines:*** `WTDS\Components` is unreadable when Tamper Protection is on, and **the tool already catches this and reports "Unknown"**. The signal exists and is being thrown away |
| **9** (Malwarebytes) | ***measured, SANDY 2026-08-28:*** Malwarebytes found **12 of 12** specimens; Defender's full scan also found 12 of 12 |
| **12** (the 18 PUPs) | **Time sensitive.** If quarantined they are recoverable now and gone once quarantine ages out |

**On item 9, the trap is named in advance and you must not fall into it:**
**detection of EICAR-style test files proves nothing about PUP detection in the
wild, which is what Malwarebytes is actually there for.** A recommendation to
drop Malwarebytes built on the 12-of-12 result would be built on the wrong
evidence. **Say so explicitly in your answer, whichever way you come down.**

**Item 9 is also the largest-consequence item in the whole list.** It reaches
pricing, the licence, the guide, four tool screens and the monthly reminder
task.

---

## WHAT THE ANSWER SHOULD LOOK LIKE

**One `.md` in `ProjectDocs\`**, named
`GatewayGuard_CloudResearch-ascii43-YYYY-MM-DD-HHMM.md`.

**Per item, four things:**

1. **The finding**, with its source in the sentence -- a link, a vendor
   document, a named standard. Bill's four labels apply: **measured**,
   **sourced**, **inferred**, **guess**. *Inferred* and *guess* are not
   shippable as recommendations.
2. **Your recommendation**, in one sentence, as a position.
3. **What would change your mind** -- the evidence that argues the other way.
   **If there is none, say the question was not genuinely open.**
4. **Where it lands** -- tool screen, guide content, website copy, or licence.
   **Items 13 to 19 are almost certainly guide content, not tool content.**
   Say so where that is true; it changes who does the work and when.

**Then the plan Bill asked for in item 20:** what to do, in what order, and what
each step depends on. **He asked for a plan before anything is built, and
nothing has been built.**

---

## THREE CAUTIONS

**1. Expert consensus moves.** On password rotation it has moved against forced
change, which supports Bill's instinct. **Cite the current guidance and its
date**, not a remembered rule.

**2. Do not design tool behaviour.** Item 10 says *"design tests"*, not design
the build. **Recommend what to verify and how; the build order is Claude Code's
and Bill's.**

**3. Two of Bill's twenty are questions with plain factual answers** -- 18 (can
an authenticator code's display time be extended) and 19 (does a previous code
still work briefly). **Answer those flatly.** Bill noticed the behaviour in 19
himself and is asking why; there is a real mechanism behind it.

---

## THE CURRENT STATE, SO NOTHING IS BUILT ON A STALE PICTURE

- **Build: ascii43**, half built, field run twice. **None of this research has
  been built into anything.**
- **The store is finished and proven** -- three products, six test purchases,
  every download verified. **Not related to this research, but it is what the
  last three days went into**, so do not treat the store as open work.
- **Licence v3.0's two open decisions are both answered** -- the Guide's print
  sizes (one, chosen at purchase) and the bundle refund (14 days).
- **Target launch: September 15, 2026.** Items 13 to 19 are guide content and
  the guide is written; **anything you recommend adding to it lands on a
  document that is already drafted at 1,976 lines.** Say where it goes.
