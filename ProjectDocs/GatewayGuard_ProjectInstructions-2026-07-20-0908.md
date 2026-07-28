<!-- Dated: 2026-07-20 09:08 EDT -->
# GatewayGuard Project Instructions
- **Document Name:** GatewayGuard_ProjectInstructions
- **Last Modified:** 2026-07-20 09:08 EDT
- **Status:** Cumulative Master Document (supersedes all prior versions)
- **Change History Log:**
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
steps:
- Dell Latitude 5430 (CGDELL) -- Windows 11 Pro, 32GB, primary dev
- HP Notebook 17-by1955cl (SANDY) -- 8GB
- Lenovo IdeaPad (Sandy3) -- 8GB, touchpad disabled in Settings

Never assume or infer the machine from context.

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
ship, with a note of which machine covers which state.

---

## CODING STANDARDS

Before any .ps1 build, read GatewayGuard_CodingStandards.md in
project knowledge and confirm all standards are met. The pre-build
audit (DefectPreventionPlaybook Appendix A) and CodingStandards
session-end checklist must both pass before a build is presented.

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

## SESSION START

At the start of every session:
1. Ask which machine Bill is working on (MACHINE CHECK above).
2. Ask for current date and time before producing any file.
3. Read GatewayGuard_CodingStandards.md before any .ps1 build.
4. Read GatewayGuard_DefectPreventionPlaybook.md Appendix A AND
   class descriptions before any .ps1 build.
5. Check project knowledge for current build status and open items.
