"""build_ascii45_F8F9_wording -- Block F, F8 (FT-253, the F6 wording block,
plus FT-222 and FT-237) and F9 (FT-195a, FT-175b, FT-225).

Dated: 2026-09-28 08:59 ET
Editor: Claude Code (CGDELL)

Source: Bill's notes in GatewayGuard_FieldTestTriage-ascii43run2-2026-08-30-
1723.md, Part 2B and 2G, re-read against THIS build on 2026-09-28. Many of the
~20 items are gone with the screens they were about (Malwarebytes, 33a, the
N keys, setting 6's "applying now" -- FT-279). What is left, and built here:
  * Bill's sentence, "These must be set manually, Checkup will show you how":
    screen 23 page 1 (the can't-change list), screen 28 (Home encryption),
    and the run loop's by-hand line (in the CLAUDE.md permission wording).
  * Screen 23: "What you saw was what was FOUND" -- the user saw nothing.
    Tamper Protection "essential", Windows Hello "strongly recommended".
  * Screen 34: "AUTOMATED STEPS COMPLETE" was wrong (no scan need have run).
  * Screen 22: "see the Guide" said nowhere -- now Part 5.
  * Screen 27: "APPLYING" beside each X removed (Bill: "Remove 'applying'
    next to Xs").
  * FT-222: an item Checkup changed successfully loses its X, so going back
    to the checklist mid-run does not change it a second time.
  FT-237 (Advertising ID label) was closed by F2 -- the undo text is the full
  on-screen label. FT-225 (N = Back) closed by the keys rule (ascii44/C1).
  FT-175b: measured in source -- the offline scan offer is on the repeat run
  path (Show-PreScanGate, the FT-175b comment); nothing further is written
  down anywhere. FT-195a (1a before 1) goes to the renumber pass.
NOT built, needs Bill: screen 11's "All security setting changes made by
Checkup have been thoroughly tested" -- a claim the field record does not yet
support (FT-294, FT-297 were found this week).

Run from Tool2/:  python build_ascii45_F8F9_wording.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"


def box(e, pairs, why):
    for o, n in pairs:
        n2 = n.ljust(len(o))
        assert len(n2) == len(o), (o, n)
        e.replace('"' + o + '"', '"' + n2 + '"', count=1, why=why)


with PS1Edit(TARGET) as e:
    e.replace(
        "#           or a Part and section -- never a page, never the old \"Phase\".\n",
        "#           or a Part and section -- never a page, never the old \"Phase\".\n"
        "#   F8 (FT-253): Bill's wording on screens 22, 23, 27, 28, 34 and the by-hand\n"
        "#           line. FT-222: a changed item loses its X.\n",
        count=1, why="change log: F8")

    box(e, [
        ("  The previous pre-flight screens READ your current settings.       ",
         "  The screens so far only READ your settings -- nothing changed."),
        ("  What you saw was what was FOUND on your PC -- nothing was         ",
         "  The security checklist on the next screen shows what Checkup"),
        ("  changed yet. Changes only happen after you approve each item      ",
         "  FOUND. Only the items you select there are changed --"),
        ("  in the security checklist on the next screen.                     ",
         "  selecting an item is your approval."),
        ("  WHAT IT CHECKS BUT CANNOT CHANGE -- Windows insists a human      ",
         "  WHAT IT CHECKS BUT CANNOT CHANGE -- these must be set by"),
        ("  does these; Checkup shows you the exact steps instead:           ",
         "  hand, and Checkup will show you how:"),
        ("  * Tamper Protection                                              ",
         "  * Tamper Protection -- essential, keep it on"),
        ("  * Windows Hello (PIN)                                            ",
         "  * Windows Hello (PIN) -- strongly recommended"),
    ], "F8: screen 23 page 1")

    box(e, [
        ("  same protection as BitLocker on Pro, but Windows turns   ",
         "  same protection as BitLocker on Pro. Checkup cannot turn"),
        ("  it on itself -- Checkup cannot turn it on for you, and   ",
         "  it on -- if it is off, it must be turned on by hand, and"),
        ("  does not try.                                            ",
         "  Checkup will show you how."),
    ], "F8: screen 28")

    box(e, [
        ("  AUTOMATED STEPS COMPLETE                                  ",
         "  CHECKUP IS FINISHED -- STEPS ONLY YOU CAN DO"),
    ], "F8: screen 34 title")

    e.replace(
        "        Write-Host \"  see the Guide for how to set one up, then re-run Checkup.\" -ForegroundColor Gray\n",
        "        Write-Host \"  the guide, Part 5, shows how to set one up. Then run Checkup again.\" -ForegroundColor Gray\n",
        count=1, why="F8: screen 22 guide pointer")

    e.replace(
        "                        Write-Host (\"  [X] APPLYING  {0,2}. {1,-38} {2}\" -f $s.ID, $s.Name, $statusShort) -ForegroundColor White\n",
        "                        Write-Host (\"  [X]           {0,2}. {1,-38} {2}\" -f $s.ID, $s.Name, $statusShort) -ForegroundColor White   # F8: no \"APPLYING\"\n",
        count=1, why="F8: screen 27 rows")

    e.replace(
        "                        Write-Host \"  Windows does not let Checkup change this one. The exact steps come at the end.\" -ForegroundColor Yellow\n",
        "                        Write-Host \"  Windows does not allow any program to change this one, so Checkup\" -ForegroundColor Yellow\n"
        "                        Write-Host \"  shows you the exact steps to do it yourself, at the end.\" -ForegroundColor Yellow\n",
        count=1, why="F8: by-hand line, CLAUDE.md wording")

    # FT-222
    e.replace(
        "                    Add-GGRunResult -Setting $s -Was $ggWas -Now $result -Steps $(if ($result -match \"MANUAL|by hand|Manual setup\") { $result } else { \"\" })\n",
        "                    Add-GGRunResult -Setting $s -Was $ggWas -Now $result -Steps $(if ($result -match \"MANUAL|by hand|Manual setup\") { $result } else { \"\" })\n"
        "                    # FT-222 (ascii45): a changed item loses its X, so B back to the\n"
        "                    # checklist mid-run does not change it a second time.\n"
        "                    if (Test-GGResultGood $result) { $s.Selected = $false }\n",
        count=1, why="FT-222")
