"""
Build licence v2.4 from the 1210 master.  Assert-guarded: every anchor is
verified against the live text before anything is written.

Base   : Masters/GatewayGuard_License-2026-08-24-1210.docx   (v2.0)
Output : Masters/GatewayGuard_License-2026-08-25-1400.docx   (v2.4)
Twin   : ProjectDocs/GatewayGuard_License-2026-08-25-1400-TEXT.md

Applies Cloud's changes 1-9 from GatewayGuard_CloudHandoff-2026-08-25-0921.md
(Option A -- the 1210 master keeps the authoring lineage), plus the four
additions Claude Code determined, plus Bill's two unambiguous typed notes.
Nothing here removes PC binding.  Bill, 2026-08-25: "binding stays."
"""
import copy
import os
import sys

import docx

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, "Masters", "GatewayGuard_License-2026-08-24-1210.docx")
DST = os.path.join(ROOT, "Masters", "GatewayGuard_License-2026-08-25-1400.docx")
TWIN = os.path.join(ROOT, "ProjectDocs",
                    "GatewayGuard_License-2026-08-25-1400-TEXT.md")

EM = u"—"          # em dash
LQ, RQ = u"“", u"”"   # curly double quotes
AP = u"’"          # curly apostrophe

doc = docx.Document(SRC)
paras = doc.paragraphs
assert len(paras) == 101, "base is not the 1210 master (paras=%d)" % len(paras)

applied = []


def anchor(i, must_contain):
    """Verify paragraph i still says what we think before touching it."""
    got = paras[i].text
    assert must_contain in got, (
        "ANCHOR FAILED at para %d\n  expected to contain: %r\n  actual: %r"
        % (i, must_contain, got[:200]))
    return got


def rebuild(i, parts, label):
    """Replace paragraph i with parts = [(text, bold_or_None), ...],
    cloning run 0's formatting so font, size and style survive."""
    p = paras[i]
    assert p.runs, "para %d has no runs" % i
    model = p.runs[0]._r
    keep = copy.deepcopy(model)
    for r in list(p.runs):
        r._r.getparent().remove(r._r)
    for text, bold in parts:
        new_r = copy.deepcopy(keep)
        # strip any existing text nodes from the clone
        for t in new_r.findall(
                "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}t"):
            new_r.remove(t)
        p._p.append(new_r)
        run = p.runs[-1]
        run.text = text
        if bold is not None:
            run.bold = bold
    applied.append(label)


def insert_after(i, parts, label, style_from=None):
    """Insert a new paragraph after paragraph i, cloning the whole paragraph
    (style, spacing, indent) from paragraph style_from (default: i)."""
    model_idx = i if style_from is None else style_from
    model_p = paras[model_idx]._p
    new_p = copy.deepcopy(model_p)
    paras[i]._p.addnext(new_p)
    new_para = docx.text.paragraph.Paragraph(new_p, paras[i]._parent)
    # blank it, then fill
    keep = copy.deepcopy(new_para.runs[0]._r)
    for r in list(new_para.runs):
        r._r.getparent().remove(r._r)
    for text, bold in parts:
        new_r = copy.deepcopy(keep)
        for t in new_r.findall(
                "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}t"):
            new_r.remove(t)
        new_p.append(new_r)
        run = new_para.runs[-1]
        run.text = text
        if bold is not None:
            run.bold = bold
    applied.append(label)
    return new_para


# =====================================================================
# PASS 1 -- in-place replacements, by index, no shifting
# =====================================================================

anchor(0, "GATEWAYGUARD CHECKUP")
rebuild(0, [(u"GATEWAYGUARD LLC " + EM + u" PRODUCT LICENSE AGREEMENT", True)],
        "title -> LLC / PRODUCT (Cloud change 1)")

anchor(1, "Version 2.0")
rebuild(1, [(u"Version 2.4 " + EM + u" Revised following the attorney "
             u"consultation of August 4, 2026", None)], "version -> 2.4")

anchor(2, "Dated: 2026-08-07")
rebuild(2, [(u"Dated: 2026-08-25 14:00 ET", None)], "date header")

anchor(5, "Supersedes the draft dated August 4, 2026.")
rebuild(5, [(u"Supersedes GatewayGuard_License-2026-08-24-1210. The "
             u"2026-08-24-1820 and 2026-08-07-0726 drafts are withdrawn and "
             u"are not part of this chain " + EM + u" both removed PC "
             u"binding, which was not approved.", None)], "supersedes line")

anchor(8, "Six substantive changes were made.")
rebuild(8, [(u"This version applies the attorney" + AP + u"s comments from "
             u"the August 4 consultation, together with the pricing and "
             u"refund decisions taken since. Items still open are marked "
             u"DECISION NEEDED and appear in a shaded note.", None)],
        "change-log preamble")

# --- change-log entry 1: binding STAYS (Cloud change 5, kills the invented
#     attribution) + Bill's typed note "We will reissue for a small fee."
anchor(9, "PC binding has been removed.")
anchor(9, "withdrawn on the attorney's advice")
rebuild(9, [
    (u"1. PC binding stays, and now reads plainly.", True),
    (u" Checkup is still tied to the PC it is first run on, exactly as in "
     u"the August 4 draft. Only the wording changed. The old text led with "
     u"the mechanism " + EM + u" a hardware identifier recorded on first run "
     u"" + EM + u" which reads to a nervous buyer as a lock rather than a "
     u"license. Section 2 now leads with what the customer gets and what "
     u"happens when a PC is replaced. Moving a license to a replacement PC "
     u"carries a small fee, listed at gatewayguard.co. The attorney asked "
     u"that this clause be tested against Section 5 of the FTC Act, which "
     u"says nothing about physical hardware. That test is still outstanding.",
     None)], "change-log 1: binding stays, invented attribution removed")

# --- Bill's typed note: "Say MS may change"
anchor(12, "A severability clause has been added. Section 12.")
rebuild(12, [
    (u"4. A severability clause has been added.", True),
    (u" Section 13. If a court strikes one part of the agreement, the rest "
     u"survives.", None)], "change-log 4: severability is now Section 13")

anchor(13, "can change or reset security settings")
rebuild(13, [
    (u"5. The annual Windows update risk is now stated plainly.", True),
    (u" Section 8 tells the customer that Microsoft" + AP + u"s yearly "
     u"Windows 11 update may change or reset security settings, and "
     u"recommends running Checkup again after each one.", None)],
    "change-log 5: can -> may (Bill, typed in v2.2)")

# --- Section 1 (Cloud change 2) + components
anchor(19, "This agreement covers two separate products.")
rebuild(19, [(u"This agreement covers every product GatewayGuard LLC sells. "
              u"Today that is two products, each with its own terms. If we "
              u"release further products, this agreement covers those too, "
              u"and we will say in the product" + AP + u"s own description "
              u"which sections apply to it.", None)],
        "Section 1 covers all products (Cloud change 2)")

anchor(20, "delivered as a PowerShell script")
rebuild(20, [
    (u"GatewayGuard Checkup (" + LQ + u"Checkup" + RQ + u"):", True),
    (u" the Windows 11 security review program, delivered as a PowerShell "
     u"script together with the small starter file that runs it for you. "
     u"Covered in Sections 2 through 4.", None)],
    "Section 1: Checkup includes the launcher")

anchor(21, "a PDF document")
rebuild(21, [
    (u"The Guide:", True),
    (u" the GatewayGuard Windows Security Walkthrough Guide, supplied as PDF "
     u"files with identical wording in five print sizes. Covered in "
     u"Section 5.", None)],
    "Section 1: Guide is five print sizes")

# --- Section 2 binding block replaces "How many PCs."
anchor(25, "How many PCs.")
rebuild(25, [
    (u"The PC you install it on.", True),
    (u" Your license covers one (1) personal computer that you own or "
     u"control. The first time you run Checkup, it makes a note of the "
     u"computer it is running on, and your license belongs to that computer. "
     u"Nothing about you goes into that note " + EM + u" not your name, not "
     u"your email, not an account. It only identifies the machine.", None)],
    "Section 2: PC binding restored (Cloud change 3)")

# --- Section 2 Updates: prices out (Cloud change 6)
anchor(27, "$12.99 per update")
rebuild(27, [
    (u"Updates.", True),
    (u" This license covers the version you bought. You can run that version "
     u"as many times as you want, and we will never make your existing copy "
     u"stop working.", None)],
    "Section 2: Updates trimmed, prices removed (Cloud change 6)")

# --- old Q2(d) callout is answered by the price removal
anchor(28, "DECISION NEEDED")
anchor(28, "Q2(d)")
rebuild(28, [
    (u"DECISION NEEDED " + EM + u" Q2(d) is answered by the removal of "
     u"prices. The spliced sentence about an annual update subscription is "
     u"gone from Section 2, together with the figure it carried. Prices and "
     u"update terms now live at gatewayguard.co only. Nothing further is "
     u"needed unless the attorney wants the update offer described in the "
     u"agreement itself.", None)], "Section 2: Q2(d) callout resolved")

# --- Section 4 no-transfer bullet regains the migration carve-out (change 4)
anchor(38, "Share, sell, rent, lend, give away, or transfer Checkup")
rebuild(38, [
    (u"Share, sell, rent, lend, give away, or transfer Checkup or any copy "
     u"of it to anyone else. Moving your own license to your own replacement "
     u"PC, as described in Section 2, is not a transfer and is always "
     u"allowed.", None)],
    "Section 4: PC-migration carve-out (Cloud change 4)")

# --- Section 8: Bill's "may change"
anchor(72, "those updates can change or reset security settings")
rebuild(72, [
    (u"We do not promise that the settings you approved will stay in place "
     u"after Windows updates. Microsoft releases a major Windows 11 update "
     u"every year, and those updates may change or reset security settings. "
     u"We recommend running Checkup again after each annual Windows update "
     u"so you can see what changed and approve any settings you want turned "
     u"back on.", None)], "Section 8: can -> may (Bill, typed in v2.2)")

# --- renumber the three sections that move down by one
anchor(84, "12. If Part of This Agreement Cannot Be Enforced")
rebuild(84, [(u"13. If Part of This Agreement Cannot Be Enforced", None)],
        "renumber 12 -> 13")
anchor(86, "13. Ending This License")
rebuild(86, [(u"14. Ending This License", None)], "renumber 13 -> 14")
anchor(88, "14. Contact")
rebuild(88, [(u"15. Contact", None)], "renumber 14 -> 15")

# --- appendix: the FTC test is live again, binding is back
anchor(94, "Removing PC binding in this version makes that test moot.")
rebuild(94, [
    (u"PC binding versus the FTC Act.", True),
    (u" The attorney noted the Federal Trade Commission Act, 15 U.S.C. "
     u"" + u"§§" + u" 41" + EM + u"58, says nothing about physical "
     u"hardware, and asked that the binding clause be tested against Section "
     u"5 (15 U.S.C. " + u"§" + u" 45), which prohibits unfair or "
     u"deceptive acts or practices in or affecting commerce. Binding is in "
     u"this version, so the test is live. The Maine consumer-protection "
     u"question on hardware-bound software comes with it, and both belong in "
     u"the refund consultation rather than a separate call " + EM + u" for a "
     u"buyer whose PC died on day 31, binding and refunds are one "
     u"conversation.", None)], "appendix: FTC test live again")

anchor(95, "a mechanism for changing terms in future versions")
rebuild(95, [
    (u"Clauses considered and not added.", True),
    (u" Question 11 of the August 4 cover note listed arbitration, "
     u"entire-agreement, assignment, age and export restrictions, and a "
     u"mechanism for changing terms in future versions. The consult notes "
     u"record only severability as the answer. The terms-change mechanism is "
     u"now drafted as Section 12 and needs review. The other four are still "
     u"not in this draft. Confirm they were declined rather than simply not "
     u"reached.", None)], "appendix: terms-change now drafted")

anchor(99, "GatewayGuard_License-2026-08-07-0726")
rebuild(99, [(u"GatewayGuard_License-2026-08-25-1400  |  Dated: 2026-08-25 "
              u"14:00 ET  |  Version 2.4  |  Last editor: Claude Code "
              u"(CGDELL)", None)], "footer")

# =====================================================================
# PASS 2 -- insertions, DESCENDING index so nothing shifts under us
# =====================================================================

# --- Section 14 (was 13) vs Section 9 contradiction: flag, do not patch
anchor(87, "does not entitle you to a refund except as described in Section 9")
insert_after(87, [
    (u"DECISION NEEDED " + EM + u" Section 14 and Section 9 do not agree. "
     u"" + LQ + u"Ending the license does not entitle you to a refund except "
     u"as described in Section 9" + RQ + u" was written when Section 9 was a "
     u"sales-are-final rule with three named exceptions. Section 9 is now an "
     u"unconditional 30-day refund with nothing to point at, so a customer "
     u"whose license ended for breach appears to be pointed at a full refund "
     u"right. A carve-out here is exactly the hedge the August 22 decision "
     u"warns against " + EM + u" " + LQ + u"no questions asked earns its "
     u"keep only if there are none." + RQ + u" This is for the attorney, "
     u"not for us.", None)],
    "Section 14: contradiction flagged", style_from=62)

# --- NEW Section 12, Changes to This Agreement, before old 12 (now 13)
anchor(84, "13. If Part of This Agreement Cannot Be Enforced")
# All four go in against para 83 (Section 11's body) in REVERSE order, because
# insert_after always lands immediately after its anchor and `paras` is the
# ORIGINAL list -- index 84 is still the severability heading, not the new one.
insert_after(83, [
    (u"DECISION NEEDED " + EM + u" the terms-change clause is new and "
     u"unreviewed. Question 11 of the August 4 cover note listed " + LQ +
     u"a mechanism for changing terms in future versions" + RQ + u" and the "
     u"consult notes record only severability as answered. This clause is "
     u"drafted from scratch. It is deliberately narrow: a change applies "
     u"only to a later purchase, never to one already made. Confirm or "
     u"replace.", None)],
    "Section 12: DECISION NEEDED", style_from=62)
insert_after(83, [
    (u"A change never applies backwards. The terms you agreed to when you "
     u"bought stay in force for that purchase. If you buy again later "
     u"" + EM + u" an annual update, another product, or another PC "
     u"" + EM + u" the terms posted at that time apply to the new purchase.",
     None)], "Section 12: no retroactive change", style_from=85)
insert_after(83, [
    (u"We may change these terms from time to time " + EM + u" for example, "
     u"to reflect a change in the law, in how we sell our products, or in "
     u"how a refund is handled. The current version of this agreement is "
     u"always posted at gatewayguard.co.", None)],
    "Section 12: we may change terms", style_from=85)
insert_after(83, [
    (u"12. Changes to This Agreement", None)],
    "new Section 12 heading", style_from=84)

# --- Section 8: third-party software + no borrowed code
anchor(73, "Checkup is built so that the changes you approve can be undone.")
insert_after(73, [
    (u"No other company" + AP + u"s code is inside Checkup.", True),
    (u" Checkup is our own work. It contains no third-party code and no "
     u"open-source components. It uses features that are already built into "
     u"Windows.", None)], "Section 8: no borrowed code", style_from=73)
insert_after(73, [
    (u"Other companies" + AP + u" software.", True),
    (u" Checkup checks and changes settings that belong to Windows, and it "
     u"can detect and open Malwarebytes if you have it installed. We do not "
     u"supply, own, or support those products. Your use of them is governed "
     u"by their own terms, not by this agreement, and we are not responsible "
     u"if Microsoft changes how a Windows setting behaves after you buy.",
     None)], "Section 8: third-party software", style_from=73)

# --- Section 2: fixes to your version + the annual update paragraph
anchor(27, "we will never make your existing copy stop working")
insert_after(27, [
    (u"Microsoft releases a major Windows 11 update most years. When that "
     u"happens we offer an updated version of Checkup that keeps pace with "
     u"the changes. The updated version is a separate purchase and is "
     u"entirely optional " + EM + u" skipping it does not affect the copy "
     u"you already own. Current prices and terms are listed at "
     u"gatewayguard.co.", None)],
    "Section 2: annual update, no price", style_from=26)
insert_after(27, [
    (u"Fixes to your version.", True),
    (u" If we issue a correction to the version you bought " + EM + u" a fix "
     u"for a defect, not a new annual version " + EM + u" you are licensed "
     u"to run it, at no charge. A new annual version for a new Windows "
     u"release is a separate product and a separate purchase.", None)],
    "Section 2: fixes to your version", style_from=27)

# --- Section 2 binding block: 3 more paragraphs + 2 callouts after para 25
anchor(25, "your license belongs to that computer")
insert_after(25, [
    (u"DECISION NEEDED " + EM + u" the license move needs a price and a way "
     u"to do it. Bill" + AP + u"s instruction of 2026-08-25 is that a "
     u"license move carries a small fee rather than being free and "
     u"unlimited. The amount is not set, and it is not written here because "
     u"prices do not belong in a contract. Two things are outstanding: the "
     u"amount, published at gatewayguard.co, and a way to actually perform "
     u"the move. Measured on build ascii43: Checkup computes a machine "
     u"identifier and displays it, but never compares it to anything, so "
     u"there is at present nothing to reissue. Section 2 states the one-PC "
     u"rule as a term of this agreement and makes no claim about what the "
     u"software enforces.", None)],
    "Section 2: reissue callout", style_from=28)
insert_after(25, [
    (u"DECISION NEEDED " + EM + u" multi-PC terms. Whose machines a pack "
     u"covers is still open: one household, one person, or any PC the buyer "
     u"owns. The packs run to $79.99, which is enough money that a buyer "
     u"will read this sentence carefully.", None)],
    "Section 2: multi-PC callout", style_from=28)
insert_after(25, [
    (u"If you bought a multi-PC pack.", True),
    (u" A 3-PC, 5-PC, or 10-PC pack covers that many computers. Each one is "
     u"noted separately, the same way, and the same move applies to each.",
     None)], "Section 2: multi-PC packs", style_from=25)
insert_after(25, [
    (u"When you get a new computer.", True),
    (u" Computers fail and people replace them. When that happens, email us "
     u"at support@gatewayguard.co and we will move your license to the new "
     u"PC. There is a small fee for the move, listed at gatewayguard.co. We "
     u"are not going to make you prove anything " + EM + u" if you tell us "
     u"your old PC is gone, that is good enough for us.", None)],
    "Section 2: moving to a new PC, small fee", style_from=25)
insert_after(25, [
    (u"We do this for one reason: it is what lets us sell Checkup once, at a "
     u"price a household can afford, instead of charging a monthly fee to "
     u"cover copies being passed around.", None)],
    "Section 2: why we do it", style_from=26)

# --- Section 1: what comes with each product, and the log file
anchor(22, "Buying one product does not give you a license to the other.")
insert_after(22, [
    (u"Your log file is yours.", True),
    (u" Checkup writes a record of what it found and what you approved to a "
     u"file on your own computer. That file belongs to you. It is never sent "
     u"to us, and we cannot read it unless you choose to send it to us.",
     None)], "Section 1: log file ownership", style_from=22)
insert_after(22, [
    (u"What comes with each product.", True),
    (u" Your Checkup license covers the script, the starter file that "
     u"launches it, and any correction we issue for that same version. Your "
     u"Guide license covers all five print sizes " + EM + u" they are one "
     u"product, not five, and the one printed copy Section 5 allows is one "
     u"copy of the size you choose.", None)],
    "Section 1: components", style_from=22)

# --- change-log entries 7 to 10, after entry 6
anchor(14, "6. A section on the programs review has been added.")
insert_after(14, [
    (u"10. What comes with each product is now listed, and other companies"
     u"" + AP + u" software is addressed.", True),
    (u" Section 1 says that a Checkup license covers the starter file as "
     u"well as the script, that the Guide" + AP + u"s five print sizes are "
     u"one product, and that your log file belongs to you. Section 8 states "
     u"that we do not supply, own, or support Windows or Malwarebytes, and "
     u"that Checkup contains no third-party or open-source code.", None)],
    "change-log 10: components and third parties", style_from=14)
insert_after(14, [
    (u"9. A section on changing these terms has been added.", True),
    (u" Section 12. Terms may change, the current version is posted at "
     u"gatewayguard.co, and a change never applies backwards to a purchase "
     u"already made. This was on the August 4 list and was never reached.",
     None)], "change-log 9: terms-change clause", style_from=14)
insert_after(14, [
    (u"8. The agreement now covers fixes to the version you bought.", True),
    (u" Section 2 said only that the license covers " + LQ + u"the version "
     u"you bought," + RQ + u" which left a correction to that same version "
     u"looking like a different version nobody had bought. Corrections are "
     u"now free. A new annual version is still a separate purchase.", None)],
    "change-log 8: fixes to your version", style_from=14)
insert_after(14, [
    (u"7. Prices have been removed from the agreement.", True),
    (u" The August 4 draft named a figure for updates in Section 2 and "
     u"referred to an annual update subscription. Both are gone. A price in "
     u"a contract has to be amended like a contract, and three surfaces "
     u"stating the same number will eventually disagree. Section 2 now says "
     u"an updated version exists and is optional, and points to "
     u"gatewayguard.co. The subscription reference also contradicted the "
     u"decision of August 22 that there is one renewal product, a yearly "
     u"update, with no multi-year plans.", None)],
    "change-log 7: prices removed", style_from=14)

# --- appendix: nobody is ever shown or accepts this agreement
anchor(95, "Clauses considered and not added.")
insert_after(95, [
    (u"Nothing shows this agreement to the buyer, and nobody accepts it.",
     True),
    (u" Measured on build ascii43 on 2026-08-25: the words " + LQ + u"license "
     u"agreement," + RQ + u" " + LQ + u"EULA," + RQ + u" " + LQ + u"terms of "
     u"use," + RQ + u" " + LQ + u"accept the terms" + RQ + u" and " + LQ +
     u"I agree" + RQ + u" appear nowhere in Checkup, and no page on "
     u"gatewayguard.co carries this agreement. The launch plan of August 2 "
     u"carries " + LQ + u"EULA posted" + RQ + u" as a critical task, and "
     u"posted is not the same as accepted. How a buyer accepts this "
     u"agreement " + EM + u" at Gumroad checkout, on a license page linked "
     u"from the receipt, on Checkup" + AP + u"s first screen, or some "
     u"combination " + EM + u" is the first question for the attorney, "
     u"because every other question here assumes a contract the buyer "
     u"entered into.", None)],
    "appendix: nobody is shown or accepts it", style_from=95)

# =====================================================================
# SAVE + READ-BACK
# =====================================================================
doc.save(DST)

check = docx.Document(DST)
text = "\n".join(p.text for p in check.paragraphs)

must_be_gone = [
    u"withdrawn on the attorney's advice",
    u"$12.99 per update",
    u"annual update subscription, if offered",
    u"PC binding has been removed",
    u"GATEWAYGUARD CHECKUP " + EM + u" LICENSE AGREEMENT",
]
must_be_present = [
    u"GATEWAYGUARD LLC " + EM + u" PRODUCT LICENSE AGREEMENT",
    u"1. PC binding stays, and now reads plainly.",
    u"your license belongs to that computer",
    u"There is a small fee for the move",
    u"Fixes to your version.",
    u"12. Changes to This Agreement",
    u"A change never applies backwards.",
    u"No other company" + AP + u"s code is inside Checkup.",
    u"Other companies" + AP + u" software.",
    u"What comes with each product.",
    u"Your log file is yours.",
    u"Nothing shows this agreement to the buyer, and nobody accepts it.",
    u"13. If Part of This Agreement Cannot Be Enforced",
    u"14. Ending This License",
    u"15. Contact",
    u"Version 2.4",
]
fail = []
for s in must_be_gone:
    if s in text:
        fail.append("STILL PRESENT: %r" % s)
for s in must_be_present:
    if s not in text:
        fail.append("MISSING: %r" % s)

# "can change or reset" must be gone in both places
if u"can change or reset security settings" in text:
    fail.append("STILL PRESENT: 'can change or reset security settings'")

# order check: the new Section 12 heading, its body, then Section 13
def idx(needle):
    for n, p in enumerate(check.paragraphs):
        if needle in p.text:
            return n
    return -1


i12 = idx(u"12. Changes to This Agreement")
ibody = idx(u"We may change these terms from time to time")
iback = idx(u"A change never applies backwards.")
idec = idx(u"the terms-change clause is new and unreviewed")
i13 = idx(u"13. If Part of This Agreement Cannot Be Enforced")
if not (0 < i12 < ibody < iback < idec < i13):
    fail.append("SECTION 12 OUT OF ORDER: heading=%d body=%d back=%d dec=%d "
                "sec13=%d" % (i12, ibody, iback, idec, i13))
if u"A severability clause has been added. Section 12." in text:
    fail.append("STALE CROSS-REF: severability still says Section 12")

if fail:
    print("READ-BACK FAILED")
    for f in fail:
        print("  " + f)
    sys.exit(1)

# --- twin ---
lines = ["<!-- Dated: 2026-08-25 14:00 ET -->",
         "<!-- Editor: Claude Code (CGDELL) -->",
         "<!-- Generated from Masters/GatewayGuard_License-2026-08-25-1400.docx"
         " by Tool2/build_license_v24_2026-08-25.py -->",
         "# GatewayGuard LLC - Product License Agreement (v2.4) - readable twin",
         "",
         "**This file is generated. Edit the .docx master, then regenerate.**",
         ""]
for p in check.paragraphs:
    t = p.text.rstrip()
    st = p.style.name if p.style is not None else "NONE"
    if not t:
        lines.append("")
    elif st == "Heading 1":
        lines.append("## " + t)
        lines.append("")
    elif st == "Heading 2":
        lines.append("### " + t)
        lines.append("")
    elif st == "List Paragraph":
        lines.append("- " + t)
    else:
        lines.append(t)
        lines.append("")
with open(TWIN, "w", encoding="utf-8") as fh:
    fh.write("\n".join(lines) + "\n")

print("OK  %d changes applied" % len(applied))
for a in applied:
    print("    - " + a)
print("\nmaster: %s  (%d paragraphs)" % (os.path.basename(DST),
                                         len(check.paragraphs)))
print("twin  : %s" % os.path.basename(TWIN))
