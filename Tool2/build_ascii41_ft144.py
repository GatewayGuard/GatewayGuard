"""build_ascii41_ft144 -- remove FT-144's warning from Checkup.

Dated: 2026-08-18 00:05 ET
Editor: Claude Code (CGDELL)

Bill, 2026-08-17: "144 eliminate it from Checkup and the guide. If user has
agreed and then panics, too bad."

WHY IT GOES
-----------
FT-144 was recorded on 2026-07-29 as "Sandy encrypted ITSELF on a local
account, with the key saved nowhere." Bill established on 2026-08-17 that he
STARTED that encryption himself and later cancelled it. So the scenario the
warning describes -- a PC encrypting spontaneously and stranding its own key --
was never observed. The sentence "We have seen exactly that happen on a real
PC" is not true, and it is on screen.

What remains after removing the false part is a paragraph pushing the user
toward a Microsoft account. That is worth removing on its own merits:

  * It is a DEAD END for anyone who will not create a Microsoft account, and
    "no dead ends" is a standing rule in CLAUDE.md.
  * It is wrong about the mechanism anyway -- research 2026-08-17 confirms the
    Microsoft account governs only where the key is BACKED UP, never whether
    encryption may proceed.
  * On Home, Checkup does not encrypt anything. It shows the user the Settings
    path, and Windows' own flow prompts for the key. The warning describes a
    gap in someone else's UI, three screens before the user reaches it.

WHAT STAYS, AND WHY IT MUST
---------------------------
The core safety message is NOT FT-144 and is untouched: what a recovery key
is, when Windows asks for it, and that without it the files are gone. Also
kept: the timing point, that the key appears when encryption STARTS. Those
are the facts a user needs to act on. Only the account-type warning goes.

THE GUIDE HALF IS ALREADY DONE. Measured 2026-08-17: the FT-144 language
appears in no .html guide page and not in the new GuideRewrite draft. It
reached only this build and three internal governing documents.
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

    def block(a, b):
        return "\n".join(src[a - 1:b])

    A_SWITCH = block(7378, 7382)     # the $ggAcctLine switch
    A_BODY = block(7392, 7402)       # acct line + the two FT-144 paragraphs

    for blk, needle in ((A_SWITCH, "ggAcctLine"), (A_BODY, "DOES NOT FORCE")):
        if needle not in blk:
            raise EditError(f"anchor is not what it claims -- want {needle!r}, got {blk[:120]!r}")

    with PS1Edit(TARGET) as e:
        e.replace(
            A_SWITCH,
            "    # FT-144 REMOVED (ascii41, Bill 2026-08-17). The account-type line and\n"
            "    # the warning it introduced are gone -- see build_ascii41_ft144.py for\n"
            "    # the full reasoning. Get-SignInAccountType is still called above: it\n"
            "    # is logged, and it still decides between SCREEN-80 and SCREEN-82.",
            count=1, why="FT-144: drop the account-type line on SCREEN-79")

        e.replace(
            A_BODY,
            '        "  Windows shows you the key when encryption STARTS, not when   ",\n'
            '        "  it finishes. Look for it as soon as it begins -- not hours   ",\n'
            '        "  later. Print it, or copy it to a USB drive, and keep that    ",\n'
            '        "  away from this computer.                                     "',
            count=1, why="FT-144: remove the warning, keep the key advice")
        e.commit()

    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except EditError as exc:
        print(f"\nABORTED: {exc}", file=sys.stderr)
        sys.exit(1)
