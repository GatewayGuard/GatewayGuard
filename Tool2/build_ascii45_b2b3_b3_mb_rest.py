"""build_ascii45_b2b3_b3_mb_rest -- the last Malwarebytes wording goes, and
the monthly Malwarebytes reminder task is no longer created -- and is removed
once from PCs that already carry it.

Dated: 2026-09-26 11:23 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block B, items B2 (part b-3) and B3.

  Start screen (Show-FontInstructions): "(Defender + Malwarebytes)" -> "(Defender)".
  Screen 14a (Show-PreScanGate, repeat run): the monthly Malwarebytes bullet removed.
  Screen 14b (Show-PostScanGuidance): "we'll run Malwarebytes next as a second
    opinion" -> write the name down, the guide shows what to do next (guide
    Part 4, approved 2026-09-25, carries the infected-PC steps).
  Screen 34 (Show-ManualSteps): the "Malwarebytes Free" companion item and its
    two-scan walk-through removed; the scan-reminders item no longer mentions
    a monthly Malwarebytes reminder.
  Screen 33 (Setup-ScheduledTasks): item (2) removed from the box.
  B3: Task 2 ("GatewayGuard - Monthly Malwarebytes Reminder") is no longer
    created. New Remove-GGOldMBReminder removes it ONCE where an earlier build
    left it (measured: SANDY got it twice, ascii44 R8 14:43:40 and R9
    18:33:14), plus its helper script, and reads back to confirm. The task
    NAME is an identifier (CLAUDE.md) -- matched exactly, never renamed.
  $AffiliateMalwarebytes: no users left -> definition removed.
KEPT on purpose: "Malwarebytes" in the apps audit's known-publisher list (it
stops an installed copy being flagged as suspicious; never shown on screen),
and the "Malwarebytes" checkpoint name (D2/FT-266 rewrites that list).

Run from Tool2/:  python build_ascii45_b2b3_b3_mb_rest.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"
SRC = open(TARGET, encoding="utf-8-sig").read().replace("\r\n", "\n")


def span(start, end):
    assert SRC.count(start) == 1, (start[:70], SRC.count(start))
    i = SRC.index(start)
    j = SRC.index(end, i + len(start)) + len(end)
    return SRC[i:j]


TASK2 = span("    # --- Task 2: Monthly Malwarebytes Reminder ---\n",
             "        Write-Log -Message \"Scheduled task ERROR: Monthly Malwarebytes Reminder -- $_\" -Status \"ERROR\"\n    }\n")
assert TASK2.count("try {") >= 1 and "foreach ($r in $results)" not in TASK2
MB_ITEM = span("        \"  [ ] Malwarebytes Free  -- Helpful companion for scans.    \",\n",
               "        \"        screen may go dark -- the scan keeps running.       \",\n"
               "        \"                                                            \",\n")
print(f"task-2 block {TASK2.count(chr(10))} lines; screen-34 MB item {MB_ITEM.count(chr(10))} lines")

TASK2_NEW = (
    "    # --- Task 2 REMOVED in ascii45 (B3): the monthly Malwarebytes reminder ---\n"
    "    # Malwarebytes is out of Checkup (Bill 2026-09-08). Earlier builds left the\n"
    "    # task behind; remove it once and say what happened.\n"
    "    $ggOldMB = Remove-GGOldMBReminder\n"
    "    if ($ggOldMB -eq \"REMOVED\") {\n"
    "        $results += @{ Text = \"  [OK] An old monthly reminder from an earlier version was removed\"; Color = \"Green\" }\n"
    "    } elseif ($ggOldMB -like \"FAILED*\") {\n"
    "        $results += @{ Text = \"  [!] An old monthly reminder from an earlier version could not be removed -- see log\"; Color = \"Yellow\" }\n"
    "    }\n"
)

REMOVER = (
    "function Remove-GGOldMBReminder {\n"
    "    # B3 (ascii45): builds up to ascii44 created \"GatewayGuard - Monthly\n"
    "    # Malwarebytes Reminder\" (SANDY got it twice). Malwarebytes is out of\n"
    "    # Checkup, so remove it once, with its helper script, and READ BACK.\n"
    "    # Returns ABSENT (nothing to do), REMOVED (confirmed gone) or FAILED:<why>.\n"
    "    # The name is an identifier (CLAUDE.md) -- matched exactly.\n"
    "    $ggName = \"GatewayGuard - Monthly Malwarebytes Reminder\"\n"
    "    $ggHelper = \"C:\\ProgramData\\GatewayGuard\\MBReminder.ps1\"\n"
    "    try {\n"
    "        $ggT = Get-ScheduledTask -TaskName $ggName -EA SilentlyContinue\n"
    "        if (-not $ggT) {\n"
    "            if (Test-Path $ggHelper) { try { Remove-Item $ggHelper -Force -EA Stop } catch {} }\n"
    "            return \"ABSENT\"\n"
    "        }\n"
    "        Unregister-ScheduledTask -TaskName $ggName -Confirm:$false -EA Stop\n"
    "        if (Get-ScheduledTask -TaskName $ggName -EA SilentlyContinue) {\n"
    "            Write-Log -Message \"Old monthly Malwarebytes reminder: removal ran but the task is still there on read-back\" -Status \"WARN\"\n"
    "            return \"FAILED: still present after removal\"\n"
    "        }\n"
    "        if (Test-Path $ggHelper) { try { Remove-Item $ggHelper -Force -EA Stop } catch {} }\n"
    "        Write-Log -Message \"Old monthly Malwarebytes reminder removed (read back: gone)\" -Status \"GOOD\"\n"
    "        return \"REMOVED\"\n"
    "    } catch {\n"
    "        Write-Log -Message \"Old monthly Malwarebytes reminder: could not remove -- $_\" -Status \"WARN\"\n"
    "        return \"FAILED: $($_.Exception.Message)\"\n"
    "    }\n"
    "}\n\n"
)

with PS1Edit(TARGET, size_tolerance=0.05) as e:
    e.replace(
        "#           deleted (no callers left).\n",
        "#           deleted (no callers left).\n"
        "#   B2b-3:  LAST MALWAREBYTES WORDING GONE: start screen, 14a, 14b, 33, 34.\n"
        "#   B3:     THE MONTHLY MALWAREBYTES REMINDER IS NO LONGER CREATED, and\n"
        "#           Remove-GGOldMBReminder removes it once where an earlier build\n"
        "#           left it (SANDY had it twice), with a read-back.\n",
        count=1, why="change log: B2b-3, B3")
    e.replace(
        "                \"  7. Security scan confirmation (Defender + Malwarebytes)   \",\n",
        "                \"  7. Security scan confirmation (Defender)                  \",\n",
        count=1, why="B2b-3: start screen")
    e.replace(
        "            \"  * Malwarebytes scan -- monthly (Checkup can launch it      \",\n"
        "            \"    for you)                                                 \",\n",
        "", count=1, why="B2b-3: 14a -- no monthly Malwarebytes bullet")
    e.replace(
        "        \"    didn't block it. If you don't recognize it, we'll run    \",\n"
        "        \"    Malwarebytes next as a second opinion.                  \",\n",
        "        \"    didn't block it. If you don't recognize it, write down  \",\n"
        "        \"    its name -- the guide shows what to do next.            \",\n",
        count=1, why="B2b-3: 14b box -- the guide, not Malwarebytes")
    e.replace(
        "        Write-Host \"  We'll continue with Malwarebytes next as a second opinion.\" -ForegroundColor Yellow\n",
        "        Write-Host \"  The guide shows what to do next with it.\" -ForegroundColor Yellow\n",
        count=1, why="B2b-3: 14b follow-up line")
    e.replace(MB_ITEM, "", count=1, why="B2b-3: screen 34 -- Malwarebytes Free item removed")
    e.replace(
        "        \"      quarterly Defender Offline Scan (Jan/Apr/Jul/Oct)     \",\n"
        "        \"      + monthly reminder to run your Malwarebytes scans     \",\n"
        "        \"      (Custom Scan with rootkits, then Deep Scan overnight) \",\n",
        "        \"      quarterly Defender Offline Scan (Jan/Apr/Jul/Oct)     \",\n",
        count=1, why="B2b-3: screen 34 -- scan reminders item")
    e.replace(
        "        \"      you to run it. The scan runs before Windows loads.   \",\n"
        "        \"                                                            \",\n"
        "        \"  (2) Monthly reminder to run your Malwarebytes scans      \",\n"
        "        \"      A popup on the 1st of each month reminding you to    \",\n"
        "        \"      run the Custom Scan (with rootkit checking) and the  \",\n"
        "        \"      Deep Scan. The popup includes the exact steps.       \"\n",
        "        \"      you to run it. The scan runs before Windows loads.   \"\n",
        count=1, why="B2b-3: screen 33 -- item (2) removed")
    e.replace(TASK2, TASK2_NEW, count=1, why="B3: Task 2 no longer created; old one removed once")
    e.replace("function Setup-ScheduledTasks {\n", REMOVER + "function Setup-ScheduledTasks {\n",
              count=1, why="B3: add Remove-GGOldMBReminder")
    e.replace(
        "$AffiliateMalwarebytes = \"https://www.malwarebytes.com/\"            # FT-81: gatewayguard.co redirect deferred; SSL not yet configured\n",
        "", count=1, why="B2b-3: $AffiliateMalwarebytes (no users left)")
print("B2b-3/B3 applied")
