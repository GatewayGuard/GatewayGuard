<!-- Dated: 2026-08-21 13:05 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Cloud Request -- Review the ascii42 triage, and three business items

- **Document Name:** GatewayGuard_CloudRequest-Review
- **For:** Claude Cloud
- **From:** Claude Code (CGDELL), 2026-08-21
- **How to use:** Bill syncs, then tells Cloud to read this file. No paste.

---

Before answering anything below, open ProjectDocs/CURRENT.md and read
back the four values at the top of it: Generated, Commit at generation,
That commit was made, and Its subject line. If those do not match what
Claude Code last pushed, say so and stop -- your snapshot is stale and
anything you tell me will be built on old files.

Context, so you do not have to guess and must not state any of it from
memory: the current build is ascii42, it was field run on SANDY today,
2026-08-21, and the results are triaged in
ProjectDocs/GatewayGuard_FieldTestTriage-ascii42run1-2026-08-21.md.
Twenty-five findings, FT-204 to FT-228. Do not restate build numbers,
line counts or test results from memory -- read them from that file or
say you cannot see it.

Four things, in the order I care about.

1. REVIEW THE ascii42 TRIAGE.
   This is your proper job -- reviewing a document Claude Code produced.
   You caught two real errors doing this on 2026-08-13. I want the same
   treatment. Specifically:
   - Any finding where the stated cause does not actually explain the
     reported symptom.
   - Any place two findings are the same defect wearing different
     numbers, or one finding is really two.
   - The fix order in section G. Argue with it if you disagree.
   Findings marked "field, unlocated" are ones Claude Code could not
   locate in the source. Do not guess at those -- flag them.

2. PER-BUYER LICENSING OF THE GUIDE. New decision, and it is yours to
   work up. I want every page of the sold guide to carry the buyer's
   name -- "Licensed to John Doe, for personal use only" or better
   wording. Sales are through Gumroad, decided 2026-08-09. Tell me how
   this is done in practice, what it costs, and what it does and does
   not protect. Watermarking a PDF per buyer is the obvious route; tell
   me if there is a better one.

3. ANNUAL UPDATES PRICING. Still open and launch is 2026-09-01, eleven
   days out. Gumroad is settled; the price is not. Lay out the options
   with the reasoning. The audience is American seniors buying for one
   personal PC.

4. TWO BANNED SUPERLATIVES ARE STILL LIVE IN THE FAMILY PRESENTATION.
   Slide 6 says "No competitor offers this" and slide 8 says "no one
   else has this planned". Both breach the unverified-superlatives ban.
   Slide 8 also promises gatewayguard.co/sources, which does not exist.
   Rewrite the two claims so they say something true and still sell, and
   tell me what to do about the promised page -- build it or cut the
   reference.

Anything you produce, I have to download and Claude Code has to commit.
You cannot write to the repository. If a decision ends up only in this
chat, say so explicitly.

