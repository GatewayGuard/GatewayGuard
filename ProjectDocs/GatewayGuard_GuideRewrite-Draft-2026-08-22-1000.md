<!-- Dated: 2026-08-22 10:00 ET -->
# GatewayGuard Security Guide — REWRITE DRAFT

- **Document Name:** GatewayGuard_GuideRewrite-Draft
- **Last Modified:** 2026-08-22 10:00 ET
- **Last Editor:** Claude.ai (Cloud)
- **Machine:** CGDELL
- **Status:** DRAFT FOR REVIEW — not a replacement for `windows_security_walkthrough_guide_v9.docx` until Bill approves
- **Supersedes:** `GatewayGuard_GuideRewrite-Draft-2026-08-19-1753.md`
- **Absorbs:** `GatewayGuard_GuideFT220-Sections-2026-08-21-1445.md` (all four settings, all VERIFY markers preserved)
- **Source:** `GatewayGuard_GuideV9-SourcePack-2026-08-15-1436.md` (68,879 bytes, 9,363 words)
- **Written against freshness stamp:** `95dc545`, generated 2026-08-21 14:30 ET

**Change History Log:**

- 2026-08-22 10:00: **Full rewrite per Bill.** The 08-19 draft and the 08-21
  FT-220 drop-in sections are merged into one document, so there is one guide
  and not three. **Setting 17 given a step of its own** — it was in the
  quick-reference table and nowhere in the body, which is the real FT-226 gap.
  **Six sections carry RETRIEVAL GAP markers** — see section 0 below. They are
  marked rather than written, because writing them from memory would be
  fabrication.
- 2026-08-21 14:45: FT-220 sections written separately (now absorbed here).
- 2026-08-19 17:53: Self-review, five defects fixed. Gate moved after cover;
  TOC added; PL-4 heading removed; Phases 4 and 5 merged; trust ladder filed.
- 2026-08-19 09:50: Front help section reduced to a four-line gate; the rest
  moved to a *Getting help* addendum, ransomware first.
- 2026-08-15 18:38: Created. Full rewrite for the senior reader per Bill's
  2026-08-13 audience decision. Six open decisions applied as recommendations.

---

## 0. READ THIS FIRST — what is finished and what is not

### 0.1 What changed in this pass

| Change | Why |
|---|---|
| **Setting 17 now has its own step** (Phase 4) | It appeared in the quick-reference table and nowhere in the body. FT-226 was filed as *"no guide page reference at all"* — that is wrong twice over, see 0.3 |
| **Setting 9 rewritten** | Bill's field report: *"Does not explain here or in the guide why they should do this, why they need to use the MS account, and why not using the MS account is bad"* |
| **Setting 12 rewritten** | The draft had almost nothing; the substance was only on the website |
| **Setting 13 rewritten** | Was framed as speed. It is about what runs when the reader believes Edge is closed |
| **Three PL-4 breaches removed** | *"the single biggest factor in PC security"*, *"the most powerful built-in tool"*, *"biggest single reduction in malware blast radius"* — all measured present in v9 |
| **"the user" removed throughout** | 16 occurrences in v9, plus one line telling the reader to *"ask the user first"*. A senior sitting alone has nobody to ask |
| **"whether" removed** | Banned, PL-1. One occurrence in v9 |
| **"open-source" kept once** | The Chromium glossary entry. Legitimate — do not sweep it |
| **Cover, author and copyright added** | v9 had none. "GatewayGuard" appeared 0 times and "Checkup" 0 times in a $19.99 product |
| **TOC placeholder defect fixed** | v9 shipped with *"Right-click here and choose Update Field"* on page 1, twice |

### 0.2 RETRIEVAL GAPS — six sections not written

I could not retrieve these from the source pack in full. **They are marked in
place rather than written, because writing them from memory would be
fabrication.** Every one exists in v9 and must be carried across.

| # | Section | Where it sits in v9 |
|---|---|---|
| G1 | **Phase 1 Step 3 — Device Encryption / BitLocker**, full body | Phase 1 |
| G2 | **Phase 1 Step 4 — User accounts & sign-in**, full body | Phase 1 |
| G3 | **Step 6 Parts B–H**, full body | Phase 2 |
| G4 | **Phase 5 — hardening, habits, performance hygiene, decision tree** | Phase 5 |
| G5 | **Firefox addendum F1–F12** | Addendum |
| G6 | **Glossary and Index** | Back matter |

**How to close them:** Claude Code should extract each named section from
`GuideV9-SourcePack` and hand it back, or Bill uploads the source pack into
the chat. Both are one action. **Do not let this document ship with the
markers still in it.**

### 0.3 FT-226 is wrong as filed, in both halves

**Half one — the tool.** Setting 17 carries a guide reference. Measured in
ascii40, ascii41, ascii42 and ascii43:

```
ID=17; Name="Password Required on Wake"; GuideRef="Keep vs. Disable Table"
```

**Half two — the guide.** Setting 17 was in the quick-reference table.

**What is actually broken is a class, not a setting.** Settings **10, 11, 12,
17, 18 and 19** all carry `GuideRef="Keep vs. Disable Table"`. That is a table
name, not a page number, so all six show the reader a reference they cannot
turn to. Bill saw it on 17 because 17 is the one he pressed. **Fixing 17 alone
leaves five live.**

Setting 9 is different again — it points at `"Phase 1, Step 4"`, which is a
real destination.

### 0.4 ELEVEN CLAIMS MARKED *VERIFY* — carried forward from 2026-08-21

Every one is marked *VERIFY* at the point it appears. **None has been measured
on a live Windows 11 machine.** Two of them can cause real harm if wrong:

1. **The BitLocker recovery-key claim** — if the guide tells a reader they can
   retrieve a key they cannot, they lose the contents of the computer.
2. **The sleep-versus-hibernate claim** — a security recommendation resting on
   what stays in memory.

**These must be measured before the guide ships.** SANDY and Sandy3 between
them cover both the local-account and the Microsoft-account cases.

---

# Windows 11 Security Checkup — the Guide

**A step-by-step security check for your own Windows 11 computer.**

Written for the person who owns the computer, not for a technician.

Published by **GatewayGuard LLC**, Brunswick, Maine.
© 2026 GatewayGuard LLC. All rights reserved.

Companion to **GatewayGuard Checkup**, which can perform many of these checks
for you. Free explanations of every setting in this guide are at
**gatewayguard.co/guide** — one page each, with pictures.

---

> ### ⚠ Before you touch anything
>
> **If your files are already locked and something is demanding money, stop.**
> Do not pay, do not run anything else, and turn to *Getting help* at the back
> of this guide.
>
> **If a pop-up or a phone call told you that you are infected and gave you a
> number to ring, that call is the scam.** Nothing in this guide asks you to
> phone anyone.

---

## Table of Contents

*In Word: right-click this line and choose Update Field.*
*The outline below is always visible and does not need updating.*

**Front matter**
- Before you start
- Quick-reference settings table

**Phase 1 — The basics**
- Step 1 — Windows Update
- Step 2 — Windows Security
- Step 3 — Device encryption
- Step 4 — Your account and how you sign in

**Phase 2 — What is installed**
- Step 5 — Apps you did not put there
- Step 6 — Your browsers

**Phase 3 — If you found something bad**
- Steps 1 to 8, behind a stop-and-decide page

**Phase 4 — Privacy and housekeeping**
- Settings 11, 12, 13, 14, 15, 17, 18, 19

**Back matter**
- Advanced — optional
- Getting help
- Firefox addendum
- Glossary
- Index

---

## Before you start

**This will take about two hours.** You do not have to do it in one sitting.
Each phase ends at a natural stopping point, and the guide says so.

**Nothing here deletes your files.** Where a step changes something that is
awkward to undo, the guide says so first and tells you how to reverse it.

**Have these to hand:**

- The password you use to sign in to this computer.
- Your phone, for the steps that are easier there.
- Paper and a pen.

**One rule, and it is the important one.** If you find something you do not
recognise, **write the name down. Do not remove it yet.** The wrong removal
can stop your computer from working properly, and undoing that is much harder
than writing down a name.

When you have finished the checks, take your list to *Getting help* at the
back of this guide. Nothing on that list needs to be dealt with today.

---

## Quick-reference table

**Every setting in this guide, and what it should be.** Use it as a checklist
now, and as somewhere to check back later.

The names below match what you will see on your own screen. Where Windows
shows a slightly different word, the guide says so at that step.

| # | Setting | Where it lives | Should be | Page |
|---|---|---|---|---|
| 1 | Windows Update | Settings › Windows Update | Up to date, nothing waiting | 00 |
| 2 | Defender Real-Time Protection | Windows Security › Virus & threat protection › Manage settings | On | 00 |
| 3 | Tamper Protection | Same screen as above | On | 00 |
| 4 | SmartScreen | Windows Security › App & browser control | On, all parts | 00 |
| 5 | Defender Periodic Scanning | Windows Security › Virus & threat protection | On, only if you run another antivirus | 00 |
| 6 | Enhanced Phishing Protection | Windows Security › App & browser control › Reputation-based protection | On, all three parts | 00 |
| 7 | Firewall & network protection | Windows Security › Firewall & network protection | On for all three networks | 00 |
| 8 | Device encryption / BitLocker | Settings › Privacy & security › Device encryption | On, **and the recovery key saved somewhere else** | 00 |
| 9 | Windows Hello | Settings › Accounts › Sign-in options | PIN set up | 00 |
| 10 | Remote Desktop | Settings › System › Remote Desktop | Off, unless you truly use it | 00 |
| 11 | Advertising ID | Settings › Privacy & security › General | Off — your choice | 00 |
| 12 | Diagnostic Data | Settings › Privacy & security › Diagnostics & feedback | Required only | 00 |
| 13 | Edge Startup Boost | Edge › Settings › System and performance | Off | 00 |
| 14 | Windows Widgets | Right-click the taskbar › Taskbar settings | Off | 00 |
| 15 | Edge Password Saving | Edge › Settings › Profiles › Passwords | Off | 00 |
| 16 | Memory Integrity | Windows Security › Device security › Core isolation | On, if your computer allows it | 00 |
| 17 | Password Required on Wake | Settings › Accounts › Sign-in options | When PC wakes from sleep | 00 |
| 18 | Fast Startup | Control Panel › Power Options › Choose what the power buttons do | Off | 00 |
| 19 | Wake on LAN | Device Manager › Network adapters › Power Management | Off | 00 |

**Page numbers must be filled in at export.** Every one of the six settings
that the tool sends to *"Keep vs. Disable Table"* — 10, 11, 12, 17, 18 and 19
— needs a real page number here, or the tool points at nothing. See 0.3.

---

# Phase 1 — The basics

These are the settings that protect you day to day. If you only ever do one
phase, do this one.

---

## Step 1 — Windows Update

**Why it matters.** Updates close security holes that criminals already know
about. An out-of-date computer is open to problems that were fixed months ago.

**Where it lives:** press the **Windows key**, type **Windows Update**, and
press **Enter**.

**Read the message at the top:**

- **"You're up to date"** — good. Move on.
- **"Updates available"** or **"Restart required"** — click **Download** or
  **Restart now**, let it finish, then come back here.
- **"Checking for updates…"** — wait a moment.

**Then click "Check for updates"** anyway, to be certain.

**Click "Advanced options"** and make sure these are **On**:

- Receive updates for other Microsoft products
- Get me up to date
- Notify me when a restart is required

**Check which Windows you have.** Go to **Settings › System › About**.

- It should say **Windows 11**, version 23H2, 24H2 or 25H2.
- **If it says Windows 10**, that is worth acting on. Windows 10 stopped
  receiving free security updates in October 2025. If your computer supports
  Windows 11, upgrading is worth doing. If it does not, this is a good
  conversation to have with someone you trust.

**One thing to skip.** If you see an update with **"Preview"** in its name,
leave it. Those are early versions. The finished one arrives automatically the
following month.

**Driver updates** are different again — install one only if you are having a
problem with that piece of hardware.

### A note on 2026

Windows computers built since about 2011 rely on security certificates that
began expiring in late June 2026. Microsoft has been sending replacements
through Windows Update. If your updates are current, this has already been
handled and you will never notice it.

Microsoft also released an unusually large security update in June 2026. If
your computer is asking to restart, let it.

---

## Step 2 — Windows Security

**Why it matters.** Windows has good security built in. It is called Microsoft
Defender, and for most home computers it is enough on its own.

**Where it lives:** press the **Windows key**, type **Windows Security**, and
press **Enter**.

### First, the six tiles

The main screen shows six tiles. **Each one should have a green check mark** or
say "No action needed":

- Virus & threat protection
- Account protection
- Firewall & network protection
- App & browser control
- Device security
- Device performance & health

**If any tile is yellow or red**, click it and read what it says. It will name
the specific problem. Fix that one thing, then come back. Do not move on while
a tile is still yellow.

### Virus & threat protection — settings 2, 3 and 5

Click **Virus & threat protection**, then **Manage settings**. Turn these
**On**:

- **Real-time protection** — checks files as you open them.
- **Cloud-delivered protection** — lets Windows ask Microsoft about
  suspicious files.
- **Automatic sample submission** — sends unknown files for a closer look.
- **Tamper Protection** — stops other software switching Defender off.

**Tamper Protection deserves a moment.** Malware tries to turn Defender off.
Tamper Protection is what stops it. **If you find this switched off and you did
not switch it off, treat that as a finding** — write it down and carry on to
Phase 2.

**Controlled folder access** is optional. It blocks unknown programs from
changing your documents, which is good, but it will sometimes block a program
you actually wanted. Turn it on only if you are comfortable dealing with that.

**Periodic scanning — setting 5.** This appears only if you run another
antivirus alongside Defender. It lets Defender keep checking in the background
as a second opinion. **If you see it, turn it on.**

### Firewall — setting 7

Click **Firewall & network protection**. All three must say **On**:

- Domain network
- Private network
- Public network

If any is off, click into it and turn **Microsoft Defender Firewall** on.

### App & browser control — settings 4 and 6

Click **App & browser control › Reputation-based protection settings**. All of
these should be **On**:

- Check apps and files
- SmartScreen for Microsoft Edge
- **Phishing protection** — all three sub-options
- Potentially unwanted app blocking — both parts
- SmartScreen for Microsoft Store apps

### Device security — setting 16

Click **Device security**. If **Core isolation** appears, click into it.
**Memory integrity** should be **On** if your computer allows it.

**If it will not turn on**, Windows will name a driver that is in the way. That
is not something to force. Write the message down and move on.

---

## Step 3 — Device encryption

> ### ⧗ RETRIEVAL GAP G1
>
> **The body of this step has not been written.** It exists in v9 as
> *"Step 3 — Device Encryption / BitLocker"* and must be carried across in
> full rather than written from memory.
>
> **What it must contain, and what must be verified first:**
>
> - Where device encryption lives on Windows 11 Home versus Pro.
> - How to find out if it is already on.
> - **How to save the recovery key, and where it actually goes.** *VERIFY —
>   this is one of the two claims that can cause real harm if wrong. A reader
>   told they can retrieve a key they cannot retrieve loses the contents of
>   the computer.*
> - What happens if the key is lost.
> - Why the key must be kept somewhere other than on this computer.

---

## Step 4 — Your account and how you sign in

> ### ⧗ RETRIEVAL GAP G2
>
> **The surrounding body of this step has not been written.** It exists in v9
> as *"Step 4 — User accounts & sign-in"* and must be carried across: how to
> see which accounts exist, how to spot an account nobody created, standard
> versus administrator accounts, and what to do about an unfamiliar one.
>
> **The Windows Hello section below is finished and replaces whatever v9 had.**

### Windows Hello — setting 9

**Where it lives:** **Settings › Accounts › Sign-in options**.

**What it is.** A PIN, a fingerprint, or your face, used instead of typing your
password every time.

**Why a PIN is safer than a password, even though it is shorter.** Your
password works from anywhere in the world. **A PIN only works on this
computer.** Somebody who learns your PIN and is not sitting at this keyboard
has nothing. Somebody who learns your password can sign in to your account from
their own machine, on the other side of the world.

That is why a four-digit PIN is not the weaker option it looks like.

### Why a Microsoft account comes into this

**Setting up a PIN does not require a Microsoft account.** *VERIFY.* A PIN
works on a computer that uses a local account. When you create the PIN, Windows
asks for your account password first — that is a one-time identity check, not a
sign-up.

**The Microsoft account matters for one thing: getting back in.**

**If you forget your PIN.** With a Microsoft account, you prove who you are
from your phone and set a new one. **On a local account, there is nobody to
prove yourself to.** *VERIFY.*

**If you forget your password on a local account**, there is no reset link and
no support line. *VERIFY.* The usual answer is a full reinstall of Windows,
which means losing everything on the computer that is not backed up
elsewhere — and if device encryption is on, the recovery key becomes the only
way in.

**This is the honest trade.** A Microsoft account means Microsoft holds a way
back into your computer. A local account means nobody does — including you.
Neither is wrong. **What is wrong is choosing a local account without knowing
that the safety net comes off with it.**

### Setting up the PIN

1. **Settings › Accounts › Sign-in options.**
2. Click **PIN (Windows Hello)**, then **Set up**.
3. Enter your account password when asked — this is the identity check.
4. Choose a PIN. **Six digits or more is better than four**, and it must not
   be your year of birth or part of your phone number.

**Keep your password as a fallback.** Setting up a PIN does not remove your
password, and you will still need it occasionally.

**At the bottom of that screen** there is a setting called *"For improved
security, only allow Windows Hello sign-in for Microsoft accounts on this
device"*. **Turn it on if you use a Microsoft account.** *VERIFY.* It stops
older, weaker sign-in methods being used to reach your account.

**How to undo it.** Same screen. Click **PIN (Windows Hello) › Remove**. You
will be asked for your password.

---

> ### ⏸ STOPPING POINT
>
> **Phase 1 is the important one, and it is done.** If you stop here, your
> computer is meaningfully better protected than it was this morning.

---

# Phase 2 — What is installed

---

## Step 5 — Apps you did not put there

**Why it matters.** Most trouble arrives as a program somebody was persuaded
to install. Finding it is mostly a matter of looking.

### First, tighten where apps are allowed to come from

**Settings › Apps › Advanced app settings › Choose where to get apps.**

It should say **"Anywhere, but warn me before installing an app that's not from
the Microsoft Store"**, or the stricter **"Microsoft Store only"**.

**It should not say plain "Anywhere"** — that setting warns you about nothing.

### Now look at the list

**Settings › Apps › Installed apps.** **Sort by install date, newest first.**
Anything that arrived recently and unannounced shows up at the top.

**What you are looking for:**

- Anything you do not recognise.
- **Generic names with no brand** — "PDF Editor", "Video Converter", "Music
  Player", "PC Cleaner".
- Several toolbars, or anything calling itself a "search helper".
- Old antivirus trials nobody ever activated.

**Before you remove anything unfamiliar, find out who made it.** A plain name
from a real company is often perfectly legitimate. Click the app, then
**Advanced options** — or open **Control Panel › Programs and Features**, which
shows the publisher in a column and is the more reliable of the two.

### Names to treat as serious — the AppSuite / TamperedChef family

**If you find any of these, do not remove it yet. Turn to Phase 3 first.**

| Name | What it is |
|---|---|
| AppSuite — any product | The TamperedChef backdoor family |
| PDF Editor 1.x.xx by AppSuite | A confirmed backdoor |
| ManualFinder | Same family |
| OneLaunch | Same family |
| Wave Browser, or Wave | Same family |
| Shift browser | Same family |
| A generic "PDF Editor" with no recognisable maker | Often this family |

These are advertised through search results for things like "free PDF editor".
Microsoft Defender, Malwarebytes, G DATA and Truesec each classify them as
backdoors — programs that can take passwords, copy files off the computer, and
let somebody else operate it.

**The order matters.** Uninstalling first can leave the rest of it behind and
tells the program it has been noticed. **Phase 3 is the order to do it in.**

### Names that are merely unwanted

These are not dangerous. They are worth removing anyway:

- **Fortect**, formerly Reimage — tells you your computer has hundreds of
  problems and asks for money to fix them.
- **Avira**, if Windows Defender is also running — two antivirus programs get
  in each other's way.
- **Norton or McAfee trials** that came with the computer and were never used.
- Anything calling itself a **driver updater** or a **registry cleaner**.

---

## Step 6 — Your browsers

Do this for every browser on the computer — Edge, Chrome, Firefox, any other.

### Part A — Extensions

Type one of these into the address bar and press Enter:

- `edge://extensions`
- `chrome://extensions`
- `about:addons` (Firefox)

**Every extension should be one you chose deliberately.**

**Remove on sight:** anything called *Coupon*, *Shopping helper*, *Deal
finder*, or *Search helper*; anything called *Wave* or *Shift*; anything you do
not recognise; anything from a maker you have never heard of.

> ### ⧗ RETRIEVAL GAP G3 — Parts B to H
>
> **These have not been written.** They exist in v9 and must be carried across
> in full:
>
> - **Part B — Default search engine**
> - **Part C — Homepage and startup pages**
> - **Part D — Stop browsers restarting themselves**
> - **Part E — Set the right default browser**
> - **Part F — Windows Widgets** (setting 14)
> - **Part G — Browsers in Windows startup apps**
> - **Part H — Edge's scheduled tasks**
>
> Part H's verification step is worth preserving as written: reboot, open Task
> Manager before opening any browser, and confirm no Edge or Chrome processes
> are running. If Edge still appears, Part F, G or H was missed.
>
> **Part H also disables rather than deletes the scheduled tasks, deliberately
> — disabling is reversible.**

### Part I — The browser's own password store

**Edge:** Settings › Profiles › Passwords. **Chrome:** Settings › Autofill and
passwords › Google Password Manager › Settings.

Turn **Offer to save passwords** off, and **Auto Sign-in** off.

**Why.** Passwords kept in a browser are the first thing this kind of program
looks for. A separate password manager keeps them somewhere the browser cannot
hand over.

**Do not delete the saved passwords yet** — you still need to sign in to those
accounts to change them. Phase 3 Step 8 is where they get cleared.

### Part J — Safe browsing

**Chrome:** Settings › Privacy and security › Security.

**Enhanced protection** or **Standard protection** — either is fine. **Never
"No protection".**

### Part K — Sync

**Chrome:** Settings › You and Google › Sync and Google services.

Confirm the account shown is yours. If it is an account you do not recognise,
that is a finding — write it down.

---

# Phase 3 — If you found something bad

---

> ### ⚠ STOP AND DECIDE
>
> **Phase 3 is only for people who found something in the list on page 00.**
> If Phase 2 turned up nothing, skip to Phase 4.
>
> **This phase is longer and more demanding than the rest of the guide.** It
> involves changing a lot of passwords. It is worth doing properly, and it is
> worth doing over several days.
>
> **If you would rather not do this alone, that is a reasonable choice.** Turn
> to *Getting help* at the back. Nothing here gets worse for waiting a day.
>
> **Do not skip steps and do not reorder them.**

---

## Step 1 — Remove the program

**Settings › Apps › Installed apps.** Find it, click the three dots, choose
**Uninstall**.

**Turn off your Wi-Fi first if you can.** It stops the program reporting home
one last time. Turn it back on afterwards.

**Do not assume that finished the job.** This kind of program leaves pieces
behind. Keep going.

## Step 2 — The offline scan

This restarts your computer and scans it before Windows fully loads, which
catches things that hide from an ordinary scan.

1. Save your work and close everything.
2. **Windows Security › Virus & threat protection › Scan options.**
3. Choose **Microsoft Defender Antivirus (offline scan)**.
4. Click **Scan now** and confirm.

**What happens:** the computer restarts after about a minute, shows a blue
scanning screen for **10 to 20 minutes**, then starts normally. **This is
expected. Let it finish.**

**Then read the results.** Windows Security › **Protection history**. For each
detection, the status must say **Quarantined** or **Removed**. **If anything
says Allowed or Action needed**, click it and take the action offered.

## Step 3 — Clear what is left behind

> ### ⧗ RETRIEVAL GAP — part of G3
>
> The manual residue-clearing procedure exists in v9 as *"Phase 3 Step 3 —
> Manually clean residue"* and has not been retrieved in full. It must be
> carried across, and it must keep whatever safety framing v9 gave it —
> this is the step in the whole guide most capable of damaging a working
> computer if followed carelessly.

## Step 4 — A second opinion

Install **Malwarebytes Free** and run one scan. It is a second opinion, not a
replacement for Defender.

**Watch for the trial.** Malwarebytes offers a Premium trial on install.
**Decline it.** If it activates anyway it can switch Defender off, which leaves
you less protected than before.

**If the trial activated:** open Malwarebytes › Settings › Account and
deactivate it. Then open Windows Security and confirm Defender is active again.
If it is not, turn off every real-time protection toggle in Malwarebytes and
check again.

**Running the scan:** a normal scan takes **15 to 45 minutes**. Quarantine
everything it finds. It presents results in several pages — malware, then
unwanted programs, then tracking cookies. **Click Quarantine on every page
until it stops asking.** Restart when it asks.

## Step 5 — Sign out everywhere, from your phone

**Do this on your phone, not on this computer.**

**Google:** `myaccount.google.com` › Security › Your devices › Manage all
devices › sign out of every one.

**Microsoft:** `account.microsoft.com` › Security › **Sign me out
everywhere**. Then check `account.live.com/Activity` for sign-ins you do not
recognise.

Do the same for any other account that offers it.

**Why.** Signing out everywhere invalidates the stored sign-ins that let
somebody stay in your account without knowing your password.

## Step 6 — Check your email

**For each email account you have:**

- **Recent sign-in activity** — anything from a place or device you do not
  recognise?
- **Sent folder** — anything you did not send?
- **Deleted items** — password-reset emails you did not ask for?
- **Filters and forwarding rules** — any you did not create?

**A forwarding rule you did not create is the serious one.** It means somebody
is receiving copies of your mail, including password resets. If you find one,
remove it, change that password immediately, and get a person involved.

**If everything looks normal**, your passwords may have been taken but nobody
has used them yet. Step 7 is what closes that door.

## Step 7 — Change your passwords

**Assume every password saved in a browser on this computer is known to
somebody else.**

**You do not have to do them all today.** Work in order of what would hurt
most.

**This week:**

- **Email accounts first, always** — every other account resets through them.
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
4. **Turn on two-step verification** if offered. An authenticator app is
   better than a text message, and a text message is better than nothing.
5. Sign out of other sessions if the site offers it.
6. Check the recovery email is one you still use.

**Ask yourself as you go: have I used this in the past year?** If not, consider
closing the account instead. An account you never use is one more place your
details sit.

## Step 8 — Finish clearing the browser

Once your important passwords have been moved, go back to Step 6 Part I and
**delete the saved passwords** from the browser's list.

---

> ### ⏸ STOPPING POINT
>
> **If you have worked through Phase 3, stop here.** Password changes are
> better done over several sittings than rushed in one.

---

# Phase 4 — Privacy and housekeeping

**Nothing in this phase makes your computer easier to break into.** These
settings control how much is shared, and what runs when you are not looking.
Reasonable people choose differently on some of them.

---

## Advertising ID — setting 11

**What it is:** a number that lets apps show you advertising based on what you
do on this computer.

**Where it lives:** **Settings › Privacy & security › General**.

Turn off **Let apps show me personalised ads by using my advertising ID**.

**What changes:** you see the same number of adverts. They are simply less
tailored to you. No restart needed.

**How to undo it:** same screen, turn it back on.

**This is a preference, not a security requirement.** Leaving it on does not
put the computer at risk.

---

## Diagnostic Data — setting 12

**What it is:** information sent to Microsoft about how this computer is
running.

**Where it lives:** **Settings › Privacy & security › Diagnostics & feedback**.

**There are two levels, and Windows sends the larger one unless told
otherwise.** *VERIFY.*

**Required** covers what Windows needs to work: what kind of computer this is,
what went wrong when something crashed, and what it needs for updates.

**Optional** adds a record of how you use the machine — **which apps you open,
how long you spend in them, which features you click, and information about
your browsing.** *VERIFY.*

**Choose Required.**

**Why this is more than a taste.** Nobody is reading your day. But a record of
what you did on your own computer is kept somewhere you cannot see it, for as
long as somebody else decides to keep it, and you were never asked in a way you
would have noticed. **Turning it down does not erase what is already there. It
stops the list getting longer.**

**What you give up:** nothing you will notice. **Your computer receives exactly
the same updates either way.** *VERIFY.* No restart needed.

**How to undo it:** same screen, choose Optional.

---

## Edge Startup Boost — setting 13

**What it is:** a setting that keeps part of Microsoft Edge running after you
close it, so it opens faster next time.

**Where it lives:** **Edge › Settings › System and performance**.

Turn off **Startup boost**. **Turn off "Continue running background extensions
and apps when Microsoft Edge is closed"** on the same screen.

**Why it is here rather than in a performance guide.** **When this is on, Edge
is still running after you have closed it.** *VERIFY.* The window is gone, so
the computer looks idle — but extensions are still loaded and still able to act.

**That matters because of Step 6.** A browser extension you did not choose is
one of the things Phase 2 asks you to look for. **An extension that keeps
running after the browser is closed is one you cannot see and did not agree
to.** Closing the window is the moment most people assume the browser has
stopped. This setting is what makes that assumption wrong.

**What you give up:** Edge takes a second or two longer to open. That is the
whole cost.

**How to undo it:** same screen, turn both back on.

---

## Windows Widgets — setting 14

**What it is:** the news and weather panel on the taskbar.

**Where it lives:** **right-click the taskbar › Taskbar settings**. Turn
**Widgets** off.

**Why.** It opens web content you did not ask for, and it is one of the things
that quietly starts Edge in the background.

**How to undo it:** same place, turn it back on.

---

## Edge password saving — setting 15

**Where it lives:** **Edge › Settings › Profiles › Passwords**. Turn **Offer to
save passwords** off.

**Why.** Same reason as Step 6 Part I. A password kept in the browser is the
first thing a bad program looks for.

**Use a password manager instead.** Choose one from a well-known publisher.

**One thing worth knowing about Edge.** Turning off *"Save and fill payment
info"* **prevents you deleting cards you already saved**. If you want the saved
cards gone: turn the setting back **on**, delete the cards, then turn it off
again. Doing it in the other order leaves the cards sitting there. Switching it
off also leaves *"Allow sites to check if you have payment methods saved"*
switched on — that is a separate toggle on the same screen and it needs turning
off too.

---

## Password required on wake — setting 17

**What it is:** whether the computer asks for your PIN or password when it
comes back from sleep.

**Where it lives:** **Settings › Accounts › Sign-in options**, under **"If
you've been away, when should Windows require you to sign in again?"**

**Set it to "When PC wakes up from sleep."**

**Why it matters more than it sounds.** Everything else in Phase 1 protects
this computer from somebody at a distance. **This one protects it from
somebody in the room.** Encryption does nothing while the computer is awake and
signed in — a laptop left asleep on a table with this set to *Never* is a
laptop anyone can open and use as you.

**It costs you a PIN.** That is the entire cost. You have already set one up in
Step 4, and it takes a second to type.

**If the option is missing**, this computer is set never to sleep, or it uses
hibernation instead. Both are fine. **Check Settings › System › Power &
battery › Screen and sleep** to see which.

### Sleep or hibernate?

**Hibernate is the safer of the two.** *VERIFY.* When a computer sleeps, it
keeps the contents of memory alive — and on an encrypted computer, the key that
unlocks the drive is in that memory. **When it hibernates, memory is written to
disk and the machine genuinely switches off**, so there is nothing live to
reach. *VERIFY.*

**On Windows 11 Home with Device Encryption, hibernating does not cause the
computer to ask for a recovery key on the way back.** *VERIFY — this claim can
cause real harm if wrong. A reader who hibernates and is then asked for a key
they cannot find has lost access to the computer. It must be measured on a
machine with Device Encryption switched on before this ships.*

**Where hibernate lives:** **Control Panel › Power Options › Choose what the
power buttons do**. You may need to click *"Change settings that are currently
unavailable"* first.

**How to undo it:** same screen. Setting 17 itself reverses at **Settings ›
Accounts › Sign-in options**.

---

## Fast Startup — setting 18

**What it is:** a setting that makes the computer start faster by not fully
shutting down.

**Where it lives:** **Control Panel › Power Options › Choose what the power
buttons do**. Click **"Change settings that are currently unavailable"**, then
untick **Turn on fast startup**.

**Why turn it off.** *"Shut down"* with this on does not shut the computer
down. It leaves it in a half-off state, which means some updates never finish
installing and some problems survive a restart that should have cleared them.

**What you give up:** the computer takes a few seconds longer to start.

**How to undo it:** same screen, tick it again.

---

## Wake on LAN — setting 19

**What it is:** a setting that lets the computer be woken up over the network.

**Where it lives:** **Device Manager › Network adapters**, right-click your
adapter, **Properties › Power Management**. Untick **Allow this device to wake
the computer**.

**Why.** On a home computer there is nothing that needs to wake it remotely, so
it is capability you are not using.

**If you have more than one network adapter**, do this for each one.

**How to undo it:** same screen, tick it again.

---

# Phase 5 — Habits worth keeping

> ### ⧗ RETRIEVAL GAP G4
>
> **This phase has not been written.** It exists in v9 as *"Phase 5 —
> Hardening Recommendations"* and covers:
>
> - Going-forward defensive habits
> - Performance hygiene related to security
> - The quick decision tree for when something looks wrong
> - Password managers — what to look for, described generically rather than by
>   brand
> - Scheduled scanning, including the phone-reminder approach for tools that
>   cannot schedule, and the quarterly offline-scan reminder
>
> All of it must be carried across from v9.

---

# Advanced — optional

**Nothing in this section is required.** It is here for readers who want it,
kept separate so that nobody feels obliged.

> ### ⧗ RETRIEVAL GAP — part of G4
>
> The PowerShell and Task Scheduler material from v9's appendix belongs here,
> walled off as decided. Not retrieved.

---

# Getting help

**If your files are locked and something is demanding money**, stop. Do not
pay. Do not run anything else. Disconnect from the internet and get a person
involved today. Paying does not reliably get the files back and marks you as
somebody who pays.

**If you found something in Phase 2 and would rather not do Phase 3 alone**,
that is a reasonable choice. Nothing gets worse for waiting a day.

**Who to call:**

- Someone in your family who is comfortable with computers.
- The shop that sold you the computer.
- Your internet provider, for anything to do with the connection itself.

**Be careful who you call.** **If a pop-up, a phone call, or an email tells you
your computer is infected and gives you a number, that is the scam itself.**
Real security warnings never ask you to phone anybody. Neither does this guide.

**Free explanations of every setting** are at **gatewayguard.co/guide**.

---

# Addendum — Firefox

> ### ⧗ RETRIEVAL GAP G5
>
> **F1 to F12 have not been written.** They exist in v9 as *"Addendum —
> Firefox-Specific Hardening (F1–F12)"* and must be carried across in full.

---

# Glossary

> ### ⧗ RETRIEVAL GAP G6
>
> **Not retrieved.** Carry across from v9, with the hardware terms trimmed as
> already decided — SO-DIMM, DDR4/DDR5, MPN and page file come out.
>
> **The Chromium entry contains "open-source" and that is correct usage. Do
> not sweep it.**

---

# Index

> ### ⧗ RETRIEVAL GAP G6
>
> **Not retrieved.** Rebuild at export, once page numbers exist.

---

## RECONCILIATION — guide against website, RULE W-07

The twelve corrections applied on 2026-08-15 stand and are carried into this
document. **One collision is still open and is not resolved here:**

**W-07 collision — diagnostic data.** The website's diagnostic-data page and
this guide's setting 12 do not say the same thing. **Both cannot ship.** This
needs Bill's decision on which position is correct, and then one of the two
gets rewritten to match.

---

## WHAT MUST HAPPEN BEFORE THIS SHIPS

1. **Close the six retrieval gaps** — G1 to G6. Nothing ships with a marker in it.
2. **Measure the eleven VERIFY claims** on live Windows 11, both the
   local-account and Microsoft-account cases. **BitLocker recovery key and
   sleep-versus-hibernate first** — those two can cost a reader their files.
3. **Resolve the W-07 diagnostic-data collision** with the website.
4. **Fill in every page number** in the quick-reference table, and give the six
   `"Keep vs. Disable Table"` settings a real destination — or change the tool
   to point somewhere that exists.
5. **Bill approves**, and only then does this replace
   `windows_security_walkthrough_guide_v9.docx`.
