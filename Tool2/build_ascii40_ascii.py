"""build_ascii40_ascii -- pre-build item 5, taken to an actual zero.

Dated: 2026-08-15 09:12 ET
Editor: Claude Code (CGDELL)

Pre-Build Checklist item 5: "Confirm ASCII conversion replaces all Unicode
characters before output."

measured 2026-08-15 on ascii40 before this pass: 36 non-ASCII characters, all
of them U+2500 BOX DRAWINGS LIGHT HORIZONTAL, four to a line across nine
comment separator lines. Zero on any line that is not a comment, so nothing
here was ever rendered to a user.

THIS IS A LINT PASS AND IT STILL GOES THROUGH THE WRAPPER. CLAUDE.md: "No
cosmetic exemption -- lint, comment, and whitespace passes are in scope.
Violating this on a lint pass corrupted ascii34 on 2026-07-25." A bulk raw
string replace on comment characters is the exact shape of the edit that
turned a 341 KB file into 13.7 MB of perfectly brace-balanced wreckage.

WHY BOTHER AT ALL, GIVEN NOTHING RENDERS THEM. Because item 5 currently
returns 36 and a human has to re-decide every build that those particular 36
are harmless. A check whose pass condition is "36, but I looked" is a check
that will eventually wave through the 37th. Zero is a condition a script can
hold.

Run:  python Tool\\build_ascii40_ascii.py
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from gg_edit import PS1Edit  # noqa: E402

TARGET = Path(__file__).parent / "W11-SecurityHardening-v3-ascii40-2026-08-15-0828.ps1"

BOX_DASH_PAIR = "──"   # the separator is always four, i.e. two pairs
ASCII_PAIR = "--"                # the convention this file already uses everywhere


def main():
    with PS1Edit(TARGET) as e:
        e.replace(BOX_DASH_PAIR, ASCII_PAIR, count=18,
                  why="item 5: U+2500 -> '--' on 9 comment separator lines (18 pairs, 36 chars)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
