"""build_ascii41_localstorage -- logs and the recovery key move to the user's
own profile folder. No cloud.

Dated: 2026-08-18 00:40 ET
Editor: Claude Code (CGDELL)

Bill, 2026-08-18: "No cloud and just use local user's account drive."

WHY THE PROFILE ROOT AND NOT Documents OR Desktop
-------------------------------------------------
Because those two are the exact folders Windows redirects INTO OneDrive.
OneDrive Known Folder Move retargets Desktop, Documents and Pictures, and it
does it silently -- the path still reads C:\\Users\\<name>\\Desktop in casual
use while actually resolving into the cloud.

**measured on CGDELL 2026-08-18**, HKCU User Shell Folders:

    Desktop      C:\\Users\\willi\\OneDrive\\Desktop     <-- IN ONEDRIVE
    Personal     C:\\Users\\willi\\Documents
    My Pictures  C:\\Users\\willi\\OneDrive\\Pictures    <-- IN ONEDRIVE

So "use the local drive" cannot mean Desktop or Documents. It has to be a path
KFM never touches. The profile ROOT is never redirected.

THE BIGGER FIND, AND IT IS NOT THE LOG
--------------------------------------
Save-BitLockerKey has been writing the recovery key to
[Environment]::GetFolderPath('Desktop'). On any machine with KFM on -- which
is the default once OneDrive is set up -- that resolves into OneDrive. **The
most sensitive file Checkup produces has been going to the cloud on every such
machine, and nobody chose that.** It moves with the log.

WHAT DOES NOT MOVE
------------------
C:\\GatewayGuard stays where it is. CLAUDE.md: it is an identifier and a
recovery point, not prose, and the scheduled tasks and the checkpoint file
live there. Renaming it would orphan both. Only the LOG and the KEY move --
the two things the user is asked to find and keep.

ONE EDGE CASE, NAMED NOT SOLVED
-------------------------------
If a standard user elevates Checkup with a DIFFERENT administrator's
credentials, $env:USERPROFILE resolves to that administrator's profile and the
log lands there. On a home PC the user is normally the administrator, and
Checkup requires admin anyway, so a user without admin rights cannot run it at
all. The resolved path is logged and shown on the I screen, so it is at worst
findable rather than lost. Not worth guessing at a fix before a field report
says it happens.
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from gg_edit import PS1Edit, EditError  # noqa: E402

TARGET = Path(__file__).parent / "W11-SecurityHardening-v3-ascii41-2026-08-17-2246.ps1"

BS = chr(92)          # backslash, kept out of the literals below for sanity
Q = chr(34)           # double quote


def main() -> int:
    text = TARGET.read_text(encoding="utf-8-sig").replace("\r\n", "\n")
    src = text.split("\n")

    def find_one(needle):
        hits = [l for l in src if needle in l]
        if len(hits) != 1:
            raise EditError(f"expected 1 line containing {needle!r}, found {len(hits)}")
        return hits[0]

    def boxed(old_line, new_text):
        """Rebuild a box content line at exactly its current width."""
        stripped = old_line.rstrip()
        if not stripped.endswith(Q + ","):
            raise EditError(f"not a box line: {old_line!r}")
        indent = old_line[:len(old_line) - len(old_line.lstrip())]
        inner_w = len(stripped) - len(indent) - 2 - len(",")
        if len(new_text) > inner_w:
            raise EditError(f"{len(new_text)} > {inner_w}: {new_text!r}")
        return indent + Q + new_text.ljust(inner_w) + Q + ","

    with PS1Edit(TARGET) as e:

        # -- 1. the new location, defined beside StateDir -------------------
        e.replace(
            '$StateDir       = "C:' + BS + 'GatewayGuard"',
            '$StateDir       = "C:' + BS + 'GatewayGuard"\n'
            "# Bill, 2026-08-18: \"No cloud and just use local user's account drive.\"\n"
            "# The PROFILE ROOT, deliberately -- not Desktop and not Documents, because\n"
            "# OneDrive Known Folder Move redirects both of those INTO the cloud, and it\n"
            "# does it silently. measured on CGDELL 2026-08-18: Desktop resolved to\n"
            "# C:" + BS + "Users" + BS + "willi" + BS + "OneDrive" + BS + "Desktop while still reading as a local path.\n"
            "# The profile root is never redirected by KFM.\n"
            "# $StateDir itself does NOT move -- CLAUDE.md, it is an identifier and a\n"
            "# recovery point, and the scheduled tasks and checkpoint file live there.\n"
            '$GGUserDir      = Join-Path $env:USERPROFILE "GatewayGuard"',
            count=1, why="no-cloud: define the user-profile folder")

        e.replace(
            find_one("$LogPath        ="),
            "$LogPath        = Join-Path $GGUserDir (\"Logs" + BS
            + "GatewayGuard-Log-\" + (Get-Date -Format 'yyyy-MM-dd_HH-mm') + \".txt\")",
            count=1, why="no-cloud: the log lands in the user's own folder")

        # -- 2. the recovery key comes off the Desktop ----------------------
        e.replace(
            find_one("$global:BitLockerKeyPath ="),
            "    # Bill, 2026-08-18: no cloud. This wrote to GetFolderPath('Desktop'),\n"
            "    # which on any machine with OneDrive Known Folder Move resolves INTO\n"
            "    # OneDrive -- measured on CGDELL, C:" + BS + "Users" + BS + "willi" + BS + "OneDrive" + BS + "Desktop.\n"
            "    # The recovery key is the most sensitive file Checkup produces and it\n"
            "    # has been going to the cloud on every such machine by accident. The\n"
            "    # user is taken to this folder on screen, so it is no harder to find.\n"
            "    if (-not (Test-Path $GGUserDir)) { New-Item -Path $GGUserDir -ItemType Directory -Force | Out-Null }\n"
            "    $global:BitLockerKeyPath = Join-Path $GGUserDir (\"BitLocker-Recovery-Key-\""
            " + (Get-Date -Format 'yyyy-MM-dd') + \".txt\")   # FT-75",
            count=1, why="no-cloud: recovery key off the Desktop")

        # -- 3. Open-My-Log.bat follows the log -----------------------------
        e.replace(
            "            if (-not (Test-Path $StateDir)) { New-Item -Path $StateDir -ItemType Directory -Force | Out-Null }",
            "            if (-not (Test-Path $GGUserDir)) { New-Item -Path $GGUserDir -ItemType Directory -Force | Out-Null }",
            count=1, why="no-cloud: opener folder follows the log")
        e.replace(
            '            $ggOpenerBody | Out-File -FilePath (Join-Path $StateDir "Open-My-Log.bat") -Encoding ascii -Force',
            '            $ggOpenerBody | Out-File -FilePath (Join-Path $GGUserDir "Open-My-Log.bat") -Encoding ascii -Force',
            count=1, why="no-cloud: opener sits beside the logs")

        # -- 4. every user-facing box line that named the old path ----------
        for needle, new_text in (
            ("log file in C:" + BS + "GatewayGuard" + BS + "Logs.",
             "     log file in your GatewayGuard folder. Press I to see it."),
            ("in C:" + BS + "GatewayGuard" + BS + "Logs. If you ever need help, that",
             "  in your own GatewayGuard folder. If you need help, that"),
            ("A complete log is saved to C:" + BS + "GatewayGuard" + BS + "Logs" + BS + " after each run.",
             "  A complete log is saved to your GatewayGuard folder each run."),
            ("Log saved to C:" + BS + "GatewayGuard" + BS + "Logs" + BS + ".",
             "  Log saved to your GatewayGuard folder."),
        ):
            line = find_one(needle)
            e.replace(line, boxed(line, new_text), count=1,
                      why="no-cloud copy: " + new_text.strip()[:42])

        # -- 5. the dynamic ones can print the real path --------------------
        e.replace(
            find_one("Log saved to C:" + BS + "GatewayGuard" + BS + "Logs" + BS + ": $(Split-Path"),
            '        "  Log saved to: $(Split-Path $LogPath -Parent)",',
            count=1, why="no-cloud: print the real log folder")

        for colour in ("DarkGray", "Yellow"):
            old = ("Check the GatewayGuard log (C:" + BS + "GatewayGuard" + BS
                   + "Logs) in the morning." + Q + " -ForegroundColor " + colour)
            new = "Check your GatewayGuard log in the morning." + Q + " -ForegroundColor " + colour
            e.replace(old, new, count=1, why="no-cloud copy: sleep note (" + colour + ")")

        e.replace(
            "Log saved to C:" + BS + "GatewayGuard" + BS + "Logs" + BS + " after run." + Q,
            "Log saved to your GatewayGuard folder after run." + Q,
            count=1, why="no-cloud copy: GUI label")

        # -- 6. the I screen names the real folder --------------------------
        e.replace(
            find_one("Open the folder  C:" + BS + "GatewayGuard  and double-click"),
            '            ("  Open this folder:  " + $GGUserDir),\n'
            '            "  and double-click  Open-My-Log.bat                          ",',
            count=1, why="no-cloud: the I screen shows the real folder")

        # -- 7. the header comment ------------------------------------------
        e.replace(
            "    All actions logged to C:" + BS + "GatewayGuard" + BS + "Logs" + BS + " (with a backup copy in",
            "    All actions logged to <your user folder>" + BS + "GatewayGuard" + BS + "Logs" + BS + " -- Bill,\n"
            "    2026-08-18, no cloud. The profile ROOT is used because OneDrive Known\n"
            "    Folder Move redirects Desktop and Documents into the cloud silently.\n"
            "    (with a backup copy in",
            count=1, why="no-cloud: header doc")

        e.commit()

    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except EditError as exc:
        print(f"\nABORTED: {exc}", file=sys.stderr)
        sys.exit(1)
