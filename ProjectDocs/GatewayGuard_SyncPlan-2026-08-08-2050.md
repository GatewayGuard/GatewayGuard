<!-- Dated: 2026-08-08 20:50 ET -->
# GatewayGuard -- Sync Plan: Claude Code, Claude Cloud, and Bill
- **Document Name:** GatewayGuard_SyncPlan
- **Last Modified:** 2026-08-08 20:50 ET
- **Last Editor:** Claude Code (CGDELL)
- **Status:** Cumulative Master Document
- **Change History Log:**
  - 2026-08-08 20:50: **Section 2 corrected before first commit.** The draft
    claimed "There is now ONE tree." That was false within the hour: a stale
    copy with its own `.git` sits nested inside the working tree at
    `Attachments\GatewayGuide\`, and four more copies exist on C: and D:.
    Section 2 now lists every copy with its file count and states which one is
    authoritative. Added the SHAPE-CHANGE subsection, earned the same evening
    when `ProjectDocs\` (every governing document) and `WebSite\` (153 files)
    were each moved by a stray File Explorer drag -- `ProjectDocs` went
    unnoticed for over an hour, and both were dismissed as "sync debris" twice
    before being opened. `git status` had reported it immediately. Figures
    updated to 23 commits / 704 tracked files / 219 MB.
  - 2026-08-08 17:49: Created. Establishes the git repository as the single
    source of truth, assigns authorship of governing documents to Claude Code,
    scopes the Claude Cloud GitHub connector, and defines the drift controls
    (stamp line, weekly audit, document gate). Written after the 2026-08-08
    consolidation, which removed the conditions that made a plan impossible
    before it: the tree existed in six copies at three different commits, and
    no git remote existed at all.

---

## 1. WHY THIS DOCUMENT EXISTS

Claude Code and Claude Cloud must work from the same picture of the project.
Until 2026-08-08 they could not, for reasons that had nothing to do with
either of them:

- **The tree existed in six copies**, three at commit 7e2d132 and three at
  4160d05. On 2026-08-08 a session read the stale copy for its first twenty
  minutes without knowing.
- **No git remote existed.** The repository lived inside the folder it was
  protecting.
- **Governing documents named files by exact filename**, and the naming
  convention changes filenames on every edit, so pointers died on contact.

All three are now fixed. This plan describes how to keep them fixed.

---

## 2. THE SINGLE SOURCE OF TRUTH

**The git repository is authoritative. Not a folder, not a copy, not a chat.**

| | |
|---|---|
| Remote | `GatewayGuard/GatewayGuard` -- **private**, owned by the `GatewayGuard` org |
| Working tree | `C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\` |
| State at writing | 23 commits, 704 tracked files, 219 MB working files (**measured** 2026-08-08 20:xx) |

### There is ONE WORKING tree. There are still several stale copies.

The personal-OneDrive copy was deleted and the business copy renamed
`GatewayGuide` -> `GatewayGuard`, which removed the copy that was actively
drifting. **That is not the same as there being one copy.** Measured
2026-08-08, all of these still exist:

| Path | Files | What it is |
|---|---|---|
| `...\OneDrive - GatewayGuard LLC\GatewayGuard\` | 704 tracked | **the working tree -- the only one to edit** |
| `C:\GG-Backup\GatewayGuide` | 652 | local fallback, made 2026-08-08 |
| `C:\GatewaayGuardBackup\GatewayGuide` | 557 | older backup (note the typo in the folder name) |
| `C:\GatewayGuard-Backup-2026-08-06` | 560 | older backup |
| `D:\GatewayGuide` | ~878 | second-drive copy; its `.git` carries a OneDrive conflict artifact |
| `...\GatewayGuard\Attachments\GatewayGuide` | 586 | **a stale copy NESTED INSIDE the working tree** |

**An earlier draft of this section said "There is now ONE tree." That was
wrong within the hour**, and the last row is why: a stale copy with its own
`.git` is sitting inside the live tree. It is untracked, so nothing has been
committed from it, but a single `git add .` would embed a repository inside a
repository.

**The rule that actually holds:** edit only the working tree. Every other copy
is evidence or fallback, never a source. When two copies disagree, the remote
decides -- not the newer file, not the bigger folder.

### The working tree's SHAPE can change without anyone noticing

On 2026-08-08, two folders were moved by stray drag-and-drop in File Explorer:

- `ProjectDocs\` -- **every governing document** -- ended up inside
  `Recovery Keys\`
- `WebSite\` -- 153 files -- ended up inside `Tool\`

Windows moves a folder on a same-drive drag with **no confirmation prompt and
no undo notification**. `ProjectDocs` was gone for over an hour before anyone
noticed, and it was noticed only because someone went looking for one file
inside it.

Both were spotted as odd-looking folders and dismissed twice as "sync debris"
before either was opened. **A folder in a place that makes no sense is worth
ten seconds of looking, not a guess about what it is.**

**What made this a nuisance rather than a disaster:** `git status` reported
126 files deleted from `ProjectDocs/` the moment it happened -- the shape
change was visible in one command even though nothing on screen looked wrong.
And every tracked file was already on GitHub, so the worst case was re-cloning.

**Therefore: run `git status` at the start of any session, before trusting the
folder layout.** A deletion count that jumped since last time means something
moved, not that work was lost.

**Anything that disagrees with the remote is wrong**, including this document.

---

## 3. WHO DOES WHAT

This is the heart of the plan. Each party does what it can actually verify.

### 3a. Claude Code (terminal) -- AUTHORS ALL GOVERNING DOCUMENTS

**Governing documents means:** ProjectInstructions, CodingStandards,
DefectPreventionPlaybook, WebsiteStandards, TestHistory, ScreenContents,
the READ-FIRST briefing, CLAUDE.md, and this plan.

Claude Code owns them because it is the only party that can **check a claim
before writing it down**:

| Capability | Claude Code | Claude Cloud |
|---|---|---|
| Confirm a filename exists | yes -- one glob | **no** |
| Measure line counts, hashes, git state | yes | **no** |
| Run the gates and checkers | yes | **no** |
| Read live machine state | yes | **no** |
| Write to the tree, commit, push | yes | **no** |

**What earned this rule (measured 2026-08-08):** every dead pointer found in
the governing documents was in a file whose `Last Editor:` line reads
Claude.ai. The 2026-08-06 briefing named `CodingStandards-2026-08-02-0741.md`
and `TestHistory-ascii39-2026-08-02-0914.md`; the first had been renamed and
the second never existed. Cloud could not have known -- it has no way to look.
A scan of every `.md` in the tree found **15 of 49 exact filename references
dead**. (Not all 15 are defects -- Change History entries legitimately name
retired files -- but the live pointers among them were.)

Claude Code also:
- Runs the pre-build gates and reports results in the same response
- Commits and pushes at the end of any session producing work worth keeping
- Retires the superseded version in the same commit as the replacement
- Runs `Get-Date` rather than asking Bill for the time

### 3b. Claude Cloud -- BUSINESS WORK AND REVIEW

Cloud is not a lesser tool; it is a differently-blind one. It keeps everything
that needs no verification against the tree:

- Business, legal and licensing analysis -- LegalZoom, EULA, trademark
- Marketing copy, FAQ, presentations, emails
- CPM scheduling and planning
- Market research
- **Reviewing documents Claude Code produced** -- a second reader with
  different blind spots is worth having, and this is where Cloud is strongest

**Cloud must not:**
- Author or revise a governing document
- Write an exact filename into anything that will be filed
- State machine state, build numbers, line counts, or test results from memory

If Cloud needs one of those facts, it asks Claude Code to measure it.

### 3c. Bill -- THE THINGS ONLY A HUMAN CAN DO

- **Field tests.** No Claude can run ascii39 on SANDY.
- **Machine settings** -- OneDrive, Windows, folder backup, hardware
- **The GitHub sync click** in Cloud's project knowledge panel after a push
- **Scope decisions and approval** for anything destructive or irreversible
- **Business tasks requiring identity** -- bank, SAM.gov, D&B, DigiCert, LegalZoom
- **Deciding when a rule is wrong.** These documents record decisions; they do
  not make them.

---

## 4. THE DOCUMENT LAYER -- GITHUB CONNECTOR

### 4a. Setup (one time)

1. In the Claude Cloud project, **Project Knowledge** -> **+** -> **GitHub**
2. Paste or select `GatewayGuard/GatewayGuard`
3. It is a **private repo in an org**. Authorize the Claude GitHub App **for
   the `GatewayGuard` organization**, not just the personal account. If the
   org ever requires SSO, each user authorizes separately.
4. Scope the connector to **exactly three things**:
   - `ProjectDocs/`
   - `Tool/`
   - `CLAUDE.md`

**Scope by folder, not by individual file**, so new documents appear on the
next sync instead of silently not existing.

**Do NOT connect the repo root.** `Certificates/` holds a driver's licence,
licence images, an EIN, and a file named like stored credentials. `Heath/`
holds medical documents. Neither belongs in project knowledge.

### 4b. Verify the connection actually works

There is a known failure where a repo shows **Connected** while its files are
not reachable in conversation. **Do not trust the badge.** After connecting,
ask Cloud to quote a specific line from a specific file. If it cannot, it is
not connected.

### 4c. The sync is MANUAL. Always.

There is no webhook and no automatic refresh -- it is an open feature request,
not a feature. What you have is not a mirror; it is **a mirror as of the last
time someone clicked Sync**.

**Therefore the staleness must be visible, never assumed away.** That is what
section 6 is for.

---

## 5. CLAUDE.md AND PROJECT INSTRUCTIONS

Claude Code reads `CLAUDE.md`. Claude Cloud reads its Project Instructions
text box. These are two texts with no diff, no timestamps, and no alarm when
they diverge.

**The fix is to shrink what must be copied, not to copy it more carefully.**

### 5a. Project Instructions holds a POINTER, not a copy

Cloud's Project Instructions should contain the short block already proven in
`START-HERE.txt` -- read the newest briefing by the date in the filename, read
CLAUDE.md, then report what is stale -- **not** a transcription of CLAUDE.md's
386 lines.

That block changes almost never. The volatile detail arrives through the
GitHub connector, where it is versioned and dated.

### 5b. Never transcribe a long document between the two

A 386-line manual copy has no mechanism to detect that it has drifted. Any
rule that lives in only one of the two will be silently absent from the other.

---

## 6. DRIFT CONTROLS

### 6a. The stamp line

The first line of `CLAUDE.md` and of the current briefing carries a stamp:
the date-time plus a short hash of the file's own content.

Drift then becomes one question: **"What stamp do you see?"** Compare to the
local file. Different stamp means the two have diverged, and it costs five
seconds instead of never being noticed.

Claude Code generates and updates the stamp mechanically in the same edit as
any change, so it cannot be forgotten.

### 6b. The audit -- weekly, or more often after any problem

1. Ask Cloud to list the files it can see in project knowledge
2. Compare against `git ls-files ProjectDocs/ Tool/ CLAUDE.md`
3. Compare stamp lines
4. Any mismatch: push, then click Sync in Cloud, then re-check

Run it at the start of any major milestone as well as weekly. Increase the
frequency after any incident -- the schedule is a floor, not a ceiling.

### 6c. The document gate -- `Run-DocCheck.bat`

**This project has 24 mechanical gates for code and none for documents, and
documents are where every defect on 2026-08-08 came from.** Its own playbook
says it: *a gate with no check is a wish.*

The checker should verify:
- Every timestamped filename referenced in a **pointer context** exists
- Every document's internal `Dated:` matches its filename
- No two documents state the same machine fact
- Only one copy of each document type is on disk
- The stamp line matches the file's actual content hash

**Rollout follows the same ratchet as gates 12b and 24:** report only at
first, baseline the known exceptions, tighten as the list shrinks. Promote it
into the existing `.claude/settings.local.json` PostToolUse hook -- which is
tracked and travels with the repo -- once its false-positive rate is zero.

**Not a git pre-commit hook.** `git ls-files` returns zero files under
`.git/`, and `core.hooksPath` is unset (**measured** 2026-08-08), so a git
hook does not clone, does not reach SANDY, and would not have survived the
folder rename. That is the same failure shape as the absolute-path hook the
Phase 4 grep caught.

---

## 7. TWO RULES THAT PREVENT MOST DRIFT

### 7a. Never write an exact timestamped filename into a pointer

Use the glob and take the newest **by the date in the filename**, never by the
file's modified date -- OneDrive sync rewrites modified dates.

**Measured 2026-08-07:** three copies of the Playbook existed. Sorting by
modified date returned a file 13 days stale; the filename written out in the
briefing returned one 1 day stale; only sorting by the date in the filename
returned the current one.

### 7b. State every fact exactly once; everywhere else, point

A fact stated once can be wrong. A fact stated twice can be **inconsistent**,
which is worse, because then nobody knows which to believe.

**What earned this:** CGDELL's encryption state was corrected in
ProjectInstructions at 17:27 on 2026-08-06. CodingStandards was edited at
17:00 the same day and kept the stale version, which then outlived its own
correction by 19 hours and produced a false "your machine encrypted itself"
warning. CodingStandards now points at the ENCRYPTION STATE MATRIX instead of
restating it.

---

## 8. THE ONE STEP THAT CANNOT BE AUTOMATED

**Cloud cannot write to the repository.** Any document Cloud produces must be
downloaded by Bill, saved into the tree, committed, and pushed by Claude Code.

Under section 3 this should now be rare -- Cloud no longer authors governing
documents. But it still applies to anything Cloud produces that gets filed,
and it is the step most likely to be skipped. When it is skipped, the document
exists only in a chat, and the next session cannot see it.

**Rule:** if a decision exists only in a chat and not in a file, say so
explicitly -- *"this is in chat only, not yet filed in [filename]."*

---

## 9. THE STANDING LOOP

1. **Edit locally** -- Claude Code, in the one tree
2. **Commit and push** -- at the end of any session with work worth keeping
3. **Click Sync** in Cloud's project knowledge panel -- Bill
4. **Ask Cloud what stamp it sees** when it matters

A remote that is 21 commits stale is a recovery point for a version you no
longer have. The push is not optional.

---

## 10. WHAT TO WATCH FOR

| Symptom | What it means |
|---|---|
| Cloud quotes a rule Claude Code cannot find | Cloud is reading stale project knowledge -- push, sync, re-check |
| Cloud names a file that does not exist | A governing document was authored by Cloud, against section 3b |
| Two documents state the same machine fact | Section 7b was breached -- one will go stale |
| A briefing pointer names an exact filename | Section 7a was breached -- it will die at the next edit |
| The tree appears in more than one folder | The consolidation has regressed. Stop and reconcile before editing |
