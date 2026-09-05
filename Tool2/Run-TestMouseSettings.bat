@echo off
REM Dated: 2026-09-04 21:03 ET
REM File: Run-TestMouseSettings.bat
REM
REM  Reports every mouse setting this project sets, and says for each one
REM  whether it is actually in force right now.
REM
REM  READ-ONLY. Changes nothing. Does NOT need administrator. NEVER elevates.
REM
cd /d "%~dp0"
setlocal
echo.
echo  ==============================================================
echo   TEST the mouse settings  --  READ ONLY, changes nothing
echo  ==============================================================
echo.
net session >nul 2>&1
if %errorlevel%==0 (
  echo   Running ELEVATED. Not required -- this only reads settings.
) else (
  echo   Running as a normal user. That is correct. Nothing here needs
  echo   administrator rights, because nothing is changed.
)
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Test-MouseSettings-2026-09-04-2103.ps1"
echo.
echo  Press Enter to close this window.
set /p JUNK=
endlocal
