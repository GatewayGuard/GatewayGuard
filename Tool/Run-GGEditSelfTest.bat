@echo off
REM Dated: 2026-08-13 10:04 EDT
REM File: Run-GGEditSelfTest.bat (always-current launcher)
REM RUNS: gg_edit.py self-test
REM
REM  gg_edit.py is the assert-guarded wrapper CodingStandards requires for
REM  EVERY edit to a .ps1 build file -- feature work, defect fixes, and lint
REM  or cleanup passes alike. There is no cosmetic exemption.
REM
REM  WHY IT EXISTS, TWICE OVER:
REM
REM  1. On 2026-07-25 a PSScriptAnalyzer cleanup pass was treated as too
REM     trivial to need the wrapper. Applied as a bulk raw string replace it
REM     duplicated ascii34 about 40x -- 341 KB became 13.7 MB, unparseable.
REM     Brace balance did NOT catch it: 47,232 open, 47,232 close, perfectly
REM     balanced and completely destroyed.
REM
REM  2. The wrappers that built ascii37 were never committed and are gone.
REM     Zero .py files existed in the tree or in git history as of
REM     2026-08-13. The spec survived; the code did not. This one is
REM     committed.
REM
REM  This self-test proves all four guards actually fire. A guard nobody has
REM  watched fail is a wish -- which is the FT-162 lesson, where [GOOD]
REM  printed for months over a command that had never run.
REM
REM  READ-ONLY. It works entirely in a temporary folder and deletes it after.
REM  It never touches a build file.
REM
REM  DOES NOT NEED ADMINISTRATOR.
REM
cd /d "%~dp0"

if not exist "gg_edit.py" (
  echo.
  echo   ERROR: cannot find gg_edit.py
  echo   It should sit in this same folder, next to this launcher.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

REM python3 resolves to a Microsoft Store stub on CGDELL. python and py both
REM work. Try python first, fall back to py.
set "GGPY=python"
%GGPY% --version >nul 2>&1
if not %errorlevel%==0 set "GGPY=py"

%GGPY% --version >nul 2>&1
if not %errorlevel%==0 (
  echo.
  echo   ERROR: no working Python found. Tried "python" and "py".
  echo   Do NOT try "python3" -- it is a Microsoft Store alias stub and
  echo   reports that Python is not installed even when it is.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

echo Running gg_edit self-test with %GGPY% ...
echo.

%GGPY% "gg_edit.py"

echo.
echo   Four checks should pass: a correct edit, a wrong count, unbalanced
echo   braces, and duplication-class damage caught by the size assertion.
echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
