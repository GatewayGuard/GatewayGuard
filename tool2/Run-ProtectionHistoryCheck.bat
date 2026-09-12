@echo off
REM Dated: 2026-08-28 10:15 ET
REM File: Run-ProtectionHistoryCheck.bat (always-current launcher)
REM RUNS: Check-ProtectionHistory-2026-08-28.ps1
REM
REM  Writes Defender Protection History to a FILE instead of making you
REM  read it off the screen in the Windows Security app.
REM
REM  Then answers the F4 question: of the twelve AVTestKit specimens,
REM  WHICH were detected, and on which drive? A count of 11 does not
REM  tell you which one got away.
REM
REM  READ-ONLY. Reads three sources and writes one report into
REM  Test_Results. It changes nothing, scans nothing, quarantines
REM  nothing, and releases nothing from quarantine.
REM
REM  NEEDS ADMINISTRATOR -- right-click this file and choose
REM  "Run as administrator". It does NOT self-elevate.
REM
cd /d "%~dp0"

if not exist "Check-ProtectionHistory-2026-08-28.ps1" (
  echo.
  echo   ERROR: cannot find Check-ProtectionHistory-2026-08-28.ps1
  echo   It should sit in this same folder, next to this launcher.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Check-ProtectionHistory-2026-08-28.ps1"

echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
