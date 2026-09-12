@echo off
REM Dated: 2026-09-07 12:35 EDT
REM File: Run-ScanControl.bat
REM
REM  THE CONTROL FOR THE PUA COMPARISON. Run it after Run-PUAComparison.bat
REM  and before the Malwarebytes scan.
REM
REM  It puts the EICAR test string -- 68 bytes of text, not malware, which
REM  every scanner is built to flag -- through the same two paths the six
REM  PUP specimens went through. If EICAR is caught and the PUPs were not,
REM  Defender was looking and simply did not object to them.
REM
REM  It removes its own test files afterwards and says so.
REM
REM  NEVER self-elevates. It reports whether it is elevated and stops if it
REM  needs rights it does not have.
REM
cd /d "%~dp0"

set "GGPS1=Test-ScanControl-2026-09-07.ps1"

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
  echo   This one needs it. Close this window, right-click
  echo   Run-ScanControl.bat and choose 'Run as administrator'.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
) else (
  echo.
  echo   Running as administrator.
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo   Done. Press Enter to close this window.
set /p "GGCLOSE="
