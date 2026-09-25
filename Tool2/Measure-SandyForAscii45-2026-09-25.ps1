# Measure-SandyForAscii45-2026-09-25.ps1
# Dated: 2026-09-25 15:40 ET
# Editor: Claude Code (CGDELL)
# Purpose: the six SANDY measurements the ascii45 build depends on
#          (FieldTestTriage-ascii44run1, Part 7). Each answers one question a
#          fix cannot be written without.
# READ-ONLY. Changes nothing in the registry, power plan, Defender or
#          BitLocker. The only things it does besides reading: opens one
#          Windows Security page (step 4) and waits while YOU flip one setting
#          in Settings and flip it back (step 6).
# Needs administrator for steps 2 and 4b (manage-bde and the Defender log).
#          It does NOT elevate itself -- right-click the .bat, Run as
#          administrator. It says so if it is not elevated.
# Output: Test_Results\SandyForAscii45-<machine>-<stamp>.txt
# -NoPrompt skips the two steps that need a person (used to test it on CGDELL).

param([switch]$NoPrompt)

$ErrorActionPreference = "Continue"
$machine = $env:COMPUTERNAME
$stamp   = Get-Date -Format "yyyy-MM-dd_HH-mm"
$outDir  = Join-Path (Split-Path -Parent $PSScriptRoot) "Test_Results"
if (-not (Test-Path $outDir)) { $outDir = $PSScriptRoot }
$outFile = Join-Path $outDir ("SandyForAscii45-" + $machine + "-" + $stamp + ".txt")

function Out-Both {
    param([string]$Text)
    Write-Host $Text
    Add-Content -Path $outFile -Value $Text -Encoding UTF8
}
function Wait-Enter {
    param([string]$Prompt)
    if ($NoPrompt) { Out-Both "  (skipped -- NoPrompt)"; return "" }
    Write-Host ""
    return (Read-Host $Prompt)
}
function Get-KeySnapshot {
    # Every value directly under each key, plus one level of subkeys. Bounded.
    param([string[]]$Keys)
    $lines = New-Object System.Collections.Generic.List[string]
    foreach ($k in $Keys) {
        $targets = @($k)
        if (Test-Path $k) {
            $targets += (Get-ChildItem -Path $k -EA SilentlyContinue | Select-Object -First 40 | ForEach-Object { $_.PSPath })
        } else { $lines.Add("$k = <key absent>") }
        foreach ($t in $targets) {
            try {
                $item = Get-ItemProperty -Path $t -EA Stop
                foreach ($p in $item.PSObject.Properties) {
                    if ($p.Name -like 'PS*') { continue }
                    $lines.Add(("{0} :: {1} = {2}" -f ($t -replace '^Microsoft\.PowerShell\.Core\\Registry::',''), $p.Name, $p.Value))
                }
            } catch { $lines.Add("$t = <read refused: $($_.Exception.GetType().Name)>") }
        }
    }
    return $lines
}

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
Out-Both "=============================================================="
Out-Both " SANDY MEASUREMENTS FOR ascii45 -- read-only"
Out-Both " Machine: $machine   Run: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')   Elevated: $isAdmin"
Out-Both "=============================================================="
if (-not $isAdmin) { Out-Both "  NOTE: not elevated -- steps 2 and 4b will be refused. Close, right-click the .bat, Run as administrator." }

# ---- 1. FT-283: why was the Widgets policy write refused? -------------------
Out-Both ""; Out-Both "-- 1. FT-283  Widgets policy key: exists, owner, who may write it --"
foreach ($k in 'HKLM:\SOFTWARE\Policies\Microsoft\Dsh','HKLM:\SOFTWARE\Policies\Microsoft') {
    Out-Both "  $k  exists: $(Test-Path $k)"
    if (Test-Path $k) {
        try {
            $acl = Get-Acl -Path $k -EA Stop
            Out-Both "    owner: $($acl.Owner)"
            foreach ($r in $acl.Access) { Out-Both ("    {0,-40} {1,-6} {2} (inherited: {3})" -f $r.IdentityReference, $r.AccessControlType, $r.RegistryRights, $r.IsInherited) }
        } catch { Out-Both "    ACL read refused: $($_.Exception.Message)" }
    }
}
if (Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Dsh') {
    try { (Get-ItemProperty 'HKLM:\SOFTWARE\Policies\Microsoft\Dsh' -EA Stop).PSObject.Properties | Where-Object { $_.Name -notlike 'PS*' } | ForEach-Object { Out-Both "    value: $($_.Name) = $($_.Value)" } } catch { Out-Both "    values: read refused" }
}

# ---- 2. Note 29: what state is encryption really in? ------------------------
Out-Both ""; Out-Both "-- 2. Note 29  Encryption state of C: --"
$mb = & manage-bde.exe -status C: 2>&1
$mb | ForEach-Object { Out-Both "    $_" }
try {
    $bv = Get-BitLockerVolume -MountPoint C: -EA Stop
    Out-Both ("    Get-BitLockerVolume: VolumeStatus={0} ProtectionStatus={1} EncryptionPercentage={2} Method={3}" -f $bv.VolumeStatus,$bv.ProtectionStatus,$bv.EncryptionPercentage,$bv.EncryptionMethod)
} catch { Out-Both "    Get-BitLockerVolume: not available or refused -- $($_.Exception.Message)" }
Out-Both "    ALSO: take a screenshot of Settings > Privacy & security > Device encryption."

# ---- 5. FT-268: can password-on-wake be read with /qh on SANDY? -------------
Out-Both ""; Out-Both "-- 5. FT-268  Password on wake: /query (what ascii44 uses) vs /qh (the fix) --"
Out-Both "    [powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK]"
& powercfg.exe /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>&1 | ForEach-Object { Out-Both "      $_" }
Out-Both "    [powercfg /qh SCHEME_CURRENT SUB_NONE CONSOLELOCK]"
& powercfg.exe /qh SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>&1 | ForEach-Object { Out-Both "      $_" }

# ---- 4b. FT-277: did the 09-19 offline scan record anything? ----------------
Out-Both ""; Out-Both "-- 4b. FT-277  Defender log, 2026-09-19 12:15 to 12:45 (at most 50 events) --"
try {
    $ev = Get-WinEvent -FilterHashtable @{ LogName='Microsoft-Windows-Windows Defender/Operational'; StartTime=[datetime]'2026-09-19 12:15'; EndTime=[datetime]'2026-09-19 12:45' } -MaxEvents 50 -EA Stop
    foreach ($e in ($ev | Sort-Object TimeCreated)) { Out-Both ("    {0}  id={1}  {2}" -f $e.TimeCreated.ToString('HH:mm:ss'), $e.Id, (($e.Message -split "`n")[0]).Trim()) }
} catch { Out-Both "    no events in that window, or read refused -- $($_.Exception.Message)" }
Out-Both "    Latest scan times Defender itself reports:"
try {
    $mp = Get-MpComputerStatus -EA Stop
    Out-Both ("    FullScanStartTime={0}  FullScanEndTime={1}  QuickScanEndTime={2}" -f $mp.FullScanStartTime,$mp.FullScanEndTime,$mp.QuickScanEndTime)
} catch { Out-Both "    Get-MpComputerStatus refused -- $($_.Exception.Message)" }

# ---- 4a. FT-277: which page does the Protection history link open? ----------
Out-Both ""; Out-Both "-- 4a. FT-277  The link Checkup uses for Protection history --"
if ($NoPrompt) { Out-Both "  (skipped -- NoPrompt)" } else {
    Write-Host ""
    Write-Host "  The script will now open Windows Security using the same link Checkup uses."
    Write-Host "  Look at the page title that opens, then come back to this window."
    [void](Read-Host "  Press Enter to open it")
    Start-Process "windowsdefender://protectionhistory"
    $page = Read-Host "  Type the title of the page that opened (for example: Protection history)"
    Out-Both "    Page that opened, as Bill read it: $page"
}

# ---- 6. FT-282: where does Windows keep the Diagnostic Data choice? ---------
Out-Both ""; Out-Both "-- 6. FT-282  Diagnostic data flip test --"
$diagKeys = @(
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection',
    'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection',
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack',
    'HKCU:\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack',
    'HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy'
)
$before = Get-KeySnapshot -Keys $diagKeys
Out-Both "    BEFORE: $($before.Count) values read"
foreach ($l in $before) { if ($l -match 'AllowTelemetry|ShowedToastAtLevel|MaxTelemetry') { Out-Both "      $l" } }
if ($NoPrompt) { Out-Both "  (flip skipped -- NoPrompt)" } else {
    Write-Host ""
    Write-Host "  Open Settings > Privacy & security > Diagnostics & feedback."
    Write-Host "  Turn 'Send optional diagnostic data' to the OPPOSITE of what it is now."
    $was = Read-Host "  Before you change it: was it On or Off? (type On or Off, then Enter)"
    Out-Both "    Bill: it was $was before the flip"
    [void](Read-Host "  Now flip it. Then press Enter here")
    $after = Get-KeySnapshot -Keys $diagKeys
    $changed = Compare-Object -ReferenceObject $before -DifferenceObject $after
    if (-not $changed) { Out-Both "    AFTER: nothing changed in these keys -- the choice is stored somewhere else" }
    else { Out-Both "    AFTER: what changed ('<=' before, '=>' after):"; foreach ($c in $changed) { Out-Both ("      {0} {1}" -f $c.SideIndicator, $c.InputObject) } }
    [void](Read-Host "  Now flip it BACK to how it was ($was). Then press Enter here")
    $back = Get-KeySnapshot -Keys $diagKeys
    $still = Compare-Object -ReferenceObject $before -DifferenceObject $back
    if (-not $still) { Out-Both "    RESTORED: the keys match the BEFORE reading again" } else { Out-Both "    NOTE: after flipping back, $($still.Count) line(s) still differ from BEFORE" }
}

# ---- 3. FT-270: Ctrl+C -- done by hand, inside Checkup ----------------------
Out-Both ""; Out-Both "-- 3. FT-270  Ctrl+C -- do this by hand after the script finishes --"
Out-Both "    a) Start Checkup. At the first Y/N question, press Ctrl+C once."
Out-Both "       Did Checkup ask you to confirm, or did it just end?  ____________"
Out-Both "    b) Start Checkup again. Press Alt+Space, then look at the Edit menu:"
Out-Both "       which letter is underlined in 'Mark'?  ____"
Out-Both "       Select some text with Mark, then press Ctrl+C.  What happened?  ____________"
Out-Both "    Write your answers in this file, or tell Claude Code."

Out-Both ""; Out-Both "Saved to: $outFile"
