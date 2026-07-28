# GatewayGuard Project Notes
**Last Updated:** June 23, 2026
**Current Build:** ascii20
**Test Machine:** HP Laptop 17-by1xxx (SANDY)

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
