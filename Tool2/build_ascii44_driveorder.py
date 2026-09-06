"""build_ascii44_driveorder -- screen 12, the SSD is Drive 1.

Bill asked for the drive list to lead with the SSD. It is the first hardware
the customer sees about their own machine, and leading with a slow secondary
disk reads as though that is the main one.

WHAT IT DID: Sort-Object DeviceId -- hardware enumeration order, which is
arbitrary from the customer's point of view.

WHAT IT DOES NOW: SSDs first, then everything else, DeviceId as the tiebreak
inside each group. Stable, and it degrades sensibly with three disks or with
two SSDs, which a plain reverse would not -- a reverse only happens to be
right when there are exactly two drives in exactly the wrong order.

IT USES ONLY THE PROPERTY THE BUILD ALREADY READS. MediaType is already
fetched two lines below to print "(SSD)" in the label, and it already carries
a VERIFIED note:
    VERIFIED 2026-08-17 measured on CGDELL: Get-PhysicalDisk exposes Size and
    a MediaType of 'SSD'. Win32_DiskDrive reports that same drive as 'Fixed
    hard disk media', which is why the type is read from Get-PhysicalDisk.
So no new command, no new property, and no unverified flag.

WHAT I COULD NOT VERIFY, AND IT MATTERS
----------------------------------------
MEASURED on CGDELL 2026-09-06: Get-PhysicalDisk returns exactly ONE disk --
DeviceId=0, MediaType=SSD, 238GB. So the multi-drive ordering this change
exists for CANNOT be observed on this machine, and on CGDELL the output is
byte-identical before and after.

*** THIS NEEDS ONE LOOK AT SCREEN 12 ON SANDY, which has the second drive. ***
It belongs on the ascii44 field checklist. The change is low risk -- it
reorders a display list and touches nothing else -- but "low risk" is not
"verified", and this project's own record is clear about the difference.

An OS-disk-first ordering was considered and rejected: it would mean mapping
Get-Disk .Number onto Get-PhysicalDisk .DeviceId, and that correspondence is
not something I can measure on a single-disk machine either. Sorting on a
property already being read is the smaller claim.

Run from Tool2/:  python build_ascii44_driveorder.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        '        $ggDisks = @(Get-PhysicalDisk -EA SilentlyContinue | Sort-Object DeviceId)\n',
        '        # ascii44, Bill\'s request: THE SSD IS DRIVE 1. This was\n'
        '        # Sort-Object DeviceId -- hardware enumeration order, which means\n'
        '        # nothing to the customer, and it is the first thing screen 12\n'
        '        # tells them about their own machine. SSDs first, everything else\n'
        '        # after, DeviceId as the tiebreak inside each group. Sorting on\n'
        '        # MediaType uses only the property already read two lines below.\n'
        '        # NOT a plain reverse: that is right only with exactly two drives\n'
        '        # in exactly the wrong order, and wrong with three.\n'
        '        # NOT VERIFIED ON A MULTI-DRIVE MACHINE -- measured on CGDELL\n'
        '        # 2026-09-06, Get-PhysicalDisk returns one disk, so the output is\n'
        '        # unchanged here. Check screen 12 on SANDY during the field run.\n'
        '        $ggDisks = @(Get-PhysicalDisk -EA SilentlyContinue |\n'
        '                     Sort-Object @{ Expression = { if ([string]$_.MediaType -eq "SSD") { 0 } else { 1 } } },\n'
        '                                 @{ Expression = { $_.DeviceId } })\n',
        count=1,
        why="Screen 12: SSD first, then the rest, DeviceId as tiebreak (Bill's request)",
    )

    e.replace(
        "# CHANGES FROM ascii39 (2026-08-15 -- ASCII40: THE THREE FIELD BLOCKERS):",
        "#   SCREEN 12: THE SSD IS NOW DRIVE 1, at Bill's request. The list was\n"
        "#           sorted by DeviceId -- hardware enumeration order, which means\n"
        "#           nothing to the customer, on the first screen that tells them\n"
        "#           anything about their own machine. SSDs first, the rest after,\n"
        "#           DeviceId as the tiebreak. Deliberately not a plain reverse,\n"
        "#           which is only correct with exactly two drives in exactly the\n"
        "#           wrong order. NOT VERIFIED ON A MULTI-DRIVE MACHINE: measured\n"
        "#           on CGDELL 2026-09-06, Get-PhysicalDisk returns one disk, so\n"
        "#           the output here is unchanged. Check screen 12 on SANDY.\n"
        "#\n"
        "# CHANGES FROM ascii39 (2026-08-15 -- ASCII40: THE THREE FIELD BLOCKERS):",
        count=1,
        why="Screen 12: header change record",
    )
