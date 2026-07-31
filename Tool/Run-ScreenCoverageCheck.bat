@echo off
REM Dated: 2026-07-30 20:40 EDT
REM File: Run-ScreenCoverageCheck.bat (always-current launcher)
REM RUNS: Check-ScreenCoverage-2026-07-29.ps1 against the NEWEST build
REM
REM  This is CodingStandards gate 12, the mechanical check: every Draw-Box
REM  screen must carry a unique screen ID. It reports the screen count, any
REM  screen missing an ID, any duplicate ID, screens built at runtime that
REM  the Gallery must seed, and the next free ID for a new screen.
REM
REM  Run this BEFORE shipping any build.
REM
REM  READ-ONLY. It parses the .ps1 file and prints findings. It changes
REM  nothing and writes nothing.
REM
REM  DOES NOT NEED ADMINISTRATOR.
REM
REM  It finds the newest W11-SecurityHardening .ps1 in this folder by itself,
REM  so it does not need updating when the build number changes -- which is
REM  the cross-file sync problem that has bitten Run-GatewayGuard.bat before.
REM
cd /d "%~dp0"

set "BUILD="
for /f "delims=" %%F in ('dir /b /o-d "W11-SecurityHardening-v3-*.ps1" 2^>nul') do (
  if not defined BUILD set "BUILD=%%F"
)

if not defined BUILD (
  echo.
  echo   ERROR: no W11-SecurityHardening-v3-*.ps1 found in this folder.
  echo.
  pause
  exit /b 1
)

echo Checking the newest build found: %BUILD%
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Check-ScreenCoverage-2026-07-29.ps1" -Path "%BUILD%"

echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
