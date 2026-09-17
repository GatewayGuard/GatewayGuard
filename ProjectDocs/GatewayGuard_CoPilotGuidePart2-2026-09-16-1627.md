<!-- Dated: 2026-09-16 16:27 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Copilot's Guide Rewrite -- Part 2 (Core Security Settings), verbatim

- **Document Name:** GatewayGuard_CoPilotGuidePart2-2026-09-16-1627
- **Dated:** 2026-09-16 16:27 ET
- **Editor:** Claude Code (CGDELL)
- **Purpose:** a verbatim `.md` twin of `Guide-Part 2 Core Security Settings-2026-09-16-1122.txt`, made because Claude Cloud's project-knowledge search did not surface any of the seven Copilot `.txt` files this session -- the same failure this project already fixed once for `.docx`/`.pdf` (Step 5, `CLAUDE.md`), showing up here for `.txt` instead.
- **Nothing cut, nothing reworded below.** The `.txt` file named above remains the file of record; this exists only so Cloud's connector can read the same words.

---

Part 2: Core Security Settings

This section covers the most important security protections available in Windows 11. For all home users, these settings provide the greatest security benefit and should be reviewed before moving on to privacy, convenience, or performance settings.

Setting 1: Windows Update
What It Is

Windows Update downloads and installs security fixes, bug fixes, reliability improvements, and new Windows features.

Why It Matters

Every month Microsoft releases security updates that fix newly discovered vulnerabilities.

Computers that miss updates remain exposed to security weaknesses that may already be known to criminals and malware authors.

Many successful attacks target systems that are simply missing security updates.

GatewayGuard Recommendation

Recommended: Automatic Updates Enabled

With your approval, Checkup will make this change for you.

For all home users, Windows should automatically check for, download, and install updates.

How To Check
Open Settings.
Select Windows Update.
Review the update status.
How To Change It
Open Settings.
Select Windows Update.
Turn on automatic updates if they are disabled.
Click Check for Updates.
What To Expect
Updates may require a restart.
Some updates take several minutes to install.
Major feature updates may take longer.
When You Might Choose Differently

The vast majority of home users should leave automatic updates enabled.

Setting 2: Microsoft Defender Real-Time Protection
What It Is

Microsoft Defender continuously monitors your computer for malicious software.

It checks:

Files you open
Files you download
Programs you run
Activity occurring in memory
Why It Matters

Real-time protection is your first line of defense against malware, ransomware, trojans, and other threats.

Without it, malware may execute before Windows has a chance to inspect it.

GatewayGuard Recommendation

Recommended: On

With your approval, Checkup will make this change for you.

How To Check
Open Windows Security.
Select Virus & Threat Protection.
Review Real-Time Protection.
How To Change It
Open Windows Security.
Select Virus & Threat Protection.
Select Manage Settings.
Turn Real-Time Protection on.
What To Expect

No restart usually required.

Protection begins immediately.

When You Might Choose Differently

Only when another trusted antivirus product is intentionally providing real-time protection.

Setting 3: Tamper Protection
What It Is

Tamper Protection prevents programs, malware, and unauthorized users from disabling Microsoft Defender security settings.

Why It Matters

Many malicious programs attempt to disable security software before launching an attack.

Tamper Protection makes those changes much more difficult.

GatewayGuard Recommendation

Recommended: On

Checkup checks this and shows you the steps; Windows requires that you make the change yourself.

How To Check
Open Windows Security.
Select Virus & Threat Protection.
Select Manage Settings.
Locate Tamper Protection.
How To Change It
Open Windows Security.
Select Virus & Threat Protection.
Select Manage Settings.
Turn Tamper Protection on.
What To Expect

No restart is required.

When You Might Choose Differently

GatewayGuard recommends that all home users have Tamper Protection enabled.

Setting 4: SmartScreen
What It Is

Microsoft Defender SmartScreen helps identify potentially dangerous:

Websites
Downloads
Applications

before they can harm your computer.

Why It Matters

SmartScreen provides an additional layer of protection when browsing the Internet or downloading files.

It can stop known malicious content before traditional antivirus detection occurs.

GatewayGuard Recommendation

Recommended: On

With your approval, Checkup will make this change for you.

How To Check
Open Windows Security.
Select App & Browser Control.
Review SmartScreen settings.

If Windows says a setting is managed by Smart App Control, that setting is already protected and cannot be changed there -- this is normal, not a fault.

How To Change It
Open Windows Security.
Select App & Browser Control.
Select Reputation-based protection settings.
Turn on Check apps and files, SmartScreen for Microsoft Edge, Potentially unwanted app blocking, and SmartScreen for Microsoft Store apps.
What To Expect

Occasionally Windows may display warnings before opening unfamiliar programs.

When You Might Choose Differently

Advanced users who regularly test unsigned software may find SmartScreen warnings inconvenient.

Setting 6: Enhanced Phishing Protection
What It Is

Phishing Protection helps identify:

Malicious apps and sites
Password reuse
Unsafe password storage

when using Microsoft Edge.

Windows Security shows a fourth checkbox in this same section, "Automatically collect website or app content when additional analysis is needed to help identify security threats." That checkbox is not part of this setting. It sends more of what is on your screen to Microsoft than the three warnings above need in order to work, so GatewayGuard does not recommend turning it on.

Why It Matters

Many account compromises begin with stolen passwords.

Phishing Protection helps identify risky behavior before credentials are stolen.

GatewayGuard Recommendation

Recommended: The Three Warnings On; Leave Automatic Collection Off

With your approval, Checkup will try to make this change. On some computers Windows blocks it; Checkup then shows you the steps.

How To Check
Open Windows Security.
Select App & Browser Control.
Open Reputation-Based Protection Settings.
Review Phishing Protection options.
How To Change It

Turn on:

Warn me about malicious apps and sites
Warn me about password reuse
Warn me about unsafe password storage

Leave unchecked:

Automatically collect website or app content when additional analysis is needed to help identify security threats

What To Expect

Windows may occasionally display warnings related to password usage.

When You Might Choose Differently

All home users should leave the three warnings enabled. Leaving the automatic-collection checkbox off costs you nothing -- the three warnings work the same either way.

Setting 7: Firewall & network protection
What It Is

The Windows Firewall monitors network traffic entering and leaving your computer.

Why It Matters

A firewall helps block unauthorized network communications.

It is particularly important when:

Traveling
Using public Wi-Fi
Connecting to unfamiliar networks
GatewayGuard Recommendation

Recommended: All Profiles Enabled

With your approval, Checkup will make this change for you.

Domain
Private
Public
How To Check
Open Windows Security.
Select Firewall & network protection.
Review all profiles.
How To Change It

Enable any disabled firewall profile.

What To Expect

No restart required.

Some applications may request firewall access the first time they run.

When You Might Choose Differently

All home users should keep all firewall profiles enabled.

Setting 8: BitLocker Data Encryption
What It Is

Encryption protects the contents of your drive if the computer is lost or stolen.

Windows 11 Pro typically uses BitLocker.

Windows 11 Home may use Device Encryption.

⚠ VERIFY -- Home/Pro split and whether Device Encryption on Home requires a Microsoft account. BitLocker Test 2 on SANDY answers this; sentence held until then.

Why It Matters

Without encryption, anyone with physical access to the drive may be able to read your files.

Encryption helps protect:

Financial records
Medical information
Personal documents
Family photos
GatewayGuard Recommendation

Recommended: Enabled

With your approval, on its own screen, Checkup will turn this on for you. It will not start without your recovery key saved first.

Important

Before enabling encryption:

Back up important files.
Save your recovery key.
Store the recovery key somewhere safe.
How To Check
Windows 11 Home
Open Settings.
Search for Device Encryption.
Windows 11 Pro
Open Control Panel.
Open BitLocker Drive Encryption.
How To Change It

Follow the step-by-step instructions provided by Checkup.

What To Expect
Initial encryption may take time.
A recovery key will be generated.

⚠ VERIFY -- on a Microsoft account the key is saved to the account automatically; on a local account it is saved nowhere automatically. One of the two claims that can cost a reader their files.

Encryption normally runs in the background.
When You Might Choose Differently

Desktop systems that never leave the home have lower physical theft exposure than laptops, but GatewayGuard still generally recommends encryption.

Setting 9: Windows Hello
What It Is

Windows Hello allows sign-in using:

PIN
Fingerprint
Facial recognition

depending on hardware capabilities.

Why It Matters

Windows Hello is typically more secure and more convenient than relying solely on a traditional password.

GatewayGuard Recommendation

Recommended: Configure a PIN at Minimum

Checkup checks this and shows you the steps; Windows requires that you make the change yourself.

⚠ VERIFY -- a PIN can be created on a local account; a local account cannot reset a forgotten PIN without the account password.

How To Check
Open Settings.
Select Accounts.
Select Sign-In Options.
How To Change It

Use Sign-In Options to configure:

PIN
Fingerprint
Face Recognition

if supported.

What To Expect

Setup usually takes only a few minutes.

When You Might Choose Differently

Users who prefer traditional passwords may continue using them, though a PIN is strongly recommended.

Setting 16: Memory Integrity
What It Is

Memory Integrity is a Windows security feature designed to prevent malicious or untrusted code from running in protected parts of memory.

Why It Matters

Many modern attacks attempt to execute code within trusted system processes.

Memory Integrity makes these attacks substantially more difficult.

GatewayGuard Recommendation

Recommended: On

With your approval, Checkup will make this change for you. A restart is needed for it to take effect.

How To Check
Open Windows Security.
Select Device Security.
Select Core Isolation.
Review Memory Integrity.
How To Change It

Turn Memory Integrity on.

What To Expect

A restart is usually required.

Some older drivers may be incompatible.

When You Might Choose Differently

If older hardware or software is incompatible, you may need to temporarily leave it disabled until compatible drivers become available.

Setting 17: Password Required on Wake
What It Is

This setting requires you to sign in again when the computer wakes from sleep.

Why It Matters

Without a password requirement, someone could access your computer simply by waking it from sleep.

GatewayGuard Recommendation

Recommended: Required

With your approval, Checkup will make this change for you.

How To Check
Open Settings.
Select Accounts.
Select Sign-In Options.
Review wake-up sign-in requirements.
How To Change It

Under "If you've been away, when should Windows require you to sign in again?", choose "When PC wakes up from sleep."

What To Expect

You will need to enter your PIN, password, fingerprint, or face recognition after waking the computer.

When You Might Choose Differently

Very few users should disable this protection.