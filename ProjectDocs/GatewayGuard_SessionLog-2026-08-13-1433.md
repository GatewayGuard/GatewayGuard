<!-- Dated: 2026-08-13 14:33 EDT -->
<!-- Editor: Claude Code (CGDELL) -->
# GatewayGuard Session Log
- **Document Name:** GatewayGuard_SessionLog
- **Last Modified:** 2026-10-02 13:17 ET
- *(The `Dated:` line and the filename stay at 2026-08-13 14:33 -- this file
  is append-only, so they record when it was opened, not when it last grew.
  `Last Modified` had been left at the creation date through nine days of
  entries; Cloud caught it 2026-08-22.)*
- **Status:** Append-only running log â€” newest session at top
- **Purpose:** Continuous record of all sessions (Claude.ai and Claude
  Code) so any Claude instance can resume with full context.
  Updated after every file produced or decision made.
  Downloaded by Bill at session end and uploaded to project immediately.

---
---

## Session: 2026-10-02 11:56-13:17 [Claude Code -- CGDELL] -- GUIDE: CLOUD'S 10-02 FILES FILED; BILL'S ANSWERS TO CLOUD'S SIX QUESTIONS

Entry written at session end from the day's commits (no entry existed for today).

- `25dd897` Cloud's 10-02 files filed: guide Parts 1/4/5 FINAL, Parts 2/3
  markers-closed list, website changes, format pack needs. P2-5, P2-6,
  P3-9..P3-13 applied to the twins (7/7, old strings asserted). VERIFY left:
  Part 2 none, Part 3 two (R7, R8).
- `b86e00a` Screen readings R1-R3 from Bill's screenshots 31-35 (CGDELL);
  System Restore ran 11:01 and is recorded. R4-R8 not found.
- `2d120f5`, `02c7b27` Bill's answers to Cloud's six questions: 1 Setting 11
  sentence; 2 Fast Startup stays Off, with why; 3 Setting 13 gets the
  measured-free Edge line; 4 "Google Password Manager" stays as an on-screen
  label (CLAUDE.md exception); 5 the 12-pt edition is a recorded exception
  (CLAUDE.md); 6 the twins are the source.
- The 09-27 session (ascii45 Blocks C-E, Ctrl+C, full screen, SANDY
  encryption) was resumed briefly and closed; everything from it was already
  committed.

**Open:** guide Part 3 R7/R8; F10; screen 11's sentence; the SANDY field run.
**Left alone:** `ProjectDocs/Co-polot_Guide_Review-2026-09-29-0815.txt` has
uncommitted changes Claude Code did not make (Bill's, presumably).

---

## Session: 2026-09-30 11:50-15:51 [Claude Code -- CGDELL] -- SCREEN READINGS FINISHED; ITEM 9 SAYS "ENTER YOUR PIN"; CURRENT.md CAUGHT UP

**Build: ascii45, not field run.** Next free FT: 310 (unchanged).

- **Screen readings finished**, every CGDELL and SANDY row
  (`ProjectDocs\GatewayGuard_ScreenReadings-Checklist-2026-09-29-1931.md`), from
  Bill's screenshots 6-29 and one phone photo. Bill's notes kept word for word.
  12 findings for the guide (Cloud) -- Part 1 system protection and restore
  wizard, setting 1/8/13/17 undo wording, "No recent actions", Quick Assist's
  camera prompt, the lock screen, setting 6 labels, Widgets check, Remote
  Desktop on Home ("doesn't support Remote Desktop", no switch).
- **Lock screen (phone photo, CGDELL):** "Enter your PIN", "Sign-in options"
  (key / keypad), **no "I forgot my PIN" link** -- the S2 row asked for a link
  that is not there (Claude Code's error, from unconfirmed community sources).
  **Item 9 now says "Enter your PIN"** (`deeb776`).
- **CGDELL changed overnight** (system protection Off -> On, BitLocker
  suspended -> on): **Bill did it by hand** from the checklist notes. Not Checkup.
- **CURRENT.md was two days stale** (Cloud caught it: da15aea, 09-28 08:38).
  Regenerated; `Update-Current.ps1` gained rows for the screen readings, the
  Copilot triage, the ForCopilot packs and the Cloud brief.
- **Not logged at the time, recovered from git (09-28 08:38 to 09-29 19:31):**
  FT-299..301 (Co-Pilot 09-28 review: items 1, 4, 13 reads, flip-tested);
  gate 27 pre-commit hook (`dc68985`); SANDY ascii45 run 1 triaged (FT-302..309,
  `c57930c`) and fixed (`32ee2d2`, `b3e7e58`); Cloud brief (`be192c7`); three
  ForCopilot documents and Copilot's review triaged (`4832d76`, `b54f746`);
  SANDY run 2 checklist (`eac86ef`); screen readings C1-C6 (`06ff4cb`).

**Next:**
- Cloud applies the 12 guide findings (pasted by Bill 2026-09-30).
- SANDY ascii45 run 2 with `GatewayGuard_FieldChecklist-ascii45-SANDYrun2-2026-09-29-0826.md`.
- Tool\ holds two untracked recipe files of Bill's -- his to move.

---

## Session: 2026-09-27 to 2026-09-28 08:37 [Claude Code -- CGDELL] -- ascii45: H, C2-C9, D, E, BLOCK F AND THE RENUMBER BUILT

**Build:** ascii45, `Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1`,
9,893 non-blank / 10,232 lines, 112 functions (measured 2026-09-28). Not field run.

- **09-27:** H1/H2 (Windows Hello read from LastLoggedOnProvider, flip-tested; password
  on wake AC+DC), C2-C9 (ignored keys logged, B/L/F, Ctrl+C asks first -- Bill's tests
  A-D, full-screen Windows Terminal), Block D (resume), Block E (start sequence; Windows
  Update install measured on CGDELL, result 2, 454 s), FT-282 (item 12).
- **09-27 evening / 09-28 early:** Bill's CGDELL runs found FT-290 to FT-298. Critical
  ones fixed first: **FT-297** (item 8 on an encrypted drive added a recovery key and
  claimed encryption started -- now screen 28b, changes nothing) and **FT-294** (item 17
  said GOOD with a 15-minute delay -- DelayLockInterval now read).
- **09-28, Block F** (Bill: "build block F and the renumber pass"): start order shown as it
  happens; screen 20 report-only; unnumbered pages boxed or removed; items 11-15 apply in
  the main run; new screens "What Checkup changed" (Was -> Now, undo steps from guide
  4.2) and "Steps for you to do"; guide refs "Setting N"; F8 wording; FT-222. **No
  password-manager product named** (four sites found and fixed).
- **Renumber:** main line 1-37, no gaps; welcome-back 1a -> 0a (FT-195a).
- **Stamps:** four wrapper headers carried typed times later than the clock (08:41-08:59
  read at 08:34). Corrected to commit times and marked as such.
- **Needs Bill:** screen 11 "thoroughly tested" sentence (not built -- the week's field
  record does not support it); F10 waits on Cloud's guide text; SANDY field run.
- **Checklist:** `ProjectDocs\GatewayGuard_FieldChecklist-ascii45-partial-2026-09-28-0836.md`
  (old number -> new number map included).

---

## Session: 2026-09-26 13:10-14:44 [Claude Code -- CGDELL] -- CO-PILOT'S ascii45 REVIEW CHECKED; ITEM 9 (WINDOWS HELLO) IS WRONG

**Build: ascii45, in progress** (Blocks A, B, C1 + C1b). Next free FT: **289**.

- **C1b (`df49203`):** Co-Pilot WAS reading the ascii45 text, as Bill said. The
  phrases it quoted are in ascii45's retained ascii44 history (line 152) and
  the item-17 comment (line 6154). Both notes now say "SUPERSEDED BY FT-268".
  Comments only; parse 0, gates 12 and 24 pass. Bill's `Tool\...-1.txt` copy
  refreshed. Tell Co-Pilot: the "CHANGES FROM" blocks are history.
- **Co-Pilot's code review -> plan Block H (`fac30cd`)**, each claim checked:
  FT-286 item 9 Hello, FT-287 item 17 reads AC only (DC missed), FT-288 item 1
  checks the service not update freshness. Item 12 already planned (G6);
  item 4 no new work; item 13 flip test later.
- **FT-286, settled at the keyboard.** Bill signs in to CGDELL with a PIN. The
  Microsoft account he set up on 09-24 and "Dad" are ONE account (SID 1001,
  one profile `C:\Users\willi`, switch at 19:41 on 09-24, security log).
  Checkup says "Not set up" (its folder does not exist); Settings says every
  Hello option is "not available"; `dsregcmd` says `NgcSet : NO`. All three
  deny a PIN that works. The business account (tenant GatewayGuard LLC) is
  workplace-registered only -- no management, no Hello rules.
  **My errors, recorded in H1:** I withdrew a correct verdict because
  `dsregcmd` said NO (`8f6bae9`), then restored it (`d1ac765`). The field wins.
- **Co-Pilot's Hello answer** agreed the check fails, but got the direction
  backwards, sent users to Settings (which is wrong on CGDELL), cited no
  links, and skipped the last-sign-in candidate. Plan H1 updated.

**Next:**
- **Bill:** at the next sign-in use the PASSWORD once, tell Claude Code; then
  the PIN, tell Claude Code (flip test for the last-sign-in read, FT-286).
- Build FT-286 (last-sign-in read if the flip test passes, else ask the
  person) and FT-287 (AC and DC) in ascii45; then rest of Block C.
- Still pending from before: SANDY measurement script, WT copy test.

---

## Session: 2026-09-26 11:10 [Claude Code -- CGDELL] -- /doctor CLEANUP, THEN ascii45 BUILT FROM ITS BASE THROUGH BLOCK A

**/doctor (Bill approved "Clean up everything" + auto mode default):**
product-management and design plugins off; auto mode the default
(`~/.claude/settings.json`, backup `.bak-2026-09-26`); Bill disabled the
Harmonic and Claude Docs connectors himself. **CLAUDE.md trimmed 95,323 ->
56,395 chars** -- the ascii44 fix history moved verbatim to
`Archive\CLAUDE-CurrentBuildHistory-ascii44-2026-09-26-0851.md` (commit
`79330ee`); `/context` then measured CLAUDE.md at 21.3k tokens.

**ascii45 -- Bill: "build ascii45".** Base `5c63ddd`: copy of ascii44, build
number moved in all five places, ascii44 `git mv`'d to `Builds\`, three
launchers repointed. **Block A, one commit per item, every edit through
`gg_edit`, gates 12/12b/24 + 0 non-ASCII + no duplicate functions after
each:**
- A1/A2 `e54ff57` -- FT-268 `/qh`; FT-269 GOOD/OK only after a confirmed
  re-read. ***Verified: the shipped reader, extracted by AST and run on
  CGDELL, returns REQUIRED; ascii44's returns NO_INDEX on the same machine.***
- A3 `c257d62` -- FT-284, no green "Done:" over an ERROR.
- A4 `b04364a` -- FT-278, five screens (10, 11, 21, 33, 34) stop promising
  automatic behaviour; every box line length asserted unchanged.
- A5 `7ce97e0` -- FT-279, "Working on this item..." + honest result colour;
  new `Write-GGWrapped` (90 functions).
- A6 `e194157` -- FT-254 time sync, re-read before "corrected". **Found an
  FT-162-class flag:** ***measured, `w32tm /?` has no `/force`***; ignored
  when W32Time runs, and the real failure (service stopped, 0x80070426) was
  hidden by `| Out-Null`. Now documented `/resync` + exit-code check.
- A7 `5498c76` -- FT-285, absent policy value = expected (INFO); item 6's
  handled Tamper refusal logs INFO and clears its own `$Error` record. Access
  denials elsewhere stay ERROR (FT-245).

**My error, corrected (`1daf4bd`):** six wrapper headers were stamped 11:20
to 12:48 -- typed, not read. The clock said 11:10. Corrected to commit times,
with the typed value kept in each header.

**ascii45 after Block A: 9,689 non-blank / 10,081 total, 90 functions.**

**Block B, same session (11:12-11:25), one commit per step:**
- B1 `e8c9bcb` -- GUI mode deleted (331 lines); screen 21 is [1] START /
  [X] EXIT, and X now goes through Confirm-Exit (the old [3] EXIT left with
  no confirmation). Screen 21 fits in 26 lines.
- B2a `b8f6fd9` -- verdicts for items 2, 3, 7 no longer depend on
  Malwarebytes. New `Get-GGOtherAV` + Defender's own real-time state: on =
  GOOD whatever else is installed; off with another AV registered = that
  product is in charge. ***Tested on the shipped code, 7 cases incl. Norton,
  Kaspersky, Defender unreadable -- all correct.*** Setting 5 retired, IDs
  not renumbered.
- B2b-1 `31d823b` -- screens 13/14 rewritten without Malwarebytes; 18/18a-c
  deleted. B2b-2 `800ac49` -- antivirus check 17/17a-e general, 17b/17d
  deleted, `Get-MalwarebytesState` deleted. ***Tested: 7 scenarios through
  the shipped Test-DefenderPrimary.*** B2b-3/B3 `5fb49e3` -- last wording
  gone; the monthly Malwarebytes reminder is no longer created and
  `Remove-GGOldMBReminder` removes it once where it exists. ***Tested for
  real on CGDELL with a stand-in task: REMOVED, then ABSENT.***
- **Oversize screens: 10 -> 5** (52, 73, 26, 27, 41 cleared); checker
  baseline and CLAUDE.md updated each time.
- **Open, deliberately:** the screen renumber pass (gaps at 17b, 17d, 18,
  18a-c) waits for Block E, which reorders the scan section anyway.
- **For Bill:** screens 17, 17a, 17c show the NAME Windows reports for an
  installed antivirus (e.g. "uninstall Kaspersky"). Kept as detection, not a
  recommendation -- his call if the no-product-names rule covers it.

**ascii45 after Block B: 8,879 non-blank / 9,202 total, 89 functions.**

**Then, same session (11:27-11:53):**
- C1 `9a8d483` -- X = Exit. ***Measured: nine prompts ended Checkup on N***
  (not the 08-30 count of 11 -- Block B removed the rest); three never said
  "Exit". Seven exited on one keypress and now call Confirm-Exit; declining
  returns to the same prompt (***tested on the shipped functions***).
- Website `90c1897` -- Bill: "Don't recommend adding MB." defender-realtime
  and tamper-protection pages no longer mention it; `periodic-scanning.html`
  (setting 5) retired to `Archive\WebSite-Retired-2026-09-26\`. ***Measured:
  0 Malwarebytes mentions and 0 setting-5 links left in `WebSite\html`.***
  **Open:** setting 5 still in `Index-Builds\guide-index-2026-08-02-2031.html`;
  which index ships is not recorded (asked Cloud).
- `FieldChecklist-ascii45-partial-2026-09-26-1139.md` (`fd43281`) -- every
  screen CHECK / SKIP / LOOK / GONE for the finished blocks. Optional.
- **Cloud's freshness check passed, and it caught four stale records on our
  side, all fixed:** the briefing's active-build block (still "ascii44, not
  yet field run"); Project Instructions' UNRUN BUILD status (still
  ascii39/40); CLAUDE.md and this log stopping at Block B; and `CURRENT.md`'s
  stamp labels ("Commit / Made / Commit subject") drifting from the names the
  Cloud rules use -- `Update-Current.ps1` now prints "Commit at generation /
  That commit was made / Its subject line". **The fifth stale item is Bill's:**
  the claude.ai Project Instructions box still holds the pre-08-21 text
  (panther step); re-paste the block from
  `GatewayGuard_CloudProjectInstructions-2026-08-12-2316.md`.
- **My error, found while fixing those:** Python text-mode writes turned LF
  files into CRLF -- `CLAUDE.md` in commit `31d823b` (all 997 lines), and the
  briefing and Project Instructions today before commit. All three restored to
  LF. Writes from now on use binary mode.

**Bill's two answers, 12:00:** (1) *"keep the found names"* -- screens 17/17a/17c
keep showing the antivirus name Windows reports; recorded in CLAUDE.md Product Rules
as the exception to no-product-names. (2) *"test on CGDELL"* -- the full-screen
launch: ***measured, `Test_Results\WtFullscreen-CGDELL-2026-09-26_12-03.txt`:
`wt -w new -F` fills the screen with no title bar, keeps administrator rights, gives
133 x 37 (was 81 x 21), and closes by itself.*** Four things still to check before
the launcher changes (copying, Mark-mode, font screens, SANDY); recorded in the
ascii45 plan's OPEN list. Not in scope until Bill says so.

**12:07 -- Bill: "add full screen to ascii45"** -> build plan item C9. "Are the four
things in my checklist?" -- they were not; now covered: SANDY's Windows Terminal
check added as step 7 of `Tool2\Run-MeasureSandyForAscii45.bat`; copy/selection
behaviour measured by new `Tool2\Run-TestWtCopySelect.bat` (+ .ps1, read-only, times
every tick and reads the clipboard itself); screens 3/4/8 are Claude Code's to
rewrite once measured; the admin launch is tested when C9 is built. Checklist
gained a full-screen section. ***Measured while building the test: a script path
with spaces does not survive wt's argument parsing, nor does -d "...\."; -d
"<folder, no trailing backslash>" + a bare script name works*** -- recorded in C9,
because Checkup's own launcher has the same spaces. Smoke-test result files were
removed so Bill's run is the only one.

**12:15 -- My error, and Bill paid for it:** my first smoke test passed an unquoted
window title, so Windows Terminal tried to run "copy" and left the error on a
FULL-SCREEN window with no X. Bill was stuck in it. My clean-up removed files but
never checked for leftover windows. Closed it with a close request to that one
window (it shared a process with this session, so the process was not ended).
The .bat Bill runs quotes correctly and was tested end to end; it now also tells
him Alt+F4 / Alt+Enter. C9 gains: check the build file exists, tested quoting
only, and the escape line on screen before the window opens.

**13:09 -- Co-Pilot reviewed setting 17 and repeated "unreadable on CGDELL"** --
describing ascii44's `powercfg /query`. Bill had given it the ascii45 text copy
(measured identical to the build: 0 `/query` lines, 2 `/qh`). Its reply opens "my
review of ascii44.txt" -- inferred: it answered from the ascii44 copy it held
earlier in that conversation. SettingsLocationList corrected: row 17 is R+C in
ascii45 (FT-268), BLOCKED now means setting 6 only, the open question is
answered. `Toolscii44.txt` removed -- measured identical (same git blob) to
`Builds\...ascii44...ps1`, so nothing lost -- so it cannot be picked up again.

Next: rest of Block C (B = step back, L = look, F = fix the screen, FT-271,
FT-270 Ctrl+C after the SANDY test).

---
---

## Session: 2026-09-25 16:38 [Claude Code -- CGDELL] -- ascii45 BUILD PLAN WRITTEN, X = EXIT DECIDED, SANDY MEASUREMENT SCRIPT READY

**Bill: "1. build plan 2. use X 3. How do i test it."**

- **`X` = Exit, decided.** ***Measured: `X` appears in no key comparison in
  ascii44.*** `CLAUDE.md` updated -- the open question since 08-30 is closed.
- **`GatewayGuard_ascii45BuildPlan-2026-09-25-1638.md`.** Blocks A (wrong
  verdicts), B (GUI and Malwarebytes out -- before C, per Cloud), C (keys:
  X, B = step back, L = look, F = fix the screen, FT-271, Ctrl+C), D (resume),
  E (the new start sequence incl. Windows Update apply-and-loop and the
  Checkup-started full scan, which also delivers F4 the second drive), F
  (wording, Was/Now screen, GuideRef = setting number), G (six SANDY
  measurements). ***Measured: ascii44's Block B never shipped*** -- FT-248,
  249, 250, 252, 253 carry into ascii45. Proposed schedule has no slack:
  ascii45 to SANDY 10-03, triage and ascii46 10-07 to 10-09.
- **"How do I test it"** -- ascii45 does not exist yet; what can be tested
  now is the six SANDY measurements. **`Tool2\Run-MeasureSandyForAscii45.bat`**
  + `Measure-SandyForAscii45-2026-09-25.ps1`, read-only, run as
  administrator. ***Tested on CGDELL with -NoPrompt, 16:36; output
  `Test_Results\SandyForAscii45-CGDELL-2026-09-25_16-36.txt`.***
- **Found while testing it, on CGDELL: C: is Fully Encrypted but BitLocker
  Protection is OFF** (`manage-bde`: Conversion Status Fully Encrypted,
  Protection Status Protection Off; `Get-BitLockerVolume` agrees). The data
  is encrypted but the key is not being protected -- the same "temporarily
  disabled" shape as Bill's SANDY note 29. Cause not measured. Raised to Bill.

---
---

## Session: 2026-09-25 14:50 [Claude Code -- CGDELL] -- BILL ANSWERS CLOUD: NO PRODUCT NAMES, PARTS 4-5 APPROVED, EVERYTHING IN ascii45, 10-15 HOLDS

**Bill's answers to Cloud's four questions in
`GatewayGuard_CloudReview-ascii44Triage-GuidePart3-Part4-2026-09-25-1308.md`:**

1. **"Remove AV names from guide."** Confirmed when asked: **no third-party
   antivirus or password-manager name anywhere -- Malwarebytes out of the
   guide too**, reversing 2026-09-08's guide-only arrangement. Microsoft
   Defender is the only product named. `CLAUDE.md` Product Rules and Approved
   Products updated. ***Measured: Guide Parts 1-3 name none already; the 08-22
   draft that Parts 4-5 draw on names Malwarebytes 7, Avira 2, Norton 1,
   McAfee 1*** -- they must not carry over. **Open: the website.**
   ***Measured 2026-09-25: 12 product-name mentions across five pages***
   (periodic-scanning 7, password-manager 2, defender-realtime 1,
   phishing-protection 1, tamper-protection 1) -- two more pages than the
   09-08 count in `CLAUDE.md`, now corrected there.
2. **Part 4 / Part 5 outline (Cloud C-2) approved.** Restore point moves to
   Part 1; Part 4 = what Checkup changed, putting each setting back, if
   something looks wrong, if you think you are infected, getting help; Part 5
   = passwords and two-step sign-in, the yearly update, habits. Cloud offered
   to draft both in one pass.
3. **Firefox addendum -- decided 15:03: "make the firefox changes and then i
   will test it. keep it out of the guide."** Out of the 10-15 guide. Lifted
   into its own draft, `GatewayGuard_FirefoxAddendum-Draft-2026-09-25-1503.md`:
   F2 Standard not Strict; plain lines under the technical labels; F8 points
   at Part 4 Getting help; F10 now matches Setting 15 (off only if you use a
   separate password manager); F12 removed (named a product). A check line
   under every step for Bill's live walk. ***Measured: Firefox is not
   installed on CGDELL*** -- Bill tests.
4. **"We will make the launch date."** Bill disagrees with Cloud's
   launch/after split (A-13 item 4): **everything goes into ascii45, and
   2026-10-15 holds.** Cloud's caution stands on the record: ascii45 still
   needs its own field run and a triage before 10-15.
   **Then, same session: "include the future loop and other items in ascii45
   as well."** So the post-launch list comes in too. **ascii45 scope, as
   Bill set it:**
   - the 21 triage defects FT-265 to FT-285 and all 12 triage decisions;
   - Malwarebytes out of the tool; GUI mode out;
   - **Windows Update apply-and-loop** (Bill's note 12; ascii44 build plan
     line 308 had it post-launch);
   - **Checkup starting the full Defender scan** (Cloud A-6 had it ascii46),
     plus PUA blocking on before scans and the `FullScanEndTime` read;
   - Cloud's "after" list: the 2FA screen line, the GuideRef pass by setting
     number, per-adapter Wake on LAN, the item-12 fallback read, FT-277,
     FT-281 to FT-285;
   - the other items the ascii44 plan deferred: FT-220 (waits on the guide
     text) and the remaining encryption items (need a live encryption run).
   **Still needs a decision before it can be built:** `X` = Exit and the 11
   `N = exit` sites (open since 08-30). **Pending tests:** the full-screen
   launch (below).

**Also raised this session, not decided:** running Checkup full-screen in
Windows Terminal from the launcher so there is no window X to click (two of
nine ascii44 runs ended by the window closing). Needs a CGDELL test of the
`wt` launch option and of administrator rights carrying over, plus an
on-screen exit line. Bill has not answered.

---
---

## Session: 2026-09-25 13:22 [Claude Code -- CGDELL] -- CLOUD'S REVIEW FILED; TWO OF ITS CLAIMS CORRECTED, FOUR "UNSOURCED" FLAGS WERE SOURCED ALL ALONG

**Cloud delivered `GatewayGuard_CloudReview-ascii44Triage-GuidePart3-Part4-2026-09-25-1308.md`**
(Bill put it in `ProjectDocs\`). Freshness check passed: Cloud quoted
`11710d8` and the 11:04 session heading exactly. Agrees with all twelve
triage decisions in substance; page numbers (Decision 8) cannot work across
five print sizes -- use the setting number; do not have Checkup start the
full scan in ascii45; launch/after split proposed in A-13.

**Two of Cloud's claims corrected by measurement:**
- **A-2 (keep the Machine-ID check because the state file may travel):**
  ***measured: `$StateDir = "C:\GatewayGuard"`, build line 1602*** -- not
  OneDrive. The state file does not follow the account to another PC, so the
  stated reason does not hold.
- **A-13 item 1 (FT collision) was larger than reported.** ***Measured:
  Copilot's ASCII45 plan numbered nine items FT-260 to FT-268***, not six
  from FT-263, and FT-260 to FT-264 are real recorded defects in CLAUDE.md.
  **Renamed Copilot's to CP-1 to CP-9**, each line asserted before change,
  header note added. Triage and CLAUDE.md numbers stand.

**Four "unsourced" flags in Cloud's Part B (B-11b, B-12b, B-14a, B-19a) had
sources -- they existed only in the 09-24 research pass inside a Claude Code
session, never in the repo.** Filed as
`GatewayGuard_GuidePart3-Sources-2026-09-25-1320.md`. **Lesson: research that
changes a guide sentence goes into `ProjectDocs\` with the sentence, the same
commit, or the next reviewer re-flags it.**

**Part B applied to the Part 3 twin, except the two waiting on Bill (B-15c
naming a password manager; B-P4b moving the restore point into Part 1):**
B-10a Home/Pro permission line; B-10b dropped "and Windows Hello" (does not
protect a Remote Desktop sign-in -- *inferred*, Cloud's); B-10c, B-14b, B-15b
VERIFY markers for on-screen labels (W-07); B-11a the website's "more than a
taste" sentence, so guide and site match Bill's 08-21 call; B-12a Insider
wording; B-14a narrowed to what the source says (Edge's news feed); B-14c
Checkup is all-or-nothing on Widgets; B-15a "open-source" out; B-18a/b Fast
Startup plain reason (VERIFY) and the "(recommended)" label explained; B-N1;
B-P4a "can be put back". VERIFY markers in Part 3: 7.

**`Tool2\Update-Current.ps1`:** two rows added (Cloud review; Part 3 sources).

**Waiting on Bill (Cloud's questions 1-4):** no named password manager?;
approve the Part 4/Part 5 outline?; Firefox addendum out of the 10-15 guide?;
launch/after split acceptable?

---
---

## Session: 2026-09-25 11:04 [Claude Code -- CGDELL] -- AFTER THE PC RESET: GIT BACK, 371 FILES RETIRED, ascii44 TRIAGED, AND PASSWORD-ON-WAKE WAS NEVER READABLE ANYWHERE

Session ran 2026-09-24 21:42 to 2026-09-25 11:04 ET.

**CGDELL was reset around 2026-09-21** (Bill's reset notes on the D: USB
stick say so; now filed in `Notes\PCReset-2026-09-21\`). ***Measured: git
and Python were both gone -- `git` not on PATH, `python` resolved only to the
Microsoft Store stub.*** Installed Git 2.55.0 and Python 3.13.15 (all users)
with winget, plus `python-docx` for the two `Tool2\` scripts that import it.
Git identity set to William F. Burns III / william.wfbiii@gmail.com.
**Do not run `GatewayGuard-PostReset.ps1`** -- Copilot wrote it; it would set
`DisableFileSyncNGSC=1` (turns OneDrive sync off, where this whole project
lives), commit under the wrong surname, and clone four repos that do not exist.

**OneDrive fights git again, one new way.** The first commit failed:
*"unable to append to '.git/logs/refs/heads/main': Invalid argument"* --
OneDrive holds git's reflog files as cloud items (attributes 0x420).
***Fixed with `git config --local windows.appendAtomically false`***, the
fix git itself suggested. Undo: `git config --local --unset
windows.appendAtomically`. First push after the reset needed Bill to sign in
to GitHub from his own terminal; Claude Code's shell cannot show the prompt.

**371 tracked files retired -- commit `11710d8`, pushed and verified.**
***Measured: 371 tracked files missing from disk, 689 untracked.*** OneDrive
had undone the 2026-09-04 retire-to-`Archive\` moves -- the D: backup dated
09-15 already shows the same state, so the reset did not cause it. Bill:
*"We don't need those files... get rid of them again."* The 280 loose copies
that had reappeared in `ProjectDocs\` (incl. the 14.6 MB PCMag page) were
checked byte-identical to committed blobs, then removed from disk. Everything
stays in history.

**THE GITHUB REPO IS PUBLIC.** ***Measured via the GitHub API:
`GatewayGuard/GatewayGuard`, `private: False`.*** The two "Recovery Keys"
files held only the words "Recovery Keys" -- no keys were exposed. Raised to
Bill; nothing changed.

**D: drive (8 GB USB) swept for the past two weeks.** 1,886 files changed
since 09-10; 418 already in OneDrive; only the three PC-reset files were new
and they are filed. Git internals dumped flat into `D:\GG-LLC\` and Windhawk
app cache were deliberately not copied.

**Guide comments applied (Bill's single-quoted notes).**
- Part 1: "greatest" to "significant" per Bill, and a PL-4 sweep for the
  same class across all three twins -- four more changed, including Part 2's
  identical "greatest security benefit".
- Part 2: ***no quoted comments exist in any Part 2 file, on C: or D:*** --
  only a stray "Guiide". Told Bill they were likely never saved.
- Part 3: Remote Desktop (Home connects out, cannot be reached; Quick Assist
  steps); Advertising ID and Diagnostic Data rewritten as privacy, not
  security; Widgets -- ***sourced: the taskbar temperature IS the Widgets
  button, so it goes too***, with a keep-weather-drop-news option; Chrome and
  Firefox password settings added (Firefox label carries a new VERIFY); Wake
  on LAN's "network backup software" replaced -- ***sourced: Veeam, Macrium
  and Windows Update wake the PC with timers, not WoL***; locked-controls
  note now states exactly what `Get-GGPolicyLock` detects; Part 4 lead-in no
  longer implies earlier changes were unsafe.
- **Decision for Bill: naming Bitwarden.** Free, USA, audited yearly. The
  approved-products rule forbids it until he says yes.

**Part 4 of the guide has never been written** -- only its lead-in line at
the end of Part 3 exists.

**ascii44 field run triaged.** ***9 run logs on SANDY, 2026-09-19/20, plus
Bill's 32 notes*** -> `ProjectDocs\GatewayGuard_FieldTestTriage-ascii44run1-2026-09-24-2353.md`,
logs copied to `Test_Results\FieldRun-ascii44\`. New FT-265 through FT-285.
Two findings re-measured by Claude Code before filing:
- **FT-268: `powercfg /query` omits hidden settings; CONSOLELOCK is hidden.**
  ***Measured on CGDELL 2026-09-24 23:53: `/query` returns only the scheme
  header; `/qh` returns AC and DC index 0x1.*** So the 09-17 conclusion that
  setting 17 is "unreadable on this machine" was wrong -- the build reads it
  with the wrong switch, on every machine. FT-256's four-state reader is
  correct and stays; its input command is the defect.
  **`GatewayGuard_SettingsLocationList-2026-09-08-2130.md` row 17 and its
  FT-256 section are now stale on this point and need correcting.**
- **FT-265: screens 10 and 11 re-run on every resume.** ***Measured:
  `Get-WinEdition` line 9812 and `Get-RAMStatus` line 9815 are
  unconditional.*** Explains Bill's notes 9, 14, 21 and 24.
Twelve decisions for Bill are listed in the triage, each with a
recommendation.

**Measured on CGDELL today, for the record:** `TaskbarDa` is now absent
(read 1 on 09-17); `AllowTelemetry` = 3 (Optional diagnostic data).

**Next free FT number: 286.**

Files: `ProjectDocs\GatewayGuard_CoPilotGuidePart1/2/3-2026-09-16-1627.md`,
`ProjectDocs\GatewayGuard_FieldTestTriage-ascii44run1-2026-09-24-2353.md`
(new), `Test_Results\FieldRun-ascii44\` (new, 10 files),
`Notes\PCReset-2026-09-21\` (new, 3 files), this log.

---
---

## OLDER ENTRIES MOVED (2026-10-03)

Entries before 2026-09-25 11:04 moved word for word to `Archive/SessionLog-before-2026-09-25.md` -- Cloud's project knowledge was at 181% of capacity (Bill, 2026-10-03). Archive is outside Cloud's scope; the text is unchanged and still in git.

---

## WORKFLOW GUIDE (permanent reference)

### WHEN TO START A NEW CHAT (Claude.ai)
Start a new chat when ANY of these are true:
- You uploaded new files to the project during the current chat
- Claude Code produced files you want Claude.ai to see
- This chat has produced more than 10 files or major deliverables
- A rule was forgotten or violated in this session
- You are starting a new major task
- Claude expressed uncertainty about something it should know

### HOW TO HAND OFF

**Before closing a Claude.ai chat:**
1. Download all files produced this session
2. Download updated SessionLog and READ-FIRST-Briefing
3. Upload all new files to Claude project
4. Delete superseded versions from project
5. Note what is pending

**Before closing Claude Code:**
1. Save all edited files to OneDrive\GatewayGuard
2. Note current build number and what changed
3. Update SessionLog.md and save to OneDrive\GatewayGuard

### WHAT TO SAY AT THE START OF A NEW CLAUDE.AI CHAT

```
New session. Please:
1. Read _READ-FIRST-Briefing from project files and confirm status.
2. Read GatewayGuard_ProjectInstructions from project files.
3. Read GatewayGuard_SessionLog if present.
4. Confirm the three governing docs and their dates:
   CLAUDE.md, WebsiteStandards, CodingStandards.
5. Ask me for today's date and time.
6. Ask which machine I am working on.
Current date: [fill in]
Current time: [fill in ET]
Machine: [CGDELL | SANDY | Sandy3]
Task: [what you want to do]
```

### WHAT TO SAY AT THE START OF A NEW CLAUDE CODE SESSION

```
New session. Current build: ascii[N].
Read CLAUDE.md and GatewayGuard_SessionLog.md.
Confirm current status before doing anything.
Task: [what you want to do]
```

### EDITOR TAG FORMAT

Add to every file header immediately after the Dated line:
```
<!-- Editor: Claude Code (CGDELL) -->   (this chat produced or last edited it)
<!-- Editor: Claude Code -->  (Claude Code terminal produced or last edited it)
<!-- Editor: Bill -->         (manually edited by Bill)
```

Add to Change History entries:
```
2026-08-04 11:05: [Claude.ai] Description of change.
2026-08-02 07:41: [Claude Code] Description of change.
```

### END OF SESSION CHECKLIST (run before closing any chat)

**Claude.ai must:**
- [ ] Update SessionLog with everything completed this session
- [ ] Update READ-FIRST-Briefing with current status
- [ ] Revise any governing doc (ProjectInstructions, WebsiteStandards,
      CodingStandards, CLAUDE.md) that had rule changes this session
- [ ] Tell Bill to download ALL files produced or changed this session
- [ ] Tell Bill to upload ALL new files to project
- [ ] Tell Bill to delete all superseded versions from project
- [ ] Remind Bill which machine-specific files go to OneDrive\GatewayGuard

**Claude Code must:**
- [ ] Update SessionLog.md and save to OneDrive\GatewayGuard
- [ ] Commit all changed files
- [ ] Update CLAUDE.md if any rules changed
- [ ] Note current build number in SessionLog

