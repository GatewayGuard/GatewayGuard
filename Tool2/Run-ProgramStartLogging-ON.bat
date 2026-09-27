@echo off
REM Dated: 2026-09-27 18:02 ET
REM File: Run-ProgramStartLogging-ON.bat
REM
REM  Turns ON recording of every program that starts (with its command line) and makes the Security log 100 MB. Undo: Run-ProgramStartLogging-OFF.bat.
REM  CHANGES WINDOWS SETTINGS. Right-click, Run as administrator.
REM  It NEVER elevates itself.
REM
cd /d "%~dp0"
echo.
net session >nul 2>&1
if %errorlevel%==0 (
  echo   Running as administrator. Good.
) else (
  echo   NOT running as administrator -- nothing will be changed.
  echo   Close this window, right-click the file, Run as administrator.
)
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Set-ProgramStartLogging-2026-09-27.ps1" -Mode On
echo.
echo   Press Enter to close.
set /p "GGCLOSE="
exit /b 0
