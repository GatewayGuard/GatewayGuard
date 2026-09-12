@echo off
REM Dated: 2026-07-30 20:40 EDT
REM File: Run-HomeDiagnostic.bat (always-current launcher)
REM RUNS: Check-HomeEdition-2026-07-29.ps1
REM
REM  Answers the Home-edition detection questions: Memory Integrity (FT-115),
REM  Tamper Protection, Defender state, encryption state and what it can test
REM  for FT-110, the Edge settings, Wake on LAN, antivirus registration,
REM  phishing protection, and Kernel DMA vs Memory Integrity.
REM
REM  READ-ONLY. It changes no setting on this PC. It writes one transcript
REM  file next to itself and a temporary msinfo32 report it deletes again.
REM
REM  NEEDS ADMINISTRATOR for the full picture. Right-click this file and
REM  choose "Run as administrator". It still works without, but several
REM  checks will report "needs admin" instead of an answer.
REM
REM  IMPORTANT: this launcher NEVER self-elevates. A self-elevating .bat was
REM  flagged by Malwarebytes as an exploit payload (field-confirmed
REM  2026-07-04). Do not add elevation to it.
REM
cd /d "%~dp0"

net session >nul 2>&1
if %errorlevel%==0 (
  echo Running as administrator -- full results.
) else (
  echo.
  echo   NOTE: not running as administrator.
  echo   Several checks will say "needs admin" instead of giving an answer.
  echo   To get everything: close this, right-click this file,
  echo   and choose "Run as administrator".
  echo.
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Check-HomeEdition-2026-07-29.ps1"

echo.
echo ============================================================
echo   Finished. The transcript was saved in this folder as
echo   HomeDiagnostic-^<PC^>-^<date^>.txt  -- send Claude that file.
echo ============================================================
echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
