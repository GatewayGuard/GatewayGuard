# Measure-BlockE-2026-09-27.ps1
# Dated: 2026-09-27 08:23 ET
# Editor: Claude Code (CGDELL)
# Purpose: ascii45 Block E. Every external call Block E will make must carry a
#          VERIFIED comment (gate 24). This measures each one on this PC.
# READ-ONLY. Changes nothing: it reads Defender state, lists the parameters of
#          the commands that WOULD change things (without running them), and
#          runs a Windows Update SEARCH (no download, no install).
# Run as administrator (Defender reads need it). Does not elevate itself.
# Output: Test_Results\BlockE-<machine>-<stamp>.txt

$out = Join-Path (Split-Path -Parent $PSScriptRoot) ("Test_Results\BlockE-" + $env:COMPUTERNAME + "-" + (Get-Date -Format "yyyy-MM-dd_HH-mm") + ".txt")
$L = New-Object System.Collections.Generic.List[string]
function Add($s) { $L.Add([string]$s) }
$admin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
Add "Block E measurements -- $env:COMPUTERNAME -- $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') -- elevated: $admin"

Add ""; Add "== 1. Get-MpComputerStatus fields (E1, E4, E7)"
try {
    $s = Get-MpComputerStatus -EA Stop
    foreach ($p in "IsTamperProtected","TamperProtectionSource","AntivirusEnabled","RealTimeProtectionEnabled","AntivirusSignatureAge","AntivirusSignatureLastUpdated","AntivirusSignatureVersion","QuickScanEndTime","QuickScanAge","FullScanEndTime","FullScanAge","FullScanStartTime") {
        Add ("  {0,-30} = {1}" -f $p, $s.$p)
    }
} catch { Add "  FAILED: $_" }

Add ""; Add "== 2. Get-MpPreference PUAProtection (E3)"
try { $pr = Get-MpPreference -EA Stop; Add "  PUAProtection = $($pr.PUAProtection)  (0 = off, 1 = on, 2 = audit per Microsoft docs)" } catch { Add "  FAILED: $_" }

Add ""; Add "== 3. Set-MpPreference -PUAProtection: parameter metadata only (NOT run)"
try {
    $pm = (Get-Command Set-MpPreference -EA Stop).Parameters["PUAProtection"]
    Add "  type: $($pm.ParameterType.FullName)"
    try { Add ("  values: " + ([Enum]::GetNames($pm.ParameterType) -join ", ")) } catch { Add "  values: (not an enum)" }
    $va = $pm.Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }
    if ($va) { Add ("  ValidateSet: " + ($va.ValidValues -join ", ")) }
} catch { Add "  FAILED: $_" }

Add ""; Add "== 4. Update-MpSignature: parameters (NOT run)"
try { Add ("  " + ((Get-Command Update-MpSignature -EA Stop).Parameters.Keys -join ", ")) } catch { Add "  FAILED: $_" }

Add ""; Add "== 5. MpCmdRun.exe -? : the scan lines (E6)"
$mp = Join-Path $env:ProgramFiles "Windows Defender\MpCmdRun.exe"
Add "  path exists: $(Test-Path $mp)  ($mp)"
if (Test-Path $mp) {
    $h = & $mp -? 2>&1 | Out-String
    $i = $h.IndexOf("-Scan")
    if ($i -ge 0) { Add ($h.Substring($i, [Math]::Min(900, $h.Length - $i)) -replace "`r", "") } else { Add "  no -Scan section found" }
}

Add ""; Add "== 6. Start-MpScan: parameters (NOT run)"
try {
    $c = Get-Command Start-MpScan -EA Stop
    Add ("  params: " + ($c.Parameters.Keys -join ", "))
    $st = $c.Parameters["ScanType"]
    try { Add ("  ScanType values: " + ([Enum]::GetNames($st.ParameterType) -join ", ")) } catch {}
    $va = $st.Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }
    if ($va) { Add ("  ScanType ValidateSet: " + ($va.ValidValues -join ", ")) }
} catch { Add "  FAILED: $_" }

Add ""; Add "== 7. Windows Update Agent: SEARCH ONLY (E2) -- nothing downloaded or installed"
try {
    $t0 = Get-Date
    $sess = New-Object -ComObject Microsoft.Update.Session
    $srch = $sess.CreateUpdateSearcher()
    $r = $srch.Search("IsInstalled=0 and IsHidden=0 and Type='Software'")
    Add ("  search took {0:N1} s, ResultCode = {1} (2 = succeeded), updates found = {2}" -f ((Get-Date) - $t0).TotalSeconds, $r.ResultCode, $r.Updates.Count)
    for ($k = 0; $k -lt [Math]::Min(10, $r.Updates.Count); $k++) {
        $u = $r.Updates.Item($k)
        Add ("   - {0}  (downloaded={1}, reboot may be needed={2}, EULA accepted={3})" -f $u.Title, $u.IsDownloaded, $u.InstallationBehavior.RebootBehavior, $u.EulaAccepted)
    }
} catch { Add "  FAILED: $_" }
try { $si = New-Object -ComObject Microsoft.Update.SystemInfo; Add "  SystemInfo.RebootRequired = $($si.RebootRequired)" } catch { Add "  SystemInfo FAILED: $_" }
try {
    $hist = $srch.QueryHistory(0, [Math]::Min(5, $srch.GetTotalHistoryCount()))
    Add "  last install history (up to 5):"
    foreach ($e in $hist) { Add ("   - {0:yyyy-MM-dd HH:mm}  result={1}  {2}" -f $e.Date, $e.ResultCode, $e.Title) }
} catch { Add "  history FAILED: $_" }

$L | Out-File -FilePath $out -Encoding UTF8
$L
""
"Saved to: $out"
