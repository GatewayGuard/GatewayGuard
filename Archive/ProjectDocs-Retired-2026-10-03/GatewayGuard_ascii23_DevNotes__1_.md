# GatewayGuard ascii23 — Development Notes
**Created:** 30-Jun-2026
**Source:** Dell Latitude 5430 (Win 11 Pro) first test run of ascii22
**Status:** Planning — not yet implemented

---

## UX ISSUES IDENTIFIED IN ascii22 — TO FIX IN ascii23

### UX-01: First message flashes by too fast
**Observed:** Opening message disappears before user can read it.
**Fix:** Add `Start-Sleep -Seconds 3` or `pause` after the first message before proceeding.
**Priority:** High

---

### UX-02: Script window needs to be maximized
**Observed:** Default PowerShell window is too small — content is cramped and hard to read.
**Fix:** Add as the very first message at launch:
> *"For the best experience, please maximize this window now by clicking the square button in the upper right corner of this screen."*
Then `pause` so user can act before anything scrolls.
**Priority:** High

---

### UX-03: User needs to scroll to top after maximizing
**Observed:** After maximizing the window, earlier content is pushed up and out of view. Users miss the opening section.
**Fix:** After the maximize prompt and pause, add a second message:
> *"Now scroll to the top of this window using the scrollbar on the right side to see the beginning of GatewayGuard."*
Then another `pause` before proceeding.
**Priority:** High

---

### UX-04: No warning before offline scan launches — script window disappears
**Observed:** When offline scan is initiated, the PowerShell window closes and the computer reboots with no explanation to the user.
**Fix:** Before launching offline scan, display a clear message:
> *"Windows Defender will now run an offline scan. Your computer will restart automatically. This window will close. When Windows restarts and you return to the desktop, please run GatewayGuard again to continue where you left off."*
Then `pause` before proceeding with the scan launch.
**Priority:** High — without this, users will think the tool crashed.

---

### UX-05: No resume capability after reboot
**Observed:** After offline scan reboots the machine, user has no way to resume where they left off — must start the script from the beginning.
**Fix:** Save a state flag file to `C:\GatewayGuard\gg_state.txt` at key checkpoints. On launch, check for this file. If found, prompt:
> *"It looks like you've run GatewayGuard before. Would you like to:"*
> *"  [R] Resume where you left off"*
> *"  [S] Start over from the beginning"*
Route user accordingly based on input.
**Priority:** High

---

### UX-06: Malwarebytes section should be a standalone re-entry point
**Observed:** If user opts to resume, they should be able to jump directly to the Malwarebytes section rather than replaying earlier content.
**Fix:** Split the Malwarebytes section into a clearly labeled checkpoint in the state machine. When resuming, jump directly to this section if that was the last completed checkpoint.
**Priority:** Medium — depends on UX-05 being implemented first.

---

### UX-07: No post-scan guidance — users don't know where to find results or what to do next
**Observed:** After offline scan completes and Windows reboots, users have no guidance on where to find scan results or what action to take if threats were found.
**Fix:** After reboot and resume, display a clear walkthrough:
> "Your offline scan is complete. Here is how to see the results:"
> "1. Click the Start menu and open Windows Security"
> "2. Click Virus & Threat Protection"
> "3. Click Protection History"
> "4. Look for any items listed under Recent Actions"
> "If threats were found and removed — no action needed. Defender handled it."
> "If threats were found but NOT removed — write down the threat name and press any key. We will guide you through next steps."
> "If Protection History shows No Recent Actions — your scan came back clean."
Then pause and ask user to confirm their result before proceeding.
**Priority:** High — users currently have no idea what happened after the reboot.

---

## GENERAL ascii23 DEVELOPMENT NOTES

### Pro-specific items to address (from Dell Latitude 5430 first run):
- Remote Desktop settings (Home vs Pro behavior differs)
- BitLocker vs Device Encryption (Pro uses full BitLocker — `Get-BitLockerVolume` check needed)
- Group Policy checks (GPO available on Pro, not Home)
- Hyper-V detection (Pro feature)

### Known ascii22 items carried forward:
- Windows edition detection already in place (Home vs Pro branching)
- Malwarebytes detection logic verified on Home — needs Pro verification
- Defender/Tamper Protection registry reads confirmed working on Pro baseline

---

### UX-08: Time & Date sync not verified — users may have wrong time/timezone
**Observed:** Fresh installs and refurbished machines frequently have incorrect time or timezone (e.g. Dell defaulted to Pacific time during setup today).
**Rationale:** Incorrect system time can affect Windows Update, certificate validation, security logs, and scheduled scans. Non-technical users rarely check this.
**Fix:** Add a Time & Date check section to ascii23:
- Verify "Set time automatically" is ON
- Verify "Set time zone automatically" is ON
- Display current detected time and timezone to user for confirmation
- If either setting is OFF, enable it and trigger a sync
- Prompt user to confirm the displayed time looks correct before proceeding
**Priority:** Medium — easy win, builds user confidence that GatewayGuard is thorough.

---

### UX-09: No scan duration guidance — users may be alarmed by fast or slow scans
**Observed:** First scan on Dell Latitude 5430 (clean fresh machine) completed quickly. Users with no context may think a fast scan means it didn't work, or a slow scan means something is wrong.
**Fix:** Before launching any scan, set user expectations:
> "The scan time will vary depending on your computer. A fast scan on a clean machine is normal. A slower scan may mean more files to check — that is also normal. Please be patient and do not close this window."
**Priority:** Medium

---

---

### UX-10: No system baseline capture at launch — add as automatic up-front step
**Observed:** ascii22 jumps straight into security checks without first capturing and displaying the machine's baseline info to the user or the log.
**Rationale:** 
- Gives user confidence the tool knows what machine it's working on
- Captures critical pre-run state for troubleshooting
- Identifies edition (Home vs Pro) early so tool can branch correctly
- Flags issues before they affect results (wrong time, no AV registered, battery low)
**Fix:** Add a System Baseline section as Step 0 (before any security checks) in ascii23:
1. System make/model/RAM
2. Windows edition (Home vs Pro — drives branching logic)
3. Processor info
4. Storage type and size
5. Battery status (warn if low and not plugged in before scans)
6. Antivirus registered in Security Center
7. Defender status
8. Windows Update service status
9. Time and date sync status (fix if wrong — see UX-08)
10. BitLocker/Device Encryption status
Display results in a formatted box, log everything, then pause before proceeding.
**Reference:** See `GatewayGuard_SystemBaseline_Diagnostic.ps1` for working code and `Run-Diagnostic.bat` for the double-click launcher.
**Usage:** Run-Diagnostic.bat → Run as Administrator → review results → then run GatewayGuard main tool.
**Priority:** High — this is the foundation for all downstream checks.

---

### UX-11: Pre-scan and pre-BitLocker user preparation guidance missing
**Observed:** ascii22 launches scans and BitLocker without telling users what to do beforehand.
**Fix — Before ANY scan:**
> "Before we begin scanning, please:"
> "1. Close all open programs and browser windows"
> "2. Plug in your power adapter if you are on a laptop"
> "3. Do not use the computer while scanning"
> "4. Do not turn off or restart the computer during the scan"
**Fix — Before BitLocker specifically:**
> "Before enabling BitLocker encryption, you MUST:"
> "1. Save your Recovery Key -- you will need it if you ever get locked out"
> "2. Print your Recovery Key and store it with your important documents"
> "   (birth certificate, passport, insurance papers) -- NOT near your computer"
> "3. Also save it to your Microsoft account as a backup"
> "4. Plug in your power adapter -- encryption can take a long time"
> "5. Do not turn off, restart, or close the lid during encryption"
> "WARNING: If you lose your Recovery Key and get locked out, your data"
> "cannot be recovered by anyone -- not even Microsoft."
Then pause and require user to confirm they have saved and printed the key before proceeding.
**Priority:** High — especially the BitLocker Recovery Key warning. This is user data protection.

---

## RESULTS FROM ascii22 DELL RUN (30-Jun-2026)

| Check | Result |
|-------|--------|
| Malwarebytes scan | Clean — no items detected, completed in under 1 minute (fresh machine) |
| Windows Defender offline scan | Clean — no recent actions in Protection History |
| Overall baseline | Clean vanilla Win 11 Pro — good test baseline established |

---

## ADDITIONAL FIELD OBSERVATIONS — ascii22 DELL RUN

### OBS-01: UAC/Permission dialog disappears on Win 11 Pro after timeout
**Observed:** When the tool triggers a permissions dialog (yes/no), if the user does not respond within a few minutes the dialog disappears silently. No error, no retry — it just vanishes.
**Impact:** User thinks the tool crashed or something went wrong. High confusion risk.
**Workarounds identified:**
- Ask MS Store to reinstall Malwarebytes — it recognizes the situation and re-presents the yes/no dialog
- Search for "Malwarebytes" in the Windows search bar — can bring back the decision box
**Fix for ascii23:** 
- Warn user before any permission dialog: *"A permissions box will appear. Please respond to it promptly — it will disappear after a few minutes if left unanswered."*
- Add recovery instructions in the tool if we detect the user got stuck: *"If a permissions box disappeared, search for Malwarebytes in the Windows search bar to bring it back."*
- Also add this to the website as a Tips section for users.
**Priority:** High — this will affect real users, especially less technical ones who step away from the screen.

### OBS-02: Malwarebytes scan — fast on clean machine, no detections
**Observed:** Malwarebytes scan completed in under 1 minute on fresh Dell Latitude 5430 (Win 11 Pro). No items detected.
**Notes:** 
- Fast scan on clean machine is expected and normal
- Confirms UX-09 is valid — users need to be told fast = normal, not fast = broken
- Win 11 Pro baseline behaves same as Home for MB scan purposes

### OBS-03: Auto-detection of user device — up-front identification needed
**Observed:** Tool does not automatically identify and display the user's device make/model/edition before proceeding.
**Notes:** This ties directly into UX-10 (System Baseline as Step 0). Auto-detecting the device up front:
- Confirms to user the tool is working and recognizes their machine
- Identifies Home vs Pro early for correct branching
- Builds immediate trust — "GatewayGuard knows what I have"
**Fix:** Already captured as UX-10. System Baseline Diagnostic script built and ready for integration into ascii23 as Step 0.
**Reference:** See `GatewayGuard_SystemBaseline_Diagnostic.ps1`

---



---

*Update this file after offline scan completes and ascii22 results are reviewed.*
