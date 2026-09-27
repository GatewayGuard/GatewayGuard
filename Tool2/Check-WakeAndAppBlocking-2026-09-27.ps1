# Check-WakeAndAppBlocking-2026-09-27.ps1
# Dated: 2026-09-27 09:41 ET
# Editor: Claude Code (CGDELL)
# Purpose: show Bill, on any PC, the settings behind two Checkup items:
#   Item 17 -- "Require a password on wake": Windows keeps TWO values, one used
#              when the PC is plugged in (AC) and one used on battery (DC).
#   Unwanted-app blocking (Block E3) -- Defender's PUAProtection setting.
# READ-ONLY. Changes nothing. Run as administrator (Defender's setting needs it).
# Output: on screen, and Test_Results\WakeAndAppBlocking-<machine>-<stamp>.txt

$out = Join-Path (Split-Path -Parent $PSScriptRoot) ("Test_Results\WakeAndAppBlocking-" + $env:COMPUTERNAME + "-" + (Get-Date -Format "yyyy-MM-dd_HH-mm") + ".txt")
$L = New-Object System.Collections.Generic.List[string]
function Add($s) { $L.Add([string]$s); Write-Host $s }

Add "WAKE PASSWORD AND UNWANTED-APP BLOCKING -- $env:COMPUTERNAME -- $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
Add ""
Add "== ITEM 17: Require a password when the PC wakes up"
# VERIFIED 2026-09-25 measured on CGDELL: /qh shows this hidden setting; /query does not (FT-268).
$q = (powercfg /qh SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>&1 | Out-String)
$ac = $null; $dc = $null
if ($q -match "Current AC Power Setting Index:\s*0x(\w+)") { $ac = [Convert]::ToUInt32($Matches[1], 16) }
if ($q -match "Current DC Power Setting Index:\s*0x(\w+)") { $dc = [Convert]::ToUInt32($Matches[1], 16) }
function Say($v) { if ($null -eq $v) { "could not read" } elseif ($v -eq 1) { "YES -- a password is required" } else { "NO -- the PC opens without a password" } }
Add ("  When plugged in:  " + (Say $ac))
Add ("  On battery:       " + (Say $dc))
if ($ac -eq 1 -and ($null -eq $dc -or $dc -eq 1)) { Add "  Checkup would say: GOOD" } else { Add "  Checkup would say: needs attention" }
Add "  Where you see it: Settings -> Accounts -> Sign-in options -> 'If you've"
Add "  been away, when should Windows require you to sign in again?'"
Add ""
Add "== UNWANTED-APP BLOCKING (Microsoft Defender)"
$p = $null
try { $p = [int](Get-MpPreference -EA Stop).PUAProtection } catch { Add "  Could not read (run as administrator): $($_.Exception.Message)" }
if ($null -ne $p) {
    $meaning = switch ($p) { 0 { "OFF -- not blocked, not recorded" } 1 { "ON -- blocked" } 2 { "AUDIT -- recorded only, NOT blocked" } default { "unknown value" } }
    Add "  Defender PUAProtection = $p  ($meaning)"
}
Add "  Where you see it: Windows Security -> App & browser control ->"
Add "  Reputation-based protection settings -> Potentially unwanted app blocking"
$L | Out-File -FilePath $out -Encoding UTF8
Write-Host ""
Write-Host "Saved to: $out"
