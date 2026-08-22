r"""Build one plain-text source pack of the marketing documents, into
ProjectDocs/ -- which is already in the Cloud connector scope.

Why this rather than adding Marketing\ to the connector: the folder is not in
scope, and putting it in scope costs capacity for five .docx that Cloud would
receive as text extractions anyway (briefing s9 -- project knowledge stores
.docx as plain text, not as documents). Extracting them here gives Cloud the
same content, in scope, with no scope change and no binary.
"""
import html
import re
import subprocess
import zipfile
from pathlib import Path

ROOT = Path(r"C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard")
STAMP = subprocess.run(["powershell", "-NoProfile", "-Command",
                        "Get-Date -Format 'yyyy-MM-dd HH:mm'"],
                       capture_output=True, text=True).stdout.strip()
FSTAMP = STAMP.replace(" ", "-").replace(":", "")

SOURCES = [
    ("Layman Positioning Statement", r"Marketing\GatewayGuard_LaymanPositioning-2026-07-16.docx",
     "The default voice for ALL GatewayGuard writing (ProjectInstructions, WRITING AUDIENCE DEFAULT)."),
    ("Expert / B2B Positioning Statement", r"Marketing\GatewayGuard_ExpertPositioning-2026-07-16.docx",
     "The named exception -- technical audiences. Also states the open-source ban correctly; do not 'fix' it."),
    ("ACBL Pitch Email", r"Marketing\GatewayGuard_ACBL_Pitch-2026-07-16.docx",
     "Outreach draft. Carries its own editorial notes at the end."),
    ("ACBL Marketing Plan", r"Marketing\ACBL Marketing PLan.docx", "Campaign plan."),
    ("Reworked Customer Wording", r"Marketing\Reworked Customer Wording.docx",
     "Customer-facing phrasing pass."),
    ("Family Presentation v3", r"Presentation\GatewayGuard_FamilyPresentation_v3-2026-07-03.pptx",
     "Slide deck. Carries two live PL-4 breaches -- see the header note."),
    # NOT ADDED HERE, and the reason matters more than the entry would.
    # GatewayGuard_CommunityFlyer.docx CANNOT be extracted by this script:
    # measured 2026-08-15, it is not a Word document at all. Its first bytes
    # are "**IS YOUR HOME C", not a ZIP signature -- it is 2,238 bytes of plain
    # Markdown wearing a .docx extension, and doc_text() dies on it with
    # BadZipFile.
    #
    # That mislabelling is the whole reason Cloud has never read the flyer. It
    # was never a scope or sync problem; the text was readable all along.
    # Its twin is therefore written directly as ProjectDocs\
    # GatewayGuard_CommunityFlyer.md rather than extracted through here.
    #
    # If the master is ever renamed to .md and the .docx retired -- which is
    # the right fix and is recommended in that twin -- this comment can go.
]


def doc_text(path):
    out = []
    with zipfile.ZipFile(path) as z:
        names = [n for n in z.namelist()
                 if re.match(r"(word/document|ppt/slides/slide\d+)\.xml$", n)]

        def key(n):
            m = re.search(r"slide(\d+)", n)
            return (0, int(m.group(1))) if m else (1, 0)

        for n in sorted(names, key=key):
            xml = z.read(n).decode("utf-8", "replace")
            xml = re.sub(r"</w:p>|</a:p>", "\n", xml)
            txt = html.unescape(re.sub(r"<[^>]+>", "", xml))
            lines = [re.sub(r"[ \t]+", " ", l).strip() for l in txt.splitlines()]
            lines = [l for l in lines if l]
            if not lines:
                continue
            m = re.search(r"slide(\d+)", n)
            if m:
                out.append(f"**Slide {m.group(1)}**")
            out.extend(lines)
            out.append("")
    return "\n".join(out)


parts = [
    f"<!-- Dated: {STAMP} ET -->",
    "<!-- Editor: Claude Code (CGDELL) -->",
    "<!-- GENERATED from the source documents. Re-generate rather than hand-edit. -->",
    "# GatewayGuard Marketing Source Pack",
    "",
    f"- **Document Name:** GatewayGuard_MarketingSourcePack",
    f"- **Last Modified:** {STAMP} ET",
    "- **Last Editor:** Claude Code (CGDELL)",
    "- **Purpose:** Put the marketing documents where Claude Cloud can read them.",
    "",
    "---",
    "",
    "## WHY THIS FILE EXISTS",
    "",
    "The Cloud connector scope is `ProjectDocs/`, `Tool/`, `WebSite/Rules/` and",
    "`CLAUDE.md`. **`Marketing/` and `Presentation/` are NOT in it**, so Cloud",
    "cannot see any of the documents below. This file carries their text into a",
    "folder Cloud already reads -- no scope change, no capacity cost, no binary.",
    "",
    "**This is a COPY. The documents named below are the originals.** Anything",
    "Cloud proposes must be applied to the original by Claude Code, not here.",
    "",
    "## STATE AS OF THIS FILE -- READ BEFORE PROPOSING ANYTHING",
    "",
    "- **In `Marketing-Notes.md` the open-source violation is CLOSED** -- seven",
    "  references cleared 2026-08-13, and `Marketing-Notes.docx` retired.",
    "  **It is NOT closed across ProjectDocs.** Measured 2026-08-13:",
    "  `GatewayGuard_ProjectNotes-2026-08-09-1435.md` carries 23 hits, of which",
    "  **3 are live violations** -- line 2547 `MARKETING COPY: \"Open source.",
    "  Verifiable. Zero data collected.\"`, line 2741 the pitch line, and line",
    "  3006 *\"they can audit the open source code first\"*. The other 20 are",
    "  third-party tools (NoID Privacy, Hardentools, Notally -- all genuinely",
    "  open-source) or the historical record of the Option A/B decision itself.",
    "  **Do not sweep those 20.** Cloud found line 3006 and was right to.",
    "- **`ExpertPositioning` states the ban correctly** -- *\"GatewayGuard is not",
    "  open-source\"*. That is the rule, not a breach. Do not sweep it.",
    "- **Assisted sessions are already compliant everywhere** -- \"NOT offered at",
    "  launch\", \"planned\", \"(Planned)\", \"on our roadmap\". No fix owed.",
    "- **Two live PL-4 breaches remain, both in the Family Presentation:**",
    "  *\"No competitor offers this\"* (slide 6) and *\"no one else has this",
    "  planned\"* (slide 8). Substitution is *no one else* -> *few competitors*.",
    "- **`Marketing-Notes.md` IS CORRUPTED, and it is not my doing.** The word",
    "  **\"free\" was overwritten with \"an expensive\"** by a find-and-replace that",
    "  ran before the file ever reached git. **measured 2026-08-13:** 9",
    "  occurrences of *an expensive*, against 21 *free* and 16 *Free*, plus an",
    "  orphaned `*ee` fragment and mangled `** **` markup where the replace ran",
    "  through formatting. The flyer now advertises *\"an expensive personal PC",
    "  security guide\"* three lines above *\"100% Free\"* and *\"we never ask for",
    "  money\"*.",
    "  **Not caused by the 2026-08-13 open-source sweep** -- the count was 9",
    "  before that commit, 9 after, and `git log -S` traces it to the initial",
    "  commit of 2026-07-28. **Do not quote any pricing or free-vs-paid wording",
    "  out of this document until it is repaired.**",
    "- **One accuracy problem nobody has raised:** the community flyer text in",
    "  `Marketing-Notes.md` opens *\"Brought to you by independent tech",
    "  volunteers\"*. GatewayGuard LLC is a Maine company selling a product.",
    "  That wording is not defensible and is a bigger exposure than the",
    "  open-source claim was.",
    "- **Slide 8 promises `gatewayguard.co/sources`** -- *\"All marketing claims",
    "  are sourced and verifiable. Links published at gatewayguard.co/sources\"*.",
    "  That page does not exist. Either build it or drop the sentence.",
    "",
    "---",
    "",
]

for title, rel, note in SOURCES:
    p = ROOT / rel
    parts += [f"## {title}", "", f"**Source file:** `{rel}`", f"**Note:** {note}", ""]
    if not p.exists():
        parts += ["*(file not found)*", "", "---", ""]
        continue
    parts += ["```text", doc_text(p).strip(), "```", "", "---", ""]

out = ROOT / "ProjectDocs" / f"GatewayGuard_MarketingSourcePack-{FSTAMP}.md"
out.write_text("\n".join(parts), encoding="utf-8", newline="")
print(f"wrote {out.name}  ({out.stat().st_size:,} bytes)")
