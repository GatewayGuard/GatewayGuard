@echo off
REM Dated: 2026-07-29 18:30 EDT
REM File: Run-GatewayGuard.bat (always-current launcher -- paired build below)
REM CURRENT BUILD: W11-SecurityHardening-v3-ascii38-2026-07-29-1830.ps1
REM
REM  To review every screen without running any checks, use the companion
REM  launcher Show-AllScreens.bat instead (gallery mode -- changes nothing).
REM
REM  IMPORTANT: This launcher NEVER self-elevates. A self-elevating .bat
REM  was flagged by Malwarebytes as an exploit payload (field-confirmed
REM  2026-07-04). To run: RIGHT-CLICK this file -> Run as administrator.
REM
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "W11-SecurityHardening-v3-ascii38-2026-07-29-1830.ps1"
