<!-- Dated: 2026-08-09 11:10 EDT -->
# READ FIRST -- Session Briefing
**Document Name:** _READ-FIRST-Briefing
**Last Modified:** 2026-08-09 11:10 EDT
**Last Editor:** Claude.ai
**Purpose:** Read this before anything else at the start of every session.
**Supersedes:** `_READ-FIRST-Briefing-2026-08-06-1727.md` -- retire that file

**Change History Log:**
- 2026-08-09 11:10: Added INDEX-VS-MOUNT rule (earned this session), the
  archive/backup finding, the delivered-but-never-uploaded file audit, the
  live Marketing-Notes accuracy violation, and the superseded-version
  decision list. Corrected the TestHistory pointer to the -1116 version.
- 2026-08-06 17:27: Machine fleet encryption matrix corrected; ascii40
  increment removed from M365 Phase 4; MACHINE-STATE CURRENCY rule added.

---

## CURRENT PROJECT STATUS (as of 2026-08-09 11:10 EDT)

**Active build:** ascii39 -- **NOT YET FIELD RUN. No log exists.**
**Target launch:** September 1, 2026 at gatewayguard.co. **23 days out.**
**Current phase:** M365 tenant migration, website build, code-signing cert
pending, project-file cleanup.

---

## THE FOUR THINGS THAT MATTER MOST RIGHT NOW

1. **ascii39 has never been field run.** Nothing may be scoped, built, or
   numbered as ascii40 until a field log exists.
2. **SANDY (the HP) is the only unencrypted machine in the fleet.** It is
   therefore the only machine that can test item 8's Home-unencrypted branch.
   Its value there is spent permanently the first time encryption completes.
3. **`Marketing-Notes.docx` currently describes GatewayGuard as "a completely
   free, open-source guide and helper script."** Three occurrences, in the
   Reddit pitch. This breaks the ACCURACY NOTE and contradicts $19.99 pricing.
   It is live in project knowledge right now. **measured** 2026-08-09.
4. **The project-knowledge file mount cannot be trusted for completeness.**
   See the next section. Two verification passes in the 2026-08-09 session
   returned a false "exact match."

---

## INDEX-VS-MOUNT RULE (added 2026-08-09) -- READ BEFORE ANY FILE AUDIT

**The `/mnt/project/` bash mount is not a reliable listing of project
knowledge. The project index supplied at session start is authoritative.**

**measured, 2026-08-09:** the mount lagged the index by 5+ files at session
start, then caught up unevenly over three hours. Late in the session two
files appeared and two vanished between checks minutes apart, with **no
delete action taken**, while the total count held steady at 108 -- so the
churn was invisible to a count check.

**Three rules follow:**

1. **Never hand-transcribe the index to diff against it.** Twice in one
   session a diff returned "index N / mount N, zero discrepancies" only
   because the transcription dropped the same files the mount was missing.
   Both checks were worthless and both were reported as proof.
2. **A matching file count is not a matching file set.** Compare names.
3. **If the mount churns mid-session, stop and rebuild in a new chat.**
   Project knowledge is a read-only snapshot frozen at session start; a
   fresh session gets one coherent listing.

---

## PROJECT KNOWLEDGE IS NOT A BACKUP (established 2026-08-09)

**measured** by `file` and Python `zipfile` inspection of every non-text file:

| Class | Condition |
|---|---|
| `.md` `.txt` `.ps1` `.html` `.cs` | Byte-exact. Faithful. |
| `.docx` `.odt` | **Plain UTF-8 text extractions.** Word will not open them. All formatting, fonts, tables, headers, images gone. |
| `.pdf` | **Zip bundles of page JPEGs plus OCR text.** No PDF reader opens them. |

Example: `GatewayGuard_License-2026-08-07-0726.docx` is 15,910 bytes of
Markdown-ish text; `zipfile` rejects it with `BadZipFile`.
`mainellc6.pdf` is a zip containing `1.jpeg, 2.jpeg, 3.jpeg, 1.txt, 2.txt,
3.txt`.

**`OneDrive\GatewayGuard` is the only real backup.** Archive from there.
Anything pulled out of project knowledge is a text-searchable reference copy,
never a document of record.

---

## MACHINE FLEET

| Machine | Hardware | Edition | Sign-in | Encryption | Basis |
|---|---|---|---|---|---|
| **CGDELL** | Dell Latitude 5430, 32 GB | Win 11 **Pro** | **Microsoft account** | **Fully encrypted** | **measured** 2026-08-02 (FT-143/144/145) |
| **SANDY** | HP Notebook 17-by1955cl, 8 GB | Win 11 **Home** | **Local account** | **NOT encrypted** | reported by Bill 2026-08-06 |
| **Sandy3** | Lenovo IdeaPad, 8 GB | Win 11 **Home** | unverified | **Pre-encrypted by Windows** | prior note -- unverified |

**Machine notes:**
- **SANDY** needs the TP-Link Archer T2U Nano USB adapter for any network --
  internal RTL8821CE Wi-Fi is a confirmed hardware failure. If no internet,
  check Malwarebytes filtering is set to none before suspecting the adapter.
- **Sandy3** touchpad is disabled in Settings; use a mouse. 290 GB free.

Always ask which machine Bill is on before giving any machine-specific steps.

---

## WHAT HAPPENED IN THE SESSION OF 2026-08-09

Session was a project-knowledge archive and file audit. No build work.

- **Project knowledge grew from 94 to 108 files** as Bill uploaded previously
  missing deliverables during the session.
- Built and delivered a cleaned archive zip; rebuilt it three times as files
  arrived. Final delivery is explicitly **partial** -- see below.
- **Established that project knowledge stores ingested representations, not
  originals** (section above). This was the session's most consequential
  finding: an archive taken from here is not a backup.
- **Audited all past chats for delivered files never uploaded.** Results below.
- **Found the live `Marketing-Notes.docx` accuracy violation** and confirmed
  from the 2026-07-17 transcript that the marketing rewrites were never done.
  The chat summary for that session says they were; the transcript reads
  "no and no." **Transcript outranks summary.**
- **Errors made this session:** the same verification error twice -- a
  hand-transcribed index diff reported as "exact match" when both sides shared
  the same gap. Also told Bill the 14pt and 20pt Guide editions were absent
  from project knowledge when both had been in the index since session start.
  Cause in every case: reading the mount, calling it the index.

### Files delivered this session
- `GatewayGuard_ProjectKnowledgeArchive-Partial-2026-08-09-1110.zip`
  (90 project files + manifest; **known-incomplete, see below**)
- `_READ-FIRST-Briefing-2026-08-09-1110.md` (this file)

---

## THE ARCHIVE -- WHAT WAS DELIVERED AND WHAT IT LACKS

`GatewayGuard_ProjectKnowledgeArchive-Partial-2026-08-09-1110.zip` contains
108 project files minus the 18 approved exclusions, plus a manifest.

**Three files that ARE in project knowledge are missing from it:**
- `GatewayGuard_GuideStandard14pt20260716.pdf` -- **the default Guide edition**
- `GatewayGuard_GuideCompact12pt20260716.pdf`
- `mainellc6.pdf` -- Maine LLC filing

It is named `-Partial-` deliberately so it cannot be mistaken for a complete
snapshot. **Rebuild it at the start of a new chat**, excluding the same 18,
diffing against the index as given.

---

## OPEN DECISIONS -- BILL'S CALL

| Decision | Detail |
|---|---|
| Delete the nine superseded document versions? | Would enforce "one unique filename per document type, forever." List below. |
| Re-add a current `404.html`? | `GatewayGuard_404-2026-07-30-2310.html` is excluded as superseded but has **no undated successor** -- no 404 page would remain in project knowledge. Page is live on the site. |
| Upload the still-absent files? | List below. Some omissions may be deliberate. |

### Superseded versions still in project knowledge

| Document | Versions present | Current |
|---|---|---|
| ProjectInstructions | 08-02-0741, 08-02-1820, 08-06-1727 | 08-06-1727 |
| _READ-FIRST-Briefing | 08-02, 08-02-1820, 08-06-1727 | **this file** |
| CodingStandards | 07-26-0619, 08-02-0741 | 08-02-0741 |
| CPM_Schedule | 07-30-2208, 08-02-1201 | 08-02-1201 |
| License | 08-04-0120, 08-07-0726 | 08-07-0726 |
| M365MigrationPlan | 08-06-1425, 08-06-1727 | 08-06-1727 |
| TestHistory-ascii39 | 08-02-0914, 08-02-1116 | 08-02-1116 |
| LegalZoomGuide | 07-24-0921, 07-24-0846 | **07-24-0846** |

**LegalZoomGuide timestamps run backwards.** The document's own change history
reads `09:21 -- Initial version` and `08:46 -- Added copyright registration
process`. The update carries an EARLIER filename stamp than the draft it
replaced. `-0846` is current. This is the one pair where the filename
date-time is an unreliable version label.

### Delivered in past sessions, still NOT in project knowledge

| File | Where it was delivered | Why it matters |
|---|---|---|
| `GatewayGuard_NamingStandard-2026-07-18-r2.md` | Chat "OV certificate enrollment pending", 07-18 | **The 19-setting name source of truth** (N-01--N-06, two named exceptions). Nothing in project knowledge currently defines the canonical setting names. |
| `Run-GatewayGuard.bat` | Ships paired with every build | **Has never been in project knowledge.** The CROSS-FILE SYNC check has therefore never been verifiable from this chat. Should reference `W11-SecurityHardening-v3-ascii39-2026-07-30-2208.ps1`. |
| `GatewayGuard_FutureProjects-2026-07-19.md` | Chat "Unmet market demand research", 07-23 | 21 items FP-01--FP-21. ProjectNotes IQ-01--IQ-14 still carry a "manual dedupe pending" note against this file. |
| `GatewayGuard_SessionLog.md` | Chat "Website Project", 08-04 | Shared memory between Claude.ai and Claude Code per the SESSION LOG RULE. |
| `Tool\Run-ExternalCommandCheck.bat` | Claude Code, 08-02 | Gate 24 enforcement -- the mechanical check that exists because FT-162 shipped. |
| `GatewayGuard_FilesCleanupList-2026-07-24-0846.docx` | Chat "HP Sandy gateway guard logs", 07-24 | Inventory step of the cleanup. |
| `GatewayGuard_ProjectFiles_DeleteKeep-2026-07-21-2023.txt` | Chat "DigiCert validation request review", 07-22 | Original delete/keep analysis. |
| `GatewayGuard_All19_Final-2026-08-02-1820.zip` | Chat "Website Project", 08-04 | Low priority -- the 19 undated HTML pages are present. |

---

## MARKETING ACCURACY -- OPEN VIOLATION

**`Marketing-Notes.docx` is in project knowledge and calls GatewayGuard
"a completely free, open-source guide and helper script."** Three occurrences.

Traced to the 2026-07-17 session, where the ACBL pitch email, both Positioning
Statements, the CommunityFlyer, and Marketing-Notes were all identified as
needing an open-source purge -- and **none of the rewrites were done.** The
session summary claims they were; the transcript records "no and no."

Clean elsewhere: the `password-manager.html` hit is Bitwarden, correctly
described as open-source. Hits in ProjectInstructions, WebsiteStandards, and
ProjectNotes are the rule text itself. `Sectigo` appears in CLAUDE.md and both
CPM schedules -- standing instruction is to ignore Sectigo references in older
notes.

---

## STILL PENDING -- CARRY INTO NEXT SESSION

| Item | Status |
|---|---|
| ascii39 field run | **NOT DONE** -- assign to SANDY. Blocks everything downstream. |
| Delete the 18 superseded files from project | **NOT DONE** -- all 18 still present. Manual, in the Claude project file panel. No tool can do it. |
| Rebuild the archive complete | **NOT DONE** -- current zip is `-Partial-` |
| Marketing rewrites (open-source purge) | **NOT STARTED** -- 5 documents |
| Path grep on CGDELL (read-only) | **NOT DONE** -- no blockers, do anytime |
| Sandy3 business OneDrive setup | **IN PROGRESS** -- M365 Phase 1 |
| Tree migration | Not started -- M365 Phase 3 |
| Domain TXT verification | Not started -- M365 Phase 5 |
| University subscription cancellation | Not started -- M365 Phase 6, last |

### Carried forward -- STATUS UNCONFIRMED

Dates on these have passed and none were confirmed in the 08-06 or 08-09
sessions. Reconfirm each before acting.

| Item | Last known state |
|---|---|
| Upload 19 guide pages to GitHub `guide/` | Zip ready; Bill's task |
| Maine Community Bank account | Checking + savings **opened** (08-04). Checking is the qualifying demand deposit account for DigiCert -- must be named explicitly in any bank letter. |
| SAM.gov EFT registration | Blocked on bank account number |
| D&B DUNS listing | Blocked on bank info |
| Google Business brand profile | Standard listing unavailable for online-only |
| DigiCert / SignMyCode validation | Pending validation |
| LegalZoom EULA review | **Consult completed 08-04.** Six license decisions still open; two attorney follow-ups (Gumroad refund override, EU/UK withdrawal rights). |
| Guide rewrite (v9 -> current) | Not started |
| Batch 2 HTML (tips, beta, compatible) | Not started, decisions needed |
| Gumroad vs. direct checkout | Open -- blocks refund terms and sales tax |

---

## KEY RULES CURRENTLY IN EFFECT -- READ BEFORE WRITING ANYTHING

### Naming
- First mention: **GatewayGuard Checkup** -- all subsequent: **Checkup**
- Company name: **GatewayGuard** or **GatewayGuard LLC**
- Never: "the tool", "the program", "SecurityGuard", "SecurityGuide"

### Banned words (ALL user-facing copy)
- **"whether"** -- replace with "if"
- **"whereas"** -- never use
- **"switch"** as a verb for settings -- replace with "turn on/off"
- Never **"open-source"** for GatewayGuard -- use "source-visible",
  "fully auditable", or "transparent, plaintext code"
- Never **"human-backed"** -- assisted sessions are roadmap only

### Permission language
- Every sentence describing a setting change must name the user's approval
- "Checkup turned it off with your approval."
- "Checkup asks your permission before making any change."

### Files
- Ask Bill for date and time before producing any file. **Once given, that
  answer stands for the session** -- do not re-ask before every file.
- Filename format: `DocumentName-YYYY-MM-DD-HHMM.ext`
- Every file is a complete self-contained replacement -- no addendums
- A filename that overstates what a file contains is a version label that
  lies. Name it for what it is (`-Partial-`, not `-Clean-`).

### Actions
- State scope and ask "Confirm?" before any bulk/destructive operation.
  **Once Bill confirms, act** -- do not re-ask the same question reworded.
- Flag session length when more than 10 files produced or rules forgotten

### Evidence
- Label every factual claim **measured / sourced / inferred / guess**
- Only *measured* and *sourced* may enter the tool or user-facing copy
- **Search project knowledge before describing machine state or past results.**
  A TestHistory measurement outranks any prose description in any document.
- **A chat transcript outranks that chat's summary.** Summaries collapse
  "Claude recommended X" into "X was done."
- **The project index outranks the bash mount.** See INDEX-VS-MOUNT above.

---

## GOVERNING DOCUMENTS -- READ BEFORE BUILDING

| Document | When to read |
|---|---|
| `GatewayGuard_ProjectInstructions-2026-08-06-1727.md` | Every session start |
| `GatewayGuard_CodingStandards-2026-08-02-0741.md` | Before any .ps1 build |
| `GatewayGuard_DefectPreventionPlaybook-2026-07-25-1936.md` | Before any .ps1 build |
| `GatewayGuard_WebsiteStandards-2026-07-26-0619.md` | Before any HTML work |
| `GatewayGuard_TestHistory-ascii39-2026-08-02-1116.md` | Before any claim about machine state or past defects |
| `GatewayGuard_M365MigrationPlan-2026-08-06-1727.md` | Before any OneDrive / tenant / domain work |
| `CLAUDE.md` | Before any guide or website copy |
| `GatewayGuard_ScreenContents-2026-07-28-1003.md` | Before writing any tool-facing copy |

**Pointer discrepancy:** `CLAUDE.md` names
`GatewayGuard_DefectPreventionPlaybook-2026-07-26-0619.md`. Project knowledge
holds only `-2026-07-25-1936`. Either a newer Playbook exists locally and was
never uploaded, or the pointer is stale. CLAUDE.md's own guidance is to glob
the name and take the newest -- do that, and resolve which is true.

---

## READ/WRITE WORKFLOW -- HOW THE TWO CLAUDES DIVIDE WORK

Claude project knowledge is **read-only** from this chat. This chat can read
project files but cannot write back to them, and **cannot delete them.**

| Task | Use |
|---|---|
| Documents, planning, guides, business tasks | This chat (Claude.ai) |
| HTML builds, file edits, read/write to local folder | Claude Code terminal |
| Governing documents, standards, briefings | Claude project knowledge (reference library) |

**The sync loop:**
1. Claude Code builds or edits files -> saves to the GatewayGuard tree
2. Bill uploads updated files to the Claude project -> available to this chat
3. This chat produces documents -> Bill downloads -> uploads to project or saves
   to the tree

**Files uploaded mid-session are not reliably visible until a new chat.**

**Note:** the tree's location changes during the M365 migration. Until Phase 3
completes it is under `C:\Users\willi\OneDrive\`; after, it is under
`C:\Users\willi\OneDrive - GatewayGuard LLC\`.

**GitHub as sync layer for HTML:** Claude Code commits HTML to the repo; the
repo is authoritative for website files.

---

## NEXT SESSION PRIORITIES (in order)

1. **ascii39 field run on SANDY** -- item 8 screens exercised, encryption NOT
   started, log uploaded. Unblocks everything downstream. 23 days to launch.
2. **Delete the 18 superseded files** in the Claude project file panel, and
   decide on the nine superseded document versions.
3. **Rebuild the archive complete** -- diff against the index as given.
4. **Marketing open-source purge** -- Marketing-Notes, CommunityFlyer, ACBL
   pitch, both Positioning Statements.
5. Path grep on CGDELL -- read-only, may prove the path-fix work is empty.
6. Finish M365 Phase 1 (Sandy3 OneDrive), then Phases 2 and 3.
7. Reconfirm the unconfirmed business items -- SAM.gov, D&B, DigiCert.
8. Resolve the six open license decisions and the two attorney follow-ups.
9. Guide rewrite -- bring `windows_security_walkthrough_guide_v9.docx` up to
   current truth from the 19 pages.
10. Batch 2 website pages: tips.html, beta.html, compatible.html.
