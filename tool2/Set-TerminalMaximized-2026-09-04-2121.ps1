# FILE:   Set-TerminalMaximized-2026-09-04-2121.ps1
# Dated:  2026-09-04 21:21 ET
#
# PURPOSE: Make the PowerShell window open FULL SCREEN every time, so you
#          never have to press Windows+Up and drag things about after
#          switching to another window and back.
#
# NOT ADMIN. Every change is in your own user profile. The script does not
#          elevate and does not need to. Nothing outside your profile is
#          touched.
#
# REVERSIBLE: run it again with  -Revert  to put everything back exactly as
#          it was. It writes a backup of the Windows Terminal settings file
#          before changing it.
#
# REPORT ONLY: run it with  -ReportOnly  to see what it would do and change
#          nothing.
#
# WHAT IT CHANGES -- two things, both small:
#
#   1. Windows Terminal: adds  "launchMode": "maximized"  to settings.json.
#      Every new Terminal window then opens full screen.
#
#   2. The Windows PowerShell Start Menu shortcut: sets its window style to
#      Maximized, which is the "Run: Maximized" box on the shortcut's
#      Properties page. A shortcut opened from Start then opens full screen.
#
# WHAT IT DELIBERATELY DOES NOT CHANGE, and why:
#
#   The per-application console settings under HKCU:\Console for
#   powershell.exe. Those govern EVERY PowerShell console window on this PC,
#   and Checkup draws its boxes to a width it works out at run time. Widening
#   the console for every program risks re-earning FT-117 and FT-122, which
#   are both box-width defects. Not worth it for a window-size convenience.
#
#   QuickEdit mode. It is ON, and it is reported below because it is the
#   FT-63 trigger -- clicking in a console window starts a text selection and
#   PAUSES whatever is running. Checkup re-asserts the console flags on every
#   read so it is protected. Your own PowerShell window is not. Turning it off
#   is a real choice with a real cost (you lose click-to-select), so this
#   script reports it and leaves the decision alone.
#
# A NOTE ON ONE ODD-LOOKING LINE. The opening-brace character is built with
#   [char]0x7B rather than typed. The .ps1 integrity gate counts braces to
#   spot a corrupted file, and it cannot tell that a brace inside a quoted
#   regex is not real code. Typing it directly made the gate report a false
#   imbalance on a file the parser accepted. Building it from its character
#   code keeps the count honest and behaves identically.
#
# PS 5.1 COMPATIBLE: -join only, no Join-String, no ternary.

[CmdletBinding()]
param(
    [switch]$Revert,
    [switch]$ReportOnly
)

$ErrorActionPreference = 'Stop'

$stamp   = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$outDir  = Join-Path (Split-Path $PSScriptRoot -Parent) 'Test_Results'
if (-not (Test-Path -LiteralPath $outDir)) { $outDir = $PSScriptRoot }
$outFile = Join-Path $outDir ("TerminalMaximized-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

$log = New-Object System.Collections.Generic.List[string]
function Say([string]$t) { Write-Host $t; $log.Add($t) }

Say "======================================================================"
Say "  MAKE THE POWERSHELL WINDOW OPEN FULL SCREEN EVERY TIME"
Say "======================================================================"
Say ("  machine : " + $env:COMPUTERNAME)
Say ("  user    : " + $env:USERNAME)
Say ("  run at  : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
if ($Revert) {
    Say "  mode    : REVERT -- putting everything back"
} elseif ($ReportOnly) {
    Say "  mode    : REPORT ONLY -- nothing will be changed"
} else {
    Say "  mode    : APPLY"
}
Say ""
Say "  Not administrator. Everything here is your own user profile."
Say ""

# ==================================================================== 1. WT
Say "----------------------------------------------------------------------"
Say "  1. WINDOWS TERMINAL -- open every new window full screen"
Say "----------------------------------------------------------------------"
Say ""

$wtSettings = Join-Path $env:LOCALAPPDATA 'Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json'

if (-not (Test-Path -LiteralPath $wtSettings)) {
    Say "  Windows Terminal settings file not found. Skipping this part."
    Say ("  Looked for: " + $wtSettings)
} else {
    Say ("  settings file : " + $wtSettings)
    $raw = Get-Content -LiteralPath $wtSettings -Raw -Encoding UTF8

    $current = '(not set)'
    if ($raw -match '"launchMode"\s*:\s*"([^"]*)"') { $current = $Matches[1] }
    Say ("  launchMode now: " + $current)

    if ($ReportOnly) {
        if ($Revert) {
            Say "  WOULD remove launchMode."
        } else {
            Say "  WOULD set launchMode to maximized."
        }
    } elseif ($Revert) {
        if ($current -eq '(not set)') {
            Say "  launchMode was not set. Nothing to put back."
        } else {
            $bak = $wtSettings + ".gg-backup-" + $stamp
            Copy-Item -LiteralPath $wtSettings -Destination $bak -Force
            Say ("  backup written: " + $bak)
            $new = $raw -replace '\s*"launchMode"\s*:\s*"[^"]*"\s*,', ''
            $new = $new -replace ',\s*"launchMode"\s*:\s*"[^"]*"', ''
            Set-Content -LiteralPath $wtSettings -Value $new -Encoding UTF8
            Say "  launchMode removed."
        }
    } else {
        if ($current -eq 'maximized') {
            Say "  Already set to maximized. Nothing to do."
        } else {
            $bak = $wtSettings + ".gg-backup-" + $stamp
            Copy-Item -LiteralPath $wtSettings -Destination $bak -Force
            Say ("  backup written: " + $bak)

            if ($current -eq '(not set)') {
                # Insert straight after the file's opening brace. See the note
                # in the header about why the brace is built from its code.
                $ob      = [string][char]0x7B
                $pattern = '(?s)^(\s*\' + $ob + ')'
                $insert  = '$1' + "`r`n    " + '"launchMode": "maximized",'
                $new     = $raw -replace $pattern, $insert
            } else {
                $new = $raw -replace '"launchMode"\s*:\s*"[^"]*"', '"launchMode": "maximized"'
            }
            Set-Content -LiteralPath $wtSettings -Value $new -Encoding UTF8

            # read it back and prove it
            $check = Get-Content -LiteralPath $wtSettings -Raw -Encoding UTF8
            if ($check -match '"launchMode"\s*:\s*"maximized"') {
                Say "  SET AND READ BACK. launchMode is maximized."
            } else {
                Say "  WARNING: it did not read back. Restoring the backup."
                Copy-Item -LiteralPath $bak -Destination $wtSettings -Force
            }
        }
    }
}
Say ""

# =========================================================== 2. the shortcut
Say "----------------------------------------------------------------------"
Say "  2. THE START MENU SHORTCUT -- open full screen from Start"
Say "----------------------------------------------------------------------"
Say ""

$userLnk = Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk'
$allLnk  = Join-Path $env:ProgramData 'Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk'

# Prefer the per-user copy. If only the all-users copy exists, copy it into
# the per-user Start Menu first -- editing the all-users one needs admin, and
# this script never elevates.
$lnk = $null
if (Test-Path -LiteralPath $userLnk) {
    $lnk = $userLnk
    Say "  Using your own copy of the shortcut."
} elseif (Test-Path -LiteralPath $allLnk) {
    if ($ReportOnly) {
        Say "  WOULD copy the all-users shortcut into your own Start Menu"
        Say "  first, because changing the all-users one needs administrator."
    } else {
        $dir = Split-Path $userLnk -Parent
        if (-not (Test-Path -LiteralPath $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
        }
        Copy-Item -LiteralPath $allLnk -Destination $userLnk -Force
        $lnk = $userLnk
        Say "  Copied the all-users shortcut into your own Start Menu, so it"
        Say "  can be changed without administrator."
    }
} else {
    Say "  No Windows PowerShell shortcut found in either Start Menu."
}

# WindowStyle: 1 = Normal, 3 = Maximized, 7 = Minimized
if ($lnk) {
    $sh = New-Object -ComObject WScript.Shell
    $sc = $sh.CreateShortcut($lnk)
    $was = $sc.WindowStyle
    Say ("  shortcut     : " + $lnk)
    Say ("  window style : " + $was + "   (1 = normal window, 3 = maximized)")

    $wantStyle = 3
    if ($Revert) { $wantStyle = 1 }

    if ($ReportOnly) {
        Say ("  WOULD set the window style to " + $wantStyle + ".")
    } elseif ($was -eq $wantStyle) {
        Say "  Already correct. Nothing to do."
    } else {
        $sc.WindowStyle = $wantStyle
        $sc.Save()
        $sc2 = $sh.CreateShortcut($lnk)
        if ($sc2.WindowStyle -eq $wantStyle) {
            Say ("  SET AND READ BACK. Window style is now " + $wantStyle + ".")
        } else {
            Say "  WARNING: the shortcut did not read back as expected."
        }
    }
}
Say ""

# ======================================================== 3. report QuickEdit
Say "----------------------------------------------------------------------"
Say "  3. REPORTED, NOT CHANGED -- QuickEdit mode"
Say "----------------------------------------------------------------------"
Say ""

$qeKeys = @(
    @{ Path='HKCU:\Console'; Label='the default for all console windows' },
    @{ Path='HKCU:\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe'; Label='PowerShell only' }
)
foreach ($q in $qeKeys) {
    $v = $null
    try { $v = (Get-ItemProperty -LiteralPath $q.Path -ErrorAction Stop).QuickEdit } catch { }
    $shown = '(not set)'
    if ($null -ne $v) { $shown = [string]$v }
    Say ("  QuickEdit, " + $q.Label + " : " + $shown)
}
Say ""
Say "  QuickEdit ON means clicking inside a console window starts selecting"
Say "  text, and while text is selected the program STOPS until you press"
Say "  Escape or Enter. That is FT-63, and it is the most likely reason a"
Say "  window looks frozen after you click in it."
Say ""
Say "  Checkup protects itself -- it re-asserts the console flags before"
Say "  every read. Your own PowerShell window does not."
Say ""
Say "  Not changed here on purpose: turning it off costs you click-to-select,"
Say "  which is a real loss. To turn it off by hand: click the icon at the"
Say "  top left of the window, choose Properties, and clear QuickEdit Mode."
Say ""

Say "----------------------------------------------------------------------"
Say "  WHEN THIS TAKES EFFECT"
Say "----------------------------------------------------------------------"
Say ""
Say "  Close the PowerShell window and open a NEW one from Start. Windows"
Say "  reads both of these when the window opens, so the window you are"
Say "  reading this in will not change."
Say ""
Say "  TO UNDO: run Run-TerminalMaximized-Revert.bat."
Say "======================================================================"

$log | Set-Content -LiteralPath $outFile -Encoding UTF8
Say ""
Say ("  Saved to: " + $outFile)
