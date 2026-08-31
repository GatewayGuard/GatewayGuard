@echo off
cd /d "%~dp0"
setlocal
echo.
echo  ==============================================================
echo   REVERT the mouse drag threshold back to the Windows default
echo  ==============================================================
echo.
net session >nul 2>&1
if %errorlevel%==0 (
  echo   Running ELEVATED. Not required for this script -- it only
  echo   changes your own user setting.
) else (
  echo   Running as a normal user. That is correct -- this script
  echo   changes only your own setting and needs no admin rights.
)
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Set-DragThreshold-2026-08-31-0943.ps1" -Revert
echo.
echo  Press Enter to close this window.
set /p JUNK=
endlocal
