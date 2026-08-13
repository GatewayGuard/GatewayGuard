<!-- Dated: 2026-08-13 09:44 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# GatewayGuard Field Test Plan -- ascii40

- **Document Name:** GatewayGuard_FieldTestPlan
- **Last Modified:** 2026-08-13 09:44 ET
- **Last Editor:** Claude Code (CGDELL)
- **Status:** Cumulative. Supersedes `-ascii39-2026-08-02-0919.md`.
- **Source:** the 47 findings in
  `Test_Results\Ascii39-Test-Results-2026-08-11-2237.txt`, the eight SANDY run
  logs of 2026-08-11/12, and the ascii39 source.

**Change History Log:**
- 2026-08-13 09:44: Created from the ascii39 field run. Carries the root-cause
  finding for the two reported crashes, the triage of all 47 findings into
  FT-171 to FT-182, and the ascii40 build scope those imply.

---

## THE HEADLINE -- CHECKUP DID NOT CRASH, AND THAT MATTERS MORE THAN IF IT HAD

Findings 14, 15 and 39 report the program crashing or disappearing. **The logs
show no crash.** In every case Checkup ended through its own code path, having
accepted an input event nobody meant to send.

`GatewayGuard-Log-2026-08-11_17-46.txt`, in full, at the moment of the second
"crash":

```
[17:50:08] [KEY] Discarded 256 keypress(es) that were already queued ... (FT-149)
[17:50:08] [SCREEN] [SCREEN-31] (shown as screen 2) Rendered: QUICK RE-CHECK BEFORE RESUMING
[17:50:08] [KEY] Key 'N' accepted at: Show-ResumeReverify
[17:50:08] [KEY] Discarded 256 keypress(es) that were already queued ... (FT-149)
[17:50:08] [EXIT] Resume re-check: user said not personal PC -- exit
```

Three log lines inside the same second: a screen appeared, an `N` was
"accepted", and Checkup exited because `N` on that screen means *this is not my
personal PC*. **Bill did not press N.** A queued event was read as his answer.

### Why the queue exists, and why the drain does not empty it

`Clear-PendingKeys` (line 2487):

```powershell
while ($Host.UI.RawUI.KeyAvailable -and $ggDrained -lt 256 -and $ggSw.ElapsedMilliseconds -lt 200) {
```

**256 is the loop's own ceiling, not a count of anything.** The log line then
reports it as one: *"Discarded 256 keypress(es) that were already queued"*.
Eleven times in this run the drain hit its cap and stopped **with events still
queued** -- and the next read consumed one.

A log that reports a cap as a measurement is the same defect class as FT-162,
where `[GOOD] Scheduled task created` printed for months over a command that
had never run. *(Recorded as a rule below.)*

### Where the events come from -- measured

`Disable-QuickEdit` (line 2318) clears QuickEdit and nothing else:

```
# Clear ENABLE_QUICK_EDIT_MODE (64), keep ENABLE_EXTENDED_FLAGS (128).
# 4294967231 = all bits set except bit 6 (QuickEdit).
```

**measured 2026-08-13 on CGDELL**, applying that exact mask to the standard
console input modes:

| console mode | after `-band 4294967231` | QuickEdit | **ENABLE_MOUSE_INPUT** |
|---|---|---|---|
| `0x01F7` (the Windows default) | `0x01B7` | off | **ON -- survives** |
| `0x03F7` | `0x03B7` | off | **ON -- survives** |
| `0x00F7` | `0x00B7` | off | **ON -- survives** |
| `0x01E7` | `0x01A7` | off | off |

**`ENABLE_MOUSE_INPUT` (0x0010) is untouched by the mask.** With it set, every
mouse move, click and wheel tick over the window becomes an `INPUT_RECORD` in
the same 256-record buffer keypresses use.

**This is why right-click "crashed" it.** Right-click is not a key. It is a
burst of mouse records into a buffer the tool then reads as answers.

**And it is why the mouse wheel scrolls so well** -- finding 5a, which asks
that the wireless mouse be recommended everywhere. *The feature Bill wants to
promote and the defect that ended his run twice are the same console flag.*
That is the single most important thing on this page.

**Basis:** the mask arithmetic is **measured**. That mouse events specifically
filled SANDY's buffer is **inferred** -- strongly, from eleven cap-hits, two
right-click endings and zero crash records. `Tool\Run-ConsoleInputModeCheck.bat`
settles it, and **must be run on SANDY before ascii40 is built**, because
CGDELL did not fail.

### It also explains finding 30, which read as unexplainable

*"about 20 openings of Checkup sitting on the welcome page"* and LibreOffice
gaining 20-30 junk pages. `GatewayGuard-Log-2026-08-11_22-10.txt` records
**about 25 `SESSION ENDED EARLY -- the window's X was clicked` events between
22:11:27 and 22:12:16** -- roughly one every two seconds -- alongside
`Not running as Administrator -- instructions shown, tool closed`.

Input was being delivered to windows nobody was aiming at. Same root cause,
different symptom, and it corrupted a document Bill was writing in.

---

## TRIAGE -- ALL 47 FINDINGS

Next free FT number was **171**. Next free screen ID is **83** (gate 12 PASS,
65 numbered screens, 10 carried oversize).

| FT | Findings | What it is | ascii40? |
|---|---|---|---|
| **FT-171** | 14, 15, 18, 19, 30, 39, 44, 45 | **Input queue accepted as answers.** Root cause above | **YES -- blocker** |
| **FT-172** | 3, 4, 6, 7, 9, 12, 35, 37 | **Screen numbering is wrong and duplicated.** Bill's screen-number table | **YES -- blocker** |
| **FT-173** | 10, 23, 33 | **Back unavailable at prompts.** Breaks a standing CLAUDE.md rule | **YES -- blocker** |
| **FT-174** | 5a, 5b, 5c, 5d, 5e, 6 | **Upfront consent for console setup** -- font, window, mouse | **YES** |
| **FT-175** | 38, 43 | **Defender offline scan never ran.** This is FT-162 confirmed in the field | **YES -- blocker** |
| **FT-176** | 17, 20, 21, 22, 27 | **Resume does not know what the previous run did** | **YES** |
| **FT-177** | 28, 32, 46 | **Screens too long.** Feeds the 26-line ratchet | **YES** |
| **FT-178** | 13 | **Second drive invisible.** FT-167 confirmed on screen | **YES** |
| **FT-179** | 12, 40, 41, 42, 46 | **Copy defects** -- date/time check, can/may, step-by-step | **YES** |
| **FT-180** | 24 | **Guide links, and whether the reader bought the guide** | **Scope decision -- Bill** |
| **FT-181** | 25, 29, 31, 46 | **Malwarebytes flow** -- scan starts itself, cannot cancel | **Partial** |
| **FT-182** | 34, 36 | **Screen timeout and sleep during encryption** | **YES** |
| -- | 1, 2, 8, 11, 16, 26, 47 | Observations, or absorbed above | -- |
| -- | 48, 49 | Blank in the source file | -- |

---

## THE THREE BLOCKERS, IN BUILD ORDER

### FT-171 -- fix the input path FIRST

Nothing else can be tested reliably until this is fixed, because any test can
be ended by a stray event and the tester will write it up as a crash. **It
already cost this project a whole field run's confidence.**

1. **Clear `ENABLE_MOUSE_INPUT` as well as QuickEdit**, unless the wheel is
   wanted -- see the open question. Mask becomes `-band 4294967231 -band
   4294967279` (clears bits 6 and 4).
2. **Drain by flushing the buffer, not by counting reads.** `FlushConsoleInputBuffer`
   empties it in one call and cannot hit a cap.
3. **Never report a cap as a count.** If a bounded loop stops at its ceiling,
   log *"drain stopped at cap -- events may remain"*. A number that cannot
   exceed its own limit is not a measurement.
4. **No single keystroke may end the session.** `Show-ResumeReverify` exits on
   a bare `N`. Exits require confirmation -- CLAUDE.md already says "no
   accidental exits without confirmation" and this screen breaks it.
5. **Timestamp-gate the answer.** Reject any key whose arrival predates the
   screen's render. That fixes the class, not just this screen.

### FT-172 -- the screen number table (Bill's finding 35)

Bill: *"Goal is to always have only one screen with a given screen number...
Discuss how you will approach this with me."*

**Recommended approach, for Bill's approval:**

The build already has the right half. Every screen carries a stable ID
(`[SCREEN-31]`) and gate 12 mechanically proves IDs are unique -- it passed
today, 65 screens, next free 83. What has no owner is the **shown-as** number,
which is written by hand at each call site and has drifted: findings 3, 4, 6, 7
and 9 are all "screen N says it is M".

**Do not renumber anything by hand.** Add a single ordered table --
`$script:GGScreenOrder` -- mapping stable ID to position, built once at
startup. `Write-GGBox` looks up its own position from the table rather than
being told. A screen physically cannot then display a number that disagrees
with the table, and inserting a screen renumbers every later one automatically.

Then extend gate 12 to fail the build if any call site passes a literal
position number. **That is what makes it stay fixed** -- FT-162's lesson is
that a rule with no check is a wish.

This keeps the two-number design CLAUDE.md already requires: stable ID in the
log, position on screen.

### FT-175 -- the offline scan that has never run

Finding 38: *"Defender offline scan run was missing."* Finding 43: *"no results
for task scheduler. Why?"*

**This is FT-162, observed in the field for the first time.** `MpCmdRun.exe
-Scan -ScanType 4` does not exist; it returns `0x80070667` in 0.0 seconds while
the log prints `[GOOD] Scheduled task created`. The correct call,
`Start-MpWDOScan`, is already in the same file.

Gate 24 exists to catch exactly this and **passes today**, because the defect
was fixed in the gate's own terms but the scan path was never re-tested end to
end. **Add to the plan: prove the task exists in Task Scheduler after the run,
not that the code claims it does.**

---

## RESEARCH ANSWERED BEFORE PLANNING -- so no phase rests on a guess

**Finding 36 -- "Says Sleep Active. Is it really? Will it be a problem when
encrypting. Research this."**

**sourced**, Microsoft BitLocker FAQ, *What happens if the computer is turned
off during encryption or decryption?*:

> "If the computer is turned off or goes into hibernation, the BitLocker
> encryption and decryption process will resume where it stopped the next time
> Windows starts. BitLocker resuming encryption or decryption is true even if
> the power is suddenly unavailable."

So sleep **cannot corrupt** the drive -- answer Bill's safety question with a
plain no. But it **stalls progress**, and SANDY has Modern Standby, so the
estimate on the BitLocker screen will be wrong and the user will think it hung.

The same FAQ notes encryption *"occurs in the background while a user continues
to work"* -- so the screen should not imply the machine must be left alone.

**ascii40:** keep the machine awake for the duration of encryption (the tool
already has sleep prevention -- the logs show it activating and deactivating
correctly), and say on screen that closing the lid pauses rather than breaks
it. Source: <https://learn.microsoft.com/en-us/windows/security/operating-system-security/data-protection/bitlocker/faq>

**Finding 37 -- "setting 6 still says 3 phishing. No longer exists in Edge."**

**Partly a misreading, and the plan must not act on it yet.** The three phishing
toggles are **Windows** settings -- Windows Security > App & browser control >
Reputation-based protection > Phishing protection -- not Edge settings. Setting
6 is looking in the right place.

**measured on CGDELL 2026-08-13:** all three registry locations that would hold
a configured state are **absent** --
`HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WebThreatDefense`, its
`\Policies` subkey, and `HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components`.
Absent means unconfigured, i.e. at Windows' own default. Windows 11 Pro build
26200.

**Do not "fix" this in ascii40 on the strength of the note.** What Bill saw on
SANDY's screen has not been established, and this project has a written rule
about absent-equals-default breaking on the second machine. **Phase 1 captures
the screen and the registry on SANDY; the decision follows the measurement.**

**Finding 12 -- "Is there a free app, maybe grammarly or word that can check
all of these kind of things before we publish?"**

**The better answer is one you already own.** Grammarly and Word check grammar;
they cannot check *"whether"*, *"switch"* as a verb, *"GatewayGuard Checkup"*
more than once per page, unverified superlatives, or missing permission
language -- and those are the rules that actually get broken here.

Today's sweep of 19 pages found 18 breaches in about a second using a
30-line matcher. **Recommend `Tool\Run-CopyCheck.bat`** on the pattern of gate
24 and the coverage checker: fails on banned words, superlatives, the Checkup
name rule and missing permission language, across `.ps1` screen text, `.html`
and `.md` together. That closes the drift RULE W-07 exists to prevent, and it
runs on the tool and the website in one pass -- which no external product can
do. Cheap, and it makes rule 12 mechanical instead of aspirational.

---

## THE PLAN

Phases 1 and 2 run **before** ascii40 is built. They settle the two questions
the build depends on.

### PHASE 0 -- SANDY, 3 minutes, READ-ONLY, BEFORE ANY BUILD WORK

1. Double-click `Tool\Run-ConsoleInputModeCheck.bat`. **Move the mouse over
   the window while it samples.**
2. Result goes to `Test_Results\ConsoleInputMode-SANDY-*.txt`.

**Reading it:** pending events climbing while only the mouse moves confirms
FT-171's mechanism. `ENABLE_MOUSE_INPUT: YES` after the mask confirms the
source. If mouse input is already off, FT-171 is real but the source is
something else -- key auto-repeat next -- and the fix in step 1 changes.

**Run it on SANDY.** CGDELL did not fail, so measuring CGDELL proves nothing.

### PHASE 1 -- SANDY, 5 minutes, READ-ONLY -- settle finding 37

1. Open Windows Security > App & browser control > Reputation-based protection.
2. **Photograph the Phishing protection section.** How many toggles, what each
   is called, what each reads.
3. Note anything Checkup's setting 6 names that is not on screen.

That is the evidence. Nothing about setting 6 changes until it exists.

### PHASE 2 -- BUILD ascii40

Blockers first: FT-171, then FT-172, then FT-175. Nothing else is worth
testing until those three are in.

Standing gates before it is presented: Playbook Appendix A, CodingStandards
session-end checklist, `Run-ScreenCoverageCheck.bat` (gate 12 and 12b),
`Run-ExternalCommandCheck.bat` (gate 24), and CLAUDE.md's five build-ID
locations. **The assert-guarded Python wrapper must exist and be committed
before any `.ps1` edit** -- there are still zero `.py` files in the tree or in
its history, measured this morning.

### PHASE 3 -- SANDY, about 45 minutes -- the run FT-171 makes possible

Every step below was untestable in ascii39 because the session kept ending.

1. **Provoke it deliberately.** At three separate prompts, right-click the
   window, move the mouse across it, spin the wheel. **Checkup must not
   advance, must not answer, must not exit.**
2. **Type into another window** while Checkup sits at a prompt -- this is
   finding 39 exactly. Checkup must be unmoved when focus returns.
3. **Back at every prompt** (FT-173). Try Back on every screen reached.
   Record any screen that refuses.
4. **Screen numbers** (FT-172). Write down the number each screen shows.
   No number may appear twice; the sequence must not skip.
5. **The second drive** (FT-178). SANDY has `C:` and a 931.5 GB `D:`, both
   decrypted. The encryption screen must name both.
6. **Defender offline scan** (FT-175). It must be offered. After the run,
   open Task Scheduler and confirm the GatewayGuard task exists and has a
   next-run time. **The log saying it was created is not evidence.**
7. **Resume** (FT-176). Quit mid-run, relaunch, resume. Checkup must know what
   the previous run completed and offer the next thing, not just
   continue-or-exit.

**Do not start encryption.** SANDY's unencrypted state is the fleet's only
copy and is spent the moment it converts.

### PHASE 4 -- encryption, one way, only when Bill decides

Unchanged from the ascii39 plan, plus:

- The screen states that sleep **pauses** encryption and does not damage it
  (finding 36, sourced above).
- Timing estimate comes from **67.7 GB used**, not the 237.3 GB volume --
  predicted mode is used-space-only.
- FT-168 free-space wipe test on `D:` after conversion, as previously planned.

---

## WHAT IS NOT BEING TESTED, AND WHY

- **Anything on CGDELL that needs the unencrypted path.** CGDELL is fully
  encrypted; sending an item-8 test there proves nothing.
- **Malwarebytes' own behaviour** (FT-181). Findings 25, 29 and 31 describe MB
  starting its own scan and refusing cancellation. That is MB's UI, not
  Checkup's, and Checkup cannot fix it. What ascii40 *can* do is stop promising
  the user something MB will not honour -- a copy change, not a code one.
- **Finding 24's guide-purchase detection.** Needs a product decision first.

---

## KNOWN-OPEN GOING IN -- do not re-report as new

- Ten screens exceed 26 lines and sit in the gate-12b baseline (72, 50, 73, 26,
  27, 65, 60, 41, 30, 52). Findings 28, 32 and 46 name three more; splitting
  them removes entries from the baseline, which may only ever get shorter.
- Three user-facing strings still say "whether" -- the convenience-review line
  and two Device Encryption screens.
- **The tool's own screens carry an unverified superlative:** *"the single most
  common scam used against home computer users today"*
  (`GatewayGuard_ScreenContents` line 933). The website's copy of that claim was
  corrected and sourced to the FTC on 2026-08-13; **the build still says the old
  thing**, so the two now disagree until ascii40 lands.

---

## QUESTIONS FOR BILL -- held, as asked

1. **The mouse wheel, or the input fix?** Clearing `ENABLE_MOUSE_INPUT` is the
   clean fix for FT-171 and it **turns off wheel scrolling**, which finding 5a
   asks to promote everywhere. The alternative is to keep mouse input and drain
   properly with `FlushConsoleInputBuffer` plus the timestamp gate -- more code,
   keeps the wheel. **My recommendation: keep the wheel, fix the drain.** The
   wheel is a real accessibility win for seniors and the drain has to be fixed
   regardless.
2. **Finding 35's table** -- approve the `$script:GGScreenOrder` approach above
   before it is built.
3. **Finding 24** -- how should Checkup know if the reader bought the guide?
   That is a product and sales decision.
4. **Finding 34** -- offer the user a choice of screen timeout, or set one?
5. **`Run-CopyCheck.bat`** -- worth building now, or after launch?
