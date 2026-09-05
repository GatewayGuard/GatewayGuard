@echo off
REM Dated: 2026-09-04 22:43 ET
REM File: Run-SetTouchpadDrag.bat
REM
REM  Stops the laptop touchpad moving folders by accident, by turning off
REM  the tap-twice-and-drag gesture.
REM
REM  This is the TOUCHPAD. The drag threshold script fixes the MOUSE. They
REM  are two different mechanisms and you may want both.
REM
REM  Does NOT need administrator. NEVER elevates.
REM
cd /d "%~dp0"
setlocal
echo.
echo  ==============================================================
echo   TOUCHPAD -- stop it moving folders by accident
echo  ==============================================================
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Set-TouchpadDrag-2026-09-04-2243.ps1"
echo.
echo  Press Enter to close this window.
set /p JUNK=
endlocal
