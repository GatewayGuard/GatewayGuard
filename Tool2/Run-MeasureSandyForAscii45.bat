@echo off
REM Dated: 2026-09-25 15:40 ET
REM File: Run-MeasureSandyForAscii45.bat
REM
REM  The six SANDY measurements the ascii45 build depends on
REM  (FieldTestTriage-ascii44run1, Part 7).
REM
REM  READ-ONLY. Changes nothing. It opens one Windows Security page and asks
REM  you to flip one setting in Settings and flip it back.
REM  NEEDS ADMINISTRATOR for two of the steps: right-click this file and
REM  choose Run as administrator. It NEVER elevates itself.
REM
cd /d "%~dp0"

echo.
echo   ==============================================================
echo    SANDY MEASUREMENTS FOR ascii45 -- read-only
echo   ==============================================================
echo.
net session >nul 2>&1
if %errorlevel%==0 (
  echo   Running as administrator. Good -- all six steps can run.
) else (
  echo   NOT running as administrator. Two steps will be refused.
  echo   Close this window, right-click the file, Run as administrator.
)
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Measure-SandyForAscii45-2026-09-25.ps1"

echo.
echo   Done. The results file is in Test_Results. Press Enter to close.
set /p "GGCLOSE="