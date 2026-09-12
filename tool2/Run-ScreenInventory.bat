@echo off
REM Dated: 2026-08-15 13:10 EDT
REM File: Run-ScreenInventory.bat (always-current launcher)
REM RUNS: Get-ScreenInventory-2026-08-15.ps1 against the NEWEST build
REM
REM  WHAT IT IS FOR: the raw material for the FT-172 screen-number table.
REM  Bill 2026-08-15: each screen must have a unique number, 1 to X, assigned
REM  at build time from the viewing order, so that when a user says "screen 6"
REM  we know exactly which screen that is.
REM
REM  It lists every screen the build can paint, its stable ID, the function it
REM  lives in, and whether it sits inside a branch. It also lists every screen
REM  number typed by hand into screen text -- those are the ones that cannot
REM  agree with a counted number except by luck.
REM
REM  It does NOT decide the order. Source order is not viewing order, because
REM  functions are defined in one order and called in another. The order is a
REM  human decision; this is the list that decision has to account for.
REM
REM  READ-ONLY. It parses the .ps1 and writes one report to Test_Results.
REM  It changes nothing and does not touch the build.
REM
REM  DOES NOT NEED ADMINISTRATOR.
REM
REM  IMPORTANT: this launcher NEVER self-elevates. A self-elevating .bat was
REM  flagged by Malwarebytes as an exploit payload (field-confirmed
REM  2026-07-04).
REM
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Get-ScreenInventory-2026-08-15.ps1"
