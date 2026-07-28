@echo off
:: ================================================================
:: Run-GatewayGuard.bat
:: Launcher for GatewayGuard Windows 11 Security Hardening Tool
:: Build: ascii18
:: Double-click this file to run -- no CMD needed.
:: ================================================================

:: Auto-elevate to Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Administrator access...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Launch the script from the same folder as this .bat file
powershell -ExecutionPolicy Bypass -File "%~dp0W11-SecurityHardening-v3-ascii18.ps1"

pause
