@echo off
REM Dated: 2026-08-19 19:00 EDT
REM File: Run-MouseSetup.bat
REM
REM  Sets the Windows mouse options that matter when running Checkup.
REM  It SHOWS every change and ASKS before applying anything, and it can
REM  put everything back.
REM
REM  Does NOT need administrator. NEVER self-elevates.
REM
cd /d "%~dp0"

echo.
echo   Do you want to SET the mouse up for Checkup, or UNDO a previous setup?
echo.
echo     S = Set it up  (you will see every change and be asked first)
echo     U = Undo       (put back what it changed last time)
echo.
set "GGPICK="
set /p "GGPICK=Type S or U then press Enter: "

if /i "%GGPICK%"=="U" goto undo
if /i "%GGPICK%"=="S" goto setup
echo.
echo   That was neither S nor U, so nothing has been done.
goto finish

:setup
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Set-MouseForCheckup-2026-08-19.ps1"
goto finish

:undo
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Set-MouseForCheckup-2026-08-19.ps1" -Undo
goto finish

:finish
echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
