@echo off
REM Dated: 2026-08-19 23:45 ET
REM File: Run-FileDeleteCheck.bat (always-current launcher)
REM RUNS: Check-FileDelete-2026-08-19.ps1
REM
REM  WHAT IT DOES: finds out what deleted Show-AllScreens.bat. It asks
REM  Microsoft Defender, Malwarebytes, the Recycle Bin and OneDrive, and it
REM  decodes the Recycle Bin index files so a renamed entry is still readable.
REM
REM  READ-ONLY. It changes nothing and deletes nothing.
REM  Needs no administrator. NEVER self-elevates -- a self-elevating .bat was
REM  flagged by Malwarebytes as an exploit payload (field-confirmed 2026-07-04).
cd /d "%~dp0"

set "GGPS1=Check-FileDelete-2026-08-19.ps1"

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
if %errorlevel%==0 (
  echo   Running as administrator. That is fine, but it is not needed.
) else (
  echo   Running as a normal user. That is all this needs.
)
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
