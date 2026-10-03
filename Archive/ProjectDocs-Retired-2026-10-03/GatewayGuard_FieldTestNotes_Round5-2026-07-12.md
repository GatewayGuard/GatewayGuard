<!-- Dated: 2026-07-12 21:37 ET -->
# GatewayGuard -- Field Test Notes, Round 5 (ascii27)
**File:** GatewayGuard_FieldTestNotes_Round5-2026-07-12.md  |  **Revision:** r1
**Revision history:** r1 initial triage of raw Round 5 notes
**Test date:** 2026-07-12 ~2:25 PM ET  |  **Build tested:** ascii27 (4,593 lines)
**Raw notes file:** Ascii27_Testing-Notes_2026-07-12_Time-14-25.txt (23 items)

## TRIAGE SUMMARY

| Bucket | Items |
|---|---|
| A -- ascii28 code-fix scope (buildable now) | FT-38, 39, 41(tip), 42, 43(wording), 44, 52, 54(progress), 55, 56(layout), 58, 60(wording) |
| B -- BLOCKED ON LOGS (need today's log file) | FT-43(cursor), 46, 47, 49, 54(cursor), 56(snap-back) |
| C -- Questions answered (see below) | FT-40, 41, 45, 50, 51, 60 |
| D -- Process & docs queue | FT-48, 51(test plan), 53, 59 |
| E -- Discrepancy flagged, needs Dell check | FT-57 |

---

## BUCKET A -- ascii28 SCOPE (pending Bill's confirmation)

### FT-38 (Raw #1): MB-detected screen -> recommend Deep Scan
Add plain-English instructions: open Malwarebytes -> turn on "Scan for
rootkits" (Settings > Security), then run a full/deep scan from the
Scanner page. Deep Scan confirmed available on MB Free (IdeaPad,
Round 3 evidence).

### FT-39 (Raw #2): Wake-on-LAN screen -> add Remote Desktop
Expand screen: if you do NOT use Remote Desktop (nearly all home
users), turn OFF both Remote Desktop and Wake-on-LAN -- strongly
recommended. If you DO use it, explain the risks in plain English.
Recommendation text sourced per FT-40 below.

### FT-42 (Raw #5): "Y" still required Enter after resume
The personal-computer prompt in the resume path is not using the
shared single-key routine. Route it through Read-ValidKey so Y
registers instantly, consistent with every other screen.

### FT-43 (Raw #6, wording half): Screen-timeout consistency
Earlier screen says the tool took control of screen settings for the
program's duration; power-settings screen contradicts it. Make the two
statements agree (one source of truth for what the tool suspended and
when it restores it).

### FT-44 (Raw #7): Hibernate state-aware wording
Tool said "hibernate set ON" when it was already on. All apply-steps
should report honestly: "already on -- no change needed" vs "turned on."
Sweep every Apply-Setting message for the same already-set case.

### FT-52 (Raw #15): DECISION -- Back navigation everywhere
Bill offered two options and delegated the call. DECISION: extend Back
to all selection screens instead of building a test-only
select/reset/counter mode. Rationale: simpler, permanently useful to
real users and testers alike, and avoids a test-only code path that
could itself introduce bugs (the FT-30 flush lesson: extra machinery
added for one purpose caused a new failure).

### FT-54 (Raw #17, progress half): "Checking Current Settings" indicator
Long checks show only a blinking cursor -- indistinguishable from a
hang. Add a live progress line ("Checking setting 7 of 19...") so the
user always knows the tool is working.

### FT-55 (Raw #18): "What this tool does" -- overclaim fix + Back
Tool makes definitive claims about features it cannot reach (e.g.,
Tamper Protection is manual-only). Reword to match reality: does /
helps you do by hand / does not do. Add Back on this screen.

### FT-56 (Raw #19, layout half): Status screen width
Only ~55-60% of screen width used; expand layout ~50%, weighted to the
left "Setting" column, so no text appears cut off.

### FT-58 (Raw #21): Tamper wording + split status screen
Tamper line: "check again after your Malwarebytes trial ends."
Split the settings-status screen into two screens now -- more items are
coming after the full Windows-settings and MB-rules review.

### FT-60 (Raw #23, wording half): Periodic scanning wording
Current text blames "MB trial" flatly. Reword pending FT-57 state
resolution; add manual how-to (see Bucket C answer). Note: suggested
wording "MB free trial active" conflates two different states the tool
distinguishes (Free companion vs Premium Trial) -- final wording after
FT-57 is settled.

### FT-51 (carry-in from Raw #14): Migrate inline ReadKey exceptions
Two screens bypass the shared input routines (BitLocker battery
screen ~line 3470; mode-selector two-key sequence ~lines 3781-3800).
Migrate both into Read-ValidKey/Read-NavKey so the "test one, trust
all" principle holds everywhere.

---

## BUCKET B -- BLOCKED ON LOGS (send today's log file)

### FT-46 (Raw #9): Ctrl+C killed the program -- REGRESSION
FT-24 (ascii24) set [Console]::TreatControlCAsInput = $true, yet Ctrl+C
still terminated the run. Confirmed present in ascii27 source (line
~4474). Suspects: pressed during a Read-Host fallback path; the console
host resetting the flag; or the crash predating the flag being set.
Logs will show the last screen and whether the WARN fallback fired.

### FT-47 (Raw #10): Screen flash-by (pro computer / battery / sleep)
A screen skipped past without input. Could be a stray buffered
keystroke or a pacing bug. Logs will show timestamps between screens.

### FT-49 (Raw #12): Mark/cursor dead, ps1 window disappeared
After alt-tabbing to Notepad the tool's window vanished. Need logs to
see if the process exited (and why) or the window was lost behind
others.

### FT-43/54/56 (Raw #6/#17/#19, cursor halves): Cursor anomalies + Mark snap-back
Enhanced cursor disappearing/returning; Mark scroll snapping back to
bottom. Working theory on snap-back: any program write resets the view
to the bottom -- if the tool writes anything while "idle" (keepalive,
timer), Mark can never hold position. Logs + code review of idle-state
writes will confirm. If true, fix = write nothing while waiting for
input.

**ACTION (Bill):** upload the log file(s) from today's 2:25 PM run.

---

## BUCKET C -- QUESTIONS ANSWERED

### FT-40 (Raw #3): Remote Desktop vs TeamViewer vs AnyDesk
Short answer: for GatewayGuard's audience, none of them -- and the
question that matters most isn't which tool is most secure, it's who is
on the other end.

- **Windows Remote Desktop (RDP):** inbound, always-listening when
  enabled. Exposed RDP is a top ransomware entry point. Should be OFF
  for essentially every home user. This is the one GatewayGuard checks.
- **TeamViewer / AnyDesk:** outbound, session-based -- structurally
  safer than an open RDP port because nothing listens until the user
  starts a session. BUT these are precisely the tools scammers direct
  victims to install. Tech-support fraud is the #1 reported crime
  against Americans 60+, with seniors losing roughly $1 billion to it
  in 2025 alone (FBI IC3 2025 Annual Report; IC3 Elder Fraud Reports
  2022-2023; IC3 PSA I-091223 "Phantom Hacker"). The scam's core move
  is talking the victim into installing remote-access software.
- **Recommendation for the tool + guide:** Remote Desktop OFF,
  Wake-on-LAN OFF. If a family member provides remote help, the SENIOR
  initiates each session, attended only, no unattended-access setup,
  and nobody they didn't already know gets access -- no matter who the
  caller claims to be. If GatewayGuard must name a tool for
  family-assisted help, prefer session-based attended tools over
  enabling RDP; final guide copy comes out of the FT-48 researched
  write-up.

### FT-41 + FT-45 (Raw #4, #8): Scrolling, and why copy/highlight died
These are the same root cause: the ascii24 walk-away fix turned
QuickEdit OFF (a click on the window used to pause the program and
kill unattended runs). QuickEdit-off also disables mouse
select/highlight and right-click copy. That is the trade, and it is
the right trade for this audience -- but the tool should say so and
teach the workaround:
- **Method 1 (Ctrl+Arrow / Shift+PgUp):** works only in Windows
  Terminal, not the classic console window the .bat launches. Expected
  to fail -- matches Bill's result.
- **Method 2 (Mark mode):** Alt+Space, E, M, then arrows/PgUp/PgDn;
  Esc to exit. Works in the classic console, persists across reruns
  (matches Bill's observation). This is the sanctioned method.
- **ascii28:** add a short "How to scroll back / how to copy" tip
  screen (or add to the font-tip screen) with the Mark-mode steps in
  plain English.

### FT-50 (Raw #13): Single-click vs double-click launch
Windows Explorer setting (Folder Options > "Single-click to open an
item"), per-user, not per-file. Fix is wording, not code: guide and
launcher instructions say "open Run-GatewayGuard (for many people
that's a double-click)" -- click-neutral. Add to guide-page spec.

### FT-51 (Raw #14): Key-blocking test plan -- code verified
Confirmed in ascii27 source: input IS centralized -- Read-ValidKey
(valid-choice screens) and Read-NavKey (continue/back screens). So
yes: test one screen per shared routine per selection-set and the rest
follow. EXCEPTIONS found (do not share the routines): BitLocker
battery screen and the mode-selector two-key sequence -- each must be
tested individually until FT-51 migration lands in ascii28. Test plan
formalized in the Status Verification Sheet workstream; ask future
beta testers to spot-check a few keys per screen as a second net.

### FT-60 (Raw #23): What "periodic scanning" actually is
Windows feature name: **Limited Periodic Scanning (LPS)**. When a
third-party AV is the primary real-time protection, Windows can still
run occasional Defender quick scans in the background during idle
maintenance windows. It is a second-opinion safety net, not real-time
protection. Toggle lives in Windows Security > Virus & threat
protection > Microsoft Defender Antivirus options. No supported
command-line/registry toggle -- the honest play for our audience is a
plain-English manual instruction, which also matches the no-fragile-
hacks principle. Bill manually ran a Defender full scan alongside MB
on the Dell -- consistent with LPS being available there.
**Added to test checklist:** confirm scan options (full / quick /
offline) appear on HP SANDY and IdeaPad too.

---

## BUCKET D -- PROCESS & DOCS QUEUE

### FT-48 (Raw #11): Pre-run preparation write-up (GUIDE DEPENDENCY)
Before first run, users must be walked through: password manager
basics, Malwarebytes install/decision, Defender state -- with a
forceful plain-English explanation of the risks of skipping it.
Deliverable: researched write-up with expert sources (FBI/CISA/
Microsoft), summary opinion, then guide-page copy. Ties directly into
the website Guide pages (launch dependency).

### FT-53 (Raw #16): Development Discipline document
A: compile every root-caused program error to date (return-if invalid
syntax, hex-literal signed-int parse, unprotected ReadKey calls,
input-flush key-eating, self-elevating launcher) into standing
development instructions for this and future projects. B: research
expert guidance on PowerShell error-prevention and compare against
planned practices. Queued as its own deliverable.

### FT-59 (Raw #22): CPM Revision 5
Redo CPM incorporating: ascii28 scope, EULA/licensing tasks, pre-run
guide (FT-48), Status Verification Sheet, test-plan procedure, MB
trial expiry (~7/15) A/B window. Queued -- build after ascii28 scope is
confirmed so the schedule reflects real work.

---

## BUCKET E -- DISCREPANCY FLAGGED

### FT-57 (Raw #20): "Malwarebytes Premium Trial" vs Bill's read of Free
The screen said Premium Trial; Bill believes the Dell has Free, using
the rule "firewall controlled by MB = premium, Defender = free."
Two problems, flagged rather than smoothed over:
1. **ProjectNotes says the Dell trial ends ~7/15** -- still 3 days out,
   so the screen may be RIGHT.
2. **The firewall heuristic is shaky.** Malwarebytes has no firewall
   component on Free, and Windows Firewall commonly stays
   Windows-managed even on Premium; firewall ownership is not a
   reliable Free-vs-Premium tell. The reliable tells: open the MB app
   > account/license area (says "Premium Trial" or "Free"), or Windows
   Security > Virus & threat protection (who provides real-time
   protection).
3. **Detection hardening regardless:** Get-MalwarebytesState treats
   "MBAMService running" as a Premium indicator, but that service also
   runs on Free. Weak signal -- tighten in ascii28 once the Dell's true
   state is confirmed.
**ACTION (Bill):** on the Dell, open Malwarebytes and read the license
line; report what it says.

---

## OPEN ACTIONS OUT OF ROUND 5
1. Bill: upload today's log file(s) -- unblocks FT-46/47/49 + cursor items
2. Bill: check MB license line on the Dell -- resolves FT-57
3. Bill: confirm (or trim) the Bucket A ascii28 scope -- then ascii28 builds
4. Claude: FT-48 pre-run write-up with sources (next doc deliverable)
5. Claude: FT-53 Development Discipline doc
6. Claude: FT-59 CPM Revision 5 (after #3)
7. Test checklist add: scan options on HP + IdeaPad (FT-60)
