"""build_ascii44_backkey -- B is the only Back key.

Bill, 2026-08-30: "N always means no and B should always be used to say back."
And, at screen 27: "Don't use N to go back use B, Change everywhere it is
needed."

The ascii43 field checklist demanded "B is the ONLY Back key, N must never
take you back". FT-236 had recorded that demand as a defect in the CHECKLIST.
The checklist was right; FT-236 is withdrawn on its premise and the build
moves.

MEASURED, ascii43: N carried three meanings across 30 of the 47 Read-ValidKey
sites -- No at 12, Back at 7, Exit at 11. A user cannot predict what N does
before pressing it, which is a head-on breach of the User-Facing Clarity Rule.

WHAT CHANGES HERE, AND WHY IT IS FIVE AND NOT SEVEN
---------------------------------------------------
The operative half of Bill's ruling is "N MUST NEVER TAKE YOU BACK." So the
test applied to each of the seven sites was: does pressing N actually navigate
backward? Five do, and those become B. Two do not:

  6672  "Still correct? (Y = yes, continue / N = no, ask me again)"
        N does not navigate. It discards a saved answer and re-asks the
        question on the next screen. The label already says exactly that, it
        contains no "go back", and a reader can predict it. NOT CHANGED --
        relabelling an honest "no" would make it worse, and adding a B here
        would need a Back destination that does not exist in this flow.

  8086  "Have you set Sleep and Display to Never manually?"
        N does NOT go back. It prints the manual steps, logs a SKIP, and
        leaves the BitLocker flow -- the user has to run Checkup again. But
        the label SAID "N = No, go back", so the user pressed N expecting the
        previous screen and got the end of the run. LABEL FIXED, key kept:
        this is a real question and its honest answer is no.

The other five are navigation, not questions, and they get B.

THE MODEL WAS ALREADY IN THE BUILD -- the single site of 47 that offered B:
    @("Y","N","B") / "Choice (Y = Re-apply / N = Skip / B = Back): "

THE 11 N = EXIT SITES DO NOT MOVE. Bill asked for X = Exit at screens 14a and
18, and that is not decided. Changing two of N's three meanings in one build
is how the confusion comes back wearing a different letter. One key at a time,
field-run between.

Run from Tool2/:  python build_ascii44_backkey.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

with PS1Edit(TARGET) as e:

    # -- 1. Close Checkup? (resume re-check) --------------------------------
    # Box line: N -> B is one character for one, so the box width is unchanged
    # and FT-117/FT-122 are not re-earned.
    e.replace(
        '"  Press N to go back -- it IS your computer and you want    ",',
        '"  Press B to go back -- it IS your computer and you want    ",',
        count=1,
        why="Back key 1/5: screen text, resume re-check",
    )
    e.replace(
        'Read-ValidKey -ValidKeys @("Y","N") -Prompt "Close Checkup? (Y = close / N = go back): "',
        'Read-ValidKey -ValidKeys @("Y","B") -Prompt "Close Checkup? (Y = close / B = go back): "',
        count=1,
        why="Back key 1/5: resume re-check -- N navigated backward, now B",
    )

    # -- 2. checklist: security-critical items deselected --------------------
    e.replace(
        'Write-Host "  N = Go back and review my selections" -ForegroundColor White',
        'Write-Host "  B = Go back and review my selections" -ForegroundColor White',
        count=1,
        why="Back key 2/5: screen text, critical-deselected review",
    )
    e.replace(
        'Read-ValidKey -ValidKeys @("Y","N","S") -Prompt "Your choice (Y = Continue / N = Go back / S = Show me each item): "',
        'Read-ValidKey -ValidKeys @("Y","B","S") -Prompt "Your choice (Y = Continue / B = Go back / S = Show me each item): "',
        count=1,
        why="Back key 2/5: critical-deselected review -- N navigated backward, now B",
    )
    e.replace(
        'return $false   # N = go back and review selections',
        'return $false   # B = go back and review selections',
        count=1,
        why="Back key 2/5: comment follows the key",
    )

    # -- 3. Continue WITHOUT encryption? -------------------------------------
    e.replace(
        'Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue WITHOUT encryption? (Y = Yes, continue / N = Go back and select it): "',
        'Read-ValidKey -ValidKeys @("Y","B") -Prompt "Continue WITHOUT encryption? (Y = Yes, continue / B = Go back and select it): "',
        count=1,
        why="Back key 3/5: encryption decline -- N returned GoBack, now B",
    )
    e.replace(
        'if ($fd.ToUpper() -eq "N") { return "GoBack" }',
        'if ($fd.ToUpper() -eq "B") { return "GoBack" }',
        count=1,
        why="Back key 3/5: branch follows the key",
    )

    # -- 4. BitLocker decline heads-up ---------------------------------------
    e.replace(
        'Write-Host "  N = Go back and select encryption" -ForegroundColor White',
        'Write-Host "  B = Go back and select encryption" -ForegroundColor White',
        count=1,
        why="Back key 4/5: screen text, BitLocker decline",
    )
    e.replace(
        'Read-ValidKey -ValidKeys @("Y","N","S") -Prompt "Your choice (Y = Continue / N = Go back / S = Show me): "',
        'Read-ValidKey -ValidKeys @("Y","B","S") -Prompt "Your choice (Y = Continue / B = Go back / S = Show me): "',
        count=1,
        why="Back key 4/5: BitLocker decline -- N returned GoBack, now B",
    )
    e.replace(
        'if ($bd.ToUpper() -eq "N") { return "GoBack" }',
        'if ($bd.ToUpper() -eq "B") { return "GoBack" }',
        count=1,
        why="Back key 4/5: branch follows the key",
    )

    # -- 5. Ready to proceed? -- SCREEN 27, THE ONE BILL HIT ------------------
    e.replace(
        'Read-ValidKey -ValidKeys @("Y","N","Q") -Prompt "Ready to proceed? (Y = Start / N = Go back / Q = Quit): "',
        'Read-ValidKey -ValidKeys @("Y","B","Q") -Prompt "Ready to proceed? (Y = Start / B = Go back / Q = Quit): "',
        count=1,
        why="Back key 5/5: screen 27, the prompt Bill hit -- N navigated backward, now B",
    )
    e.replace(
        '                        "N" { continue checklistLoop }',
        '                        "B" { continue checklistLoop }',
        count=1,
        why="Back key 5/5: branch follows the key",
    )

    # -- 6. label fix: N here is a real "no", and never went back -------------
    e.replace(
        '-Prompt "Have you set Sleep and Display to Never manually? (Y = Yes, continue / N = No, go back): "',
        '-Prompt "Have you set Sleep and Display to Never manually? (Y = Yes, continue / N = No, not yet): "',
        count=1,
        why='Label fix: N here does NOT go back -- it leaves the flow with the '
            'manual steps. The label promised the previous screen.',
    )

    # -- header change record -------------------------------------------------
    e.replace(
        "# CHANGES FROM ascii39 (2026-08-15 -- ASCII40: THE THREE FIELD BLOCKERS):",
        "#   BACK KEY: B IS NOW THE ONLY BACK KEY. Bill, 2026-08-30: \"N always\n"
        "#           means no and B should always be used to say back.\" Measured\n"
        "#           on ascii43, N meant three different things across 30 of the\n"
        "#           47 Read-ValidKey sites -- No at 12, Back at 7, Exit at 11 --\n"
        "#           so nobody could predict it. Five sites where N actually\n"
        "#           navigated backward are now B: the resume re-check, the\n"
        "#           critical-deselected review, the encryption decline, the\n"
        "#           BitLocker decline, and screen 27's \"Ready to proceed?\",\n"
        "#           which is the one Bill hit.\n"
        "#           NOT changed: \"Still correct?\", where N already means no and\n"
        "#           navigates nowhere. Label fixed at the Sleep/Display question,\n"
        "#           where N said \"go back\" but actually left the flow.\n"
        "#           THE 11 N = EXIT SITES ARE UNTOUCHED -- X = Exit is not\n"
        "#           decided, and changing two of N's three meanings at once is\n"
        "#           how the confusion returns wearing a different letter.\n"
        "#\n"
        "# CHANGES FROM ascii39 (2026-08-15 -- ASCII40: THE THREE FIELD BLOCKERS):",
        count=1,
        why="Back key: header change record",
    )
