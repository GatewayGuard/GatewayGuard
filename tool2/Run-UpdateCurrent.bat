@echo off
REM Dated: 2026-08-12 17:05 ET
REM File: Run-UpdateCurrent.bat (always-current launcher)
REM RUNS: Update-Current.ps1
REM
REM  WHAT IT DOES: rewrites ProjectDocs\CURRENT.md so it names the newest
REM  version of every governing document. Claude Cloud cannot list a folder,
REM  so it needs one fixed filename to follow. This keeps that file honest.
REM
REM  Run it at session end, after any document is replaced with a new date.
REM
REM  READ-ONLY except for ProjectDocs\CURRENT.md. Needs no administrator.
REM  NEVER self-elevates -- a self-elevating .bat was flagged by Malwarebytes
REM  as an exploit payload (field-confirmed 2026-07-04).
cd /d "%~dp0"

set "GGPS1=Update-Current.ps1"

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
