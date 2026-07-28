# GatewayGuard — Frequently Asked Questions (FAQ)
**For:** gatewayguard.co/faq
**Started:** June 27, 2026
**Status:** Living document -- add questions as they come up during testing and beta

---

## CATEGORY 1: GETTING STARTED

**Q: What is GatewayGuard?**
A: GatewayGuard is a Windows 11 security hardening tool designed for everyday home users. It checks 19 important security settings on your PC, explains what was found, tells you why each setting matters, and lets you decide what gets changed. Nothing happens without your approval.

**Q: Do I need to be technical to use GatewayGuard?**
A: No. GatewayGuard is specifically designed for non-technical home users. Every setting is explained in plain English before anything is changed. You stay in full control at all times.

**Q: What Windows versions does GatewayGuard support?**
A: Windows 11 Home and Windows 11 Pro. Windows 10 is not supported.

**Q: Does GatewayGuard work on my PC?**
A: Check our tested hardware list at gatewayguard.co/compatible. If your PC is not listed, apply for our free beta tester program at gatewayguard.co/beta and we will test it with you over a screen share session.

**Q: Is GatewayGuard free?**
A: GatewayGuard is free for PCs listed on our tested hardware compatibility page (gatewayguard.co/compatible). For all other PCs, a one-time license fee applies. See gatewayguard.co/pricing for current prices.

**Q: Do I need an internet connection to run GatewayGuard?**
A: No. GatewayGuard runs entirely offline. It does not send any data anywhere. It does not phone home. It does not require an account or login.

---

## CATEGORY 2: INSTALLATION AND SETUP

**Q: How do I run GatewayGuard?**
A: Download both files (the .ps1 script and the Run-GatewayGuard.bat launcher) and save them to the same folder. Double-click Run-GatewayGuard.bat. Click Yes when Windows asks for Administrator access. Follow the on-screen prompts.

**Q: Why does Windows ask for Administrator access?**
A: Some security settings (like enabling BitLocker or configuring Windows Firewall) require Administrator rights to change. GatewayGuard only uses these rights to apply settings you specifically approve.

**Q: Why does Windows Defender or my antivirus flag GatewayGuard?**
A: GatewayGuard is a PowerShell script that modifies Windows security settings. Some antivirus products flag PowerShell scripts by default because malware sometimes uses PowerShell. GatewayGuard is not malware -- its full source code is visible and readable (it is a plain text .ps1 file -- open it in Notepad to see exactly what it does). If your antivirus flags it, add an exception for the GatewayGuard folder.

**Q: My screen is too small to see the full output**
A: Maximize the window (press Windows key + Up arrow, or drag to fill the screen). GatewayGuard is designed for a maximized window. Scroll arrows appear at the top right and bottom right of the window when there is more content. You can also use your mouse scroll wheel or the Page Up / Page Down keys.

**Q: GatewayGuard won't run -- says "execution policy" error**
A: Use the Run-GatewayGuard.bat launcher (not the .ps1 file directly). The .bat file sets the correct execution policy automatically. If you accidentally double-clicked the .ps1 file, close it and use the .bat file instead.

**Q: How long does GatewayGuard take to run?**
A: A typical full run takes 15-30 minutes depending on how many settings need attention and how many items you choose to change.

**Q: Can I stop partway through and come back?**
A: Yes -- press Q at any prompt to exit safely. Any settings already applied stay applied. Re-run GatewayGuard anytime to check or update settings.

---

## CATEGORY 3: WHAT GATEWAYGUARD DOES

**Q: What does GatewayGuard change on my PC?**
A: Only what you approve. GatewayGuard checks 19 security settings and shows you what it found. For each item that needs attention, it explains what it wants to change and why, then asks Y (yes) or N (no). Nothing changes without your explicit approval.

**Q: Can GatewayGuard break my PC?**
A: GatewayGuard only modifies Windows security settings -- it does not touch your files, programs, or personal data. Every automated change can be reversed. Windows 11 26H2 also includes Point-in-Time Restore as an additional safety net. That said, we recommend saving your work before running any system configuration tool.

**Q: Does GatewayGuard uninstall my apps?**
A: No. GatewayGuard includes an Apps Audit that reviews your installed applications and flags potentially unwanted programs (PUPs). It shows you what it found and explains any concerns -- but YOU decide whether to uninstall anything. GatewayGuard never uninstalls apps automatically.

**Q: What security settings does GatewayGuard check?**
A: GatewayGuard checks 19 settings across these areas: Windows Update, Microsoft Defender (real-time protection, tamper protection, periodic scanning), SmartScreen, Enhanced Phishing Protection, Windows Firewall, BitLocker encryption, Windows Hello, Remote Desktop, privacy settings (Advertising ID, Diagnostic Data), Edge browser settings, Memory Integrity, Password on Wake, Fast Startup, and Wake on LAN. See gatewayguard.co/guide for full details on each one.

**Q: Will GatewayGuard interfere with my antivirus?**
A: GatewayGuard works alongside your existing antivirus. It detects what AV software you have installed and adapts its recommendations accordingly. It does not disable, remove, or conflict with any antivirus product.

**Q: Does GatewayGuard work if I have Malwarebytes installed?**
A: Yes. GatewayGuard specifically detects Malwarebytes Free, Malwarebytes Premium Trial, and various other AV configurations and handles each one correctly with a clear explanation of what it found and what it means for your security setup.

**Q: Does GatewayGuard work with Windows 11 26H2?**
A: Yes. GatewayGuard is tested and updated for each major Windows 11 release. Check gatewayguard.co/compatible for the current tested version list.

---

## CATEGORY 4: PRIVACY AND SECURITY

**Q: Does GatewayGuard collect my data?**
A: No. GatewayGuard collects nothing. It runs offline, creates no account, sends no telemetry, and stores no personal information anywhere. A local log file is saved to your Desktop after each run for your own reference -- it never leaves your PC.

**Q: Why do you recommend Microsoft Defender instead of a paid antivirus?**
A: Microsoft Defender is built into every Windows 11 PC, maintained by Microsoft (who makes Windows), updated automatically via Windows Update every month, and independently tested as comparable to paid antivirus products by AV-TEST and AV-Comparatives. The problem is not that Defender is weak -- it ships with some settings turned off by default. GatewayGuard configures those settings correctly. You get protection comparable to paid antivirus, free, without a subscription. See gatewayguard.co/defender-vs-antivirus for the full comparison.

**Q: Is it safe to stop paying for my antivirus subscription?**
A: After running GatewayGuard to properly configure Microsoft Defender, most home users do not need a paid antivirus subscription. However this is a personal decision. We recommend researching the topic and making your own informed choice. See gatewayguard.co/defender-vs-antivirus for more information.

**Q: What is the difference between Defender Antivirus and Defender Firewall?**
A: They are two completely separate Windows services. Defender Antivirus (service: WinDefend) scans files and blocks malware. Defender Firewall (service: MpsSvc) blocks unauthorized network connections. Stopping or disabling one does NOT affect the other. This is why you may see "Defender Firewall ON" even when Defender Antivirus is not running -- they are independent services.

**Q: Is GatewayGuard GDPR compliant?**
A: Yes -- and more than that. GatewayGuard collects zero data by design, not by policy. No account is created, no data leaves your PC, no cookies or tracking are used on our website. GatewayGuard is architecturally incapable of violating GDPR, CCPA, Maine MPPA, or virtually any other privacy law worldwide -- because there is nothing to collect, store, or share. Zero data collected. Zero accounts required. Compliant with GDPR, CCPA, and global privacy laws -- by design, not by policy.

---

## CATEGORY 5: FILES AND VERSIONS

**Q: Which file is the latest version of GatewayGuard?**
A: Always use the file with the highest build number in the filename (for example, ascii22 is newer than ascii21) and the most recent date (in YYYY-MM-DD format, e.g. 2026-06-27). Always keep both the .ps1 script AND the matching Run-GatewayGuard.bat launcher in the same folder.

**Q: Do I need to keep old versions of GatewayGuard?**
A: No. Only keep the latest version. Old builds can be deleted safely.

**Q: Why does my GatewayGuard file show a Creation Date that is later than its Modified Date?**
A: This is normal Windows behavior and does not affect the file in any way. Here is what is happening:

When you copy, move, download, or extract a file from a zip, Windows resets the Creation Date to the moment the copy arrived on your PC. The Modified Date is preserved from the original file.

Example: If the file was built at 14:00 (2pm) and you extracted it from a zip at 16:00 (4pm):
  - Modified Date shows: 27-Jun-2026 14:00  (when it was built)
  - Creation Date shows: 27-Jun-2026 16:00  (when your copy was made)

So Creation appears later than Modified. This applies to every file copied or downloaded anywhere in the world -- it is a Windows Explorer display quirk, not an error. GatewayGuard's files are not affected by this in any way.

**Q: What date format does GatewayGuard use?**
A: GatewayGuard uses the format 27-Jun-2026 (day-abbreviated month name-year) for all displayed dates. This format is unambiguous in every country -- there is no confusion between day and month because the month is always spelled out (Jun, not 6). File names use ISO 8601 format (YYYY-MM-DD, e.g. 2026-06-27) which sorts correctly in every file system worldwide.

GatewayGuard follows the majority of the world convention for dates, not the US-only MM/DD/YYYY format. The US format is used by essentially one country. The rest of the world uses DD/MM/YYYY or YYYY-MM-DD. For a global tool, majority rules.

---

## CATEGORY 6: LICENSING AND PRICING

**Q: How much does GatewayGuard cost?**
A: See gatewayguard.co/pricing for current pricing. Single PC and multi-PC pack options are available. PCs on our tested hardware compatibility list (gatewayguard.co/compatible) are free.

**Q: How does licensing work?**
A: Each GatewayGuard license is tied to one PC using a hardware fingerprint. The license validates locally -- no internet connection or account required to run the tool. Multi-PC packs are available at a discount.

**Q: What happens if my PC breaks and I need to reinstall Windows?**
A: Contact us at support@gatewayguard.co and we will reactivate your license for the same PC at no charge.

**Q: Can I transfer my license to a new PC?**
A: License transfers are handled on request. Contact support@gatewayguard.co with your order details.

**Q: Is there a free trial?**
A: GatewayGuard is free for PCs on our tested hardware compatibility list. If your PC is not listed, apply for our free beta tester program -- you get a full free assisted session in exchange for helping us test compatibility on your hardware.

---

## CATEGORY 7: BETA TESTER PROGRAM

**Q: What is the beta tester program?**
A: If your PC is not on our tested hardware list, you can apply to be a beta tester. We run a GatewayGuard session with you over screen share, walking you through the tool together. You get a fully hardened PC at no cost. We get compatibility data for your hardware.

**Q: What does the beta tester session involve?**
A: Screen share only -- you stay in full control of your PC at all times. We communicate via text chat during the session. A typical session takes 30-60 minutes. Apply at gatewayguard.co/beta.

**Q: Is my privacy protected during a beta session?**
A: Yes. Screen share is view-only. We never ask for passwords, personal information, or remote control of your PC. We only observe the GatewayGuard tool running on your screen.

**Q: What happens after a beta session?**
A: Your PC hardware profile is added to our tested compatibility list. You receive a free license for your PC. Future GatewayGuard updates will be tested against your hardware configuration.

---

## CATEGORY 8: TROUBLESHOOTING

**Q: GatewayGuard detected my antivirus incorrectly**
A: Send a description of what GatewayGuard showed and what your actual AV setup is to support@gatewayguard.co -- we use these reports to improve detection accuracy in future builds.

**Q: Something went wrong after running GatewayGuard**
A: Every automated change GatewayGuard makes can be reversed by running it again and choosing to revert the relevant setting. The convenience feature review at the end of each session also lets you revert individual privacy settings one at a time. If Windows 11 26H2 is installed, Point-in-Time Restore provides an additional system-level rollback option (Settings -> System -> Recovery).

**Q: GatewayGuard says my Defender is OFF but my firewall is on**
A: This is correct and expected. Defender Antivirus and Defender Firewall are two completely separate services. Your firewall can be ON even when Defender Antivirus is not running. GatewayGuard detects and explains both independently. See Category 4 above for a full explanation.

**Q: The Apps Audit flagged an app I know is legitimate**
A: GatewayGuard's Apps Audit uses a trusted publisher list that we update regularly. If a legitimate app was flagged, you can safely ignore that recommendation. Send the app name to support@gatewayguard.co so we can add it to the trusted list in the next update.

**Q: I cannot see the bottom of a long screen**
A: Scroll arrows appear at the top right and bottom right corners of the console window. If the bottom arrow disappears, move your mouse pointer to the very bottom right corner of the window and it will reappear. You can also use the mouse scroll wheel or Page Down key. Always scroll to the bottom before pressing Enter or Space to continue.

---

## CATEGORY 9: INTERNATIONAL USERS

**Q: Is GatewayGuard available in other languages?**
A: GatewayGuard currently runs in English. Translations into German, Spanish, French, Japanese, and Mandarin Chinese are planned. Sign up at gatewayguard.co/notify to be notified when your language is available.

**Q: Does GatewayGuard work on non-English Windows installations?**
A: Yes. GatewayGuard reads Windows security settings directly from the registry and system APIs -- it does not depend on the Windows display language. The tool output will be in English regardless of your Windows language setting. A fully localized version is planned for future releases.

**Q: What date format does GatewayGuard use -- will I understand it?**
A: GatewayGuard uses the format 27-Jun-2026 (day-abbreviated month name-year) for all displayed dates. This format is internationally unambiguous -- there is no possible confusion between day and month because the month is always spelled out as a three-letter abbreviation (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec). File names use ISO 8601 format (YYYY-MM-DD) which is the international computing standard.

**Q: Is GatewayGuard GDPR compliant for European users?**
A: Yes -- see Category 4 above. GatewayGuard collects no data, creates no account, and uses no cookies or tracking. It is GDPR compliant by design. Our website privacy policy is available at gatewayguard.co/privacy.

**Q: I am in Europe -- does Defender work the same as in the US?**
A: Yes. Microsoft Defender is identical worldwide. Windows 11 security settings, registry paths, and PowerShell commands work the same on every Windows 11 installation regardless of country or language.

**Q: Will GatewayGuard work on my PC if I bought it outside the US?**
A: Yes. GatewayGuard works on any Windows 11 Home or Pro PC worldwide. Hardware region of origin does not affect compatibility.

---

## WEBSITE PAGES REFERENCED IN THIS FAQ
*(Pages that need to be built for gatewayguard.co)*

- gatewayguard.co/faq -- this page
- gatewayguard.co/compatible -- tested hardware list (free tier)
- gatewayguard.co/pricing -- pricing and license pack options
- gatewayguard.co/beta -- beta tester signup form
- gatewayguard.co/guide -- full guide with screenshots for all 19 settings
- gatewayguard.co/defender-vs-antivirus -- Defender vs paid AV explainer page
- gatewayguard.co/privacy -- privacy policy
- gatewayguard.co/notify -- language availability notification signup
- support@gatewayguard.co -- support email (needs to be set up)

---

## FAQ MAINTENANCE NOTES
- Add new questions after each beta session
- Add new questions from support emails
- Review and update after each major Windows 11 update (26H2 in Oct 2026)
- Review pricing section whenever pricing changes
- Review international section as translations are added
