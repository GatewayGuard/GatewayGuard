<!-- Dated: 2026-09-28 21:23 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# For Copilot, document 1 of 3 -- the security guide's new parts, read as a senior would

**Bill: paste everything below the line into Copilot.**

---

**What this is.** A draft of three new parts of the GatewayGuard security guide, for home users of Windows 11, many of them over 70:
a short "safety net" section for Part 1, Part 4 (after Checkup: what changed, how to put it back, what to do if something looks wrong) and Part 5 (keeping it safe).

**Please read it as a 75-year-old who is not good with computers.** List every sentence you would not understand, or could not act on without help.
For each one: **quote the sentence exactly**, say **what confused you**, and say **what you would have needed** to act on it.
**Do not rewrite the document.** Do not add advice of your own. Do not recommend any product -- the guide names only Microsoft Defender, on purpose.

**Already known -- please do not comment on these:**
1. Settings 1, 8 and 17 in the 4.2 table still need their exact button words read off a real screen (a separate job).
2. "Checkup" is the name of the GatewayGuard program; "Setting N" refers to the guide's numbered settings in Parts 2 and 3, which you do not have. Number 5 is deliberately unused.
3. Part 4, 4.1: pressing I in Checkup shows the build, Machine ID and where the record is kept, not the record itself. That wording will be corrected.
4. Part 4, 4.5 Step 3: the full route is Windows Security > Virus & threat protection > Protection history. That wording will be corrected.

**How to answer:** a numbered list. One sentence per number. Keep it to what a senior would struggle with.

---

## Part 1 addition -- Before you start: a safety net


### Make a restore point first

A restore point is a snapshot of how Windows is set up at one moment. If Windows itself starts misbehaving after a change, you can take it back to that moment.

It takes about a minute to make one. Do it before you run Checkup.

1. Press the **Windows key**, type **Create a restore point**, and press **Enter**.
2. On the window that opens, click **Create**.
3. Type a name you will recognize, such as *Before Checkup*, and click **Create**.
4. Wait for the message that says it was created, then click **Close**.


**What a restore point is, and what it is not.** It is a safety net for Windows. **It is not an undo button for the settings in this guide.** Some of them it puts back and some it does not. Part 4 shows you how to put back each setting on its own, which is the reliable way.


---

# Part 4: After Checkup -- What Changed, How to Put It Back, and What to Do If Something Looks Wrong

Every change in Parts 2 and 3 can be put back. This part shows how for each one, and what to do if something does not look right afterward.

---

## 4.1 What Checkup changed

Checkup writes down everything it does, as it does it. You never need to copy anything off the screen.

**While Checkup is running,** press **I** on any screen that offers it to see the record so far.

**After Checkup has finished,** the record is a file in your GatewayGuard folder.


[UPDATED by Claude Code, 2026-09-28 -- now built] At the end of the run, Checkup shows a screen called **What Checkup changed**. It lists each setting you selected: what it **was**, and what it is **now**. Anything that still needs you is then shown on **Steps for you to do**, one item per screen.

**Keep the record.** If you ever ask for help, it is the most useful thing you can send.

---

## 4.2 Putting a setting back

For each setting: what Checkup may have changed, and the clicks to reverse it. Where to find each setting in the first place is in that setting's **How To Check**, in Part 2 or Part 3.

**Before you put a security setting back, ask why.** The settings in Part 2 protect you. If something stopped working after a change, it is usually quicker to fix that one thing than to switch the protection off. See 4.4.

| Setting | What Checkup may have changed | To put it back |
|---|---|---|
| **Part 2, Setting 1 -- Windows Update** | Turned automatic updates on | GatewayGuard does not recommend turning updates off. Windows Update's own screen lets you pause updates for a short time. |
| **Part 2, Setting 2 -- Microsoft Defender Real-Time Protection** | Turned it on, only if no other antivirus was in charge | Windows Security > Virus & threat protection > Manage settings > Real-time protection **Off**. Only do this if support asks you to |
| **Part 2, Setting 3 -- Tamper Protection** | Nothing. Checkup only checks this one | Nothing to put back |
| **Part 2, Setting 4 -- SmartScreen** | Turned the protections on | Windows Security > App & browser control > Reputation-based protection settings. Turn off whichever of the four you want off: Check apps and files, SmartScreen for Microsoft Edge, Potentially unwanted app blocking, SmartScreen for Microsoft Store apps |
| **Part 2, Setting 6 -- Enhanced Phishing Protection** | Turned the warnings on | Windows Security > App & browser control > Reputation-based protection settings > under **Phishing protection**, untick the *Warn me about* boxes |
| **Part 2, Setting 7 -- Firewall & network protection** | Turned on any network type that was off | GatewayGuard does not recommend turning any of these off. Windows Security > Firewall & network protection > choose the network type > turn it off |
| **Part 2, Setting 8 -- BitLocker Data Encryption** | Turned encryption on, on its own screen, after you saved your recovery key | Turning encryption off takes a long time, like turning it on, and your PC should stay plugged in. **Keep your recovery key** either way. |
| **Part 2, Setting 9 -- Windows Hello** | Nothing. Checkup only checks this one | Nothing to put back |
| **Part 3, Setting 10 -- Remote Desktop** (Windows 11 Pro only) | Turned it off | Settings > System > Remote Desktop > **On** |
| **Part 3, Setting 11 -- Advertising ID** | Turned it off | Settings > Privacy & security > Recommendations and offers > turn **Let apps show me personalized ads by using my advertising ID** back on |
| **Part 3, Setting 12 -- Diagnostic Data** | Chose Required diagnostic data | Settings > Privacy & security > Diagnostics & feedback > choose **Optional diagnostic data** |
| **Part 3, Setting 13 -- Edge Startup Boost** | Turned off both parts | Edge > Settings > System and performance > open **Startup boost** first > turn **Startup boost** and **Continue running background extensions and apps** back on |
| **Part 3, Setting 14 -- Windows Widgets** | Turned Widgets off | Right-click the taskbar > Taskbar settings > **Widgets On** |
| **Part 3, Setting 15 -- Edge Password Saving** | Turned it off, only if you told Checkup you use a password manager | Edge > Settings > Passwords > **Offer to save passwords On**. Turning it off never deleted the passwords Edge already had |
| **Part 2, Setting 16 -- Memory Integrity** | Turned it on | Windows Security > Device security > Core isolation > **Memory integrity Off**, then restart |
| **Part 2, Setting 17 -- Password Required on Wake** | Set sign-in to be required when the PC wakes | Settings > Accounts > Sign-in options > under *If you've been away, when should Windows require you to sign in again?*, choose **Never**. |
| **Part 3, Setting 18 -- Fast Startup** | Turned it off | Control Panel > Power Options > Choose what the power buttons do > Change settings that are currently unavailable > tick **Turn on fast startup (recommended)** > Save changes |
| **Part 3, Setting 19 -- Wake on LAN** | Turned it off on each network adapter | Device Manager > Network adapters > right-click the adapter > Properties > Power Management > tick **Allow this device to wake the computer** |

Number 5 is not used. That check is no longer part of GatewayGuard Checkup.


---

## 4.3 A restore point: what it can and cannot do

If you made a restore point before Checkup (Part 1, *Before you start: a safety net*), you have a way to take Windows back to how it was that day.

**Use it if Windows itself misbehaves** -- something that worked yesterday no longer starts, and putting back single settings in 4.2 has not helped.

**Do not use it as a way to undo Checkup.** Some settings in this guide live inside programs such as Edge, or are protected by Windows, and a restore point does not touch them. Encryption is never undone by a restore point. For any setting, 4.2 is the reliable way back.


**To use a restore point:**

1. Press the **Windows key**, type **Create a restore point**, and press **Enter**.
2. Click **System Restore**, then **Next**.
3. Choose the restore point you made, click **Next**, then **Finish**.

Your computer restarts. Your documents, photos and emails are not changed by a restore point.


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
| A setting is grey and you cannot click it | **Part 3, A Note About Gray or Locked Controls** -- this is usually normal |

---

## 4.5 If you think the computer is infected

**Read this whole section before you start.** It is longer than the rest of the guide. Nothing here gets worse for waiting a day, and doing it over several days is fine. **If you would rather not do this alone, go to 4.6.**

### Step 1 -- Remove the program you do not recognize

If you know which program it is: **Settings > Apps > Installed apps.** Find it, click the three dots beside it, and choose **Uninstall**.


**If you are not sure what it is, write the name down and do not remove it.** The wrong removal can stop your computer working properly. Take the name to 4.6.

### Step 2 -- Run the Microsoft Defender Offline Scan

This scan runs **before Windows loads**, so it catches things that hide while the computer is running normally.

1. **Save your work and close everything.** The computer will restart.
2. Press the **Windows key**, type **Windows Security**, and press **Enter**.
3. Click **Virus & threat protection**.
4. Under **Current threats**, click **Scan options**.
5. Choose **Microsoft Defender Antivirus (offline scan)**.
6. Click **Scan now**.

Your computer restarts, a blue scan screen runs for 10 to 20 minutes, and then it restarts back to your desktop. **This is expected. Let it finish.**


**Checkup can start this scan for you, with your permission,** and sets up a reminder to run it four times a year.


### Step 3 -- Read what the scan found

In Windows Security, open **Protection history**. For each item listed, the status should say it was removed or quarantined. If one says it was allowed, or that action is needed, click it and choose the action offered.


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


### If someone you trust is going to help you

Quick Assist lets a family member see your screen and help. How to use it safely is in **Part 3, Setting 10**. **Only use it when you called them.**

### Before you ask anyone for help, write these down

- **The screen number** Checkup is showing, if Checkup is open.
- **What you were doing** when the problem started.
- **Where your Checkup record is** (4.1). Press **I** in Checkup to see it.
- **The name of anything you did not recognize** (4.5, Step 1).

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


### Two-step sign-in

Two-step sign-in means that after your password, the account asks for a second thing -- usually a short code. **Turn it on for every account that holds money:** banks, investments, credit cards, and payment services.

There are three kinds, from weakest to strongest:

1. **A code sent by text message.** Much better than nothing. Its weakness is that a criminal can sometimes talk the phone company into moving your number to their phone.
2. **A code from an authenticator app** on your phone. Nobody can steal it by moving your phone number. **This is the one to choose** if your bank offers it.
3. **A passkey**, where your bank offers one. It cannot be tricked out of you by a fake website at all.

**Whichever you use: never type a code into a page you did not open yourself.** A fake page that asks for your code is the one trick that still works against codes.


### The 30 seconds

An authenticator app shows a new code every 30 seconds or so. **The time is set by your bank, not by the app**, so the app cannot give you longer. If the code runs out while you are typing, wait for the next one and start again.

**If an old code still works for a few seconds after it changed, that is normal.** Banks allow a short grace period so a slow typist is not locked out. Each code still works only once.


---

## 5.2 The yearly Windows update, and running Checkup again

About once a year Microsoft releases a large update to Windows 11. **A large update can change or reset some of the settings in this guide.**

**After each large update, run Checkup again.** It checks every setting and offers to fix anything that has moved. Nothing is changed without your approval.

GatewayGuard offers an updated Checkup each year for the new version of Windows. **It is optional.** The copy you have keeps working.


---

## 5.3 Habits that keep you safe

- **Let Windows update itself** (Part 2, Setting 1), and restart when it asks.
- **Lock the computer when you walk away.** Press the Windows key and L together. Setting 17 makes it ask for your PIN when it wakes.
- **Keep your encryption recovery key somewhere safe and away from the computer** (Part 2, Setting 8).
- **Never call a phone number shown in a pop-up**, and never let someone who called you connect to your computer (4.4).
- **Be suspicious of any program you did not choose to install.** Write its name down and check it before removing it (4.5, Step 1).
- **Run Checkup again after the yearly Windows update** (5.2).
