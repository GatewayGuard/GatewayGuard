"""build_ascii41_ft172 -- FT-172: the screen number becomes a property of the
SCREEN instead of a property of the RUN.

Dated: 2026-08-17 23:40 ET
Editor: Claude Code (CGDELL)

Approved by Bill 2026-08-17 ("172 is approved"), with all five design
questions closed. Design: GatewayGuard_ScreenNumberDesign-2026-08-15-1430.md.
Table and call-flow walk: GatewayGuard_ScreenNumberTable-2026-08-17.md.

WHAT WAS ACTUALLY WRONG
-----------------------
Not what the field test plan first said. There are three causes, and the one
that matters is that Get-ScreenNumber COUNTED AT RUNTIME, in encounter order.
The number was a property of the run, so two users got different numbers for
the same screen -- which is the whole of Bill's finding 35, "so when a user
refers to it we know exactly which screen he is talking about."

  1. runtime counting            -> replaced by a static table
  2. three screens never reached Draw-Box, so the counter never saw them and
     everything after read LOW BY A CONSTANT
                                 -> they get IDs 85/86/87 and read the table
  3. six numbers typed by hand into visible text, which cannot agree with a
     counted number except by luck
                                 -> deleted; the table is the only source

THE SCHEME
----------
Integers for the canonical journey -- a first run, Console mode, Home, nothing
skipped. Letters for departures from it, ONE LEVEL DEEP (Bill, 2026-08-17:
no 8a1). The BitLocker end block takes integers (Bill, 2026-08-17: "use
integers for the end block"). Revisits re-show their own number and are exempt
-- only FIRST encounters must ascend (Bill, 2026-08-15).

ALSO CLOSED HERE: Bill's ascii40 finding 4, "No 2 of 2". The yellow banner
promised "STEP 1 OF 2" and no STEP 2 OF 2 exists anywhere in the build. The
false promise is removed rather than a second step invented.
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from gg_edit import PS1Edit, EditError  # noqa: E402

TARGET = Path(__file__).parent / "W11-SecurityHardening-v3-ascii41-2026-08-17-2246.ps1"

# --------------------------------------------------------------------------
# THE TABLE. Order here is viewing order, which is what makes it readable and
# what makes a decrease visible to a human reviewer.
# --------------------------------------------------------------------------
MAIN = [
    ("85", "1",  "Welcome / maximize"),
    ("86", "2",  "Scrolling"),
    ("87", "3",  "Set your console font"),
    ("28", "4",  "FONT CHECK"),
    ("29", "5",  "Before you start -- your window"),
    ("78", "6",  "Before you start -- your keyboard"),
    ("30", "7",  "What happens next"),
    ("02", "8",  "How to scroll back and copy"),
    ("05", "9",  "Important -- read before continuing"),
    ("34", "10", "Windows edition detected"),
    ("35", "11", "Your PC -- RAM"),
    ("09", "12", "Your system at a glance"),
    ("26", "13", "Your PC's security tools"),
    ("27", "14", "The scans we recommend"),
    ("10", "15", "Pre-scan prep checklist"),
    ("38", "16", "Defender offline scan"),
    ("43", "17", "Antivirus status -- healthy setup"),
    ("73", "18", "Malwarebytes detected"),
    ("50", "19", "Power settings -- security review"),
    ("51", "20", "Apps audit results"),
    ("52", "21", "Mode selector"),
    ("53", "22", "Quick question -- your passwords"),
    ("54", "23", "What Checkup does and does not do (1 of 2)"),
    ("75", "24", "What Checkup does and does not do (2 of 2)"),
    ("76", "25", "The security checklist, page 1"),
    ("77", "26", "The security checklist, page 2"),
    ("55", "27", "Review your selections"),
    ("61", "28", "Final item: device encryption"),
    ("62", "29", "Your PC meets the requirements"),
    ("79", "30", "Before you turn it on -- your recovery key"),
    ("81", "31", "How to tell if encryption is running"),
    ("69", "32", "All selected items processed"),
    ("70", "33", "Automated scan schedule setup"),
    ("72", "34", "Automated steps complete"),
]

BRANCH = [
    ("25", "1a",  "Welcome back -- a checkpoint exists"),
    ("31", "1b",  "Quick re-check before resuming"),
    ("83", "1c",  "Are you sure you want to close Checkup?"),
    ("01", "3a",  "Not administrator -- how to run Checkup correctly"),
    ("32", "9a",  "Domain-joined warning"),
    ("33", "9b",  "Administrator access required"),
    ("36", "11a", "Time and date -- check"),
    ("37", "11b", "Time and date -- out of sync"),
    ("39", "14a", "Reminder: pre-scan recommended (repeat run)"),
    ("40", "14b", "Welcome back -- offline scan complete"),
    ("41", "17a", "Antivirus -- alternative state"),
    ("42", "17b", "Antivirus -- alternative state"),
    ("44", "17c", "Antivirus -- alternative state"),
    ("45", "17d", "Antivirus -- alternative state"),
    ("46", "17e", "Antivirus -- alternative state"),
    ("13", "18a", "Malwarebytes -- alternative state"),
    ("47", "18b", "Malwarebytes -- alternative state"),
    ("48", "18c", "Malwarebytes -- alternative state"),
    ("49", "18d", "Power / battery warning"),
    ("74", "22a", "Your passwords -- we remembered your answer"),
    ("56", "25a", "Non-recommended selections"),
    ("57", "25b", "Non-recommended -- confirm"),
    ("58", "25c", "Heads up -- skipping encryption"),
    ("60", "25d", "Why encrypt?"),
    ("68", "25e", "Encryption declined"),
    ("59", "27a", "Applying your changes"),
    ("64", "27b", "BitLocker (Windows 11 Pro)"),
    ("65", "27c", "BitLocker -- what will happen (Pro)"),
    ("66", "27d", "BitLocker -- confirm (Pro)"),
    ("67", "27e", "BitLocker enabled (Pro)"),
    ("63", "28a", "Device encryption may not be available on this PC"),
    ("82", "30a", "Already signed in with a Microsoft account"),
    ("80", "30b", "How to sign in with a Microsoft account"),
    ("23", "33a", "Convenience review"),
    ("71", "33b", "Convenience review -- result"),
]

# Reachable from EVERY prompt, so it hangs off no integer and takes no number.
# Its title already says what it is, and a number would have to be either a
# duplicate or a lie about where the user is.
UNNUMBERED = [("84", "", "About this Checkup run (the I key)")]

ALL = MAIN + BRANCH + UNNUMBERED


def build_table_ps() -> str:
    """Emit the PowerShell hashtable, aligned, with the viewing order intact."""
    out = [
        "# ============================================================",
        "# FT-172 (ascii41): THE SCREEN NUMBER TABLE.",
        "#",
        "# Before this, Get-ScreenNumber COUNTED AT RUNTIME in encounter order,",
        "# so the number was a property of THE RUN and not of THE SCREEN. Two",
        "# users got different numbers for the same screen. That is Bill's",
        "# finding 35: \"so when a user refers to it we know exactly which screen",
        "# he is talking about.\"",
        "#",
        "# THE SCHEME, approved by Bill 2026-08-17:",
        "#   * Integers  = the canonical journey. A first run, Console mode,",
        "#                 Home edition, nothing skipped.",
        "#   * Letters   = a departure from it. ONE LEVEL ONLY -- there is no",
        "#                 8a1. A branch inside a branch takes the next letter.",
        "#   * Revisits are exempt. Only FIRST encounters must ascend, so the",
        "#                 checklist hub keeps its own number however often the",
        "#                 user returns to it.",
        "#   * A screen reachable from everywhere (the I screen) takes NO",
        "#                 number, because any number would be a lie about",
        "#                 where the user is.",
        "#",
        "# THE ORDER BELOW IS VIEWING ORDER, not ID order and not source order.",
        "# It is written that way so a human reviewer can see a decrease. The",
        "# call-flow walk that produced it, and the proof that no user ever meets",
        "# a first-encounter decrease, are in",
        "# ProjectDocs\\GatewayGuard_ScreenNumberTable-2026-08-17.md.",
        "#",
        "# ADDING A SCREEN: give it an ID, put it in this table in the position",
        "# the user reaches it, and renumber. Do NOT type a number into screen",
        "# text -- that is cause 3 of this defect and it is now gone.",
        "# ============================================================",
        "$script:GGScreenLabels = @{",
        "    # -- the canonical journey ------------------------------------",
    ]
    for sid, label, note in MAIN:
        out.append(f'    "{sid}" = "{label}"'.ljust(24) + f"  # {note}")
    out.append("    # -- branches, one level deep ---------------------------------")
    for sid, label, note in BRANCH:
        out.append(f'    "{sid}" = "{label}"'.ljust(24) + f"  # {note}")
    out.append("    # -- reachable from everywhere, so deliberately unnumbered ----")
    for sid, label, note in UNNUMBERED:
        out.append(f'    "{sid}" = "{label}"'.ljust(24) + f"  # {note}")
    out.append("}")
    return "\n".join(out)


def pad(s: str, width: int) -> str:
    if len(s) > width:
        raise EditError(f"line too long: {len(s)} > {width}\n  {s!r}")
    return s + " " * (width - len(s))


def main() -> int:
    # --- table self-checks. A table that fails these is worse than none. ---
    ids = [s for s, _, _ in ALL]
    if len(ids) != len(set(ids)):
        dupes = sorted({i for i in ids if ids.count(i) > 1})
        raise EditError(f"TABLE HAS DUPLICATE IDs: {dupes}")
    labels = [l for _, l, _ in ALL if l]
    if len(labels) != len(set(labels)):
        dupes = sorted({l for l in labels if labels.count(l) > 1})
        raise EditError(f"TABLE HAS DUPLICATE LABELS -- breaches rule 1: {dupes}")
    seq = [int(l) for _, l, _ in MAIN]
    if seq != list(range(1, len(MAIN) + 1)):
        raise EditError(f"MAIN LINE IS NOT 1..N GAPLESS: {seq}")
    for sid, label, _ in BRANCH:
        anchor = label.rstrip("abcdefghijklmnopqrstuvwxyz")
        if anchor not in [l for _, l, _ in MAIN]:
            raise EditError(f"BRANCH {label} (id {sid}) hangs off {anchor}, which is not a main-line number")
        if not label[len(anchor):].isalpha() or len(label) - len(anchor) != 1:
            raise EditError(f"BRANCH {label} is not one level deep -- Bill, 2026-08-17: no 8a1")
    print(f"  [table] {len(MAIN)} integers 1..{len(MAIN)}, {len(BRANCH)} branches, "
          f"{len(UNNUMBERED)} unnumbered -- no duplicates, main line gapless")

    text = TARGET.read_text(encoding="utf-8-sig").replace("\r\n", "\n")
    src = text.split("\n")

    def block(first, last):
        return "\n".join(src[first - 1:last])

    A_COUNTER = block(1744, 1755)     # $GGScreenNo .. end of Get-ScreenNumber
    A_STEP12 = None
    for i, ln in enumerate(src, 1):
        if "STEP 1 OF 2" in ln:
            A_STEP12 = ln
            break
    if A_STEP12 is None:
        raise EditError("could not find the STEP 1 OF 2 banner")

    for blk, needle in ((A_COUNTER, "GGScreenSeen"),):
        if needle not in blk:
            raise EditError(f"anchor is not what it claims: {needle!r}")

    with PS1Edit(TARGET) as e:

        # -- 1. the table replaces the runtime counter ----------------------
        e.replace(
            A_COUNTER,
            build_table_ps() + "\n\n"
            "# Counts DISTINCT screens shown this run. Not the displayed number --\n"
            "# that comes from the table above. Kept because the look-back snapshot\n"
            "# uses it as an ordinal.\n"
            "$script:GGScreenNo   = 0\n"
            "$script:GGScreenSeen = @{}\n"
            "\n"
            "function Get-ScreenNumber {\n"
            "    param([string]$ScreenId)\n"
            "    if (-not $ScreenId) { return \"\" }\n"
            "    if (-not $script:GGScreenSeen.ContainsKey($ScreenId)) {\n"
            "        $script:GGScreenNo++\n"
            "        $script:GGScreenSeen[$ScreenId] = $true\n"
            "    }\n"
            "    # A screen missing from the table shows NO number rather than a\n"
            "    # wrong one. Gate 12 fails the build for it, which is where that\n"
            "    # belongs -- the user should never be the one who finds out.\n"
            "    if ($script:GGScreenLabels.ContainsKey($ScreenId)) {\n"
            "        return $script:GGScreenLabels[$ScreenId]\n"
            "    }\n"
            "    return \"\"\n"
            "}",
            count=1, why="FT-172: static table replaces the runtime counter")

        # -- 2. the box tag takes a label, not an int ----------------------
        e.replace("        [int]$Number = 0,", "        [string]$Number = \"\",",
                  count=1, why="FT-172: screen label is a string (16c, 25a)")
        e.replace("    if ($Number -gt 0) {", "    if ($Number) {",
                  count=1, why="FT-172: empty label means no tag")
        e.replace(
            "    Write-GGBox -Lines $Lines -Color $Color -TextColor $TextColor -Number 0",
            "    Write-GGBox -Lines $Lines -Color $Color -TextColor $TextColor -Number \"\"",
            count=1, why="FT-172: gallery box unnumbered")
        e.replace("    $ggNum = 0\n", "    $ggNum = \"\"\n",
                  count=1, why="FT-172: Draw-Box default label")

        # -- 3. the three screens the counter could never see --------------
        e.replace(
            '            Write-Host "  Welcome to GatewayGuard Checkup.  (Screen 1 of 6)" -ForegroundColor Cyan',
            '            # FT-172 (ascii41): this screen and the two below never reached\n'
            '            # Draw-Box, so the counter had never seen them and EVERY screen\n'
            '            # after them read low by a constant. That is the arithmetic Bill\n'
            '            # reported five separate times in ascii39 -- "Scr 3 -> 4 of 6",\n'
            '            # "Scr 4 -> 5 of 6", "Scr 5 = 5 of 6" -- one defect, not five.\n'
            '            # They now carry IDs and read the same table as everything else.\n'
            '            Write-Host ("  Welcome to GatewayGuard Checkup.  (Screen " + (Get-ScreenNumber -ScreenId "85") + ")") -ForegroundColor Cyan',
            count=1, why="FT-172: intro screen 1 reads the table")
        e.replace(
            '            Write-Host "  SCROLLING  (Screen 2 of 6)" -ForegroundColor Cyan',
            '            Write-Host ("  SCROLLING  (Screen " + (Get-ScreenNumber -ScreenId "86") + ")") -ForegroundColor Cyan',
            count=1, why="FT-172: intro screen 2 reads the table")
        e.replace(
            '            Write-Host "  (Screen 3 of 6)" -ForegroundColor DarkGray',
            '            Write-Host ("  (Screen " + (Get-ScreenNumber -ScreenId "87") + ")") -ForegroundColor DarkGray',
            count=1, why="FT-172: intro screen 3 reads the table")

        # -- 4. the typed numbers in box titles ----------------------------
        # Draw-Box already stamps the number into the border, so these were a
        # SECOND number on the same screen, disagreeing with the first.
        for old_txt, new_txt, why in (
            ("  BEFORE YOU START -- YOUR WINDOW  (Screen 4 of 6)",
             "  BEFORE YOU START -- YOUR WINDOW", "29"),
            ("  BEFORE YOU START -- YOUR KEYBOARD  (Screen 5 of 6)",
             "  BEFORE YOU START -- YOUR KEYBOARD", "78"),
            ("  WHAT HAPPENS NEXT -- PLEASE READ  (Screen 6 of 6)",
             "  WHAT HAPPENS NEXT -- PLEASE READ", "30"),
        ):
            hit = [ln for ln in e.text.split("\n") if old_txt in ln]
            if len(hit) != 1:
                raise EditError(f"expected 1 line containing {old_txt!r}, found {len(hit)}")
            line = hit[0]
            width = len(line) - len('        "') - len('",')
            e.replace(line, '        "' + pad(new_txt, width) + '",',
                      count=1, why=f"FT-172: SCREEN-{why} drops its typed number")

        # -- 5. the orphaned STEP 1 OF 2 (Bill's finding 4, "No 2 of 2") ---
        inner = A_STEP12.split('"')[1]
        w = len(inner)
        e.replace(
            A_STEP12,
            A_STEP12.replace(
                inner,
                pad("  |  SET YOUR CONSOLE FONT (takes 30 seconds)" +
                    " " * max(0, w - 46 - 1) + "|", w)[:w - 1] + "|"),
            count=1, why="FT-172 / finding 4: STEP 1 OF 2 had no step 2")

        # -- 6. the checklist logs the number it shows ---------------------
        e.replace(
            '        Write-Log -Message ("[SCREEN-" + $(if ($script:ChecklistPage -eq 1) { "76" } else { "77" }) + "] Checklist render: page ',
            '        # FT-172 (ascii41): the checklist logged NO position, so the log\n'
            '        # jumped 21 -> 23 while the user was looking at a header bar that\n'
            '        # said 22. Bill called it "screen 22" in his ascii40 findings and\n'
            '        # the log support would read had no such screen. It logs it now.\n'
            '        Write-Log -Message ("[SCREEN-" + $(if ($script:ChecklistPage -eq 1) { "76" } else { "77" }) + "] (shown as screen " + (Get-ScreenNumber -ScreenId $(if ($script:ChecklistPage -eq 1) { "76" } else { "77" })) + ") Checklist render: page ',
            count=1, why="FT-172: the checklist logs its own number")

        e.commit()

    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except EditError as exc:
        print(f"\nABORTED: {exc}", file=sys.stderr)
        sys.exit(1)
