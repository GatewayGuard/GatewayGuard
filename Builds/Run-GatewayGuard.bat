@echo off
REM Dated: 2026-07-25 09:00 ET
REM File: Run-GatewayGuard.bat (always-current launcher -- paired build below)
REM CURRENT BUILD: W11-SecurityHardening-v3-ascii34-2026-07-25.ps1
REM
REM  IMPORTANT: This launcher NEVER self-elevates. A self-elevating .bat
REM  was flagged by Malwarebytes as an exploit payload (field-confirmed
REM  2026-07-04). To run: RIGHT-CLICK this file -> Run as administrator.
REM
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "W11-SecurityHardening-v3-ascii34-2026-07-25.ps1"
