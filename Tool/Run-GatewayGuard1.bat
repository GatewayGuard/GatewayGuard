@echo off
REM Dated: 2026-07-28 13:30 EDT
REM File: Run-GatewayGuard.bat (always-current launcher -- paired build below)
REM CURRENT BUILD: Test-LookBack-2026-07-29
REM
REM  IMPORTANT: This launcher NEVER self-elevates. A self-elevating .bat
REM  was flagged by Malwarebytes as an exploit payload (field-confirmed
REM  2026-07-04). To run: RIGHT-CLICK this file -> Run as administrator.
REM
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Test-LookBack-2026-07-29.ps1"
