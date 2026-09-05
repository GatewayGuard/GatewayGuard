@echo off
REM Dated: 2026-09-04 22:43 ET
REM File: Run-SetTouchpadDrag-Revert.bat
REM
REM  Puts the touchpad's tap-twice-and-drag gesture back on.
REM
REM  Does NOT need administrator. NEVER elevates.
REM
cd /d "%~dp0"
setlocal
echo.
echo  ==============================================================
echo   UNDO -- turn tap-and-drag back on
echo  ==============================================================
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Set-TouchpadDrag-2026-09-04-2243.ps1" -Revert
echo.
echo  Press Enter to close this window.
set /p JUNK=
endlocal
