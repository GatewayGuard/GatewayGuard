@echo off
REM Dated: 2026-09-27 10:57 ET
REM File: Run-TestWtCtrlC.bat
REM
REM  ascii45 C7 (FT-270): does Checkup's Ctrl+C guard work in Windows Terminal?
REM  Step 1 Ctrl+C with nothing highlighted; step 2 with text highlighted.
REM  It opens a FULL-SCREEN Windows Terminal window, the way Checkup will.
REM
REM  READ-ONLY. Changes nothing. Does NOT need administrator. NEVER elevates.
REM
cd /d "%~dp0"

echo.
echo   ==============================================================
echo    CTRL+C TEST -- Windows Terminal, full screen
echo   ==============================================================
echo.
where wt.exe >nul 2>&1
if errorlevel 1 (
  echo   Windows Terminal ^(wt.exe^) was not found on this PC.
  echo   That is itself the answer -- tell Claude Code.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  goto :eof
)
echo   A full-screen window is opening now. Follow the two steps on it.
echo   There is no X in full screen: the window closes by itself after
echo   step 2.
echo   If you are ever stuck in a full-screen window: Alt+F4 closes it,
echo   Alt+Enter leaves full screen.
echo.
REM Start in this folder (-d, folder WITHOUT a trailing backslash) and name the script without its path. Measured 2026-09-26: a full path with spaces, and a folder ending in \. , both failed.
set "GGDIR=%~dp0"
set "GGDIR=%GGDIR:~0,-1%"
wt.exe -w new -F new-tab -d "%GGDIR%" --title "GatewayGuard Ctrl+C test" --suppressApplicationTitle powershell.exe -NoProfile -ExecutionPolicy Bypass -File Test-WtCtrlC-2026-09-27.ps1
echo   When the full-screen window has closed, the results are in Test_Results.
echo   Press Enter to close this window.
set /p "GGCLOSE="
