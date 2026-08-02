<!-- Dated: 2026-08-02 09:19 EDT -->
# GatewayGuard Field Test Plan -- ascii39

- **Document Name:** GatewayGuard_FieldTestPlan-ascii39
- **Last Modified:** 2026-08-02 09:19 EDT
- **Status:** Working document -- use at the keyboard, tick as you go
- **Build under test:** `Tool\W11-SecurityHardening-v3-ascii39-2026-07-30-2208.ps1`
- **Build size:** 8,448 total / 8,075 non-blank lines, 508,318 bytes, 0 parse errors

---

## WHY THIS ORDER

**Dell first. SANDY's encryption is a one-shot measurement.**

A finished encryption leaves no duration behind -- verified on CGDELL
2026-08-02: no start event, no complete event, and the BitLocker Operational
log ships disabled. The Dell's and the IdeaPad's encryption times are gone
for good. SANDY is the only unencrypted Home machine, so its conversion is
the single chance to capture the project's first measured timing.

Do not spend that on a build that might still die when you click the X.
Prove survival on the Dell, where a crash costs nothing.

**Also: do not switch SANDY to a Microsoft account until Phase 4.** Phase 3
exists to test the LOCAL-account branch. Switch early and that branch is
never tested.

---

## PHASE 1 -- DELL (CGDELL), about 20 minutes

Survival, plus the three detections only this machine can prove. The Dell is
the trial-expired-Malwarebytes, Secure-Boot-off, Tamper-Protection-on box.

Launch: `Tool\Run-GatewayGuard.bat` -> right-click -> Run as administrator.

- [ ] **1. FT-160 -- the X-click.** Get to the checklist, then click the
      window's **X**. Reopen the newest log in `C:\GatewayGuard\Logs`.
      **PASS:** last lines read `SESSION ENDED EARLY -- the window's X (close
      button) was clicked` followed by the full footer.
      **FAIL:** the log ends mid-sentence. Stop and report.

- [ ] **2. FT-150 -- Ctrl+C in Mark mode.** Relaunch. Press **Alt+Space, E,
      M**, then **Ctrl+C**.
      **PASS:** the tool keeps running. Press Esc to leave Mark mode.
      **FAIL:** the program ends. This is the one our own copy tip causes.

- [ ] **3. FT-149 -- queued keypresses.** At a screen that pauses to work,
      **tap Space 5-6 times quickly**.
      **PASS:** exactly one screen advances, and the log contains
      `Discarded N keypress(es)`.
      **FAIL:** several screens flash past.

- [ ] **4. FT-140 -- Malwarebytes on an expired trial.** At the checklist,
      read **item 2**.
      **PASS:** Malwarebytes reported as detected/installed.
      **FAIL:** "NOT DETECTED", or it offers to download software that is
      already on this PC.

- [ ] **5. FT-141 -- a blocked read must not become a verdict.** Read
      **item 6**.
      **PASS:** `Unknown -- Tamper Protection blocks this check; verify by hand`
      **FAIL:** "Not configured -- all 3 need to be enabled".

- [ ] **6. FT-143 -- Secure Boot on Pro.** On the system baseline screen.
      **PASS:** `Secure Boot: OFF` appears, with the recovery-key warning.
      **FAIL:** no Secure Boot line at all (that was every build before this).

- [ ] **7. FT-151 -- column widths.** Narrow the window to roughly 86
      columns and look at the checklist.
      **PASS:** no status text cut off. The log records
      `Checklist columns: window NN, name NN ..., status NN ...`.
      **FAIL:** truncated statuses on items 6, 8 or 9.

- [ ] **8. FT-159 -- swallowed errors.** Search the log for `SILENT ERROR`.
      **Any hit is a finding** -- that is the instrumentation working. Copy
      the text out.

**Send back:** the Dell log file.

---

## PHASE 2 -- SANDY, 2 minutes, READ-ONLY. Do this before anything else

- [ ] **9.** Double-click `Tool\Run-EncryptionMeasure.bat`.

**Now or never.** Once SANDY is encrypted its unencrypted profile is
unrecoverable -- drive model, media type, volume size, and how full it is.
Those are the inputs to any timing estimate, and there is no way back.

Read-only. It starts nothing and changes nothing.

**Send back:** `EncryptionProfile-SANDY-*.txt`

---

## PHASE 3 -- SANDY run 1, about 45 minutes. The LOCAL-account branch

Launch `Run-GatewayGuard.bat` as administrator.
**Do NOT switch to a Microsoft account before this run.**

- [ ] **10. FT-144 -- recovery key as a precondition.** Walk to the Device
      Encryption screens at the end.
      **PASS:** account type reads **Local**; the **recovery-key screen comes
      BEFORE the sign-in steps**; there are **four** screens, not one.
      **FAIL:** one long screen, or the key discussed only as a follow-up.

- [ ] **11. FT-153 -- screen length and trailing blank line.** The intro is
      now **6 screens** (was 5 -- the window-setup screen was split).
      **PASS:** every screen ends with a blank line; nothing runs past a
      window height.

- [ ] **12. FT-154 -- scan order.** The pre-scan reminder screen.
      **PASS:** Defender Offline Scan listed **before** Malwarebytes.

- [ ] **13. FT-155 -- item name.** Checklist item 6.
      **PASS:** reads `Edge Phishing Protection (all 3)`.

- [ ] **14. FT-152 -- the rename.** Watch for any screen still calling the
      product "this tool" where it means Checkup. Note the screen number.

- [ ] **15. FT-146/147 -- look-back.** Press **B** wherever it is offered.
      **PASS:** it never answers "this is as far back as you can go".
      Then **resize the window** and look for the B offer again --
      **PASS:** B is **not offered** at the changed width (the offer is now
      gated rather than the promise broken).

- [ ] **16. FT-148 -- compile spam.** After the run, run
      `Tool\Run-PSErrorCheck.bat` and count 4104 events during the checks.
      **PASS:** a handful. **FAIL:** dozens in one second (that was ascii38).

**Send back:** the SANDY log.

---

## PHASE 4 -- SANDY, the encryption. The measurement taken only once

- [ ] **17.** Back up anything on SANDY you would hate to lose.

- [ ] **18.** **Start `Run-EncryptionMeasure.bat` FIRST.** Leave the window
      open for the whole conversion. It samples every 60 seconds.

- [ ] **19.** Settings -> Accounts -> Your info ->
      *Sign in with a Microsoft account instead*. **Stay online** -- offline,
      the key cannot upload even with the right account signed in.

- [ ] **20.** Let Windows turn Device Encryption on. Checkup does not do
      this and must not be asked to.

- [ ] **21. FT-110, second half -- never once observed in this project.**
      Go to `account.microsoft.com/devices/recoverykey` **immediately**. The
      key is written when encryption **starts**, not when it finishes.
      **PASS:** this PC is listed with a key.
      **FAIL:** not listed. That is a major find -- report it straight away.

- [ ] **22.** **Also save the key by hand** -- print to PDF, or to a USB
      stick. Do not stake the machine on the mechanism being tested.

- [ ] **23.** Do not touch Secure Boot afterwards. It is already On here, so
      there is nothing to do. Rule: recovery key first, Secure Boot second,
      always.

**Send back:** `EncryptionSamples-SANDY-*.csv` -- the first measured
encryption timing this project has ever had. It gives elapsed minutes,
%/min, and GB/min against both used space and total volume.

---

## PHASE 5 -- SANDY run 2, WHILE it is still converting

This window closes when encryption finishes and cannot be reopened without
decrypting the drive.

- [ ] **24. FT-145 -- conversion progress.** Run `Run-GatewayGuard.bat`
      again during conversion.
      **PASS:** the Device Encryption screen reports **"Encrypting now --
      X% done"**, and account type now reads **Microsoft** (the other
      branch, which Phase 3 could not reach).

**Send back:** the log.

---

## WHAT IS NOT BEING TESTED, AND WHY

| Item | Reason |
|---|---|
| **FT-137 Gallery mode** | Untested in the field and deliberately untouched in ascii39, so this run exercises it exactly as ascii38 shipped it. Optional: `Show-AllScreens.bat`. |
| **FT-146 look-back redesign** | Gated in ascii39, not redesigned. Step 15 tests the gate, not a rebuild. |
| **Gate 24** | Currently **FAILS** on ascii39 by design -- it is flagging FT-162, which is on the ascii40 list. Do not treat that as a new problem. |
| **Build gates 12 / 12b** | Already passed at build time. No need to re-run before field testing. |

---

## KNOWN-OPEN GOING IN (do not re-report as new)

| ID | What |
|---|---|
| **FT-161** | Both scheduled tasks are blocked from running on battery; the quarterly one also will not wake a sleeping PC and never retries. Decision taken: `StartWhenAvailable` only, no `WakeToRun`. |
| **FT-162** | `MpCmdRun.exe -Scan -ScanType 4` is not a valid flag. The quarterly Defender scan has never run on any machine. The on-screen sentence describing it is false. |
| **FT-163** | The BitLocker screen reads the wrong disk (`Select -First 1` picks an attached USB stick). |
| **FT-164** | The SSD time estimate keys off RAM instead of drive size / used space. |
| **10 screens over 26 lines** | 72, 50, 73, 26, 27, 65, 60, 41, 30, 52 -- carried in the gate 12b baseline. Cosmetic. |

---

## NOTES SPACE

Number your notes to match the step numbers above so they map straight into
the TestHistory. Field note format that has worked: step number, what you
did, what you saw, what you expected.

```
1.
2.
3.
```
