"""build_ascii43_base -- stand up ascii43 from the ascii42 copy.

Bumps the in-file build-ID locations only (no functional change). Three of the
five build-ID locations live in the .ps1 and go through gg_edit; the filename
was set by the copy, and CLAUDE.md is edited separately.

Run from the Tool/ directory:  python build_ascii43_base.py
"""
from gg_edit import PS1Edit

TARGET = r"W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "# Dated: 2026-08-15 08:28 EDT",
        "# Dated: 2026-08-21 17:52 ET",
        count=1,
        why="ascii43 base: file header date -> 2026-08-21",
    )
    e.replace(
        "# FILE:    W11-SecurityHardening-v3-ascii42-2026-08-19-1830.ps1",
        "# FILE:    W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1",
        count=1,
        why="ascii43 base: FILE header (build-ID location 2 of 5)",
    )
    e.replace(
        "# BUILD:   ascii42  |  Version 3.1",
        "# BUILD:   ascii43  |  Version 3.1",
        count=1,
        why="ascii43 base: BUILD header (build-ID location 3 of 5)",
    )
    e.replace(
        '$BuildID        = "ascii42"',
        '$BuildID        = "ascii43"',
        count=1,
        why="ascii43 base: $BuildID (build-ID location 4 of 5)",
    )
