"""build_ascii44_ft203 -- the two reminders never ran on a laptop on battery.

FT-203. schtasks.exe creates a task and leaves four settings at defaults it
has no switch to change:

    StartWhenAvailable          False   missed start is never shown later
    DisallowStartIfOnBatteries  True    on battery it does not run at all
    StopIfGoingOnBatteries      True    unplug mid-popup and it is killed
    WakeToRun                   False

So a senior with a laptop, unplugged at ten in the morning, gets no reminder
-- and because StartWhenAvailable is False it is not shown when they plug in
either. The quarter simply passes. The log says "[GOOD] Scheduled task
created", which is TRUE: the task exists. It just never fires.

MEASURED, CGDELL 2026-09-06, Tool2\\Test-TaskSettings-2026-09-06.ps1, output in
Test_Results\\TaskSettings-CGDELL-2026-09-06_12-20.txt -- a throwaway task
created with the build's own command shape returned exactly those four
defaults, the three changes applied, the read-back confirmed all four, and the
task was deleted and the deletion verified.

WHY NOT New-ScheduledTaskSettingsSet
------------------------------------
The FT-203 write-up recommended Set-ScheduledTask -Settings
(New-ScheduledTaskSettingsSet ...). That builds a FRESH settings object, so
every setting not named in the call is reset to its cmdlet default -- silently
changing ExecutionTimeLimit, MultipleInstances and the rest. This mutates the
three properties on the task's EXISTING settings object instead, which touches
nothing else. Both were available; this one has the smaller blast radius.

It also does not reintroduce C-14. That defect was $false passed POSITIONALLY
to a switch parameter. There are no switch parameters here at all -- these are
property assignments on a CIM object.

WakeToRun STAYS FALSE, and that is a product call, not a technical one.
Waking a senior's laptop out of hibernate to throw up a message box is the
behaviour people uninstall software over. With StartWhenAvailable on, the
reminder appears the next time they turn the PC on -- the same thing Windows
Update does.

THE LOG RECORDS WHAT WAS READ BACK, NOT WHAT WAS INTENDED. That is the FT-162
lesson and the whole reason this defect survived: a task that cannot fire was
reported as created, and nothing ever looked again.

Run from Tool2/:  python build_ascii44_ft203.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

HELPER = r'''
function Set-GGTaskSettings {
    # FT-203 (ascii44): schtasks.exe has no switch for a missed start, for
    # waking, or for battery -- the complete /create switch list has none of
    # them, so every task it makes is off by default on a laptop. This runs
    # AFTER the task exists and adjusts the three that matter.
    #
    # VERIFIED 2026-09-06 measured on CGDELL (Tool2\Test-TaskSettings-2026-09-06.ps1):
    #   as created  StartWhenAvailable False / DisallowStartIfOnBatteries True /
    #               StopIfGoingOnBatteries True / WakeToRun False
    #   after this  True / False / False / False, confirmed by read-back.
    #
    # Mutates the EXISTING settings object rather than building a new one with
    # New-ScheduledTaskSettingsSet, which would reset every setting not named.
    #
    # WakeToRun is deliberately left False. Product decision: waking a sleeping
    # laptop to show a message box is what people uninstall software over.
    #
    # Returns a hashtable: Ok, and the four values AS READ BACK.
    param([string]$TaskName)

    $out = @{ Ok = $false; StartWhenAvailable = $null; DisallowStartIfOnBatteries = $null
              StopIfGoingOnBatteries = $null; WakeToRun = $null; Error = "" }
    try {
        $ggTask = Get-ScheduledTask -TaskName $TaskName -EA Stop
        $ggSet  = $ggTask.Settings
        $ggSet.StartWhenAvailable         = $true
        $ggSet.DisallowStartIfOnBatteries = $false
        $ggSet.StopIfGoingOnBatteries     = $false
        Set-ScheduledTask -TaskName $TaskName -Settings $ggSet -EA Stop | Out-Null

        # READ BACK. Report what the task store says, never what was intended.
        $ggAfter = (Get-ScheduledTask -TaskName $TaskName -EA Stop).Settings
        $out.StartWhenAvailable         = $ggAfter.StartWhenAvailable
        $out.DisallowStartIfOnBatteries = $ggAfter.DisallowStartIfOnBatteries
        $out.StopIfGoingOnBatteries     = $ggAfter.StopIfGoingOnBatteries
        $out.WakeToRun                  = $ggAfter.WakeToRun
        $out.Ok = ($ggAfter.StartWhenAvailable -eq $true -and
                   $ggAfter.DisallowStartIfOnBatteries -eq $false -and
                   $ggAfter.StopIfGoingOnBatteries -eq $false)
    } catch {
        $out.Error = "$_"
    }
    return $out
}

'''

# Applied after each successful create. Same text both times except the label.
def adjust(label):
    return (
        '\n'
        '        # FT-203 (ascii44): the task exists, but schtasks left it unable to\n'
        '        # run on battery and unable to catch up a missed start. Fix the three\n'
        '        # settings, then LOG WHAT WAS READ BACK.\n'
        '        $ggSet' + label + ' = Set-GGTaskSettings -TaskName $gg' + label + 'Name\n'
        '        if ($ggSet' + label + '.Ok) {\n'
        '            Write-Log -Message ("Reminder settings confirmed by read-back -- runs on battery: yes, catches a missed start: yes, wakes the PC: no (' + label + ')") -Status "GOOD"\n'
        '        } elseif ($ggSet' + label + '.Error) {\n'
        '            $results += @{ Text = "  [!] Reminder created, but its battery settings could not be adjusted -- it may not run on battery"; Color = "Yellow" }\n'
        '            Write-Log -Message ("Reminder settings NOT adjusted (' + label + ') -- $($ggSet' + label + '.Error)") -Status "WARN"\n'
        '        } else {\n'
        '            $results += @{ Text = "  [!] Reminder created, but its battery settings did not take -- it may not run on battery"; Color = "Yellow" }\n'
        '            Write-Log -Message ("Reminder settings read back WRONG (' + label + ') -- StartWhenAvailable=$($ggSet' + label + '.StartWhenAvailable) DisallowStartIfOnBatteries=$($ggSet' + label + '.DisallowStartIfOnBatteries) StopIfGoingOnBatteries=$($ggSet' + label + '.StopIfGoingOnBatteries)") -Status "WARN"\n'
        '        }\n'
    )

with PS1Edit(TARGET) as e:
    # 1. the helper, immediately before Invoke-SchTasksCreate
    e.replace(
        "function Invoke-SchTasksCreate {",
        HELPER.lstrip("\n") + "function Invoke-SchTasksCreate {",
        count=1,
        why="FT-203: Set-GGTaskSettings helper, measured on CGDELL 2026-09-06",
    )

    # 2. task 1 -- quarterly offline scan reminder
    e.replace(
        '        if ($ggT1Result.ExitCode -ne 0) { throw "schtasks exit $($ggT1Result.ExitCode) -- $($ggT1Result.Output)" }\n',
        '        if ($ggT1Result.ExitCode -ne 0) { throw "schtasks exit $($ggT1Result.ExitCode) -- $($ggT1Result.Output)" }\n'
        + adjust("T1"),
        count=1,
        why="FT-203: adjust + read back task 1, the quarterly offline scan reminder",
    )

    # 3. task 2 -- monthly Malwarebytes reminder
    e.replace(
        '        if ($ggT2Result.ExitCode -ne 0) { throw "schtasks exit $($ggT2Result.ExitCode) -- $($ggT2Result.Output)" }\n',
        '        if ($ggT2Result.ExitCode -ne 0) { throw "schtasks exit $($ggT2Result.ExitCode) -- $($ggT2Result.Output)" }\n'
        + adjust("T2"),
        count=1,
        why="FT-203: adjust + read back task 2, the monthly Malwarebytes reminder",
    )

    # 4. header change record
    e.replace(
        "# CHANGES FROM ascii39 (2026-08-15 -- ASCII40: THE THREE FIELD BLOCKERS):",
        "#   FT-203: BOTH REMINDERS WERE OFF BY DEFAULT ON A LAPTOP. schtasks.exe\n"
        "#           has no switch for a missed start, for waking, or for battery,\n"
        "#           so every task it creates carries\n"
        "#           DisallowStartIfOnBatteries=True and StartWhenAvailable=False.\n"
        "#           A senior on battery at 10:00 got no reminder, and it was not\n"
        "#           shown when they plugged in either -- while the log said\n"
        "#           [GOOD] Scheduled task created, which was true. The task\n"
        "#           existed; it could not fire. New Set-GGTaskSettings runs after\n"
        "#           the create, mutates the three properties on the task's own\n"
        "#           settings object, and LOGS WHAT IT READS BACK.\n"
        "#           WakeToRun stays False on purpose -- product decision.\n"
        "#\n"
        "# CHANGES FROM ascii39 (2026-08-15 -- ASCII40: THE THREE FIELD BLOCKERS):",
        count=1,
        why="FT-203: header change record",
    )
