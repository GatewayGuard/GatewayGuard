"""build_ascii45_a7_ft285 -- two expected, handled conditions stop logging as
[ERROR] SILENT ERROR.

Dated: 2026-09-26 12:48 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block A, item A7.

FT-285 (measured, SANDY logs 2026-09-19 14:41:01 and 2026-09-20 16:35/17:23):
  1. "Property EnableSmartScreen does not exist at path ..." -- Get-GGPolicyLock
     reading a policy VALUE that is supposed to be absent on a home PC. FT-188
     already treats absent KEYS as expected (INFO); an absent VALUE is the same
     fact. Added to the same benign test.
  2. "Requested registry access is not allowed." -- Tamper Protection refusing
     item 6's write, which Apply-Setting catches ([SecurityException]) and
     answers with the manual steps. A PowerShell catch does NOT remove the
     record from $Error, so Write-PendingErrors logged it again as ERROR.
     FT-245's rule stands -- access denials are never downgraded in general --
     so this one handled site logs its own INFO line and removes ITS record.

Run from Tool2/:  python build_ascii45_a7_ft285.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "#           real failure -- service stopped, 0x80070426 -- was hidden).\n",
        "#           real failure -- service stopped, 0x80070426 -- was hidden).\n"
        "#   FT-285: TWO HANDLED CONDITIONS LOGGED AS [ERROR] SILENT ERROR. An\n"
        "#           absent policy VALUE is now expected-absent like an absent key\n"
        "#           (FT-188); item 6's Tamper Protection refusal logs its own\n"
        "#           INFO and clears its record. Access denials elsewhere stay\n"
        "#           ERROR (FT-245).\n",
        count=1,
        why="change log: FT-285",
    )
    e.replace(
        "                $ggBenign = (($ggMsg -match 'because it does not exist') -or\n"
        "                             ($ggMsg -match 'Cannot find path'))\n",
        "                # FT-285 (ascii45): an absent policy VALUE is the same fact as\n"
        "                # an absent policy KEY -- expected on a home PC, handled by the\n"
        "                # caller (Get-GGPolicyLock). SANDY logged it as ERROR.\n"
        "                $ggBenign = (($ggMsg -match 'because it does not exist') -or\n"
        "                             ($ggMsg -match 'Cannot find path') -or\n"
        "                             ($ggMsg -match '^Property \\S+ does not exist at path'))\n",
        count=1,
        why="FT-285: absent policy value is expected-absent (INFO)",
    )
    e.replace(
        "            } catch [System.Security.SecurityException] {\n"
        "                $result = \"MANUAL REQUIRED -- registry is protected on this PC (Tamper Protection)\"\n",
        "            } catch [System.Security.SecurityException] {\n"
        "                $result = \"MANUAL REQUIRED -- registry is protected on this PC (Tamper Protection)\"\n"
        "                # FT-285 (ascii45): this refusal is expected and handled right\n"
        "                # here (manual steps below). Log it as what it is and remove its\n"
        "                # record, or Write-PendingErrors logs it again as SILENT ERROR.\n"
        "                # Only THIS record: FT-245 keeps access denials ERROR elsewhere.\n"
        "                try { Write-Log -Message \"Item 6: Phishing Protection keys are protected by Tamper Protection -- expected; manual steps shown ($($_.Exception.Message))\" -Status \"INFO\" } catch {}\n"
        "                try { if ($Error.Count -gt 0 -and $Error[0].Exception -is [System.Security.SecurityException]) { $Error.RemoveAt(0) } } catch {}\n",
        count=1,
        why="FT-285: item 6 Tamper refusal logs INFO and clears its own record",
    )
print("A7 applied")
