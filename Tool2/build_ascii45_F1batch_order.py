"""build_ascii45_F1batch_order -- Block F, batch 1: Bill's start order, shown as
it happens (F12/FT-290, F20/FT-298), the checklist order (F18/FT-296), and
screen 7's list (F11).

Dated: 2026-09-28 08:10 ET
Editor: Claude Code (CGDELL)
Bill, 2026-09-28: "build block F and the renumber pass".

Bill's CGDELL runs 2026-09-27/28 (logs in Test_Results\\TestRun-ascii45-*):
  "fix order - tamper protection first, VP on second, app blocking 3rd, then
  windows update" -- Tamper WAS read first but silently (log 18:22:16); the
  antivirus check ran only after the scans, as an unnumbered page (FT-298).
  "Scr 25 - change order 1. tamper 2. defender 3. windows updates".
  Screen 7 still listed the ascii44 checks (F11).

New order: Tamper -> virus protection (Test-DefenderPrimary) -> unwanted-app
blocking -> Windows Update -> virus definitions -> 14g summary -> scans.
Screen 97 shows the results so far and what is being checked now. The healthy
antivirus result no longer has its own unnumbered page. Checkpoints follow the
order ("DefenderAV" moves up; "PUA" is new). The checklist sorts 3, 2, 1 first
-- display only; item NUMBERS never change (CLAUDE.md).

Run from Tool2/:  python build_ascii45_F1batch_order.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

PROGRESS_FN = r'''function Show-GGStartProgress {
    # F12 / FT-290 (ascii45): Bill -- "did not check tamper protection first".
    # It did, silently. This screen shows each result as it arrives, in order,
    # and what is being checked now.
    param([string]$Now = "")
    Clear-Host
    Write-Host ""
    $ggL = @("  CHECKING YOUR PC'S PROTECTION -- ONE STEP AT A TIME        ", "---")
    if ($null -ne $script:GGReady) { foreach ($ggK in $script:GGReady.Keys) { $ggL += [string]$script:GGReady[$ggK] } }
    if ($Now) { $ggL += ("  ...   Now checking: " + $Now) }
    $ggL += @("                                                             ",
              "  Nothing is changed without asking you first.               ")
    Draw-Box -ScreenId "97" -Color White -Lines $ggL
    Write-Host ""
}

function Show-GGReadySummary {'''

with PS1Edit(TARGET) as e:
    e.replace(
        "#           its own state and gets screen 96 -- no command, no new key.\n",
        "#           its own state and gets screen 96 -- no command, no new key.\n"
        "#   F12/F20 (FT-290, FT-298): BILL'S START ORDER, SHOWN AS IT HAPPENS --\n"
        "#           Tamper, virus protection, unwanted-app blocking, Windows Update,\n"
        "#           definitions; screen 97 shows each result; antivirus on 14g.\n"
        "#   F18 (FT-296): checklist shows Tamper, Defender, Windows Update first\n"
        "#           (display only). F11: screen 7 lists the new order.\n",
        count=1, why="change log: batch 1")

    # ---- checkpoints follow the order ----
    e.replace(
        "    \"Tamper\",\n"
        "    \"WinUpdatePending\",\n"
        "    \"WinUpdate\",\n"
        "    \"Defs\",\n"
        "    \"PreScanPrep\",\n"
        "    \"OfflineScanPending\",\n"
        "    \"OfflineScanDone\",\n"
        "    \"DefenderAV\",\n"
        "    \"PowerSettings\",\n",
        "    \"Tamper\",\n"
        "    \"DefenderAV\",        # F12 (ascii45): moved up -- Bill's order\n"
        "    \"PUA\",               # F12 (ascii45): app blocking before Windows Update\n"
        "    \"WinUpdatePending\",\n"
        "    \"WinUpdate\",\n"
        "    \"Defs\",\n"
        "    \"PreScanPrep\",\n"
        "    \"OfflineScanPending\",\n"
        "    \"OfflineScanDone\",\n"
        "    \"PowerSettings\",\n",
        count=1, why="checkpoint order")
    e.replace(
        "        \"Tamper\"             = @(\"the Windows Update check\", \"\")\n"
        "        \"WinUpdatePending\"   = @(\"the Windows Update check, after the restart\", \"\")\n"
        "        \"WinUpdate\"          = @(\"unwanted app blocking\", \"\")\n"
        "        \"Defs\"               = @(\"getting ready for the scan\", \"\")\n",
        "        \"Tamper\"             = @(\"the virus protection check\", \"\")\n"
        "        \"PUA\"                = @(\"the Windows Update check\", \"\")\n"
        "        \"WinUpdatePending\"   = @(\"the Windows Update check, after the restart\", \"\")\n"
        "        \"WinUpdate\"          = @(\"the virus definitions check\", \"\")\n"
        "        \"Defs\"               = @(\"getting ready for the scan\", \"\")\n",
        count=1, why="resume targets 1")
    e.replace(
        "        \"OfflineScanDone\"    = @(\"the antivirus check\", \"\")\n"
        "        \"DefenderAV\"         = @(\"the power settings review\", \"\")\n",
        "        \"OfflineScanDone\"    = @(\"the power settings review\", \"\")\n"
        "        \"DefenderAV\"         = @(\"unwanted app blocking\", \"\")\n",
        count=1, why="resume targets 2")

    # ---- the main flow ----
    e.replace(
        "$script:GGReady = [ordered]@{}\n"
        "if (-not (Test-CheckpointReached -Checkpoint \"Tamper\")) {\n"
        "    Show-TamperCheck\n"
        "    Save-Checkpoint -Checkpoint \"Tamper\"\n"
        "}\n"
        "if (-not (Test-CheckpointReached -Checkpoint \"WinUpdate\")) {\n"
        "    Invoke-WindowsUpdateLoop   # saves WinUpdate / WinUpdatePending itself\n"
        "}\n"
        "if (-not (Test-CheckpointReached -Checkpoint \"Defs\")) {\n"
        "    Invoke-PUACheck\n"
        "    Update-GGSignaturesIfStale\n"
        "    Save-Checkpoint -Checkpoint \"Defs\"\n"
        "}\n"
        "Show-GGReadySummary\n",
        "# F12 (ascii45) -- Bill's order: Tamper, virus protection, app blocking,\n"
        "# Windows Update, definitions. Screen 97 shows each result as it arrives.\n"
        "$script:GGReady = [ordered]@{}\n"
        "if (-not (Test-CheckpointReached -Checkpoint \"Tamper\")) {\n"
        "    Show-GGStartProgress -Now \"Tamper Protection\"\n"
        "    Show-TamperCheck\n"
        "    Save-Checkpoint -Checkpoint \"Tamper\"\n"
        "}\n"
        "if (-not (Test-CheckpointReached -Checkpoint \"DefenderAV\")) {\n"
        "    Show-GGStartProgress -Now \"virus protection (Microsoft Defender)\"\n"
        "    Test-DefenderPrimary\n"
        "    if (-not $script:GGReady.Contains(\"AV\")) { Add-GGReady \"AV\" \"  NOTE  Virus protection needs your attention -- see the screen before this one.\" }\n"
        "    Save-Checkpoint -Checkpoint \"DefenderAV\"\n"
        "}\n"
        "if (-not (Test-CheckpointReached -Checkpoint \"PUA\")) {\n"
        "    Show-GGStartProgress -Now \"unwanted app blocking\"\n"
        "    Invoke-PUACheck\n"
        "    Save-Checkpoint -Checkpoint \"PUA\"\n"
        "}\n"
        "if (-not (Test-CheckpointReached -Checkpoint \"WinUpdate\")) {\n"
        "    Invoke-WindowsUpdateLoop   # saves WinUpdate / WinUpdatePending itself\n"
        "}\n"
        "if (-not (Test-CheckpointReached -Checkpoint \"Defs\")) {\n"
        "    Show-GGStartProgress -Now \"virus definitions\"\n"
        "    Update-GGSignaturesIfStale\n"
        "    Save-Checkpoint -Checkpoint \"Defs\"\n"
        "}\n"
        "Show-GGReadySummary\n",
        count=1, why="main flow: Bill's order")
    e.replace(
        "# 12. Defender primary AV check -- MOVED BEFORE Malwarebytes (D-06,\n"
        "# ascii33): confirm Defender is your active antivirus first, then add\n"
        "# the companion scanner. Was after MB through ascii32.\n"
        "if (-not (Test-CheckpointReached -Checkpoint \"DefenderAV\")) {\n"
        "    Test-DefenderPrimary\n"
        "    Save-Checkpoint -Checkpoint \"DefenderAV\"\n"
        "}\n",
        "# 12. (F12, ascii45: the antivirus check moved into the start sequence,\n"
        "# second after Tamper Protection -- Bill's order.)\n",
        count=1, why="main flow: old antivirus position removed")

    # ---- the healthy antivirus result: no unnumbered page ----
    e.replace(
        "                Write-Host \"  OK  Microsoft Defender is active as primary AV.\" -ForegroundColor Green\n"
        "                Write-Log -Message \"Defender confirmed as primary AV\" -Status \"OK\"\n"
        "                Pause-ForUser\n",
        "                # F20 / FT-298 (ascii45): was an unnumbered page with a pause;\n"
        "                # the result now shows on screen 97 and on 14g.\n"
        "                Add-GGReady \"AV\" \"  OK    Virus protection (Microsoft Defender) is on.\"\n"
        "                Write-Log -Message \"Defender confirmed as primary AV\" -Status \"OK\"\n",
        count=1, why="healthy antivirus: no unnumbered page")
    e.replace(
        "                Write-Log -Message \"Defender active as primary AV. Also registered (not in charge): $ggAlso\" -Status \"OK\"\n",
        "                Write-Log -Message \"Defender active as primary AV. Also registered (not in charge): $ggAlso\" -Status \"OK\"\n"
        "                Add-GGReady \"AV\" (\"  OK    Virus protection (Microsoft Defender) is on. \" + $ggAlso + \" is also installed, not in charge.\")\n",
        count=1, why="antivirus with another registered: summary line")

    e.replace("function Show-GGReadySummary {", PROGRESS_FN, count=1, why="screen 97 function")
    e.replace(
        "    \"94\" = \"14g\"          # Before the scan -- what Checkup checked -- interim\n",
        "    \"97\" = \"14h\"          # Checking your PC's protection, step by step (F12) -- interim\n"
        "    \"94\" = \"14g\"          # Before the scan -- what Checkup checked -- interim\n",
        count=1, why="table: 97")

    # ---- F18: checklist order (display only) ----
    e.replace(
        "        $ggPageItems = if ($script:ChecklistPage -eq 1) { $Settings | Where-Object { $_.ID -le 10 } } else { $Settings | Where-Object { $_.ID -ge 11 } }\n",
        "        $ggPageItems = if ($script:ChecklistPage -eq 1) { $Settings | Where-Object { $_.ID -le 10 } } else { $Settings | Where-Object { $_.ID -ge 11 } }\n"
        "        # F18 / FT-296 (ascii45): Bill -- \"1. tamper 2. defender 3. windows updates\".\n"
        "        # Display order only: the item NUMBERS never change (logs name items by ID).\n"
        "        $ggPageItems = @($ggPageItems | Sort-Object { switch ([int]$_.ID) { 3 { 1 } 2 { 2 } 1 { 3 } default { [int]$_.ID + 10 } } })\n",
        count=1, why="F18: checklist display order")

    # ---- F11: screen 7 ----
    old7 = [
        "  Checkup runs a series of quick checks before reaching     ",
        "  the main security settings. Some screens appear briefly   ",
        "  and move on automatically -- this is normal.              ",
        "                                                             ",
        "  PRE-FLIGHT CHECKS (you will see these in order):          ",
        "  1. Personal computer confirmation                          ",
        "  2. Domain / corporate network check                       ",
        "  3. Administrator access check                             ",
        "  4. Windows edition detection (Home vs Pro)                ",
        "  5. RAM check                                              ",
        "  6. First-run vs returning user check                      ",
        "  7. Security scan confirmation (Defender)                  ",
        "  8. Antivirus detection and status                         ",
        "  9. Battery / power status check                           ",
        " 10. Power settings (optional)                              ",
        " 11. Apps audit (installed apps review)                     ",
        "                                                             ",
        "  Screens that require your input will PAUSE and wait.      ",
        "  Quick status confirmations (green OK messages) will show  ",
        "  briefly and move on -- nothing is skipped silently.       ",
        "                                                             ",
        "  After all checks pass, you reach the main security        ",
        "  settings checklist where YOU control what gets changed.   ",
    ]
    new7 = [
        "  Checkup runs some quick checks before the main security   ",
        "  settings. Anything that needs you will PAUSE and wait.    ",
        "                                                             ",
        "  GETTING READY:                                             ",
        "  1. Personal computer confirmation                          ",
        "  2. Work or school network check                            ",
        "  3. Administrator access check                              ",
        "  4. Windows edition (Home or Pro) and memory                ",
        "                                                             ",
        "  PROTECTION CHECKS, in this order:                          ",
        "  5. Tamper Protection                                       ",
        "  6. Virus protection (Microsoft Defender)                   ",
        "  7. Unwanted app blocking                                   ",
        "  8. Windows Update -- installs updates with your OK         ",
        "  9. Virus definitions                                       ",
        " 10. Scans: the offline scan and a full scan, if you want    ",
        "                                                             ",
        "  THEN: power settings, the apps review, and the security   ",
        "  settings checklist, where YOU choose what gets changed.   ",
        "                                                             ",
        "  Green OK messages move on by themselves -- nothing is     ",
        "  skipped silently, and everything is saved in your log.    ",
        "                                                             ",
    ]
    assert len(old7) == len(new7), (len(old7), len(new7))
    ind = "                "
    old_txt = "".join('%s"%s",\n' % (ind, o) for o in old7[:-1]) + '%s"%s"\n' % (ind, old7[-1])
    new_txt = "".join('%s"%s",\n' % (ind, n) for n in new7[:-1]) + '%s"%s"\n' % (ind, new7[-1])
    e.replace(old_txt, new_txt, count=1, why="F11: screen 7 list")
