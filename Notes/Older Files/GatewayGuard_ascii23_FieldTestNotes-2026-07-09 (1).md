<!-- Dated: 2026-07-09 22:17 EDT -->
# GatewayGuard -- ascii23 Field Test Notes (Dell + IdeaPad)
Source: extensive hands-on testing, raw notes file "AScii23_2026-07.md"
Numbering below = FT-## (Field Test), to avoid collision with existing
UX-01–UX-11 / OBS-01–OBS-03 from the earlier Dell baseline round.

---

## 🔴 CRITICAL -- INVESTIGATE FIRST

### FT-01: Session unexpectedly ends when switching away from console window (Raw #5, #8, #12)
Reported **three separate times**, on three different screens ("BEFORE YOU
START -- WINDOW SETUP", the Real-Time Protection screen, and once more
right after). Common thread each time: user switched to Notepad (or
another window) mid-screen, then switched back -- and the session had
ended.

**Hypothesis to test:** `Read-ValidKey`'s raw console input handling
(`$Host.UI.RawUI.ReadKey`) may throw or behave unexpectedly when the
console loses and regains focus, and if that exception isn't caught
cleanly, it could silently terminate the script instead of just
re-prompting. Needs direct investigation -- this is the single highest-
priority bug in this round, since it's reproducible and hits core
navigation, not an edge feature.

**Distinct from FT-03 below** (items #13, #20), where the user
confirmed they personally clicked the X button -- that's expected
behavior (closing a window closes the program), not a bug.

### FT-02: GUI Mode crash -- 'op_Subtraction' method not found (Raw #6)
```
Method invocation failed because [System.Object[]] does not contain a method named 'op_Subtraction'.
At ...ascii23-2026-07-06.ps1:3671 char:9
+         $rowBg.Location = New-Object System.Drawing.Point(0, $yPos - ...
```
Classic PowerShell gotcha: `$yPos` is apparently an **array**
(`System.Object[]`), not a scalar integer, at the point of subtraction --
arrays don't support the `-` operator. Almost certainly caused by a loop
or function call earlier that returns multiple objects to the pipeline
unsuppressed, silently turning `$yPos` into an array instead of a single
number. Happened after selecting GUI Mode and waiting through "Checking
current settings -- please wait..." -- needs a line-by-line review of
everything that sets `$yPos` before line 3671.

### FT-03: User-closed window (X button) during Power Settings screen (Raw #13, #20)
User confirmed this was their own action (hit X while trying the up
arrow), not a script bug. No fix needed -- noted for completeness, and
because it surfaced the maximize/scroll issue below (FT-05).

---

## 🟡 WORDING / SEQUENCE FIXES

### FT-04: Font setup should be the very first screen (Raw #1)
Currently "Welcome to GatewayGuard" shows before the console-font
instructions. Reorder so "STEP 1 OF 2: SET YOUR CONSOLE FONT" is the
literal first thing shown.

### FT-05: Scroll instruction wording unclear -- needs your clarification
Raw note #2 reads: *"Now Scroll to the of this window and following
windows.= on the right side, so you don't miss anything."* -- this looks
like a typo/transcription gap (missing a word after "to the"). Before I
change the actual script wording, can you confirm the intended phrase?
My best guess is something like "Now scroll to the top of this window,
and remember to do this on every following screen too." Flag: don't
want to guess wrong and ship different wrong wording.

### FT-06: Add "TOP and BOTTOM" to scroll reminders (Raw #4, #13)
Currently only mentions scrolling to the top. Add reminder to scroll to
the **bottom** too, since later content can be missed. Apply to the
Power Settings screen specifically (per #13) and audit all screens with
scrollable content.

### FT-07: Standardize "press Enter to continue" wording (Raw #5)
At least one screen ("BEFORE YOU START -- WINDOW SETUP") still says
"press Enter to continue..." instead of "press Enter or Space." Audit
**every** continue-prompt in the script for consistency -- this was
supposed to already be standardized; this is a regression or a missed
spot.

### FT-08: Resume flow should remind user to re-maximize (Raw #14)
When resuming after the offline-scan reboot, the original maximize/
scroll instructions aren't repeated, so the user doesn't get the
reminder. Add a short reminder in the resume path: "Press Windows+Up
Arrow (or click the maximize box, top-right) to make this window
full-screen again."

---

## 🔵 RESEARCH ITEMS (not yet built, need investigation before deciding)

### FT-09: Auto-correct time/date with user approval (Raw #9)
Dell's clock was off by 3 hours; user answered "N" (not correct) when
asked to confirm. Currently `Test-TimeDateSync` only re-enables
auto-sync services -- it doesn't force an immediate, explicit
correction if the offset is large or auto-sync doesn't resolve it fast
enough. Research: build an approval-gated manual time/timezone
correction path for when auto-sync alone doesn't fix it.

### FT-10: Automate window maximize (Windows+Up) instead of instructing user (Raw #15, #20)
Idea: send the Windows+Up Arrow key combination programmatically at
launch and after resume, instead of asking the user to do it manually
each time -- and drop the explanatory text if this works ("part of our
automation" framing). Research whether this is reliably scriptable
(SendKeys vs. a Win32 call), and whether Windows+Up actually restores
scroll position to the top of the console buffer or only changes window
state (these may be two separate things -- maximizing the window may
not scroll the buffer). Add to test procedure for all 3 PCs once a
method is chosen.

### FT-11: Malwarebytes trial upgrade nag + Deep Scan guidance (Raw #10)
When Malwarebytes is found still in trial, it shows an upgrade-prompt
box. Script should tell the user to X out of it (don't upgrade), briefly
reiterate why Defender is the primary AV (or point back to earlier
explanation if already given), and guide them to Scan Options → Deep
Scan -- which may only be available during the trial window. **Note:**
verify this Deep Scan option status on the HP test PC specifically,
since its Malwarebytes trial has already expired -- behavior may differ.

### FT-12: Explain Defender/Malwarebytes real-time-protection handoff (Raw #11)
When Malwarebytes is active, Defender's real-time protection shows as
OFF -- this is expected and will revert automatically, not a problem.
Script needs to explain this clearly so the "!! DEFENDER REAL-TIME
PROTECTION IS OFF" screen doesn't alarm users. This warning should only
trigger when Malwarebytes is NOT in control AND Defender is off (a
genuine problem state) -- confirm the current logic actually
distinguishes these two cases.

**Tamper Protection observations logged (not yet a fix, just data):**
- Dell (Win 11 Pro): Tamper Protection ON. Malwarebytes does not appear
  to touch this setting.
- IdeaPad: Malwarebytes Premium was purchased then rescinded. Tamper
  Protection still ON; Deep Scan still available.
- **Action:** systematically check all settings on all 3 test machines
  (Dell, IdeaPad, HP/SANDY), and check whether monthly Deep Scan +
  weekly Quick Scan scheduling is possible. Create a standard test
  procedure/checklist for any future/untested PC.

### FT-13: Investigate the "flash of full screen" after Resume (Raw #16)
After resuming, "Checking current settings" hung for a while; user hit
Space, saw a brief flash, then a larger flash of what looked like a
full screen of information, before moving on. Message cuts off before
describing the final destination screen. **Need clarification from
Bill:** what screen did it land on after the flash? May be related to
FT-02's GUI rendering issue, or a separate console redraw quirk.

---

## 🟢 CONTENT / MARKETING / BUSINESS IDEAS (not script bugs)

### FT-14: PowerShell tips for website (Raw #17)
- In the PS console, you don't need Ctrl+C -- highlighting text and
  clicking elsewhere copies it automatically (QuickEdit mode behavior).
- Add a "useful PowerShell commands" tips list to the website.
- Add tips on increasing console font size and cursor size for
  readability.

### FT-15: Windows key shortcuts list + custom key action product idea (Raw #18)
- Prepare a list of all Windows-key shortcut actions.
- Prepare a list of recommended custom key actions users could set up
  themselves.
- **Business idea (price TBD):** sell these as a product; consider
  giving some/all (TBD which) free with bundled purchases.
- Add a tip explaining the value of OneDrive/Google Drive etc. for
  backup and cross-device sync.

### FT-16: Ads as a future monetization channel (Raw #19)
Logged as a **far-future consideration only** -- not a current plan,
not reflected in any current pricing or marketing material. Flagging
clearly so this doesn't get mistaken for an active decision.

### FT-17: Right-click targeting instruction for the .bat file (Raw #7)
Users need to be told to point the mouse **directly on the .bat file's
icon** before right-clicking to get the "Run as administrator" option.
Right-clicking while the cursor is elsewhere in the selection highlight
(not on the icon glyph itself) shows a different context menu without
that option. This is a real Windows quirk -- add clear guidance (with a
screenshot ideally) to the guide/FAQ, not a script fix.

---

## SUMMARY -- SUGGESTED NEXT STEPS

1. **FT-01 (session-ending bug) and FT-02 (GUI crash)** are the two
   items that actually block reliable use of the tool -- recommend
   tackling these first, before wording polish.
2. **FT-05** needs your clarification before I touch that wording.
3. **FT-13** needs your clarification on what screen appeared after
   the "flash."
4. Everything else is either a straightforward wording fix, a research
   item with no urgency, or a content/business idea for later.

*Logged 2026-07-09. Not yet incorporated into any script -- this is the
intake/organization pass only, per request.*
