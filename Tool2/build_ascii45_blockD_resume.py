"""build_ascii45_blockD_resume -- Block D: resume lands where the user was.

Dated: 2026-09-27 08:20 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block D, items D1-D5.

D1 FT-265  Screens 10 (edition) and 11 (RAM) replayed on every resume --
           Get-WinEdition and Get-RAMStatus ran with no checkpoint test. On
           resume they now read the values silently (both are needed later).
D2 FT-266  CheckpointOrder still listed "Malwarebytes" (gone since B2), and
           "OfflineScanDone" was never saved. It is now saved when the pre-scan
           gate completes.
D3 FT-267  A finished run left its checkpoint behind, so the next run offered
           to "resume" a finished run (R9 resumed from AppsAudit after R8
           finished). Cleared at the end of a completed run.
D4 Decision 2  "Still YOUR personal computer?" is skipped on resume when the
           saved Machine ID matches this PC; asked when it does not (or when an
           older state file has none). $StateDir is C:\GatewayGuard (measured
           09-25), not OneDrive.
D5 Decision 3  New checkpoints: ModeChosen (after Start at 21), Scope (after the
           password question, 22) and Checklist (with the selections, which
           lived only in memory -- FT-204). Resume goes straight to 22, 23 or
           the checklist. 1b now says where Checkup will continue.

Run from Tool2/:  python build_ascii45_blockD_resume.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"


def in_function(e, name, edits):
    """Apply (old, new, why) edits inside one function only, each exactly once."""
    t = e.text
    s = t.index("function %s {\n" % name)
    end = t.index("\n}\n", s) + 3
    old = t[s:end]
    new = old
    for o, n, why in edits:
        c = new.count(o)
        assert c == 1, "%s / %s: expected 1, found %d" % (name, why, c)
        new = new.replace(o, n)
    e.replace(old, new, count=1, why="%s: %s" % (name, "; ".join(w for _, _, w in edits)))


with PS1Edit(TARGET) as e:
    e.replace(
        "#           themselves.\n",
        "#           themselves.\n"
        "#   D1 / FT-265: RESUME NO LONGER REPLAYS SCREENS 10 AND 11 (read silently).\n"
        "#   D2 / FT-266: checkpoint order fixed; OfflineScanDone is now saved.\n"
        "#   D3 / FT-267: a finished run clears its checkpoint.\n"
        "#   D4 / Decision 2: \"Still YOUR personal computer?\" skipped on resume when\n"
        "#           the saved Machine ID matches.\n"
        "#   D5 / Decision 3: checkpoints at 21, 22/23 and the checklist, with the\n"
        "#           selections saved; 1b says where Checkup will continue.\n",
        count=1, why="change log: Block D")

    # ---------- D1 ----------
    in_function(e, "Get-WinEdition", [
        ("function Get-WinEdition {\n    try {\n",
         "function Get-WinEdition {\n"
         "    param([switch]$Quiet)   # D1 / FT-265 (ascii45): on resume, read but do not show\n"
         "    try {\n", "Quiet param"),
        ("    if ($isHome) {\n        Clear-Host\n",
         "    if ($Quiet) {\n"
         "        Write-Log -Message \"Edition screen not shown -- resuming (FT-265)\" -Status \"INFO\"\n"
         "    } elseif ($isHome) {\n        Clear-Host\n", "skip screen"),
    ])
    in_function(e, "Get-RAMStatus", [
        ("function Get-RAMStatus {\n    try {\n",
         "function Get-RAMStatus {\n"
         "    param([switch]$Quiet)   # D1 / FT-265 (ascii45): on resume, read but do not show\n"
         "    try {\n", "Quiet param"),
        ("        if ($global:RAMGB -le 8) {\n",
         "        if ($Quiet) {\n"
         "            Write-Log -Message \"RAM: $($global:RAMGB) GB -- screen not shown, resuming (FT-265)\" -Status \"INFO\"\n"
         "        } elseif ($global:RAMGB -le 8) {\n", "skip screen"),
    ])
    e.replace(
        "Get-WinEdition\n\n# 7. RAM check\nGet-RAMStatus\n",
        "Get-WinEdition -Quiet:([bool]$global:ResumeFrom)   # D1 / FT-265\n\n"
        "# 7. RAM check\n"
        "Get-RAMStatus -Quiet:([bool]$global:ResumeFrom)    # D1 / FT-265\n",
        count=1, why="D1: quiet on resume")

    # ---------- D2 + D5: the order ----------
    e.replace(
        "    \"OfflineScanDone\",\n"
        "    \"Malwarebytes\",\n"
        "    \"DefenderAV\",\n"
        "    \"PowerSettings\",\n"
        "    \"AppsAudit\"\n"
        ")\n",
        "    \"OfflineScanDone\",\n"
        "    \"DefenderAV\",\n"
        "    \"PowerSettings\",\n"
        "    \"AppsAudit\",\n"
        "    # D5 / Decision 3 (ascii45): resume can land at 22, 23 or the checklist.\n"
        "    \"ModeChosen\",\n"
        "    \"Scope\",\n"
        "    \"Checklist\"\n"
        ")\n",
        count=1, why="D2/D5: checkpoint order")

    # ---------- Save-Checkpoint: Machine ID and selections ----------
    in_function(e, "Save-Checkpoint", [
        ("    param([Parameter(Mandatory)][string]$Checkpoint)\n",
         "    param([Parameter(Mandatory)][string]$Checkpoint, [switch]$NoLog)\n", "NoLog param"),
        ("    ($ggState -join \"`r`n\") | Out-File",
         "    # D4 (ascii45): the Machine ID, so resume can skip \"Still YOUR PC?\".\n"
         "    if ($global:MachineID) { $ggState += (\"MID=\" + $global:MachineID) }\n"
         "    # D5 (ascii45): the checklist selections (they lived only in memory, FT-204).\n"
         "    if ($Checkpoint -eq \"Checklist\") {\n"
         "        $ggState += (\"SEL=\" + ((@($Settings | Where-Object { $_.Selected } | ForEach-Object { $_.ID })) -join \",\"))\n"
         "    }\n"
         "    ($ggState -join \"`r`n\") | Out-File", "MID and SEL"),
        ("    Write-Log -Message \"Checkpoint saved: $Checkpoint\" -Status \"STATE\"\n",
         "    if (-not $NoLog) { Write-Log -Message \"Checkpoint saved: $Checkpoint\" -Status \"STATE\" }\n", "NoLog"),
    ])
    in_function(e, "Restore-SessionAnswers", [
        ("            if ($ggLine -match '^\\s*OD=N\\s*$') {\n",
         "            if ($ggLine -match '^\\s*MID=(\\S+)\\s*$') { $global:GGSavedMachineID = $Matches[1] }   # D4\n"
         "            if ($ggLine -match '^\\s*SEL=([0-9,]*)\\s*$') {   # D5\n"
         "                $global:GGSavedSelections = @($Matches[1] -split \",\" | Where-Object { $_ -ne \"\" } | ForEach-Object { [int]$_ })\n"
         "                Write-Log -Message (\"Restored saved checklist selections: \" + ($global:GGSavedSelections -join \",\")) -Status \"STATE\"\n"
         "            }\n"
         "            if ($ggLine -match '^\\s*OD=N\\s*$') {\n", "MID and SEL"),
    ])

    # ---------- D4 + 1b "continue at" ----------
    in_function(e, "Show-ResumeReverify", [
        ("        \"  Because you're resuming, we re-verify the basics on this   \",\n"
         "        \"  ONE screen instead of replaying each earlier screen:       \",\n"
         "        \"  your personal-PC answer, Administrator access, and         \",\n"
         "        \"  power/battery state.                                       \"\n"
         "    )\n",
         "        \"  Because you're resuming, we re-verify the basics on this   \",\n"
         "        \"  ONE screen instead of replaying each earlier screen:       \",\n"
         "        \"  that this is the same computer, Administrator access, and  \",\n"
         "        \"  power/battery state.                                       \",\n"
         "        \"                                                             \",\n"
         "        (\"  Checkup will continue at: \" + (Get-GGResumeTarget))\n"
         "    )\n", "box: continue-at line"),
        ("    $rc = Read-ValidKey -ValidKeys @(\"Y\",\"X\") -Prompt \"Still YOUR personal computer? (Y = Yes / X = Exit): \"\n",
         "    # D4 / Decision 2 (ascii45): skip the question when this is the same PC.\n"
         "    if ($global:GGSavedMachineID -and $global:GGSavedMachineID -eq $global:MachineID) {\n"
         "        $rc = \"Y\"\n"
         "        Write-Host \"  OK  Same computer as before (Machine ID matches).\" -ForegroundColor Green\n"
         "        Write-Log -Message \"Resume re-check: Machine ID matches the saved one -- personal-PC question skipped (Decision 2)\" -Status \"CONFIRM\"\n"
         "    } else {\n"
         "        $rc = Read-ValidKey -ValidKeys @(\"Y\",\"X\") -Prompt \"Still YOUR personal computer? (Y = Yes / X = Exit): \"\n"
         "    }\n", "Machine ID check"),
    ])
    e.replace(
        "function Show-ResumeReverify {\n",
        "function Get-GGResumeTarget {\n"
        "    # D5 (ascii45): where a resumed run continues, in words, with the screen\n"
        "    # number from the table (never typed -- FT-172) where it is certain.\n"
        "    $ggMap = @{\n"
        "        \"Baseline\"           = @(\"the security tools overview\", \"26\")\n"
        "        \"Briefing\"           = @(\"getting ready for the scan\", \"\")\n"
        "        \"PreScanPrep\"        = @(\"getting ready for the scan\", \"\")\n"
        "        \"OfflineScanPending\" = @(\"your offline scan results\", \"40\")\n"
        "        \"OfflineScanDone\"    = @(\"the antivirus check\", \"\")\n"
        "        \"DefenderAV\"         = @(\"the power settings review\", \"\")\n"
        "        \"PowerSettings\"      = @(\"the apps review\", \"51\")\n"
        "        \"AppsAudit\"          = @(\"the start screen\", \"52\")\n"
        "        \"ModeChosen\"         = @(\"the password question\", \"\")\n"
        "        \"Scope\"              = @(\"what Checkup does and does not do\", \"54\")\n"
        "        \"Checklist\"          = @(\"the security checklist\", \"76\")\n"
        "    }\n"
        "    $ggT = $ggMap[[string]$global:ResumeFrom]\n"
        "    if ($null -eq $ggT) { return \"where you left off\" }\n"
        "    $ggN = \"\"\n"
        "    if ($ggT[1] -and $script:GGScreenLabels.ContainsKey($ggT[1])) { $ggN = \" (screen \" + $script:GGScreenLabels[$ggT[1]] + \")\" }\n"
        "    return ($ggT[0] + $ggN)\n"
        "}\n"
        "\n"
        "function Show-ResumeReverify {\n",
        count=1, why="D5: Get-GGResumeTarget")

    # ---------- D2: OfflineScanDone saved ----------
    e.replace(
        "if (-not (Test-CheckpointReached -Checkpoint \"OfflineScanDone\")) {\n"
        "    Show-PreScanGate\n"
        "}\n",
        "if (-not (Test-CheckpointReached -Checkpoint \"OfflineScanDone\")) {\n"
        "    Show-PreScanGate\n"
        "    Save-Checkpoint -Checkpoint \"OfflineScanDone\"   # D2 / FT-266: was never saved\n"
        "}\n",
        count=1, why="D2: save OfflineScanDone")

    # ---------- D5: main step loop ----------
    e.replace(
        "if ($ggFlow -eq \"Apps\" -and (Test-CheckpointReached -Checkpoint \"AppsAudit\")) { $ggFlow = \"Mode\" }\n",
        "if ($ggFlow -eq \"Apps\" -and (Test-CheckpointReached -Checkpoint \"AppsAudit\")) { $ggFlow = \"Mode\" }\n"
        "if ($ggFlow -eq \"Mode\" -and (Test-CheckpointReached -Checkpoint \"ModeChosen\")) { $ggFlow = \"Console\" }   # D5\n",
        count=1, why="D5: resume past 21")
    e.replace(
        "    $choice = Select-Mode\n"
        "    if ($choice -eq \"BACK\") { $ggFlow = \"Apps\"; continue ggFlowLoop }\n"
        "    Write-Log -Message \"Start chosen at screen 21 (console checklist)\" -Status \"INFO\"\n"
        "    Run-ConsoleMode   # B1 (ascii45): the only mode; Exit is handled inside Select-Mode\n"
        "    if ($script:GGStepBack) { continue ggFlowLoop }   # B at screen 22 -> screen 21\n",
        "    if ($ggFlow -eq \"Mode\") {\n"
        "        $choice = Select-Mode\n"
        "        if ($choice -eq \"BACK\") { $ggFlow = \"Apps\"; continue ggFlowLoop }\n"
        "        Write-Log -Message \"Start chosen at screen 21 (console checklist)\" -Status \"INFO\"\n"
        "        Save-Checkpoint -Checkpoint \"ModeChosen\"   # D5\n"
        "    }\n"
        "    Run-ConsoleMode   # B1 (ascii45): the only mode; Exit is handled inside Select-Mode\n"
        "    if ($script:GGStepBack) { $ggFlow = \"Mode\"; continue ggFlowLoop }   # B at screen 22 -> screen 21\n",
        count=1, why="D5: ModeChosen checkpoint")

    # ---------- D5: Run-ConsoleMode resume target ----------
    e.replace(
        "    Show-ScopeDisclaimer\n"
        "    if ($script:GGStepBack) { return }   # C3 (ascii45): B at screen 22 -> screen 21\n",
        "    # D5 / Decision 3 (ascii45): a resumed run goes straight to where it was,\n"
        "    # once. Going Back and coming forward again shows the normal screens.\n"
        "    $ggResumeAt = \"\"\n"
        "    if (-not $script:GGResumeConsumed) {\n"
        "        if (Test-CheckpointReached -Checkpoint \"Checklist\") { $ggResumeAt = \"Checklist\" }\n"
        "        elseif (Test-CheckpointReached -Checkpoint \"Scope\") { $ggResumeAt = \"Scope\" }\n"
        "        $script:GGResumeConsumed = $true\n"
        "    }\n"
        "    if ($ggResumeAt -eq \"Checklist\") {\n"
        "        if ($null -ne $global:GGSavedSelections) {\n"
        "            foreach ($ggS in $Settings) { $ggS.Selected = ($ggS.ID -in $global:GGSavedSelections) }\n"
        "            Write-Log -Message (\"Resume: checklist selections restored: \" + ($global:GGSavedSelections -join \",\")) -Status \"STATE\"\n"
        "        }\n"
        "        Write-Log -Message \"Resume: straight to the checklist (Decision 3)\" -Status \"STATE\"\n"
        "    } else {\n"
        "        Show-ScopeDisclaimer -StartPage $(if ($ggResumeAt -eq \"Scope\") { 1 } else { 0 })\n"
        "        if ($script:GGStepBack) { return }   # C3 (ascii45): B at screen 22 -> screen 21\n"
        "    }\n",
        count=1, why="D5: Run-ConsoleMode resume")
    e.replace(
        "    :checklistLoop while ($true) {\n",
        "    :checklistLoop while ($true) {\n"
        "        Save-Checkpoint -Checkpoint \"Checklist\" -NoLog   # D5: selections survive a restart\n",
        count=1, why="D5: checklist checkpoint")

    # ---------- D5: Show-ScopeDisclaimer ----------
    in_function(e, "Show-ScopeDisclaimer", [
        ("    # C3 / C5 (ascii45): -StartPage 2 comes from the checklist's B.\n",
         "    # C3 / C5 (ascii45): -StartPage 2 comes from the checklist's B.\n"
         "    # D5 (ascii45): -StartPage 1 is a resume that already answered 22.\n", "comment"),
        ("    $ggSkipQuestion = ($StartPage -eq 2)\n",
         "    $ggSkipQuestion = ($StartPage -ge 1)\n", "skip question on 1 or 2"),
        ("    $ggScopePage = if ($ggSkipQuestion) { 2 } else { 1 }\n",
         "    if (-not $ggSkipQuestion) { Save-Checkpoint -Checkpoint \"Scope\" }   # D5\n"
         "    $ggScopePage = if ($ggSkipQuestion -and $StartPage -eq 2) { 2 } else { 1 }\n", "start page + checkpoint"),
    ])

    # ---------- D3 ----------
    e.replace(
        "                Set-FirstRunComplete\n"
        "                # FT-119 (ascii34): \"Press Enter or Space to exit...\" is used\n",
        "                Set-FirstRunComplete\n"
        "                Clear-Checkpoint   # D3 / FT-267: a finished run leaves nothing to resume\n"
        "                Write-Log -Message \"Run complete -- checkpoint cleared (FT-267)\" -Status \"STATE\"\n"
        "                # FT-119 (ascii34): \"Press Enter or Space to exit...\" is used\n",
        count=1, why="D3: clear on completion")
