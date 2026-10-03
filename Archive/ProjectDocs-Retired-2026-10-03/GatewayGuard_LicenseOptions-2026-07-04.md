<!-- Dated: 2026-07-04 -->

# GatewayGuard License Options — Side-by-Side Drafts

**Purpose:** Compare Option C (fully closed / proprietary EULA) against Option B (source-available license) from ProjectNotes, so a deliberate decision can be made before T15 (launch prep).

**Status:** DRAFT — both versions require review by a Maine-licensed attorney before launch. Neither is legal advice.

---

## Decision Summary

| Factor | Option C — Proprietary EULA | Option B — Source-Available License |
|---|---|---|
| Can customers read the code? | No (only the running tool) | Yes — full source visible |
| Can anyone copy/redistribute it? | No | No |
| Can anyone modify or resell it? | No | No |
| Supports "Fear 2: Is it malware?" answer | Partially — relies on code signing + SHA-256 + LLC identity | Fully — "open the file in Notepad and read every line" stays true |
| Marketing copy impact | Flyer/website claims of source visibility must be rewritten | Existing "verifiable / readable source" positioning stays intact (change "open source" wording to "source-available") |
| Protection against theft | Legal (copyright + EULA) | Legal (copyright + license) — identical enforcement strength |
| Practical piracy risk | Same either way — a .ps1 ships as plain text regardless; the license is what makes copying illegal | Same |
| Fit with current PowerShell delivery | Awkward — the .ps1 IS the source; "closed" is only a legal statement, not a technical one | Natural — makes a virtue of what PowerShell already is |

**Working recommendation (from ProjectNotes, unchanged):** Option B or C. Given PowerShell delivery, Option B costs nothing technically and preserves the strongest trust argument a solo unknown vendor has. Option C only becomes technically meaningful if/when a Phase 2 compiled rewrite (C#/Go) happens.

**Terminology note:** "GPL-3.0" was considered and rejected 2026-07-04 — GPL is an open-source license that *requires* source disclosure and *permits* free redistribution, the opposite of the protection goal.

---

## DRAFT A — Proprietary EULA (Option C)

*Plain-English test applied throughout. Attorney review required.*

### GatewayGuard End User License Agreement

**Dated: 2026-07-04 (draft)**

This is an agreement between you and GatewayGuard LLC, a Maine limited liability company ("we" / "us"). By downloading, installing, or running GatewayGuard, you agree to these terms.

**1. What you're buying.**
You are buying a license to use GatewayGuard — not the software itself. GatewayGuard LLC owns the software, including all code, text, and design. Your license lets you install and run GatewayGuard on **one (1) personal computer** that you own or control.

**2. What you may do.**
- Install and run GatewayGuard on one PC.
- Make one backup copy of the download for your own safekeeping.
- Re-run the tool as often as you like on that same PC.

**3. What you may not do.**
- Share, sell, rent, lend, or give copies of GatewayGuard to anyone else.
- Post GatewayGuard on any website, file-sharing service, or forum.
- Modify the software or remove our name or copyright notices from it.
- Use GatewayGuard on business, school, or government computers without a separate agreement from us.
- Reverse engineer the software, except where the law says we can't stop you.

**4. Updates.**
This license covers the version you purchased. Update terms and pricing are described on gatewayguard.co at the time of purchase. [PLACEHOLDER — finalize once Annual Updates pricing is locked, per EnvironmentHardening open question #8.]

**5. Refunds.**
[PLACEHOLDER — refund window and conditions TBD before T15.]

**6. What GatewayGuard does — and what it doesn't promise.**
GatewayGuard reviews and adjusts Windows 11 security settings, with your approval at each step, and every change is reversible. No security tool can guarantee your computer will never have a problem. We provide GatewayGuard "as is." To the fullest extent Maine law allows, we are not liable for indirect or consequential damages, and our total liability is limited to the amount you paid for the license.

**7. Privacy.**
GatewayGuard collects no data and makes no network connections from your PC. Nothing about you or your computer is sent to us or anyone else.

**8. Ending this license.**
If you break these terms, the license ends and you must delete all copies. You can end it yourself at any time by deleting the software.

**9. Governing law.**
This agreement is governed by the laws of the State of Maine.

**Questions?** Contact GatewayGuard LLC via gatewayguard.co.

---

## DRAFT B — Source-Available License (Option B)

*Same commercial terms; adds a read-only source grant. Attorney review required.*

### GatewayGuard Source-Available License

**Dated: 2026-07-04 (draft)**

This is an agreement between you and GatewayGuard LLC, a Maine limited liability company ("we" / "us"). By downloading, installing, or running GatewayGuard, you agree to these terms.

**1. What you're buying.**
You are buying a license to use GatewayGuard — not the software itself. GatewayGuard LLC owns the software. Your license lets you install and run GatewayGuard on **one (1) personal computer** that you own or control.

**2. You can read every line.**
GatewayGuard ships as readable PowerShell. We *want* you to open it and see exactly what it does — that's part of how you know you can trust it. You may read, inspect, and study the code freely.

**3. What you may do.**
- Install and run GatewayGuard on one PC.
- Open and read the source code in any editor.
- Make one backup copy of the download for your own safekeeping.
- Quote short portions of the code when writing reviews or asking for help, with attribution.

**4. What you may not do.**
- Share, sell, rent, lend, or give copies of GatewayGuard to anyone else.
- Post the software or its source code on any website, repository, file-sharing service, or forum.
- Create modified versions and distribute them, or reuse our code in another product.
- Remove our name, copyright notices, or the code-signing signature.
- Use GatewayGuard on business, school, or government computers without a separate agreement from us.

**Plain-English summary of the difference:** *You may look. You may not take.*

**Sections 5–10:** Identical to Draft A sections 4–9 (Updates, Refunds, No-guarantee/liability, Privacy, Termination, Maine governing law).

---

## Open Items Before This Is Final

1. **Attorney review** — Maine attorney, both drafts; budget ~$500–1,000. Schedule before T15.
2. **Refund policy** — decide window/conditions (Section 5 placeholder).
3. **Annual Updates pricing** — must be locked before the Updates clause is finalized (existing open question #8).
4. **Marketing copy sweep if Option C chosen** — remove/rewrite "source code visible" and "Open source. Verifiable." claims in ProjectNotes marketing copy, flyer, and website spec. If Option B chosen, change "open source" wording to "source-available" everywhere (accuracy: it is not open source under the standard definition).
5. **Decision entry for ProjectNotes** — log the chosen option with date once decided.
