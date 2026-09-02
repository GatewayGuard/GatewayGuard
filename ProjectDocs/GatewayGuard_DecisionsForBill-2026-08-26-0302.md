<!-- Dated: 2026-08-26 03:02 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Everything waiting on Bill -- one list, 2026-08-26

- **Document Name:** GatewayGuard_DecisionsForBill
- **Last Modified:** 2026-08-26 03:02 ET
- **Replaces:** `GatewayGuard_DecisionsForBill-2026-08-25-1620.md`. **Two of its
  nine items are closed and one has changed shape completely.** Everything else
  is carried below with its old number noted, so nothing was quietly dropped.
- **Launch target:** **2026-09-15** (moved 2026-08-30 from 2026-09-01).
  *(This line said "2026-09-01. Six days." -- a countdown that was wrong the
  next morning. Dates do not go stale; countdowns do. No countdown here.)*

---

## WHAT CHANGED SINCE THE LAST LIST

**The big one: item 5 is no longer a decision, and no longer gates the build.**
Cloud's licence research came in and answered it. It is now a job in section A,
not a decision in section B. **The build freeze is not waiting on you.**

**Item 4 -- Windows Update -- you are doing right now.** It moves to
CONFIRM-WHEN-BACK rather than off the list entirely, because two measurements
have to be taken afterwards.

**Two rows are new**, both from Cloud's research, and **one of them has a date
on it that lands two weeks after launch.**

---

# A. JOBS -- NO DECISION REQUIRED, JUST DO THEM

## 1. CONNECT THE GUMROAD PAYOUT METHOD * STILL BLOCKS LAUNCH

**Unchanged and still first.** Your own Gumroad page: *"You haven't connected a
payout method yet, so you won't be able to publish this product for sale."*

**Nothing publishes until this is done.** Not Checkup, not the Guide. Ten
minutes.

## 2. ADD THE LICENCE AS A **TERMS** FIELD AT CHECKOUT * *(was item 5, a decision)*

**This is the answer to "how does a buyer accept the licence", and it is a form
field, not a build change.**

*Sourced, Cloud, from Gumroad's own help documentation, 2026-08-25:* Gumroad
supports custom checkout fields in three kinds -- textbox, checkbox, and
**Terms**. The **Terms** field takes the URL of the seller's terms, **which
customers must accept before purchasing.**

**And it is not optional in the way we assumed.** *Sourced, `gumroad.com/terms`
section 6.7 and 6.9(c):* the supplier **shall provide Gumroad with the end user
licence terms**, authorises Gumroad to present them **in a manner that creates a
binding contract**, and **warrants that those terms are correct and current.**

**So the position today is not neutral. It is negative.** We have supplied no
terms, into the one channel Gumroad's own contract says is where terms get
supplied, while a warranty is being given about them.

**Four steps, in order:**

1. Publish the agreement at a stable URL -- **`gatewayguard.co/license`**.
2. Add a **Terms** field on **both** products pointing at it.
3. Make a test purchase and confirm the acceptance is recorded in the sales CSV.
4. **Keep the CSV.** It is the evidence that somebody agreed, and it is what
   gets asked for if the agreement is ever tested.

**One honest caveat from Cloud, and it is yours to close:** this comes from
Gumroad's help pages, **not from your screen.** *"Bill should confirm the field
exists in his account before the launch plan depends on it."*

**What this does NOT need:** an acceptance screen in Checkup. Cloud's
recommendation and mine agree -- **no gate in the product for launch.** A single
non-blocking notice line goes in the F6 wording block instead, telling the
customer where the terms live. That is copy, and it carries no keyboard risk.

## 3. SET BOTH REFUND TOGGLES TO 30 DAYS *(was item 2)*

**Settings -> "Specify a refund policy for this product."** ***Per-product, not
account-wide*** -- settled from your own screenshots.

**Two products, two toggles. Doing one is the failure mode here.** Wording is
written and ready to paste: `GatewayGuard_GumroadListings-2026-08-25-0015.md`.

## 4. TEST THE CHECKOUT -- WITH GUMROAD'S TEST CARD, NOT YOUR OWN *(was item 3)*

***CORRECTED 2026-09-02. This item said "use a real card" and that was
wrong.*** ***sourced, Gumroad Help Center:*** charging your own card for your
own product *"appears exactly the same as money laundering to our security
systems, and your account may be automatically suspended as a result."*

**Nobody has ever bought anything from our store. Not once.** Stay logged in,
open your own product page, and buy it -- the checkout substitutes a **test
card** and charges nothing. **Do it for both products.**

**It proves the checkout, both emails, and the file download.** It does not
prove a real card or the payout -- for those, ***sourced:*** *"just ask"*
Gumroad support to confirm the payout works. One email, no risk.

**It may NOT prove item 2.** ***sourced:*** a test sale *"will not be displayed
in your Audience Dashboard alongside your other sales"* -- so the licence
acceptance may not reach the CSV either. Check the export straight after.

**Full procedure:** `GatewayGuard_GumroadTestPurchase-2026-09-02-1040.md`

## 5. WHEN YOU ARE BACK FROM THE REBOOT -- TWO MEASUREMENTS *(was item 4, part closed)*

**You are patching both machines as I write this. That closes the "every field
measurement is from an unpatched PC" asterisk.** Two things to capture
afterwards, and both are quick:

1. **`winver` on both machines**, and tell me the numbers. **SANDY's build has
   never been measured** and I want it recorded before the ascii43 field run.
   CGDELL was **26200.8875**; it should come back **26200.9168**.
2. **The Win+L test** for `LockScreenWidgetsEnabled`. It was on the old list and
   it is now **more** useful than it was, because it will be measured on the
   Windows customers will actually have. Twenty seconds: set the value, press
   Win+L, look.

**Nothing in the update changes Checkup.** I checked all three changed areas
against the source -- details in the session log. The one relevant change is
that Windows now shows **Weather only** on the lock screen for new users, which
means the setting-14 lock-screen steps have to cover two starting states when
they get written. **Neither of your machines will change**, because "new users"
leaves existing profiles alone.

---

# B. DECISIONS -- ONE WORD EACH

## 6. THE TWO NOTES YOU TYPED INTO THE LICENCE FILE *(was item 6, unchanged)*

**Still open. Still the same two, and I still will not guess.**

| Your note | Why I stopped |
|---|---|
| *"No bundles initially -- remove mention of them just make sure it covers all sold copies."* | It is attached to the **refund** entry. Does "bundles" mean the **Checkup + Guide bundle**, or the **multi-PC packs**? The two read completely differently in Section 9 |
| *"Remove"* -- after the programs-review entry | Remove **Section 7 itself**, or remove **that change-log entry**? **I am not deleting a whole section of a contract on the strength of one word in a margin** |

## 7. WHAT IS THE LICENCE-MOVE FEE? *(was item 7 -- research is in, decision is not)*

**Cloud's research arrived and it does not support the current wording.** Its
recommendation, in its words: **the fee is your decision and it is not
reopening it**, but two things must happen before the sentence ships:

1. **Name the amount, or name where and when the buyer learns it.** The amount
   does not belong in the contract -- prices in a contract have to be amended
   like a contract -- so it goes on `gatewayguard.co`.
2. **Consider waiving it where charging looks worst** -- where the PC **failed**
   rather than was replaced by choice. **That is a support-policy line, not a
   contract line.**

**And one thing Cloud handed back to me, which I have not done:** establish what
a licence move actually *consists of* before a price is attached to it.
***measured on ascii43:*** `Get-MachineIdentity` computes a hash, displays it,
logs it, **and never compares it to anything** -- so today a "move" is an email
saying go ahead. **Cloud's warning is fair: an administrative charge is
defensible; charging for nothing is harder to defend if a customer reads the
source.** I will do this before the wording ships.

---

# C. NEW -- FROM CLOUD'S RESEARCH, NOT ON ANY EARLIER LIST

## 8. GUMROAD CHANGED ITS TERMS, AND THE DATE FALLS AFTER LAUNCH

*Sourced, `gumroad.com/terms`, read by Cloud 2026-08-25:* effective date
2026-01-01, **last updated 2026-08-17**, and accounts that existed when those
changes were posted **become bound by them on 2026-09-16.**

**Launch is 2026-09-01.** You sell your first copies under one set of terms and
your account moves to another **fifteen days later.**

**Two things follow:** it is worth one question to the attorney, and it is worth
**you reading the diff yourself**. Nobody had flagged this and it was outside
what Cloud was asked.

## 9. CLOUD'S RESEARCH WAS SITTING OUTSIDE THE REPOSITORY FOR TWELVE HOURS

**No action needed from you. Recorded because you should know it happened.**

Cloud delivered 1,261 lines answering all fourteen licence questions at 14:35
yesterday. ***measured at session start:*** it was **untracked** -- on disk, in
no commit, so in no push, so in no sync. **It is committed and pushed now.**

**That was my failure, not yours and not Cloud's.** Committing it is step 4 of
the rule in `CLAUDE.md`, the rule was rewritten the same day precisely because
it used to omit that step, and the session that received the work closed without
running it.

**The four words that catch this, and they work on me too: "did you push it?"**

## 10. YOU TYPED AN ITEM 24 WHILE I WAS WORKING, AND I WILL NOT GUESS AT IT

***measured, `git diff` at 03:06:*** `ProjectDocs/Q2 - Checkup offers to run
windows.txt` gained one line during this session:

> *"Item 24 - Deep Research and them implement their suggestions/functionality
> for our documents, the website and maybe Checkup if available in PS mode."*

**Committed exactly as you typed it. Not acted on.** Two readings, and they are
different jobs:

| Reading | What it would mean |
|---|---|
| **Run a deep-research pass**, then implement what it recommends | A research task first, scope unknown until it reports |
| **Implement the suggestions already sitting in Cloud's delivered research** | Work I could start now -- there are 1,261 lines of it |

**And "if available in PS mode" I do not follow at all** -- whether that means
PowerShell, or a presentation mode, or something else.

**One sentence from you settles it.** I am flagging rather than choosing because
this is exactly the shape of the two margin notes in item 6, and guessing at
those is what I declined to do there.

**Note also what this is an instance of.** I found it because the repo health
check listed a modified file I had not touched -- the same way the four
instructions typed into the licence `.docx` were found, by opening a file nobody
had pointed at. **If you type something into a file and want it seen, one line
saying so still saves a round trip.**

---

---

## WHAT IS DONE AND NEEDS NOTHING FROM YOU

- **Licence v2.4 built and committed** -- binding stays, Section 12 added,
  corrections free, components and log ownership named, third parties
  disclaimed. Master and readable twin both in.
- **Cloud's fourteen licence questions are answered**, committed and pushed --
  `GatewayGuard_CloudResearch-Licence-2026-08-25-1435.md`.
- **The Windows update is measured against the build.** No change to Checkup.
  One future-copy note recorded in `FutureSettings` C-3.
- **Website review closed** -- all 19 pages, items 2, 3, 9 and 17.
- **Repo health: ALL CLEAR.** No conflict copies, nothing unpushed.

---

## THE ORDER I WOULD DO IT IN

**When you sit back down, ten minutes:** item 1, then item 3. Both are clicks.

**Then item 5** -- two measurements, one of which is twenty seconds.

**Then item 2**, which is the biggest change on this list and the one that turns
a contract nobody accepts into a contract everybody does.

**Item 4 last of that group**, because it proves items 2 and 3 at the same time.

**The build -- ascii44 -- is not waiting on any of this any more.** F4, F6, F5
remnants, setting 1 pause detection, setting 14 three-way plus the Revert
string, setting 6 rename, then gates 12 / 12b / 24 / 25 and the increment.
**Nineteen settings. Frozen.**
