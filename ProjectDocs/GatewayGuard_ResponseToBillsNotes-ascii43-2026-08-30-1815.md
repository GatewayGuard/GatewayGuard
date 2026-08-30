# My thoughts on every item in your ascii43 test results

# Dated: 2026-08-30 18:15 ET

**Editor:** Claude Code (CGDELL)
**Your source:** `Test_Results\Ascii43-Test-Results=2-026-08-26-1701-2.docx`
**Covers:** all 41 entries, in your order, with your own numbering kept.

**FIRST, THE ANSWER TO THE OTHER QUESTION. I have made NO changes to
ascii44.** ***measured 2026-08-30 18:00:*** no file named `ascii44` exists
anywhere in the tree; the ascii43 `.ps1` is unmodified since commit `eb972b7`
on 2026-08-22; none of my three commits today touched any `.ps1`. Everything
I have produced is documents. **Nothing has been built.**

**How to read the verdicts:**

| Verdict | Means |
|---|---|
| **DEFECT** | The build is wrong. It must change. |
| **WORDING** | The build works; the words are wrong. |
| **YOURS** | A decision only you can make. |
| **RESEARCH** | Needs finding out before anyone can act. |
| **NOT A DEFECT** | Working as intended -- reasoning given. |
| **NOT MEASURED** | I do not know. I have not checked, and I am not guessing. |

---

## 1. Scr 1 -- "No flash appeared."

**NOT A DEFECT -- and this is a result worth keeping.** FT-184, the flash
before screen 1, has been hunted through three builds and never located.
**You have now run ascii43 five times and not seen it.** I would record it as
not reproducing and stop looking until it comes back. Chasing a ghost costs
more than the ghost does.

---

## 2. Scr 11 -- three items

1. **"All security setting changes made by Checkup have been thoroughly
   tested."** -- **YOURS, and I would push back before it goes in.** It is a
   strong claim in the tool's own voice. ***measured today:*** eight registry
   writes cannot report failure (FT-242), one scheduled-task flag means the
   quarterly scan never runs on battery (FT-203), and the Defender scan flag
   shipped broken for months (FT-162). **I would not print "thoroughly
   tested" until those are fixed** -- it is the kind of sentence that gets
   quoted back at you. Something like *"Every change Checkup makes has been
   tested on real home PCs"* is true today; the stronger version is true after
   ascii44.
2. **How users set up sleep mode** -- **WORDING.** Reasonable and cheap.
3. **Guidance about scheduling scans overnight** -- **NOT MEASURED.** I have
   not checked whether screen 11 says anything about overnight scheduling. It
   is a one-line check when the build is open.

---

## 3. Scr 11-14 -- three items

1. **Explain why steps 1-4 are shown** -- **WORDING, and I agree strongly.**
   This is the plain-language rule: every instruction says what it does and
   what happens if you skip it.
2. **Explain how they help the user** -- **WORDING.** Same fix, same edit.
3. **Guide-page references where needed** -- ***measured: 17 "See Guide"
   pointers exist*** and the ones I sampled do carry a location
   (`See Guide: Phase 2`, `Phase 3, Step 4`). **So the mechanism exists.**
   What is missing is page numbers, which is your Scr 27 item 5, and which
   **cannot be done until the guide is paginated.** See item 30.

---

## 4. Scr 14a -- four items

1. **Add "run" after "protection"** -- **WORDING.** Agreed.
2. **"With your approval, Checkup will run it for you"** -- **WORDING, and
   this is the best line in your notes.** It says who authorised it, which is
   the rule in `CLAUDE.md`, and it says what happens next. **I would reuse
   this exact sentence pattern across every screen that offers an action.**
3. **Explain why exit is offered here** -- **WORDING.** Agreed; a bare exit
   offer with no reason reads as the tool expecting to fail.
4. **X for Exit instead of N** -- **YOURS, still open.** See item 13.7 -- you
   ask for it twice and it needs one decision. My recommendation is in the
   summary at the end.

---

## 5. "Checkup resumed after the offline scan."

**NOT A DEFECT -- a confirmation, and a valuable one.** ***measured,
`2026-08-27_10-45` at 10:45:36:*** `User chose to RESUME from checkpoint:
OfflineScanPending`, then screen 14b at 10:46:50. **The resume path survived a
reboot and a scan.** That is the hardest path in the program and it worked.

---

## 6-8. Scr 10, Scr 11, Scr 14b -- "Add notes or follow-up items"

**These are blank placeholders in your notes.** You did not write a finding
against them. **I am not going to invent one.** If something bothered you on
those three screens and you remember what, tell me; otherwise I would treat
them as clean.

---

## 9. Scr 18 -- "I will run the Windows full scan first so I can continue working"

**NOT A DEFECT -- your test method, recorded.** Worth keeping because it
explains why the Malwarebytes screens reappear later (item 12).

---

## 10. "Restart using S."

**NOT A DEFECT.** ***measured, `2026-08-26_18-07` at 18:07:49:***
`Key 'S' accepted` -> `User chose to START OVER -- checkpoint cleared`.
Working as designed.

---

## 11. Scr 12 -- ten items. This is the richest entry in your notes

1. **Two drives shown as Drive 1 and Drive 2** -- confirmed.
2. **Checkup's labels or Microsoft's?** -- **ANSWERED. Both, and that is the
   problem.** ***measured, source line 4050:***
   `Get-PhysicalDisk | Sort-Object DeviceId`, then line 4063 builds the text
   `"Drive " + $ggDN` from a counter starting at 1.
   **So the words "Drive 1" and "Drive 2" are Checkup's. The ORDER is
   Windows'** -- lowest DeviceId first. Checkup is putting its own labels onto
   Windows' ordering, which is why the numbering looks arbitrary to you: it is
   arbitrary. It reflects which SATA port the disk is on.
3. **Reverse so the SSD is Drive 1** -- **YOURS.** My recommendation:
   **sort by role, not by DeviceId -- put the Windows drive first**, because
   that is the one the user thinks of as "my computer". That is stable across
   machines, where "SSD first" breaks on an all-SSD PC.
4. **"Drive 1 - 1 TB HDD" / "Drive 2 - 256 GB SSD"** -- **WORDING, and easy.**
   ***measured, line 4063:*** the current format is
   `"Drive 2: 238 GB (SSD)"`. Everything your format needs is already in the
   variables. It is a format-string change.
5. **Explain base-10 vs what is shown** -- **CONFIRMED AND I CAN NAME THE
   CAUSE.** ***measured, line 4057:*** `[math]::Round($ggD.Size / 1GB, 0)`.
   In PowerShell `1GB` is **1,073,741,824** bytes, not 1,000,000,000. **That
   is exactly why a drive sold as 256 GB shows as 238.** You are right that a
   senior will read it as Checkup miscounting. Two honest options: show
   `238 GB (sold as 256 GB)`, or show the maker's number and drop the
   discrepancy. **I prefer the first** -- it explains the thing they will see
   everywhere else in Windows.
6. **List Defender and Malwarebytes under antivirus** -- **WORDING.** The
   information is already known: ***measured, 10:48:02:*** `Defender active as
   primary AV. MB Free installed as companion.` The screen just is not showing
   it.
7. **"When I pressed I, I saw a message about my PC"** -- **NOT A DEFECT.**
   That is the `I` screen working.
8. **"I had to press the spacebar twice"** -- **DEFECT, and it recurs.** You
   report it again at Scr 18 item 2. ***measured, `2026-08-30_11-04` at
   12:55:47 and 12:56:49:*** `Show-CheckupInfo` returns and the underlying
   screen needs its own continue. **The `I` screen consumes one keypress and
   the screen beneath it wants another.** One fix covers both reports.
9. **"I moved to Scr 13"** -- expected.
10. **"I could not return to Scr 12"** -- **DEFECT, and it is the B-for-Back
    work.** Screen 12 ends at a `Pause-ForUser`, which offers Back only when a
    screen snapshot exists (FT-146). **Not measured: whether a snapshot
    existed at that moment.** Worth checking as part of the Back pass.

---

## 12. Scr 13-14 -- the screens appeared again

1. **Confirmed** -- and expected, because you restarted with `S` and cleared
   the checkpoint (item 10).
2. **"Determine whether users need to see these screens again"** -- **YOURS,
   and it is a real product question.** The tool already records what was
   done: ***measured:*** checkpoints `DefenderAV` and `Malwarebytes` are
   written. **So Checkup CAN know. It is not asked to.** My view: on a repeat
   run, replace the full briefing with one line -- *"You ran this on 27
   August. Run it again?"* -- and keep the full screens for first runs. This
   is the same family as your Scr 18 item 1.

---

## 13. Scr 14a -- seven items

1. **Add "Run" before "quarterly" and "monthly"** -- **WORDING.**
2. **Explain scans may have run in a previous session** -- **WORDING**, and it
   depends on item 12.2 being decided.
3. **If Checkup handled the results, say they may not need to run again** --
   **WORDING**, same dependency.
4. **Retitle in plain English** -- **WORDING.** Agreed. "REMINDER: PRE-SCAN
   RECOMMENDED" is tool-speak.
5. **First run: "Virus scans are recommended."** -- **WORDING.** Good.
6. **Later runs: wording based on what they did before** -- **DEFECT-ish, and
   the biggest of the seven.** It needs the build to read its own checkpoints
   and branch. Not hard, but it is code, not copy.
7. **Q for Quit, E for Exit, or preferably X for Exit** -- **YOURS.** Second
   time you ask. See the summary.

---

## 14. Scr 16 -- four items

1. **"Appeared to skip Scr 15"** -- **NOT MEASURED, and I want to be careful
   here.** ***measured:*** in every log, screen 14a is followed directly by
   screen 16. **I have not established whether a screen 15 exists at all.**
   If it does not, the number is simply unused and the fix is the numbering
   table. If it does, something is skipping it. **This is a ten-minute check I
   have not run.**
2. **No Back button** -- consistent with Back working on pages but not at
   questions. Part of the B pass.
3. **and 4. The two screenshots (21 and 22)** -- **THE BIGGEST HOLE IN THE
   WHOLE REVIEW.** They are in
   `C:\Users\willi\OneDrive\Personal\Pictures\Screenshots`, **not in the
   repository, and nobody has looked at them.** You describe "something
   unusual" twice and the logs show nothing anomalous at that point. **The
   screenshots are the only evidence that exists.** Copy them into
   `Test_Results\` and I can triage them.

---

## 15. Scr 18 -- three items

1. **"Can Checkup again determine what the user did previously?"** -- **YES,
   and see item 12.2.** The checkpoints already hold it.
2. **"After selecting N, I still had to press the spacebar"** -- **DEFECT.**
   Same as item 11.8. One fix.
3. **"Check for this issue throughout the program"** -- **agreed, and it
   should be a mechanical sweep**, not a per-screen hunt: find every place a
   `Read-ValidKey` answer is followed by a `Pause-ForUser` with nothing shown
   between them. That pattern is always a wasted keypress.

---

## 16-17. "No screen number -- checking power status / power-related settings"

**DEFECT, minor but real.** ***measured, `2026-08-28_17-29` at 18:53:14 and
18:56:07:*** `Test-PowerStatus` and `Run-PowerSettingsCheck` write log lines
and take a keypress **without rendering a numbered screen.** The user is
answering something that has no identity. **Either give them a number or do
not stop for a keypress.**

---

## 18. Scr 19 -- five items

1. **"Implement line count policy"** -- **agreed.** Screen 19 is one of the
   ten oversize screens carried in the baseline. It is on the list to split.
2. **"Clarify how Checkup knows password on wake is not required"** --
   **WORDING**, and it pairs with your "HOW DO WE KNOW" at Scr 29. See the
   note under item 35 -- I think this is one idea, not two.
3. **"Could not reread the setting -- can it be read reliably?"** --
   **DEFECT, intermittent, and now measured properly.** ***three runs, same
   machine, same build:*** failed 08-27 12:46, failed 08-29 07:50, **worked
   08-30 15:31.** So it is not "cannot be read" -- it is unreliable.
   **Do not let anyone fix this by guessing.** Instrument the re-read, log
   both attempts, then fix what the log shows.
4. **"Avoid telling users Checkup is simply skipping these items"** --
   **WORDING, and I agree hard.** "Skipping" tells the user nothing and sounds
   like the tool gave up.
5. **"Explain Checkup will guide them through settings Microsoft requires
   them to change manually"** -- **this is the right replacement**, and it is
   the same sentence you land on repeatedly. See the summary.

---

## 19. Scr 20 -- "Something flashed briefly, possibly a running-apps message"

**NOT MEASURED.** ***measured, 12:50:38-12:50:39:*** the apps audit starts and
completes in **one second**, and screen 20 renders between. **Something almost
certainly did flash** -- most likely a progress line with no pause, the same
family as screen 32 (FT-244). **I have not located it in the source.**

---

## 20. Scr 22 -- four items

1. **"Tells the user to see the guide but does not say where"** --
   **WORDING, confirmed as a real pattern.** ***measured: 17 "See Guide"
   pointers***, and while the ones I sampled carry a phase and step, **your
   report says at least one does not.** Worth a sweep: every guide pointer
   gets a location.
2. **"Revise this wording throughout"** -- agreed, same sweep.
3. **"Press Enter or Space to continue Checkup"** -- **WORDING.** Good, and it
   matches what `Pause-ForUser` already says elsewhere. Consistency is the
   point.
4. **"Checkup disappeared and then resumed"** -- **NOT MEASURED and it
   worries me more than the rest of this entry.** The log shows no gap or
   error at that point. A window that vanishes and returns is either the
   console being redrawn or something external. **If it happens again, note
   the exact time** -- that is what makes it findable.

---

## 21. Scr 22 (second entry) -- four items

1. **and 2. "Asked for the password again, entered M again"** --
   ***measured, `2026-08-27_10-45`:*** the password-manager question was
   answered **three times** -- 12:55:16 `Y`, 12:59:24 `N`, 12:59:57 `N`. **But
   each was preceded by `Nav 'BACK'`.** So the tool re-asked because you went
   back to it, which is correct behaviour. **NOT A DEFECT as logged** -- but
   if it asked without you navigating back, that is a real defect and the log
   does not show it. **Which happened?**
3. **and 4. "After I selected I, the sequence did not look right when I chose
   B on the information screen"** -- **DEFECT, and this is a good catch.**
   The `I` screen is reachable from everywhere and deliberately has no number.
   **So "Back" from it has no single correct destination.** ***measured,
   12:47:30-12:50:38:*** the info screen was opened three times in a row
   before the underlying screen continued. **The interaction between `I`,
   `B` and the screen underneath is not well defined**, and it should be
   before the B pass, or the B pass will inherit the confusion.

---

## 22. Scr 23 -- six items

1. **"Says 'what you saw' but the user did not see anything"** -- **WORDING,
   confirmed.** ***measured, source line 6722:***
   `"  What you saw was what was FOUND on your PC -- nothing was..."`.
   You are right; at that point they have seen a list, not an event.
2. **"The main point is that Checkup checked the settings"** -- **agreed, and
   this is the sharper observation.** The screen leads with a denial (*nothing
   was changed*) instead of the achievement (*everything was checked*).
3. **Rework to state what Checkup just did and what comes next** --
   **WORDING**, and it is a rewrite of the whole screen rather than a line.
4. **"With your approval, Checkup can change what it is allowed to, and will
   guide you through the rest"** -- **this is the sentence.** It is your Scr
   14a item 2 again. Same words, different screen.
5. **"Tamper protection essential, Windows Hello strongly recommended -- or
   essential if that is the policy"** -- **YOURS.** The question inside your
   own note is the real one: **is Windows Hello essential or recommended?**
   Checkup currently treats it as a check-only manual item. **Pick one word
   and it propagates everywhere.**
6. **"Same for sleep setting"** -- **YOURS**, same shape.

---

## 23. The "Aside" -- your 20-point research list

**None of this is a defect. All of it is design, and you asked for a plan in a
`.md` before anything is built. That is the right instinct and I have not
written it yet.** My thoughts on the ones where I have something useful:

- **1. Reorder the run: tamper protection, then Windows Update to completion,
  then blocking sub-options, then scans.** **I think you are right**, and the
  reason is stronger than tidiness: ***measured*** -- Windows turned real-time
  protection back on by itself mid-test (FT-239), and the WTDS registry cannot
  be read at all while Tamper Protection is on. **The machine's state changes
  underneath the tool depending on these settings.** Establishing them first
  makes every later reading trustworthy. **This is the most valuable item in
  your list.**
- **2. Detect tamper protection indirectly by trying a blocked read.** -- **We
  already have the evidence that this works.** ***measured on both machines:***
  `WTDS\Components` is unreadable when Tamper Protection is on, and the tool
  already catches exactly that and reports "Unknown". **The signal exists; it
  is just being thrown away instead of used.** Cheap and clever.
- **3. Apply Windows updates automatically.** -- **RESEARCH, and I am
  cautious.** Driving Windows Update programmatically on Home is limited and
  can leave a machine mid-update. **My instinct is to check and instruct, not
  to apply.** Worth researching properly before deciding.
- **4. Is Malwarebytes still needed?** -- **THE BIGGEST QUESTION IN YOUR
  NOTES.** It reaches pricing, the licence, the guide, four screens and the
  monthly reminder task. ***measured, SANDY 2026-08-28:*** Malwarebytes found
  **12 of 12** specimens; so did Defender's full scan. **On that evidence
  alone Defender is not obviously worse.** But detection of test files is not
  the same as PUP detection in the wild, which is what Malwarebytes is
  actually there for. **RESEARCH -- and it must not be settled on the EICAR
  result, which proves nothing about PUPs.**
- **5. Recover the 18 PUPs from SANDY for testing.** -- **Good idea and time
  sensitive.** If they were quarantined, they are recoverable now and gone
  after the quarantine ages out. **Worth doing before anything else on this
  list.**
- **6-8. Password managers, password change frequency, 2FA, authenticator
  apps.** -- **RESEARCH, and it is guide content, not tool content.** Current
  expert consensus has moved against forced rotation, which supports your
  instinct about leaving a strong password alone with 2FA on. **The
  authenticator display-time question has a real answer worth finding** --
  codes are valid for a window, and most apps show the next one early, which
  is exactly the behaviour you noticed.

---

## 24. Scr 24 -- eight items

1. **Confirm the info is explained the same way on the settings screens** --
   **NOT MEASURED.**
2. **Can Checkup uninstall apps with approval?** -- **IT ALREADY DOES.**
   ***measured, source lines 5544 and 5584:***
   `Uninstall $($app.Name)? (Y = Yes / N = Skip / S = Skip all)`. **The
   capability exists.** Your question may be about a different screen -- worth
   pinning down.
3. **and 4. If not, explain how, and where** -- see above; probably moot.
5. **"I did not work on this screen"** -- noted, no finding.
6. **and 7. "Every screen that supports I should display it as an option"**
   -- **DEFECT, and the measurement is stark.** ***measured: `I` works at all
   47 question prompts and every pause screen, but the words "Press I" appear
   exactly TWICE in the entire file*** -- once inside the wrong-key error
   message, which only appears after you have already pressed something wrong,
   and once on a single screen. **A feature that works everywhere and is
   advertised almost nowhere.** You found it by accident, which proves the
   point.
8. **"Users should write down the info and the screen number"** --
   **WORDING**, and it is a good idea for support calls. It is also the
   argument for the screen numbering being right, which is item 35.3.

---

## 25. Scr 25 -- setting 6 and setting 9 wording

**"What are you checking when you say TP blocks this?"** -- **ANSWERED.**
***measured, source line 5946:*** Checkup tries to read
`HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components` and Windows
refuses. ***measured on both machines, elevated: it cannot be read on
either.*** **So yes, it is truly blocked** -- and your proposed wording,
**"Must be set manually -- Checkup will show you how,"** is accurate. Same for
setting 9.

**And there is a live bug attached to this that you should know about.**
***measured, source line 6406:*** the screen says *"turn ON all 3 options"*
**beside four visible checkboxes**, and you turned on all four during the
measurement. The fourth is a data-collection box, not a protection one.

---

## 26. Scr 26 -- three items

1. **"Screen positioning too wide"** -- **DEFECT, confirmed with numbers.**
   ***measured, 12:57:10:*** at a 175-column window, screen 26 allocates
   `name 126 (content needed 41), status 38`. **The name column gets 126
   columns to display 41 characters -- 85 wasted.** Screen 25, the same
   checklist, splits the same window `name 70 / status 94`. **Two pages of one
   list using different geometry.** Real, measurable, and fixable.
2. **Settings 12-15 and 17 to use screen 26's status wording** -- **WORDING.**
3. **"Windows key print screen is accepted as an entry"** -- **CONFIRMED, and
   milder than you think.** ***measured, 12:56:55:***
   `Checklist: key ignored ( )`. **The key is rejected, not acted on** -- so
   nothing was wrongly selected. But you are right that **you cannot take a
   screenshot**, and for a tool whose support model is "send us what you saw",
   that matters. **I would call it a real usability defect, not a data
   defect.**

---

## 27. Scr 25-26 -- three items

1. **"I works, but the spacebar doesn't show what the letters do"** --
   **DEFECT**, and it is item 24.6/24.7 again from the other side. The
   checklist legend does not list its own commands.
2. **Your checklist item 8 -- entering "12"** -- **ANSWERED, and it works.**
   ***measured, 14:29:22:*** `Checklist command '12' accepted` -> selection
   count drops 6 to 5. **Two-digit entry commits on the second key.** Your
   note says it "did not say anything new" -- correct, and that is arguably
   the defect: **a silent toggle on a two-digit entry gives no confirmation.**
3. **"Your checklist 9 & 10 worked"** -- noted, good.

---

## 28. Scr 25d -- three items

1. **"Change to 26d, and is there a 25a/b/c?"** -- **DEFECT, and you are
   right about the direction.** ***measured, 14:36:31:*** you were on **screen
   26**, pressed `R`, and landed on **screen 25c** -- a first-encounter
   decrease, which is exactly what the numbering scheme exists to prevent.
   **25c does exist; 25a and 25b I have not confirmed.** The whole block is
   reachable from 26, so renumbering to 26c/26d/26e is the right shape.
2. **"Add save to USB drive"** -- **YOURS, and I would say yes.** A recovery
   key saved only to a Microsoft account is no help to someone locked out of
   that account.
3. **"Will encryption encrypt a plugged-in USB drive?"** -- **RESEARCH, and
   an important one.** My understanding is that Device Encryption on Home
   covers internal fixed drives only, and removable drives need BitLocker To
   Go, which Home does not offer. **But I have not verified that, and you
   should not act on it until someone does.** It goes on the SANDY encryption
   run.

---

## 29. Scr 25e -- item 8 flashed but did not take

**DEFECT, and the log backs you up.** ***measured, 14:53:03 to 14:53:33:***
item 8 was toggled **four times in thirty seconds** across both pages --
selected, deselected, reselected. **Item 8 is Drive Encryption, which is
ALSO driven by the 25c/25e decline flow.** So two different controls move the
same flag, and pressing `8` can appear to do nothing because the other path
has just moved it back. **That is a genuine state bug, not a display glitch.**

---

## 30. Scr 27 -- five items plus the "6 items" wording

1. **"Did not see 'choices can be reviewed in your log'"** -- **DEFECT,
   confirmed, and worse than you knew.** ***measured: exactly one occurrence,
   source line 7428***, inside `Show-BitLockerFinalDecline` -- **screen 25e**,
   which you only reach by **declining** encryption. `CLAUDE.md` requires it
   on the review screen. **Anyone who accepts encryption never sees it at
   all.**
2. **"Screen too long"** -- agreed, on the split list.
3. **"Don't use N to go back, use B"** -- **DECIDED BY YOU TODAY.** 7 prompts
   change. Full list in the triage document.
4. **"Remove 'applying' next to Xs that will be applied"** -- **WORDING,
   located.** ***measured, source line 8493:***
   `"  [X] APPLYING  {0,2}. {1,-38} {2}"`. **I agree with removing it** -- the
   screen's own title says nothing has been applied yet, so the word
   contradicts the heading directly above it.
5. **"Give page numbers in the guide"** -- **BLOCKED, and worth saying
   plainly.** The guide draft still carries **one `page 00` in the text and 19
   bare `| 00 |` table cells.** **Page numbers cannot be written into the tool
   until the guide is paginated.** This is a real dependency, not a delay.
6. **"Starting 6 items -- change to 'These must be set manually, Checkup will
   show you how'"** -- **WORDING**, and this is the sentence that resolves
   five separate screens. See the summary.

---

## 31. Setting 6 -- two items

1. **"Spacebar repeats 'manual is required' -- remove, unnecessary"** --
   **WORDING.** Agreed, it is the pedantic-phrasing rule.
2. **"Says Checkup is applying this now -- not true. Remove"** -- **DEFECT,
   located, and it is the most quietly dangerous line in your notes.**
   ***measured, source line 8684:***
   `"  You selected this item, so Checkup is applying it now."`
   **For setting 6, Checkup cannot apply it** -- the registry is blocked, and
   the same run reported `MANUAL REQUIRED` a moment later. **So the screen
   says it is doing something it is about to say it cannot do.** This is the
   FT-242 family in prose rather than code.

---

## 32. Setting 9 -- "uses another different wording"

**WORDING, confirmed as a real inconsistency.** ***measured: the build
contains only ONE instance of the phrase "MANUAL REQUIRED"*** (line 6400), so
the other manual-path screens are each phrasing it their own way. **Your one
sentence replaces all of them.**

---

## 33. Scr 13, 14, 17 -- "do the same as setting 6", and "do we need to say this at all?"

**Your instinct here is the interesting part**, and I think you are right.
*"If the console status says it already and they selected it ... I think we
can do away with these and just provide them with the details on how to
manually change these settings since they have approved them."*

**That is FT-219 -- selection is approval -- extended to the manual items.**
It is already the rule for automatic changes. **There is no principled reason
the manual ones should re-ask.** I would apply it, and it removes screens
rather than adding them.

---

## 34. Scr 28 -- two items

1. **"On Home the user must turn on encryption themselves"** -- **TRUE ON
   SANDY, and it should be verified as a general claim.** ***measured,
   16:06:28:*** `BitLocker/Device Encryption: Home edition -- manual path
   shown across 4 screens, no changes made by Checkup`. **So the build already
   behaves this way.** Whether it is true of *all* Windows 11 Home machines is
   the research you ask for, and it matters because the screen states it as a
   fact.
2. **"Then give the instruction how, for each, and tell them to go do it"** --
   **WORDING**, and it is the no-dead-ends rule.

---

## 35. Scr 29 -- four items

1. **"TPM READY -- GOOD -- HOW DO WE KNOW"** -- **WORDING, and I think this
   is one of your best points, repeated from Scr 19.** ***measured,
   15:38:24:*** `Device Encryption prereq check -- TPM: True, SecureBoot:
   True, WinRE: True`. **The readings are correct.** What is missing is that
   the screen asserts a verdict without saying what it looked at. **A senior
   being told "GOOD" with no basis has been asked to take it on faith** --
   which is the opposite of this product's promise. One short clause each.
2. **"What if one or all are not on? Need step by step"** -- **DEFECT, and
   this is a dead end in the strict sense of the rule.** The screen reports a
   failure state and offers no route out of it. **Three remedies needed, one
   per prerequisite.**
3. **"Screen number is in a different place -- fix on 25, 28 and every other
   screen"** -- **agreed, and it should be mechanical.** The coverage checker
   is the right place to enforce a fixed position.
4. **"Do the guide and website have these instructions?"** -- **NOT
   MEASURED.** Worth checking against the guide draft.

---

## 36. Scr 30 -- "2nd paragraph needs checking when we run encryption on Sandy"

**Agreed, and it goes on the encryption run list.** Noted, no action until
then.

---

## 37. Scr 30b -- "is there a scr 30a?"

**NO, AND THAT IS A DEFECT.** ***measured:*** `SCREEN-79` shows as **30**,
`SCREEN-80` shows as **30b**. **Nothing shows as 30a.** To a reader a screen
is missing. Same family as item 28.

---

## 38. Scr 31 -- "need to verify when encrypting Sandy"

**Agreed.** On the encryption run list.

---

## 39. Scr 33 -- two items

1. **"Is there a screen 32?"** -- **YES, AND YOU NEVER GOT TO READ IT. This
   is a defect.** ***measured, both at 16:09:43, same second, no keypress
   between:*** screen 32 `ALL SELECTED ITEMS PROCESSED` then screen 33.
   ***measured, source lines 8735-8741:*** the box is drawn and
   `Setup-ScheduledTasks` is called immediately. **There is no pause.**
   `CLAUDE.md` requires one on every screen.
2. **"Set up an auto check and tell them the answer"** -- **agreed, and there
   is a live defect underneath it.** ***measured, 16:09:43-44:*** both tasks
   log `[GOOD] Scheduled task created`. **But both carry
   `DisallowStartIfOnBatteries`, so on a laptop on battery they never run** --
   and the log still says GOOD. **Your auto-check would have caught this.**
   That is FT-203, already measured, fix already written, still not built.

---

## 40. Scr 33a -- three items

1. **"Edge startup boost asked again. Wrong. User already selected it."** --
   **DEFECT, and you are right on the principle.** This is FT-219 --
   selection is approval -- not reaching the convenience review. **And "had an
   error, check logs" -- I checked.** ***measured, 16:34:21:*** immediately
   after Widgets was declared GOOD, `SILENT ERROR ... Attempted to perform an
   unauthorized operation ... line 6472`. **That is FT-242: the write was
   refused and the tool reported success.** Your instinct to check the log was
   exactly right.
2. **"Screen 33a is too long"** -- on the split list.
3. **"Scr 34 appeared at the bottom of Scr 33b"** -- **DEFECT**, same family
   as screen 32. ***measured, 16:40:14:*** screen 34 renders in the same
   second the convenience review returns, with no screen clear.

---

## 41. Scr 34 -- two items

1. **"Says automated scans are finished ... terminology is incorrect"** --
   **CORRECT, and confirmed.** The screen is titled **AUTOMATED STEPS
   COMPLETE**, and ***measured:*** **no scan ran in that session at all** --
   the offline scan was skipped at 18:44:32 and Malwarebytes at 18:53:09.
   **A completion screen naming work that did not happen.**
   **"I checked edge startup boost, no change, still off"** -- **and this is
   the field evidence for FT-242.** The log says `Before: Unknown -- could not
   check` and then `GOOD`. **It never read the setting before or after.**
2. **"User is never told how to make the manual changes he approved"** --
   **DEFECT, and it is the largest single gap in the whole run.** The user
   approves six manual items and reaches the last screen without instructions
   for any of them. **Everything in your notes about "Checkup will show you
   how" is worthless if the showing never happens.** This should be a screen
   of its own before the end.

---

# WHAT I TAKE FROM ALL 41, AS A WHOLE

**You wrote the same sentence five times without being asked to, and it is the
right one:**

> **"These must be set manually, Checkup will show you how."**

It resolves settings 6, 9, 13, 14, 17, the six-item block and screen 28. **It
is the F6 wording block, and you have already written it.**

**Three things in your notes are worth more than the rest put together:**

1. **Item 41.2 -- the user is never shown how to make the manual changes.**
   Everything else is polish next to a promise the program does not keep.
2. **Aside item 1 -- reorder the run.** Tamper protection and Windows Update
   change what every later reading means. **The order is a correctness issue,
   not a tidiness one.**
3. **Item 40.1 -- you checked the log when something looked wrong**, and it
   found the worst defect in the build.

**One caution about item 2 (Scr 11).** I would not print *"thoroughly
tested"* until the eight writes are fixed. **That sentence and FT-242 cannot
both be true at the same time.**

**Two decisions I need from you**, both of which block work:

- **`X` for Exit** -- you asked twice (items 4.4 and 13.7). My recommendation:
  **yes, `X` for Exit, but AFTER the `B` change ships and is field run.**
  Changing two of `N`'s three meanings at once brings the confusion back
  wearing a new letter.
- **Windows Hello -- essential or recommended?** (item 22.5). One word, and it
  propagates through the tool, the guide and the website.

**And one thing I need from you that costs a minute:** **screenshots 21 and
22.** They are the only record of what happened on screen 16 and they are
sitting outside the repository.
