@echo off
REM Dated: 2026-09-06 15:28 EDT
REM File: Run-InstallAccountCheck.bat
REM
REM  READ-ONLY. Answers Bill's question 7: what account was active when
REM  Windows was installed, and is anything already encrypted.
REM  Changes nothing. Writes its answer to ..\Test_Results\.
REM
REM  NEVER self-elevates (Malwarebytes flagged self-elevation as an
REM  exploit payload, field-confirmed 2026-07-04). For the encryption
REM  section: RIGHT-CLICK this file -> Run as administrator.
REM
cd /d "%~dp0"

set "GGPS1=Get-InstallAccount-2026-09-06.ps1"

if not exist "%GGPS1%" (
  echo.
  echo   ERROR: cannot find %GGPS1%
  echo   It should sit in this same folder, next to this launcher.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

net session >nul 2>&1
if errorlevel 1 (
  echo.
  echo   NOTE: this window is NOT running as administrator.
  echo   Everything about accounts will still be read. The encryption
  echo   section will say "could not read" instead of guessing.
  echo   To get that section too: close this, right-click the .bat,
  echo   and choose Run as administrator.
  echo.
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo   Done. Press Enter to close this window.
set /p "GGCLOSE="
