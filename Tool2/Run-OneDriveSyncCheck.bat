@echo off
REM Dated: 2026-08-06 22:12 ET
REM File: Run-OneDriveSyncCheck.bat (always-current launcher)
REM RUNS: Check-OneDriveSync-2026-08-06.ps1
REM
REM  WHAT IT TELLS YOU: which OneDrive accounts are set up on THIS machine,
REM  and whether the GatewayGuide project tree is present and fully on disk
REM  under each one.
REM
REM  RUN IT ON ALL THREE MACHINES -- CGDELL, SANDY, and SANDY3 -- then compare
REM  the FINGERPRINT line at the bottom of each. Matching fingerprints mean the
REM  machines are carrying the same tree.
REM
REM  READ-ONLY. It reads the registry and counts files. It changes NOTHING,
REM  moves nothing, and deletes nothing. The only file it writes is its own
REM  results file, saved into the Test_Results folder.
REM
REM  DOES NOT NEED ADMINISTRATOR. Just double-click it.
REM
REM  IMPORTANT: this launcher NEVER self-elevates. A self-elevating .bat was
REM  flagged by Malwarebytes as an exploit payload (field-confirmed 2026-07-04).
REM
cd /d "%~dp0"

set "GGPS1=Check-OneDriveSync-2026-08-06.ps1"

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

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo ============================================================
echo   Finished. Nothing on this PC was changed.
echo   Send Claude the results file named in the line above.
echo ============================================================
echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
