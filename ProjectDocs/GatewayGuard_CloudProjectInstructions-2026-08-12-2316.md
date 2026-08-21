<!-- Dated: 2026-08-12 23:16 ET -->
# GatewayGuard -- Cloud Project Instructions (the text for the settings box)
- **Document Name:** GatewayGuard_CloudProjectInstructions
- **Last Modified:** 2026-08-21 13:35 ET
- **Last Editor:** Claude Code (CGDELL)
- **Status:** Cumulative Master Document
- **Purpose:** the exact text that belongs in the Claude.ai project's
  **Project Instructions** field. Bill copies the block below into that box.
- **Change History Log:**
  - 2026-08-21 13:35: **The panther-phrase freshness check is retired -- the
    start-of-conversation step now reads the four-value stamp instead.** Caught
    by Cloud reviewing this doc against `CURRENT.md`: the stamp mechanism was
    added to this file's history on 2026-08-12 22:37, but the numbered
    start-of-conversation procedure still told Cloud to find *"local account
    named panther"* in the briefing -- nine days of drift between the recorded
    fix and the actual instruction. The stamp is strictly better: generated so
    it cannot drift, and it says stale *by how much*. Updated `Start-Claude-Cloud.txt`
    in the same edit, per this file's own WHEN-TO-REVISIT rule. The main pasted
    block already used the stamp; only the numbered list lagged.
  - 2026-08-12 23:16: **THE TEN-MINUTE RULE added.** If ten minutes of diagnosis has not produced a cause, stop and write up an issue for Bill to take to Claude support -- environment, expectation, what happened, every check with its actual output, numbered questions, why it matters. Then stop. **Earned the same day:** four wrong diagnoses over most of a day, settled by one support reply, on facts no amount of measuring the repository could have found.
  - 2026-08-12 22:37: **Anthropic support answered. Sync is manual; there is NO way to see which commit a snapshot reflects.** So a stale snapshot is indistinguishable from a current one from inside the conversation -- a design constraint, not a bug. **Fix, proposed by Cloud: put the stamp inside the payload.** `CURRENT.md` now opens with its generation time, commit hash, commit date and commit subject; reading the file IS reading the sync date. A sentinel says stale or not stale, a stamp says stale BY HOW MUCH. **Also corrects this block's opening false premise** -- it said "Everything you need is in the repository. Read it there", which Cloud can never do; it reads a copy of unknown age. Third capability error in this file. **And Cloud withdrew its own bug report**: what it remembered as live repo access on 2026-08-11 was path-prefixed project-knowledge results. Nothing regressed; there was never a live tool.
  - 2026-08-12 21:34: **THE CONNECTOR IS NOT A TOOL -- IT IS PROJECT KNOWLEDGE, and this block forbade it.** A GitHub connector indexes the repository INTO project knowledge, reachable via `project_knowledge_search`. It never appears in the tool registry. This block said "do not answer from project knowledge", written to block stale uploads; it blocked the connector, because both live in the same place. Cloud obeyed exactly. **Three wrong diagnoses preceded this one** -- the glob instruction, a stale index, then no connector at all -- each consistent with the evidence at the time. Corrected: use `project_knowledge_search`, and distrust a SOURCE rather than a TOOL, discriminating by source filename against `CURRENT.md`. **Second capability claim in this block written from assumption and corrected by the reader.**
  - 2026-08-12 18:00: **First live run. Cloud refused to answer and was right to,
    and it corrected two errors in this block.** (1) "You cannot run commands"
    was FALSE -- Cloud has a bash tool, in an isolated container with no
    checkout and a UTC clock. Restated accurately; the clock rule stands, with
    its reason. (2) "Do not answer from anything pasted" OVER-BLOCKED -- read
    literally it forbids Bill pasting CURRENT.md into the chat, which is the
    main workaround when the connector is down. Pasted content is now
    explicitly allowed and must be labelled as pasted. **A capability claim
    about the reader is a factual claim** and falls under RESEARCH BEFORE
    STATING; the reader knew better than the instruction did.
    **Also settles the 2026-08-11 failure: there was no GitHub connector in
    the conversation at all** -- not the glob, not a stale index.  - 2026-08-12 17:26: **Created.** `SyncPlan` 5a has required since
    2026-08-09 that Cloud's Project Instructions hold a POINTER, not a copy.
    **No file ever contained the pointer text**, so there was nothing to copy
    from and the box kept getting a whole document pasted into it instead.
    **Measured 2026-08-12:** the box held a full 794-line copy of
    `ProjectInstructions-2026-08-10-1606` -- 175 lines and two days behind the
    current version, looking complete and authoritative, with no way for Cloud
    to know. A rule with no artifact is a rule nobody can follow.

---

## WHY THIS FILE IS IN ProjectDocs

`Start-Claude-Cloud.txt` lives at the repository root, which is **outside the
connector scope** -- Cloud cannot open it. `SyncSetupSteps` records that
limitation and left it standing.

This file is in `ProjectDocs/`, which **is** in scope. So Cloud can read its
own Project Instructions and confirm the box matches. **Ask it to.** An
instructions field nobody can audit is how the box drifted two days stale
without anyone noticing.

---

## WHAT TO DO

1. Open the GatewayGuard project at claude.ai.
2. Open **Project Instructions**.
3. **Delete everything in the box.** All of it.
4. Paste the block between the markers below.
5. Delete every file in **project knowledge**. They outrank the connector in
   retrieval, so a stale upload wins over a current commit. If something
   exists ONLY there, harvest it into `ProjectDocs/` first.

---

## THE BLOCK -- paste this into Project Instructions

---------------- COPY FROM HERE ----------------

This project has a GitHub connector. **It does not give you live repository
access.** It syncs selected files into project knowledge, and you read that
copy. The copy can be days old and nothing in the interface will tell you.
Confirmed by Anthropic support, 2026-08-12.

**So the first thing you do is say how old your copy is.**

Search project knowledge for `ProjectDocs/CURRENT.md` and read out its
FRESHNESS STAMP -- generated time, commit hash, commit date, commit subject.
**Four values, in your first reply, before anything else.** Bill compares them
against what Claude Code last pushed. That is the only way either of you can
tell what you are actually looking at.

**If `CURRENT.md` does not surface at all, your copy predates 2026-08-12.
Say so and stop.**

**USE `project_knowledge_search`. That is where the connector puts the
repository.** A GitHub connector on a Claude.ai project is not a tool you
call -- it indexes the repository INTO project knowledge. Searching project
knowledge IS reading the repository.

**What to distrust is a source, not a tool.** Two different things sit in
project knowledge:

- **Repository content, via the connector** -- current, versioned, dated.
  **This is what you want.**
- **Manually uploaded files** -- frozen whenever someone uploaded them, and
  they outrank the connector in retrieval. **Do not answer from these.**

**Tell them apart by naming the source file of every hit and checking it
against `CURRENT.md`.** If a hit comes from a filename `CURRENT.md` does not
list as current, say so rather than quoting it.

**Do not answer from these instructions or from memory.** Both are stale by
construction -- this box cannot carry an expiry date.

**Content Bill pastes into the conversation IS acceptable**, and often it is
the only path available. Use it, and **say plainly that you are working from
pasted text rather than from the repository**, so neither of you forgets
which it was.

**If you cannot reach the repository, say so and stop.** Do not substitute
memory and do not soften it -- "I cannot open the file" and "I could not find
the phrase" are different findings with different fixes, and reporting the
second when the first is true sends Bill after the wrong problem.

**At the start of every conversation, before anything else:**

1. Find `ProjectDocs/CURRENT.md` -- **search project knowledge for it; that
   is where the connector puts the repository.** It names the current version
   of every governing document. It is generated by script and its filename
   never changes, so it is the only filename you should ever be told.
2. **Read back the four freshness values at the top of `CURRENT.md`** --
   Generated, Commit at generation, That commit was made, and Its subject
   line -- and state them in your first reply. Bill compares them against
   what Claude Code last pushed; a mismatch is one line instead of five
   searches. **If `CURRENT.md` is absent, or its stamp looks old, say so and
   stop.** Do not report on documents you could not confirm you are reading.
   The stamp travels inside the file, so reading it IS reading the sync date --
   it replaces the old "find the panther phrase" discriminator, which asked
   for a string that could land on a stale file and pass while reading it.
3. Read the briefing, the session log and the project instructions that
   `CURRENT.md` names, plus `CLAUDE.md` at the repository root.

**Then, before doing any work, report:**
- The current build number, and whether it has been field run.
- The top three open items.
- Anything you checked and found already stale.

**Then stop and wait.** Do not start work until Bill says what you are doing.

**Standing rules:**

- **Never write a filename from memory.** Filenames in this project change
  constantly. Take every one from `CURRENT.md`.
- **Label every factual claim** with its basis: **measured** (ran it, output
  shown), **sourced** (documented, with the link), **inferred** (reasoning,
  could be wrong), **guess**. An unlabelled claim is being asserted as fact.
  Only *measured* and *sourced* may enter the tool or user-facing copy.
- **You may have a bash tool, in an isolated container with no checkout of
  this repository and a UTC clock.** It cannot reach Bill's files, and **UTC
  is not US Eastern** -- it differs by hours or by a calendar day, which is a
  wrong version label on every file named from it. **Ask Bill for the date and
  time, and say that is why you are asking.** Use the container for anything
  it is genuinely good for; never for repository state or the clock.
- **You cannot glob the repository** -- you cannot list a folder or sort one
  by filename date. If an instruction tells you to find the newest file that
  way, say you cannot and use `CURRENT.md`.
- **If these instructions conflict with the repository, the repository wins**
  and tell Bill about the conflict.
- **THE TEN-MINUTE RULE.** If roughly ten minutes of diagnosis has not
  produced a cause -- not a theory, a cause -- **stop and write up an issue
  for Bill to take to Claude support.** Include the environment, what you
  expected, what happened, **every check you ran with its actual output**,
  numbered questions, and why it matters. Then stop; do not keep theorising
  while he asks. **When the answer comes back, apply it and correct anything
  you got wrong** -- that correction is the most valuable part.
  *Earned 2026-08-12: "why can't Cloud see the current files" took most of a
  day and four wrong diagnoses. One support exchange settled it. Nothing in
  the repository could have revealed the answer, so more measuring would never
  have found it.*

----------------- COPY TO HERE -----------------

---

## FIRST LIVE RUN, 2026-08-12 -- IT WORKED, AND IT CORRECTED ME TWICE

**Cloud refused to answer, and that was the right answer.** It measured
before concluding -- `ls /mnt/project/` returned 0, `find` for `CURRENT.md`,
`ProjectDocs` and `.git` returned nothing, uploads were empty, and a search of
the connector directory returned no GitHub connector. Then it said *"Stopping.
I cannot read the repository"* and answered none of the three questions,
because every answer would have come from memory.

**It also drew a distinction I had blurred:** *"Not 'cannot find the phrase'
-- cannot open the file. Reporting 'old snapshot' would itself be a fabricated
finding."* Correct. Those are different findings with different fixes.

**This settles a question open all day.** The 2026-08-11 failure was blamed on
the glob instruction, with a stale connector index as the second suspect.
**Neither.** There was no connector in that conversation at all. A6 passed on
2026-08-11 at 14:45, so one existed then -- so either the chat was opened
outside the project, or the connector was removed since. **Check that the
chat is started inside the GatewayGuard project before diagnosing anything
else.**

**Two corrections it raised against this block, both of which it was right
about, both now applied above:**

1. **"You cannot run commands" was false.** Cloud has a bash tool. It runs in
   an isolated container with no checkout of this repository and a UTC clock,
   so the effect for repository work is the same -- but the blanket claim
   could mislead in a session where the container is useful. Now stated
   accurately, with the clock rule unchanged and its reason given.
2. **"Do not answer from anything pasted" over-blocked.** Read literally it
   forbids Bill pasting `CURRENT.md` into the chat -- which is the main
   workaround when the connector is down. Cloud flagged it rather than
   quietly picking an interpretation, which is what the instruction to report
   conflicts is for. Pasted content is now explicitly allowed, and must be
   labelled as pasted rather than read.

**The lesson for writing these blocks:** a capability claim about the reader
is a factual claim and falls under RESEARCH BEFORE STATING like any other. I
wrote "you cannot run commands" from an assumption about what Cloud can do,
and the reader knew better than the instruction did.

## SYNC IS MANUAL. THE FRESHNESS STAMP IS THE ONLY SIGNAL. (2026-08-12)

**Anthropic support, 2026-08-12, on a report Cloud filed itself:**

1. **The GitHub connector exposes no live "read repo" tool.** It syncs
   selected files into project knowledge ahead of time. Seeing no GitHub tool
   in the session is **expected behaviour, not a fault.**
2. **To refresh: the "Sync now" icon in the project's GitHub connector
   settings.** If it fails silently, check Settings -> Connectors -> GitHub,
   then disconnect and reconnect.
3. **There is no documented way to see which commit a snapshot reflects.**
   Support could not confirm one exists.

**Point 3 is the one that matters, and it is a design constraint, not a bug.**
A stale snapshot is indistinguishable from a current one from inside the
conversation. In a project whose documents change several times a day, that
produces confident answers about a version that no longer exists -- worse than
no access, because it looks like success.

**The fix needs nobody's permission: put the stamp inside the payload.**
`CURRENT.md` now carries its own generation time, commit hash, commit date and
commit subject as its first section. **Reading the file IS reading the sync
date.** Cloud proposed this, and it is better than the sentinel phrase it
replaces: **a sentinel says stale or not stale; a stamp says stale by how
much.** The sentinel stays as a second check -- it is what caught this at all.

**And Cloud corrected its own bug report, which is the part worth keeping.**
It had reported the connector as regressed -- working 2026-08-11, absent
2026-08-12. On support's answer it withdrew that: what it remembered as "naming
repo file paths" was path-prefixed project-knowledge results, exactly what it
saw on both days. **There was never a live tool. Nothing regressed.** The
apparent regression was an inference from its own memory of a previous session,
which is the one source these rules say not to trust.

**What this block got wrong, now fixed above:** it opened *"Everything you need
is in the repository. Read it there."* **That is not possible and never was.**
Cloud can only ever read a copy of unknown age. An instruction resting on a
false premise about the reader's capability is the third such error in this
file -- see the two entries below on "you cannot run commands" and "do not
answer from project knowledge."

## THE CONNECTOR IS NOT A TOOL. IT IS PROJECT KNOWLEDGE.

**This is the correction that cost 2026-08-11 and most of 2026-08-12.**

A GitHub connector on a Claude.ai project does **not** appear as a callable
tool. It **indexes the repository into project knowledge**, reachable through
`project_knowledge_search`. There is nothing in the tool registry to find,
and looking there and finding nothing proves nothing.

**Measured 2026-08-12**, from Cloud's own tool inventory: `search_mcp_registry`
returned the connector directory with **no GitHub connector**, while the
project demonstrably has two connector entries covering four paths. Both facts
are true, and they are not in conflict -- the entries were never going to
appear in that registry.

**And this block forbade the only tool that could read the repository.** It
said *"do not answer from project knowledge."* Written to block **stale
uploads**; it blocked **the connector**, because both live in the same place.
Cloud obeyed exactly and reported *"Searchable, but your instructions forbid
answering from it. I have not touched it."*

**So the diagnosis went through three wrong answers before this one:** the
glob instruction, then a stale connector index, then no connector at all.
Every one was consistent with the evidence available at the time. The actual
cause was an instruction written by someone who did not know how the
connector surfaces -- and it produced a silent, total failure that looked
like a platform fault.

**What to distrust is a SOURCE, not a TOOL.** Repository content and stale
uploads share one search surface. The discriminator is the source filename,
checked against `CURRENT.md` -- not which tool was called.

**The general rule:** before writing an instruction that forbids a tool,
establish what that tool actually reaches. A prohibition is a factual claim
about capability, and falls under RESEARCH BEFORE STATING like any other.
That is the second capability claim in this block to be written from
assumption and corrected by the reader -- see the 2026-08-12 entry above on
"you cannot run commands."

## WHY THE BOX HOLDS A POINTER AND NOT THE DOCUMENT

**A copy in the box looks finished.** Cloud has no reason to consult the
connector when it already holds something complete and authoritative, so it
answers from the copy -- and the copy cannot carry its own expiry date.

The repository version is dated, versioned, and diffable. The box is none of
those things. **Everything volatile belongs on the far side of the connector;
the box holds only what never changes.**

## WHY THE FRESHNESS STAMP REPLACED THE PANTHER PHRASE

**The panther phrase was a discriminator: a string unique to current
documents, so finding it proved you were reading a current snapshot.** It
worked, but it was fragile. "panther" alone appeared 23 times across 14 files
(measured 2026-08-12), including two where it was only Bill's name on a header,
so the check had to ask for the whole phrase *"local account named panther"* --
and even then it was worth exactly as much as the uniqueness of that string.
A discriminator can only ever tell you stale or not stale.

**`CURRENT.md`'s stamp is strictly better, for two reasons.** It is
**generated**, so it cannot be forgotten or drift the way a hand-placed phrase
does; and it says stale **by how much** -- the commit hash and date let Bill
see exactly how far behind a snapshot is, not merely that it is behind. Reading
the file IS reading the sync date. The stamp made the phrase check redundant,
and this file carried the phrase check for nine days after the stamp existed.
That drift is what retired it.

**The general rule still holds, pointed at the stamp:** a freshness check is
worth what its signal is worth. The stamp's signal is a commit hash, which is
as unique as a check can be.

## WHEN TO REVISIT THIS BLOCK

**It should change almost never.** That is the design -- the volatile detail
arrives through the connector. Revisit only when:

- `CURRENT.md` stops opening with the four-value freshness stamp, or its
  field names change. Then update the read-back step here and in
  `Start-Claude-Cloud.txt` in the same edit.
- `CURRENT.md` is renamed or moved. It should not be.
- The connector scope changes and `ProjectDocs/` leaves it.

## RELATED

- `Start-Claude-Cloud.txt` -- what Bill pastes as the first CHAT MESSAGE. The
  two overlap on purpose: the box covers every conversation automatically, and
  the pasted block is the belt-and-braces for a project whose box was not set.
- `GatewayGuard_SyncPlan-*.md` section 5a -- the rule this file implements.
- `Tool/Update-Current.ps1` -- generates `CURRENT.md`. Run at session end.
