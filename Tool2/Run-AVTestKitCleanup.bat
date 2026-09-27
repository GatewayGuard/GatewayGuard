@echo off
cd /d "%~dp0"
echo.
echo  GatewayGuard -- remove the AV test kit specimens
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Remove-AVTestKit-2026-08-21.ps1"
echo.
set /p _done=Press Enter to close this window...
REM 2026-09-27: set /p leaves errorlevel 1 after an empty Enter, and Windows Terminal
REM keeps a window open on a non-zero exit -- so end cleanly.
exit /b 0
