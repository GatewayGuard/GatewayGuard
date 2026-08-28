# Our licence compared against two real ones -- what to add, what to reject

# Dated: 2026-08-28 13:30 ET

**Our agreement:** `GatewayGuard_License-2026-08-25-1400-TEXT.md`, **v2.4**,
15 sections plus an Appendix of open items.

**Compared against, both read in full this session:**

1. **Malwarebytes** -- `Migration\MB\MB EULA.pdf`, 36 pages, 16 sections.
   **The real comparator:** US consumer security software, sold to households,
   and we name them on our own screens.
2. **"Master Zhuan Zhuan"** -- `ProjectDocs\End User License Agreement.docx`.
   ***measured:*** **Xiamen Yinlemei Information Technology Co., Ltd.**, a
   Chinese video-editing publisher (the Filmora people). 20 sections plus an
   annex.

**No edits were made to our agreement.** Everything below is an *addition*, and
additions to a contract with an attorney review pending are Bill's call and the
attorney's, not something to slip in. **Drafts are ready on request.**

---

## 0. A FILE THAT IS NOT WHAT ITS NAME SAYS

`ProjectDocs\Eula-other files .zip` sounds like a collection of other companies'
agreements. ***measured:*** it holds **nine files, all ours**, from 2026-07-26 --
an old `GatewayGuard_License`, the CPM schedule, LegalZoom guides, a
project-files backup. **Rename it.** Anyone reaching for comparison material
will open it and lose ten minutes.

---

## 1. THE THREE EXAMPLES BILL WAS SENT DESCRIBE A DIFFERENT BUSINESS

Bill received a note citing **Articulate**, **VMware/Broadcom** and
**Microsoft** as publishers who bundle software and documentation under one
agreement, with a recommendation to do the same.

**Those three bundle documentation WITH a product.** Their manuals are a
companion to something you bought. Under a unified "Licensed Products" term,
buying the software gets you the docs.

**We sell the Guide as its own product.** Section 1 says so:

> *"Buying one product does not give you a license to the other. A bundle
> purchase covers both."*

**Adopting a unified term would say the opposite of what we sell** -- it would
give the Guide away with every Checkup purchase. **Rejected, and the reason is
commercial, not stylistic.**

**Our structure is already what those examples are praised for**: Section 1
names both products and which sections apply to each, Sections 2-4 cover the
software, Section 5 covers the Guide. **It also does something none of the
three does** -- Section 1 says the log file belongs to the customer, is never
sent to us, and cannot be read by us unless they send it.

**On Microsoft's "names the exact edition":** ours handles it better, by
pointer rather than hardcoding -- *"supported Windows 11 versions listed at
gatewayguard.co/compatible on the date you bought it."* Same reasoning that
took prices out of the contract. **See section 5 for the problem with that.**

---

## 2. THE ZHUAN ZHUAN AGREEMENT IS NOT A MODEL. THREE CLAUSES WOULD HARM US

**Do not borrow from this one.** It was read in full; these are the reasons.

| Their clause | Why it is wrong for us |
|---|---|
| **§2:** *"Sharing the Software with others, **or allowing others to view the contents of this Software**, is in violation of the License."* | **The exact opposite of our Section 2**, which says *"Open it, read it, and inspect it as much as you like."* Readable source is a selling point for a security tool bought by nervous people. **Importing this would remove a reason to trust us.** |
| **§19 Licensee Publicity Rights** | Lets the vendor use the buyer's name in marketing. Wrong for a household product. |
| **§16 Indemnification** | Makes the buyer cover the vendor's legal costs. Against a household consumer in Maine that reads badly and is largely unenforceable. |

---

## 3. MALWAREBYTES, SECTION BY SECTION -- WE COVER 13 OF 16

| Malwarebytes | Ours |
|---|---|
| 1 License | **Section 2** |
| 2 Restrictions | **Section 4** |
| 3 Ownership | **Sections 2, 5** |
| 4 Updates | **Section 2** |
| 5 Term | **Section 14** |
| 6 Payment Terms | **Section 9** (refunds); prices live on the website |
| **7 Privacy and Data Protection** | **MISSING -- see section 4** |
| 8 Limited Warranty | **Section 6** |
| 9 Limitation of Liability | **Section 10** |
| 11 Export Laws | In our Appendix, undecided |
| 12 Agreement to Arbitrate | In our Appendix, undecided |
| **13 Feedback; Marketing** | **MISSING -- see section 4** |
| 14 General | **Sections 11, 13** |
| 15 Audit Rights | **Not applicable.** Theirs is Teams-only -- auditing business device counts. We have no enforcement mechanism to audit against: ***measured on ascii43***, `Get-MachineIdentity` computes a hash and never compares it to anything |
| 16 Contact Us | **Section 15** |

**Four gaps are already ours and already known.** The Appendix records
arbitration, entire-agreement, assignment, age and export restrictions as
*"considered and not added... Confirm they were declined rather than simply not
reached."* **Malwarebytes carries arbitration and export laws, so both are
normal for this market. That Appendix question is still the right one and it is
for the attorney.**

---

## 4. TWO GENUINE GAPS, NEITHER PREVIOUSLY RECORDED

### 4a. Feedback -- small, cheap, and a solo developer will need it

**Malwarebytes §13:** ideas, suggestions or recommendations a customer sends
become theirs to use freely.

**We have nothing.** Bill is one person whose buyers will email
`support@gatewayguard.co` saying *"you should also check X."* Some of those will
ship. **Without this clause, a customer who suggested a feature has an argument
that they contributed to the product.**

Three sentences. No cost to the customer. **Recommended.**

### 4b. Privacy -- the word appears zero times, and no policy exists

**Malwarebytes §7** binds the buyer to a policy at a named URL.

***measured:*** **"privacy" appears zero times in our agreement**, and no privacy
policy exists on the site.

**The product privacy story is strong** -- Section 1 says the log file is the
customer's, never sent, unreadable by us. **The gap is the business side:**
Gumroad collects buyer names, emails and billing data; the site exists;
`support@` receives mail. **And the Appendix already plans a customer email list
scaling to 100,000 addresses.**

**That list needs a policy behind it before it exists, not after.**

---

## 5. TWO PAGES THE AGREEMENT PROMISES THAT ARE NOT THERE

***measured: no page matching `compat*` anywhere in `WebSite\`.***

**Section 6's warranty is defined by reference to a page that does not exist:**

> *"Checkup runs on supported Windows 11 versions listed at
> gatewayguard.co/compatible on the date you bought it."*

Section 6's **exclusions** lean on it again -- *"PCs with hardware not listed on
our compatible PC list."*

**A warranty pointing at a missing page is worse than no pointer: the promise
itself is undefined.**

**`gatewayguard.co/license` does not exist either**, and the Gumroad checkout
plan depends on it -- the Terms field at checkout must point somewhere.

**Both must exist before anything is sold.**

---

## 6. THE ONE-PRINTED-COPY RULE FIGHTS THE REASON THE FIVE SIZES EXIST

**A decision for Bill. Both answers are defensible.**

Section 5 grants: *"Read and use the Guide on any personal computer in your home"*
and forbids sharing *"outside your household"* -- so the household is treated as
one unit. **But:** *"Print one copy for your own use,"* and Section 1 nails it
down -- *"the one printed copy Section 5 allows is one copy of the size you
choose."*

***measured, our own pricing page:*** *"It comes in five sizes, from compact to
extra-large print. Pick the one..."*

**The sizes are a vision accommodation.** So a couple where one needs
extra-large and the other does not can legally print **one** of them. For a
product aimed at seniors, **printing is exactly what they will do.**

**This is the one idea worth borrowing from VMware** -- *a reasonable number of
copies for internal use*.

**Three defensible answers:** one printed copy per licence; one per person in
the household; or "a reasonable number for your own household." **Cheap to get
wrong in the customer's favour, expensive to get wrong in ours.**

---

## 7. WHAT IS STILL OPEN, IN ORDER

1. **Publish `/compatible` and `/license`.** Both are promised; neither exists.
   **Blocks selling.**
2. **The printed-copy decision** (section 6). One word from Bill.
3. **Feedback clause** (4a) -- draft on request.
4. **Privacy policy** (4b) -- needed before the email list, not after.
5. **The Appendix's four** -- arbitration, entire-agreement, assignment, export.
   **Confirm with the attorney they were declined rather than simply not
   reached.**
6. **The second margin note** in the licence file -- a bare *"Remove"* after the
   programs-review entry. **Still not guessed at.** Remove Section 7, or remove
   that change-log entry? Two very different edits.
7. **Multi-PC pack scope** -- one household, one person, or any PC the buyer
   owns. The packs run to $79.99, which is enough that a buyer will read the
   sentence carefully.
