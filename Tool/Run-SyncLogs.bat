@echo off
cd /d "%~dp0"
echo.
echo  GatewayGuard -- copy Checkup logs into OneDrive
echo  ------------------------------------------------
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Sync-Logs.ps1"
echo.
echo  Finished. Press Enter to close this window.
set /p _dummy=
exit /b 0
