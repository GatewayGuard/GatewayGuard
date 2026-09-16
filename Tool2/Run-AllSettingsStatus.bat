@echo off
REM Dated: 2026-09-16 13:40 EDT
REM File: Run-AllSettingsStatus.bat
REM
REM  Runs Checkup's OWN status-detection code for all 19 settings in one
REM  pass and prints the result. Built as the "did this build change break
REM  anything" checker: run it before a build change, run it again after,
REM  and compare.
REM
REM  READ-ONLY. Calls the same functions Checkup uses to READ your
REM  settings. Never calls the function that changes anything. Nothing on
REM  this PC is modified by running this.
REM
REM  Does NOT need administrator, but a few settings (BitLocker, some
REM  Defender reads) report more when run as admin -- the same way Checkup
REM  itself does. NEVER self-elevates.
REM
cd /d "%~dp0"

echo.
echo   ==============================================================
echo    ALL SETTINGS STATUS -- via Checkup's own code, read-only
echo   ==============================================================
echo.
net session >nul 2>&1
if %errorlevel%==0 (
  echo   Running ELEVATED -- a few settings will read more completely.
) else (
  echo   Running as a normal user. That is fine -- some settings may
  echo   show "needs admin" the same way they would in Checkup itself.
)
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Check-AllSettingsStatus-2026-09-16.ps1"

echo.
echo   Done. Press Enter to close this window.
set /p "GGCLOSE="
