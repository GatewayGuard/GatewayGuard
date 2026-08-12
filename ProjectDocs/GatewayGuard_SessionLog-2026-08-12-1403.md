<!-- Dated: 2026-08-12 14:03 EDT -->
<!-- Editor: Claude Code (CGDELL) -->
# GatewayGuard Session Log
- **Document Name:** GatewayGuard_SessionLog
- **Last Modified:** 2026-08-12 14:03 EDT
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

## Session: 2026-08-11 22:00 to 2026-08-12 14:03 [Claude Code -- CGDELL]

**No build work. The 19 guide pages resolved to a single deploy copy, one
rule withdrawn, the Cloud starter file renamed, and the approval habit
replaced with a written commit policy.**

### The headline

**`WebSite\html\` now exists and is the one deploy copy of the 19 guide
pages.** Five copies of that set were on disk in three generations, all
stamped 2026-08-02, and which was current had never been established --
open item 6 in the 2026-08-11 briefing. It is established now.

### Which of the five sets won, and why

| Set | Location | Gen | Tracked |
|---|---|---|---|
| A | `WebSite\files (6)\html` | 1 | no |
| B | `Index-Builds\GuidePages-Corrected-2026-08-02-1201` | 1 (identical to A) | yes |
| E | `WebSite/html/` at commit `81a2f00` | 1 (identical to A) | deleted in `afc748c` |
| C | `Index-Builds\GatewayGuard_All19_Final-2026-08-02` | 2 | yes |
| **D** | `Index-Builds\GatewayGuard_All19_Final-2026-08-02-1820` | **3 -- newest** | yes |

**measured**, across the 19 pages: A/B = 0 "whether", 0 "whereas", 5
"switch"-as-verb, **69** "GatewayGuard Checkup"; C = 0/0/4/**19**; D =
0/0/3/**19**. The CHECKUP NAME RULE allows the full name exactly once per
page, so 19 is compliant and 69 is a breach in every one of them. D also
carries `<h2>What Checkup found and did</h2>` where A carries
`<h2>What GatewayGuard Checkup found and did</h2>`, and D is the artifact
the 2026-08-02 session log names as delivered. **Filename stamp, modified
time and content compliance all agree: D is current.**

The comparison used git's own content-addressed blob SHA-1s rather than
extracting files and hashing them. A first attempt (`Extract-GitHtml.ps1`)
would have piped `git show` through `Out-String` and `Set-Content`, which
re-encodes bytes and line endings -- every hash would have differed for the
wrong reason and produced a confident "all five are different." Caught
before it ran. The replacement carries a V-2 control row that must match
before any result is believed; it printed `CONTROL PASS`, `core.autocrlf =
false`.

**Scope gaps closed:** `Attachments\` holds 157 `.html`, 76 name-matching --
38 byte-identical to set A, 38 mirroring set C, nothing novel. The business
OneDrive root outside the project holds 18 `.html`, none name-matching.

### Completed

- **`WebSite\html\` built from set D**, 19 files, dates stripped, each
  SHA256-verified identical to its source before any edit. The tracked
  `-1820` build folder was left untouched -- it is the delivered artifact of
  record.
- **All five "switch" occurrences in `wake-on-lan.html` are now "turn" /
  "turning"**, on Bill's instruction. No page in the set now contains
  "switch" in body text. The six occurrences remaining in that file are all
  inside its change-history comment, quoting the old wording.
- **`Check-Claude-Cloud.txt` renamed to `Start-Claude-Cloud.txt`** via
  `git mv`, to pair with `Start-CC.txt`. Four live pointers updated, in
  `Start-CC.txt` (3) and `Check-Connector.txt` (1).
- **`.gitignore` extended** with the never-publish list -- see the commit
  policy below.

### Rule changed: the powering-on exemption is withdrawn (CLAUDE.md)

The verb rule formerly carried a second exemption alongside the noun:
*"Powering a machine on -- wake-on-lan's 'switch on hundreds of computers
overnight' is a different verb entirely. Leave it."* Bill removed it on
2026-08-12. **"switch" is now never the verb, unconditionally.** The noun --
the toggle control on screen -- survives.

Two reasons it went, recorded in CLAUDE.md itself:

1. **The reader cannot tell which sense they are reading.** A senior meets
   "switch your PC on" and "turn Memory integrity on" on the same site with
   no way to know one is exempt.
2. **An exemption written as a quoted sentence protects only that
   sentence.** It named one occurrence and left four others on the same
   page unaddressed and unflagged -- which is exactly how the page came to
   hold five, of which a narrow verb regex found three.

**The undercount is worth keeping.** The report said "3 switch hits" because
that was what the regex `\bswitch(es|ed|ing)?\s+(it|them|this|that|the\s+\w+\s+)?(on|off)\b`
matched. The plain word count was 5. A regex answer was reported as a word
answer. Related: a "0 remaining" check printed empty because
`.{60}\bswitch\w*\b.{60}` needs 60 characters on both sides and `.` does not
cross newlines -- an absence produced by the matcher, not the file. Both are
V-2: **test the matcher on a control that must match.**

### Why Claude Cloud could not find the 2026-08-11 documents

**Not a missing commit.** All four -- the briefing, session log, project
instructions and `CLAUDE.md` -- are tracked and present on `origin/main`;
`git rev-list --left-right --count origin/main...main` returned `0 0`.

**We gave Cloud an instruction it cannot execute.** `Start-Claude-Cloud.txt`
says to glob `_READ-FIRST-Briefing-*.md` and take the newest by filename
date. **Cloud cannot list a directory or sort one.** With five briefings in
`ProjectDocs/` it searches by relevance and returns whichever looks most
relevant -- a coin toss it reports as success. The anti-stale-filename rule
is right for Claude Code and actively harmful for Cloud, and that asymmetry
had not been noticed.

A second candidate is still open: the A6 connector proof passed
2026-08-11 at **14:45**, and those documents were committed at **16:17** --
after it. The connector index may predate them. **Unresolved, and settled by
one question:** ask Cloud to quote *"SANDY converted to a local account named
panther."* That sentence exists only in the 16:16 documents. Quoting it
clears the connector and convicts the glob; failing to clears the glob and
convicts the connector.

**Proposed fix, not yet built:** `ProjectDocs\CURRENT.md` -- one fixed name
Cloud can be told, holding the current document filenames, **generated by
`Tool\Update-Current.ps1` at session end and never typed**, refusing to
write if a glob returns zero hits. The starter files keep the fixed pointer
and carry no volatile state, so nothing undated can go stale unnoticed.

### Rule added: the commit policy, replacing per-commit approval

Bill, 2026-08-12: *"All this tracking, committing and pushing. Can it be
done automatically by you -- why do I need to approve it? Most of the time I
don't know what I am approving."*

**He is right, and the approvals were protecting the wrong thing.** The only
real reason for asking was that the tree holds ~60 untracked items including
banking and legal documents, and this repository pushes to GitHub. That is a
`.gitignore` problem being solved by asking a human to audit a file list at
the end of a long session -- the worst available reviewer for that job.

**Now in `.gitignore`:** `Certificates/MaineCommunityBank/`,
`Certificates/Banking instructions.odt`, `Attachments/`, `Videos/`.
**Narrow on purpose** -- `Certificates\` and `LegalZoom\` already hold 18 and
5 tracked files, so neither is ignored wholesale.

**Standing policy from this session on:**

- Claude Code commits and pushes **without asking**, at session end and at
  natural checkpoints.
- Every commit is **path-scoped to files touched this session**. Never
  `git add -A`, never `git add .` -- the ignore list is the backstop, not
  the mechanism.
- **Still asked, every time:** deleting or renaming tracked files, force
  push, history rewrite, and any new top-level folder that cannot be
  classified as product content.

### Bill was holding the ascii39 field results back

Claude surfaced `Test_Results\Ascii39-Test-Results-2026-08-11-2237.txt`
(49 numbered findings), the `.docx`, `Notes\ASCii39_run_check_notes.txt` and
seven SANDY run logs while answering a narrow question about what Phase 3
is. **Bill was holding those for a dedicated session.** They remain
untracked and uncommitted by intent. **Do not fold them into TestHistory
until Bill opens that session.**

Two facts from it are worth carrying anyway, because they change what is
true: **Phase 3 has run** -- so the UNRUN BUILD RULE no longer blocks
ascii40 -- and the findings are not cosmetic. Right-click crashed the
program twice, look-back broke repeatedly, and item 13 confirms FT-167 on
screen: *"only list one hard drive for Sandy when it has two."*

**Name collision worth fixing:** "Phase 3" means SANDY run 1 in
`GatewayGuard_FieldTestPlan-ascii39-2026-08-02-0919.md` and "move the tree"
in `GatewayGuard_M365MigrationPlan-2026-08-06-1727.md`. The 2026-08-11
briefing line 625 says "rewrite Phase 3" and means the migration plan.

### Left open

1. **The Cloud connector question** -- ask for the panther line before
   building `CURRENT.md`.
2. **Two dead pointers to the old filename**, at `SyncPlan-2026-08-10-1119.md:303`
   and `SyncSetupSteps-2026-08-11-1445.md:752`. Under the DOCUMENT REVISION
   RULE these need complete new dated versions of both, so they were left to
   ride with the revision that records the connector outcome rather than
   spawning two lineages today. **Deliberately not touched:**
   `ProjectInstructions-2026-08-11-1616.md:562`, which quotes the literal
   command that earned rule V-1, and the two change-history entries at
   `SyncPlan:9` and `SyncSetupSteps:72`.
3. **HTML DELIVERY GATE H-1 to H-4 has not been run** on the new
   `WebSite\html\`. The files are byte-identical to a build that passed, but
   `wake-on-lan.html` has had five text edits and a comment block inserted
   since. Not delivered until the gates run.
4. **The ascii39 field results**, above -- Bill's session to open.
5. **`Attachments\` is back**, 803 files with its own `.git` nested in the
   working tree. It was deleted on 2026-08-11 and has returned, presumably
   via OneDrive. Now ignored by git; still a live trap for a session started
   in the wrong folder.

### Files produced

- `WebSite\html\` -- 19 pages (new)
- `ProjectDocs\GatewayGuard_SessionLog-2026-08-12-1403.md` (this file)
- `Start-Claude-Cloud.txt` (renamed from `Check-Claude-Cloud.txt`)
- `CLAUDE.md`, `.gitignore`, `Start-CC.txt`, `Check-Connector.txt` (edited)

---

## Session: 2026-08-10 to 2026-08-11 [Claude Code -- CGDELL]

**Fourteen hours across two days. No build work. The Cloud connector, a
governance clean-up, and six of Claude Code's own errors turned into rules.**

### The headline

**Claude Cloud now reads the repository.** A6 passed on revised targets: Cloud
quoted the root `CLAUDE.md` rule-move line, `Tool/Run-ExternalCommandCheck.bat`,
and both header lines of `WebSite/Rules/website-copy.md`, all matching CGDELL
character for character. `ProjectDocs/` proved by twelve prefixed files. **Both
Claudes now read the same commit** -- the thing SyncPlan was written for.

### Completed

- **Connector live**, scoped to `ProjectDocs`, `Tool`, `WebSite/Rules`,
  `CLAUDE.md`. Manual uploads deleted; the Cloud-only files harvested first,
  signatures checked, and committed.
- **`Attachments\` deleted** -- 825 files, including the nested stale tree
  copy with its own `.git`. 29 medical documents were hash-verified into
  `C:\Users\willi\OneDrive\Personal\` first, and 21 documents that existed
  nowhere else were rescued and verified before the delete ran.
- **Repo trimmed 10.8 MB to 4.42 MB** so the connector would fit: saved-webpage
  junk, 17 PDFs, superseded builds ascii32-38, three `.pptx`.
- **ProjectInstructions rewritten twice** -- THE CLOCK scoped by capability,
  the four-gate HTML DELIVERY GATE with H-4, PL-4 no-unverified-superlatives,
  Sandy3's measured encryption, UNIVERSAL WORKING RULES, VERIFICATION RULES
  V-1 to V-6, and RETIRING OLD FILES.
- **Profile instructions trimmed** and filed for the first time, at
  `ProjectDocs\Profile_Instructions_Universal-*.md`.
- **`SyncSetupSteps` fixed three times** -- the 0b-4 ordering gate, A6 widened
  to four targets, then A6 target 1 rewritten after it could neither fail nor
  verify.
- **`Check-Connector.txt`** added at the root: the A6 test as a file with copy
  markers, because three chat pastes were mangled or over-selected.

### Errors made, and what came of them

Six, all verification failures rather than knowledge failures. Three broke
EXHAUST THE FORMS, which had no mechanical step. They are now **V-1 to V-6** in
ProjectInstructions, each citing the error that earned it: a negative drawn from
one query form; a name matcher never tested on a control; "not in the tree" used
as the test for a cumulative document; a PowerShell wildcard that matched every
line and reported 165 untracked files against a real 18; a measurement restated
hours later as current; and a guard watching a substring that new prose
legitimately quoted.

**Bill caught three of them himself** -- the hyphen-stripping matcher, the
superseded-file archaeology, and the deletion-before-verification ordering.

### Recovered

- **The 0b-4 ordering decision**, made 2026-08-09 18:28 and never filed. Found
  by searching the session transcripts under
  `C:\Users\willi\.claude\projects\`. **Those transcripts are searchable and
  this project did not know it.**
- **The ProjectNotes UPDATE rule**, uncarried since 2026-07-03 in a file under
  the retired `GatewayGuide` spelling. A renamed document is invisible to the
  newest-wins rule -- now recorded as ORPHAN LINEAGE.
- **`Notes\Older Files\`**, six files, found at the business OneDrive root
  after a stray drag. Hash-verified identical to git.

### Interface findings that cost hours

- **The Project knowledge panel is unreachable at 150% text scaling.** An
  artifact in the chat makes it reachable -- Bill found that.
- **Deleting the manual uploads cleared the connector content**, and the
  folders had to be re-added.
- **The capacity meter is unreliable** -- it read 1% while the connector was
  fully loaded and answering correctly.
- **Cloud's `/mnt/project/` mount is not the connector.**

All four are now PART F of `SyncSetupSteps`.

### The ascii39 field run started, 15:15

- **Phase 2 done.** SANDY's unencrypted profile captured and committed --
  `C:` 67.7 GB used of 237.3 GB, `D:` 78.9 GB of 931.5 GB, both
  **FullyDecrypted**, Modern Standby, Edition Core. One-shot measurement;
  unrecoverable once it encrypts.
- **FT-167 confirmed in the field** -- the second fixed drive is real and in
  the clear. Checkup reads only `C:`.
- **SANDY's Windows account was Microsoft until 2026-08-11**, for a week or
  more through multiple reboots, and Device Encryption never engaged.
  Converted to a local account named `panther` immediately before Phase 3.
  **This contradicts the fleet warning** and is recorded in the briefing and
  the ENCRYPTION STATE MATRIX rather than left in chat.
- **Phase 3 starting** -- the 45-minute local-account run. Not yet reported.
- A blocker was caught on the way: `Builds\Run-GatewayGuard.bat` named a
  `.ps1` filename that has never existed and predates the missing-file check,
  so it would have blinked shut with no message. Retired. Briefing section 14
  had flagged it for verification weeks ago and nobody had.

### Bill's decisions

- Org display name `GatewayGuard LLC`; third-party OAuth restrictions removed
- Connector scope narrowed to `WebSite/Rules` rather than all of `WebSite`
- Stop chasing superseded files

### Open

1. **ascii39 field run on SANDY.** Still blocks everything downstream.
2. `GatewayGuard_AttorneyCallQuestions-2026-08-04-0120.docx` -- the last file
   that exists only in Cloud.
3. `Run-DocCheck.bat` -- the document gate, still unbuilt.
4. Rebuild the assert-guarded Python wrapper and **commit it this time**.
5. Marketing-Notes open-source violation -- three occurrences, still unfixed.


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

