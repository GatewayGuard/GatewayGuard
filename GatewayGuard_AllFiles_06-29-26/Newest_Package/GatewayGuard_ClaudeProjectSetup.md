# How to Set Up and Use the GatewayGuard Claude Project
**For:** William F. Burns III
**Created:** 28-Jun-2026
**Purpose:** Efficient session setup so every Claude conversation
             has full context and picks up exactly where we left off.

---

## WHAT IS THE CLAUDE PROJECT?

The GatewayGuard Claude Project is a dedicated workspace on claude.ai
that keeps all GatewayGuard conversations together in one place.
Claude remembers context within a project better than in standalone chats.

**Access it at:** claude.ai -> Projects -> GatewayGuard
**Login with:** william.wfbiii@gmail.com
**Available on:** Browser (IdeaPad, SANDY, Dell Latitude), Claude Android app

---

## ONE-TIME SETUP (already done -- for reference)

1. Go to claude.ai and log in with william.wfbiii@gmail.com
2. Click "Projects" in the left sidebar
3. Click "New Project" -> name it "GatewayGuard"
4. The project now appears in your sidebar every time you log in
5. All GatewayGuard conversations go inside this project

---

## HOW TO START EACH SESSION EFFICIENTLY

### STEP 1: Open the project
- Go to claude.ai
- Click GatewayGuard in the left sidebar
- Click "New Chat" inside the project

### STEP 2: Upload your context files (takes 30 seconds)
At the start of EVERY session, upload these two files:
```
C:\Users\willi\OneDrive\GatewayGuard\ProjectDocs\GatewayGuard_ProjectNotes.md
C:\Users\willi\OneDrive\GatewayGuard\Tool\W11-SecurityHardening-v3-asciiXX-YYYY-MM-DD.ps1
```
(Replace XX with current build number and YYYY-MM-DD with date)

Drag and drop both files into the Claude chat window, or click
the paperclip icon to attach them.

### STEP 3: Start with one of these opening messages

**For a coding session (building new ascii version):**
"Good morning. Uploaded are the latest project notes and ascii22.
I have new test results to review. [upload test results file]
Let's build ascii23."

**For a business/planning session:**
"Good morning. Uploaded are the latest project notes.
Today I want to work on [topic]. Here are my notes: [paste or upload]"

**For a quick question:**
"Quick question about [topic] -- see project notes attached."

**For continuing where you left off:**
"Good morning. Uploaded project notes and latest build.
Can you check what we said we'd do next and let's pick up there?"

---

## FILE MANAGEMENT RULES

### YOUR ONEDRIVE FOLDER STRUCTURE
```
C:\Users\willi\OneDrive\GatewayGuard\
├── Builds\          <- Archive of each ascii build (latest only)
├── Presentation\    <- Family presentation and companion sheet
├── ProjectDocs\     <- Notes, checklist, standards, research
├── Run_Comments\    <- Test run screenshots and comments
├── Tool\            <- Current active build (.ps1 + .bat)
└── Website\         <- Website planning documents
```

### WHAT TO KEEP IN EACH FOLDER

**Tool\ (active build only):**
- W11-SecurityHardening-v3-ascii22-2026-06-27.ps1
- Run-GatewayGuard.bat

**Builds\ (latest archive only -- delete old ones):**
- W11-SecurityHardening-v3-ascii22-2026-06-27.ps1

**ProjectDocs\ (always current versions):**
- GatewayGuard_ProjectNotes.md          <- MOST IMPORTANT
- GatewayGuard_Checklist.txt
- GatewayGuard_CodingStandards.md
- GatewayGuard_MBDefender_Screens.md
- GatewayGuard_MarketResearch.docx
- GatewayGuard_FAQ.md

**Presentation\:**
- GatewayGuard_FamilyPresentation_v2.pptx
- GatewayGuard_PresentationCompanionSheet.md

**Website\:**
- GatewayGuard_WebsitePrePlan.md
- GatewayGuard_SettingsToGuideMap.md

**Run_Comments\:**
- Test screenshots (.png files)
- Comment text files (.txt)
- Name format: Ascii22_IdeaPad_comments.txt

### DOWNLOAD SETTINGS
Set Chrome to ask where to save each download:
Chrome -> Settings -> Downloads -> Ask where to save each file -> ON
Then save directly to the right OneDrive subfolder when downloading
from Claude.

---

## HOW TO UPLOAD TEST RESULTS

After running GatewayGuard on a test machine:

**Method 1: Screenshot**
1. Press Win + Shift + S
2. Drag to select the screen area
3. Open Paint, paste (Ctrl+V), save as PNG
4. Upload to Claude

**Method 2: Copy console text**
1. Right-click in the PowerShell window
2. Select "Select All" then "Copy"
3. Paste into a new Notepad file
4. Save as Ascii22_IdeaPad_run.txt
5. Upload to Claude

**Method 3: Type comments directly**
For shorter observations, type them directly in the chat
or save as a .txt file and upload.

**Best practice:** Do both -- screenshot for visual issues,
text copy for complete output Claude can analyze line by line.

---

## SESSION END CHECKLIST

At the end of every session:

1. **Download all new files Claude created:**
   - New .ps1 build file -> Tool\ and Builds\ folders
   - Updated ProjectNotes.md -> ProjectDocs\ folder
   - Any new documents -> appropriate subfolder

2. **Delete old versions:**
   - Previous .ps1 build from Tool\ folder
   - Previous .ps1 build from Builds\ folder
   - Keep only the latest version of each file

3. **Verify OneDrive synced:**
   - Look for the blue sync icon on OneDrive files
   - Wait for green checkmarks before closing laptop

4. **Note what to do next session:**
   - Jot down the top 2-3 priorities for next time
   - Claude's project notes capture most of this automatically

---

## WHAT CLAUDE REMEMBERS VS WHAT IT DOESN'T

### Claude DOES remember (within this project):
- Conversation history in this project
- Memory summaries updated periodically
- Context from uploaded files in THIS conversation

### Claude does NOT remember:
- Files from previous conversations (must re-upload)
- Exact details from older sessions (notes file solves this)
- Anything from Cowork desktop app sessions

### The solution -- always upload ProjectNotes.md:
The project notes file (1,922+ lines as of June 2026) contains
everything Claude needs to pick up exactly where we left off:
- Current build status and line count
- All hardware registry entries
- All decisions made and why
- Marketing strategy and pricing
- CPM timeline
- Investigation queue items

One file upload = full context restored. Takes 10 seconds.

---

## MULTI-DEVICE USAGE

### IdeaPad (primary dev machine):
- Primary Claude usage
- Upload test files from here
- Download new builds here
- OneDrive syncs to other machines automatically

### SANDY (HP test machine):
- Run GatewayGuard tests here
- Copy test output to USB or OneDrive
- Use Claude on browser to upload results
- Login: william.wfbiii@gmail.com

### Dell Latitude 5430 (arriving):
- Windows 11 Pro tests
- Same setup as SANDY
- Login with same Google account

### Android phone:
- Install Claude app from Google Play
- Login: william.wfbiii@gmail.com
- Good for: quick questions, uploading photos of screens,
  voice-to-text for notes on the go
- Not good for: long coding sessions, file downloads

---

## TIPS FOR EFFICIENT SESSIONS

### DO:
- Start every session by uploading ProjectNotes.md and latest .ps1
- Keep sessions focused -- one main topic per session works best
- Save Claude's outputs immediately -- don't wait until end of session
- Use Win + Shift + S for quick screenshots to upload
- Type "save to notes" when you want something added to ProjectNotes.md
- Press F5 if the input box disappears (faster than logging out)

### DON'T:
- Don't start a new session without uploading context files
- Don't rely on Claude remembering details from old sessions
- Don't let files accumulate in Downloads -- move them immediately
- Don't run multiple Claude tabs at once -- causes confusion
- Don't use Cowork app for GatewayGuard work -- files save locally only

### WHEN YOU HIT MESSAGE LIMITS:
- Claude Pro resets every few hours
- Start a new chat within the same project
- Upload ProjectNotes.md again in the new chat
- Continue exactly where you left off

---

## NAMING CONVENTIONS (quick reference)

| Item | Format | Example |
|------|--------|---------|
| Build files | ascii##-YYYY-MM-DD.ps1 | ascii22-2026-06-27.ps1 |
| Test comments | Ascii##_Machine_comments.txt | Ascii22_IdeaPad_comments.txt |
| Test runs | Ascii##_Machine_run.txt | Ascii22_SANDY_run.txt |
| Screenshots | YYYY-MM-DD.png | 2026-06-28.png |
| Notes updates | Always same filename | GatewayGuard_ProjectNotes.md |

---

## CONTACTS AND LINKS (quick reference)

| Item | Detail |
|------|--------|
| Claude Project | claude.ai -> Projects -> GatewayGuard |
| Login email | william.wfbiii@gmail.com |
| Domain | gatewayguard.co |
| Maine SOS | icrs.informe.org/icrs |
| USPTO trademarks | tmsearch.uspto.gov |
| Maine LLC annual report | maine.gov/sos -- due annually, $85 |
| IRS EIN (get after LLC confirmed) | irs.gov/ein -- free, 5 minutes |
| Maine SOS phone | (207) 624-7752 |
| Maine SOS email | CEC.Corporations@Maine.gov |
