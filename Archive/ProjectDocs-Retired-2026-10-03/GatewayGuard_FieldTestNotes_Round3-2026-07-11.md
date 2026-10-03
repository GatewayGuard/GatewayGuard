<!-- Dated: 2026-07-11 16:45 ET -->
# GatewayGuard -- Field Test Notes, Round 3 (ascii24)
**Test date:** 2026-07-11 (~1:30 PM ET)  |  **Build tested:** ascii24
**Numbering continues from Round 2 (last: FT-20 + FT-18b).**

## FIXED IN ascii25 (built same day, 2026-07-11 16:45 ET)

### FT-21: Time check -- N answer appeared to stall (Raw #1)
Not a hang: the first N triggered a SECOND question ("Open Date & Time
settings now?") that was easy to miss, so the tester pressed N again and
unknowingly declined the fix. FIXED: follow-up question is now in a
yellow box with an explicit Y = Open / N = Skip prompt.

### FT-22: Malwarebytes elevation (Raw #2)
ANSWER: yes -- the tool runs as Administrator, and any program it starts
INHERITS that, so Malwarebytes launched by the tool is already elevated.
Screen now says so. The manual-launch fallback (exe not found) now gives
select-then-right-click Run-as-administrator steps.

### FT-23: FALSE "DEFENDER REAL-TIME PROTECTION IS OFF" alarm (Raw #4)
ROOT CAUSE: if the Defender status query THREW AN ERROR, the code
defaulted to "off" and fired the full alarm screen. Unknown is now
tracked separately -- calm "could not verify, here's how to check
yourself" message, no alarm, no exit ramp. CONFIRM in round 4: if the
alarm appears again, the log now says whether Defender was CONFIRMED
off or the check failed.

### FT-24: Ctrl+C KILLED the program (Raw #4)
Direct consequence of disabling QuickEdit in ascii24 (FT-01 fix):
without QuickEdit, Ctrl+C = break signal = instant termination.
FIXED: Ctrl+C is now treated as ordinary input. Also added WINDOW SETUP
item 6: nothing ever needs copying off screens -- it is all in the log
(C:\GatewayGuard\Logs). Known trade-off: with QuickEdit off, mouse
highlight/right-click copy no longer work. The log IS the copy.

### FT-25: Non-admin run continued instead of closing (Raw #5)
Limited mode REMOVED: without admin the tool now shows the run-as-admin
instructions (with select-then-right-click wording) and CLOSES on
keypress. PRODUCT DECISION LOGGED: limited mode is gone entirely.

### FT-26: 3-5 second silent gap at launch (Raw #6)
Hardware identification queries caused it. Immediate "Please wait --
checking your system..." now prints first.

### FT-27: WINDOW SETUP item 1 wording (Raw #7)
Now: "IF YOU HAVEN'T MAXIMIZED THIS WINDOW YET, DO IT NOW!"

### FT-28: "(UTC-05:00)" label confusion (Raw #8)
Not a bug -- Windows always displays the zone's winter (standard) label
even during daylight saving. Screen now explains this in plain English:
if day/date/time are right, everything is correct.

### FT-11 extension: overnight deep scan (Raw #3)
FIELD EVIDENCE: IdeaPad, previously scanned clean by Defender + MB quick
scan, later showed 6 detections on a deep scan. Dell deep scan: clean.
BUILT: "GO DEEPER" box after Malwarebytes launch -- run Deep/Custom scan
(all drives) overnight, plugged in, with Sleep set to Never for the
night (Settings > System > Power & battery), restore tomorrow. Reminder:
the tool's own sleep prevention ends when the tool closes -- it does NOT
cover an overnight scan, hence the manual Sleep=Never step.

## STILL OPEN -- INVESTIGATE

### FT-27b: Spacebar ignored / Enter needed twice (Raw #7) -- OPEN
On the WINDOW SETUP screen, Space did not advance and Enter took two
presses (seen before at least once). Leading hypothesis: the FT-01
input-buffer flush discards keys pressed BEFORE the prompt renders --
fast type-ahead gets eaten, so the FIRST press vanishes and the second
works. NEXT ROUND: when it happens, note the screen, then send the log
-- the [KEY] entries will show which presses registered and where.
Trade-off call pending: the flush is what stops the far worse
walk-away-and-die bug, so it stays unless the log shows otherwise.

### FT-01 status check
No walk-away deaths reported in round 3 (Ctrl+C death was separate --
now fixed). Cautiously good sign for the ascii24 QuickEdit+flush fix.
Keep watching.

### IdeaPad follow-up (owner action, not a build item)
6 deep-scan detections on the IdeaPad pending handling. Compare deep-
scan durations HP vs Dell vs IdeaPad when available -- feeds the "how
long will this take" copy.
