@echo off
REM Dated: 2026-08-02 07:55 EDT
REM File: Run-EncryptionMeasure.bat (always-current launcher)
REM RUNS: Measure-Encryption-2026-08-02.ps1
REM
REM  WHAT IT IS FOR: capturing how long drive encryption actually takes.
REM
REM  A FINISHED ENCRYPTION LEAVES NO TIME BEHIND. Measured on CGDELL:
REM  Windows logs "encryption will occur when restarted" and then nothing --
REM  no started event, no completed event -- and the BitLocker Operational
REM  log ships disabled. So the Dell's and the IdeaPad's encryption times
REM  are gone for good. The only way to get a real number is to sample the
REM  percentage while it converts.
REM
REM  START THIS BEFORE YOU TURN ENCRYPTION ON, and leave the window open.
REM  It samples every 60 seconds and writes a CSV beside this launcher.
REM
REM  On an already-encrypted PC it still captures a useful profile row
REM  (drive model, size, used space, method, CPU) for the timing model.
REM
REM  READ-ONLY. It never starts, stops or changes encryption, and changes
REM  no setting. It only reads status and hardware inventory.
REM
REM  DOES NOT NEED ADMINISTRATOR, though elevated gives fuller detail.
REM
REM  IMPORTANT: this launcher NEVER self-elevates. A self-elevating .bat was
REM  flagged by Malwarebytes as an exploit payload (field-confirmed
REM  2026-07-04). It reports elevation; it does not elevate.
REM
cd /d "%~dp0"

set "GGPS1=Measure-Encryption-2026-08-02.ps1"

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
if errorlevel 1 (
  echo.
  echo   Running WITHOUT administrator. The profile still works; some
  echo   BitLocker detail may be less complete.
  echo.
) else (
  echo.
  echo   Running as administrator.
  echo.
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
