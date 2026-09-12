@echo off
REM Run-DisplayOff.bat -- turn the screen off now, keep the machine running.
REM Changes no settings. Needs no administrator.
REM Move the mouse or press a key to bring the screen back.
cd /d "%~dp0"

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Turn-DisplayOff-2026-08-24.ps1"

set /p GGDONE=  Press Enter to close this window. 
