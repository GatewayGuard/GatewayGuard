<!-- Dated: 2026-08-14 00:41 ET -->
# READ FIRST -- Session Briefing
**Document Name:** _READ-FIRST-Briefing
**Last Modified:** 2026-08-14 00:41 ET
**Last Editor:** Claude Code (CGDELL)
**Purpose:** Read this before anything else at the start of every session.
**Supersedes:** `_READ-FIRST-Briefing-2026-08-14-0007.md`, and through it
`-2026-08-13-1433.md` and `-2026-08-11-1616.md`, which had **nine
wrong or overtaken items** by the morning of 2026-08-13 -- including the two
that block work: it said ascii39 had never been field run, and it said no
ascii40 may be scoped.

**Change History Log:**
- 2026-08-14 00:41: **Section 8a corrected -- it was giving an instruction
  that does not work.** It listed the steps without saying who does each, so
  it read as "Bill puts the file somewhere and syncs." Bill caught it: nothing
  triggers Claude Code to commit and push, so the file just sits there. Step 2
  -- *Bill tells Claude Code it is there* -- is now the named trigger, and
  step 5 -- the "sync now" line -- is Claude Code's obligation.
  `Tool\build_readable_twins.py` added and run: **16 Word and PowerPoint files
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

It is **generated** by `Tool\Update-Current.ps1`, never typed, and it opens
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

## 1. CURRENT STATUS -- 2026-08-13 14:33 ET

**Active build: ascii39** -- 8,075 non-blank lines / 8,448 total. 65 numbered
screens, **next free screen ID 83**, gate 12 PASS, 10 carried oversize screens.

**ascii39 HAS BEEN FIELD RUN. ascii40 IS UNBLOCKED.**
The field log is `Test_Results\Ascii39-Test-Results-2026-08-11-2237.txt` -- 49
numbered findings from the SANDY Phase 3 run of 2026-08-11 -- plus 15 run logs
in `Test_Results\Logs\SANDY\`. All tracked.

**The plan exists:** `ProjectDocs\GatewayGuard_FieldTestPlan-ascii40-2026-08-13-0944.md`
triages all 47 findings into **FT-171 to FT-183** with three blockers in build
order. **Next free FT number: 184.**

**THE STATUS LINE IS NOT THE RULE.** On 2026-08-12 a session reported "no field
log exists" while the log sat on disk untracked, because the check asked `git`
and git was blind to it. **Look on disk.**

**Target launch:** September 1, 2026 at gatewayguard.co

### Git -- measured 2026-08-13 14:33, and stated HERE ONLY

| | |
|---|---|
| Commits | **85** |
| Tracked files | **444** |
| Unpushed | **0** |
| Untracked | **8** |
| Modified | 1 (`WebSite.lnk`, a shortcut Explorer rewrites) |
| Tracked bytes on disk | **42.3 MB** |
| `.git` | **29 MB** |
| Whole working tree | 86 MB |

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
zero uses of `ReadConsoleInput` or `MOUSE_EVENT` in 8,075 lines. Clear the
flag, fix the drain, and stop letting one keystroke end the session.

**Before building ascii40, run `Tool\Run-ConsoleInputModeCheck.bat` ON SANDY.**
Read-only. CGDELL did not fail, so measuring CGDELL proves nothing.

---

## 3. THE FIVE THINGS THAT MATTER MOST

1. **Fix FT-171 (the input queue) first.** Nothing else can be tested
   reliably until it is done, because any test can be ended by a stray event
   and written up as a crash. It already cost one whole field run's
   confidence.
2. **The assert-guarded Python wrapper now EXISTS and is COMMITTED** --
   `Tool\gg_edit.py`, with `Run-GGEditSelfTest.bat`. It was a named ascii40
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
- **Before the ascii40 field run, right-click the project folder on SANDY and
  choose "Always keep on this device"** -- 307 of its 1,110 files are cloud
  placeholders and it has no internet without the adapter.

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
account") and `Tool\Run-OneDriveSyncCheck.bat`.

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
| `.ps1` integrity | automatic hook | parse errors, line count, brace balance |

**Still a wish, with no check behind it:** `Run-DocCheck.bat` (no two documents
state the same volatile fact) -- named on 2026-08-09, still unbuilt. And
**H-4**, the guide-wording gate, which is human-only and **has never been run.**

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

**Marketing is handed over via `Marketing-For-Cloud.txt`** at the repository
root -- a paste block with copy markers, opening with SYNC NOW and a freshness
check. Its source material is
`ProjectDocs\GatewayGuard_MarketingSourcePack-*.md`, **generated** by
`Tool\build_marketing_sourcepack.py`, because `Marketing\` and `Presentation\`
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
`Tool\build_marketing_sourcepack.py` and `Tool\build_guide_sourcepack.py`
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

1. **Build ascii40.** Blockers in order: **FT-171** (input queue), **FT-172**
   (screen numbering -- the `$script:GGScreenOrder` table needs Bill's
   approval), **FT-175** (the Defender offline scan that has never run).
   Run Phase 0 and Phase 1 of the field test plan **first**.
2. **`Marketing-Notes.md` is corrupted** -- 9 × "an expensive" written over
   "free" by a find-and-replace that ran **before the file reached git**
   (traced to the initial commit, 2026-07-28). Orphaned `*ee` fragment,
   mangled `** **` markup, and the flyer advertising *"an expensive personal
   PC security guide"* three lines above *"100% Free"*. **Do not quote pricing
   wording out of it until repaired.**
3. **3 live open-source violations remain** in
   `GatewayGuard_ProjectNotes-2026-08-09-1435.md`, lines 2547, 2741, 3006.
   **Do not touch the other 20 hits.**
4. **`CLAUDE-Sandy.md`** -- 21,725 bytes at the root, tracked, dated
   2026-07-26 against `CLAUDE.md`'s 2026-08-09. **Eighteen days stale**, build
   line identical so it looks current, missing exactly **THE TEN-MINUTE RULE**
   and **DO NOT ASK. ACT, THEN REPORT.** Same for
   `.claude\rules\website-copy-Sandy.md`. **Deliberate machine variants, or
   drift? Bill's call.**
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
11. **`Run-DocCheck.bat`** -- still unbuilt.
12. **Business:** Maine Community Bank **checking** account (the qualifying
    account for DigiCert, must be named explicitly in the bank letter);
    SAM.gov EFT; D&B DUNS; DigiCert validation; six open LegalZoom licence
    decisions and two attorney follow-ups; Google Business profile; guide
    rewrite from v9; batch 2 website pages. **Gumroad for all sales
    (decided 2026-08-09).** **Annual Updates pricing is still open** --
    recovered 2026-08-13 from a 2026-07-13 snapshot and settled nowhere since.

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
