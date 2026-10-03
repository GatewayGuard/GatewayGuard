<!-- Dated: 2026-07-16 16:25 EDT -->
<!-- File: PricingReconciliation-2026-07-16.md -->
<!-- Append to GatewayGuard_ProjectNotes.md under a new dated section -->

## PRICING RECONCILIATION (July 16, 2026)

### Confirmed Pricing (current as of this entry)
| Product | Price | Type | Source of decision |
|---------|-------|------|--------------------|
| Single PC license | $19.99 | One-time | FINAL, June 26 2026 |
| 3-PC pack | $34.99 | One-time | FINAL, June 26 2026 |
| 5-PC pack | $49.99 | One-time | FINAL, June 26 2026 |
| 10-PC pack | $79.99 | One-time | FINAL, June 26 2026 |
| Annual updates | $12.99/yr | Recurring | Stated in presentation July 3 2026; CONFIRMED July 16 2026 |
| Security Guide | $8.99 | One-time | DECIDED July 16 2026 |
| Assisted session | $39-49 | One-time | Roadmap item -- not launch scope |
| Beta tester / listed PCs | FREE | -- | Beta policy, June 27 2026 |

### Sync fix
ProjectNotes previously listed annual updates as TBD ($9.99-$14.99
range) while the July 3 presentation companion sheet stated $12.99
as fact. $12.99 is the decision. This entry supersedes the TBD.

### NOT confirmed / no record
- $59.99 bundle: no record in any project file. Do not use this
  number in any material until a decision is logged here.
  (Possible memory of the $49.99 5-PC pack.)
- Optimization Guides (Home $9.99 / Pro $14.99) remain SUGGESTED
  ONLY -- future products, post-26H2. Distinct from the $8.99
  Security Guide above.

### GUIDE SCOPE -- RESOLVED July 16, 2026 (was blocker)
What does $8.99 buy vs. what stays free at gatewayguard.co/guide?
- The tool hardcodes "See full guide: gatewayguard.co/guide" on
  every manual-step screen.
- The Phase 2 marketing strategy ("Lead with the Guide") depends
  on a free guide as the trust-building distribution asset.
- GitHub Pages cannot paywall content.
DECISION (July 16, 2026): OPTION A CONFIRMED.
- gatewayguard.co/guide hosts ONLY the 19 per-setting reference
  pages (support docs the tool links to). Free.
- The complete Guide (full walkthrough, screenshots, phases,
  glossary) is the $8.99 product, sold as PDF via Gumroad, and
  is NEVER published on the web.
- Rationale: the copyable thing is not the sellable thing; the
  tool's hardcoded guide links keep working; free-guide marketing
  role preserved for the reference pages.

### TAXES (July 16, 2026 -- informational, verify with CPA)
- Sales tax / VAT: Gumroad is Merchant of Record (since Jan 1 2025)
  -- collects and remits sales tax/VAT/GST worldwide automatically.
  Microsoft Store likewise. No Maine sales tax registration needed
  for these channels.
- Income tax: entirely GatewayGuard LLC's responsibility. Single-
  member LLC = Schedule C + self-employment tax (~15.3%) + Maine
  income tax. Quarterly estimated payments once expecting $1,000+
  owed -- set up BEFORE Sept launch.
- FLAG: build list says "Stripe" for update subscriptions. Stripe
  is NOT merchant of record -- sales tax burden returns to us.
  Gumroad memberships keep MoR coverage. Decide before building
  subscription plumbing.
- Platform fee reality: Gumroad ~10% + processing. Net on $19.99
  is roughly $16-17; on $8.99 roughly $7.50.
- Add to attorney/CPA consult agenda: quarterly estimates setup,
  Stripe-vs-Gumroad MoR decision, S-corp election if revenue grows.

### Downstream impacts of paid model (task list)
- [ ] Marketing copy sweep: remove/replace all "Free" tool claims
      (ProjectNotes positioning lines, flyer, FAQ, positioning
      statements, Reddit pitch wording "completely free")
- [ ] WebsitePrePlan hero spec still says "Free." -- correct it
- [ ] download.html spec changes from file-serving to purchase
      page (Gumroad link/embed)
- [ ] "Stop paying for protection you already have -- for free"
      line needs rewording ($19.99 once vs. $30-50/yr framing
      survives; "free" does not)
- [ ] Reconcile beta reward tiers with paid guide: do Founding
      Members / beta testers get the guide included?
