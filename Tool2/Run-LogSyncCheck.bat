@echo off
cd /d "%~dp0"
echo.
echo  GatewayGuard -- why has today^&s log not synced?
echo  READ-ONLY. Changes nothing, uploads nothing.
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Check-LogSync-2026-08-21.ps1"
echo.
set /p _done=Press Enter to close this window...
REM 2026-09-27: set /p leaves errorlevel 1 after an empty Enter, and Windows Terminal
REM keeps a window open on a non-zero exit -- so end cleanly.
exit /b 0
