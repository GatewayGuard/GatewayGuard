"""build_ascii43_f6_ft226 -- F6: FT-226 setting 17 gets a real guide reference.

Setting 17 (Password Required on Wake) carried GuideRef="Keep vs. Disable Table"
-- a vague section name, not a locatable reference like its neighbours. The guide
covers it under "Step 4 -- Your account and sign-in" ("Sign-in options -- settings
9 and 17"), and setting 9's tool GuideRef is "Phase 1, Step 4". Setting 17 is on
the same sign-in-options screen, so its reference is the same. Verified against
the guide draft, not guessed.

The explanation half of FT-226/FT-220 waits for the guide rewrite (ascii44); this
is the data fix the build plan said does not wait.

Run from the Tool/ directory:  python build_ascii43_f6_ft226.py
"""
from gg_edit import PS1Edit

TARGET = r"W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        'Name="Password Required on Wake";         Description="Requires password when PC wakes from sleep. Prevents unlocked screen access.";          GuideRef="Keep vs. Disable Table";',
        'Name="Password Required on Wake";         Description="Requires password when PC wakes from sleep. Prevents unlocked screen access.";          GuideRef="Phase 1, Step 4";',
        count=1,
        why="FT-226: setting 17 GuideRef -> Phase 1, Step 4 (where the guide actually covers it, with setting 9)",
    )
