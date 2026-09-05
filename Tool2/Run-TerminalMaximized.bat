@echo off
REM Dated: 2026-09-04 21:21 ET
REM File: Run-TerminalMaximized.bat
REM
REM  Makes the PowerShell window open FULL SCREEN every time.
REM
REM  Does NOT need administrator. NEVER elevates. Reversible with
REM  Run-TerminalMaximized-Revert.bat.
REM
cd /d "%~dp0"
setlocal
echo.
echo  ==============================================================
echo   OPEN POWERSHELL FULL SCREEN EVERY TIME
echo  ==============================================================
echo.
net session >nul 2>&1
if %errorlevel%==0 (
  echo   Running ELEVATED. Not required -- every change is in your own
  echo   user profile.
) else (
  echo   Running as a normal user. That is correct. Nothing here needs
  echo   administrator rights.
)
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Set-TerminalMaximized-2026-09-04-2121.ps1"
echo.
echo  Press Enter to close this window.
set /p JUNK=
endlocal
