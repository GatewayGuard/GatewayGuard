@echo off
REM Dated: 2026-07-30 20:40 EDT
REM File: Run-PSErrorCheck.bat (always-current launcher)
REM RUNS: Get-PSErrors-2026-07-30.ps1
REM
REM  Pulls the FULL text of PowerShell errors from the Windows event log --
REM  the ones Checkup generated and swallowed without logging them (FT-159).
REM  Also lists PowerShell start/stop events, which is how we tell an ordinary
REM  exit from the process being killed, and reports which console host this
REM  PC uses (Windows Terminal or classic conhost).
REM
REM  READ-ONLY. It reads the event log and writes one text file next to
REM  itself. It changes nothing.
REM
REM  BOUNDED. Every query is capped and filtered inside the event-log engine.
REM  An unbounded version of this query locked up SANDY on 2026-07-30 and had
REM  to be killed by closing the window -- do not remove the -MaxEvents caps.
REM
REM  NEEDS ADMINISTRATOR to read the PowerShell operational log.
REM  Right-click this file and choose "Run as administrator".
REM
REM  IMPORTANT: this launcher NEVER self-elevates (Malwarebytes flagged a
REM  self-elevating .bat as an exploit payload, field-confirmed 2026-07-04).
REM
cd /d "%~dp0"

net session >nul 2>&1
if %errorlevel%==0 (
  echo Running as administrator -- good.
) else (
  echo.
  echo   NOTE: not running as administrator.
  echo   The PowerShell event log may not be readable and this will
  echo   probably come back empty. Close this, right-click the file,
  echo   and choose "Run as administrator".
  echo.
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Get-PSErrors-2026-07-30.ps1"

echo.
echo ============================================================
echo   Finished. The results were saved in this folder as
echo   PSErrors-^<PC^>-^<date^>.txt  -- send Claude that file.
echo ============================================================
echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
