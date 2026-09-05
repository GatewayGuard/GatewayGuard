<!-- Dated: 2026-08-09 16:35 ET -->
<!-- Editor: Claude.ai -->
# GatewayGuard -- Review of the Three Sync Documents
- **Document Name:** GatewayGuard_SyncDocsReview
- **Last Modified:** 2026-08-09 16:35 ET
- **Last Editor:** Claude.ai
- **Status:** REVIEW ONLY -- not a governing document, amends no rule
- **Documents reviewed:**
  - `GatewayGuard_SyncSetupSteps-2026-08-09-1435.md` (Claude Code)
  - `GatewayGuard_SyncPlan-2026-08-08-2050.md` (Claude Code)
  - `_READ-FIRST-Briefing-2026-08-09-1445.md` (Claude Code)
- **Compared against:** `_READ-FIRST-Briefing-2026-08-09-1110.md` (Claude.ai)
- **Change History Log:**
  - 2026-08-09 16:35: Created. Review findings only.

---

## HOW TO READ THIS DOCUMENT

**This is a review, not a governing document.** Under SyncPlan section 3b,
Claude Cloud reviews; Claude Code authors. Nothing here changes a rule. It
records findings for Claude Code to act on.

**Every filename appearing below is quoted from one of the three documents
under review, not written from memory.** No filename here should be treated as
a pointer.

**What was NOT checked, by instruction:** filenames, file counts, commit
counts, machine state. Those were measured against the repository and Cloud
cannot check them.

**Basis for the interface findings: `inferred`, not `measured`.** Cloud cannot
see the claude.ai interface from here, and interface labels change faster than
Cloud's knowledge of them. Where a step is called wrong below, read it as
*expect this not to match -- verify at the keyboard before trusting it.* That
is the same epistemic hole these documents are built around, and Cloud is not
exempt from it.

**Filing status:** this document exists only in chat until Bill downloads it,
saves it to the tree, and Claude Code commits and pushes it. SyncPlan section 8.

---

# PART 1 -- THE THREE THINGS THAT WILL BREAK AT THE KEYBOARD

## 1.1 The connector scope is stated three different ways -- and the briefing contradicts itself

| Document | Location | Scope stated |
|---|---|---|
| SyncPlan | 4a | **three**: `ProjectDocs/`, `Tool/`, `CLAUDE.md` |
| Briefing | section 8, item 10 | **four**: `ProjectDocs/`, `Tool/`, `WebSite/`, `CLAUDE.md` |
| Briefing | headline item 9 | **five** -- ".claude was missing, and it holds a governing rule" |
| SyncSetupSteps | A5 | **five** |

The briefing announces the four-to-five correction in its own opening banner,
then issues the four-item version in its own priority list. Whichever is
followed at the keyboard, one of them is wrong.

SyncPlan is worse. At three items it drops `WebSite/` entirely, and its
section 6b weekly-audit command inherits the omission:

```
git ls-files ProjectDocs/ Tool/ CLAUDE.md
```

That audit would compare against the wrong set every week and report a
permanent mismatch that is not one.

**Severity:** high. SyncPlan is the document the briefing's pointer table sends
a reader to first, for "what and why."

## 1.2 The A6 connection test names a file the briefing retires

A6 says to prove the connection by asking Cloud to quote:

```
ProjectDocs\_READ-FIRST-Briefing-2026-08-08-2147.md
```

The merged briefing's header says it supersedes both `-2026-08-08-2147` and
`-2026-08-09-1110`, and instructs: **retire both.**

Follow the briefing, then run A6, and the test fails on a correctly connected
repository. The document then instructs the reader to conclude *"it is not
connected -- go back to A4."*

This is also a direct breach of SyncPlan section 7a -- never write an exact
timestamped filename into a pointer -- inside the document that teaches the
rule.

**Suggested fix:** make A6 a glob-and-quote against a file that does not get
retired. `CLAUDE.md` is the obvious candidate; it is already the
stamp-comparison target in D2.

## 1.3 Part 0 harvests only one of the two text boxes

Part 0's argument is correct: a text box holding rules that exist in no file,
overwritten with no history, is unrecoverable loss.

**There are two such boxes in claude.ai.** Project instructions is one.
**Personal preferences / profile instructions is the other** -- separate, not
project-scoped, and currently holding live rules: the USER-FACING CLARITY rule,
the file-naming and header-timestamp rules, and the time-zone rule, at minimum.

Part 0 does not mention it. It will not be destroyed by Part B (different box),
so this is not urgent loss -- but it is the identical failure class Part 0
exists to close, and those rules are unfiled and invisible to Claude Code
today.

**Suggested fix:** harvest the profile box in the same pass as 0a.

---

# PART 2 -- SYNCSETUPSTEPS: INTERFACE FINDINGS

## 2.1 A3-A4: the order is probably inverted, and the repo name is probably not typed

**As written:** type `GatewayGuard/GatewayGuard` into a box, press Enter, then
a private-repo warning appears, then authorize the org.

**Expected instead:** authorization comes **first**. The repository picker only
lists repos the Claude GitHub App has already been granted. Until the App is
installed on the `GatewayGuard` org, the repo is not in the list to be
selected.

Expect a **searchable picker** -- typing filters a list, then you click the
result. Not a free-text field where typing a path and pressing Enter submits
it.

**Practical effect at the keyboard:** if you type the name and nothing happens,
that is not a failure. Do A4, come back, and the repo appears in the list.

**Also A3:** the `+` may be labelled **Add content** rather than being a bare
plus. Minor, but you are looking for a button by shape and it may have words on
it.

## 2.2 A5: `.claude` may not be selectable at all -- and the whole correction depends on it

**This is the highest-risk step in the document.**

Dot-prefixed directories are routinely filtered out of file pickers as hidden.
Whether this picker shows them is unknown to Cloud. `inferred`.

If `.claude` does not appear, the 14:35 change-history entry's own conclusion
bites: connecting the other four takes the website-copy rule that Cloud's
current snapshot holds as inline text in `CLAUDE.md` and makes it invisible.
**The switch loses ground, exactly as predicted, with no error message.**

**Two secondary risks on the same folder:**
- Connectors commonly filter by file type. `.claude/` holds a `.json` and a
  `.ps1` alongside the `.md`. The rule file may come through while the hook
  registration does not.
- If `.claude` is invisible in the picker, ticking the repo root is **not** an
  acceptable fallback, for the reasons A5 already gives.

**Decide before starting:** if `.claude` cannot be ticked, does the
website-copy rule move back into a connected folder, or does `CLAUDE.md` keep
the pointer and the rule live only where Cloud cannot see it? Bill's call, and
better made now than at the picker.

## 2.3 A5: the rule and the list disagree

> "**Tick FOLDERS, not individual files inside them.**"

The list two lines later includes `CLAUDE.md`, which is an individual file. The
intent is clear -- do not cherry-pick files *inside* a folder -- but as written
the instruction contradicts its own list. At the keyboard that reads as an
error.

## 2.4 0b-1: this step asks Cloud to do the exact thing section 11 says Cloud gets wrong

The instruction:

```
List every file in your project knowledge. Give the exact filename of each one, one per line, nothing else.
```

The briefing's own section 11 documents that in one session Cloud twice
reported a hand-transcribed listing as an exact match when it had dropped
files. **Long verbatim enumerations are where Cloud fails, and the failure is
silent** -- the list looks complete.

That would be tolerable except for what happens next:

| Step | What it does | Risk |
|---|---|---|
| 0b-3 | Files "only in Cloud" get harvested | A dropped filename is never harvested |
| 0b-4 | **Every manual upload is deleted** | That file is then removed |
| Section 9 | Project knowledge is not a backup | For anything existing only there, the loss is real |

**Suggested mitigations:**
- Do 0b-4 **in stages**, not all at once.
- Treat 0b-3's "only in Cloud" result as a **floor, not a set.** Cloud's
  omissions will look identical to correct output.

## 2.5 0b-5: weak verification

```
How many files can you see in project knowledge, and where do they come from?
```

Cloud does not reliably know provenance. Content arrives in context; it does
not always carry a labelled source. Asking where it came from invites a
confident guess -- which is what section 7 says Cloud does.

**A6's quote-a-line test is the strong verification.** Keep A6; treat 0b-5 as
informational only.

## 2.6 Labels worth hedging (both already hedged correctly)

| Step | Text | Assessment |
|---|---|---|
| 0b-4 | "an **x** or a menu with **Remove**" | Plausible; the hedge does the right work |
| Part C step 4 | "Click **Sync**" | There is a refresh affordance on a connected repo, but the word *Sync* on the control is not certain |

Both are written loosely enough to survive being wrong. That is correct
authoring.

## 2.7 Minor: path separators

Windows backslashes appear in paths that will be read by the connector -- the
A6 test and the Part B2 instruction block both use
`ProjectDocs\_READ-FIRST-Briefing-*.md`. Repository paths are forward-slash.
Probably harmless in prose; in the pasted instruction block it is the literal
text Cloud pattern-matches against.

## 2.8 One claim Cloud cannot check and would not state as flatly

> "**It is not automatic.** There is no webhook."

Correct as an operating assumption and correct to design around. But it was not
measured today, and it is product behavior that can change without
announcement.

SyncPlan 4c hedges it better -- "an open feature request." Keep the behavior,
soften the certainty. A document that asserts a product fact flatly will
eventually be wrong in the direction of complacency.

---

# PART 3 -- SYNCPLAN: WHAT MISDESCRIBES WHAT CLOUD CAN DO

## 3.1 Section 3a capability table, row 1 -- becomes wrong the moment Part A succeeds

| Capability | Table says | Actually |
|---|---|---|
| Confirm a filename exists | **no** | **Yes, once connected** -- inside the connector scope |

The rest of the column holds and is permanent: no hashes, no line counts, no
git state, no machine state, no writes.

But "confirm a filename exists" is precisely what the connector delivers, and
it is the **first row** -- the load-bearing one for the authorship rule.

**The rule survives. Here is the version that holds after the connector
exists:**

> Cloud can see a filename. Cloud cannot see whether it is current. Cloud's
> view is stale by design between Sync clicks, and stale-by-an-unknown-amount
> is not a basis for writing a pointer into a governing document.

That reasoning does not expire. The table's version does, and **a rule resting
on a premise that stops being true is a rule that gets argued with later.**

## 3.2 Section 4a scope -- three items

See 1.1. Drops `WebSite/` and `.claude`. Section 6b's audit command inherits
the omission.

## 3.3 Section 6a -- the stamp with the content hash is not in the files delivered

**What section 6a says:**

> "The first line of `CLAUDE.md` and of the current briefing carries a stamp:
> the date-time plus a short hash of the file's own content."
>
> "Claude Code generates and updates the stamp mechanically in the same edit as
> any change, so it cannot be forgotten."

**Line 1 of the briefing delivered today:**

```
<!-- Dated: 2026-08-09 14:45 ET -->
```

Date-time, no hash. Same for the other two documents.

`CLAUDE.md` in the tree cannot be checked from here, so this may be implemented
there and not yet in the briefings. But as written, section 6a describes an
existing mechanism in the present tense, and two of the three documents
governed by it do not carry it. Either it is aspirational and should say so, or
it was forgotten in the same edit it "cannot be forgotten" in.

**Why it matters beyond tidiness:** without the hash, *"what stamp do you
see?"* only detects that the two sides are on different **versions**. Two files
with the same date-time and different content -- exactly what a mid-session
edit produces -- read as identical.

## 3.4 Section 7b is breached by these three documents

**The rule:** state every fact exactly once; everywhere else, point.

**The git state is stated four times across three files written within 24
hours:**

| Document | Figure given |
|---|---|
| SyncPlan section 2 | 23 commits / 704 tracked |
| SyncSetupSteps | 31 commits / 706 tracked |
| Briefing section 1 | 33 commits / 708 tracked |
| Briefing section 2, item 2 | 33 commits / 708 tracked |

Each is timestamped, so none is *false*. But SyncPlan section 10 lists "Two
documents state the same machine fact" as a symptom meaning **one will go
stale** -- and this is the most volatile fact in the project.

Per the rule's own logic: one document states it, the other two point.

## 3.5 Section 5a -- `START-HERE.txt` is not visible to Cloud

Section 5a refers to "the short block already proven in `START-HERE.txt`."
Cloud cannot see that file and therefore cannot confirm the Part B2 block
matches it. **Flagged as unverifiable rather than guessed.**

## 3.6 Correctly described

- **Section 8** -- Cloud cannot write to the repository; anything filed must be
  downloaded, saved, committed, pushed. Exactly right, including calling it the
  step most likely to be skipped.
- **Section 3b** -- the list of what Cloud must not do.
- **Section 4b** -- refusing to trust the Connected badge.

**One addition suggested for the "cannot" list:** Cloud **cannot delete from
project knowledge** either. That has bitten this project before, and 0b-4
depends entirely on Bill doing it by hand.

---

# PART 4 -- THE BRIEFING MERGE

## 4.0 What the merge got right

The structure is sound, and it corrects two Cloud pointers correctly:
`CodingStandards-2026-08-02-0741` (renamed; Cloud had it stale) and the
Playbook discrepancy Cloud flagged but could not resolve. The section 5
correction of the `-0914` "never existed" claim is fair, and its reasoning
about unverified negatives is right.

## 4.1 Dropped from the Claude.ai briefing -- in severity order

### a) The eight delivered-but-never-uploaded files -- and `NamingStandard` above all

The merge picks up `SessionLog` (section 10) and the Python wrappers (section
8, item 3). It drops the rest:

```
GatewayGuard_NamingStandard-2026-07-18-r2.md
Run-GatewayGuard.bat
GatewayGuard_FutureProjects-2026-07-19.md
Run-ExternalCommandCheck.bat
GatewayGuard_FilesCleanupList-2026-07-24-0846.docx
GatewayGuard_ProjectFiles_DeleteKeep-2026-07-21-2023.txt
GatewayGuard_All19_Final-2026-08-02-1820.zip
```

**`NamingStandard` is the serious one.** It is the source of truth for the
canonical display names of all 19 settings across tool, website and guide --
rules N-01 to N-06, the locked name table, two named exceptions. It exists in
no file either Claude can reach. Roughly 45 project files carry those names,
and a live case mismatch was found on 2026-08-09 (`firewall.html` title case
against the guide index's sentence case).

**Net effect: nothing now defines the 19 names.**

### b) The LegalZoomGuide backwards-timestamp exception -- dropped, and its absence contradicts section 0

- `-2026-07-24-0921` is the **initial version**
- `-2026-07-24-0846` **added the copyright registration process**

The update carries the **earlier** stamp. This is the one documented pair where
newest-by-date-in-filename returns the wrong file -- and section 0 makes that
rule the **first rule in the document**, with no exception noted.

**A dropped exception to a rule promoted to primacy is the worst combination
available.**

### c) `Run-GatewayGuard.bat` and CROSS-FILE SYNC

The launcher names its `.ps1` by exact filename, and the naming convention
renames that file on every build. It has never been in project knowledge, so
the sync check has never been verifiable from Cloud's side. Dropped entirely.

### d) "open-source" and "human-backed" fall out of the banned-words list

Section 6 keeps *whether*, *whereas*, and *switch*. It drops the "open-source"
ban -- **while section 12 of the same document is an open violation about the
"open-source" ban.** The rule section 12 depends on is no longer stated in the
rules section.

"human-backed" (assisted sessions are roadmap only) is gone too.

### e) "A chat transcript outranks that chat's summary" -- demoted from rule to anecdote

Cloud's briefing had it in the standing evidence rules. The merge uses the
principle inside section 12 but drops it from section 6, where the other
evidence rules live. It is a general rule and it earned itself twice.

### f) The `-Partial-` archive, its known gaps, and the naming principle

Gone: the archive is known-incomplete, and the three files it lacks are

```
GatewayGuard_GuideStandard14pt20260716.pdf   <- the DEFAULT Guide edition
GatewayGuard_GuideCompact12pt20260716.pdf
mainellc6.pdf
```

Also gone: *a filename that overstates what a file contains is a version label
that lies* -- the rule that produced the `-Partial-` name in the first place.

### g) "No tool can delete from project knowledge -- Bill, by hand, in the file panel"

Section 0b-4 depends on this being true and does not say it. This project has
re-learned it more than once.

### h) The business carry-forward detail, collapsed to one line

Section 8 item 6 reduces two tables to "reconfirm the business items." Gone
with it:

- Checking is the qualifying demand deposit account for DigiCert and **must be
  named explicitly** in the bank letter
- SAM.gov EFT is blocked on the account number
- Six open license decisions and two attorney follow-ups (Gumroad refund
  override; EU/UK withdrawal rights)
- Guide rewrite from v9
- Batch 2 HTML: tips, beta, compatible
- **Gumroad vs. direct checkout** -- a decision gating refund terms and sales
  tax work, now invisible

### i) The 404.html open decision

Excluded as superseded, no undated successor, would leave no 404 page in
project knowledge. Dropped.

### j) The sign-in column in the fleet table

Cloud's table carried CGDELL = Microsoft account, SANDY = local account. The
merged table drops it -- but section 3's bullet warns *"Do not sign SANDY into
Windows with a Microsoft account."*

**The fact that SANDY is currently on a local account is what makes that
warning coherent and checkable.** Without it, the warning floats.

### k) Launch countdown

Cloud's briefing put "23 days out" in the status line. The merge gives the date
only.

## 4.2 Contradictions between the two halves

Beyond 1.1 (connector scope) and 1.2 (A6 vs retirement):

### Section 8's priority list opens with a closed item

Item 1 is `Run-OneDriveSyncCheck.bat` -- "**This item is closed.**" It occupies
the top slot in a list titled "NEXT PRIORITIES, IN ORDER," pushing the ascii39
field run to #2. Section 2 correctly calls the field run the thing everything
is blocked on.

**In a document whose one job is to make the top item unmissable in the first
thirty seconds, a completed task is holding the #1 position.**

### The git state is stated twice inside the briefing alone

Section 1 and section 2 item 2, before counting the other two documents.
Section 7b again.

---

# PART 5 -- ONE OBSERVATION ON THE AUTHORSHIP RULE

Cloud accepts the role, and the evidence behind it is not arguable -- 15 of 49
dead pointers in Cloud-authored files settles it. The merge also found real
things Cloud's briefing had wrong.

Worth noting anyway: **the sharpest defect in today's set is the connector
scope stated three ways, including a document that contradicts its own headline
four sections later.** No filename was misremembered. No measurement was wrong.

Moving authorship to the party that can measure closes the **dead-pointer**
class. It does not close the **internal-consistency** class -- and these three
documents cross-reference each other heavily enough that the second class now
has more surface area than the first.

`Run-DocCheck.bat` in SyncPlan 6c is the right answer:

- The "no two documents state the same machine fact" check would have caught
  the git-state repetition
- A scope-consistency check across the three sync documents would have caught
  finding 1.1

---

# APPENDIX -- FINDINGS SUMMARY

| # | Finding | Document | Severity |
|---|---|---|---|
| 1.1 | Connector scope stated 3 ways; briefing self-contradicts | All three | **High** |
| 1.2 | A6 test names a file the briefing retires | SetupSteps / Briefing | **High** |
| 1.3 | Part 0 misses the profile instructions box | SetupSteps | **High** |
| 2.1 | A3/A4 order inverted; repo likely picked, not typed | SetupSteps | Medium |
| 2.2 | `.claude` may not be selectable; no fallback defined | SetupSteps | **High** |
| 2.3 | "Tick folders not files" contradicts its own list | SetupSteps | Low |
| 2.4 | 0b-1 invites the exact failure section 11 documents | SetupSteps | **High** |
| 2.5 | 0b-5 provenance question invites a guess | SetupSteps | Low |
| 2.7 | Backslash paths in connector-facing text | SetupSteps | Low |
| 2.8 | "There is no webhook" stated as measured fact | SetupSteps | Low |
| 3.1 | Capability table row 1 wrong once connected | SyncPlan | Medium |
| 3.2 | Scope 4a is three items; audit 6b inherits it | SyncPlan | **High** |
| 3.3 | Content-hash stamp described but not present | SyncPlan | Medium |
| 3.4 | Section 7b breached by these three documents | All three | Medium |
| 3.5 | `START-HERE.txt` unverifiable from Cloud | SyncPlan | Low |
| 3.6 | "Cannot delete from project knowledge" missing | SyncPlan | Medium |
| 4.1a | NamingStandard and 6 other files dropped | Briefing | **High** |
| 4.1b | LegalZoomGuide exception dropped, contradicts section 0 | Briefing | **High** |
| 4.1c | Run-GatewayGuard.bat / CROSS-FILE SYNC dropped | Briefing | Medium |
| 4.1d | "open-source" ban dropped while section 12 depends on it | Briefing | **High** |
| 4.1e | Transcript-outranks-summary demoted | Briefing | Medium |
| 4.1f | `-Partial-` archive and naming principle dropped | Briefing | Medium |
| 4.1g | "No tool can delete" dropped; 0b-4 depends on it | Briefing | Medium |
| 4.1h | Business carry-forward detail collapsed | Briefing | Medium |
| 4.1i | 404.html decision dropped | Briefing | Low |
| 4.1j | Sign-in column dropped; SANDY warning floats | Briefing | Medium |
| 4.1k | Launch countdown dropped | Briefing | Low |
| 4.2 | Closed item holds the #1 priority slot | Briefing | Medium |

ENDOFFILE
