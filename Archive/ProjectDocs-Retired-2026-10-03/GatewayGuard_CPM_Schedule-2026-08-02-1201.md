# **GATEWAYGUARD — CRITICAL PATH METHOD (CPM) SCHEDULE**

**File:** GatewayGuard_CPM_Schedule-2026-08-02-1201.md

**Revision 7 — 02-Aug-2026 (12:01 PM EDT)**

> **TARGET MOVED, 2026-08-30. LAUNCH IS NOW 15-Sep-2026 (Tuesday), not
> 01-Sep.** Two weeks later, same weekday. **Everything below is computed
> against the old date and the float figures are therefore wrong** -- the
> critical path, the slack, and "buffer to September 1" all need recomputing
> from a fresh baseline. **They are left as they were on purpose.** Hand-editing
> a computed float turns a schedule into a guess wearing a table, and the next
> reader cannot tell which numbers were calculated and which were typed.
> **Rebaseline this document before relying on any number in it.**

**Baseline date:** 02-Aug-2026  |  **Target launch:** ~~01-Sep-2026~~ **15-Sep-2026**  |  **Calendar days remaining:** *(stale -- was 30 from 02-Aug)*  |  **Working days remaining:** *(stale -- was 22)*

**Current build:** **ascii39** (built 2026-07-30 22:08, **NOT YET FIELD-TESTED**)
**Last field-tested build:** ascii38 (SANDY, 2026-07-30)
**Product name:** the tool is **Checkup**. GatewayGuard is the company.

---

## **WHAT CHANGED FROM REVISION 6 (30-Jul-2026)**

Three calendar days. **The zero-float task is done, and a blocker was found
that had been invisible for months.**

**T-GW IS COMPLETE.** Rev 6 called the remaining guide pages *"the task most
likely to break the plan"* — 10 pages, zero float, running at a measured 2
pages per 6 days against a plan of 1.5/day. **All 19 now exist**, pass all
eight mechanical checks, and carry corrected copy. That was the tightest
constraint in the schedule and it is gone.

**FT-162 — the quarterly Defender scan has never run on any machine.**
`MpCmdRun.exe -Scan -ScanType 4` is not a valid flag; it returns
`0x80070667 Invalid command line argument` in 0.0 seconds. The task was
created correctly every time and the log printed `[GOOD]` every time. Four
generations of work (FT-73/76/93/109) asked *"was the task created?"* and
never *"does the command work?"*

**FT-109 CLOSED** — first external verification since ascii32, via
`Run-ScheduledTasksCheck.bat` on SANDY.

**New this cycle:** FT-161 (both scheduled tasks blocked on battery),
FT-163/164 (BitLocker time estimate reads the wrong disk and keys off RAM),
FT-165/166 (Remote Assistance never checked; Quick Assist never mentioned).

**New tooling:** gate 24 external-command verification, gate 12b 26-line
ratchet, scheduled-task verifier, encryption timing measurer.

---

## **STATUS I STILL CANNOT VERIFY — BILL TO CONFIRM**

Unchanged from Rev 6 and now three days older. These drive the critical path.

| # | Item | Last known | Needed |
|---|---|---|---|
| 1 | **DigiCert/Sectigo OV validation** | Token assigned 7/18, validation pending | **Is it complete?** Gates T-SN and therefore launch |
| 2 | **LegalZoom Call 1 (EULA)** | Scheduled Mon 7/27 | Did it happen? Feedback incorporated? |
| 3 | **Calls 2–4** | Not scheduled | Any booked? |
| 4 | **GitHub Pages** | index + 404 live | Is anything else pushed? |

**If item 1 has not started, it is now the longest pole and the buffer below
is wrong.**

---

## **ASSUMPTIONS**

• Working days = Mon–Fri. Day 1 = Mon 03-Aug.

• **Two build rounds are scheduled, not hoped for** (carried from Rev 6, and
  vindicated: ascii39's field test has not run and FT-162 alone guarantees an
  ascii40).

• **Feature freeze is a DATE: Fri 14-Aug.** Unchanged from Rev 6.

• ascii39 field test follows `GatewayGuard_FieldTestPlan-ascii39-2026-08-02-0919.md`
  — Dell first (survival + detection), then SANDY, because SANDY's encryption
  is a **one-shot measurement** that cannot be recovered afterwards.

• **Screenshots still cannot start until the build is signed** (T-SN).

• Website authoring continues in the Cloud session; verification here.

---

## **TASK TABLE**

ES/EF/LS/LF in working days from Mon 03-Aug. ★ = on critical path.

| **ID** | **Task** | **Dur** | **Pred.** | **ES** | **EF** | **LS** | **LF** | **Slack / Critical** |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **BUILD** | | | | | | | | |
| T-39T | **ascii39 field test** — Dell then SANDY, per the field test plan | 2 | — | 0 | 2 | 0 | 2 | **★ CRITICAL** |
| T-ENC | **SANDY encryption + timing capture** (one-shot; FT-110 escrow, FT-145 progress) | 1 | T-39T | 2 | 3 | 3 | 4 | 1 |
| T-40 | **ascii40 build** — FT-162 (quarterly scan), FT-161 (battery), FT-163/164 (estimate), FT-165/166 (remote access), 3 "whether" strings, 10 oversized screens | 3 | T-39T | 2 | 5 | 2 | 5 | **★ CRITICAL** |
| T-40T | ascii40 field test — all three machines | 2 | T-40 | 5 | 7 | 5 | 7 | **★ CRITICAL** |
| T-FRZ | **FEATURE FREEZE — Fri 14-Aug** | 0 | T-40T | 7 | 7 | 7 | 7 | **★ CRITICAL** |
| T-FX | Contingency fix round (ascii41, only if T-40T finds a blocker) | 2 | T-FRZ | 7 | 9 | 7 | 9 | **★ CRITICAL** |
| **INFRA** | | | | | | | | |
| T-CS | DigiCert/Sectigo OV validation — **STATUS UNCONFIRMED** | 0–5 | — | 0 | 5 | 3 | 8 | ★ if pending (3) |
| T-TK | Token confirmed working — test sign | 1 | T-CS | 5 | 6 | 8 | 9 | 3 |
| T-SN | **Sign release build** (.ps1 only) | 1 | T-TK, T-FX | 9 | 10 | 9 | 10 | **★ CRITICAL** |
| T-SC | SmartScreen smoke test | 0.5 | T-SN | 10 | 10.5 | 10 | 10.5 | **★ CRITICAL** |
| **WEBSITE** | | | | | | | | |
| ~~T-GW~~ | ~~Remaining guide setting pages~~ | — | — | — | — | — | — | **COMPLETE 02-Aug — all 19 built and checked** |
| T-GD | **Rewrite the written guide** from the 19 corrected pages (W-07 feed-back) | 3 | — | 0 | 3 | 6 | 9 | 6 |
| T-W1 | **`tips.html`** — assemble from GG-Tips.md + Note tips.txt + mouse/trackpad research | 1 | — | 0 | 1 | 7 | 8 | 7 |
| T-W2 | **`beta.html` + `compatible.html`** — need product decisions first | 1 | decisions | 0 | 1 | 7 | 8 | 7 |
| T-DL | **`download.html`** — Gumroad link, system requirements, SHA-256 placeholder | 1 | — | 0 | 1 | 9.5 | 10.5 | 9.5 |
| T-W3 | Screenshots — all 19 settings, **must match the FINAL SIGNED build** | 1 | T-SN | 10 | 11 | 10 | 11 | **★ CRITICAL** |
| T-W4 | QA full site: links, nav, download file, hash, mobile | 1 | T-DL, T-W3, T-W1, T-W2 | 11 | 12 | 11 | 12 | **★ CRITICAL** |
| T-W5 | Publish SHA-256 of the signed build | 0.5 | T-W4 | 12 | 12.5 | 12 | 12.5 | **★ CRITICAL** |
| **LEGAL** | | | | | | | | |
| T-LR | EULA Call 1 + incorporate — **UNCONFIRMED** | 2 | — | 0 | 2 | 10 | 12 | 10 |
| T-L2 | Refund policy Call 2 + incorporate | 2 | T-LR | 2 | 4 | 12 | 14 | 10 |
| T-L3 | Apps Audit liability Call 3 | 2 | T-L2 | 4 | 6 | 14 | 16 | 10 |
| T-L4 | Incident response Call 4 | 2 | T-L3 | 6 | 8 | 16 | 18 | 10 — post-launch OK |
| T-CR | Copyright registrations — **file as "Checkup"** | 2 | T-LR | 2 | 4 | 15 | 17 | 13 |
| **LAUNCH** | | | | | | | | |
| T-QA | Final integration QA — Checkup ↔ website, all 3 machines | 1 | T-SC, T-W5 | 12.5 | 13.5 | 12.5 | 13.5 | **★ CRITICAL** |
| T-MK | Marketing sweep — **must say Checkup** | 2 | T-LR | 2 | 4 | 11.5 | 13.5 | 9.5 |
| T-PF | Old project file cleanup | 0.5 | — | 0 | 0.5 | 18 | 18.5 | 18 |
| T-LP | Launch prep: pricing locked, Gumroad live, EULA posted | 1 | T-QA, T-MK | 13.5 | 14.5 | 13.5 | 14.5 | **★ CRITICAL** |
| T-GO | **LAUNCH — September 1, 2026** | 0 | T-LP | 14.5 | 14.5 | 14.5 | 14.5 | **★ CRITICAL** |

---

## **CRITICAL PATH**

**Chain 1 (build):** T-39T → T-40 → T-40T → T-FRZ → T-FX → T-SN → T-SC

**Chain 2 (screenshots):** T-SN → T-W3 → T-W4 → T-W5

**Chain 3 (cert):** T-CS → T-TK → T-SN *(critical only if validation is still pending)*

Converging at T-QA → T-LP → T-GO.

**Critical path length: ~14.5 working days ≈ 21 calendar days** | From 03-Aug → completes ~**22-Aug** | **Buffer to September 1: ~10 calendar days.**

**The website is no longer on the critical path.** With T-GW complete, every
remaining web task has 6–9.5 days of float and the binding chain is now
**build → freeze → sign → screenshots**. That is a materially healthier
shape than Rev 6, where two chains ran at zero float simultaneously.

---

## **FLOAT ANALYSIS**

| Task | Float | Note |
| --- | --- | --- |
| T-39T (ascii39 field test) | **0 wd** | ★ Gates everything. Run it this week |
| T-40 (ascii40) | **0 wd** | ★ FT-162 alone makes this mandatory |
| T-CS (cert) | 3 wd *if pending* | **Unconfirmed — could become the longest pole** |
| T-ENC (SANDY encryption) | 1 wd | One-shot. If missed, no measured encryption timing ever |
| T-GD (guide rewrite) | 6 wd | Cloud session |
| T-W1/T-W2 (tips, beta, compatible) | 7 wd | Needs product decisions for beta/compatible |
| T-DL (download.html) | 9.5 wd | Content can be drafted now; the hash waits for T-SN |
| Legal | 10 wd | Only T-LR and T-L2 gate anything shippable |

---

## **RISK FLAGS**

| Risk | Likelihood | Impact | Mitigation |
| --- | --- | --- | --- |
| **Cert validation still pending** | **Unknown** | **HIGH — blocks signing** | Confirm Monday. Now the most likely thing to break this plan, with T-GW done |
| **ascii40 surfaces another blocker** | Medium | Medium | T-FX is the allowance. Beyond that, ship with known cosmetic defects |
| **SANDY encryption window missed** | Medium | Medium — no measured timing, ever | One-shot. `Run-EncryptionMeasure.bat` must start BEFORE encryption |
| **ascii39 mixes three change classes** | Certain (by decision) | Medium — slower triage | Field test in the class order given in the plan |
| **More "silent success" defects like FT-162** | **Medium** | **HIGH** | Gate 24 now checks external commands. But FT-162 stood for months — assume siblings exist |
| **Screenshots redone** | Medium | Medium | T-W3 deliberately after T-SN |
| **Guide and website drift again** | Medium | Medium | W-07 both ways. Verify the guide rewrite against the 19 pages |
| **Annual Updates pricing undecided** | Medium | Low for launch | Lock before T-LP |

---

## **IMMEDIATE NEXT ACTIONS (week of 03-Aug)**

| # | Action | Owner | Unblocks |
| --- | --- | --- | --- |
| 1 | **Field-test ascii39** — Dell first, then SANDY | Bill | T-39T → everything |
| 2 | **Confirm cert validation status** — first thing Monday | Bill | T-CS → T-SN |
| 3 | **SANDY encryption with measurement running** | Bill | T-ENC, FT-110, FT-145 |
| 4 | Confirm LegalZoom Call 1 happened | Bill | T-LR → T-L2 |
| 5 | Guide rewrite from the 19 corrected pages | Cloud + verify here | T-GD |
| 6 | tips.html; decide beta/compatible scope | Bill + Cloud | T-W1, T-W2 |
| 7 | Draft download.html (hash added after signing) | Claude Code | T-DL |
| 8 | Copyright registration as **Checkup** | Bill | T-CR |

---

## **OPEN DECISIONS**

| # | Decision | Note |
| --- | --- | --- |
| 1 | Annual Updates pricing | $12.99/update working number. Blocks T-LP |
| 2 | Refund policy | LegalZoom Call 2 |
| 3 | **Quarterly Defender scan: reminder or silent action?** | FT-162/FT-166. Recommend a reminder like the Malwarebytes one — a silent reboot into a pre-boot scanner is wrong for this audience |
| 4 | **Quick Assist: remove, or educate only?** | FT-166. Recommend educate + optional removal, never silent |
| 5 | **beta.html / compatible.html scope** | Who is in the beta; what "compatible" claims. Blocks T-W2 |
| 6 | The 10 oversized screens | Cosmetic. Recommend splitting the worst three |
| 7 | Incident response plan | Post-launch acceptable |
| 8 | Analytics / Microsoft Store | Post-launch |

---

## **DECISIONS LOGGED THIS REVISION**

**DECISION (02-Aug-2026):** All 19 guide pages complete and verified. **T-GW
closed** — the zero-float critical-path task from Rev 6 is done, and the
website leaves the critical path.

**DECISION (02-Aug-2026):** Banned words **"whether" and "whereas"** in all
user-facing copy; **permission wording required** whenever a setting change
is described. Applied to all 19 pages (26 instances removed); three strings
remain in the build for ascii40.

**DECISION (02-Aug-2026):** Quarterly Defender scan — **`StartWhenAvailable`
only, no `WakeToRun`.** Nothing wakes a laptop at 02:00 to reboot it.

**DECISION (02-Aug-2026):** Division of labour — **Cloud authors, Claude Code
verifies.** Proven twice: the FT-157 false claim and two byte-identical
passthrough pages, neither of which would have surfaced without mechanical
checks Cloud cannot run against local files.

**Revision history:** Rev 1–3 (pre-Dell → ascii22), Rev 4 (15-Jul, ascii31,
48 days), Rev 5 (24-Jul, ascii33, 38 days), Rev 6 (30-Jul, ascii39, 33 days),
**Rev 7 (02-Aug, ascii39, 30 days).**
