@echo off
REM Dated: 2026-08-27 13:05 ET
REM File: Run-FullScanCoverageCheck.bat (always-current launcher)
REM RUNS: Check-FullScanCoverage-2026-08-27.ps1
REM
REM  Answers ONE question: did the Defender FULL SCAN actually cover D: ?
REM  That is the gate-24 prerequisite for F4 -- until it is answered with
REM  measured evidence, no Checkup screen may claim to cover any drive
REM  but C:.
REM
REM  READ-ONLY. Reads three sources and writes one report into
REM  Test_Results. It changes nothing, scans nothing, starts nothing.
REM
REM  NEEDS ADMINISTRATOR to read the MPLog folder -- that is the section
REM  that answers the question. Right-click this file and choose
REM  "Run as administrator". It does NOT self-elevate.
REM
cd /d "%~dp0"

if not exist "Check-FullScanCoverage-2026-08-27.ps1" (
  echo.
  echo   ERROR: cannot find Check-FullScanCoverage-2026-08-27.ps1
  echo   It should sit in this same folder, next to this launcher.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Check-FullScanCoverage-2026-08-27.ps1"

echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
