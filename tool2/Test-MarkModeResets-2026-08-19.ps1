# Test-MarkModeResets-2026-08-19.ps1
# Dated: 2026-08-19 18:10 ET
#
# THE QUESTION: does selecting text in the window hand ENABLE_MOUSE_INPUT
# back after Checkup has cleared it?
#
# NOTE 2026-08-19: this now tests the WEAKER of two theories. Bill's finding 9
# already proves a stronger one from the field -- right-click in Windows
# Terminal PASTES, and his paste was consumed as keystrokes, opening the I
# screen without him pressing I. A multi-line paste is many characters, each
# one an unmatched key, each one a silent full repaint of the checklist. That
# needs no console-mode change at all. Run this anyway: if selection DOES
# restore the flag there are two independent causes, and knowing that is worth
# two minutes.
#
# WHY IT MATTERS: FT-193. On 2026-08-18 the ascii41 checklist repainted ten
# times in one second with no keypress at all -- measured in
# Logs-Sandy-ascii41\GatewayGuard-Log-2026-08-18_16-18.txt at 17:35:15. The
# mechanism needs mouse events to be reaching ReadKey. Checkup clears
# ENABLE_MOUSE_INPUT at startup, so something must be turning it back on, and
# selection is the suspect here. That link is INFERRED. This measures it.
#
# WHAT IT DOES: clears the flag exactly the way ascii41 does, asks you to
# select text, then reads the flag again. Three readings, one run.
#
# READ-ONLY in the sense that matters: it changes only this window's console
# mode, and it restores what it found before exiting. Nothing on the PC is
# touched. Closing the window also discards the change.
# DOES NOT NEED ADMINISTRATOR.
# PS 5.1 COMPATIBLE: -join only, no Join-String, no ternary.

$ErrorActionPreference = 'Continue'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projRoot  = Split-Path -Parent $scriptDir
$outDir    = Join-Path $projRoot 'Test_Results'
if (-not (Test-Path -LiteralPath $outDir)) { $outDir = $scriptDir }
$outFile = Join-Path $outDir ("MarkModeReset-" + $env:COMPUTERNAME + "-" + (Get-Date -Format 'yyyy-MM-dd_HH-mm') + ".txt")

$lines = New-Object System.Collections.ArrayList
function Add-Line { param([string]$t) ; [void]$lines.Add($t) ; Write-Host $t }

Add-Type -Namespace GG -Name K32 -MemberDefinition @'
[DllImport("kernel32.dll", SetLastError=true)]
public static extern IntPtr GetStdHandle(int nStdHandle);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool GetConsoleMode(IntPtr hConsoleHandle, out uint lpMode);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool SetConsoleMode(IntPtr hConsoleHandle, uint dwMode);
'@

$MOUSE = [uint32]16          # ENABLE_MOUSE_INPUT, bit 4
$QUICK = [uint32]64          # ENABLE_QUICK_EDIT_MODE, bit 6
$h = [GG.K32]::GetStdHandle(-10)

function Read-Mode {
    $m = [uint32]0
    $ok = [GG.K32]::GetConsoleMode($h, [ref]$m)
    if (-not $ok) { return $null }
    return $m
}
function Show-Mode {
    param([string]$Label, [uint32]$m)
    $mouse = (($m -band $MOUSE) -ne 0)
    $quick = (($m -band $QUICK) -ne 0)
    Add-Line ("  {0,-22} 0x{1:X8}   MOUSE_INPUT={2,-5}  QUICK_EDIT={3}" -f $Label, $m, $mouse, $quick)
    return $mouse
}

Add-Line "============================================================"
Add-Line " DOES SELECTING TEXT HAND ENABLE_MOUSE_INPUT BACK?  (FT-193)"
Add-Line "============================================================"
Add-Line ("  Machine : " + $env:COMPUTERNAME)
Add-Line ("  Run     : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + " ET")
Add-Line ("  Host    : " + $Host.Name + "   WT_SESSION set: " + [bool]$env:WT_SESSION)
Add-Line ""

$original = Read-Mode
if ($null -eq $original) {
    Add-Line "  STOPPED -- GetConsoleMode failed. This host has no real console."
    $lines -join "`r`n" | Out-File -FilePath $outFile -Encoding UTF8 -Force
    return
}

Add-Line "READING 1 -- as the window opened"
[void](Show-Mode "before" $original)
Add-Line ""

# Exactly what ascii41's Disable-QuickEdit applies, line 2703.
$cleared = [uint32](($original -band [uint32]4294967231 -band [uint32]4294967279) -bor [uint32]128)
[void][GG.K32]::SetConsoleMode($h, $cleared)
$after = Read-Mode
Add-Line "READING 2 -- after applying ascii41's mask (Checkup's startup)"
$mouseAfterClear = Show-Mode "after clearing" $after
if ($mouseAfterClear) {
    Add-Line ""
    Add-Line "  !! The mask did NOT clear MOUSE_INPUT. Stop here -- that alone"
    Add-Line "     is the defect, and selection is not needed to explain FT-193."
} else {
    Add-Line "     MOUSE_INPUT is now OFF, which is what Checkup relies on."
}
Add-Line ""

Add-Line "------------------------------------------------------------"
Add-Line " NOW SELECT SOME TEXT IN THIS WINDOW, then come back."
Add-Line ""
if ($env:WT_SESSION) {
    Add-Line "   This is WINDOWS TERMINAL. It has no Edit -> Mark menu --"
    Add-Line "   right-click here PASTES. Do this instead:"
    Add-Line ""
    Add-Line "     1. Click and DRAG across a few words above"
    Add-Line "     2. Press  Ctrl+Shift+C  to copy them"
    Add-Line "     3. Click once to clear the selection"
    Add-Line ""
    Add-Line "   If Ctrl+Shift+M opens a Mark mode on your version, use that"
    Add-Line "   too, then press Esc to leave it."
} else {
    Add-Line "   This is the CLASSIC CONSOLE (conhost). Do this:"
    Add-Line ""
    Add-Line "     1. RIGHT-CLICK the title bar"
    Add-Line "     2. Choose  Edit  ->  Mark"
    Add-Line "     3. Drag over a few words to select them"
    Add-Line "     4. Press  Esc  to leave Mark mode"
}
Add-Line ""
Add-Line "   Then press Enter back here."
Add-Line "------------------------------------------------------------"
Write-Host ""
Write-Host "  Press Enter when you have finished selecting..." -ForegroundColor White -NoNewline
[void](Read-Host)
Add-Line ""

$final = Read-Mode
Add-Line "READING 3 -- after selecting text in the window"
$mouseAfterSelect = Show-Mode "after selecting" $final
Add-Line ""

Add-Line "============================================================"
Add-Line " ANSWER"
Add-Line "============================================================"
if ($mouseAfterClear) {
    Add-Line "  INCONCLUSIVE -- the mask never cleared the flag, so there was"
    Add-Line "  nothing for selection to undo."
} elseif ($mouseAfterSelect) {
    Add-Line "  YES. Selecting text handed ENABLE_MOUSE_INPUT BACK."
    Add-Line ""
    Add-Line "  FT-193's chain is now closed end to end: Checkup clears the flag,"
    Add-Line "  selection restores it, the checklist never re-asserts it because"
    Add-Line "  it does not go through Draw-Box, and every mouse event then"
    Add-Line "  repaints the screen. The fix is to re-assert on the checklist."
} else {
    Add-Line "  NO. Selecting text left the flag alone."
    Add-Line ""
    Add-Line "  The FT-193 theory is WRONG and must not be built on. Something"
    Add-Line "  else is feeding events to the checklist's ReadKey. Do not apply"
    Add-Line "  the planned fix on this reasoning -- find the real source first."
}
Add-Line ""
Add-Line ("  raw: before=0x{0:X8}  cleared=0x{1:X8}  after-select=0x{2:X8}" -f $original, $after, $final)

# Put the window back the way it was found.
[void][GG.K32]::SetConsoleMode($h, $original)
Add-Line ""
Add-Line "  Console mode restored to what it was when this window opened."
Add-Line "============================================================"

$lines -join "`r`n" | Out-File -FilePath $outFile -Encoding UTF8 -Force
Write-Host ""
Write-Host ("  Saved to: " + $outFile) -ForegroundColor Cyan
