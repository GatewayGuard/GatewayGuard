<!-- Dated: 2026-09-05 11:30 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii44 -- the build plan

- **Document Name:** GatewayGuard_ascii44BuildPlan
- **Base:** `Tool\W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1`,
  9,002 non-blank lines / 9,382 total
- **Sources:** `GatewayGuard_FieldTestTriage-ascii43run2-2026-08-30-1723.md`
  Parts 3-5; `GatewayGuard_CloudResearch-ascii43-2026-09-05-0018.md`;
  `GatewayGuard_ResponseToBillsNotes-ascii43-2026-08-30-1815.md`;
  `GatewayGuard_ScheduledTaskDefects-2026-08-20.md`; briefing open item 1
- **Status:** PLAN. Nothing built. Blocks A and B need no decision from Bill
  and can start immediately.

---

## WHY THERE IS AN ascii44 AT ALL

**ascii43 has been field run twice** -- five logs in
`Test_Results\FieldRun-ascii43\`, 2026-08-26 18:07 through 2026-08-30 11:04,
triaged in two documents. **A build that has been field run is spent.** The
remaining work takes a new number, and that number is 44.

**Next free FT number: 248. Next free screen ID: 90.**

---

## THE ORDERING PRINCIPLE

**By cost of being wrong, not by effort.** A defect that makes Checkup report
a success it did not achieve outranks a defect that annoys the user, because
the first one reaches the customer's support file and the second one reaches
their patience.

**Block A ships even if nothing else does.** If time runs short before the
SANDY run, cut from the bottom.

---
---

# BLOCK A -- NOTHING IS BLOCKED, AND IT IS THE HIGHEST COST OF BEING WRONG

## A1. FT-242 -- eight registry writes that cannot fail

**The defect.** Eight of the fourteen registry writes have no error trap, so a
write that fails is followed by `$result = "... GOOD"` and the log records a
success that never happened. **Bill watched this happen and wrote it down.**

**The fix, already specified in the triage:** add `-EA Stop` to all eight, and
move each `$result = "...GOOD"` line so it can only run after the write
returned. The correct pattern is already in the file twelve lines away.

**Why first:** it is mechanical, it is low risk, and it is the one defect that
makes the product lie in writing.

## A2. FT-203 -- the two reminders never run on a laptop on battery

***Measured:*** both scheduled tasks carry `DisallowStartIfOnBatteries = True`
and `StartWhenAvailable = False`, so on a laptop running on battery they never
fire and are never shown afterwards -- while the log prints
`[GOOD] Scheduled task created`. **Same shape as A1.** The fix and the one
product decision inside it are written out in
`GatewayGuard_ScheduledTaskDefects-2026-08-20.md`.

## A3. `B` is the only Back key -- 7 prompts

**Bill, 2026-08-30:** *"N always means no and B should always be used to say
back."*

***Measured, ascii43:*** `N` carries three meanings across 30 of the 47
`Read-ValidKey` sites -- No at 12, Back at 7, Exit at 11. **Only the 7 Back
sites change now.** Lines 3825, 6239, 6642, 7432, 7461, 7983 and **8522** --
the last is screen 27, the one Bill hit.

**The model to copy is already in the build, line 8548**, the only site of 47
that offers `B` today.

**Two of the seven are not simple swaps.** 6642 and 7983 ask a real question
whose honest answer is "no", and *then* go back as a consequence. Those need
`B` added **and** the `N` branch rewritten to mean no -- not `N` relabelled.

**The 11 `N = exit` sites do not move.** Bill asked for `X` = Exit at screens
14a and 18 and that is not decided. **Do not fold the two changes together**
-- changing two of three meanings at once brings the confusion back wearing a
different letter.

## A4. FT-244 -- screen 32 is drawn and never paused

The user never sees it. Plus the screen-34 overlap recorded with it.

## A5. FT-243 -- the required log notice is on a screen half the users skip

Move it to the review screen. **This is the "your choices can be reviewed in
your log" line**, shown once only, and the rule says which screen it belongs
on.

## A6. FT-245 -- three silent-error sites, not one

Recorded in the triage. Same family as A1: a failure that produces no
evidence.

## A7. FT-246 -- instrument the password-on-wake re-read

It fails twice and succeeds once, and nobody knows why. **Log both attempts
before attempting a fix.** Do not guess at a cause in this build.

## A8. Screen 12 -- reverse the drive order so the SSD is Drive 1

Bill asked for it. One line. It is what the customer sees first.

---
---

# BLOCK B -- NOTHING IS BLOCKED, AND IT COMES FROM CLOUD'S RESEARCH

**Everything in Block B was checked against the source this morning. What was
already built has been removed from the list.**

## B1. FT-248 -- nuisance-software blocking is never read, and it decides the scan

***Measured:*** the string `PUAProtection` **does not appear anywhere in
ascii43.** *Sourced, Microsoft:* Defender detects potentially unwanted
applications only when this is on, and Microsoft recommends both halves on.

**Build:** read `(Get-MpPreference).PUAProtection` before the scan gate. If it
is not 1, ask permission, apply `Set-MpPreference -PUAProtection Enabled`,
**re-read**, and report what the re-read said -- not what the write intended.

**The second half is Edge's, not Defender's.** *Sourced:* "Block downloads"
works only in Microsoft Edge and is an Edge SmartScreen setting the Defender
route does not touch. **Show manual steps for that half. The exact current
Edge path is open research** and is in the note to Cloud -- do not write a
path that has not been read off a live Edge.

**One thing the customer will meet:** on a PC with Smart App Control
enforcing, the "Block apps" box is greyed out because Windows has taken it
over. ***Measured on CGDELL 2026-08-24.*** That needs one plain sentence or a
reader will think they broke something.

**Gate 24 applies to every command above.**

## B2. FT-249 -- a scan with stale definitions prints a clean result that means nothing

***Measured:*** no signature-age read exists in the build. `Get-MpComputerStatus`
already returns `AntivirusSignatureAge` and the build already calls that
cmdlet. **This is the FT-162 shape** -- a GOOD printed over a check that could
not have succeeded.

**Build:** read it before the scan gate and instruct if stale. **The threshold
is open research** -- use Windows' own number, not one we invent, or the
customer gets two verdicts on one PC.

## B3. FT-250 -- settle the machine before reading it

***Measured, FT-239 from run 2:*** Windows turned real-time protection back on
by itself mid-test. **The machine's state moves underneath the tool while
these settings are unsettled**, so every reading taken before they are settled
is untrustworthy.

**Build the run order:** Tamper Protection -> Windows Update status -> nuisance
blocking -> signature age -> scans.

**Tamper Protection is already read correctly** (`Get-TamperProtectionState`,
lines 5647-5666, `IsTamperProtected` primary since ascii33). **What is new is
the position and the re-read** -- when the user fixes it by hand, read it
again rather than carrying the old answer forward.

## B4. FT-251 -- setting 6 says "manual required" without saying why

***Measured, lines 6389-6410:*** the write is attempted with `-EA Stop` and
the permission-denied case is caught and handled. **Leave `CanAuto` alone --
on a PC where the write is allowed it succeeds today, and marking it manual
would switch off a working path for everyone.**

**Change the wording only.** When the write is genuinely blocked, say why:
Tamper Protection is on, that is correct and good, and it is what is blocking
this. Now that Tamper Protection is read before this point (B3), the tool can
state it as a fact rather than a guess.

**Bill's own sentence covers this and four other screens:** *"These must be
set manually, Checkup will show you how."*

## B5. FT-252 -- Windows Update: check and instruct, do not install

*Sourced:* the Windows Update Agent COM API can search, download and install
without any third-party module. **We are not going to use the install half for
launch.** It is the highest blast-radius feature on the list, it can leave a
senior's machine part-way through servicing, and it has never been run once on
a project machine. Cloud agrees and so does the record.

**Build:** check status, and where updates are pending say plainly what to do
and that Checkup should be run again after the restart. **The resume-after-
reboot path already exists** for the offline scan and is the shape to copy.

**Do not use `PSWindowsUpdate`.** It is an internet install of third-party
code into a product whose promise is that you can read every line.

## B6. FT-253 -- the F6 wording block

~20 items plus FT-222 and FT-237. **Bill has already written most of the
replacement copy himself** in Part 2B of the triage. Unblocked, entirely
wording, and the largest single block of remaining work.

**FT-237 belongs here:** the Advertising ID revert path names *"Let apps use
advertising ID"*, which is a stem and not the on-screen label.

## B7. FT-247 -- the numbering goes backwards, and there is no 30a

26 -> 25c is a first-encounter decrease, which the screen-number rule forbids.
**Decide it in `GatewayGuard_ScreenNumberDesign-*.md` first, then build.** Run
`Tool2\Run-ScreenCoverageCheck.bat` after.

---
---

# BLOCK C -- BLOCKED ON BILL

**None of this starts until the answer exists. All three are in
`GatewayGuard_DecisionsForBill-2026-09-05-1130.md`.**

## C1. FT-254 -- GUI mode is labelled "Recommended for first time users"

***Measured, lines 8064-8073*** and the build's own header at line 642: mode 2
**has never been inventoried, every field log is mode 1**, and its screens
carry IDs only where they share a call with mode 1.

**Two ways out, and it is Bill's:** drop the "recommended" label, or drop mode
2 from the launch build. **The label is the smaller change; removal is the
honest one if GUI mode will not be field run before 15 September.**

## C2. Malwarebytes -- in or out

**The largest change set in the plan and the only one that reaches outside the
tool.** Four screens, the monthly reminder task, the guide section, the
pricing copy, the website, and **three sentences in the licence** -- two in
Section 8's other-companies paragraph and one in the trademark line.

**Do not start any of it until the decision exists**, and the decision waits
on one afternoon of measurement on SANDY (Block D).

## C3. The password-manager reasoning

**The behaviour is already correct and does not change.** ***Measured, lines
6665-6689:*** Checkup asks first and leaves Edge saving on for anyone without
a separate manager.

**What is in question is the "why" text**, which frames a browser manager as a
single point of failure while NCSC calls it a very good choice for exactly our
reader. **Customer-facing copy on a frozen setting. Bill's call, not mine.**

---
---

# BLOCK D -- BLOCKED ON A MEASUREMENT, NOT ON A PERSON

## D1. F4 -- the second drive

**Route 3: Checkup covers the other drives.** Its screen text is
**gate-24-blocked** until a full scan is measured actually covering `D:` **on
SANDY** -- CGDELL has no large second drive.

***Measured 2026-08-21:*** `Start-MpWDOScan` has no scope parameter at all, so
`D:` coverage comes from `Start-MpScan -ScanType FullScan`, a full **online**
scan. **The wording must say "full scan of all your drives" and must never
say "offline scan".**

**Bill's screen-12 drive list, Part 2D of the triage, is the specification.**

## D2. The Malwarebytes comparison test

Restore the quarantined items on SANDY, turn nuisance blocking on, scan with
Defender, scan with Malwarebytes free, fill the `07 PUA` rows of the existing
coverage grid. **One afternoon, and it decides C2.**

**Do it before SANDY is encrypted.** Reimaging would destroy the quarantine.

## D3. The USB-drive sentence on screen 25d

*Sourced, Microsoft:* device encryption covers the OS and fixed drives and
does not encrypt external or USB drives, and Home has no way to encrypt one.
**The website says this today** -- it is a fact about Windows, so it needed no
measurement there.

**The tool screen is different**, because it will sit beside a claim about
what Checkup did. Measure it once on SANDY: plug a drive in, turn encryption
on, read `manage-bde -status` for the removable volume. **Then write it.**

## D4. The encryption screens -- the local-account condition

*Sourced, Microsoft Support:* a PC set up with a Microsoft account has device
encryption turned on automatically with the key attached to that account; a PC
set up with a local account does not. **So SANDY's behaviour generalises to
local-account machines, not to all Home machines**, and the six screens must
carry the condition rather than assert the general case.

**Checkup already detects both halves** -- `Get-SignInAccountType` at line
7498 and encryption state at setting 8 -- so the sentence can be driven by
data instead of asserted. **Note Bill removed the visible account-type line in
ascii41** (see the comment at 7654); putting a version of it back is a
decision, not a bug fix.

---
---

# NOT IN ascii44

- **FT-220** -- waits on the guide (rule W-07).
- **Windows Update apply-and-loop** -- post-launch, with its own field run.
- **`X` = Exit and the 11 `N = exit` sites** -- undecided, and deliberately
  not folded into A3.
- **The remaining encryption items** that need a live encryption run.

---

# THE MECHANICS -- DO NOT SKIP THESE

1. **Every edit through `gg_edit.py`, assert-guarded.** No exemption for
   wording or comment passes. A lint pass with raw string edits corrupted
   ascii34.
2. **One family per commit**, as ascii43 was built.
3. **Five build-ID locations** must move together: the filename, the `FILE:`
   header, the `BUILD:` header, `$BuildID`, and the line in `CLAUDE.md`.
   Pre-Build Audit item 9 checks all five.
4. **After every edit session:** the file parses with zero errors and the line
   count is plausible. **Brace balance is not enough** -- the corrupted file
   was perfectly balanced and completely destroyed.
5. **Gates before presenting the build**, all from `Tool2\`:
   `Run-ScreenCoverageCheck.bat` (12 and 12b, the 26-line ratchet),
   `Run-ExternalCommandCheck.bat` (24 -- **B1, B2 and B5 all add external
   commands, so this one matters more than usual this build**),
   `Run-DocCheck.bat`, `Run-RepoHealthCheck.bat`.
6. **Every new external command carries its evidence in a comment beside it**,
   `# VERIFIED YYYY-MM-DD measured on <machine>: ...`. *inferred* and *guess*
   are not shippable. **This is the rule FT-162 was written in blood for** --
   `ScanType 4` shipped for months, returned "invalid argument" in 0.0
   seconds, and the log said `[GOOD]` every time.
7. **26 lines per screen**, ratcheted against the ten-screen baseline. Any new
   screen over 26 fails the build.
8. **Field checklist** for the SANDY run, written before the run, not after.

---

# WHAT I WOULD START ON TODAY

**Block A, in order, beginning with FT-242.** It needs no decision from
anyone, it is the highest cost of being wrong, and it is roughly a third of
the build.
