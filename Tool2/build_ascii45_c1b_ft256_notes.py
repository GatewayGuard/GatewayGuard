"""build_ascii45_c1b_ft256_notes -- mark the FT-256 history notes as
superseded by FT-268, so a reviewer does not read them as current code.

Dated: 2026-09-26 13:14 ET
Editor: Claude Code (CGDELL)

Why: Co-Pilot's 2026-09-26 review of the ascii45 text described item 17 as
read with `powercfg /query` and "could not read". MEASURED: both phrases it
quoted are in ascii45 -- line 152 (the ascii44 change history the header
keeps) and line 6154 (the comment above item 17) -- and neither said FT-268
replaced it. The code path uses `powercfg /qh`. Comments only; no code change.

Run from Tool2/:  python build_ascii45_c1b_ft256_notes.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "#           exited on one keypress -- they now ask first (Confirm-Exit).\n",
        "#           exited on one keypress -- they now ask first (Confirm-Exit).\n"
        "#   C1b:    The FT-256 notes below (ascii44 history, and above item 17)\n"
        "#           now say FT-268 superseded them. Comments only.\n",
        count=1, why="change log: C1b")

    e.replace(
        "#           output, so the next field run says WHY.\n",
        "#           output, so the next field run says WHY.\n"
        "#           SUPERSEDED BY FT-268 (ascii45): the \"could not read\" was\n"
        "#           caused by `powercfg /query`, which leaves out hidden settings.\n"
        "#           The reader now uses `powercfg /qh` and reads it on every\n"
        "#           machine measured. This note is history, not current code.\n",
        count=1, why="FT-256 history note: superseded by FT-268")

    e.replace(
        "                # FT-256 (ascii44, fixed 2026-09-08): \"Not required -- needs\n",
        "                # SUPERSEDED IN PART BY FT-268 (ascii45): Get-GGConsoleLockState\n"
        "                # now reads with `powercfg /qh`, so \"could not read\" is rare.\n"
        "                # The unknown-keeps-selected rule below still applies.\n"
        "                # FT-256 (ascii44, fixed 2026-09-08): \"Not required -- needs\n",
        count=1, why="item 17 comment: superseded note")
