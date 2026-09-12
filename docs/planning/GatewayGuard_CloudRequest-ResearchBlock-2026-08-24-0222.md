<!-- Dated: 2026-08-24 02:22 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Cloud request -- the seven-topic research block

- **Document Name:** GatewayGuard_CloudRequest-ResearchBlock
- **Last Modified:** 2026-08-24 02:55 ET
- **For:** Claude Cloud, GatewayGuard project
- **Raised by:** Bill, 2026-08-24 -- *"research with experts and forums and MS
  support and then give me your recommendation"*

---

## SCOPE -- CLOUD TAKES TWO OF THE SEVEN. REVISED 2026-08-24 02:55.

**This document originally handed Cloud all seven topics. That was wrong, and
Bill caught it by asking the right question: could Claude Code do the research
instead?**

**Yes, for five of them -- because five are not research questions. They are
measurements wearing research clothes.** Cloud would answer them from
documentation and forum posts; Claude Code can answer them from Bill's actual
machines and then check the documentation agrees. That is strictly better.

| Topic | Owner | Why |
|---|---|---|
| 1. Q7 -- BitLocker and the Microsoft account | **Claude Code** | Half sourced, half measurable. SANDY is the local-account machine -- the exact case in question |
| **2. Item 21 -- Windows Widgets** | **CLOUD** | *What people use it for* needs the open web, not a registry key |
| 3. Item 15 -- the fourth Reputation-based item | **Claude Code** | It is on the screen of a machine here. Read it |
| 4. Item 20 -- Wake on LAN, disabled adapter | **Claude Code** | Needs `Get-NetAdapter` and the power tabs on SANDY |
| 5. Item 14 -- periodic scanning | **Claude Code** | Depends on what Defender shows when it is primary. Measurable |
| 6. Q8 -- Windows Update Advanced options | **Claude Code** | Readable off the machine, and Bill deferred the deliverable |
| **7. Item 24 -- Word Accessibility Assistant** | **CLOUD** | Needs the open web and Word. No machine state involved |

**CLOUD: do topics 2 and 7 only.** They are marked **CLOUD** in the headings
below. The other five are listed so you have the context and do not duplicate
work -- do not answer them.

---

## WHY THESE TWO ARE A CLOUD JOB

**Neither needs the repository, the build, or a machine.** That is the exact
shape of work Cloud does without hitting any of its limits:

- It does **not** need `WebSite\html\` -- outside the connector scope.
- It does **not** need `Test_Results\` or `Tool2\` -- also outside.
- It does **not** need to glob or list a directory -- Cloud cannot.
- It does **not** need to measure a machine -- Cloud cannot.

**Meanwhile it is blocking six website items and two guide settings here.** So
it is the highest-value thing that can run in parallel with build work.

**What Cloud must NOT do in this job:** do not state what Checkup currently
does, what any setting's `CanAuto` value is, or what any machine here is
configured to. Those are measurements and they belong to Claude Code. **If an
answer depends on one, say so and hand the measurement back** -- name the
question you need answered rather than assuming it.

---

## HOW TO ANSWER -- THE HOUSE RULES THAT APPLY

Every claim carries its basis, using these four words: **measured**,
**sourced**, **inferred**, **guess**. A claim with no label is being asserted
as fact.

- **sourced** needs the link. Microsoft Learn, a Microsoft support page, or a
  named expert. A forum thread is evidence of what people experience, not of
  how the system works -- label those **inferred** and say how many reports.
- **Name the alternatives you rejected.** If one explanation fits, say what
  else could fit and why it does not. This project has been bitten repeatedly
  by the first plausible answer.
- **Give a recommendation, not a survey.** Bill asked for a recommendation.
  Three options with no pick is not an answer.
- **Say plainly when the research does not settle it**, and what would.

Deliverable: **one Markdown file per topic, or one file with seven sections**,
into `ProjectDocs\`. Bill will tell Claude Code it is there.

---

## DO NOT STOP TO ASK. HOLD EVERY QUESTION TO THE END.

**Bill will be away from the keyboard. A question asked in the middle costs the
whole session, because nothing answers it until he comes back.**

**So: never stop and wait.** When you hit something you would normally ask
about:

1. **Choose the most reasonable reading**, and say in one line which reading
   you chose and why.
2. **Carry on with the research** under that assumption.
3. **Put the question in a numbered list at the very end**, under the heading
   **QUESTIONS FOR BILL**, each one saying what you assumed and what would
   change if the other answer is right.

**A question that changes nothing about the research is not worth asking.**
Apply the same test Claude Code is held to: imagine both answers. If the work
would be the same either way, it was never a question -- decide it and note the
decision.

**Finish both topics before writing the question list.** Research
everything, analyse it, reach a recommendation on each, and only then collect
what you could not settle. A partial answer with questions attached is worth
less than seven complete answers with seven caveats.

---

## THE SEVEN TOPICS, IN THE ORDER THEY UNBLOCK THINGS

### 1. Q7 -- DOES BITLOCKER NEED A MICROSOFT ACCOUNT? *(highest value -- it grew)*  **<- CLAUDE CODE. Context only, do not answer.**

Bill's words: *"Don't we need MS Account for bitlocker to be able to store
bitlocker key or manually add bitlocker key. research with experts and forums
and ms support and then give me your recommendation."*

**This started as a Windows Hello question and became a BitLocker key-escrow
question, so it now governs two settings instead of one.** It is also the
highest-stakes item in the whole guide: **a wrong answer here can cost a reader
their files.**

Answer these, separately for **Windows 11 Home (Device Encryption)** and
**Windows 11 Pro (BitLocker)**:

- Can a user on a **local account** turn on encryption at all?
- Where can the recovery key be saved on a local account -- printed, a text
  file, a USB drive, an Azure AD account, a Microsoft account added later?
- **Does Windows 11 Home auto-encrypt on first sign-in with a Microsoft
  account, and escrow the key silently?** If so, from which build, and what
  happens on a local account instead?
- **Can a recovery key be added to a Microsoft account after the fact**, for a
  drive already encrypted on a local account?
- What is the actual failure mode if the key is lost? Be specific about what
  is recoverable and what is not.

**Why it matters here:** the guide has a BitLocker recovery-key VERIFY marker
that is unmeasured, and item 4 asks for a written recovery-key backup plan for
Home and for Pro. Both wait on this.

### 2. Item 21 -- WINDOWS WIDGETS  **<- CLOUD, DO THIS ONE**

Bill's words, repeated in full: *"We need to research with experts, forums and
MS support, what people use it for and what capabilities are going to be lost
and explain that. Discuss with me. Rewrite Action item with whatever phrase we
settle on."*

- **What do people actually use the Widgets panel for?** Weather, news, stocks,
  calendar, sports -- with some sense of which matter to a home user over 60.
- **What is genuinely lost when it is turned off?** Does anything else in
  Windows depend on it? Does the taskbar weather disappear? Does anything
  break, or is it purely the panel?
- **What is the security case for turning it off**, stated honestly? Is it
  really about the background Edge processes, the news feed's ad and tracker
  content, or both?
- **Can it be turned back on easily**, and is that path the same on Home and
  Pro?
- **Recommendation:** should GatewayGuard keep recommending it be turned off?

### 3. Item 15 -- THE FOURTH REPUTATION-BASED PROTECTION ITEM  **<- CLAUDE CODE. Context only, do not answer.**

Windows Security -> App & browser control -> Reputation-based protection has
**four** items. The guide covers three.

- **Name all four exactly as they appear on screen** in current Windows 11.
- For the fourth one: what does it do, what does it cost the user when on, and
  is it on by default?
- Is there any reason a home user would want it off?
- **Recommendation:** cover it in the guide, add it to Checkup, or explain it
  and leave it alone?

*(This is the same shape as Q4/item 5, which Bill has already answered "add
them" for cloud protection and automatic sample submission. A consistent answer
here would be worth noting.)*

### 4. Item 20 -- WAKE ON LAN, AND THE DISABLED ADAPTER  **<- CLAUDE CODE. Context only, do not answer.**

Bill's field finding: SANDY has a Realtek controller, a **Realtek adapter that
is disabled and therefore could not be checked**, and a wifi USB adapter. Both
machines also show a number of WAN miniports with no power management section.

- **If a network adapter is disabled, can its Wake on LAN setting still be
  set, and does it take effect if the adapter is later enabled?** This is the
  actual question -- Bill's concern is a hole that opens later.
- **Do WAN miniports need any Wake on LAN consideration at all**, or are they
  virtual devices where the question does not apply? Say which.
- Where Wake on LAN lives on a modern Windows 11 machine: the adapter's
  **Power Management** tab, its **Advanced** tab, or the BIOS/UEFI -- and what
  to tell a reader whose adapter shows no Power Management tab, which is
  CGDELL's case.
- **Recommendation:** what should the guide tell someone with more than one
  adapter, including disabled ones?

### 5. Item 14 -- PERIODIC SCANNING  **<- CLAUDE CODE. Context only, do not answer.**

Bill: *"defender is running on sandy and cgdell and sandy3. Confirm these
instructions with experts and forums and Microsoft support."*

- **When does Defender's periodic scanning option actually appear?** It is
  understood to show only when a third-party antivirus is the primary. Confirm
  or correct that, with a source.
- If Defender **is** the primary antivirus, is the option absent, greyed, or
  simply irrelevant? What does the user see?
- What does periodic scanning actually do, and how often?
- **Recommendation:** is the guide's current framing right, and what should a
  reader with Defender-only be told?

### 6. Q8 / Item 23 -- WINDOWS UPDATE ADVANCED OPTIONS  **<- CLAUDE CODE. Context only, do not answer.**

**Bill has deferred the deliverable** -- no page, no guide section, filed for
future work. **The research still stands**, so that the decision is made on
facts when it is taken up.

- **Name the three items** under Windows Update -> Advanced options as they
  appear in current Windows 11, exactly.
- What does each do, and what is the default?
- Which are worth recommending to a non-technical home user, and why?
- **The paused-updates case:** Bill found both machines paused until
  2026-09-06, and Windows Update showed **Resume updates**. What should a
  reader be told if they arrive at a paused machine? Is pausing ever the right
  choice for this audience?

### 7. Item 24 -- THE WORD ACCESSIBILITY ASSISTANT  **<- CLOUD, DO THIS ONE**

Bill: *"are you aware of the MS word accessibility assistant to help readers.
If not research it and make sure all of our public documents adhere to it, if
we can. Make this a rule."*

- **What is it**, where does it live in current Word, and what does it check?
- **What does it actually check for** -- alt text, heading structure, contrast,
  table headers, reading order, link text? List them.
- Which of those apply to **HTML web pages** as well as `.docx`, and which are
  Word-only?
- **Is there a public standard behind it** (WCAG 2.1 AA?), and which level does
  Word's checker target?
- **Recommendation: draft the rule Bill asked for**, as a numbered rule in the
  house style, covering what a GatewayGuard public document must satisfy before
  it ships, and how it is checked. Keep it to what can actually be verified --
  a gate nobody can run is a wish.

---

## WHAT TO DO IF A TOPIC TURNS OUT TO BE UNANSWERABLE ONLINE

**Say so early rather than filling the space.** The ten-minute rule applies:
when roughly ten minutes of searching has not produced a cause -- not a theory,
a cause -- stop and write up what is needed instead. For most of these that
would be a specific measurement on a specific machine, and Claude Code can run
it in seconds.

**Naming the measurement you need is a complete and useful answer.** A wrong
recommendation is not.
