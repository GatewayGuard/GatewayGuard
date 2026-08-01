# **GATEWAYGUARD — CRITICAL PATH METHOD (CPM) SCHEDULE**

**File:** GatewayGuard_CPM_Schedule-2026-07-30-2208.md

**Revision 6 — 30-Jul-2026 (10:08 PM EDT)**

**Baseline date:** 30-Jul-2026  |  **Target launch:** 01-Sep-2026  |  **Calendar days remaining:** 33  |  **Working days remaining:** 23

**Current build:** **ascii39** (built 2026-07-30 22:08, **NOT YET FIELD-TESTED**)
**Last field-tested build:** ascii38 (tested 2026-07-30 on HP SANDY, Windows 11 **Home**)
**Product name:** the tool is **Checkup**. GatewayGuard is the company. Certified 2026-07-29.

---

## **WHAT CHANGED FROM REVISION 5 (24-Jul-2026)**

Six calendar days. **Six builds.**

**Completed:** ascii34, 35, 36, 37, 38, 39 all built. ascii38 field-tested on
SANDY — **the first Windows 11 Home field run in the project's history**.
Product renamed to Checkup (2026-07-29). SANDY back online via the TP-Link USB
adapter. Two more guide pages built (memory-integrity, wake-on-lan). Screen
gallery and mechanical screen-coverage gate built. ascii39 built tonight
closing all 20 open items from the ascii38 run.

**D-20 / Windows Home BitLocker: CLOSED.** This was Rev 5's headline risk
("Certain — affects all Home users"). ascii38 field log confirms the Home
Device Encryption path renders, `Enable-BitLocker` is never called, and
0x8031005A never appears. ascii39 rebuilds that screen into four screens with
the recovery key handled as a precondition.

**Rev 5's central assumption has failed and must be replaced.** Rev 5 said
*"Feature freeze after ascii34 unless blocking defect surfaces."* We are five
builds past that freeze. Each round has surfaced real defects — the ascii38 run
alone produced 20, including two that could end a user's session. The plan
below **stops predicting a freeze and instead schedules two more rounds**, then
freezes on a date rather than on a build number.

**Corrected from Rev 5:** guide pages were counted as "7 built, 12 remaining".
Measured on disk 2026-07-30: **9 built, 10 remaining**.

---

## **STATUS I COULD NOT VERIFY — BILL TO CONFIRM BEFORE THIS PLAN IS TRUSTED**

Everything above is measured from the repository. The four items below drive the
critical path and I have **no evidence either way**. They are carried at Rev 5's
values and flagged, not guessed.

| # | Item | Last known (Rev 5) | Needed |
|---|---|---|---|
| 1 | **DigiCert/Sectigo OV validation** | Token assigned 7/18, validation pending | Is validation **complete**? This gates T-SN and therefore launch |
| 2 | **LegalZoom Call 1 (EULA)** | Scheduled Mon 7/27 10:30 AM | Did it happen? Feedback incorporated? |
| 3 | **LegalZoom Calls 2–4** | Not yet scheduled | Any booked? |
| 4 | **GitHub Pages** | index + 404 live; guide/index ready to push | Is guide/index.html pushed? Which setting pages are live? |

**If item 1 is still pending, it becomes the single longest pole and the buffer
below is wrong.** Follow up first thing Friday.

---

## **ASSUMPTIONS**

• Working days = Mon–Fri. No holidays between now and Sep 1. Day 1 = Fri 31-Jul.

• **Two more build rounds are scheduled, not hoped for.** ascii39 field test →
  ascii40 (fix round) → ascii40 field test. Rev 5's one-round assumption has
  been wrong five times running; planning one round again would be the same
  error a sixth time.

• **Feature freeze is a DATE, not a build.** Fri 14-Aug. After that, only
  defects that can lose a user's data or end their session get fixed.

• ascii39 closes all 20 ascii38 items but **mixes three change classes** at
  Bill's direction. If a field failure appears, attribution is harder than
  usual — budget triage time accordingly.

• Guide pages: 9 built, 10 remaining, ~0.7 working days each ≈ 7 working days.

• **Screenshots cannot be taken until the UI stops moving AND the build is
  signed.** Six builds in six days means every screenshot taken before freeze
  is waste. This is why T-W3 sits after T-SN.

• The HTML "tool → Checkup" sweep is running in a separate Claude Cloud session
  concurrently with this plan. Treated as task T-RN.

• Copyright registration must name **Checkup**, not "Tool" — the name changed
  after Rev 5 was written.

---

## **TASK TABLE**

ES/EF/LS/LF in working days from Fri 31-Jul. ★ = on critical path.

| **ID** | **Task** | **Dur** | **Pred.** | **ES** | **EF** | **LS** | **LF** | **Slack / Critical** |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **INFRA** | **Code signing / cert** | | | | | | | |
| T-CS | DigiCert/Sectigo OV validation — **STATUS UNCONFIRMED** | 0–5 | — | 0 | 5 | 3.5 | 8.5 | ★ CRITICAL if pending (3.5) |
| T-TK | Token confirmed working — test sign on IdeaPad | 1 | T-CS | 5 | 6 | 8.5 | 9.5 | 3.5 |
| **BUILD** | **PowerShell builds and testing** | | | | | | | |
| T-39T | **ascii39 field test** — SANDY (Home) + Dell (Pro), per the plan in the ascii39 TestHistory | 2 | — | 0 | 2 | 0 | 2 | **★ CRITICAL** |
| T-40 | **ascii40 build** — ascii39 field defects + the 10 oversized screens (FT-153 baseline) + FT-146 look-back redesign | 3 | T-39T | 2 | 5 | 2 | 5 | **★ CRITICAL** |
| T-40T | ascii40 field test — all three machines | 2 | T-40 | 5 | 7 | 5 | 7 | **★ CRITICAL** |
| T-TS | **Open Task Scheduler on SANDY, confirm both GatewayGuard tasks** (gate 21 / C-25 — FT-109 does not close without this) | 0.5 | T-39T | 2 | 2.5 | 10 | 10.5 | 8 |
| T-FRZ | **FEATURE FREEZE — Fri 14-Aug** | 0 | T-40T | 7 | 7 | 7 | 7 | **★ CRITICAL** |
| T-FX | Contingency fix round (ascii41 — only if T-40T finds a blocker) | 2 | T-FRZ | 7 | 9 | 7 | 9 | **★ CRITICAL** |
| T-SN | Sign release build (.ps1 only — .bat unsigned) | 1 | T-TK, T-FX | 9 | 10 | 9 | 10 | **★ CRITICAL** |
| T-SC | SmartScreen smoke test — download signed build, confirm no Unknown Publisher | 0.5 | T-SN | 10 | 10.5 | 10 | 10.5 | **★ CRITICAL** |
| **WEBSITE** | **HTML pages** | | | | | | | |
| T-RN | **"tool" → "Checkup" sweep across all .html** (Claude Cloud, in progress) + re-run H-1/H-2/H-3 validation | 1 | — | 0 | 1 | 5 | 6 | 5 |
| T-GI | Push guide/index.html — **confirm whether already done** | 0.5 | — | 0 | 0.5 | 0 | 0.5 | **★ CRITICAL** |
| T-GW | Remaining **10** guide setting pages (periodic-scanning, windows-hello, remote-desktop, advertising-id, diagnostic-data, edge-startup, widgets, password-manager, password-on-wake, fast-startup) | 7 | T-GI | 0.5 | 7.5 | 0.5 | 7.5 | **★ CRITICAL** |
| T-DL | download.html (Gumroad link, SHA-256 placeholder, system requirements) | 1 | T-GW | 7.5 | 8.5 | 7.5 | 8.5 | **★ CRITICAL** |
| T-W3 | Screenshots — all 19 settings, **must match the FINAL SIGNED build** | 1 | T-SN | 10 | 11 | 10 | 11 | **★ CRITICAL** |
| T-W4 | QA full site: links, nav, download file, hash, mobile | 1 | T-DL, T-W3 | 11 | 12 | 11 | 12 | **★ CRITICAL** |
| T-W5 | Publish SHA-256 of the signed build on the download page | 0.5 | T-W4 | 12 | 12.5 | 12 | 12.5 | **★ CRITICAL** |
| **LEGAL** | **LegalZoom consultations** | | | | | | | |
| T-LR | EULA Call 1 + incorporate feedback — **STATUS UNCONFIRMED** | 2 | — | 0 | 2 | 10 | 12 | 10 |
| T-L2 | Refund policy Call 2 + incorporate | 2 | T-LR | 2 | 4 | 12 | 14 | 10 |
| T-L3 | Apps Audit liability Call 3 | 2 | T-L2 | 4 | 6 | 14 | 16 | 10 |
| T-L4 | Incident response Call 4 + written plan | 2 | T-L3 | 6 | 8 | 16 | 18 | 10 — post-launch acceptable |
| T-CR | Copyright registrations — **register as "Checkup", not "Tool"** | 2 | T-LR | 2 | 4 | 15 | 17 | 13 |
| **LAUNCH** | **Final prep and go-live** | | | | | | | |
| T-QA | Final integration QA: Checkup ↔ website links, end-to-end on all 3 machines | 1 | T-SC, T-W5 | 12.5 | 13.5 | 12.5 | 13.5 | **★ CRITICAL** |
| T-MK | Marketing sweep + ACBL pitch + BBO/forum drafts — **must say Checkup** | 2 | T-LR | 2 | 4 | 11.5 | 13.5 | 9.5 |
| T-PF | Old project file cleanup (retire superseded docs) | 0.5 | — | 0 | 0.5 | 18 | 18.5 | 18 |
| T-LP | Launch prep: pricing locked, Gumroad live, EULA posted, final checklist | 1 | T-QA, T-MK | 13.5 | 14.5 | 13.5 | 14.5 | **★ CRITICAL** |
| T-GO | **LAUNCH — September 1, 2026** | 0 | T-LP | 14.5 | 14.5 | 14.5 | 14.5 | **★ CRITICAL** |

---

## **CRITICAL PATH**

**Chain 1 (build):** T-39T → T-40 → T-40T → T-FRZ → T-FX → T-SN → T-SC

**Chain 2 (website):** T-GI → T-GW → T-DL → T-W4 → T-W5

**Chain 3 (screenshots):** T-SN → T-W3 → T-W4

**Chain 4 (cert):** T-CS → T-TK → T-SN *(critical only if validation is still pending)*

All chains converge at T-QA → T-LP → T-GO.

**Critical path length: ~14.5 working days ≈ 21 calendar days**  |  From 31-Jul → completes ~**20-Aug**  |  **Buffer to September 1: ~12 calendar days (8.5 working days).**

**The buffer is real but thinner than Rev 5's.** Rev 5 claimed 14 calendar days
of buffer while assuming one more build; this plan claims 12 while assuming
three. That is the more honest number.

---

## **FLOAT ANALYSIS**

| Task | Float | Note |
| --- | --- | --- |
| T-GW (guide pages) | **0 wd** | ★ CRITICAL. 10 pages, ~7 working days, zero float — same as Rev 5, where it also had zero float and slipped. **This is the task most likely to break the plan.** |
| T-39T (ascii39 field test) | **0 wd** | ★ CRITICAL and it is the gate on everything downstream. Run it this weekend |
| T-CS (cert validation) | 3.5 wd *if pending* | Unconfirmed. If validation has not started, this becomes the longest pole |
| T-MK (marketing) | 9.5 wd | Must be re-swept for the Checkup rename |
| T-LR–T-L4 (legal) | 10 wd | Only T-LR and T-L2 gate anything shippable |
| T-TS (Task Scheduler check) | 8 wd | 30 minutes of work that closes a defect open since ascii32 |
| T-CR (copyright) | 13 wd | Name is now Checkup |
| T-PF (file cleanup) | 18 wd | Any time |

---

## **RISK FLAGS**

| Risk | Likelihood | Impact | Mitigation |
| --- | --- | --- | --- |
| **Guide pages slip again** | **High** | **HIGH — 0 float** | Zero float in Rev 5 too, and it slipped: 12 remaining then, 10 now — **2 pages in 6 days against a plan of 1.5/day.** Either commit real hours or cut scope to the settings users actually change |
| **ascii39 mixes three change classes** | Certain (by decision) | Medium — slower triage | Field test in the class order given in the ascii39 TestHistory §4 so failures stay attributable |
| **A seventh and eighth build round** | Medium | HIGH — eats the buffer | T-FX is the allowance. **Beyond that, ship with known cosmetic defects.** The 10 oversized screens are cosmetic and must not be allowed to delay launch |
| **Cert validation still pending** | **Unknown** | **HIGH — blocks signing** | Confirm Friday morning. If not started, escalate to SignMyCode immediately |
| **Screenshots redone** | Medium | Medium | T-W3 deliberately sits after T-SN. Do not take screenshots before freeze |
| **HTML rename breaks markup** | **Medium** | Medium — silent | A blanket `tool`→`Checkup` replace also hits **tooltip / toolbar / toolkit**. Require whole-word, case-sensitive matching and re-run H-1 corruption grep after |
| **Website and guide drift apart** | Medium | Medium | W-07 / gate H-4: the guide wins on substance. The rename changes both — sweep them together |
| **FT-109 never actually verified** | Medium | Low–Medium | T-TS. Gate 21: a clean build is not evidence. Open Task Scheduler and look |
| **Annual Updates pricing undecided** | Medium | Low for launch | $12.99 working number. Lock before T-LP |

---

## **IMMEDIATE NEXT ACTIONS (Week of 30-Jul)**

| # | Action | Owner | Unblocks |
| --- | --- | --- | --- |
| 1 | **Field-test ascii39** — SANDY + Dell, following the class-ordered plan in the ascii39 TestHistory §4 | Bill | T-39T → everything |
| 2 | **Confirm DigiCert/Sectigo validation status** — first call Friday | Bill | T-CS → T-SN (possible longest pole) |
| 3 | **Confirm LegalZoom Call 1 happened** and what came back | Bill | T-LR → T-L2 |
| 4 | Resume guide pages — 10 left, **zero float** | Bill + Claude | T-GW (critical) |
| 5 | Finish the HTML Checkup rename, **whole-word only**, then re-run H-1/H-2/H-3 | Claude Cloud | T-RN |
| 6 | Open Task Scheduler on SANDY, confirm both tasks (30 min, closes FT-109) | Bill | T-TS |
| 7 | Confirm which guide pages are actually live on GitHub Pages | Bill | T-GI |
| 8 | Re-sweep marketing copy for "Checkup" | Bill + Claude | T-MK |
| 9 | Copyright registration — file as **Checkup** | Bill | T-CR |

---

## **OPEN DECISIONS (must resolve before launch)**

| # | Decision | Note |
| --- | --- | --- |
| 1 | Annual Updates pricing | $12.99/update working number. Blocks marketing copy and T-LP |
| 2 | Refund policy | LegalZoom Call 2. Blocks EULA Section 8 and the Gumroad listing |
| 3 | **The 10 oversized screens** | Split in ascii40, or ship as-is? Cosmetic. **Recommend: split the worst three (55, 50, 35 lines) and ship the rest** |
| 4 | **FT-146 look-back redesign** | Gated in ascii39, not redesigned. Do it in ascii40 or defer past launch? |
| 5 | Incident response plan | LegalZoom Call 4. Post-launch acceptable |
| 6 | Analytics | Plausible, Fathom, or none. No Google Analytics. Post-launch |
| 7 | Microsoft Store registration | $19 one-time. Not a launch dependency |
| 8 | Marketing launch timing | Before or after 1-Sep? |

---

## **DECISIONS LOGGED THIS REVISION**

**DECISION (30-Jul-2026):** ascii39 scoped to **all 20** open items from the
ascii38 field run, at Bill's direction, against Playbook Class 6 rule 3 and the
ascii38 TestHistory's own recommendation to split. Recorded in the .ps1 header
and the ascii39 TestHistory so a field failure is read with that in mind.

**DECISION (30-Jul-2026):** **Feature freeze becomes a date — Fri 14-Aug —
not a build number.** Five consecutive revisions have predicted a freeze at
"the next build" and been wrong each time.

**DECISION (30-Jul-2026):** **Two build rounds are scheduled, not one.**
ascii39 field test → ascii40 → ascii40 field test, with T-FX as the single
contingency round.

**DECISION (29-Jul-2026):** Product named **Checkup**. GatewayGuard is the
company. Identifiers unchanged — MachineID salt, scheduled task names,
`C:\GatewayGuard\`, `Run-GatewayGuard.bat`, the domain and the LLC name are
recovery points, not prose.

**DECISION (30-Jul-2026):** **D-20 / Windows Home BitLocker CLOSED.** Rev 5's
"Certain / HIGH" risk. Field-confirmed on SANDY, ascii38.

**DECISION (30-Jul-2026):** The 26-line screen rule is enforced as a
**ratchet** — 10 known-oversized screens carried in a named baseline, reported
every run; any new one fails the build.

**Revision history:** Rev 1 (pre-Dell), Rev 2 (Dell ETA), Rev 3 (30-Jun,
ascii22), Rev 4 (15-Jul, ascii31, 48 days), Rev 5 (24-Jul, ascii33, 38 days),
**Rev 6 (30-Jul, ascii39, 33 days).**
