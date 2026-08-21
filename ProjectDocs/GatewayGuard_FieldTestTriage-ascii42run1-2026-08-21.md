<!-- Dated: 2026-08-21 10:20 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii42 Field Test -- Run 1 Triage

- **Document Name:** GatewayGuard_FieldTestTriage-ascii42run1
- **Last Modified:** 2026-08-21 10:20 ET
- **Last Editor:** Claude Code (CGDELL)
- **Build:** ascii42 -- `Tool\W11-SecurityHardening-v3-ascii42-2026-08-19-1830.ps1`
- **Machine:** SANDY (HP 17-by1955cl, Win 11 Home, local account `panther`,
  both drives unencrypted, conhost not Windows Terminal)
- **Source:** `Test_Results\Ascii42-test-results-2026-08-21-.odt`, Bill's
  notes taken at the keyboard during the run
- **Run status:** **INCOMPLETE.** The run stopped at the checklist
  (shown as screen 25) and did not reach the review, encryption or
  scheduling screens. Everything from shown-screen 27 onward is untested
  in this run.
- **Encryption:** NOT run. Held for ascii43 by decision on 2026-08-21.
  SANDY remains the only unencrypted machine in the fleet.

**Run log not yet available.** The tool writes to
`<user folder>\GatewayGuard\Logs\`, which on SANDY is the personal OneDrive
folder. As of 10:20 ET that folder holds 14 logs and **none dated
2026-08-21** -- SANDY has not synced. Harvest it when it arrives; several
findings below can be confirmed or refuted from it.

---

## HOW TO READ THE BASIS LABELS

Per CLAUDE.md, every claim carries how it was established.

| Label | Means |
|---|---|
| **field** | Bill observed it on SANDY. The field wins. |
| **source** | Located in the ascii42 source, file and line given |
| **field, unlocated** | Reported, not yet found in the source. Not a doubt about the report -- a gap in my analysis |

---

## A. THE CHECKLIST -- WHERE THE RUN STOPPED

### FT-204 -- `N` on the checklist silently discards every selection

**Basis: field + source, line 8368.**

```
"N" { $Settings | ForEach-Object { $_.Selected = $false } }
```

No confirmation, no undo, instant, and it clears **both pages**. The legend
presents it as an ordinary command beside `A = Select all`:

```
A = Select all             N = Deselect all    Q = Quit
```

**Why this is more than a stray keypress.** Everywhere else in Checkup `N`
is the safe answer -- no, skip, go back, do not change my system, across
roughly 40 prompts. On this one screen it destroys everything Checkup
computed. That fails the User-Facing Clarity Rule on its own test: a user
cannot predict what the key does, because it means the opposite of what it
means everywhere else.

**This has been reported before and was not fixed.** The FT-125 comment ten
lines above the handler quotes field note 14 from 2026-07-27 verbatim:
*"selected N to turn off all selections and screen flickered ... then
displayed screen showing R had been selected and when i hit space bar pgm
crashed."* The response then was to add **logging** to the checklist reader.
The key itself was never guarded. FT-124 also removed Enter-as-Yes in ascii37
partly to explain field note 10, *"somehow all selections were removed while
I was typing notes"* -- which may have been this key all along, meaning that
fix addressed the wrong mechanism.

**Fix for ascii43:** move the command to `C = Clear all selections`, and
confirm before wiping. It is the only command on that screen that destroys
work and the only one with no confirmation -- `Q` has one.

### FT-205 -- once nothing is selected, the only ways on are re-select or quit

**Basis: field + source, line 8373.**

```
"R" {
    $selectedCount = ($Settings | Where-Object { $_.Selected }).Count
    if ($selectedCount -eq 0) {
        "  Nothing is selected, so there is nothing to run."
        "  Type an item number to select that item, or A to select all."
```

Bill's words: *"it forces me to run something."* Accurate. After FT-204
wipes the list, `R` refuses to advance, so the choices are to rebuild the
selections by hand or `Q` out of the tool. **There is no path through the
checklist that changes nothing.**

**Open product decision, Bill's call:** should a "look through everything and
change nothing" path exist? My recommendation is **no** -- the checklist with
its statuses *is* the review, `Q` is the no-change exit, and
`Show-AllScreens.bat` covers walkthroughs. Adding a branch means new screens
in a build already carrying ~20 open findings 11 days from launch. Recorded
as a decision, not actioned.

### FT-206 -- the `I` key does nothing on shown-screens 25 and 26

**Basis: field + source.** `Show-CheckupInfo` has exactly **two** call
sites -- line 2551 inside `Pause-ForUser`, line 2667 inside `Read-ValidKey`.
The checklist uses its own hand-rolled reader, because it must accept
two-digit item numbers, and that reader handles **only Ctrl+C** (lines 8287
and 8312). So FT-189's promise that `I` works from any prompt is not true of
the checklist.

The promise is made on screen. `Read-ValidKey` line 2675 prints *"Press I at
any time to see your build and Machine ID."* **"At any time" is wrong**, and
the two screens where it fails are the busiest in the tool.

### FT-207 -- no prompt in the build says an exit exists

**Basis: source.** Ctrl+C opens the exit confirmation from every question
(`Read-ValidKey` line 2648) and the checklist has `Q` (line 8370). **Measured:
44 of the 47 `Read-ValidKey` prompts list neither `Q` nor `B` in their key
list.**

That figure needs care and is deliberately not being reported as "44 dead
ends" -- most of the 44 are Y/N questions where `N` *is* the exit ("N =
Exit", "N = Go back"), and Ctrl+C works at all 47 because it is caught before
the valid-key check. The defect is that **nothing on screen ever says so.**
When a key is not accepted, the message names the valid keys and offers `I`,
and never mentions Ctrl+C.

**Fix for ascii43:** add the exit line to the unrecognised-key message in
`Read-ValidKey`. One edit, covers all 47 prompts, and does not require
bolting a Back onto questions that correctly have none.

---

## B. SCREENS WITH NO NUMBER -- AND THE GATE THAT CANNOT SEE THEM

### FT-208 -- at least two screens the user meets carry no screen number

**Basis: field + source.** Bill logged two:

- *"Checking power-related -- no scr #"*
- *"Your settings -- step 6 -- no Scr # no back allowed"*

**The mechanism, and it matters more than the two screens.** Gate 12
(`Check-ScreenCoverage`) audits **`Draw-Box` calls** and verifies each carries
a `-ScreenId`. Measured: in the whole power block, lines 4928-5372, there is
**exactly one** `Draw-Box` call -- line 5054, `ScreenId "50"`.
`Apply-PowerSettings` (5175-5372) paints its output with bare `Write-Host`.

**So a screen assembled from bare `Write-Host` is invisible to gate 12.**
"70 screen IDs, all unique, gate 12 PASS" is not the same statement as "every
screen the user meets has a number", and ascii42 shipped believing it was.
The checklist is already documented as the one screen that bypasses
`Draw-Box`; it is not the only one.

**This is the class, not the instance.** Before ascii43, the count of
user-visible screens needs establishing by a method that does not assume
`Draw-Box`. I have not done that audit and am not guessing at the number.

---

## C. NAVIGATION -- BACK

### FT-209 -- shown-screen 14a traps the user with only Y or N

**Basis: field.** *"hit space bar few times ended up on 14a -- won't go back.
Pre-scan recommended. Only press Y or N to exit."* Shown-as 14a is
`SCREEN-39`, the repeat-run pre-scan reminder. Reached by pressing Space
through preceding screens, with no way back to what he had been reading.

### FT-210 -- the power "Your settings" screen offers no Back

**Basis: field.** Same screen as FT-208's second half. It ends with the
standard *"Press Enter or Space to continue... Or press B to look back"*
line, and Bill records **no back allowed** at the point he needed it.
**field, unlocated** -- I have not yet separated "B was not offered" from "B
was offered and did nothing", and the run log will settle it.

### FT-211 -- shown-screen 22 back behaviour is inconsistent

**Basis: field.** *"Scr 22 -- no going back. Selected Y and hit B and it went
back."* So `B` worked, but only after answering. Before answering it did not.
Consistent with the known class **Back works on pages, not at questions**,
carried over unfixed from the ascii41 run.

### FT-212 -- shown-screen 11 repeated, and the two `N` answers behaved differently

**Basis: field.** *"Scr 11 -- repeated, shown twice. Responded N, showed time,
went back. Responded N again, did not show time again and it moved on."*
Shown-as 11a/11b are `SCREEN-36`/`SCREEN-37`, the time and date check. The
same key produced two different outcomes on what the user reads as the same
screen. **field, unlocated.**

---

## D. THE SCREEN GALLERY -- `Show-AllScreens.bat`

Two separate launches, consistent between them.

### FT-213 -- `Ctrl+A` does nothing

**Basis: field.** Both runs.

### FT-214 -- `B` is dead until an unrelated key is pressed

**Basis: field, both runs.** *"B did not work ... tried j and it seemed to
work. After that B worked."* And on the restart: *"B and mouse wheel did
nothing ... Tried j it worked and B key started working."*

**Reproduced twice with the same trigger key**, which makes this the most
diagnosable finding in the run. A reader that ignores input until some other
key wakes it is the same family as FT-171's input-gate work.

### FT-215 -- mouse wheel scrolls one direction, then stops entirely

**Basis: field, both runs.** *"mouse wheel scroll forward and back, only went
forward ... Could no longer scroll with mouse wheel."* On the second run the
wheel did nothing at all from the start.

**This is expected to interact with the FT-171a change.** Briefing section 2
records that ascii42 clears `ENABLE_MOUSE_INPUT`, and the 21:08 log confirms
it fires: *"QuickEdit AND mouse input reporting disabled for this session
(FT-01, FT-171a)."* Whether wheel scrolling of the **window** should survive
that is the open question -- section 2 argues it should, because the wheel
belongs to the console host and the build never reads a mouse event.
**The field says it does not survive.** That contradiction has to be resolved
before ascii43, and the field wins.

### FT-216 -- arrows, Page Up/Down and `Q` all work

**Basis: field, both runs.** Recorded so the working set is not re-tested.

---

## E. ALREADY KNOWN, RECONFIRMED

### The gallery start-up freeze -- evidence recovered

The briefing's open item 1 calls
`GatewayGuard-Log-2026-08-19_21-08.txt` uncollected and unreadable from
CGDELL. **It is readable.** It sits in the personal OneDrive log folder and
Checkup diagnosed its own freeze:

```
[21:09:00] [WARN] FT-63: startup was delayed 1 minute(s) between launch
           and initialization -- console was likely frozen in
           text-selection (Mark) mode; Esc releases it
[21:09:00] [START] SCREEN GALLERY opened (review mode -- no checks run)
[21:41:41] [EXIT] SCREEN GALLERY closed
```

**Esc is the release.** The open item can be closed as diagnosed; what
remains is preventing the console from entering Mark mode at launch.

### Shown-screen 24 reports sleep active

**Basis: field.** *"Scr 24 -- says sleep active."* Recorded; no action
determined. **field, unlocated.**

---

## F. WHERE THE LOGS ACTUALLY LIVE

**Checkup writes its log outside the repository**, to
`<user folder>\GatewayGuard\Logs\`. On both machines that resolves to the
**personal** OneDrive, not the `OneDrive - GatewayGuard LLC` folder that
holds the repo. The logs replicate to CGDELL by themselves and are readable
there -- but git has never seen them, so **Cloud has never seen them.**

That is the mechanism behind the recurring "field logs arrive untracked"
failure recorded in briefing section 8a. As of 10:20 ET that folder holds 14
logs: 4 ascii41 (SANDY) and 10 ascii42 (7 CGDELL, 3 SANDY).

**Harvesting them into `Test_Results\` should be mechanical, not
remembered.** A guard nobody runs is a wish.

---

## G. WHAT ascii43 SHOULD CARRY, IN ORDER

1. **FT-204** -- move deselect-all off `N`, and confirm before wiping.
   Smallest edit, largest protection, twice-reported.
2. **FT-207** -- say the exit exists in the unrecognised-key message.
   One edit, all 47 prompts.
3. **FT-206** -- make `I` work on the checklist, or stop promising "at any
   time" on screens where it does not.
4. **FT-214 / FT-215** -- the gallery reader. Reproduced twice with a known
   trigger key, and FT-215 contradicts the briefing's mouse-flag reasoning,
   which has to be settled either way.
5. **FT-208** -- establish the real count of user-visible screens by a method
   that does not assume `Draw-Box`, then number the ones that have no number.
6. The carried block from ascii41 -- FT-203, and the ~20 wording and
   screen-splitting findings.

**Then field-run ascii43 on SANDY, and run the encryption path on that
build.** SANDY's unencrypted state is spent once and should be spent on the
build closest to launch.

**Next free FT number after this run: 217.**
