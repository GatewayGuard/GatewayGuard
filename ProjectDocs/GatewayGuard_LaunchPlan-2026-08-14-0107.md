<!-- Dated: 2026-08-14 01:07 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# GatewayGuard Launch Plan -- 18 days to 1 September

- **Document Name:** GatewayGuard_LaunchPlan
- **Last Modified:** 2026-08-14 01:07 ET
- **Last Editor:** Claude Code (CGDELL)
- **Built from:** `GatewayGuard_CPM_Schedule-2026-08-02-1201.md` (critical path
  and float), the ascii39 field results, and the repository as measured today.

**Change History Log:**
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

## GATE 0 -- DO THIS TODAY, BEFORE ANYTHING ELSE

### Confirm the code-signing certificate status. One phone call or one login.

**This has read "STATUS UNCONFIRMED" since 2026-08-02.** The CPM named it
*"the most likely thing to break this plan"* and told you to confirm it on
Monday 3 August. Twelve days later it is still unknown.

**Why it outranks everything:** signing gates screenshots, screenshots gate
the download page, and the download page gates launch. And the validation
response we filed says it plainly -- without a certificate, Windows shows
**"Unknown Publisher"**, which *"would prevent non-technical users from
running the software."* That is the entire audience.

**What is on file:** `Certificates\DigiCert OV Token Confirmation.pdf`, dated
**18 July**, and a completed
`ProjectDocs\GatewayGuard_DigiCert_Validation_Response.txt`. So a token was
assigned and answers were prepared. **Whether validation completed is not
recorded anywhere.**

**Three possible answers, three different plans:**

| Answer | What it means | What changes |
|---|---|---|
| **Validated, token in hand** | Best case | Nothing. Follow this plan as written |
| **Submitted, still pending** | Typical OV takes 3-5 business days | Chase it daily. Everything else stays parallel |
| **Not submitted / blocked on bank or D&B** | **The September date is at risk** | Decide TODAY between the fallbacks below |

### If the certificate cannot land in time -- decide now, not on 30 August

1. **Launch unsigned with an honest SmartScreen warning page.** Buildable,
   but it fights the product's core promise and this audience is the least
   equipped to click past a scary warning. **Weakest option.**
2. **Move the date.** 15 September costs two weeks and nothing else.
3. **A faster issuer.** Some resellers turn OV around quicker for an
   established LLC with an EIN. Worth one call.

**Do not let this drift another twelve days. It is the only item on this page
that money and time cannot fix late.**

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
| A6 | **Sign the build** | Bill | 0.5 | **BLOCKED ON GATE 0** |
| A7 | Hash + `download.html` | Claude Code | 0.5 | Content draftable now; hash after A6 |

**A2 is only three defects, not the 47 findings.** FT-171 stops sessions
ending by themselves. FT-172 stops screens lying about their own numbers.
FT-175 makes the Defender scan actually run -- it never has, on any machine.
**Everything else in the field results waits for ascii41.**

### TRACK B -- THE CERTIFICATE (Bill, external, longest pole)

| # | Task | Owner |
|---|---|---|
| B1 | **Confirm validation status** | Bill -- **TODAY** |
| B2 | If not submitted, submit. The answers are already written | Bill |
| B3 | If blocked on the bank letter or D&B, escalate or switch issuer | Bill |
| B4 | Test-sign a throwaway file the day the token works | Bill + Claude Code |

**The bank account is the hidden dependency.** DigiCert wants a qualifying
**checking** account named explicitly in the bank letter. If Maine Community
Bank is not open yet, B2 cannot complete.

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

## THE HONEST RISK

**One item can miss the date and nothing else can: the certificate.**

Every other line on this page is work that can be compressed, cut, or shipped
imperfect. The certificate is an external party's queue, it has been unmoving
for twelve days, and its dependency chain runs through a **bank account that
may not be open**.

**The second risk is smaller and real:** ascii40 surfaces a new blocker in
field test. The allowance is A4. Beyond that, ship with known cosmetic
defects and fix them in ascii41 -- the product does not need to be perfect on
1 September, it needs to be **signed, honest, and buyable.**

**What is genuinely in good shape:** the 19 website pages are built, verified
and clean; the field test plan for ascii40 exists with the root cause found;
the tooling (gates 12, 24, 25, the assert-guarded wrapper) is committed; the
LLC, EIN and domain are done.

**The build is closer than the paperwork.**
