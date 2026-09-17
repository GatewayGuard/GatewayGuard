import sys
sys.path.insert(0, r"C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\Tool2")
from gg_edit import PS1Edit

PS1 = r"C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

OLD = '''                try {
                    $w = (Get-ItemProperty "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Dsh" -EA SilentlyContinue).AllowNewsAndInterests
                    $s.Status = if ($null -eq $w) { "Unknown -- could not check" }
                                elseif ($w -eq 0)  { "DISABLED -- GOOD" }
                                else               { "Enabled -- needs attention" }
                }
                catch { $s.Status = "Unknown -- could not check" }
            }
            15 {'''

NEW = '''                # FT-123b (item 14 closed 2026-09-17): when the POLICY value is
                # absent, this now also checks the user's own TaskbarDa value
                # before giving up and saying Unknown, same fallback shape as
                # items 13 and 15. ***MEASURED on CGDELL 2026-09-17, Bill's
                # field test, a real controlled flip -- not a guessed key:***
                # TaskbarDa read 1 before, 0 after turning Widgets off in the
                # taskbar's own UI, and 1 again after turning it back on.
                try {
                    $w = (Get-ItemProperty "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Dsh" -EA SilentlyContinue).AllowNewsAndInterests
                    if ($null -ne $w) {
                        $s.Status = if ($w -eq 0) { "DISABLED -- GOOD" } else { "Enabled -- needs attention" }
                    } else {
                        $ggDa = (Get-ItemProperty "HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced" -EA SilentlyContinue).TaskbarDa
                        $s.Status = if ($null -eq $ggDa) { "Unknown -- could not check" }
                                    elseif ($ggDa -eq 0)  { "DISABLED -- GOOD" }
                                    else                  { "Enabled -- needs attention" }
                    }
                }
                catch { $s.Status = "Unknown -- could not check" }
            }
            15 {'''

with PS1Edit(PS1) as e:
    e.replace(
        OLD, NEW, count=1,
        why="FT-123b item 14 closed: fall back to the effective TaskbarDa read "
            "when the policy is absent, mirroring items 13/15's pattern, using "
            "the key Bill's field test proved flips with the real toggle."
    )

print("Edit applied, file parsed clean.")
