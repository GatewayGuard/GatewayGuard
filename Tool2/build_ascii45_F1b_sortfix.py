"""build_ascii45_F1b_sortfix -- F18 sort fix: inside switch, $_ is the switched
value, so "[int]$_.ID + 10" was the same for every item and Sort-Object
jumbled them (test: 3,2,1,8,9,10,4,6,7). Capture the ID first.

Dated: 2026-09-28 08:13 ET
Editor: Claude Code (CGDELL)
"""
from gg_edit import PS1Edit
with PS1Edit(r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1") as e:
    e.replace(
        "        $ggPageItems = @($ggPageItems | Sort-Object { switch ([int]$_.ID) { 3 { 1 } 2 { 2 } 1 { 3 } default { [int]$_.ID + 10 } } })\n",
        "        $ggPageItems = @($ggPageItems | Sort-Object { $ggId = [int]$_.ID; switch ($ggId) { 3 { 1 } 2 { 2 } 1 { 3 } default { $ggId + 10 } } })\n",
        count=1, why="F18: capture the ID before switch")
