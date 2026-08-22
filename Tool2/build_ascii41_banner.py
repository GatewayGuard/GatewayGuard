"""build_ascii41_banner -- repair the font banner line.

Dated: 2026-08-17 23:55 ET
Editor: Claude Code (CGDELL)

The FT-172 pass removed the orphaned "STEP 1 OF 2" correctly and then padded
the remainder with a clever expression that emitted a trailing "||" and made
the line one character wider than its own border:

    |  SET YOUR CONSOLE FONT (takes 30 seconds)                   ||

The pad arithmetic tried to be general and was simply wrong. This rebuilds the
line from the border instead, which is the only thing it actually has to
agree with: two spaces, a pipe, 62 characters, a pipe.

Lesson, and it is the same one as everywhere else in this build: compute the
width from the thing it must match, never from a hand-counted constant.
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from gg_edit import PS1Edit, EditError  # noqa: E402

TARGET = Path(__file__).parent / "W11-SecurityHardening-v3-ascii41-2026-08-17-2246.ps1"


def main() -> int:
    text = TARGET.read_text(encoding="utf-8-sig").replace("\r\n", "\n")
    src = text.split("\n")

    border = None
    broken = None
    for ln in src:
        if "SET YOUR CONSOLE FONT" in ln and "Write-Host" in ln:
            broken = ln
        if broken is None and "+==============" in ln and "Write-Host" in ln:
            border = ln
    if broken is None:
        raise EditError("could not find the console-font banner line")
    if border is None:
        raise EditError("could not find the banner border line above it")

    # The border is the authority on width: "  +" + N "=" + "+".
    binner = border.split('"')[1]
    inner_w = len(binner) - 4          # drop the two leading spaces, + and +
    if binner.count("=") != inner_w:
        raise EditError(f"border is not the shape expected: {binner!r}")

    text_body = "  SET YOUR CONSOLE FONT (takes 30 seconds)"
    if len(text_body) > inner_w:
        raise EditError(f"banner text {len(text_body)} > {inner_w}")
    new_inner = "  |" + text_body.ljust(inner_w) + "|"
    fixed = broken.replace(broken.split('"')[1], new_inner)

    if len(new_inner) != len(binner):
        raise EditError(f"repaired line {len(new_inner)} != border {len(binner)}")
    print(f"  [width] border {len(binner)}, repaired line {len(new_inner)} -- match")

    with PS1Edit(TARGET) as e:
        e.replace(broken, fixed, count=1,
                  why="repair: banner rebuilt from its own border")
        e.commit()
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except EditError as exc:
        print(f"\nABORTED: {exc}", file=sys.stderr)
        sys.exit(1)
