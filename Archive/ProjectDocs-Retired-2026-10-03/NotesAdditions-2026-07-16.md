<!-- Dated: 2026-07-16 18:25 EDT -->
<!-- File: NotesAdditions-2026-07-16.md -->
<!-- Append to GatewayGuard_ProjectNotes.md -->

## SCREEN-SHARE OFFERINGS -- REMOVED FROM ALL CURRENT SCOPE (July 16, 2026)

DECISION (refined July 16, 2026):
- Paid assisted sessions: roadmap only. Not offered, not marketed.
- General beta program: SELF-RUN model -- tester runs GatewayGuard
  on their own PC and submits: (1) the log file, (2) their own notes
  and suggestions -- what they liked, what they didn't, anything
  confusing. Free license in return. Feedback notes are as valuable
  as the log: the log shows what the tool did; the notes show what
  the USER experienced.
- EXCEPTION: the first 10-20 Founding Member beta testers may still
  receive a free remote screen-share testing session with Bill --
  BY INVITATION ONLY. This is not advertised on the website or in
  any marketing material; it is handled directly with those testers.
- No screen-share offering of any kind appears on the website.

IMPACT:
- [ ] Home page r3: rewrite beta teaser (remove "over a screen share")
- [ ] beta.html spec: offer changes to self-run model -- tester runs
      GatewayGuard on their own PC and submits the log file in
      exchange for a free license (matches Round 5 field methodology)
      CONFIRM offer wording with Bill before page build
- [ ] MarketResearch differentiator "HUMAN-ASSISTED SESSIONS" line:
      mark roadmap-only
- [ ] Pricing table: Assisted Session $39-49 line: mark roadmap-only
- [ ] PresentationCompanionSheet already says "planned as a future
      offering" -- consistent, no change needed

## FRENCH CANADA RESEARCH (July 16, 2026)

DIALECT: Quebec French (Quebecois) -- the large majority of Canadian
francophones are in Quebec; smaller Acadian French community in New
Brunswick. Target locale for any French version: fr-CA, NOT fr-FR.

KEY VOCABULARY DIFFERENCES (everyday computing terms the guide uses):
- courriel (email), telecharger/televerser (download/upload),
  clavardage (chat), naviguer (browse), fichier (file)
- Official free terminology source: Grand dictionnaire terminologique
  from the OQLF (Office quebecois de la langue francaise)

LEGAL NOTE (add to attorney agenda): Quebec's Charter of the French
Language (Bill 96) sets French-availability requirements for software
and commerce in Quebec. Practical exposure for a small US Gumroad
seller is limited, but a real fr-CA version converts a compliance
question into a marketing advantage in an underserved market.

PAID REVIEW SERVICE: Yes -- the credential is OTTIAQ certification
(Quebec's professional order of translators). Quebec agencies
(e.g., Frenchside, KNR Montreal, GTS) offer fr-CA software/website
localization and linguistic QA by OTTIAQ-certified translators.
RECOMMENDED WORKFLOW: draft fr-CA in-house (Claude), then hire an
OTTIAQ-certified reviewer for a linguistic + cultural QA pass --
review of existing text costs a fraction of from-scratch translation.
Approximate market rates: translation ~$0.20-0.30 CAD/word;
revision/QA substantially less. Get real quotes before committing.

STATUS: Research item -- no build commitment. French version is
post-launch scope at earliest.

## GUIDE FONT EDITIONS (decided July 16, 2026)

The $8.99 Guide ships as ONE Gumroad product containing FIVE PDF
editions (decided July 16) -- buyer downloads whichever suits their
eyes:
| Edition | Size |
|---------|------|
| Compact (ink-saver) | 12 pt |
| Standard | 14 pt (default) |
| Comfort | 16 pt |
| Large Print | 18 pt (publishing-standard large print) |
| Extra Large | 20 pt |

MARKETING FRAMING: pitch leads with the 14-20 pt size choice;
12 pt gets the closing line: "And for you ink-savers, a 12 pt
edition is included as well -- only X pages."
OPEN: X = actual page count. Guide source file
(windows_security_walkthrough_guide_v9.docx) is NOT in the project
workspace and no page count is recorded. Upload it to generate all
five editions and measure real counts.

- Single master document; sizes are a formatting pass, regenerated
  together on every guide revision (one date bump across all four)
- Extra Large edition needs its own proofing pass (screenshot
  placement/page breaks), not just a font swap
- Product page line: "Includes four editions: Compact, Standard,
  Large Print, and Extra Large -- choose whichever is easiest on
  your eyes."
- Filename convention: GatewayGuard_Guide-LargePrint-18pt-YYYY-MM-DD.pdf

## RESEARCH / TEST ITEM — Mouse Pointer Size & Scroll Behavior (July 16, 2026)

OBSERVATION (Bill, Dell Latitude 5430 / Win 11 Pro): Keeping the
mouse pointer at size 1 (smallest) appears to produce smoother,
slower scrolling. Larger pointer sizes cause the screen to jump
further than intended -- either past the target or back further
than desired.

TEST TO DESIGN (August, pre-launch):
- Controlled comparison: pointer size 1 vs. 3 vs. 5 (or similar
  spread) on same machine, same content, same scroll action
- Test on at least two machines (Pro + Home) to see if behavior
  is hardware-specific or Windows-wide
- Document: is the jump consistent, reproducible, content-dependent
  (long page vs. short)? Any relation to display scaling or DPI?
- If confirmed: evaluate whether GatewayGuard should recommend or
  set pointer size as part of the convenience settings review
- If confirmed on multiple machines: potential tips.html entry
  ("Why your screen jumps when you scroll -- and the 30-second fix")

STATUS: Observation only. Schedule test for August during pre-launch
QA window. Do not act on or document as confirmed behavior until
tested.

## RESEARCH / TEST ITEM — Cursor Visibility: Size & Color (July 16, 2026)

OBSERVATION (Bill): Cursor color matters as much as size. Black
cursor stands out clearly on a white/light screen. Default white
cursor with small shadow can be hard to locate, especially for
older eyes or on bright displays.

Windows 11 allows: pointer size (1-15), pointer color (white /
black / custom color), and pointer shadow toggle.
Location: Settings → Accessibility → Mouse pointer and touch

POTENTIAL tips.html ENTRY:
"Can't find your cursor? Two changes that make it easy to spot."
- Switch color to black (high contrast on most screens)
- Bump size to 2 or 3 (visible without affecting scroll behavior
  per the pointer-size scroll test above -- cross-reference results)
- Optional: enable pointer shadow for extra depth on light backgrounds

LINK TO SCROLL TEST: pointer size and color should be tested
together in the August scroll-behavior test -- record which
combination gives best visibility WITHOUT triggering scroll jumping.
Ideal outcome: a single recommended setting (e.g. size 2, black)
that solves both problems at once.

POSSIBLE GUIDE / TOOL ADDITION: if a "sweet spot" setting is
confirmed by testing, add to GatewayGuard convenience settings
review as an optional recommendation -- "make your cursor easier
to see."

STATUS: Observation. Bundle into August pointer/scroll test.
Do not document as confirmed until tested.

## CURSOR / TEXT CURSOR SETTINGS — RESEARCH COMPLETE (July 16, 2026)

Windows 11 already supports everything discussed -- all built-in,
no third-party tools, all in Settings → Accessibility.

MOUSE POINTER (Settings → Accessibility → Mouse pointer and touch):
- Size: 1-15
- Color: white / black / custom RGB
- Recommendation pending August test: black, size ~2

TEXT CURSOR (Settings → Accessibility → Text cursor):
- Text cursor indicator: ON/OFF toggle -- adds colored markers
  ABOVE AND BELOW the blinking line (they blink with it, so the
  whole indicator pulses -- this IS the "blink the whole thing" idea)
- Indicator color: preset or custom RGB
- Indicator size: slider
- Text cursor thickness: slider (makes the blinking line wider)
- Blink rate: 200ms-1300ms slider, or OFF entirely via
  Control Panel → Keyboard → Speed tab

TIPS.HTML ENTRY (confirmed -- ready to write when page is built):
Title: "Can't find your cursor? Windows 11 has fixes built right in."
Covers:
1. Mouse pointer: black, size 2 (pending August test confirmation)
2. Text cursor indicator: colored markers above/below, any color
3. Text cursor thickness: make the line itself wider
4. Blink rate: slow it down or turn it off
All in Settings → Accessibility. Two locations: "Mouse pointer and
touch" and "Text cursor." Takes 2 minutes.

NOTE: Two separate things share the word "cursor" -- important to
clarify for non-technical users in the tip:
- Mouse POINTER -- the arrow that moves when you move the mouse
- Text CURSOR -- the blinking line that shows where you're typing
Both are customizable; they have separate settings panels.

## TIPS.HTML ENTRY — Screen Too Wide / Missing Scrollbars (July 16, 2026)

OBSERVATION (Bill, live issue): Screen appeared too wide with no
scroll arrows; Win+Up arrow and Ctrl+Shift+R did not fix it.

TIPS.HTML ENTRY (ready to write when page is built):
Title: "Your screen looks wrong? Six fixes that take 10 seconds each."
1. F11 -- toggles browser full-screen on/off (most common cause)
2. Ctrl+minus -- zoom out; page may not be too wide, just zoomed in
3. Windows key + left/right arrow -- snap window to half screen,
   then Windows+Up to re-maximize properly
4. Alt+Space, then R -- Restore: un-maximizes and resets window size
5. Windows key + D -- show desktop, resets some display states
6. Ctrl+Shift+J (Chrome) / Ctrl+Shift+K (Edge/Firefox) -- closes
   accidentally-opened browser console panel
LAST RESORT: Ctrl+Alt+Delete → Sign out -- faster than full restart,
usually fixes display state in under 30 seconds.

AUDIENCE NOTE: non-technical users often don't know these shortcuts
exist and assume logout/restart is the only fix. The value of this
tip is showing them the 10-second version first.

LINK TO: cursor tip page (same Accessibility location); consider
grouping as "When your screen looks wrong" category on tips.html.

## TIPS.HTML UPDATE — Ctrl+0 Zoom Reset (July 16, 2026)

CONFIRMED FIX (Bill, live): Page appeared too wide with no scrollbar.
Cause: browser zoom on that tab had been bumped accidentally.
Fix: Ctrl+0 (zero) -- resets browser zoom on current tab to 100%.
One keystroke, instant, works in Chrome/Edge/Firefox.

UPDATE tip #4 to lead with this -- it's the most common cause:

REVISED TIP ORDER:
1. Ctrl+0 -- reset zoom on this tab (most common cause of
   "page too wide" -- accidentally zoomed with Ctrl+scroll wheel)
2. F11 -- toggle full-screen off
3. Ctrl+minus -- zoom out gradually if Ctrl+0 feels too abrupt
4. Windows+Left/Right then Windows+Up -- re-maximize window
5. Alt+Space, R -- Restore window size
6. Ctrl+Alt+Delete → Sign out -- last resort, under 30 seconds

HOW IT HAPPENS: Ctrl+scroll wheel zooms the page without the user
realizing it. Very common on laptops with touchpads. Non-technical
users rarely connect "I scrolled" with "the page changed size."

AUDIENCE VALUE: this is the #1 "my computer is broken" call that
isn't actually broken. Knowing Ctrl+0 exists saves a phone call
to a family member or a trip to the store.

## FT-90 REVISED -- MB Trial Locked State (July 16, 2026)

OBSERVATION (Bill, Dell / Win 11 Pro / MB Trial):
When Defender tamper protection is ON, MB Trial enters a locked/passive
state -- 90%+ of MB settings greyed out and inaccessible in the UI.
MB tamper protection itself is OFF but unreachable. MB appears to
detect it is not primary AV and deliberately steps back.

This is NOT a tool bug -- it is MB's designed behavior when Defender
is primary. But the tool currently does not detect or explain this
state, and may be returning silent failures or wrong statuses when
attempting to read/check MB settings in this condition.

BEFORE ascii32 CAN TOUCH MB LOGIC -- REQUIRED RESEARCH:
1. Full audit of which MB settings are visible vs greyed out in
   MB Trial when Defender tamper is ON
2. Full audit of same when Defender tamper is OFF
3. Determine which MB states are readable via PowerShell/WMI when
   the UI is greyed out -- the tool may be reading nothing
4. Map all MB states the tool needs to handle:

   | MB Version | Defender Tamper | MB UI State | Tool behavior needed |
   |------------|-----------------|-------------|----------------------|
   | Premium    | ON              | Partial lock| Detect + explain     |
   | Premium    | OFF             | Full access | Normal check         |
   | Trial      | ON              | ~90% locked | Detect + explain     |
   | Trial      | OFF             | More access | Check what's visible |
   | Free       | ON              | TBD         | TBD                  |
   | Free       | OFF             | TBD         | TBD                  |
   | Absent     | ON              | N/A         | Already handled      |
   | Absent     | OFF             | N/A         | Already handled      |

5. For each locked state: what should the tool tell the user?
   Draft copy: "Malwarebytes has stepped back because Windows
   Defender is your active protection right now. Most MB settings
   are not accessible in this mode -- this is normal. What you
   need to know: [X]"

STATUS: Research required before any MB logic changes in ascii32+.
Assign to: manual testing on Dell (MB Trial + Defender tamper ON/OFF).
BLOCKER: Do not change MB screen logic until this matrix is complete.
