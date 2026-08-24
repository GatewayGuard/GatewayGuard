@echo off
REM Run-SandyChecks.bat -- collect every open SANDY measurement in one pass.
REM READ-ONLY. Changes nothing. Writes one report into Test_Results.
REM Works without administrator; three checks need it and will say so.
REM Does NOT self-elevate. To get everything: right-click > Run as administrator.
cd /d "%~dp0"

echo.
echo   Collecting SANDY answers. Nothing on this PC will be changed.
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Check-SandyQuestions-2026-08-24.ps1"

echo.
set /p GGDONE=  Press Enter to close this window. 
