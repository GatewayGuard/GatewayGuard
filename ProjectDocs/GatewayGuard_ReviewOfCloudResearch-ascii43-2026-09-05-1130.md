<!-- Dated: 2026-09-05 11:30 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Cloud's ascii43 research -- what I checked, and what it changes

- **Document Name:** GatewayGuard_ReviewOfCloudResearch-ascii43
- **Answers:** `GatewayGuard_CloudResearch-ascii43-2026-09-05-0018.md`
- **For:** Bill
- **Status:** Response. Decides nothing. Three items need your ruling and
  they are in `GatewayGuard_DecisionsForBill-2026-09-05-1130.md`.

---

## THE SHORT VERSION

**The research is good and most of it is usable.** The password work, the
two-step sign-in work, and the encryption-scope answers are all properly
sourced to Microsoft, NCSC, CISA and NIST, and they settle questions you have
been carrying for weeks. **Item 18 and item 19 are flat answers with a
standard behind them** -- you noticed a real mechanism, and it is documented.

**But three of its build recommendations are for work that is already in the
build.** I opened the source and read each one. If we had taken the plan as
written we would have spent an ascii44 slot rebuilding what shipped in ascii33
and ascii39, and one of the three would have made the product worse.

**That is not Cloud being careless.** It reads the repository through a search
that returns fragments, not whole files, so it cannot see a function it did not
happen to retrieve. I have written the fix into the note going back to it.

---

## THE THREE THINGS ALREADY BUILT

### 1. Reading Tamper Protection directly -- already the primary method

Cloud recommends reading Windows' own `IsTamperProtected` value instead of
guessing from a blocked registry key.

***Measured, ascii43 source, lines 5647-5666:*** that is already exactly what
Checkup does. The function tries `IsTamperProtected` first, falls back to the
registry only if that throws, and reports "Unknown" only when both fail. The
comment beside it records it as a field fix from ascii33, verified True on the
Dell.

**What is genuinely new and worth building:** the *order*. Tamper Protection
should be settled before anything else runs, and after you fix it by hand
Checkup should read it again rather than carry the old answer. That part is
real and it is in the ascii44 plan.

### 2. Turning off the automatic fix for setting 6 -- would make it worse

Cloud recommends marking setting 6 (Edge Phishing Protection) as something
Checkup cannot change automatically.

***Measured, lines 6389-6410:*** Checkup writes the four values with the
error-trap switched on, and catches the specific "permission denied" error to
fall back to on-screen manual steps. **So on a PC where the write is allowed,
it works, automatically, today.** Marking it manual-only would switch off a
path that succeeds and hand every customer a manual chore they did not need.

**Why Cloud got there:** it measured that the *read* is blocked on both
machines, then reasoned to the *write*, and labelled that step "near-certain,
not measured." The recommendation rests on the unmeasured half. **The measured
half is in the file** -- the code already knows the difference between the two
cases.

**What is genuinely new:** the wording. When the write really is blocked,
Checkup should say *why* -- "Tamper Protection is on, which is correct, and it
blocks this" -- instead of leaving the customer with a bare "manual required."
Cloud's instinct there is right and I am building it.

### 3. Making the password setting conditional -- it has been conditional since ascii39

Cloud recommends that setting 15 stop turning Edge password saving off unless
the customer has a separate password manager.

***Measured, lines 6665-6689 and 6476-6490:*** Checkup asks *"Do you use a
password manager -- a separate app such as Bitwarden, 1Password, or KeePass?"*
**before** the checklist. If the answer is no, setting 15 is deselected, left
on, and the log records why. The website page says the same thing and is
accurate.

**So Cloud's question to you -- "is making setting 15 conditional inside the
nineteen-settings freeze?" -- does not need an answer. Nothing changes.**

---

## WHAT SURVIVES, AND IT IS THE MAJORITY

**These are sourced, they do not exist in the build, and they are worth
having:**

| Cloud's item | What it gives us | Where it goes |
|---|---|---|
| 7 -- PUA blocking | Defender only catches nuisance software when this is on. Checkup never reads it. **This is the single biggest gap the research found.** | Tool, before any scan |
| 8 -- signature age | A scan with week-old definitions prints a clean result that means nothing | Tool, before the scan gate |
| 8 -- the mode screen | Real, and I confirmed it (below) | Your decision |
| 3-5 -- Windows Update | Check and tell the customer; do not try to install. I agree, and so does the record | Tool + one guide paragraph |
| 13-19 -- passwords and two-step sign-in | Properly sourced, and it corrects advice we would otherwise have given wrong | Guide |
| A -- USB drives | Microsoft's own words. **Already applied to the website today** | Website done, tool waits on a measurement |
| B -- local vs Microsoft account | Microsoft's own words. **Already applied to the website today** | Website done, tool waits on your call |
| 9-12 -- Malwarebytes | The plan to settle it is sound, and it is one afternoon | Your decision, after the test |

### The mode screen -- I checked this one and Cloud is right

***Measured, lines 8064-8073:***

```
  [1] CONSOLE MODE
  [2] GUI MODE
      Opens a visual window with checkboxes and color-coded
      status indicators. Recommended for first time users.
```

***And measured, the build's own header at line 642:*** *"KNOWN GAP, flagged
not hidden: Run-GUIMode (mode 2) has never been inventoried. Every field log
to date is mode 1."*

**So the screen recommends to first-time users the one path that has never
been field tested, never been screen-numbered, and appears in no checklist.**
The build already knows this and says so in a comment nobody reads at
runtime. This is a launch item, not a nice-to-have, and it is question 1 for
you.

---

## THE ONE PIECE OF CLOUD'S RESEARCH I WOULD NOT ACT ON YET

**Items 13-14, the password-manager advice, are sourced and I think correct --
and they collide with what the product says.** NCSC's position is that a
browser password manager is a very good choice for someone on one PC with a
PIN, which is our customer exactly. Our page and our screens present it as a
single point of failure and push a dedicated manager.

**The behaviour is already right** (nothing is turned off unless they have a
manager). **The reasoning we print is what is out of step.**

I have not touched a word of it. It is customer-facing copy on a frozen
setting, it is your judgment and not mine, and it is question 5.

---

## WHAT I ANSWERED FOR CLOUD SO IT DOES NOT HAVE TO ASK YOU

Cloud held five questions to the end. **Two of them I settled from the
repository this morning, so they are off your list:**

- **"Does the licence name Malwarebytes?"** ***Measured:*** yes, three times
  in Cloud's own v3.1 draft -- twice in Section 8's other-companies paragraph
  and once in the trademark line. If Malwarebytes leaves the product, those
  three sentences leave in the same edit.
- **"Is setting 15 conditional inside the freeze?"** Moot. Already built.

**Three still need you**, and they are in the questions document.

---

## WHAT I DID TO THE WEBSITE TODAY

**The nineteen pages pass every mechanical rule.** No banned words, no
"switch" as a verb, no `.com`, no v3.0. The three remaining uses of the word
"switch" are the noun -- *"the Memory integrity switch"* -- which the rule
allows. **The copy pass the briefing says is on zero pages is in fact
complete on all nineteen**, and the pricing page no longer promises a drive
scan it cannot do. Two stale entries; both now corrected in the briefing.

**I added two things to the BitLocker page**, both Microsoft's own documented
behaviour, neither making any new claim about Checkup:

1. **Why yours may already be on, or not.** A PC set up with a Microsoft
   account very likely encrypted itself and saved the key to that account. A
   PC set up with a local account did not, and has no key anywhere until the
   owner makes one. That is the SANDY-versus-Sandy3 difference, and it is the
   question a reader actually has.
2. **A USB drive is a safe place for the key, and why.** Encryption covers the
   drives inside the PC. A plugged-in USB stick is not encrypted and Home
   cannot encrypt one -- which is precisely why the key file on it stays
   readable on the day your own PC will not open.

**Undo:** `git checkout WebSite/html/bitlocker.html`.

I wrote one sentence claiming Checkup names your account type, then checked it
and found you had that line removed in ascii41. The sentence now says only
what the build measurably does.

---

## WHAT I THINK YOU SHOULD DO NEXT, IN ORDER

1. **Answer the three questions.** The mode screen, Malwarebytes, and the
   password wording. Nothing large can be scheduled around them until they
   are settled.
2. **Let me build the first block of ascii44 now.** The plan separates the
   work that needs no decision from the work that does; roughly two thirds
   needs nothing from you.
3. **One SANDY afternoon settles Malwarebytes.** Restore the quarantined
   items, turn nuisance-software blocking on, scan with each product, compare.
   Cloud's step 0 is a good plan and I would run it close to as written.

The build plan is `GatewayGuard_ascii44BuildPlan-2026-09-05-1130.md`.
