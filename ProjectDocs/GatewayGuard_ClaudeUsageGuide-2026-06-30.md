# How to Set Up and Maintain Claude Projects -- Master Guide
**For:** William F. Burns III
**Created:** 30-Jun-2026
**Covers:** Efficient usage, GatewayGuard-specific changes, new project setup,
            sign-in routine, sign-out routine, switching projects

---

## SECTION 1: HOW TO INTERACT EFFICIENTLY (save messages and time)

### The core principle
Every message costs you part of your session limit. The goal is fewer,
denser messages rather than many small back-and-forth ones.

### DO -- batch your asks into one message
Instead of:
"Can you look at this file?"
[wait for response]
"Now build ascii23"
[wait for response]
"Also update the notes"

Do this in ONE message:
"Here's the latest test results. [upload]
1. Review the issues found
2. Build ascii23 with fixes
3. Update project notes with what changed"

### DO -- upload context files at the START, not partway through
Always attach BEFORE typing your message, not after Claude has already
started responding. Re-uploading mid-conversation costs an extra message.

### DO -- be specific about format up front
"Give me a one-page summary" saves a message vs getting a long answer
then asking "can you shorten this?"

### DO -- say "and update the notes" in the same message
Don't make a separate request afterward. Build the habit of always
including "save this to ProjectNotes.md" in your original ask.

### DON'T -- send single-word or single-line follow-ups
"ok" / "go ahead" / "yes" still count as full messages. If you already
know you want Claude to proceed, say so in your FIRST message:
"Build it now, don't wait for me to confirm" instead of asking
"should I build this?" then replying "yes" separately.

### DON'T -- ask Claude to re-explain something already in the notes
If it's in ProjectNotes.md and you uploaded it, just say
"per the notes, do X" rather than re-describing the whole situation.

### DON'T -- upload the same large file multiple times in one session
Upload the .ps1 and ProjectNotes.md ONCE at the start. Claude retains
them for the rest of that conversation -- no need to re-attach.

### Time-saving phrases to use often
- "Save to notes" -- triggers an update without you specifying every detail
- "Same as last time" -- referencing a known prior decision instead of re-explaining
- "Build it, don't ask" -- skips a confirmation round-trip
- "Short answer" -- caps response length when you just need a fact
- "Continue" -- resumes a cut-off response without restating context

---

## SECTION 2: CHANGES TO MAKE TO THE GATEWAYGUARD PROJECT SPECIFICALLY

### 1. DONE (confirmed 30-Jun-2026) -- Project Files set up
Inside the GatewayGuard project, there is a "Files" area (separate from
per-chat uploads) where all GatewayGuard documents have been uploaded,
including GatewayGuard_ProjectNotes.md. These files are now available
to every new chat in the project automatically -- no need to re-upload
ProjectNotes.md at the start of each session anymore.

HOW TO FIND IT: Inside the GatewayGuard project page, look for a
"Files" tab/section (distinct from "Edit details" which only renames
the project). This is where persistent project-wide documents live.

MAINTENANCE: When ProjectNotes.md is significantly updated, the file
in this Files area should be REPLACED with the latest version
periodically -- it does not auto-sync with the OneDrive copy. Re-upload
when there's been substantial new content added (e.g. weekly, or after
a major session).

### 2. DONE (confirmed 30-Jun-2026) -- Custom Instructions set up
The GatewayGuard project's "Instructions" area now contains the
suggested instruction paragraph:

"This is the GatewayGuard project -- a Windows 11 security hardening
tool. Always check the latest ProjectNotes.md in Project Knowledge before
answering. Use plain English, avoid jargon. Keep responses concise unless
asked for detail. Always update ProjectNotes.md when new
decisions/research/builds are discussed. Verify competitor claims against
primary sources before treating them as fact -- flag anything unverified
clearly."

This means Claude now applies these rules automatically in every new
chat inside this project without needing to repeat them each session.

RESULT: New chats in GatewayGuard should now start with full context
already available. Test this periodically by asking a notes-dependent
question in a brand new chat without uploading anything first.

### 3. Archive completed/stale conversations
Long-running chats slow down loading and can hit context limits sooner.
Once a chat session is "done" (e.g. ascii22 build session, complete),
start a FRESH chat for the next topic rather than continuing the same
thread indefinitely. Use the project's chat list to keep things organized
by topic/date rather than one infinitely long conversation.

### 4. Standardize your upload routine (see Section 4 below)
Stop uploading ProjectNotes.md ad hoc -- once Project Knowledge is set
up (#1 above), you mainly need to upload the LATEST .ps1 build and any
NEW test result files each session, not the notes file every time.

### 5. Clean up the file naming pattern project-wide
Confirmed convention going forward:
- All builds: ascii##-YYYY-MM-DD.ps1
- All zips: GatewayGuard_AllFiles-YYYY-MM-DD.zip
- Notes: GatewayGuard_ProjectNotes.md (current) AND
  GatewayGuard_ProjectNotes-YYYY-MM-DD.md (dated snapshot)
- Always update the "Last Updated" header line inside ProjectNotes.md
  itself, not just the filename

---

## SECTION 3: BASIC INSTRUCTIONS FOR STARTING A NEW PROJECT

Use this any time you start a new, unrelated Claude Project (not GatewayGuard).

### Step 1: Create the project
claude.ai -> Projects (left sidebar) -> New Project -> name it clearly
Use a name that will make sense to you in 6 months (not "Project 1")

### Step 2: Set Project Knowledge immediately
Before doing any real work, decide what reference material Claude should
always have. Upload it to Project Knowledge right away:
- Any existing notes, specs, or background documents
- Key decisions already made
- Important constraints or requirements

### Step 3: Set Custom Instructions
Write a short paragraph telling Claude how to behave in this project:
- What tone to use
- What format to default to (concise vs detailed)
- Any standing rules (e.g. "always cite sources," "never use jargon")
- Whether to proactively update a notes file as you go

### Step 4: Create a "ProjectNotes" master file from day one
Just like GatewayGuard, start a single master notes document immediately
-- don't wait until things get complicated. Ask Claude in your very
first real working chat: "Create a ProjectNotes.md file and keep it
updated as we go." This habit from day one prevents the scramble of
trying to reconstruct history later.

### Step 5: Decide your file organization BEFORE generating files
Set up your OneDrive (or equivalent) folder structure before Claude
starts producing documents, so you're not reorganizing after the fact.
A simple starting structure:
```
ProjectName/
├── ProjectDocs/   (notes, specs, decisions)
├── Outputs/       (whatever the project produces)
└── Reference/     (source material, research)
```

---

## SECTION 4: WHAT TO DO EVERY TIME YOU SIGN IN TO CLAUDE.AI

### Quick sign-in checklist (under 2 minutes)
1. Go to claude.ai, log in with william.wfbiii@gmail.com
2. Click the relevant Project in the left sidebar (e.g. GatewayGuard)
3. Decide: continue an existing chat, or start fresh?
   - Continuing same topic within last few hours -> use existing chat
   - New topic, or it's a new day -> click "New Chat"
4. Project Files are now set up (confirmed 30-Jun-2026) -- you do NOT
   need to upload GatewayGuard_ProjectNotes.md manually anymore.
   Claude has access to it automatically via the project's Files area.
5. Upload any NEW files specific to today's work (latest build,
   new test results, new screenshots)
6. State your goal for the session in one clear opening message

### What NOT to do at sign-in
- Don't re-upload files Claude already has from earlier in the same chat
- Don't ask "are you ready?" or similar warm-up messages -- just start
  with the actual request

---

## SECTION 5: WHAT TO DO WHEN LOGGING OUT / ENDING A SESSION

### End-of-session checklist (5 minutes, do this every time)
1. **Download every new file** Claude created during the session
   - Click each file card's download/present button
   - Save directly into the correct OneDrive subfolder
     (Tool, Builds, ProjectDocs, Website, Presentation, Run_Comments)
2. **Confirm ProjectNotes.md was updated** if anything new was decided
   - If Claude didn't explicitly update it, ask before closing:
     "Did you update the project notes with everything from today?"
3. **Delete old/superseded files** from your OneDrive folders
   - Old .ps1 build versions (keep latest only)
   - Old presentation versions
   - Anything explicitly replaced this session
4. **Verify OneDrive sync completed**
   - Look for the green checkmark / cloud icon on synced files
   - Wait for sync before closing the laptop, especially before travel
5. **Jot a one-line note to yourself** (in Notes app, sticky note, etc.)
   of the single most important next step, in case you forget by next
   session. Example: "Next: test ascii22 on SANDY after restart"
6. **Close the browser tab** -- no need to formally "log out" of
   claude.ai itself, just closing the tab is fine. Your session and
   chat history are saved automatically.

### If you hit a message limit before finishing
- Note where you left off (in your own quick note, not necessarily in chat)
- Start a new chat in the same project next session
- Upload ProjectNotes.md again if Project Knowledge isn't set up yet
- Reference: "Continuing from where we left off -- see notes for context"

---

## SECTION 6: WHAT TO DO WHEN SWITCHING PROJECTS OR CHATS

### Switching to a DIFFERENT Project entirely
(e.g. GatewayGuard -> a personal project -> back to GatewayGuard)

1. Click the new Project name in the left sidebar -- this fully switches
   context. Claude will NOT carry over anything from GatewayGuard.
2. If returning to GatewayGuard later same day, click back into the
   GatewayGuard project and either continue the existing chat (if recent)
   or start fresh with the standard sign-in checklist (Section 4)
3. Nothing needs to be manually "saved" when switching -- each project's
   chats and Project Knowledge stay separate and intact automatically

### Switching to a NEW CHAT within the SAME Project
(e.g. starting a fresh GatewayGuard conversation)

1. Click "New Chat" inside the GatewayGuard project
2. If Project Knowledge is set up (Section 2, #1) -- Claude automatically
   has the latest ProjectNotes.md without you uploading anything
3. If Project Knowledge is NOT yet set up -- upload ProjectNotes.md
   and the latest .ps1 manually, same as a normal sign-in
4. State clearly what's different about this new chat vs continuing
   the old one, e.g.: "New chat -- moving on to website planning,
   separate from the ascii22 testing chat"

### When to deliberately start a NEW chat vs continuing an old one
START NEW when:
- The previous chat has gotten very long (loading feels slow)
- You're switching to a completely different topic/task
- It's a new day and the old session feels "closed"

CONTINUE OLD when:
- You're still mid-task (e.g. still testing the same build)
- It's been less than a few hours
- The conversation context is still directly relevant

### Quick reference table
| Situation | Action |
|-----------|--------|
| Same day, same task | Continue existing chat |
| Same day, new task | New chat, same project |
| Different day | New chat, same project (re-upload notes if no Project Knowledge) |
| Different project entirely | Click different project in sidebar |
| Hit message limit | New chat, same project, reference where you left off |
| Chat feels slow/long | New chat, same project |

---

## QUICK REFERENCE -- THE ENTIRE WORKFLOW IN ONE GLANCE

```
SIGN IN
  -> Pick project -> Pick chat (new or continue) -> Upload today's files
  -> State your goal clearly

WORK
  -> Batch requests into fewer messages
  -> Say "save to notes" explicitly
  -> Avoid one-word follow-up messages

SIGN OUT
  -> Download all new files to correct OneDrive folders
  -> Confirm notes were updated
  -> Delete superseded old files
  -> Verify OneDrive synced
  -> Note your next single priority
  -> Close tab
```

---

## ONE-TIME SETUP TASKS (do these once, not every session)

- [ ] Set up Project Knowledge for GatewayGuard (Section 2, #1)
- [ ] Write Custom Instructions for GatewayGuard (Section 2, #2)
- [ ] Confirm OneDrive folder structure matches naming conventions
- [ ] Bookmark claude.ai -> GatewayGuard project for quick access
- [ ] Set Chrome to "ask where to save each file" (already done per
      earlier session) so downloads go to the right folder directly
