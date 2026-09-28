@echo off
cd /d "%~dp0"
rem Read-only: Items 1, 4 and 13 values. Changes nothing.
net session >/dev/null 2>&1
if %errorlevel%==0 (echo Running as administrator.) else (echo Not administrator -- that is fine, this only reads.)
powershell -NoProfile -ExecutionPolicy Bypass -File "Measure-Items1-4-13.ps1"
echo.
set /p _x=Press Enter to close this window...
exit /b 0
