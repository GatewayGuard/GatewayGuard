import sys
sys.path.insert(0, r"C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\Tool2")
from gg_edit import PS1Edit

PS1 = r"C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

NEW_FUNC = '''function Get-GGEdgeLocalStateBool {
    # FT-123b (item 13 closed 2026-09-17). Copilot's proposed key names for
    # Startup Boost and Background Mode were real, but in the wrong file --
    # Get-GGEdgeEffectiveBool checks the per-profile Preferences file, and
    # these two live in Local State, shared across all profiles, one level
    # nested under their own named section, not top-level like item 15's key.
    #
    # MEASURED on CGDELL 2026-09-17, from a live field test (Bill toggled
    # Startup Boost in edge://settings/system while the profile Preferences
    # files were watched -- nothing there changed, which is what sent the
    # search to Local State instead):
    # %LOCALAPPDATA%\\Microsoft\\Edge\\User Data\\Local State exists, parses,
    # and holds "startup_boost":{"enabled":<bool>, "default_last_launch":
    # <bool>, ...} and "background_mode":{"enabled":<bool>}.
    #
    # *Inferred, not flip-proven*: "enabled" is the field the on-screen
    # toggle controls in each section -- the standard Chromium naming for a
    # feature's own on/off field, and the only boolean in background_mode's
    # object -- but the controlled before/after diff that would prove it by
    # watching it flip was interrupted before Bill reached this file.
    # Treated as GOOD/BAD only when found; Unknown otherwise, same caution
    # as item 15's Get-GGEdgeEffectiveBool.
    param([string]$Section, [string]$KeyName)
    $ggLocalStatePath = Join-Path $env:LOCALAPPDATA "Microsoft\\Edge\\User Data\\Local State"
    if (-not (Test-Path -LiteralPath $ggLocalStatePath)) {
        return @{ Found = $false; Value = $null }
    }
    try {
        $ggJson = Get-Content -LiteralPath $ggLocalStatePath -Raw -EA Stop | ConvertFrom-Json -EA Stop
    } catch {
        return @{ Found = $false; Value = $null }
    }
    if ($ggJson.PSObject.Properties.Name -notcontains $Section) {
        return @{ Found = $false; Value = $null }
    }
    $ggSectionObj = $ggJson.$Section
    if ($null -eq $ggSectionObj -or $ggSectionObj.PSObject.Properties.Name -notcontains $KeyName) {
        return @{ Found = $false; Value = $null }
    }
    return @{ Found = $true; Value = [bool]$ggSectionObj.$KeyName }
}

'''

OLD_CASE13_TAIL = '''                try {
                    $ep = Get-ItemProperty "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge" -EA SilentlyContinue
                    $s.Status = if ($ep -and $ep.StartupBoostEnabled -eq 0 -and $ep.BackgroundModeEnabled -eq 0) { "DISABLED -- GOOD" }
                                elseif ($ep -and ($null -ne $ep.StartupBoostEnabled -or $null -ne $ep.BackgroundModeEnabled)) { "Enabled -- needs attention" }
                                else { "Unknown -- could not check" }
                }
                catch { $s.Status = "Unknown -- could not check" }'''

NEW_CASE13_TAIL = '''                # FT-123b (item 13 closed 2026-09-17): when the POLICY value is
                # absent, this now also checks the user's own Edge Local State
                # before giving up and saying Unknown -- see
                # Get-GGEdgeLocalStateBool. The policy read stays first and
                # authoritative, same reasoning as item 15 (FT-258, items
                # 12-15 are set through policy keys, so Checkup's own change
                # must still read back from the policy key first). A partial
                # effective read (one key found, the other not) reports
                # Unknown rather than guessing the missing half.
                try {
                    $ep = Get-ItemProperty "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge" -EA SilentlyContinue
                    if ($ep -and ($null -ne $ep.StartupBoostEnabled -or $null -ne $ep.BackgroundModeEnabled)) {
                        $s.Status = if ($ep.StartupBoostEnabled -eq 0 -and $ep.BackgroundModeEnabled -eq 0) { "DISABLED -- GOOD" }
                                    else { "Enabled -- needs attention" }
                    } else {
                        $ggBoost = Get-GGEdgeLocalStateBool -Section "startup_boost" -KeyName "enabled"
                        $ggBg    = Get-GGEdgeLocalStateBool -Section "background_mode" -KeyName "enabled"
                        $s.Status = if (-not $ggBoost.Found -and -not $ggBg.Found) { "Unknown -- could not check" }
                                    elseif (($ggBoost.Found -and $ggBoost.Value -eq $true) -or ($ggBg.Found -and $ggBg.Value -eq $true)) { "Enabled -- needs attention" }
                                    elseif ($ggBoost.Found -and $ggBg.Found -and $ggBoost.Value -eq $false -and $ggBg.Value -eq $false) { "DISABLED -- GOOD" }
                                    else { "Unknown -- could not check" }
                    }
                }
                catch { $s.Status = "Unknown -- could not check" }'''

with PS1Edit(PS1) as e:
    e.replace(
        "function Get-GGEdgeEffectiveBool {",
        NEW_FUNC + "function Get-GGEdgeEffectiveBool {",
        count=1,
        why="FT-123b item 13: add Get-GGEdgeLocalStateBool, the Local-State-file "
            "counterpart to Get-GGEdgeEffectiveBool, using the real keys found in "
            "Bill's 2026-09-17 field test."
    )
    e.replace(
        OLD_CASE13_TAIL, NEW_CASE13_TAIL, count=1,
        why="FT-123b item 13 closed: fall back to the effective Local State read "
            "when the policy is absent, mirroring item 15's existing pattern exactly."
    )

print("Both edits applied, file parsed clean.")
