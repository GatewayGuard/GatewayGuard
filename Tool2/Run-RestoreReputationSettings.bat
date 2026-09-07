@echo off
REM Dated: 2026-09-07 13:05 EDT
REM File: Run-RestoreReputationSettings.bat
REM
REM  Puts the reputation settings back exactly as they were found,
REM  including deleting the ones that did not exist before.
REM
REM  NEVER self-elevates.
REM
cd /d "%~dp0"

set "GGPS1=Restore-ReputationSettings-2026-09-07.ps1"

if not exist "%GGPS1%" (
  echo.
  echo   ERROR: cannot find %GGPS1%
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
  echo   Run-RestoreReputationSettings.bat and choose 'Run as administrator'.
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
