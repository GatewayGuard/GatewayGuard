<!-- Dated: 2026-08-24 11:40 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Response to Cloud's handoff -- all seven items

- **Document Name:** GatewayGuard_CloudHandoffResponse
- **Last Modified:** 2026-08-24 11:40 ET
- **Answers:** Cloud's seven-item handoff of 2026-08-24 on
  `GatewayGuard_CloudResearch-WidgetsAndAccessibility-2026-08-24-1015.md`
- **Status:** Six done. **One deliberately NOT done, and Cloud's own status
  line is the reason.** One new defect found while doing item 7.

---

## THE HEADLINE -- ITEM 7 FOUND SOMETHING WORSE THAN ITEM 5

Cloud told me to fill the `[VERIFY-CC]` markers from the build. **The second
marker asked me to "confirm Checkup writes only the per-user taskbar value and
no policy key."**

**It does not. It writes a policy key.**

*measured, build lines 6470-6472:*

```powershell
$rp = "HKLM:\SOFTWARE\Policies\Microsoft\Dsh"
Set-ItemProperty -Path $rp -Name AllowNewsAndInterests -Value 0 -Type DWord -Force
```

**And that turns the page's "turn it back on" steps into a dead end.**

*sourced:* with `AllowNewsAndInterests = 0`, Windows treats Widgets as disabled
by policy and **the toggle in Settings > Personalization > Taskbar becomes
unavailable -- greyed out.** Recovering it means removing that value and
restarting.

**So a reader who lets Checkup turn Widgets off, then follows our own
instructions to turn it back on, finds a control they cannot click and no
explanation.** The build tells them the same wrong thing -- its Revert string
at line 6830 reads *"Settings -> Personalization -> Taskbar -> Widgets -> On"*.

**This is the "no dead ends" rule, broken by the product's own revert path.**
Cloud could not have found it; the marker it left is exactly what surfaced it.

**Fixed on the page today** -- a step now covers the greyed-out case and tells
the reader what it means and that nothing is lost. **The build's Revert string
is still wrong** and belongs in F6.

---

## ITEM BY ITEM

### 1. CURRENT.md row -- DONE, and the fix is in the generator

`CURRENT.md` is generated, never hand-edited, so a hand-added row would vanish
on the next run. **Two patterns added to `Tool2\Update-Current.ps1`:**

```
Cloud research (delivered)   GatewayGuard_CloudResearch-*.md        Multi
Review of Cloud research     GatewayGuard_ReviewOfCloudResearch-*.md Multi
```

`Multi` for the same reason the requests use it -- each is a distinct handoff,
not a version of one file. **Cloud's diagnosis was right and worth restating:
the request had a row, the answer had nowhere to appear, so the next session
could not name it.**

### 2. The two superseded drafts -- NOTHING TO RETIRE

*measured:* both are **absent from disk and untracked**. A `find` for
`*CloudResearch*` across the tree returns only the `-1015` file and my review of
it. **Neither draft ever reached the tree**, so there is nothing to retire and
no risk of a future session reading one.

### 3. The timestamp -- CONFIRMED, no rename

Filename, `Dated:` line, `Last Modified` and the internal target path all read
`2026-08-24 10:15`. Consistent, and Bill's own value. **No action.**

### 4. Rule number -- ASSIGNED, BUT THE RULE IS NOT FILED, AND THAT IS DELIBERATE

*measured:* `RULE W-01` through `W-08` exist in WebsiteStandards; gates `H-1`
through `H-4` exist. **So the number is `W-09` and the gate is `H-5`.** Cloud
inferred exactly that and declined to assert it, which was correct.

**I have NOT updated the cross-references in the four standards documents, and
here is why.** Cloud's instruction 4 says to update WebsiteStandards,
ProjectInstructions, CodingStandards and CLAUDE.md in the same pass. **But
Cloud's own status line says the file *"amends no rule until Bill approves"*
and calls 7.7 a draft.** Those two instructions contradict each other.

**Filing W-09 into four governing documents would make an unapproved rule
live**, and Bill's questions 5, 6, 7 and 10 all change what the rule says --
where it lives, WCAG 2.1 or 2.2, whether it covers Checkup's console, and
whether the site gets an accessibility statement. Filing first and editing
after is how a rule that nobody agreed to ends up being enforced.

**So: the number is reserved and recorded here. The four cross-references go in
the same pass as Bill's approval, not before.** If Bill approves 7.7 as
written, it is one edit.

### 5. The live defect on `widgets.html` -- FIXED, AND THERE WERE TWO

**Cloud's finding, confirmed.** *measured:* the sentence is on the page
verbatim and `Windows key + W` appears **zero** times.

> **Was:** *"Turning it off removes the panel and stops that data sharing."*
>
> **Now:** *"Turning it off removes the button from your taskbar, so the panel
> stops appearing while you work. The board itself can still be opened on
> purpose with the **Windows key** and **W**."*

**And a second one Cloud did not have the measurement to catch.** The note-box
said the panel *"keeps a background process running when you are not looking at
it. Anything still running is still working."*

*measured 2026-08-24 on CGDELL:* with the taskbar button off (`TaskbarDa = 0`),
**`Widgets.exe`, `WidgetService` and twelve `msedgewebview2` processes are all
running.** The page implied turning it off stops them. **It does not.** That is
precisely the claim Cloud's M-2 said must not ship until measured, and it was
already shipping.

> **Now:** *"The panel builds a record of what you read and click, and Microsoft
> says it becomes more personalised the longer you use it."*

**I applied only the minimum.** Cloud's full replacement copy in 2.8 is not
applied, because it depends on Bill's answers to questions 1 and 2. **What is
false is gone; what is a judgement is still Bill's.**

### 6. The measurements -- M-2 to M-5 ARE IN A SCRIPT, M-1 CAN BE ANSWERED IN TEN SECONDS

`Tool2\Run-SandyChecks.bat` collects M-2, M-3, M-4 and M-5 alongside the six I
already owed, read-only, one pass. **Section 7 of that script is Cloud's set.**

**M-1 does not need SANDY at all, and Bill can settle it right now.** *measured:*
CGDELL already has the Widgets button off (`TaskbarDa = 0`).

> **Press Windows key + W on CGDELL. Does the board open?**

Microsoft says yes. That one keystroke turns the page's central claim from
*sourced* into *measured*, and it gates block 7 of Cloud's draft copy.

**M-2 -- partly answered above, and not fully.** Cloud specified *"after a
restart."* Uptime here is 196 hours and nothing records when `TaskbarDa` became
0, so the strict test has not been run. **The direction is clear; the strict
form stays open.**

**M-6 -- ANSWERED, and it is the defect at the top of this document.** Cloud
asked whether Checkup writes only the per-user value. It writes a policy key.

### 7. The `[VERIFY-CC]` markers -- FILLED WHERE THE BUILD CAN ANSWER

| Marker | Answer |
|---|---|
| Exact wording of Checkup's status line for setting 14 | *measured, line 6473:* `"Windows Widgets disabled -- GOOD"` |
| Does Checkup write only the per-user taskbar value? | **NO -- policy key.** See the headline |
| The lock-screen label on each machine | **Cannot answer from here.** It is M-3 in the SANDY script, with a write-in line |
| Does the button return immediately or after a restart? | **Depends which route.** Settings toggle: immediately, and the page already says so. **After Checkup's policy write: not at all until the value is removed and the PC restarted** |

**Gate 25 not run.** Cloud asked for it before applying the draft copy. **The
draft copy is not applied**, so the gate belongs with that work, not with
today's two corrections. Both corrections were length-checked by eye and neither
touches a box border.

---

## WHAT CLOUD SHOULD KNOW FOR NEXT TIME

**Two of your handoff items were better than the research they came from**, and
both for the same reason: they named a specific thing to check rather than a
conclusion to accept. The `[VERIFY-CC]` on the policy key found a live dead end.
The CURRENT.md row diagnosis found a structural gap in the handoff chain that
had already cost a duplicated day.

**One thing to watch:** instruction 4 told me to file a rule that your own
status line says is unapproved. **When a handoff asks for an action the document
forbids, say which one wins.** I chose the status line, because an unapproved
rule in four governing documents is harder to undo than a reserved number.
