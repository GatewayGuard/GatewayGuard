@echo off
REM Dated: 2026-09-16 12:45 EDT
REM File: Run-MeasureEffectiveState.bat
REM
REM  Settles FT-123b items 13 (Edge Startup Boost) and 14 (Widgets) by
REM  MEASUREMENT -- you flip each setting once in Windows' own UI while the
REM  script watches what changes -- and prints three candidate signals for
REM  item 9 (Windows Hello). Whatever value moves is the real key.
REM
REM  READ-ONLY. Writes nothing to the registry, nothing to Edge, nothing
REM  outside Test_Results\. Does NOT need administrator. NEVER self-elevates.
REM
REM  Written by Claude Cloud, checked against this project's coding
REM  standards by Claude Code before this launcher was added.
REM
cd /d "%~dp0"

echo.
echo   ==============================================================
echo    MEASURE EFFECTIVE STATE -- Edge Startup Boost, Widgets, Hello
echo   ==============================================================
echo.
net session >nul 2>&1
if %errorlevel%==0 (
  echo   Running ELEVATED. Not required -- this only reads settings.
) else (
  echo   Running as a normal user. That is correct. Nothing here needs
  echo   administrator rights, because nothing is changed.
)
echo.
echo   You will be asked to flip Startup Boost, then Widgets, each once,
echo   then flip them back. The script only reads before and after.
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Measure-EffectiveState-2026-09-16.ps1"

echo.
echo   Done. Press Enter to close this window.
set /p "GGCLOSE="
