# Dated: 2026-08-13 09:52 ET
# FILE:    Check-ConsoleInputMode-2026-08-13.ps1
# Editor:  Claude Code (CGDELL)
#
# READ-ONLY. Changes nothing. Restores anything it touches.
#
# WHY THIS EXISTS
# ---------------
# The ascii39 field run on SANDY (2026-08-11) logged "Discarded 256
# keypress(es) that were already queued" eleven times, and Bill reported the
# program "crashing" twice immediately after a right-click.
#
# The logs say it did not crash. It EXITED, cleanly, because a queued input
# event was consumed as the answer to a prompt whose 'N' means "not my
# personal PC -- exit".
#
# 256 is not a measurement. It is the drain loop's own ceiling:
#
#   while ($Host.UI.RawUI.KeyAvailable -and $ggDrained -lt 256 -and ...)
#
# So "Discarded 256" means the drain STOPPED AT ITS CAP with events possibly
# still queued -- and the very next read consumes one.
#
# The suspected source is mouse input. Disable-QuickEdit clears bit 6
# (ENABLE_QUICK_EDIT_MODE) with -band 4294967231 and leaves every other bit
# alone -- including ENABLE_MOUSE_INPUT (0x0010). With that bit set, every
# mouse move, click and wheel tick becomes an INPUT_RECORD in the same 256-
# record console input buffer that keypresses use. Bill runs Checkup with a
# wireless mouse and recommends the wheel for scrolling, so the buffer fills
# from ordinary use.
#
# This script MEASURES that, rather than asserting it. Run it on SANDY, where
# the defect actually reproduced.

$ErrorActionPreference = 'Stop'

$outDir = Join-Path $PSScriptRoot '..\Test_Results'
try { $outDir = (Resolve-Path $outDir).Path } catch { $outDir = $PSScriptRoot }
$stamp   = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$outFile = Join-Path $outDir ("ConsoleInputMode-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

$lines = New-Object System.Collections.Generic.List[string]
function Say([string]$t) { Write-Host $t; $lines.Add($t) }

Say "============================================================"
Say " CONSOLE INPUT MODE CHECK"
Say " Machine : $env:COMPUTERNAME"
Say " Run     : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ET"
Say " Read-only. Nothing is changed permanently."
Say "============================================================"
Say ""

Add-Type -Namespace GGProbe -Name Native -MemberDefinition @'
[DllImport("kernel32.dll", SetLastError=true)]
public static extern IntPtr GetStdHandle(int nStdHandle);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool GetConsoleMode(IntPtr hConsoleHandle, out uint lpMode);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool GetNumberOfConsoleInputEvents(IntPtr hConsoleInput, out uint lpcNumberOfEvents);
'@

# Documented console input mode flags (Microsoft Learn, SetConsoleMode).
$FLAGS = [ordered]@{
    'ENABLE_PROCESSED_INPUT'        = 0x0001
    'ENABLE_LINE_INPUT'             = 0x0002
    'ENABLE_ECHO_INPUT'             = 0x0004
    'ENABLE_WINDOW_INPUT'           = 0x0008
    'ENABLE_MOUSE_INPUT'            = 0x0010
    'ENABLE_INSERT_MODE'            = 0x0020
    'ENABLE_QUICK_EDIT_MODE'        = 0x0040
    'ENABLE_EXTENDED_FLAGS'         = 0x0080
    'ENABLE_AUTO_POSITION'          = 0x0100
    'ENABLE_VIRTUAL_TERMINAL_INPUT' = 0x0200
}

$STD_INPUT_HANDLE = -10
$h = [GGProbe.Native]::GetStdHandle($STD_INPUT_HANDLE)
$mode = 0
$got = [GGProbe.Native]::GetConsoleMode($h, [ref]$mode)

if (-not $got) {
    Say "GetConsoleMode FAILED."
    Say ""
    Say "This almost always means there is no real console attached -- the"
    Say "script was run with its output redirected, or from an editor."
    Say "Run it by double-clicking Run-ConsoleInputModeCheck.bat instead."
    $lines | Set-Content -LiteralPath $outFile -Encoding UTF8
    Say ""
    Say "Saved to: $outFile"
    return
}

Say ("CURRENT INPUT MODE: 0x{0:X8}  ({0})" -f $mode)
Say ""
Say "  FLAG                            SET?"
Say "  ------------------------------  ----"
foreach ($k in $FLAGS.Keys) {
    $on = ($mode -band $FLAGS[$k]) -ne 0
    Say ("  {0,-30}  {1}" -f $k, $(if ($on) { 'YES' } else { ' no' }))
}

# Apply the SAME mask the build uses, in a variable only. Nothing is set.
$buildMask = 4294967231   # 0xFFFFFFBF -- clears bit 6 only
$after = $mode -band $buildMask

Say ""
Say "WHAT Disable-QuickEdit WOULD LEAVE"
Say "----------------------------------"
Say ("  The build applies:  mode -band {0}   (0x{0:X8})" -f $buildMask)
Say ("  Resulting mode:     0x{0:X8}" -f $after)
Say ""

$qeBefore = ($mode  -band 0x0040) -ne 0
$qeAfter  = ($after -band 0x0040) -ne 0
$msAfter  = ($after -band 0x0010) -ne 0

Say ("  ENABLE_QUICK_EDIT_MODE  before: {0}   after: {1}" -f $qeBefore, $qeAfter)
Say ("  ENABLE_MOUSE_INPUT      after:  {0}" -f $msAfter)
Say ""

if ($msAfter) {
    Say "  >>> ENABLE_MOUSE_INPUT SURVIVES the build's mask."
    Say ""
    Say "      Every mouse move, click and wheel tick over the window becomes"
    Say "      an INPUT_RECORD in the same 256-record input buffer keypresses"
    Say "      use. That is a queue the user fills without typing anything,"
    Say "      and the FT-149 drain caps at 256 and gives up."
} else {
    Say "  >>> ENABLE_MOUSE_INPUT is already off. Mouse events are NOT the"
    Say "      source of the queue. Look elsewhere -- key auto-repeat next."
}

# Live buffer depth, sampled. Purely observational.
Say ""
Say "LIVE INPUT BUFFER DEPTH (5 samples, 400 ms apart)"
Say "-------------------------------------------------"
Say "  Move the mouse over this window while it samples."
for ($i = 1; $i -le 5; $i++) {
    $n = 0
    [void][GGProbe.Native]::GetNumberOfConsoleInputEvents($h, [ref]$n)
    Say ("  sample {0}: {1,4} events pending" -f $i, $n)
    Start-Sleep -Milliseconds 400
}

Say ""
Say "HOW TO READ THIS"
Say "----------------"
Say "  Pending events climbing while you only move the mouse confirms the"
Say "  buffer fills from mouse activity alone. On a screen that takes a"
Say "  single key as its answer, a stale event answers the prompt -- which"
Say "  is what ended the 2026-08-11 SANDY run twice and was written up as"
Say "  a crash."

$lines | Set-Content -LiteralPath $outFile -Encoding UTF8
Say ""
Say "Saved to: $outFile"
