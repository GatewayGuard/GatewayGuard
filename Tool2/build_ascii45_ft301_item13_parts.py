"""build_ascii45_ft301_item13_parts -- FT-301: item 13 judges Startup boost
and background running each from its own best source, and reads back.

Dated: 2026-09-28 11:46 ET
Editor: Claude Code (CGDELL)

MEASURED on SANDY 2026-09-28 (Bill), Test_Results\\Items1-4-13-SANDY-2026-09-28_09-18.txt
and _11-41.txt:
  09:18  Edge policy StartupBoostEnabled '0', BackgroundModeEnabled '0';
         Local State startup_boost {"enabled":false,...}, background_mode {"enabled":false}
  11:41  Edge policy StartupBoostEnabled ABSENT, BackgroundModeEnabled '0';
         Local State unchanged (both "enabled":false)
So the "enabled" fields DO exist on SANDY (CGDELL had none), and a PC can
hold ONE of the two policy values. Today's rule -- "if either policy value
exists, GOOD only when BOTH are 0" -- reads SANDY at 11:41 as "Enabled --
needs attention", though Startup boost reads off in Local State. Not a
wrong GOOD, but a wrong verdict.
Now each part is judged alone: its policy value when present, else its Local
State "enabled" field when found, else unknown. Either part on -> needs
attention; both off -> GOOD; otherwise Unknown (keeps it selected, FT-256).
The Local State field's meaning is still NOT flip-proven (both SANDY reads
were already false) -- this does not widen when GOOD can be printed: Local
State false already counted as off before this change.
Apply now reads the two policy values back before GOOD (FT-269 shape).

Run from Tool2/:  python build_ascii45_ft301_item13_parts.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "#   FT-299: item 1 reads a pause (flip-tested) and the NoAutoUpdate policy.\n",
        "#   FT-299: item 1 reads a pause (flip-tested) and the NoAutoUpdate policy.\n"
        "#   FT-301: item 13 judges its two parts separately (SANDY: one policy value).\n",
        count=1, why="change log")

    e.replace(
        "                    $ep = Get-ItemProperty \"HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge\" -EA SilentlyContinue\n"
        "                    if ($ep -and ($null -ne $ep.StartupBoostEnabled -or $null -ne $ep.BackgroundModeEnabled)) {\n"
        "                        $s.Status = if ($ep.StartupBoostEnabled -eq 0 -and $ep.BackgroundModeEnabled -eq 0) { \"DISABLED -- GOOD\" }\n"
        "                                    else { \"Enabled -- needs attention\" }\n"
        "                    } else {\n"
        "                        $ggBoost = Get-GGEdgeLocalStateBool -Section \"startup_boost\" -KeyName \"enabled\"\n"
        "                        $ggBg    = Get-GGEdgeLocalStateBool -Section \"background_mode\" -KeyName \"enabled\"\n"
        "                        $s.Status = if (-not $ggBoost.Found -and -not $ggBg.Found) { \"Unknown -- nothing stored; select it to set it off\" }\n"
        "                                    elseif (($ggBoost.Found -and $ggBoost.Value -eq $true) -or ($ggBg.Found -and $ggBg.Value -eq $true)) { \"Enabled -- needs attention\" }\n"
        "                                    elseif ($ggBoost.Found -and $ggBg.Found -and $ggBoost.Value -eq $false -and $ggBg.Value -eq $false) { \"DISABLED -- GOOD\" }\n"
        "                                    else { \"Unknown -- nothing stored; select it to set it off\" }\n"
        "                    }\n",
        "                    # FT-301 (ascii45): each part from its own best source -- the\n"
        "                    # policy value when present, else Local State. SANDY 2026-09-28\n"
        "                    # held ONE policy value; judging both by \"either exists\" read a\n"
        "                    # Startup boost that Local State showed off as Enabled.\n"
        "                    $ep = Get-ItemProperty \"HKLM:\\SOFTWARE\\Policies\\Microsoft\\Edge\" -EA SilentlyContinue\n"
        "                    $ggParts = @()\n"
        "                    foreach ($ggPart in @(@{ Pol = \"StartupBoostEnabled\"; Sec = \"startup_boost\" }, @{ Pol = \"BackgroundModeEnabled\"; Sec = \"background_mode\" })) {\n"
        "                        $ggPv = $null\n"
        "                        if ($ep) { $ggPv = $ep.($ggPart.Pol) }\n"
        "                        if ($null -ne $ggPv) { $ggParts += $(if ($ggPv -eq 0) { \"off\" } else { \"on\" }) }\n"
        "                        else {\n"
        "                            $ggLs = Get-GGEdgeLocalStateBool -Section $ggPart.Sec -KeyName \"enabled\"\n"
        "                            $ggParts += $(if (-not $ggLs.Found) { \"unknown\" } elseif ($ggLs.Value -eq $true) { \"on\" } elseif ($ggLs.Value -eq $false) { \"off\" } else { \"unknown\" })\n"
        "                        }\n"
        "                    }\n"
        "                    $s.Status = if ($ggParts -contains \"on\") { \"Enabled -- needs attention\" }\n"
        "                                elseif (($ggParts | Where-Object { $_ -eq \"off\" }).Count -eq 2) { \"DISABLED -- GOOD\" }\n"
        "                                else { \"Unknown -- nothing stored; select it to set it off\" }\n"
        "                    try { Write-Log -Message (\"Item 13 parts: startup boost=\" + $ggParts[0] + \", background=\" + $ggParts[1]) -Status \"INFO\" } catch {}\n",
        count=1, why="FT-301: item 13 status by part")

    e.replace(
        "                Set-ItemProperty -Path $rp -Name BackgroundModeEnabled  -Value 0 -Type DWord -Force -EA Stop\n"
        "                $result = \"Edge startup boost and background mode disabled -- GOOD\"\n",
        "                Set-ItemProperty -Path $rp -Name BackgroundModeEnabled  -Value 0 -Type DWord -Force -EA Stop\n"
        "                # FT-301 (ascii45): read both back before GOOD (FT-269 shape).\n"
        "                $ggE13 = Get-ItemProperty -Path $rp -EA SilentlyContinue\n"
        "                $result = if ($ggE13 -and $ggE13.StartupBoostEnabled -eq 0 -and $ggE13.BackgroundModeEnabled -eq 0) { \"Edge startup boost and background mode disabled -- GOOD\" }\n"
        "                          else { \"NOTE: Checkup set this, but could not read it back to confirm. Check by hand: Edge -> Settings -> System and performance -> Startup boost -> Off, and Continue running background extensions and apps -> Off.\" }\n",
        count=1, why="FT-301: item 13 read back")
