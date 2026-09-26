# GatewayGuard — Claude Code Project Instructions
<!-- Dated: 2026-08-09 17:05 ET -->

## Project Identity

- **Product:** GatewayGuard — Windows 11 security hardening tool for non-technical home users
- **Developer:** Solo (William F. Burns III / GatewayGuard LLC)
- **Target launch:** **October 15, 2026** (Thursday). **Bill moved it from
  September 15 on 2026-09-15**, per
  `GatewayGuard_ExternalGuideReview-Comments-2026-09-15-1324.md`, so the
  format pack and the 29 VERIFY-marker measurements (T-VF1) can land in one
  guide revision **before** launch instead of after it.
  **Never write a countdown here** -- "six days" was wrong the next morning
  and stayed wrong. Write the date; let the reader subtract.
- **Current build:** ascii45 (9,689 non-blank lines / 10,081 total, 90 functions, measured 2026-09-26 after Block A) — **IN PROGRESS, NOT FIELD RUN. Block A done** (FT-268, 269, 284, 278, 279, 254, 285); Block B next.
  `Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1`. Plan
  `ProjectDocs\GatewayGuard_ascii45BuildPlan-2026-09-25-1638.md`; each block is one commit.
  **Next free FT number: 286.**
  - **ascii44 is spent and retired to `Builds\`** (2026-09-26). It was field run on SANDY
    2026-09-19/20: nine logs plus Bill's 32 notes in `Test_Results\FieldRun-ascii44\`, triaged in
    `ProjectDocs\GatewayGuard_FieldTestTriage-ascii44run1-2026-09-24-2353.md` (FT-265 to FT-285).
    ascii43 is retired too. `Tool\` holds only the current build.
  - **The fix-by-fix history of ascii44 moved out of this file on 2026-09-26** -- FT-242 to FT-264,
    FT-123b, and the write-ups of FT-259 (window height), the mouse settings and Back replaying a
    photograph -- word for word to `Archive\CLAUDE-CurrentBuildHistory-ascii44-2026-09-26-0851.md`. Every session paid ~10k tokens for it,
    and each item is also in the session log, the build's `# FT-` comments, or the ascii45 plan.
    **Read it when you need to know why a fix was made.**
  - **Rules that came out of that history and still bind every session:**
    - **A wrong GOOD is the worst result Checkup can print** -- it deselects the item, so the user
      is never offered the fix (FT-257). A value that could not be read is Unknown, never GOOD, and
      an Unknown keeps the item selected (FT-256).
    - **A source you verified against can be real but incomplete.** Before reporting that something
      is absent, check a second source (FT-258b: the ADMX files had no Public firewall profile; the
      firewall's own store did).
    - **Group Policy is not the only thing that can lock a setting.** Smart App Control locks item 4
      from a non-policy key that `Get-GGPolicyLock` does not read (FT-260, deliberately not built).
    - **Before changing what any setting's guide, website or build text says, check the "Field
      results" column** in `ProjectDocs\GatewayGuard_SettingsLocationList-*.md` (FT-262: a correct
      08-26 field result sat unread for three weeks).
    - **Password on wake is read with `powercfg /qh`, never `/query`** -- `/query` leaves out the
      hidden CONSOLELOCK setting (FT-268, measured on CGDELL 2026-09-24 and 09-25).
  - **Needs SANDY before ascii45 ships:** `Tool2\Run-MeasureSandyForAscii45.bat` -- six read-only
    measurements, run as administrator.
  - Always confirm the current build number before any edit session
  - **Line-count convention:** the quoted figure is the `Measure-Object -Line`
    **non-blank** number, per Playbook Appendix A. The old "ascii36 (6,134
    lines)" entry used the total-lines figure instead — two different methods
    on the same line, which makes gate 11's before/after size check
    meaningless. Both numbers are given above so the method is unambiguous.
  - **This line is one of five build-ID locations** (filename, `FILE:` header, `BUILD:` header, `$BuildID`, and here). Pre-Build Audit item 9 checks all five; update this line in the same edit that increments the build. It sat at ascii28 while the tree was on ascii34 — six builds stale, on the very line telling you to confirm the build number. A pointer that lies is worse than no pointer.
- **Tool name:** the tool is **Checkup**. "GatewayGuard Checkup" on first mention, "Checkup" thereafter. GatewayGuard is the company. Certified 2026-07-29. Do **not** rename the MachineID hash salt (`"GatewayGuard|"`), the Task Scheduler task names (`GatewayGuard - Quarterly…`, `GatewayGuard - Monthly…`), `C:\GatewayGuard\`, `Run-GatewayGuard.bat`, `gatewayguard.co`, or the LLC name — those are identifiers and recovery points, not prose. A blanket find-and-replace on "GatewayGuard" would corrupt every machine's ID and orphan the scheduled tasks.
- **Screen numbers:** the number comes from **a static table**, `$script:GGScreenLabels`, and the log carries the stable ID beside it (`[SCREEN-02] (shown as screen 8)`). Gate 12 / C-15's "fixed forever, never renumber" governs the **log only** — Bill overruled the user-facing half on 2026-07-28, because a user on a support call must be able to say which screen they are on.
  - **FT-172, ascii41. This replaces the runtime counter and the sentence that
    used to stand here** — *"on screen the user sees position in their
    journey."* That was the old model, and it was the defect: `Get-ScreenNumber`
    counted in **encounter order at runtime**, so the number was a property of
    **the run** and not of **the screen**, and two users got different numbers
    for the same screen. Bill's finding 35 exists to kill exactly that.
  - **The scheme, approved by Bill 2026-08-17.** Integers for the canonical
    journey (first run, Console mode, Home, nothing skipped). Letters for
    departures from it — **one level only, there is no 8a1**. The BitLocker end
    block is main line and takes integers. Revisits are exempt: only **first
    encounters** must ascend, so the checklist hub keeps its number however
    often the user returns. A screen reachable from everywhere — the FT-189 `I`
    screen — takes **no number**, because any number would be a lie about where
    the user is.
  - **Adding a screen:** give it an ID, put it in the table **in the position
    the user reaches it**, and renumber. The table is written in viewing order
    so a human can see a decrease. **Never type a number into screen text** —
    that was cause 3 of FT-172, it put two disagreeing numbers on the same
    screen, and all six instances are now gone.
  - Full design and the call-flow walk that proves no user meets a
    first-encounter decrease: `ProjectDocs\GatewayGuard_ScreenNumberDesign-*.md`
    and `ProjectDocs\GatewayGuard_ScreenNumberTable-*.md`. Run `Tool2\Check-ScreenCoverage-2026-07-30.ps1` before every build (launcher: `Run-ScreenCoverageCheck.bat`); it is the mechanical gate-12 check and reports the next free ID (**90 as of ascii43, measured 2026-08-22** -- this line said 88 and was two stale, on the paragraph that warns about stale pointers. 88 as of ascii41 — 83 went to the FT-171d exit confirmation, 84 to the FT-189 "about this run" screen, and 85/86/87 to the three intro screens that FT-172 finally gave IDs to).
- **Review every screen:** `Tool2\Show-AllScreens.bat` walks all **72** screens without running checks or changing anything. It reads the .ps1's own source via the AST, so it cannot drift from the real screens.
- **26 lines per screen maximum, and every screen ends with a blank line.**
  Bill's rule, 2026-07-30 (field note 11), superseding the ascii37 25-line
  rule. The trailing blank line is produced centrally in `Write-GGBox`, so a
  new screen gets it automatically and cannot forget it. The 26-line limit is
  gate 12b in the coverage checker, run as a **ratchet**: ten screens were
  already over when the rule was written (72, 50, 73, 26, 27, 65, 60, 41, 30,
  52) and sit in a named baseline inside the checker — reported on every run,
  but not failing the gate. **Any screen not on that list that exceeds 26
  lines fails the build.** Delete an entry from the baseline as you split that
  screen; the list is only ever allowed to get shorter.
- **Language:** Python (primary tool), PowerShell (.ps1 for system edits), batch (.bat for launchers)
- **Platform:** Windows 11 Home and Pro only

---

## Build Naming Rules

- Build names follow the convention: ascii11, ascii12, ascii13 … (incrementing integer after "ascii")
- **Never reuse a build number.** Every saved output is a new build number.
- Same-day superseding builds still increment (e.g., ascii26 superseded same night by ascii27 — both exist)
- Always state the new build number explicitly before presenting output

---

## Pre-Build Checklist (run before presenting any .py output)

1. Audit source for **duplicate function definitions** — flag every duplicate found before proceeding
2. Confirm all `.ps1` edits use **assert-guarded Python replacements** (no raw PowerShell string edits without assertion). **No cosmetic exemption** — lint, comment, and whitespace passes are in scope. Violating this on a lint pass corrupted ascii34 on 2026-07-25.
2a. **File integrity after every edit session:** the file parses (`[Parser]::ParseFile` → 0 errors) and its line count is plausible. **Brace balance alone is not enough** — the corrupted file measured 47,232/47,232 braces, perfectly balanced and completely destroyed. See DefectPreventionPlaybook Class 7.
3. Confirm **`-join`** is used, not `Join-String` (PowerShell 5.1 compatibility)
4. Confirm **console flags are re-asserted before every read**, not once at startup
5. Confirm **ASCII conversion replaces all Unicode characters** before output
6. Confirm build number has been incremented from the previous build
7. Confirm all screens have pauses and a **Back option at every prompt**
8. Confirm no accidental exit without confirmation dialog

---

## Coding Standards

### PowerShell / .ps1
- Use `-join` not `Join-String` (PS 5.1 compatibility — target machines may not have PS 7)
- All `.ps1` edits must go through assert-guarded Python wrappers — never edit registry or system settings via raw string manipulation
- Console flags must be re-asserted before every read operation (not once at startup — see FT-63: Mark mode pauses execution on writes)

### Python
- Build from a clean known-good base — never patch a patched file without confirming the base
- Run the pre-build checklist above before presenting any file
- ASCII conversion must replace **all** Unicode characters before output

### General
- No self-elevation in the launcher (Malwarebytes flagged self-elevation as exploit payload — do not reintroduce)
- Tool version is always **v3.1** in all user-facing text. **Bill, 2026-08-15:
  "use 3.1 everywhere."** This rule said **v3.0** until that decision, while
  the build had been shipping `$ScriptVersion = "3.1"` and printing `v3.1` in
  eight user-facing places. The rule was the thing that was wrong, not the
  build — so the rule moved. **Still carrying v3.0 and needing Bill's hand:**
  `Masters\gatewayguard projects.docx`, which says *"Version: v3.0 (always —
  this is the customer-facing version)"*; its generated twin cannot be edited
  directly because the next regeneration would overwrite it.
- For personal computers only — do not generalize to enterprise or server scenarios

---

## Product Rules (User-Facing)

- **Name no third-party antivirus or password-manager product, anywhere —
  tool, guide, or website.** Only **Microsoft Defender (USA)**, the protection
  built into Windows, is named. **Bill, 2026-09-25: "remove AV names from
  guide"** — this removes Malwarebytes from the guide too, reversing the
  2026-09-08 guide-only arrangement. See Approved Products below.
- Always include country of origin for AV recommendations
- Never name unapproved or competitor products
- "For your protection, your choices can be reviewed in your log" — shown **once only**, on the review screen
- Use **"HEADS UP"** wording, not formal "NOTICE"
- Non-recommended warnings use **Y / N / S** options
- **BitLocker** is always the last item, on its own dedicated screen showing RAM + drive size + type + estimated time
- **GOOD items** auto-skip during run, offered for change at the end
- Font instructions shown as the **very first screen** before any code runs

### THE KEYS MEAN ONE THING EACH (Bill, 2026-08-30)

**Bill's words: "N always means no and B should always be used to say back."**

- **`N` = No.** Never "go back", never "exit", never "skip to the next
  thing". Just no.
- **`B` = Back.** It is the only Back key.

**This REVERSES the earlier ruling recorded against FT-236**, which said
*"`N = go back` stays as the natural answer in real Y/N questions"* and
treated the ascii43 field checklist's demand -- *"B is the ONLY Back key, N
must never take you back"* -- as a defect in the checklist. **The checklist
was right. FT-236 is withdrawn on its premise**, and the build is what has to
move.

**Why the earlier ruling failed in the field.** ***measured, ascii43 source,
2026-08-30:*** `N` currently carries **three different meanings across 30 call
sites** -- No at 12, "go back" at 7, and "exit/leave" at 11. A user cannot
predict what `N` does before pressing it, which is a head-on breach of the
User-Facing Clarity Rule below. Bill hit this at screen 27 and wrote
*"Don't use N to go back use B, Change everywhere it is needed."*

**THE `B` HALF IS BUILT, in ascii44, 2026-09-06.** Five sites where `N`
actually navigated backward now use `B`: the resume re-check, the
critical-deselected review, the encryption decline, the BitLocker decline,
and screen 27. ***measured after the change: no prompt in the build
advertises `N` as Back.*** Two of the seven the triage listed were left
alone on purpose -- "Still correct?", where `N` already means no and
navigates nowhere, and the Sleep/Display question, where `N` never went
back at all and only the label said it did (label fixed, key kept).
**The 11 `N` = Exit sites are untouched**, waiting on the `X` decision.

**The model to copy already exists in the build** -- line 8667:
`@("Y","N","B")` / `"Choice (Y = Re-apply / N = Skip / B = Back): "`. It is
the **only** one of 30 sites that offers `B`.

**`X` = Exit. DECIDED -- Bill, 2026-09-25: "use X."** It had been open since
he asked for it at screens 14a and 18 on 2026-08-30. ***Measured 2026-09-25:
`X` appears in no key comparison anywhere in ascii44*** -- it is free, like
`F`, `D` and `L`. **The 11 `N = Exit` sites become `X = Exit` in ascii45**
(6 found by prompt wording on 09-25; the build step re-counts all 11), and
every exit keeps the FT-171d confirmation. After this, **`N` means No and
nothing else, `B` means Back, `X` means Exit.**

Full measurement and the site-by-site list:
`ProjectDocs\GatewayGuard_FieldTestTriage-ascii43run2-2026-08-30-1723.md`,
Part 4 item 1.

---

## Website Copy Must Match the Written Guide

**The rule lives in `WebSite\Rules\website-copy.md`** (moved there
2026-08-09). A path-triggered pointer remains at
`.claude/rules/website-copy.md`, so it still loads automatically whenever you
touch `WebSite/`, any `.html`, or a guide doc — the rule is in front of you
exactly when it applies and costs nothing the rest of the time.

**Why it moved:** it was in `.claude/rules/` from 2026-08-02. `.claude` is a
dot-folder, and dot-folders are routinely filtered out of file pickers as
hidden — so the rule might not have been selectable when connecting Claude
Cloud to the repository. A rule Cloud cannot see is a rule Cloud does not
follow, and Cloud's own snapshot still carried this rule inline from before the
2026-08-02 move. `WebSite/` is in the connector scope; `.claude` may not be.

The one line worth carrying everywhere: **the guide wins on substance,
plain English wins on expression** — and jargon gets deleted, not
explained. Full rule: WebsiteStandards RULE W-07, delivery gate H-4.

---

## Plain Language and No Dead Ends

Applies to the website, the written guide, **and** the tool's on-screen
copy. Full rule: WebsiteStandards RULE W-08.

- **No pedantic phrasing.** Language that is overly meticulous, dwells on
  trivial details, or reads as condescending. Say the thing that matters,
  once. ("the tool told you so at the time" — cut it.)
- **No technical jargon.** Remove it, don't gloss it. See substitutions
  above.
- **Every check step states the desired state and the fix.** Not "look at
  the switch" — "It should say On. If it does not, turn it on."
- **No dead ends.** If you tell them to do something, tell them how, and
  what to do when that route isn't available. "Update the driver" alone
  is a dead end.
- **Copy buttons** anywhere the reader must copy a command, key, path, or
  URL. Never make a senior select text by hand.
- **Headings that promise detail say so** — "(explained fully below)".

### Banned words: "whether" and "whereas" (Bill, 2026-08-02)

**Never use either, anywhere user-facing** — screens, website, guide,
marketing. No exceptions.

"Whether" hedges. It describes what was *looked at* instead of what was
*found*, and the reader is left holding a question rather than an answer.
Every one of the 19 website pages opened its "What Checkup found" box with
*"Whether X is enabled…"* — 26 instances across 18 pages — which told the
reader nothing. Replace with **"Checkup checks if…"** and then say the
answer.

Substitutions: *whether X* → **if X**; *not sure whether you did* →
**cannot remember doing**; *applies whether A or B* → **applies when A or
B**; *asked whether to* → **asked for your permission to**.

### Use the verb Checkup uses: "turn on" / "turn off", never "switch"

**Measured 2026-08-02:** Checkup's own screens say **"turn on/off" 23 times**
and "switch on/off" 3 times. Windows Settings says **"Turn on."** The website
said "switch" **23 times** — because that is the verb Claude chose when
writing the permission wording that morning, without checking what the product
already said.

That is a straight breach of **D-18**: *where the tool already says something
on screen, reuse the tool's wording rather than writing a parallel version.*
A parallel version is exactly what got written, across 15 of the 19 pages.

Three reasons "turn" wins, in order of weight:

1. **Checkup says it.** D-18. The product's vocabulary is the vocabulary.
2. **Windows says it.** The Settings toggle reads *Turn on* / *Turn off*. A
   senior hunting for a "switch" will not find that word on their screen, and
   the literal-on-screen-labels rule applies.
3. **"Switch off" is British.** GatewayGuard is Maine, writing for American
   seniors. "Turn off" is the natural register.

**One sense of "switch" that is NOT covered by this rule** — do not sweep it
blindly:

- **The noun, meaning the toggle control the user clicks** — *"the Memory
  integrity switch. It should say On."* That is fine; it is a thing on screen.

**The powering-on exemption is withdrawn (Bill, 2026-08-12.)** This rule
formerly carried a second exemption: *"Powering a machine on — wake-on-lan's
'switch on hundreds of computers overnight' is a different verb entirely.
Leave it."* All five occurrences in `wake-on-lan.html` are now "turn on" /
"turning on", by Bill's instruction, and the exemption is removed so the rule
and the build agree.

The exemption was linguistically defensible and practically wrong. Two
reasons it went:

1. **The reader does not know which sense they are reading.** A senior meets
   "switch your PC on" and "turn Memory integrity on" on the same site and
   has no way to tell that one is an exempt verb and the other a governed
   one. One verb for one action is the whole point of D-18.
2. **An exemption stated as a quoted sentence protects only that sentence.**
   It named *"switch on hundreds of computers overnight"* and left the four
   other occurrences on the same page unaddressed and unflagged. That is how
   the page ended up with five, of which a narrow verb regex found three.

**The verb rule is now unconditional: "switch" is never the verb.** The noun
survives. Nothing else does.

**The general rule this is an instance of: before choosing a verb for
something Checkup does, grep the build for how Checkup already says it.**
The tool is the dictionary. Writing fresh words for a thing that already has
words is how the guide, the website and the screens drift apart — which is
what RULE W-07 exists to prevent, pointed inward.

### Say who authorized it, every time a setting is described

Any sentence describing what Checkup does to a setting names **the user's
permission**. This is not decoration — it is the product's central promise
("Checkup never applies anything you did not choose"), and a reader who is
told what a program changed, without being told they approved it, has been
given a reason to distrust the program.

- **"It can switch it off with your permission."**
- **"Checkup never starts encryption without your explicit permission."**
- **"Checkup asks your permission first."**
- Where Windows forbids programmatic change, say that instead:
  **"Windows does not allow any program to change this one, so Checkup shows
  you the exact steps to do it yourself."**

Applied to all 19 guide pages 2026-08-02. **Paid off in ascii40, 2026-08-15**
— the three user-facing strings that still said "whether" (the
convenience-review line and two Device Encryption screens) are gone.
**measured on the ascii40 source: zero occurrences of "whether" in any
user-facing string.** The two box lines were length-preserved, because
`Write-GGBox` sets the box width from its longest line and FT-117/FT-122 are
both width defects not worth re-earning over a copy fix.

---

## Research Before Asserting — in conversation, not just in the tool

`RESEARCH BEFORE STATING` (CodingStandards) governs what gets coded into the
tool and written into user-facing copy. **It also governs what Claude tells
Bill.** Added 2026-07-30 after four wrong assertions in one session, every
one of which the machine could have settled beforehand.

- **Before stating any fact** about system behaviour, a machine's state, or
  the cause of a defect — **verify it, or label it unverified.**
- **Prefer running the check over asking Bill to run it.** Most are available
  locally. Asking Bill costs a round trip and his time; running it costs
  seconds.
- If it cannot be verified, write **"check whether X"**, never **"X is"**.

**Every claim carries its basis, using these four words:**

| Label | Means |
|---|---|
| **measured** | I ran it — output shown |
| **sourced** | Documented, with the link |
| **inferred** | Reasoning from evidence; could be wrong |
| **guess** | A hypothesis. Treat as such |

A claim with no label is being asserted as fact, so it had better be one.

**What earned this (2026-07-30):** "the Off row is almost certainly Kernel DMA
Protection" — msinfo32 said Kernel DMA was **On**; the Off row was Secure
Boot. "The crash was in my look-back code" — the PowerShell event log showed
**no event at all** at the crash time, proving an external process kill
(Bill's own X-click theory, which was correct). "Absent = default" for Edge
settings — broke on the second machine. Each was a *guess* presented as a
conclusion, and each cost a round trip to disprove.

**The asymmetry:** checking costs seconds, a wrong assertion costs a build.
That is FT-116 and FT-120 in this project's own defect record.

### THE FIRST EXPLANATION THAT FITS IS NOT THE ANSWER (added 2026-08-17)

Bill: *"How can I get you to research all possible alternatives and not
generalize on the first one you think is the obvious answer?"*

**This is not a research failure. It is a stopping failure.** In both cases
that earned this rule, the evidence that disproved the conclusion was
**already on the table when the conclusion was published.** No further
searching was needed — one question was.

**Before any "X is the mechanism / X is the cause / it affects N things"
claim, run these three. All three, every time.**

1. **What ELSE could produce this symptom? Name the alternatives out loud,
   even to dismiss them.** For a mechanism in code, the concrete form is: *is
   this the only function that does this job?* Grep for the others. It costs
   ten seconds.
2. **Does this contradict anything already known?** The field report, an
   earlier measurement, or Bill's direct experience at the keyboard.
   **THE FIELD WINS.** If the conclusion disagrees with what Bill saw, the
   conclusion is wrong until it can also explain what he saw. Do not publish
   a claim that cannot account for the contradicting evidence.
3. **Am I counting the thing, or a proxy for it?** A count looks measured even
   when it answers the wrong question, which is where false confidence comes
   from.

**What earned this (2026-08-17, both in one session):**

- **"Back is broken on 34 screens."** Read `Read-ValidKey`, found 34 Y/N
  prompts with no `B`, published. **Never asked whether it was the only
  reader.** It is not: `Pause-ForUser` has 71 call sites and `Read-NavKey` 7,
  and both handle Back. Back works on **pages** and not at **questions** —
  a much smaller and differently-shaped defect. **Bill's own field report,
  the document being triaged at that moment, said "B works on every screen
  except 19."** Two contradicting claims were in front of each other and were
  not reconciled.
- **"BitLocker is 14 screens across 5 functions."** A decision was put to Bill
  built on that structure. When it was finally checked, **three of the
  fourteen were somewhere else entirely** — inside the checklist loop, not the
  BitLocker block. The question had to be withdrawn and re-asked.

**Proportionality — this is not a demand to exhaust everything.** Cheap checks
always; exhaustive search only when the claim is load-bearing. The test for
load-bearing: **would Bill make a decision, or would a build change, if this
were true?** If yes, check the alternatives before saying it. The two failures
above were both load-bearing — one asked Bill for a decision, the other set
scope for a build.

**This is the same asymmetry as the rule above it, one level earlier.** That
rule says verify a claim before asserting it. This one says a verified claim
can still be the wrong claim, if nothing checked whether something else fits
the same evidence.

### EVERY STATE CLAIM CARRIES ITS SOURCE INLINE, OR IT IS NOT MADE (added 2026-08-18)

Bill, 2026-08-18: *"It seems to me that your design is constantly causing
errors and mishaps which cause delays in my completing my project. What can I
do about it?"*

**Five wrong assertions in one session, all the same shape.** "Back is broken
on 34 screens." "BitLocker is 14 screens across 5 functions." "Device
Encryption requires a Microsoft account." "SANDY has no OneDrive." Each was
reasoning from something adjacent instead of reading what was on disk, and
**in every case the disproving evidence was already in the repository.**

**THE RULE ADDED THIS MORNING DID NOT WORK.** "The first explanation that fits
is not the answer" was written at 09:00 and three more wrong claims followed
it the same day. It failed because it asks for a judgment at a moment when no
judgment is happening -- the claim comes out mid-sentence, not at a checkpoint.
This one replaces the judgment with a **format requirement**, which is
checkable by eye.

**Any sentence asserting the state of a machine, a file, or a behaviour must
carry, in that sentence, the thing it was read from:**

- a **path and line** -- `Read-ValidKey, line 2329`
- or a **command and its output** -- `measured: Get-PhysicalDisk returns MediaType SSD`
- or a **file in the repo** -- `Test_Results\OneDriveSync-SANDY-2026-08-12_13-15.txt`

**With no source, the sentence does not get written.** Write "not measured" or
run the check. **"Not measured" is always acceptable and never costs a round
trip. A wrong assertion always does.**

**WHAT BILL CAN DO, and it is four words: "What did you read?"**

Ask it of any claim that matters. It takes seconds, it cannot be answered
plausibly without a real source, and every one of today's five errors would
have died on it. He should not have to -- but it is the fastest lever he has,
and it works immediately.

**THE PART THAT ALREADY WORKS, AND WHY.** Today's build went through
`gg_edit` and the gates, and **the guards caught four of my mistakes before
they shipped**: SCREEN-81 and SCREEN-88 over the 26-line rule, the console-font
banner one character wider than its own border, and an ambiguous Ctrl+C anchor
that matched two functions. Nothing corrupt reached the file.

**So the errors are not in the code. They are in the talking.** The guarded
pipeline has assertions; conversation had none. That is the asymmetry this
rule closes -- a claim in chat now needs the same evidence a replacement in
`gg_edit` needs, for the same reason.

### This covers COMMAND FLAGS, not just behaviour (added 2026-08-02, FT-162)

An argument you pass to an external program is a factual claim about that
program. **Never write a flag or a flag VALUE you have not seen in that
program's own `-?` output, or run.**

**What earned this:** the build shipped
`MpCmdRun.exe -Scan -ScanType 4` in the quarterly scheduled task, and told
the user on screen that it "SCHEDULES the offline scan for your NEXT PC
restart." **ScanType 4 does not exist.** MpCmdRun documents 0-3. Measured on
CGDELL 2026-08-02: it returns `0x80070667 -- Invalid command line argument`
in **0.0 seconds** and does nothing. The quarterly Defender scan has never
run on any machine, for as long as it has shipped — and the log printed
`[GOOD] Scheduled task created` every single time. The correct call,
`Start-MpWDOScan`, was already in the same file, twelve hundred lines away.

**The rule that forbids this already existed. Nothing checked it.** That is
the whole lesson: a gate with no check is a wish.

- **Test on the Dell first.** It has Defender, BitLocker, TPM, Secure Boot
  off, and a trial-expired Malwarebytes — most claims can be settled there
  in seconds. Say plainly when something cannot be tested.
- **Every external command carries its evidence, in a comment beside it:**
  `# VERIFIED 2026-08-02 measured on CGDELL: ...` — basis must be
  **measured** or **sourced**. *inferred* and *guess* are not shippable.
- **Gate 24 enforces both.** Run `Tool2\Run-ExternalCommandCheck.bat` before
  every build. It fails any external command with no VERIFIED comment, and
  any screen that shows the user a raw command line (`# GATE24-OK: reason`
  suppresses a deliberate "type this" instruction).

---

## GETTING A FILE TO CLAUDE CLOUD -- WHO DOES WHAT

**Cloud sees a file ONLY after it has been added, committed, pushed and
synced. Proven repeatedly: it does not see it before then, and there is no
partial credit.**

The earlier version of this section listed the five steps and left out the
handoffs, so it read as "Bill puts the file somewhere and syncs." **That
instruction is false** -- between those two acts, Claude Code has to commit and
push, and nothing was triggering it. A file can sit in `ProjectDocs\`
indefinitely while everyone believes it is done. Bill caught this.

**This section is about GETTING a file to Cloud. What Cloud must do BEFORE it
writes anything is a separate document:
`ProjectDocs\GatewayGuard_CloudWorkingRules-*.md`** -- nine rules and a
paste-in block Bill drops into any Cloud session. **The one line worth carrying
here: name your base from `CURRENT.md`, say how you read it, and never carry a
factual sentence forward without naming what you checked it against.**

**Written 2026-08-25, after licence v2.2 was reconstructed from a readable twin
because the `.docx` master could not be opened, and carried forward a sentence
from a superseded draft attributing to the attorney something he never said.
Neither was carelessness. Both were the predictable result of working from what
was reachable instead of from what was current.**

### BILL

1. **Put the file in `ProjectDocs\`.** That folder is always in Cloud's scope.
2. **Say so, in one line** -- *"I put X in ProjectDocs."* **This is the
   trigger. Without it, nothing else happens.**
3. **Click SYNC NOW when, and only when, Claude Code says
   "committed and pushed -- sync now."**

### CLAUDE CODE

4. **Commit and push it, and VERIFY the push landed** --
   `git rev-list --count origin/main..HEAD` must read 0. Never report a push
   that was not confirmed.
5. **If it is `.docx`, `.pdf` or `.pptx`, generate a `.md` twin** into
   `ProjectDocs\` and push that too. Cloud cannot read the binary. **A push
   without the twin is not done.**
6. **Then, and only then, say "committed and pushed -- sync now."** That line
   is Bill's only cue. Do not say it before the push is verified, and do not
   say it when nothing Cloud can see has changed.
7. **Check the four Cloud folders at session start and session end** --
   `ProjectDocs\`, `Tool\`, `WebSite\Rules\`, `CLAUDE.md`. This is the safety
   net for a file Bill forgot to mention, not a replacement for step 2.

   **`Tool\` NOW HOLDS ONLY THE CURRENT BUILD .ps1 (Bill, 2026-08-22).**
   Everything else that used to live there -- every `.bat` launcher, every
   `Check-*`/`Test-*`/`Get-*` script, `gg_edit.py` and the `build_*.py`
   wrappers -- moved to **`Tool2\`, which is deliberately OUTSIDE the connector
   scope.** Cloud was at 89% of capacity on Tool+ProjectDocs+CLAUDE.md and the
   five superseded build `.ps1` alone were 2.1 MB of it. Superseded builds went
   to `Builds\`.

   - **Run every gate from `Tool2\`.** The `.bat` and the script it calls sit
     together, so `cd /d "%~dp0"` still works and no path was rewritten.
   - **The four build-aware launchers point at `..\Tool\`** --
     `Run-GatewayGuard`, `Show-AllScreens`, `Run-ScreenCoverageCheck`,
     `Run-ExternalCommandCheck`. Verified by running gates 12 and 24 after the
     move.
   - **If the connector ever shows `Tool2\` content, it is matching `Tool` as a
     prefix.** Rename the folder rather than moving the scripts back.
8. **Run `Tool2\Run-RepoHealthCheck.bat` at session end**, before the final
   commit. See THE REPOSITORY LIVES INSIDE ONEDRIVE below for what it watches
   and why it exists.

### THE REPOSITORY LIVES INSIDE ONEDRIVE, AND ONEDRIVE FIGHTS GIT

**Measured 2026-08-20:** all **1,441 items under `.git`** carry the
ReparsePoint attribute -- OneDrive manages every one of git's internal files as
a cloud item and replicates them to SANDY. It has already written **seven
conflict copies**, including `index`, `config`, and **both references to
`main`**.

**This does not need anyone to run git on the second machine, and the evidence
is exact.** Five of the seven are stamped **2026-08-09 14:39:27** -- the same
second as commit `094743b`, which the reflog shows was made on CGDELL -- and
they are precisely the five files a single `git commit` rewrites. Bill has
never run git on SANDY. One commit here rewrites five files, OneDrive
replicates all five, and the other machine's client conflicts on them.

**So "only run git on one machine" is not a mitigation.** It was already true
and did not prevent this. The mitigation that works is the remote: every commit
is pushed the same day, so a broken `.git` is a re-clone and nothing is lost.

**What was missing was anything that would notice.** The seven copies sat
unread for eleven days, and `CLAUDE-Sandy.md` -- a stale 21,849-byte snapshot
of this file against the live 38,325 -- sat **committed, in the repository
root, where Cloud reads it.** `.claude\rules\website-copy-Sandy.md` was a whole
stale rule in the folder Claude Code loads rules from. Both are now removed.

`Tool2\Run-RepoHealthCheck.bat` is the check. Read-only, no admin. It reports
real `fsck` damage (dangling objects are normal and are filtered out), any new
conflict copy that sits beside a file of the same name, and the unpushed count.
**A guard nobody runs is a wish** -- which is why it is step 8 above and not a
suggestion.

### WHY EACH STEP IS THERE

**A file in the folder is not in the repo.** OneDrive syncs the folder; the
connector syncs the repo; only the repo reaches Cloud. Nothing in either
interface tells you which steps have happened.

Every step has already failed here: five guide PDFs untracked until
2026-08-09; 99 files untracked that nobody had decided on; field logs arriving
untracked so a session reported "no field log exists" while it sat on disk;
and the connector index frozen thirty commits behind while answering
confidently.

**Step 5 defeats all the others.** Measured 2026-08-13 --
`MarketResearch.docx` and `MarketResearch.md`, same folder, same scope, same
commit: only the `.md` ever surfaces. The guide `.docx` was committed and
pushed for **sixteen days** while invisible. Keep the binary for safekeeping
-- git stores and versions it fine, it just cannot diff it -- and generate the
`.md` beside it. Proven: `Tool2\build_marketing_sourcepack.py`,
`Tool2\build_guide_sourcepack.py`, `Tool2\build_readable_twins.py`.

Full detail, with the evidence for each failed step: briefing section 8a.

---

## REVIEW AND CLEAN OUT THE REPOSITORY AT THE START OF EVERY SESSION

**Bill, 2026-09-04: "New rule at the start of every session review and
cleanout the repo as much as possible."**

**Run `Tool2\Run-RepoBloatCheck.bat` (gate 26) as part of session start**,
beside the briefing and `CURRENT.md`. Read-only, no admin, moves nothing.
Then act on what it reports — do not just read it out.

**What earned this, and it was mine.** ***measured, commit `17fc9fa`,
2026-09-03:*** a Claude Code session working on Gumroad store defects ran a
broad `git add` and committed **665 files** — 402 from `Store_TestFiles`, 262
from `ProjectDocs`. **256 of those were a saved PCMag web article and its
`_files` folder, 14.6 MB, landing directly in the folder Cloud reads.** The
commit message described receipts and refund terms and **never mentioned 665
files or a web page**. A day later Cloud refused to sync because project
knowledge was full, and by then the article was **79% of everything Cloud
could see**. A second commit the same day, `b4b999f`, added 177.

Gate 26's first run found a **second** one nobody had looked for: a saved
Gmail receipt, **63 files and 22.9 MB**, in `Test_Results\`. Both are now in
`Archive\`. The receipts themselves survive as PDFs, which is what the record
actually needed.

**The five things it checks, and why each is there:**

1. **The size of what Cloud can see**, against a 4 MB budget. Cloud gives no
   warning before it fills; it simply refuses.
2. **Files in Cloud's scope Cloud cannot read** — `.docx`, `.pdf`, images.
   They spend the budget and return nothing. This is why twins exist.
3. **Files over 20 KB that `CURRENT.md` does not name.** Not proof of
   anything. It is where dead weight hides.
4. **Commits that added more than 60 files at once.** This is the check that
   would have caught `17fc9fa` on the day. **A commit message that does not
   account for its own file count is the warning sign.**
5. **Any folder ending `_files`** — what a browser's Save Page As produces.
   A third-party page is never a project document.

**THE HABIT THAT CAUSED IT, stated plainly so it is not repeated: never
`git add` a directory or a wildcard when you have not looked at what is in
it.** Stage the files the work actually touched, by name. If a commit is
about receipts, it contains receipt files and nothing else. The count in
`git status` is a claim about your own change — read it before committing,
the way any other claim gets read.

**Retire, do not delete.** `git mv` into `Archive\`, which is outside the
connector scope. The file stays tracked, stays on disk, stays recoverable,
and stops costing Cloud anything. Nothing in this project has ever needed to
be deleted to solve a capacity problem.

---

## THE TEN-MINUTE RULE -- STOP AND WRITE IT UP

Bill, 2026-08-12: *"If an issue can't be solved in 10 minutes or so, write up
an issue and ask Bill to check with Claude support."*

**Applies to Claude Code and Claude Cloud alike.** When roughly ten minutes of
diagnosis has not produced a cause -- not a theory, a cause -- **stop
diagnosing and write the report.**

**What earned this.** On 2026-08-12 the question *"why can't Cloud see the
current files?"* consumed most of a day and produced **four wrong
diagnoses in sequence**: the glob instruction, a stale connector index, no
connector at all, then a platform fault. Each was consistent with the evidence
available when it was made. **One support exchange settled it in a single
reply** -- the GitHub connector exposes no live repository tool, it syncs into
project knowledge, sync is manual, and there is no way to see which commit a
snapshot reflects. **Nothing in the repository could have revealed any of
that**, so no amount of further measuring would have found it.

**The tell is repeated re-diagnosis.** A second theory is normal. A third
means the answer is somewhere you cannot reach, and the next hour will produce
a fourth.

**The write-up carries, at minimum:**

- **Environment** -- interface, model, project, date and time
- **What was expected**, and what happened instead
- **Every check run, with its actual output.** Measured, not summarised.
  Cloud's report listed its `ls`, `find` and `curl` results verbatim, and
  support's answer engaged with them directly.
- **The specific questions to be answered**, numbered
- **Why it matters here** -- what the fault costs this project

**Then hand it to Bill and stop.** Do not keep theorising while he asks. And
**when the answer comes back, apply it and correct the record** -- Cloud's
report was partly wrong, it withdrew that part on support's reply, and the
withdrawal was the most valuable line in the exchange.

**This is EXHAUST THE FORMS BEFORE CONCLUDING ABSENCE with a clock on it.**
Exhausting the forms is right; doing it for eight hours against a system whose
behaviour is documented elsewhere is not.

---

## DO NOT ASK. ACT, THEN REPORT.

Bill, 2026-08-12, after saying it three times in one session:
*"How do I stop all these unnecessary asks?"*

**THE TEST, and it is the whole rule: imagine both answers. If you would do
the same thing either way, it was never a question — it was you looking for
cover. Act.**

Applied honestly this kills almost every question. "Should I commit this?"
has one right answer and Claude already knows it. "Want me to write the
script?" — he asked for the script two messages ago. Asking costs him a round
trip to repeat himself, and it costs him the thing he is paying for, which is
not needing to hold the details.

**Banned phrasings. These are asks wearing politeness as a disguise:**

- "Want me to…?" / "Shall I…?" / "Should I go ahead and…?"
- "Say if you'd rather I hold it" / "Let me know if you want…"
- "Do you want me to also…?"
- Any closing line that hands a decision back that was already made.

**Instead: do it, then report in this shape** — what changed, the evidence it
worked, and how to undo it. The undo line is what replaces permission. It is
also more useful than permission, because it survives the session.

**ASK ONLY THESE. The list is exhaustive:**

1. **Two real paths with different consequences, and the choice is Bill's** —
   product decisions, money, anything customer-facing. *"Should customer logs
   upload to your OneDrive?"* is a real question. *"Should I commit?"* is not.
2. **Deleting anything not recoverable** — untracked files, files with
   uncommitted changes. Committed files are recoverable; delete them and say
   so. See the SessionLog 2026-08-12 entry for the three-command check.
3. **Force push and history rewrite.** Not about recoverability — they change
   what *other* copies believe, and this repository is read by Cloud.
4. **Something outside the stated task**, where doing it would widen the job
   Bill asked for.

**Everything else: act.** Wrong-and-reversible beats correct-and-unasked-for,
because the cost of a wrong action is one commit and the cost of a needless
question is Bill's attention, which is the scarce thing here.

**The failure this replaces** was not one bad question, it was a habit that
came back three times in a single session after being corrected twice. So it
is written here, in the file that loads itself every session, rather than
left in a conversation that ends.

---

## Commands Given to Bill Must Be Bounded and Tested

Ad-hoc PowerShell pasted into chat gets the same rigour as the build scripts.
Added 2026-07-30 after an unbounded `Get-WinEvent` locked up SANDY and had to
be killed by closing the window.

- **Bound every query** — `-MaxEvents`, `-First`, an explicit count. This is
  PYTHON EDITING RULES 4a ("bound every replacement") applied to the terminal,
  where there is no safety net at all.
- **Filter server-side** where the cmdlet supports it:
  `Get-WinEvent -FilterHashtable @{LogName=...; Id=...}` beats piping to
  `Where-Object`, which fetches everything first.
- **NEVER paste a command for Bill to run. Write a `.ps1` file instead.**
  This supersedes the original "one line, no wrapping" version of this rule,
  which was written on 2026-07-30 and failed the same afternoon. Measured
  record for that day: **3 commands pasted into chat, 3 mangled by
  line-wrapping (100% failure); 3 scripts shipped as `.ps1` files, 3 ran
  first time (100% success).** The last paste was 166 characters and broke at
  columns 29 and 109, so PowerShell executed three invalid fragments. The
  syntax was correct every time — the command never arrived intact. Length
  limits do not fix this; a file removes the failure mode entirely.
- **Every `.ps1` gets a paired `.bat` launcher** so Bill can double-click
  instead of typing anything (his request, 2026-07-30). Launcher rules:
  no date-time in the name; `cd /d "%~dp0"`; **never self-elevate** (the
  Malwarebytes exploit-payload flag stands); detect and report whether it is
  elevated rather than elevating; end with an Enter-only wait, never cmd's
  built-in `pause`, which prints the banned phrase "press any key"; and write
  the file as **CRLF** — `.bat` files with bare LF endings misbehave in
  cmd.exe.
- **Run the script locally first** when the machine allows. Say plainly when
  it cannot be tested.
- **Write results to a file** rather than long console output, so nothing is
  truncated on screen.
- **State whether it is read-only.** That is the reassurance Bill needs when
  something misbehaves on a test machine that field data depends on.

---

## User-Facing Clarity Rule

Every instruction given to the user must state exactly what each action does and what happens if they do not take it.

- **Never** say "press X when done" if X and "done" mean different things depending on context
- Spell out the outcome of each key or choice explicitly
- **Test:** Could a non-technical home user predict exactly what will happen before they press the key?

**Standard copy tip wording (use verbatim across all three locations):**
> Tip: To copy text from this window -- press Alt+Space, then E, then M -- drag or use Shift+arrows to select -- press Enter to copy. Press Esc to exit without copying.

The three locations this tip appears:
1. Checklist legend line (always visible)
2. Before BitLocker prep screen
3. Resume flow line

---

## Screen / UX Standards

- All screens need pauses before proceeding
- Back option at every prompt — no dead ends
- No accidental exits without confirmation
- BitLocker screen must show: RAM size, drive size, drive type, estimated time
- GOOD items auto-skip during run; offered for review/change at the end

---

## Document Formatting Standards

*(Applies to any .docx, guide, plan, or report generated alongside the tool)*

**Scope exception — working documents stay plain Markdown.** Test plans,
field checklists, test history, and any doc used at the keyboard while
running the tool are `.md` files with no font or typography requirements.
The standards below govern deliverables a reader sees — guides, plans,
and reports — not working artifacts. (Confirmed 2026-07-26.)

- Minimum **14pt body font**
- **Garamond** for guides, plans, reports, GUI text
- **Arial 14pt** for console/PowerShell output only
- Table headers: black fill / white bold text / black borders
- Table cells: white background / black text / black single-line borders with padding
- No color shading anywhere
- Page breaks between major sections
- Black and white only — no color
- Footer on every page with key sequence rule

---

## Known Issues Log (do not reintroduce)

- **FT-63:** Console text-selection / Mark mode pauses program execution on writes — console flags must be re-asserted before every read
- **Malwarebytes flag:** Self-elevation in launcher flagged as exploit payload — launcher must not self-elevate
- **UX-01 through UX-11:** Logged UX issues — confirm none are reintroduced in any build
- **OBS-01 through OBS-03:** Field observations from Dell Latitude 5430 testing

---

## Approved Products Named in Tool

- **Microsoft Defender (USA)** — the protection. In the tool and the guide.
- **Malwarebytes Free (USA)** — **OUT OF THE GUIDE TOO, from 2026-09-25.**

**BILL'S DECISION, 2026-09-25: "remove AV names from guide."** Answering
Cloud's question on naming a password manager, and confirmed when asked:
**no third-party antivirus or password-manager name anywhere** — not
Malwarebytes, Norton, McAfee, Avira, nor Bitwarden or any other password
manager. **Microsoft Defender is the only product named.** Measured
2026-09-25: Guide Parts 1–3 already name none; the old 08-22 draft that Parts
4–5 are built from names Malwarebytes 7 times, Avira 2, Norton 1, McAfee 1,
and those do not carry over. **Website follow-up, not yet done -- measured
2026-09-25, 12 product-name mentions across FIVE pages, not the three
recorded on 09-08:** `periodic-scanning.html` 7, `password-manager.html` 2,
`defender-realtime.html` 1, `phishing-protection.html` 1,
`tamper-protection.html` 1. All must match the guide (W-07).

*(Superseded, kept for the record:)* **BILL'S DECISION, 2026-09-08:
"Malwarebytes is out of Checkup."** It stayed in the guide as an **optional
second opinion the reader may choose**, and the tool stopped orchestrating it
entirely.

**Why, and it is measured on both sides.** ***Measured on CGDELL 2026-09-07
and 09-08, same twelve files, one day apart: Defender flagged 0 of 6 real
unwanted programs, Malwarebytes Free flagged 6 of 6.*** So Malwarebytes is
doing real work there. **But Cloud's answer of 2026-09-08 sharpened what that
result means, and the guide wording turns on it: the gap is partly a
disagreement about what "unwanted" MEANS, not only about what each product
can find** — one of the six is a commercially sold antivirus that
Malwarebytes classifies as unwanted, and *sourced, AV-Comparatives Feb-May
2026*, **that same aggressive line is what Malwarebytes Premium was
downgraded for.** Those are not two facts, they are one fact seen from both
sides. **So the guide may say the two vendors disagree. It may NOT say
Defender is weak on unwanted programs.**

**REMOVAL IS GENERALISATION, NOT DELETION — and getting this wrong brings
back three fixed defects.** ***Measured: `Get-MalwarebytesState` has 13 call
sites, and items 2 and 7 change their verdict on it because a third-party AV
takes real-time protection from Defender.*** **Every third-party AV does that,
not just Malwarebytes.** Replace it with a generic "which product holds
real-time protection" read from `root\SecurityCenter2` `AntiVirusProduct`,
**or FT-30, FT-33 and FT-114 return for every customer running Norton, McAfee
or Bitdefender — which is more customers than Malwarebytes ever was.**

**Also in scope of the removal, each measured:** the four Malwarebytes
screens; the scheduled task **`GatewayGuard - Monthly Malwarebytes Reminder`**
(build line 7604) **plus a one-time removal of it from machines that already
carry it**; 3 mentions in the licence; and ***THREE website pages, nine
mentions — `periodic-scanning.html` 7, `defender-realtime.html` 1,
`tamper-protection.html` 1.*** **Cloud predicted one page and zero settings
pages; all three ARE settings pages, and periodic-scanning needs rewriting
rather than editing**, because the setting only exists as a concept when
another antivirus holds real-time protection. ***Measured: pricing copy has
zero mentions.***

**SETTING 5, DEFENDER PERIODIC SCANNING, IS ALSO OUT — same decision, same
day.** It only means anything while another antivirus holds real-time
protection, which is the arrangement the tool no longer runs. **So the product
is 18 settings, not 19.**

**DO NOT RENUMBER. 5 is simply gone.** Every log ever written names items by
ID. **A gap in the numbers costs nothing; a renumber makes every earlier log
wrong about which setting it was discussing.** Same rule as the screen IDs.

**Where each setting is, what Checkup can read and change, and what it is set
to — measured, one line each:**
`ProjectDocs\GatewayGuard_SettingsLocationList-2026-09-08-2130.md`.
Re-runnable with `Tool2\Run-SettingsStatus.bat`, read-only.

## Domain / Business

- Domain: **gatewayguard.co** -- `.co`, NOT `.com`. This line said
  `gatewayguard.com` until 2026-08-24, contradicting line 16 of this same file,
  the briefing in four places, and all 57 occurrences across the 19 website
  pages. The wrong value sat in the section a reader would consult to look it
  up. Bill wrote "gatewayguard.co (NOT .com)" unprompted the same day, so the
  confusion was live.
- LLC: GatewayGuard LLC (Maine)
- Code-signing certificate required before launch (Sectigo or DigiCert, ~$200–400/yr)

---

## File Naming Convention

- Every file uses the format: **`filename-YYYY-MM-DD-HHMM.ext`** with today's
  actual date **and time in US Eastern**. **Bill, 2026-08-23: "put times in the
  filename."** This rule said `-YYYY-MM-DD` with no time until then, while most
  of `ProjectDocs\` had been carrying the time anyway -- so the rule was the
  thing that was wrong, not the practice.
  - **Why the time is not decoration.** `Update-Current.ps1` resolves "newest"
    by the date pulled out of the filename. **Two files created on the same day
    with no time are a tie, and a tie resolves silently and arbitrarily.** That
    is not hypothetical: on 2026-08-22 the pricing row resolved to a superseded
    draft because the sort could not tell two same-family files apart, and
    nothing said so. Three files created that day were renamed to carry times
    the following morning for exactly this reason.
  - **The exception: fixed-name pointers carry no date at all.** `CURRENT.md`,
    `CLAUDE.md`, `Start-Claude-Cloud.txt`. Their
    whole value is that the name never changes, so it can be written into an
    instruction without going stale. **Never add a date to one of these.**
- Internal header must show date **and time** in US Eastern Time: `# Dated: YYYY-MM-DD HH:MM ET`
- Filename date and internal header date+time must always match — update both in the same edit, never one without the other
- **READ THE CLOCK. Do not type a tidy-looking time.** Run `date` immediately
  before stamping a file and use what it returns. **Cloud caught the third
  instance in two days on 2026-08-31:** `GatewayGuard_CloudRequest-CPM-2026-08-30-2200.md`
  is stamped **22:00** in both its filename and its header, and the commit
  carrying it was made at **21:52:45** — *the document is dated eight minutes
  after the commit that contains it.* Cosmetic on its own; as a habit it is the
  same failure as an unmeasured claim, because a rounded number reads exactly
  like a measured one. **A stamp is a measurement.**
- When one file references another by exact filename (e.g., launcher referencing a build script), update that reference in the same response whenever the referenced filename changes
- See also, in `ProjectDocs\`. **Dates are deliberately omitted here — glob the
  name and take the newest.** Two of these three pointers had gone stale by
  2026-08-02 (one silently, for eleven days), which is the same "a pointer that
  lies is worse than no pointer" failure recorded above:
  - `GatewayGuard_CodingStandards-*.md` — Python editing rules, the 24 pre-build gates, recovery points
  - `GatewayGuard_DefectPreventionPlaybook-*.md` — the seven failure classes, Pre-Build Audit
  - `GatewayGuard_WebsiteStandards-*.md` — HTML build rules and delivery gate
  - `GatewayGuard_ProjectInstructions-*.md` — session rules, research and verification rules
  - `GatewayGuard_TestHistory-ascii*.md` — the field record for the current build
