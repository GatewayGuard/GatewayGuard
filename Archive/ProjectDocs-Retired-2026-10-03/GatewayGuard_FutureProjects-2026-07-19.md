<!-- Dated: 2026-07-19 05:55 EDT -->
# GatewayGuard — Future Projects Notes
**File:** GatewayGuard_FutureProjects-2026-07-19.md
**Started:** 2026-07-19

This file captures post-launch product ideas, roadmap items, and future
project concepts sourced from ProjectNotes, marketing files, research,
and field observations. Items here are NOT in launch scope unless
explicitly promoted. Review and prioritize after September 1, 2026 launch.

---

## PRODUCT EXPANSIONS

### FP-01 — PC Cleanup & Speed Tool (NEW — 2026-07-19)
**Source:** Market research (July 2026) — most-requested unmet need for
non-technical home users
**Concept:** A companion tool (separate from GatewayGuard) focused on
PC performance: startup program management, removal of junk/temp files,
basic storage cleanup, and plain-English explanations of what each step
does and why. Same interaction model as GatewayGuard — guided, reversible,
user-approved.
**Why it fits:** Slow PC is the #1 pain point for non-technical home users.
73% of U.S. adults have experienced a scam or attack; many are also dealing
with sluggish machines. Same audience, same trust model, natural upsell or bundle.
**Notes:** This is a separate product, not a GatewayGuard feature — keep
security hardening and performance cleanup as distinct tools.
**Priority:** High. Broadens market without diluting security message.

---

### FP-02 — Windows 11 Home Optimization Guide (digital product)
**Source:** ProjectNotes Item 6 (Optimization Guides)
**Concept:** Downloadable guide (PDF or HTML) for performance tweaks,
privacy settings beyond GatewayGuard, storage cleanup, startup optimization,
and memory management on Windows 11 Home.
**Suggested price:** $9.99 one-time + $4.99/year updates
**Notes:** Plan after Windows 11 26H2 release. Email all buyers when
annual update is available.

---

### FP-03 — Windows 11 Pro Optimization Guide (digital product)
**Source:** ProjectNotes Item 6 (Optimization Guides)
**Concept:** Everything in the Home guide plus Group Policy settings,
Hyper-V setup, BitLocker advanced configuration, Windows Sandbox,
Remote Desktop secure setup, and domain vs. workgroup considerations.
**Suggested price:** $14.99 one-time + $6.99/year updates
**Notes:** Bundle discount with GatewayGuard TBD. Plan after Sep 2026.

---

### FP-04 — Browser Extension Audit Feature (in-tool)
**Source:** ProjectNotes (browser extension audit, planned future feature)
**Concept:** Detect known risky extensions (financial, remote access,
redundant AV), explain the risk in plain English, offer removal with
explicit user approval. Same interaction pattern as the existing Apps Audit.
**Notes:** Edge and Chrome guides flagged as needing thorough review before
building — complex settings with non-obvious interactions. Edge "Save and
fill payment info" has a known non-obvious behavior (must re-enable to
delete saved cards, then disable again). Flag for careful research before
coding.

---

### FP-05 — Assisted Sessions (paid human support tier)
**Source:** ProjectNotes, PresentationCompanionSheet, MarketingNotes
**Concept:** A real person (Bill or future staff) helping users over
screen share — scheduled, paid support sessions. Differentiator: no
competitor offers this.
**Status:** ROADMAP ITEM — explicitly NOT a launch feature. Must never
be described as currently available in any marketing or user-facing copy.
**Notes:** Beats automated tools on trust. Strong differentiator for
seniors and non-technical users. Plan pricing and scheduling model
post-launch once user base exists.

---

### FP-06 — Annual Updates Subscription
**Source:** Business model, CPM Schedule, PresentationCompanionSheet
**Concept:** $12.99/year recurring subscription that delivers updated
GatewayGuard builds as Windows 11 changes. Locks in recurring revenue.
**Status:** Pricing locked in marketing materials; delivery mechanism
(how buyers receive updates) not yet designed. Must be decided before launch.

---

### FP-07 — Family 3-Pack Licensing
**Source:** Business model, PresentationCompanionSheet
**Concept:** Single purchase covers 3 PCs in the same household. $34.99
one-time. Targets parents buying for themselves plus aging parents or kids.
**Status:** In current marketing materials. License enforcement mechanism
not yet designed. Must be decided before launch.

---

## SETTINGS & SECURITY FEATURES (future tool builds)

### FP-08 — Additional Security Settings (medium priority)
**Source:** ProjectNotes "Settings to Add in Future Builds"
Settings flagged for future builds after launch:
- Disable Windows Recall / AI features (privacy)
- ELAM set to Good Only (Early Launch Antimalware)
- ASR rules (19 Defender-specific rules — requires Defender as primary AV)
- WPAD disable (Web Proxy Auto-Discovery — MITM attack vector)
- Full Microsoft Security Baseline v25H2 alignment
- Audit policy configuration (23 policies)
- Security template settings (67 settings)

---

### FP-09 — Multilingual Support
**Source:** ProjectNotes (global market section)
**Concept:** Tool currently English-only. Phase roadmap:
- Phase 1 (now): English only — US/UK/Canada/Australia
- Phase 2 (after 100+ users): Add Spanish and German
- Phase 3 (after revenue): Add Mandarin Chinese and Japanese
- Phase 4 (mature product): Full auto-detection of Windows UI language
  via `(Get-Culture).Name`
**Notes:** Claude can translate tool text and conduct beta support sessions
in other languages — scales without hiring multilingual staff.

---

## MARKETING & OUTREACH

### FP-10 — Press and Media Outreach Strategy
**Source:** ProjectNotes Item 7
**Concept:** Tiered outreach to tech press after launch with a working
polished product. Do NOT approach press before product is stable.
Tier 1: NYT, Washington Post, Forbes, Time, WSJ
Tier 2: PCMag, Ars Technica, The Verge, ZDNet, TechRadar, BleepingComputer, Wired
Tier 3: YouTube Windows 11 security channels, Security Now podcast,
Darknet Diaries, The CyberWire
**Rule:** Working product first. No press before ready.

---

### FP-11 — ACB / BBO Marketing Channel
**Source:** ProjectNotes Item 12
**Concept:** Target the American Contract Bridge League (200,000+ members)
and Bridge Base Online (millions of users). Bridge players skew 50s-70s —
exact demographic most vulnerable to cybercrime and least likely to have
hardened their PCs. Bill is an ACB member — warm introduction possible.
**Pitch:** "GatewayGuard protects the Windows 11 PCs your members use
to play bridge online."

---

### FP-12 — Reddit / Forum Presence
**Source:** ProjectNotes (grassroots marketing)
**Concept:** Build reputation on r/Windows11, r/privacy, and similar
communities before launch. Lead with free education, not product pitches.
Start now — don't arrive at launch as a stranger.
**Key post idea:** "5 Windows 11 Settings That Stop Ransomware" — free
hook content, can run on Reddit and the website.

---

### FP-13 — Email Capture / List Building
**Source:** ProjectNotes (grassroots marketing)
**Concept:** Offer a free guide PDF download in exchange for email.
Builds the list that becomes annual update customers.
**Notes:** Must be GDPR-compliant if capturing European email addresses.
Maine privacy law (MPPA) — collecting zero data is the current model;
any email capture is a new data practice that needs privacy policy update.

---

### FP-14 — Library / Community Workshop Program
**Source:** MarketingNotes, LocalCommunityWorkshopPlan.pdf
**Concept:** Free "Taking Control of Your Digital Privacy" presentations
at local public libraries and community associations. Distribute printed
one-page flyers with QR code linking to gatewayguard.co.
**Notes:** Live Windows 11 demo beats slides. Use analog analogies
(Windows Updates = oil change; Core Isolation = deadbolt on utility closet).
Avoid fear tactics — lead with empowerment and peace of mind.

---

### FP-15 — "Family IT Maven" Targeted Messaging
**Source:** Marketing-Notes.docx
**Concept:** Every family has one person who gets called when a laptop
breaks. Target them explicitly: "Tired of cleaning malware off your
parents' PCs? Run GatewayGuard next time you set up their machine."
One Maven deploys across 5-10 PCs in their circle.

---

### FP-16 — SEO Content Strategy
**Source:** ProjectNotes (grassroots marketing)
**Concept:** Build SEO target keyword list. Assign one page per keyword.
Website Phase 1 should include 3-5 target pages.
**Notes:** Not yet started. Post-launch priority.

---

## WEBSITE PAGES (future)

### FP-17 — tips.html ("Helpful Windows 11 Tips")
**Source:** ProjectNotes (website plan, Item 10)
**Concept:** Phase 3 website page at gatewayguard.co/tips. Plain-language
tips in numbered list format. Each tip: problem (bold) + cause + what to do.
Free — no download required. Updated periodically.
**First tip:** Streaming audio capture on Windows 11
**Format:** Simple numbered list, problem-first structure, plain English.

---

### FP-18 — Beta Program Page (beta.html)
**Source:** WebsitePrePlan, CPM Schedule
**Concept:** Signup form and screening checklist for beta testers.
Not a launch dependency — can go live during or after Phase 2.

---

## LEGAL & BUSINESS

### FP-19 — Incident Response Plan
**Source:** GatewayGuard_EnvironmentHardening.md
**Concept:** What happens if a build is found to contain a bug that harms
a user's system? Need a defined process before public launch or shortly after.
**Notes:** Define: user communication protocol, build pull procedure,
patch timeline, and compensation/refund policy.

---

### FP-20 — Terms of Service / Disclaimer Page
**Source:** ProjectNotes (apps audit liability section)
**Concept:** gatewayguard.co/terms needs a software recommendation
disclaimer. Add to Maine LLC operating agreement as well.
GatewayGuard never auto-removes anything — user must explicitly approve.
Removal warnings must be clear ("this cannot be undone easily").
**Notes:** Research similar tools' disclaimer language (NoID, Hardentools).
Consult Maine attorney before paid launch if not already covered by AirCounsel review.

---

### FP-21 — Annual Updates Pricing (open item)
**Source:** CPM Schedule, EnvironmentHardening.md
**Status:** Price point ($12.99/year) is in marketing materials but
delivery mechanism is undefined. Must be locked before T-LP (launch prep).

---

*End of file. Add new items as FP-NN in the appropriate section.*
