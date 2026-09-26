"""build_ascii45_c1_x_exit -- X means Exit, at every prompt where N used to
exit; and every one of those exits now asks first.

Dated: 2026-09-26 11:27 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block C, item C1.

Bill, 2026-09-25: "use X." CLAUDE.md, THE KEYS MEAN ONE THING EACH: after
this, N means No and nothing else, B means Back, X means Exit.

MEASURED 2026-09-26 on the ascii45 source: NINE prompts where N ends Checkup
(the 08-30 count of 11 included the Malwarebytes screens and the old [3] EXIT,
both removed in Block B). Found by reading what each N branch DOES, not only
its label -- three of them never said "Exit" ("Fix first then re-run", "Fix
Defender first", "Plug in and relaunch").

SEVEN of the nine exited on a single keypress with no confirmation, against
the standing "no accidental exits" rule. They now print their own advice,
then call Confirm-Exit (FT-171d); answering N there returns to the same
prompt (each sits in a do/while that re-asks until Y).
TWO already confirmed and keep their own confirmation:
  - the resume question (screen 83, Y = close / B = go back) -- key N -> X;
  - the pre-scan gate, whose E/R confirm becomes X = Exit / B = Back.

Run from Tool2/:  python build_ascii45_c1_x_exit.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "#           left it (SANDY had it twice), with a read-back.\n",
        "#           left it (SANDY had it twice), with a read-back.\n"
        "#   C1:     X = EXIT (Bill 2026-09-25). The nine prompts where N ended\n"
        "#           Checkup now use X; N means No and nothing else. Seven of them\n"
        "#           exited on one keypress -- they now ask first (Confirm-Exit).\n",
        count=1, why="change log: C1")

    # 1. Test-PersonalComputer
    e.replace(
        "        $confirm = Read-ValidKey -ValidKeys @(\"Y\",\"N\") -Prompt \"Is this YOUR personal computer? (Y = Yes / N = Exit): \"\n"
        "        if ($confirm.ToUpper() -eq \"N\") {\n"
        "            Write-Host \"\"\n"
        "            Write-Host \"  Exiting. No changes made.\" -ForegroundColor Yellow\n"
        "            Write-Host \"  To secure a company PC, contact your IT department.\" -ForegroundColor Gray\n"
        "            Write-Host \"\"\n"
        "            Write-Log -Message \"User confirmed not personal PC -- exit\" -Status \"EXIT\"\n"
        "            Save-Log\n"
        "            exit\n"
        "        }\n",
        "        $confirm = Read-ValidKey -ValidKeys @(\"Y\",\"X\") -Prompt \"Is this YOUR personal computer? (Y = Yes / X = Exit): \"\n"
        "        if ($confirm.ToUpper() -eq \"X\") {\n"
        "            # C1 (ascii45): X = Exit, and it asks first (was one keypress).\n"
        "            Write-Host \"\"\n"
        "            Write-Host \"  To secure a company PC, contact your IT department.\" -ForegroundColor Gray\n"
        "            Write-Log -Message \"User chose Exit: not a personal PC\" -Status \"INFO\"\n"
        "            Confirm-Exit \"Checkup has not changed anything.\"\n"
        "        }\n",
        count=1, why="C1: personal-PC question")
    # 2. Test-DomainJoin
    e.replace(
        "                $confirm = Read-ValidKey -ValidKeys @(\"Y\",\"N\") -Prompt \"Continue? (Y = This is my personal PC / N = Exit): \"\n"
        "                if ($confirm.ToUpper() -eq \"N\") {\n"
        "                    Write-Host \"\"\n"
        "                    Write-Host \"  Exiting. No changes made.\" -ForegroundColor Yellow\n"
        "                    Save-Log; exit\n"
        "                }\n",
        "                $confirm = Read-ValidKey -ValidKeys @(\"Y\",\"X\") -Prompt \"Continue? (Y = This is my personal PC / X = Exit): \"\n"
        "                if ($confirm.ToUpper() -eq \"X\") {\n"
        "                    # C1 (ascii45): X = Exit, and it asks first.\n"
        "                    Write-Log -Message \"User chose Exit: domain-joined PC\" -Status \"INFO\"\n"
        "                    Confirm-Exit \"Checkup has not changed anything.\"\n"
        "                }\n",
        count=1, why="C1: domain-joined question")
    # 3. Resume re-check (already confirmed)
    e.replace(
        "    $rc = Read-ValidKey -ValidKeys @(\"Y\",\"N\") -Prompt \"Still YOUR personal computer? (Y = Yes / N = Exit): \"\n"
        "    if ($rc.ToUpper() -eq \"N\") {\n",
        "    $rc = Read-ValidKey -ValidKeys @(\"Y\",\"X\") -Prompt \"Still YOUR personal computer? (Y = Yes / X = Exit): \"\n"
        "    if ($rc.ToUpper() -eq \"X\") {   # C1 (ascii45): X = Exit; screen 83 still confirms\n",
        count=1, why="C1: resume question (keeps screen 83)")
    # 4. Pre-scan gate (already confirmed)
    e.replace(
        "            Write-Host \"  N = Not ready yet -- exit Checkup so you can prepare first\" -ForegroundColor DarkGray\n",
        "            Write-Host \"  X = Not ready yet -- exit Checkup so you can prepare first\" -ForegroundColor DarkGray\n",
        count=1, why="C1: pre-scan legend")
    e.replace(
        "            $ready = Read-ValidKey -ValidKeys @(\"Y\",\"N\",\"S\") -Prompt \"Your choice (Y = Scan now / S = Skip scan / N = Exit to prepare): \"\n"
        "            if ($ready.ToUpper() -eq \"N\") {\n"
        "                Write-Host \"\"\n"
        "                Write-Host \"  N exits Checkup so you can close programs and get ready.\" -ForegroundColor Yellow\n",
        "            $ready = Read-ValidKey -ValidKeys @(\"Y\",\"X\",\"S\") -Prompt \"Your choice (Y = Scan now / S = Skip scan / X = Exit to prepare): \"\n"
        "            if ($ready.ToUpper() -eq \"X\") {\n"
        "                Write-Host \"\"\n"
        "                Write-Host \"  X exits Checkup so you can close programs and get ready.\" -ForegroundColor Yellow\n",
        count=1, why="C1: pre-scan gate key")
    e.replace(
        "                $exitConfirm = Read-ValidKey -ValidKeys @(\"E\",\"R\") -Prompt \"Confirm: (E = Exit the tool / R = Return to the question above): \"\n"
        "                if ($exitConfirm.ToUpper() -ne \"E\") {\n",
        "                # C1 (ascii45): X = Exit and B = Back, the keys' one meaning each.\n"
        "                $exitConfirm = Read-ValidKey -ValidKeys @(\"X\",\"B\") -Prompt \"Confirm: (X = Exit the tool / B = Back to the question above): \"\n"
        "                if ($exitConfirm.ToUpper() -ne \"X\") {\n",
        count=1, why="C1: pre-scan confirm uses X / B")
    # 5. Repeat-run continue
    e.replace(
        "            $cont = Read-ValidKey -ValidKeys @(\"Y\",\"N\") -Prompt \"Continue with Checkup? (Y = Continue / N = Exit): \"\n"
        "            if ($cont.ToUpper() -eq \"N\") { Save-Log; exit }\n",
        "            $cont = Read-ValidKey -ValidKeys @(\"Y\",\"X\") -Prompt \"Continue with Checkup? (Y = Continue / X = Exit): \"\n"
        "            if ($cont.ToUpper() -eq \"X\") { Confirm-Exit \"Checkup has not changed anything yet.\" }   # C1 (ascii45)\n",
        count=1, why="C1: repeat-run continue")
    # 6. High-risk AV
    e.replace(
        "                $cont = Read-ValidKey -ValidKeys @(\"Y\",\"N\") -Prompt \"Continue anyway? (Y = Continue / N = Exit to uninstall first): \"\n"
        "                if ($cont.ToUpper() -eq \"N\") {\n"
        "                    Write-Host \"\"\n"
        "                    Write-Host \"  Uninstall $riskyName, then relaunch Checkup.\" -ForegroundColor Yellow\n"
        "                    Disable-SleepPrevention; Save-Log; exit\n"
        "                }\n",
        "                $cont = Read-ValidKey -ValidKeys @(\"Y\",\"X\") -Prompt \"Continue anyway? (Y = Continue / X = Exit to uninstall first): \"\n"
        "                if ($cont.ToUpper() -eq \"X\") {\n"
        "                    # C1 (ascii45): X = Exit, and it asks first.\n"
        "                    Write-Host \"\"\n"
        "                    Write-Host \"  Uninstall $riskyName, then relaunch Checkup.\" -ForegroundColor Yellow\n"
        "                    Write-Log -Message \"User chose Exit to uninstall first: $riskyName\" -Status \"INFO\"\n"
        "                    Confirm-Exit\n"
        "                }\n",
        count=1, why="C1: high-risk AV")
    # 7. Another AV in charge
    e.replace(
        "                $cont = Read-ValidKey -ValidKeys @(\"Y\",\"N\") -Prompt \"Continue anyway? (Y = Continue / N = Fix first then re-run): \"\n"
        "                if ($cont.ToUpper() -eq \"N\") {\n"
        "                    Write-Host \"  Fix Defender status and relaunch the tool.\" -ForegroundColor Yellow\n"
        "                    Write-Log -Message \"Exited -- non-Defender AV active: $avName\" -Status \"WARN\"\n"
        "                    Disable-SleepPrevention; Save-Log; exit\n"
        "                }\n",
        "                $cont = Read-ValidKey -ValidKeys @(\"Y\",\"X\") -Prompt \"Continue anyway? (Y = Continue / X = Exit to fix it first): \"\n"
        "                if ($cont.ToUpper() -eq \"X\") {\n"
        "                    # C1 (ascii45): this N always exited; now X, and it asks first.\n"
        "                    Write-Host \"  Fix Defender status and relaunch the tool.\" -ForegroundColor Yellow\n"
        "                    Write-Log -Message \"User chose Exit to fix first -- non-Defender AV active: $avName\" -Status \"WARN\"\n"
        "                    Confirm-Exit\n"
        "                }\n",
        count=1, why="C1: another AV in charge")
    # 8. Defender off
    e.replace(
        "                $cont = Read-ValidKey -ValidKeys @(\"Y\",\"N\") -Prompt \"Continue anyway? (Y = Continue / N = Fix Defender first): \"\n"
        "                if ($cont.ToUpper() -eq \"N\") {\n"
        "                    Write-Host \"  Enable Defender real-time protection, then relaunch.\" -ForegroundColor Yellow\n"
        "                    Write-Log -Message \"Exited -- Defender real-time protection is OFF\" -Status \"WARN\"\n"
        "                    Disable-SleepPrevention; Save-Log; exit\n"
        "                }\n",
        "                $cont = Read-ValidKey -ValidKeys @(\"Y\",\"X\") -Prompt \"Continue anyway? (Y = Continue / X = Exit to fix Defender first): \"\n"
        "                if ($cont.ToUpper() -eq \"X\") {\n"
        "                    # C1 (ascii45): this N always exited; now X, and it asks first.\n"
        "                    Write-Host \"  Turn on Defender real-time protection, then relaunch.\" -ForegroundColor Yellow\n"
        "                    Write-Log -Message \"User chose Exit to fix first -- Defender real-time protection is OFF\" -Status \"WARN\"\n"
        "                    Confirm-Exit\n"
        "                }\n",
        count=1, why="C1: Defender off")
    # 9. On battery
    e.replace(
        "            $cont = Read-ValidKey -ValidKeys @(\"Y\",\"N\") -Prompt \"Continue on battery? (Y = Continue / N = Plug in and relaunch): \"\n"
        "            if ($cont.ToUpper() -eq \"N\") {\n"
        "                Write-Host \"\"\n"
        "                Write-Host \"  Plug in AC power and relaunch the tool.\" -ForegroundColor Yellow\n"
        "                Disable-SleepPrevention; Save-Log; exit\n"
        "            }\n",
        "            $cont = Read-ValidKey -ValidKeys @(\"Y\",\"X\") -Prompt \"Continue on battery? (Y = Continue / X = Exit to plug in first): \"\n"
        "            if ($cont.ToUpper() -eq \"X\") {\n"
        "                # C1 (ascii45): this N always exited; now X, and it asks first.\n"
        "                Write-Host \"\"\n"
        "                Write-Host \"  Plug in AC power and relaunch the tool.\" -ForegroundColor Yellow\n"
        "                Write-Log -Message \"User chose Exit to plug in first\" -Status \"INFO\"\n"
        "                Confirm-Exit\n"
        "            }\n",
        count=1, why="C1: on battery")
print("C1 applied")
