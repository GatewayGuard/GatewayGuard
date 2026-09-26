<!-- Dated: 2026-09-26 08:51 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# CLAUDE.md -- the ascii44 "Current build" history, moved out verbatim

- **Moved 2026-09-26** by the /doctor cleanup Bill approved ("Clean up everything").
- **Source:** `CLAUDE.md` lines 15-615 as of commit `cd7395f`. Nothing below was edited.
- **Why:** CLAUDE.md loads into every session; this block cost ~10k tokens each time, and
  every item is also in the session log, the build's `# FT-` comments, or the ascii45 plan.
- **Restore:** paste this block back over the short "Current build" bullet in CLAUDE.md,
  or run `git show cd7395f:CLAUDE.md`.

---

- **Current build:** ascii44 (9,458 non-blank lines / 9,847 total) — **BLOCK A COMPLETE, NOT YET FIELD RUN.**
  - **ascii43 is SPENT and retired to `Builds\`.** It was field run twice,
    2026-08-26 to 08-30, five logs in `Test_Results\FieldRun-ascii43\`.
    `Tool\` holds only ascii44. F1, F2, F3, F5 and part of F6 came from it.
  - **In ascii44 so far:** FT-242, the nine registry writes that could not
    fail. Eight were the audited set; the ninth was in `Apply-PowerSettings`,
    a second apply path for setting 18 outside the range the triage checked.
    **FT-203**, the two reminders that could never fire on a laptop on
    battery -- `Set-GGTaskSettings` now fixes the three settings after the
    task is created and logs what it reads back. Measured on CGDELL
    2026-09-06: `Test_Results\TaskSettings-CGDELL-2026-09-06_12-20.txt`.
    **The Back key**: five sites where `N` actually navigated backward are
    now `B`, including screen 27's "Ready to proceed?", the one Bill hit.
    **FT-244**, screen 32 drawn and wiped in the same second, and screen 34
    painted on top of the one before it. **FT-243**, the required log notice
    moved off the decline-only screen and onto the review screen the rule
    names.
    **FT-255**, five `powercfg` parses that could never populate `$Matches`
    -- on an array `-match` is a filter and sets nothing, so the `if` passed
    and the next line read a stale or null `$Matches`. **FT-245**, the
    silent-error breadcrumb named where the user was, not where the fault
    was.
    **Screen 12**, the SSD is now Drive 1.
    **FT-257**, the SmartScreen status check reported **"ON -- GOOD" from a
    value that was not there**. The test was `$ss -ne "Off"`, and an absent
    `SmartScreenEnabled` is `$null`, which is not `"Off"` -- so a machine
    that had never had the setting written was told it was on and fine.
    ***Measured on CGDELL 2026-09-07: the value was absent while Windows
    Security was posting a warning asking for reputation checking to be
    turned on.*** Bill was looking at that warning when he asked why it
    disagreed with what I had read him. `-EA SilentlyContinue` made it
    worse -- a **refused** read also landed as `$null`, so blocked and
    absent both reported GOOD. **A wrong GOOD is the worst kind here: it
    deselects the item, so the user is never offered the fix.** Now
    `-EA Stop` with a typed catch, and five distinct answers. **Raised, not
    fixed:** a Group Policy `EnableSmartScreen` of 0 forces SmartScreen off
    whatever the value says -- the same class of wrong GOOD. Not set on
    CGDELL, and "off by policy" needs a decision about what Checkup should
    then offer, so it belongs with the F6 wording block.
    **FT-258**, and this is the answer to the line above — Bill, 2026-09-07:
    *"add the policy check to checkup."* `Get-GGPolicyLock` reports when a
    Group Policy is **forcing** a setting, so Checkup says so instead of
    offering a fix that cannot work. **A value under
    `HKLM\SOFTWARE\Policies` beats the switch in Windows Security**, so the
    user clicks and nothing happens, and concludes they did it wrong.
    **Every key was read out of Windows' own policy definitions in
    `C:\Windows\PolicyDefinitions\*.admx`** — the ADMX declares the exact
    key, value name, and the numbers meaning enabled and disabled — and all
    five were then re-verified against those files mechanically. **Never
    remembered, never inferred.** **Three settings, each for a measured
    reason:** item 4 SmartScreen, where the verdict is *wrong* without it
    because the check reads the **user's** value and the policy lives
    elsewhere; items 2 and 7, where the verdict is already right because
    both read the **effective** state, so the policy is added only as the
    *reason* and never flips a GOOD. **Items 12–15 are deliberately
    excluded: Checkup sets those through policy keys itself**, so a check
    would report our own work as an outside override. One insertion point,
    not three — the pass runs before the auto-deselect, so an ON-by-policy
    GOOD is deselected by the existing loop. ***Measured: with no policy
    set, the pass changes nothing at all***, which is the common case.
    **FT-258b, the correction Bill caught the same hour:** *"I thought there
    were 3 and now you mentioned four."* He was right — **I double-counted
    one profile under two names.** ***Measured: `Get-NetFirewallProfile`
    returns three — Domain, Private, Public — while the firewall's own live
    store names them `DomainProfile`, `StandardProfile`, `PublicProfile`.
    StandardProfile IS Private***, the name it carried on Windows XP. So
    "Domain and Standard" already covered Domain **and** Private, and only
    **Public** was missing. All three are now wired and ***measured
    identical to the live store***.
    **The lesson, and it is the one worth keeping: the source I verified
    against was real but not complete, and I reported its silence as proof
    of absence.** ***Measured: "PublicProfile" appears in no `.admx` on this
    machine, and the two firewall policies that are declared carry
    `supportedOn = SUPPORTED_WindowsXPSP2`*** — an XP-era template, and XP
    had only two profiles. Modern firewall policy comes through the Advanced
    Security snap-in, not that ADMX. **One command against a second source —
    the firewall's own store — settled it.** Public is also the profile that
    matters most to the customer: it is the one that applies on hotel and
    coffee-shop wifi.
    **FT-256, FIXED 2026-09-08 — Bill: "fix ft-256". THE MIRROR OF
    FT-257, AND IT WAS REPRODUCING ON THIS MACHINE WHILE WE DISCUSSED IT.**
    Two sites parsed `powercfg /query ... CONSOLELOCK` for a setting index
    and, when the parse found nothing, **fell through to the ELSE branch and
    reported "NOT required"** — a verdict invented from silence.
    ***Measured on CGDELL 2026-09-08 21:29, elevated: the query returns
    `Power Scheme GUID: ... (Balanced)` and NO setting index line at all***,
    so the shipped build was telling this machine its password-on-wake was
    not set when nothing had been read.
    **FT-257 was the same fault pointing the other way** — an absent value
    became a wrong GOOD, which **deselects** the item. Here it is a wrong
    BAD, which is the safer direction because it offers a fix that may be
    unneeded rather than hiding one that is needed. **It is still a verdict
    from a read that did not happen.**
    **FIX: one shared reader, `Get-GGConsoleLockState`, replacing two private
    copies of a two-outcome parse.** Four answers — REQUIRED /
    NOT_REQUIRED / NO_INDEX / NO_OUTPUT — and it carries the raw output so
    the log says WHY. **The unknown deliberately keeps the item SELECTED**,
    because auto-deselect keys on "GOOD": a reading we could not take is not
    a reason to hide a fix that is harmless and idempotent.
    ***Verified against the SHIPPED function extracted from the build
    itself: live run returns NO_INDEX with the header as its raw output, and
    all four states map to the right words at both call sites.*** Width
    checked too — the new power-screen string is 31 characters against the
    34 already on that line, so the box cannot widen (FT-117/FT-122).
    Gates after: 12, 12b, 24 PASS, parse 0 errors, 0 non-ASCII, 87 functions
    and no duplicates. Wrapper:
    `Tool2uild_ascii44_ft256_consolelock.py`.
  - **FT-261, FIXED 2026-09-17 — Bill: "don't let checkup run without
    administrative rights." THE RESUME PATH STILL OFFERED THE LIMITED MODE
    THAT FT-25 HAD ALREADY REMOVED FROM THE FRESH-RUN PATH, 2026-07-11.**
    ***Measured: on a fresh run, `Show-FontInstructions` already gates on
    `$global:IsAdmin` and exits with relaunch instructions if not admin —
    FT-25's own comment says why: "running without admin meant settings
    silently could not apply."*** But `Show-FontInstructions` is skipped
    entirely on resume (`if (-not $global:ResumeFrom)`), and the resume
    path's own admin check, `Test-AdminAccess`, still asked **"Continue in
    Limited Mode? (Y = Continue / N = Exit)"** — the exact behavior FT-25
    had already decided was wrong, left in place one call site over.
    ***Measured: 15 of the 18 settings carry `RequiresAdmin=$true`***, so
    Limited Mode could run at most 3 of them; it was barely functional even
    on the day it was still offered. **The box also told the user they
    could still "Run Defender and Malwarebytes scans" — Malwarebytes has
    been out of Checkup entirely since 2026-09-08**, so the box was
    describing a feature that no longer exists, on top of offering a mode
    that should not exist.
    **FIX: `Test-AdminAccess`'s non-admin branch now matches
    `Show-FontInstructions` exactly — show the same relaunch instructions,
    then exit. No Y/N, no Limited Mode, no Malwarebytes line.** One user
    experience, one decision, enforced at both entry points instead of one.
    Gates after: 12, 12b, 24 PASS, parse 0 errors, 0 non-ASCII, 88 functions
    and no duplicates. Wrapper:
    `Tool2\build_ascii44_ft261_adminrequired.py`.
  - **FT-262, FIXED 2026-09-17 — SETTING 6 HAS A FOURTH CHECKBOX CHECKUP HAS
    NEVER TOUCHED, AND EVERY CUSTOMER-FACING SURFACE EITHER SAID TO TURN IT
    ON OR SAID NOTHING AT ALL — INCLUDING THE BUILD ITSELF. Bill, looking at
    his own screen: "the one about phishing. We don't want all 4 on, do we?
    only 3 of the 4 right?"**
    **THIS WAS NOT A NEW FINDING, AND THE FIRST WRITE OF THIS ENTRY SAID SO
    BY OMISSION — Cloud caught it on review.** The same four boxes, the same
    fourth-box wording, the same three-warnings-are-correct conclusion, and
    an exact drafted replacement for the build's own manual-steps line were
    **already measured and written up on 2026-08-26**:
    `GatewayGuard_FieldResult-PhishingProtection-2026-08-26-1130.md`,
    itself following a recommendation against turning the fourth box on in
    `GatewayGuard_DecisionsForBill-2026-08-24-1033.md` item 5. **Bill had
    already turned all four boxes on once before, on SANDY, on 2026-08-26 —
    this is the second time the same interface confusion produced the same
    result.** The 08-26 write-up sat as a live, correctly-dated row in
    `CURRENT.md` for three weeks. Nothing routed a setting-6 change through
    it, so it was re-derived from scratch instead of read. See the process
    fix below.
    ***Measured against `WebThreatDefense.admx`: Enhanced Phishing Protection
    is five policies — a master switch, three warnings (`NotifyMalicious`,
    `NotifyPasswordReuse`, `NotifyUnsafeApp`), and `AutomaticDataCollection`
    (registry name `CaptureThreatWindow`), which sends Microsoft a copy of
    on-screen content when something is flagged.*** **Checkup's item 6 has
    only ever set the three warnings — the fourth was never part of the
    setting, on any surface, at any point.**
    ***Confirmed again against Bill's screenshot 92, 2026-09-17: the live
    screen shows exactly four checkboxes under Phishing protection, all four
    checked, and the fourth is `AutomaticDataCollection` by its own
    wording.*** **Could not confirm this by reading the registry** — already
    measured 2026-09-07 (see `SettingsLocationList`, section 2): Tamper
    Protection refuses all four of these reads and writes, so the screen is
    the only truth for this group. Had to ask Bill to look and send the
    screenshot rather than guess which four he meant.
    **What was wrong, surface by surface, and all four are now fixed:** the
    guide said *"Recommended: All Options Enabled"* and *"Enable all
    available phishing protection warnings"*; the website said *"toggle each
    item that is off to On"* under the Phishing protection heading —
    independently arrived at, same defect; and **the build's own manual-steps
    screen, shown when the registry write is refused, said "turn ON all 3
    options" while showing the user four** — this is the line the 08-26
    document drafted a replacement for and it was never applied, surviving
    unchanged from ascii43 into ascii44. None of the four ever named the
    fourth checkbox, so a reader had no way to know they were being asked to
    turn on something Checkup itself does not set.
    **FIX: all four surfaces now name the three warnings by their literal
    on-screen labels, name the fourth by its literal label, and say plainly
    to leave it unchecked and why** (it shares more of the screen with
    Microsoft than the three warnings need to work). Guide:
    `GatewayGuard_CoPilotGuidePart2-2026-09-16-1627.md`, Setting 6. Website:
    `WebSite\html\phishing-protection.html`, "How to change it yourself."
    Build: the manual-steps block in `Apply-Setting`, case 6 — wording is the
    08-26 draft, applied verbatim. Gates after: 12, 12b, 24 PASS, parse 0
    errors, 0 non-ASCII, 88 functions, no duplicates. Wrapper:
    `Tool2\build_ascii44_ft262_phishingwording.py`.
    **THE DOCUMENTATION LESSON, separate from the setting itself:**
    `GatewayGuard_SettingsLocationList-2026-09-08-2130.md` had already
    measured all four registry writes failing on 2026-09-07, and its own
    prose said *"all four writes returned..."* — **but its table had only
    ever listed three rows.** The measurement was right the whole time; the
    table just never surfaced the fourth row where a reader would see it.
    Same shape as the ascii44 line-count mismatch and the Guide Part 3
    numbering bug: two places in the same document set carrying two
    different answers, neither one flagged as disagreeing with the other.
    Fourth row added to the table.
    **THE PROCESS FIX Cloud asked for:** a correct, dated, field-measured
    finding sat unread in `ProjectDocs\` for three weeks because nothing
    pointed a future editor of that setting back to it.
    `SettingsLocationList` now carries a "Field results" column naming the
    dated write-up beside any setting that has one — see the table update
    below. **Before changing what any setting's guide, website, or build
    text says, check that column first.**
    **08-26's OTHER recommendation, `CanAuto=$false` for setting 6, was
    checked and NOT applied — see FT-263.** It would have silenced the exact
    fix above.
  - **FT-263, FIXED 2026-09-17 — `CanAuto=$false` DID NOT MEAN
    "SHOW MANUAL STEPS." IT MEANT "NEVER REACH THE CODE THAT WOULD."**
    Found while checking whether `GatewayGuard_FieldResult-PhishingProtection-
    2026-08-26-1130.md`'s recommendation to set setting 6's `CanAuto=$false`
    was safe to apply (FT-262). It was not, and tracing why found a second,
    older, larger defect.
    ***Measured: `Apply-Setting` (line 6673) checks `if (-not
    $Setting.CanAuto) { return "Manual action required -- see Guide:
    $($Setting.GuideRef)" }` BEFORE `switch ($Setting.ID)` is ever reached —
    the same function, one early return away from the per-setting cases.***
    ***Measured: `.CanAuto` is never reassigned anywhere in the file after
    the settings array declares it*** — so for any setting with
    `CanAuto=$false`, the switch case with that ID's number can never
    execute, for any caller, under any state. This is not a runtime
    condition to test; it is a fact about the control flow, true by
    construction.
    **Two settings already carry `CanAuto=$false`, and both have a rich,
    specific `switch` case that this makes permanently unreachable:**
    **ID=3, Tamper Protection** — four branches keyed on Malwarebytes state
    (Free / Trial / third-party AV / none), each with different, correct,
    specific instructions. ***Measured: every path through `Apply-Setting`
    for ID=3 returns the same generic string, "Manual action required --
    see Guide: Phase 1, Step 2", before any of those four branches can run.***
    **ID=9, Windows Hello** — checks whether a PIN or biometric is already
    configured (`Test-Path ...\NGC`) and returns one of two different
    messages. ***Measured: unreachable the same way — the generic message
    fires first, so the NGC check has never run inside `Apply-Setting`.***
    **Checked: the dead case's content is NOT duplicated anywhere the user
    does reach.** ***Measured: `Get-AllStatuses` case 3 (line 6133), which
    does run and does populate what the checklist shows, produces only "OFF
    -- turn on in Windows Security (see guide)" or, during a Malwarebytes
    trial, "OFF during Malwarebytes trial -- recheck after trial ends" —
    neither the specific Windows Security path, nor the third-party-AV name,
    nor the trial-ending options `Apply-Setting`'s dead case 3 would have
    given.*** ***Measured: the Guide's own Setting 3 (Tamper Protection) text
    is generic too — "Open Windows Security. Select Virus & threat
    protection. Select Manage Settings. Turn Tamper Protection on." — no
    mention of Malwarebytes or a trial at all.*** **So this is not a wasted-
    code problem. The specific guidance exists nowhere the user can see it,
    on the one setting Bill just said every home user should have on.**
    **THE PRACTICAL CONSEQUENCE THAT MADE THIS WORTH FIXING NOW, NOT
    LATER:** setting 3, Tamper Protection, is the one setting Bill just said
    every home user should have on, unconditionally, no exceptions. Its
    specific, correct, already-written instructions had never once reached
    a user — the highest-severity setting this class of bug could have
    picked.
    **THE FIX: exempt only IDs 3 and 9 from the early return, since neither
    writes anything.** ***Measured: neither case calls `Set-ItemProperty`,
    `Set-Service`, `New-Item`, or `Remove-Item` — both only read state
    (`Get-MalwarebytesState`, `Get-WmiObject ... AntiVirusProduct`,
    `Test-Path ...\NGC`) and build a message string.*** So letting them
    reach the switch carries none of the risk a real write would. Any other
    setting that ever gets `CanAuto=$false` in the future still exits at the
    generic message and never reaches a case that might write — the guard
    is narrowed, not removed.
    ```
    if (-not $Setting.CanAuto -and $Setting.ID -notin 3,9) {
        Write-Log ...
        return "Manual action required -- see Guide: $($Setting.GuideRef)"
    }
    ```
    ***Verified against the SHIPPED function, extracted from the build by
    its own AST and called directly*** (mirroring the FT-256 verification
    method): with `CanAuto=$false`, `ID=3` now returns *"MANUAL ACTION
    REQUIRED: Windows Security -> Virus & threat protection -> Virus &
    threat protection settings -> Tamper Protection -> On. (Malwarebytes
    Free does not affect this setting.)"* — the specific instruction, not
    the generic one. ***The same live call also confirmed
    `Get-MalwarebytesState` detects Malwarebytes on CGDELL right now***, by
    its documented FT-140 fallback path. `ID=9` now returns the specific
    *"NOT CONFIGURED -- Manual setup: Settings -> Accounts -> Sign-in
    options..."* message. A third, synthetic `ID=99` (standing in for any
    future `CanAuto=false` setting) still returns the generic fallback
    message unchanged, confirming the safety net holds for every ID except
    the two proven safe.
    Gates after: 12, 12b, 24 PASS, parse 0 errors (one transient "1 error"
    reading did not reproduce on a clean re-run, matching the same false
    reading seen once already this session under FT-262 — noted, not
    chased further, since `gg_edit.py`'s own write-time check and two
    independent re-checks all read 0), 0 non-ASCII, 88 functions, no
    duplicates. Wrapper: `Tool2\build_ascii44_ft263_canautofix.py`.
  - **FT-264, FIXED 2026-09-17 — TWO Tool2 UTILITY SCRIPTS HAVE BEEN UNABLE
    TO FIND THE BUILD SINCE THE 2026-08-22 Tool/Tool2 SPLIT, AND SAID SO AS
    "THE BUILD DOES NOT PARSE."** Found while building a screen-by-screen
    field checklist for Bill and running `Run-ScreenInventory.bat`.
    ***Measured: `Get-ScreenInventory-2026-08-15.ps1` and
    `Test-InputGate-2026-08-15.ps1` both search `$PSScriptRoot` (`Tool2\`)
    for `W11-SecurityHardening-v3-*.ps1` — a pattern that has matched
    nothing since the build moved to `Tool\` on 2026-08-22.*** `Get-ChildItem`
    silently returns nothing, `ParseFile($null, ...)` throws, and the script
    reports "STOP: the build does not parse (1 error(s))" — a true
    statement about a file that was never found, read by an operator as a
    real corruption in the shipped build. ***This is not the same as the
    unrelated transient single-error readings noted under FT-262 and
    FT-263 — those were against the correct path in `Tool\` and did not
    reproduce; this one reproduced 3 of 3 times and had a mechanical
    cause.*** CLAUDE.md's own record of the split names four launchers it
    verified afterward — `Run-GatewayGuard`, `Show-AllScreens`,
    `Run-ScreenCoverageCheck`, `Run-ExternalCommandCheck` — and these two,
    both dated before the split, were not among them.
    **FIX: both now search `..\Tool\` instead of `$PSScriptRoot`.** No
    build change; both are dev-only tools, edited directly (not through
    `gg_edit.py`, which governs `Tool\*.ps1` only). Re-ran
    `Run-ScreenInventory.bat` afterward: 69 `Draw-Box` screens found, 0
    parse errors, output written to
    `Test_Results\ScreenInventory-ascii44-2026-09-06-1214.txt`.
    **Also fixed in passing:** FT-261 and FT-262 were applied without the
    inline `# FT-NNN` code comment every other fix in this file carries —
    added both, no behavior change, so a future screen-to-FT mapping (like
    the one this was found while building) does not miss them.
  - **FT-123b, ITEM 13 CLOSED 2026-09-17 — COPILOT'S KEY NAMES WERE RIGHT,
    THE FILE WAS WRONG. BILL'S FIELD TEST FOUND THE REAL ONE.**
    **Background: item 13 (Edge Startup Boost and Background Running) has
    reported "Unknown -- could not check" whenever its policy has never
    been set, since ascii43** — deliberately, per FT-123 (the fix for a
    worse defect: absence of policy used to be misread as "Enabled -- needs
    attention"). Item 15 (Edge Password Saving) got a real fallback on
    2026-09-16, reading the user's own live setting from Edge's
    `Preferences` file when no policy is set. ***Item 13 and 14 were left on
    "Unknown-only" the same day because Copilot's proposed key names,
    checked against that same file, were not there:*** *"neither
    startup_boost_enabled (item 13) nor a top-level background_mode.enabled
    exists in it."*
    **Bill ran `Tool2\Run-MeasureEffectiveState.bat` today** (Cloud's
    script, built 2026-09-16 for exactly this) and completed Part 1 in
    full: closed Edge, snapshotted its `Preferences` file, flipped Startup
    Boost in `edge://settings/system`, closed Edge, snapshotted again.
    ***Measured: zero lines matching "boost" or "background" changed
    anywhere in the diff.*** That is a real, clean null result, not a dead
    end — checked immediately rather than accepted at face value:
    ***measured directly against `%LOCALAPPDATA%\Microsoft\Edge\User
    Data\Local State` (the file SHARED across all profiles, which the
    script never read): it holds `"startup_boost":{"enabled":false,
    "default_last_launch":true,...}` and `"background_mode":{"enabled":
    true}`.*** Copilot had the right names; the script (and the original
    Copilot guess before it) was looking in the wrong file — per-profile
    `Preferences`, not the shared `Local State`.
    **FIX: `Get-GGEdgeLocalStateBool`, the `Local State` counterpart to
    item 15's `Get-GGEdgeEffectiveBool`.** Item 13's status check now falls
    back to it when the policy is absent, exact same shape as item 15: read
    both `startup_boost.enabled` and `background_mode.enabled`, GOOD only
    if both are found AND both false, "needs attention" if either found
    value is true, Unknown if neither resolves or the read is only half
    complete — never a guess from a partial read.
    **Labelled honestly, not oversold:** *measured* that the keys exist and
    hold real values right now; *inferred, not flip-proven* that `enabled`
    is the specific field the on-screen toggle controls — Bill's toggle
    test was aimed at the wrong file, so no before/after diff exists yet
    for the right one. The inference rests on `enabled` being the
    conventional Chromium name for a feature's own on/off field and the
    only boolean in `background_mode`'s object, not on a proven flip.
    ***Verified against the SHIPPED function, extracted from the build by
    its own AST and called directly against this machine's real file:***
    `startup_boost.enabled` reads `False`, `background_mode.enabled` reads
    `True` — matching the raw JSON read exactly — and a made-up section
    name fails closed (`Found = False`) rather than throwing. The full
    case-13 decision logic was tested against all three shapes a read can
    take (both off, one on, one found and one missing) and returned GOOD,
    needs-attention, and Unknown respectively, each correctly.
    **Item 14 (Widgets) CLOSED THE SAME DAY, ONE RE-RUN LATER — AND THIS
    ONE IS FLIP-PROVEN, NOT JUST FOUND.** Bill's first run stopped at
    "TaskbarDa BEFORE = 1" (Ctrl+C, before the after-read). He re-ran the
    whole script and completed all three parts this time.
    ***Measured on CGDELL 2026-09-17, a real controlled toggle: `TaskbarDa`
    read 1 before, 0 after Widgets was turned off in the taskbar's own UI,
    and 1 again after turning it back on.*** Unlike item 13, this is not an
    inference from a field name — it was watched flip both directions.
    **FIX: the same policy-then-effective-fallback shape as items 13/15**,
    reading `HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\
    Advanced\TaskbarDa` when the `AllowNewsAndInterests` policy is absent.
    No new helper needed — a flat HKCU value, not nested JSON like Edge's
    settings. Apply-Setting's case 14 was already correct and untouched;
    only detection needed the fallback, same as item 13.
    ***Verified live on this machine: TaskbarDa currently reads 1 (Widgets
    back on after Bill's restore step), and the fix correctly reports
    "Enabled -- needs attention" for that value.***
    **FT-123b is now fully closed — items 13, 14 and 15 all have a real,
    measured effective-state fallback. None of it was guessed:** two were
    proven by watching them flip, one (item 13's specific `enabled` field)
    rested on the standard Chromium naming convention rather than a proven
    flip.
    **That last gap closed the same day.** `startup_boost.enabled` was read
    twice an hour apart — `False` at 15:11, `True` at 15:43, with no known
    toggle in between — and flagged as a live value to re-read rather than
    trust. ***Bill then read the real Edge screen directly: "currently edge
    startup boost is on," at the exact moment the key read `True`.*** Not a
    watched flip, but a direct screen-to-registry match at a single point in
    time — the strongest evidence available short of watching it move, and
    enough to call `enabled` confirmed rather than merely inferred.
    Gates after: 12, 12b, 24 PASS, parse 0 errors, 0 non-ASCII, 89
    functions, no duplicates. Wrappers:
    `Tool2\build_ascii44_ft123b_item13.py`,
    `Tool2\build_ascii44_ft123b_item14.py`.
  - **FT-260 — THE PRODUCT QUESTION IS DECIDED 2026-09-16; THE DETECTION GAP
    IS STILL OPEN ON PURPOSE.** Read the decision first, then the finding
    that started it — the heading used to say only "RAISED NOT FIXED," which
    left a reader who stopped there thinking nothing had been resolved.
    **THE DECISION: Smart App Control does NOT become a 20th setting.
    Checkup gains one guide sentence instead.** Bill's question, Copilot's
    independent analysis, and Claude Code's own reasoning all converged on
    the same answer without seeing each other's work first — three separate
    passes, one conclusion. **Reasons, in order of weight:** the settings it
    touches are already forced to the correct state, so there is no security
    gap to close; many machines cannot freely enable it at all (Windows
    installation history gates availability); and detecting it would add a
    20th setting's worth of testing and support burden for zero customer
    benefit, since there is nothing the customer can *do* about it. **The
    guide sentence, wherever it sends a reader to that Windows Security
    screen:** *"If Windows says a setting is managed by Smart App Control,
    that setting is already protected and cannot be changed there — this is
    normal, not a fault."* Filed for the reconciliation pack in
    `GatewayGuard_CoPilotGuideReview-Comments-2026-09-16-1140.md`.
    **THE DETECTION GAP THIS WAS BUILT ON, RAISED 2026-09-08, STILL NOT
    FIXED AND NOT SCHEDULED — Bill's screenshots.**
    Windows Security shows *"This setting is managed by Smart App Control"*
    above **Check apps and files**, with that toggle **greyed out** while
    SmartScreen for Microsoft Edge beside it is live and clickable.
    **Check apps and files is item 4 — a numbered checklist item.**
    ***Measured on CGDELL 2026-09-08: `VerifiedAndReputablePolicyState = 1`,
    Smart App Control On and enforced.***
    **FT-258's `Get-GGPolicyLock` reads only `HKLM\SOFTWARE\Policies`. Smart
    App Control locks from `HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy`,
    and *measured: the ascii44 source carries ZERO occurrences of "Smart App
    Control"*.** So Checkup reports no lock while a control sits greyed out on
    the user's own screen.
    ***The measurement makes the point exactly: on this machine no Group
    Policy is forcing anything — all three policy keys exist and hold no
    values — and the one mechanism that IS forcing a setting is the one the
    check cannot see.*** **This is FT-258b's lesson again, one day later: the
    source I verified against was real but not complete.**
    **DELIBERATELY NOT OVERSTATED: Smart App Control forces both controls ON,
    so no user ever meets one that is off and unclickable. There is no dead
    end here.** The cost is a senior seeing a greyed control and assuming they
    broke it.
    **Also taken over: `Block apps` under Potentially unwanted app blocking**
    — ***measured 2026-08-24***, already recorded in
    `GatewayGuard_Research-Items15and20-2026-08-24-0917.md`, and the ascii44
    plan already asks for one plain sentence about it. **What is new is that
    it reaches a NUMBERED ITEM, so that sentence has to cover both.**
    **THE ARCHITECTURAL LESSON, sharpened per Copilot's read — FT-260 was
    never really about Smart App Control.** It is the first *measured*
    instance of a general shape: **a setting can be forced, locked, or
    overridden by a Windows mechanism that is not Group Policy at all**, so
    a policy-only lock check can report "nothing is forcing this" while the
    user's own screen shows otherwise. `Get-GGPolicyLock` covers the
    mechanism it was built for; it was never meant to cover every mechanism
    that can exist, and the next one will not announce itself either.
    **Deferred, not scheduled:** a general "what else can lock a setting"
    survey, only if a second real instance turns up — chasing hypothetical
    future lock mechanisms now would be exactly the open-ended expansion
    this project's own rules exist to prevent. **Smart App Control is not
    one of the 19/18 and is nowhere in the build; that does not change.**
    Full write-up with every path:
    `ProjectDocs\GatewayGuard_SettingsLocationList-2026-09-08-2130.md`. The
    complete chat history behind this decision, start to finish:
    `ProjectDocs\GatewayGuard_SmartAppControl-ChatHistory-2026-09-16-1403.md`.
  - **Raised in ascii44 and still NOT fixed:** **FT-254** alone
    (`Test-TimeDateSync` prints success after four unguarded calls).
    *(FT-256 was on this line until 2026-09-08 and is now fixed — see
    the entry above.)*
  - **FT-259, RAISED NOT FIXED — Bill's call, 2026-09-07: "build the height
    check later." CHECKUP NEVER ASKS HOW TALL THE USER'S WINDOW IS.**
    ***Measured on the ascii44 source: `WindowWidth`/`BufferSize.Width` is
    read at 5 sites — that is FT-217 — while `WindowSize.Height` appears
    exactly once, inside `Save-ScreenSnapshot`, where it bounds a capture
    and has nothing to do with whether a screen fits.***
    **The 26-line rule assumes a window tall enough to show 26 lines, and
    nothing checks that assumption.** ***Measured on CGDELL 2026-09-07: the
    terminal was 81 columns by **21 rows**, because Windows was at 150%
    zoom and the terminal font was 20 — the two multiply.*** At 21 rows a
    26-line screen loses its top 5 lines before the user sees them, and
    SCREEN-72 at 55 lines loses 34. **The user reads the bottom of a
    screen, sees the prompt, and answers a question whose top scrolled away
    unseen.** It is a Class 1 invisible failure: nothing errors, nothing is
    logged, and the user cannot tell it happened.
    **THE PEOPLE MOST LIKELY TO HAVE A SHORT WINDOW ARE EXACTLY OUR
    CUSTOMERS** — a senior who set a large font because they cannot see
    well gets fewer rows for that reason.
    **BILL SET THE REQUIREMENT, 2026-09-07, and it replaces the two-level
    plan I had proposed:** *"The final fix has to be one key that resets
    the screen to what works best on their pc terminal windows settings."*
    **ONE KEY. The user presses it and the screen is right.** They are not
    told to resize anything, not given instructions, and not asked to
    understand anything.
    **That requirement forces the whole design — it cannot be met by a
    startup warning.** To be correct after one keypress the key must, at
    the moment it is pressed: **re-measure BOTH width and height** (not
    the values from draw time), **redraw the current screen from its own
    text** — which is why the words must be stored and not a photograph —
    and **page it if it is taller than the window**, or the redraw still
    scrolls the top away and the key has not delivered what it promised.
    **It must work at EVERY prompt**, so it belongs in the three shared
    readers, ***measured: `Pause-ForUser` 78 sites, `Read-ValidKey` 60,
    `Read-NavKey` 7***.
    **THE KEY CANNOT BE `R`.** ***Measured: `R` is already taken at three
    prompts*** — `@("R","S")` resume-or-start-over at line 3909, `@("E","R")`
    exit-confirm at 4444, and `@("R","A","C","Q","P")` at 8704. A key that
    means one thing in most places and another in three is FT-236 again,
    which is the defect Bill's own rule *"N always means no and B should
    always be used to say back"* exists to kill. ***Measured: `F`, `D` and
    `L` appear in no key comparison anywhere in the build.*** **`F` is the
    recommendation, labelled `F = Fix the screen`** — it says to a
    non-technical reader exactly what it does, which is the test in the
    User-Facing Clarity Rule.
  - **THE MOUSE SETTING FIXES — BUILT, PARTLY MEASURED, AND SEQUENCED.**
    **Bill, 2026-09-07:** *"I still want to do further testing on [these]
    before checkup launch, but after website fully built and guide in final
    draft form."* **So: not now. After the website and the guide, before
    launch.** This entry exists because the work was in `Tool2\` and
    `Test_Results\` and **nowhere in this file** — Bill had to ask whether
    it had been recorded, which is the definition of a pointer that does
    not exist.
    **What they are for, and it is not comfort — it is FT-63.**
    ***Measured on CGDELL 2026-08-19: `MouseWheelRouting` was 0***, meaning
    the wheel scrolls only the **active** window, so the user must **click**
    the console before they can scroll it — **and clicking a console window
    starts a text selection, which is FT-63, the selection that freezes
    Checkup on its next write.** Setting it to 2 scrolls whatever is under
    the pointer with no click at all. ***Measured the same day:
    `DoubleClickSpeed` was 200 ms against Windows' default of 500.*** At
    200 a missed double-click becomes **two single clicks**, which in a
    console starts a selection and then extends it. **These are two direct
    contributors to Bill's own field findings 15, 24 and 32 —** *"the same
    question repeated multiple times"*, *"crazy things started
    happening... 20+ command screens"*, *"Mouse goes crazy again"*.
    **What exists, measured:** five scripts and seven launchers in `Tool2\`
    — `Set-MouseForCheckup-2026-08-19.ps1`, `Set-DragThreshold-*`,
    `Set-TouchpadDrag-*`, `Test-MouseSettings-*`, and revert launchers for
    each. Settings touched: `MouseWheelRouting`, `DoubleClickSpeed`,
    `DragHeight`/`DragWidth`, `ClickLock`, `SnapToDefaultButton`. **All
    per-user (HKCU), no administrator, no self-elevation**, undo file
    written before anything changes, and `MouseSettings-UNDO-CGDELL.txt`
    and `-SANDY.txt` both already exist.
    **CORRECTED 2026-09-10 — my own first write of this entry claimed
    2026-09-10 was the first time the 200-pixel value was field tested.
    That was wrong, and the session log I should have checked first
    already had the answer: Bill confirmed 200 working on the mouse the
    same night the fix was built, 2026-09-04 — "working on the mouse,
    but not on the laptop flat below keyboard mouse." That second half
    of the sentence is why the touchpad has its OWN separate fix below;
    the touchpad drags through its own tap-twice-and-hold gesture and
    never consults this threshold at all, so no number here could ever
    have fixed it.**
    **WHAT 2026-09-10 ACTUALLY ESTABLISHED, narrower than first
    claimed:** the setting had been sitting at 200 untouched for six
    days with no further testing recorded, so today re-confirmed it
    survives a mouse swap (wireless to wired) and a reboot. ***Reset to
    30, the documented shipped value, confirmed stored AND live
    (SystemParametersInfo re-read), then tested: "not only does it move
    easily, it grabbed something and moved it before I could stop
    it."*** **30 failed.** Set back to 200, same test: ***"It doesn't
    move until I reach 5 cm... the moving image does not show until I
    pass the 5 cm."*** **200 held**, consistent with 09-04.
    **The documented shipped default of 30 is field-disproven — twice
    now, six days apart — and 200 is field-confirmed twice.** Left at
    200, live and stored. Full record:
    `Test_Results\DragThreshold-FieldTest-CGDELL-2026-09-10_15-50.txt`
    (corrected in place, not reissued, so the mistake stays visible
    rather than quietly vanishing).
    **NOT ESTABLISHED, and not to be assumed either way:** whether 30
    failed because this specific wired mouse turns the same hand
    movement into more on-screen pixels than the wireless one did, or
    because 8mm is simply too small a distance for any mouse to
    reliably separate a twitch from an intended drag once Windows'
    pointer acceleration is in play. Telling these apart needs the same
    test repeated with the wireless mouse reconnected — not done.
  - **ALSO RAISED, same session: BACK REPLAYS A PHOTOGRAPH, NOT THE WORDS.**
    ***Measured: `Save-ScreenSnapshot` stores `GetBufferContents` cells plus
    the buffer width; `Restore-ScreenSnapshot` returns `$false` the moment
    `$Snapshot.Width -ne $ggUI.BufferSize.Width`***, and the user gets
    *"this screen could not be redrawn exactly."* **So resizing the window
    breaks Back.** Storing each screen's **text lines** beside the picture
    would let Checkup redraw at any width, would make Back survive a
    resize, and would allow a redraw key for a screen that has gone stale.
    ***Measured scope: 72 screens, 67 of them already drawn through one
    shared routine that has the text in its hands; 5 are hand-drawn (IDs
    76, 77, 85, 86, 87).*** One central change plus five small ones.
  - **Needs one look on SANDY:** screen 12's drive order. CGDELL has a
    single disk, so multi-drive ordering could not be observed here.
  - **Plan:** `ProjectDocs\GatewayGuard_ascii44BuildPlan-2026-09-05-1130.md`.
    Blocks A and B need no decision from Bill; C and D do.
  - **THE NEXT BUILD IS ascii44. THE REMAINING WORK IS NOT "FINISHING ascii43".**
    Bill, 2026-09-05: *"hope you mean ascii44."* He was right, and this line
    was why: it said **"IN PROGRESS, not finished and never field run"** while
    ***measured:*** `Test_Results\FieldRun-ascii43\` holds **five run logs**,
    2026-08-26 18:07 through 2026-08-30 11:04, triaged in two documents. It
    was field run twice. The line was wrong on the very sentence that tells
    you to confirm the build number, so it misled the reader it existed to
    protect.
  - **Still to build, and it lands in ascii44:** F4 (second drive), the F5
    remnants, and the F6 wording block. Plus FT-220, already recorded as
    ascii44. **A build that has been field run is spent** — Build Naming Rules
    below: never reuse a build number, and same-day superseding builds still
    increment. New work means a new number, always.
