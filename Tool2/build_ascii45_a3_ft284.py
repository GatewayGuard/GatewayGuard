"""build_ascii45_a3_ft284 -- the convenience review stops printing a green
"Done:" over an ERROR.

Dated: 2026-09-26 11:03 ET (commit time. The first stamp, 11:36, was typed, not read off the clock -- corrected 2026-09-26 11:10.)
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block A, item A3.

FT-284 (measured, ascii44 SANDY run R9 18:52:17; triage Part 5): the review
printed "Done: ERROR: Attempted to perform an unauthorized operation." in
GREEN and logged it [OK]. Now it uses the run loop's own colour rule (same
regex, same order), prints "Done:" only for a success, and logs WARN/ERROR.
F1 (Decision 4) replaces this screen later; this fix ships regardless, so the
defect cannot ride along if F1 slips.

Run from Tool2/:  python build_ascii45_a3_ft284.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "#           through Get-GGConsoleLockState and say GOOD only on REQUIRED.\n",
        "#           through Get-GGConsoleLockState and say GOOD only on REQUIRED.\n"
        "#   FT-284: THE CONVENIENCE REVIEW PRINTED A GREEN \"Done:\" OVER AN ERROR\n"
        "#           and logged it [OK] (SANDY, 33b). Now it uses the run loop's\n"
        "#           colour rule and logs WARN/ERROR for anything not a success.\n",
        count=1,
        why="change log: FT-284",
    )
    e.replace(
        "            $ggConvResult = Apply-Setting -Setting $ggSetting\n"
        "            Write-Host \"\"\n"
        "            Write-Host \"  Done: $ggConvResult\" -ForegroundColor Green\n"
        "            Write-Log -Message \"User approved convenience change: $($ci.Name) -- $ggConvResult\" -Status \"OK\"\n",
        "            $ggConvResult = Apply-Setting -Setting $ggSetting\n"
        "            Write-Host \"\"\n"
        "            # FT-284 (ascii45): same colour rule as the run loop, in the same\n"
        "            # order. A result is only \"Done\" when it reads as a success.\n"
        "            if ($ggConvResult -match \"GOOD|enabled|disabled|set to|Already\") {\n"
        "                Write-Host \"  Done: $ggConvResult\" -ForegroundColor Green\n"
        "                Write-Log -Message \"User approved convenience change: $($ci.Name) -- $ggConvResult\" -Status \"OK\"\n"
        "            } elseif ($ggConvResult -match \"NOTE:|MANUAL|manual\") {\n"
        "                Write-Host \"  $ggConvResult\" -ForegroundColor Yellow\n"
        "                Write-Log -Message \"User approved convenience change: $($ci.Name) -- $ggConvResult\" -Status \"WARN\"\n"
        "            } else {\n"
        "                Write-Host \"  Not changed: $ggConvResult\" -ForegroundColor Red\n"
        "                Write-Log -Message \"User approved convenience change: $($ci.Name) -- NOT applied -- $ggConvResult\" -Status \"ERROR\"\n"
        "            }\n",
        count=1,
        why="FT-284: colour and log status follow the result",
    )
print("A3 applied")
