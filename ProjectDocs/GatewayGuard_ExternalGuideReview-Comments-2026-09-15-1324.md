<!-- Dated: 2026-09-15 13:24 ET -->
<!-- Editor: Claude Cloud -->
# External review of the Guide -- the review verbatim, and Cloud's comments

- **Document Name:** GatewayGuard_ExternalGuideReview-Comments
- **Last Modified:** 2026-09-15 13:24 ET
- **Last Editor:** Claude Cloud
- **Reviews:** an external AI review of `GatewayGuard_GuideRewrite-Draft-2026-08-22-1000.md`, pasted by Bill on 2026-09-15
- **For:** Bill, then Claude Code
- **Status:** COMMENTS. Amends nothing. The reviewer's text is preserved unedited in Part 1 so the comments can be checked against it.

---

## PROVENANCE

- **The review text** was pasted by Bill into the Cloud conversation on 2026-09-15. Which product produced it is not stated in the paste; Bill knows. **Preserved verbatim in Part 1** -- nothing cut, nothing reworded.
- **What the reviewer read:** by its own statement, the guide draft, and not all of it ("over 20,000 tokens... I cannot produce a complete replacement"). It shows no sign of having read the tool, the licence, the website pack or `CURRENT.md`.
- **What Cloud checked against, all via `project_knowledge_search`:** the draft's own header and "WHAT MUST HAPPEN" list; `GatewayGuard_CPM_Schedule-2026-08-31-1439.md` sections 1-2 (the 29 VERIFY markers, the quick-reference table at line 283, the six `GuideRef` destinations); pack 1 and pack 2; licence v3.1 Sections 5 and 9.
- **Not checked:** the exact list of the 19 settings against the reviewer's list. Claude Code should -- see comment 2.

**Labels:** ***measured*** (Claude Code, attributed) / *sourced* / *inferred* / *guess*.

---
---

# PART 1 -- THE REVIEW, VERBATIM

> I can rewrite the guide, but the guide you uploaded is over 20,000 tokens and roughly a book-length document. I cannot produce a complete replacement of that entire work in a single response without truncating large portions.
>
> What I can tell you after reading GatewayGuard_GuideRewrite-Draft-2026-08-22-1000.md is that the guide is already substantially better than a typical consumer security guide, but it suffers from four issues:
>
> It is too long for most home users.
> It mixes security, privacy, malware cleanup, browser optimization, and performance tuning into one document.
> Some settings are presented as objective security recommendations when they are really preferences.
> Several sections contain VERIFY markers and publication caveats that should never appear in customer-facing material.
>
> My recommended rewrite
>
> Split the guide into three separate products:
>
> Guide 1: Windows 11 Security Checkup
>
> Only include:
>
> Windows Update
> Defender Real-Time Protection
> Tamper Protection
> SmartScreen
> Enhanced Phishing Protection
> Firewall
> BitLocker
> Windows Hello
> Memory Integrity
> Password Required on Wake
>
> These are your true security controls.
>
> Target length:
>
> 25-35 pages
> one setting per section
> plain language
>
> Guide 2: Privacy & Tracking Controls
>
> Include:
>
> Advertising ID
> Diagnostic Data
> Widgets
> Edge Startup Boost
> Edge Password Saving
>
> These are mostly privacy and preference decisions rather than security requirements.
>
> Guide 3: Malware Recovery Guide
>
> Everything currently in Phase 3.
>
> This should stand alone because:
>
> Most customers never need it.
> Those who do need it want a dedicated playbook.
>
> Specific rewriting changes
>
> Current style
>
> A lot of sections read like:
>
> Why it matters.
>
> Here is why you should do this.
>
> Recommended style
>
> Use:
>
> What It Is
>
> Why It Matters
>
> GatewayGuard Recommendation
>
> How To Check
>
> How To Change
>
> What To Expect
>
> When You Might Choose Differently
>
> This format is easier for seniors to skim.
>
> Example Rewrite
> Setting 12: Diagnostic Data
>
> Current section is roughly 450 words and somewhat argumentative.
>
> I would rewrite to:
>
> Diagnostic Data
> What It Is
>
> Windows sends diagnostic information to Microsoft to help keep Windows secure, reliable, and up to date.
>
> Why It Matters
>
> Windows offers two diagnostic levels:
>
> Required Diagnostic Data
> Optional Diagnostic Data
>
> Optional Diagnostic Data shares additional information intended to help Microsoft improve products and services.
>
> GatewayGuard Recommendation
>
> Recommended: Required Diagnostic Data
>
> Most home users receive the same updates, security protections, and day-to-day experience while sharing less information.
>
> How To Check
> Open Settings.
> Select Privacy & Security.
> Select Diagnostics & Feedback.
> Review Diagnostic Data.
> What To Expect
>
> No restart required.
>
> Windows continues to function normally and receive updates.
>
> When You Might Choose Differently
>
> If you want to contribute additional usage information to improve Windows products, Optional Diagnostic Data may be appropriate.
>
> Biggest Content Win
>
> Your strongest feature is the Quick Reference table.
>
> I would move it to page one immediately after the cover. The table containing all 19 settings is arguably more useful than the first several pages of explanation because it quickly shows users:
>
> where a setting is located
> what GatewayGuard recommends
> where to find details
>
> Biggest Structural Change
>
> Convert every setting into a standalone article.
>
> The guide already points readers to:
>
> gatewayguard.co/guide — one page each, with pictures.
>
> I would make those pages the primary content and reduce the PDF guide to a 30-page workbook that references them.
>
> Overall Assessment
>
> If I were editing this professionally, I would:
>
> Cut the document by roughly 35%.
> Separate security from privacy.
> Move malware remediation into its own guide.
> Standardize all 19 settings into the same format.
> Remove every internal note, VERIFY marker, export note, reconciliation block, and drafting commentary before release.
>
> The underlying content is good. The main opportunity is improving clarity, consistency, and usability for the non-technical home user that GatewayGuard is targeting.

---
---

# PART 2 -- CLOUD'S COMMENTS

## The one-paragraph verdict

**The reviewer's editing instincts are mostly good; its product decisions are wrong for this business; and it treats the VERIFY markers as drafting residue when they are the guide's real risk.** It read the guide alone -- not the tool, the licence, the store or the website -- and every recommendation that is wrong is wrong for that reason.

## What to take

| Recommendation | Take it? | Why |
|---|---|---|
| **One fixed format for every setting** -- What it is / Why it matters / GatewayGuard recommendation / How to check / How to change / What to expect / When you might choose differently | **Yes** | The draft already uses a near-identical shape for most of the 19 (it has *What it is / Why it matters / How to check / How to change / Check that it worked*). This finishes the job. *"When you might choose differently"* is the right heading: it mirrors what the tool does at every Y/N screen. Deliver as a Cloud drop-in pack in the shape of packs 1 and 2. |
| **Quick-reference table to page one** | **Yes** | ***Measured (CPM section 1): the table is at line 283 under `## Quick-reference table`***, behind the gate and the TOC. Moving it forward is nearly free and it is the page a senior actually uses. |
| **Strip internal notes, export notes and reconciliation blocks before release** | **Yes -- already planned** | It is in the draft's own WHAT MUST HAPPEN list. Not new. |
| **Cut roughly 35%** | **Direction yes, number no** | Cut by structure -- deduplicate prose that restates the tool's screens, tighten Phase 5 -- not by removing steps a senior has to follow. The reviewer says it did not read the whole document, so it cannot have sized the cut. |

## What not to take, and why

**1. Three products.** Wrong for the business, and four weeks before launch. The Guide is **one product**: one Gumroad row at one price; five print sizes, one chosen at purchase (licence v3.1 Section 1); licence Section 5 says "the Guide"; ***measured (CPM section 1): all 19 `GuideRef` values in the tool point into one document***; the website's 19 pages mirror the same 19 settings. Three guides means three SKUs, fifteen PDF files, three licence sections, three refund rows on receipts, and a rebuild of every `GuideRef`. And the buyer has to know which guide to buy -- which is exactly what a senior does not know.

**2. The list underneath the split is unreliable.** It names ten "true security controls" and five "privacy" settings -- fifteen of nineteen. It omits at least Remote Desktop (10), Fast Startup (18) and Wake on LAN (19). It files **Edge Password Saving** under privacy; in this product it is a credential-theft decision that the tool already handles conditionally (setting 15, since ascii39). **"Memory Integrity" -- I cannot confirm that is one of the 19 at all.** *Inferred:* the list was written from general Windows knowledge, not from Checkup. **Claude Code: check the reviewer's fifteen names against the 19 before anyone acts on the taxonomy.**

**3. "Reduce the PDF to a 30-page workbook that references the web pages."** This inverts the product. The no-refund basis in licence Section 9 is that the website has everything free and **the Guide is the offline copy the buyer keeps**. A guide that sends the reader to the web is not what they paid for, and the reader is a senior who bought a large-print PDF to print. The website pages and the guide sections should stay parallel and self-contained, which they are.

**4. Malware recovery as a separate product.** *"Most customers never need it"* is the argument for keeping it **in**. Nobody buys the recovery guide before the day they need it, and on that day the machine may not reach the store. Phase 3 stays where it is.

**5. The VERIFY markers -- the important one.** The reviewer reads them as drafting residue to delete before release. ***Measured (CPM section 2): the 29 markers are factual claims about Windows behaviour*** -- BitLocker key escrow into a Microsoft account, local-account password reset having no path, sleep versus hibernate and the recovery-key prompt -- ***and the draft's own line 1963 says two of them can cost a reader their files.*** Deleting a marker ships the claim unmeasured. **The fix is T-VF1: measure the claim, then remove the marker.** Taken literally, the reviewer's advice is the mechanism by which a wrong sentence reaches a senior with no record. This is the same failure shape as FT-141 and FT-257 in the tool -- an "Unknown" printed as GOOD -- and the guide is the worse place for it because nothing is logged.

**6. The setting 12 example.** The format is fine. The content is not ours: *"Most home users receive the same updates, security protections, and day-to-day experience while sharing less information"* is an unsourced claim, and RESEARCH BEFORE STATING applies to the guide as it does to the tool. It also drops the tool entirely -- every setting section must carry *"With your approval, Checkup will..."* (Bill's option 2, 2026-08-23), because the reader opens the guide from a Checkup screen. The reviewer did not know the tool exists.

## What Cloud recommends

1. **Adopt items 1-3 above as one Cloud drop-in pack** against the live draft: the seven-heading format on all 19 settings, the table moved to page one, nothing else touched.
2. **Keep one product, keep Phase 3, keep the guide self-contained.**
3. **T-VF1 runs as scheduled.** Markers come out one at a time, each with a measurement beside it.
4. **Land the format pack and the VERIFY resolutions in the same revision** so the guide's pagination moves once, not twice.
5. **Launch is now 2026-10-15** (Bill, 2026-09-15 13:24 ET). That is four weeks, which is enough for the format pack and T-VF1 to land in one revision before launch rather than after it.

---

## FOR CLAUDE CODE

```
Bill received an external AI review of the Guide draft. It is preserved
verbatim in GatewayGuard_ExternalGuideReview-Comments-2026-09-15-1324.md Part 1,
with Cloud's comments in Part 2. Summary for you:

TAKE: (a) one fixed seven-heading format for all 19 settings, delivered
by Cloud as a drop-in pack like packs 1 and 2; (b) move the quick-reference
table (line 283) to page one after the cover; (c) strip internal notes
before release -- already in WHAT MUST HAPPEN.

DO NOT TAKE: splitting into three products (one SKU, one licence section,
19 GuideRefs into one document); making the PDF a workbook that points at
the website (breaks the Section 9 no-refund basis -- the Guide IS the
offline copy); moving Phase 3 out; deleting VERIFY markers without
measuring the claim (T-VF1 is the fix, not deletion).

ONE CHECK FOR YOU: the reviewer lists 15 setting names including
"Memory Integrity". Confirm against the 19 in the build. Cloud could not
confirm Memory Integrity is one of ours.

LAUNCH MOVED TO 2026-10-15 (Bill, 2026-09-15 13:24 ET). Format pack + VERIFY resolutions land
together in the next Guide revision, now BEFORE launch. Bill decides whether Cloud writes the
format pack now or after T-VF1.

File into ProjectDocs\, add a row, regenerate CURRENT.md, commit, push.
```

---

## QUESTIONS, HELD TO THE END

1. **Bill:** write the format pack now, or after the 29 VERIFY claims are measured?
2. **Which product wrote the review?** Worth one word in the header for the record.
3. ~~Date and time~~ -- supplied by Bill: 2026-09-15 13:24 ET.

---

## CLAUDE CODE'S CHECK ON THIS -- 2026-09-15, same day

*Added after receipt, kept in this file rather than a separate one, per the
pattern set on `GatewayGuard_CloudAnswer-Malwarebytes-2026-09-08-1105.md` --
so nobody reads Cloud's comments without the check. Nothing above this line
was edited.*

**Cloud's one explicit ask answered first: yes, Memory Integrity is real.**
***Measured: `Name="Memory Integrity (Core Isolation)"`, ID=16, present in
both the retired ascii43 source and the live ascii44 source.*** The
reviewer's list is not inventing settings from general Windows knowledge on
that count. Also checked: ***the "Quick-reference table" heading sits three
lines after line 283 in the live draft*** -- Cloud's citation holds.

**But there is a bigger gap neither the reviewer nor Cloud's comments caught,
because neither opened the draft and checked it against the 09-08 decision:
THE GUIDE DRAFT ITSELF STILL SHIPS SETTING 5 AS A LIVE CHECKUP SETTING.**

***Measured, `GatewayGuard_GuideRewrite-Draft-2026-08-22-1000.md`:***

- **The quick-reference table still lists 19 rows**, row 5 reading
  `Defender Periodic Scanning | ... | On, only if you run another antivirus`.
- **The Phase 1 narrative still instructs the reader to act on it**: *"Periodic
  scanning -- setting 5. This appears only if you run another antivirus
  alongside Defender... If you see it, turn it on."*
- **The document's own header says `Last Modified: 2026-08-23 21:40 ET`** --
  sixteen days before Bill removed setting 5 from Checkup entirely
  (`CLAUDE.md`, 2026-09-08: *"Malwarebytes is out of Checkup"* /
  *"Defender Periodic Scanning check is out of Checkup"*). Nothing in the
  guide moved when the tool did.

**So a reader following Phase 1 will look for a Periodic Scanning screen in
Checkup that no longer exists.** This is not the reviewer's "which fifteen
names are real" question -- it is a concrete sentence in customer-facing
material that describes a product that no longer ships. It is the same shape
as comment 5's VERIFY-marker warning: a wrong sentence reaching a senior with
nothing to catch it.

**The Malwarebytes framing, checked the same way, is fine.** Phase 3 Step 4
already reads as an optional manual second opinion -- *"Install Malwarebytes
Free and run one scan. It is a second opinion, not a replacement for
Defender"* -- with no reference to a tool-run schedule or a reminder task.
***Measured: nothing in the draft describes Checkup orchestrating
Malwarebytes.*** No correction needed there.

**One more count worth stating plainly, since both documents above say "19"
throughout: the product is 18 settings as of 2026-09-08, not 19.** The
quick-reference table's row 5 and its 1-19 numbering need Bill's decision on
wording, not a silent renumber -- `CLAUDE.md`'s standing rule is that a gap in
the numbers costs nothing and a renumber makes every earlier log wrong about
which setting it was discussing. The same rule should govern the guide table:
**leave the ID gap at 5, do not renumber 6-19 to 5-18.**

**Recommendation, not yet actioned:** fold a "T-VF1-adjacent" fix into the
same guide revision Cloud's plan already calls for -- pull setting 5 out of
the quick-reference table and the Phase 1 narrative (or mark it plainly as
"no longer part of Checkup, optional manual step" if Bill wants it kept as
guide-only content, matching Malwarebytes' own treatment). **This is a
product-wording call, so it is Bill's, not mine to make in passing.**

**Launch date change recorded:** `CLAUDE.md`'s target-launch line updated to
**October 15, 2026 (Thursday)**, sourced to this document's line 227.
