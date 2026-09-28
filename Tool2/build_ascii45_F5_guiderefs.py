"""build_ascii45_F5_guiderefs -- Block F, F5 (Decision 8 as amended by Cloud):
every guide reference names the SETTING NUMBER, or a guide Part and section.

Dated: 2026-09-28 08:28 ET (commit time; the 08:50 first typed here was not read off a clock)
Editor: Claude Code (CGDELL)

Five print sizes mean no page number can be right, and "Phase 1, Step 6,
Part D" is the old guide's structure -- the guide is now Parts 1-5 with
Settings 1-19 (measured: GatewayGuard_GuideDraft-Part1SafetyNet-Part4-Part5-
2026-09-26-1459.md, section 4.2 table, "Part 2, Setting 1" ... "Part 3,
Setting 19"). Includes the six "Keep vs. Disable Table" refs (10, 11, 12, 17,
18, 19). Measured before this edit: 18 GuideRef values and 17 other
"Guide: Phase" strings.

Where the reference is not a setting:
  * offline scan reminder (screen 15a) -> Part 4, section 4.5 (Step 2 there
    is the Defender Offline Scan)
  * unrecognised apps -> Part 4, section 4.5 (Step 1: remove the program)
  * password manager "LEFT ON" and screen 34 -> Part 5 (5.1 Passwords)
Box lines keep their exact length (FT-117/FT-122).

Run from Tool2/:  python build_ascii45_F5_guiderefs.py
"""
import re
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"


def same_len(old, new):
    assert len(new) <= len(old), (old, new)
    return new.ljust(len(old))


with PS1Edit(TARGET) as e:
    e.replace(
        "#           \"Steps for you to do\". F2: undo steps are guide 4.2 rows 11-15.\n",
        "#           \"Steps for you to do\". F2: undo steps are guide 4.2 rows 11-15.\n"
        "#   F5 (Decision 8): guide references name the setting number (\"Setting 14\")\n"
        "#           or a Part and section -- never a page, never the old \"Phase\".\n",
        count=1, why="change log: F5")

    # ---------- the GuideRef table: one per setting ----------
    t = e.text
    s = t.index("    [PSCustomObject]@{ ID=1;  Name=\"Windows Update\";")
    end = t.index("    [PSCustomObject]@{ ID=19;", s)
    end = t.index("\n", end) + 1
    old = t[s:end]
    new_lines = []
    n = 0
    for line in old.splitlines(True):
        m = re.search(r'ID=(\d+);', line)
        g = re.search(r'GuideRef="[^"]*"', line)
        if m and g:
            line = line.replace(g.group(0), 'GuideRef="Setting %s"' % m.group(1))
            n += 1
        new_lines.append(line)
    assert n == 18, n
    e.replace(old, "".join(new_lines), count=1, why="F5: GuideRef -> Setting N (18)")

    # ---------- box lines (length kept) ----------
    for o, nw, c in [
        ("  Guide: Phase 5 -- Scheduled Scanning                       ", "  Guide: Part 4, section 4.5 (the offline scan)", 1),
        ("  Guide: Phase 3, Step 4                                   ", "  Guide: Setting 2", 1),
        ("      Guide: Phase 1, Step 2                                ", "      Guide: Setting 3", 1),
        ("      Guide: Phase 1, Step 4                                ", "      Guide: Setting 9", 1),
        ("      Guide: Phase 5                                        ", "      Guide: Part 5, section 5.1", 1),
        ("  Guide: Phase 1, Step 3  |  $GuideURL", "  Guide: Setting 8  |  $GuideURL", 2),
    ]:
        e.replace('"' + o + '"', '"' + same_len(o, nw) + '"', count=c, why="F5: box line " + nw.strip())

    # ---------- result strings and plain lines ----------
    for o, nw, c in [
        ("Recommendation: Uninstall. See Guide: Phase 2\"", "Recommendation: Uninstall. See Guide: Part 4, section 4.5\"", 1),
        ("Matches a known suspicious publisher. See Guide: Phase 2\"", "Matches a known suspicious publisher. See Guide: Part 4, section 4.5\"", 1),
        ("See Guide: Phase 3, Step 4\"", "See Guide: Setting 2\"", 2),
        ("LEFT ON -- set up a password manager first, or your saved passwords would have nowhere to live. See Guide: Phase 5 at $GuideURL",
         "LEFT ON -- set up a password manager first, or your saved passwords would have nowhere to live. See Guide: Part 5, section 5.1 at $GuideURL", 1),
        ("Use a dedicated password manager. See Guide: Phase 5 at $GuideURL", "Use a dedicated password manager. See Guide: Setting 15 at $GuideURL", 1),
        ("RESTART REQUIRED to take effect.$drNote See Guide: Phase 1, Step 2", "RESTART REQUIRED to take effect.$drNote See Guide: Setting 16", 1),
        ("  See Guide: Phase 1, Step 3 at $GuideURL\n", "  See Guide: Setting 8 at $GuideURL\n", 1),
    ]:
        e.replace(o, nw, count=c, why="F5: " + nw[-40:])

    # the Tamper (7358/7360) and Hello (7425) results: find by content
    t = e.text
    for pat, setting, c in [(r'(\$result = "(?:NOTE: \$avName is registered as an AV\. Tamper|MANUAL ACTION REQUIRED: Windows Security -> Virus & threat protection -> Virus & threat protection settings -> Tamper)[^\n]*?)Guide: Phase 1, Step 2', "3", 2),
                            (r'(\$result = "MANUAL CHECK -- Checkup cannot confirm this one[^\n]*?)Guide: Phase 1, Step 4', "9", 1)]:
        found = list(re.finditer(pat, t))
        assert len(found) == c, (pat, len(found))
        for f in found:
            e.replace(f.group(0), f.group(1) + "Guide: Setting " + setting, count=1, why="F5: result -> Setting " + setting)
        t = e.text

    assert "Guide: Phase" not in "\n".join(l for l in e.text.splitlines() if not l.lstrip().startswith("#")), \
        [l for l in e.text.splitlines() if "Guide: Phase" in l and not l.lstrip().startswith("#")]
    assert "Keep vs. Disable Table\"" not in e.text
