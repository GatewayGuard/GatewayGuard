@echo off
REM Dated: 2026-08-19 18:10 EDT
REM File: Run-MarkModeTest.bat
REM
REM  Answers ONE question for FT-193: does using Mark mode hand
REM  ENABLE_MOUSE_INPUT back after Checkup has cleared it?
REM
REM  Read-only on your PC. It changes only this window and puts it back.
REM  Does NOT need administrator. NEVER self-elevates.
REM
cd /d "%~dp0"

net session >/dev/null 2>&1
if errorlevel 1 (
  echo.
  echo   NOTE: this window is NOT running as administrator. That is fine.
  echo.
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Test-MarkModeResets-2026-08-19.ps1"

echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
