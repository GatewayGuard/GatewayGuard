# Check-PhishingProtection-2026-08-18.ps1
# Dated: 2026-08-18 03:40 ET
#
# WHAT THIS ANSWERS: where Enhanced Phishing Protection actually lives, and
# which registry read reports it correctly.
#
# WHY IT EXISTS: Checkup's item 6 reads an EDGE key
# (HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components), gets
# blocked by Tamper Protection, and reports "Unknown -- could not check".
# That is FT-185, open since ascii39 field finding 37 -- Bill: "setting 6 still
# says 3 phishing. No longer exists in Edge, Edge using windows smartscreen."
#
# Cloud's guide rewrite places the setting at
#   Windows Security > App & browser control > Reputation-based protection
# which is WINDOWS, not Edge. This script checks every candidate read so the
# replacement can be chosen from output rather than from reasoning.
#
# READ-ONLY. Reads registry values and Defender preferences. Changes nothing.
# DOES NOT NEED ADMINISTRATOR, but reports whether it is elevated, because
# some of these keys read differently when it is not.
# PS 5.1 COMPATIBLE: -join only, no Join-String, no ternary.

$ErrorActionPreference = 'Continue'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projRoot  = Split-Path -Parent $scriptDir
$outDir    = Join-Path $projRoot 'Test_Results'
if (-not (Test-Path -LiteralPath $outDir)) { $outDir = $scriptDir }
$outFile = Join-Path $outDir ("PhishingProtection-" + $env:COMPUTERNAME + "-" + (Get-Date -Format 'yyyy-MM-dd_HH-mm') + ".txt")

$lines = New-Object System.Collections.ArrayList
function Add-Line { param([string]$t) ; [void]$lines.Add($t) ; Write-Host $t }

$elevated = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")

Add-Line "================================================================"
Add-Line " ENHANCED PHISHING PROTECTION -- WHERE DOES IT ACTUALLY LIVE?"
Add-Line "================================================================"
Add-Line ("  Computer  : " + $env:COMPUTERNAME)
Add-Line ("  Run date  : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Add-Line ("  Elevated  : " + $elevated)
Add-Line ("  Windows   : " + (Get-CimInstance Win32_OperatingSystem -EA SilentlyContinue).Caption)
Add-Line ""

# ---------- read one value, and say plainly WHY it failed if it did ----------
function Read-Val {
    param([string]$Path, [string]$Name)
    $r = New-Object PSObject -Property @{ Path=$Path; Name=$Name; Value=$null; State='' }
    try {
        if (-not (Test-Path -LiteralPath $Path)) { $r.State = 'KEY ABSENT'; return $r }
        $p = Get-ItemProperty -LiteralPath $Path -EA Stop
        if ($null -eq $p.$Name) { $r.State = 'value not set'; return $r }
        $r.Value = $p.$Name ; $r.State = 'READ OK' ; return $r
    }
    catch [System.Security.SecurityException]      { $r.State = 'BLOCKED (SecurityException -- Tamper Protection)'; return $r }
    catch [System.UnauthorizedAccessException]     { $r.State = 'BLOCKED (UnauthorizedAccess)'; return $r }
    catch { $r.State = ('FAILED: ' + $_.Exception.GetType().Name) ; return $r }
}

Add-Line "---- 1. WHAT CHECKUP READS TODAY (the FT-185 defect) ----"
$c = Read-Val 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components' 'ServiceEnabled'
Add-Line ("  HKLM\...\WTDS\Components  ServiceEnabled")
Add-Line ("     state : " + $c.State)
Add-Line ("     value : " + $c.Value)
Add-Line ""

Add-Line "---- 2. THE THREE PARTS THE GUIDE NAMES ----"
Add-Line "  Windows Security > App & browser control > Reputation-based protection"
Add-Line "  The three toggles under Phishing protection, per the guide's setting 6."
$wtds = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components'
foreach ($n in 'ServiceEnabled','NotifyMalicious','NotifyPasswordReuse','NotifyUnsafeApp','CaptureThreatWindow') {
    $v = Read-Val $wtds $n
    Add-Line ("     {0,-22} {1,-52} {2}" -f $n, $v.State, $v.Value)
}
Add-Line ""

Add-Line "---- 3. POLICY MIRROR (HKLM Policies -- what an admin would set) ----"
foreach ($n in 'ServiceEnabled','NotifyMalicious','NotifyPasswordReuse','NotifyUnsafeApp') {
    $v = Read-Val 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components' $n
    Add-Line ("     {0,-22} {1,-52} {2}" -f $n, $v.State, $v.Value)
}
Add-Line ""

Add-Line "---- 4. SMARTSCREEN, the other half of App & browser control ----"
$v = Read-Val 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' 'SmartScreenEnabled'
Add-Line ("     Explorer SmartScreenEnabled        {0,-30} {1}" -f $v.State, $v.Value)
$v = Read-Val 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost' 'EnableWebContentEvaluation'
Add-Line ("     AppHost EnableWebContentEvaluation {0,-30} {1}" -f $v.State, $v.Value)
$v = Read-Val 'HKCU:\SOFTWARE\Microsoft\Edge\SmartScreenEnabled' '(default)'
Add-Line ("     Edge SmartScreenEnabled key        {0,-30} {1}" -f $v.State, $v.Value)
Add-Line ""

Add-Line "---- 5. THE CMDLET ROUTE -- does Defender expose it without registry? ----"
try {
    $mp = Get-MpPreference -EA Stop
    Add-Line "     Get-MpPreference: READ OK"
    foreach ($n in 'PUAProtection','EnableNetworkProtection','SubmitSamplesConsent') {
        Add-Line ("     {0,-26} {1}" -f $n, $mp.$n)
    }
} catch {
    Add-Line ("     Get-MpPreference FAILED: " + $_.Exception.Message)
}
try {
    $ms = Get-MpComputerStatus -EA Stop
    Add-Line ("     IsTamperProtected          " + $ms.IsTamperProtected)
    Add-Line ("     AntivirusEnabled           " + $ms.AntivirusEnabled)
    Add-Line ("     RealTimeProtectionEnabled  " + $ms.RealTimeProtectionEnabled)
} catch {
    Add-Line ("     Get-MpComputerStatus FAILED: " + $_.Exception.Message)
}
Add-Line ""

Add-Line "================================================================"
Add-Line " WHAT TO CONCLUDE"
Add-Line "================================================================"
Add-Line "  A read is usable for Checkup ONLY if it says READ OK above."
Add-Line "  'BLOCKED' means Tamper Protection -- that read can never be the"
Add-Line "  answer, because it fails on exactly the machines that are"
Add-Line "  correctly configured."
Add-Line "  'KEY ABSENT' on a HOME PC usually means the setting is at its"
Add-Line "  default and nothing has written a value -- which FT-123 says must"
Add-Line "  report Unknown, never a definite answer."
Add-Line ""
Add-Line "  Nothing was changed by this script."
Add-Line "================================================================"

$lines -join "`r`n" | Out-File -FilePath $outFile -Encoding UTF8 -Force
Write-Host ""
Write-Host ("  Saved to: " + $outFile)
