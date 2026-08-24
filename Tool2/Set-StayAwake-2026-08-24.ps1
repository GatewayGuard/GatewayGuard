# FILE:    Set-StayAwake-2026-08-24.ps1
# Dated:   2026-08-24 02:40 ET
# PURPOSE: Keep this notebook running with the display off, so a long
#          Claude Cloud research session is not interrupted.
#
# NOT READ-ONLY. This script CHANGES power settings.
# It writes an undo file first, and -Undo puts everything back.
#
# Needs administrator. It does NOT self-elevate -- the Malwarebytes
# exploit-payload flag stands. It detects and reports instead.
#
# measured on CGDELL 2026-08-24 before any change:
#   chassis type 10 (notebook)
#   AC  : sleep never, display never off, hibernate never, disk 30s
#   DC  : sleep after 180s (3 MINUTES), display never off, hibernate never
#   sleep states: S0 Low Power Idle Network Connected (Modern Standby)
#
# The setting that actually matters is DC sleep at 180 seconds. On battery
# this machine sleeps three minutes after you walk away, and no display
# setting prevents that. PLUG IT IN.

param(
    [switch]$Undo,
    [int]$DisplayOffMinutes = 10
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Machine   = $env:COMPUTERNAME
$UndoFile  = Join-Path $ScriptDir "PowerSettings-UNDO-$Machine.txt"
$Stamp     = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ReportDir = Join-Path (Split-Path -Parent $ScriptDir) "Test_Results"
$Report    = Join-Path $ReportDir "StayAwake-$Machine-$Stamp.txt"

$lines = New-Object System.Collections.Generic.List[string]
function Say([string]$t) { $lines.Add($t); Write-Host $t }

Say ("=" * 70)
Say "  STAY AWAKE -- display off, machine running"
Say ("=" * 70)
Say "  machine  : $Machine"
Say "  run at   : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

# --- elevation: report, never elevate -------------------------------
$identity  = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($identity)
$isAdmin   = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
Say "  elevated : $isAdmin"
Say ""

if (-not $isAdmin) {
    Say "  STOPPED. This needs administrator rights to change a power scheme."
    Say ""
    Say "  Close this window. Right-click Run-StayAwake.bat and choose"
    Say "  'Run as administrator', then run it again."
    Say ""
    $lines -join "`r`n" | Out-File -FilePath $Report -Encoding UTF8
    return
}

# --- helper: read one setting index ---------------------------------
function Get-Idx([string]$sub, [string]$setting) {
    $out = powercfg /query SCHEME_CURRENT $sub $setting 2>$null
    if (-not $out) { return $null }
    $ac = ($out | Select-String "Current AC Power Setting Index")
    $dc = ($out | Select-String "Current DC Power Setting Index")
    $toInt = { param($m) if ($m) { [Convert]::ToInt64((($m.ToString() -replace '.*:\s*','').Trim()), 16) } else { $null } }
    return [PSCustomObject]@{
        AC = & $toInt $ac
        DC = & $toInt $dc
    }
}

$targets = @(
    @{ Sub = "SUB_SLEEP"; Set = "STANDBYIDLE";   Label = "sleep after" },
    @{ Sub = "SUB_VIDEO"; Set = "VIDEOIDLE";     Label = "display off after" },
    @{ Sub = "SUB_SLEEP"; Set = "HIBERNATEIDLE"; Label = "hibernate after" }
)

# --- UNDO path -------------------------------------------------------
if ($Undo) {
    if (-not (Test-Path $UndoFile)) {
        Say "  No undo file at $UndoFile -- nothing to put back."
        $lines -join "`r`n" | Out-File -FilePath $Report -Encoding UTF8
        return
    }
    Say "  Restoring from $UndoFile"
    Say ""
    foreach ($line in (Get-Content $UndoFile)) {
        if ($line -match '^\s*#' -or -not $line.Trim()) { continue }
        $parts = $line.Split("|")
        if ($parts.Count -ne 4) { continue }
        $sub, $set, $ac, $dc = $parts
        powercfg /setacvalueindex SCHEME_CURRENT $sub $set $ac | Out-Null
        powercfg /setdcvalueindex SCHEME_CURRENT $sub $set $dc | Out-Null
        Say ("  restored {0} {1}  AC={2}  DC={3}" -f $sub, $set, $ac, $dc)
    }
    powercfg /setactive SCHEME_CURRENT | Out-Null
    Say ""
    Say "  Power settings are back to what they were."
    $lines -join "`r`n" | Out-File -FilePath $Report -Encoding UTF8
    Say ""
    Say "  Report: $Report"
    return
}

# --- write the undo file BEFORE changing anything --------------------
#
# THE GUARD BELOW IS THE WHOLE POINT, AND IT WAS MISSING.
# 2026-08-24: this script was run a second time, and because it wrote the
# undo file unconditionally it recorded the ALREADY-CHANGED values as the
# originals. Undoing from that file would have restored nothing and said it
# succeeded. The real values survived only because the first run's file had
# been committed to git.
#
# An undo file that a second run can overwrite is not a safety net. It is a
# safety net with a hole in it that opens the moment somebody double-clicks
# the launcher twice -- which is the single most likely thing to happen.
#
# So: the first run owns the undo file. Later runs never touch it.

$undoLines = New-Object System.Collections.Generic.List[string]
$undoLines.Add("# GatewayGuard power-settings undo -- $Machine")
$undoLines.Add("# Written $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') by Set-StayAwake-2026-08-24.ps1")
$undoLines.Add("# Format: SUBGROUP|SETTING|AC_seconds|DC_seconds")
$undoLines.Add("# Put it all back:  Run-StayAwake.bat undo")

Say "  BEFORE -- current values, seconds (0 = never)"
Say ""
foreach ($t in $targets) {
    $v = Get-Idx $t.Sub $t.Set
    if ($null -eq $v) { Say ("  {0,-22} not exposed on this machine" -f $t.Label); continue }
    Say ("  {0,-22} AC={1,-12} DC={2}" -f $t.Label, $v.AC, $v.DC)
    $undoLines.Add("$($t.Sub)|$($t.Set)|$($v.AC)|$($v.DC)")
}
Say ""

if (Test-Path $UndoFile) {
    $existingStamp = (Get-Content $UndoFile | Where-Object { $_ -like "# Written*" } | Select-Object -First 1)
    Say "  UNDO FILE ALREADY EXISTS -- LEAVING IT ALONE."
    Say "    $UndoFile"
    if ($existingStamp) { Say "    $($existingStamp.TrimStart('#').Trim())" }
    Say ""
    Say "  It holds the settings from BEFORE the first run, which is what an"
    Say "  undo needs. Overwriting it now would record the current -- already"
    Say "  changed -- values and quietly destroy the only way back."
    Say ""
    Say "  To capture a fresh baseline deliberately: run the undo first"
    Say "  (Run-StayAwake.bat undo), then run this again."
} else {
    $undoLines -join "`r`n" | Out-File -FilePath $UndoFile -Encoding UTF8
    Say "  Undo file written: $UndoFile"
}
Say ""

# --- apply -----------------------------------------------------------
$displaySecs = $DisplayOffMinutes * 60

Say "  APPLYING"
Say ""
# Display off after N minutes, both AC and battery. This is the one thing
# Bill actually asked for -- the screen dark while the machine works.
powercfg /setacvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOIDLE $displaySecs | Out-Null
powercfg /setdcvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOIDLE $displaySecs | Out-Null
Say ("  display off after      {0} minutes (AC and battery)" -f $DisplayOffMinutes)

# Never sleep. AC was already never; DC was 180 seconds, which is the
# setting that would actually end an overnight run.
powercfg /setacvalueindex SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0 | Out-Null
powercfg /setdcvalueindex SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0 | Out-Null
Say "  sleep                  never (AC and battery)"

# Never hibernate.
powercfg /setacvalueindex SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 0 | Out-Null
powercfg /setdcvalueindex SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 0 | Out-Null
Say "  hibernate              never (AC and battery)"

powercfg /setactive SCHEME_CURRENT | Out-Null
Say ""

# --- verify by reading back ------------------------------------------
Say "  AFTER -- read back from the machine"
Say ""
$ok = $true
foreach ($t in $targets) {
    $v = Get-Idx $t.Sub $t.Set
    if ($null -eq $v) { continue }
    Say ("  {0,-22} AC={1,-12} DC={2}" -f $t.Label, $v.AC, $v.DC)
}
$vid = Get-Idx SUB_VIDEO VIDEOIDLE
$slp = Get-Idx SUB_SLEEP STANDBYIDLE
if ($vid.AC -ne $displaySecs -or $vid.DC -ne $displaySecs) { $ok = $false; Say "  MISMATCH: display timeout did not take" }
if ($slp.AC -ne 0 -or $slp.DC -ne 0) { $ok = $false; Say "  MISMATCH: sleep did not take" }

Say ""
Say ("=" * 70)
if ($ok) {
    Say "  DONE. The display will go dark; the machine keeps running."
} else {
    Say "  SOMETHING DID NOT TAKE -- see the mismatch lines above."
}
Say ("=" * 70)
Say ""
Say "  STILL DO THESE TWO THINGS BY HAND:"
Say ""
Say "  1. PLUG IN THE POWER ADAPTER. This is a notebook. Nothing above"
Say "     protects a battery that runs flat."
Say ""
Say "  2. LEAVE THE LID OPEN. Closing the lid puts this machine into"
Say "     Modern Standby whatever the timeouts say, and the lid setting"
Say "     is hidden from powercfg on this model, so the script cannot"
Say "     set it for you. Screen dark with the lid open is what you want."
Say ""
Say "  To put everything back:  Run-StayAwake.bat undo"
Say ""

if (-not (Test-Path $ReportDir)) { New-Item -Path $ReportDir -ItemType Directory -Force | Out-Null }
$lines -join "`r`n" | Out-File -FilePath $Report -Encoding UTF8
Write-Host "  Report: $Report"
Write-Host ""
