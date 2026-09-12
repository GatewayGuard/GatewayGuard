"""build_ascii41_onedrive_screen -- SCREEN-88, the OneDrive offer.

Dated: 2026-08-18 01:25 ET
Editor: Claude Code (CGDELL)

Bill, 2026-08-18: "...if they are not using it and we explain the reasons to
use it (the reasons go way beyond saving our logs) and they still disapprove
(unlikely) then we will save it on their local C: drive as stated."

SHOWN ONLY TO USERS WITH NO ONEDRIVE. Everyone else never sees it, which is
the point -- a user who already has OneDrive has already made this decision
and asking again is the needless prompt this project has a rule against.

WHY IT IS AN ARGUMENT ABOUT BACKUP AND NOT ABOUT OUR LOG FILE
--------------------------------------------------------------
Bill: "the reasons go way beyond saving our logs." Correct, and it would be a
weak screen otherwise -- nobody sets up cloud storage to hold a diagnostic
file. The reasons that matter to this audience are ransomware (the one attack
that beats every setting on the checklist, because it does not need a
vulnerability once the user clicks), theft or a dead drive, and accidental
deletion. Checkup hardens the machine; none of that helps once the machine is
gone. This is the one recommendation on the list that survives the hardware.

IT IS HONEST ABOUT THE TIMING. The log for THIS run was created before any
screen could be drawn (FT-63 -- the header is written in the first instant of
launch so an abnormal exit still leaves one). So OneDrive starts with the NEXT
run, and the screen says so rather than implying a file will move.

THE DECLINE IS REMEMBERED, using the existing state-file mechanism that
already carries PM=Y/N for the password-manager answer. One line, same shape,
same restore path -- rather than a second mechanism doing the same job.

GATE 12: SCREEN-88 is a branch under FT-172. It hangs off screen 33 -- the
convenience review it follows -- and takes 33c.
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from gg_edit import PS1Edit, EditError  # noqa: E402

TARGET = Path(__file__).parent / "W11-SecurityHardening-v3-ascii41-2026-08-17-2246.ps1"

SCREEN = r'''
function Show-OneDriveOffer {
    # FT-191 (ascii41). Shown ONLY when no OneDrive folder was found.
    if ($global:GGUsingOneDrive) { return }
    if ($global:GGOneDriveDeclined) {
        Write-Log -Message "OneDrive offer skipped -- user declined on an earlier run" -Status "SKIP"
        return
    }
    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "88" -Color Yellow -Lines @(
        "  ONE THING CHECKUP CANNOT PROTECT YOU FROM                 ",
        "---",
        "  Everything on the checklist protects THIS computer. None  ",
        "  of it helps if the computer itself is gone -- stolen, or  ",
        "  dropped, or the drive simply stops one morning.           ",
        "                                                            ",
        "  It also does not stop RANSOMWARE. That is the attack      ",
        "  where your own files are locked and money is demanded.    ",
        "  It does not need a weakness in Windows -- it only needs   ",
        "  one wrong click. A second copy of your files, somewhere   ",
        "  that is not this PC, is what defeats it.                  ",
        "                                                            ",
        "  Windows already includes that: OneDrive. It is free for   ",
        "  5 GB, it is made by Microsoft, and it is already on this  ",
        "  PC -- it has just never been set up. Your files copy      ",
        "  themselves as you work, and you can reach them from a     ",
        "  phone or any other computer.                              ",
        "                                                            ",
        "  Checkup would also keep your log and your encryption      ",
        "  recovery key there. A recovery key saved only on the      ",
        "  encrypted PC is no use on the day that PC will not start. ",
        "                                                            ",
        "  [Y] Show me how to set up OneDrive                        ",
        "  [N] No thank you -- keep everything on this PC only       "
    )
    Write-Host ""
    $ggODAns = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Set up OneDrive? (Y = show me how / N = no thank you): "
    if ($ggODAns.ToUpper() -eq "Y") {
        Write-Log -Message "User asked for OneDrive setup" -Status "INFO"
        Clear-Host
        Write-Host ""
        Draw-Box -ScreenId "89" -Color White -Lines @(
            "  HOW TO SET UP ONEDRIVE                                    ",
            "---",
            "  1. Press the Windows key, type  onedrive  and press Enter ",
            "  2. Sign in. If you have no Microsoft account, click       ",
            "     'Create one' -- it is free and takes a minute.         ",
            "  3. Accept the folder it offers. That is the right one.    ",
            "  4. When it asks which folders to back up, tick Desktop,   ",
            "     Documents and Pictures.                                ",
            "                                                            ",
            "  YOU DO NOT HAVE TO DO IT NOW. Nothing here is waiting on  ",
            "  it and Checkup will finish either way.                    ",
            "                                                            ",
            "  This run's log has already been written to this PC, so    ",
            "  Checkup starts using OneDrive the NEXT time you run it.   "
        )
        Write-Host ""
        try { Start-Process "onedrive.exe" -EA Stop; Write-Log -Message "OneDrive setup launched" -Status "INFO" }
        catch { Write-Log -Message ("Could not launch OneDrive: " + $_) -Status "WARN" }
        Pause-ForUser
    } else {
        $global:GGOneDriveDeclined = $true
        # Re-save the CURRENT checkpoint so the decline reaches the state file
        # without inventing a checkpoint name. Save-Checkpoint's -Checkpoint is
        # mandatory and line 1 of that file must stay the checkpoint and nothing
        # else (FT-127), so the existing value is read back and rewritten.
        $ggCurCp = Get-SavedCheckpoint
        if ($ggCurCp) { Save-Checkpoint -Checkpoint $ggCurCp }
        Write-Log -Message "User declined OneDrive -- log and key stay on this PC only" -Status "SKIP"
        Write-Host ""
        Write-Host "  Understood. Your log and recovery key stay on this PC only." -ForegroundColor Gray
        Write-Host "  You will not be asked again." -ForegroundColor Gray
        Write-Host ""
        Pause-ForUser
    }
}

'''


def main() -> int:
    text = TARGET.read_text(encoding="utf-8-sig").replace("\r\n", "\n")
    src = text.split("\n")

    def find_one(needle):
        hits = [l for l in src if needle in l]
        if len(hits) != 1:
            raise EditError(f"expected 1 line containing {needle!r}, found {len(hits)}")
        return hits[0]

    with PS1Edit(TARGET) as e:

        # -- the screen itself, defined before Show-ManualSteps -------------
        e.replace("function Show-ManualSteps {", SCREEN.lstrip("\n") + "function Show-ManualSteps {",
                  count=1, why="FT-191: define Show-OneDriveOffer")

        # -- called in console mode, after the convenience review -----------
        e.replace(
            find_one("Show-ConvenienceReview   # FT-70"),
            find_one("Show-ConvenienceReview   # FT-70") + "\n"
            "                Show-OneDriveOffer       # FT-191: only if no OneDrive",
            count=1, why="FT-191: call it in console mode")

        # -- remember the decline, same mechanism as PM=Y/N -----------------
        e.replace(
            find_one('        $ggState += ("PM=" + $(if ($global:HasPasswordManager) { "Y" } else { "N" }))'),
            find_one('        $ggState += ("PM=" + $(if ($global:HasPasswordManager) { "Y" } else { "N" }))') + "\n"
            "        # FT-191 (ascii41): the OneDrive decline rides the SAME state file as\n"
            "        # the password-manager answer rather than inventing a second store\n"
            "        # for one boolean. Same shape, same restore path, one thing to break.\n"
            '        if ($global:GGOneDriveDeclined) { $ggState += "OD=N" }',
            count=1, why="FT-191: persist the decline")

        e.replace(
            find_one("            if ($ggLine -match '^\\s*PM=([YN])\\s*$') {"),
            "            if ($ggLine -match '^\\s*OD=N\\s*$') {\n"
            "                $global:GGOneDriveDeclined = $true\n"
            "                Write-Log -Message \"Restored saved answer: OneDrive declined\" -Status \"STATE\"\n"
            "            }\n"
            + find_one("            if ($ggLine -match '^\\s*PM=([YN])\\s*$') {"),
            count=1, why="FT-191: restore the decline")

        e.commit()

    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except EditError as exc:
        print(f"\nABORTED: {exc}", file=sys.stderr)
        sys.exit(1)
