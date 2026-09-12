"""build_ascii44_matches -- FT-255, FT-246 and FT-245.

FT-255 -- FIVE PARSES THAT COULD NEVER POPULATE $Matches
--------------------------------------------------------
MEASURED on CGDELL 2026-09-06, PowerShell 5.1:

    $arr = @('noise','Current AC Power Setting Index: 0x00000001','more')
    $arr -match 'Current AC Power Setting Index: 0x(\\w+)'
      -> returns the matching ELEMENT (so the `if` is TRUE)
      -> $Matches is $null

    ($arr | Out-String) -match 'same pattern'
      -> returns $true, $Matches[1] = '00000001'

On an ARRAY, -match is a FILTER, not a match: it returns the matching
elements and never populates $Matches. Every `powercfg` call returns multiple
lines, so every one of these variables is an array.

So each site's `if` passes and the very next expression, $Matches[1], reads a
$Matches that this statement did not set -- either $null (throws, caught,
falls back) or whatever a previous unrelated scalar match left behind. A
value read from a stale $Matches is worse than no value: it is a wrong number
reported as a measurement.

THE CORRECT PATTERN IS ALREADY IN THIS FILE, TWICE -- lines 5088 and 5116 use
`($st | Out-String) -match ...`. Five other sites do not. That is the FT-242
shape again: the right pattern sitting a few lines from the wrong one.

  5027   $pw              password-on-wake STATUS read
  6173   $pw              setting 17 status read
  5291   $ggQ             password-on-wake RE-READ after applying  (FT-246)
  8089   $blOrigSleepRaw  original sleep timeout, saved before an overnight
  8090   $blOrigDisplayRaw   encryption run and restored afterwards

NOT a site, despite matching the search: line 7690, `$ggOut` from
manage-bde. That one is already piped through Out-String at assignment, so it
is a string and $Matches populates correctly. Read before fixing.

FT-246 -- "PASSWORD ON WAKE" RE-READ FAILS TWICE, SUCCEEDS ONCE
---------------------------------------------------------------
Bill, screen 19: "The log says Checkup could not reread the setting;
determine whether the setting can be read reliably."

Two failures and one success across three runs on the same machine, same
setting, same build. The triage said not to fix it by guessing, and to
instrument instead. Measuring first found the mechanism above, which explains
the two failures exactly. It also means the ONE success is suspect: with
$Matches never set by this statement, a "REQUIRED" result could only have
come from a stale $Matches left by an earlier match.

The Out-String fix is the certain part. What is still NOT known is instrumented
rather than guessed at -- see below.

WHAT IS NOT FIXED, AND IS NOT GUESSED AT
-----------------------------------------
MEASURED on CGDELL 2026-09-06, elevated:

    powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK
    [Power Scheme GUID: 381b4222-...  (Balanced)]
    [  GUID Alias: SCHEME_BALANCED]
    exit code 0

TWO LINES, AND NO SETTING BLOCK AT ALL. There is no "Current AC Power Setting
Index" line to find, so even with Out-String the parse returns nothing -- and
the status read then reports "NOT required -- change recommended" from a read
that produced NOTHING. That is the FT-120/FT-123 shape: absence read as state.

Raised as FT-256, not fixed here. It needs its own work -- console lock is a
hidden power setting on some machines, and the fix may be a different data
source rather than a different parse. Guessing at it is what the triage
warned against.

So this build makes the failure VISIBLE instead: when the parse finds nothing,
the raw powercfg output is logged. The next field run will say why rather than
just "could not re-read".

FT-245 -- THE SILENT-ERROR BREADCRUMB NAMES THE WRONG PLACE
------------------------------------------------------------
Every silent-error line reads "SILENT ERROR at Show-ScopeDisclaimer" -- which
is where the USER was, not where the fault was. The real location is already
in the same line, after the "|", as the position message. Only the wording
misdirects, so only the wording changes. Severity is NOT reclassified: an
access denial stays ERROR, because reclassifying it to INFO is how a real
failure becomes invisible.

Run from Tool2/:  python build_ascii44_matches.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

NOTE = ("# FT-255 (ascii44): powercfg returns an ARRAY. On an array -match is a\n"
        "        # FILTER and does NOT populate $Matches -- measured on CGDELL\n"
        "        # 2026-09-06. Out-String makes it a scalar match, which is the\n"
        "        # pattern already used at the screen-timeout and battery reads.")

with PS1Edit(TARGET) as e:

    # -- 1. password-on-wake STATUS read --------------------------------------
    e.replace(
        '        $pw = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>$null\n'
        '        $acVal = if ($pw -match "Current AC Power Setting Index: 0x(\\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { $null }\n',
        '        $pw = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>$null\n'
        '        ' + NOTE + '\n'
        '        $acVal = if (($pw | Out-String) -match "Current AC Power Setting Index: 0x(\\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { $null }\n',
        count=1,
        why="FT-255 site 1/5: password-on-wake status read",
    )

    # -- 2. setting 17 status read --------------------------------------------
    e.replace(
        'try { $pw = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>$null; $acVal = if ($pw -match "Current AC Power Setting Index: 0x(\\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { $null }; $s.Status = if ($acVal -eq 1) { "REQUIRED -- GOOD" } else { "Not required -- needs attention" } }',
        'try { $pw = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>$null; $acVal = if (($pw | Out-String) -match "Current AC Power Setting Index: 0x(\\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { $null }; $s.Status = if ($acVal -eq 1) { "REQUIRED -- GOOD" } else { "Not required -- needs attention" } }   # FT-255: Out-String -- -match on an array never sets $Matches',
        count=1,
        why="FT-255 site 2/5: setting 17 status read",
    )

    # -- 3. the re-read, and instrument what is still unknown ------------------
    e.replace(
        '            $ggNow = "could not re-read -- check manually"\n'
        '            try {\n'
        '                $ggQ = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>&1\n'
        '                if ($ggQ -match "Current AC Power Setting Index: 0x(\\w+)") {\n'
        '                    $ggNow = if ([Convert]::ToUInt32($Matches[1], 16) -eq 1) { "REQUIRED" } else { "still NOT required" }\n'
        '                }\n'
        '            } catch {}\n',
        '            $ggNow = "could not re-read -- check manually"\n'
        '            try {\n'
        '                $ggQ = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>&1\n'
        '                ' + NOTE + '\n'
        '                if (($ggQ | Out-String) -match "Current AC Power Setting Index: 0x(\\w+)") {\n'
        '                    $ggNow = if ([Convert]::ToUInt32($Matches[1], 16) -eq 1) { "REQUIRED" } else { "still NOT required" }\n'
        '                } else {\n'
        '                    # FT-246/FT-256 (ascii44): the parse found nothing. Log the RAW\n'
        '                    # output so the next field run says WHY, instead of only\n'
        '                    # "could not re-read". Measured on CGDELL 2026-09-06: this\n'
        '                    # query can return the scheme header and no setting block at\n'
        '                    # all, which is FT-256 and is not fixed by any parse change.\n'
        '                    $ggRaw = ((($ggQ | Out-String) -replace "\\s+", " ").Trim())\n'
        '                    if ($ggRaw.Length -gt 300) { $ggRaw = $ggRaw.Substring(0, 300) + "..." }\n'
        '                    Write-Log -Message "Password on wake re-read found no setting index (FT-256). Raw powercfg output: $ggRaw" -Status "WARN"\n'
        '                }\n'
        '            } catch {\n'
        '                Write-Log -Message "Password on wake re-read threw: $_" -Status "WARN"\n'
        '            }\n',
        count=1,
        why="FT-246/FT-255 site 3/5: the re-read, plus instrumentation for FT-256",
    )

    # -- 4 and 5. the sleep/display originals saved before an overnight run -----
    e.replace(
        '        $blOrigSleep = if ($blOrigSleepRaw -match "Current AC Power Setting Index: 0x(\\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { 0 }\n'
        '        $blOrigDisplay = if ($blOrigDisplayRaw -match "Current AC Power Setting Index: 0x(\\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { 0 }\n',
        '        ' + NOTE + '\n'
        '        # These two are the values RESTORED after an overnight encryption\n'
        '        # run, so a wrong read here leaves the machine on the wrong timeouts.\n'
        '        $blOrigSleep = if (($blOrigSleepRaw | Out-String) -match "Current AC Power Setting Index: 0x(\\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { 0 }\n'
        '        $blOrigDisplay = if (($blOrigDisplayRaw | Out-String) -match "Current AC Power Setting Index: 0x(\\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { 0 }\n',
        count=1,
        why="FT-255 sites 4/5 and 5/5: sleep and display originals for the overnight restore",
    )

    # -- FT-245: the breadcrumb names where the USER was ----------------------
    e.replace(
        '                Write-Log -Message ($ggLabel + " at " + $Where + ": " + $ggMsg + $(if ($ggAt) { " | " + $ggAt } else { "" })) -Status $ggStatus',
        '                # FT-245 (ascii44): $Where is where the USER was, not where the\n'
        '                # fault was -- every line read "SILENT ERROR at\n'
        '                # Show-ScopeDisclaimer" and sent readers to the wrong function.\n'
        '                # The real location is the position message. Wording only:\n'
        '                # severity is NOT reclassified, because turning an access\n'
        '                # denial into INFO is how a real failure becomes invisible.\n'
        '                $ggFault = if ($ggAt) { $ggAt } else { "location not recorded" }\n'
        '                Write-Log -Message ($ggLabel + " -- fault at: " + $ggFault + " -- user was at: " + $Where + " -- " + $ggMsg) -Status $ggStatus',
        count=1,
        why="FT-245: the silent-error breadcrumb pointed at the wrong function",
    )

    # -- header change record --------------------------------------------------
    e.replace(
        "# CHANGES FROM ascii39 (2026-08-15 -- ASCII40: THE THREE FIELD BLOCKERS):",
        "#   FT-255: FIVE PARSES COULD NEVER POPULATE $Matches. powercfg returns an\n"
        "#           ARRAY, and on an array -match is a FILTER: it returns the\n"
        "#           matching element, so the `if` passes, but it NEVER sets\n"
        "#           $Matches. Measured on CGDELL 2026-09-06. So the next\n"
        "#           expression read a $Matches this statement did not set --\n"
        "#           $null, or whatever an unrelated earlier match had left. A\n"
        "#           number from a stale $Matches is worse than no number. The\n"
        "#           correct pattern, ($x | Out-String) -match, was already in this\n"
        "#           file at two other reads. NOT a site: the manage-bde read,\n"
        "#           which is piped through Out-String at assignment already.\n"
        "#   FT-246: the password-on-wake re-read is one of those five, which\n"
        "#           explains two failures and makes the one success suspect.\n"
        "#           What is still unknown is INSTRUMENTED, not guessed: when the\n"
        "#           parse finds nothing the raw powercfg output is now logged.\n"
        "#   FT-256: RAISED, NOT FIXED. Measured on CGDELL, elevated: this query\n"
        "#           can return the scheme header and NO setting block at all --\n"
        "#           and the status read then reports \"NOT required\" from a read\n"
        "#           that produced nothing, which is the FT-120/FT-123 shape.\n"
        "#           No parse change fixes that; it needs its own work.\n"
        "#   FT-245: the silent-error breadcrumb said \"at Show-ScopeDisclaimer\",\n"
        "#           where the USER was, not where the fault was. Wording only --\n"
        "#           severity unchanged, because an access denial logged as INFO\n"
        "#           is how a real failure becomes invisible.\n"
        "#\n"
        "# CHANGES FROM ascii39 (2026-08-15 -- ASCII40: THE THREE FIELD BLOCKERS):",
        count=1,
        why="FT-255/246/245: header change record",
    )
