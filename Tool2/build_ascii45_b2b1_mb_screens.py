"""build_ascii45_b2b1_mb_screens -- screens 13 and 14 stop recommending
Malwarebytes; the Malwarebytes follow-up (screens 18, 18a-c) is removed.

Dated: 2026-09-26 11:19 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block B, item B2 (part b-1).

Bill's ascii44 notes 6, 7, 11, 13 (screens 13, 14, 17, 18): Malwarebytes is
still recommended although it is out of Checkup (2026-09-08) and no product
but Microsoft Defender may be named (2026-09-25).

  Screen 13 (ID 26): Defender section kept; the Malwarebytes and 14-day-trial
    sections replaced by one generic paragraph about another antivirus.
  Screen 14 (ID 27): only the scan Checkup runs today -- the Defender Offline
    Scan -- with the rootkit explanation moved onto it. The Checkup-started
    full scan is Block E; this screen does not promise it before it exists
    (FT-278 was exactly that defect).
  Screens 18/18a/18b/18c (IDs 73, 13, 47, 48): Show-MalwarebytesFollowUp
    deleted, its call removed, its four screen-table rows removed.
  OPEN, deliberately: the gap this leaves in the numbering (17 -> 18d -> 19)
    is renumbered once, after Block E reorders the scan section, so support
    screen numbers change once and not twice.

Every new box line is padded to the box's 61-character width.

Run from Tool2/:  python build_ascii45_b2b1_mb_screens.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"
SRC = open(TARGET, encoding="utf-8-sig").read().replace("\r\n", "\n")
W = 61


def span(start, end):
    assert SRC.count(start) == 1, (start[:70], SRC.count(start))
    i = SRC.index(start)
    j = SRC.index(end, i + len(start)) + len(end)
    return SRC[i:j]


def box_lines(lines, indent="        "):
    out = []
    for k, t in enumerate(lines):
        body = t if t == "---" else t.ljust(W)
        assert t == "---" or len(t) <= W, (len(t), t)
        out.append(f'{indent}"{body}"' + ("," if k < len(lines) - 1 else ""))
    return "\n".join(out) + "\n"


S13_OLD = span('    Draw-Box -ScreenId "26" -Color White -Lines @(\n', "\n    )\n")
S13_NEW = '    Draw-Box -ScreenId "26" -Color White -Lines @(\n' + box_lines([
    "  YOUR PC'S SECURITY TOOLS -- A QUICK INTRODUCTION",
    "---",
    "  Before we change anything, here is what protects your PC",
    "  and how the pieces fit together.",
    "",
    "  MICROSOFT DEFENDER (already on your PC)",
    "  Windows comes with a built-in antivirus called Microsoft",
    "  Defender. It is free, already installed, and watches your",
    "  PC in real time -- every file you open, every download,",
    "  every program you run. Checkup will make sure it is",
    "  set up correctly.",
    "",
    "  ANOTHER ANTIVIRUS ALREADY INSTALLED?",
    "  If your PC came with one, or you bought one, Checkup will",
    "  notice and tell you. Only one antivirus can watch in real",
    "  time. Checkup does not remove it -- it shows you what it",
    "  found.",
    "",
    "  YOUR RECORDS",
    "  Checkup keeps a record of everything it does, saved",
    "  in your own GatewayGuard folder. If you need help, that",
    "  file shows exactly what happened on your PC.",
]) + "    )\n"

S14_OLD = span('    Draw-Box -ScreenId "27" -Color White -Lines @(\n', "\n    )\n")
S14_NEW = '    Draw-Box -ScreenId "27" -Color White -Lines @(\n' + box_lines([
    "  THE SCAN WE RECOMMEND -- AND WHY",
    "---",
    "  Before hardening your settings, we want your PC confirmed",
    "  clean. A scan AFTER hardening cannot undo an infection",
    "  that is already there.",
    "",
    "  DEFENDER OFFLINE SCAN (15-20 minutes)",
    "  Runs BEFORE Windows loads -- so threats cannot hide the",
    "  way they can once Windows is running. Your PC restarts",
    "  by itself, scans, and comes back. Checkup picks up",
    "  right where you left off.",
    "",
    "  What is a rootkit? One of the sneakiest kinds of",
    "  malicious software. It buries itself deep inside Windows",
    "  and hides, so your PC can be infected while everything",
    "  still LOOKS normal. A scan that runs before Windows",
    "  loads looks where rootkits hide.",
    "",
    "  Already ran this scan today? You can skip ahead on the",
    "  next screen.",
]) + "    )\n"

FOLLOWUP = span("# ============================================================\n"
                "# MALWAREBYTES DETECT-AND-LAUNCH FOLLOW-UP (UX-06, OBS-01)\n",
                "        Pause-ForUser \"  Press Enter or Space to continue...\"\n    }\n}\n\n")
assert FOLLOWUP.count("\nfunction ") == 1 and "function Show-MalwarebytesFollowUp {" in FOLLOWUP
assert FOLLOWUP.rstrip().endswith("}") and "# STEP 9" not in FOLLOWUP
print(f"follow-up block: {FOLLOWUP.count(chr(10))} lines")

with PS1Edit(TARGET, size_tolerance=0.05) as e:
    e.replace(
        "#           IDs not renumbered; typing 5 says it is no longer part of it.\n",
        "#           IDs not renumbered; typing 5 says it is no longer part of it.\n"
        "#   B2b-1:  SCREENS 13/14 STOP RECOMMENDING MALWAREBYTES (Bill's notes 6,\n"
        "#           7, 11, 13). 13: Defender + a generic other-antivirus note. 14:\n"
        "#           the offline scan only (the full scan arrives in Block E, not\n"
        "#           promised before). Screens 18/18a-c and Show-MalwarebytesFollowUp\n"
        "#           removed. Numbering gap closed by the renumber pass after Block E.\n",
        count=1, why="change log: B2b-1")
    e.replace(S13_OLD, S13_NEW, count=1, why="B2b-1: screen 13 without Malwarebytes")
    e.replace(S14_OLD, S14_NEW, count=1, why="B2b-1: screen 14 -- the offline scan only")
    e.replace(FOLLOWUP, "", count=1, why="B2b-1: delete Show-MalwarebytesFollowUp (screens 18, 18a-c)")
    e.replace(
        "# 12b. Malwarebytes detect-and-launch (UX-06 standalone checkpoint)\n"
        "if (-not (Test-CheckpointReached -Checkpoint \"Malwarebytes\")) {\n"
        "    Show-MalwarebytesFollowUp\n"
        "    Save-Checkpoint -Checkpoint \"Malwarebytes\"\n"
        "}\n",
        "# 12b. (removed in ascii45, B2b-1: the Malwarebytes follow-up. The\n"
        "# \"Malwarebytes\" checkpoint name is left in CheckpointOrder for D2/FT-266,\n"
        "# which re-orders that list.)\n",
        count=1, why="B2b-1: remove the follow-up call")
    for row in ['    "73" = "18"           # Malwarebytes detected\n',
                '    "13" = "18a"          # Malwarebytes -- alternative state\n',
                '    "47" = "18b"          # Malwarebytes -- alternative state\n',
                '    "48" = "18c"          # Malwarebytes -- alternative state\n']:
        e.replace(row, "", count=1, why="B2b-1: screen-table row removed -- " + row.strip()[:14])
print("B2b-1 applied")
