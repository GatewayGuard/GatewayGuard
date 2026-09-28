"""build_ascii45_ft299_item1_pause -- FT-299: item 1 no longer says GOOD while
updates are paused or turned off by a policy.

Dated: 2026-09-28 09:06 ET
Editor: Claude Code (CGDELL)

FT-299 (Co-Pilot's review, checked): item 1 said "Enabled -- GOOD" from the
service start type alone (Get-AllStatuses case 1).

MEASURED, flip test by Bill on CGDELL 2026-09-28 (Settings -> Windows Update ->
Pause for 1 week, then Resume):
  09:02 before   PauseUpdatesExpiryTime absent
  09:03 paused   HKLM\\SOFTWARE\\Microsoft\\WindowsUpdate\\UX\\Settings
                 PauseUpdatesExpiryTime = '2026-10-05T13:02:18Z' (also
                 PauseUpdatesStartTime, PauseQualityUpdatesEndTime,
                 PauseFeatureUpdatesEndTime)
  09:06 resumed  all four absent again; wuauserv StartType Manual throughout
Files: Test_Results\\Items1-4-13-CGDELL-2026-09-28_09-02 / 09-03 / 09-06.txt
SOURCED: HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU NoAutoUpdate
= 1 turns automatic updates off -- Microsoft Learn, "Manage additional Windows
Update settings" (learn.microsoft.com/windows/deployment/update/waas-wu-settings),
Configure Automatic Updates. Not present on CGDELL.

Status: Disabled -> as before; paused until a future time -> "PAUSED until
<date> -- needs attention"; a pause value that will not parse -> Unknown
(keeps the item selected, FT-256); NoAutoUpdate = 1 -> needs attention.
Apply: a pause or a policy is not undone by Checkup -- it gives the steps
(screen 35). Otherwise the service change as before, now read back before
GOOD (FT-269 shape).
Updates that were offered and not installed at screen 14g are NOT a reason
here: Windows installs those on its own schedule, and item 1's change would
not install them.

Run from Tool2/:  python build_ascii45_ft299_item1_pause.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

HELPER = r'''function Get-GGUpdateHold {
    # FT-299 (ascii45): what can stop updates while the service looks fine.
    # VERIFIED 2026-09-28 measured on CGDELL (Bill's flip test): Settings ->
    # Pause writes UX\Settings PauseUpdatesExpiryTime ('2026-10-05T13:02:18Z',
    # UTC); Resume removes it.
    # VERIFIED 2026-09-28 sourced: learn.microsoft.com/windows/deployment/update/
    # waas-wu-settings -- AU\NoAutoUpdate = 1 turns automatic updates off.
    $ggHold = [ordered]@{ Paused = $false; Until = $null; Unreadable = $false; Policy = $false }
    try {
        $ggPx = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name PauseUpdatesExpiryTime -EA Stop).PauseUpdatesExpiryTime
        if ($ggPx) {
            $ggWhen = [datetime]::MinValue
            if ([datetime]::TryParse([string]$ggPx, [Globalization.CultureInfo]::InvariantCulture, [Globalization.DateTimeStyles]::AdjustToUniversal -bor [Globalization.DateTimeStyles]::AssumeUniversal, [ref]$ggWhen)) {
                if ($ggWhen -gt [datetime]::UtcNow) { $ggHold.Paused = $true; $ggHold.Until = $ggWhen.ToLocalTime() }
            } else { $ggHold.Unreadable = $true }
        }
    } catch [System.Management.Automation.ItemNotFoundException] {
    } catch [System.Management.Automation.PSArgumentException] {
    } catch { $ggHold.Unreadable = $true }
    try {
        $ggNo = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name NoAutoUpdate -EA Stop).NoAutoUpdate
        if ($ggNo -eq 1) { $ggHold.Policy = $true }
    } catch {}
    try { Write-Log -Message ("Item 1 hold read: paused=" + $ggHold.Paused + " until=" + $ggHold.Until + " unreadable=" + $ggHold.Unreadable + " policy=" + $ggHold.Policy) -Status "INFO" } catch {}
    return $ggHold
}

'''

with PS1Edit(TARGET) as e:
    e.replace(
        "#   FT-300 (part): item 4 re-reads SmartScreenEnabled before saying GOOD.\n",
        "#   FT-300 (part): item 4 re-reads SmartScreenEnabled before saying GOOD.\n"
        "#   FT-299: item 1 reads a pause (flip-tested) and the NoAutoUpdate policy.\n",
        count=1, why="change log")

    e.replace("function Get-AllStatuses {\n", HELPER + "function Get-AllStatuses {\n", count=1, why="FT-299: helper")

    e.replace(
        "                try { $svc = Get-Service wuauserv -EA Stop; $s.Status = if ($svc.StartType -ne 'Disabled') { \"Enabled -- GOOD\" } else { \"DISABLED -- needs attention\" } }\n"
        "                catch { $s.Status = \"Unknown\" }\n",
        "                # FT-299 (ascii45): the service alone is not enough -- a pause or a\n"
        "                # policy stops updates while the service looks fine.\n"
        "                try {\n"
        "                    $svc = Get-Service wuauserv -EA Stop\n"
        "                    $ggHold1 = Get-GGUpdateHold\n"
        "                    $s.Status = if ($svc.StartType -eq 'Disabled') { \"DISABLED -- needs attention\" }\n"
        "                                elseif ($ggHold1.Policy) { \"Turned off by a policy -- needs attention\" }\n"
        "                                elseif ($ggHold1.Paused) { \"PAUSED until \" + $ggHold1.Until.ToString(\"MMM d\") + \" -- needs attention\" }\n"
        "                                elseif ($ggHold1.Unreadable) { \"Unknown -- could not read the pause setting\" }\n"
        "                                else { \"Enabled -- GOOD\" }\n"
        "                }\n"
        "                catch { $s.Status = \"Unknown\" }\n",
        count=1, why="FT-299: item 1 status")

    e.replace(
        "            try {\n"
        "                Set-Service -Name wuauserv -StartupType Automatic -EA Stop\n"
        "                Start-Service -Name wuauserv -EA SilentlyContinue\n"
        "                Set-Service -Name UsoSvc -StartupType Automatic -EA SilentlyContinue\n"
        "                $result = \"Windows Update service set to Automatic and started -- GOOD\"\n"
        "            } catch { $result = \"ERROR: $_\" }\n",
        "            # FT-299 (ascii45): Checkup does not undo a pause or a policy -- it\n"
        "            # shows the steps (screen 35). Otherwise the service, read back.\n"
        "            $ggHoldA = Get-GGUpdateHold\n"
        "            if ($ggHoldA.Policy) {\n"
        "                $result = \"MANUAL: A policy on this PC turns automatic updates off. If you did not set it, ask whoever set up this PC. The policy is 'Configure Automatic Updates' in Group Policy (Windows 11 Pro).\"\n"
        "            } elseif ($ggHoldA.Paused -or $ggHoldA.Unreadable) {\n"
        "                $result = \"MANUAL: Updates are paused. To turn them back on by hand: Settings -> Windows Update -> Resume updates.\"\n"
        "            } else {\n"
        "                try {\n"
        "                    Set-Service -Name wuauserv -StartupType Automatic -EA Stop\n"
        "                    Start-Service -Name wuauserv -EA SilentlyContinue\n"
        "                    Set-Service -Name UsoSvc -StartupType Automatic -EA SilentlyContinue\n"
        "                    $ggSt1 = $null\n"
        "                    try { $ggSt1 = (Get-Service wuauserv -EA Stop).StartType } catch {}\n"
        "                    $result = if (\"$ggSt1\" -eq \"Automatic\") { \"Windows Update service set to Automatic and started -- GOOD\" }\n"
        "                              else { \"NOTE: Checkup set the Windows Update service to start on its own, but could not read it back to confirm. Check: Settings -> Windows Update.\" }\n"
        "                } catch { $result = \"ERROR: $_\" }\n"
        "            }\n",
        count=1, why="FT-299: item 1 apply")
