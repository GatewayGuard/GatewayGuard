@echo off
REM Run-DisplayOff.bat -- turn the screen off now, keep the machine running.
REM Changes no settings. Needs no administrator.
REM Move the mouse or press a key to bring the screen back.
cd /d "%~dp0"

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Turn-DisplayOff-2026-08-24.ps1"

set /p GGDONE=  Press Enter to close this window. 
REM 2026-09-27: set /p leaves errorlevel 1 after an empty Enter, and Windows Terminal
REM keeps a window open on a non-zero exit -- so end cleanly.
exit /b 0
