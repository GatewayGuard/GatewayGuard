"""build_ascii45_h1d_enter_your_pin -- item 9's question uses the lock
screen's exact words.

Dated: 2026-09-30 14:31 ET
Editor: Claude Code (CGDELL)

MEASURED from Bill's phone photo of CGDELL's lock screen, 2026-09-30 (Win+L):
the heading reads "Enter your PIN", the box reads "PIN", below it
"Sign-in options" with a key and a keypad symbol. There is no "I forgot my
PIN" link on that screen. Item 9 said "If it says Enter PIN" -- close, but
the rule is the literal on-screen label.

Run from Tool2/:  python build_ascii45_h1d_enter_your_pin.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace("If it says Enter PIN, or signs you in by your face or fingerprint,",
              "If it says Enter your PIN, or signs you in by your face or fingerprint,",
              count=1, why="item 9: exact lock-screen words (Bill's photo, 2026-09-30)")
