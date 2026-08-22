# Dated: 2026-08-21 11:05 ET
# ================================================================
# FILE:    Check-LogSync-2026-08-21.ps1
# PURPOSE: Run on SANDY. Answers one question -- why has today's
#          Checkup log not reached the other PC?
#
# READ-ONLY. Changes nothing, uploads nothing, does not self-elevate.
# Writes its findings to a file beside itself.
# ================================================================

$ErrorActionPreference = "Continue"
$stamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
$out   = Join-Path $PSScriptRoot ("..\Test_Results\LogSync-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

$L = New-Object System.Collections.Generic.List[string]
function A { param([string]$t = "") ; $L.Add($t) ; Write-Host $t }

A "================================================================"
A " LOG SYNC CHECK -- $env:COMPUTERNAME -- $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
A " READ-ONLY. Nothing was changed or uploaded."
A "================================================================"
A ""

# -- 1. is this machine on the internet at all? -------------------
A "--- 1. INTERNET ---"
# VERIFIED 2026-08-21 measured on CGDELL: Test-NetConnection -InformationLevel
# Quiet returns a plain $true/$false and does not prompt.
$net = $false
try { $net = Test-NetConnection -ComputerName "www.microsoft.com" -Port 443 -InformationLevel Quiet -WarningAction SilentlyContinue } catch {}
A ("  Reaches the internet: " + $(if ($net) { "YES" } else { "NO  <-- this is almost certainly the answer" }))
try {
    Get-NetAdapter -ErrorAction Stop | Where-Object { $_.Status -eq "Up" } | ForEach-Object {
        A ("  Adapter UP: " + $_.Name + "  [" + $_.InterfaceDescription + "]")
    }
    $down = Get-NetAdapter -ErrorAction Stop | Where-Object { $_.Status -ne "Up" }
    foreach ($d in $down) { A ("  Adapter down: " + $d.Name + "  [" + $d.Status + "]") }
} catch { A ("  Could not list adapters: " + $_.Exception.Message) }
A ""

# -- 2. is OneDrive even running? ---------------------------------
A "--- 2. ONEDRIVE CLIENT ---"
$od = Get-Process OneDrive -ErrorAction SilentlyContinue
if ($od) { A ("  Running. PID " + ($od.Id -join ", ")) }
else     { A "  NOT RUNNING. Nothing will upload until it is started." }
A ""

# -- 3. is today's log actually on this disk? ---------------------
A "--- 3. TODAY'S LOG ON THIS MACHINE ---"
$today = Get-Date -Format "yyyy-MM-dd"
$roots = @(
    (Join-Path $env:USERPROFILE "OneDrive\GatewayGuard\Logs"),
    (Join-Path $env:USERPROFILE "GatewayGuard\Logs"),
    "C:\GatewayGuard\Logs"
)
$found = 0
foreach ($r in $roots) {
    if (Test-Path $r) {
        $all = @(Get-ChildItem $r -Filter "*.txt" -ErrorAction SilentlyContinue)
        $hits = @($all | Where-Object { $_.Name -like ("*" + $today + "*") })
        A ("  " + $r)
        A ("     " + $all.Count + " log(s) total, " + $hits.Count + " from today")
        foreach ($h in $hits) {
            $found++
            $ph = if ($h.Attributes -band [IO.FileAttributes]::Offline) { "CLOUD-ONLY (not on this disk)" } else { "on disk" }
            A ("     -> " + $h.Name + "  " + $h.Length + " bytes  " + $ph)
        }
    } else {
        A ("  " + $r + "   (does not exist)")
    }
}
if ($found -eq 0) { A "  NO LOG FROM TODAY ANYWHERE. The run may not have written one yet." }
A ""

A "--- WHAT TO DO ---"
if (-not $net) {
    A "  No internet. Plug in the TP-Link Archer T2U Nano USB adapter --"
    A "  the internal Wi-Fi on this PC is a known hardware failure. Nothing"
    A "  syncs until it is connected."
} elseif (-not $od) {
    A "  Internet is fine but OneDrive is not running. Start OneDrive from"
    A "  the Start menu and give it a few minutes."
} elseif ($found -eq 0) {
    A "  Online and OneDrive is running, but no log was written today."
    A "  Check that Checkup actually launched."
} else {
    A "  Online, OneDrive running, and the log exists. Give it a few minutes,"
    A "  then look at the OneDrive cloud icon near the clock -- if it shows a"
    A "  pause symbol, click it and choose Resume syncing."
}
A ""
A ("Saved to: " + $out)

try { ($L -join "`r`n") | Out-File -FilePath $out -Encoding UTF8 } catch { Write-Host "  Could not write file: $($_.Exception.Message)" }
