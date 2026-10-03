<!-- Dated: 2026-08-25 16:20 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Everything waiting on Bill — one list, 2026-08-25

- **Document Name:** GatewayGuard_DecisionsForBill
- **Last Modified:** 2026-08-25 16:20 ET
- **Replaces:** `GatewayGuard_DecisionsForBill-2026-08-24-1033.md`. **Eleven of
  its fourteen items are closed.** The three that are not are carried below
  with their original numbers noted, so nothing was quietly dropped.
- **Launch target:** 2026-09-01. **Seven days.**

---

## HOW TO USE THIS

**Nine items. Four are jobs, not decisions — nobody has to think, someone has
to click. Four need one word from you. One is a build day.**

**Read section A first. Item 1 blocks everything else on the store, and it
takes ten minutes.**

---

# A. JOBS — NO DECISION REQUIRED, JUST DO THEM

## 1. CONNECT THE GUMROAD PAYOUT METHOD ★ BLOCKS LAUNCH

**Your own Gumroad page says it:** *"You haven't connected a payout method yet,
so you won't be able to publish this product for sale."*

**Nothing publishes until this is done.** Not Checkup, not the Guide. **It was
on no list until yesterday**, which is how a ten-minute task ends up seven days
from launch. **Do it first.**

## 2. SET BOTH REFUND TOGGLES TO 30 DAYS

**Settings → "Specify a refund policy for this product."** ***It is per-product,
not account-wide*** — settled from your own screenshots, which resolved a
contradiction the 22 August decision document could not.

**Two products, two toggles. Doing one is the failure mode here.**

Wording for both is written and ready to paste:
`GatewayGuard_GumroadListings-2026-08-25-0015.md`.

## 3. BUY YOUR OWN PRODUCT, WITH A REAL CARD, THEN REFUND IT

**Nobody has ever bought anything from our store. Not once.**

So we do not know the payment goes through. We do not know the download reaches
the buyer's email. We do not know the refund button does what it says.

***CORRECTED 2026-09-02 -- DO NOT DO THIS.*** This item said to use a real
card. ***sourced, Gumroad Help Center:*** charging your own card for your own
product *"appears exactly the same as money laundering to our security systems,
and your account may be automatically suspended as a result."* **Use Gumroad's
test purchase instead** -- stay logged in and the checkout substitutes a test
card. Procedure: `GatewayGuard_GumroadTestPurchase-2026-09-02-1040.md`

**The reason the test still matters is unchanged. If something is broken, we
want to be the ones who find it -- not the first person who trusts us with
$19.99.**

## 4. UN-PAUSE WINDOWS UPDATE ON BOTH MACHINES *(was item 1, 24 Aug)*

**Still open.** Neither machine has been patched since 1 August. **Every field
run since then has been on an unpatched PC**, which means every "this is how
Windows behaves" measurement carries an asterisk.

---

# B. DECISIONS — ONE WORD EACH

## 5. HOW DOES A BUYER ACCEPT THE LICENCE? ★ THE ONE WITH A DEADLINE

***measured on ascii43:*** the words **"license agreement"**, **"EULA"**,
**"terms of use"**, **"accept the terms"** and **"I agree"** appear **nowhere in
Checkup**. ***measured:*** **no page on the website carries the agreement.**

**Nobody is ever shown it, and nobody ever accepts it.**

It has been on the plan since 24 July as five words — *"EULA posted"* — marked
CRITICAL. **Posted is not accepted.**

**Why this one has a deadline the others do not:** if the answer is *"a screen
in Checkup on first run"*, **that is a build change and the build freezes this
week.** If the answer is *"a link in the Gumroad receipt"*, it costs nothing and
can happen on 31 August.

**So the decision has to come before tomorrow's build, not after it.**

**My recommendation: the receipt link plus a licence page on the site, and no
build change.** Cloud is researching what actually binds a buyer in the US
(question A1 of its brief). **If you want the option kept open, say so tomorrow
morning and the screen goes in with the rest of ascii44.**

## 6. THE TWO NOTES YOU TYPED INTO THE LICENCE FILE

**Your v2.2 `.docx` is still open in Word.** I read a copy — it would not open
directly. **Four instructions are typed into it. Two are applied; two I would
not guess at:**

| Your note | Why I stopped |
|---|---|
| *"No bundles initially — remove mention of them just make sure it covers all sold copies."* | It is attached to the **refund** entry. Does "bundles" mean the **Checkup + Guide bundle**, or the **multi-PC packs**? The two read completely differently in Section 9 |
| *"Remove"* — after the programs-review entry | Remove **Section 7 itself**, or remove **that change-log entry**? **I am not deleting a whole section of a contract on the strength of one word in a margin** |

**Applied without asking:** *"We will reissue for a small fee"* and *"Say MS may
change"*. Both unambiguous.

## 7. WHAT IS THE LICENCE-MOVE FEE?

Follows from your own note. **The amount is not in the contract and should not
be** — prices in a contract have to be amended like a contract. **It goes on
gatewayguard.co.**

**What it has to survive:** a widow with a dead laptop. **Cloud is researching
what comparable vendors charge** (question B7). **You can wait for that.**

## 8. `C:` ON CGDELL — CLOSED, RECORDED HERE SO IT STAYS CLOSED *(was item 2, 24 Aug)*

**Your instruction, 2026-08-24:** *"don't ever remove any they are all saved and
safe in print and two digital storage devices."*

**No recovery key protector is ever removed, on any machine. It will not be
proposed again and it will not be asked about again.** Written to permanent
memory as well as here.

---

# C. THE BUILD

## 9. ascii44, TOMORROW

**ascii43 is unfinished and has never been field run.** That is the largest
untested thing between here and 1 September.

| Task | Note |
|---|---|
| **F4 — full scan after the offline scan** | **Unblocked** by your Q2 decision: run it, with approval |
| **F6 wording block** | Not built |
| **F5 remnants** | Not built |
| Setting 1 — pause detection | From Q8 |
| Setting 14 — three-way choice + the Revert string | Your design, 24 Aug |
| Setting 6 — rename | Item 6, 24 Aug |
| **Gates 12 / 12b / 24 / 25, then increment** | Five build-ID locations |

**Nineteen settings. Frozen.** Candidates for later are parked in
`GatewayGuard_FutureSettings-2026-08-24-2310.md`.

---

## WHAT IS DONE AND NEEDS NOTHING FROM YOU

- **Licence v2.4 built** — binding stays, Section 12 added, corrections free,
  components and log ownership named, third parties disclaimed. Master and
  readable twin both committed.
- **The Gumroad listing corrected** — it promised *"free updates within the same
  version"*, which the licence did not grant. **I wrote that. v2.4 now grants
  it, so the store and the contract agree.**
- **The invented attribution corrected** in the consult notes — you said *"not a
  good idea"*; the attorney only said test it against FTC section 5.
- **Cloud is synced and working**, on fourteen research questions with
  acceptance mechanics first.
- **Website review closed** — all 19 pages, items 2, 3, 9 and 17.
- **Repo health: ALL CLEAR.** No conflict copies, nothing unpushed.

---

## THE ORDER I WOULD DO IT IN

**Tonight, twenty minutes total:** item 1, then item 2, then item 3.

**Tomorrow morning, before the build starts:** item 5. **One sentence from you
decides whether ascii44 gains a screen.**

**Tomorrow, all day:** item 9.

**When Cloud reports back:** items 6 and 7.
