<!-- Dated: 2026-08-22 22:20 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Bill's HTML website review -- all 19 pages, 24 items

- **Document Name:** GatewayGuard_HtmlWebsiteReview
- **Last Modified:** 2026-08-22 22:20 ET
- **Reviewed by:** Bill, at the keyboard, 2026-08-22 16:30
- **Source:** `Test_Results\Html_Website_Review__by_Bill.docx` and its `.txt`.
  **This file is the readable twin.** The `.docx` is unreadable to Cloud, the
  `.txt` is cp1252 and does not decode as UTF-8, and **neither lives in the
  connector scope** -- `Test_Results\` is not synced. Without this copy in
  `ProjectDocs\`, Cloud cannot see one word of this review.
- **Five screenshots extracted** to `Test_Results\Html_Website_Review-images\`,
  renamed for the items they belong to. Cloud cannot open them; Bill and Claude
  Code can.

**Change History Log:**
- 2026-08-22 22:20: Created from Bill's review. His text is **verbatim** --
  decoded from cp1252 and normalised to ASCII (curly quotes and non-breaking
  spaces only). Nothing reworded, nothing corrected. The triage lines are
  Claude Code's and are marked as such.

---

## WAITING FOR BILL -- READ THIS FIRST WHEN YOU GET BACK

**Eleven A items are done and pushed.** What is below is everything I could not
settle without you. Q1 is CLOSED -- Bill kept the override. Nothing below blocks the copy pass.

### THE ONE THAT CHANGES A DECISION YOU ALREADY MADE

**Q1. CLOSED 2026-08-22. Bill: "keep your override on tamper protection."**
~~I overruled your item 18 wording, deliberately. Confirm or reverse.~~ The
override **stands and is now the decision**, not one Claude's judgment call.

For the record of what was overruled and why: item 18 asked for *"If Tamper
Protection was off, Checkup flagged it and with your approval will offer to
turn it on."* **Checkup cannot turn it on** -- `CanAuto=$false`, and the tool
itself prints *"MANUAL ACTION REQUIRED"*. The page's own **Found** line already
said so, so the page contradicted itself two lines apart. Bill wrote the item
without that measurement in front of him.

**The live wording:** *"If Tamper Protection was off, Checkup flagged it and
showed you the exact steps to turn it on yourself. Windows does not allow any
program to change this one, so this is the one setting on this page you have to
do by hand -- the steps are below."*

**This also settles the general case, and it is worth stating as a rule:**
where a written instruction and a measurement of the build disagree, **the
build wins and the instruction gets re-asked** -- rather than being applied and
quietly shipping a claim the product cannot honour. Bill ratified that here on
the first occasion it came up.

**Q2. Item 18's other half is built on a false premise.** You wrote *"the
offline scan which we can tell them Checkup does automatically."* **It does
not, and that is deliberate** -- `Start-MpWDOScan` reboots the machine on the
spot and cannot be queued, so a 2AM scheduled scan would restart a sleeping
user's PC four times a year. The quarterly task is a **reminder**. The true
sentence is *"Checkup offers to run it during a check-up, and reminds you every
three months."* **Do you want that added?**

### THE ONE THING THAT STOPPED ME MID-FIX

**Q3. Item 7, the Windows 11 Pro route for Startup Boost.** Your note reads
*"scroll down ... then select manage account and then select hardware
acceleration and then I could see the two settings."* **I cannot reconcile
"manage account" with Edge's System and performance page**, and guessing at a
click path is what put four wrong paths on the site in the first place. **The
Home half is applied.** For Pro: open Edge, and tell me the exact sequence of
things you click. A screenshot is easier than typing it.

### PRODUCT DECISIONS -- NEITHER CLAUDE CAN MAKE THESE

- **Q4, item 5.** Cloud protection and automatic sample submission: **add them
  to Checkup's 19 settings, or explain them on the site and leave them alone?**
  You said discuss. Adding them makes it 21 settings and touches the build, the
  guide and the site.
- **Q5, item 15.** Reputation-based protection has a fourth item. **What is our
  position on it?** The page covers three.
- **Q6, item 10.** Advanced firewall settings, especially inbound rules --
  **in scope, or out?** My instinct is out: inbound rules are where a
  non-technical user can lock themselves out of their own network, and the
  three profiles being On is the 95% win. But it is your call.
- **Q7, item 22.** Windows Hello on a local account says *"currently not
  available."* **Do we tell people upfront to create or sign in to a Microsoft
  account?** That is a real product position, not a wording choice -- it is
  also the same question the guide's setting 9 rewrite ran into.
- **Q8, item 23.** Windows Update Advanced options has three items. **Does
  Checkup check them, and should it?** Related to Q4 -- same shape.
- **Q9, item 20.** Wake on LAN. You found a **disabled Realtek adapter on SANDY
  that could not be checked** and may be a hole if it is ever enabled. You asked
  to review this together. **Held.**

### AND ONE FROM EARLIER TODAY, STILL OPEN

- **Q10, M-4.** Two approved versions of the same sentence live in the
  marketing plan: *"One-time purchase. Updates are optional."* and *"One-time
  purchase, yours to keep. Annual updates are optional."* **My recommendation
  is the long one everywhere.** One word from you closes it.

---

## ITEM 2 -- THE PHRASING OPTIONS YOU ASKED FOR

**I inventoried the "Action taken" line on all 19 pages first**, because you
cannot pick one phrasing without seeing what is actually there. **There are
four different shapes**, and the split is not random:

| Shape | Pages | Example |
|---|---|---|
| **Past, asserted** | 7 | *"Checkup turned off the Advertising ID with your approval."* |
| **Past, conditional** | 6 | *"If any profile was off, Checkup flagged it and offered to turn it on."* |
| **Present, review-only** | 2 | *"Checkup reviews your Windows Hello setup and flags it..."* |
| **Mixed** | 4 | *"If it was off and your PC can support it, Checkup asked for your approval and turned it on."* |

**The real problem is not that there are four. It is that the past tense is
wrong on every page.** These pages are read **before** purchase as well as
after -- they are the trust ladder. Telling a reader *"Checkup turned off your
Advertising ID"* when they have never run it is simply false for most visitors.

**Your own item 6 wording already fixes this**, and it is why I think you
landed on it instinctively: *"With your approval, Checkup will set Diagnostic
data to Required diagnostic data."* **Permission first, future tense, no claim
about what already happened.**

### THE THREE OPTIONS

**Option 1 -- your item 6 pattern, applied to all 19.**
> *"With your approval, Checkup will [do the thing]."*

Shortest, and it is already your voice. Works for every page. **The one gap:**
it does not distinguish the settings Checkup **cannot** change, so those two
pages need the second sentence anyway.

**Option 2 -- the same, with a stated fallback. My recommendation.**
> *"With your approval, Checkup will [do the thing]."*
> and, where Windows forbids it:
> *"Windows does not allow any program to change this one, so Checkup shows you
> the exact steps to do it yourself."*

**Two sentences, one rule, and it cannot produce the Tamper Protection defect**
-- because the second form exists precisely for the settings the first one
cannot honestly claim. That second sentence is already the house wording in
CLAUDE.md, and it is already on two pages.

**Option 3 -- name the state as well as the action.**
> *"If [the setting] was off, Checkup will flag it and, with your approval,
> turn it on."*

Most precise, closest to what the conditional pages already say. **But it is
longer on every page, and the "if it was off" clause is noise on the pages
where the answer is nearly always the same.**

**Pick one and I will sweep all 19 in a single pass**, with the two `CanAuto`
exceptions handled by the second sentence.

---

## WHO LOOKS FIRST -- CLAUDE CODE, AND IT IS NOT CLOSE

**Bill asked me to decide. Two facts force it.**

**1. Cloud cannot see the website.** `WebSite\html\` is outside the connector
scope, and so is `Test_Results\`. Cloud reads the website only through
`GatewayGuard_WebsiteSourcePack-*.md`. **It cannot verify a single navigation
path and it cannot open a screenshot.**

**2. Eleven of the twenty-four items are factual corrections Bill measured at
the keyboard** -- wrong menu paths on a live site, telling seniors to click
things that are not on their screen. Items 1, 4, 7, 9, 10, 11, 15, 16, 20, 22
and 23. **Those are the dangerous ones**, and settling them needs the repo, the
build and a machine.

**If Cloud went first it would write polished copy onto pages whose facts are
about to change** -- wasted work, and a conflict against edits it cannot see.

### THE ORDER

**Claude Code first**, producing three things:

1. **The factual fixes** -- every measured path corrected across the 19 pages.
2. **An inventory of the current "Action taken" phrasings**, all 19 pages. Item
   2 asks for *options for one phrasing to use with them all*; that cannot be
   answered without first knowing what is actually there.
3. **The answer to item 17's real question.**

**Then Cloud**, on the copy pass -- items 2, 3, 6, 8, 13, 18, 19, 21 -- working
from a regenerated source pack, against facts that have stopped moving.

**Then Bill**, on what neither Claude can decide: items 5, the fourth item in
15, 20, 22, and the item 17 scope question.

### ITEM 17 IS THE ONE THAT MATTERS MOST, AND IT IS NOT A WEBSITE QUESTION

> *"Are we making all these changes we are recommending on the website in
> Checkup?"*

**Nobody has answered this.** If the site recommends settings Checkup does not
touch, then either the tool is incomplete or the site is overpromising -- and
**the guide, the tool and all 19 pages inherit the answer.** It governs items 5,
10, 18, 21 and 23 as well. **Settle it before the copy pass, not after.**

### WHAT IS NEW WORK RATHER THAN A CORRECTION

Three items ask for things that do not exist yet, and should not be mistaken
for edits:

- **Item 4 -- a BitLocker recovery-key backup plan**, written twice, for Home
  and for Pro. Bill also intends to **decrypt CGDELL and walk the whole
  process.** *That is the same machine and the same operation that would settle
  the BitLocker recovery-key VERIFY claim in the guide -- the claim that can
  cost a reader their files if it is wrong. **One trip, two jobs. Do them
  together.***
- **Item 13** -- a donation and word-of-mouth pitch on every page.
- **Item 19** -- an explanation of how Checkup automates the manual steps.

### THE CLASS CODES BELOW

| Code | Means |
|---|---|
| **A** | Factual or measured. Claude Code, first |
| **B** | Copy or wording sweep. Cloud, once the facts settle |
| **C** | Product decision. Bill |
| **D** | Research needed before anything is written |

---

## ITEM 17 ANSWERED, 2026-08-22 22:40 -- MEASURED AGAINST THE BUILD

> *"Are we making all these changes we are recommending on the website in
> Checkup?"*

**Answer: 17 of 19 yes. 2 of 19 no. One of those two was lying about it.**

Measured by extracting the settings table from
`Tool\W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1` and matching all
nineteen `ID=` rows against the nineteen pages. **The mapping is exact --
one page per setting, no page without a setting, no setting without a page.**

**`CanAuto=$false` on exactly two settings:**

| ID | Setting | Page | What the page claimed |
|---|---|---|---|
| **3** | Tamper Protection | `tamper-protection.html` | **WRONG -- said Checkup would offer to turn it on** |
| **9** | Windows Hello | `windows-hello.html` | Correct -- says Checkup cannot, and why |

### THE TAMPER PROTECTION PAGE CONTRADICTED ITSELF, IN TWO ADJACENT LINES

Its **Found** line already carried the correct house wording:

> *"Windows does not allow any program to change this one, so Checkup shows you
> the exact steps to turn it on yourself."*

Its **Action taken** line, directly beneath, said Checkup *"flagged it and
offered to turn it on."* **Both were on the page at once, and the second one is
false.** `CanAuto=$false` at line 5620, whose own description reads *"Manual
toggle required in Windows Security"*, and line 6351 prints **"MANUAL ACTION
REQUIRED"** to the user.

**This is why item 17 was the right question to ask first.** It is not a
wording problem. It is the tool and the website disagreeing about what the
product does.

### I DEPARTED FROM BILL'S ITEM 18 WORDING, DELIBERATELY

Item 18 asked for: *"If Tamper Protection was off, Checkup flagged it and with
your approval will offer to turn it on."* **I applied that, then measured the
build and took it back out** -- it keeps the false promise, in different words.
Bill wrote it without knowing `CanAuto=$false`.

**Now reads:** *"If Tamper Protection was off, Checkup flagged it and showed you
the exact steps to turn it on yourself. Windows does not allow any program to
change this one, so this is the one setting on this page you have to do by hand
-- the steps are below."*

**RATIFIED BY BILL, 2026-08-22:** *"keep your override on tamper protection."*
Shipping a promise the tool cannot keep was the worse of the two errors, and it
is the exact case CLAUDE.md already legislates: *"Where Windows forbids
programmatic change, say that instead."* **The override is now the decision.**

### ITEM 18'S SECOND HALF RESTS ON A FALSE PREMISE

> *"No mention of the offline scan which we can tell them Checkup does
> automatically."*

**Checkup does not do the offline scan automatically, and that is deliberate.**

- **In an interactive run** it offers the scan and runs `Start-MpWDOScan` with
  the user's permission (line 4375). That reboots the machine immediately.
- **The quarterly scheduled task is a REMINDER, not a scan** (line 7115). The
  comment block gives the reason, sourced to Microsoft: `Start-MpWDOScan`
  *"causes the computer to start in Windows Defender offline and begin the
  scan"* -- it cannot be queued for a later restart. As a SYSTEM task at 2AM it
  would **restart a sleeping user's PC without warning, four times a year.**
- This is the FT-175 / FT-162 history: the task used to run
  `MpCmdRun.exe -Scan -ScanType 4`, **a switch that does not exist**, returning
  `0x80070667` in 0.0 seconds while the log printed `[GOOD]`.

**So the sentence to add is not "Checkup does this automatically."** The true
one is *"Checkup offers to run it during a check-up, and reminds you every
three months."* **Not added -- it needs Bill's word, because it is his claim
that changes.**

### THE OTHER SEVENTEEN

All `CanAuto=$true`. **Setting 10, Remote Desktop, additionally carries
`SkipOnHome=$true`** -- correct, and the page already says Windows 11 Home has
no such setting.

**This answer governs items 5, 10, 18, 21 and 23**, and it is the input the
copy pass needs before any of them is reworded.

---

## BILL'S REVIEW, VERBATIM

### Item 1  --  `A`

> Advertising iD instructions is wrong. Change to select Settings, select Privacy and Security , select Recommendations and offers, Find Advertising ID - Let apps show me personalized ads by using my advertising ID. The toggle should be Off. If it is On, click it to turn it Off. Fix both turn it on and turn it off.

*Triage: Nav path measured wrong on a live page*

### Item 2  --  `B`

> Also throughout the .htmls there is a whole lot of different phrasing used in the Action taken item. Review my comments below and all the action taken items wording and give me options of one phrasing to uss with them all.

*Triage: Unify the "Action taken" phrasing across 19 pages -- needs the inventory first*

### Item 3  --  `B`

> Change this everywhere What Checkup found and did to " What Checkup found and we recommend you do" or somesuch wording.

*Triage: Rename "What Checkup found and did" everywhere*

### Item 4  --  `A+C`

> Bitlocker instructions are wrong. Home : type encryption, seleect encryption settings, if it is off turn it on. Pro: type windows, open windows security, in the left-hand panel select device security, select manage bitlocker drive encryption, if it is on then there is nothing to do. If it is off turn it on. And establish a bitlocker backup plan in the eventuality that you need to use your bitlocker key (write them one for both home and pro) I will need to unencrypt cgdell and go through the whole process at some point soon.

*Triage: Home and Pro paths wrong, plus a NEW deliverable -- the recovery-key backup plan*

### Item 5  --  `C`

> Real-time Defender -- OK, but we should add the other two settings cloud and auto sample to our list of settings in checkup or at least explain them and request they appove them as well and then turn them on if off. We need to discuss. Tamper Protection is there in the same list and should be turned on if it is off, and we already have it listed in settings screen. Lets discuss

*Triage: Add cloud protection and auto sample submission to Checkup? Bill said discuss*

### Item 6  --  `B`

> Diagnostic Data -- rewrite to "With your approval, Checkup will set Diagnostic data to Required diagnostic data. This type of wording should appear throughout all the website .htmls. Check all ,htmls and change wording to what is in the quotes. Same goes for wording in checkup and the guide.

*Triage: Permission wording pattern -- website AND Checkup AND guide*

### Item 7  --  `A`

> Startup Boost -- Instructions are wrong. Home: I had to select Startup Boost first and then I could see the two settings. Pro: I had to first scroll down or use my down arrows key or page down key to get to settings, then select manage account and then select hardware acceleration and then I could see the two settings.

*Triage: Home and Pro paths measured wrong*

### Item 8  --  `B`

> Aside: Everywhere we tell them to check settings tell them to first scroll down or use down arrow key or page down key to get to settings,

*Triage: Add the scroll-down instruction everywhere*

### Item 9  --  `A`

> Fast Startup -- Change to this wording "Under Shutdown settings, If checked, remove the checkmark from Turn on fast startup (recommended).

*Triage: Exact replacement wording given*

### Item 10  --  `A+C`

> Firewall & Network Protection -- the first screen shows all three on or off. You only need to click one if it is off to change it to on. What about checking advanced settings, especially inbound settins

*Triage: First screen shows all three; advanced and inbound rules is a scope question*

### Item 11  --  `A+B`

> Memory Integrity -- change wording to "Look at the Memory integrity setting, if it is off, turn it on an then restart your PC when Windows asks. What happens in Checkoff? Tell them.

*Triage: Wording given, plus "what happens in Checkup" needs the build read*

### Item 12  --  `-`

> Edge Passwords Saving -- ok

*Triage: No action -- Bill marked it OK*

### Item 13  --  `B`

> Aside write a pitch on every screen that quite an effort and testing went into making these free instructions, a donation would be appreciated as well as letting your friends and acquaintances know about our website gatewayguard.co NOT .com) or some such wording.

*Triage: Donation and word-of-mouth pitch on every page*

### Item 14  --  `D`

> Periodic Scanning -- defender is running on sandy and cgdell and sandy3. Confirm these instructions with experts and forums and Microsoft support,

*Triage: Confirm the periodic-scanning guidance against Microsoft and forums*

### Item 15  --  `A+C`

> Phishing -- Change wording to "With your approval Checkup will flag them and offer to turn them on." What is our position on the 4th item. See image and rewrite this.

**Screenshot:** `Test_Results\Html_Website_Review-images\item15-phishing.png`

*Triage: Wording given; the 4th item needs a position. Screenshot attached*

### Item 16  --  `A`

> Remote Desktoo Connection -- Home & Pro: when you open it a screen pops up nowhere to turnit off I had to select options on the first screen to get the second screen to appear. Rewrite and discuss with me. See below: r

**Screenshot:** `Test_Results\Html_Website_Review-images\item16-17-remote-desktop-first-screen.png`
**Screenshot:** `Test_Results\Html_Website_Review-images\item16-remote-desktop-options-screen.png`

*Triage: Measured wrong -- the Options click is needed. Two screenshots*

### Item 17  --  `B+C`

> Smartscreen -- Insttruction is good but rewrite checkup action. This question applies to all the ,htmls. Are we making all these changes we are recommending on the website in Checkup?

**Screenshot:** `Test_Results\Html_Website_Review-images\item16-17-remote-desktop-first-screen.png`

*Triage: Rewrite the action, AND the scope question -- see above*

### Item 18  --  `B`

> Tamper Protection -- change action to "If Tamper Protection was off, Checkup flagged it and with your approval will offer to turn it on, No mention of the offline scan which we can tell them Checkup does autormatically.

*Triage: Action rewrite given, plus the offline scan goes unmentioned*

### Item 19  --  `B`

> Aside: Write something about how Checkup will automate and step you through manual instructions where necessary. This will save you some time and do some of the tasks for you. Reword into something that will strike a sn understanding in seniors. Also mention how there are other setting we will be reviewing and including in our Checkup and Security Guide.

*Triage: Write the automation explanation for seniors*

### Item 20  --  `A+C`

> Wake on Lan -- Sandy had 3 a realteck controller, a realteck adaptor which was disabled and a wife usb. You couldn't check the realteck adaptor as it was disabled. This may leave a security hole if it is a working adaptor and they enable it in the future. On cgdell and sandy there is also a number of wan miniports, none of which have a power management section. On cgdell no power management section, you have to go to advanced see two images of all the possible settings lets review this together when you get to this part. Ask questions.:

**Screenshot:** `Test_Results\Html_Website_Review-images\item20-wake-on-lan-advanced-1.png`
**Screenshot:** `Test_Results\Html_Website_Review-images\item20-wake-on-lan-advanced-2.png`

*Triage: A disabled SANDY adapter is a possible security hole. Two screenshots. Bill wants to review this together*

### Item 21  --  `D+B`

> Widgets -- We need to research with experts, forums and MS support, what people use it for and what capabilities are going to be lost and explain that. Discuss with me. Rewrite Action item with whatever phrase we settle on.

*Triage: Research what Widgets actually does, then rewrite*

### Item 22  --  `A+C`

> Windows hello -- Sandy it says this option is currently not available -- I am on a local account with admin rights and have to enter a pin. We need to take this into consideration if a user runs into this situation. Upfront do we tell them to sign on to or create an MS account? On CGDell My windows hello after bootup was turned off but I still had to enter my pin after hibernate. Sleep is set to never so it won't sleep even if you select sleep instead of hibernate.

*Triage: SANDY local account blocks Hello; CGDELL asks for a PIN after hibernate. MS-account question*

### Item 23  --  `A+C`

> Windows Update -- CGDell said windows update settings and it took me to windows update which said resume updates because I had them paused until 2026-09-06. We need to rewrite to take different circumstances into consideration. Sandy also paused to that date. Does Checkup check for the 3 items in Advanced options and do we tell them about it in Checkup. If not can we check on them and turn them on.

*Triage: Updates paused; do we check the three Advanced options items* 

### Item 24  --  `D`

> Aside are you aware of the MS word accessibility assistant to help readers. If not research it and make sure all of our public documents adhere to it, if we can. Make this a rule.

*Triage: MS Word Accessibility Assistant -- research, then make it a rule*
