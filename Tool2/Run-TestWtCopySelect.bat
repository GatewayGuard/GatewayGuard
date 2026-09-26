@echo off
REM Dated: 2026-09-26 12:07 ET
REM File: Run-TestWtCopySelect.bat
REM
REM  ascii45 C9 (full-screen launch): measures how COPYING and SELECTING text
REM  behave in Windows Terminal, before screens 3, 4 and 8 are rewritten.
REM  It opens a FULL-SCREEN Windows Terminal window, the way Checkup will.
REM
REM  READ-ONLY. Changes nothing. Does NOT need administrator. NEVER elevates.
REM
cd /d "%~dp0"

echo.
echo   ==============================================================
echo    COPY AND SELECTION TEST -- Windows Terminal, full screen
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
echo   A full-screen window is opening now. Follow the three steps on it.
echo   There is no X in full screen: the window closes by itself after
echo   step 3 or after two minutes.
echo   If you are ever stuck in a full-screen window: Alt+F4 closes it,
echo   Alt+Enter leaves full screen.
echo.
REM Start in this folder (-d, folder WITHOUT a trailing backslash) and name the script without its path. Measured 2026-09-26: a full path with spaces, and a folder ending in \. , both failed.
set "GGDIR=%~dp0"
set "GGDIR=%GGDIR:~0,-1%"
wt.exe -w new -F new-tab -d "%GGDIR%" --title "GatewayGuard copy test" --suppressApplicationTitle powershell.exe -NoProfile -ExecutionPolicy Bypass -File Test-WtCopySelect-2026-09-26.ps1
echo   When the full-screen window has closed, the results are in Test_Results.
echo   Press Enter to close this window.
set /p "GGCLOSE="
