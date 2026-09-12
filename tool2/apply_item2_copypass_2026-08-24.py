#!/usr/bin/env python3
# FILE:  apply_item2_copypass_2026-08-24.py
# Dated: 2026-08-24 00:15 ET
#
# Bill's HTML review, the copy pass he unblocked on 2026-08-23:
#   Item 2  -- OPTION 1. Every "Action taken" line becomes
#              "With your approval, Checkup will [do the thing]."
#              Where Windows forbids programmatic change, Bill's sentence:
#              "With your approval, Checkup will show you the exact steps
#               to do it yourself."
#   Item 3  -- heading "What Checkup found and did"
#              -> "What Checkup found and we recommend you do"
#   Item 9  -- fast-startup: drop "(recommended)"
#   Item 17 -- the tag line was never audited against CanAuto. Three pages
#              disagree with the build. Measured on
#              Tool\W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1
#              lines 5618-5636: ONLY ID 3 and ID 9 are CanAuto=$false.
#
# Every replacement is assert-guarded: the anchor must match exactly once,
# or nothing is written. CLAUDE.md Pre-Build Checklist item 2, applied to
# .html for the same reason it applies to .ps1 -- a silent miss is worse
# than a crash.

import re
import sys
from pathlib import Path

HTML = Path(__file__).resolve().parent.parent / "WebSite" / "html"

NBSP_DASH = "&#8212;"
APOS = "&#8217;"

# --- Item 2 ------------------------------------------------------------
# key = page stem, value = the new "Action taken" inner HTML.
# None means "already conforms to option 1, leave it alone".
ACTION_TAKEN = {
    "advertising-id":
        "With your approval, Checkup will turn off the Advertising ID. "
        f"You can turn it back on at any time {NBSP_DASH} the steps are below.",

    "bitlocker":
        "With your approval, Checkup will walk you through turning on "
        "encryption and saving your recovery key to at least two safe "
        "locations, asking before each step. This is one of the few "
        "settings where Checkup guides you step by step rather than "
        f"applying the change itself {NBSP_DASH} the recovery key is critical "
        "and must be saved before encryption begins.",

    "defender-realtime":
        "With your approval, Checkup will turn real-time protection back "
        "on if it was off and no other antivirus had taken its place.",

    # Bill's own model sentence, item 6. Already option 1.
    "diagnostic-data": None,

    "edge-startup":
        "With your approval, Checkup will turn off Edge Startup Boost and "
        f"background running. This is a convenience setting {NBSP_DASH} if you "
        "prefer Edge to open as fast as possible and do not mind it running "
        "in the background, you can turn it back on at any time.",

    "fast-startup":
        "With your approval, Checkup will turn off Fast Startup. Your PC "
        "will then do a proper full shutdown when you click Shut down. "
        "Startup will be a few seconds slower, but updates install "
        "completely and your PC starts in a fully clean state every time.",

    "firewall":
        "With your approval, Checkup will turn on any firewall profile "
        "that was off.",

    "memory-integrity":
        "With your approval, Checkup will turn on Memory Integrity, if it "
        "was off and your PC can support it. <strong>Memory Integrity does "
        "not start working until you restart your PC.</strong>",

    "password-manager":
        f"With your approval, Checkup will turn off Edge{APOS}s offer to save "
        "passwords. This does not delete any passwords already saved "
        f"{NBSP_DASH} it only stops Edge from offering to save new ones going "
        "forward.",

    # ID 17, CanAuto=$true. The old line called this "a manual setup",
    # which contradicted its own Found line one row above.
    "password-on-wake":
        "With your approval, Checkup will turn on the requirement to sign "
        "in when your PC wakes from sleep.",

    "periodic-scanning":
        "With your approval, Checkup will turn on periodic scanning if it "
        "was off and Malwarebytes was your primary antivirus.",

    # Bill's exact item 15 wording, already applied and already option 1.
    "phishing-protection": None,

    "remote-desktop":
        "With your approval, Checkup will turn Remote Desktop off if it "
        f"was on. If you use Remote Desktop intentionally {NBSP_DASH} for "
        f"example, to connect to your home PC from work {NBSP_DASH} you can "
        "leave it on.",

    "smartscreen":
        "With your approval, Checkup will turn on any SmartScreen setting "
        "that was off.",

    # ID 3, CanAuto=$false. Bill's manual sentence, keeping the "why"
    # from the override he ratified 2026-08-22.
    "tamper-protection":
        "With your approval, Checkup will show you the exact steps to do "
        "it yourself. Windows does not allow any program to change this "
        "one, so this is the one setting on this page you have to do by "
        f"hand {NBSP_DASH} the steps are below.",

    "wake-on-lan":
        "With your approval, Checkup will turn Wake on LAN off if it was "
        "on. Checkup explains what it does before asking.",

    "widgets":
        "With your approval, Checkup will turn off Windows Widgets. If you "
        "use and enjoy the Widgets panel, you can turn it back on at any "
        f"time {NBSP_DASH} the steps are below.",

    # ID 9, CanAuto=$false.
    "windows-hello":
        "With your approval, Checkup will show you the exact steps to do "
        "it yourself. Checkup cannot set up your PIN or fingerprint for "
        "you, because Windows requires you to confirm your identity as "
        "part of the process.",

    "windows-update":
        "With your approval, Checkup will turn automatic updates back on "
        "if they were disabled or set to manual only.",
}

PAGES = list(ACTION_TAKEN.keys())

ACTION_RE = re.compile(
    r'(Action taken:</span>\s*<span class="gg-did-value">)(.*?)(</span>)',
    re.DOTALL,
)

# --- Item 3 ------------------------------------------------------------
NEW_HEADING = "<h2>What Checkup found and we recommend you do</h2>"
OLD_HEADINGS = [
    "<h2>What Checkup found and did</h2>",
    "<h2>What GatewayGuard Checkup found and did</h2>",
]

# --- Item 17, the tag line vs CanAuto ----------------------------------
TAG_AUTO = '<span class="tag tag-auto">&#10003; Checkup can do this for you</span>'
TAG_MANUAL = '<span class="tag tag-manual">&#9998; You set this up</span>'
TAG_FIXES = {
    # CanAuto=$false -- must not promise Checkup can do it
    "tamper-protection": (TAG_AUTO, TAG_MANUAL),
    # CanAuto=$true -- understated as manual
    "password-on-wake": (TAG_MANUAL, TAG_AUTO),
    "remote-desktop": (TAG_MANUAL, TAG_AUTO),
}

# --- Item 9 ------------------------------------------------------------
LITERAL_FIXES = {
    "fast-startup": [
        ("<strong>Turn on fast startup (recommended)</strong>",
         "<strong>Turn on fast startup</strong>"),
    ],
}


def fail(msg):
    print(f"  FAIL: {msg}")
    sys.exit(1)


def main():
    changes = []
    for stem in PAGES:
        path = HTML / f"{stem}.html"
        if not path.is_file():
            fail(f"{path} does not exist")
        text = original = path.read_text(encoding="utf-8")
        did = []

        # Item 2
        new_value = ACTION_TAKEN[stem]
        if new_value is not None:
            matches = ACTION_RE.findall(text)
            if len(matches) != 1:
                fail(f"{stem}: expected 1 'Action taken' block, found {len(matches)}")
            text = ACTION_RE.sub(
                lambda m: m.group(1) + new_value + m.group(3), text, count=1
            )
            if text != original:
                did.append("item2")

        # Item 3
        hits = [h for h in OLD_HEADINGS if h in text]
        if len(hits) != 1:
            fail(f"{stem}: expected 1 old heading, found {len(hits)}")
        if text.count(hits[0]) != 1:
            fail(f"{stem}: heading {hits[0]!r} appears more than once")
        text = text.replace(hits[0], NEW_HEADING, 1)
        did.append("item3")

        # Item 17 -- tag vs CanAuto
        if stem in TAG_FIXES:
            old_tag, new_tag = TAG_FIXES[stem]
            if text.count(old_tag) != 1:
                fail(f"{stem}: expected 1 {old_tag!r}, found {text.count(old_tag)}")
            text = text.replace(old_tag, new_tag, 1)
            did.append("item17-tag")

        # Item 9 and any other literal fixes
        for old, new in LITERAL_FIXES.get(stem, []):
            if text.count(old) != 1:
                fail(f"{stem}: expected 1 {old!r}, found {text.count(old)}")
            text = text.replace(old, new, 1)
            did.append("item9")

        if text == original:
            print(f"  {stem:<22} unchanged")
            continue
        path.write_text(text, encoding="utf-8", newline="")
        changes.append(stem)
        print(f"  {stem:<22} {', '.join(did)}")

    print(f"\n  {len(changes)} of {len(PAGES)} pages rewritten.")


if __name__ == "__main__":
    print("\n  ITEM 2 COPY PASS -- option 1, all 19 pages\n")
    main()
