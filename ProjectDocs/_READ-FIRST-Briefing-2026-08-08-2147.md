<!-- Dated: 2026-08-08 21:47 ET -->
# READ FIRST -- Session Briefing
**Document Name:** _READ-FIRST-Briefing
**Last Modified:** 2026-08-08 21:47 ET
**Last Editor:** Claude Code (CGDELL)
**Purpose:** Read this before anything else at the start of every session.
**Supersedes:** `_READ-FIRST-Briefing-2026-08-07-1330.md` -- retire that file
and every earlier briefing with it.

**FIVE THINGS CHANGED ON 2026-08-08. THEY CHANGE THE GROUND RULES.**

1. **The folder is now named `GatewayGuard`, not `GatewayGuide`.** The rename
   finally reached this machine. The single root is
   `C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\`.
2. **Claude Code now AUTHORS all governing documents.** Cloud does not.
   This is new and it is the most important rule change here -- see section 7.
3. **Sandy3's encryption is MEASURED, not assumed** -- `FullyEncrypted / 100 /
   XtsAes128`. The last unverified fleet fact is settled. See section 3.
4. **Folder backup is OFF on SANDY and SANDY3**, and CGDELL's Documents folder
   was rescued from inside the project tree. See section 4.
5. **A stale copy of the tree is nested INSIDE the working tree** at
   `Attachments\GatewayGuide\`, and it holds the ONLY copy of some of Bill's
   personal documents. Do not delete it. See section 5.

---

## 0. HOW TO FIND ANY DOCUMENT -- READ THIS BEFORE THE POINTER TABLE

**Glob the name. Take the newest by the DATE IN THE FILENAME.**

Never sort by the file's modified date. OneDrive sync rewrites modified dates,
so the most recently *touched* file is routinely not the most recent *version*.

**Measured 2026-08-07, and it is worse than it sounds.** Three copies of
`GatewayGuard_DefectPreventionPlaybook-*.md` exist. Each way of choosing gives
a different answer, and only one is right:

| Method | Returns | Stale by |
|---|---|---|
| Sort by **file modified date** | `2026-07-13` | 13 days |
| The filename **written out** in the 2026-08-06 briefing | `2026-07-25-1936` | 1 day |
| **Sort by the date in the filename** | **`2026-07-26-0619`** | **current** |

Both of the convenient methods were wrong. A session that trusted either would
build against a stale Playbook and never know it had.

**And do not trust a filename written out in full anywhere -- including in this
document.** Every briefing so far has gone stale within hours. The briefing
written 2026-08-06 17:27 named eight governing documents; **two were already
dead by the next morning** (see CORRECTIONS). That is why the table below uses
patterns, not filenames.

| Document | Pattern | When to read |
|---|---|---|
| Session rules | `GatewayGuard_ProjectInstructions-*.md` | Every session start |
| Coding standards, the 24 gates | `GatewayGuard_CodingStandards-*.md` | Before any .ps1 build |
| The seven failure classes | `GatewayGuard_DefectPreventionPlaybook-*.md` | Before any .ps1 build |
| Website rules | `GatewayGuard_WebsiteStandards-*.md` | Before any HTML work |
| Field record, current build | `GatewayGuard_TestHistory-ascii39-*.md` | **Before any claim about machine state or a past defect** |
| Migration | `GatewayGuard_M365MigrationPlan-*.md` | Before any OneDrive / tenant / domain work |
| Screen copy | `GatewayGuard_ScreenContents-*.md` | Before writing any tool-facing copy |
| **Cloud/Code sync -- what and why** | `GatewayGuard_SyncPlan-*.md` | Before any work involving Claude Cloud |
| **Cloud/Code sync -- the procedure** | `GatewayGuard_SyncSetupSteps-*.md` | When connecting or auditing Cloud |
| Everything else | `CLAUDE.md` | Before any guide or website copy |

---

## 1. CURRENT STATUS -- 2026-08-08 21:47 ET

**Active build:** ascii39 -- **NEVER FIELD RUN. No log exists.**
**Target launch:** September 1, 2026 at gatewayguard.co
**Current phase:** M365 tenant migration, website build, code-signing cert pending

**Nothing may be scoped, built or numbered as ascii40 until ascii39 has a field
log.** That is the UNRUN BUILD RULE. The migration plan once instructed exactly
that increment; it has been corrected twice now, so expect it to try again.

**Git (measured 2026-08-08 21:47):** 25 commits, 706 files tracked, 0 unpushed,
remote `GatewayGuard/GatewayGuard` (private, org-owned).

**The working tree is NOT "clean", and that is correct.** It carries **139
deletions** and **15 untracked** entries, all deliberate or junk:

| Count | What | Verdict |
|---|---|---|
| 63 | `Incoming/` | deliberate holdback |
| 32 | `Tool/Run-GatewayGuard_files/` | saved-webpage CSS/JS. Junk. |
| 19 | `WebSite/html/` | **the 19 guide pages** -- see section 8 item 7 |
| 17 | `Builds/` | old builds ascii18-34 |
| 8 | Presentation, LegalZoom, Certificates | holdbacks |

**Do not sweep any of it into a commit without asking.** Every commit made on
2026-08-08 was individually path-scoped, and that is the only reason 1.2 GB of
personal documents never reached GitHub.

---

## 2. THE FOUR THINGS THAT MATTER MOST

1. **ascii39 has never been field run.** Everything downstream is blocked on it.
   It belongs on **SANDY** -- CGDELL is fully encrypted and cannot reach the
   Home-unencrypted branch that most needs testing.
2. **The offsite backup EXISTS -- and must be kept fed.**
   `GatewayGuard/GatewayGuard`, **private**, org-owned. 25 commits, 706 files.
   Recovery is `git clone`, or `git checkout <commit> -- <path>` for one file.
   **Push at the end of any session that produces work worth keeping.** The
   danger is no longer "no remote" -- it is a remote gone stale while the only
   current copy sits in one folder. On 2026-08-07 that was exactly the state:
   21 commits locally, both fallbacks three commits behind, and a deletion
   pending that would have destroyed the only copy of 77 field logs.
3. **ONE WORKING tree -- but several stale copies still exist.**
   Edit only:
   `C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\`
   The root **contains a space**; quote it anywhere it is named. The old folder
   spelling `GatewayGuide` appears throughout files written before 2026-08-08.
   It was real, not a typo, and it is retired.
   **These other copies exist and are NOT sources** (measured 2026-08-08):
   `C:\GG-Backup\GatewayGuide` (652), `C:\GatewaayGuardBackup\GatewayGuide`
   (557, note the typo), `C:\GatewayGuard-Backup-2026-08-06` (560),
   `D:\GatewayGuide`, and one **nested inside the working tree** at
   `Attachments\GatewayGuide\` (586). See section 5.
   **When two copies disagree, the remote decides** -- not the newer file, not
   the bigger folder.
4. **The working tree's SHAPE can change without anyone noticing.**
   On 2026-08-08 two folders were moved by stray drag-and-drop in File
   Explorer: `ProjectDocs\` -- **every governing document** -- landed inside
   `Recovery Keys\`, and `WebSite\` (153 files) landed inside `Tool\`. Windows
   moves a folder on a same-drive drag with **no confirmation and no undo
   prompt.** `ProjectDocs` was gone over an hour before anyone noticed, and
   both were dismissed as "sync debris" twice before being opened.
   **`git status` reported it instantly.** Run it at the start of every session
   before trusting the folder layout. A deletion count that jumped since last
   time means something moved -- not that work was lost.

---

## 3. MACHINE FLEET

| Machine | Hardware | Edition | Encryption | OneDrive | Basis |
|---|---|---|---|---|---|
| **CGDELL** | Dell Latitude 5430, 32 GB | Win 11 **Pro** | **Fully encrypted** | both | measured 2026-08-02 |
| **SANDY** | HP Notebook 17-by1955cl, 8 GB | Win 11 **Home** | **NOT encrypted** | both | Bill, 2026-08-06 |
| **Sandy3** | Lenovo IdeaPad, 8 GB | Win 11 **Home** | **Fully encrypted** | both | **measured 2026-08-08** |

**Sandy3 measured 2026-08-08** (`Tool\Run-EncryptionMeasure.bat`):
`FullyEncrypted / 100% / XtsAes128`, read via `Get-BitLockerVolume`. C: is
474.7 GB with 176 GB used, SOLIDIGM SSDPFINW512GZL NVMe, i5-1235U, 8 GB,
Modern Standby. **This replaces the "pre-encrypted, unverified" note carried
for weeks.** It was the last fleet fact resting on a guess.

- **SANDY is the only unencrypted machine.** Its value for testing item 8's
  Home-unencrypted branch is spent permanently the first time encryption
  actually completes on it. **Do not sign SANDY into Windows with a Microsoft
  account** -- that is one of the things that triggers Device Encryption, and
  it would end the field-test capability that blocks everything downstream.
- **SANDY** needs the TP-Link Archer T2U Nano USB adapter -- the internal
  RTL8821CE Wi-Fi is a confirmed hardware failure. If there is no internet,
  check Malwarebytes filtering is set to none before suspecting the adapter.
- **Sandy3** touchpad is disabled in Settings; use a mouse.
- **Folder backup is OFF on SANDY and SANDY3** (2026-08-08), both accounts.
  **Leave it off.** Three PCs backing up to one personal account merge their
  Documents folders into the same cloud folder.
- **Recovery keys are printed and on USB for CGDELL and Sandy3.** CGDELL holds
  **four** working RecoveryPassword protectors -- all four unlock it. Rotation
  is a deliberate two-pass design and pass 2 was never run; that is untidy, not
  broken.
- **Most of the tree is cloud-only on the test machines** (measured 2026-08-08):
  SANDY 307 of 1,110 files are placeholders, SANDY3 **1,109 of 1,111**.
  **Before the ascii39 field run, right-click the project folder on SANDY and
  choose "Always keep on this device"** -- a placeholder needs internet to
  open, and SANDY has none without the USB adapter.

**Always ask which machine Bill is on before giving any machine-specific steps.**

---

## 4. WHAT CHANGED ON 2026-08-08

**The consolidation completed.** The personal-OneDrive copy of the tree was
deleted and the business copy renamed `GatewayGuide` -> `GatewayGuard`. The
rename had been made once before and reverted -- because it was made locally
while the cloud still held the old name, and **the cloud won.** It stuck only
when made in the browser, at the source.

**CGDELL's Documents folder was pointed INSIDE the project tree.** Measured:
`Documents -> C:\Users\willi\OneDrive\GatewayGuide\Documents`. That single
misconfiguration explained a whole afternoon of failures -- a folder that
regenerated after four deletions (Windows was recreating its own Documents
folder), 1.2 GB of personal files sitting in `Builds\Documents\`, and two
OneDrive accounts deadlocking over folder backup. It is now local at
`C:\Users\willi\Documents` with 2,180 files.

**The fix needed the supported API, not the UI.** The Location tab never
appeared on that machine. Three legacy junctions (`My Music`, `My Pictures`,
`My Videos`) blocked the redirect and had to be removed with `rmdir`; OneDrive
had to be unlinked to release the folder; then `SHSetKnownFolderPath` did it
in one call. **Editing `User Shell Folders` in the registry is the Windows XP
method and is not supported today** -- scripts for this are in
`C:\GG-Backup\Fix-Documents\`.

**Sandy3's encryption measured** -- see section 3. Folder backup turned off on
both test machines. Recovery keys printed and copied to USB for CGDELL and
Sandy3.

**Two governing documents were written and filed:**
`GatewayGuard_SyncPlan-*` (what and why) and `GatewayGuard_SyncSetupSteps-*`
(the procedure). Together they define how Claude Cloud and Claude Code stay in
agreement, and they assign authorship -- see section 7.

**New tools committed:** `Tool\Run-GetRecoveryKey.bat` reads a BitLocker
recovery key locally, read-only, saving to `C:\GG-RecoveryKey\` **outside the
tree** -- because `account.microsoft.com/devices/recoverykey` went into a
sign-in loop, and because a key committed to git is permanent in its history.

**The 19 guide pages were found.** `WebSite/files (6)/` holds exactly 19 HTML
files matching the 19 deleted from `WebSite/html/`. Briefing 2026-08-07 flagged
that folder as "may be a stray copy" -- confirmed, it is.

### Carried forward -- what changed 2026-08-06 evening into 2026-08-07

**Migration Phase 4 path audit -- done.** The grep Bill asked for
(`\OneDrive\`, `$env:USERPROFILE`, `C:\Users\`, `CGDELL`, `SANDY3`) returned
236 hits. 235 were noise. One was real:

- **The `.ps1` integrity hook was registered by absolute path** in
  `.claude/settings.local.json`. That is the Class 7 gate earned by the
  2026-07-25 ascii34 corruption. Moving the tree would have stopped it running,
  silently. Now `${CLAUDE_PROJECT_DIR}`, verified by writing a probe `.ps1` and
  watching the hook answer. **The rule it teaches: a check wired up by absolute
  path is one folder move away from being a wish.**
- **`$env:USERPROFILE` in ascii39 line 1401 is the CUSTOMER's profile, not this
  tree.** A search-and-replace would break first-run detection on every machine
  Checkup ever runs on. Do not touch it.
- All 15 CGDELL/SANDY3 hits in `Tool\*.ps1` are gate-24 VERIFIED evidence
  comments. Editing them destroys the provenance trail the gate exists to
  enforce.
- **The migration therefore does NOT require ascii40.** Nothing in the build
  was wrong. All 10 launchers use `cd /d "%~dp0"` and relocate cleanly.

**FT-170 raised** (TestHistory ascii39, section 5h). Checkup already creates
`C:\GatewayGuard\Logs` automatically -- lines 1530, 1571, 1583 -- and creates a
**second** folder, `C:\ProgramData\GatewayGuard\Logs`, that no screen mentions.
The defect is that it asks permission for neither, in a product whose central
promise is "Checkup never applies anything you did not choose". Both creations
sit in silent `try` blocks, so a failure loses the log without a word.

**Two new tools, both tested on CGDELL:**

| Launcher | What it does |
|---|---|
| `Tool\Run-OneDriveSyncCheck.bat` | Read-only. Which OneDrive accounts a machine has, and if the tree is really on disk or a cloud placeholder. **Has now run on all three machines -- 2026-08-08.** |
| `Tool\Run-CollectLogs.bat` | Copy-only, idempotent. Brings Checkup's logs from `C:\GatewayGuard\Logs` into `Test_Results\` so OneDrive carries them back with no USB round trip. |

**Why the log collector exists:** Checkup logs to `C:\GatewayGuard\Logs`, which
is outside OneDrive and never syncs. The sync-instead-of-USB plan had a hole
exactly where the field-test log is. The path is a fixed recovery point and does
not move; the log is brought to the synced folder instead.

**77 field logs committed** -- every Checkup run 2026-07-06 to 2026-07-30. They
had lived on one disk, never backed up.

**Storage.** Personal OneDrive was **5.02 GB, over the 5 GB free tier** a lapsed
subscription drops to. Deleting a December 2023 Samsung phone backup (3.5 GB,
99.9% re-downloadable app installers, zero photos/messages/contacts) took it to
**1.59 GB** and out of danger. Bill is cancelling a university-tied Office 365
subscription; his personal OneDrive now survives that with room to spare.

---

## 5. CORRECTIONS TO THE 2026-08-06 17:27 BRIEFING

| It said | Actually |
|---|---|
| Read `GatewayGuard_CodingStandards-2026-08-02-0741.md` | **File does not exist** -- renamed to `-2026-08-06-1700` |
| Read `GatewayGuard_TestHistory-ascii39-2026-08-02-0914.md` | **Never existed** -- the file is `-2026-08-02-1335` |
| "Path grep on CGDELL -- NOT DONE" | **Done 2026-08-06.** Found the hook defect above |
| "may prove the path-fix work is empty" | It was not empty |
| "GitHub as sync layer... the repo is authoritative for website files" | **Settled 2026-08-07.** Half true. A public website repo does exist -- `GatewayGuard/gatewayguard.github.io`, org-owned, Pages on, `CNAME` = `gatewayguard.co` -- but it is **not** authoritative for the guide pages, because they were never uploaded. `gh repo list` returns nothing because the repos belong to the **`GatewayGuard` org**, not to `wfbiii`; query the org, not the account |

**Uncommitted on purpose, do not sweep into a commit without asking:**
`Certificates/Banking instructions.odt`, `Certificates/MaineCommunityBank/`
(financial documents -- a commit is permanent), `Heath/` (medical documents),
`Builds/Documents/`, a duplicate licence `.docx`, and `WebSite/files (6)/`
which holds the 19 guide pages.

### `Attachments\` -- READ BEFORE DELETING IT

A stale copy of the whole tree, **with its own `.git`**, sits nested inside the
working tree at `Attachments\GatewayGuide\`. It is untracked, so nothing has
been committed from it -- but a single `git add .` would embed a repository
inside a repository.

**Do NOT delete `Attachments\`.** Hash-compared 2026-08-08: 35 blobs in it are
not in the live tree, and **18 of those are Bill's only copies** -- his resume
(`wfburnsiiiresume.doc`), three Mark Cuban pitch letters, `The Executive
Letter.docx`, `final review.docx`, `Maine Credi Voucher (1).pdf`, and the
`Sunset\` set (Executive Summary, Due Diligence, Fiduciary Pledge, Moral
Verification, Waste Audit, Deployment Map). Swept the whole machine -- they
exist nowhere else. The `Sunset` folder at the OneDrive root is **empty**.

The other 17 are superseded project files (in git) and saved-webpage junk.

**Move the 18 documents out first**, then the remainder can go. An earlier
Attachments copy in the personal OneDrive *was* purely redundant and was safely
deleted -- **same folder name, different contents.** Verify before assuming.

---

## 6. RULES MOST OFTEN BROKEN -- CHECK YOURSELF AGAINST THESE

**Evidence.** Label every factual claim **measured / sourced / inferred /
guess**. Only *measured* and *sourced* may enter the tool or user-facing copy.
Search project knowledge before describing machine state or a past result --
**a TestHistory measurement outranks any prose description in any document.**
Prefer running the check over asking Bill to run it.

**Command flags are factual claims.** Never write a flag or flag value not seen
in that program's own help output or run. This is gate 24, earned by FT-162:
`MpCmdRun.exe -ScanType 4` does not exist, returned `0x80070667` in 0.0
seconds, and the log printed `[GOOD]` every time for months.

**Never paste a command into chat for Bill to run. Write a `.ps1` and a paired
`.bat`.** Measured record: 3 pasted commands, 3 mangled by line wrapping (100%
failure); 3 shipped as files, 3 ran first time (100% success). Launchers use
`cd /d "%~dp0"`, are CRLF, never self-elevate, and end with an Enter-only wait
(never cmd's `pause`, which prints the banned "press any key").

**Naming.** First mention **GatewayGuard Checkup**, thereafter **Checkup**.
Never "the tool" or "the program". Do not rename the MachineID salt
`"GatewayGuard|"`, the Task Scheduler task names, `C:\GatewayGuard\`,
`Run-GatewayGuard.bat`, `gatewayguard.co`, or the LLC.

**Banned in all user-facing copy:** "whether", "whereas", and "switch" as a verb
for settings (use "turn on/off" -- it is what Checkup and Windows both say).

**Permission language.** Every sentence describing a setting change names the
user's approval.

**.ps1 edits** go through assert-guarded Python wrappers -- no cosmetic
exemption. A lint pass corrupted ascii34 on 2026-07-25. Brace balance alone
proves nothing: the corrupted file measured 47,232/47,232, perfectly balanced
and completely destroyed.

**Confirm once, then act.** State scope and ask before any bulk or destructive
operation -- then do it. Do not re-ask the same question reworded.

---

## 7. THE TWO CLAUDES -- WHO DOES WHAT

**CHANGED 2026-08-08 -- this supersedes every earlier version of this table.**

| Task | Who |
|---|---|
| **ALL governing documents** | **Claude Code** -- see below |
| File edits, builds, git, anything touching the folder | Claude Code |
| Business, legal, licensing, marketing, FAQ, presentations, CPM | Claude Cloud |
| **Reviewing** a document Claude Code produced | Claude Cloud |
| Field tests, machine settings, approvals, the Sync click | Bill |

**Governing documents** = ProjectInstructions, CodingStandards,
DefectPreventionPlaybook, WebsiteStandards, TestHistory, ScreenContents, this
briefing, CLAUDE.md, SyncPlan, SyncSetupSteps.

**Why Claude Code authors them:** it is the only party that can check a claim
before writing it down. **Measured 2026-08-08:** every dead pointer found in
the governing documents was in a file whose `Last Editor:` line reads
Claude.ai, and a scan of every `.md` in the tree found **15 of 49 exact
filename references dead**. Cloud could not have known -- it cannot run a glob,
measure a line count, read git state, or see a machine. It is not a lesser
tool; it is a differently-blind one.

**Cloud must not:** author or revise a governing document; write an exact
filename into anything that will be filed; state machine state, build numbers,
line counts or test results from memory. If it needs one of those, it asks for
it to be measured.

**Claude Cloud cannot write to the tree.** Anything it produces that gets filed
must be downloaded by Bill, saved, committed and pushed by Claude Code. That is
the one step no design removes, and the one most likely to be skipped. If a
decision exists only in a chat, say so: *"this is in chat only, not yet filed
in [filename]."*

**Differences that matter for Claude Code specifically:**

- **Do not ask Bill for the date and time.** Cloud has to; Claude Code runs
  `Get-Date` and should.
- **Do not ask Bill to check something checkable.** Run it.
- **Both Claudes may be writing to the same synced tree at once.** On
  2026-08-06 Cloud wrote three governing documents at 17:27 while Claude Code
  was editing the same folder, and one was born with a dead pointer 26 minutes
  old. If a file's timestamp is newer than your session start and you did not
  write it, Cloud did -- read it before assuming your view is current.

---

## 8. NEXT PRIORITIES, IN ORDER

1. **DONE 2026-08-08** -- `Run-OneDriveSyncCheck.bat` has now run on all three
   machines. All three report `refs/heads/main at 4160d05` or later, with the
   ascii39 build hashing to `75C3509473F17D6F` everywhere. **This item is
   closed.**
2. **ascii39 field run on SANDY** -- item 8 screens exercised, encryption NOT
   started, then `Run-CollectLogs.bat`. Unblocks everything downstream.
   **Before starting: right-click the project folder on SANDY and choose
   "Always keep on this device."** 307 of its 1,110 files are cloud
   placeholders, and SANDY has no internet without the USB adapter.
3. **Rebuild the assert-guarded Python wrapper.** CodingStandards requires
   every `.ps1` build edit to go through one. **Measured 2026-08-07: there are
   zero `.py` files in the tree and zero in git history** -- the wrappers that
   built ascii37 (`build_ascii37.py`, `measure.py`, `final_check.py`,
   `patch_header_count.py`, still named in `.claude/settings.local.json`) were
   never committed and are gone. The spec survives intact in CodingStandards
   PYTHON EDITING RULES, so it can be rebuilt exactly. **Commit it this time.**
   Required before ascii40, but not urgent: ascii40 is blocked on the ascii39
   field run regardless.
4. **ascii40 scope, only after the field log exists:** FT-170 (consent for the
   log folders), FT-162 (the Defender scan that has never run), and the three
   remaining "whether" strings.
5. Finish M365 Phase 1 (Sandy3), then rewrite Phase 3 -- the tree is already in
   the business OneDrive, so "move it there" as written risks propagating a
   deletion.
6. Reconfirm the business items carried from 2026-08-02, all with dates now
   passed: Maine Community Bank, SAM.gov EFT, D&B DUNS, DigiCert validation,
   LegalZoom EULA review, Google Business profile.
7. **Upload the 19 guide pages.** **Measured 2026-08-07: they never reached
   GitHub.** `GatewayGuard/gatewayguard.github.io/guide/` contains a single
   `index.html`. That repo is public, Pages is on, and its `CNAME` is
   `gatewayguard.co`, so the domain is already wired to it -- but it has not
   been pushed to since **2026-07-21** and `index.html` still carries an
   "UNDER CONSTRUCTION" banner.
   **Found 2026-08-08:** the pages exist in two places -- git history
   (`WebSite/html/`, deleted from the worktree) and untracked in
   `WebSite/files (6)/`. **Hash-compare the two copies before publishing any
   of them** -- which is current has not been established.
   Also still open: confirm 17 stale HTML files deleted.
8. **Move Bill's 18 personal documents out of `Attachments\`** (section 5),
   then remove the stale nested tree copy.
9. **Commit the seven untracked project files** -- three sync-check results,
   the Sandy3 encryption profile, `Rotate-BitLockerKey` and its launcher, the
   to-do list. The rotate tool has never been committed, which is the same
   class of gap as the missing Python wrappers.
10. **Connect Claude Cloud to the repository** -- follow
    `GatewayGuard_SyncSetupSteps-*.md`. Scope to `ProjectDocs/`, `Tool/`,
    `WebSite/` and `CLAUDE.md` by **folder**, never the repo root.
