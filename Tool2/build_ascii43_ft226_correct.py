"""build_ascii43_ft226_correct -- undo the wrong FT-226 fix.

Cloud's correction (new guide draft section 0.3) is right on both halves:
  1. Setting 17 already HAD a GuideRef ("Keep vs. Disable Table") in
     ascii40-43 -- it was never missing.
  2. The real defect is a CLASS: settings 10, 11, 12, 17, 18, 19 all point at
     "Keep vs. Disable Table" -- a table name, not a locatable page. Fixing 17
     alone leaves five live.

My earlier fix set 17 to "Phase 1, Step 4". That is worse, not better:
  - it broke consistency with the other five, and
  - the NEW draft (2026-08-22-1000) moves setting 17 to PHASE 4, so "Phase 1,
    Step 4" now points at the wrong place.

Restore 17 to the class value so all six are consistent again. The class fix --
setting all six to real destinations -- is deferred until the guide structure
is LOCKED, because it is still moving (17 jumped Step 4 -> Phase 4 between
drafts; setting 10 has no dedicated section yet). Setting the refs against an
unapproved, gap-ridden draft would just have to be redone.

Run from the Tool/ directory:  python build_ascii43_ft226_correct.py
"""
from gg_edit import PS1Edit

TARGET = r"W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        'Name="Password Required on Wake";         Description="Requires password when PC wakes from sleep. Prevents unlocked screen access.";          GuideRef="Phase 1, Step 4";',
        'Name="Password Required on Wake";         Description="Requires password when PC wakes from sleep. Prevents unlocked screen access.";          GuideRef="Keep vs. Disable Table";',
        count=1,
        why="FT-226 correction (Cloud): restore setting 17 to the class value; class fix waits for guide lock",
    )
