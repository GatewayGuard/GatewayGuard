<!-- Dated: 2026-08-21 14:05 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Cloud Request -- Rewrite the pricing / renewal copy across the site

> **READ ORDER: 3 of 3.** Read after
> `GatewayGuard_CloudRequest-Review-2026-08-21.md` (1 of 3) and
> `GatewayGuard_CloudRequest-GuideRewrite-2026-08-21.md` (2 of 3). All pricing
> work lives HERE -- doc 1 only points to it. This one may wait on Bill's
> price decisions (section 5); draft the structure, leave the numbers as
> tokens.

- **Document Name:** GatewayGuard_CloudRequest-PricingCopy
- **For:** Claude Cloud
- **From:** Claude Code (CGDELL), 2026-08-21, on Bill's instruction
- **How to use:** Bill syncs, then tells Cloud to read this file and write the copy.
- **Lane:** this is marketing substance -- Cloud's job. Claude Code has mapped
  every location and specced the structure; Cloud writes the words; Bill locks
  the prices; Claude Code applies Cloud's copy to the files.

---

Before anything else, read back the four freshness values at the top of
`ProjectDocs/CURRENT.md` and confirm they match what Claude Code last pushed.
If they do not, say so and stop.

## 1. THE DECISION BILL MADE, 2026-08-21

The old site said **"No subscription -- ever"** and **"no renewal, no upsell."**
That was wrong and is being replaced. The real model:

- **The tool is a one-time purchase.** $19.99, you own it, it keeps working.
  (This number is established.)
- **Annual updates exist and are a paid, optional product.** Each year
  Microsoft changes Windows security; the annual update is a refreshed Checkup
  that keeps pace. Frame it as a benefit -- "stay current with Windows'
  yearly changes" -- not as a fee they are stuck with.
- **Renewals are offered as plans on the website.** A buyer can take a
  **one-time (single-year) renewal**, or **pre-pay several years** at a
  discount. Multi-year plans get a discount (Bill: "10% per year").
- **The base purchase never expires.** Skipping updates does not break the
  tool. Say this plainly -- it is the reassurance that makes the paid update
  feel optional rather than coerced.

**So: remove every "no subscription / no renewal / no ongoing fees / no
upsell" claim, and replace it with honest, friendly copy about the one-time
purchase plus optional annual updates and renewal plans.**

## 2. WHAT TO REMOVE -- exact strings and locations

All in `WebSite/` (the site the guide pages link to as `/` and `/guide/`).
The footer's two lines are ALREADY fixed -- do not touch the footer.

**Index** (`Index-Builds/GatewayGuard_index-2026-08-02-2050.html`, and the
same content in `GatewayGuard_index-2026-07-21-1625.html`):

| Line | Current text | Action |
|---|---|---|
| meta description (~17) | "One-time purchase, no subscription." | replace -- see 4 |
| hero subhead (~631) | "No subscription. No jargon. No surprises." | replace |
| hero note (~637) | "$19.99, once - ... - No subscription" | replace |
| body (~708) | "The source code is included ... so you can see exactly what it does." | reword source half to match the footer's "readable, so you can check exactly what it does" |
| feature bullet (~735) | "Does not require a subscription, renewal, or ongoing fees" | **replace -- this one is now false** |
| pricing paragraph (~800) | "$19.99, once. No subscription, no renewal, no upsell." | **replace -- this one is now false** |
| nav/CTA strip (~803) | "... - Source code included" | reword to "Readable source included" |

**Download page** (`Index-Builds/download-2026-08-04-0932.html`):

| Line | Current text | Action |
|---|---|---|
| meta (~15) | "One-time purchase, no subscription. Source code included..." | replace |
| footer (~181) | "... No subscription." | align to the new footer line |

**Guide pages (19), guide-index, footer everywhere:** already corrected. Leave.

## 3. THE RENEWAL / PLAN STRUCTURE TO PRESENT

Write this as a small, clear plans block on the **index** (pricing section)
and on the **download page**. Consumer-friendly, no jargon, senior-readable.

- **Buy once:** $19.99. Yours to keep. Works forever.
- **Keep it current (optional):** the annual Checkup update, priced per year.
- **Renewal plans:**
  - **1 year** -- single renewal.
  - **Multi-year** -- pre-pay 2, 3, 5, or 10 years and save.
  - **Discount:** Bill's rule is "10% per year" for multi-year plans.

**PLACEHOLDERS -- do not invent numbers.** Write the copy with these tokens
and Bill fills them, OR Bill gives them to you before you write:

- `[[BASE]]` = $19.99 (this one is fixed)
- `[[ANNUAL]]` = annual update price -- working number was $12.99, **NOT
  LOCKED**
- `[[TIERS]]` = the exact multi-year bundles and their prices, from Bill

**Say what you cannot yet say.** Where a price is not locked, write the
structure and leave the token visible rather than guessing -- a guessed price
in customer copy is worse than a blank.

## 4. HOUSE RULES -- every word

- Never use "whether" or "whereas" (use "if"); never "switch" as a verb for a
  setting.
- First mention "GatewayGuard Checkup", then "Checkup".
- No jargon -- delete it, do not explain it. No dead ends.
- **"open-source" is banned.** For the code: "the full source is included and
  readable, so you can check exactly what it does" -- the phrasing now in the
  footer. Match it.
- Every claim about money must be true under the model in section 1. If a line
  cannot be made true, cut it.
- Deliver as Markdown (the copy, with each block labelled by its location from
  section 2), so Claude Code can drop each piece into the right file. You
  cannot write to the repository yourself.

## 5. THE DECISIONS BILL MUST LOCK BEFORE THIS GOES LIVE

List these back to Bill; do not resolve them yourself:

1. **The annual update price** (`[[ANNUAL]]`). Working number $12.99, never
   locked. This is open item 12 in the briefing.
2. **The exact multi-year bundles and their prices** (`[[TIERS]]`) -- which
   terms (2, 3, 5, 10, others), and the price of each.
3. **How "10% per year" applies** -- Bill said "10% per year for two and for
   3-5 and for 10." Two readings, and Cloud needs ONE to build a table:
   - **Flat:** every multi-year plan is 10% off the yearly price, per year.
   - **Deepening:** the discount grows with the term (e.g. 10% at 2 yr, more
     at 5, more at 10).
   Ask Bill which, and get the exact percentages if deepening.
4. **Whether "annual" is the right cadence** or it should read "when Windows
   changes" -- affects whether the word "annual" appears at all.

## 6. WHERE THE WORDING GOES -- summary for "what to write where"

| Piece Cloud writes | Goes into |
|---|---|
| One-line value prop (replaces "no subscription" hero) | index hero subhead + note; meta descriptions |
| The plans block (buy once / annual / multi-year) | index pricing section; download page |
| Reworded source-code sentence | index body (~708); nav strip (~803); download meta |
| Footer | ALREADY DONE -- do not rewrite |

Hand the finished copy back as one Markdown file. Claude Code applies each
labelled block to its file and commits.
