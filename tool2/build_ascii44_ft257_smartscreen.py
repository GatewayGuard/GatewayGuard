"""build_ascii44_ft257_smartscreen -- FT-257.

THE SMARTSCREEN CHECK REPORTED "ON -- GOOD" FROM A VALUE THAT WAS NOT THERE
--------------------------------------------------------------------------
Bill, 2026-09-07, looking at his own screen while I read him the registry:
"if what you read says blocking is on why does windows security av apps and
browsers asking to turn on reputation checking. Isn't that where blocking
settings are?"

He was right and the check was wrong.

THE LINE, build 6029 as shipped:

    try { $ss = (Get-ItemProperty "HKLM:\\...\\Explorer" -EA SilentlyContinue).SmartScreenEnabled
          $s.Status = if ($ss -ne "Off") { "ON -- GOOD" } else { "OFF -- needs attention" } }
    catch { $s.Status = "Unknown" }

MEASURED on CGDELL 2026-09-07 12:59, before anything was changed:

    HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\SmartScreenEnabled
      -> NOT SET

and at that same moment Windows Security was posting a warning asking for
reputation-based protection to be turned on.

An absent value reads as $null. `$null -ne "Off"` is TRUE. So the branch taken
is "ON -- GOOD", on a machine where Windows itself says the setting needs
turning on. The check does not read the state; it reads "is this string
literally the word Off", and everything else -- including nothing at all --
counts as on.

TWO WAYS TO REACH THE WRONG ANSWER, NOT ONE
-------------------------------------------
1. ABSENT. The value has never been written. $null -> "ON -- GOOD".
2. BLOCKED. `-EA SilentlyContinue` turns a refused read into $null as well, so
   a read denied by policy lands in exactly the same place and also reports
   GOOD. This is FT-141 verbatim, on a different key: that one was fixed by
   telling BLOCKED and ABSENT apart with -EA Stop and a typed catch. The same
   fix belongs here.

WHY A WRONG "GOOD" IS WORSE THAN A WRONG ANYTHING ELSE
-----------------------------------------------------
Line 6313:   if ($s.Status -match "GOOD") { $s.Selected = $false }

"GOOD" in the status DESELECTS the item. So this does not merely tell the user
something false -- it removes the item from the list of things Checkup offers
to fix, and the user never sees the question. A silent skip is the most
expensive kind of wrong answer this program can give.

THE RULE THIS RESTORES, already written down twice in this project: a check
that did not establish the state reports Unknown and never invents a definite
answer (FT-120, FT-123, FT-141).

WHAT THE VALUE CAN BE, and what each means:
    "RequireAdmin"  on, strictest      -> GOOD
    "Warn"          on, recommended    -> GOOD   (this is what item 4 applies)
    "Off"           off                -> needs attention
    absent          never configured   -> needs attention
    refused         cannot be read     -> Unknown, verify by hand
    anything else   unrecognised       -> Unknown, verify by hand

DELIBERATELY NOT DONE HERE
--------------------------
A Group Policy value, HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\System\\
EnableSmartScreen, can force SmartScreen off no matter what the value above
says -- which would be the same class of wrong GOOD. It is NOT part of this
fix. MEASURED on CGDELL 2026-09-07: that policy is not set, so there is no
evidence it is a live problem here, and a status of "off by policy" needs a
decision about what Checkup should then offer the user -- applying the setting
would not lift a policy. Raised, not fixed. It belongs with the F6 wording
block, not smuggled into a status-read fix.

The apply path, build 6498, is correct and untouched: it writes "Warn" with
-EA Stop and reports through a catch.

Run from Tool2/:  python build_ascii44_ft257_smartscreen.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

OLD = (
    '            4 {\n'
    '                try { $ss = (Get-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer" -EA SilentlyContinue).SmartScreenEnabled; $s.Status = if ($ss -ne "Off") { "ON -- GOOD" } else { "OFF -- needs attention" } }\n'
    '                catch { $s.Status = "Unknown" }\n'
    '            }\n'
)

NEW = (
    '            4 {\n'
    '                # FT-257 (ascii44): THIS REPORTED "ON -- GOOD" FROM A VALUE\n'
    '                # THAT WAS NOT THERE. The test was ($ss -ne "Off"), and an\n'
    '                # ABSENT SmartScreenEnabled reads as $null -- which is not\n'
    '                # "Off", so it took the GOOD branch. MEASURED on CGDELL\n'
    '                # 2026-09-07: the value was absent while Windows Security\n'
    '                # was itself posting a warning asking for reputation\n'
    '                # checking to be turned on. Bill was looking at that warning\n'
    '                # when he asked why we disagreed with his screen.\n'
    '                # -EA SilentlyContinue made it worse: a REFUSED read also\n'
    '                # lands as $null, so blocked and absent both reported GOOD.\n'
    '                # That is FT-141 on a different key, and the same fix\n'
    '                # applies -- -EA Stop with a typed catch, so BLOCKED and\n'
    '                # ABSENT are told apart and neither is guessed at.\n'
    '                # WHY A WRONG GOOD IS THE WORST KIND: "GOOD" in the status\n'
    '                # deselects the item a few lines below, so the user is never\n'
    '                # offered the fix and never sees the question.\n'
    '                try {\n'
    '                    $ss        = $null\n'
    '                    $ssBlocked = $false\n'
    '                    try {\n'
    '                        $ss = (Get-ItemProperty "HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer" -Name SmartScreenEnabled -EA Stop).SmartScreenEnabled\n'
    '                    } catch [System.Security.SecurityException] {\n'
    '                        $ssBlocked = $true\n'
    '                    } catch [System.UnauthorizedAccessException] {\n'
    '                        $ssBlocked = $true\n'
    '                    } catch {\n'
    '                        # A missing key or missing value lands here, leaves\n'
    '                        # $ss null and $ssBlocked false, and is reported as\n'
    '                        # "not configured" below -- which for an absent\n'
    '                        # value is the truth.\n'
    '                        if ($_.Exception -is [System.Security.SecurityException]) { $ssBlocked = $true }\n'
    '                    }\n'
    '                    if ($ssBlocked) {\n'
    '                        $s.Status = "Unknown -- could not read; check by hand"\n'
    '                    } elseif ($null -eq $ss -or "$ss" -eq "") {\n'
    '                        $s.Status = "Not configured -- needs attention"\n'
    '                    } elseif ("$ss" -eq "Off") {\n'
    '                        $s.Status = "OFF -- needs attention"\n'
    '                    } elseif ("$ss" -eq "Warn" -or "$ss" -eq "RequireAdmin") {\n'
    '                        $s.Status = "ON -- GOOD"\n'
    '                    } else {\n'
    '                        $s.Status = "Unknown setting -- check by hand"\n'
    '                    }\n'
    '                }\n'
    '                catch { $s.Status = "Unknown" }\n'
    '            }\n'
)

with PS1Edit(TARGET) as e:
    e.replace(
        OLD, NEW, count=1,
        why="FT-257: SmartScreen status reported GOOD for an absent or unreadable value",
    )
