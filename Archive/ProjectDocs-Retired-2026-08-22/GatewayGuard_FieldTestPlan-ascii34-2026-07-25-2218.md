<!-- Dated: 2026-07-25 22:18 EDT -->
# GatewayGuard Field Test Plan -- ascii34
- **Document Name:** GatewayGuard_FieldTestPlan-ascii34
- **Last Modified:** 2026-07-25 22:18 EDT
- **Status:** Test plan (pre-run). Results go into a new
  GatewayGuard_TestHistory-ascii34 document after the run.
- **Supersedes:** nothing. First field test plan for ascii34.

**Build under test:** `Tool\W11-SecurityHardening-v3-ascii34-2026-07-25-2142.ps1`
**Build date:** 2026-07-25 21:42 ET (5,574 lines, 341 KB, parses clean)
**UNRUN BUILD RULE:** ascii34 is an UNRUN BUILD. This run clears it.
ascii35 scoping does not open until this is done.

> **File-integrity note:** this build file was corrupted by a bulk edit at
> 21:26 and restored byte-for-byte from the 21:20 snapshot. Verified
> before this plan was written: 5,574 lines, 0 parse errors, SHA256
> matches the snapshot. The file under test is the intended ascii34.

---

## THE ONE RULE THAT MATTERS FOR THIS RUN

**Do a fresh, full start-over run. Do not resume.**

ascii33's field test resumed 3 of its 4 logs, and that is *why* half the
build went unverified — SCREEN-26/27 were never reached in any log,
ConvenienceReview (FT-94/95) was skipped entirely, FT-102 was never
captured. A resume-heavy run will produce the same blind spots again and
ascii34 will still not be cleared.

If the run dies partway, note where, then **start over from the
beginning** rather than resuming — at least once, end to end.

---

## MACHINE MATRIX

| Machine | Edition | Covers | Required? |
|---|---|---|---|
| **HP Notebook 17-by1xxx (SANDY)**, 8 GB, MachineID F7F13A97D58D | Win 11 **Home** | FT-110/D-20 (the whole reason this run exists), FT-115, FT-117, FT-109 | **YES — cannot clear ascii34 without it** |
| **Dell Latitude 5430** | Win 11 **Pro** | FT-108 family (already-encrypted BitLocker path), Pro-side regression check | Recommended, not blocking |

FT-110 is the headline fix and it is *Home-only logic*. It has been
researched and logically verified but **never run on a Home machine**.
The dev machine is Pro and structurally cannot exercise it.

### BLOCKED UNTIL 2026-07-26 -- HP NETWORK

**The HP has no working internet, and a USB WiFi adapter is being
delivered 2026-07-26.** The run waits for it.

This is a **hard prerequisite, not a convenience**. FT-110 -- the single
reason this field test exists -- routes entirely through signing in with
a Microsoft account and confirming the recovery key reaches
account.microsoft.com/devices/recoverykey. With no connectivity on the
HP, FT-110 cannot be verified at all, and a run without it does not
clear ascii34.

Related: ascii33 note 19 flagged a DHCP/network problem on the HP. It was
ruled out as the FT-110 cause (0x8031005A is an edition error, not a
network error), but it is the same underlying connectivity gap the USB
adapter is meant to close.

**On delivery day, before starting the run:**
- [ ] USB WiFi adapter installed and HP has confirmed internet access
- [ ] Browser can reach account.microsoft.com from the HP
- [ ] Microsoft account credentials on hand (FT-110 needs an actual sign-in, not a local account)

---

## PER-ITEM VERIFICATION

### Blockers (ascii34's stated scope)

| ID | What to do | Passes if |
|---|---|---|
| **FT-109** | Let the run create both scheduled tasks. Then open Task Scheduler and inspect each. | **Both** tasks exist. Quarterly Defender Offline Scan is present and its action path is correctly quoted. (MB Monthly Reminder passed in ascii33; Defender Offline failed both runs on path quoting.) |
| **FT-110/D-20** | HP only. Reach the BitLocker screen. | Home branch renders — **`Enable-BitLocker` is never called** and **0x8031005A never appears**. Screen checks 3 prereqs (TPM, Secure Boot, WinRE) and tells you to sign in with a Microsoft account, then verify the key actually lands at account.microsoft.com/devices/recoverykey. |
| **FT-111** | Read the BitLocker overnight option wording. | It no longer claims sleep is handled in a way it isn't. Wording is honest about what happens. |
| **FT-112** | Press **Ctrl+C** during the main checklist's two-digit item-number entry. | Program does **not** die instantly. You get a clean "are you sure" exit. Then confirm Mark-mode copy (Enter) still works — the fix must not break copying. |

### Before-launch items

| ID | What to do | Passes if |
|---|---|---|
| **FT-113** | After **every** exit this run — clean, Ctrl+C, or crash — open the log. | Footer is written **every time**, and the caller is never blank. `(called from: )` with nothing inside is a FAIL. |
| **FT-114** | On the HP (Defender active + MB Free companion), reach HEADS UP. | "Defender Real-Time / Status: ON" does **not** appear as a not-selected concern. Healthy items must not be flagged. |
| **FT-115** | HP only. Watch Memory Integrity status wherever it renders. | Shows a real state, not "Unknown". This was fixed by inference on a Pro dev box and could not be reproduced locally — **the HP is the only real test.** |
| **FT-116** | Watch for "Section -- Step N" on Baseline, PowerReview, TaskSetup. | It is **visible**. It was correct all along but rendered in DarkCyan (this file's de-emphasis color); it is now plain Cyan. This is purely a "can you see it" test. |
| **FT-117** | Resize the console and re-render the checklist at ~70, 80, and 100 columns. | No truncation at any width. Nothing cut off to the right of "2. Defender Status". Widths are now measured per render, not guessed from two presets — so test more than one width. |

### Copy items (read-through, no special setup)

| ID | Passes if |
|---|---|
| **FT-118** | Diagnostic Data reads **"Should Send Required Only -- GOOD"**. The "Required Only" substring must be intact — it's a locked gate token. |
| **FT-119** | Final screen plainly says GatewayGuard is finished and will close, while still noting scheduled scans run later. Console prompt reads "Press Enter or Space to **close GatewayGuard**...". GUI dialog title says "-- GatewayGuard Closing". |
| **D-17** | BitLocker prep checklist's **item 1** is back up your files, with concrete steps (USB/external via File Explorer, drag-drop or Ctrl+C/V) plus the OneDrive callout — not a generic "back up your files". Old items renumbered 2-6. |
| **D-18** | Manual-steps screen's Malwarebytes item gives real Custom/Deep scan steps, matching the Monthly Reminder popup wording. |

### Carried forward — never reached in ascii33, must be reached now

These are the items the resume-heavy ascii33 run silently skipped. They
are the main reason the fresh-run rule above exists.

- [ ] **SCREEN-26 / SCREEN-27** (Your Security Tools / The Scans) — the D-06 package. Not observed in any of four ascii33 logs.
- [ ] **FT-94** — ConvenienceReview ask-before-apply. Untested in field.
- [ ] **FT-95** — ConvenienceReview copy. Untested in field.
- [ ] **FT-102** — password manager flag on the summary screen. Not captured.
- [ ] **D-15** — overnight scan guidance content, pending your read-through.

---

## HOW TO REFER TO SCREENS IN YOUR NOTES

**There is no screen number shown on screen.** The only visible progress
indicator is "Section -- Step N" (the FT-116 counter), which is a step
counter, not a stable screen ID.

**So: identify screens by their on-screen title text in your notes.**
That is always available and never ambiguous.

Screen numbers *do* exist in the **log** — 11 screens write a
`[SCREEN-nn] Rendered: ...` line, which is how ascii33's four logs were
reconstructed. Use this map when reading logs afterward:

| # | Screen |
|---|---|
| 01 | Welcome / Font Instructions |
| 02 | Scroll and Copy Tip |
| 05 | Personal Computer Check |
| 09 | System Baseline Summary |
| 10 | Before We Scan Your PC |
| 13 | Malwarebytes Guidance (Custom Scan rewrite) |
| 13 | Malwarebytes Guidance (not detected) — **duplicate number** |
| 23 | Convenience Choices (ask-before-apply) |
| 25 | Welcome Back (Resume Prompt) |
| 26 | Your Security Tools (briefing 1 of 2) |
| 27 | The Scans We Recommend (briefing 2 of 2) |

**Two known gaps** (candidates for ascii35, not blockers for this run):

1. Numbering is sparse — 03, 04, 06-08, 11, 12, 14-22, 24 are unnumbered
   entirely. Those screens leave no `[SCREEN-nn]` trace in the log, so a
   run through them can't be reconstructed the way ascii33's was.
2. **SCREEN-13 is assigned to two different screens** (Malwarebytes
   Guidance, Custom-Scan-rewrite vs. not-detected variants). That number
   is ambiguous in any log.

---

## WHAT TO CAPTURE

Match the ascii33 format so results drop straight into a TestHistory doc:

1. **Every log file** — one per run segment, with start/end times.
2. **Numbered field notes** as you go ("note 12", "note 17"). The ascii33
   analysis leaned on these heavily; unnumbered observations were the
   ones that got lost (see open question 1 below).
3. **For each run:** start time, end time, path taken, exit type
   (CLEAN with footer / ABNORMAL).
4. **Machine + MB state** at time of run.

---

## OPEN QUESTIONS FOR BILL

Carried from ascii33, still unanswered:

1. Note 12 said "there were 1 mis-statements Will rerun" — which
   mis-statement? Never captured anywhere else.
2. Note 20: program appeared to restart showing the last 3 screens. Real
   re-launch, or just scroll-back? You flagged you were tired — confirm
   or drop it.
3. HP DHCP/network issue — **has a planned fix**: USB WiFi adapter
   arriving 2026-07-26. Whether that resolves the underlying DHCP
   problem or just routes around it is still unknown — if the adapter
   works, the original DHCP fault on the built-in NIC remains
   undiagnosed and should keep its own troubleshooting session.

**New, found while writing this plan:**

4. **D-16 (Edge check), D-19 (website purchase rule), and D-21 (double
   HEADS UP) do not appear anywhere in ascii34.** The ascii33 doc listed
   all three as "decisions needed before build." They appear to have been
   passed over during the ascii34 build. D-21 especially will show up in
   this field run — HEADS UP still appears twice (review stage, then
   final), which ascii33 noted "reads as a bug to the user." Decide
   whether that's in scope before or after this test.

---

## KNOWN NOT-VERIFIABLE THIS RUN

- **FT-110 recovery-key backup to Microsoft account** can only be
  confirmed after you actually sign in with an MS account and the OS
  arms Device Encryption on its own schedule — that may not complete
  during the test session. Verify the *screen guidance* now; verify the
  *key actually landing* at account.microsoft.com/devices/recoverykey as
  a follow-up.
- **FT-105 IsTamperProtected** was not verifiable on HP in ascii33.
  Expect the same unless FT-115's Win32_DeviceGuard fix incidentally
  helps.

---

## AFTER THE RUN

1. Results become `GatewayGuard_TestHistory-ascii34-<date>.md`, same
   cumulative-master format as the ascii33 doc.
2. Only then does ascii35 scoping open (UNRUN BUILD RULE).

### ASCII35 CANDIDATES (running list -- carry into the ascii34 test history)

| Item | Description | Source |
|---|---|---|
| **Screen numbering** — **LAUNCH REQUIREMENT, decided 2026-07-27** | **Bill, 2026-07-27: this must be present in the last pre-run build and in the final release. It is allowed to slip past interim field-test builds (ascii36 shipped without it, scoped to FT-120b only), but it cannot be dropped.** The reason is *user support*, not field-test reconstruction — a user on the phone must be able to say which screen they are stuck on. That makes it product scope, not a testing convenience. Schedule it as its own build, not bolted onto one shortly before a field run: it touches every screen render in a 6,100-line file. Settle two design questions with Bill first — fixed ID per screen vs. position in flow, and where it renders given FT-117's already-tight layout. The log-side half (b and c below) is additive `Write-Log` lines with no layout risk and can go first. Full scope: show a stable screen ID to the user on every screen, so screens can be referred to by number in field notes and support calls. Three parts: **(a)** display the ID on screen — today nothing is visible but the "Section -- Step N" step counter, which is not a stable ID; **(b)** fill the gaps — only 11 screens emit `[SCREEN-nn]` to the log; 03, 04, 06-08, 11, 12, 14-22, 24 are unnumbered and leave no log trace, so runs through them can't be reconstructed; **(c)** fix the duplicate — SCREEN-13 is assigned to two different Malwarebytes Guidance screens, making that number ambiguous in any log. | Bill, 2026-07-25. Originally ascii33 note 1 ("No screen numbering"), which was filed as FT-116 but resolved only as step-counter *visibility* — the underlying request for referable screen IDs was never addressed. |
| **Lint pass** | 40 `PSAvoidUsingEmptyCatchBlock` + 18 `PSAvoidUsingWMICmdlet`. ascii34's header documents these as knowingly deferred and **not** individually reviewed against Class 1 of the Defect Prevention Playbook — so each empty catch needs a case-by-case judgment, not a blanket rewrite. Must go through the assert-guarded Python wrapper (`CLAUDE.md` line 41) in small batches with a parse check after each; a bulk raw-PowerShell replace is what corrupted this file on 2026-07-25. | ascii34 header, lines 16-26 |
| **D-16 / D-19 / D-21** | Edge check, website purchase rule, and double HEADS UP. All three were listed in the ascii33 doc as "decisions needed before build" and appear nowhere in ascii34. D-21 is user-visible — HEADS UP still renders twice. | ascii33 test history, line 165 |

Anything the field run turns up gets added to this table before ascii35
scoping.

### FT-120 -- WAKE ON LAN REPORTS A FALSE "GOOD" (found 2026-07-26, BLOCKER)

**Severity: blocker.** A security-critical item reports GOOD when it is
actually ENABLED. Worse than a false alarm -- the user is told they are
safe when they are not. Class 1 (invisible failure), FT-37 pattern.

**Field-verified on Dell Latitude 5430, Win 11 Pro, 2026-07-26:**

| Adapter | Setting | Actual | Tool says |
|---|---|---|---|
| Ethernet | Wake on Magic Packet | **Enabled** | "DISABLED -- GOOD" |
| Ethernet | Wake on Pattern Match | **Enabled** | not checked |
| Ethernet | Wake from S0ix on Magic Packet | **Enabled** | not checked |
| Wi-Fi | Wake on Pattern Match | **Enabled** | not checked |

**Three compounding causes**, all in the `# 3. Wake on LAN` block:

1. `Get-NetAdapterPowerManagement` throws CimException on all four
   adapters on this hardware. With `-EA SilentlyContinue`, `$wol` is
   null, the `if` never fires, and `$wolEnabled` stays `$false` -- so a
   FAILED CHECK falls through to "DISABLED -- GOOD". There is no
   distinction between "checked and clean" and "could not check".
   This is exactly Class 1 rule 3: a swallowed error on a code path that
   changes program behaviour.
2. The adapter list is filtered to `Status -eq "Up"`. This Dell's
   Ethernet is Disconnected, so the one adapter with WoL enabled is
   skipped entirely. A desktop with an unplugged cable, or a laptop on
   Wi-Fi, hides its own Ethernet WoL setting.
3. Only `WakeOnMagicPacket` is examined. `Wake on Pattern Match` and
   `Wake from S0ix on Magic Packet` are never read, and both are
   Enabled here.

**Working detection method on this hardware:**
`Get-NetAdapterAdvancedProperty` returns all of these cleanly (Ethernet
exposes 39 advanced properties, Wi-Fi 23). This is also what the user
sees in the GUI on machines with no Power Management tab.

**Fix requirements:**
- Never report GOOD from a check that failed. "Unknown" already exists as
  a status for exactly this -- use it, and surface it to the user.
- Enumerate physical adapters regardless of Up/Down status.
- Read Magic Packet, Pattern Match, and S0ix variants, not just one.
- Prefer `Get-NetAdapterAdvancedProperty`; keep PowerManagement as a
  fallback, not the primary.

**Knock-on:** the wake-on-lan website page currently instructs users to
use the **Power Management tab**, which does not exist on this hardware.
The page must cover the Advanced-settings route as well. Same for any
guide section written from the same assumption.

---

### FOR THE NEXT NOTES UPDATE (not build items)

| Item | Detail |
|---|---|
| **Keyboard arrow tip for users** | `Ctrl + Left/Right` moves the cursor a whole word per press instead of one character; `Home`/`End` jump to start/end of line; adding `Shift` selects while moving. Relevant to GatewayGuard users because the Mark-mode copy tip already tells them to "use Shift+arrows to select" -- `Ctrl+Shift+Left/Right` selects a word at a time and makes copying a long status line far less tedious. Separately, Windows' arrow-repeat behaviour is tunable at `control keyboard` (Repeat delay / Repeat rate) if holding a key overshoots. Source: Bill, 2026-07-26. **Destination: next ProjectNotes update, and content for tips.html when built.** If it is ever added to the tool's copy tip, note that CLAUDE.md locks that wording verbatim across three locations -- all three change together. |
