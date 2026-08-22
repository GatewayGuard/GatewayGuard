"""build_pptx_twin -- generate a readable .md twin of a .pptx.

Dated: 2026-08-19 09:30 ET
Editor: Claude Code (CGDELL)

WHY: Claude Cloud cannot read .pptx. Measured 2026-08-13 as a controlled
result -- a .docx and its .md twin in the same folder, same scope, same commit,
and only the .md ever surfaced. A binary in the connector scope is a file that
is synced and invisible, which is worse than one that is absent, because
everyone believes it arrived.

NO LIBRARY REQUIRED, and that is deliberate. build_readable_twins.py records
that no PDF text library is installed on CGDELL and that installing one is a
change to the machine rather than to the project. A .pptx is an Open Packaging
Convention zip of XML, so zipfile and the standard XML parser are enough --
nothing to install, nothing to break on another machine.

WHAT IT EXTRACTS
  * slide text, in slide order, from <a:t> runs
  * speaker notes, which for a presentation are usually the real content --
    the slides carry headlines and the notes carry what gets said
  * a manifest of embedded media, named but not extracted

WHAT IT CANNOT DO, stated rather than silently lost: layout, images, and the
reading order WITHIN a slide where the deck was built with overlapping text
boxes. Slide order is reliable; order inside a busy slide is best-effort.
"""

from __future__ import annotations

import re
import sys
import zipfile
from pathlib import Path
from xml.etree import ElementTree as ET

A = "{http://schemas.openxmlformats.org/drawingml/2006/main}"


def slide_sort_key(name: str) -> int:
    m = re.search(r"(\d+)\.xml$", name)
    return int(m.group(1)) if m else 0


def text_of(xml_bytes: bytes) -> list[str]:
    """Every <a:t> run, grouped into paragraphs by <a:p>."""
    try:
        root = ET.fromstring(xml_bytes)
    except ET.ParseError:
        return []
    out = []
    for para in root.iter(A + "p"):
        runs = [(t.text or "") for t in para.iter(A + "t")]
        line = "".join(runs).strip()
        if line:
            out.append(line)
    return out


def build(src: Path) -> str:
    z = zipfile.ZipFile(src)
    names = z.namelist()

    slides = sorted([n for n in names if re.match(r"ppt/slides/slide\d+\.xml$", n)],
                    key=slide_sort_key)
    notes = {slide_sort_key(n): n for n in names
             if re.match(r"ppt/notesSlides/notesSlide\d+\.xml$", n)}
    media = sorted(n for n in names if n.startswith("ppt/media/"))

    L = []
    L.append(f"<!-- Generated from {src.name} by Tool/build_pptx_twin.py -->")
    L.append("<!-- Dated: 2026-08-19 09:30 ET -->")
    L.append(f"# {src.stem} -- readable twin")
    L.append("")
    L.append(f"**Source:** `{src.name}` ({src.stat().st_size:,} bytes, "
             f"{len(slides)} slides)")
    L.append("")
    L.append("**This file is generated. Edit the .pptx, then re-run "
             "`Tool/build_pptx_twin.py`.** It exists because Claude Cloud "
             "cannot read a .pptx -- the binary syncs and stays invisible, "
             "which is worse than being absent, because everyone believes it "
             "arrived.")
    L.append("")
    L.append("**Not carried over:** layout, images, and reading order within "
             "a slide that uses overlapping text boxes. Slide order is "
             "reliable.")
    L.append("")
    L.append("---")
    L.append("")

    for i, s in enumerate(slides, 1):
        n = slide_sort_key(s)
        body = text_of(z.read(s))
        L.append(f"## Slide {i}")
        L.append("")
        if body:
            L.append(f"**{body[0]}**")
            L.append("")
            for line in body[1:]:
                L.append(f"- {line}")
        else:
            L.append("*(no text on this slide)*")
        L.append("")
        if n in notes:
            note_lines = [x for x in text_of(z.read(notes[n]))
                          if not re.fullmatch(r"\d+", x)]
            if note_lines:
                L.append("**Speaker notes:**")
                L.append("")
                for line in note_lines:
                    L.append(f"> {line}")
                L.append("")
        L.append("---")
        L.append("")

    if media:
        L.append("## Embedded media")
        L.append("")
        L.append("Named, not extracted -- open the .pptx to see them.")
        L.append("")
        for m in media:
            L.append(f"- `{Path(m).name}`")
        L.append("")

    return "\n".join(L)


def main(argv):
    if len(argv) < 2:
        print("usage: build_pptx_twin.py <file.pptx> [more.pptx ...]")
        return 2
    for arg in argv[1:]:
        src = Path(arg)
        if not src.exists():
            print(f"  NOT FOUND: {src}")
            return 1
        out = src.with_suffix(".md")
        if out.exists() and "readable twin" not in out.read_text(encoding="utf-8", errors="ignore")[:2000]:
            print(f"  REFUSING to overwrite {out.name} -- it is not a generated twin")
            return 1
        md = build(src)
        out.write_text(md, encoding="utf-8")
        print(f"  {src.name} -> {out.name}  ({len(md):,} chars)")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
