<!-- Dated: 2026-08-09 13:45 EDT -->
# GatewayGuard Naming Standard
- **Document Name:** GatewayGuard_NamingStandard
- **Last Modified:** 2026-08-09 13:45 EDT
- **Last Editor:** Claude.ai
- **Machine:** CGDELL
- **Status:** Cumulative Master Document (supersedes all prior versions)
- **Supersedes:** `GatewayGuard_NamingStandard-2026-07-18-r2.md` and
  `GatewayGuard_NamingStandard-2026-07-18.md` -- both lost, see PROVENANCE

**Change History Log:**
- 2026-08-09 13:45: Rebuilt after the r2 file was confirmed lost. Added
  **RULE N-07 (capitalization matches the screen)**, proposed 2026-07-18
  and adopted this session. Corrected #7 from "Windows Firewall" to
  "Firewall & network protection" (the transcript table predates that
  same-session change). Replaced the July per-surface change lists with
  a measured conformance audit against ascii39 and the live website.
  Added PROVENANCE, KNOWN DRIFT, and the STATUS-STRING warning.
  Filename drops the `-r2` suffix per FILE NAMING & VERSIONING.
- 2026-07-18 21:15 (r2): Added N-06, the two named exceptions, #7 changed
  to "Firewall & network protection", firewall Domain-network content note.
- 2026-07-18 20:30 (r1): Initial document. N-01--N-05, the locked 19-name
  table, per-surface change lists.

---

## PURPOSE

Single source of truth for the names of all 19 settings.

The tool (`.ps1`), the website (gatewayguard.co/guide), and the Guide
must all use these exact base names. A user follows our instructions
with the Windows screen in front of them. When our word and their word
differ, they stop and wonder if they are in the wrong place. For this
audience that hesitation is the whole ballgame.

---

## PROVENANCE -- READ BEFORE TREATING ANY LINE AS SETTLED

The r2 file was delivered on 2026-07-18 but never saved to
`OneDrive\GatewayGuard` and never uploaded to project knowledge. Session
staging was cleared long ago. A PowerShell recursive search of both
OneDrive roots on CGDELL on 2026-08-09 returned nothing. The file is
gone. This document is a rebuild, and every section carries its basis.

| Section | Basis |
|---|---|
| Rules N-01 -- N-05 | **sourced** -- verbatim from the 2026-07-18 transcript |
| Rule N-06 | **inferred** -- summary paraphrase only, text rewritten here |
| Rule N-07 | **new** -- proposed 2026-07-18, adopted 2026-08-09 |
| The 19 names | **measured** -- cross-read from `guide-index-2026-08-02-2031.html` and the `<h1>` of all 19 undated guide pages |
| Notes, settings #1--#8 | **sourced** -- verbatim from the transcript |
| Named exceptions | **sourced** -- reasoning from the transcript |
| Tool conformance column | **measured** -- `Name=` strings, ascii39 lines 4942--4960 |

**N-06 is the weakest line in this document.** If the reconstruction
reads wrong, the intent was: a Windows label too generic to stand alone
may take a context prefix. Correct it and the rule stands as corrected.

---

## THE RULES

**RULE N-01 -- ONE BASE NAME EVERYWHERE**
The base name in the table below is used word-for-word on all three
surfaces: the `.ps1` checklist, the website guide pages, and the Guide.
No variants, no abbreviations.

**RULE N-02 -- NAMES MATCH THE SCREEN**
Where Windows shows a term on the user's screen (for example "Defender",
"BitLocker"), our name keeps that term. Our name must never conflict
with what the user sees in Windows Security or Settings. **The screen is
the authority.**

**RULE N-03 -- DESCRIPTIONS MAY EXPLAIN, NAMES MAY NOT**
Plain-English explanation goes in the description, not the name.
Example: name = "Defender Real-Time Protection"; description may say
"Windows's built-in antivirus." First mention explains; the name matches
the screen everywhere after.

**RULE N-04 -- TOOL ACTION SUFFIXES ALLOWED**
The `.ps1` checklist may append an action suffix after the base name for
operational clarity: `-- Disable`, `-- Turn Off`, `-- Required Only`,
`(check only)`. The base name before the suffix must still match this
table exactly.

**An action suffix says what Checkup will do.** A parenthetical that
renames or re-describes the setting is not an action suffix and is not
covered by this rule. `Memory Integrity (Core Isolation)` and
`Tamper Protection (Defender)` are renames, not suffixes.

**RULE N-05 -- CHANGES REQUIRE A TABLE UPDATE FIRST**
No setting is renamed on any surface without updating this file first,
then propagating to all three surfaces in the same work cycle. Same
discipline as the STATUS-STRING CONTRACT.

**RULE N-06 -- CONTEXT PREFIXES ALLOWED FOR GENERIC LABELS**
*(reconstructed -- see PROVENANCE)*
Where the Windows screen label is too generic to identify the setting on
its own, a context prefix naming the product or surface it lives in may
be added: "Defender Periodic Scanning" for the screen's "Periodic
scanning", "Edge Password Saving" for the screen's "Save passwords".
The screen's own words are kept intact; only the prefix is added. A
prefix is permitted to disambiguate, never to re-describe -- if the
screen label already stands alone, no prefix.

**RULE N-07 -- CAPITALIZATION MATCHES THE SCREEN** *(adopted 2026-08-09)*
Capitalize exactly as the Windows screen does, everywhere, including
headings and card titles. Windows 11 uses sentence case for most
setting names and capitalizes product names.

- Correct: **Firewall & network protection** -- sentence case, because
  the Windows Security screen shows it that way
- Correct: **Windows Update**, **BitLocker**, **SmartScreen**,
  **Windows Hello** -- capitalized, because they are product names and
  the screen capitalizes them
- Wrong: "Firewall & Network Protection" -- Title Case we invented

**Why no heading exception.** Allowing standard heading capitalization in
titles would give one setting two spellings, which is exactly what N-01
forbids, and it puts the mismatch on the largest text on the page --
the first thing a user compares against their screen. One rule, no
judgment calls. The resulting table is mixed by design.

---

## THE 19 OFFICIAL NAMES

Names **measured** 2026-08-09 from the live website. Tool column
**measured** from ascii39 `Name=` strings, lines 4942--4960.

| # | Official Base Name | Tool suffix allowed | ascii39 tool string | Conforms |
|---|---|---|---|---|
| 1 | Windows Update | -- | Windows Update | YES |
| 2 | Defender Real-Time Protection | -- | Defender Real-Time VP (Virus Protection) | **NO** |
| 3 | Tamper Protection | -- | Tamper Protection (Defender) | **NO** |
| 4 | SmartScreen | -- | SmartScreen | YES |
| 5 | Defender Periodic Scanning | -- | Defender Periodic Scanning | YES |
| 6 | Enhanced Phishing Protection | -- | Edge Phishing Protection (all 3) | **NO** |
| 7 | Firewall & network protection | -- | Defender Firewall Protection (all profiles) | **NO** |
| 8 | BitLocker Data Encryption | -- | BitLocker / Device Encryption | **NO** |
| 9 | Windows Hello | (check only) | Windows Hello (check only) | YES |
| 10 | Remote Desktop | -- Disable | Remote Desktop -- Disable | YES |
| 11 | Advertising ID | -- Turn Off | Advertising ID -- Turn Off | YES |
| 12 | Diagnostic Data | -- Required Only | Diagnostic Data -- Required Only | YES |
| 13 | Edge Startup Boost | -- Turn Off | Edge Startup Boost and Background | **NO** |
| 14 | Windows Widgets | -- Disable | Windows Widgets -- Disable | YES |
| 15 | Edge Password Saving | -- Disable | Edge Password Saving -- Disable | YES |
| 16 | Memory Integrity | -- | Memory Integrity (Core Isolation) | **NO** |
| 17 | Password Required on Wake | -- | Password Required on Wake | YES |
| 18 | Fast Startup | -- Disable | Fast Startup -- Disable | YES |
| 19 | Wake on LAN | -- Disable | Wake on LAN -- Disable | YES |

**Twelve conform. Seven do not.** The July document scoped six tool
renames; the measured count is seven. #13 was not on the original list.

---

## THE TWO NAMED EXCEPTIONS

These two names deliberately depart from the exact screen label. Both
were decided 2026-07-18 with reasoning recorded. **Neither is a defect.
Do not "fix" them.**

**#6 -- Enhanced Phishing Protection.** The Windows screen shows
"Phishing protection". We keep "Enhanced" because the feature's own
Microsoft name is Enhanced Phishing Protection and the longer form
distinguishes it from SmartScreen's phishing behavior, which sits on an
adjacent screen. Users searching Microsoft's own documentation find the
longer name.

**#8 -- BitLocker Data Encryption.** Windows 11 Home shows "Device
encryption"; Pro shows "BitLocker Drive Encryption". We use "BitLocker
Data Encryption" on both. "BitLocker" is kept because the user must
produce a **BitLocker recovery key** -- that is the word on the key,
the word in their Microsoft account, and the word they will search for
if they are ever locked out. "Data" rather than "Drive" so the one name
covers Device Encryption on Home under a single heading.

---

## KNOWN DRIFT -- OPEN AT 2026-08-09

Every item below is **measured** against files in project knowledge.

**1. Website -- setting #7 has two spellings. LIVE DEFECT.**

| File | Renders as |
|---|---|
| `guide-index-2026-08-02-2031.html` | Firewall & network protection |
| `firewall.html` `<h1>` | Firewall & **N**etwork **P**rotection |

`firewall.html` is wrong under N-07. One edit, Claude Code, on the live
page. Nothing else on the site is known to be affected.

**2. Tool -- seven names do not conform.** See the table. Blocked by the
UNRUN BUILD RULE: ascii39 has never had a field run, so no ascii40 may
be scoped. These renames are the first candidate for ascii40 scope once
that log exists.

**3. Tool -- internal inconsistency at #2.** The checklist `Name=` string
reads "Defender Real-Time VP (Virus Protection)" while log lines 5651
and 5664 already read "Defender Real-Time Protection". The tool
disagrees with itself today.

**4. Guide v9 -- never audited.** `windows_security_walkthrough_guide_v9.docx`
carries 47 setting-name hits and has not been checked against this
table since the standard was written. Fold the audit into the guide
rewrite.

**5. Marketing -- never audited.** `Marketing-Notes.docx` carries 14
hits. Check names in the same pass as the open-source purge.

**6. Superseded duplicates.** The 18 files pending deletion include
second copies of setting names (`smartscreen-2026-07-18.html`,
`bitlocker-2026-07-30-2310.html`, and others). Each is a name that can
drift from the live page with nothing to catch it. Deleting them is a
naming-integrity action, not just tidiness.

---

## BEFORE RENAMING ANYTHING IN THE TOOL

**STATUS-STRING CONTRACT applies.** The `Name=` strings at ascii39 lines
4942--4960 may be consumed by `-match` elsewhere in the file. Grep every
consumer of a string before rewording it, in the same edit. A rename
that satisfies this document and breaks a gate is a worse outcome than
the mismatch it fixed.

**N-05 order of operations:** update this table first, then propagate to
tool, website, and Guide in the same work cycle. Never the reverse.

---

## SURFACES GOVERNED BY THIS DOCUMENT

**Measured** 2026-08-09 -- files carrying three or more of the 19 names.

**Must match, or a user sees the mismatch:**
- `W11-SecurityHardening-v3-ascii39-2026-07-30-2208.ps1` (232 hits)
- `GatewayGuard_ScreenContents-2026-07-28-1003.md` (59)
- `windows_security_walkthrough_guide_v9.docx` (47)
- The 19 undated guide `.html` pages and `guide-index-2026-08-02-2031.html`

**Must agree, but users do not read them:**
`GatewayGuard_SettingsToGuideMap.md`, `GatewayGuard_ProjectNotes`,
the TestHistory files, `CLAUDE.md`, `GatewayGuard_CodingStandards`,
`GatewayGuard_WebsiteStandards`, `GatewayGuard_WebsitePrePlan`

**Marketing:** `Marketing-Notes.docx`

---

## GUIDE CONTENT NOTE -- SETTING #7

Carried from r2. On `guide/firewall.html`, the three network profiles
need a plain-English line: the Domain profile is for workplace networks
and home PCs do not use it, but it should be left on anyway. Checkup
checks all three.

---

## STANDARD SETTING DESCRIPTIONS

**NOT WRITTEN.** Open since 2026-07-18.

Goal: one approved plain-English description per setting, used on the
website setting cards, the tool checklist descriptions, and the guide
page intros. The 19 built guide pages now carry descriptions that were
never promoted to standard. Harvesting them into this file is the
cheapest path and would close the last open item in the naming work.

---

*Related rules: N-05 pairs with the STATUS-STRING CONTRACT
(ProjectInstructions). N-07 pairs with W-07 zero-clean validation
(WebsiteStandards). PL-1 through PL-3 govern the surrounding copy;
this document governs only the names.*

*End of file.*
