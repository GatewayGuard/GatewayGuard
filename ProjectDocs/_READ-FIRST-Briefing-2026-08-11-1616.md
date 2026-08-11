<!-- Dated: 2026-08-11 16:16 ET -->
# READ FIRST -- Session Briefing
**Document Name:** _READ-FIRST-Briefing
**Last Modified:** 2026-08-11 16:16 ET
**Last Editor:** Claude Code (CGDELL)
**Purpose:** Read this before anything else at the start of every session.
**Supersedes:** BOTH `_READ-FIRST-Briefing-2026-08-08-2147.md` (Claude Code)
and `_READ-FIRST-Briefing-2026-08-09-1110.md` (Claude.ai) -- retire both, and
every earlier briefing with them.

**Change History Log:**
- 2026-08-11 16:16: **The ascii39 field run started.** Phase 2 captured SANDY's
  unencrypted profile -- one-shot, now permanent. **FT-167 confirmed in the
  field** (a second fixed drive, 931.5 GB, in the clear). And **SANDY's
  Windows account was Microsoft until today**, through a week of reboots,
  without Device Encryption ever engaging -- which contradicts the warning in
  section 3. Bill converted it to a local account named `panther` immediately
  before Phase 3. See section 1.
- 2026-08-11 14:45: **THE CONNECTOR IS LIVE, AND `Attachments\` IS GONE.**
  Claude Cloud now reads the repository -- A6 passed on revised targets, with
  every quoted line matching CGDELL character for character. Section 8's items
  7 and 9 are **done** and struck. Section 5's `Attachments\` do-not-delete
  warning is **withdrawn**: the folder was deleted 2026-08-10 after 21 unique
  documents and 29 medical files were rescued and hash-verified. Counts in
  section 1 re-measured. Also records what two days of connector work actually
  cost -- five interface failures, now PART F of `SyncSetupSteps`, none of them
  documented anywhere and every one indistinguishable from a broken connector
  while it was happening.
- 2026-08-09 22:39: **Revised against Claude Cloud's review** of all three sync
  documents (28 findings; 23 applied, 2 pushed back, 3 decided by Bill).
  Restored from Cloud's briefing: the **LegalZoomGuide backwards-timestamp
  exception** (section 0 -- it was dropped, leaving the document's first rule
  stated with no exception at all); the **"open-source" ban** (section 15 --
  dropped while section 12's open violation of it was kept); **transcript
  outranks summary** as a standing rule rather than an anecdote;
  **NamingStandard** and the delivered-but-never-uploaded list (section 14);
  **CROSS-FILE SYNC / Run-GatewayGuard.bat**; **"no tool can delete from
  project knowledge"**; the **sign-in column** in the fleet table, without
  which the SANDY warning has nothing to check against; and the business
  carry-forward detail, which had been collapsed to one line and hid the
  Gumroad decision.
  Fixed: the connector scope now stated **once**, in SyncSetupSteps A5;
  commit and file counts now stated **once**, in section 1; a **closed item no
  longer holds the #1 priority slot** ahead of the ascii39 field run.
  Added section 13 on what the review changed, and the `python3`-alias tooling
  trap. Recorded Bill's decision: **Gumroad for all sales.**
- 2026-08-09 14:45: Merged the Claude Code and Claude.ai briefings.

## WHY THIS IS A MERGE

**Two briefings existed and both claimed to be current.** Claude Code wrote one
on 2026-08-08 at 21:47; Claude.ai wrote another on 2026-08-09 at 11:10. Cloud's
named `-2026-08-06-1727` as its predecessor because its project-knowledge
snapshot is frozen at session start and mine did not exist yet.

**Cloud's was newer by filename date.** Under the glob-newest rule -- the first
rule in this document -- the next session would have read Cloud's and missed
the entire 2026-08-08 consolidation: the folder rename, the Documents rescue,
the GitHub remote, the folder-backup work, Sandy3's measurement.

Neither was complete. Cloud's carried real findings mine lacked -- the
index-vs-mount rule, project-knowledge-is-not-a-backup, an open Marketing
violation. This file carries both and supersedes both.

**The lesson, and it is now the reason section 7 exists:** two authors writing
the same governing document, neither able to see the other's, produces two
documents that are each individually correct and jointly misleading.

---

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

**AND FIVE MORE ON 2026-08-09:**

6. **PROJECT KNOWLEDGE IS NOT A BACKUP.** Cloud stores its own ingested
   representation, not the uploaded original. See section 9.
7. **The SESSION LOG RULE is real, and Claude Code has never followed it** --
   its defining file had never reached the tree. See section 10.
8. **CF-01 through CF-06 were recovered from Cloud** -- 62 lines of ascii30/31
   field findings that existed in no file here. See section 4.
9. **The website-copy rule moved to `WebSite\Rules\`** so Claude Cloud can see
   it. The connector scope is **four items** -- `ProjectDocs/`, `Tool/`,
   `WebSite/`, `CLAUDE.md`. **The authoritative statement of the scope is
   `GatewayGuard_SyncSetupSteps-*.md` step A5, nowhere else.**
10. **Claude Cloud reviewed all three sync documents on 2026-08-09** and found
   28 defects, most of them internal inconsistency rather than wrong facts.
   See section 13 -- it changed how these documents are checked.

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

### THE ONE DOCUMENTED EXCEPTION -- LegalZoomGuide

**`GatewayGuard_LegalZoomGuide-2026-07-24-0846` is CURRENT.
`-2026-07-24-0921` was the initial version.**

The document's own change history reads `09:21 -- Initial version` and
`08:46 -- Added copyright registration process, filing timeline and
deposit-materials question`. **The update carries an EARLIER filename stamp
than the draft it replaced**, so newest-by-date-in-filename returns the wrong
file here.

Both `-0921` copies were retired from ProjectDocs on 2026-08-09. Two files
still named `-0921` survive in `Certificates\LegalZoom\` and `LegalZoom\` --
those are **byte-identical to the `-0846`**, so they hold current content under
a wrong name.

**This is the only known pair where the filename date lies about which version
is newer.** It was dropped from an earlier merge of this briefing, which left
the first rule in this document stated with no exception at all -- and a
dropped exception to a rule promoted to primacy is the worst combination
available. Caught by Cloud's review.

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

## 1. CURRENT STATUS -- 2026-08-09 22:39 ET

**ascii39 FIELD RUN IS UNDERWAY -- Phase 2 DONE, 2026-08-11.**

`Tool\EncryptionProfile-SANDY-2026-08-11_15-15.txt` is captured and
committed. **That measurement was one-shot** -- once SANDY encrypts, its
unencrypted profile is unrecoverable.

| | |
|---|---|
| `C:` | 237.3 GB / **67.7 GB used** (29%) · WDC SN520 SSD NVMe · **FullyDecrypted** |
| `D:` | 931.5 GB / 78.9 GB used (8%) · ST1000LM035 HDD · **FullyDecrypted** |
| | i5-8265U · 8 GB · Edition **Core** (Home) · **Modern Standby** |

**Predicted mode is USED-SPACE-ONLY, so any timing estimate comes from the
67.7 GB used figure, not the 237 GB volume size.**

**FT-167 IS CONFIRMED IN THE FIELD.** SANDY has a second internal fixed
drive, `D:`, 931.5 GB, fully decrypted. **Checkup only ever reads `C:`**, so
a machine in this shape is told `ENCRYPTED -- GOOD` while a terabyte sits in
the clear. Raised 2026-08-02 as a theory from the Dell; this is the first
measurement of a machine that actually exhibits it.

**SANDY'S WINDOWS ACCOUNT WAS MICROSOFT UNTIL 2026-08-11.** Bill converted
it to a **local account named `panther`** that day, immediately before
Phase 3. It had been signed into a Microsoft account **for a week or more,
through multiple reboots, with Modern Standby present -- and Device
Encryption never engaged.**

**That contradicts a standing warning in this document.** Section 3 says
signing SANDY into Windows with a Microsoft account is one of the things
that triggers Device Encryption. On this machine, over a week, it did not.
**Basis: reported by Bill 2026-08-11, corroborated by the profile above
showing both drives FullyDecrypted.** The warning has not been disproven in
general -- one machine over one week is not a rule -- but it can no longer
be stated as settled, and the assumption that SANDY's test value is
one keystroke from being spent is measurably too pessimistic.

**Phase 3 -- the 45-minute local-account run -- was starting when this was
written. Ask Bill whether it finished before assuming either way.**

---

**Active build:** ascii39 -- **FIELD RUN IN PROGRESS, no log yet.**

A TestHistory file exists -- `GatewayGuard_TestHistory-ascii39-2026-08-02-1335.md`
-- but it is a **BUILD record, not a field record.** Its own header reads *"No
field run yet."* **No field-run log exists.** *(An earlier version of this line
said "No log exists," which is how a file that does exist got recorded as
missing once already -- see section 5.)*
**Target launch:** September 1, 2026 at gatewayguard.co
**Current phase:** M365 tenant migration, website build, code-signing cert pending

**Nothing may be scoped, built or numbered as ascii40 until ascii39 has a field
log.** That is the UNRUN BUILD RULE. The migration plan once instructed exactly
that increment; it has been corrected twice now, so expect it to try again.

**Git (measured 2026-08-11 14:45):** 47 commits, 634 files tracked, 0 unpushed,
remote `GatewayGuard/GatewayGuard` (private, org-owned).

**The tracked count went DOWN by 75 on purpose.** The connector would not fit --
project knowledge reported 312% of capacity -- so 10.8 MB was trimmed to 4.42 MB:
saved-webpage junk, 17 PDFs, superseded builds ascii32-38, three `.pptx`. The
large binaries were untracked with `git rm --cached`, so they remain on disk.

**These counts are stated HERE and nowhere else.** They were previously written
into three documents at once and all three disagreed within 24 hours -- which
is the "two documents state the same machine fact" symptom the SyncPlan names.
Everything else points here. **If you need them current, run `git status`;** a
number in a document is a measurement with a timestamp, not a live reading.

**The working tree is NOT "clean", and that is correct.** It carries **93
deletions** and **51 untracked** entries, all deliberate or junk:

| Count | What | Verdict |
|---|---|---|
| 63 | `Incoming/` | deliberate holdback |
| 17 | `Builds/` | old builds ascii18-34 |
| 6 | `Notes/Older Files/` | **moved, not lost** -- see below |
| 7 | ProjectDocs, LegalZoom, Certificates | holdbacks |

**The untracked count nearly tripled, and that is also correct.** Most of it is
the PDFs, `.pptx` and superseded builds untracked on 2026-08-11 to fit the
connector -- still on disk, still in git history, simply no longer tracked.

**`Notes\Older Files\` was found at the business OneDrive root** on
2026-08-11, one level above the project, after a stray File Explorer drag. All
six files hash-verified identical to git. **Nothing was lost.** Decide whether
to move it back or record the removal with `git rm`; what is wrong is the
current state, where git reports six files missing and they are sitting one
folder up. This is the third stray-drag incident -- see section 2 item 4.

**Do not sweep any of it into a commit without asking.** Every commit made on
2026-08-08 was individually path-scoped, and that is the only reason 1.2 GB of
personal documents never reached GitHub.

---

## 2. THE FOUR THINGS THAT MATTER MOST

1. **ascii39 has never been field run.** Everything downstream is blocked on it.
   It belongs on **SANDY** -- CGDELL is fully encrypted and cannot reach the
   Home-unencrypted branch that most needs testing.
2. **The offsite backup EXISTS -- and must be kept fed.**
   `GatewayGuard/GatewayGuard`, **private**, org-owned. Counts are in section 1
   only, never repeated here -- see the note there.
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
   (557, note the typo), `C:\GatewayGuard-Backup-2026-08-06` (560), and
   `D:\GatewayGuide` (not reachable when last checked).
   **The nested copy inside the working tree is GONE** -- `Attachments\` was
   deleted 2026-08-10. See section 5.
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

| Machine | Hardware | Edition | Windows sign-in | Encryption | OneDrive | Basis |
|---|---|---|---|---|---|---|
| **CGDELL** | Dell Latitude 5430, 32 GB | Win 11 **Pro** | **Microsoft account** | **Fully encrypted** | both | measured 2026-08-02, FT-143/144/145 |
| **SANDY** | HP Notebook 17-by1955cl, 8 GB | Win 11 **Home** | **Local account** | **NOT encrypted** | both | Bill, 2026-08-06 |
| **Sandy3** | Lenovo IdeaPad, 8 GB | Win 11 **Home** | unverified | **Fully encrypted** | both | **measured 2026-08-08** |

**The sign-in column is load-bearing, not decoration.** SANDY being on a
**local account** is what makes the warning below checkable: signing it into
Windows with a Microsoft account is one of the things that triggers Device
Encryption. Without the column, that warning floats with nothing to test it
against.

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
| Read `GatewayGuard_TestHistory-ascii39-2026-08-02-0914.md` | **CORRECTED 2026-08-09.** An earlier version of this briefing said it "never existed." **It exists** -- in Claude project knowledge, alongside a `-2026-08-02-1116` version. It was never in the tree, which is why a tree search missed it. "Not in the tree" is not "never existed": that was an unverified negative, the same failure this document criticises elsewhere. The tree's copy is `-2026-08-02-1335`, which is the newest of the three. |
| "Path grep on CGDELL -- NOT DONE" | **Done 2026-08-06.** Found the hook defect above |
| "may prove the path-fix work is empty" | It was not empty |
| "GitHub as sync layer... the repo is authoritative for website files" | **Settled 2026-08-07.** Half true. A public website repo does exist -- `GatewayGuard/gatewayguard.github.io`, org-owned, Pages on, `CNAME` = `gatewayguard.co` -- but it is **not** authoritative for the guide pages, because they were never uploaded. `gh repo list` returns nothing because the repos belong to the **`GatewayGuard` org**, not to `wfbiii`; query the org, not the account |

**Uncommitted on purpose, do not sweep into a commit without asking:**
`Certificates/Banking instructions.odt`, `Certificates/MaineCommunityBank/`
(financial documents -- a commit is permanent), `Heath/` (medical documents),
`Builds/Documents/`, a duplicate licence `.docx`, and `WebSite/files (6)/`
which holds the 19 guide pages.

### `Attachments\` -- DELETED 2026-08-10. This section is history.

**The folder no longer exists.** 825 files removed, including the nested stale
tree copy and its `.git`. Nothing was lost, and the warning below is retained
only because how it was cleared is the useful part.

**What was rescued first, and verified:**

- **29 medical documents** from `Attachments\GatewayGuide\Heath\` --
  hash-verified byte-identical into `C:\Users\willi\OneDrive\Personal\`,
  29 of 29. That folder existed in **exactly one place** on the machine: not in
  git, not in any of the four backup copies, not in either OneDrive. **The
  briefing named 18 personal documents as the constraint; the real constraint
  was 29 medical files nobody had listed.**
- **21 documents** in `Attachments\` itself -- the resume, three Cuban letters,
  `The Executive Letter.docx`, `final review.docx`, `Maine LLC.pdf`,
  `Maine Credi Voucher (1).pdf`, and both levels of `Sunset\` -- copied to
  `Personal\` and hash-verified 21 of 21 **before** the delete ran. The script
  was written so the deletion could not execute unless all 21 passed.

**Only one file in the whole folder had a copy elsewhere** (`UPS-LLC_Delivery.txt`,
eight copies). Everything else was either unique and rescued, or part of the
586-file stale tree copy that was proven redundant first: 493 files
byte-identical to the live tree, 4 differing with the live tree newer on every
one, and nothing that superseded anything.

**The lesson worth keeping:** the briefing said "move the 18 documents out
first, then the remainder can go." The 18 were in `Attachments\` proper and
were never at risk from deleting the nested copy. The 29 files that *were* at
risk went unmentioned. **A named list in a warning becomes the thing people
check, and stops them looking for what the list left out.**

---

### The original warning, retained for its reasoning

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

1. **ascii39 field run on SANDY** -- item 8 screens exercised, encryption NOT
   started, then `Run-CollectLogs.bat`. Unblocks everything downstream.
   **Before starting: right-click the project folder on SANDY and choose
   "Always keep on this device."** 307 of its 1,110 files are cloud
   placeholders, and SANDY has no internet without the USB adapter.
2. **Rebuild the assert-guarded Python wrapper.** CodingStandards requires
   every `.ps1` build edit to go through one. **Measured 2026-08-07: there are
   zero `.py` files in the tree and zero in git history** -- the wrappers that
   built ascii37 (`build_ascii37.py`, `measure.py`, `final_check.py`,
   `patch_header_count.py`, still named in `.claude/settings.local.json`) were
   never committed and are gone. The spec survives intact in CodingStandards
   PYTHON EDITING RULES, so it can be rebuilt exactly. **Commit it this time.**
   Required before ascii40, but not urgent: ascii40 is blocked on the ascii39
   field run regardless.
3. **ascii40 scope, only after the field log exists:** FT-170 (consent for the
   log folders), FT-162 (the Defender scan that has never run), and the three
   remaining "whether" strings.
4. Finish M365 Phase 1 (Sandy3), then rewrite Phase 3 -- the tree is already in
   the business OneDrive, so "move it there" as written risks propagating a
   deletion.
5. **Business items -- the detail matters, and collapsing it hid decisions.**
   All carried from 2026-08-02 with dates now passed:
   - **Maine Community Bank** -- the account must be a **checking** account.
     That is the qualifying demand deposit account for DigiCert, and it **must
     be named explicitly** in the bank letter.
   - **SAM.gov EFT** -- blocked on the account number.
   - **D&B DUNS** -- blocked on bank info.
   - **DigiCert / SignMyCode validation** -- blocked on D&B, the bank letter,
     or SAM.gov.
   - **LegalZoom** -- six open licence decisions and two attorney follow-ups:
     the Gumroad refund override, and EU/UK withdrawal rights.
   - **Google Business profile.**
   - **Guide rewrite** from `windows_security_walkthrough_guide_v9.docx` to
     current truth.
   - **Batch 2 website pages:** tips, beta, compatible.
   - **DECIDED 2026-08-09: Gumroad for all sales.** This closes the
     Gumroad-vs-direct-checkout question that was gating refund terms and sales
     tax work. The two attorney follow-ups above now have a definite subject.
6. **Upload the 19 guide pages.** **Measured 2026-08-07: they never reached
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
7. ~~Move Bill's 18 personal documents out of `Attachments\`, then remove the
   stale nested tree copy.~~ **DONE 2026-08-10.** All rescued and
   hash-verified into `C:\Users\willi\OneDrive\Personal\`; `Attachments\`
   deleted, 825 files. See section 5.
8. **Commit the seven untracked project files** -- three sync-check results,
   the Sandy3 encryption profile, `Rotate-BitLockerKey` and its launcher, the
   to-do list. The rotate tool has never been committed, which is the same
   class of gap as the missing Python wrappers.
9. ~~Connect Claude Cloud to the repository.~~ **DONE 2026-08-11. A6 PASSED.**

    Scope is `ProjectDocs/`, `Tool/`, **`WebSite/Rules/`** and `CLAUDE.md`.
    **Note the narrowing:** all of `WebSite/` would not fit -- capacity ran to
    116% -- and `WebSite/Rules/website-copy.md` is the only part Cloud needs.

    **Proof, 2026-08-11:** Cloud quoted the root `CLAUDE.md` rule-move line,
    `Tool/Run-ExternalCommandCheck.bat` and both header lines of
    `WebSite/Rules/website-copy.md`, all matching CGDELL character for
    character; `ProjectDocs/` proved by twelve prefixed files.

    **Re-run A6 after anything that changes the connection** -- deleting the
    manual uploads cleared the connector content once, and the repository entry
    kept showing as attached the whole time. **The capacity meter is not
    evidence:** it read 1% while the connector was fully loaded and answering
    correctly. See `SyncSetupSteps` PART F for the five interface failures that
    cost two days, all of which look exactly like a broken connector.

---

## 9. PROJECT KNOWLEDGE IS NOT A BACKUP (established 2026-08-09)

**measured** by `file` and Python `zipfile` inspection of every non-text file
in project knowledge, then confirmed independently by hash-comparing the
2026-08-09 archive against this tree:

| Class | Condition |
|---|---|
| `.md` `.txt` `.ps1` `.html` `.cs` | Byte-exact. Faithful. |
| `.docx` `.odt` | **Plain UTF-8 text extractions.** Word will not open them. Fonts, tables, headers, images -- all gone. |
| `.pdf` | **Zip bundles of page JPEGs plus OCR text.** No PDF reader opens them. |

Measured examples: `GatewayGuard_License-2026-08-07-0726.docx` is 15,910 bytes
of Markdown-ish text and `zipfile` rejects it with `BadZipFile`. `mainellc6.pdf`
is a zip containing `1.jpeg, 2.jpeg, 3.jpeg, 1.txt, 2.txt, 3.txt`.

**This tree is the only real backup, and GitHub is its offsite copy.** Anything
pulled out of project knowledge is a text-searchable reference, never a
document of record.

**Practical consequence:** when harvesting a file back from Cloud, check its
signature before committing it. A real PDF starts `%PDF`; a real `.docx` starts
`PK`. On 2026-08-09 thirteen harvested files were checked this way and all were
genuine, because Bill had sourced them from originals rather than the archive.

---

## 10. THE SESSION LOG RULE -- REAL, AND NEVER FOLLOWED HERE

`ProjectDocs\GatewayGuard_SessionLog-*.md` defines a standing rule:

> **Claude Code:** Read this file at every session start. Update it after every
> file produced or build completed. Commit at session end.
> **Bill:** Download at the end of every session, upload to the project.
> This is the shared memory between all Claude instances.

**Claude Code has never followed it, and could not have.** The file existed
only in Claude project knowledge until 2026-08-09; it had never reached the
tree, so there was no way to read it or to discover it existed. Cloud cited a
"SESSION LOG RULE" and a grep of every governing document found it nowhere --
which looked like Cloud inventing a rule, and was not.

It is now committed and will reach both sides through the connector.

---

## 11. INDEX-VS-MOUNT RULE (Cloud-side, added 2026-08-09)

**The `/mnt/project/` bash mount is not a reliable listing of project
knowledge. The index supplied at session start is authoritative.**

**measured 2026-08-09:** the mount lagged the index by 5+ files at session
start, then caught up unevenly over three hours. Late in the session two files
appeared and two vanished between checks minutes apart with **no delete action
taken**, while the total held at 108 -- so the churn was invisible to a count.

1. **Never hand-transcribe the index to diff against it.** Twice in one session
   a diff reported "zero discrepancies" only because the transcription dropped
   the same files the mount was missing. Both checks were worthless and both
   were reported as proof.
2. **A matching file count is not a matching file set.** Compare names.
3. **If the mount churns mid-session, stop and rebuild in a new chat.**

---

## 12. MARKETING ACCURACY -- OPEN VIOLATION

**`Marketing-Notes.docx` calls GatewayGuard "a completely free, open-source
guide and helper script."** Three occurrences. ACCURACY NOTE forbids it --
"open-source" requires a public repository and an OSI licence, and this
repository is private.

Traced to the 2026-07-17 session, where the ACBL pitch email, both Positioning
Statements, the CommunityFlyer and Marketing-Notes were all identified as
needing an open-source purge -- and **none of the rewrites were done.** The
session summary claims they were; the transcript records "no and no."
**Transcript outranks summary.**

Clean elsewhere: the `password-manager.html` hit is Bitwarden, correctly
described. Hits in ProjectInstructions, WebsiteStandards and ProjectNotes are
the rule text itself. Sectigo references in older notes are ignored by standing
instruction.

**Still open. Not fixed as of 2026-08-09.**

---

## 13. WHAT CLOUD'S REVIEW CHANGED (2026-08-09)

Claude Cloud reviewed all three sync documents and returned **28 findings**
(`GatewayGuard_SyncDocsReview-2026-08-09-1635.md`). Twenty-three were applied,
two pushed back on, three were Bill's to decide.

**The observation that matters most is not any single finding.** Moving
authorship to Claude Code closed the **dead-pointer** class -- 15 of 49 dead
references settled that. But the sharpest defect Cloud found was **the
connector scope stated three different ways across three documents, including
one that contradicted its own headline four sections later.**

No filename was misremembered. No measurement was wrong.

**Authorship-by-the-party-that-can-measure does not close the
internal-consistency class** -- and because these documents cross-reference each
other far more than the old ones did, that class now has more surface area than
the one that was closed.

**Two rules follow, and they are cheap:**

1. **A volatile fact is stated in exactly ONE document.** Everything else
   points at it. Commit counts, file counts and the connector scope each have
   one home now: section 1 here, and `SyncSetupSteps` A5 respectively.
2. **`Run-DocCheck.bat` is the real answer** (SyncPlan 6c). A
   no-two-documents-state-the-same-fact check would have caught the git-state
   repetition; a scope-consistency check across the three sync documents would
   have caught the three-way disagreement. Both are mechanical and neither
   existed.

**Also worth recording:** Cloud declined to verify anything it could not check
and labelled its interface findings `inferred` rather than measured. That is
the behaviour the evidence rules ask for, and it is the reason the review is
usable.

### Tooling note, earned the same evening

`python3` fails on CGDELL -- it resolves to a Microsoft Store alias stub.
**`python` and `py` both work** (Python 3.12.10, at
`C:\Users\willi\AppData\Local\Programs\Python\Python312\`). PSScriptAnalyzer
v1.25.0 is installed, so gate 1 can run.

A session that tries `python3`, gets "Python was not found," and concludes
Python is unavailable will wrongly believe it cannot rebuild the assert-guarded
wrapper. That happened on 2026-08-09. **Absence concluded from a single check
is the same error as the `-0914` "never existed" claim**, on a different
subject.

---

## 14. THE NAMING STANDARD -- AND WHAT ELSE NEVER REACHED THE TREE

### `GatewayGuard_NamingStandard` is the serious one

It is **the source of truth for the canonical display names of all 19
settings** across the tool, the website and the guide -- rules N-01 to N-06,
the locked name table, and two named exceptions.

**Roughly 45 project files carry those names.** Cloud found a live case
mismatch on 2026-08-09: `firewall.html` uses title case against the guide
index's sentence case.

`GatewayGuard_NamingStandard-2026-08-09-1345.md` **is now in `ProjectDocs\`**
(Bill retrieved it). Before that it existed in neither Claude's reach, and
nothing defined the 19 names.

### `Run-GatewayGuard.bat` and CROSS-FILE SYNC

The launcher references its paired `.ps1` **by exact filename**, and the naming
convention renames that file on every build. CROSS-FILE SYNC exists to keep
them in step.

**The launcher has never been in Claude project knowledge**, so that check has
never been verifiable from Cloud's side. It is in the tree at
`Builds\Run-GatewayGuard.bat`, and it should reference
`W11-SecurityHardening-v3-ascii39-2026-07-30-2208.ps1`. **Verify before any
build.**

### Still absent from project knowledge

Recovered into the tree on 2026-08-09: `NamingStandard`, `SessionLog`,
`ProjectFiles_DeleteKeep`, `FutureProjects`.

Still absent from Cloud's side and low priority: `FilesCleanupList-2026-07-24-0846.docx`,
`All19_Final-2026-08-02-1820.zip` (the 19 undated HTML pages are present
instead).

### Nothing can delete from project knowledge

**No tool can do it -- not Cloud, not Claude Code.** It is manual, by Bill, in
the file panel. The SyncSetupSteps 0b-4 deletion step depends entirely on this
and this project has re-learned it more than once.

---

## 15. BANNED CLAIMS -- NOT JUST BANNED WORDS

Section 6 lists the banned *words*. These are banned **claims**, and they carry
the same force:

**"open-source" -- BANNED.** ACCURACY NOTE: it requires a public repository and
an OSI-approved licence. This repository is **private**. Use "source-visible",
"fully auditable", or "transparent, plaintext code" -- they support the same
trust argument without an easily disprovable claim.

**This ban has a live violation.** See section 12: `Marketing-Notes.docx` calls
GatewayGuard "a completely free, open-source guide and helper script", three
times. An earlier merge of this briefing dropped the ban from the rules section
**while keeping the violation section that depends on it** -- the rule and its
own open breach were separated. Caught by Cloud's review.

**"human-backed" / assisted sessions -- describe as PLANNED only.** They are
roadmap, not launch scope. This is distinct from beta-testing screen-share
sessions, which are active now.

### A transcript outranks that chat's summary

**Standing evidence rule**, not an anecdote. On 2026-07-17 the session summary
recorded that the marketing open-source rewrites were done. The transcript
records "no and no." **The rewrites were never done**, and the violation in
section 12 is the result.

When a summary and a transcript disagree, the transcript wins. It earned this
twice.
