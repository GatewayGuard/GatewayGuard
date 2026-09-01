@echo off
REM Dated: 2026-08-31 20:36 EDT
REM File: Run-CheckStoreDomain.bat
REM Runs: Check-StoreDomain-2026-08-31.ps1  (same folder)
REM
REM  READ-ONLY. Looks up DNS and reports. Changes nothing, here or at Namecheap.
REM  This launcher NEVER self-elevates -- a self-elevating .bat was flagged by
REM  Malwarebytes as an exploit payload (field-confirmed 2026-07-04).
REM
cd /d "%~dp0"

set "GGPS1=Check-StoreDomain-2026-08-31.ps1"

if not exist "%GGPS1%" (
  echo.
  echo   ERROR: cannot find the check script:
  echo     %GGPS1%
  echo.
  echo   It should sit in this same folder, next to this launcher.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

REM  Report elevation rather than elevating. This check does not need it.
net session >nul 2>&1
if errorlevel 1 (
  echo.
  echo   NOTE: not running as administrator. That is fine -- this check
  echo   does not need it.
  echo.
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
exit /b 0
