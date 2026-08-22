@echo off
REM Dated: 2026-08-20 00:55 ET
REM File: Run-RepoHealthCheck.bat (always-current launcher)
REM RUNS: Check-RepoHealth-2026-08-20.ps1
REM
REM  WHAT IT DOES: checks that the GatewayGuard repository is still sound,
REM  that OneDrive has not written conflict copies of git's own files, and
REM  that every commit is on GitHub. Run it at session end.
REM
REM  READ-ONLY. It changes nothing and deletes nothing.
REM  Needs no administrator. NEVER self-elevates -- a self-elevating .bat was
REM  flagged by Malwarebytes as an exploit payload (field-confirmed 2026-07-04).
cd /d "%~dp0"

set "GGPS1=Check-RepoHealth-2026-08-20.ps1"

if not exist "%GGPS1%" (
  echo.
  echo   ERROR: cannot find %GGPS1%
  echo   It should sit in this same folder, next to this launcher.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
