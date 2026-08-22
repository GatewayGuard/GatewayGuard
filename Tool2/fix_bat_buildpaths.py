"""fix_bat_buildpaths -- point the build-aware launchers at ..\\Tool\\, and
repair two launchers that were stored with bare LF endings.

After the split, Tool\\ holds ONLY the current build .ps1; every .bat and every
helper script lives in Tool2\\. The .bat that call a helper need NO change --
they cd to their own folder and the helper is beside them, exactly as before.

Four .bat reference the BUILD and do need changing:
  Run-GatewayGuard.bat          set "GGBUILD=..."           -> ..\\Tool\\, ascii43
  Show-AllScreens.bat           -File "..."                 -> ..\\Tool\\, ascii43
  Run-ScreenCoverageCheck.bat   dir /b /o-d "W11-...*.ps1"  -> ..\\Tool\\
  Run-ExternalCommandCheck.bat  same                        -> ..\\Tool\\

TWO THINGS FOUND WHILE DOING IT, both real defects:

1. The two launchers still named **ascii42**. They were never updated when
   ascii43 was built, so double-clicking Run-GatewayGuard ran the OLD build.

2. **Run-GatewayGuard.bat and Show-AllScreens.bat are LF-only, in git.**
   Measured 2026-08-22 -- the other 28 .bat are CRLF. CLAUDE.md requires CRLF
   because "bat files with bare LF endings misbehave in cmd.exe", and these are
   the two launchers Bill actually double-clicks. Normalised here.

Exact-string replaces with asserted counts, on bytes, so nothing else moves.
(sed was tried first and ate backslashes; GNU sed also read the "\\U" of
Update-Current.ps1 as its uppercase operator and deleted a character.)

Run from the Tool2 directory:  python fix_bat_buildpaths.py
"""
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
OLD = "W11-SecurityHardening-v3-ascii42-2026-08-19-1830.ps1"
NEW = "W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1"
DIR_SCAN = """'dir /b /o-d "W11-SecurityHardening-v3-*.ps1" 2^>nul'"""
DIR_SCAN_NEW = """'dir /b /o-d "..\\Tool\\W11-SecurityHardening-v3-*.ps1" 2^>nul'"""

EDITS = [
    ("Run-GatewayGuard.bat", [
        (f"REM CURRENT BUILD: {OLD}", f"REM CURRENT BUILD: {NEW}   (lives in ..\\Tool\\)", 1),
        (f'set "GGBUILD={OLD}"', f'set "GGBUILD=..\\Tool\\{NEW}"', 1),
    ]),
    ("Show-AllScreens.bat", [
        (f"REM CURRENT BUILD: {OLD}", f"REM CURRENT BUILD: {NEW}   (lives in ..\\Tool\\)", 1),
        (f'-File "{OLD}"', f'-File "..\\Tool\\{NEW}"', 1),
    ]),
    ("Run-ScreenCoverageCheck.bat", [
        ("REM  It finds the newest W11-SecurityHardening .ps1 in this folder by itself,",
         "REM  It finds the newest W11-SecurityHardening .ps1 in ..\\Tool\\ by itself,", 1),
        (DIR_SCAN, DIR_SCAN_NEW, 1),
        ("echo   ERROR: no W11-SecurityHardening-v3-*.ps1 found in this folder.",
         "echo   ERROR: no W11-SecurityHardening-v3-*.ps1 found in ..\\Tool\\.", 1),
    ]),
    ("Run-ExternalCommandCheck.bat", [
        ("REM  It finds the newest W11-SecurityHardening .ps1 in this folder by itself.",
         "REM  It finds the newest W11-SecurityHardening .ps1 in ..\\Tool\\ by itself.", 1),
        (DIR_SCAN, DIR_SCAN_NEW, 1),
        ("echo   ERROR: no W11-SecurityHardening-v3-*.ps1 found in this folder.",
         "echo   ERROR: no W11-SecurityHardening-v3-*.ps1 found in ..\\Tool\\.", 1),
    ]),
]

failed = False
for name, subs in EDITS:
    p = HERE / name
    raw = p.read_bytes()
    text = raw.decode("utf-8")

    for old, new, count in subs:
        found = text.count(old)
        if found != count:
            print(f"  COUNT FAILED {name}: expected {count}, found {found}")
            print(f"      {old[:90]!r}")
            failed = True
            continue
        text = text.replace(old, new, count)

    # Normalise to CRLF. Two of these four were stored LF-only, against the
    # CLAUDE.md rule; the other two are already CRLF and are unaffected.
    body = text.replace("\r\n", "\n").replace("\n", "\r\n")
    out = body.encode("utf-8")

    if b"\r\n" not in out:
        print(f"  {name}: no CRLF in output -- refusing to write")
        failed = True
        continue
    if out.count(b"\n") != out.count(b"\r\n"):
        print(f"  {name}: mixed endings after normalise -- refusing to write")
        failed = True
        continue

    if out != raw:
        p.write_bytes(out)
        crlf_fixed = b"\r\n" not in raw
        print(f"  updated {name}" + ("   [+ LF -> CRLF repaired]" if crlf_fixed else ""))

if failed:
    sys.exit(1)

print("\n  -- verification ------------------------------------------------")
for name, _ in EDITS:
    d = (HERE / name).read_bytes()
    ok_crlf = d.count(b"\n") == d.count(b"\r\n")
    t = d.decode("utf-8")
    stale = OLD in t
    print(f"    {name:<32} CRLF={'yes' if ok_crlf else 'NO'}  ascii42-left={'YES' if stale else 'no'}")
    for line in t.splitlines():
        s = line.strip()
        if s.startswith(("set \"GGBUILD", "powershell.exe -NoProfile -ExecutionPolicy Bypass -File \"..")) or "dir /b /o-d" in s:
            print(f"        {s}")
