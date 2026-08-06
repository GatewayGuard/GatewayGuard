<!-- Dated: 2026-08-02 18:20 EDT -->
# READ FIRST — Session Briefing
**Document Name:** _READ-FIRST-Briefing
**Last Modified:** 2026-08-02 18:20 EDT
**Purpose:** Read this before anything else at the start of every session.

---

## CURRENT PROJECT STATUS (as of 2026-08-02 18:20 EDT)

**Active build:** ascii39 — field testing in progress on SANDY.
**Target launch:** September 1, 2026 at gatewayguard.co.
**Current phase:** Website build, business setup, code-signing cert pending.

---

## WHAT WAS COMPLETED IN THE SESSION OF 2026-08-02

### Website — 19 guide pages COMPLETE
All 19 setting pages are built, fixed, and zipped:
`GatewayGuard_All19_Final-2026-08-02-1820.zip`

Every page has:
- "GatewayGuard Checkup" on first mention, "Checkup" thereafter
- No "whether" or "whereas" anywhere
- "turn on/off" — never "switch" as a setting verb
- User permission named on every setting-change sentence
- H-1 corruption grep passed

**Still needed:** Upload zip to GitHub guide/ folder (Bill's next task).

### Rules added to ProjectInstructions (2026-08-02-1820)
- PL-1: Banned words — "whether" and "whereas"
- PL-2: Checkup's verb — "turn on/off", never "switch"
- PL-3: Name the permission on every setting change
- CHECKUP NAME RULE — full name first, "Checkup" after
- CONFIRM BEFORE ACTING — state scope, wait for yes before bulk actions
- SESSION LENGTH WARNING — flag when session is too long, suggest new chat

### Project file cleanup
- 17 old timestamped HTML files marked for deletion from project
- Bill must manually delete these from the Claude project interface
- No-timestamp versions from Claude Code are the authoritative set

### Business setup (in progress)
- Maine Community Bank: closed today, plan to open account Monday 8/3 at 8:30 AM
- SAM.gov: needs bank account info before completing EFT section
- Google Business: online businesses not allowed standard listing; using free brand profile
- DigiCert/SignMyCode: needs D&B listing OR SAM.gov OR bank letter before validation call
- LegalZoom EULA review: rescheduled to Tuesday 8/4 at noon
- D&B listing: needs bank account info

### Documents produced this session
- `GatewayGuard_BankLetterRequest-2026-08-02-1820.docx` — printable letter for bank manager
- `GatewayGuard_TomorrowActionList-2026-08-02-1820.docx` — Monday 8/3 action plan
- `GatewayGuard_ProjectInstructions-2026-08-02-1820.md` — updated with 5 new rules
- `GatewayGuard_All19_Final-2026-08-02-1820.zip` — all 19 guide pages final

---

## STILL PENDING — CARRY INTO NEXT SESSION

| Item | Status | Blocker |
|------|--------|---------|
| Upload 19 pages to GitHub guide/ folder | Bill's next task | None — zip is ready |
| Delete 17 old timestamped HTML files from project | Bill's task | Requires manual deletion in Claude UI |
| Open Maine Community Bank account | Monday 8/3 8:30 AM | Bank closed today |
| SAM.gov EFT registration | After bank | Need account number |
| D&B DUNS listing | After bank | Need bank info |
| Google Business brand profile | Monday | None |
| DigiCert validation call | Within week | Need D&B or bank letter or SAM.gov |
| LegalZoom EULA review | Tuesday 8/4 noon | Rescheduled |
| Guide rewrite (v9 → current) | Not started | Next session task |
| Project file cleanup Task 3 | Not started | Needs Claude session |
| ascii39 field testing | In progress on SANDY | Awaiting results |
| Batch 2 HTML pages (tips, beta, compatible) | Not started | Decisions needed |

---

## KEY RULES CURRENTLY IN EFFECT — READ BEFORE WRITING ANYTHING

### Naming
- First mention: **GatewayGuard Checkup** — all subsequent: **Checkup**
- Company name: **GatewayGuard** or **GatewayGuard LLC**
- Never: "the tool", "the program", "SecurityGuard", "SecurityGuide"

### Banned words (ALL user-facing copy)
- **"whether"** — replace with "if"
- **"whereas"** — never use
- **"switch"** as a verb for settings — replace with "turn on/off"

### Permission language
- Every sentence describing a setting change must name the user's approval
- "Checkup turned it off with your approval."
- "Checkup asks your permission before making any change."

### Files
- Always ask Bill for date and time before producing any file
- Filename format: `DocumentName-YYYY-MM-DD-HHMM.ext`
- Every file is a complete self-contained replacement — no addendums

### Actions
- State scope and ask "Confirm?" before any bulk/destructive operation
- Flag session length when more than 10 files produced or rules forgotten

---

## MACHINE FLEET
- **CGDELL** — Dell Latitude 5430, Win 11 Pro, 32GB, primary dev machine
- **SANDY** — HP Notebook 17-by1955cl, Win 11 Home, 8GB, currently in ascii39 field testing
- **Sandy3** — Lenovo IdeaPad, Win 11 Home, 8GB, touchpad disabled

Always ask which machine Bill is on before giving any machine-specific steps.

---

## GOVERNING DOCUMENTS — READ BEFORE BUILDING

**Dates are omitted on purpose. Glob the name and take the newest.** Every one of
these is re-issued under a new date each time it changes, so a filename spelled
out in full here goes stale silently. That has already happened — CLAUDE.md
records two of its three pointers stale by 2026-08-02, one of them for eleven
days. Match the pattern, sort by date, read the newest.

| Document | When to read |
|----------|-------------|
| `GatewayGuard_ProjectInstructions-*.md` | Every session start |
| `GatewayGuard_CodingStandards-*.md` | Before any .ps1 build |
| `GatewayGuard_DefectPreventionPlaybook-*.md` | Before any .ps1 build |
| `GatewayGuard_WebsiteStandards-*.md` | Before any HTML work |
| `CLAUDE.md` | Before any guide or website copy |
| `GatewayGuard_ScreenContents-*.md` | Before writing any tool-facing copy |

---

## READ/WRITE WORKFLOW — HOW THE TWO CLAUDES DIVIDE WORK

Claude project knowledge is **read-only** from this chat. I can read
project files but cannot write back to them. Here is how the two
environments divide work:

| Task | Use |
|------|-----|
| Documents, planning, guides, business tasks | This chat (Claude.ai) |
| HTML builds, file edits, read/write to local folder | Claude Code terminal |
| Governing documents, standards, briefings | Claude project knowledge (reference library only) |

**The sync loop:**
1. Claude Code builds or edits files → saves to `OneDrive\GatewayGuard`
2. Bill uploads updated files to Claude project → available to this chat
3. This chat produces documents → Bill downloads → uploads to project or
   saves to `OneDrive\GatewayGuard`

**GitHub as sync layer for HTML:**
Claude Code commits HTML files to the repo → repo is the authoritative
store for website files → no need to keep HTML in Claude project at all
once they are on GitHub.

**Bottom line:** Use Claude Code for anything that touches the filesystem.
Use this chat for anything that needs reasoning, planning, or document
production. Keep the Claude project as the reference library.

---

## NEXT SESSION PRIORITIES (in order)
1. Confirm GitHub guide pages uploaded successfully
2. Confirm 17 old timestamped HTML files deleted from project
3. Project file cleanup — review and delete remaining stale files
4. Guide rewrite — bring windows_security_walkthrough_guide_v9.docx up to current truth from the 19 pages
5. Build remaining website pages: tips.html, beta.html (blocked on decisions), compatible.html (blocked)
6. ascii39 field test results review
