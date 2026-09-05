<!-- Dated: 2026-08-15 18:38 ET -->
# GatewayGuard Security Guide — REWRITE DRAFT

- **Document Name:** GatewayGuard_GuideRewrite-Draft
- **Last Modified:** 2026-08-15 18:38 ET
- **Last Editor:** Claude.ai (Cloud)
- **Machine:** CGDELL
- **Status:** DRAFT FOR REVIEW — not a replacement for `windows_security_walkthrough_guide_v9.docx` until Bill approves
- **Source:** `ProjectDocs/GatewayGuard_GuideV9-SourcePack-2026-08-15-1436.md` (68,879-byte source, 9,363 words)
- **Change History Log:**
  - 2026-08-15 18:38: Created. Full rewrite for the senior reader per Bill's 2026-08-13 audience decision. Six open decisions applied as recommendations, each marked **[DECISION]** in place.
  - 2026-08-15 18:38 (same session): Reconciled against `WebSite/html/` and `ProjectDocs/GatewayGuard_WebsiteSourcePack-2026-08-15-1751.md` under RULE W-07. Twelve corrections applied — see RECONCILIATION below.

---

## READ THIS BEFORE THE DRAFT — what changed and why

**Six decisions were open from `GuideRewritePlan-2026-08-13-2207.md`. I applied my recommendation for each rather than stall.** Every one is marked **[DECISION]** at the point it takes effect, so any single reversal is a local edit and not a rewrite.

| # | Decision | Applied |
|---|---|---|
| 1 | Phase 4 — Avira | **Cut.** Generalised into Step 2 as "another antivirus that will not uninstall" |
| 2 | Phase 3 — incident response | **Gated.** Full procedure kept, behind a stop-and-decide page |
| 3 | PowerShell / Task Scheduler | **Walled.** Moved to "Advanced — optional" at the back |
| 4 | Cross-reference to the tool | **Yes, light.** Named per the Checkup Name Rule; links to the free pages |
| 5 | Advertising ID / Diagnostic data | **Reconciled.** Presented as privacy choices with a recommendation, matching what Checkup does |
| 6 | Glossary hardware terms | **Trimmed.** SO-DIMM, DDR4/DDR5, MPN, page file removed |

**Also applied throughout:**

- **Audience.** Every "the user" is gone. The reader owns this PC. Where v9 said *"ask the user first,"* the replacement is *write it down and change nothing yet* plus a route to help.
- **Naming.** All 19 names follow `NamingStandard-2026-08-09-1345.md` and N-07 capitalization. **The two named exceptions are preserved and must not be "corrected"** — Enhanced Phishing Protection, BitLocker Data Encryption.
- **Coverage.** The three absent settings are written: Defender Periodic Scanning, Fast Startup, Wake on LAN. The four thin ones are expanded: Enhanced Phishing Protection, Remote Desktop, Advertising ID, Diagnostic Data.
- **Rules.** No "whether", no "whereas", no "switch" as a verb, no superlatives. "Open-source" survives once, in the Chromium glossary entry, where it is factually correct.
- **Stopping points.** Marked at the end of each phase. v9 asked for 1–3 hours unbroken with no breaks marked.
- **Identity.** Cover, publisher, copyright, edition label, version date — none of which existed.

## RECONCILIATION AGAINST THE 19 WEBSITE PAGES — RULE W-07

**Twelve corrections applied.** The website pages are further along than v9 was, and on these points they were right and the draft was wrong or thin.

| # | Setting | Correction |
|---|---|---|
| 1 | Fast Startup | Path was incomplete — **Hardware and Sound** was missing, and **Shutdown settings** was not named |
| 2 | Fast Startup | Added the greyed-out-boxes warning; readers get stuck there |
| 3 | Fast Startup | "A few seconds" replaced with the measured **ten to thirty seconds** |
| 4 | Fast Startup | **Removed a false instruction** — the draft said restart afterwards. It takes effect at the next shutdown |
| 5 | Fast Startup | Added the note that scan reminders are unaffected |
| 6 | Wake on LAN | **Tone corrected.** The draft said turn it off. The tool keeps this item unselected by default — it is a choice, not a harden |
| 7 | Wake on LAN | Added the **magic packet** option for readers who keep it on |
| 8 | Wake on LAN | Added the definite answer on pre-Windows startup screens — **W-08 forbids the dead end** the draft left |
| 9 | Wake on LAN | Added "no restart needed", and that both adapters must be done |
| 10 | Wake on LAN | Added the **remote-access scam warning**, FTC-sourced, carried from the tool |
| 11 | BitLocker | Added the **Windows 11 Pro path** and the Manage BitLocker check; added initial encryption time |
| 12 | BitLocker | Recovery key: **four storage options, at least two**, and saved **before encryption finishes** |

**Plus a systematic gap the website exposed: the guide had no undo instructions anywhere.** The website template carries *How to revert it* on all 19 pages. Added to Fast Startup, Wake on LAN, Advertising ID, Diagnostic Data and Remote Desktop.

### Two things on the live site that need your decision — not fixed here

**The page footers say "Source code is included with every download."** Under the source-available licence that may be accurate, but `WebsiteStandards` requires "source-visible" or "fully auditable" rather than anything that reads as open-source. Worth a consistent phrase across the site and the guide.

**The same footers say "No subscription — ever."** Annual updates are priced at $12.99/yr. Optional updates are not a subscription, but the line invites the comparison and a buyer may feel misled. Worth rewording before launch.

---

**Still needed before this ships, and not in my hands:** the Table of Contents and index page numbers must be generated in Word (that defect exists at source, not just in the export), the five editions regenerated together, and every measurement re-verified by Claude Code.

---
---

# GatewayGuard Security Guide

### Windows 11 — a plain-English walkthrough for your own PC

**Compact edition — 12 pt**
Version 10 · [DATE TO BE SET AT RELEASE]

Published by **GatewayGuard LLC**, Brunswick, Maine
gatewayguard.co

© 2026 GatewayGuard LLC. All rights reserved.
This guide is licensed for personal use by the purchaser. Please do not
redistribute it.

**Larger print available.** This guide comes in five sizes — 12, 14, 16,
18 and 20 point. If this one is hard on your eyes, use a larger one. They
contain exactly the same words.

---

## What this guide is

This is a step-by-step walkthrough of the security settings on your own
Windows 11 computer. You do not need any technical background. Nothing
here assumes someone is sitting beside you.

You will check about twenty settings, one at a time. For each one, the
guide tells you where it lives, what it does, what it should be set to,
and how to change it if it is wrong.

**It also covers what to do if you find something harmful** — a family of
fake programs that has been spreading through search-engine advertising.
That part is at the back, and you only read it if you need it.

## What this guide is not

It is not a program and it changes nothing on your computer. **You make
every change yourself**, so you always know what happened.

If you would rather have those checks run for you, **GatewayGuard
Checkup** is our tool that walks through the same settings on screen and
asks your permission before each change. This guide stands on its own and
does not require it.

---

## Before you start

**Have these ready:**

- Your phone, with internet. You will use it for a few steps where signing
  in on the computer itself is a bad idea.
- Pen and paper. You will write things down.
- Your Microsoft account password, if you use one to sign in to Windows.
- Your Windows PIN.

**Set aside about an hour for the first two phases.** Stopping points are
marked. You can close the guide at any one of them and pick up later
without losing your place.

### The one rule that matters most

**If you find something you do not recognise, do not delete it. Write down
exactly what it says, and keep going.**

Some things look alarming and are perfectly normal. A few look ordinary
and are not. The wrong removal can stop your computer from working
properly, and undoing it is much harder than writing down a name.

When you have finished the checks, take your list to the *When to ask for
help* section near the front of this guide. Nothing on that list needs to
be dealt with today.

---

## When to ask for help

**This section is near the front on purpose.** Most of this guide is
routine, but a few situations are not, and it is worth knowing them before
you start rather than after.

**Stop and get help from a person if any of these are true:**

- **Money is missing**, or a bank or card account shows something you did
  not do. Call the bank first, using the number on your card — not a
  number from an email or a web search.
- **Your files have been renamed** to something strange and a message is
  demanding payment. Do not pay and do not restart the computer. This is
  ransomware and it needs someone with hands on the machine.
- **Someone is signed in to your email who is not you**, or messages you
  did not write have been sent from your account.
- **This computer is used for work.** Tell your employer's IT people
  before changing anything. They have their own procedures and may already
  be monitoring the machine.
- **Someone is harassing, stalking, or abusing you**, and you think they
  may have access to this computer. Security settings alone are not the
  answer here. In the United States, the National Domestic Violence
  Hotline is at **thehotline.org**, and the **Coalition Against
  Stalkerware** publishes guidance written for exactly this situation.
  Consider using a different device to reach them.

**Who counts as help?** A relative or friend who is comfortable with
computers. A local repair shop with a physical address and reviews you can
read. Your internet provider's support line for anything to do with the
connection itself.

**Be careful who you call.** If a pop-up, phone call, or email tells you
your computer is infected and gives you a number, that is the scam itself.
Real security warnings never ask you to phone anyone.

---

## Quick-reference table

**Every setting in this guide, and what it should be.** Use it as a
checklist now, and as a place to check back later.

The names below match what you will see on your own screen. Where Windows
shows a slightly different word, the guide says so at that step.

| # | Setting | Where it lives | Should be |
|---|---|---|---|
| 1 | Windows Update | Settings › Windows Update | Up to date, nothing waiting |
| 2 | Defender Real-Time Protection | Windows Security › Virus & threat protection › Manage settings | On |
| 3 | Tamper Protection | Same screen as above | On |
| 4 | SmartScreen | Windows Security › App & browser control | On, all parts |
| 5 | Defender Periodic Scanning | Windows Security › Virus & threat protection | On, only if you run another antivirus |
| 6 | Enhanced Phishing Protection | Windows Security › App & browser control › Reputation-based protection | On, all three parts |
| 7 | Firewall & network protection | Windows Security › Firewall & network protection | On for all three networks |
| 8 | BitLocker Data Encryption | Settings › Privacy & security › Device encryption | On, **and the recovery key saved somewhere else** |
| 9 | Windows Hello | Settings › Accounts › Sign-in options | PIN set up |
| 10 | Remote Desktop | Settings › System › Remote Desktop | Off, unless you truly use it |
| 11 | Advertising ID | Settings › Privacy & security › General | Off — your choice |
| 12 | Diagnostic Data | Settings › Privacy & security › Diagnostics & feedback | Required only — your choice |
| 13 | Edge Startup Boost | Edge › Settings › System and performance | Off |
| 14 | Windows Widgets | Right-click the taskbar › Taskbar settings | Off |
| 15 | Edge Password Saving | Edge › Settings › Profiles › Passwords | Off |
| 16 | Memory Integrity | Windows Security › Device security › Core isolation | On, if your computer allows it |
| 17 | Password Required on Wake | Settings › Accounts › Sign-in options | When PC wakes from sleep |
| 18 | Fast Startup | Control Panel › Power Options › Choose what the power buttons do | Off |
| 19 | Wake on LAN | Device Manager › Network adapters › Power Management | Off |

**Free explanations for every one of these** are at
**gatewayguard.co/guide** — one page per setting, with pictures.

---

# Phase 1 — The basics

These are the settings that protect you day to day. If you only ever do
one phase, do this one.

---

## Step 1 — Windows Update

**Why it matters.** Updates close security holes that criminals already
know about. An out-of-date computer is vulnerable to problems that were
fixed months ago.

**Where it lives:** press the **Windows key**, type **Windows Update**,
and press **Enter**.

**Read the message at the top:**

- **"You're up to date"** — good. Move on.
- **"Updates available"** or **"Restart required"** — click **Download**
  or **Restart now**, let it finish, then come back here.
- **"Checking for updates…"** — wait a moment.

**Then click "Check for updates"** anyway, to be certain.

**Click "Advanced options"** and make sure these are **On**:

- Receive updates for other Microsoft products
- Get me up to date
- Notify me when a restart is required

**Check which Windows you have.** Go to **Settings › System › About**.

- It should say **Windows 11**, version 23H2, 24H2 or 25H2.
- **If it says Windows 10**, that is a problem worth acting on. Windows 10
  stopped receiving free security updates in October 2025. If your
  computer supports Windows 11, upgrading is worth doing. If it does not,
  this is a good conversation to have with someone you trust.

**One thing to skip.** If you see an update with **"Preview"** in its
name, leave it. Those are early versions. The finished one arrives
automatically the following month.

### A note on 2026

**Two things make this year worth checking carefully.**

Windows computers built since about 2011 rely on security certificates
that began expiring in late June 2026. Microsoft has been sending
replacements through Windows Update. If your updates are current, this has
already been handled and you will never notice it.

Microsoft also released an unusually large security update in June 2026.
If your computer is asking to restart, let it.

---

## Step 2 — Windows Security

**Why it matters.** Windows has good security built in. It is called
Microsoft Defender, and for most home computers it is enough on its own.

**Where it lives:** press the **Windows key**, type **Windows Security**,
and press **Enter**.

### First, the six tiles

The main screen shows six tiles. **Each one should have a green check
mark** or say "No action needed":

- Virus & threat protection
- Account protection
- Firewall & network protection
- App & browser control
- Device security
- Device performance & health

**If any tile is yellow or red**, click it and read what it says. It will
name the specific problem. Fix that one thing, then come back. Do not move
on while a tile is still yellow.

### Virus & threat protection

Click **Virus & threat protection**, then **Manage settings**. Turn these
**On**:

- **Defender Real-Time Protection** — checks files as you open them.
- **Cloud-delivered protection** — lets Windows ask Microsoft about
  suspicious files.
- **Automatic sample submission** — sends unknown files for checking.
- **Tamper Protection** — stops other programs from turning Defender off.

**Pay attention to Tamper Protection.** Harmful programs try to turn off
your antivirus before doing anything else. If you find this turned off and
you did not turn it off, that is worth noting on your paper.

**Controlled folder access** is also on this screen. It blocks unknown
programs from changing your documents and pictures. It is genuinely
protective, and it can also block a program you actually want. **Leave it
off unless you are comfortable investigating when something stops
working.**

### Defender Periodic Scanning — setting 5

**This one only applies if you run a different antivirus.**

If another antivirus program is in charge, Defender steps aside and stops
watching. **Periodic scanning** lets Defender still run an occasional
check in the background as a second opinion, without the two programs
fighting.

**Where it lives:** Windows Security › Virus & threat protection. If
another antivirus is installed, you will see **Microsoft Defender
Antivirus options** on this screen with a **Periodic scanning** toggle.

- **Another antivirus installed** → turn Periodic scanning **On**.
- **Defender is your only antivirus** → the option is not shown, and does
  not need to be. Defender is already watching continuously.

### Firewall & network protection — setting 7

Click **Firewall & network protection**. **All three must say On:**

- Domain network
- Private network
- Public network

If any says Off, click it and turn **Microsoft Defender Firewall** on.

**Why all three?** Windows uses different rules depending on the network
you are connected to. Turning one off leaves a gap that opens the moment
you join that kind of network.

### App & browser control — settings 4 and 6

Click **App & browser control**, then **Reputation-based protection
settings**. Turn all of these **On**:

- **Check apps and files** — warns before running something unrecognised.
- **SmartScreen for Microsoft Edge** — blocks known bad websites.
- **Phishing protection** — all three parts.
- **Potentially unwanted app blocking** — both parts, Block apps and Block
  downloads.
- **SmartScreen for Microsoft Store apps**

**About Enhanced Phishing Protection — setting 6.** Your screen calls this
**Phishing protection**. Microsoft's own name for it is Enhanced Phishing
Protection, and this guide uses the longer name so you can find their
documentation if you want it.

**What it actually does is worth understanding**, because it is not the
same as the website blocking above. It watches for your **Windows
password** being typed where it does not belong — into a website, or into
another program. If you are ever tricked into typing your Windows password
into a convincing fake login page, this is the feature that warns you.

Its three parts warn you about typing your password into a bad site, about
reusing it on other sites, and about storing it in a plain text file. **Turn
all three on.**

### Device security — setting 16

Click **Device security**. If you see **Core isolation**, click into it.

**Memory integrity** should be **On**.

If Windows says drivers are preventing it, **leave it off**. Forcing it
can stop the computer from starting. This is worth revisiting after a
round of updates.

**If you turn it on, you may notice two new entries** called `vmmem` and
`vmwp` using memory. They belong to this feature and they are supposed to
be there.

### If another antivirus is installed

**[DECISION 1 — the old Phase 4, which covered only Avira, is cut. This is
the general version.]**

Go to **Settings › Apps › Installed apps** and look for names like Norton,
McAfee, Avast, AVG, Avira, Kaspersky, Bitdefender, ESET or Webroot.

**For most home computers, Defender alone is the better arrangement.** Two
antivirus programs do not add up to twice the protection — they interfere
with each other, and the one that came free with the computer is often a
trial that expired long ago and now does nothing but ask for money.

**If you want to remove one:**

1. **Settings › Apps › Installed apps**, and find **every** entry from
   that company. They often install four or five separate pieces.
2. Uninstall each one. **Be patient.** Some take ten or fifteen minutes
   per piece and look frozen while they work.
3. **If it will not uninstall**, look for a **Repair** option first. Run
   the repair, restart the computer, then try the uninstall again. A
   half-broken installation is harder to remove than a working one.
4. **If that fails**, most of these companies publish a removal tool for
   exactly this situation. Get it from the company's own website, typed in
   directly — not from a search result, and not from any site that merely
   mentions the company's name.
5. **Afterwards**, open Windows Security › Virus & threat protection and
   confirm it now says **Microsoft Defender Antivirus**.

**If Defender does not come back on by itself**, restart once. It usually
takes over as soon as it notices nothing else is in charge.

---

## Step 3 — BitLocker Data Encryption

**Why it matters.** Encryption scrambles everything on the drive so it is
useless to anyone who does not have your sign-in. Without it, someone who
takes the computer can read every file on it, without needing your
password at all.

**Your screen may call this something else.** Windows 11 Home says
**Device encryption**. Windows 11 Pro says **BitLocker Drive Encryption**.
This guide says **BitLocker Data Encryption** because "BitLocker" is the
word printed on the recovery key you may one day need.

**Where it lives:** **Settings › Privacy & security › Device encryption**.
Turn it **On** if it is off. It works in the background and you can keep
using the computer.

**On Windows 11 Pro** the path is **Settings › Privacy & security ›
Device security › BitLocker drive encryption**, and it should say
**BitLocker on** beside your C: drive.

**On either edition**, you can also press the Windows key, type
**BitLocker**, and open **Manage BitLocker**. The C: drive should show
**On**.

**What to expect.** Encryption runs in the background and does not slow
the computer down in normal use. The first time you turn it on it may
take anywhere from thirty minutes to a few hours, depending on how much
is on the drive. You can keep using the computer while it works.

### The recovery key — read this part twice

Encryption comes with a **48-digit recovery key**. Windows may ask for it
after a hardware change, a firmware update, or a repair. It is not a
warning sign when that happens — it is normal, and it is exactly when you
need the key.

**Without the key, the files are gone. Not locked. Gone.** No one can
recover them. Not Microsoft, not a repair shop, not us.

**Find your key now, before you need it:**

1. **On your phone or another computer**, go to
   **account.microsoft.com/devices/recoverykey**
2. Sign in with the Microsoft account this computer uses.
3. You should see a 48-digit key listed for this computer.

**Save it before encryption finishes**, and in **at least two** of these
places:

- **Your Microsoft account online** — account.microsoft.com/devices/recoverykey.
  If you sign in to Windows with a Microsoft account, it may already be
  there.
- **Printed on paper**, stored with your important documents.
- **On a USB stick**, kept somewhere other than the computer bag.
- **In a password manager**, saved as a secure note.

**It must not be saved only on the encrypted drive.** If the drive is what
you cannot open, a key stored inside it is no help at all.

**If the page shows no key**, press the Windows key, type **Manage
BitLocker**, choose **Back up your recovery key**, and pick **Save to a
file** or **Print**. Then check the website again to confirm it arrived.

### One situation that catches people out

**If you sign in to this computer with a local account rather than a
Microsoft account**, Windows may still turn encryption on — but there is
no Microsoft account for it to send the key to. **The key exists and is
stored nowhere you can reach.**

**How to tell:** Settings › Accounts › Your info. If it says "Local
account" and Device encryption says On, **use Manage BitLocker to back the
key up right now.** This is the one combination that quietly leaves people
without a key.

---

## Step 4 — Your account and sign-in

**Where it lives:** **Settings › Accounts › Your info**.

**Microsoft account or local account?** Either works. A Microsoft account
saves your encryption key automatically, which is a real advantage. A local
account keeps more to yourself but makes Step 3 your responsibility.

### Sign-in options — settings 9 and 17

Go to **Settings › Accounts › Sign-in options**.

**Windows Hello PIN — setting 9.** Set one up if you have not. Six digits
or more.

**A PIN is safer than a password here, which sounds backwards.** The
difference is that your PIN only works on this one computer — it is locked
to a chip inside it. Someone who learns your PIN from across the room
still cannot use it anywhere else. A password can be used from anywhere in
the world.

**Fingerprint or face** — set up if your computer has them. If it says
Unavailable, your computer does not have the hardware. That is not a
problem.

**Keep your password** as a fallback, but use the PIN day to day.

**Picture password** — leave it off.

**Password Required on Wake — setting 17.** Near the top of this screen,
find **If you've been away, when should Windows require you to sign in
again?** Set it to **When PC wakes up from sleep**.

**Why it matters:** closing the lid is how most people "put the computer
away". If it wakes straight to your desktop, then the lock on the front
door is only as good as the room the computer is sitting in.

**At the bottom of the screen**, turn on **For improved security, only
allow Windows Hello sign-in for Microsoft accounts on this device**.

### Who else can use this computer

Go to **Settings › Accounts › Other users**.

**There should be nobody here you do not recognise.** On a computer only
you use, the list should be empty.

**If you see a name you do not know: write it down exactly. Do not delete
it.** Some accounts are created by the manufacturer and removing them can
cause problems. Take the name to the *When to ask for help* section.

### Two-step verification — do this on your phone

**This one change protects every other account you own**, because your
email address is how they all reset their passwords.

1. On your phone, go to **account.microsoft.com/security**
2. Sign in.
3. Turn **Two-step verification** on.
4. Set up **at least two** methods. Best first: an authenticator app, then
   a text message, then email.
5. Find **Recovery code**, generate one, and **save it with your BitLocker
   key**.

**That last step matters more than it looks.** If you lose your phone
without a recovery code, you can be locked out of your own account
permanently.

---

> ### ⏸ STOPPING POINT
>
> **This is a good place to stop.** Everything above is the core of it.
> If you do nothing else, the computer is meaningfully safer than it was
> this morning.
>
> Phase 2 is about programs and browsers, and takes about another hour.

---

# Phase 2 — Programs and browsers

**This is where harmful software is usually found.**

---

## Step 5 — Look at what is installed

### First, tighten where programs can come from

**Settings › Apps › Advanced app settings › Choose where to get apps.**

Set it to **"Anywhere, but warn me before installing an app that's not
from the Microsoft Store"**, or stricter.

**Avoid plain "Anywhere"** — that setting installs things without ever
warning you.

### Now look at the list

**Settings › Apps › Installed apps.** Sort by **Install date**, newest
first. Anything that arrived without your knowledge will be near the top.

**Go down the list slowly.** For each one, ask: do I know what this is?

**Things worth writing down:**

- Programs you do not recognise at all
- Plain names with no company behind them — "PDF Editor", "Video
  Converter", "PC Cleaner", "Music Player"
- Extra toolbars or "search helpers"
- Antivirus trials you never used

**Before removing anything, find out who made it.** Open **Control Panel ›
Programs and Features**, which shows a Publisher column. A dull name from
a well-known company is usually something that came with your computer and
is harmless.

### Programs to remove on sight

**If you see any of these, they are harmful.** Do not open them. Go to the
*If you found something harmful* section before removing them, because the
order of steps matters.

| Name | What it is |
|---|---|
| Anything by **AppSuite** | A family of programs that gives outsiders access to your computer |
| **PDF Editor 1.x** by AppSuite | Confirmed harmful |
| **ManualFinder** | Same family |
| **OneLaunch** | Same family |
| **Wave Browser** or **Wave** | Same family |
| **Shift** browser | Same family |
| A plain **"PDF Editor"** with no company name | Very often this family |

**How people get these.** They are advertised at the top of search results
for things like "free PDF editor". They look like ordinary free programs
and install without complaint. Several security companies have confirmed
that they can steal saved passwords and let someone else operate the
computer remotely.

**Also worth removing**, though these are nuisances rather than dangers:

- **Fortect**, formerly Reimage — sells repairs for problems it invents
- **Driver updaters** and **registry cleaners** of any brand
- Antivirus trials that came with the computer and were never used

---

## Step 6 — Your browsers

**Do this for each browser you actually use.** Firefox has its own section
at the back, because its settings are arranged differently.

### Part A — Extensions

**Type this into your browser's address bar:** `chrome://extensions` for
Chrome, or `edge://extensions` for Edge.

**Every extension here should be one you chose deliberately.**

**Remove:** anything named Coupon, Shopping helper, Deal finder, Search
helper, Wave or Shift, and anything you do not recognise.

**Look at what each one is allowed to do.** "Read and change all your data
on all websites" is a great deal of power. It is reasonable for a password
manager you chose, or a well-known ad blocker. It is not reasonable for a
coupon finder.

### Part B — Search engine

**Settings › Search engine.** It should be Google, Bing or DuckDuckGo.

**If it is a name you do not recognise, that is a sign something changed
it without asking.** Set it back, then open **Manage search engines** and
delete the unfamiliar entries.

### Part C — What opens when you start the browser

**Settings › On startup.**

**Fine:** "Open the New Tab page", or "Continue where you left off".

**Not fine:** "Open a specific page" showing an address you do not
recognise. Remove it.

**If a site keeps reopening on its own**, it is one of three things: the
tab is pinned (right-click it and choose Unpin), it is listed under On
startup, or an extension is opening it — go back to Part A.

### Part D — Stop browsers running when they are closed — setting 13

**Why this matters.** Edge and Chrome are both set, out of the box, to
keep running after you close them and to start themselves when Windows
starts. This uses memory you have paid for, and it is a common reason a
computer feels slow for no obvious reason.

**Microsoft Edge — setting 13, Edge Startup Boost:**

1. Open Edge, click the **three dots** at the top right, choose
   **Settings**.
2. Click **System and performance**.
3. Turn **off Startup boost**.
4. Turn **off "Continue running background extensions and apps when
   Microsoft Edge is closed"**.
5. Close Edge completely.

**Google Chrome:**

1. Open Chrome, **three dots**, **Settings**, then **System**.
2. Turn **off "Continue running background apps when Google Chrome is
   closed"**.
3. Close Chrome completely.

**On a computer with 8 GB of memory or less**, Chrome's **Memory Saver**
is worth turning on as well — Settings › Performance. It puts tabs you are
not using to sleep.

### Part E — Choose your default browser

**Even with the settings above, Windows opens Edge** when you click a link
in Start menu search, in Outlook, or in a notification — unless you tell
it otherwise.

1. Press the Windows key, type **Default apps**, press Enter.
2. Click your preferred browser.
3. Click **Set default** at the top.

### Part F — Windows Widgets — setting 14

**The news and weather panel on your taskbar runs browser processes in the
background continuously**, even if you never open it.

1. Right-click an empty part of the taskbar, choose **Taskbar settings**.
2. Turn **Widgets** off.

### Part G — Programs that start with Windows

1. Open **Task Manager** — hold **Ctrl + Shift** and press **Esc**.
2. Click the **Startup apps** tab.
3. Look for browsers, and for anything you do not use daily.
4. Right-click each and choose **Disable**.

**Disabling here does not uninstall anything.** The program still works;
it simply waits until you ask for it.

### Part H — Saved passwords in your browser — setting 15

**Chrome:** Settings › Autofill and passwords › Google Password Manager ›
Settings.
**Edge:** Settings › Profiles › Passwords.

- **Offer to save passwords** → **Off**
- **Auto Sign-in** → **Off**

**Why turn off something so convenient?** Because anything running on your
computer can often read them. That is exactly what the programs in Step 5
are built to do. A separate password manager keeps them behind a second
lock.

**Do not delete the saved passwords yet.** Move them somewhere else first
— Phase 3 explains how. Turning off saving does not remove what is already
stored.

### Part I — Safe browsing in Chrome

**Settings › Privacy and security › Security.**

Choose **Enhanced protection** or **Standard protection**. **Never choose
"No protection".**

### Part J — Check your sync account

**Settings › You and Google › Sync.** Confirm it is signed in to your own
account and not one you do not recognise.

---

> ### ⏸ STOPPING POINT
>
> **Phases 1 and 2 are the whole routine.** Everything after this is
> either for a specific situation or optional.
>
> **If you found nothing harmful**, skip the next section entirely and go
> to *Phase 4 — Privacy choices*.

---

# Phase 3 — If you found something harmful

**[DECISION 2 — the eight-step procedure is kept in full, behind this
page.]**

---

## Stop and read this before starting

**If Step 5 turned up one of the programs in the "remove on sight" table,
this section explains what to do about it. It is longer and more demanding
than anything so far.**

**Be honest with yourself about which of these describes you:**

**Get another person involved if:**

- You are not confident about the steps in Phases 1 and 2
- You bank, invest, or do your taxes on this computer
- You have more than a handful of accounts with saved passwords
- Anything in *When to ask for help* applies to you
- You would rather not spend several hours on this

**There is no shame in that.** This section asks you to change passwords
on twenty or more accounts and to delete files from system folders. It is
work, and doing half of it is worse than not starting.

**Right now, before deciding either way, do these two things:**

1. **Disconnect from the internet.** Click the network icon near the clock
   and turn Wi-Fi off. This stops the program communicating while you
   decide.
2. **Do not sign in to your bank on this computer** until this is
   finished. Use your phone.

**If you are going ahead, work through the steps in order.** Skipping is
how things get missed.

---

## Step 1 — Remove the program

**Settings › Apps › Installed apps.** Find it, click the three dots,
choose **Uninstall**.

**Do not assume it is gone.** These programs leave pieces behind
deliberately. That is what the next three steps are for.

## Step 2 — Run an offline scan

**This scan runs before Windows finishes starting**, so it can find things
that hide from a normal scan.

1. Save your work and close everything.
2. **Windows Security › Virus & threat protection › Scan options**.
3. Choose **Microsoft Defender Antivirus (offline scan)**.
4. Click **Scan now**.

**The computer restarts within a minute**, shows a blue scanning screen
for ten to twenty minutes, then starts normally. **This is expected. Do
not turn it off.**

**When it is done**, open **Windows Security › Protection history** and
read every entry. Each should say **Quarantined** or **Removed**. If any
says **Allowed** or **Action needed**, click it and take the action
offered.

## Step 3 — Check for leftovers

**Copy each line below into the address bar of File Explorer** and press
Enter:

```
%AppData%\PDFEditor
%AppData%\AppSuite
%LocalAppData%\PDFEditor
%LocalAppData%\AppSuite
%ProgramData%\PDFEditor
%ProgramData%\AppSuite
```

**"Location not found" is the answer you want.** It means nothing is
there.

**If a folder does open:** close it, go up one level, right-click the
folder, and choose **Delete**. If Windows says it is in use, restart and
try again. Then empty the Recycle Bin.

## Step 4 — A second opinion

**Different scanners find different things.**

1. Type **malwarebytes.com** into your browser directly. **Check the
   address bar reads exactly that** before downloading anything.
2. Download **Malwarebytes Free**.
3. **During installation, decline the free trial of the Premium version.**
   Uncheck the box, or choose Skip.

**Why declining matters.** Windows allows only one antivirus to be in
charge at a time. If the Premium trial activates, it takes over and
Windows turns Defender's real-time protection off — leaving you with a
confusing arrangement when the trial ends. **The free version, used
occasionally, never does this.**

4. Run a scan. It takes twenty to forty-five minutes.
5. **Quarantine everything it finds.** It presents results in groups —
   keep clicking Quarantine until it stops asking.
6. Restart when asked.

**Afterwards, check Windows Security › Virus & threat protection still
says Microsoft Defender Antivirus.** If it does not, open Malwarebytes ›
Settings › Security and turn its real-time protection off.

**Note on the free version:** it is licensed for personal, non-commercial
use. And its Deep Scan does not check for the deepest kind of hidden
program regardless of what its settings say — which is why Step 2 comes
first and is not optional.

## Step 5 — Sign out everywhere — from your phone

**Do this on your phone**, not on this computer.

**Google:** myaccount.google.com › Security › Your devices › Sign out of
all devices.

**Microsoft:** account.microsoft.com › Security › Sign me out everywhere.

**Then check account.live.com/Activity** for sign-ins from places you have
never been.

**Why this step exists.** These programs can copy the invisible tokens
that keep you signed in. Changing a password does not always cancel those.
Signing out everywhere does.

## Step 6 — Check your email

**For each email account**, from your phone:

1. **Recent sign-in activity** — anything from a country you have not
   visited?
2. **Sent folder** — messages you did not write?
3. **Trash** — password reset emails you did not ask for?
4. **Forwarding and filters** — Gmail: gear icon › See all settings ›
   Filters and Blocked Addresses, and Forwarding and POP/IMAP.

**A forwarding rule you did not create needs acting on today.** It means someone is receiving copies of your mail, including
password resets. If you find one, remove it, change that password
immediately, and get a person involved.

**If everything looks normal**, then your passwords may have been taken
but nobody has used them yet. Step 7 is what closes that door.

## Step 7 — Change your passwords

**Assume every password saved in a browser on this computer is known to
someone else.**

**You do not have to do them all today.** Work in order of what would hurt
most.

**This week — the ones that matter:**

- Email accounts. **These first, always** — every other account resets
  through them.
- Microsoft, Google, Apple
- Banks, credit cards, PayPal
- Tax and health accounts
- Anything to do with work

**This month:** shopping sites with a card saved, and your main social
accounts.

**When you get to them:** everything else.

**For each account, ideally on your phone:**

1. Sign in with the old password.
2. Go to Security settings and change the password.
3. **Let a password manager generate the new one** — a strong password you
   cannot remember is fine, because you no longer need to.
4. **Turn on two-step verification** if offered.
5. Sign out of other sessions if the site offers it.

**Ask yourself as you go: have I used this in the past year?** If not,
consider closing the account instead. An account you never use is one more
place your details sit.

## Step 8 — Finish clearing the browser

Once your important passwords are moved, go back to Step 6 Part H and
**delete the saved passwords** from the browser's list.

---

> ### ⏸ STOPPING POINT
>
> **If you have worked through Phase 3, stop here.** Password changes are
> better done over several sittings than rushed in one.

---

# Phase 4 — Privacy choices

**[DECISION 5 — these are presented as choices with a recommendation, and
now match what Checkup does.]**

**These are not security settings** and nothing here makes your computer
easier to break into. They control how much Microsoft learns about how you
use it. Reasonable people choose differently.

**Our recommendation is to turn both down**, and Checkup does so with your
permission. Neither affects how Windows works.

## Advertising ID — setting 11

**What it is:** a number that lets apps show advertising based on what you
do on this computer.

**Where it lives:** **Settings › Privacy & security › General**.

Turn off **Let apps show me personalised ads by using my advertising ID**.

**What changes:** you see the same number of adverts. They are simply
less tailored to you. No restart is needed.

**How to undo it.** Same screen, turn the toggle back on.

**This is a preference, not a security requirement.** Leaving it on does
not put the computer at risk. The choice is yours.

## Diagnostic Data — setting 12

**What it is:** information sent to Microsoft about how the computer is
running.

**Where it lives:** **Settings › Privacy & security › Diagnostics &
feedback**.

Set it to **Required diagnostic data**, and turn off **Tailored
experiences**.

**What changes:** nothing you will notice. Windows still receives what it
needs to stay reliable.

**How to undo it.** Same screen, set it back to **Optional diagnostic
data**.

**A preference, not a security requirement**, exactly as above.

## Remote Desktop — setting 10

**This one is a security setting, and it is on this page because it is
usually off already.**

**What it is:** a feature that lets someone operate this computer from
another one, over the internet.

**Where it lives:** **Settings › System › Remote Desktop**.

**Turn it off unless you genuinely use it.** Most home users never have.
It is a door, and a door nobody uses is one that should be locked.

**How to undo it.** Same screen, turn Remote Desktop back on.

**On Windows 11 Home**, this feature is not included and you may not see
the option. That is fine — it means it was never available.

---

# Phase 5 — Two settings most guides miss

## Fast Startup — setting 18

**What it is:** a feature that makes the computer start faster by not
fully shutting down. When you choose Shut down, Windows saves part of
itself to disk and restores it next time.

**Why turn it off.** Because "shut down" no longer means shut down. Some
updates do not finish installing, and problems that a restart would clear
survive instead. On a computer with encryption, the drive is also left in
a state that is less protected than a genuine shutdown.

**You lose a few seconds of startup time. That is the whole cost.**

**Where it lives:**

1. Press the Windows key, type **Control Panel**, press Enter.
2. Go to **Hardware and Sound › Power Options › Choose what the power
   buttons do**.
3. Click **Change settings that are currently unavailable** at the top.
   Until you click this, the boxes below are greyed out.
4. Under **Shutdown settings**, uncheck **Turn on fast startup**.
5. Click **Save changes**.

**What to expect.** Starting up takes about ten to thirty seconds longer
on a modern computer, a little more on an older one. In exchange, every
start is a genuinely fresh one and updates finish installing properly.

**Your scan reminders are unaffected.** The monthly and quarterly
reminders are scheduled inside Windows and do not depend on this setting.

**How to undo it.** Same place, tick the box again, Save changes.

## Wake on LAN — setting 19

**What it is:** a feature that lets the computer be woken up over the
network while it is asleep.

**Why turn it off.** In an office this is useful — the technicians wake
machines overnight to update them. At home, nobody needs it, and a
computer that can be woken from elsewhere is a computer that can be
reached when you think it is off.

**It is also why a laptop sometimes wakes in a closed bag** and grows warm.

**Where it lives:**

1. Right-click the **Start** button, choose **Device Manager**.
2. Expand **Network adapters**.
3. Right-click your adapter, choose **Properties**.
4. Open the **Power Management** tab.
5. Uncheck **Allow this device to wake the computer**.
6. Click **OK**.

**Do this for each adapter listed** — most computers have two, one for
Wi-Fi and one for the network cable. **Turning off one and not the other
leaves the door open.**

**No restart is needed.** The change takes effect straight away.

**If a tab or option is missing**, that adapter does not support the
feature and there is nothing to turn off.

**Do I need to change anything in the startup screens before Windows
loads?** No. The Windows setting above is the one that governs this, and
it is enough. You may read elsewhere that there is also a setting in the
screens that appear before Windows starts. That is true on some
computers, and it does not override what you have just done. We do not
recommend going near those screens — they differ on every make of
computer and a wrong change there is much harder to undo.

**If you actually use this feature, keep it.** Some people turn a
computer on in another room from a phone app so it is ready when they get
there. That is a real use, and this is a recommendation rather than a
requirement — which is why Checkup asks rather than simply changing it.

**If you keep it on, make it safer.** In the same Power Management tab,
tick **Only allow a magic packet to wake the computer**. A magic packet
is a specific wake-up message meant only for your computer. With that
ticked, ordinary network traffic can no longer wake it.

**How to undo it.** Same place — Device Manager, Network adapters,
right-click the adapter, Properties, Power Management — and tick the box
again. Nothing is lost by turning it off and back on.

**One warning worth carrying with you.** Nobody legitimate will ever
phone you, or send a pop-up, asking to connect to your computer to fix a
problem you did not report. Remote-access requests that arrive out of the
blue are among the most common frauds aimed at older adults, according to
the Federal Trade Commission's *Protecting Older Consumers* report. Hang
up, and close the window.

---

# Going forward

**These habits matter more over time than any single setting.**

**Never install a free utility from a search result.** This is how nearly
all of it arrives. The advertisements at the top of the page are bought,
including by the people in Step 5. **Type a company's address in
directly**, or use the Microsoft Store.

**Use a password manager.** Look for one that encrypts so the company
itself cannot read your passwords, has a working free version or clear
pricing, has apps for every device you use, and publishes independent
security audits. Search for a comparison in the current year; this changes.

**Run Malwarebytes Free about once a month**, and decline the trial every
time.

**Run an offline scan every few months**, or any time the computer starts
behaving oddly.

**Turn on two-step verification wherever it is offered**, and save the
recovery codes with your BitLocker key.

**Look at your browser extensions a few times a year.** They accumulate.

**Keep your recovery keys off the encrypted drive.** Paper, password
manager, USB stick.

**Check the browser settings again every few months.** Windows and browser
updates have been known to turn Startup boost and background running back
on.

**Watch for these names in future:** AppSuite, ManualFinder, OneLaunch,
Wave, Shift, TamperedChef. They travel together.

## Keeping the computer from getting slow

**A slow computer is a security problem**, because a slow computer is one
people start turning protections off to speed up.

- **Look at Startup apps every few months** — Task Manager › Startup apps.
  Turn off things you do not use daily.
- **Pick one browser for daily use.** Running three at once can use
  several gigabytes on its own.
- **On 8 GB computers**, turn Chrome's Memory Saver to Maximum, and close
  chat programs like Teams, Slack, Discord and Spotify when you are not
  using them. Each uses a surprising amount.
- **If one browser is using several gigabytes**, close it and reopen it.
  It is usually one tab or one extension.

---

# If something looks suspicious — quick answers

| What you found | What to do |
|---|---|
| A program you do not recognise, from a well-known company | Probably came with the computer. Write down the name; leave it alone. |
| A program with a plain name and no company | Search the name plus the word "malware". If results agree, treat it as harmful. |
| "PDF Editor", "ManualFinder", or anything by AppSuite | Harmful. Go to Phase 3. |
| Your search engine changed to something unfamiliar | Something changed it. Reset it, and delete the entry. |
| A device you do not recognise in your Google account | Sign out of everything, change the password from your phone, turn on two-step verification. |
| An email forwarding rule you did not create | Serious. Remove it, change that password, and get help. |
| A sign-in from a country you have never visited | Serious. Same as above. |
| Windows Security says "Action needed" | Click it and do what it asks. |
| Edge keeps reopening after you close it | Recheck Step 6, Parts D, F and G. |
| A browser using several gigabytes | Close it, reopen, and look at the extensions. |

---
---

# Advanced — optional

**[DECISION 3 — the PowerShell commands and Task Scheduler steps are kept
here, behind this wall, rather than in the main walkthrough.]**

**Nothing in this section is required.** The guide is complete without it.
It is here for readers who are comfortable with technical tools, or who
have been asked for this information by someone helping them.

**If a stranger has asked you to run any of these, stop.** That is a
common way people are talked into damaging their own computers.

## Edge's scheduled tasks

Edge schedules itself to run periodically. Turning these off stops it
restarting itself in the background.

1. Press the Windows key, type **Task Scheduler**, press Enter.
2. Click **Task Scheduler Library** on the left.
3. Find entries with **MicrosoftEdgeUpdate** in the name.
4. Right-click each and choose **Disable**. **Do not choose Delete** —
   disabling can be undone.

**Edge still updates normally.** This only stops it launching itself.

## PowerShell commands

Right-click **Start** and choose **Terminal**.

List installed Store apps matching a word:

```
Get-AppxPackage *keyword* | Select Name, Publisher, PackageFullName
```

List all installed programs:

```
Get-WmiObject -Class Win32_Product | Select Name, Vendor, InstallDate
```

Remove a specific Store app:

```
Get-AppxPackage *exactname* | Remove-AppxPackage
```

## Browser addresses worth knowing

**Edge:** `edge://settings/system` · `edge://extensions` ·
`edge://settings/help`

**Chrome:** `chrome://settings/system` · `chrome://settings/performance` ·
`chrome://extensions` · `chrome://settings/searchEngines`

## Folder shortcuts

| Type this | It means |
|---|---|
| `%AppData%` | C:\Users\yourname\AppData\Roaming |
| `%LocalAppData%` | C:\Users\yourname\AppData\Local |
| `%ProgramData%` | C:\ProgramData |
| `%UserProfile%` | C:\Users\yourname |

## Websites worth bookmarking

- **account.microsoft.com/devices/recoverykey** — your BitLocker key
- **account.microsoft.com/security** — two-step verification
- **myaccount.google.com** — Google account security
- **haveibeenpwned.com** — check your email against known breaches
- **gatewayguard.co/guide** — free explanations for all nineteen settings

---
---

# Firefox

**Skip this section if you do not use Firefox.**

Firefox arranges its settings differently, so it gets its own walkthrough.
**Type each address below into the address bar** and press Enter.

**F1 — Extensions.** `about:addons` › Extensions. Same rules as Step 6
Part A: remove anything you did not choose. Check Themes and Plugins too.

**F2 — Tracking and safe browsing.** `about:preferences#privacy`. Set
Enhanced Tracking Protection to **Strict**. Further down, confirm all four
boxes under **Deceptive Content and Dangerous Software Protection** are
ticked. Turn on **HTTPS-Only Mode** for all windows.

**F3 — Search engine.** `about:preferences#search`. Confirm it is a name
you know, and remove unfamiliar entries below.

**F4 — Startup.** `about:preferences`. Untick **Open previous windows and
tabs**.

**F5 — Data collection.** `about:preferences#privacy`, then **Firefox Data
Collection and Use**. Untick all three boxes.

**F6 — Sponsored content.** `about:preferences#home`. Untick **Recommended
by Pocket**, **Sponsored stories** and **Sponsored shortcuts**.

**F7 — Encrypted DNS.** `about:preferences#privacy`, at the bottom. Choose
**Increased Protection**. This hides which websites you look up from your
internet provider.

**F8 — Profiles.** `about:profiles`. There should be one profile, or only
ones you created. **If you see an unfamiliar profile, do not remove it —
write down what it says.** Some harmful programs create a second Firefox
profile to collect information quietly.

**F9 — Updates.** `about:preferences#general`. Leave **Automatically
install updates** on.

**F10 — Saved passwords.** `about:preferences#privacy` › Logins and
Passwords. Untick **Ask to save logins and passwords**. Move existing ones
to a password manager before deleting them.

**F11 — If Firefox feels slow.** `about:performance` shows which tab or
extension is responsible.

### Firefox quick reference

| Setting | Where | Should be |
|---|---|---|
| Open previous windows and tabs | `about:preferences` | Off |
| Enhanced Tracking Protection | `about:preferences#privacy` | Strict |
| Deceptive content protection | `about:preferences#privacy` | All four on |
| HTTPS-Only Mode | `about:preferences#privacy` | On, all windows |
| Data collection | `about:preferences#privacy` | All off |
| Pocket and sponsored content | `about:preferences#home` | All off |
| Search engine | `about:preferences#search` | One you recognise |
| Encrypted DNS | `about:preferences#privacy` | Increased Protection |
| Saved passwords | `about:preferences#privacy` | Off |
| Profiles | `about:profiles` | Only ones you know about |

---
---

# Words you may meet

**[DECISION 6 — memory-upgrade terms removed. They belong to a different
conversation.]**

**Two-step verification (2FA)** — Signing in with two things instead of
one: your password, plus a code from your phone. It stops nearly every
attempt to break into an account using a stolen password.

**AppSuite** — The company name behind a family of harmful programs.
Anything from AppSuite should be treated as dangerous.

**Authenticator app** — A phone app that produces a fresh six-digit code
every thirty seconds, used for two-step verification. Safer than receiving
a code by text.

**BitLocker** — Windows' built-in encryption. Scrambles the drive so it
cannot be read without your sign-in.

**BitLocker recovery key** — A 48-digit number Windows creates when
encryption is turned on. Needed if Windows ever cannot unlock the drive on
its own. **Must be stored somewhere other than that drive.**

**Chromium** — The open-source engine underneath Chrome, Edge, Brave and
several other browsers. Programs like Slack and Teams are built on it too,
which is why they use so much memory.

**Cloud-delivered protection** — Lets Defender ask Microsoft's servers
about a file it has not seen before.

**Controlled folder access** — Stops unapproved programs changing your
documents and pictures. Strong protection against ransomware, and
occasionally blocks something you wanted.

**Defender** — Microsoft Defender, the security software built into
Windows. Antivirus, firewall and web protection together.

**Encryption** — Scrambling information so it is meaningless without the
key.

**Extension** — A small add-on that changes how your browser behaves. Some
are useful; some read everything you do.

**Firewall** — Controls which connections in and out of your computer are
allowed.

**Memory Integrity** — A Windows feature that walls off the core of
Windows from harmful software. Also called Core isolation.

**Offline scan** — A scan that runs before Windows finishes starting, so
it can find things that hide during normal use.

**Password manager** — A program that stores your passwords behind one
strong password, and creates new ones for you.

**Phishing** — A message or website pretending to be someone you trust, to
get you to type your password.

**PIN** — A short code that signs you in to one specific computer. Safer
than a password here, because it works nowhere else.

**PUP — Potentially Unwanted Program** — Not quite harmful, not welcome
either. Fake cleaners, nuisance toolbars, programs that arrive alongside
something else.

**Ransomware** — Software that locks up your files and demands payment.

**Real-time protection** — Defender checking each file as it is opened or
downloaded, rather than only during a scan.

**SmartScreen** — Warns you before opening a website or program with a bad
reputation.

**Startup boost** — An Edge feature that starts Edge quietly when Windows
starts.

**Tamper Protection** — Stops other software turning Defender off. Harmful
programs try this first.

**TamperedChef** — The name security researchers gave the family of
harmful programs described in Step 5.

**Task Manager** — The Windows tool showing what is running. Ctrl + Shift
+ Esc.

**TPM** — A chip inside the computer that stores encryption keys safely.
BitLocker and your PIN both rely on it.

**Widgets** — The news and weather panel on the taskbar. Runs browser
processes in the background even when unopened.

**Windows Hello** — Windows' sign-in system using a PIN, fingerprint or
face.

**Windows Update** — How Windows repairs security problems. The single
most important thing to keep current.

---

**End of guide.**

*This guide describes procedures carried out on real Windows 11 computers,
including removal of the AppSuite "PDF Editor" family, removal of
conflicting antivirus software, and browser background-activity
prevention.*

*GatewayGuard LLC · Brunswick, Maine · gatewayguard.co*
*© 2026 GatewayGuard LLC*
