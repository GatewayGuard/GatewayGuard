# READ FIRST — Briefing for this work session
**Dated: 2026-08-02 12:30 EDT**

You are writing four new website pages and rewriting the written guide.
Read this before anything else in the upload.

---

## TWO RULES THAT ARE NEW TODAY

Both were added to `CLAUDE.md` on 2026-08-02. **If you are working from an
older copy of CLAUDE.md you will not have them, and you will reintroduce 26
defects that were removed this morning.** The copy in this folder is current.

### 1. "whether" and "whereas" are BANNED in all user-facing copy

No exceptions — screens, website, guide, marketing.

"Whether" hedges. It describes what was *looked at* instead of what was
*found*, leaving the reader holding a question instead of an answer. All 19
guide pages opened their "What Checkup found" box with *"Whether X is
enabled…"* — 26 instances across 18 pages. Every one has been rewritten.

**Substitutions:**

| Instead of | Write |
|---|---|
| Whether X is enabled | **Checkup checks if X is enabled** |
| not sure whether you did | **cannot remember doing** |
| applies whether A or B | **applies when A or B** |
| asked whether to turn it off | **asked for your permission to turn it off** |
| checks whether it is set up | **checks if it is set up** |

### 2. Every sentence describing a setting change names the user's permission

This is the product's central promise — *"Checkup never applies anything you
did not choose."* A reader told what a program changed, without being told
they approved it, has been handed a reason to distrust the program.

- **"It can switch it off with your permission."**
- **"Checkup never starts encryption without your explicit permission."**
- **"Checkup asks your permission first."**

Where Windows forbids programmatic change, say **that** instead:

- **"Windows does not allow any program to change this one, so Checkup shows
  you the exact steps to switch it on yourself."**

Three settings are in that category and must not be described as things
Checkup changes: **Tamper Protection**, **Windows Hello**, and **Defender
Periodic Scanning**.

---

## THE 19 PAGES ARE CORRECTED, NOT DRAFTS

`GuidePages-Corrected-2026-08-02-1201/` contains the current, verified truth.
They pass eight mechanical checks: no markup corruption, no malformed
entities, no banned jargon, no banned words, balanced tags, no duplicate IDs,
complete document heads, correct product naming.

**Use them as the template for voice, structure, navigation and footer. Do
not rewrite them. Do not "improve" them.**

Two corrections in particular must survive, because a well-meaning rewrite
would undo both:

**`remote-desktop.html`** previously said *"Remote Desktop is not available on
Windows 11 Home."* That is **false** and was corrected on 2026-08-02 against
Microsoft Learn. The accurate position:

- Windows 11 Home **cannot accept incoming** Remote Desktop connections —
  hosting is Pro and above. Correct.
- Windows 11 Home **can** run the Remote Desktop Connection client to connect
  **out** to another PC. The old copy denied this and was wrong.
- The page also names **Quick Assist** as the consent-based exception and the
  scam it enables. Quick Assist ships on Home and is a documented
  social-engineering vector. Do not remove that warning.

**`memory-integrity.html`** is the page most at risk of jargon creeping back.
The words **kernel, hypervisor, VBS, virtualization, sealed room** are banned
in body copy — delete them, do not explain them. But the literal on-screen
labels **"Memory integrity"**, **"Core isolation"**, **"Device security"**,
**"Device Manager"** and the process names **vmmem** and **vmwp** must stay
exact, because the reader has to find them on their own screen.

---

## THE GUIDE IS STALE — W-07 IS INVERTED FOR THIS JOB

`windows_security_walkthrough_guide_v9.docx` was last modified **2026-06-02**
— two months and seven builds ago.

| Term | Mentions in the guide |
|---|---|
| Checkup | **0** |
| GatewayGuard | **0** |
| Wake on LAN | **0** |
| Quick Assist | **0** |
| Remote Desktop | 2 |

Normally RULE W-07 says *the guide wins on substance*. **Not here.** The 19
pages are current and the guide is the stale artifact. Carrying the guide's
claims back into the pages would undo today's corrections.

**Direction of travel: the 19 pages feed the guide, not the reverse.**

`GatewayGuard_SettingsToGuideMap.md` is an **index**, not a content source.
Use it to find which guide section covers a setting, then read that section.
It already flags Remote Desktop coverage as *"BRIEF — needs expansion."*

---

## WHAT TO PRODUCE

**Four website pages**, matching the 19 exactly in template, nav and footer:

| Page | Notes |
|---|---|
| `tips.html` | Assemble from `GG-Tips.md` and `Note tips.txt`. Do not invent tips |
| `beta.html` | **Blocked** — needs a product decision on who is in the beta |
| `compatible.html` | **Blocked** — needs a decision on what is claimed compatible |
| `download.html` | Draft the copy and system requirements. **Leave the SHA-256 as a placeholder** — it can only be computed from the signed build, which does not exist yet |

All four are linked from every one of the 19 pages' navigation, so their
filenames must be exactly as above at the site root.

**The guide rewrite** — bring `v9` up to current truth from the 19 pages.
It must gain the product name (Checkup on first mention, Checkup thereafter;
GatewayGuard is the company), and coverage for the settings it is missing.
Document Formatting Standards apply to the `.docx`: minimum 14pt body,
Garamond, black-and-white tables with black fill / white bold header text, no
colour, page breaks between major sections.

---

## BEFORE YOU DELIVER

Report the HTML delivery gate:

```
H-1 Corruption grep (W-02): [PASSED -- 0 issues] or [list findings]
H-2 Browser check instruction (W-03): [INCLUDED in response]
H-3 W3C validation instruction (W-04): [INCLUDED in response]
H-4 Guide-wording source (W-07): [section cited] or
    [NO GUIDE COVERAGE -- original copy, flagged in file header]
```

A page whose wording source cannot be named has not passed the gate.
"Written from the settings map" is a FAIL, not a source.

Everything you deliver will be checked here against the same eight
mechanical checks the 19 pages passed, plus a `whether`/`whereas` sweep and a
diff against the corrected pages to confirm nothing was silently reverted.

---

## ALSO IN THIS FOLDER

| File | Why you have it |
|---|---|
| `CLAUDE.md` | **Current as of today.** The two new rules are in it |
| `GatewayGuard_ProjectInstructions-*` | Session rules, research and verification rules |
| `GatewayGuard_WebsiteStandards-*` | W-07, W-08, the HTML build rules |
| `GatewayGuard_CodingStandards-*` | Carries the HTML delivery gate H-1…H-4 |
| `GatewayGuard_ScreenContents-*` | Every Checkup screen verbatim. **Reuse Checkup's own wording rather than writing a parallel version** (the D-18 principle) |
| `GatewayGuard_TestHistory-ascii39-*` | Current known defects. Do not write copy that contradicts these |
| `GatewayGuard_CPM_Schedule-*` | Where this work sits in the launch plan |
| `GatewayGuard_FieldTestPlan-ascii39-*` | Context on what is being tested now |
