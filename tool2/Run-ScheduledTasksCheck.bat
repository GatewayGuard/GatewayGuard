@echo off
REM Dated: 2026-08-02 06:14 EDT
REM File: Run-ScheduledTasksCheck.bat (always-current launcher)
REM RUNS: Check-ScheduledTasks-2026-08-02.ps1  (rev 2)
REM
REM  FT-109 / gate 21: confirms the two GatewayGuard scheduled tasks really
REM  exist AND that their action paths point at programs that really exist.
REM  A task can look perfectly healthy in Task Scheduler and still be aimed
REM  at a program that is not there -- that is the defect this checks for.
REM
REM  READ-ONLY. It creates no task, changes no task, deletes no task, and
REM  touches no setting. It writes ONE text file next to this launcher.
REM
REM  DOES NOT NEED ADMINISTRATOR.
REM
REM  IMPORTANT: this launcher NEVER self-elevates. A self-elevating .bat was
REM  flagged by Malwarebytes as an exploit payload (field-confirmed
REM  2026-07-04). It reports whether it is elevated; it does not elevate.
REM
cd /d "%~dp0"

set "GGPS1=Check-ScheduledTasks-2026-08-02.ps1"

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
  echo   Running WITHOUT administrator. That is fine for this check.
  echo.
) else (
  echo.
  echo   Running as administrator.
  echo.
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
