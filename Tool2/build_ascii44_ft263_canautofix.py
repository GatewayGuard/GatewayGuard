import sys
sys.path.insert(0, r"C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\Tool2")
from gg_edit import PS1Edit

PS1 = r"C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

OLD = '''    if (-not $Setting.CanAuto) {
        Write-Log -Message "$($Setting.Name) | Manual action required" -Status "MANUAL"
        return "Manual action required -- see Guide: $($Setting.GuideRef)"
    }'''

NEW = '''    # FT-263 (2026-09-17): this used to return here unconditionally for every
    # CanAuto=false setting, before the switch below could ever run -- so
    # settings 3 (Tamper Protection) and 9 (Windows Hello), which write
    # nothing but DO build specific, correct manual instructions in their
    # own switch case (Malwarebytes/trial-aware for 3, an NGC check for 9),
    # never reached them. Measured: neither case calls Set-ItemProperty,
    # Set-Service, New-Item, or Remove-Item -- both only read state and
    # return a message string -- so it is safe to let these two through.
    # Any OTHER CanAuto=false setting still exits here and can never reach
    # a case that might write.
    if (-not $Setting.CanAuto -and $Setting.ID -notin 3,9) {
        Write-Log -Message "$($Setting.Name) | Manual action required" -Status "MANUAL"
        return "Manual action required -- see Guide: $($Setting.GuideRef)"
    }'''

with PS1Edit(PS1) as e:
    e.replace(
        OLD, NEW, count=1,
        why="FT-263: CanAuto=false's early return in Apply-Setting made cases 3 and 9 "
            "permanently unreachable. Neither writes anything (measured: no Set-ItemProperty/"
            "Set-Service/New-Item/Remove-Item in either case), so exempting only these two "
            "IDs from the early return is safe; any future CanAuto=false setting still gets "
            "the generic, safe fallback."
    )

print("Edit applied and file parsed clean.")
