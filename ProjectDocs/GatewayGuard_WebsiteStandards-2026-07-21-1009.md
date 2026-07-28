<!-- Dated: 2026-07-21 10:09 EDT -->
# GatewayGuard Website Standards
- **Document Name:** GatewayGuard_WebsiteStandards
- **Last Modified:** 2026-07-21 10:09 EDT
- **Status:** Cumulative Master Document (supersedes all prior dates)
- **Change History Log:**
  - 2026-07-21 10:09: Added READ-BEFORE-PRODUCING rule to Section 3
    and HTML DELIVERY GATE. Claude must read WebsiteStandards and the
    current HTML file from project knowledge before producing any HTML
    file. Full delete-and-replace delivery required for all HTML files.
  - 2026-07-21 09:33: Added HTML DELIVERY GATE (Section 3a) as hard
    gate. W-02, W-03, W-04 now mandatory pre-delivery checks Claude
    must run and report. Updated FILE NAMING to YYYY-MM-DD-HHMM.
    Removed -r2/-r3 suffix language. Updated color tokens to locked
    values (Navy #2E6BD6, Mocha #A0522D, Charcoal #5E35B1). Updated
    sitemap status.
  - 2026-07-18: Initial file. Design tokens, senior color rules, build
    rules W-01 through W-06, file naming, GitHub deployment, sitemap,
    setting page template, writing rules.

---

## 1. DESIGN STANDARDS

**Colors (CSS tokens -- never hardcode hex values directly):**
| Token | Hex | Use |
|-------|-----|-----|
| `--black` | #000000 | Primary text, borders, headings |
| `--white` | #FFFFFF | All backgrounds |
| `--gray-dark` | #333333 | Secondary text |
| `--gray-mid` | #666666 | Labels, breadcrumbs, metadata |
| `--gray-light` | #F4F4F4 | Section backgrounds |
| `--gray-rule` | #DDDDDD | Dividers, card borders |
| `--navy` | #2E6BD6 | Auto/GatewayGuard-handled tag accent (Brighter Blue) |
| `--mocha` | #A0522D | Manual setup tag accent (Vibrant Mocha) |
| `--charcoal` | #5E35B1 | User-choice tag accent (Deep Violet) |

**Senior-Audience Color Rules (DO NOT VIOLATE):**
- All backgrounds are white or `--gray-light` only. No colored tints, no pastels.
- Light green, pale blue, soft amber backgrounds are PROHIBITED -- they
  read as muddy through aging eyes.
- When color is used for categorization, use deep saturated tones
  (navy, mocha, charcoal) on borders and text only -- never as background fills.
- Color is never the sole indicator of meaning. Always pair color with a
  bold text label and/or icon (e.g. ✓ Automatic, ✎ Manual, ▶ Your decision).
- Build hierarchy with font size, font weight, and borders first.
  Color is progressive enhancement only.

**Typography:**
- Body: Arial, Helvetica, sans-serif
- Code/commands: Consolas, "Courier New", monospace
- Minimum body font size: 15px
- Minimum card description font size: 15px
- Minimum tag/badge font size: 12px
- Line height: 1.5 minimum for body text

**Layout:**
- Max width: 960px centered
- Single column on mobile (max-width: 600px)
- No sidebars
- Padding: 0 24px inside .wrap

**Structural elements (boxes, not solid fills):**
- Nav, tool banners, page headers, table headers, footer:
  white background + 4px solid black border on ALL FOUR SIDES
- Section dividers: 1px solid `--gray-rule`
- Cards: 1px solid `--gray-rule`, hover to 1px solid black

**Navigation (identical on every page):**
```
Home | Download | Guide | Tips | Beta | Compatible
```
- Active page link: underlined or 3px black border-bottom
- Nav is sticky (position: sticky; top: 0; z-index: 100)

**Footer (identical on every page):**
- GatewayGuard LLC · Brunswick, Maine · support@gatewayguard.co
- "GatewayGuard does not collect personal data or show ads. No subscription -- ever."
- "Source code is included with every download. © 2026 GatewayGuard LLC. All rights reserved."
- Footer email is always support@gatewayguard.co -- never a personal email address.

---

## 2. FILE NAMING AND HEADERS

**Filename convention (effective 2026-07-21):**
- Working/project files: `GatewayGuard_[pagename]-YYYY-MM-DD-HHMM.html`
  Example: `GatewayGuard_index-2026-07-21-1009.html`
- Date AND time are both required in the filename.
- No -r2, -r3, or any other revision suffix. Ever.
- GitHub repo files use clean names with no dates:
  `index.html`, `guide/index.html`, `guide/windows-update.html` etc.
- Before producing any file, Claude must ask Bill for the current date
  and time. Both the filename and internal header come from that answer.
  Claude never infers the date from UTC chat metadata or system clocks.

**Internal header (top of every HTML file):**
```html
<!-- Dated: YYYY-MM-DD HH:MM EDT -->
<!-- File: GatewayGuard_[pagename]-YYYY-MM-DD-HHMM.html (deploys as path/filename.html) -->
<!-- GatewayGuard LLC -- gatewayguard.co/[path] -->
<!-- Change History:
     YYYY-MM-DD: Description of what changed.
     YYYY-MM-DD: Prior change.
-->
```

---

## 3. BUILD AND EDIT RULES

**READ BEFORE PRODUCING (effective 2026-07-21):**
Before building or updating any HTML file, Claude must:
1. Read GatewayGuard_WebsiteStandards.md from project knowledge.
2. Read the current version of the HTML file from project knowledge
   if it already exists. Never produce an updated HTML file from
   memory or a prior session's output.
3. Deliver the result as a complete self-contained replacement file
   so Bill can do a full delete and replace with zero assembly required.

**RULE W-01 -- NO SED ON HTML:**
Never use `sed` or bash string replacement on HTML files.
It corrupts nested tags and breaks HTML entities.
All edits must use `str_replace` on unique strings, or a clean full rewrite.

**RULE W-02 -- CORRUPTION CHECK (mandatory, Claude runs and reports):**
Before presenting any HTML file, Claude runs both grep checks and
reports results in the response:
```bash
grep -n 'class="\([^"]*\)"><[^>]*class="\1"' file.html
grep -n '#[0-9]\{4,5\};' file.html
```
Any hit that is NOT a valid HTML entity (&#NNNNN;) must be fixed
before delivery. Claude reports: "W-02 PASSED" or lists findings.

**RULE W-03 -- BROWSER CHECK (mandatory instruction in every response):**
Claude's preview does not render CSS. Every HTML delivery response
must include this instruction:
"Open this file in Chrome or Edge on your PC before pushing to GitHub.
Claude's preview does not render CSS."
The file must not be pushed until Bill confirms it looks correct in
a real browser.

**RULE W-04 -- W3C VALIDATION (mandatory instruction in every response):**
Every HTML delivery response must include:
"Validate at https://validator.w3.org -- use Validate by Direct Input,
paste the file content, click Check. Fix all errors before pushing.
Warnings are acceptable; errors are not."

**RULE W-05 -- ONE FILE AT A TIME TO GITHUB:**
Push one file, confirm it renders correctly at gatewayguard.co, then
push the next. Never batch-push multiple files without verifying each.

**RULE W-06 -- PAIRED LINK CHECK:**
Any time a page is added or renamed, check every existing page that
links to it. Nav links, breadcrumbs, and "Back to Guide" links must
all be updated in the same session.

---

## 3a. HTML DELIVERY GATE (effective 2026-07-21)

This gate is the HTML equivalent of the PowerShell BUILD GATE.
No HTML file is presented as complete until all steps are done and
reported in the same response. A skipped step blocks delivery.

Before presenting any HTML file, Claude must show:

```
HTML DELIVERY GATE RESULTS
H-1 Corruption grep (W-02): [PASSED -- 0 issues] or [list findings]
H-2 Browser check instruction (W-03): [INCLUDED in response]
H-3 W3C validation instruction (W-04): [INCLUDED in response]
Gate status: [ALL PASSED -- file ready for delivery]
```

If any gate fails or is skipped, Claude fixes and re-runs before
presenting the file. No exceptions.

---

## 4. GITHUB PAGES DEPLOYMENT

**Repo:** github.com/gatewayguard/gatewayguard.github.io
**Branch:** main
**Custom domain:** gatewayguard.co (configured in repo Settings > Pages)
**DNS:** A records at Namecheap pointing to GitHub Pages IPs
         (185.199.108.153, 185.199.109.153, 185.199.110.153, 185.199.111.153)

**To update an existing file:**
1. Go to the file in the repo
2. Click the pencil (Edit) icon
3. Select all (Ctrl+A), delete, paste new content
4. Scroll to bottom, click "Commit changes..."
5. Confirm in the dialog

**To add a new file in a subfolder:**
1. Click Add file > Create new file
2. Type `foldername/filename.html` (the slash creates the folder)
3. Paste content, commit

**Propagation:** Changes go live within ~60 seconds.
Hard refresh with Ctrl+Shift+R to bypass browser cache.

**Known quirk:** GitHub online editor Commit button can become
unresponsive after large pastes. Fix: press F11 (full screen toggle),
then try committing again. If still stuck, Ctrl+Shift+R and re-paste.

---

## 5. SITEMAP AND BUILD PRIORITY

**Phase 1 -- Launch dependencies (must be live September 1):**
| File | Status |
|------|--------|
| index.html | ✓ Live (updated 2026-07-21) |
| guide/index.html | ✓ Ready to push (2026-07-21) |
| guide/windows-update.html | ✓ Built (needs push) |
| guide/defender-realtime.html | ✓ Built (needs push) |
| guide/tamper-protection.html | ✓ Built (needs push) |
| guide/smartscreen.html | ✓ Built (needs push) |
| guide/phishing-protection.html | ✓ Built (needs push) |
| guide/firewall.html | ✓ Built (needs push) |
| guide/bitlocker.html | ✓ Built (needs push) |
| guide/periodic-scanning.html | Not built |
| guide/windows-hello.html | Not built |
| guide/remote-desktop.html | Not built |
| guide/advertising-id.html | Not built |
| guide/diagnostic-data.html | Not built |
| guide/edge-startup.html | Not built |
| guide/widgets.html | Not built |
| guide/password-manager.html | Not built |
| guide/memory-integrity.html | Not built |
| guide/password-on-wake.html | Not built |
| guide/fast-startup.html | Not built |
| guide/wake-on-lan.html | Not built |
| download.html | Not built |

**Phase 2 -- Growth:**
| File | Status |
|------|--------|
| beta.html | Not built |
| compatible.html | Not built |
| glossary.html | Not built |

**Phase 3 -- Content expansion:**
| File | Status |
|------|--------|
| tips.html | Not built |
| firefox.html | Not built |
| settings-reference.html | Not built |

---

## 6. INDIVIDUAL SETTING PAGE TEMPLATE

Every guide/[setting].html follows this structure:

1. Breadcrumb: Home > Guide > [Setting Name]
2. Setting name + ID number (large heading)
3. "What GatewayGuard did" box (bordered, not filled):
   - Found: [what was detected]
   - Action taken: [what tool did or recommended]
4. WHY THIS MATTERS (plain English, 2-3 sentences)
5. HOW TO CHECK IT YOURSELF (numbered steps)
6. HOW TO CHANGE IT (if manual action needed)
7. HOW TO REVERT IT (if user wants to undo)
8. WHAT TO EXPECT AFTER (side effects, reboots, etc.)
9. Related settings links
10. "Back to Guide" link

**Content sources by setting -- see GatewayGuard_SettingsToGuideMap.md**

---

## 7. WRITING RULES (all pages)

- Plain English only. No jargon. Test: "Would a non-technical neighbor
  understand this in 5 seconds?"
- Active voice. Say what the setting does, not what it is.
- Never describe GatewayGuard as "open-source." Use "source-visible"
  or "fully auditable."
- Assisted sessions are a planned future offering -- never describe
  as currently available.
- No ads, no tracking pixels, no newsletter popups, no login required.
- Footer email is always support@gatewayguard.co -- never personal email.

---

## 8. TOOLS AND REFERENCES

| Tool | URL | Use |
|------|-----|-----|
| W3C HTML Validator | validator.w3.org | Validate HTML before go-live -- required |
| W3C CSS Validator | jigsaw.w3.org/css-validator | Validate CSS |
| MDN Web Docs | developer.mozilla.org | HTML/CSS reference |
| GitHub Pages repo | github.com/gatewayguard/gatewayguard.github.io | Live repo |
| Live site | gatewayguard.co | Live site |
| Direct GitHub URL | gatewayguard.github.io | Bypasses DNS cache for testing |
