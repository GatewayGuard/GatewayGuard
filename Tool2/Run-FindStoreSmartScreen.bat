@echo off
REM Dated: 2026-09-28 13:19 ET
REM Run-FindStoreSmartScreen.bat -- READ-ONLY. Finds where Windows keeps
REM "SmartScreen for Microsoft Store apps". Changes nothing. Never elevates itself.
echo This launcher is in: %~dp0
cd /d "%~dp0"
if errorlevel 1 (echo PROBLEM: could not open that folder. & goto :done)
if not exist "Find-StoreSmartScreen.ps1" (echo PROBLEM: Find-StoreSmartScreen.ps1 is not here yet -- let OneDrive finish syncing Tool2. & goto :done)
net session >/dev/null 2>&1
if %errorlevel%==0 (echo Running as administrator.) else (echo Not administrator -- run it as administrator so every area can be read.)
echo.
powershell -NoProfile -ExecutionPolicy Bypass -File "Find-StoreSmartScreen.ps1"
:done
echo.
set /p _x=Press Enter to close this window...
exit /b 0
