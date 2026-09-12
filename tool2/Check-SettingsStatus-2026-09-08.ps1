# =====================================================================
#  CHECK SETTINGS STATUS -- what Checkup can read, what it can change,
#  and what each setting is RIGHT NOW on this machine.
#
#  READ-ONLY. Changes nothing. No administrator needed for most rows;
#  the ones that need it say so instead of guessing.
#
#  Bill, 2026-09-08: "update the settings list with checkup status i.e.
#  blocked can't read or can read, but can't change or can read and
#  change setting and current setting is x"
#
#  Setting 5 (Defender Periodic Scanning) and every Malwarebytes row are
#  REMOVED BY BILL'S DECISION of 2026-09-08 and are reported as such
#  rather than silently dropped -- a reader of an old log needs to know
#  why the row went.
# =====================================================================

$ErrorActionPreference = 'Continue'

$repo = Split-Path -Parent $PSScriptRoot
$outDir = Join-Path $repo 'Test_Results'
$stamp  = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$outFile = Join-Path $outDir ("SettingsStatus-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

$L = New-Object System.Collections.Generic.List[string]
function W($t) { $L.Add($t); Write-Host $t }

# --- is this session elevated? ---------------------------------------
$isAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

W ("=" * 70)
W "  CHECKUP SETTINGS STATUS -- read / change / current value"
W ("  " + $env:COMPUTERNAME + "   " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
W ("=" * 70)
W ""
W ("  Administrator : " + $isAdmin)
$os = (Get-CimInstance Win32_OperatingSystem).Caption
$dv = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -EA SilentlyContinue).DisplayVersion
W ("  Windows       : " + $os + "  " + $dv)
W ""
W "  READ-ONLY. Nothing was changed."
W ""

# --- helper: read a registry value and say WHY it failed --------------
# The whole point of this script is that 'absent', 'blocked' and 'off'
# are three different answers. -EA SilentlyContinue collapses them into
# one, which is the FT-257 defect. So: -EA Stop and a typed catch.
function Get-GGValue {
    param([string]$Path, [string]$Name)
    try {
        $v = (Get-ItemProperty -Path $Path -Name $Name -EA Stop).$Name
        if ($null -eq $v) { return @{ State = 'ABSENT'; Value = $null } }
        return @{ State = 'READ'; Value = $v }
    }
    catch [System.Security.SecurityException]        { return @{ State = 'BLOCKED'; Value = $null } }
    catch [System.UnauthorizedAccessException]       { return @{ State = 'BLOCKED'; Value = $null } }
    catch [System.Management.Automation.ItemNotFoundException] { return @{ State = 'ABSENT'; Value = $null } }
    catch {
        if ($_.Exception -is [System.Security.SecurityException]) { return @{ State = 'BLOCKED'; Value = $null } }
        return @{ State = 'ABSENT'; Value = $null }
    }
}

$rows = New-Object System.Collections.Generic.List[object]
function Row($id, $name, $canRead, $canChange, $current, $note) {
    $rows.Add([PSCustomObject]@{
        ID = $id; Name = $name; CanRead = $canRead
        CanChange = $canChange; Current = $current; Note = $note })
}

# ---------------------------------------------------------------- 1 --
try {
    $svc = Get-Service wuauserv -EA Stop
    Row 1 'Windows Update' 'YES' 'YES' ("service StartType = " + $svc.StartType + ", Status = " + $svc.Status) ''
} catch { Row 1 'Windows Update' 'NO -- read failed' 'YES' 'unknown' $_.Exception.GetType().Name }

# ---------------------------------------------------------------- 2 --
try {
    $mp = Get-MpComputerStatus -EA Stop
    Row 2 'Defender Real-Time Protection' 'YES' 'YES -- unless another AV holds it' `
        ("RealTimeProtectionEnabled = " + $mp.RealTimeProtectionEnabled) ''
} catch { Row 2 'Defender Real-Time Protection' 'NO -- read failed' 'CONDITIONAL' 'unknown' $_.Exception.GetType().Name }

# ---------------------------------------------------------------- 3 --
try {
    $tp = (Get-MpComputerStatus -EA Stop).IsTamperProtected
    Row 3 'Tamper Protection' 'YES' 'NO -- Windows forbids it, by design' ("IsTamperProtected = " + $tp) `
        'Checkup shows the Windows Security path instead'
} catch { Row 3 'Tamper Protection' 'NO -- read failed' 'NO -- by design' 'unknown' $_.Exception.GetType().Name }

# ---------------------------------------------------------------- 4 --
$ss = Get-GGValue 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' 'SmartScreenEnabled'
$sacRaw = (Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\CI\Policy' -EA SilentlyContinue).VerifiedAndReputablePolicyState
$sacOn = ($sacRaw -eq 1)
$ssNote = if ($sacOn) { 'Smart App Control is ON, so the Windows Security toggle is GREYED OUT (FT-260)' } else { '' }
switch ($ss.State) {
    'READ'    { Row 4 'SmartScreen (Check apps and files)' 'YES' 'YES -- registry write works even when the toggle is greyed' ("SmartScreenEnabled = '" + $ss.Value + "'") $ssNote }
    'BLOCKED' { Row 4 'SmartScreen (Check apps and files)' 'NO -- BLOCKED' 'unknown' 'could not read' $ssNote }
    default   { Row 4 'SmartScreen (Check apps and files)' 'YES' 'YES' 'NOT SET (absent)' $ssNote }
}

# ---------------------------------------------------------------- 5 --
Row 5 'Defender Periodic Scanning' '--' '--' 'REMOVED FROM CHECKUP' `
    "Bill's decision 2026-09-08. It only means anything when another AV holds real-time protection"

# ---------------------------------------------------------------- 6 --
$wt = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components'
$pp = Get-GGValue $wt 'ServiceEnabled'
if ($pp.State -eq 'BLOCKED') {
    Row 6 'Edge Phishing Protection (3 options)' 'NO -- BLOCKED by Tamper Protection' 'NO -- writes refused too' `
        'cannot be read here' 'The SCREEN is the truth for this one, not the registry'
} else {
    $vals = @()
    foreach ($n in 'ServiceEnabled','NotifyMalicious','NotifyPasswordReuse','NotifyUnsafeApp') {
        $g = Get-GGValue $wt $n
        $vals += ($n + '=' + $(if ($g.State -eq 'READ') { $g.Value } else { $g.State }))
    }
    Row 6 'Edge Phishing Protection (3 options)' 'PARTIAL -- values read but may not reflect the screen' `
        'NO -- writes refused by Tamper Protection (measured 2026-09-07)' ($vals -join ', ') `
        'Measured 2026-09-07: all four read NOT SET while the screen showed all four ON'
}

# ---------------------------------------------------------------- 7 --
try {
    $fw = Get-NetFirewallProfile -EA Stop | Select-Object Name, Enabled
    Row 7 'Firewall (all profiles)' 'YES' 'YES' (($fw | ForEach-Object { $_.Name + '=' + $_.Enabled }) -join ', ') ''
} catch { Row 7 'Firewall (all profiles)' 'NO -- read failed' 'YES' 'unknown' $_.Exception.GetType().Name }

# ---------------------------------------------------------------- 8 --
try {
    $bl = Get-BitLockerVolume -MountPoint $env:SystemDrive -EA Stop
    Row 8 'BitLocker / Device Encryption' 'YES' 'YES -- only on its own screen, with explicit permission' `
        ("ProtectionStatus = " + $bl.ProtectionStatus) 'Product rule, not a technical limit'
} catch { Row 8 'BitLocker / Device Encryption' 'NO -- needs admin, or not supported' 'CONDITIONAL' 'could not read' $_.Exception.GetType().Name }

# ---------------------------------------------------------------- 9 --
$ngc = Test-Path "$env:LOCALAPPDATA\Microsoft\NGC"
Row 9 'Windows Hello' 'YES' 'NO -- enrolment needs the person at the machine' `
    ("PIN/biometric configured = " + $ngc) 'Checkup shows the Settings path instead'

# --------------------------------------------------------------- 10 --
$rd = Get-GGValue 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' 'fDenyTSConnections'
Row 10 'Remote Desktop -- Disable' $(if ($rd.State -eq 'BLOCKED') { 'NO -- BLOCKED' } else { 'YES' }) 'YES' `
    $(if ($rd.State -eq 'READ') { "fDenyTSConnections = " + $rd.Value + $(if ($rd.Value -eq 1) { ' (disabled)' } else { ' (ENABLED)' }) } else { $rd.State }) `
    'Not present on Windows 11 Home at all'

# --------------------------------------------------------------- 11 --
$ai = Get-GGValue 'HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo' 'Enabled'
Row 11 'Advertising ID -- Turn Off' $(if ($ai.State -eq 'BLOCKED') { 'NO -- BLOCKED' } else { 'YES' }) 'YES' `
    $(if ($ai.State -eq 'READ') { "Enabled = " + $ai.Value + $(if ($ai.Value -eq 0) { ' (off)' } else { ' (ON)' }) } else { $ai.State }) `
    'A blocked read currently reports "needs attention" -- a false BAD'

# --------------------------------------------------------------- 12 --
$dd = Get-GGValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' 'AllowTelemetry'
Row 12 'Diagnostic Data -- Required Only' $(if ($dd.State -eq 'BLOCKED') { 'NO -- BLOCKED' } else { 'YES' }) 'YES' `
    $(if ($dd.State -eq 'READ') { "AllowTelemetry = " + $dd.Value } else { $dd.State + ' (absent = Windows default, sending extra)' }) `
    'A blocked read currently reports "needs attention" -- a false BAD'

# --------------------------------------------------------------- 13 --
$ep = 'HKCU:\Software\Microsoft\Edge'
$sb = Get-GGValue $ep 'StartupBoostEnabled'
$bg = Get-GGValue $ep 'BackgroundModeEnabled'
Row 13 'Edge Startup Boost + Background' 'YES' 'YES' `
    ("StartupBoost=" + $(if ($sb.State -eq 'READ') { $sb.Value } else { $sb.State }) + `
     ", Background=" + $(if ($bg.State -eq 'READ') { $bg.Value } else { $bg.State })) `
    'Absent usually means the Edge default, which is ON'

# --------------------------------------------------------------- 14 --
$wd = Get-GGValue 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' 'TaskbarDa'
Row 14 'Widgets -- Disable' $(if ($wd.State -eq 'BLOCKED') { 'NO -- BLOCKED' } else { 'YES' }) 'YES' `
    $(if ($wd.State -eq 'READ') { "TaskbarDa = " + $wd.Value + $(if ($wd.Value -eq 0) { ' (off)' } else { ' (ON)' }) } else { $wd.State }) ''

# --------------------------------------------------------------- 15 --
$pwsave = Get-GGValue $ep 'PasswordManagerEnabled'
Row 15 'Edge Password Saving -- Disable' 'YES' 'YES' `
    $(if ($pwsave.State -eq 'READ') { "PasswordManagerEnabled = " + $pwsave.Value } else { $pwsave.State }) ''

# --------------------------------------------------------------- 16 --
try {
    $dg = Get-CimInstance -ClassName Win32_DeviceGuard -Namespace 'root\Microsoft\Windows\DeviceGuard' -EA Stop
    $on = ($dg.SecurityServicesRunning -contains 2)
    Row 16 'Memory Integrity (Core Isolation)' 'YES' 'YES -- but needs a RESTART to take effect' `
        ("SecurityServicesRunning contains 2 = " + $on) ''
} catch {
    $mi = Get-GGValue 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity' 'Enabled'
    Row 16 'Memory Integrity (Core Isolation)' 'PARTIAL -- WMI failed, registry fallback' 'YES -- needs a RESTART' `
        $(if ($mi.State -eq 'READ') { "Enabled = " + $mi.Value } else { $mi.State }) 'WMI class unavailable'
}

# --------------------------------------------------------------- 17 --
$pwOut = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>$null | Out-String
if ($pwOut -match 'Current AC Power Setting Index:\s*0x(\w+)') {
    $acVal = [Convert]::ToUInt32($Matches[1], 16)
    Row 17 'Password Required on Wake' 'YES' 'YES' `
        ("AC index = " + $acVal + $(if ($acVal -eq 1) { ' (required)' } else { ' (NOT required)' })) ''
} else {
    Row 17 'Password Required on Wake' 'NO -- powercfg returned no CONSOLELOCK block' 'YES' `
        'could not read' 'This is FT-256 -- the build reports "NOT required" from a read that produced nothing'
}

# --------------------------------------------------------------- 18 --
$fs = Get-GGValue 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' 'HiberbootEnabled'
Row 18 'Fast Startup -- Disable' $(if ($fs.State -eq 'BLOCKED') { 'NO -- BLOCKED' } else { 'YES' }) 'YES' `
    $(if ($fs.State -eq 'READ') { "HiberbootEnabled = " + $fs.Value + $(if ($fs.Value -eq 0) { ' (off)' } else { ' (ON)' }) } else { $fs.State }) ''

# --------------------------------------------------------------- 19 --
try {
    $ad = Get-NetAdapter -Physical -EA Stop
    $wolBits = @()
    foreach ($a in $ad) {
        try {
            $p = Get-NetAdapterPowerManagement -Name $a.Name -EA Stop
            $wolBits += ($a.Name + '=' + $p.WakeOnMagicPacket)
        } catch { $wolBits += ($a.Name + '=no power management') }
    }
    Row 19 'Wake on LAN -- Disable' 'YES' 'YES' ($wolBits -join '; ') 'Every adapter must be done, not just one'
} catch { Row 19 'Wake on LAN -- Disable' 'NO -- could not enumerate adapters' 'YES' 'unknown' $_.Exception.GetType().Name }

# =====================================================================
W ("-" * 70)
W "  THE SETTINGS"
W ("-" * 70)
W ""
foreach ($r in $rows) {
    W ("  [" + $r.ID.ToString().PadLeft(2) + "]  " + $r.Name)
    W ("        Checkup can READ   : " + $r.CanRead)
    W ("        Checkup can CHANGE : " + $r.CanChange)
    W ("        Current on this PC : " + $r.Current)
    if ($r.Note) { W ("        Note               : " + $r.Note) }
    W ""
}

W ("-" * 70)
W "  WHAT IS NO LONGER IN CHECKUP -- Bill's decision, 2026-09-08"
W ("-" * 70)
W ""
W "  * MALWAREBYTES comes out of the tool entirely. It stays in the"
W "    guide as an optional second opinion the reader may choose."
W "  * SETTING 5, Defender Periodic Scanning, comes out. It only means"
W "    anything while another antivirus holds real-time protection,"
W "    which is the arrangement the tool no longer orchestrates."
W ""
W "  So the list is 18 settings. IDs are NOT renumbered -- 5 is simply"
W "  gone, because the log and the screen table refer to items by ID and"
W "  renumbering would make every earlier log wrong."
W ""

W ("-" * 70)
W "  SMART APP CONTROL"
W ("-" * 70)
W ""
W ("  VerifiedAndReputablePolicyState = " + $(if ($null -eq $sacRaw) { 'not set' } else { $sacRaw }) + "   (0=Off, 1=On, 2=Evaluation)")
if ($sacOn) {
    W ""
    W "  ON. Windows takes over 'Check apps and files' and 'Block apps'"
    W "  and greys them out. Not a fault, and not something Checkup did."
    W "  Checkup cannot see this lock -- that is FT-260."
}
W ""

W ("=" * 70)
W ("  Saved to: " + $outFile)
W ("=" * 70)

[System.IO.File]::WriteAllText($outFile, (($L -join "`r`n") + "`r`n"),
    (New-Object System.Text.UTF8Encoding($false)))
