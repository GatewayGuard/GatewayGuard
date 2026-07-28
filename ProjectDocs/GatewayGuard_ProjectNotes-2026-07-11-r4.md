# GatewayGuard Project Notes
<!-- Dated: 2026-07-11 17:15 ET -->
**Last Updated:** 11-Jul-2026 17:15 ET (ascii21 line count filled: 3,468; round-3 field test on ascii24 -> ascii25 built same day: FT-21..28 fixes, Ctrl+C fix, Defender false-alarm fix, deep-scan guidance)
**Current Build:** ascii25 (built 2026-07-11 PM -- ready to test)
**Test Machines:** HP Notebook 17-by1955cl (SANDY), Lenovo IdeaPad, Dell Latitude 5430 (ready for T3)

## ACTIVE WORKSTREAMS (update with every revision)

| Workstream | Status as of 11-Jul-2026 |
|---|---|
| Build/Test | ascii25 built 2026-07-11 PM (FT-21..28) -- NEEDS TEST RUN; FT-27b (eaten keypress) open; T3 (ascii22 on Dell) queued |
| Website | BLOCKED -- waiting on notes files from IdeaPad; then HTML/CSS build, GitHub Pages, DNS |
| Licensing | PENDING DECISION -- Option B (source-available) vs C (closed proprietary); attorney review before launch |
| Marketing/Copy | PENDING DECISION -- product-copy naming rule (two-names-only vs sourced comparisons); see entry dated 2026-07-10 |

---

## CURRENT BUILD STATUS

| Build | Lines | Status |
|-------|-------|--------|
| ascii13 | 2,436 | Archive |
| ascii14 | 2,530 | Archive |
| ascii15 | 2,675 | Archive |
| ascii16 | 2,873 | Archive |
| ascii17 | 2,938 | Archive |
| ascii18 | 3,114 | Archive |
| ascii19 | 3,310 | Archive |
| ascii20 | 3,339 | Archive |
| ascii21 | 3,468 | Archive |
| ascii22 | 3,534 | Tested (Dell first run 2026-07-02; T3 pending) |
| ascii23 | 4,201 | Archive (round-2 field feedback folded into ascii24) |
| ascii24 | 4,344 | **CURRENT -- built 2026-07-11, ready to test** |

---

## TESTED HARDWARE REGISTRY

### #1 -- HP Laptop 17-by1xxx (SANDY)
- **OS:** Windows 11 Home (EditionID: Core, Build 26200)
- **CPU:** Intel Core i5-8265U @ 1.60GHz
- **RAM:** 7.9 GB
- **Storage:** 238GB SSD (primary) + 932GB HDD + 7.5GB recovery partition
- **Battery:** Yes -- laptop, BatteryStatus 2 = AC connected
- **AV:** Malwarebytes Free (productState=0x061000) + Windows Defender
- **Key finding:** MB Free sets 0x1000 productState bit even as companion -- fixed in ascii20
- **First tested:** ascii13
- **Latest test:** ascii20 (pending)
- **Network issues (June 26, 2026):**
  - Intermittent Wi-Fi disconnects -- partially fixed by driver update
  - Was using 8.8.8.8 (Google DNS) with NO alternate -- caused browser
    failures even when network reconnected (DNS hiccup = no fallback)
  - FIX APPLIED:
    * IPv4 Alternate DNS added: 8.8.4.4
    * DNS over HTTPS set to On (automatic template) for both
    * Power Management: unchecked "Allow computer to turn off this device"
  - IPv6 left on automatic (manual entry gave error -- correct behavior)
  - Monitor for stability after these changes

### #2 -- Lenovo IdeaPad (William's dev machine)
- **OS:** Windows 11 Home
- **Battery:** Yes -- laptop
- **CPU:** TBD (run Get-ComputerInfo to confirm)
- **RAM:** TBD
- **Storage:** TBD
- **Keyboard:** Built-in broken (stuck E + Windows keys) -- USB keyboard/mouse workaround
- **AV at first test run (June 25, 2026):**
  - Windows Defender: PRIMARY -- AMRunningMode=Normal, RealTimeProtection=True (397568=0x061100)
  - Malwarebytes: Installed, RT OFF (393232=0x060010) -- not interfering
  - Fortect Security Suite: WAS installed (PUP/optimizer) -- uninstalled before test
    Ghost SC2 entry self-cleaned on uninstall -- no manual removal needed
  - Windows Firewall: ON all profiles
- **Key finding:** Clean Defender primary + MB companion (MB turned off)
  This is the HEALTHY SETUP scenario -- ideal baseline test for ascii20
- **First test build:** ascii20 (June 25, 2026 -- results pending)
- **Status:** First full test run in progress

---

## PENDING TEST ITEMS (ascii20)
When you get back to the HP, watch for:
1. Malwarebytes detected correctly as FreeCompanion (not TrialActive)
2. Defender shown as ON and primary
3. Tamper Protection reading correctly from registry
4. Battery % showing on AC power screen
5. Edition showing "Core -- Windows 11 Home"
6. Convenience feature review working one at a time at end
7. Screen timeout showing "Found: X min"
8. Box text not cut off on any screen
9. Useless pauses gone after Y confirmations

---

## KNOWN BUGS / FIXED IN ascii20
- [FIXED ascii20] MB Free productState 0x1000 bit unreliable -- now uses Get-MpComputerStatus directly
- [FIXED ascii19] Tamper Protection unreadable when MB present -- now reads registry directly
- [FIXED ascii19] Draw-Box colors -- all white/black now, color only for status
- [FIXED ascii19] Screen timeout said "active" -- now says "Found: X min"
- [FIXED ascii19] Edition showed "Core" only -- now "Core -- Windows 11 Home"
- [FIXED ascii19] Useless pauses after Y confirmations -- removed
- [FIXED ascii18] Battery said "no battery risk" on laptop -- now shows laptop vs desktop
- [FIXED ascii18] httpUsbBridge / Brother flagged as suspicious -- added to TrustedPublishers

---

## FUTURE FEATURES / IDEAS TO BUILD

### High Priority
- [ ] Pull system info at startup and display hardware profile to user
  - Make/Model, CPU, RAM, Storage type, Battery Y/N, Edition
  - Compare against tested hardware registry
  - Flag "Untested hardware" if not on list

### Beta Tester Program
- [ ] Build beta tester signup on gatewayguard.co
- [ ] Screen checklist for known problem configurations before accepting
- [ ] Remote session process: screen share only + text back and forth
- [ ] After session: log hardware profile to tested registry
- [ ] Offer: free hardening session in exchange for being a test subject
- [ ] Build "Untested hardware" warning screen in tool that offers beta program

### Tested Hardware Registry (in-tool)
- [ ] Decide: separate document vs built into tool
- [ ] If built-in: show "Tested on your hardware" vs "Untested -- beta"
- [ ] Track: Make/Model, OS edition, known quirks, first/last build tested

### Windows 11 Pro Support
- [ ] Test on Pro edition machine
- [ ] Verify Group Policy settings work correctly
- [ ] Remote Desktop section currently N/A on Home -- enable for Pro
- [ ] Verify BitLocker full encryption (Pro) vs Device Encryption (Home)

### Other Editions
- [ ] Windows 11 Education
- [ ] Windows 11 Enterprise
- [ ] Note: currently only Home confirmed tested

### Tool Improvements
- [ ] Add Pro edition wording throughout (currently Home focused)
- [ ] Consider GUI improvements based on test feedback
- [ ] Scheduled scan verification screen -- confirm tasks were created

---

## PROJECT SETUP
- **Files location:** OneDrive -> GatewayGuard folder
- **Launcher:** Run-GatewayGuard.bat (always same folder as .ps1)
- **Log:** Saved to Desktop after each run
- **Claude Project:** GatewayGuard (this project)
- **Website:** gatewayguard.co

---

## SESSION NOTES -- June 23, 2026
- William's keyboard broke on broken PC (IdeaPad)
- Used on-screen keyboard to get back in
- Recovered full project via Untitled.txt export from broken PC browser
- Moved to wife's PC for this session (logged into same Claude account)
- Files synced to OneDrive
- HP system info collected -- revealed MB detection bug
- Built ascii18, ascii19, ascii20 in this session


---

## SESSION NOTES -- June 25, 2026

### IdeaPad Pre-Run Findings
- Fortect Security Suite found in SC2 -- already uninstalled, ghost entry self-cleaned
- Win32_Product query confirmed Fortect gone (slow ~60 sec query -- normal)
- SC2 clean: Malwarebytes (RT off, 0x060010) + Windows Defender (primary, 0x061100)
- AMRunningMode = Normal -- Defender fully active
- IdeaPad is in HEALTHY SETUP state -- best test scenario so far
- ascii20 test run initiated on IdeaPad (results pending upload)

### New Key Learnings
- **Ghost SC2 entries**: Uninstalled AV products can leave stale SC2 entries.
  Fortect self-cleaned but not all products do. ascii21 should cross-check
  SC2 entries vs Win32_Product to flag ghosts differently from active AVs.
- **Win32_Product is slow**: 30-60 sec query -- use only when needed.
- **Fortect Security Suite**: PUP/optimizer, mixed reputation. Good example
  of what apps audit should flag for user review.
- **IdeaPad SC2 productStates confirmed**:
  MB = 393232 (0x060010) -- RT bit OFF, companion only
  Defender = 397568 (0x061100) -- primary, active
- **Maine LLC**: William operates from Brunswick, ME. Form LLC in Maine.
  $175 filing, $85/year. maine.gov/sos/cec/corp/llc.html
- **gatewayguard.co domain**: Purchased. Website 0% built.
- **Dell Latitude 5430 ordered**: $539, arriving 10-14 days.
  First Windows 11 Pro test machine.
- **Website content**: windows_security_walkthrough_guide_v9.docx found --
  13 of 19 settings already have guide content written.
  Only settings 18 (Fast Startup) and 19 (Wake on LAN) need new content.


---

## APPS AUDIT -- TRUSTED/FLAG/REMOVE RESEARCH (June 25, 2026)

### Three-tier system for ascii22+

**TIER 1 -- ALWAYS TRUSTED (never flag):**
OEM/Hardware: Microsoft, Dell, HP, Lenovo, ASUS, Acer, Samsung, Intel, NVIDIA, AMD,
Qualcomm, Realtek, Brother, Canon, Epson, Logitech
Software: Google, Apple, Mozilla, Adobe, Valve/Steam, Epic Games, EA/Origin,
Battle.net/Blizzard, GOG, Malwarebytes, Zoom, Slack, Dropbox, ProtonMail/Proton AG,
Chrome Remote Desktop (Google LLC), VLC (VideoLAN), 7-Zip, WinRAR, HandBrake,
VirtualBox (Oracle), VMware, Git, Python, Node.js, VS Code (Microsoft)
Gaming anti-cheat: EasyAntiCheat, BattlEye (look like rootkits but are legitimate)

**TIER 2 -- ADVISORY YELLOW (flag with explanation, let user decide):**
- CCleaner / Recuva (Piriform/Avast) -- legitimate but bundles other software
- IObit Uninstaller, Advanced SystemCare -- bundling concerns
- Glary Utilities -- bundling concerns
- PC Manager (Microsoft) -- community reports of permission oddities
- Any "PC optimizer" or "Registry cleaner" -- rarely needed, sometimes harmful
- Shopping browser extensions (Honey, Capital One Shopping) -- broad permissions,
  affiliate link replacement concerns

**TIER 3 -- FLAG RED (genuinely unwanted, suggest removal):**
- Non-OEM driver updaters: Driver Booster, Driver Easy, DriverPack -- install wrong
  drivers, often PUP flagged. Get drivers from hardware vendor directly.
- Reimage, PC Keeper, PC Repair Online -- fake repair tools
- Toolbar installers (Ask Toolbar, MyWebSearch, bing.vc, vosteran)
- DNS Unlocker -- known adware
- Browser hijackers -- any app that changed homepage/search without consent
- Fortect Security Suite -- PUP/optimizer (found on IdeaPad, uninstalled)
- Any app the user cannot identify or did not intentionally install

### Note on CCleaner specifically:
Defender flags free CCleaner as PUA:Win32/CCleaner due to bundling Avast/Google Chrome
during install. It is NOT malware. GatewayGuard should show it as Tier 2 advisory,
not recommend removal -- many users have it intentionally.

### Note on Steam/gaming:
Steam triggers false positives due to file management behavior. Always Tier 1 trusted.
Game anti-cheat engines (EasyAntiCheat, BattlEye, Vanguard) look like rootkits to
scanners but are legitimate -- add to trusted list.

### For ascii22: implement three-tier display in apps audit
- Green: Tier 1 trusted -- no action
- Yellow: Tier 2 advisory -- explain and let user decide  
- Red: Tier 3 flag -- recommend removal with explanation


---

## COMPETITIVE ANALYSIS (June 25, 2026)

### Tools Reviewed
1. Hardentools (free, open source)
2. HotCakeX / Harden Windows Security (free, Microsoft Store)
3. ZephrFish Script (free, GitHub -- expert/pentester tool)
4. NoID Privacy Pro ($39.99 one-time)
5. Microsoft Defender for Endpoint P1 ($34.20/yr -- enterprise only)

---

### Competitive Positioning Summary

| Tool | Price | Target User | Settings | Human Support | Plain English WHY |
|------|-------|-------------|----------|---------------|-------------------|
| GatewayGuard | Free | Home/personal | 19 (growing) | YES -- beta program | YES |
| Hardentools | Free | At-risk individuals | ~25 | NO | NO |
| HotCakeX | Free | Technical users | 200+ | NO | NO |
| ZephrFish | Free | Security professionals | ~30 | NO | NO |
| NoID Privacy | $39.99 one-time | Semi-technical | 630+ | NO | Partial |
| Defender Endpoint P1 | $34/yr+ enterprise | Enterprise IT dept | Thousands | Enterprise only | NO |

---

### Key Findings Per Tool

**Hardentools:**
- Focuses on disabling legacy attack vectors: Windows Script Host, AutoRun/AutoPlay,
  Office macros, OLE objects, PDF JavaScript, cmd.exe/PowerShell via Explorer
- All-or-nothing approach with restore button
- NOT for corporate environments
- No explanations of what or why -- just harden/restore buttons
- GatewayGuard opportunity: add AutoRun/AutoPlay and Script Host for future build

**HotCakeX / Harden Windows Security:**
- Most technically sophisticated free tool
- Uses only official Microsoft methods (Group Policy, PowerShell cmdlets)
- UEFI Lock for LSA, ELAM Good Only, clears remote registry paths
- Targets technical/enterprise users -- no hand-holding
- GatewayGuard opportunity: borrow ELAM Good Only setting for future build

**NoID Privacy Pro ($39.99):**
- CLOSEST DIRECT COMPETITOR
- 630+ settings: 335 registry, 67 security templates, 23 audit policies, 19 ASR rules
- Full Microsoft Security Baseline v25H2
- BAVR pattern (Backup/Apply/Verify/Restore) -- similar to GatewayGuard approach
- Three profiles: Balanced / Enterprise / Maximum
- Disables 15 Windows AI features (Recall, Copilot, Paint AI etc)
- Blocks WDigest (plaintext passwords in LSASM), PowerShell v2, WPAD
- HTML compliance report with security score
- No human support, no beta program, still requires technical comfort
- GatewayGuard settings to borrow: WDigest disable, Windows Recall disable,
  PowerShell v2 disable, ASR rules (Defender-specific)

**Microsoft Defender for Endpoint P1:**
- NOT a competitor -- completely different product category
- Enterprise IT tool requiring M365 subscription, IT admin, security ops team
- $34.20/yr is misleading -- real cost includes surrounding M365 enterprise stack
- Home users cannot meaningfully purchase or use this product

---

### GatewayGuard Unique Differentiators
(Things NO other tool offers)

1. PLAIN ENGLISH WHY -- Every setting explained in non-technical terms
   "Here is what was found, here is what we changed, here is exactly why"
   No other tool in this space does this for home users

2. HUMAN-ASSISTED SESSIONS -- Beta tester program
   Screen share + text guidance = personal security consultant experience
   No other tool offers this at any price point

3. HARDWARE-AWARE -- Detects your specific PC (battery, edition, RAM, AV state)
   Adapts recommendations to your actual hardware
   Other tools apply the same settings regardless of machine

4. GUIDED DECISION-MAKING -- User approves each change individually
   Other tools are all-or-nothing or require technical knowledge to customize

5. APPS AUDIT -- Reviews installed apps for PUPs and suspicious software
   No comparable tool includes this in the same workflow

6. COMPANION TO GUIDE -- Full written guide at gatewayguard.co/guide
   Every manual step has a dedicated web page with screenshots
   Creates a complete ecosystem, not just a script

---

### MARKETING ANGLES

**Headline positioning:**
"The only Windows security tool that explains what it found, what it changed,
and exactly why -- in plain English. Free."

**Against Hardentools/HotCakeX/ZephrFish (free tools):**
"Free tools exist but they require you to already understand security.
GatewayGuard is free AND explains everything."

**Against NoID Privacy Pro ($39.99):**
"NoID applies 630 settings automatically. GatewayGuard walks you through 19
essential ones and makes sure you understand each one. Different tools for
different users -- NoID for the technically confident, GatewayGuard for everyone else."
OR
"NoID is an excellent tool for power users. GatewayGuard is for everyone else --
free, guided, and backed by a real person if you need help."

**Against paying for antivirus subscriptions:**
"You already have Microsoft Defender built into Windows 11. GatewayGuard makes
sure it is set up correctly and turned on -- for free. Stop paying for protection
you already have."

**Beta tester program angle:**
"Untested hardware? We will run GatewayGuard with you over screen share, free.
You get a hardened PC. We get compatibility data."

**Trust angle:**
"GatewayGuard does not install background software. It does not phone home.
It does not collect your data. It runs, makes changes you approved, and exits."

---

### PRICING STRATEGY

**Current: Free (appropriate for launch phase)**
- Builds user base and hardware test registry
- Beta program generates testimonials and word of mouth
- Trust established before any monetization

**Future pricing options to consider:**

OPTION A -- Freemium model:
- GatewayGuard Basic: Free -- 19 core settings, console mode
- GatewayGuard Pro: $19.99 one-time -- adds GUI mode, compliance report,
  scheduled re-checks, priority email support
- Positions below NoID ($39.99) while offering the human element they don't

OPTION B -- Assisted session model:
- GatewayGuard tool: Always free
- GatewayGuard Assisted Session: $29-49 one-time
  Remote screen share session, guided hardening, Q&A included
  Targets users who want human help, not just software
- Differentiated from all competitors -- none offer this

OPTION C -- Subscription:
- GatewayGuard Basic: Free
- GatewayGuard Annual: $12-15/year
  Re-run alerts when new Windows settings need attention
  Annual security check-in email
  Access to guide updates
  Too similar to what competitors do -- least differentiated option

OPTION D -- Business/family plan:
- GatewayGuard Home: Free (1 PC)
- GatewayGuard Family: $24.99 one-time (up to 5 PCs)
- GatewayGuard Small Business: $99/year (up to 25 PCs, admin dashboard)

**RECOMMENDED PATH:**
Phase 1 (now): Free tool + free beta sessions -- build reputation and test data
Phase 2 (after 50+ tested machines): Add Pro version at $19.99 one-time
Phase 3 (after website launch): Add Assisted Session at $39-49 one-time
Phase 4 (if demand warrants): Family/Small Business plans

The assisted session model is the strongest long-term differentiator because
it cannot be replicated by software alone. NoID cannot offer a human.
Hardentools cannot offer a human. GatewayGuard can -- and that is worth paying for.

---

### SETTINGS TO ADD IN FUTURE BUILDS (from competitive research)

**High priority (ascii22-23):**
- Disable WDigest (prevents plaintext passwords in LSASS memory)
  HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest
  UseLogonCredential = 0
- Disable AutoRun/AutoPlay (USB attack vector)
  Registry: HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer
  NoDriveTypeAutoRun = 255
- Disable Windows Script Host (VBScript/JavaScript malware delivery)
  HKLM:\SOFTWARE\Microsoft\Windows Script Host\Settings
  Enabled = 0
- Disable PowerShell v2 (legacy, no logging, exploit vector)
  Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root

**Medium priority (future):**
- Disable Windows Recall/AI features (privacy)
- ELAM set to Good Only (Early Launch Antimalware)
- ASR rules (19 rules, Defender-specific API -- requires Defender as primary)
- WDigest disable
- WPAD disable (Web Proxy Auto-Discovery -- MITM vector)

**Lower priority:**
- Full Microsoft Security Baseline v25H2 alignment
- Audit policy configuration (23 policies)
- Security template settings (67 settings)


---

## ASCII22 PLANNED CHANGES (do not build until ascii21 fully tested)

### New Security Settings (from competitive research):
1. **Disable WDigest** -- prevents plaintext passwords in LSASS memory
   HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest
   UseLogonCredential = 0
   Simple registry key, high security value, no user impact

2. **Disable AutoRun/AutoPlay** -- USB attack vector
   HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer
   NoDriveTypeAutoRun = 255
   Prevents malware auto-executing when USB plugged in

3. **Disable Windows Script Host** -- VBScript/JavaScript malware delivery
   HKLM:\SOFTWARE\Microsoft\Windows Script Host\Settings
   Enabled = 0
   Blocks ransomware delivery via .vbs and .js files

4. **Disable PowerShell v2** -- legacy version, no logging, exploit vector
   Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root
   NOTE: requires restart, check if Home edition supports this

### Apps Audit Improvements:
- Implement three-tier system (Green/Yellow/Red)
- Tier 1 trusted: add Steam, VirtualBox, VMware, Git, Python, VLC, 7-Zip,
  WinRAR, HandBrake, ProtonMail, Chrome Remote Desktop, EasyAntiCheat, BattlEye
- Tier 2 advisory yellow: CCleaner, IObit, PC Manager, shopping extensions
- Tier 3 red flag: non-OEM driver updaters, Reimage, PC Keeper, toolbars

### Convenience Feature Reorder:
Current: 11=Advertising ID, 12=Diagnostic Data, 13=Edge Startup, 14=Widgets, 15=Edge PW
New order: 11=Advertising ID, 12=Diagnostic Data, 13=Edge Password Saving,
           14=Edge Startup Boost, 15=Windows Widgets (Edge items together, Widgets last)

### Ghost SC2 Entry Detection:
- Cross-check SC2 AntiVirusProduct entries against Win32_Product
- If in SC2 but NOT in Win32_Product = ghost entry
- Flag differently from real active AVs
- Offer to clean ghost entries automatically

---

## INTERNATIONALIZATION & GLOBAL MARKET (research June 26, 2026)

### To Research:
- Best marketing practices for global market
- Top 10 Windows 11 countries by user base
- How to handle non-English Windows 11 users
- Translation approach for tool and website
- Whether Claude handles other languages for support

### Windows 11 Global Scale (as of early 2026)
- 1 BILLION Windows 11 users worldwide (Microsoft earnings call Jan 28, 2026)
- Windows 11 now at ~72% of all Windows desktop users (Feb 2026)
- Windows dominates desktop at 62-67% worldwide market share
- Windows strongest in Europe (69% desktop share), Asia (65%), US (61%)

### Top 10 Countries by Windows PC Users (estimated 2025)
1. USA -- ~230 million Windows users -- Language: English
2. China -- ~200 million Windows users -- Language: Mandarin Chinese
3. India -- ~150 million Windows users -- Languages: Hindi, English
4. Japan -- ~100 million Windows users -- Language: Japanese
5. Germany -- ~45 million Windows users -- Language: German
6. Brazil -- ~80 million Windows users -- Language: Portuguese
7. UK -- ~50 million Windows users -- Language: English
8. France -- ~40 million Windows users -- Language: French
9. Russia -- ~50 million Windows users -- Language: Russian
10. South Korea -- ~30 million Windows users -- Language: Korean

### Priority Languages for GatewayGuard (by market size)
Tier 1 (English-speaking -- covered now):
  USA, UK, Canada, Australia, India (English educated class)

Tier 2 (large markets, high value):
  Mandarin Chinese (China/Taiwan) -- 200M+ users
  Japanese -- 100M+ users
  German -- 45M+ users (high security consciousness, strong privacy culture)
  Portuguese (Brazil) -- 80M+ users
  Spanish (Latin America + Spain) -- 150M+ combined

Tier 3 (medium markets):
  French, Russian, Korean, Italian

NOTE: NoID Privacy already supports 8 languages -- this is a competitive gap.
German users especially are known for high security and privacy awareness --
strong potential market with GatewayGuard's privacy angle.

### Does Claude Support Other Languages?
YES -- Claude reads and writes fluently in all major world languages including:
Mandarin Chinese, Spanish, French, German, Japanese, Portuguese, Russian, Korean,
Italian, Arabic, Hindi, and dozens more. Claude can:
- Translate GatewayGuard tool text into any language
- Conduct beta tester support sessions in other languages via text
- Translate the website guide content
- Answer security questions from non-English users
This means the beta tester support model scales globally without hiring
multilingual staff -- just use Claude as the communication layer.

### How to Handle Non-English Windows 11 Users

OPTION A -- Tool detects Windows UI language automatically:
PowerShell: (Get-Culture).Name returns e.g. "de-DE", "zh-CN", "ja-JP"
Tool then loads appropriate language strings
Complex to implement but best user experience
All 19 setting explanations need translation per language

OPTION B -- Language selection screen at startup:
User picks their language from a list
Simpler to implement
Good interim solution while building out full auto-detection

OPTION C -- English only with website translation:
Tool stays English
Website uses auto-translate (Google Translate widget or DeepL)
Lowest cost, least friction to implement
Adequate for initial launch

RECOMMENDED PATH:
Phase 1 (now): English only -- US/UK/Canada/Australia market
Phase 2 (after 100+ users): Add Spanish and German (large markets, high value)
Phase 3 (after revenue): Add Mandarin Chinese and Japanese
Phase 4 (mature product): Full auto-detection of Windows UI language

### Legal Considerations by Region
GDPR (Europe -- Germany, France, UK post-Brexit etc):
  GatewayGuard currently collects NO user data, no telemetry, no accounts
  This is actually a MARKETING ADVANTAGE in Europe -- "zero data collection"
  Website needs a privacy policy page even if there is nothing to disclose
  If beta program collects email addresses -- need GDPR-compliant consent

China:
  Chinese cybersecurity law requires data stored in China for Chinese users
  Beta program sessions with Chinese users need careful consideration
  Free tool download likely fine -- collecting any data is complex
  Initial strategy: make tool available, avoid collecting Chinese user data

India:
  Personal Data Protection Bill -- similar GDPR-style considerations emerging
  Large English-speaking market -- high priority with no language barrier

USA (Maine LLC operating):
  Maine privacy law (MPPA) -- among the strongest state privacy laws in US
  Collecting zero data = compliant with all US state privacy laws
  LLC formation in Maine puts GatewayGuard under Maine jurisdiction

### Marketing for Global Market -- Key Principles

1. LEAD WITH PRIVACY (especially for European markets):
   "No accounts. No data collection. No telemetry. Ever."
   Germans and Northern Europeans especially respond to this positioning.

2. FREE IS THE UNIVERSAL MESSAGE:
   "$0 in every currency" -- free needs no translation
   Lead with free in all markets

3. HUMAN SUPPORT IS RARE GLOBALLY:
   "A real person helps you if you get stuck"
   This resonates in every culture -- paid tools don't offer this

4. SECURITY ANXIETY IS UNIVERSAL:
   Ransomware, phishing, identity theft -- fears are the same worldwide
   Case studies and threat stats are globally relevant

5. LOCALIZE THE WHY, NOT JUST THE WORDS:
   German users care about Datenschutz (data protection)
   US users care about identity theft and hackers
   Japanese users care about precision and reliability
   Tailor the homepage messaging per region even if the tool is the same

6. GDPR AS A FEATURE NOT A BURDEN:
   "GDPR compliant by design -- we collect nothing"
   Turns a legal requirement into a marketing message for European market

### Marketing Research Still Needed
- Best channels to reach home PC users by country (Reddit, local forums etc)
- Affiliate/referral marketing potential
- Security blogger outreach strategy
- ProductHunt launch planning
- GitHub presence and open source consideration
- YouTube demo video strategy (universal -- no language barrier)


---

## INDEPENDENT MARKET VALIDATION (Copilot Research -- June 26, 2026)

### Key Finding
Copilot independently confirmed GatewayGuard fills a REAL and UNCONTESTED gap:
"There is real demand for a Windows 11 hardening tool aimed at home and Pro
edition users -- but the gap isn't in more toggles. The gap is in guided,
explain-the-why, user-friendly hardening. Current tools either overwhelm
non-technical users or focus on enterprise-grade automation. Your concept
sits in the middle, where there is surprisingly little competition."

### Three Categories Dominating the Market (none serve home users well)

1. ENTERPRISE EDR PLATFORMS
   Microsoft Defender for Endpoint, CrowdStrike Falcon, Cortex XDR
   - Powerful but not for home users
   - Require subscriptions and centralized IT management
   - GatewayGuard opportunity: provide accessible hardening without IT dept

2. COMPLIANCE-DRIVEN TOOLS
   CIS-CAT Pro, Microsoft Security Compliance Toolkit, OpenSCAP
   - Built for CIS/NIST benchmark validation
   - Require technical knowledge
   - Produce audit reports, not interactive guidance
   - GatewayGuard opportunity: simplify CIS-style guidance for home users

3. PRIVACY/DEBLOAT UTILITIES
   O&O ShutUp10++, Winaero Tweaker, Win11Debloat, W10Privacy
   - Popular with home users but focus on telemetry/bloatware/UI tweaks
   - NOT full security hardening
   - Rarely explain why a setting matters
   - GatewayGuard opportunity: add real security hardening with explanations

### The Exact Gap GatewayGuard Fills
"There is no mainstream, user-friendly hardening assistant that:
 - Teaches users
 - Explains risks
 - Offers reversible changes
 - Works on Home edition
 - Does not require enterprise infrastructure
 This is a genuine market gap."

### Market Size Validation
- Over 75% of malware targets Windows endpoints -- hardening is critical
- AV-TEST: consumer Windows 11 systems heavily targeted, botnets of millions
  of infected HOME PCs driving demand for tools beyond antivirus
- Security publications confirm Windows 11 defenses are strong BUT require
  proper configuration -- home users don't know how to configure them
- Windows 11 now at 1 BILLION users (confirmed Jan 2026 Microsoft earnings)

### Competitive Positioning Table (from Copilot research)
| Tool | Audience | Strengths | Weaknesses | GatewayGuard Opportunity |
|------|----------|-----------|------------|--------------------------|
| Defender for Endpoint | Enterprise | Strong ASR/EDR | Not for home | Accessible hardening |
| CIS-CAT Pro | IT/security pros | Benchmark compliance | Too technical | Simplify CIS guidance |
| O&O ShutUp10++ | Home users | Easy privacy toggles | No security depth | Add real hardening |
| Win11Debloat | Power users | Removes bloat | Risky, no guidance | Safe explained changes |
| GatewayGuard | Home & Pro users | Guided, educational, reversible | New product | Fill explain+harden gap |

### The Non-Obvious Insight (Copilot's key finding)
"The biggest unmet need is TRUST + CLARITY. Most hardening tools fail because
users don't trust them -- they flip dozens of switches without explaining
consequences. Your approach (education + transparency + user control) directly
addresses this."

### Recommended Positioning (Copilot suggested)
"A guided Windows 11 security coach for everyday users."
This creates a NEW CATEGORY rather than competing with enterprise EDR
or debloat tools. Nobody owns this space yet.

### MARKETING IMPLICATIONS

**Lead message (validated by independent research):**
"The only guided Windows 11 security tool that teaches you what it's doing
and why -- and lets you decide. Free."

**Category creation angle:**
Don't say "security hardening tool" -- say "Windows 11 security coach"
or "Windows 11 security guide" -- positions as educational, not technical

**Trust angle (most important differentiator):**
"Every change explained. Every change reversible. You stay in control."
This directly addresses the #1 reason people don't trust hardening tools.

**Against debloat tools (O&O ShutUp10++ etc):**
"ShutUp10 tweaks privacy settings. GatewayGuard hardens your actual security
-- the settings that stop malware, ransomware and hackers."

**Against enterprise tools:**
"You don't need an IT department. GatewayGuard does what enterprise security
teams do, in plain English, for free, on your home PC."

**Stats to use in marketing:**
- "Over 75% of malware targets Windows" (AV-TEST)
- "1 billion Windows 11 users" (Microsoft Jan 2026)
- "Windows 11 security features are strong -- but only if properly configured"
- "Most home PCs ship with security features turned off by default"

### Additional Competitors to Research
From Copilot results -- tools not previously on our radar:
- O&O ShutUp10++ -- most popular home privacy tool, worth studying UX
- Winaero Tweaker -- UI/settings tweaker, large user base
- Win11Debloat -- GitHub script, power users
- W10Privacy -- older but still used
- Citadel Frame hardening guide -- text-only guide, no interactive tool
  (validates that even good guides don't fill the interactive gap)
NOTE: Research these tools' GitHub star counts, Reddit mentions, and
download numbers to quantify the market size more precisely.

### Next Research Steps
- [ ] Check Reddit r/Windows11, r/privacy, r/netsec for "hardening" discussion volume
- [ ] Check GitHub star counts for Win11Debloat, HotCakeX, Hardentools
- [ ] Look at O&O ShutUp10++ download numbers (millions -- shows market size)
- [ ] Research ProductHunt launches of similar tools
- [ ] Find security blogger/YouTuber outreach targets
- [ ] Research affiliate marketing potential with Malwarebytes, Bitwarden etc


---

## SESSION NOTES -- June 26, 2026

### Accomplished Today
- Recovered full project from broken IdeaPad using USB keyboard/mouse
- Transferred everything to wife's PC then back to IdeaPad
- Built ascii18, ascii19, ascii20, ascii21 (16 fixes in ascii21 alone)
- Identified and fixed MB Free productState 0x1000 bit detection bug
- Ran ascii20 on IdeaPad -- 16 new issues found and logged
- Built ascii21 with all 16 fixes including full ReadKey input lockout
- Fixed SANDY Wi-Fi DNS issue (added 8.8.4.4 alternate, power management fix)
- Created FixInternet.bat for SANDY desktop
- Created GatewayGuard OneDrive folder structure
- Created zip package of all project files
- Created GatewayGuard_MarketResearch.docx from Copilot validation research
- Researched competitive landscape (Hardentools, HotCakeX, NoID, Defender P1)
- Researched global market (1B Windows 11 users, top 10 countries, languages)
- Developed pricing strategy (Free -> Pro $19.99 -> Assisted Sessions $39-49)
- Planned Maine LLC formation
- Ordered Dell Latitude 5430 ($539, arrives 10-14 days) -- first Pro test machine
- Identified 3 new settings for ascii22 (WDigest, AutoRun, Script Host)
- Added Android Claude access to workflow
- Confirmed william.wfbiii@gmail.com as correct email across all accounts

### Files Created This Session
- W11-SecurityHardening-v3-ascii21.ps1 (current build)
- Run-GatewayGuard.bat (updated for ascii21)
- GatewayGuard_ProjectNotes.md (this file)
- GatewayGuard_Checklist.txt
- GatewayGuard_MBDefender_Screens.md (Screens A-D)
- GatewayGuard_WebsitePrePlan.md
- GatewayGuard_SettingsToGuideMap.md
- GatewayGuard_MarketResearch.docx
- GatewayGuard_Package.zip (all files in one download)
- FixInternet.bat (SANDY desktop tool)

### Next Session Priorities
1. Test ascii21 on IdeaPad -- upload results
2. Check SANDY MB trial expiry -- run after-trial checklist
3. Wait for Dell Latitude 5430 arrival (10-14 days)
4. Begin Maine LLC formation (maine.gov/sos/cec/corp/llc.html, $175)
5. Build ascii22 after ascii21 fully tested


---

## PRICING STRATEGY -- FINAL (June 26, 2026)

### Confirmed Pricing Structure
| Package | Price | PCs |
|---------|-------|-----|
| Single PC | $19.99 | 1 |
| 3 PC pack | $34.99 | 3 |
| 5 PC pack | $49.99 | 5 |
| 10 PC pack | $79.99 | 10 |
| Assisted Session | $39-49 | 1 (human screen share) |
| Listed/Compatible PCs | FREE | beta testers only |

### Vs. NoID Privacy Pro (closest competitor)
- NoID: €39.99 (~$43 USD) per device, one-time
- GatewayGuard: $19.99 per device, one-time
- GatewayGuard is less than HALF the price
- GatewayGuard adds human support NoID cannot offer
- NoID has very few public reviews -- easy to dominate in that space

### License Model
- Hardware fingerprint based -- cryptographic local binding
- No server required -- offline validation
- One PC per license
- Multi-PC packs for families and small businesses
- Repeat customer discount TBD

### Edge Cases to Decide Later
- Hard drive dies / Windows reinstall on same PC -- free reactivation?
- PC upgrade -- transfer license once per year?
- Listed PC becomes unlisted (user modifies hardware) -- ?
- These don't need to be decided before launch -- handle as support cases

---

## MARKETING -- AV SUBSCRIPTION ANGLE (key message)

### The Core Insight
Most home users pay $30-50/year for antivirus software they don't need.
Microsoft Defender -- built into every Windows 11 PC -- is FREE, maintained
by Microsoft (the biggest Windows supplier), updated automatically via
Windows Update, and independently tested as comparable to paid AV.

The ONLY reason Defender underperforms is that it ships with settings
turned off by default. GatewayGuard fixes that -- once, for $19.99.

### The Math (use this in marketing)
- Average AV subscription: $30-50/year
- Over 3 years: $90-150 spent on paid AV
- GatewayGuard: $19.99 ONE TIME
- Savings over 3 years: $70-130+
- AND you end up with better security than most paid AV provides

### Key Marketing Messages

**PRIMARY HEADLINE:**
"Stop paying for antivirus. You already have the best one -- free.
GatewayGuard makes sure it's turned on and set up correctly. $19.99, once."

**SUPPORTING MESSAGES:**
- "Microsoft built Defender. Microsoft updates it every month. Microsoft
  knows Windows better than any third-party antivirus company."
- "Independent tests (AV-TEST, AV-Comparatives) show Defender matches
  or beats most paid antivirus when properly configured."
- "Kaspersky was banned by the US government. Avast was fined $16.5M
  for selling user data. Defender doesn't sell anything -- it's Microsoft."
- "Most people don't know their antivirus subscription is optional.
  GatewayGuard shows you how to get the same protection for free."

**GERMAN MARKET ANGLE (high privacy consciousness):**
- "Kein Abo. Keine Datenweitergabe. Einmalig $19.99."
  (No subscription. No data sharing. One-time $19.99.)
- Germans especially distrust foreign AV companies after Kaspersky ban

**AFFILIATE MARKETING ANGLE:**
- NoID runs 50% affiliate commissions (~$20/sale)
- GatewayGuard could run 40% = ~$8/sale at $19.99
- Security bloggers and YouTubers actively look for these programs
- Lower price = easier sell = more affiliate volume

### What People Don't Realize (education = trust)
1. Defender is built into Windows 11 -- already paid for with the OS
2. Microsoft releases security updates every Patch Tuesday -- monthly
3. Defender ships with 19 Attack Surface Reduction rules -- all OFF by default
4. Tamper Protection, Real-Time Protection, SmartScreen -- often misconfigured
5. BitLocker encryption is built in -- most people never turn it on
6. All of this is FREE -- it just needs to be configured correctly
7. GatewayGuard does the configuration -- once -- for less than one year
   of any paid antivirus subscription

### Competitive Messaging Against Paid AV
| Product | Cost | Data Privacy | Updates | Who makes it |
|---------|------|-------------|---------|-------------|
| Norton 360 | $49.99/yr | Sells usage data | Third party | Gen Digital |
| McAfee Total | $39.99/yr | Data sharing concerns | Third party | McAfee |
| Kaspersky | BANNED | Russian government ties | Third party | Russia |
| Avast | $34.99/yr | Fined $16.5M for data sales | Third party | Gen Digital |
| Defender + GatewayGuard | $19.99 ONCE | Zero data collection | Microsoft | Microsoft |

### Website Page Idea: gatewayguard.co/defender-vs-antivirus
Full page explaining:
- Why Defender is as good as paid AV when configured correctly
- The AV industry's financial incentive to make you think you need them
- Independent test results showing Defender performance
- Exact settings GatewayGuard configures and why they matter
- The math: $19.99 once vs $30-50/year forever
This page alone could drive significant organic search traffic on terms like
"do I need antivirus Windows 11" and "is Windows Defender good enough"


---

## MOBILE NOTEPAD RECOMMENDATIONS (for users during GatewayGuard sessions)

### Purpose
Users need a simple notepad on their phone to jot down notes, manual steps,
and settings while running GatewayGuard on their PC. Recommendation goes on
gatewayguard.co and in the tool's manual steps screen.

### Recommendations by Phone Type

**Samsung Android:**
- Samsung Notes -- already installed, free, no account needed
- Verdict: Samsung Notes is GOOD ENOUGH for this use case
- No reason to install anything else unless user wants cross-device sync

**Any Android:**
- Google Keep -- already on most Android phones, free, syncs via Google account
- Best for users who want notes on both phone AND PC browser
- Requires Google account (most Android users already have one)

**iPhone:**
- Apple Notes -- already installed, free, syncs via iCloud
- No recommendation needed -- just use what's there

**Privacy-conscious users (any phone):**
- Notally -- free, no account, no cloud, offline only, open source
- Fits GatewayGuard privacy philosophy perfectly
- Download from Google Play Store

**Cross-platform (Android + iPhone household):**
- Simplenote -- free, works on Android, iPhone, Windows, Mac, Linux, browser
- Requires free account for sync

### Samsung Notes vs Free Alternatives -- Honest Comparison

| Feature | Samsung Notes | Google Keep | Notally |
|---------|--------------|-------------|---------|
| Cost | Free | Free | Free |
| Account needed | Samsung account (optional) | Google account | None |
| Cloud sync | Samsung Cloud | Google Drive | No |
| Cross-device | Samsung only | Any device | No |
| Privacy | Samsung collects usage data | Google collects data | Zero data collection |
| Offline | Yes | Yes | Yes |
| Simplicity | Very simple | Very simple | Very simple |
| Pre-installed | Samsung phones | Most Android | No |

### Verdict: Is any free version better than Samsung Notes?
For GatewayGuard users specifically -- NO, Samsung Notes is fine.
They just need to jot down a few manual steps while at their PC.
Samsung Notes handles that perfectly with zero setup.

HOWEVER -- if user wants notes accessible on their PC too:
- Google Keep wins -- open keep.google.com in any browser on PC
- User can see phone notes on PC and vice versa automatically
- This is genuinely more useful for GatewayGuard sessions where
  they might want to copy a registry path or setting name

### Website Recommendation (keep it simple)
"To take notes during your GatewayGuard session:
- Samsung phone: Use Samsung Notes (already installed)
- Other Android: Use Google Keep (already installed on most phones)
- iPhone: Use Apple Notes (already installed)
- Want privacy? Install Notally from the Play Store -- free, no account needed"


---

## WINDOWS 11 26H2 IMPACT ANALYSIS (June 27, 2026)

### What is 26H2
- Windows 11 26H2 arriving October 2026 (possibly late September)
- Delivered as a small enablement package (eKB under 500KB) -- not a full reinstall
- All existing 24H2 and 25H2 devices will receive it automatically
- No new hardware requirements -- same specs as current Windows 11
- First genuinely meaningful update since 24H2 in October 2024
- 25H2 (what SANDY runs) had zero new features -- 26H2 is different
- Some 26H2 features already rolling out via June 2026 cumulative update

### Key New Features in 26H2

1. COPILOT AI INTEGRATIONS
   - Replaces classic search box with Copilot-powered natural language prompt
   - 15 Windows AI features: Recall, Paint AI, Notepad AI, Click to Do,
     Settings Agent, etc.
   - Privacy-conscious users will want these OFF
   - NoID Privacy already disables these -- GatewayGuard needs to also
   - ACTION: Add "Disable Windows AI Features" as new setting in ascii22

2. BING REMOVAL FROM START MENU (most requested feature ever)
   - Microsoft finally allowing web search results to be disabled in Search
   - Setting location: Privacy & Security -> Search -> turn off web results
   - Currently can't be automated by GatewayGuard (registry key TBD)
   - ACTION: Research registry key and add as new setting in ascii22/23
   - MARKETING: "GatewayGuard removes Bing from your Start menu search"

3. POINT-IN-TIME RESTORE (new feature)
   - Automated restore points -- more granular than existing System Restore
   - GOOD NEWS for GatewayGuard users -- OS-level safety net
   - ACTION: Add mention in tool messaging:
     "Windows 11 26H2 includes Point-in-Time Restore -- if anything
     goes wrong after running GatewayGuard, you can restore to before
     this session. See Settings -> System -> Recovery."
   - Also good for marketing: "Every change GatewayGuard makes is
     reversible -- and Windows 26H2 adds an extra safety net on top."

4. MOVABLE TASKBAR (via cumulative update, not waiting for 26H2)
   - UI change only -- no security impact on GatewayGuard

5. LOW LATENCY PROFILE (already live in June 2026 cumulative update)
   - Faster app/Start menu launch -- already on SANDY and IdeaPad
   - No security impact -- no action needed

6. REVAMPED FILE EXPLORER
   - UI change only -- no security impact

### BitLocker Warning -- URGENT
Devices with unrecommended BitLocker Group Policy configuration may be
required to enter their BitLocker recovery key after 26H2 update.
ACTION: Review GatewayGuard's BitLocker setting (ID=8) to ensure it
does NOT create a non-standard Group Policy configuration that could
trigger this issue. Test on Dell Latitude 5430 (Pro edition) when it arrives.

### 26H2 Testing Plan
- October 2026: 26H2 rolls out to all 24H2/25H2 devices
- SANDY (25H2) and IdeaPad (25H2) will both receive it automatically
- Dell Latitude 5430 (arriving now) -- test GatewayGuard on 26H2 when updated
- Test all 19 settings still work correctly after 26H2
- Check if any registry paths changed
- Check if new AI settings need to be added to apps audit

### New Settings for ASCII22/23 (from 26H2 research)
These join the existing planned ascii22 settings (WDigest, AutoRun, Script Host):

HIGH PRIORITY -- add in ascii22:
- Disable Windows AI Features (Recall, Copilot, Paint AI, Notepad AI etc)
  Registry: HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot
  DisableWindowsCopilot = 1 (and related keys for each AI feature)
  NoID Privacy already implements this -- research exact registry keys

- Disable Bing from Start menu search
  Registry: HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search
  BingSearchEnabled = 0
  CortanaConsent = 0
  Also: AllowSearchHighlights = 0 in policy

MEDIUM PRIORITY -- add in ascii23:
- Quick Machine Recovery awareness (new Pro feature -- auto-enables on non-domain Pro PCs)
- Point-in-Time Restore -- mention as safety net in tool messaging

### Marketing Opportunity
26H2 drops October 2026 -- perfect timing for GatewayGuard launch:

"Updated for Windows 11 26H2"
- Removes Bing from Start menu search
- Disables Windows AI features (Recall, Copilot etc) for privacy
- Fully compatible with Point-in-Time Restore safety net
- Tested on 26H2 before release

This positions GatewayGuard as current and maintained -- a key trust signal
that distinguishes it from tools that go stale after initial release.
NoID Privacy will need to chase the same thing -- but GatewayGuard can
market "26H2 ready" as a feature if we test and update before October.

### Timeline Impact on GatewayGuard
- Now: Build and test ascii21/22 on 24H2/25H2
- September 2026: Begin testing on 26H2 Insider builds
- October 2026: 26H2 releases -- GatewayGuard should be 26H2-ready
- October 2026: Ideal launch window -- "Updated for Windows 11 26H2"


---

## GATEWAYGUARD GLOBAL STANDARDS (June 27, 2026)

### Date Format Standard
GatewayGuard defers to the MAJORITY of the world, not US convention,
for all date displays. The US MM/DD/YYYY format is used by essentially
one country. 7+ billion people use DD/MM/YYYY or YYYY-MM-DD.

| Context | Format | Example | Reason |
|---------|--------|---------|--------|
| Tool displays | DD-MMM-YYYY | 27-Jun-2026 | Unambiguous in every country |
| Filenames | YYYY-MM-DD | 2026-06-27 | ISO 8601, sorts correctly |
| Website (global) | DD Month YYYY | 27 June 2026 | Majority world convention |
| Website (US context) | Month DD, YYYY | June 27, 2026 | Full month name, no ambiguity |
| FAQ examples | DD-MMM-YYYY | 27-Jun-2026 | Matches tool output |
| US legal/tax docs | MM/DD/YYYY | 06/27/2026 | US legal standard only |

PowerShell implementation in tool:
  Get-Date -Format "dd-MMM-yyyy HH:mm"  -> 27-Jun-2026 14:32
  Get-Date -Format "yyyy-MM-dd"          -> 2026-06-27 (for filenames)

### GDPR and Privacy Compliance -- MARKETING POINT
GatewayGuard collects ZERO data by design. This means:
- GDPR (Europe) -- fully compliant, nothing to report or protect
- CCPA (California) -- fully compliant
- Maine MPPA (our home state, one of the strongest US privacy laws) -- compliant
- Virtually every other privacy law worldwide -- compliant

This is not a policy choice -- it is an architectural choice.
GatewayGuard cannot violate privacy laws because there is nothing to violate.

OFFICIAL MARKETING LINE:
"Zero data collected. Zero accounts required.
Compliant with GDPR, CCPA, and global privacy laws
-- by design, not by policy."

WHY "BY DESIGN, NOT BY POLICY" IS POWERFUL:
- "By policy" means a company CHOSE not to collect data (but could)
- "By design" means the tool is ARCHITECTURALLY INCAPABLE of collecting data
- Users in Germany, France, and other privacy-conscious markets will
  immediately understand and trust this distinction
- No other hardening tool in our competitive set makes this claim as cleanly

### Where to Use These Points
- Homepage hero section
- gatewayguard.co/privacy page
- FAQ Category 4 and Category 9
- All marketing materials
- Beta tester program description
- Press kit (when built)
- App store descriptions (when applicable)
- German/European marketing especially -- lead with this


---

## REVENUE MODEL -- UPDATES AND RECURRING REVENUE (June 27, 2026)

### The Problem with One-Time Sales Only
One-time purchasers pay once and disappear. No ongoing relationship,
no recurring revenue, no way to monetize Windows updates, new threats,
or new features. Building a customer database without a way to monetize
it long-term is a missed opportunity.

### Solution: Annual Update Subscription (price TBD)
Every one-time purchaser becomes a potential annual subscriber.
The update subscription provides:
- Updated tool for each major Windows 11 release (26H2, 27H1 etc)
- New security settings as Windows evolves
- Updated apps audit trusted/flag/remove lists
- Updated threat intelligence (new PUP publishers etc)
- Priority support access
- Early access to new features

### Why This Works for GatewayGuard Specifically
Windows 11 changes EVERY YEAR:
- Major feature updates (H1 and H2 releases annually)
- New security settings appear (Recall, Copilot AI features in 26H2)
- Registry paths sometimes change between versions
- New threats emerge requiring updated detection
- Tested hardware list grows requiring tool updates

A customer who bought GatewayGuard in 2026 will NEED an update in 2027
when 27H1 ships. That natural need is the recurring revenue hook.

### Pricing Strategy (TBD -- research needed)
Suggested starting point:
| Product | Price | Type |
|---------|-------|------|
| Single PC license | $19.99 | One-time |
| 3-PC pack | $34.99 | One-time |
| 5-PC pack | $49.99 | One-time |
| 10-PC pack | $79.99 | One-time |
| Annual update subscription | $TBD/yr | Recurring |
| Assisted session | $39-49 | One-time |

Annual subscription pricing considerations:
- Must be low enough that one-time buyers convert easily
- Suggested range: $9.99 - $14.99/year per PC
- Family/multi-PC discount: $19.99/year for up to 5 PCs
- Compare: Norton costs $49.99/yr -- GatewayGuard updates at $9.99/yr
  is dramatically cheaper AND doesn't conflict with Defender

### How to Convert One-Time Buyers to Subscribers
1. EMAIL LIST -- every purchaser goes into email database
2. When new Windows version releases:
   - Email: "Windows 11 26H2 is here -- your GatewayGuard update is ready"
   - Show what changed and why they need the update
   - Offer update subscription OR one-time update purchase
3. Annual reminder email:
   - "It's been a year -- here's what changed in Windows security"
   - "Your GatewayGuard is 12 months old -- update recommended"
4. Threat alerts:
   - "New ransomware targeting this Windows setting -- update protects you"
   - Creates urgency without being alarmist

### What This Requires (build list)
- [ ] Email collection at purchase (required for this model to work)
- [ ] Email marketing system (Mailchimp free tier to start)
- [ ] Customer database (even simple spreadsheet to start)
- [ ] Update notification system (email when new version ships)
- [ ] Payment system that handles subscriptions (Stripe)
- [ ] License system that knows subscription status
- [ ] Decide: does expired subscription = tool stops working or
      just stops getting updates? RECOMMENDATION: Tool keeps working,
      updates require active subscription. Never punish past buyers.

### Revenue Projection (rough)
Assume 1,000 customers in year 1 (conservative):
- 1,000 x $19.99 avg one-time = $19,990 year 1 revenue
- 30% convert to annual updates at $9.99 = 300 x $9.99 = $2,997/yr recurring
- Year 2: add 1,000 new + 300 returning = growing recurring base
- Year 3: recurring revenue starts to match or exceed new sales

### Marketing Angle for Annual Updates
"Windows changes every year. So do the threats.
GatewayGuard updates keep your security current automatically.
$9.99/year -- less than one month of any antivirus subscription."

### Important Policy Decision
NEVER make the existing tool stop working when subscription expires.
Users who don't renew keep their last version working indefinitely.
Only NEW features and NEW Windows version support require subscription.
This is the ethical approach AND better marketing:
"We never hold your security hostage. Updates are optional, not required."

### Research Needed
- [ ] What do competitors charge for updates (NoID Privacy Pro model)
- [ ] What is acceptable annual price for home users
- [ ] Stripe subscription billing setup complexity
- [ ] Email marketing best practices for software update announcements
- [ ] Legal requirements for email marketing (CAN-SPAM, GDPR opt-in)


---

## BETA TESTER POLICY -- COMPLETE (June 27, 2026)

### Tiered Reward Structure

| Beta Tester Type | Reward |
|-----------------|--------|
| First 10-20 testers (early adopters, most risk) | Free license + free updates for life |
| General beta testers (tested on listed hardware) | Free license for their PC + 50% off annual updates forever |
| Hardware submitters (specs only, no session) | Free license for their PC only |

### Founding Member Tier (first 10-20 testers)
- Free license on their PC -- forever
- Free annual updates -- forever
- "Founding Member" designation on profile/account
- Listed by first name on gatewayguard.co/founding-members (with permission)
- This is MARKETING as much as reward -- "I was one of the first 20
  people to test GatewayGuard" is word of mouth that money can't buy

### PC Migration Policy for Beta Testers

SCENARIO 1: Moves to PC already on tested/approved list
- Listed PCs are always free -- no issue
- License transfers automatically
- No session needed

SCENARIO 2: Moves to PC NOT yet on tested list
- This is actually a GIFT to GatewayGuard
- Run a new beta session on their new hardware
- New PC gets added to tested list
- Their reward: free license on new PC
- GatewayGuard reward: new hardware profile added to compatibility list
- Their loyalty automatically expands our testing coverage

SCENARIO 3: Moves to unlisted PC and won't do a session
- Standard pricing applies -- BUT discounted for beta history
- Suggested discount: 50% off standard price
- Honors their contribution without fully waiving revenue

SCENARIO 4: License fingerprint mismatch (new PC, didn't tell us)
- Tool won't run -- hardware fingerprint changed
- User contacts support@gatewayguard.co
- We verify beta tester status in our database
- Reissue license for new PC per above scenarios

### Free Transfer Policy (abuse prevention)
- All beta testers get ONE free license transfer per year
- Covers moving to any PC (listed or unlisted)
- After one transfer per year: standard pricing or session required
- Prevents abuse (claiming new PC every month)
- Founding Members: unlimited transfers (they earned it)

### The Beautiful Business Dynamic
Beta testers moving to new unlisted hardware = AUTOMATIC beta recruitment
- They need GatewayGuard on their new PC
- New PC isn't listed -- they contact us for a session
- Session adds new hardware to tested list
- Their loyalty to the product grows the compatibility database
- We never have to chase beta testers -- they come to us when they upgrade

### What This Requires
- [ ] Beta tester database tracking:
      Name, email, PC model tested, session date, tier assigned,
      transfers used this year, founding member Y/N
- [ ] Simple spreadsheet to start (Google Sheets or Excel)
- [ ] License system that flags beta tester status
- [ ] Support email monitoring (support@gatewayguard.co)
- [ ] Annual reset of transfer count (Jan 1 each year)

### Policy Summary (for website gatewayguard.co/beta-policy)
"Beta testers receive a free GatewayGuard license for their PC as a thank
you for helping us test compatibility. Our first 20 testers receive free
lifetime updates as Founding Members.

If you get a new PC:
- Already on our tested list? Run it free -- listed PCs are always free.
- Not on our list? Contact us for a free session -- we'll test it together
  and add it to our list.
- One free license transfer per year for all beta testers.

We never forget the people who helped build GatewayGuard."


---

## WHY WINDOWS SHIPS WITH SECURITY FEATURES OFF -- RESEARCH (June 27, 2026)

### The Facts (presented neutrally -- let users draw their own conclusions)

FACT 1: Windows 11 ships many security features turned OFF by default.
- Tamper Protection: sometimes off
- Memory Integrity (Core Isolation): off on many PCs
- Enhanced Phishing Protection: off by default
- Periodic Scanning: off when 3rd party AV present
- BitLocker/Device Encryption: off on most Home edition PCs
- Advertising ID: on by default
- Diagnostic data: set to Full by default
- Windows Recall/AI features: collecting data by default on Copilot+ PCs

FACT 2: Microsoft designs default settings primarily for enterprise environments.
Source: Microsoft own documentation states "features that might be disruptive
to organizations will be turned off for all Windows managed devices by default."
Home users inherit enterprise-cautious defaults that don't match their needs.

FACT 3: Controlled Feature Rollout (CFR) means "up to date" doesn't mean
"fully configured." Features can sit dormant on a fully updated PC waiting
for a server-side signal that may never come for some users.

FACT 4: In April 2026 Microsoft published then removed a blog post titled
"Best antivirus software for 2026: The built-in Windows protection you need"
which stated Defender was sufficient for most home users.
Source: Neowin, May 2026. Removal noted by AV-Comparatives.

FACT 5: Microsoft claims Windows 11 features led to a 58% drop in security
incidents -- but this refers to enterprise-managed devices, not home users
on default settings.

FACT 6: 2025 was described by Windows community as a difficult year --
features shipped via mandatory security updates, some couldn't be disabled,
and the Windows roadmap site was described as "too confusing to be useful."

### Why This Matters for GatewayGuard (internal context only)
Microsoft faces structural tensions between:
- Enterprise customers who need stable, controllable defaults
- Home users who need aggressive security defaults
- Ecosystem partners (antivirus vendors) who are a revenue relationship
- AI features that require data collection to function

GatewayGuard doesn't need to explain or judge any of this.
The opportunity exists regardless of why the gap exists.

### HOW TO PRESENT THIS TO USERS -- NEUTRAL FRAMING POLICY

NEVER SAY:
- Microsoft deliberately ships insecure settings
- Microsoft protects antivirus company revenue
- Microsoft doesn't care about home users
- Any specific criticism of Microsoft, Google, Amazon or any named company
- Anything that could be read as an attack on a partner or competitor

ALWAYS SAY (let users draw their own conclusions):
- "Windows 11 ships with powerful security features -- some turned off by default"
- "GatewayGuard turns them on"
- "Your PC came with the tools -- GatewayGuard makes sure they're working"
- "Windows security features are strong when properly configured"
- "Some home PCs ship with security settings that haven't been fully optimized"

THE GOLDEN RULE FOR MARKETING COPY:
Present facts. Never assign blame. Let the reader connect the dots.
A user who reads "most Windows security features ship turned off"
will draw their own conclusion about why -- without you saying a word.

### MARKETING MORATORIUM POLICY
Do not criticize ANY company -- large or small -- until GatewayGuard is:
- Established with a paying user base
- Written about independently by tech press
- Has legal counsel in place
- Has sufficient revenue to defend against any response

At that point reassess. Until then: facts only, neutral framing, no names.

### SAFE MARKETING STATEMENTS (factual, neutral, defensible)
1. "Windows 11 includes Microsoft Defender -- one of the most capable
   antivirus engines available. GatewayGuard makes sure it's fully active."

2. "Some Windows 11 PCs ship with security features that aren't fully turned on.
   GatewayGuard checks all of them and fixes what needs fixing."

3. "You already paid for the security. GatewayGuard makes sure you're
   getting it."

4. "Windows 11 security features are powerful when properly configured.
   Most home PCs aren't. GatewayGuard changes that."

5. "Stop paying for antivirus software. You already have Defender.
   GatewayGuard makes sure it's set up correctly."


---

## RESEARCH TODO: NoID 630+ AUTO-CHANGES DEEP DIVE (June 27, 2026)

### Why This Matters for GatewayGuard
NoID Privacy Pro applies 630+ settings automatically. Before GatewayGuard
competes with or references this approach, we need to understand:
1. What problems does mass auto-configuration actually cause?
2. Are all 630 changes genuinely necessary for home users?
3. What breaks when you apply 630 settings at once?
4. How does NoID handle reversibility at that scale?
5. Is more settings = more security, or more risk?

### Research Questions

NECESSITY:
- How many of the 630 settings are genuinely critical for home users?
- How many are enterprise/compliance settings irrelevant to home use?
- What is the overlap with GatewayGuard's 19 settings?
- Are there settings in NoID's 630 that GatewayGuard should add?
- Are there settings in NoID's 630 that would be HARMFUL for home users?

PROBLEMS CAUSED:
- What apps break after applying NoID's full profile?
- What Windows features stop working?
- Are there reports of users having to reinstall Windows after NoID?
- What is the most common complaint from NoID users?
- How does NoID handle rollback of 630 settings -- is it reliable?
- What happens when Windows updates after NoID has been applied?
  Do settings persist, revert, or conflict?

PROCESS ISSUES:
- Does NoID explain what each of 630 settings does?
- Can users selectively apply or skip individual settings?
- What is the time required to apply 630 settings?
- Does NoID require restart(s) and how many?
- What is the failure mode if NoID crashes mid-apply?

COMPETITIVE INTELLIGENCE:
- Check NoID GitHub issues for user complaints
- Check Reddit r/privacy and r/Windows11 for NoID discussions
- Check NoID's own documentation for known incompatibilities
- Check if NoID has a "lite" mode with fewer settings

### GatewayGuard Positioning from This Research
If research shows NoID 630 settings cause problems:
- SAFE FRAMING: "GatewayGuard focuses on the settings that matter most
  for home users -- the ones that make a real difference without
  changing things that don't need changing."
- NEVER SAY: "NoID breaks things" or any direct criticism

If research shows NoID 630 settings work well:
- Acknowledge they serve a different (more technical) audience
- Position GatewayGuard as the guided, explained, accessible alternative
- Consider whether any NoID settings should be added to GatewayGuard

### Where to Research
- github.com/NexusOne23/noid-privacy (issues tab)
- reddit.com/r/privacy -- search "NoID"
- reddit.com/r/Windows11 -- search "NoID Privacy"
- NoID documentation: FEATURES.md and SECURITY-ANALYSIS.md
- AV-Comparatives and AV-TEST for any NoID testing data


---

## MARKET OPPORTUNITY -- STATISTICAL DEEP DIVE (June 27, 2026)
### "Nobody Owns This Space" -- The Evidence

---

### THE ADDRESSABLE MARKET

**Windows 11 Users:**
- 1 billion Windows 11 users worldwide (Microsoft earnings call, Jan 28, 2026)
- 1.4 billion+ monthly active Windows devices total (June 2025)
- Windows 11 jumped from 50% to 72% of all Windows users in ONE MONTH
  (Jan-Feb 2026) driven by Windows 10 end-of-life in Oct 2025
- Windows holds 67.7% of worldwide desktop OS market (StatCounter Jan 2026)
- US alone: 60.8% desktop OS share = ~230 million Windows users

**The Cybersecurity Market:**
- Global consumer security market: $47.75 billion in 2026
  growing to $75.25 billion by 2031 (9.52% CAGR)
- Global cybersecurity market: $302 billion in 2026
  growing to $663 billion by 2033 (11.9% CAGR)
- Cybercrime costs the world $10.5 TRILLION in 2025
- Average consumer loss per cybercrime victim: $19,372
- Seniors alone lost $4.8 billion to cybercrime in 2024
- FBI reported consumer cybercrime losses of $16.6 billion in 2024
  -- a 33% increase year over year

**The Threat Reality:**
- Cyberattacks: 1,968 per week average -- up 18% year over year
- 88% of all cyber incidents caused by human error
- Password attacks: 4,000 per SECOND (up 3,378% since 2015)
- Antivirus/internet security = 41.95% of consumer security spending
  -- the single largest category
- Yet most of this spending goes to products that duplicate
  what Windows already includes for free

---

### THE MARKET GAP -- WHY NOBODY OWNS THIS SPACE

**Who currently serves Windows 11 home users for security hardening?**

CATEGORY 1: Enterprise tools (Defender for Endpoint, CrowdStrike)
- Require IT departments, subscriptions, centralized management
- Cannot be used by home users -- wrong product entirely
- Market: Fortune 500 companies, not home users

CATEGORY 2: Compliance tools (CIS-CAT Pro, OpenSCAP)
- Built for HIPAA, PCI DSS, NIST compliance audits
- Require security professional to operate
- Produce reports, not guided changes
- Market: regulated industries, not home users

CATEGORY 3: Privacy/debloat tools (O&O ShutUp10++, Win11Debloat)
- Focus on telemetry and UI tweaks, not security
- No AV configuration, no BitLocker, no firewall checking
- No explanations of why settings matter
- Market: power users who already know what they want

CATEGORY 4: NoID Privacy Pro ($43/device)
- 630+ settings applied automatically
- No guided explanations
- Still requires technical comfort
- No human support
- Closest competitor but serves semi-technical users

**THE GAP:** No tool exists that is:
✗ Free or low-cost (under $20)
✗ Guided with plain English explanations
✗ Hardware-aware (detects your specific PC configuration)
✗ Interactive (user approves every change)
✗ Human-supported (real person helps if needed)
✗ Designed specifically for non-technical home users

This gap is confirmed by THREE independent sources:
1. Microsoft Copilot research (our own query)
2. Privacy Guides Community forum (users asking "are there any guides for 25H2?")
3. Windows Forum (Feb 2026): "strong is not the same as optimal -- defaults
   leave gaps for privacy-minded users"

---

### WHY THE GAP EXISTS -- STRUCTURAL REASONS

**The enterprise-first design problem:**
According to Microsoft's own documentation: "features that might be
disruptive to organizations will be turned off for all Windows managed
devices until enabled by policy."
Result: Home users get enterprise-cautious defaults. Security features
that should be ON ship OFF. Nobody notices. Nobody fixes it.

**The default settings problem:**
A default Windows 11 endpoint in 2026 has these attack surfaces open:
(Source: CyberSecurity Elite, May 2026 -- enterprise hardening guide)
- BitLocker without PIN
- SmartScreen passable via mark-of-the-web bypass
- LSASS access from non-protected processes
- PowerShell without script-block logging
These affect HOME users too -- not just enterprises.

**The antivirus industry problem:**
Antivirus products = 41.95% of consumer security spending
Average consumer pays $30-50/year for AV subscriptions
Most don't know Defender -- already on their PC -- is comparable
when properly configured. Nobody in the AV industry will tell them.

**The "strong is not optimal" problem:**
As confirmed by Windows Forum (Feb 2026):
"Windows 11's security posture is stronger than most casual users
realize -- but strong is not the same as optimal. The defaults Microsoft
ships increasingly favor convenience, cloud recovery, and compatibility
over the tightest possible security posture."

---

### THE STATISTICAL CASE FOR GATEWAYGUARD

**Slide-ready statistics:**

1. "1 BILLION Windows 11 users worldwide -- and most have never
   optimized their security settings." (Microsoft, Jan 2026)

2. "$10.5 TRILLION -- the cost of cybercrime worldwide in 2025.
   Most of it targets home users on misconfigured Windows PCs."
   (Cybersecurity Ventures, 2025)

3. "88% of cyber incidents are caused by human error --
   including leaving security settings at their defaults."
   (Multiple sources, 2025-2026)

4. "$19,372 -- average loss per cybercrime victim in 2024.
   GatewayGuard costs $19.99." (FBI, 2024)

5. "4,000 password attacks per second -- up 3,378% since 2015.
   Tamper Protection stops most of them. It ships turned off."
   (Microsoft Security Blog, 2024)

6. "$47.75 BILLION -- the consumer security market in 2026.
   Most of it goes to products that duplicate what Windows
   already includes for free." (Mordor Intelligence, 2026)

7. "ZERO -- the number of guided, explained, human-supported
   Windows 11 security tools for home users that exist today."
   (Our own market research, confirmed by Copilot, June 2026)

---

### THE COMPETITIVE MOAT

Why won't a big company just build this?

1. MICROSOFT can't -- conflict of interest with enterprise customers
   and antivirus ecosystem partners. Their defaults serve enterprises first.

2. ANTIVIRUS COMPANIES won't -- they make money selling what
   GatewayGuard proves you don't need. Not in their interest.

3. ENTERPRISE TOOLS can't -- built for IT departments with thousands
   of devices. Can't be simplified for a single home user.

4. OPEN SOURCE tools won't -- no human support, no guided UX,
   no business model to fund ongoing development.

5. NOID PRIVACY won't -- serves a different (more technical) audience.
   630 auto-changes with no explanations is not a home user product.

The gap isn't an oversight. It's a structural market failure.
GatewayGuard fills it by design.


---

## TWO-FACTOR AUTHENTICATION (2FA) -- STRATEGY (June 27, 2026)

### Why 2FA Belongs in GatewayGuard

2FA is arguably the single highest-impact security action any home user
can take. Microsoft's own data shows password attacks at 4,000/second.
2FA stops virtually all of them regardless of whether the password is
compromised. It costs nothing and takes 5 minutes to set up.

Yet NO current Windows hardening tool recommends or guides users through
2FA setup. This is a genuine gap GatewayGuard can own.

### Where to Add 2FA in the Tool

**Setting #20 (new -- ascii23+): Microsoft Account 2FA**
- Check if Microsoft Account has 2FA enabled
- Cannot auto-enable (requires web browser + account access)
- Mark as MANUAL REQUIRED
- Show exact steps: account.microsoft.com -> Security -> Advanced security
- Explain: protects Windows login, OneDrive, Office, Xbox, everything Microsoft
- Priority: HIGH -- most impactful single change for home users

**Setting #21 (new -- ascii23+): Email Account 2FA Advisory**
- Cannot check email account 2FA from Windows (outside scope)
- Show as ADVISORY screen after main checklist
- Recommend enabling 2FA on:
  * Gmail: myaccount.google.com -> Security -> 2-Step Verification
  * Outlook/Hotmail: account.microsoft.com -> Security
  * Yahoo: account.yahoo.com -> Security
  * Apple ID: appleid.apple.com -> Sign-In and Security
- Explain: email is the master key -- if email is compromised,
  every password reset goes to the attacker

**Apps Audit Addition:**
- Flag if Microsoft Authenticator is NOT installed
- Recommend installing as the 2FA app of choice
- Alternative: Google Authenticator, Authy

### Where to Add 2FA on Website

**gatewayguard.co/guide/2fa** (new page)
Full guide covering:
1. What is 2FA and why it matters
2. Microsoft Account 2FA setup (screenshots)
3. Gmail 2FA setup (screenshots)
4. Which 2FA method to use:
   - Authenticator app (best) -- Microsoft Authenticator recommended
   - SMS text (acceptable but weaker)
   - Hardware key like YubiKey (best for high-risk users)
5. What to do if you lose your phone (recovery codes)
6. 2FA for other important accounts (banking, social media)

**gatewayguard.co/guide/index.html** -- add 2FA as featured section:
"Beyond GatewayGuard -- Essential steps we recommend but can't automate"
- Enable 2FA on your Microsoft Account
- Enable 2FA on your email
- Use a password manager

### 2FA as Marketing Point

**Headline angle:**
"GatewayGuard hardens your Windows settings. Then we tell you the
one thing that matters even more -- and it's free."

**Supporting copy:**
"Even a perfectly hardened PC can be compromised if your password
is stolen. Two-factor authentication stops that -- it means a stolen
password alone can never unlock your account. GatewayGuard walks you
through setting it up on your Microsoft Account and email. Takes
5 minutes. Costs nothing. Stops 99.9% of account attacks."
(Microsoft data: 2FA blocks 99.9% of automated account attacks)

**Why this is a differentiator:**
- No other Windows hardening tool mentions 2FA
- It's outside the scope of registry/settings changes
- But it's the MOST important security action after hardening
- GatewayGuard being the tool that connects these two things
  is a genuine value-add no competitor offers

### 2FA Recommendations for GatewayGuard Operations

**For William's accounts (internal):**
- [ ] Enable 2FA on william.wfbiii@gmail.com
- [ ] Enable 2FA on gatewayguard.co domain registrar (Namecheap)
- [ ] Enable 2FA on any payment processing account (Stripe etc)
- [ ] Enable 2FA on Maine LLC filing account
- [ ] Use Microsoft Authenticator or Google Authenticator
- [ ] Save recovery codes somewhere safe (NOT on the PC itself)

**For the GatewayGuard business:**
- [ ] support@gatewayguard.co -- 2FA required
- [ ] Website hosting account -- 2FA required
- [ ] Any customer database -- 2FA required
- [ ] GitHub (if source code hosted there) -- 2FA required

### What to Say in the Tool (Manual Steps screen)
Add to Show-ManualSteps function:

"STRONGLY RECOMMENDED -- OUTSIDE THIS TOOL:
Enable Two-Factor Authentication (2FA) on your Microsoft Account.
This is the single most impactful security action you can take.

HOW TO ENABLE:
1. Open a browser and go to: account.microsoft.com
2. Click Security -> Advanced security options
3. Click Turn on under Two-step verification
4. Install Microsoft Authenticator on your phone
5. Follow the setup wizard (takes about 5 minutes)

WHY THIS MATTERS:
2FA means a stolen password alone cannot access your account.
Even if someone knows your password, they still need your phone.
Microsoft reports 2FA blocks 99.9% of automated account attacks.

Full guide with screenshots: gatewayguard.co/guide/2fa"

### 2FA Statistics for Presentations/Marketing
- 2FA blocks 99.9% of automated account attacks (Microsoft, 2019 -- still valid)
- Password attacks: 4,000 per second as of 2024 (Microsoft Security Blog)
- 81% of hacking-related breaches use stolen or weak passwords (Verizon DBIR)
- Average cost of account compromise: $19,372 (FBI 2024)
- 2FA setup time: ~5 minutes
- 2FA cost: Free
- This is the easiest $19,372 you'll ever save


---

## MARKETING REFINEMENTS (June 28, 2026)

### Language Policy Updates

NEVER SAY:
- "Windows 11 ships with security features turned off"
- "Microsoft ships insecure settings"
- Any wording that could be read as disparaging Microsoft or Windows

ALWAYS SAY (positive framing):
- "Windows 11 is a brilliantly designed software package with
  powerful security features built right in"
- "After safely scanning your computer, we help you turn on
  the security features you need"
- "We help you get the most out of what Windows 11 already includes"

### Approved Marketing Lines (refined June 28, 2026)

"After safely having you scan your computer, we help you turn on
the security features you need."

"Windows 11 is a brilliantly designed software package.
GatewayGuard makes sure you're getting everything it offers."

"We don't change hundreds of things. We help you change the ones
that matter -- and we explain every single one."

"2FA blocks 99.9% of automated account attacks.
Takes 5 minutes. Costs nothing. No competitor teaches you this."

"The average cybercrime victim loses $19,372.
Setting up 2FA is free and takes 5 minutes.
Stops cybercrime cold."

### NoID Research Todo
- [ ] Search for NoID Privacy Pro community group or forum
- [ ] Check Reddit, GitHub discussions, Discord for NoID user community
- [ ] "NoID" is a clever name but tells users nothing about what it does
- [ ] GatewayGuard is descriptive -- "guards your gateway" -- better branding
- [ ] Research NoID user complaints, workarounds, known issues
- [ ] Check if NoID has a knowledge base or support community

### 88% Stat -- Deep Dive Research Needed
Current note says "88% of cyber incidents caused by human error"
William's refinement: "by not turning on needed and available security settings"
- [ ] Research: what percentage of breaches specifically involve
  misconfigured or disabled security settings vs phishing vs other errors
- [ ] Find stats that specifically support the "settings not turned on" angle
- [ ] Sources to check: Verizon DBIR 2025, IBM Cost of Data Breach 2025,
  Microsoft Digital Defense Report 2025

### 2FA Simple Language and Steps (for website and tool)

WHAT IS 2FA IN PLAIN ENGLISH:
"Two-factor authentication means that even if someone steals your
password, they still cannot get into your account. They would also
need your phone. It's like a deadbolt on top of a regular lock."

WHY IT MATTERS:
"Password attacks happen 4,000 times per second. Most passwords can
be guessed, bought on the dark web, or stolen in a data breach.
2FA makes a stolen password useless on its own."

HOW TO SET IT UP ON YOUR MICROSOFT ACCOUNT (5 minutes):
Step 1: On your phone, download Microsoft Authenticator (free)
        from the App Store or Google Play
Step 2: On your PC, open a browser and go to account.microsoft.com
Step 3: Click Security in the top menu
Step 4: Click Advanced security options
Step 5: Under Two-step verification, click Turn on
Step 6: Follow the wizard -- it will ask you to scan a QR code
        with the Authenticator app on your phone
Step 7: Save your recovery code somewhere safe
        (print it and keep it with important documents)
Done. Next time you sign in from a new device, you'll need
to approve it on your phone. Takes 2 extra seconds.

THE STAT IN PLAIN ENGLISH:
"The average person who falls victim to cybercrime loses $19,372.
Setting up 2FA costs nothing and takes 5 minutes.
That's the easiest money you'll ever protect."

### The 10 Things Every Person Needs to Do
(for gatewayguard.co -- working title:
"10 Simple Things That Keep Your Money and Data Safe")

These should be:
- Simple enough for anyone to do
- Free or nearly free
- Explainable in one sentence each
- Actionable today

DRAFT LIST (refine before publishing):
1. Turn on Two-Factor Authentication (2FA) on your email and
   Microsoft account -- stops 99.9% of account attacks
2. Use a password manager -- one strong password to remember,
   unique passwords everywhere else (Bitwarden is free)
3. Keep Windows Update turned on and current --
   patches close the holes attackers use
4. Run GatewayGuard -- turns on the security features
   Windows already has built in
5. Back up your important files -- 3-2-1 rule:
   3 copies, 2 different media, 1 offsite (OneDrive counts)
6. Enable BitLocker/Device Encryption --
   if your laptop is stolen, your files stay private
7. Don't click links in emails -- go directly to the website instead.
   When in doubt, don't click.
8. Use a different email for important accounts (banking, Microsoft)
   than the one you use for newsletters and shopping
9. Check haveibeenpwned.com -- find out if your email and passwords
   have been in a data breach. It's free.
10. Back up your phone -- photos, contacts, and apps.
    iCloud or Google Photos. Automatic. Free.

Page title options:
- "10 Things That Keep You Safe Online"
- "10 Simple Steps to Protect Your Money and Data"
- "The 10-Minute Security Checklist Every Windows User Needs"

### Windows 11 26H2 Launch Readiness -- CPM

TARGET: Be fully ready 1 MONTH BEFORE Windows 11 26H2 release
Estimated 26H2 release: October 2026
GatewayGuard readiness target: 1 September 2026

CPM (Critical Path Method) -- key milestones working backwards:

01-Sep-2026: GATEWAYGUARD 26H2-READY RELEASE
  - All 26H2 settings tested and working
  - Website updated with 26H2 compatibility note
  - Marketing materials updated
  - "Updated for Windows 11 26H2" badge ready

01-Aug-2026: FULL TESTING COMPLETE
  - ascii23+ tested on 26H2 Insider build
  - All 19+ settings verified on 26H2
  - New settings (Bing removal, AI features off) tested
  - BitLocker Group Policy conflict verified safe

15-Jul-2026: BEGIN 26H2 INSIDER TESTING
  - Enroll one test machine in Windows Insider Program (Beta channel)
  - Dell Latitude 5430 recommended for this (Win 11 Pro)
  - Run GatewayGuard on 26H2 Beta build
  - Document any registry path changes or new settings

01-Jul-2026: ASCII23 FEATURE COMPLETE
  - New settings added: Bing removal, AI features off, WDigest,
    AutoRun/AutoPlay, Windows Script Host
  - 2FA recommendation screen added
  - "10 Things" page on website published
  - All ascii22 issues resolved

15-Jun-2026 (TODAY): ASCII22 TESTING
  - Test ascii22 on IdeaPad ✓ (in progress)
  - Test ascii22 on SANDY after MB trial expires
  - Test ascii22 on Dell Latitude 5430 when it arrives

IMMEDIATE NEXT STEPS (this week):
  [ ] Test ascii22 on IdeaPad -- report results
  [ ] SANDY MB trial expires -- run after-trial checklist
  [ ] Dell Latitude 5430 arrives -- initial setup and test
  [ ] Maine LLC formation (maine.gov -- $175)
  [ ] Begin gatewayguard.co website build (Phase 1 pages)


---

## INVESTIGATION QUEUE (June 28, 2026)
Items to research and add to notes/tool/website as time permits.

---

### ITEM 1: BUNDLING CONCERNS -- CCleaner, IObit etc
WHAT IS BUNDLING?
Software bundling means an installer secretly includes additional
programs the user did not ask for. Classic example: installing
CCleaner and finding Avast Antivirus also installed without asking.

HOW TO EXPLAIN TO USERS IN TOOL:
"This app is legitimate but is known to include additional software
during installation that you may not have wanted. If you installed
it intentionally and only got what you expected -- keep it.
If you're not sure what else got installed with it -- we recommend
reviewing your installed apps list carefully."

USER CHOICES (Tier 2 advisory screen):
Y = Keep it -- I installed it intentionally and trust it
N = Remove it -- I don't recognize it or don't want it
S = Skip for now -- I'll decide later
B = Back -- let me look at this again

TO DO:
- [ ] Research exact bundling behavior of each Tier 2 app
- [ ] Write specific advisory text for CCleaner, IObit, Glary Utilities
- [ ] Add to Apps Audit Tier 2 advisory screen in ascii23

---

### ITEM 2: YAHOO SEARCH REMOVAL
Yahoo Search is frequently set as default browser search engine
without user consent -- often bundled with other software installs.

HOW TO DETECT:
- Check default search engine in Edge, Chrome, Firefox
- Registry: HKCU\Software\Microsoft\Internet Explorer\Main
  Look for Search Page = yahoo.com
- Check browser settings via PowerShell where possible

REMOVAL STEPS (manual -- add to guide):
EDGE: Settings -> Privacy, search and services -> Address bar and search
      -> Search engine used in address bar -> Change to Google/Bing
CHROME: Settings -> Search engine -> Change default
FIREFOX: about:preferences#search -> Change default search engine

TO DO:
- [ ] Research registry keys for Yahoo search detection
- [ ] Add Yahoo search detection to Apps Audit
- [ ] Add removal instructions to gatewayguard.co/guide/yahoo-search
- [ ] Consider adding as Setting #22 in ascii23+

---

### ITEM 3: GHOST SC2 ENTRIES -- DETECTION AND HANDLING
WHAT IS A GHOST SC2 ENTRY?
SecurityCenter2 (SC2) is the Windows registry that tracks installed
AV products. When AV software is uninstalled incorrectly, it can
leave a stale "ghost" entry in SC2 -- confusing Windows and
GatewayGuard into thinking an AV is still present.

FOUND ON: IdeaPad -- Fortect Security Suite left ghost SC2 entry
that self-cleaned on proper uninstall. Not always the case.

HOW TO DETECT GHOSTS:
Cross-reference SC2 entries against Win32_Product (installed apps):
- If in SC2 but NOT in Win32_Product = ghost entry
- If in Win32_Product but NOT in SC2 = normal (not an AV)

CAUTION: Win32_Product is SLOW (~60 seconds) -- use sparingly.
Alternative: cross-reference with Get-Package or registry uninstall keys.

HOW TO HANDLE IN TOOL:
- Detect ghost and flag clearly: "Found stale AV entry -- [Name]
  appears to be uninstalled but still registered with Windows Security"
- Offer to clean: Y = Remove ghost entry / N = Leave it / S = Skip
- Log the ghost detection and action taken

TO DO:
- [ ] Build ghost SC2 detection function for ascii23
- [ ] Research faster alternative to Win32_Product for cross-reference
- [ ] Add to Apps Audit -- ghost entries section
- [ ] Test ghost detection on IdeaPad (known ghost history)

---

### ITEM 4: WINDOWS KEY FEATURES GUIDE (future product)
CONCEPT: A downloadable guide explaining Windows 11 built-in features
that most users don't know about. Two versions:

PRODUCT A: "Windows 11 Hidden Features Guide" ($TBD)
- Summary list: each Windows key shortcut/feature, 1-line description
- Full writeup: what it does, how to use it, when it's useful
- Annual update after each Windows 11 release
- Email notification to previous buyers when updated version available

WINDOWS KEY ITEMS TO DOCUMENT (starter list):
Win + X = Quick Link menu (Device Manager, PowerShell, Settings etc)
Win + I = Settings
Win + E = File Explorer
Win + D = Show/hide desktop
Win + L = Lock screen
Win + V = Clipboard history (must enable first)
Win + Shift + S = Snipping tool / screenshot
Win + . = Emoji picker
Win + Tab = Task View / Virtual desktops
Win + A = Action Center / Quick Settings
Win + N = Notification Center
Win + K = Cast / Connect to display
Win + P = Project (extend/duplicate display)
Win + G = Xbox Game Bar
Win + H = Voice typing
Win + Z = Snap Layouts
Win + Left/Right/Up/Down = Window snapping

PRODUCT B: "Apps You Didn't Know You Had" ($TBD)
Built-in Windows 11 apps most users overlook:
- PowerToys (free from Microsoft Store -- adds many power features)
- Windows Sandbox (Pro only -- isolated test environment)
- Hyper-V (Pro only -- virtual machines)
- God Mode (hidden admin folder with 200+ settings)
- Reliability Monitor (tracks system crashes and errors)
- Resource Monitor (deep system performance view)
- Steps Recorder (records screen steps for support)
- Character Map (find any Unicode character)
- Math Input Panel

TO DO:
- [ ] Complete Windows key feature list
- [ ] Research pricing for downloadable guides ($4.99-$9.99 range?)
- [ ] Plan after 26H2 readiness target (post-Sep 2026)
- [ ] Annual update model same as GatewayGuard tool

---

### ITEM 5: LEGAL LIABILITY -- TIER 3 REMOVAL LIST
QUESTION: Are we liable if GatewayGuard recommends removing an app
that turns out to be something the user needed?

RESEARCH NEEDED:
- Software tool liability precedents
- Does our disclaimer cover recommendation-based removal?
- Does "user must approve" protect us from liability?

INTERIM POLICY (until legal review):
- GatewayGuard NEVER auto-removes anything
- User must explicitly choose Y to uninstall
- All removals show clear warning: "This cannot be undone easily.
  Make sure you don't need this app before proceeding."
- Log all removals with user confirmation timestamp
- Tier 3 list items show reason for flagging, not just a removal prompt

RECOMMENDED ACTION:
- [ ] Add liability disclaimer to GatewayGuard pre-run screen
- [ ] Add to Maine LLC operating agreement: software recommendation disclaimer
- [ ] Consult Maine business attorney before paid launch (1-hour consult ~$200)
- [ ] Research similar tools' disclaimer language (NoID, Hardentools)
- [ ] Add disclaimer to gatewayguard.co/terms

---

### ITEM 6: OPTIMIZATION GUIDES (future products)
CONCEPT: Separate downloadable guides for optimizing Windows 11

PRODUCT A: "Windows 11 Home Optimization Guide" ($TBD)
- Performance tweaks for Home edition
- Privacy settings beyond GatewayGuard
- Storage cleanup and management
- Startup optimization
- Memory management tips
- Annual update after each Windows 11 release

PRODUCT B: "Windows 11 Pro Optimization Guide" ($TBD)
- Everything in Home guide PLUS:
- Group Policy settings for power users
- Hyper-V setup and use
- BitLocker advanced configuration
- Windows Sandbox usage
- Remote Desktop secure setup
- Domain vs workgroup considerations

PRICING MODEL (suggested):
- Home Guide: $9.99 one-time + $4.99/year updates
- Pro Guide: $14.99 one-time + $6.99/year updates
- Bundle with GatewayGuard: discount TBD
- Email notification to all buyers when annual update available

TO DO:
- [ ] Outline content for both guides
- [ ] Plan after 26H2 readiness (post-Sep 2026)
- [ ] Research competitor pricing for similar guides

---

### ITEM 7: PRESS AND MEDIA OUTREACH STRATEGY
TARGET PUBLICATIONS AND INFLUENCERS:

TIER 1 (highest impact):
- The New York Times (technology section)
- Washington Post (technology section)
- Forbes (technology/cybersecurity)
- Time Magazine (technology features)
- Wall Street Journal (technology)

TIER 2 (tech press):
- PCMag (already covers Windows 11 hardening -- strong fit)
- Ars Technica (technical audience, credible reviews)
- The Verge (mainstream tech audience)
- ZDNet (enterprise + consumer security)
- TechRadar (consumer technology)
- BleepingComputer (security-focused, strong Windows coverage)
- Wired (technology culture)

TIER 3 (YouTube and podcasts):
- YouTube channels covering Windows 11 security/tips
  (search "Windows 11 security" -- identify top 10 channels)
- Security Now podcast (Steve Gibson -- very technical but influential)
- Darknet Diaries (security storytelling podcast)
- The CyberWire (daily security news)

HOW TO APPROACH (when ready):
1. Have a working, polished product first -- no press before ready
2. Build press kit: one-page overview, screenshots, demo video
3. Start with Tier 2 tech press -- easier to reach than Tier 1
4. BleepingComputer specifically covers Windows security tools -- ideal first target
5. Offer exclusive first review to one outlet
6. Let reviews snowball -- Tier 1 picks up stories from Tier 2
7. Never pay for coverage -- earned media only

TIMING: After 26H2-ready release (post Sep 2026) and after
at least 100 beta users with positive feedback documented.

TO DO:
- [ ] Build press kit after Sep 2026 release
- [ ] Identify specific journalists who cover Windows security at each outlet
- [ ] Create demo video showing GatewayGuard in action
- [ ] Draft press release template
- [ ] Research editorial calendars for tech publications

---

### ITEM 8: TRUSTED PUBLISHER LIST -- DUE DILIGENCE
POLICY: Before adding any publisher or product to GatewayGuard's
trusted list, research it thoroughly.

RESEARCH CHECKLIST FOR EACH TRUSTED PUBLISHER:
- [ ] Check AV-TEST and AV-Comparatives for any flags
- [ ] Search Reddit r/privacy and r/windows for user complaints
- [ ] Check if company has had any data breach or privacy violations
- [ ] Verify publisher name matches exactly what appears in Windows
- [ ] Check if product has been sold recently (new owners may change policies)
  Example: Avast bought AVG, then Gen Digital bought Avast -- behavior changed
- [ ] Check FTC and consumer protection databases for complaints

KNOWN ISSUES TO RESEARCH:
- Kaspersky: Banned by US government for Russian government ties
  DO NOT ADD to trusted list -- flag as HIGH RISK if found
- Avast: Fined $16.5M for selling user browsing data
  Add as Tier 2 advisory -- legitimate but data sharing history
- Norton/McAfee: Both owned by Gen Digital
  Research current data practices before trusted status

WINDOWS UPDATE ISSUE:
Research whether any specific MS updates or releases cause issues
on certain PC configurations. Known areas to investigate:
- KB updates that break Defender settings
- Updates that reset security configurations
- 26H2 BitLocker Group Policy conflict (already documented)
- Cumulative updates that change registry paths we depend on

TO DO:
- [ ] Complete due diligence on all current Tier 1 trusted publishers
- [ ] Add due diligence notes to each publisher entry
- [ ] Monitor security news for any new issues with trusted publishers
- [ ] Research Windows Update KB articles for known configuration issues

---

### ITEM 9: (SKIPPED -- number not in original list)

---

### ITEM 10: FREE TIPS LIST -- "THINGS YOU SHOULD KNOW"
CONCEPT: Free resource on gatewayguard.co covering common Windows
problems and their surprising/non-obvious causes.

STARTER LIST:

CONNECTIVITY ISSUES:
- "Can't reach website" -- could be VPN blocking it. Turn off VPN and retry.
- "Printer unavailable" -- could be VPN. VPN routes traffic differently,
  losing access to local network devices. Turn off VPN to print.
- "Slow internet after connecting VPN" -- normal. VPN routes all traffic
  through remote server. Expected behavior.

BROWSER SECURITY WARNINGS:
- "Your connection is not private" (https warning):
  * Site uses HTTP not HTTPS -- your data to/from the site is unencrypted
  * Anyone on the same WiFi could potentially see what you send
  * For banking, shopping, email -- NEVER proceed past this warning
  * For reading a news article -- lower risk but still not ideal
  * Rule of thumb: if you're entering any information -- leave the site
  * Look for the padlock icon in the address bar -- that means HTTPS

- "Certificate expired" warning:
  * Site's security certificate has lapsed -- different from HTTP/HTTPS
  * Could be harmless (site owner forgot to renew) or could be dangerous
  * When in doubt -- don't proceed

OTHER TIPS:
- "Windows won't update" -- check if drive is nearly full (need 20GB+ free)
- "PC running slow after update" -- give it 30 minutes. Windows indexes
  files after updates. Usually resolves on its own.
- "Defender scan slowing everything down" -- schedule scans for overnight
  Settings -> Windows Security -> Virus & threat protection ->
  Manage settings -> Scan schedule
- "Password manager won't autofill" -- check browser extension is enabled
- "Two screens showing wrong content" -- Win + P to change display mode

PAGE FORMAT FOR WEBSITE:
- gatewayguard.co/tips
- Simple numbered list, plain language
- Each tip: problem (bold) + cause + what to do
- Free -- no download required
- Updated periodically

---

### ITEM 11: PRESENTATION AND CPM UPDATES
TO DO:
- [ ] Review all 14 investigation queue items for presentation relevance
- [ ] Add press outreach strategy to CPM timeline (post Sep 2026)
- [ ] Add optimization guides to product roadmap slide
- [ ] Add ACB/BBO marketing angle to go-to-market slide
- [ ] Update CPM with survey/suggestion box launch timing
- [ ] Final CPM document due by next Friday

---

### ITEM 12: ACB AND BBO MARKETING OPPORTUNITY
ACB = American Contract Bridge League (200,000+ members)
BBO = Bridge Base Online (millions of users worldwide)

WHY THIS IS A PERFECT FIT:
- Bridge players skew older (50s-70s) -- exact demographic most
  vulnerable to cybercrime and least likely to know about security
- Bridge players are educated and financially comfortable
  -- willing to pay $19.99 for something that protects them
- ACB and BBO both have established communication channels
  (newsletters, email lists, online forums)
- William is an ACB member -- warm introduction possible

MARKETING PITCH TO ACB/BBO:
"GatewayGuard protects the Windows 11 PCs your members use to play
bridge online. Cybercriminals target exactly the demographic that
plays bridge -- and most members have never had their PC security
checked. GatewayGuard does it for them, in plain language,
in about 30 minutes."

APPROACH:
1. Contact ACB newsletter/communications team
2. Offer free GatewayGuard sessions for ACB board members first
   (builds trust and word of mouth within leadership)
3. Offer member discount: $14.99 (vs $19.99 standard)
   "ACB Member Price" -- creates exclusivity
4. BBO forum post: "Keep your bridge PC secure -- free check"
5. Consider sponsoring ACB newsletter ad after launch

SIMILAR ORGANIZATIONS TO TARGET:
- AARP (tens of millions of members -- perfect demographic)
- Senior centers and community organizations
- Online gaming communities (chess, bridge, backgammon)
- Retirement community newsletters and portals

TO DO:
- [ ] Draft ACB outreach letter after Sep 2026 launch
- [ ] Identify ACB communications director contact
- [ ] Research BBO forum posting guidelines
- [ ] Draft member discount pricing and terms

---

### ITEM 13: REFERRAL PROGRAM
CONCEPT: Every GatewayGuard customer gets a referral link.
When someone buys using their link, referrer gets reward.

OPTIONS:
A. Cash referral: $5 per referred sale
B. Free update year: each referral = 1 free year of updates
C. Account credit: build up credit toward future purchases
D. Discount code: referred buyer gets 10% off, referrer gets 10% credit

RECOMMENDED: Option B -- free update year
- No cash outlay from GatewayGuard
- Incentivizes both referrer AND buyer
- Builds loyalty and update subscription base
- Simple to implement: track referral code in license system

TO DO:
- [ ] Design referral tracking system (simple at first -- spreadsheet)
- [ ] Add referral code field to purchase flow
- [ ] Draft referral program terms
- [ ] Add to website after paid launch

---

### ITEM 14: SUGGESTION BOX AND QUARTERLY SURVEY
CONCEPT: Ongoing feedback mechanism for GatewayGuard users

SUGGESTION BOX (always open):
- gatewayguard.co/suggest
- Simple form: name (optional), email (optional), suggestion
- Incentive: if suggestion is implemented, suggester gets
  FREE one-year update subscription (value $TBD)
- Acknowledge every suggestion with email response

QUARTERLY SURVEY:
- Sent to all registered users (email list) every 3 months
- 5-10 questions max -- short enough to actually complete
- Topics: satisfaction, features wanted, security concerns,
  how they heard about GatewayGuard, would they recommend
- Incentive for completing: entry into drawing for free
  1-year update subscription or $TBD Amazon gift card
- Results used to prioritize next build features

SURVEY QUESTIONS (draft):
1. How satisfied are you with GatewayGuard? (1-5)
2. How easy was it to use? (1-5)
3. Did you feel you understood what each setting did? (Y/N)
4. Would you recommend GatewayGuard to a friend? (Y/N)
5. What one feature would you most like to see added?
6. How did you hear about GatewayGuard?
7. Are you using the annual update subscription? (Y/N)
8. Any other comments?

PLATFORM OPTIONS:
- Google Forms (free, easy to set up)
- Typeform (better UX, free tier available)
- SurveyMonkey (free tier limited)
- Build our own simple form on gatewayguard.co/survey

TO DO:
- [ ] Set up suggestion box form on website at launch
- [ ] Set up first quarterly survey for Q1 2027 (3 months after launch)
- [ ] Define incentive prizes and budget
- [ ] Draft survey questions (refine from above)
- [ ] Create email template for survey invitation


---

## MARKETING STRATEGY -- VALUE-FIRST / PRODUCT-LED GROWTH (June 28, 2026)

### Source
Research on marketing Windows 11 security tools -- "Freemium / Product-Led Growth"
approach for security-skeptical buyers.

### Core Insight
Security buyers hate FUD (Fear, Uncertainty, Doubt) and fluff.
They respond to technical credibility and demonstrated value.
Strategy: use the GUIDE to validate the problem,
use the TOOL to automate the solution.

---

### THE FUNNEL ARCHITECTURE

STAGE 1 -- THE HOOK (Free):
Release a highly detailed, actionable excerpt of the security guide
completely free. Give away genuine value.
GatewayGuard version: "The 5 Windows 11 Settings That Stop Ransomware"
- Free, no email required
- Genuinely useful on its own
- Links to full guide for more

STAGE 2 -- THE CONTENT LOCK (Lead Generation):
Offer the full formatted PDF guide in exchange for an email address.
This builds the email list that drives annual update subscriptions.
GatewayGuard version: Full security guide PDF
- Email required to download
- GDPR compliant opt-in (checkbox: "I agree to receive GatewayGuard updates")
- Instant delivery via automated email
- Email goes into annual update notification list

STAGE 3 -- THE PITCH (Monetization):
Inside the guide, AFTER explaining how tedious manual hardening is,
introduce the tool.
GatewayGuard version:
"You can do these 20+ steps manually over the next two hours,
or run GatewayGuard and have it checked and configured in 30 minutes --
with plain-language explanations of every setting along the way."
Then: link to download page.

NOTE ON OUR TARGET AUDIENCE:
The research assumes sysadmins and power users. GatewayGuard's
PRIMARY audience is non-technical home users -- adjust the funnel:
- Hook: even simpler ("5 free things that protect your PC right now")
- Guide: plain language, not technical registry talk
- Pitch: emphasize guided experience, not speed
SECONDARY audience (power users, small IT shops) = also valid --
create separate content track for them eventually.

---

### TOP MARKETING CHANNELS

CHANNEL 1 -- REDDIT AND FORUMS (highest priority, free):
Subreddits to engage:
- r/Windows11 (large, mainstream Windows users)
- r/privacy (privacy-conscious users -- our GDPR angle resonates)
- r/cybersecurity (technical audience -- credibility building)
- r/sysadmin (IT professionals -- secondary audience)
- r/techsupport (people with problems = people who need GatewayGuard)
- r/pcmasterrace (power users, Windows enthusiasts)
- r/seniors (our primary demographic -- underserved in security forums)

HOW TO DO IT RIGHT (not spammy):
- Write massive, genuinely helpful posts explaining a specific issue
  Example: "I spent 3 hours auditing my Windows 11 security settings.
  Here's everything I found and how to fix it manually."
- Provide complete value in the post itself
- Drop tool link ONLY at the end: "I also built a tool that does this
  automatically if you want a shortcut -- gatewayguard.co"
- Never post "check out my tool" without substance first
- Engage with comments -- answer questions thoroughly
- Build reputation in subreddits before promoting anything

CHANNEL 2 -- GITHUB (trust building, technical audience):
Consider publishing GatewayGuard source code on GitHub.
WHY THIS WORKS:
- Security buyers audit code before running it on their machines
- Open source = "nothing to hide" = trust
- GitHub README.md can link to premium guide and assisted sessions
- Stars and forks = social proof
- Issues tab = community feedback and beta tester pipeline

DECISION NEEDED: Open source vs closed source?
OPTION A: Fully open source on GitHub (free, trust-maximum)
OPTION B: Source-available (view but not redistribute) on GitHub
OPTION C: Closed source, but publish SHA-256 hash for verification
RECOMMENDATION: Option B or C -- allows code inspection without
enabling free redistribution. Discuss before paid launch.

CHANNEL 3 -- SEO / SEARCH CONTENT:
Target specific search queries people are already making:
High-value search terms:
- "how to harden Windows 11 home"
- "is Windows Defender good enough 2026"
- "how to disable Windows 11 telemetry"
- "Windows 11 security settings guide"
- "how to enable BitLocker Windows 11 home"
- "best free Windows 11 security tool"
- "Windows 11 ransomware protection settings"
- "how to turn on tamper protection Windows 11"

Each of these = one blog post / guide page on gatewayguard.co
Answer the question COMPLETELY and FIRST
Then: "GatewayGuard checks and configures this automatically"

---

### POSITIONING AGAINST BUYER FEARS

The research identified three universal security buyer fears.
Here's how GatewayGuard addresses each:

FEAR 1: "Will it brick my OS?"
OUR ANSWER: "Every change GatewayGuard makes is reversible.
Run it again at any time to undo any setting.
Windows 11 26H2 also includes Point-in-Time Restore as an
additional safety net. We've tested on [X] real PC configurations."
MARKETING COPY: "Reversible by design. Nothing is permanent."

FEAR 2: "Is it malware?"
OUR ANSWER: Multiple layers of trust:
1. Source code visible -- open the .ps1 in Notepad to see every line
2. SHA-256 hash published on website for verification
3. Code signing (future -- requires certificate, ~$200-400/year)
4. Zero data collected -- no network calls to verify
5. Maine LLC registered business -- real person, real address
MARKETING COPY: "Open source. Verifiable. Zero data collected."
TO DO:
- [ ] Publish SHA-256 hash on download page for each release
- [ ] Research code signing certificates (DigiCert, Sectigo)
- [ ] Consider GitHub publication for source verification

FEAR 3: "Is it a black box?"
OUR ANSWER: Transparency is our core differentiator.
- Every setting explained before it's changed
- Source code is plain text PowerShell -- fully readable
- Log file saved to Desktop after every run
- Nothing hidden, nothing automatic without approval
MARKETING COPY: "We explain every single change. No surprises."

---

### HOW THIS FITS GATEWAYGUARD'S EXISTING STRATEGY

ALREADY DOING (keep doing):
✅ Plain language explanations -- addresses "black box" fear
✅ User approves every change -- addresses "will it brick" fear
✅ Zero data collected -- addresses privacy/malware fear
✅ Reversible changes -- addresses "will it break something" fear
✅ Security guide (v9 written) -- the "content lock" asset is ready
✅ gatewayguard.co domain -- home for all content

NEED TO ADD:
[ ] SHA-256 hash on download page -- easy, do this at launch
[ ] Free excerpt of guide (hook content) -- "5 settings" post
[ ] Email capture for full guide download (lead gen)
[ ] Reddit presence -- start building reputation now
[ ] SEO content pages for high-value search terms
[ ] GitHub consideration -- decision needed

NEW MARKETING LINE FROM THIS RESEARCH:
"You can do this manually. Here are the exact steps.
Or let GatewayGuard walk you through it."
This respects the user's intelligence while demonstrating
the tool's value. Perfect for the security-skeptical audience.

---

### ACB/BRIDGE COMMUNITY APPLICATION
The bridge/senior demographic is DIFFERENT from sysadmins:
- Don't care about SHA-256 hashes or GitHub stars
- DO care about: "will it break my PC", "is it safe", "is it easy"
- Trust signals for this audience:
  * Testimonials from people like them
  * Plain language everything
  * Human support available
  * Money-back guarantee (consider adding)
  * Real person / real Maine business

For ACB/BBO marketing: skip the technical trust signals,
lead with human trust signals -- testimonials, the story,
the assisted session offer, the founding member program.

---

### IMMEDIATE ACTION ITEMS FROM THIS RESEARCH
Priority order:

1. [ ] Publish SHA-256 hash for each build on download page
       (Do this at first public release -- easy, high trust value)

2. [ ] Write "5 Windows 11 Settings That Stop Ransomware" free post
       (First hook content -- can go on Reddit AND website)

3. [ ] Set up email capture for full guide PDF download
       (Builds the list that becomes annual update customers)

4. [ ] Decide: open source / source-available / closed source
       (Affects GitHub strategy and trust positioning)

5. [ ] Begin building Reddit presence (r/Windows11, r/privacy)
       (Start now, before launch -- build reputation first)

6. [ ] Create SEO target list and assign one page per keyword
       (Website Phase 1 should include 3-5 of these pages)


---

## GRASSROOTS MARKETING CAMPAIGN -- DEEP DIVE (June 28, 2026)

### The Core Challenge
"A stranger telling someone to run an automated tool to secure their PC
looks identical to a phishing scam or a malware trap."
This is the #1 marketing problem GatewayGuard must solve before
anything else. Trust is not optional -- it is the product.

### The Strategic Shift
FROM: "Here is our product, buy it"
TO:   "Here is free education. We built a tool if you want a shortcut."

This is not just marketing positioning -- it changes the entire
go-to-market approach. The guide IS the marketing. The tool IS the payoff.

---

### PHASE 1: RADICAL TRANSPARENCY (do this FIRST, before any promotion)

WHAT TO DO:
- Publish GatewayGuard PowerShell source code publicly
  Options: GitHub, GitLab, or gatewayguard.co/source
- Document EVERY registry key and system setting the tool touches
  This becomes the settings reference page on the website
- Publish SHA-256 hash for every build on the download page
- Add to every page: "View the source code" link

WHY THIS WORKS:
- Tech influencers can read it, verify it's safe, and champion it
- Power users who audit the code become your most vocal advocates
- Eliminates "is it malware" objection completely
- A PowerShell .ps1 file is inherently more trustworthy than a .exe
  because it's plain text -- anyone can open it in Notepad

GATEWAYGUARD ADVANTAGE:
We're already a .ps1 PowerShell script -- not a compiled .exe
This is a massive trust advantage we should market explicitly:
"Open the .ps1 file in any text editor. Read every line.
See exactly what GatewayGuard does before running it."

DECISION: GitHub vs website hosting of source
OPTION A: GitHub public repository
  + Maximum trust (GitHub = developer credibility)
  + Built-in issue tracker for community feedback
  + Stars = social proof
  - Anyone can fork and redistribute (possibly without our branding)
OPTION B: Source-available on gatewayguard.co/source
  + We control the presentation
  + Can add context and explanations alongside code
  - Less credibility than GitHub for technical users
RECOMMENDATION: GitHub for technical audience trust
  + gatewayguard.co/source linking to GitHub

ACTION ITEMS:
[ ] Create GitHub account for GatewayGuard LLC
[ ] Publish ascii22+ source with full documentation
[ ] Write README.md explaining every setting touched
[ ] Add SHA-256 verification to download page
[ ] Add "View source code" link to every page

---

### PHASE 2: LEAD WITH THE GUIDE (the Trojan Horse)

KEY INSIGHT: A guide is zero-risk to a consumer. A tool is not.
Let the guide do the selling. The tool is the reward for trust.

HOW TO STRUCTURE THE GUIDE FOR MARKETING:
After EVERY manual step in the guide, add this callout:

"Doing this manually takes about 5 minutes.
GatewayGuard checks and configures this automatically --
with a plain-language explanation of what it found.
Download free at gatewayguard.co"

This creates 20+ natural product mentions throughout the guide
without ever feeling like a pitch. The user chooses manual control
first -- which builds credibility for the tool.

GUIDE DISTRIBUTION PLAN:
- Free PDF: no email required for basic version
  (removes all friction -- maximum distribution)
- Email for "full guide with screenshots" version
  (builds email list for annual updates)
- Web version: gatewayguard.co/guide (one page per setting)
  (SEO value + always current)

GUIDE EXCERPT AS HOOK CONTENT:
Free excerpt: "5 Windows 11 Settings That Stop Ransomware"
- Post to Reddit, local Facebook groups, Nextdoor
- No email required, no tool mentioned until the end
- Genuine value, genuinely free
- Demonstrates expertise before asking for anything

---

### PHASE 3: SEED POWER USER HUBS

TARGET PLATFORMS:

REDDIT (highest priority):
r/Windows11 -- mainstream Windows users, large audience
r/privacy -- privacy-conscious, our GDPR angle resonates perfectly
r/cybersecurity -- technical, credibility building
r/sysadmin -- IT professionals who help family members
r/techsupport -- people actively seeking help = our target user
r/pcmasterrace -- enthusiasts, will audit code and vouch for us
r/netsec -- security professionals (advanced, verify first)
r/seniors -- underserved, our primary demographic, almost no competition

THE PITCH (exact wording to use):
"I built a completely free, open-source guide and helper script
to help everyday Home and Pro users lock down Windows 11 without
enterprise software. I'd love for this community to audit the script,
tell me what you think, and use it to protect your families' PCs."

NOTE: This pitch invites audit BEFORE promotion. That's the key.
The community becomes quality assurance AND marketing simultaneously.

INDEPENDENT TECH FORUMS:
BleepingComputer -- security-focused, Windows coverage, trusted community
  Approach: post in Windows 11 security forum, not promotional section
  They cover security tools regularly -- could become a review target
ElevenForum -- dedicated Windows 11 community
  Very active, knowledgeable users, good for beta feedback
Wilders Security Forums -- privacy and security focused
  Older demographic, exactly our target user

APPROACH FOR ALL FORUMS:
1. Create account and participate genuinely for 2-4 weeks first
2. Answer questions, provide value, build reputation
3. THEN introduce GatewayGuard as "something I've been working on"
4. Invite critique -- "please audit the script and tell me what I missed"
5. Never lead with pricing -- lead with free version always

---

### PHASE 4: HYPER-LOCAL / GRASSROOTS (underrated opportunity)

THIS IS GATEWAYGUARD'S SECRET WEAPON:
Most security software companies ignore local community marketing.
GatewayGuard is built by a person in Brunswick, Maine -- that's an asset.

NEXTDOOR AND LOCAL FACEBOOK GROUPS:
Post based on REAL LOCAL EVENTS, not promotional messages.
Example posts:

"There's been a spike in phishing emails pretending to be Central Maine
Power. Here's a free quick guide I wrote on making sure your Windows 11
security features are actually turned on to catch these:
[link to free excerpt]"

"I'm a Brunswick resident who's been working on a free Windows 11
security guide. Happy to help anyone check their PC settings --
no charge. Just trying to help neighbors stay safe online."

"Local scam alert: [real local scam] is targeting our area.
Here are 3 free things you can do right now to protect yourself:"

WHY THIS WORKS:
- Local trust is the highest trust
- Neighbors helping neighbors = zero skepticism
- Real local events create urgency without fear-mongering
- The ACB/bridge community is hyper-local by nature

LIBRARY AND COMMUNITY PRESENTATIONS:
Offer free 45-minute presentations at:
- Curtis Memorial Library (Brunswick)
- Local senior centers
- Brunswick Community Education programs
- AARP chapter meetings
- ACB regional meetings

PRESENTATION TITLE OPTIONS:
"Taking Control of Your Digital Privacy"
"Is Your Windows 11 PC Actually Secure? Find Out Free"
"5 Free Things You Can Do Right Now to Stop Hackers"

WHAT TO BRING:
- Printed one-page handout with QR code to gatewayguard.co/guide
- Laptop to demo GatewayGuard live (biggest trust builder)
- Business cards (simple: GatewayGuard LLC, gatewayguard.co, William Burns)
- Sign-up sheet for free beta session (in-person offer)

LIVE DEMO IS EVERYTHING:
Showing GatewayGuard run on a real PC in front of an audience
-- showing what it finds, explaining each setting in plain language,
showing the user approve each change -- is more convincing than
any marketing copy ever written. One live demo = 20 word-of-mouth referrals.

---

### PHASE 5: AMPLIFICATION (after initial community trust established)

TECH BLOGGER OUTREACH:
Once Reddit/forum community has validated and vouched for GatewayGuard:
- Reach out to BleepingComputer editorial team
- Contact PCMag (already covers Windows 11 hardening)
- Reach out to How-To Geek (huge audience, our exact demographic)
- Contact WindowsLatest.com (Windows-specific news site)

The pitch to bloggers/press:
"GatewayGuard has been reviewed and validated by the communities at
r/Windows11 and BleepingComputer. Here's what they said. [quotes]
Would you like to review it for your readers?"

Community validation = press credibility. Press credibility = national reach.

YOUTUBE:
- Create simple screen recording showing GatewayGuard run start to finish
- No voiceover needed -- on-screen text explaining each step
- Title: "I ran a free Windows 11 security check on my home PC. Here's what I found."
- This type of video gets organic search traffic for years
- One genuine video = thousands of impressions over time

AFFILIATE PROGRAM:
Once paid launch is live:
- 30-40% commission for referrals
- Target: security bloggers, YouTube creators, tech newsletter writers
- Provide affiliate link and pre-written review language
- Payment via PayPal or Stripe (simple to set up)

---

### MARKETING CALENDAR (proposed)

NOW -- JULY 2026:
[ ] Create GitHub account and publish source
[ ] Write "5 Settings That Stop Ransomware" free post
[ ] Create Reddit accounts and begin genuine participation
[ ] Register on BleepingComputer and ElevenForum
[ ] Contact Curtis Memorial Library about presentation

AUGUST 2026:
[ ] Post free excerpt to Reddit communities
[ ] Submit GatewayGuard for community audit on r/Windows11
[ ] Offer free beta sessions via Nextdoor / local Facebook
[ ] Give library presentation if scheduled

SEPTEMBER 2026 (post launch):
[ ] Contact BleepingComputer for review
[ ] Contact PCMag / How-To Geek
[ ] Launch affiliate program
[ ] First ACB outreach email

OCTOBER 2026 (26H2 launch timing):
[ ] "Updated for Windows 11 26H2" announcement post to all channels
[ ] Press release to tech publications
[ ] Paid social ads (small budget, targeted to Windows 11 users)

---

### WHAT MAKES GATEWAYGUARD UNIQUELY SUITED FOR GRASSROOTS MARKETING

1. BUILT BY A REAL PERSON -- not a faceless company
   William F. Burns III, Brunswick Maine, GatewayGuard LLC
   People trust people more than corporations

2. POWERSHELL SCRIPT -- inherently auditable
   "Open it in Notepad and read every line" is a genuine offer

3. ZERO DATA COLLECTED -- most feared thing about security tools
   "We can't spy on you because we collect nothing" is provable

4. FREE TIER EXISTS -- lowest possible barrier to entry
   Listed hardware = free forever. No credit card ever needed.

5. HUMAN SUPPORT -- nobody else offers this
   "A real person will help you if you get stuck" = community trust

6. LOCAL ROOTS -- Brunswick Maine business
   Local credibility transfers to national credibility over time

7. THE STORY IS COMPELLING
   Retired/semi-retired individual builds tool that fills gap
   the entire security industry missed. That's a story people root for.


---

## LANGUAGE GUIDE -- TECHNICAL VS PLAIN ENGLISH (June 28, 2026)

### The Golden Rule
Never use technical language when plain English works.
Security buyers who are non-technical will not trust what they
don't understand. Plain English = trust. Jargon = fear.

### Approved Translations

| NEVER SAY (technical) | ALWAYS SAY (plain English) |
|----------------------|---------------------------|
| "Harden your Windows 11 kernel-level security architecture" | "Turn on the hidden, built-in protection that locks out hackers before they can touch your keyboard" |
| "Execute this automated registry optimization script" | "Run this free, open helper to instantly turn off annoying tracking and switch on maximum privacy" |
| "Configure Attack Surface Reduction rules" | "Turn off the Windows features hackers use most" |
| "Enable Tamper Protection via registry key" | "Lock your antivirus so nothing can turn it off without your permission" |
| "Disable LSASS credential dumping attack vector" | "Stop programs from stealing your saved passwords from memory" |
| "Enforce SmartScreen URL reputation filtering" | "Turn on the built-in filter that blocks dangerous websites before they load" |
| "Apply CIS Benchmark Level 1 controls" | "Set up the security settings that security experts recommend for home users" |
| "Disable WDigest authentication protocol" | "Turn off an old Windows feature that stores your password in plain text" |
| "Configure BitLocker with TPM+PIN preboot authentication" | "Encrypt your hard drive so nobody can read your files if your laptop is stolen" |
| "Remediate PUP detections from SC2 audit" | "Remove unwanted programs that snuck onto your PC" |
| "Enable Memory Integrity (HVCI)" | "Turn on a protection that stops malware from hiding deep in Windows" |
| "Disable AutoRun/AutoPlay attack surface" | "Stop your PC from automatically running programs off USB drives" |

### Why This Matters
Our primary audience has never heard of "kernel-level security"
or "registry optimization." Those phrases create fear, not trust.
But "turn on hidden protection that locks out hackers" --
everyone understands that. Everyone wants that.

The technical terms go in the source code documentation and
GitHub README for the power user audience.
The plain English goes everywhere the home user sees it:
- Website
- Guide
- Tool screens
- Reddit posts
- Library presentation handouts
- Email newsletters

### Test Every Line of Marketing Copy
Before publishing anything, ask: "Would my non-technical neighbor
understand this in 5 seconds?"
If no -- rewrite it.
If yes -- it's ready.

### More Translations Needed (research in progress)
Add to this list as new settings and features are added to the tool.
Every technical term in the tool needs a plain English equivalent
for the website guide and marketing materials.


---

## THE FAMILY IT HERO STRATEGY (June 28, 2026)

### The Core Insight
Every family or neighborhood has ONE person who gets called when:
- A laptop breaks
- A printer goes offline
- Someone clicks a bad link
- "My PC is acting weird"
- "I think I have a virus"

THIS PERSON IS YOUR MOST VALUABLE MARKETING CHANNEL.

If you convince ONE Family IT Hero that GatewayGuard is safe,
effective, and saves them time -- they will instantly deploy it
across 5-10 personal computers in their immediate circle.
That's 5-10 users from ONE convert. No advertising needed.

### The Family IT Hero Profile
- Usually 30s-50s, comfortable with technology
- Not a professional IT person -- just "the tech person" in the family
- Spends their own time helping parents, siblings, neighbors for free
- Currently has NO efficient solution for hardening home PCs
- Would LOVE a tool that does in 30 minutes what takes them hours
- Already trusted by the people they help -- zero skepticism transfer needed

### The Pitch to Family IT Heroes

PRIMARY MESSAGE:
"Tired of cleaning malware off your parents' or neighbors' PCs?
Run GatewayGuard next time you set up their machine.
It locks it down in 30 minutes -- and it explains everything
in plain English so they understand what was done."

SECONDARY MESSAGE:
"You don't have to be there in person.
Walk them through it over the phone.
GatewayGuard does the explaining for you."

WHAT MAKES THIS WORK:
- Saves the Hero TIME (their most precious resource)
- Reduces their future support calls (selfish benefit = powerful motivator)
- Makes them look good to the people they help
- Zero risk to them -- they can audit the open source code first
- Free tier means they can recommend it without asking anyone to pay

### Where Family IT Heroes Hang Out
Reddit:
- r/sysadmin -- "home lab" section, people who do IT professionally
  AND help family members
- r/techsupport -- Heroes answering questions = our exact audience
- r/pcmasterrace -- enthusiasts who help friends and family
- r/malelivingspace, r/homelab -- adjacent communities

Facebook Groups:
- "Windows 10/11 Help" groups
- Local community Facebook groups
- "Computer Help" groups

Forums:
- BleepingComputer (helpers and help-seekers)
- Tom's Hardware forums
- AnandTech forums

### Marketing Copy for Family IT Heroes

Website page: gatewayguard.co/for-helpers

HEADLINE: "You're everyone's free IT support. GatewayGuard is yours."

BODY:
"You're the person your family calls. You've cleaned malware off
your parents' PC four times. You've reset your neighbor's browser
settings twice. You've explained why they shouldn't click that link
more times than you can count.

GatewayGuard changes that.

Run it once on their PC and it locks down the 20+ settings that
let the bad stuff in. It explains every change in plain English
so they understand what was done. And because every change is
reversible, you can always undo anything.

One 30-minute session. Fewer panicked phone calls.
That's the GatewayGuard promise to the people who keep
everyone else safe."

CTA: "Download free and run it on the next PC you fix."

### The Viral Loop This Creates

Hero discovers GatewayGuard
  ↓
Hero runs it on their own PC -- sees it's safe and effective
  ↓
Hero runs it on parents' PC, siblings' PC, neighbors' PC
  ↓ (5-10 PCs per Hero)
Those people tell THEIR families and neighbors
  ↓
Some of THEM become Heroes for their own circles
  ↓
Viral loop -- each Hero spawns more Heroes

This is how grassroots software spreads without advertising.
One trusted person in a social network = gateway to the whole network.

### How This Connects to Beta Program
Beta testers ARE Family IT Heroes.
They're already the kind of person who:
- Wants to understand what a tool does before running it
- Will audit the PowerShell source before installing
- Has multiple family members who could benefit

Beta program recruitment should EXPLICITLY target this persona:
"Are you the tech person in your family?
Be one of our first 20 founding members --
free lifetime license for you AND step-by-step instructions
you can use to help every family member you support."

### How This Connects to ACB/Bridge Community
Bridge players who are Family IT Heroes = double opportunity:
- They protect their own PC
- They become the "bridge security person" in their club
- Bridge clubs are tight-knit social networks
- One Hero in a bridge club of 40 people = 40 potential users

### Immediate Action Items
[ ] Create gatewayguard.co/for-helpers page (post-launch)
[ ] Write Reddit post specifically targeting r/techsupport helpers
[ ] Add "Family IT Hero" persona to beta tester recruitment
[ ] Add to presentation: Heroes section showing viral loop potential
[ ] Draft email specifically for Heroes in annual update program
[ ] Create "share with a friend" one-click option on download page
[ ] Consider "Hero Pack" pricing -- 3 licenses for $24.99
    (one for themselves, two to give away)


---

## CORRECTION: NoID Privacy Pro Is Open Source and Documented (30-Jun-2026)

### IMPORTANT -- Supersedes earlier competitive claims in this document

Earlier notes in this document state NoID Privacy Pro applies 630+ changes
"with no explanation" and "no human support, no guidance." THIS WAS WRONG
and has been verified false against NoID's actual GitHub repository.

### What Is Actually True About NoID Privacy

CONFIRMED via github.com/NexusOne23/noid-privacy (30-Jun-2026 verification):

- FULLY OPEN SOURCE -- licensed GPL-3.0 for individuals/researchers/open-source use
- Core PowerShell engine and framework are entirely FREE -- the $43/€39.99
  price is ONLY for the optional one-click GUI wrapper
- Complete documentation exists: Docs/FEATURES.md details exactly what
  every one of the 630+ settings does, with registry keys and policy names
- BAVR pattern (Backup -> Apply -> Verify -> Restore) -- full one-click
  rollback of all changes, well documented
- Automated HTML compliance report via Verify-Complete-Hardening.ps1 --
  shows exactly what was checked and the result of each item
- "Custom" profile wizard allows granular module-by-module control --
  NOT all-or-nothing as previously assumed
- Detects third-party AV and gracefully adapts (skips Defender-only
  features like ASR with clear explanation why)
- Active GitHub repo with security disclosure policy, recent commits,
  responsive maintenance (v2.2.4 as of May 2026)
- Available in 8 languages (English, German, French, Spanish, Italian,
  Portuguese, Japanese, Chinese)
- Also has Linux and Android versions

### What This Means -- REVISED Competitive Position

NoID Privacy Pro is a MORE formidable competitor than previously documented.
It is NOT a black-box tool for semi-technical users. It is a fully
transparent, well-documented, open-source tool that a technical user
could trust as much as -- or more than -- GatewayGuard on the
transparency dimension.

### Where GatewayGuard STILL Differentiates (the real, defensible gap)

1. AUDIENCE: NoID explicitly states it is "not a beginner's tool."
   It targets power users comfortable with PowerShell, registry concepts,
   and technical documentation. GatewayGuard targets non-technical
   home users specifically -- this remains a real, valid distinction.

2. INTERACTION MODEL: NoID applies a chosen PROFILE (Balanced/Enterprise/
   Maximum) to many settings at once, even in "Custom" mode requiring
   users to understand module names and what they cover. GatewayGuard
   walks through items ONE AT A TIME with plain-language explanation
   BEFORE each individual change, requiring no prior technical knowledge
   to use it correctly.

3. LANGUAGE LEVEL: NoID's FEATURES.md documentation is technical
   (registry keys, policy names, security template settings).
   GatewayGuard's explanations are written for someone who has never
   opened Group Policy or Registry Editor.

4. HUMAN-ASSISTED SESSIONS: NoID has no equivalent -- no screen-share
   support, no beta tester program offering hands-on help. This
   differentiator REMAINS VALID and is GatewayGuard's strongest
   defensible advantage.

5. PRICING MODEL: NoID's engine is free but GUI is $43. GatewayGuard
   is a single $19.99 product with the explanatory interface built in
   from the start -- no separate "technical free version" vs
   "paid easy version" split.

### REVISED Marketing Language (replace earlier versions)

DO NOT SAY: "NoID applies 630 changes with no explanation"
  (FALSE -- they have thorough documentation)

DO NOT SAY: "NoID is a black box"
  (FALSE -- fully open source, GPL-3.0)

INSTEAD SAY:
"NoID Privacy is an excellent, fully open-source tool built for technical
users comfortable with PowerShell and registry-level concepts. GatewayGuard
is built for everyone else -- walking through each setting one at a time,
in plain language, with no prior technical knowledge required."

OR:
"Both GatewayGuard and NoID Privacy believe in transparency -- our code
is open and explained too. The difference is who it's built for: NoID
serves technical users who want full control over 630+ settings.
GatewayGuard serves home users who want guided, one-at-a-time decisions
explained in plain English."

### Action Items
[ ] Review and correct all earlier NoID competitive claims throughout
    this document that state or imply "no explanation" or "no documentation"
[ ] Update GatewayGuard_MarketResearch.docx if it contains the same error
[ ] Update presentation slide 4 and companion sheet if they reference
    "no guidance" for NoID
[ ] Consider NoID as a credible open-source peer, not a black-box
    inferior product -- compete on AUDIENCE FIT, not on transparency
[ ] GatewayGuard should also consider publishing its own FEATURES.md
    style documentation -- NoID's approach to this is worth modeling
[ ] Re-verify any other competitor claims in this document before
    using them publicly -- this was a research error worth learning from


---

## NoID PRIVACY -- FULL FEATURES.md REVIEW & GATEWAYGUARD RELEVANCE (30-Jun-2026)

### Methodology Note
This section is based on actually reading NoID's public Docs/FEATURES.md
(747 lines, retrieved 30-Jun-2026), not just summary research. This is
the first genuine source-document review, distinct from earlier web
searches about NoID.

### User Complaints / Known Friction Points (per their own documentation)
NoID's own docs candidly document where their settings cause problems --
this is a sign of good-faith documentation, not hidden bugs:

1. ASR FALSE POSITIVES -- LSASS memory-read blocks can affect older
   software, game launchers, modding tools. Office/Adobe child-process
   blocks break custom macros and third-party plugins.

2. LOCAL NETWORK DISRUPTION -- Discovery protocol and mDNS disabling
   breaks local file sharing, network printers, and smart TV casting.
   Documented explicitly under "Discovery Protocols Security" --
   their own docs say "Automatic network printer/scanner discovery stops."

3. WINDOWS INSIDER PROGRAM CONFLICT -- Their own README has a dedicated
   troubleshooting section: MSRecommended privacy mode sets
   AllowTelemetry=1 via policy, which BLOCKS Windows Insider enrollment
   (Insider requires AllowTelemetry=3). They provide a documented
   workaround (temporarily remove the registry policy).

4. PARANOID MODE BREAKS VIDEO CALLING -- Explicitly documented:
   "Paranoid: Everything from Strict + WerSvc disabled... WARNING:
   BREAKS Teams/Zoom/Skype!" -- they warn users directly in their own docs.

5. "MANAGED BY YOUR ORGANIZATION" CONFUSION -- Their Windows Update
   module intentionally uses Group Policy registry keys, which causes
   the Windows Settings UI to display "managed by your organization" --
   confusing for home users even though NO actual organization is involved.

6. PHOTOS/PAINT AI BUTTONS STILL VISIBLE -- Their own "Known Limitations"
   section: AI feature buttons remain visible in UI but are non-functional
   because Microsoft hasn't provided policies to hide them, only block them.

### IMPORTANT CONTEXT -- These Are Disclosed, Not Hidden Bugs
NoID's documentation is unusually candid about side effects. Each module
includes an explicit "Impact" section. This is actually a STRENGTH of
their transparency model -- it reinforces the correction made earlier
today: NoID is NOT a black box. They tell you upfront what might break.

### What This Means for GatewayGuard Marketing
DO NOT use NoID's documented friction points as "gotcha" criticism --
they disclosed these themselves, which is commendable. Instead, the
honest differentiation is:

"NoID documents what might break in technical terms (ASR LSASS reads,
mDNS discovery, AllowTelemetry policy conflicts). GatewayGuard explains
the same kind of tradeoffs in plain language before you ever apply a
change -- so you decide per-setting, not per-630-setting-bundle."

---

## NoID SOURCE REVIEW -- WHICH OF THEIR 630+ SETTINGS ARE RELEVANT TO GATEWAYGUARD

### Direct Answer to "Have You Already Done This?"
No -- prior to today only summary-level research had been done (their
README and marketing site). This is the first pass actually reading
their full FEATURES.md documentation line by line. Below is the result.

### NoID's 7 Modules at a Glance
| Module | Settings | Relevant to GatewayGuard? |
|--------|----------|---------------------------|
| SecurityBaseline | 425 | Partially -- see breakdown below |
| ASR | 19 | YES -- high value, Defender-native |
| DNS | 5 | WORTH CONSIDERING -- new territory for us |
| Privacy | 78 | PARTIALLY -- some overlap with our settings 11-12 |
| AntiAI | 32 | YES -- directly matches our planned 26H2 settings |
| EdgeHardening | 24 | PARTIALLY -- we touch a few Edge settings already |
| AdvancedSecurity | 50 | SELECTIVELY -- several already on our ascii22+ list |

### HIGH-VALUE ADDITIONS FOR GATEWAYGUARD (from NoID's catalogue)

**From AdvancedSecurity module -- already partially planned, now confirmed valuable:**
- WDigest Protection (UseLogonCredential=0) -- ALREADY ON OUR LIST for ascii22+
- PowerShell v2 Removal -- ALREADY ON OUR LIST for ascii22+
- SRP .lnk Protection (CVE-2025-9491) -- NEW, HIGH VALUE
  Blocks a known unpatched zero-day (Microsoft has stated it "does not
  meet servicing threshold" -- i.e. won't be patched). Two simple
  Software Restriction Policy rules block .lnk execution from
  Temp/Downloads folders. Strong candidate for GatewayGuard.
- Finger Protocol Block (TCP port 79 outbound) -- NEW, ZERO IMPACT
  Blocks ClickFix malware campaign (finger.exe abuse). Protocol is
  obsolete since the 1990s -- zero legitimate impact, pure upside.
  Excellent candidate -- no tradeoff to explain to users.
- WPAD Disable -- NEW, WORTH CONSIDERING
  Prevents proxy hijacking (rogue WPAD server attacks). Low complexity.
- Legacy TLS 1.0/1.1 Disable -- WORTH CONSIDERING
  Protects against BEAST/CRIME/POODLE. Modern systems rarely need
  TLS 1.0/1.1 -- low risk of breaking anything in 2026.
- RDP NLA Enforcement -- WORTH CONSIDERING for users with RDP enabled
  Simple two-key change (UserAuthentication=1, SecurityLayer=2),
  meaningfully reduces RDP brute-force risk.

**From AntiAI module -- validates our ascii23+ plan:**
NoID's AntiAI module disabling 15 AI features (Recall, Copilot, Paint
Cocreator, Notepad AI, Click to Do, etc.) directly confirms the research
already in this document about 26H2 AI features. Their registry key
list (32 policies) is a useful cross-reference for our own
implementation when we build this in ascii23.
ACTION: Use NoID's documented registry keys as a starting reference
point when building GatewayGuard's own AI-disable setting (verify
independently, do not copy-paste without testing).

**From ASR module -- already core to GatewayGuard's Defender-based approach:**
Our existing settings already touch Defender configuration. NoID's ASR
rule list (19 rules) is useful as a REFERENCE for which specific rules
matter most. The ones with the best safety/impact ratio for home users:
- Block credential stealing from LSASS (anti-Mimikatz) -- HIGH VALUE
- Block executable content from email -- HIGH VALUE
- Block JavaScript/VBScript launching downloads -- HIGH VALUE
- Advanced ransomware protection -- HIGH VALUE, AI-powered, low friction
These four specifically have minimal false-positive risk for typical
home users (the friction-prone ones are Office macro-blocking and
USB-process blocking, which legitimate small businesses sometimes need).

**From DNS module -- new territory worth considering:**
NoID offers DNS-over-HTTPS setup with provider choice (Quad9/Cloudflare/
AdGuard) plus a "Skip" option. This is NOT something GatewayGuard
currently touches. Could be a good ascii24+ addition:
- Simple, high privacy/security value
- Already partly covered in our SANDY troubleshooting work (we manually
  set 8.8.8.8/8.8.4.4 DNS during a support session earlier this project)
- Their REQUIRE vs ALLOW fallback distinction is a good UX pattern to
  borrow (REQUIRE = max security, ALLOW = compatibility for VPN/mobile)

### SETTINGS TO DELIBERATELY NOT ADOPT (too aggressive for our audience)
- IPv6 full disable -- breaks IPv6-only services, requires reboot,
  too disruptive for non-technical home users to troubleshoot if something breaks
- Firewall "Shields Up" (block all inbound/outbound by default) --
  too likely to silently break things home users won't know how to diagnose
- Complete RDP disable -- fine for NoID's technical audience's "Maximum"
  profile, but most home users don't even know what RDP is; better to
  just confirm it's off by default rather than make it a guided decision
- Full Discovery Protocol disable (breaks printer/smart TV discovery) --
  the friction-to-benefit ratio is poor for a typical household with a
  wireless printer and a smart TV
- "Paranoid" privacy mode -- their own docs say it breaks Teams/Zoom/Skype.
  Not worth the risk for GatewayGuard's plain-language, low-friction model.

### RECOMMENDED ASCII23/24 ADDITIONS FROM THIS REVIEW (priority order)
1. WDigest disable (already planned)
2. PowerShell v2 removal (already planned)
3. SRP .lnk protection (CVE-2025-9491) -- NEW, zero-day, no patch coming
4. Finger protocol block (port 79) -- NEW, zero impact, blocks active malware campaign
5. Four specific ASR rules (LSASS, email exec, JS/VBS downloads, ransomware protection)
6. AntiAI / Windows 11 AI feature disable -- already planned for 26H2 readiness
7. WPAD disable -- NEW, low complexity, real benefit
8. DNS-over-HTTPS setup wizard -- consider for ascii24, new territory but high value

### KEY TAKEAWAY
NoID's open documentation is genuinely useful as a reference catalogue --
not to copy wholesale, but to identify which of their 630+ settings are
both (a) high security value and (b) low risk of breaking things for a
non-technical home user. The four items above (SRP .lnk, Finger block,
the four ASR rules, WPAD) are strong, low-friction additions worth
prioritizing in upcoming builds.


---

## NoID SUPPORT MODEL -- RESEARCH AND VERIFICATION (30-Jun-2026)

### Verification Note (important)
The provided research describes a "community support via GitHub Issues"
model. When actually checked against NoID's live GitHub repo today,
this was found to need a correction:

VERIFIED FACT: As of 30-Jun-2026, NoID's GitHub repository shows
"Issue creation is restricted in this repository" -- meaning the public
CANNOT currently open new GitHub Issues to report bugs or ask for help.
There were zero open issues found. This is the opposite of an active
public bug-tracker/support channel.

This means the "Bug Reports: Highly responsive" claim and "community-
driven support via Issues tab" claim cannot be verified as currently
accurate -- the Issues tab is locked down, not an open community channel.
Security vulnerability reporting is separately handled via private
disclosure (confirmed in their Security policy from earlier research),
which is normal and good practice, but is NOT the same as general
user support.

### What Can Be Confirmed
- 48 forks, 153 stars on GitHub (real but modest community size)
- Active development -- v2.2.4 released, regular commits, last updated
  18-May-2026 per FEATURES.md
- Discussions tab exists on the repo (separate from Issues) -- this MAY
  be where user support actually happens, not yet independently verified
- A dedicated Security Overview page exists with responsible disclosure
  process for vulnerabilities specifically (not general support)
- No live chat, phone support, or 24/7 helpdesk -- confirmed, consistent
  with a small independent open-source project

### What Remains Unverified / Should Be Treated as Plausible-But-Unconfirmed
- Whether paid GUI ($43) purchasers get a dedicated support email/ticket
  channel -- not independently confirmed via primary source
- The specific characterization of "user error" tickets being closed
  without action vs "working as intended" responses -- plausible given
  the closed Issues tab, but no direct evidence reviewed (couldn't see
  issue history since the tab is restricted)
- Direct user complaints about response tone/curtness -- not found in
  Reddit/forum search during this session; this is an inference about
  what TYPICALLY happens with lean open-source projects, not a documented
  pattern specific to NoID

### Revised, Defensible Summary
NoID Privacy is a small, actively-maintained, open-source project
(153 stars, 48 forks) with locked-down public issue tracking as of
30-Jun-2026 -- meaning there is currently no visible open community
support channel for general troubleshooting. Whatever support exists
for paid GUI purchasers is not publicly documented or verifiable from
outside. This stands in contrast to GatewayGuard's explicit beta tester
program and assisted screen-share sessions, which are a publicly
documented, structured support offering from day one.

### Confirmed, Safe-to-Use Differentiation Point
"NoID Privacy is a small open-source project without a visible public
support channel for general troubleshooting. GatewayGuard offers free
assisted screen-share sessions where a real person walks you through
the tool -- a structured support option NoID does not provide."

This is accurate and defensible: the ABSENCE of an open Issues tab and
ABSENCE of any documented consumer helpdesk are independently verified
facts. The claim should rest on what GatewayGuard DOES offer (assisted
sessions) rather than speculative characterizations of how NoID's
support team behaves, which could not be independently confirmed.

### Lesson for Future Competitor Research
Claims about competitor support quality/responsiveness/tone should be
verified against primary sources (their actual GitHub Issues history,
Trustpilot, Reddit threads naming the product) before being treated as
fact. Plausible-sounding inferences about "how small open-source
projects typically behave" are not the same as documented evidence
about this specific project. Flag the difference clearly when reporting
research back to William going forward.

### Action Items
[ ] Periodically recheck if NoID's Issues tab reopens (current
    "restricted" status may be temporary or repo-specific settings)
[ ] Check NoID's Discussions tab specifically (different from Issues)
    next research pass -- this may be their actual support channel
[ ] Search Trustpilot, G2, or similar review sites for NoID Privacy Pro
    GUI purchasers specifically commenting on paid support experience
[ ] Do not repeat unverified support-tone claims in GatewayGuard
    marketing materials -- stick to the verified differentiation point above


---

## NoID SALES, REVENUE, FOUNDER & ANNUAL UPDATE MODEL -- VERIFICATION (30-Jun-2026)

### Verification Outcome -- Mixed
Some claims in the supplied research check out against primary sources.
One specific claim could NOT be verified and should not be repeated as fact.

### CANNOT VERIFY: Developer identity
The name "Fabio Mantegna" does not appear anywhere in NoID's GitHub
repository, README, FEATURES.md, Security policy, or release notes
reviewed today. The GitHub account is "NexusOne23" -- no real name is
publicly disclosed on any page checked. This specific identity claim
should be treated as UNVERIFIED and not repeated in GatewayGuard
materials unless independently confirmed (e.g. directly from
noid-privacy.com "About" page, which was not checked this session).
ACTION: If this matters for competitive intel, check noid-privacy.com
directly for an About/Author page before citing a name.

### CONFIRMED: Sales figures and revenue are not public
No earnings, unit sales, or revenue figures were found anywhere in the
GitHub repo, releases, or documentation -- consistent with an independent
project with no obligation to disclose. This part of the research is
accurate: these numbers are simply not publicly available, and there is
no evidence-based way to estimate them from what is public (153 GitHub
stars and 48 forks are a rough popularity signal only, not a sales proxy
-- many GitHub users star/fork without ever buying the paid GUI).

### CONFIRMED: Pricing structure is real but verify current numbers
GitHub README and noid-privacy.com confirm $43/€39.99 for the Pro GUI,
matching prior research. The specific "€149 for 5 devices" and
"€19.99 Update Pass" figures supplied in this latest research were NOT
independently re-verified this session -- they are plausible and
consistent with typical software tiering but should be confirmed
directly against noid-privacy.com pricing page before using in any
GatewayGuard comparison materials, since pricing pages change.

### PARTIALLY CONFIRMED: Timeline / time in existence
Confirmed via GitHub: a release tagged v1.7.14 exists with bug-fix
commits, and the current version is v2.2.4 (last updated 18-May-2026).
This confirms meaningful version history and ongoing development.
The specific claim of "late 2024/early 2025" launch was NOT independently
confirmed this session (would require checking the repo's first commit
date or earliest release tag) -- treat as a reasonable estimate, not a
verified fact, until the actual creation date is checked.

### CONFIRMED: Multi-platform expansion
Verified directly: noid-privacy-linux (420+ checks, Bash, zero
dependencies), an Android app description (81 checks, 10 categories),
and a custom Fedora-based "NoID Privacy Workstation 44" OS distribution
all exist and are publicly documented on GitHub. This is genuine and
substantial -- confirms NoID is more ambitious in scope than a single
Windows script, now spanning Windows, Linux, Android, and a full OS build.

### CONFIRMED: Version-specific Windows targeting
README explicitly states the main branch targets the "Windows 11 v25H2
Security Baseline" with separate handling noted for 26H2. This confirms
the research's point that NoID maintains version-specific code rather
than a single static script -- consistent with the "Last Updated:
2026-05-18" timestamp on their FEATURES.md, which postdates 25H2 release.

### CANNOT VERIFY: "Perpetual Fallback" license / Update Pass mechanics
No direct evidence was found this session describing exactly how NoID
handles licensing continuity across major annual Windows updates, beyond
the general BAVR rollback pattern (which IS confirmed and well-documented).
The specific "buy once, own that version forever, pay for an Update Pass
for new OS versions" business model was not directly confirmed against
their pricing/licensing pages this session. Plausible given typical
software licensing patterns, but should be verified directly at
noid-privacy.com before being treated as confirmed fact.

### What This Means -- Honest Summary for William
Roughly half of this latest research batch checks out against primary
sources (multi-platform expansion, version-specific code targeting,
general pricing structure, no public sales/revenue figures, ongoing
active development). The other half -- the developer's real name, exact
launch date, specific Update Pass pricing/mechanics -- could not be
verified in this session and should be treated as unconfirmed until
checked directly against noid-privacy.com or the repo's commit history.

### Standing Research Policy (reaffirmed)
As established in the earlier support-model correction: distinguish
clearly between VERIFIED claims (checked against primary source today)
and UNVERIFIED/PLAUSIBLE claims (sound reasonable but not independently
confirmed). Do not let confident-sounding research phrasing convert
into GatewayGuard's own marketing facts without that check.

### Follow-Up Action Items
[ ] Visit noid-privacy.com directly (not yet done) to check:
    - About/Author page for developer identity
    - Current Pro GUI / 5-device / Update Pass pricing
    - Any public sales or customer count claims
[ ] Check GitHub repo's first commit / earliest release tag for actual
    launch date (more reliable than estimated date range)
[ ] None of this is urgent for GatewayGuard's own roadmap -- useful
    competitive color, not a blocking dependency for ascii22/23 work


---

## TEST FLEET CONFIG ADDITIONS (2026-07-10 18:25 ET)

### Dell Latitude 5430 -- auto-login configuration
- Autologon64.exe (Sysinternals) configured with the Microsoft account
  email/password for automatic boot login
- Earlier netplwiz / manual Winlogon registry attempts FAILED -- stored
  username was the local profile folder name, not the MS account email
- Windows Hello PIN restored for manual sign-ins
- Sleep/wake sign-in prompt set to Never
- RELEVANT TO T3: machine boots straight to desktop after reboot --
  no login prompt will interrupt the ascii23 offline-scan resume test.
  Caveat: this means T3 does NOT test resume on a password-protected
  machine. After T3 passes, re-run the offline-scan resume path once
  with auto-login disabled (or on SANDY/IdeaPad with normal sign-in)
  before calling resume field-ready.

### HP SANDY -- exact model
- HP Notebook 17-by1955cl, Windows 11 Home, 8GB RAM
- Realtek RTL8821CE Wi-Fi adapter -- KNOWN driver issues; expect
  possible Wi-Fi flakiness during long test runs
- Code comment "confirmed HP 17-by1xxx" in ascii23 (productState
  0x1000 finding) refers to this machine

---

## PENDING DECISION -- PRODUCT-COPY NAMING RULE (logged 2026-07-10)

Old rule (early build sessions): only Microsoft Defender and
Malwarebytes Free may be named by name in any PUBLIC product copy.
Conflict: ProjectNotes marketing sections draft comparison tables
naming Norton, McAfee, Kaspersky, Avast.
Status: UNRESOLVED. Internal notes are fine either way. Before any
comparison content ships publicly, decide: (a) reaffirm the
two-names-only rule, or (b) permit factual, sourced comparisons of
named competitors. Option (a) is the safer fit with the existing
Marketing Moratorium. Log the decision here when made.
