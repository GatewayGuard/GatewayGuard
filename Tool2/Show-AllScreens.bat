@echo off
REM Dated: 2026-08-19 18:30 EDT
REM File: Show-AllScreens.bat (always-current gallery launcher)
REM CURRENT BUILD: W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1   (lives in ..\Tool\)
REM
REM  Opens GatewayGuard Checkup in SCREEN GALLERY mode: it shows you every
REM  screen in the tool, one at a time, with Next / Back / Jump / Quit.
REM
REM  It runs NO checks, reads NOTHING about this PC, and changes NOTHING.
REM  The values on the screens are examples, not readings from this computer.
REM
REM  This does NOT need to run as administrator -- it makes no changes.
REM
REM  IMPORTANT: like Run-GatewayGuard.bat, this launcher NEVER self-elevates.
REM  A self-elevating .bat was flagged by Malwarebytes as an exploit payload
REM  (field-confirmed 2026-07-04).
REM
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "..\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1" -Gallery
