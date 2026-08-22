# Dated: 2026-07-30 20:30 EDT
# ================================================================
# FILE:    Get-PSErrors-2026-07-30.ps1
# PURPOSE: FT-159 -- retrieve the full text of the PowerShell error that
#          Checkup generated and swallowed during the SANDY run.
#
# WHY A FILE AND NOT A PASTED COMMAND: three commands pasted into chat this
# session were all mangled by line-wrapping before they reached the prompt
# (the last was 166 characters and broke at columns 29 and 109, producing
# three invalid fragments). Three scripts shipped as .ps1 files all ran
# first time. The method with the perfect record wins.
#
# THIS SCRIPT CHANGES NOTHING. It reads the Windows event log and writes one
# text file next to itself. There is no Set-, New-, Remove-, Enable- or
# Disable- call in it.
#
# IT IS BOUNDED. -MaxEvents caps every query, and -FilterHashtable pushes the
# filtering into the event-log engine rather than fetching the whole log and
# discarding most of it. An unbounded version of this query locked up SANDY
# on 2026-07-30 and had to be killed by closing the window: script-block
# logging makes that log enormous, and Get-WinEvent blocks inside a .NET
# enumeration where Ctrl+C cannot interrupt it.
#
# HOW TO RUN -- right-click PowerShell, Run as administrator, then:
#   powershell -NoProfile -ExecutionPolicy Bypass -File .\Get-PSErrors-2026-07-30.ps1
# ================================================================

$log  = 'Microsoft-Windows-PowerShell/Operational'
$dest = Join-Path $PSScriptRoot ("PSErrors-" + $env:COMPUTERNAME + "-" + (Get-Date -Format 'yyyy-MM-dd_HH-mm') + ".txt")
$out  = New-Object System.Collections.ArrayList

function Add-Line {
    param([string]$Text, [System.ConsoleColor]$Color = "Gray")
    Write-Host $Text -ForegroundColor $Color
    $null = $out.Add($Text)
}

Clear-Host
Add-Line ""
Add-Line "================================================================" "Cyan"
Add-Line " FT-159 -- SWALLOWED POWERSHELL ERRORS (read-only)" "Cyan"
Add-Line "================================================================" "Cyan"
Add-Line ("  Computer : " + $env:COMPUTERNAME)
Add-Line ("  Run date : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Add-Line ""

# ---- the 4100 errors, in full -------------------------------------------
Add-Line "---- Event ID 4100 (pipeline errors), newest 10, FULL TEXT ----" "Cyan"
Add-Line ""
try {
    $errs = @(Get-WinEvent -FilterHashtable @{ LogName = $log; Id = 4100 } -MaxEvents 10 -EA Stop)
    if ($errs.Count -eq 0) {
        Add-Line "  No 4100 events found." "Yellow"
    } else {
        Add-Line ("  Found " + $errs.Count + " event(s).") "Green"
        foreach ($e in $errs) {
            Add-Line ""
            Add-Line ("  ---- " + $e.TimeCreated.ToString('yyyy-MM-dd HH:mm:ss') + "  Id " + $e.Id + " ----") "White"
            foreach ($line in ($e.Message -split "`r?`n")) { Add-Line ("    " + $line) }
        }
    }
} catch {
    Add-Line ("  Could not read 4100 events: " + $_.Exception.Message) "Red"
}

# ---- engine lifecycle, to confirm the crash was an external kill ---------
Add-Line ""
Add-Line "---- Engine start/stop events, newest 20 ----" "Cyan"
Add-Line "  (a start with no matching stop = the process was KILLED, not exited)" "DarkGray"
Add-Line ""
try {
    $life = @(Get-WinEvent -FilterHashtable @{ LogName = $log; Id = 40961, 40962, 53504 } -MaxEvents 20 -EA Stop |
              Sort-Object TimeCreated)
    if ($life.Count -eq 0) { Add-Line "  None found." "Yellow" }
    foreach ($e in $life) {
        Add-Line ("  " + $e.TimeCreated.ToString('yyyy-MM-dd HH:mm:ss') + "  " + $e.Id + "  " + ($e.Message -split "`r?`n")[0])
    }
} catch {
    Add-Line ("  Could not read lifecycle events: " + $_.Exception.Message) "Red"
}

# ---- which console host is this? ----------------------------------------
Add-Line ""
Add-Line "---- Console host ----" "Cyan"
if ($env:WT_SESSION) {
    Add-Line ("  Windows Terminal  (WT_SESSION = " + $env:WT_SESSION + ")") "Green"
} else {
    Add-Line "  classic conhost (WT_SESSION not set)" "Green"
}
Add-Line ("  PowerShell host name : " + $Host.Name)
Add-Line ("  PowerShell version   : " + $PSVersionTable.PSVersion)

# ---- write it out --------------------------------------------------------
try {
    $out | Out-File -FilePath $dest -Encoding UTF8
    Write-Host ""
    Write-Host ("  Saved to: " + $dest) -ForegroundColor Green
    Write-Host "  Send me that file." -ForegroundColor Green
} catch {
    Write-Host ""
    Write-Host ("  Could not save: " + $_.Exception.Message) -ForegroundColor Red
}
Write-Host ""
Write-Host "  Nothing on this PC was changed." -ForegroundColor Green
Write-Host ""
