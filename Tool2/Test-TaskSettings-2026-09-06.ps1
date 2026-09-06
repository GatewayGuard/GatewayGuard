# Dated: 2026-09-06 12:30 ET
# File: Tool2\Test-TaskSettings-2026-09-06.ps1
#
# FT-203. Proves the settings adjustment before it is written into the build.
# Creates a THROWAWAY task with the same shape the build uses, reads the
# defaults, applies the three changes, reads them back, then deletes the task
# and verifies the deletion.
#
# WRITES: one scheduled task named GG-THROWAWAY-FT203, deleted before exit.
# Touches no GatewayGuard task and no setting on this PC.
# NEEDS ADMINISTRATOR to create a task.

$ErrorActionPreference = "Stop"
$name = "GG-THROWAWAY-FT203"
$out  = Join-Path $PSScriptRoot ("..\Test_Results\TaskSettings-" + $env:COMPUTERNAME + "-" + (Get-Date -Format "yyyy-MM-dd_HH-mm") + ".txt")
$lines = New-Object System.Collections.ArrayList
function W([string]$t) { [void]$lines.Add($t); Write-Host $t }

W "FT-203 -- scheduled task settings, measured on $env:COMPUTERNAME at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
W ""

# -- 0. is it already there from a failed run? --------------------------------
$pre = Get-ScheduledTask -TaskName $name -EA SilentlyContinue
if ($pre) { W "  found a leftover $name -- deleting first"; Unregister-ScheduledTask -TaskName $name -Confirm:$false }

try {
    # -- 1. the parameter names actually available --------------------------
    W "-- 1. New-ScheduledTaskSettingsSet parameters that exist on this PS --"
    $p = (Get-Command New-ScheduledTaskSettingsSet).Parameters.Keys | Sort-Object
    foreach ($want in @("StartWhenAvailable","AllowStartIfOnBatteries","DontStopIfGoingOnBatteries","WakeToRun")) {
        W ("     {0,-30} {1}" -f $want, $(if ($p -contains $want) { "EXISTS" } else { "*** ABSENT ***" }))
    }
    W ""

    # -- 2. create the throwaway with the build's own command shape ---------
    W "-- 2. create via schtasks.exe, same shape as the build --"
    $tr = 'powershell.exe -WindowStyle Hidden -Command "exit"'
    $r  = & schtasks.exe /create /f /tn $name /tr $tr /sc monthly /d 1 /st 10:00 2>&1
    W ("     schtasks exit $LASTEXITCODE -- " + ($r -join " "))
    W ""

    # -- 3. the defaults schtasks leaves behind -----------------------------
    $t = Get-ScheduledTask -TaskName $name
    W "-- 3. DEFAULTS as created --"
    foreach ($k in @("StartWhenAvailable","DisallowStartIfOnBatteries","StopIfGoingOnBatteries","WakeToRun")) {
        W ("     {0,-30} {1}" -f $k, $t.Settings.$k)
    }
    W ""

    # -- 4. mutate only the three, leave every other setting alone ----------
    W "-- 4. apply: mutate the three properties on the EXISTING settings object --"
    W "     (not New-ScheduledTaskSettingsSet, which would reset every other setting)"
    $s = $t.Settings
    $s.StartWhenAvailable         = $true
    $s.DisallowStartIfOnBatteries = $false
    $s.StopIfGoingOnBatteries     = $false
    # WakeToRun deliberately untouched -- product decision, stays False
    Set-ScheduledTask -TaskName $name -Settings $s | Out-Null
    W "     Set-ScheduledTask returned without error"
    W ""

    # -- 5. READ BACK. log what was read, not what was intended -------------
    W "-- 5. READ BACK from the task store --"
    $t2 = Get-ScheduledTask -TaskName $name
    $expect = @{ StartWhenAvailable = $true; DisallowStartIfOnBatteries = $false
                 StopIfGoingOnBatteries = $false; WakeToRun = $false }
    $allOk = $true
    foreach ($k in @("StartWhenAvailable","DisallowStartIfOnBatteries","StopIfGoingOnBatteries","WakeToRun")) {
        $got = $t2.Settings.$k
        $ok  = ($got -eq $expect[$k])
        if (-not $ok) { $allOk = $false }
        W ("     {0,-30} {1,-6} expected {2,-6} {3}" -f $k, $got, $expect[$k], $(if ($ok) { "OK" } else { "*** MISMATCH ***" }))
    }
    W ""
    W ("  RESULT: " + $(if ($allOk) { "the approach works -- safe to write into the build" } else { "DOES NOT WORK -- do not write this into the build" }))
}
finally {
    # -- 6. delete, and verify the deletion ---------------------------------
    W ""
    W "-- 6. cleanup --"
    Unregister-ScheduledTask -TaskName $name -Confirm:$false -EA SilentlyContinue
    $gone = -not (Get-ScheduledTask -TaskName $name -EA SilentlyContinue)
    W ("     $name removed: " + $gone)
    $dir = Split-Path $out -Parent
    if (-not (Test-Path $dir)) { New-Item -Path $dir -ItemType Directory -Force | Out-Null }
    $lines | Out-File -FilePath $out -Encoding utf8
    Write-Host ""
    Write-Host "  Saved to: $out"
}
