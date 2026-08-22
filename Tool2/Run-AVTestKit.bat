@echo off
cd /d "%~dp0"
echo.
echo  GatewayGuard -- AV scan coverage TEST KIT
echo  Stages HARMLESS EICAR test files across C: and D: to measure
echo  which scan finds what. Not malware. Reversible with the cleanup bat.
echo.
echo  Read ProjectDocs\GatewayGuard_AVScanCoverageTest-2026-08-21.md first.
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Make-AVTestKit-2026-08-21.ps1"
echo.
set /p _done=Press Enter to close this window...
