# Measure-BlockE-Flips-2026-09-27.ps1
# Dated: 2026-09-27 08:26 ET
# Editor: Claude Code (CGDELL)
# Purpose: ascii45 Block E. Three calls CHANGE something, so reading their
#          parameters is not enough -- each is run once here and undone:
#   E3  Set-MpPreference -PUAProtection Enabled, read back, then RESTORED to
#       whatever it was before (CGDELL: AuditMode, measured 08:24).
#   E4  Update-MpSignature -- updates Defender's definitions (Windows does this
#       on its own every day; nothing to undo).
#   E6  MpCmdRun -Scan -ScanType 2 started DETACHED (so it outlives Checkup),
#       confirmed running, then CANCELLED with MpCmdRun -Scan -Cancel.
# NOT read-only, but leaves the PC as it found it. Run as administrator.
# Output: Test_Results\BlockE-Flips-<machine>-<stamp>.txt

$out = Join-Path (Split-Path -Parent $PSScriptRoot) ("Test_Results\BlockE-Flips-" + $env:COMPUTERNAME + "-" + (Get-Date -Format "yyyy-MM-dd_HH-mm") + ".txt")
$L = New-Object System.Collections.Generic.List[string]
function Add($s) { $L.Add(("[{0:HH:mm:ss}] " -f (Get-Date)) + [string]$s) }
Add "Block E flip measurements -- $env:COMPUTERNAME"

# ---- E3: PUA ----
$before = (Get-MpPreference).PUAProtection
Add "E3 PUAProtection before: $before"
try {
    Set-MpPreference -PUAProtection Enabled -EA Stop
    Add "E3 Set-MpPreference -PUAProtection Enabled: no error"
} catch { Add "E3 Set FAILED: $($_.Exception.GetType().Name): $($_.Exception.Message)" }
Start-Sleep -Seconds 2
Add "E3 PUAProtection after set: $((Get-MpPreference).PUAProtection)   (1 = Enabled)"
$restore = switch ([int]$before) { 0 { "Disabled" } 1 { "Enabled" } 2 { "AuditMode" } default { "AuditMode" } }
try { Set-MpPreference -PUAProtection $restore -EA Stop; Add "E3 restored with -PUAProtection $restore" } catch { Add "E3 RESTORE FAILED: $_" }
Start-Sleep -Seconds 2
Add "E3 PUAProtection after restore: $((Get-MpPreference).PUAProtection)   (must equal $before)"

# ---- E4: signatures ----
$s0 = Get-MpComputerStatus
Add ("E4 before: version {0}, last updated {1}, age {2} day(s)" -f $s0.AntivirusSignatureVersion, $s0.AntivirusSignatureLastUpdated, $s0.AntivirusSignatureAge)
$t0 = Get-Date
try { Update-MpSignature -EA Stop; Add ("E4 Update-MpSignature: no error, {0:N0} s" -f ((Get-Date) - $t0).TotalSeconds) } catch { Add "E4 Update-MpSignature FAILED: $_" }
$s1 = Get-MpComputerStatus
Add ("E4 after:  version {0}, last updated {1}, age {2} day(s)" -f $s1.AntivirusSignatureVersion, $s1.AntivirusSignatureLastUpdated, $s1.AntivirusSignatureAge)

# ---- E6: full scan, detached, then cancelled ----
$mp = Join-Path $env:ProgramFiles "Windows Defender\MpCmdRun.exe"
$p = Start-Process -FilePath $mp -ArgumentList "-Scan -ScanType 2" -WindowStyle Hidden -PassThru
Add "E6 started MpCmdRun -Scan -ScanType 2 detached, PID $($p.Id)"
Start-Sleep -Seconds 15
$running = Get-Process -Id $p.Id -EA SilentlyContinue
$s2 = Get-MpComputerStatus
Add ("E6 after 15 s: MpCmdRun still running = {0}; FullScanStartTime = {1}" -f [bool]$running, $s2.FullScanStartTime)
try { $sc = Get-MpThreatDetection -EA SilentlyContinue | Out-Null } catch {}
$c = & $mp -Scan -Cancel 2>&1 | Out-String
Add ("E6 MpCmdRun -Scan -Cancel exit {0}: {1}" -f $LASTEXITCODE, (($c -replace "\s+", " ").Trim()))
Start-Sleep -Seconds 5
Add ("E6 after cancel: MpCmdRun PID {0} still running = {1}" -f $p.Id, [bool](Get-Process -Id $p.Id -EA SilentlyContinue))
try { $p.Refresh(); if ($p.HasExited) { Add "E6 scan process exit code: $($p.ExitCode)" } } catch {}

$L | Out-File -FilePath $out -Encoding UTF8
$L
"Saved to: $out"
