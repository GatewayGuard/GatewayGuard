"""build_ascii45_c7b_allowctrlc -- C7 / FT-270, second half: every key read
passes AllowCtrlC, so PowerShell's own key reader no longer stops Checkup.

Dated: 2026-09-27 15:07 ET
Editor: Claude Code (CGDELL)

Bill, 2026-09-27: "tried copy and control c in checkup ascii45 on cgdell and it
ended the program" -- after C7 was built. MEASURED, five tests run by Bill in
full-screen Windows Terminal on CGDELL (Test_Results\CtrlCRepro-*):
  A  as built                     -> ended, nothing arrived
  B  no TreatControlCAsInput      -> Ctrl+C CAUGHT, then ended the same second
  C  A without the FT-150 handler -> ended
  D  B without the FT-150 handler -> caught, then ended
  11:27 test that SURVIVED two presses read keys with ReadKey(...AllowCtrlC).
All the ones that ended read keys WITHOUT AllowCtrlC. PowerShell documents
AllowCtrlC as letting Ctrl+C be read as a keystroke "as opposed to causing a
break event" (sourced, ReadKeyOptions) -- without it, the next ReadKey that
meets the Ctrl+C stops the program, whatever the handler did.

This adds AllowCtrlC to all 8 ReadKey calls. The existing "Character 3 ->
Invoke-CtrlCExit -> are you sure?" paths then receive it. To be confirmed by
Bill re-running Run-TestCtrlCRepro-A.bat (it loads Read-GGKey from this build).

Run from Tool2/:  python build_ascii45_c7b_allowctrlc.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace('ReadKey("NoEcho,IncludeKeyDown")', 'ReadKey("NoEcho,IncludeKeyDown,AllowCtrlC")',
              count=8, why="C7b: AllowCtrlC on every key read")
    e.replace(
        "#           a Ctrl+C signal handler does. Every answer is read via Read-GGKey.\n",
        "#           a Ctrl+C signal handler does. Every answer is read via Read-GGKey.\n"
        "#           C7b: every ReadKey passes AllowCtrlC -- without it PowerShell's\n"
        "#           own key reader stopped Checkup even after the handler caught the\n"
        "#           Ctrl+C (measured, tests A-D, 2026-09-27).\n",
        count=1, why="change log: C7b")
