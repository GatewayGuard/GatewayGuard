"""build_ascii45_c3c4c5_back -- B goes back one STEP; L looks back; screen 22
is redrawn in full when you come back to it.

Dated: 2026-09-27 08:08 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block C, items C3 (FT-272 / Decision
1), C4 and C5 (FT-273).

Bill's ascii44 notes 10, 15, 19, 20, 21, 22, 26 and 27 all expect B to mean
"take me back to the previous step so I can change it". On a page, B only
showed a PICTURE of the previous screen, and where no picture was offered it
was swallowed. CLAUDE.md: "B = Back. It is the only Back key."

C3  B = back one step, where the step can be redone:
      20 (apps)       -> 19 (power settings, re-read)
      21 (start)      -> 20 (apps audit, re-read)
      22 (passwords)  -> 21 (start screen)
      23 -> 22, 24 -> 23 (already existed)
      checklist       -> 24
    Where there is no step to go back to, B now SAYS so instead of doing
    nothing: "There is no step to go back to from this screen."
    The signal is a script flag, $script:GGStepBack, never a return value --
    Pause-ForUser has ~78 call sites that do not capture output, and a
    returned string would leak into their callers' results.
C4  The picture replay moves from B to L (measured free, FT-259).
C5  FT-273: B from screen 23 used to drop to a bare "Do you use a password
    manager?" prompt with no box and no number. It now redraws screen 22 in
    full, and 22 offers B = back to the start screen.

Run from Tool2/:  python build_ascii45_c3c4c5_back.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"


def sub(text, old, new, why):
    n = text.count(old)
    assert n == 1, "%s: expected 1, found %d" % (why, n)
    return text.replace(old, new)


with PS1Edit(TARGET) as e:
    e.replace(
        "#           only accepted keys; now an ignored press is a KEY line too.\n",
        "#           only accepted keys; now an ignored press is a KEY line too.\n"
        "#   C3 / FT-272: B GOES BACK ONE STEP (Bill's notes 10,15,19-22,26,27).\n"
        "#           20->19, 21->20, 22->21, checklist->24. Where no step exists, B\n"
        "#           says so. Signalled by $script:GGStepBack, never a return value.\n"
        "#   C4:     L = look at the previous screen (the old B picture replay).\n"
        "#   C5 / FT-273: back to screen 22 redraws it in full, with B to 21.\n",
        count=1, why="change log: C3 C4 C5")

    # ---------------- Pause-ForUser ----------------
    e.replace(
        "        [string]$Message = \"\",\n"
        "        [switch]$NoBack\n"
        "    )\n",
        "        [string]$Message = \"\",\n"
        "        [switch]$NoBack,\n"
        "        # C3 (ascii45): B returns to the caller with $script:GGStepBack set.\n"
        "        [switch]$AllowStepBack,\n"
        "        [string]$BackTo = \"the previous step\"\n"
        "    )\n",
        count=1, why="Pause-ForUser: params")

    e.replace(
        "    Write-Host \"\"\n"
        "    Write-Host $Message -ForegroundColor White\n"
        "    if ($ggCanBack) {\n"
        "        Write-Host \"  Or press B to look back at the previous screen (nothing is undone).\" -ForegroundColor DarkCyan\n"
        "    }\n"
        "    try {\n",
        "    if ($AllowStepBack) { $script:GGStepBack = $false }\n"
        "    $ggNoBackShown = $false\n"
        "    Write-Host \"\"\n"
        "    Write-Host $Message -ForegroundColor White\n"
        "    if ($AllowStepBack) {\n"
        "        Write-Host \"  Or press B to go back to $BackTo.\" -ForegroundColor DarkCyan\n"
        "    }\n"
        "    if ($ggCanBack) {\n"
        "        Write-Host \"  Or press L to look at the previous screen again (nothing is undone).\" -ForegroundColor DarkCyan\n"
        "    }\n"
        "    try {\n",
        count=1, why="Pause-ForUser: prompt lines")

    e.replace(
        "            if ($ggCanBack -and $ggCh -eq \"B\") {\n"
        "                try { Write-Log -Message (\"Look-back opened at: \"",
        "            # C3 (ascii45): B means BACK ONE STEP, and only that.\n"
        "            if ($ggCh -eq \"B\") {\n"
        "                if ($AllowStepBack) {\n"
        "                    $script:GGStepBack = $true\n"
        "                    try { Write-Log -Message (\"Step back (B) accepted at: \" + (Get-PSCallStack)[1].Command) -Status \"KEY\" } catch {}\n"
        "                    Clear-PendingKeys\n"
        "                    return\n"
        "                }\n"
        "                try { Write-Log -Message (\"B pressed where no step back exists, at: \" + (Get-PSCallStack)[1].Command) -Status \"KEY\" } catch {}\n"
        "                if (-not $ggNoBackShown) {\n"
        "                    Write-Host \"  There is no step to go back to from this screen. Press Enter or Space to continue.\" -ForegroundColor Yellow\n"
        "                    $ggNoBackShown = $true\n"
        "                }\n"
        "                continue\n"
        "            }\n"
        "            # C4 (ascii45): the picture replay moved from B to L.\n"
        "            if ($ggCanBack -and $ggCh -eq \"L\") {\n"
        "                try { Write-Log -Message (\"Look-back opened at: \"",
        count=1, why="Pause-ForUser: B = step back, L = look")

    e.replace(
        "                Write-Host \"  Or press B to look back at the previous screen (nothing is undone).\" -ForegroundColor DarkCyan\n"
        "            }\n",
        "                if ($AllowStepBack) { Write-Host \"  Or press B to go back to $BackTo.\" -ForegroundColor DarkCyan }\n"
        "                Write-Host \"  Or press L to look at the previous screen again (nothing is undone).\" -ForegroundColor DarkCyan\n"
        "            }\n",
        count=1, why="Pause-ForUser: re-print after look-back")

    e.replace(
        "if (-not ($ggCanBack -and $ggCh -eq \"B\")) { Write-GGIgnoredKey",
        "if (-not ($ggCanBack -and $ggCh -eq \"L\")) { Write-GGIgnoredKey",
        count=1, why="Pause-ForUser: ignored-key test uses L")

    # ---------------- Show-LookBack ----------------
    e.replace(
        "            Write-Host \"  [B]              Look back one more screen\" -ForegroundColor White\n",
        "            Write-Host \"  [L]              Look back one more screen\" -ForegroundColor White\n",
        count=1, why="Show-LookBack: label L")
    e.replace(
        "            if ($ggC -eq \"B\" -and $ggIdx -gt 0) { $ggDone = $true }\n",
        "            if ($ggC -eq \"L\" -and $ggIdx -gt 0) { $ggDone = $true }\n",
        count=1, why="Show-LookBack: key L")

    # ---------------- Screen 6 (keyboard): item 5 ----------------
    old5 = [
        "                \"  5. GOING BACK: On these setup screens, press B to go back    \",\n",
        "                \"     one screen if you missed something. Later on, Checkup     \",\n",
        "                \"     offers B whenever it can show you the previous screen     \",\n",
        "                \"     exactly as it was. If B is not offered, that screen       \",\n",
        "                \"     cannot be redrawn -- but everything is in your log file.  \",\n",
    ]
    new5 = [
        "  5. GOING BACK: Press B to go back one step and change your   ",
        "     answer. Press L to LOOK at the previous screen again --   ",
        "     nothing is changed. Once Checkup has changed a setting,   ",
        "     that step cannot be reopened, and the screen says so.     ",
        "     Everything is also saved in your log file.                ",
    ]
    for o, n in zip(old5, new5):
        assert len(n) <= len(o.strip().strip('",').rstrip('"')) + 1, n
    e.replace("".join(old5),
              "".join("                \"%s\",\n" % n for n in new5),
              count=1, why="screen 6: B and L explained")

    # ---------------- Screen 21 (start) ----------------
    e.replace(
        "        \"                                                            \",\n"
        "        \"  [X] EXIT -- nothing has been changed                      \",\n",
        "        \"  [B] BACK -- to the apps review                            \",\n"
        "        \"  [X] EXIT -- nothing has been changed                      \",\n",
        count=1, why="screen 21: B line")

    e.replace(
        "        $smChoice = Read-ValidKey -ValidKeys @(\"1\",\"X\") -Prompt \"Enter choice (1 = Start / X = Exit): \"\n"
        "        if ($smChoice -eq \"1\") { return \"1\" }\n",
        "        $smChoice = Read-ValidKey -ValidKeys @(\"1\",\"B\",\"X\") -Prompt \"Enter choice (1 = Start / B = Back / X = Exit): \"\n"
        "        if ($smChoice -eq \"1\") { return \"1\" }\n"
        "        if ($smChoice -eq \"B\") { return \"BACK\" }   # C3 (ascii45): back to the apps review\n",
        count=1, why="Select-Mode: B")

    # ---------------- Screen 20 (apps audit) ----------------
    e.replace(
        "    Pause-ForUser \"  Apps Audit complete. Press Enter or Space to continue...\"\n",
        "    Pause-ForUser \"  Apps Audit complete. Press Enter or Space to continue...\" -AllowStepBack -BackTo \"the power settings review\"\n",
        count=1, why="screen 20: B to 19")

    # ---------------- Main flow: a step loop ----------------
    e.replace(
        "# 14. Power settings review\n"
        "if (-not (Test-CheckpointReached -Checkpoint \"PowerSettings\")) {\n"
        "    Run-PowerSettingsCheck\n"
        "    Save-Checkpoint -Checkpoint \"PowerSettings\"\n"
        "}\n"
        "\n"
        "# 15. Apps audit\n"
        "if (-not (Test-CheckpointReached -Checkpoint \"AppsAudit\")) {\n"
        "    Run-AppsAudit\n"
        "    Save-Checkpoint -Checkpoint \"AppsAudit\"\n"
        "}\n",
        "# C3 (ascii45): screens 19 -> 20 -> 21 -> 22 run as STEPS, so B can go\n"
        "# back one. Everything they do before the checklist is a read or asks\n"
        "# first, so each can be redone. Screen 19 has no step behind it.\n"
        "$ggFlow = \"Power\"\n"
        "if (Test-CheckpointReached -Checkpoint \"PowerSettings\") { $ggFlow = \"Apps\" }\n"
        "if ($ggFlow -eq \"Apps\" -and (Test-CheckpointReached -Checkpoint \"AppsAudit\")) { $ggFlow = \"Mode\" }\n",
        count=1, why="main flow: step start")

    e.replace(
        "$choice = Select-Mode\n"
        "\n"
        "Write-Log -Message \"Start chosen at screen 21 (console checklist)\" -Status \"INFO\"\n"
        "Run-ConsoleMode   # B1 (ascii45): the only mode; Exit is handled inside Select-Mode\n",
        ":ggFlowLoop while ($true) {\n"
        "    $script:GGStepBack = $false\n"
        "    if ($ggFlow -eq \"Power\") {\n"
        "        Run-PowerSettingsCheck\n"
        "        Save-Checkpoint -Checkpoint \"PowerSettings\"\n"
        "        $ggFlow = \"Apps\"\n"
        "        continue ggFlowLoop\n"
        "    }\n"
        "    if ($ggFlow -eq \"Apps\") {\n"
        "        Run-AppsAudit\n"
        "        if ($script:GGStepBack) { $ggFlow = \"Power\"; continue ggFlowLoop }\n"
        "        Save-Checkpoint -Checkpoint \"AppsAudit\"\n"
        "        $ggFlow = \"Mode\"\n"
        "        continue ggFlowLoop\n"
        "    }\n"
        "    $choice = Select-Mode\n"
        "    if ($choice -eq \"BACK\") { $ggFlow = \"Apps\"; continue ggFlowLoop }\n"
        "    Write-Log -Message \"Start chosen at screen 21 (console checklist)\" -Status \"INFO\"\n"
        "    Run-ConsoleMode   # B1 (ascii45): the only mode; Exit is handled inside Select-Mode\n"
        "    if ($script:GGStepBack) { continue ggFlowLoop }   # B at screen 22 -> screen 21\n"
        "    break\n"
        "}\n",
        count=1, why="main flow: step loop")

    # ---------------- Run-ConsoleMode ----------------
    e.replace(
        "    Show-ScopeDisclaimer\n"
        "\n"
        "    :checklistLoop while ($true) {\n",
        "    Show-ScopeDisclaimer\n"
        "    if ($script:GGStepBack) { return }   # C3 (ascii45): B at screen 22 -> screen 21\n"
        "\n"
        "    :checklistLoop while ($true) {\n",
        count=1, why="Run-ConsoleMode: B from 22")

    # checklist B -> 24
    e.replace(
        "        if ($firstCh -in @(\"R\",\"A\",\"C\",\"Q\",\"P\")) {\n",
        "        if ($firstCh -in @(\"R\",\"A\",\"C\",\"Q\",\"P\",\"B\")) {\n",
        count=1, why="checklist: accept B")
    e.replace(
        "        switch ($userInput.ToUpper()) {\n"
        "            \"P\" {",
        "        switch ($userInput.ToUpper()) {\n"
        "            \"B\" {\n"
        "                # C3 (ascii45): back to the page before the checklist.\n"
        "                Show-ScopeDisclaimer -StartPage 2\n"
        "                if ($script:GGStepBack) { return }\n"
        "            }\n"
        "            \"P\" {",
        count=1, why="checklist: B handler")
    e.replace(
        "        Write-Host \"    P = show the other page of the list\" -ForegroundColor Yellow\n",
        "        Write-Host \"    P = show the other page of the list    B = go back one page\" -ForegroundColor Yellow\n",
        count=1, why="checklist: legend B")
    e.replace(
        "Enter command (R/A/C/Q/P or item number 1-19): ",
        "Enter command (R/A/C/Q/P/B or item number 1-19): ",
        count=1, why="checklist: prompt B")
    e.replace(
        "That key does nothing here. Press R, A, C, Q, P, I or an item number 1-19.",
        "That key does nothing here. Press R, A, C, Q, P, B, I or an item number 1-19.",
        count=1, why="checklist: message B")

    # ---------------- Show-ScopeDisclaimer ----------------
    t = e.text
    s = t.index("function Show-ScopeDisclaimer {\n")
    end = t.index("\n}\n", s) + 3
    old = t[s:end]
    new = old
    new = sub(new,
        "    if (-not $global:SleepPrevented) { Enable-SleepPrevention }\n",
        "    # C3 / C5 (ascii45): -StartPage 2 comes from the checklist's B.\n"
        "    param([int]$StartPage = 0)\n"
        "    $script:GGStepBack = $false\n"
        "    $ggSkipQuestion = ($StartPage -eq 2)\n"
        "    $ggReasked = $false\n"
        "    if (-not $global:SleepPrevented) { Enable-SleepPrevention }\n",
        "scope: param")
    new = sub(new,
        "    $ggPMKnown = ($null -ne $global:HasPasswordManager)\n",
        "    :ggScopeTop while ($true) {\n"
        "    if (-not $ggSkipQuestion) {\n"
        "    $ggPMKnown = ($null -ne $global:HasPasswordManager)\n",
        "scope: outer loop")
    new = sub(new,
        "        $ggPMStill = Read-ValidKey -ValidKeys @(\"Y\",\"N\") -Prompt \"Still correct? (Y = yes, continue / N = no, ask me again): \"\n",
        "        $ggPMStill = Read-ValidKey -ValidKeys @(\"Y\",\"N\",\"B\") -Prompt \"Still correct? (Y = yes / N = no, ask me again / B = back to the start screen): \"\n"
        "        if ($ggPMStill -eq \"B\") { $script:GGStepBack = $true; return }\n",
        "scope: 74 B")
    new = sub(new,
        "    $pmAns = Read-ValidKey -ValidKeys @(\"Y\",\"N\") -Prompt \"Do you use a password manager? (Y = yes / N = no): \"\n"
        "    $global:HasPasswordManager = ($pmAns.ToUpper() -eq \"Y\")\n",
        "    $pmAns = Read-ValidKey -ValidKeys @(\"Y\",\"N\",\"B\") -Prompt \"Do you use a password manager? (Y = yes / N = no / B = back to the start screen): \"\n"
        "    if ($pmAns -eq \"B\") { $script:GGStepBack = $true; return }\n"
        "    $global:HasPasswordManager = ($pmAns.ToUpper() -eq \"Y\")\n"
        "    if ($ggReasked) {\n"
        "        $eSetting2 = $Settings | Where-Object { $_.ID -eq 15 }\n"
        "        if ($eSetting2) { $eSetting2.Selected = $global:HasPasswordManager }\n"
        "        Write-Log -Message \"Password-manager answer revised via Back: $($global:HasPasswordManager)\" -Status \"INFO\"\n"
        "    }\n",
        "scope: 53 B")
    new = sub(new,
        "    $ggScopePage = 1\n",
        "    }   # end: skip the question when coming back from the checklist\n"
        "    $ggScopePage = if ($ggSkipQuestion) { 2 } else { 1 }\n"
        "    $ggSkipQuestion = $false\n",
        "scope: start page")
    # page 1 Back: the old bare re-ask becomes a full redraw of screen 22
    i = new.index("            if ($ggScopeNav -eq \"BACK\") {\n")
    j = new.index("                $ggScopePage = 2\n", i)
    blk = new[i:j]
    assert "Password-manager answer revised via Back" in blk and "Read-ValidKey" in blk, "page1 back block"
    new = new[:i] + (
        "            if ($ggScopeNav -eq \"BACK\") {\n"
        "                # FT-273 (ascii45): this used to re-ask with a bare prompt --\n"
        "                # no box, no number, no Back. Now screen 22 is shown in full.\n"
        "                $global:HasPasswordManager = $null\n"
        "                $ggReasked = $true\n"
        "                continue ggScopeTop\n"
        "            } else {\n") + new[j:]
    new = sub(new,
        "            if ($ggScopeNav -eq \"BACK\") { $ggScopePage = 1 } else { break }\n",
        "            if ($ggScopeNav -eq \"BACK\") { $ggScopePage = 1 } else { return }\n",
        "scope: page 2 exits")
    assert new.endswith("\n}\n")
    new = new[:-2] + "    }   # end :ggScopeTop (C3)\n}\n"
    e.replace(old, new, count=1, why="Show-ScopeDisclaimer: steps and FT-273")
