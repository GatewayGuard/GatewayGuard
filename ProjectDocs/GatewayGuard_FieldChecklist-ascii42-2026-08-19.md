<!-- Dated: 2026-08-19 20:00 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii42 field checklist -- what to look for

- **Build:** `W11-SecurityHardening-v3-ascii42-2026-08-19-1830.ps1`
- **Launcher:** `Tool\Run-GatewayGuard.bat` -- RIGHT-CLICK, Run as administrator
- **Gallery:** `Tool\Show-AllScreens.bat` -- no admin needed, changes nothing
- **Written for SANDY:** Windows 11 Home, local account, two drives, personal
  OneDrive present, **conhost not Windows Terminal** (measured
  `MarkModeReset-SANDY-2026-08-19_18-14.txt`, `WT_SESSION: False`).

**ascii42 is a small build on top of ascii41.** Four things changed, all of
them about Checkup telling you what it is doing. Everything else is as you
last tested it.

---

## THE SHORT VERSION -- five minutes

| # | Do this | Good looks like |
|---|---|---|
| 1 | `Show-AllScreens.bat`, press **A** | All 67 screens print in one list you can scroll back through |
| 2 | In the gallery press the **right arrow** | It moves to the next screen |
| 3 | At the checklist, press a key that is not a command -- **X** | It says the key does nothing, and **the screen does NOT redraw** |
| 4 | On any ordinary screen press **I** | Build and Machine ID appear, Enter returns you |
| 5 | Lean something on the keyboard for a second at the checklist | It says it is ignoring repeated keys. **No flicker, no avalanche** |

---

## THE FOUR CHANGES, IN FULL

### 1. FT-202 -- the gallery can print everything at once

**This is the one that answers "it only showed me one screen".**

- **Do:** run `Show-AllScreens.bat`. Press **A**.
- **Good:** all 67 screens print one after another with no clearing. At the end
  it says to scroll back, and how to copy.
- **Good:** you can scroll up through the whole list, drag over any of it, and
  press Ctrl+C.
- **Why it looked broken before:** the gallery cleared the screen before each
  one, so there was never anything above to scroll to. It was working; it just
  destroyed each screen as it drew the next.

### 2. FT-201 -- the gallery takes the keys you would actually press

- **Do:** in the paged gallery try **right arrow**, **left arrow**, **PageDown**,
  **N**, and **Esc**.
- **Good:** right/down/PageDown/N go forward. Left/up/PageUp/B go back. Esc or
  Q closes.
- **Do:** press something meaningless -- **X**.
- **Good:** it tells you the key does nothing. **Before, it said nothing at
  all, which is why the gallery looked dead.**

### 3. FT-193 -- a stray key no longer repaints the checklist

**This is the important one. It is what made the screen "go crazy".**

- **Do:** at the big settings checklist, press **X**, then **Z**, then a couple
  more junk keys.
- **Good:** each one says *"That key does nothing here. Press R, A, N, Q, P or
  an item number 1-19."*
- **Good, and this is the point: THE SCREEN DOES NOT REDRAW.** The prompt asks
  again in place. Before ascii42 every one of those keys wiped and repainted
  the entire checklist.
- **Do:** rest something on the keyboard for a second, or hold a key down.
- **Good:** after three it says *"Ignoring repeated keys. Something may be
  resting on the keyboard."* and stops printing.
- **BAD:** any flicker, repainting, or the list scrolling away.

### 4. FT-194 -- the I key now works on ordinary screens

- **Do:** press **I** on a page you just read -- not a question, an ordinary
  screen with "Press Enter or Space to continue".
- **Good:** the ABOUT THIS CHECKUP RUN screen appears with your build and
  Machine ID. Press Enter and **you are back where you were.**
- **Why it failed before:** I only worked at Y/N questions. It did nothing on
  the 71 ordinary screens, which is why your items 5-7 could not be tested.
- **Now retest the three you could not:** press I on two or three different
  pages and check it always returns you to the right place.

---

## STILL OPEN -- do NOT spend a finding on these

These are known, filed, and deliberately not in ascii42.

| Finding | Status |
|---|---|
| Something flashes before screen 1 | **FT-184, still open.** Cutting the banner did not fix it. Not yet located |
| Numbering reads oddly on a resume -- 1a, 1b, then 10 | **FT-195.** The numbers are correct and never go backwards -- measured, 253 renders, zero decreases. The gaps are skipped screens. Presentation problem, not a numbering fault |
| "First two screens say screen 1" | **FT-195(a).** Real, mine, not yet fixed |
| No offline scan offered on a resume | **FT-175b.** My fix was incomplete -- it repaired the branch and left the gate |
| Edge phishing / setting 6 says Unknown | **FT-185. Correct behaviour.** Tamper Protection blocks every read; measured on CGDELL. Only the label is wrong |
| "Applying..." then "saved for your review" | **FT-197,** located, not fixed |
| Screens too long, need splitting | **FT-197 family,** your findings 12, 14, 21, 23, 36 |
| Copy instructions wrong -- M vs K vs left-click | **FT-198.** Needs measuring on SANDY before anything is written |
| No Back at screen 19 | **FT-173 residual,** deliberate per-prompt decision, not a sweep |

---

## IF IT CRASHES

ascii40 ran 58 minutes on SANDY without crashing and ascii41 ran four sessions
without crashing. **A crash in ascii42 is new** and points at these four
changes.

Say what you were doing. The log's last line is where it was, and it is in
`C:\Users\willi\OneDrive\GatewayGuard\Logs\`.

---

## ONE THING THAT IS NOT CHECKUP

Your mouse settings were applied on **both** machines by a version of
`Set-MouseForCheckup` that had a fault, so **the undo file on each machine is
unreadable and your original values were never recorded.** The script now
refuses to pretend otherwise -- run it with U and it will say NOTHING WAS
RESTORED rather than claiming success.

The settings themselves are fine and are what you asked for. If you ever want
them back the way they were, it is by hand in Settings, not by the script.
