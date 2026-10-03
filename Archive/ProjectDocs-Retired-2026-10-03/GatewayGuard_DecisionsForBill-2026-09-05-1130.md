<!-- Dated: 2026-09-05 11:30 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Questions for Bill -- the ascii44 build, and the licence

- **Document Name:** GatewayGuard_DecisionsForBill
- **Supersedes:** `GatewayGuard_DecisionsForBill-2026-08-26-0302.md`
- **Status:** Waiting on Bill. **Every question carries my recommendation, so
  you can answer "agree" and move on.**

---

## HOW TO ANSWER THIS FAST

**Each question has a recommendation.** If you agree, write the number and the
word *agree*. If you do not, name the other option. **You do not need to
explain any of them.**

Example reply: *"1 agree. 2 remove it. 3 agree. 4 leave the wording alone."*

**Questions 1 through 4 block work. Everything after 9 can wait.**

---
---

# PART 1 -- THE BUILD

## 1. GUI mode is recommended to first-time users and has never been tested

***Measured, ascii43 lines 8064-8073*** -- the opening screen reads:

```
  [2] GUI MODE
      Opens a visual window with checkboxes and color-coded
      status indicators. Recommended for first time users.
```

***And measured, the build's own note at line 642:*** GUI mode *"has never
been inventoried. Every field log to date is mode 1."* It has no screen
numbers, appears in no field checklist, and has never been run in a test you
or I have recorded.

**So the screen sends a first-time senior -- our exact customer -- down the
one path nobody has ever walked.**

| Option | What it costs |
|---|---|
| **A. Drop the "Recommended for first time users" line** | One line. Both modes stay available. |
| **B. Remove GUI mode from the launch build** | Larger, but nothing untested ships. |
| **C. Field-run GUI mode before September 15** | A whole SANDY session we do not have spare. |

> **My recommendation: A now, and B if GUI mode has still not been field run
> two weeks before launch.** A is honest and costs nothing. What we cannot do
> is leave the word "recommended" on it.

## 2. Malwarebytes -- do you want the test run that decides it?

**I am not asking you to decide Malwarebytes today.** I am asking whether to
schedule the measurement that would let you decide it properly.

**What is known.** Independent labs in 2026 put Microsoft Defender at the top
award level, and marked Malwarebytes down for false alarms. But the labs test
Malwarebytes *Premium*, and we use the *free* scanner -- so those scores do
not describe what our customers get. **Defender only catches nuisance software
when a setting we never touch is turned on** (question 3). Nobody has
published the comparison we actually need.

**What Malwarebytes costs us today:** four screens, a monthly reminder task,
a guide section, pricing copy, website copy, **and three sentences in the
licence**. Its firewall caused the DHCP failures on SANDY, and a whole status
branch exists because a trial can seize primary antivirus.

**The test is one afternoon on SANDY:** restore the 18 quarantined items,
turn nuisance blocking on, scan with Defender, scan with Malwarebytes free,
compare. **It must happen before SANDY is encrypted or reimaged** -- that
would destroy the quarantine.

> **My recommendation: run the test.** It is one afternoon and it converts the
> largest open product question in the project into a measurement. **I would
> not remove Malwarebytes without it**, and I would not keep it without it
> either.

## 3. Nuisance-software blocking -- a real gap, and I want to confirm the scope

***Measured: the setting does not appear anywhere in ascii43.*** Windows can
block "potentially unwanted applications" -- the toolbars, the driver
updaters, the free-download bundles. Microsoft recommends it be on. **Checkup
has never read it, never reported it, and never offered it.**

It has two halves. Checkup can turn the first on with permission. The second
lives in Edge and has to be done by hand.

**This is the closest thing to a genuinely missing setting the research
found.** But the nineteen settings are frozen.

| Option | |
|---|---|
| **A. A step before the scans, not a numbered setting** | Reads it, offers to turn it on, shows the manual steps for the Edge half. The count stays at nineteen. |
| **B. Setting 20** | Breaks the freeze and every "19 settings" reference on the website, the guide and the packaging. |
| **C. Leave it out of ascii44** | Our scans stay weaker than they need to be. |

> **My recommendation: A.** It gets the protection without touching the
> nineteen, and it belongs before the scans anyway because it changes what the
> scans find.

## 4. The password-manager reasoning -- the behaviour is right, the "why" may not be

**Nothing about how Checkup behaves is in question.** ***Measured, lines
6665-6689:*** it asks *"Do you use a password manager?"* before the checklist,
and if the answer is no it leaves Edge password saving switched on and says
why. That is correct and it stays.

**What is in question is the explanation we print.** Our page and screens
describe a browser password manager as a convenient single point of failure
and steer the reader to Bitwarden or 1Password.

**The UK's National Cyber Security Centre says a browser password manager
"can be a very good choice"** for someone on one PC with a screen lock -- our
customer, described. The strongest "turn it off" arguments come from companies
that sell password managers.

| Option | |
|---|---|
| **A. Leave it. It is defensible and it is written.** | Our advice is more cautious than the standard, which is not a defect. |
| **B. Soften it** | Present the browser manager as a reasonable choice for one PC, and the separate app as the better answer for someone with a phone, a tablet and a shared computer. |

> **My recommendation: B, but not in ascii44.** It is right, and it is not
> urgent. **It belongs with the guide's new passwords section**, so the page,
> the screens and the guide all move together and say the same thing once.

## 5. Screen 12 -- reverse the drive order?

You asked for the SSD to be Drive 1. **One line.** I am carrying it in the
plan as agreed unless you say otherwise.

> **My recommendation: do it.** It is the first thing the customer sees.

## 6. Two screenshots have never been looked at

**Screens 21 and 22 from screen 16**, in `OneDrive\Personal\Pictures\Screenshots`.
They are the only record of whatever happened at screen 16 during the field
run. **Put them in `Test_Results\` and I will triage them.**

## 7. Should the account-type line go back into the encryption screens?

**You had it removed in ascii41** -- the line that told the user whether they
were on a local account or a Microsoft account.

**Microsoft's documentation now makes it the thing that explains everything
else:** a PC set up with a Microsoft account very likely encrypted itself and
put the recovery key in that account. A PC set up with a local account did not,
and has no key anywhere until the owner makes one. **That is the SANDY-versus-
Sandy3 difference, and it is why "turn it on yourself" is true for some
customers and wrong for others.**

Checkup already detects it -- it just does not say it any more.

| Option | |
|---|---|
| **A. Leave it removed** | You removed it for a reason and I have not re-read that reasoning. |
| **B. Put back a plain sentence, not the warning** | Not the old alarming line -- a sentence that explains why their PC is in the state it is in. |

> **My recommendation: B**, with the wording shown to you before it is built.
> **I have already added this explanation to the website's BitLocker page
> today**, because there it is a fact about Windows and makes no claim about
> Checkup. The screen is a different matter and it is your call.

## 8. Windows Update -- confirming what we are NOT doing

Checkup could be made to install Windows updates and loop until the machine is
current. **I do not want to build that for launch.** It can leave a senior's
PC part-way through servicing, it involves restarts, and it has never been run
once on a project machine.

**What I will build:** Checkup checks, tells you plainly if updates are
waiting, and says to restart and run it again.

> **My recommendation: confirm check-and-tell for launch, install after.**
> Say so and I will scope it out of ascii44 permanently rather than carry it.

## 9. `X` = Exit -- not now, but I need to know it is coming

**You settled the Back key: `N` is no, `B` is back.** I am building that for
the 7 sites where `N` currently means "go back".

**There are 11 more where `N` means "exit"**, and you asked for `X` = Exit at
screens 14a and 18. **I am deliberately not touching those in ascii44** --
changing two of `N`'s three meanings in one build is how the confusion comes
back wearing a different letter. One key at a time, field-run between.

> **My recommendation: leave the 11 alone this build; decide `X` after the
> ascii44 field run.** Just confirm you still want `X` eventually so I do not
> lose it.

---
---

# PART 2 -- THE LICENCE

**Cloud's v3.1 draft applies every answer you typed on September 2.** It is
good, and it is close to ready for the attorney. **Six things need you.**

## 10. "It will only run on that computer" -- three of your notes ask for it

You asked for a sentence saying Checkup will only run on the PC it is licensed
to.

***Measured, ascii43:*** **Checkup computes a machine identifier, displays it,
and never compares it to anything.** It runs on any PC, every time. **A
sentence in the agreement saying the software refuses to run elsewhere would
be a false statement about how our software behaves, in a consumer contract.**
That is the same shape as the Tamper Protection defect, with legal consequences
attached.

| Option | |
|---|---|
| **A. Leave it out.** The licence states the rule; nothing claims enforcement. | What Cloud drafted. Honest today. |
| **B. Build the enforcement first, then write the sentence.** | Real work, and it needs its own decisions -- what happens when the check fails, how a legitimate move is handled, what a false positive costs a customer who paid. |

> **My recommendation: A for launch.** The attorney has already told you an
> unenforced per-PC limit is worth asking about (question B2 in the consult
> document), and B is a feature with a customer-support tail we cannot staff
> two weeks out. **If you want B, it is an ascii45 conversation, not an
> ascii44 one.**

## 11. The "when you get a new computer" paragraph -- you tagged it MARKETING

Cloud kept it, on the grounds that it states an actual term: **the move is
free and we will not make you prove anything.**

| Option | |
|---|---|
| **A. Keep it as drafted** | It is a promise a customer can rely on. |
| **B. Cut it to one sentence** | *"If you replace your PC, email us and we will move your licence at no charge."* The warmth moves to the website. |

> **My recommendation: B.** You are right that it reads like marketing. One
> sentence keeps the term enforceable and gets the tone out of the contract.

## 12. The MARKETING tags in Sections 7, 8 and 9

You tagged several paragraphs. **Cloud kept all of them, because each one is
either a disclaimer the "as is" clause depends on or the stated reason for a
term** -- and the Guide's no-refund rule leans on its paragraph directly.

> **My recommendation: Cloud is right to keep them, and you are right about
> the tone.** Tell me you meant the tone and I will flatten the sentences
> without removing the substance. **If you meant remove them, say so and I
> will show you what the "as is" clause looks like without them before
> anything is cut.**

## 13. Version control -- your question, and it is mine to answer

You asked: *"How are we going to do this and control the versions?"*

**This is not a licence question and the agreement does not depend on it.** It
is a store question: how a correction to a version reaches the people who
already bought it, and how the annual update stays a separate purchase.

> **My recommendation: leave the licence text alone and let me write this up
> separately as a store-operations note.** It needs measuring against how
> Gumroad actually delivers a file update, not deciding in the abstract.

## 14. Call it 3.1 or finalise it as 3.0?

Cloud numbered it **3.1** because it changes more than the two markers 3.0 was
waiting on.

> **My recommendation: 3.1.** The customer never sees this number -- **the
> product version is v3.1 everywhere and that is unrelated** -- and the
> attorney benefits from a version that moved when the text moved.

## 15. The Gemini write-up Cloud could not read

Your ascii43 notes at screen 25 say *"See below gemini write up"* and the next
line is screen 26. **The write-up did not survive into the file.** Cloud has
asked twice for it.

> **What to do: paste it into `ProjectDocs\` as a `.md` and tell me.** I will
> commit and push it and Cloud can read it. Without it, Cloud is answering
> that item from our own measurements, which it has done, but it cannot tell
> you where it agrees with Gemini and where it does not.

## 16. The licence has to be a web page before the store takes real money

**Gumroad's checkout requires a Terms link the buyer accepts before paying.**
You said it is a click on the website that opens the PDF.

***Measured 2026-09-02, not re-checked since: no such page exists yet.***

> **My recommendation: confirm the PDF-link form is what you want and I will
> raise it as a launch blocker with a date on it.** It is one of the few
> things left that genuinely stops the store opening.

---
---

# PART 3 -- ONE THING THAT NEEDS YOUR HAND, NOT YOUR DECISION

**`Masters\gatewayguard projects.docx` still says "Version: v3.0 (always --
this is the customer-facing version)."** Every other place says v3.1, per your
2026-08-15 instruction. **I cannot fix it** -- its generated twin would be
overwritten on the next regeneration, so the change has to happen in the
master, by you.

---

# WHAT I AM DOING WHILE YOU ARE AWAY

**Building nothing.** The build plan separates the work that needs no decision
-- roughly two thirds of ascii44 -- from the work that waits on questions 1
through 4. **I will start Block A when you confirm the report**, and Block A
needs nothing from this document.

**Done today and needing no approval:** two sourced additions to the website's
BitLocker page, the attorney questions revised for licence v3.1, and four
stale entries corrected in the briefing.
