<!-- Dated: 2026-08-19 11:00 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii41 -- Field Test Run 1 triage, all 38 findings

- **Document Name:** GatewayGuard_FieldTestTriage-ascii41run1
- **Last Modified:** 2026-08-19 11:00 ET
- **Build under test:** ascii41 (`W11-SecurityHardening-v3-ascii41-2026-08-17-2246.ps1`)
- **Machine:** SANDY. Windows 11 Home, local account, two drives, personal OneDrive present.
- **Sources:** `Test_Results\Ascii41-Test-Reults-2026-08-18-1110.txt` (38 findings)
  and four logs in `C:\Users\willi\OneDrive\GatewayGuard\Logs\`.

---

## THE MEASUREMENT THAT MATTERS MOST

**253 screen renders across four runs. ZERO first-encounter decreases.**

That is the property the whole FT-172 walk existed to guarantee, and it holds
in the field. Every run:

| Run | First-encounter order | Decreases |
|---|---|---|
| 11:04 | `3a` | none |
| 11:06 | `1a 4 5 6 7 8 9 10 11 12 13 14 14a 16` | **none** |
| 14:11 | `1a 1b 10 11 14b 17 18 18c 19 20 21` | **none** |
| 16:18 | `1a 1b 10 11 21 22 23 24 25 26 27 28 29 30 30b 31` | **none** |

**Bill reported numbering "screwed up", "went backwards" and "out of order"
five times (findings 18, 20, 21, 24, 26). The numbers never went backwards.**
That gap between what is true and what the user experienced is FT-195 below,
and it is a real defect -- just not the one it looked like.

---

## WHAT WORKED

| Checklist item | Result |
|---|---|
| **#8 both drives** | **WORKS.** Bill's finding 34: *"both drives showed up correctly"* |
| **#12 log location** | **WORKS.** `C:\Users\willi\OneDrive\GatewayGuard\Logs\`, with `Open-My-Log.bat` beside it. Log line 3 confirms: *"Log location: ... (OneDrive -- already set up on this PC)"* |
| **#7 unrecognised key** | **WORKS.** Finding 38 quotes it firing verbatim: *"That key does nothing here. Please press Y or N or B."* |
| **#11 recovery-key screen** | Reached and read; no complaint about the removed FT-144 text |
| **Windows Security path** | Finding 19: *"Win security path worked perfectly"* |

---

## NEW DEFECTS

### FT-193 -- DIAGNOSED 2026-08-19. The checklist is the one screen the FT-171 fix cannot reach.

**My prime suspect was wrong.** I named the `I` key, on the reasoning that
`Read-ValidKey` now reacts to characters it used to discard. **That is not it.
Nothing I changed in ascii41 causes this.**

### The evidence

**measured**, `Logs-Sandy-ascii41\GatewayGuard-Log-2026-08-18_16-18.txt`:

```
[17:35:15] Checklist render: page 1 ...      <- no key
[17:35:15] Checklist render: page 1 ...      <- no key
[17:35:15] Checklist render: page 1 ...      <- no key
   ... 10 renders inside one second, ZERO [KEY] lines ...
```

Against the normal case ninety minutes earlier, where **every** render is
preceded by an accepted key:

```
[17:03:18] [KEY] Checklist command 'P' accepted
[17:03:18] Checklist render: page 1
[17:03:20] [KEY] Checklist command 'P' accepted
[17:03:20] Checklist render: page 2
```

**Accepted keys peak at 2 per second across the whole run.** So the burst is
not input being accepted. It is the loop re-rendering on input it discards.

### The mechanism, in four measured steps

1. **The checklist is hand-drawn.** SCREEN-76 and 77 are the only screens that
   do not go through `Draw-Box` -- gate 12 has always reported them as
   "hand-drawn (no Draw-Box)".
2. **`Reset-GGInputGate` is called from exactly one place: line 2159, inside
   `Draw-Box`.** So it never runs on the checklist. `Disable-QuickEdit`, which
   clears `ENABLE_MOUSE_INPUT`, has three call sites and **none is in the
   checklist loop** -- measured, zero occurrences between lines 7980 and 8200.
3. **An unmatched key is discarded and the loop repaints.** Line 8202:
   `$userInput = ""  # Invalid -- swallow silently`. No log line, full
   `Clear-Host` and redraw.
4. **So any event that reaches `ReadKey` and is not a command repaints the
   entire screen, silently.** Ten mouse events a second is ten repaints a
   second, which is what the log shows and what Bill saw.

### The one link that is INFERRED, not measured

**That Mark mode restores the console mode.** Bill used right-click and Mark
repeatedly in this run -- findings 8, 9, 17 and 24 -- and entering or leaving
Mark mode is the documented way console mode gets reset by the host. That
would re-enable `ENABLE_MOUSE_INPUT` behind Checkup's back.

**This is measurable and should be, before the fix is written.**
`Tool\Check-ConsoleInputMode-2026-08-13.ps1` already exists and reads the
mode. Run it on SANDY, use Mark mode, run it again. **If bit 4 comes back, the
chain is closed end to end.**

### Why FT-171f did not cover this

FT-171f's stated claim is *"console flags asserted before EVERY screen"*, and
it was implemented by putting `Reset-GGInputGate` inside `Draw-Box` --
deliberately, so that "no new screen can forget it". **That reasoning is sound
and it has exactly one hole: the two screens that do not use `Draw-Box`.**
They are the checklist. Which is the screen the user spends most of the run on,
and the screen field note 14's crash happened on.

**A central fix protects everything routed through the centre.** The checklist
was never routed through it, and nothing checked that.

### The fix

1. **Call `Reset-GGInputGate` at the top of the checklist loop.** One line, and
   it closes the gap FT-171f left.
2. **Stop swallowing silently.** Line 8202 is FT-173's defect in a second
   reader -- an unrecognised key produces no message and a full repaint. It
   should log, and it should not repaint.
3. **Do not repaint on an unmatched key at all.** The repaint is what turns one
   stray event into visible chaos.
4. **Gate it:** a check that every screen-painting path asserts the input gate.
   The rule existed; nothing verified it.

### FT-194 -- the `I` key is dead on 71 of 127 screens. Mine.

**Findings 29, 30, 31, 33.** *"'I' continues to do nothing on scrs 23-24"*,
*"All keys as in 24 flash screen and do nothing."*

**measured:** `Pause-ForUser` accepts `VirtualKeyCode -in @(13,32)` only. No
`I`. I added the key to `Read-ValidKey` -- **56 sites, all of them questions**
-- and not to `Pause-ForUser`, which is **71 sites and nearly every page.**

**This is the exact mirror of the Back defect I had spent that morning
analysing:** Back works on pages and not questions; `I` works on questions and
not pages. I put the new key in the reader with the fewest screens, the day
after writing up why that distinction mattered.

Bill's finding 33 is the consequence: *"your number 5-7 not active due to 'I'
not working"* -- three checklist items could not be tested at all.

### FT-195 -- the numbering is right and reads as broken

**Findings 2, 11, 18, 20, 21, 24, 26.** Two distinct causes.

**(a) `1a` renders before `1`.** On a START OVER the user sees the resume
prompt (`1a`) and then the welcome screen (`1`). Finding 2: *"First two
screens say screen 1."*

**I predicted this exactly and dismissed it.** `ScreenNumberTable`, written
2026-08-17: *"1a precedes screen 1. That's awkward but harmless (resumers
never see 1)."* **It is not harmless -- a START OVER shows both, and that is
the path Bill takes on every test.**

**Fix: the resume screens take NO number**, like the FT-189 `I` screen. They
are pre-flight, not journey. The rule already exists and I applied it to one
screen and not the other.

**(b) Gaps read as errors.** On resume: `1a, 1b, 10, 11, 21`. Ascending,
correct, and it looks broken. Rule 4 permits gaps; **nobody tells the user.**
The C-20 resume line exists but does not mention numbering.

### FT-196 -- Enter is still required after a letter

**Finding 27.** *"we have told the user that they would not have to hit
enter/spacebar again after selecting a letter. This is not true on this screen
and on several others."*

A real breach of the User-Facing Clarity Rule: we make a promise about the
keyboard and then break it. **Needs a sweep of every prompt** -- which is
mechanical and gate-able.

### FT-197 -- "Applying..." then "not applied"

**Finding 38**, and Bill is right that it makes no sense:

```
Apply? (Y = Yes / N = Skip / B = Back): Y
Applying...
Result: Saved for your individual review -- you will approve or skip this one next
```

**measured, line 6161:** `Apply-Setting` returns that string for items 11-15,
which FT-94 defers to `Show-ConvenienceReview` on purpose. **The deferral is
correct. The sequencing is not** -- the caller prints "Applying..." *before*
calling, so the user is told it is applying and then told it was not.

**Fix: test the deferral before printing "Applying...".** No logic change.

### FT-198 -- copy instructions are wrong, and contradict earlier screens

**Findings 8, 17, 24.** Three separate problems:

1. **`M` does nothing; `K` worked; later left-click worked and `K` did not.**
   *"Figure out what is going on and pick one way of doing copy that always
   works -- left click seems to be the choice."*
2. **We tell them how to copy after telling them they never need to copy.**
   Finding 17: *"Again we tell them about copying when we have already told
   them they don't have to copy."*
3. **The standard copy tip in CLAUDE.md says `Alt+Space, E, M`.** If `M` does
   not work on Windows 11's terminal, **that tip is wrong in all three places
   it is mandated.**

### FT-199 -- characters cut off at the end of each item

**Finding 36**, screen 27. *"a lot of characters are cut off at end of each
item."* Width defect, FT-117 family. Not yet located.

### FT-175b -- MY FIX WAS INCOMPLETE

**Finding 35.** *"No offline scan got offered on resume run."*

**measured:** I fixed the repeat-run *branch inside* `Show-PreScanGate`. But
line 9062 gates the whole function:

```powershell
if (-not (Test-CheckpointReached -Checkpoint "OfflineScanDone")) { Show-PreScanGate }
```

Bill's 16:18 run resumed from `AppsAudit`, which is past `OfflineScanDone`, so
**the function never ran and my fix never executed.** I fixed the branch and
left the gate.

**Bill's requirement, unchanged since ascii39 finding 38: the offline scan
should be offerable at any time.** That means a route to it that does not
depend on the checkpoint -- most naturally an item on the checklist.

### FT-184 -- the flash is STILL THERE

**Finding 1.** *"I think something flashed by = finally fix this."*

Cutting the banner did not do it. **Something else paints before SCREEN-25**,
and I have not identified it. Reported in ascii39, ascii40 and now ascii41.
**Next step is to capture it rather than reason about it** -- the console can
be recorded, or the startup path instrumented with a pause.

---

## DESIGN DECISIONS FOR BILL -- not defects

| # | Finding | What Bill wants |
|---|---|---|
| 3, 5 | Warn about the X button beside the scroll arrow; confirm on accidental X | **Already possible** -- FT-160's control handler catches the close. Needs a confirm dialog |
| 4 | Screen number on the same line as the title | Format change, applies to every screen |
| 5 | Auto-set the window for them | This is the FT-174 upfront-approval screen |
| 6 | Tell them where the log is on screen 6 | One line; the path is already computed |
| 7 | *"Why do we have messages that move on?"* | Needs clarification -- which messages |
| 12 | Combine screens 10-12 into one | Reduces screens, which is the standing goal |
| 13, 14 | Reword the scan-explanation screens; add "Machine Time"; split screen 14 | Copy work, specified precisely |
| 16 | Tell them to save and close files before the offline scan; give estimated time | Real gap -- Bill lost his notes to the reboot |
| 18 | BitLocker: plug in BEFORE choosing option 2; set sleep to Never ourselves; check battery % | Sequencing bug plus a genuine coordination question with the earlier sleep handling |
| 19 | Offer to delete quarantined items | |
| 20 | Explain MB can still run custom and deep scans | |
| 21 | Protect the screen during an overnight scan; give average scan times from our own logs | **The logs can answer this** -- we have timings across every trial run |
| 23 | Screen 19 too long; split; approval under each item | |
| 25 | **Reorganise the Tool folder** -- top level only the current .bat and .ps1, old builds to `gg\builds` | Housekeeping, and Bill is right that it has become hard to find the launcher |
| 28, 29 | Explain what the next screens will do, and give pros/cons per setting so approvals are informed | **The most valuable item on this list.** Bill: *"They just don't know what you are talking about... This is very important to make them comfortable in their approvals"* |
| 30, 31 | Checklist wording: #6 status, column widths, "we will show you how", #17 Pro-only | Precise, actionable |
| 36 | Guide page numbers per setting once both are final | Post-launch; also a sales hook |
| 37 | Windows Hello: what it does and why | |

---

## RESEARCH REQUESTED

**Finding 16:** *"deep research the internet, experts, forums and Microsoft
support to see if and how we can get Defender offline scan to do all connected
drives."* Bill observed the offline scan appeared to cover only C:. **Not yet
done.**

---

## WHAT I WOULD FIX FIRST, IN ORDER

1. **FT-193, the mouse.** Twenty command windows opening is worse than
   anything else here, ascii40 did not do it, and the prime suspect is a
   change I made. Nothing else should ship until it is understood.
2. **FT-194, the `I` key** -- one edit to `Pause-ForUser`, and it unblocks
   three of Bill's untested checklist items.
3. **FT-197** -- print "Applying..." after the deferral test.
4. **FT-195(a)** -- resume screens take no number.
5. **FT-175b properly** -- a checklist route to the offline scan.

**FT-198 needs a decision before code:** which copy method is the one true
method. Bill's read is left-click. That should be measured on SANDY before it
is written into three documents and a screen.
