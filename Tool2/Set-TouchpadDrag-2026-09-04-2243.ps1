# FILE:   Set-TouchpadDrag-2026-09-04-2243.ps1
# Dated:  2026-09-04 22:43 ET
#
# PURPOSE: Stop the LAPTOP TOUCHPAD moving folders by accident.
#
# WHY THIS IS A SEPARATE SCRIPT FROM THE DRAG THRESHOLD, and it is the whole
# point:
#
#   Bill, 2026-09-04, after the drag threshold was raised to 200 pixels:
#   "working on the mouse, but not on the laptop flat below keyboard mouse."
#
#   ***measured on CGDELL 2026-09-04:*** the drag threshold reads 200 x 200
#   live, and the mouse obeys it. The touchpad does not, and it never did.
#
#   The reason is that they are two different mechanisms. The drag threshold
#   is SM_CXDRAG / SM_CYDRAG, which a program consults by calling
#   DragDetect(). The touchpad's "tap twice and drag" is produced by the
#   Precision Touchpad driver itself, which starts the drag on its own and
#   does not ask about the threshold. No number in the other script can ever
#   fix the touchpad. This is the setting that governs it.
#
# WHAT IT CHANGES: one value, TapAndDrag, under
#   HKCU\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad
#
#   1 = tapping twice and holding starts dragging whatever is under the
#       pointer. This is the thing moving folders.
#   0 = off. Tapping still clicks. Dragging still works if you press the
#       touchpad down properly and move -- it just will not start from a
#       light double-tap any more.
#
# WHAT IT REPORTS BUT DOES NOT CHANGE: AAPThreshold, which is the "Touchpad
#   sensitivity" list in Windows Settings. Raising it makes the touchpad
#   ignore lighter contact -- useful against a palm brush, but it also makes
#   deliberate taps harder to land, so it is a real trade-off and Bill's
#   choice, not a side effect of this fix.
#
# NOT ADMIN. Current user's own setting. Never elevates.
# REVERSIBLE: run with -Revert to put TapAndDrag back to 1.
# REPORT ONLY: run with -ReportOnly to see the state and change nothing.
#
# PS 5.1 COMPATIBLE: -join only, no Join-String, no ternary.

[CmdletBinding()]
param(
    [switch]$Revert,
    [switch]$ReportOnly
)

$ErrorActionPreference = 'Stop'
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad'

$stamp   = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$outDir  = Join-Path (Split-Path $PSScriptRoot -Parent) 'Test_Results'
if (-not (Test-Path -LiteralPath $outDir)) { $outDir = $PSScriptRoot }
$outFile = Join-Path $outDir ("TouchpadDrag-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

$log = New-Object System.Collections.Generic.List[string]
function Say([string]$t) { Write-Host $t; $log.Add($t) }

function Get-Val { param($n)
    try { return (Get-ItemProperty -LiteralPath $key -ErrorAction Stop).$n } catch { return $null }
}
function Show { param($v)
    if ($null -eq $v) { return '(not set)' }
    return [string]$v
}

Say "======================================================================"
Say "  LAPTOP TOUCHPAD -- stop it moving folders by accident"
Say "======================================================================"
Say ("  machine : " + $env:COMPUTERNAME)
Say ("  user    : " + $env:USERNAME)
Say ("  run at  : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Say ""

if (-not (Test-Path -LiteralPath $key)) {
    Say "  This PC has no Precision Touchpad. Nothing to do."
    $log | Set-Content -LiteralPath $outFile -Encoding UTF8
    Say ""
    Say ("  Saved to: " + $outFile)
    return
}

Say "-- WHY THE MOUSE OBEYED AND THE TOUCHPAD DID NOT ----------------------"
Say ""
Say "  They are two different mechanisms, and only one of them reads the"
Say "  drag threshold."
Say ""
Say "    The MOUSE asks Windows how far you moved before it decides you"
Say "    meant to drag. That is the drag threshold, and raising it works."
Say ""
Say "    The TOUCHPAD has its own gesture -- tap twice and hold -- and the"
Say "    touchpad driver starts the drag itself. It never asks Windows"
Say "    about the threshold, so no number could ever have fixed it."
Say ""

$before = Get-Val 'TapAndDrag'
$aap    = Get-Val 'AAPThreshold'

Say "-- BEFORE -------------------------------------------------------------"
Say ("  TapAndDrag   : " + (Show $before) + "   (1 = on, 0 = off)")
Say ("  AAPThreshold : " + (Show $aap) + "   (touchpad sensitivity -- reported only)")
Say ""

if ($ReportOnly) {
    Say "  REPORT ONLY -- nothing was changed."
    $log | Set-Content -LiteralPath $outFile -Encoding UTF8
    Say ""
    Say ("  Saved to: " + $outFile)
    return
}

$target = 0
if ($Revert) { $target = 1 }

if ($Revert) {
    Say "-- TURNING TAP-AND-DRAG BACK ON --------------------------------------"
} else {
    Say "-- TURNING TAP-AND-DRAG OFF ------------------------------------------"
    Say ""
    Say "  What you keep: tapping the touchpad still clicks. Pressing the"
    Say "  touchpad down and moving still drags, deliberately."
    Say ""
    Say "  What stops: a light double-tap will no longer pick a folder up"
    Say "  and carry it."
}
Say ""

try {
    Set-ItemProperty -LiteralPath $key -Name 'TapAndDrag' -Value $target -Type DWord -Force -ErrorAction Stop
} catch {
    Say ("  FAILED: " + $_.Exception.Message)
    Say "  Nothing was changed."
    $log | Set-Content -LiteralPath $outFile -Encoding UTF8
    Say ""
    Say ("  Saved to: " + $outFile)
    return
}

$after = Get-Val 'TapAndDrag'
Say "-- AFTER --------------------------------------------------------------"
Say ("  TapAndDrag   : " + (Show $after))
Say ""

if ((Show $after) -eq [string]$target) {
    Say "  WRITTEN AND READ BACK."
} else {
    Say "  WARNING: it did not read back as expected. Check by hand."
}
Say ""

Say "-- IT MAY NEED A SIGN-OUT, AND HERE IS HOW TO TELL --------------------"
Say ""
Say "  The touchpad driver reads this when it starts. If tap-and-drag still"
Say "  works right now, sign out and back in, then try again."
Say ""
Say "  To see it in Windows: Settings > Bluetooth and devices > Touchpad,"
Say "  then open Taps. The box for tapping twice and dragging should now be"
Say "  clear. If Settings still shows it ticked, sign out and back in."
Say ""

Say "-- THE OTHER LEVER, REPORTED AND NOT TOUCHED --------------------------"
Say ""
Say ("  Touchpad sensitivity is currently " + (Show $aap) + ".")
Say ""
Say "  A higher number makes the touchpad ignore lighter contact, which"
Say "  helps if a palm or a sleeve is brushing it. It also makes deliberate"
Say "  taps harder to land, so it is a genuine trade-off rather than a"
Say "  free improvement -- which is why this script leaves it alone."
Say ""
Say "  To change it yourself: Settings > Bluetooth and devices > Touchpad,"
Say "  and pick from the Touchpad sensitivity list. Try one step at a time."
Say ""

Say "-- TO UNDO ------------------------------------------------------------"
Say "  Double-click Run-SetTouchpadDrag-Revert.bat."
Say ""
Say "-- IF A FOLDER EVER DOES MOVE BY ACCIDENT -----------------------------"
Say "  Press Ctrl+Z in File Explorer straight away. That undoes the move"
Say "  and puts the folder back where it was."
Say "======================================================================"

$log | Set-Content -LiteralPath $outFile -Encoding UTF8
Say ""
Say ("  Saved to: " + $outFile)
