# Measure-EffectiveState-2026-09-16.ps1
# Dated: 2026-09-16 12:09 ET
# Editor: Claude Cloud
# Purpose: settle FT-123b items 13 (Edge Startup Boost) and 14 (Widgets) by
#          MEASUREMENT instead of a key name nobody has seen hold a value, and
#          print three candidate signals for item 9 (Windows Hello).
# READ-ONLY. Writes nothing to the registry, nothing to Edge, nothing outside
#          Test_Results\. Does not elevate. Not a build change.
# How it works: snapshot, Bill toggles the setting in the product's own UI,
#          snapshot again, print what changed. Whatever moved is the key.
# Run from: Tool2\ via Run-MeasureEffectiveState.bat. Not run by Cloud.
# Claude Code: check against GatewayGuard_CodingStandards-2026-08-07-1330.md
#          before Bill runs it. Cloud cannot.

$ErrorActionPreference = "Continue"
$machine = $env:COMPUTERNAME
$stamp   = Get-Date -Format "yyyy-MM-dd_HH-mm"
$outDir  = Join-Path (Split-Path -Parent $PSScriptRoot) "Test_Results"
if (-not (Test-Path $outDir)) { $outDir = $PSScriptRoot }
$outFile = Join-Path $outDir ("EffectiveState-" + $machine + "-" + $stamp + ".txt")

function Out-Both {
    param([string]$Text)
    Write-Host $Text
    Add-Content -Path $outFile -Value $Text -Encoding UTF8
}

function Get-FlatJson {
    # Flattens a parsed JSON object into "path = value" lines so two snapshots
    # can be diffed without knowing any key name in advance.
    param($Obj, [string]$Prefix = "")
    $lines = New-Object System.Collections.Generic.List[string]
    if ($null -eq $Obj) { $lines.Add($Prefix + " = <null>"); return $lines }
    if ($Obj -is [System.Management.Automation.PSCustomObject]) {
        foreach ($p in $Obj.PSObject.Properties) {
            $child = if ($Prefix) { $Prefix + "." + $p.Name } else { $p.Name }
            foreach ($l in (Get-FlatJson -Obj $p.Value -Prefix $child)) { $lines.Add($l) }
        }
    } elseif ($Obj -is [System.Array]) {
        $i = 0
        foreach ($item in $Obj) {
            foreach ($l in (Get-FlatJson -Obj $item -Prefix ($Prefix + "[" + $i + "]"))) { $lines.Add($l) }
            $i++
        }
        if ($i -eq 0) { $lines.Add($Prefix + " = <empty array>") }
    } else {
        $lines.Add($Prefix + " = " + [string]$Obj)
    }
    return $lines
}

function Get-EdgePrefSnapshots {
    # Returns a hashtable: profile folder name -> flattened lines.
    $root = Join-Path $env:LOCALAPPDATA "Microsoft\Edge\User Data"
    $result = @{}
    if (-not (Test-Path $root)) { return $result }
    $profiles = Get-ChildItem -Path $root -Directory | Where-Object {
        $_.Name -eq "Default" -or $_.Name -like "Profile *"
    }
    foreach ($p in $profiles) {
        $pref = Join-Path $p.FullName "Preferences"
        if (Test-Path $pref) {
            try {
                $json = Get-Content -Path $pref -Raw -Encoding UTF8 | ConvertFrom-Json
                $result[$p.Name] = Get-FlatJson -Obj $json
            } catch {
                $result[$p.Name] = @("<could not parse: " + $_.Exception.Message + ">")
            }
        }
    }
    return $result
}

function Show-Diff {
    param([string[]]$Before, [string[]]$After, [string]$Label)
    $removed = Compare-Object -ReferenceObject $Before -DifferenceObject $After |
        Where-Object { $_.SideIndicator -eq "<=" } | ForEach-Object { $_.InputObject }
    $added   = Compare-Object -ReferenceObject $Before -DifferenceObject $After |
        Where-Object { $_.SideIndicator -eq "=>" } | ForEach-Object { $_.InputObject }
    Out-Both ("  [" + $Label + "] lines before: " + $Before.Count + "  after: " + $After.Count)
    if (-not $removed -and -not $added) { Out-Both "  [$Label] NO CHANGE"; return }
    foreach ($r in $removed) { Out-Both ("  [" + $Label + "] WAS  : " + $r) }
    foreach ($a in $added)   { Out-Both ("  [" + $Label + "] NOW  : " + $a) }
}

function Wait-Enter {
    param([string]$Prompt)
    Write-Host ""
    Write-Host $Prompt -ForegroundColor Yellow
    Write-Host "  Press Enter to continue. Press Ctrl+C to stop the script (nothing is written to Windows either way)." -ForegroundColor Gray
    [void](Read-Host)
}

# ------------------------------------------------------------------
Out-Both "EffectiveState measurement -- $machine -- $stamp"
Out-Both "Read-only. Output: $outFile"
Out-Both ""

# ---------------- PART 1: EDGE STARTUP BOOST (item 13) -------------
Out-Both "PART 1 -- ITEM 13, EDGE STARTUP BOOST: diff Preferences across one toggle"
Out-Both "  Policy key (what Checkup writes):"
$pol = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
try {
    $v = Get-ItemProperty -Path $pol -ErrorAction Stop
    Out-Both ("    StartupBoostEnabled = " + $(if ($null -ne $v.StartupBoostEnabled) { $v.StartupBoostEnabled } else { "<absent>" }))
    Out-Both ("    BackgroundModeEnabled = " + $(if ($null -ne $v.BackgroundModeEnabled) { $v.BackgroundModeEnabled } else { "<absent>" }))
} catch { Out-Both "    <policy key absent or unreadable: $($_.Exception.Message)>" }

Wait-Enter "  Close Microsoft Edge COMPLETELY (all windows) so its Preferences file is settled. Then press Enter for the BEFORE snapshot."
$before = Get-EdgePrefSnapshots
if ($before.Count -eq 0) { Out-Both "  No Edge profile Preferences files found. Skipping Part 1." }
else {
    Out-Both ("  Profiles snapshotted: " + ($before.Keys -join ", "))
    Out-Both "  Lines already mentioning boost/background/credentials (before):"
    foreach ($k in $before.Keys) {
        $before[$k] | Where-Object { $_ -match "boost|background|credentials_enable" } | ForEach-Object { Out-Both ("    [" + $k + "] " + $_) }
    }
    Wait-Enter "  Open Edge -> edge://settings/system -> flip STARTUP BOOST to the opposite state -> close Edge COMPLETELY -> wait 5 seconds -> press Enter."
    $after = Get-EdgePrefSnapshots
    foreach ($k in $before.Keys) {
        if ($after.ContainsKey($k)) { Show-Diff -Before $before[$k] -After $after[$k] -Label $k }
        else { Out-Both "  [$k] profile missing after toggle" }
    }
    Wait-Enter "  Flip STARTUP BOOST BACK to where it was, close Edge completely, then press Enter. (Restores your setting; nothing else changes.)"
    $restored = Get-EdgePrefSnapshots
    foreach ($k in $before.Keys) {
        if ($restored.ContainsKey($k)) { Show-Diff -Before $before[$k] -After $restored[$k] -Label ($k + " restored-vs-before") }
    }
}
Out-Both ""

# ---------------- PART 2: WIDGETS (item 14) ------------------------
Out-Both "PART 2 -- ITEM 14, WIDGETS: re-read TaskbarDa across one toggle"
$adv = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$dsh = "HKLM:\SOFTWARE\Policies\Microsoft\Dsh"
function Read-TaskbarDa {
    try { $x = Get-ItemProperty -Path $adv -Name TaskbarDa -ErrorAction Stop; return [string]$x.TaskbarDa }
    catch { return "<absent>" }
}
try { $d = Get-ItemProperty -Path $dsh -ErrorAction Stop; Out-Both ("  Policy AllowNewsAndInterests = " + $(if ($null -ne $d.AllowNewsAndInterests) { $d.AllowNewsAndInterests } else { "<absent>" })) }
catch { Out-Both "  Policy key Dsh absent or unreadable" }
$da1 = Read-TaskbarDa
Out-Both "  TaskbarDa BEFORE = $da1"
Wait-Enter "  Right-click the taskbar -> Taskbar settings -> flip WIDGETS to the opposite state -> press Enter."
$da2 = Read-TaskbarDa
Out-Both "  TaskbarDa AFTER  = $da2"
Out-Both ("  Result: " + $(if ($da1 -ne $da2) { "FLIPPED -- TaskbarDa tracks the toggle on this machine" } else { "DID NOT CHANGE -- TaskbarDa does NOT track the toggle here; do not build on it" }))
Wait-Enter "  Flip WIDGETS BACK to where it was, then press Enter."
$da3 = Read-TaskbarDa
Out-Both "  TaskbarDa RESTORED = $da3  (expected to equal BEFORE: $da1)"
Out-Both ""

# ---------------- PART 3: WINDOWS HELLO (item 9) -------------------
Out-Both "PART 3 -- ITEM 9, WINDOWS HELLO: three candidate signals, none yet proven to flip"
$ngc = Join-Path $env:LOCALAPPDATA "Microsoft\NGC"
Out-Both ("  A. NGC folder exists (current check): " + (Test-Path $ngc))
if (Test-Path $ngc) {
    try {
        $subs = Get-ChildItem -Path $ngc -Directory -ErrorAction Stop
        Out-Both ("     NGC subfolders: " + $subs.Count + "  (inferred: enrollment creates one; empty folder = leftover)")
    } catch { Out-Both ("     NGC subfolders: <unreadable: " + $_.Exception.Message + ">") }
}
Out-Both "  B. certutil Passport KSP key listing (documented switch; whether it lists a Hello PIN key is what this run finds out):"
try {
    $ct = & certutil -csp "Microsoft Passport Key Storage Provider" -key 2>&1
    foreach ($line in $ct) { Out-Both ("     " + $line) }
} catch { Out-Both ("     <certutil failed: " + $_.Exception.Message + ">") }
Out-Both "  C. Sign-in options registry area (read-only, values printed as found):"
$so = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI"
try {
    $v = Get-ItemProperty -Path $so -ErrorAction Stop
    foreach ($p in $v.PSObject.Properties) {
        if ($p.Name -notlike "PS*") { Out-Both ("     " + $p.Name + " = " + $p.Value) }
    }
} catch { Out-Both "     <LogonUI key absent or unreadable>" }
Out-Both ""
Out-Both "  To make A/B/C mean anything: run this Part on an account WITH a PIN and one WITHOUT, and see which signal differs."
Out-Both ""
Out-Both "DONE. Nothing was changed by this script. Send $outFile to Claude Code."
Write-Host ""
Write-Host "Press Enter to close." -ForegroundColor Gray
[void](Read-Host)
