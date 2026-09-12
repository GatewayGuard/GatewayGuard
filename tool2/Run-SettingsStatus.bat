@echo off
REM Dated: 2026-09-08 16:30 EDT
REM File: Run-SettingsStatus.bat
REM
REM  Reports, for every Checkup setting: can Checkup READ it, can Checkup
REM  CHANGE it, and what it is set to on THIS PC right now.
REM
REM  READ-ONLY. It changes nothing at all.
REM
REM  Run it as a normal user first. A few rows need administrator to read
REM  (BitLocker is the main one) -- those say so rather than guessing, so
REM  you can run it again as administrator if you want those filled in.
REM
REM  NEVER self-elevates.
REM
cd /d "%~dp0"

set "GGPS1=Check-SettingsStatus-2026-09-08.ps1"

if not exist "%GGPS1%" (
  echo.
  echo   ERROR: cannot find %GGPS1%
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo   Done. Press Enter to close this window.
set /p "GGCLOSE="
