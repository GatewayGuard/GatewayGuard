"""build_ascii45_renumber -- the screen renumber pass after Blocks E and F.

Dated: 2026-09-28 08:35 ET
Editor: Claude Code (CGDELL)
Bill, 2026-09-28: "build block F and the renumber pass".

The scheme (Bill, 2026-08-17; CLAUDE.md): integers for the canonical journey
(first run, Home, AC power, administrator, Defender only, nothing skipped),
letters for departures, one level only, first encounters ascend, the I
screen unnumbered. IDs never change -- only the numbers shown.

MEASURED 2026-09-28 in this build: the main flow's call order (Show-ResumePrompt
... Run-ConsoleMode) and, per function, the ScreenIds it draws. Conditions:
90 only when Tamper is off; 93 only when app blocking is off; 91/92 only
when updates wait; 43/41/44/46 only when another antivirus is installed (the
Defender-only page went in F20); 36/37 only when time is not automatic; 39
replaces 10 on a repeat run; 49 replaces 98 on battery; 74 replaces 53 when
the answer is remembered; 59 only when a GOOD item is re-offered.

What changes, and why:
  * Gaps closed: 4 (the font sample, FT-274), 17/18 (the old antivirus and
    power pages), and 1-3/5-14 shift down by one from 4 onward.
  * Interim labels 14c-14h, 16a, 18, 27f, 32a, 32b become real numbers.
  * FT-195a: "1a" (welcome back) appeared BEFORE screen 1 when the user
    chose Start over -- a first-encounter decrease. It is now "0a", a
    departure before 1; resume goes 0a -> 1b, start over goes 0a -> 1.
  * The checklist's R-branch screens (non-recommended, encryption heads-up)
    stay on page 1's number (26a-26e), because R can be pressed from page 1
    without ever seeing page 2.
  * The log line "Start chosen at screen 21" typed a number -- now it reads
    the table.

Run from Tool2/:  python build_ascii45_renumber.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

CANON = [
    ("85", "1", "Welcome / maximize"),
    ("86", "2", "Scrolling"),
    ("87", "3", "Set your console font"),
    ("29", "4", "Before you start -- your window"),
    ("78", "5", "Before you start -- your keyboard"),
    ("30", "6", "What happens next"),
    ("02", "7", "How to scroll back and copy"),
    ("05", "8", "Important -- read before continuing"),
    ("34", "9", "Windows edition detected"),
    ("35", "10", "Your PC -- RAM"),
    ("09", "11", "Your system at a glance"),
    ("26", "12", "Your PC's security tools"),
    ("27", "13", "The scans we recommend"),
    ("97", "14", "Checking your PC's protection, step by step (F12)"),
    ("94", "15", "Before the scan -- what Checkup checked"),
    ("10", "16", "Pre-scan prep checklist"),
    ("38", "17", "Defender offline scan"),
    ("95", "18", "Full scan of every drive (E6)"),
    ("98", "19", "Power check -- plugged in, stay awake (FT-298)"),
    ("50", "20", "Power settings -- security review"),
    ("51", "21", "Apps audit results"),
    ("52", "22", "Mode selector"),
    ("53", "23", "Quick question -- your passwords"),
    ("54", "24", "What Checkup does and does not do (1 of 2)"),
    ("75", "25", "What Checkup does and does not do (2 of 2)"),
    ("76", "26", "The security checklist, page 1"),
    ("77", "27", "The security checklist, page 2"),
    ("55", "28", "Review your selections"),
    ("61", "29", "Final item: device encryption"),
    ("62", "30", "Your PC meets the requirements"),
    ("79", "31", "Before you turn it on -- your recovery key"),
    ("81", "32", "How to tell if encryption is running"),
    ("69", "33", "All selected items processed"),
    ("99", "34", "What Checkup changed (F1)"),
    ("100", "35", "Steps for you to do (F1)"),
    ("70", "36", "Automated scan schedule setup"),
    ("72", "37", "Checkup is finished -- steps only you can do"),
]
BRANCH = [
    ("25", "0a", "Welcome back -- a checkpoint exists (FT-195a: before 1)"),
    ("31", "1b", "Quick re-check before resuming"),
    ("83", "1c", "Are you sure you want to close Checkup?"),
    ("01", "3a", "Not administrator -- how to run Checkup correctly"),
    ("32", "8a", "Domain-joined warning"),
    ("33", "8b", "Administrator access required"),
    ("36", "10a", "Time and date -- check"),
    ("37", "10b", "Time and date -- out of sync"),
    ("90", "14a", "Tamper Protection is off (E1)"),
    ("43", "14b", "Antivirus -- Defender on, another product also installed"),
    ("41", "14c", "Antivirus -- alternative state"),
    ("44", "14d", "Antivirus -- alternative state"),
    ("46", "14e", "Antivirus -- alternative state"),
    ("93", "14f", "Unwanted app blocking (E3)"),
    ("91", "14g", "Windows Update -- updates waiting (E2)"),
    ("92", "14h", "Restart needed to finish updates (E2)"),
    ("39", "16a", "Reminder: pre-scan recommended (repeat run)"),
    ("40", "17a", "Welcome back -- offline scan complete"),
    ("49", "19a", "Power / battery warning"),
    ("74", "23a", "Your passwords -- we remembered your answer"),
    ("56", "26a", "Non-recommended selections"),
    ("57", "26b", "Non-recommended -- confirm"),
    ("58", "26c", "Heads up -- skipping encryption"),
    ("60", "26d", "Why encrypt?"),
    ("68", "26e", "Encryption declined"),
    ("59", "28a", "Already correct -- re-offered"),
    ("96", "28b", "Drive already encrypted, protection off (FT-297)"),
    ("64", "28c", "BitLocker (Windows 11 Pro)"),
    ("65", "28d", "BitLocker -- what will happen (Pro)"),
    ("66", "28e", "BitLocker -- confirm (Pro)"),
    ("67", "28f", "BitLocker enabled (Pro)"),
    ("63", "29a", "Device encryption may not be available on this PC"),
    ("82", "31a", "Already signed in with a Microsoft account"),
    ("80", "31b", "How to sign in with a Microsoft account"),
    ("88", "36a", "OneDrive offer -- shown only when there is no OneDrive"),
    ("89", "36b", "How to set up OneDrive"),
]


def row(i, lab, note):
    left = '    "%s" = "%s"' % (i, lab)
    return left.ljust(26) + "# " + note + "\n"


with PS1Edit(TARGET) as e:
    e.replace(
        "#           line. FT-222: a changed item loses its X.\n",
        "#           line. FT-222: a changed item loses its X.\n"
        "#   RENUMBER (2026-09-28): gaps and interim labels gone; 1a -> 0a (FT-195a).\n",
        count=1, why="change log: renumber")

    t = e.text
    s = t.index("    # -- the canonical journey ------------------------------------\n")
    end = t.index("    # -- reachable from everywhere, so deliberately unnumbered ----\n", s)
    old = t[s:end]
    ids_old = sorted(l.split('"')[1] for l in old.splitlines() if l.strip().startswith('"'))
    ids_new = sorted([c[0] for c in CANON] + [b[0] for b in BRANCH])
    assert ids_old == ids_new, (set(ids_old) ^ set(ids_new))
    labels = [c[1] for c in CANON] + [b[1] for b in BRANCH]
    assert len(labels) == len(set(labels)), "duplicate label"
    assert [int(c[1]) for c in CANON] == list(range(1, len(CANON) + 1))
    new = ("    # -- the canonical journey ------------------------------------\n"
           "    # Renumbered 2026-09-28 (ascii45) after Blocks E and F -- see\n"
           "    # Tool2\\build_ascii45_renumber.py for the measured order.\n"
           + "".join(row(*c) for c in CANON)
           + "    # -- branches, one level deep ---------------------------------\n"
           + "".join(row(*b) for b in BRANCH))
    e.replace(old, new, count=1, why="renumber: the table")

    e.replace(
        "        Write-Log -Message \"Start chosen at screen 21 (console checklist)\" -Status \"INFO\"\n",
        "        Write-Log -Message (\"Start chosen at screen \" + $script:GGScreenLabels[\"52\"] + \" (console checklist)\") -Status \"INFO\"\n",
        count=1, why="renumber: log line reads the table")
