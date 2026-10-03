<!-- Dated: 2026-08-25 14:35 ET -->
<!-- Editor: Claude Cloud -->
# Licence research -- the fourteen questions of 2026-08-25, answered

- **Document Name:** GatewayGuard_CloudResearch-Licence
- **Last Modified:** 2026-08-25 14:35 ET
- **Last Editor:** Claude Cloud
- **Machine:** CGDELL
- **Status:** RESEARCH AND CHANGE LIST. Not a governing document. Amends no rule.
- **Answers:** `GatewayGuard_CloudResearchBrief-Licence-2026-08-25-1400.md`, all fourteen
- **Written under:** `GatewayGuard_CloudWorkingRules-2026-08-25-1400.md`

---

## PROVENANCE -- RULE 6

```
Base file      : GatewayGuard_License-2026-08-25-1400-TEXT.md (v2.4)
                 CURRENT.md row "Licence agreement (EULA)". 4 older versions present.
                 Master it is generated from: Masters/GatewayGuard_License-2026-08-25-1400.docx
How I read it  : .md twin only. The .docx master is not indexed and I cannot open it.
                 I also did not read the twin as a whole file -- connector search returns
                 relevance-ranked fragments, so I assembled it from repeated queries.
Could not see  : Section 2's "Fixes to your version" and "Updates" paragraphs; the opening
                 recital of Section 1 in full; Section 6's closing bullets and its Q9
                 callout as they stand in v2.4; all formatting, shading, tracked changes.
Sync stamp     : Generated 2026-08-25 14:01 ET | cd1199f | made 2026-08-25 11:10 ET |
                 "Three no-reissue mechanisms tested -- and nobody ever accepts this agreement"
```

**On the sentinel wording, corrected before it hardens.** What I ran at session start was a
**heading match against the session log** -- I found the newest heading in my snapshot and it
matched what was written at 14:00. `CURRENT.md` names no sentinel mechanism; the only
occurrence of the word in the live set says the stamp *replaced* a sentinel. I called it a
sentinel check and that label was wrong. It is a heading match, and as evidence it is
stronger than the stamp: the stamp proves which commit generated `CURRENT.md`, the heading
proves the payload arrived.

---

## STEP 2 -- THE BASE, AND ITS `CURRENT.md` ROW

| | |
|---|---|
| Base I built on | `GatewayGuard_License-2026-08-25-1400-TEXT.md` |
| `CURRENT.md` row | **Licence agreement (EULA)** -- same filename, 4 older versions present |
| Match | **Yes.** No discrepancy. |

Also read and matched to their rows: `GatewayGuard_CloudResearchBrief-Licence-2026-08-25-1400.md`,
`GatewayGuard_CloudWorkingRules-2026-08-25-1400.md`, `GatewayGuard_CloudHandoff-2026-08-25-0921.md`,
`GatewayGuard_Decisions-RefundAndTerms-2026-08-22-1510.md`,
`GatewayGuard_AttorneyConsult2-Revised-RefundAndGumroad-2026-08-25-1010.md`,
`GatewayGuard_LicenceUpdateMechanisms-2026-08-25-1115.md`,
`GatewayGuard_LicenceVsEulaNorms-2026-08-25-1045.md`.

The 1210, 0726, 0921 and 0120 licence twins surfaced in search. **I read them only to answer
step 4 -- what is carried forward -- and drew no operative content from them.**

---

## STEP 4 -- SENTENCES I CARRY FORWARD FROM AN OLDER DRAFT, AND WHAT EACH WAS CHECKED AGAINST

A previous draft is not a source. Every factual claim below that predates this session is
listed with the primary source it was checked against, or marked **not verified**.

| Claim I rely on | Primary source checked |
|---|---|
| Bill decided binding stays, 2026-08-25 | Claude Code's brief, reporting Bill directly this session. **I have no verbatim record.** See question 6 at the end |
| Bill typed *"We will reissue for a small fee"* | `SessionLog` 2026-08-24 to 25, quoting the note found in the 0921 `.docx`. Claude Code read the file |
| Checkup never compares the machine ID to anything | Claude Code, ***measured on ascii43***, `Get-MachineIdentity` line 3140, header comment line 3139. **I cannot verify this and do not assert it independently** |
| Nothing shows the agreement to a buyer and nobody accepts it | Claude Code, ***measured on ascii43 and `WebSite/`***, 2026-08-25. Same caveat |
| Refund is 30 days, no questions asked; hedges banned | `GatewayGuard_Decisions-RefundAndTerms-2026-08-22-1510.md` -- a decision document, not a draft |
| Annual update $12.99 a year; bundle $29.99 once | `GatewayGuard_PriceDecision-Annual-2026-08-21-1445.md`, `GatewayGuard_PriceDecision-GuideAndBundle-2026-08-23-1816.md`. **Context only; no figure enters the agreement** |
| The attorney's only recorded comment on binding was the FTC Act section 5 test | `GatewayGuard_AttorneyConsultNotes-Bill-VERBATIM-2026-08-04-1200-TEXT.md`, item 5 |
| *"Withdrawn on the attorney's advice and Bill's judgment"* | **Not verified, and known false.** The sentence Rule 4 exists for. It is in the 0726 and 1210 drafts. **It is not in v2.4 and must not return** |

---

## STEP 5 -- WHAT I COULD NOT SEE, AND WHAT IT MIGHT CHANGE

1. **The `.docx` master.** Formatting, callout shading, tracked changes and comments are
   invisible to me. **Every change below is written as a text anchor**, so it can be applied
   by script against the master without my having seen it.
2. **Section 2's "Fixes to your version" and "Updates" paragraphs.** These are the exact
   subject of question 8 and I never retrieved their v2.4 text. **Change block 6 is written
   conditionally and must not be applied blind.**
3. **Section 1's opening recital in full.** I have the acceptance sentence from the preamble
   but not the surrounding v2.4 paragraph. **Block 1 carries a grep precondition.**
4. **Bill's Gumroad screens.** Question 2 rests on Gumroad's help documentation, not on what
   Bill sees in his account.
5. **Whether Gumroad has been given the end user licence terms.** Nothing in the repository
   says it has. See the headline.

---
---

# THE HEADLINE, AND IT CHANGES THE SHAPE OF THE ANSWER

**Gumroad's own Terms of Service already require GatewayGuard to supply this agreement, and
already provide the mechanism that makes it bind.** Both halves are in the contract Bill
agreed to when he opened the account.

*Sourced, `https://gumroad.com/terms`, read 2026-08-25.* **Section 6.7** provides that
although Gumroad is the authorised reseller and merchant of record, each product resold
through the service is licensed by the supplier **through** Gumroad to the buyer; that the
supplier **shall provide Gumroad with the end user licence terms** for its products; and that
the supplier **authorises Gumroad to present them to each buyer in a manner that creates a
binding contract** between supplier and buyer. **Section 6.9(c)** has the supplier warrant
that the information and documentation it provides for each product, **including the end user
licence terms, is correct and current.**

**Read together, the position today is not neutral. It is negative.** The agreement is
unwritten into the one channel Gumroad's terms say is where it gets written, and a warranty
is being given about a document that has not been supplied.

**The good news is that the fix is a form field, not a build.** See question 2.

**One dated item nobody has flagged.** Gumroad's terms carry an effective date of 2026-01-01
and a last-updated date of **2026-08-17**, and the page states that accounts existing when
those changes were posted **become bound by them on 2026-09-16.** Launch is 2026-09-01.
**The terms Bill sells his first copy under are not the terms his account is bound by two
weeks later.** Worth one question to the attorney, and worth Bill reading the diff himself.

---
---

# PART A -- HOW A BUYER ACCEPTS

## 1. How does a downloadable-software buyer become bound to a EULA in the US?

### What the research says

**The doctrine has consolidated around two elements, and they are always the same two:
reasonably conspicuous notice of the terms, and an unambiguous act manifesting assent to
them.** Clickwrap, browsewrap and sign-in-wrap describe where a design sits on that spectrum.
They are not separate legal tests.

- ***Specht v. Netscape***, 306 F.3d 17 (2d Cir. 2002). The pole nearest our present position.
  Judge Sotomayor held that clicking a download button does not communicate assent to
  contractual terms where the offer did not make clear that clicking would signify assent.
  Terms reachable only by scrolling below the download button did not bind.
- ***Nguyen v. Barnes & Noble***, 763 F.3d 1171 (9th Cir. 2014). Browsewrap terms were not
  enforceable merely because hyperlinks appeared near transactional buttons. Users are not
  bound by inconspicuous terms without actual or constructive notice **and some act showing
  assent.**
- ***Meyer v. Uber***, 868 F.3d 66 (2d Cir. 2017). The other pole, and it is a design lesson
  rather than a legal one: an uncluttered payment screen, with text directly below the
  buttons saying that creating an account meant agreeing to the terms, and a blue underlined
  link. Enforced. The court judged the process from the standpoint of a **reasonably prudent
  user of that kind of interface.**
- ***Berman v. Freedom Financial Network*** (9th Cir. 2022) supplies the current working test.
  Pure browsewrap -- where the user takes no affirmative action at all -- struggles to satisfy
  its second prong, and the test has pushed designs toward **a visible terms link plus a
  button the user must click, with adjacent language saying that clicking means agreeing.**
- **Post-purchase terms are the genuinely split area**, and it matters because Checkup is
  delivered after payment. ***ProCD v. Zeidenberg***, 86 F.3d 1447 (7th Cir. 1996) reversed a
  holding that all licence terms must be visible before purchase, and held shrinkwrap licences
  enforceable unless objectionable on grounds applicable to contracts generally. **The
  contract forms not at purchase but when the user clicks "I Agree" in the software**, and the
  ability to return the product instead is what makes that fair. ***Klocek v. Gateway*** and
  ***Step-Saver*** run the other way, splitting on whether objective manifestation of consent
  suffices.
- **Records of assent are part of the requirement in practice.** A company must be able to
  produce evidence that the user actually accepted, which means preserving the record of
  acceptance and of any later amendments accepted. Uber produced undisputed evidence.

### Applied to GatewayGuard as it stands

The agreement's own acceptance sentence is *"By downloading, installing, or running any
GatewayGuard product, you agree to these terms."* **On Claude Code's measurement that
sentence is currently addressed to nobody** -- the document is not shown at checkout, not on
the website, not in the build.

**That is not weak browsewrap. It is a term with no notice event at all**, which fails
*Specht* and *Nguyen* on the first element before assent is reached, and cannot reach the
*ProCD* analysis either, because *ProCD* turns on the buyer being shown the terms and
clicking.

### The minimum that reliably binds

1. Terms **displayed or one click away** at the moment of purchase, on an uncluttered screen;
2. an **affirmative act** by the buyer -- a tick, or a button whose label or adjacent text
   says clicking means agreeing;
3. the seller **keeps the record** of who accepted and when.

### Recommendation

**Bind at checkout, and treat anything in the product as reinforcement rather than as the
contract.** Checkout is the only moment where all three elements are available to us today,
and question 2 says the mechanism is already built.

---

## 2. What can Gumroad actually do? -- **this is the answer to question 1 in practice**

### What Gumroad's documentation says

*Sourced, Gumroad Help Center, "Checkout customization", read 2026-08-25.* Gumroad supports
custom fields at checkout in three kinds -- textbox, checkbox, and **Terms**. The **Terms**
field takes **the URL of the seller's terms, which customers must accept before purchasing**,
and the field is **always set to "Required."** Each custom field can be applied to all
products or a subset, and **the custom field information is accessible in the Sales tab and
the sales CSV.**

**Read that against the three elements in question 1 and it satisfies all three.** A required
field at checkout is the affirmative act. The URL is the notice. The Sales tab and CSV are
the record of assent -- **the element a solo seller usually cannot produce, and therefore the
most valuable of the three.**

And the platform contract expects exactly this: Gumroad's section 6.7 authorises Gumroad to
present the supplier's end user licence terms to each buyer **in a manner that creates a
binding contract.** **The Terms custom field is the operational form of that clause.**

### The constraint that comes with it

Two limits on what our own terms may say, both from Gumroad's supplier obligations
(*sourced, `https://gumroad.com/terms`*):

- **Section 11.2(d):** a supplier will not require or suggest that a buyer agree to any terms
  **that reduce or limit Gumroad's refunds, chargebacks and disputes section**, or otherwise
  interfere with Gumroad's rights. **Section 9's existing sentence acknowledging that Gumroad
  may refund under its own policy is not merely diplomatic -- it is what keeps us on the right
  side of this. Do not remove it, and add nothing that reads as narrowing it.**
- **Section 11.2(b):** suppliers must use best efforts to ensure communications and
  representations about their products are accurate and carry the disclosures needed to
  prevent them being false, deceptive or misleading, and comply with consumer-protection law.
  That is the store-page half of the discipline the copy gate already enforces.

### Recommendation

**Do this before launch. It is the cheapest item on the whole board.**

1. Publish the agreement at a stable URL -- `gatewayguard.co/license`.
2. Add a **Terms** custom field on both products pointing at that URL.
3. Make a test purchase and confirm the acceptance is recorded in the sales CSV.
4. **Keep the CSV.** It is the evidence of assent, and it is what will be asked for if the
   agreement is ever tested.

**One caveat, honestly stated.** I have this from Gumroad's help documentation, not from
Bill's screen. **Bill should confirm the field exists in his account before the launch plan
depends on it.** If it has moved or been renamed, the rest of the answer still holds: the
requirement is a required acceptance with a record, and section 6.7 obliges Gumroad to
provide a route to it.

---

## 3. What do comparable small publishers do?

**I could not audit five checkout flows without buying five products, so treat the pattern
rather than the roster as the finding.** Basis: **sourced** where a document is cited,
**inferred** where I am generalising.

| Publisher | Where the licence appears | Does the buyer do anything? |
|---|---|---|
| **Scooter Software** (Beyond Compare) | Full agreement on the website; also in the installer | Yes. The agreement's own recital says that unless a different signed agreement exists, **use of the software indicates agreement**, and a user who does not accept must stop using it immediately |
| **Binary Fortress** (DisplayFusion) | Website and installer licence page | Yes. The text is written to be read during installation -- it opens by asking the reader to read the terms carefully **"before continuing with this installation"**, and says that by installing, copying or otherwise using the software the user agrees to be bound |
| **GPSoftware** (Directory Opus) | Installer, then a first-run wizard | Yes. Opus uses a standard InstallShield installer; on first run an initialisation wizard asks a short series of configuration questions. The licence sits in the installer sequence |
| **Zibra AI** (sells via Gumroad) | A dedicated terms page **written for the Gumroad channel** | Yes, at checkout. Their Gumroad terms describe purchasing the licence on the product page and receiving a licence key on payment |
| **Tetrisly** (sells via Gumroad) | EULA published as a PDF, referenced from the listing | Their EULA states the licence may be purchased through Gumroad and that the fee is charged in accordance with Gumroad's terms |

### The pattern, and the one thing that makes us different

**Two of the five sell through Gumroad, and both wrote a licence that names the Gumroad
channel explicitly.** That is the closest comparable set to us, and neither relies on a buyer
stumbling across a website page.

**Everyone else in the desktop-utility world relies on the installer.** The installer licence
page is the standard clickwrap for desktop software: terms appear as installation starts and
the user must click an "I Accept" control to proceed. It is favoured because **it leaves no
doubt.** Every Inno, InstallShield and Advanced Installer product does it -- in Advanced
Installer, selecting an RTF file for the EULA inserts a licence-agreement dialog into the
sequence straight after the welcome screen.

**And this is precisely what GatewayGuard does not have.** Checkup ships as a `.ps1` plus a
`.bat` launcher. **There is no installer, so the industry-standard acceptance point does not
exist for us.** That is not an oversight -- it is a consequence of the delivery model that
makes the source readable, which is the product's whole trust argument. **It does mean
checkout is not our second-best option. It is our only conventional one.**

### Recommendation

Follow the two Gumroad sellers, not the three installer sellers: **a licence page written to
be accepted at checkout**, named in the store listing, enforced by the Terms field.

---

## 4. Is a first-run acceptance screen worth building?

### The legal half

**Once acceptance exists at checkout, a first-run screen adds very little legally, and what it
adds is not worth a build change eleven days out.**

The reasoning is the *ProCD* line read backwards. A second acceptance inside the software
matters **where the buyer had no chance to see the terms before paying** -- there, the
in-product click is what forms the contract, and the ability to return the product instead is
what makes it fair. **If the buyer already assented at checkout, the contract is already
formed and the screen re-confirms something that already binds.** Belt over braces.

One real benefit, stated fairly: **a second record of assent, from the machine rather than the
store.** If the Gumroad CSV were ever unavailable, that would matter. It is thin against a
build change.

### The product half, which is the stronger argument

**A modal acceptance gate on first run is the single most out-of-character screen this product
could ship.** Checkup's entire design is approval at each step, plain English, nothing happens
without a yes. **An "I agree to the End User Licence Agreement" wall in front of a
non-technical senior is the exact experience the product is positioned against** -- placed at
the moment of highest abandonment.

There is a defect-risk argument that should be decisive on its own. **The ascii43 field run
has not happened.** Adding a new first screen to an unrun build, in the week it freezes, puts
a new mandatory gate ahead of every existing screen -- and this project has already lost a
field run to a first-screen defect (FT-63's Mark-mode freeze) and carries an open unlocated
finding about something flashing before screen 1 (FT-184).

### Recommendation

**No acceptance screen for launch. Yes to a notice line.**

Ship one non-blocking line where the tool already introduces itself:

```
Your use of Checkup is covered by our license agreement, which you accepted when you
bought it. You can read it any time at gatewayguard.co/license.
```

**That is copy, not a gate.** It belongs in the F6 wording block, carries no keyboard-handling
risk, and does the one thing an in-product mention is good for -- telling a customer where the
terms are without standing in their way.

**If the attorney wants an in-product acceptance, it is an ascii44 item, not an ascii43 item.**
ascii44 is already the shipping build, so there is room for it.

---
---

# PART B -- PER-PC BINDING WITHOUT TECHNICAL ENFORCEMENT

## 5. Is a stated per-PC licence with no software enforcement common, and is it defensible?

### It is common, and the best comparable states it openly

*Sourced, `scootersoftware.com/kb/licensing`, read 2026-08-25.* Beyond Compare is licensed
per **user** rather than per PC, but the structural point is identical -- a stated scope with
no technical enforcement. **Each licensed user may use it on any number of computers; there is
no need to deactivate a licence on one machine before using it on another; licence management
is the customer's responsibility, and they say plainly they have no way to track who is using
a particular licence.** Asked how it works at all, **their answer is the honour system, and
that they simply trust customers to buy an appropriately sized licence.**

**That is our position exactly, in a product that has been sold for two decades.**

### Is it defensible? Yes -- and v2.4's wording is the reason

**The defensibility question is not about enforcement. It is about whether the sentence is
true.** A licence term is a promise the buyer makes; it needs a lock no more than "do not post
the source on a forum" needs one. Nothing in the research suggests an unenforced scope term
is void.

**Where it becomes indefensible is when the contract describes a mechanism that does not
exist.** The prior wording -- *"the Tool records a hardware identifier from the first PC it is
run on. After that first run, the Tool will only operate on that same PC"* -- is a statement
about **software behaviour.** On Claude Code's measurement of ascii43 it is false.

**v2.4's replacement is the right fix, and I want to be explicit that Claude Code overruled me
correctly.** *"The first time you run Checkup, it makes a note of the computer it is running
on, and your license belongs to that computer"* is a statement about **the licence.** It is
true. It carries the same commercial effect. **The wording I wrote would have put a false
factual claim into a consumer contract, and my own provenance caveat would not have caught it
-- because it was not carried from a draft. It was mine.**

**One residual risk, small but real.** *"It makes a note of the computer it is running on"* is
still a factual claim about behaviour. It is true -- the machine ID is computed and written to
the log. But a reader may take "makes a note" to mean the note is **enforced.** That is the
buyer's inference rather than our statement, and the sentence after it already limits the
claim. **I would leave it.** Adding *"this note is not used to stop Checkup running"* would be
honest and would also read as advertising that the rule is unenforced.

### How others word it

Two shapes worth copying:

- **The honour-system shape** -- state the scope, say plainly you cannot police it, ask for
  good faith. Scooter Software does this and it reads well. **v2.4 already does it in Section
  9:** *"We are aware we cannot check this, and we are not going to try."*
- **The plain-scope shape** -- state the scope, say nothing about enforcement. More common,
  and what most of Section 2 does.

### Recommendation

**Keep the clause as drafted. No change needed for question 5.** The one wording problem in
this area is a conflict with Section 4 -- change block 2.

---

## 6. FTC Act section 5 and Maine UTPA section 207 -- hardware-bound consumer software

**Routed to the attorney.** The brief says not to answer this as settled law. What follows is
the research to hand him, not a conclusion.

### The federal test

*Sourced, Maine Attorney General consumer-protection guidance, read 2026-08-25.* The Maine
UTPA is modelled on the FTC Act, and the unfairness test it recites is the federal one: an act
or practice is unfair if it **causes or is likely to cause substantial injury to consumers**
and **is not outweighed by countervailing benefits to consumers or competition.** On
deception, **"material" means important to consumers and hence likely to affect their choice
of, or conduct regarding, a product** -- and **a practice may be deceptive under the UTPA even
where the defendant had no intent to deceive.**

**That last clause is the one to put in front of the attorney.** Intent is not an element. The
question is not whether we meant to mislead; it is whether the statement is likely to affect a
buyer's decision and is not accurate.

### The Maine overlay, and why it is not a footnote

Maine is not a state where a UTPA claim is theoretical for a $19.99 product.

- **5 M.R.S. section 213** gives a private right of action to any person suffering an
  ascertainable loss of money or property. A successful plaintiff may recover **actual damages
  or $100, whichever is greater, plus attorney's fees and costs** -- a fee-shifting provision
  that lets low-value consumer claims proceed without contingency barriers.
- Section 213 also allows **statutory damages on top of actual damages**, and **treble damages
  for willful violations** -- though treble damages require proving willfulness.
- The limitation period is **six years.**
- ***Bartner v. Carter*** (Me. 1979): a private plaintiff under section 213 **cannot establish
  loss merely by showing a capacity or tendency to deceive.** The requirement of loss
  resulting from the wrongful act limits section 207 in private suits, even though courts
  interpreting section 207 are to be guided by federal decisions under section 5(a)(1).

**And one section heading the attorney should read in full, because I have not.** The chapter
index lists **5 section 214, "Waiver; public policy."** I have the heading, not the text. A
public-policy limit on waivers would bear directly on the liability cap in Section 10 and on
any limitation the agreement places on a buyer's remedies. **Not verified -- flag it as a
read-the-statute item rather than a finding.**

### Where the actual exposure sits, in my reading

**Not in the binding clause. In the pointer.** *(Inferred.)*

The binding rule as v2.4 states it is accurate. But *"There is a small fee for the move,
listed at gatewayguard.co"* is a **material term** -- it is the price of getting your product
back when your laptop dies -- **and it points at a page that does not exist.** A material term
whose content lives at an address with nothing at it sits closer to the deception test than
the binding rule does, and **it is the same defect shape as the Tamper Protection claim and
the drive-rescan claim.** See change block 3.

### What wording reduces exposure

1. **Do not describe behaviour the software does not have.** Already fixed in v2.4.
2. **Do not point at a page that does not exist.** Change block 3.
3. **Keep Section 9's refund sentence.** It is the countervailing-benefit half of the
   unfairness test in one sentence.

---

## 7. Licence transfer or reactivation fees

### The finding, and it does not support the current wording

**I looked for consumer software that charges its own customer to move a licence to that
customer's replacement machine, and what I found is a different practice with a similar name.**

Fees are common for **transfer to a third party** -- a resale. A representative clause charges
a **non-refundable transfer fee** and requires signed requests from **both** the outgoing and
incoming licensee; HP-branded software licences are transferable subject to prior written
authorisation and payment of applicable fees, with the transferee having to agree in writing
to the licence terms. **That is a fee for administering a change of *person*.**

Fees for a change of *machine* by the same person exist but are **enterprise** practice. One
vendor charges a licence transfer fee of **5% of the current price of the software
configuration** whenever a customer changes their system in a way that requires new licence
keys, including upgrading to a new machine. That is a 2200-series mainframe product.

Scooter Software, the closest comparable, **provides for a reinstatement fee at its
discretion** -- but their per-user licence means moving to a new computer **is not a licensed
event at all**, so the reinstatement provision is not doing this job. Moving machines requires
no deactivation and no contact with them. **Their answer to the dead-laptop case is that there
is no case.**

In the consumer-desktop and plugin markets, the pattern reported by users is that **most
vendors charge nothing**, and the ones that do are named as exceptions -- one survey names two
vendors that charge and seven that do not. **Low-quality source and I flag it as such**: a
forum thread from 2015. It is directionally consistent with everything else and I would not
build a decision on it alone.

### Consumer-protection limits

**No source I found establishes a rule against charging a fee to restore access to something
already bought.** The exposure is not a prohibition. It is the unfairness test in question 6,
plus the fact that the fee is published nowhere.

### The widow with the dead laptop

**The brief names the case the wording has to survive, so let me take it seriously.**

She writes in. Her husband bought Checkup. His laptop is gone. She is not the buyer, she does
not have the order number, and she is being asked for money to use something the household
already paid for. **Whatever the fee is, that email is a bad afternoon, and the wording of
Section 2 decides how bad.**

The current wording gets one thing exactly right and one thing wrong:

- **Right:** *"We are not going to make you prove anything -- if you tell us your old PC is
  gone, that is good enough for us."* **Keep every word.**
- **Wrong:** *"There is a small fee for the move, listed at gatewayguard.co."* **"Small" is
  not a price and the page is not there.** She now has to go and find out what she owes, at a
  URL that will not tell her.

### Recommendation

**The fee is Bill's decision and I am not reopening it.** But two things must happen before
this sentence ships, and one of them is a decision only Bill can make.

1. **Name the amount, or name where and when the buyer learns it.** Change block 3.
2. **Consider waiving it where charging looks worst** -- where the PC **failed** rather than
   was replaced by choice. **That is a support-policy line, not a contract line.** It does not
   need to be in the agreement, and putting it there invites argument about which is which.

**And one thing to check that is not a wording question at all: whether we can actually
perform the move.** On Claude Code's measurement the machine ID is never compared to anything,
so **there is nothing to reissue and nothing to unbind** -- the "move" today is an email
saying go ahead. **Charging for that is defensible if framed as an administrative charge; it
is harder to defend if a customer reads the source and finds nothing had to be done.**
*Not verified by me -- Claude Code should establish what a licence move consists of
operationally before a price is attached to it.*

---
---

# PART C -- UPDATES, VERSIONS AND CHANGING TERMS

## 8. The free-fix versus paid-new-version boundary

### How the industry draws it, and it draws it the same way every time

**The line is drawn with two defined terms, and the definitions do the whole job.**
*Sourced, standard EULA drafting practice:* **"Updates"** means minor updates, bug fixes,
patches and error corrections to the software; **"Upgrades"** means major new versions or
releases that add significant functionality. The same split in operative form: Updates are
new releases **of a particular version** providing enhancements or error corrections;
Upgrades are **new version releases.**

The commercial consequence, stated plainly in the perpetual-licence literature: **a perpetual
licence covers the specific version purchased, and major new versions typically require a
separate purchase or upgrade fee.** A customer whose maintenance lapses can still use the
software but is **version-locked** to the last version they were entitled to.

### Why this matters to our wording specifically

**Our boundary is unusual, and a buyer could genuinely argue about it.** The typical vendor's
new version arrives when the vendor decides to ship one. **Ours arrives on Microsoft's
schedule, to keep the product working against a changed Windows.** A reasonable buyer can
say: *"the yearly version exists because Windows broke the old one -- that is a correction,
not a new product."*

**The defence is not to argue about it. It is to define the trigger rather than the size of
the change.** A definition turning on "significant new functionality" invites exactly that
argument, because the annual version may add nothing a buyer would call a feature -- it may
just work again. **A definition turning on which Windows release the version is built for does
not.**

### Recommendation

Define both terms once, in Section 2, **on the Windows-release trigger.** Wording in change
block 6.

**One warning, and the brief already flags it.** The standard formulation is *"the Software,
including any updates, patches and replacement versions."* **Do not accept it.** It reads as
tidy boilerplate and it gives away the annual update, which is the whole renewal business.
**If a reviewer proposes it, the answer is the narrow definition, not a negotiation.**

---

## 9. Terms-change clauses in one-time-purchase consumer EULAs

**I have now read Section 12 in the twin. It is short, and my assessment is that it is right
-- and right for a stronger reason than "narrow is safer."**

### The standard shape, and why the standard shape would fail for us

Publishers do reserve broader rights. The near-universal formulation is that the vendor may
change the terms by posting the revised version and that **continued use constitutes
acceptance.** Terms of that shape are, in the literature's own words, **quite common.**

**And that formulation is exactly the one that fails without an account to notify through.**

***Douglas v. U.S. District Court (Talk America)***, 495 F.3d 1062 (9th Cir. 2007), is
directly on our facts. The court held that **a company cannot unilaterally change the terms of
a contract by posting a revised version online without providing notice**; that **customers do
not assent merely by continuing to use the service**; and that **a party has no obligation to
check a contract's terms to verify they have not changed**, because that monitoring is too
burdensome -- the customer would have had to check every day and compare every word against
his existing contract. **Implicit acceptance can only occur after the customer receives
notice**, which is why a customer emailed the changes who does not object may be bound.

That principle has held across circuits: **a unilateral modification posted only to the
company's site, without conspicuous direct notice, generally does not bind.**

### So the answer to "is narrow the standard shape?" is: no -- and that is the point

**The broad shape is standard and we could not use it.** We have no accounts, no logins, and
no relationship continuing after the download, so we have **neither the notification channel
*Douglas* requires nor the continued use it distinguishes.** A "we may change these terms by
posting them" clause in our agreement would be a clause we could never rely on.

**Section 12 as drafted does not try.** *"A change never applies backwards. The terms you
agreed to when you bought stay in force for that purchase. If you buy again later -- an annual
update, another product, or another PC -- the terms posted at that time apply to the new
purchase."*

**That is not a modification clause at all. It is a scoping clause**, and it sidesteps
*Douglas* entirely by never attempting to alter an existing bargain. Each purchase is its own
contract on the terms shown at that purchase. **There is nothing to notify, because nothing
changes for anyone who has already bought.**

### What is enforceable without an account

**The narrow form -- and its enforceability does not rest on Section 12 at all.** It rests on
the buyer accepting the then-current terms **at the next checkout**, which is the mechanism
answered in questions 1 and 2. **Section 12 does not create the binding. The Terms field does.
Section 12 tells the buyer that is how it works.**

### Recommendation

**Keep Section 12. Confirm it to the attorney rather than asking him to draft it.** One
sentence makes the mechanism explicit rather than implied -- change block 5.

---

## 10. Does the narrow form actually spare us a reissue?

**Yes, and cleanly -- provided one operational thing is true, which is where the risk actually
sits.**

### The 2027 case, worked through

A buyer accepts v2.4 at checkout in September 2026. In September 2027 they buy the annual
update. By then the agreement is at, say, v3.1.

- **Which agreement governs the 2027 purchase?** v3.1, because they accept v3.1 at that
  checkout. Section 12 says so in advance; the Terms field enforces it in the moment.
- **Which agreement governs the 2026 copy they are still running?** v2.4, permanently.
  Section 12's first sentence says so.
- **Does anything have to be reissued to anyone?** **No. No existing customer is ever asked to
  re-accept anything**, which is the entire benefit.

Two agreements now govern one household, **and that is fine** -- it is how every version-locked
perpetual licence works. The buyer's rights are version-locked to what they purchased.

### The operational condition, and it is a real one

**All of that depends on the Terms field pointing at the current agreement at the moment of
every sale.** If `gatewayguard.co/license` is updated to v3.1 while the Gumroad Terms field
still points at an archived v2.4, or the reverse, **the buyer accepts one document while we
believe they accepted another.** That is worse than having no clause, because it produces a
confident wrong answer.

**This is the pointer-that-lies failure, in the one place where it costs money** -- and this
project has been bitten by it often enough that it should be handled the way the repository
handles it: **by generation, not by memory.**

### Recommendation

Two mechanical items, neither a wording change:

1. **One URL, always current.** `gatewayguard.co/license` serves the live agreement. Archived
   versions live at dated URLs beneath it -- `/license/2026-08-25` -- so a buyer can always
   find the version they accepted. **The Terms field points at the live URL, never a dated
   one.**
2. **A dated archive copy is published at the same time as every version bump, and never
   afterwards.** A customer who bought under v2.4 must be able to read v2.4 in 2029.

**This belongs in a licence-version checklist in `ProjectDocs/`, not in the agreement.** It is
a process, and processes are Claude Code's.

---
---

# PART D -- DISCLAIMERS AND CLAIMS

## 11. Third-party disclaimers, and the Malwarebytes trademark question

### The disclaimer

**Section 8's new paragraph is good and covers what the standard wording covers.** It does the
three things a third-party clause exists to do: we do not supply, own or support them; their
own terms govern; we are not responsible if Microsoft changes a setting's behaviour after
purchase.

**One element the standard wording has and ours does not:** a statement that the third party
gives **no warranty and owes no obligation to the buyer through us.** Small addition, change
block 4.

### The trademark question -- naming Malwarebytes is fine, and here is why

**Naming it is nominative fair use.** *Sourced:* the test allows one party to refer to
another's trademark where **(1)** the product or service cannot be readily identified without
using the mark; **(2)** the user takes only as much of the mark as necessary -- **the words,
not the font or symbol**; and **(3)** the user does nothing to suggest sponsorship or
endorsement. **Compatibility claims -- statements that a product is suitable for use with
another brand's products -- qualify as nominative fair use.**

**We satisfy all three as drafted.** Checkup genuinely detects and opens Malwarebytes; there
is no other way to say so; we use the word only, no logo, no styling; and nothing suggests
endorsement.

**What is worth adding is the third factor's belt.** In one reported dispute, use of
"[Brand] Compatible" **prominently and without a nearby disclaimer** drew an allegation that
consumers would believe the product was endorsed or sponsored. The conventional cure is an
attribution line: **name the mark, identify it as the trademark of its owner, and disclaim
association.**

**Note what that means for the marketing copy, not just the agreement.** The agreement's use
is descriptive and buried in a disclaimer -- the safest possible placement. **A store page or
flyer that puts "Works with Malwarebytes" in a headline is the prominent use that attracted
the complaint.** *(Inferred, and worth a line in the copy rules.)*

### Recommendation

Add a short trademark attribution sentence to Section 8 -- change block 4. **Do not remove the
Malwarebytes name.** Removing it makes the disclaimer vaguer without making it safer, and the
product does what the sentence says it does.

---

## 12. Is "contains no third-party code and no open-source components" a claim worth making?

### My answer: **no, not in that form. Narrow it.**

**The instinct behind the claim is good, and the claim as written is riskier than it looks.**

**What is right about it.** It is not decoration. This product's entire trust argument is *you
can read every line*, and a buyer who reads the file and finds a borrowed library would feel
misled. Saying "this is our own work" is consistent with everything else GatewayGuard says.

**Three reasons the absolute negative is the wrong form:**

1. **It is a claim that can only ever become false, never more true.** Every future build is
   an opportunity to break it. One `Add-Type` of a helper class, one borrowed regex carrying a
   licence header, one contractor -- and a sentence in the customer contract is wrong. **The
   agreement is the worst place in the business for a claim that decays**, which is exactly
   why the prices were taken out of it three weeks ago, for the same reason.
2. **It is unverified by this project's own standard.** Claude Code's measurement covers
   `Add-Type` usage. **`Add-Type` is one route of several** -- dot-sourcing,
   `Invoke-Expression`, embedded base64, a copied function with no attribution, a snippet from
   a forum. **Claude Code's own earlier note said the same thing:** *"I have not audited the
   file for borrowed code, and this is a contract. Do not publish it on my belief."* **That
   warning was right and the `Add-Type` scan has not retired it.**
3. **Nobody in the comparable set makes it.** Scooter Software goes the other way and says so
   openly: **Beyond Compare has been created with the help of a number of open source
   libraries**, whose source is available on their respective websites. **The industry norm is
   to disclose dependencies, not to warrant their absence.** A claim we do not need is a claim
   that can be wrong later.

**And the phrase carries a specific hazard for us.** "No open-source components" sits one word
away from `MarketingPlan`'s banned open-source family and from ExpertPositioning's *"GatewayGuard
is not open-source."* **Two nearby sentences using "open source" to mean two different things
-- what we are not, and what we contain none of -- is how a copy gate produces a false pass and
how a reader gets confused.**

### Recommendation

**Replace the absolute negative with a positive statement of what Checkup uses.** True, more
informative, cannot decay the same way, and a better trust statement. Change block 4.

**If Bill wants the stronger claim, it is available at a price:** a real dependency audit,
filed in `Test_Results/`, re-run as a gate on every build. **That is a build-gate project, not
a sentence**, and my recommendation is not to spend the eleven days on it.

---
---

# PART E -- REFUNDS

## 13. Gumroad as merchant of record

**Answered from Gumroad's own contract.** The commercial consequences are research; the legal
allocation between us, Gumroad and the buyer is the attorney's, per the brief.
*All citations sourced from `https://gumroad.com/terms`, read 2026-08-25.*

### Who is the seller of record

**Gumroad, unambiguously, and by our own appointment.** **Section 6.1:** the supplier appoints
Gumroad as its non-exclusive reseller and **acknowledges that Gumroad is the merchant of
record** for the resale of the supplier's products, and that **the supplier shall not issue
any invoice or make any demand for payment to any buyer** in relation to a completed resale.

**Section 6.2:** Gumroad is treated as the seller for indirect tax purposes and provides tax
collection, reporting and remittance; and **provides buyers with first-tier post-sale support
covering invoicing, refund requests, chargebacks, disputes and payment reconciliation.**

**But the licence is still ours.** Section 6.7: each product resold **is licensed by the
supplier through Gumroad to the buyer.**

**So the structure is two contracts, and it is worth Bill holding this clearly:** the **sale**
is between the buyer and Gumroad; the **licence** is between the buyer and GatewayGuard LLC.
**Section 9 straddles them**, which is why it has to acknowledge Gumroad's policy rather than
override it.

### Who owes the refund

**Gumroad pays it and we fund it. Section 7.1(a):** Gumroad handles buyers' requests for
refunds, chargebacks and other disputes **in Gumroad's sole discretion**; the supplier must
provide information Gumroad requests; and **the supplier is responsible for reimbursing
Gumroad for the amount of any monies paid to buyers or third-party providers in connection
with refunds, chargebacks or disputes, as well as any other reasonable costs** Gumroad incurs
resolving them.

**Note "in Gumroad's sole discretion."** Our 30-day promise is a promise about what **we** will
do. It does not constrain Gumroad, and **Gumroad may refund where we would not.**

### The chargeback exposure, and it is the part that should get Bill's attention

**Refunding generously is not free, and the cost is not the refunds. Section 11.3(b):**

- **Above a 15% refund rate**, the supplier authorises Gumroad to **hold in reserve 25% of
  unsettled funds for 90 days on a rolling basis** to offset future refunds.
- **Above 25%**, the account **may be suspended, terminated, or made subject to additional
  conditions or fees.**

And a broader discretionary power sits on top. **Section 11.3(c):** Gumroad may hold any or
all unsettled funds and may pause, decline, delay or reduce any payout where it has reason to
believe transactions present **an elevated risk of chargeback, refund, dispute or loss**, or
that **a supplier's products or marketing are misleading**, and **no fixed or maximum hold
period applies.**

**Read that against the launch plan.** A tiny sales base makes the percentage volatile --
**on the first twenty sales, four refunds is 20%.** A no-questions-asked policy on a
low-volume account is far more likely to cross 15% than the same policy on a large one, and
crossing it puts a quarter of the money behind a 90-day wall.

**This is not an argument against the refund policy.** It is an argument for **expecting the
threshold in the first months and not being alarmed by it.**

Two smaller points for the call:

- **Section 6.3:** Gumroad **reserves the right to set the price** at which a product is
  offered for resale, notwithstanding the supplier's suggested retail price. Probably never
  exercised; worth knowing it exists, given the UNIT RULE work and the store copy.
- **Section 7.2(b):** if a buyer requests a refund **and also** pursues a dispute with their
  payment provider for the same transaction, **Gumroad declines the refund request.** Useful
  for support: **tell a customer to ask us, not their bank.**

### Recommendation

**No change to the agreement.** Section 9 is already correct on all of this -- it names
Gumroad as handling payment, admits Gumroad's policy may run longer, and preserves the
buyer's consumer-law rights. **That paragraph is doing real work and should not be touched.**

Three items, none of them contract wording:

1. **Bill:** expect a refund-rate reserve in the first months; do not treat it as a fault.
2. **Attorney:** confirm the two-contract structure is described accurately in Section 9, and
   whether the agreement should say explicitly that Gumroad's terms govern the **payment**
   while ours govern the **licence.**
3. **Attorney:** the 2026-09-16 change to Gumroad's own terms, noted in the headline.

---

## 14. Does a 30-day no-questions refund change the binding analysis?

**Routed to the attorney for the legal half.** The commercial half I can answer, and my answer
is that **the refund does less work than we have been assuming.**

### The argument as we have been making it

The refund is the practical protection that makes binding tolerable. Buy it, run it, and if
the one-PC rule does not suit you, take your money back within 30 days.

**That argument is sound and it maps onto the unfairness test.** Question 6 quotes it:
substantial injury not outweighed by countervailing benefits. **An unconditional 30-day refund
is a countervailing benefit, and it is the strongest single fact in our favour.**

### But it only covers the first thirty days, and the case that hurts is on day 400

**The brief names the case and it is the right one to design around: the refund window has
closed and the PC has died. What is the buyer left with?**

Today, on the documents:

- The licence belongs to a computer that no longer exists.
- The refund window closed thirteen months ago.
- To use the product again they must write in and pay a fee whose amount is not published.
- **And Checkup will in fact run perfectly well on the new machine**, because on Claude Code's
  measurement nothing enforces the rule.

**Which produces the sentence nobody wants to have to answer:** a customer who reads the
source -- which we invite them to do, and which is the selling point -- can discover that the
fee buys them nothing they did not already have.

**That is the real exposure in this document, and it is not a refund question or a binding
question. It is the interaction of the two with a fee.** Binding without enforcement is
honest. A refund window is generous. **A fee to restore access that was never actually
withdrawn is the piece that does not fit** -- and it is the piece a Maine UTPA claim would aim
at, given the fee-shifting provision in question 6.

### What I recommend, and it is Bill's call not mine

**Three routes. I am not choosing; I am naming the trade.**

| | What it is | What it costs | What it buys |
|---|---|---|---|
| **A** | **No fee.** Licence moves are free, on request, no proof | The revenue from a rare event | Removes the problem entirely. The widow email becomes a one-line yes |
| **B** | **Fee, published, waived on hardware failure** | A support judgment on each request | Keeps the fee for genuine convenience moves; the sympathetic case never pays |
| **C** | **Fee, published, no exceptions** | The day-400 conversation above | Simplicity, and the revenue |

**My recommendation is B, and A if Bill would rather not run a judgment call.** The fee is
Bill's decision of 2026-08-25 and I am not asking him to reverse it -- **but "small fee,
listed at gatewayguard.co" is not yet a decision. It is a placeholder**, and it has to become
one of these three before the agreement can be shown to anyone.

**For the attorney, framed as a question:** does an unenforced per-PC term **combined with a
fee to move it** change the FTC section 5 / UTPA section 207 analysis, relative to the same
term with no fee?

---
---
---

# THE NUMBERED CHANGE LIST

**Against `Masters/GatewayGuard_License-2026-08-25-1400.docx`, v2.4.** Anchors quoted from
`GatewayGuard_License-2026-08-25-1400-TEXT.md`.

**No `.docx` is produced.** Every block is a text anchor plus replacement text, so it can be
applied by an assert-guarded script against the master.

**Sections 13 and 14 are not touched. No refund hedge is added anywhere. The product
definition is not broadened.**

---

### BLOCK 1 -- the acceptance recital. **Apply only after the Gumroad Terms field is set up.**

**Why:** the current recital names three acts -- downloading, installing, running -- and none
is presented to the buyer with notice. Once the Terms field is live, the recital should name
the act the buyer actually performs. **This is the whole of question 1.**

**Precondition:** grep the master for `you agree to these terms` and confirm **exactly one**
occurrence. **If more than one, stop and report** -- I could not see the full Section 1
recital.

**Currently:**

> This agreement is between you ("you") and GatewayGuard LLC, a Maine limited liability company ("GatewayGuard," "we," or "us"). By downloading, installing, or running any GatewayGuard product, you agree to these terms. If you do not agree, do not use the product.

**Replace with:**

```
This agreement is between you ("you") and GatewayGuard LLC, a Maine limited liability
company ("GatewayGuard," "we," or "us").

You accept this agreement when you buy a GatewayGuard product. The version shown to you
at checkout is the version that covers your purchase, and it is also posted at
gatewayguard.co/license. If you do not agree to it, do not buy or use the product.
```

**Note for the attorney, not for the document:** this assumes acceptance happens at checkout
and nowhere else. **If he wants a second acceptance in the product, the sentence changes and
it becomes an ascii44 build item** -- question 4.

---

### BLOCK 2 -- Section 4's no-transfer bullet contradicts Section 2's fee

**Why:** Section 4 says the move is **"always allowed"**; Section 2 conditions it on a fee.
Read together, a buyer can argue the move is unconditional and the fee is not payable.
**Section 4 is the operative permissions list, so on a strict reading Section 4 wins.**

**Currently, first bullet of Section 4:**

> Share, sell, rent, lend, give away, or transfer Checkup or any copy of it to anyone else. Moving your own license to your own replacement PC, as described in Section 2, is not a transfer and is always allowed.

**Replace with:**

```
Share, sell, rent, lend, give away, or transfer Checkup or any copy of it to anyone
else. Moving your own license to your own replacement PC is not a transfer, and this
bullet does not prevent it -- see Section 2 for how to do that.
```

**This is the one change on the list I would call mandatory regardless of what else is
decided.** It is an internal contradiction in a contract going to an attorney.

---

### BLOCK 3 -- Section 2, the fee points at a page that does not exist. **Bill decides first.**

**Why:** questions 6 and 14. A material term whose content lives at a URL with nothing at it.
**Same defect class as the Tamper Protection claim and the drive-rescan claim** -- the
document promises what the surfaces cannot deliver.

**Currently, in Section 2 under "When you get a new computer":**

> There is a small fee for the move, listed at gatewayguard.co.

**Three replacements. Bill picks one -- this is the route A / B / C decision from question 14.**

**3a -- no fee (route A):**

```
There is no charge for this.
```

**3b -- fee, published, waived on hardware failure (route B, recommended):**

```
There is a charge of $[AMOUNT] for the move, which covers our time. We do not charge it
when the old PC failed rather than being replaced by choice -- if your computer died,
just tell us that.
```

**3c -- fee, published, no exceptions (route C):**

```
There is a charge of $[AMOUNT] for the move, which covers our time.
```

**Whichever is chosen, `gatewayguard.co` must not be the answer to "how much."** A price
living only on a page nobody has built is not a term. **UNIT RULE: the figure carries "once,
per move."**

**Cross-file sync in the same edit:** change-log entry 1 currently reads *"Moving a license to
a replacement PC carries a small fee, listed at gatewayguard.co."* **The entry and Section 2
must not disagree.**

---

### BLOCK 4 -- Section 8, the two third-party paragraphs

**Why:** questions 11 and 12. Adds the trademark attribution nominative fair use rewards, and
removes an absolute negative that can only decay.

**Currently:**

> Other companies' software. Checkup checks and changes settings that belong to Windows, and it can detect and open Malwarebytes if you have it installed. We do not supply, own, or support those products. Your use of them is governed by their own terms, not by this agreement, and we are not responsible if Microsoft changes how a Windows setting behaves after you buy.
>
> No other company's code is inside Checkup. Checkup is our own work. It contains no third-party code and no open-source components. It uses features that are already built into Windows.

**Replace with:**

```
Other companies' software. Checkup checks and changes settings that belong to Windows,
and it can detect and open Malwarebytes if you have it installed. We do not supply, own,
or support those products, and they give you no promises through us. Your use of them is
governed by their own terms, not by this agreement, and we are not responsible if
Microsoft changes how a Windows setting behaves after you buy.

Windows and Microsoft Defender are trademarks of Microsoft Corporation. Malwarebytes is
a trademark of Malwarebytes Inc. We name them here only to say what Checkup works with.
Neither company is connected with GatewayGuard LLC, and neither has endorsed, sponsored,
or reviewed Checkup.

Checkup is our own work. It is written in PowerShell and it uses the features already
built into Windows to do its job. You can read every line of it in any text editor,
which is the point.
```

**What changed and why:**

| Change | Reason |
|---|---|
| *"and they give you no promises through us"* | The one element the standard third-party clause has that ours lacked |
| The whole trademark paragraph | Question 11. Names the owners, uses the words only, disclaims endorsement -- the three nominative-use factors, in the order courts apply them |
| **"It contains no third-party code and no open-source components" is DELETED** | Question 12. Unverified beyond an `Add-Type` scan, decays with every build, and sits beside a banned marketing phrase. **This is a deletion, not a softening -- do not replace it with a hedged version** |
| *"You can read every line of it"* replaces the negative | Says the same thing to the buyer, is verifiable, and is the product's actual trust argument |

**If Bill wants the stronger claim back, the price is a dependency audit filed in
`Test_Results/` and re-run as a build gate.**

---

### BLOCK 5 -- Section 12, one sentence to make the mechanism explicit

**Why:** question 9. Section 12 is right and I recommend it be confirmed rather than
redrafted. But it describes an outcome without naming the moment that produces it, and **the
moment is the whole enforceability story under *Douglas*.**

**Currently, second paragraph of Section 12:**

> A change never applies backwards. The terms you agreed to when you bought stay in force for that purchase. If you buy again later -- an annual update, another product, or another PC -- the terms posted at that time apply to the new purchase.

**Replace with:**

```
A change never applies backwards. The terms you agreed to when you bought stay in force
for that purchase, for as long as you use what you bought. We will never ask you to
accept new terms for something you have already paid for.

If you buy again later -- an annual update, another product, or another PC -- you will
be shown the terms in force at that time, and those terms cover that new purchase.
Nothing you do or do not do in the meantime changes the terms of a purchase you have
already made.
```

**Then update the DECISION NEEDED beneath it**, which currently ends *"Confirm or replace."*

**Replace that last sentence with:**

```
Confirm. Cloud's research of 2026-08-25 recommends keeping the narrow form. The standard
broad form -- terms change by posting, continued use is acceptance -- is unenforceable
against buyers we have no way to notify, and we have no accounts and no logins. Douglas
v. U.S. District Court (Talk America), 495 F.3d 1062 (9th Cir. 2007) is on these facts:
a party has no duty to check a contract for changes, and assent can only be inferred
after notice. The narrow form avoids the problem instead of losing to it.
```

---

### BLOCK 6 -- Section 2, the update boundary. **CONDITIONAL. DO NOT APPLY BLIND.**

**Why:** question 8. The free-fix versus paid-version boundary should turn on the Windows
release, not on how big the change is, or a buyer can argue the annual version is a
correction.

**I did not retrieve the v2.4 text of the "Fixes to your version" and "Updates" paragraphs.**
All I know of them is Claude Code's summary in the brief and change-log entry 8. **Rule 3 says
what you cannot read, you do not rebuild.**

**So this block is a proposal, not an instruction.** Read both paragraphs in the master and
decide whether the wording below adds anything they do not already do. **If it is already
covered, drop this block and say so.**

**Proposed, to close the "Fixes to your version" paragraph:**

```
Here is where we draw the line, in plain terms. A correction is a fix to the version you
bought, for the Windows release it was built for -- those are free and always will be. A
new annual version is built for a new Windows release, after Microsoft ships one. That
is a separate product and a separate purchase, and you never have to buy it: the version
you have keeps doing what it did the day you bought it.
```

**Why the trigger is Microsoft's release and not the size of the change:** our new version
exists **because Windows changed**, so it may add nothing a buyer would call a feature. **A
definition resting on "significant new functionality" invites the argument that the annual
version is really a fix.** A definition resting on which Windows release it targets does not.

**Do not accept the boilerplate alternative** -- *"including all updates, patches and
replacement versions"* -- if a reviewer proposes it. It gives away the annual update.

---

### BLOCK 7 -- the Appendix, two lines now out of date

**7a. Currently, in "Clauses considered and not added":**

> The other four are still not in this draft. Confirm they were declined rather than simply not reached.

**Replace with:**

```
The other four -- arbitration, entire agreement, assignment, and age and export
restrictions -- are still not in this draft. Confirm they were declined rather than
simply not reached. Two are worth a moment each. An entire-agreement clause is cheap and
would settle which of the store listing, the website and this document controls if they
ever disagree, which is a live risk for us. An arbitration clause is a real decision
rather than boilerplate, because Gumroad already requires arbitration of disputes
between the buyer and Gumroad -- so a buyer with a complaint about a $19.99 purchase may
face two different dispute paths depending on whether the complaint is about the sale or
about the license.
```

**7b. Currently, at the end of "Nothing shows this agreement to the buyer, and nobody accepts
it":**

> ...is the first question for the attorney, because every other question here assumes a contract the buyer entered into.

**Add immediately after it:**

```
Cloud's research of 2026-08-25 recommends acceptance at Gumroad checkout, and it is
available today without a build change. Gumroad's Terms of Service section 6.7 requires
a supplier to provide its end user license terms and authorizes Gumroad to present them
to each buyer in a manner that creates a binding contract between supplier and buyer,
and section 6.9(c) has the supplier warrant that those terms are correct and current --
so the platform contract already both requires this agreement and provides the mechanism
for it. Gumroad's checkout supports a required "Terms" custom field taking the URL of
the seller's terms, which the buyer must accept before purchasing, with acceptance
recorded in the Sales tab and the sales CSV. That record of assent is the element a solo
seller usually cannot produce, and it is the most valuable part.

A first-run acceptance screen inside Checkup adds little once acceptance exists at
checkout, and it is the most out-of-character screen this product could ship. It is not
recommended for launch.
```

---

### BLOCK 8 -- not a document change. Three things Bill does, in this order.

```
1. Publish the agreement at gatewayguard.co/license.
   Nothing else on this list works until the URL resolves.

2. Add a required "Terms" custom field at Gumroad checkout, on BOTH products, pointing
   at that URL. Confirm the field exists in the account first -- Cloud has this from
   Gumroad's help documentation, not from your screen.

3. Make a test purchase and check that the acceptance appears in the sales CSV.
   Keep the CSV. It is the evidence that the agreement binds.
```

**That is the whole of the acceptance fix.** No build change, no new screen, no attorney
needed to start.

---
---

# QUESTIONS, HELD TO THE END AS INSTRUCTED

1. **Route A, B or C on the licence-move fee?** *(Question 14, block 3.)* **Nothing in
   Section 2 can ship until this is answered** -- "a small fee, listed at gatewayguard.co" is
   a placeholder pointing at a page that does not exist. My recommendation is **B**: publish
   the amount, waive it when the old PC failed.

2. **What is the amount?** Block 3 carries `$[AMOUNT]` and I will not guess a price. **UNIT
   RULE: it carries "once, per move."**

3. **Does the Gumroad "Terms" custom field exist in your account, and does it look the way the
   help documentation describes?** *(Question 2.)* I have it from Gumroad's documentation, not
   your screen. **Everything in Part A rests on it.**

4. **Was the Gumroad payout method connected?** The session log has it blocking publishing and
   on the critical path. Not a licence question, but upstream of the test purchase in block 8
   and of every refund question in Part E.

5. **Do you want the "contains no third-party code and no open-source components" claim back?**
   *(Question 12, block 4.)* I recommend deletion. Keeping it means funding a dependency audit
   filed in `Test_Results/` and re-run as a build gate. **Deleting it costs nothing a buyer
   would notice.**

6. **Is there a verbatim record of your 2026-08-25 decision that binding stays?** *(Step 4.)*
   I am carrying it from Claude Code's brief. **The last time a binding decision rested on a
   report rather than your words, the record carried an invented attribution for eighteen
   days.** One line in the VERBATIM file closes it permanently.

7. **Did you mean the Checkup+Guide bundle or the multi-PC packs** when you typed *"No bundles
   initially - remove mention of them just make sure it covers all sold copies"*? *(Session
   log section 7; still unapplied.)* Section 1 currently says *"A bundle purchase covers
   both."* **If bundles are not launching, that sentence describes a product that does not
   exist**, and it interacts with the open DECISION NEEDED on what the bundle grants.

8. **Section 7, the programs review -- does it ship on 2026-09-01?** The DECISION NEEDED says
   that if it does not, **the whole section comes out of the launch agreement.** That is a
   deletion with a deadline, and ascii43 is not finished.

9. **The Guide has no per-PC rule and no move fee** -- Section 5 licenses it across the
   household. Checkup has both. **Is that deliberate?** Defensible on the facts (a PDF cannot
   be bound to a machine), but the two products now answer "what did I buy?" very differently,
   and the packs run to $79.99.

10. **Should the archived-agreement discipline from question 10 become a checklist document in
    `ProjectDocs/`?** One live URL, dated archives, the Gumroad field always pointing at the
    live one. **It is the pointer-that-lies failure in the one place where it costs money**,
    and this project's answer to that has always been to generate rather than remember. I did
    not write it because it is a governing process, and those are yours.
