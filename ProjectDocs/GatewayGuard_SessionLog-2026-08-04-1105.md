<!-- Dated: 2026-08-04 11:05 EDT -->
<!-- Editor: Claude.ai -->
# GatewayGuard Session Log
- **Document Name:** GatewayGuard_SessionLog
- **Last Modified:** 2026-08-04 11:05 EDT
- **Status:** Append-only running log — newest session at top
- **Purpose:** Continuous record of all sessions (Claude.ai and Claude
  Code) so any Claude instance can resume with full context.
  Updated after every file produced or decision made.
  Downloaded by Bill at session end and uploaded to project immediately.

---

## HOW TO USE THIS FILE

**Claude.ai:** Read this file at every session start. Update it after
every file produced, rule decided, or task completed. Tell Bill to
download and upload it at session end.

**Claude Code:** Read this file at every session start. Update it after
every file produced or build completed. Commit updated file to
OneDrive\GatewayGuard at session end.

**Bill:** Download this file at the end of every session.
Upload it to the Claude project immediately after downloading.
This is the shared memory between all Claude instances.

---

## Session: 2026-08-04 [Claude.ai]

### Completed
- Built `download-2026-08-04-0932.html` — download page, all rules applied
- Proposed editor tag system (Claude.ai / Claude Code / Bill in headers)
- Answered why two-Claude workflow exists and how to manage it
- Produced structured plan for session handoff (see WorkflowGuide below)
- Produced `GatewayGuard_SessionLog-2026-08-04-1105.md` (this file)
- Updating `GatewayGuard_ProjectInstructions` with new rules (in progress)

### Pending
- Rewrite CLAUDE.md with updated header, editor tags, corrections
- Rewrite WebsiteStandards with updated sitemap and new rules
- Rewrite CodingStandards with new rules
- Delete `GatewayGuard_CodingStandards-2026-07-26-0619.md` from project
- Delete superseded HTML files from project
- Guide rewrite (v9 → current)
- Upload all 19 final HTML pages to GitHub guide/ folder
- ascii39 field test results review

### Files produced this session (2026-08-04)
- `download-2026-08-04-0932.html` — download page

### Files produced previous session (2026-08-02)
- `GatewayGuard_All19_Final-2026-08-02-1820.zip` — all 19 guide pages
- `GatewayGuard_BankLetterRequest-2026-08-02-1820.docx` — bank letter
- `GatewayGuard_TomorrowActionList-2026-08-02-1820.docx` — action list
- `GatewayGuard_ProjectInstructions-2026-08-02-1820.md` — updated rules
- `_READ-FIRST-Briefing-2026-08-02-1820.md` — session briefing

### Rules decided this session
- EDITOR TAG SYSTEM: every file header identifies last editor
  (Claude.ai / Claude Code / Bill)
- SESSION SUMMARY FILE: SessionLog.md maintained by both Claudes
- SESSION HANDOFF PROTOCOL: structured plan for new chat startup
- Claude.ai must update CLAUDE.md when rules change and tell Bill
  to download it for Claude Code

### Business status (as of 2026-08-04)
- Maine Community Bank: account opening attempt Monday 8/3 — status unknown
- SAM.gov: pending bank account info
- DigiCert/SignMyCode: pending D&B or bank letter
- LegalZoom EULA review: rescheduled to 8/4 Tuesday noon
- Google Business: free brand profile setup pending
- GitHub guide pages: zip ready, not yet uploaded

---

## Session: 2026-08-02 [Claude.ai]

### Completed
- Built all 19 guide setting pages — all rules applied, zipped
- Fixed "whether", "switch", Checkup naming across all 19 pages
- Added PL-1, PL-2, PL-3, CHECKUP NAME RULE, CONFIRM BEFORE ACTING,
  SESSION LENGTH WARNING to ProjectInstructions
- Deleted 17 old timestamped HTML files from project (marked — Bill
  must confirm deletion in Claude UI)
- Built bank letter request and Monday action list
- Updated READ-FIRST briefing

---

## WORKFLOW GUIDE (permanent reference)

### WHEN TO START A NEW CHAT (Claude.ai)
Start a new chat when ANY of these are true:
- You uploaded new files to the project during the current chat
- Claude Code produced files you want Claude.ai to see
- This chat has produced more than 10 files or major deliverables
- A rule was forgotten or violated in this session
- You are starting a new major task
- Claude expressed uncertainty about something it should know

### HOW TO HAND OFF

**Before closing a Claude.ai chat:**
1. Download all files produced this session
2. Download updated SessionLog and READ-FIRST-Briefing
3. Upload all new files to Claude project
4. Delete superseded versions from project
5. Note what is pending

**Before closing Claude Code:**
1. Save all edited files to OneDrive\GatewayGuard
2. Note current build number and what changed
3. Update SessionLog.md and save to OneDrive\GatewayGuard

### WHAT TO SAY AT THE START OF A NEW CLAUDE.AI CHAT

```
New session. Please:
1. Read _READ-FIRST-Briefing from project files and confirm status.
2. Read GatewayGuard_ProjectInstructions from project files.
3. Read GatewayGuard_SessionLog if present.
4. Confirm the three governing docs and their dates:
   CLAUDE.md, WebsiteStandards, CodingStandards.
5. Ask me for today's date and time.
6. Ask which machine I am working on.
Current date: [fill in]
Current time: [fill in ET]
Machine: [CGDELL | SANDY | Sandy3]
Task: [what you want to do]
```

### WHAT TO SAY AT THE START OF A NEW CLAUDE CODE SESSION

```
New session. Current build: ascii[N].
Read CLAUDE.md and GatewayGuard_SessionLog.md.
Confirm current status before doing anything.
Task: [what you want to do]
```

### EDITOR TAG FORMAT

Add to every file header immediately after the Dated line:
```
<!-- Editor: Claude.ai -->   (this chat produced or last edited it)
<!-- Editor: Claude Code -->  (Claude Code terminal produced or last edited it)
<!-- Editor: Bill -->         (manually edited by Bill)
```

Add to Change History entries:
```
2026-08-04 11:05: [Claude.ai] Description of change.
2026-08-02 07:41: [Claude Code] Description of change.
```

### END OF SESSION CHECKLIST (run before closing any chat)

**Claude.ai must:**
- [ ] Update SessionLog with everything completed this session
- [ ] Update READ-FIRST-Briefing with current status
- [ ] Revise any governing doc (ProjectInstructions, WebsiteStandards,
      CodingStandards, CLAUDE.md) that had rule changes this session
- [ ] Tell Bill to download ALL files produced or changed this session
- [ ] Tell Bill to upload ALL new files to project
- [ ] Tell Bill to delete all superseded versions from project
- [ ] Remind Bill which machine-specific files go to OneDrive\GatewayGuard

**Claude Code must:**
- [ ] Update SessionLog.md and save to OneDrive\GatewayGuard
- [ ] Commit all changed files
- [ ] Update CLAUDE.md if any rules changed
- [ ] Note current build number in SessionLog

