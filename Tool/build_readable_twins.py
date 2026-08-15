r"""Generate a readable .md twin, into ProjectDocs\, for every master in Masters\.

WHY
---
Claude Cloud cannot read .docx, .pdf or .pptx. Measured 2026-08-13, a
controlled result -- GatewayGuard_MarketResearch.docx and .md sit in the same
folder, same connector scope, same commit, and only the .md ever surfaces.

So a binary can be committed, pushed and synced correctly and still be
invisible. The guide .docx was in that state for SIXTEEN DAYS.

This sweeps the folder so it stops happening one document at a time when
somebody notices. Run it after adding any Word or PowerPoint file, and at
session end.

WHAT IT CANNOT DO
-----------------
**PDFs.** No PDF text library is installed on CGDELL (pypdf, PyPDF2 and
pymupdf all absent, checked 2026-08-13) and installing one is a change to
Bill's machine, not a decision for a script. PDFs are REPORTED, never silently
skipped -- an unreported gap is how the guide stayed invisible.

Most of the PDFs here do not need a twin anyway: the five Guide-*.pdf print
editions are renderings of windows_security_walkthrough_guide_v9.docx, which
already has one.
"""

import html
import re
import subprocess
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
# 2026-08-15: the two halves now live apart, and that is the point.
#   MASTERS  -- the binaries, in Masters\, OUTSIDE connector scope.
#   DOCS     -- the readable twins, in ProjectDocs\, INSIDE it.
# Cloud cannot read a .docx, .pdf or .pptx, so every byte of binary sitting
# in ProjectDocs spent connector capacity and returned nothing. Sweep the
# masters; write the twins where they can actually be read.
MASTERS = ROOT / "Masters"
DOCS = ROOT / "ProjectDocs"

STAMP = subprocess.run(
    ["powershell", "-NoProfile", "-Command", "Get-Date -Format 'yyyy-MM-dd HH:mm'"],
    capture_output=True, text=True).stdout.strip()

# Already covered by a purpose-built generator, or third-party material with
# no project value. Skipping is a decision, so each one carries its reason.
COVERED = {
    "windows_security_walkthrough_guide_v9.docx": "build_guide_sourcepack.py",
    "GatewayGuard_ExpertPositioning-2026-07-16.docx": "build_marketing_sourcepack.py",
    "GatewayGuard_LaymanPositioning-2026-07-16.docx": "build_marketing_sourcepack.py",
    "GatewayGuard_ACBL_Pitch-2026-07-16.docx": "build_marketing_sourcepack.py",
    # 2026-08-15: this entry USED TO BE FALSE. It said "build_marketing_
    # sourcepack.py"; measured, "CommunityFlyer" appeared ZERO times in that
    # pack because it was never in its SOURCES list. A skip carrying a reason
    # that is not true is worse than no skip -- it stops anyone looking again,
    # which is how this survived from the day this file was written.
    #
    # The real cause, measured the same day: the file is NOT a .docx. Its first
    # bytes are "**IS YOUR HOME C", not a ZIP signature. It is plain Markdown
    # with the wrong extension, which is why every binary-aware tool here
    # skipped it and why the extractor dies on it with BadZipFile.
    # VERIFIED 2026-08-15: ProjectDocs\GatewayGuard_CommunityFlyer.md exists.
    "GatewayGuard_CommunityFlyer.docx":
        "NOT a real .docx -- plain Markdown, wrong extension. "
        "Twin written directly: ProjectDocs\\GatewayGuard_CommunityFlyer.md",
    "GatewayGuard_MarketResearch.docx": "GatewayGuard_MarketResearch.md exists",
    "mainellc6.pdf": "scanned filing, image-only",
}

# MOVED OUT OF ProjectDocs\ 2026-08-14, not deleted. Project knowledge hit
# 390% of capacity, and 21 of ProjectDocs' 24 MB was files Cloud cannot read
# at all -- so they cost capacity and returned nothing. Their COVERED entries
# went with them; an entry for a file that is no longer here can never match.
#
#   DigiCert-Token-Instructions.pdf  6.97 MB -> Certificates\
#   20260726_161618.jpg              4.90 MB -> Presentation\
#   MB_Privacy_policy_.pdf           4.39 MB -> MB\
#   MB Privacy policy..pdf           0.23 MB -> MB\
#   Getting started with OneDrive.pdf 0.38 MB -> Notes\
#
# THE RULE THIS ESTABLISHES: a file Cloud cannot read does not belong in a
# folder Cloud syncs. Keep it in the repository, keep it out of scope.

HEADING = {"Heading1": "##", "Heading2": "###", "Heading3": "####",
           "Title": "#", "Heading4": "#####"}


def extract(path):
    """Text from .docx or .pptx. Headings survive where Word marked them."""
    out = []
    with zipfile.ZipFile(path) as z:
        names = [n for n in z.namelist()
                 if re.match(r"(word/document|ppt/slides/slide\d+)\.xml$", n)]

        def order(n):
            m = re.search(r"slide(\d+)", n)
            return (0, int(m.group(1))) if m else (1, 0)

        for n in sorted(names, key=order):
            xml = z.read(n).decode("utf-8", "replace")
            m = re.search(r"slide(\d+)", n)
            if m:
                out.append(f"\n### Slide {m.group(1)}\n")
            for blk in re.findall(r"<(?:w|a):p[ >].*?</(?:w|a):p>", xml, re.S):
                st = re.search(r'<w:pStyle w:val="([^"]+)"', blk)
                style = st.group(1) if st else ""
                txt = html.unescape(re.sub(r"<[^>]+>", "", re.sub(r"<w:tab/>", "  ", blk)))
                txt = re.sub(r"[ \t]+", " ", txt).strip()
                if not txt:
                    continue
                h = HEADING.get(style)
                out.append(f"\n{h} {txt}\n" if h else txt)
    return "\n".join(out)


def main():
    made, skipped, pdfs, failed = [], [], [], []

    for p in sorted(MASTERS.iterdir()):
        if not p.is_file() or p.suffix.lower() not in {".docx", ".pptx", ".pdf"}:
            continue
        if p.name in COVERED:
            skipped.append((p.name, COVERED[p.name]))
            continue
        if p.suffix.lower() == ".pdf":
            pdfs.append(p.name)
            continue

        twin = DOCS / (p.stem + "-TEXT.md")
        try:
            body = extract(p)
        except (zipfile.BadZipFile, OSError) as e:
            failed.append((p.name, str(e)))
            continue
        if len(body.strip()) < 40:
            failed.append((p.name, "no extractable text"))
            continue

        head = (f"<!-- Dated: {STAMP} ET -->\n"
                f"<!-- Editor: Claude Code (CGDELL) -->\n"
                f"<!-- GENERATED by Tool/build_readable_twins.py -- do not hand-edit. -->\n"
                f"# {p.stem} -- readable text\n\n"
                f"- **Source of record:** `Masters/{p.name}`\n"
                f"- **Generated:** {STAMP} ET\n\n"
                f"**This is an extraction, not the document.** Claude Cloud cannot read\n"
                f"`.docx`, `.pdf` or `.pptx`, so the binary is kept for safekeeping and\n"
                f"this is what gets read. Formatting, tables and images are not preserved.\n"
                f"Anything to be changed goes into the source, never here.\n\n---\n\n")
        twin.write_text(head + body.strip() + "\n", encoding="utf-8", newline="")
        made.append((twin.name, twin.stat().st_size))

    print(f"=== readable twins, {STAMP} ET ===\n")
    if made:
        print(f"CREATED {len(made)}:")
        for name, size in made:
            print(f"  {size:>8,} b  {name}")
    else:
        print("CREATED 0 -- every Word/PowerPoint file already has a twin.")

    if skipped:
        print(f"\nSKIPPED {len(skipped)} (each with a reason):")
        for name, why in skipped:
            print(f"  {name:<52} {why}")

    if pdfs:
        print(f"\nPDF -- NOT EXTRACTED, {len(pdfs)}. Reported, never silently dropped:")
        for name in pdfs:
            print(f"  {name}")
        print("  No PDF text library is installed. Installing one changes Bill's")
        print("  machine and is his call, not this script's.")

    if failed:
        print(f"\nFAILED {len(failed)}:")
        for name, why in failed:
            print(f"  {name:<52} {why}")
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
