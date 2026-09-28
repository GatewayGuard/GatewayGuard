"""build_ascii45_F1b_summarylog -- F1 follow-up: screen 99 logs each row once
(before the pages), not again every time a page is redrawn after B.

Dated: 2026-09-28 08:27 ET (commit time; the 08:44 first typed here was not read off a clock)
Editor: Claude Code (CGDELL)

Run from Tool2/:  python build_ascii45_F1b_summarylog.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "            Write-Host \"\"\n"
        "            if ($ggP -eq 0 -or $true) {\n"
        "                try { Write-Log -Message (\"Changed summary: \" + $ggR.ID + \". \" + $ggR.Name + \" | Was: \" + $ggR.Was + \" | Now: \" + $ggR.Now) -Status $(if ($ggGood) { \"OK\" } else { \"WARN\" }) } catch {}\n"
        "            }\n"
        "        }\n",
        "            Write-Host \"\"\n"
        "        }\n",
        count=1, why="F1b: drop per-page log")
    e.replace(
        "    if ($ggCur.Count -gt 0) { $ggPages.Add($ggCur.ToArray()) }\n",
        "    if ($ggCur.Count -gt 0) { $ggPages.Add($ggCur.ToArray()) }\n"
        "    foreach ($ggR in $ggRows) {\n"
        "        try { Write-Log -Message (\"Changed summary: \" + $ggR.ID + \". \" + $ggR.Name + \" | Was: \" + $ggR.Was + \" | Now: \" + $ggR.Now) -Status $(if (Test-GGResultGood $ggR.Now) { \"OK\" } else { \"WARN\" }) } catch {}\n"
        "    }\n",
        count=1, why="F1b: log once")
