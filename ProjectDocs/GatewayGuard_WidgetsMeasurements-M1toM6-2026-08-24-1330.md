<!-- Dated: 2026-08-24 13:30 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Widgets measurements M-1 to M-6 -- all six answered

- **Document Name:** GatewayGuard_WidgetsMeasurements-M1toM6
- **Last Modified:** 2026-08-24 13:30 ET
- **Answers:** the six measurements Cloud handed back in section 2.9 of
  `GatewayGuard_CloudResearch-WidgetsAndAccessibility-2026-08-24-1015.md`
- **Source:** Bill's `ProjectDocs\Response-to-Cloud-html-Research.txt` and four
  screenshots he took on CGDELL and SANDY, read in place from his OneDrive and
  **deliberately not copied into this repository**
- **Status:** **All six answered. Two of Cloud's three security arguments do
  not survive.** One page correction applied today as a result.

---

## THE SHORT VERSION

**Cloud's research was careful and it handed back exactly the right six
questions. Two of its answers change the advice.**

- **M-5 kills the "accidental open" argument.** Hover-to-open no longer exists
  in Windows. Cloud had it as its second-strongest reason.
- **M-2 kills the memory argument, harder than Cloud expected.** Widgets uses
  **27.2 MB**. Windows Search uses **125.6 MB** and Teams uses **191 MB** of
  the same runtime on the same machine.
- **M-3 confirms Cloud's own fallback prediction exactly**, and its draft
  block 5 cannot ship as written.

**What is left standing is the ad and clickbait surface -- which is what Cloud
said was the strongest argument, reasoned to without being able to see a
screen.**

---

## M-1 -- DOES WINDOWS KEY + W STILL OPEN THE BOARD? **YES**

**Bill: yes, on both machines.** Already recorded from the earlier screenshot on
CGDELL with `TaskbarDa = 0`; **now confirmed on SANDY as well.**

**Consequence:** the correction already applied to `widgets.html` stands. The
old sentence *"Turning it off removes the panel"* was false on both machines,
not just one.

---

## M-2 -- DO THE PROCESSES KEEP RUNNING? **YES, AND THE NUMBERS END THE ARGUMENT**

*measured, Bill's Task Manager, filtered on `widgets`:*

**Windows Widgets -- 8 processes, 27.2 MB total, 0% CPU, 0 MB/s disk, 0 Mbps
network.**

| Process | Memory |
|---|---|
| WebView2 Manager | 7.3 MB |
| Widgets.exe | 6.4 MB |
| WebView2: Widgets *(Efficiency mode)* | 4.9 MB |
| WebView2 GPU Process | 3.7 MB |
| WebView2 Utility: Network Service | 2.0 MB |
| Crashpad | 1.2 MB |
| WebView2 Utility: Storage Service | 0.9 MB |
| Runtime Broker | 0.7 MB |
| *plus* WidgetsPlatformRuntime | 2.1 MB |

### AND THE SECOND SCREENSHOT IS THE ONE THAT SETTLES IT

*measured, same machine, filtered on `msedgewebview`:*

| What is using WebView2 | Memory |
|---|---|
| **Microsoft Teams** (7 processes) | **191.0 MB** |
| **Windows Search** (6 processes) | **125.6 MB** |
| **Windows Widgets** (8 processes) | **27.2 MB** |

**Widgets is the smallest WebView2 consumer on the machine by a factor of five
to seven.** Windows Search -- which nobody would suggest turning off -- uses
**4.6 times more**.

**So the memory argument must never be made.** Telling a senior to disable
Widgets to save RAM, while Search quietly uses five times as much, is
misleading even though every individual number is true. Cloud called it *"a
performance argument wearing a security coat"* and was right; the measurement
makes it worse than that.

**The claim was already live on the page** and was removed this morning before
these numbers arrived. **The removal is now measured, not merely prudent.**

### ONE HONEST CAVEAT ON M-2

Cloud's strict question was *"with Widgets **Off** and **after a restart**."*
Bill's screenshots were taken **after he turned Widgets on** for the M-5 test,
so they show the ON state. *inferred from his own note in M-5.*

**The OFF state is separately measured, by me on CGDELL:** with
`TaskbarDa = 0`, `Widgets.exe` and `WidgetService` were both running.

**So the processes run in both states.** The restart-ordering half of Cloud's
question remains unrun, and **it no longer matters** -- at 27.2 MB against
Search's 125.6 MB, the answer changes no advice either way.

---

## M-3 -- LOCK SCREEN WIDGETS: **THERE IS NO "WIDGETS" SECTION ON EITHER MACHINE**

*measured, both screenshots:*

| | CGDELL (Pro, 25H2) | SANDY (Home) |
|---|---|---|
| Section heading | **"Lock screen status"** | **"Lock screen status"** |
| Its description | *"Choose an app to show detailed status on the lock screen"* | same |
| The relevant option | **"Weather and more"** | **"Weather and more"** |
| Other options offered | None, Dev Home, Windows File Recovery, Intel Graphics Software | None, WildTangent Games, 3D Viewer, Xbox Console Companion |

**Cloud predicted this precisely.** Its `[VERIFY-CC]` read: *"older builds say
'Lock screen status' and offer 'Weather and more' instead."* **That is exactly
what both machines show.**

**Consequence: Cloud's draft block 5 cannot ship as written.** It says *"Look
for Widgets. It should be Off."* **There is no Widgets entry to look for**, and
sending a senior to hunt for one is the dead-end shape the rules forbid. The
block needs rewriting around **"Lock screen status"** and **"Weather and
more"**, with a note that the list of apps differs by machine.

**Also worth noting:** the option list is driven by installed apps, so it is
different on every PC. **The guide cannot promise what a reader will see** --
only the section name and the one entry that matters.

---

## M-4 -- IS THE DISCOVER CONTROL PRESENT? **YES, AND THE TWO MACHINES DIFFER**

**Bill: yes on both, via Windows key + W then the settings icon.**

- **CGDELL -- Discover ON**
- **SANDY -- Discover OFF**

**So the middle path Cloud recommended is available**, which was the open half
of M-4. The tab strip (Discover | Watch | Play) was already visible in the
earlier screenshot; the **off switch** is now confirmed to exist too.

**And the two machines disagree**, which is the useful part: a reader's
starting state is not predictable, so the copy has to say *"if it is on"*
rather than *"turn it off"*.

---

## M-5 -- HOVER-TO-OPEN: **IT NO LONGER EXISTS. THIS KILLS AN ARGUMENT.**

**Bill, measured on both machines:** the setting **"Open Widgets board on
hover"** under Settings > Personalization > Taskbar > Taskbar behaviors is
**missing on both**. Microsoft removed hover-to-open. Neither test PC has a
touchscreen, so the left-edge swipe does not apply either.

**The board now opens three ways, and all three are deliberate:** the taskbar
weather button, Windows key + W, or a touch swipe on hardware that has one.

### WHAT THIS COSTS US

**Cloud's 2.4 listed the accidental open as its second argument:** *"hover-to-
open has been the default for most of the feature's life... Removing the button
removes the accident."* **That is now historical.** On a current build there is
no accident to remove.

**Two of Cloud's three arguments are gone** -- the accidental open by M-5, the
background process by M-2. **The ad and clickbait surface is the only one
left**, and it is the one Cloud named as strongest.

**Recommendation: the page should rest on that single argument and say it
plainly.** One true reason beats three where two do not hold.

### AND IT CORRECTED SOMETHING I WROTE THIS MORNING

My 11:00 fix said turning Widgets off means *"the panel stops appearing while
you work."* **With hover gone, the panel never appeared by itself.** What
actually goes is the taskbar button and the weather, headlines and badges it
carries. **Corrected today:**

> *"Turning it off removes the weather button from the left of your taskbar, so
> the headlines and alerts it carries stop appearing there. The board itself
> can still be opened on purpose with the Windows key and W."*

**Bill also measured where the button sits: the LEFT of the taskbar**, on both
machines, appearing as soon as Widgets is turned on. The page had never said
which side.

**Bill's note is fair:** *"Surprised you didn't find this out already."* It is a
current-behaviour question about a Windows setting, it was answerable from the
machine in front of me, and I carried Cloud's sourced claim forward instead of
checking it. **RESEARCH BEFORE ASSERTING applies to inherited claims, not just
new ones.**

---

## M-6 -- DOES CHECKUP WRITE A POLICY KEY? **YES -- ANSWERED EARLIER TODAY**

*measured, build lines 6470-6472:* Checkup writes
`HKLM:\SOFTWARE\Policies\Microsoft\Dsh\AllowNewsAndInterests = 0` -- a
machine-wide policy, **not** the per-user taskbar value.

*sourced:* that policy **greys out** the Widgets toggle in Settings, so the
page's own "turn it back on" steps were a dead end. **Fixed on the page; the
build's Revert string at line 6830 is still wrong and belongs in F6.**

**Bill's note against M-6 reads `Question for Claude90-]` and is cut off.**
*Not an assumption I am willing to make:* if there was a question there, it did
not arrive. **Bill -- what was it?**

---

## WHAT CHANGES NOW

| | Action |
|---|---|
| **Page intro** | **DONE today** -- corrected for the hover finding and the taskbar side |
| **Memory / background-process claim** | **DONE** -- removed this morning, now measured as correct to remove |
| **Cloud's draft block 3** (accidental open) | **Must be cut or rewritten.** The argument is historical |
| **Cloud's draft block 5** (lock screen) | **Must be rewritten** around "Lock screen status" and "Weather and more" |
| **Cloud's draft block 4** (Discover) | **Stands**, and can now say the control exists -- with *"if it is on"* framing, since the machines differ |
| **The security case** | **Rests on the ad and clickbait surface alone.** Say it once, plainly |
| **Build, setting 14 Revert string** | Still wrong. F6 |
