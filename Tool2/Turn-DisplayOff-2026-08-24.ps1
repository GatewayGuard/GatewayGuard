# FILE:    Turn-DisplayOff-2026-08-24.ps1
# Dated:   2026-08-24 03:20 ET
# PURPOSE: Turn the display off NOW, on demand, and leave the machine running.
#
# NOT READ-ONLY in the sense that it changes the screen state -- but it
# changes NO settings, writes nothing, and needs no administrator.
# Move the mouse or press a key and the display comes straight back.
#
# WHY THIS EXISTS. Set-StayAwake-2026-08-24.ps1 set a 10-minute idle
# timeout, and Bill's reaction was that it "did nothing to the display."
# It had done exactly what it was told: 0x258 = 600 seconds, both AC and DC,
# verified by read-back. But an idle timeout resets on every keystroke, so
# somebody sitting at the keyboard never sees it. A timeout is the wrong
# tool for "I am walking away now."
#
# THE COUNTDOWN IS NOT DECORATION. Releasing the Enter key that launched
# this script counts as input, and input wakes the display. Without a few
# seconds of grace the screen blinks off and straight back on.

param(
    [int]$CountdownSeconds = 5
)

$ErrorActionPreference = "Stop"

if (-not ("GGDisplay" -as [type])) {
    Add-Type -Namespace "" -Name "GGDisplay" -MemberDefinition @"
[System.Runtime.InteropServices.DllImport("user32.dll", CharSet = System.Runtime.InteropServices.CharSet.Auto)]
public static extern int SendMessage(int hWnd, int hMsg, int wParam, int lParam);
"@
}

# HWND_BROADCAST = 0xFFFF, WM_SYSCOMMAND = 0x0112,
# SC_MONITORPOWER = 0xF170, and 2 = power off.
$HWND_BROADCAST  = 0xFFFF
$WM_SYSCOMMAND   = 0x0112
$SC_MONITORPOWER = 0xF170
$POWER_OFF       = 2

Write-Host ""
Write-Host "  TURN THE DISPLAY OFF" -ForegroundColor Cyan
Write-Host ""
Write-Host "  The computer keeps running. Nothing is closed and nothing is saved"
Write-Host "  or changed. Move the mouse or press any key to bring the screen back."
Write-Host ""
Write-Host "  TAKE YOUR HAND OFF THE MOUSE AND KEYBOARD NOW." -ForegroundColor Yellow
Write-Host "  Touching either one during the countdown cancels the blackout,"
Write-Host "  because Windows treats it as you coming back."
Write-Host ""

for ($i = $CountdownSeconds; $i -gt 0; $i--) {
    Write-Host ("`r  Screen goes off in {0} second{1}...  " -f $i, $(if ($i -eq 1) { "" } else { "s" })) -NoNewline -ForegroundColor Gray
    Start-Sleep -Seconds 1
}
Write-Host "`r  Turning the display off now.                    " -ForegroundColor Green

[GGDisplay]::SendMessage($HWND_BROADCAST, $WM_SYSCOMMAND, $SC_MONITORPOWER, $POWER_OFF) | Out-Null

Start-Sleep -Seconds 2
Write-Host ""
Write-Host "  Sent. If the screen is still on, this model ignores the monitor-off"
Write-Host "  message -- close the lid instead, or wait out the 10-minute idle"
Write-Host "  timeout that Set-StayAwake already configured."
Write-Host ""
