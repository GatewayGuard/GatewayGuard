"""FT-123b, partial close -- item 15 (Edge Password Saving) gets an effective-
state read, verified before being written.

Dated: 2026-09-16 ET
Editor: Claude Code (CGDELL)
Build:  ascii44 (in place -- still not field run, so still not spent)

Bill asked for Copilot's ascii44 review to be checked and acted on where
warranted. Its P2-3 recommendation -- read Edge's Preferences JSON for
`credentials_enable_service` instead of relying on the policy key alone --
is not new: the build's own header already names this exact gap as FT-123b,
carried since ascii37, and gives the reason it was not built: "RESEARCH
BEFORE STATING and gate 13 ... apply and neither is satisfied yet."

THAT BLOCKER IS NOW CLEARED FOR THIS ONE SETTING, MEASURED, NOT ASSUMED.
Checked on CGDELL 2026-09-16: `%LOCALAPPDATA%\\Microsoft\\Edge\\User Data\\
Default\\Preferences` exists and parses as JSON, and its top-level
`credentials_enable_service` key is present and readable (value: False on
this machine). Copilot's OTHER two suggestions -- `startup_boost_enabled`
and `background_mode.enabled` for item 13 -- do NOT exist as named on this
same file, so FT-123b stays open for items 13 and 14. Building against a key
name nobody has seen in the real file is exactly gate 24's rule, applied to
a JSON path instead of a command flag.

THE FIX. A read of the profile's OWN Preferences file cannot replace the
policy read -- items 12-15 are the settings Checkup itself applies via
policy keys (FT-258), so the policy value is still the authoritative signal
for "did Checkup's own change take." What effective-state adds is the case
FT-123 was written for: a user who changed the setting inside Edge itself,
never touching the policy key at all. So the new read is a SECOND signal,
consulted only when the policy read comes back absent -- it turns some of
the "Unknown" results into a real answer without touching the case that
already works.

WHAT IS STILL NOT KNOWN, on purpose, in the same style as FT-123b's own
disclaimer: this reads the "Default" profile only. A user running multiple
Edge profiles, or a profile literally not named "Default", is not covered,
and the code says so in a comment rather than silently guessing which
profile is "the" one.
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from gg_edit import PS1Edit  # noqa: E402

BUILD = Path(__file__).resolve().parent.parent / "Tool" / \
    "W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

HEADER_OLD = '''#   FT-123b (CARRIED, NOT FIXED): reading the real effective state means
#           parsing the Edge profile Preferences JSON (items 13 and 15) and
#           HKCU\\...\\Explorer\\Advanced\\TaskbarDa (item 14). Those are claims
#           about external software behaviour: RESEARCH BEFORE STATING and
#           gate 13 (documented state-matrix test) both apply and neither is
#           satisfied yet. Reporting Unknown is honest in the meantime. The
#           false BAD was not -- which is why the half that IS provable
#           ships now rather than waiting.'''

HEADER_NEW = '''#   FT-123b (item 15 FIXED 2026-09-16, items 13/14 CARRIED). Copilot's
#           ascii44 review named this same gap independently and proposed
#           reading Edge's Preferences JSON. VERIFIED on CGDELL 2026-09-16:
#           %LOCALAPPDATA%\\Microsoft\\Edge\\User Data\\Default\\Preferences
#           exists, parses, and its top-level credentials_enable_service key
#           is present and readable -- that is item 15, now fixed, using the
#           effective read only when the policy value is absent so Checkup's
#           own applied changes (FT-258) still read from the policy key.
#           Copilot's other two proposed keys do NOT hold up: measured the
#           same file the same day, neither startup_boost_enabled (item 13)
#           nor a top-level background_mode.enabled exists in it. Building
#           against an unseen key name is gate 24's rule, applied to JSON.
#           Items 13 and 14 (TaskbarDa, read but not cross-verified against
#           the real taskbar) stay Unknown-only until that is settled.
#           Known gap, stated rather than guessed: this reads the "Default"
#           profile only. A reader on a second Edge profile is not covered.'''

FUNC_ANCHOR = "function Get-AllStatuses {"

HELPER = '''function Get-GGEdgeEffectiveBool {
    # FT-123b (partial), added 2026-09-16. Reads ONE key out of the user's
    # own Edge profile, for the case FT-123 exists to catch: a setting the
    # user changed inside Edge itself, which the policy key never saw.
    #
    # VERIFIED 2026-09-16 measured on CGDELL: the file exists, parses as
    # JSON, and "credentials_enable_service" is present at the top level.
    # Only that key is called verified -- see the header note by FT-123b for
    # what was checked and did not hold up.
    #
    # Known gap, stated rather than guessed: "Default" profile only.
    param([string]$KeyName)
    $ggPrefPath = Join-Path $env:LOCALAPPDATA "Microsoft\\Edge\\User Data\\Default\\Preferences"
    if (-not (Test-Path -LiteralPath $ggPrefPath)) {
        return @{ Found = $false; Value = $null }
    }
    try {
        $ggJson = Get-Content -LiteralPath $ggPrefPath -Raw -EA Stop | ConvertFrom-Json -EA Stop
    } catch {
        return @{ Found = $false; Value = $null }
    }
    if ($ggJson.PSObject.Properties.Name -notcontains $KeyName) {
        return @{ Found = $false; Value = $null }
    }
    return @{ Found = $true; Value = [bool]$ggJson.$KeyName }
}

'''

STATUS_OLD = '''            15 {
                # FT-123 (ascii37): identical defect to items 13 and 14. Field
                # note 10 (2026-07-27): "also passwords saves was off and tool
                # said it was enabled." The policy value was absent because
                # the user turned password saving off in Edge's own settings,
                # and absent was being reported as enabled.
                try {
                    $ep = (Get-ItemProperty "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge" -EA SilentlyContinue).PasswordManagerEnabled
                    $s.Status = if ($null -eq $ep) { "Unknown -- could not check" }
                                elseif ($ep -eq 0)  { "DISABLED -- GOOD" }
                                else                { "Enabled -- needs attention" }
                }
                catch { $s.Status = "Unknown -- could not check" }
            }'''

STATUS_NEW = '''            15 {
                # FT-123 (ascii37): identical defect to items 13 and 14. Field
                # note 10 (2026-07-27): "also passwords saves was off and tool
                # said it was enabled." The policy value was absent because
                # the user turned password saving off in Edge's own settings,
                # and absent was being reported as enabled.
                # FT-123b (partial, 2026-09-16): when the POLICY value is
                # absent, this now also checks the user's own Edge profile
                # before giving up and saying Unknown -- see
                # Get-GGEdgeEffectiveBool. The policy read stays first and
                # authoritative, because items 12-15 are the settings Checkup
                # itself applies through policy keys (FT-258), so a change
                # Checkup made must still read back from the policy key.
                try {
                    $ep = (Get-ItemProperty "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge" -EA SilentlyContinue).PasswordManagerEnabled
                    if ($null -ne $ep) {
                        $s.Status = if ($ep -eq 0) { "DISABLED -- GOOD" } else { "Enabled -- needs attention" }
                    } else {
                        $ggEff = Get-GGEdgeEffectiveBool -KeyName "credentials_enable_service"
                        $s.Status = if (-not $ggEff.Found) { "Unknown -- could not check" }
                                    elseif ($ggEff.Value -eq $false) { "DISABLED -- GOOD" }
                                    else { "Enabled -- needs attention" }
                    }
                }
                catch { $s.Status = "Unknown -- could not check" }
            }'''


def main():
    with PS1Edit(str(BUILD)) as e:
        e.replace(HEADER_OLD, HEADER_NEW, count=1,
                  why="FT-123b: header records item 15 fixed, 13/14 still open, with what was and was not verified")
        e.replace(FUNC_ANCHOR, HELPER + FUNC_ANCHOR, count=1,
                  why="FT-123b: Get-GGEdgeEffectiveBool, defined before its one caller")
        e.replace(STATUS_OLD, STATUS_NEW, count=1,
                  why="FT-123b: item 15 falls back to the verified effective-state read only when policy is absent")


if __name__ == "__main__":
    main()
