# FILE:   Set-DragThreshold-2026-08-31-0943.ps1
# Dated:  2026-08-31 09:43 ET
# PURPOSE: Stop File Explorer grabbing and moving a folder on a tiny mouse
#          slip, by raising how far the mouse must travel before Windows
#          decides you meant to drag.
#
# WHAT IT CHANGES: two values under HKEY_CURRENT_USER\Control Panel\Desktop --
#          DragHeight and DragWidth. Both are measured in SCREEN PIXELS.
#
# VERIFIED 2026-08-31 measured on CGDELL: both values read 4, which is the
#          Windows default. Four pixels is roughly the width of this letter I.
#          A hand that twitches while clicking a folder has already dragged it.
#
# NOT ADMIN. This is the CURRENT USER's own setting. The script does not
#          elevate and does not need to. Nothing outside your own profile is
#          touched.
#
# REVERSIBLE: run it again with -Revert to put both values back to 4.

[CmdletBinding()]
param(
    [ValidateRange(4, 200)]
    [int]$Pixels = 30,
    [switch]$Revert,
    [switch]$ReportOnly
)

$ErrorActionPreference = 'Stop'
$key = 'HKCU:\Control Panel\Desktop'

# -- results go to a file as well as the screen, so nothing is lost to
#    console scrollback (project rule, 2026-07-30)
$stamp   = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$outDir  = Join-Path (Split-Path $PSScriptRoot -Parent) 'Test_Results'
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }
$outFile = Join-Path $outDir ("DragThreshold-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

$log = New-Object System.Collections.Generic.List[string]
function Say([string]$t) { Write-Host $t; $log.Add($t) }

Say "======================================================================"
Say "  MOUSE DRAG THRESHOLD -- how far the mouse must move before Windows"
Say "  treats a click as a drag."
Say "======================================================================"
Say ("  machine : " + $env:COMPUTERNAME)
Say ("  user    : " + $env:USERNAME)
Say ("  run at  : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Say ""

function Get-Current {
    $p = Get-ItemProperty -Path $key -ErrorAction SilentlyContinue
    $h = if ($null -ne $p.DragHeight) { [string]$p.DragHeight } else { '(not set -- Windows uses 4)' }
    $w = if ($null -ne $p.DragWidth)  { [string]$p.DragWidth  } else { '(not set -- Windows uses 4)' }
    return @{ H = $h; W = $w }
}

$before = Get-Current
Say "-- BEFORE -------------------------------------------------------------"
Say ("  DragHeight : " + $before.H + "   (pixels up/down)")
Say ("  DragWidth  : " + $before.W + "   (pixels left/right)")
Say ""

if ($ReportOnly) {
    Say "  REPORT ONLY -- nothing was changed."
    Say ""
    $log | Set-Content -LiteralPath $outFile -Encoding UTF8
    Say ("  Saved to: " + $outFile)
    return
}

$target = if ($Revert) { 4 } else { $Pixels }

if ($Revert) {
    Say "-- REVERTING to the Windows default of 4 pixels ----------------------"
} else {
    Say ("-- SETTING both values to " + $target + " pixels ----------------------------------")
    Say ""
    Say "  What this means in plain terms:"
    Say ("  You will have to move the mouse " + $target + " pixels -- about " + [math]::Round($target/96*25.4,1) + " mm on a")
    Say "  standard-density screen -- with the button held down before Windows"
    Say "  starts dragging anything. A normal click, and a small twitch during"
    Say "  a click, will no longer move a folder."
    Say ""
    Say "  Deliberate drag-and-drop still works. It just needs to look"
    Say "  deliberate."
}
Say ""

try {
    Set-ItemProperty -Path $key -Name 'DragHeight' -Value ([string]$target) -Type String -Force -ErrorAction Stop
    Set-ItemProperty -Path $key -Name 'DragWidth'  -Value ([string]$target) -Type String -Force -ErrorAction Stop
} catch {
    Say ("  FAILED: " + $_.Exception.Message)
    Say "  Nothing was changed."
    $log | Set-Content -LiteralPath $outFile -Encoding UTF8
    Say ("  Saved to: " + $outFile)
    return
}

$after = Get-Current
Say "-- AFTER --------------------------------------------------------------"
Say ("  DragHeight : " + $after.H)
Say ("  DragWidth  : " + $after.W)
Say ""

if ($after.H -eq [string]$target -and $after.W -eq [string]$target) {
    Say "  WRITTEN AND READ BACK. Both values confirmed."
} else {
    Say "  WARNING: the values did not read back as expected. Check by hand."
}
Say ""
Say "-- ONE MORE STEP, AND IT IS NOT OPTIONAL ------------------------------"
Say "  Windows reads these values when you sign in, so nothing changes"
Say "  until you SIGN OUT and SIGN BACK IN (or restart the PC)."
Say ""
Say "  Start > your name > Sign out.  Then sign back in and try to nudge a"
Say "  folder. It should not move."
Say ""
Say "-- TO UNDO ------------------------------------------------------------"
Say "  Run this again by double-clicking Run-SetDragThreshold-Revert.bat,"
Say "  which puts both values back to 4. Sign out and in again afterwards."
Say ""
Say "-- ALSO WORTH KNOWING -------------------------------------------------"
Say "  If a folder ever does move by accident, press Ctrl+Z in File"
Say "  Explorer straight away. That undoes the move and puts it back."
Say "======================================================================"

$log | Set-Content -LiteralPath $outFile -Encoding UTF8
Say ""
Say ("  Saved to: " + $outFile)
