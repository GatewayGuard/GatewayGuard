<!-- Dated: 2026-07-19 16:55 EDT -->
<!-- File: GatewayGuard_PreScanSpec-ascii33-2026-07-19-r2.md -->
<!-- Build-ready spec for the D-06 pre-scan redesign. Every screen names
     its target function per PATTERN C rule. All external claims verified
     per RESEARCH BEFORE STATING (sources noted inline). -->

# Pre-Scan Section Redesign -- ascii33 Build Spec
**Covers:** D-06, D-08, D-10, D-11, D-13, FT-85, FT-86, FT-103
**Author:** William F. Burns III / GatewayGuard
**Status:** DRAFT -- pending Bill's approval of screen copy

---

## SCREEN SEQUENCE (replaces current pre-scan flow)

Current defective order: Pre-scan reminder -> MB NOT DETECTED -> Defender...
New order (Defender first, MB second, briefing before both):

    [NEW] SCREEN-26  Your Security Tools (briefing part 1)
    [NEW] SCREEN-27  The Scans We Recommend (briefing part 2)
    [MOD] SCREEN-11  Defender Offline Scan (existing, reordered first)
    [MOD] SCREEN-13  Malwarebytes Guidance (existing, now after Defender,
                     rewritten with trial + rootkit + deep scan content)
    [MOD] SCREEN-10  Skip gate (D-08: "already ran both scans?" option)

Screen numbers 26-27 are new; per SCREEN NUMBERING rule, added at the
end of the master list, never renumbering existing screens.

---

## SCREEN-26 -- YOUR SECURITY TOOLS
**Target function:** new Show-SecurityToolsBriefing (called from the
point where Show-PreScanGate currently starts)

--- SCREEN COPY (final draft) ---

    YOUR PC'S SECURITY TOOLS -- A QUICK INTRODUCTION      Screen 26

    Before we make any changes, here's what protects your PC and
    how the pieces fit together.

    WINDOWS DEFENDER (already on your PC)
    Windows comes with a built-in antivirus called Microsoft
    Defender. It's free, it's already installed, and it watches
    your PC in real time -- every file you open, every download,
    every program you run. GatewayGuard will make sure it's set
    up correctly.

    MALWAREBYTES (we recommend adding it)
    Malwarebytes is a separate free program that works alongside
    Defender. Defender watches in real time; Malwarebytes runs a
    deeper scan when you ask for one -- it looks for threats that
    hide from real-time scanners. They work together without
    conflict.

    ABOUT THE 14-DAY TRIAL (important -- read this)
    When you first install Malwarebytes, it starts a free 14-day
    trial of the paid version. During the trial, Malwarebytes
    also handles real-time protection. After 14 days the trial
    ends BY ITSELF -- you don't need to do anything, and nothing
    breaks. Malwarebytes switches to its free mode: real-time
    protection hands back to Defender, and the deep scan feature
    stays available to you permanently, at no cost.

    A NOTE ABOUT YOUR RECORDS
    GatewayGuard keeps a record of everything it does on your PC.
    It's saved in your Documents folder, in a folder named
    GatewayGuard. If you ever need help, that file shows exactly
    what happened.

    Press Enter to continue.

--- LOGGING ---
[SCREEN-26] Rendered: Your Security Tools (briefing 1 of 2)

--- NOTES ---
- 14-day trial behavior: verified by field observation (Dell trial
  expired 2026-07-15/16; Defender resumed primary automatically --
  see ascii31 test history and MB state audit 2026-07-17).
- Log location paragraph implements D-13.
- Layout: if this exceeds one screen height at minimum window size,
  split after the Malwarebytes block into 26a/26b -- do NOT let
  content scroll below the fold (FT-83 lesson).

---

## SCREEN-27 -- THE SCANS WE RECOMMEND
**Target function:** Show-SecurityToolsBriefing (part 2) or separate
Show-ScanPlanBriefing -- builder's choice, one function per screen preferred

--- SCREEN COPY (final draft) ---

    THE TWO SCANS WE RECOMMEND -- AND WHY                 Screen 27

    Before hardening your settings, we want to be sure your PC is
    clean. A scan AFTER hardening can't undo an infection that's
    already there. So we recommend two scans, in this order:

    SCAN 1: DEFENDER OFFLINE SCAN (15-20 minutes)
    This special scan runs BEFORE Windows fully loads -- which
    matters, because some threats can hide once Windows is
    running. Your PC will restart by itself, run the scan, and
    come back. GatewayGuard will be here when you return.

    SCAN 2: MALWAREBYTES DEEP SCAN (roughly 1-2 hours)
    After installing Malwarebytes, you'll run its deep scan. It
    checks far more of your PC than a quick scan. You can keep
    using your PC while it runs, though it may feel slower.

    ONE-TIME SETUP: TURN ON ROOTKIT CHECKING
    Before your first deep scan, turn on one setting in
    Malwarebytes (we'll give you the exact steps on the next
    screens):  Settings (gear icon) -> Security -> "Scan for
    rootkits" -> ON.  You only do this once.

    What's a rootkit? A rootkit is one of the sneakiest kinds of
    malicious software. It buries itself deep inside Windows --
    deeper than most security programs can see -- and hides
    itself, and often hides other malicious programs too. Your PC
    can be infected and everything still looks normal. Normal
    scans can miss rootkits because rootkits actively hide from
    them. This setting tells Malwarebytes to look in the places
    rootkits hide.

    Already ran both scans earlier today? You'll be able to skip
    ahead on the next screen.

    Press Enter to continue.

--- LOGGING ---
[SCREEN-27] Rendered: The Scans We Recommend (briefing 2 of 2)

--- NOTES ---
- Rootkit toggle necessity: FIELD-VERIFIED 2026-07-16/19 on Dell.
  Both Threat and Deep Scan reports show "Rootkits: Disabled" when
  toggle off. Deep Scan does NOT include rootkits by itself.
- Deep Scan availability in Free mode: FIELD-VERIFIED -- 07-16 Deep
  Scan report shows License: Expired, scan completed normally.
- Time estimates: Defender offline 15-20 min (existing verified copy);
  deep scan ~46 min without rootkits on the Dell (407K objects,
  2 drives) -- "roughly 1-2 hours" is the safe user-facing range;
  update if the rootkits-ON re-run shows materially longer.

---

## SCREEN-13 REWRITE -- MALWAREBYTES GUIDANCE
**Target function:** Show-MalwarebytesFollowUp (existing -- content replaced)
**Covers FT-86 (incomplete guidance) and FT-103 (explanation buried at end)**

Content requirements (full copy drafted at build time):
1. Install steps (existing, URL = https://www.malwarebytes.com/ per FT-81)
2. Rootkit toggle steps (the 4-step block from SCREEN-27, repeated
   here at point of action -- users act on the screen in front of
   them, not one they saw earlier)
3. Deep scan steps -- VERIFIED against MB Help Center (updated
   2026-06-30, article 39240775526171):
       1. Open Malwarebytes
       2. Next to the Scan button, click the three dots
          (do NOT click Scan -- that runs a quicker Threat Scan)
       3. Click Advanced Scan
       4. Click Deep Scan -- it starts automatically
       5. When done, the Malwarebytes icon flashes near the clock;
          open Malwarebytes to see the results
4. How to confirm rootkits were checked: open the scan report;
   under "Scan Options" it should say "Rootkits: Enabled"
5. D-10 wording: "monthly reminder to run your Malwarebytes deep scan"

---

## SKIP GATE (D-08)
**Target function:** Show-PreScanGate (existing -- add skip path)

After the briefing screens, the gate offers:

    Have you already run both scans today?
      Y = Yes, both are done -- skip ahead to the settings checklist
      N = Not yet -- walk me through the scans now

Every key states its outcome (USER-FACING CLARITY). No ambiguous
"continue" wording. Log the choice.

---

## D-12 -- QUICK REFERENCE CARD (pending format confirmation)
**Target function:** new Write-QuickReference, called from summary flow
**Location:** Documents\GatewayGuard\GatewayGuard-QuickReference.txt
(same folder as log; folder-creation logic already exists for the log)

Content sections:
1. What GatewayGuard did on this PC (date, machine, summary)
2. Your monthly Malwarebytes deep scan -- the 5 steps + the
   "Rootkits: Enabled" report check + one-time toggle reminder
3. Your quarterly Defender offline scan -- how to run it manually
   (Windows Security -> Virus & threat protection -> Scan options ->
   Microsoft Defender Antivirus (offline scan))
4. Where your GatewayGuard log lives
5. Support: support@gatewayguard.co (attach the log)

Summary screen tells the user the card exists and where it is.

DECISION PENDING: .txt (recommended -- universal, printable) vs .html

---

## WEBSITE PARALLEL WORK (logged as TODO)
- New guide pages: MB install/deep-scan/rootkit page; Defender offline
  scan page. Tool links to gatewayguard.co/guide/... once live
  (URL VALIDATION rule: never hardcode until live + SSL-tested;
  until then the tool shows the steps directly, no URL dependency).

---

## OPEN ITEMS BEFORE ascii33 BUILD
1. Deep Scan WITH rootkits re-run result (duration + "Rootkits:
   Enabled" in report) -- in progress on Dell 2026-07-19
2. Reference card format confirmation (.txt recommended)
3. FT-93 root-cause grep of Setup-ScheduledTasks (blocker, separate
   from this spec)
4. Bill's approval of SCREEN-26/27 copy above


---
---

# R2 REVISIONS -- AFTERNOON 2026-07-19
(These supersede conflicting content above. Verified same day on all
three machines.)

## SCAN GUIDANCE CHANGE -- CUSTOM SCAN REPLACES DEEP-ONLY (D-15)
Deep Scan does NOT check rootkits (report-verified, toggle on or off,
two machines). The rootkit toggle in Settings does not reach Deep
Scan. Monthly guidance is now TWO scans:

  1. CUSTOM SCAN first -- all drives, "Scan for rootkits" CHECKED.
  2. DEEP SCAN after -- overnight is fine. On 8 GB machines: one scan
     per night (Custom night 1, Deep night 2).
  If the Custom Scan finds anything: click QUARANTINE (finding is not
  fixing -- quarantining is fixing), then the Deep Scan confirms the
  cleanup. (Matches MB's official Deep Scan positioning.)

## SCREEN-27 COPY REVISIONS
- Replace the deep-scan-only block with the two-scan plan above.
- Rootkit one-time toggle paragraph is REPLACED by the Custom Scan
  checkbox step (the Settings toggle is unreliable across scan types;
  the checkbox at scan time is what works and is verifiable).
- Keep the rootkit plain-English explanation verbatim.
- Time line (C-26 backed): "Each scan takes about 25 minutes to an
  hour depending on your PC. You don't need to watch it."
- Overnight lines (verified): "You can run a scan overnight -- no
  settings to change. Plug in your PC and leave the lid open. Your
  screen may stay on or may go dark on its own -- either is normal;
  the scan keeps running. Don't press the power button."

## SCREEN-13 (MALWAREBYTES GUIDANCE) -- STEP LIST FINAL
  Custom Scan steps (verified on MB 5.5.7 / 5.6.1 / 5.6.2):
  1. Open Malwarebytes
  2. Next to the Scan button, click the three dots
     (do NOT click Scan -- that runs a quicker Threat Scan)
  3. Click Advanced Scan
  4. Choose Custom Scan
  5. Check "Scan for rootkits"
  6. Check ALL your drives (C:, D:, and any others listed)
  7. Start the scan
  8. Afterward: open the scan report -- under "Scan Options" it must
     say "Rootkits: Enabled"
  9. If anything was found: select all detections and click
     QUARANTINE, then run a Deep Scan (three dots -> Advanced Scan ->
     Deep Scan) to confirm the cleanup
  Deep Scan steps stay as previously specced (source: MB Help Center
  article 39240775526171).

## SCHEDULED TASK / REMINDER POPUP -- COPY + MECHANISM
- schtasks.exe implementation per C-14a (quarterly: /sc monthly
  /m JAN,APR,JUL,OCT /d 1 /st 02:00; monthly: /sc monthly /d 1
  /st 10:00).
- Reminder popup text rewritten: title "Monthly reminder to run your
  Malwarebytes scans" (D-10); body carries the Custom Scan 9 steps
  above in shortened form + "run the Deep Scan overnight after".
  Remove obsolete "Click Scan Now" (that runs a Threat Scan -- no
  rootkits).

## STEP COUNTER (C-15, FT-98) -- DISPLAY FORMAT LOCKED
Section label + live step number: "Getting Ready -- Step 3",
"Scans -- Step 7", "Your Settings -- Step 12", "Wrapping Up --
Step 18". Counter increments per rendered screen; internal SCREEN-NN
stays log-only. Skipped content acknowledged per C-20.

## FT-105 -- TAMPER DETECTION (added to ascii33)
Detection: Get-MpComputerStatus | IsTamperProtected (verified True on
Dell). True -> GOOD (removed from security-critical skip warning);
False -> manual guidance; query failure only -> Unknown.

## OPEN ITEMS (updated)
1. D-12 reference card format: .txt working default -- Bill to
   confirm before it's built (deferred from ascii33 either way).
2. Bill clarifications: note 15 "AND to N"; note 15 BitLocker.
3. HP cleanup completion + Deep Scan confirm (field incident).
4. Lid-close during scan: unverified -- instruction stays "leave lid
   open".
