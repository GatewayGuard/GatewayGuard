@echo off
REM Dated: 2026-08-28 12:45 ET
REM File: Run-ChecklistClaimsCheck.bat (always-current launcher)
REM RUNS: Check-ChecklistClaims-2026-08-28.ps1 against the NEWEST field checklist
REM       and the NEWEST build.
REM
REM  Verifies the FT claims in a checklist against the build source.
REM
REM  WHY IT EXISTS: on 2026-08-28 three rows of the ascii43 FT table were
REM  found wrong and two FT numbers were found to be invented -- cited in
REM  the checklist and existing nowhere else. Bill asked how we would know
REM  if there were more. This is the answer.
REM
REM  It proves: every FT cited exists in the build OR in another project
REM  document; which FTs share a function (where descriptions get swapped);
REM  and whether cited screen numbers resolve in the label table.
REM
REM  It does NOT judge whether a description is right. It prints the source
REM  comment beside each citation so a human compares in one pass.
REM
REM  READ-ONLY. Writes one report into Test_Results.
REM  DOES NOT NEED ADMINISTRATOR.
REM
cd /d "%~dp0"

if not exist "Check-ChecklistClaims-2026-08-28.ps1" (
  echo.
  echo   ERROR: cannot find Check-ChecklistClaims-2026-08-28.ps1
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Check-ChecklistClaims-2026-08-28.ps1"

echo.
echo   Press Enter to close this window.
set /p "GGCLOSE="
