@echo off
REM Dated: 2026-08-02 07:30 EDT
REM File: Run-ExternalCommandCheck.bat (always-current launcher)
REM RUNS: Check-ExternalCommands-2026-08-02.ps1 against the NEWEST build
REM
REM  GATE 24 -- the mechanical enforcement of RESEARCH BEFORE STATING.
REM
REM  24a: every external command the tool runs (MpCmdRun, schtasks, powercfg,
REM       manage-bde, reagentc ...) must carry a nearby VERIFIED comment
REM       naming a date and a basis -- measured or sourced.
REM  24b: no screen may show the user a raw command line.
REM
REM  WHY IT EXISTS: the build shipped MpCmdRun.exe -Scan -ScanType 4 and told
REM  the user on screen that it scheduled an offline scan. ScanType 4 is not a
REM  valid scan type. It returns "Invalid command line argument" in 0.0
REM  seconds and does nothing -- while the log printed [GOOD] every time.
REM  The rule that forbids this already existed. Nothing checked it.
REM
REM  Run this BEFORE shipping any build.
REM
REM  READ-ONLY. It parses the .ps1 and prints findings. It changes nothing,
REM  writes nothing, and runs none of the commands it inspects.
REM
REM  DOES NOT NEED ADMINISTRATOR.
REM
REM  It finds the newest W11-SecurityHardening .ps1 in ..\Tool\ by itself.
REM
cd /d "%~dp0"

set "GGPS1=Check-ExternalCommands-2026-08-02.ps1"

if not exist "%GGPS1%" (
  echo.
  echo   ERROR: cannot find %GGPS1%
  echo   It should sit in this same folder, next to this launcher.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

set "BUILD="
for /f "delims=" %%F in ('dir /b /o-d "..\Tool\W11-SecurityHardening-v3-*.ps1" 2^>nul') do (
  if not defined BUILD set "BUILD=..\Tool\%%F"
)

if not defined BUILD (
  echo.
  echo   ERROR: no W11-SecurityHardening-v3-*.ps1 found in ..\Tool\.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

echo Checking the newest build found: %BUILD%
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%" -Path "%BUILD%"

echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
