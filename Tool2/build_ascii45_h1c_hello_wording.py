"""build_ascii45_h1c_hello_wording -- item 9's question, rewritten so a senior
can answer it by looking, not by knowing what a PIN is.

Dated: 2026-09-27 10:16 ET
Editor: Claude Code (CGDELL)

Bill, 2026-09-27: "Item 9 how will the senior know. I didn't know and still
don't know how to answer that question for CGDELL." The old question asked
"Do you sign in with a short PIN, your face or your fingerprint?" -- it relied
on the user knowing the difference between a PIN and a password.

MEASURED by Bill on CGDELL 2026-09-27 ~10:15: Windows key + L shows the Dad
account with "Enter PIN" and a "Sign-in options" link below it. So the check
is something the user SEES: lock the screen and read the box.

Run from Tool2/:  python build_ascii45_h1c_hello_wording.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

OLD = ("MANUAL CHECK -- Checkup cannot confirm this one. Do you sign in to Windows "
       "with a short PIN, your face or your fingerprint? If yes, you are set. If you "
       "type your full password, set up a PIN: Settings -> Accounts -> Sign-in options "
       "-> PIN (Windows Hello). See Guide: Phase 1, Step 4")
NEW = ("MANUAL CHECK -- Checkup cannot confirm this one, so please look: press the "
       "Windows key + L to lock the screen. If it says Enter PIN, or signs you in by "
       "your face or fingerprint, you are set -- sign back in as usual. If it asks "
       "for your password, sign back in, then set up a PIN: Settings -> Accounts -> "
       "Sign-in options -> PIN (Windows Hello). See Guide: Phase 1, Step 4")

with PS1Edit(TARGET) as e:
    e.replace(OLD, NEW, count=1, why="item 9: a question a senior can answer by looking")
    e.replace(
        "#           sourced Microsoft Learn 2026-09-27).\n",
        "#           sourced Microsoft Learn 2026-09-27).\n"
        "#           The question now says what to LOOK at (Win+L shows \"Enter PIN\" --\n"
        "#           measured by Bill on CGDELL 2026-09-27).\n",
        count=1, why="change log")
