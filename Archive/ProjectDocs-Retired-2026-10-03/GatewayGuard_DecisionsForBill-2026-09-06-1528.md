<!-- Dated: 2026-09-06 15:28 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Bill's 16 decisions -- reviewed, with what each one costs

- **Document Name:** GatewayGuard_DecisionsForBill
- **Supersedes:** `GatewayGuard_DecisionsForBill-2026-09-05-1130.md`
- **Source of the answers:** `ProjectDocs\Bills 16 Decisions.txt`, 2026-09-06 13:58
- **Status:** 11 of 16 are settled and I am working from them. **4 need one
  more line from you** (2, 8, 12, 16). **1 was answered for a different
  question than the one asked** (16).

---

## THE SHORT VERSION

**Settled and actionable now:** 1, 3, 5, 6, 7(a-d as research), 9, 10, 11,
13, 14, 15.

**I got one cost badly wrong and it is worth knowing.** I told you question 3
option B would break *"every '19 settings' reference on the website, the guide
and the packaging."* ***Measured today across the whole repository:*** the
customer-facing count is **two lines on the website index**, and **three
comments inside the build that no user ever sees**. The real cost of setting
20 is a **new website page and a new guide section** -- the twentieth of each.
That is still real work, but it is not the wall I described. **You chose the
more expensive option while I was overstating its price, so the choice only
gets safer.**

**Two of your answers collide over one machine.** Question 2 needs SANDY's
Malwarebytes data intact. Question 7c wipes SANDY. **Order matters and I have
set it out in section "THE SANDY QUEUE" below.**

---
---

# PART 1 -- THE BUILD

## 1. GUI mode -- you chose C, field-run it before September 15

**Accepted. Here is what that run is actually walking into**, because it is
more than I knew when I wrote the question.

***Measured, ascii44 lines 9015-9345:*** GUI mode is **330 lines** and it is
**not a display**. It calls `Apply-Setting` on real settings, runs the
BitLocker screen, creates the scheduled tasks and prints the manual steps. It
changes the machine exactly as Console mode does.

**Three things it does not have**, each of which you will notice within a
minute of running it:

| Missing | Consequence on the day |
|---|---|
| **Screen numbers** | You cannot write "screen 14 was wrong" in the field notes. Every note will have to say "the third dialog". |
| **The `B` Back key and look-back** | Both live in the Console reader. GUI uses Windows message boxes, which have Yes/No/OK and nothing else. |
| **The `I` info key** | Same reason. No build or Machine ID on demand. |

**And there is a live defect already being instrumented in there.** ***Measured,
inside `Run-GUIMode`:*** two diagnostic log lines that exist only to catch a
layout variable going wrong --

```
DIAG: yPos initialized as type ...
DIAG: yPos CORRUPTED at row for '<setting name>' -- type=... value=...
```

**Somebody hit that bug, added the instrumentation, and never came back.**
Nobody has run the code since, so nobody knows if it still happens.

> **What I will do:** write the GUI field checklist the same way the Console
> one is written, and give the dialogs identifiers so your notes can name
> them. **Expect the first run to produce a defect list, not a pass.** That is
> the normal outcome of a first field run and it is the reason to do it.

> **One recommendation, and it is not me re-asking the question.** The screen
> today tells a first-time senior that the untested path is *"Recommended for
> first time users."* That sentence is false until the run passes. **I suggest
> taking the word "Recommended" off now and putting it back the day GUI mode
> passes a field run** -- that keeps both modes available, costs one line, and
> does not touch your decision to test it.

## 2. Malwarebytes -- SOLVED AT 16:42. ALL SIX SPECIMENS RECOVERED.

> ### EVERYTHING BELOW THIS BOX IS SUPERSEDED. Read the box, then skip to question 3.
>
> **Bill supplied the scan report at 16:30 and it settled the whole question.**
> ***Measured, `Tool2\Find-PUASamples-2026-09-06.ps1`, 1,161,813 files across
> E: and G:, every hit confirmed by SHA-256: all 6 distinct specimens found,
> 36 copies. Four of the six are in one folder, `G:\May-2023\Downloads\`.***
>
> **THE MALWAREBYTES COMPARISON IS NO LONGER BLOCKED.**
>
> **And the premise underneath my answer below was wrong.** ***The report's own
> header reads `Threats Quarantined: 0`, and all 18 lines say "No Action By
> User."*** **Nothing was ever quarantined**, so the question was never whether
> deleted quarantine can be recovered -- it was where the originals were, and
> they were on a backup drive the whole time.
>
> **Full detail, including what I got wrong about PUA blocking:**
> `GatewayGuard_PUASamplesRecovered-2026-09-06-1650.md`.

**Kept below for the record, because it explains why the search was built to
match on hashes rather than names -- which is the thing that stopped it
reporting four false hits on E:.**

You asked three things. Here they are in order, with what each is worth.

### (a) "Does MB still have them saved somewhere you can still get to?"

**No.** *Sourced, Malwarebytes Help Center:* quarantined items are copied,
**encrypted**, and stored in `C:\ProgramData\Malwarebytes\MBAMService\Quarantine`,
and the Delete action **permanently deletes the encrypted items** -- once
deleted, an item *"will no longer be present on your device and can no longer
be restored."* There is no second copy and no recycle bin behind it.

### (b) "Can you sweep Sandy's C: free space to find and restore them?"

**I recommend against it, and the reason is not the effort.**

**What is on that free space is not the files.** It is the **encrypted
quarantine blobs**. Even a flawless carve gives you a pile of ciphertext that
only Malwarebytes can open, and Malwarebytes opens it by looking up a database
row that was deleted at the same time. *inferred, and the inference is
straightforward from the sourced encryption fact above:* **a perfect recovery
would still produce nothing you can scan.**

Two more reasons on top of that: SANDY has been running for weeks since, so
that free space has been written over many times; and the whole exercise would
consume days of the two weeks left before launch.

### (c) "Do we still have a list of their names?" -- THIS ONE IS PROMISING

**Malwarebytes keeps its scan reports separately from its quarantine.**
Deleting quarantined items does not delete the report that named them.

***Measured on CGDELL, 2026-09-06:*** `C:\ProgramData\Malwarebytes\MBAMService\ScanResults`
holds **19 report files**. I read the first bytes of two of them -- they are
**hex-encoded ciphertext**, so they cannot be read from outside the app.
*Sourced, Malwarebytes Help Center:* the app's own **Reports** view opens and
exports them.

> **So the route is five minutes at SANDY's keyboard, not a forensic
> operation:** open Malwarebytes -> **Detection History** -> **Reports** tab
> -> find the scan dated **2026-08-11** -> open it -> **Export**. That gives
> the 18 names **and their original paths**. With the paths, your old backup
> drives become searchable, because you will know what to search for.
>
> **Do this before anything else happens to SANDY.** It is read-only and it
> cannot make anything worse.

### AND THERE IS A BETTER INSTRUMENT FOR HALF OF WHAT THE SAMPLES WERE FOR

**The nuisance-software question does not need those 18 files at all.**

*Sourced, AMTSO (the Anti-Malware Testing Standards Organization):* there is a
**PUA test file** -- a simulated potentially-unwanted application that the
security industry has agreed by standard to detect **only when PUA blocking is
switched on**. It is not malicious and does nothing. If it downloads
successfully, your PUA blocking is off. That is precisely the check question 3
now requires, and it works on CGDELL today.

**Be clear about what it does not do.** Every product detects the AMTSO file
*by agreement*, so it proves **the setting works** -- it cannot tell you
whether Defender or Malwarebytes free is better at real nuisance software.
**Only the 18 real samples could have done that, and they are gone.** If the
report export gives us the names and a backup drive still holds the originals,
the comparison is back on. If not, the Malwarebytes decision gets made on the
grounds we already have, and I will say so plainly rather than pretend a test
happened.

> **What I need from you: the report export.** Everything else on this
> question follows from it.

**Sources:**
[Manage quarantined items -- Malwarebytes Help Center](https://help.malwarebytes.com/hc/en-us/articles/31589479169179-Manage-quarantined-items-in-Windows-and-Mac) |
[View and download scan reports -- Malwarebytes Help Center](https://help.malwarebytes.com/hc/en-us/articles/31589573227035-View-and-download-scan-reports-in-Malwarebytes-for-Windows-and-Mac) |
[AMTSO Feature Settings Check -- PUA](https://www.amtso.org/feature-settings-check-potentially-unwanted-applications/) |
[AMTSO Security Features Check tools](https://www.amtso.org/security-features-check/)

## 3. Nuisance-software blocking -- you chose B, make it setting 20

**Accepted, and my question overstated the price.** The corrected measurement
is at the top of this document: two customer-facing lines on the website
index, three invisible comments in the build.

**The real cost is the twentieth page.** Every one of the nineteen settings
has its own website page (`WebSite\html\`, ***measured: 19 setting pages***)
and its own guide section. Setting 20 needs both, written to the same standard
as the rest.

> ### CORRECTION, 16:50 -- THE CASE FOR THIS IS WEAKER THAN I TOLD YOU
>
> I called it *"the closest thing to a genuinely missing setting the research
> found"*, and said our scans would *"stay weaker than they need to be"*
> without it. **Both halves of PUA blocking have been ON BY DEFAULT since
> August 2021** -- *sourced, Microsoft Support, and Edge's own documentation
> for the browser half.* ***Measured on CGDELL today: `PUAProtection = 1`, and
> nobody here turned it on.***
>
> **So setting 20 is a confirmation plus a catch for the minority where
> something switched it off -- not a missing protection.** That is still a
> real job, and several of the existing nineteen are also usually already
> correct. **But you chose the more expensive option partly on my wording, so
> you should know the wording was wrong before I build it.** Your decision
> stands unless you say otherwise.

**What setting 20 will do**, and both halves are needed because they are
separate switches:

1. **Windows PUA blocking** -- Checkup reads it, reports it, and turns it on
   with your permission. Automatic.
2. **The Edge half** -- Windows does not let a program set this one, so
   Checkup shows the exact steps. **Your question 15 answer gives me the
   wording for this**, see below.

**And it will be verifiable**, which none of the other nineteen fully are: the
AMTSO PUA file above gives a yes/no proof that the setting took effect.

> **Where it goes in the run:** before the scans, because it changes what the
> scans find. That was the one part of option A worth keeping, and being
> setting 20 does not stop it running early.

## 4. The password-manager reasoning -- you gave instructions, not a pick

**You did not choose A or B. You described a third thing, and it is better
than either.** Restated so you can check I have it right:

1. **A good non-browser password manager: leave them alone.** Do not talk them
   out of something that works.
2. **Otherwise, they keep the browser manager and we tell them how to run it
   properly** -- check which browser it is, then give the minimum settings for
   that browser.
3. **Research what Microsoft and the experts actually say** about saving
   passwords in a browser, and specifically about **one browser or all of
   them**.
4. **If the answer is "use only one": find out which one they use most, and
   tell them why one.** If the answer is "all are fine": give the minimum
   settings for each.

**That is a real research job and I have not done it yet.** It is on the list
below.

**One thing I should flag now, because it changes the shape of the answer:**
this asks Checkup to detect *which* browsers a user has and *which* they use
most. Checkup reads Edge today. Chrome and Firefox are additional work. **The
guide can cover all three at no build cost; the screens are where it gets
expensive.** I will bring you the research with a build/guide split before
anything is built.

## 5. Screen 12 -- agreed, and already done

**Built in ascii44 this morning.** SSDs sort first, then everything else,
hardware ID as the tiebreak inside each group.

**Not verified**, and it cannot be here: ***measured on CGDELL 2026-09-06,
`Get-PhysicalDisk` returns one disk***, so the output is identical before and
after. **It needs one look at screen 12 on SANDY** and it is on the field
checklist.

## 6. The two screenshots -- done, and they show something worse than I expected

**I found them myself and put them in `Test_Results\FieldRun-ascii43\`** as
`Screen16-shot21-2026-08-28_1846.png` and `Screen16-shot22-2026-08-28_1851.png`.
You did not need to move them.

**Here is what they show, five minutes apart, at screen 16 (the Defender
offline scan).**

**Shot 21, 18:46 -- the screen is unreadable.** Four copies of screen 16's box
are painted across each other at different horizontal positions. Fragments
like `ENDER OFFLINE SCAN` and `ootkits and malware` -- the tails of lines
whose beginnings are somewhere else on the row. Underneath it all sits the
look-back prompt: *"LOOKING BACK -- nothing on your PC has been changed or
undone. [B] Look back one more screen."* **A senior looking at that has no
idea what the program is doing.**

**Shot 22, 18:51 -- the apology.** An almost empty console reading:

```
(Returning -- this screen could not be redrawn exactly.
 Nothing has changed. Your log file has the full detail.)
```

**What is certain, and what is not.**

***Measured, ascii44 line 2694:*** that apology is printed on exactly one
condition -- `Restore-ScreenSnapshot` returned false. ***Measured, line
2112:*** that function returns false when the stored snapshot's width does not
match the console's current width. **So the console window's width changed
during the run.** That much is solid.

**AND THE CAUSE IS NOW SETTLED. It is Windows, and it is on by default.**

***Sourced, Microsoft's own console code and issue tracker:*** the console has
a feature called **"Wrap text output on resize."** When the window is resized,
`ResizeWithReflow` **takes every stored row apart and re-splits it to the new
width.** Microsoft's own bug list carries this exact consequence -- issue #383
is titled ***"'Layout / Wrap text output on resize' option breaks pseudographic
UI."*** **Checkup is a pseudographic UI.** Its screens are boxes drawn out of
`+`, `=` and `|`.

***Measured on CGDELL today, `HKCU\Console`:*** **`LineWrap = 1`.** The feature
is **on**. ***Measured, same key:*** the window is **120 columns**.

**Here is the whole failure, start to finish:**

1. ***Measured, ascii44 line 2231:*** Checkup sizes every box **to the window
   width at the moment it draws it** -- exactly as FT-217 requires.
2. The user drags the window to a different width.
3. Windows re-splits every stored row to the new width. **The boxes come
   apart.** That is shot 21.
4. ***Measured, line 2113:*** Checkup's snapshots are keyed to the width they
   were captured at, so after a resize **none of them can be replayed**. That
   is shot 22's apology.

> **Nothing in Checkup is doing anything wrong here, and that is exactly why
> it cannot recover.** Every protection it has -- the width-fitting, the
> snapshot guard, the honest apology -- is keyed to *the width at draw time*.
> **Nothing looks again afterwards**, so the tool never learns the window
> moved, and the one thing it could do about it -- redraw the screen at the
> new width -- is the one thing it cannot do, because it keeps a **picture**
> of each screen rather than the **lines** it was built from.
>
> **That is the fix, and it is a small one:** keep the current screen's text
> lines alongside the picture. Then a prompt that notices the width has
> changed can simply draw the screen again, correctly, at the new size --
> instead of apologising on an empty console. **Look-back after a resize
> starts working as a side effect.**

**Still your call whether it goes into ascii44.** It is not in Block A and I
have not touched it.

**What is already clear enough to call a defect, whatever the cause:**

- **Look-back was offered and entered while the screen was unreadable.** The
  guard that is supposed to withhold the offer after a resize did not withhold
  it here.
- **When the tool knows it cannot redraw, it apologises on an empty console
  instead of redrawing the screen the user is actually on.** The user is left
  with no screen at all. **That is a dead end, and it is the rule this project
  has broken and fixed more than any other.**

> **This is a new finding, raised today, not fixed.** It is not part of Block
> A and I have not touched it. It belongs in ascii44 if you want it, and I
> would put it above most of Block B, because "the screen went blank and
> apologised" is the kind of thing that ends a senior's session.

## 7. The account-type line and the encryption questions

**You did not pick A or B either -- you set four research questions.** Taking
them in order:

**(a) "You need to know if the drive is already encrypted. If already
installed this is a moot question."** ***Measured, ascii44:*** Checkup already
reads encryption status before it offers anything. **You are right that this
comes first**, and it changes what the account-type line is even for: not a
warning, but the explanation of why *this* PC is in *this* state.

**(b) "Can you tell what account was active when Windows was installed?"**
**Not answered yet, and I will not guess.** There are candidate sources -- the
install date in the registry, profile creation times, the account type on the
oldest profile -- but "candidates exist" is not an answer, and this project's
record on confident answers about account types is bad. **I will measure it on
both machines and report what each one can actually prove.**

**(c) "Research what I believe to be true -- during installation the user is
asked, with either account, if they want to encrypt their drives."**
**Not answered yet.** This is the load-bearing one: if it is true, "turn it on
yourself" is wrong advice for some customers. It goes to Cloud, which is
better placed to do documentation research than I am, and I will check its
answer against Microsoft's own pages before it goes anywhere near a screen.

**(d) "Find the instructions for reinstalling Windows on Sandy using the
BitLocker key we get when we encrypt."** **I will write this up as a
step-by-step document.**

> **And a warning attached to (c) and (d): reimaging SANDY destroys the
> Malwarebytes reports in question 2.** See THE SANDY QUEUE below. **Export
> the reports first.** It costs five minutes and it is not recoverable
> afterwards.

## 8. Windows Update -- you asked me a question back

**Your question:** *"What could happen differently with Checkup looping from
the user running updates until they get the 'you are up to date' message. We
should test this out on Sandy and CGDELL."*

**The honest answer is that the difference is not in the updating -- it is in
who is holding the machine when it goes wrong.** Windows Update on a real home
PC does not finish in one pass. It installs, restarts, installs more, and
sometimes stalls for twenty minutes on one item, and it can want two or three
restarts before it says "You're up to date."

| | User runs updates themselves | Checkup loops until up to date |
|---|---|---|
| **Restarts** | Windows does it, the user knows Windows did it | Checkup must survive being killed mid-run and come back to the right place |
| **A stall** | Windows shows its own progress, and it is familiar | Checkup shows a screen that says nothing for 20 minutes and looks frozen -- **this is the failure that has already cost us field runs** |
| **A failed update** | Windows Update's own error and retry | Checkup has to explain someone else's error code |
| **If it goes wrong** | The user blames Windows | The user blames us |

**And one hard fact: this has never been run once on a project machine.**
Building an unattended multi-restart loop, for the first time, two weeks
before launch, on the machines seniors will use -- that is the highest-risk
thing on any list in this project.

> **My recommendation stands: check and tell for launch, install after.** But
> **your test is worth running either way**, because it tells us what the
> "check and tell" screen must say. I will script it read-only on both
> machines: how many passes, how many restarts, how long each takes, and what
> Windows shows at each stage.
>
> **One line from you settles the build half:** confirm check-and-tell for
> launch, and I will scope the loop out of ascii44 permanently rather than
> carrying it as an open item.

## 9. `X` = Exit -- agreed, later

**Recorded.** The 11 `N`-means-exit sites stay as they are through the ascii44
field run. **`X` is not lost** -- it is written into `CLAUDE.md` as an open
decision.

---
---

# PART 2 -- THE LICENCE

## 10. Per-PC enforcement -- "B in ascii45"

**Recorded, and here is the reading I am working from, so correct me if it is
wrong:** the enforcement gets **built in ascii45**, and until it exists **the
launch licence says nothing that claims it**. The rule stays stated; no
sentence claims the software refuses to run elsewhere.

**That keeps the agreement true on launch day**, which was the whole reason I
raised it.

**When ascii45 comes, enforcement needs three decisions before a line is
written:** what happens when the check fails, how a legitimate new PC is
handled, and what a false positive costs a customer who paid. **I will bring
those to you as their own document, not fold them into a build.**

## 11. The "new computer" paragraph -- B

**Cut to one sentence.** The term stays enforceable, the warmth moves to the
website where it belongs.

## 12. The MARKETING tags in Sections 7, 8 and 9 -- "Remove and show me"

**Understood, and I will show you before anything is cut** -- that was the
condition I attached and you have taken it.

**What you will get:** the three sections side by side, as they stand and with
the tagged paragraphs removed, plus **one line under each saying what the
removal costs**. Some of those paragraphs are the stated reason a term exists,
and the Guide's no-refund rule leans on one of them directly. **You should see
that before you decide, not after.**

**This one is genuinely for the attorney too.** *"Can this clause survive
without its explanation?"* is a lawyer's question, not mine, and it is going
into the consult list.

## 13. Version control -- your Gumroad research answers it

**This settles it, and it is good news.** From what you gathered:

- Gumroad **keeps the buyer email list** and the seller can **export it**.
- Replacing a product file lets you **send the update to past buyers at no
  extra charge**.
- **One catch, and it matters for launch:** broadcast emails are **locked
  until the account has earned $100** after fees and taken its first payout.
  It is a **one-time** gate, not recurring.

**So the first buyers cannot be emailed an update until we cross $100.**

**That is not a problem, but it is a thing to know**, and there is a simple
answer: the buyer's **download link stays live and always serves the newest
file**. So an early buyer who gets no email still gets the fix the next time
they use their link. **The store page and the licence should both say that**
-- "your download link always gives you the current version" -- rather than
promising an email we cannot send yet.

> **I will write this up as the store-operations note**, covering how a
> correction reaches existing buyers, how the annual update stays a separate
> purchase, and what to say on the page before $100. **The licence text does
> not change.**

## 14. "Use 3.1" -- agreed

**Licence v3.1.** No conflict with the product version, which is v3.1
everywhere for its own separate reason.

## 15. The Gemini Edge write-up -- received, and it lands on setting 6

**Thank you -- this is the piece Cloud has asked for twice.** What it gives:

- The address is **`edge://settings/privacy/security`**
- The section is **Security**
- The control is **"Protect from harmful sites and downloads"**, and Edge
  itself says it **uses Microsoft Defender SmartScreen**

**CHECKED, AND IT FOUND SOMETHING BETTER THAN I EXPECTED.**

**First, a correction to what I told you an hour ago.** I said the tool's
message *"All 3 phishing protection options enabled"* looked wrong against
your one-toggle description, and I said I would check it. **I checked, and the
message is right -- I had aimed it at the wrong feature.** There are **three**
controls here, not two:

| | What it is | Where the user finds it | Does Checkup handle it? |
|---|---|---|---|
| **Setting 4** | Windows SmartScreen, apps and downloads | Windows Security | **Yes** |
| **Setting 6** | **Windows** Enhanced Phishing Protection -- and it genuinely has **three** switches | Windows Security -> App & browser control -> Reputation-based protection | **Yes** |
| **Your write-up** | **Edge's own** "Protect from harmful sites and downloads" | `edge://settings/privacy/security` | ***measured: no. Not one Edge policy key anywhere in the build.*** |

**So your write-up names a control Checkup does not check at all.** That is
worth more than the confirmation I thought I was getting.

### But it did turn up a real defect, and it is one word

***Measured, ascii44 line 5758:*** setting 6 is called **"Edge Phishing
Protection (all 3)"** in the checklist -- **and it has nothing to do with
Edge.** It writes Windows settings, and its own manual instructions correctly
send the user to Windows Security without mentioning Edge.

***And the website already has it right:*** `phishing-protection.html` is
titled **"Enhanced Phishing Protection -- Setting 6"** and names the Windows
panel. **The tool and the website disagree, and this time the tool is the one
that is wrong.**

> **Why a customer cares:** the checklist name is what a senior reads when
> deciding what to leave ticked. **Someone who uses Chrome can reasonably
> untick a row labelled "Edge Phishing Protection"** -- and switch off a
> protection that has nothing to do with which browser they use.
>
> **The fix is the name**, to match the website and the Windows panel:
> *Enhanced Phishing Protection (all 3)*. One line, no behaviour change.

**Your write-up is committed to `ProjectDocs\` as a `.md`**, with all of this
recorded in it. That closes Cloud's request.

## 16. The licence as a web page -- YOUR ANSWER IS ABOUT SOMETHING ELSE

**I have to flag this one rather than file it.**

**The question was:** Gumroad's checkout needs a Terms link the buyer accepts
before paying, you said it is a click on the website that opens the PDF, and
***measured 2026-09-02: no such page exists yet.*** Is the PDF-link form what
you want?

**Your answer describes how to put a Gumroad buy button on the website** --
and you picked option 1, the direct link that sends the buyer to Gumroad's own
checkout. **That is a useful decision and I have recorded it.** It is just not
an answer to the question asked.

**And picking option 1 makes the original question sharper, not softer.** If
the buyer leaves our site for Gumroad's checkout, then **the terms they accept
are the ones configured inside Gumroad**, and that field needs a **URL** --
somewhere public and permanent that serves the licence.

> **What I need is one line: is the licence a PDF the link opens, or a proper
> web page like the rest of the site?**
>
> **My recommendation is a web page**, for three reasons: a PDF on a phone
> opens in a viewer a senior may not get back out of; the website's own rules
> require the same copy standards everywhere; and a web page can be corrected
> without re-uploading a file to two places. **The PDF stays, as the copy the
> customer keeps.**

---
---

# THE SANDY QUEUE -- ORDER MATTERS AND TWO OF YOUR ANSWERS COLLIDE

**Three of your decisions need SANDY, and one of them destroys what the others
need.** Do them in this order.

| | Do this | Why it is here |
|---|---|---|
| **1** | **Export the Malwarebytes scan reports** (Q2c). Detection History -> Reports -> the 2026-08-11 scan -> Export. | Read-only, five minutes, **and gone forever after step 4**. Nothing else on this list can be undone by doing it. |
| **2** | **Look at screen 12** during the ascii44 field run (Q5). | SANDY is the only machine with two drives. One glance. |
| **3** | **Run the ascii44 field checklist**, Console mode, then GUI mode (Q1). | The build has eight fixes in it that no human has seen run. |
| **4** | **Reimage SANDY** (Q7c), if the research says we need it. | **Destroys steps 1, 2 and 3's machine state.** Last, or not at all. |

**Step 1 is the one to do today.** It is five minutes, it cannot break
anything, and it is the only item on this list with a deadline set by
something other than us.

---

# WHAT I AM DOING NEXT, IN ORDER

1. **Commit your Gemini Edge write-up as a `.md`** so Cloud can read it (Q15).
2. **Reproduce the screen-16 display fault on CGDELL** -- resize mid-run, press
   B -- and report the actual cause rather than the two candidates (Q6).
3. **Check "All 3 phishing protection options" against a real Edge settings
   page** (Q15).
4. **Research the password-manager questions you set** -- Microsoft and the
   expert consensus, one browser or all, and the minimum settings for each
   (Q4).
5. **Measure what each machine can prove about its own install account** (Q7b),
   and send 7c to Cloud.
6. **Write the reinstall-with-BitLocker-key document** (Q7d).
7. **Show you Sections 7, 8 and 9 with and without the tagged paragraphs**
   (Q12).
8. **Write the store-operations note** from your Gumroad research (Q13).

**Not started, waiting on you:** the four lines above -- question 2's report
export, question 8's confirmation, question 16's page-or-PDF, and whether the
screen-16 fault goes into ascii44.

**Building nothing further until you say so.** Block A is finished, committed
and pushed. **Block B is ready and I have not started it.**
