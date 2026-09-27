# Check-WhoEncrypted-2026-09-27.ps1
# Dated: 2026-09-27 13:04 ET
# Editor: Claude Code (CGDELL)
# Purpose: find out how SANDY's drive became encrypted. Measured: Checkup read
#          it 0% encrypted on 2026-09-20 18:15 (field log) and it read 100%
#          encrypted, protection Off, on 2026-09-27 12:45
#          (Test_Results\SandyForAscii45-SANDY-2026-09-27_12-45.txt). Bill did
#          not turn it on. Windows' own encryption log says when and why.
# READ-ONLY. Changes nothing. Run as administrator.
# Output: Test_Results\WhoEncrypted-<machine>-<stamp>.txt

$out = Join-Path (Split-Path -Parent $PSScriptRoot) ("Test_Results\WhoEncrypted-" + $env:COMPUTERNAME + "-" + (Get-Date -Format "yyyy-MM-dd_HH-mm") + ".txt")
$L = New-Object System.Collections.Generic.List[string]
function Add($s) { $L.Add([string]$s) }
$since = Get-Date "2026-09-19"
Add "WHO ENCRYPTED THIS DRIVE -- $env:COMPUTERNAME -- $(Get-Date -Format 'yyyy-MM-dd HH:mm') -- events since $($since.ToString('yyyy-MM-dd'))"

Add ""; Add "== 1. Windows' encryption log (Microsoft-Windows-BitLocker/BitLocker Management), oldest first, at most 300"
try {
    $ev = Get-WinEvent -FilterHashtable @{ LogName = "Microsoft-Windows-BitLocker/BitLocker Management"; StartTime = $since } -MaxEvents 300 -EA Stop | Sort-Object TimeCreated
    foreach ($e in $ev) { Add ("  {0:yyyy-MM-dd HH:mm:ss} id={1,-5} {2}" -f $e.TimeCreated, $e.Id, (($e.Message -split "`r?`n")[0])) }
    if (-not $ev) { Add "  (no events since then)" }
} catch { Add "  could not read: $($_.Exception.Message)" }

Add ""; Add "== 2. Restarts since then (System log, event 6005 = Windows started), at most 50"
try {
    Get-WinEvent -FilterHashtable @{ LogName = "System"; Id = 6005; StartTime = $since } -MaxEvents 50 -EA Stop | Sort-Object TimeCreated | ForEach-Object { Add ("  {0:yyyy-MM-dd HH:mm:ss}  Windows started" -f $_.TimeCreated) }
} catch { Add "  could not read: $($_.Exception.Message)" }

Add ""; Add "== 3. Updates installed since then (Windows Update history, at most 40) -- TIMES ARE UTC: subtract 4 hours for Eastern"
try {
    $s = (New-Object -ComObject Microsoft.Update.Session).CreateUpdateSearcher()
    $n = $s.GetTotalHistoryCount()
    if ($n -gt 0) {
        foreach ($h in $s.QueryHistory(0, [Math]::Min(40, $n))) { if ($h.Date -ge $since) { Add ("  {0:yyyy-MM-dd HH:mm}  result={1}  {2}" -f $h.Date, $h.ResultCode, $h.Title) } }
    }
} catch { Add "  could not read: $($_.Exception.Message)" }

Add ""; Add "== 4. Encryption state now"
try {
    $v = Get-BitLockerVolume -MountPoint $env:SystemDrive -EA Stop
    Add ("  VolumeStatus={0}  ProtectionStatus={1}  EncryptionPercentage={2}" -f $v.VolumeStatus, $v.ProtectionStatus, $v.EncryptionPercentage)
    Add ("  Key protectors: " + (($v.KeyProtector | ForEach-Object { [string]$_.KeyProtectorType }) -join ", "))
} catch { Add "  could not read: $($_.Exception.Message)" }

$L | Out-File -FilePath $out -Encoding UTF8
$L
""
"Saved to: $out"
