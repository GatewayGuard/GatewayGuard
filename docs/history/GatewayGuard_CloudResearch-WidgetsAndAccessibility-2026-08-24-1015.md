<!-- Dated: 2026-08-24 10:15 ET -->
<!-- Editor: Claude Cloud -->
# Cloud research -- topics 2 and 7 of the seven-topic block

- **Document Name:** GatewayGuard_CloudResearch-WidgetsAndAccessibility
- **Last Modified:** 2026-08-24 10:15 ET
- **Last Editor:** Claude Cloud
- **Target path:** `ProjectDocs\GatewayGuard_CloudResearch-WidgetsAndAccessibility-2026-08-24-1015.md`
- **Answers:** `GatewayGuard_CloudRequest-ResearchBlock-2026-08-24-0222.md`, topics
  **2** (item 21 / setting 14, Windows Widgets) and **7** (item 24, Word
  Accessibility Assistant) -- the two marked CLOUD. **Topics 1, 3, 4, 5 and 6
  are Claude Code's and are not answered here.**
- **Status:** RESEARCH AND RECOMMENDATION. Amends no rule until Bill approves.
  Section 7.7 is a **draft** rule.
- **SUPERSEDES, and both must be retired unread:**
  - `GatewayGuard_CloudResearch-WidgetsAndWordAccessibility-2026-08-24.md` (superseded; now `GatewayGuard_CloudResearch-WidgetsAndAccessibility-2026-08-24-1015.md`)
  - `GatewayGuard_CloudResearch-WidgetsAndAccessibility-2026-08-24-0930.md` (superseded; now `GatewayGuard_CloudResearch-WidgetsAndAccessibility-2026-08-24-1015.md`)
- **Change History Log:**
  - 2026-08-24 10:15: **Timestamp given by Bill and applied.** Filename, the
    `Dated:` line and the target path all carry `-2026-08-24-1015` and no
    longer rest on an inference. See MERGE NOTE.
  - 2026-08-24 10:15: **Created by merging two earlier drafts.** Two Cloud
    sessions six hours apart answered the same request without either knowing
    the other existed. See MERGE NOTE.

---

## MERGE NOTE -- WHY THERE WERE TWO, AND WHERE THEY DISAGREED

**Two Cloud sessions produced two independent answers to this request on the
same day.** One instance cannot see another instance's output, and nothing in
the repository named the first file, so the second session had no way to know
it was duplicating work. **The failure is structural, not anyone's mistake:
a Cloud deliverable that has not been committed is invisible to the next Cloud
session.** The fix is the one already in use -- commit it and give it a
`CURRENT.md` row -- and it only works if the first file lands before the second
session starts.

**Where the two disagreed, and what this file does about it:**

| Point | File A (03:06) | File B (09:30) | Merged |
|---|---|---|---|
| **Windows key + W after the toggle** | Sourced: the board still opens | Listed as unmeasured | **File A wins, and I re-verified it against Microsoft's page myself rather than take the citation on trust.** See 2.3 |
| **Filename time** | Date only; refused to infer a time | Time inferred from the container clock | **File A wins.** See below |
| **Rule number** | Left as `W-nn` for Claude Code | Assigned `W-09` / `H-5` | **File A's discipline wins**, with what I can see recorded as an inference |
| **The Discover feed off switch** | Sourced from Microsoft's page | Inferred from 2026 press reports | **Both, and the sourcing is now stronger than either had.** See 2.6 |
| **Lock screen widgets** | Covered as a policy | Covered as a customer step | **File B wins -- it is a step the reader has to take.** See 2.3 and block 3 |
| **Palette contrast** | Cited the 4.5:1 threshold | Computed all seven tokens | **File B wins; the numbers are in 7.5** |
| **PDF export** | Covered -- tags, Print-to-PDF | Not covered | **File A wins.** See 7.7 W-nn.2 |

**On the filename -- SETTLED. Bill gave the time: 2026-08-24 10:15 ET.** The
filename, the `Dated:` line and the target path all carry `-2026-08-24-1015`,
and the naming standard is satisfied without an inference. **That answer stands
for the session and is not to be re-asked.**

**The conflict is kept on the record because it will recur.** The naming
standard requires `-YYYY-MM-DD-HHMM`; the clock rule forbids inferring a time;
a no-questions session forbids asking. All three cannot hold when Bill is away.
One earlier draft resolved it by inferring a time from the container's UTC
clock, the other by using a date-only filename. **Date-only was the better of
the two** -- it is already precedented in this tree
(`GatewayGuard_ScreenNumberTable-2026-08-17.md`,
`GatewayGuard_FieldChecklist-ascii43-2026-08-22.md`,
`GatewayGuard_ascii43BuildPlan-2026-08-21.md`, per `CURRENT.md`), and a
fabricated time looks exactly like a real one. **The rule worth writing down:
when the clock cannot be sourced, drop the field rather than fill it, and say
in the file that it is missing.** A held blank is recoverable; a plausible
wrong value is not.

**Snapshot this was written against:** `CURRENT.md` generated 2026-08-23 23:05
ET, commit `746879b`. The request document `-2026-08-24-0222` postdates that
stamp and was readable, so a later commit had synced in.

**Basis labels:** *measured* / *sourced* / *inferred* / *guess*. Forum and Q&A
threads are *inferred* with a report count. **Nothing below states what Checkup
does, what any `CanAuto` value is, or how any machine here is configured** --
those are marked `[VERIFY-CC]` and handed back.

---
---

# TOPIC 2 -- WINDOWS WIDGETS (item 21 / setting 14)

## 2.1 WHAT THE PANEL ACTUALLY IS

*Sourced.* Widgets is **three things people discuss as one**: a **taskbar entry
point** that usually shows the weather, a **board** of widget cards (weather,
calendar, sports, finance, traffic, photos, To Do, Phone Link, third-party
cards from the Store), and the **Discover dashboard** -- Microsoft's own name
for the stream of news and advertising inside the board, which Microsoft says
becomes more personalised over time.
<https://support.microsoft.com/en-us/windows/experience/personalization/stay-up-to-date-with-widgets-in-windows>

*Sourced.* Microsoft's policy documentation describes the **Allow widgets**
setting as governing **the entire widgets experience, including content on the
taskbar**, default on.
<https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-newsandinterests>

**That settles the most-asked question: the taskbar weather and the Widgets
panel are the same feature.** There is no supported arrangement that keeps the
taskbar weather and loses the board behind it.

**Almost every wrong claim about Widgets -- including one on our own page --
comes from treating the button, the board and the feed as one switch.** They
are governed by three different controls:

| Surface | Control | Note |
|---|---|---|
| Taskbar button and the board behind it | Settings › Personalization › Taskbar › **Widgets** | What setting 14 currently addresses |
| **Lock screen widgets** | Settings › Personalization › **Lock screen** › Widgets | **Separate toggle. The taskbar one does not touch it.** |
| The **Discover** feed inside the board | Board's settings button › Dashboards › **Discover** › Off | Present on the redesigned board -- see 2.6 |

## 2.2 WHAT PEOPLE USE IT FOR

*Sourced* for the list of cards Microsoft offers (same support page).
*Inferred, from roughly a dozen consumer how-to and forum sources:* the usage
split is lopsided and consistent. Nobody publishes telemetry, so this is a
read of what people write about, not a measurement.

| Use | Who for | Honest assessment for a home user over 60 |
|---|---|---|
| **Weather at a glance on the taskbar** | Very broad. The genuinely popular part | **The only part likely to be missed.** It costs no clicks -- the temperature is just there |
| Traffic | Commuters | Rarely |
| Watchlist / finance | People following a portfolio | Sometimes, and genuinely |
| Sports | Fans | Sometimes |
| Calendar, To Do, Photos, Phone Link | People already inside the Microsoft ecosystem | Rarely relevant on a local-account machine |
| **The Discover / MSN feed** | Nobody asks for it; it arrives by default | **Negative value for this reader.** Ad-funded, clickbait-shaped, and the reason the board feels like an intrusion |

**The tell is in what people publish.** Overwhelmingly the articles are titled
*how to remove the weather widget*, not *how to use widgets*. The weather is
the part people want; the feed underneath is the part they are trying to get
away from; the taskbar button is where the two collide.

**Rejected reading:** that the panel is simply unused and the setting is
therefore free. **It is not free for the reader who checks the weather there
every morning, and that reader is exactly who GatewayGuard sells to.** Treating
this as a no-cost change is how a senior ends up feeling the tool took
something without saying so.

## 2.3 WHAT IS GENUINELY LOST -- AND THE CLAIM ON OUR PAGE THAT IS FALSE

**Turning the taskbar toggle off removes:** the weather button, the board's
taskbar entry point, and the badges and animated headlines that appear over it.

**IT DOES NOT REMOVE THE BOARD.** *Sourced, and verified directly against
Microsoft's page for this merge rather than taken from the earlier file's
citation:* even with Widgets removed from the taskbar, the board is still
reachable with **Windows key + W** or by swiping in from the side of the
screen. Same support page as 2.1.

**So `widgets.html`'s opening sentence -- "Turning it off removes the panel and
stops that data sharing" -- is false on its first half, by Microsoft's own
documentation.** This is the Tamper Protection shape again: a page telling a
reader something is gone when the vendor says it is one keystroke away. **The
page cannot keep that wording under any answer to the questions at the end.**

**Lock screen widgets also stay.** They are a separate toggle (2.1), and
Microsoft's release notes for Release Preview builds 26100.8968 / 26200.8968
state the lock screen widgets experience was simplified so that **Weather is
now the only lock-screen widget shown by default for new users**. *Sourced.*
<https://learn.microsoft.com/en-us/windows-insider/release-notes/release-preview-24h2-25h2/build-26100-8968-26200-8968>

**A reader who follows setting 14 today turns off the taskbar button and still
sees widgets before they sign in, with nothing in the guide explaining why.**
That gap is block 3 in 2.8.

**What does NOT break:**

- **Nothing else in Windows depends on the board.** *Inferred* -- no Microsoft
  documentation names a dependency and no report reviewed describes one.
  Labelled inferred deliberately: *"not found in the searched documentation"*
  is not *"does not exist"*.
- **WebView2 stays installed and other apps keep using it.** Teams, the new
  Outlook and parts of Office host the same runtime. Turning Widgets off stops
  Widgets' use of it; it does not remove the runtime. *Inferred, well
  supported.*
- **Calendar, Weather and Phone Link all work standalone.**

**Unsettled, and it must not ship until measured:** whether `Widgets.exe` and
its `msedgewebview2.exe` children actually stop. *Inferred; roughly six
reports, four-to-two the other way* -- the older ones (2022, and some about
Windows 10 News and Interests) say the processes persist, the newer ones say
they stop after a restart. **No memory or background-process claim ships on
that evidence.** Measurement M-2.

## 2.4 THE SECURITY CASE, STATED HONESTLY

Three arguments of very unequal strength, and the current page leads with the
two weaker ones.

**Strongest -- the ad slots are a scam-delivery surface.** Malwarebytes
documented a campaign running at least two months that placed advertisements in
the **Microsoft Edge news feed** -- the same MSN / Microsoft Start content and
ad pipeline that fills the Discover dashboard -- using shocking or bizarre
story thumbnails to redirect victims to **tech-support scam browser-locker
pages carrying a phone number to call**. Microsoft confirmed it removed the
content and blocked the advertiser. *Sourced:*
<https://www.techradar.com/news/microsoft-edge-news-feed-infiltrated-by-tech-support-scammers>
*Inferred for the step that matters here:* that the Widgets Discover feed draws
on the same feed and ad inventory, so the same class of ad can appear there.
Microsoft has published nothing tying the two, and I found no report of a
browser-locker campaign served specifically through the Widgets board.

**Why that is the right argument for this audience:** the whole product exists
because a senior can be talked into calling a number on a screen. A tech-support
scam ad one hover from the Start button, dressed as a headline, is the exact
threat model. It is about **what the reader might click**, not what the process
might do.

**Second, and real -- the accidental open.** *Sourced:* hover-to-open has been
the default for most of the feature's life, and a left-edge swipe opens it on a
touchscreen. Removing the button removes the accident.

**Third, and it is a privacy argument -- the personalisation record.**
*Sourced:* Microsoft says the Discover dashboard becomes more personalised over
time. **That is all Microsoft says.** Our page's current line -- *"tracks which
stories you read, how long you spend on them, and what you click on"* -- is
more specific than anything I could source and should be softened to what can
be.

**What does not hold up as security -- the background process.** Real, and on
an 8 GB machine not nothing, but a **performance** argument wearing a security
coat. WebView2 is a Microsoft-signed component that stays installed regardless.
The page's line *"Anything still running is still working"* is the sentence in
the file that would not survive a technical reviewer, and selling performance
as security is the drift the copy rules exist to stop.

**Rejected framings:**

- *"Widgets is a vulnerability."* No CVE, no exploit, no privilege issue found.
  Saying so would fail RESEARCH BEFORE STATING.
- *"Turning it off protects you from malware."* It removes one place ads are
  displayed. The same ads are reachable in a browser.
- *"It phones home, therefore it is dangerous."* That is setting 12's argument.
  Reusing it here makes two pages say the same thing about different features
  -- how the W-07 collision happened before.

**So, to Bill's question -- the processes, the feed, or both?** *The feed and
the ad surface carry the argument. The accidental open supports it. The
processes are a footnote, and currently an unverified one.*

## 2.5 TURNING IT BACK ON, AND HOME VERSUS PRO

*Sourced.* **The Settings path is identical on Home and Pro:** Settings ›
Personalization › Taskbar › Taskbar items › **Widgets** › On. Right-clicking
empty taskbar space and choosing Taskbar settings lands in the same place. The
button returns immediately. *(Whether a restart is ever needed is M-5.)*

**Where the editions genuinely differ is the hard disable, and we should not go
near it:**

| Path | Home | Pro | Verdict |
|---|---|---|---|
| Settings toggle | Yes | Yes | **Use this.** Same on both, reversible in two clicks |
| `gpedit.msc` › Windows Components › Widgets › Allow widgets = Disabled | **No `gpedit.msc` on Home** | Yes | **Reject** -- edition-dependent |
| Registry `SOFTWARE\Policies\Microsoft\Dsh` › `AllowNewsAndInterests` = 0 | Undocumented for Home | Documented | **Reject** -- see below |
| `TaskbarDa` = 0 under `Explorer\Advanced` | Yes | Yes | **Reject** -- the toggle by another name, no advantage |
| `winget uninstall` the Web Experience Pack | Yes | Yes | **Reject** -- hard to undo, removes the toggle itself |

*Sourced, and load-bearing:* Microsoft's Policy CSP page lists
`AllowNewsAndInterests` for **Pro, Enterprise, Education and IoT Enterprise --
Home is not in the supported-editions list.** Writing that key on a Home
machine is an undocumented change to the customer's own PC. Under RESEARCH
BEFORE STATING we cannot claim it works on Home, and under the no-dead-ends
rule we cannot ship a step we cannot tell them how to undo.

*Inferred, three forum sources:* policy is also the only path that survives
updates re-enabling the feature. A point in its favour for an IT admin and
against it for a senior -- **a change they cannot reverse from Settings is a
change they cannot reverse.**

## 2.6 MICROSOFT IS FIXING THIS UNDERNEATH US

*Sourced.* Microsoft's own support page now documents the feed kill switch:
open the board, select the settings button on the navigation bar, and under
**Dashboards**, toggle **Discover** to **Off**. Same support page as 2.1.
**This is a Microsoft-documented control, not a rumour** -- the earlier draft
had it as an inference from press coverage, and it is better than that.

*Sourced.* The Windows Insider Blog, 2026-05-01, states Microsoft is separating
Widgets and the Discover feed into more distinct destinations with calmer
defaults, changing launch and badging defaults so the experience seeks
attention less, and reducing the default lock-screen widget set to Weather.
<https://blogs.windows.com/windows-insider/2026/05/01/windows-quality-update-progress-weve-made-since-march/>

*Inferred, roughly five independent reports of the July 2026 Release Preview
builds 26100.8942 / 26200.8942:* the redesigned board puts pinned widgets and
Discover on separate tabs of a navigation rail and hover-to-open is off by
default. No Microsoft release note states it in those words, and Microsoft
ships this by controlled rollout -- **two PCs on the same build can differ.**

**Why this matters more than it looks.** On a machine with the newer board, the
strongest argument for turning the whole thing off can be answered *without*
turning the whole thing off. **The page must not promise that control exists,
and must not be written so it becomes false when it arrives.** The taskbar
toggle is the step that works on every Windows 11 PC today; the feed switch is
the better outcome where it is present. Setting 14 belongs on a
review-before-release list for this reason.

## 2.7 RECOMMENDATION

**Keep recommending it. Keep it a *Your decision* item -- do not promote it to
a security fix and do not drop it.** Four changes:

1. **Fix the false claim.** "Removes the panel" is contradicted by Microsoft.
   Say the button goes and the board is still reachable by keyboard.
2. **Lead with the ad-and-clickbait surface and the accidental open**, not the
   tracking specifics and not the background process.
3. **Offer the middle path and lead with it for anyone who likes the weather** --
   Discover off, or hover-open off, keeping the button. With a stated fallback
   for machines that do not have those controls yet.
4. **Add the lock screen step.** Otherwise the reader is half-served and the
   page tells them everything else is unchanged.

**Rejected alternative recommendations:**

- **Drop the item.** The ad surface and the accidental open are real.
- **Promote it to security-critical or auto-select it.** It is a preference,
  the risk is indirect, and silently changing a visible piece of someone's
  taskbar is what makes people distrust a tool.
- **Policy or registry hard-disable, or uninstalling the package.** 2.5.
- **Make "feed off" the only advice.** It depends on a control that is not on
  every build, so the taskbar toggle stays as the fallback.
- **Put Microsoft's coming changes in the customer copy.** It dates
  immediately and becomes a maintenance liability on nineteen pages. The
  review list is the right home.

## 2.8 DRAFT REPLACEMENT COPY -- setting 14

House rules applied: no *whether*, no *whereas*, no *switch* as a verb, "turn
on / turn off", permission named, every step states its outcome, no dead ends,
no forever-family wording. **`[VERIFY-CC]` marks a claim about Checkup's
behaviour or machine state -- Claude Code's to measure, not Cloud's to
assert.** I could not run gate 25 from here; run it before applying.

**Block 1 -- intro**

```
Windows Widgets is the weather button on your taskbar and the panel of
news, weather and sports cards that slides out when you click it.
The news part of that panel is paid for by advertising, and Microsoft
uses what you open there to choose what to show you next.
```

**Block 2 -- What Checkup found and we recommend you do**

```
Found: Checkup checks if the Widgets button is turned on for your
taskbar.
[VERIFY-CC: exact wording of Checkup's found/status line for setting 14]

Action taken: With your approval, Checkup turns off the Widgets button.
The weather and news button leaves your taskbar, and the panel stops
opening when your mouse drifts over that corner. Nothing else on your PC
changes. You can turn it back on in two steps at any time -- they are
below. If you check the weather there every morning, keeping it is a
reasonable choice.
[VERIFY-CC: confirm Checkup writes only the per-user taskbar value and
no policy key]
```

**Block 3 -- Why you might want this off**

```
The news part of the panel is an advertising feed. The stories and the
ads sit side by side, and some of those ads have been used to send
people to fake "your computer has a problem" pages with a phone number
to call. Microsoft removed those advertisers when it was told about
them. The point is not that the panel is unsafe today -- it is that a
headline you did not ask for, one click from your Start button, is the
same shape as the scams aimed at people your age.

There is a second reason, and it is simpler: the panel opens by
accident. It can slide out when your mouse passes the bottom-left corner
of the screen, and on a touchscreen when your hand brushes the left
edge.

Microsoft also says the feed becomes more personalised the more you use
it. If you would rather it did not build that picture, turning the panel
off is the clean way to stop it.
```

**Block 4 -- If you like the weather but not the news**

```
You do not have to choose all or nothing.

  1. Hold the Windows key and press W. The panel opens.
  2. Click the settings button on the panel's navigation bar.
  3. Under Dashboards, turn Discover to Off.

The news stream is gone. Your weather and any other cards you keep stay,
and so does the weather on your taskbar.

If your panel does not have a Dashboards section, your version of
Windows has not received that setting yet. You have two choices: leave
the panel as it is, or turn the whole button off using the steps below.

To stop the panel opening by accident but keep the button:

  1. Press the Windows key, type Taskbar settings, and press Enter.
  2. Click Taskbar behaviors to open it.
  3. Clear the checkbox for Open Widgets board on hover.

The button stays where it is. The panel now opens only when you click it
on purpose.
```

**Block 5 -- One more place widgets appear** *(the gap in the current page)*

```
Turning off the taskbar button does not clear the widgets on your lock
screen -- the screen you see before you sign in. That is a separate
switch, and it is on by default on many PCs.

  1. Press the Windows key, type Lock screen settings, and press Enter.
  2. Look for Widgets. It should be Off. If it is On, turn it off.

If that page has no Widgets section, your version of Windows does not
have lock screen widgets. There is nothing to do.
[VERIFY-CC: confirm the on-screen label on CGDELL, SANDY and Sandy3 --
older builds say "Lock screen status" and offer "Weather and more"
instead]
```

**Block 6 -- How to check it yourself / How to turn it back on**

```
How to check it yourself

  1. Press the Windows key, type Taskbar settings, and press Enter.
  2. Look for Widgets in the list of taskbar items. If it says Off, the
     button is turned off. If it says On, the button is turned on.

How to turn it back on if you want it

  1. Press the Windows key, type Taskbar settings, and press Enter.
  2. Turn Widgets to On.
  3. The Widgets button reappears on your taskbar right away.
[VERIFY-CC: does the button return immediately, or after a restart?]
```

**Block 7 -- What to expect**

```
The weather and news button leaves the left end of your taskbar, along
with the red dots and the animated headlines that appeared over it.
Everything else on your PC works exactly the same -- your calendar, your
weather app and your browser are untouched. If you want the forecast,
your browser gives you a fuller one.

One thing to know, because we would rather tell you than have you find
it: turning the button off takes it off the taskbar, and the panel can
still be opened by holding the Windows key and pressing W. If what you
wanted was the button and the accidental opening gone, that is what this
does. If you want the news itself to stop, use the Discover steps above
-- that is the part that turns the feed off.
```

*Block 7 deliberately makes no claim about background processes or memory.
That claim is unverified -- M-2.*

## 2.9 MEASUREMENTS HANDED BACK -- topic 2

Each is minutes on CGDELL or SANDY. None can be settled from documentation.

| # | Measurement | Why it blocks |
|---|---|---|
| **M-1** | With Widgets toggled **Off**, does **Windows key + W** still open the board? Microsoft says yes. | **Gates the page.** If yes, block 7 stands as written. If no, cut its last paragraph. Either way the current "removes the panel" sentence goes. |
| **M-2** | With Widgets **Off** and after a restart, are `Widgets.exe` or `msedgewebview2.exe` running? Task Manager › Details, with the Command line column. | Until settled, **no memory or background-process claim ships**, on the page or in the guide. |
| **M-3** | Does **Settings › Personalization › Lock screen** show a **Widgets** section on CGDELL (Pro), SANDY (Home) and Sandy3 (Home)? Record the exact label on each. | Block 5 gives a path and a label. A wrong label sends a senior somewhere that is not there. |
| **M-4** | Is the board's **Dashboards › Discover** control present on any machine here? Record `winver` build. | Block 4's main path. If absent everywhere, its fallback paragraph is load-bearing rather than defensive and should say so more plainly. |
| **M-5** | Is **Open Widgets board on hover** still on by default here? And does the taskbar button return immediately when re-enabled? | The accidental-open argument in block 3, and block 6's last line. |
| **M-6** | Does Checkup write only the per-user taskbar value for setting 14, and no policy key? | A policy write on Home would be an undocumented change and a defect. |

---
---

# TOPIC 7 -- THE MICROSOFT WORD ACCESSIBILITY ASSISTANT (item 24)

## 7.1 WHAT IT IS AND WHERE IT LIVES

*Sourced.* It is the current form of Word's **Accessibility Checker**: a pane
listing accessibility problems in the open document, explaining why each
matters and offering fixes in place. Microsoft describes five categories --
**Color and Contrast, Media and Illustrations, Tables, Document Structure,
Document Access** -- and a status-bar **Accessibility: Investigate** button
that lights whenever the document has issues, so it can run continuously
rather than only at the end.
<https://support.microsoft.com/en-us/topic/improve-accessibility-in-your-documents-with-the-accessibility-assistant-f01562ca-0119-40ad-8dd6-f6223df50bef>

**Where:** **Review** tab › **Check Accessibility**.

**Two panes exist and the licence decides which.** *Sourced, WebAIM:* a
Microsoft 365 subscription shows the **Accessibility Assistant** pane;
standalone Office 2019-2024 shows a pane headed **Accessibility**. WebAIM keeps
two separate checklists for that reason.
<https://webaim.org/resources/evaloffice/>
**Which one Bill has is a measurement.** It changes the wording of the gate,
not its substance.

## 7.2 WHAT IT CHECKS -- AND WHAT IT DOES NOT

*Sourced, Microsoft's rules page (its own metadata dates the content
2025-11-17):*
<https://support.microsoft.com/en-us/office/rules-for-the-accessibility-checker-651e08f2-0fc3-4e10-aaca-74b4a67101c1>

Findings are classed **Error**, **Warning**, **Tip**, or **Intelligent
Services**.

**Errors** -- content that makes a document difficult or impossible to use:

| Rule | Verifies | Word? |
|---|---|---|
| All non-text content has alt text | Every object has alt text, with no file names or extensions | **Yes** |
| Tables specify column header information | A header row or header box is set | **Yes** |
| Document access is not restricted | IRM has not disabled *Access content programmatically* | **Yes** |
| All content control fields have titles | Every form field has a title | **Yes -- Word only** |
| Slide titles / meaningful section names | | PowerPoint only |
| No red-only formatting for negative numbers | | Excel only |

**Warnings** -- difficult in most cases: **table has a simple structure** (no
split, merged or nested cells) and **sufficient contrast between text and
background** -- both Word. Closed captions and logical reading order are
PowerPoint and OneNote; sheet names are Excel.

**Tip:** *documents use heading styles* -- content organised with headings or a
table of contents. **Word, and only a Tip** -- which matters, because heading
structure is the most important thing in our documents and Word rates it the
lowest severity it has.

**Intelligent Services:** AI-written alt text is listed so a person can check
it. Microsoft says to review each suggestion for accuracy.

**Microsoft states its own limits.** The same page says the checker finds
**most** issues, not all, and that it cannot detect **information conveyed by
colour alone**; its missing-captions finding also fires falsely on video with
in-band or open captions or no dialogue.

**What is not in the rule list at all, and this is the important half:**

- **No link-text rule.** "Click here" and bare URLs pass. WCAG 2.4.4 does not.
- **No document-language rule**, though language tells a screen reader which
  voice to use.
- **No heading-order rule.** Word checks that headings exist, not that they run
  without skipping levels.
- **No list-structure rule.** Hand-typed dashes pass.
- **No reading-order rule for Word** -- that one is PowerPoint-only.
- **No plain-language or reading-level rule** -- arguably our single most
  important quality for a guide written for seniors.

**A document with zero findings is not an accessible document.** *Sourced --
Microsoft says as much itself; and it is the position of every institutional
guide read for this topic.*

## 7.3 WHICH CHECKS CARRY ACROSS TO HTML

| Word / Assistant check | Applies to our HTML? | The HTML equivalent |
|---|---|---|
| Alt text on all non-text content | **Yes, directly** | `alt` on every `<img>`; `alt=""` only for decoration |
| Tables specify column headers | **Yes, directly** | `<th>` with `scope` |
| Table has a simple structure | **Yes** | No nested tables, no `rowspan`/`colspan` gymnastics |
| Sufficient text/background contrast | **Yes, and stricter** | WCAG 1.4.3 -- a number, not a warning |
| Uses heading styles | **Yes, and it matters more** | Real `<h1>`-`<h3>`, in order, no skipped levels, one `<h1>` |
| Document access not restricted (IRM) | **No -- Word only** | No analogue |
| Content control fields have titles | **Partly** | A real form control needs a `<label>`; our pages may have none |
| Slide titles, section names, sheet names | **No** | Other apps |
| Closed captions | **Not yet** | The day we ship a video |
| Reading order of objects | **No** (PowerPoint rule) | DOM order is the reading order in pages this simple |
| -- | **HTML-only, no Word equivalent** | `<html lang>`, `<title>`, descriptive link text, focus visibility, keyboard operability, skip link, 200% zoom reflow |

*Sourced, WCAG 2.1 SC 1.4.3:* the thresholds are **4.5:1** for text and **3:1**
for large-scale text -- 18pt / ~24px, or 14pt / ~18.7px bold.
<https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html>
*(The 2.2 Understanding page; the criterion text is unchanged from 2.1.)*

## 7.4 THE STANDARD BEHIND IT

**Yes, but not the one people assume, and Microsoft does not claim the checker
measures conformance.**

*Sourced.* Microsoft frames the checker as a **rules-based helper** -- it
verifies a file against a set of rules that identify possible issues, classed
Error / Warning / Tip. **Nowhere on that page does Microsoft write "WCAG" or
name a level.** *(Checked against the full page text, not a summary.)*

*Sourced.* Where Microsoft does name standards is in its **Accessibility
Conformance Reports**, which describe conformance against Section 508, the Web
Content Accessibility Guidelines and EN 301 549, and which state that Microsoft
assesses products against **WCAG levels A and AA**.
<https://www.microsoft.com/en-us/accessibility/conformance-reports>

**Read together, the defensible statement is:** the checker is aligned with
WCAG's concerns and Microsoft's products are *reported* against WCAG, Section
508 and EN 301 549 -- but **"passed the Accessibility Assistant" is not
"conforms to WCAG at any level."** Anyone who says otherwise is filling in a
claim Microsoft did not make. *Inferred, and stated as inferred deliberately.*

**Level to adopt: WCAG 2.1 Level AA.** *Sourced-secondary:* EN 301 549 takes
WCAG 2.1 AA as its web baseline and Section 508 sits at 2.0 AA, so 2.1 AA
covers both. **Rejected: 2.2 AA** -- nine added criteria, mostly about target
size, dragging, focus appearance and authentication, little of it relevant to
nineteen static pages and a PDF, and naming it raises a bar we then have to
keep. **Rejected: AAA** -- not achievable and not expected of anyone.

**On legal exposure: no claim made.** I am not a lawyer and this document does
not say what any law requires of a Maine LLC's website. The case is commercial:
**the product's entire audience is people whose eyesight, hearing and dexterity
are declining. An accessibility failure in a guide for seniors is a product
defect before it is anything else.**

## 7.5 MEASURED -- THE LOCKED PALETTE ALREADY PASSES AA

Contrast is one of the two Word rules that carries straight into HTML, and the
token palette in `WebsiteStandards` section 1 is a fixed set of hex values, so
it can be settled with arithmetic rather than a machine.

**Measured** -- WCAG relative-luminance formula, computed for this document,
every text token against both approved backgrounds:

| Token | Hex | on `--white` | on `--gray-light` | AA normal text (4.5:1) |
|---|---|---|---|---|
| `--black` | #000000 | 21.00 | 19.09 | PASS |
| `--gray-dark` | #333333 | 12.63 | 11.49 | PASS |
| `--gray-mid` | #666666 | 5.74 | 5.22 | PASS |
| `--navy` | #2E6BD6 | 5.01 | **4.56** | PASS |
| `--mocha` | #A0522D | 5.62 | 5.11 | PASS |
| `--charcoal` | #5E35B1 | 8.02 | 7.29 | PASS |
| `--gray-rule` | #DDDDDD | 1.36 | 1.23 | **FAIL -- never use for text** |

**Two things follow.** The senior-audience colour rules already produce an
AA-passing palette, which is worth knowing before anyone proposes changing a
token. And **`--navy` on `--gray-light` at 4.56 has almost no headroom** -- any
darkening of the light background or lightening of the navy breaks it, so the
gate pins these numbers rather than trusting them to stay true.

`--gray-rule` failing is not a defect: it is a divider colour. The rule says so.

## 7.6 WHAT A REAL GATE CAN AND CANNOT CHECK

Bill's constraint was the sharp one -- *a gate nobody can run is a wish.*

**Machine-checkable, deterministic, no network, no paid tool:**

| Check | How | Artefact |
|---|---|---|
| Every `<img>` has an `alt` attribute | Python HTML parse | `.html` |
| Exactly one `<h1>`; no skipped heading levels | Python HTML parse | `.html` |
| `<html lang="en">` present | Python HTML parse | `.html` |
| `<title>` present and unique across pages | Python HTML parse | `.html` |
| Every `<table>` has `<th>` | Python HTML parse | `.html` |
| No banned link text (`click here`, `here`, `read more`, `learn more`), no link whose text is a bare URL, no empty links | Python HTML parse | `.html` |
| Every colour pair the stylesheet resolves meets 4.5:1 (3:1 large) | Compute from `:root` and literal `color:` / `background:` declarations, seeded with 7.5 | `.html` |
| No body-text `font-size` below 16px | Python HTML/CSS parse | `.html` |
| PDF is tagged: `/MarkInfo /Marked true` and `/StructTreeRoot` present | `pikepdf` or equivalent | `.pdf` |
| PDF carries `/Lang` and a real document title in metadata | same | `.pdf` |

Python's `html.parser` is standard library, so there is no install and no
network -- the same reason gate 24 is a local script.

**Human-only, and it must be *named* as human-only or it will silently never
happen:** alt text that is accurate rather than merely present; headings that
describe what follows; **no information carried by colour alone** (Microsoft's
documented blind spot); reading order that makes sense read aloud; one
keyboard-only pass with focus always visible; one screen-reader spot check --
**Narrator is free and on every Windows 11 machine**, so there is no cost
barrier.

**Alternatives rejected for the automated half:**

- **axe-core CLI / pa11y / Lighthouse.** The strongest tools by far, and
  rejected: they need Node and a headless Chromium, they change behaviour
  underneath you, and every existing gate here is PowerShell or Python from
  `Tool2\`. **A gate that needs a browser toolchain on three machines is a gate
  that will be skipped.**
- **WAVE or an axe browser extension as *the* gate.** Manual, nineteen pages,
  no record and no ratchet. **Kept as an optional spot check.**
- **Acrobat Pro's accessibility check as a requirement.** Paid, and the tag
  check that matters is readable with a Python PDF library. Optional.
- **A full VPAT / Accessibility Conformance Report.** No procurement
  requirement, weeks of work, and it documents conformance rather than
  producing it.
- **Trusting gate H-3 (W3C validation) as sufficient.** Valid and accessible
  are different things: a page with no `alt` attributes and a skipped heading
  level validates cleanly.
- **Trusting Word's checker for the PDF.** *Sourced:* an accessible PDF
  requires the **Document structure tags for accessibility** option at export.
  <https://support.microsoft.com/en-us/office/create-accessible-pdfs-064625e0-56ea-4e16-ad71-3aa33bb4b7ed>
  *Sourced-secondary, consistent across five institutional guides:* **Print to
  PDF destroys the tag tree**, and "Minimize size" can silently clear the tags
  checkbox. **The export step is where the work disappears, so the gate must
  test the output file, not the source.**

## 7.7 THE DRAFT RULE

**Rule number left as `W-nn`.** `W-07` and `W-08` are occupied. *Inferred, from
what surfaced in this snapshot:* `W-09` is likely next and `H-5` is likely the
next gate letter -- but **Cloud cannot enumerate the WebsiteStandards rule list
and will not write a number as fact. Claude Code assigns it when filing.**

```
RULE W-nn -- ACCESSIBILITY OF PUBLIC DOCUMENTS

Standard: WCAG 2.1 Level AA is GatewayGuard's written benchmark.
"Accessible" means nothing until a level is named, so this rule names
one. WCAG 2.2 is a later decision and is not adopted here.

Scope -- every artefact published outside this repository:
  - the 19 HTML guide pages and every other page on gatewayguard.co
  - the Security Guide, both its source file and the shipped PDF
  - marketing one-pagers, the family presentation, the EULA and the
    refund and terms pages, in whatever format they ship
Out of scope: Checkup's own console screens, and internal ProjectDocs
files. A text-mode PowerShell program is a different accessibility
problem with different rules, and pretending one rule covers both
produces a gate that fits neither. Its own rule is future work.

W-nn.1  MICROSOFT 365 SOURCE FILES (.docx, .pptx, .xlsx)
  a. The Accessibility Assistant reports ZERO Errors and ZERO Warnings
     before the file is exported or published.
     Review tab > Check Accessibility.
  b. Every Tip is fixed or recorded with a one-line reason for leaving
     it. "Documents use heading styles" is a Tip in Word and is treated
     here as an Error: our documents are navigated by heading and must
     use real heading styles, never bold text standing in for one.
  c. Every AI-suggested alt text under Intelligent Services is read and
     corrected or replaced. A generated description is a draft.
  d. Keep accessibility checker running while I work stays enabled.
  e. Evidence: the pane's result is recorded in the file's change
     history -- "Accessibility Assistant: 0 errors, 0 warnings, N tips,
     <date>". "I ran it" is not a result.

W-nn.2  PDF EXPORT
  a. Export by File > Save As > PDF, with Options > Document structure
     tags for accessibility CHECKED and Create bookmarks using headings
     CHECKED.
  b. NEVER Print to PDF, and never a third-party PDF printer. Both
     flatten the tag tree, and the result looks correct.
  c. Re-check the tags option after any use of Minimize size -- it can
     clear it.
  d. The gate tests the OUTPUT file, not the source: /MarkInfo /Marked
     true, a /StructTreeRoot present, /Lang set, and a real document
     title in the metadata rather than a filename.

W-nn.3  HTML PAGES -- the machine half
  Every page passes, with zero exceptions:
   1. one <h1>, and no skipped heading levels
   2. an alt attribute on every <img>; alt="" only where the image is
      decorative and marked as such; alt text never repeats the file
      name and never opens "image of"
   3. <html lang="en">
   4. a <title>, unique across the site
   5. <th> in every <table>; no merged, split or nested cells; tables
      never used for layout
   6. no link whose visible text is "click here", "here", "read more",
      "learn more", or a bare URL; no empty links
   7. every colour pair the stylesheet resolves meets 4.5:1, or 3:1
      where the text is 24px or larger, or 18.7px and bold. Only the
      locked tokens carry text. --gray-rule is a divider colour and
      never carries text.
   8. no body text below 16px
   9. every form field has a visible label tied to it
  Item 7 is a FLOOR, not a full contrast test -- computed styles can
  differ from declared ones. It fails what it can resolve and stays
  silent on the rest, and that limit is printed in its own output so
  nobody mistakes a pass for proof.

W-nn.4  HTML PAGES -- the human half, and it is not optional
  Once per release, on the guide index and at least one setting page,
  recorded with the date and the machine:
   a. alt text read for accuracy, not presence
   b. no information carried by colour alone -- the tag colours
      especially. Microsoft's checker cannot see this; it says so
   c. a keyboard-only pass: Tab reaches everything, focus always visible
   d. a Narrator spot check of one page, top to bottom
   e. one page read at 200% browser zoom
  Unrecorded means not done.

W-nn.5  WHAT PASSING DOES NOT MEAN
  Microsoft does not claim the Accessibility Assistant measures WCAG
  conformance, and publishes its own list of what the checker cannot
  detect. Zero findings means zero findings. It does not mean the
  document is accessible, and no GatewayGuard copy may say or imply
  that it does.

W-nn.6  A FINDING THAT CANNOT BE FIXED is recorded in the file's header
  with the reason, not left silent.

W-nn.7  HOW IT IS ENFORCED
  A single launcher in Tool2\, run at delivery time beside the other
  gates, reporting per file and per check.
  It runs as a RATCHET, exactly like Run-DocCheck: the baseline is
  whatever the first run measures, and the numbers are only ever
  allowed to go down. Going above a baseline fails the run.
  The human half of W-nn.4 cannot be automated and is therefore a
  CHECKLIST ITEM with a recorded result, not a gate. A rule that
  pretends a human check is automatic is how H-4 went unrun.
```

**And the delivery-gate rows, in the existing format:**

```
HTML DELIVERY GATE RESULTS -- new rows

H-n a  Automated accessibility check: [PASSED -- N findings, baseline M]
H-n b  Human pass (W-nn.4 a-e):       [page named, date, machine] or
                                       [N/A -- no release this session]
H-n c  Word Accessibility Assistant:  [result pasted] or [N/A -- not a
                                       Word file]
H-n d  PDF tag check:                 [PASSED] or [N/A -- no PDF]
```

**WHAT THIS GATE DELIBERATELY DOES NOT DO**, so it is a decision and not an
omission: no full screen-reader testing beyond a spot check, no PDF/UA
certification, no captions rule (there is no video), no AAA criteria, no
third-party scanning service. Each is defensible work; none can be run from
this repository today.

**Why the rule is shaped this way rather than "run the Accessibility Assistant
on everything":** because Word's checker does not check link text, heading
order, document language, list structure or plain language, and cannot see
colour-only information at all -- **so a rule that stopped at "the pane is
clean" would certify pages that fail WCAG on six counts.** And because
**Word's Assistant only ever sees a document that is a Word document**: the
guide is authored in Markdown and the website is hand-written HTML, so for
those artefacts the Word tool is simply not in the path. One standard, three
checkers, chosen by what the artefact actually is.

## 7.8 MEASUREMENTS AND PREREQUISITES HANDED BACK -- topic 7

1. **Which Word is on CGDELL -- Microsoft 365 or standalone Office 2019-2024?**
   It decides which pane appears and therefore which steps the rule cites.
   WebAIM keeps two checklists for exactly this reason.
2. **Is a Python PDF library installed?** The 2026-08-14 session log records
   nine PDFs as unextractable for lack of one. W-nn.2's tag check needs
   `pikepdf` or equivalent. If none can be installed, the PDF half is a wish
   and the rule should say Acrobat Pro or nothing.
3. **Do the 19 pages have any real form controls?** If not, W-nn.3 item 9 is
   dead code and should be dropped rather than carried as a check that can
   never fire.
4. **What hex values are actually in the site's `:root` today?** 7.5 computes
   the tokens as `WebsiteStandards` declares them. If a page hardcodes a hex
   outside that set, the floor has to catch it.
5. **Does the shipped Security Guide PDF pass the tag check today?** Run it
   before adopting the rule. If it fails, that is a defect found by the rule on
   its first run -- which is what `Run-DocCheck.bat` did, and a good sign about
   the gate rather than a bad one.

---
---

# QUESTIONS FOR BILL

Merged from both drafts and deduplicated. Each says what was assumed and what
changes if the other answer is right. Questions whose answer would not change
the work are in the decisions list below instead.

1. **Setting 14 -- does the taskbar toggle stay the recommendation, or does the
   Discover-off middle path become the headline?**
   *Assumed:* the toggle stays the action, and the page leads with the middle
   path for readers who want to keep the weather.
   *If the middle path becomes primary:* Checkup's item changes shape, because
   the Discover control lives inside the board's own settings and is not
   obviously scriptable. That is a build question, not a copy question.

2. **Do we say out loud that the panel still opens with Windows key + W?**
   *Assumed:* yes -- Microsoft's own page says it, and hiding it is the Tamper
   Protection shape.
   *If you would rather not raise it:* the page must at minimum stop claiming
   the panel is removed. Silence is available; the current sentence is not.

3. **Lock screen widgets -- a step inside setting 14, or a setting of its own?**
   *Assumed:* a step inside setting 14 (block 5). It is the same feature, and a
   twentieth setting renumbers the guide, the website and every "Setting N of
   19" line.
   *If separate:* that renumbering is the real cost, not the writing.

4. **Do we mention in the customer copy that Microsoft is changing these
   defaults?**
   *Assumed:* no -- it dates immediately. Setting 14 goes on a
   review-before-release list instead.
   *If yes:* it needs a date and an "as of" hedge and becomes a maintenance
   liability on nineteen pages.

5. **Where does the accessibility rule live, and what number?**
   *Assumed:* `WebsiteStandards`, next free `W-` number assigned by Claude Code.
   *If it should be a standalone standards document* -- defensible, since it
   covers the PDF guide and marketing as well as the website -- the scope line,
   the cross-references and `CLAUDE.md`'s pointer all change with it.

6. **WCAG 2.1 AA, or 2.2 AA?**
   *Assumed:* 2.1 AA. It is what EN 301 549 references and it covers Section
   508's 2.0 AA.
   *If 2.2:* nine more criteria; two of them (target size, focus appearance)
   touch the site's CSS. Not free.

7. **Does the rule cover Checkup's console screens?**
   *Assumed:* no -- explicitly out of scope, with its own rule named as future
   work.
   *If yes:* it needs a fourth section on text-mode accessibility -- contrast
   in a console with user-set colours, screen-reader behaviour in a PowerShell
   host, keyboard-only by definition -- and I would want to research that
   properly rather than bolt it on.

8. **Is the human half of W-nn.4 acceptable as a recorded checklist item?**
   *Assumed:* yes, with the recording requirement, because the alternative is
   pretending a human check is a gate.
   *If you want it fully automated:* it cannot be, and the honest version of
   that answer is to cut checks b, c and d rather than fake them.

9. **`--navy` on `--gray-light` passes at 4.56 with almost no headroom. Pin it
   or improve it?**
   *Assumed:* pin the current values in the gate and leave the palette alone.
   It passes, and the colours are locked.
   *If you want headroom:* darkening `--navy` is a token change touching every
   page's CSS -- one co-ordinated edit, not a per-page one.

10. **Should gatewayguard.co carry an accessibility statement page?**
    *Assumed:* not yet, and not in this rule. It is a claim, and claims need to
    be true before they are published -- the Tamper Protection lesson.
    *If yes:* write it after the gate has run clean once, never before.

---

## DECIDED RATHER THAN ASKED, BECAUSE BOTH ANSWERS LED TO THE SAME WORK

- **Deliverable format** -- one file covering both topics. The request
  permitted either.
- **Whether to answer topics 1, 3, 4, 5 and 6** -- no. The request is explicit,
  and each turns on a measurement Cloud cannot take.
- **Which Word version Bill has** -- the pane's name differs; the rule does
  not. W-nn.1 accepts either.
- **Group Policy versus the Settings toggle for Widgets** -- policy is not a
  home-user tool and is unsupported on Home. There was no real choice.
- **Uninstalling the Web Experience Pack** -- not offered to this audience
  under any answer.
- **Whether to name Malwarebytes or the campaign in the customer copy** -- no.
  The page says what happened in plain English. The citation belongs here and
  in the guide's source note, not in front of a senior reader.
- **Whether the rule covers internal `ProjectDocs` files** -- no. They are not
  public and the gate would spend its life on documents no customer reads.
- **Whether to run the ten-minute rule on the conflicting WebView2 evidence** --
  no support ticket needed. One reboot and one glance at Task Manager settles
  it, so it went to M-2 instead.
