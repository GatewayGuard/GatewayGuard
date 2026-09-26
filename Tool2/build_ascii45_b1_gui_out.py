"""build_ascii45_b1_gui_out -- GUI mode is removed; screen 21 is "1 = Start,
X = Exit", and Exit asks first.

Dated: 2026-09-26 11:12 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block B, item B1 (Decision 5).

WHY: GUI mode had seven measured defects in its first field run (FT-280:
footer mid-run, convenience review never ran, item 6 steps sent to a hidden
console, bad statuses in green, clipped text, "No changes will be saved" after
changes were saved, no way back) and was labelled "Recommended for first time
users" with nothing behind it. Bill's decision 2026-09-25: remove it for
launch. FT-280 becomes moot.

ALSO: option [3] EXIT on this screen exited with NO confirmation, against the
"no accidental exits" rule. X (Bill 2026-09-25, "use X") now goes through the
existing Confirm-Exit (FT-171d); answering N returns to this screen.

Run-GUIMode (331 lines of Windows Forms, no Draw-Box screens -- gate 12 is not
affected) is cut between exact markers, each asserted to occur once.

Run from Tool2/:  python build_ascii45_b1_gui_out.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

src = open(TARGET, encoding="utf-8-sig").read().replace("\r\n", "\n")
START = "# ============================================================\n# GUI MODE  (Garamond font throughout)\n"
END = "    $form.ShowDialog() | Out-Null\n}\n\n"
assert src.count(START) == 1, src.count(START)
assert src.count(END) == 1, src.count(END)
i, j = src.index(START), src.index(END) + len(END)
assert j > i
gui_block = src[i:j]
assert gui_block.count("\nfunction ") == 1 and "function Run-GUIMode {" in gui_block
print(f"GUI block: {gui_block.count(chr(10))} lines")

with PS1Edit(TARGET, size_tolerance=0.05) as e:
    e.replace(
        "#           ERROR (FT-245).\n",
        "#           ERROR (FT-245).\n"
        "#   B1:     GUI MODE REMOVED (Decision 5, Bill 2026-09-25). Seven measured\n"
        "#           defects in its first field run (FT-280, now moot). Screen 21\n"
        "#           reads [1] START / [X] EXIT; X asks first (Confirm-Exit) -- the\n"
        "#           old [3] EXIT left with no confirmation.\n",
        count=1,
        why="change log: B1",
    )
    e.replace(gui_block, "", count=1, why="B1: delete Run-GUIMode (331 lines)")
    e.replace(
        "        \"  SELECT A MODE:                                            \",\n"
        "        \"                                                            \",\n"
        "        \"  [1] CONSOLE MODE                                          \",\n"
        "        \"      Text-based checklist in this window. Shows each       \",\n"
        "        \"      setting and its live status, and changes only the     \",\n"
        "        \"      items you select. Fast and fully transparent.         \",\n"
        "        \"                                                            \",\n"
        "        \"  [2] GUI MODE                                              \",\n"
        "        \"      Opens a visual window with checkboxes and color-coded \",\n"
        "        \"      status indicators. Recommended for first time users.  \",\n"
        "        \"                                                            \",\n"
        "        \"  [3] EXIT                                                  \",\n",
        "        \"  WHAT HAPPENS NEXT:                                        \",\n"
        "        \"                                                            \",\n"
        "        \"  [1] START                                                 \",\n"
        "        \"      A checklist in this window shows each setting and     \",\n"
        "        \"      its live status. Checkup changes only the items you   \",\n"
        "        \"      select.                                               \",\n"
        "        \"                                                            \",\n"
        "        \"  [X] EXIT -- nothing has been changed                      \",\n",
        count=1,
        why="B1: screen 21 -- one Start option and X = Exit",
    )
    e.replace(
        "function Select-Mode {\n"
        "    Show-ModeSelector\n"
        "    do {\n"
        "        $smChoice = Read-ValidKey -ValidKeys @(\"1\",\"2\",\"3\") -Prompt \"Enter choice (1, 2, or 3): \"\n"
        "    } while ($smChoice -notin \"1\",\"2\",\"3\")\n"
        "    return $smChoice\n"
        "}\n",
        "function Select-Mode {\n"
        "    # B1 (ascii45): GUI mode removed. X = Exit (Bill 2026-09-25) and it asks\n"
        "    # first -- Confirm-Exit exits on Y; on N we show this screen again.\n"
        "    while ($true) {\n"
        "        Show-ModeSelector\n"
        "        $smChoice = Read-ValidKey -ValidKeys @(\"1\",\"X\") -Prompt \"Enter choice (1 = Start / X = Exit): \"\n"
        "        if ($smChoice -eq \"1\") { return \"1\" }\n"
        "        Confirm-Exit \"You chose Exit at the start screen. Checkup has not changed anything.\"\n"
        "    }\n"
        "}\n",
        count=1,
        why="B1: Select-Mode -- 1 or X, X confirms",
    )
    e.replace(
        "Write-Log -Message \"Mode selected: $(if ($choice -eq '1') { 'Console' } elseif ($choice -eq '2') { 'GUI' } else { 'Exit' })\" -Status \"INFO\"\n"
        "\n"
        "switch ($choice) {\n"
        "    \"1\" { Run-ConsoleMode }\n"
        "    \"2\" { Run-GUIMode }\n"
        "    \"3\" {\n"
        "        Write-Host \"\"\n"
        "        Write-Host \"  Exiting. No changes made.\" -ForegroundColor Gray\n"
        "        Write-Host \"\"\n"
        "        Write-Log -Message \"User exited at mode selection\" -Status \"EXIT\"\n"
        "        Disable-SleepPrevention\n"
        "        Save-Log\n"
        "        exit\n"
        "    }\n"
        "}\n",
        "Write-Log -Message \"Start chosen at screen 21 (console checklist)\" -Status \"INFO\"\n"
        "Run-ConsoleMode   # B1 (ascii45): the only mode; Exit is handled inside Select-Mode\n",
        count=1,
        why="B1: main flow runs the console checklist",
    )
    e.replace(
        "# Then: mode selection -> Run-ConsoleMode or Run-GUIMode\n",
        "# Then: start screen -> Run-ConsoleMode (GUI mode removed in ascii45, B1)\n",
        count=1,
        why="B1: entry-point comment",
    )
    e.replace(
        "# PRE-BUILD AUDIT: Verify all 15 required functions are present\n",
        "# PRE-BUILD AUDIT: Verify all 14 required functions are present\n",
        count=1,
        why="B1: audit comment count",
    )
    e.replace(
        "#     'Run-ConsoleMode','Run-GUIMode','Show-BitLockerScreen','Write-Log',\n",
        "#     'Run-ConsoleMode','Show-BitLockerScreen','Write-Log',\n",
        count=1,
        why="B1: audit comment list",
    )
print("B1 applied")
