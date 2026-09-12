<!-- Dated: 2026-08-21 14:20 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# AV Scan Coverage Test -- protocol and results grid

- **Document Name:** GatewayGuard_AVScanCoverageTest
- **Last Modified:** 2026-08-21 14:20 ET
- **Last Editor:** Claude Code (CGDELL)
- **Asked for by Bill, 2026-08-21:** test C: and D: with files that look like
  viruses, to see what the Defender offline scan finds, then the full scan,
  then Malwarebytes custom and deep scans -- and whether things hidden well
  are still caught.
- **Kit:** `Tool\Run-AVTestKit.bat` (stage), `Tool\Run-AVTestKitCleanup.bat`
  (remove). Both read `Make-` / `Remove-AVTestKit-2026-08-21.ps1`.

---

## 0. WHAT THE SPECIMENS ARE, AND WHY NOT REAL MALWARE

**Every specimen is the EICAR test file** -- a 68-byte text string that the
antivirus industry has agreed, since 1991, that every scanner must detect. It
is **not a virus.** It contains no code and can do nothing. It exists for
exactly this: proving a scanner is working, with zero risk to the machine.
Reference: https://www.eicar.org.

**Why this is the right tool and a real virus is the wrong one.** Detection of
EICAR is **guaranteed**. So when a scan does NOT report a specimen, there is
only one explanation left -- the scan never looked there. That isolates
**coverage**, which is the entire question: does the offline scan reach D:?
Does the full scan? Does hiding a file change the answer? A real virus would
add a second unknown -- "did the scan miss it, or was my sample not detectable"
-- and would put genuine infection risk on a machine the field data depends on.

**The rootkit question is a coverage question.** A rootkit matters because it
hides from the running OS and loads before Windows -- which is why the offline
scan boots outside Windows. We test that property directly and safely: the same
guaranteed-detected specimen is planted in the places rootkits abuse -- an
Alternate Data Stream, a hidden+system file, a deeply buried folder, inside an
archive. If a scan misses it there, that is the coverage gap a real rootkit
would exploit -- found without any real rootkit.

**No real virus. No rootkit. No hiding code. Nothing that persists or
executes.** Just a known-detected string in hard-to-reach places.

---

## 1. THE SIX PLACEMENTS (per drive)

| # | Where | What it tests |
|---|---|---|
| 01 | plain file, plain name | the baseline -- any scan should catch this |
| 02 | renamed extension (`invoice.dat`) | does the scanner read content, not just extension |
| 03 | six folders deep | does the scan recurse fully |
| 04 | hidden + system attributes | does the scan see hidden/system files |
| 05 | inside a ZIP archive | does the scan open archives |
| 06 | Alternate Data Stream | does the scan read ADS -- a classic hiding spot |

Staged on **C:** and, where present, **D:**. On CGDELL there is no D:, so the
drive-coverage half of the test **must be run on SANDY**, which has the
931.5 GB D:.

---

## 2. WHAT WE ALREADY KNOW GOING IN (measured / sourced)

Do not re-derive these -- they are settled and frame the expected results.

- **`Start-MpWDOScan` has no scope parameter** (measured on CGDELL). The
  offline scan cannot be aimed at a drive.
- **Microsoft documents the offline scan's job as firmware / rootkits / MBR**
  (sourced), and **never states which drives it scans.**
- **A full scan covers "all the fixed and removable network drives that are
  mounted"** (sourced). This is the scan expected to catch D:.
- **Defender PUA protection: CGDELL = ON (`PUAProtection = 1`, measured).**
  Check SANDY separately -- if it is off there, a PUP specimen would be missed
  by Defender and caught only by Malwarebytes.
- **Real-time protection is ON.** It removes EICAR the instant it is written.
  That is result row zero, not a problem -- see step 4.

Full detail: `ProjectDocs\GatewayGuard_OfflineScanResearch-2026-08-21.md`.

---

## 3. WHICH MACHINE

**Run the full C:-vs-D: test on SANDY.** It is the only machine with a second
fixed drive. **This test encrypts nothing and does not spend SANDY's
unencrypted state** -- it only writes and deletes harmless text files.

CGDELL can run the C:-only half (placements 01-06 on C:) as a rehearsal, to
confirm the kit behaves before it goes on SANDY.

---

## 4. THE PROTOCOL, IN ORDER

**Read this whole section before starting. Two steps touch a security setting
and both are reversible.**

### Step A -- baseline: prove real-time protection works

1. Run `Run-AVTestKit.bat` with real-time protection ON (its normal state).
2. Read the manifest. **Expect most specimens to show EATEN** -- real-time
   protection took them on write. That is a pass for real-time.
3. Note any that show KEPT. A KEPT specimen is one real-time protection did
   **not** catch on write -- the archive and ADS cases are the likely ones,
   and each is a genuine finding.

### Step B -- stage for the scan test (real-time briefly off)

**To test the scheduled/offline/full scans, the specimens must survive to
disk, so real-time protection has to be off while they are placed.** This is a
deliberate, reversible step you perform by hand.

1. **Turn Real-time protection OFF:** Windows Security -> Virus & threat
   protection -> Manage settings -> Real-time protection -> Off.
   *(Tamper Protection blocks scripts from doing this, on purpose. It is a
   manual toggle. Windows turns it back on by itself after a while, so do the
   next step promptly.)*
2. Run `Run-AVTestKit.bat`. The manifest should now show **KEPT** for every
   placement on every drive.
3. **Do NOT turn real-time protection back on yet** -- it would re-scan and
   quarantine the specimens before the scans under test can look at them.

### Step C -- run each scan and record what it reports

Run these in order, recording each in the grid in section 5. After each scan,
look at its own results/quarantine/history view for which specimens it named,
**and on which drive.**

1. **Defender Offline scan** -- Windows Security -> Scan options -> Microsoft
   Defender Offline scan -> Scan now. Reboots. Results afterwards under
   Protection history.
2. **Defender Full scan** -- Scan options -> Full scan -> Scan now.
3. **Malwarebytes Custom (Threat) scan** -- point it at C: and D:.
4. **Malwarebytes deep / hyper scan** -- whatever the longest option is.

### Step D -- clean up and restore

1. `Run-AVTestKitCleanup.bat` removes any specimens still on disk.
2. Clear anything the scanners quarantined, from inside Defender and
   Malwarebytes.
3. **Turn Real-time protection back ON** (Windows likely already did).
4. Confirm C:\AVTestKit and D:\AVTestKit are gone.

---

## 5. RESULTS GRID -- fill this in

Mark each cell: **Y** = the scan reported it, **N** = it did not,
**-** = not applicable. One grid per drive.

### Drive C:

| Placement | Real-time (write) | Defender Offline | Defender Full | MB Custom | MB Deep |
|---|---|---|---|---|---|
| 01 plain | | | | | |
| 02 renamed .dat | | | | | |
| 03 deep folder | | | | | |
| 04 hidden+system | | | | | |
| 05 in ZIP | | | | | |
| 06 in ADS | | | | | |

### Drive D:  (SANDY only)

| Placement | Real-time (write) | Defender Offline | Defender Full | MB Custom | MB Deep |
|---|---|---|---|---|---|
| 01 plain | | | | | |
| 02 renamed .dat | | | | | |
| 03 deep folder | | | | | |
| 04 hidden+system | | | | | |
| 05 in ZIP | | | | | |
| 06 in ADS | | | | | |

---

## 6. THE QUESTIONS THE GRID ANSWERS

- **Does the offline scan touch D: at all?** If the D: / Offline column is all
  N, that confirms the research: the offline scan is a system-drive tool. This
  is the evidence behind FT-230 and F4 of the ascii43 plan.
- **Does the full scan cover D:?** If the D: / Full column turns to Y where
  Offline was N, that is the proof that F4's fix -- add a full scan when a
  second drive is present -- actually closes the gap.
- **Does hiding change anything?** Compare the ADS and archive rows against the
  plain row. Any N there is a thoroughness gap, and it is the same for a real
  threat as for EICAR.
- **Do Defender and Malwarebytes differ?** Where one says Y and the other N,
  that is the case for running both -- which is what Checkup already
  recommends.

---

## 7. OPTIONAL -- THE PUP / PUA SPECIMEN

The kit above uses EICAR, which every scanner treats as malware. To test the
**potentially-unwanted-program** case -- the class most likely to be *missed*
by default -- use the **AMTSO PUA test file**, the sanctioned equivalent for
PUAs:

- Page: https://www.amtso.org/feature-settings-check-potentially-unwanted-applications/

Download it into `C:\AVTestKit\07_pua\` by hand and add a `07 PUA` row to each
grid. **Expected split:** Defender catches it only if PUA protection is on
(CGDELL: on; **check SANDY**), while Malwarebytes catches PUPs by default. That
difference is itself a finding worth the guide.

**Not automated here on purpose** -- it is a download from a third-party site,
and this kit deliberately generates its specimens offline rather than fetching
anything.
