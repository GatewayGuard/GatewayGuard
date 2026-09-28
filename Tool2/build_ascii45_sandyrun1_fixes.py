"""build_ascii45_sandyrun1_fixes -- everything else from Bill's SANDY ascii45
run of 2026-09-28: FT-302, FT-304, FT-305, FT-306, FT-308, FT-309 and the
wording notes 2, 4b, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15.

Dated: 2026-09-28 18:36 ET
Editor: Claude Code (CGDELL)
Triage: ProjectDocs\\GatewayGuard_FieldTestTriage-ascii45run1-2026-09-28-1639.md
Bill, 2026-09-28: "fix everything".

FT-302  I then Space twice: the Info screen's own Pause-ForUser saved a picture
        of the Info screen on top of the caller's, and the caller restored the
        LATEST picture -- the Info screen again. Log 14:20:28-14:20:34: Info
        closed at :33, screen 9 left at :34 without being seen. Show-CheckupInfo
        now removes any pictures it added, and restores the caller's stored box.
FT-304  "Nothing has been changed" removed where nothing was offered (screens
        20, 22, 24, 23a, the Info screen, look-back, return lines). Kept at the
        Exit confirmations and the review screen, where a change WAS on offer.
FT-305  Checklist: when the content fits, the NAME column takes only what it
        needs and the STATUS column the rest (was the reverse -- log 15:49:16
        "name 101 (content needed 51)" on a 174-wide window).
FT-306  Screen 33 said "ALL SELECTED ITEMS PROCESSED" after item 6 needed the
        user and item 14 failed. It now counts done / need you / not done.
FT-308  Remove-GGOldMBReminder: the expected "No MSFT_ScheduledTask objects
        found" is cleared from $Error, so it no longer logs SILENT ERROR.
FT-309  Absent policy keys log one plain INFO line ("Not set -- normal on a
        home PC"), without the "fault at" wording that read like an error.
Wording per Bill's notes. Item 14: when Windows refuses the change, the manual
steps are given instead of an ERROR (FT-283 cause still open).

Run from Tool2/:  python build_ascii45_sandyrun1_fixes.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"


def box_line(e, starts, new, why):
    """Replace ONE box line (a quoted string element) found by the start of its
    text; keeps indentation and the trailing comma, pads to the old length so
    no box gets wider or narrower by accident."""
    lines = e.text.split("\n")
    hits = [i for i, l in enumerate(lines) if l.strip().startswith('"' + starts)]
    assert len(hits) == 1, (why, starts, len(hits))
    i = hits[0]
    l = lines[i]
    ind = l[: len(l) - len(l.lstrip())]
    comma = "," if l.rstrip().endswith(",") else ""
    old_content = l.strip()[1:].rstrip(",")[:-1]
    assert len(new) <= max(len(old_content), 62), (why, len(new), len(old_content))
    new_line = ind + '"' + new.ljust(len(old_content)) + '"' + comma
    e.replace(l + "\n", new_line + "\n", count=1, why=why)


with PS1Edit(TARGET) as e:
    e.replace(
        "#           COUNTS AS IN CHARGE (Get-GGAVInCharge). FT-307: its name shows.\n",
        "#           COUNTS AS IN CHARGE (Get-GGAVInCharge). FT-307: its name shows.\n"
        "#   SANDY RUN 1 (2026-09-28): FT-302 I-screen return, FT-304 no \"nothing\n"
        "#           changed\" where nothing was offered, FT-305 checklist columns,\n"
        "#           FT-306 screen 33 counts, FT-308/309 log noise, wording notes.\n",
        count=1, why="change log")

    # ---------------- FT-302 ----------------
    e.replace(
        "    if ($script:GGInInfo) { return }\n"
        "    $script:GGInInfo = $true\n",
        "    if ($script:GGInInfo) { return }\n"
        "    $script:GGInInfo = $true\n"
        "    # FT-302 (ascii45): remember the caller's picture count and stored box,\n"
        "    # so closing this screen shows the caller's screen, not this one again.\n"
        "    $ggSnapCount = 0; try { $ggSnapCount = $script:GGSnapshots.Count } catch {}\n"
        "    $ggBoxBefore = $script:GGLastBox\n",
        count=1, why="FT-302: remember state")
    e.replace(
        "    } finally {\n"
        "        $script:GGInInfo = $false\n"
        "    }\n",
        "    } finally {\n"
        "        try { while ($script:GGSnapshots.Count -gt $ggSnapCount) { $script:GGSnapshots.RemoveAt($script:GGSnapshots.Count - 1) } } catch {}\n"
        "        $script:GGLastBox = $ggBoxBefore\n"
        "        $script:GGInInfo = $false\n"
        "    }\n",
        count=1, why="FT-302: drop the Info picture")

    # ---------------- FT-304 sweep ----------------
    e.replace("LOOKING BACK -- nothing on your PC has been changed or undone.", "LOOKING BACK at an earlier screen.", count=1, why="FT-304 look-back")
    e.replace("(Returning to where you were. Nothing has changed.)", "(Returning to where you were.)", count=1, why="FT-304 return 1")
    e.replace("   Nothing has changed. Your log file has the full detail.)", "   Your log file has the full detail.)", count=1, why="FT-304 return 2")
    box_line(e, "  Nothing on your PC has been changed by this screen, and", "  This screen only shows information. Nothing is sent", "FT-304 info 1")
    box_line(e, "  nothing has been sent anywhere.", "  anywhere.", "FT-304 info 2")
    box_line(e, "  Nothing on your PC has been changed by this screen.", "", "FT-304 23a")

    # ---------------- screen 20 (note 7) ----------------
    box_line(e, "  Checkup changes 1-3 only on the security checklist", "  Each line shows what Checkup FOUND on your PC right now.", "note 7: readings")
    box_line(e, "  (items 17, 18 and 19), and only the ones you select.", "  To change 1-3, select items 17, 18, 19 on the checklist.", "note 7: where to change")
    e.replace(
        "    Write-Host \"  Items 1-3 above change only on the security checklist (items 17-19),\" -ForegroundColor Yellow\n"
        "    Write-Host \"  and only if you select them there. Nothing is changed here.\" -ForegroundColor Gray\n",
        "", count=1, why="note 7: drop the repeat and 'nothing changed'")

    # ---------------- screen 22 (note 8) ----------------
    box_line(e, "      A checklist in this window shows each setting and", "      A checklist will appear shortly, showing each", "note 8a")
    box_line(e, "      its live status. Checkup changes only the items you", "      setting and its live status. Checkup changes only", "note 8b")
    box_line(e, "      select.", "      the items you select.", "note 8c")
    box_line(e, "  [X] EXIT -- nothing has been changed", "  [X] EXIT -- close Checkup", "note 8d")

    # ---------------- screen 24 (note 9) ----------------
    box_line(e, "  The screens so far only READ your settings -- nothing changed.", "  The screens so far only READ your settings.", "note 9a")
    box_line(e, "    Fast Startup)", "    Fast Startup) -- each is explained on the checklist", "note 9b")

    # ---------------- screen 25 (note 10) ----------------
    box_line(e, "  Each one you select is changed with the rest. At the end,", "  Each one you select is changed with the rest, and at the", "note 10a")
    box_line(e, "  Checkup shows what changed and how to put each one back:", "  end Checkup shows you what it changed:", "note 10b")
    e.replace("'Full access -- all settings available'", "'Full access -- for all available settings'", count=1, why="note 10c")
    e.replace(
        "  Sleep: $(if ($global:SleepPrevented) { 'ACTIVE' } else { 'inactive' })\"",
        "  (Checkup keeps your PC awake while it runs)\"",
        count=1, why="note 10d: say what the sleep line means")

    # ---------------- note 2: Windows Update ----------------
    e.replace("\"Checking Windows Update -- this can take a minute or two\"", "\"Checking Windows Update -- this can take a while\"", count=1, why="note 2")

    # ---------------- screen 17 (notes 4b, 5) ----------------
    box_line(e, "  * When you're back at the desktop, run Checkup again", "  * Sign in as usual, then run Checkup again and choose", "note 5a")
    box_line(e, "    -- it will automatically pick up right where you left", "    R (Resume) -- it picks up right where you left off.", "note 5b")
    box_line(e, "    off. You do NOT need to start over.", "    You do NOT need to start over.", "note 5c")
    e.replace(
        "        Write-Host \"  Starting the offline scan. Your computer will restart\" -ForegroundColor Green\n"
        "        Write-Host \"  in a few seconds. See you on the other side!\" -ForegroundColor Green\n",
        "        Write-Host \"  Awaiting restart -- this can take several minutes. Leave the PC\" -ForegroundColor Green\n"
        "        Write-Host \"  alone. After the restart, sign in and run Checkup again (R).\" -ForegroundColor Green\n",
        count=1, why="note 4b")

    # ---------------- screen 17a (note 6 / FT-277) ----------------
    old40 = [
        "  Welcome back. If the offline scan ran, its results are in",
        "  Protection History. Here's how to see them:",
        "  1. We'll open Windows Security to Protection History now",
        "  2. Look for any items listed under Recent Actions",
        "  WHAT TO LOOK FOR:",
        "  * 'Quarantined' or 'Removed' -- good news, Defender",
        "    already handled it. No action needed.",
        "  * 'Allowed' -- Defender saw something suspicious but",
        "    didn't block it. If you don't recognize it, write down",
        "    its name -- the guide shows what to do next.",
        "  * 'No Recent Actions' -- your scan came back clean.",
    ]
    new40 = [
        "  Anything the offline scan found is listed in Protection",
        "  history. To see it:",
        "  1. Checkup opens Windows Security (next key). Click Virus",
        "     & threat protection, then Protection history.",
        "  2. WRITE DOWN the name and status of anything listed.",
        "  * 'Quarantined' or 'Removed' -- Defender handled it.",
        "  * 'Allowed' -- it was NOT blocked. If you do not know",
        "    it, keep your note: the guide shows what to do next.",
        "  * Nothing listed -- the scan found nothing.",
        "  Guide: Setting 2 (Defender virus protection).",
        "",
    ]
    for o, n in zip(old40, new40):
        box_line(e, o, n, "note 6: " + o.strip()[:20])
    e.replace("Pause-ForUser \"  Press Enter or Space to open Protection History...\"",
              "Pause-ForUser \"  Press Enter or Space to open Windows Security...\"",
              count=1, why="note 6: prompt")
    e.replace("        Write-Host \"  The guide shows what to do next with it.\" -ForegroundColor Yellow\n",
              "        Write-Host \"  The guide shows what to do next with it: Setting 2.\" -ForegroundColor Yellow\n",
              count=1, why="note 6: guide ref")

    # ---------------- item 6 (notes 11, 13, 14) ----------------
    e.replace("\"Unknown -- Tamper Protection blocks this check; verify by hand\"",
              "\"Blocked by Tamper Protection -- check by hand; Checkup will show you how\"",
              count=1, why="note 11: item 6 status")
    e.replace(
        "                $result = \"MANUAL REQUIRED -- registry is protected on this PC (Tamper Protection)\"\n",
        "                $result = \"MANUAL -- these settings are protected on this PC (Tamper Protection); do the steps shown\"\n"
        "                $script:GGStepsShown = $true   # notes 13/14: the loop does not repeat it\n",
        count=1, why="note 13: settings are protected")
    e.replace(
        "                Write-Host \"  NOTE: Phishing Protection registry is protected on this PC.\" -ForegroundColor Yellow\n"
        "                Write-Host \"  Enable manually:\" -ForegroundColor Yellow\n"
        "                Write-Host \"  1. Windows Security -> App & browser control\" -ForegroundColor Gray\n"
        "                Write-Host \"  2. Reputation-based protection settings\" -ForegroundColor Gray\n",
        "                Write-Host \"  1. Windows Security -> App & browser control\" -ForegroundColor Gray\n"
        "                Write-Host \"  2. Reputation-based protection settings (you may need to click Turn on)\" -ForegroundColor Gray\n",
        count=1, why="note 14: no repeated lines; note 13: may need Turn on")
    e.replace(
        "                Write-Host \"     contents to Microsoft. Checkup does not need it.\" -ForegroundColor Gray\n",
        "                Write-Host \"     contents to Microsoft. Checkup recommends you leave it off.\" -ForegroundColor Gray\n",
        count=1, why="note 13: recommends")
    e.replace(
        "                Write-Host \"  Full guide: gatewayguard.co/guide/phishing-protection\" -ForegroundColor Cyan\n"
        "                Write-Host \"\"\n"
        "                Pause-ForUser \"  Press Enter or Space to continue...\"\n",
        "                Write-Host \"  Full guide: gatewayguard.co/guide/phishing-protection\" -ForegroundColor Cyan\n",
        count=1, why="note 14: one Enter, not two")

    # ---------------- apply loop (notes 13, 14; FT-306 data) ----------------
    e.replace(
        "                Write-Host \"\"\n"
        "                Write-Host \"  Starting -- $selectedCount item(s) to process...\" -ForegroundColor Cyan\n",
        "                Clear-Host   # note 13: the run starts on a clean screen, not under the review\n"
        "                Write-Host \"\"\n"
        "                Write-Host \"  Starting -- $selectedCount item(s) to process...\" -ForegroundColor Cyan\n",
        count=1, why="note 13: clear before applying")
    e.replace(
        "                    Write-Host \"  Working on this item...\" -ForegroundColor Cyan\n",
        "                    $script:GGStepsShown = $false\n"
        "                    if ($s.Status -match \"Blocked by Tamper Protection\") { Write-Host \"  Do this:\" -ForegroundColor Cyan }   # note 14\n"
        "                    else { Write-Host \"  Working on this item...\" -ForegroundColor Cyan }\n",
        count=1, why="note 14: Do this")
    e.replace(
        "                    Write-Host \"\"\n"
        "                    Write-GGWrapped -Text \"Result: $result\" -Color $resultColor\n"
        "                    Pause-ForUser\n",
        "                    if (-not $script:GGStepsShown) {   # note 14: steps already on screen\n"
        "                        Write-Host \"\"\n"
        "                        Write-GGWrapped -Text \"Result: $result\" -Color $resultColor\n"
        "                    }\n"
        "                    Pause-ForUser\n",
        count=1, why="note 14: no repeated manual line")

    # ---------------- item 14 (note 15) ----------------
    e.replace(
        "                Set-ItemProperty -Path $rp -Name AllowNewsAndInterests -Value 0 -Type DWord -Force -EA Stop\n"
        "                $result = \"Windows Widgets disabled -- GOOD\"\n"
        "            } catch { $result = \"ERROR: $_\" }\n",
        "                Set-ItemProperty -Path $rp -Name AllowNewsAndInterests -Value 0 -Type DWord -Force -EA Stop\n"
        "                $result = \"Windows Widgets disabled -- GOOD\"\n"
        "            } catch {\n"
        "                # Note 15 / FT-283 (SANDY 2026-09-28 16:11): Windows refused this write\n"
        "                # although Administrators have FullControl on the key (measured\n"
        "                # 09-27). Cause still open -- give the steps, never claim it worked.\n"
        "                try { Write-Log -Message (\"Item 14: Windows refused the Widgets policy write -- manual steps shown (FT-283): \" + $_.Exception.Message) -Status \"WARN\" } catch {}\n"
        "                try { if ($Error.Count -gt 0) { $Error.RemoveAt(0) } } catch {}\n"
        "                $result = \"MANUAL -- Windows would not let Checkup change this. Turn Widgets off yourself: press the Windows key, type taskbar settings, press Enter, and turn Widgets Off.\"\n"
        "            }\n",
        count=1, why="note 15: Widgets manual steps")

    # ---------------- FT-306: screen 33 ----------------
    e.replace(
        "                    \"  ALL SELECTED ITEMS PROCESSED                           \",\n",
        "                    $(Get-GGRunCountLine),\n",
        count=1, why="FT-306: screen 33 counts")
    e.replace(
        "function Test-GGResultGood {\n",
        "function Get-GGRunCountLine {\n"
        "    # FT-306 (ascii45, SANDY 2026-09-28): screen 33 said \"ALL SELECTED ITEMS\n"
        "    # PROCESSED\" after one item needed the user and one failed.\n"
        "    $ggRows = @(); if ($script:GGRunResults) { $ggRows = @($script:GGRunResults.Values) }\n"
        "    $ggDone = @($ggRows | Where-Object { Test-GGResultGood $_.Now }).Count\n"
        "    $ggYou  = @($ggRows | Where-Object { -not (Test-GGResultGood $_.Now) -and $_.Now -match 'MANUAL|NOTE:|by hand|Manual setup|LEFT ON' }).Count\n"
        "    $ggNot  = $ggRows.Count - $ggDone - $ggYou\n"
        "    if ($ggRows.Count -gt 0 -and $ggDone -eq $ggRows.Count) { return \"  ALL SELECTED ITEMS DONE                                \" }\n"
        "    return (\"  SELECTED ITEMS -- done: \" + $ggDone + \"   need you: \" + $ggYou + \"   could not be done: \" + $ggNot)\n"
        "}\n"
        "\n"
        "function Test-GGResultGood {\n",
        count=1, why="FT-306: Get-GGRunCountLine")

    # ---------------- FT-305: checklist columns ----------------
    e.replace(
        "            # Everything fits -- hand the leftover room to the name column so\n"
        "            # nothing is shortened that did not have to be.\n"
        "            $ggNameW = $ggAvailable - $ggStatW\n",
        "            # FT-305 (ascii45): everything fits -- the spare room goes to the\n"
        "            # STATUS column, so the column line sits just after the longest\n"
        "            # name (Bill, SANDY 2026-09-28: \"move the break to the left\").\n"
        "            $ggStatW = $ggAvailable - $ggNameW\n",
        count=1, why="FT-305: columns")
    e.replace(
        "Write-Log -Message (\"Checklist: key ignored (\" + $(if ($firstCh) { $firstCh } else { \"non-printing\" }) + \")\") -Status \"KEY\"",
        "Write-Log -Message (\"Checklist: key ignored (\" + $(if ($firstCh -match '^[!-~]$') { $firstCh } else { \"key code \" + $(if ($firstKey) { $firstKey.VirtualKeyCode } else { \"?\" }) }) + \")\") -Status \"KEY\"",
        count=1, why="checklist: name non-printing keys")

    # ---------------- FT-308 ----------------
    t = e.text
    s = t.index("function Remove-GGOldMBReminder {\n")
    end = t.index("\n}\n", s) + 3
    old = t[s:end]
    new = old
    a1 = "        $ggT = Get-ScheduledTask -TaskName $ggName -EA SilentlyContinue\n"
    assert new.count(a1) == 1
    new = new.replace(a1, a1 + "        Clear-GGExpectedTaskError   # FT-308\n")
    a2 = "        if (Get-ScheduledTask -TaskName $ggName -EA SilentlyContinue) {\n"
    assert new.count(a2) == 1
    new = new.replace(a2, "        $ggStill = Get-ScheduledTask -TaskName $ggName -EA SilentlyContinue\n        Clear-GGExpectedTaskError   # FT-308\n        if ($ggStill) {\n")
    new = ("function Clear-GGExpectedTaskError {\n"
           "    # FT-308 (ascii45, SANDY 2026-09-28 16:29:47): \"not found\" is the\n"
           "    # answer Checkup hopes for here; it was logged as SILENT ERROR.\n"
           "    try { while ($Error.Count -gt 0 -and [string]$Error[0] -match 'No MSFT_ScheduledTask objects found') { $Error.RemoveAt(0) } } catch {}\n"
           "}\n\n") + new
    e.replace(old, new, count=1, why="FT-308")

    # ---------------- FT-309 ----------------
    e.replace(
        "                Write-Log -Message ($ggLabel + \" -- fault at: \" + $ggFault + \" -- user was at: \" + $Where + \" -- \" + $ggMsg) -Status $ggStatus\n",
        "                if ($ggBenign) {\n"
        "                    # FT-309 (ascii45): one plain line -- \"fault at\" read like an error.\n"
        "                    Write-Log -Message (\"Not set -- normal on a home PC: \" + $ggMsg) -Status \"INFO\"\n"
        "                } else {\n"
        "                    Write-Log -Message ($ggLabel + \" -- fault at: \" + $ggFault + \" -- user was at: \" + $Where + \" -- \" + $ggMsg) -Status $ggStatus\n"
        "                }\n",
        count=1, why="FT-309")
