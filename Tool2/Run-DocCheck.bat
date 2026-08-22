@echo off
REM Dated: 2026-08-20 12:10 ET
REM File: Run-DocCheck.bat (always-current launcher)
REM RUNS: Check-Docs-2026-08-20.ps1
REM
REM  WHAT IT DOES: the document gate. This project has two dozen mechanical
REM  gates for code and had none for documents, and documents are where the
REM  drift lives. It checks that the live documents agree with each other and
REM  with the machine, that no pointer names a file that is gone, that every
REM  filename date matches the date inside the file, and that where several
REM  copies of a document exist something says which one is live.
REM
REM  Run it at session end, next to Run-RepoHealthCheck.bat.
REM
REM  READ-ONLY. It changes nothing and deletes nothing.
REM  Needs no administrator. NEVER self-elevates -- a self-elevating .bat was
REM  flagged by Malwarebytes as an exploit payload (field-confirmed 2026-07-04).
cd /d "%~dp0"

set "GGPS1=Check-Docs-2026-08-20.ps1"

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
if "%ERRORLEVEL%"=="0" (
  echo.
  echo   Running as administrator. This check does not need it.
) else (
  echo.
  echo   Running as a normal user. That is all this check needs.
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
