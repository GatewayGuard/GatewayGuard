<!-- Dated: 2026-08-20 13:06 ET -->
# READ FIRST -- Session Briefing
**Document Name:** _READ-FIRST-Briefing
**Last Modified:** 2026-09-16 12:30 ET
**Last Editor:** Claude Code (CGDELL)
**Purpose:** Read this before anything else at the start of every session.
**Supersedes:** `_READ-FIRST-Briefing-2026-08-14-0041.md`, which by this
morning said **"Active build: ascii39"** and **"Build ascii40"** as open item 1.
The tree was on **ascii42**. Three builds stale, on the first two lines any new
session reads.

**Change History Log:**
- 2026-09-16 12:30: **LAUNCH DATE CORRECTED -- this document still said
  September 15 the day after Bill moved it to October 15.** Found by Cloud's
  09-16 response, not by this document's own reading -- exactly the
  pointer-that-lies shape this file exists to catch, caught on itself.
  Section on the target launch date rewritten; every other schedule this
  briefing carries against the old 15-Sep date is still open, same sweep
  as the 01-Sep move below.
- 2026-08-23 22:50: **THE GUIDE IS FINISHED -- status block rewritten.** It
  said ascii43 half built and nothing about the guide, which was the day's
  entire work. Packs 1 and 2 applied, every retrieval gap closed, Part H cut on
  research. **Git figures re-measured and they were badly stale** -- the table
  said 176 commits and 551 tracked files against 270 and 642, so it was 94
  commits and 91 files out, on the section that says "stated HERE ONLY".
  Open item 1 rewritten: the guide is no longer the blocker, ascii43 F6 is.
- 2026-08-22 14:10: **`Last Modified` restamped -- it said 2026-08-20 13:06
  while section 1's status block was dated 2026-08-22 13:05.** Cloud caught
  it. The `Dated:` line and the filename stay at 2026-08-20 13:06 on purpose:
  this is a cumulative document, so those two record when it was created and
  `Last Modified` records the edit. Also repointed the ascii43 field checklist
  to its 2026-08-22 filename.
- 2026-08-20 13:06: **`Run-DocCheck.bat` is built.** It was open item 11 and
  the "still a wish" line in section 5; both now say what is true. The gate
  ran on this document and found the commit count one behind the repository
  and ten dead pointers in the live set, so **the first thing it caught was
  this file.** Section 5 carries the row, its baselines and its first-run
  findings.
- 2026-08-20 11:50: **Status brought to ascii42 -- it had said ascii39 for six
  days and three builds.** Open item 1 said "Build ascii40"; ascii40, 41 and 42
  are all built and two have been field run. Item 4 (`CLAUDE-Sandy.md`) is
  **closed** -- it was an OneDrive conflict copy, not a machine variant, and it
  is removed. **New section 1a: the repository lives inside a synced OneDrive
  folder and OneDrive conflicts on git's own files.** FT-203 added to open
  items. Git figures re-measured: 176 commits, 551 tracked files, three methods
  agreeing.
- 2026-08-14 00:41: **Section 8a corrected -- it was giving an instruction
  that does not work.** It listed the steps without saying who does each, so
  it read as "Bill puts the file somewhere and syncs." Bill caught it: nothing
  triggers Claude Code to commit and push, so the file just sits there. Step 2
  -- *Bill tells Claude Code it is there* -- is now the named trigger, and
  step 5 -- the "sync now" line -- is Claude Code's obligation.
  `Tool2\build_readable_twins.py` added and run: **16 Word and PowerPoint files
  in `ProjectDocs\` now have readable twins.** 9 PDFs reported as unextractable
  (no PDF library installed) rather than silently skipped.
- 2026-08-14 00:07: **Added section 8a, THE FIVE-STEP CHAIN.** The most
  useful thing learned on 2026-08-13, and it existed only in a chat until
  now. Every step fails silently; only the first and last are visible. Step 6
  -- binaries need extraction -- defeats all five and cost sixteen days on the
  guide.
- 2026-08-13 14:33: **Full reissue.** The ascii39 crashes are not crashes --
  root cause found in the logs and the source, section 2. ascii40 is
  UNBLOCKED and its field test plan exists. Two new gates and the
  assert-guarded wrapper are committed. 262 files retired. Git counts
  re-measured with a method that does not silently drop files. Nine
  corrections to the 2026-08-11 briefing folded in rather than listed.
- 2026-08-11 16:16: The ascii39 field run started; Phase 2 captured SANDY's
  unencrypted profile; FT-167 confirmed in the field; SANDY converted to a
  local account named `panther`.
- 2026-08-09 22:39: Revised against Claude Cloud's review of the three sync
  documents (28 findings).
- 2026-08-09 14:45: Merged the Claude Code and Claude.ai briefings.

---

## 0. HOW TO FIND ANY DOCUMENT

**Read `ProjectDocs\CURRENT.md` first. That filename never changes.**

It is **generated** by `Tool2\Update-Current.ps1`, never typed, and it opens
with a freshness stamp -- generation time, commit hash, commit date, commit
subject. Reading it *is* reading the sync date. It refuses to write if any
pattern matches nothing, so it cannot publish a pointer with a hole.

**If you are Claude Code:** you may also glob and take the newest by the
**date in the filename**. Never sort by modified date -- OneDrive rewrites
those.

**If you are Claude Cloud:** you cannot glob, list, or sort a directory.
`CURRENT.md` exists because of that. Do not accept an instruction that asks
you to enumerate files -- say so and hand the measurement back. *(This was
re-learned on 2026-08-13 when Claude Code asked Cloud to list every
`CLAUDE.md`. Cloud correctly refused. The lesson had been written up the day
before and was repeated anyway.)*

### THE ONE DOCUMENTED EXCEPTION -- LegalZoomGuide

**`GatewayGuard_LegalZoomGuide-2026-07-24-0846` is CURRENT.** `-0921` was the
initial version. The update carries an **earlier** filename stamp than the
draft it replaced, so newest-by-filename-date returns the wrong file here.
This is the only known pair where the filename date lies about which is newer.

---

## 1. CURRENT STATUS -- 2026-08-23 22:50 ET

**THE GUIDE IS WRITTEN. ZERO RETRIEVAL GAPS.**
`ProjectDocs\GatewayGuard_GuideRewrite-Draft-2026-08-22-1000.md`, **1,976
lines.** Every heading has a body. Packs 1 and 2 applied 2026-08-23; the draft
is the live one and supersedes the 08-19 and 08-15 drafts, which must not be
opened.

**What still stands between it and shipping, in its own WHAT MUST HAPPEN list:**
**29 VERIFY markers, none measured on a live machine** -- two can cost a reader
their files; **page numbers** (one `page 00` in text, 19 bare `| 00 |` cells);
and **Bill's approval.**

**ORDER MATTERS AND IT IS EASY TO GET WRONG. The ascii43 field run on SANDY
must come BEFORE the encryption measurements.** SANDY is the only unencrypted
machine, its state spends permanently the first time encryption completes, and
encrypting it to settle the BitLocker VERIFY destroys the field test's starting
condition. One trip settles both only in that order.

**Part H was cut 2026-08-23, and the reasoning is worth keeping.** It told the
reader to disable Edge's MicrosoftEdgeUpdate scheduled tasks. *Sourced,
Microsoft's architecture:* those tasks are what trigger Edge's automatic update
checks; the `edgeupdate` service is only the COM server they call. The step
stopped a senior's browser patching itself. **The test the guide proposed would
have passed it wrongly** -- `edge://settings/help` drives the updater directly,
so it cannot see the unattended check stop. **A test that cannot fail is worse
than no test.**

**Active build: ascii44 -- BLOCK A COMPLETE, NOT YET FIELD RUN** --
`Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1`, **9,387 non-blank
lines / 9,775 total**. Gates 12, 12b and 24 PASS, 0 non-ASCII, 0 duplicate
functions, 10 carried oversize screens. **Next free screen ID 90.**
*(Grew 2026-09-07: FT-257, the SmartScreen check that reported "ON -- GOOD"
from a value that was not there; FT-258, the Group Policy override check, with
every key read out of Windows' own `PolicyDefinitions\*.admx`; FT-258b, the
third firewall profile.)*

**Only ONE build's figures belong in this block.** It briefly carried both
ascii43's and ascii44's on 2026-09-06 and the document gate caught it within
the minute -- section 7b exists because a fact stated twice can be
INCONSISTENT, and then nobody knows which to believe. The predecessor is named
below, without numbers; its numbers are in git and in its own commits.

**ascii43 is SPENT and retired to `Builds\`.** It was field run twice,
2026-08-26 18:07 to 2026-08-30 11:04, five logs in
`Test_Results\FieldRun-ascii43\`, triaged in two documents. **A build that
has been field run is spent -- the remaining work takes a new number.**

**Plan for ascii44:** `GatewayGuard_ascii44BuildPlan-2026-09-05-1130.md`.
Blocks A and B need no decision from Bill; C and D do.

**IN ascii44 SO FAR (Block A, eight items, one family per commit):** FT-242
nine registry writes that could not fail; FT-203 the two reminders that could
never run on battery; the Back key, `B` at five sites; FT-244 two screens the
user could not read; FT-243 the log notice moved to the review screen; FT-255
five `powercfg` parses that could never populate `$Matches`; FT-245 the
silent-error breadcrumb; screen 12's drive order.

**RAISED IN ascii44 AND DELIBERATELY NOT FIXED, each with its reason in the
build header:** **FT-254** (`Test-TimeDateSync` prints success after four
unguarded calls) and **FT-256** (`powercfg` can return no CONSOLELOCK block at
all, so the status read reports "NOT required" from a read that produced
nothing -- instrumented, not guessed at).

**NEEDS ONE LOOK ON SANDY:** screen 12's drive order. CGDELL has a single
disk, so the multi-drive ordering the change exists for cannot be observed
here.

**BUILT SO FAR, one family per commit, every edit through `gg_edit.py`:** F1
keyboard (FT-204, 206, 207, 223, 232), F2 width (FT-217/199), F3 log (FT-231),
F5 flow (FT-219 selection=approval, FT-224), F6 part (FT-221).

**NOT BUILT:** **F4 the second drive** (route 3, and its screen text is
gate-24-blocked until a full scan is measured covering `D:` **on SANDY**), the
**F5 remnants** (FT-195a, FT-175b, FT-225 -- scoped to the one inconsistent
screen), and the **F6 wording block** (~20 items + FT-222).

**Field checklist for it:** `GatewayGuard_FieldChecklist-ascii43-2026-08-26-1730.md`.
*(Corrected 2026-09-05; this line named the superseded 08-22 file, which
`CURRENT.md` has not pointed at since 08-26.)*
**Next free FT number: 238.** *(FT-237 assigned 2026-08-22: Checkup's
Advertising ID revert path names `Let apps use advertising ID`, which is a
stem, not the on-screen label. Belongs to the unbuilt F6 wording block --
see `GatewayGuard_DefectPassResponse-2026-08-22-1525.md`.)* *(FT-236 assigned 2026-08-22: the ascii43 field
checklist demanded "B is the ONLY Back key, N must never take you back",
contradicting what was then Bill's ruling that `N = go back` stays in real Y/N
questions. Cloud's point, and it is right: a checklist that contradicts a
settled decision is a defect in the checklist, not a build-scheduling fact,
so it gets a number and is fixed once instead of re-tagged every build.)*

### THE TREE MOVED, 2026-08-22 -- READ THIS BEFORE LOOKING FOR A SCRIPT

Cloud was at 89% of project-knowledge capacity, so the connector scope was cut.

- **`Tool\` now holds ONLY the current build `.ps1`.** 3.4 MB / 102 files ->
  556 KB / 1 file.
- **`Tool2\` holds every `.bat` and every helper script**, and is deliberately
  **outside** the connector scope. **Run every gate from `Tool2\`.**
- **`Builds\`** holds the superseded builds; **`Archive\ProjectDocs-Retired-2026-08-22\`**
  holds 17 files retired out of ProjectDocs (16 MB -> 2.5 MB).
- Nothing was deleted -- it was all moved, still tracked, still on disk.

**ascii41 WAS field run** -- four sessions on SANDY, **38 findings**, in
`Test_Results\Ascii41-Test-Reults-2026-08-18-1110.txt`, all triaged in
`GatewayGuard_FieldTestTriage-ascii41run1-2026-08-19.md`. **ascii42 fixed five
of the 38.** Which five, and why so few:
`GatewayGuard_ascii41Findings-FixedOrNot-2026-08-19.md`.

**The number that matters from that run: 253 screen renders, ZERO
first-encounter decreases.** FT-172's numbering scheme holds in the field.

*(Superseded 2026-08-22: the next free FT is **236** -- see the status block
above. This line said 204 and is kept only so the ascii41 paragraph above it
still reads in sequence.)*

**THE STATUS LINE IS NOT THE RULE.** On 2026-08-12 a session reported "no field
log exists" while the log sat on disk untracked, because the check asked `git`
and git was blind to it. **Look on disk.**

**Target launch:** **October 15, 2026** (Thursday) at gatewayguard.co.
**Moved by Bill on 2026-09-15 from September 15**, so the format pack and the
29 VERIFY-marker measurements (T-VF1) can land in one guide revision before
launch instead of after it -- see
`GatewayGuard_ExternalGuideReview-Comments-2026-09-15-1324.md`. **This
briefing had not caught up to that move** -- Cloud's 2026-09-16 response
found it still saying September 15 the day after the change, the same
pointer-that-lies shape flagged below for the CPM schedule and the marketing
plan's launch-week table when 01-Sep moved to 15-Sep. **Every schedule built
against 15-Sep is now wrong too**, and needs the same sweep this section
already asked for once.

### Git -- measured 2026-09-08 07:55, and stated HERE ONLY

*(Commits reads **432**: 431 was measured at 07:55, and the commit that
carries this line makes it 432. Every other figure is the 07:55 reading.
A count written before its own commit is off by one on the line whose
whole job is being right.)*

| | |
|---|---|
| Commits | **432** |
| Tracked files | **1313** |
| Unpushed | **0** |
| Untracked | 260 -- see the note below |
| Modified | 26 |
| Deleted on disk, still tracked | 20 -- see the note below |
| `.git` | **63 MB** |

**Untracked went from 43 to 258 on 2026-09-07, and none of it is a Cloud
problem.** ***Measured, grouped by folder: 188 under `Guide\Documents\Bridge`,
12 under `Certificates\Windows_SAC_10.9_R1_GA`, 21 in `Test_Results`, 19 in
`Notes`, 8 in `Migration\MB`.*** **None is committed, so none costs Cloud
anything**, and `Guide\`, `Certificates\` and `Migration\` are outside the
connector scope regardless. ***Measured: the four largest are SafeNet
Authentication Client installers totalling about 156 MB*** -- the code-signing
token software, which belongs on disk.

**Two things worth Bill's eye rather than any action here.** `Guide\Documents\
Bridge\` holds bridge (the card game) documents including a saved web page with
its `_files` folder -- **gate 26 flags exactly that shape**, and it looks like
personal material that landed in a project folder rather than anything the
guide needs. **Nothing has been moved or deleted:** these are untracked, so
they are not recoverable from git, and the standing rule is to ask first.

**The deleted count moved from 18 to 20 during the 2026-09-06 afternoon
session, and it is worth one paragraph rather than a silent edit.** Both new
ones are Malwarebytes reports of 2026-07-16, deleted from
`Test_Results\Logs\Archive\Malwarebytes_Reports\` -- the Deep Scan report of
09:54:06 and the Threat Scan report of 02:41:55.

*(Their names are written out rather than quoted as paths, because the
document gate reads a quoted filename as a pointer and correctly reports a
pointer to a file that is not there. Naming a gone file is not the same as
pointing at one.)*

***Measured: that folder's timestamp is 2026-09-06 16:21***, which is between
that session's 16:00 commit and Bill handing over a Malwarebytes report at
16:30 -- **so the likely cause is Bill in his own reports folder, finding the
file he wanted.** *inferred, not measured: nothing in the session wrote to
that folder.*

**Both are committed, so both are recoverable in one command:**

```
git checkout -- "Test_Results/Logs/Archive/Malwarebytes_Reports/"
```

**They were deliberately NOT restored.** The other 18 are Bill's folder
reorganisation, and quietly putting files back would fight a tidy-up he
meant to do. **Recoverable and recorded beats restored and unasked-for.**

*(Measured 2026-09-06 15:55. The previous figures were taken 2026-08-23 and
had gone 132 commits and 593 files stale -- on the table that says "stated
HERE ONLY". Re-measure it, do not carry it forward.)*

**The tracked-file count was taken three ways and all three agree** --
`ls-files`, `ls-files -z`, and `ls-tree -r HEAD` each return **1,258**.

> **The block that stood here disagreed with itself.** The table said 642
> tracked files and the paragraph directly beneath it said all three methods
> "each return 551". **Two different numbers, four lines apart, in the section
> that exists to be the single source for them.** Neither was right by
> 2026-09-05. That is why the figures are re-measured at session end rather
> than carried, and why the three-way check is quoted with the number it
> actually returned.

**The 18 deletions are folder moves, and none is a loss.** `MB\` is now
untracked `Migration\MB\`; `Presentation\` is tracked at
`ProjectDocs\Presentation\`; `Run_Comments\` matches
`Archive\ToolRunComments-Retired-2026-09-04\`. **`Recovery Keys\Recovery
Keys.txt` has no copy on disk** -- and ***measured: it is 13 bytes in HEAD and
contains only the words "Recovery Keys", no keys.*** Same empty shell as the
one retired on 09-04. Every one is recoverable from the last commit.

---

## 1a. THE REPOSITORY LIVES INSIDE ONEDRIVE, AND ONEDRIVE FIGHTS GIT

**Found 2026-08-20 while chasing a file that vanished.** All **1,441 items
under `.git`** carry the ReparsePoint attribute -- OneDrive manages every one of
git's internal files as a cloud item and replicates them to SANDY. It had
already written **seven conflict copies**, including `index`, `config`, and
**both references to `main`**.

**This does not need anyone to run git on the second machine, and Bill never
has.** Five of the seven were stamped **2026-08-09 14:39:27** -- the same second
as commit `094743b`, made on CGDELL -- and they are exactly the five files a
single `git commit` rewrites. **One commit here is enough.**

**So "only run git on one machine" is not a mitigation.** It was already true
and prevented nothing. **The mitigation that works is the remote:** every commit
is pushed the same day, so a damaged `.git` is a re-clone and nothing is lost.

**Nothing was damaged** -- `fsck` reports dangling objects only, and
`main-Sandy` pointed at an *ancestor* of `main`. **What was missing was anything
that would notice.** They sat unread eleven days, and two had been committed:
`CLAUDE-Sandy.md`, a stale snapshot of the governing instructions in the
repository root **where Cloud reads it**, and `.claude\rules\website-copy-Sandy.md`,
an entire stale rule in the folder Claude Code loads rules from. All are gone.

**`Tool2\Run-RepoHealthCheck.bat` is now step 8 of the Cloud handoff in
CLAUDE.md** -- fsck damage, new conflict copies, unpushed count. It reports ALL
CLEAR as of 2026-08-20. **Run it at session end.** A guard nobody runs is a
wish.

**A measurement caution earned today.** Three different size figures were
reported during this session (41.19, 31.99, 22.9 MB) because the methods used
`xargs`/PowerShell loops that **silently dropped files whose names contain
special characters**. The 42.3 MB figure comes from a method verified to see
all 444 files with 0 missing, and the count was confirmed three ways
(`ls-files`, `ls-files -z`, `ls-tree -r HEAD`). **A size figure with no stated
method is not a measurement.**

**GitHub limits are not in play.** 29 MB against a 1 GB recommendation; largest
tracked file 7.07 MB against a 100 MB hard limit. There is **no limit on the
number of commits or pushes.** The limit this project has actually collided
with is **Cloud's project-knowledge capacity**, which reads the working tree,
not `.git`.

**Deleting files does not shrink `.git`.** Blobs stay in history. Retirement is
for tidiness and for Cloud, never for size.

---

## 2. THE MOST IMPORTANT THING IN THIS DOCUMENT -- CHECKUP NEVER CRASHED

ascii39 field findings 14, 15 and 39 report the program crashing or vanishing.
**The logs show no crash.** Each ended through Checkup's own code path after
accepting an input event nobody sent.

`GatewayGuard-Log-2026-08-11_17-46.txt`, three lines inside one second:

```
[17:50:08] [SCREEN] [SCREEN-31] Rendered: QUICK RE-CHECK BEFORE RESUMING
[17:50:08] [KEY] Key 'N' accepted at: Show-ResumeReverify
[17:50:08] [EXIT] Resume re-check: user said not personal PC -- exit
```

**Two mechanisms, both in the source:**

1. **`Clear-PendingKeys` line 2487 caps its drain at 256 and then logs 256 as
   a count.** *"Discarded 256 keypress(es) that were already queued"* actually
   means **the drain hit its own ceiling and stopped with events still
   queued** -- and the next read consumes one. Eleven cap-hits in that run.
2. **`Disable-QuickEdit` line 2318 masks with `-band 4294967231`**, clearing
   QuickEdit and **leaving `ENABLE_MOUSE_INPUT` set**. **measured:** on the
   Windows default mode `0x01F7`, mouse input survives. Every mouse move,
   click and wheel tick becomes a record in the same 256-record buffer the
   tool reads answers from. **That is why right-click ended it.**

It also explains field finding 30, previously unexplainable: the 22-10 log
holds **~25 "the window's X was clicked" exits in 49 seconds.**

**There is no wheel-versus-safety trade-off.** `SetConsoleMode` documents the
flag as controlling whether mouse events are *"reported in the input buffer or
discarded"* -- delivery to the **application**. Wheel scrolling of the window
belongs to the console host. And the build **never reads a mouse event** --
zero uses of `ReadConsoleInput` or `MOUSE_EVENT` -- **re-measured on ascii42,
2026-08-20: still 0 and 0.** Clear the flag, fix the drain, and stop letting one
keystroke end the session.

**Before any build, run `Tool2\Run-ConsoleInputModeCheck.bat` ON SANDY.**
Read-only. CGDELL did not fail, so measuring CGDELL proves nothing. **The two
machines differ in the way that matters: SANDY is conhost, CGDELL is Windows
Terminal** (measured, `MarkModeReset-SANDY-2026-08-19_18-14.txt`,
`WT_SESSION: False`). A probe written for one console does not answer the other,
which cost a round trip on 2026-08-19.

---

## 3. THE FIVE THINGS THAT MATTER MOST

1. **Fix FT-171 (the input queue) first.** Nothing else can be tested
   reliably until it is done, because any test can be ended by a stray event
   and written up as a crash. It already cost one whole field run's
   confidence.
2. **The assert-guarded Python wrapper now EXISTS and is COMMITTED** --
   `Tool2\gg_edit.py`, with `Run-GGEditSelfTest.bat`. It was a named ascii40
   blocker and had been missing since the ascii37 wrappers were lost
   uncommitted. **Every `.ps1` build edit goes through it. No cosmetic
   exemption.**
3. **The offsite backup is `GatewayGuard/GatewayGuard`**, private, org-owned.
   Push at the end of any session producing work worth keeping. Recovery is
   `git clone`, or `git checkout <commit> -- <path>` for one file.
4. **ONE working tree:**
   `C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\`
   The root **contains a space**; quote it everywhere. Other copies exist at
   `C:\GG-Backup\GatewayGuide`, `C:\GatewaayGuardBackup\GatewayGuide` (note
   the typo), `C:\GatewayGuard-Backup-2026-08-06` -- **none are sources**.
   **When two copies disagree, the remote decides.**
5. **The tree's SHAPE can change without anyone noticing.** Stray
   drag-and-drop in File Explorer has moved `ProjectDocs\` and `WebSite\`
   before, with no confirmation and no undo prompt. **`git status` reports it
   instantly. Run it at session start.**

---

## 4. MACHINE FLEET

| Machine | Hardware | Edition | Windows sign-in | Encryption | Basis |
|---|---|---|---|---|---|
| **CGDELL** | Dell Latitude 5430, 32 GB | Win 11 **Pro** | Microsoft account | **Fully encrypted** | measured 2026-08-02 |
| **SANDY** | HP 17-by1955cl, 8 GB | Win 11 **Home** | **Local account `panther`** | **NOT encrypted** (`C:` and `D:`) | measured 2026-08-11 |
| **Sandy3** | Lenovo IdeaPad, 8 GB | Win 11 **Home** | unverified | **Fully encrypted** | measured 2026-08-08 |

- **SANDY is the only unencrypted machine** and the only one that reaches the
  Home + unencrypted + local-account branch. **Its value is spent permanently
  the first time encryption completes on it.**
- **SANDY carries a second fixed drive `D:`, 931.5 GB, fully decrypted.**
  Checkup reads only `C:`. That is **FT-167**, confirmed on screen by field
  finding 13.
- **CGDELL Service Tag `9WPZTT3`**, local account `CGAdmin`, Autologon64
  configured deliberately for resume testing.
- **SANDY needs the TP-Link Archer T2U Nano USB adapter** -- the internal
  RTL8821CE Wi-Fi is a confirmed hardware failure.
- **Sandy3's touchpad is disabled in Settings; use a mouse.**
- **Folder backup is OFF on SANDY and SANDY3. Leave it off.**
- **Before any field run, right-click the project folder on SANDY and choose
  "Always keep on this device"** -- files in it are cloud placeholders and
  SANDY has no internet without the adapter. Counted 307 of 1,110 before the
  ascii40 run; not re-counted since.

### Adding OneDrive personal to SANDY -- safe, with one condition

**A Microsoft account in the OneDrive APP does not change the Windows
sign-in.** `panther` stays local. The documented Device Encryption trigger is a
Microsoft account at **OOBE on a clean install**; an in-place upgrade does not
flip it. SANDY already sat on a full Microsoft *Windows* account for over a
week, through reboots, with Modern Standby, and nothing engaged.

**The condition: decline the folder-backup prompt** (Desktop, Documents,
Pictures). That is the screen that merges three PCs' Documents into one cloud
folder. Also decline any "sign in to all your apps / use this account
everywhere" offer -- that one *would* attach the account to Windows.

Verify after with **Settings › Accounts › Your info** (should read "Local
account") and `Tool2\Run-OneDriveSyncCheck.bat`.

---

## 5. THE GATES -- WHAT RUNS, AND WHAT IS STILL A WISH

**Every rule that held on 2026-08-13 had machinery. Every rule broken was one
someone had to remember.** That is the strongest argument in this document.

| Gate | Launcher | Checks |
|---|---|---|
| **12 / 12b** | `Run-ScreenCoverageCheck.bat` | unique screen IDs; 26-line ratchet |
| **24** | `Run-ExternalCommandCheck.bat` | every external command carries VERIFIED evidence |
| **25** | `Run-CopyCheck.bat` | **NEW** -- banned words, superlatives, open-source ban, Checkup name rule, across tool AND website in one pass |
| wrapper | `Run-GGEditSelfTest.bat` | **NEW** -- proves all four `gg_edit.py` guards fire |
| input mode | `Run-ConsoleInputModeCheck.bat` | **NEW** -- FT-171 diagnosis, run on SANDY |
| documents | `Run-DocCheck.bat` | **NEW** -- SyncPlan 6c's five checks: volatile facts, dead pointers, filename vs `Dated:`, one live copy, content stamp |
| `.ps1` integrity | automatic hook | parse errors, line count, brace balance |

**`Run-DocCheck.bat` was built 2026-08-20** and this row replaces the "still a
wish" line that stood here -- named on 2026-08-09, unbuilt for eleven days,
during which this document sat three builds stale on its own first line.
**Run it at session end, beside `Run-RepoHealthCheck.bat`.**

**It reads the live filenames out of `CURRENT.md` and never carries its own
list**, because a checker with a hand-kept set of filenames would be the exact
failure it exists to catch. Sections 2 and 4 run as a **ratchet** with the
baseline measured on the day it was built -- 10 dead pointers in the live
documents, 52 across all of `ProjectDocs\`, 1 date mismatch, 4 document
families with no anchor. Going above a baseline fails the run. **The numbers
are only ever allowed to go down.**

**What it found on its first run:** section 1 said this briefing's commit count
was one behind the repository, and the dead-pointer list is led by the SANDY
log for 21:08 on 2026-08-19 -- the evidence for open item 1's first bullet,
never collected off that machine and so unreadable from here.

**It then caught two more that were ten minutes old, both mine**, written into
this section while recording the gate: that log named a second time, and a
filename typed without its `GatewayGuard_` prefix. **A checker that finds
nothing on the day it is built has usually been fitted to the ground it was
built on.**

**Still a wish:** **H-4**, the guide-wording gate, which is human-only and
**has never been run.**

**Gate 25 found FT-183 on its first run:** on **16 of the 19 guide pages the
only "GatewayGuard Checkup" is inside the `<meta description>`** -- the reader
meets "Checkup" without ever being introduced to it. A careful human read and
a raw grep had both called those pages compliant.

---

## 6. RULES MOST OFTEN BROKEN -- CHECK YOURSELF AGAINST THESE

**Evidence.** Label every factual claim **measured / sourced / inferred /
guess**. Only *measured* and *sourced* may enter the tool or user-facing copy.
**A capability claim about a reader is a factual claim too**, and so is a
Windows API's behaviour -- both were asserted unread on 2026-08-13.

**Command flags are factual claims.** Gate 24, earned by FT-162:
`MpCmdRun.exe -ScanType 4` does not exist, returned `0x80070667` in 0.0
seconds, and the log printed `[GOOD]` for months.

**A matcher that has not been proved on a control produces absences, not
findings.** This appeared **three times on 2026-08-13 alone**: tag-stripping
that fused two words into a double space and undercounted 19 to 3; comment
stripping that deleted the suppression markers it was meant to honour; and a
line-by-line grep reporting two rules "missing" that were merely wrapped
across a newline. **Run the control first. Gate 25 exits 2 if any matcher
cannot match its own control.**

**Never paste a command into chat for Bill to run. Write a `.ps1` and a paired
`.bat`.** Measured record: 3 pasted, 3 mangled by line wrapping; 3 shipped as
files, 3 ran first time. Launchers use `cd /d "%~dp0"`, are CRLF, **never
self-elevate**, and end with an Enter-only wait.

**Naming.** First mention **GatewayGuard Checkup**, thereafter **Checkup**.
Never rename the MachineID salt `"GatewayGuard|"`, the Task Scheduler task
names, `C:\GatewayGuard\`, `Run-GatewayGuard.bat`, `gatewayguard.co`, or the
LLC.

**Banned in all user-facing copy:** "whether", "whereas", and "switch" as a
verb for a setting. **The powering-on exemption is withdrawn** -- the verb rule
is unconditional; only the noun survives.

**Unverified superlatives are banned, and sourcing beats softening.** Two
website claims were not merely unsourced but **wrong**, and the right source
was the one matching the audience -- FBI IC3 and FTC for seniors at home, not
the Verizon DBIR, which counts enterprise breaches.

**Do NOT sweep a banned phrase blindly.** `ExpertPositioning` says
*"GatewayGuard is not open-source"* -- that is the rule, not a breach. Twenty
of the 23 open-source hits in ProjectNotes are third-party tools or the record
of the licensing decision. **An unqualified sweep is what wrote "an expensive"
over "free" in `Marketing-Notes.md`.**

**Act, then report. Do not ask.** The undo line replaces permission and
survives the session. Ask only for: two real paths where the choice is Bill's;
deleting anything **unrecoverable** (untracked, or tracked with uncommitted
changes -- "committed" is the test, not "tracked"); force push and history
rewrite; and work outside the stated task.

---

## 7. THE TWO CLAUDES -- WHO DOES WHAT

| Task | Who |
|---|---|
| **ALL governing documents** | **Claude Code** |
| File edits, builds, git, anything touching the folder | Claude Code |
| Business, legal, licensing, marketing, FAQ, presentations | Claude Cloud |
| **Reviewing** a document Claude Code produced | Claude Cloud |
| Field tests, machine settings, approvals, the Sync click | Bill |

**Claude Code authors governing documents** because it is the only party that
can check a claim before writing it down. **Cloud must not** author or revise
one, write an exact filename into anything filed, or state machine state,
build numbers, line counts or test results from memory.

**But Cloud reviews well, and twice on 2026-08-13 it was right and Claude Code
was wrong:** it caught the source pack claiming the open-source violation was
closed repository-wide when it was closed only in one file, and it correctly
refused an instruction to enumerate files.

**Cloud cannot write to the tree.** Anything it produces must be downloaded by
Bill and committed by Claude Code. **If a decision exists only in a chat, say
so:** *"this is in chat only, not yet filed in [filename]."*

**RETIRED 2026-08-23. Marketing is NOT handed over via a paste block any
more -- it is handed over the way everything else is: as documents in
`ProjectDocs\` that Cloud opens itself, named in `CURRENT.md`.**

**Why it went.** `Marketing-For-Cloud.txt` sat untouched from 2026-08-13 while
the marketing plan, its amendment, the pricing copy and the source pack all
landed in `ProjectDocs\` and were named in `CURRENT.md`. **A paste block that
restates documents Cloud can already open is a second copy that can go stale --
and ten days on, it had.** Moved to `Archive\Root-Retired-2026-08-23\`.

**The rule this leaves.** Anything Cloud must READ goes in `ProjectDocs\` and
gets a `CURRENT.md` row. **The repository root is OUTSIDE the connector scope,
so a file there is invisible to Cloud and no sync will ever fix that** -- Cloud
proved it on 2026-08-23 by searching three ways for a root file and correctly
reporting that it could not be opened. **`Start-Claude-Cloud.txt` is the one
file that belongs at the root**, because it is what Bill pastes to BEGIN a
chat, before Cloud can read anything at all.

*(Superseded text: marketing was handed over via `Marketing-For-Cloud.txt` at the repository
root -- a paste block with copy markers, opening with SYNC NOW and a freshness
check. Its source material is
`ProjectDocs\GatewayGuard_MarketingSourcePack-*.md`, **generated** by
`Tool2\build_marketing_sourcepack.py`, because `Marketing\` and `Presentation\`
are **not in connector scope** and adding them would cost capacity for 9.3 MB
of saved-webpage junk.

---

## 8. THE CONNECTOR -- WHAT IT ACTUALLY IS

**Settled by Anthropic support, 2026-08-12, after four wrong diagnoses in one
day:**

- The GitHub connector **exposes no live repository tool.**
- It **syncs selected files into project knowledge.**
- **THE SYNC IS MANUAL.** Nothing in the interface says so.
- **There is no documented way to see which commit a snapshot reflects.**

**Scope is `ProjectDocs/`, `Tool/`, `WebSite/Rules/` and `CLAUDE.md`** -- and
that last one is a **single named file, not a pattern**, so a nested
`CLAUDE.md` is invisible to Cloud whether it exists or not.

**A6-PRE: a connector proof must test a file written AFTER the last proof.**
The 2026-08-11 proof passed against an index frozen at `212fb8e`, thirty
commits behind, and could not have failed -- all three of its targets predated
the freeze.

**The capacity meter is not evidence.** It read 1% while the connector was
fully loaded and answering correctly.

**Unresolved:** whether a re-sync **removes** deleted files from project
knowledge. 262 files were retired on 2026-08-13. Test with a **content probe
on a file changed that day** -- never by asking Cloud to enumerate.

---

## 8a. HOW A FILE ACTUALLY REACHES CLOUD -- AND WHO DOES EACH STEP

**Every step fails SILENTLY. Cloud sees a file only after ALL of them, and
there is no partial credit.**

```
1. Put the file in ProjectDocs\    BILL.  OneDrive syncs it. Cloud sees NOTHING.
2. Tell Claude Code it is there    BILL.  THE TRIGGER. Nothing follows without it.
3. add / commit / push             CLAUDE CODE. Verified, never assumed.
4. Generate a .md twin if binary   CLAUDE CODE. A push without it is not done.
5. "committed and pushed -- sync"  CLAUDE CODE. Bill's only cue.
6. Click SYNC NOW                  BILL.
```

**The earlier version of this list left out step 2**, so it read as *"Bill puts
the file somewhere and syncs."* **That is false.** Claude Code has to commit and
push in between, and nothing was triggering it -- a file can sit in
`ProjectDocs\` indefinitely while everyone believes the job is done. Bill
caught it: *"you haven't added via git, or committed it, or pushed it yet, and
Claude Cloud has proved he does not see it unless you have."*

**Step 2 is the fix.** One line -- *"I put X in ProjectDocs"* -- and the rest
follows. Claude Code also checks the four Cloud folders at session start and
end, but that is a safety net for a forgotten file, **not a substitute for the
trigger.**

**A file sitting in the folder is not in the repo.** OneDrive syncs the
folder; the connector syncs the repo; **only the repo reaches Cloud.** Nothing
in either interface tells you which of these steps has happened.

**Each step has already failed here at least once:**

| Step missed | What it looked like | When |
|---|---|---|
| 2-4 | Five guide PDFs invisible to Cloud | untracked until 2026-08-09 |
| 2-4 | 99 files untracked, nobody had decided that | 2026-08-12 |
| 2-4 | Field logs arrive untracked, so `git` cannot see them and a session reports "no field log exists" | 2026-08-12 |
| 5 | Connector index frozen **thirty commits behind** while answering confidently | 2026-08-12 |

### STEP 6, AND IT DEFEATS ALL FIVE

```
6. Is it .docx / .pdf / .pptx?     Then Cloud STILL cannot read it.
                                   Extract the text to .md in ProjectDocs\.
```

**measured 2026-08-13, a controlled result** -- one document, two formats,
same folder, same connector scope, same commit:

| File | Cloud |
|---|---|
| `ProjectDocs/GatewayGuard_MarketResearch.docx` | **never surfaces** |
| `ProjectDocs/GatewayGuard_MarketResearch.md` | surfaces immediately |

Across roughly a dozen searches Cloud has never returned a `.docx` source
path. `windows_security_walkthrough_guide_v9.docx` was committed and pushed
**sixteen days** before this was noticed, and was invisible the whole time.

**So a binary can pass all five steps and still be unreadable.** Committing
harder does not help. Extraction does.

**The fix is already built and proven twice:**
`Tool2\build_marketing_sourcepack.py` and `Tool2\build_guide_sourcepack.py`
both generate a `.md` into `ProjectDocs\`, and Cloud read each within the
hour. **Keep the binary for safekeeping -- git stores and versions it
perfectly well; it simply cannot diff it -- and generate the `.md` for
working.**

*Anthropic's connector documentation gives no file-type list either way, so
"binaries are not indexed" is **inferred**, not settled. The MarketResearch
pair is the clean case to take to support if you want it established.*

---

## 9. PROJECT KNOWLEDGE IS NOT A BACKUP

| Class | Condition |
|---|---|
| `.md` `.txt` `.ps1` `.html` | Byte-exact. Faithful. |
| `.docx` `.odt` | **Plain UTF-8 text extractions.** Word will not open them. |
| `.pdf` | **Zip bundles of page JPEGs plus OCR text.** No reader opens them. |

**Check the signature before trusting a harvested file.** A real PDF starts
`%PDF`; a real `.docx` starts `PK`. **Two files failed this test on
2026-08-13** -- `PCSafetyChecklist.pdf` and `LocalCommunityWorkshopPlan.pdf`,
both exactly 101,737 bytes, both `PK`-headed with no `%%EOF`. Both deleted;
the real documents survive under hyphenated names.

---

## 10. OPEN ITEMS, IN ORDER

0aa. **A QUESTION BILL PUT TO BOTH CLAUDES, 2026-09-07: SHOULD MALWAREBYTES
   COME OUT OF THE PROJECT?** His words: *"with your write up the summary of
   our av testing findings ask yourself and cloud if you think we should
   delete malwarebytes from our project."*
   **Everything needed to answer is in
   `ProjectDocs\GatewayGuard_AVTestFindings-2026-09-07-1808.md`** — what was
   tested, the four runs, the control that makes them mean anything, and an
   honest section on the limits.
   **Claude Code's answer, revised after reading Cloud's own research: TAKE IT
   OUT OF THE TOOL, KEEP IT IN THE GUIDE** as an optional second opinion --
   which is Cloud's own fallback, reached independently and then confirmed by
   Bill's own steer at the close of the session: *"the important thing is the
   user and providing them with easy way to do things."*
   **The two measurements it rests on, and they cut opposite ways:**
   ***measured 2026-09-07, Defender objected to none of six real unwanted
   programs across four runs, with its scanner proven working three separate
   ways*** — so Malwarebytes is doing real work on PUPs; and *sourced, Cloud
   from AV-Comparatives Feb–May 2026*, **Defender is ADVANCED+ while
   Malwarebytes Premium was downgraded for above-average false positives** —
   so on malware it is Defender that is ahead. **Out of the tool, into the
   guide is the only answer that keeps the first and respects the second while
   reducing what the senior has to do.**
   **MY FIRST ANSWER WAS "KEEP IT", WRITTEN WITHOUT READING
   `GatewayGuard_CloudResearch-ascii43-2026-09-05-0018.md`** — two days old,
   same question, sourced lab evidence, and a **pre-registered decision rule**
   naming the exact test. Bill had to point me at his own repository. That
   failure is recorded in the findings document, section 6a.
   **CLOUD: answer section 7 in a new dated document in `ProjectDocs\`, and
   say where you disagree.**
   **THE MISSING HALF WAS RUN 2026-09-08 AND THE RULE IS NOW FULLY MET.**
   ***Measured, Malwarebytes Free 5.6.5.306 on CGDELL, same twelve files:
   6 of 6 PUPs found, every hash matching the staged file -- and 5 of 6 EICAR
   placements, MISSING the alternate data stream that Defender found.*** So
   each product caught something the other missed, on one machine, a day
   apart. **Run 2 the same morning, as administrator, settled the caveat:**
   ***memory and startup enabled, 124,720 objects against 12, same 11
   detections, stream missed again -- and rootkit scanning could NOT be
   enabled, because Malwarebytes offers it only on a whole drive, never on a
   folder.*** **That is a second finding and it matters more to our customer
   than the first: "scan this folder" is always Malwarebytes' weaker scan, and
   the user is not told.** Section 3b has both tables.
   *(The paragraph below is kept for the record of what was outstanding.)*
   **BEFORE ANY DECISION, ONE THING WAS MISSING AND IT WAS FIVE MINUTES OF
   BILL'S TIME.** ***The Malwarebytes half was never run on CGDELL*** — that
   result is from 2026-07-19 on SANDY, same six files confirmed by hash, but
   a different machine and definitions two months old. **The six specimens
   are staged at `C:\AVTestKit\07_pua` right now.** One Malwarebytes custom
   scan of that folder, quarantining nothing, then
   `Tool2\Run-MBScanResult.bat` reads its answer.

0. **THE CHEAPEST UNBLOCK ON THE BOARD IS ONE WORD FROM BILL.** The `.html`
   copy pass -- items 2, 3, 6, 8, 13, 18, 19 and 21, across all 19 pages --
   is held until Bill picks one of three phrasings for item 2. They are in
   `GatewayGuard_HtmlWebsiteReview-2026-08-22-2220.md`; **the recommendation is
   option 2**, because it carries a second sentence for the two settings
   Checkup cannot change and so cannot reproduce the Tamper Protection defect.
   **Eleven of 19 pages have their factual (A) items built.** *(Corrected
   2026-09-05: this said the copy pass had been done on ZERO pages. It is
   **complete on all 19**, and* ***measured 2026-09-05:*** *the pages pass
   every mechanical rule -- no banned words, no "switch" as a verb, no
   `.com`, no v3.0. The three remaining uses of "switch" are the allowed
   noun.)*

0a. **CLOSED 2026-09-04.** *(This item read "A PURCHASE PAGE PROMISES WHAT
   THE PRODUCT CANNOT DO" -- the pricing section said the annual update
   "scans your drives again", which ascii43 cannot do.* ***Measured
   2026-09-05, the live file:*** *it now reads "can start a Microsoft Defender
   offline scan while it is there -- the same one it offers the first time you
   run it, and only if you say yes." That is supportable and approval-gated.
   The paragraph below is kept for the reasoning, which still governs any
   future claim on that page.)*

   The old text, for the record: the pricing section
   `WebSite\html\GatewayGuard_PricingSectionHtml-2026-08-23-1816.html`
   said the annual update *"scans your drives again"*. **Measured against
   ascii43: zero second-drive handling, and `Start-MpWDOScan` has no scope
   parameter. Checkup reads `C:` only** -- FT-167. This is the Tamper
   Protection shape on the page that takes the money. It is left as received
   because the honest fix waits on F4's measurement.

1. **BUILD ascii44, then field-run it on SANDY.** *(Updated 2026-09-05. This
   item said "FINISH ascii43" and that is now wrong: **ascii43 was field run
   twice**, 2026-08-26 to 2026-08-30, five logs in
   `Test_Results\FieldRun-ascii43\` and two triage documents. A build that has
   been field run is spent -- the remaining work takes a new number. Bill
   caught this: "hope you mean ascii44.")*
   *(Updated 2026-08-23. The
   guide is no longer the blocker -- it is written, see section 1. **F6 is the
   block to do**: the biggest, entirely unblocked, and pure wording.)*
 *(Updated 2026-08-22.
   ascii42 WAS field run on 2026-08-21 -- 32 findings, FT-204 to FT-235, all
   triaged. ascii43 is half built; see the status block in section 1 for what
   is in and what is not.)* What remains:
   - **F4, the second drive.** Route 3 -- Checkup covers the other drives.
     Its screen text is **gate-24-blocked** until a full scan is measured
     actually covering `D:` **on SANDY** -- CGDELL has no large second drive.
     *measured 2026-08-21: `Start-MpWDOScan` has no scope parameter at all, so
     `D:` coverage comes from `Start-MpScan -ScanType FullScan`, a full ONLINE
     scan. The wording must say "full scan of all your drives", never
     "offline scan".*
   - **F5 remnants** -- FT-195a, FT-175b, and FT-225 scoped to the one
     genuinely inconsistent screen. **The parenthetical that stood here --
     "Bill's call: `N = go back` stays as the natural answer in real Y/N/S
     questions" -- is WITHDRAWN.** Bill reversed it 2026-08-30: *"N always
     means no and B should always be used to say back."* FT-236 is
     withdrawn on its premise; the build moves, not the checklist. **7
     prompts change in ascii44**; the 11 `N = exit` sites wait on the `X`
     decision. See `CLAUDE.md` under Product Rules and triage Part 5.
   - **F6 wording block** -- ~20 items plus FT-222.
   - **FT-220 is ascii44, not ascii43** -- it waits on the guide (W-07).

   The older ascii43 content, still valid:
   - **The gallery froze for one minute at startup on SANDY**, logged as FT-63
     Mark mode in `GatewayGuard-Log-2026-08-19_21-08.txt`. It is what left Bill
     at a dead console pressing keys, and it is the upstream cause of a deleted
     file. A finding in its own right.
   - **FT-203** -- both scheduled reminders carry
     `DisallowStartIfOnBatteries = True` and `StartWhenAvailable = False`, so on
     a laptop on battery they **never run and are never shown afterwards**,
     while the log writes `[GOOD] Scheduled task created`. Measured, with the
     fix and one product decision, in
     `ProjectDocs\GatewayGuard_ScheduledTaskDefects-2026-08-20.md`.
   - **FT-184** (something flashes before screen 1, unlocated after three
     builds), **FT-195(a)** (`1a` renders before `1`), **FT-192**, **FT-197**,
     **FT-198**, **FT-199**.
   - **The ~20 wording and screen-splitting findings** from the ascii41 run --
     findings 3-8, 12-14, 16, 19-21, 23, 28-31, 37. **The largest remaining
     block, and none of it is blocked on anything.**
2. **`Marketing-Notes.md` is corrupted** -- 9 × "an expensive" written over
   "free" by a find-and-replace that ran **before the file reached git**
   (traced to the initial commit, 2026-07-28). Orphaned `*ee` fragment,
   mangled `** **` markup, and the flyer advertising *"an expensive personal
   PC security guide"* three lines above *"100% Free"*. **Do not quote pricing
   wording out of it until repaired.**
3. **3 live open-source violations remain** in
   `GatewayGuard_ProjectNotes-2026-08-09-1435.md`, lines 2547, 2741, 3006.
   **Do not touch the other 20 hits.**
4. **CLOSED 2026-08-20. `CLAUDE-Sandy.md` was neither a machine variant nor
   drift -- it was an OneDrive conflict copy**, and so was
   `.claude\rules\website-copy-Sandy.md`. Both are removed, along with five more
   inside `.git`. See section 1a. **The open question was the wrong question:**
   it asked Bill to choose between two explanations when a third had never been
   considered, and the answer was on disk the whole time in the form of five
   more copies with the same suffix.
5. **Two `W11-...ascii33-2026-07-19.ps1` files, same name, different
   contents** -- `Builds\` (5,497 lines, FT-113, carries an **ascii34** comment
   block dated 2026-07-25) and `ProjectDocs\` (5,425 lines, FT-105). **The
   `Builds\` copy is a documented recovery point and is not what its filename
   says.**
6. **Personal identity documents in `Certificates\`** -- 10.6 MB of licence
   photographs plus a utility bill, **permanent in git history**. `.gitignore`
   excludes banking and medical, not identity. Never a decision.
7. **20 held files** -- untracked and byte-unique, kept because deleting them
   would be permanent on a premise that turned out false. Bill's decision.
8. **63 remaining duplicate files**, of which 19 pairs are deliberate
   (`WebSite\html` vs the `-1820` delivered artifact).
9. **H-2, H-3, H-4 outstanding** on the 19 guide pages. H-1 passes; gate 25
   reports 0 breaches. **H-4 has never been run** and is the only gate that
   protects meaning.
10. **Upload the 19 guide pages.** `gatewayguard.co` has shown UNDER
    CONSTRUCTION since 2026-07-21. `WebSite\html\` is the one deploy copy.
11. **CLOSED 2026-08-20. `Run-DocCheck.bat` is built, run and committed** --
    `Tool2\Check-Docs-2026-08-20.ps1` behind it. Section 5 carries the row and
    the baselines. What remains open is not the gate but **the four findings it
    reports**: the 10 dead pointers in the live documents (7 of them in
    ProjectInstructions alone), the 4 document families with several copies and
    nothing saying which is live,
    `GatewayGuard_TestHistory-ascii39-2026-08-02-1335.md`
    whose header says 11:16 against a filename saying 1335, and the content
    stamp of 6c's last item, which is **still not adopted** -- 0 of 6 live
    documents carry one.
12. **Business:** Maine Community Bank **checking** account (the qualifying
    account for DigiCert, must be named explicitly in the bank letter);
    SAM.gov EFT; D&B DUNS; DigiCert validation; six open LegalZoom licence
    decisions and two attorney follow-ups; Google Business profile; guide
    rewrite from v9; batch 2 website pages. **Gumroad for all sales
    (decided 2026-08-09).**

    **TWO OF THESE CLOSED 2026-08-22** --
    `GatewayGuard_Decisions-RefundAndTerms-2026-08-22-1510.md`:
    - **Refunds: 30 days, no questions asked.** This was the ONLY genuine
      store-opening blocker. *Sourced:* "no refunds" was never available --
      Gumroad refunds at its own discretion within 90 days and card networks
      allow chargebacks regardless, so a restrictive policy converts refunds
      into chargebacks and risks account suspension. **Bill still has to set
      the Gumroad account setting to 30** -- it is account-wide.
    - **Annual updates only. Multi-year pre-pay dropped.** $12.99 / $22.99 /
      $32.99 / $51.99 for 1 / 3 / 5 / 10 PCs. The "10% per year" question is
      **removed, not answered** -- there are no multi-year terms, so there is
      no discount rule. `PricingCopy` section 5 never publishes.

    **Annual Updates pricing is CLOSED** -- locked 2026-08-21, and this line
    said "still open" for a day after that. **Still open: the multi-PC licence
    TERMS** (not the prices), and **how a buyer receives and pays for a yearly
    update at all** -- `FP-21`, the larger hole.

---

## 11. BANNED CLAIMS

**"open-source" -- BANNED** for GatewayGuard. It requires a public repository
and an OSI licence; this repository is private. Use **source-visible**,
**fully auditable**, or **transparent, plaintext code**.

**Naming a third party's licence correctly is not a violation.** Bitwarden,
NoID Privacy, Hardentools and Notally genuinely are open-source.

**"human-backed" / assisted sessions -- describe as PLANNED only.** Verified
2026-08-13: every occurrence already complies.

**Unverified superlatives -- banned.** *most*, *everyone*, *no one else*,
*the only*, *always* about the market, competitors or users, unless a named
source supports it. **Two live breaches remain** in the Family Presentation:
*"No competitor offers this"* (slide 6) and *"no one else has this planned"*
(slide 8). Slide 8 also promises `gatewayguard.co/sources`, **a page that does
not exist.**

**A transcript outranks that chat's summary.** Earned twice.
