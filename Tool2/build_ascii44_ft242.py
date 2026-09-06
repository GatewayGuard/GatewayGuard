"""build_ascii44_ft242 -- nine registry writes that could not fail.

FT-242. Without -EA Stop, a failed Set-ItemProperty raises a NON-TERMINATING
error: the catch never fires, execution falls through to the next line, and
that line is `$result = "... GOOD"`. So a write the machine refused is logged
to the customer's support file as a success.

Bill saw this in the field, screen 34: "I checked edge startup boost no
change, still off." The log for that run, 16:34:15, item 13, read:
  Before: Unknown -- could not check | Result: Edge startup boost and
  background mode disabled -- GOOD
Could not read before, did not read after, reported success.

WHY NINE AND NOT EIGHT
----------------------
The triage audited Apply-Setting, lines 6200-6600, and found 8 of 14 writes
unguarded. Auditing the WHOLE file found a ninth in a DIFFERENT function --
Apply-PowerSettings, line 5243 -- which is a second apply path for Fast
Startup (setting 18). Fixing only the audited range would have left the same
defect live in the other function, which is precisely the "is this the only
function that does this job?" failure CLAUDE.md records.

Apply-PowerSettings is less wrong than Apply-Setting: it re-reads afterwards
and prints what the re-read found, so it can already say "still enabled". The
guard still belongs there -- a refused write should reach the ERROR branch,
not be reported as a re-read result.

DELIBERATELY NOT CHANGED
------------------------
1574, 1575, 1586, 1587 -- Suspend-ScreenSaver / Restore-ScreenSaver. These use
-EA SilentlyContinue on purpose. A screensaver tweak that fails must not abort
a security run.

3931 -- Test-TimeDateSync. SAME DEFECT CLASS, filed as FT-254 and NOT fixed
here. It prints "Time sync settings corrected." after four calls that all
carry -EA SilentlyContinue (Set-Service, Start-Service, w32tm, and this
Set-ItemProperty). Guarding only the registry write would still let a failed
Set-Service print success, so the fix needs all four considered together and
is a judgment call about a screen outside the nineteen settings. Widening a
mechanical change into that is how a low-risk build becomes a risky one.

Run from Tool2/:  python build_ascii44_ft242.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

# (anchor, why) -- each anchor verified unique in the file before writing.
SITES = [
    ("-Name Enabled -Value 0 -Type DWord -Force",
     "FT-242 site 1/9: setting 11 Advertising ID"),
    ("-Name AllowTelemetry -Value 1 -Type DWord -Force",
     "FT-242 site 2/9: setting 12 Diagnostic Data"),
    ("-Name StartupBoostEnabled   -Value 0 -Type DWord -Force",
     "FT-242 site 3/9: setting 13 Edge startup boost -- the one Bill caught"),
    ("-Name BackgroundModeEnabled  -Value 0 -Type DWord -Force",
     "FT-242 site 4/9: setting 13 Edge background mode"),
    ("-Name AllowNewsAndInterests -Value 0 -Type DWord -Force",
     "FT-242 site 5/9: setting 14 Widgets -- the one that failed in the field"),
    ("-Name PasswordManagerEnabled -Value 0 -Type DWord -Force",
     "FT-242 site 6/9: setting 15 Edge password saving"),
    ("-Name Enabled -Value 1 -Type DWord -Force",
     "FT-242 site 7/9: setting 16 Memory Integrity"),
]

with PS1Edit(TARGET) as e:
    for anchor, why in SITES:
        e.replace(anchor, anchor + " -EA Stop", count=1, why=why)

    # The two HiberbootEnabled writes are identical, so each needs the line
    # AFTER it to disambiguate -- Apply-Setting sets $result, Apply-PowerSettings
    # sets $ggNow.
    e.replace(
        '-Name HiberbootEnabled -Value 0 -Type DWord -Force\n'
        '                $result = "Fast Startup disabled',
        '-Name HiberbootEnabled -Value 0 -Type DWord -Force -EA Stop\n'
        '                $result = "Fast Startup disabled',
        count=1,
        why="FT-242 site 8/9: setting 18 Fast Startup, in Apply-Setting",
    )
    e.replace(
        '-Name HiberbootEnabled -Value 0 -Type DWord -Force\n'
        '            $ggNow = "could not re-read',
        '-Name HiberbootEnabled -Value 0 -Type DWord -Force -EA Stop\n'
        '            $ggNow = "could not re-read',
        count=1,
        why="FT-242 site 9/9: setting 18 Fast Startup, in Apply-PowerSettings "
            "-- the site outside the triage's audited range",
    )

    # Header change record.
    e.replace(
        "# CHANGES FROM ascii39 (2026-08-15 -- ASCII40: THE THREE FIELD BLOCKERS):",
        "# CHANGES FROM ascii43 (2026-09-06 -- ASCII44):\n"
        "#   FT-242: NINE REGISTRY WRITES COULD NOT FAIL. Without -EA Stop a\n"
        "#           refused Set-ItemProperty raises a non-terminating error --\n"
        "#           the catch never fires, and the next line sets\n"
        "#           $result = \"... GOOD\". The customer's support file recorded\n"
        "#           a success for a change the machine rejected. Bill caught it\n"
        "#           on screen 34: \"I checked edge startup boost no change,\n"
        "#           still off\", against a log reading\n"
        "#           \"Before: Unknown -- could not check | Result: ... GOOD\".\n"
        "#           Eight sites were in Apply-Setting; a ninth was found in\n"
        "#           Apply-PowerSettings, a second apply path for setting 18\n"
        "#           that the triage's line range never covered.\n"
        "#           NOT changed: Suspend-ScreenSaver and Restore-ScreenSaver\n"
        "#           (1574-1587), where -EA SilentlyContinue is correct -- a\n"
        "#           cosmetic failure must not abort a security run.\n"
        "#           FT-254 raised for Test-TimeDateSync (3931), same class,\n"
        "#           four calls that need deciding together.\n"
        "#\n"
        "# CHANGES FROM ascii39 (2026-08-15 -- ASCII40: THE THREE FIELD BLOCKERS):",
        count=1,
        why="FT-242: header change record for ascii44",
    )
