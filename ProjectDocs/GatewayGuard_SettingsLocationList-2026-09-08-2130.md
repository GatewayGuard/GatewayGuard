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

**BLOCKED now covers one setting only: 6 (Edge Phishing Protection),**
blocked by Windows itself on any machine -- Tamper Protection refuses the
read everywhere. *(Updated 2026-09-26. Setting 17 used to sit here as
"unreadable on this machine". That was wrong about the cause -- see row 17
and FT-268 below.)*

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
| 13 | Edge Startup Boost + Background | Edge > three dots > Settings > System and performance. **Open `Startup boost` first** or the toggles do not appear | **R+C** -- policy still unset; live-state fallback added 2026-09-17, FT-123b, key confirmed against the real Edge screen | ***Measured 2026-09-17, Bill's field test plus a direct screen check:*** Continue running background extensions and apps **On**; Startup boost read **Off at 15:11, On at 15:43** -- ***Bill confirmed by looking at Edge's own screen that Startup boost is genuinely On***, matching the second read. This is a live setting that moved between two checks, not a defect in the read. **Needs attention** (both halves, currently). Superseded the 09-08 "both not set, assume Edge defaults" guess -- these are the real live values, not an assumption. |
| 14 | Widgets -- Disable | Windows key > type `taskbar settings` > Enter | **R+C** -- policy still unset; live-state fallback added 2026-09-17, FT-123b, using `TaskbarDa`, ***flip-proven*** by Bill's field test (1 before, 0 after turning Widgets off, 1 after restoring) | **On.** **Needs attention** |
| 15 | Edge Password Saving -- Disable | Edge > three dots > Settings > Passwords | **R+C** | **Not set** -- so Edge's default, which is On |
| 16 | Memory Integrity (Core Isolation) | Windows Security > Device security > Core isolation details | **R+C** -- but needs a **restart** to take effect | **On** |
| 17 | Password Required on Wake | Windows key > type `sign-in options` > Enter, then Require sign-in | **R+C in ascii45** *(updated 2026-09-26)*. **FT-268: it was never unreadable -- ascii44 asked the wrong way.** `powercfg /query` leaves out HIDDEN settings and CONSOLELOCK is hidden; `powercfg /qh` includes it. ***Measured on CGDELL 2026-09-24/25: `/query` returns the header only, `/qh` returns AC and DC index 0x1*** (`Test_Results\SandyForAscii45-CGDELL-2026-09-25_16-36.txt`, section 5). ***ascii45's reader, extracted from the build and run live 2026-09-26, returns REQUIRED*** (commit `e54ff57`). ascii44 and earlier still read NO_INDEX here. SANDY confirmation: step 5 of `Tool2\Run-MeasureSandyForAscii45.bat`. | **Required on wake -- on (AC and battery).** The 09-17 "Could not read" came from the wrong switch. |
| 18 | Fast Startup -- Disable | **Control Panel** > Hardware and Sound > Power Options > Choose what the power buttons do > **Change settings that are currently unavailable** | **R+C** | **Off** -- correct |
| 19 | Wake on LAN -- Disable | **Device Manager** > Network adapters > right-click each > Properties > Power Management | **R+C** | **Ethernet = Enabled**, Wi-Fi = Disabled. **Needs attention on Ethernet** |

**~~5~~ Defender Periodic Scanning -- REMOVED, Bill's decision 2026-09-08.**

### Six of these need attention on this machine

**Measured, not guessed:** **12** Diagnostic Data, **13** Edge startup boost and
background, **14** Widgets, **15** Edge password saving, **19** Wake on LAN on
the Ethernet adapter -- and **9** Windows Hello has no PIN set up. **Everything
security-critical is already correct**: real-time protection, tamper
protection, firewall on all three profiles, BitLocker, and memory integrity.

### The question that was open here -- ANSWERED 2026-09-26 (FT-268)

**Answer: setting 17 can be read on CGDELL, with `powercfg /qh`.** The section
below asked whether it was a CGDELL-only gap or a wider one. It was neither:
`/query` omits hidden power settings on every machine, and CONSOLELOCK is
hidden. ascii45 reads it with `/qh` (row 17). The Co-Pilot suggestion at the
end -- find another way to read it -- is no longer needed. **Co-Pilot's
2026-09-26 review repeated the old "unreadable on CGDELL" conclusion and
described the code as using `powercfg /query`.** Bill gave it the ascii45 text
copy (`Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059-1.txt`, ***measured
identical to the build***), which has **0** `/query CONSOLELOCK` lines and **2**
`/qh` lines; `Tool\ascii44.txt` has the reverse. Co-Pilot's reply opens "my
review of ascii44.txt", so it answered from ascii44's code -- ***inferred:***
from the ascii44 copy it had earlier in the same conversation.

*The original text, kept for the record:*

**Setting 17 cannot be read on CGDELL.** ***Measured: `powercfg` returns no
CONSOLELOCK block, so there is nothing to parse.*** **Before FT-256 (fixed
2026-09-08), the shipped build reported "Not required -- needs attention" in
exactly this situation -- a verdict from a read that produced nothing.**
That is fixed: the build now reports "Could not read," honestly, and leaves
the item selected rather than hiding it. **What FT-256 did not and could not
fix is whether this specific machine's `powercfg` output has a CONSOLELOCK
line to read at all** -- re-measured live 2026-09-17 with the fixed reader,
still `NO_INDEX`. Not yet tested on SANDY or any other machine, so whether
this is a CGDELL-only gap or a wider one is still open.

**Worth investigating for ascii45, not done here:** whether Windows exposes
"Require sign-in after sleep" through something other than `powercfg`'s
CONSOLELOCK index -- the registry directly, Local Security Policy, or the
modern Settings provider behind Accounts > Sign-in options. `powercfg` is
proven, by this machine, not to be guaranteed to expose it. Raised by
Co-Pilot's review, 2026-09-17 -- not yet checked against any source.

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
| Phishing protection -- Automatically collect website or app content when additional analysis is needed to help identify security threats | **Off** | ***Confirmed by Bill's screenshot 92, 2026-09-17: Windows shows this as a fourth checkbox in the same group, checked On on this PC.*** **Not setting 6, and not recommended on** -- it sends more of the screen to Microsoft than the three warnings need in order to work. Checkup does not set this one either way; the guide says so. |

### 1. Block downloads is still yours to tick

***Measured 2026-09-07: `Block apps` is on; `Block downloads` was left for a
tick box on purpose.*** Setting it from a script means writing an Edge policy
key, which **marks your browser as managed by an organisation and greys the
setting out in Edge's own options.**

> Windows Security > App & browser control > Reputation-based protection
> settings > **Potentially unwanted app blocking** > tick **Block downloads**

### 2. The phishing toggles cannot be set by any program here

***Measured 2026-09-07: all four writes returned "Requested registry access is
not allowed."*** **This document only named three of those four rows until
2026-09-17** -- the fourth, "Automatically collect website or app content...",
was tested the same day as the other three but never given its own row, which
is exactly the gap Bill's own question about "3 of the 4" ran into. Tamper
Protection refuses all four writes. They must be ticked or unticked by hand.

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

## FIELD RESULTS ON FILE, BY SETTING -- CHECK THIS BEFORE CHANGING ANY WORDING

**Added 2026-09-17, after FT-262: a correct, dated, field-measured finding
about setting 6 sat unread in `ProjectDocs\` for three weeks and was
re-derived from scratch instead of read.** Before writing or changing what
any setting's guide text, website page, or build screen says, check this
list. If the setting is not listed, none exists yet.

| Setting | Field result on file | What it found |
|---|---|---|
| 3, Tamper Protection | *(none yet -- see FT-263, CLAUDE.md)* | `Apply-Setting`'s detailed, Malwarebytes/trial-aware manual steps for this setting can never run; the live checklist and the Guide both show only a generic line |
| 6, Enhanced Phishing Protection | `GatewayGuard_FieldResult-PhishingProtection-2026-08-26-1130.md` | Four checkboxes on screen, Checkup's own item only ever sets three; drafted the exact replacement wording for the build's manual-steps line (applied 2026-09-17, FT-262) |
| 14, Windows Widgets | `GatewayGuard_FieldResult-LockScreenWidgets-2026-08-26-1030.md` | Lock screen widgets are automatable; the widget opens a browser |

**Not setting-specific, but worth the same check before touching F4/scan
scope:** `GatewayGuard_FieldResult-FullScanCoversD-2026-08-27-1500.md`.

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
