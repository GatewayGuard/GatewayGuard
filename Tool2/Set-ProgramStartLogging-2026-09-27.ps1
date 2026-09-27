# Set-ProgramStartLogging-2026-09-27.ps1
# Dated: 2026-09-27 18:02 ET
# Editor: Claude Code (CGDELL)
# Purpose: Bill, 2026-09-27: "yes to program start logging" -- on SANDY, so if
#          encryption (or anything) starts by itself again during the ascii45
#          field run, Windows records WHICH program did it (FT-289: on 09-20 the
#          encryption events named only "process 8832", because program starts
#          are not recorded on a home PC).
#   -Mode On   : record every program start (Security log event 4688), with the
#                program's command line, and make the Security log big enough
#                (100 MB) that the field run's records are not overwritten.
#   -Mode Off  : put all three back to Windows' defaults (no auditing, no command
#                line, 20 MB -- the values measured on CGDELL 2026-09-27 18:01).
# CHANGES THREE WINDOWS SETTINGS (On) or restores them (Off). Nothing else.
# Run as administrator. Output: Test_Results\ProgramStartLogging-<mode>-<machine>-<stamp>.txt
#
# VERIFIED 2026-09-27 measured on CGDELL: "auditpol /set /?" documents
#   /subcategory:<name>|<{guid}> /success:<enable>|<disable>; "auditpol /list
#   /subcategory:"Detailed Tracking" /v" gives Process Creation =
#   {0CCE922B-69AE-11D9-BED3-505054503030} (the GUID works in any language).
# VERIFIED 2026-09-27 measured on CGDELL: "wevtutil sl /?" documents /ms:<n>.
# Sourced: Microsoft Learn, "Command line process auditing" --
#   HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\Audit
#   ProcessCreationIncludeCmdLine_Enabled = 1 adds the command line to 4688.

param([ValidateSet("On","Off")][string]$Mode = "On")
$out = Join-Path (Split-Path -Parent $PSScriptRoot) ("Test_Results\ProgramStartLogging-" + $Mode + "-" + $env:COMPUTERNAME + "-" + (Get-Date -Format "yyyy-MM-dd_HH-mm") + ".txt")
$L = New-Object System.Collections.Generic.List[string]
function Add($s) { $L.Add([string]$s); Write-Host $s }
$guid = "{0CCE922B-69AE-11D9-BED3-505054503030}"
$key  = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit"

$admin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
Add "PROGRAM-START LOGGING -- turning it $($Mode.ToUpper()) -- $env:COMPUTERNAME -- $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
if (-not $admin) { Add "  NOT running as administrator -- nothing was changed. Right-click the .bat, Run as administrator."; $L | Out-File $out -Encoding UTF8; return }

function Show-State($when) {
    $a = (auditpol /get /subcategory:"$guid" 2>&1 | Out-String)
    $rec = if ($a -match "Success") { "ON" } elseif ($a -match "No Auditing") { "off" } else { "unknown" }
    $cl = (Get-ItemProperty $key -EA SilentlyContinue).ProcessCreationIncludeCmdLine_Enabled
    $mb = [math]::Round((Get-WinEvent -ListLog Security).MaximumSizeInBytes / 1MB)
    Add ("  {0,-7} program starts recorded: {1,-4}  command lines: {2,-4}  Security log size: {3} MB" -f $when, $rec, $(if ($cl -eq 1) { "ON" } else { "off" }), $mb)
}

Show-State "before:"
if ($Mode -eq "On") {
    $r1 = auditpol /set /subcategory:"$guid" /success:enable 2>&1 | Out-String
    if (-not (Test-Path $key)) { New-Item -Path $key -Force | Out-Null }
    Set-ItemProperty -Path $key -Name ProcessCreationIncludeCmdLine_Enabled -Value 1 -Type DWord
    $r3 = wevtutil sl Security /ms:104857600 2>&1 | Out-String
} else {
    $r1 = auditpol /set /subcategory:"$guid" /success:disable 2>&1 | Out-String
    Remove-ItemProperty -Path $key -Name ProcessCreationIncludeCmdLine_Enabled -EA SilentlyContinue
    $r3 = wevtutil sl Security /ms:20971520 2>&1 | Out-String
}
Add ("  auditpol said: " + ($r1 -replace "\s+", " ").Trim())
if ($r3.Trim()) { Add ("  wevtutil said: " + ($r3 -replace "\s+", " ").Trim()) }
Show-State "after:"
Add ""
if ($Mode -eq "On") {
    Add "  Done. Every program that starts on this PC is now recorded, with its command line."
    Add "  To undo it later: Run-ProgramStartLogging-OFF.bat, as administrator."
} else {
    Add "  Done. Program-start logging is back to Windows' defaults."
}
$L | Out-File -FilePath $out -Encoding UTF8
Write-Host ""
Write-Host "Saved to: $out"
