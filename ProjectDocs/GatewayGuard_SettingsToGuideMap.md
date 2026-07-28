# GatewayGuard -- Settings to Guide Mapping
**Source:** windows_security_walkthrough_guide_v9.docx
**Created:** June 25, 2026
**Purpose:** Maps each of the 19 GatewayGuard settings to the relevant
section of the existing guide. This is the content foundation for
gatewayguard.co/guide -- most of it is already written.

---

## MAPPING: 19 Settings -> Guide Sections

### [1] Windows Update
**Guide source:** Phase 1, Step 1 -- Windows Update
**Content available:** Full step-by-step -- check for updates, Advanced
options (3 toggles), version verification, Windows 10 EOL warning
**Manual steps in tool:** Settings -> Windows Update -> Check for updates
**Website URL:** gatewayguard.co/guide/windows-update
**Status:** FULLY WRITTEN in guide

---

### [2] Defender Real-Time VP (Virus Protection)
**Guide source:** Phase 1, Step 2 -- Windows Security (Defender)
**Content available:** Full -- all 6 tiles, Manage settings (RT, Cloud,
Tamper, Sample submission, Controlled folder access), third-party AV removal
**Manual steps in tool:** Windows Security -> Virus & threat protection
-> Manage settings -> Real-time protection On
**Website URL:** gatewayguard.co/guide/defender-realtime
**Status:** FULLY WRITTEN in guide
**Note:** Guide also covers MB Free detection and coexistence

---

### [3] Tamper Protection (Defender)
**Guide source:** Phase 1, Step 2 -- Virus & threat protection -> Manage settings
**Content available:** Yes -- "critical -- malware tries to disable this;
if Off and user didn't disable it, that's a red flag"
**Manual steps in tool:** Windows Security -> Virus & threat protection
-> Manage settings -> Tamper Protection -> On
**Website URL:** gatewayguard.co/guide/tamper-protection
**Status:** COVERED in guide (subsection of Step 2)

---

### [4] SmartScreen
**Guide source:** Phase 1, Step 2 -- App & browser control ->
Reputation-based protection settings
**Content available:** Yes -- all sub-toggles listed with desired state On
**Manual steps in tool:** Windows Security -> App & browser control
-> Reputation-based protection settings -> all On
**Website URL:** gatewayguard.co/guide/smartscreen
**Status:** COVERED in guide (subsection of Step 2)

---

### [5] Defender Periodic Scanning
**Guide source:** Phase 1, Step 2 + Phase 3 Step 2 (Offline scan)
**Content available:** Partial -- guide covers offline scan setup and
quarterly Defender scan. Periodic scanning with MB Free companion covered.
**Manual steps in tool:** Windows Security -> Virus & threat protection
-> Microsoft Defender Antivirus options -> Periodic scanning On
**Website URL:** gatewayguard.co/guide/periodic-scanning
**Status:** PARTIALLY WRITTEN -- needs expansion for MB coexistence scenario
**Note:** Guide explains MB Free + Defender as recommended setup

---

### [6] Enhanced Phishing Protection (all 3)
**Guide source:** Phase 1, Step 2 -- App & browser control ->
Reputation-based protection -> Phishing protection (all three sub-options On)
**Content available:** Yes -- listed in Quick-reference table and Step 2
**Manual steps in tool:** Windows Security -> App & browser control
-> Reputation-based protection -> Phishing protection -> all 3 On
**Website URL:** gatewayguard.co/guide/phishing-protection
**Status:** COVERED in guide

---

### [7] Defender Firewall Protection (all profiles)
**Guide source:** Phase 1, Step 2 -- Firewall & network protection
**Content available:** Full -- Domain/Private/Public all must be On,
how to re-enable if Off
**Manual steps in tool:** Windows Security -> Firewall & network protection
-> check all 3 profiles are On
**Website URL:** gatewayguard.co/guide/firewall
**Status:** FULLY WRITTEN in guide
**Note:** Guide clarifies firewall is separate from AV engine

---

### [8] BitLocker / Device Encryption
**Guide source:** Phase 1, Step 3 -- Device Encryption / BitLocker
**Content available:** Full -- enable steps, recovery key backup (2+ places,
NOT on encrypted drive), account.microsoft.com/devices/recoverykey
**Manual steps in tool:** Settings -> Privacy & security -> Device encryption
-> On (Home) or BitLocker Drive Encryption (Pro)
**Website URL:** gatewayguard.co/guide/bitlocker
**Status:** FULLY WRITTEN in guide
**Note:** Guide covers both Home (Device Encryption) and Pro (BitLocker)

---

### [9] Windows Hello (check only)
**Guide source:** Phase 1, Step 4 -- User accounts & sign-in
**Content available:** Yes -- PIN setup, biometrics, "Only allow Windows
Hello sign-in for Microsoft accounts" toggle
**Manual steps in tool:** Settings -> Accounts -> Sign-in options
-> Windows Hello PIN -> Add
**Website URL:** gatewayguard.co/guide/windows-hello
**Status:** COVERED in guide

---

### [10] Remote Desktop -- Disable
**Guide source:** Quick-reference table -- "Turn Off if not used"
**Content available:** Brief mention -- "Settings -> System -> Remote Desktop.
If you don't use it, an open remote-access path is unnecessary attack surface."
**Manual steps in tool:** Settings -> System -> Remote Desktop -> Off
**Website URL:** gatewayguard.co/guide/remote-desktop
**Status:** BRIEF -- needs expansion for Pro edition explanation
**Note:** N/A on Home Edition -- Pro only setting in GatewayGuard

---

### [11] Advertising ID -- Turn Off
**Guide source:** Quick-reference table -- "Diagnostic data / advertising ID"
**Content available:** Brief -- "Privacy preference, not a security
requirement. Settings -> Privacy & security -> Diagnostics & feedback ->
turn off personalized advertising"
**Manual steps in tool:** Settings -> Privacy & security -> General
-> Let apps use advertising ID -> Off
**Website URL:** gatewayguard.co/guide/advertising-id
**Status:** BRIEF -- needs expansion explaining what it does

---

### [12] Diagnostic Data -- Required Only
**Guide source:** Quick-reference table -- "Diagnostic data / advertising ID"
**Content available:** Brief -- same section as above
**Manual steps in tool:** Settings -> Privacy & security ->
Diagnostics & feedback -> Diagnostic data -> Required diagnostic data
**Website URL:** gatewayguard.co/guide/diagnostic-data
**Status:** BRIEF -- needs expansion

---

### [13] Edge Startup Boost and Background Running
**Guide source:** Phase 2, Step 6, Part D -- Stop browsers from auto-restarting
**Content available:** FULL -- detailed steps for Edge Startup boost Off,
background apps Off, Chrome background apps Off, pinned tabs warning
**Manual steps in tool:** Edge -> Settings -> System and performance
-> Startup boost Off + Continue running background apps Off
**Website URL:** gatewayguard.co/guide/edge-startup
**Status:** FULLY WRITTEN in guide (Step 6 Part D)

---

### [14] Windows Widgets -- Disable
**Guide source:** Phase 2, Step 6, Part F -- Disable Windows Widgets
**Content available:** Full -- right-click taskbar -> Taskbar settings
-> Widgets Off. Explains Edge WebView2 background processes.
**Manual steps in tool:** Settings -> Personalization -> Taskbar -> Widgets Off
**Website URL:** gatewayguard.co/guide/widgets
**Status:** FULLY WRITTEN in guide (Step 6 Part F)

---

### [15] Edge Password Saving -- Disable
**Guide source:** Phase 2, Step 6, Part I -- Chrome/Edge built-in
password manager
**Content available:** Full -- "Turn Off -- convenient but single point
of failure if PC is compromised. Use dedicated password manager instead."
**Manual steps in tool:** Edge -> Settings -> Passwords
-> Offer to save passwords Off
**Website URL:** gatewayguard.co/guide/password-manager
**Status:** FULLY WRITTEN in guide (Step 6 Part I)

---

### [16] Memory Integrity (Core Isolation)
**Guide source:** Phase 1, Step 2 -- Device security -> Core isolation
**Content available:** Full -- "On if compatible. If incompatible drivers
are blocking it, leave Off. Note on vmmem/vmwp processes (150-300MB RAM)
-- legitimate, valuable security."
**Manual steps in tool:** Windows Security -> Device security
-> Core isolation details -> Memory integrity On
**Website URL:** gatewayguard.co/guide/memory-integrity
**Status:** FULLY WRITTEN in guide

---

### [17] Password Required on Wake
**Guide source:** Phase 1, Step 4 -- User accounts & sign-in
**Content available:** Covered under sign-in options section
**Manual steps in tool:** Settings -> Accounts -> Sign-in options
-> Require sign-in -> When PC wakes from sleep
**Website URL:** gatewayguard.co/guide/password-on-wake
**Status:** COVERED in guide

---

### [18] Fast Startup -- Disable
**Guide source:** Quick-reference table -- "Keep On / Turn Off" table
(not explicitly listed but covered under Windows security hygiene)
**Content available:** MISSING from guide -- needs to be written
**Manual steps in tool:** Control Panel -> Power Options -> Choose what
power buttons do -> Turn on fast startup -> uncheck
**Website URL:** gatewayguard.co/guide/fast-startup
**Status:** NOT IN GUIDE -- needs new content written

---

### [19] Wake on LAN -- Disable
**Guide source:** Not covered in guide
**Content available:** MISSING -- needs to be written
**Manual steps in tool:** Device Manager -> Network Adapters ->
right-click -> Properties -> Power Management ->
Allow this device to wake the computer -> uncheck
**Website URL:** gatewayguard.co/guide/wake-on-lan
**Status:** NOT IN GUIDE -- needs new content written

---

## SUMMARY

| Status | Count | Settings |
|--------|-------|---------|
| Fully written in guide | 8 | 1,2,7,8,13,14,15,16 |
| Covered (subsection) | 5 | 3,4,5,6,9 |
| Brief (needs expansion) | 3 | 10,11,12 |
| Missing -- needs writing | 2 | 18,19 |
| Not applicable (Home) | 1 | 10 |

**Bottom line:** 13 of 19 settings have usable guide content already written.
Only 2 settings (Fast Startup, Wake on LAN) need content written from scratch.

---

## ADDITIONAL GUIDE CONTENT (beyond the 19 settings)

The guide also contains valuable content for the website beyond the 19 settings:

**Phase 3 -- Incident Response (AppSuite/TamperedChef)**
-> Could become a separate gatewayguard.co/malware-removal page

**Phase 4 -- Avira Removal**
-> Could become gatewayguard.co/third-party-av-removal

**Phase 5 -- Hardening Recommendations**
-> Going-forward defensive habits
-> Performance hygiene
-> Quick decision tree
-> When to call for help
-> Could become gatewayguard.co/beyond-gatewayguard

**Firefox Addendum (F1-F12)**
-> Could become gatewayguard.co/firefox-hardening

**Glossary**
-> Could become gatewayguard.co/glossary

**Quick-reference settings table**
-> Could become gatewayguard.co/settings-reference
-> Also perfect as a printable PDF download

**2026 Time-Sensitive Updates section**
-> Secure Boot certificate expiration (June 2026)
-> Major June 2026 patch reminder
-> Keep this updated annually
