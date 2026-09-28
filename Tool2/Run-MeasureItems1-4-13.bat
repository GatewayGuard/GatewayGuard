@echo off
REM Dated: 2026-09-28 09:14 ET
REM Run-MeasureItems1-4-13.bat -- READ-ONLY. Items 1, 4 and 13 values. Changes nothing.
REM Never elevates itself.
echo This launcher is in: %~dp0
cd /d "%~dp0"
if errorlevel 1 (echo PROBLEM: could not open that folder. & goto :done)
echo Now working in: %CD%
if exist "Measure-Items1-4-13.ps1" (echo Found Measure-Items1-4-13.ps1) else (echo PROBLEM: Measure-Items1-4-13.ps1 is not in this folder yet -- let OneDrive finish syncing Tool2. & goto :done)
if exist "..\Test_Results\" (echo Found the Test_Results folder) else (echo NOTE: no Test_Results folder next to Tool2 -- the result will be saved beside this launcher instead.)
net session >nul 2>&1
if %errorlevel%==0 (echo Running as administrator.) else (echo Not administrator -- that is fine, this only reads.)
echo.
powershell -NoProfile -ExecutionPolicy Bypass -File "Measure-Items1-4-13.ps1"
:done
echo.
set /p _x=Press Enter to close this window...
exit /b 0
