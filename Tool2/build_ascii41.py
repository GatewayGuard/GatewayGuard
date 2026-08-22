"""build_ascii41 -- ascii40 -> ascii41, guarded.

Dated: 2026-08-17 22:46 ET
Editor: Claude Code (CGDELL)

Every edit goes through gg_edit.PS1Edit, per CodingStandards PYTHON EDITING
RULES. Nothing is written unless every count assertion passes, braces balance,
the size delta is plausible, and the result parses with 0 errors.

EVERY ANCHOR IS CAPTURED BY LINE NUMBER FROM THE FILE ITSELF, never retyped.
A hand-typed anchor is a second copy of the source that can disagree with it,
and the count assertion then fails for a reason that has nothing to do with
the edit. Slice it, do not type it.

WHAT THIS BUILD CLOSES
----------------------
  FT-184  the identity banner was painted and erased inside one second. CUT.
          Bill, 2026-08-17: "no senior including me is going to remember that."
          Nothing is lost -- intro screen 3 already prints the same version,
          build and Machine ID, on a screen that pauses.
  FT-189  the build and Machine ID can now be FETCHED on demand: I at any
          prompt, plus Open-My-Log.bat.
  FT-173  an unrecognised key at a Read-ValidKey prompt was discarded in TOTAL
          SILENCE -- nothing distinguished "that key does nothing here" from
          "the program has frozen". Fixed once, centrally, for all 56 sites.
  FT-178  Select-Object -First 1 DISCARDED every disk but one. Field-reported
          twice: ascii39 finding 13, ascii40 run 1 finding 3.
  FT-175b the repeat-run branch of Show-PreScanGate never offered the offline
          scan. ascii39 finding 38, still open in ascii40, proven again by the
          2026-08-17 SANDY log: SCREEN-39 rendered, SCREEN-38 never did.
  FT-186  "click Settings (the gear)" is not a universal route. The gear moves
          between Start layouts; typing does not.
  FT-188  absent policy keys were logged as ERROR in the file the customer is
          told to email to support.

NOT IN THIS SCRIPT
------------------
  FT-172  the numbering table. Structural -- build_ascii41_ft172.py.
  FT-185  Edge item 6 (SmartScreen). The replacement registry read has NOT
          been verified on a live machine, and gate 24 forbids shipping a read
          that has not been. Deferred deliberately rather than guessed.
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from gg_edit import PS1Edit, EditError  # noqa: E402

TOOL = Path(__file__).parent
TARGET = TOOL / "W11-SecurityHardening-v3-ascii41-2026-08-17-2246.ps1"

OLD_NAME = "W11-SecurityHardening-v3-ascii40-2026-08-15-0828.ps1"
NEW_NAME = "W11-SecurityHardening-v3-ascii41-2026-08-17-2246.ps1"


def pad(s: str, width: int) -> str:
    """Keep a box content line exactly as wide as the one it replaces.

    Write-GGBox sets the box width from its longest line, so a copy edit that
    changes a length silently changes the box. FT-117 and FT-122 are both
    width defects and are not worth re-earning over wording.
    """
    if len(s) > width:
        raise EditError(f"line too long: {len(s)} > {width}\n  {s!r}")
    return s + " " * (width - len(s))


def dedent4(s: str) -> str:
    """Lift a block out of one `if` level. Blank lines stay blank."""
    out = []
    for ln in s.split("\n"):
        if ln.startswith("    ") and ln.strip():
            out.append(ln[4:])
        else:
            out.append(ln)
    return "\n".join(out)


def main() -> int:
    text = TARGET.read_text(encoding="utf-8-sig").replace("\r\n", "\n")
    src = text.split("\n")

    def block(first: int, last: int) -> str:
        """Exact source slice, 1-indexed inclusive."""
        return "\n".join(src[first - 1:last])

    # Captured BEFORE any edit, so every anchor is the real bytes on disk.
    A_OFFLINE = block(3860, 3905)      # the offline-scan offer, inside `if`
    A_DISK = block(3624, 3628)         # baseline storage line
    A_EST = block(6737, 6737)          # BitLocker estimator disk pick
    A_PENDING = block(2727, 2727)      # SILENT ERROR log line
    A_SCR80 = block(7145, 7145)        # "click Settings (the gear)"
    A_SCR81 = block(7175, 7177)        # "type Device Encryption"
    A_BANNER = block(8486, 8489)       # the erased identity banner
    # Read-NavKey carries a byte-identical copy of the FT-69 comment and the
    # Ctrl+C line, so the two-line slice matched BOTH and the count assertion
    # fired -- correctly. The lines that differ are the reads above them:
    # Read-ValidKey has "$k = " (one space), Read-NavKey has "$k  = " (two)
    # and a $vk line. Anchor from the read down, so the slice is unique.
    A_CTRLC = block(2308, 2311)        # Ctrl+C guard inside Read-ValidKey

    # Sanity: the slices must be what we think they are. A silent off-by-one
    # here would hand a wrong-but-unique anchor to replace(), and the count
    # assertion would pass while editing the wrong place.
    checks = [
        (A_OFFLINE, "Automated offline scan confirmation"),
        (A_DISK, "Win32_DiskDrive"),
        (A_EST, "Get-PhysicalDisk"),
        (A_PENDING, "SILENT ERROR at "),
        (A_SCR80, "the gear"),
        (A_SCR81, "Device Encryption"),
        (A_BANNER, "Machine ID:"),
        (A_CTRLC, "Invoke-CtrlCExit"),
    ]
    for i, (blk, needle) in enumerate(checks):
        if needle not in blk:
            raise EditError(
                f"ANCHOR {i} IS NOT WHAT IT CLAIMS: expected {needle!r}.\n"
                f"  got: {blk[:160]!r}\n"
                f"  The file moved under the line numbers. Re-measure before editing."
            )
    print(f"  [anchor] {len(checks)} slices verified against their content")

    with PS1Edit(TARGET) as e:

        # ---------------------------------------------------------------
        # BUILD IDENTITY -- 3 of the 5 locations. The filename was done by
        # the copy; CLAUDE.md is done separately.
        # ---------------------------------------------------------------
        e.replace(f"# FILE:    {OLD_NAME}", f"# FILE:    {NEW_NAME}",
                  count=1, why="build id: FILE header")
        e.replace("# BUILD:   ascii40  |  Version 3.1",
                  "# BUILD:   ascii41  |  Version 3.1",
                  count=1, why="build id: BUILD header")
        e.replace('$BuildID        = "ascii40"', '$BuildID        = "ascii41"',
                  count=1, why="build id: $BuildID")

        # ---------------------------------------------------------------
        # FT-184 -- cut the erased banner.
        # ---------------------------------------------------------------
        e.replace(
            A_BANNER,
            "# FT-184 (ascii41): the four-line identity banner that stood here was\n"
            "# painted and then wiped by Show-ResumePrompt's Clear-Host about a\n"
            "# second later -- Bill's ascii39 finding 1 and ascii40 finding 1a,\n"
            "# \"something flashes by before you get to screen 1\".\n"
            "# On the proposal to give it a pause instead, Bill 2026-08-17: \"no\n"
            "# senior including me is going to remember that.\" That disposes of the\n"
            "# fix rather than adjusting it -- the build number and Machine ID are\n"
            "# wanted on a support call days later, so no screen shown at launch can\n"
            "# serve the purpose. FETCH beats DISPLAY. Replaced by FT-189.\n"
            "# Nothing is lost by deleting it: intro screen 3 already prints the\n"
            "# same version, build and Machine ID, and it pauses.",
            count=1, why="FT-184: banner cut, replaced by FT-189")

        # ---------------------------------------------------------------
        # FT-178 -- report every disk, not the first one.
        # ---------------------------------------------------------------
        e.replace(
            A_DISK,
            "    try {\n"
            "        # FT-178 (ascii41): this read Win32_DiskDrive | Select-Object -First 1\n"
            "        # and threw every other disk away. SANDY has two and this screen has\n"
            "        # always shown one. Reported twice from the field -- ascii39 finding\n"
            "        # 13 and ascii40 run 1 finding 3 -- because it was never a detection\n"
            "        # failure. The second disk was discarded by construction.\n"
            "        # VERIFIED 2026-08-17 measured on CGDELL: Get-PhysicalDisk exposes\n"
            "        # Size and a MediaType of 'SSD'. Win32_DiskDrive reports that same\n"
            "        # drive as 'Fixed hard disk media', which is why the type is read\n"
            "        # from Get-PhysicalDisk and not from WMI.\n"
            "        $ggDisks = @(Get-PhysicalDisk -EA SilentlyContinue | Sort-Object DeviceId)\n"
            "        if ($ggDisks.Count -eq 0) {\n"
            "            $lines += \"  Storage:      Could not detect\"\n"
            "        } else {\n"
            "            $ggDN = 0\n"
            "            foreach ($ggD in $ggDisks) {\n"
            "                $ggDN++\n"
            "                $ggDGB  = [math]::Round($ggD.Size / 1GB, 0)\n"
            "                $ggDTyp = if ($ggD.MediaType) { [string]$ggD.MediaType } else { \"type unknown\" }\n"
            "                $ggDLbl = if ($ggDN -eq 1) { \"  Storage:      \" } else { \"                \" }\n"
            "                if ($ggDisks.Count -eq 1) {\n"
            "                    $lines += ($ggDLbl + $ggDGB + \" GB (\" + $ggDTyp + \")\")\n"
            "                } else {\n"
            "                    $lines += ($ggDLbl + \"Drive \" + $ggDN + \": \" + $ggDGB + \" GB (\" + $ggDTyp + \")\")\n"
            "                }\n"
            "            }\n"
            "        }\n"
            "    } catch { $lines += \"  Storage:      Could not detect\" }",
            count=1, why="FT-178: list every disk on the baseline screen")

        # ---------------------------------------------------------------
        # FT-178b -- the estimator picked the first ENUMERATED disk.
        # ---------------------------------------------------------------
        e.replace(
            A_EST,
            "        # FT-178b (ascii41): was Get-PhysicalDisk | Select-Object -First 1,\n"
            "        # i.e. the first ENUMERATED disk, which on a two-disk PC need not be\n"
            "        # the one being encrypted. The estimate is about C:, so find C:.\n"
            "        # VERIFIED 2026-08-17 measured on CGDELL: Get-Partition -DriveLetter C\n"
            "        # | Get-Disk returns disk number 0, and the physical disk with that\n"
            "        # DeviceId reports MediaType 'SSD'. Falls back to the old behaviour\n"
            "        # if the Storage module is unavailable, so nothing regresses.\n"
            "        $disk = $null\n"
            "        try {\n"
            "            $ggSysDisk = Get-Partition -DriveLetter C -EA Stop | Get-Disk -EA Stop\n"
            "            $disk = Get-PhysicalDisk -EA Stop | Where-Object { $_.DeviceId -eq [string]$ggSysDisk.Number }\n"
            "        } catch { $disk = $null }\n"
            "        if (-not $disk) { $disk = Get-PhysicalDisk -EA SilentlyContinue | Select-Object -First 1 }",
            count=1, why="FT-178b: BitLocker estimate reads the disk holding C:")

        # ---------------------------------------------------------------
        # FT-188 -- an absent policy key is not an error.
        # ---------------------------------------------------------------
        e.replace(
            A_PENDING,
            "                # FT-188 (ascii41): three of the four lines this produced on a\n"
            "                # clean SANDY run were absent policy keys -- HKLM\\...\\Edge and\n"
            "                # HKLM\\...\\Dsh -- which are SUPPOSED to be absent on a home PC\n"
            "                # and which the caller already handles by reporting Unknown.\n"
            "                # Nothing was wrong and the user saw nothing wrong, but the log\n"
            "                # said ERROR four times. That log is the file we tell the\n"
            "                # customer to email support, so a clean run must not read like\n"
            "                # a broken one. Expected-absent keys log INFO; all else ERROR.\n"
            "                $ggBenign = (($ggMsg -match 'because it does not exist') -or\n"
            "                             ($ggMsg -match 'Cannot find path'))\n"
            "                $ggStatus = if ($ggBenign) { \"INFO\" } else { \"ERROR\" }\n"
            "                $ggLabel  = if ($ggBenign) { \"NOT SET (expected)\" } else { \"SILENT ERROR\" }\n"
            "                Write-Log -Message ($ggLabel + \" at \" + $Where + \": \" + $ggMsg +"
            " $(if ($ggAt) { \" | \" + $ggAt } else { \"\" })) -Status $ggStatus",
            count=1, why="FT-188: absent policy keys log INFO, not ERROR")

        # ---------------------------------------------------------------
        # FT-186 -- one universal route to Settings.
        # ---------------------------------------------------------------
        w80 = len(A_SCR80) - len('            "') - len('",')
        e.replace(
            A_SCR80,
            '            "' + pad("  1. Press the Windows key, type  settings  and press", w80) + '",',
            count=1, why="FT-186: screen 80 -- type, do not hunt for a gear")

        w81 = len(A_SCR81.split("\n")[0]) - len('        "') - len('",')
        e.replace(
            A_SCR81,
            '        "' + pad("  1. Press the Windows key, type  settings  and", w81) + '",\n'
            '        "' + pad("     press Enter. This works on every PC.", w81) + '",\n'
            '        "' + pad("  2. In Settings, search for  device encryption", w81) + '",\n'
            '        "' + pad("     Look at the switch. It should say On.", w81) + '",\n'
            '        "' + pad("     If it does not, turn it on.", w81) + '",',
            count=1, why="FT-186: screen 81 -- Settings first, then search inside it")

        # ---------------------------------------------------------------
        # FT-175b -- extract the offer, then call it from BOTH branches.
        # ---------------------------------------------------------------
        e.replace(A_OFFLINE, "        Invoke-OfflineScanOffer",
                  count=1, why="FT-175b: first-run branch calls the extracted offer")

        e.replace(
            '        Write-Log -Message "Repeat run -- user confirmed to continue" -Status "CONFIRM"',
            '        Write-Log -Message "Repeat run -- user confirmed to continue" -Status "CONFIRM"\n'
            "        # FT-175b (ascii41): THE OFFER WAS NEVER HERE. This branch runs on\n"
            "        # every repeat run and every resume. It DESCRIBED the offline scan\n"
            "        # without ever offering to start one, so a returning user could not\n"
            "        # run it from Checkup at all. ascii39 finding 38 asked for exactly\n"
            "        # this and guessed the cause correctly -- \"check if running resume\n"
            "        # had anything to do with it not running\". It did.\n"
            "        # Proven again 2026-08-17: the SANDY log shows SCREEN-39, no\n"
            "        # SCREEN-38, and no [SKIP] User skipped Defender Offline Scan line,\n"
            "        # because the question was never asked.\n"
            "        Invoke-OfflineScanOffer",
            count=1, why="FT-175b: repeat-run branch now offers the scan")

        e.replace(
            "# ============================================================\n"
            "# POST-SCAN GUIDANCE (UX-07)",
            "# ============================================================\n"
            "# DEFENDER OFFLINE SCAN OFFER (FT-175b, ascii41)\n"
            "# Extracted verbatim from the first-run branch of Show-PreScanGate so\n"
            "# that BOTH branches can call it. Duplicating it was the alternative\n"
            "# and was rejected: the reason this defect survived an entire build is\n"
            "# that the offer lived in one branch and the other silently had none.\n"
            "# ============================================================\n"
            "function Invoke-OfflineScanOffer {\n"
            + dedent4(A_OFFLINE) + "\n"
            "}\n\n"
            "# ============================================================\n"
            "# POST-SCAN GUIDANCE (UX-07)",
            count=1, why="FT-175b: define Invoke-OfflineScanOffer")

        # ---------------------------------------------------------------
        # FT-189 + FT-173 -- I fetches the details from any prompt, and an
        # unrecognised key stops being swallowed in silence.
        # ---------------------------------------------------------------
        e.replace(
            "function Read-ValidKey {",
            "function Show-CheckupInfo {\n"
            "    # FT-189 (ascii41): reachable by pressing I at ANY prompt.\n"
            "    # Bill, 2026-08-17: \"no senior including me is going to remember that.\n"
            "    # Better you provide a button the user can select and read it right off\n"
            "    # the screen, or a file the user can open in Notepad.\" Both, because\n"
            "    # they serve different moments -- this screen is for the call in\n"
            "    # progress, the .bat is for the call three days later.\n"
            "    # Re-entrancy guard: this screen's own pause must not offer itself.\n"
            "    if ($script:GGInInfo) { return }\n"
            "    $script:GGInInfo = $true\n"
            "    try {\n"
            "        Clear-Host\n"
            "        Write-Host \"\"\n"
            "        Draw-Box -ScreenId \"84\" -Color White -Lines @(\n"
            "            \"  ABOUT THIS CHECKUP RUN                                     \",\n"
            "            \"---\",\n"
            "            \"  If you telephone for help, you will be asked for these:    \",\n"
            "            \"                                                             \",\n"
            "            (\"  Build:       \" + $BuildID),\n"
            "            (\"  Machine ID:  \" + $global:MachineID),\n"
            "            \"                                                             \",\n"
            "            \"  You do not have to write them down or remember them.       \",\n"
            "            \"  They are saved in your log file, and you can open it       \",\n"
            "            \"  any time -- during this run or weeks from now:             \",\n"
            "            \"                                                             \",\n"
            "            \"  Open the folder  C:\\GatewayGuard  and double-click         \",\n"
            "            \"  Open-My-Log.bat -- your log opens in Notepad. The build     \",\n"
            "            \"  and Machine ID are in the first few lines.                  \",\n"
            "            \"                                                             \",\n"
            "            \"  Nothing on your PC has been changed by this screen, and    \",\n"
            "            \"  nothing has been sent anywhere.                            \"\n"
            "        )\n"
            "        Write-Host \"\"\n"
            "        Pause-ForUser \"  Press Enter or Space to go back to where you were...\" -NoBack\n"
            "    } finally {\n"
            "        $script:GGInInfo = $false\n"
            "    }\n"
            "}\n"
            "\n"
            "function Read-ValidKey {",
            count=1, why="FT-189: the I screen")

        e.replace(
            A_CTRLC,
            A_CTRLC + "\n"
            "            # FT-189 (ascii41): I fetches the build and Machine ID from any\n"
            "            # prompt. Free everywhere -- measured 2026-08-17, the keys in use\n"
            "            # as valid keys anywhere in this file are B, E, N, Q, R, S and Y,\n"
            "            # plus the checklist's P and A and the digits 1-3.\n"
            "            # FT-173 (ascii41): an unrecognised key used to fall straight\n"
            "            # through to the `while` and be discarded with NO output at all.\n"
            "            # Nothing on screen distinguished \"that key does nothing here\"\n"
            "            # from \"the program has frozen\", which is the fear this tool's\n"
            "            # readers already have -- and it is why the missing Back option on\n"
            "            # SCREEN-53 went unreported through two builds. Say so instead.\n"
            "            # Deliberately NOT a blanket Back: some questions correctly have\n"
            "            # none. Telling the user which keys work is the fix; inventing a\n"
            "            # Back on \"are you sure you want to close Checkup\" is not.\n"
            "            if ($ch -notin $ValidKeys) {\n"
            "                if ($ch -eq \"I\") {\n"
            "                    Show-CheckupInfo\n"
            "                    if ($Prompt) { Write-Host \"  $Prompt\" -ForegroundColor White -NoNewline }\n"
            "                } elseif ($k.Character -match '\\S') {\n"
            "                    Write-Host \"\"\n"
            "                    Write-Host (\"  That key does nothing here. Please press \" + "
            "($ValidKeys -join \" or \") + \".\") -ForegroundColor Yellow\n"
            "                    Write-Host \"  Press I at any time to see your build and Machine ID.\" -ForegroundColor DarkGray\n"
            "                    if ($Prompt) { Write-Host \"  $Prompt\" -ForegroundColor White -NoNewline }\n"
            "                }\n"
            "            }",
            count=1, why="FT-173 + FT-189: I key, and no more silent discards")

        e.commit()

    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except EditError as exc:
        print(f"\nABORTED: {exc}", file=sys.stderr)
        sys.exit(1)
