<!-- Dated: 2026-08-22 12:24 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Guide gap-fill -- v9 source extracted for G1-G6

- **For:** Claude Cloud, to fill the six RETRIEVAL GAPS in GatewayGuard_GuideRewrite-Draft-2026-08-22-1000.md.
- **Source:** GatewayGuard_GuideV9-SourcePack-2026-08-15-1436.md
- **Nature:** BYTE-FAITHFUL EXTRACTION, not a rewrite. Each block is the raw v9 text for that gap, verbatim, with its source line range. Apply the plain-language / RULE W-07 / audience pass when weaving it in -- Claude Code extracts, Cloud writes the substance.
- **G2 note:** the Windows Hello section is already finished in the draft; this is the FULL v9 Step 4 for reference -- do not overwrite the finished Hello copy.
- **G4 note -- CORRECTED 2026-08-22 14:35. My original note said neither of these was requested. That was wrong about the first one, and I read the v9 line range instead of the draft's own G4 scope.**
  - **Quick decision tree (src 713-737): ALREADY IN SCOPE. Carry it, no decision needed.** The draft asks for it twice in its own words -- section 0.2's G4 row reads *"Phase 5 -- hardening, habits, performance hygiene, decision tree"*, and the in-place G4 marker lists *"The quick decision tree for when something looks wrong"*.
  - **When to call for help (src 738-746): NOT a duplicate, but do not carry it as a section.** The draft already has a `Getting help` back-matter section. Measured overlap: the draft covers ransomware/do-not-pay, the option not to do Phase 3 alone, who to call, and the fake-warning scam. **Four things in v9 are NOT in it** -- active-compromise indicators (unfamiliar sign-ins, sent mail you did not send, forwarding rules, money missing), the *50+ items or erratic behaviour* escalation threshold, employer/work accounts -> notify their IT, and harassment/stalking/domestic-abuse -> named professional resources. **Recommendation: fold those four into the existing `Getting help` section, in second person.** The v9 text carries **4 occurrences of "the user"** in 34 lines and is written for a technician working on somebody else's PC -- the exact voice section 0.1 removed.

---

## G1 -- Phase 1 Step 3: Device Encryption / BitLocker

> Source pack lines 390-403, verbatim:

```text
### Step 3 — Device Encryption / BitLocker

Why: Protects data if the PC is lost or stolen. Without it, anyone with physical access can read the drive.
Settings → Privacy & security → Device encryption.
Device encryption → On. If Off, toggle it On (encryption will run in the background; PC stays usable).
If “Device encryption” page doesn’t exist: search Start menu for Manage BitLocker. Each drive (at least the OS drive C:) → BitLocker On.
Find and save the recovery key (this is critical — losing it means losing all data if Windows ever can’t unlock the drive):
On a phone or another device, go to account.microsoft.com/devices/recoverykey
Sign in with the Microsoft account used on this PC
Should be: a 48-digit recovery key (eight blocks of six digits) listed for this device
Save it in two places: (a) print and store with important papers, OR password manager entry; AND (b) USB drive stored physically separate from the laptop
Must NOT save it only on the encrypted drive itself — chicken-and-egg problem when you’d actually need it
If the recovery key page is empty / no key shown: search Start menu for Manage BitLocker → click Back up your recovery key → choose Save to file (USB), Print, or Save to Microsoft account. Then re-check account.microsoft.com/devices/recoverykey to confirm it uploaded.

```

---

## G2 -- Phase 1 Step 4: User accounts & sign-in

> Source pack lines 404-426, verbatim:

```text
### Step 4 — User accounts & sign-in

Settings → Accounts → Your info:
Should show: a Microsoft account (email displayed) — needed for BitLocker key auto-backup. Local account works but loses that benefit.
Account type: Administrator is typical and acceptable for a single-user home PC. Best practice (optional) is to make a second Standard user for daily use and only sign in to the admin account when installing software — biggest single reduction in malware blast radius. Skip if it adds too much friction.
Settings → Accounts → Sign-in options:
Windows Hello PIN → Set up (6+ digits). The PIN is bound to the device’s TPM, so it can’t be brute-forced remotely.
Windows Hello Face / Fingerprint → Set up if hardware supports it (laptops with IR cameras / fingerprint readers). If “Unavailable,” that’s a hardware limitation — no problem.
Password → keep set up as fallback, but PIN should be the daily sign-in.
Picture password → Off / not set up. Less secure than PIN; skip.
At the bottom: “For improved security, only allow Windows Hello sign-in for Microsoft accounts on this device” → On.
Dynamic lock (locks PC when paired phone leaves Bluetooth range) → user preference. Off is fine.
Settings → Accounts → Other users and Family:
Should show: only people who actually use this PC.
If anything is unfamiliar (a name/email you don’t recognize) → that’s a red flag, do not delete yet, ask the user first.
Cleanest state: zero “Other users” if it’s a single-user PC.
Two-step verification on the Microsoft account (do from phone):
Go to account.microsoft.com/security
Sign in
Two-step verification → On. If currently Off, turn it on now.
Methods to set up: at least two. In order of preference: (a) Microsoft Authenticator app, (b) phone SMS, (c) email. Authenticator app should be primary.
Recovery code → Generate and Save. account.microsoft.com/security → Advanced security options → Recovery code → Generate. Save with the BitLocker key (print, password manager, USB). Without this code, losing the phone can lock you out permanently.

```

---

## G3a -- Step 6 Parts B to H

> Source pack lines 487-544, verbatim:

```text
Part B — Default search engine
(Settings → Search engine):
Sh
ould be: Google, Bing, or DuckDuckGo.
Red flags to remove: “search-redirect,” “yahoo-search” (only legitimate “Yahoo” entry is fine), “myway,” “ask.com,” anything else unfamiliar.
In Manage search engines and site search, delete unfamiliar entries from the list.
Part C — Homepage / startup pages
(Settings → On startup):
Acceptable: “Open the New Tab page” or “Continue where you left off.”
Red flag: “Open a specific page or set of pages” with a URL the user doesn’t recognize → remove that URL.
If a site like Facebook keeps reopening when you launch the browser: it’s either pinned (right-click the tab → Unpin), set as a startup page (remove from On startup list), or being launched by an extension (check Part A).
Part D — Stop browsers from auto-restarting after reboot or close
Browsers like Edge and Chrome are configured by default to silently keep running even after you close them, and to pre-launch at Windows boot. This eats RAM (often 1–2 GB), drives “why is m
y PC slow?” problems, and resurrects browser instances even when you didn’t open them. Turn this behavior off.
Microsoft Edge — stop background relaunch:
Open Edge → click the 3 dots in the top-right → Settings.
Click System and performance in the left sidebar (or paste edge://settings/system into the address bar).
Turn OFF: Startup boost (this is what pre-launches Edge silently when Windows boots).
Turn OFF: “Continue running background extensions and apps when Microsoft Edge is closed.”
Optional: Turn ON “Save resources with sleeping tabs” / Efficiency mode for additional RAM savings.
Close Edge fully when done.
Google Chrome — stop background relaunch:
Open Chrome → click the 3 dots in the top-right → Settings.
Click System in the left sidebar (or paste chrome://settings/system).
Turn OFF: “Continue running background apps when Google Chrome is closed.”
Optional: paste chrome://settings/performance and turn ON Memory Saver. Set to Maximum on systems with 8 GB or less RAM.
Close Chrome fully when done.
Note: Chrome doesn’t have an exact equivalent of Edge’s “Startup boost” — “Continue running background apps” is the only Chrome setting that keeps it alive after close. If Chrome is still launching at Windows boot after you turn this off, the cause is in Windows Startup apps (see Part E).
Mozilla Firefox — stop session restore on launch (if applicable):
Firefox → hamburger menu → Settings → General.
Under Startup: uncheck “Open previous windows and tabs.”
Close Firefox fully.
Part E — Set the correct default browser (stops Windows from auto-launching Edge)
Even with Edge’s background settings off, Windows itself will launch Edge whenever you click a link from Start menu search, the Widgets panel, Outlook, Teams, or notifications — unless a different browser is your system default.
Press Windows key → type Default apps → Enter.
Search for or click your preferred browser (Chrome, Firefox, etc.) in the app list.
Click “Set default” at the top — this assigns it for HTTP, HTTPS, HTML, and all related link types in one click.
Part F — Disable Windows Widgets (a major hidden Edge spawner)
The Widgets panel uses Edge processes in the background to fetch news, weather, and feed content — even if you never open Widgets. Turning Widgets off kills 2–3 ongoing Edge processes for most users.
Right-click an empty area of the taskbar → Taskbar settings.
Find Widgets and turn it Off.
Part G — Disable browsers in Windows Startup apps
Even with browser-side settings disabled, Windows can still auto-launch Edge or Chrome at boot if they’re in the Startup apps list (separate from the browser’s own settings).
Open Task Manager (Ctrl + Shift + Esc).
Click the Startup apps tab.
Look for: Microsoft Edge, MicrosoftEdgeUpdate, Google Chrome, GoogleUpdate, GoogleChromeAutoLaunch_*, or anything browser-related.
Right-click each → Disable.
Part H — Disable Edge’s scheduled tasks (the persistent ones)
Edge schedules itself in Windows Task Scheduler to launch periodically for updates and “preloading,” which can keep resurrecting it.
Press Windows key → type Task Scheduler → Enter.
In the left panel, click Task Scheduler Library.
Look for entries with MicrosoftEdge in the name (typically MicrosoftEdgeUpdateBrowserReplacement, MicrosoftEdgeUpdateTaskMachineCore, MicrosoftEdgeUpdateTaskMachineUA).
Right-click each → Disable. (Don’t Delete — disabling is reversible.)
Verify it worked:
Reboot the PC.
Before opening any browser, open Task Manager.
Sort the Processes tab by Name and look for “Microsoft Edge” and “Google Chrome” entries.
There should be none. If Edge still appears, you missed Part F (Widgets) or Part G (Startup apps) or Part H (scheduled tasks).
```

---

## G3b -- Phase 3 Step 3: Manually clean residue

> Source pack lines 584-602, verbatim:

```text
### Phase 3 Step 3 — Manually clean residue

Defender misses some files. Check these paths in File Explorer (paste each into the address bar):
C:\Users\<username>\PDFEditor
C:\Users\<username>\AppSuite
%AppData%\PDFEditor
%AppData%\AppSuite
%LocalAppData%\PDFEditor
%LocalAppData%\AppSuite
%ProgramData%\PDFEditor
%ProgramData%\AppSuite
For each that exists:
Open the folder. If it contains an Electron framework (files like chrome_*.pak, ffmpeg.dll, icudtl.dat, plus Resources/app/ or Resources/w-electron/ subfolders), it’s the malware.
Close any File Explorer window inside that folder.
Navigate up one level → right-click the malware folder → Delete.
If “in use” / “access denied,” reboot first then delete.
Empty the Recycle Bin to make sure files are gone.
Re-check all paths above to confirm “location not found.”

```

---

## G4a -- Phase 5: Hardening Recommendations (entire)

> Source pack lines 681-712, verbatim:

```text
## Phase 5: Hardening Recommendations

Apply these regardless of whether malware was found.

### Going-forward defensive habits

Never install free utilities from search results. Most malware arrives via SEO’d “free X tool” pages. Stick to:
Known publishers (Adobe, Foxit, PDF24 for PDFs; Audacity for audio; VLC for video; etc.)
Microsoft Store apps
Edge has built-in PDF viewing/annotation that covers most needs
Use a real password manager. Stop using browser-built-in password storage. Look for one that offers:
End-to-end encryption, so the provider itself can’t read your stored passwords
A working free tier or transparent pricing, with apps for every device you use (Windows, phone, browser extension)
A track record of independent security audits and a clear breach-disclosure history
Built-in passkey support and 2FA/authenticator code storage, since both are becoming standard
Several well-known options meet these criteria at the time of writing — do a quick search for “password manager comparison [current year]” to see current reviews, since this is an area where features and pricing change.
Run Malwarebytes Free monthly. Catches PUPs Defender ignores. Free version is enough — decline any Premium trial prompt, and afterward confirm Microsoft Defender is still your active antivirus (see Phase 3 Step 4 for details).
Run Defender Offline scan quarterly or any time something feels off (slow performance, unfamiliar pop-ups, browser redirects).
Enable 2FA everywhere it’s offered. Authenticator app > SMS > email. Save recovery codes for every account that issues one.
Review browser extensions every few months. They’re powerful and easy to forget.
Keep BitLocker/encryption recovery keys saved off the encrypted drive. Print, password manager, USB stick — somewhere safe and not the locked drive itself.
Keep browsers from auto-restarting. Re-verify every few months that Edge “Startup boost” and “run in background” are still off, and that your default browser is set to your preferred one. Windows updates and Edge updates have been known to silently flip these back on.
Watch for related malware family names in the future: AppSuite, ManualFinder, OneLaunch, Wave, Shift, TamperedChef. They cluster.

### Performance hygiene (related to security)

A bloated, low-RAM system encourages users to disable security features for performance. Keeping the system trim helps maintain security.
Audit Windows Startup apps quarterly: Task Manager → Startup apps. Disable anything you don’t actively use (Spotify, Steam, Discord, Adobe Creative Cloud auto-launchers, OEM bloatware like Lenovo Vantage).
Pick one daily-driver browser. Running Chrome + Edge + Firefox simultaneously can easily eat 3–4 GB on its own.
On 8 GB systems, set Chrome’s Memory Saver to Maximum and avoid keeping Electron apps (Slack, Teams, Discord, Spotify) open when not in use — each typically consumes 300–700 MB.
If a single Chrome or Edge instance shows multiple GB in Task Manager, close and relaunch — it’s usually a leaked tab or extension.

```

---

## G4b -- Appendix: PowerShell / Task Scheduler / commands

> Source pack lines 747-792, verbatim:

```text
## Appendix: Specific commands you may need


### PowerShell (right-click Start → Terminal)

List all installed Store apps matching a pattern:
Get-AppxPackage *<keyword>* | Select Name, Publisher, PackageFullName
List all programs (Store and traditional):
Get-WmiObject -Class Win32_Product | Select Name, Vendor, InstallDate
Force-stop and remove a specific Store app:
Get-AppxPackage *<exactname>* | Remove-AppxPackage
Identify Hyper-V-based VM workers (helpful when investigating vmmem / Memory Integrity):
Get-CimInstance Win32_Process -Filter "Name='vmwp.exe'" | Select-Object ProcessId, CommandLine

### Direct browser settings URLs

Microsoft Edge:
edge://settings/system — background apps and Startup boost
edge://settings/help — version and updates
edge://extensions — review installed extensions
Google Chrome:
chrome://settings/system — background apps toggle
chrome://settings/performance — Memory Saver
chrome://settings/onStartup — startup pages
chrome://settings/searchEngines — review search providers
chrome://settings/help — version and updates
chrome://extensions — review installed extensions

### File Explorer paths to remember

%AppData% → C:\Users\<user>\AppData\Roaming
%LocalAppData% → C:\Users\<user>\AppData\Local
%ProgramData% → C:\ProgramData
%UserProfile% → C:\Users\<user>

### Useful URLs

account.microsoft.com/devices/recoverykey — BitLocker recovery key
account.microsoft.com/security — Microsoft account 2FA, recovery codes
account.live.com/Activity — Microsoft sign-in activity
myaccount.google.com → Security — Google account, devices, password
mysignins.microsoft.com — Microsoft work/school account
haveibeenpwned.com — check email against known data breaches
justdeleteme.xyz — guide to deleting unused accounts
Generated based on real cleanup procedures performed on Windows 11 Home machines, including AppSuite “PDF Editor” / TamperedChef removal, Avira cleanup, and browser auto-restart prevention. Updated May 2026 to incorporate browser auto-restart prevention guidance.

```

---

## G5 -- Firefox-Specific Hardening (F1-F12 + tables)

> Source pack lines 793-929, verbatim:

```text
## Addendum: Firefox-Specific Hardening

Firefox uses a different settings layout than Chromium browsers (Chrome, Edge), so it gets its own walkthrough. Open Firefox and use these address-bar shortcuts (paste each into the URL bar and hit Enter). Skip this section if Firefox is not installed.

### F1 — Extensions audit (about:addons)

Paste about:addons → Enter.
Click Extensions in the left sidebar.
Desired state: every extension recognized and installed deliberately by the user.
Remove on sight: anything called “Coupon,” “Shopping helper,” “Search helper,” “Wave,” “Shift,” unknown publishers, or extensions you don’t recognize.
Click Themes and Plugins as well — same rules apply.

### F2 — Tracking protection and safe browsing

Paste about:preferences#privacy → Enter.
Under Enhanced Tracking Protection, select Strict (recommended) or Custom (only if you understand the trade-offs). Default Standard is acceptable but weaker.
Scroll to Deceptive Content and Dangerous Software Protection — confirm all four checkboxes are On (Block dangerous and deceptive content, dangerous downloads, unwanted/uncommon software).
Scroll to HTTPS-Only Mode — enable in all windows (recommended) or in private windows only. Forces secure connections wherever available.

### F3 — Search engine

Paste about:preferences#search → Enter.
Default Search Engine: confirm it’s Google, Bing, DuckDuckGo, or another known engine. Not “myway,” “search-redirect,” or other unfamiliar names.
In One-Click Search Engines (or Other Search Engines), remove any unfamiliar entries.
Address Bar: turn OFF “Provide search suggestions” for stricter privacy (optional).

### F4 — Stop session restore on launch (auto-restart prevention)

Paste about:preferences → Enter.
Under Startup, uncheck “Open previous windows and tabs.”
Optional: uncheck “Always check if Firefox is your default browser” to stop the recurring prompt — only if you’re intentionally not using Firefox as default.

### F5 — Disable telemetry and data collection

Paste about:preferences#privacy → Enter.
Scroll to Firefox Data Collection and Use.
Uncheck: “Allow Firefox to send technical and interaction data to Mozilla.”
Uncheck: “Allow Firefox to install and run studies.”
Uncheck: “Allow Firefox to send backlogged crash reports on your behalf.”
Optional: uncheck the Firefox Suggest experimental options if shown.

### F6 — Disable Pocket and recommended-content noise

Paste about:preferences#home → Enter.
Uncheck: “Recommended by Pocket.”
Uncheck: “Sponsored stories,” “Sponsored shortcuts,” and “Recent activity” if you don’t want them.
Paste about:preferences#search again — uncheck “Show search suggestions from sponsors” if present.

### F7 — DNS over HTTPS (DoH)

Paste about:preferences#privacy → Enter.
Scroll to DNS over HTTPS at the bottom.
Recommended: Increased Protection (uses Cloudflare or NextDNS by default).
Max Protection only if you’re comfortable with what it means (will fail closed if DoH is unavailable).

### F8 — Profile audit (catches injected secondary profiles)

Paste about:profiles → Enter.
Confirm there’s only the default profile (or profiles you intentionally created).
If you see an unfamiliar profile, do NOT click Remove yet — note its location and investigate. Some malware creates secondary Firefox profiles to siphon data quietly.

### F9 — Update settings

Paste about:preferences#general → Enter.
Under Firefox Updates, leave “Automatically install updates” On.
Uncheck “Use a background service to install updates” if you’re tight on RAM (8 GB systems) and want to reduce one persistent background service. Updates will still install — just when Firefox is running.

### F10 — Built-in password manager

Paste about:preferences#privacy → Enter.
Scroll to Logins and Passwords.
Uncheck: “Ask to save logins and passwords for websites” (use a dedicated password manager instead — see Phase 5 for what to look for).
Click Saved Logins to review existing saved passwords. Migrate them to a real password manager and remove from Firefox.

### F11 — Diagnostics if Firefox feels slow or memory-heavy

about:memory — click Measure under Show memory reports to see what’s using RAM.
about:performance — shows per-tab and per-extension CPU and memory usage; identify the heavy tab/extension.
about:support — Troubleshooting Information page; useful when asking for help on forums.

### F12 — Optional: Multi-Account Containers extension

Mozilla’s Multi-Account Containers extension lets you isolate cookies and sessions per tab (e.g., one container for personal Google, another for work Google, a third for shopping). Reduces cross-site tracking and accidental cross-account leakage. Install from addons.mozilla.org.

### Firefox quick-reference table

Setting
Location
Desired state
“Open previous windows and tabs”
about:preferences → Startup
Off
Enhanced Tracking Protection
about:preferences#privacy
Strict (or Custom)
Deceptive Content protection (4 boxes)
about:preferences#privacy
All On
HTTPS-Only Mode
about:preferences#privacy
Enable in all windows
Telemetry / studies / crash reports
about:preferences#privacy → Data Collection
All unchecked
Pocket / sponsored stories / sponsored shortcuts
about:preferences#home
All unchecked
Default search engine
about:preferences#search
Google / Bing / DuckDuckGo
DNS over HTTPS
about:preferences#privacy
Increased Protection
Built-in password manager
about:preferences#privacy → Logins and Passwords
Off
Background updater service
about:preferences#general → Firefox Updates
Off (on tight-RAM systems)
Profile count
about:profiles
Only profiles user knows about

### Firefox URL shortcuts (appendix)

about:preferences — main settings page
about:preferences#privacy — tracking protection, HTTPS-Only, DoH, telemetry, password manager
about:preferences#home — Pocket and sponsored content toggles
about:preferences#search — search engine and search suggestions
about:preferences#general — startup behavior and updates
about:addons — review installed extensions, themes, plugins
about:profiles — review installed Firefox profiles
about:performance — per-tab and per-extension resource usage
about:memory — detailed memory breakdown
about:support — diagnostic info for troubleshooting
End of Firefox addendum.

```

---

## G6 -- Glossary and Index

> Source pack lines 930-1043, verbatim:

```text
## Glossary

Definitions for key terms used throughout this guide. Useful for non-technical users following along.
2FA / Two-factor authentication — A login method that requires two pieces of evidence — typically a password plus a one-time code from an authenticator app, SMS, or email. Drastically reduces account takeover risk.
AppSuite — Publisher name behind a confirmed malware family (TamperedChef). Apps signed by AppSuite — especially generic “PDF Editor” products — should be treated as backdoors.
Authenticator app — A phone app that generates rotating one-time passcodes for 2FA. Examples: Microsoft Authenticator, Google Authenticator, Authy. More secure than SMS-based 2FA.
Backdoor — A type of malware that gives a remote attacker ongoing access to your machine, often hidden as a normal-looking program.
BitLocker — Microsoft’s built-in full-disk encryption for Windows. Protects data if the laptop is lost or stolen.
BitLocker recovery key — A 48-digit key Windows generates when BitLocker is enabled. Required to unlock the drive if Windows can’t. Must be stored OFF the encrypted drive.
Chromium — The open-source browser engine that powers Chrome, Edge, Brave, Opera, and many others. Apps that bundle Chromium (Slack, Discord, Teams) inherit its memory footprint.
Cloud-delivered protection — A Windows Defender feature that sends suspicious file fingerprints to Microsoft’s cloud for fast threat lookups. Should be On.
Controlled folder access — A Defender feature that blocks unauthorized apps from modifying files in protected folders (Documents, Pictures, etc.). Strong protection against ransomware.
Core Isolation / Memory Integrity — A Windows security feature that uses virtualization to isolate critical kernel processes from malware. Spawns vmmem and vmwp processes.
DDR4 / DDR5 — Generations of computer memory (RAM). DDR5 is newer and faster; older PCs use DDR4. Must match your motherboard.
Defender (Microsoft Defender) — Windows’ built-in antivirus, firewall, and threat protection suite. Generally adequate to replace third-party AV on home PCs.
Defender Offline scan — A Defender mode that boots into a clean environment before Windows fully loads, allowing it to find rootkits and other malware that hide from regular scans.
DoH / DNS over HTTPS — Encrypts DNS lookups so your ISP and network can’t see which websites you’re asking for. Configurable in Firefox and Edge.
Edge — Microsoft Edge — Windows’ default browser, based on Chromium.
Electron app — A category of desktop apps built on Chromium (e.g., Slack, Teams, Discord, Spotify, VS Code). Each typically uses 300–700 MB RAM.
Enhanced Tracking Protection (Firefox) — Firefox’s feature blocking trackers, fingerprinters, and cryptominers. Three tiers: Standard, Strict, Custom.
Extended Security Updates (ESU) — Paid program letting Windows 10 users keep getting security patches after October 2025 end-of-support.
Firewall — Software that controls which network connections in and out of the PC are allowed. Windows includes one (Microsoft Defender Firewall).
Gigabyte (GB) — Unit of data/memory size. 1 GB = 1,024 MB. Modern Windows comfortably uses 8–16 GB of RAM.
Hyper-V — Microsoft’s built-in virtualization technology. Memory Integrity, WSL2, Windows Sandbox, and WSA all depend on it.
Hypervisor / VBS — Virtualization-Based Security. Windows runs certain security functions inside a hypervisor-protected environment to isolate them from kernel-level malware.
MalwareBytes — Third-party anti-malware program known for catching PUPs and adware that Defender misses. Free version is sufficient.
Memory Integrity — See Core Isolation.
Memory Saver (Chrome) — Chrome feature that puts inactive tabs to sleep to free RAM. Settings: Moderate / Balanced / Maximum.
MPN / Model Part Number — Manufacturer’s exact part identifier. Use this when buying replacement RAM (e.g., Crucial CT8G4SFRA32A) to ensure compatibility.
Page file — A hidden file Windows uses as overflow when RAM fills up. Heavy use indicates RAM is too small for the workload.
Pinned tab — A browser tab “locked” to the leftmost position. Pinned tabs reopen automatically every time the browser starts.
PowerShell — Windows’ scripting and command shell. Often used for system administration tasks.
PUP / Potentially Unwanted Program — Software that isn’t outright malware but is unwanted: scareware, fake cleaners, aggressive bundlers.
RAM / Memory — Random Access Memory — the fast, temporary storage your PC uses for running programs. More = better multitasking.
Ransomware — Malware that encrypts your files and demands payment for the key. Backups + Controlled Folder Access are key defenses.
Real-time protection — Defender’s always-on scanning of files as they’re opened, downloaded, or modified.
SO-DIMM — Small Outline Dual Inline Memory Module — the laptop form factor for RAM. Different from desktop DIMMs.
Startup boost (Edge) — An Edge feature that pre-launches Edge silently when Windows boots, so it opens faster. Should be Off if you don’t want Edge auto-launching.
Tamper Protection — A Defender setting that prevents other software (including malware) from disabling Defender. Critical to keep On.
TamperedChef — Malware family distributed via fake utility apps (PDF Editor, ManualFinder, OneLaunch, Wave, Shift). Capable of password theft and full remote control.
Task Manager — Windows tool (Ctrl + Shift + Esc) for viewing running processes, CPU/RAM usage, and Startup apps.
Task Scheduler — Windows tool that runs programs on schedules. Edge and other apps add their own scheduled tasks here.
TPM / Trusted Platform Module — Hardware chip that securely stores encryption keys. BitLocker and Windows Hello PIN both rely on it.
UEFI / BIOS — Firmware that runs before Windows starts. Controls boot order, security features, and hardware initialization.
VBS — See Hypervisor.
VBR / VBS / vmmem / vmwp — Processes related to Virtualization-Based Security. Memory Integrity uses ~150–300 MB across these processes; legitimate.
VMware / VirtualBox — Third-party virtualization software (run other operating systems inside Windows).
WebView2 — A Microsoft runtime that lets desktop apps embed web content using the Edge engine. Used by Outlook, Teams, Widgets, and many others.
Widgets (Windows) — The news/weather panel accessible from the taskbar. Uses Edge processes in the background, even if never opened.
Windows Defender — See Defender.
Windows Hello — Windows’ biometric/PIN sign-in system. PIN is bound to the device’s TPM and can’t be stolen remotely.
Windows Update — Windows’ automatic patching system. Critical for security; should always be current.
WSA / Windows Subsystem for Android — Microsoft’s deprecated Android runtime for Windows 11. Spawns vmwp/vmmem if installed.
WSL / WSL2 — Windows Subsystem for Linux — runs a Linux distro inside Windows. Spawns vmwp/vmmem if a distro is running.

## Index

Section references for key topics. Locate the named section using the Table of Contents at the front of the document.
2FA / Two-step verification — Quick-reference table; Step 4 — User accounts & sign-in; Phase 5 — Hardening PAGEREF bm_Firefox_quick_reference_table \h #
AppSuite (malware) — CRITICAL — Known malicious publishers; Phase 3 — Incident Response; Quick decision tree PAGEREF bm_CRITICAL_Known_malicious_publishers_a \h #
Avira removal — Phase 4 — Avira-Specific Removal; Step 2 — Windows Security
BitLocker — Quick-reference table; Step 3 — Device Encryption / BitLocker; Phase 5 — Hardening; Glossary PAGEREF bm_Firefox_quick_reference_table \h #
Browser auto-restart prevention — Step 6, Part D (browser side); Step 6, Part E (default browser); Step 6, Part F (Widgets); Step 6, Part G (Startup apps); Step 6, Part H (Scheduled tasks)
Browser default settings — Step 6, Part E; Quick-reference table
Browser extensions audit — Step 6, Part A (Chrome/Edge); Firefox addendum F1
Chrome — Memory Saver — Quick-reference table; Step 6, Part D; Phase 5 — Performance hygiene PAGEREF bm_Quick_reference_settings_table_target \h #
Chrome — Password manager — Step 6, Part I; Phase 3 Step 8 PAGEREF bm_Phase_3_Step_8_Disable_Chrome_s_built \h #
Chrome — System settings (background apps) — Step 6, Part D; Quick-reference table PAGEREF bm_Phase_3_Step_8_Disable_Chrome_s_built \h #
Core Isolation / Memory Integrity — Step 2 — Windows Security (Defender); Quick-reference table; Glossary PAGEREF bm_Step_2_Windows_Security_Defender \h #
Defender (Microsoft Defender) — Step 2 — Windows Security; Phase 3 Step 2 — Offline scan; Glossary PAGEREF bm_Step_2_Windows_Security_Defender \h #
Defender Offline scan — Phase 3 Step 2; Phase 5 — Hardening PAGEREF bm_Phase_3_Step_2_Run_Microsoft_Defender \h #
Defender CPU loop fix (folder exclusion) — Step 2 — Windows Security; Quick-reference table PAGEREF bm_Step_2_Windows_Security_Defender \h #
Edge — Startup boost — Quick-reference table; Step 6, Part D PAGEREF bm_Quick_reference_settings_table_target \h #
Edge — Background apps — Quick-reference table; Step 6, Part D PAGEREF bm_Quick_reference_settings_table_target \h #
Edge — Scheduled tasks — Step 6, Part H; Quick-reference table
Email — forwarding rules — Phase 3 Step 6; Quick decision tree; Quick-reference table PAGEREF bm_Phase_3_Step_1_Uninstall_the_maliciou \h #
Firefox — Enhanced Tracking Protection — Firefox addendum F2; Firefox quick-reference table PAGEREF bm_Addendum_Firefox_Specific_Hardening \h #
Firefox — HTTPS-Only Mode — Firefox addendum F2; Firefox quick-reference table PAGEREF bm_Addendum_Firefox_Specific_Hardening \h #
Firefox — Multi-Account Containers — Firefox addendum F12 PAGEREF bm_Addendum_Firefox_Specific_Hardening \h #
Firefox — Pocket / sponsored content — Firefox addendum F6 PAGEREF bm_Addendum_Firefox_Specific_Hardening \h #
Firefox — Profile audit — Firefox addendum F8 PAGEREF bm_Addendum_Firefox_Specific_Hardening \h #
Firefox — Search engine — Firefox addendum F3 PAGEREF bm_Addendum_Firefox_Specific_Hardening \h #
Firefox — Session restore (Open previous tabs) — Step 6, Part D (Firefox section); Firefox addendum F4 PAGEREF bm_Addendum_Firefox_Specific_Hardening \h #
Firefox — Telemetry / data collection — Firefox addendum F5 PAGEREF bm_Addendum_Firefox_Specific_Hardening \h #
Firewall (Microsoft Defender Firewall) — Step 2 — Windows Security; Quick-reference table PAGEREF bm_Step_2_Windows_Security_Defender \h #
Hyper-V / Hypervisor — Step 2 — Windows Security (Memory Integrity note); Glossary PAGEREF bm_Step_2_Windows_Security_Defender \h #
Malwarebytes Free — Phase 3 Step 4; Phase 5 — Hardening PAGEREF bm_Phase_3_Step_4_Run_Malwarebytes_Free_ \h #
Microsoft account / sign-in — Step 4 — User accounts & sign-in; Phase 3 Step 5; Quick-reference table PAGEREF bm_Step_4_User_accounts_sign_in \h #
Microsoft Store / wsappx — Step 5 — Identify suspicious apps; Glossary PAGEREF bm_Step_5_Identify_suspicious_installed_ \h #
OneLaunch / Wave / Shift / ManualFinder — CRITICAL — Known malicious publishers PAGEREF bm_CRITICAL_Known_malicious_publishers_a \h #
Page file / virtual memory — Phase 5 — Performance hygiene; Glossary PAGEREF bm_Performance_hygiene_related_to_securi \h #
Password manager (dedicated, non-browser) — Step 6, Parts I and J; Phase 3 Step 7; Phase 5 — Hardening
PUPs (Potentially Unwanted Programs) — Common PUPs to remove; Quick decision tree; Glossary PAGEREF bm_Common_PUPs_to_remove_not_malware_but \h #
Quick-reference settings table — Front matter section PAGEREF bm_Quick_reference_settings_table_target \h #
RAM / Memory upgrade — Phase 5 — Performance hygiene PAGEREF bm_Performance_hygiene_related_to_securi \h #
Ransomware — When to call for help; Glossary PAGEREF bm_When_to_call_for_help \h #
Real-time protection (Defender) — Step 2 — Windows Security; Quick-reference table PAGEREF bm_Step_2_Windows_Security_Defender \h #
Recovery codes (Microsoft account) — Step 4 — User accounts & sign-in; Quick-reference table PAGEREF bm_Step_4_User_accounts_sign_in \h #
SmartScreen / Reputation-based protection — Step 2 — Windows Security; Quick-reference table PAGEREF bm_Step_2_Windows_Security_Defender \h #
Startup apps (Windows) — Step 6, Part G; Quick-reference table; Phase 5 — Performance hygiene
Tamper Protection — Step 2 — Windows Security; Quick-reference table; Glossary PAGEREF bm_Step_2_Windows_Security_Defender \h #
TamperedChef malware family — CRITICAL — Known malicious publishers; Phase 3 — Incident Response; Glossary PAGEREF bm_CRITICAL_Known_malicious_publishers_a \h #
Task Manager — Step 6, Part G; Phase 5 — Performance hygiene; Glossary
Task Scheduler — Step 6, Part H; Glossary
TPM (Trusted Platform Module) — Step 4 — User accounts & sign-in (PIN); Glossary PAGEREF bm_Step_4_User_accounts_sign_in \h #
Two-step verification — See: 2FA
vmmem / vmwp — Step 2 — Windows Security (Memory Integrity note); Appendix — PowerShell commands; Glossary PAGEREF bm_Step_2_Windows_Security_Defender \h #
WebView2 — Glossary PAGEREF bm_Glossary \h #
Widgets (Windows taskbar) — Step 6, Part F; Quick-reference table; Glossary
Windows Hello PIN / Face / Fingerprint — Step 4 — User accounts & sign-in; Quick-reference table; Glossary PAGEREF bm_Step_4_User_accounts_sign_in \h #
Windows Update — Step 1 — Windows Update; Quick-reference table; Glossary PAGEREF bm_Step_1_Windows_Update \h #
WSA (Windows Subsystem for Android) — Step 2 — Windows Security (Memory Integrity note); Glossary PAGEREF bm_Step_2_Windows_Security_Defender \h #
WSL (Windows Subsystem for Linux) — Step 2 — Windows Security (Memory Integrity note); Glossary PAGEREF bm_Step_2_Windows_Security_Defender \h #
End of document.
```
