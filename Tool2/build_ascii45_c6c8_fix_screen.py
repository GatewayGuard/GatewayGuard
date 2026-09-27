"""build_ascii45_c6c8_fix_screen -- F fixes the screen (C6, FT-259), redrawn
from the screen's stored TEXT (C8), not from a picture.

Dated: 2026-09-27 08:11 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block C, items C6 and C8.

Bill, 2026-09-07: "one key that resets the screen". SANDY opened at 60
columns and every resume screen was truncated (ascii44 triage, section F).
A picture of the screen (the look-back snapshot) cannot help after a resize
-- Restore-ScreenSnapshot refuses when the width changed. So:

C8  Draw-Box keeps the last box's TEXT in $script:GGLastBox. Get-ScreenNumber
    clears it first, so a hand-drawn screen (76, 77, 85, 86, 87 -- they call
    Get-ScreenNumber but not Draw-Box) never redraws the box before it.
C6  F at every reader: Invoke-GGFixScreen clears the window, measures width
    and height again, redraws the stored box at the new size, and shows it in
    parts when it is taller than the window. The intro screens and the
    checklist redraw themselves instead (their loops already draw from code).

Run from Tool2/:  python build_ascii45_c6c8_fix_screen.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

FIX_FN = r'''function Invoke-GGFixScreen {
    # C6 / FT-259 (ascii45). Bill 2026-09-07: "one key that resets the screen".
    # Clears the window, measures it again (width AND height), and redraws the
    # current screen's box from its stored TEXT (C8) -- so it works after a
    # resize, where the look-back picture cannot. A box taller than the window
    # is shown in parts. Returns $true when it redrew, $false when this screen
    # has no stored box.
    try { Write-Log -Message ("F (fix the screen) at: " + (Get-PSCallStack)[1].Command) -Status "KEY" } catch {}
    $ggB = $script:GGLastBox
    if ($null -eq $ggB) {
        Write-Host ""
        Write-Host "  This screen cannot be redrawn. Everything on it is in your log file." -ForegroundColor Yellow
        return $false
    }
    Clear-Host
    $ggH = 30
    try { if ([Console]::WindowHeight -gt 0) { $ggH = [Console]::WindowHeight } } catch {}
    $ggRoom = $ggH - 6          # borders, the part line and the prompt
    if ($ggRoom -lt 8) { $ggRoom = 8 }
    $ggAll = @($ggB.Lines)
    if ($ggAll.Count -le $ggRoom) {
        $null = Write-GGBox -Lines $ggAll -Color $ggB.Color -TextColor $ggB.TextColor -Number $ggB.Number
    } else {
        $ggParts = [int][math]::Ceiling($ggAll.Count / $ggRoom)
        for ($ggP = 0; $ggP -lt $ggParts; $ggP++) {
            $ggSlice = @($ggAll | Select-Object -Skip ($ggP * $ggRoom) -First $ggRoom)
            $ggNum = if ($ggB.Number) { "$($ggB.Number), part $($ggP + 1) of $ggParts" } else { "" }
            $null = Write-GGBox -Lines $ggSlice -Color $ggB.Color -TextColor $ggB.TextColor -Number $ggNum
            if ($ggP -lt $ggParts - 1) {
                Write-Host "  This screen is taller than your window. Press Enter or Space for the rest..." -ForegroundColor White
                try {
                    do {
                        try { [Console]::TreatControlCAsInput = $true } catch {}
                        $ggK = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
                    } while ($ggK.VirtualKeyCode -notin @(13, 32))
                } catch { $null = Read-Host }
                Clear-Host
            }
        }
    }
    Write-Host "  (Screen redrawn to fit your window.)" -ForegroundColor DarkGray
    return $true
}

function Draw-Box {'''

with PS1Edit(TARGET) as e:
    e.replace(
        "#   C5 / FT-273: back to screen 22 redraws it in full, with B to 21.\n",
        "#   C5 / FT-273: back to screen 22 redraws it in full, with B to 21.\n"
        "#   C6 / C8 (FT-259): F FIXES THE SCREEN. Draw-Box keeps the box's text;\n"
        "#           F clears, re-measures width and height, redraws it (in parts\n"
        "#           if taller than the window). Intro and checklist redraw\n"
        "#           themselves.\n",
        count=1, why="change log: C6 C8")

    # C8: store the text
    e.replace(
        "function Get-ScreenNumber {\n"
        "    param([string]$ScreenId)\n",
        "function Get-ScreenNumber {\n"
        "    param([string]$ScreenId)\n"
        "    # C8 (ascii45): a new screen starts; Draw-Box stores its text after this.\n"
        "    $script:GGLastBox = $null\n",
        count=1, why="C8: clear stored box per screen")
    e.replace(
        "    Write-GGBox -Lines $Lines -Color $Color -TextColor $TextColor -Number $ggNum\n",
        "    Write-GGBox -Lines $Lines -Color $Color -TextColor $TextColor -Number $ggNum\n"
        "    $script:GGLastBox = @{ Lines = $Lines; Color = $Color; TextColor = $TextColor; Number = $ggNum }   # C8\n",
        count=1, why="C8: store the box text")
    e.replace("function Draw-Box {", FIX_FN, count=1, why="C6: Invoke-GGFixScreen")

    # Read-ValidKey
    e.replace(
        "                if ($ch -ne \"I\") { Write-GGIgnoredKey -Key $k -Where ((Get-PSCallStack)[1].Command) }\n"
        "                if ($ch -eq \"I\") {\n",
        "                if ($ch -ne \"I\" -and $ch -ne \"F\") { Write-GGIgnoredKey -Key $k -Where ((Get-PSCallStack)[1].Command) }\n"
        "                if ($ch -eq \"F\") {\n"
        "                    $null = Invoke-GGFixScreen   # C6 (ascii45)\n"
        "                    Write-Host \"\"\n"
        "                    if ($Prompt) { Write-Host \"  $Prompt\" -ForegroundColor White -NoNewline }\n"
        "                    continue\n"
        "                }\n"
        "                if ($ch -eq \"I\") {\n",
        count=1, why="Read-ValidKey: F")
    e.replace(
        "Write-Host \"  Press I at any time to see your build and Machine ID.\"",
        "Write-Host \"  Press I at any time to see your build and Machine ID, or F to fix the screen.\"",
        count=1, why="Read-ValidKey: hint F")

    # Pause-ForUser
    e.replace(
        "        [string]$BackTo = \"the previous step\"\n"
        "    )\n",
        "        [string]$BackTo = \"the previous step\",\n"
        "        # C6 (ascii45): F returns with $script:GGRedraw set, for callers that\n"
        "        # draw the screen themselves (the intro screens).\n"
        "        [switch]$AllowRedraw\n"
        "    )\n",
        count=1, why="Pause-ForUser: AllowRedraw param")
    e.replace(
        "    if ($AllowStepBack) { $script:GGStepBack = $false }\n"
        "    $ggNoBackShown = $false\n",
        "    if ($AllowStepBack) { $script:GGStepBack = $false }\n"
        "    if ($AllowRedraw) { $script:GGRedraw = $false }\n"
        "    $ggNoBackShown = $false\n",
        count=1, why="Pause-ForUser: reset redraw flag")
    e.replace(
        "            # C3 (ascii45): B means BACK ONE STEP, and only that.\n"
        "            if ($ggCh -eq \"B\") {\n",
        "            # C6 (ascii45): F fixes the screen.\n"
        "            if ($ggCh -eq \"F\") {\n"
        "                if ($AllowRedraw) {\n"
        "                    $script:GGRedraw = $true\n"
        "                    try { Write-Log -Message (\"F (redraw) at: \" + (Get-PSCallStack)[1].Command) -Status \"KEY\" } catch {}\n"
        "                    Clear-PendingKeys\n"
        "                    return\n"
        "                }\n"
        "                $null = Invoke-GGFixScreen\n"
        "                Write-Host \"\"\n"
        "                Write-Host $Message -ForegroundColor White\n"
        "                if ($AllowStepBack) { Write-Host \"  Or press B to go back to $BackTo.\" -ForegroundColor DarkCyan }\n"
        "                continue\n"
        "            }\n"
        "            # C3 (ascii45): B means BACK ONE STEP, and only that.\n"
        "            if ($ggCh -eq \"B\") {\n",
        count=1, why="Pause-ForUser: F")

    # Read-NavKey
    e.replace(
        "function Read-NavKey {\n"
        "    param([string]$Prompt = \"  Press Enter or Space to continue, or B to go back one screen: \")\n",
        "function Read-NavKey {\n"
        "    param(\n"
        "        [string]$Prompt = \"  Press Enter or Space to continue, or B to go back one screen: \",\n"
        "        [switch]$AllowRedraw   # C6 (ascii45): F returns \"REDRAW\" to a caller that draws its own screen\n"
        "    )\n",
        count=1, why="Read-NavKey: AllowRedraw param")
    e.replace(
        "            if (($vk -notin @(13, 32)) -and ($ch -ne \"B\")) { Write-GGIgnoredKey -Key $k -Where ((Get-PSCallStack)[1].Command) }\n"
        "        } while (($vk -notin @(13, 32)) -and ($ch -ne \"B\"))\n",
        "            if ($ch -eq \"F\") {\n"
        "                if ($AllowRedraw) {\n"
        "                    try { Write-Log -Message (\"F (redraw) at: \" + (Get-PSCallStack)[1].Command) -Status \"KEY\" } catch {}\n"
        "                    Clear-PendingKeys\n"
        "                    return \"REDRAW\"\n"
        "                }\n"
        "                $null = Invoke-GGFixScreen   # C6 (ascii45)\n"
        "                if ($Prompt) { Write-Host $Prompt -ForegroundColor White }\n"
        "                continue\n"
        "            }\n"
        "            if (($vk -notin @(13, 32)) -and ($ch -ne \"B\")) { Write-GGIgnoredKey -Key $k -Where ((Get-PSCallStack)[1].Command) }\n"
        "        } while (($vk -notin @(13, 32)) -and ($ch -ne \"B\"))\n",
        count=1, why="Read-NavKey: F")

    # Intro loop: screens redraw themselves
    e.replace(
        "        if ($screenIdx -eq 0) {\n"
        "            Pause-ForUser \"  Press Enter or Space to continue...\"\n"
        "            $screenIdx++\n"
        "        } else {\n"
        "            $nav = Read-NavKey\n"
        "            if ($nav -eq \"BACK\") { $screenIdx-- } else { $screenIdx++ }\n"
        "        }\n",
        "        if ($screenIdx -eq 0) {\n"
        "            Pause-ForUser \"  Press Enter or Space to continue...\" -AllowRedraw\n"
        "            if ($script:GGRedraw) { continue }   # C6: F redraws at the new size\n"
        "            $screenIdx++\n"
        "        } else {\n"
        "            $nav = Read-NavKey -AllowRedraw\n"
        "            if ($nav -eq \"REDRAW\") { continue }   # C6: F redraws at the new size\n"
        "            if ($nav -eq \"BACK\") { $screenIdx-- } else { $screenIdx++ }\n"
        "        }\n",
        count=1, why="intro: F redraws")

    # Checklist
    e.replace(
        "        if ($firstCh -in @(\"R\",\"A\",\"C\",\"Q\",\"P\",\"B\")) {\n",
        "        if ($firstCh -eq \"F\") {\n"
        "            try { Write-Log -Message \"F (fix the screen) at: checklist\" -Status \"KEY\" } catch {}\n"
        "            continue checklistLoop   # C6 (ascii45): the checklist redraws at the new size\n"
        "        }\n"
        "        if ($firstCh -in @(\"R\",\"A\",\"C\",\"Q\",\"P\",\"B\")) {\n",
        count=1, why="checklist: F")
    e.replace(
        "        Write-Host \"    I = show build and Machine ID\" -ForegroundColor Yellow\n",
        "        Write-Host \"    I = show build and Machine ID    F = fix the screen\" -ForegroundColor Yellow\n",
        count=1, why="checklist: legend F")

    # Screen 6 item 5: B, L and F in the same five lines
    old5 = [
        "  5. GOING BACK: Press B to go back one step and change your   ",
        "     answer. Press L to LOOK at the previous screen again --   ",
        "     nothing is changed. Once Checkup has changed a setting,   ",
        "     that step cannot be reopened, and the screen says so.     ",
        "     Everything is also saved in your log file.                ",
    ]
    new5 = [
        "  5. B, L AND F: B goes back one step to change an answer.     ",
        "     L looks at the previous screen again (nothing changes).   ",
        "     F fixes the screen if it looks cut off or jumbled. Once   ",
        "     Checkup has changed a setting, that step cannot be        ",
        "     reopened, and the screen says so.                         ",
    ]
    for n in new5:
        assert len(n) <= 64, (len(n), n)
    e.replace("".join("                \"%s\",\n" % o for o in old5),
              "".join("                \"%s\",\n" % n for n in new5),
              count=1, why="screen 6: B, L and F")
