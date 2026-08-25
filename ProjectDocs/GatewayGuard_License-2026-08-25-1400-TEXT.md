<!-- Dated: 2026-08-25 14:00 ET -->
<!-- Editor: Claude Code (CGDELL) -->
<!-- Generated from Masters/GatewayGuard_License-2026-08-25-1400.docx by Tool2/build_license_v24_2026-08-25.py -->
# GatewayGuard LLC - Product License Agreement (v2.4) - readable twin

**This file is generated. Edit the .docx master, then regenerate.**

GATEWAYGUARD LLC — PRODUCT LICENSE AGREEMENT

Version 2.4 — Revised following the attorney consultation of August 4, 2026

Dated: 2026-08-25 14:00 ET

GatewayGuard LLC  |  William F. Burns III, Founder & Developer  |  Brunswick, Maine

support@gatewayguard.co  |  gatewayguard.co

Supersedes GatewayGuard_License-2026-08-24-1210. The 2026-08-24-1820 and 2026-08-07-0726 drafts are withdrawn and are not part of this chain — both removed PC binding, which was not approved.


## Changes Since the August 4 Draft

This version applies the attorney’s comments from the August 4 consultation, together with the pricing and refund decisions taken since. Items still open are marked DECISION NEEDED and appear in a shaded note.

1. PC binding stays, and now reads plainly. Checkup is still tied to the PC it is first run on, exactly as in the August 4 draft. Only the wording changed. The old text led with the mechanism — a hardware identifier recorded on first run — which reads to a nervous buyer as a lock rather than a license. Section 2 now leads with what the customer gets and what happens when a PC is replaced. Moving a license to a replacement PC carries a small fee, listed at gatewayguard.co. The attorney asked that this clause be tested against Section 5 of the FTC Act, which says nothing about physical hardware. That test is still outstanding.

2. The refund policy has been rewritten to 30 days, no questions asked (2026-08-24). Section 8 of the August 4 draft was an empty placeholder. The August 7 draft filled it with a sales-are-final rule carrying three named exceptions and a log-file requirement. That has been withdrawn: Section 9 now gives a full refund on request within 30 days of purchase, with no reason required and nothing for the buyer to prove.

3. Two absolute warranties have been softened. The prior draft warranted that “every change is reversible” and that Checkup “makes no network connections from your PC.” A single edge case would make either statement false. Reversibility now appears in Section 8 as a description of how Checkup is built rather than as a warranty, and the data warranty now states what Checkup sends rather than making an absolute claim about network behavior.

4. A severability clause has been added. Section 13. If a court strikes one part of the agreement, the rest survives.

5. The annual Windows update risk is now stated plainly. Section 8 tells the customer that Microsoft’s yearly Windows 11 update may change or reset security settings, and recommends running Checkup again after each one.

6. A section on the programs review has been added. Section 7 describes the installed-programs audit, states that Checkup removes nothing without on-screen approval, states that each approval is logged with a date and time, and frames our risk flags as our opinion rather than a finding of fact.

7. Prices have been removed from the agreement. The August 4 draft named a figure for updates in Section 2 and referred to an annual update subscription. Both are gone. A price in a contract has to be amended like a contract, and three surfaces stating the same number will eventually disagree. Section 2 now says an updated version exists and is optional, and points to gatewayguard.co. The subscription reference also contradicted the decision of August 22 that there is one renewal product, a yearly update, with no multi-year plans.

8. The agreement now covers fixes to the version you bought. Section 2 said only that the license covers “the version you bought,” which left a correction to that same version looking like a different version nobody had bought. Corrections are now free. A new annual version is still a separate purchase.

9. A section on changing these terms has been added. Section 12. Terms may change, the current version is posted at gatewayguard.co, and a change never applies backwards to a purchase already made. This was on the August 4 list and was never reached.

10. What comes with each product is now listed, and other companies’ software is addressed. Section 1 says that a Checkup license covers the starter file as well as the script, that the Guide’s five print sizes are one product, and that your log file belongs to you. Section 8 states that we do not supply, own, or support Windows or Malwarebytes, and that Checkup contains no third-party or open-source code.


## License Agreement

This agreement is between you (“you”) and GatewayGuard LLC, a Maine limited liability company (“GatewayGuard,” “we,” or “us”). By downloading, installing, or running any GatewayGuard product, you agree to these terms. If you do not agree, do not use the product.

### 1. Products Covered

This agreement covers every product GatewayGuard LLC sells. Today that is two products, each with its own terms. If we release further products, this agreement covers those too, and we will say in the product’s own description which sections apply to it.

GatewayGuard Checkup (“Checkup”): the Windows 11 security review program, delivered as a PowerShell script together with the small starter file that runs it for you. Covered in Sections 2 through 4.

The Guide: the GatewayGuard Windows Security Walkthrough Guide, supplied as PDF files with identical wording in five print sizes. Covered in Section 5.

Buying one product does not give you a license to the other. A bundle purchase covers both.

What comes with each product. Your Checkup license covers the script, the starter file that launches it, and any correction we issue for that same version. Your Guide license covers all five print sizes — they are one product, not five, and the one printed copy Section 5 allows is one copy of the size you choose.

Your log file is yours. Checkup writes a record of what it found and what you approved to a file on your own computer. That file belongs to you. It is never sent to us, and we cannot read it unless you choose to send it to us.

### 2. Your Checkup License

You are buying a license to use Checkup — not Checkup itself. GatewayGuard LLC owns Checkup, including all code, text, and design.

The PC you install it on. Your license covers one (1) personal computer that you own or control. The first time you run Checkup, it makes a note of the computer it is running on, and your license belongs to that computer. Nothing about you goes into that note — not your name, not your email, not an account. It only identifies the machine.

We do this for one reason: it is what lets us sell Checkup once, at a price a household can afford, instead of charging a monthly fee to cover copies being passed around.

When you get a new computer. Computers fail and people replace them. When that happens, email us at support@gatewayguard.co and we will move your license to the new PC. There is a small fee for the move, listed at gatewayguard.co. We are not going to make you prove anything — if you tell us your old PC is gone, that is good enough for us.

If you bought a multi-PC pack. A 3-PC, 5-PC, or 10-PC pack covers that many computers. Each one is noted separately, the same way, and the same move applies to each.

DECISION NEEDED — multi-PC terms. Whose machines a pack covers is still open: one household, one person, or any PC the buyer owns. The packs run to $79.99, which is enough money that a buyer will read this sentence carefully.

DECISION NEEDED — the license move needs a price and a way to do it. Bill’s instruction of 2026-08-25 is that a license move carries a small fee rather than being free and unlimited. The amount is not set, and it is not written here because prices do not belong in a contract. Two things are outstanding: the amount, published at gatewayguard.co, and a way to actually perform the move. Measured on build ascii43: Checkup computes a machine identifier and displays it, but never compares it to anything, so there is at present nothing to reissue. Section 2 states the one-PC rule as a term of this agreement and makes no claim about what the software enforces.

You may read the source code. Checkup is delivered as a PowerShell script (a .ps1 file). The source code is fully readable in any text editor. We want you to be able to see exactly what Checkup does — that is part of how you know you can trust it. Open it, read it, and inspect it as much as you like.

Updates. This license covers the version you bought. You can run that version as many times as you want, and we will never make your existing copy stop working.

Fixes to your version. If we issue a correction to the version you bought — a fix for a defect, not a new annual version — you are licensed to run it, at no charge. A new annual version for a new Windows release is a separate product and a separate purchase.

Microsoft releases a major Windows 11 update most years. When that happens we offer an updated version of Checkup that keeps pace with the changes. The updated version is a separate purchase and is entirely optional — skipping it does not affect the copy you already own. Current prices and terms are listed at gatewayguard.co.

DECISION NEEDED — Q2(d) is answered by the removal of prices. The spliced sentence about an annual update subscription is gone from Section 2, together with the figure it carried. Prices and update terms now live at gatewayguard.co only. Nothing further is needed unless the attorney wants the update offer described in the agreement itself.

### 3. What You May Do

With a valid Checkup license you may:

- Install and run Checkup on your licensed PC as many times as you like.
- Open and read the source code in any text editor.
- Keep one backup copy of the download file for your own safekeeping, so you can install it again later.
- Quote short portions of the source code in a review, or when asking for technical help online, as long as you include the credit “GatewayGuard LLC — gatewayguard.co.”
DECISION NEEDED — Q5. Your notes read “Allow them to make a 2nd copy for security for future.” The draft already permitted one backup copy, which is that second copy. Confirm this is what was meant. If you intended two backup copies, or a copy on separate media such as a USB drive, say so and the wording will change.

### 4. What You May Not Do

You may not:

- Share, sell, rent, lend, give away, or transfer Checkup or any copy of it to anyone else. Moving your own license to your own replacement PC, as described in Section 2, is not a transfer and is always allowed.
- Post Checkup or its source code on any website, file-sharing service, code repository, or forum.
- Create modified versions of Checkup, or put our code into another product, for personal or commercial use.
- Remove, alter, or hide our name, our copyright notices, or the code-signing signature on Checkup.
- Run Checkup on business, school, government, or organization computers without a separate written agreement with GatewayGuard LLC.
- Use Checkup to provide paid services to other people — for example, running it on clients' computers as part of a paid service — without a separate written agreement with GatewayGuard LLC.
### 5. Guide License

The Guide is a separate product from Checkup. Buying the Guide gives you a personal, non-transferable license to:

- Read and use the Guide on any personal computer in your home that you own or control.
- Print one copy for your own use.
You may not:

- Share, distribute, sell, or give the Guide to anyone outside your household.
- Post the Guide, or any part of it, online.
- Use the Guide for any commercial purpose, including teaching, consulting, training, or providing services to other people.
- Create your own version based on the Guide — including rewritten, adapted, translated, or reformatted versions — for personal or commercial use.
The Guide is protected by copyright. GatewayGuard LLC keeps all rights not granted to you here.

### 6. What GatewayGuard Promises

GatewayGuard LLC warrants that:

- Checkup runs on supported Windows 11 versions listed at gatewayguard.co/compatible on the date you bought it.
- Checkup does what the website says it does. It reviews your Windows 11 security settings and turns them on or off with your approval at each step.
- Checkup changes nothing without your approval. Checkup shows you each proposed change first and asks your permission. Nothing is changed unless you say yes.
- Checkup contains no malware. Checkup is digitally signed with a code-signing certificate issued by a recognized certificate authority. The signed file has not been altered since we signed it.
- Checkup does not collect your data. Checkup is built to run without contacting us. It sends nothing about you or your computer to GatewayGuard LLC or to anyone else.
These promises do not cover: problems caused by Windows updates that change how your system behaves after you buy; PCs with hardware not listed on our compatible PC list; or damage caused by running Checkup on an unsupported version of Windows.

DECISION NEEDED — Q9. Two absolute claims were removed from this section. “Every change is reversible” now appears in Section 8 as a description of how Checkup is built. “Checkup makes no network connections from your PC” became “built to run without contacting us.” Both changes reduce exposure but weaken the marketing claim. Confirm, or restore the original absolute wording and accept the risk knowingly.

### 7. Reviewing the Programs on Your PC

Checkup reviews the programs installed on your PC and points out any we consider risky, with a plain-English explanation of why we think so.

Checkup never removes a program on its own. If you want a program removed, you approve that removal on screen, and Checkup records your approval with the date and time in your log file.

Our flags are our opinion, based on our research. A flag does not mean a program is harmful, and you may have good reasons to keep something we flagged. The decision is always yours.

DECISION NEEDED — Q10. The attorney approved this design and asked separately if the feature should ship at launch or wait. That launch-timing decision is not recorded in the consult notes. If the programs review does not ship on September 1, this section comes out of the launch version of the agreement.

### 8. What GatewayGuard Does Not Promise

Except for the promises in Section 6, Checkup and the Guide are provided “as is.”

We do not promise that Checkup will make your computer immune to every security threat, catch every piece of malware, or prevent every attack. No security tool can promise that.

We do not promise that Checkup will work correctly on every possible combination of hardware and software.

We do not promise that the settings you approved will stay in place after Windows updates. Microsoft releases a major Windows 11 update every year, and those updates may change or reset security settings. We recommend running Checkup again after each annual Windows update so you can see what changed and approve any settings you want turned back on.

Checkup is built so that the changes you approve can be undone. The Guide explains how to undo each one.

Other companies’ software. Checkup checks and changes settings that belong to Windows, and it can detect and open Malwarebytes if you have it installed. We do not supply, own, or support those products. Your use of them is governed by their own terms, not by this agreement, and we are not responsible if Microsoft changes how a Windows setting behaves after you buy.

No other company’s code is inside Checkup. Checkup is our own work. It contains no third-party code and no open-source components. It uses features that are already built into Windows.

### 9. Refunds

Checkup and the Guide are downloadable files. If either one is not what you expected, write to us within 30 days of buying and we will refund you in full. You do not have to give a reason.

You do not need to prove anything, send us a log file, or let us try to fix the problem first. If you would like to tell us what went wrong we are glad to hear it, because it is how the product improves — but it is not a condition of your refund.

To ask for a refund, email support@gatewayguard.co from the address you bought with, or use the refund link in your Gumroad receipt. Give us your order number. We aim to answer within two business days.

When we refund you, your license ends and you should delete the copies you have, including any backup. We are aware we cannot check this, and we are not going to try. We are asking you to be straight with us, in the same way we are being straight with you.

If you bought through Gumroad, Gumroad handles the payment and may also issue a refund under its own policy, which can run longer than our 30 days. Nothing here takes away any right you have under the consumer law where you live.

### 10. Liability Limit

To the fullest extent Maine law allows, GatewayGuard LLC is not liable for any indirect, incidental, special, or consequential damages arising from your use of our products, even if we were told those damages were possible. Our total liability to you for any claim related to GatewayGuard products is limited to the amount you actually paid for the product involved.

### 11. Governing Law

This agreement is governed by the laws of the State of Maine, without regard to conflict-of-law principles. Any dispute arising from this agreement will be resolved in the courts of Maine.

### 12. Changes to This Agreement

We may change these terms from time to time — for example, to reflect a change in the law, in how we sell our products, or in how a refund is handled. The current version of this agreement is always posted at gatewayguard.co.

A change never applies backwards. The terms you agreed to when you bought stay in force for that purchase. If you buy again later — an annual update, another product, or another PC — the terms posted at that time apply to the new purchase.

DECISION NEEDED — the terms-change clause is new and unreviewed. Question 11 of the August 4 cover note listed “a mechanism for changing terms in future versions” and the consult notes record only severability as answered. This clause is drafted from scratch. It is deliberately narrow: a change applies only to a later purchase, never to one already made. Confirm or replace.

### 13. If Part of This Agreement Cannot Be Enforced

If a court decides that any part of this agreement is invalid, illegal, or cannot be enforced, that part is removed and the rest of the agreement stays in full effect.

### 14. Ending This License

If you break these terms, your license ends immediately and you must delete every copy of the GatewayGuard products you have. You may end this license yourself at any time by deleting every copy. Ending the license does not entitle you to a refund except as described in Section 9.

DECISION NEEDED — Section 14 and Section 9 do not agree. “Ending the license does not entitle you to a refund except as described in Section 9” was written when Section 9 was a sales-are-final rule with three named exceptions. Section 9 is now an unconditional 30-day refund with nothing to point at, so a customer whose license ended for breach appears to be pointed at a full refund right. A carve-out here is exactly the hedge the August 22 decision warns against — “no questions asked earns its keep only if there are none.” This is for the attorney, not for us.

### 15. Contact

GatewayGuard LLC  |  Brunswick, Maine  |  support@gatewayguard.co  |  gatewayguard.co


## Appendix — Open Items Not Yet in the Agreement

These came out of the August 4 consultation and are not resolved. None of them is drafted into the text above.

Cease-and-desist template. The attorney agreed a template letter should be prepared — email first, U.S. mail if there is no response — but the specific language has not been supplied. Not part of this agreement; a separate document.

PC binding versus the FTC Act. The attorney noted the Federal Trade Commission Act, 15 U.S.C. §§ 41—58, says nothing about physical hardware, and asked that the binding clause be tested against Section 5 (15 U.S.C. § 45), which prohibits unfair or deceptive acts or practices in or affecting commerce. Binding is in this version, so the test is live. The Maine consumer-protection question on hardware-bound software comes with it, and both belong in the refund consultation rather than a separate call — for a buyer whose PC died on day 31, binding and refunds are one conversation.

Clauses considered and not added. Question 11 of the August 4 cover note listed arbitration, entire-agreement, assignment, age and export restrictions, and a mechanism for changing terms in future versions. The consult notes record only severability as the answer. The terms-change mechanism is now drafted as Section 12 and needs review. The other four are still not in this draft. Confirm they were declined rather than simply not reached.

Nothing shows this agreement to the buyer, and nobody accepts it. Measured on build ascii43 on 2026-08-25: the words “license agreement,” “EULA,” “terms of use,” “accept the terms” and “I agree” appear nowhere in Checkup, and no page on gatewayguard.co carries this agreement. The launch plan of August 2 carries “EULA posted” as a critical task, and posted is not the same as accepted. How a buyer accepts this agreement — at Gumroad checkout, on a license page linked from the receipt, on Checkup’s first screen, or some combination — is the first question for the attorney, because every other question here assumes a contract the buyer entered into.

The customer email list. The plan is to notify every past installer when an annual update ships. Research finding: an email whose only content is warranty, safety, or security information about a product the recipient bought, or notice of a change in terms or features, is treated as transactional or relationship content and is exempt from most CAN-SPAM requirements. The FTC reads those categories narrowly. Adding a sales pitch to the same message makes it commercial, which brings the opt-out, advertisement-identification, and physical-address requirements with it. A separate technical plan is needed for a list that scales to 100,000 addresses.

Gaps in the consult notes. Question 6 was answered “no minimum, we can establish” without recording a minimum of what — quantity, license term, or price. Question 8 ends mid-sentence at “Qualify in terms of …” and was referred to LegalZoom. The follow-up plan refers to combining “the 7 items” into three or four consultations without identifying which seven.


GatewayGuard_License-2026-08-25-1400  |  Dated: 2026-08-25 14:00 ET  |  Version 2.4  |  Last editor: Claude Code (CGDELL)

Draft — attorney review required before use. This document is not legal advice.

