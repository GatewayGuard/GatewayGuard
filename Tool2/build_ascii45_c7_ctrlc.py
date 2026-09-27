"""build_ascii45_c7_ctrlc -- C7 / FT-270: Ctrl+C asks first in Windows Terminal.

Dated: 2026-09-27 11:29 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block C, item C7.

MEASURED on CGDELL 2026-09-27, full-screen Windows Terminal:
  11:09  Test_Results\WtCtrlC-CGDELL-2026-09-27_11-09.txt -- the current guard,
         [Console]::TreatControlCAsInput re-asserted before every read, does NOT
         work: Ctrl+C ended the program before any key arrived. So "Ctrl+C ends
         Checkup with no confirmation" (FT-270) is real wherever Checkup runs in
         Windows Terminal -- which, with no default set, is Windows 11's choice
         (inferred; CGDELL's DelegationConsole/Terminal values are blank).
  11:27  Test_Results\WtCtrlC2-CGDELL-2026-09-27_11-27.txt -- catching the SIGNAL
         (Console.CancelKeyPress, compiled handler, e.Cancel = true) works: two
         presses, both caught, the program kept running.

So: the handler is armed at start-up; every place that waits for an answer
reads through Read-GGKey, which waits for a key while watching the handler's
counter, and turns a caught Ctrl+C into the same key the old code expected
(Character 3). Every existing "Ctrl+C -> Invoke-CtrlCExit -> are you sure?"
path then works unchanged. The classic console path (TreatControlCAsInput) is
kept as it was. A Ctrl+C pressed while Checkup is busy is asked about at the
next question.

Run from Tool2/:  python build_ascii45_c7_ctrlc.py
"""
import re
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

HELPERS = r'''function Enable-GGCtrlCGuard {
    # C7 / FT-270 (ascii45). VERIFIED 2026-09-27 measured on CGDELL, full-screen
    # Windows Terminal: this handler caught Ctrl+C twice and the program kept
    # running (Test_Results\WtCtrlC2-CGDELL-2026-09-27_11-27.txt). The old guard
    # alone (TreatControlCAsInput) let Ctrl+C end the program (..._11-09.txt).
    # Compiled, so it runs without a PowerShell thread.
    try {
        if (-not ("GGCtrlC" -as [type])) {
            Add-Type -TypeDefinition @"
using System;
public static class GGCtrlC {
    public static volatile int Count = 0;
    static bool armed = false;
    public static void Arm() {
        if (armed) return;
        armed = true;
        Console.CancelKeyPress += delegate(object s, ConsoleCancelEventArgs e) { e.Cancel = true; Count++; };
    }
}
"@
        }
        [GGCtrlC]::Arm()
        $script:GGCtrlCHandled = 0
        Write-Log -Message "Ctrl+C guard armed (C7): a Ctrl+C asks first, in Windows Terminal too" -Status "OK"
    } catch {
        try { Write-Log -Message "Ctrl+C guard could not be armed: $_" -Status "WARN" } catch {}
    }
}

function Read-GGKey {
    # C7 (ascii45): wait for a key the way ReadKey("NoEcho,IncludeKeyDown") did,
    # but watch the Ctrl+C guard while waiting. A caught Ctrl+C comes back as
    # the key the callers already handle: Character 3.
    while ($true) {
        try { [Console]::TreatControlCAsInput = $true } catch {}   # classic console path (FT-46)
        $ggCount = 0
        try { $ggCount = [GGCtrlC]::Count } catch {}
        if ($ggCount -gt $script:GGCtrlCHandled) {
            $script:GGCtrlCHandled = $ggCount
            return (New-Object System.Management.Automation.Host.KeyInfo -ArgumentList 67, ([char]3), ([System.Management.Automation.Host.ControlKeyStates]::LeftCtrlPressed), $true)
        }
        $ggAvail = $true
        try { $ggAvail = $Host.UI.RawUI.KeyAvailable } catch { $ggAvail = $true }
        if ($ggAvail) { return $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") }
        Start-Sleep -Milliseconds 50
    }
}

function Invoke-CtrlCExit {'''

TARGET_FUNCS = {"Show-LookBack", "Wait-GGEnterOrSpace", "Pause-ForUser", "Read-ValidKey",
                "Read-NavKey", "Show-BitLockerScreen", "Run-ConsoleMode"}

with PS1Edit(TARGET) as e:
    e.replace(
        "#           finished (FT-277). New screens 90-95, interim labels.\n",
        "#           finished (FT-277). New screens 90-95, interim labels.\n"
        "#   C7 / FT-270: CTRL+C ASKS FIRST IN WINDOWS TERMINAL. The old guard\n"
        "#           (TreatControlCAsInput) does not work there -- measured 2026-09-27;\n"
        "#           a Ctrl+C signal handler does. Every answer is read via Read-GGKey.\n",
        count=1, why="change log: C7")
    e.replace("function Invoke-CtrlCExit {", HELPERS, count=1, why="C7 helpers")
    e.replace("\nShow-ResumePrompt\n",
              "\nEnable-GGCtrlCGuard   # C7 / FT-270: before the first question\nShow-ResumePrompt\n",
              count=1, why="C7: arm at start-up")

    # Route the eight answer-waiting reads through Read-GGKey (by function).
    lines = e.text.split("\n")
    cur = None
    hits = []
    pat = '$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")'
    for i, ln in enumerate(lines):
        m = re.match(r"^function ([A-Za-z0-9-]+) \{", ln)
        if m:
            cur = m.group(1)
        if pat in ln and cur in TARGET_FUNCS and "KeyAvailable" not in ln:
            lines[i] = ln.replace(pat, "Read-GGKey")
            hits.append((i + 1, cur))
    assert len(hits) == 8, hits
    new_text = "\n".join(lines)
    e.replace(e.text, new_text, count=1, why="C7: 8 reads -> Read-GGKey " + ", ".join(sorted(set(f for _, f in hits))))
