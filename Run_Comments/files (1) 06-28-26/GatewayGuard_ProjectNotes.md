# GatewayGuard Project Notes
**Last Updated:** June 26, 2026
**Current Build:** ascii21
**Test Machines:** HP Laptop 17-by1xxx (SANDY), Lenovo IdeaPad

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
| ascii20 | 3,339 | **CURRENT -- ready to test** |

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
