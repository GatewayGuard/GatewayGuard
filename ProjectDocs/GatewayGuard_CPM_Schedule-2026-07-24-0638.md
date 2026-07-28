# **GATEWAYGUARD — CRITICAL PATH METHOD (CPM) SCHEDULE**

**File: **GatewayGuard_CPM_Schedule-2026-07-24-0638.md

**Revision 5 — 24-Jul-2026 (6:38 AM EDT)**

**Baseline date: **24-Jul-2026  |  **Target launch: **01-Sep-2026  |  **Calendar days remaining: **38  |  **Working days remaining: **27

**Current build: **ascii33 (built 2026-07-19, field-tested 2026-07-21 on HP SANDY)

## **WHAT CHANGED FROM REVISION 4 (15-Jul-2026)**

Revision 4 was written at ascii31 with 48 days to go. Since then:

**Completed: **ascii32 built+tested (Dell+HP+IdeaPad), ascii33 built+tested (HP SANDY). BitLocker on Dell confirmed encrypted. EULA Option B drafted and submitted to LegalZoom attorney (Call 1 scheduled Mon 7/27 10:30 AM). LegalZoom Business Attorney Plan enrolled ($199/yr) — replaces AirCounsel. Code signing: DigiCert OV via SignMyCode reseller — token assigned, validation pending. 7 guide pages built (windows-update, defender-realtime, tamper-protection, smartscreen, phishing-protection, firewall, bitlocker). index.html and 404.html live on GitHub Pages. guide/index.html built and ready to push. SANDY network confirmed dead (RTL8821CE hardware failure) — USB adapter ordered, arrives Sunday 7/26.

**Removed/corrected: **AirCounsel replaced by LegalZoom. Sectigo as primary cert issuer corrected: chain is SignMyCode (reseller) → DigiCert → Sectigo (issuing CA). SANDY BitLocker/Windows Home — ascii34 scope item D-20.

**New tasks added: **T-CR (copyright registrations), T-GW (guide pages remaining 12), T-DL (download.html), T-MK expanded (ACBL, BBO, forums), T-SA (SANDY repair/USB adapter), T-34 (ascii34 build).

## **ASSUMPTIONS**

• Working days = Mon–Fri. No holidays between now and Sep 1.

• ascii33 is field-tested and cleared. ascii34 is next build — scoping session needed first. Feature freeze after ascii34 unless blocking defect surfaces.

• DigiCert/Sectigo OV validation: token is assigned but validation pending. Estimated 3–7 working days from validation start. Token already in hand — no shipping wait.

• LegalZoom Call 1 (EULA) Monday 7/27. Subsequent legal calls spaced — one topic per call. Refund policy, Apps Audit liability, incident response are remaining open legal topics.

• Website guide pages: 7 built, 12 remaining. Each page takes roughly 1.5–2 hours with Claude. Build 2–3 per session.

• SANDY USB adapter arrives Sunday 7/26. Once online: Windows Update, MB update, ascii34 field test.

• Screenshots must match FINAL signed build UI — cannot take screenshots until signing is complete.

**• Windows Home / BitLocker: **SANDY runs Windows 11 Home which lacks BitLocker. D-20 in ascii34 scope — tool must detect Home edition and show appropriate guidance. This affects all Home edition users and must be resolved before launch.

## **TASK TABLE**

ES/EF/LS/LF in working days from today (Jul 24). ★ = on critical path.

| **ID** | **Task** | **Dur** | **Pred.** | **ES** | **EF** | **LS** | **LF** | **Slack / Critical** |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| INFRA | Code signing / cert |  |  |  |  |  |  |  |
| T-CS | DigiCert/Sectigo OV validation (token assigned, pending org validation) | 5 | — | 0 | 5 | 0 | 5 | **★ CRITICAL ** |
| T-TK | Token confirmed working — test sign on IdeaPad | 1 | T-CS | 5 | 6 | 5 | 6 | **★ CRITICAL ** |
| LEGAL | LegalZoom consultations |  |  |  |  |  |  |  |
| T-LR | EULA Call 1 (Mon 7/27) + incorporate attorney feedback | 2 | — | 1 | 3 | 1 | 3 | **★ CRITICAL ** |
| T-L2 | Refund policy Call 2 + incorporate | 2 | T-LR | 3 | 5 | 3 | 5 | **★ CRITICAL ** |
| T-L3 | Apps Audit liability Call 3 + incorporate | 2 | T-L2 | 5 | 7 | 5 | 7 | ★ CRITICAL (5) |
| T-L4 | Incident response Call 4 + plan | 2 | T-L3 | 7 | 9 | 7 | 9 | ★ CRITICAL (7) |
| T-CR | Copyright registrations: Tool + Guide + Website (LegalZoom, 1/mo incl.) | 2 | T-LR | 3 | 5 | 15 | 17 | ★ CRITICAL (12) |
| BUILD | PowerShell builds and testing |  |  |  |  |  |  |  |
| T-SA | SANDY USB adapter arrives + setup + Windows Update + MB update | 1 | — | 2 | 3 | 2 | 3 | **★ CRITICAL ** |
| T-34 | ascii34 build (D-20 Home edition BitLocker, FT-109 schtasks, FT-112 Ctrl+C, FT-113 footer, FT-114 HEADS UP, FT-116 step counter, FT-117 width) | 3 | T-SA | 3 | 6 | 3 | 6 | **★ CRITICAL ** |
| T-35 | ascii34 field test: Dell + SANDY + IdeaPad, upload logs, triage | 3 | T-34 | 6 | 9 | 6 | 9 | **★ CRITICAL ** |
| T-FX | Final defect fix build (ascii35 if needed — assume 1 round) | 2 | T-35 | 9 | 11 | 9 | 11 | **★ CRITICAL ** |
| T-SN | Sign release build with DigiCert/Sectigo token (.ps1 only — .bat unsigned) | 1 | T-TK, T-FX, T-L2 | 11 | 12 | 11 | 12 | **★ CRITICAL ** |
| T-SC | SmartScreen smoke test: download signed build, confirm no Unknown Publisher warning | 0.5 | T-SN | 12 | 12.5 | 12 | 12.5 | **★ CRITICAL ** |
| WEBSITE | HTML pages |  |  |  |  |  |  |  |
| T-GI | Push guide/index.html (built, validated, ready) | 0.5 | — | 0 | 0.5 | 0 | 0.5 | **★ CRITICAL ** |
| T-GW | Remaining 12 guide setting pages (periodic-scanning, windows-hello, remote-desktop, advertising-id, diagnostic-data, edge-startup, widgets, password-manager, memory-integrity, password-on-wake, fast-startup, wake-on-lan) | 8 | T-GI | 0.5 | 8.5 | 0.5 | 8.5 | **★ CRITICAL ** |
| T-DL | download.html (Gumroad link, SHA-256 hash placeholder, system requirements) | 1 | T-GW | 8.5 | 9.5 | 8.5 | 9.5 | **★ CRITICAL ** |
| T-W3 | Screenshots — all 19 settings (must match FINAL signed build UI) | 1 | T-SN | 12 | 13 | 12 | 13 | **★ CRITICAL ** |
| T-W4 | QA full site: links, nav, download file, hash, mobile check | 1 | T-DL, T-W3 | 13 | 14 | 13 | 14 | **★ CRITICAL ** |
| T-W5 | Publish SHA-256 hash of signed build on download page | 0.5 | T-W4 | 14 | 14.5 | 14 | 14.5 | **★ CRITICAL ** |
| LAUNCH | Final prep and go-live |  |  |  |  |  |  |  |
| T-QA | Final integration QA: tool ↔ website links, end-to-end run on all 3 machines | 1 | T-SC, T-W5 | 14.5 | 15.5 | 14.5 | 15.5 | **★ CRITICAL ** |
| T-MK | Marketing copy sweep + ACBL pitch ready + BBO/forum posts drafted | 2 | T-LR | 3 | 5 | 13.5 | 15.5 | ★ CRITICAL (10.5) |
| T-PF | Old project files cleanup (retire superseded docs from project knowledge) | 0.5 | — | 0 | 0.5 | 20 | 20.5 | ★ CRITICAL (20) |
| T-LP | Launch prep: pricing locked, Gumroad listing live, EULA posted, final checklist | 1 | T-QA, T-MK | 15.5 | 16.5 | 15.5 | 16.5 | **★ CRITICAL ** |
| T-GO | LAUNCH — September 1, 2026 | 0 | T-LP | 16.5 | 16.5 | 16.5 | 16.5 | **★ CRITICAL ** |

## **CRITICAL PATH**

**Chain 1 (cert): **T-CS → T-TK → T-SN

**Chain 2 (build): **T-SA → T-34 → T-35 → T-FX → T-SN

**Chain 3 (legal): **T-LR → T-L2 → T-SN

**Chain 4 (website): **T-GI → T-GW → T-DL → [T-W3] → T-W4 → T-W5

All four chains converge at T-SN (signing) or T-W4 (site QA). Both must complete before T-QA → T-LP → T-GO.

**Critical path length: ~16.5 working days ≈ 24 calendar days**  |  From July 24 → critical path completes ~August 18  |  Buffer to September 1: ~14 calendar days.

## **FLOAT ANALYSIS**

|  |  |  |
| --- | --- | --- |
| T-MK (marketing copy) | 10.5 wd | Can start after T-LR (EULA feedback). ACBL pitch, BBO post, forum drafts. Plenty of float — but don't ignore. |
| T-CR (copyright reg) | 12 wd | Use LegalZoom dashboard. Do Tool first (Month 1), Guide second (Month 2). No attorney call needed. |
| T-L3 (Apps Audit liability) | 5 wd | Call 3 after refund policy settled. Not a launch blocker but should be done. |
| T-L4 (incident response) | 7 wd | Call 4. Results in a written incident response plan. Post-launch is acceptable if needed. |
| T-PF (old file cleanup) | 20 wd | Low priority — any time before launch. |
| T-GW (guide pages) | 0 wd | ★ CRITICAL — 12 pages needed, ~8 working days. Must start immediately in parallel with builds. |

## **RISK FLAGS**

|  |  |  |  |
| --- | --- | --- | --- |
| DigiCert/Sectigo validation stalls | Medium | HIGH — blocks signing and launch | Token is assigned — validation is the remaining step. Follow up with SignMyCode if no movement by Monday 7/28. |
| ascii34 surfaces blocking defect | Medium | Medium — adds 1–3 working days | T-FX has 2-day allocation. 14-day buffer absorbs 1 extra round. |
| Guide pages take longer than 8 days | Medium | HIGH — 0 float on this task | Start today. Build 2–3 pages per session with Claude. Do not wait for builds to stabilize. |
| SANDY USB adapter delayed past Sunday | Low | Low — IdeaPad covers ascii34 testing | Lenovo IdeaPad is healthy and available as backup test machine. |
| Windows Home / BitLocker (D-20) | Certain — SANDY is Home edition | HIGH — affects all Home users | Must be in ascii34 scope. Tool must detect Home edition and show alternative guidance (Device Encryption or upgrade path). |
| LegalZoom attorney unavailable Mon 7/27 | Low | Low — reschedule same week | Call 1 is EULA review. If rescheduled, T-LR shifts 1–2 days. Still within buffer. |
| SmartScreen reputation (OV cert) | Low | Low — expected, not a defect | OV removes Unknown Publisher immediately. Reputation builds with installs over time. |
| Annual Updates pricing still undecided | Medium | Low for launch — soft-launch without | Must decide before T-LP. $12.99 single update is working number. |

## **IMMEDIATE NEXT ACTIONS (Week of July 24)**

|  |  |  |  |
| --- | --- | --- | --- |
| 1 | Push guide/index.html to GitHub (built and validated — ready now) | Bill | T-GW start |
| 2 | Begin remaining 12 guide setting pages (2–3 per session) | Bill + Claude | T-GW (critical path, 0 float) |
| 3 | Follow up with SignMyCode on DigiCert/Sectigo validation status | Bill | T-CS → T-TK → T-SN (critical path) |
| 4 | Confirm ascii34 scope — scoping session with Claude | Bill + Claude | T-34 build |
| 5 | Plug in USB adapter Sunday, get SANDY online, run Windows Update + MB update | Bill | T-SA → T-34 field test |
| 6 | LegalZoom Call 1 — EULA review (Mon 7/27 10:30 AM) | Bill | T-LR → T-L2 → T-SN |
| 7 | Schedule LegalZoom Call 2 (refund policy) after Call 1 feedback received | Bill | T-L2 |
| 8 | Copyright registration: Tool (Month 1) via LegalZoom dashboard | Bill | IP protection before launch |
| 9 | ACBL pitch — finalize draft for upcoming meetings | Bill + Claude | T-MK (10.5 wd float — not urgent but don't ignore) |

## **OPEN DECISIONS (must resolve before launch)**

|  |  |  |
| --- | --- | --- |
| 1 | Annual Updates pricing | $12.99/update is working number. Must lock before T-LP. Blocks marketing copy. |
| 2 | Refund policy | LegalZoom Call 2. Maine law + Gumroad platform requirements. Blocks EULA Section 8 and Gumroad listing. |
| 3 | Windows Home BitLocker / D-20 | SANDY confirmed Windows 11 Home — no BitLocker. Tool must detect and handle. ascii34 scope. |
| 4 | Incident response plan | LegalZoom Call 4. What happens if a shipped build harms a user's system. Written plan needed. |
| 5 | Analytics | Plausible, Fathom, or none. No Google Analytics. Low priority — can decide post-launch. |
| 6 | Microsoft Store registration | $19 one-time fee. Not a launch dependency. Decide after launch. |
| 7 | ACBL / BBO / forum marketing launch timing | Drafts exist. When do we start outreach — before or after September 1? |
| 8 | Copyright registrations timeline | Tool: register before launch. Guide: register before launch. Website: register after finalized. Use LegalZoom 1/month benefit. |

## **DECISIONS LOGGED THIS REVISION**

**DECISION (24-Jul-2026): **Legal vendor changed from AirCounsel to LegalZoom Business Attorney Plan ($199/yr). Unlimited 30-min consultations on new topics + document review under 10 pages included. Enrolled 2026-07-24.

**DECISION (24-Jul-2026): **EULA Option B (source-available) draft complete. Submitted to LegalZoom for Call 1 review Mon 7/27 10:30 AM. 8 specific questions flagged for attorney.

**DECISION (24-Jul-2026): **Code signing chain corrected: SignMyCode (reseller) → DigiCert (ordered from) → Sectigo (issuing CA). Certificate will show Sectigo as issuer.

**DECISION (24-Jul-2026): **SANDY network confirmed dead — RTL8821CE adapter hardware failure. Fix: TP-Link Archer T2U Nano USB adapter (~$10, arrives Sun 7/26). Internal card disabled after USB adapter confirmed working.

**DECISION (24-Jul-2026): **Copyright registrations added to plan. Use LegalZoom 1/month included benefit. Tool (Month 1), Guide (Month 2), Website (after finalized).

**DECISION (18-Jul-2026): **Website standards finalized. HTML delivery gate (H-1, H-2, H-3) mandatory for all HTML files.

**DECISION (21-Jul-2026): **index.html and 404.html live on GitHub Pages. guide/index.html built and validated — ready to push. 7 guide setting pages built.

**Revision history: **Rev 1 (pre-Dell), Rev 2 (Dell ETA), Rev 3 (30-Jun, Dell on-hand, ascii22), Rev 4 (15-Jul, ascii31, 48 days), Rev 5 (24-Jul, ascii33, 38 days).