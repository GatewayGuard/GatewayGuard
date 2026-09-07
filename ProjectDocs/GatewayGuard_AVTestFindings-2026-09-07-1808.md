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

# 4. THE HONEST LIMITS OF WHAT WE PROVED

**These belong in any decision made on this evidence.**

1. **THE MALWAREBYTES HALF WAS NEVER RUN ON CGDELL.** The Malwarebytes result
   is from **2026-07-19, on SANDY**, in the scan report at
   `Test_Results\MBCustomScan-SANDY-2026-07-19_1505.txt`. Same six files,
   confirmed by hash — but **a different machine and definitions two months
   old.** The comparison is real and it is half-aged.
   **The six specimens are staged at `C:\AVTestKit\07_pua` right now.** One
   Malwarebytes custom scan makes it current. **Do that before deciding.**
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

## Claude Code says: KEEP IT. The testing argues for keeping it, not removing it.

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
