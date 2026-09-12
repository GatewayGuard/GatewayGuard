@echo off
REM Dated: 2026-08-07 10:08 ET
REM File: Run-RotateBitLockerKey.bat (always-current launcher)
REM RUNS: Rotate-BitLockerKey-2026-08-07.ps1
REM
REM  ******************************************************************
REM   THIS ONE CHANGES YOUR COMPUTER. It is NOT a read-only check.
REM   It replaces the BitLocker recovery key on drive C:.
REM  ******************************************************************
REM
REM  WHY: the current recovery key was found written in plain text inside a
REM  project note, and has since been copied to two OneDrive accounts, a USB
REM  stick, Sandy3 and a local backup. Deleting the note cannot un-copy it.
REM  Replacing the key makes every one of those copies worthless at once.
REM
REM  SAFETY ORDER: it ADDS a new key first, SHOWS it to you, makes you confirm
REM  you have saved it, and only THEN deletes the old one. There is never a
REM  moment when the drive has no recovery key. Stopping part-way leaves you
REM  with two working keys, which is safe.
REM
REM  HAVE A PEN READY. The new key is shown on screen once and is deliberately
REM  never written to any file.
REM
REM  NEEDS ADMINISTRATOR: RIGHT-CLICK this file, choose "Run as administrator",
REM  and answer Yes to the Windows prompt. If you just double-click it, the
REM  script will tell you so and stop without changing anything.
REM
REM  IMPORTANT: this launcher NEVER self-elevates. A self-elevating .bat was
REM  flagged by Malwarebytes as an exploit payload (field-confirmed 2026-07-04).
REM
cd /d "%~dp0"

set "GGPS1=Rotate-BitLockerKey-2026-08-07.ps1"

if not exist "%GGPS1%" (
  echo.
  echo   ERROR: cannot find the rotation script:
  echo     %GGPS1%
  echo.
  echo   It should sit in this same folder, next to this launcher.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

net session >nul 2>&1
if errorlevel 1 (
  echo.
  echo   NOTE: this window is NOT running as administrator.
  echo   The script will stop safely and change nothing.
  echo   Close this, then RIGHT-CLICK the file and pick Run as administrator.
  echo.
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo ============================================================
echo   Finished. Read the RESULT section above before closing.
echo   If it says NOT FINISHED, send the results file to Claude.
echo ============================================================
echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
