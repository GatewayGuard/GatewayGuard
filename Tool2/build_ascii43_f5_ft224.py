"""build_ascii43_f5_ft224 -- F5 flow: FT-224 encryption decline asked once.

The BitLocker decline heads-up (SCREEN-58) was shown on EVERY R press when
item 8 was not selected on an unencrypted drive -- the run log caught it
rendered three times, each after the decline was already noted. Remember the
acknowledgment for the session. A GoBack does NOT set the flag (the user has
not decided to skip), so the reminder still stands until they either select
item 8 or accept continuing without encryption.

Run from the Tool/ directory:  python build_ascii43_f5_ft224.py
"""
from gg_edit import PS1Edit

TARGET = r"W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        '''                $blItem = $Settings | Where-Object { $_.ID -eq 8 } | Select-Object -First 1
                if ($blItem -and -not $blItem.Selected -and $blItem.Status -match "NOT Encrypted") {
                    $blDecision = Show-BitLockerDeclineHeadsUp
                    if ($blDecision -eq "GoBack") {
                        Write-Host ""
                        Write-Host "  Back at the checklist -- type 8 to select Drive Encryption." -ForegroundColor Cyan
                        Pause-ForUser "  Press Enter or Space to return to the checklist..."
                        continue checklistLoop
                    }
                }''',
        '''                $blItem = $Settings | Where-Object { $_.ID -eq 8 } | Select-Object -First 1
                # FT-224 (ascii43): this decline heads-up was shown on EVERY R
                # press -- the run log caught SCREEN-58 rendered three times, each
                # after the decline was already noted. Once the user chooses to
                # continue without encryption, remember it for the session and do
                # not re-ask. A GoBack does not set the flag: they have not
                # decided to skip, so the reminder stands until they either select
                # item 8 or acknowledge declining.
                if ($blItem -and -not $blItem.Selected -and $blItem.Status -match "NOT Encrypted" -and -not $script:GGBitLockerDeclineAcknowledged) {
                    $blDecision = Show-BitLockerDeclineHeadsUp
                    if ($blDecision -eq "GoBack") {
                        Write-Host ""
                        Write-Host "  Back at the checklist -- type 8 to select Drive Encryption." -ForegroundColor Cyan
                        Pause-ForUser "  Press Enter or Space to return to the checklist..."
                        continue checklistLoop
                    }
                    $script:GGBitLockerDeclineAcknowledged = $true
                }''',
        count=1,
        why="FT-224: BitLocker decline heads-up asked once per session, not on every R",
    )
