"""build_ascii41_screen81 -- bring SCREEN-81 back under the 26-line rule.

Dated: 2026-08-17 23:15 ET
Editor: Claude Code (CGDELL)

Gate 12b caught this, which is the whole point of gate 12b. The FT-186 wording
fix turned 3 content lines into 5, pushing SCREEN-81 from 25 to 27 lines --
over Bill's 26-line limit and NOT on the carried baseline, so it failed the
build. Exactly as designed: the ratchet only ever gets shorter.

Two lines come back out, and neither is the fix:

  1. The Settings route is one instruction, so it is one numbered step again
     rather than a step plus a continuation line.
  2. "DO YOU NEED TO REBOOT? No. DO YOU NEED TO QUIT CHECKUP? No." asks the
     reader two questions to deliver one answer. "No, to both."

Result: 25 lines, one under the limit, with a line of headroom for the next
copy edit. The FT-186 instruction itself is unchanged in substance -- type
settings, then search inside Settings.
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from gg_edit import PS1Edit, EditError  # noqa: E402

TARGET = Path(__file__).parent / "W11-SecurityHardening-v3-ascii41-2026-08-17-2246.ps1"


def pad(s: str, width: int) -> str:
    if len(s) > width:
        raise EditError(f"line too long: {len(s)} > {width}\n  {s!r}")
    return s + " " * (width - len(s))


def main() -> int:
    text = TARGET.read_text(encoding="utf-8-sig").replace("\r\n", "\n")
    src = text.split("\n")

    def block(first: int, last: int) -> str:
        return "\n".join(src[first - 1:last])

    A_STEP = block(7343, 7344)      # the split Settings step
    A_REBOOT = block(7354, 7357)    # the two-question paragraph

    for blk, needle in ((A_STEP, "press Enter"), (A_REBOOT, "DO YOU NEED TO REBOOT")):
        if needle not in blk:
            raise EditError(f"anchor is not what it claims -- expected {needle!r}, got {blk[:120]!r}")

    w = len(A_STEP.split("\n")[0]) - len('        "') - len('",')

    with PS1Edit(TARGET) as e:
        e.replace(
            A_STEP,
            '        "' + pad("  1. Press the Windows key, type  settings, press Enter", w) + '",',
            count=1, why="gate 12b: Settings route back to one step")

        e.replace(
            A_REBOOT,
            '        "' + pad("  DO YOU NEED TO REBOOT OR QUIT CHECKUP? No, to both.", w) + '",\n'
            '        "' + pad("  Encryption runs in the background and you can keep", w) + '",\n'
            '        "' + pad("  using the PC. An hour or more is normal on a big drive.", w) + '",',
            count=1, why="gate 12b: one answer, not two questions")
        e.commit()

    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except EditError as exc:
        print(f"\nABORTED: {exc}", file=sys.stderr)
        sys.exit(1)
