"""gg_edit -- the assert-guarded wrapper for every .ps1 build edit.

Dated: 2026-08-13 10:04 ET
Editor: Claude Code (CGDELL)

CodingStandards PYTHON EDITING RULES require every edit to a .ps1 build file
to go through a wrapper like this -- feature work, defect fixes, AND lint or
cleanup passes, with no cosmetic exemption.

WHY THIS FILE EXISTS AT ALL, TWICE OVER
---------------------------------------
1. On 2026-07-25 a PSScriptAnalyzer cleanup pass was treated as too trivial to
   need the wrapper. Applied as a bulk raw string replace, it duplicated the
   file about 40x -- 341 KB / 5,574 lines became 13.7 MB / 228,739 lines,
   unparseable. **Brace balance did not catch it**: the corrupt file measured
   47,232 open / 47,232 close, perfectly balanced and completely destroyed.
   Duplication-class damage copies balanced blocks, so it stays balanced by
   construction. That is why rules 6b (size) and 6c (parse) exist.

2. The wrappers that built ascii37 were never committed and are gone. Measured
   2026-08-07 and again 2026-08-13: zero .py files in the tree, zero in git
   history. The spec survived; the code did not. **This one is committed.**

USAGE
-----
    from gg_edit import PS1Edit

    with PS1Edit(r"Tool\\W11-SecurityHardening-v3-ascii40-....ps1") as e:
        e.replace(old_text, new_text, count=1, why="FT-171: drain by flush")
        e.replace(other, other_new, count=3, why="FT-172: screen order table")

Nothing is written unless every assertion passes and the result parses. On any
failure the original file is untouched and the working copy is kept for
inspection -- fail closed, per V-6. A guard that fails closed on a false
positive is cheap; a guard that fails open is how ascii34 was corrupted and how
ScanType 4 printed [GOOD] for months.
"""

from __future__ import annotations

import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

BOM = "﻿"


class EditError(Exception):
    """Raised on any assertion failure. Nothing is written when this fires."""


class PS1Edit:
    """Context manager for guarded edits to one .ps1 file.

    Implements PYTHON EDITING RULES 1-7:
      1  copy to -work.ps1 first
      2  normalize CRLF -> LF before editing
      3  write back as CRLF
      4  count assertion before every substitution
      4a bounded replace -- explicit count, never replace-all
      5  a wrong count stops the run; the expectation is never adjusted to fit
      6  brace balance after the session
      6a brace balance is NOT sufficient on its own
      6b size assertion -- delta within max(50, 10%)
      6c parse check via [Parser]::ParseFile, must be 0 errors
      7  UTF-8 BOM present in the output
    """

    def __init__(self, path, size_tolerance=0.10, min_line_slack=50):
        self.path = Path(path)
        if not self.path.exists():
            raise EditError(f"not found: {self.path}")
        if self.path.suffix.lower() != ".ps1":
            raise EditError(f"not a .ps1: {self.path}")

        self.work = self.path.with_name(self.path.stem + "-work.ps1")
        self.size_tolerance = size_tolerance
        self.min_line_slack = min_line_slack
        self.edits = []
        self._committed = False

        # Rule 1 -- copy to -work.ps1 first.
        shutil.copy2(self.path, self.work)

        raw = self.path.read_text(encoding="utf-8-sig")
        self.had_bom = self.path.read_bytes().startswith(b"\xef\xbb\xbf")

        # Rule 2 -- normalize line endings before editing.
        self.text = raw.replace("\r\n", "\n")
        self.original = self.text

        self.before_lines = len(self.original.splitlines())
        self.before_bytes = self.path.stat().st_size
        self.before_braces = (self.original.count("{"), self.original.count("}"))

        print(f"  [open ] {self.path.name}")
        print(f"          {self.before_lines:,} lines / {self.before_bytes:,} bytes / "
              f"braces {self.before_braces[0]}:{self.before_braces[1]} / BOM {self.had_bom}")

    # -- editing ---------------------------------------------------------

    def replace(self, old, new, count, why=""):
        """Rule 4 + 4a: assert the count, then replace EXACTLY that many."""
        if not old:
            raise EditError("empty search string")
        if count < 1:
            raise EditError(f"count must be >= 1, got {count}")

        found = self.text.count(old)
        if found != count:
            raise EditError(
                f"COUNT ASSERTION FAILED: expected {count}, found {found}\n"
                f"  string: {old[:110]!r}\n"
                f"  Rule 5: investigate. Never adjust the expected count to make it pass."
            )

        # Rule 4a -- bounded. The count argument is the asserted number.
        self.text = self.text.replace(old, new, count)

        remaining = self.text.count(old)
        # An append-style edit deliberately keeps `old` inside `new`.
        expected_remaining = count if old in new else 0
        if remaining != expected_remaining:
            raise EditError(
                f"POST-REPLACE CHECK FAILED: {remaining} occurrence(s) of the old "
                f"string remain, expected {expected_remaining}"
            )

        self.edits.append((count, why))
        print(f"  [edit ] {count} x  {why}")
        return self

    def insert_after(self, anchor, addition, count=1, why=""):
        """Convenience: place `addition` immediately after `anchor`."""
        return self.replace(anchor, anchor + addition, count, why)

    # -- verification ----------------------------------------------------

    def _check_size(self):
        after = len(self.text.splitlines())
        allowed = max(self.min_line_slack, self.before_lines * self.size_tolerance)
        delta = after - self.before_lines
        if abs(delta) > allowed:
            raise EditError(
                f"SIZE ASSERTION FAILED: {self.before_lines:,} -> {after:,} lines "
                f"({delta:+,}); allowed +/-{allowed:,.0f}. STOP."
            )
        print(f"  [size ] {self.before_lines:,} -> {after:,} lines ({delta:+,}) -- within +/-{allowed:,.0f}")

    def _check_braces(self):
        o, c = self.text.count("{"), self.text.count("}")
        if o != c:
            raise EditError(f"BRACE BALANCE FAILED: {o} open / {c} close")
        # Rule 6a -- say plainly that this proves less than it looks.
        print(f"  [brace] {o}:{c} balanced "
              f"(rule 6a: balance CANNOT detect duplication -- 6b and 6c do that)")

    def _check_parse(self, target):
        """Rule 6c -- the cheapest catastrophic-damage detector there is."""
        ps = (
            "$e=$null; $t=$null; "
            "[void][System.Management.Automation.Language.Parser]::ParseFile("
            f"'{target}',[ref]$t,[ref]$e); "
            "if($e){$e.Count}else{0}"
        )
        try:
            r = subprocess.run(
                ["powershell.exe", "-NoProfile", "-NonInteractive", "-Command", ps],
                capture_output=True, text=True, timeout=120,
            )
        except (OSError, subprocess.TimeoutExpired) as exc:
            raise EditError(f"PARSE CHECK COULD NOT RUN: {exc}. Treat as failure.")

        out = (r.stdout or "").strip().splitlines()
        errs = out[-1].strip() if out else ""
        if errs != "0":
            raise EditError(
                f"PARSE CHECK FAILED: {errs or '(no output)'} error(s).\n"
                f"  Do NOT hand-patch a file that no longer parses.\n"
                f"  Recover from a known-good copy -- see RECOVERY POINTS."
            )
        print("  [parse] 0 errors")

    # -- commit ----------------------------------------------------------

    def _write(self):
        if self.text == self.original:
            print("  [write] no change -- nothing written")
            return False

        # Rule 3 -- write back as CRLF. Rule 7 -- UTF-8 BOM present.
        body = self.text.replace("\r\n", "\n").replace("\n", "\r\n")
        if not body.startswith(BOM):
            body = BOM + body

        # Verify on the working copy BEFORE the real file is touched.
        self.work.write_text(body, encoding="utf-8", newline="")
        self._check_parse(str(self.work.resolve()).replace("'", "''"))

        self.path.write_text(body, encoding="utf-8", newline="")

        if not self.path.read_bytes().startswith(b"\xef\xbb\xbf"):
            raise EditError("BOM ASSERTION FAILED: output lacks a UTF-8 BOM")

        after_bytes = self.path.stat().st_size
        print(f"  [write] {self.path.name} -- {after_bytes:,} bytes "
              f"({after_bytes - self.before_bytes:+,}), CRLF, BOM present")
        return True

    def commit(self):
        if not self.edits:
            print("  [done ] no edits staged")
            return False
        self._check_size()
        self._check_braces()
        wrote = self._write()
        self._committed = True
        if self.work.exists():
            self.work.unlink()
        total = sum(n for n, _ in self.edits)
        print(f"  [done ] {len(self.edits)} replacement group(s), {total} site(s)")
        return wrote

    # -- context manager -------------------------------------------------

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc, tb):
        if exc_type is not None:
            # Fail closed. Original untouched; working copy kept for inspection.
            print(f"\n  ABORTED: {exc}", file=sys.stderr)
            print(f"  Original NOT modified. Working copy kept: {self.work.name}",
                  file=sys.stderr)
            return False
        self.commit()
        return False


# -- self-test -----------------------------------------------------------

def _self_test():
    """Prove every guard fires. A guard nobody has watched fail is a wish."""
    import tempfile

    tmp = Path(tempfile.mkdtemp(prefix="gg_edit_test_"))
    sample = ("﻿# test\r\n"
              "function Test-Thing {\r\n"
              "    $x = 'ALPHA'\r\n"
              "    $y = 'ALPHA'\r\n"
              "    Write-Host $x\r\n"
              "}\r\n")
    passed = failed = 0

    def check(name, fn):
        nonlocal passed, failed
        try:
            fn()
            print(f"  PASS  {name}")
            passed += 1
        except AssertionError as e:
            print(f"  FAIL  {name}: {e}")
            failed += 1

    def fresh(n="t.ps1"):
        p = tmp / n
        p.write_bytes(sample.encode("utf-8"))
        return p

    # 1. A correct edit succeeds, and BOM + CRLF survive.
    def t_ok():
        p = fresh("ok.ps1")
        with PS1Edit(p) as e:
            e.replace("'ALPHA'", "'BETA'", count=2, why="self-test")
        out = p.read_bytes()
        assert out.startswith(b"\xef\xbb\xbf"), "BOM lost"
        assert b"\r\n" in out, "CRLF lost"
        assert out.count(b"BETA") == 2, "replacement did not land"
        assert out.count(b"ALPHA") == 0, "old string survived"
        assert not (tmp / "ok-work.ps1").exists(), "working copy not cleaned up"

    # 2. A wrong count aborts and leaves the original untouched.
    def t_count():
        p = fresh("count.ps1")
        before = p.read_bytes()
        try:
            with PS1Edit(p) as e:
                e.replace("'ALPHA'", "'GAMMA'", count=1, why="wrong count")
        except EditError:
            pass
        assert p.read_bytes() == before, "file changed despite failed assertion"

    # 3. Unbalanced braces abort.
    def t_brace():
        p = fresh("brace.ps1")
        before = p.read_bytes()
        try:
            with PS1Edit(p) as e:
                e.replace("Write-Host $x", "if ($x) { Write-Host $x", count=1, why="unbalanced")
        except EditError:
            pass
        assert p.read_bytes() == before, "unbalanced braces were written"

    # 4. Duplication-class damage is caught by SIZE even though braces balance.
    #    The replacement must NOT contain the original verbatim, or the
    #    post-replace check fires first and the size guard is never reached --
    #    which is what the first version of this test actually proved while
    #    claiming otherwise.
    def t_dup():
        p = fresh("dup.ps1")
        before = p.read_bytes()
        block = "function Test-Thing {\n    $x = 'ALPHA'\n    $y = 'ALPHA'\n    Write-Host $x\n}"
        copy = block.replace("Test-Thing", "Test-Thing2")   # balanced, not a substring
        dup = "\n".join([copy] * 200)
        assert block not in dup, "test setup wrong -- post-replace check would fire first"
        assert dup.count("{") == dup.count("}"), "test setup wrong -- must stay brace-balanced"

        err = None
        try:
            with PS1Edit(p) as e:
                e.replace(block, dup, count=1, why="simulated ascii34 duplication")
        except EditError as ex:
            err = str(ex)
        assert err and "SIZE ASSERTION FAILED" in err, \
            f"expected the SIZE guard to fire, got: {err}"
        assert p.read_bytes() == before, "duplication was written"

    print("\n=== gg_edit self-test ===")
    check("correct edit writes, BOM and CRLF preserved", t_ok)
    check("wrong count aborts, original untouched", t_count)
    check("unbalanced braces abort", t_brace)
    check("duplication caught by size assertion (braces stay balanced)", t_dup)
    shutil.rmtree(tmp, ignore_errors=True)

    print(f"\n{passed} passed, {failed} failed")
    return 0 if failed == 0 else 1


if __name__ == "__main__":
    sys.exit(_self_test())
