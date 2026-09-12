<!-- Dated: 2026-09-06 16:50 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# All six PUP specimens recovered -- and two things I told Bill were wrong

- **Document Name:** GatewayGuard_PUASamplesRecovered
- **Bill, 2026-09-06:** gave the scan report and said *"search for them in the
  E: and G: drives that are now attached."*
- **Source list:** `Test_Results\MBCustomScan-SANDY-2026-07-19_1505.txt`
  -- Bill's Malwarebytes Custom Scan Report of 2026-07-19 15:05, copied
  verbatim from his Desktop into the repository. **It is the evidence the
  whole AV comparison rests on and it was living outside the project.**
- **The search:** `Tool2\Find-PUASamples-2026-09-06.ps1`
  (launcher `Run-PUASampleSearch.bat`). **Read-only.**
- **Full output:** `Test_Results\PUASampleSearch-CGDELL-2026-09-06_16-42.txt`

---

# 1. THE RESULT: 6 OF 6, ALL RECOVERED

***Measured 2026-09-06 16:42, CGDELL, 1,161,813 files enumerated across E: and
G:, every hit confirmed by SHA-256:***

| Specimen | Threat name | Copies found | Where |
|---|---|---|---|
| `clientsetup_d-0.exe` | PUP.Optional.DllFilesFixer | **29** | E: and G: |
| `claimid800393432willianf_burnsiii.zip` | PUP.Optional.DllFilesFixer | **2** | G: only |
| `Wave Browser.exe` | PUP.Optional.Wave | **2** | G: only |
| `Wave Browser (2).exe` | PUP.Optional.Wave | **1** | G: only |
| `TotalAV.exe` | PUP.Optional.TotalAV | **1** | G: only |
| `ZoomInfoContactContributor.exe` | PUP.Optional.ZoomInfo | **1** | G: only |

**36 files confirmed. Every distinct specimen the scan found is recovered.**

**Four of the six sit in one folder:** `G:\May-2023\Downloads\`.

> **THE MALWAREBYTES COMPARISON IS BACK ON.** It was blocked on having no
> samples. It no longer is.

## Why the hashes mattered, and this is the proof

**The E: drive holds four copies of a file named
`claimid800393432willianf_burnsiii.zip` -- and none of them is the one
Malwarebytes flagged.**

| | SHA-256 | Size | Modified |
|---|---|---|---|
| **The flagged file** (found on G:) | `729D0208...` | 13,529,844 | 2021-06-04 |
| **The file on E: with the same name** | `B79F43E3...` | 10,917,613 | 2017-04-14 |

**A search by filename would have reported four hits on E: and been wrong
about all four.** Different file, different year, never flagged.

---

# 2. CORRECTION: THEY WERE NEVER IN QUARANTINE

**I built a whole answer this afternoon around Malwarebytes quarantine being
permanent and irreversible. That answer was aimed at something that never
happened.**

***Measured, the scan report's own header:***

```
Threats Detected: 18
Threats Quarantined: 0
```

**And every one of the 18 lines ends `No Action By User`.**

**Nothing was ever quarantined.** The files were found, listed, and left
exactly where they were. So the question was never "can deleted quarantine be
recovered" -- **it was "where are the originals", and they were on a backup
drive the whole time.**

**What this changes going forward:** ***the files were left in place on
SANDY's D: as of 2026-07-19.*** Unless Bill deleted them himself afterwards,
**they may still be on SANDY right now** -- which would be easier still. **One
run of `Run-PUASampleSearch.bat` on SANDY settles it**, and it is read-only.

---

# 3. CORRECTION: PUA BLOCKING IS ON BY DEFAULT, AND I SAID THE OPPOSITE

**This one matters, because Bill made a decision on what I told him.**

**What I wrote in the decisions document:** *"This is the closest thing to a
genuinely missing setting the research found"* and, if left out, *"our scans
stay weaker than they need to be."*

**Both halves of PUA blocking have been ON BY DEFAULT since August 2021.**

- *Sourced, Microsoft Support, "Potentially unwanted apps are blocked by
  default":* **from early August 2021 Microsoft set PUA protection on by
  default.**
- *Sourced, Edge documentation and coverage:* **Edge's "Block potentially
  unwanted apps" is on by default too**, and it is greyed out unless Edge's
  SmartScreen is on -- so it follows a setting Checkup already handles.

***And measured on CGDELL, 2026-09-06: `PUAProtection = 1`. It is on, and
nobody here turned it on.***

## So what is setting 20 actually worth?

**Not "a missing protection." A confirmation, plus a catch for the minority
where something switched it off.**

**That is still a real job** -- several of the existing nineteen are usually
already correct, and reporting them is the product's whole purpose. **But it
is a weaker case than the one I put to Bill**, and he chose the more expensive
option (setting 20 rather than a pre-scan step) partly on my wording.

> **This does not reverse his decision and I am not asking him to re-take it.
> He should just know the case changed before I build it.**

---

# 4. A HINT ABOUT DEFENDER, AND IT IS ONLY A HINT

***Measured:*** while the search ran, CGDELL had **real-time protection on**
and **PUA blocking on**, and the script **read all six specimens** to hash
them.

***Measured afterwards: `Get-MpThreatDetection` shows no detection in the last
two hours, and all six files are still present.***

**Do not read that as "Defender missed them."** At least three other
explanations fit and I have not separated them:

1. **PUA blocking acts on download and execution**, not necessarily on a
   read of a file already sitting on a secondary drive.
2. **These files are three to nine years old.** Definitions change, and a
   2017 installer may no longer be classified.
3. `Get-MpThreatDetection` may not surface everything Defender does.

> **This is exactly the reason to run the real test rather than reason about
> it.** The proper comparison -- a controlled folder, a Defender scan, a
> Malwarebytes scan, both results written down -- now has its specimens and
> can actually be run.

---

# 5. WHAT I HAVE NOT DONE, ON PURPOSE

**Nothing has been copied, moved, renamed or deleted.** The specimens are
where they have always been.

**Assembling a test folder is Bill's call, not mine**, because it means
putting six known PUP installers together in one place on a working machine.
**When he says go, the way to do it safely is:**

- **One folder, named so nobody opens it by accident**, on a drive that is not
  the OS drive.
- **Add a Defender exclusion for that folder FIRST**, otherwise Defender may
  remove the specimens before Malwarebytes ever sees them -- and then the
  comparison measures nothing.
- **Remove the exclusion the moment the test is finished.** An exclusion left
  behind is a real hole in a real machine.
- **Nothing is ever run.** Both scanners are pointed at the folder. **These
  are installers; running one installs the thing.**

**And the existing kit already has a slot for this:**
`ProjectDocs\GatewayGuard_AVScanCoverageTest-2026-08-21.md` reserves
`C:\AVTestKit\07_pua\` for exactly these files.

---

# 6. WHAT HAPPENS NEXT

| | |
|---|---|
| **Bill** | Say go, and whether the test folder lives on CGDELL or SANDY. |
| **Bill** | Run `Run-PUASampleSearch.bat` on SANDY when convenient -- it may find them still sitting on D:. |
| **Me** | Build the test folder and the exclusion, run both scanners, write down what each one names. |
| **Me** | Verify setting 20 with the AMTSO PUA file, which tests the setting rather than the scanner. |

**Sources:**
[Microsoft -- Potentially unwanted apps are blocked by default](https://support.microsoft.com/en-us/security/potentially-unwanted-apps-are-blocked-by-default) |
[Microsoft Learn -- Edge potentially unwanted apps](https://learn.microsoft.com/en-us/deployedge/microsoft-edge-potentially-unwanted-apps) |
[AMTSO Feature Settings Check -- PUA](https://www.amtso.org/feature-settings-check-potentially-unwanted-applications/)
