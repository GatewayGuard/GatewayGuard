"""build_ascii41_logopener -- FT-189, part 2: the file the user can open.

Dated: 2026-08-17 23:05 ET
Editor: Claude Code (CGDELL)

Bill, 2026-08-17: "...or a file the user can open in Notepad."

Checkup WRITES this launcher at startup rather than it being shipped beside
the .ps1. That is deliberate: the log lives in C:\\GatewayGuard\\Logs, and a
helper that opens the log has to sit where the log is, not where the program
happens to have been run from. Shipping it in Tool\\ would put it in whatever
folder the installer or the user chose, which is the one place a senior will
not look.

The .bat obeys the launcher rules in CLAUDE.md: no date in the name,
cd /d "%~dp0", never self-elevates, no cmd `pause` (it prints the banned
"press any key"), an Enter-only wait on the failure path, and CRLF endings.
It is read-only -- it opens Notepad and changes nothing.
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from gg_edit import PS1Edit, EditError  # noqa: E402

TARGET = Path(__file__).parent / "W11-SecurityHardening-v3-ascii41-2026-08-17-2246.ps1"

ANCHOR = (
    "        $logDir = Split-Path $LogPath -Parent\n"
    "        if (-not (Test-Path $logDir)) { New-Item -Path $logDir -ItemType Directory -Force | Out-Null }\n"
    "        $header = @\""
)

ADDITION = r'''        $logDir = Split-Path $LogPath -Parent
        if (-not (Test-Path $logDir)) { New-Item -Path $logDir -ItemType Directory -Force | Out-Null }
        # FT-189 (ascii41): write the log opener beside the logs, every launch.
        # Bill, 2026-08-17: "or a file the user can open in Notepad." The file
        # half of that request was already 90% built and 0% delivered -- the log
        # header has carried the build, computer, Machine ID and run date since
        # ascii28, at a path no senior is going to navigate to. This puts a
        # double-clickable opener next to it. Rewritten every run so a damaged
        # or deleted copy repairs itself. Read-only: it opens Notepad, nothing
        # more. NEVER self-elevates -- the Malwarebytes exploit-payload flag
        # from 2026-07-04 stands.
        try {
            if (-not (Test-Path $StateDir)) { New-Item -Path $StateDir -ItemType Directory -Force | Out-Null }
            $ggOpenerBody = @'
@echo off
REM  GatewayGuard -- opens your most recent Checkup log in Notepad.
REM  Written automatically by Checkup. Safe to double-click at any time.
REM  This file only READS your log. It changes nothing on your PC.
cd /d "%~dp0"
set "GGLOG="
for /f "delims=" %%F in ('dir /b /o-d "Logs\GatewayGuard-Log-*.txt" 2^>nul') do (
  if not defined GGLOG set "GGLOG=Logs\%%F"
)
if not defined GGLOG (
  echo.
  echo   No Checkup log was found in this folder:
  echo     %~dp0Logs
  echo.
  echo   A log is created the first time you run Checkup.
  echo   If you have run Checkup before, the folder may have been moved.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)
start "" notepad.exe "%GGLOG%"
'@
            $ggOpenerBody | Out-File -FilePath (Join-Path $StateDir "Open-My-Log.bat") -Encoding ascii -Force
        } catch {}
        $header = @"'''


def main() -> int:
    with PS1Edit(TARGET) as e:
        e.replace(ANCHOR, ADDITION, count=1,
                  why="FT-189: Checkup writes Open-My-Log.bat beside the logs")
        e.commit()
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except EditError as exc:
        print(f"\nABORTED: {exc}", file=sys.stderr)
        sys.exit(1)
