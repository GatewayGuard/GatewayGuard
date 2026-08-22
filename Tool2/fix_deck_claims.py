"""fix_deck_claims -- bring the family presentation into line with the
2026-08-15 Marketing Plan's approved/banned claim table.

Dated: 2026-08-19 10:15 ET
Editor: Claude Code (CGDELL)

Bill, 2026-08-19: "fix the deck notes".

SCOPE CORRECTION: I reported the conflicts as "all in the speaker notes".
That was wrong -- slides 6 and 8 carry the same claims in VISIBLE text, which
is the half the audience actually reads. Bill asked for notes because my report
said notes. Both are fixed here.

WHAT IS BEING REMOVED, AND UNDER WHICH RULE

  MarketingPlan section 2, banned claims:
    "Any superlative -- best, safest, most secure"          -> PL-4
    "Do not claim to be the only tool doing this"           -> PL-4, not verifiable
    "Human-backed, or assisted sessions AS AVAILABLE"       -> roadmap only
    Website says "No subscription -- ever"                  -> deck said "subscriptions"

  1. notesSlide5  "zero tools that do what GatewayGuard does" -- unverifiable,
     and it names NoID, which contradicts notesSlide8's own claim of
     "No named competitors". That contradiction is INSIDE the deck.
  2. notesSlide6  "Annual update subscriptions" -- the site says the opposite.
  3. notesSlide6  "No competitor offers that last one at any price."
  4. slide6       "No competitor offers this."  -- on screen, in front of people.
  5. slide8       "no one else has this planned." -- on screen.

WHAT IS DELIBERATELY LEFT ALONE

  slide5 "Assisted sessions planned" is ACCURATE. The plan bans describing them
  as AVAILABLE, not as planned, and a roadmap item on a business-model slide in
  a family deck is legitimate. Removing honest roadmap language would be
  over-correction.

  notesSlide8 "No named competitors" is left because fix 1 makes it TRUE. It
  was false only while NoID was named two slides earlier.

HOW: a .pptx is an OPC zip. Every target phrase was verified to sit inside a
single <a:t> run before writing this, so no phrase spans a run boundary and no
XML structure is touched. Each replacement asserts its count, the archive is
rebuilt entry by entry, and the result is re-opened and re-verified.
"""

from __future__ import annotations

import shutil
import sys
import zipfile
from pathlib import Path

DECK = Path(__file__).parent.parent / "ProjectDocs" / "Presentation" / \
    "GatewayGuard_FamilyPresentation_v3-2026-07-03.pptx"

# part -> list of (old, new, why)
EDITS = {
    "ppt/notesSlides/notesSlide5.xml": [
        ("And zero tools that do what GatewayGuard does for home users.",
         "GatewayGuard is aimed at the person who owns the PC rather than at a sysadmin.",
         "PL-4: 'zero tools that do what we do' is not verifiable"),
        ("NoID charges $43 per device with no explanations.",
         "Comparable tools cost more and explain less.",
         "names a competitor, contradicting notesSlide8's 'No named competitors'"),
    ],
    "ppt/notesSlides/notesSlide6.xml": [
        ("Annual update subscriptions for recurring revenue.",
         "Optional annual updates at $12.99 a year -- optional, so not a subscription.",
         "the website says 'No subscription -- ever'; the deck said the opposite"),
        ("No competitor offers that last one at any price.",
         "Assisted sessions are on the roadmap and are not available today.",
         "PL-4 superlative, and assisted sessions must not be described as available"),
    ],
    "ppt/slides/slide6.xml": [
        ("No competitor offers this.",
         "Written for the person who owns the PC.",
         "PL-4: on-screen, unverifiable"),
    ],
    "ppt/slides/slide8.xml": [
        ("no one else has this planned.",
         "they are not available today.",
         "PL-4: on-screen, unverifiable, and softens a roadmap item correctly"),
    ],
}


def main() -> int:
    if not DECK.exists():
        print(f"  NOT FOUND: {DECK}")
        return 1

    backup = DECK.with_suffix(".pptx.bak")
    shutil.copy2(DECK, backup)
    print(f"  [backup] {backup.name}")

    src = zipfile.ZipFile(DECK)
    parts = {n: src.read(n) for n in src.namelist()}
    infos = {i.filename: i for i in src.infolist()}
    src.close()

    total = 0
    for part, edits in EDITS.items():
        if part not in parts:
            print(f"  ABORT: {part} not in the deck")
            return 1
        text = parts[part].decode("utf-8")
        for old, new, why in edits:
            n = text.count(old)
            if n != 1:
                print(f"  ABORT: {part}\n    expected 1 x {old!r}, found {n}")
                print("    Nothing written. The deck is unchanged.")
                return 1
            text = text.replace(old, new, 1)
            print(f"  [edit ] {part.split('/')[-1]:22} {why}")
            total += 1
        parts[part] = text.encode("utf-8")

    tmp = DECK.with_suffix(".pptx.tmp")
    with zipfile.ZipFile(tmp, "w", zipfile.ZIP_DEFLATED) as out:
        for name in [i.filename for i in zipfile.ZipFile(backup).infolist()]:
            out.writestr(infos[name], parts[name])

    # Re-open and prove the old text is gone and the new text is present.
    check = zipfile.ZipFile(tmp)
    for part, edits in EDITS.items():
        t = check.read(part).decode("utf-8")
        for old, new, _ in edits:
            if old in t:
                print(f"  ABORT: old text survived in {part}: {old!r}")
                return 1
            if new not in t:
                print(f"  ABORT: new text missing in {part}: {new!r}")
                return 1
    n_parts = len(check.namelist())
    check.close()

    if n_parts != len(parts):
        print(f"  ABORT: part count changed {len(parts)} -> {n_parts}")
        return 1

    tmp.replace(DECK)
    print(f"  [verify] {n_parts} parts intact, all {total} replacements confirmed")
    print(f"  [write ] {DECK.name} -- {DECK.stat().st_size:,} bytes")
    print(f"  [undo  ] restore {backup.name} over it")
    return 0


if __name__ == "__main__":
    sys.exit(main())
