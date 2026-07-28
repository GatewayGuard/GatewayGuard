<!-- Dated: 2026-07-28 12:43 EDT -->
# GatewayGuard -- Session Handoff, 2026-07-28

- **Document Name:** GatewayGuard_SessionHandoff
- **Last Modified:** 2026-07-28 12:43 EDT
- **Current build:** `Tool\W11-SecurityHardening-v3-ascii36-2026-07-27-1655.ps1`
  -- **UNCHANGED today.** No edit was applied to any `.ps1` file.
- **Status:** Working document. Written so a cold start resumes exactly here.

---

## 1. STATE OF THE TREE

Clean. Four commits. `ascii36` untouched -- the ascii37 build script was
drafted twice and declined both times, so nothing is half-edited.

| Commit | Contents |
|---|---|
| `745dfde` | Initial commit -- project baseline, 417 files, 57 MB |
| `1432902` | Screen inventory (the list) |
| `c6eaeaa` | Screen contents (the screens) |
| *(latest)* | winget permission |

---

## 2. WHAT WAS PUT IN PLACE TODAY

**Git.** Installed (2.55.0.3) and initialised. Storage is byte-exact:
`core.autocrlf=false` plus `* -text` in `.gitattributes`. This is
load-bearing -- Class 7 rule 5 specifies recovery as "byte-for-byte,
confirmed by hash", and Git for Windows' default CRLF translation would
have broken that. Verified: the blob stored for ascii36 and the hash of
the file on disk are the same object, `1f540d86...`.

`.gitignore` excludes `*.exe` (a 569 MB printer installer sits in the
folder), `*.zip`, `Tool/_corrupt/`, and Office lock files.

**Automatic file-integrity check.** `.claude/check-ps1-integrity.ps1`,
wired as a `PostToolUse` hook. After every write or edit to a `.ps1` it
runs the parse check, line count, byte size and brace balance, and
**blocks with a STOP instruction** if the file fails. Confirmed firing.

Proven against the real corrupted file: 244 parse errors, 242,064 lines --
and **47,232 / 47,232 braces, perfectly balanced.** The check that was in
the standing procedure passed clean on the destroyed file. The two that
caught it now run automatically.

**Python 3.12.10** installed, for the assert-guarded edit wrapper the
CodingStandards require.

**Two screen documents** (committed):
`GatewayGuard_ScreenInventory-2026-07-28-1003.md` and
`GatewayGuard_ScreenContents-2026-07-28-1003.md`. Together these are
field note 3's request. 56 screens; 11 numbered, 45 not.

---

## 3. FINDINGS RECORDED NOWHERE ELSE

These came out of today's reading and exist only here.

### 3.1 The crash (note 14) -- narrowed, not solved

Reported: *"selected N to turn off all selections and screen flickered ...
then displayed screen showing R had been selected and when i hit space bar
pgm crashed."*

**Ruled out:** the labelled `continue`. Line 5142 does carry
`:checklistLoop`, so all twelve `continue checklistLoop` statements are
valid. (An unmatched label terminates a PowerShell script silently and
would have looked exactly like this.) Also ruled out: R with nothing
selected -- line 5283 handles that cleanly.

**The evidence:** log `GatewayGuard-Log-2026-07-27_19-08.txt` ends dead at
`[19:14:07] [KEY] Nav 'NEXT' at: Show-ScopeDisclaimer`, with no exit line
and no error line. `Show-ScopeDisclaimer` is called at line 5140; the
checklist loop begins at 5142. **The program died in the checklist
render.**

**UPDATE (12:55) -- lines 5142-5222 have now been read. The crash site is
identified and it is already documented in the source.**

Line 5183 carries this comment:

```powershell
$statusStr = [string]$s.Status; ...   # FT-71 (ascii30): [string] cast -- null/array
                                      # Status crashes here on page flip after N
```

*"crashes here on page flip after N"* is field note 14 verbatim, written
into the file during ascii30. **This is a known crash site, patched once,
that has recurred.** Any fix must therefore explain why the ascii30 patch
was insufficient -- Class 6 rule 5 (close the defect that was reported,
not a proxy for it) applies with force here, because a proxy fix has
already been shipped once at this exact line.

The surrounding block is the most-rewritten code in the file: lines
5145-5157 record three successive attempts at the column-width arithmetic
(FT-56, FT-58, FT-117), each replacing the last. Lines 5182-5183 then do
`Substring` arithmetic on those computed widths, which is the operation
that throws when a value is not what the code assumes.

**Two gaps the ascii30 patch did not cover** -- candidates, not proven:

1. **`[Math]::Floor` returns a double.** Line 5162 sets
   `$ggNameW = [Math]::Floor($ggAvailable * 0.6)`, and line 5163 derives
   `$ggStatW` from it, so both are `[double]`. They are then passed to
   `Substring(Int32, Int32)` and `PadRight(Int32)` at lines 5182-5183.
   PowerShell coerces this in the normal case, but it is exactly the loose
   typing at a computed boundary that Class 4 rule 2 exists to prevent.
   Explicit `[int]` casts on both widths are cheap and remove the whole
   question.
2. **The `[string]` guard is on one column only.** FT-71 added
   `[string]$s.Status` at line 5183, but `$s.Name` at line 5178 has no
   equivalent cast. The two columns are built by the same pattern and only
   one was hardened.

Neither is confirmed as the trigger. Confirming it needs the checklist
exercised under a narrow console window with all items deselected --
which is the FT-117 reproduction, and points back to 3.2.

**Note the sequencing consequence:** this is a crash on the screen where
the user spends the most time. If it is still live in ascii37, a field run
may not reach the end regardless of what else is in the build. It is
gating for the run, not merely another backlog item.

**Likely connection:** see 3.2.

### 3.2 One box is 173 columns wide

Measured across all 56 screens: widths run 57 to **173** columns. On an
80-column window that widest box loses more than half its content off the
right edge.

FT-117 was closed as "widths are now measured per render rather than
guessed from two presets" -- which sizes the box correctly to its content
but does nothing when the content itself is wider than the window.

This plausibly ties together **note 14** (crash in the checklist render),
**note 10** (selections behaving oddly, screens hard to read) and FT-117.
Unproven, but it is the strongest single lead.

### 3.3 The "Briefing" checkpoint silently disables resume

Not in any field note. Line 6030 runs `Save-Checkpoint -Checkpoint
"Briefing"`, but `"Briefing"` is **absent from `$global:CheckpointOrder`**
(line 1466). Two consequences:

1. `Test-CheckpointReached "Briefing"` hits `IndexOf` -> -1 -> always
   returns `$false`, so the condition at line 6027 collapses to just
   `$global:IsFirstRun`.
2. It **overwrites the valid `"Baseline"` checkpoint** saved at line 6018.
   `Show-ResumePrompt` (line 1517) guards with
   `if ($saved -and ($saved -in $global:CheckpointOrder))` -- `"Briefing"`
   fails that test, so the resume prompt never appears and the user
   silently loses their resume point.

Class 1 invisible failure.

**Fix:** add `"Briefing"` to `CheckpointOrder` between `"Baseline"` and
`"PreScanPrep"`, then drop the `$global:IsFirstRun` gate at 6027.

### 3.4 Field note 3's root cause is the briefing gate, not screen order

The tool already explains Defender and Malwarebytes *before* the offline
scan question -- but only on a first run. The 2026-07-27 session was a
repeat run (log: *"Repeat run -- user confirmed to continue"*), so
`$global:IsFirstRun` was false and **both briefing screens were skipped**.
Neither SCREEN-26 nor SCREEN-27 appears in either log.

The sequence is correct. The explanation was conditional and the tester
was not receiving it. Same cause as the ascii34 plan's note that
SCREEN-26/27 were "not observed in any of four ascii33 logs" -- third
occurrence.

**This must stay a separate ticket from the numbering work.** FT-116 died
the first time by being closed with an adjacent fix; Class 6 rule 5 exists
to stop exactly that.

### 3.5 Enter silently answers Y at 32 prompts

`Read-ValidKey` line 889:

```powershell
if ($k.VirtualKeyCode -eq 13 -and "Y" -in $ValidKeys -and $ch -eq "") { $ch = "Y" }
```

Enter means "I have read this" at all 56 `Pause-ForUser` screens and
"yes, change my system" at all 32 Y/N prompts. This is the most likely
cause of note 10's *"all selections were removed while I was typing
notes"*. It also violates the User-Facing Clarity Rule directly.

Related: `N` = deselect-everything is a single unconfirmed keypress
(line 5279).

**Any field run before this is fixed produces suspect selection data.**

### 3.6 Malwarebytes IS registered in SecurityCenter2

An earlier hypothesis (that MB Free does not register in SC2) is **wrong**
and should not be carried forward. From
`ProjectDocs\Dell Win 11 Pro MB Status - 2026-07-16-08=06.txt`:

```
displayName        productState
Malwarebytes             397312
Windows Defender         393472
```

MB is in SC2 on the Dell. The tool's query at line 2127 should have
matched it. So "MALWAREBYTES NOT DETECTED" is a **branch-logic bug, not a
detection-method gap** -- it needs a trace of which branch ran, not a
redesign. The same capture shows `AMRunningMode = Passive Mode`, i.e. an MB
trial was active on 7/16; by 7/27 Defender was primary, so the machine
changed state between captures and the run took neither the `TrialActive`
nor the `FreeCompanion` branch.

### 3.7 Items 13, 14, 15 report false BAD

Lines 3553, 3557, 3561. All three read **only the HKLM policy key that the
tool itself writes**:

- 13 Edge Startup Boost -> `HKLM:\SOFTWARE\Policies\Microsoft\Edge`
- 14 Widgets -> `HKLM:\SOFTWARE\Policies\Microsoft\Dsh`
- 15 Edge password saving -> `HKLM:\SOFTWARE\Policies\Microsoft\Edge`

Settings turned off through the normal Edge/Windows UI write elsewhere
(Edge profile Preferences JSON; `HKCU...\Advanced\TaskbarDa` for widgets).
The policy key is absent, the read returns null, and null falls through
`else` into "Enabled (default) -- needs attention".

This is **FT-120 inverted** -- same root cause, opposite direction. Null
must resolve to "Unknown", never to a definite state.

### 3.8 `Get-MpPreference` throws when Defender is stopped

`ProjectDocs\get-mpcomputerstatus.txt` (the HP, Defender disabled) shows
`Get-MpPreference` failing with **0x800106ba**. Any call wrapped in
`-EA SilentlyContinue` on a State-2 machine is a Class 1 risk -- and the HP
is the machine that has never been tested.

### 3.9 Line 5387 prints a literal `+`

```powershell
Write-Host "  !!  $($s.Name) is a critical security protection.".PadRight(63) + "!!" -ForegroundColor Red
```

PowerShell argument mode does not concatenate here. User-visible, inside
the SECURITY CRITICAL warning box. Cosmetic.

---

## 4. THE STRUCTURAL PROBLEM

**Nothing has been field-tested since ascii33.** No TestHistory document
exists for ascii34, ascii35 or ascii36 -- only ascii32 and ascii33.

The ascii34 field test plan states plainly: *"ascii34 is an UNRUN BUILD.
This run clears it. ascii35 scoping does not open until this is done."*
ascii35 and ascii36 shipped anyway. Playbook Class 6 rule 3 -- *"Never let
two builds stack unrun"* -- is broken by three.

**The required test machine has never run.** The ascii34 machine matrix
lists the HP Notebook (SANDY), Windows 11 **Home**, as
*"YES -- cannot clear ascii34 without it."* Every log in the project is the
Dell (CGDELL, Pro). Consequently **FT-110** -- the headline ascii34 fix, and
Home-only logic -- has never executed, and **FT-115** (Memory Integrity
showing "Unknown") is still unverified. It was blocked on a USB WiFi
adapter due 2026-07-26. **Did it arrive?**

Practical read: for most items, "fixed" currently means "written", not
"confirmed". Field note 9 -- *"apparently nothing was fixed from the
previous two test runs"* -- was reading this accurately.

---

## 5. OPEN DECISION: ascii37 SCOPE

Bill's stated order: **(1)** briefing gate, **(2)** screen numbering,
**(3)** false-BAD detections. Bill also ruled on 2026-07-28 that
**the user must see a screen number** -- see section 6.

Agreed design for (2), measured before adoption:

`Draw-Box` (line 782) is a single choke point every screen passes through.
Add a `-ScreenId` parameter which (a) prefixes the first content line --
`"Screen 50 - POWER SETTINGS -- SECURITY REVIEW"` -- and (b) emits
`[SCREEN-50] Rendered: ...` to the log itself. One mechanism covers the
user-visible number, the 45 missing log IDs, and the duplicate SCREEN-13
(structurally impossible once the ID comes from one place). Then 56 call
sites get `-ScreenId "NN"`, and the 11 hand-written log lines are removed.

**Width impact measured:** 39 of 56 boxes absorb the prefix into existing
title padding with no width change; 17 grow; worst result is 74 columns,
inside a standard 80-column console. Safe.

**The open question is how wide to scope ascii37.** Roughly 11 of the 14
ascii36 notes remain unaddressed, plus the whole ascii34 backlog
(FT-109 to FT-119, D-15 to D-21). Arguments both ways are in section 7.

The full ID map for all 56 call sites is in the screen inventory document.

---

## 6. STANDARDS THAT NEED AMENDING

| Document | Issue |
|---|---|
| **CodingStandards** gate 18 / C-15 | Says *"No screen, prompt, or message ever shows an internal ID to user."* **Bill overruled this 2026-07-28** -- users must see a screen number for support calls. Amend with date and reason. |
| **CLAUDE.md** "Current build: ascii36 (6,134 lines)" | Wrong metric. Playbook Appendix A sets the convention as the `Measure-Object -Line` **non-blank** number, which is **5,808**. 6,134 is the total-lines figure. Matters because gate 11's size check is meaningless if before/after use different methods. |
| **CLAUDE.md** "Domain: gatewayguard.com" | Wrong. WebsiteStandards section 4 confirms **gatewayguard.co** -- GitHub Pages custom domain, Namecheap A records. The tool is right; CLAUDE.md is wrong. |
| **CLAUDE.md** WebsiteStandards pointer | Names `-2026-07-21-1009` (11 KB). Newest is `-2026-07-26-0619` (19 KB). Same "pointer that lies" failure the build-ID line already earned. |
| **SettingsToGuideMap** item 19 | Gives the Wake on LAN path as *Device Manager -> Network Adapters -> Properties -> Power Management*. That tab **does not exist** on the Dell (field-confirmed). Anything written from the map inherits the error. |
| **WebsiteStandards** section 5 sitemap | Lists `wake-on-lan.html` and `memory-integrity.html` as "Not built"; both exist in `WebSite\` dated 2026-07-26-0619. |
| **Tool** gate 11 violation | Line 3868 hardcodes `gatewayguard.co/guide/phishing-protection`; the sitemap shows that page as "Built (needs push)" -- not live. Gate 11 forbids hardcoding a path that is not live. Only `index.html` is Live. |

---

## 7. RECOMMENDED NEXT STEPS

1. **Finish the crash diagnosis** -- read lines 5142-5222. It is the one
   defect that can stop a field run reaching the end, which makes it
   gating for everything else.
2. **Decide ascii37 scope.** The argument for keeping it tight (briefing
   gate, screen numbering, detections) is that those three make the *next
   run* produce unambiguous data -- every note citable to a screen, no
   missing explanation screens, true statuses. The argument for widening
   is that ascii37 will be a fourth unrun build regardless, and testing is
   Bill's time. Class 6 rule 3 says "where possible", which is the room to
   choose.
3. **Fix the Enter->Y hazard regardless of scope.** One line. Until it is
   fixed, every run produces suspect selection data.
4. **Confirm the HP USB WiFi adapter arrived.** Without the Home machine
   nothing clears, however good ascii37 is.
5. **Then run it** -- and write the TestHistory document that has been
   missing for three builds.

---

## 8. NOT YET READ

Roughly 125 of the ~132 files in `ProjectDocs\` and `WebSite\`. Read so
far: DefectPreventionPlaybook, CodingStandards, WebsiteStandards,
FieldTestPlan-ascii34, MBDefender_Screens, SettingsToGuideMap, and the two
MB/Defender diagnostic captures.

**Largest unread item:** `GatewayGuard_ProjectNotes-2026-07-24-1317 (1).md`
at 165 KB -- roughly a third of all live text in the project and the
likeliest record of past decisions.

**Hard blocker for all website work:** the guide itself,
`windows_security_walkthrough_guide_v9.docx`, is a `.docx` and cannot be
read directly. RULE W-07 makes reading it mandatory before any guide page,
and gate H-4 fails delivery if the guide section cannot be named. Its text
needs extracting before website work can proceed at all.

`Run-GUIMode` (mode 2, lines 5593-6075) is not inventoried. Every field log
uses mode 1.
