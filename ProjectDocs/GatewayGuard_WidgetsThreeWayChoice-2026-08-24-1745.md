<!-- Dated: 2026-08-24 17:45 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Widgets: the three-way choice

- **Document Name:** GatewayGuard_WidgetsThreeWayChoice
- **Last Modified:** 2026-08-24 17:45 ET
- **Bill's design, 2026-08-24**, in his words:
  > *"a) ask the senior if you are concerned about your info then we turnoff
  > widgets whatever else that keeps info from going to MS. b) If they just want
  > the weather and don't want to see adds and apps, etc and we can do that then
  > we should. c) If they want to keep all that widgets and the dashboard
  > supplies then we turn widgets on if not already on and whatever else is
  > necessary in lockscreen, if necessary."*
- **Status:** Design proposal. **Nothing built. Nothing applied to the page.**
- **Evidence:** `GatewayGuard_Research-WidgetsDataCollection-2026-08-24-1730.md`
  and `GatewayGuard_WidgetsMeasurements-M1toM6-2026-08-24-1330.md`

---

## WHY THIS IS BETTER THAN WHAT WE HAVE

**Today setting 14 asks one question -- off or not -- and answers it with a
machine-wide rule.** Bill's version asks what the person actually wants and
then does that. It fits the product's own promise, and it fits what the
research found: **there is no single right answer here, because Widgets is a
preference with an advertising problem, not a security hole.**

**It also solves a problem the binary version could not.** A senior who likes
the weather has, until now, been told to remove it. That is why the page needed
three arguments -- it was arguing someone out of something they wanted. **Give
them (b) and the argument becomes an offer.**

---

## THE THREE SETTINGS INVOLVED, AND WHAT CHECKUP CAN ACTUALLY TOUCH

*measured 2026-08-24 on CGDELL:*

| Setting | Where the user finds it | Can Checkup set it? |
|---|---|---|
| **Widgets on/off** (taskbar button) | Settings > Personalization > Taskbar > Widgets, **or** the board's own settings | **YES** -- the per-user value `TaskbarDa` |
| **Discover / the news feed** | The board > gear > **Dashboards** > Discover *(older builds: "Show or hide feeds" > Feed)* | **PROBABLY NOT.** Lives in the board's own interface. **Not found in the registry; not proven impossible either** |
| **Lock screen status** ("Weather and more") | Settings > Personalization > **Lock screen** > Lock screen status | **PROBABLY NOT.** No registry value found for the app choice |
| *(related)* "Get fun facts, tips, tricks" | Same Lock screen page | **YES** -- `RotatingLockScreenOverlayEnabled`. Only has an effect when the lock screen is set to Windows Spotlight |

**So two of the four are show-the-steps, not do-it-for-you** -- unless somebody
finds a supported way to set them, which is worth thirty minutes before this
gets built. **I am labelling those "probably not" rather than "cannot":** I
looked and did not find them, and *"not found in the searched locations"* is not
*"does not exist"*.

**This matters for the tag line and the Action wording on the page**, which have
to match `CanAuto` -- the mismatch that produced the Tamper Protection defect.

---

## THE QUESTION CHECKUP ASKS

One screen, three answers, and **no wrong answer**. Wording drafted to the house
rules -- no *whether*, no jargon, "turn on/off" not "switch", and it says who
authorised it.

```
  WINDOWS WIDGETS -- THE WEATHER AND NEWS PANEL

  Windows puts a weather button on the left of your taskbar.
  Clicking it opens a board with weather, sport and a news feed.

  The news feed is where Microsoft sells advertising, and some of
  those adverts are made to look like news headlines. That is the
  reason to think about this one.

  Microsoft has begun turning that feed off by default in newer
  versions of Windows. You can do it now.

  What would you like?

  [1] Turn the whole thing off.
      No weather button, no board, no feed.

  [2] Keep the weather, turn the news feed off.
      You keep the weather and anything else you have pinned.
      The adverts and headlines go.

  [3] Leave everything as it is.
      Checkup will not change any of it.

  Your choice is written to your log either way.
```

**Why option 2 is offered second and not last:** *sourced* -- with Discover
off, the board **"will display a smaller widget board with only widgets and no
news feed."** The weather survives. It is the answer most people will actually
want, and it is the one nobody has been offering.

---

## PATH (a) -- "I DO NOT WANT MY INFORMATION GOING TO MICROSOFT"

**What Checkup does:** turns the Widgets button off, for the person who chose
it.

**What Checkup shows steps for:**

1. **The lock screen.** Settings > Personalization > **Lock screen** > **Lock
   screen status** -> set it to **None**. *(measured: both test machines are
   currently on "Weather and more", which puts the same feed on the screen
   before you sign in.)*
2. **Windows Spotlight's promos**, if the lock screen is set to Windows
   Spotlight -- untick **"Get fun facts, tips, tricks, and more on your lock
   screen."**

**What Checkup should say honestly, and does not today:**

> Your Diagnostic data setting already limits what the Widgets board reports
> back. Checkup set that to **Required** earlier in this check-up.

*Sourced, Microsoft:* *"Windows diagnostic data is collected from the Widgets
board and is determined by the diagnostic data settings you choose."* **That is
setting 12, and Checkup already does it.** Saying so is more reassuring than
another warning, and it is true.

**And one thing (a) does NOT achieve, which we must not imply:** turning
Widgets off does not stop Windows collecting data generally. It removes an
advertising surface. **Do not let (a) read as a privacy guarantee.**

---

## PATH (b) -- "JUST THE WEATHER, NO ADVERTS"

**The one that needed research, and it works -- with one limit.**

**What Checkup shows steps for:**

1. Press **Windows key + W**, or click the **weather button** on the left of
   the taskbar.
2. Click the **gear** in the **top right** of the board.
3. Under **Dashboards**, turn **Discover** **Off**.
   *If your version does not show Dashboards, look for **Show or hide feeds**
   and turn **Feed** off instead.*
4. The board now shows your weather and anything you have pinned, and no news.

**The limit, and it has to be said plainly:** the **lock screen** offers only
**None** or **"Weather and more"**, and the *"and more"* is the news and
adverts. **There is no weather-only choice there.** So (b) means:

- **Desktop:** weather, no adverts. Exactly what was asked for.
- **Lock screen:** they choose -- weather with adverts, or nothing.

**A trap worth one line**, *inferred from two measured facts and not yet watched
happening:* if someone turns Widgets **off** from inside the board's own
settings, the weather button vanishes -- and that button was how they got
there. Hover-to-open no longer exists, so the way back is Windows key + W or
Settings > Personalization > Taskbar.

---

## PATH (c) -- "I WANT IT ALL"

**What Checkup does:** turns the Widgets button **on** if it is off, and
**changes nothing else**.

**What Checkup shows steps for**, only if they ask: putting the lock screen
back to **"Weather and more"**.

**The important part is what Checkup must NOT do.** No policy write, no feed
change, no lock screen change. **And the log should record that the user chose
to keep it**, so a later run does not re-ask as though nothing was decided.

---

## DECIDED 2026-08-24 -- KEEP THE MACHINE-WIDE POLICY

**Bill:** *"the person on the computer has admin permissions and therefore has
decided to implement this policy for all users on this pc."*

**Settled, and it closes both of my recommendations -- this morning's and this
evening's, which contradicted each other.** The reasoning is sound and it is
supported by the build: ***measured, setting 14 already carries
`RequiresAdmin=$true`.*** Checkup does not offer this setting at all to someone
without administrator rights, so the only person who can trigger it is the
person entitled to decide for the machine. **The policy is not a side effect --
it is the correct tool for an administrator making a machine-wide choice on
their own PC.**

*(It is also now the only option. `TaskbarDa` cannot be written --
`GatewayGuard_Research-WidgetsScriptability-2026-08-24-1850.md`.)*

### THREE THINGS FOLLOW, AND THEY ARE NOT RE-ARGUING THE DECISION

**1. TELL THEM, AND GET THEIR APPROVAL. Bill, 2026-08-24:** *"We do need to
tell him that is what he is doing and get his approval."*

**Not a line of explanation -- a second, separate approval.** Telling someone
what they are about to do and asking them to approve it are different things,
and only the second makes it their decision. **This is the product's own
promise applied to the one setting that reaches beyond the person using it.**

**So option 1 leads to a confirmation screen of its own:**

```
  BEFORE CHECKUP TURNS WIDGETS OFF

  This one is different from the others, so please read it.

  Turning Widgets off here turns it off for EVERYONE who signs
  in to this PC -- not only for you. Anyone else with an account
  on this computer will lose the weather button too.

  Windows lets you do that because you are an administrator.
  It will not let them undo it from their own Settings.

  If you change your mind later, run Checkup again and choose
  to keep Widgets. That is the way back -- Windows Settings
  cannot undo this one.

  Is that what you want?

  Y = Yes, turn Widgets off for everyone on this PC
  N = No, take me back to the choices
  B = Back
```

**Why the wording is shaped this way:**

- **"This one is different from the others, so please read it."** A senior who
  has approved eleven settings is not reading the twelfth. The screen has to
  earn the pause.
- **"EVERYONE who signs in to this PC -- not only for you."** The fact, in the
  first sentence, in their words rather than ours.
- **"It will not let them undo it from their own Settings."** The consequence
  that is easiest to overlook and hardest to reverse. Saying it here is what
  makes the approval informed.
- **The way back is given before it is needed**, which is the no-dead-ends
  rule.
- **N returns to the three-way question**, not out of the setting. Someone who
  balks at the machine-wide effect very likely wants option 2, and should land
  where they can pick it.

**This also settles what the log records:** not *"Widgets disabled"* but that
the administrator approved a machine-wide change, with the date. **If anyone
else on that PC ever asks why their weather went, the answer is in the log.**

**2. The Revert string is wrong and must change.** *measured, build line 6830:*

```
Revert = "Settings -> Personalization -> Taskbar -> Widgets -> On"
```

**That route cannot work after a policy write** -- the policy greys the toggle
out. **And the honest replacement is not a registry edit**, which is no
instruction to give a senior. It is Checkup itself:

```
Revert = "Run Checkup again and choose to keep Windows Widgets.
          Windows Settings cannot undo this one, because the change
          applies to every account on this PC."
```

**3. Option 3 has to actually remove the policy.** In the three-way question,
*"Leave everything as it is"* is not enough on a machine where a previous run
already wrote it. **On a re-run, choosing to keep Widgets must delete
`AllowNewsAndInterests`** -- otherwise the tool offers a choice it cannot
honour, which is the Tamper Protection shape again. *(A restart or an Explorer
restart is needed for it to take effect; the screen should say so.)*

**F6 ITEM, not built today.** The Revert string is a one-line replacement and
the policy-removal path is a small addition, but ascii43 is mid-family and has
never been field run. **Both are recorded here with the exact text ready.**

---

## THE BUILD CHANGES THIS NEEDS

### 1. ~~STOP WRITING A MACHINE-WIDE RULE~~ -- WITHDRAWN 2026-08-24

**Bill decided to keep the policy, and the per-user value turned out to be
unwritable anyway. The section below is kept only so the reasoning is on the
record; do not act on it.**

*measured, build lines 6470-6472:* setting 14 writes
`HKLM:\SOFTWARE\Policies\Microsoft\Dsh\AllowNewsAndInterests = 0`.

**In plain terms: it changes Widgets for everyone who signs into that PC, and
greys out the ordinary switch so none of them can put it back.** Every other
route we publish -- the page, the manual steps, the build's own Revert string
-- describes the ordinary per-user switch.

**Change it to write `TaskbarDa` for the current user.** Then:

- Only the person who chose it is affected.
- The revert steps we already publish actually work.
- The build's Revert string at line 6830 becomes true instead of false.

**This is a behaviour change on a shipped setting, so it is Bill's call** --
but nothing else on this page makes sense until it is made. **A three-way
choice written into a machine-wide policy is still a machine-wide policy.**

### 2. Setting 14 becomes a three-way question, not a checkbox

It currently has `Selected=$true` and a binary apply. It needs a prompt with
three answers, and the log needs to record which one.

### 3. Two of the four settings are show-the-steps

So setting 14 stops being cleanly `CanAuto=$true`. **Either it splits, or its
tag and its Action line say "Checkup does part of this and shows you the
rest"** -- which is honest and which no page currently says.

### 4. Before building: thirty minutes on scriptability

**Is there a supported way to set the Discover toggle and the Lock screen status
app?** If yes, (a) and (b) get much better. If no, the copy has to be honest
about it. **Do not build on my "probably not" -- I looked, I did not find them,
and that is not the same as proving it.**

---

## WHAT THE PAGE SAYS, ON THE ONE ARGUMENT THAT SURVIVED

Three of the page's four claims failed a check today. **This is the one that
holds**, and it should carry the page alone:

> **Why this one is worth thinking about.** The board's news feed is where
> Microsoft sells advertising inside Windows, and some of those adverts are
> built to look like news stories -- a startling headline, a photograph, and a
> page that wants you to call a phone number. It sits one click from your Start
> button. **Microsoft has begun turning this feed off by default in newer
> versions of Windows.**

**Cut from the page:**

- *"tracks which stories you read, how long you spend on them, and what you
  click on"* -- **not sourceable**, and wrong for a local account that is not
  signed into the board, which is both test machines and most of our readers.
- Anything implying that turning Widgets off stops data going to Microsoft.
  **The diagnostic-data half is setting 12, and Checkup already handles it.**

**Add, because it is true, useful, and nobody says it:** turning Location off
does not stop the weather knowing roughly where you are. *Sourced, Microsoft:*
it falls back to your IP address.

---

## WHAT I NEED FROM BILL BEFORE ANY OF THIS IS BUILT

1. **Per-user instead of machine-wide -- yes or no?** Everything else waits on
   it.
2. **Three-way question -- is the wording above right?** Particularly whether
   option 3 should say *"Leave everything as it is"* or name what stays.
3. **Does the lock screen belong inside setting 14, or become its own setting?**
   Inside keeps the count at 19. Its own setting makes 20, and 21 with Q4's
   two -- and every *"Setting N of 19"* line in the guide and the website
   changes.
