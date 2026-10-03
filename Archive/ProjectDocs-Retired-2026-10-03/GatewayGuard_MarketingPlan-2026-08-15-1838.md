<!-- Dated: 2026-08-15 18:38 ET -->
# GatewayGuard — Marketing Plan

- **Document Name:** GatewayGuard_MarketingPlan
- **Last Modified:** 2026-08-15 18:38 ET
- **Last Editor:** Claude.ai (Cloud)
- **Machine:** CGDELL
- **Status:** Cumulative Master Document — supersedes the marketing sections of `ProjectNotes-2026-08-09-1435.md` and the marketing entries FP-10 to FP-16 in `FutureProjects-2026-07-19.md`
- **Change History Log:**
  - 2026-08-15 18:38: Created. Rebuilt on the licence position Bill set this session — both products copyrighted, source visible but not takeable, EULA on purchase, source shipped with every download and auditable after purchase. **This closes the open source/closed-source decision that has sat unresolved in ProjectNotes since July**, and retires every tactic that assumed a public repository.
  - **Stamp note:** 18:38 is the last time given this session. Correct it if the session has moved on before filing.

---

## 1. WHAT BILL DECIDED, AND WHY IT CHANGES THE PLAN

**Two statements, 2026-08-15:**

1. **The Security Guide and the Checkup source code are copyrighted.** The source is available to view. You can look, but you cannot take. Purchasing either product requires agreement to the End-User Licence Agreement.
2. **Visible source code is included with every Checkup download and is fully auditable after purchase.**

**This settles a decision that has been open since July.** `ProjectNotes` posed it as Option A fully open source, Option B source-available, Option C closed with a published hash, and recommended B or C without choosing. **The answer is B, with one detail that changes the marketing more than the licence does: the source ships with the download, not on a public repository.**

### The consequence, stated plainly

**Nobody can audit the code before buying.** The trust argument in the old plan ran *"security buyers audit code before running it — open source means nothing to hide."* **That argument no longer applies to a prospect.** It applies to a customer.

**This is a real cost and it should be named rather than papered over.** It closes the technical-reviewer path that the old plan leaned on: no GitHub stars, no forks, no pre-purchase community audit, no "submit for review on r/Windows11."

**It is also the right call for the actual buyer.** The primary audience is a non-technical senior. That person was never going to read PowerShell, and a public repository would have been trust theatre aimed at an audience that is not paying. What they need is a promise they can verify *through someone they trust* — and that is exactly what shipping readable source in the download delivers.

---

## 2. THE CLAIM LANGUAGE — APPROVED AND BANNED

**This section is the operative part of the plan.** Every other section depends on it.

### Approved

| Claim | Where it may be used |
|---|---|
| **Source-visible** | Anywhere |
| **Fully auditable after purchase** | Anywhere |
| **The code is included with every download, in plain readable text** | Anywhere |
| **You can read every line, or have someone you trust read it** | Consumer-facing |
| **Nothing is hidden from you. Nothing is sold to anyone else.** | Consumer-facing |
| **Checkup asks your permission before every change** | Anywhere |
| **No data collection, no advertising, no account required** | Anywhere |
| **One-time purchase. Updates are optional.** | Anywhere |

### Banned, and why

| Never say | Reason |
|---|---|
| **Open-source** | No public repository and no OSI licence. `WebsiteStandards` and `CLAUDE.md` both ban it. Easily disproved, and the disproof lands on the one thing we sell — trust |
| **Free** *(of either product)* | Both are paid. The 19 website pages are free; the products are not |
| **100% Free**, **we never ask for money**, **we do not sell software** | Present in the flyer drafts. Flatly false and now legally material, since purchase carries a EULA |
| **Independent tech volunteers** | GatewayGuard LLC is a Maine company selling a product |
| **Human-backed**, or assisted sessions as available | Roadmap only. `CLAUDE.md` business-model accuracy rule |
| Any superlative — *best, safest, most secure* | PL-4 |
| **Audit it before you buy** | No longer true. Audit follows purchase |

### One line to settle across every surface

**The website footer currently says "Source code is included with every download."** That is accurate under the new position and should stay. **Pair it with the second half so the claim is complete:**

> Source code is included with every download and is fully auditable after purchase. It is copyrighted and licensed for your use — you may read it; you may not redistribute it.

**Also on that footer: "No subscription — ever."** Annual updates are $12.99/yr. Optional updates are not a subscription, but the line invites the comparison and a buyer who later sees an annual price will remember it. **Recommended replacement:** *"One-time purchase. No subscription. Annual updates are optional."*

---

## 3. POSITIONING

**Primary audience: the non-technical senior operating their own PC.** This is the guide's reader as of the 2026-08-13 decision, and it is the tool's user. All default copy is written to them.

**Secondary audience: the Family IT Maven** — the one person in a family who gets called when a laptop misbehaves. **They are a marketing target, not the reader.** One Maven deploys across five to ten machines, which is what the multi-PC packs exist for.

**Tertiary: technical reviewers and press.** Addressed in the expert voice, and now addressed *without* a pre-purchase audit path. See section 5.

### The core message

**Windows 11 already contains the protection you need. Most of it is turned off, buried, or worded so that nobody touches it.**

Checkup walks through nineteen settings, explains each one in plain English, and asks permission before changing anything. The guide does the same on paper, at your own pace.

**Neither one asks for an account, collects anything, or phones home.**

### What the competition does not do

| | Typical hardening tool | GatewayGuard |
|---|---|---|
| Explains each change | Rarely | Every one, in plain English |
| Asks permission | No — applies a profile | Yes — every setting |
| Reversible | Often not | Undo steps for every setting |
| Readable code | Compiled | Plain text, included |
| Written for | Sysadmins | The person who owns the PC |

**Do not claim to be the only tool doing this.** PL-4, and it is not verifiable.

---

## 4. LAUNCH — SEVENTEEN DAYS

**The Guide has no dependency on the code-signing certificate.** It is a PDF. The tool does. **That splits the launch into two independent halves and makes September 1 achievable regardless of DigiCert.**

### Recommended: Guide first

| | |
|---|---|
| **September 1** | Security Guide, $8.99, live on Gumroad. Website updated. Announcement to the channels below |
| **On certificate issue** | Checkup, $19.99, signed. Second announcement, which is a second news cycle rather than a delay |

**Two launches produce two moments of attention.** A single launch that slips produces none.

**The unsigned option should be declined.** A SmartScreen warning on first run, on a product sold entirely on trust, at the exact moment a cautious buyer is deciding — that costs more than waiting.

### Pre-launch, now to September 1

**Nothing here requires the certificate.**

- **Fix the false claims.** The corrupted flyer drafts in `Marketing-Notes.md` advertise *"an expensive personal PC security guide"* above *"100% Free."* **Retire them rather than patch them** — their premise is a free guide from volunteers, which is not the business.
- **Fix `MarketResearch.md`** — the competitive table still lists GatewayGuard as free, and the human-assisted line is still unmarked as roadmap.
- **Write the launch post.** *"I spent three hours auditing the security settings on my own Windows 11 PC. Here is everything I found."* Full value in the post; the link at the end only.
- **Begin participating** in r/Windows11, r/techsupport, r/privacy and r/seniors. **Arrive as a known name, not a stranger with a link.**
- **Contact Curtis Memorial Library** about an autumn presentation. Local, warm, and the exact demographic.

---

## 5. CHANNELS

### Channel 1 — Reddit and forums (free, highest priority)

**Rule that has not changed: value first, link last.** A long, genuinely useful post that solves the problem without the product, with one line at the end offering the shortcut.

**What has changed: do not offer the code for review.** The old plan proposed submitting for community audit. **That offer cannot be honoured now**, and making it and withdrawing it would be worse than never making it.

**What to offer instead:** the nineteen free setting pages. They are real, complete, and cost nothing to give. A reader who works through all nineteen by hand has been genuinely helped, and is exactly the person who will pay $19.99 not to do it again on three more machines.

### Channel 2 — Local and community (highest conversion)

**A live demonstration on a real PC in front of twenty people in a library is worth more than any copy ever written.** It is also the only channel where the senior audience is reachable directly rather than through their children.

- Library and community-association talks: *"Taking Control of Your Digital Privacy"*
- Printed one-page handout, QR code to `gatewayguard.co/guide`
- Nextdoor and local Facebook posts tied to real local events — a phishing wave, a utility scam

**Use plain analogies.** Updates are an oil change. Encryption is a lock on the filing cabinet. **Avoid fear.** This audience is already frightened, and frightening them further is how they end up on the phone with the scammer.

### Channel 3 — ACBL and Bridge Base Online

**200,000+ members, skewing 50s to 70s, and Bill is a member.** A warm introduction to a demographic that is both the most targeted by fraud and the least likely to have touched a security setting.

**Pitch:** *"GatewayGuard protects the Windows 11 PCs your members use to play online."*

### Channel 4 — Press

**After launch, and after the product is stable.** Community validation first, press second.

**Tier order:** BleepingComputer, How-To Geek and PCMag before anything national. They cover exactly this and their readers are Family IT Mavens.

**Be ready for the source question.** A reviewer will ask why it is not on GitHub. **The answer is short and should be given without apology:**

> The code ships with the product, in plain text, and any buyer can read every line. It is copyrighted and licensed — readable, not redistributable. We would rather be honest about what that is than call it open source when it is not.

### Channel 5 — Affiliates

**Post-launch.** 30–40% commission, targeted at security bloggers and newsletter writers. **Provide the approved claim language from section 2** — an affiliate writing "free and open source" creates the exact liability the licence exists to prevent.

---

## 6. WHAT THE EULA MEANS FOR THE STORE

**Purchase requires agreement.** That has three consequences worth planning rather than discovering:

**The EULA must be readable before purchase, not only after.** A licence a buyer first sees after paying invites chargebacks. Link it from the product page and the download page.

**The refund policy has to coexist with a downloaded, readable product.** Once source is in a buyer's hands it cannot be un-given. **Decide the policy before the store opens**, and state it on the product page.

**Multi-PC packs need their licence terms stated in the listing** — how many machines, whose machines, household or otherwise. The packs run to $79.99 for ten, which is enough money that the terms will be read.

---

## 7. OPEN DECISIONS

| # | Decision | Why it matters now |
|---|---|---|
| 1 | **Launch shape** — Guide first, both together, or tool unsigned | Everything in section 4 depends on it. Seventeen days |
| 2 | **Refund policy** | Cannot open a store without one, and the readable-source download makes it non-obvious |
| 3 | **Multi-PC licence terms** | Must appear in the listing |
| 4 | **Annual updates — delivery mechanism** | Priced at $12.99/yr in materials, undefined in practice. `FP-21`, still open |
| 5 | **Retire the flyer drafts, or rewrite them** | Recommendation is retire. They are false in their premise, not their wording |
| 6 | **Footer wording** — the two lines in section 2 | Live on the site today |

---

## 8. WHAT THIS PLAN RETIRES

**Struck, because they assumed a public repository:**

- *"Create GitHub account and publish source"* — marketing calendar, July 2026
- *"Submit GatewayGuard for community audit on r/Windows11"*
- GitHub stars and forks as social proof; the Issues tab as a beta pipeline
- *"Open source = nothing to hide = trust"* as a positioning line

**Struck, because they are false:**

- Every flyer draft claiming free, volunteer-run, or no money asked
- Any description of assisted sessions as available

**Kept in full:** the local and community strategy, the ACBL channel, the Family IT Maven framing, the value-first forum method, and the press tiering. **None of those depended on the source being public.**

---

*End of document.*
