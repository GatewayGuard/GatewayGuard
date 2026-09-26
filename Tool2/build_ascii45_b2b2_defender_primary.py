"""build_ascii45_b2b2_defender_primary -- the antivirus-status check (screens
17, 17a-e) stops special-casing Malwarebytes; Get-MalwarebytesState is
deleted.

Dated: 2026-09-26 11:21 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block B, item B2 (part b-2).

Test-DefenderPrimary, measured before this edit (ascii45 lines 4684-4948):
  17a (ID 41) high-risk AV: step "4. Optional companion: Malwarebytes FREE"
       + affiliate link -> removed (no product but Defender is named).
  17b (ID 42) "Malwarebytes trial is handling protection" -> REMOVED; the
       generic 17c covers any product in charge, Malwarebytes included.
  17  (ID 43) healthy setup: shown when Defender is on AND another product
       is registered. Kept, worded generically ("Also installed: <name>").
  17c (ID 44) another AV in charge: was "not Malwarebytes"; now any.
  17d (ID 45) "Malwarebytes is on duty" -> REMOVED (unreachable once 17c is
       general, and it named a product).
  17e (ID 46) Defender off alarm: log line no longer calls the MB check.
  Names Windows REPORTS for an installed product (e.g. "$avName") are kept:
  the user needs them to act, and they are detection, not a recommendation.
  Get-MalwarebytesState had its last two callers here and is deleted.

Run from Tool2/:  python build_ascii45_b2b2_defender_primary.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"
SRC = open(TARGET, encoding="utf-8-sig").read().replace("\r\n", "\n")


def span(start, end):
    assert SRC.count(start) == 1, (start[:70], SRC.count(start))
    i = SRC.index(start)
    j = SRC.index(end, i + len(start)) + len(end)
    return SRC[i:j]


MB_TRIAL = span("        if ($mbFree) {\n            # Check if MB took over real-time -- use Get-MpComputerStatus (reliable)\n",
                "                Pause-ForUser\n                return\n            }\n        }\n\n")
assert 'ScreenId "42"' in MB_TRIAL and 'ScreenId "43"' not in MB_TRIAL
HEALTHY = span("            if ($mbFree) {\n                # MB registered in SC2 but Defender RT is on -- MB is companion only\n",
               "                Write-Log -Message \"Defender active as primary AV. MB Free installed as companion.\" -Status \"OK\"\n")
assert 'ScreenId "43"' in HEALTHY
HANDOFF = span("        } elseif ($nonDefender | Where-Object { $_.displayName -match \"Malwarebytes\" }) {\n",
               "            Write-Log -Message \"Defender RT off, Malwarebytes registered in SC2 -- handoff explanation shown (no alarm)\" -Status \"OK\"\n            Pause-ForUser\n")
assert 'ScreenId "45"' in HANDOFF and 'ScreenId "46"' not in HANDOFF
MBSTATE = span("function Get-MalwarebytesState {\n", "    } catch { return \"Unknown\" }\n}\n\n")
assert MBSTATE.count("\nfunction ") == 0
print(f"blocks: trial {MB_TRIAL.count(chr(10))}, healthy {HEALTHY.count(chr(10))}, handoff {HANDOFF.count(chr(10))}, mbstate {MBSTATE.count(chr(10))}")

HEALTHY_NEW = (
    "            if ($nonDefender) {\n"
    "                # B2b-2 (ascii45): another product is registered but Defender's\n"
    "                # real-time is on -- Defender is in charge, the other is not.\n"
    "                $ggAlso = $nonDefender[0].displayName\n"
    "                Clear-Host\n"
    "                Write-Host \"\"\n"
    "                Draw-Box -ScreenId \"43\" -Color White -Lines @(\n"
    "                    \"  OK  ANTIVIRUS STATUS -- HEALTHY SETUP                    \",\n"
    "                    \"---\",\n"
    "                    \"  Microsoft Defender: ACTIVE -- watching your PC in real   \",\n"
    "                    \"  time.                                                    \",\n"
    "                    \"  Also installed:     $ggAlso\",\n"
    "                    \"                                                            \",\n"
    "                    \"  Only one antivirus can watch in real time, and on this   \",\n"
    "                    \"  PC it is Defender. The other program is installed but   \",\n"
    "                    \"  is not in charge. This is fine.                          \",\n"
    "                    \"                                                            \",\n"
    "                    \"  What you see in Windows Security:                        \",\n"
    "                    \"  Both may appear under Virus & threat protection.         \",\n"
    "                    \"  Defender is listed as 'On' -- this is correct.           \"\n"
    "                )\n"
    "                Write-Host \"\"\n"
    "                Write-Log -Message \"Defender active as primary AV. Also registered (not in charge): $ggAlso\" -Status \"OK\"\n"
)

with PS1Edit(TARGET, size_tolerance=0.05) as e:
    e.replace(
        "#           removed. Numbering gap closed by the renumber pass after Block E.\n",
        "#           removed. Numbering gap closed by the renumber pass after Block E.\n"
        "#   B2b-2:  ANTIVIRUS CHECK (17, 17a-e) IS GENERAL. 17b (MB trial) and 17d\n"
        "#           (MB on duty) removed -- 17c covers any product in charge; 17's\n"
        "#           healthy screen names whatever else is installed; the high-risk\n"
        "#           screen no longer suggests Malwarebytes. Get-MalwarebytesState\n"
        "#           deleted (no callers left).\n",
        count=1, why="change log: B2b-2")
    e.replace("        $mbFree     = $avProducts | Where-Object { $_.displayName -match \"Malwarebytes\" }\n", "",
              count=1, why="B2b-2: drop $mbFree")
    e.replace(
        "                \"  4. Optional companion: Malwarebytes FREE (manual scans)   \",\n"
        "                \"     $AffiliateMalwarebytes\",\n"
        "                \"     (Free version only -- do NOT activate real-time)        \",\n",
        "", count=1, why="B2b-2: 17a -- no Malwarebytes suggestion")
    e.replace(MB_TRIAL, "", count=1, why="B2b-2: remove 17b (MB trial)")
    e.replace(
        "        # Determine if MB Free is the only non-Defender AV (companion scenario -- OK)\n"
        "        $nonMbNonDefender = $nonDefender | Where-Object { $_.displayName -notmatch \"Malwarebytes\" }\n\n",
        "", count=1, why="B2b-2: no Malwarebytes exclusion")
    e.replace(HEALTHY, HEALTHY_NEW, count=1, why="B2b-2: 17 healthy screen, general")
    e.replace(
        "        } elseif ($nonMbNonDefender) {\n"
        "            # A different 3rd-party AV is active, not MB\n"
        "            $avName = $nonMbNonDefender[0].displayName\n",
        "        } elseif ($nonDefender) {\n"
        "            # B2b-2 (ascii45): ANY other product in charge (Malwarebytes included)\n"
        "            $avName = $nonDefender[0].displayName\n",
        count=1, why="B2b-2: 17c covers any product in charge")
    e.replace(HANDOFF, "", count=1, why="B2b-2: remove 17d (MB on duty)")
    e.replace(
        "            Write-Log -Message (\"Defender-off ALARM context: mbState=\" + (Get-MalwarebytesState) + \" SC2 count=\" + (@($nonDefender).Count)) -Status \"WARN\"\n",
        "            Write-Log -Message (\"Defender-off ALARM context: SC2 count=\" + (@($nonDefender).Count)) -Status \"WARN\"\n",
        count=1, why="B2b-2: alarm log without the MB check")
    e.replace(MBSTATE, "", count=1, why="B2b-2: delete Get-MalwarebytesState")
    for row in ['    "42" = "17b"          # Antivirus -- alternative state\n',
                '    "45" = "17d"          # Antivirus -- alternative state\n']:
        e.replace(row, "", count=1, why="B2b-2: screen-table row removed -- " + row.strip()[:14])
print("B2b-2 applied")
