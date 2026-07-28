REM Dated: 2026-07-04
@echo off
:: ================================================================
:: Run-GatewayGuard.bat
:: Launcher for GatewayGuard Windows 11 Security Hardening Tool
:: Build: ascii23
::
:: HOW TO RUN:
:: RIGHT-CLICK this file and select "Run as administrator"
:: Click YES when Windows asks to allow changes
:: If you see "Unknown publisher" -- click More info, then Run anyway
:: ================================================================

:: Auto-elevate to Administrator if not already
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo  Requesting Administrator access...
    echo  Click YES on the next prompt to continue.
    echo.
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Launch script from same folder as this .bat file
powershell -ExecutionPolicy Bypass -File "%~dp0W11-SecurityHardening-v3-ascii23-2026-07-04.ps1"

echo.
echo  GatewayGuard session complete.
echo  Press Enter or Space to close this window...
pause >nul
