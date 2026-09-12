@echo off
REM Dated: 2026-08-13 09:52 EDT
REM File: Run-ConsoleInputModeCheck.bat (always-current launcher)
REM RUNS: Check-ConsoleInputMode-2026-08-13.ps1
REM
REM  WHY IT EXISTS: the ascii39 SANDY run of 2026-08-11 logged
REM  "Discarded 256 keypress(es) that were already queued" eleven times, and
REM  the program ended twice right after a right-click. Bill recorded both as
REM  crashes.
REM
REM  The logs say otherwise. It did not crash -- it EXITED, cleanly, because a
REM  queued input event was consumed as the answer to a prompt where N means
REM  "not my personal PC -- exit".
REM
REM  256 is not a count. It is the drain loop's own ceiling. "Discarded 256"
REM  means the drain hit its cap and stopped with events possibly still
REM  queued, and the next read consumes one of them.
REM
REM  This measures whether mouse input is what fills that queue.
REM
REM  READ-ONLY. It reads the console input mode and counts pending events.
REM  It changes nothing and restores nothing because it sets nothing.
REM
REM  DOES NOT NEED ADMINISTRATOR. Do not run it elevated -- run it exactly the
REM  way Checkup is run, or the console it measures is not the one that fails.
REM
REM  RUN THIS ON SANDY. That is where the defect reproduced. Running it on
REM  CGDELL measures a machine that did not fail.
REM
cd /d "%~dp0"

set "GGPS1=Check-ConsoleInputMode-2026-08-13.ps1"

if not exist "%GGPS1%" (
  echo.
  echo   ERROR: cannot find %GGPS1%
  echo   It should sit in this same folder, next to this launcher.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

REM Report elevation, never change it. Self-elevation is banned -- Malwarebytes
REM flagged a self-elevating launcher as an exploit payload.
net session >nul 2>&1
if %errorlevel%==0 (
  echo   NOTE: this window IS running as Administrator.
  echo         Checkup normally runs elevated too, so this matches.
) else (
  echo   NOTE: this window is NOT running as Administrator.
  echo         That is fine -- this check does not need it.
)
echo.
echo   While the buffer samples run, MOVE THE MOUSE over this window.
echo   That is the whole test: if pending events climb while you only
echo   move the mouse, the queue fills without anyone typing.
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
