<!-- Dated: 2026-10-02 11:56 ET -->
<!-- Stamped by Claude Code: the time this file arrived on CGDELL (file creation time, measured). -->
<!-- Editor: Claude Cloud -->
# Guide -- Part 1 "Before you start: a safety net", Part 4, Part 5 -- FINAL TEXT FOR F10

- **Document Name:** GatewayGuard_GuideFinal-Part1SafetyNet-Part4-Part5
- **Supersedes:** `GatewayGuard_GuideDraft-Part1SafetyNet-Part4-Part5-2026-09-30-1636.md`
- **From:** Claude Cloud
- **For:** Claude Code (F10: put the guide's final wording into Checkup), then the format pack
- **Status: FINAL**, with five sentences held. Every other sentence is measured or sourced. The five held sentences each wait on one screen reading (R1-R6, listed at the end of this file and in the companion change list). **F10 can take everything now except the five held places, which are named in the F10 section below.**
- **Companion files:** `GatewayGuard_GuideChanges-Parts2-3-MarkersClosed-2026-10-02-1156.md` (Parts 2 and 3, plus the reading list), `GatewayGuard_WebsiteChanges-ToMatchGuide-2026-10-02-1156.md`, `GatewayGuard_FormatPackNeeds-2026-10-02-1156.md`

---

## PROVENANCE (Cloud Working Rules, steps 1-5)

1. **Stamp:** `CURRENT.md` Generated **2026-09-30 16:43 ET**, commit **`6f3ab29`**, made **2026-09-30 16:23 ET**, subject *"Gate 27 extended: A1 regenerates CURRENT.md into any ProjectDocs commit, W1 warns on no session-log entry today, S2/S3 refuse unfilled or typed stamps; Tool2/stamp.py writes the clock time"*. 96 rows.
2. **Base:** `GatewayGuard_GuideDraft-Part1SafetyNet-Part4-Part5-2026-09-30-1636.md` (filed by Claude Code from Cloud's 09-30 file; its text is Cloud's word for word, stamp corrected). Readings: `GatewayGuard_ScreenReadings-Checklist-2026-09-29-1931.md`. S6: Bill, this session -- the only real offline scan, SANDY 2026-09-28, about 10 minutes. Build: `Tool/W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1`. Brief: `GatewayGuard_CloudBrief-GuideVsAscii45-SinceC1-2026-09-28-1910.md` (A11, A12).
3. **How read:** through `project_knowledge_search`; the base text is Cloud's own and was compared line for line against the filed copy's quoted lines.
4. **Carried forward as fact, and checked against:**

   | Sentence | Checked against |
   |---|---|
   | 4.1: the log is in **GatewayGuard\Logs**, in OneDrive if the reader uses it, otherwise the user folder; **Open-My-Log** opens the newest in Notepad and changes nothing | ***measured***, build: `$GGUserDir` (OneDrive\GatewayGuard or %USERPROFILE%\GatewayGuard), `$LogPath` = `Logs\GatewayGuard-Log-*.txt`, `Open-My-Log.bat` written to `$GGUserDir` every run with the comment *"This file only READS your log."* Field-confirmed on SANDY, `FieldTestTriage-ascii41run1-2026-08-19`, item #12 |
   | 4.2 Setting 13: **edge://policy** lists the policies in force | *sourced*: Microsoft Q&A answers on "managed by your organization" (learn.microsoft.com/answers/a/2423362; /a/12231299) |
   | 4.3: a restore point "may put some of these settings back and not others" | Makes no claim either way; the earlier claims about Edge and encryption are **removed**, not settled. Windows' own sentence about personal data is ***measured*** (S4) |
   | 4.5 Step 2: about 10 minutes on our test computer | ***measured***, S6 (Bill: SANDY 2026-09-28) |
   | 4.5 Step 2: sign in, run Checkup again, choose **R** | brief A11 (Block E, F12) |
   | 4.2 Setting 2: "running in its place" | brief A12 / FT-303 |
   | 4.6: the FBI does not support paying a ransom; paying does not guarantee anything back; report at ic3.gov | *sourced*: fbi.gov, FBI Memphis Field Office release, *"The FBI does not support paying a ransom..."* |

5. **Not seen:** the five screens in R1-R6. Until Bill reads them, the five held sentences stay marked.

**Labels:** ***measured*** / *sourced* / *inferred* / *guess*.

---

====================================================================
# CUSTOMER TEXT BEGINS
====================================================================

## Part 1 addition -- Before you start: a safety net

[NOTE: goes in Part 1 immediately after "Before You Begin", before "Understanding Recommendations".]

### Make a restore point first

A restore point is a snapshot of how Windows is set up at one moment. If Windows itself starts misbehaving after a change, you can take it back to that moment.

It takes a few minutes. Do it before you run Checkup.

1. Press the **Windows key**, type **Create a restore point**, and press **Enter**. A window opens on its **System Protection** tab.
2. Look at the **Create...** button.
   - If you can click it, go to step 4.
   - If it is grey, restore points are switched off on this computer. The window says: *"To create a restore point, first enable protection by selecting a drive and clicking Configure."* Do step 3 first.
3. **Switch restore points on.** Click **Windows (C:)** in the list, then click **Configure...**. In the window that opens, choose **Turn on system protection**, then click **OK**. You are back at the first window, and **Create...** can now be clicked.
4. Click **Create...**, type a name you will recognize, such as *Before Checkup*, and click **Create**. When Windows says the restore point was created, click **Close**.

⚠ VERIFY -- step 4 only: the name box, its button, and the message that follows (reading R1). Steps 1 to 3 are read off the screen (C1, C1b).

### What a restore point is, and what it is not

It is a safety net for Windows. **It is not an undo button for the settings in this guide.** It may put some of these settings back and not others, so do not count on it for them. Part 4 shows you how to put back each setting on its own, which is the reliable way.

### Using a restore point

Use this only if Windows itself misbehaves and putting back single settings (Part 4, 4.2) has not helped.

1. Press the **Windows key**, type **Create a restore point**, and press **Enter**.
2. Click **System Restore...**. A window opens headed **Restore system files and settings**. Windows tells you there: *"System Restore does not affect any of your documents, pictures, or other personal data. Recently installed programs and drivers might be uninstalled."* Click **Next >**.
3. The next page lists your restore points, with the **Date and Time**, **Description** and **Type** of each. **Click the one you made.** Until you click one, **Next >** stays grey.
4. **Before you go on, click Scan for affected programs.** Write down any programs it lists. You may need to install them again afterward.
5. Click **Next >**, then **Finish**. Your computer restarts.

⚠ VERIFY -- step 4: what the scan shows (reading R3). Step 5: the page after Next and the Finish button (reading R2). Steps 1 to 3 are read off the screen (S4, screenshots 28-29).

---

# Part 4: After Checkup -- What Changed, How to Put It Back, and What to Do If Something Looks Wrong

Every change in Parts 2 and 3 can be put back. This part shows how for each one, and what to do if something does not look right afterward.

---

## 4.1 What Checkup changed

Checkup writes down everything it does, as it does it. You never need to copy anything off the screen.

**While Checkup is running,** press **I** on any screen that offers it to see the record so far.

**After Checkup has finished,** the record is a file in your **GatewayGuard** folder, inside a folder called **Logs**. If you use OneDrive, the GatewayGuard folder is in your OneDrive. If not, it is in your own user folder.

**The quickest way to open it:** in the GatewayGuard folder, double-click **Open-My-Log** (it may show as *Open-My-Log.bat*). It opens your newest log in Notepad and changes nothing.

[SCREEN NAME PENDING -- F10 / Decision 4. When the "What Checkup changed" screen is built, one paragraph goes here: its name, that it lists each setting as *Was* and *Now*, and that it shows the steps for any setting you must put back yourself.]

**Keep the log file Checkup saves.** If you ever ask for help, it is the most useful thing you can send.

---

## 4.2 Putting a setting back

For each setting: what Checkup may have changed, and the clicks to reverse it. Where to find each setting in the first place is in that setting's **How To Check**, in Part 2 or Part 3.

**Before you put a security setting back, ask why.** The settings in Part 2 protect you. If something stopped working after a change, it is usually quicker to fix that one thing than to switch the protection off. See 4.4.

| Setting | What Checkup may have changed | To put it back |
|---|---|---|
| **Part 2, Setting 1 -- Windows Update** | Turned automatic updates on | GatewayGuard does not recommend turning updates off. If you need a break from them: Settings > Windows Update > **Pause updates**, which says *"Select the date to pause updates until."* Pick a date on the calendar; the latest it offers is about five weeks ahead. To end the pause early, click **Resume updates** |
| **Part 2, Setting 2 -- Microsoft Defender Real-Time Protection** | Turned it on, only if no other antivirus was running in its place | Windows Security > Virus & threat protection > Manage settings > Real-time protection **Off**. Only do this if support asks you to |
| **Part 2, Setting 3 -- Tamper Protection** | Nothing. Checkup only checks this one | Nothing to put back |
| **Part 2, Setting 4 -- SmartScreen** | Turned the protections on | Windows Security > App & browser control > Reputation-based protection settings. Turn off whichever of the four you want off: Check apps and files, SmartScreen for Microsoft Edge, Potentially unwanted app blocking, SmartScreen for Microsoft Store apps |
| **Part 2, Setting 6 -- Enhanced Phishing Protection** | Turned the warnings on | Windows Security > App & browser control > Reputation-based protection settings > under **Phishing protection**, untick **Warn me about malicious apps and sites**, **Warn me about password reuse** and **Warn me about unsafe password storage** |
| **Part 2, Setting 7 -- Firewall & network protection** | Turned on any network type that was off | GatewayGuard does not recommend turning any of these off. Windows Security > Firewall & network protection > choose the network type > turn it off |
| **Part 2, Setting 8 -- BitLocker Data Encryption** | Turned encryption on, on its own screen, after you saved your recovery key | **Windows 11 Pro:** Control Panel > BitLocker Drive Encryption > **Turn off BitLocker**. **Windows 11 Home:** Settings > Privacy & security > Device encryption > turn **Device encryption** Off. Turning encryption off takes a long time, like turning it on, and your PC should stay plugged in. **Keep your recovery key, with encryption on or off** |
| **Part 2, Setting 9 -- Windows Hello** | Nothing. Checkup only checks this one | Nothing to put back |
| **Part 3, Setting 10 -- Remote Desktop** | On Windows 11 Pro, turned it off | **Windows 11 Pro:** Settings > System > Remote Desktop > turn **Remote Desktop** On. **Windows 11 Home:** nothing to put back. The page says *"Your Home edition of Windows 11 doesn't support Remote Desktop."* |
| **Part 3, Setting 11 -- Advertising ID** | Turned it off | Settings > Privacy & security > Recommendations and offers > turn **Let apps show me personalized ads by using my advertising ID** back on |
| **Part 3, Setting 12 -- Diagnostic Data** | Chose Required diagnostic data | Settings > Privacy & security > Diagnostics & feedback > choose **Optional diagnostic data** |
| **Part 3, Setting 13 -- Edge Startup Boost** | Turned off both parts, using a Windows policy | **You cannot turn these back on in Edge.** After Checkup, Edge shows a **briefcase icon** beside **Startup boost** and **Continue running background extensions and apps when Edge is closed**. It means the setting is controlled from outside Edge. To put them back, the policy Checkup set has to be removed. **Ask someone comfortable with Windows to help (4.6).** They open Registry Editor, go to `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge`, and delete the two values **StartupBoostEnabled** and **BackgroundModeEnabled**. Then close Edge, open it again, and turn both on in Edge > Settings > System and performance > **Startup boost**. To see which settings are controlled this way, type **edge://policy** in Edge's address bar |
| **Part 3, Setting 14 -- Windows Widgets** | Turned Widgets off. On Windows 11 Home you may have done this yourself, following Checkup's steps | Right-click the taskbar > Taskbar settings > **Widgets On** |
| **Part 3, Setting 15 -- Edge Password Saving** | Turned it off, only if you told Checkup you use a password manager | Edge > Settings > Passwords > **Offer to save passwords On**. Turning it off never deleted the passwords Edge already had |
| **Part 2, Setting 16 -- Memory Integrity** | Turned it on | Windows Security > Device security > Core isolation > **Memory integrity Off**, then restart |
| **Part 2, Setting 17 -- Password Required on Wake** | Set sign-in to be required when the PC wakes | Settings > Accounts > Sign-in options > *If you've been away, when should Windows require you to sign in again?* The choices are **Never, Every Time, 1 minute, 3 minutes, 5 minutes, 15 minutes.** Choose the one you had before; Checkup's log shows it, on the line that starts *Password on wake: was*. **Checkup recommends leaving sign-in required** |
| **Part 3, Setting 18 -- Fast Startup** | Turned it off | Control Panel > Power Options > Choose what the power buttons do > Change settings that are currently unavailable > tick **Turn on fast startup (recommended)** > Save changes |
| **Part 3, Setting 19 -- Wake on LAN** | Turned it off on each network adapter | Device Manager > Network adapters > right-click the adapter > Properties > Power Management > tick **Allow this device to wake the computer** |

Number 5 is not used. That check is no longer part of GatewayGuard Checkup.

⚠ VERIFY -- Setting 13: that deleting the two values takes the briefcase away and lets the switches be turned on (reading R5).

⚠ VERIFY -- Settings 12 and 14 (*inferred*, not measured): Checkup sets item 12 with a Windows policy too (build: `HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection`, `AllowTelemetry` = 1). The Settings choice may be locked the same way Edge's switches are. Setting 14 may be the same on Pro. Read both undo paths after a Checkup run before these rows ship (reading R6).

---

## 4.3 A restore point: what it can and cannot do

If you made a restore point before Checkup (Part 1, *Before you start: a safety net*), you have a way to take Windows back to how it was that day.

**Use it if Windows itself misbehaves** -- something that worked yesterday no longer starts, and putting back single settings in 4.2 has not helped. **The steps are in Part 1, *Using a restore point*.**

**Do not use it as a way to undo Checkup.** It may put some of these settings back and not others. For any setting, 4.2 is the reliable way back.

Windows says a restore **does not affect your documents, pictures, or other personal data**, but **recently installed programs and drivers might be uninstalled**. Use **Scan for affected programs** first to see which.

---

## 4.4 If something looks wrong

Find what you are seeing in the left column. The right column says where to go.

| What you notice | Where to go |
|---|---|
| Something stopped working right after Checkup changed a setting | **4.2** -- put that one setting back |
| Windows itself will not behave, and 4.2 did not help | **4.3** -- a restore point |
| A browser opens by itself, or a page keeps reopening every time you start it | **Part 3, Setting 13** first; then **4.5** |
| A pop-up says your computer is infected and gives you a phone number | **Close it. Do not call.** That is the scam. Then **4.5** if you are still worried |
| Someone phoned you, said they are from Microsoft or your bank, and asked to connect to your computer | **Hang up.** Never let someone who called you connect. See **Part 3, Setting 10** on Quick Assist |
| A message says your files are locked and demands money | **4.6 first, now.** Do not pay |
| Emails in your Sent folder you did not send, or sign-in alerts you did not cause | **4.5**, steps 4 to 6 |
| A setting is grey and you cannot click it, or shows a briefcase icon | **Part 3, A Note About Gray or Locked Controls** -- this is usually normal. For Edge's briefcase after Checkup, see **4.2, Setting 13** |

---

## 4.5 If you think the computer is infected

**Read this whole section before you start.** It is longer than the rest of the guide. Nothing here gets worse for waiting a day, and doing it over several days is fine. **If you would rather not do this alone, go to 4.6.**

### Step 1 -- Remove the program you do not recognize

**If you are sure which program it is:** Settings > Apps > **Installed apps**. Find it, click the **...** beside it, and choose **Uninstall**.

**If you are not sure what it is, write the name down and do not remove it.** The wrong removal can stop your computer working properly. Take the name to 4.6.

### Step 2 -- Run the Microsoft Defender Offline Scan

This scan runs **before Windows loads**, so it catches things that hide while the computer is running normally.

1. **Save your work and close everything.** The computer will restart.
2. Press the **Windows key**, type **Windows Security**, and press **Enter**.
3. Click **Virus & threat protection**.
4. Under **Current threats**, click **Scan options**.
5. Choose **Microsoft Defender Antivirus (offline scan)**.
6. Click **Scan now**.

Your computer restarts, and a blue scan screen runs. On our test computer it took about 10 minutes. Then it restarts back to your desktop. **This is expected. Let it finish.**

**Checkup can start this scan for you, with your permission.** Save your work first. After the restart, sign in and run Checkup again, and choose **R** to carry on where you left off.

### Step 3 -- Read what the scan found

In Windows Security, click **Virus & threat protection**, then **Protection history**.

- **If the list says "No recent actions",** there is nothing on it for you to deal with.
- **If there are entries,** write down the name shown on each one. For each item, the status should say it was removed or quarantined. If one says it was allowed, or that action is needed, click it and choose the action offered.

⚠ VERIFY -- the exact status words on an entry (reading R4). Both readings so far (C8, S7) showed *No recent actions*.

### Step 4 -- Check your email accounts

For each email account you have, look at:

- **Recent sign-in activity** -- anything from a place or device you do not recognize?
- **Sent folder** -- anything you did not send?
- **Deleted items** -- password-reset emails you did not ask for?
- **Forwarding and filter rules**, in your email's settings -- any you did not create?

**A forwarding rule you did not create is the serious one.** It means somebody is getting copies of your mail, including password resets. Remove it, change that password at once from a different device, and go to 4.6.

### Step 5 -- Sign out everywhere

For your email and money accounts, look in the account's security settings for **sign out of all sessions** or **sign out everywhere**, and use it. That removes the stored sign-ins that let someone stay in without knowing your password.

### Step 6 -- Change your passwords, most important first

**Change them from a different device if you can** -- a phone, or another computer.

**This week:** your email accounts first, always, because every other account resets through them. Then Microsoft, Google or Apple; banks, credit cards and payment services; tax and health accounts; anything for work.

**This month:** shopping sites with a card saved, and your main social accounts.

**When you get to them:** everything else.

For each one: sign in, change the password, and turn on two-step sign-in if it is offered (Part 5, *Passwords and two-step sign-in*).

**Have you used this account in the past year?** If not, consider closing it instead.

---

## 4.6 Getting help

### If your files are locked and something is demanding money

**Stop. Do not pay. Do not run anything else.** Disconnect from the internet -- unplug the network cable, or turn Wi-Fi off -- and get a person involved today.

The FBI does not support paying a ransom. Paying does not guarantee you will get anything back. Report it to the FBI at **ic3.gov**.

### If someone you trust is going to help you

Quick Assist lets a family member see your screen and help. How to use it safely is in **Part 3, Setting 10**. **Only use it when you called them.**

### Before you ask anyone for help, write these down

- **The screen number** Checkup is showing, if Checkup is open.
- **What you were doing** when the problem started.
- **Where your Checkup log file is** (4.1). Press **I** in Checkup to see the record.
- **The name of anything you did not recognize** (4.5, Steps 1 and 3).

### When to stop and get someone

- **If a scan finds a lot of items**, or the computer behaves strangely in ways that keep changing, stop and get someone to look at it. That is not a failure.
- **If any account on this computer belongs to an employer**, tell their IT people.
- **If you think a particular person is watching your computer, your phone or your accounts,** the advice in this guide is not the right advice. Changing settings can warn the person watching before it stops them. That situation needs people trained for it, and they are reachable before you change anything.

### Who to call

- Someone in your family who is comfortable with computers.
- The shop that sold you the computer.
- Your internet provider, for anything about the connection itself.
- **GatewayGuard:** support@gatewayguard.co. Include the four things above.

**Be careful who you call.** If a pop-up, a phone call or an email tells you your computer is infected and gives you a number, **that is the scam itself.** Real security warnings never ask you to phone anybody. Neither does this guide.

---

# Part 5: Keeping It Safe

---

## 5.1 Passwords and two-step sign-in

### Passwords

**Long beats clever.** A long password, or a short sentence only you would think of, is stronger than a short one full of symbols.

**One password per account.** If one site is broken into, the others stay safe.

**Do not change a good password on a schedule.** Change it when you have a reason: a warning that a site you use was broken into, a sign-in you did not make, or a lost phone or computer. Then change it at once.

[NOTE: *sourced*, `CloudResearch-ascii43-2026-09-05-0018`, items 15-16: NIST SP 800-63B-4 §3.1.1.2; NCSC.]

### Two-step sign-in

Two-step sign-in means that after your password, the account asks for a second thing -- usually a short code. **Turn it on for every account that holds money:** banks, investments, credit cards, and payment services.

There are three kinds, from weakest to strongest:

1. **A code sent by text message.** Much better than nothing. Its weakness is that a criminal can sometimes talk the phone company into moving your number to their phone.
2. **A code from an authenticator app** on your phone. Nobody can steal it by moving your phone number. **This is the one to choose** if your bank offers it.
3. **A passkey**, where your bank offers one. It cannot be tricked out of you by a fake website at all.

**Whichever you use: never type a code into a page you did not open yourself.** A fake page that asks for your code is the one trick that still works against codes.

[NOTE: *sourced*, same research, items 15-17: CISA; NIST SP 800-63B-4 §3.2.9.]

### The 30 seconds

An authenticator app shows a new code every 30 seconds or so. **The time is set by your bank, not by the app**, so the app cannot give you longer. If the code runs out while you are typing, wait for the next one and start again.

**If an old code still works for a few seconds after it changed, that is normal.** Banks allow a short grace period so a slow typist is not locked out. Each code still works only once.

[NOTE: *sourced*, same research, items 18-19: RFC 6238 §4.1, §5.2, §6.]

---

## 5.2 The yearly Windows update, and running Checkup again

About once a year Microsoft releases a large update to Windows 11. **A large update can change or reset some of the settings in this guide.**

**After each large update, run Checkup again.** It checks every setting and offers to fix anything that has moved. Nothing is changed without your approval.

GatewayGuard offers an updated Checkup each year for the new version of Windows. **It is optional.** The copy you have keeps working.

[NOTE: unchanged from 09-26; licence v3.1 §8 still to be confirmed by Claude Code (09-26 question 5).]

---

## 5.3 Habits that keep you safe

- **Let Windows update itself** (Part 2, Setting 1), and restart when it asks.
- **Lock the computer when you walk away.** Press the **Windows key** and **L** together. If you use a PIN, the screen that comes up says **Enter your PIN**; type it when you come back.
- **Keep your encryption recovery key somewhere safe and away from the computer** (Part 2, Setting 8).
- **Never call a phone number shown in a pop-up**, and never let someone who called you connect to your computer (4.4).
- **Be suspicious of any program you did not choose to install.** Write its name down and check it before removing it (4.5, Step 1).
- **Run Checkup again after the yearly Windows update** (5.2).

====================================================================
# CUSTOMER TEXT ENDS
====================================================================

**Open markers: 5,** all waiting on screen readings R1 to R6 (Part 1 step 4; Part 1 *Using a restore point* steps 4-5; 4.2 Setting 13; 4.2 Settings 12 and 14; 4.5 Step 3). Down from 10.

---

## FOR F10 -- WHAT CHECKUP TAKES FROM THIS FILE

**Take now:**

- **4.2, every row except 12, 13 and 14**, as the undo steps on the *What Checkup changed* screen (Decision 4). Use the row text, not the build's `Revert` strings; check whether K4-K6 (items 11, 12, 13) were fixed, and if not, fix them from these rows.
- **4.1** for the screen's own wording about the log and **Open-My-Log**.
- **4.5 Step 2:** Checkup's offline-scan reminder says *"about 15 minutes"*. The guide now says *about 10 minutes on our test computer* (S6). Make them agree; the measured figure wins.
- **Wording rules from the 09-28 brief, B:** no *"nothing has been changed"* where nothing was offered; nothing that invites the reader to reconsider a change.

**Hold until the readings come back:**

| Place | Waits on |
|---|---|
| 4.2 Setting 13 undo | R5 |
| 4.2 Settings 12 and 14 undo | R6 |
| Part 1 step 4 (Create dialog) | R1 -- guide only, not in Checkup |
| Part 1 *Using a restore point* steps 4-5 | R2, R3 -- guide only |
| 4.5 Step 3 status words | R4 -- guide only |

---

## SCREEN READINGS STILL NEEDED -- one line each

| # | PC | Open and read |
|---|---|---|
| R1 | CGDELL | Windows key > type *Create a restore point* > Enter > **Create...** -- read the name box's title, its button, the message after it finishes, and the button that closes it. |
| R2 | CGDELL | Same window > **System Restore...** > **Next >** > click your restore point > **Next >** -- read the page heading and every button on that page, then **Cancel**. |
| R3 | CGDELL | On the restore-point list, click an entry > **Scan for affected programs** -- read the window's headings and what it lists, then close it. |
| R4 | CGDELL | Claude Code drops the standard harmless test file (EICAR) as on 09-08; then Windows Security > Virus & threat protection > **Protection history** > click the new entry -- read the status words and every button. |
| R5 | CGDELL | After a Checkup run: Registry Editor > `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge` > delete **StartupBoostEnabled** and **BackgroundModeEnabled** > close and reopen Edge > Settings > System and performance > Startup boost -- is the briefcase gone, and can both switches be turned on? Then put the two values back with Checkup. |
| R6 | CGDELL | After a Checkup run: Settings > Privacy & security > Diagnostics & feedback -- can **Optional diagnostic data** be chosen, and is there any "managed by your organization" line? Then right-click the taskbar > Taskbar settings -- can **Widgets** be turned On? |
