"""build_ascii45_blockE_start -- Block E: the new start sequence.

Dated: 2026-09-27 08:27 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block E (E1-E7).

Bill's order (note 12, Decision 6, plus Cloud's PUA step):
  Tamper Protection -> Windows Update until finished -> unwanted-app blocking
  -> virus definitions -> offline-scan offer -> full scan started by Checkup.

Evidence, all on CGDELL 2026-09-27:
  Test_Results\BlockE-CGDELL-2026-09-27_08-24.txt        (reads, WU search)
  Test_Results\BlockE-Flips-CGDELL-2026-09-27_08-26.txt  (PUA on and restored,
      Update-MpSignature, full scan started detached and cancelled)
NOT YET MEASURED: Windows Update DOWNLOAD and INSTALL (they install real
updates), and Restart-Computer (it restarts the PC). Marked in the code;
Bill's approval is needed to measure the first on CGDELL. The restart is
sourced (Microsoft Learn, Restart-Computer).

New screens take IDs 90-95 with interim letter labels (14c-14g, 16a); the
renumber pass after Block E replaces them.

Run from Tool2/:  python build_ascii45_blockE_start.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

NEW_FUNCS = r'''function Add-GGReady {
    # E (ascii45): one line per start-sequence check, shown together on the
    # ready-check screen before the scans.
    param([string]$Key, [string]$Line)
    if ($null -eq $script:GGReady) { $script:GGReady = [ordered]@{} }
    $script:GGReady[$Key] = $Line
}

function Show-TamperCheck {
    # E1 / FT-250 (ascii45): Tamper Protection is read FIRST, so every Defender
    # setting read after it comes from a settled machine.
    # Read: Get-TamperProtectionState -- Get-MpComputerStatus IsTamperProtected,
    # VERIFIED 2026-09-27 measured on CGDELL: True (BlockE-CGDELL-..._08-24.txt).
    while ($true) {
        $ggTP = Get-TamperProtectionState
        Write-Log -Message "Tamper Protection read first (E1): $ggTP" -Status "INFO"
        if ($ggTP -eq "On") { Add-GGReady "Tamper" "  OK    Tamper Protection is on."; return }
        $ggOther = @(Get-GGOtherAV)
        if ($ggOther.Count -gt 0) {
            Add-GGReady "Tamper" ("  NOTE  Tamper Protection is off while " + $ggOther[0] + " is your antivirus. That is expected.")
            return
        }
        if ($ggTP -ne "Off") {
            Add-GGReady "Tamper" "  NOTE  Checkup could not read Tamper Protection. Check it in Windows Security."
            return
        }
        Clear-Host
        Write-Host ""
        Draw-Box -ScreenId "90" -Color Yellow -Lines @(
            "  TAMPER PROTECTION IS OFF                                   ",
            "---",
            "  Tamper Protection stops harmful programs from turning off  ",
            "  Microsoft Defender. It should be On.                       ",
            "                                                             ",
            "  Windows does not allow any program to turn this on, so     ",
            "  here are the steps to do it yourself:                      ",
            "  1. Press the Windows key, type  Windows Security , Enter.  ",
            "  2. Click Virus & threat protection.                        ",
            "  3. Under Virus & threat protection settings, click         ",
            "     Manage settings.                                        ",
            "  4. Find Tamper Protection and turn it On.                  ",
            "                                                             ",
            "  Checkup checks this first because the checks after it read ",
            "  Defender's settings, and those can only be trusted while   ",
            "  Tamper Protection is on.                                   "
        )
        Write-Host ""
        $ggAns = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Did you turn it on? (Y = yes, check again / N = no, continue without it): "
        if ($ggAns -eq "N") {
            Add-GGReady "Tamper" "  NOTE  Tamper Protection is off. Turn it on in Windows Security."
            Write-Log -Message "Tamper Protection left off by the user (E1)" -Status "SKIP"
            return
        }
    }
}

function Show-GGUpdateRestart {
    # E2 (ascii45): the updates need a restart. Y restarts; after it, Checkup
    # resumes at "WinUpdatePending" and checks again, until none are left.
    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "92" -Color Yellow -Lines @(
        "  RESTART NEEDED TO FINISH THE UPDATES                       ",
        "---",
        "  Windows needs to restart to finish installing updates.     ",
        "                                                             ",
        "  SAVE AND CLOSE YOUR WORK FIRST.                            ",
        "                                                             ",
        "  After the restart, run Checkup again. It continues from    ",
        "  here and checks for more updates, until none are left.     "
    )
    Write-Host ""
    $ggR = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Restart now? (Y = restart now / N = later, continue with Checkup): "
    if ($ggR -eq "Y") {
        Save-Checkpoint -Checkpoint "WinUpdatePending"
        Write-Log -Message "Windows Update: restart chosen by the user (E2)" -Status "INFO"
        Write-Host ""
        Write-Host "  Restarting. Run Checkup again when you are back at the desktop." -ForegroundColor Green
        Disable-SleepPrevention
        Save-Log
        try {
            # VERIFIED 2026-09-27 sourced: Microsoft Learn, Restart-Computer
            # (learn.microsoft.com/powershell/module/microsoft.powershell.management/restart-computer).
            # Without -Force it does not close programs that are still open.
            Restart-Computer -EA Stop
            exit
        } catch {
            Write-Log -Message "Restart-Computer failed: $_" -Status "WARN"
            Write-Host "  Windows would not restart just now. Restart it yourself" -ForegroundColor Yellow
            Write-Host "  (Start -> Power -> Restart), then run Checkup again." -ForegroundColor Yellow
            Pause-ForUser "  Press Enter or Space to close Checkup..."
            exit
        }
    }
    Add-GGReady "Update" "  NOTE  Restart your PC soon -- some updates finish only after a restart."
    Write-Log -Message "Windows Update: restart postponed by the user (E2)" -Status "SKIP"
}

function Invoke-WindowsUpdateLoop {
    # E2 / FT-252, upgraded by Bill 2026-09-25 to APPLY AND LOOP: check,
    # install with the user's permission, restart when needed, check again,
    # until nothing is left. Survives the restarts through the checkpoint
    # "WinUpdatePending" (Block D).
    #
    # VERIFY STATUS (2026-09-27):
    #   Search -- VERIFIED measured on CGDELL (below).
    #   Download and install -- NOT YET MEASURED. They install real updates, so
    #   they need Bill's approval to run on CGDELL. Do not ship until they are.
    $ggRound = 0
    while ($true) {
        $ggRound++
        Clear-Host
        Write-Host ""
        Write-Host "  Checking Windows Update -- this can take a minute or two..." -ForegroundColor Yellow
        $ggSess = $null
        $ggRes  = $null
        try {
            # VERIFIED 2026-09-27 measured on CGDELL, elevated: Microsoft.Update.Session
            # CreateUpdateSearcher().Search("IsInstalled=0 and IsHidden=0 and Type='Software'")
            # -> ResultCode 2 (succeeded), 2 updates, 21.7 s.
            # Test_Results\BlockE-CGDELL-2026-09-27_08-24.txt, section 7.
            $ggSess = New-Object -ComObject Microsoft.Update.Session
            $ggRes  = $ggSess.CreateUpdateSearcher().Search("IsInstalled=0 and IsHidden=0 and Type='Software'")
        } catch {
            Write-Log -Message "Windows Update search failed: $_" -Status "WARN"
            Add-GGReady "Update" "  NOTE  Checkup could not check Windows Update. Check it: Settings -> Windows Update."
            Save-Checkpoint -Checkpoint "WinUpdate"
            return
        }
        $ggAll = @()
        for ($ggI = 0; $ggI -lt $ggRes.Updates.Count; $ggI++) { $ggAll += $ggRes.Updates.Item($ggI) }
        $ggOK   = @($ggAll | Where-Object { $_.EulaAccepted })
        $ggEula = $ggAll.Count - $ggOK.Count
        Write-Log -Message ("Windows Update round " + $ggRound + ": " + $ggAll.Count + " waiting, " + $ggEula + " need licence terms accepted") -Status "INFO"

        if ($ggOK.Count -eq 0) {
            $ggReboot = $false
            # VERIFIED 2026-09-27 measured on CGDELL: Microsoft.Update.SystemInfo
            # RebootRequired = False (same file, section 7).
            try { $ggReboot = [bool](New-Object -ComObject Microsoft.Update.SystemInfo).RebootRequired } catch {}
            if ($ggReboot) {
                Show-GGUpdateRestart
            } elseif ($ggEula -gt 0) {
                Add-GGReady "Update" ("  NOTE  " + $ggEula + " update(s) need you to accept terms: Settings -> Windows Update.")
            } else {
                Add-GGReady "Update" "  OK    Windows is up to date."
            }
            Save-Checkpoint -Checkpoint "WinUpdate"
            return
        }
        if ($ggRound -gt 4) {
            Add-GGReady "Update" "  NOTE  Some updates would not install. Check: Settings -> Windows Update."
            Write-Log -Message "Windows Update: still updates after 4 rounds -- stopping the loop" -Status "WARN"
            Save-Checkpoint -Checkpoint "WinUpdate"
            return
        }

        Clear-Host
        Write-Host ""
        $ggLines = @(("  WINDOWS UPDATE -- " + $ggOK.Count + " UPDATE(S) WAITING"), "---")
        foreach ($ggU in ($ggOK | Select-Object -First 8)) {
            $ggT = [string]$ggU.Title
            if ($ggT.Length -gt 56) { $ggT = $ggT.Substring(0, 53) + "..." }
            $ggLines += ("  * " + $ggT)
        }
        if ($ggOK.Count -gt 8) { $ggLines += ("  ...and " + ($ggOK.Count - 8) + " more") }
        $ggLines += @(
            "                                                             ",
            "  Checkup can download and install them now, with your      ",
            "  permission. It can take several minutes, and this window   ",
            "  may look still while it works -- it is not stuck.          ",
            "  Keep the PC plugged in.                                    "
        )
        Draw-Box -ScreenId "91" -Color White -Lines $ggLines
        Write-Host ""
        $ggYes = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Install them now? (Y = yes / N = not now, continue): "
        if ($ggYes -eq "N") {
            Add-GGReady "Update" ("  NOTE  " + $ggOK.Count + " update(s) not installed. Windows installs them on its own schedule.")
            Write-Log -Message "Windows Update: install declined by the user" -Status "SKIP"
            Save-Checkpoint -Checkpoint "WinUpdate"
            return
        }

        Write-Host ""
        Write-Host "  Downloading and installing -- please wait. The window may look still." -ForegroundColor Yellow
        $ggIr = $null
        try {
            # NOT YET MEASURED (see VERIFY STATUS above): UpdateColl, Download, Install.
            # Result codes, sourced (Microsoft Learn, OperationResultCode):
            # 2 = succeeded, 3 = succeeded with errors, 4 = failed, 5 = aborted.
            $ggColl = New-Object -ComObject Microsoft.Update.UpdateColl
            foreach ($ggU in $ggOK) { [void]$ggColl.Add($ggU) }
            $ggDl = $ggSess.CreateUpdateDownloader()
            $ggDl.Updates = $ggColl
            $ggDr = $ggDl.Download()
            $ggIn = $ggSess.CreateUpdateInstaller()
            $ggIn.Updates = $ggColl
            $ggIr = $ggIn.Install()
            Write-Log -Message ("Windows Update: download result " + $ggDr.ResultCode + ", install result " + $ggIr.ResultCode + ", restart needed " + $ggIr.RebootRequired) -Status "INFO"
            for ($ggI = 0; $ggI -lt $ggColl.Count; $ggI++) {
                Write-Log -Message ("  " + $ggColl.Item($ggI).Title + " -- result " + $ggIr.GetUpdateResult($ggI).ResultCode) -Status "INFO"
            }
        } catch {
            Write-Log -Message "Windows Update install failed: $_" -Status "ERROR"
            Write-Host "  The updates could not be installed. You can try from" -ForegroundColor Yellow
            Write-Host "  Settings -> Windows Update. Checkup carries on." -ForegroundColor Yellow
            Add-GGReady "Update" "  NOTE  The updates could not be installed. Try: Settings -> Windows Update."
            Save-Checkpoint -Checkpoint "WinUpdate"
            Pause-ForUser "  Press Enter or Space to continue..."
            return
        }
        if ($ggIr -and $ggIr.ResultCode -eq 2) {
            Write-Host "  OK  Updates installed." -ForegroundColor Green
        } else {
            Write-Host "  Some updates did not install. Checkup checks again." -ForegroundColor Yellow
        }
        if ($ggIr -and $ggIr.RebootRequired) {
            Show-GGUpdateRestart
            Save-Checkpoint -Checkpoint "WinUpdate"
            return
        }
        # No restart needed: go round and check again -- some updates only
        # appear once earlier ones are installed.
    }
}

function Invoke-PUACheck {
    # E3 / FT-248 (ascii45, Cloud A-6): turn on blocking of potentially
    # unwanted apps, with permission, before any scan.
    # VERIFIED 2026-09-27 measured on CGDELL, elevated: Get-MpPreference
    # PUAProtection read 2 (AuditMode); Set-MpPreference -PUAProtection Enabled
    # -> read 1; restored with -PUAProtection AuditMode -> read 2. Values
    # Disabled/Enabled/AuditMode from the cmdlet's own ValidateSet.
    # Test_Results\BlockE-Flips-CGDELL-2026-09-27_08-26.txt
    $ggOther = @(Get-GGOtherAV)
    if ($ggOther.Count -gt 0) {
        Add-GGReady "PUA" ("  NOTE  " + $ggOther[0] + " is your antivirus, so its own settings apply.")
        return
    }
    $ggP = $null
    try { $ggP = [int](Get-MpPreference -EA Stop).PUAProtection } catch {}
    Write-Log -Message "Unwanted app blocking (PUAProtection) read: $ggP" -Status "INFO"
    if ($ggP -eq 1) { Add-GGReady "PUA" "  OK    Unwanted app blocking is on."; return }
    if ($null -eq $ggP) { Add-GGReady "PUA" "  NOTE  Checkup could not read unwanted app blocking."; return }
    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "93" -Color White -Lines @(
        "  UNWANTED APP BLOCKING IS NOT ON                            ",
        "---",
        "  Some programs are not viruses but still do things you did  ",
        "  not ask for -- adding toolbars, showing ads, or changing   ",
        "  your browser. Microsoft Defender can block them.           ",
        "                                                             ",
        "  Checkup can turn this on for you, with your permission.    "
    )
    Write-Host ""
    $ggA = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Turn on unwanted app blocking? (Y = yes / N = no): "
    if ($ggA -eq "N") {
        Add-GGReady "PUA" "  NOTE  Unwanted app blocking left off, by your choice."
        Write-Log -Message "Unwanted app blocking: declined by the user" -Status "SKIP"
        return
    }
    try { Set-MpPreference -PUAProtection Enabled -EA Stop } catch { Write-Log -Message "Set-MpPreference -PUAProtection failed: $_" -Status "WARN" }
    Start-Sleep -Seconds 2   # measured: the read-back settles within 2 s
    $ggP2 = $null
    try { $ggP2 = [int](Get-MpPreference -EA Stop).PUAProtection } catch {}
    if ($ggP2 -eq 1) {
        Add-GGReady "PUA" "  OK    Unwanted app blocking turned on, with your permission -- confirmed."
        Write-Log -Message "Unwanted app blocking: turned on and confirmed (read 1)" -Status "OK"
    } else {
        Add-GGReady "PUA" "  NOTE  Windows did not accept the change. See below."
        Write-Log -Message "Unwanted app blocking: set did not take (read $ggP2)" -Status "WARN"
        Write-Host ""
        Write-Host "  Windows did not accept the change. Turn it on yourself:" -ForegroundColor Yellow
        Write-Host "  Windows Security -> App & browser control -> Reputation-based" -ForegroundColor Yellow
        Write-Host "  protection settings -> Potentially unwanted app blocking." -ForegroundColor Yellow
        Pause-ForUser "  Press Enter or Space to continue..."
    }
}

function Update-GGSignaturesIfStale {
    # E4 / FT-249 (ascii45): a scan on old virus definitions must not look like
    # a clean bill of health. Definitions older than a day are updated first.
    # VERIFIED 2026-09-27 measured on CGDELL, elevated: Update-MpSignature ran
    # with no error in 17 s, version 1.459.420.0 -> 1.459.428.0.
    # Test_Results\BlockE-Flips-CGDELL-2026-09-27_08-26.txt
    # Note: AntivirusSignatureAge read 0 at 17 hours old -- it counts whole days,
    # so the last-updated time is used instead.
    $ggOther = @(Get-GGOtherAV)
    if ($ggOther.Count -gt 0) { return }
    $ggS = $null
    try { $ggS = Get-MpComputerStatus -EA Stop } catch {}
    if ($null -eq $ggS) { Add-GGReady "Defs" "  NOTE  Checkup could not read Defender's virus definitions."; return }
    $ggHours = ((Get-Date) - [datetime]$ggS.AntivirusSignatureLastUpdated).TotalHours
    Write-Log -Message ("Virus definitions: version " + $ggS.AntivirusSignatureVersion + ", " + [int]$ggHours + " hour(s) old") -Status "INFO"
    if ($ggHours -lt 24) { Add-GGReady "Defs" "  OK    Virus definitions are up to date."; return }
    Write-Host ""
    Write-Host "  Updating Microsoft Defender's virus definitions -- under a minute..." -ForegroundColor Yellow
    try { Update-MpSignature -EA Stop } catch { Write-Log -Message "Update-MpSignature failed: $_" -Status "WARN" }
    $ggS2 = $null
    try { $ggS2 = Get-MpComputerStatus -EA Stop } catch {}
    if ($ggS2 -and ((Get-Date) - [datetime]$ggS2.AntivirusSignatureLastUpdated).TotalHours -lt 24) {
        Add-GGReady "Defs" "  OK    Virus definitions updated -- confirmed."
        Write-Log -Message ("Virus definitions updated to " + $ggS2.AntivirusSignatureVersion) -Status "OK"
    } else {
        Add-GGReady "Defs" "  NOTE  Virus definitions could not be updated. A scan may miss the newest threats."
        Write-Log -Message "Virus definitions still more than a day old after Update-MpSignature" -Status "WARN"
    }
}

function Show-GGReadySummary {
    # E (ascii45): one screen with what the start checks found, before the scans.
    if ($null -eq $script:GGReady -or $script:GGReady.Count -eq 0) { return }
    Clear-Host
    Write-Host ""
    $ggL = @("  BEFORE THE SCAN -- WHAT CHECKUP CHECKED                    ", "---")
    foreach ($ggK in $script:GGReady.Keys) { $ggL += [string]$script:GGReady[$ggK] }
    $ggL += @("                                                             ",
              "  OK means it is set the safe way. NOTE means it needs you,  ",
              "  and says where. Everything here is also in your log file.  ")
    Draw-Box -ScreenId "94" -Color White -Lines $ggL
    Write-Host ""
    Pause-ForUser "  Press Enter or Space to continue to the scan..."
}

function Invoke-FullScanOffer {
    # E6 (ascii45, Bill 2026-09-25): a full scan of every drive, started by
    # Checkup in the background -- this is how a second drive gets scanned.
    # VERIFIED 2026-09-27 measured on CGDELL, elevated: MpCmdRun.exe -? lists
    # "-Scan [-ScanType value] ... 2  Full system scan". Started DETACHED with
    # Start-Process -WindowStyle Hidden it was still running 15 s later, and
    # MpCmdRun -Scan -Cancel stopped it ("Scan cancelled successfully").
    # FullScanStartTime stayed blank while it ran -- do not use it as proof.
    # Test_Results\BlockE-Flips-CGDELL-2026-09-27_08-26.txt
    $ggOther = @(Get-GGOtherAV)
    if ($ggOther.Count -gt 0) {
        Write-Log -Message ("Full scan offer skipped -- " + $ggOther[0] + " is the antivirus") -Status "INFO"
        return
    }
    $ggMp = Join-Path $env:ProgramFiles "Windows Defender\MpCmdRun.exe"
    if (-not (Test-Path $ggMp)) { Write-Log -Message "Full scan offer skipped -- MpCmdRun.exe not found" -Status "WARN"; return }
    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "95" -Color White -Lines @(
        "  FULL SCAN OF EVERY DRIVE                                   ",
        "---",
        "  Checkup can start a full Microsoft Defender scan now, with ",
        "  your permission. It checks every file on every drive,      ",
        "  including a second drive, and runs in the background.      ",
        "                                                             ",
        "  * It can take an hour -- or several hours on a large or    ",
        "    older hard drive.                                        ",
        "  * You can keep using Checkup and your PC while it runs.    ",
        "  * It keeps going if you close Checkup.                     ",
        "  * Results: Windows Security -> Virus & threat protection   ",
        "    -> Protection history.                                   "
    )
    Write-Host ""
    $ggA = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Start the full scan now? (Y = yes / N = no): "
    if ($ggA -eq "N") { Write-Log -Message "Full scan: declined by the user" -Status "SKIP"; return }
    $ggP = $null
    try {
        # VERIFIED 2026-09-27 measured on CGDELL -- see the note at the top.
        $ggP = Start-Process -FilePath $ggMp -ArgumentList "-Scan -ScanType 2" -WindowStyle Hidden -PassThru -EA Stop
    } catch { Write-Log -Message "Full scan could not start: $_" -Status "WARN" }
    Start-Sleep -Seconds 3   # measured: a started scan is still running after 15 s; one that fails exits at once
    if ($ggP -and -not $ggP.HasExited) {
        Write-Host ""
        Write-Host "  OK  Full scan started, with your permission. It runs in the background." -ForegroundColor Green
        Write-Log -Message ("Full scan started (MpCmdRun PID " + $ggP.Id + ")") -Status "OK"
    } else {
        Write-Host ""
        Write-Host "  The full scan did not start. You can start it yourself:" -ForegroundColor Yellow
        Write-Host "  Windows Security -> Virus & threat protection -> Scan options" -ForegroundColor Yellow
        Write-Host "  -> Full scan -> Scan now." -ForegroundColor Yellow
        Write-Log -Message "Full scan: process exited at once or did not start" -Status "WARN"
    }
    Pause-ForUser "  Press Enter or Space to continue..."
}

function Show-PreScanGate {'''

with PS1Edit(TARGET) as e:
    e.replace(
        "#           selections saved; 1b says where Checkup will continue.\n",
        "#           selections saved; 1b says where Checkup will continue.\n"
        "#   BLOCK E: THE NEW START SEQUENCE (Bill's order): E1 Tamper Protection\n"
        "#           first (FT-250); E2 Windows Update, install with permission and\n"
        "#           loop across restarts (FT-252 -- DOWNLOAD/INSTALL NOT YET\n"
        "#           MEASURED); E3 unwanted-app blocking (FT-248); E4 virus\n"
        "#           definitions (FT-249); one ready-check screen; E5 save-your-work\n"
        "#           warning on the offline scan (FT-276); E6 full scan of every\n"
        "#           drive in the background; E7 14b no longer claims the scan\n"
        "#           finished (FT-277). New screens 90-95, interim labels.\n",
        count=1, why="change log: Block E")

    e.replace("function Show-PreScanGate {", NEW_FUNCS, count=1, why="Block E functions")

    # screen table: interim labels in viewing order
    e.replace(
        "    \"27\" = \"14\"           # The scans we recommend\n",
        "    \"27\" = \"14\"           # The scans we recommend\n"
        "    \"90\" = \"14c\"          # Tamper Protection is off (E1) -- interim label\n"
        "    \"91\" = \"14d\"          # Windows Update -- updates waiting (E2) -- interim\n"
        "    \"92\" = \"14e\"          # Restart needed to finish updates (E2) -- interim\n"
        "    \"93\" = \"14f\"          # Unwanted app blocking (E3) -- interim\n"
        "    \"94\" = \"14g\"          # Before the scan -- what Checkup checked -- interim\n",
        count=1, why="table: 90-94")
    e.replace(
        "    \"38\" = \"16\"           # Defender offline scan\n",
        "    \"38\" = \"16\"           # Defender offline scan\n"
        "    \"95\" = \"16a\"          # Full scan of every drive (E6) -- interim label\n",
        count=1, why="table: 95")

    # checkpoints
    e.replace(
        "    \"Briefing\",\n    \"PreScanPrep\",\n",
        "    \"Briefing\",\n"
        "    # Block E (ascii45): the start sequence.\n"
        "    \"Tamper\",\n"
        "    \"WinUpdatePending\",\n"
        "    \"WinUpdate\",\n"
        "    \"Defs\",\n"
        "    \"PreScanPrep\",\n",
        count=1, why="checkpoints: Block E")
    e.replace(
        "        \"PreScanPrep\"        = @(\"getting ready for the scan\", \"\")\n",
        "        \"PreScanPrep\"        = @(\"getting ready for the scan\", \"\")\n"
        "        \"Tamper\"             = @(\"the Windows Update check\", \"\")\n"
        "        \"WinUpdatePending\"   = @(\"the Windows Update check, after the restart\", \"\")\n"
        "        \"WinUpdate\"          = @(\"unwanted app blocking\", \"\")\n"
        "        \"Defs\"               = @(\"getting ready for the scan\", \"\")\n",
        count=1, why="resume target: Block E")

    # main flow
    e.replace(
        "# 11. Pre-scan gate -- now a real automated flow (UX-04,05,06,07,09,11),\n",
        "# Block E (ascii45): Bill's order -- Tamper Protection, Windows Update until\n"
        "# finished, unwanted-app blocking, virus definitions, then the scans.\n"
        "$script:GGReady = [ordered]@{}\n"
        "if (-not (Test-CheckpointReached -Checkpoint \"Tamper\")) {\n"
        "    Show-TamperCheck\n"
        "    Save-Checkpoint -Checkpoint \"Tamper\"\n"
        "}\n"
        "if (-not (Test-CheckpointReached -Checkpoint \"WinUpdate\")) {\n"
        "    Invoke-WindowsUpdateLoop   # saves WinUpdate / WinUpdatePending itself\n"
        "}\n"
        "if (-not (Test-CheckpointReached -Checkpoint \"Defs\")) {\n"
        "    Invoke-PUACheck\n"
        "    Update-GGSignaturesIfStale\n"
        "    Save-Checkpoint -Checkpoint \"Defs\"\n"
        "}\n"
        "Show-GGReadySummary\n"
        "\n"
        "# 11. Pre-scan gate -- now a real automated flow (UX-04,05,06,07,09,11),\n",
        count=1, why="main flow: Block E steps")
    e.replace(
        "    Show-PreScanGate\n"
        "    Save-Checkpoint -Checkpoint \"OfflineScanDone\"   # D2 / FT-266: was never saved\n",
        "    Show-PreScanGate\n"
        "    if (-not $script:GGScanSkipped) { Invoke-FullScanOffer }   # E6 (ascii45)\n"
        "    Save-Checkpoint -Checkpoint \"OfflineScanDone\"   # D2 / FT-266: was never saved\n",
        count=1, why="main flow: full scan offer")
    e.replace(
        "                Write-Log -Message \"Scan gate SKIPPED by user (S key)\" -Status \"WARN\"\n",
        "                Write-Log -Message \"Scan gate SKIPPED by user (S key)\" -Status \"WARN\"\n"
        "                $script:GGScanSkipped = $true   # E6: no full-scan offer either\n",
        count=1, why="S skips the full scan too")

    # E5: save your work, every run
    e.replace(
        "        \"  for you now. This scan runs BEFORE Windows loads, so it    \",\n"
        "        \"  catches rootkits and malware that hide during normal use.  \",\n"
        "        \"                                                             \",\n"
        "        \"  IMPORTANT -- WHAT WILL HAPPEN:                            \",\n",
        "        \"  for you now. This scan runs BEFORE Windows loads, so it    \",\n"
        "        \"  catches rootkits and malware that hide during normal use.  \",\n"
        "        \"                                                             \",\n"
        "        \"  SAVE AND CLOSE YOUR WORK FIRST. The restart comes about    \",\n"
        "        \"  five seconds after you press Y.                            \",\n"
        "        \"                                                             \",\n"
        "        \"  IMPORTANT -- WHAT WILL HAPPEN:                            \",\n",
        count=1, why="E5: save your work")

    # E7: 14b no longer claims the scan finished
    e.replace(
        "        \"  WELCOME BACK -- OFFLINE SCAN COMPLETE                     \",\n",
        "        \"  WELCOME BACK -- AFTER THE OFFLINE SCAN                    \",\n",
        count=1, why="E7: 14b title")
    e.replace(
        "        \"  Your Defender Offline Scan has finished. Here's how to     \",\n"
        "        \"  see the results:                                          \",\n",
        "        \"  Welcome back. If the offline scan ran, its results are in  \",\n"
        "        \"  Protection History. Here's how to see them:               \",\n",
        count=1, why="E7: 14b no claim")
