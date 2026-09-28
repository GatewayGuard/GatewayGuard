"""build_ascii45_F1F2_changed_steps -- Block F: Decision 4 (F1) and the stale
Revert strings (F2).

Dated: 2026-09-28 08:41 ET
Editor: Claude Code (CGDELL)

F1 / Decision 4 (Bill, note 30: "they selected it, don't make them decide
again ... the next step should show all Checkup changed, and the next screen
walk them through the ones needing manual changes"). FT-219 wins over FT-94:
  * Apply-Setting no longer holds 11-15 back -- they apply in the main run
    like every other selected item.
  * Screens 33a/33b (IDs 23, 71, Show-ConvenienceReview) are removed.
  * NEW screen 99 "What Checkup changed": each item run, Was -> Now; anything
    not a success in yellow; for 11-15 the steps to put it back (13, 14, 15
    have no automatic undo -- RegPath $null -- and 11/12 now have none either).
  * NEW screen 100 "Steps for you to do": one manual item per screen. The run
    loop no longer prints the long instructions mid-run (FT-279 note 28).
  * Screen 21 page 2 (ID 75) no longer promises an end-of-run question.
F2: the undo text is guide Part 4, section 4.2, rows 11-15 (Cloud's draft
GatewayGuard_GuideDraft-Part1SafetyNet-Part4-Part5-2026-09-26-1459.md), with
">" written as "->" as everywhere else on Checkup's screens. That fixes 11
("General" -> Recommendations and offers), 12 ("Full" -> Optional diagnostic
data) and 13 (the open-Startup-boost-first step and the full label).
Keys rule (CLAUDE.md, X = Exit): the "Ready to proceed?" prompt still used
Q = Quit. Now X, same Confirm-Exit.

Run from Tool2/:  python build_ascii45_F1F2_changed_steps.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

UNDO = {
    11: "Settings -> Privacy & security -> Recommendations and offers -> turn 'Let apps show me personalized ads by using my advertising ID' back on.",
    12: "Settings -> Privacy & security -> Diagnostics & feedback -> choose 'Optional diagnostic data'.",
    13: "Edge -> Settings -> System and performance -> open 'Startup boost' first -> turn 'Startup boost' and 'Continue running background extensions and apps' back on.",
    14: "Right-click the taskbar -> Taskbar settings -> Widgets On.",
    15: "Edge -> Settings -> Passwords -> 'Offer to save passwords' On. Turning it off never deleted the passwords Edge already had.",
}

NEW_FUNCS = r'''# ============================================================
# WHAT CHECKUP CHANGED + STEPS FOR YOU TO DO (F1 / Decision 4, ascii45)
# Replaces the convenience review (33a/33b). Selecting an item on the
# checklist is the approval (FT-219); this only REPORTS.
# ============================================================
# F2 (ascii45): guide Part 4, section 4.2, rows 11-15 -- the guide's measured
# paths. Checkup has no automatic undo for these, so the steps are shown.
$script:GGUndo = @{
__UNDO__
}

function Add-GGRunResult {
    # One row per item run. A second run of the same item keeps its FIRST
    # "Was", so the summary still shows what the PC had before Checkup.
    param($Setting, [string]$Was, [string]$Now, [string]$Steps = "")
    if ($null -eq $script:GGRunResults) { $script:GGRunResults = [ordered]@{} }
    $ggKey = [string]$Setting.ID
    if ($script:GGRunResults.Contains($ggKey)) { $Was = $script:GGRunResults[$ggKey].Was }
    $script:GGRunResults[$ggKey] = [pscustomobject]@{ ID = [int]$Setting.ID; Name = [string]$Setting.Name; Was = $Was; Now = $Now; Steps = $Steps }
}

function Test-GGResultGood {
    # The run loop's own colour rule (FT-284), in the same order.
    param([string]$Text)
    return (($Text -match "GOOD|enabled|disabled|set to|Already") -and ($Text -notmatch "ERROR|NOTE:|MANUAL|manual|by hand"))
}

function Get-GGRowLines {
    # Screen lines one summary row takes (wrapped at the window width).
    param($Row)
    $ggW = 76
    try { $ggW = [Console]::WindowWidth - 6 } catch {}
    if ($ggW -lt 30) { $ggW = 30 }
    $ggN = 2 + [math]::Ceiling(("Was: " + $Row.Was).Length / $ggW) + [math]::Ceiling(("Now: " + $Row.Now).Length / $ggW)
    if ($script:GGUndo.ContainsKey($Row.ID) -and (Test-GGResultGood $Row.Now) -and ($Row.Now -notmatch "Already")) {
        $ggN += [math]::Ceiling(("To put it back: " + $script:GGUndo[$Row.ID]).Length / $ggW)
    }
    return $ggN
}

function Show-GGChangedSummary {
    if ($null -eq $script:GGRunResults -or $script:GGRunResults.Count -eq 0) { return }
    $ggRows = @($script:GGRunResults.Values)
    # Pages by screen lines, not by a fixed count -- one long result (item 17's
    # by-hand text) can fill most of a screen. 26-line rule: box 7 + 17.
    $ggPages = New-Object System.Collections.Generic.List[object]
    $ggCur = New-Object System.Collections.Generic.List[object]
    $ggUsed = 0
    foreach ($ggR in $ggRows) {
        $ggN = Get-GGRowLines $ggR
        if ($ggCur.Count -gt 0 -and ($ggUsed + $ggN) -gt 17) { $ggPages.Add($ggCur.ToArray()); $ggCur = New-Object System.Collections.Generic.List[object]; $ggUsed = 0 }
        $ggCur.Add($ggR); $ggUsed += $ggN
    }
    if ($ggCur.Count -gt 0) { $ggPages.Add($ggCur.ToArray()) }
    $ggP = 0
    while ($ggP -lt $ggPages.Count) {
        Clear-Host
        Write-Host ""
        Draw-Box -ScreenId "99" -Color White -Lines @(
            ("  WHAT CHECKUP CHANGED   (page " + ($ggP + 1) + " of " + $ggPages.Count + ")"),
            "---",
            "  Each item you selected: what it was, and what it is now.   ",
            "  Anything in yellow did not change -- the next screens show ",
            "  the steps. All of this is also in your log.                "
        )
        Write-Host ""
        foreach ($ggR in $ggPages[$ggP]) {
            $ggGood = Test-GGResultGood $ggR.Now
            Write-Host ("  " + $ggR.ID + ". " + $ggR.Name) -ForegroundColor White
            Write-GGWrapped -Text ("Was: " + $ggR.Was) -Color Gray -Indent 4
            Write-GGWrapped -Text ("Now: " + $ggR.Now) -Color $(if ($ggGood) { "Green" } else { "Yellow" }) -Indent 4
            if ($ggGood -and ($ggR.Now -notmatch "Already") -and $script:GGUndo.ContainsKey($ggR.ID)) {
                Write-GGWrapped -Text ("To put it back: " + $script:GGUndo[$ggR.ID]) -Color DarkCyan -Indent 4
            }
            Write-Host ""
            if ($ggP -eq 0 -or $true) {
                try { Write-Log -Message ("Changed summary: " + $ggR.ID + ". " + $ggR.Name + " | Was: " + $ggR.Was + " | Now: " + $ggR.Now) -Status $(if ($ggGood) { "OK" } else { "WARN" }) } catch {}
            }
        }
        if ($ggP -gt 0) {
            Pause-ForUser "  Press Enter or Space to go on..." -AllowStepBack -BackTo "the previous page"
            if ($script:GGStepBack) { $ggP--; continue }
        } else {
            Pause-ForUser "  Press Enter or Space to go on..."
        }
        $ggP++
    }
}

function Show-GGStepsForYou {
    if ($null -eq $script:GGRunResults) { return }
    $ggSteps = @($script:GGRunResults.Values | Where-Object { $_.Steps })
    if ($ggSteps.Count -eq 0) { return }
    $ggI = 0
    while ($ggI -lt $ggSteps.Count) {
        $ggR = $ggSteps[$ggI]
        Clear-Host
        Write-Host ""
        Draw-Box -ScreenId "100" -Color White -Lines @(
            ("  STEPS FOR YOU TO DO   (" + ($ggI + 1) + " of " + $ggSteps.Count + ")"),
            "---",
            ("  " + $ggR.ID + ". " + $ggR.Name),
            "  Windows does not let Checkup finish this one, so here are  ",
            "  the exact steps to do it yourself.                         "
        )
        Write-Host ""
        Write-GGWrapped -Text $ggR.Steps -Color Yellow
        Write-Log -Message ("Steps for you to do: " + $ggR.ID + ". " + $ggR.Name) -Status "INFO"
        if ($ggI -gt 0) {
            Pause-ForUser "  Press Enter or Space when you have read this..." -AllowStepBack -BackTo "the previous step"
            if ($script:GGStepBack) { $ggI--; continue }
        } else {
            Pause-ForUser "  Press Enter or Space when you have read this..."
        }
        $ggI++
    }
}

'''


def undo_block():
    rows = []
    for k in sorted(UNDO):
        rows.append("    %d = \"%s\"" % (k, UNDO[k].replace('"', '`"')))
    return "\n".join(rows)


with PS1Edit(TARGET) as e:
    e.replace(
        "#           is a NOTE line. No password-manager product is named (CLAUDE.md).\n",
        "#           is a NOTE line. No password-manager product is named (CLAUDE.md).\n"
        "#   F1 (Decision 4): items 11-15 apply in the main run; 33a/33b are gone.\n"
        "#           New screens 99 \"What Checkup changed\" (Was -> Now) and 100\n"
        "#           \"Steps for you to do\". F2: undo steps are guide 4.2 rows 11-15.\n",
        count=1, why="change log: F1/F2")

    # ---------- Apply-Setting: no deferral ----------
    t = e.text
    s = t.index("    # FT-94 (ascii33): convenience items (11-15) are NEVER applied in the\n")
    end = t.index("    $before = $Setting.Status\n", s)
    old = t[s:end]
    assert "Saved for your individual review" in old and old.count("\n") == 10, old
    e.replace(old,
              "    # F1 / Decision 4 (ascii45): the FT-94 hold on 11-15 is gone. Selecting\n"
              "    # an item is the approval (FT-219), so they apply like every other item.\n\n",
              count=1, why="F1: Apply-Setting guard removed")

    # ---------- screen 21 page 2 ----------
    for o, n in [
        ("  CONVENIENCE FEATURES -- YOU WILL BE ASKED AT THE END:            ",
         "  CONVENIENCE FEATURES -- CHANGED ONLY IF YOU SELECT THEM:         "),
        ("  After all settings run, you will review each one individually     ",
         "  Each one you select is changed with the rest. At the end,         "),
        ("  and decide if you want to KEEP the change or REVERT it:          ",
         "  Checkup shows what changed and how to put each one back:      "),
    ]:
        n = n.ljust(len(o))
        assert len(n) == len(o), (o, n)
        e.replace('"' + o + '"', '"' + n + '"', count=1, why="F1: screen 21 page 2")

    # ---------- run loop ----------
    e.replace(
        "                    $finalCheck = Read-ValidKey -ValidKeys @(\"Y\",\"B\",\"Q\") -Prompt \"Ready to proceed? (Y = Start / B = Go back / Q = Quit): \"\n"
        "                    switch ($finalCheck.ToUpper()) {\n"
        "                        \"Q\" { Confirm-Exit; continue checklistLoop }\n",
        "                    # Keys rule (ascii45): X = Exit, not Q.\n"
        "                    $finalCheck = Read-ValidKey -ValidKeys @(\"Y\",\"B\",\"X\") -Prompt \"Ready to proceed? (Y = Start / B = Go back / X = Exit): \"\n"
        "                    switch ($finalCheck.ToUpper()) {\n"
        "                        \"X\" { Confirm-Exit; continue checklistLoop }\n",
        count=1, why="keys: Q -> X")

    e.replace(
        "                                    Write-Host \"  Applying...\" -ForegroundColor Cyan\n"
        "                                    $result = Apply-Setting -Setting $s\n",
        "                                    Write-Host \"  Applying...\" -ForegroundColor Cyan\n"
        "                                    $ggWas = $s.Status\n"
        "                                    $result = Apply-Setting -Setting $s\n"
        "                                    Add-GGRunResult -Setting $s -Was $ggWas -Now $result   # F1\n",
        count=1, why="F1: record GOOD re-apply")

    e.replace(
        "                    if (-not $s.CanAuto) {\n"
        "                        Write-Host \"\"\n"
        "                        Write-Host \"  This one needs you to do it by hand -- Checkup will show you the steps.\" -ForegroundColor Red\n"
        "                        $r = Apply-Setting -Setting $s\n"
        "                        Write-GGWrapped -Text \"INSTRUCTIONS: $r\" -Color Yellow   # FT-279\n"
        "                        Pause-ForUser\n"
        "                        continue\n"
        "                    }\n",
        "                    if (-not $s.CanAuto) {\n"
        "                        # F1 / Decision 4 (ascii45): the steps come one per screen\n"
        "                        # after the run (screen 100), not mid-run.\n"
        "                        $ggWas = $s.Status\n"
        "                        $r = Apply-Setting -Setting $s\n"
        "                        Add-GGRunResult -Setting $s -Was $ggWas -Now \"Not changed -- this one is yours to do; the steps come at the end\" -Steps $r\n"
        "                        Write-Host \"\"\n"
        "                        Write-Host \"  Windows does not let Checkup change this one. The exact steps come at the end.\" -ForegroundColor Yellow\n"
        "                        Pause-ForUser\n"
        "                        continue\n"
        "                    }\n",
        count=1, why="F1: manual items to screen 100")

    e.replace(
        "                    # FT-279 (ascii45): no promise before the outcome is known --\n"
        "                    # 11-15 are put off to their own review and 6 can be blocked.\n"
        "                    Write-Host \"  Working on this item...\" -ForegroundColor Cyan\n"
        "                    $result = Apply-Setting -Setting $s\n"
        "                    $resultColor = if ($result -match \"GOOD|enabled|disabled|set to|Already\") { \"Green\" } elseif ($result -match \"NOTE:|MANUAL|manual\") { \"Yellow\" } elseif ($result -match \"Saved for your individual review\") { \"Cyan\" } else { \"Red\" }\n",
        "                    # FT-279 (ascii45): no promise before the outcome is known --\n"
        "                    # item 6 can be blocked by Tamper Protection.\n"
        "                    Write-Host \"  Working on this item...\" -ForegroundColor Cyan\n"
        "                    $ggWas = $s.Status\n"
        "                    $result = Apply-Setting -Setting $s\n"
        "                    # F1: a by-hand answer from an item Checkup tried is a step too.\n"
        "                    Add-GGRunResult -Setting $s -Was $ggWas -Now $result -Steps $(if ($result -match \"MANUAL|by hand|Manual setup\") { $result } else { \"\" })\n"
        "                    $resultColor = if ($result -match \"GOOD|enabled|disabled|set to|Already\") { \"Green\" } elseif ($result -match \"NOTE:|MANUAL|manual\") { \"Yellow\" } else { \"Red\" }\n",
        count=1, why="F1: record each run result")

    e.replace(
        "                                $item.Status = \"Forced re-apply by user\"\n"
        "                                $result = Apply-Setting -Setting $item\n",
        "                                $ggWas = $item.Status\n"
        "                                $item.Status = \"Forced re-apply by user\"\n"
        "                                $result = Apply-Setting -Setting $item\n"
        "                                Add-GGRunResult -Setting $item -Was $ggWas -Now $result   # F1\n",
        count=1, why="F1: record forced re-apply")

    e.replace(
        "                    \"  See manual steps below for items needing your action.  \"\n",
        "                    \"  Next: what Checkup changed, then any steps for you.    \"\n",
        count=1, why="F1: screen 32 line")
    e.replace(
        "                Setup-ScheduledTasks\n"
        "                Show-ConvenienceReview   # FT-70 (ascii29): was called twice back-to-back -- deduped\n",
        "                Show-GGChangedSummary    # F1 / Decision 4 (ascii45): screen 99\n"
        "                Show-GGStepsForYou       # F1: screen 100, one by-hand item per screen\n"
        "                Setup-ScheduledTasks\n",
        count=1, why="F1: calls")

    # ---------- replace Show-ConvenienceReview ----------
    t = e.text
    s = t.index("# ============================================================\n# CONVENIENCE FEATURES REVIEW (end of run -- option B: one at a time)\n")
    end = t.index("# ============================================================\n# MANUAL STEPS REMINDER\n", s)
    old = t[s:end]
    assert old.count("function Show-ConvenienceReview") == 1 and old.count("\nfunction ") == 1
    e.replace(old, NEW_FUNCS.replace("__UNDO__", undo_block()), count=1, why="F1: new summary functions")

    # ---------- screen table ----------
    e.replace("    \"23\" = \"33a\"          # Convenience review\n", "", count=1, why="table: 23 out")
    e.replace("    \"71\" = \"33b\"          # Convenience review -- result\n", "", count=1, why="table: 71 out")
    e.replace(
        "    \"69\" = \"32\"           # All selected items processed\n",
        "    \"69\" = \"32\"           # All selected items processed\n"
        "    \"99\" = \"32a\"          # What Checkup changed (F1) -- interim label\n"
        "    \"100\" = \"32b\"         # Steps for you to do (F1) -- interim label\n",
        count=1, why="table: 99, 100")
