@echo off
REM Dated: 2026-09-28 14:08 ET
REM Run-SimpleMistakesCheck.bat -- gate 27, READ-ONLY. Checks every tracked launcher
REM and script for the simple mistakes that have actually happened. Never elevates.
REM It also runs by itself before every commit (git pre-commit hook). To reinstall
REM the hook after a fresh clone: copy Tool2\pre-commit-hook to .git\hooks\pre-commit
cd /d "%~dp0"
if errorlevel 1 (echo PROBLEM: could not open this folder. & goto :done)
powershell -NoProfile -ExecutionPolicy Bypass -File "Check-SimpleMistakes.ps1"
:done
echo.
set /p _x=Press Enter to close this window...
exit /b 0
