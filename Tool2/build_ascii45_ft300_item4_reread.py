"""build_ascii45_ft300_item4_reread -- FT-300 (part): item 4 reports GOOD only
after reading the value back.

Dated: 2026-09-28 08:52 ET
Editor: Claude Code (CGDELL)

Co-Pilot's review (2026-09-28) questioned item 4. MEASURED in this build:
Apply-Setting case 4 writes Explorer\SmartScreenEnabled = "Warn" and returns
"-- GOOD" without reading anything back -- the FT-269 shape. Now it re-reads
and says GOOD only when the value reads "Warn".
Measured on CGDELL 2026-09-28 08:51 (Test_Results\Items1-4-13-CGDELL-2026-09-28_08-51.txt):
SmartScreenEnabled = 'Warn'.
NOT built here (needs Bill/Cloud): item 4 reads and writes only "Check apps
and files", while its description says "websites and downloads" and guide 4.2
says Checkup turned "the protections" on (four toggles).

Run from Tool2/:  python build_ascii45_ft300_item4_reread.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "#           line. FT-222: a changed item loses its X.\n",
        "#           line. FT-222: a changed item loses its X.\n"
        "#   FT-300 (part): item 4 re-reads SmartScreenEnabled before saying GOOD.\n",
        count=1, why="change log")
    e.replace(
        "                Set-ItemProperty -Path \"HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\" -Name SmartScreenEnabled -Value \"Warn\" -Force -EA Stop\n"
        "                $result = \"SmartScreen set to Warn (recommended) -- GOOD\"\n",
        "                Set-ItemProperty -Path \"HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\" -Name SmartScreenEnabled -Value \"Warn\" -Force -EA Stop\n"
        "                # FT-300 (ascii45): read it back before saying GOOD (FT-269 shape).\n"
        "                $ggSS = $null\n"
        "                try { $ggSS = (Get-ItemProperty -Path \"HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\" -Name SmartScreenEnabled -EA Stop).SmartScreenEnabled } catch {}\n"
        "                $result = if (\"$ggSS\" -eq \"Warn\") { \"Check apps and files set to Warn (recommended) -- GOOD\" }\n"
        "                          else { \"NOTE: Checkup set this, but could not read it back to confirm. Check by hand: Windows Security -> App & browser control -> Reputation-based protection settings -> Check apps and files -> On.\" }\n",
        count=1, why="FT-300: item 4 re-read")
