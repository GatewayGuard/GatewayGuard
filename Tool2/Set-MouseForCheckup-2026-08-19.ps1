# Set-MouseForCheckup-2026-08-19.ps1
# Dated: 2026-08-19 19:00 ET
#
# WHAT IT DOES: sets the Windows mouse options that matter when running
# Checkup in a console window, for a reader with older eyes and hands.
#
# IT ALWAYS SHOWS YOU THE CHANGES AND ASKS BEFORE APPLYING ANY OF THEM, and it
# writes an undo file first. Run it again with  -Undo  to put everything back.
#
# DOES NOT NEED ADMINISTRATOR -- every value is per-user (HKCU).
# NEVER self-elevates. Touches nothing outside the mouse settings below.
# PS 5.1 COMPATIBLE: -join only, no Join-String, no ternary.
#
# WHY THESE VALUES -- measured on CGDELL 2026-08-19, and two of them are
# actively working against Checkup today:
#
#   MouseWheelRouting was 0. That means the wheel scrolls only the ACTIVE
#   window, so you must CLICK the console before you can scroll it. Clicking a
#   console window is what starts a text selection -- which is FT-63, the
#   selection that freezes the program on its next write. Setting it to 2
#   scrolls whatever is under the pointer, with no click at all. This is the
#   single most useful change on the list for Checkup.
#
#   DoubleClickSpeed was 200 ms. Windows' default is 500. At 200 a double-click
#   must land inside a fifth of a second, which is hard for anyone and harder
#   with age -- and when it misses, Windows sees TWO SINGLE CLICKS. In a
#   console two single clicks start a selection and then extend it. That is a
#   direct contributor to "the screen went crazy".
#
# Sources for the senior-accessibility values are in the .md written beside
# the results file.

param([switch]$Undo)

# NOTE 2026-08-19: the collection below was called $undo, which IS the -Undo
# switch parameter -- PowerShell variable names are case-insensitive. Assigning
# an array to a SwitchParameter threw, the undo file was written containing the
# word "False", and the settings were applied with no way back. Renamed
# $ggUndoLines. A switch parameter and a working variable must never differ
# only by case.

$ErrorActionPreference = 'Continue'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projRoot  = Split-Path -Parent $scriptDir
$outDir    = Join-Path $projRoot 'Test_Results'
if (-not (Test-Path -LiteralPath $outDir)) { $outDir = $scriptDir }
$undoFile  = Join-Path $scriptDir ("MouseSettings-UNDO-" + $env:COMPUTERNAME + ".txt")

# SystemParametersInfo so the changes take effect NOW rather than at sign-out.
Add-Type -Namespace GG -Name SPI -MemberDefinition @'
[DllImport("user32.dll", SetLastError=true)]
public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, IntPtr pvParam, uint fWinIni);
'@
$SPI_SETDOUBLECLICKTIME = 0x0020
$SPI_SETWHEELSCROLLLINES = 0x0069
$SPIF_UPDATE = 0x03   # write to profile + broadcast the change

# key, value name, desired, why
$WANT = @(
    @{ Key='HKCU:\Control Panel\Desktop'; Name='MouseWheelRouting'; Want='2'; Type='DWord'
       Why='Scroll whatever is under the pointer. No click needed, so no accidental selection.' },
    @{ Key='HKCU:\Control Panel\Desktop'; Name='WheelScrollLines'; Want='5'; Type='String'
       Why='5 lines per notch instead of 3 -- fewer turns to read a long screen.' },
    @{ Key='HKCU:\Control Panel\Mouse';   Name='DoubleClickSpeed'; Want='650'; Type='String'
       Why='650 ms. A slow double-click still counts as one, instead of two selections.' },
    @{ Key='HKCU:\Control Panel\Mouse';   Name='DoubleClickWidth'; Want='6'; Type='String'
       Why='Allows the pointer to drift 6 px between clicks instead of 4.' },
    @{ Key='HKCU:\Control Panel\Mouse';   Name='DoubleClickHeight'; Want='6'; Type='String'
       Why='Same, vertically. Hands are not steady on a second click.' },
    @{ Key='HKCU:\Control Panel\Cursors'; Name='CursorBaseSize'; Want='64'; Type='DWord'
       Why='Large pointer. Already set on this PC -- listed so it is checked, not assumed.' },
    @{ Key='HKCU:\Control Panel\Mouse';   Name='SnapToDefaultButton'; Want='1'; Type='String'
       Why='The pointer jumps to the default button in a dialog. One less thing to hunt for.' }
)

function Get-Val { param($k,$n)
    try { return (Get-ItemProperty -LiteralPath $k -EA Stop).$n } catch { return $null }
}

Write-Host ""
Write-Host "============================================================"
Write-Host "  MOUSE SETUP FOR RUNNING CHECKUP"
Write-Host "============================================================"
Write-Host ("  Computer : " + $env:COMPUTERNAME)
Write-Host ("  Run      : " + (Get-Date -Format 'yyyy-MM-dd HH:mm'))
Write-Host ""

# ---------------- UNDO ----------------
if ($Undo) {
    if (-not (Test-Path -LiteralPath $undoFile)) {
        Write-Host "  There is no undo file for this PC, so nothing was changed by"
        Write-Host "  this script here. Nothing to put back."
        Write-Host ""
        Write-Host "  Press Enter to close."
        $null = Read-Host
        return
    }
    Write-Host "  Putting your previous settings back..."
    Write-Host ""
    # A file written by the 2026-08-19 buggy version contains the single word
    # "False" -- $undo WAS the -Undo switch parameter, so the array assignment
    # threw and the switch's own value got written instead. Such a file matches
    # no line below, restores nothing, and the old code then deleted it and
    # printed "Done" -- telling the user their settings were back when nothing
    # had been touched. Count what is actually restored and say so.
    $ggRestored = 0
    foreach ($line in (Get-Content -LiteralPath $undoFile)) {
        if ($line -match '^(.+?)\|(.+?)\|(.*)$') {
            $ggRestored++
            $k = $Matches[1]; $n = $Matches[2]; $v = $Matches[3]
            try {
                if ($v -eq '<absent>') {
                    Remove-ItemProperty -LiteralPath $k -Name $n -EA SilentlyContinue
                    Write-Host ("    {0,-22} removed (it was not set before)" -f $n)
                } else {
                    Set-ItemProperty -LiteralPath $k -Name $n -Value $v -EA Stop
                    Write-Host ("    {0,-22} back to {1}" -f $n, $v)
                }
            } catch { Write-Host ("    {0,-22} COULD NOT RESTORE: {1}" -f $n, $_.Exception.Message) }
        }
    }
    if ($ggRestored -eq 0) {
        Write-Host "  NOTHING WAS RESTORED." -ForegroundColor Red
        Write-Host ""
        Write-Host "  The undo file for this PC is unreadable. It was written by a"
        Write-Host "  version of this script that had a fault, so your previous mouse"
        Write-Host "  values were never recorded and cannot be recovered from it."
        Write-Host ""
        Write-Host "  Your settings have NOT been changed by this run. If you want to"
        Write-Host "  go back to Windows' own defaults, set them by hand in:"
        Write-Host "    Settings > Bluetooth & devices > Mouse"
        Write-Host "    Settings > Accessibility > Mouse pointer and touch"
        Write-Host ""
        Write-Host "  The file has been left in place, not deleted, so nothing is lost."
        Write-Host ""
        Write-Host "  Press Enter to close."
        $null = Read-Host
        return
    }
    Remove-Item -LiteralPath $undoFile -Force -EA SilentlyContinue
    Write-Host ""
    Write-Host ("  Done -- " + $ggRestored + " setting(s) restored. Sign out and back in for")
    Write-Host "  every one of them to take effect."
    Write-Host ""
    Write-Host "  Press Enter to close."
    $null = Read-Host
    return
}

# ---------------- SHOW ----------------
Write-Host "  These are the settings and what they are now:"
Write-Host ""
$changes = @()
foreach ($w in $WANT) {
    $cur = Get-Val $w.Key $w.Name
    $curS = if ($null -eq $cur) { '<not set>' } else { [string]$cur }
    if ($curS -eq $w.Want) {
        Write-Host ("    {0,-22} {1,-10} already correct" -f $w.Name, $curS) -ForegroundColor DarkGray
    } else {
        Write-Host ("    {0,-22} {1,-10} -> {2}" -f $w.Name, $curS, $w.Want) -ForegroundColor Cyan
        Write-Host ("      {0}" -f $w.Why) -ForegroundColor Gray
        $changes += $w
    }
}
Write-Host ""

if ($changes.Count -eq 0) {
    Write-Host "  Everything is already set the way Checkup likes it. Nothing to do."
    Write-Host ""
    Write-Host "  Press Enter to close."
    $null = Read-Host
    return
}

Write-Host ("  " + $changes.Count + " setting(s) would change. Your current values are saved first,")
Write-Host "  and you can put them all back by running this again with -Undo."
Write-Host ""
Write-Host "  Apply these changes? (Y = yes / N = no): " -NoNewline -ForegroundColor White
$ans = Read-Host
if ($ans.ToUpper().Trim() -ne 'Y') {
    Write-Host ""
    Write-Host "  Nothing was changed."
    Write-Host ""
    Write-Host "  Press Enter to close."
    $null = Read-Host
    return
}

# ---------------- APPLY ----------------
$ggUndoLines = @()
foreach ($w in $changes) {
    $cur = Get-Val $w.Key $w.Name
    $ggUndoLines += ($w.Key + '|' + $w.Name + '|' + $(if ($null -eq $cur) { '<absent>' } else { [string]$cur }))
}
$ggUndoLines -join "`r`n" | Out-File -FilePath $undoFile -Encoding UTF8 -Force
Write-Host ""
Write-Host ("  Previous values saved to: " + (Split-Path $undoFile -Leaf))
Write-Host ""

foreach ($w in $changes) {
    try {
        if (-not (Test-Path -LiteralPath $w.Key)) { New-Item -Path $w.Key -Force | Out-Null }
        Set-ItemProperty -LiteralPath $w.Key -Name $w.Name -Value $w.Want -Type $w.Type -EA Stop
        Write-Host ("    {0,-22} set to {1}" -f $w.Name, $w.Want) -ForegroundColor Green
    } catch {
        Write-Host ("    {0,-22} FAILED: {1}" -f $w.Name, $_.Exception.Message) -ForegroundColor Red
    }
}

# Make the two that support it take effect immediately.
try {
    $dc = ($WANT | Where-Object { $_.Name -eq 'DoubleClickSpeed' }).Want
    [void][GG.SPI]::SystemParametersInfo($SPI_SETDOUBLECLICKTIME, [uint32]$dc, [IntPtr]::Zero, $SPIF_UPDATE)
    $wl = ($WANT | Where-Object { $_.Name -eq 'WheelScrollLines' }).Want
    [void][GG.SPI]::SystemParametersInfo($SPI_SETWHEELSCROLLLINES, [uint32]$wl, [IntPtr]::Zero, $SPIF_UPDATE)
    $dw = ($WANT | Where-Object { $_.Name -eq 'DoubleClickWidth' }).Want
    [void][GG.SPI]::SystemParametersInfo(0x001D, [uint32]$dw, [IntPtr]::Zero, $SPIF_UPDATE)
    $dh = ($WANT | Where-Object { $_.Name -eq 'DoubleClickHeight' }).Want
    [void][GG.SPI]::SystemParametersInfo(0x001E, [uint32]$dh, [IntPtr]::Zero, $SPIF_UPDATE)
    $sn = ($WANT | Where-Object { $_.Name -eq 'SnapToDefaultButton' }).Want
    [void][GG.SPI]::SystemParametersInfo(0x0060, [uint32]$sn, [IntPtr]::Zero, $SPIF_UPDATE)
} catch {
    Write-Host ""
    Write-Host "  (Could not apply the two live settings; they will work after sign-out.)"
}

Write-Host ""
Write-Host "  WHAT IS WORKING RIGHT NOW -- try them, no restart needed:" -ForegroundColor Green
Write-Host "    * Double-click speed and the wiggle it allows"
Write-Host "    * How far the wheel scrolls per notch"
Write-Host "    * Pointer jumping to the default button"
Write-Host ""
Write-Host "  ONE SETTING IS WAITING: scrolling whatever is under the pointer." -ForegroundColor Yellow
Write-Host "  Windows only reads that one when your session starts, so it will"
Write-Host "  begin working the next time you sign in. Nothing is wrong."
Write-Host ""
Write-Host "  If you want it now, SIGN OUT AND BACK IN. That means:"
Write-Host "    1. Click Start"
Write-Host "    2. Click your name or picture at the bottom"
Write-Host "    3. Click Sign out"
Write-Host "    4. Sign back in as usual"
Write-Host "  It is not a restart and it does not take long. Save your work"
Write-Host "  first, because signing out closes your open programs."
Write-Host ""
Write-Host "  To undo all of this: run Run-MouseSetup.bat again and answer U"
Write-Host "  at the prompt, or run this script with  -Undo"
Write-Host "============================================================"
Write-Host ""
Write-Host "  Press Enter to close."
$null = Read-Host
