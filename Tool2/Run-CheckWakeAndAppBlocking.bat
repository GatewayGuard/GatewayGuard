@echo off
REM Dated: 2026-09-27 09:41 ET
REM File: Run-CheckWakeAndAppBlocking.bat
REM
REM  Shows the two "password on wake" values (plugged in / on battery) and
REM  Defender's unwanted-app blocking setting.
REM  READ-ONLY. Changes nothing. Right-click, Run as administrator.
REM  It NEVER elevates itself.
REM
cd /d "%~dp0"
echo.
net session >nul 2>&1
if %errorlevel%==0 (
  echo   Running as administrator. Good.
) else (
  echo   NOT running as administrator -- the app-blocking line will be refused.
  echo   Close this window, right-click the file, Run as administrator.
)
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Check-WakeAndAppBlocking-2026-09-27.ps1"
echo.
echo   Done. Press Enter to close.
set /p "GGCLOSE="
