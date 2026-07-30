# GatewayGuard — Claude Code Project Instructions
<!-- Dated: 2026-07-26 06:19 ET -->

## Project Identity

- **Product:** GatewayGuard — Windows 11 security hardening tool for non-technical home users
- **Developer:** Solo (William F. Burns III / GatewayGuard LLC)
- **Target launch:** September 1, 2026
- **Current build:** ascii38 (7,159 non-blank lines / 7,505 total) — always confirm current build number before any edit session
  - **Line-count convention:** the quoted figure is the `Measure-Object -Line`
    **non-blank** number, per Playbook Appendix A. The old "ascii36 (6,134
    lines)" entry used the total-lines figure instead — two different methods
    on the same line, which makes gate 11's before/after size check
    meaningless. Both numbers are given above so the method is unambiguous.
  - **This line is one of five build-ID locations** (filename, `FILE:` header, `BUILD:` header, `$BuildID`, and here). Pre-Build Audit item 9 checks all five; update this line in the same edit that increments the build. It sat at ascii28 while the tree was on ascii34 — six builds stale, on the very line telling you to confirm the build number. A pointer that lies is worse than no pointer.
- **Tool name:** the tool is **Checkup**. "GatewayGuard Checkup" on first mention, "Checkup" thereafter. GatewayGuard is the company. Certified 2026-07-29. Do **not** rename the MachineID hash salt (`"GatewayGuard|"`), the Task Scheduler task names (`GatewayGuard - Quarterly…`, `GatewayGuard - Monthly…`), `C:\GatewayGuard\`, `Run-GatewayGuard.bat`, `gatewayguard.co`, or the LLC name — those are identifiers and recovery points, not prose. A blanket find-and-replace on "GatewayGuard" would corrupt every machine's ID and orphan the scheduled tasks.
- **Screen numbers:** on screen the user sees **position** in their journey ("Screen 6"); the log carries the **stable ID** plus the position (`[SCREEN-02] (shown as screen 6)`). Gate 12 / C-15's "fixed forever, never renumber" governs the **log only** — Bill overruled the user-facing half on 2026-07-28, because a user on a support call must be able to say which screen they are on. Run `Tool\Check-ScreenCoverage-2026-07-29.ps1` before every build; it is the mechanical gate-12 check and reports the next free ID (78 as of ascii38).
- **Review every screen:** `Tool\Show-AllScreens.bat` walks all 60 screens without running checks or changing anything. It reads the .ps1's own source via the AST, so it cannot drift from the real screens.
- **Language:** Python (primary tool), PowerShell (.ps1 for system edits), batch (.bat for launchers)
- **Platform:** Windows 11 Home and Pro only

---

## Build Naming Rules

- Build names follow the convention: ascii11, ascii12, ascii13 … (incrementing integer after "ascii")
- **Never reuse a build number.** Every saved output is a new build number.
- Same-day superseding builds still increment (e.g., ascii26 superseded same night by ascii27 — both exist)
- Always state the new build number explicitly before presenting output

---

## Pre-Build Checklist (run before presenting any .py output)

1. Audit source for **duplicate function definitions** — flag every duplicate found before proceeding
2. Confirm all `.ps1` edits use **assert-guarded Python replacements** (no raw PowerShell string edits without assertion). **No cosmetic exemption** — lint, comment, and whitespace passes are in scope. Violating this on a lint pass corrupted ascii34 on 2026-07-25.
2a. **File integrity after every edit session:** the file parses (`[Parser]::ParseFile` → 0 errors) and its line count is plausible. **Brace balance alone is not enough** — the corrupted file measured 47,232/47,232 braces, perfectly balanced and completely destroyed. See DefectPreventionPlaybook Class 7.
3. Confirm **`-join`** is used, not `Join-String` (PowerShell 5.1 compatibility)
4. Confirm **console flags are re-asserted before every read**, not once at startup
5. Confirm **ASCII conversion replaces all Unicode characters** before output
6. Confirm build number has been incremented from the previous build
7. Confirm all screens have pauses and a **Back option at every prompt**
8. Confirm no accidental exit without confirmation dialog

---

## Coding Standards

### PowerShell / .ps1
- Use `-join` not `Join-String` (PS 5.1 compatibility — target machines may not have PS 7)
- All `.ps1` edits must go through assert-guarded Python wrappers — never edit registry or system settings via raw string manipulation
- Console flags must be re-asserted before every read operation (not once at startup — see FT-63: Mark mode pauses execution on writes)

### Python
- Build from a clean known-good base — never patch a patched file without confirming the base
- Run the pre-build checklist above before presenting any file
- ASCII conversion must replace **all** Unicode characters before output

### General
- No self-elevation in the launcher (Malwarebytes flagged self-elevation as exploit payload — do not reintroduce)
- Tool version is always **v3.0** in all user-facing text
- For personal computers only — do not generalize to enterprise or server scenarios

---

## Product Rules (User-Facing)

- Only name approved AV products by name: **Microsoft Defender (USA)** and **Malwarebytes Free (USA)**
- Always include country of origin for AV recommendations
- Never name unapproved or competitor products
- "For your protection, your choices can be reviewed in your log" — shown **once only**, on the review screen
- Use **"HEADS UP"** wording, not formal "NOTICE"
- Non-recommended warnings use **Y / N / S** options
- **BitLocker** is always the last item, on its own dedicated screen showing RAM + drive size + type + estimated time
- **GOOD items** auto-skip during run, offered for change at the end
- Font instructions shown as the **very first screen** before any code runs

---

## Website Copy Must Match the Written Guide

The website and the written guide are read by the same person, often side
by side. **They must say the same things in the same words.**

- Before writing any guide page, read the actual guide section for that
  setting and match its wording — not a summary of it.
- `GatewayGuard_SettingsToGuideMap.md` is an **index**, not a content
  source. It tells you which guide section covers a setting. Use it to
  find the section, then read the section.
- **The guide wins on substance. Plain English wins on expression.**
  Match the guide's facts, recommendations, terminology, setting names
  and menu paths exactly — never a different claim or a different path.
  But write the sentences to the plain-English standard, because the
  reader is a non-technical senior.
- **Remove technical jargon — don't explain it, delete it.** Leave the
  plain English version only. Glossing a hard word still leaves a hard
  word in front of the reader. Standing substitutions: *kernel* → "this
  part"; *sealed room* → "locked file location"; *hypervisor*, *VBS*,
  *virtualization* → cut entirely, describe the effect instead.
- **Keep literal on-screen labels exact** — "Memory integrity", "Core
  isolation", "Device security", "Device Manager". Those are names the
  reader must find on their own screen, not jargon. Also keep process
  names they may actually see (vmmem, vmwp).
- Load-bearing phrases stay verbatim — warnings, exact setting names,
  exact paths, and anything that changes meaning if reworded
  ("leave Off — forcing it can break boot").
- If the guide is wrong or unclear, fix the guide first, then carry it
  across — never let the two drift.
- Where the tool already says something on screen, reuse the tool's
  wording rather than writing a parallel version (the D-18 principle).
- **Exception:** a few settings have no guide coverage at all (Fast
  Startup #18, Wake on LAN #19). Original copy is correct there — flag it
  in the page header and feed it back into the guide when next revised.

Full rule: WebsiteStandards RULE W-07, enforced by delivery gate H-4.

---

## Plain Language and No Dead Ends

Applies to the website, the written guide, **and** the tool's on-screen
copy. Full rule: WebsiteStandards RULE W-08.

- **No pedantic phrasing.** Language that is overly meticulous, dwells on
  trivial details, or reads as condescending. Say the thing that matters,
  once. ("the tool told you so at the time" — cut it.)
- **No technical jargon.** Remove it, don't gloss it. See substitutions
  above.
- **Every check step states the desired state and the fix.** Not "look at
  the switch" — "It should say On. If it does not, turn it on."
- **No dead ends.** If you tell them to do something, tell them how, and
  what to do when that route isn't available. "Update the driver" alone
  is a dead end.
- **Copy buttons** anywhere the reader must copy a command, key, path, or
  URL. Never make a senior select text by hand.
- **Headings that promise detail say so** — "(explained fully below)".

---

## User-Facing Clarity Rule

Every instruction given to the user must state exactly what each action does and what happens if they do not take it.

- **Never** say "press X when done" if X and "done" mean different things depending on context
- Spell out the outcome of each key or choice explicitly
- **Test:** Could a non-technical home user predict exactly what will happen before they press the key?

**Standard copy tip wording (use verbatim across all three locations):**
> Tip: To copy text from this window -- press Alt+Space, then E, then M -- drag or use Shift+arrows to select -- press Enter to copy. Press Esc to exit without copying.

The three locations this tip appears:
1. Checklist legend line (always visible)
2. Before BitLocker prep screen
3. Resume flow line

---

## Screen / UX Standards

- All screens need pauses before proceeding
- Back option at every prompt — no dead ends
- No accidental exits without confirmation
- BitLocker screen must show: RAM size, drive size, drive type, estimated time
- GOOD items auto-skip during run; offered for review/change at the end

---

## Document Formatting Standards

*(Applies to any .docx, guide, plan, or report generated alongside the tool)*

**Scope exception — working documents stay plain Markdown.** Test plans,
field checklists, test history, and any doc used at the keyboard while
running the tool are `.md` files with no font or typography requirements.
The standards below govern deliverables a reader sees — guides, plans,
and reports — not working artifacts. (Confirmed 2026-07-26.)

- Minimum **14pt body font**
- **Garamond** for guides, plans, reports, GUI text
- **Arial 14pt** for console/PowerShell output only
- Table headers: black fill / white bold text / black borders
- Table cells: white background / black text / black single-line borders with padding
- No color shading anywhere
- Page breaks between major sections
- Black and white only — no color
- Footer on every page with key sequence rule

---

## Known Issues Log (do not reintroduce)

- **FT-63:** Console text-selection / Mark mode pauses program execution on writes — console flags must be re-asserted before every read
- **Malwarebytes flag:** Self-elevation in launcher flagged as exploit payload — launcher must not self-elevate
- **UX-01 through UX-11:** Logged UX issues — confirm none are reintroduced in any build
- **OBS-01 through OBS-03:** Field observations from Dell Latitude 5430 testing

---

## Approved Products Named in Tool

- Microsoft Defender (USA)
- Malwarebytes Free (USA)

## Domain / Business

- Domain: gatewayguard.com
- LLC: GatewayGuard LLC (Maine)
- Code-signing certificate required before launch (Sectigo or DigiCert, ~$200–400/yr)

---

## File Naming Convention

- Every file uses the format: `filename-YYYY-MM-DD.ext` with today's actual date
- Internal header must show date **and time** in US Eastern Time: `# Dated: YYYY-MM-DD HH:MM ET`
- Filename date and internal header date+time must always match — update both in the same edit, never one without the other
- When one file references another by exact filename (e.g., launcher referencing a build script), update that reference in the same response whenever the referenced filename changes
- See also, in `ProjectDocs\` (always read the newest dated version):
  - `GatewayGuard_CodingStandards-2026-07-26-0619.md` — Python editing rules, recovery points
  - `GatewayGuard_DefectPreventionPlaybook-2026-07-26-0619.md` — the seven failure classes, Pre-Build Audit
  - `GatewayGuard_WebsiteStandards-2026-07-21-1009.md` — HTML build rules and delivery gate
