<!-- Dated: 2026-08-24 09:17 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Item 15 -- the fourth phishing item, and Item 20 -- Wake on LAN

- **Document Name:** GatewayGuard_Research-Items15and20
- **Last Modified:** 2026-08-24 09:17 ET
- **Answers:** Bill's items 15 and 20, both marked "research same as Q7"
- **Status:** Both answered. **Item 15 raises a bigger question about Checkup's
  setting 6 that needs one SANDY measurement.**

---

# ITEM 15 -- THE FOURTH ITEM IS NOT A WARNING. IT IS DATA COLLECTION.

**Bill's screenshot settled this without any searching.**
`Test_Results\Html_Website_Review-images\item15-phishing.png` shows the
**Phishing protection** section with four checkboxes:

1. Warn me about malicious apps and sites
2. Warn me about password reuse
3. Warn me about unsafe password storage
4. **Automatically collect website or app content when additional analysis is
   needed to help identify security threats**

**The guide covers the first three. They are all warnings. The fourth is a
different kind of thing entirely -- it uploads content to Microsoft.**

## WHAT IT ACTUALLY SENDS

*sourced, Microsoft Learn, Enhanced Phishing Protection, updated 2025-04-15:*

> *"If users type their work or school password into a website or app that
> SmartScreen finds suspicious, Enhanced Phishing Protection can automatically
> collect information from that website or app to help identify security
> threats. For example, **the content displayed, sounds played, and application
> memory**."*

**Application memory.** That is the phrase a senior would want to know about,
and it is Microsoft's own wording.

**Microsoft's default, which is the fact that decides this:**

> *"Automatic Data Collection -- Default Value: **Enabled** for domain joined
> devices or devices enrolled with MDM. **Disabled for all other devices**."*

**A home PC is "all other devices." Microsoft ships this OFF for exactly
GatewayGuard's audience.** Microsoft does recommend Enabled -- but that
recommendation sits under a heading reading *"Recommended settings for **your
organization**"*, and the reasoning given is *"to improve Microsoft's threat
intelligence."* That is an argument for Microsoft, not for the reader.

## RECOMMENDATION FOR ITEM 15

**Do not recommend turning the fourth item on. Explain it, and leave it alone.**

Four reasons, strongest first:

1. **Microsoft turns it off by default on home PCs.** Recommending someone
   switch on a thing their vendor deliberately left off, for the vendor's
   benefit, needs a better reason than we have.
2. **It is data collection, not protection.** Nothing about the reader's safety
   improves when it is on. The three warnings are the protection.
3. **It sends application memory.** Whatever the safeguards, that sentence
   cannot be made comfortable for a non-technical reader, and hiding it would
   be worse.
4. **It contradicts the rest of the product.** GatewayGuard turns the
   Advertising ID off and sets Diagnostic data to Required only. Recommending
   an extra upload channel in the same breath is incoherent.

**Suggested page wording:**

> There is a fourth checkbox here: **Automatically collect website or app
> content when additional analysis is needed to help identify security
> threats.** It does not protect you -- it sends samples of what was on screen
> to Microsoft to help them study new attacks. Windows leaves it off on home
> PCs, and Checkup leaves it exactly as it found it. Turn it on if you would
> like to help, or leave it. Nothing about your safety changes either way.

---

## AND NOW THE BIGGER PROBLEM, WHICH ITEM 15 UNCOVERED

**The whole Phishing protection feature may do nothing for GatewayGuard's
readers, and Checkup turns it on for all of them.**

*measured:* Checkup setting **ID 6**, named *"Edge Phishing Protection (all
3)"*, writes `NotifyMalicious`, `NotifyPasswordReuse` and `NotifyUnsafeApp` to
`HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components` (build lines
6392-6397). **WTDS is Windows Enhanced Phishing Protection -- an operating
system feature. It is not Edge's own password monitor.** The name given to it
in FT-155 is wrong, and being wrong made this harder to see.

**Three facts from Microsoft's page, and each one is a problem:**

1. **It protects work or school passwords only.** Every sentence in the
   documentation is scoped that way -- *"helps protect typed work or school
   password used to sign into Windows 11."* **A home user on a local account or
   a personal Microsoft account has no work or school password.**
2. **The edition table lists Windows Pro, Enterprise, Pro Education and
   Education. Home is not in it.** *measured:* Checkup has `SkipOnHome=$false`
   on this setting, so it applies it on Home anyway.
3. **A Hello PIN switches it off in practice.** *sourced:* *"When a user signs
   in to a device using a Windows Hello for Business PIN or biometric, Enhanced
   Phishing Protection doesn't alert the user."* **Checkup's setting 9
   encourages a PIN.** The product may be recommending two settings that cancel
   each other.

**And on CGDELL the registry key cannot even be read.** *measured 2026-08-24,
elevated:* `Get-ItemProperty` on `WTDS\Components` returns **"Requested
registry access is not allowed."** The build already anticipates this -- line
6402 prints *"Phishing Protection registry is protected on this PC"* and falls
back to manual steps -- so at least it is not silently claiming success.

### I AM NOT CONCLUDING THE SETTING IS USELESS, AND HERE IS WHY

**The alternatives have to be ruled out first, and one of them is live.** Bill's
screenshot proves the Phishing protection UI **exists and is switched On with
all four boxes ticked** on whichever machine he photographed. If that machine
was SANDY, then Home does expose the feature and the edition table is about
managed configuration rather than availability. **That single fact would
change the answer**, and I do not know which machine the screenshot came from.

**The measurement that settles it, on SANDY (Home):**

1. Open Windows Security > App & browser control. **Is there a Phishing
   protection section at all?**
2. If yes, are the four checkboxes present and settable?
3. Run `Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components"`
   -- does it read, and what are the values?

**Until that is done, setting 6 stays exactly as it is.** It is not doing harm,
and pulling a security setting out of the product on a documentation table
would be the same mistake in the other direction.

### ALSO MEASURED, AND IT EXPLAINS BILL'S SCREENSHOT

The screenshot shows *"This setting is managed by Smart App Control"* above
**Potentially unwanted app blocking**, with **Block apps** greyed out and
**Block downloads** still tickable.

*measured on CGDELL:* `VerifiedAndReputablePolicyState = 1` (Smart App Control
**On/Enforced**) and `PUAProtection = 1` (Block).

**So that greyed-out box is not a fault and not something Checkup did.** When
Smart App Control is on, Windows takes app blocking over. Worth one sentence on
the page, because a reader who finds a control they cannot click will otherwise
assume something is broken.

---

# ITEM 20 -- WAKE ON LAN

## BILL'S SECURITY HOLE IS REAL, AND IT IS FIXABLE

His concern: SANDY had *"a realteck adaptor which was disabled... You couldn't
check the realteck adaptor as it was disabled. This may leave a security hole
if it is a working adaptor and they enable it in the future."*

**He is right that the setting survives. He is wrong that it cannot be reached
-- and that is good news.**

*measured 2026-08-24 on CGDELL, by disabling the Ethernet adapter, reading it,
and restoring it -- three separate cycles, adapter returned to its exact prior
state each time:*

| Test | Result |
|---|---|
| `Get-NetAdapter -Physical` lists a **disabled** adapter | **Yes** |
| `Get-NetAdapterPowerManagement` **reads** a disabled adapter | **Yes** -- `MagicPacket:Enabled Pattern:Enabled` |
| `Get-NetAdapterAdvancedProperty` **reads** a disabled adapter | **Yes** -- all three display names returned |
| `Set-NetAdapterPowerManagement` **writes** to a disabled adapter | **Yes** -- flipped to Disabled and back, confirmed by read-back |

**So Wake on LAN on a disabled adapter can be both seen and turned off.** What
cannot see it is the **graphical interface** -- Device Manager hides the Power
Management tab on a disabled device, which is exactly what Bill hit.

**A HYPOTHESIS I HAD AND THEN DISPROVED, recorded because it nearly got
published:** I expected `Get-NetAdapterAdvancedProperty` -- the build's primary
method -- to fail on a disabled adapter, and that this was the defect. **It
does not fail.** It returned every property normally. Had I written that up
without testing it, it would have been a wrong cause with a plausible story
attached.

**So why did SANDY's Realtek adapter go unchecked?** Not because it was
disabled. The likeliest remaining cause is **the property name**: the build
looks for specific display names, and Realtek drivers do not always use
Intel's wording. That is a SANDY measurement, listed at the end.

## THE WAN MINIPORTS -- ANSWERED, AND THE ANSWER IS "IGNORE THEM"

Bill: *"on cgdell and sandy there is also a number of wan miniports, none of
which have a power management section."*

*measured on CGDELL, all 19 adapters including hidden:* **eight WAN miniports
(SSTP, IKEv2, L2TP, PPTP, PPPOE, IP, IPv6, Network Monitor), and not one of
them has a power management section.** Nor do the Hyper-V virtual switch,
6to4, Teredo, IP-HTTPS, or the kernel debugger adapter.

**They are software constructs, not network cards. There is no hardware to
wake, so there is nothing to check and nothing to turn off.** Checkup already
gets this right -- it uses `Get-NetAdapter -Physical`, which excludes every one
of them.

**Say this on the page in one line**, so a reader who opens Device Manager and
finds fifteen network things stops hunting through them.

## WHAT IS ACTUALLY LIVE ON CGDELL RIGHT NOW

*measured:*

| Adapter | Magic Packet | Pattern Match |
|---|---|---|
| **Ethernet** -- Intel I219-LM | **Enabled** | **Enabled** |
| **Wi-Fi** -- Intel Wi-Fi 6E AX211 | Disabled | **Enabled** |
| Bluetooth PAN | Unsupported | Unsupported |
| vEthernet (Default Switch) | Unsupported | Unsupported |

**Bill's own machine has Wake on LAN live on two adapters.** Checkup's setting
19 exists to turn that off, and setting 19 is `Selected=$false` by default --
so on a default run it never fires. That is a deliberate choice, not a bug, but
it means CGDELL is a working example of the hole the page describes.

**Note "Pattern Match" is enabled on both.** That is the second wake trigger,
and it is the one people forget. *measured:* the build already checks both
(lines 5004 and 6144), so this was fixed at some point -- the comment at line
958 records that only Magic Packet used to be read.

## RECOMMENDATION FOR ITEM 20

**For the page:**

1. **Say that a disabled adapter keeps its Wake on LAN setting**, and that the
   setting becomes live the moment somebody enables the adapter. That is Bill's
   finding and it deserves to be stated plainly.
2. **Say that Windows will not show it to you on a disabled adapter** -- the
   Power Management tab is not there -- so there is no way to check it by hand.
   **This is the strongest "what Checkup does for you" example in the whole
   guide**: not a convenience, but a thing the reader genuinely cannot do
   through the interface.
3. **Tell readers to ignore the WAN miniports**, by name, with the reason.
4. **Mention both triggers** -- magic packet and pattern match.

**For the build**, one thing worth confirming rather than changing: setting 19
is `Selected=$false`, so Wake on LAN is not turned off unless the user picks
it. Given Bill's own machine has it enabled on two adapters, **is that still
the right default?** A product decision, not a defect.

---

# WHAT NEEDS SANDY

Both items converge on the same trip already planned for the ascii43 field run
and F4's `D:` scan. All read-only:

1. **Windows Security > App & browser control** -- is there a Phishing
   protection section on Home at all? Four checkboxes present? *(item 15, and
   it decides whether setting 6 is doing anything for Home users)*
2. `Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components"`
   -- does it read on Home, and what are the values? *(it refuses even elevated
   on CGDELL)*
3. **The Realtek adapter, disabled:** run
   `Get-NetAdapterAdvancedProperty -Name <realtek> | Where-Object DisplayName -like "*Wake*"`
   and `Get-NetAdapterPowerManagement -Name <realtek>`. **What display names
   does the Realtek driver actually use?** That is the likely reason Checkup
   missed it, now that "because it was disabled" has been ruled out here.
4. **Settings > Privacy & security -- is "Device encryption" present?** *(Q7,
   carried over)*

A single script can collect all four. Say the word and I will write it with a
`.bat` launcher, read-only, results to a file.
