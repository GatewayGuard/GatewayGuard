# FILE:   Test-MouseSettings-2026-09-04-2103.ps1
# Dated:  2026-09-04 21:03 ET
# PURPOSE: Report every mouse setting this project has ever set, and say for
#          each one whether it is actually in force RIGHT NOW.
#
# READ-ONLY. It changes nothing. It does not need administrator and never
#          elevates. Safe to run on any machine, at any time.
#
# WHY IT EXISTS: on 2026-09-04 the drag threshold was believed not to have
#          worked. The registry is only half the answer -- Windows caches
#          these values for the session, so a value can be stored and not yet
#          in force. This script reports BOTH, side by side, plus the three
#          settings that can defeat a correct drag threshold.
#
# PS 5.1 COMPATIBLE: -join only, no Join-String, no ternary.

$ErrorActionPreference = 'Continue'

$stamp   = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$outDir  = Join-Path (Split-Path $PSScriptRoot -Parent) 'Test_Results'
if (-not (Test-Path -LiteralPath $outDir)) { $outDir = $PSScriptRoot }
$outFile = Join-Path $outDir ("MouseSettings-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

$log = New-Object System.Collections.Generic.List[string]
function Say([string]$t) { Write-Host $t; $log.Add($t) }

function Get-Val { param($k,$n)
    try { $p = Get-ItemProperty -LiteralPath $k -ErrorAction Stop; return $p.$n } catch { return $null }
}
function Show { param($n)
    if ($null -eq $n) { return '(not set)' }
    return [string]$n
}

Say "======================================================================"
Say "  MOUSE SETTINGS -- WHAT IS STORED, AND WHAT IS ACTUALLY IN FORCE"
Say "======================================================================"
Say ("  machine  : " + $env:COMPUTERNAME)
Say ("  user     : " + $env:USERNAME)
Say ("  run at   : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
try {
    $boot = (Get-CimInstance Win32_OperatingSystem -ErrorAction Stop).LastBootUpTime
    Say ("  booted   : " + (Get-Date $boot -Format 'yyyy-MM-dd HH:mm:ss'))
} catch { Say "  booted   : (could not read)" }
Say ""
Say "  READ-ONLY. Nothing on this PC was changed by running this."
Say ""

# ---------------------------------------------------------------- effective
Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue
$si = [System.Windows.Forms.SystemInformation]

Say "======================================================================"
Say "  1. THE DRAG THRESHOLD -- the one that stops folders moving by slip"
Say "======================================================================"
Say ""

$regH = Get-Val 'HKCU:\Control Panel\Desktop' 'DragHeight'
$regW = Get-Val 'HKCU:\Control Panel\Desktop' 'DragWidth'
$eff  = $si::DragSize

Say ("  STORED in the registry  : DragHeight " + (Show $regH) + " , DragWidth " + (Show $regW))
Say ("  IN FORCE right now      : height " + $eff.Height + " , width " + $eff.Width + " pixels")
Say ""
Say "  Windows default is 4. This project sets 30."
Say ""

$storedOk = ((Show $regH) -eq '30' -and (Show $regW) -eq '30')
$liveOk   = ($eff.Height -ge 30 -and $eff.Width -ge 30)

if ($storedOk -and $liveOk) {
    Say "  RESULT: SET AND WORKING. Both stored and in force at 30 pixels."
    Say "          You must move the mouse about 8 mm with the button held"
    Say "          down before Windows will drag anything."
} elseif ($storedOk -and -not $liveOk) {
    Say "  RESULT: STORED BUT NOT YET IN FORCE."
    Say "          The value is saved but this sign-in session is still using"
    Say "          the old one. Sign out and sign back in, or restart."
} elseif (-not $storedOk -and $liveOk) {
    Say "  RESULT: IN FORCE BUT NOT STORED. It will be lost at next sign-in."
    Say "          Run Run-SetDragThreshold.bat to store it."
} else {
    Say "  RESULT: NOT SET. Folders can still be moved by a small hand slip."
    Say "          Run Run-SetDragThreshold.bat, then sign out and back in."
}
Say ""

# ------------------------------------------------- what can defeat it
Say "======================================================================"
Say "  2. THE THREE THINGS THAT CAN DEFEAT A CORRECT DRAG THRESHOLD"
Say "======================================================================"
Say ""
Say "  A 30-pixel threshold is not the whole story. Each of these can still"
Say "  let a folder move, and none of them is obvious."
Say ""

# ClickLock
$cl     = Get-Val 'HKCU:\Control Panel\Desktop' 'ClickLock'
$clTime = Get-Val 'HKCU:\Control Panel\Desktop' 'ClickLockTime'
Say "  -- ClickLock (Settings, Mouse, Turn on ClickLock) -------------------"
Say ("     stored : " + (Show $cl) + "   hold time : " + (Show $clTime) + " ms")
if ((Show $cl) -eq '1') {
    Say "     ON. THIS DEFEATS THE DRAG THRESHOLD COMPLETELY. With ClickLock"
    Say "     on, holding the button briefly locks it DOWN, and everything"
    Say "     the pointer touches after that is dragged. Turn it off."
} else {
    Say "     Off. Good -- this is not what is moving your folders."
}
Say ""

# Touchpad tap-and-drag
$ptp = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad'
$tapDrag = Get-Val $ptp 'TapAndDrag'
$hasPtp  = Test-Path -LiteralPath $ptp
Say "  -- Touchpad tap-and-drag -------------------------------------------"
if (-not $hasPtp) {
    Say "     No precision touchpad on this PC. Not applicable."
} else {
    Say ("     TapAndDrag : " + (Show $tapDrag) + "   (1 = on, 0 = off)")
    if ((Show $tapDrag) -eq '1') {
        Say "     ON, AND THIS IS A CONFIRMED CAUSE."
        Say ""
        Say "     measured on CGDELL 2026-09-04: with the drag threshold at"
        Say "     200 x 200, the mouse obeyed it and the touchpad did not."
        Say "     Bill: 'working on the mouse, but not on the laptop flat"
        Say "     below keyboard mouse.'"
        Say ""
        Say "     The touchpad driver starts its own drag on a double-tap and"
        Say "     never asks Windows about the threshold, so NO number in the"
        Say "     drag-threshold script can fix the touchpad. This setting is"
        Say "     the one that governs it."
        Say ""
        Say "     Fix: run Run-SetTouchpadDrag.bat."
    } else {
        Say "     Off. The touchpad will not start a drag from a double-tap."
    }
}
Say ""

$dcs = Get-Val 'HKCU:\Control Panel\Mouse' 'DoubleClickSpeed'
Say "  -- Double-click speed, as a drag cause ------------------------------"
Say ("     stored : " + (Show $dcs) + " ms   in force : " + $si::DoubleClickTime + " ms")
if ($si::DoubleClickTime -lt 400) {
    Say "     FAST. Under 400 ms a missed double-click becomes TWO single"
    Say "     clicks, and the second one can land as a click-and-move."
} else {
    Say "     Comfortable. Not a cause."
}
Say ""

# --------------------------------------------- the Checkup mouse set
Say "======================================================================"
Say "  3. THE CHECKUP MOUSE SETTINGS (Run-MouseSetup.bat)"
Say "======================================================================"
Say ""
Say "  These are the settings that make Checkup readable in a console."
Say ""

$WANT = @(
    @{ K='HKCU:\Control Panel\Desktop'; N='MouseWheelRouting'; W='2'
       Why='Scroll what is under the pointer, with no click. Avoids FT-63.' },
    @{ K='HKCU:\Control Panel\Desktop'; N='WheelScrollLines'; W='5'
       Why='5 lines per notch instead of 3.' },
    @{ K='HKCU:\Control Panel\Mouse';   N='DoubleClickSpeed'; W='650'
       Why='A slow double-click still counts as one.' },
    @{ K='HKCU:\Control Panel\Mouse';   N='DoubleClickWidth'; W='6'
       Why='Pointer may drift 6 px between the two clicks.' },
    @{ K='HKCU:\Control Panel\Mouse';   N='DoubleClickHeight'; W='6'
       Why='Same, vertically.' },
    @{ K='HKCU:\Control Panel\Cursors'; N='CursorBaseSize'; W='64'
       Why='Large pointer.' },
    @{ K='HKCU:\Control Panel\Mouse';   N='SnapToDefaultButton'; W='1'
       Why='Pointer jumps to the default button in a dialog.' }
)

$pass = 0; $fail = 0
foreach ($w in $WANT) {
    $have = Show (Get-Val $w.K $w.N)
    if ($have -eq $w.W) { $mark = 'SET     '; $pass++ } else { $mark = 'NOT SET '; $fail++ }
    Say ("  [" + $mark + "] " + $w.N.PadRight(20) + " is " + $have.PadRight(12) + " wanted " + $w.W)
    Say ("               " + $w.Why)
}
Say ""
Say ("  " + $pass + " of " + $WANT.Count + " set as wanted, " + $fail + " not.")
if ($fail -gt 0) {
    Say "  To set them: double-click Run-MouseSetup.bat and choose S."
    Say "  It shows every change and asks first, and it can put them back."
}
Say ""

Say "======================================================================"
Say "  4. IN FORCE RIGHT NOW, straight from Windows"
Say "======================================================================"
Say ""
Say ("  Drag threshold      : " + $eff.Width + " x " + $eff.Height + " pixels")
Say ("  Double-click time   : " + $si::DoubleClickTime + " ms")
Say ("  Double-click area   : " + $si::DoubleClickSize.Width + " x " + $si::DoubleClickSize.Height + " pixels")
Say ("  Wheel scroll lines  : " + $si::MouseWheelScrollLines)
Say ("  Mouse buttons       : " + $si::MouseButtons)
Say ("  Buttons swapped     : " + $si::MouseButtonsSwapped)
Say ("  Wheel present       : " + $si::MouseWheelPresent)
Say ""
Say "  These are the numbers Windows is using at this moment. Where one of"
Say "  them disagrees with section 3, the setting is stored but has not"
Say "  taken effect yet -- sign out and sign back in."
Say "======================================================================"

$log | Set-Content -LiteralPath $outFile -Encoding UTF8
Say ""
Say ("  Saved to: " + $outFile)
