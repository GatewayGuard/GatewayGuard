@echo off
REM Dated: 2026-09-04 21:59 ET
REM File: Run-RepoBloatCheck.bat
REM
REM  GATE 26 -- the session-start repo review.
REM
REM  Reports what Claude Cloud can see, what is spending the budget without
REM  earning it, and any commit that added a pile of files at once.
REM
REM  READ-ONLY. Moves nothing, deletes nothing, commits nothing.
REM  Does NOT need administrator. NEVER elevates.
REM
cd /d "%~dp0"
setlocal
echo.
echo  ==============================================================
echo   GATE 26 -- SESSION-START REPO REVIEW  (read only)
echo  ==============================================================
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Check-RepoBloat-2026-09-04-2159.ps1"
echo.
echo  Press Enter to close this window.
set /p JUNK=
endlocal
