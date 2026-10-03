<!-- Dated: 2026-09-25 13:08 ET -->
<!-- Editor: Claude Cloud -->
# Cloud review, 2026-09-25 -- the ascii44 triage decisions, Guide Part 3 checked, and a Part 4 outline

- **Document Name:** GatewayGuard_CloudReview-ascii44Triage-GuidePart3-Part4
- **Last Modified:** 2026-09-25 13:08 ET
- **Last Editor:** Claude Cloud
- **For:** Bill, then Claude Code
- **Status:** REVIEW. Decides nothing; amends no rule. Three deliverables in one file because Bill asked for one file.

---

## PROVENANCE (Cloud Working Rules, steps 1-5)

1. **Stamp of the copy read** (measured from `ProjectDocs/CURRENT.md`): Generated **2026-09-25 11:05 ET**, commit **`11710d8`**, made 2026-09-25 10:51 ET, subject *"Remove 371 files OneDrive already dropped from disk; kept in history (Bill approved)."* Session-log heading match confirmed from the log itself: `## Session: 2026-09-25 11:04 [Claude Code -- CGDELL] -- AFTER THE PC RESET: GIT BACK, 371 FILES RETIRED, ascii44 TRIAGED, AND PASSWORD-ON-WAKE WAS NEVER READABLE ANYWHERE`. 81 rows; I saw the first four groups and the "Guide gap-fill ... ascii41 findings" group.
2. **Base files, each named in `CURRENT.md`:**
   - Task 2: `GatewayGuard_FieldTestTriage-ascii44run1-2026-09-24-2353.md`
   - Task 3: `GatewayGuard_CoPilotGuidePart3-2026-09-16-1627.md` (its own header says it is the live text after R-01 to R-29 on 09-17 and Bill's inline comments on 09-24)
   - Task 4: `GatewayGuard_GuideRewrite-Draft-2026-08-22-1000.md` (the old draft), `GatewayGuard_GuideSectionReplacementsPack2-2026-08-23-1816.md` (for the old draft's Phase 3 / Phase 5 / Firefox / Getting-help structure), and the ascii44 build's settings table for the `Revert` strings.
3. **How read:** all via `project_knowledge_search`, in fragments. **Triage:** Parts 0, 1 (runs table), 2 (notes 13-15, 19-28, 32), 3 (whole summary table), 4A, 5 (FT-268 to FT-285), 6 (all twelve decisions, complete), 7 (all six). **Part 3 twin:** opener; settings 10, 11, 12, 13, 14, 15, 18, 19 in full; the grey-control note; the Part 4 lead-in. **Old draft:** the index build list (which names every section that exists), section 0, the pack-2 block table. I did not read the old draft's Phase 3 or Phase 5 bodies; the outline in Part C places them by section name, not by rewriting them.
4. **Carried forward from a draft as fact:** nothing. Where I cite a measurement it is Claude Code's, named. Where I cite my own earlier research (09-05, 09-08) it is labelled as such.
5. **Not seen, and what it changes:** the triage's Part 2 notes 1-12 and 16-18, 29-31 in full (I have their one-line rows in Part 3's table); `Co-Pilot-ASCII45 Detailed Build Plan-2026-09-16-0942.txt` beyond the fragment that surfaced -- enough to see its FT numbers, not its whole plan; the old draft's Phase 3 body. None of the three changes an agree/disagree below; the first would only add detail to decisions 3 and 9.

**Labels:** ***measured*** (Claude Code, output named) / *sourced* (vendor/standard, named) / *inferred* / *guess*. Only measured and sourced may enter the tool or the guide.

---
---

# PART A -- THE TWELVE DECISIONS IN THE ascii44 TRIAGE

**Overall:** I agree with eleven of twelve recommendations as written and with the twelfth in substance. What the triage missed is not inside any one decision; it is across them, and it is in section A-13.

| # | Decision | Agree? | One line |
|---|---|---|---|
| 1 | B = go back one step; L = look at the previous screen | **Yes** | Ship FT-271 with it or the next field run cannot tell "B did nothing" from "B was not offered" |
| 2 | Drop the ownership Y/N on resume; keep silent re-checks | **Yes** | Keep the Machine-ID comparison; the state file may travel |
| 3 | Checkpoint-level resume, more checkpoints, 1b says where | **Yes** | The checklist checkpoint needs selections persisted -- new code, say so |
| 4 | FT-219 wins; 11-15 apply in the main run; 33a/33b become Was/Now + Steps-for-you | **Yes** | The Was/Now screen must carry the manual revert for 13, 14, 15 and print ERROR honestly (FT-283/284) |
| 5 | Remove GUI mode for launch | **Yes, strongly** | Do it before Decision 1 -- it removes a third of Decision 1's scope |
| 6 | Tamper -> Windows Update -> offline offer -> Defender full scan by Checkup | **Order yes; full-scan-by-Checkup not for launch** | Offer and instruct; read `FullScanEndTime`, never assert "finished" |
| 7 | 2FA: one screen line + a guide page | **Yes** | The guide page is Part 5 in the outline below |
| 8 | Guide references: title + page number, one pass, when final | **Substance yes; page numbers no** | Five print sizes = five paginations. Use the setting number |
| 9 | Always show "save your work" before the offline scan | **Yes** | Nothing to add |
| 10 | WoL: log every adapter; show them only when one is ON or unreadable | **Yes** | Name the adapter on screen the way Device Manager does |
| 11 | Item 12: SANDY flip test, then a fallback read | **Yes** | Same method that closed FT-123b |
| 12 | Screen 19 report-only; checklist is the one place 17-19 change | **Yes** | FT-268 `/qh` still needs the SANDY measurement first |

## A-1. What B means

**Agree.** The rule "one key, one meaning" is the right one and the triage's split -- B navigates, L looks -- is the only split that satisfies it. ***Measured (FT-259): `L` is free in every key comparison.***

**Two conditions, both already in the triage but worth making non-optional:**
- **FT-271 ships in the same build.** Today an unoffered B is swallowed and unlogged (line 2720). If B becomes navigation and the next field run says "B did nothing," nobody can tell a missing B from a broken one. Log every ignored key.
- **Where a step cannot be redone, say so on screen.** After a write, after the reboot: *"This step is done and cannot be reopened. Press Enter to continue."* Silence there is the same defect in a new place.

**Missed:** Decision 5 removes the GUI, which removes the GUI half of Decision 1 (note 26's "no route back to the mode selector"). **Sequence 5 before 1** and Decision 1 shrinks to five console sites.

## A-2. The ownership question on resume

**Agree** -- with the Machine-ID check kept, not dropped. **The reason the check matters, *inferred*:** `$StateFilePath` is `"$StateDir\gg_state.txt"` (line 1649). If `$StateDir` is inside the OneDrive folder, as the log is, the state file follows the Microsoft account to a second PC, and a resume there is possible. The Machine-ID comparison catches exactly that case and asks the question only then. *Not measured:* what `$StateDir` resolves to. Claude Code can confirm in one line.

## A-3. How resume lands

**Agree.** Checkpoint-level, with checkpoints at 21, 23/24 and the checklist, and a 1b sentence naming the stop and the resume screen. Photo-exact resume is not worth building.

**Missed:** the checklist checkpoint is described as "selections saved," but ***measured (FT-204): the selections live in memory*** -- `N` used to wipe them, which is why FT-204 exists. Persisting them is new state, new code and a new field-run item. Not an argument against; an argument for listing it as work rather than as a checkpoint name.

## A-4. Convenience items 11-15

**Agree: FT-219 wins.** Two rules that contradict each other is the FT-236 shape, and the newer one is Bill's.

**What the replacement screens must do that the triage does not spell out:**
- ***Measured (build settings table): items 13, 14 and 15 have `RegPath = $null` -- "manual revert only."*** The **"What Checkup changed"** Was/Now screen must print the manual revert path for those three, from the build's own `Revert` strings, or the reader has an undo for 11 and 12 and none for 13-15.
- ***Measured (FT-283): the Widgets policy write was refused on SANDY, elevated, cause undetermined.*** Moving item 14 into the main run does not fix that. The Was/Now line for 14 must be able to say *"Could not change -- here is how to do it yourself"* in yellow, not green (FT-284).
- **Rename the replacement screens now** so the screen-numbering table and the guide's Part 4 (below) can point at them.

## A-5. GUI mode

**Agree, strongly.** I recommended dropping the "recommended" label on 09-05; seven measured defects and a first field run that ended in a Ctrl+C settle the rest. **Remove option 2 from the launch build.**

**Two follow-ons the triage does not list:** grep the website, the licence v3.1 and the store copy for "two modes" / "GUI" / "option 2" -- I did not find any in the licence Sections 1-9 when I wrote them, but Claude Code should measure it; and update `ScreenNumberTable` so screen 21 loses its second branch.

## A-6. The scan plan without Malwarebytes

**Agree with the order.** Tamper Protection first (my items 1-2), Windows Update **check-and-instruct** (my items 3-5, and agreed with Claude Code on 09-05 that apply-and-loop is post-launch), the offline-scan offer with the FT-276 warning, then the full scan. **Add one step: PUA blocking on, with approval, before either scan** (my item 7, *sourced Microsoft*). The 09-07 test showed why: Defender's on-demand scan flags nothing it does not classify, and PUA off means it classifies less.

**Disagree with one part for the launch build: Checkup starting the full scan in the background.** Three reasons:
1. It is new capability with no field run, three weeks from 2026-10-15. The UNRUN BUILD RULE applies.
2. ***Measured (FT-277): 14b already asserts "scan has finished" without reading anything.*** A background scan started by Checkup makes that assertion worse unless it is replaced by a real read. *Sourced, Microsoft Learn, `Get-MpComputerStatus`:* the object carries **`FullScanStartTime` and `FullScanEndTime`** (and the Quick equivalents). That is the honest "finished" read, and it works whether Checkup or the user started the scan.
3. ***Measured (SANDY, screen 12): SANDY has a 1 TB HDD.*** A full scan of that drive is hours. Bill's own ascii43 note was "I will run the Windows full scan first so I can continue working." **Offer it, tell the reader how to start it in Windows Security, and read the end time on the next run.** Ship the start-it-for-you version in the build after launch, when `Start-MpScan -ScanType FullScan` has a VERIFIED comment.

**Confirm scope:** Tamper first, WU check, PUA on, offline offer, full-scan offer -- **yes, that set is ascii45.** Starting the scan is ascii46.

## A-7. 2FA on screen 34

**Agree.** One line on screen, the substance in the guide. The guide destination is **Part 5, "Passwords and two-step sign-in"** in the outline below -- it was writing job 1 in the 09-05 note to me and it is unwritten. Until Decision 8 is settled, the on-screen line says *"the guide shows how -- Part 5"* not *"page N."*

## A-8. Guide references

**Agree on the mechanism: one table in the build, replaced in one pass when the guide is final.** ***Measured (FT-226 class, old draft §0.3): six settings carry `GuideRef="Keep vs. Disable Table"`*** -- a table name, not a destination. The pass must cover those six as well as the "Phase 1, Step 4" family.

**Disagree on page numbers, and this is the catch the triage missed.** ***Measured (store, 2026-09-04): the Guide sells in five print sizes with identical wording.*** Five sizes means five paginations. A page number in the tool is right for at most one of them and wrong for four. Bill's field note 27 asked for page numbers; the answer is that they cannot be one number.

**Use the setting number.** It is the same in all five sizes, it is Checkup's own ID, and Part 1's quick-reference table already says the two match. `GuideRef="Setting 14"` (or "Part 3, Setting 14") is right in every size, never goes stale when pagination shifts, and is what the reader sees on Checkup's screen already. Page numbers can still be printed *in* the guide's own quick-reference table, per size, where they are generated at export.

## A-9. Offline-scan prep on repeat runs

**Agree.** ***Measured (FT-276): the reboot comes 5 s after Y.*** A senior with an open document loses it. Every run, not the first.

## A-10. Wake-on-LAN per adapter

**Agree.** Log every adapter and every wake property; show them only when one is ON or unreadable. **One addition:** on screen, use the adapter's name as Device Manager shows it, because Decision 12 sends the reader to Device Manager for the manual path and "Wi-Fi 2" must match what they see there. ***Measured: SANDY has three adapters; CGDELL's Ethernet reads Enabled.***

## A-11. Diagnostic Data effective state

**Agree.** The FT-123b method -- read-only script, Bill flips the setting, read again -- is the one that has worked three times. *Guess:* the user-facing level lives outside `HKLM\...\Policies\...\DataCollection` because that key is the policy, not the choice; the flip test will name the real key. Do not build the fallback before the flip.

## A-12. Screen 19 versus checklist items 17-19

**Agree.** Report-only on 19; one apply path. ***Measured (FT-242): the second apply path in `Apply-PowerSettings` is where an unguarded write hid.*** Removing it removes a class.

**Two conditions:** (a) screen 19's three Y/N prompts go, not just the writes; (b) ***FT-268 `/qh` on SANDY (Part 7 item 5) is measured before item 17 can ever print GOOD*** -- on CGDELL it never could (session log 09-25: "password-on-wake was never readable anywhere" with `/q`). Until then item 17's status is "Could not read" and the guide's Setting 17 must say Checkup may not be able to confirm it.

## A-13. What the triage missed, across all twelve

1. **FT numbers collide with Copilot's plan.** ***Measured in project knowledge: `ProjectDocs/Co-Pilot-ASCII45 Detailed Build Plan-2026-09-16-0942.txt` assigns FT-263 through FT-268 to its own items*** -- "Guide/Tool Synchronization Audit," "GuideRef Integrity Check," "Strengthen Unknown Handling," "Manual Verification Pack," "Security-Critical Settings Review," "Launch Documentation Package." The triage assigns **FT-265 to the 10/11 replay, FT-266 to checkpoint order, FT-267 to the uncleared checkpoint, FT-268 to `/qh`.** Same numbers, different defects, both files in `ProjectDocs\`. The next reader who greps FT-266 gets two answers. **Fix:** Copilot's items become `CP-1` to `CP-6` (or whatever prefix), in the `.txt` and wherever they were copied. The triage's numbers stand -- they are the ones in the build.
2. **Five print sizes versus page numbers** (A-8). Decision 8 as written cannot be built.
3. **Sequence.** 5 before 1; 12 before FT-268's fix is trusted; 4's Was/Now screen before the guide's Part 4 is written (Part 4 must name that screen).
4. **Three weeks.** The launch is 2026-10-15. Twelve decisions, 21 new FTs, a Malwarebytes removal and a GUI removal are more than one build and one field run. **The triage does not split the list into "launch" and "after."** My split: **launch = FT-265/266/267 (resume), FT-269/279/284 (no green over unconfirmed), FT-270 (Ctrl+C), FT-271/273 (B), FT-274/275 (numbers), FT-276 (save warning), FT-278 (false copy), Decisions 1-5, 9, 12, Malwarebytes out, GUI out.** After: Decision 6's scan start, 7's screen line (guide first), 8's pass (guide must be final), 10, 11, FT-277's URI, FT-280 (moot), FT-281/282/283/285. That is still a big build. It needs its own field run and a triage before 10-15, which means the build should be done in a week.

---
---

# PART B -- GUIDE PART 3, CHECKED AGAINST THE RULES

**Rules applied:** plain English for a senior; no banned words (`whether`, `switch` as a verb, PL-4 superlatives, "the user"); every setting says who authorised the change (Bill's option 2, 2026-08-23: *"With your approval, Checkup will..."*); no dead ends (every path ends at a thing the reader can do); literal on-screen labels (W-07); VERIFY markers stay on unmeasured claims and come out only with a measurement.

**What passed, so it is not re-listed:** the permission line is present on all eight settings in the right shape (R-11/R-12 applied); numbering is 10-15, 18, 19 (R-03/R-04 applied); the Smart App Control sentence is in the grey-control note; Setting 13 now covers both toggles; Setting 10 now tells Home readers there is nothing to turn off; Setting 11's path and label are the measured ones; Setting 15 states the password-manager condition. ***Measured (my read of the twin): 0 "whether", 0 "switch" as a verb, 0 "the user", 0 PL-4 superlatives*** across the eight settings.

## Problems, by setting

**Opener** -- none.

**Setting 10, Remote Desktop**
- **B-10a Contradiction for the Home reader.** Line 1 of the Recommendation says *"With your approval, Checkup will make this change for you."* Three lines later: *"Windows 11 Home cannot be reached by Remote Desktop, so there is nothing to turn off."* ***Measured (build): `SkipOnHome=$true`*** -- Checkup never offers it on Home. A Home reader is told Checkup will do something Checkup will not show them. **Fix:** *"On Windows 11 Pro, with your approval, Checkup will turn this off for you. On Windows 11 Home there is nothing to turn off, and Checkup will not ask."*
- **B-10b "If enabled, use a strong password and Windows Hello whenever possible."** *Inferred:* a Windows Hello PIN does not protect a Remote Desktop sign-in -- Remote Desktop authenticates with the account password. Telling a reader Hello helps here is a false comfort. **Fix:** drop "and Windows Hello"; keep the strong password.
- **B-10c Quick Assist paragraph.** Good content and the right warning ("only when you called the helper"). The key combination and the button names (*Help someone*, *Submit*, *Allow*, *Leave*) are on-screen labels under W-07 and carry no VERIFY marker. **Fix:** add `⚠ VERIFY -- Quick Assist labels on a live copy` until someone reads them off the screen.

**Setting 11, Advertising ID**
- **B-11a Stance disagrees with the website.** The guide says *"This is a privacy setting, not a security risk."* ***Sourced (project record, `CloudRequest-GuideSetting11-2026-08-21`): Bill's explicit call on 08-21 was that the website take the "more than a preference / a record exists" position, and the guide was to match it*** -- a RULE W-07 divergence recorded as temporary five weeks ago. The Copilot text puts the old stance back. **Fix:** keep "not a security risk" (true, and the 08-21 guardrail said not to overclaim) and add the site's substance: *"It is more than a taste. The number lets apps build a record of what you do across programs and hand it to advertisers. Turning it off stops that record getting longer."* Same stance, both places.
- **B-11b "It has no effect on web searches or websites."** Stated as fact, no source, no marker. *Inferred, probably true (websites track by cookie, not by this ID), but unmeasured.* **Fix:** VERIFY marker or drop the sentence -- the reader does not need it.

**Setting 12, Diagnostic Data**
- **B-12a Jargon.** *"Users participating in troubleshooting or preview programs"* -- a senior does not know what a preview program is. **Fix:** *"If Microsoft support has asked you to send more information, or you have joined the Windows Insider Program on purpose, you may choose the higher level."*
- **B-12b "copies of memory when a program crashes... can include parts of a file you had open."** Stated as fact above the fold; the VERIFY marker sits lower, under What To Expect, and covers a different sentence. *Sourced in spirit (Microsoft's diagnostic-data documentation describes crash dumps at the Optional level), but no one on this project has read the page.* **Fix:** move or duplicate the marker to cover this sentence too, or cite the Microsoft page in the marker so T-VF1 knows where to look.

**Setting 13, Edge Startup Boost** -- **none new.** The VERIFY on running-after-close is in place. One style note: *"Many users will not notice"* is fine; *"Most"* would have been a PL-4 problem and it is not there.

**Setting 14, Windows Widgets**
- **B-14a Unsourced factual claim.** *"Ads in Microsoft's news feed have been used to send people to fake 'call this number' warning pages."* This is the whole "why," it is a claim about a third party's platform, and it has no source and no marker. *Inferred: malvertising in news feeds is well reported in general; that it happened in Microsoft's feed specifically needs a citation.* **Fix:** `⚠ VERIFY -- source for malvertising in the Widgets/MSN feed` or soften to *"News feeds carry advertising, and advertising is one of the ways scam pages reach people."*
- **B-14b Two unverified paths.** *"The panel still opens if you press Windows key + W"* after the taskbar toggle is off; and *"click the settings button, and under Dashboards turn Discover off."* Neither was measured; the FT-123b flip test only measured `TaskbarDa`. **Fix:** one VERIFY marker covering both; Bill can read both off SANDY in a minute.
- **B-14c Dead end, minor.** The "keep the weather, lose the news" route is good and answers Bill's 09-16 question -- but it is the only place a reader learns Widgets can be partly kept, and Checkup's item 14 is all-or-nothing. Say so: *"Checkup turns Widgets off entirely; if you want the weather only, do this step yourself afterwards."*

**Setting 15, Edge Password Saving**
- **B-15a Banned-sweep word.** *"built on the same open-source foundation as Google Chrome."* The 08-22 draft kept "open-source" exactly once, in the glossary, on purpose. This is a second occurrence in customer text. **Fix:** *"built on the same underlying browser engine as Google Chrome, which is why the two look alike."*
- **B-15b Chrome path unmarked.** The Firefox path carries a VERIFY; the Chrome path (*three-dot menu > Passwords and autofill > Google Password Manager > Settings > Offer to save passwords and passkeys*) does not and was not measured either. **Fix:** extend the marker to both.
- **B-15c Bill's open question, not answered in the text.** His 09-16 comment: *"using one is free or use Bitwarden (it's free) -- should we be making a recommendation?"* The twin does not recommend one and does not say why not. **My answer, from the 09-05 research, *sourced NCSC*:** for a senior on one PC, Edge's own password saving behind a Windows PIN is the expert-supported choice; a separate manager is better only with several devices or a shared PC. **Recommend: do not name a product.** Naming one makes GatewayGuard responsible for a third party's install, updates and support calls. The "When You Might Choose Differently" paragraph already says the right thing; add one sentence: *"For most people with one computer, letting Edge save passwords and protecting the PC with a PIN is a good, safe choice -- Checkup only offers this change if you already use a separate password manager."* That closes Bill's question and matches setting 15's conditional.

**Setting 18, Fast Startup**
- **B-18a Jargon and irrelevance in "Why It Matters."** *"Maintenance tasks, dual-boot systems, certain updates, troubleshooting procedures"* -- "dual-boot" means nothing to the reader and does not apply to them. **Fix:** plain reason: *"With Fast Startup on, 'Shut down' does not fully shut the computer down -- Windows saves part of itself to disk and reloads it. Some updates and repairs only finish after a real shutdown, so problems can carry over from one day to the next."* *Inferred from how Fast Startup works (hybrid shutdown); worth a VERIFY marker until T-VF1 confirms the update behaviour.*
- **B-18b Literal label.** The checkbox reads *Turn on fast startup (recommended)*. The twin has it. Keep Microsoft's "(recommended)" in the label -- a reader will see it and needs to know it is Microsoft's word, not ours. **Fix:** add: *"Windows labels this 'recommended'; that is Microsoft's default, not GatewayGuard's advice."*

**Setting 19, Wake on LAN**
- **B-19a Unsourced claim.** *"Backup programs that run on this PC wake it with their own timer and do not need Wake on LAN. Windows Update does not need it either."* Both plausible (*inferred*: wake timers are a different mechanism), neither measured. **Fix:** VERIFY marker; the sentence is Bill's own 09-24 addition and worth keeping.
- **B-19b Reader burden, acceptable.** Device Manager is heavy for a senior. It is the measured path and Checkup does this one for them, so the manual steps are the fallback. No change; noted so nobody "simplifies" it to a wrong path.

**A Note About Gray or Locked Controls**
- **B-N1 Passive, not plain.** *"This does not necessarily indicate a problem"* and *"can sometimes manage a setting automatically."* **Fix:** *"This is not a fault. Windows itself, or a security feature that is already protecting you, is holding that setting in place."* The FT-258 sentence (policy forcing Defender/SmartScreen/Firewall) is ***measured*** and correct.

**Part 4 lead-in**
- **B-P4a A promise Part 4 will have to keep, and it is not yet true as written.** *"Every change in Parts 2 and 3 can be undone."* ***Measured (build): settings 13, 14 and 15 are manual-revert only; setting 8 (encryption) is reversible but takes hours and is not "undo a change" in the reader's sense; setting 3 (Tamper Protection) is a Windows Security toggle Checkup never touched.*** All undoable, not all the same way. **Fix:** *"Every change in Parts 2 and 3 can be put back. Part 4 shows how for each one."*
- **B-P4b Sequencing.** *"how to create a restore point before you start"* -- Part 4 comes after the reader has done Parts 2 and 3. "Before you start" content belongs in Part 1. See Part C.

**Count:** 17 items across eight settings, the note and the lead-in. Four are real content problems (B-10a, B-11a, B-15c, B-P4a); the rest are markers, jargon, or one word.

---
---

# PART C -- PART 4: AN OUTLINE, AND WHERE THE OLD DRAFT'S REMAINING CONTENT GOES

## C-1. What Part 3's last lines promise

Three things: **a restore point**, **how to undo a change**, **what to do if something looks wrong**. The outline below keeps all three, moves one of them, and adds the two things a reader in trouble actually needs next -- a way to tell if the computer is infected, and a way to get help. Those are the old draft's Phase 3 and Getting-help addendum, and they have no home in Copilot's Parts 1-3.

## C-2. The proposed structure

**Change to Part 1 (not Part 4):** add **"Before you start -- a safety net"** to Part 1's opening: what a restore point is, how to make one (Windows key, type *Create a restore point*, Enter, *Create...*), and one honest sentence about what it does and does not cover (see C-3). That is the "before" half of Copilot's lead-in, put where "before" is.

**Part 4 -- After Checkup: what changed, how to put it back, and what to do if something looks wrong**

| § | Title | Content | Source | Basis / risk |
|---|---|---|---|---|
| 4.1 | **What Checkup changed** | Where the log is (the folder, `Open-My-Log.bat`); how to read the Was/Now lines; the "What Checkup changed" screen from Decision 4 | Decision 4; FT-243 | Screen must exist and be named first (A-13 item 3) |
| 4.2 | **Putting a setting back -- one entry per setting, 1-19** | For each: what Checkup did, then the exact clicks to reverse it | ***Measured: the build's `Revert` string for every setting*** (e.g. 11: *Settings -> Privacy & security -> General -> Let apps use advertising ID -> On*; 15: *Edge -> Settings -> Passwords -> Offer to save passwords -> On*) | The `Revert` strings are the tool's own text, so tool and guide agree by construction. **Two are stale on their face:** 11's says "General" and the measured path is "Recommendations and offers" (R-21); 13's names the old toggle labels. Fix the strings in the build, then copy |
| 4.3 | **A restore point: what it can and cannot do** | One page. Make one before; use one if Windows itself misbehaves. **Plainly: a restore point is a safety net for Windows, not an undo button for these settings** | New | ⚠ VERIFY -- which of the 19 a System Restore actually reverts (registry-based ones likely; Edge's own settings, Windows Hello enrolment and encryption certainly not). One SANDY test before this ships |
| 4.4 | **If something looks wrong** | The old draft's Phase 5 decision tree: browser opens by itself, search engine changed, pop-up "warning" pages, email forwarding rules, PC slow after a change -> which section to go to | Old draft Phase 5 *Quick decision tree* / *If something looks wrong* (pack-2 G4-A) | Already written; needs the Malwarebytes lines updated per the 09-08 answer |
| 4.5 | **If you think the computer is infected** | The old draft's **Phase 3** (AppSuite/TamperedChef: uninstall, Defender offline scan, residue, accounts, email rules, password changes), condensed to the senior reader | Old draft Phase 3 Steps 1-8 (pack-2 G3-B for residue) | Malwarebytes becomes "an optional second opinion" (my 09-08 answer, Bill's decision pending); Defender full scan + Protection history are the primary tools |
| 4.6 | **Getting help** | Ransomware first (do not pay, unplug, call); Quick Assist for a trusted helper (from Setting 10's paragraph -- reference it, do not repeat it); what to write down before calling (screen number, the `I` screen, the log location); support@gatewayguard.co and what to include | Old draft *Getting help* addendum (08-19) | The "write down the screen number" line answers Bill's ascii43 Scr 24 note |

**Part 5 -- Keeping it safe (new, short)**

| § | Title | Content | Source |
|---|---|---|---|
| 5.1 | **Passwords and two-step sign-in** | Long, unique, unchanged until a breach; 2FA for money accounts; app vs text codes; the 30 seconds; why an old code still works | My 09-05 research items 13-19 (*sourced NIST 800-63B-4, CISA, NCSC, RFC 6238*); writing job 1 from the 09-05 note. **This is the guide page Decision 7 needs** |
| 5.2 | **The yearly Windows update, and running Checkup again** | What a feature update can reset; run Checkup after it; the annual update is optional | Licence v3.1 §2 and §8 wording; consistent with the tool |
| 5.3 | **Habits** | The old draft's Phase 5 hardening/habits list, cut to one page | Old draft Phase 5 (pack-2 G4-A) |

**Back matter:** Glossary and Index from the old draft (pack-2 G6), pruned to the terms Parts 1-5 still use.

## C-3. Where the three named pieces of the old draft go

| Old draft content | Goes to | Why |
|---|---|---|
| **Phase 3 malware recovery** (Steps 1-8) | **Part 4 §4.5**, condensed | It is the "something looks wrong" escalation; it stays in the product (my 09-15 comment on Copilot's split) and it sits after the undo material because a reader reaches it from 4.4 |
| **Getting help** addendum | **Part 4 §4.6** | Last section a reader in trouble reaches; ransomware stays first |
| **Firefox addendum F1-F12** | **Not in the 10-15 guide.** Website page later, or Appendix A in a later revision | ***Measured (pack-2 §10b, marker 15): every label and location in F1-F12 is unmeasured.*** Twelve unverified click paths for a browser Checkup does not touch is exactly the failure T-VF1 exists to stop. Setting 15 already carries the one Firefox line a reader needs (with its marker) |
| **Phase 5** habits / performance / decision tree | Tree -> **§4.4**; habits -> **§5.3**; performance hygiene -> cut (the product's security promise does not depend on it) | Splits by what the reader is doing when they need it |
| **Avira removal** | Nowhere | ***Measured (pack-2 §9): no such section exists in the guide***; do not invent one |

## C-4. Two things Part 4 must not do

1. **Promise a restore point undoes Checkup.** Until the §4.3 measurement exists, the sentence is a VERIFY, and it is one of the two-can-cost-a-reader-their-files class if it turns out wrong about encryption.
2. **Repeat Setting-level text.** §4.2 points at each setting's "How To Change It" for the forward path and gives only the reverse. One source per fact.

## C-5. What this costs before 2026-10-15

Part 4 and Part 5 are mostly assembly from measured or already-written material: the `Revert` strings, Phase 3, Phase 5, the 09-05 research. The genuinely new writing is §4.3 (one page), §5.1 (two pages) and §5.2 (half a page). **I can draft all of Part 4 and Part 5 in one pass once Bill approves this outline** and Decision 4's screen has a name. The two VERIFY items it adds (§4.3 restore-point scope, B-18a) go on T-VF1's list, which is then 29 + 2 + the eight new markers Part B asks for.

---

## FOR CLAUDE CODE

```
Cloud's review is in GatewayGuard_CloudReview-ascii44Triage-GuidePart3-Part4-2026-09-25-1308.md.
Actions that are yours:
1. FT NUMBER COLLISION: ProjectDocs\Co-Pilot-ASCII45 Detailed Build Plan-2026-09-16-0942.txt
   uses FT-263..FT-268 for six Copilot items; the ascii44 triage uses FT-265..268 for
   real defects. Rename Copilot's to CP-1..CP-6 wherever they appear. Triage numbers stand.
2. Decision 8: page numbers cannot work -- five print sizes. GuideRef becomes the
   setting number ("Setting 14"). One table, one pass, when the guide is final.
3. Decision 6: agree on order; add PUA-on before scans; DO NOT start the full scan
   from Checkup in ascii45. Read FullScanEndTime from Get-MpComputerStatus instead
   of asserting "finished" (FT-277).
4. Sequence: Decision 5 (GUI out) before Decision 1 (B); FT-271 ships with Decision 1.
5. Confirm what $StateDir resolves to (A-2) -- if OneDrive, keep the Machine-ID check.
6. Build's Revert strings for settings 11 and 13 are stale (path/labels); fix in the
   build, then they become Part 4 §4.2 verbatim.
7. Part 3 twin: 17 items in Part B, four content (B-10a, B-11a, B-15c, B-P4a), the
   rest markers/wording. Apply as a pack after Bill rules on B-15c.
8. Launch/after split for the 21 FTs and 12 decisions is in A-13 item 4 -- Bill's
   call, but the build needs a field run and a triage before 10-15.
File into ProjectDocs\, add a row, regenerate CURRENT.md, commit, push.
```

---

## QUESTIONS, HELD TO THE END

1. **B-15c:** confirm no named password manager in the guide.
2. **Part 4 outline (C-2):** approve, amend, or reject -- and confirm Part 5 as a separate short part rather than folding 5.1 into Part 4.
3. **Firefox addendum:** confirm it is out of the 10-15 guide (C-3).
4. **A-13 item 4:** is the launch/after split acceptable, or does everything ship in ascii45?
5. ~~Date and time~~ -- supplied by Bill: 2026-09-25 13:08 ET.
