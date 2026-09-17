import sys
sys.path.insert(0, r"C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\Tool2")
from gg_edit import PS1Edit

PS1 = r"C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

OLD = '''                Write-Host "  3. Under Phishing protection -> turn ON all 3 options" -ForegroundColor Gray
                Write-Host "  Full guide: gatewayguard.co/guide/phishing-protection" -ForegroundColor Cyan'''

NEW = '''                Write-Host "  3. Under Phishing protection, turn ON the three" -ForegroundColor Gray
                Write-Host "     'Warn me about' boxes." -ForegroundColor Gray
                Write-Host "  4. Leave the fourth box OFF -- 'Automatically collect" -ForegroundColor Gray
                Write-Host "     website or app content...' sends your screen" -ForegroundColor Gray
                Write-Host "     contents to Microsoft. Checkup does not need it." -ForegroundColor Gray
                Write-Host "  Full guide: gatewayguard.co/guide/phishing-protection" -ForegroundColor Cyan'''

with PS1Edit(PS1) as e:
    e.replace(
        OLD, NEW, count=1,
        why="FT-262: line named 'turn ON all 3 options' with four boxes on screen and "
            "none of the three named. Drafted and reviewed 2026-08-26 in "
            "GatewayGuard_FieldResult-PhishingProtection-2026-08-26-1130.md, never applied "
            "to the build -- ascii43 became ascii44 without this line changing. Wording is "
            "the 08-26 draft verbatim, split to fit Write-Host lines. Does not touch CanAuto: "
            "setting 6 is CanAuto=true, so this switch case is live and reachable, unlike "
            "settings 3 and 9 (see FT-263)."
    )

print("Edit applied and file parsed clean.")
