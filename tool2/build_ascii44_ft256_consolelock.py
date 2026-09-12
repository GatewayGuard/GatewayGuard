"""FT-256 -- the password-on-wake read that reported a verdict from silence.

Dated: 2026-09-08 21:45 ET
Editor: Claude Code (CGDELL)
Build:  ascii44 (in place -- ascii44 has NOT been field run, so it is not spent)

Bill, 2026-09-08: "fix ft-256".

THE DEFECT, and it is the mirror of FT-257.
------------------------------------------
Two sites ran `powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK`, parsed
for a setting index, and when the parse found nothing fell through to the ELSE
branch and reported "NOT required". That is a verdict invented from silence.

FT-257 was the same fault pointing the other way -- an absent value became a
wrong GOOD, which DESELECTS the item so the user is never offered the fix.
Here it becomes a wrong BAD, which is the safer direction: it offers a fix
that may be unneeded rather than hiding one that is needed. But it still tells
a user their PC is insecure when we do not know, and the fix costs the same.

MEASURED ON CGDELL 2026-09-08 21:29, elevated, in
Test_Results\\SettingsStatus-CGDELL-2026-09-08_21-29.txt: the query returned no
setting index block at all. The shipped build reports "NOT required -- change
recommended" in exactly that situation. This machine is a live instance, not a
theory -- which is also how the fix can be verified rather than argued about.

THE FIX -- one shared reader, not two parallel repairs.
------------------------------------------------------
Both sites asked the same question and each had its own copy of the parse.
`Get-GGConsoleLockState` answers it once, with FOUR outcomes instead of two:

    REQUIRED      index parsed, is 1
    NOT_REQUIRED  index parsed, is not 1
    NO_INDEX      powercfg answered, but with no setting index block
    NO_OUTPUT     powercfg produced nothing, or threw

and carries the raw output so the log says WHY rather than only "unknown".
That is the FT-257 shape applied here: separate BLOCKED / ABSENT / OFF instead
of collapsing them, and let the caller decide the wording.

WIDTH, because two width defects are already on the books (FT-117, FT-122).
The power screen's box takes its width from its longest line, and
"NOT required -- change recommended" (34 chars) is already the longest value
on that line. The replacement, "Could not read -- check by hand", is 31 -- so
the box cannot get wider than it already is. The checklist status uses the
longer "Unknown -- could not read; check by hand", which is the string item 4
already prints in that same render path, so it is proven there.

BEHAVIOUR ON THE UNKNOWN, checked rather than assumed:
  * Power screen, line 5308: `-notmatch "GOOD|N/A"` -- so an unknown IS still
    offered for change. Correct: the fix is harmless and idempotent, and we do
    not know it is already set.
  * Checklist auto-deselect keys on "GOOD" -- an unknown stays selected, so
    the item is still offered. Correct, same reason.
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from gg_edit import PS1Edit  # noqa: E402

BUILD = Path(__file__).resolve().parent.parent / "Tool" / \
    "W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

# ---------------------------------------------------------------- helper ---
HELPER = r'''function Get-GGConsoleLockState {
    # FT-256 (ascii44, FIXED 2026-09-08). Bill: "fix ft-256".
    #
    # THE DEFECT THIS REPLACES: two sites parsed this query for a setting
    # index and, when the parse found nothing, fell through to the ELSE
    # branch and reported "NOT required". A verdict from a read that produced
    # nothing -- the FT-120/FT-123 shape, and the exact mirror of FT-257,
    # where an absent value became a wrong GOOD.
    #
    # A wrong BAD is the safer direction: it offers a fix that may be
    # unneeded rather than hiding one that is needed. It is still wrong. It
    # tells the user their PC is insecure when we do not know.
    #
    # VERIFIED 2026-09-08 measured on CGDELL, elevated: powercfg /query
    # SCHEME_CURRENT SUB_NONE CONSOLELOCK returned the scheme header and NO
    # "Current AC Power Setting Index:" line at all.
    # Test_Results\SettingsStatus-CGDELL-2026-09-08_21-29.txt
    #
    # FOUR ANSWERS, never two. The caller chooses the wording; this decides
    # only what was actually true. Raw carries the output so the log says WHY.
    $ggOut = ""
    try {
        $ggQ   = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>&1
        $ggOut = ($ggQ | Out-String)
    } catch {
        return @{ State = "NO_OUTPUT"; Value = $null; Raw = "powercfg threw: $_" }
    }
    if ([string]::IsNullOrWhiteSpace($ggOut)) {
        return @{ State = "NO_OUTPUT"; Value = $null; Raw = "" }
    }
    $ggRaw = (($ggOut -replace "\s+", " ").Trim())
    if ($ggRaw.Length -gt 300) { $ggRaw = $ggRaw.Substring(0, 300) + "..." }
    # FT-255 (ascii44): Out-String FIRST. On an array -match is a filter and
    # never populates $Matches.
    if ($ggOut -match "Current AC Power Setting Index:\s*0x(\w+)") {
        $ggVal = [Convert]::ToUInt32($Matches[1], 16)
        if ($ggVal -eq 1) { return @{ State = "REQUIRED";     Value = $ggVal; Raw = $ggRaw } }
        return @{ State = "NOT_REQUIRED"; Value = $ggVal; Raw = $ggRaw }
    }
    return @{ State = "NO_INDEX"; Value = $null; Raw = $ggRaw }
}

'''

ANCHOR_FN = "function Run-PowerSettingsCheck {"

# ---------------------------------------------------------------- site 1 ---
OLD_1 = '''    # 1. Password on wake
    try {
        $pw = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>$null
        # FT-255 (ascii44): powercfg returns an ARRAY. On an array -match is a
        # FILTER and does NOT populate $Matches -- measured on CGDELL
        # 2026-09-06. Out-String makes it a scalar match, which is the
        # pattern already used at the screen-timeout and battery reads.
        $acVal = if (($pw | Out-String) -match "Current AC Power Setting Index: 0x(\\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { $null }
        $results["PasswordOnWake"] = if ($acVal -eq 1) { "REQUIRED -- GOOD" } else { "NOT required -- change recommended" }
    } catch { $results["PasswordOnWake"] = "Unknown" }'''

NEW_1 = '''    # 1. Password on wake
    # FT-256 (ascii44, fixed 2026-09-08): this used to report "NOT required"
    # whenever the parse found nothing, which is a verdict from silence.
    # Get-GGConsoleLockState separates a real NO from a failed read, and FT-255
    # (Out-String before -match) lives inside it now rather than being repeated.
    # The unknown wording is 31 chars against the 34 of the line above it, so
    # the box cannot get wider -- FT-117/FT-122.
    $ggCL = Get-GGConsoleLockState
    switch ($ggCL.State) {
        "REQUIRED"     { $results["PasswordOnWake"] = "REQUIRED -- GOOD" }
        "NOT_REQUIRED" { $results["PasswordOnWake"] = "NOT required -- change recommended" }
        default        {
            $results["PasswordOnWake"] = "Could not read -- check by hand"
            try { Write-Log -Message "Password on wake: read produced no setting index (FT-256, $($ggCL.State)). Raw powercfg output: $($ggCL.Raw)" -Status "WARN" } catch {}
        }
    }'''

# ---------------------------------------------------------------- site 2 ---
OLD_2 = '''            17 {
                try { $pw = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>$null; $acVal = if (($pw | Out-String) -match "Current AC Power Setting Index: 0x(\\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { $null }; $s.Status = if ($acVal -eq 1) { "REQUIRED -- GOOD" } else { "Not required -- needs attention" } }   # FT-255: Out-String -- -match on an array never sets $Matches
                catch { $s.Status = "Unknown" }
            }'''

NEW_2 = '''            17 {
                # FT-256 (ascii44, fixed 2026-09-08): "Not required -- needs
                # attention" used to be printed when the parse found nothing.
                # A failed read now says so, and an unknown keeps the item
                # SELECTED (auto-deselect keys on "GOOD"), so the user is still
                # offered the fix. The wording matches item 4's, which is
                # already proven in this render path.
                $ggCL17 = Get-GGConsoleLockState
                $s.Status = switch ($ggCL17.State) {
                    "REQUIRED"     { "REQUIRED -- GOOD" }
                    "NOT_REQUIRED" { "Not required -- needs attention" }
                    default        { "Unknown -- could not read; check by hand" }
                }
                if (@("REQUIRED","NOT_REQUIRED") -notcontains $ggCL17.State) {
                    try { Write-Log -Message "Item 17 (password on wake): read produced no setting index (FT-256, $($ggCL17.State)). Raw powercfg output: $($ggCL17.Raw)" -Status "WARN" } catch {}
                }
            }'''

# --------------------------------------------------------------- header ----
OLD_HDR = '''#   FT-256: RAISED, NOT FIXED. Measured on CGDELL, elevated: this query
#           can return the scheme header and NO setting block at all --
#           and the status read then reports "NOT required" from a read
#           that produced nothing, which is the FT-120/FT-123 shape.
#           No parse change fixes that; it needs its own work.'''

NEW_HDR = '''#   FT-256: FIXED 2026-09-08 (Bill: "fix ft-256"). Measured on CGDELL,
#           elevated: this query can return the scheme header and NO
#           setting block at all -- and BOTH read sites then reported
#           "NOT required" from a read that produced nothing, which is
#           the FT-120/FT-123 shape and the mirror of FT-257.
#           FIX: one shared reader, Get-GGConsoleLockState, with FOUR
#           outcomes -- REQUIRED / NOT_REQUIRED / NO_INDEX / NO_OUTPUT --
#           replacing two private copies of a two-outcome parse. A failed
#           read now says "could not read" and logs the raw powercfg
#           output, so the next field run says WHY.
#           The unknown keeps the item SELECTED, because auto-deselect
#           keys on "GOOD" -- so the user is still offered the fix. That
#           is deliberate: the fix is harmless and idempotent, and a
#           reading we could not take is not a reason to hide it.
#           Live instance measured the same day:
#           Test_Results\\SettingsStatus-CGDELL-2026-09-08_21-29.txt'''


def main():
    with PS1Edit(str(BUILD)) as e:
        e.replace(OLD_HDR, NEW_HDR, count=1,
                  why="FT-256: header entry moves from RAISED to FIXED")
        e.replace(ANCHOR_FN, HELPER + ANCHOR_FN, count=1,
                  why="FT-256: Get-GGConsoleLockState, defined before both callers")
        e.replace(OLD_1, NEW_1, count=1,
                  why="FT-256 site 1: power screen no longer invents NOT required")
        e.replace(OLD_2, NEW_2, count=1,
                  why="FT-256 site 2: checklist item 17 no longer invents a verdict")


if __name__ == "__main__":
    main()
