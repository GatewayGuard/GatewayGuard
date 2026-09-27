# Check-EncryptionStart-2026-09-27.ps1
# Dated: 2026-09-27 15:58 ET
# Editor: Claude Code (CGDELL)
# Purpose: Bill, 2026-09-27: "how did encryption start? can you check".
#          MEASURED so far: on SANDY, Windows logged "Device Encryption
#          initialized by user" for C: and D: at 2026-09-20 18:22:26, while
#          Checkup was waiting for a key on screen 32 (Checkup log). Checkup's
#          Home path runs no encryption command (ascii44 source). This reads
#          every log that could say WHAT started it, 18:10-18:30 that evening.
# READ-ONLY. Changes nothing. Run as administrator. Every read is bounded.
# Output: Test_Results\EncryptionStart-<machine>-<stamp>.txt

$out = Join-Path (Split-Path -Parent $PSScriptRoot) ("Test_Results\EncryptionStart-" + $env:COMPUTERNAME + "-" + (Get-Date -Format "yyyy-MM-dd_HH-mm") + ".txt")
$L = New-Object System.Collections.Generic.List[string]
function Add($s) { $L.Add([string]$s) }
$from = Get-Date "2026-09-20 18:10:00"
$to   = Get-Date "2026-09-20 18:30:00"
Add "WHAT STARTED ENCRYPTION -- $env:COMPUTERNAME -- read $(Get-Date -Format 'yyyy-MM-dd HH:mm') -- window $($from.ToString('yyyy-MM-dd HH:mm')) to $($to.ToString('HH:mm'))"

function Dump($log, $max, [switch]$Full) {
    Add ""; Add "== $log (at most $max)"
    try {
        $ev = Get-WinEvent -FilterHashtable @{ LogName = $log; StartTime = $from; EndTime = $to } -MaxEvents $max -EA Stop | Sort-Object TimeCreated
        foreach ($e in $ev) {
            Add ("  {0:HH:mm:ss} id={1,-5} {2}" -f $e.TimeCreated, $e.Id, (($e.Message -split "`r?`n")[0]))
            if ($Full) {
                try {
                    $x = [xml]$e.ToXml()
                    foreach ($d in @($x.Event.EventData.Data)) { if ($d.'#text') { Add ("           {0} = {1}" -f $d.Name, $d.'#text') } }
                    if ($x.Event.System.Security.UserID) { Add ("           (user SID: " + $x.Event.System.Security.UserID + ", process id: " + $x.Event.System.Execution.ProcessID + ")") }
                } catch {}
            }
        }
        if (-not $ev) { Add "  (nothing in this window)" }
    } catch { Add ("  not readable or no events: " + $_.Exception.Message) }
}

Dump "Microsoft-Windows-BitLocker/BitLocker Management" 60 -Full
Dump "Microsoft-Windows-BitLocker-DrivePreparationTool/Operational" 30 -Full
Dump "Microsoft-Windows-Shell-Core/Operational" 120
Dump "Microsoft-Windows-AppModel-Runtime/Admin" 60
Dump "Microsoft-Windows-AAD/Operational" 60
Dump "Microsoft-Windows-LiveId/Operational" 60
Dump "Microsoft-Windows-User Device Registration/Admin" 60
Dump "Application" 80
Dump "System" 80

Add ""; Add "== Security log: process starts (4688) and sign-ins (4624), if Windows records them (at most 100)"
try {
    $ev = Get-WinEvent -FilterHashtable @{ LogName = "Security"; Id = 4688, 4624; StartTime = $from; EndTime = $to } -MaxEvents 100 -EA Stop | Sort-Object TimeCreated
    foreach ($e in $ev) {
        $x = [xml]$e.ToXml(); $d = @{}; $x.Event.EventData.Data | ForEach-Object { $d[$_.Name] = $_.'#text' }
        if ($e.Id -eq 4688) { Add ("  {0:HH:mm:ss} process started: {1}  (by {2})" -f $e.TimeCreated, $d.NewProcessName, $d.SubjectUserName) }
        else { Add ("  {0:HH:mm:ss} sign-in: {1}\{2} type {3}" -f $e.TimeCreated, $d.TargetDomainName, $d.TargetUserName, $d.LogonType) }
    }
    if (-not $ev) { Add "  (none recorded -- process auditing is usually off on home PCs)" }
} catch { Add ("  not readable: " + $_.Exception.Message) }

Add ""; Add "== Encryption settings in the registry now"
foreach ($k in "HKLM:\SYSTEM\CurrentControlSet\Control\BitLocker", "HKLM:\SOFTWARE\Policies\Microsoft\FVE", "HKLM:\SYSTEM\CurrentControlSet\Control\BitLockerStatus") {
    if (Test-Path $k) {
        $p = Get-ItemProperty $k
        Add "  $k"
        foreach ($n in ($p.PSObject.Properties | Where-Object { $_.Name -notlike "PS*" })) { Add ("     {0} = {1}" -f $n.Name, $n.Value) }
    } else { Add "  $k -- not present" }
}

Add ""; Add "== Which account was signed in (for context)"
try { Add ("  " + (Get-CimInstance Win32_ComputerSystem).UserName) } catch {}
try { Get-LocalUser | Where-Object Enabled | ForEach-Object { Add ("  local account: {0}  source={1}" -f $_.Name, $_.PrincipalSource) } } catch {}

$L | Out-File -FilePath $out -Encoding UTF8
"Saved to: $out"
