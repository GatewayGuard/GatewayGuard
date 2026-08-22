"""build_ascii43_f2 -- F2 console width (FT-217 / FT-199).

Write-GGBox measured each $Lines entry with .Length, which is blind to an
embedded newline (the convenience items wrap their prose with `n), and had no
upper bound -- so a 328-char string with a newline in the middle painted a
378-column box into an 86-column window.

Fix: split every entry on its newlines FIRST (so each becomes its own box line
and is measured as one), then clamp each line to the console width, truncating
an over-long line with ".." and logging it rather than ballooning the box.
Reuses the checklist's window measure rather than inventing a second (D-18).

NOTE: the plan also asks for a width check in gate 12b. That gate is static and
cannot know the runtime window width; the runtime clamp here is the actual
protection. A static "source line literal too long" check is a separate
follow-up and is called out in the commit, not silently skipped.

Run from the Tool/ directory:  python build_ascii43_f2.py
"""
from gg_edit import PS1Edit

TARGET = r"W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        '''        [string]$Total = ""
    )
    $Width = 44
    foreach ($line in $Lines) {
        if ($line -ne "---" -and ([string]$line).Length -gt $Width) { $Width = ([string]$line).Length }
    }''',
        '''        [string]$Total = ""
    )
    # FT-217 (ascii43): a $Lines entry can contain an embedded newline -- the
    # convenience items wrap their prose with `n. .Length and PadRight treat
    # such a string as ONE long line, so a 328-char string with a newline in
    # the middle painted a 378-column box into an 86-column window. Split every
    # entry on its newlines FIRST, so each becomes its own box line.
    $ggExpanded = New-Object System.Collections.Generic.List[string]
    foreach ($ggLn in $Lines) {
        if ($ggLn -eq "---") { $ggExpanded.Add("---"); continue }
        foreach ($ggPart in ([string]$ggLn -split "`n")) { $ggExpanded.Add(($ggPart -replace "`r$", "")) }
    }
    $Lines = $ggExpanded.ToArray()
    # FT-217: never paint wider than the window. Reserve the "|..|" frame.
    # Reuse the checklist's window measure (it logs "window 86") rather than
    # inventing a second one (D-18). Truncate an over-long line with ".." and
    # log it, instead of silently ballooning the box.
    $ggWin = 80
    try { if ([Console]::WindowWidth -gt 0) { $ggWin = [Console]::WindowWidth } } catch {}
    $ggMaxContent = $ggWin - 4
    if ($ggMaxContent -lt 16) { $ggMaxContent = 16 }
    for ($ggWi = 0; $ggWi -lt $Lines.Count; $ggWi++) {
        if ($Lines[$ggWi] -ne "---" -and ([string]$Lines[$ggWi]).Length -gt $ggMaxContent) {
            $Lines[$ggWi] = ([string]$Lines[$ggWi]).Substring(0, $ggMaxContent - 2) + ".."
            try { Write-Log -Message ("Write-GGBox: a line was truncated to fit the window (" + $ggWin + " cols) -- FT-217") -Status "WARN" } catch {}
        }
    }
    $Width = 44
    foreach ($line in $Lines) {
        if ($line -ne "---" -and ([string]$line).Length -gt $Width) { $Width = ([string]$line).Length }
    }''',
        count=1,
        why="FT-217: Write-GGBox splits embedded newlines and clamps to window width",
    )
