@echo off
REM Dated: 2026-08-02 14:35 EDT
REM File: Run-FreeSpaceWipeCheck.bat (always-current launcher)
REM RUNS: Check-FreeSpaceWipe-2026-08-02.ps1
REM
REM  *** THIS CANNOT WIPE ANYTHING. IT ONLY LOOKS. ***
REM
REM  The wipe half was deliberately REMOVED on 2026-08-02, at Bill's
REM  direction, until encryption field testing is finished. SANDY's
REM  encryption is a one-shot measurement, and a wipe started by accident
REM  would run for hours and destroy it. During that window the safest tool
REM  is one that CANNOT do the destructive thing, not one that asks first.
REM
REM  To restore the wipe half later, see the preserved copies in
REM  scratchpad\wipe-capability-removed-2026-08-02\ -- restore the .ps1 and
REM  the .bat together.
REM
REM  WHAT IT REPORTS: the fixed drives, the real disk behind the one you
REM  pick, whether it is a hard drive or solid state, which Windows wipe
REM  command is available on this edition, and how long a wipe would take.
REM
REM  DOES NOT NEED ADMINISTRATOR. Nothing here writes.
REM
REM  This launcher NEVER self-elevates (Malwarebytes exploit-payload flag,
REM  2026-07-04).
REM
cd /d "%~dp0"

set "GGPS1=Check-FreeSpaceWipe-2026-08-02.ps1"

if not exist "%GGPS1%" (
  echo.
  echo   ERROR: cannot find %GGPS1%
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

cls
echo.
echo   ================================================================
echo    FREE-SPACE WIPE -- LOOK ONLY
echo   ================================================================
echo.
echo    THIS TOOL CANNOT WIPE ANYTHING. It only reads and reports.
echo.
echo    You will see: the drive type, how much free space there is,
echo    which Windows command would do the job on this PC, and an
echo    estimate of how long it would take.
echo.
echo    The wipe itself was deliberately removed from this version
echo    until the encryption testing is finished. Nothing you type
echo    here can start one.
echo.
echo   ================================================================
echo.

echo   The fixed drives on this PC:
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"
echo.

set "GGDRIVE="
echo   Which drive should I LOOK AT?  (for example, type  D  then Enter)
echo   This only looks. It writes nothing. It cannot wipe.
echo   Press Enter on its own to quit.
echo.
set /p "GGDRIVE=  Drive letter: "
if not defined GGDRIVE (
  echo.
  echo   Nothing was done.
  goto :done
)

echo.
echo   ---------------- LOOKING AT %GGDRIVE% ----------------
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%" -Drive "%GGDRIVE%"

:done
echo.
echo   The report is saved in this folder as
echo   FreeSpaceWipe-COMPUTERNAME-DATE.txt
echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
