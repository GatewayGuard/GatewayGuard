<!-- Dated: 2026-08-13 14:27 ET -->
<!-- Editor: Claude Code (CGDELL) -->
<!-- GENERATED from the source documents. Re-generate rather than hand-edit. -->
# GatewayGuard Marketing Source Pack

- **Document Name:** GatewayGuard_MarketingSourcePack
- **Last Modified:** 2026-08-13 14:27 ET
- **Last Editor:** Claude Code (CGDELL)
- **Purpose:** Put the marketing documents where Claude Cloud can read them.

---

## WHY THIS FILE EXISTS

The Cloud connector scope is `ProjectDocs/`, `Tool/`, `WebSite/Rules/` and
`CLAUDE.md`. **`Marketing/` and `Presentation/` are NOT in it**, so Cloud
cannot see any of the documents below. This file carries their text into a
folder Cloud already reads -- no scope change, no capacity cost, no binary.

**This is a COPY. The documents named below are the originals.** Anything
Cloud proposes must be applied to the original by Claude Code, not here.

## STATE AS OF THIS FILE -- READ BEFORE PROPOSING ANYTHING

- **In `Marketing-Notes.md` the open-source violation is CLOSED** -- seven
  references cleared 2026-08-13, and `Marketing-Notes.docx` retired.
  **It is NOT closed across ProjectDocs.** Measured 2026-08-13:
  `GatewayGuard_ProjectNotes-2026-08-09-1435.md` carries 23 hits, of which
  **3 are live violations** -- line 2547 `MARKETING COPY: "Open source.
  Verifiable. Zero data collected."`, line 2741 the pitch line, and line
  3006 *"they can audit the open source code first"*. The other 20 are
  third-party tools (NoID Privacy, Hardentools, Notally -- all genuinely
  open-source) or the historical record of the Option A/B decision itself.
  **Do not sweep those 20.** Cloud found line 3006 and was right to.
- **`ExpertPositioning` states the ban correctly** -- *"GatewayGuard is not
  open-source"*. That is the rule, not a breach. Do not sweep it.
- **Assisted sessions are already compliant everywhere** -- "NOT offered at
  launch", "planned", "(Planned)", "on our roadmap". No fix owed.
- **Two live PL-4 breaches remain, both in the Family Presentation:**
  *"No competitor offers this"* (slide 6) and *"no one else has this
  planned"* (slide 8). Substitution is *no one else* -> *few competitors*.
- **`Marketing-Notes.md` IS CORRUPTED, and it is not my doing.** The word
  **"free" was overwritten with "an expensive"** by a find-and-replace that
  ran before the file ever reached git. **measured 2026-08-13:** 9
  occurrences of *an expensive*, against 21 *free* and 16 *Free*, plus an
  orphaned `*ee` fragment and mangled `** **` markup where the replace ran
  through formatting. The flyer now advertises *"an expensive personal PC
  security guide"* three lines above *"100% Free"* and *"we never ask for
  money"*.
  **Not caused by the 2026-08-13 open-source sweep** -- the count was 9
  before that commit, 9 after, and `git log -S` traces it to the initial
  commit of 2026-07-28. **Do not quote any pricing or free-vs-paid wording
  out of this document until it is repaired.**
- **One accuracy problem nobody has raised:** the community flyer text in
  `Marketing-Notes.md` opens *"Brought to you by independent tech
  volunteers"*. GatewayGuard LLC is a Maine company selling a product.
  That wording is not defensible and is a bigger exposure than the
  open-source claim was.
- **Slide 8 promises `gatewayguard.co/sources`** -- *"All marketing claims
  are sourced and verifiable. Links published at gatewayguard.co/sources"*.
  That page does not exist. Either build it or drop the sentence.

---

## Layman Positioning Statement

**Source file:** `Marketing\GatewayGuard_LaymanPositioning-2026-07-16.docx`
**Note:** The default voice for ALL GatewayGuard writing (ProjectInstructions, WRITING AUDIENCE DEFAULT).

```text
<!-- Dated: 2026-07-16 18:45 EDT -->
GatewayGuard — Positioning Statement (Plain English)
For: General public, non-technical users, seniors, families
Audience rule: Would a non-technical neighbor understand this in 5 seconds?
What is GatewayGuard?
GatewayGuard is a fully auditable tool that turns on the powerful security features already built into Windows 11 Home and Pro. It is not an antivirus program, and it does not replace one. It does not slow down your computer, cause lag, or collect your data. Instead of installing mysterious hidden software, it simply sets up the professional-grade protections Windows already includes — and explains every change in plain English.
The entire program is written in plain, readable text. You can open it in Notepad and read every line before you run it. Nothing is hidden.
What does it do?
Checks 19 security settings — antivirus, firewall, drive encryption, automatic updates, and more. Shows you exactly what it found.
Fixes what needs fixing — with your approval — nothing changes without you saying so. It explains each issue and asks before making any change.
Tells you exactly what it changed — plain-English summary of every change and why. No mystery, no guesswork.
What it does NOT do
Does not uninstall or change any of your apps
Does not read, move, or delete your files
Does not collect your passwords or personal data
Does not make changes without asking you first
Does not make changes you cannot reverse
Does not require a subscription, renewal, or ongoing fees
Does not run in the background or start automatically
Does not send anything over the internet
Why IT professionals and security reviewers trust it
Zero-bloat design. Acts only as a setup tool for built-in Windows security features. When it finishes, it shuts off completely. Nothing runs in the background afterward.
Total code transparency. Written in plain, readable text scripts. Anyone — from everyday users to security experts — can open it and read line by line exactly what it changes before running it.
You are in control. Never makes major changes or restarts your computer without warning. For big actions (like a deep boot-time scan), it stops and asks your permission first.
Plays well with other software. Does not try to replace your current protection. If it detects other security tools (like Malwarebytes), it adjusts to work alongside them.
Feature
GatewayGuard
Typical Paid Antivirus Suite
Can you see the code?
100% auditable — plain text anyone can read, line by line
Hidden — locked in program files you cannot inspect
Impact on your PC
Runs only while changing a setting, then shuts off completely
Runs constantly in the background, using processor and memory
How it protects you
Strengthens the defenses Windows already includes
Adds its own separate scanning engines on top of Windows
Your privacy
Sends nothing over the internet. Never tracks your behavior
Many collect usage data and send it to their own servers
Cost
$19.99 once. No subscription, no renewal
Typically $30–$90/year, renewing automatically
Pricing
Tool + Guide bundle: [price TBD — confirm $29.99 before publishing]
Tool only: $19.99, one-time
Step-by-step Security Guide (PDF): $8.99, one-time — includes five print sizes (12, 14, 16, 18, and 20 pt)
Annual updates: $12.99/year — keeps the tool current after major Windows releases
No subscription. No auto-renewal. No account required to download.
GatewayGuard LLC · Brunswick, Maine · gatewayguard.co · Dated: 2026-07-16 18:45 EDT
```

---

## Expert / B2B Positioning Statement

**Source file:** `Marketing\GatewayGuard_ExpertPositioning-2026-07-16.docx`
**Note:** The named exception -- technical audiences. Also states the open-source ban correctly; do not 'fix' it.

```text
<!-- Dated: 2026-07-16 18:45 EDT -->
GatewayGuard — Technical Positioning Statement
For: IT professionals, security reviewers, technical media, sysadmins
Audience: Use precise technical language appropriate to this audience.
Overview
GatewayGuard is a source-available, no-redistribution PowerShell framework that enforces native Windows 11 Home and Pro security baselines without the overhead, telemetry, or system degradation associated with traditional consumer security suites. By automating the configuration of built-in OS controls — Memory Integrity (Core Isolation), BitLocker/Device Encryption, Defender hardening, local access policy, and native backup infrastructure — it replaces opaque third-party software with transparent, verifiable system hardening.
The entire execution logic is delivered as fully commented, plaintext PowerShell scripts under a source-available, no-redistribution license. Security analysts and system administrators can audit every registry modification, policy toggle, and cmdlet call prior to deployment. The code is included with every purchase — open it in any text editor.
Key anchors for technical reviewers
Zero-bloat architecture. Acts strictly as a configuration engine for native Windows APIs and cmdlets (e.g., Start-MpWDOScan, Manage-BDE, Set-MpPreference). Zero ongoing background processing, zero persistent services, zero permanent resource footprint. Execution-only.
Source-available, fully auditable. Complete source in plaintext PowerShell. No compiled binaries, no DLLs, no obfuscated execution paths. The source-available, no-redistribution license permits full audit prior to deployment. This is not an open-source license — redistribution is prohibited — but every line of logic is readable before the tool runs.
User-gated automation. Critical interventions — offline boot scan initiation, BitLocker provisioning, protection history modification — require explicit interactive confirmation loops. No unhandled reboots, no silent state changes.
Layered security coexistence. Detects installed security tools (Malwarebytes Premium, Trial, Free, and absent states; Defender configuration) and optimizes configuration posture accordingly, rather than conflicting with or replacing existing layered defenses.
State-matrix awareness. Branches on machine state (encrypted/unencrypted, MB tier, Pro/Home edition) tested across all branches before release. Build gate enforced: no release without state-matrix test coverage logged.
Attribute
GatewayGuard
Standard Consumer AV Suites
Code visibility
Source-available, plaintext PowerShell — full audit before execution
Proprietary compiled binaries (.exe / .dll) — no inspection possible
System footprint
0% continuous CPU/RAM — execution-only, shuts off on completion
Persistent background services, filter drivers, scheduled tasks
Mechanism
Hardens native OS kernel and policy controls via built-in Windows APIs
Signature hooks, proprietary scanning engines, third-party kernel drivers
Data privacy
Zero telemetry — no outbound network calls of any kind
Frequent behavioral data harvesting; cloud-reported threat telemetry
Redistribution
Source-available, no-redistribution license (auditable, not OSS)
Proprietary — neither source nor redistribution permitted
Deployment model
User-run, interactive, approval-gated — no silent deployment
Background daemon, auto-update, cloud-managed policy push
Licensing — important distinction
GatewayGuard is not open-source. The correct terms: source-available, fully auditable, no-redistribution. The source is included with every purchase and readable in any text editor. Redistribution, resale, or derivative works are prohibited under the license. Do not describe GatewayGuard as open-source in any technical review or media coverage — it is an easily-disprovable claim and we will correct it.
Target environment
Windows 11 Home and Pro. Tested on consumer hardware (HP Notebook 17, Dell Latitude 5430, Lenovo IdeaPad). PowerShell 5.1 (inbox, no upgrade required). Signed with Sectigo OV Code Signing Certificate — no SmartScreen warnings on download.
GatewayGuard LLC · Brunswick, Maine · gatewayguard.co · Dated: 2026-07-16 18:45 EDT
```

---

## ACBL Pitch Email

**Source file:** `Marketing\GatewayGuard_ACBL_Pitch-2026-07-16.docx`
**Note:** Outreach draft. Carries its own editorial notes at the end.

```text
<!-- Dated: 2026-07-16 18:45 EDT -->
ACBL Pitch Email — GatewayGuard
Channel: American Contract Bridge League — leadership / member benefits outreach
Note: Confirm ACBL member discount offer and contact name before sending.
Draft email
Subject: Helping ACBL Members Play Online With a Safer PC
Dear [ACBL Executive Director / Member Benefits Team],
I'm an ACBL member [Member # ___] and a Windows 11 security researcher based in Brunswick, Maine. I've spent the past year building a tool specifically for everyday Windows 11 users — the kind of people who want their PC protected without needing an IT degree.
I'm reaching out because the overlap with your membership is hard to ignore.
The problem your members face
When ACBL play moved online — BBO, RealBridge, club games — members' home PCs became the connection point for every hand they play. Most of those PCs are running Windows 11 with factory-default security settings, which means they're missing protections that Windows itself already includes and that Microsoft expects to be turned on.
The result: members are more vulnerable to the malware, phishing, and account-takeover attacks that specifically target older adults. A compromised PC doesn't just put a member at risk — it affects connection stability during play, exposes ACBL login credentials, and in some cases introduces unauthorized software onto a machine that's actively in a sanctioned game.
What GatewayGuard does
GatewayGuard walks a Windows 11 user through 19 security settings — checking what's on, fixing what needs fixing with the member's approval, and explaining every change in plain English. It takes about 30 minutes. It doesn't install anything that stays on the computer afterward. The member sees exactly what it does, in language that doesn't require a technical background.
The entire program is written in plain, readable text — anyone can open it and read what it does before running it. That transparency is the product's core promise, and it matters to the ACBL demographic more than almost any other audience.
Why this fits the ACBL
Your members are the target demographic. Retired, playing regularly online, often sole caretakers of their own PC security. Cybercriminals know this and target them specifically.
Fewer tech problems during play. A properly hardened Windows PC has fewer background interference issues, malware-caused slowdowns, and unexpected disconnections — fewer disrupted pairs, fewer calls to club directors.
No IT knowledge required. The guide and tool are written in plain English throughout. Members don't need to know what a firewall is to follow the steps.
No subscription, no ongoing commitment. One-time purchase. Nothing auto-renews. No account required.
What I'm proposing
I'd welcome a conversation about any of the following — whatever makes sense for the ACBL:
[Option A] Bridge Bulletin or ACBL website tech column: A short "Protect Your PC Before You Play" piece — educational, ACBL-branded, links to the guide.
[Option B] Member discount: A special ACBL-member price on the tool and guide — [discount TBD, confirm before sending]. Trackable with a member-specific code.
[Option C] Club pilot: A small group of club managers or a virtual club tries the tool first, provides feedback, and becomes the case study.
I'm not asking for an endorsement. I'm asking for ten minutes to show you what the tool looks like and whether there's a way to get it in front of members who would benefit from it.
Thank you for the work the ACBL does keeping bridge accessible and fairly run.
William F. Burns III (Bill)
GatewayGuard LLC · Brunswick, Maine
gatewyaguard.co · william.wfbiii@gmail.com
ACBL Member # [___]
Internal notes (not for sending)
Remove all Gemini-suggested 'zero-touch' / 'one-click' language — contradicts the product's approval-gated model
'Elevates Fair Play & Tournament Integrity' claim removed — GatewayGuard does not detect bots or screen-viewers; the defensible claim is reduced malware/account-compromise risk
Free version / basic version offer removed — no free tier in current pricing model; use [ACBL-member discount] bracket instead
'Support Jitters' corrected to 'fewer tech support calls' — jitters was a typo in the Gemini draft
Confirm member number, contact name, and any offered discount before sending
Assisted sessions are NOT offered at launch — do not add back to this email
GatewayGuard LLC · Brunswick, Maine · gatewayguard.co · Dated: 2026-07-16 18:45 EDT
```

---

## ACBL Marketing Plan

**Source file:** `Marketing\ACBL Marketing PLan.docx`
**Note:** Campaign plan.

```text
﻿ACBL MArketing Conversation with Gemini
how would you pitch to the ACBL, the security guide and automated settings program, to encourage their players who use windows 11 home or pro to checkout the products I am developing to help them secure their windows computers, which in turn helps the ACBL with all the online connections thier users do with perhaps not well protected windows PCs.
To successfully pitch your security guide and automated settings program to the American Contract Bridge League (ACBL), your core strategy should focus on a win-win partnership: protecting the integrity of online bridge play while safeguarding a demographic that is heavily targeted by cybercriminals.
When bridge moved online (via BBO, RealBridge, and Club games), players' home computers became the primary gateway to ACBL's digital ecosystem. A compromised Windows PC doesn't just put the player at risk—it poses a security threat to tournament integrity, billing systems, and online platform connections.
Here is a strategic approach and a ready-to-use pitch email tailored for ACBL leadership.
💡 The Strategy: Three Pillars of the Pitch
Protecting Game & Club Integrity: A secure connection prevents bad actors or unauthorized software (like bots or unauthorized screen-viewers) from compromising fair play.
Reducing Tech Support Overhead: Well-configured, secure Windows PCs experience fewer crashes, malware interruptions, and connection drops, saving club directors and the ACBL support desk valuable time.
Peace of Mind for Members: The ACBL has a deeply loyal, often retired demographic that appreciates straightforward, jargon-free tools to protect their digital lives without needing an IT degree.
✉️ Draft Pitch to ACBL Leadership
Subject: Protecting Online Bridge: A Turnkey Security Initiative for ACBL Members
Dear [ACBL Executive/Marketing Director Name or Department],
As online duplicate bridge continues to be a vital cornerstone of the ACBL community, ensuring secure, uninterrupted play is more important than ever. Every day, thousands of members connect to ACBL-sanctioned games from home PCs—many of which run standard Windows 11 Home or Pro configurations with default settings that leave them vulnerable to malware, tracking, and performance issues.
A compromised player computer doesn't just threaten that individual's privacy; it introduces security risks to tournament integrity, stable connections, and the online platforms we rely on.
To help address this, I have developed a Windows 11 Security Guide and Automated Settings Program designed specifically for everyday users who want robust protection without the complexity.
I would love to explore how we can share these tools with ACBL members to help them secure their devices. Here is why this partnership is a win for the ACBL:
Elevates Fair Play & Connection Stability: Securing players’ Windows environments reduces background system interference, malware, and unauthorized remote access, ensuring cleaner, more reliable connections during critical tournaments.
Reduces Director & Support Jitters: Fewer system-level glitches on players' ends means fewer disconnected pairs, less tournament disruption, and reduced technical support queries for your team.
Empowers a Vulnerable Demographic: Cybercriminals heavily target seniors and retirees. By offering a straightforward, automated way to harden Windows 11 security, the ACBL can provide a massive value-add to its membership, reinforcing your commitment to their digital well-being.
How We Can Collaborate:
Educational Outreach: We could feature a "Tech Tip" column in the Bridge Bulletin or on the ACBL website focusing on basic home PC security.
Member Benefits Program: Offer a special ACBL-member discount or a free basic version of the security guide/settings program to encourage widespread adoption.
I would welcome a brief 10-minute call to show you how the automated program works and discuss how we can customize this resource to benefit the ACBL community.
Thank you for your time and your continued dedication to keeping our game safe, fair, and fun.
Best regards,
[Your Name]
ACBL Member #[Your Member Number, if applicable]
[Your Contact Information]
[Link to Your Product/Website]
🛠️ Key Tips for Your Discussion
Emphasize "Zero-Touch" Simplicity: ACBL decision-makers might worry that a "security program" will cause more tech support calls. Emphasize that your automated settings program is a one-click/low-touch solution that configures built-in Windows 11 settings rather than adding heavy, confusing third-party software.
Focus on the "Built-in" Angle: Let them know your program leverages Windows 11's existing, robust security features (like turning on dormant Windows Defender settings, isolating core processes, and tightening privacy) so players don't have to purchase expensive subscription software.
Offer a Pilot: Suggest letting a small group of local club managers or a specific virtual club try the program first to gather feedback and build a case study.
Sharing “New Tab”
Skip to the latest Gemini result
```

---

## Reworked Customer Wording

**Source file:** `Marketing\Reworked Customer Wording.docx`
**Note:** Customer-facing phrasing pass.

```text
﻿Reworked Customer Wording
The current version sounds like we're covering ourselves legally at their expense. Here's a friendlier approach that still protects you:
Instead of:
"GatewayGuard is not responsible for security issues arising from settings applied against our recommendations."
Say:
================================================================ HEADS UP -- A FEW OF YOUR SELECTIONS DIFFER FROM WHAT WE RECOMMEND FOR MOST HOME USERS ================================================================ Item 13: Edge Startup Boost -- we suggest OFF to save RAM and reduce background activity. You have it ON. Item 19: Wake on LAN -- we suggest OFF to reduce remote access risk. You have it ON. That is completely fine -- you know your setup better than we do. We just want to make sure these were intentional choices and not accidental selections. If you are unsure, press N to go back and review. If these are intentional, press Y to continue. Either way, your choices will be noted in your log so you have a record of what was applied and when. Continue with current selections? (Y = yes / N = go back): ================================================================
Key differences:
"Heads up" not "Notice" — friendly not formal
"We suggest" not "recommended" — collaborative not prescriptive
"You know your setup better than we do" — respectful, empowering
"We just want to make sure these were intentional" — caring not defensive
No mention of liability or responsibility — that stays in ToS only
"Either way your choices will be noted" — transparent without threatening
Only two options Y/N — not Y/N/confirm — simpler
Log entry wording:
[NOTED] User chose to proceed with non-default setting: Wake on LAN ON[NOTED] User confirmed this was an intentional choice
NOTED instead of WARN — neutral, factual, non-accusatory.
One More Question Before Building
Q: Where should the non-recommended warning appear? A: all 3 keep it short
Q: Which items trigger the non-recommended warning? A: at least 1, not sure about others what do you think
Q: For the non-recommended warning - how much detail? A: #2
Good choices. My thoughts on which items trigger the warning:
My Recommendation on Trigger Items
Definitely trigger warning (security critical — real risk if wrong):
#2 Defender Real-Time Protection — off = no AV
#3 Tamper Protection — off = malware can disable Defender
#7 Firewall — off = network wide open
#8 BitLocker — skipping = unencrypted drive
#16 Memory Integrity — off = kernel attack surface
Trigger warning only if user manually turns OFF a default-ON item:
#4 SmartScreen
#6 Phishing Protection
#11 Advertising ID
#12 Diagnostic Data
#17 Password on Wake
Never trigger warning (convenience items, user preference):
#1 Windows Update (always recommended on, no scenario to warn)
#9 Windows Hello (manual only, can't automate)
#10 Remote Desktop (N/A on Home)
#13 Edge Startup Boost
#14 Widgets
#15 Edge Password Saving
#18 Fast Startup
#19 Wake on LAN
Summary of All Decisions
Decision
Answer
Warning location
All 3 stages, kept short
Warning triggers
Security-critical items (#2,3,7,8,16) + any default-ON item turned OFF
Warning detail
Y=proceed, N=go back, S=see explanation
Already correct items
Auto-deselect + show GOOD + user can re-select
BitLocker when OFF
Default deselected, time warning, manual instructions at end
Windows Hello
Brief instructions + guide link
Command order
R first, A after
Non-recommended wording
Friendly "heads up" approach
Log entry
NOTED not WARN
Colors
Red for manual items (#3, #9)
Ready to build ascii7 now — this will be a substantial rewrite. Shall I proceed?
can we check ram and say 'you have only minimal ram of 8GB or mediium ram of 16 MB if they have more ram then that just the wimple warming; also change either way line to "For your protection, we keep a record of your choices" or something like it
Both good additions. On RAM:
RAM Check Logic
RAM
Message
8GB or less
"Heads up: Your PC has minimal RAM (8GB). We recommend scheduling scans and heavy operations for overnight when the PC is idle."
16GB
"Your PC has moderate RAM (16GB). Most operations will run smoothly."
32GB+
No message — just proceed
This check runs right after edition detection and feeds into BitLocker timing warning and scan scheduling advice.
Revised "Either Way" Line
Your suggestion is better — here's a slightly refined version:
"For your protection, your choices and the time they were made are recorded in your personal security log."
Keeps the "for your protection" framing (positive, customer-focused) and adds "the time they were made" (subtly reinforces the timestamp without sounding threatening).
```

---

## Family Presentation v3

**Source file:** `Presentation\GatewayGuard_FamilyPresentation_v3-2026-07-03.pptx`
**Note:** Slide deck. Carries two live PL-4 breaches -- see the header note.

```text
**Slide 1**
GatewayGuard
GatewayGuard
Stop paying for something you already own.
We will set it up and secure it correctly.
GatewayGuard LLC · gatewayguard.co · June 2026

**Slide 2**
The Problem
$10.5T
Cybercrime cost globally
2025 (Cybersecurity Ventures)
$19,372
Average victim loss per incident
(FBI IC3 Annual Report 2024)
88%
Of incidents caused by
human error (IBM 2024)
4,000 password attacks per second
81% of breaches use stolen passwords
2FA blocks 99.9% of automated account attacks — takes 5 minutes, costs nothing
Windows 11 has strong built-in defenses — but many home users never configure them
Sources: Cybersecurity Ventures · Microsoft Digital Defense Report · FBI IC3 2024 · IBM Cost of Data Breach 2024 · Verizon DBIR 2024

**Slide 3**
The Solution
CHECKS 20+
SETTINGS
Reviews every critical Windows 11 security setting — and explains what it found.
PLAIN ENGLISH
EXPLAINED
No jargon. Every setting described in terms a home user understands.
YOU APPROVE
EVERY CHANGE
Nothing changes without your permission. You stay in full control.
Reversible — every automated change can be undone
Runs completely offline — zero data collected, ever
Accompanied by a full written guide at gatewayguard.co/guide
Works on Windows 11 Home AND Pro

**Slide 4**
Market Validation — Independent Research
KEY FINDING: No current tool offers guided, educational, risk-explaining hardening for non-technical home users. This gap is real and uncontested.
Enterprise EDR Tools
Defender for Endpoint · CrowdStrike · Cortex XDR
Gap: Require IT dept. Cannot be used by home users.
Compliance Tools
CIS-CAT · MS Security Baseline · OpenSCAP
Gap: Too technical. Produce audit reports, not guidance.
Privacy / Debloat Tools
O&O ShutUp10++ · Win11Debloat · Winaero
Gap: Focus on tweaks, not security. No AV/BitLocker/firewall.
GatewayGuard fills the gap: guided, educational, reversible hardening — designed for home users who want to be safe without needing an IT department.
Source: Independent market validation research, Microsoft Copilot, June 2026

**Slide 5**
The Market Opportunity
1B+
Windows 11 users worldwide
(Microsoft, January 2026)
$47.75B
Consumer security market
(Mordor Intelligence 2026)
0
Tools offering guided home-user
hardening — the gap we fill
Closest Competitor — NoID Privacy Pro
NoID Privacy Pro
GatewayGuard
Price
$43 per device
$19.99 per device
Changes
630 applied automatically
User approves each change
Explanations
Technical documentation
Plain English for every setting
Audience
Technical users
Home users — no skills required
Human support
No public support channel
Assisted sessions planned

**Slide 6**
Business Model
$19.99
Single PC
One-time purchase.
Lifetime use on one PC.
Includes full guide access.
$34.99
Family 3-Pack
One-time purchase.
Covers 3 household PCs.
Volume savings built in.
$12.99/yr
Annual Updates
Keep GatewayGuard current
as Windows 11 evolves.
Recurring revenue stream.
Future
Assisted Session (Planned)
Real person, screen share.
Step-by-step guidance.
No competitor offers this.
GatewayGuard LLC (Maine) filed · gatewayguard.co secured · EIN application pending

**Slide 7**
What's Already Built
✓
Working PowerShell tool — 22 build iterations (ascii22), tested on real hardware
✓
3-machine test fleet — HP SANDY (Win 11 Home), Lenovo IdeaPad (Win 11 Home), Dell Latitude 5430 (Win 11 Pro)
✓
Security guide v9 — the content for the website, largely written
✓
GatewayGuard LLC (Maine) — filed via Form MLLC-6, Noncommercial Registered Agent confirmed
✓
Domain secured — gatewayguard.co registered and active
✓
Apps audit identifies suspicious software AND unused apps (6+ months inactive)
○
EIN application — in progress (IRS online, ~5 minutes)
○
Business bank account — pending EIN
○
Commercial code-signing certificate — Sectigo/DigiCert (~$200-400/yr), launch prerequisite
○
Website Phase 1 — gatewayguard.co (guide hub, download page, home)

**Slide 8**
The Marketing Story
The Tagline
'Stop paying for something you already own.' — Defender is built in. Many people don't know it's there or configured correctly.
The 2FA Hook
2FA blocks 99.9% of automated account attacks. Takes 5 minutes. Costs nothing. No other Windows tool teaches users this.
The Privacy Promise
Zero data collected — not by policy, but by design. Nothing to collect means nothing to breach. A genuine advantage in GDPR markets.
The Human Advantage
Every competitor is a tool. We plan to offer a person, too. Assisted sessions are a future differentiator on our roadmap — no one else has this planned.
All marketing claims are sourced and verifiable. Links published at gatewayguard.co/sources

**Slide 9**
The Plan
Phase 1
Now — Jul 14
Testing
ascii22 on all 3 machines
Win 11 Home + Pro
Pro-specific fixes → ascii23
Phase 2
Jul 14 — Aug 1
Beta
Real users, real hardware
Screen share sessions
Compatibility list grows
Phase 3
Aug 1 — Aug 22
Website
gatewayguard.co Phase 1
Guide + download + home
Code-signing certificate
Phase 4
Aug 22 — Sep 1
Launch Ready
Final QA
Marketing materials
Sep 1 target
Target: September 1, 2026 — one month ahead of Windows 11 26H2 launch (October 2026)

**Slide 10**
The Numbers
Assumptions
Users
Revenue
Year 1
1,000 users
$19,990
Year 2
3,000 users+
updates
$74,963
Year 3
5,000 users+
updates
$149,925
Zero advertising spend in Year 1
Beta program + word of mouth only
Annual update = natural recurring hook
5,000 users = 0.0005% of 1 billion
Competitor charges $43 — we charge $19.99 with more value

**Slide 11**
Critical Path to Launch
Jun 30
Dell Latitude 5430 arrives — 3-machine Pro test fleet complete
Jul 14
ascii23 built and tested on all 3 machines (Home + Pro)
Jul 14
Website Phase 1 QA complete — guide, home, download pages
Jul 15
EIN obtained · Business bank account opened · Domain → LLC
Jul 15
Beta tester recruitment opens at gatewayguard.co/beta
Aug 1
Code-signing certificate obtained and applied to build
Aug 22
Final integration QA — tool + website + marketing materials
Sep 1
LAUNCH — 26H2-ready, fully signed, website live

**Slide 12**
GatewayGuard
GatewayGuard
The gap is real.
The market is enormous.
The timing is right.
The product works.
gatewayguard.co · GatewayGuard LLC · william.wfbiii@gmail.com
```

---
