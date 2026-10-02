<!-- Dated: 2026-10-02 12:07 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Screen readings R1-R3 (Cloud's 10-02 list) -- read from Bill's screenshots

- **Source:** Bill's screenshots 31-35, CGDELL, 2026-10-02 10:55-11:00
  (`OneDrive\Personal\Pictures\Screenshots\`). Windows 11 Pro.
- **R4-R8: no screenshots found** (searched the whole user folder for images from
  the last 8 hours: only 31-35). Still to read.
- **Labels:** ***measured*** = read off Bill's screenshot. Exact on-screen text in quotes.

## R1 -- Create a restore point

- **Not captured:** the name box, its button, and the done message. No screenshot
  of the Create dialog exists.
- ***Measured (Windows' own record):*** a restore point was made at **10:56:18 AM**,
  description **"2026-10-02"** (`Get-ComputerRestorePoint`). The System Restore
  pages list it as **"Manual: 2026-10-02"** -- so the name typed shows with
  "Manual:" in front of it.
- System Protection tab (screenshot 31): "Create a restore point right now for the
  drives that have system protection turned on." button **"Create..."**; also
  **"System Restore..."**, **"Configure..."**, **OK / Cancel / Apply**.
  Protection: Windows (C:) (System) **On**; a second volume (`\\?\Volume{8dcb1069...}`) **On**.

## R2 -- System Restore wizard, after picking a restore point

**Page: "Confirm disks to restore"** (screenshot 32) -- appears because a second
volume has protection on:
- "System Restore needs you to confirm which drives you want to restore."
- "Selected restore point: 10/2/2026 10:56:18 AM Manual: 2026-10-02"
- "Current time zone: Eastern Daylight Time"
- Warning: "You must always restore the drive that contains Windows. Restoring other drives is optional."
- Columns **Drive / Status**: the second volume -- "There is not enough free space to restore the disk" (unticked);
  Windows (C:) (System) -- "Ready to restore" (ticked, greyed).
- Buttons: **< Back / Next > / Cancel**.

**Page: "Confirm your restore point"** (screenshots 34, 35):
- "Your computer will be restored to the state it was in before the event in the Description field below."
- Time: "10/2/2026 10:56:18 AM (Eastern Daylight Time)"; Description: "Manual: 2026-10-02"; Drives: "Windows (C:) (System)"
- Link: **"Scan for affected programs"**
- "If you have changed your Windows password recently, we recommend that you create a password reset disk."
- "System Restore needs to restart your computer to apply these changes. Before you proceed, save any open files and close all programs."
- Buttons: **< Back / Finish / Cancel**.

**FINISH WAS CLICKED -- the restore ran** (System log, measured): 11:00:54 Windows
made a restore point "Restore Operation"; 11:01:06 `rstrui.exe` restarted CGDELL
(event 1074); Windows back at 11:07:33, a TrustedInstaller restart, up at 11:08:13.
It restored to 10:56:18, four minutes earlier. **For the guide:** pressing Finish
restarts the PC straight away -- the page's "save any open files" line is the only warning.

## R3 -- "Scan for affected programs" (screenshot 33)

- Title "System Restore". "Description: 2026-10-02"; "Date: 10/2/2026 10:56:18 AM"
- "Any programs that were added since the last restore point will be deleted and any that were removed will be restored."
- "Programs and drivers that will be deleted:" -- columns Description / Type -- **"None detected."**
- "Programs and drivers that might be restored. These programs might not work correctly after restore and might need to be reinstalled:" -- **"None detected."**
- Button: **Close**.
