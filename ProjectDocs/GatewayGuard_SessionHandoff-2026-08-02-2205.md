<!-- Dated: 2026-08-02 22:05 EDT -->
# GatewayGuard Session Handoff -- 2026-08-02

**Read this first, then stop.** Everything else from today is already filed in
its proper document. This page exists only for the handful of things that
would otherwise live nowhere but a git commit message.

---

## THE NEXT ACTION, IN ORDER

1. **Build `gg-deploy`** from `WebSite\Index-Builds\GatewayGuard_All19_Final-2026-08-02-1820\`
   with the `-2026-08-02-1820` stripped from each filename. **See the trap below first.**
2. **Run the 7 deployment steps** (Bill's document, machine paths for CGDELL).
3. **FIELD-TEST ascii39.** Dell first for survival, then SANDY. This is the
   only item on the critical path. See
   `GatewayGuard_FieldTestPlan-ascii39-2026-08-02-0919.md`.

---

## THE TRAP -- THREE VARIANTS OF THE 19 PAGES

Only one is current, and **it is the one that fails Pre-check 0** while the two
stale ones pass it.

| Folder | Time | Filenames | Content |
|---|---|---|---|
| `GatewayGuard_All19_Final-2026-08-02-1820\` | **20:54** | timestamped | **CURRENT** -- 30 "Checkup reviews", 0 stutter |
| `GatewayGuard_All19_Final-2026-08-02\` | 18:12 | clean | STALE -- 37 "Checkup checks" |
| `GuidePages-Corrected-2026-08-02-1201\GatewayGuard_All19_Final-2026-08-02\` | 18:09 | clean | STALE -- 37 "Checkup checks" |

**Build the deployment set from the 1820 folder. Not from either clean-named
folder**, however convenient their filenames look.

---

## TWO FILES WERE RENAMED AFTER THE DEPLOYMENT STEPS WERE WRITTEN

Step 6 references the old 07-30 names.

| Purpose | Current filename |
|---|---|
| Guide index (Step 6 Branch B) | `guide-index-2026-08-02-2031.html` |
| Home page (Step 6 Branch A) | `GatewayGuard_index-2026-08-02-2050.html` |

---

## ONE DEFECT CLASS THE VALIDATOR CANNOT CATCH

`bitlocker.html` in the 18:20 batch carried a **duplicated sentence spliced
with a broken `#8212;` entity**. It is valid HTML -- W3C passes it -- but it
renders as literal `#8212;` text mid-paragraph. Fixed 2026-08-02. The 09:57
zip had zero malformed entities; the 18:20 batch had one.

**Therefore: include `bitlocker.html` in the Step 1 browser spot-check.** It is
the page that was broken, and no automated gate would have found it.

---

## WHERE EVERYTHING ELSE LIVES

| Looking for | Read |
|---|---|
| Today's defects, FT-161 to FT-169 | `GatewayGuard_TestHistory-ascii39-2026-08-02-1335.md`, sections 5a-5g |
| The schedule, 30 days out | `GatewayGuard_CPM_Schedule-2026-08-02-1201.md` (Rev 7) |
| How to field-test ascii39 | `GatewayGuard_FieldTestPlan-ascii39-2026-08-02-0919.md` |
| The copy rules added today | `CLAUDE.md` -- banned words, Checkup's verb, name the permission |
| Gate 24 (external commands) | `GatewayGuard_CodingStandards-2026-08-02-0741.md` |
| Session rules | `GatewayGuard_ProjectInstructions-2026-08-02-1820.md` |

---

## STATE

- **ascii39 is built and UNTOUCHED** -- 8,448 lines, 0 parse errors, still the
  field-test candidate. Nothing today modified it.
- **Working tree clean.** Recovery points: `81a2f00` (tooling + defect record),
  `cf134fb` (the verb rule), `9f6297b` (website corrections).
- **All 19 pages, the guide index and the home page pass a 13-check suite.**
- **Free-space wipe tooling is deliberately probe-only** -- the wipe half was
  removed until encryption testing is done. Restore source:
  `scratchpad\wipe-capability-removed-2026-08-02\`.

---

## THE HEADLINE FROM TODAY

**FT-162: the quarterly Defender scan has never run on any machine.**
`MpCmdRun.exe -Scan -ScanType 4` is not a valid flag -- measured
`0x80070667 Invalid command line argument`, 0.0 seconds, no scan. The task was
created correctly every time and the log printed `[GOOD]` every time.

FT-73, FT-76, FT-93 and FT-109 were four generations of work on that exact
task. Every one asked *"was the task created?"* None asked *"does the command
work?"*

That question is now gate 24, and it is mechanical.
