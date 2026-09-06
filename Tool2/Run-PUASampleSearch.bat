@echo off
REM Dated: 2026-09-06 16:45 EDT
REM File: Run-PUASampleSearch.bat
REM
REM  READ-ONLY. Searches the attached drives for the six PUP specimens
REM  from SANDY 2026-07-19 Malwarebytes scan, matching on SHA-256 as well
REM  as filename. Opens nothing, runs nothing, copies nothing, deletes
REM  nothing. Writes its findings to the Test_Results folder.
REM
REM  NEVER self-elevates. It does not need administrator.
REM
cd /d "%~dp0"

set "GGPS1=Find-PUASamples-2026-09-06.ps1"

if not exist "%GGPS1%" (
  echo.
  echo   ERROR: cannot find %GGPS1%
  echo   It should sit in this same folder, next to this launcher.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

echo.
echo   Searching drives E: and G: -- about two minutes.
echo   Nothing is changed. This only looks.
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo   Done. Press Enter to close this window.
set /p "GGCLOSE="
