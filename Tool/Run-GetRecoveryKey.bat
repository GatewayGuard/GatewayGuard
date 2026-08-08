@echo off
REM Dated: 2026-08-08 19:02 ET
REM Launcher for Get-BitLockerRecoveryKey-2026-08-08.ps1
REM READ-ONLY -- reads the existing BitLocker recovery key. Changes nothing.
REM Does NOT self-elevate. Reading recovery passwords needs administrator:
REM right-click this file and choose "Run as administrator".
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "Get-BitLockerRecoveryKey-2026-08-08.ps1"
echo.
set /p "=Press Enter to close this window." <nul
set /p "dummy="
