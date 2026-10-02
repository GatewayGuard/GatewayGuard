<!-- Dated: 2026-10-02 11:56 ET -->
<!-- Stamped by Claude Code: the time this file arrived on CGDELL (file creation time, measured). -->
<!-- Editor: Claude Cloud -->
# What the format pack needs to rebuild the five print sizes before 10-15

- **Document Name:** GatewayGuard_FormatPackNeeds
- **From:** Claude Cloud
- **For:** Bill, then Claude Code
- **Status:** REQUIREMENTS. Cloud cannot build the PDFs (Working Rule 3). This says what goes in, what rules apply, and what must be true before export.

---

## PROVENANCE

1. **Stamp:** `CURRENT.md` Generated **2026-09-30 16:43 ET**, commit **`6f3ab29`**.
2. **Bases:**
   - `CLAUDE.md`, the typography standards.
   - `GatewayGuard_GuideVersions-Gumroad-2026-09-02-1841.md`: the five sizes, filenames, and the 12-point footer finding.
   - `GatewayGuard_StoreTestFiles-2026-09-02-1119.md`: US Letter, 0.9-inch margins, Garamond, selectable text.
   - `NotesAdditions-2026-07-16.md`: one master, sizes regenerated together, and the 20-point proofing pass.
   - Cloud review C-4 / Decision 8: no page numbers in cross-references.
3. **Not seen:** any existing format-pack script or master `.docx` for the new guide. **I do not know what the pack is built from today.** Item 1 below is the first thing to settle.

---

## 1. SOURCE TEXT -- ONE MASTER, ASSEMBLED IN THIS ORDER

| Order | Content | File (from `CURRENT.md`) |
|---|---|---|
| 1 | Part 1, through *Before You Begin* | `GatewayGuard_CoPilotGuidePart1-2026-09-16-1627.md` |
| 2 | **Part 1 addition**: *Before you start: a safety net* (make, what it is, using) | `GatewayGuard_GuideFinal-Part1SafetyNet-Part4-Part5-<stamp>.md` |
| 3 | Part 1, from *Understanding Recommendations* to the end (quick-reference table with **Number 5: Not applicable**) | Part 1 twin |
| 4 | Part 2, Settings 1-4, 6-9, 16, 17 | `GatewayGuard_CoPilotGuidePart2-2026-09-16-1627.md`, after P2-5 and P2-6 |
| 5 | Part 3, Settings 10-15, 18, 19, the locked-controls note, and the Part 4 lead-in | `GatewayGuard_CoPilotGuidePart3-2026-09-16-1627.md`, after P3-9 to P3-13 |
| 6 | Part 4 and Part 5 | the GuideFinal file |

**Bill's call (question 1):** the twins are `.md`, so either the pack builds from `.md`, or someone pastes all of this into a new master `.docx` once. **One master, five exports**, not five documents.

---

## 2. STRIP BEFORE EXPORT -- A GATE, NOT A HOPE

Every one of these must grep to **0** in the assembled master:

| Pattern | Why |
|---|---|
| `VERIFY` | No unmeasured sentence ships. **Today: 5 in GuideFinal + 2 in Part 3**, all waiting on R1-R8 |
| `[NOTE` and `[SCREEN NAME PENDING` | Editorial notes |
| `====` and the Provenance / For F10 / Readings sections | Cloud's file furniture |
| `Bitwarden`, `1Password`, `KeePass`, `Malwarebytes`, `Norton`, `McAfee`, `Avira`, `LastPass` | Bill, 2026-09-25. **Bill must first rule on "Google Password Manager"** in Setting 15 (Parts 2-3 change list, B-3) |
| `Phase ` + digit, `Step ` + digit outside Part 4.5 | Old guide structure |
| `of 19` | 18 settings |
| `whether` | Banned word (triage G3) |
| `nothing has been changed` | Brief rule B, note 14 |
| `page ` + digit in a cross-reference | Five sizes paginate differently (Decision 8). Cross-references are *Part N, Setting N* |

**Also check:** setting numbers in every heading match Checkup's IDs (1-4, 6-19, no 5). That was the 09-16 bug.

---

## 3. TYPOGRAPHY -- FROM `CLAUDE.md`, AND ONE CONFLICT

| Rule | Value |
|---|---|
| Body face | **Garamond**; headings Garamond Bold |
| Colour | **Black and white only**, no shading anywhere |
| Tables | Header: black fill, white bold text, black borders. Cells: white, black text, black single-line borders, padding |
| Page breaks | Between major sections (each Part; each Setting is *inferred* to be cleanest) |
| Footer | **On every page, with the key sequence rule**. Size it as body text, not smaller |
| Page | US Letter, 0.9-inch margins, real selectable text (StoreTestFiles) |
| Sizes | **12, 14, 16, 18, 20 point** body, measured in the PDF (StoreTestFiles method: `Tf` x content matrix) |
| Filenames | `GatewayGuard Windows Security Walkthrough Guide - NN point (label).pdf`, exactly as in GuideVersions |

**The conflict, for Bill (question 2):** `CLAUDE.md` says **minimum 14pt body font**, but the 12-point edition is a product on Gumroad. The test PDF's footer also rendered at **9 point**.

- Either the 12-point edition is an explicit, recorded exception to the 14-point rule, or it goes.
- Either way, **no run of text in any edition may be smaller than that edition's body size.** That includes the footer and table text.

---

## 4. PROOFING PER SIZE -- NOT JUST A FONT SWAP

From `NotesAdditions` 07-16: the large sizes need their own pass. For **each** of the five:

1. **No table splits a row across pages.** The 4.2 undo table is the one most at risk.
2. **No heading is the last line on a page.**
3. **Numbered steps do not break between a step and its sub-bullets** (Part 1 step 2; 4.5 Step 2).
4. **Long literal labels wrap without hyphenation**, e.g. *Continue running background extensions and apps when Edge is closed*. A hyphen inside an on-screen label sends a reader looking for a word that is not there.
5. **Record the page count**, which the Gumroad copy needs, and the measured body size.

---

## 5. ACCESSIBILITY

- **Tagged PDF**, with headings tagged as headings and tables with header rows.
- **Reading order** checked once per size.
- **Document title** set in the PDF's properties.
- **Language** set to English (US).
- The Word Accessibility Assistant run on the master, if the master is `.docx`, **recorded as a checklist item, not a pass claim** (W-nn.5: zero findings is not proof).

---

## 6. WHAT HAS TO BE TRUE BEFORE EXPORT -- ORDER FOR 10-15

1. **R1 to R8 read** (Bill, CGDELL; R7 needs a second PC). Cloud closes or rewrites the 7 remaining markers.
2. **Bill rules on:**
   - G2 (Setting 11);
   - B-1 to B-3 in the Parts 2-3 list (Fast Startup and Microsoft's own advice; the Setting 13 memory line; Google Password Manager);
   - the 12-point edition.
3. **Claude Code applies** the Parts 2-3 change list and the website list. **F10 takes 4.2 into Checkup**, so the guide's undo steps and Checkup's screen say the same thing.
4. **Assemble the master** (section 1) and run the strip gate (section 2) to zero.
5. **Export five sizes**, then measure each (section 3) and proof each (section 4).
6. **Update the Gumroad copy:**
   - real page counts;
   - "Five print sizes - you pick one";
   - the five filenames replace the `TESTFILE - ` stand-ins.

---

## QUESTIONS, HELD TO THE END

1. **Bill:** build the master from the `.md` twins, or paste once into a new `.docx` master? I do not know what the existing pack builds from.
2. **Bill:** the 12-point edition against `CLAUDE.md`'s 14-point minimum. Is it a recorded exception, or is it dropped?
