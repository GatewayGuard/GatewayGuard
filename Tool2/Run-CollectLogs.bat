@echo off
REM Dated: 2026-08-12 16:40 ET
REM File: Run-CollectLogs.bat (always-current launcher)
REM RUNS: Collect-CheckupLogs-2026-08-12.ps1
REM
REM  WHAT IT DOES: copies Checkup's run logs out of C:\GatewayGuard\Logs and
REM  into the project's Test_Results folder, where OneDrive syncs them back on
REM  their own. No USB, no copying by hand.
REM
REM  RUN IT ON SANDY OR SANDY3 right after a field test.
REM
REM  COPY ONLY. It never deletes, moves, or changes a log. The originals stay
REM  in C:\GatewayGuard\Logs exactly where Checkup put them. Running it twice
REM  is harmless -- logs already collected are skipped.
REM
REM  DOES NOT NEED ADMINISTRATOR. Just double-click it.
REM
REM  IMPORTANT: this launcher NEVER self-elevates. A self-elevating .bat was
REM  flagged by Malwarebytes as an exploit payload (field-confirmed 2026-07-04).
REM
cd /d "%~dp0"

set "GGPS1=Collect-CheckupLogs-2026-08-12.ps1"

if not exist "%GGPS1%" (
  echo.
  echo   ERROR: cannot find the collect script:
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
echo   Finished. No log was deleted or changed.
echo ============================================================
echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
