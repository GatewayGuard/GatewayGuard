<!-- Dated: 2026-08-09 22:58 EDT -->
<!-- Editor: Claude Code (CGDELL) -->
# GatewayGuard Session Log
- **Document Name:** GatewayGuard_SessionLog
- **Last Modified:** 2026-08-09 22:58 EDT
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
---

## Session: 2026-08-08 to 2026-08-09 [Claude Code — CGDELL]

**Two-day session. No build work. Consolidation, backup, and governance.**

### The headline

**The GitHub remote now exists** — `GatewayGuard/GatewayGuard`, private,
org-owned. Before 2026-08-08 the repository lived inside the folder it was
protecting, with no remote at all, while the tree existed in six copies at
three different commits. That was the largest unmitigated risk to the
September 1 launch and it is closed.

### Completed — infrastructure

- **GitHub remote created and populated.** 35 commits pushed.
- **Tree consolidated to one working copy.** Personal-OneDrive copy deleted;
  business copy renamed `GatewayGuide` → `GatewayGuard`. The rename had been
  made once before and reverted — it only stuck when made in the browser,
  because the cloud held the old name and the cloud wins.
- **CGDELL's Documents folder rescued from inside the project tree.** It had
  been redirected to `OneDrive\GatewayGuide\Documents`, which explained a
  folder that regenerated after four deletions, 1.2 GB of personal files in
  `Builds\Documents\`, and two OneDrive accounts deadlocking over folder
  backup. Fixed with `SHSetKnownFolderPath` — the Location tab never appeared,
  and three legacy junctions had to be removed first.
- **Folder backup turned off on SANDY and SANDY3**, both accounts, before
  CGDELL's 1.2 GB could merge onto them.
- **Recovery keys printed and copied to USB** for CGDELL and Sandy3.

### Completed — measurements that settled open questions

- **Sandy3 encryption MEASURED:** `FullyEncrypted / 100 / XtsAes128`. The last
  fleet fact resting on a guess.
- **All three machines confirmed at the same commit** with the same ascii39
  hash `75C3509473F17D6F`.
- **The 19 guide pages located** — in git history and untracked in
  `WebSite/files (6)/`. They never reached GitHub Pages.
- **CGDELL has four working BitLocker recovery keys.** All four unlock it;
  rotation is a deliberate two-pass design and pass 2 was never run.

### Completed — governance

- **`GatewayGuard_SyncPlan`** — what and why, and who authors what.
- **`GatewayGuard_SyncSetupSteps`** — the click-by-click procedure.
- **READ-FIRST briefing merged** from two rival versions and rewritten.
- **Claude Cloud reviewed all three** and returned 28 findings; 23 applied.
- **Governing-document authorship moved to Claude Code**, on the evidence that
  every dead pointer found was in a Cloud-authored file — 15 of 49 filename
  references across the tree were dead.
- **New rule: EXHAUST THE FORMS BEFORE CONCLUDING ABSENCE** (ProjectInstructions).

### Recovered — content that existed in only one place

- **CF-01 through CF-06** — 62 lines of ascii30/31 field findings, in Cloud
  and in no file here. CF-02 (per-setting approve/disapprove for all settings)
  reads like ascii40 scope.
- **`GatewayGuard_NamingStandard`** — the source of truth for all 19 setting
  names, across ~45 files. Nothing defined them before.
- **`GatewayGuard_SessionLog`** — this file. Its own rule had never been
  followable by Claude Code because the file had never reached the tree.
- **`FutureProjects`** (FP-01–FP-21), **`ProjectFiles_DeleteKeep`**, the five
  Guide print editions, and eight other documents.

### Errors made and corrected

- Read the **wrong tree** for the first 20 minutes of 2026-08-08 — a stale
  copy, three commits behind.
- Recorded `TestHistory-ascii39-2026-08-02-0914.md` as **"never existed."** It
  exists in project knowledge; it had never reached the tree.
- Declared **Python unavailable** after `python3` failed. `python` and `py`
  both work.
- Twice dismissed a misplaced folder as "sync debris" without opening it. One
  was `ProjectDocs` — every governing document — moved by a stray drag and
  gone for over an hour.
- Told Bill the connector scope three different ways across three documents.

All five are the same shape and produced the new rule above.

### Bill's decisions this session

- **Gumroad for all sales** — closes the question gating refund terms and
  sales tax work.
- **Website-copy rule moved to `WebSite\Rules\`** rather than adding `.claude`
  to the connector scope.
- **404.html** — live site has one; no action.
- Keep all four BitLocker recovery keys.

### Open — carried into the next session

1. **ascii39 field run on SANDY.** Blocks everything downstream. Right-click
   the project folder → "Always keep on this device" first: 307 of 1,110 files
   are cloud placeholders and SANDY has no internet without the USB adapter.
2. **Connect Claude Cloud to GitHub** — follow `GatewayGuard_SyncSetupSteps-*.md`.
3. **Rebuild the assert-guarded Python wrapper.** Zero `.py` files in the tree
   or in git history. Required before ascii40. Python 3.12.10 is installed.
4. **Move Bill's 18 personal documents out of `Attachments\`** — his resume,
   the Cuban letters and the Sunset set exist nowhere else.
5. **Upload the 19 guide pages.** `gatewayguard.co` still shows UNDER
   CONSTRUCTION from 2026-07-21.
6. **`Run-DocCheck.bat`** — the document gate. Would have caught the scope
   disagreement and the repeated git counts.
7. **Marketing-Notes open-source violation** — three occurrences, never fixed.


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
<!-- Editor: Claude Code (CGDELL) -->   (this chat produced or last edited it)
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

