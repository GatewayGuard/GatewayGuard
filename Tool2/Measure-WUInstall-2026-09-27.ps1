# Measure-WUInstall-2026-09-27.ps1
# Dated: 2026-09-27 10:22 ET
# Editor: Claude Code (CGDELL)
# Purpose: ascii45 E2. Measures the Windows Update DOWNLOAD and INSTALL calls
#          exactly as Invoke-WindowsUpdateLoop makes them, so they can carry a
#          VERIFIED comment. Bill approved running it on CGDELL, 2026-09-27.
# NOT READ-ONLY: installs the updates that are waiting (at 08:24 that was the
#          Malicious Software Removal Tool and a Defender definitions update).
#          Does NOT restart the PC. Run as administrator.
# Output: Test_Results\WUInstall-<machine>-<stamp>.txt

$out = Join-Path (Split-Path -Parent $PSScriptRoot) ("Test_Results\WUInstall-" + $env:COMPUTERNAME + "-" + (Get-Date -Format "yyyy-MM-dd_HH-mm") + ".txt")
$L = New-Object System.Collections.Generic.List[string]
function Add($s) { $line = ("[{0:HH:mm:ss}] " -f (Get-Date)) + [string]$s; $L.Add($line); Write-Host $line }
$admin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
Add "Windows Update install measurement -- $env:COMPUTERNAME -- elevated: $admin"
try {
    $sess = New-Object -ComObject Microsoft.Update.Session
    $t0 = Get-Date
    $r = $sess.CreateUpdateSearcher().Search("IsInstalled=0 and IsHidden=0 and Type='Software'")
    Add ("Search: ResultCode {0}, {1} update(s), {2:N1} s" -f $r.ResultCode, $r.Updates.Count, ((Get-Date) - $t0).TotalSeconds)
    $coll = New-Object -ComObject Microsoft.Update.UpdateColl
    for ($i = 0; $i -lt $r.Updates.Count; $i++) {
        $u = $r.Updates.Item($i)
        Add ("  - {0}  (EulaAccepted={1}, downloaded={2})" -f $u.Title, $u.EulaAccepted, $u.IsDownloaded)
        if ($u.EulaAccepted) { [void]$coll.Add($u) }
    }
    Add "UpdateColl.Count = $($coll.Count)"
    if ($coll.Count -eq 0) { Add "Nothing to install -- download/install NOT exercised." }
    else {
        $t1 = Get-Date
        $dl = $sess.CreateUpdateDownloader(); $dl.Updates = $coll; $dr = $dl.Download()
        Add ("Download: ResultCode {0}, {1:N1} s" -f $dr.ResultCode, ((Get-Date) - $t1).TotalSeconds)
        $t2 = Get-Date
        $in = $sess.CreateUpdateInstaller(); $in.Updates = $coll; $ir = $in.Install()
        Add ("Install: ResultCode {0}, RebootRequired {1}, {2:N1} s" -f $ir.ResultCode, $ir.RebootRequired, ((Get-Date) - $t2).TotalSeconds)
        for ($i = 0; $i -lt $coll.Count; $i++) { Add ("  - {0}: result {1}" -f $coll.Item($i).Title, $ir.GetUpdateResult($i).ResultCode) }
    }
    $r2 = $sess.CreateUpdateSearcher().Search("IsInstalled=0 and IsHidden=0 and Type='Software'")
    Add "Search again: $($r2.Updates.Count) update(s) waiting"
    Add ("SystemInfo.RebootRequired = " + (New-Object -ComObject Microsoft.Update.SystemInfo).RebootRequired)
} catch { Add "FAILED: $($_.Exception.GetType().Name): $($_.Exception.Message)" }
$L | Out-File -FilePath $out -Encoding UTF8
"Saved to: $out"
