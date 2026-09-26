"""build_ascii45_a4_ft278 -- five screens stop promising what Checkup does not do.

Dated: 2026-09-26 11:52 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block A, item A4.

FT-278 (measured, triage Part 2 notes 4 and 32; Bill's notes 4 and 32):
  screen 10 -- "BitLocker uses Device Encryption on Home -- handled
               automatically by Checkup."  The Home path changes nothing; it
               shows manual steps across 4 screens (SANDY R9 18:20:48).
  screen 11 -- "select option 2 (Enable overnight)". The Home path has no
               option 2. New wording is true on Home and Pro alike.
  screen 21 -- "asks Y/N before any change". False since FT-219 (selecting an
               item IS approval). (B1 rewrites this box later; fixed now so it
               is right even if B1 slips.)
  screen 33 -- "AUTOMATED SCAN SCHEDULE" / "Scheduled: ... 2AM". The task is a
               REMINDER popup (FT-175's own comment, same function).
  screen 34 -- "Scheduled Scans -- AUTOMATED" / "will still run automatically".
               Same: reminders.
Every replaced box line keeps its exact length (FT-117/FT-122: Write-GGBox
sizes the box from its longest line). Malwarebytes lines are left for B2.

Run from Tool2/:  python build_ascii45_a4_ft278.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"


def swap(e, pairs, why, indent, last_comma=True):
    """Replace a run of consecutive box lines; each new text is padded to the
    old line's exact length and may never be longer. last_comma says whether
    the group's final line is followed by another array element."""
    old_block, new_block = "", ""
    for i, (old, new) in enumerate(pairs):
        assert len(new) <= len(old), (why, len(new), len(old), new)
        end = ",\n" if (i < len(pairs) - 1 or last_comma) else "\n"
        old_block += f'{indent}"{old}"{end}'
        new_block += f'{indent}"{new.ljust(len(old))}"{end}'
    e.replace(old_block, new_block, count=1, why=why)


with PS1Edit(TARGET) as e:
    e.replace(
        "#           colour rule and logs WARN/ERROR for anything not a success.\n",
        "#           colour rule and logs WARN/ERROR for anything not a success.\n"
        "#   FT-278: FIVE SCREENS PROMISED WHAT CHECKUP DOES NOT DO. 10: Home\n"
        "#           encryption \"handled automatically\" (it is manual steps). 11:\n"
        "#           \"option 2\" (Home has none). 21: \"asks Y/N before any change\"\n"
        "#           (false since FT-219). 33 and 34: \"automatic\"/\"scheduled\"\n"
        "#           scans (they are reminder popups, FT-175). Box widths kept.\n",
        count=1,
        why="change log: FT-278",
    )
    # screen 10 (Get-WinEdition)
    swap(e, [
        ("  BitLocker uses Device Encryption on Home -- handled               ",
         "  On Home, encryption is called Device Encryption. Checkup"),
        ("  automatically by Checkup.                                         ",
         "  shows you the steps to turn it on yourself."),
    ], "FT-278: screen 10 -- Home encryption is manual steps, not automatic", indent="            ", last_comma=False)
    # screen 11 (Get-RAMStatus)
    swap(e, [
        ("  Schedule it to run overnight -- select option 2            ",
         "  Checkup shows the time estimate and your choices when"),
        ("  (Enable overnight) when you reach the BitLocker screen.    ",
         "  you reach the encryption screen at the end."),
    ], "FT-278: screen 11 -- no 'option 2' promise (Home has none)", indent="                ")
    # screen 21 (mode select)
    swap(e, [
        ("      setting, its live status, and asks Y/N before any     ",
         "      setting and its live status, and changes only the"),
        ("      change. Fast and fully transparent.                   ",
         "      items you select. Fast and fully transparent."),
    ], "FT-278: screen 21 -- selecting is approval (FT-219)", indent="        ")
    # screen 33 (scan reminder setup)
    swap(e, [
        ("  AUTOMATED SCAN SCHEDULE SETUP                            ",
         "  SCAN REMINDER SETUP"),
        ("  Setting up automatic security scans...                   ",
         "  Setting up reminders to run your security scans..."),
    ], "FT-278: screen 33 header -- reminders, not automatic scans", indent="        ")
    swap(e, [
        ("  (1) Quarterly Defender Offline Scan                      ",
         "  (1) Quarterly reminder: Defender Offline Scan"),
        ("      Runs BEFORE Windows loads -- catches deeply hidden   ",
         "      A popup on the 1st of Jan / Apr / Jul / Oct reminds"),
        ("      threats. Scheduled: 1st of Jan / Apr / Jul / Oct 2AM ",
         "      you to run it. The scan runs before Windows loads."),
    ], "FT-278: screen 33 item 1 -- a reminder popup, not a scheduled scan", indent="        ")
    # screen 34 (Show-ManualSteps)
    swap(e, [
        ("  [ ] Scheduled Scans    -- AUTOMATED: Checkup set up       ",
         "  [ ] Scan reminders     -- Checkup set up popups for a"),
        ("      Quarterly Defender Offline Scan (Jan/Apr/Jul/Oct)     ",
         "      quarterly Defender Offline Scan (Jan/Apr/Jul/Oct)"),
    ], "FT-278: screen 34 -- scan reminders, not automated scans", indent="        ")
    swap(e, [
        ("  items above on your own time. Your scheduled scans (above)  ",
         "  items above on your own time. Your scan reminders (above)"),
        ("  will still run automatically later -- everything else       ",
         "  will still pop up later -- everything else"),
    ], "FT-278: screen 34 closing -- reminders pop up, scans do not run by themselves", indent="        ")
print("A4 applied")
