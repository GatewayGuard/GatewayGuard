<!-- Dated: 2026-08-21 14:45 ET -->
<!-- Editor: Claude Cloud -->
# GatewayGuard -- Pricing / renewal copy for the website

- **Document Name:** GatewayGuard_PricingCopy-Draft
- **Last Modified:** 2026-08-21 14:45 ET
- **Last Editor:** Claude Cloud
- **Status:** Draft copy, ready for Claude Code to apply. Not yet applied.
- **Answers:** `GatewayGuard_CloudRequest-PricingCopy-2026-08-21.md`
- **Prices used:** `PricingReconciliation-2026-07-16.md` for the one-time
  packs; the annual update price is **$12.99, locked by Bill 2026-08-21** --
  see `GatewayGuard_PriceDecision-Annual-2026-08-21-1445.md`.

**Change History Log:**
- 2026-08-21 14:45: Created. Written against the freshness stamp
  `58e7ee0` / generated 2026-08-21 14:18 ET. **No `[[ANNUAL]]` token
  survives** -- the price was locked before this was filed. The multi-year
  pre-pay block is deliberately absent; see section 4.

---

## 1. THE NUMBERS, AND WHERE THEY CAME FROM

**One-time packs -- *sourced*, `PricingReconciliation-2026-07-16.md`, FINAL
2026-06-26:** $19.99 / $34.99 / $49.99 / $79.99 for 1, 3, 5 and 10 PCs.

**Annual update, one PC -- *sourced*, locked by Bill 2026-08-21:** $12.99.

**Annual update, multiple PCs -- *derived*, by Bill's instruction of
2026-08-21:** take the discount already built into the one-time packs and
apply the same percentage to $12.99.

| PCs | Buy once | Off the 1-PC rate | Same % on $12.99 | Price used |
|---|---|---|---|---|
| 1 | $19.99 | -- | $12.99 | **$12.99** |
| 3 | $34.99 | 41.7% | $22.74 | **$22.99** |
| 5 | $49.99 | 50.0% | $32.48 | **$32.99** |
| 10 | $79.99 | 60.0% | $51.96 | **$51.99** |

The 3- and 5-PC rows round up to a .99 ending, which costs about one point of
discount each. The 10-PC row lands on 60.0% exactly.

---

## 2. THE COPY -- each block labelled by its location in section 2 of the request

### INDEX -- `Index-Builds/GatewayGuard_index-2026-08-02-2050.html`
### (and the same content in `GatewayGuard_index-2026-07-21-1625.html`)

**meta description (~17)**

> GatewayGuard Checkup makes your Windows 11 PC safer, one plain question at
> a time. $19.99 once, yours to keep. Yearly updates optional.

**hero subhead (~631)**

> Buy it once. Keep it for good. No jargon, no surprises.

**hero note (~637)**

> $19.99, once - yours to keep - yearly updates optional

**body, source-code half (~708)**

> The full source is included and readable, so you can check exactly what it does.

**feature bullet (~735)**

> Keeps working for good, even if you never buy another update

**pricing section (~800) -- replaces the whole paragraph**

> **What it costs**
>
> **Buy it once.** $19.99 for one PC. It is yours to keep, and it keeps working.
>
> **Windows changes every year.** Microsoft moves security settings, adds new
> ones, and retires old ones. The yearly update is a refreshed Checkup that
> keeps pace - $12.99 a year for one PC. It is optional.
>
> **Your copy never expires.** If you skip a year, nothing stops working. You
> keep the version you have for as long as you want it.
>
> **More than one PC**
>
> | PCs | Buy once | Yearly update (optional) |
> |---|---|---|
> | 1 | $19.99 | $12.99 |
> | 3 | $34.99 | $22.99 |
> | 5 | $49.99 | $32.99 |
> | 10 | $79.99 | $51.99 |
>
> Covering more PCs costs less per PC, and the same savings carry over to the
> yearly update.

**nav / CTA strip (~803)**

> Readable source included

---

### DOWNLOAD PAGE -- `Index-Builds/download-2026-08-04-0932.html`

**meta (~15)**

> Download GatewayGuard Checkup. $19.99 once, yours to keep. Yearly updates
> optional. Readable source included, so you can check exactly what it does.

**plans block**

> **$19.99, once.** One PC. Yours to keep, and it keeps working.
>
> **Yearly update: $12.99 a year, optional.** Windows security changes every
> year; the update keeps Checkup current. Skip it and nothing breaks - you keep
> the version you have.
>
> Covering 3, 5, or 10 PCs costs less per PC. Prices are on the main page.

**footer (~181) -- NOT WRITTEN, on purpose**

The instruction is *"align to the new footer line."* The corrected footer text
is not visible from Cloud's side, and writing a footer from a description of it
is how a wrong line gets shipped. **Claude Code should copy the footer line
already applied to the guide pages, verbatim.**

---

## 3. HOUSE-RULE CHECK

| Rule | Result |
|---|---|
| No "whether" or "whereas" | Neither word appears in any block above |
| "switch" never used as a verb | Does not appear |
| Full name on first mention, then "Checkup" | Index: full name in the meta description, "Checkup" after. Download page: full name in the meta, "Checkup" after. **Each file gets its own first mention** -- do not shorten either meta |
| "open-source" banned | Not used. The footer's phrasing is matched word for word |
| Every money claim true under the new model | The two false lines (feature bullet ~735, pricing paragraph ~800) are replaced, not softened |
| No dead ends | The download page points to the main page for pack prices rather than dropping the reader |

---

## 4. WHAT IS STILL OPEN

1. **Do the multi-PC packs belong in the launch site at all?** They are
   confirmed products, so they are written in. If the site sells single copies
   only on 2026-09-01, Claude Code cuts the "More than one PC" table and the
   last line of the download plans block. Nothing else depends on them.
2. **Multi-year pre-pay is not written.** Section 5 item 3 of the request
   records two readings of "10% per year" -- flat, or deepening with the term
   -- and asks Bill for one. Bill's 2026-08-21 instruction covered copies, not
   years, so that decision is untouched. **A block written under the wrong
   reading would be customer copy carrying a wrong price.**

---

## 5. WHAT CLAUDE CODE DOES WITH THIS

Apply each labelled block to the file named above it, then commit. Cloud
cannot write to the repository. The footer at download ~181 is the one block
that needs a value from the repository rather than from this file.
