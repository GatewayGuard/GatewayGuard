<!-- Dated: 2026-09-07 18:08 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# AV testing findings — and the question Bill put: should Malwarebytes come out of the project?

- **Document Name:** GatewayGuard_AVTestFindings
- **Last Modified:** 2026-09-08 07:50 ET
- **Change log:** *2026-09-08 07:50 -- section 0 (the file index for Cloud),
  3b (the Malwarebytes half), 3c (what one button press proved), 3d (the
  output problem) and a rewritten section 7 added. Both halves of the
  comparison are now measured on the same machine.*
- **Last Editor:** Claude Code (CGDELL)
- **Bill, 2026-09-07:** *"with your write up the summary of our av testing
  findings ask yourself and cloud if you think we should delete malwarebytes
  from our project."*
- **Bill, 2026-09-08:** *"add in the details and findings filenames etc. for
  cloud to review and let's get his read of all of it."*
- **THIS IS A QUESTION PUT TO BOTH CLAUDES.**
  **CLOUD: section 0 is your file index. Section 7 is your seven questions.**
  Claude Code's answer is section 6b, and section 6a records that the first
  answer was wrong because it was written without reading Cloud's own research.
  **Both halves of the comparison are now measured on the same machine** —
  Defender in section 2, Malwarebytes in 3b, the control that makes them mean
  anything in 3, and what a single button press proved in 3c.

---

# 0. EVERY FILE THIS RESTS ON — CLOUD, THIS IS YOUR INDEX

**Cloud cannot list a directory, so every filename is written out here.** All
paths are from the repository root. **Ask Bill to attach any of these you
cannot retrieve** rather than reasoning around a file you could not open.

## The evidence — `Test_Results\`

| File | What it holds |
|---|---|
| `PUASampleSearch-CGDELL-2026-09-06_16-42.txt` | the six specimens recovered from the backup drives, each confirmed by SHA-256 |
| `PUAComparison-CGDELL-2026-09-07_12-29.txt` | Defender run 1 — with a folder exclusion |
| `PUAComparison-CGDELL-2026-09-07_12-52.txt` | Defender run 2 — **no exclusion** |
| `PUAComparison-CGDELL-2026-09-07_13-26.txt` | Defender run 3 — reputation settings on, excluded |
| `PUAComparison-CGDELL-2026-09-07_13-27.txt` | Defender run 4 — reputation settings on, no exclusion |
| `ScanControl-CGDELL-2026-09-07_12-31.txt` | **the control** — EICAR in the same folder, same command, found in seconds |
| `AVTestKit-Manifest-CGDELL-2026-09-07_12-45.txt` | the six EICAR placements as staged |
| `Malwarebytes Custom Scan Report 2026-09-08 070306.txt` | **Malwarebytes run 1** |
| `Malwarebytes Custom Scan Report 2026-09-08 071949.txt` | **Malwarebytes run 2, as administrator** |
| `MBScanResult-CGDELL-2026-09-08_07-09.txt` | run 1 parsed out of Malwarebytes' own JSON record |
| `ProtectionHistory-CGDELL-2026-09-08_07-38.txt` | **what Defender did when Bill pressed Start actions** |
| `MBCustomScan-SANDY-2026-07-19_1505.txt` | the original 2026-07-19 SANDY scan that started all of this |

## The tools — `Tool2\`

`Find-PUASamples-2026-09-06.ps1` (recovered the specimens) ·
`Test-PUAComparison-2026-09-07.ps1` + `Run-PUAComparison.bat` (the Defender
runs) · `Test-ScanControl-2026-09-07.ps1` + `Run-ScanControl.bat` (the control)
· `Read-MBScanResult-2026-09-07.ps1` + `Run-MBScanResult.bat` (reads
Malwarebytes' JSON) · `Check-ProtectionHistory-2026-08-28.ps1` +
`Run-ProtectionHistoryCheck.bat` (writes Defender's history to a file) ·
`Make-AVTestKit-2026-08-21.ps1` + `Run-AVTestKit.bat` (the EICAR placements) ·
`Run-PUATestCleanup.bat` and `Run-AVTestKitCleanup.bat` (undo)

## The documents that bear on the decision

- **`GatewayGuard_CloudResearch-ascii43-2026-09-05-0018.md`, items 9–11** —
  **Cloud, this is your own work, and it is the most important document here.**
  It carries the AV-Comparatives evidence and the pre-registered decision rule.
- `GatewayGuard_PUASamplesRecovered-2026-09-06-1650.md` — how the specimens
  were found, and the two corrections that came with them.
- `GatewayGuard_AVScanCoverageTest-2026-08-21.md` — the protocol the EICAR kit
  follows, and the reserved `07_pua` slot these specimens were staged into.

---

# 1. WHAT WAS TESTED, AND WITH WHAT

**Six real potentially-unwanted programs**, not test files — the six distinct
specimens Malwarebytes flagged on SANDY on 2026-07-19, recovered from the E:
and G: backup drives on 2026-09-06 and each confirmed by SHA-256 against the
scan report.

| Specimen | What Malwarebytes called it |
|---|---|
| `clientsetup_d-0.exe` | PUP.Optional.DllFilesFixer |
| `claimid800393432willianf_burnsiii.zip` | PUP.Optional.DllFilesFixer |
| `Wave Browser.exe` | PUP.Optional.Wave |
| `Wave Browser (2).exe` | PUP.Optional.Wave |
| `TotalAV.exe` | PUP.Optional.TotalAV |
| `ZoomInfoContactContributor.exe` | PUP.Optional.ZoomInfo |

**Nothing was ever executed.** These are installers; running one installs the
thing. The scanners were pointed at the folder and the files were only read.

**Kit:** `Tool2\Test-PUAComparison-2026-09-07.ps1`,
`Tool2\Test-ScanControl-2026-09-07.ps1`, cleanup and launchers beside them.
**Full logs:** `Test_Results\PUAComparison-CGDELL-2026-09-07_*.txt` and
`Test_Results\ScanControl-CGDELL-2026-09-07_12-31.txt`.

---

# 2. THE RESULT: DEFENDER OBJECTED TO NONE OF THE SIX

***Measured on CGDELL 2026-09-07, four runs:***

| Run | Conditions | Real-time took | On-demand scan |
|---|---|---|---|
| 12:29 | folder excluded from Defender | **0 of 6** | **no threats** |
| 12:52 | **no exclusion at all** | **0 of 6** | **no threats** |
| 13:26 | reputation settings turned on, excluded | **0 of 6** | **no threats** |
| 13:27 | reputation settings on, **no exclusion** | **0 of 6** | **no threats** |

**The answer did not move.** Not with an exclusion, not without one, not
before the reputation settings were turned on and not after.

***Measured throughout:*** PUA blocking was **on** (`PUAProtection = 1`, set
locally, no policy overriding it), real-time protection on, cloud protection
on Advanced, block-at-first-sight on, signatures from 03:26 that morning.

---

# 3. WHY THAT RESULT COUNTS — THE CONTROL

**"Found no threats" has two meanings and they are opposites:** *I looked and
these are fine*, or *I never looked*. The words alone cannot tell them apart,
and a result that cannot distinguish those is worth nothing.

***Measured:*** the EICAR test string was written into **the same folder** and
**the identical command** was run. Defender found it in seconds and named it
`Virus:DOS/EICAR_Test_File`.

**Two things follow, and both were in doubt beforehand:**

1. **The scan does look at that folder.**
2. **`-DisableRemediation` really does ignore folder exclusions**, exactly as
   MpCmdRun's own help states — so the exclusion never blinded the scan.

***Measured, second control:*** the project's own AVTestKit planted EICAR in
six hiding places on C:. **Defender's on-demand scan found all six** — plain
file, renamed extension, six folders deep, hidden+system, **inside a ZIP**, and
**inside an alternate data stream**.

> **Defender's scanner is thorough and it was working.** It looked at the six
> PUPs and did not object. That is a verdict, not a gap in the test.

---

# 3b. THE MALWAREBYTES HALF — RUN 2026-09-08, AND THE GAP CLOSES BOTH WAYS

**Bill ran it the next morning.** Report:
`Test_Results\Malwarebytes Custom Scan Report 2026-09-08 070306.txt`;
parsed to `Test_Results\MBScanResult-CGDELL-2026-09-08_07-09.txt`.
**Limit 4.1 below is now closed** — both halves are measured on the same
machine, on the same twelve files, within a day of each other.

***Measured. Malwarebytes 5.6.5.306, licence Free, definitions 1.0.114296,
custom scan of `C:\AVTestKit`, archives ON, rootkit scanning OFF. 12 objects
scanned, 11 detected, `Threats Quarantined: 0`, every line "No Action By
User", and all 12 files still on disk afterwards.***

| | Defender, 2026-09-07 | Malwarebytes Free, 2026-09-08 |
|---|---|---|
| The 6 EICAR placements | **6 of 6** | **5 of 6** |
| — inside a ZIP | found | found |
| — inside an alternate data stream | **found** | **NOT found** |
| The 6 real PUPs | **0 of 6** | **6 of 6** |

**Every one of the six PUP detections matches the staged file by SHA-256**, so
these are the same specimens, not lookalikes:
`PUP.Optional.ZoomInfo`, `PUP.Optional.Wave` (×2), `PUP.Optional.TotalAV`,
`PUP.Optional.DllFilesFixer` (×2, one of them **found inside the .zip**).

## What this settles, and what it does not

**IT SETTLES CLOUD'S PRE-REGISTERED RULE, COMPLETELY.** Cloud asked for
*"Defender+PUA missing a material fraction of real PUPs that Malwarebytes free
catches."* ***Measured: Defender missed 6 of 6 and Malwarebytes free caught
6 of 6.*** That is not a fraction. It is all of them, both ways.

**AND IT CUTS THE OTHER WAY TOO, WHICH THE FIRST HALF DID NOT SHOW.**
***Malwarebytes did not find EICAR in the alternate data stream — the hiding
place Defender did find.*** An ADS is a classic place to hide something.

**Run 2, 2026-09-08 07:19, settled most of that same morning.** Bill ran it
**as administrator**, and reported the reason the caveat cannot simply be
lifted: ***"MB would not let me select rootkit scan unless I ran it on entire
drive."***

***Measured, run 2's own options block: Memory ENABLED, Startup ENABLED,
Archives ENABLED, Rootkits STILL Disabled. 124,720 objects scanned against
run 1's 12 — and the same 11 detections. The alternate data stream was missed
again.***

| | Run 1, 07:03 | Run 2, 07:19, as administrator |
|---|---|---|
| Objects scanned | 12 | **124,720** |
| Memory / Startup | disabled | **enabled** |
| Rootkits | disabled | **disabled — cannot be enabled on a folder** |
| Detections | 11 | **11** |
| The alternate data stream | missed | **missed** |

**And the specimen is genuinely there — checked, because a miss means nothing
if the thing was absent.** ***Measured after both scans: the host file carries
two streams, `:$DATA` at 77 bytes and `hidden` at 70; the hidden one holds the
real EICAR string; and Defender scanned that folder again minutes later and
named it outright — `Virus:DOS/EICAR_Test_File` in
`C:\AVTestKit\06_ads\readme.txt:hidden`.***

## So the claim can now be stated, and it is narrower and more useful

**"In a custom folder scan, Malwarebytes does not examine alternate data
streams. Defender does."** Measured twice, once with administrator rights and
memory and startup scanning enabled.

**And a second finding fell out of it, which matters more to our customer than
the first: MALWAREBYTES WILL NOT DO A ROOTKIT SCAN OF A FOLDER AT ALL.** It
offers that option only on a whole drive. **So "scan this folder" is always
Malwarebytes' weaker scan**, and a senior told to check one folder gets the
weaker one without being told.

**Still genuinely open, and much narrower:** does a **full-drive** Malwarebytes
scan with rootkit scanning enabled find an alternate data stream? **That is a
different scan type, it takes far longer, and no guide sentence should depend
on it until someone runs it.**

**The two products are complementary, and now that is measured rather than
assumed.** Each found something the other missed, on the same twelve files, on
the same machine, a day apart.

---

# 3c. THE WHOLE FINDING, DEMONSTRATED BY ONE BUTTON PRESS

**2026-09-08 07:28.** Bill right-clicked `C:\AVTestKit`, chose Defender's scan,
was told a **severe** threat was found, and clicked **Start actions**. He was
not running an experiment. He was doing what any user would do.

***Measured immediately afterwards, and this is the cleanest statement of the
whole test:***

| Defender was pointed at one folder and told to act | Result |
|---|---|
| The 5 plain EICAR placements | **all removed** |
| The EICAR inside the ZIP | **removed** |
| **The EICAR in the alternate data stream** | **removed — the stream Malwarebytes could not see** |
| **Bill's 6 real unwanted programs** | **all six untouched** |

***Sources, all readable rather than a screen Bill could not copy from:
`Test_Results\ProtectionHistory-CGDELL-2026-09-08_07-38.txt`; Defender's own
event log, id 1116 detected at 07:28:56 and id 1117 action taken at 07:29:28,
both naming `readme.txt:hidden` explicitly; and a directory listing showing
07_pua still holding all six files.***

**One press of one button cleaned every specimen Defender considers a threat,
including the best-hidden one, and walked past all six real unwanted programs
without a word.** That is the case for both products, and the case against
relying on either alone, in a single observation.

**Where the output lives, since this cost Bill a question:** Defender writes no
report file. Its results are in **Windows Security → Protection history**,
which cannot be copied from. **`Tool2\Run-ProtectionHistoryCheck.bat` writes
the same information to a text file in `Test_Results\`** — detections, threat
names, and the event-log cross-check. **That is a guide item: a user told to
"check Protection history" cannot send anyone what they saw.**

---

# 3d. WHAT EACH PRODUCT GIVES THE USER AFTERWARDS — AND THIS IS A PRODUCT PROBLEM

**Bill, 2026-09-08, having just run a Defender scan:** *"not sure where output
is, won't let me copy but shows result in detail on screen if you click on
severe threat found."* **He asked the same question twice in one morning, which
is how this section came to exist.**

***Measured, both products, this morning:***

| | **Microsoft Defender** | **Malwarebytes Free** |
|---|---|---|
| Writes a report file | **No. None.** | **Yes** — a text report the user can save |
| Machine-readable record | only via PowerShell and the event log | **Yes** — JSON at `C:\ProgramData\Malwarebytes\MBAMService\ScanResults\` |
| Can the user copy the result | **No** — Protection history is a screen only | **Yes** |
| Includes file hashes | not in the UI | **Yes — MD5 and SHA-256 per detection** |

**Malwarebytes' report is why this whole investigation was possible.** The
2026-07-19 SANDY report carried **SHA-256 for every detection**, which is how
six specimens were found on a backup drive two months later and proved to be
the same files. ***Measured: a name-only search would have returned four wrong
hits on E: for one of them.*** **Defender's output could not have done that.**

## Why this matters more than it looks

**Our customer is a senior who has been told to run a scan.** If something is
found, the useful next step is almost always *show someone what it said* — a
family member, a support call, us.

- **With Malwarebytes they can.** Save the report, attach it.
- **With Defender they cannot.** They can read it on screen and nothing else.
  Bill — who builds security software — could not get it out, and said so.

**Checkup can close this, and it already owns the code.**
***`Tool2\Check-ProtectionHistory-2026-08-28.ps1` was written in August and
does exactly this*** — it reads Defender's detections, threat names and the
1116/1117 event-log entries and writes them to a text file.

**The proposal: Checkup writes Defender's protection history into the user's
own log.** Then a customer who has run a scan has something to send, whichever
product found it. **That is a Checkup feature that exists in no antivirus
product, it costs one function call, and it is squarely on Bill's "give them an
easy way to do things."**

**Cloud: question 5 in section 7 asks you to weigh this.**

---

# 4. THE HONEST LIMITS OF WHAT WE PROVED

**These belong in any decision made on this evidence.**

1. **CLOSED 2026-09-08 — see section 3b.** *(This read "THE MALWAREBYTES HALF
   WAS NEVER RUN ON CGDELL" and it was the biggest hole in the evidence. Bill
   ran the scan the next morning.* ***Measured: 6 of 6 PUPs found, every hash
   matching the staged file.*** *The comparison is now same machine, same
   files, one day apart. A new limit took its place — see 5.)*
2. **Defender's real-time protection was not observed acting on anything**
   during these runs — not on the PUPs, and not on EICAR written to an
   ordinary folder. Its **on-demand** scanner was proven working three
   separate ways; its **on-write** behaviour was not explained and is not
   claimed either way here.
3. **These files are 3 to 9 years old** (2017 to 2022). A vendor may retire a
   classification. This says nothing about what either product does with a PUP
   circulating today.
4. **One machine, one sample of six.** Six is enough to show a difference
   exists. It is not enough to size it.
5. **NARROWED the same morning, and it is now a small gap rather than an open
   question.** *(This read: the Malwarebytes scan had rootkit scanning off, so
   the ADS miss might be an options artefact.* ***Run 2 was made as
   administrator with memory and startup enabled, 124,720 objects against 12,
   and missed the stream again — and rootkit scanning could not be enabled at
   all, because Malwarebytes offers it only on a whole drive, not a folder.***
   *So for any folder scan the finding is settled.)*
   **What remains open is only this:** does a **full-drive** Malwarebytes scan
   with rootkit scanning on find an alternate data stream? Different scan type,
   far longer to run, and **no sentence in the guide should rest on it until
   someone does.**

---

# 5. HOW DEEPLY MALWAREBYTES IS WIRED IN

***Measured on the ascii44 source:*** **136 mentions** of "Malwarebytes",
**13 call sites** of `Get-MalwarebytesState`. It changes the verdict of
**three settings** — item 2 (Defender real-time), item 5 (periodic scanning),
item 7 (firewall) — because a Malwarebytes Premium **trial** legitimately
takes real-time protection away from Defender, and without that knowledge
Checkup would report a fault where there is none.

It also owns a scheduled task, `GatewayGuard - Monthly Malwarebytes Reminder`.

***Measured:*** only **1 of the 19 website pages** mentions it.

**So removal is not a find-and-replace.** The trial-aware logic exists because
its absence produced real defects — FT-30, FT-33, FT-114 are all in that code.

---

# 6. THE QUESTION, AND CLAUDE CODE'S ANSWER

## BILL'S OWN STEER, AND IT OUTRANKS EVERYTHING BELOW

**Bill, 2026-09-07, closing the session:** *"the av was just a thought. the
important thing is the user and providing them with easy way to do things."*

**Read that as the tie-breaker.** The lab scores, the detection counts and the
false-positive rates all matter less than what the senior has to DO. Any answer
that leaves the customer with a second program to run, a list of scary-looking
detections to judge, and a monthly reminder to act on, is losing on the measure
Bill has just said is the important one.

**It points at section 6b, not 6a** — take Malwarebytes out of the tool, keep it
in the guide as an optional second opinion.

## 6a. My FIRST answer was KEEP IT, and it was written without reading our own research

**Recorded because the mistake matters more than the answer.** I wrote the
section below before opening
`ProjectDocs\GatewayGuard_CloudResearch-ascii43-2026-09-05-0018.md`, which is
two days old, answers this same question with sourced lab evidence, and
**pre-registers the decision rule**. Bill had to point me at his own repository.
See section 6b for what the answer became once I read it.

**The reasoning, in one line: the product's central claim is that Defender
alone is not enough, and today is the first time this project has measured
that claim rather than asserted it.**

Six real unwanted programs. Defender, fully configured and provably looking,
objected to **none** of them. Malwarebytes named **all six**. A customer
running only Defender keeps all six.

**Removing Malwarebytes now would mean removing the second scanner in the same
week we produced the first hard evidence that the first scanner misses things.**
If that evidence had gone the other way — if Defender had caught all six — the
case for removal would be strong. It went the opposite way.

### What would change this answer

- **The Malwarebytes scan on CGDELL comes back empty or partial.** That is
  limit 4.1 above and it is unresolved. **It is five minutes of Bill's time and
  it should be settled before any decision.**
- **A licensing or liability reason.** Naming a third-party product in a paid
  tool is a legal question, not a technical one, and it belongs with the
  attorney questions rather than here.
- **Support cost in the field.** The trial-versus-free confusion is real and it
  has produced defects. That is an argument for **explaining it better**, and
  only becomes an argument for removal if it cannot be explained.

### The strongest honest case FOR removal

Stated fairly, because a decision made on one side of the argument is not a
decision:

- **It is the most complicated thing in the checklist.** Three settings change
  their verdict based on it, and three logged defects came from that logic.
- **Every added product is another thing to keep current** — versions, UI
  changes, licence terms — for a solo developer with a launch date.
- **Malwarebytes flagged our own launcher's self-elevation as an exploit
  payload.** We build around its behaviour already.

**None of those is about protection.** They are about cost and complexity, and
they are real. **But the test measured protection, and on protection the answer
is not close.**

---

# 6b. THE REVISED ANSWER: OUT OF THE TOOL, INTO THE GUIDE

**Not "keep it" and not "delete it".** **Remove Malwarebytes from what Checkup
does; keep it in the guide as an optional second opinion the reader can take or
leave.**

**This is Cloud's own fallback, reached independently and then confirmed by
Bill's steer above.** *Cloud, 2026-09-05:* *"If Defender misses what
Malwarebytes catches, keep Malwarebytes as an optional second opinion the guide
describes, not something the tool orchestrates."*

**What Cloud's research established, sourced, and what it did NOT:**

- *Sourced, AV-Comparatives Real-World Protection Feb–May 2026:* **Defender is
  ADVANCED+; Malwarebytes Premium was downgraded for above-average false
  positives.** *Sourced, Malware Protection Test March 2026, 10,000 samples:*
  Microsoft among the top-rated, the spread on the order of 0.08 points.
- **That covers MALWARE.** *Cloud, explicitly:* on PUPs, **"nobody has published
  that"**, and it named the test.
- **Cloud pre-registered the decision rule:** *"What would change my mind. The
  item-12 test showing Defender+PUA misses a material fraction of real PUPs
  that Malwarebytes free catches."*

***That test was run 2026-09-07 and Defender missed 6 of 6*** — so the rule is
**half met**. The other half, that Malwarebytes free catches them, still rests
on the 2026-07-19 SANDY report and has not been re-run on CGDELL. **Section 4.1
stands and should be closed before anything is removed.**

**Why "out of the tool" is the right shape rather than a compromise:**

- **It is the only option that reduces what the senior has to do.** Bill's
  steer, applied.
- **It keeps the one thing the test showed Malwarebytes is better at**, without
  the tool asking the user to act on scary detections that are, in the
  project's own field record, usually safe to leave alone. ***Measured, the
  2026-07-19 report: `Threats Quarantined: 0`, all 18 lines "No Action By
  User"*** — nothing was acted on and nothing went wrong.
- **It removes the complexity that has produced real defects**: 13
  `Get-MalwarebytesState` call sites, three settings whose verdict depends on
  it, FT-30, FT-33, FT-114, the monthly reminder task, and the SANDY firewall
  DHCP failure.
- **It is honest about the false-positive evidence** rather than ignoring it.

**What comes out:** the Malwarebytes screens, the monthly reminder task, the
trial-detection branches in items 2, 5 and 7, and the licence/pricing
references. **What stays:** a guide section that says, in plain words, what
Defender did and did not catch in our own testing — which we can now write from
measurement instead of assertion.

---

# 7. CLOUD — YOUR TURN

**Bill, 2026-09-08:** *"let's get his read of all of it."*

**Answer in your own words, in a new dated document in `ProjectDocs\`, and say
plainly where you disagree.** Section 0 is your index — **ask Bill to attach
anything you cannot retrieve rather than reasoning around a file you could not
open.** Name what you read for every factual sentence, per the Cloud Working
Rules.

**Start here, because it is your own work and it framed everything:**
`GatewayGuard_CloudResearch-ascii43-2026-09-05-0018.md`, items 9–11.

## The seven questions

1. **YOUR OWN DECISION RULE HAS BEEN MET. Does it hold?** You wrote: *"What
   would change my mind. The item-12 test showing Defender+PUA misses a
   material fraction of real PUPs that Malwarebytes free catches."* ***Measured:
   Defender 0 of 6, Malwarebytes free 6 of 6, same machine, same files, one day
   apart.*** **You pre-registered the rule and the result cleared it by the
   widest possible margin. Do you stand by the rule, or does something about
   the test make you want to revise it after the fact?** If the latter, say so
   openly — that is a legitimate answer and a much more useful one than a
   silent change of position.

2. **Do you agree with the landing — OUT OF THE TOOL, INTO THE GUIDE?** It is
   your own fallback sentence. Section 6b argues it is now the only option that
   keeps what Malwarebytes is measurably better at, respects your
   false-positive evidence, and reduces what the senior has to do — Bill's
   stated priority. **If you disagree, is your objection to the evidence or to
   the shape of the answer?**

3. **THE FINDING THAT CUTS THE OTHER WAY. Have I stated it too strongly?**
   ***Measured across two scans, one as administrator with memory and startup
   enabled: Malwarebytes did not detect EICAR in an alternate data stream that
   Defender detected and then removed.*** And ***measured, Bill at the keyboard:
   Malwarebytes will not offer rootkit scanning on a folder at all, only on a
   whole drive.*** **Is "in a folder scan, Malwarebytes does not examine
   alternate data streams" a fair sentence for the guide, or does it still need
   the full-drive run first?**

4. **Section 4 lists five limits. Is any of them fatal — and is there a
   sixth?** Limit 4.1 is closed and limit 4.5 is narrowed; 4.2, 4.3 and 4.4
   stand. **The one I am least sure of is 4.3: these files are three to nine
   years old.** Does that undermine the PUP result, or is a vendor's continued
   detection of an old PUP exactly the point?

5. **THE OUTPUT PROBLEM — section 3d, and this may be the most valuable thing
   in the document.** ***Defender writes no report and its Protection history
   cannot be copied; Malwarebytes writes a text report and a JSON record with
   SHA-256 per detection.*** **Should Checkup write Defender's protection
   history into the user's own log?** The code exists already
   (`Check-ProtectionHistory-2026-08-28.ps1`). **Weigh it against everything
   else competing for time before a 2026-09-15 launch, and say where you would
   put it.**

6. **IF MALWAREBYTES LEAVES THE TOOL, WHAT HAPPENS TO THE COPY?**
   ***Measured: 136 mentions in the build, 13 `Get-MalwarebytesState` call
   sites, three settings whose verdict depends on it, a scheduled task, and
   only 1 of the 19 website pages mentioning it.*** **That last number now
   looks wrong in both directions** — too few if we recommend it, too many if
   we do not. **What should the guide and the website actually say, given we
   can now write from measurement instead of assertion?**

7. **WHAT HAVE I MISSED?** Bill's steer was *"the important thing is the user
   and providing them with easy way to do things."* **Read the whole document
   against that sentence and tell me where the answer still asks too much of a
   senior.**
