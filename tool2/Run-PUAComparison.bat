@echo off
REM Dated: 2026-09-07 12:16 EDT
REM File: Run-PUAComparison.bat
REM
REM  NOT read-only. Adds a Defender exclusion for the test folder, copies
REM  six known PUP installers into it, and runs a Defender scan that
REM  reports without acting. Nothing is ever executed.
REM
REM  Undo: Run-PUATestCleanup.bat
REM
REM  NEVER self-elevates. It reports whether it is elevated and stops
REM  if it needs rights it does not have.
REM
cd /d "%~dp0"

set "GGPS1=Test-PUAComparison-2026-09-07.ps1"

if not exist "%GGPS1%" (
  echo.
  echo   ERROR: cannot find %GGPS1%
  echo   It should sit in this same folder, next to this launcher.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

net session >nul 2>&1
if errorlevel 1 (
  echo.
  echo   NOT running as administrator.

  echo   This one needs it. Close this window, right-click
  echo   Run-PUAComparison.bat and choose 'Run as administrator'.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
) else (
  echo.
  echo   Running as administrator.
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo   Done. Press Enter to close this window.
set /p "GGCLOSE="
