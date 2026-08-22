"""fix_tool_paths -- repoint Tool\\ references to Tool2\\ after the split.

Tool\\ now holds ONLY the current build .ps1. Every launcher, checker and build
script moved to Tool2\\, so any document naming Tool\\<script> is now a dead
pointer -- the exact "a pointer that lies is worse than no pointer" failure
this project keeps getting bitten by.

Scope: CLAUDE.md (loads every session, so it must be right) and the live
governing documents in ProjectDocs. Historical session-log entries are left
alone -- they are a record of what was true then, and rewriting history to
match the present is how a log stops being evidence.

Only names that ACTUALLY live in Tool2 now are rewritten; anything else is
reported instead, so a typo cannot be silently "fixed" into a new lie.

Run from the Tool2 directory:  python fix_tool_paths.py [--apply]
"""
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
APPLY = "--apply" in sys.argv

PAT = re.compile(r"Tool\\([A-Za-z0-9_.\-]+\.(?:ps1|py|bat))")

tool2 = {
    line.split("/")[-1]
    for line in subprocess.run(
        ["git", "ls-files", "Tool2"], cwd=ROOT, capture_output=True, text=True
    ).stdout.split()
}
tool = {
    line.split("/")[-1]
    for line in subprocess.run(
        ["git", "ls-files", "Tool"], cwd=ROOT, capture_output=True, text=True
    ).stdout.split()
}

# The live set: CLAUDE.md plus the governing docs CURRENT.md names.
targets = [ROOT / "CLAUDE.md"]
cur = ROOT / "ProjectDocs" / "CURRENT.md"
if cur.exists():
    for m in re.finditer(r"`([A-Za-z0-9_.\-]+\.md)`", cur.read_text(encoding="utf-8")):
        p = ROOT / "ProjectDocs" / m.group(1)
        if p.exists() and "SessionLog" not in p.name:
            targets.append(p)

total_rewritten = 0
unknown = {}

for p in targets:
    # Byte-exact: read_text() would normalise CRLF to LF and write it back that
    # way, silently changing every line ending in the file. Decode the bytes
    # instead, so only the matched substring ever changes.
    original_bytes = p.read_bytes()
    text = original_bytes.decode("utf-8")
    hits = PAT.findall(text)
    if not hits:
        continue

    rewritten = 0

    def sub(m):
        global rewritten
        name = m.group(1)
        if name in tool2:
            rewritten += 1
            return "Tool2\\" + name
        if name in tool:
            return m.group(0)          # still in Tool\ -- correct as written
        unknown.setdefault(name, []).append(p.name)
        return m.group(0)              # unknown: leave it, report it

    new = PAT.sub(sub, text)

    if rewritten:
        print(f"  {p.relative_to(ROOT)}: {rewritten} reference(s) -> Tool2\\")
        total_rewritten += rewritten
        if APPLY and new != text:
            out = new.encode("utf-8")
            before_crlf = original_bytes.count(b"\r\n")
            after_crlf = out.count(b"\r\n")
            if before_crlf != after_crlf:
                print(f"    REFUSED {p.name}: line endings would change "
                      f"({before_crlf} -> {after_crlf} CRLF)")
                continue
            p.write_bytes(out)

if unknown:
    print("\n  NOT rewritten -- name is in neither Tool nor Tool2 (reported, not guessed):")
    for name, files in sorted(unknown.items()):
        print(f"    {name}   cited by {', '.join(sorted(set(files)))}")

print(f"\n  {'APPLIED' if APPLY else 'DRY RUN'} -- {total_rewritten} reference(s)"
      f"{'' if APPLY else '; re-run with --apply to write'}")
