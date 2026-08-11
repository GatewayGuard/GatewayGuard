<!-- Dated: 2026-08-11 00:16 ET -->
# GatewayGuard -- Sync Setup Steps (Claude Code <-> Claude Cloud)
- **Document Name:** GatewayGuard_SyncSetupSteps
- **Last Modified:** 2026-08-11 00:16 ET
- **Last Editor:** Claude Code (CGDELL)
- **Status:** Working procedure -- follow at the keyboard
- **Companion to:** `GatewayGuard_SyncPlan-*.md` (the what and why; this is the how)
- **Change History Log:**
  - 2026-08-11 00:16: **THE ORDER WAS WRONG, AND IT WAS WRONG AGAINST A
    DECISION ALREADY MADE.** This document ran 0b-4 -- delete every manual
    upload -- BEFORE Part A connects the repository and A6 proves it. So it
    told Bill to empty project knowledge and only then find out if the
    connector worked. **Project knowledge cannot be restored by any tool, so
    that ordering had no recovery path.** The correct order was settled in
    conversation on **2026-08-09 at 18:28**: *"merge ProjectNotes -> commit ->
    push -> connect -> verify with the quote test -> THEN delete the uploads."*
    It was never written into this document. Bill caught it on 2026-08-10 by
    remembering the conversation this document contradicts. **A decision that
    lives only in a chat is a decision the next document will overwrite** --
    which is the exact rule restored to ProjectInstructions the same evening.
    0b-4 now carries a hard prerequisite gate.
    **A6 also widened from one target to four.** It tested `CLAUDE.md` alone --
    the single file ticked at the repository ROOT, inside none of the three
    folders. A folder that silently failed to attach would leave A6 passing,
    and 117 uploads would then be deleted on that evidence. It now quotes one
    file per ticked item, with an answer key measured 2026-08-11.
  - 2026-08-10 11:19: **`START-HERE.txt` was renamed to
    `Check-Claude-Cloud.txt`**, and the pointer in Part B updated. The Claude
    Code half of that file has moved to a separate `Start-CC.txt`, which adds
    `Get-Date`, a working-root confirmation and `git status` -- none of which
    Cloud can do, which is why the two are now separate files rather than one
    that claimed to serve both. **Both sit at the repo root and are therefore
    outside the four-item connector scope in A5**, so Cloud still cannot read
    either one. That is the same limitation the Part B note already records,
    unchanged by the rename.
  - 2026-08-09 22:39: **Rewritten against Claude Cloud's review**
    (`GatewayGuard_SyncDocsReview-2026-08-09-1635.md`, 28 findings). Ten
    applied here:
    **Scope back to FOUR, and stated once.** The 14:35 entry below added
    `.claude` as a fifth item. Cloud flagged that as the highest-risk step in
    the document -- `.claude` is a dot-folder and may not be selectable in the
    picker at all, so the correction rested on an assumption nobody could
    check. Fixed at the source instead: the rule body moved to
    `WebSite\Rules\website-copy.md`, which was already in scope. A5 now says it
    is the single source of truth for the scope.
    **A6 no longer names a retired file.** It pointed at a briefing by exact
    timestamped filename -- a file the briefing itself retires -- so following
    the documents in order made the test fail on a working connection and then
    told you that meant it was broken. It was also a breach of rule 7a inside
    the document that teaches rule 7a. Now targets `CLAUDE.md`, which never
    gets a date-time suffix.
    **PART 0 harvests TWO boxes, not one.** Personal preferences / profile
    instructions is a separate box, holds live rules (USER-FACING CLARITY, file
    naming, time zone), and was missed entirely.
    **A3/A4 order inverted.** Authorization comes first; the picker only lists
    repos the App has been granted. The repo is selected from a filtered list,
    not typed into a free-text field.
    **0b-1 now warns that Cloud's file list is a floor, not a set** -- long
    verbatim enumerations are where Cloud fails silently, and 0b-4 deletes
    whatever the list missed. Added the ask-twice and get-the-zip mitigations,
    staged deletion, and the binary-signature check.
    **0b-5 demoted to informational** -- Cloud does not reliably know
    provenance. A6 is the real verification.
    Also: "tick folders not files" reconciled with `CLAUDE.md` on the list;
    "no webhook" hedged from asserted fact to operating assumption;
    connector-facing paths switched to forward slashes; "no tool can delete
    from project knowledge" stated where 0b-4 depends on it.
  - 2026-08-09 14:35: **Connector scope corrected from four items to five --
    `.claude` was missing.** *(Superseded 22:39 -- the rule moved instead.)* It is easy to overlook: the name starts with a
    dot and it holds three files. But one of them is
    `.claude/rules/website-copy.md`, the website-copy-must-match-the-guide
    rule, which `CLAUDE.md` relocated there on 2026-08-02 and replaced with a
    pointer.
    **Measured 2026-08-09:** Cloud's copy of `CLAUDE.md` still carries that
    rule as full inline text, because its snapshot predates the move. So
    connecting the four as previously written would have taken a rule Cloud
    already had and made it invisible -- the switch would have lost ground.
    Found by hash-comparing the project-knowledge archive against the tree.
    Connector total corrected 343 -> 346 files.
  - 2026-08-09 07:17: **Added PART 0b -- reconcile Project Knowledge, then thin
    the duplicates.** Connecting GitHub does not replace what is already in
    Project Knowledge; it adds to it. Cloud would then hold two copies of the
    same document -- an old upload and the git version -- with different
    content and nothing marking which is authoritative. That is worse than one
    stale source, because they contradict and Cloud cannot choose.
    Lists the 11 clear-cut retirements by name, and separates out **three that
    need Bill's decision rather than a guess**: a `.docx`/`.md` format pair
    sharing one timestamp (not an older version), two byte-identical copies of
    the CompanionSheet in different folders (a filing decision), and the two
    `GatewayGuide_Project_Instructions` files under the retired spelling, which
    the newest-by-date rule never compares against `GatewayGuard_*` because
    they are a different document type.
    Measured: the connector will deliver 343 files -- ProjectDocs 128, Tool 64,
    WebSite 150, CLAUDE.md 1; 64 of them are `.md`.
  - 2026-08-09 07:05: **Added PART 0 -- harvest the existing Project
    Instructions before overwriting them.** The first version went straight to
    connecting the repository and then told Bill to paste a new instruction
    block over the old one. **The box in Cloud almost certainly holds rules
    that exist in no file**, and pasting over it destroys them with no copy and
    no history. That is the same class of loss as the four Python wrappers,
    which were named in `settings.local.json` and never committed. Harvest
    first, file what is unique, then overwrite.
    Also rewrote PART A as literal actions -- which button, which box, what
    text to type -- after Bill pointed out the previous version described what
    to do without saying where or what to type.
  - 2026-08-08 20:53: Created. Step-by-step procedure to bring Claude Cloud
    and Claude Code into agreement on project files, ProjectDocs and WebSite
    files. Written after the GitHub remote was created 2026-08-08 -- none of
    this was possible before it existed.

---

## WHAT "AGREEMENT" ACTUALLY MEANS HERE

Claude Cloud cannot read your PC and cannot write to it. The only thing both
sides can see is **the GitHub repository**. So agreement means:

> Claude Code pushes to GitHub. Bill clicks Sync in Cloud. Both now read the
> same commit.

**Treat it as manual.** There is no automatic refresh -- an auto-sync webhook
is an open feature request, not a feature. That is product behaviour and could
change without announcement, so verify rather than assume. If nobody pushes and
nobody clicks Sync, Cloud is reading whatever it saw last -- which may be days
old and will never say so.

**The remote is `GatewayGuard/GatewayGuard`** -- private, owned by the
`GatewayGuard` org.

**Commit and file counts are not stated here.** They live in section 1 of the
newest `_READ-FIRST-Briefing-*.md`, and nowhere else. They were previously
written into three documents at once and all three disagreed within a day.
For a live reading, run `git status`.

---

# PART 0 -- DO THIS FIRST: HARVEST THE OLD INSTRUCTIONS

**Do not skip this. It is the step that loses rules if skipped.**

Cloud's Project Instructions box has been in use for months. It very likely
holds rules that were typed straight into it and were **never written into any
file**. Paste a new block over it and those rules are gone -- no copy, no
history, no way to know what was lost.

This is the same shape as the four Python wrappers: named in
`settings.local.json`, used to build ascii37, never committed, and now
unrecoverable.

## THERE ARE TWO BOXES, NOT ONE

This is the part an earlier version of this document missed entirely.

| Box | Where | Scope |
|---|---|---|
| **Project instructions** | inside the GatewayGuard project | that project only |
| **Personal preferences / profile instructions** | account settings, outside any project | **every** conversation |

**The profile box holds live rules.** At minimum the USER-FACING CLARITY rule,
the file-naming and header-timestamp rules, and the time-zone rule -- none of
which exist in any file Claude Code can read.

The profile box is **not** destroyed by PART B, which only overwrites the
project box. So this is not urgent loss. But those rules are unfiled and
invisible to Claude Code today, which is the identical failure PART 0 exists to
close. **Harvest both in the same pass.**

## 0a. Copy the PROJECT instructions out

1. Go to **claude.ai** and open the **GatewayGuard** project
2. Find **Project instructions** (there may be an **Edit** link beside it)
3. Click inside the box
4. Press **Ctrl+A** then **Ctrl+C** -- this selects and copies everything in it

## 0a-2. Copy the PROFILE instructions out

1. Click your initials or photo, **top-right** of claude.ai
2. Open **Settings**, then look for **Profile** or **Personal preferences**
3. Click inside the instructions box
4. **Ctrl+A**, then **Ctrl+C**

Save it the same way as 0b below, as
`ProjectDocs\CloudProfileInstructions-CAPTURED.txt`.

**If you cannot find that box**, say so rather than skipping it -- the rules in
it govern every conversation, and they are currently written down nowhere.

## 0b. Save it where Claude Code can read it

1. Open **Notepad** (press the Windows key, type `notepad`, press Enter)
2. Press **Ctrl+V** to paste
3. Press **Ctrl+S** to save
4. In the filename box, type this **exactly**, including the quotes:

```
"C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\ProjectDocs\CloudInstructions-CAPTURED.txt"
```

The quotes matter -- the folder name has spaces in it.

## 0c. Tell Claude Code to reconcile it

In the Claude Code terminal, say:

> Read ProjectDocs\CloudInstructions-CAPTURED.txt and compare it against the
> governing documents. Tell me every rule in it that exists in no file.

**Claude Code then files anything unique** into the right document -- usually
`GatewayGuard_ProjectInstructions-*.md` or `CLAUDE.md` -- commits it, and
pushes.

**Only after that push is it safe to overwrite the box.** The rules now live
in files, and the files are on GitHub.

## 0d. Why the two do not need to "mirror" afterwards

They never should. **The box holds a pointer; the files hold the content.**

A 386-line copy of CLAUDE.md pasted into a text box has no timestamp, no diff,
and nothing that signals it has drifted -- so it drifts silently and forever.
A short pointer that says "read the newest briefing, then CLAUDE.md" stays
correct no matter how much those files change.

**Mirroring is achieved by making the box small enough that it cannot drift**,
not by keeping two long texts in step.

---

# PART 0b -- RECONCILE PROJECT KNOWLEDGE, THEN THIN THE DUPLICATES

**Connecting GitHub does not replace what is already in Project Knowledge. It
adds to it.**

Cloud holds months of manually uploaded files. Once the repository connects, it
sees **both** -- the old uploaded `ProjectInstructions` and the current one
from git. Two copies of the same document, different content, nothing marking
which is authoritative. **That is worse than one stale source**, because they
contradict each other and Cloud has no way to choose.

**Measured 2026-08-09:** the connector will deliver **346 files** --
ProjectDocs 130, Tool 64, WebSite 151, CLAUDE.md 1. **Four items, no dot-folder.**
documents.**

## 0b-1. Get the list out of Cloud

In the project's chat box, **type exactly:**

```
List every file in your project knowledge. Give the exact filename of each one, one per line, nothing else.
```

## 0b-2. Save the list

1. Select the answer, **Ctrl+C**
2. Open **Notepad** (Windows key, type `notepad`, Enter)
3. **Ctrl+V**, then **Ctrl+S**
4. Filename box -- type this **exactly, with the quotes**:

```
"C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\ProjectDocs\CloudKnowledge-CAPTURED.txt"
```

### The list Cloud gives you is a FLOOR, not a set

**Cloud is unreliable at long verbatim enumerations, and the failure is
silent** -- a list with files missing looks exactly like a complete one. On
2026-08-09 Cloud twice reported a hand-transcribed listing as an exact match
when it had dropped the same files both times.

That matters here because of what happens next: 0b-4 deletes every manual
upload, and project knowledge is not a backup. **A filename dropped from the
list is never harvested, and is then deleted.**

Two mitigations, both cheap:

- **Ask twice, in separate messages, and compare the two lists.** Different
  omissions each time reveal the problem; identical lists raise confidence.
- **Better: get the zip.** Ask Cloud to build an archive of project knowledge
  and download it. A file comparison beats a filename comparison, because it
  catches files present on *both* sides with the same name and different
  content -- which a name list cannot see. On 2026-08-09 that method found two
  real problems a name list would have missed entirely.

## 0b-3. Have Claude Code compare it

In the terminal, say:

> Compare ProjectDocs\CloudKnowledge-CAPTURED.txt against `git ls-files`.
> Tell me which files exist only in Cloud.

Or, if you got the zip:

> Unzip the archive outside the tree and hash-compare every file against
> ProjectDocs, Tool, WebSite and CLAUDE.md. Report three lists: identical,
> same name but different content, and only in Cloud.

Anything only in Cloud never made it into the tree. **Download those from
Cloud before deleting anything.** Claude Code files them, commits, pushes.

**Check signatures before committing anything binary.** Cloud's copies of
`.docx` and `.pdf` are text extractions and page images, not the originals. A
real PDF starts `%PDF`; a real `.docx` starts `PK`. Committing Cloud's copy
puts an unopenable file in the tree under a name implying it works.

## 0b-4. Delete the manual uploads -- IN STAGES

> # STOP -- DO NOT RUN 0b-4 YET
>
> **0b-4 runs AFTER Part A and AFTER A6 passes. Not before.**
>
> Deleting the uploads is the only step in this document with **no recovery
> path**. No tool can restore project knowledge -- not Cloud, not Claude Code,
> not Bill. If the connector turns out not to work, and the uploads are already
> gone, the project has neither.
>
> **The two failures this guards against are both documented in this very
> document:** the "Connected but not really" bug in A6, and org single sign-on
> in A3 -- which reconnecting inside Claude does not fix.
>
> **Required order, settled 2026-08-09 18:28:**
>
> 1. Merge anything found only in Cloud -- 0b-3
> 2. Commit and push -- Claude Code
> 3. Connect the repository -- PART A
> 4. **Prove it with A6 -- all four targets, exact quotes**
> 5. *Then* delete the uploads -- this step
>
> **The risk is not symmetric.** Connecting first means Cloud briefly sees two
> copies of some documents: a correctness problem, and a temporary one. Deleting
> first means an unrecoverable loss if anything in Part A fails. Take the
> recoverable risk.

In the **Project knowledge** panel, each uploaded file has an **x** or a menu
with **Remove**. Remove the manually-uploaded files, leaving **only the GitHub
connection**.

**Do it in batches, not all at once**, and re-run 0b-3 between batches. If the
list was short by a file, a staged deletion gives you a chance to notice before
that file is gone.

**No tool can do this step.** Cloud cannot delete from its own project
knowledge, and neither can Claude Code. It is manual, in the file panel, by
Bill. This project has re-learned that more than once.

## 0b-5. Verify -- informational only

Type to Cloud:

```
How many files can you see in project knowledge, and where do they come from?
```

**Treat the answer as informational, not as proof.** Cloud does not reliably
know provenance -- content arrives in its context without always carrying a
labelled source, so asking where something came from invites a confident guess.

**A6's quote-an-exact-line test is the real verification.** Use that.

---

## 0b-6. THIN THE DUPLICATE VERSIONS IN THE TREE

Cloud will see **every** version of every document, not only the newest. The
"take the newest by the DATE IN THE FILENAME" rule keeps that safe -- but it is
a rule Cloud must remember on every question, forever. **Retiring the
superseded versions removes the ambiguity at the source instead**, which the
DOCUMENT REVISION RULE already requires: the prior version is retired when a
new one is delivered.

### Clear-cut -- 11 files, superseded by a later version of the same document

```
GatewayGuard_CPM_Schedule-2026-07-03.md
GatewayGuard_CPM_Schedule-2026-07-15.md
GatewayGuard_CPM_Schedule-2026-07-24-0638.md
GatewayGuard_CPM_Schedule-2026-07-30-2208.md
        -> keep GatewayGuard_CPM_Schedule-2026-08-02-1201.md

_READ-FIRST-Briefing-2026-08-02-1820.md
_READ-FIRST-Briefing-2026-08-06-1727.md
        -> keep the NEWEST _READ-FIRST-Briefing-*.md by filename date

GatewayGuard_DefectPreventionPlaybook-2026-07-13.md
GatewayGuard_DefectPreventionPlaybook-2026-07-25-1936.md
        -> keep GatewayGuard_DefectPreventionPlaybook-2026-07-26-0619.md

GatewayGuard_ProjectInstructions-2026-08-02-1820.md
        -> keep GatewayGuard_ProjectInstructions-2026-08-06-1727.md

GatewayGuard_M365MigrationPlan-2026-08-06-1425.md
        -> keep GatewayGuard_M365MigrationPlan-2026-08-06-1727.md

GatewayGuard_SessionHandoff-2026-07-28-1243.md
        -> keep GatewayGuard_SessionHandoff-2026-08-02-2205.md
```

The three Playbooks are the case briefing section 0 documents, where three
different ways of choosing gave three different answers and only one was right.

### Needs Bill's decision -- do NOT retire on a guess

**1. `GatewayGuard_CPM_Schedule-2026-07-24-0638.docx`**
Same date-time as the `.md`. That is a **format pair, not an older version** --
the same document exported to Word. Retiring it may throw away a deliverable.
*Decide: keep the .docx, or keep only Markdown?*

**2. `GatewayGuard_PresentationCompanionSheet-2026-07-03.md` -- two copies**
One in `ProjectDocs\`, one in `ProjectDocs\Presentation\`. **Verified
byte-identical 2026-08-09.** A pure duplicate, not a version -- but which
location is the right home is a filing decision.
*Decide: which folder keeps it?*

**3. `GatewayGuide_Project_Instructions-*.md` -- the old spelling**
Two July versions, under the retired `GatewayGuide` spelling. They are a
*different document type* from `GatewayGuard_ProjectInstructions`, so the
newest-by-date rule never compares them. They may be fully superseded, or may
hold rules that were never carried across.
*Decide: read them first, then retire both -- or carry anything unique into
ProjectInstructions.*

### How to retire

Retiring means `git rm` -- the file leaves the working tree but **stays in git
history forever** and can be recovered with
`git checkout <commit> -- <path>`. Nothing is destroyed.

---

# PART A -- CONNECT THE REPOSITORY

## A1. Confirm GitHub has everything (Claude Code, 10 seconds)

Ask Claude Code to run:

```
git status
git log origin/main..HEAD --oneline
```

**Desired state:** the second command prints nothing -- no commits sitting
unpushed. If it prints anything, push before going further.

## A2. Open the project

In a browser, go to:

```
claude.ai
```

Sign in. On the left, click **Projects**, then click **GatewayGuard**.

## A3. AUTHORIZE FIRST -- the organisation, not your account

**Do this before looking for the repository.** The picker only lists
repositories the Claude GitHub App has already been granted, so until the App
is installed on the `GatewayGuard` org, the repo is not in the list to be
found. Trying to select it first is the common way to get stuck.

The repository is **private and owned by the `GatewayGuard` org**, not by
`wfbiii`. A personal authorization is not enough. This is the step people get
wrong.

1. On the right of the project page, find the panel headed **Project
   knowledge**
2. Click **`+`** -- it may be a bare plus, or a button labelled **Add content**
3. Choose **GitHub**
4. If you are not connected yet, or the repo does not appear, follow the link
   to GitHub
5. GitHub shows a list containing **wfbiii** and **GatewayGuard**.
   **Click `GatewayGuard` -- the organisation, not your name.**
6. Choose **Only select repositories**, pick **GatewayGuard**
7. Click the green **Install** (or **Save**)
8. Return to the Claude browser tab

**If the repositories still do not appear**, the org may require single
sign-on. Each user then authorizes separately for that org. Disconnecting and
reconnecting GitHub inside Claude does **not** fix an SSO problem.

## A4. Now pick the repository

**Expect a searchable picker, not a free-text field.** Typing filters a list;
you then click the result. It is probably not a box where you type a path and
press Enter.

Start typing:

```
GatewayGuard/GatewayGuard
```

and click it when it appears in the list.

**If you type the name and nothing happens, that is not a failure** -- it means
A3 has not completed. Finish the authorization, come back, and the repository
will be in the list.

## A5. Tick exactly four things -- and nothing else

A file browser appears showing the folders in the repository. **Tick these
four:**

```
ProjectDocs
Tool
WebSite
CLAUDE.md
```

Then click **Save** (or **Add**).

**This is the ONLY scope. If any other document says three or five, it is
stale -- this line is the source of truth.**

### Why not `.claude`

An earlier version of this document said five, adding `.claude`, because
`.claude/rules/website-copy.md` held a governing rule that `CLAUDE.md` only
pointed to.

**That was fixed at the source on 2026-08-09 instead.** `.claude` is a
dot-folder, and dot-folders are routinely filtered out of file pickers as
hidden -- so the rule might not have been selectable at all, and the whole
scope correction rested on an assumption nobody could check. The rule body was
moved to `WebSite\Rules\website-copy.md`, which is inside `WebSite/` and
therefore already in scope. A path-triggered pointer stays behind in
`.claude/rules/` so Claude Code still auto-loads it on website work.

What remains in `.claude` is Claude Code machinery only -- the Class 7
integrity hook and a permissions file. Cloud does not run hooks and does not
need either.

**Do not tick a dot-folder to solve a rule-visibility problem. Move the rule.**

**Tick whole FOLDERS -- never cherry-pick files from inside one.** A folder
picks up new documents on later syncs; individually chosen files do not, so any
document written after today would simply not exist as far as Cloud is
concerned.

`CLAUDE.md` is the one file on the list, because it sits at the repository root
and is not inside any folder. That is not cherry-picking.

**Do NOT tick the top-level box that selects everything.** The root also holds:

| Folder | What is in it |
|---|---|
| `Certificates/` | driver's licence, licence images, EIN, a file named like stored credentials |
| `Heath/` | medical documents |
| `Attachments/` | a stale copy of the whole tree, plus personal business documents |
| `Builds/Documents/` | personal documents |

One click on the top-level box puts all of that into project knowledge.

## A6. PROVE it is connected -- do not trust the badge

There is a known failure where a repository shows **Connected** while its files
are not actually reachable in conversation.

### Test ALL FOUR ticked items, not just one

**`CLAUDE.md` is the single file ticked at the repository ROOT. It is inside
none of the three folders.** A test that only quotes `CLAUDE.md` proves the
connector reaches one root file and proves nothing about `ProjectDocs/`,
`Tool/` or `WebSite/`. A5 warns that folders and individually-picked files
behave differently -- so a folder that silently failed to attach would leave
this test passing, and 0b-4 would then delete every upload on that evidence.

**In the project's chat box, type exactly this and press Enter:**

```
Quote these exactly as they appear, no paraphrasing. If you cannot
open any of them, say which one and do not guess.

1. The first two lines of CLAUDE.md
2. The first line of ProjectDocs/GatewayGuard_Checklist.txt
3. The first line of Tool/Run-ExternalCommandCheck.bat
4. The first line of WebSite/Rules/website-copy.md
```

**Answer key -- measured 2026-08-11 00:16:**

| # | Ticked item | Must come back as |
|---|---|---|
| 1 | `CLAUDE.md` (root) | `# GatewayGuard -- Claude Code Project Instructions` then `<!-- Dated: ... ET -->` |
| 2 | `ProjectDocs` | `GatewayGuard Project Checklist` |
| 3 | `Tool` | `@echo off` |
| 4 | `WebSite` | `<!-- Dated: ... ET -->` |

**All four must be exact.** Any paraphrase, any "I can see that file" without
the text, any miss -- **it is not connected. Go back to A4 and find out which
folder did not attach. Do not run 0b-4.**

**Target 4 carries extra weight.** `WebSite/Rules/website-copy.md` was moved
there on 2026-08-09 specifically so Cloud could reach it, replacing a copy in
`.claude` that a file picker may hide as a dot-folder. If Cloud quotes it, the
reason for that move is confirmed. If it cannot, the move did not achieve what
it was for -- and nothing else in this procedure would tell you.

**All four targets have undated filenames on purpose**, so the test cannot go
stale. See below for what happened the last time it named a dated file.

### Why this test names `CLAUDE.md` and not a dated document

An earlier version pointed the test at a briefing by its exact timestamped
filename. **That file is retired by the very briefing it was named in** -- so
following the documents in order made the test fail on a correctly connected
repository, and then told you to conclude you were not connected.

It was also a breach of the never-write-an-exact-filename-into-a-pointer rule,
inside the document that teaches the rule.

`CLAUDE.md` never gets a date-time suffix and is never retired, so it cannot
go stale as a test target. It is also the stamp-comparison target in PART D,
which keeps both checks pointed at one file.

---

# PART B -- PROJECT INSTRUCTIONS IN CLOUD

**Do not start Part B until PART 0 is finished and pushed.**

## B1. Do not paste CLAUDE.md into Project Instructions

`CLAUDE.md` is 386 lines and changes often. A copy of it in a text box has no
timestamp, no diff, and nothing to signal that it has drifted. It will drift,
and nothing will tell you.

## B2. Paste this instead

1. On the project page, click **Set project instructions** (or **Edit** beside
   Instructions)
2. Click in the box, press **Ctrl+A**, then **Delete**
3. Paste the block below
4. Click **Save**

Put **only** this in the box. It changes almost never, because the detail
lives in files the connector delivers:

```
Read ProjectDocs/_READ-FIRST-Briefing-*.md -- take the newest by the DATE IN
THE FILENAME, not the file's modified date. Then read CLAUDE.md.

Then tell me, before doing any work:
1. The current build number and if it has been field run.
2. The top three open items.
3. Anything in the briefing you checked and found already stale.

Do not start work until I tell you what we are doing.

You do not author governing documents (ProjectInstructions, CodingStandards,
DefectPreventionPlaybook, WebsiteStandards, TestHistory, ScreenContents, the
READ-FIRST briefing, CLAUDE.md). Claude Code authors those, because it can
verify a filename or a measurement before writing it down and you cannot.
Never write an exact filename or a measured number from memory -- ask for it
to be measured.
```

That block is the same one already proven in `Check-Claude-Cloud.txt` (repo
root, outside the connector scope -- so Cloud cannot open it to confirm the
match itself). It was named `START-HERE.txt` until 2026-08-10.

---

# PART C -- THE ONGOING LOOP

Run this every time work is done. It is four steps and takes under a minute.

1. **Edit locally** -- Claude Code, in the one working tree at
   `C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\`
2. **Commit** -- Claude Code, with the superseded file retired in the same commit
3. **Push** -- `git push origin main`
4. **Click Sync** in Cloud's project knowledge panel -- Bill

**Step 4 is the one that gets forgotten**, and forgetting it is silent. Cloud
will answer confidently from the older version and give no sign it is behind.

**Rule:** push at the end of any session that produced work worth keeping. A
remote 20 commits behind is a recovery point for a version you no longer have.

---

# PART D -- THE WEEKLY AUDIT

Do this weekly, at the start of any major milestone, and more often after any
incident.

## D1. Compare the file lists

**Claude Code side:**

```
git ls-files ProjectDocs/ Tool/ WebSite/ CLAUDE.md | wc -l
```

**Cloud side:** ask it to list the files it can see in project knowledge.

**Desired state:** the counts match. A shortfall in Cloud means Sync has not
been clicked since the last push, or the connector scope lost a folder.

## D2. Compare the stamp

Ask Cloud:

> What is the stamp line at the top of CLAUDE.md?

Compare to the local file. **Different stamp = they have diverged.** Push,
Sync, ask again.

## D3. Check the tree's shape has not changed

```
git status
```

**Desired state:** the deletion count matches what you expect. **A count that
jumped since last time means a folder moved**, not that work was lost.

On 2026-08-08 `ProjectDocs\` -- every governing document -- was moved into
`Recovery Keys\` by a stray drag in File Explorer, and `WebSite\` was moved
into `Tool\`. Windows does same-drive moves with no confirmation and no undo
prompt. `ProjectDocs` was gone over an hour before anyone noticed. `git status`
had reported 126 deletions the whole time.

---

# PART E -- WEBSITE FILES: THERE ARE TWO REPOSITORIES

This is the part most likely to confuse, so read it before touching the site.

| Repository | Visibility | Holds | Files |
|---|---|---|---|
| `GatewayGuard/GatewayGuard` | **private** | `WebSite/` -- the source you edit | 150 (131 HTML) |
| `GatewayGuard/gatewayguard.github.io` | **public** | the live site at `gatewayguard.co` | 4 |

The public repository has GitHub Pages on and its `CNAME` is
`gatewayguard.co`, so the domain is already wired to it.

## E1. They are NOT currently in agreement

**Measured 2026-08-08:** the public site contains `index.html`, `404.html`,
`CNAME`, and `guide/index.html` -- **four files.** The private repo holds 131
HTML files.

**The 19 guide pages were never uploaded.** The public site has not been
pushed to since **2026-07-21**, and its `index.html` still carries an UNDER
CONSTRUCTION banner.

## E2. Which repository is authoritative for what

- **`WebSite/` in the private repo is the source.** Edit there. Cloud reads it
  through the connector.
- **The public repo is the published output.** Nothing is edited there
  directly; pages are copied in and pushed when they are ready to be public.

Keeping the source private matters: `WebSite/Index-Builds/` holds working
drafts, and the public repo is visible to anyone.

## E3. Before any page goes public

Follow the HTML DELIVERY GATE in CodingStandards -- H-1 corruption grep, H-2
browser check, H-3 W3C validation, H-4 guide-wording source. A page whose
wording source cannot be named has not passed the gate.

---

# PART F -- WHEN THE TWO DISAGREE

| Symptom | Cause | Fix |
|---|---|---|
| Cloud quotes a rule Claude Code cannot find | Cloud is reading stale knowledge | Push, click Sync, ask again |
| Cloud names a file that does not exist | A governing document was authored by Cloud | Re-author it in Claude Code against the real tree |
| Cloud cannot find a file you know is committed | Connector scope, or the "Connected but not really" bug | Re-run A5; re-check the folder selection in A4 |
| Cloud's file list is shorter than `git ls-files` | Sync not clicked since the last push | Click Sync |
| A new document is invisible to Cloud | Individual files were selected instead of folders | Re-scope to folders (A4) |
| `git status` shows a jump in deletions | A folder was moved by a stray drag | Find it and move it back -- see D3 |

**When the two disagree and you cannot tell which is right: the remote
decides.** Not the newer file, not the bigger folder, not the more confident
answer.
