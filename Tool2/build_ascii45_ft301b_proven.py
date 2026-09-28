"""build_ascii45_ft301b_proven -- FT-301: the Local State Startup boost field is
now flip-proven; the build comment that said "inferred" is corrected.

Dated: 2026-09-28 11:58 ET
Editor: Claude Code (CGDELL)

MEASURED on SANDY 2026-09-28 by Bill (Edge Settings -> System and performance
-> Startup boost), Test_Results\\Items1-4-13-SANDY-2026-09-28_11-41 / 11-53 / 11-54:
  11:41 off   startup_boost "enabled":false
  11:53 ON    startup_boost "enabled":true  (8 msedge processes left running --
              which is what Startup boost does)
  11:54 off   startup_boost "enabled":false
background_mode was not flipped (its Edge policy value 0 is present on SANDY).
Comment change only -- no behaviour changes.

Run from Tool2/:  python build_ascii45_ft301b_proven.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "    # *Inferred, not flip-proven*: \"enabled\" is the field the on-screen\n",
        "    # FT-301 (2026-09-28): startup_boost \"enabled\" is now FLIP-PROVEN on SANDY --\n"
        "    # false 11:41, true 11:53 with Startup boost turned on, false 11:54\n"
        "    # (Test_Results\\Items1-4-13-SANDY-2026-09-28_11-41/11-53/11-54.txt).\n"
        "    # background_mode \"enabled\" is still inferred. The original note:\n"
        "    # *Inferred, not flip-proven*: \"enabled\" is the field the on-screen\n",
        count=1, why="FT-301: proven note")
