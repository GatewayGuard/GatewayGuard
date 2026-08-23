<!-- Dated: 2026-08-22 10:00 ET -->
# Pricing and renewal copy — every block, ready to apply

- **Document Name:** GatewayGuard_PricingCopy
- **Last Modified:** 2026-08-22 10:00 ET
- **Last Editor:** Claude.ai (Cloud)
- **Answers:** `GatewayGuard_CloudRequest-PricingCopy-2026-08-21.md` (read order 3 of 3)
- **Status:** Finished copy. Claude Code applies each labelled block to its file and commits.
- **Written against freshness stamp:** `95dc545`, generated 2026-08-21 14:30 ET

**Change History Log:**

- 2026-08-22 10:00: Created. **`[[ANNUAL]]` is closed** — $12.99 locked by Bill
  2026-08-21, per `GatewayGuard_PriceDecision-Annual-2026-08-21-1445.md`, so
  every block below carries a real price. **`[[TIERS]]` is still open**, so the
  multi-year copy sits in section 5 as held copy and **must not go live**.

---

## 1. WHAT IS READY AND WHAT IS NOT

| | State |
|---|---|
| `[[BASE]]` — $19.99 | Fixed. Used throughout |
| `[[ANNUAL]]` — **$12.99/yr, 1 PC** | **Locked 2026-08-21.** Also $22.99 for 3, $32.99 for 5, $51.99 for 10 — derived, not separately decided |
| `[[TIERS]]` — multi-year pre-pay | **Still open.** Section 5 is written and held. Nothing in sections 2 to 4 mentions multi-year |

**Section 5 does not ship.** The plan amendment is explicit: no marketing copy
can mention multi-year plans until the flat-versus-deepening reading of "10%
per year" is settled. The copy is written so that it is ready the day it is.

**Every block below is true under the current model with nothing pending.**

---

## 2. INDEX — `Index-Builds/GatewayGuard_index-2026-08-02-2050.html`

Apply the same content to `GatewayGuard_index-2026-07-21-1625.html`.

### 2a. Meta description — line ~17

```
Check the security settings on your Windows 11 PC in about twenty minutes. Plain English, no jargon. $19.99 once, yours to keep.
```

### 2b. Hero subhead — line ~631

```
Plain English. No jargon. No surprises.
```

**Note.** This keeps the rhythm of the line it replaces and drops only the
claim that is now false. "No jargon" and "no surprises" both remain true and
both are things the product actually delivers.

### 2c. Hero note — line ~637

```
$19.99, once. Yours to keep, and it keeps working.
```

### 2d. Body — line ~708

Reword the source half to match the footer.

```
The full source is included and readable, so you can check exactly what it does before you run it.
```

### 2e. Feature bullet — line ~735

Replaces *"Does not require a subscription, renewal, or ongoing fees."*

```
Your copy never expires. Yearly updates are offered and entirely optional.
```

### 2f. Pricing paragraph — line ~800

Replaces *"$19.99, once. No subscription, no renewal, no upsell."*

```
$19.99, once. You own it, and it goes on working for as long as you want to use it.
```

### 2g. Nav / CTA strip — line ~803

```
Readable source included
```

---

## 3. THE PLANS BLOCK — index pricing section

Drop in below the pricing paragraph at ~800.

```
Buy it once — $19.99

You own your copy. It keeps working. There is nothing to renew and
nothing that stops.

Keep it current — $12.99 a year, and only if you want to

Microsoft changes how Windows security works most years. The yearly
update is a refreshed GatewayGuard Checkup that keeps pace with those
changes.

It is entirely optional. Skipping a year does not switch anything off
and does not expire your copy — the version you own carries on doing
exactly what it did the day you bought it.

More than one PC

                      Buy once      Yearly update, optional
  1 PC                $19.99        $12.99
  3 PCs               $34.99        $22.99
  5 PCs               $49.99        $32.99
  10 PCs              $79.99        $51.99
```

**Why the reassurance sits between the two prices rather than after them.** The
sentence a cautious buyer needs is that skipping the update costs them nothing.
Putting it after the table means they have read four prices before they reach
it.

---

## 4. DOWNLOAD PAGE — `Index-Builds/download-2026-08-04-0932.html`

### 4a. Meta — line ~15

```
GatewayGuard Checkup for Windows 11. $19.99 once, yours to keep. The full source is included and readable, so you can check exactly what it does.
```

### 4b. Footer — line ~181

Align to the corrected footer line already live elsewhere.

```
One-time purchase, yours to keep. Annual updates are optional.
```

### 4c. Plans block

Use the block from section 3 unchanged.

---

## 5. HELD — multi-year copy. DO NOT PUBLISH

**Blocked on `[[TIERS]]`.** Two decisions are outstanding: which terms exist,
and how "10% per year" applies. Nothing here goes live until both are settled
and the numbers are filled in.

```
Pre-pay and save

If you would rather not think about it each year, you can pay for
several years at once and pay less per year.

  1 year                          $12.99
  [[TERM]] years                  [[PRICE]]     (saves [[SAVING]])
  [[TERM]] years                  [[PRICE]]     (saves [[SAVING]])

Whichever you choose, your copy of Checkup never expires. A plan
covers the yearly updates, not the tool itself.
```

**The last sentence is the one that has to be there.** A pre-paid multi-year
plan is the point at which a buyer starts to wonder if they have signed up to
something. The answer is that they have not, and it should be on the same
screen as the prices rather than a click away.

**Two words in that block need checking against house rules when it ships.**
*"Whichever"* is fine. If the final wording reaches for *"whether"*, it must be
rewritten with *"if"*.

---

## 6. WHAT I DID NOT CHANGE, AND WHY

- **The footer.** Already corrected. Section 2 of the request says do not touch it, and I have not.
- **The nineteen guide pages, the guide index, and the footer everywhere else.** Already corrected on 2026-08-15.
- **Anything mentioning multi-year plans.** Held in section 5.
- **`WebSite/html/diagnostic-data.html`.** Out of scope here. *(The W-07 collision this line used to claim was closed 2026-08-23 — the website says "Select Required diagnostic data" and the guide says "Choose Required", which agree.)*

---

## 7. STILL OPEN FOR BILL

**Two of the four decisions from the request are now closed.** These are not.

1. **The multi-year terms and their prices** (`[[TIERS]]`) — which terms exist, and what each costs.
2. **How "10% per year" applies** — flat 10% off the yearly price on every multi-year plan, or a discount that deepens with the term. One reading only; I cannot build the table from both.
3. **Is "annual" the right cadence**, or should it read "when Windows changes"? Every block above uses *yearly* and *a year*. If the cadence changes, sections 2e, 3 and 4 all change with it.
4. **The refund policy.** Not raised in the pricing request, and it belongs here anyway: the plans block is the first place on the site that asks a buyer for money more than once. `ReviewOfCloudDrafts-2026-08-18.md` calls this the only genuine store blocker, and it is still open.

---

## 8. FOR THE GREP, BEFORE ANY OF THIS IS APPLIED

`PriceDecision-Annual` is explicit that its edit list is not complete. Search
`ProjectDocs\` and `WebSite\` for these before committing:

```
no subscription
No subscription
no renewal
ongoing fees
no upsell
open source
open-source
9.99/year
$9.99 - $14.99
price TBD
```

**The one that matters most is `9.99/year`** — it is the wrong price and it is
written as customer copy, in `GatewayGuard_ProjectNotes-2026-08-09-1435.md`.
