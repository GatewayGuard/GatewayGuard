@echo off
REM Dated: 2026-08-13 10:18 EDT
REM File: Run-CopyCheck.bat (always-current launcher)
REM RUNS: Check-Copy-2026-08-13.ps1
REM
REM  GATE 25 -- THE COPY GATE.
REM
REM  Checks the plain-language rules mechanically, across the TOOL and the
REM  WEBSITE in one pass:
REM
REM    PL-1  "whether" and "whereas"
REM    PL-2  "switch" as a verb for a setting (the NOUN is allowed)
REM    PL-4  unverified superlatives
REM          the open-source ban (ACCURACY NOTE)
REM          the Checkup name rule
REM          assisted sessions described as available
REM
REM  WHY IT EXISTS: ascii39 field finding 12 asked whether Grammarly or Word
REM  could check "all of these kind of things before we publish". They cannot.
REM  They check grammar. They do not know that "whether" is banned here, that
REM  the repository is private, or that the full product name may appear once
REM  per page.
REM
REM  Checking both the tool and the website in one pass is the point. RULE
REM  W-07 exists because the two drift apart, and on 2026-08-13 they did.
REM
REM  READ-ONLY. Parses text and prints findings. Changes nothing.
REM
REM  DOES NOT NEED ADMINISTRATOR.
REM
REM  Exit codes:  0 = pass   1 = breaches found   2 = a matcher failed its
REM  own control, so no result is valid.
REM
cd /d "%~dp0"

set "GGPS1=Check-Copy-2026-08-13.ps1"

if not exist "%GGPS1%" (
  echo.
  echo   ERROR: cannot find %GGPS1%
  echo   It should sit in this same folder, next to this launcher.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

echo Checking website copy and tool screen text ...
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%GGPS1%"

echo.
echo   A deliberate, defensible use is marked on the SAME line:
echo      ^<!-- COPYCHECK-OK: describes Bitwarden, not GatewayGuard --^>
echo.
echo   This gate cannot judge meaning. H-4 -- naming the guide section a
echo   page's wording came from -- is still yours to run.
echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
