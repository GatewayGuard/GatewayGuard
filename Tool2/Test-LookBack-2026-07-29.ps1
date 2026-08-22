# Dated: 2026-07-29 18:05 EDT
# ================================================================
# FILE:    Test-LookBack-2026-07-29.ps1
# PURPOSE: Prove (or disprove) the console-buffer look-back mechanism
#          that ascii38's Back button depends on, on a REAL console.
#
# WHY THIS EXISTS: the mechanism captures the console buffer and paints it
# back. It cannot be validated in a redirected/captured host, because there
# Write-Host output never reaches the console buffer at all. Given that FT-46
# (the host silently resets input mode) and FT-63 (Mark mode freezes writes on
# output) are both console-behaviour surprises that cost this project weeks,
# the mechanism gets proven on the target console before a build ships on it.
#
# HOW TO RUN: right-click Run-GatewayGuard.bat's folder, or from a normal
# PowerShell window:
#     powershell -NoProfile -ExecutionPolicy Bypass -File .\Test-LookBack-2026-07-29.ps1
# It changes NOTHING on this PC. It only draws on screen and reads keys.
# ================================================================

$ErrorActionPreference = "Continue"

function Write-TestBox {
    param([string[]]$Lines, [System.ConsoleColor]$Color = "White")
    $w = 44
    foreach ($l in $Lines) { if ($l -ne "---" -and $l.Length -gt $w) { $w = $l.Length } }
    $b = "+" + ("=" * $w) + "+"
    Write-Host $b -ForegroundColor $Color
    foreach ($l in $Lines) {
        if ($l -eq "---") { Write-Host $b -ForegroundColor $Color }
        else { Write-Host ("|" + $l.PadRight($w) + "|") -ForegroundColor $Color }
    }
    Write-Host $b -ForegroundColor $Color
}

function Wait-Key {
    param([string]$Msg)
    Write-Host ""
    Write-Host $Msg -ForegroundColor White
    try {
        do { $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") }
        while ($k.VirtualKeyCode -notin @(13, 32))
    } catch { $null = Read-Host }
}

Clear-Host
Write-Host ""
Write-TestBox -Color Cyan -Lines @(
    "  LOOK-BACK MECHANISM TEST                    ",
    "---",
    "  This changes nothing on your PC. It draws on ",
    "  screen and reads keys, nothing else.        ",
    "                                              ",
    "  Three checks, about 30 seconds.             "
)
Write-Host ""
Write-Host "  Host name  : $($Host.Name)"
Write-Host "  WindowSize : $($Host.UI.RawUI.WindowSize)"
Write-Host "  BufferSize : $($Host.UI.RawUI.BufferSize)"
Wait-Key "  Press Enter or Space to start CHECK 1..."

# ---------------------------------------------------------------- CHECK 1
Clear-Host
Write-Host ""
Write-TestBox -Color White -Lines @(
    "  CHECK 1 -- THIS IS THE ORIGINAL SCREEN      ",
    "---",
    "  Remember two things about this screen:      ",
    "                                              ",
    "    1. This box, with its border              ",
    "    2. The YELLOW line printed below the box  "
)
Write-Host "  >>> THIS YELLOW LINE IS OUTSIDE THE BOX <<<" -ForegroundColor Yellow
Write-Host "  (a plain Write-Host line, not part of any box)" -ForegroundColor Yellow

$snapOK = $true
$snap = $null
$lastRow = 0
try {
    $ui = $Host.UI.RawUI
    $h = $ui.WindowSize.Height
    if ($ui.CursorPosition.Y -ge $h) { $h = $ui.CursorPosition.Y + 1 }
    if ($h -gt $ui.BufferSize.Height) { $h = $ui.BufferSize.Height }
    $rect = New-Object System.Management.Automation.Host.Rectangle 0, 0, ($ui.BufferSize.Width - 1), ($h - 1)
    $snap = $ui.GetBufferContents($rect)
    for ($y = 0; $y -lt $snap.GetLength(0); $y++) {
        for ($x = 0; $x -lt $snap.GetLength(1); $x++) {
            if ($snap[$y, $x].Character -ne ' ') { $lastRow = $y; break }
        }
    }
} catch {
    $snapOK = $false
    $captureError = $_.Exception.Message
}

Write-Host ""
if ($snapOK) {
    Write-Host "  CAPTURE: ok -- $($snap.GetLength(0)) rows x $($snap.GetLength(1)) cols, last row with content = $lastRow" -ForegroundColor Green
    if ($lastRow -lt 3) {
        Write-Host "  WARNING: last row with content is $lastRow, which looks wrong for this" -ForegroundColor Red
        Write-Host "           screen. The buffer may not contain what was drawn." -ForegroundColor Red
    }
} else {
    Write-Host "  CAPTURE FAILED: $captureError" -ForegroundColor Red
}
Wait-Key "  Press Enter or Space to WIPE this screen (check 2)..."

# ---------------------------------------------------------------- CHECK 2
Clear-Host
Write-Host ""
Write-Host "  CHECK 2 -- the original screen has been WIPED." -ForegroundColor Red
Write-Host "  Nothing from check 1 should be visible right now." -ForegroundColor Red
Wait-Key "  Press Enter or Space to RESTORE it (check 3)..."

# ---------------------------------------------------------------- CHECK 3
$restoreOK = $false
$restoreErr = ""
if ($snapOK) {
    try {
        Clear-Host
        $ui = $Host.UI.RawUI
        $origin = New-Object System.Management.Automation.Host.Coordinates 0, 0
        $ui.SetBufferContents($origin, $snap)
        $row = $lastRow + 1
        if ($row -ge $ui.BufferSize.Height) { $row = $ui.BufferSize.Height - 1 }
        $ui.CursorPosition = New-Object System.Management.Automation.Host.Coordinates 0, $row
        $restoreOK = $true
    } catch {
        $restoreErr = $_.Exception.Message
    }
}

Write-Host ""
Write-Host "  ---------------- CHECK 3 RESULT ----------------" -ForegroundColor Cyan
if (-not $snapOK) {
    Write-Host "  VERDICT: FAIL -- capture is not supported in this host." -ForegroundColor Red
} elseif (-not $restoreOK) {
    Write-Host "  VERDICT: FAIL -- restore threw: $restoreErr" -ForegroundColor Red
} else {
    Write-Host "  The API calls all succeeded. Now YOU decide:" -ForegroundColor White
    Write-Host ""
    Write-Host "  Above this result block, can you see BOTH" -ForegroundColor White
    Write-Host "    (a) the CHECK 1 box, and" -ForegroundColor White
    Write-Host "    (b) the YELLOW line that sat outside it?" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  BOTH visible      -> look-back works. Tell me PASS." -ForegroundColor Green
    Write-Host "  Box only          -> tell me BOX ONLY." -ForegroundColor Yellow
    Write-Host "  Nothing restored  -> tell me FAIL." -ForegroundColor Red
    Write-Host "  Garbled/misplaced -> tell me GARBLED." -ForegroundColor Red
}
Write-Host ""
Write-Host "  Also worth reporting: did the colours come back correctly?" -ForegroundColor Gray
Write-Host ""
Wait-Key "  Press Enter or Space to finish (nothing was changed on this PC)..."
Clear-Host
Write-Host ""
Write-Host "  Test complete. Nothing on this PC was modified." -ForegroundColor Green
Write-Host ""
