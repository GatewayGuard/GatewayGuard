r"""Assemble a build's FIELD RUN EVIDENCE into one readable .md in ProjectDocs\.

WHY
---
Bill, 2026-09-04: "can you explain why claude cloud can't read/find my ascii43
test results"

***measured 2026-09-04.*** Three separate reasons stack up, and only the first
one actually matters:

1. Test_Results\ IS NOT IN THE CONNECTOR SCOPE. Cloud sees exactly four
   things -- ProjectDocs\, Tool\, WebSite\Rules\ and CLAUDE.md. Every ascii43
   result file is tracked, committed and pushed, and every one of them is
   invisible to Cloud because of where it sits. Committing harder cannot fix
   a scope problem.

2. TWO OF THE THREE RESULT FILES ARE .docx. Even inside the scope Cloud
   cannot read Word. Only Ascii43-Test-Results-...-TEXT.md would surface.

3. THE DOCUMENTS CLOUD *CAN* SEE POINT AT THE ONES IT CANNOT. The run2 triage
   alone references Test_Results\ six times, including its own appendix on how
   to reproduce any claim in the file. So Cloud reads "the evidence is in
   Test_Results\FieldRun-ascii43\", goes looking, finds nothing, and reports
   that it cannot find the test results. That is exactly the symptom.

Reason 3 is why this felt like a Cloud fault rather than a layout choice.

WHAT THIS DOES
--------------
Copies the field evidence INTO the scope, as one readable Markdown file:

    ProjectDocs\GatewayGuard_FieldRunEvidence-<build>-<stamp>.md

It carries Bill's own run notes and every run log, verbatim, in time order.
The originals stay exactly where they are -- nothing is moved, and the .docx
files stay in Test_Results\ for safekeeping and version history.

This is the same fix as build_guide_sourcepack.py and for the same reason:
the binary stays, and a readable twin goes where Cloud can reach it.

RE-RUN IT for each new build. Pass the build name:

    python build_fieldrun_sourcepack.py ascii44

READ-ONLY on everything it reads. It writes exactly one new file.
"""

import sys
import datetime
from pathlib import Path

TOOL2 = Path(__file__).resolve().parent
REPO = TOOL2.parent
RESULTS = REPO / "Test_Results"
PROJDOCS = REPO / "ProjectDocs"

# A run log is large and repetitive. Everything is kept, because the triage
# quotes exact timestamps out of these and a summary would break that.
MAX_KB_WARN = 400


def find_sources(build: str):
    """Return (notes, logs) for a build. Case-insensitive, tolerant of the
    inconsistent naming these files have arrived with -- '=2-026-' in one
    filename is a real typo in a real file, not a pattern to rely on."""
    b = build.lower()

    notes = sorted(
        p for p in RESULTS.glob("*.md")
        if b in p.name.lower() and "test-results" in p.name.lower()
    )

    logdir = None
    for d in RESULTS.iterdir():
        if d.is_dir() and b in d.name.lower():
            logdir = d
            break

    logs = sorted(logdir.glob("*.txt")) if logdir else []
    return notes, logs, logdir


def main():
    build = sys.argv[1] if len(sys.argv) > 1 else "ascii43"

    notes, logs, logdir = find_sources(build)

    if not notes and not logs:
        print(f"  Nothing found for '{build}'.")
        print(f"  Looked in: {RESULTS}")
        print("  Expected a *-Test-Results-*.md and a FieldRun-<build>\\ folder.")
        return 1

    now = datetime.datetime.now()
    stamp = now.strftime("%Y-%m-%d-%H%M")
    out = PROJDOCS / f"GatewayGuard_FieldRunEvidence-{build}-{stamp}.md"

    parts = []
    parts.append(f"<!-- Dated: {now.strftime('%Y-%m-%d %H:%M')} ET -->")
    parts.append(f"# Field run evidence -- {build}")
    parts.append("")
    parts.append(
        "**GENERATED FILE. Do not edit by hand.** Rebuild it with "
        "`python Tool2\\build_fieldrun_sourcepack.py " + build + "`."
    )
    parts.append("")
    parts.append(
        "**Why this file exists.** The real files live in `Test_Results\\`, "
        "which is **outside the connector scope** -- Claude Cloud cannot see "
        "anything in there, however thoroughly it is committed and pushed. "
        "The triage documents reference those paths repeatedly, so Cloud was "
        "being sent to look somewhere it cannot reach. This copy puts the "
        "same evidence inside `ProjectDocs\\`, where Cloud can read it."
    )
    parts.append("")
    parts.append("**The originals are unchanged and remain the record of truth.**")
    parts.append("")
    parts.append("## What is in here")
    parts.append("")
    for p in notes:
        parts.append(f"- Run notes: `Test_Results\\{p.name}`")
    if logdir:
        for p in logs:
            parts.append(f"- Run log: `Test_Results\\{logdir.name}\\{p.name}`")
    parts.append("")
    parts.append("---")
    parts.append("")

    for p in notes:
        parts.append(f"# RUN NOTES -- {p.name}")
        parts.append("")
        parts.append(p.read_text(encoding="utf-8", errors="replace").rstrip())
        parts.append("")
        parts.append("---")
        parts.append("")

    for p in logs:
        parts.append(f"# RUN LOG -- {p.name}")
        parts.append("")
        parts.append("```")
        parts.append(p.read_text(encoding="utf-8", errors="replace").rstrip())
        parts.append("```")
        parts.append("")
        parts.append("---")
        parts.append("")

    text = "\n".join(parts) + "\n"
    out.write_text(text, encoding="utf-8")

    kb = len(text.encode("utf-8")) // 1024
    print(f"  Wrote {out.relative_to(REPO)}")
    print(f"  {len(notes)} notes file(s), {len(logs)} run log(s), {kb} KB")
    if kb > MAX_KB_WARN:
        print(f"  NOTE: over {MAX_KB_WARN} KB. Check gate 26 -- this counts")
        print("  against what Cloud can hold.")
    print("")
    print("  Commit and push it, then tell Bill to sync.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
