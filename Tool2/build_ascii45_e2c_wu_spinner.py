"""build_ascii45_e2c_wu_spinner -- a spinner and a timer while Windows Update
searches, downloads and installs.

Dated: 2026-09-27 10:36 ET
Editor: Claude Code (CGDELL)

Bill, 2026-09-27: "can you add a spinning something while updates are
running/installing". MEASURED 10:22-10:31: the install call blocks for 454 s
with nothing on screen -- one COM call, so Checkup cannot draw while it runs.

So the work moves to a background PowerShell runspace (STA, like
powershell.exe itself) and the foreground draws  | / - \  plus the elapsed
time four times a second until it finishes. Only plain values cross between
the two (titles, update IDs, result codes) -- never the COM objects.
The install runspace searches again and installs only the update IDs the user
saw and approved.

Run from Tool2/:  python build_ascii45_e2c_wu_spinner.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

NEW_FN = r'''function Invoke-GGWithSpinner {
    # E2 (ascii45). Bill 2026-09-27: "can you add a spinning something while
    # updates are running". Runs $Script in a background runspace and draws a
    # spinner and the elapsed time until it finishes. Returns the script's
    # output; rethrows its first error. STA, the same as powershell.exe, where
    # the Windows Update calls were measured.
    param([scriptblock]$Script, [object]$Argument = $null, [string]$Message = "Working")
    $ggRs = [runspacefactory]::CreateRunspace()
    $ggRs.ApartmentState = "STA"
    $ggRs.ThreadOptions  = "ReuseThread"
    $ggRs.Open()
    $ggPs = [powershell]::Create()
    $ggPs.Runspace = $ggRs
    [void]$ggPs.AddScript($Script)
    if ($null -ne $Argument) { [void]$ggPs.AddArgument($Argument) }
    $ggH = $ggPs.BeginInvoke()
    $ggChars = @("|", "/", "-", "\")
    $ggI  = 0
    $ggT0 = Get-Date
    while (-not $ggH.IsCompleted) {
        $ggEl = (Get-Date) - $ggT0
        $ggLine = "  " + $ggChars[$ggI % 4] + "  " + $Message + ("   {0:00}:{1:00} elapsed   " -f [int][math]::Floor($ggEl.TotalMinutes), $ggEl.Seconds)
        try { Write-Host ("`r" + $ggLine) -NoNewline -ForegroundColor Yellow } catch {}
        $ggI++
        Start-Sleep -Milliseconds 250
    }
    try { Write-Host ("`r" + (" " * ($Message.Length + 30)) + "`r") -NoNewline } catch {}
    $ggOut = $null
    $ggErr = $null
    try { $ggOut = $ggPs.EndInvoke($ggH) } catch { $ggErr = $_ }
    if (-not $ggErr -and $ggPs.Streams.Error.Count -gt 0) { $ggErr = $ggPs.Streams.Error[0] }
    $ggPs.Dispose()
    $ggRs.Close()
    try { Clear-PendingKeys } catch {}   # keys pressed while it spun are not answers
    if ($ggErr) { throw $ggErr }
    return @($ggOut)
}

$script:GGWUSearchScript = {
    # Runs in the spinner's runspace. Returns plain values only.
    # VERIFIED 2026-09-27 measured on CGDELL, elevated: this search -> ResultCode 2
    # (Test_Results\BlockE-CGDELL-2026-09-27_08-24.txt, WUInstall-CGDELL-..._10-22.txt).
    $s = New-Object -ComObject Microsoft.Update.Session
    $r = $s.CreateUpdateSearcher().Search("IsInstalled=0 and IsHidden=0 and Type='Software'")
    for ($i = 0; $i -lt $r.Updates.Count; $i++) {
        $u = $r.Updates.Item($i)
        [pscustomobject]@{ Title = [string]$u.Title; Id = [string]$u.Identity.UpdateID; Eula = [bool]$u.EulaAccepted }
    }
}

$script:GGWUInstallScript = {
    # Runs in the spinner's runspace. Installs ONLY the update IDs the user saw.
    # VERIFIED 2026-09-27 measured on CGDELL, elevated: UpdateColl, Download()
    # -> 2, Install() -> 2, RebootRequired False, 454 s
    # (Test_Results\WUInstall-CGDELL-2026-09-27_10-22.txt).
    param($ids)
    $s = New-Object -ComObject Microsoft.Update.Session
    $r = $s.CreateUpdateSearcher().Search("IsInstalled=0 and IsHidden=0 and Type='Software'")
    $c = New-Object -ComObject Microsoft.Update.UpdateColl
    for ($i = 0; $i -lt $r.Updates.Count; $i++) {
        $u = $r.Updates.Item($i)
        if (@($ids) -contains [string]$u.Identity.UpdateID) { [void]$c.Add($u) }
    }
    if ($c.Count -eq 0) { return [pscustomobject]@{ Count = 0; Download = 0; Install = 0; Reboot = $false; Per = @() } }
    $d = $s.CreateUpdateDownloader(); $d.Updates = $c; $dr = $d.Download()
    $n = $s.CreateUpdateInstaller();  $n.Updates = $c; $ir = $n.Install()
    $per = @()
    for ($i = 0; $i -lt $c.Count; $i++) { $per += [pscustomobject]@{ Title = [string]$c.Item($i).Title; Result = [int]$ir.GetUpdateResult($i).ResultCode } }
    [pscustomobject]@{ Count = $c.Count; Download = [int]$dr.ResultCode; Install = [int]$ir.ResultCode; Reboot = [bool]$ir.RebootRequired; Per = $per }
}

function Invoke-WindowsUpdateLoop {
    # E2 / FT-252, upgraded by Bill 2026-09-25 to APPLY AND LOOP: check,
    # install with the user's permission, restart when needed, check again,
    # until nothing is left. Survives the restarts through the checkpoint
    # "WinUpdatePending" (Block D).
    # Search, download and install run in the background with a spinner
    # (Invoke-GGWithSpinner) -- measured: the install alone took 454 s.
    # Restart -- sourced only (no restart was needed in the measurement).
    $ggRound = 0
    while ($true) {
        $ggRound++
        Clear-Host
        Write-Host ""
        $ggAll = @()
        try {
            $ggAll = @(Invoke-GGWithSpinner -Script $script:GGWUSearchScript -Message "Checking Windows Update -- this can take a minute or two")
        } catch {
            Write-Log -Message "Windows Update search failed: $_" -Status "WARN"
            Add-GGReady "Update" "  NOTE  Checkup could not check Windows Update. Check it: Settings -> Windows Update."
            Save-Checkpoint -Checkpoint "WinUpdate"
            return
        }
        $ggOK   = @($ggAll | Where-Object { $_.Eula })
        $ggEula = $ggAll.Count - $ggOK.Count
        Write-Log -Message ("Windows Update round " + $ggRound + ": " + $ggAll.Count + " waiting, " + $ggEula + " need licence terms accepted") -Status "INFO"

        if ($ggOK.Count -eq 0) {
            $ggReboot = $false
            # VERIFIED 2026-09-27 measured on CGDELL: Microsoft.Update.SystemInfo
            # RebootRequired = False (BlockE-CGDELL-..._08-24.txt, section 7).
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
            "  permission. It can take several minutes. A spinner and a   ",
            "  timer show it is still working.                            ",
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
        $ggIr = $null
        try {
            # Result codes, sourced (Microsoft Learn, OperationResultCode):
            # 2 = succeeded, 3 = succeeded with errors, 4 = failed, 5 = aborted.
            $ggIds = @($ggOK | ForEach-Object { $_.Id })
            $ggIr = @(Invoke-GGWithSpinner -Script $script:GGWUInstallScript -Argument $ggIds -Message "Downloading and installing updates -- please wait") | Select-Object -Last 1
            Write-Host ""
            Write-Log -Message ("Windows Update: " + $ggIr.Count + " update(s), download result " + $ggIr.Download + ", install result " + $ggIr.Install + ", restart needed " + $ggIr.Reboot) -Status "INFO"
            foreach ($ggP in @($ggIr.Per)) { Write-Log -Message ("  " + $ggP.Title + " -- result " + $ggP.Result) -Status "INFO" }
        } catch {
            Write-Log -Message "Windows Update install failed: $_" -Status "ERROR"
            Write-Host ""
            Write-Host "  The updates could not be installed. You can try from" -ForegroundColor Yellow
            Write-Host "  Settings -> Windows Update. Checkup carries on." -ForegroundColor Yellow
            Add-GGReady "Update" "  NOTE  The updates could not be installed. Try: Settings -> Windows Update."
            Save-Checkpoint -Checkpoint "WinUpdate"
            Pause-ForUser "  Press Enter or Space to continue..."
            return
        }
        if ($ggIr -and $ggIr.Install -eq 2) {
            Write-Host "  OK  Updates installed." -ForegroundColor Green
        } else {
            Write-Host "  Some updates did not install. Checkup checks again." -ForegroundColor Yellow
        }
        if ($ggIr -and $ggIr.Reboot) {
            Show-GGUpdateRestart
            Save-Checkpoint -Checkpoint "WinUpdate"
            return
        }
        # No restart needed: go round and check again -- some updates only
        # appear once earlier ones are installed.
    }
}
'''

with PS1Edit(TARGET) as e:
    t = e.text
    s = t.index("function Invoke-WindowsUpdateLoop {\n")
    end = t.index("\n}\n", s) + 3
    old = t[s:end]
    assert "CreateUpdateInstaller" in old and "Show-GGUpdateRestart" in old
    e.replace(old, NEW_FN, count=1, why="E2: spinner while Windows Update works")
    e.replace(
        "#           CGDELL 2026-09-27); E3 unwanted-app blocking (FT-248); E4 virus\n",
        "#           CGDELL 2026-09-27; a spinner and timer run while it works, Bill\n"
        "#           2026-09-27); E3 unwanted-app blocking (FT-248); E4 virus\n",
        count=1, why="change log: spinner")
