@echo off
:: ================================================================
:: Run-Diagnostic.bat
:: Launcher for GatewayGuard System Baseline Diagnostic
::
:: HOW TO RUN:
:: RIGHT-CLICK this file and select "Run as administrator"
:: Click YES when Windows asks to allow changes
:: If you see "Unknown publisher" -- click More info, then Run anyway
::
:: PURPOSE:
:: Captures your system baseline BEFORE running GatewayGuard.
:: Run this first, review the results, then run GatewayGuard.
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

:: Launch diagnostic script from same folder as this .bat file
powershell -ExecutionPolicy Bypass -File "%~dp0GatewayGuard_SystemBaseline_Diagnostic.ps1"

echo.
echo  GatewayGuard Diagnostic complete.
echo  Press any key to close this window...
pause >nul
