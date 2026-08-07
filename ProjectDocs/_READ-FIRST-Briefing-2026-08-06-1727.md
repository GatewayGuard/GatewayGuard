<!-- Dated: 2026-08-06 17:27 EDT -->
# READ FIRST -- Session Briefing
**Document Name:** _READ-FIRST-Briefing
**Last Modified:** 2026-08-06 17:27 EDT
**Last Editor:** Claude.ai
**Purpose:** Read this before anything else at the start of every session.
**Supersedes:** `_READ-FIRST-Briefing-2026-08-02-1820.md` -- retire that file

---

## CURRENT PROJECT STATUS (as of 2026-08-06 17:27 EDT)

**Active build:** ascii39 -- **NOT YET FIELD RUN. No log exists.**
**Target launch:** September 1, 2026 at gatewayguard.co.
**Current phase:** M365 tenant migration, website build, code-signing cert pending.

---

## THE THREE THINGS THAT MATTER MOST RIGHT NOW

1. **ascii39 has never been field run.** Nothing may be scoped, built, or
   numbered as ascii40 until a field log exists. The M365 migration plan
   previously instructed exactly that increment; it has been corrected.
2. **SANDY (the HP) is the only unencrypted machine in the fleet.** It is
   therefore the only machine that can test item 8's Home-unencrypted branch.
   Its value there is spent permanently the first time encryption actually
   completes on it.
3. **A stale machine-state line in the ProjectInstructions caused a false
   alarm this session.** The corrected encryption matrix now lives in one
   place -- ProjectInstructions, MACHINE CHECK section. TestHistory
   measurements outrank any prose description of machine state.

---

## MACHINE FLEET -- CORRECTED 2026-08-06

| Machine | Hardware | Edition | Sign-in | Encryption | Basis |
|---|---|---|---|---|---|
| **CGDELL** | Dell Latitude 5430, 32 GB | Win 11 **Pro** | **Microsoft account** | **Fully encrypted** | **measured** 2026-08-02 (FT-143/144/145) |
| **SANDY** | HP Notebook 17-by1955cl, 8 GB | Win 11 **Home** | **Local account** | **NOT encrypted** | reported by Bill 2026-08-06 |
| **Sandy3** | Lenovo IdeaPad, 8 GB | Win 11 **Home** | unverified | **Pre-encrypted by Windows** | prior note -- unverified |

**The prior briefing and the prior ProjectInstructions described CGDELL as
having BitLocker off. That was wrong.** CGDELL reads
`Encrypted / 100 / FullyEncrypted` and `Get-SignInAccountType` returns
`Microsoft`, both measured on 2026-08-02 and recorded in
`GatewayGuard_TestHistory-ascii39-2026-08-02-0914.md`.

**Machine notes:**
- **SANDY** needs the TP-Link Archer T2U Nano USB adapter for any network --
  internal RTL8821CE Wi-Fi is a confirmed hardware failure. If no internet,
  check Malwarebytes filtering is set to none before suspecting the adapter.
- **Sandy3** touchpad is disabled in Settings; use a mouse. 290 GB free.

Always ask which machine Bill is on before giving any machine-specific steps.

---

## WHAT HAPPENED IN THE SESSION OF 2026-08-06

- Reviewed the M365 migration plan. Found **Phase 4 instructed an increment to
  ascii40**, which violates the UNRUN BUILD RULE with ascii39 unrun.
- Established the corrected encryption matrix for all three machines.
- Determined the ascii39 field test belongs on **SANDY**, not CGDELL -- CGDELL
  cannot reach the branch that most needs testing.
- Scoped SANDY (the HP) explicitly **out** of the M365 migration.
- **Error made and corrected:** Claude warned that CGDELL had unexpectedly
  encrypted itself and sent Bill after a recovery key and a `dsregcmd`
  diagnostic. The measurement showing CGDELL already encrypted was in project
  knowledge and was not searched for first. Rule added: MACHINE-STATE CURRENCY.

### Documents produced this session
- `GatewayGuard_ProjectInstructions-2026-08-06-1727.md`
- `GatewayGuard_M365MigrationPlan-2026-08-06-1727.md`
- `_READ-FIRST-Briefing-2026-08-06-1727.md` (this file)

---

## STILL PENDING -- CARRY INTO NEXT SESSION

### Verified this session

| Item | Status |
|---|---|
| ascii39 field run | **NOT DONE** -- assign to SANDY |
| Path grep on CGDELL (read-only) | **NOT DONE** -- no blockers, do anytime |
| Sandy3 business OneDrive setup | **IN PROGRESS** -- M365 Phase 1 |
| Tree migration | Not started -- M365 Phase 3 |
| Domain TXT verification | Not started -- M365 Phase 5 |
| University subscription cancellation | Not started -- M365 Phase 6, last |

### Carried from 2026-08-02 -- STATUS UNCONFIRMED

These were pending on 2026-08-02 with dates that have since passed. **None were
confirmed in the 2026-08-06 session.** Reconfirm each before acting on it.

| Item | Last known state |
|---|---|
| Upload 19 guide pages to GitHub `guide/` | Zip ready; upload was Bill's task |
| Delete 17 old timestamped HTML files from project | Manual deletion in Claude UI |
| Maine Community Bank account | Was scheduled 8/3 |
| SAM.gov EFT registration | Blocked on bank account number |
| D&B DUNS listing | Blocked on bank info |
| Google Business brand profile | Was scheduled 8/3 |
| DigiCert / SignMyCode validation | Blocked on D&B or bank letter or SAM.gov |
| LegalZoom EULA / trademark review | Was scheduled 8/4 noon |
| Guide rewrite (v9 -> current) | Not started |
| Batch 2 HTML (tips, beta, compatible) | Not started, decisions needed |
| Gumroad vs. direct checkout compliance | Open -- needed before Sept 1 |

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

### Permission language
- Every sentence describing a setting change must name the user's approval
- "Checkup turned it off with your approval."
- "Checkup asks your permission before making any change."

### Files
- Ask Bill for date and time before producing any file. **Once given, that
  answer stands for the session** -- do not re-ask before every file.
- Filename format: `DocumentName-YYYY-MM-DD-HHMM.ext`
- Every file is a complete self-contained replacement -- no addendums

### Actions
- State scope and ask "Confirm?" before any bulk/destructive operation.
  **Once Bill confirms, act** -- do not re-ask the same question reworded.
- Flag session length when more than 10 files produced or rules forgotten

### Evidence
- Label every factual claim **measured / sourced / inferred / guess**
- Only *measured* and *sourced* may enter the tool or user-facing copy
- **Search project knowledge before describing machine state or past results.**
  A TestHistory measurement outranks any prose description in any document.

---

## GOVERNING DOCUMENTS -- READ BEFORE BUILDING

| Document | When to read |
|---|---|
| `GatewayGuard_ProjectInstructions-2026-08-06-1727.md` | Every session start |
| `GatewayGuard_CodingStandards-2026-08-02-0741.md` | Before any .ps1 build |
| `GatewayGuard_DefectPreventionPlaybook-2026-07-25-1936.md` | Before any .ps1 build |
| `GatewayGuard_WebsiteStandards-2026-07-26-0619.md` | Before any HTML work |
| `GatewayGuard_TestHistory-ascii39-2026-08-02-0914.md` | Before any claim about machine state or past defects |
| `GatewayGuard_M365MigrationPlan-2026-08-06-1727.md` | Before any OneDrive / tenant / domain work |
| `CLAUDE.md` | Before any guide or website copy |
| `GatewayGuard_ScreenContents-2026-07-28-1003.md` | Before writing any tool-facing copy |

---

## READ/WRITE WORKFLOW -- HOW THE TWO CLAUDES DIVIDE WORK

Claude project knowledge is **read-only** from this chat. This chat can read
project files but cannot write back to them.

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

**Note:** the tree's location changes during the M365 migration. Until Phase 3
completes it is under `C:\Users\willi\OneDrive\`; after, it is under
`C:\Users\willi\OneDrive - GatewayGuard LLC\`.

**GitHub as sync layer for HTML:** Claude Code commits HTML to the repo; the repo
is authoritative for website files. No need to keep HTML in the Claude project
once it is on GitHub.

---

## NEXT SESSION PRIORITIES (in order)

1. **ascii39 field run on SANDY** -- item 8 screens exercised, encryption NOT
   started, log uploaded. Unblocks everything downstream.
2. **Path grep on CGDELL** -- read-only, may prove the path-fix work is empty
3. Finish M365 Phase 1 (Sandy3 OneDrive), then Phases 2 and 3
4. Reconfirm the unconfirmed business items above -- bank, SAM.gov, DigiCert,
   LegalZoom
5. Confirm GitHub guide pages uploaded; confirm 17 stale HTML files deleted
6. Guide rewrite -- bring `windows_security_walkthrough_guide_v9.docx` up to
   current truth from the 19 pages
7. Batch 2 website pages: tips.html, beta.html, compatible.html
