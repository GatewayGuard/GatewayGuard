<!-- Dated: 2026-09-26 14:59 ET -->
<!-- Editor: Claude Cloud -->
# Guide Parts 1-3 against ascii45 after Blocks A, B and C1

- **Document Name:** GatewayGuard_GuideVsAscii45-BlocksABC1
- **Dated:** 2026-09-26 14:59 ET (supplied by Bill)
- **From:** Claude Cloud
- **For:** Bill, then Claude Code
- **Status:** FINDINGS. Changes nothing.

---

## PROVENANCE

1. **Stamp:** Generated **2026-09-26 12:14 ET**, commit **`4fb5596`**, made **2026-09-26 12:10 ET**, subject *"ascii45 C9 full-screen launch in scope; copy/selection test and SANDY Windows Terminal check added"*. Session-log heading match confirmed.
2. **Base files:**
   - `Tool/W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1` -- the `CHANGES FROM ascii44` block (A1-A7, B1, B2a, B2b-1 to -3, B3, C1), the settings table, the convenience-review table (items 11-15), screens 21, 39 and 53, the scan-reminder code.
   - Guide Parts 1-3 twins, `GatewayGuard_CoPilotGuidePart1/2/3-2026-09-16-1627.md`.
3. **How read:** fragments. The CHANGES block was read whole from A1 through C1. **Guide coverage is the same as the T-VF1 file:** everything except Part 2 Setting 6's body and Setting 7's opening.
4. **Carried forward:** nothing from a draft.
5. **Not seen:** the build's full screen text for 13, 14, 14a, 14b, 33 and 34 after B2b-3. I have the CHANGES entries and the partial field checklist's description of them, not every line on screen.

---

## THE SHORT ANSWER

**Blocks A, B and C1 broke almost nothing in Guide Parts 1-3, because Parts 1-3 never described the things those blocks changed.** There is no mention of GUI mode, of keys, of Malwarebytes, of screens 13/14, or of scan schedules anywhere in the text I read.

- ***Measured by Claude Code, 2026-09-25:*** Guide Parts 1-3 name no third-party antivirus.
- Part 1's quick-reference table already carries **Number 5: Not applicable** (R-26).

**The mismatches run the other way.** In eight places, **Checkup is now behind the guide** or behind Bill's decisions. Section B lists them, and they are the part worth acting on.

---

## A. GUIDE SENTENCES THAT NO LONGER MATCH CHECKUP, OR WILL NOT SOON

### A-1. Now -- fix in the guide

| # | Where | Guide says | Checkup after A/B/C1 | Change |
|---|---|---|---|---|
| G1 | Part 2, Setting 2, permission line | *"With your approval, Checkup will make this change for you."* | ***measured, B2a:*** if Defender's real-time protection is off **and another antivirus is registered**, Checkup reports that product is in charge and does not offer the change | Add: *"...unless another antivirus program is in charge, in which case Checkup tells you which one."* The setting's own *When You Might Choose Differently* already says this; the permission line should not contradict it |
| G2 | Part 3, Setting 11, *Why It Matters* | *"This is a privacy setting, not a security risk."* followed two paragraphs later by *"This is more than a taste..."* | not a Checkup mismatch -- **the setting contradicts itself** | Bill's call which stands. The website's `advertising-id.html` took the "more than a taste" position on 08-21 (Job 4, W6) |

### A-2. Correct today, but a later ascii45 block will break it

| # | Where | Guide says | Breaks when |
|---|---|---|---|
| L1 | Part 3, Setting 14 | *"answer No when Checkup offers this change"* | ***Measured, build:*** the convenience review still asks Y/N per item 11-15 (FT-94), and C1 made **N mean No and nothing else** -- so today this is right, and better than before. **Decision 4 moves 11-15 into the main run (selection = approval).** Then there is no No to answer. Rewrite to *"leave item 14 unticked on the checklist"* in the same edit |
| L2 | Part 3, Setting 15 | *"Checkup asks first if you use a password manager, and only offers this change if you do."* | Right today (screen 53, ***measured***). Changes only if Decision 4 moves item 15 |
| L3 | Part 1, *Before You Begin* | *"Run Checkup as Administrator. Checkup will not run without it -- it closes and shows you how to relaunch correctly."* | **C9, full-screen launch.** ***Measured (build plan):*** the launcher will say how to leave full screen before the window opens. Part 1 needs one line: *"Checkup opens full screen. To leave full screen press Alt+Enter; to close it press Alt+F4."* -- **only after C9 is built and those keys are measured in Checkup itself** |
| L4 | Part 2, Setting 1 | How To Change It: turn on automatic updates, click Check for Updates | **Block E, E2:** Checkup installs updates with approval, restarts, and repeats. The permission line and *What To Expect* need rewriting then, from the built behaviour |
| L5 | Part 2 / Part 3 cross-references | none today -- Parts 1-3 do not send the reader to Checkup screens | **Block F, GuideRef pass.** When the build's references change to Setting numbers, check nothing in the guide cites a Phase/Step |

---

## B. WHERE CHECKUP IS NOW BEHIND THE GUIDE OR THE DECISIONS -- for Claude Code

**Each row quotes the build's own text in my snapshot.**

| # | Build location | Build says (***measured***, snapshot text) | Conflicts with | Fix |
|---|---|---|---|---|
| K1 | **Screen 53**, the password question | *"a separate app such as Bitwarden, 1Password, or KeePass"* | **Bill, 2026-09-26:** no password-manager names in Checkup's own words. The exception covers names Checkup **finds on the PC** (screens 17/17a/17c) -- this is not one | *"a separate password manager app"* |
| K2 | **Item 15 `Why`** (convenience review) | *"A dedicated password manager (Bitwarden, 1Password) uses stronger encryption..."* | same decision; also the guide's position that Edge saving is *"significantly better than reusing weak passwords"* | Drop the names |
| K3 | **Screen 39**, repeat-run reminder | *"Guide: Phase 5 -- Scheduled Scanning"* | The guide has no Phase 5 and no *Scheduled Scanning* section. Checkup's scans are **reminders** (FT-175; screen 33's own wording) | Point at **Part 4, 4.5** (offline scan) once the draft is approved; drop the word *Scheduled* |
| K4 | **Item 11 `Revert`** | `...Privacy & security -> General -> Let apps use advertising ID -> On` | Guide Part 3 (measured 08-22, SettingsLocationList 09-08): **Recommendations and offers**, *Let apps show me personalized ads by using my advertising ID* | Replace (was Cloud's 09-25 action 6; still open) |
| K5 | **Item 12 `Revert`** | `...Diagnostic data -> Full` | Guide Part 3: **Optional diagnostic data** | Replace |
| K6 | **Item 13 `Revert`** | `Continue running background apps` | Guide Part 3: *Continue running background extensions and apps*; **open Startup boost first** | Replace (Cloud's 09-25 action 6; still open) |
| K7 | **Item 14 `Why`** | *"runs background Edge WebView2 processes at all times, consuming RAM... It also sends browsing behavior data to Microsoft"* | `GuidePart3-Sources-2026-09-25-1320`: *"No memory claim should be published -- nobody has measured what stops when Widgets is turned off."* The data claim is unsourced there too | Replace with the guide's reason (the news panel carries ads; scam ads have run in Microsoft's Edge news feed, *sourced* in that file) |
| K8 | **Item 15 `Description`** | *"Check manually: Edge -> Settings -> Profiles -> Passwords"* | Guide Part 3 and the item's own `Revert`: **Edge > Settings > Passwords** | Replace |

**Two more, lower cost, same class:**

- **Item names versus the Naming Standard.** Item 2 is `Defender Real-Time VP (Virus Protection)`; item 6 is `Edge Phishing Protection (all 3)`; item 16 keeps `(Core Isolation)`, which N-04 calls a rename. The guide uses *Microsoft Defender Real-Time Protection*, *Enhanced Phishing Protection* and *Memory Integrity*. **Not caused by A/B/C1**; recorded because the reconciliation pack's R-13 to R-18 fixed the guide side only.
- **GuideRefs.** Every item still points at *"Phase 1, Step N"* or *"Keep vs. Disable Table"*. **Known, and scheduled** for Block F; listed so nobody reads Part 4's cross-references as the build's.

---

## C. CHECKED AND CLEAN

Each change in the CHANGES block, against the guide:

| Change | Guide text it could touch | Result |
|---|---|---|
| A1/A2 FT-268/269, password-on-wake read and re-read | Part 2, Setting 17 permission line | **Clean.** The claim was "Checkup will make this change"; A1/A2 make it true where it was not readable |
| A3 FT-284, no green Done over an error | none | Clean |
| A4 FT-278, five screens stop promising automatic behaviour | Part 2 Setting 8 *"Follow the step-by-step instructions provided by Checkup"*; Part 3 nothing on scans | **Clean.** The guide already describes Home encryption as manual steps |
| A5 FT-279, "Working on this item..." | none | Clean |
| A6 FT-254, time sync | none | Clean -- time sync is not a guide setting |
| A7 FT-285, logging | none | Clean |
| B1 GUI removed; screen 21 is Start / Exit | none | Clean -- ***the guide never mentioned GUI mode*** in the text read |
| B2a verdicts no longer depend on Malwarebytes; setting 5 retired | Part 1 table note; Part 2 Setting 2 | Part 1 clean; Setting 2 is **G1** above |
| B2b-1/-2/-3 screens 13, 14, 17, 18 | none | Clean -- the guide names no screens |
| B3 monthly Malwarebytes reminder removed | none | Clean |
| C1 X = Exit | Part 3 Setting 14 *"answer No"* | Clean now -- **L1** for later |

---

## FOR CLAUDE CODE

```
Cloud checked Guide Parts 1-3 against ascii45 A/B/C1:
GatewayGuard_GuideVsAscii45-BlocksABC1-2026-09-26-1459.md.
Build items (section B), ordered by cost of being wrong:
  K1, K2  -- password-manager names in Checkup's own words (screen 53,
             item 15 Why). Against Bill's 2026-09-26 decision.
  K7      -- item 14 Why states an unmeasured memory claim.
  K3      -- screen 39 GuideRef to a Phase 5 that does not exist.
  K4-K6, K8 -- stale Revert / Description paths for 11, 12, 13, 15.
One family per commit, gg_edit, gates as usual.
Guide items: G1 (Setting 2 permission line) -- apply to the Part 2 twin.
G2 and L1-L5 wait on Bill or on later blocks.
File into ProjectDocs\, add a row, regenerate
CURRENT.md last, commit, push.
```

## QUESTIONS, HELD TO THE END

1. **Bill:** G2 -- Setting 11 says both *"not a security risk"* and *"more than a taste."* Which stands?
2. **Bill:** Part 3 Setting 15 prints Chrome's own label *"Google Password Manager."* That is a menu name the reader must click, not a recommendation. Is it covered by the no-names rule, or does it stay as a literal screen label?
