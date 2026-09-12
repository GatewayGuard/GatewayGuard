@echo off
REM Dated: 2026-07-30 20:40 EDT
REM File: Run-LookBackTest.bat (always-current launcher)
REM RUNS: Test-LookBack-2026-07-29.ps1
REM
REM  Proves (or disproves) the console-buffer look-back mechanism that
REM  Checkup's Back button depends on. Three checks, about 30 seconds:
REM  it draws a screen, captures it, wipes it, restores it, and asks you
REM  what you can see.
REM
REM  READ-ONLY. It draws on screen and reads keys. It changes nothing and
REM  writes nothing.
REM
REM  DOES NOT NEED ADMINISTRATOR. Just double-click it.
REM
REM  IMPORTANT: this launcher NEVER self-elevates (Malwarebytes flagged a
REM  self-elevating .bat as an exploit payload, field-confirmed 2026-07-04).
REM
cd /d "%~dp0"

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Test-LookBack-2026-07-29.ps1"

echo.
echo ============================================================
echo   Finished. Nothing on this PC was changed.
echo   Tell Claude: PASS / BOX ONLY / FAIL / GARBLED
echo ============================================================
echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
