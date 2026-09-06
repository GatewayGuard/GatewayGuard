"""build_ascii44_base -- stand up ascii44 from the ascii43 copy.

Bumps the in-file build-ID locations only (no functional change). Three of the
five build-ID locations live in the .ps1 and go through gg_edit; the filename
was set by the copy, and CLAUDE.md is edited separately.

WHY THERE IS AN ascii44: ascii43 was field run twice, 2026-08-26 to 08-30,
five logs in Test_Results\\FieldRun-ascii43\\. A build that has been field run
is spent -- Build Naming Rules: never reuse a build number.

Run from Tool2/:  python build_ascii44_base.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "# Dated: 2026-08-21 17:52 ET",
        "# Dated: 2026-09-06 12:14 ET",
        count=1,
        why="ascii44 base: file header date -> 2026-09-06",
    )
    e.replace(
        "# FILE:    W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1",
        "# FILE:    W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1",
        count=1,
        why="ascii44 base: FILE header (build-ID location 2 of 5)",
    )
    e.replace(
        "# BUILD:   ascii43  |  Version 3.1",
        "# BUILD:   ascii44  |  Version 3.1",
        count=1,
        why="ascii44 base: BUILD header (build-ID location 3 of 5)",
    )
    e.replace(
        '$BuildID        = "ascii43"',
        '$BuildID        = "ascii44"',
        count=1,
        why="ascii44 base: $BuildID (build-ID location 4 of 5)",
    )
