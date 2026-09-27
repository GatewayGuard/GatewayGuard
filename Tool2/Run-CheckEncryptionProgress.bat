@echo off
REM Dated: 2026-09-27 13:27 ET
REM File: Run-CheckEncryptionProgress.bat
REM
REM  Shows how far encryption or decryption has got on every drive.
REM  READ-ONLY. Changes nothing. Right-click, Run as administrator.
REM  It NEVER elevates itself.
REM
cd /d "%~dp0"
echo.
net session >nul 2>&1
if %errorlevel%==0 (
  echo   Running as administrator. Good.
) else (
  echo   NOT running as administrator -- the drives cannot be read.
  echo   Close this window, right-click the file, Run as administrator.
)
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Check-EncryptionProgress-2026-09-27.ps1"
echo.
echo   Press Enter to close.
set /p "GGCLOSE="
exit /b 0
