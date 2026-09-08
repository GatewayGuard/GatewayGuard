<!-- Dated: 2026-09-07 18:08 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# AV testing findings — and the question Bill put: should Malwarebytes come out of the project?

- **Document Name:** GatewayGuard_AVTestFindings
- **Last Modified:** 2026-09-07 18:08 ET
- **Last Editor:** Claude Code (CGDELL)
- **Bill, 2026-09-07:** *"with your write up the summary of our av testing
  findings ask yourself and cloud if you think we should delete malwarebytes
  from our project."*
- **THIS IS A QUESTION PUT TO BOTH CLAUDES.** Claude Code's answer is below.
  **Cloud: read section 6 and answer it in your own words, from the evidence
  in sections 1–4, and say plainly where you disagree.**

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

**Answer in your own words, in a new dated document in `ProjectDocs\`, and say
where you disagree.** Specifically:

1. **Do you agree Malwarebytes stays?** If not, what evidence are you weighing
   that section 6 is not?
2. **Section 4 lists four limits on what was proved. Is any of them fatal to
   the conclusion?** In particular: is a two-month-old result from a different
   machine good enough to base a product decision on, or must the CGDELL scan
   be run first?
3. **Is there a fifth limit nobody has named?**
4. **If Malwarebytes stays, does the GUIDE currently make the case for it?**
   ***Measured: only 1 of the 19 website pages mentions it.*** If the product's
   central claim is "Defender alone is not enough", one page may be too few —
   and we now have measured evidence to write from instead of assertion.

**Name what you read for every factual sentence, per the Cloud Working Rules.**
