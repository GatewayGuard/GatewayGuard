@echo off
REM Dated: 2026-08-19 18:30 EDT
REM File: Run-GatewayGuard.bat (always-current launcher -- paired build below)
REM CURRENT BUILD: W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1   (lives in ..\Tool\)
REM
REM  To review every screen without running any checks, use the companion
REM  launcher Show-AllScreens.bat instead (gallery mode -- changes nothing).
REM
REM  IMPORTANT: This launcher NEVER self-elevates. A self-elevating .bat
REM  was flagged by Malwarebytes as an exploit payload (field-confirmed
REM  2026-07-04). To run: RIGHT-CLICK this file -> Run as administrator.
REM
cd /d "%~dp0"

set "GGBUILD=..\Tool\W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1"

REM  Gate 6 / audit item 10: this launcher names its build explicitly, so a
REM  stale reference is a silent failure -- it would launch nothing and the
REM  window would blink shut. Say so plainly instead.
if not exist "%GGBUILD%" (
  echo.
  echo   ERROR: cannot find the Checkup program file:
  echo     %GGBUILD%
  echo.
  echo   It should sit in this same folder, next to this launcher.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

REM  Report elevation rather than elevating (see the Malwarebytes note above).
net session >nul 2>&1
if errorlevel 1 (
  echo.
  echo   NOTE: this window is NOT running as administrator.
  echo   Checkup will show you how to relaunch it correctly.
  echo.
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGBUILD%"
