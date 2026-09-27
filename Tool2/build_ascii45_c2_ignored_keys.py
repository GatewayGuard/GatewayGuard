"""build_ascii45_c2_ignored_keys -- FT-271: log every key Checkup ignores.

Dated: 2026-09-27 08:03 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block C, item C2.

Bill's ascii44 notes say "B & N do nothing" at screens 26-27. The log could
not confirm or deny it: all three key readers logged only ACCEPTED keys, and
Pause-ForUser's own comment said "Every other key is silently swallowed".
Now each reader logs an ignored key and where it was pressed, so the next
field run can be checked from the log instead of from memory.

Modifier keys (Shift, Ctrl, Alt, Caps Lock, Windows, menu) and Ctrl+C (handled
by Invoke-CtrlCExit) are not logged -- they are not presses of a choice.

Run from Tool2/:  python build_ascii45_c2_ignored_keys.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

HELPER = r'''function Write-GGIgnoredKey {
    # FT-271 (ascii45): the three key readers used to log only ACCEPTED keys,
    # so "B did nothing" (Bill, ascii44 screens 26-27) could not be checked
    # from the log. This writes one KEY line per ignored press.
    param($Key, [string]$Where)
    try {
        if ($Key.VirtualKeyCode -in @(16, 17, 18, 20, 91, 92, 93)) { return }
        if ($Key.Character -eq [char]3) { return }
        $ggCode = [int][char]$Key.Character
        $ggName = if ($ggCode -ge 33 -and $ggCode -le 126) { "'" + $Key.Character.ToString().ToUpper() + "'" } else { "key code " + $Key.VirtualKeyCode }
        Write-Log -Message ("Key " + $ggName + " IGNORED at: " + $Where) -Status "KEY"
    } catch {}
}

function Read-ValidKey {'''

with PS1Edit(TARGET) as e:
    e.replace(
        "#           (battery) value as well as AC, when Windows reports one.\n",
        "#           (battery) value as well as AC, when Windows reports one.\n"
        "#   C2 / FT-271: IGNORED KEYS ARE LOGGED. All three key readers logged\n"
        "#           only accepted keys; now an ignored press is a KEY line too.\n",
        count=1, why="change log: C2")

    e.replace("function Read-ValidKey {", HELPER, count=1, why="add Write-GGIgnoredKey")

    e.replace(
        "            if ($ch -notin $ValidKeys) {\n"
        "                if ($ch -eq \"I\") {\n",
        "            if ($ch -notin $ValidKeys) {\n"
        "                if ($ch -ne \"I\") { Write-GGIgnoredKey -Key $k -Where ((Get-PSCallStack)[1].Command) }\n"
        "                if ($ch -eq \"I\") {\n",
        count=1, why="Read-ValidKey: log ignored")

    e.replace(
        "            # Every other key is silently swallowed, exactly as before.\n",
        "            # FT-271 (ascii45): every other key is still ignored, but now logged.\n"
        "            if (-not ($ggCanBack -and $ggCh -eq \"B\")) { Write-GGIgnoredKey -Key $k -Where ((Get-PSCallStack)[1].Command) }\n",
        count=1, why="Pause-ForUser: log ignored")

    # Read-NavKey: a comment line sits between $ch and the Ctrl+C line, so
    # anchor on the loop's closing condition, which is unique (measured).
    e.replace(
        "        } while (($vk -notin @(13, 32)) -and ($ch -ne \"B\"))\n",
        "            if (($vk -notin @(13, 32)) -and ($ch -ne \"B\")) { Write-GGIgnoredKey -Key $k -Where ((Get-PSCallStack)[1].Command) }\n"
        "        } while (($vk -notin @(13, 32)) -and ($ch -ne \"B\"))\n",
        count=1, why="Read-NavKey: log ignored")
