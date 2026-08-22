<!-- Dated: 2026-08-15 14:30 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# GatewayGuard Screen Numbering -- design state for FT-172

- **Document Name:** GatewayGuard_ScreenNumberDesign
- **Last Modified:** 2026-08-15 14:30 ET
- **Last Editor:** Claude Code (CGDELL)
- **Status:** **APPROVED AND FULLY SETTLED. Bill, 2026-08-17: "172 is
  approved."** All five questions are closed -- 1, 2 and 4 by Bill, 5 by the
  approval itself, 3 being Claude Code's own analysis. **Nothing blocks the
  build.** The remaining work is the call-flow walk (question 3), then the
  table, then the six build steps at the foot of this document.
- **Decisions, in one place:**
  1. Revisits are exempt -- only first encounters must ascend.
  2. Letters never nest. One level: 8a, 8b, 8c. There is no 8a1.
  3. Main line = every user reaches it. Establishing it is the walk.
  4. The BitLocker end block is main line and gets **integers**. Its three
     decline screens are a checklist branch and get letters.
  5. Home 8a / Pro 8b is the scheme working, not a flaw in it.
- **Supersedes:** `GatewayGuard_ScreenNumberTable-2026-08-15-1330.md`, which
  proposed flat numbering. Bill rejected that in favour of branch letters.

---

## READ THIS FIRST IF YOU ARE THE NEXT SESSION

**The design is agreed. Build it.** Bill approved FT-172 on 2026-08-17 and
closed the last two sub-decisions the same day. The five decisions are listed
in the Status block at the top of this document; the reasoning behind each is
in THE OPEN QUESTIONS below.

**The remaining work is question 3 -- the call-flow walk.** It is not a
question for Bill. It establishes which screens every user reaches (integers)
and which hang off them (letters), and it is the input the table is built
from. **It is also the gate:** it must prove no user ever sees a first-encounter
number lower than one already shown. That proof does not exist yet.

**Why this section still opens with a warning.** Bill, 2026-08-15: *"Stop doing
work before we have 100% agreement on complex issues like this... discuss
before you do the work."* That instruction was earned on this exact document --
an earlier session shipped a 262-line numbering table built on a scheme Bill
had already rejected. **The agreement now exists. It did not on 2026-08-15,
and the difference is the only thing that makes building correct today.**

That instruction was earned. This session produced an inventory tool and a
262-line numbering table while the requirement was still arriving across five
messages. The table was obsolete when it landed -- it used a scheme Bill had
already said he liked less, and it shipped with an unresolved cell in the
middle. The work was not wrong so much as premature.

**The next move is a conversation, not a commit.** Start with open question 1.

---

## WHAT FT-172 ACTUALLY IS -- the earlier diagnosis was wrong

**The field test plan says the shown-as number is "written by hand at each
call site." That is false and is withdrawn.**

**measured 2026-08-15 on the ascii40 source:**

- **Zero call sites pass a literal number.** `Draw-Box` has no `-Number`
  parameter at all. It calls `Get-ScreenNumber`, which already keeps a lookup
  table. Half of what Bill asked for in finding 35 already exists.

**The three real causes:**

1. **`Get-ScreenNumber` counts at RUNTIME, in encounter order.** So the number
   is a property of *the run*, not of *the screen*. Two users get different
   numbers for the same screen -- exactly the confusion finding 35 exists to
   kill. **This is the one that matters.**
2. **Three screens never reach `Draw-Box` at all** -- bare `Write-Host` at
   source lines 2833, 2841, 2852. They are on screen; the counter has never
   seen them. Every screen after them therefore reads **low by a constant.**
3. **Eleven screen numbers are typed by hand into visible text** --
   `(Screen 4 of 6)` and similar. A typed number cannot agree with a counted
   one except by luck.

**Causes 2 and 3 together are the whole of findings 3, 4, 6, 7 and 9.**
*"Scr 3 -> 4 of 6"*, *"Scr 4 -> 5 of 6"*, *"Scr 5 = 5 of 6"* -- one arithmetic
error seen five times, not five defects. The intro sequence advertises "of 6"
while `Show-FontInstructions` can paint eight things.

**There is a third numbering surface** nobody had listed: the checklist header
paints `Screen NN -- PAGE p of 2` in its own bar, source line 7668.

---

## BILL'S REQUIREMENTS, as stated

1. **One number per screen. Never two screens with the same number.** *"So when
   a user refers to it we know exactly which screen he is talking about."*
   Stated three times. This is the primary requirement.
2. **Assigned at BUILD time from the viewing order**, not at runtime from what
   this user happened to reach.
3. **The user must never see a number lower than one already seen.**
4. **Skip numbers if you have to.** Gaps acceptable, decreases not.
5. **Going back is fine** -- pressing B repaints the previous screen with its
   own lower number. The user asked for it.
6. `(1 of 2)` / `(3 of 5)` survives as a **group label** for multi-page pairs.
   It never does the numbering, and it comes from the table rather than being
   typed into the screen's text.

---

## THE AGREED SCHEME -- branch letters

**Bill, 2026-08-15: "I liked the other approach with 8a, etc on branches."**

- **Main-line screens get integers** -- 1, 2, 3 … N. These are the screens
  *every* user reaches.
- **Branch screens hang off the integer they follow, with a letter** -- 8a, 8b,
  8c.

**Why this beats flat numbering, on Bill's own rule 3.** Under flat numbering
branch screens consume main-line numbers, so a user who skips a branch sees
7, 8, **12**. Ascending, but the gap is meaningless to them and every user gets
a different one. Under letters, branch content never consumes a main-line
number: **every user walks 1..N unbroken**, with branch screens sitting between
the integers. Monotonic **and** gapless. Rule 4's "skip if you have to" turns
out to be barely needed.

**It also handles mutually exclusive pairs, which flat numbering handles
badly.** Home and Pro are both branches -- neither is a main-line screen. Home
sees 8, **8a**, 9. Pro sees 8, **8b**, 9. Both ascend, neither has a hole.

---

## THE OPEN QUESTIONS -- ALL FIVE NOW CLOSED

**As of 2026-08-17 nothing here blocks the build.** 1, 2 and 4 answered by
Bill; 5 settled by the approval; 3 is Claude Code's analysis and is the
remaining work. The question text is kept in full because the reasoning is
what makes each answer legible later.

### 1. The checklist hub. ANSWERED -- Bill, 2026-08-15: "no".

**The question put to him:** *does returning to a hub that keeps its own label
count as seeing a lower number?* **His answer: no.**

**So revisits are exempt, and the scheme closes.** A screen the user returns to
re-shows its own number. Only **first encounters** must ascend. The checklist
keeps its number and stays numbered like everything else -- no `Checklist`
special case, no unnumbered hub.

**What this settles, beyond the hub:** the same exemption covers every
returned-to screen, so `Test-NonRecommendedSelections` showing at both the
"review" and "final" stages, the BitLocker screens reachable by more than one
route, and the B look-back are all fine as they stand.

**What it does NOT settle, and this is now the main technical risk:** rule 3
still binds on first encounters. Nothing yet proves that two screens cannot be
**first seen in opposite orders on different paths**. If such a pair exists, no
single numbering satisfies rule 3 for both users, and the flow must be
reordered or an exception accepted. **This is what the path-walking gate has to
prove**, and it should be built alongside the numbering rather than after it.

The original text of this question is kept below, because the reasoning is what
makes the answer legible later.

---

### 1 (original text). The checklist hub.

**The checklist is a hub, not a step.** `:checklistLoop while ($true)`, source
line 7808. The run is: checklist -> pick a setting -> setting screen -> **back
to the checklist** -> next setting -> back again. It is the screen the user
spends most of their time on and it is returned to dozens of times per run.

Under letters the natural shape is checklist = 40, its settings = 40a, 40b,
40c. So the journey is **40, 40a, 40, 40b, 40, 40c**.

**Strictly, 40a -> 40 is a decrease.** Letters do not dissolve this -- the hub
has one number by rule 1, so returning to it shows that number again however
numbers are allocated. Giving it a fresh higher number per visit would put
several different numbers on one screen, breaching rule 1 head-on.

**But it reads very differently from the flat version.** *"Checklist, item a,
back to checklist, item b"* is legible structure. The number is not walking
backwards through the program; it is the label of a place the user keeps
returning to, like a contents page.

**So the question narrows to one thing:** does returning to a hub that keeps
its own label count as *seeing a lower number*?

- **If yes** -- the hub carries no number. It says `Checklist` where other
  screens say `Screen 41`. Costs the number on the screen a user is most likely
  to be looking at when they phone for help.
- **If no** -- a returned-to screen re-shows its own label, only first
  encounters must ascend, and **the scheme closes completely with nothing else
  open.**

**Claude Code's read, offered and NOT acted on: "no" is consistent with Bill's
"going back is fine."** But Bill has not said so, and this document does not
assume it.

### 2. Nesting -- ANSWERED. Bill, 2026-08-17: one level only.

**Letters never nest.** Every branch screen hanging off 8 gets a, b, c in
visit order, whatever its depth in the code. There is no 8a1.

A branch inside a branch simply takes the next letter. `Show-BitLockerHomeScreen`
holds seven screens with conditionals inside it; under this answer they are
lettered in the order they are seen, and the code's nesting is invisible to the
user -- which is the point. **One level is what a senior can say out loud on
the phone.**

The original text of this question is kept below.

### 2 (original text). Nesting -- how deep do letters go?

Some branches contain branches. `Show-BitLockerHomeScreen` alone holds seven
screens with conditionals inside it.

- **Flat lettering within an anchor** -- every branch screen hanging off 8 gets
  a, b, c in visit order, whatever its depth. **Recommended:** one level is
  enough to say out loud on the phone.
- **A second level** -- 8a1, 8a2. More precise, more to read out.

### 3. What counts as main line?

Only screens *every* user reaches get an integer.

**measured: 35 of 64 `Draw-Box` screens sit inside an `if`/`switch`**, so the
main line is at most 29 -- and likely fewer, because a function can be called
conditionally even when its screens are not syntactically nested. **Establishing
the true main line is the first real analysis and no number can be assigned
before it.** It requires walking the call flow, not reading the file.

### 4. BitLocker -- ANSWERED. Bill, 2026-08-17: "use integers for the end block."

**The end block gets integers.** The contiguous BitLocker run at the close of
`Run-ConsoleMode` is main line, not a branch, and is numbered with plain
integers. A caller says *"screen 47"*, never *"screen 40k"*.

**The question as first posed was wrong, and was corrected before it was
answered.** It said *"BitLocker is fourteen screens across five functions"* and
asked whether they should hang off one anchor. **measured 2026-08-17: they are
not in one place.**

| Group | Where | Screens | Numbering |
|---|---|---|---|
| Decline heads-up + follow-ups | line 7825, **inside the checklist loop** | 58, 60, 68 | **Letters off the checklist** -- they appear only if the user unticks BitLocker |
| The main run | line 8090, end of `Run-ConsoleMode` | 61, 62, 63, 79, 80, 81, 82 (Home) / 64, 65, 66, 67 (Pro) | **Integers** |

So option 2's stated advantage -- *"BitLocker stays visibly one thing"* -- was
not real. Three of its screens already live with the checklist and belong
there.

**measured, and this is what made integers safe:** the console run enters the
main BitLocker block **once**, walks it in one direction, and never returns.
Home and Pro are mutually exclusive. `Run-ConsoleMode` (line 8090) and
`Run-GUIMode` (line 8437) are mutually exclusive -- the user picks one at
`Show-ModeSelector`. **No user sees a decrease inside BitLocker under either
option.** A Home user climbs and then skips a gap; rule 4 permits exactly that.

### 5. Two users, different letters -- SETTLED BY THE APPROVAL.

Home seeing **8a** where Pro sees **8b** is not a side effect of the scheme, it
is the scheme -- it is the specific case the scheme was chosen to handle
(see THE AGREED SCHEME above). Approving branch letters approves this.

---

## WHAT IS MEASURED, AND WHAT IS NOT

**measured** -- reproducible with `Tool2\Run-ScreenInventory.bat`:

| | |
|---|---|
| `Draw-Box` screens | 64 |
| …of those, inside a branch | 35 |
| Hand-drawn screens carrying IDs 76, 77 | 2 |
| Bare `Write-Host` screens with no ID at all | 3 |
| Screen numbers typed into visible text | 11 |
| Call sites passing a literal number | **0** |

**measured:** the main-flow call sequence, walked from the entry point at
source line 8505.

**NOT established, and it is the risk that would break rule 3 silently:**
nothing yet proves two screens cannot appear in **opposite orders on different
paths**. If any such pair exists, no single numbering satisfies rule 3 for
both, and the flow has to be reordered or an exception accepted. Blocks around
the checklist and BitLocker are where such an inversion would live.

**A gate that walks every path and asserts numbers ascend should be built
ALONGSIDE the numbering, not after it.** FT-162's lesson: a rule with no check
is a wish.

---

## WHAT THE BUILD WILL HAVE TO DO, once the design is agreed

1. **Give the three bare `Write-Host` intro screens stable IDs** and paint them
   through `Draw-Box`. **This single change removes the constant offset Bill
   measured in the field.**
2. **Delete all eleven typed numbers** from screen text. The table becomes the
   only source.
3. **`Get-ScreenNumber` reads the table** instead of counting at runtime.
4. **Extend gate 12 to fail the build** if: a screen ID is missing from the
   table, appears twice, names a screen that does not exist, two screens
   resolve to the same number, any typed `N of M` reappears, or any path
   produces a decrease.
5. **Update CLAUDE.md**, which records the opposite decision today -- *"on
   screen the user sees position in their journey."* That was the runtime model
   and this supersedes it.
6. **Make the checklist log its number.** **measured 2026-08-17, ascii40 field
   run 1:** the log jumps `(shown as screen 21)` -> `(shown as screen 23)`,
   because `SCREEN-76` logs `Checklist render: page 1, window width 121` and no
   position at all. Bill called it "screen 22" in his findings -- read off the
   header bar at source line 7668, the third numbering surface this document
   identified. **So the number the user reads out to support is the one number
   missing from the log support would be reading.** Whatever the table
   assigns to the checklist must reach both surfaces.

---

## RELATED ITEMS -- both settled 2026-08-15

- **`v3.1` everywhere. SETTLED**, Bill: *"use 3.1 everywhere."* CLAUDE.md said
  v3.0 while the build shipped v3.1 in eight user-facing places, so **the rule
  was what was wrong**. Updated in `CLAUDE.md`, in `CLAUDE-Sandy.md`, and in
  the `download` page draft. measured after: **no `v3.0` remains in any
  `.html`, `.ps1` or `.bat`.** One place still carries it and needs Bill's
  hand: `Masters\gatewayguard projects.docx` says *"Version: v3.0 (always --
  this is the customer-facing version)"*. Its twin is generated, so editing
  the twin would be undone at the next regeneration.
- **A3 runs on SANDY. SETTLED**, Bill. The Launch Plan already says so; this
  confirms it rather than changing it. CGDELL was measured as the harsher
  console (`0x01F7` against SANDY's `0x01B7`) but SANDY is the machine that
  actually failed, on a different Windows edition, and reproducing on hardware
  that never broke is the weaker evidence.

## STILL OPEN, not part of FT-172

- **The build number is nearly invisible.** `ascii40` appears on screen twice,
  both in the colours this file reserves for de-emphasized chrome. Since
  numbers renumber between builds, *"screen 6"* only resolves if the build is
  known. It is in the log, so support can ask -- but worth deciding whether it
  belongs somewhere the user can read out.
- **`CLAUDE-Sandy.md` has drifted badly.** measured 2026-08-15: **386 lines
  against `CLAUDE.md`'s 571**. Both are tracked; both claim to be the project
  instructions. A second copy of the governing document, 185 lines behind, is
  the exact failure `SyncPlan` 7b exists to prevent -- and it is the file a
  session started on SANDY would read. **Decide whether it should exist at
  all**, rather than patching it line by line as this session just had to.
