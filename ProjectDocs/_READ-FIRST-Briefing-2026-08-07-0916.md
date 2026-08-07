<!-- Dated: 2026-08-07 09:16 ET -->
# READ FIRST -- Session Briefing
**Document Name:** _READ-FIRST-Briefing
**Last Modified:** 2026-08-07 09:16 ET
**Last Editor:** Claude Code (CGDELL)
**Purpose:** Read this before anything else at the start of every session.
**Supersedes:** `_READ-FIRST-Briefing-2026-08-06-1727.md` -- retire that file.
Its machine fleet, rules and workflow sections were correct and are carried
forward here. Its document pointers and two of its status lines were not; see
CORRECTIONS below.

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
| Everything else | `CLAUDE.md` | Before any guide or website copy |

---

## 1. CURRENT STATUS -- 2026-08-07 09:16 ET

**Active build:** ascii39 -- **NEVER FIELD RUN. No log exists.**
**Target launch:** September 1, 2026 at gatewayguard.co
**Current phase:** M365 tenant migration, website build, code-signing cert pending

**Nothing may be scoped, built or numbered as ascii40 until ascii39 has a field
log.** That is the UNRUN BUILD RULE. The migration plan once instructed exactly
that increment; it has been corrected twice now, so expect it to try again.

**Git:** 19 commits, 700 files tracked, working tree clean apart from the
deliberate holdbacks in section 5.

---

## 2. THE FOUR THINGS THAT MATTER MOST

1. **ascii39 has never been field run.** Everything downstream is blocked on it.
   It belongs on **SANDY** -- CGDELL is fully encrypted and cannot reach the
   Home-unencrypted branch that most needs testing.
2. **There is NO offsite backup. No git remote exists.** `.git` lives inside the
   project folder. Delete the folder and 19 commits go with it. A local backup
   (`C:\GatewayGuard-Backup-2026-08-06\`) and a USB copy were made 2026-08-06.
   **A GitHub remote is the outstanding fix and it is the single largest risk
   to the September 1 launch.**
3. **The project tree exists in BOTH OneDrives and they drift within hours.**
   Until SANDY3 has the business account, the rule is: **edit the personal copy
   only** (`C:\Users\willi\OneDrive\GatewayGuide`). The business copy is a
   passive backup that nobody edits. Bill's reason for keeping both: sync
   carries builds to Sandy and results back without a USB shuttle.
4. **107 files are missing from the working tree and recoverable from git.**
   19 website guide pages, 17 old builds, 62 Incoming files, the LegalZoom
   license and more. **Do not restore them until Sandy's sync is confirmed
   healthy** -- restoring into a broken sync makes one mess into two.

---

## 3. MACHINE FLEET

| Machine | Hardware | Edition | Sign-in | Encryption | OneDrive | Basis |
|---|---|---|---|---|---|---|
| **CGDELL** | Dell Latitude 5430, 32 GB | Win 11 **Pro** | Microsoft account | **Fully encrypted** | **both** | measured 2026-08-02 |
| **SANDY** | HP Notebook 17-by1955cl, 8 GB | Win 11 **Home** | Local account | **NOT encrypted** | personal only | Bill, 2026-08-06 |
| **Sandy3** | Lenovo IdeaPad, 8 GB | Win 11 **Home** | unverified | Pre-encrypted by Windows | **both** | Bill, unverified |

- **SANDY is the only unencrypted machine.** Its value for testing item 8's
  Home-unencrypted branch is spent permanently the first time encryption
  actually completes on it.
- **SANDY** needs the TP-Link Archer T2U Nano USB adapter -- the internal
  RTL8821CE Wi-Fi is a confirmed hardware failure. If there is no internet,
  check Malwarebytes filtering is set to none before suspecting the adapter.
- **SANDY's OneDrive sync was turned off**, which Bill identified as the cause
  of its red X errors. When it is turned back on it must reconcile weeks of
  changes at once and will churn. Nothing is at risk -- git, the local backup
  and the USB all hold the missing files.
- **Sandy3** touchpad is disabled in Settings; use a mouse. 290 GB free.

**Always ask which machine Bill is on before giving any machine-specific steps.**

---

## 4. WHAT CHANGED 2026-08-06 EVENING INTO 2026-08-07

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
| `Tool\Run-OneDriveSyncCheck.bat` | Read-only. Which OneDrive accounts a machine has, and whether the tree is really on disk or a cloud placeholder. **Run on SANDY and SANDY3 -- never has been.** |
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
| "GitHub as sync layer... the repo is authoritative for website files" | **No git remote exists.** Measured 2026-08-07. Either the repo is somewhere this machine cannot see, or the statement is aspirational. Settle this before relying on it |

**Uncommitted on purpose, do not sweep into a commit without asking:**
`Certificates/Banking instructions.odt`, `Certificates/MaineCommunityBank/`
(financial documents -- a commit is permanent), a stray `Documents/` folder, a
duplicate `License - Copy.docx`, and `WebSite/files (6)/` which holds an `html`
folder that may be a stray copy of the 19 guide pages.

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

| Task | Use |
|---|---|
| Documents, planning, guides, business tasks | Claude.ai (Cloud) |
| File edits, builds, git, anything touching the folder | Claude Code (terminal) |
| Governing documents and standards | The reference library both read |

**Claude Cloud cannot write to the tree.** It produces documents Bill downloads
and saves. **Claude Code can**, and should therefore never assume a document it
reads is what Cloud last produced -- check the date in the filename.

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

1. **`Run-OneDriveSyncCheck.bat` on SANDY and SANDY3** once Sandy's sync is back
   on. Read-only, and the results file syncs back on its own.
2. **ascii39 field run on SANDY** -- item 8 screens exercised, encryption NOT
   started, then `Run-CollectLogs.bat`. Unblocks everything downstream.
3. **Set up a GitHub remote.** See section 2 item 2. This is the largest
   unmitigated risk to the launch.
4. **ascii40 scope, only after the field log exists:** FT-170 (consent for the
   log folders), FT-162 (the Defender scan that has never run), and the three
   remaining "whether" strings.
5. Finish M365 Phase 1 (Sandy3), then rewrite Phase 3 -- the tree is already in
   the business OneDrive, so "move it there" as written risks propagating a
   deletion.
6. Reconfirm the business items carried from 2026-08-02, all with dates now
   passed: Maine Community Bank, SAM.gov EFT, D&B DUNS, DigiCert validation,
   LegalZoom EULA review, Google Business profile.
7. Confirm the 19 guide pages reached GitHub; confirm 17 stale HTML files
   deleted. Both were Bill's tasks and neither has been confirmed.
