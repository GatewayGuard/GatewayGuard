<!-- Dated: 2026-08-24 02:22 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Q2 answered, and drafts for items 8, 13 and 19

- **Document Name:** GatewayGuard_Q2AndCopyDrafts
- **Last Modified:** 2026-08-24 02:22 ET
- **Answers:** Bill's three questions of 2026-08-24
- **Status:** Q2 needs one decision from Bill. Items 8, 13 and 19 are drafted
  and ready to apply.

---

## 1. Q2 -- CAN CHECKUP RUN THE FULL SCAN AFTER THE OFFLINE SCAN AUTOMATICALLY?

**Short answer: the cmdlet works and the hook already exists, but "after the
offline scan" cannot mean unattended, and Microsoft advises against the routine
version. My recommendation is to OFFER it, not run it.**

### WHAT IS TRUE -- ALL MEASURED OR SOURCED

**1. The cmdlet exists and does what is wanted.** *measured 2026-08-24 on
CGDELL:*

```
Start-MpScan EXISTS - source: ConfigDefender v1.0
ScanType values: FullScan, QuickScan, CustomScan
AsJob supported: True
```

**2. A full scan covers every drive. This settles F4's scope question.**
*sourced, Microsoft Defender full scan considerations and best practices,
updated 2026-04-13:*

> *"A full scan starts with a quick scan, and then continues with a sequential
> file scan of all the fixed and removable network drives that are mounted."*

**So `Start-MpScan -ScanType FullScan` is the answer to FT-167 and to route 3.**
No scope parameter is needed, because there is no scope to set -- it takes
everything. That is the measurement F4's screen text was gate-24-blocked on,
and it is now sourced rather than assumed. It still wants one confirming run on
SANDY, which is the only machine here with a second drive.

**3. The build already has the hook.** `Show-PreScanGate`, line 4231:

```powershell
if ($global:ResumeFrom -eq "OfflineScanPending") {
    Show-PostScanGuidance
    return
}
```

That branch fires exactly once -- when the user comes back after the
offline-scan reboot. It is the natural home for this.

### THE TWO THINGS THAT SAY "OFFER", NOT "RUN"

**A. NOTHING RESTARTS CHECKUP AFTER THE REBOOT.** *measured: `grep -n
"RunOnce|Register-ScheduledTask|schtasks"` on ascii43 returns only the
quarterly and monthly reminder tasks.* `Save-Checkpoint` writes a state file
and nothing else. `Start-MpWDOScan` reboots the machine and the script calls
`exit` on the next line.

**So when the PC comes back, Checkup is not running.** The user launches it
again themselves and presses **R** to resume. Anything "automatic" would need a
**RunOnce** key or a scheduled task to relaunch Checkup at logon -- a new
mechanism, and a program that restarts itself after a reboot is uncomfortably
close in shape to the self-elevation that Malwarebytes already flagged on this
product. **Not worth earning that fight for a scan the user can approve in one
keystroke.**

**B. MICROSOFT SAYS MOST PEOPLE SHOULD NEVER RUN ONE.** *sourced, same page:*

> *"Our recommendation for scheduled scans is to configure quick scan together
> with always-on real-time protection and cloud protection... In general,
> there's no need to schedule a full scan, and most users never need to
> manually run full scans."*

> *"A full scan can last from several hours to several days, depending on the
> content volume, type of content, and the resources that Microsoft Defender
> has been allocated."*

**Hours to days.** For scale, *measured on CGDELL:* a **quick** scan took
**2 minutes 7 seconds** (08:21:52 to 08:23:59) against 100.2 GB used on one
236 GB drive. CGDELL has **never run a full scan** -- `FullScanAge` returns
4294967295, which is the "never" value -- so there is no local full-scan
duration to quote, and I will not guess one.

A senior whose laptop has been busy for four hours after a security tool
touched it does not think "the scan is thorough." They think they broke
something, and they call somebody.

### BUT MICROSOFT ALSO SAYS THE ONE CASE WHERE IT IS RIGHT

> *"Running a full scan once after you have enabled or installed Microsoft
> Defender Antivirus can be useful to scan systems to detect existing
> threats."*

**That is precisely Checkup's situation on a first run.** Checkup turns
Defender's protections on, and this is the moment Microsoft names as worth one
full scan. It is a strong argument for offering it **once**, on first run,
and never again.

**Note this also reinforces Q4.** Microsoft's recommended combination is quick
scan **plus real-time protection plus cloud protection** -- and cloud
protection is one of the two settings Bill just said to add. The three are a
set in Microsoft's own guidance.

### THE RECOMMENDATION

**Offer the full scan on the resume screen after the offline scan, on first run
only, with an honest warning about the time and an easy no.**

Concretely, at the `Show-PostScanGuidance` branch:

- Say the offline scan is finished and what it found.
- Then: *"One more scan is worth doing, once. It checks every file on every
  drive, and it is the only scan that does. It can take a few hours. You can
  keep using your PC while it runs, and you can stop it at any time."*
- **Y / N, and N is not a failure.** Default the wording so that N is an
  ordinary answer, not a warning.
- Run it with `-AsJob` so Checkup keeps going rather than freezing behind it.
- Log the choice either way.

**What this buys:** the website's *"scans your drives again"* becomes true, the
guide's second-drive claim becomes true, F4's route 3 gets its wording, and
nobody's laptop is hijacked for a day without being asked.

### DECIDED 2026-08-24 -- RUN THE FULL SCAN, WITH APPROVAL

**Bill: *"q2 run the full scan with approval."*** Settled. Checkup offers the
full scan, the user approves it, Checkup runs it. **Not silent, not automatic
-- asked for and granted, like every other change Checkup makes.**

### WHAT THIS UNBLOCKS IMMEDIATELY

**F4, route 3, and FT-167.** *sourced, Microsoft:* a full scan *"starts with a
quick scan, and then continues with a sequential file scan of all the fixed and
removable network drives that are mounted."* **So the second drive is covered
with no scope parameter, because there is none to set.** The screen text that
was gate-24-blocked on this measurement is unblocked.

**And two sentences already published become true**: the pricing page's *"scans
your drives again"*, and Bill's own Q2 wording. Both were held pending this.

### WHERE IT GOES IN THE FLOW -- AND IT IS NOT ONLY THE RESUME PATH

`Show-PreScanGate` line 4231 catches the resume after the offline-scan reboot,
and that is the obvious home. **But a user who declines the offline scan never
reaches it.** *measured:* the offline scan sits behind a Y/N at line 4365, and
N skips straight past.

**So the offer belongs in the scan section for everyone**, with the resume path
simply arriving at it already knowing the offline scan is done.

### RUN IT AS A BACKGROUND JOB. THIS IS NOT OPTIONAL.

*measured 2026-08-24 on CGDELL:* `Start-MpScan` supports **`-AsJob`**.

*sourced:* a full scan *"can last from several hours to several days."*
**Checkup cannot stand still for that.** `-AsJob` returns immediately, the scan
continues in the background, and Checkup carries on with the remaining
settings.

```powershell
# VERIFIED 2026-08-24 measured on CGDELL: Get-Command Start-MpScan returns
#   ConfigDefender v1.0; ScanType ValidateSet = FullScan, QuickScan, CustomScan;
#   -AsJob present. There is NO scope/drive parameter, and none is needed --
# VERIFIED 2026-08-24 sourced, Microsoft Defender full scan best practices:
#   "A full scan starts with a quick scan, and then continues with a sequential
#   file scan of all the fixed and removable network drives that are mounted."
#   This is the answer to FT-167 and to F4 route 3.
Start-MpScan -ScanType FullScan -AsJob
```

**Gate 24 satisfied by that comment block** -- basis is *measured* and
*sourced*, not inferred.

### THE SCREEN -- DRAFTED TO THE HOUSE RULES

Modelled on the existing offline-scan screen at line 4344 so it reads as part
of the same product. **The honesty about time is the whole point of it.**

```
  ONE MORE SCAN -- AND THIS ONE CHECKS EVERY DRIVE

  The scans so far checked the places malware usually hides.
  A full scan checks every file on every drive you have.

  It is the only scan that looks at your second drive, if you
  have one.

  WHAT WILL HAPPEN:
  * The scan starts now and runs in the background
  * Checkup carries on -- you do not have to wait for it
  * You can keep using your computer while it runs
  * It can take a few hours. That is normal, not a fault
  * Windows Security shows you how it is getting on

  Microsoft suggests doing this once, after turning Defender's
  protections on. That is exactly where you are now.

  Start the full scan? (Y/N)

  Y = Yes, start it in the background
  N = No thanks -- nothing else changes
  B = Back
```

**Why "once, after turning Defender's protections on" is in there:** it is
*sourced* from Microsoft, it is true of this moment in the run, and it answers
the unspoken question of why a tool is suddenly asking for hours of the
machine. **It also stops the screen reading as a scare.**

**Why N says "nothing else changes":** a senior declining a security offer
needs to know they have not broken anything. `N` is an ordinary answer here,
not a warning.

### WHAT MUST NOT BE CLAIMED

- **Not "offline scan".** That is the other one, it reboots, and conflating
  them is how FT-162 happened.
- **Nothing about how long it will take on their machine.** *measured:*
  CGDELL has **never run a full scan** -- `FullScanAge` returns 4294967295 --
  so there is no local figure and I will not invent one. *"A few hours"* is
  Microsoft's own range, hedged.
- **No claim it finds more than the quick scan on a clean PC.** It checks more
  files. Whether it finds more is not something we can promise.

### F6 ITEM

Not built. ascii43 is mid-family and has never been field run. **The screen
text, the cmdlet call and the gate-24 comment block above are ready to drop
in**, and the F4 wording that was blocked on this measurement can be written at
the same time.

---

### THE DECISION THAT WAS BILL'S -- ANSWERED ABOVE

**Two real paths, and they lead to different products:**

| | **OFFER IT (recommended)** | **RUN IT AUTOMATICALLY** |
|---|---|---|
| Consent | Consistent with "Checkup never applies anything you did not choose" | Breaks that promise for the biggest single action Checkup takes |
| Mechanism | Uses the hook that already exists | Needs a RunOnce or logon task -- new, and Malwarebytes-adjacent |
| A senior's experience | Told what it costs, chooses | PC is slow for hours with no explanation |
| Website copy | *"Checkup offers to run a full scan of all your drives"* | *"Checkup runs a full scan of all your drives"* |
| Microsoft's guidance | Matches it -- once, after enabling Defender | Contradicts it |

**Until Bill picks, the website sentence stays as it is.** The current pricing
page's *"scans your drives again"* is true under either path, once F4 exists --
it is only the word **automatically** that differs.

---

## 2. ITEM 8 -- THE SCROLL-DOWN INSTRUCTION

**Do not write a new sentence. One already exists, it is Bill's own wording
from items 1 and 7, and it is on the pages already.** *measured 2026-08-24:*

> *"Scroll down &#8212; or use the down arrow key or the Page Down key &#8212;
> and select **X**."*

**Four occurrences carry it in full.** Six others say only *"Scroll down
to..."* or *"Scroll down and click..."*, with **no keyboard alternative** --
which is the half that matters to a reader who cannot use a mouse wheel
comfortably.

**So item 8 is not a 19-page sweep. It is eight edits, measured:**

| Where | Count | What is wrong |
|---|---|---|
| *"Scroll down to..."* / *"Scroll down and click..."* | **6** | No down-arrow or Page Down alternative |
| Edge's three-dots menu -> **Settings** | **2** | No scroll guidance at all, and this is the exact step Bill hit on item 7 |

The two menu steps are `edge-startup.html:123` and `password-manager.html:123`,
both reading *"Click the three dots (...) in the top right, then click
Settings."* **Settings sits at the bottom of that menu.** That is where Bill
got stuck.

### THE STANDARD BLOCK, FOR THE TWO MENU STEPS

> Click the **three dots (...)** in the top right corner. **Settings** is near
> the bottom of the menu, so you will probably have to scroll down to see it
> &#8212; roll the mouse wheel down, or press the **Page Down** key, or hold
> the **down arrow** key. Then click **Settings**.

**Why this shape:** three routes to the same place, so nobody is stuck if one
does not work for them; it says *where* Settings is, so the reader knows they
have not gone wrong; and it reuses the vocabulary already on the other pages
rather than inventing a parallel version, which is D-18.

**Pages where no scrolling instruction is needed, and adding one would be
noise:** the eleven that start *"Press the Windows key, type X, and press
Enter"* land the reader directly on the page they want. Bill's *"everywhere"*
reads naturally as *everywhere it is needed*; measured, that is six pages, not
nineteen.

---

## 3. ITEM 13 -- THE DONATION AND WORD-OF-MOUTH PITCH

### WHAT THE RESEARCH SAYS, AND WHAT IT DOES NOT

The nonprofit fundraising literature is the wrong model -- it is written for
charities with a beneficiary, and this is a solo developer giving away
instructions. **The parts that do transfer:**

- **Matter-of-fact beats clever.** The consistent advice across the sources is
  to strive for clear, plain messaging over cute catchphrases, and to cut
  jargon and run-on sentences.
- **Specific and tangible beats abstract.** People give when they can see what
  the contribution did, and what the effort actually was.
- **Short.** Nothing on a donation ask should take longer to read than the act
  of giving takes to do.
- **Remove friction and remove guilt.** The strongest finding in the
  conversion research is that barriers, not weak wording, are what stop people.
- **The successful indie-developer asks are conversational and low-pressure**
  -- the "buy me a coffee" family works because it names a small, concrete
  amount and explicitly says you get nothing for it.

**The thing none of the sources address, and it matters most here: this pitch
sits on a page that is ALSO selling a product.** A donation ask next to a
purchase can cannibalise the purchase, or read as asking twice. **So the pitch
must be clearly about the free guide, not about Checkup.**

### THE DRAFT

> ### These instructions are free
>
> Every step on this page was carried out on a real Windows 11 PC and then
> rewritten until it matched what is actually on the screen. There is no
> company behind the guide -- it is one person in Maine, and it took months.
>
> **If this page saved you a phone call to your grandchildren, there are two
> ways to help, and the free one helps most.**
>
> **Tell someone.** Send them to **gatewayguard.co** -- that is `.co`, not
> `.com`. Word of mouth is the only way people find this.
>
> **Chip in, if you can spare it.** [ Donate ] Any amount. Nothing on this
> page changes if you do not, and nothing is held back.

### WHY EACH LINE IS THERE

- **"took months" and "carried out on a real PC"** -- the specific, tangible
  effort claim the research asks for. It is also true and checkable.
- **"one person in Maine"** -- the whole of the emotional case, in five words,
  with no pleading.
- **"saved you a phone call to your grandchildren"** -- names the benefit in
  the reader's own life. This is the senior audience's actual pain.
- **The free ask comes FIRST and is called the bigger help.** That is the line
  that makes the money ask land as honest rather than transactional.
- **`.co`, not `.com`** -- Bill flagged this himself, and it belongs in the
  pitch because this is the one sentence readers are asked to repeat out loud.
- **"Nothing on this page changes if you do not, and nothing is held back."**
  -- friction and guilt removed in one sentence, and it is a promise the
  product can keep.

**Banned-word check:** no *whether*, no *whereas*, no *switch* as a verb, no
jargon. **Placement:** at the foot of each page, after the steps, never above
them.

---

## 4. ITEM 19 -- HOW CHECKUP AUTOMATES THE MANUAL STEPS

### WHAT THE RESEARCH SAYS

The literature on writing technology instructions for older adults is
consistent and it is mostly about **tone**:

- **Use a respectful, adult tone that acknowledges life experience. Do not be
  condescending and do not explain like a child.** This is the single most
  repeated point across the sources, and it is the one most often broken.
- **Plain language, no jargon** -- remove it, do not gloss it.
- **One task at a time**, in small steps, rather than several features at once.
- **Say what the thing does for them**, not what it is.

**This matches what CLAUDE.md already requires**, which is a good sign: RULE
W-08's "no pedantic phrasing" and the ban on jargon are the same finding
arrived at independently.

### THE DRAFT

> ### You do not have to do any of this by hand
>
> The steps above work, and plenty of people prefer to do it themselves. They
> are written so that you can.
>
> **GatewayGuard Checkup does the same work for you.** It looks at this
> setting on your PC, tells you in plain words what it found, and asks your
> permission before it changes anything. If you say no, nothing happens.
>
> There are two settings Windows will not let any program change. For those,
> Checkup puts the exact steps on the screen and waits while you do them.
>
> What Checkup really saves you is the hunting -- no menus to find, no setting
> buried three screens down, and no wondering afterwards if you clicked the
> right thing.
>
> **In the future** we will be adding more settings to both Checkup and the
> Security Guide as we finish testing them.

### WHY EACH LINE IS THERE

- **Opens by validating the manual route, not dismissing it.** The
  respectful-adult-tone finding. A reader who has just worked through the steps
  is not told they wasted their time.
- **"tells you in plain words what it found"** -- what it does for them, not
  what it is.
- **"If you say no, nothing happens."** The permission promise, stated the
  short way.
- **"two settings Windows will not let any program change"** -- *measured:*
  ascii43 lines 5620 and 5626, `CanAuto=$false` on ID 3 and ID 9, and no
  others. A specific number is more convincing than "some settings", and this
  one is true.
- **"no wondering afterwards if you clicked the right thing"** -- the real
  anxiety, named. This is the sentence that will land.
- **"In the future"** -- Bill's own addition, in his words.

**One thing deliberately NOT said:** nothing here claims Checkup is faster,
safer or better than doing it by hand. It is not, for a competent reader, and
claiming it would be the kind of unverified superiority the banned-claims rule
already forbids.

---

## 5. ONE DEFECT FOUND ALONG THE WAY

**`CLAUDE.md` line 732 says the domain is `gatewayguard.com`. It is not.**

*measured 2026-08-24:*

- `CLAUDE.md` line 732: `- Domain: gatewayguard.com`
- `CLAUDE.md` line 16, same file: `gatewayguard.co`
- The briefing, four places: `gatewayguard.co`
- The website, **57 occurrences across the 19 pages**: `gatewayguard.co`

**The file contradicts itself, and the wrong half is in the "Domain / Business"
section** -- which is exactly where somebody would go to look it up. Bill wrote
*"gatewayguard.co (NOT .com)"* in his own answer on item 13, so the confusion
is live. Corrected in the same commit as this document.
