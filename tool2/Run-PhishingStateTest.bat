@echo off
REM Dated: 2026-09-07 14:30 EDT
REM File: Run-PhishingStateTest.bat
REM
REM  READ-ONLY on the real phishing protection setting. It only reads it.
REM  The only key it writes is a throwaway of its own under HKCU, which it
REM  deletes and checks is gone.
REM
REM  It asks what you had the switches set to, so the run can be matched up
REM  with what was on screen. Press Enter to skip that.
REM
REM  NEVER self-elevates.
REM
cd /d "%~dp0"

set "GGPS1=Test-PhishingStates-2026-09-07.ps1"

if not exist "%GGPS1%" (
  echo.
  echo   ERROR: cannot find %GGPS1%
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

echo.
echo   In Windows Security, what are the Phishing protection switches set to
echo   right now? A few words is enough, for example:  all four on
echo.
set "GGLABEL="
set /p "GGLABEL=  Setting: "

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%" -Label "%GGLABEL%"

echo.
echo   Done. Press Enter to close this window.
set /p "GGCLOSE="
