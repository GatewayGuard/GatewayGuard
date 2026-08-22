"""build_ascii40_switch -- "switch" is never the verb. Three strings in the build.

Dated: 2026-08-15 09:35 ET
Editor: Claude Code (CGDELL)

CLAUDE.md, and the rule is unconditional since Bill withdrew the last
exemption on 2026-08-12: "The verb rule is now unconditional: 'switch' is
never the verb. The noun survives. Nothing else does."

Three reasons, in the order CLAUDE.md gives them: Checkup itself says "turn
on/off" 23 times (D-18 -- the product's vocabulary is the vocabulary); Windows
Settings says "Turn on"; and "switch off" is British while GatewayGuard writes
for American seniors.

FOUND BY GATE 25, NOT BY READING. Run-CopyCheck.bat over the tree,
2026-08-15. This is the point of having the checker: the website was swept for
this on 2026-08-02 and the BUILD was not, so the tool kept saying the thing the
website had stopped saying -- which is RULE W-07's drift, pointed inward.

THE THREE, and why each is the verb and not the noun:

  1  SCREEN-02  "right-click copy are switched OFF"     -> "turned OFF"
  2  a power screen  "protection Checkup switched on"   -> "turned on"
  3  setting 10's description  "nothing to switch off"  -> "nothing to turn off"

The NOUN is untouched and must stay untouched -- "the Memory integrity switch.
It should say On." is a thing on the user's screen, and CLAUDE.md protects it
explicitly. measured 2026-08-15: no noun use was altered by this pass.

Box lines are LENGTH-PRESERVED. "switched" is 8 characters and "turned" is 6,
so two trailing spaces come back in each box string. Write-GGBox takes the box
width from its longest line; FT-117 and FT-122 are both width defects and
neither is worth re-earning over a verb.

Run:  python Tool\\build_ascii40_switch.py
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from gg_edit import PS1Edit  # noqa: E402

TARGET = Path(__file__).parent / "W11-SecurityHardening-v3-ascii40-2026-08-15-0828.ps1"


def main():
    with PS1Edit(TARGET) as e:
        # 1. SCREEN-02, the scroll-and-copy tip. Length 60 -> 60.
        e.replace(
            '"  Mouse highlighting and right-click copy are switched OFF   "',
            '"  Mouse highlighting and right-click copy are turned OFF     "',
            count=1,
            why='switch-as-verb 1 of 3 -- SCREEN-02 copy tip (length preserved)')

        # 2. The screen-timeout advisory. Length 62 -> 62.
        e.replace(
            '"      protection Checkup switched on for this session --       "',
            '"      protection Checkup turned on for this session --         "',
            count=1,
            why='switch-as-verb 2 of 3 -- stay-awake note (length preserved)')

        # 3. Setting 10's description. Not a box line, so no padding to hold.
        e.replace(
            "so there is nothing to switch off there.",
            "so there is nothing to turn off there.",
            count=1,
            why='switch-as-verb 3 of 3 -- Remote Desktop description')

    return 0


if __name__ == "__main__":
    sys.exit(main())
