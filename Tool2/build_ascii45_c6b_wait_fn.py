"""build_ascii45_c6b_wait_fn -- move Invoke-GGFixScreen's "press Enter for
the rest" wait into its own function, Wait-GGEnterOrSpace.

Dated: 2026-09-27 08:15 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block C, item C6 (follow-up).

Why: the paging wait read the real keyboard inline, so the test harness hung
on it (2026-09-27 08:14). As a function it can be stood in for in a test, and
it behaves exactly as before.

Run from Tool2/:  python build_ascii45_c6b_wait_fn.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "                Write-Host \"  This screen is taller than your window. Press Enter or Space for the rest...\" -ForegroundColor White\n"
        "                try {\n"
        "                    do {\n"
        "                        try { [Console]::TreatControlCAsInput = $true } catch {}\n"
        "                        $ggK = $Host.UI.RawUI.ReadKey(\"NoEcho,IncludeKeyDown\")\n"
        "                    } while ($ggK.VirtualKeyCode -notin @(13, 32))\n"
        "                } catch { $null = Read-Host }\n",
        "                Write-Host \"  This screen is taller than your window. Press Enter or Space for the rest...\" -ForegroundColor White\n"
        "                Wait-GGEnterOrSpace\n",
        count=1, why="use Wait-GGEnterOrSpace")
    e.replace(
        "function Invoke-GGFixScreen {\n",
        "function Wait-GGEnterOrSpace {\n"
        "    # C6 (ascii45): waits for Enter or Space only. Ctrl+C is taken as a key\n"
        "    # here and ignored; the flag is re-asserted before every read (FT-46).\n"
        "    try {\n"
        "        do {\n"
        "            try { [Console]::TreatControlCAsInput = $true } catch {}\n"
        "            $ggK = $Host.UI.RawUI.ReadKey(\"NoEcho,IncludeKeyDown\")\n"
        "        } while ($ggK.VirtualKeyCode -notin @(13, 32))\n"
        "    } catch { $null = Read-Host }\n"
        "}\n"
        "\n"
        "function Invoke-GGFixScreen {\n",
        count=1, why="add Wait-GGEnterOrSpace")
