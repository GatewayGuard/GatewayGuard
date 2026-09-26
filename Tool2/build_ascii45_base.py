"""build_ascii45_base -- stand up ascii45 from the ascii44 copy.

Dated: 2026-09-26 10:59 ET
Editor: Claude Code (CGDELL)

Bumps the in-file build-ID locations and opens the CHANGES FROM ascii44 block.
No functional change. Three of the five build-ID locations live in the .ps1
and go through gg_edit; the filename is set by the copy below, and CLAUDE.md is
edited separately.

WHY THERE IS AN ascii45: ascii44 was field run on SANDY 2026-09-19/20, nine
logs in Test_Results\\FieldRun-ascii44\\, triaged in
FieldTestTriage-ascii44run1-2026-09-24-2353. A build that has been field run is
spent -- Build Naming Rules: never reuse a build number.

Plan: ProjectDocs\\GatewayGuard_ascii45BuildPlan-2026-09-25-1638.md

Run from Tool2/:  python build_ascii45_base.py
"""
import os
import shutil
from gg_edit import PS1Edit

SRC = r"..\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"
TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

if not os.path.exists(TARGET):
    shutil.copy2(SRC, TARGET)

with PS1Edit(TARGET) as e:
    e.replace(
        "# Dated: 2026-09-06 12:14 ET",
        "# Dated: 2026-09-26 10:59 ET",
        count=1,
        why="ascii45 base: file header date -> 2026-09-26 10:59",
    )
    e.replace(
        "# FILE:    W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1",
        "# FILE:    W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1",
        count=1,
        why="ascii45 base: FILE header (build-ID location 2 of 5)",
    )
    e.replace(
        "# BUILD:   ascii44  |  Version 3.1\n# CHANGES FROM ascii43 (2026-09-06 -- ASCII44):",
        "# BUILD:   ascii45  |  Version 3.1\n"
        "# CHANGES FROM ascii44 (2026-09-26 -- ASCII45):\n"
        "#   Plan: ProjectDocs\\GatewayGuard_ascii45BuildPlan-2026-09-25-1638.md\n"
        "#   Source of every FT-265..FT-285 below: the ascii44 SANDY field run,\n"
        "#   FieldTestTriage-ascii44run1-2026-09-24-2353.\n"
        "#   (entries are added here, one family per commit)\n"
        "#\n"
        "# CHANGES FROM ascii43 (2026-09-06 -- ASCII44):",
        count=1,
        why="ascii45 base: BUILD header (build-ID location 3 of 5) + open the ascii45 change log",
    )
    e.replace(
        '$BuildID        = "ascii44"',
        '$BuildID        = "ascii45"',
        count=1,
        why="ascii45 base: $BuildID (build-ID location 4 of 5)",
    )
print("ascii45 base written:", TARGET)
