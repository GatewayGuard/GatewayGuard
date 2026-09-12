<!-- Dated: 2026-08-21 17:32 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Cloud Request -- reconcile the guide's setting 11, plus this session's context

- **Document Name:** GatewayGuard_CloudRequest-GuideSetting11
- **Last Editor:** Claude Code (CGDELL)
- **For:** Claude Cloud
- **One action** (section 1) and **four FYIs** (section 2). Everything else is context.

---

## 0. FIRST -- prove the sync landed

Before acting, read `ProjectDocs\CURRENT.md` and state its **commit hash** and
its four freshness values back to Bill. Your snapshot lags this session until
he clicks SYNC NOW, and the files named below were written after your last
snapshot. If you cannot see `GatewayGuard_MarketingPlan-2026-08-21-1645.md`,
the sync has not reached you yet -- say so and stop.

---

## 1. THE ONE ACTION -- reframe the guide's setting 11 (Advertising ID)

**Why this exists.** This session aligned the website page
`WebSite\html\advertising-id.html` (setting 11) to the same "more than a
preference" position that FT-220 gave setting 12 -- **Bill's explicit call.**
But the guide was **not** changed, so guide and site now disagree. That is a
RULE W-07 divergence, and it is recorded in the website page's own header as a
known temporary state.

**What the guide says now** -- `GatewayGuard_GuideRewrite-Draft-2026-08-19-1753.md`,
setting 11, **lines 1031-1032** (measured):

> **This is a preference, not a security requirement.** Leaving it on does
> not put the computer at risk. The choice is yours.

And the Phase 4 opener, **line 1010**:

> **These are not security settings** and nothing here makes your computer
> easier to break into.

**What the website says now** (the three strings this session put live, for you
to match in wording and stance):

- Intro is unchanged: *"Windows assigns your PC a unique tracking number that
  apps use to follow your activity..."*
- Why-box: *"...This is more than a taste: a record of what you do, built on
  your own machine and handed to advertisers you have never heard of, stops
  getting longer the moment you turn it off."*
- Note-box: *"This is more than a taste. The tracking number lets apps build a
  record of what you do across programs and hand it to advertisers. Checkup
  turns it off with your permission, and you can turn it back on whenever you
  like."*

**What to do.** Rewrite the guide's **setting 11** so it matches the site's
stance, the same way your FT-220 sections reframed setting 12. Keep these
guardrails:

1. **The reframe is "more than a preference / a record exists," NOT "your PC
   is less secure."** Do not claim Advertising ID is a literal security
   requirement or that leaving it on puts the machine at risk. The site does
   not say that, and it would not be true.
2. **Keep it a permission-based recommendation** -- Checkup turns it off with
   the user's permission; the user can turn it back on. Name the permission, as
   every setting description must.
3. **Touch the Phase 4 opener (line 1010) lightly** so it no longer says
   "these are not security settings" flatly over a setting you now argue
   matters. Your wording -- something that separates "not a malware defense"
   from "not nothing." Your lane.
4. **Deliver as a drop-in section** (same format as your FT-220 sections), not
   a whole-guide reissue. Bill downloads it; Claude Code commits it.

**While you are in there:** your FT-220 setting-12 section
(`GatewayGuard_GuideFT220-Sections-2026-08-21-1445.md`, section 3) already
supersedes the draft body's setting-12 text, which **still** reads *"A
preference, not a security requirement, exactly as above"* at **line 1051**.
Flag in your drop-in that the draft's line 1051 is replaced by the FT-220
section, so whoever merges the guide does not leave the old line standing.

---

## 2. FYI -- no action, or your ongoing lanes

1. **The marketing amendment is APPLIED.** Your five block replacements from
   `GatewayGuard_MarketingPlanAmendment-2026-08-21-1445.md` are in the new
   cumulative master **`GatewayGuard_MarketingPlan-2026-08-21-1645.md`**. Read
   marketing from that file now, not `-2026-08-19-1753`. **"No subscription" is
   now BANNED** in it, and it supersedes the plan's own earlier footer line.

2. **The annual price is LOCKED at $12.99/yr.**
   `GatewayGuard_PriceDecision-Annual-2026-08-21-1445.md` is filed and its
   dead-pointer is resolved. Your `GatewayGuard_PricingCopy-Draft-2026-08-21-1445.md`
   can be finalized now -- the price token can come out. **Multi-year renewal
   plan terms and the "10% per year" reading are still Bill's to decide** (open
   item), so no multi-year copy yet.

3. **FT-220 guide sections received and committed.** They are **ascii44 scope**,
   not ascii43 (Bill's decision -- the tool waits for the guide). The **eleven
   claims marked VERIFY** in that document are **Claude Code's to measure on a
   live Windows 11 machine** under gate 24 -- claims about Microsoft's software.
   **Do not measure or assert them from memory**; two (the BitLocker-key claim
   and the sleep-vs-hibernate claim) would do real harm if wrong.

4. **Per-buyer guide watermarking** is on your plate, recorded so it is not
   lost. From the ascii42 run (Bill's item 15): *"when we sell the guide... put
   their name on every page -- licensed to John Doe, for personal use only."*
   Licensing and packaging -- your lane, not a build item.

---

## 3. THE STANDING REMINDERS

- **You cannot write to the repository.** Anything you produce, Bill downloads
  and Claude Code commits. Deliver drop-in sections, not tree edits.
- **Do not author or revise a governing document**, and do not state a build
  number, line count, machine state, or test result from memory. If a fact
  about the tool is needed, ask Claude Code to measure it.
- **If a decision lives only in this chat, say so** -- *"this is in chat only,
  not yet filed in [filename]."*
