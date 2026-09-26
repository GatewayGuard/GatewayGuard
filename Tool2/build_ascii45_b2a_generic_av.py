"""build_ascii45_b2a_generic_av -- the verdicts stop depending on Malwarebytes;
one general "is another antivirus in charge?" read replaces it; setting 5 is
retired.

Dated: 2026-09-26 11:16 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block B, item B2 (part a).

WHY (CLAUDE.md, Approved Products): Malwarebytes is out of Checkup (Bill,
2026-09-08; product names out entirely 2026-09-25). But Get-MalwarebytesState
answered a real question for items 2 and 7 -- "does another antivirus hold
real-time protection?" -- and EVERY third-party AV does that. Deleting it
without a general replacement brings back FT-30, FT-33 and FT-114 for every
Norton / McAfee / Bitdefender customer.

THE GENERAL RULE, and why it also covers Malwarebytes:
  Defender real-time ON  -> GOOD, whatever else is installed (a registered
                            companion is not in charge).
  Defender real-time OFF + another AV registered with Windows Security Center
                         -> that product is in charge.
  Malwarebytes registers in SecurityCenter2 only while its trial/Premium runs
  (FT-140: it deregisters at trial expiry) -- exactly when it IS in charge.
  So no Malwarebytes special case is needed.
  NEW (FT-30's own point): when another AV has switched Defender off,
  Get-MpComputerStatus can fail outright; item 2 used to print "Unknown" then.
  It now names the registered product instead.

Also here, because both switch cases called Get-MalwarebytesState:
  SETTING 5 (Defender Periodic Scanning) RETIRED -- Bill's decision 2026-09-08
  (CLAUDE.md): it only means something while another AV holds real-time
  protection. Its settings-table row and both switch cases are removed.
  DO NOT RENUMBER (CLAUDE.md): IDs stay 1-4, 6-19. Typing 5 at the checklist
  now says it is no longer part of Checkup, instead of "item numbers run 1 to
  19".

Get-MalwarebytesState itself stays until B2b removes its last callers (two
log lines in Test-DefenderPrimary and the Malwarebytes follow-up screen).

Run from Tool2/:  python build_ascii45_b2a_generic_av.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"
SRC = open(TARGET, encoding="utf-8-sig").read().replace("\r\n", "\n")


def block(start, next_case):
    """Exact text from the unique start marker up to (not including) the
    next case's opening line."""
    assert SRC.count(start) == 1, (start[:60], SRC.count(start))
    i = SRC.index(start)
    j = SRC.index(next_case, i + len(start))
    return SRC[i:j + 1]          # keep the newline that ends the block


# --- Get-AllStatuses ------------------------------------------------------
ST2 = block("            2 {\n                try {\n                    $mbSt2 = Get-MalwarebytesState\n", "\n            3 {\n")
ST3 = block("            3 {\n                # Tamper Protection is always readable via registry regardless of which AV is active\n", "\n            4 {\n")
ST5 = block("            5 {\n                try {\n                    $mbSt5   = Get-MalwarebytesState\n", "\n            6 {\n")
ST7 = block("            7 {\n                try {\n                    $fw    = Get-NetFirewallProfile -EA Stop\n", "\n            8 {\n")
# --- Apply-Setting ----------------------------------------------------------
AP2 = block("        2 {\n            try {\n                $mbSt2a  = Get-MalwarebytesState\n", "\n        3 {\n")
AP3 = block("        3 {\n            $mbSt3a = Get-MalwarebytesState\n", "\n        4 {\n")
AP5 = block("        5 {\n            try {\n                $mbSt5a = Get-MalwarebytesState\n", "\n        6 {\n")
AP7 = block("        7 {\n            try {\n                Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True -EA Stop\n                $mbSt7a", "\n        8 {\n")
for name, b in [("ST2", ST2), ("ST3", ST3), ("ST5", ST5), ("ST7", ST7), ("AP2", AP2), ("AP3", AP3), ("AP5", AP5), ("AP7", AP7)]:
    print(f"  {name}: {b.count(chr(10))} lines")

NEW_ST2 = """            2 {
                # B2a (ascii45): the Malwarebytes special case is gone. Defender
                # real-time ON is GOOD whatever else is installed; OFF with
                # another AV registered means that product is in charge (FT-30).
                # Every branch ends in a definite status (FT-33) and the healthy
                # one carries the GOOD token (FT-114).
                $ggOther2 = @(Get-GGOtherAV)
                $ggRT2 = $null
                try { $ggRT2 = (Get-MpComputerStatus -EA Stop).RealTimeProtectionEnabled } catch {}
                if ($ggRT2 -eq $true) {
                    $s.Status = "ON -- GOOD"
                } elseif ($ggOther2.Count -gt 0) {
                    $n2    = $ggOther2[0]
                    $isHR2 = ($HighRiskAVList | Where-Object { $n2 -match $_ }).Count -gt 0
                    $s.Status = if ($isHR2) { "!! CRITICAL RISK: $n2 (Russian/Chinese AV)" } else { "$n2 is active as primary AV -- Defender real-time is off" }
                } elseif ($ggRT2 -eq $false) {
                    $s.Status = "OFF -- needs attention"
                } else {
                    $s.Status = "Unknown -- could not read Defender status"
                }
            }
"""
NEW_ST3 = """            3 {
                # Tamper Protection is always readable via registry regardless of which AV is active
                # B2a (ascii45): the Malwarebytes wording is gone. OFF while another
                # AV is in charge is named as such -- Tamper Protection guards
                # Defender, and Defender is not the one running then.
                $tpState = Get-TamperProtectionState
                switch ($tpState) {
                    "On"  { $s.Status = "ON -- GOOD" }
                    "Off" {
                        $ggOther3 = @(Get-GGOtherAV)
                        $s.Status = if ($ggOther3.Count -gt 0) { "OFF while $($ggOther3[0]) is your antivirus -- see guide" } else { "OFF -- turn on in Windows Security (see guide)" }
                    }
                    default { $s.Status = "Could not read -- check in Windows Security" }
                }
            }
"""
NEW_ST7 = """            7 {
                try {
                    $fw    = Get-NetFirewallProfile -EA Stop
                    $allOn = ($fw | Where-Object { -not $_.Enabled }).Count -eq 0
                    # B2a (ascii45): Malwarebytes wording removed; the verdict never depended on it.
                    $s.Status = if ($allOn) { "ALL ON -- GOOD" } else { "One or more profiles OFF -- needs attention" }
                } catch { $s.Status = "Unknown" }
            }
"""
NEW_AP2 = """        2 {
            try {
                # B2a (ascii45): general rule, no Malwarebytes special case. If
                # another AV is registered and Defender real-time is not on, that
                # product is in charge and Defender cannot be turned on beside it.
                $ggOtherA2 = @(Get-GGOtherAV)
                $ggRTA2 = $null
                try { $ggRTA2 = (Get-MpComputerStatus -EA Stop).RealTimeProtectionEnabled } catch {}
                if ($ggOtherA2.Count -gt 0 -and $ggRTA2 -ne $true) {
                    $avName   = $ggOtherA2[0]
                    $isHiRisk = ($HighRiskAVList | Where-Object { $avName -match $_ }).Count -gt 0
                    if ($isHiRisk) {
                        $result = "!! CRITICAL SECURITY RISK: $avName is a Russian or Chinese antivirus. This software may be sending your files and browsing data to foreign government servers. ACTION REQUIRED: (1) Uninstall $avName -- Settings -> Apps -> $avName -> Uninstall. (2) Restart your PC. (3) Confirm Defender is active in Windows Security. Microsoft Defender is a fully capable free AV -- you do not need this product. See Guide: Phase 3, Step 4"
                    } else {
                        $result = "$avName is registered as an antivirus. Defender real-time cannot run simultaneously with another active AV. See Guide: Phase 3, Step 4"
                    }
                } else {
                    Set-MpPreference -DisableRealtimeMonitoring $false -EA Stop
                    $result = "Defender Real-Time Protection enabled -- GOOD"
                }
            } catch { $result = "ERROR: $_ -- If a 3rd-party AV is active, Defender real-time cannot be enabled simultaneously" }
        }
"""
NEW_AP3 = """        3 {
            # B2a (ascii45): general rule, no Malwarebytes branches. FT-263 made
            # this case reachable; it only reads state and builds a message.
            $ggOtherA3 = @(Get-GGOtherAV)
            $ggRTA3 = $null
            try { $ggRTA3 = (Get-MpComputerStatus -EA Stop).RealTimeProtectionEnabled } catch {}
            if ($ggOtherA3.Count -gt 0 -and $ggRTA3 -ne $true) {
                $avName = $ggOtherA3[0]
                $result = "NOTE: $avName is registered as an AV. Tamper Protection cannot be verified while another AV is active. Fix AV status first, then: Windows Security -> Virus & threat protection settings -> Tamper Protection -> On. See Guide: Phase 1, Step 2"
            } else {
                $result = "MANUAL ACTION REQUIRED: Windows Security -> Virus & threat protection -> Virus & threat protection settings -> Tamper Protection -> On. See Guide: Phase 1, Step 2"
            }
        }
"""
NEW_AP7 = """        7 {
            try {
                Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True -EA Stop
                # B2a (ascii45): Malwarebytes wording removed; the result never depended on it.
                $result = "All firewall profiles enabled (Domain, Private, Public) -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
"""
HELPER = """function Get-GGOtherAV {
    # B2a (ascii45): replaces Get-MalwarebytesState for every VERDICT.
    # Returns the display names of antivirus products registered with Windows
    # Security Center other than Defender. Empty = none found. Never throws: a
    # failed read returns empty, and every caller also reads Defender's own
    # real-time state, so an empty answer can never produce a GOOD by itself.
    try {
        $ggAV = Get-WmiObject -Namespace "root\\SecurityCenter2" -Class AntiVirusProduct -EA Stop
        return @($ggAV | Where-Object { $_.displayName -and $_.displayName -notmatch "Windows Defender|Microsoft Defender" } | ForEach-Object { [string]$_.displayName })
    } catch { return @() }
}

"""

with PS1Edit(TARGET, size_tolerance=0.05) as e:
    e.replace(
        "#           old [3] EXIT left with no confirmation.\n",
        "#           old [3] EXIT left with no confirmation.\n"
        "#   B2a:    VERDICTS NO LONGER DEPEND ON MALWAREBYTES. New Get-GGOtherAV\n"
        "#           (other AVs registered in SecurityCenter2) + Defender's own\n"
        "#           real-time state decide items 2, 3 and 7 for ANY third-party\n"
        "#           AV (FT-30/33/114 held). SETTING 5 RETIRED (Bill 2026-09-08);\n"
        "#           IDs not renumbered; typing 5 says it is no longer part of it.\n",
        count=1, why="change log: B2a")
    e.replace("function Get-MalwarebytesState {\n", HELPER + "function Get-MalwarebytesState {\n", count=1,
              why="B2a: add Get-GGOtherAV")
    e.replace(ST2, NEW_ST2, count=1, why="B2a: status 2 -- general rule")
    e.replace(ST3, NEW_ST3, count=1, why="B2a: status 3 -- no Malwarebytes wording")
    e.replace(ST5, "", count=1, why="B2a: status 5 removed (setting retired)")
    e.replace(ST7, NEW_ST7, count=1, why="B2a: status 7 -- no Malwarebytes wording")
    e.replace(AP2, NEW_AP2, count=1, why="B2a: apply 2 -- general rule")
    e.replace(AP3, NEW_AP3, count=1, why="B2a: apply 3 -- general rule")
    e.replace(AP5, "", count=1, why="B2a: apply 5 removed (setting retired)")
    e.replace(AP7, NEW_AP7, count=1, why="B2a: apply 7 -- no Malwarebytes wording")
    e.replace(
        "    [PSCustomObject]@{ ID=5;  Name=\"Defender Periodic Scanning\";        Description=\"Enables Defender background scans if a 3rd-party AV is your primary protection.\";        GuideRef=\"Phase 1, Step 2\";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$true;  Status='Pending' },\n",
        "    # ID 5 (Defender Periodic Scanning) retired in ascii45 (Bill 2026-09-08). DO NOT RENUMBER -- every log names items by ID.\n",
        count=1, why="B2a: setting 5 row removed; IDs unchanged")
    e.replace(
        "                        Write-Host \"  There is no item $id. Item numbers run 1 to $maxId.\" -ForegroundColor Yellow\n",
        "                        # B2a (ascii45): 5 sits inside the range but was retired --\n"
        "                        # say so, rather than claim the numbers run 1 to 19.\n"
        "                        if ($id -ge 1 -and $id -le $maxId) {\n"
        "                            Write-Host \"  Item $id is no longer part of Checkup. Choose another number.\" -ForegroundColor Yellow\n"
        "                        } else {\n"
        "                            Write-Host \"  There is no item $id. Item numbers run 1 to $maxId.\" -ForegroundColor Yellow\n"
        "                        }\n",
        count=1, why="B2a: typing a retired number says so")
print("B2a applied")
