@echo off
setlocal
cd /d "%~dp0"

REM Run-TestCodeSignature.bat -- launcher for Test-CodeSignature-2026-08-14.ps1
REM Launch plan item B4: prove the code signing certificate can actually sign.
REM Does NOT self-elevate. Does NOT touch the build.

net session >/dev/null 2>&1
if %errorlevel%==0 (
  echo   Running ELEVATED. Not required for this test, but harmless.
) else (
  echo   Running as a normal user. That is all this test needs.
)
echo.
echo   Plug the eToken in before continuing. SafeNet will ask for the
echo   token password in its own window.
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "Test-CodeSignature-2026-08-14.ps1"

endlocal
