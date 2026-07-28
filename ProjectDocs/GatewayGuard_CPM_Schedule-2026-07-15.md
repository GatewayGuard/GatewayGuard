<!-- Dated: 2026-07-15 05:55 ET -->
# GatewayGuard — Critical Path Method (CPM) Schedule
**File:** GatewayGuard_CPM_Schedule-2026-07-15.md
**Revision 4 — 15-Jul-2026**
**Baseline date:** 15-Jul-2026 (today) | **Target launch:** 01-Sep-2026
**Calendar days remaining:** 48 | **Working days remaining:** 34
**Current build:** ascii31 (built 14-Jul-2026, not yet tested on HP/IdeaPad)

---

## WHAT CHANGED FROM REVISION 3 (30-Jun-2026)

Revision 3 was written at ascii22 with 63 days to go. The build/test
cycle consumed the float that was originally reserved for early completion.
The schedule is rebuilt from actual current state:

- **Completed since Rev 3:** T1 (Dell), T2 (Win11 Pro setup), T3 (ascii22
  on Dell), ascii23 through ascii31 (12 builds), Round 5 field testing
  (FT-38 through FT-71), Defect Prevention Playbook, pre-build audit gate,
  project instruction updates, Sectigo OV cert ordered (15-Jul-2026),
  admin@gatewayguard.co email forwarding setup, AirCounsel engaged for
  license review.
- **New tasks added:** T-CS (code signing), T-EM (email setup), T-LR
  (license review), T-BL (BitLocker on Dell), T-HP (HP/IdeaPad testing).
- **Critical path revised:** build stabilization is now the gating item,
  not the original ascii22→23 path.

---

## ASSUMPTIONS

- Working days = Mon–Fri. No holidays between now and Sep 1.
- ascii31 is the last bug-fix-only build. ascii32 adds Mark mode
  reminders + Playbook update (small, low-risk). Feature freeze after
  ascii32 unless a blocking defect surfaces.
- Website is a true zero-start — no HTML written yet.
- Sectigo OV validation: estimated 3–7 working days for a new LLC
  (optimistic 3, conservative 7). Physical token ships after validation
  and arrives in 2–3 days. Total door-to-door: 5–10 working days.
- AirCounsel license review: estimated 2–3 working days at the
  "Review of Contract or Legal Document" tier ($250 flat fee).
- License document must be in final draft before submitting to AirCounsel
  — one Claude session needed to finalize the Option B text first.
- Zoho Mail free tier: 1–2 hours to configure, DNS propagation up to
  24 hours. Non-blocking (can run in parallel with anything).
- Website guide pages are a hard launch dependency — the tool links
  directly to gatewayguard.co/guide.
- HP SANDY and IdeaPad must be tested on the final release build
  before launch — not currently tested on ascii31.
- Annual Updates pricing: still open. Must be decided before T-LP
  (launch prep) as it appears in marketing materials.

---

## TASK TABLE

| ID | Task | Dur (wd) | Predecessors | ES | EF | LS | LF | Slack | Critical? |
|----|------|:--------:|--------------|:--:|:--:|:--:|:--:|:-----:|:---------:|
| **INFRA** |
| T-EM | Email setup: Zoho Mail, admin@ + support@ + info@ | 0.5 | — | 0 | 0.5 | 0 | 0.5 | 0 | **YES** |
| T-CS | Sectigo OV cert: order placed 15-Jul → validation → token ships | 7 | T-EM | 0 | 7 | 0 | 7 | 0 | **YES** |
| T-TK | Token arrives + SafeNet setup + test sign on IdeaPad | 2 | T-CS | 7 | 9 | 7 | 9 | 0 | **YES** |
| **LEGAL** |
| T-LD | Finalize Option B license draft (Claude session) | 1 | — | 0 | 1 | 1 | 2 | 1 | No |
| T-LR | AirCounsel review + incorporate feedback | 3 | T-LD | 1 | 4 | 2 | 5 | 1 | No |
| **BUILD / TEST** |
| T-32 | Build + test ascii32 (Mark reminders, Playbook update, USER-FACING CLARITY) | 1 | — | 0 | 1 | 0 | 1 | 0 | **YES** |
| T-BL | BitLocker encryption on Dell (overnight run, recovery key saved) | 1 | T-32 | 1 | 2 | 1 | 2 | 0 | **YES** |
| T-HP | Test ascii32 on HP SANDY + IdeaPad, upload logs, triage | 2 | T-32 | 1 | 3 | 1 | 3 | 0 | **YES** |
| T-FX | Final defect fix build (ascii33 if needed — assume 1 round) | 2 | T-HP | 3 | 5 | 3 | 5 | 0 | **YES** |
| T-SN | Sign release build with Sectigo token (.ps1 + .bat) | 1 | T-TK, T-FX, T-LR | 9 | 10 | 9 | 10 | 0 | **YES** |
| T-SC | SmartScreen smoke test: download signed build, confirm no Unknown Publisher | 0.5 | T-SN | 10 | 10.5 | 10 | 10.5 | 0 | **YES** |
| **WEBSITE** |
| T-W1 | Guide pages HTML (13 pages — launch dependency, tool links here) | 5 | — | 0 | 5 | 3 | 8 | 3 | No |
| T-W2 | download.html + index.html (home) | 2 | T-W1 | 5 | 7 | 8 | 10 | 3 | No |
| T-W3 | Screenshots — all settings (must match FINAL signed build UI) | 1 | T-SN | 10 | 11 | 10 | 11 | 0 | **YES** |
| T-W4 | Assemble + QA full site (links, nav, download file, hash) | 1 | T-W2, T-W3 | 11 | 12 | 11 | 12 | 0 | **YES** |
| T-W5 | Publish SHA-256 hash of signed release build on download page | 0.5 | T-W4 | 12 | 12.5 | 12 | 12.5 | 0 | **YES** |
| **LAUNCH PREP** |
| T-QA | Final integration QA: tool ↔ website links, end-to-end run | 1 | T-SC, T-W5 | 12.5 | 13.5 | 12.5 | 13.5 | 0 | **YES** |
| T-MK | Marketing copy sweep (license-dependent) | 1 | T-LR | 4 | 5 | 12.5 | 13.5 | 8.5 | No |
| T-LP | Launch prep: pricing locked, Gumroad listing live, final checklist | 1 | T-QA, T-MK | 13.5 | 14.5 | 13.5 | 14.5 | 0 | **YES** |
| T-16 | **LAUNCH** | 0 | T-LP | 14.5 | 14.5 | 14.5 | 14.5 | 0 | **YES** |

---

## CRITICAL PATH

**T-EM → T-CS → T-TK → T-SN → T-SC → T-W3 → T-W4 → T-W5 → T-QA → T-LP → T-16**

**AND in parallel:**

**T-32 → T-BL / T-HP → T-FX → T-SN**

Both chains converge at T-SN (signing). The signing step cannot happen
until BOTH the cert token is in hand AND the final build is stable.

**Critical path length: ~14.5 working days ≈ 21 calendar days**
From July 15 → critical path completes ~August 5.
Buffer to September 1: **~27 calendar days.**

---

## FLOAT ANALYSIS

| Task | Float | Notes |
|---|---|---|
| T-LD / T-LR (license) | 1 day | Tight — don't let this drift; submit to AirCounsel by end of week 1 |
| T-W1 (guide pages) | 3 days | Start immediately in parallel — 5 working days of writing |
| T-W2 (download + home) | 3 days | Follows guide pages |
| T-MK (marketing copy) | 8.5 days | Can be done any time after license review |
| T-13 (beta program) | Off critical path | Build in slack after T-W4 |

---

## RISK FLAGS

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Sectigo validation stalls (new LLC, unverified phone) | Medium | High — blocks signing and launch | DUNS number application started in parallel; attorney letter from AirCounsel as backup documentation |
| ascii32/33 surfaces a blocking defect | Medium | Medium — adds 1–3 working days | T-FX has 2-day allocation; 27-day buffer absorbs 1 extra round |
| Website guide pages take longer than 5 days | Medium | Low — 3 days of float | Start today; don't wait for build to stabilize |
| Annual Updates pricing still undecided | High | Low for launch — can soft-launch without it | Must decide before T-LP |
| Fable 5 access ends July 19 | Certain | Low-Medium — Opus 4.6 is the fallback | Run ascii32 build before July 19 if possible; test Opus 4.6 on a build before relying on it |
| SmartScreen reputation (OV cert) | Low | Low — expected, not a defect | OV removes "Unknown Publisher" immediately; SmartScreen quiet builds with installs over time |

---

## IMMEDIATE NEXT ACTIONS (today, July 15)

| Priority | Action | Owner | Blocks |
|---|---|---|---|
| 1 | Set up admin@gatewayguard.co forwarding in Namecheap | Bill | T-CS |
| 2 | Complete Sectigo OV cert order | Bill | T-CS (critical path) |
| 3 | Start Zoho Mail setup for support@ | Bill | Customer support at launch |
| 4 | Build ascii32 (Mark reminders + Playbook + USER-FACING CLARITY) | Claude (Opus/Fable) | T-BL, T-HP |
| 5 | Start website guide pages (zero-start, 5 working days needed) | Bill + Claude | T-W1 |
| 6 | Schedule license draft session with Claude | Bill | T-LD → T-LR |

---

## OPEN DECISIONS (must resolve before launch)

1. **Annual Updates pricing** — TBD; blocks T-LP and marketing copy
2. **MB Tamper Protection** — found OFF on Dell; check HP and IdeaPad
3. **Incident response plan** — what happens if a shipped build harms a user's system
4. **Analytics** — Plausible, Fathom, or none (no Google Analytics)
5. **Microsoft Store registration** — $19 one-time fee; not on critical path for Sep 1 but worth deciding

---

## DECISIONS LOGGED THIS REVISION

- **DECISION (15-Jul-2026):** Code signing vendor confirmed: Sectigo OV
  Code Signing Certificate, 1-year term, USB token delivery. Ordered
  direct from sectigo.com. $715/year. Admin email: admin@gatewayguard.co.
- **DECISION (15-Jul-2026):** Legal review vendor confirmed: AirCounsel
  (aircounsel.com), flat-fee "Review of Contract or Legal Document,"
  from $250. License document must be in final draft before submission.
- **DECISION (15-Jul-2026):** Email infrastructure: Namecheap forwarding
  for admin@ (immediate, for Sectigo order), Zoho Mail free tier for
  send/receive on support@, info@, admin@.
- **DECISION (14-Jul-2026):** Defect Prevention Playbook adopted.
  Appendix A pre-build audit is mandatory gate for all ascii builds.
  FT-53 closed — satisfied by the Playbook.
- **DECISION (14-Jul-2026):** USER-FACING CLARITY rule adopted in project
  instructions and profile instructions. Every key/action shown to user
  must state exactly what it does and what happens if not taken.
- **DECISION (confirmed):** License Option B — source-visible, no
  redistribution. Never described as open source. Use "source-visible"
  or "fully auditable."

---

*Revision history: Rev 1 (pre-Dell), Rev 2 (Dell ETA), Rev 3 (30-Jun,
Dell on-hand, ascii22), Rev 4 (15-Jul, ascii31, 48 days to launch).*
