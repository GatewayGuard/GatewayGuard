<!-- Dated: 2026-08-06 17:27 EDT -->
# GatewayGuard Project Instructions
- **Document Name:** GatewayGuard_ProjectInstructions
- **Last Modified:** 2026-08-06 17:27 EDT
- **Last Editor:** Claude.ai
- **Status:** Cumulative Master Document (supersedes all prior versions)
- **Change History Log:**
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
    (`GatewayGuard_TestHistory-ascii39-2026-08-02-0914.md`): CGDELL reads
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

---

## FILE NAMING & VERSIONING (effective 2026-07-20)

**One unique filename per document type, forever.**

**Filename syntax:** `[ProjectName]_[DocumentType]-YYYY-MM-DD-HHMM.ext`
**Example:** `GatewayGuard_CodingStandards-2026-07-20-0908.md`

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
- Before producing any file, Claude must ask Bill for the current date
  and time. Both the filename and the internal header come from that
  answer. Claude never infers the date or time from UTC chat metadata,
  system clocks, or conversation context -- UTC timestamps routinely
  differ from US Eastern Time by hours or a calendar day. A wrong
  date-time in the filename is a wrong version label. No exceptions:
  if the date and time have not been provided in this session, Claude
  asks before producing any output file.
  **Once Bill has given a date and time in a session, that answer stands
  for the session.** Re-asking for a fresh clock reading before every
  file is friction, not diligence. Ask once; ask again only if the
  session has clearly spanned hours or a date boundary.
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
| **SANDY** | **Local account** | **Not encrypted** | unverified | **reported by Bill** 2026-08-06; local-account state measured in FT-144 |
| **Sandy3** | unverified | **Pre-encrypted by Windows** (not by GatewayGuard) | unverified | prior session note -- **unverified**, re-measure before relying on it |

**What this matrix means for testing:**

- **SANDY is the only machine that can reach the Home + unencrypted +
  local-account branch of item 8** -- the FT-110 path, and the FT-144
  danger case where Windows will encrypt on a local account with the
  recovery key escrowed nowhere. It is the highest-value test machine in
  the fleet for that item.
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
**off**. `GatewayGuard_TestHistory-ascii39-2026-08-02-0914.md`, written
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

**Status as of 2026-08-06: ascii39 has NOT had a field run. No ascii40
may be scoped, built, or numbered until an ascii39 field log exists.**
Any plan, schedule, or migration document that instructs an increment to
ascii40 is in violation of this rule and must be corrected, not followed.

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
  `Tool\Check-ScreenCoverage-2026-07-30.ps1` (launcher
  `Run-ScreenCoverageCheck.bat`), the mechanical gate-12 check that
  also reports the next free screen ID, and `Tool\Show-AllScreens.bat`
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
gate 24, via `Tool\Run-ExternalCommandCheck.bat`, which fails any
external command lacking a `# VERIFIED <date> measured|sourced:`
comment and any screen that shows the user a raw command line. A gate
with no check is a wish.

---

## WEBSITE BUILD RULE

Before delivering any HTML file: (1) run a corruption grep, (2)
instruct the user to validate the page at validator.w3.org before it
goes live, (3) tell the user to open the file in Chrome or Edge
locally before pushing to GitHub -- Claude's preview does not render
CSS. Review full standards in GatewayGuard_WebsiteStandards.md before
any website work.

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

## CONFIRM BEFORE ACTING (effective 2026-08-02)

Before executing any multi-file change, bulk edit, delete operation,
or any action that cannot be easily undone, Claude must state what it
is about to do and wait for explicit confirmation before proceeding.

**This rule applies to:**
- Deleting any project file
- Bulk find-and-replace across multiple files
- Rebuilding or re-zipping any file set
- Any action where the scope is more than one file or one change

**Format:**
State the action, list what will be affected, then stop and ask:
"Confirm?" Do not proceed until Bill says yes or equivalent.

**Exception:** Single targeted edits within an active build session
where the scope has already been agreed do not require re-confirmation
at each step -- only at the start of the task.

**Confirmation is not repeated once given (clarified 2026-08-06).**
When Bill has stated the scope himself, or confirmed a scope Claude
proposed, that is the confirmation. Re-asking the same question in
different words is friction. Ask once, clearly, then act.

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
- "Switch" as a noun meaning a physical device (network switch, light
  switch) is acceptable in non-setting contexts only.

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
2. Ask for current date and time before producing any file. Once given,
   that answer stands for the session.
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
