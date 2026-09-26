<!-- Dated: 2026-08-12 16:52 EDT -->
# GatewayGuard Project Instructions
- **Document Name:** GatewayGuard_ProjectInstructions
- **Last Modified:** 2026-08-12 16:52 EDT
- **Last Editor:** Claude Code (CGDELL)
- **Status:** Cumulative Master Document (supersedes all prior versions)
- **Change History Log:**
  - 2026-08-12 16:52: **Three corrections, all caught by Bill pasting Cloud's
    Project Instructions field into a session and asking what was wrong with
    it.** That field held a full 794-line copy of the 2026-08-10 16:06
    version -- 175 lines and two days behind, looking complete and
    authoritative, with no way for Cloud to know. **`SyncPlan` section 5a
    requires that field to hold a POINTER, not a copy**, and this is exactly
    why: a copy goes stale silently, and Cloud has no reason to consult the
    connector when it already holds something that looks finished.
    (1) **UNRUN BUILD RULE status corrected -- ascii40 is UNBLOCKED.** The
    line read "as of 2026-08-06 ascii39 has NOT had a field run" for six days
    after it stopped being true. ascii39 was field run 2026-08-11: 49
    numbered findings, plus fifteen SANDY run logs, all now tracked. Added
    the standing warning that **the status line is not the rule** -- on
    2026-08-12 a session reported no field log existed while the log sat
    untracked on disk, because the check asked `git` and `git` was blind to
    it.
    (2) **CONFIRM BEFORE ACTING narrowed to the unrecoverable.** It required
    confirmation before any change touching more than one file, which is most
    real work, and made Bill the reviewer of file lists he had no way to
    check -- *"most of the time I don't know what I am approving."* The test
    is now "can this be undone", not "is this big", with four exhaustive
    exceptions and an undo line replacing permission. Mirrors **DO NOT ASK.
    ACT, THEN REPORT.** in `CLAUDE.md`; the two were written together and must
    not drift.
    (3) **PL-2's powering-on exemption withdrawn.** The verb rule is
    unconditional -- only the noun survives. The exemption was written as a
    quoted sentence, so it protected that sentence and left four other
    occurrences on the same page unflagged. **Write exemptions as categories
    or not at all.**
  - 2026-08-11 16:16: **ENCRYPTION STATE MATRIX corrected for SANDY.** Its
    Windows account was a **Microsoft account** until 2026-08-11, not a local
    one -- the matrix had said local since 2026-08-06 on Bill's report, and
    the two were never reconciled. It sat on that Microsoft account for a week
    or more, through multiple reboots, with Modern Standby present, and
    **Device Encryption never engaged.** Bill converted it to a local account
    named `panther` immediately before the ascii39 Phase 3 run. Both drives
    measured FullyDecrypted the same day. This is the MACHINE-STATE CURRENCY
    rule catching its own table again.
  - 2026-08-10 22:45: **Rescued a rule that had been missing for five weeks.**
    `GatewayGuide_Project_Instructions-2026-07-03.md` (superseded; now `GatewayGuard_ProjectInstructions-2026-08-12-1652.md`) -- written under the
    RETIRED `GatewayGuide` spelling -- required that ProjectNotes be **updated**
    when new decisions, research or builds are discussed, not merely consulted.
    Every other rule in that file was carried into this document. That one was
    not, and nothing could have caught it: because the old file's name differs
    from `GatewayGuard_ProjectInstructions`, the newest-by-filename-date rule
    never compares the two. **A renamed document is invisible to the rule that
    protects documents.** Recorded as ORPHAN LINEAGE under RETIRING OLD FILES so
    the class is named, not just this instance. The two old-spelling files are
    retired in the same commit that adds this.
  - 2026-08-10 22:18: **Added VERIFICATION RULES V-1 to V-6.** Six errors in one
    session, none of them a knowledge failure -- every one was a verification
    failure, and three broke EXHAUST THE FORMS, which was added nine days
    earlier and had no mechanical step. A rule that says "check the other
    forms" without saying HOW MANY forms or WHICH ones is advice, not a gate.
    V-1 to V-6 each name the check, and each cites the error that earned it.
    Requested by Bill after he counted the errors himself.
  - 2026-08-10 16:06: **Five corrections, all from reconciling this document
    against Bill's profile instructions.** (1) **THE CLOCK replaces "ask Bill
    for the date and time"** in both FILE NAMING and SESSION START -- the old
    wording was a workaround for a limitation only Claude.ai has, generalised
    into a universal rule, and it contradicted Start-CC.txt, which tells Claude
    Code to run `Get-Date`. Now scoped: read the clock if you can run commands,
    ask if you cannot. (2) **WEBSITE BUILD RULE now carries all FOUR gates.** It
    listed three and omitted **H-4**, the guide-wording source -- the only gate
    that protects meaning rather than syntax. A session following this document
    could print "ALL PASSED" having never checked the words. Bill's profile had
    the identical defect. (3) **PL-4 NO UNVERIFIED SUPERLATIVES added** -- it was
    already enforced by name in TrustSection-2026-07-16 ("the superlative rule")
    while being defined in no governing document. (4) **Sandy3's ENCRYPTION STATE
    MATRIX row corrected** to `FullyEncrypted / 100 / XtsAes128`, measured
    2026-08-08. It still read "unverified -- re-measure before relying on it" in
    a table that calls itself the single authoritative statement of fleet state,
    two days after the measurement -- the exact failure MACHINE-STATE CURRENCY
    exists to prevent, inside the document that carries that rule. (5) **UNIVERSAL
    WORKING RULES section added**, naming the profile as a real dependency,
    recording that it is invisible to grep, git and every gate, and settling the
    authority in both directions.
  - 2026-08-09 22:58: **Added EXHAUST THE FORMS BEFORE CONCLUDING ABSENCE.**
    A single check coming back empty is not evidence a thing does not exist --
    it is evidence one form of it was not found in one place. Earned three
    times in two days on three different subjects: a tool declared unavailable
    after one of its several invocation names failed; a file recorded as
    "never existed" because it was absent from the one tree searched, while it
    sat in another system; and a folder assessed as redundant because a
    different folder of the same name had been. Two of the three reached
    governing documents before being caught. A wrong negative closes the
    question, which is what makes it worse than a wrong positive.
    Last Editor corrected to Claude Code -- governing documents moved to
    Claude Code authorship on 2026-08-08; see the SyncPlan.
  - 2026-08-06 17:27: **Added CLAUDE.md as required reading** before any
    .ps1 build, build-number increment, or bulk edit -- it was named in no
    prior version of this document, so a session following these instructions
    literally would never have opened it. Its never-rename identifier list
    (MachineID hash salt, Task Scheduler task names, `C:\GatewayGuard\`,
    `Run-GatewayGuard.bat`) is the specific protection against a
    find-and-replace that would corrupt every machine's ID and orphan every
    scheduled task. Added to both CODING STANDARDS and SESSION START.
  - 2026-08-06 17:27: **Corrected the CGDELL machine-state description under
    RESEARCH BEFORE STATING.** The prior text said CGDELL carried BitLocker,
    TPM, and Secure Boot **off**. That is false and was contradicted by this
    project's own measurements taken four days earlier
    (`GatewayGuard_TestHistory-ascii39-2026-08-02-0914.md` (superseded; now `GatewayGuard_TestHistory-ascii39-2026-08-02-1335.md`)): CGDELL reads
    `Encrypted / 100 / FullyEncrypted`, signs in with a **Microsoft account**,
    and reads Secure Boot `False`. Added the ENCRYPTION STATE MATRIX to the
    MACHINE CHECK section so the fleet's real state is stated once, in one
    place, with the basis of each claim. Added the MACHINE-STATE CURRENCY rule.
    Source: this session, after a wrong warning was issued to Bill on the
    strength of the stale line.
  - 2026-08-02 18:20: Added PLAIN LANGUAGE RULES section (three word-level
    rules: banned words, Checkup's verb, name the permission). Added
    CONFIRM BEFORE ACTING rule. Added CHECKUP NAME RULE. Source: Claude
    Code session 2026-08-02 and Bill's direction this session.
  - 2026-08-02: Extended RESEARCH BEFORE STATING -- a command FLAG (and a
    parameter NAME) is a factual claim; the four bases measured/sourced/
    inferred/guess, with only the first two shippable; test on CGDELL first.
    Earned by FT-162: `MpCmdRun.exe -Scan -ScanType 4`, a flag that does not
    exist, shipped in the quarterly task and asserted on screen -- the scan
    has never run on any machine. Enforcement is now mechanical via
    CodingStandards gate 24 (`Run-ExternalCommandCheck.bat`).
  - 2026-07-20: Full rewrite. Added FILE NAMING & VERSIONING (Option A,
    YYYY-MM-DD-HHMM), DOCUMENT REVISION RULE, STALE INSTRUCTION CHECK,
    MACHINE CHECK, and consolidated all rules from chats 2026-07-17
    through 2026-07-20 including ascii32/33 governance decisions.
  - 2026-07-19: Added CODING STANDARDS rule, PLAYBOOK RULE, WEBSITE
    BUILD RULE, VERIFY THEN DESCRIBE, STATED-VS-DELIVERED CHECK,
    RESEARCH BEFORE STATING, STATE-MATRIX TESTING, STATUS-STRING
    CONTRACT, RELEASE SIGNING RULE, UNRUN BUILD RULE.
  - 2026-07-18: Added MACHINE CHECK, WRITING AUDIENCE DEFAULT,
    EXCEPTION -- EXPERT/TECHIE AUDIENCE, ACCURACY NOTE, BUSINESS
    MODEL ACCURACY, MODEL SELECTION, BUILD GATE, USER-FACING CLARITY.
  - 2026-07-17: Added CROSS-FILE SYNC, TIME ZONE, FILE HEADERS.
  - 2026-07-10: Initial project instructions established.

---

## PROJECT CONTEXT

This is the GatewayGuard project -- a Windows 11 security hardening
tool for non-technical home users and seniors, launching September 1,
2026. Maine LLC, sole developer: William F. Burns III (Bill),
GatewayGuard LLC, Brunswick, Maine. Website: gatewayguard.co.

Always check project knowledge files before answering questions about
project status, history, or past decisions.

**And update `GatewayGuard_ProjectNotes-*.md` when new decisions, research
or builds are discussed.** Checking is not enough on its own -- a decision
that is only ever read out of chat is a decision that will be lost when the
chat is. *(Restored 2026-08-10 from the retired `GatewayGuide`-spelled
instructions, where it had sat uncarried since 2026-07-03.)*

---

## FILE NAMING & VERSIONING (effective 2026-07-20)

**One unique filename per document type, forever.**

**Filename syntax:** `[ProjectName]_[DocumentType]-YYYY-MM-DD-HHMM.ext`
**Example:** `GatewayGuard_CodingStandards-2026-07-20-0908.md` (superseded; now `GatewayGuard_CodingStandards-2026-08-07-1330.md`)

- The core descriptive name of a file never changes across its lifetime.
- The filename always ends with `-YYYY-MM-DD-HHMM` before the extension.
  Date AND time are both required -- date alone is not sufficient because
  multiple versions can be produced on the same day.
- When a file is updated, both the date and time in the filename change
  to reflect the current edit. Nothing else in the name changes.
- No `-r2`, `-r3`, `_addendum`, `_additions`, `_patch`, or any other
  variant suffix. Ever. For any file type.
- Every update is a complete replacement file with the new date-time.
  The new file supersedes the prior version. Upload it; retire the old one.
- Every file maintains a cumulative Change History Log in its header.
  All history lives inside the file -- never in separate patch files.
- **THE CLOCK.** Every dated file carries a real local date and time,
  never an inferred one. Both the filename and the internal header come
  from it.
  - **If you can run commands, read the clock yourself** and state the
    date and time you will use for the session. On Windows that is
    `Get-Date`. **Do not ask Bill for something you can measure in a
    second** -- asking costs a round trip and his time.
  - **If you cannot run commands, ask Bill,** and say that is why you are
    asking. This is Claude.ai's position, not Claude Code's.
  - **Never infer** the date or time from UTC chat metadata, container or
    system clocks reported by the chat, or conversation context -- UTC
    routinely differs from US Eastern Time by hours or by a calendar day.
    A wrong date-time in the filename is a wrong version label.
  - **Once established for the session, read or given, that answer
    stands.** Re-asking before every file is friction, not diligence.
    Ask again only if the session has clearly spanned hours or crossed a
    date boundary.
  - *Corrected 2026-08-10. The prior wording told every Claude to ask.
    That is right for Claude.ai, which cannot read a clock, and wrong for
    Claude Code, which can -- and it contradicted `Start-CC.txt`.*
- Exception -- script builds: ascii build name is part of the .ps1
  filename and increments with each build.
  Format: `W11-SecurityHardening-v3-ascii34-YYYY-MM-DD-HHMM.ps1`
- Exception -- Run-GatewayGuard.bat: no date-time in filename
  (always-current launcher). Date and time live in internal header only.
- This rule supersedes all prior naming conventions including the old
  date-only format and any -r2/-r3 revision suffix conventions.

---

## DOCUMENT REVISION RULE (effective 2026-07-20)

This rule governs ALL revisions and additions to every GatewayGuard
document, file, and standard, going forward without exception.

**Never create a separate addendum, additions, patch, or revision file.**
When any document needs updating -- whether it is CodingStandards,
ProjectNotes, WebsiteStandards, NamingStandard, TestHistory, or any
other file -- the process is always:

1. Open the current master file.
2. Integrate the new content directly into the body of the document.
3. Update the Change History Log at the top with a one-line summary
   of what changed and the date-time.
4. Update the filename date-time to reflect the current edit.
5. Deliver as a complete self-contained replacement file.
6. Bill uploads the new file; the prior version is retired.

**No partial files. No diffs. No "add this to the bottom of X."**
Every delivered file must be complete and self-contained so that Bill
can upload it as a drop-in replacement with zero assembly required.

---

## FILE HEADERS

Every file's internal header must show current DATE AND TIME in US
Eastern Time:
- `.ps1` / `.psm1`: `# Dated: YYYY-MM-DD HH:MM ET`
- `.bat`: `REM Dated: YYYY-MM-DD HH:MM ET`
- `.md`: `<!-- Dated: YYYY-MM-DD HH:MM ET -->`
- `.docx` / `.pptx`: visible date+time line in header or footer

Filename date-time and internal header date-time must always match.
When either changes, update BOTH in the same edit -- never one without
the other.

---

## TIME ZONE

Always use US Eastern Time -- automatically Eastern Daylight Time
(EDT, UTC-4) from mid-March to early November, and Eastern Standard
Time (EST, UTC-5) the rest of the year. Label timestamps "ET" (or
"EDT"/"EST" if precision matters). Never hardcode a fixed UTC offset.

---

## STALE INSTRUCTION CHECK

If asked to review, confirm, or discuss these project instructions and
the visible "Dated:" header is more than a few days old relative to
today's actual date, flag that the file is stale and hasn't been
re-saved recently -- do not assume it is current just because it is
the version on file.

---

## MACHINE CHECK

At the start of every session (or when resuming after a break), ask
which machine Bill is working on before giving any machine-specific
steps. Never assume or infer the machine from context.

### The fleet

| Nickname | Hardware | Edition | RAM | Role |
|---|---|---|---|---|
| **CGDELL** | Dell Latitude 5430 | Win 11 **Pro** | 32 GB | Primary dev machine |
| **SANDY** | HP Notebook 17-by1955cl | Win 11 **Home** | 8 GB | Field test -- Home / local account |
| **Sandy3** | Lenovo IdeaPad | Win 11 **Home** | 8 GB | Field test -- Home / pre-encrypted |

### ENCRYPTION STATE MATRIX (corrected 2026-08-06)

This table is the single authoritative statement of fleet state. Any
other description of a machine's state anywhere in any document is
subordinate to this table.

| Machine | Sign-in account | Encryption | Secure Boot | Basis |
|---|---|---|---|---|
| **CGDELL** | **Microsoft account** | **Fully encrypted** (`Encrypted / 100 / FullyEncrypted`) | `False` | **measured** 2026-08-02, TestHistory-ascii39 FT-143/144/145 |
| **SANDY** | **Local account** `panther` -- **converted from a MICROSOFT account 2026-08-11** | **Not encrypted** (`FullyDecrypted`, both `C:` and `D:`) | unverified | **measured** 2026-08-11, `Tool\EncryptionProfile-SANDY-2026-08-11_15-15.txt` |
| **Sandy3** | unverified | **Fully encrypted** (`FullyEncrypted / 100 / XtsAes128`) | unverified | **measured** 2026-08-08, `Tool2\Run-EncryptionMeasure.bat` |

**What this matrix means for testing:**

- **SANDY is the only machine that can reach the Home + unencrypted +
  local-account branch of item 8** -- the FT-110 path, and the FT-144
  danger case where Windows will encrypt on a local account with the
  recovery key escrowed nowhere. It is the highest-value test machine in
  the fleet for that item.
- **SANDY carries a SECOND fixed drive, `D:`, 931.5 GB, fully decrypted**
  (measured 2026-08-11). Checkup reads only `C:`. That is FT-167, and SANDY
  is the machine that proves it.
- **A Microsoft account did NOT trigger Device Encryption on SANDY.** It sat
  signed in for a week or more through multiple reboots, Modern Standby
  present, and nothing engaged. **Do not treat the Microsoft-account warning
  as settled in either direction** -- one machine over one week is not a
  rule, but it is no longer an assumption that can be asserted.
- **SANDY's value for that branch is spent the moment encryption
  actually starts on it.** Exercise the screens without completing
  encryption for as many runs as needed. Treat actually letting
  encryption run as a separate, deliberate, one-way decision.
- CGDELL cannot reach the unencrypted branch. Sending an item-8 field
  test there proves nothing about the branch that most needs proving.

### MACHINE-STATE CURRENCY (added 2026-08-06)

**A machine-state claim in a governing document is a factual claim and
decays like any other.** Before reasoning from any statement about what
a machine carries -- encryption, TPM, Secure Boot, Defender, antivirus,
account type -- check the most recent TestHistory for a measurement. A
measurement in TestHistory beats a description in this file, always,
without needing this file to be corrected first.

**What earned this (2026-08-06):** the RESEARCH BEFORE STATING section
of this document said CGDELL carried BitLocker, TPM, and Secure Boot
**off**. `GatewayGuard_TestHistory-ascii39-2026-08-02-0914.md` (superseded; now `GatewayGuard_TestHistory-ascii39-2026-08-02-1335.md`), written
four days earlier, recorded CGDELL as fully encrypted and signed in with
a Microsoft account -- measured, cross-checked, and logged under three
separate FT numbers. Claude reasoned from the stale line, told Bill his
machine had encrypted itself unexpectedly, and sent him after a recovery
key and a `dsregcmd /status` diagnostic for a non-event. **The correct
information was already in project knowledge and was not searched for.**
The failure was not the stale line; it was describing machine state from
a governing document without checking the measurement record.

---

## MODEL SELECTION

Any turn touching a .ps1 build file, licensing/legal analysis, or
CPM scheduling must use the most capable available model (currently
Claude Sonnet or Opus -- not Haiku). Sonnet is acceptable for
marketing copy, FAQ, presentations, and emails. Never use Haiku on
ascii builds -- multi-rule discipline (paired-file sync, header
timestamps) degrades on smaller models.

---

## BUILD GATE

No .ps1 build is presented as complete until the Appendix A pre-build
audit (GatewayGuard_DefectPreventionPlaybook) has been run and passed,
with results shown in the same response. A failed check blocks the
build from being delivered.

---

## UNRUN BUILD RULE

Never scope or build the next ascii until the current build has at
least one field run with an uploaded log. An untested build is a
liability, not a build.

**Status as of 2026-09-26: ascii44 HAS been field run (SANDY, 2026-09-19/20;
nine logs in `Test_Results\FieldRun-ascii44\`, triaged in
`GatewayGuard_FieldTestTriage-ascii44run1-2026-09-24-2353.md`), so ascii45 is
unblocked and being built. Cloud caught the line below still describing
ascii39/40.**

*Earlier status, superseded 2026-09-26:* **ascii39 HAS been field run. ascii40 is
UNBLOCKED.** The field log is
`Test_Results\Ascii39-Test-Results-2026-08-11-2237.txt` -- 49 numbered
findings from the SANDY Phase 3 run of 2026-08-11, plus fifteen run logs
in `Test_Results\Logs\SANDY\`. All are now tracked.

*Previous status, superseded: "as of 2026-08-06 ascii39 has NOT had a
field run; no ascii40 may be scoped." It was correct when written and
stayed in the document six days after it stopped being true.*

**THE STATUS LINE IS NOT THE RULE. Check for the log; do not read this
line and stop.** On 2026-08-12 a session reported "no field log exists
for ascii39" while the log sat in `Test_Results\`. It was untracked, so
`git` could not see it, and the check had only asked `git`. **Look on
disk.** A question answered with a tool that is blind to the answer
returns a confident wrong number, and this rule is the one it blocks
work with.

**The findings are not cosmetic.** Right-click crashed the program
twice, the look-back promise broke repeatedly, and item 13 confirms
FT-167 on screen: *"only list one hard drive for Sandy when it has
two."* Fold them into TestHistory before scoping ascii40.

---

## RELEASE SIGNING RULE

Signing is the FINAL step, after the pre-build audit passes. Any edit
after signing voids the signature -- re-audit and re-sign. The .bat
launcher cannot be signed and ships plain; keep it minimal and stable.

---

## CROSS-FILE SYNC

Run-GatewayGuard.bat references its paired .ps1 build file by exact
filename. Any time the .ps1 file is renamed or rebuilt, the .bat's
filename reference must be corrected and re-presented in the SAME
response -- never leave a .bat pointing to a superseded or deleted
filename. Before ending any turn touching a .ps1 build file,
explicitly confirm whether Run-GatewayGuard.bat still points to the
correct current filename.

---

## STATUS-STRING CONTRACT

Status strings are matched by gate logic elsewhere in the code
("GOOD", "NOT Encrypted", "primary"). Never reword a status string
without grepping every -match that consumes it, in the same edit.

---

## STATE-MATRIX TESTING

Any feature that branches on machine state (drive encrypted vs. not;
MB Premium/Trial/Free/absent) must be tested in each state before
ship, with a note of which machine covers which state. See the
ENCRYPTION STATE MATRIX under MACHINE CHECK for which machine covers
which encryption state.

---

## CODING STANDARDS

Before any .ps1 build, read GatewayGuard_CodingStandards.md in
project knowledge and confirm all standards are met. The pre-build
audit (DefectPreventionPlaybook Appendix A) and CodingStandards
session-end checklist must both pass before a build is presented.

### CLAUDE.md IS REQUIRED READING (added 2026-08-06)

**`CLAUDE.md` must be read before any .ps1 build, any build-number
increment, and any bulk edit or find-and-replace across the tree.**
It is 307 lines and carries build rules that exist in no other
document:

- **The five build-ID locations** -- filename, `FILE:` header,
  `BUILD:` header, `$BuildID`, and CLAUDE.md's own current-build line.
  All five update in the same edit. Appendix A item 9 checks all five.
- **The line-count convention** -- the quoted figure is the
  `Measure-Object -Line` **non-blank** number. Gate 11's before/after
  size check is meaningless if the two numbers use different methods.
- **26 lines per screen maximum**, every screen ending in a blank line,
  run as a **ratchet**: ten screens (72, 50, 73, 26, 27, 65, 60, 41,
  30, 52) sit in a named baseline inside the coverage checker and are
  reported but do not fail. Any screen **not** on that list exceeding
  26 lines fails the build. The list may only ever get shorter.
- **The never-rename identifier list** -- the MachineID hash salt
  `"GatewayGuard|"`, the Task Scheduler task names
  (`GatewayGuard - Quarterly...`, `GatewayGuard - Monthly...`),
  `C:\GatewayGuard\`, `Run-GatewayGuard.bat`, `gatewayguard.co`, and
  the LLC name. **These are identifiers and recovery points, not
  prose.** A blanket find-and-replace on "GatewayGuard" would corrupt
  every machine's ID and orphan every scheduled task on every
  customer machine.
- **The required pre-build tool runs** --
  `Tool2\Check-ScreenCoverage-2026-07-30.ps1` (launcher
  `Run-ScreenCoverageCheck.bat`), the mechanical gate-12 check that
  also reports the next free screen ID, and `Tool2\Show-AllScreens.bat`
  to walk every screen without running checks or changing anything.

**Why this was added:** until 2026-08-06 this document named
CodingStandards and the Playbook as required build reading and did not
mention CLAUDE.md at all. A session following these instructions
literally would never have opened it. CLAUDE.md's own current-build
line once sat at ascii28 while the tree was on ascii34 -- six builds
stale, on the very line instructing the reader to confirm the build
number. A pointer that lies is worse than no pointer, and an
instruction file that omits a governing document is the same failure
one level up.

---

## PLAYBOOK RULE

Before any .ps1 build, re-read the Defect Prevention Playbook class
descriptions (not just Appendix A). Appendix A catches code patterns;
the class descriptions carry the reasoning and rules that the audit
commands don't cover. Both are required reading, not just the audit.

---

## VERIFY THEN DESCRIBE

Before stating that any rule, decision, or item appears in a delivered
file, re-read the relevant section and confirm it is actually there.
Never describe file contents from memory of intent. If a rule or
decision exists only in the chat response and not in a file, state
explicitly: "Note: this is in chat only -- not yet filed in
[filename]."

**This extends to machine state and past measurements.** Before telling
Bill that something about his machines, his builds, or his prior test
results is true, search project knowledge for the record. "I do not
recall seeing that" is not evidence of absence when the search has not
been run.

---

## STATED-VS-DELIVERED CHECK

At the end of any session that produces files, run a stated-vs-
delivered check: list every claim made about file contents and confirm
each one is in the delivered file. Flag any gap before signing off.

---

## EXHAUST THE FORMS BEFORE CONCLUDING ABSENCE (added 2026-08-09)

**One check coming back empty is not evidence that a thing does not exist. It
is evidence that one form of it was not found in one place.**

Before writing *"there is no X"*, *"X never existed"*, *"X is not installed"*,
or *"X is redundant"*:

1. **Name the other forms X could take.** A thing rarely has one spelling, one
   extension, one command name, one location, one representation.
2. **Name the other places X could be.** This tree is not the only place things
   live. Neither is any one machine, folder, account, or system.
3. **Check them.** If either list is unexhausted, the search is unfinished.
4. **Then say what you actually measured:** *"not found as Y in Z"* -- never
   *"does not exist."*

**"Not found" and "does not exist" are different claims.** The first is a
measurement and is almost always safe. The second is a conclusion, and it is
only earned when the search was exhaustive. Downgrade to the first whenever the
second cannot be defended.

**The tell:** a negative conclusion reached faster than a positive one would
have been. Finding something requires locating it; concluding nothing exists
requires ruling everywhere out. If the second felt quicker, it was not done.

**Why this is a standing rule and not a note:** a wrong negative is worse than
a wrong positive. A wrong positive gets contradicted by the next check. A wrong
negative closes the question -- nobody looks again, the thing stays lost, and
the conclusion gets written into a governing document where it is read as
settled.

**What earned this (three instances, two days, three different subjects):** a
tool was declared unavailable after one of its several invocation names failed;
a file was recorded as having "never existed" because it was absent from the
one tree searched, while it sat in another system entirely; and a folder was
assessed as redundant because a different folder with the same name had been.
Each was a single probe treated as an exhaustive search. Two reached governing
documents before being caught.

**This generalises past files and tools.** Machine state, settings, rules,
capabilities, permissions, and history all have more than one place to look and
more than one form to take.

---

## RETIRING OLD FILES -- NAME THE KIND FIRST (added 2026-08-10)

**"Old file" is not one thing.** Five kinds sit in this tree and they carry
different risk. Name the kind before deleting anything.

| Kind | What it is | Delete? |
|---|---|---|
| **Superseded version** | Same document, later version exists, content carried forward | Yes -- git keeps it |
| **Exact duplicate** | Identical content in two places, or a `(1)` download artifact | Yes |
| **Stale export** | Same document in another format, built from an OLDER version | **Ask Bill** -- may record what someone was given |
| **Orphan lineage** | An earlier document under a DIFFERENT name | **Read it first** |
| **Undated legacy** | Predates the naming convention, occupies the bare core name | **Read it first** |

**ORPHAN LINEAGE is the dangerous one, and it has already cost this project.**
The newest-by-filename-date rule works by matching the core name. Rename the
document and the rule stops comparing the old one to the new -- silently,
forever. Nothing reports it, because from the rule's point of view they are two
unrelated documents.

*Measured 2026-08-10:* `GatewayGuide_Project_Instructions-2026-07-03.md` (superseded; now `GatewayGuard_ProjectInstructions-2026-08-12-1652.md`), under
the retired folder spelling, held a rule requiring ProjectNotes to be UPDATED
and not merely checked. Every other rule in it had been carried across. That one
sat uncarried for five weeks, and no gate could have found it.

**So: when a document is renamed, diff the old lineage against the new one in
the same session, and record that you did.** A rename is not a filing change; it
is a break in the chain the newest-wins rule depends on.

**Retiring means `git rm`** -- the file leaves the working tree, stays in git
history, and comes back with `git checkout <commit> -- <path>`. Nothing is
destroyed. **Never `git rm` a file that was never committed:** that is not
retirement, it is deletion, and it is how the assert-guarded Python wrappers
were lost.

---

## VERIFICATION RULES V-1 TO V-6 (added 2026-08-10)

**All six were earned in one session.** Not one was a knowledge failure -- every
one was a verification failure, and three of the six broke EXHAUST THE FORMS,
which had been added nine days earlier. That rule says "check the other forms."
It does not say how many, or which, or how you would know you were done. **A
rule with no mechanical step is advice, and advice does not survive a long
session.** Each rule below names its check and cites the error that earned it.

### V-1 -- A NEGATIVE NEEDS TWO QUERIES OF DIFFERENT SHAPE

**Before writing "X is not there", run a second query built differently** --
different tool, different field, different match rule. Same query twice is one
query. If the two disagree, the search is unfinished and neither answer ships.

*Earned:* `git ls-files "Check-Claude-Cloud.txt" "Start-CC.txt"` returned
nothing, and that was reported as "neither is tracked" -- a false alarm that the
two startup documents were outside the backup. `git ls-files --error-unmatch`
returned both immediately. One query form, one wrong conclusion, and the
conclusion was the alarming direction.

### V-2 -- TEST THE MATCHER ON A CONTROL THAT MUST MATCH

**Any normalisation, fuzzy match or name comparison across two systems is run
first against an item KNOWN to exist in both.** If the control does not match,
the matcher is broken and every "missing" it produced is void -- report nothing
until it passes.

*Earned twice in one comparison.* Cloud strips hyphens on ingest, so
`GatewayGuard_Guide-Comfort-16pt-2026-07-16.pdf` arrives as
`GatewayGuardGuideComfort16pt20260716.pdf`. The normaliser collapsed separators
to underscores instead of removing them, and reported five guide PDFs as
missing that were tracked in git the whole time. **Bill caught it, not the
process.** Separately, a bidirectional prefix match accepted the undated
`GatewayGuard_CPM_Schedule.md` as a match for
`GatewayGuard_CPM_Schedule-2026-07-30-2208.md` (superseded; now `GatewayGuard_CPM_Schedule-2026-08-31-1439.md`) -- a different and older file.

### V-3 -- FOR CUMULATIVE DOCUMENTS, TEST THE CONTENT, NOT THE FILENAME

**Before calling a missing version a loss, open the newest version and look for
its change-history entry.** Every GatewayGuard master document is a complete
self-contained replacement carrying cumulative history -- so an older dated
version is almost never a loss. **"Not in the tree" is the wrong test.
"Content not in the tree" is the right one.**

*Earned:* `GatewayGuard_TestHistory-ascii39-2026-08-02-0914.md` (superseded; now `GatewayGuard_TestHistory-ascii39-2026-08-02-1335.md`) was reported as
existing only in Cloud and queued for recovery. The tree's `-2026-08-02-1335`
already contained its change-history entry, its FT-163/FT-164 sections, and
everything after -- 54,666 bytes against the earlier 36,971, because each
version absorbs the last. Nothing had ever been missing. The same was true of
`ProjectInstructions-2026-08-02-1820.md` (superseded; now `GatewayGuard_ProjectInstructions-2026-08-12-1652.md`). **Bill stopped this one:** *"We spend
too much time on useless old files that have been superceded."*

**Only chase content that exists nowhere else** -- genuinely new material, or
binaries (`.docx`, `.pdf`) that no newer version can reconstruct.

### V-4 -- NEVER USE A PATTERN OPERATOR FOR A LITERAL TEST

**PowerShell `-like` treats `?` and `*` as wildcards.** Use `.StartsWith()`, or
`-match` with the metacharacters escaped. **And every count is sanity-checked
against a known total before it is reported** -- a number larger than the
population is a bug, not a finding.

*Earned:* `Where-Object { $_ -like '??*' }`, intended to select git's untracked
lines, matched EVERY line of `git status --short`. It reported **165 untracked
files against a real 18**, and the impossible number was passed on as a
suspected mass restore before the filter was suspected.

### V-5 -- A MEASUREMENT IS STAMPED; RESTATING IT RE-RUNS IT

**Never restate an earlier measurement as current state.** Either re-run it, or
give it the time it was taken. This applies inside a single session -- long
sessions cross hours, and the tree changes underneath.

*Earned:* a file deleted at 16:54 was reported as still deleted hours later. It
had been recreated at 21:38 with different content. The claim was true when
made and false when repeated.

### V-6 -- GUARD ON THE STRUCTURE, NOT ON A SUBSTRING

**An assert that old text is gone must target the full structural unit** -- the
whole table row, the whole block -- **not a phrase.** New prose legitimately
quotes old wording when it explains what changed, and a substring guard cannot
tell the two apart.

*Earned:* a build guard checking that `"re-measure before relying on it"` was
gone aborted correctly-built output, because the new change-history entry
quoted that phrase while describing its removal. The guard was right to fire
and wrong in what it watched.

**Why V-6 is a rule and not a note:** this is the only one of the six that cost
nothing, because the guard failed CLOSED -- it aborted and wrote no file. That
is the behaviour every check should have. A guard that fails closed on a false
positive is cheap; a guard that fails open is how ascii34 was corrupted and how
`ScanType 4` printed `[GOOD]` for months.

---

## RESEARCH BEFORE STATING

No factual claim about external system behavior (Windows, Defender,
Malwarebytes, third-party tools) is written into any response, file,
or tool copy until verified against a primary source (live machine
test, Microsoft docs, vendor docs, or web search with URL cited). If
unverified, say "unverified -- check whether [X]" not "this will [X]."

**Every claim carries its basis, in one of four words:** **measured**
(I ran it, output shown), **sourced** (documented, with the link),
**inferred** (reasoning from evidence, could be wrong), **guess** (a
hypothesis). A claim with no label is being asserted as fact, so it
had better be one. Only *measured* and *sourced* may be written into
the tool or into user-facing copy.

**TEST ON A REAL MACHINE FIRST (revised 2026-08-06).** Prefer running a
check over asking Bill to run it: asking costs a round trip and his
time, running costs seconds. **Choose the machine by the state the claim
depends on** -- see the ENCRYPTION STATE MATRIX under MACHINE CHECK.
CGDELL is Pro and fully encrypted; SANDY is Home, local account, and
unencrypted; Sandy3 is Home and pre-encrypted. A claim about the
unencrypted path cannot be settled on CGDELL no matter how convenient
CGDELL is. Say plainly when something cannot be tested on any available
machine.

*(The prior version of this paragraph asserted CGDELL carried BitLocker,
TPM, and Secure Boot off. That was wrong -- see MACHINE-STATE CURRENCY.)*

**A COMMAND FLAG IS A FACTUAL CLAIM.** The flags and flag VALUES passed
to an external program fall under this rule exactly as prose does.
Never write a flag -- or a parameter NAME -- you have not seen in that
program's own help output, or run.

**What earned this (FT-162, 2026-08-02):** the build shipped
`MpCmdRun.exe -Scan -ScanType 4` in the quarterly scheduled task and
told the user on screen that it scheduled an offline scan for their
next restart. ScanType 4 does not exist; MpCmdRun documents 0-3.
Measured: `0x80070667 -- Invalid command line argument`, 0.0 seconds,
nothing queued. **The quarterly Defender scan never ran on any
machine**, while the log printed `[GOOD] Scheduled task created` every
time. The correct call was already in the same file. Separately, the
first draft of the FT-161 fix used `-DisallowStartIfOnBatteries`, which
is not a real parameter (`-AllowStartIfOnBatteries` is) -- caught only
because it was run before being written down.

**This rule existed before FT-162 and did not prevent it, because
nothing checked it.** Enforcement is now mechanical: CodingStandards
gate 24, via `Tool2\Run-ExternalCommandCheck.bat`, which fails any
external command lacking a `# VERIFIED <date> measured|sourced:`
comment and any screen that shows the user a raw command line. A gate
with no check is a wish.

---

## WEBSITE BUILD RULE

Before delivering any HTML file, run the **four-gate HTML DELIVERY GATE**
and print its results block in the same response. `GatewayGuard_
WebsiteStandards-*.md` defines it; this is the summary, and
**WebsiteStandards wins on any difference.**

- **H-1  Corruption grep** of the file content.
- **H-2  Browser check.** Instruct Bill to open the file locally in Chrome
  or Edge before pushing. A chat preview does not render CSS.
- **H-3  W3C validation.** Instruct Bill to validate at
  https://validator.w3.org. **Errors block delivery; warnings do not.**
- **H-4  Guide-wording source.** Name the guide section the page's wording
  came from. **"Written from the settings map" is a FAIL, not a source** --
  `GatewayGuard_SettingsToGuideMap.md` is an INDEX, not a content source.
  Use it to find the section, then read the section.

**A skipped gate blocks delivery.** Re-run after fixing; do not present a
file with a gate outstanding.

**H-4 is the only gate that protects meaning.** H-1 through H-3 are
mechanical -- a grep, a browser, a validator -- and a page can pass all
three and still send a senior down a menu path the guide does not
describe. That is the drift RULE W-07 exists to prevent, and no other
check can see it.

*Added 2026-08-10. This rule listed three gates and omitted H-4 from the
day H-4 was created (2026-07-26). Bill's profile instructions carried the
identical three-gate defect. A gate that two of the three documents a
session actually reads do not mention is a gate that does not run.*

Review full standards in `GatewayGuard_WebsiteStandards-*.md` before any
website work.

---

## WRITING AUDIENCE DEFAULT

All GatewayGuard writing produced going forward -- tool text, guide
copy, marketing, FAQ, presentations, emails -- defaults to the
Layman's Positioning Statement's voice: plain English, no jargon,
technical terms defined inline if used at all. Test: "Would a
non-technical neighbor understand this in 5 seconds?"

---

## EXCEPTION -- EXPERT/TECHIE AUDIENCE

When content is explicitly directed at IT professionals, technical
media, security reviewers, or other expert audiences (e.g., the
B2B/Expert Positioning Statement, technical documentation,
developer-facing material), use precise technical language appropriate
to that audience. Always confirm which audience a piece is for before
drafting if it isn't obvious -- default to layman's terms if unstated.

---

## USER-FACING CLARITY

Every prompt, key label, and instruction shown to the user must state
exactly what each action does. Never say "press X when done" if X and
"done" mean different things -- spell out the outcome of each choice.
Test: could a non-technical senior user predict exactly what will
happen before pressing the key?

Example (correct): "Press Enter to copy. Press Esc to exit without copying."
Example (wrong): "Press Enter or Esc when done."

This applies to every piece of user-facing text: prompts, key labels,
status strings, review copy, confirmation screens.

---

## BUSINESS MODEL ACCURACY

Assisted/screen-share sessions are a planned future offering, not part
of launch scope -- always describe them as "planned" or "roadmap,"
never as currently available, in any marketing or presentation
material. This is distinct from beta-testing screen-share sessions
(the testing methodology), which are active now.

---

## ACCURACY NOTE

Do not describe GatewayGuard as "open-source" unless it has an actual
public repository and OSI-approved license attached. Use
"source-visible," "fully auditable," or "transparent, plaintext code"
instead -- these support the same trust argument without an easily
disprovable claim.

---

## ALL USER-FACING CONTENT

All GatewayGuard user-facing content (tool text, guide copy,
marketing, FAQ) must be plain English, zero jargon. Test: "Would a
non-technical neighbor understand this in 5 seconds?" If a request or
draft contradicts source documentation already in this workspace, flag
the discrepancy rather than guessing or smoothing it over.

---

## CONFIRM BEFORE ACTING -- NARROWED TO THE UNRECOVERABLE (revised 2026-08-12)

**The test is not "is this big?" It is "can this be undone?"**

Bill, 2026-08-12: *"All this tracking, committing and pushing. Can it be
done automatically by you -- why do I need to approve it? Most of the time
I don't know what I am approving."* And, after it kept happening:
*"How do I stop all these unnecessary asks?"*

**The old rule asked for confirmation before any change touching more than
one file.** That is most real work, and it made Bill the reviewer of file
lists at the end of long sessions -- the worst-placed reviewer for that
decision, approving things he had no way to check. It protected nothing and
cost him the thing he is paying for, which is not having to hold the
details.

### The test, and it is the whole rule

**Imagine both answers. If you would do the same thing either way, it was
never a question -- it was you looking for cover. Act.**

*"Should I commit this?"* has one right answer and Claude already knows it.
*"Want me to write the script?"* -- he asked for the script two messages
ago. Applied honestly this kills almost every question.

### ASK ONLY THESE. The list is exhaustive

1. **Two real paths with different consequences, and the choice is Bill's**
   -- product decisions, money, anything customer-facing. *"Should customer
   logs upload to your OneDrive?"* is a real question. *"Should I commit?"*
   is not.
2. **Deleting anything not recoverable** -- untracked files, or files with
   uncommitted changes. **"Tracked" was the wrong test; "committed" is the
   test.** A committed file's blob survives `git rm`. Verify with three
   commands -- `git log` on the path returns a commit, `git diff HEAD`
   returns zero lines, `git cat-file -e HEAD:<path>` succeeds -- then delete
   and say so.
3. **Force push and history rewrite.** Not about recoverability -- they
   change what *other* copies believe, and this repository is read by Cloud.
4. **Work outside the stated task**, where doing it would widen the job Bill
   asked for.

### What replaces permission

**Act, then report: what changed, the evidence it worked, and how to undo
it.** The undo line does the job permission was pretending to do, and it is
better, because it survives the session. Put the recovery command in the
commit message.

**Banned phrasings -- these are asks wearing politeness as a disguise:**
"Want me to…?", "Shall I…?", "Say if you'd rather I hold it", "Let me know
if you want…", and any closing line handing back a decision already made.

### Two things this does NOT relax

- **The stated scope is still the deliverable.** Acting without asking is
  not licence to widen the job. That is exception 4.
- **Verify before destroying.** Every delete this session was preceded by a
  measurement: 26 personal documents SHA256-matched against
  `OneDrive\Personal\` before `Attachments\` was removed; every log hashed
  before its source was deleted. **Not asking raises the bar on checking,
  it does not lower it.**

**`CLAUDE.md` carries this same rule as DO NOT ASK. ACT, THEN REPORT.**
Where the two differ, this document wins per UNIVERSAL WORKING RULES -- but
they were written together and should not differ. If they do, one was
edited alone and that is the defect.

*The 2026-08-06 clarification -- "confirmation is not repeated once given;
re-asking in different words is friction" -- was this rule already arguing
with itself. This revision finishes the argument.*

---

## PLAIN LANGUAGE RULES (effective 2026-08-02)

These three word-level rules sit inside the PlainLanguage section and
apply to ALL user-facing copy: tool screens, website, guide, marketing,
FAQ, emails. No exceptions.

**Rule PL-1 -- BANNED WORDS: "whether" and "whereas"**
Never use either word anywhere user-facing.
- "Whether" hedges. It describes what was looked at instead of what
  was found. Replace with "if": "Checkup checks if X is on."
- "Whereas" is formal/legalistic and has no place in plain English.
- Substitutions: *whether X* -> "if X"; *not sure whether* -> "cannot
  remember"; *applies whether A or B* -> "applies when A or B";
  *asked whether to* -> "asked for your permission to".

**Rule PL-2 -- CHECKUP'S VERB: "turn on/off", never "switch"**
The action verb for changing a setting is always "turn on" or "turn
off". Never use "switch" as a verb for a setting change.
- Wrong: "Checkup can switch it off."
- Right: "Checkup can turn it off."
- **The noun survives, and only the noun** -- the toggle control on
  screen ("the Memory integrity switch. It should say On."), or a
  physical device. Nothing else.

**The powering-on exemption is withdrawn (Bill, 2026-08-12).** This rule
formerly also exempted powering a machine on, quoting wake-on-lan's
*"switch on hundreds of computers overnight"* as "a different verb
entirely. Leave it." All five occurrences in `wake-on-lan.html` are now
turn/turning, and no page in the 19-page set contains "switch" in body
text. **The verb rule is unconditional.**

Two reasons the exemption went, and the second is the general lesson:

1. **The reader cannot tell which sense they are reading.** A senior meets
   "switch your PC on" and "turn Memory integrity on" on the same site
   with no way to know one is exempt. One verb for one action is the whole
   point of D-18.
2. **An exemption written as a quoted sentence protects only that
   sentence.** It named one occurrence and left four others on the same
   page unaddressed and unflagged -- which is how that page came to hold
   five, of which a narrow verb regex found three. **Write exemptions as
   categories or not at all.**

**Rule PL-3 -- NAME THE PERMISSION: every setting change says the
user approved it**
Any sentence describing what Checkup does to a setting must name the
user's permission. This is the product's central promise -- Checkup
never applies anything the user did not choose.
- "Checkup turned it off with your approval."
- "Checkup asks your permission before making any change."
- Where Windows forbids programmatic change: "Windows does not allow
  any program to change this, so Checkup shows you the exact steps
  to do it yourself."

**Rule PL-4 -- NO UNVERIFIED SUPERLATIVES (added 2026-08-10)**
Never write "most", "everyone", "no one else", "the only", or "always"
about the market, competitors, or users unless a named source supports
it. Prefer accurate, defensible wording.
- Wrong: "works perfectly alongside your antivirus"
- Right: "works alongside your antivirus"
- Wrong: "most security tools collect your data"
- Right: "many security tools collect usage data"
Substitutions: *most* -> "many"; *everyone* -> "many people";
*no one else* -> "few competitors"; *always* -> "in every case we have
tested".

**Why this is a trust rule, not a style rule.** An easily disproved
superlative does more damage to the trust argument than a weak claim
does. One reader who finds a counter-example has a reason to doubt
everything else on the page.

*This rule was being enforced before it was written down.*
`GatewayGuard_TrustSection-2026-07-16.md` cites "the superlative rule" by
name and applies it -- "work perfectly alongside" -> "work alongside" --
while no governing document defined it. It lived only in Bill's profile
instructions, where no grep and no gate could reach it.

---

## CHECKUP NAME RULE (effective 2026-08-02)

The product is named **GatewayGuard Checkup**. In any document,
page, or screen:
- First mention: **GatewayGuard Checkup** (full name)
- All subsequent mentions on the same page/screen: **Checkup** alone

Never use "GatewayGuard Checkup" more than once per page. Never use
"Checkup" before the full name has appeared. Never use "the tool",
"the program", or "it" as the subject when "Checkup" is clearer.

---

## SESSION LENGTH WARNING (effective 2026-08-02)

Long sessions degrade rule adherence. When any of these signals appear,
flag it and suggest starting a new chat before continuing:

- This conversation has produced more than 10 files or major deliverables
- A rule stated earlier in the session was forgotten or violated
- Bill has to re-explain something already covered this session
- A response feels uncertain about project context that should be clear
- We are about to start a new major task (new build, new document, new topic)

**Format when flagging:**
"This session is long -- rule adherence may be degrading. Suggest starting
a new chat before we continue with [next task]. Upload any new files to
the project first so context is preserved."

Before suggesting a new chat, always:
1. Deliver any files that are in progress
2. Produce an updated _READ-FIRST-Briefing with current session summary
3. List what was completed this session and what is still pending

---

## SESSION START

At the start of every session:
1. Ask which machine Bill is working on (MACHINE CHECK above).
2. **Establish the date and time before producing any dated file -- see
   THE CLOCK under FILE NAMING & VERSIONING.** Read the clock yourself if
   you can run commands (`Get-Date`); ask Bill only if you cannot. Once
   established, it stands for the session.
3. Read GatewayGuard_CodingStandards.md before any .ps1 build.
4. Read GatewayGuard_DefectPreventionPlaybook.md Appendix A AND
   class descriptions before any .ps1 build.
5. **Read CLAUDE.md before any .ps1 build, any build-number increment,
   and any bulk edit across the tree.** See CODING STANDARDS above for
   what it carries that nothing else does -- in particular the
   never-rename identifier list.
6. Check project knowledge for current build status and open items --
   including the most recent TestHistory, which outranks this document
   on any question of machine state.

---

## UNIVERSAL WORKING RULES (added 2026-08-10)

**Bill's profile instructions carry rules that apply to every project he
works on, not only this one** -- tone, sourcing, the clock, time zone,
cross-file sync, user-facing clarity, and confirm-before-acting. They load
into every conversation automatically.

**They are invisible to grep, to git, and to every gate.** They live in a
settings box. No check in this project can read them, and no review will
ever surface them.

**The current text is filed at `ProjectDocs\Profile_Instructions_Universal-*.md`
-- glob the newest by the date in the filename.** That file is a COPY, not
the source. The source is the settings box, and the copy goes stale the
moment the box is edited. Re-file it whenever the box changes.

**Where this document and the profile cover the same ground, THIS DOCUMENT
WINS.** The profile's job is the projects where these instructions are not
loaded. Report any conflict you find rather than silently following one
and dropping the other.

**Measured 2026-08-10:** the profile and this document disagreed on three
points at once -- the clock, the number of HTML delivery gates, and the
W3C warnings threshold. All three are corrected in this version. That is
what an undocumented dependency costs.
