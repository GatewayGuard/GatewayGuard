<!-- Dated: 2026-08-24 10:33 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Everything waiting on Bill -- one list, 2026-08-24

- **Document Name:** GatewayGuard_DecisionsForBill
- **Last Modified:** 2026-08-24 10:33 ET
- **Replaces, for reading purposes:** the five documents written overnight.
  They are **not additive** and they are **not in a sequence** -- each covers
  different topics. **Read this one instead.** The others stay as the evidence
  behind each answer and are cited where they apply.
- **Deliberately excluded:** the SANDY field checks. Nothing here needs a
  second machine. Those six checks are collected separately -- see the last
  section for where.

---

## HOW TO USE THIS

**Fourteen items. Two are urgent and are not really decisions. Nine need one
word from you. Three are done and need nothing.**

Answer by number. Anything you skip stays as it is -- nothing here changes
without you.

---

# URGENT -- TODAY, AND NEITHER IS A DECISION

## 1. YOUR MACHINES HAVE NOT BEEN PATCHED SINCE 1 AUGUST

*measured on CGDELL:*

```
PauseUpdatesStartTime   : 2026-08-01T11:33:37Z
PauseUpdatesExpiryTime  : 2026-09-06T11:33:14Z
```

You said SANDY is paused to the same date. **Launch is 1 September.** Both
machines go through launch week with five weeks of missed security updates, on
the PCs used to build and test a security product.

**Un-pause both.** Settings > Windows Update > **Resume updates**.

**I have not done it for you** because resuming pulls five weeks of updates
onto a machine that is mid-project, and that is your timing to choose, not
mine. Say the word and it is one command.

## 2. `C:` ON CGDELL HAS FOUR WORKING RECOVERY KEYS. IT SHOULD HAVE ONE.

*measured:* `Tpm` plus **four** `RecoveryPassword` protectors. Any one of the
four unlocks the drive.

**Not a script defect.** `Rotate-BitLockerKey` is deliberately two-phase -- it
adds a new key, prints it, and deletes the old one only after you type
**SAVED**. Three runs, three times SAVED was not typed.

**The question I need answered before touching anything:**

> **Which recovery key do you actually have written down?**

If I delete the three stale ones and your paper copy is one of them, your
written record becomes worthless. Once I know which one you hold, cleaning up
to that single key is safe and quick.

**Also:** reading the protectors printed all four keys into yesterday's session
transcript. They are **not** in any file in the repository -- *measured:* `git
grep` for the 48-digit pattern across `HEAD` returns nothing, and the tracked
`Recovery Keys.txt` is 13 bytes and contains none. **But treat them as exposed
and rotate when you clean up to one.**

*Evidence: `GatewayGuard_Research-Q7-BitLockerMicrosoftAccount-2026-08-24-0300.md` section 9.*

---

# DECISIONS -- ONE WORD EACH

## 3. Q2 -- SHOULD CHECKUP RUN THE FULL SCAN, OR OFFER IT?

You asked if Checkup can run the full scan automatically after the offline
scan. **It can be built, but not the way the word "automatically" implies.**

*measured:* nothing restarts Checkup after the offline-scan reboot --
`Save-Checkpoint` writes a state file and the script exits. Automatic would
need a new relaunch mechanism at logon, which is uncomfortably close in shape
to the self-elevation Malwarebytes already flagged on this product.

*sourced, Microsoft:* *"most users never need to manually run full scans"*, and
one *"can last from several hours to several days."* But also: *"Running a full
scan once after you have enabled or installed Microsoft Defender Antivirus can
be useful"* -- **which is exactly Checkup's first run.**

| | **OFFER IT** (my recommendation) | **RUN IT AUTOMATICALLY** |
|---|---|---|
| Consent | Keeps "Checkup never applies anything you did not choose" | Breaks it, for the biggest action Checkup takes |
| Build | Uses the hook that already exists at line 4231 | New logon-relaunch mechanism |
| A senior's experience | Told what it costs, chooses | PC slow for hours, no explanation |
| Microsoft's guidance | Matches -- once, after enabling Defender | Contradicts it |

**Answer 3: OFFER or AUTOMATIC.**

*Evidence: `GatewayGuard_Q2AndCopyDrafts-2026-08-24-0222.md` section 1.*

## 4. THE FULL-SCAN SENTENCE IS HELD UNTIL F4 EXISTS

Your Q2 wording was *"Checkup offers to run windows Defender offline scan **and
a full scan** with every Checkup run..."*

*measured:* `grep -o "Start-Mp[A-Za-z]*"` on ascii43 returns **`Start-MpWDOScan`
and nothing else.** There is no full scan in the tool. The offline half is
true; the full-scan half is not yet.

*sourced, and this is the useful half:* a full scan covers **all fixed and
removable drives**, so **`Start-MpScan -ScanType FullScan` is the answer to F4
and FT-167.** No scope parameter is needed because none exists.

**Nothing to decide unless you disagree** -- the sentence goes live when F4
does, together with the pricing page's *"scans your drives again."*

## 5. ITEM 15 -- THE FOURTH PHISHING ITEM

It is **"Automatically collect website or app content when additional analysis
is needed to help identify security threats."** The other three are warnings;
**this one is data collection.** Microsoft's own words for what it sends: *"the
content displayed, sounds played, and application memory."*

**Recommendation: explain it, do not recommend turning it on.** Microsoft's
default is Enabled for domain-joined and MDM devices and **Disabled for all
other devices** -- our audience. Their "turn it on" advice sits under
*"Recommended settings for **your organization**"* and the reason given is
improving Microsoft's threat intelligence. Also, a product that turns off the
Advertising ID and caps Diagnostic data cannot coherently recommend an extra
upload channel.

Draft page wording is in the evidence document.

**Answer 5: agree, or tell me to recommend turning it on.**

*Evidence: `GatewayGuard_Research-Items15and20-2026-08-24-0917.md`.*

## 6. SETTING 6 MAY DO NOTHING FOR OUR READERS

*measured:* Checkup's setting 6, named *"Edge Phishing Protection"*, writes to
`WTDS\Components`. **That is Windows Enhanced Phishing Protection, an operating
system feature -- not Edge's password monitor. The name is wrong**, and being
wrong is why nobody spotted the rest.

*sourced, three problems:* Microsoft scopes the feature to **work or school
passwords**; its edition table lists Pro, Enterprise and Education but **not
Home**; and **a Hello PIN stops it alerting at all** -- while Checkup's setting
9 encourages a PIN. Checkup has `SkipOnHome=$false`.

**I am not concluding it is useless.** Your screenshot shows the feature
present and switched on with four boxes ticked. If that machine was SANDY,
Home does expose it and the edition table means something narrower.

**Recommendation: change nothing yet, but rename it.** *"Edge Phishing
Protection"* is factually wrong whatever the outcome, and the rename costs
nothing.

**Answer 6: rename now, or leave the whole thing alone until SANDY.**

## 7. ITEM 20 -- IS SETTING 19'S DEFAULT STILL RIGHT?

*measured on CGDELL right now:*

| Adapter | Magic Packet | Pattern Match |
|---|---|---|
| Ethernet (Intel I219-LM) | **Enabled** | **Enabled** |
| Wi-Fi (Intel AX211) | Disabled | **Enabled** |

Setting 19 (Wake on LAN) is `Selected=$false`, so **a default Checkup run never
turns it off.** Your own machine is a live example of the hole the page
describes.

**Answer 7: leave the default off, or make it on.**

**Your security concern is confirmed and it is fixable.** *measured by
disabling the Ethernet adapter, reading it and restoring it, three cycles:* a
disabled adapter's Wake on LAN can be **both read and written**. What cannot
see it is the graphical interface -- Device Manager hides the Power Management
tab on a disabled device. **That makes it the strongest "what Checkup does for
you" example in the guide** -- not a convenience, but something the reader
genuinely cannot do by hand.

## 8. Q4 -- WHICH BUILD GETS THE TWO NEW SETTINGS?

You answered *"Add them"* for cloud protection and automatic sample submission.
That takes Checkup from **19 settings to 21** and touches the build, the guide
and the website.

*Worth knowing:* Microsoft's recommended combination is quick scan **plus
real-time protection plus cloud protection** -- so your instinct matches their
guidance.

**Answer 8: ascii43 (delays the field run) or ascii44 (field-run ascii43
first).** My recommendation is **ascii44** -- ascii43 has never been field run
and adding two settings before it is tested widens what a failed run has to
explain.

## 9. Q8 -- THE UPDATE-PAUSE BLIND SPOT

*measured:* nothing in the build reads `PauseUpdatesExpiryTime`. Every "pause"
match in the source is a user-interface screen. **So setting 1 can report
Windows Update healthy on a machine unpatched for five weeks** -- the same
shape as the FT-162 quarterly-scan defect, a `[GOOD]` printed over something
that is not happening.

Your own two machines are currently in exactly that state (item 1 above).

**Answer 9: give it an FT number and put it in F6, or defer with the rest of
item 23.** My recommendation is **F6** -- it is a build defect, not a page, and
the fix is a handful of lines.

## 10, 11, 12. THE THREE DRAFTS -- ITEMS 8, 13 AND 19

All three are written, with a line-by-line rationale so you can argue with the
wording rather than just accept it. **None is applied.**

**Item 8 -- the scroll instruction.** It is **eight edits, not nineteen**. The
sentence you want already exists in your own words on four pages; six others
scroll without offering the keyboard alternative, and the two Edge three-dots
steps have no scroll guidance at all -- which is the exact step you got stuck
on in item 7.

**Item 13 -- the donation pitch.** Puts the **free** ask first and calls it the
bigger help, because the pitch sits on a page that is also selling something.
Includes `.co, not .com`.

**Item 19 -- the automation explanation.** Opens by validating the manual route
rather than dismissing it, and cites the real number of settings Windows will
not let any program change.

**Answer 10, 11, 12: apply as drafted, or send changes.**

*Evidence: `GatewayGuard_Q2AndCopyDrafts-2026-08-24-0222.md` sections 2, 3, 4.*

---

# DONE -- NOTHING NEEDED FROM YOU

## 13. THE ITEM 2 COPY PASS IS BUILT, ALL 19 PAGES

Your option 1 plus your manual sentence, applied. Every "Action taken" line now
opens **"With your approval, Checkup will..."**. There had been four different
shapes, and the past tense was wrong on every page -- these are read *before*
purchase, so *"Checkup turned off your Advertising ID"* was false for most
visitors.

Items 3 (heading), 9 (dropped "(recommended)") and 17 went with it.

**Item 17 went further than the Action line.** The tag under each page title
had never been audited against the build. Three disagreed:

| Page | Build | Tag said | Now |
|---|---|---|---|
| `tamper-protection` | cannot | *"Checkup can do this for you"* | *"You set this up"* |
| `password-on-wake` | can | *"You set this up"* | *"Checkup can do this for you"* |
| `remote-desktop` | can | *"You set this up"* | *"Checkup can do this for you"* |

**And then I found I had missed a third element myself.** Each page states what
Checkup can do in **three** places -- tag, Found line, Action line. I audited
two and called it done. Auditing all 19 Found lines found exactly one wrong:
`periodic-scanning` claimed *"Windows does not allow this one to be changed by
a program"* while setting ID 5 is `CanAuto=$true`. **Fixed.**

## 14. ITEM 14, ITEM 16 AND THE DOMAIN

**Item 14 -- the build was already right.** I expected setting 5 to be
recommending something inapplicable; it is not. Lines 5904-5921 already
distinguish Malwarebytes Free from the Premium trial and report *"OFF is
correct here -- GOOD"* when Defender is primary. *sourced:* Malwarebytes Free
has no real-time protection, so it never triggers the periodic-scanning toggle
at all -- **the page now says so.**

**Item 16 -- answered.** Commit `200b6ec` fixed it, but not the way your
screenshots suggest. Both images are of **Remote Desktop Connection**, the
*outbound* client -- a different program with no setting to turn anything off.
The fix steers readers away from it rather than documenting its Options click.

**The domain.** `CLAUDE.md` line 732 said `gatewayguard.com`. Line 16 of the
same file, the briefing in four places, and all 57 occurrences on the website
say `.co`. **Corrected** -- and the wrong value was sitting in the section
anyone would consult to look it up.

---

# THE SANDY CHECKS -- EXCLUDED HERE ON PURPOSE

Six read-only checks have accumulated across Q7, 15, 20 and 14. **None needs a
decision and none can be done from this machine**, so they are kept out of this
list.

They live in the four evidence documents, and **the order they must be done in
matters** -- SANDY is the only unencrypted machine, and encrypting it ends the
ascii43 field run's starting condition permanently.

**Say the word and I will write them as one read-only script with a `.bat`
launcher, results to a file** -- so the whole trip is one double-click instead
of six lookups.
