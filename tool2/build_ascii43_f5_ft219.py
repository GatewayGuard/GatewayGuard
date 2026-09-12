"""build_ascii43_f5_ft219 -- F5 flow: FT-219 selection = approval to apply.

Bill, 2026-08-21: "making the selection is an approval to apply the change,
except where a manual intervention by the approver is needed."

So a setting Checkup can apply automatically is applied as soon as it comes up
in the run -- no second per-item "Apply? Y/N" -- because selecting it on the
checklist was the approval (and the whole run was confirmed at the review
gate). The ONE exception is a setting that needs the user to act by hand: that
path (-not $s.CanAuto) already shows the steps instead of changing anything,
and its wording now says so.

Non-recommended / dangerous deselections are still gated at the review stage by
Test-NonRecommendedSelections -- that safety net is unchanged. Convenience
items (11-15) keep their own separate review (FT-94).

Run from the Tool/ directory:  python build_ascii43_f5_ft219.py
"""
from gg_edit import PS1Edit

TARGET = r"W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1"

with PS1Edit(TARGET) as e:

    # -- review summary: state the model ("selecting them was your approval") -
    e.replace(
        '                Write-Host "  $selectedCount item(s) will be applied. Y/N prompt shown for each." -ForegroundColor Yellow',
        '                Write-Host "  $selectedCount item(s) will be applied -- selecting them was your approval. Any that need a manual step will show you how." -ForegroundColor Yellow',
        count=1,
        why="FT-219: review summary states selection=approval and names the manual exception",
    )

    # -- the manual-action exception: name it as the exception ---------------
    e.replace(
        '                        Write-Host "  Manual action required -- cannot be automated." -ForegroundColor Red',
        '                        Write-Host "  This one needs you to do it by hand -- Checkup will show you the steps." -ForegroundColor Red',
        count=1,
        why="FT-219: manual-action items are the stated exception to selection=approval",
    )

    # -- the per-item apply loop: selection = approval, apply without re-asking
    e.replace(
        '''                    Write-Host ""
                    Write-Host "  Y = Apply this change   N = Skip   B = Back to checklist" -ForegroundColor White
                    $confirm = Read-ValidKey -ValidKeys @("Y","N","B") -Prompt "Apply? (Y = Yes / N = Skip / B = Back): "
                    switch ($confirm.ToUpper()) {
                        "B" { continue checklistLoop }
                        "N" {
                            Write-Host "  Skipped." -ForegroundColor Gray
                            Write-Log -Message "$($s.Name) -- Skipped by user" -Status "SKIP"
                            continue
                        }
                    }
                    Write-Host "  Applying..." -ForegroundColor Cyan''',
        '''                    # FT-219 (ascii43): selecting an item on the checklist IS your
                    # approval to apply it (Bill, 2026-08-21), and the whole run was
                    # confirmed at the review gate. A setting Checkup can apply is
                    # applied now, with no second "Apply? Y/N". The ONLY exception is
                    # a setting that needs you to act by hand -- handled above
                    # (-not $s.CanAuto), where Checkup shows the steps rather than
                    # changing anything itself.
                    Write-Host ""
                    Write-Host "  You selected this item, so Checkup is applying it now." -ForegroundColor Cyan
                    Write-Host "  Applying..." -ForegroundColor Cyan''',
        count=1,
        why="FT-219: automatable selected items apply without a per-item Y/N (selection=approval)",
    )
