<!-- Dated: 2026-08-14 01:07 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# GatewayGuard Launch Plan -- 18 days to 1 September

- **Document Name:** GatewayGuard_LaunchPlan
- **Last Modified:** 2026-08-14 16:30 ET
- **Last Editor:** Claude Code (CGDELL)
- **Built from:** `GatewayGuard_CPM_Schedule-2026-08-02-1201.md` (critical path
  and float), the ascii39 field results, and the repository as measured today.

**Change History Log:**
- 2026-08-14 16:30: **GATE 0 CLOSED -- the certificate is issued and
  installed.** Gate 0 rewritten from a question into a result, Track B marked
  done except the test signature, and the risk section replaced: the longest
  pole is gone and a smaller dated risk takes its place (the token password
  expires 2026-09-13).
- 2026-08-14 01:07: Created. The CPM schedule is 12 days old, its feature
  freeze date is **today**, and ascii40 is not built. This re-orders the
  remaining work against 18 calendar days.

---

## THE NUMBERS

**18 calendar days. About 12 working days.** Today is Friday 14 August.

The CPM's critical path is **build -> freeze -> sign -> screenshots -> launch
page**. Two of those four have not started, and the third is blocked on
something nobody has confirmed in twelve days.

---

## GATE 0 -- CLOSED, 2026-08-14. BEST CASE.

### The code-signing certificate is issued and installed.

The answer came back on the day this plan asked for it, and it is the good
one: **validated, token in hand.** The fallbacks below are struck through --
none of them is needed.

**Measured twice, by two instances, serial numbers matching exactly.** Cloud
read it from SAC Tools; Claude Code read it from `Cert:\CurrentUser\My` at
16:25 ET.

| Field | Value |
|---|---|
| Subject | `CN=GatewayGuard LLC, O=GatewayGuard LLC, L=Brunswick, S=Maine, C=US` |
| Issuer | `CN=DigiCert Trusted G4 Code Signing RSA4096 SHA384 2021 CA1` |
| Serial | `01CB7A973EBF26A608319C22D7ACB78A` |
| Thumbprint | `0995F50D9496116A36624D8A81B404439C55B796` |
| Valid | 2026-08-14 to 2027-08-16 |
| `HasPrivateKey` | **True** -- the key is reachable from CGDELL |
| Token | SafeNet eToken 5110+ FIPS, FIPS 140-2 L2 |

**What this buys:** no "Unknown Publisher" warning. The validation response on
file said that warning *"would prevent non-technical users from running the
software"* -- the entire audience. That risk is gone.

~~Launch unsigned with a SmartScreen warning page. Move the date to 15
September. Try a faster issuer.~~ **All three withdrawn.**

### It signs. Proved 2026-08-14 17:17 ET.

**B4 PASSED on the first attempt**, on CGDELL, against a throwaway file. Full
report: `Test_Results\SignTest-2026-08-14-1717\SignTest-Report.txt`.

| Check | Result |
|---|---|
| Signature status | **Valid** -- *"Signature verified."* |
| Signer thumbprint | `0995F50D...B796` -- matches the issued certificate |
| **Timestamped** | **Yes** -- DigiCert SHA256 RSA4096 Timestamp Responder 2025 1 |
| Signature block written into the file | Yes |

**The timestamp is the one worth naming.** Without it every signature would
stop verifying on 2027-08-16 when the certificate expires -- silently breaking
copies already sold. It is present, so signatures outlive the certificate.

**Signing the real build is the same command against the build file.** No
Windows SDK, no signtool: zero `.exe` or `.msi` ship here, so
`Set-AuthenticodeSignature` is the whole toolchain.

**A6 is now a known quantity rather than a hope.**

### The new dated risk -- read this, it is smaller but real

**The token password expires 2026-09-13**, a thirty-day expiry set at
initialization. That is **twelve days after launch**, so it does not threaten
1 September -- but it will land during the first fortnight of selling, when a
patch build is most likely.

- Password is **16 characters maximum**, held in Proton Pass.
- The replacement goes into Proton Pass **the same minute** it is changed.
- **The admin password stays at factory default on purpose.** It is the only
  unlock path, and losing it bricks the token permanently. DigiCert has no
  override.

---

## THE ORDERED LIST

Tracks B, C and E can run at the same time as A. **Only Track A is the
critical path.**

### TRACK A -- THE BUILD (critical path)

| # | Task | Owner | Days | Notes |
|---|---|---|---|---|
| A1 | Run `Tool\Run-ConsoleInputModeCheck.bat` **on SANDY** | Bill | 5 min | Confirms the FT-171 root cause. **Do this first** -- if the result is unexpected, the ascii40 fix changes |
| A2 | **Build ascii40** -- FT-171, FT-172, FT-175 | Claude Code | 2 | The three blockers, in that order |
| A3 | **Field test ascii40 on SANDY** | Bill | 0.5 | Phase 3 of the field test plan. Provoke the input bug deliberately |
| A4 | Fix what A3 finds | Claude Code | 1 | The allowance. Beyond it, ship with known cosmetic defects |
| A5 | **FEATURE FREEZE** | Bill | -- | Was scheduled for today. Realistically **Wed 20 Aug** |
| A6 | **Sign the build** | Bill | 0.5 | **UNBLOCKED 2026-08-14.** Needs B4 proved first |
| A7 | Hash + `download.html` | Claude Code | 0.5 | Content draftable now; hash after A6 |

**A2 is only three defects, not the 47 findings.** FT-171 stops sessions
ending by themselves. FT-172 stops screens lying about their own numbers.
FT-175 makes the Defender scan actually run -- it never has, on any machine.
**Everything else in the field results waits for ascii41.**

### TRACK B -- THE CERTIFICATE (was the longest pole; now nearly done)

| # | Task | Owner | Status |
|---|---|---|---|
| B1 | Confirm validation status | Bill | **DONE 2026-08-14** |
| B2 | Submit if not submitted | Bill | **DONE** -- issued |
| B3 | Escalate if blocked on bank letter or D&B | Bill | **NOT NEEDED** |
| B4 | Test-sign a throwaway file and verify it | Bill + Claude Code | **DONE 2026-08-14 17:17 -- PASS, timestamped** |
| B5 | **Change the token password before 2026-09-13** | Bill | Diarise it. New password into Proton Pass the same minute |

**B4 is now the top item in this track and takes minutes.** One open question
first: **what artifact actually ships?**

- **If Checkup ships as `.ps1` + `.bat`** -- `Set-AuthenticodeSignature` is
  built into PowerShell and signs the `.ps1` directly. **Nothing to install.**
  (A `.bat` cannot carry an Authenticode signature at all. That is how batch
  files work, not a defect, and the `.bat` is a two-line launcher for a signed
  `.ps1`.)
- **If anything is packaged as `.exe` or an installer** -- that needs
  `signtool.exe`, and **measured on CGDELL with two queries of different
  shape, signtool is not installed**: 0 hits across `PATH` and four SDK and
  Visual Studio root paths. Installing the Windows SDK is a change to Bill's
  machine, so it is his call, and it wants doing **now** rather than on
  freeze day.

**The bank-account dependency is dead.** DigiCert wanted a qualifying checking
account named in the bank letter; the certificate issued, so that question is
settled whatever the answer was.

### TRACK C -- SELLING (Bill, parallel, no dependency on the build)

| # | Task | Owner |
|---|---|---|
| C1 | Gumroad account, product page, $19.99 | Bill |
| C2 | Refund policy wording -- LegalZoom Call 2 | Bill |
| C3 | Sales tax handling on Gumroad | Bill |
| C4 | Test purchase end to end, with a real card | Bill |

**C4 is the one people skip.** A checkout that fails on launch day costs more
than any defect in the build.

### TRACK D -- THE WEBSITE (Claude Code, has float)

| # | Task | Owner | Notes |
|---|---|---|---|
| D1 | **Publish the 19 guide pages** | Claude Code | They exist, verified, gate 25 clean. `gatewayguard.co` has shown **UNDER CONSTRUCTION since 21 July** |
| D2 | Rewrite `index.html` -- remove the banner | Claude Code | |
| D3 | `download.html` -- draft now, hash later | Claude Code | |
| D4 | Fix FT-183 -- 16 pages never introduce the product name | Claude Code | Half a day |
| D5 | tips / beta / compatible pages | **CUT unless time appears** | Needs product decisions that do not exist |

### TRACK E -- THE PAID GUIDE (Cloud writes, Claude Code files)

| # | Task | Owner | Notes |
|---|---|---|---|
| E1 | **Fix the TOC defect** | Bill in Word | **Page 1 of the paid product reads *"Right-click here and choose Update Field"*.** Two minutes to fix, and it is the first thing a paying customer sees |
| E2 | **Add a cover, author and copyright notice** | Cloud + Bill | **The guide says "GatewayGuard" ZERO times and "Checkup" ZERO times** in 36 pages |
| E3 | Fix 3 PL-4 breaches and 1 "whether" | Cloud | Named in the source pack |
| E4 | Rewrite for the senior-alone reader | Cloud | 16 uses of "the user"; one line says *"ask the user first"* |
| E5 | Re-export the 5 print PDFs | Bill | After E1-E4 |
| E6 | Close the coverage gap -- guide covers ~12 settings, site covers 19 | **CUT for launch** | Say plainly the guide covers the essentials |

**E1 and E2 are not optional.** A paid product whose first page shows an
un-updated field code, and which never names itself, is not shippable at any
price.

---

## WHAT I WOULD CUT, AND WHY

| Cut | Reason |
|---|---|
| Full guide rewrite (E4 beyond a pronoun pass) | 36 pages of rewriting does not fit in 12 days alongside a build |
| Guide coverage gap (E6) | Say what it covers; expand post-launch |
| tips / beta / compatible pages (D5) | Blocked on decisions nobody has made |
| The 10 oversized screens | Cosmetic. In the gate-12b baseline already |
| The other 44 ascii39 findings | ascii41 |
| Annual Updates pricing | Post-launch. It is a second SKU, not a launch blocker |
| Microsoft Store | Post-launch. Gumroad is decided and sufficient |

---

## THE HONEST RISK -- rewritten 2026-08-14 16:30

~~One item can miss the date and nothing else can: the certificate.~~
**The certificate landed. That risk is closed**, and with it the only item on
this plan that money and time could not fix late. Nothing on the critical path
now depends on an outside party's queue -- **every remaining item is work in
this room.**

**The risk that replaces it is the ordinary one: 12 working days, one solo
developer, and a build that is not written yet.** That is a scheduling
problem, not a hazard. It responds to cutting scope, and the cut list above is
the response.

**The live risks, in order:**

1. **ascii40 surfaces a new blocker in field test.** The allowance is A4.
   **This is now the top risk on the plan**, and it is the ordinary kind.
2. **The token password expires 2026-09-13**, twelve days after launch, during
   the fortnight a patch build is most likely. Diarised as B5.

~~The test signature has never been produced.~~ **Retired the same day it was
written.** B4 passed at 17:17 ET, timestamp and all. The fear behind it -- a
Windows SDK install discovered on freeze day -- turned out not to exist: there
is nothing here that signtool would sign.

**On risk 2, the standing allowance:** beyond A4, ship with known cosmetic
defects and fix them in ascii41. The product does not need to be perfect on
1 September. It needs to be **signed, honest, and buyable** -- and as of today
the first of those three is possible for the first time.

**What is genuinely in good shape:** the certificate is issued and the private
key is reachable from this machine; the 19 website pages are built, verified
and clean; the field test plan for ascii40 exists with the root cause found;
the tooling (gates 12, 24, 25, the assert-guarded wrapper) is committed; the
LLC, EIN and domain are done.

~~The build is closer than the paperwork.~~ **The paperwork is done. The build
is now the whole job** -- which is the position you would have chosen 18 days
out, because it is the part nobody else controls.
