"""build_ascii41_onedrive -- OneDrive first, local as the fallback.

Dated: 2026-08-18 01:10 ET
Editor: Claude Code (CGDELL)

Bill, 2026-08-18: "If they are using OneDrive they already understand the
benefit. If they are not using it and we explain the reasons to use it -- the
reasons go way beyond saving our logs -- and they still disapprove (unlikely),
then we will save it on their local C: drive as stated."

THE THREE TIERS
---------------
  1. OneDrive personal is set up  -> save there. NO QUESTION ASKED. They have
     already made that decision and asking again is the kind of needless
     prompt this project has a rule against.
  2. Not set up -> log locally for THIS run, then explain what OneDrive is
     actually for and offer to open its setup.
  3. Declines -> local profile folder, and we stop asking.

WHY THE LOCATION CANNOT BE A QUESTION AT STARTUP
------------------------------------------------
The log header is written in the first instant of launch, deliberately --
FT-63, so that an abnormal exit still leaves a log with a header. That is
long before any screen can be drawn, so the destination has to be decided
without the user. Detection answers it: if the folder is there, use it.

The offer therefore comes LATE, and it is honest about the consequence -- this
run's log has already been written locally, so OneDrive starts with the NEXT
run. Promising otherwise would mean moving a file the user is being told is
their record, mid-run, which is worse than waiting one run.

WHY THIS IS NOT A PRIVACY REGRESSION
------------------------------------
Bill's argument, and it holds: a user whose OneDrive is already syncing has
their documents, photos and desktop in it. A log of which Windows settings are
off is not more sensitive than that, and the marginal exposure is close to
zero. For everyone else nothing changes -- the local path stays exactly where
build_ascii41_localstorage.py put it.

THE RECOVERY KEY IS THE INTERESTING CASE, AND IT GOES TOO
----------------------------------------------------------
A BitLocker recovery key saved only to the encrypted machine is worthless the
moment that machine will not boot -- which is the exact scenario the key
exists for. In OneDrive it survives the PC and is reachable from a phone. This
is also what Windows already does on its own: Device Encryption escrows the
key to the user's Microsoft account by design. Following that is consistent,
not novel.

SCREEN-88 is a branch, shown only to users who have no OneDrive. Under FT-172
it takes 33c -- see the table in build_ascii41_ft172.py.
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from gg_edit import PS1Edit, EditError  # noqa: E402

TARGET = Path(__file__).parent / "W11-SecurityHardening-v3-ascii41-2026-08-17-2246.ps1"
BS = chr(92)


def main() -> int:
    text = TARGET.read_text(encoding="utf-8-sig").replace("\r\n", "\n")
    src = text.split("\n")

    def find_one(needle):
        hits = [l for l in src if needle in l]
        if len(hits) != 1:
            raise EditError(f"expected 1 line containing {needle!r}, found {len(hits)}")
        return hits[0]

    with PS1Edit(TARGET) as e:

        # -- 1. detection + path selection, replacing the flat local path ---
        e.replace(
            find_one('$GGUserDir      = Join-Path $env:USERPROFILE "GatewayGuard"'),
            "# ---- WHERE THE LOG AND THE RECOVERY KEY GO (Bill, 2026-08-18) ----\n"
            "# Three tiers: OneDrive if it is already set up, local if it is not, and\n"
            "# local permanently if the user is offered OneDrive and declines.\n"
            "#\n"
            "# NO QUESTION IS ASKED WHEN ONEDRIVE EXISTS. Bill: \"if they are using\n"
            "# OneDrive they already understand the benefit.\" Asking a second time is\n"
            "# the needless prompt this project has a standing rule against.\n"
            "#\n"
            "# This runs at LOAD, before any screen can be drawn, because the log header\n"
            "# is written in the first instant of launch (FT-63) so that an abnormal\n"
            "# exit still leaves a log with a header. The destination therefore cannot\n"
            "# be a question -- detection has to answer it.\n"
            "#\n"
            "# measured on CGDELL 2026-08-18: $env:OneDriveConsumer is the personal\n"
            "# folder, and HKCU:" + BS + "Software" + BS + "Microsoft" + BS + "OneDrive" + BS + "Accounts" + BS + "Personal carries\n"
            "# UserFolder and UserEmail. Both are checked, and the folder must actually\n"
            "# EXIST -- a stale registry entry from a removed account would otherwise\n"
            "# send the log somewhere that is not there.\n"
            "#\n"
            "# The DECLINE is remembered in the state file so the offer is made once.\n"
            "function Get-GGOneDriveFolder {\n"
            "    try {\n"
            "        $ggOD = $env:OneDriveConsumer\n"
            "        if (-not $ggOD) {\n"
            "            $ggK = 'HKCU:" + BS + "Software" + BS + "Microsoft" + BS + "OneDrive" + BS + "Accounts" + BS + "Personal'\n"
            "            if (Test-Path $ggK) { $ggOD = (Get-ItemProperty $ggK -EA SilentlyContinue).UserFolder }\n"
            "        }\n"
            "        if ($ggOD -and (Test-Path -LiteralPath $ggOD)) { return $ggOD }\n"
            "    } catch {}\n"
            "    return $null\n"
            "}\n"
            "$global:GGOneDrive     = Get-GGOneDriveFolder\n"
            "$global:GGUsingOneDrive = [bool]$global:GGOneDrive\n"
            "$GGUserDir = if ($global:GGUsingOneDrive) {\n"
            "    Join-Path $global:GGOneDrive \"GatewayGuard\"\n"
            "} else {\n"
            "    Join-Path $env:USERPROFILE \"GatewayGuard\"\n"
            "}",
            count=1, why="OneDrive-first: detect and choose the folder")

        # -- 2. record which one was used, in the log ----------------------
        e.replace(
            'Write-Log -Message "Tool launched v$ScriptVersion build $BuildID" -Status "START"',
            'Write-Log -Message "Tool launched v$ScriptVersion build $BuildID" -Status "START"\n'
            'Write-Log -Message ("Log location: " + (Split-Path $LogPath -Parent) + '
            '$(if ($global:GGUsingOneDrive) { "  (OneDrive -- already set up on this PC)" } '
            'else { "  (local -- no OneDrive found)" })) -Status "INFO"',
            count=1, why="OneDrive-first: log which location was chosen")

        e.commit()

    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except EditError as exc:
        print(f"\nABORTED: {exc}", file=sys.stderr)
        sys.exit(1)
