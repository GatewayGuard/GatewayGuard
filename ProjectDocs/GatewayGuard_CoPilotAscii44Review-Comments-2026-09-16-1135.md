<!-- Dated: 2026-09-16 11:35 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Copilot's ascii44 review and the BitLocker test plan -- checked, one fix applied

- **Document Name:** GatewayGuard_CoPilotAscii44Review-Comments
- **Dated:** 2026-09-16 11:35 ET
- **Editor:** Claude Code (CGDELL)
- **Reviews:** three files Bill pasted from Copilot into `ProjectDocs\` today --
  `Co-Pilot-ASCII44-Improvement-Plan-2026-09-16-0923.txt`,
  `code ascii44-44 comments-2026-09-16-0925.txt` (a code-level review,
  duplicated verbatim as `Tool\I reviewed the comments document pl.txt`,
  now retired to `Archive\`), and `BitLocker-Test-Plan-2026-09-16-0948.md`.
  A fourth, `Co-Pilot-ASCII45 Detailed Build Plan-2026-09-26-0942.txt`, is a
  forward plan built on the same findings -- referenced, not separately
  re-verified here.
- **For:** Bill, then Claude Cloud
- **Status:** COMMENTS. One build fix already applied and gated; everything
  else is a recommendation, verified or not, for Bill and Cloud to weigh.

---

## THE ONE-PARAGRAPH VERDICT

**Copilot's code-level review is accurate and well-sourced -- it read the real
diff between ascii43 and ascii44 and its praise (SmartScreen, FT-256,
scheduled-task validation) matches what actually shipped.** Its four
"effective state vs. policy state" suggestions (items 9, 13, 14, 15) name a
real, already-known gap -- the build's own header already calls it **FT-123b**
and has carried it since ascii37. **One of the four cleared verification
today and is now fixed. Two of Copilot's specific proposed registry/JSON keys
do not exist on this machine, and building against an unseen key name is
exactly what this project's own gate 24 forbids.** The BitLocker test plan
asks for hardware and destructive tests this fleet does not have and should
not risk -- real content, wrong shape for three machines.

---

## PART A -- WHAT WAS CHECKED, AND WHAT CHANGED

### FT-123b, item 15 (Edge Password Saving) -- FIXED, VERIFIED FIRST

Copilot's P2-3: read Edge's Preferences JSON for `credentials_enable_service`
instead of relying only on the policy key. **This is not a new finding --
the build's own header names this gap as FT-123b and gives the reason it was
never built: "RESEARCH BEFORE STATING and gate 13 ... apply and neither is
satisfied yet."**

***Measured on CGDELL 2026-09-16, before writing any code:***
`%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Preferences` exists,
parses as JSON, and its top-level `credentials_enable_service` key is
present and readable -- `False` on this machine. **That clears FT-123b's
own stated blocker, for this one key.**

**Fixed.** `Get-GGEdgeEffectiveBool` reads that key **only when the policy
value is absent** -- the policy read stays first and authoritative, because
items 12-15 are the settings Checkup itself applies through policy keys
(FT-258), so a change Checkup made must still read back from the policy key.
The new read only turns some "Unknown" results into a real answer, for a
user who changed the setting inside Edge itself and never touched the
policy key -- which is the exact case FT-123 was written to catch.

***Verified against the shipped function, not a copy: `Found=True,
Value=False` for the real key; `Found=False` for both a wrong key name and
a nonexistent one.*** Gates after: 12, 12b, 24 PASS. Parse 0 errors, 0
non-ASCII, 88 functions, no duplicates.

**One known gap, stated rather than guessed:** this reads the "Default"
Edge profile only. A reader running a second profile is not covered, and
the code says so in a comment.

### FT-123b, item 13 (Edge Startup Boost) -- STILL OPEN, AND NOW SHARPER

Copilot's P2-1 names two keys: `startup_boost_enabled` and
`background_mode_enabled` inside the same Preferences file.

***Measured the same file, same day: neither exists.*** No top-level
`startup_boost_enabled`, no top-level `background_mode` object at all.
**Copilot's suggestion for item 13 does not hold up as written.** Either the
real key is named or nested differently, or the flag only appears once a
user has actually toggled Startup Boost at least once (unconfirmed). **Not
built, on the same rule that just closed item 15: never write a flag or key
you have not seen hold a value.** Worth a research pass -- toggle Startup
Boost by hand once and re-read the file -- before any further attempt.

### FT-123b, item 14 (Widgets) -- STILL OPEN, PARTIALLY MEASURED

Copilot's P2-2 names `HKCU\Software\Microsoft\Windows\CurrentVersion\
Explorer\Advanced\TaskbarDa`.

***Measured: the value exists and reads `1` on CGDELL.*** That is one
verified signal, not two agreeing ones -- I have no way to visually cross-check
the real taskbar's widgets button from here, so "the key reads a plausible
value" is not the same as "the key is proven to track the real state." Not
built. Worth a five-second confirmation at the keyboard (toggle Widgets off
in the taskbar, re-read `TaskbarDa`, confirm it flips) before this is called
verified the way item 15 now is.

### Windows Hello (item 9) -- concern is fair, no verified alternative offered

Copilot's P2-4 correctly describes the current check
(`Test-Path $env:LOCALAPPDATA\Microsoft\NGC`) as folder-existence rather than
true enrollment state, and correctly says a broken or partially-removed PIN
could leave the folder behind. **Agreed as a real limitation.** Copilot
proposes "Hello APIs or account sign-in option checks" without naming one --
that is not yet a buildable suggestion, it is a direction. Nothing built.
Raised for whoever picks this up next.

### Remote Desktop -- Copilot confirms current handling is correct

No action needed; recorded so the item does not get re-litigated.

---

## PART B -- WHAT WAS NOT DONE, AND WHY (Priorities 3, 4, 5)

Copilot's architecture recommendations -- a shared `GGStatus` object model
(P3-1), a central policy-lock framework (P3-2), a central registry-read
wrapper (P3-3), a diagnostics screen (P4-2), a settings-export file (P4-3),
splitting the giant switch blocks into named functions (P5-1), and an
automated validation harness (P5-2) -- **are not wrong, and none of them
were attempted.**

**Why not now:** launch is 2026-10-15, roughly four weeks out, and ascii44
has not yet been field run at all. A structural rewrite of the settings
engine this close to a first field run is exactly the kind of change that
turns one small defect into a build-wide one -- the project's own
`PYTHON EDITING RULES` and the 2026-07-25 corruption (a lint pass that
turned 341 KB into 13.7 MB and stayed brace-balanced the whole time) are the
standing argument against exactly this shape of change under time pressure.
**These belong on `Co-Pilot-ASCII45 Detailed Build Plan` or later, after
ascii44's first field run, not folded into ascii44 today.**

---

## PART C -- THE BITLOCKER TEST PLAN

**The content is right. The shape does not fit this project's hardware, and
part of it is unsafe to run on the machines this project actually has.**

**What it asks for:** five machines (A-E) covering Home/Pro, local/Microsoft
account, and pre-encrypted states, plus twelve tests including a TPM clear,
a TPM reinitialize, a live BIOS/UEFI firmware update, and disabling Secure
Boot on an already-encrypted production machine.

***Measured against the actual fleet, `CLAUDE.md` section 4: three machines
exist -- CGDELL (Pro, Microsoft account, encrypted), SANDY (Home, local
account, unencrypted), Sandy3 (Home, encrypted, account type unverified).***
**Not five. Machines B and D, as specified, do not exist at all** (Home and
Pro with a fresh local account, neither yet encrypted) without a factory
reset of hardware this project depends on for other testing.

**Tests 8, 9 and 10 -- TPM clear, a live firmware update, and boot-order
changes on an encrypted machine -- carry real risk of the exact harm
`GatewayGuard_ExternalGuideReview-Comments-2026-09-15-1324.md` already
flagged: this is the class of test where a wrong answer costs a reader their
files, done here on a machine Bill actually uses.** This project already
treats recovery keys as never-to-be-risked -- they are kept redundantly
(print and multiple digital copies) specifically so nothing about them is
ever attempted without a safety margin, and TPM-clear / firmware-update
tests are the closest thing to spending that margin deliberately.

**What is genuinely actionable, on the hardware that exists:**

- **Test 2 (Home + local account, does Device Encryption require a
  Microsoft account)** -- SANDY already matches this exactly, right now,
  unencrypted. No new setup needed.
- **Test 12 (recovery-key retrieval drill, using only the Guide/website
  instructions)** -- runnable on CGDELL today with zero risk; it reads a key
  that already exists, it does not create or destroy one.
- **Tests 3 and 4 (recovery-key timing, online vs. offline)** -- runnable on
  Sandy3 if a factory-reset-free path exists to observe first-time
  encryption there; not confirmed.

**Recommendation to Bill, not actioned:** treat this plan as a menu, not a
checklist. The two zero-risk items (2 and 12) can run this week on the
fleet that exists. The TPM/firmware/Secure-Boot items need either dedicated
disposable hardware or should be answered from Microsoft's own documented
behaviour (**sourced**, not measured) rather than reproduced by hand on
CGDELL or Sandy3.

---

## PART D -- HOUSEKEEPING, DONE WITHOUT WAITING TO BE ASKED

**`Tool\` had drifted back to holding seven things that were not the current
build** -- a byte-identical stray copy of the retired ascii43 `.ps1`
(confirmed identical to the tracked copy in `Builds\` before anything moved),
two plain-text scratch copies of the build made to hand to Copilot, a
duplicate of Copilot's code review, a Malwarebytes scan report, and two old
folders (`Run_Comments\`, `_corrupt\`) that had already been retired once
before, on 2026-09-04, for this exact violation. **All untracked, none
deleted -- moved to `Archive\Tool-Contents-Retired-2026-09-16\`, and the
Malwarebytes report to `Test_Results\` where its family lives.** `Tool\`
now holds only `W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1` and
`desktop.ini`, matching the rule this project has stated three times now.

---

## SOURCES

- `Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1` -- every line
  and function name above, and the FT-123b header entry.
- Measured live on CGDELL, 2026-09-16: the Edge Preferences JSON contents,
  the shipped `Get-GGEdgeEffectiveBool` function's output on three inputs,
  and `TaskbarDa`'s current value.
- `CLAUDE.md` section 4 (machine fleet) and the mouse-work entry's
  "never remove BitLocker keys" precedent.
- `ProjectDocs\GatewayGuard_ExternalGuideReview-Comments-2026-09-15-1324.md`
  -- the VERIFY-marker caution this plan itself cites.
