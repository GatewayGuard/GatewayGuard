"""build_ascii45_g6_item12 -- FT-282 / Decision 11: item 12 (Diagnostic data)
reads the value the Settings switch writes, not only the Group Policy value.

Dated: 2026-09-27 13:23 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, G6 (FT-282) and Block H item H4.

MEASURED 2026-09-27:
  SANDY, "Send optional diagnostic data" OFF (Bill):
    HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection
    AllowTelemetry = 1  (Test_Results\SandyForAscii45-SANDY-2026-09-27_12-45.txt, step 6)
  CGDELL, the same switch ON (Bill): the same value = 3.
  Both PCs: HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection (Group
  Policy, the ONLY place item 12 read) has no AllowTelemetry.
So item 12 said "Sending extra data" on SANDY although optional data was off.

New read: the policy value first (a policy overrides the switch); if there is
none, the Settings value: 0 or 1 -> GOOD, 3 -> needs attention, anything else
or unreadable -> Unknown (never GOOD -- FT-256/257). The apply is unchanged.

Run from Tool2/:  python build_ascii45_g6_item12.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

OLD = ('                try { $dd = (Get-ItemProperty "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\DataCollection" -EA SilentlyContinue).AllowTelemetry; '
       '$s.Status = if ($null -ne $dd -and $dd -le 1) { "Should Send Required Only -- GOOD" } else { "Sending extra data -- we will limit it" } }\n'
       '                catch { $s.Status = "Sending extra data -- we will limit it" }\n')

NEW = r'''                # FT-282 / Decision 11 (ascii45): the policy value first -- a policy
                # overrides the Settings switch. If there is none, the value the
                # switch itself writes. VERIFIED 2026-09-27 measured: switch OFF on
                # SANDY -> 1, switch ON on CGDELL -> 3, at
                # HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection.
                # Registry reads only.
                $ddPol = $null; $ddSet = $null
                try { $ddPol = (Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -EA Stop).AllowTelemetry } catch {}
                try { $ddSet = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -EA Stop).AllowTelemetry } catch {}
                $dd = if ($null -ne $ddPol) { $ddPol } else { $ddSet }
                if ($null -eq $dd) {
                    $s.Status = "Unknown -- could not read; check by hand"
                } elseif ([int]$dd -le 1) {
                    $s.Status = "Should Send Required Only -- GOOD"
                } elseif ([int]$dd -eq 3) {
                    $s.Status = "Sending extra data -- we will limit it"
                } else {
                    $s.Status = "Unknown setting -- check by hand"
                }
                try { Write-Log -Message ("Item 12 (Diagnostic data): policy=" + $ddPol + " settings=" + $ddSet) -Status "INFO" } catch {}
'''

with PS1Edit(TARGET) as e:
    e.replace(OLD, NEW, count=1, why="FT-282: item 12 reads the Settings value too")
    e.replace(
        "#           a Ctrl+C signal handler does. Every answer is read via Read-GGKey.\n",
        "#           a Ctrl+C signal handler does. Every answer is read via Read-GGKey.\n"
        "#   FT-282: ITEM 12 (DIAGNOSTIC DATA) READ ONLY THE GROUP POLICY VALUE, which\n"
        "#           is empty on home PCs, and said \"Sending extra data\" when optional\n"
        "#           data was off. Now reads the Settings value too (measured on SANDY\n"
        "#           and CGDELL 2026-09-27).\n",
        count=1, why="change log: FT-282")
