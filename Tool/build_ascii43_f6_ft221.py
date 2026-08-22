"""build_ascii43_f6_ft221 -- F6: FT-221 setting 15 ties to the password-manager answer.

The checklist already deselects item 15 when the user says they have no password
manager (line ~6672), and the convenience-review display already shows two
wordings based on the answer (lines 6758, 7028). The gap is at APPLY time: the
item-15 handler disabled Edge password saving unconditionally, so a manual
re-select of item 15 could still turn it off with no manager -- leaving the user
with no password store at all. Put the guard at the point of change.

Run from the Tool/ directory:  python build_ascii43_f6_ft221.py
"""
from gg_edit import PS1Edit

TARGET = r"W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        '''        15 {
            try {
                $rp = "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge"
                if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                Set-ItemProperty -Path $rp -Name PasswordManagerEnabled -Value 0 -Type DWord -Force
                $result = "Edge password saving disabled. Use a dedicated password manager. See Guide: Phase 5 at $GuideURL"
            } catch { $result = "ERROR: $_" }
        }''',
        '''        15 {
            try {
                # FT-221 (ascii43): never disable Edge password saving while the
                # user has no password manager -- that would leave them with no
                # password store at all. The checklist deselects item 15 when the
                # user says they have no manager, but a manual re-select could
                # still reach here, so the guard lives at the point of change.
                if (-not $global:HasPasswordManager) {
                    $result = "LEFT ON -- set up a password manager first, or your saved passwords would have nowhere to live. See Guide: Phase 5 at $GuideURL"
                    Write-Log -Message "Edge Password Saving (ID 15) NOT disabled -- no password manager (FT-221)" -Status "SKIP"
                } else {
                    $rp = "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge"
                    if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                    Set-ItemProperty -Path $rp -Name PasswordManagerEnabled -Value 0 -Type DWord -Force
                    $result = "Edge password saving disabled. Use a dedicated password manager. See Guide: Phase 5 at $GuideURL"
                }
            } catch { $result = "ERROR: $_" }
        }''',
        count=1,
        why="FT-221: item 15 refuses to disable Edge password saving when there is no password manager",
    )
