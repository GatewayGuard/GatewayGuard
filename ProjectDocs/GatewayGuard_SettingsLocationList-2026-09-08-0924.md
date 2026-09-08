<!-- Dated: 2026-09-08 09:24 ET -->
# Where Every Setting Lives -- One Line Each

- **Document Name:** GatewayGuard_SettingsLocationList
- **Dated:** 2026-09-08 09:24 ET
- **Editor:** Claude Code (CGDELL)
- **What this is:** the 19 Checkup settings plus the app-blocking group, one
  line each, saying where to find it and what it should say when you get
  there. For use at the keyboard.
- **Where the paths came from:** the 19 guide pages, extracted mechanically
  from `ProjectDocs\GatewayGuard_WebsiteSourcePack-2026-08-22-2235.md`, not
  retyped. Those pages are the reviewed, rule-checked wording. **Two settings
  are not in Settings at all** -- 18 is in Control Panel and 19 is in Device
  Manager -- and those two lines say so.

---

## HOW TO OPEN THE THREE PLACES EVERYTHING LIVES

| Place | How to open it |
|---|---|
| **Windows Security** | Press the Windows key, type `windows security`, press Enter |
| **Settings** | Press the Windows key, type `settings`, press Enter -- or press Windows + I |
| **Control Panel** | Press the Windows key, type `control panel`, press Enter |

**Faster for most of these: press the Windows key and type the name of the
page itself** -- `sign-in options`, `taskbar settings`, `device manager`.
Windows takes you straight there.

---

## THE 19 SETTINGS

| # | Setting | Where to find it | It should say |
|---|---|---|---|
| 1 | Windows Update | Windows key > type `Windows Update` > Enter | **You're up to date.** Then Advanced options: three toggles **On** |
| 2 | Defender Real-Time Protection | Windows Security > Virus & threat protection > Manage settings | Real-time protection **On** (toggle blue) |
| 3 | Tamper Protection | Windows Security > Virus & threat protection > Manage settings > scroll to Tamper Protection | **On** |
| 4 | SmartScreen (Check apps and files) | Windows Security > App & browser control > Reputation-based protection settings | Check apps and files **On** |
| 5 | Defender Periodic Scanning | Windows Security > Virus & threat protection > Microsoft Defender Antivirus options | Periodic scanning **On** -- **if you do not see this section at all, Defender is your main antivirus and this does not apply.** That is correct, not a fault |
| 6 | Edge Phishing Protection | Windows Security > App & browser control > Reputation-based protection settings > scroll to Phishing protection | All **three** sub-options **On** (see the app-blocking table below) |
| 7 | Firewall | Windows Security > Firewall & network protection | Domain, Private and Public all **On**. The first screen shows all three -- no need to open them one at a time |
| 8 | BitLocker / Device Encryption **(Home)** | Windows key > type `encryption` > Device encryption settings | Device encryption **On**. **No such page = your PC does not support it.** Hardware, not a mistake |
| 8 | BitLocker **(Pro)** | Windows Security > Device security > Manage BitLocker drive encryption | Your C: drive says **BitLocker on** |
| 9 | Windows Hello | Windows key > type `sign-in options` > Enter | Windows Hello PIN shows a **Change** button. If it shows **Add**, no PIN is set up |
| 10 | Remote Desktop | Windows key > type `Remote Desktop settings` -- **all three words** > Enter | Remote Desktop **Off**. **Not on Windows 11 Home at all** -- nothing to do |
| 11 | Advertising ID | Settings > Privacy & security > Recommendations and offers | Advertising ID **Off** |
| 12 | Diagnostic Data | Windows key > type `Diagnostics & feedback` > Enter | **Required diagnostic data** selected, not Optional |
| 13 | Edge Startup Boost + Background | Edge > three dots (top right) > Settings > System and performance | **Open `Startup boost` first** -- the toggles only appear once you have. Both **Off** |
| 14 | Widgets | Windows key > type `taskbar settings` > Enter | Widgets **Off** |
| 15 | Edge Password Saving | Edge > three dots > Settings > Passwords | Offer to save passwords **Off** |
| 16 | Memory Integrity | Windows Security > Device security > Core isolation details | Memory integrity **On**. Turning it on needs a **restart** |
| 17 | Password Required on Wake | Windows key > type `sign-in options` > Enter | Under Require sign-in: **When PC wakes from sleep** (not Never) |
| 18 | Fast Startup | **Control Panel** > Hardware and Sound > Power Options > Choose what the power buttons do > **Change settings that are currently unavailable** | Under Shutdown settings, **Turn on fast startup** has **no tick** |
| 19 | Wake on LAN | **Device Manager** > Network adapters > right-click an adapter > Properties > Power Management tab | **Allow this device to wake the computer** is **unticked**. **Do every adapter** -- most PCs have two. No Power Management tab = that one cannot wake the PC, nothing to change |

**Three of these are not where a reader would guess, and that is the whole
reason for this list:**

- **18 is in Control Panel, not Settings**, and the tick box is greyed out
  until you click **Change settings that are currently unavailable**.
- **19 is in Device Manager**, per network adapter, and **doing one adapter
  and not the other leaves the door open.**
- **13 will not show its toggles until you click Startup boost first.**

---

## THE APP-BLOCKING SETTINGS

**All of these live in one place:**
**Windows Security > App & browser control > Reputation-based protection settings**

| Toggle | It should say | Note |
|---|---|---|
| Check apps and files | **On** | This is setting 4. ***Measured on CGDELL 2026-09-07: it reads back as `Warn`, which is On*** |
| SmartScreen for Microsoft Edge | **On** | **Confirmed by Bill on CGDELL, 2026-09-08 -- it IS on this screen**, as its own on/off separate from Check apps and files. **It also has a second on/off inside Edge:** three dots > Settings > Privacy, search, and services. **Two controls, same protection.** *Confirmed on Windows 11 Pro 25H2; not yet looked at on Home* |
| **Potentially unwanted app blocking** | **On**, and **open it** -- it has **two** tick boxes inside | See the note below. This is the one that catches the junk installers |
| SmartScreen for Microsoft Store apps | **On** | |
| **Phishing protection** -- Warn me about malicious apps and sites | **On** | These three together are setting 6 |
| **Phishing protection** -- Warn me about password reuse | **On** | |
| **Phishing protection** -- Warn me about unsafe password storage | **On** | |

### Two things about this group that are worth knowing before you look

**1. Potentially unwanted app blocking has two halves, and only one is on.**
***Measured on CGDELL 2026-09-07: `Block apps` is on; `Block downloads` was
left for you to tick by hand, on purpose.*** Setting `Block downloads` from a
script means writing an Edge policy key, which **marks your browser as managed
by an organisation and greys the setting out in Edge's own options.** A tick
box is better than that.

> Windows Security > App & browser control > Reputation-based protection
> settings > **Potentially unwanted app blocking** > tick **Block downloads**

**2. The three phishing toggles cannot be set by any program on this PC.**
***Measured on CGDELL 2026-09-07, all four writes returned "Requested registry
access is not allowed" -- Tamper Protection refuses them.*** They have to be
ticked by hand at the screen above.

**And a warning about reading them back:** ***measured the same day, all four
registry values read NOT SET while the screen showed all four ticked ON.***
**For this one group, the screen is the truth and the registry is not.** If
Checkup says "Unknown -- Tamper Protection blocks this check", that is the
correct answer and not a fault.

---

## WHAT CHECKUP CAN AND CANNOT DO TO THESE

Short version, so this list is usable on its own. Full detail with line
numbers: `GatewayGuard_SettingsReadVsChange-2026-09-08-0901.md`.

- **Checkup cannot change 2 of the 19 by design:** Tamper Protection (3) and
  Windows Hello (9). It shows the steps instead.
- **It cannot change 5 more in certain conditions:** Edge phishing (6) when
  Tamper Protection refuses, Defender real-time (2) and periodic scanning (5)
  when another antivirus holds the slot, Memory integrity (16) until a
  restart, and BitLocker (8) which always waits for your permission on its own
  screen.
- **It cannot read Edge phishing (6) at all on this machine**, and 9 others
  can come back "Unknown" if a read fails.
- **Everything Checkup changes, it changes only after you say yes.**

---

## SOURCES

- `ProjectDocs\GatewayGuard_WebsiteSourcePack-2026-08-22-2235.md` -- the 19
  guide pages; every path in the first table was extracted from them.
- `Test_Results\ReputationSettings-CGDELL-2026-09-07_13-25.txt` -- the
  app-blocking measurements, including the four refused writes and the
  `Block downloads` decision.
- `Test_Results\PhishingStates-CGDELL-2026-09-07_16-11.txt` -- the screen
  saying ON while the registry said NOT SET.
- `Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1` -- the settings
  table itself, 19 items.
- **Bill at the screen, CGDELL, 2026-09-08** -- the SmartScreen for Microsoft
  Edge row. He looked because the row said it was unverified, and it was the
  fastest way to settle it. *Windows 11 Pro 25H2; the Home machines have not
  been looked at.*
