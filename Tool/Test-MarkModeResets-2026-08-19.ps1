# Test-MarkModeResets-2026-08-19.ps1
# Dated: 2026-08-19 18:10 ET
#
# THE ONE QUESTION: does entering and leaving Mark mode hand
# ENABLE_MOUSE_INPUT back after Checkup has cleared it?
#
# WHY IT MATTERS: FT-193. On 2026-08-18 the ascii41 checklist repainted ten
# times in one second with no keypress at all -- measured in
# Logs-Sandy-ascii41\GatewayGuard-Log-2026-08-18_16-18.txt at 17:35:15. The
# mechanism needs mouse events to be reaching ReadKey. Checkup clears
# ENABLE_MOUSE_INPUT at startup, so something must be turning it back on, and
# Mark mode is the suspect. That link is currently INFERRED. This measures it.
#
# WHAT IT DOES: clears the flag exactly the way ascii41 does, asks you to use
# Mark mode, then reads the flag again. Three readings, one run.
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
Add-Line " DOES MARK MODE HAND ENABLE_MOUSE_INPUT BACK?  (FT-193)"
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
    Add-Line "     is the defect, and Mark mode is not needed to explain FT-193."
} else {
    Add-Line "     MOUSE_INPUT is now OFF, which is what Checkup relies on."
}
Add-Line ""

Add-Line "------------------------------------------------------------"
Add-Line " NOW DO THIS, in this window:"
Add-Line ""
Add-Line "   1. RIGHT-CLICK the title bar"
Add-Line "   2. Choose  Edit  ->  Mark"
Add-Line "   3. Drag over a few words to select them"
Add-Line "   4. Press  Esc  to leave Mark mode"
Add-Line "   5. Come back here and press Enter"
Add-Line ""
Add-Line "   If your window has no title-bar menu, try right-clicking"
Add-Line "   inside the window instead, or press Ctrl+Shift+M."
Add-Line "------------------------------------------------------------"
Write-Host ""
Write-Host "  Press Enter when you have finished using Mark mode..." -ForegroundColor White -NoNewline
[void](Read-Host)
Add-Line ""

$final = Read-Mode
Add-Line "READING 3 -- after using Mark mode"
$mouseAfterMark = Show-Mode "after Mark" $final
Add-Line ""

Add-Line "============================================================"
Add-Line " ANSWER"
Add-Line "============================================================"
if ($mouseAfterClear) {
    Add-Line "  INCONCLUSIVE -- the mask never cleared the flag, so there was"
    Add-Line "  nothing for Mark mode to undo."
} elseif ($mouseAfterMark) {
    Add-Line "  YES. Mark mode handed ENABLE_MOUSE_INPUT BACK."
    Add-Line ""
    Add-Line "  FT-193's chain is now closed end to end: Checkup clears the flag,"
    Add-Line "  Mark mode restores it, the checklist never re-asserts it because"
    Add-Line "  it does not go through Draw-Box, and every mouse event then"
    Add-Line "  repaints the screen. The fix is to re-assert on the checklist."
} else {
    Add-Line "  NO. Mark mode left the flag alone."
    Add-Line ""
    Add-Line "  The FT-193 theory is WRONG and must not be built on. Something"
    Add-Line "  else is feeding events to the checklist's ReadKey. Do not apply"
    Add-Line "  the planned fix on this reasoning -- find the real source first."
}
Add-Line ""
Add-Line ("  raw: before=0x{0:X8}  cleared=0x{1:X8}  after-Mark=0x{2:X8}" -f $original, $after, $final)

# Put the window back the way it was found.
[void][GG.K32]::SetConsoleMode($h, $original)
Add-Line ""
Add-Line "  Console mode restored to what it was when this window opened."
Add-Line "============================================================"

$lines -join "`r`n" | Out-File -FilePath $outFile -Encoding UTF8 -Force
Write-Host ""
Write-Host ("  Saved to: " + $outFile) -ForegroundColor Cyan
