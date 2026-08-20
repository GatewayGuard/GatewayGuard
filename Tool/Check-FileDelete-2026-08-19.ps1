# Dated: 2026-08-19 23:45 ET
# File: Check-FileDelete-2026-08-19.ps1
#
#   WHY THIS EXISTS: Show-AllScreens.bat vanished from the GatewayGuard folder
#   on both machines and Bill did not delete it. OneDrive reported it as
#   deleted, which means SOMETHING on ONE machine deleted it and the sync
#   carried that deletion to the other.
#
#   This asks the four things on this PC that can delete a file without telling
#   you: Microsoft Defender, Malwarebytes, the Recycle Bin, and OneDrive. It
#   also decodes the Recycle Bin index files, which record the ORIGINAL FULL
#   PATH of anything deleted -- so a file sitting in the bin under a scrambled
#   name can still be identified.
#
#   READ-ONLY. It changes nothing, deletes nothing, and needs no administrator.
#   Results are written to a file so nothing scrolls off the top of the window.

$ErrorActionPreference = "Continue"

$stamp   = Get-Date -Format "yyyy-MM-dd_HH-mm"
$results = Join-Path (Split-Path -Parent $PSScriptRoot) "Test_Results"
if (-not (Test-Path $results)) { New-Item -ItemType Directory -Path $results -Force | Out-Null }
$outFile = Join-Path $results ("FileDeleteCheck-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

$L = New-Object System.Collections.ArrayList
function W([string]$t) { [void]$L.Add($t); Write-Host $t }

W ("=" * 70)
W "  WHAT DELETED Show-AllScreens.bat"
W ("=" * 70)
W ("  machine        : " + $env:COMPUTERNAME)
W ("  user           : " + $env:USERNAME)
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
W ("  elevated       : " + $isAdmin + "   (not required -- this only reads)")
W ("  run at         : " + (Get-Date -Format "yyyy-MM-dd HH:mm:ss"))
W ""

# ---------------------------------------------------------------- 1. the file
W "-- 1. IS THE FILE THERE NOW ------------------------------------------"
$target = Join-Path $PSScriptRoot "Show-AllScreens.bat"
if (Test-Path $target) {
    $f = Get-Item $target
    W ("  PRESENT   " + $f.Length + " bytes   last written " + $f.LastWriteTime)
} else {
    W "  MISSING from this PC."
}
W ""

# ------------------------------------------------------------- 2. Defender
W "-- 2. MICROSOFT DEFENDER ---------------------------------------------"
try {
    $det = Get-MpThreatDetection -ErrorAction Stop | Sort-Object InitialDetectionTime -Descending | Select-Object -First 10
    if ($det) {
        foreach ($d in $det) {
            W ("  " + $d.InitialDetectionTime + "   action succeeded=" + $d.ActionSuccess)
            foreach ($r in $d.Resources) { W ("      " + $r) }
        }
    } else { W "  no detections recorded" }
} catch { W ("  could not read detections: " + $_.Exception.Message) }

try {
    $thr = Get-MpThreat -ErrorAction Stop | Select-Object -First 10
    if ($thr) { foreach ($t in $thr) { W ("  threat: " + $t.ThreatName) } }
    else { W "  no threats recorded" }
} catch { W ("  could not read threats: " + $_.Exception.Message) }

# VERIFIED 2026-08-19 measured on CGDELL: MpCmdRun.exe -Restore -ListAll
# prints "No quarantined items." and exits cleanly. Platform path used was
# C:\ProgramData\Microsoft\Windows Defender\Platform\4.18.26070.9-0.
try {
    $plat = Get-ChildItem (Join-Path $env:ProgramData "Microsoft\Windows Defender\Platform") -Directory -ErrorAction Stop |
            Sort-Object Name -Descending | Select-Object -First 1
    $mpc = Join-Path $plat.FullName "MpCmdRun.exe"
    if (Test-Path $mpc) {
        W "  quarantine list:"
        foreach ($line in (& $mpc -Restore -ListAll 2>&1)) { W ("      " + $line) }
    }
} catch { W ("  could not run the quarantine list: " + $_.Exception.Message) }

W "  Defender event log (detected / action taken), newest 15:"
try {
    $ev = Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-Windows Defender/Operational'; Id=@(1116,1117,1118,1119,1006,1007)} -MaxEvents 15 -ErrorAction Stop
    foreach ($e in $ev) {
        W ("      " + $e.TimeCreated + "  Id=" + $e.Id)
        $keep = ($e.Message -split "`n") | Where-Object { $_ -match "Path:|Name:" } | Select-Object -First 2
        foreach ($k in $keep) { W ("          " + $k.Trim()) }
    }
} catch { W "      no matching events" }
W ""

# -------------------------------------------------------- 3. Malwarebytes
W "-- 3. MALWAREBYTES ---------------------------------------------------"
$svc = Get-Service -Name MBAMService -ErrorAction SilentlyContinue
if ($svc) { W ("  service        : " + $svc.Status + " / " + $svc.StartType) }
else       { W "  service        : not installed on this PC" }

$q = "C:\ProgramData\Malwarebytes\MBAMService\Quarantine"
if (Test-Path $q) {
    $qi = @(Get-ChildItem $q -File -Force -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 10)
    W ("  quarantine     : " + $qi.Count + " item(s) shown, newest first")
    foreach ($i in $qi) { W ("      " + $i.LastWriteTime + "   " + $i.Name) }
} else { W "  quarantine     : folder not present" }

$mbl = "C:\ProgramData\Malwarebytes\MBAMService\logs"
if (Test-Path $mbl) {
    W "  newest log files:"
    Get-ChildItem $mbl -File -Recurse -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending | Select-Object -First 5 |
        ForEach-Object { W ("      " + $_.LastWriteTime + "   " + $_.Name) }
}
W ""

# --------------------------------------------------------- 4. Recycle Bin
W "-- 4. RECYCLE BIN, WITH THE ORIGINAL PATHS DECODED -------------------"
W "  Every deleted file leaves a small index file whose name starts with"
W "  dollar-I. It records where the file came from. This reads those, so a"
W "  scrambled name in the bin is not a hiding place."
$sid = ([Security.Principal.WindowsIdentity]::GetCurrent()).User.Value
foreach ($drive in @("C:", "D:", "E:")) {
    if (-not (Test-Path ($drive + "\"))) { continue }
    $rb = Join-Path $drive ('$Recycle.Bin\' + $sid)
    if (-not (Test-Path $rb)) { W ("  " + $rb + " -- none"); continue }
    $idx = @(Get-ChildItem $rb -Force -File -Filter '$I*' -ErrorAction SilentlyContinue |
             Sort-Object LastWriteTime -Descending | Select-Object -First 25)
    W ("  " + $rb + " -- " + $idx.Count + " entries, newest first:")
    foreach ($i in $idx) {
        $orig = "(could not decode)"
        try {
            $b = [System.IO.File]::ReadAllBytes($i.FullName)
            if ($b.Length -gt 28) {
                $ver = [BitConverter]::ToInt64($b, 0)
                if ($ver -eq 2) {
                    $nameLen = [BitConverter]::ToInt32($b, 24)
                    if ($nameLen -gt 0 -and (28 + ($nameLen * 2)) -le $b.Length) {
                        $orig = [System.Text.Encoding]::Unicode.GetString($b, 28, ($nameLen * 2) - 2)
                    }
                } else {
                    $orig = ([System.Text.Encoding]::Unicode.GetString($b, 24, $b.Length - 24)).TrimEnd([char]0)
                }
            }
        } catch { }
        W ("      " + $i.LastWriteTime + "   " + $orig)
    }
}
W ""

# ------------------------------------------------------------- 5. OneDrive
W "-- 5. ONEDRIVE -------------------------------------------------------"
$od = @(Get-Process OneDrive -ErrorAction SilentlyContinue)
W ("  running        : " + $od.Count + " process(es)")
foreach ($p in $od) { try { W ("      started " + $p.StartTime) } catch { } }
W ("  business root  : " + $env:OneDriveCommercial)
W ("  personal root  : " + $env:OneDriveConsumer)
W ""

W ("=" * 70)
W "  WHAT THIS TELLS YOU"
W ("=" * 70)
W "  Section 2 or 3 names the file  -- security software removed it, and the"
W "                                    fix is an exclusion for the Tool folder."
W "  Section 4 shows it             -- an ordinary delete happened on this PC."
W "  All four empty on BOTH PCs     -- the record is only in the OneDrive"
W "                                    recycle bin on the web, which names who"
W "                                    deleted it and when."
W ""

Set-Content -LiteralPath $outFile -Value ($L -join "`r`n") -Encoding UTF8
Write-Host ""
Write-Host ("  Saved to: " + $outFile) -ForegroundColor Green
Write-Host ""
