<!-- Dated: 2026-08-19 20:40 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Bill's 38 ascii41 findings -- what ascii42 actually fixed

- **Question asked 2026-08-19:** *"Which of my ascii41 test results were not
  fixed in ascii42?"*
- **Short answer: five were fixed. Thirty-two were not.** One needed nothing.
- **Source:** `Test_Results\Ascii41-Test-Reults-2026-08-18-1110.txt`

**ascii42 is a small build and was never meant to be more.** It fixed the
things that made Checkup behave as though it were broken -- a stray key
repainting the screen, and the `I` key doing nothing on most screens. It fixed
no wording, split no screens, and added no explanations.

---

## FIXED IN ascii42 -- worth retesting

| # | Your finding | What changed |
|---|---|---|
| **10** | *"Hit spacebar and pgm repeated the question"* | FT-193. An unmatched key now re-asks in place instead of repainting, and the rest of the burst is drained |
| **15** | *"the same question repeated multiple times after pressing my mouse button repeatedly"* | FT-193. **The repeating is fixed. The scroll-back wall in the same finding is NOT** |
| **24** | *"crazy things started happening... 20+ command screens"* | FT-193 removes Checkup's part in it. **Your own explanation -- the mouse body on the keys -- is the likely source, and no code fixes that** |
| **32** | *"Mouse goes crazy again"* | FT-193, plus the mouse settings on both machines |
| **33** | *"your number 5-7 not active due to I not working"* | FT-194. `I` now works on ordinary pages, so those three are testable again |

**34** (*"both drives showed up correctly"*) needed nothing -- it was already
right in ascii41.

---

## NOT FIXED -- please do not spend a finding on these

### Things I have located and filed

| # | Your finding | Status |
|---|---|---|
| 1 | Something flashed by | **FT-184.** Cutting the banner did not fix it. Still unlocated after three builds |
| 2 | First two screens say screen 1 | **FT-195(a).** Mine. `1a` renders immediately before `1` |
| 9 | No **B** on "Is this your personal computer" | **FT-173 residual.** A per-prompt decision, deliberately not a sweep |
| 11 | Going back skips screen 9 | **FT-195.** Not addressed |
| 18, 20, 21, 26 | Numbering out of order / went backwards | **FT-195.** Measured: 253 renders, **zero decreases**. The numbers are right; the gaps and the `1a`/`1` collision are what you are seeing |
| 27 | Still have to press Enter after a letter | **FT-196.** Needs a sweep of every prompt |
| 35 | No offline scan offered on a resume | **FT-175b. My fix was incomplete** -- it repaired the branch and left the gate that skips the whole function |
| 36 | Characters cut off at the end of each item | **FT-199.** Not yet located |
| 38 | *"Applying..."* then *"saved for your individual review"* | **FT-197.** Located at line 6161. The deferral is correct; the sequencing is not |
| 17, 24 | `M` does nothing, `K` worked, then left-click | **FT-198.** Needs measuring on SANDY before anything is written into three documents and a screen |

### Wording and content -- all still open

| # | What you asked for |
|---|---|
| 3 | Scr 2: mouse-wheel wording; warn about the X beside the arrow; confirm on accidental X |
| 4 | Put the screen number on the title line, everywhere |
| 5 | Scr 5: X warning again; **auto-set the window for them** |
| 6 | Scr 6: tell them where the log file is |
| 7 | *"Why do we have messages that move on?"* -- **I still do not know which messages you mean** |
| 8 | Scr 8: rewrite the scrolling/copying explanation; it contradicts earlier screens |
| 12 | Combine screens 10-12 into one |
| 13 | Scr 13: three specific rewordings you gave me |
| 14 | Scr 14: reword the first sentence, add "Machine Time", split into two screens |
| 16 | Scr 16: estimated time, "save and close all open files" |
| 19 | 14b: offer to delete quarantined items |
| 20 | Scr 17: reword the Malwarebytes/Defender status; explain custom and deep scans |
| 21 | Scr 18c: protect the screen during an overnight scan; give average scan times from our own logs |
| 23 | Scr 19: too long, split, approval under each item |
| 25 | **Reorganise the Tool folder** -- you have started this yourself |
| 28 | Scr 23: explain what the next screens will do, with a synopsis of each |
| 29 | Scr 24: pros and cons per setting; why sleep shows Active; Back forces re-answering |
| 30 | Scr 25: change setting 6's status wording |
| 31 | Scr 26: column widths; "we will show you how"; is 17 Pro-only |
| 37 | Setting 9 Windows Hello: what it does and why |

### Research you asked for and I have not done

**Finding 16:** whether Defender's offline scan can be made to cover all
connected drives. Not started.

---

## WHY SO LITTLE

**The day went into diagnosis rather than construction**, and two of those
diagnoses were wrong before they were right:

- FT-193 needed the log read, three theories, a purpose-built probe, and the
  probe disproving my own theory before the fix could be written honestly.
- FT-185 turned out to need **no** fix -- Tamper Protection blocks every read,
  so `Unknown` is the truthful answer and only the label is wrong.
- FT-192 was found: I had written *"Windows shows you the key when encryption
  starts"* into SCREEN-79 on the 17th, and **Windows 11 Home shows nothing.**

**The wording and screen-splitting work is the largest remaining block and none
of it is blocked on anything.** It is the obvious content of ascii43.
