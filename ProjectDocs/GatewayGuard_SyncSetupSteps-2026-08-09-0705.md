<!-- Dated: 2026-08-09 07:05 ET -->
# GatewayGuard -- Sync Setup Steps (Claude Code <-> Claude Cloud)
- **Document Name:** GatewayGuard_SyncSetupSteps
- **Last Modified:** 2026-08-09 07:05 ET
- **Last Editor:** Claude Code (CGDELL)
- **Status:** Working procedure -- follow at the keyboard
- **Companion to:** `GatewayGuard_SyncPlan-*.md` (the what and why; this is the how)
- **Change History Log:**
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

**It is not automatic.** There is no webhook. If nobody pushes and nobody
clicks Sync, Cloud is reading whatever it saw last -- which may be days old
and will never say so.

**Current state (measured 2026-08-08 20:53):** 24 commits, 705 tracked files,
remote `GatewayGuard/GatewayGuard`, private, org-owned, 0 unpushed.

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

## 0a. Copy the existing text out

1. Go to **claude.ai** and open the **GatewayGuard** project
2. Find **Project instructions** (there may be an **Edit** link beside it)
3. Click inside the box
4. Press **Ctrl+A** then **Ctrl+C** -- this selects and copies everything in it

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

## A3. Add the repository

On the right of the project page is a panel headed **Project knowledge**.

1. Click the **`+`** button in that panel
2. A menu appears -- click **GitHub**
3. A box appears asking for a repository. **Type exactly:**

```
GatewayGuard/GatewayGuard
```

4. Press **Enter**

## A4. Authorize the ORGANISATION, not your account

The repository is **private and owned by the `GatewayGuard` org**, not by
`wfbiii`. A personal authorization is not enough, and this is the step people
get wrong.

1. A warning about a private repository appears, with a link to GitHub. Click
   the link.
2. GitHub shows a list containing **wfbiii** and **GatewayGuard**.
   **Click `GatewayGuard` -- the organisation, not your name.**
3. Choose **Only select repositories**
4. Pick **GatewayGuard**
5. Click the green **Install** (or **Save**) button
6. Return to the Claude browser tab

**If the repositories still do not appear**, the org may require single
sign-on. Each user then authorizes separately for that org. Disconnecting and
reconnecting GitHub inside Claude does **not** fix an SSO problem.

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

**Tick FOLDERS, not individual files inside them.** A folder picks up new
documents on later syncs. Individually chosen files do not -- any document
written after today would simply not exist as far as Cloud is concerned.

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

**In the project's chat box, type exactly this and press Enter:**

```
Quote the first two lines of ProjectDocs\_READ-FIRST-Briefing-2026-08-08-2147.md exactly as they appear.
```

**It should answer with:**

```
<!-- Dated: 2026-08-08 21:47 ET -->
# READ FIRST -- Session Briefing
```

If it paraphrases, guesses, or says it cannot find the file, **it is not
connected** -- go back to A4.

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
