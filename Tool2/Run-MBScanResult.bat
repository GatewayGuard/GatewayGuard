@echo off
REM Dated: 2026-09-07 12:16 EDT
REM File: Run-MBScanResult.bat
REM
REM  READ-ONLY. Reads the newest Malwarebytes scan record and prints what
REM  it found. Scans nothing, changes nothing, deletes nothing.
REM
REM  NEVER self-elevates. It reports whether it is elevated and stops
REM  if it needs rights it does not have.
REM
cd /d "%~dp0"

set "GGPS1=Read-MBScanResult-2026-09-07.ps1"

if not exist "%GGPS1%" (
  echo.
  echo   ERROR: cannot find %GGPS1%
  echo   It should sit in this same folder, next to this launcher.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

net session >nul 2>&1
if errorlevel 1 (
  echo.
  echo   NOT running as administrator.

  echo   That is fine -- this one does not need it.
) else (
  echo.
  echo   Running as administrator.
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo   Done. Press Enter to close this window.
set /p "GGCLOSE="
