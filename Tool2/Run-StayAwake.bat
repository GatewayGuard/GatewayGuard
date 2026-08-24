@echo off
REM Run-StayAwake.bat -- keep this machine running with the display off.
REM Pass  undo  to put the power settings back:   Run-StayAwake.bat undo
REM Does NOT self-elevate. Reports elevation and stops if it is missing.
cd /d "%~dp0"

set GGARG=
if /i "%~1"=="undo" set GGARG=-Undo

echo.
echo   Running Set-StayAwake...
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Set-StayAwake-2026-08-24.ps1" %GGARG%

echo.
set /p GGDONE=  Press Enter to close this window. 
