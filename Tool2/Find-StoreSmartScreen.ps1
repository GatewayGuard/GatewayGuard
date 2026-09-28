# Dated: 2026-09-28 13:19 ET
# Editor: Claude Code (CGDELL)
# Find-StoreSmartScreen -- READ-ONLY. Changes nothing.
# FT-300: where does Windows keep "SmartScreen for Microsoft Store apps"?
# The usual answer (HKCU\...\AppHost\EnableWebContentEvaluation) was ABSENT in
# all four of Bill's SANDY runs, 2026-09-28 13:11-13:16, so it lives elsewhere.
# Each run records every value under a few registry areas, then compares with
# the previous run on this PC and lists what changed.
# Use: run it; turn the Store apps toggle OFF; run it; turn it back ON; run it.
# Output: ..\Test_Results\StoreSS-<PC>-<date_time>.txt (+ a hidden-in-plain-sight
#         snapshot file beside it, StoreSS-snap-..., used by the next run)

$ErrorActionPreference = "SilentlyContinue"
$stamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$dir = Join-Path (Split-Path $PSScriptRoot -Parent) "Test_Results"
if (-not (Test-Path $dir)) { $dir = $PSScriptRoot }
$roots = @(
    "HKCU:\Software\Microsoft\Windows\CurrentVersion",
    "HKCU:\Software\Microsoft\Windows Security Health",
    "HKCU:\Software\Microsoft\Edge",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer",
    "HKLM:\SOFTWARE\Microsoft\Windows Defender\SmartScreen",
    "HKLM:\SOFTWARE\Microsoft\Windows Security Health",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System",
    "HKLM:\SYSTEM\CurrentControlSet\Control\CI\Policy"   # Smart App Control (FT-260; Bill 2026-09-28)
)
# Areas that change on their own every few seconds -- noise, not settings.
$noise = 'CloudStore|\\Explorer\\SessionInfo|\\Explorer\\UserAssist|RecentDocs|\\BagMRU|\\Bags\\|FeatureUsage|TypedPaths|\\Search\\|\\Notifications\\|\\DeliveryOptimization|PushNotifications|\\Themes\\History|\\Store\\Cache|TaskbarItemsCache|\\Explorer\\StartPage'

$sw = [Diagnostics.Stopwatch]::StartNew()
$snap = New-Object System.Collections.Generic.List[string]
foreach ($r in $roots) {
    if (-not (Test-Path $r)) { continue }
    $keys = @(Get-Item $r) + @(Get-ChildItem $r -Recurse -EA SilentlyContinue)
    foreach ($k in $keys) {
        $kp = $k.Name
        if ($kp -match $noise) { continue }
        foreach ($vn in $k.GetValueNames()) {
            $v = $k.GetValue($vn)
            if ($v -is [byte[]]) { $v = "bytes:" + $v.Length + ":" + (($v | Select-Object -First 16 | ForEach-Object { $_.ToString("x2") }) -join "") }
            elseif ($v -is [string[]]) { $v = ($v -join "|") }
            $v = ([string]$v) -replace "`r?`n", "\n"   # one line per value, or the comparison splits it
            $name = if ($vn) { $vn } else { "(default)" }
            $snap.Add($kp + "  ::  " + $name + " = " + $v)
        }
    }
}
$sw.Stop()
$snapFile = Join-Path $dir ("StoreSS-snap-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")
$snap | Set-Content -Path $snapFile -Encoding UTF8

$out = New-Object System.Collections.Generic.List[string]
$out.Add("Find-StoreSmartScreen -- " + $env:COMPUTERNAME + " -- " + (Get-Date -Format "yyyy-MM-dd HH:mm:ss") + " -- " + $snap.Count + " values read in " + [int]$sw.Elapsed.TotalSeconds + " s")
$prev = Get-ChildItem $dir -Filter ("StoreSS-snap-" + $env:COMPUTERNAME + "-*.txt") | Where-Object { $_.FullName -ne $snapFile } | Sort-Object Name -Descending | Select-Object -First 1
if ($prev) {
    $old = Get-Content $prev.FullName
    $out.Add("Compared with the previous run: " + $prev.Name)
    $d = @(Compare-Object -ReferenceObject $old -DifferenceObject @($snap) | Select-Object -First 200)
    if ($d.Count -eq 0) { $out.Add("  NO CHANGES found in these areas.") }
    foreach ($x in $d) { $out.Add("  " + $(if ($x.SideIndicator -eq "=>") { "NOW    " } else { "BEFORE " }) + $x.InputObject) }
} else {
    $out.Add("First run on this PC -- nothing to compare yet. Now turn 'SmartScreen for Microsoft Store apps' OFF and run this again.")
}
$outFile = Join-Path $dir ("StoreSS-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")
$out | Set-Content -Path $outFile -Encoding UTF8
$out | ForEach-Object { Write-Host $_ }
Write-Host ""
Write-Host ("Saved to: " + $outFile)
