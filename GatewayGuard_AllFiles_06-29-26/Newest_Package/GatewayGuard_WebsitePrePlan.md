# gatewayguard.co -- Website Pre-Plan
**Created:** June 25, 2026
**Status:** Pre-plan only -- site is 0% built
**Content source:** windows_security_walkthrough_guide_v9.docx +
GatewayGuard tool sessions ascii12-ascii20

---

## SITE PURPOSE

gatewayguard.co serves two functions:

1. **Tool support** -- Full guide with screenshots for every manual
   action GatewayGuard cannot automate. The tool directs users here
   via: "See full guide: gatewayguard.co/guide"

2. **Beta tester program** -- Signup page for users with untested
   hardware who want a free remote assisted session in exchange
   for being a test subject.

---

## SITEMAP

```
gatewayguard.co/
├── index.html              (Home / landing page)
├── download.html           (Download GatewayGuard)
├── guide/
│   ├── index.html          (Guide home -- all 19 settings)
│   ├── windows-update.html
│   ├── defender-realtime.html
│   ├── tamper-protection.html
│   ├── smartscreen.html
│   ├── periodic-scanning.html
│   ├── phishing-protection.html
│   ├── firewall.html
│   ├── bitlocker.html
│   ├── windows-hello.html
│   ├── remote-desktop.html
│   ├── advertising-id.html
│   ├── diagnostic-data.html
│   ├── edge-startup.html
│   ├── widgets.html
│   ├── password-manager.html
│   ├── memory-integrity.html
│   ├── password-on-wake.html
│   ├── fast-startup.html
│   └── wake-on-lan.html
├── beta.html               (Beta tester signup)
├── compatible.html         (Tested hardware list)
├── glossary.html           (Security terms glossary)
├── firefox.html            (Firefox hardening addendum)
└── settings-reference.html (Quick-reference printable table)
```

---

## PAGE SPECS

---

### HOME (index.html)

**Purpose:** Convert visitor to downloader or beta tester
**Tone:** Plain English, non-technical, reassuring

**Sections:**
1. Hero -- "Harden your Windows 11 PC in minutes. Free."
2. What it does (3 columns):
   - Checks 19 security settings
   - Fixes what needs fixing (with your approval)
   - Tells you exactly what it changed
3. How it works (3 steps):
   - Download and run
   - Review what was found
   - Approve each change
4. What it does NOT do (trust builder):
   - Does not uninstall your apps
   - Does not touch your files or passwords
   - Does not make changes you can't reverse
5. Tested on (hardware list -- brief)
6. Download button (primary CTA)
7. Beta tester program teaser (secondary CTA)
8. Footer: privacy note, contact, version

**Design notes:**
- Black and white primary palette (matches tool aesthetic)
- Single download CTA above the fold
- No ads, no tracking pixels, no newsletter signup required

---

### DOWNLOAD (download.html)

**Purpose:** Deliver both files cleanly with clear instructions

**Sections:**
1. Download GatewayGuard (current build label e.g. ascii20)
   - Button: Download .ps1 file
   - Button: Download Run-GatewayGuard.bat
   - Note: Save both files to the SAME folder
2. How to run:
   - Step 1: Save both files to same folder (e.g. Desktop\GatewayGuard)
   - Step 2: Double-click Run-GatewayGuard.bat
   - Step 3: Click Yes when Windows asks for Administrator access
   - Step 4: Follow the prompts
3. Requirements:
   - Windows 11 Home or Pro
   - Administrator access
   - Consolas or Courier New font (tool checks automatically)
4. Tested hardware list link
5. If something goes wrong link -> beta.html

---

### GUIDE HOME (guide/index.html)

**Purpose:** Navigation hub for all 19 setting pages
**Also used by:** Tool (directs here from manual step screens)

**Sections:**
1. "You were sent here by GatewayGuard" banner
   (explains user may have been directed from the tool)
2. Quick-reference table (all 19 settings, current status, link to page)
3. Settings organized by category:

   SECURITY (auto-applied by tool):
   - [1] Windows Update
   - [2] Defender Real-Time VP
   - [3] Tamper Protection
   - [4] SmartScreen
   - [5] Defender Periodic Scanning
   - [6] Enhanced Phishing Protection
   - [7] Defender Firewall
   - [8] BitLocker / Device Encryption

   MANUAL ACTION REQUIRED:
   - [9] Windows Hello
   - [10] Remote Desktop (Pro only)
   - [16] Memory Integrity
   - [17] Password Required on Wake

   CONVENIENCE (you decide):
   - [11] Advertising ID
   - [12] Diagnostic Data
   - [13] Edge Startup Boost
   - [14] Windows Widgets
   - [15] Edge Password Saving

   SYSTEM HARDENING:
   - [18] Fast Startup
   - [19] Wake on LAN

4. Additional resources:
   - Firefox hardening
   - Glossary
   - Printable settings reference

---

### INDIVIDUAL SETTING PAGES (guide/[setting].html)

**Template -- same structure for all 19:**

1. Breadcrumb: Home > Guide > [Setting Name]
2. Setting name + ID number
3. "What GatewayGuard did" box:
   - Found: [what was detected]
   - Action taken: [what tool did or recommended]
4. WHY THIS MATTERS (plain English, 2-3 sentences)
5. HOW TO CHECK IT YOURSELF (step by step with screenshots)
6. HOW TO CHANGE IT (if manual action needed)
7. HOW TO REVERT IT (if user wants to undo)
8. WHAT TO EXPECT AFTER (any side effects to know about)
9. Related settings links

**Content source by setting:**

| Setting | Source | Work needed |
|---------|---------|-------------|
| [1] Windows Update | Guide Phase 1 Step 1 | Minor edit |
| [2] Defender RT VP | Guide Phase 1 Step 2 | Minor edit |
| [3] Tamper Protection | Guide Phase 1 Step 2 | Extract subsection |
| [4] SmartScreen | Guide Phase 1 Step 2 | Extract subsection |
| [5] Periodic Scanning | Guide Phase 1 Step 2 | Expand for MB |
| [6] Phishing Protection | Guide Phase 1 Step 2 | Extract subsection |
| [7] Firewall | Guide Phase 1 Step 2 | Extract subsection |
| [8] BitLocker | Guide Phase 1 Step 3 | Minor edit |
| [9] Windows Hello | Guide Phase 1 Step 4 | Extract subsection |
| [10] Remote Desktop | Guide QR table | Expand significantly |
| [11] Advertising ID | Guide QR table | Write new |
| [12] Diagnostic Data | Guide QR table | Write new |
| [13] Edge Startup | Guide Phase 2 Step 6D | Minor edit |
| [14] Widgets | Guide Phase 2 Step 6F | Minor edit |
| [15] Edge Passwords | Guide Phase 2 Step 6I | Minor edit |
| [16] Memory Integrity | Guide Phase 1 Step 2 | Extract subsection |
| [17] Password on Wake | Guide Phase 1 Step 4 | Extract subsection |
| [18] Fast Startup | NOT in guide | Write from scratch |
| [19] Wake on LAN | NOT in guide | Write from scratch |

---

### BETA TESTER PAGE (beta.html)

**Purpose:** Recruit testers with untested hardware

**Sections:**
1. Headline: "Is your PC on our tested list?"
2. Link to compatible.html
3. "Don't see your PC? Become a beta tester."
4. What you get:
   - Free GatewayGuard session (we run it with you)
   - Screen share only -- you stay in control
   - We chat via text during the session
   - Your PC gets hardened at no cost
5. What we get:
   - Test results for your hardware
   - Compatibility data to help future users
6. Signup form:
   - Name
   - Email
   - PC Make / Model
   - Windows edition (Home/Pro)
   - Approximate age of PC
   - Any known issues?
   - Best time to connect
7. Screening note:
   "We'll review your submission and reach out within 48 hours.
   Some configurations may not qualify if known conflicts exist."

---

### COMPATIBLE HARDWARE (compatible.html)

**Purpose:** Show tested hardware, build trust

**Sections:**
1. Tested hardware table:

| # | Make/Model | OS | CPU | RAM | First Tested | Notes |
|---|------------|----|----|-----|-------------|-------|
| 1 | HP Laptop 17-by1xxx | Win 11 Home | i5-8265U | 8GB | ascii13 | MB Free installed |
| 2 | Dell Latitude 5430 | Win 11 Pro | i7-1265U | 32GB | ascii21 (pending) | First Pro test |

2. "Don't see your PC?" -> beta.html
3. What "tested" means:
   - Full run completed without errors
   - All 19 settings checked
   - Results verified manually
   - Any quirks documented

---

### GLOSSARY (glossary.html)

**Purpose:** Help non-technical users understand terms

**Content source:** Directly from guide v9 glossary section
**Terms to include:** All 40+ terms from the guide glossary
**Work needed:** Format as HTML, add GatewayGuard-specific terms
(FreeCompanion, TrialActive, etc.)

---

### FIREFOX HARDENING (firefox.html)

**Purpose:** Supplementary hardening for Firefox users

**Content source:** Firefox addendum F1-F12 from guide v9
**Work needed:** Format as HTML with screenshots
**Note:** GatewayGuard tool doesn't touch Firefox -- this is manual only

---

### SETTINGS REFERENCE (settings-reference.html)

**Purpose:** Printable quick-reference of all settings

**Content source:** Quick-reference settings table from guide v9
**Format:** Clean printable table, also downloadable as PDF
**Work needed:** Format as HTML, add GatewayGuard setting IDs

---

## BUILD PRIORITY ORDER

**Phase 1 -- MVP (minimum to support tool launch):**
1. guide/index.html -- navigation hub (tool directs here)
2. All 19 individual setting pages -- tool references these
3. download.html -- where users get the tool
4. index.html -- landing page

**Phase 2 -- Growth:**
5. beta.html -- beta tester recruitment
6. compatible.html -- tested hardware list
7. glossary.html -- trust builder

**Phase 3 -- Content expansion:**
8. firefox.html
9. settings-reference.html (printable PDF)
10. Blog/changelog page

---

## DESIGN SPEC

**Colors:**
- Primary: Black (#000000) and White (#FFFFFF)
- Accent: Dark gray (#333333) for secondary text
- Status Good: Green (#2E7D32)
- Status Warning: Amber (#F57F17)
- Status Critical: Red (#C62828)
- Matches tool console aesthetic

**Typography:**
- Body: Arial or system sans-serif
- Code/commands: Consolas or Courier New (matches tool font)
- Headings: Arial Bold

**Layout:**
- Max width: 960px centered
- Single column on mobile
- Two column max on desktop
- No sidebars

**Navigation:**
- Simple top nav: Home | Download | Guide | Beta | Compatible
- Breadcrumbs on all guide pages
- "Back to Guide" link on every setting page

**No:**
- No ads
- No newsletter popups
- No tracking pixels
- No login required
- No cookies except basic analytics (optional)

---

## CONTENT WRITING WORKLOAD ESTIMATE

| Task | Pages | Est. Hours |
|------|-------|-----------|
| Format existing guide content as HTML | 13 pages | 6-8 hrs |
| Write new content (settings 18, 19) | 2 pages | 1-2 hrs |
| Expand brief content (settings 10,11,12) | 3 pages | 2-3 hrs |
| Home, Download, Beta, Compatible pages | 4 pages | 3-4 hrs |
| Screenshots for all 19 settings | 19 sets | 4-6 hrs |
| Glossary, Firefox, Reference pages | 3 pages | 2-3 hrs |
| **TOTAL** | **44 pages** | **~20-25 hrs** |

**Most of the writing is already done** in guide v9.
Primary work is formatting, screenshots, and HTML build.

---

## NEXT STEPS

1. Get domain DNS pointed to hosting (is gatewayguard.co registered?)
2. Choose hosting (GitHub Pages is free and simple for static HTML)
3. Build Phase 1 pages (guide + download + home)
4. Add screenshots as each setting page is built
5. Launch with Phase 1, build Phase 2 after beta tester program starts
