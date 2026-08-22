r"""Extract the 19 guide pages in WebSite\html\ to readable Markdown in ProjectDocs\.

WHY
---
The Cloud connector scope is ProjectDocs/, Tool/, WebSite/Rules/ and CLAUDE.md.

    WebSite/Rules/website-copy.md   IN scope   -- the rule about the copy
    WebSite/html/*.html             OUT of scope -- the copy itself

So Claude Cloud can read the rule that governs the website and cannot read one
line of the website. Every website review it has given was done without the
pages in front of it. Measured 2026-08-15: 19 pages tracked, pushed, 0 unpushed,
and 0 of them reachable by Cloud.

This is the same shape as the guide and marketing packs -- the artifact of
record stays where it lives, and a readable .md goes into ProjectDocs\ where
Cloud can actually reach it. Both of those packs were read by Cloud within the
hour of being pushed.

WHAT IS FAITHFUL AND WHAT IS NOT
--------------------------------
The extracted text keeps the pages' real characters -- curly quotes, em dashes,
the lot. It is NOT ASCII-folded. A pack whose job is "what the pages actually
say" must not quietly say something else; the ASCII rule governs the tool's
console output, not a document. Rewrites carried back to the pages therefore
carry the right characters by default.

THE MATCHER BUGS THIS SCRIPT IS BUILT NOT TO REPEAT (V-2)
---------------------------------------------------------
Gate 25's first version stripped `<b>GatewayGuard</b> Checkup` to a DOUBLE
SPACE, so a two-word match missed it and the Checkup name rule was undercounted
19 -> 3. The fix is not a cleverer tag list: it is replacing every tag with a
single space and then COLLAPSING runs of whitespace, which repairs the fusion
and the split at once.

That collapse has exactly one failure mode -- intra-word markup such as
`Gateway<b>Guard</b>`, which would become "Gateway Guard". So this script
DETECTS that case explicitly and reports it rather than leaving it silent.

Every matcher below is run against a control that must match before any result
is believed. If a control fails, the script exits 2 and writes nothing --
results invalid, per V-2. An absence produced by the matcher is not a finding.

Generated. Never hand-edit; the next run overwrites.
"""

import html
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC_DIR = ROOT / "WebSite" / "html"
OUT_DIR = ROOT / "ProjectDocs"

STAMP = subprocess.run(
    ["powershell", "-NoProfile", "-Command", "Get-Date -Format 'yyyy-MM-dd HH:mm'"],
    capture_output=True, text=True).stdout.strip()
FSTAMP = STAMP.replace(" ", "-").replace(":", "")

# Tags that end a line of reading. Everything else is inline and becomes a
# space, which the collapse then removes if it was not needed.
BLOCK = ("p", "div", "h1", "h2", "h3", "h4", "h5", "h6", "li", "ul", "ol",
         "tr", "td", "th", "br", "section", "header", "footer", "nav",
         "article", "aside", "blockquote", "table", "hr")
BLOCK_RE = re.compile(r"</?(?:%s)\b[^>]*>" % "|".join(BLOCK), re.I)
TAG_RE = re.compile(r"<[^>]+>")
# A tag with a word character hard against it on BOTH sides -- the one case
# the whitespace collapse would corrupt.
INTRAWORD_RE = re.compile(r"\w<[^>]+>\w")

BANNED_WHETHER = re.compile(r"\bwhether\b", re.I)
BANNED_WHEREAS = re.compile(r"\bwhereas\b", re.I)
# Reported alongside the plain word count on purpose. On 2026-08-12 this regex
# returned 3 where the plain count was 5, and the regex answer was reported as
# a word answer. Both numbers ship, every time.
#
# CORRECTED 2026-08-15, and the correction was forced by the control below.
# Gate 25 / the 2026-08-12 report use this pattern:
#
#     \bswitch(es|ed|ing)?\s+(it|them|this|that|the\s+\w+\s+)?(on|off)\b
#
# The object alternatives `it|them|this|that` carry NO trailing \s+, while the
# `the\s+\w+\s+` branch does. So it matches "switch off" and "switch the
# firewall on" and CANNOT match "switch it off" -- the commonest form of the
# banned verb, and the exact phrasing the rule quotes as its example. The
# missing \s+ moved inside the optional group so every branch gets it.
SWITCH_VERB = re.compile(
    r"\bswitch(es|ed|ing)?\s+((it|them|this|that|the\s+\w+)\s+)?(on|off)\b", re.I)
SWITCH_WORD = re.compile(r"\bswitch\w*\b", re.I)
FULL_NAME = re.compile(r"\bGatewayGuard\s+Checkup\b")
BARE_NAME = re.compile(r"\bCheckup\b")
PERMISSION = re.compile(
    r"your permission|your approval|your explicit permission|"
    r"without your|asks you|with your consent|you did not choose", re.I)


def strip_html(markup):
    """Markup -> readable text. Block tags break lines, inline tags vanish."""
    markup = re.sub(r"<!--.*?-->", " ", markup, flags=re.S)
    markup = re.sub(r"<(script|style)\b[^>]*>.*?</\1>", " ", markup,
                    flags=re.S | re.I)
    markup = BLOCK_RE.sub("\n", markup)
    markup = TAG_RE.sub(" ", markup)
    text = html.unescape(markup)
    text = re.sub(r"[ \t\r\f\v]+", " ", text)          # the fusion repair
    text = "\n".join(ln.strip() for ln in text.split("\n"))
    return re.sub(r"\n{3,}", "\n\n", text).strip()


def controls():
    """V-2. Every matcher proves itself on a case that MUST match.

    Returns (failures, how_many_ran). An empty failure list means the results
    below can be believed. The count is returned rather than written down,
    because a hardcoded "10 controls passed" is a pointer that lies the moment
    an eleventh is added -- which is exactly what happened on the first run.
    """
    bad, ran = [], 0

    # The exact fusion that undercounted the name rule 19 -> 3.
    ran += 1
    fused = strip_html("<p><b>GatewayGuard</b> Checkup reviews it.</p>")
    if "GatewayGuard Checkup" not in fused:
        bad.append(f"CONTROL 1 tag-fusion: got {fused!r}")

    # Adjacent inline spans must NOT fuse into one word.
    ran += 1
    split = strip_html('<span class="a">Found:</span><span class="b">Yes</span>')
    if "Found: Yes" not in split.replace("\n", " "):
        bad.append(f"CONTROL 2 span-split: got {split!r}")

    # Entities must decode, and a real page's em dash must survive.
    ran += 1
    ent = strip_html("<p>it&#8217;s on &#8212; blocks it</p>")
    if "’" not in ent or "—" not in ent:
        bad.append(f"CONTROL 3 entities: got {ent!r}")

    # Script and style must leave nothing behind.
    ran += 1
    dirty = strip_html("<style>body{color:red}</style><p>Real text</p>"
                       "<script>var x=1;</script>")
    if dirty.strip() != "Real text":
        bad.append(f"CONTROL 4 script/style: got {dirty!r}")

    # Each banned-word matcher must fire on a sentence built to trip it.
    for name, rx, probe in (
        ("whether", BANNED_WHETHER, "Checkup checks whether it is on."),
        ("whereas", BANNED_WHEREAS, "It is on, whereas the other is off."),
        # Four probes, because the published pattern passed the last two and
        # silently failed the first two. One probe would have shipped the hole.
        ("switch-verb/object", SWITCH_VERB, "You can switch it off yourself."),
        ("switch-verb/them", SWITCH_VERB, "You can switch them on later."),
        ("switch-verb/bare", SWITCH_VERB, "You can switch off the firewall."),
        ("switch-verb/named", SWITCH_VERB, "Switch the firewall on now."),
        ("switch-word", SWITCH_WORD, "Find the switch on that screen."),
        ("full-name", FULL_NAME, "Run GatewayGuard Checkup now."),
        ("permission", PERMISSION, "Checkup asks your permission first."),
    ):
        ran += 1
        if not rx.search(probe):
            bad.append(f"CONTROL {name}: matcher failed its own probe")

    # And the intra-word detector must detect -- and must NOT over-detect.
    ran += 2
    if not INTRAWORD_RE.search("Gateway<b>Guard</b>"):
        bad.append("CONTROL intraword: detector failed its own probe")
    if INTRAWORD_RE.search("<b>GatewayGuard</b> Checkup"):
        bad.append("CONTROL intraword: detector fired on a clean case")

    return bad, ran


def meta_of(markup, name):
    m = re.search(r'<meta\s+name=["\']%s["\']\s+content=["\'](.*?)["\']\s*/?>'
                  % name, markup, re.I | re.S)
    return html.unescape(re.sub(r"\s+", " ", m.group(1)).strip()) if m else ""


def title_of(markup):
    m = re.search(r"<title[^>]*>(.*?)</title>", markup, re.I | re.S)
    return html.unescape(re.sub(r"\s+", " ", m.group(1)).strip()) if m else ""


def dated_of(markup):
    m = re.search(r"<!--\s*Dated:\s*(.*?)\s*-->", markup, re.I)
    return m.group(1) if m else "(no Dated comment)"


NAV_RE = re.compile(r"<nav\b.*?</nav>", re.S | re.I)
FOOTER_RE = re.compile(r"<footer\b.*?</footer>", re.S | re.I)


def chrome_of(markup):
    """The nav and footer blocks, raw."""
    n = NAV_RE.search(markup)
    f = FOOTER_RE.search(markup)
    return (n.group(0) if n else ""), (f.group(0) if f else "")


def headed_body(markup, drop_chrome=True):
    """Body text with h1/h2/h3 promoted to Markdown headings.

    drop_chrome removes the nav and footer, which are byte-identical on all
    pages -- verified before they are dropped, never assumed. Repeating 19
    identical copies would spend Cloud's project-knowledge capacity on
    boilerplate, which is the resource this whole file exists to husband.
    """
    body = re.search(r"<body[^>]*>(.*?)</body>", markup, re.I | re.S)
    inner = body.group(1) if body else markup
    if drop_chrome:
        inner = FOOTER_RE.sub(" ", NAV_RE.sub(" ", inner))

    def mark(m):
        level = int(m.group(1))
        text = strip_html(m.group(2)).replace("\n", " ").strip()
        return "\n\n@@H%d@@%s\n\n" % (level, text)

    inner = re.sub(r"<h([1-6])[^>]*>(.*?)</h\1>", mark, inner,
                   flags=re.S | re.I)
    text = strip_html(inner)
    # Heading level n on the page becomes n+2 here, so page headings sit
    # under this document's own structure instead of competing with it.
    text = re.sub(r"@@H(\d)@@", lambda m: "#" * (int(m.group(1)) + 2) + " ", text)
    return text


def main():
    bad, ran = controls()
    if bad:
        print("V-2 CONTROL FAILURE -- RESULTS INVALID, nothing written:")
        for b in bad:
            print("  " + b)
        return 2

    pages = sorted(SRC_DIR.glob("*.html"))
    if not pages:
        print(f"no .html found in {SRC_DIR}")
        return 2

    rows, sections, intraword_hits, dup_titles = [], [], [], []
    totals = dict(whether=0, whereas=0, sw_verb=0, sw_word=0,
                  full_body=0, full_meta=0, bare=0, perm=0)

    # The chrome is dropped from every page only if it is genuinely the same on
    # every page. Measured, not assumed -- if any page differs, every page keeps
    # its own copy and the header says so.
    chromes = {chrome_of(p.read_text(encoding="utf-8", errors="replace"))
               for p in pages}
    chrome_uniform = len(chromes) == 1
    nav_txt, foot_txt = ("", "")
    if chrome_uniform:
        nav_raw, foot_raw = next(iter(chromes))
        nav_txt, foot_txt = strip_html(nav_raw), strip_html(foot_raw)

    for path in pages:
        markup = path.read_text(encoding="utf-8", errors="replace")

        for m in INTRAWORD_RE.finditer(markup):
            intraword_hits.append(f"{path.name}: {m.group(0)!r}")

        title = title_of(markup)
        desc = meta_of(markup, "description")
        body = headed_body(markup, drop_chrome=chrome_uniform)

        # A <title> is what the browser tab and the Google result show.
        if title.count("GatewayGuard Security Guide") > 1:
            dup_titles.append((path.name, title))

        c = dict(
            whether=len(BANNED_WHETHER.findall(body)),
            whereas=len(BANNED_WHEREAS.findall(body)),
            sw_verb=len(SWITCH_VERB.findall(body)),
            sw_word=len(SWITCH_WORD.findall(body)),
            full_body=len(FULL_NAME.findall(body)),
            full_meta=len(FULL_NAME.findall(desc)),
            bare=len(BARE_NAME.findall(body)),
            perm=len(PERMISSION.findall(body)),
        )
        for k in totals:
            totals[k] += c[k]

        # FT-183: the full name inside <meta description> is invisible to the
        # reader, so it does not introduce anything. Only the body counts.
        name_rule = "OK" if c["full_body"] == 1 else (
            "**0 in body**" if c["full_body"] == 0 else f"**{c['full_body']} in body**")

        rows.append(
            f"| `{path.name}` | {c['full_body']} | {c['full_meta']} | "
            f"{c['bare']} | {c['whether']} | {c['sw_verb']} / {c['sw_word']} | "
            f"{c['perm']} | {name_rule} |")

        sections.append(
            f"\n\n---\n\n## {path.name}\n\n"
            f"- **Page dated:** {dated_of(markup)}\n"
            f"- **Source of record:** `WebSite/html/{path.name}`\n"
            f"- **`<title>`:** {title}\n"
            f"- **`<meta description>`:** {desc}\n"
            f"- **Measured:** full name {c['full_body']} in body / "
            f"{c['full_meta']} in meta - \"Checkup\" {c['bare']} - "
            f"\"whether\" {c['whether']} - \"switch\" {c['sw_verb']} verb / "
            f"{c['sw_word']} word - permission named {c['perm']}\n"
            f"\n### Readable text\n\n{body}\n")

    zero_body = [r.split("`")[1] for r in rows if "in body**" in r and "0 in body" in r]
    over_body = [r.split("`")[1] for r in rows if "in body**" in r and "0 in body" not in r]

    intra = ("**None.** No intra-word markup on any page, so the whitespace "
             "collapse could not have split a word."
             if not intraword_hits else
             "**%d found -- the extraction may have split a word. Check these "
             "by hand:**\n\n%s" % (len(intraword_hits),
                                   "\n".join("- " + h for h in intraword_hits)))

    if chrome_uniform:
        chrome_note = (
            "**The navigation bar and footer are byte-identical on all "
            f"{len(pages)} pages**, measured before either was dropped. They "
            "are printed once below and removed from the individual pages, so "
            f"this file carries them once instead of {len(pages)} times. They "
            "are still copy and still governed by the rules -- they are simply "
            "one piece of copy, not nineteen.\n\n"
            f"**Navigation bar**\n\n```\n{nav_txt}\n```\n\n"
            f"**Footer**\n\n```\n{foot_txt}\n```")
    else:
        chrome_note = (
            "**The chrome is NOT identical across the pages**, so nothing was "
            "dropped and every page below carries its own navigation bar and "
            "footer. That difference is itself worth looking at -- the pages "
            "are meant to share one header and one footer.")

    if dup_titles:
        dup_note = (
            f"**{len(dup_titles)} of the {len(pages)} pages ship a `<title>` "
            "with the site name written twice.** The `<title>` is what the "
            "browser tab shows and what Google prints as the headline of a "
            "search result, so this is visible to every reader who ever finds "
            "the page:\n\n"
            + "\n".join(f"- `{n}` -- {t}" for n, t in dup_titles)
            + "\n\nThe fix is to delete the trailing ` - GatewayGuard Security "
              "Guide` from those six. **Not fixed here** -- this file is "
              "generated and cannot change a page.")
    else:
        dup_note = f"**None.** All {len(pages)} titles are clean."

    head = rf"""<!-- Dated: {STAMP} ET -->
<!-- Editor: Claude Code (CGDELL) -->
<!-- GENERATED by Tool/build_website_sourcepack.py -- do not hand-edit. -->
# GatewayGuard website -- the {len(pages)} guide pages, readable text

- **Document Name:** GatewayGuard_WebsiteSourcePack
- **Last Modified:** {STAMP} ET
- **Source of record:** `WebSite/html/` -- {len(pages)} pages, tracked and pushed
- **Status:** GENERATED extraction. **The `.html` files remain the deploy copy.**
  Rewrite the pages, then re-run this script. Never edit this file.

---

## WHY THIS FILE EXISTS

**measured {STAMP.split()[0]}:** the Cloud connector scope is `ProjectDocs/`,
`Tool/`, `WebSite/Rules/` and `CLAUDE.md`.

| Path | In Cloud's scope | What it holds |
|---|---|---|
| `WebSite/Rules/website-copy.md` | **yes** | the rule governing website copy |
| `WebSite/html/*.html` | **no** | the {len(pages)} pages the rule governs |

So Cloud could read the rule and not one line of the copy. Every website review
it has given was done without the pages in front of it.

All {len(pages)} pages are tracked, committed and pushed with **0 unpushed** --
this was never the "in the folder, not the repo" failure. The repo was fine.
The scope did not reach them. Committing harder does not fix a scope.

**The pages themselves stay where they are.** `WebSite/html/` is the one deploy
copy, established 2026-08-12 out of five competing sets. This file is a reading
copy for Cloud, exactly as `GatewayGuard_GuideV9-SourcePack` is for the Word
guide and `GatewayGuard_MarketingSourcePack` is for the marketing material --
both of which Cloud read within the hour of being pushed.

**Text is faithful, not ASCII-folded.** Curly quotes and em dashes are the
pages' own characters. A pack whose whole job is *what the pages actually say*
must not quietly say something else, and a rewrite carried back to a page then
carries the right characters by default.

## HOW THE EXTRACTION PROTECTS ITSELF -- V-2

Gate 25's first version stripped `<b>GatewayGuard</b> Checkup` into a **double
space**, so a two-word match missed it and the Checkup name rule was
undercounted **19 -> 3**. Every matcher here is run first against a control it
**must** match, and the script **exits 2 and writes nothing** if any control
fails. **{ran} controls passed on this run** -- that number is counted by the
script, not typed, because a hardcoded one goes stale the moment a control is
added.

**The controls caught a live defect in gate 25 on their first run.** The
switch-as-verb pattern published in the 2026-08-12 report and used by
`Run-CopyCheck.bat` is:

```
\bswitch(es|ed|ing)?\s+(it|them|this|that|the\s+\w+\s+)?(on|off)\b
```

The object alternatives `it|them|this|that` carry **no trailing `\s+`**, while
the `the\s+\w+\s+` branch does. So it matches *"switch off"* and *"switch the
firewall on"*, and **cannot match "switch it off"** -- the commonest form of
the banned verb, and the exact phrasing the rule itself quotes as its example
(*"It can switch it off with your permission"*). The pattern here is corrected;
**`Tool\Check-Copy-2026-08-13.ps1` still carries the original and should be
fixed before gate 25 is trusted on this word.** This is the same class as the
3-versus-5 undercount: an absence produced by the matcher.

The whitespace collapse that repairs the fusion has exactly one failure mode:
intra-word markup like `Gateway<b>Guard</b>`, which would become two words.
That case is **detected, not assumed away**.

**Intra-word markup found:** {intra}

## SHARED CHROME -- printed once

{chrome_note}

## A DEFECT THE EXTRACTION FOUND -- duplicated `<title>`

{dup_note}

## MEASURED ACROSS ALL {len(pages)} PAGES

| | |
|---|---|
| "whether" (banned, PL-1) | **{totals['whether']}** |
| "whereas" (banned, PL-1) | **{totals['whereas']}** |
| "switch" as a verb (banned; the noun is allowed) | **{totals['sw_verb']}** |
| "switch" as a plain word, noun included | {totals['sw_word']} |
| "GatewayGuard Checkup" in **visible body** | {totals['full_body']} |
| "GatewayGuard Checkup" in **`<meta description>`** | {totals['full_meta']} |
| "Checkup" alone | {totals['bare']} |
| Sentences naming the user's permission | {totals['perm']} |

**The verb count and the word count are both here on purpose.** On 2026-08-12 a
regex returned 3 where the plain word count was 5, and the regex answer was
reported as a word answer. Two numbers, every time.

### FT-183 -- the Checkup name rule, per page

The rule allows the full name **exactly once per page, on first mention**.
A full name sitting only inside `<meta description>` does **not** count: the
reader never sees it, so the page introduces "Checkup" without ever saying what
it is. That is FT-183, and it is why the body and meta columns are separate.

- **Pages with 0 full names in the visible body:** {len(zero_body) or 0}{" -- " + ", ".join(f"`{p}`" for p in zero_body) if zero_body else ""}
- **Pages with more than one:** {len(over_body) or 0}{" -- " + ", ".join(f"`{p}`" for p in over_body) if over_body else ""}

| Page | Full name (body) | Full name (meta) | "Checkup" | "whether" | "switch" verb/word | Permission named | Name rule |
|---|---|---|---|---|---|---|---|
{chr(10).join(rows)}

## WHAT TO DO WITH THIS FILE

**Reviewing:** read the page text below and check it against
`WebSite/Rules/website-copy.md` (RULE W-07) and the plain-language rules. This
is the first time that check can be made with the copy actually in view.

**Rewriting:** propose the new wording here or in chat. **Claude Cloud cannot
write to the tree** -- Claude Code makes the change in `WebSite/html/*.html`,
which is the deploy copy, and then re-runs this script so the pack and the
pages agree again.

**Do not edit this file to fix a page.** The next run overwrites it and the
website would be unchanged -- the pointer-that-lies failure, in a new hat.
"""

    out = OUT_DIR / f"GatewayGuard_WebsiteSourcePack-{FSTAMP}.md"
    out.write_text(head + "".join(sections) + "\n", encoding="utf-8", newline="")
    print(f"wrote {out.name}  ({out.stat().st_size:,} bytes, {len(pages)} pages)")
    print(f"  {ran} V-2 controls passed")
    print(f"  whether={totals['whether']}  whereas={totals['whereas']}  "
          f"switch verb={totals['sw_verb']} word={totals['sw_word']}")
    print(f"  full name: body={totals['full_body']} meta={totals['full_meta']}  "
          f"Checkup={totals['bare']}  permission={totals['perm']}")
    if zero_body:
        print(f"  FT-183 -- {len(zero_body)} page(s) with NO full name in body: "
              f"{', '.join(zero_body)}")
    if intraword_hits:
        print(f"  WARNING: {len(intraword_hits)} intra-word tag(s) -- "
              f"a word may have been split")
    return 0


if __name__ == "__main__":
    sys.exit(main())
