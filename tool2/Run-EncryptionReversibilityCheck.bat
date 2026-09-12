@echo off
cd /d "%~dp0"
echo.
echo  GatewayGuard -- encryption state and reversibility check
echo  READ-ONLY. This changes nothing on this PC.
echo.
net session >nul 2>&1
if %errorlevel%==0 (echo  Running elevated.) else (echo  Running WITHOUT admin -- that is fine, some rows may say access denied.)
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Check-EncryptionReversibility-2026-08-21.ps1"
echo.
set /p _done=Press Enter to close this window...
