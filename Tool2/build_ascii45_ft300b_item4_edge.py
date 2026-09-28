"""build_ascii45_ft300b_item4_edge -- FT-300: item 4 also reads SmartScreen for
Microsoft Edge and unwanted app blocking before it says GOOD.

Dated: 2026-09-28 13:19 ET
Editor: Claude Code (CGDELL)

Why: the guide's Setting 4 (Guide-Part 2 Core Security Settings-2026-09-16-1122.txt,
line 114) covers websites, downloads and applications -- "Enable available
SmartScreen protections". Item 4 read one toggle of four. W-07: the guide wins.

MEASURED on SANDY 2026-09-28 by Bill (Windows Security -> App & browser control
-> Reputation-based protection settings), Test_Results\\Items1-4-13-SANDY-
2026-09-28_13-11 / 13-13 / 13-14 / 13-16:
  HKCU\\SOFTWARE\\Microsoft\\Edge\\SmartScreenEnabled (default) = 1, 0, 0, 1 --
  follows the SmartScreen for Microsoft Edge toggle. Also '1' on CGDELL.
  HKCU\\...\\AppHost\\EnableWebContentEvaluation absent all four times -- NOT
  where Store apps lives on this Windows. Store apps is NOT read yet
  (Tool2\\Run-FindStoreSmartScreen.bat finds it).
Unwanted app blocking: Get-MpPreference PUAProtection, the E3 read (measured
2026-09-27; 1 on both PCs).
What Checkup CHANGES stays "Check apps and files" only -- writing the Edge
value is not proven to be honoured, so an Edge toggle that is off, or app
blocking that is off, goes to screen 35 as steps. A value that cannot be
read -> Unknown (FT-256). An Edge POLICY, when present, wins (it locks the
toggle): 1 on, 0 off.

Run from Tool2/:  python build_ascii45_ft300b_item4_edge.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

HELPER = r'''function Get-GGSmartScreenParts {
    # FT-300 (ascii45): the other SmartScreen toggles item 4 must see.
    # VERIFIED 2026-09-28 measured on SANDY (Bill's flip test, 1-0-0-1):
    # HKCU\SOFTWARE\Microsoft\Edge\SmartScreenEnabled (default) follows
    # "SmartScreen for Microsoft Edge". PUAProtection = the E3 read.
    $ggP = [ordered]@{ Edge = "unknown"; PUA = "unknown" }
    $ggEp = $null
    try { $ggEp = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name SmartScreenEnabled -EA Stop).SmartScreenEnabled } catch {}
    if ($null -ne $ggEp) { $ggP.Edge = $(if ($ggEp -eq 1) { "on" } else { "off" }) }
    else {
        try {
            $ggEv = (Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Edge\SmartScreenEnabled" -Name "(default)" -EA Stop)."(default)"
            if ("$ggEv" -eq "1") { $ggP.Edge = "on" } elseif ("$ggEv" -eq "0") { $ggP.Edge = "off" }
        } catch {}
    }
    try { $ggPu = (Get-MpPreference -EA Stop).PUAProtection; if ($ggPu -eq 1) { $ggP.PUA = "on" } elseif ($null -ne $ggPu) { $ggP.PUA = "off" } } catch {}
    try { Write-Log -Message ("Item 4 parts: Edge SmartScreen=" + $ggP.Edge + ", unwanted app blocking=" + $ggP.PUA) -Status "INFO" } catch {}
    return $ggP
}

function Get-GGSmartScreenSteps {
    # The by-hand steps for the parts Checkup does not change (screen 35).
    param($Parts)
    $ggOff = @()
    if ($Parts.Edge -ne "on") { $ggOff += "SmartScreen for Microsoft Edge" }
    if ($Parts.PUA -ne "on") { $ggOff += "Potentially unwanted app blocking (tick Block apps and Block downloads)" }
    if ($ggOff.Count -eq 0) { return "" }
    return ("MANUAL: Windows Security -> App & browser control -> Reputation-based protection settings -> turn on: " + ($ggOff -join "; ") + ". Each should say On.")
}

'''

with PS1Edit(TARGET) as e:
    e.replace(
        "#   FT-301: item 13 judges its two parts separately (SANDY: one policy value).\n",
        "#   FT-301: item 13 judges its two parts separately (SANDY: one policy value).\n"
        "#   FT-300: item 4 also reads Edge SmartScreen (flip-proven) and app blocking.\n",
        count=1, why="change log")

    e.replace("function Get-GGUpdateHold {\n", HELPER + "function Get-GGUpdateHold {\n", count=1, why="FT-300: helpers")

    e.replace(
        "                    } elseif (\"$ss\" -eq \"Warn\" -or \"$ss\" -eq \"RequireAdmin\") {\n"
        "                        $s.Status = \"ON -- GOOD\"\n"
        "                    } else {\n"
        "                        $s.Status = \"Unknown setting -- check by hand\"\n"
        "                    }\n",
        "                    } elseif (\"$ss\" -eq \"Warn\" -or \"$ss\" -eq \"RequireAdmin\") {\n"
        "                        # FT-300 (ascii45): GOOD needs the Edge toggle and app\n"
        "                        # blocking on too -- the guide's Setting 4 covers all of them.\n"
        "                        $gg4 = Get-GGSmartScreenParts\n"
        "                        $s.Status = if ($gg4.Edge -eq \"off\") { \"SmartScreen for Edge is OFF -- needs attention\" }\n"
        "                                    elseif ($gg4.PUA -eq \"off\") { \"Unwanted app blocking is OFF -- needs attention\" }\n"
        "                                    elseif ($gg4.Edge -eq \"on\" -and $gg4.PUA -eq \"on\") { \"ON -- GOOD\" }\n"
        "                                    else { \"Unknown -- could not read SmartScreen for Edge\" }\n"
        "                    } else {\n"
        "                        $s.Status = \"Unknown setting -- check by hand\"\n"
        "                    }\n",
        count=1, why="FT-300: item 4 status")

    e.replace(
        "                $result = if (\"$ggSS\" -eq \"Warn\") { \"Check apps and files set to Warn (recommended) -- GOOD\" }\n",
        "                # FT-300: the parts Checkup does not change become steps (screen 35).\n"
        "                $gg4Steps = Get-GGSmartScreenSteps -Parts (Get-GGSmartScreenParts)\n"
        "                $result = if (\"$ggSS\" -eq \"Warn\" -and $gg4Steps) { \"Check apps and files set to Warn. \" + $gg4Steps }\n"
        "                          elseif (\"$ggSS\" -eq \"Warn\") { \"Check apps and files set to Warn (recommended) -- GOOD\" }\n",
        count=1, why="FT-300: item 4 apply steps")
