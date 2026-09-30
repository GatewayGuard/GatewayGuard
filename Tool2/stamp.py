"""stamp.py -- writes the clock time into files, so no time is ever typed.

Dated: 2026-09-30 16:21 ET
Editor: Claude Code (CGDELL)

Bill, 2026-09-30: "why do we keep having these mistakes". The answer included
stamps: the time was read off the clock, then typed by hand a few steps later,
and came out 1-14 minutes wrong (12:30 for 12:29, 14:39 for 14:53, 15:23 for
15:28 ...). Gate 27 only caught times in the future. This removes the typing.

USE
  Write the file with placeholders instead of a time:
      @ @NOW@ @    -> 2026-09-30 16:25     (for "Dated:" / "Updated:" lines)
      @ @STAMP@ @  -> 2026-09-30-1625      (for file names)
  (written here with spaces, so this file does not stamp itself -- in a real
  file there are no spaces). Then run:
      python Tool2/stamp.py <file> [<file> ...]
  Every placeholder in the file is replaced with the same clock reading. If the
  FILE NAME contains the STAMP placeholder, the file is renamed too, and the new
  name is printed. Gate 27 refuses a commit that still holds a placeholder
  (check S2), and a new file whose "Dated:" differs from when it was created
  (check S3).

      python Tool2/stamp.py --now      prints both forms, for use in a name

The first version stamped ITSELF on its first test (16:21) -- its own code held
the placeholder words, so they were replaced too. They are now built from
pieces below, so they never appear whole in this file.
"""
import os
import sys
from datetime import datetime

AT = "@@"
NOW_TOKEN = AT + "NOW" + AT
STAMP_TOKEN = AT + "STAMP" + AT


def forms():
    now = datetime.now()   # CGDELL and SANDY both keep US Eastern time
    return now.strftime("%Y-%m-%d %H:%M"), now.strftime("%Y-%m-%d-%H%M")


def stamp_file(path):
    now_s, stamp_s = forms()
    text = open(path, "rb").read().decode("utf-8")
    n = text.count(NOW_TOKEN) + text.count(STAMP_TOKEN)
    text = text.replace(NOW_TOKEN, now_s).replace(STAMP_TOKEN, stamp_s)
    open(path, "wb").write(text.encode("utf-8"))   # binary: line endings untouched
    new_path = path
    base = os.path.basename(path)
    if STAMP_TOKEN in base:
        new_path = os.path.join(os.path.dirname(path), base.replace(STAMP_TOKEN, stamp_s))
        os.replace(path, new_path)
    print("%s  %d placeholder(s) -> %s%s" % (new_path, n, now_s,
          "" if new_path == path else "  (renamed from " + base + ")"))
    return new_path


if __name__ == "__main__":
    args = sys.argv[1:]
    if not args or args == ["--now"]:
        a, b = forms()
        print("NOW   = " + a)
        print("STAMP = " + b)
        sys.exit(0)
    bad = 0
    for p in args:
        if not os.path.isfile(p):
            print("not a file: " + p)
            bad += 1
            continue
        stamp_file(p)
    sys.exit(1 if bad else 0)
