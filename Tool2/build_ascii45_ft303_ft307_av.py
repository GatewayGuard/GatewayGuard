"""build_ascii45_ft303_ft307_av -- FT-303 and FT-307 (SANDY test run 2026-09-28).

Dated: 2026-09-28 17:25 ET
Editor: Claude Code (CGDELL)
Triage: ProjectDocs\\GatewayGuard_FieldTestTriage-ascii45run1-2026-09-28-1639.md

FT-303 -- an antivirus that is only INSTALLED was treated as IN CHARGE.
  Get-GGOtherAV lists every non-Defender product registered with Windows
  Security, running or not. SANDY has Malwarebytes Free installed and OFF with
  Defender ON (log 14:23:54), yet unwanted-app blocking and virus definitions
  were never checked and the full scan was never offered (log 14:44:59 "Full
  scan offer skipped -- Malwarebytes is the antivirus"), and screen 15 said
  Malwarebytes is the antivirus.
  New Get-GGAVInCharge: another product is in charge only when one is
  registered AND Defender's real-time protection is not on -- the same test the
  item-2 and item-3 APPLY paths already use (build lines ~7453, ~7473). Used at
  the five places that skipped on "registered" alone: Tamper check, PUA check,
  definitions, full-scan offer, and item 3's status.

FT-307 -- screen 14b showed the other antivirus with NO NAME.
  MEASURED on CGDELL 2026-09-28 17:27: one registered product is a single
  System.Management.ManagementObject; $one[0].displayName = "" while
  @($one)[0].displayName = "Windows Defender". SANDY's log line 14:23:54 "Also
  registered (not in charge): " is exactly that. Same pattern at the screen
  shown when another antivirus IS in charge. Both now use @(...)[0].

Run from Tool2/:  python build_ascii45_ft303_ft307_av.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

HELPER = r'''function Get-GGAVInCharge {
    # FT-303 (ascii45, SANDY 2026-09-28): the name of another antivirus ONLY
    # when it is actually in charge -- registered with Windows Security AND
    # Defender's own real-time protection is not on. Installed-but-off
    # products (SANDY's Malwarebytes Free) return "" and Checkup carries on
    # with Defender. Same test as the item-2/3 apply paths.
    $ggOther = @(Get-GGOtherAV)
    if ($ggOther.Count -eq 0) { return "" }
    $ggRT = $null
    try { $ggRT = (Get-MpComputerStatus -EA Stop).RealTimeProtectionEnabled } catch {}
    if ($ggRT -eq $true) { return "" }
    return [string]$ggOther[0]
}

function Get-GGEdgeLocalStateBool {'''

with PS1Edit(TARGET) as e:
    e.replace("function Get-GGEdgeLocalStateBool {", HELPER, count=1, why="FT-303: Get-GGAVInCharge")

    # Tamper check
    e.replace(
        "        $ggOther = @(Get-GGOtherAV)\n"
        "        if ($ggOther.Count -gt 0) {\n"
        "            Add-GGReady \"Tamper\" (\"  NOTE  Tamper Protection is off while \" + $ggOther[0] + \" is your antivirus. That is expected.\")\n",
        "        $ggInCharge = Get-GGAVInCharge   # FT-303: in charge, not merely installed\n"
        "        if ($ggInCharge) {\n"
        "            Add-GGReady \"Tamper\" (\"  NOTE  Tamper Protection is off while \" + $ggInCharge + \" is your antivirus. That is expected.\")\n",
        count=1, why="FT-303: Tamper check")

    # PUA
    e.replace(
        "    $ggOther = @(Get-GGOtherAV)\n"
        "    if ($ggOther.Count -gt 0) {\n"
        "        Add-GGReady \"PUA\" (\"  NOTE  \" + $ggOther[0] + \" is your antivirus, so its own settings apply.\")\n",
        "    $ggInCharge = Get-GGAVInCharge   # FT-303: in charge, not merely installed\n"
        "    if ($ggInCharge) {\n"
        "        Add-GGReady \"PUA\" (\"  NOTE  \" + $ggInCharge + \" is your antivirus, so its own settings apply.\")\n",
        count=1, why="FT-303: PUA check")

    # Definitions
    e.replace(
        "    $ggOther = @(Get-GGOtherAV)\n"
        "    if ($ggOther.Count -gt 0) { return }\n",
        "    if (Get-GGAVInCharge) { return }   # FT-303: in charge, not merely installed\n",
        count=1, why="FT-303: definitions")

    # Full scan
    e.replace(
        "    $ggOther = @(Get-GGOtherAV)\n"
        "    if ($ggOther.Count -gt 0) {\n"
        "        Write-Log -Message (\"Full scan offer skipped -- \" + $ggOther[0] + \" is the antivirus\") -Status \"INFO\"\n",
        "    $ggInCharge = Get-GGAVInCharge   # FT-303: in charge, not merely installed\n"
        "    if ($ggInCharge) {\n"
        "        Write-Log -Message (\"Full scan offer skipped -- \" + $ggInCharge + \" is the antivirus\") -Status \"INFO\"\n",
        count=1, why="FT-303: full scan")

    # Item 3 status
    e.replace(
        "                        $ggOther3 = @(Get-GGOtherAV)\n"
        "                        $s.Status = if ($ggOther3.Count -gt 0) { \"OFF while $($ggOther3[0]) is your antivirus -- see guide\" }",
        "                        $ggInCharge3 = Get-GGAVInCharge   # FT-303\n"
        "                        $s.Status = if ($ggInCharge3) { \"OFF while $ggInCharge3 is your antivirus -- see guide\" }",
        count=1, why="FT-303: item 3 status")

    # FT-307
    e.replace("                $ggAlso = $nonDefender[0].displayName\n",
              "                $ggAlso = @($nonDefender)[0].displayName   # FT-307: [0] on ONE WMI object is blank (measured)\n",
              count=1, why="FT-307: 14b name")
    e.replace("            $avName = $nonDefender[0].displayName\n",
              "            $avName = @($nonDefender)[0].displayName   # FT-307\n",
              count=1, why="FT-307: in-charge screen name")

    e.replace(
        "#           CGDELL 2026-09-27; a spinner and timer run while it works, Bill\n",
        "#           CGDELL 2026-09-27; a spinner and timer run while it works, Bill\n"
        "#   FT-303 (SANDY 2026-09-28): AN INSTALLED-BUT-OFF ANTIVIRUS NO LONGER\n"
        "#           COUNTS AS IN CHARGE (Get-GGAVInCharge). FT-307: its name shows.\n",
        count=1, why="change log")
