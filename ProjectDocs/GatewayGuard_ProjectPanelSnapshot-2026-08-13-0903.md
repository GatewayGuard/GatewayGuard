<!-- Dated: 2026-08-13 09:03 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# GatewayGuard Claude Project Panel — Snapshot of 2026-07-13

- **Document Name:** GatewayGuard_ProjectPanelSnapshot
- **Last Modified:** 2026-08-13 09:03 ET
- **Last Editor:** Claude Code (CGDELL)
- **Status:** Historical record. Extracted content, filed once, not maintained.
- **Purpose:** Preserve the readable content of a saved Claude.ai page so the
  9.3 MB of saved-webpage scaffolding around it could be deleted.

**Change History Log:**
- 2026-08-13 09:03: Created. Text extracted from
  `Marketing\atewayGuard_MarketResearch.html` before that file and its
  `atewayGuard_MarketResearch_files\` folder were removed from the tree.

---

## WHAT THIS IS, AND WHAT IT IS NOT

**It is not market research.** The source filename said so and was wrong on
both counts — it was also missing its leading `G`, as was its companion
folder, since the day it was added.

**What it actually was:** a browser "Save page as" capture of the Claude.ai
project panel, taken around **2026-07-13**, when the active build was
**ascii27** and ascii28 was being scoped. It held three things worth keeping:

1. The project **Memory** block Claude.ai had generated at that date
2. The **Project Instructions** field as it read on **2026-07-10**
3. The **project knowledge file list**, with line counts, as of that date

Everything else in the 351,128-character file was rendering scaffolding:
37 files of JavaScript, CSS and thumbnails totalling 8.9 MB.

**Deliberately not carried across:** the sidebar's list of Bill's unrelated
personal chats. It had no project value and some of it was personal.

---

## HONEST ASSESSMENT — ALMOST NONE OF THIS WAS LOST

**measured 2026-08-13**, before deleting anything. Each distinctive fact in
the snapshot was searched for across the tree:

| Fact | Already in the tree at |
|---|---|
| Bill's InfoSec background — ISO at Port Authority of NY & NJ, senior InfoSec at PSEG of NJ, EnCase / FTK forensics | **On screen in the build itself** — `# Former ISO, Port Authority of NY & NJ`, carried in every `.ps1` from ascii33 on |
| FBI IC3 tech-support-fraud rationale for the RDP / Wake-on-LAN recommendation | `Presentation\GatewayGuard_PresentationCompanionSheet-2026-07-03.md`, `ProjectDocs\GatewayGuard_FieldTestNotes_Round5-2026-07-12.md` |
| Beta candidate — a physical therapist named Erica | `ProjectDocs\GatewayGuard_BetaCandidates-2026-07-02.md` |
| Namecheap as DNS registrar | `Notes\Latest GG Chat-2026-07-16-10-58.txt` and the ProjectNotes lineage |
| Sectigo OV certificate ordered | `ProjectDocs\GatewayGuard_CPM_Schedule-2026-08-02-1201.md` |
| Autologon64 on the Dell, intentional | `ProjectDocs\GatewayGuard_ProjectNotes-2026-07-11-r4.md` |
| The 2026-07-10 project instructions | Superseded in full by `GatewayGuard_ProjectInstructions-2026-08-12-1652.md` |

**Exactly one fact appears nowhere else in the tree:**

> **Dell Latitude 5430 (CGDELL) Service Tag: `9WPZTT3`.**
> Zero hits anywhere else. It is the machine identifier used for Dell warranty
> and support lookups.

This section exists because **V-3** requires testing the content, not the
filename, before calling a removed file a loss. The honest finding is that the
file was very nearly pure duplication — and the full text is filed below
anyway, because 19 KB is cheaper than ever having to ask the question again.

---

## 1. DECISIONS AND STATE WORTH READING — WITH CURRENT STATUS

These are the substantive lines from the Memory block, each marked against
what is true today. **Where this document and a current governing document
disagree, the current one wins** — this is a 2026-07-13 photograph.

### Still current

- **Licensing: Option B, confirmed** — source-available, no redistribution,
  **never described as "open source."** Correct terminology: *source-visible*
  or *fully auditable*. *(This is the ACCURACY NOTE, and it was a confirmed
  decision as early as 2026-07-13.)*
- **The launcher must never self-elevate.** A self-elevating `.bat` was
  blocked by Malwarebytes as an exploit payload (2026-07-04); an unsigned run
  triggered SmartScreen (2026-07-12). Code signing is a hard launch
  requirement.
- **Assisted / screen-share sessions: removed from launch marketing**, parked
  as a Phase 2 post-launch roadmap item. *(This is BUSINESS MODEL ACCURACY,
  and it has been settled since 2026-07-13.)*
- **Deep Scan works on the Free Malwarebytes licence** — not trial-only, as
  had been believed. Rootkit scanning is off by default and should be turned
  on in the guide instructions.
- **Remote access guidance for seniors:** RDP off, Wake-on-LAN off, on
  **sourced** rationale — FBI IC3 data on tech-support fraud targeting
  seniors.
- **Sanctioned scroll method:** Mark mode (Alt+Space, E, M). Right-click copy
  and mouse highlight are disabled by design, a consequence of the QuickEdit-off
  fix.

### Superseded, recorded for lineage

- **Active build ascii27 (4,593 lines);** ascii26 never run, superseded the
  same night. *(Now ascii39, 8,075 non-blank lines, field run 2026-08-11.)*
- **Sales via Gumroad and Microsoft Store.** *(Superseded 2026-08-09: **Gumroad
  for all sales.** The Microsoft Store channel is not in launch scope.)*
- **Revision suffixes `-r2` / `-r3` for same-day revisions.** *(Directly
  reversed by FILE NAMING & VERSIONING, 2026-07-20: no variant suffixes,
  ever, for any file type. The filename carries `-YYYY-MM-DD-HHMM` instead.)*
- **Model selection: Fable 5 or Opus 4.8 for `.ps1` builds.** *(Still the
  rule in substance — most capable model for builds — with the model names
  since updated.)*
- **OneDrive path `C:\Users\willi\OneDrive\GatewayGuide\`.** *(Retired. The
  single working root is
  `C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\`, renamed
  2026-08-08.)*
- **Website pre-plan: 44 pages.** Build priority guide pages → `download.html`
  → `index.html`. Design spec: black and white, Arial, 960 px maximum width,
  green / amber / red status colours. Navigation: Home | Download | Guide |
  Tips | Beta | Compatible. *(Check against the current WebsiteStandards
  before relying on any of it.)*

### Still open, and worth surfacing

- **Annual Updates pricing remains an open question.** It was open on
  2026-07-13 and no later document settles it. It belongs on the business
  list alongside the Gumroad decision.
- **Dell Latitude 5430 Service Tag `9WPZTT3`** — the one fact this file
  uniquely held. Local account `CGAdmin`; Autologon64 configured deliberately
  for resume testing, not a defect.

### Engineering lessons recorded at that date

Kept because they are stated compactly here and the reasoning is worth having
in one place. All predate the current DefectPreventionPlaybook.

- **FT-37** — a single line of invalid PowerShell (`return if (...)`) in
  `Get-MalwarebytesState` threw silently at runtime, so the function always
  returned `Unknown` when Defender real-time protection was off. That is the
  root cause of the false *DEFENDER IS OFF* alarms. **Silent failures in
  conditional logic are high-risk.**
- **FT-01** — walk-away session deaths were **QuickEdit mode**. Disabling it
  at launch eliminated the nine-hour session gaps. Confirmed fixed in ascii24+.
- **FT-29** — first-keypress eating was the **input buffer flush**. Removing
  it resolved five or more reports.
- **The flush-bug lesson, generalised:** avoid extra input or state machinery
  when a simpler permanent fix exists. It decided the back-navigation design
  in favour of extending Back to all selection screens rather than a
  test-only counter mode.
- **`0x80000003` hex literal bug** — PowerShell parses it as a negative signed
  `Int32` before the `[uint32]` cast. The fix is the decimal literal
  `2147483651`.
- **`$yPos` multi-element array bug** — a GUI-mode crash, fixed with `[0]`
  indexing throughout plus diagnostic logging.
- **`switch -Wildcard` missing `break`** — `Professional` matched both the
  `Professional` and `Pro` patterns and returned a duplicated array. **Always
  include `break` in `switch -Wildcard`.**
- **Scan durations:** roughly 27 minutes on the Dell (clean); roughly
  1 hour 36 minutes on the IdeaPad (6 PUPs found).

---

## 2. THE MEMORY BLOCK, VERBATIM

Reproduced as extracted. Section breaks are the source's own.

> **Purpose & context**
>
> Bill (William F. Burns III, "Panther") is the sole developer of GatewayGuard
> LLC (Maine LLC, registered in Brunswick, ME), building a Windows 11 security
> hardening tool targeting non-technical home users, particularly seniors. The
> tool is a guided PowerShell script with a plain-English interface that walks
> users through security settings, runs Defender and Malwarebytes scans, and
> applies hardening changes. Bill has an information security background
> (former ISO at Port Authority of NY & NJ, senior InfoSec at PSEG of NJ,
> computer forensics with EnCase Enterprise and FTK). Target launch: September
> 1, 2026 via Gumroad and Microsoft Store. Website: gatewayguard.co (not .com),
> hosted on GitHub Pages with Namecheap DNS.
>
> Key people & contacts: Beta candidates include a physical therapist named
> Erica and family members with varying device compatibility.
>
> Licensing decision (confirmed): Option B — source-available, no
> redistribution, never described as "open source." Correct terminology:
> "source-visible" or "fully auditable."
>
> Code signing (confirmed prerequisite): Sectigo OV certificate ordered direct
> from CA. The launcher must never self-elevate — a self-elevating .bat was
> blocked by Malwarebytes as an exploit payload (7/4), and an unsigned run
> triggered SmartScreen (7/12). Code signing is a hard launch requirement.
>
> **Current state**
>
> Active build: ascii27 (4,593 lines); ascii26 was never run and was superseded
> by ascii27 the same night. Next build: ascii28 scope is partially defined —
> 13 items are buildable, but 6 are blocked pending log file uploads, and FT-57
> (MB license discrepancy on Dell) needs resolution before the detection fix
> can be finalized.
>
> Test fleet: HP SANDY — Windows 11 Home. Lenovo IdeaPad — Windows 11 Home;
> primary dev machine (broken built-in keyboard, USB peripherals); cursor drift
> resolved by disabling built-in touchpad. Dell Latitude 5430 (T3) — Windows 11
> Pro; Service Tag 9WPZTT3; local account CGAdmin; fully updated including
> firmware; OOBE issue resolved as of 30-Jun-2026; clean vanilla desktop, ready
> for testing; Autologon64 configured for T3 resume testing (intentional, not a
> bug).
>
> Round 5 field testing (FT-38–FT-60): 23 items triaged. Open actions: upload
> day's log file, check MB license line on Dell (Premium Trial vs. Free — trial
> end date still days away as of last session, firewall-ownership heuristic
> deemed unreliable), confirm/trim ascii28 scope.
>
> Website: Pre-plan established (44 pages, build priority: guide pages →
> download.html → index.html). Design spec: black/white, Arial, 960px max
> width, green/amber/red status colors. Nav: Home | Download | Guide | Tips |
> Beta | Compatible. tips.html ("Helpful Windows 11 Tips") added as Phase 3;
> Tip #1 is capturing streaming audio on Windows 11.
>
> File management: OneDrive path C:\Users\willi\OneDrive\GatewayGuide\. Project
> files maintained in GatewayGuard Claude project: GatewayGuard_ProjectNotes.md,
> CodingStandards.md, field test notes files.
>
> **On the horizon**
>
> Resolve FT-57 MB license discrepancy on Dell before finalizing ascii28
> detection fix. Upload Round 5 log file to unblock the 6 pending ascii28 items.
> Confirm ascii28 scope, then build. Back navigation extension to all selection
> screens (delegated decision: chosen over test-only counter mode, per flush-bug
> lesson about avoiding extra machinery). Detection hardening (queued). Website
> build (guide pages first, as gatewayguard.co/guide is a direct link from the
> tool — launch dependency). Attorney review of license before launch. Marketing
> copy sweep (license-dependent). Log final license decision in ProjectNotes.
> Annual Updates pricing remains an open question.
>
> **Key learnings & principles**
>
> FT-37 (root cause of false DEFENDER IS OFF alarms): A single line of invalid
> PowerShell (return if (...)) in Get-MalwarebytesState silently threw at
> runtime, causing the function to always return "Unknown" when Defender
> real-time protection was off. Silent failures in conditional logic are
> high-risk.
>
> FT-01 (walk-away session deaths): QuickEdit mode was the culprit; disabling
> it at launch eliminated 9-hour session gaps. Confirmed fix in ascii24+.
>
> FT-29 (first-keypress eating): Input buffer flush was the cause; removing it
> resolved 5+ reports. Extra machinery creates new bugs.
>
> Flush-bug lesson (generalized): Avoid extra input/state machinery when a
> simpler permanent fix exists. Applied to back navigation decision.
>
> Self-elevation is blocked: Never self-elevate the launcher. Malwarebytes
> flags it as an exploit payload.
>
> Deep Scan works on Free Malwarebytes license (not trial-only as previously
> believed). Rootkit scanning is off by default and should be enabled in guide
> instructions. Scan durations: ~27 min on Dell (clean); ~1 hr 36 min on
> IdeaPad (6 PUPs found).
>
> Periodic scanning = Windows Limited Periodic Scanning; manual-toggle only;
> plain-English instructions are the correct approach.
>
> Remote access recommendation for seniors: RDP off, Wake-on-LAN off (sourced
> rationale: FBI IC3 data on tech support fraud targeting seniors).
>
> Right-click copy and mouse highlight disabled by design (QuickEdit-off fix).
> Sanctioned scroll method: Mark mode (Alt+Space, E, M).
>
> 0x80000003 hex literal bug: PowerShell parses it as negative signed Int32
> before [uint32] cast; fix is decimal literal 2147483651.
>
> $yPos multi-element array bug: GUI mode crash fixed with int[0]) throughout
> plus diagnostic logging.
>
> Switch -Wildcard missing break: Professional matched both Professional and
> Pro patterns, returning a duplicated array. Always include break in switch
> -Wildcard.
>
> GatewayGuard must never be called "open source" — only "source-visible" or
> "fully auditable."
>
> **Approach & patterns**
>
> Model selection: Fable 5 or Opus 4.8 for .ps1 builds and complex debugging;
> Sonnet for copy, FAQ edits, companion sheets, email drafts.
>
> File naming: ISO 8601 dates in filenames; date+time stamps (US Eastern Time,
> auto EDT/EST by season) in every file header; every file carries a "File:"
> line in its header stating its exact filename including date and revision
> suffix.
>
> Revision suffixes: Same-day revisions get -r2/-r3 suffixes; filename and
> File: header line bump together in the same edit. Internal timestamps must
> reflect actual generation time (P-02 rule — Bill has explicitly corrected
> violations).
>
> Paired files: .ps1 and .bat launcher always updated together in the same
> response. Build naming: ascii-N convention (sequential). Field test case
> numbering: Sequential across rounds (Round 5 = FT-38–FT-60).
>
> Claude project management: "New chat" button in sidebar always starts outside
> a project. Bill works inside the GatewayGuard project.
>
> Communication style: Bill communicates in fragmented, fast-moving notes
> during active testing; Claude is expected to parse intent from incomplete
> sentences. Direct answers, no hedging, immediate action. No waffling on
> decisions Bill has delegated.
>
> Decision discipline: Flag discrepancies rather than silently resolving them
> (e.g., FT-57 logged with CONFIRM flag). Don't build when blockers are
> unresolved.
>
> Writing default: Layman's terms unless explicitly targeting a technical
> audience.
>
> Assisted sessions: Removed from launch marketing; parked as Phase 2
> post-launch roadmap item.
>
> **Tools & resources**
>
> Development: PowerShell (.ps1 + .bat launcher pairs), Windows 11 (Home and
> Pro). Security scanning: Windows Defender (including offline scan via
> Start-MpWDOScan), Malwarebytes Free. Code signing: Sectigo OV certificate
> (ordered). Auto-login: Sysinternals Autologon64.exe (Dell T3, intentional).
> Version/sync: OneDrive; GitHub Pages (website hosting). Domain registrar:
> Namecheap. Sales: Gumroad, Microsoft Store (planned). File storage path:
> C:\Users\willi\OneDrive\GatewayGuide\. Contact: william.wfbiii@gmail.com

---

## 3. THE PROJECT INSTRUCTIONS FIELD AS OF 2026-07-10

**Superseded in full** by `GatewayGuard_ProjectInstructions-2026-08-12-1652.md`.
Filed for lineage — several of these rules survive word for word, which shows
which ones have held for a month without needing revision.

> `<!-- Dated: 2026-07-10 18::00 EDT -->`
>
> This is the GatewayGuard project -- a Windows 11 security hardening tool for
> non-technical home users, launching September 1, 2026 (Maine LLC, solo
> development).
>
> Always check GatewayGuard_ProjectNotes.md in Project Knowledge before
> answering questions about project status, history, or past decisions. Update
> it when new decisions, research, or builds are discussed.
>
> All GatewayGuard user-facing content (tool text, guide copy, marketing, FAQ)
> must be plain English, zero jargon -- test: "Would a non-technical neighbor
> understand this in 5 seconds?"
>
> If a request or draft contradicts source documentation already in this
> workspace, flag the discrepancy rather than guessing or smoothing it over.
>
> **FILE NAMING:** Every file created or renamed for this project must use
> today's actual current date in the filename (US Eastern Time) -- append
> -YYYY-MM-DD before the extension. This is the date the rename/edit happens,
> not the date content was originally drafted.
>
> **FILE HEADERS:** Every file's internal header must show current DATE AND
> TIME in US Eastern Time, not date alone -- "# Dated: YYYY-MM-DD HH:MM ET" for
> .ps1/.psm1, "REM Dated: ..." for .bat, "<!-- Dated: ... -->" for .md, and a
> visible date+time line/footer for .docx/.pptx. Filename date and internal
> header date+time must always match -- when either changes, update BOTH in the
> same edit, never one without the other.
>
> **TIME ZONE:** Always use US Eastern Time -- automatically EDT (UTC-4) from
> mid-March to early November, and EST (UTC-5) the rest of the year. Never
> hardcode a fixed offset. Label the timestamp with "ET".
>
> **STALE INSTRUCTION CHECK:** If asked to review, confirm, or discuss these
> project instructions (or the Profile instructions) and the visible "Dated:"
> header is more than a few days old relative to today's actual date, flag that
> the file is stale and hasn't been re-saved recently.
>
> **CROSS-FILE SYNC:** Run-GatewayGuard.bat references its paired .ps1 build
> file by exact filename. Any time the .ps1 file is renamed or rebuilt, the
> .bat's filename reference must be corrected and re-presented in the SAME
> response -- never leave a .bat pointing to a superseded or deleted filename.
>
> **BUSINESS MODEL ACCURACY:** Assisted/screen-share sessions are a planned
> future offering, not part of launch scope -- always describe them as
> "planned" or "roadmap," never as currently available. This is distinct from
> beta-testing screen-share sessions, which are active now.
>
> **WRITING AUDIENCE DEFAULT:** All GatewayGuard writing defaults to the
> Layman's Positioning Statement's voice: plain English, no jargon, technical
> terms defined inline if used at all.
>
> **EXCEPTION -- EXPERT/TECHIE AUDIENCE:** When content is explicitly directed
> at IT professionals, technical media, security reviewers, or other expert
> audiences, use precise technical language appropriate to that audience.
> Default to layman's terms if unstated.
>
> **ACCURACY NOTE:** Do not describe GatewayGuard as "open-source" unless it
> has an actual public repository and OSI-approved license attached. Absent
> that, use "source-visible," "fully auditable," or "transparent, plaintext
> code" instead -- these support the same trust argument without an
> easily-disprovable claim.
>
> **MODEL SELECTION:** Any turn touching a .ps1 build file, licensing/legal
> analysis, or CPM scheduling must use Fable 5 or Opus. Sonnet is acceptable
> for marketing copy, FAQ, presentations, and emails. Never use Haiku on ascii
> builds -- multi-rule discipline degrades on smaller models.
>
> **BUILD GATE:** No .ps1 build is presented as complete until the Appendix A
> pre-build audit has been run and passed, with results shown in the same
> response. A failed check blocks the build from being delivered.
>
> **USER-FACING CLARITY:** Every prompt, key label, and instruction shown to
> the user must state exactly what each action does. Never say "press X when
> done" if X and "done" mean different things. Test: could a non-technical
> senior user predict exactly what will happen before pressing the key?

---

## 4. PROJECT KNOWLEDGE FILE LIST AS OF 2026-07-13

Capacity read **22% of project capacity used**. Useful as a record of what
Cloud could see at that date, and of line counts for documents that have since
grown.

| File | Lines | Type |
|---|---|---|
| GatewayGuard_ProjectNotes.md | 3,651 | md |
| GatewayGuard_ProjectNotes-2026-07-11-r4.md | 3,570 | md |
| W11-SecurityHardening-v3-ascii30-2026-07-14.ps1 | 5,111 | ps1 |
| W11-SecurityHardening-v3-ascii29-2026-07-13.ps1 | 5,092 | ps1 |
| W11-SecurityHardening-v3-ascii28-2026-07-13.ps1 | 4,867 | ps1 |
| GatewayGuard-BitLocker-Screens-ascii29-2026-07-13.ps1 | 239 | ps1 |
| GatewayGuard-BitLocker-Overnight-2026-07-13.ps1 | 171 | ps1 |
| GatewayGuard_SystemBaseline_Diagnostic.ps1 | 111 | ps1 |
| Run-GatewayGuard.bat | 12 | bat |
| Run-Diagnostic (1).bat | 34 | bat |
| GatewayGuard_PresentationCompanionSheet-2026-07-03.md | 655 | md |
| GatewayGuard_WebsitePrePlan-2026-07-12.md | 399 | md |
| GatewayGuard_WebsitePrePlan.md | 365 | md |
| GatewayGuard_ClaudeUsageGuide-2026-06-30.md | 300 | md |
| GatewayGuard_ClaudeProjectSetup.md | 274 | md |
| GatewayGuard_SettingsToGuideMap.md | 270 | md |
| GatewayGuard_CodingStandards.md | 268 | md |
| GatewayGuard_DefectPreventionPlaybook-2026-07-13.md | 261 | md |
| GatewayGuard_FieldTestNotes_Round5-2026-07-12.md | 256 | md |
| GatewayGuard_MBDefender_Screens.md | 237 | md |
| GatewayGuard_FAQ.md | 222 | md |
| GatewayGuard_LaunchAssets.md | 220 | md |
| GatewayGuard_ascii23_DevNotes (1).md | 211 | md |
| GatewayGuard_EnvironmentHardening (1).md | 184 | md |
| GatewayGuard_Checklist.txt | 142 | txt |
| GatewayGuard_CPM_Schedule.md | 107 | md |
| What is Ascii.txt | 9 | txt |
| Marketing-Notes.docx | 700 | docx |
| GatewayGuard_MarketResearch.docx | 157 | docx |
| Expert Positioning Statemen.docx | 43 | docx |
| GatewayGuard_CommunityFlyer.docx | 33 | docx |
| Layman Positioning Statement.docx | 26 | docx |
| mainellc6.pdf · LocalCommunityWorkshopPlan.pdf · PCSafetyChecklist.pdf · Capture_Streaming_Audio_Windows11.pdf · MB Privacy policy..pdf | — | pdf |

**Note the two typos preserved here:** `Expert Positioning Statemen.docx`
(missing the `t`) and the duplicate `GatewayGuard_CPM_Schedule.md` /
`GatewayGuard_SettingsToGuideMap.md` entries — both files were uploaded twice.

**Also note `GatewayGuard_MarketResearch.docx`, 157 lines — the real market
research, which is NOT this file.** It is in the tree, in five places
(**measured** 2026-08-13):

| Copy | Note |
|---|---|
| `ProjectDocs\GatewayGuard_MarketResearch.docx` | **In connector scope.** Cloud can already read it |
| `ProjectDocs\GatewayGuard_MarketResearch.md` | Same document, second format |
| `GatewayGuard_AllFiles_06-29-26\Newest_Package\` | Archive copy |
| `Run_Comments\files (1) 06-28-26\` | Archive copy |
| `Incoming\GatewayGuard_MarketResearch-2026-06-27.docx` | In git history only |

*This paragraph first said the document "is not in this tree… no file of that
name on disk or in git history." **That was false, and it was written before
the search was run.** It is corrected here rather than quietly deleted,
because it is a textbook EXHAUST THE FORMS breach committed inside a document
whose own purpose is recording what was and was not lost — and because the
same mistake, undetected, is how `TestHistory-ascii39-0914` came to be
recorded as "never existed."*

---

## HOW TO RECOVER THE ORIGINAL

The source file and its scaffolding were removed from the working tree on
2026-08-13. They remain in git history:

```
git checkout <commit> -- "Marketing/atewayGuard_MarketResearch.html"
git checkout <commit> -- "Marketing/atewayGuard_MarketResearch_files"
```

The commit that removed them names them in its message. Nothing is destroyed;
OneDrive also holds them in its 30-day recycle bin.
