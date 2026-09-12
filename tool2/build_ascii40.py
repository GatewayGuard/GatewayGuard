"""build_ascii40 -- the guarded edit pass that turns ascii39 into ascii40.

Dated: 2026-08-15 08:28 ET
Editor: Claude Code (CGDELL)

Every edit goes through gg_edit.PS1Edit, so each one asserts its own hit count
first and the whole pass fails closed if any assertion, the brace balance, the
size delta or the parse check disagrees. Nothing is written otherwise.

SCOPE -- the three field blockers named in
ProjectDocs\\GatewayGuard_FieldTestPlan-ascii40-2026-08-13-0944.md:

  FT-171  the input path.   Mouse records were reaching a 256-record buffer the
          tool then read as answers; the drain capped at 256 and reported the
          cap as a count; one bare N could end the session.
  FT-175  the quarterly Defender offline scan, which has never run on any
          machine because MpCmdRun -ScanType 4 does not exist.
  FT-172  the shown-as screen numbers.  NOT IN THIS PASS -- it waits on Bill's
          approval of the $script:GGScreenOrder approach (field test plan,
          held question 2).

Run:  python Tool\\build_ascii40.py
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from gg_edit import PS1Edit  # noqa: E402

TARGET = Path(__file__).parent / "W11-SecurityHardening-v3-ascii40-2026-08-15-0828.ps1"


# ---------------------------------------------------------------- header ---

OLD_HEADER = """# Dated: 2026-07-30 22:08 EDT
# ================================================================
# FILE:    W11-SecurityHardening-v3-ascii39-2026-07-30-2208.ps1
# BUILD:   ascii39  |  Version 3.1
# CHANGES FROM ascii38 (2026-07-30 -- ASCII39: THE SURVIVAL AND TRUTHFULNESS PASS):"""

NEW_HEADER = """# Dated: 2026-08-15 08:28 EDT
# ================================================================
# FILE:    W11-SecurityHardening-v3-ascii40-2026-08-15-0828.ps1
# BUILD:   ascii40  |  Version 3.1
# CHANGES FROM ascii39 (2026-08-15 -- ASCII40: THE THREE FIELD BLOCKERS):
#   SCOPE NOTE. Two of the three blockers are in this build. FT-172 (the
#   shown-as screen numbers) is held pending Bill's approval of the
#   $script:GGScreenOrder approach -- see the field test plan, question 2.
#   Playbook Class 6 rule 3 asks for one change class per build; this build
#   carries two (input handling, and one wrong external command), which is
#   already better attribution than ascii39's three.
#
#   ---- FT-171: THE INPUT PATH. FIVE PARTS, ALL FIVE IN. ----
#
#   The 2026-08-11 SANDY run ended twice on a right-click and was written up
#   as a crash. It was not a crash. PowerShell's own event log recorded no
#   event at the time of either ending, which is what an external process kill
#   or a deliberate exit path looks like, and not what a fault looks like.
#
#   171a  ENABLE_MOUSE_INPUT IS NOW CLEARED TOO. measured on SANDY
#         2026-08-14 22:25 (Test_Results\\ConsoleInputMode-SANDY-2026-08-14_22-25.txt):
#         the console mode was 0x01B7 -- QuickEdit already OFF, and
#         ENABLE_MOUSE_INPUT still ON, because ascii39's mask (4294967231)
#         clears bit 6 and leaves bit 4 alone. With bit 4 set, every mouse
#         move, click and wheel tick over the window becomes an INPUT_RECORD
#         in the same buffer keypresses use.
#         Checkup NEVER reads a mouse event, so clearing the flag discards
#         records nothing was going to use. sourced, SetConsoleMode: the flag
#         decides whether mouse events are REPORTED or DISCARDED -- it does
#         not create wheel scrolling. CONFIRM THE WHEEL STILL SCROLLS IN
#         PHASE 3 rather than trusting either side of that argument.
#   171b  THE DRAIN IS A FLUSH, NOT A COUNTED READ. Clear-PendingKeys looped
#         `while KeyAvailable` up to 256 reads / 200 ms. A 256-record buffer
#         and a 256-read cap is a coin toss. FlushConsoleInputBuffer empties
#         it in one call and cannot hit a cap.
#   171c  A CAP IS NEVER REPORTED AS A COUNT. The fallback path (used only if
#         the P/Invoke is unavailable) now logs "drain stopped at its cap --
#         events may remain" when it stops at the ceiling. A number that
#         cannot exceed its own limit is not a measurement. That is FT-162's
#         lesson -- [GOOD] printed over a command that had failed -- applied
#         to the thing next door.
#   171d  NO SINGLE KEYSTROKE ENDS THE SESSION. Show-ResumeReverify exited on
#         a bare N. CLAUDE.md has said "no accidental exits without
#         confirmation" since ascii28 and this screen broke it. N now asks.
#   171e  THE ANSWER IS TIMESTAMP-GATED -- Reset-GGInputGate, called at the
#         end of Write-GGBox, so EVERY screen gets it and a new screen cannot
#         forget it. Anything sitting in the buffer when the box finishes
#         painting arrived BEFORE the user could read the question, so it is
#         discarded. That closes the class, not just the one screen.
#         WHY THIS IS NOT FT-29: FT-29 flushed immediately BEFORE THE READ,
#         after the prompt had been on screen, so it ate the key of anyone who
#         answered promptly -- reported five or more times as "had to press
#         twice". This flush happens BEFORE THE PROMPT IS PRINTED. The window
#         it discards from is the paint itself. Nothing typed in answer to a
#         question the user has actually seen can be inside it.
#   171f  AND THE CONSOLE FLAGS ARE ASSERTED BEFORE EVERY SCREEN, not once
#         deep into the run. Found while reading for 171a: measured on the
#         ascii39 source, Disable-QuickEdit had two call sites and BOTH were
#         inside Get-AllStatuses, which runs most of the way through the
#         session. Every screen before it -- the personal-computer question
#         and the resume re-check among them -- ran with the console in
#         whatever state it started in, and SCREEN-02 announced that mouse
#         highlighting was off several screens before anything turned it off.
#         Reset-GGInputGate asserts them, so 171a actually applies from the
#         first screen instead of from the middle.
#
#   ---- FT-175: THE QUARTERLY SCAN THAT HAS NEVER RUN ----
#
#   FT-162, observed in the field for the first time (findings 38 and 43).
#   The quarterly task ran `MpCmdRun.exe -Scan -ScanType 4`. measured on
#   CGDELL 2026-08-15, MpCmdRun.exe -? documents ScanType 0-3 and no 4;
#   ScanType 4 returns 0x80070667 "Invalid command line argument" in 0.0
#   seconds. The log printed [GOOD] Scheduled task created every time,
#   because schtasks had indeed created a task -- one whose command was junk.
#
#   THE OBVIOUS FIX IS WRONG AND WAS NOT MADE. Start-MpWDOScan is the correct
#   call and is already in this file, but sourced, Microsoft's own cmdlet
#   reference: "This command causes the computer to start in Windows Defender
#   offline and begin the scan." It REBOOTS. It does not queue anything for a
#   later restart. Putting it in a task that runs as SYSTEM at 2AM would
#   restart a sleeping senior's computer unannounced, four times a year, to
#   run a scan nobody asked for that morning. That is the opposite of the
#   promise this product is sold on.
#
#   SO THE QUARTERLY TASK IS NOW A REMINDER, on the pattern of the monthly
#   Malwarebytes reminder already in this file: a popup that tells the user
#   the offline scan is due and gives the steps. The user starts it, having
#   been told the machine restarts. The interactive path (SCREEN-38) is
#   unchanged -- it already called Start-MpWDOScan correctly and already said
#   the computer would restart.
#
#   The screen text that described the old behaviour is replaced. It was
#   wrong twice over: it named a command line at the user (gate 24b) and the
#   mechanism it described never happened.
#
# CHANGES FROM ascii38 (2026-07-30 -- ASCII39: THE SURVIVAL AND TRUTHFULNESS PASS):"""


# --------------------------------------------------------------- FT-171a ---

OLD_SIG = """[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool SetConsoleMode(IntPtr hConsoleHandle, uint dwMode);
'@"""

NEW_SIG = """[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool SetConsoleMode(IntPtr hConsoleHandle, uint dwMode);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool FlushConsoleInputBuffer(IntPtr hConsoleHandle);
'@"""

OLD_MASK = """            # Clear ENABLE_QUICK_EDIT_MODE (64), keep ENABLE_EXTENDED_FLAGS (128).
            # DECIMAL literals only -- hex literals near the sign bit caused the
            # ascii23 0x80000003 bug (PowerShell parses hex as SIGNED Int32).
            # 4294967231 = all bits set except bit 6 (QuickEdit).
            $newMode = [uint32](($mode -band [uint32]4294967231) -bor [uint32]128)
            [void]$script:GGK32::SetConsoleMode($handle, $newMode)
            # FT-148: once per session, not once per item.
            if (-not $script:GGQuickEditLogged) {
                Write-Log -Message "QuickEdit mode disabled for this session (FT-01 mitigation) -- re-asserted silently from here on" -Status "OK"
                $script:GGQuickEditLogged = $true
            }"""

NEW_MASK = """            # Clear ENABLE_QUICK_EDIT_MODE (64) AND ENABLE_MOUSE_INPUT (16),
            # keep ENABLE_EXTENDED_FLAGS (128).
            # DECIMAL literals only -- hex literals near the sign bit caused the
            # ascii23 0x80000003 bug (PowerShell parses hex as SIGNED Int32).
            # 4294967231 = all bits set except bit 6 (QuickEdit).
            # 4294967279 = all bits set except bit 4 (ENABLE_MOUSE_INPUT).
            #
            # FT-171a (ascii40): THE SECOND MASK IS THE NEW ONE. ascii39 cleared
            # QuickEdit and left mouse input alone, so SANDY ran the whole
            # 2026-08-11 field session with mouse reporting ON -- measured
            # 2026-08-14 22:25, mode 0x01B7, QuickEdit already off and
            # ENABLE_MOUSE_INPUT still set. Every mouse move over the window was
            # landing in the same 256-record input buffer the tool reads answers
            # from. Checkup never reads a mouse event, so this discards records
            # nothing was going to use.
            # COULD CAUSE: nothing Checkup uses. sourced, SetConsoleMode -- the
            # flag decides whether mouse events are reported to the application
            # or discarded, and does not control wheel scrolling by the console
            # host. That last part is worth CONFIRMING IN THE FIELD (phase 3)
            # rather than believed, because the opposite claim was written down
            # here first and was wrong.
            $newMode = [uint32](($mode -band [uint32]4294967231 -band [uint32]4294967279) -bor [uint32]128)
            [void]$script:GGK32::SetConsoleMode($handle, $newMode)
            # FT-148: once per session, not once per item.
            if (-not $script:GGQuickEditLogged) {
                Write-Log -Message "QuickEdit AND mouse input reporting disabled for this session (FT-01, FT-171a) -- re-asserted silently from here on" -Status "OK"
                $script:GGQuickEditLogged = $true
            }"""


# ------------------------------------------------------- FT-171b and 171c ---

OLD_DRAIN = """function Clear-PendingKeys {
    try {
        $ggDrained = 0
        $ggSw = [System.Diagnostics.Stopwatch]::StartNew()
        while ($Host.UI.RawUI.KeyAvailable -and $ggDrained -lt 256 -and $ggSw.ElapsedMilliseconds -lt 200) {
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            $ggDrained++
        }
        $ggSw.Stop()
        if ($ggDrained -gt 0) {
            try { Write-Log -Message ("Discarded " + $ggDrained + " keypress(es) that were already queued before this screen appeared (FT-149)") -Status "KEY" } catch {}
        }
    } catch {}
}"""

NEW_DRAIN = """#
# FT-171b (ascii40): IT IS A FLUSH NOW, NOT A COUNTED READ. ascii39 read up to
# 256 events or 200 ms, whichever came first. The console input buffer holds
# 256 records. A 256-record buffer drained by a 256-read cap is a coin toss,
# and with mouse reporting on (FT-171a) the buffer could be full of records
# that were never keypresses at all. FlushConsoleInputBuffer empties it in one
# call, cannot hit a cap, and cannot spin.
#
# FT-171c (ascii40): AND IT NO LONGER REPORTS A CAP AS A COUNT. The old log
# line said "Discarded N keypress(es)" where N could only ever be 256, because
# 256 was the ceiling. That is FT-162 in miniature -- a number that cannot
# exceed its own limit is not a measurement, and printing it as one is how
# [GOOD] came to sit over a command that had returned an error. The flush path
# does not claim a count at all. The fallback path, used only if the P/Invoke
# is unavailable, says plainly when it stopped at its ceiling.
function Clear-PendingKeys {
    try {
        # Preferred path: one call, no cap, no count to misreport.
        if ($null -ne $script:GGK32) {
            $ggH = $script:GGK32::GetStdHandle(-10)   # STD_INPUT_HANDLE
            if ($script:GGK32::FlushConsoleInputBuffer($ggH)) {
                return
            }
        }
    } catch {}
    # Fallback only. Reached if Add-Type never ran, or the flush returned false.
    try {
        $ggDrained = 0
        $ggSw = [System.Diagnostics.Stopwatch]::StartNew()
        while ($Host.UI.RawUI.KeyAvailable -and $ggDrained -lt 256 -and $ggSw.ElapsedMilliseconds -lt 200) {
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            $ggDrained++
        }
        $ggSw.Stop()
        $ggHitCap = ($ggDrained -ge 256) -or ($ggSw.ElapsedMilliseconds -ge 200)
        if ($ggHitCap) {
            try { Write-Log -Message ("Input drain stopped at its cap -- events may remain. Stopped after " + $ggDrained + " read(s) / " + $ggSw.ElapsedMilliseconds + " ms (FT-171c)") -Status "WARN" } catch {}
        } elseif ($ggDrained -gt 0) {
            try { Write-Log -Message ("Discarded " + $ggDrained + " keypress(es) that were already queued before this screen appeared (FT-149)") -Status "KEY" } catch {}
        }
    } catch {}
}

# -- RESET-GGINPUTGATE (FT-171e, ascii40) --
# THE TIMESTAMP GATE, AND IT IS THE PART THAT CLOSES THE CLASS.
#
# Called at the end of Write-GGBox, so it runs once per screen, on every screen,
# automatically -- a screen added next build gets it without being told, in the
# same way FT-153's trailing blank line is produced centrally rather than at 58
# call sites.
#
# WHAT IT DOES: anything sitting in the input buffer at the instant the box
# finishes painting arrived BEFORE the user could have read the question. It is
# discarded, and the render tick is stamped so the log can say which screen the
# accepted key belongs to.
#
# WHY THIS IS NOT FT-29, AND THE DISTINCTION IS THE WHOLE DESIGN: FT-29 was a
# flush IMMEDIATELY BEFORE THE READ -- after the prompt had been printed and
# the user had had time to answer it. It ate the legitimate first keypress of
# anyone who typed promptly, field-reported five or more times as "had to press
# twice", and it stays removed. This flush happens BEFORE THE PROMPT IS
# PRINTED. The only window it discards from is the paint itself. A key typed in
# answer to a question the user has actually seen cannot be inside that window.
#
# COULD CAUSE: a user who has learned the screens by heart and types the answer
# during the paint loses that keystroke and presses again. That is the intended
# trade, and it is the same trade FT-65 and FT-149 already make after an accept.
#
# IT ALSO RE-ASSERTS THE CONSOLE FLAGS, AND THAT PART FIXES A SEPARATE DEFECT
# FOUND WHILE READING FOR FT-171 (ascii40). measured on the ascii39 source:
# Disable-QuickEdit had exactly TWO call sites, both inside Get-AllStatuses --
# which does not run until the user is most of the way through the session. So
# every screen before it, INCLUDING the personal-computer question and the
# resume re-check, ran with QuickEdit and mouse reporting in whatever state the
# console started in. SCREEN-02 told the user "mouse highlighting and
# right-click copy are switched OFF in this window" several screens BEFORE any
# code had switched them off. The screen was telling the truth about the
# intent and not about the machine.
# Asserting here means the flags are set before EVERY screen, which is what
# CLAUDE.md's standing rule has asked for all along ("console flags must be
# re-asserted before every read, not once at startup"). It is also what makes
# the flush above work at all, since Disable-QuickEdit is what builds the
# cached P/Invoke type the flush calls through.
function Reset-GGInputGate {
    try {
        Disable-QuickEdit
        $script:GGScreenRenderTicks = [System.Diagnostics.Stopwatch]::GetTimestamp()
        Clear-PendingKeys
    } catch {}
}"""

OLD_BOXEND = """    Write-Host $border -ForegroundColor $Color
}

function Get-AllScreenDefinitions {"""

NEW_BOXEND = """    Write-Host $border -ForegroundColor $Color
    # FT-171e (ascii40): the timestamp gate, applied centrally so that every
    # screen has it and no new screen can forget it. See Reset-GGInputGate for
    # why this is not the FT-29 pre-read flush.
    Reset-GGInputGate
}

function Get-AllScreenDefinitions {"""


# --------------------------------------------------------------- FT-171d ---

OLD_RESUME_EXIT = """    $rc = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Still YOUR personal computer? (Y = Yes / N = Exit): "
    if ($rc.ToUpper() -eq "N") {
        Write-Host ""
        Write-Host "  Exiting. No changes made." -ForegroundColor Yellow
        Write-Log -Message "Resume re-check: user said not personal PC -- exit" -Status "EXIT"
        Disable-SleepPrevention
        Save-Log
        exit
    }"""

NEW_RESUME_EXIT = """    $rc = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Still YOUR personal computer? (Y = Yes / N = Exit): "
    if ($rc.ToUpper() -eq "N") {
        # FT-171d (ascii40): N USED TO END THE SESSION ON ITS OWN. One key, no
        # confirmation, everything closed -- against CLAUDE.md's standing rule
        # that there are no accidental exits without confirmation. On a machine
        # whose input buffer was accepting stray events (FT-171a), a single
        # stray N was all it took, and that is the shape of the two 2026-08-11
        # SANDY endings that were written up as crashes.
        Write-Host ""
        Draw-Box -ScreenId "83" -Color Yellow -Lines @(
            "  ARE YOU SURE YOU WANT TO CLOSE CHECKUP?                   ",
            "---",
            "  You answered that this is NOT your own personal computer. ",
            "  Checkup is only for computers you own, so it will close.  ",
            "                                                             ",
            "  Nothing on your computer has been changed.                ",
            "                                                             ",
            "  Press Y to close Checkup now.                             ",
            "  Press N to go back -- it IS your computer and you want    ",
            "  to carry on where you left off.                           "
        )
        Write-Host ""
        $rcSure = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Close Checkup? (Y = close / N = go back): "
        if ($rcSure.ToUpper() -eq "Y") {
            Write-Host ""
            Write-Host "  Exiting. No changes made." -ForegroundColor Yellow
            Write-Log -Message "Resume re-check: user said not personal PC, and confirmed the exit -- exit" -Status "EXIT"
            Disable-SleepPrevention
            Save-Log
            exit
        }
        Write-Log -Message "Resume re-check: N was not confirmed -- carrying on (FT-171d)" -Status "CONFIRM"
        Write-Host ""
        Write-Host "  Carrying on where you left off." -ForegroundColor Green
    }"""


# ---------------------------------------------------------------- FT-175 ---

OLD_TASK1 = """    # --- Task 1: Quarterly Defender Offline Scan ---
    try {
        $mpCmd = "$env:ProgramFiles\\Windows Defender\\MpCmdRun.exe"
        if (-not (Test-Path $mpCmd)) { $mpCmd = "MpCmdRun.exe" }
"""

NEW_TASK1 = """    # --- Task 1: Quarterly Defender Offline Scan REMINDER ---
    # FT-175 (ascii40): THIS TASK HAS NEVER RUN A SCAN ON ANY MACHINE.
    # It used to schedule `MpCmdRun.exe -Scan -ScanType 4`.
    # VERIFIED 2026-08-15 measured on CGDELL: `MpCmdRun.exe -?` documents
    # -ScanType 0 (default), 1 (quick), 2 (full) and 3 (file). THERE IS NO 4.
    # ScanType 4 returns 0x80070667 "Invalid command line argument" in 0.0
    # seconds and does nothing -- while this function logged
    # "[GOOD] Scheduled task created", because schtasks had genuinely created a
    # task. The task was real. Its command was junk. Field findings 38 and 43.
    #
    # AND THE CORRECT CALL CANNOT GO IN A SCHEDULED TASK EITHER.
    # VERIFIED 2026-08-15 sourced, Microsoft's Start-MpWDOScan reference:
    # "This command causes the computer to start in Windows Defender offline
    # and begin the scan." It reboots the machine there and then; it does not
    # queue anything for the next restart. As a SYSTEM task at 2AM that would
    # restart a sleeping user's computer without warning, four times a year.
    # https://learn.microsoft.com/en-us/powershell/module/defender/start-mpwdoscan
    #
    # So the quarterly task is a REMINDER, exactly like the monthly
    # Malwarebytes one below: it tells the user the scan is due, tells them the
    # computer will restart, and lets them start it. The user's permission is
    # what starts an offline scan -- which is what SCREEN-38 already does
    # correctly in the interactive run, using Start-MpWDOScan.
    try {
        $scanDir = "C:\\ProgramData\\GatewayGuard"
        if (-not (Test-Path $scanDir)) { New-Item -Path $scanDir -ItemType Directory -Force | Out-Null }

        $offlineCode = @"
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show(
    "QUARTERLY SECURITY REMINDER -- GatewayGuard Checkup``n``n" +
    "Your Microsoft Defender Offline Scan is due.``n``n" +
    "This scan runs BEFORE Windows loads, so it catches things``n" +
    "that hide while the computer is running normally.``n``n" +
    "HOW TO START IT:``n" +
    "  1. Press the Windows key and type: Windows Security``n" +
    "  2. Open it, then click Virus and threat protection``n" +
    "  3. Under Current threats, click Scan options``n" +
    "  4. Choose Microsoft Defender Antivirus (offline scan)``n" +
    "  5. Click Scan now``n``n" +
    "WHAT WILL HAPPEN:``n" +
    "  Your computer restarts, a blue scan screen runs for about``n" +
    "  15 minutes, and then it restarts back to your desktop.``n``n" +
    "SAVE YOUR WORK FIRST. Start it when you do not need the``n" +
    "computer for half an hour. Nothing starts without you.",
    "GatewayGuard -- Quarterly Defender Offline Scan Due",
    [System.Windows.Forms.MessageBoxButtons]::OK,
    [System.Windows.Forms.MessageBoxIcon]::Information
) | Out-Null
"@
        $offlineCode | Out-File -FilePath "$scanDir\\OfflineScanReminder.ps1" -Encoding UTF8 -Force
"""

OLD_TASK1_TR = """        $ggT1Name = "GatewayGuard - Quarterly Defender Offline Scan"
        # FT-109 (ascii34): the /tr value here quotes MpCmdRun.exe's path
        # because it contains a space ("Program Files"). PowerShell's own
        # native-argument marshalling for `&`-invoked exes mangles an
        # already-quoted argument that ALSO contains a space, splitting it
        # mid-path -- this produced the field error "Invalid argument/
        # option - 'Files\\Windows'". Empirically confirmed 2026-07-25
        # (throwaway test task, since deleted) that invoking via
        # Invoke-SchTasksCreate (raw ProcessStartInfo, bypassing
        # PowerShell's argument marshalling entirely) is the only tested
        # fix that survives correctly -- see that function for detail.
        $ggT1Tr = '\\"' + $mpCmd + '\\" -Scan -ScanType 4'
        $ggT1Args = "/create /f /tn `"$ggT1Name`" /tr `"$ggT1Tr`" /sc monthly /m JAN,APR,JUL,OCT /d 1 /st 02:00 /ru SYSTEM /rl HIGHEST"
        $ggT1Result = Invoke-SchTasksCreate -Arguments $ggT1Args
        if ($ggT1Result.ExitCode -ne 0) { throw "schtasks exit $($ggT1Result.ExitCode) -- $($ggT1Result.Output)" }

        $results += @{ Text = "  [OK] Quarterly Defender Offline Scan scheduled (Jan/Apr/Jul/Oct, 1st @ 2AM)"; Color = "Green" }
        Write-Log -Message "Scheduled task created: GatewayGuard - Quarterly Defender Offline Scan" -Status "GOOD\""""

NEW_TASK1_TR = """        # The task NAME is unchanged on purpose. CLAUDE.md lists the two
        # GatewayGuard task names as identifiers and recovery points, not
        # prose: renaming this one would orphan the task on every machine
        # that already has it.
        $ggT1Name = "GatewayGuard - Quarterly Defender Offline Scan"
        # FT-109 (ascii34): the /tr value quotes the -File argument because its
        # path can contain a space. PowerShell's own native-argument
        # marshalling for `&`-invoked exes mangles an already-quoted argument
        # that ALSO contains a space, splitting it mid-path -- this produced
        # the field error "Invalid argument/option - 'Files\\Windows'".
        # Empirically confirmed 2026-07-25 (throwaway test task, since
        # deleted) that invoking via Invoke-SchTasksCreate (raw
        # ProcessStartInfo, bypassing PowerShell's argument marshalling
        # entirely) is the only tested fix that survives correctly -- see that
        # function for detail.
        # NO /ru SYSTEM here any more. The reminder is a popup and has to
        # appear on the user's own desktop, so it runs as the current
        # interactive user -- the same reason task 2 below has no /ru. A
        # SYSTEM task would put the popup on a desktop nobody is looking at.
        $ggT1Tr = 'powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File \\"' + "$scanDir\\OfflineScanReminder.ps1" + '\\"'
        $ggT1Args = "/create /f /tn `"$ggT1Name`" /tr `"$ggT1Tr`" /sc monthly /m JAN,APR,JUL,OCT /d 1 /st 10:00"
        $ggT1Result = Invoke-SchTasksCreate -Arguments $ggT1Args
        if ($ggT1Result.ExitCode -ne 0) { throw "schtasks exit $($ggT1Result.ExitCode) -- $($ggT1Result.Output)" }

        $results += @{ Text = "  [OK] Quarterly offline-scan reminder scheduled (Jan/Apr/Jul/Oct, 1st @ 10AM)"; Color = "Green" }
        Write-Log -Message "Scheduled task created: GatewayGuard - Quarterly Defender Offline Scan (reminder popup -- FT-175)" -Status "GOOD\""""

OLD_TASK1_ERR = """        $results += @{ Text = "  [!] Quarterly scan task -- could not create: $_"; Color = "Yellow" }
        Write-Log -Message "Scheduled task ERROR: Quarterly Defender Offline Scan -- $_" -Status "ERROR\""""

NEW_TASK1_ERR = """        $results += @{ Text = "  [!] Quarterly scan reminder -- could not create: $_"; Color = "Yellow" }
        Write-Log -Message "Scheduled task ERROR: Quarterly Defender Offline Scan reminder -- $_" -Status "ERROR\""""


OLD_SCAN_TEXT = """    Write-Host "  IMPORTANT -- HOW THE OFFLINE SCAN WORKS:" -ForegroundColor White
    Write-Host "  The quarterly task runs MpCmdRun.exe -ScanType 4 which SCHEDULES" -ForegroundColor Gray
    Write-Host "  the offline scan for your NEXT PC restart. You will see:" -ForegroundColor Gray
    Write-Host "    'Microsoft Defender Offline' screen on startup" -ForegroundColor DarkCyan
    Write-Host "  The scan runs before Windows fully loads -- this is intentional" -ForegroundColor Gray
    Write-Host "  and allows it to catch rootkits Defender cannot see at runtime." -ForegroundColor Gray"""

NEW_SCAN_TEXT = """    Write-Host "  IMPORTANT -- HOW THE QUARTERLY REMINDER WORKS:" -ForegroundColor White
    Write-Host "  Four times a year -- January, April, July and October -- a" -ForegroundColor Gray
    Write-Host "  message appears telling you your offline scan is due, with" -ForegroundColor Gray
    Write-Host "  the steps for starting it. YOU choose when to start it." -ForegroundColor Gray
    Write-Host "  Checkup never starts a scan, and never restarts your" -ForegroundColor Gray
    Write-Host "  computer, without your permission." -ForegroundColor Gray
    Write-Host "  The scan itself runs before Windows loads, which is how it" -ForegroundColor Gray
    Write-Host "  catches things that hide while the computer is running." -ForegroundColor Gray"""


def main():
    with PS1Edit(TARGET) as e:
        e.replace(OLD_HEADER, NEW_HEADER, count=1,
                  why="build ID: FILE + BUILD header, dated line, ascii40 change block")
        e.replace('$BuildID        = "ascii39"', '$BuildID        = "ascii40"', count=1,
                  why="build ID: $BuildID (3rd of the five locations)")

        e.replace(OLD_SIG, NEW_SIG, count=1,
                  why="FT-171b: add FlushConsoleInputBuffer to the cached P/Invoke type")
        e.replace(OLD_MASK, NEW_MASK, count=1,
                  why="FT-171a: clear ENABLE_MOUSE_INPUT as well as QuickEdit")
        e.replace(OLD_DRAIN, NEW_DRAIN, count=1,
                  why="FT-171b/c/e: flush not counted read, no cap-as-count, add Reset-GGInputGate")
        e.replace(OLD_BOXEND, NEW_BOXEND, count=1,
                  why="FT-171e: call the timestamp gate centrally at the end of Write-GGBox")
        e.replace(OLD_RESUME_EXIT, NEW_RESUME_EXIT, count=1,
                  why="FT-171d: Show-ResumeReverify N now confirms before exiting")

        e.replace(OLD_TASK1, NEW_TASK1, count=1,
                  why="FT-175: quarterly task writes a reminder script, not an MpCmdRun call")
        e.replace(OLD_TASK1_TR, NEW_TASK1_TR, count=1,
                  why="FT-175: schedule the reminder as the interactive user, drop ScanType 4")
        e.replace(OLD_TASK1_ERR, NEW_TASK1_ERR, count=1,
                  why="FT-175: error text names the reminder")
        e.replace(OLD_SCAN_TEXT, NEW_SCAN_TEXT, count=1,
                  why="FT-175 + gate 24b: screen no longer shows a command line or a false mechanism")

    return 0


if __name__ == "__main__":
    sys.exit(main())
