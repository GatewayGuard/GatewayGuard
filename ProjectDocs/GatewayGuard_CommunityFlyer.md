<!-- Dated: 2026-08-15 13:50 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# GatewayGuard Community Flyer -- readable text

- **Document Name:** GatewayGuard_CommunityFlyer
- **Last Modified:** 2026-08-15 13:50 ET
- **Source of record:** `ProjectDocs/GatewayGuard_CommunityFlyer.docx`
- **Status:** Extraction. The `.docx` remains the master file.

---

## THREE THINGS THE READER SHOULD KNOW BEFORE REWRITING THIS

**1. The `.docx` is not a Word document.** measured 2026-08-15: its first bytes
are `**IS YOUR HOME C`, not a ZIP signature. It is **2,238 bytes of plain
Markdown with a `.docx` extension**. Every tool in this repository treated it
as an opaque binary and skipped it, and `build_marketing_sourcepack.py`
crashed with `BadZipFile` on the first attempt to extract it.

**That mislabelling is why Cloud has never been able to read this flyer.** It
was not a scope problem or a sync problem. The file was readable text the whole
time, wearing the wrong extension. **Consider renaming the master to `.md` and
retiring the `.docx`** -- there is nothing in it that needs Word.

**2. `build_readable_twins.py` skipped it for a reason that was not true.** It
carried the entry *"covered by build_marketing_sourcepack.py"*. measured
2026-08-15: the string `CommunityFlyer` appeared **zero times** in that pack,
because the flyer was never in its `SOURCES` list. A skip with a false reason
is worse than no skip, because it stops anyone looking again -- and this one
survived from the day that file was written.

**3. The text below has one live copy breach**, flagged and deliberately NOT
fixed here, because rewriting the marketing copy is Cloud's job and this file
is an extraction:

- *"...to **switch off** aggressive background data collection..."* --
  **"switch" as a verb is banned**, unconditionally, since Bill withdrew the
  last exemption on 2026-08-12. It must read **"turn off"**. Checkup itself
  says "turn on/off" 23 times and Windows Settings says "Turn on"; RULE D-18
  makes the product's vocabulary the vocabulary.

**Encoding was repaired.** The source is UTF-8 stored as if it were
Windows-1252, so every dash rendered as `a-hat-euro-dash` and every apostrophe
as `a-hat-euro-tm`. Curly punctuation is normalised to ASCII here, per this
project's `--` convention.

---

## THE FLYER TEXT

**IS YOUR HOME COMPUTER REALLY SECURE?**

*Take Control of Your Privacy **&** Safety in Less Than 10 Minutes*

When you set up a Windows 11 computer, it comes out of the box with excellent
security features -- but some of the most critical protections are actually
turned off by default, while privacy-invasive tracking is often left wide open.

**You shouldn't need a corporate IT department or a degree in computer
engineering to keep your personal emails, bank accounts, and family memories
safe from online scammers.**

We've created a step-by-step Personal PC Safety Guide written specifically for
independent, everyday users. No confusing jargon -- just clear instructions on
how to:

- **Lock the Front Door:** Turn on the hidden, built-in system protections that
  block malicious software before it can ever touch your keyboard.

- **Stop Unwanted Tracking:** Quickly adjust your default settings to switch
  off aggressive background data collection and annoying targeted ads.

- **Secure Your Digital Identity:** Learn how to use simple, modern sign-in
  protections like secure Windows Hello PINs and passkeys.

- **Scam-Proof Your Files:** Set up easy automated backup methods so your
  photos and documents stay safe from ransomware.

**OUR NEIGHBORHOOD PROMISE**

This guide is an educational community resource. We will never sell, share, or
collect your personal information -- our tools run without an account and
without sending your data anywhere. Our free guide and our optional automated
helper are built to help you use the protections you already own with your
Windows license.

*The guide is always free to read. Most home computers qualify for a free copy
of our automated helper tool too -- see the website for details.*

**GET YOUR FREE GUIDE**

Visit Online: **gatewayguard.co/guide**

*(Read it on your tablet or computer, or print a copy for a neighbor)*

*Brought to you by GatewayGuard -- independent tech help dedicated to digital
safety. If you're the "Family IT Hero" who always helps friends and neighbors
with their computers, this guide (and our optional automated helper) will save
you hours of tech-support cleanup down the road!*

GatewayGuard LLC | Brunswick, Maine | gatewayguard.co

---

## NOTE ON THE ORIGINAL FORMATTING

The source places its bold markers outside the intended span on the four bullet
headings -- `**Lock the Front Door: **` rather than `**Lock the Front Door:**`
-- which renders the bold with a trailing space and can break emphasis in
strict Markdown parsers. Corrected in the text above. The `.docx` still has it.
