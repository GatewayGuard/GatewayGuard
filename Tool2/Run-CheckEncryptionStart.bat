@echo off
REM Dated: 2026-09-27 15:58 ET
REM File: Run-CheckEncryptionStart.bat
REM
REM  Reads SANDY's logs from 2026-09-20 18:10-18:30 to find what started
REM  encryption. READ-ONLY. Changes nothing. Right-click, Run as administrator.
REM  It NEVER elevates itself.
REM
cd /d "%~dp0"
echo.
net session >nul 2>&1
if %errorlevel%==0 (
  echo   Running as administrator. Good.
) else (
  echo   NOT running as administrator -- some logs will be refused.
  echo   Close this window, right-click the file, Run as administrator.
)
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Check-EncryptionStart-2026-09-27.ps1"
echo.
echo   Done. The results file is in Test_Results. Press Enter to close.
set /p "GGCLOSE="
exit /b 0
