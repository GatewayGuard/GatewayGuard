"""build_ascii43_f1 -- F1 keyboard contract (safe subset).

Covers the unambiguous, low-risk parts of the F1 family:
  FT-204  deselect-all moved off N (the safe key everywhere else) to C, and
          gated behind a Y/N confirm. N is now inert on the checklist.
  FT-206  I works on the checklist's own hand-rolled reader.
  FT-207  the unrecognised-key message in Read-ValidKey names the exit
          (Ctrl+C) -- one edit, all 47 Read-ValidKey prompts.
  FT-232  an out-of-range item number is rejected out loud instead of being
          logged as accepted and doing nothing.
  FT-223  the checklist legend explains single- vs two-digit entry.

DELIBERATELY NOT HERE (design fork, awaiting Bill): "B is the only Back key,
N never means Back." N = Go back is an established Y/N/S consent pattern across
~6 prompts; rewriting them is a scope decision, not a mechanical fix.

Run from the Tool/ directory:  python build_ascii43_f1.py
"""
from gg_edit import PS1Edit

TARGET = r"W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1"

with PS1Edit(TARGET) as e:

    # -- FT-207: name the exit in Read-ValidKey's unrecognised-key message ----
    e.replace(
        '''                } elseif ($k.Character -match '\\S') {
                    Write-Host ""
                    Write-Host ("  That key does nothing here. Please press " + ($ValidKeys -join " or ") + ".") -ForegroundColor Yellow
                    Write-Host "  Press I at any time to see your build and Machine ID." -ForegroundColor DarkGray
                    if ($Prompt) { Write-Host "  $Prompt" -ForegroundColor White -NoNewline }
                }''',
        '''                } elseif ($k.Character -match '\\S') {
                    Write-Host ""
                    Write-Host ("  That key does nothing here. Please press " + ($ValidKeys -join " or ") + ".") -ForegroundColor Yellow
                    Write-Host "  Press I at any time to see your build and Machine ID." -ForegroundColor DarkGray
                    Write-Host "  To leave Checkup at any time, press Ctrl+C." -ForegroundColor DarkGray
                    if ($Prompt) { Write-Host "  $Prompt" -ForegroundColor White -NoNewline }
                }''',
        count=1,
        why="FT-207: unrecognised-key message names the exit (covers all 47 Read-ValidKey prompts)",
    )

    # -- FT-204 legend: N = Deselect all  ->  C = Clear all -------------------
    e.replace(
        '        Write-Host "    A = Select all             N = Deselect all    Q = Quit" -ForegroundColor Yellow',
        '        Write-Host "    A = Select all             C = Clear all       Q = Quit" -ForegroundColor Yellow',
        count=1,
        why="FT-204: legend -- deselect-all moved off N to C",
    )

    # -- FT-206 + FT-223 legend: advertise I, and explain digit entry --------
    e.insert_after(
        '        Write-Host "    P = show the other page of the list" -ForegroundColor Yellow',
        '\n        Write-Host "    I = show build and Machine ID" -ForegroundColor Yellow'
        '\n        Write-Host "    Item numbers: 1-9 then Enter; 10-19 apply on the second digit." -ForegroundColor DarkGray',
        count=1,
        why="FT-206/FT-223: advertise I on the checklist and explain single- vs two-digit entry",
    )

    # -- FT-204 prompt: R/A/N/Q/P -> R/A/C/Q/P -------------------------------
    e.replace(
        '        Write-Host "  Enter command (R/A/N/Q/P or item number 1-19): " -ForegroundColor White -NoNewline',
        '        Write-Host "  Enter command (R/A/C/Q/P or item number 1-19): " -ForegroundColor White -NoNewline',
        count=1,
        why="FT-204: prompt -- N replaced by C",
    )

    # -- FT-204 accepted-key set: N -> C -------------------------------------
    e.replace(
        '        if ($firstCh -in @("R","A","N","Q","P")) {',
        '        if ($firstCh -in @("R","A","C","Q","P")) {',
        count=1,
        why="FT-204: accepted commands -- N replaced by C (N now inert on checklist)",
    )

    # -- FT-206: I branch in the checklist's own reader ----------------------
    e.replace(
        '''            break keyLoop
        } else {
            # FT-193 (ascii42): was \'$userInput = ""  # Invalid -- swallow''',
        '''            break keyLoop
        } elseif ($firstCh -eq "I") {
            # FT-206 (ascii43): I works on the checklist too. FT-189 promised
            # "at any time" and this hand-rolled reader was the one prompt
            # where it failed -- the screen the user spends most of the run on.
            Write-Host ""
            Show-CheckupInfo
            continue keyLoop
        } else {
            # FT-193 (ascii42): was \'$userInput = ""  # Invalid -- swallow''',
        count=1,
        why="FT-206: I shows build and Machine ID from the checklist reader",
    )

    # -- FT-204 + FT-206 does-nothing message: N -> C, add I -----------------
    e.replace(
        '                Write-Host "  That key does nothing here. Press R, A, N, Q, P or an item number 1-19." -ForegroundColor Yellow',
        '                Write-Host "  That key does nothing here. Press R, A, C, Q, P, I or an item number 1-19." -ForegroundColor Yellow',
        count=1,
        why="FT-204/FT-206: unrecognised-key message -- N replaced by C, I added",
    )

    # -- FT-204 switch: the N destructive case becomes C, with a confirm -----
    e.replace(
        '''            "A" { $Settings | ForEach-Object { $_.Selected = $true } }
            "N" { $Settings | ForEach-Object { $_.Selected = $false } }''',
        '''            "A" { $Settings | ForEach-Object { $_.Selected = $true } }
            "C" {
                # FT-204 (ascii43): clearing every selection is the only
                # destructive command on this screen and used to be N -- the
                # safe key everywhere else -- with no confirmation. It wiped
                # 19 selections five seconds after they were made (field,
                # 2026-08-21). Moved to C and gated behind a Y/N.
                $selCount = ($Settings | Where-Object { $_.Selected }).Count
                if ($selCount -eq 0) {
                    Write-Host ""
                    Write-Host "  Nothing is selected -- nothing to clear." -ForegroundColor Yellow
                    Pause-ForUser "  Press Enter or Space to return to the checklist..."
                } else {
                    Write-Host ""
                    $clearResp = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Clear all $selCount selection(s)? (Y = Clear / N = Keep them): "
                    if ($clearResp.ToUpper() -eq "Y") {
                        $Settings | ForEach-Object { $_.Selected = $false }
                        try { Write-Log -Message "Checklist: all selections cleared (C, confirmed)" -Status "KEY" } catch {}
                    }
                }
            }''',
        count=1,
        why="FT-204: deselect-all -> Clear all on C, gated behind a Y/N confirm",
    )

    # -- FT-232: out-of-range item number rejected out loud ------------------
    e.replace(
        '''            default {
                if ($userInput -match \'^\\d+$\') {
                    $id = [int]$userInput
                    $item = $Settings | Where-Object { $_.ID -eq $id }
                    if ($item) { $item.Selected = -not $item.Selected }
                }
            }''',
        '''            default {
                if ($userInput -match \'^\\d+$\') {
                    $id = [int]$userInput
                    $item = $Settings | Where-Object { $_.ID -eq $id }
                    if ($item) {
                        $item.Selected = -not $item.Selected
                    } else {
                        # FT-232 (ascii43): an out-of-range number was logged as
                        # accepted and did nothing -- worse than an unknown key,
                        # because it looked like it worked. Reject it out loud.
                        $maxId = ($Settings | Measure-Object -Property ID -Maximum).Maximum
                        Write-Host ""
                        Write-Host "  There is no item $id. Item numbers run 1 to $maxId." -ForegroundColor Yellow
                        try { Write-Log -Message ("Checklist: item number out of range (" + $id + ") -- rejected") -Status "KEY" } catch {}
                        Pause-ForUser "  Press Enter or Space to return to the checklist..."
                    }
                }
            }''',
        count=1,
        why="FT-232: out-of-range item number rejected out loud instead of silently accepted",
    )
