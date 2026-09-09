<!-- Dated: 2026-09-08 21:30 ET -->
# Where Every Setting Lives, What Checkup Can Do To It, and What It Is Now

- **Document Name:** GatewayGuard_SettingsLocationList
- **Dated:** 2026-09-08 21:30 ET
- **Editor:** Claude Code (CGDELL)
- **Supersedes:** `GatewayGuard_SettingsLocationList-2026-09-08-0924.md`, retired
  to `Archive\`. That one had locations only.
- **For use at the keyboard.**

**Bill, 2026-09-08:** *"update the settings list with checkup status i.e.
blocked can't read or can read, but can't change or can read and change setting
and current setting is x"*

---

## TWO DECISIONS TODAY, AND THEY CHANGE THE LIST

**Bill, 2026-09-08:**

1. **Malwarebytes is OUT of Checkup.** It stays in the guide as an optional
   second opinion the reader may choose. The tool stops orchestrating it.
2. **Setting 5, Defender Periodic Scanning, is OUT of Checkup.** It only means
   anything while another antivirus holds real-time protection -- which is the
   arrangement the tool no longer runs.

**So this is 18 settings, not 19.**

**The IDs are NOT renumbered. 5 is simply gone.** Every log ever written names
items by ID, and the screen table refers to them by ID. Renumbering would make
every earlier log wrong about which setting it was talking about. **A gap in
the numbers costs nothing; a renumber costs the whole field record.**

---

## HOW TO READ THE "CHECKUP" COLUMN

| Code | Means |
|---|---|
| **R+C** | Checkup can **read** it and can **change** it, with your permission |
| **R only** | Checkup can **read** it but **cannot change** it -- it shows you the steps instead |
| **BLOCKED** | Checkup **cannot read** it on this machine at all |

**Everything Checkup changes, it changes only after you say yes.**

---

## THE 18 SETTINGS

***Every value in the last column was measured on CGDELL, 2026-09-08 21:29,
by `Tool2\Run-SettingsStatus.bat`. Read-only. It can be re-run any time, and
it should be run on SANDY, which is Home rather than Pro.***

| # | Setting | Where to find it | Checkup | On CGDELL now |
|---|---|---|---|---|
| 1 | Windows Update | Windows key > type `Windows Update` > Enter | **R+C** | Service Manual / Stopped. **That is normal** -- Windows starts it when needed |
| 2 | Defender Real-Time Protection | Windows Security > Virus & threat protection > Manage settings | **R+C** *(unless another AV holds it)* | **On** |
| 3 | Tamper Protection | Windows Security > Virus & threat protection > Manage settings > scroll down | **R only** -- Windows forbids any program changing it, by design | **On** |
| 4 | SmartScreen (Check apps and files) | Windows Security > App & browser control > Reputation-based protection settings | **R+C** -- the registry write works even when the toggle is greyed | **Warn**, which is On. **Toggle greyed out -- Smart App Control has it. See below** |
| 6 | Edge Phishing Protection (3 options) | Windows Security > App & browser control > Reputation-based protection settings > scroll to Phishing protection | **BLOCKED** -- cannot read it, and writes are refused too | **Cannot be read here.** The screen is the truth for this one, not the registry |
| 7 | Firewall (all profiles) | Windows Security > Firewall & network protection | **R+C** | Domain **On**, Private **On**, Public **On** |
| 8 | BitLocker / Device Encryption | **Pro:** Windows Security > Device security > Manage BitLocker drive encryption. **Home:** Windows key > type `encryption` > Device encryption settings | **R+C** -- but only on its own screen, with explicit permission | **On** (encrypted) |
| 9 | Windows Hello | Windows key > type `sign-in options` > Enter | **R only** -- enrolling a PIN or a face needs the person at the machine | **Not set up** on this PC |
| 10 | Remote Desktop -- Disable | Windows key > type `Remote Desktop settings` -- **all three words** > Enter | **R+C** | **Disabled** -- correct. *Not present on Home at all* |
| 11 | Advertising ID -- Turn Off | Settings > Privacy & security > Recommendations and offers | **R+C** | **Off** -- correct |
| 12 | Diagnostic Data -- Required Only | Windows key > type `Diagnostics & feedback` > Enter | **R+C** | **Not set** -- so Windows' default, which sends the extra data. **Needs attention** |
| 13 | Edge Startup Boost + Background | Edge > three dots > Settings > System and performance. **Open `Startup boost` first** or the toggles do not appear | **R+C** | **Both not set** -- so Edge's defaults, which are On. **Needs attention** |
| 14 | Widgets -- Disable | Windows key > type `taskbar settings` > Enter | **R+C** | **On.** **Needs attention** |
| 15 | Edge Password Saving -- Disable | Edge > three dots > Settings > Passwords | **R+C** | **Not set** -- so Edge's default, which is On |
| 16 | Memory Integrity (Core Isolation) | Windows Security > Device security > Core isolation details | **R+C** -- but needs a **restart** to take effect | **On** |
| 17 | Password Required on Wake | Windows key > type `sign-in options` > Enter, then Require sign-in | **BLOCKED right now** -- see the note below | **Could not read.** ***This is FT-256 happening live on this machine*** |
| 18 | Fast Startup -- Disable | **Control Panel** > Hardware and Sound > Power Options > Choose what the power buttons do > **Change settings that are currently unavailable** | **R+C** | **Off** -- correct |
| 19 | Wake on LAN -- Disable | **Device Manager** > Network adapters > right-click each > Properties > Power Management | **R+C** | **Ethernet = Enabled**, Wi-Fi = Disabled. **Needs attention on Ethernet** |

**~~5~~ Defender Periodic Scanning -- REMOVED, Bill's decision 2026-09-08.**

### Six of these need attention on this machine

**Measured, not guessed:** **12** Diagnostic Data, **13** Edge startup boost and
background, **14** Widgets, **15** Edge password saving, **19** Wake on LAN on
the Ethernet adapter -- and **9** Windows Hello has no PIN set up. **Everything
security-critical is already correct**: real-time protection, tamper
protection, firewall on all three profiles, BitLocker, and memory integrity.

### The one live defect on this list

**Setting 17 could not be read at all.** ***Measured: `powercfg` returned no
CONSOLELOCK block, so there was nothing to parse.*** **The shipped build
reports "Not required -- needs attention" in exactly this situation, from a
read that produced nothing.** That is FT-256, raised in ascii44 and not yet
fixed, and this machine is now a live example rather than a theory.

---

## THE APP-BLOCKING SETTINGS

**All in one place:**
**Windows Security > App & browser control > Reputation-based protection settings**

| Toggle | It should say | Note |
|---|---|---|
| Check apps and files | **On** | Setting 4. **Greyed out here** -- Smart App Control has taken it over |
| SmartScreen for Microsoft Edge | **On** | ***Confirmed by Bill, 2026-09-08.*** It also has its own on/off inside Edge: three dots > Settings > **Privacy, search, and services** > **Security**, called **Protect from harmful sites and downloads**, with a second toggle **Share detected scam sites**. Both On |
| **Potentially unwanted app blocking** | **On**, and **open it** -- **two** tick boxes inside | `Block apps` is on and greyed. **`Block downloads` is yours to tick** -- see below |
| SmartScreen for Microsoft Store apps | **On** | |
| Phishing protection -- Warn me about malicious apps and sites | **On** | These three are setting 6 |
| Phishing protection -- Warn me about password reuse | **On** | |
| Phishing protection -- Warn me about unsafe password storage | **On** | |

### 1. Block downloads is still yours to tick

***Measured 2026-09-07: `Block apps` is on; `Block downloads` was left for a
tick box on purpose.*** Setting it from a script means writing an Edge policy
key, which **marks your browser as managed by an organisation and greys the
setting out in Edge's own options.**

> Windows Security > App & browser control > Reputation-based protection
> settings > **Potentially unwanted app blocking** > tick **Block downloads**

### 2. The three phishing toggles cannot be set by any program here

***Measured 2026-09-07: all four writes returned "Requested registry access is
not allowed."*** Tamper Protection refuses them. They must be ticked by hand.

**And reading them back does not work either:** ***measured the same day, all
four values read NOT SET while the screen showed all four ticked ON.*** **For
this one group the screen is the truth and the registry is not.** Checkup's
"Unknown -- Tamper Protection blocks this check" is the correct answer.

### 3. Smart App Control is on, and it takes two of these over

***Measured on CGDELL 2026-09-08: `VerifiedAndReputablePolicyState = 1`, On and
enforced.***

**It greys out `Check apps and files` and `Block apps`, and forces both On.**
Neither is a fault and neither is something Checkup did. **A greyed control is
the thing a reader assumes they broke**, so the guide needs one plain sentence.

**Where to look at it:** Windows Security > App & browser control > **Smart App
Control** -- On / Evaluation / Off. ***On here.***

**FT-260:** Checkup cannot see this kind of lock. Its policy check reads only
`HKLM\SOFTWARE\Policies`; Smart App Control locks from
`HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy`, and ***the build has zero
occurrences of it.*** ***Measured: on this machine no Group Policy is forcing
anything, and the one thing that IS forcing a setting is the one the check
cannot see.***

---

## HOW TO RE-RUN THIS

**`Tool2\Run-SettingsStatus.bat`** -- double-click it. **Read-only, changes
nothing**, writes a text file into `Test_Results\`. Run it as a normal user
first; a couple of rows read more when run as administrator, and they say so
rather than guessing.

**It should be run on SANDY.** SANDY is Windows 11 Home, and three rows behave
differently there: Remote Desktop does not exist, BitLocker is Device
Encryption, and Smart App Control may not be on.

---

## SOURCES

- `Test_Results\SettingsStatus-CGDELL-2026-09-08_21-29.txt` -- every value in
  the last column.
- `ProjectDocs\GatewayGuard_WebsiteSourcePack-2026-08-22-2235.md` -- the 19
  guide pages; every location was extracted from them, not retyped.
- `Test_Results\ReputationSettings-CGDELL-2026-09-07_13-25.txt` -- the four
  refused writes and the `Block downloads` decision.
- `Test_Results\PhishingStates-CGDELL-2026-09-07_16-11.txt` -- the screen
  saying On while the registry said NOT SET.
- `ProjectDocs\GatewayGuard_SettingsReadVsChange-2026-09-08-0901.md` -- the
  read-versus-change analysis with build line numbers.
- Bill at the screen, 2026-09-08 -- SmartScreen for Microsoft Edge, and the two
  decisions at the top of this document.
