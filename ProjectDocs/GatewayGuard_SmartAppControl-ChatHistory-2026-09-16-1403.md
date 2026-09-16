<!-- Dated: 2026-09-16 14:03 ET -->
# Smart App Control -- everything said in this chat, in the order it was said

- **Document Name:** GatewayGuard_SmartAppControl-ChatHistory
- **Dated:** 2026-09-16 14:03 ET
- **Editor:** Claude Code (CGDELL)
- **Purpose:** Bill asked for every piece of this conversation touching Smart
  App Control / FT-260, pulled into one document, in sequence -- so the whole
  discussion can be read start to finish instead of scattered across many
  messages over several days.
- **Reconstructed from this session's own conversation**, not from a saved
  transcript file (none exists) -- faithful to what was said, not a paraphrase.
- **This is the input to a decision, not the decision.** Question 3, still
  open: *does Checkup name Smart App Control in ascii45, or stay silent?*

---

## STAGE 1 -- THE DISCOVERY, FROM BILL'S OWN SCREENSHOTS (2026-09-08)

Bill sent three screenshots. Claude Code's report at the time:

> This is very likely the actual cause. Here's what happened and what I'm doing about it.
>
> **What's actually live**
>
> **Your drag threshold has been sitting at 200 pixels...** *(unrelated finding from the same screenshot batch -- not part of this topic, omitted here)*

The Smart App Control finding, from the same reply:

> Read all three. They settle the open row **and** turn up something bigger.
>
> **What they confirm**
>
> SmartScreen for Microsoft Edge is on that screen -- its own toggle, teal and clickable. The guide page was right. And the Edge-side control is real...
>
> **The finding in the second screenshot**
>
> A yellow line: "This setting is managed by Smart App Control" -- above **Check apps and files**, and that toggle is grey while the Edge one below it is teal.
>
> **Check apps and files is our setting 4.** Measured on this PC just now: `VerifiedAndReputablePolicyState = 1` -- Smart App Control on and enforced, which your third screenshot confirms at its own page.
>
> **This is not entirely new, but it is wider than our record said.** We wrote this up on 2026-08-24 for Block apps under Potentially unwanted app blocking, and the ascii44 plan already calls for one plain sentence about it. What is new is that it also takes over Check apps and files -- a numbered checklist item, not just a sub-tick-box. That sentence has to cover both.
>
> **I am not going to inflate it.** Smart App Control forces both controls on, so a reader will never find one off and unable to click it. There is no dead end. The cost is a senior seeing a greyed control and assuming they broke something -- which is exactly what the one sentence is for.
>
> **What is worth your attention -- raised, not fixed**
>
> Checkup cannot see this kind of lock. The policy check I added yesterday reads only under `HKLM\SOFTWARE\Policies`. Smart App Control locks settings from somewhere else entirely, and the build has zero mentions of it.
>
> Measured on your PC, and the point lands exactly: no Group Policy is forcing anything here -- all three policy keys exist but hold no values -- and the one mechanism that actually is forcing a setting is the one the check cannot see. Same shape as the firewall-profile miss last night: the source I checked was real but not complete.
>
> Logged as FT-260. Smart App Control is also not one of the 19 and appears nowhere in the build -- whether it should be checked is your call, not a fix I should make. Say the word and I add FT-260 to `CLAUDE.md` so the next session meets it at startup.

---

## STAGE 2 -- FT-260 ADDED TO CLAUDE.md, AT BILL'S REQUEST

Bill: *"add ft-260 to claude.md"*

Claude Code's reply, explaining placement and content:

> FT-260 is in `CLAUDE.md`, so the next session meets it at startup.
>
> **I put it directly after the FT-258b firewall block, not in the short raised-not-fixed list further down.** That was deliberate: FT-260 is the same lesson arriving a day later, and it only makes sense to someone who has just read what the policy check does and where it looks. Split them, and the line above still describes that check as complete.
>
> The entry carries:
>
> - The measurement -- Smart App Control on and enforced, and zero occurrences of it in the build.
> - Both registry locations, so the gap is concrete rather than described.
> - The sentence that makes it land: no Group Policy is forcing anything on this machine, and the one mechanism that is forcing a setting is the one the check cannot see.
> - What the finding is not -- Smart App Control forces both controls on, no user meets one that is off and unclickable, no dead end. Without that, the next session scopes it too wide and builds more than it should.
> - The prior art, so it does not read as new: Block apps was recorded on 2026-08-24 and the ascii44 plan already asks for one plain sentence. What is new is that it reaches a numbered item, so that sentence has to cover both.

The entry actually filed into `CLAUDE.md` (still live there today):

> **FT-260, RAISED NOT FIXED -- THE POLICY CHECK CANNOT SEE THE LOCK THAT
> IS ACTUALLY IN FORCE ON CGDELL. Bill's screenshots, 2026-09-08.**
> Windows Security shows *"This setting is managed by Smart App Control"*
> above **Check apps and files**, with that toggle **greyed out** while
> SmartScreen for Microsoft Edge beside it is live and clickable.
> **Check apps and files is item 4 -- a numbered checklist item.**
> ***Measured on CGDELL 2026-09-08: `VerifiedAndReputablePolicyState = 1`,
> Smart App Control On and enforced.***
> **FT-258's `Get-GGPolicyLock` reads only `HKLM\SOFTWARE\Policies`. Smart
> App Control locks from `HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy`,
> and *measured: the ascii44 source carries ZERO occurrences of "Smart App
> Control"*.** So Checkup reports no lock while a control sits greyed out on
> the user's own screen.
> ***The measurement makes the point exactly: on this machine no Group
> Policy is forcing anything -- all three policy keys exist and hold no
> values -- and the one mechanism that IS forcing a setting is the one the
> check cannot see.*** **This is FT-258b's lesson again, one day later: the
> source I verified against was real but not complete.**
> **DELIBERATELY NOT OVERSTATED: Smart App Control forces both controls ON,
> so no user ever meets one that is off and unclickable. There is no dead
> end here.** The cost is a senior seeing a greyed control and assuming they
> broke it.
> **Also taken over: `Block apps` under Potentially unwanted app blocking**
> -- ***measured 2026-08-24***, already recorded in
> `GatewayGuard_Research-Items15and20-2026-08-24-0917.md`, and the ascii44
> plan already asks for one plain sentence about it. **What is new is that
> it reaches a NUMBERED ITEM, so that sentence has to cover both.**
> **Smart App Control is not one of the 19 and is nowhere in the build.
> Whether it should be checked is Bill's call, not a fix.** Full write-up
> with every path:
> `ProjectDocs\GatewayGuard_SettingsLocationList-2026-09-08-2130.md`.

---

## STAGE 3 -- CARRIED INTO THE SETTINGS LOCATION LIST (2026-09-08)

From `GatewayGuard_SettingsLocationList-2026-09-08-2130.md`, section 3, still
the live reference document:

> ### 3. Smart App Control is on, and it takes two of these over
>
> ***Measured on CGDELL 2026-09-08: `VerifiedAndReputablePolicyState = 1`, On and enforced.***
>
> **It greys out `Check apps and files` and `Block apps`, and forces both On.** Neither is a fault and neither is something Checkup did. **A greyed control is the thing a reader assumes they broke**, so the guide needs one plain sentence.
>
> **Where to look at it:** Windows Security > App & browser control > **Smart App Control** -- On / Evaluation / Off. ***On here.***
>
> **FT-260:** Checkup cannot see this kind of lock. Its policy check reads only `HKLM\SOFTWARE\Policies`; Smart App Control locks from `HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy`, and *measured: the build has zero occurrences of it.* *Measured: on this machine no Group Policy is forcing anything, and the one thing that IS forcing a setting is the one the check cannot see.*

---

## STAGE 4 -- CLOUD'S RESPONSE RAISES IT AS A DECISION FOR ASCII45 (2026-09-16)

From `GatewayGuard_CloudResponse-CoPilot44-45-2026-09-16-1209.md`, section 1.5:

> ### 1.5 FT-260 is not in Copilot's review and should be in ascii45's decision list
>
> ***Measured (CLAUDE.md, 09-08):*** Smart App Control locks item 4 from
> `HKLM\SYSTEM\...\CI\Policy`, and the ascii44 source has zero occurrences of
> "Smart App Control". Copilot's "policy state vs effective state" theme is
> this exact gap, one layer down. It belongs beside P3-2 in ascii45 as the
> first concrete case the policy-lock framework has to handle, and it needs
> Bill's ruling on whether Checkup names Smart App Control at all (question 3).

And among Cloud's six closing questions:

> 3. **Bill:** does Checkup name Smart App Control (FT-260) in ascii45, or
>    stay silent on it?

---

## STAGE 5 -- TODAY'S EXCHANGE

Bill asked for Claude Code's recommendation across several open questions,
including: *"3. Why wouldn't it?"* -- asking for the case against naming it.

Claude Code's answer:

> **The case against naming Smart App Control.** A few real reasons:
> - It's confusing and mostly out of a customer's control -- if their PC came with Windows 10 and was upgraded, they often can't turn it on at all, no matter what they do.
> - Once someone turns it off, Windows won't let them turn it back on without reinstalling Windows. That's a bigger, riskier thing for Checkup to point a customer toward than anything else we do.
> - It's already not costing us anything -- the two settings it affects already show correctly as fine. Naming it would only be about explaining a greyed-out toggle, not fixing anything.
> - Building the detection and writing the explanation is real extra work for something most customers can't act on anyway.
>
> The one argument the other way: a customer who sees a toggle greyed out with no explanation might think Checkup is broken. A single guide sentence could prevent that without touching the tool itself.

Bill: *"repeat what you said about why smART APP CONTROL WAS RECOMMENEDE, I MISSE DIT"*

Claude Code, repeating the case **for** naming it (the recommendation, as
distinct from the case against just given):

> **Why it was recommended:** because your own guide sometimes tells the reader to go look at that Windows Security screen themselves, to double-check a setting. On a machine with Smart App Control turned on, when they get there, they'll see a toggle they can't click, next to a mention of a Windows feature we've never explained anywhere. It's a confusion we'd be causing ourselves -- since we're the ones sending them to look at that screen in the first place.
>
> The setting itself is already fine either way (Smart App Control forces it to the correct state) -- the only question is whether we say one sentence explaining why it's greyed out, so a senior doesn't think they broke something.

Bill: *"SO ITS NOT PART OF CHECKUP"*

Claude Code:

> Correct -- **Smart App Control is not part of Checkup at all.** It's a separate Windows 11 feature that Windows itself controls, entirely outside anything Checkup checks, changes, or even reads. Measured directly: the build's source code has zero mentions of it anywhere.
>
> What Checkup does have is two settings that Smart App Control happens to interact with -- "Check apps and files" (setting 4) and "Block apps." When Smart App Control is on, it forces both of those to the correct, safe state on its own and won't let anyone change them, which is why the toggle shows up greyed out on that screen.
>
> So the actual open question isn't "should Checkup manage Smart App Control" -- it doesn't and wouldn't. It's narrower: should we add one sentence to the guide explaining why a reader might see a greyed-out toggle, so they don't think something's broken?

Bill: *"SO WHAT IS THIS SETTING IN ONEDRIVE PERSONAL SCREENSHOTS 91? i CAN TURN IT ON OR OFF"*

Claude Code checked the actual screenshot (`Screenshot (91).png`) before
answering:

> That's the Smart App Control feature's **own** control page -- a completely different screen from the two Checkup settings it locks.
>
> - **The two Checkup settings** (Check apps and files, Block apps) are greyed out *because* Smart App Control is on -- you can't touch those directly.
> - **This screen is Smart App Control's own home** -- On / Evaluation / Off, and yes, this one you can click directly. It's currently set to **On**.
>
> So you're right -- you can turn *this* on or off. It's just not the same thing as the settings Checkup manages; it's the separate Windows feature sitting one level above them.
>
> **One caution before you touch it, and it's important:** Microsoft's own documentation says that once you turn Smart App Control **off**, you generally can't turn it back **on** again -- not without reinstalling Windows. It only offers a one-way trip from On (or Evaluation) down to Off. I haven't tested that myself on this machine, so I'm passing it along as documented behavior, not something I've verified here -- but it's the reason I wouldn't recommend flipping it just to see what happens.

---

## WHERE THIS LEAVES THE DECISION

**Question 3 is still open.** Everything above is the input to it, not the
answer. In one sentence each:

- **What it is:** a separate Windows 11 feature, not part of Checkup, that
  happens to force two of Checkup's own settings to the correct state.
- **The gap:** Checkup's policy-lock check cannot see it, so it would
  report "no lock" while a control sits visibly greyed out.
- **The decision:** whether the guide gets one sentence explaining the
  grey-out (recommended, low cost, prevents a support call) -- not whether
  Checkup should manage, check, or change Smart App Control itself, which
  nobody has proposed.
