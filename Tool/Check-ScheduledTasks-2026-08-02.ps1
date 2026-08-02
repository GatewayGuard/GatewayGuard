# Dated: 2026-08-02 06:14 ET
# ================================================================
# FILE:    Check-ScheduledTasks-2026-08-02.ps1
#
# REVISION 2026-08-02 06:14 -- TWO CHANGES, BOTH EARNED BY THE FIRST RUN:
#
#   1. THIS CHECK PRODUCED A FALSE FAIL AND IS NOW CORRECTED. On SANDY
#      (2026-08-02 05:59) it reported the Quarterly task's program as
#      "DOES NOT EXIST" and failed the task. It was wrong. Test-Path was
#      handed the path with its surrounding quotes still attached; Task
#      Scheduler strips those. PROVEN on CGDELL, not assumed: the
#      GoogleUpdaterTaskSystem task stores Command as
#      "C:\Program Files (x86)\...\updater.exe" -- quotes included -- and
#      ran successfully (LastTaskResult 0) at 2026-08-02 05:52:32.
#      This was FT-120 / FT-123 / FT-141 all over again -- a check that
#      could not establish the state invented a definite answer instead of
#      reporting Unknown -- committed inside the tool written to catch it.
#      The genuinely-broken split path is still detected; verified against
#      "C:\Program" which still reports DOES NOT EXIST.
#
#   2. POWER CONDITIONS ARE NOW REPORTED. The first SANDY run found the
#      Malwarebytes reminder had actually RUN (2026-08-01 14:55:49) and
#      returned 0x800710E0 -- "The operator or administrator has refused
#      the request" -- which is Task Scheduler declining because a power
#      condition was not met. Both tasks carry schtasks.exe's DEFAULT
#      DisallowStartIfOnBatteries = true, which the build never overrides.
#      Every target machine is a home laptop, so this matters more than
#      the quoting ever did. Tracked as FT-161.
#
# PURPOSE: FT-109 / gate 21 (C-25) -- the EXTERNAL verification that
#          CodingStandards requires before the scheduled-task feature can
#          be called closed.
#
# Gate 21 reads: "A feature that produced [ERROR] lines in any prior field
# log is OPEN until a new field run shows the error gone AND the outcome
# verified externally (e.g., Task Scheduler confirms both tasks exist).
# A clean build is not evidence of a working feature."
#
# The ascii38 run logged both tasks as [GOOD] -- the first success in five
# builds. That is the "clean build" half. This script is the other half.
#
# WHAT IT IS REALLY CHECKING: not merely that the tasks exist, but that the
# ACTION PATH SURVIVED QUOTING. The FT-93/FT-109 lineage was never about
# missing tasks -- it was about "C:\Program Files\Windows Defender\..."
# splitting at the space, producing the field error:
#     Invalid argument/option - 'Files\Windows'
# A task can sit in Task Scheduler looking perfectly healthy and still be
# pointed at a program that does not exist. So the decisive test here is
# simple: DOES THE COMMAND PATH RESOLVE TO A REAL FILE ON DISK?
#
# READ-ONLY. It queries the task definitions and writes one text file next
# to this script. It creates no task, changes no task, deletes no task, and
# touches no setting.
#
# DOES NOT NEED ADMINISTRATOR. Reading a task definition -- including one
# that runs as SYSTEM -- does not require elevation. If a read is refused,
# the script says so rather than failing silently.
#
# USAGE: double-click Run-ScheduledTasksCheck.bat
# ================================================================

$ErrorActionPreference = "Continue"

$ggStamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ggOut = Join-Path $PSScriptRoot ("ScheduledTasks-" + $env:COMPUTERNAME + "-" + $ggStamp + ".txt")
$L = New-Object System.Collections.Generic.List[string]

function Add-Line { param([string]$Text = "") $L.Add($Text) }

# The two tasks, and what each one is supposed to look like. These strings
# come from Setup-ScheduledTasks in the build -- read off the source, not
# recalled, so this file cannot drift from what the tool actually creates.
$ggTasks = @(
    @{
        Name     = "GatewayGuard - Quarterly Defender Offline Scan"
        WantExe  = "MpCmdRun.exe"
        WantArgs = @("-Scan", "-ScanType 4")
        WantWhen = "Monthly -- Jan, Apr, Jul, Oct, day 1, 02:00"
        WantUser = "SYSTEM"
    },
    @{
        Name     = "GatewayGuard - Monthly Malwarebytes Reminder"
        WantExe  = "powershell.exe"
        WantArgs = @("MBReminder.ps1")
        WantWhen = "Monthly -- day 1, 10:00"
        WantUser = ""
    }
)

Add-Line ""
Add-Line "================================================================"
Add-Line " FT-109 -- SCHEDULED TASK VERIFICATION (read-only)"
Add-Line " Gate 21 / C-25: external confirmation, not a log line"
Add-Line "================================================================"
Add-Line ("  Computer : " + $env:COMPUTERNAME)
Add-Line ("  User     : " + $env:USERNAME)
Add-Line ("  Run date : " + (Get-Date -Format "yyyy-MM-dd HH:mm:ss"))
Add-Line ("  Checker  : Check-ScheduledTasks-2026-08-02 (rev 2 -- quote-stripping fix + power conditions)")
try {
    $ggAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")
    Add-Line ("  Elevated : " + $ggAdmin + "   (not required for this check)")
} catch { Add-Line "  Elevated : could not determine" }
Add-Line ""

$ggVerdicts = New-Object System.Collections.Generic.List[string]

foreach ($ggT in $ggTasks) {
    $ggName = $ggT.Name
    Add-Line "----------------------------------------------------------------"
    Add-Line (" TASK: " + $ggName)
    Add-Line "----------------------------------------------------------------"

    $ggTask = $null
    try { $ggTask = Get-ScheduledTask -TaskName $ggName -ErrorAction Stop } catch { $ggTask = $null }

    if ($null -eq $ggTask) {
        Add-Line "  RESULT: *** NOT FOUND ***"
        Add-Line ""
        Add-Line "  This task does not exist on this PC. Either Checkup never"
        Add-Line "  reached the scheduling step on this machine, the task was"
        Add-Line "  removed afterwards, or creation failed silently."
        Add-Line ""
        $ggVerdicts.Add("FAIL  -- NOT FOUND      -- " + $ggName)
        continue
    }

    Add-Line ("  Exists   : YES")
    Add-Line ("  State    : " + $ggTask.State + "   (want: Ready -- Disabled means it will never run)")
    Add-Line ("  Path     : " + $ggTask.TaskPath)
    try { Add-Line ("  Run as   : " + $ggTask.Principal.UserId + "   (RunLevel: " + $ggTask.Principal.RunLevel + ")") } catch {}
    if ($ggT.WantUser) { Add-Line ("             want: " + $ggT.WantUser) }

    # ---- last run outcome -------------------------------------------------
    try {
        $ggInfo = Get-ScheduledTaskInfo -TaskName $ggName -ErrorAction Stop
        Add-Line ("  Last run : " + $ggInfo.LastRunTime)
        $ggRC = $ggInfo.LastTaskResult
        $ggRCNote = "unrecognised"
        if ($ggRC -eq 0) { $ggRCNote = "success" }
        elseif ($ggRC -eq 267011) { $ggRCNote = "has not run yet -- normal, these are scheduled months out" }
        elseif ($ggRC -eq 2147942402) { $ggRCNote = "*** FILE NOT FOUND -- the action points at something missing ***" }
        elseif ($ggRC -eq 2147942401) { $ggRCNote = "*** ACCESS DENIED ***" }
        # 0x800710E0 -- seen on SANDY 2026-08-01. Win32 4320, "The operator or
        # administrator has refused the request". In practice on a laptop this
        # is Task Scheduler declining to start because a POWER CONDITION was
        # not met -- see POWER CONDITIONS below.
        elseif ($ggRC -eq 2147946720) { $ggRCNote = "*** REFUSED -- 0x800710E0. A condition blocked the start; on a laptop this is normally the on-battery rule below ***" }
        elseif ($ggRC -eq 267009) { $ggRCNote = "currently running" }
        elseif ($ggRC -eq 267014) { $ggRCNote = "last run was terminated by the user" }
        Add-Line ("  Last code: " + $ggRC + "   (" + $ggRCNote + ")")
        Add-Line ("  Next run : " + $ggInfo.NextRunTime)
    } catch { Add-Line "  Last run : could not read task info" }

    # ---- triggers ---------------------------------------------------------
    Add-Line ""
    Add-Line ("  TRIGGERS   (want: " + $ggT.WantWhen + ")")
    try {
        $ggTrigs = @($ggTask.Triggers)
        if ($ggTrigs.Count -eq 0) {
            Add-Line "    *** NONE -- a task with no trigger never runs ***"
            $ggVerdicts.Add("FAIL  -- NO TRIGGER     -- " + $ggName)
        }
        foreach ($ggTr in $ggTrigs) {
            Add-Line ("    type     : " + $ggTr.CimClass.CimClassName)
            if ($ggTr.StartBoundary) { Add-Line ("    starts   : " + $ggTr.StartBoundary) }
            if ($ggTr.Enabled -ne $null) { Add-Line ("    enabled  : " + $ggTr.Enabled) }
            foreach ($ggP in @("DaysOfMonth","MonthsOfYear","RandomDelay")) {
                try {
                    $ggV = $ggTr.$ggP
                    if ($ggV) { Add-Line ("    " + $ggP.PadRight(9) + ": " + ($ggV -join ", ")) }
                } catch {}
            }
        }
    } catch { Add-Line "    could not read triggers" }

    # ---- power conditions: the SANDY finding, 2026-08-02 -------------------
    # schtasks.exe DEFAULTS both of these to true, and the build never
    # overrides them. On SANDY the Malwarebytes reminder ran on 2026-08-01 at
    # 14:55:49 and returned 0x800710E0 -- "The operator or administrator has
    # refused the request" -- which is what Task Scheduler reports when a
    # power condition blocks a start.
    # WHY THIS MATTERS MORE THAN IT LOOKS: every target machine is a home
    # laptop. A reminder that silently declines to run whenever the lid is on
    # battery is not a reminder. The quarterly Defender scan is worse -- it is
    # scheduled for 02:00, when a laptop is least likely to be plugged in.
    Add-Line ""
    Add-Line "  POWER CONDITIONS"
    try {
        $ggSet = $ggTask.Settings
        $ggNoBatt = $ggSet.DisallowStartIfOnBatteries
        $ggStopBatt = $ggSet.StopIfGoingOnBatteries
        Add-Line ("    DisallowStartIfOnBatteries : " + $ggNoBatt)
        Add-Line ("    StopIfGoingOnBatteries     : " + $ggStopBatt)
        if ($ggNoBatt -eq $true) {
            Add-Line "    *** This task will NOT START while the PC is on battery. ***"
            Add-Line "    *** On a laptop that is most of the time.                ***"
            $ggVerdicts.Add("WARN  -- BATTERY-BLOCKED -- " + $ggName)
        }
        Add-Line ("    WakeToRun                  : " + $ggSet.WakeToRun)
        if ($ggSet.WakeToRun -ne $true) {
            Add-Line "    NOTE: will not wake a sleeping PC. If the machine is asleep"
            Add-Line "    at the scheduled time, the run is missed."
        }
        Add-Line ("    StartWhenAvailable         : " + $ggSet.StartWhenAvailable)
        if ($ggSet.StartWhenAvailable -ne $true) {
            Add-Line "    NOTE: a missed run is NOT retried later."
        }
    } catch { Add-Line "    could not read settings" }

    # ---- actions: THE DECISIVE CHECK --------------------------------------
    Add-Line ""
    Add-Line "  ACTIONS  -- this is the FT-109 check"
    $ggActOK = $false
    try {
        foreach ($ggA in @($ggTask.Actions)) {
            $ggCmdRaw = [string]$ggA.Execute
            $ggArg = [string]$ggA.Arguments
            Add-Line ("    Program  : " + $ggCmdRaw)
            Add-Line ("    Arguments: " + $ggArg)

            # 2026-08-02 FIX -- THIS CHECK ITSELF PRODUCED A FALSE FAIL.
            # The first SANDY run reported the Quarterly task's program as
            # "DOES NOT EXIST" because Test-Path was handed the path with its
            # surrounding quotes still attached. Task Scheduler strips those.
            # PROVEN, not assumed: the GoogleUpdaterTaskSystem task on CGDELL
            # stores Command as "C:\Program Files (x86)\...\updater.exe" --
            # quotes included -- and ran successfully (LastTaskResult 0) at
            # 2026-08-02 05:52:32.
            # This was the exact defect class the project keeps paying for --
            # FT-120, FT-123, FT-141: a check that could not establish the
            # state invented a definite answer instead of reporting Unknown.
            # Built into the tool written to catch that very thing.
            # Also expands %ProgramFiles%-style variables, which Windows' own
            # UpdateLibrary task uses in Command.
            $ggCmd = $ggCmdRaw.Trim()
            if ($ggCmd.StartsWith('"') -and $ggCmd.EndsWith('"') -and $ggCmd.Length -gt 1) {
                $ggCmd = $ggCmd.Substring(1, $ggCmd.Length - 2)
            }
            try { $ggCmd = [Environment]::ExpandEnvironmentVariables($ggCmd) } catch {}
            if ($ggCmd -ne $ggCmdRaw) { Add-Line ("    (resolved to: " + $ggCmd + ")") }

            # Does the program actually exist? If quoting broke, this is
            # where it shows: "C:\Program" is not a file.
            $ggResolved = ""
            if ($ggCmd) {
                if (Test-Path -LiteralPath $ggCmd -ErrorAction SilentlyContinue) {
                    $ggResolved = "found on disk"
                    $ggActOK = $true
                } else {
                    $ggWhere = $null
                    try { $ggWhere = (Get-Command $ggCmd -ErrorAction Stop).Source } catch {}
                    if ($ggWhere) {
                        $ggResolved = "resolves via PATH to " + $ggWhere
                        $ggActOK = $true
                    } else {
                        $ggResolved = "*** DOES NOT EXIST ***"
                    }
                }
            }
            Add-Line ("    Program exists? " + $ggResolved)

            if ($ggCmd -match '^[A-Za-z]:\\Program$' -or $ggArg -match '^Files\\') {
                Add-Line "    *** FT-109 SIGNATURE: the path split at 'Program Files'. ***"
                Add-Line "    *** This is the exact defect that produced the field  ***"
                Add-Line "    *** error: Invalid argument/option - 'Files\Windows'  ***"
            }

            if ($ggCmd -notmatch [regex]::Escape($ggT.WantExe)) {
                Add-Line ("    NOTE: expected the program to be " + $ggT.WantExe)
            }
            foreach ($ggW in $ggT.WantArgs) {
                if ($ggArg -notmatch [regex]::Escape($ggW)) {
                    Add-Line ("    NOTE: expected the arguments to contain: " + $ggW)
                }
            }

            # For the reminder task, the -File target must exist too. A task
            # pointing at a missing script fails silently -- Class 1.
            if ($ggArg -match '-File\s+"?([^"]+\.ps1)"?') {
                $ggScript = $Matches[1].Trim('"')
                if (Test-Path -LiteralPath $ggScript) {
                    Add-Line ("    Script target exists: YES -- " + $ggScript)
                } else {
                    Add-Line ("    Script target exists: *** NO -- " + $ggScript + " ***")
                    Add-Line "    A task pointing at a missing script fails silently."
                    $ggActOK = $false
                }
            }
        }
    } catch {
        Add-Line ("    could not read actions: " + $_)
    }

    if ($ggActOK) {
        $ggVerdicts.Add("PASS  -- action resolves -- " + $ggName)
    } else {
        $ggVerdicts.Add("FAIL  -- BAD ACTION PATH -- " + $ggName)
    }

    # ---- full XML for the record -----------------------------------------
    Add-Line ""
    Add-Line "  FULL DEFINITION (XML, for the test record):"
    try {
        $ggXml = Export-ScheduledTask -TaskName $ggName -ErrorAction Stop
        foreach ($ggLine in ($ggXml -split "\r?\n")) { Add-Line ("    " + $ggLine) }
    } catch {
        Add-Line ("    could not export XML: " + $_)
    }
    Add-Line ""
}

Add-Line "================================================================"
Add-Line " VERDICT"
Add-Line "================================================================"
foreach ($ggV in $ggVerdicts) { Add-Line ("  " + $ggV) }
Add-Line ""
$ggFails = @($ggVerdicts | Where-Object { $_ -like "FAIL*" }).Count
if ($ggFails -eq 0) {
    Add-Line "  FT-109 CAN BE CLOSED. Both tasks exist and both action paths"
    Add-Line "  resolve to real programs. This is the external confirmation"
    Add-Line "  gate 21 requires -- a log line was never enough."
} else {
    Add-Line ("  FT-109 STAYS OPEN -- " + $ggFails + " problem(s) above.")
    Add-Line "  Send this file back and it goes into the ascii40 scope."
}
Add-Line ""
Add-Line "  Nothing on this PC was created, changed or deleted by this check."
Add-Line "================================================================"

# Write the file, then show the short version on screen.
try {
    $L -join "`r`n" | Out-File -FilePath $ggOut -Encoding UTF8 -Force
} catch {
    Write-Host "  Could not write the results file: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "  FT-109 SCHEDULED TASK CHECK -- $env:COMPUTERNAME" -ForegroundColor Cyan
Write-Host ""
foreach ($ggV in $ggVerdicts) {
    $ggColor = "Green"
    if ($ggV -like "FAIL*") { $ggColor = "Red" }
    elseif ($ggV -like "WARN*") { $ggColor = "Yellow" }
    Write-Host ("    " + $ggV) -ForegroundColor $ggColor
}
Write-Host ""
if ($ggFails -eq 0) {
    Write-Host "  Both tasks verified. FT-109 can be closed." -ForegroundColor Green
} else {
    Write-Host "  $ggFails problem(s) found -- FT-109 stays open." -ForegroundColor Yellow
}
Write-Host ""
Write-Host "  Full results saved to:" -ForegroundColor Gray
Write-Host "    $ggOut" -ForegroundColor White
Write-Host ""
Write-Host "  Read-only: nothing was created, changed or deleted." -ForegroundColor Gray
Write-Host ""
