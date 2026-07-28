# GatewayGuard — Critical Path Method (CPM) Schedule
**Baseline date:** 30-Jun-2026 | **Target launch:** 01-Sep-2026 (63 calendar days out)
**Current build:** ascii22 | **LLC:** Filed/FedExed, Noncommercial Registered Agent confirmed
**Revision 2 (30-Jun-2026):** Dell Latitude 5430 picked up today — T1 closed out, schedule re-run with Dell as on-hand, Day 0.

---

## ASSUMPTIONS (flagged for verification)

- ~~Dell Latitude 5430 arrival treated as Day 0–5~~ — **RESOLVED.** Machine is on-hand as of 30-Jun-2026. T1 removed from the network; T2 now starts at Day 0.
- Durations are working days (Mon–Fri), not calendar days.
- Website content-writing estimate (20–25 hrs total) pulled directly from `GatewayGuard_WebsitePrePlan.md` and converted to day-blocks.
- Tasks already complete (LLC filing, ascii22 build, SANDY/IdeaPad first-pass testing, marketing assets, coding standards doc) are excluded from the network — they're sunk cost, not float.
- Beta Tester Program and Website Phase 2/3 are NOT required for a functional 1-Sep launch (site MVP = Phase 1 only per WebsitePrePlan.md) and are intentionally kept OFF the critical path, scheduled into available slack instead.

---

## TASK TABLE

| ID | Task | Dur (days) | Predecessors | ES | EF | LS | LF | Slack | Critical? |
|----|------|:--:|------|:--:|:--:|:--:|:--:|:--:|:--:|
| T1 | ~~Dell Latitude 5430 arrives~~ | — | — | — | — | — | — | — | **COMPLETE 30-Jun-2026** |
| T2 | Win11 Pro initial setup + full Windows Update | 1 | — | 0 | 1 | 0 | 1 | 0 | **YES** |
| T3 | Run ascii22 on Dell (Pro), upload results, enable Hyper-V | 1 | T2 | 1 | 2 | 1 | 2 | 0 | **YES** |
| T4 | Build ascii23: Pro-specific fixes (Remote Desktop, BitLocker vs Device Encryption, GPO checks) | 3 | T3 | 2 | 5 | 2 | 5 | 0 | **YES** |
| T5 | Regression test ascii23 on all 3 machines (SANDY, IdeaPad, Dell) | 2 | T4 | 5 | 7 | 5 | 7 | 0 | **YES** |
| T6 | Pre-release checklist sign-off (per CodingStandards.md) | 1 | T5 | 7 | 8 | 7 | 8 | 0 | **YES** |
| T7 | Website Phase 1: format existing guide content → HTML (13 pages) | 3 | — | 0 | 3 | 3 | 6 | 3 | No |
| T8 | Screenshots — all 19 settings (must reflect FINAL UI) | 1 | T4 | 5 | 6 | 5 | 6 | 0 | No (ties critical, watch closely) |
| T9 | New/expanded content — settings #10,11,12,18,19 | 1 | T7 | 3 | 4 | 6 | 7 | 3 | No |
| T10 | Build download.html + index.html (home) | 1 | T7 | 3 | 4 | 6 | 7 | 3 | No |
| T11 | DNS/hosting setup (GitHub Pages) | 1 | — | 0 | 1 | 6 | 7 | 6 | No |
| T12 | Assemble + QA Website Phase 1 (all links, nav, mobile check) | 1 | T8, T9, T10, T11 | 6 | 7 | 7 | 8 | 1 | No |
| T13 | Beta tester program build (signup form, screening checklist) | 2 | T12 | 7 | 9 | — | — | — | **Off critical path — schedule in slack** |
| T14 | Final integration QA — tool ↔ website link checks, full end-to-end run | 1 | T6, T12 | 8 | 9 | 8 | 9 | 0 | **YES** |
| T15 | Launch prep — LLC bank account, domain transfer to LLC, final marketing review | 1 | T14 | 9 | 10 | 9 | 10 | 0 | **YES** |
| T16 | **LAUNCH** | 0 | T15 | 10 | 10 | 10 | 10 | 0 | **YES** |

---

## CRITICAL PATH

**T2 → T3 → T4 → T5 → T6 → T14 → T15 → T16**

Length: **10 working days** ≈ **14 calendar days** from 30-Jun-2026 → projects build/test completion around **~14-Jul-2026**.

Removing the Dell wait cut **5 working days** off the critical path. Float against the 01-Sep-2026 deadline is now roughly **~49 calendar days** — the schedule has substantial cushion. T8 (screenshots) now sits at zero slack on its own short branch, so don't let that one drift once ascii23 is final.

---

## SLACK ALLOCATION (how to use the ~49-day buffer)

| Use of slack | Recommendation |
|---|---|
| Beta Tester Program (T13) | Build during Days 7–9, soft-launch recruitment immediately after Phase 1 site goes live — gives ~7 weeks of beta data before 1-Sep |
| Website Phase 2 (compatible.html, beta.html, glossary.html) | Schedule Days 10–15 |
| Website Phase 3 (Firefox addendum, printable reference, changelog) | Schedule Days 15–20 |
| Press outreach (prerequisite for any named-competitor marketing per moratorium) | Begin Days 10+, run in parallel — has its own external timeline outside your control |
| Buffer for ascii23 → ascii24 if Pro testing surfaces unexpected issues | Absorbed entirely by existing float |
| Hardware registry update | Add Dell Latitude 5430 as Machine #3 to `GatewayGuard_ProjectNotes.md` tested hardware registry now that it's in hand — no need to wait for T2/T3 |

---

## RISK FLAGS

1. ~~Dell Latitude 5430 ETA~~ — **RESOLVED.** In hand as of 30-Jun-2026.
2. **T4 (3 days for Pro-specific ascii23 fixes) is still an estimate** — Remote Desktop, BitLocker-vs-Device-Encryption, and Group Policy verification are all untested territory per ProjectNotes.md "Future Features" section. Could run longer if Pro edition surfaces structural issues (similar to the MB/Defender detection rework between ascii19–21). With ~49 days of float, this has room to slip without threatening launch.
3. **T12 "QA all links"** assumes 44-page WebsitePrePlan scope is trimmed to Phase 1 MVP (4 page-types: guide hub + 19 setting pages + download + home) — if scope creeps to full 44 pages before launch, T7/T9/T10 durations are understated.
4. Annual Updates pricing (TBD per memory) has no task entry — it's a business decision, not a build dependency, but should be locked before T15 (launch prep) since it likely needs to appear in launch marketing materials.
5. **T2 (Pro initial setup) starts today if you want to hold the 14-Jul completion projection.** Every day this slips before starting pushes the whole critical path 1:1 — it just has a much bigger cushion to absorb it now.

---

*Generated 30-Jun-2026. Re-run this CPM whenever Dell Latitude ships, ascii23 scope is finalized, or website page count changes — those three inputs drive every downstream date.*
