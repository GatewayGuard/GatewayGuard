<!-- Dated: 2026-08-24 09:45 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Item 14 -- periodic scanning, and Q8 -- Windows Update Advanced options

- **Document Name:** GatewayGuard_Research-Item14andQ8
- **Last Modified:** 2026-08-24 09:45 ET
- **Answers:** Bill's item 14 and Q8, the last two of the five Claude Code took
- **Status:** Both answered. **One page defect found and fixed. One real gap in
  the build, and one thing about CGDELL that needs Bill's attention today.**

---

# ITEM 14 -- PERIODIC SCANNING

**Bill's instinct was right, and so is the build. The website page was the
thing that was wrong.**

## WHEN THE SETTING EXISTS AT ALL

*sourced:* periodic scanning appears **only when a third-party antivirus is
installed AND running its own real-time protection.** That combination puts
Defender into passive mode, and a *"Microsoft Defender Antivirus options"* link
then appears carrying the toggle.

*measured 2026-08-24 on CGDELL:*

| | |
|---|---|
| `AMRunningMode` | **Normal** |
| Registered AV products | **Windows Defender only** |
| `PassiveMode` | **0** |

**Defender is primary here, so the toggle does not exist on this machine.**
Bill said the same is true of SANDY and SANDY3.

## THE FACT THAT DECIDES IT

*sourced:* **Malwarebytes Free has no real-time protection.** It is an
on-demand scanner and a browser extension -- no real-time shields, no scheduled
scans, no background monitoring. A new install carries a **14-day Premium
trial** which does have real-time protection; when the trial ends it reverts to
the free on-demand scanner.

**So for GatewayGuard's own recommended pairing -- Defender plus Malwarebytes
Free -- the periodic scanning toggle never appears at all.** The only ways a
reader sees it are during the 14-day Malwarebytes trial, or with some other
real-time antivirus that GatewayGuard does not name.

**This is exactly the situation on CGDELL**, whose Malwarebytes trial has
expired.

## THE BUILD ALREADY GETS THIS RIGHT -- I EXPECTED IT NOT TO

I went in expecting to find setting 5 recommending something inapplicable.
**It does not.** *measured, build lines 5904-5921:*

- `"MB Free -- Defender is still primary -- no periodic scan needed"`
- `"MB Premium Trial took over real-time -- periodic scanning IS recommended"`
- `"OFF is correct here -- GOOD"` when Defender is primary

**Checkup distinguishes Malwarebytes Free from the Premium trial and reports
the right thing in each case.** FT-60 and G-03 fixed this some builds ago.
Recording that I expected a defect and did not find one, because the opposite
belief was about to be written down.

## WHAT WAS ACTUALLY WRONG -- THE PAGE, AND IT WAS A FALSE CLAIM

`periodic-scanning.html`'s **Found** line said:

> *"...Windows does not allow this one to be changed by a program, so Checkup
> shows you the exact steps instead."*

***measured:* setting ID 5 is `CanAuto=$true`.** Windows allows it perfectly
well. **The page was telling readers Checkup cannot do something it can.**

**FIXED 2026-08-24.** Now reads:

> *"Checkup reviews Defender Periodic Scanning. This setting only appears when
> another antivirus program is running its own real-time protection -- if
> Defender is your primary antivirus, the option is hidden, because Defender is
> already scanning continuously. **Malwarebytes Free does not make it
> appear**, because the free version scans only when you ask it to."*

The **Action** line was also corrected. My own item 2 sweep had written *"...if
it was off and Malwarebytes was your primary antivirus"* -- which is wrong for
the same reason: **Malwarebytes Free is never the primary real-time
antivirus.** It now reads:

> *"With your approval, Checkup will turn on periodic scanning -- but only on a
> PC where another antivirus has taken over real-time protection. On a PC where
> Defender is in charge, there is nothing to turn on, and Checkup says so."*

## AND THIS EXPOSED A HOLE IN MY OWN ITEM 17 AUDIT

Yesterday I audited the **tag line** and the **Action taken** line against
`CanAuto` and reported three pages corrected. **There is a third element making
the same claim -- the Found line -- and I did not check it.**

Audited now, all 19. **Exactly one was wrong:**

| Page | Setting | Found line | Verdict |
|---|---|---|---|
| `periodic-scanning` | ID 5, `CanAuto=$true` | claimed Windows forbids it | **WRONG -- fixed** |
| `tamper-protection` | ID 3, `CanAuto=$false` | says Windows forbids it | correct |
| `windows-hello` | ID 9, `CanAuto=$false` | says Windows requires you to do it | correct |
| `wake-on-lan` | ID 19, `CanAuto=$true` | *"Some PCs cannot do it at all... where it can be changed, Checkup asks your permission"* | correct, and well put |

**The lesson is the one item 17 keeps teaching.** Each page states what Checkup
can do in three separate places. Checking two of them and declaring the page
audited is how the first Tamper Protection contradiction survived, and it is
what I then repeated.

---

# Q8 -- WINDOWS UPDATE ADVANCED OPTIONS

## THE THREE ITEMS, NAMED AND MEASURED

*measured 2026-08-24 on CGDELL, from `HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings`:*

| On-screen name | Registry value | CGDELL | Default |
|---|---|---|---|
| **Get me up to date** | `IsContinuousInnovationOptedIn` | **absent = Off** | Off |
| **Download updates over metered connections** | `AllowAutoWindowsUpdateDownloadOverMeteredNetwork` = **1** | **On** | Off |
| **Notify me when a restart is required to finish updating** | `RestartNotificationsAllowed2` = **1** | **On** | On |

*(**Receive updates for other Microsoft products** is a fourth toggle, but it
sits on the main Windows Update page rather than under Advanced options in
current builds. *measured:* `AllowMUUpdateService = 1`, and the Microsoft Update
service reports `IsDefaultAUService = True` -- so it is **on** here.)*

## WHAT EACH ONE DOES, AND WHETHER TO RECOMMEND IT

**Get me up to date** -- restarts the PC as soon as possible after an update,
overriding active hours, and delivers feature updates earlier.
**Recommendation: leave it off.** A PC that restarts itself outside active
hours is exactly the surprise this audience should not get, and early feature
updates mean being first to meet a new bug. It does not improve security --
quality updates arrive on the same schedule either way.

**Download updates over metered connections** -- lets Windows use a connection
you have marked as metered, typically a phone hotspot.
**Recommendation: leave it off, but say why it is a real trade-off.** Off
protects a data allowance. On means a laptop that only ever sees a hotspot
still gets patched. The honest line is: leave it off unless a hotspot is your
only internet, in which case turn it on and accept the data cost.
**Note CGDELL has it ON**, which is not the Windows default.

**Notify me when a restart is required** -- shows a notice instead of restarting
quietly.
**Recommendation: on, and this is the one worth actively recommending.** It is
already the default. It converts a silent restart into a warning, which for
someone with unsaved work is the difference between an interruption and a loss.

## THE PAUSED-UPDATES CASE -- AND THIS ONE IS URGENT

*measured on CGDELL:*

```
PauseUpdatesStartTime   : 2026-08-01T11:33:37Z
PauseUpdatesExpiryTime  : 2026-09-06T11:33:14Z
```

**Bill's machine has had no Windows updates since 1 August and will get none
until 6 September.** He reported SANDY is paused to the same date.

**Launch is 1 September.** Both machines will go through launch week with five
weeks of missed security updates, on the PCs used to build and test a security
product. **That is worth un-pausing today**, quite apart from what the guide
says.

### CHECKUP DOES NOT DETECT A PAUSE, AND THAT IS A REAL GAP

*measured: `grep -i "pause|PauseUpdates|NoAutoUpdate|AUOptions"` across the
build returns **only user-interface pause screens** -- `Pause-ForUser` and
friends. **Nothing reads `PauseUpdatesExpiryTime`.**

So a paused machine is invisible to setting 1. Checkup can report Windows
Update as healthy on a PC that has not been patched for five weeks -- which is
the same shape as the FT-162 quarterly-scan defect: a `[GOOD]` printed over a
thing that is not happening.

**Recommended fix, and it is small:** read `PauseUpdatesExpiryTime`; if it is a
future date, report *"Updates are paused until <date>"* and offer to resume.
Resuming is deleting those pause values, which is the same thing the **Resume
updates** button does.

## RECOMMENDATION FOR Q8 / ITEM 23

**Bill's own decision stands -- no new page, filed for future work.** Two
amendments to it:

1. **The pause detection should not wait.** It is not a page, it is a build
   defect, and it is the same class as one already in the defect record. Give
   it an FT number and put it in the F6 block.
2. **When the page is eventually written, only one of the three items is worth
   recommending** (notify on restart, already the default). The other two are
   "leave alone, here is why." **That is a thin page** -- which supports Bill's
   instinct that it is not urgent, and is worth recording as the reason rather
   than leaving the deferral unexplained.

---

# WHAT THIS ADDS TO THE SANDY LIST

Both items add one read-only check each to the trip already planned:

5. **Confirm SANDY has no periodic-scanning toggle** -- Windows Security >
   Virus & threat protection. Expected absent, since Defender is primary there.
6. **Read SANDY's pause state:**
   `Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name PauseUpdatesExpiryTime`
   -- Bill says it is paused to 2026-09-06 like CGDELL; worth confirming before
   the field run, because a machine mid-update behaves differently.
