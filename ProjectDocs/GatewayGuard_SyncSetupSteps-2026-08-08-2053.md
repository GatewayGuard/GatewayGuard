<!-- Dated: 2026-08-08 20:53 ET -->
# GatewayGuard -- Sync Setup Steps (Claude Code <-> Claude Cloud)
- **Document Name:** GatewayGuard_SyncSetupSteps
- **Last Modified:** 2026-08-08 20:53 ET
- **Last Editor:** Claude Code (CGDELL)
- **Status:** Working procedure -- follow at the keyboard
- **Companion to:** `GatewayGuard_SyncPlan-*.md` (the what and why; this is the how)
- **Change History Log:**
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

**It is not automatic.** There is no webhook. If nobody pushes and nobody
clicks Sync, Cloud is reading whatever it saw last -- which may be days old
and will never say so.

**Current state (measured 2026-08-08 20:53):** 24 commits, 705 tracked files,
remote `GatewayGuard/GatewayGuard`, private, org-owned, 0 unpushed.

---

# PART A -- ONE-TIME SETUP

## A1. Confirm the repository is current (Claude Code, 10 seconds)

Before connecting anything, make sure GitHub has everything:

```
git status
git log origin/main..HEAD --oneline
```

**Desired state:** the second command prints nothing. That means no commits
are sitting unpushed. If it prints anything, push first.

## A2. Connect Claude Cloud to the repository

1. Open the GatewayGuard project at **claude.ai**
2. Find **Project knowledge** on the right
3. Click **+**
4. Choose **GitHub**
5. Paste: `GatewayGuard/GatewayGuard`

## A3. Authorize the ORGANISATION, not just your account

The repository is **private and owned by the `GatewayGuard` org**, not by
`wfbiii`. A personal authorization is not enough.

- When the warning about a private repository appears, follow the link to the
  GitHub App and grant access
- **Grant it for the `GatewayGuard` organisation**
- If the repositories still do not appear, the org may require single sign-on.
  Each user then authorizes separately for that org. Disconnecting and
  reconnecting GitHub inside Claude does **not** fix an SSO problem.

## A4. Select exactly four things -- and nothing else

Use the file browser to select:

```
ProjectDocs/     <- governing documents
Tool/            <- the build, checkers and launchers
WebSite/         <- website source, 150 files (131 HTML)
CLAUDE.md        <- build rules
```

**Select FOLDERS, not individual files.** A folder picks up new documents on
the next sync. Individually chosen files do not, and the new ones will simply
not exist as far as Cloud is concerned.

### Do NOT connect the repository root

The root also contains:

| Folder | What is in it |
|---|---|
| `Certificates/` | driver's licence, licence images, EIN, a file named like stored credentials |
| `Heath/` | medical documents |
| `Attachments/` | a stale copy of the whole tree, plus personal business documents |
| `Builds/Documents/` | personal documents |

None of that belongs in project knowledge. Connecting the root puts all of it
there in one click.

## A5. PROVE it is connected -- do not trust the badge

There is a known failure where a repository shows **Connected** while its
files are not actually reachable in conversation.

**Ask Cloud this, and require a real answer:**

> Quote the first three lines of `ProjectDocs/GatewayGuard_SyncPlan-2026-08-08-2050.md`
> exactly as they appear.

**Desired state:** it returns the `<!-- Dated: 2026-08-08 20:50 ET -->` line
and the title. If it paraphrases, guesses, or says it cannot find the file,
**it is not connected** -- go back to A3.

---

# PART B -- PROJECT INSTRUCTIONS IN CLOUD

## B1. Do not paste CLAUDE.md into Project Instructions

`CLAUDE.md` is 386 lines and changes often. A copy of it in a text box has no
timestamp, no diff, and nothing to signal that it has drifted. It will drift,
and nothing will tell you.

## B2. Paste this instead

Put **only** this in Cloud's Project Instructions. It changes almost never,
because the detail lives in files the connector delivers:

```
Read ProjectDocs\_READ-FIRST-Briefing-*.md -- take the newest by the DATE IN
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

That block is the same one already proven in `START-HERE.txt`.

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
