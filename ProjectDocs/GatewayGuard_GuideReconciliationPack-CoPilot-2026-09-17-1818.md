<!-- Dated: 2026-09-17 18:18 ET -->
<!-- Editor: Claude Cloud -->
# Guide reconciliation pack -- Copilot Parts 1-3 made adoptable

- **Document Name:** GatewayGuard_GuideReconciliationPack-CoPilot
- **Dated:** 2026-09-17 18:18 ET
- **From:** Claude Cloud
- **For:** Bill, then Claude Code
- **Base files (all three, rows in `CURRENT.md` at `2c51707`):**
  `GatewayGuard_CoPilotGuidePart1-2026-09-16-1627.md`,
  `GatewayGuard_CoPilotGuidePart2-2026-09-16-1627.md`,
  `GatewayGuard_CoPilotGuidePart3-2026-09-16-1627.md`
- **Shape:** a numbered change list against those three files, per Working
  Rule 3. Not a replacement text. Claude Code applies each change to the
  twins (or the `.txt` files of record) and reports which were applied.
- **Status:** PACK. Decides nothing. Three items need Bill's ruling; they
  are at the end.

---

## PROVENANCE

- **Stamp of the copy read:** Generated 2026-09-16 16:30 ET, commit
  `2c51707`, made 15:14 ET, subject *"Self-review found and fixed a
  misleading FT-260 heading; Guide Part 3 review found a real numbering
  bug"*.
- **How I read the base files:** via `project_knowledge_search`, in
  fragments. **Read:** Part 1 from "What Checkup Does Not Do" through the
  Part 2 preview; Part 2 settings 2, 3, 4, 6, 7, 8, 9, 10-as-labelled,
  11-as-labelled and the Part 3 preview; Part 3 opener and all eight
  settings. **NOT seen:** Part 1's cover/opening sections before "What
  Checkup Does Not Do"; Part 2 Setting 1 (Windows Update); Part 3's
  grey-control note verbatim (I have Claude Code's excerpt) and anything
  after Setting 19. Changes below touch only text I saw; R-27 covers the
  gaps.
- **Checked against:** `SettingsLocationList-2026-09-08-2130` (Checkup
  R+C / R only / BLOCKED column, measured on CGDELL);
  `NamingStandard-2026-08-09-1345` (the 19 official names);
  `GuideRewrite-Draft-2026-08-22-1000` (VERIFY marker text for 10, 11, 12);
  `GuideFT220-Sections-2026-08-21-1445` (VERIFY list for 8/9/17);
  `GuideSectionReplacements-2026-08-23-0142` (local-account VERIFY);
  the ascii44 source settings table (13's `Name` and `Why`);
  `CoPilotGuideReview-Comments-2026-09-16-1140` and
  `GuidePart3Review-ForCloud-2026-09-16-1512` (Claude Code's greps and the
  numbering table).
- **Carried forward from an older draft:** the VERIFY marker sentences in
  R-05 to R-09 are quoted from the live draft *as markers* -- their whole
  point is that they are unmeasured. Nothing else is carried.
- **Ran:** nothing.

**Labels:** ***measured*** (Claude Code, output named) / *sourced* / *inferred* / *guess*.

---

## THE SHORT VERSION

Claude Code's four required fixes stand (numbering, markers, permission
line, Setting 5 + Smart App Control). **Reading the twins found five more
classes of change, and two of them are the same severity as the numbering
bug:** Setting 13 covers half the Checkup setting (Startup Boost only; the
build's item 13 is Startup Boost *and* Background Running), and Setting 10
sends a Windows 11 Home reader to a page that does not exist on Home. The
rest: seven setting names that do not match the Naming Standard, four
on-screen paths or labels that disagree with measured Windows, and Copilot's
own editorial notes left inside customer text.

**Change count: 30. Bill decides 3. Everything else is mechanical.**

---

## A. NUMBERING -- four headings (Claude Code's finding, applied here)

| # | File | Change | Basis |
|---|---|---|---|
| R-01 | Part 2 | Heading `Setting 10: Memory Integrity (Core Isolation)` → `Setting 16: Memory Integrity` | ***measured*** (build ID 16; name per R-13) |
| R-02 | Part 2 | Heading `Setting 11: Password Required on Wake` → `Setting 17: Password Required on Wake` | ***measured*** |
| R-03 | Part 3 | Heading `Setting 16: Fast Startup` → `Setting 18: Fast Startup` | ***measured*** |
| R-04 | Part 3 | Heading `Setting 17: Wake on LAN` → `Setting 19: Wake on LAN` | ***measured*** |

Part 1's table already has 16-19 right; no change there.

## B. VERIFY MARKERS -- restore the ones the rewrite dropped

Each marker goes back as a bracketed line immediately after the sentence it
guards, in the draft's existing style (`⚠ VERIFY -- ...`). They come out
one at a time under T-VF1, each with its measurement, never by deletion.

| # | File / setting | Sentence in Copilot's text | Marker to add after it | Basis |
|---|---|---|---|---|
| R-05 | Part 2 / 8 BitLocker | *"Windows 11 Pro typically uses BitLocker. Windows 11 Home may use Device Encryption."* | `⚠ VERIFY -- Home/Pro split and whether Device Encryption on Home requires a Microsoft account. BitLocker Test 2 on SANDY answers this; sentence held until then.` | Claude Code hold 1, 09-16; CPM §2 lines 494-517 |
| R-06 | Part 2 / 8 BitLocker | *"A recovery key will be generated."* | `⚠ VERIFY -- on a Microsoft account the key is saved to the account automatically; on a local account it is saved nowhere automatically. One of the two claims that can cost a reader their files.` | FT220 §6 item 5; draft line 1963 |
| R-07 | Part 2 / 9 Windows Hello | after *"Configure a PIN at Minimum"* | `⚠ VERIFY -- a PIN can be created on a local account; a local account cannot reset a forgotten PIN without the account password.` | FT220 §6 items 1, 4; GuideSectionReplacements §4 |
| R-08 | Part 3 / 12 Diagnostic Data | *"Windows will continue sending information necessary to maintain and update the operating system."* | `⚠ VERIFY -- Windows sends the larger level unless told otherwise; updates are identical at either level.` | draft §12, two markers; Part3Review |
| R-09 | Part 3 / 13 Startup Boost | *"keeps portions of Microsoft Edge running in the background after you close the browser"* | `⚠ VERIFY -- the running-after-close claim, and the exact current label of Edge's background-apps toggle.` | draft §13; FT220 §6 item 10 |
| R-10 | Part 3 / 10 Remote Desktop | after the How To Check steps | `⚠ VERIFY -- exact on-screen path and label on Pro; what Home shows (page absent, or present and greyed).` | draft §10 marker, original copy with no v9 source |

*Inferred:* Part 2's Setting 17 will also need the sleep-versus-hibernate
marker from FT220 §5 **if** that sentence is carried in; Copilot's text does
not make the claim, so no marker is needed unless R-22 adds it. Bill's call
(question 2).

## C. THE PERMISSION LINE -- one line per setting, under GatewayGuard Recommendation

Bill's option 2 (2026-08-23): every setting names what Checkup does. Not an
eighth heading; one line directly under **GatewayGuard Recommendation**,
after the `Recommended:` value. Three shapes, chosen from the measured
Checkup column in `SettingsLocationList-2026-09-08-2130`:

- **Shape A (R+C):** *With your approval, Checkup will make this change for you.*
- **Shape B (R only):** *Checkup checks this and shows you the steps; Windows requires that you make the change yourself.*
- **Shape C (BLOCKED on some machines):** *With your approval, Checkup will try to make this change. On some computers Windows blocks it; Checkup then shows you the steps.*

| # | Setting | Shape | Note | Basis |
|---|---|---|---|---|
| R-11 | 1, 2, 4, 7, 10, 11, 12, 13, 14, 15, 16, 18, 19 | **A** | 16 adds *"A restart is needed for it to take effect"* (already in What To Expect -- keep both) | ***measured*** R+C column |
| R-12 | 3 Tamper Protection | **B** | Windows forbids any program changing it | ***measured*** R only |
| R-12 | 9 Windows Hello | **B** | enrolling needs the person at the machine | ***measured*** R only |
| R-12 | 6 Phishing Protection | **C** | BLOCKED on CGDELL (Tamper Protection); write path exists and succeeds where permitted (NoteToCloud 09-05 §2) | ***measured*** |
| R-12 | 8 BitLocker | **A, reworded** | *"With your approval, on its own screen, Checkup will turn this on for you. It will not start without your recovery key saved first."* | ***measured*** R+C, own screen, explicit permission |
| R-12 | 17 Password on Wake | **A** | ascii43 log 08-30 shows `[APPLIED]`; the 09-08 BLOCKED is a *read* failure (FT-256), not a write | ***measured***, both |
| R-12 | 15 Password Saving | **A, plus** | add: *"Checkup asks first whether you use a password manager and only offers this if you do."* | ***measured***, FT-221 |

## D. NAMES -- match the Naming Standard's official 19 (N-01: one spelling everywhere)

| # | File | Copilot's name | Official name | 
|---|---|---|---|
| R-13 | Part 2 heading + Part 1 table | Memory Integrity (Core Isolation) / Memory Integrity | **Memory Integrity** (drop the parenthetical in the heading) |
| R-14 | Part 2 heading + Part 1 table | Edge Phishing Protection | **Enhanced Phishing Protection** (named exception, decided 07-18) |
| R-15 | Part 2 heading + Part 1 table | Microsoft Defender Firewall / Firewall | **Firewall & network protection** (sentence case, matches the screen) |
| R-16 | Part 2 heading + Part 1 table | BitLocker or Device Encryption / BitLocker / Device Encryption | **BitLocker Data Encryption** |
| R-17 | Part 3 heading + Part 1 table | Widgets | **Windows Widgets** |
| R-18 | Part 3 heading | Edge Startup Boost | **Edge Startup Boost** is the official base name -- keep -- but see R-19 for the missing half |

Basis for all: *sourced*, `NamingStandard-2026-08-09-1345`, "THE 19
OFFICIAL NAMES" table, measured from the live website. Part 1's "Setting
numbers match GatewayGuard Checkup" sentence should extend to names once
this is done.

## E. CONTENT ERRORS -- two the same severity as the numbering bug

| # | File / setting | Problem | Change | Basis |
|---|---|---|---|---|
| R-19 | Part 3 / 13 | **Covers half the setting.** Checkup item 13 is `Edge Startup Boost and Background Running` and turns off *two* toggles: **Startup boost** and **Continue running background extensions and apps**. Copilot's What It Is also conflates them (Startup Boost pre-loads Edge at boot; background mode keeps it running after close). | Rewrite What It Is as two sentences, one per toggle, using the build's own `Why` text as source; add the second toggle to How To Check and How To Change It; note *"Open Startup boost first or the toggles do not appear"* | ***measured***: build `Name`/`Why` for ID 13; SettingsLocationList row 13 |
| R-20 | Part 3 / 10 | **Home readers are sent to a page that does not exist.** Windows 11 Home has no Remote Desktop page; Checkup `SkipOnHome=$true`. Copilot says nothing. | Add under How To Check: *"If Settings > System has no Remote Desktop entry, your computer is Windows 11 Home and cannot accept these connections. There is nothing to turn off."* (then R-10's marker) | *sourced* build `SkipOnHome`; draft §10; website remote-desktop.html |

## F. ON-SCREEN PATHS AND LABELS -- RULE W-07, literal words only

| # | File / setting | Copilot has | Measured | Change |
|---|---|---|---|---|
| R-21 | Part 3 / 11 | Settings > Privacy & Security > **General**; toggle *"Let apps use my advertising ID to show me personalized ads"* | **Recommendations and offers**; *"Let apps show me personalized ads by using my advertising ID"* (Bill on CGDELL 08-22; SettingsLocationList 09-08) | Replace both |
| R-22 | Part 2 / 17 | *"Set sign-in to be required whenever the computer wakes from sleep"* | Screen label: **If you've been away, when should Windows require you to sign in again?** → **When PC wakes up from sleep** (FT220 §5) | Replace with the literal label and value |
| R-23 | Part 3 / 18 | Control Panel > Power Options > Choose What The Power Buttons Do | Path needs **Change settings that are currently unavailable** before the checkbox is editable (SettingsLocationList row 18) | Add that step; sentence-case the labels |
| R-24 | Part 3 / 19 | How To Check: *"BIOS or UEFI settings / Device Manager / Network adapter properties"* | Checkup path: **Device Manager > Network adapters > right-click each adapter > Properties > Power Management**, untick *Allow this device to wake the computer* | Replace the three-option list with the one measured path. **Remove the BIOS/UEFI reference** -- out of the product's scope and the class of step a senior should not be sent into |
| R-25 | Part 2 / 4 | How To Change It: *"Enable available SmartScreen protections"* | Four named toggles under Reputation-based protection settings (website smartscreen.html, measured 07-30) | Name the four |

## G. DECIDED TEXT -- carry in

| # | File | Change | Basis |
|---|---|---|---|
| R-26 | Part 1 table note | Replace *"Number 5 is intentionally omitted ... product decision."* with: **Not applicable** -- *this check is no longer part of GatewayGuard Checkup.* Keep *"Setting numbers match GatewayGuard Checkup."* | Bill, 09-16 13:39 |
| R-27 | Part 2, once, after Setting 4's How To Check | *If Windows says a setting is managed by Smart App Control, that setting is already protected and cannot be changed there -- this is normal, not a fault.* Do not repeat at Setting 6. Part 3's grey-control note stays as written; the two do not duplicate (Part 3's is general, Part 2's is at the screen where it happens). | decided 09-16 14:55 |

## H. EDITORIAL RESIDUE -- strip before this is customer text

| # | File | Change |
|---|---|---|
| R-28 | Part 1, last paragraph | Delete *"I would recommend this become the new opening section and replace most of the existing preamble..."* -- Copilot talking to Bill, not to a reader |
| R-29 | Part 2, end | Delete the *"Part 3: Additional Security and Privacy Settings ... performance considerations.Guiide"* preview block; Part 3 carries its own opener, and this one lists the settings in a different order |
| R-30 | Part 1, Before You Begin | *"Run Checkup as Administrator when possible"* -- **"when possible" implies optional.** *Inferred:* Checkup writes `HKLM` and needs elevation; the launcher asks for it. Claude Code to confirm against the build and replace with the actual behaviour (question 3) |

---

## WHAT THIS PACK DOES NOT DO

- Does not touch the live draft `GuideRewrite-Draft-2026-08-22-1000.md`.
  Adoption replaces its opening, quick-reference table and settings
  narrative with the corrected Copilot text; that substitution is one
  Claude Code job after Bill approves this pack.
- Does not resolve any VERIFY claim. T-VF1 does that.
- Does not cover Part 1's cover sections or Part 2's Setting 1 -- not read.
  Claude Code: run the same checks (name, path literal, permission line)
  on those two before applying.
- Does not re-order settings into phases. Copilot's Part 2/Part 3 split
  maps to the draft's Phase 1 / Phase 4; Phases 2, 3 and 5 (browsers,
  malware, staying safe) are untouched by the rewrite and stay as they are.

---

## FOR CLAUDE CODE

```
Apply R-01 to R-29 to the three twins (and the .txt files of record).
R-30 needs your measurement first: does Checkup require elevation, and
what does the launcher do about it? Replace the sentence with what is true.
Run the name check (R-13..R-18) and the permission-line check (R-11/R-12)
on Part 1's opening and Part 2 Setting 1, which Cloud did not see.
Then grep all three parts: VERIFY count should be 6 (R-05..R-10),
"With your approval" / "Checkup checks this" count should be 18.
Report both counts. File this pack, add a row, regenerate CURRENT.md,
commit, push, tell Bill to sync.
```

---

## QUESTIONS, HELD TO THE END

1. **Bill:** approve the pack as the adoption path? Once applied, the
   Copilot text replaces the draft's Phase 1 and Phase 4 narrative and the
   quick-reference table.
2. **Bill:** Setting 17 -- carry the draft's *"sleep and hibernate are not
   the same thing"* paragraph into Copilot's text (with its marker), or
   leave it out until T-VF1 measures it?
3. **Claude Code:** R-30 -- does Checkup require Administrator, and what
   happens when it is not?
4. ~~Date and time~~ -- supplied by Bill: 2026-09-17 18:18 ET.
