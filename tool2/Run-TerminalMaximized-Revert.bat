@echo off
REM Dated: 2026-09-04 21:21 ET
REM File: Run-TerminalMaximized-Revert.bat
REM
REM  Puts back what Run-TerminalMaximized.bat changed: the PowerShell
REM  window goes back to opening as a normal window.
REM
REM  Does NOT need administrator. NEVER elevates.
REM
cd /d "%~dp0"
setlocal
echo.
echo  ==============================================================
echo   UNDO -- go back to a normal-sized PowerShell window
echo  ==============================================================
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Set-TerminalMaximized-2026-09-04-2121.ps1" -Revert
echo.
echo  Press Enter to close this window.
set /p JUNK=
endlocal
