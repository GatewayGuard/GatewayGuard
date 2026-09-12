<!-- Dated: 2026-09-05 00:18 ET -->
<!-- Editor: Claude Cloud -->
# Cloud research -- the ascii43 test-results research, with recommendations

- **Document Name:** GatewayGuard_CloudResearch-ascii43
- **Last Modified:** 2026-09-05 00:18 ET
- **Last Editor:** Claude Cloud
- **Answers:** `GatewayGuard_CloudRequest-ascii43Research-2026-09-04-2000.md`
- **Status:** RESEARCH -- not a governing document, amends no rule, builds nothing

---

## PROVENANCE -- read this before any finding below (Cloud Working Rules, steps 1-5)

1. **Freshness stamp of the copy this was written from** (measured from
   `ProjectDocs/CURRENT.md` in project knowledge): Generated **2026-09-04
   20:02 ET**, commit **`2729263`**, made **2026-09-04 19:56 ET**, subject
   *"Bundle receipt fixed and the right two files delivered; the store is
   finished."* Session-log heading match confirmed word for word.
2. **Base files** (each named in `CURRENT.md`): the Cloud request above; the
   field-notes response `GatewayGuard_ResponseToBillsNotes-ascii43-2026-08-30-1815.md`;
   the run-2 triage `GatewayGuard_FieldTestTriage-ascii43run2-2026-08-30-1723.md`;
   the build `Tool/W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1`;
   `GatewayGuard_FieldResult-PhishingProtection-2026-08-26-1130.md`;
   `GatewayGuard_Research-Items15and20-2026-08-24-0917.md`;
   `GatewayGuard_AVScanCoverageTest-2026-08-21.md`;
   `GatewayGuard_Q2AndCopyDrafts-2026-08-24-0222.md`.
3. **How read:** all of the above via `project_knowledge_search`, in
   relevance-ranked fragments, not whole files. Where a chunk boundary cut
   something I needed, I say so at the item.
4. **Carried-forward factual claims:** none carried from a draft. Every
   machine-state claim below is either labelled ***measured*** and attributed
   to the Claude Code document that measured it, or labelled *sourced* with
   the vendor/standard named in the sentence. Nothing is asserted from my
   memory of earlier sessions.
5. **What I could NOT see, and what it changes:**
   - **`Test_Results\Ascii43-Test-Results-2026-08-26-1701-2-TEXT.md`** -- in
     `Test_Results\`, outside the connector scope, so I could not open it from
     the repository. **Bill pasted the readable twin into the conversation
     after the first draft of this file; I read it from the paste.** Every
     item in the request matches the notes verbatim. **The Gemini write-up
     item C points at is NOT in the twin** -- Scr 25 says *"See below gemini
     write up"* and the next line is Scr 26. Either the extraction dropped it
     or it was an attachment. Item C is therefore answered from the project's
     own measurements. If Bill wants my agree/disagree on Gemini, it needs to
     reach me as text.
   - **Added from the paste:** Scr 25d item 2, *"Add save to USB Drive"* for
     the recovery key -- consistent with ask A and noted there.
   - **The full 20-item list**: the request quotes it verbatim and I have
     items 1-20 complete across two chunks. No gap.
   - **Web sources** are dated in the sentence where they are used. Anything
     I could not source is labelled *inferred* or *guess* and is not a
     recommendation.

**Basis labels used throughout:** ***measured*** (a Claude Code document ran it
and shows output) / *sourced* (vendor or standard, named) / *inferred*
(reasoning, could be wrong) / *guess*. Only measured and sourced may enter
the tool or user-facing copy.

---
---

# PART 1 -- BILL'S TWENTY ITEMS

## Items 1-2 -- Tamper Protection first, and detect it directly

**Finding.** *Sourced, Microsoft Learn, "Protect security settings with
tamper protection" (page dated 2026-07-30):* `Get-MpComputerStatus` exposes an
**`IsTamperProtected`** property; `True` means Tamper Protection is on. **That
is a direct read.** The indirect route Bill proposed in item 2 -- infer TP
from a blocked read of `WTDS\Components` -- is not needed as the primary
signal, though it remains a useful second witness.

***Measured, Claude Code 2026-08-26 and 2026-08-30:*** the `WTDS\Components`
read is refused on both machines when TP is on, and the build already catches
that and reports "Unknown" for setting 6. Setting 3 (Tamper Protection) is
already declared `CanAuto=$false` because Windows forbids programmatic
change -- *sourced, same Microsoft page:* TP cannot be set by PowerShell,
policy or registry; only the Windows Security UI (or Intune/MDE) changes it.

**Recommendation.** Make Tamper Protection the first substantive screen of the
run, read `IsTamperProtected` directly, and if it is `False` show the manual
steps and **re-read before continuing**. Keep the `WTDS` blocked-read as a
consistency check (TP=True but WTDS readable, or the reverse, is itself a
finding worth logging).

**What would change my mind.** If `IsTamperProtected` is measured to be
unreliable on Home -- e.g. returns `$null` or stale on SANDY. *Not yet
measured on either project machine.* That is the first test in Part 3.

**Where it lands.** Tool (run order + a new read). Not guide, not licence.

## Items 3-5 -- Windows Update: check, apply, loop until current

**Finding.** Three routes exist, all usable on Home:

| Route | What it does | Source | Fit for Checkup |
|---|---|---|---|
| `UsoClient StartInteractiveScan` | Same scan as clicking *Check for updates*; does **not** install | *sourced, iTechGuides 2026-08-09, noting Microsoft documents that switch but not all* | Check only |
| **Windows Update Agent COM API** (`Microsoft.Update.Session`) | Search, download, **install**, reports `RebootRequired`; built into Windows, no module install | *sourced, Microsoft Learn wuapi.h: `IUpdateInstaller::Install` is a synchronous install; `RunWizard` guides the local user* | Check + apply, no third-party code |
| `PSWindowsUpdate` module | Convenience wrapper over the same API | *sourced, PowerShell Gallery; community-maintained* | **No** -- adds an internet install of third-party code to a product whose promise is "read every line" |

*Sourced, Microsoft Learn Q&A 2025-03-07:* the WUA API is the documented way
to search, download and install programmatically. *Sourced, Action1
2026-08-03:* the API is designed for **local interactive** use and refuses
remote sessions -- which is exactly Checkup's situation, so no obstacle.

**"Until Windows reports current" (item 4) is a loop with reboots in it.**
Cumulative updates routinely require a restart before the next scan sees the
machine as current. Checkup already has a resume-after-reboot path (the
offline-scan resume, `Show-PreScanGate`); the same shape applies here.

**Recommendation.** Ship **check-and-instruct** for launch (route 1 or the
API's search half), with a clear "restart, then run Checkup again" message
when updates are pending. **Do not ship apply-and-loop in ascii44.** It is
achievable via the COM API, but it is the highest blast-radius feature on this
list -- it can leave a senior's machine mid-servicing -- and it has never been
run once on a project machine. Claude Code's instinct in section 23 (*"check
and instruct, not apply"*) is right for September 15. Build the apply path as
a post-launch feature with its own field run.

**What would change my mind.** A measured run of the COM API install path on
SANDY that completes cleanly including the reboot-and-resume, plus a decision
from Bill that the risk is acceptable. *Inferred:* it would take one full
SANDY session to establish.

**Where it lands.** Tool (new pre-scan step). Guide gains one paragraph
("Checkup will tell you if Windows needs updating; here is how to finish it").

## Item 6 -- scans only after the above

**Finding.** No research needed; this follows from 1-5. ***Measured, FT-239
(triage run 2):*** Windows turned real-time protection back on by itself
mid-test -- the machine's state moves underneath the tool when these settings
are unsettled. Establish them first and every later reading is trustworthy.

**Recommendation.** Yes. Order: Tamper Protection -> Windows Update status ->
PUA blocking (item 7) -> scans. The question was not genuinely open.

**Where it lands.** Tool (run order).

## Item 7 -- both blocking sub-options before any scan

**Finding.** The two boxes are **Block apps** and **Block downloads** under
*Potentially unwanted app blocking*. *Sourced, Microsoft Support, "Protect your
PC from potentially unwanted applications":* Microsoft recommends leaving the
feature on **and enabling both**; *Block downloads* works **only in Microsoft
Edge**. *Sourced, Microsoft Learn/defender-docs:* `Set-MpPreference
-PUAProtection Enabled` turns on Defender's PUA blocking (= the *Block apps*
half). *Sourced, ElevenForum/GeekRewind (secondary), consistent with the Edge
doc:* the Defender setting and registry route **do not** change the Edge
*Block downloads* toggle -- that one is an Edge SmartScreen setting.

***Measured, Claude Code 2026-08-24 (Research-Items15and20):*** on CGDELL
`PUAProtection = 1` and Smart App Control is enforced, which **greys out Block
apps** -- not a fault, Windows has taken it over. That will confuse a reader
who finds a box they cannot click.

**Recommendation.** Before any scan: read `(Get-MpPreference).PUAProtection`;
if not 1, apply `Set-MpPreference -PUAProtection Enabled` **with approval**
and re-read. For *Block downloads*, show manual steps (it is an Edge setting)
and say the one-sentence Smart App Control note. This is the setting that
makes Defender's PUP detection real -- see item 9.

**What would change my mind.** Nothing found. Microsoft's own recommendation
is to enable both.

**Where it lands.** Tool (a new setting or a pre-scan step -- Claude Code's
call) + one guide sentence on Smart App Control.

## Item 8 -- anything else before scans, including "console option 1 vs 2"

**Finding.** ***Measured, build source, mode-select screen:*** *option 1* is
**CONSOLE MODE** and *option 2* is **GUI MODE** ("Recommended for first time
users"). *Inferred from the two ascii43 field runs and every triage since
ascii39:* **every field run and every screen number, gate and finding in this
project is console mode.** GUI mode has no field evidence, no screen numbers
and no coverage in the checklists. A first-time senior sent to option 2 is
sent to the least-tested path, labelled "recommended".

Other pre-scan settings worth confirming, all already in the 19: real-time
protection on (setting 2), cloud-delivered protection (not currently a
Checkup setting -- *sourced, Microsoft:* `MAPSReporting`), signatures updated
(`AntivirusSignatureAge` from `Get-MpComputerStatus`, *sourced, Microsoft
Learn cmdlet page*). **Signature age is the one worth adding**: a scan with
stale definitions is the FT-162 shape -- a GOOD printed over a check that
could not succeed.

**Recommendation.** (a) Bill decides on mode select: either **drop the
"recommended for first time users" label from option 2** or remove option 2
from the launch build. I recommend the first as the smaller change; the
second if GUI mode is not going to be field-run before 15-Sep. (b) Add a
signature-age read before the scan gate; instruct if older than a day.

**What would change my mind on (a).** A GUI-mode field run with a checklist,
before launch. **Nineteen settings are frozen**, so this is not a new
setting; it is a label.

**Where it lands.** Tool (mode screen wording; one read). Bill's decision.

## Items 9-11 -- is Malwarebytes still needed?

**First, the trap the request names, stated as instructed:** ***measured,
SANDY 2026-08-28:*** Malwarebytes found 12 of 12 specimens and so did
Defender's full scan. **That result is EICAR-class test files and proves
nothing about PUP detection in the wild.** No recommendation below rests on
it.

**Finding -- independent lab evidence.** *Sourced, AV-Comparatives Real-World
Protection Test Feb-May 2026 (published 2026-06-18), 400 live cases on Windows
11:* Microsoft Defender is one of seven products at the top award level
(**ADVANCED+**); **Malwarebytes Premium was downgraded for above-average
false positives.** *Sourced, AV-Comparatives Malware Protection Test March
2026, 10,000 samples:* Microsoft is among the top-rated. *Sourced, Bits From
Bytes summary of the same data, 2026-05-21:* the spread between the leaders
and Defender is on the order of 0.08 percentage points.

**Two facts that keep the question open, and they cut opposite ways:**

1. **The labs test Malwarebytes *Premium* (real-time).** Checkup uses the
   **free on-demand scanner** -- Custom scan with rootkit check and the Deep
   scan. *Inferred:* the same engine and definitions, but the free product
   has no real-time layer, so lab "real-world" scores overstate what the free
   scan delivers. The comparison Checkup actually needs is *Defender full scan
   + PUA on* versus *Malwarebytes free on-demand scan*, on PUPs. **Nobody
   has published that.** Item 12 is how we measure it ourselves.
2. **Defender only detects PUPs when PUA protection is on.** *Sourced,
   Microsoft Learn:* PUA blocking is a distinct feature that must be enabled;
   *sourced, the project's own AVScanCoverageTest:* "Defender catches [the
   AMTSO PUA specimen] only if PUA protection is on; Malwarebytes catches PUPs
   by default." **So the answer to item 9 depends on item 7 being done
   first.** With PUA off, Malwarebytes is doing real work. With PUA on, the
   published evidence says Defender is at parity or better on malware, and
   on PUPs it is untested.

**The Malwarebytes cost is not hypothetical.** ***Measured across the project
record:*** the SANDY Malwarebytes firewall caused DHCP failures; the
"MB Trial is primary" status branch exists because a trial can seize primary
AV; FT-154 and the monthly reminder task exist only because of Malwarebytes;
and *sourced, AV-Comparatives 2026:* Malwarebytes is the false-positive
outlier -- a senior asked to trust a scary detection on a benign file is a
support call.

**Recommendation.** **Plan for a Defender-only Checkup, but do not remove
Malwarebytes until the item-12 PUP test is run and read.** Position: if the
18 recovered PUPs (or the AMTSO PUA specimen) are caught by Defender's full
scan with PUA on at a rate that matches Malwarebytes' free scan, drop
Malwarebytes from the product -- the four screens, the reminder task, the
guide section, and the pricing/licence references go with it. If Defender
misses what Malwarebytes catches, keep Malwarebytes **as an optional second
opinion the guide describes**, not something the tool orchestrates.

**What would change my mind.** The item-12 test showing Defender+PUA misses a
material fraction of real PUPs that Malwarebytes free catches. That is the
whole question, and it is one afternoon on SANDY.

**Where it lands.** Tool (four screens + reminder task), guide, website,
pricing copy, and **licence Section 1 / Section 3** wherever Malwarebytes is
named as a component -- ***check the v3.0 text; I did not grep it for the
word.***

## Item 12 -- recover the 18 PUPs from SANDY for testing

**Finding.** *Sourced, Malwarebytes help centre (Windows v5):* quarantined
items sit in **Detection History > Quarantined items** and can be **restored**
from there; auto-quarantine is on by default. *Sourced, same help centre:*
whether and when quarantine auto-deletes is a setting in the app -- the
**Windows default retention is not stated on the page I could reach** (the
Mac page says 90 days). *Inferred:* the 2026-08-28 SANDY run is eight days
old at the request's date, so they are almost certainly still there.

**Recommendation.** Do this first, this week: on SANDY, open Malwarebytes >
Detection History > Quarantined items, and **before restoring anything**
photograph or export the list (names, paths, detection names). Then either
(a) restore to an isolated folder (`C:\AVTestKit\07_pua\` from the existing
kit) with Malwarebytes real-time OFF, or (b) if restore returns them to
original locations only, restore-then-move. Then run Defender full scan with
`PUAProtection = 1` and record what it catches. **Add a `07 PUA` row per
specimen to the AVScanCoverageTest grid** -- the row is already designed.

**Handling caution, *inferred*:** PUPs are not malware but some carry
droppers. Keep SANDY offline for the restore, and do it **before** SANDY is
encrypted (T-ENC is a one-way door; this test needs the unencrypted baseline
no more than any other, but it needs the quarantine, which any reimaging
would destroy).

**Where it lands.** Test plan. Nothing ships from this directly.

## Items 13-14 -- password managers vs browser password managers

**Finding.** Expert consensus is **not** "dedicated manager, always."

- *Sourced, UK NCSC, "What does the NCSC think of password managers?":*
  browser-based managers **"can be a very good choice"** -- convenient,
  integrated, no separate master password -- provided the browser is kept
  updated and the device has a PIN/password/biometric lock. Drawbacks named:
  passwords may not follow you across different operating systems, and a
  shared device profile shares the vault.
- *Sourced, NCSC guidance via IT Pro 2025-06-26:* first-party browser
  managers are endorsed alongside dedicated ones; passkeys are called the
  future.
- *Sourced, CISA (via Bellator summary 2026-05-29):* use **a** password
  manager and make every password unique -- CISA does not specify
  dedicated-over-browser in the consumer guidance summarised.
- *Sourced, NIST SP 800-63B-4 (July 2025):* verifiers **shall** permit paste
  "to facilitate the use of password managers" -- NIST treats managers as
  expected, without distinguishing browser from standalone.
- The "disable browser saving" position comes overwhelmingly from **vendors
  of dedicated managers** (*sourced:* LastPass blog 2025-10-20; Bitwarden's
  critique of NCSC's browser advice).

**And this collides with Checkup.** Setting 15 is **"Edge Password Saving --
Disable."** ***Measured, build:*** it is one of the 19 frozen settings, tied
to the password-manager answer by FT-221. The product currently tells a
senior to turn off the very thing NCSC says is a very good choice for exactly
that reader, with no standalone manager installed in its place.

**Recommendation.** For a senior on one Windows PC: **a browser password
manager, kept updated, behind a Windows PIN (setting 9), is the
expert-supported recommendation.** A dedicated manager is the better answer
only for someone with multiple platforms or a shared PC. **So item 14's "turn
off browser password saving before running Checkup" should NOT be the
advice** -- and setting 15 should become **conditional**: *"Do you use a
separate password manager (1Password, Bitwarden, etc.)? Y -> turn Edge saving
off. N -> leave it on, and here is how to protect it (PIN, updates)."*
That is the FT-221 tie, pointed the right way.

**What would change my mind.** A primary NCSC/CISA/NIST document that
recommends **against** browser managers for consumers. I searched and found
none; the counter-evidence is vendor-authored.

**Where it lands.** **Guide** (a section, and the reasoning above in plain
words) and **tool** (setting 15 becomes a conditional). This is a change to a
frozen setting's *behaviour*, not a new setting -- Bill's call whether that
crosses the freeze line.

## Items 15-16 -- how often to change passwords; 2FA for money accounts

**Finding.** *Sourced, NIST SP 800-63B-4, final July 2025 (superseded
800-63B 2025-08-01), §3.1.1.2:* verifiers **shall not** require periodic
password change; change only on evidence of compromise; length is the
primary strength driver (15 characters recommended for single-factor);
composition rules prohibited; new passwords screened against breach
blocklists. *Sourced, NCSC (same page family):* "avoid frequent password
changes." **Bill's instinct is the current standard**, not merely supported
by it.

**On the argument for keeping a very strong password unchanged with 2FA:**
the reason forced rotation fails is that people make predictable small
changes; the reason to change is *evidence of compromise*, which 2FA does not
remove but does contain. So the rule for the guide is: **long, unique,
unchanged -- until a breach notice, a suspicious login, or a lost device;
then change it at once.**

**On 2FA for banking, investment and credit-card accounts:** *sourced, CISA
"Implementing Phishing-Resistant MFA" fact sheet (2022-10-31, still CISA's
canonical guidance):* any MFA beats none; the hierarchy from weakest to
strongest is SMS/voice -> app-based push/codes -> phishing-resistant
(FIDO/passkeys, PKI). *Sourced, NIST SP 800-63B-4 §3.2.9:* the **one**
restricted authenticator is out-of-band over the telephone network -- i.e.
SMS and voice codes.

**Recommendation.** Guide language: turn on 2FA for every account that holds
money, **using an authenticator app or a passkey where the bank offers one,
SMS only if that is all the bank offers** -- and SMS is still far better than
nothing. Do not tell readers to change strong passwords on a schedule.

**What would change my mind.** Nothing found. The standards converged in 2025.

**Where it lands.** Guide only.

## Item 17 -- authenticator apps versus text-message codes

**Finding.** *Sourced, CISA fact sheet above:* SMS and voice are vulnerable to
SIM swapping and SS7 interception; app codes are vulnerable to real-time
phishing relay but not to SIM swap. *Sourced, NIST SP 800-63B-4:* PSTN
out-of-band is the restricted category. **For a senior, the practical
differences to explain:** an SMS code can be stolen by someone who talks the
phone company into moving your number; an app code cannot. Both can be
phished by a fake page that asks for the code -- so never type a code into a
page you did not open yourself. A passkey cannot be phished that way at all.

**Recommendation.** Guide: explain the three levels in that order, recommend
the app, and say plainly why SMS is weaker without frightening readers off
SMS where it is the only option.

**Where it lands.** Guide only.

## Item 18 -- can an authenticator code's display time be extended?

**Flat answer: no, not by the user, and not by the app.** *Sourced, RFC 6238
§4.1 and §5.2:* the time step is a **system parameter** the *account issuer*
sets when it creates the secret; 30 seconds is the recommended default, and
the prover and verifier **must** use the same step. The app cannot lengthen
what the bank chose. What some apps do (*inferred, not verified per app*) is
show a countdown, or show the **next** code early -- which is the effective
"extension," and it is also the mechanism behind item 19.

**Where it lands.** Guide (two sentences: "the 30 seconds is set by the bank,
not the app; if you run out, wait for the next code and start again").

## Item 19 -- why a previous code still works briefly

**Flat answer: because the server is designed to accept it.** *Sourced, RFC
6238 §6 "Resynchronization":* the standard **recommends** the validator accept
codes a bounded number of time steps behind (and ahead) of its own clock, to
absorb clock drift between phone and server; with a 30-second step and two
steps of tolerance, a code can be accepted up to about 89 seconds after it
was generated. *Sourced, RFC 6238 §5.2:* a code accepted once **must not** be
accepted again. *Sourced, OLOID 2026-05-07 and Otp.NET docs:* the common
implementation accepts the previous, current and next step -- a ~90-second
window. **So the "old" code Bill saw was inside the server's tolerance
window. It is not a bug and it is not a weakness worth worrying about**: the
code is still single-use, and the window exists so that a slow typist is not
locked out.

**Where it lands.** Guide (one reassuring paragraph). Bill noticed a real,
documented mechanism.

## Item 20 -- the plan

See Part 3.

---
---

# PART 2 -- THE FOUR OTHER ASKS

## A. Does encryption reach a plugged-in USB drive?

**Finding.** *Sourced, Microsoft Learn, BitLocker overview (updated within the
last two weeks of 2026-09-04):* **"Device encryption encrypts only the OS drive
and fixed drives, it doesn't encrypt external/USB drives."** *Sourced,
Microsoft Learn security book:* removable drives are **BitLocker To Go**, a
separate feature. *Sourced, Microsoft Support "Device Encryption in Windows":*
Device Encryption (Home) covers the OS drive and fixed drives; BitLocker Drive
Encryption is Pro/Enterprise/Education.

**Claude Code's hypothesis is confirmed by Microsoft's own page**: on Home, a
plugged-in USB drive is not encrypted by Device Encryption, and Home does not
offer BitLocker To Go to encrypt it manually.

**One caveat, *sourced, Tom's Hardware 2024-05-07 reporting Deskmodder*:**
during a **clean install/reinstall** of 24H2, "all other drives connected to
the machine will be encrypted as well." That is about drives present at
install time, fixed or otherwise, and is not the scenario Checkup runs in.
*Inferred:* a USB stick left plugged in during a Windows reinstall could be
caught; a USB stick plugged in when Checkup turns encryption on will not be.

**Recommendation.** Screen 25d can say: "Encryption covers the drives inside
this PC. A USB drive or memory stick plugged in is **not** encrypted, and
Windows 11 Home cannot encrypt it. Keep the recovery key somewhere that is
not on this PC." **Do not ship this until it is measured once on SANDY** --
plug a USB drive in, turn Device Encryption on, and read
`manage-bde -status` for the removable volume. Gate 24 applies.

**Bill's Scr 25d item 2 -- "Add save to USB Drive" -- follows from the same
fact:** because Home leaves a USB stick unencrypted, it is a usable place to
store the recovery key, which is what the 25d screen should offer alongside
print and Microsoft account. *Sourced, Microsoft Support:* on a local account
the key is not backed up to any account, so an offline copy is the only copy.

**Where it lands.** Tool screen 25d + guide.

## B. Must the user turn on encryption themselves on every Windows 11 Home PC?

**Finding. No -- and the six-screen sentence needs a condition.** *Sourced,
Microsoft Support "Device Encryption in Windows":* **"When you first sign in
or set up a device with a Microsoft account... Device Encryption is turned on
and a recovery key is attached to that account. If you're using a local
account, Device Encryption isn't turned on automatically."** *Sourced,
Microsoft Learn BitLocker overview:* from 24H2 the Modern Standby/HSTI and
DMA prerequisites are removed, so more devices qualify. *Sourced, Tom's
Hardware 2024-05:* Home OEM machines need the manufacturer's UEFI flag for the
automatic path.

**So SANDY's behaviour generalises to "local account" Home machines, not to
all Home machines.** A senior who set up their PC by signing in with a
Microsoft account is very likely already encrypted -- ***measured in this
project:*** Sandy3 (Home, Microsoft account) auto-enabled Device Encryption,
per the project record; SANDY (Home, local account `panther`) did not.

**Recommendation.** The six screens should say: **"On a PC set up with a local
account, you turn this on yourself -- Checkup will show you how. If you signed
in with a Microsoft account when you first set the PC up, it is probably
already on; Checkup will tell you."** Checkup already detects local vs
Microsoft account (FT-144) and encryption state (setting 8), so the sentence
can be driven by data rather than asserted.

**What would change my mind.** Nothing; this is Microsoft's stated design.
The residual unknown is *how many* senior-owned Home PCs are local-account.
*Guess:* a minority, since OOBE pushes hard for a Microsoft account.

**Where it lands.** Tool (six screens, conditional wording) + guide.

## C. What is Tamper Protection actually blocking?

**I could not read the Gemini write-up (see provenance).** Answered from the
project's own measurements.

**Finding.** ***Measured, Claude Code 2026-08-26 (FieldResult-Phishing
Protection §4) and 2026-08-30 (Response §25):*** setting 6 tries to read
`HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components`; Windows
returns `System.Security.SecurityException` on both machines, elevated. The
write was **not** tested (it would change the machine), so "TP blocks the
write" is *inferred, near-certain, not measured*. *Sourced, Microsoft Learn
tamper protection page:* TP protects Defender AV settings from being changed
by anything other than the Security app/MDE.

**So yes: truly blocked for reading, and Bill's wording "Must be set manually
-- Checkup will show you how" is accurate for setting 6.** Setting 9 (Windows
Hello) is already check-only/manual, so the same wording is honest there too.

**One thing I disagree with in the current build, not with Bill:** setting 6
still declares `CanAuto=$true` (***measured, line 5623***). Claude Code
already recommends `CanAuto=$false` for ascii44. I concur, and add: with
`IsTamperProtected` now available (items 1-2), the tool can say **why** it is
manual ("Tamper Protection is on, which is correct, and it blocks this") --
which turns an "Unknown" into an explanation.

**Where it lands.** Tool (settings 6 and 9 wording; `CanAuto`). The Gemini
comparison remains owed if Bill wants it.

## D. Anything else before a scan runs, including console option 1 vs 2

Covered under item 8. Summary: signature age; PUA on (item 7); mode-select
label. Nothing else surfaced that is not already among the 19.

---
---

# PART 3 -- THE PLAN (item 20)

**Principle:** measure the three things that decide the design **before**
anything is built. Two of them need SANDY unencrypted; do them on the same
trip, before T-ENC.

## Step 0 -- this week, SANDY, no build (Bill, ~2 h)

| # | Do | Why it is first | Depends on |
|---|---|---|---|
| 0.1 | Photograph/export Malwarebytes quarantine list; restore the 18 PUPs into `C:\AVTestKit\07_pua\` per item 12 | Time-sensitive; nothing else on this list can be decided without it | SANDY unencrypted, offline |
| 0.2 | Run `Get-MpComputerStatus \| Select IsTamperProtected` with TP on, then off, then on, on SANDY and CGDELL; record output | Items 1-2 rest on this read being reliable on Home | -- |
| 0.3 | Run `(Get-MpPreference).PUAProtection` on SANDY; set to 1 if needed | Item 7, and a precondition for 0.4 | -- |
| 0.4 | Defender full scan against `07_pua`; then Malwarebytes free Custom scan against the same folder; fill the `07 PUA` grid rows | **Decides item 9** | 0.1, 0.3 |
| 0.5 | Plug in a USB stick, turn Device Encryption on (this IS T-ENC -- do it last, after every other unencrypted-state measurement is done); `manage-bde -status` | Ask A | T-SL enumeration complete |

**Step 0.5 is the one-way door.** Nothing after it can be re-measured on an
unencrypted SANDY.

## Step 1 -- Bill decides (three decisions, one line each)

1. **Malwarebytes in or out**, on the 0.4 result.
2. **Mode select**: drop the "recommended" label on GUI mode, or drop GUI mode.
3. **Setting 15 becomes conditional** (browser manager stays on unless a
   standalone manager is in use) -- is that inside the freeze?

## Step 2 -- Claude Code builds (ascii44, in this order, by cost of being wrong)

1. FT-242 `-EA Stop` on the eight unguarded writes (already first in the
   triage; unchanged).
2. **Run-order change**: Tamper Protection (direct read, item 1-2) -> Windows
   Update **check-and-instruct** (items 3-5, no apply) -> PUA on with approval
   (item 7) -> signature age -> scans.
3. Setting 6 `CanAuto=$false` + "blocked because TP is on" wording; setting 9
   same wording (ask C).
4. Six encryption screens: conditional local-vs-Microsoft-account sentence
   (ask B); screen 25d USB sentence **only if 0.5 measured it** (ask A).
5. Mode-select label per decision 2.
6. Malwarebytes removal or retention per decision 1 -- **the largest change
   set; do not start it until decision 1 exists.**
7. Setting 15 conditional per decision 3.

## Step 3 -- Cloud writes guide content (can run in parallel with Step 2)

Items 13-19 as one new guide section ("Passwords and two-step sign-in") plus
the Windows Update paragraph and the encryption-scope paragraph. Landing spots
in the 1,976-line draft: **the Guide already has a settings-9/15 area (FT-221
sections, `GatewayGuard_GuideFT220-Sections-2026-08-21-1445.md`) and a
Device Encryption section**; the password/2FA material is new and belongs
immediately after the password-manager section FT-221 called for. I will
give line anchors against the live draft when Bill says go.

## Step 4 -- field-run ascii44 on SANDY (T-44T), then triage, then T-ENC

Unchanged from the CPM. **T-ENC must follow the ascii44 run**, and 0.5 above
is T-ENC -- so 0.5 waits for the run, not for this week. *Correction to my
own Step 0 table: 0.5 is listed for completeness but is scheduled at T-ENC,
after T-44T.*

## What is off the 15-Sep path

Per the CPM, ascii44 is off the Guide-launch path. Everything in Steps 1-2 is
Checkup work. **The only items that touch the Guide launch are Step 3
(guide content) and any licence text naming Malwarebytes** -- and Step 3 can
ship in the guide's next revision rather than block 15-Sep, since the guide is
already at approval.

---

# QUESTIONS HELD TO THE END (Working Rule 8)

1. **The Gemini write-up**: paste it, or move `Ascii43-Test-Results-2026-08-26-1701-2-TEXT.md` (or an extract) into `ProjectDocs\` and sync, if you want my agree/disagree on it specifically.
2. **Does the current licence v3.0 name Malwarebytes anywhere?** I did not grep it; if item 9 goes "out," that text changes.
3. **Setting 15 conditional**: inside or outside the nineteen-settings freeze? Your ruling.
4. **Windows Update apply-and-loop**: confirm it is post-launch, so Claude Code does not scope it into ascii44.
5. ~~Date and time~~ -- supplied by Bill: 2026-09-05 00:18 ET.
