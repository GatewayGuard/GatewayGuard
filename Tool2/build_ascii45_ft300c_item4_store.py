"""build_ascii45_ft300c_item4_store -- FT-300: item 4 reads the fourth toggle,
SmartScreen for Microsoft Store apps. Item 4 now covers all four.

Dated: 2026-09-28 14:04 ET
Editor: Claude Code (CGDELL)

MEASURED on CGDELL 2026-09-28 by Bill (Windows Security -> App & browser control
-> Reputation-based protection settings -> SmartScreen for Microsoft Store apps),
Test_Results\\StoreSS-CGDELL-2026-09-28_13-47-12 / 14-01-31 / 14-02-17:
  13:47 on, never changed   HKCU\\...\\CurrentVersion\\AppHost\\EnableWebContentEvaluation ABSENT
  14:01 off                 EnableWebContentEvaluation = 0 (and PreventOverride = 0 appears)
  14:02 on                  EnableWebContentEvaluation = 1
Absent was also read on SANDY in four runs (13:11-13:16) with the switch on.
So: 1 or absent = on (absent = never changed from Windows' default, seen on
BOTH PCs with the switch on); 0 = off. A read that FAILS (not absent) ->
unknown -> item 4 Unknown (FT-256).
Checkup does not write it: an off switch becomes a step on screen 35, like
Edge SmartScreen and app blocking.

Run from Tool2/:  python build_ascii45_ft300c_item4_store.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "#   FT-300: item 4 also reads Edge SmartScreen (flip-proven) and app blocking.\n",
        "#   FT-300: item 4 also reads Edge SmartScreen (flip-proven) and app blocking.\n"
        "#           Store apps too (AppHost EnableWebContentEvaluation, flip-proven).\n",
        count=1, why="change log")

    e.replace(
        "    $ggP = [ordered]@{ Edge = \"unknown\"; PUA = \"unknown\" }\n",
        "    $ggP = [ordered]@{ Edge = \"unknown\"; PUA = \"unknown\"; Store = \"unknown\" }\n",
        count=1, why="FT-300: Store part")

    e.replace(
        "    try { $ggPu = (Get-MpPreference -EA Stop).PUAProtection; if ($ggPu -eq 1) { $ggP.PUA = \"on\" } elseif ($null -ne $ggPu) { $ggP.PUA = \"off\" } } catch {}\n"
        "    try { Write-Log -Message (\"Item 4 parts: Edge SmartScreen=\" + $ggP.Edge + \", unwanted app blocking=\" + $ggP.PUA) -Status \"INFO\" } catch {}\n",
        "    try { $ggPu = (Get-MpPreference -EA Stop).PUAProtection; if ($ggPu -eq 1) { $ggP.PUA = \"on\" } elseif ($null -ne $ggPu) { $ggP.PUA = \"off\" } } catch {}\n"
        "    # VERIFIED 2026-09-28 measured on CGDELL (Bill's flip test): \"SmartScreen for\n"
        "    # Microsoft Store apps\" = HKCU AppHost\\EnableWebContentEvaluation -- absent\n"
        "    # until the switch is first changed (absent with the switch on, on BOTH PCs),\n"
        "    # 0 off, 1 on.\n"
        "    try {\n"
        "        $ggSt = (Get-ItemProperty -Path \"HKCU:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\AppHost\" -Name EnableWebContentEvaluation -EA Stop).EnableWebContentEvaluation\n"
        "        if ($ggSt -eq 0) { $ggP.Store = \"off\" } elseif ($ggSt -eq 1) { $ggP.Store = \"on\" }\n"
        "    } catch [System.Management.Automation.ItemNotFoundException] { $ggP.Store = \"on\"\n"
        "    } catch [System.Management.Automation.PSArgumentException] { $ggP.Store = \"on\"\n"
        "    } catch {}\n"
        "    try { Write-Log -Message (\"Item 4 parts: Edge SmartScreen=\" + $ggP.Edge + \", unwanted app blocking=\" + $ggP.PUA + \", Store apps=\" + $ggP.Store) -Status \"INFO\" } catch {}\n",
        count=1, why="FT-300: Store read")

    e.replace(
        "    if ($Parts.PUA -ne \"on\") { $ggOff += \"Potentially unwanted app blocking (tick Block apps and Block downloads)\" }\n",
        "    if ($Parts.PUA -ne \"on\") { $ggOff += \"Potentially unwanted app blocking (tick Block apps and Block downloads)\" }\n"
        "    if ($Parts.Store -ne \"on\") { $ggOff += \"SmartScreen for Microsoft Store apps (further down the same page)\" }\n",
        count=1, why="FT-300: Store step")

    e.replace(
        "                                    elseif ($gg4.PUA -eq \"off\") { \"Unwanted app blocking is OFF -- needs attention\" }\n"
        "                                    elseif ($gg4.Edge -eq \"on\" -and $gg4.PUA -eq \"on\") { \"ON -- GOOD\" }\n"
        "                                    else { \"Unknown -- could not read SmartScreen for Edge\" }\n",
        "                                    elseif ($gg4.PUA -eq \"off\") { \"Unwanted app blocking is OFF -- needs attention\" }\n"
        "                                    elseif ($gg4.Store -eq \"off\") { \"SmartScreen for Store apps is OFF -- needs attention\" }\n"
        "                                    elseif ($gg4.Edge -eq \"on\" -and $gg4.PUA -eq \"on\" -and $gg4.Store -eq \"on\") { \"ON -- GOOD\" }\n"
        "                                    else { \"Unknown -- could not read every SmartScreen switch\" }\n",
        count=1, why="FT-300: Store in status")
