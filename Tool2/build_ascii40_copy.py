"""build_ascii40_copy -- the second guarded pass: the copy debts ascii40 owes.

Dated: 2026-08-15 09:05 ET
Editor: Claude Code (CGDELL)

Separate from build_ascii40.py on purpose. That pass is defect work on the
input path and one wrong external command; this one is copy. Playbook Class 6
rule 3 wants change classes separable, and two scripts is the cheapest way to
keep the attribution clean if a field failure appears.

WHAT IS IN HERE

1. THE THREE REMAINING "whether" STRINGS. CLAUDE.md names them and assigns
   them to this build: "Still owed in the build: three user-facing strings in
   ascii39 still say 'whether' -- the convenience-review line, and two Device
   Encryption screens. Fix in ascii40." measured 2026-08-15: exactly three,
   at the convenience-review line and both Device Encryption screens, which is
   the debt closed to the character.

   Box lines are LENGTH-PRESERVED. Write-GGBox sets the box width from the
   longest line it is given, so changing a line's length can change the width
   of the whole box. Trailing spaces are adjusted to keep each string the size
   it was -- FT-117/FT-122 are both width defects and neither is worth
   re-earning over a copy fix.

2. GATE 24b's LAST FINDING, declared rather than deleted. The gate's own
   header draws the distinction: showing a command line to EXPLAIN internals
   is jargon and must go; TELLING the user to type something as a fallback
   they can actually perform is a legitimate instruction. This is the second
   kind -- it is the Home-edition fallback for a user whose Device Encryption
   page is missing, and deleting it would leave that user with a dead end,
   which the plain-language rule forbids in the same breath. So it carries a
   GATE24-OK reason, which is the mechanism the gate provides for exactly this.

Run:  python Tool\\build_ascii40_copy.py
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from gg_edit import PS1Edit  # noqa: E402

TARGET = Path(__file__).parent / "W11-SecurityHardening-v3-ascii40-2026-08-15-0828.ps1"


def main():
    with PS1Edit(TARGET) as e:
        # 1. The convenience-review line. "decide whether to" -> "decide if you
        #    want to", per CLAUDE.md's substitution table (whether X -> if X).
        #    +4 characters in, 4 trailing spaces out. Length unchanged at 67.
        e.replace(
            '"  and decide whether to KEEP the change or REVERT it:              "',
            '"  and decide if you want to KEEP the change or REVERT it:          "',
            count=1,
            why='banned word: "whether" 1 of 3 -- convenience review (length preserved)')

        # 2. Device Encryption screen 1. Not a box line, so no padding to keep.
        e.replace(
            '"  Press Enter or Space to see whether this PC can use it..."',
            '"  Press Enter or Space to see if this PC can use it..."',
            count=1,
            why='banned word: "whether" 2 of 3 -- Device Encryption pause line')

        # 3. Device Encryption screen 2, SCREEN-81's heading. -5 characters in,
        #    5 trailing spaces back. Length unchanged at 58.
        e.replace(
            '"  HOW TO TELL WHETHER ENCRYPTION IS ACTUALLY RUNNING       "',
            '"  HOW TO TELL IF ENCRYPTION IS ACTUALLY RUNNING            "',
            count=1,
            why='banned word: "whether" 3 of 3 -- SCREEN-81 heading (length preserved)')

        # 4. Gate 24b's remaining finding. Declared, with the reason the gate
        #    requires -- a bare marker is refused by the gate's own regex.
        e.replace(
            '        "  2. Press Enter, then type:  manage-bde -status            ",\n',
            '        "  2. Press Enter, then type:  manage-bde -status            ",  '
            '# GATE24-OK: the user is told to type this. It is the Home-edition '
            'fallback when the Device Encryption page is absent, so removing it '
            'leaves that user a dead end.\n',
            count=1,
            why="gate 24b: declare the one deliberate type-this instruction")

    return 0


if __name__ == "__main__":
    sys.exit(main())
