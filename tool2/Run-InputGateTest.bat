@echo off
REM Dated: 2026-08-15 09:30 EDT
REM File: Run-InputGateTest.bat (always-current launcher)
REM RUNS: Test-InputGate-2026-08-15.ps1 against the NEWEST build
REM
REM  WHAT IT CHECKS: the three input-path claims ascii40 makes.
REM    FT-171a  mouse input reporting is turned off, not just QuickEdit.
REM             ascii39 turned off QuickEdit only, so SANDY ran the whole
REM             2026-08-11 field session with mouse reporting on.
REM    FT-171b  the input drain is one flush call, not a capped read loop
REM             against a buffer of the same size.
REM    FT-171f  the console flags are set again before every screen. In
REM             ascii39 they were only ever set part-way through the run.
REM
REM  It reads those functions out of the build itself, so it cannot drift
REM  from what ships.
REM
REM  WHAT IT CHANGES: the input mode of THIS window only, exactly as Checkup
REM  does, and it puts it back before it finishes. No file, no registry key,
REM  no setting. Closing the window also puts it back.
REM
REM  DOES NOT NEED ADMINISTRATOR.
REM
REM  Results are saved to Test_Results, so nothing is lost off the screen.
REM
REM  IMPORTANT: this launcher NEVER self-elevates. A self-elevating .bat was
REM  flagged by Malwarebytes as an exploit payload (field-confirmed
REM  2026-07-04). It reports elevation; it does not elevate.
REM
cd /d "%~dp0"

net session >nul 2>&1
if errorlevel 1 (
  echo.
  echo   NOTE: this window is NOT running as administrator.
  echo   That is fine -- this check does not need it.
  echo.
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Test-InputGate-2026-08-15.ps1"
