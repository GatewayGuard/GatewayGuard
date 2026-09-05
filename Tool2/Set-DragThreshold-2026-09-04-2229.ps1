# FILE:   Set-DragThreshold-2026-09-04-2229.ps1
# Dated:  2026-09-04 22:29 ET
#
# SUPERSEDES Set-DragThreshold-2026-08-31-0943.ps1. Two changes, both because
# Bill reported on 2026-09-04 that setting it to 30 was "not doing anything":
#
#   1. IT NOW TAKES EFFECT IMMEDIATELY. The old script wrote the registry and
#      nothing else, so the change waited for a sign-out. This one also calls
#      SystemParametersInfo, which pushes the value into the running system.
#      It then proves it by reading the value back in a SEPARATE PowerShell
#      process -- reading it in this one would only report what this process
#      cached at start.
#
#   2. THE CAP IS NOW 500 PIXELS, was 200.
#
# WHAT IS HONESTLY NOT KNOWN, and it is the thing that matters:
#
#   These two values are SM_CXDRAG and SM_CYDRAG. A program uses them by
#   calling DragDetect(), and a program is FREE NOT TO. Windows does not
#   enforce a drag threshold on every window. It has NOT been verified that
#   Windows 11's File Explorer honours them -- Explorer was rebuilt on a newer
#   input stack, and it may use its own threshold.
#
#   So if 30 did nothing, 200 may also do nothing, and that would not mean
#   the setting failed to apply. It would mean Explorer is not reading it.
#   THAT IS THE QUESTION THIS SCRIPT IS DESIGNED TO SETTLE, by making the
#   value large enough that honouring it would be unmistakable.
#
#   Test it like this: set it to 200, then try to drag a folder in File
#   Explorer. 200 pixels is about 5 cm. If a folder still moves on a short
#   flick, Explorer is ignoring the setting and the answer lies elsewhere.
#
# NOT ADMIN. This is the current user's own setting. No elevation, ever.
# REVERSIBLE: run with -Revert to put both values back to 4, live.
# REPORT ONLY: run with -ReportOnly to see the state and change nothing.
#
# PS 5.1 COMPATIBLE: -join only, no Join-String, no ternary.

[CmdletBinding()]
param(
    [ValidateRange(4, 500)]
    [int]$Pixels = 200,
    [switch]$Revert,
    [switch]$ReportOnly
)

$ErrorActionPreference = 'Stop'
$key = 'HKCU:\Control Panel\Desktop'

$stamp   = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$outDir  = Join-Path (Split-Path $PSScriptRoot -Parent) 'Test_Results'
if (-not (Test-Path -LiteralPath $outDir)) { $outDir = $PSScriptRoot }
$outFile = Join-Path $outDir ("DragThreshold-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

$log = New-Object System.Collections.Generic.List[string]
function Say([string]$t) { Write-Host $t; $log.Add($t) }

# SystemParametersInfo -- pushes the value into the running system so the
# change does not wait for a sign-out. GetSystemMetrics reads the live value
# back, which is the only honest proof that the push worked.
#
# VERIFIED 2026-09-04 measured on CGDELL. The action codes below were tested
# by calling them and reading SM_CXDRAG/SM_CYDRAG afterwards:
#   0x004C sets drag WIDTH  -- returned True, SM_CXDRAG went 30 -> 200.
#   0x004D sets drag HEIGHT -- returned True, SM_CYDRAG went 30 -> 200.
#   0x004E FAILS. It returns False with error 1439, ERROR_INVALID_SPI_VALUE.
# The first version of this script used 0x004E for height on the strength of
# its name, and the result was a threshold of 200 wide by 30 tall -- which
# behaves like no change at all, because a drag only has to beat ONE axis.
# Do not "correct" 0x004D back to 0x004E without re-running that measurement.
#
#   SPIF_UPDATEINIFILE (1) + SPIF_SENDCHANGE (2) = 3
Add-Type -Namespace GGDrag -Name Spi -MemberDefinition @'
[DllImport("user32.dll", SetLastError=true)]
public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, IntPtr pvParam, uint fWinIni);
[DllImport("user32.dll")]
public static extern int GetSystemMetrics(int nIndex);
'@ -ErrorAction SilentlyContinue

$SPI_SETDRAGWIDTH  = 0x004C
$SPI_SETDRAGHEIGHT = 0x004D
$SPIF_UPDATE       = 0x0003
$SM_CXDRAG         = 68
$SM_CYDRAG         = 69

function Get-Stored {
    $p = Get-ItemProperty -Path $key -ErrorAction SilentlyContinue
    $h = '(not set -- Windows uses 4)'
    $w = '(not set -- Windows uses 4)'
    if ($null -ne $p.DragHeight) { $h = [string]$p.DragHeight }
    if ($null -ne $p.DragWidth)  { $w = [string]$p.DragWidth }
    return @{ H = $h; W = $w }
}

# Read the LIVE value straight from Windows. GetSystemMetrics is not cached
# by .NET -- it asks the system each time -- so this reports what is actually
# in force at this instant, not what the registry says it should be.
#
# An earlier version of this launched a second PowerShell process to read the
# value. It always returned "(could not read)": passing a format string like
# "{0}x{1}" through -Command loses its quotes on the way, and the child died
# on a parse error. Reading the metric directly needs no child at all.
function Get-Live {
    try {
        $w = [GGDrag.Spi]::GetSystemMetrics($SM_CXDRAG)
        $h = [GGDrag.Spi]::GetSystemMetrics($SM_CYDRAG)
        return ([string]$w + "x" + [string]$h)
    } catch {
        return '(could not read)'
    }
}

Say "======================================================================"
Say "  MOUSE DRAG THRESHOLD -- how far the mouse must move before Windows"
Say "  treats a click as a drag."
Say "======================================================================"
Say ("  machine : " + $env:COMPUTERNAME)
Say ("  user    : " + $env:USERNAME)
Say ("  run at  : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Say ""

$before     = Get-Stored
$beforeLive = Get-Live
Say "-- BEFORE -------------------------------------------------------------"
Say ("  stored in registry : DragHeight " + $before.H + " , DragWidth " + $before.W)
Say ("  live in Windows    : " + $beforeLive + "  (width x height, in pixels)")
Say ""

if ($ReportOnly) {
    Say "  REPORT ONLY -- nothing was changed."
    $log | Set-Content -LiteralPath $outFile -Encoding UTF8
    Say ""
    Say ("  Saved to: " + $outFile)
    return
}

$target = $Pixels
if ($Revert) { $target = 4 }

if ($Revert) {
    Say "-- REVERTING to the Windows default of 4 pixels ----------------------"
} else {
    Say ("-- SETTING both values to " + $target + " pixels --------------------------------")
    Say ""
    $mm = [math]::Round($target / 96 * 25.4, 1)
    Say ("  You will have to move the mouse " + $target + " pixels -- about " + $mm + " mm on a")
    Say "  standard-density screen -- with the button held down before Windows"
    Say "  will start dragging. A normal click, and a twitch during a click,"
    Say "  will not move a folder."
    Say ""
    Say "  Deliberate drag-and-drop still works. It just has to look"
    Say "  deliberate."
}
Say ""

# 1. store it, so it survives a sign-out
try {
    Set-ItemProperty -Path $key -Name 'DragHeight' -Value ([string]$target) -Type String -Force -ErrorAction Stop
    Set-ItemProperty -Path $key -Name 'DragWidth'  -Value ([string]$target) -Type String -Force -ErrorAction Stop
    Say "  [1 of 2] Written to the registry, so it survives a sign-out."
} catch {
    Say ("  FAILED to write the registry: " + $_.Exception.Message)
    Say "  Nothing was changed."
    $log | Set-Content -LiteralPath $outFile -Encoding UTF8
    Say ""
    Say ("  Saved to: " + $outFile)
    return
}

# 2. push it into the running system, so it works NOW
$okW = $false
$okH = $false
try {
    $okW = [GGDrag.Spi]::SystemParametersInfo($SPI_SETDRAGWIDTH,  [uint32]$target, [IntPtr]::Zero, $SPIF_UPDATE)
    $okH = [GGDrag.Spi]::SystemParametersInfo($SPI_SETDRAGHEIGHT, [uint32]$target, [IntPtr]::Zero, $SPIF_UPDATE)
} catch {
    Say ("  SystemParametersInfo threw: " + $_.Exception.Message)
}
if ($okW -and $okH) {
    Say "  [2 of 2] Pushed into the running system. No sign-out needed."
} else {
    Say "  [2 of 2] The live update did not report success. The value is still"
    Say "           stored, so it will take effect after a sign-out."
}
Say ""

$after     = Get-Stored
$afterLive = Get-Live
Say "-- AFTER --------------------------------------------------------------"
Say ("  stored in registry : DragHeight " + $after.H + " , DragWidth " + $after.W)
Say ("  live in Windows    : " + $afterLive + "   <-- asked Windows just now")
Say ""

$wantLive = ([string]$target) + "x" + ([string]$target)
$storedOk = ($after.H -eq [string]$target -and $after.W -eq [string]$target)
$liveOk   = ($afterLive -eq $wantLive)

if ($storedOk -and $liveOk) {
    Say ("  CONFIRMED. Stored and live, both at " + $target + ".")
    Say ""
    Say "  NOW TEST IT, and this is the part that actually answers the"
    Say "  question. Open File Explorer and try to nudge a folder with a"
    Say "  short flick of the mouse."
    Say ""
    Say "    - If the folder does NOT move, the setting is working."
    Say "    - If the folder STILL moves, then File Explorer is ignoring"
    Say "      this setting, and no number will fix it. Say so, and the"
    Say "      answer has to be found somewhere else. That is a real"
    Say "      result, not a failure."
} elseif ($storedOk) {
    Say ("  Stored correctly, but the live value still reads " + $afterLive + ".")
    Say "  Sign out and back in, then run this again with -ReportOnly."
} else {
    Say "  WARNING: the stored values did not read back as expected."
}
Say ""
Say "-- TO UNDO ------------------------------------------------------------"
Say "  Double-click Run-SetDragThreshold-Revert.bat. It puts both values"
Say "  back to 4 and applies that immediately too."
Say ""
Say "-- IF A FOLDER EVER DOES MOVE BY ACCIDENT -----------------------------"
Say "  Press Ctrl+Z in File Explorer straight away. That undoes the move"
Say "  and puts the folder back where it was."
Say "======================================================================"

$log | Set-Content -LiteralPath $outFile -Encoding UTF8
Say ""
Say ("  Saved to: " + $outFile)
