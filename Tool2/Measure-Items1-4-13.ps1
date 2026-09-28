# Dated: 2026-09-28 08:51 ET
# Editor: Claude Code (CGDELL)
# Measure-Items1-4-13 -- READ-ONLY. Changes nothing.
# Co-Pilot's ascii45 review (2026-09-28) named three reads that decide a verdict
# from less than the setting's name promises:
#   Item 1  -- GOOD whenever the Windows Update SERVICE is not Disabled
#              (Get-AllStatuses case 1). Paused updates, an auto-update policy,
#              or updates the user declined are not looked at.
#   Item 4  -- reads and writes ONE value (Explorer SmartScreenEnabled =
#              "Check apps and files"); the item says "websites and downloads".
#   Item 13 -- Edge Local State startup_boost/background_mode "enabled" is
#              inferred, not flip-proven.
# Run it, change ONE thing by hand, run it again, compare the two files.
# Output: ..\Test_Results\Items1-4-13-<PC>-<date_time>.txt

$ErrorActionPreference = "Continue"
$stamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ggDir = Join-Path (Split-Path $PSScriptRoot -Parent) "Test_Results"
if (-not (Test-Path $ggDir)) { $ggDir = $PSScriptRoot }   # 2026-09-28: SANDY reported "cannot find the path"
$out = Join-Path $ggDir ("Items1-4-13-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")
$L = New-Object System.Collections.Generic.List[string]
function Add([string]$t) { $L.Add($t) }
function RegVal($path, $name) {
    try { $v = (Get-ItemProperty -Path $path -Name $name -EA Stop).$name; return ("'" + $v + "'") }
    catch [System.Management.Automation.ItemNotFoundException] { return "(key absent)" }
    catch [System.Management.Automation.PSArgumentException] { return "(value absent)" }
    catch { return ("(read failed: " + $_.Exception.GetType().Name + ")") }
}
$admin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
Add ("Items 1, 4, 13 -- " + $env:COMPUTERNAME + " -- " + (Get-Date -Format "yyyy-MM-dd HH:mm:ss") + " -- administrator: " + $admin)
Add ""

Add "== ITEM 1: Windows Update"
try { $svc = Get-Service wuauserv -EA Stop; Add ("  wuauserv StartType=" + $svc.StartType + "  Status=" + $svc.Status + "   <- the ONLY thing item 1 reads today") } catch { Add ("  wuauserv: " + $_.Exception.Message) }
foreach ($n in "NoAutoUpdate", "AUOptions") { Add ("  Policy AU\" + $n + " = " + (RegVal "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" $n)) }
foreach ($n in "PauseUpdatesExpiryTime", "PauseUpdatesStartTime", "PauseQualityUpdatesEndTime", "PauseFeatureUpdatesEndTime") { Add ("  UX\Settings\" + $n + " = " + (RegVal "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" $n)) }
try {
    $ses = New-Object -ComObject Microsoft.Update.Session
    $srch = $ses.CreateUpdateSearcher()
    $cnt = $srch.GetTotalHistoryCount()
    Add ("  Update history entries: " + $cnt)
    if ($cnt -gt 0) {
        $h = $srch.QueryHistory(0, [Math]::Min(5, $cnt))
        foreach ($e in $h) { Add ("    " + $e.Date.ToLocalTime().ToString("yyyy-MM-dd HH:mm") + "  result=" + $e.ResultCode + "  " + $e.Title) }
    }
} catch { Add ("  Update history: " + $_.Exception.Message) }
Add ""

Add "== ITEM 4: SmartScreen (Windows Security -> App & browser control -> Reputation-based protection)"
Add ("  Check apps and files   HKLM Explorer\SmartScreenEnabled = " + (RegVal "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" "SmartScreenEnabled") + "   <- the ONLY value item 4 reads and writes")
Add ("  Policy System\EnableSmartScreen = " + (RegVal "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "EnableSmartScreen"))
Add ("  SmartScreen for Edge   HKCU Edge\SmartScreenEnabled (default value) = " + (RegVal "HKCU:\SOFTWARE\Microsoft\Edge\SmartScreenEnabled" "(default)") + "   (flip-proven 2026-09-28: 1 on, 0 off)")
Add ("  Edge policy SmartScreenEnabled = " + (RegVal "HKLM:\SOFTWARE\Policies\Microsoft\Edge" "SmartScreenEnabled"))
Add ("  Store apps             HKCU AppHost\EnableWebContentEvaluation = " + (RegVal "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" "EnableWebContentEvaluation") + "   (flip-proven 2026-09-28: absent or 1 on, 0 off)")
foreach ($n in "VerifiedAndReputablePolicyState", "VerifiedAndReputablePolicyStateMinValueSeen") { Add ("  Smart App Control CI\Policy\" + $n + " = " + (RegVal "HKLM:\SYSTEM\CurrentControlSet\Control\CI\Policy" $n) + "   (can lock these toggles, FT-260)") }
try { $mp = Get-MpPreference -EA Stop; Add ("  Unwanted app blocking  Get-MpPreference PUAProtection = " + $mp.PUAProtection + "   (checked at start, E3)") } catch { Add ("  PUAProtection: " + $_.Exception.Message) }
Add ""

Add "== ITEM 13: Edge Startup boost / Continue running background extensions and apps"
$ls = Join-Path $env:LOCALAPPDATA "Microsoft\Edge\User Data\Local State"
if (Test-Path $ls) {
    try {
        $j = Get-Content $ls -Raw -EA Stop | ConvertFrom-Json
        Add ("  Local State startup_boost   = " + $(if ($j.startup_boost) { ($j.startup_boost | ConvertTo-Json -Compress) } else { "(section absent)" }))
        Add ("  Local State background_mode = " + $(if ($j.background_mode) { ($j.background_mode | ConvertTo-Json -Compress) } else { "(section absent)" }))
        Add ("  Local State file time: " + (Get-Item $ls).LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss"))
    } catch { Add ("  Local State: " + $_.Exception.Message) }
} else { Add "  Local State: file not found" }
foreach ($n in "StartupBoostEnabled", "BackgroundModeEnabled") { Add ("  Edge policy " + $n + " = " + (RegVal "HKLM:\SOFTWARE\Policies\Microsoft\Edge" $n)) }
$edge = @(Get-Process msedge -EA SilentlyContinue).Count
Add ("  msedge processes running now: " + $edge + "  (Edge writes Local State when it closes -- close Edge fully before the second run)")

$L | Set-Content -Path $out -Encoding UTF8
$L | ForEach-Object { Write-Host $_ }
Write-Host ""
Write-Host ("Saved to: " + $out)
