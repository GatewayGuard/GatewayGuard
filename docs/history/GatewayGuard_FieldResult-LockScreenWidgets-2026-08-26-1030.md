# Field result: lock screen widgets are automatable, and the widget opens a browser

# Dated: 2026-08-26 10:30 ET

**Machine:** CGDELL (Windows 11 Pro, 25H2, build 26200.9168 -- *measured
2026-08-26 09:29 ET*). SANDY measured at the same build by Bill the same
morning.

**Supersedes row 3 of the table in
`GatewayGuard_Research-WidgetsScriptability-2026-08-24-1850.md`, line 149.**
That row read **"Lock screen widgets off | MAYBE -- writable, effect
unproven."** It is now **YES, proven in the field.**

---

## 1. THE FIRST TEST WAS BROKEN, AND THE FAULT WAS IN THE DESIGN

The test written on 2026-08-24 (research doc lines 120-128) was: **set
`LockScreenWidgetsEnabled = 0`, then press Win+L and look for the
weather-and-more content to disappear.**

***measured on CGDELL 2026-08-26 09:56 ET, before any toggling:***

```
HKCU\Software\Microsoft\Windows\CurrentVersion\Lock Screen
  LockScreenWidgetsEnabled                = 0
  LockScreenWidgetsSystemCurationEnabled  = 0
  AutoSelectWidgetsOnLockScreen           = 1
```

**The value was already 0 and the Settings toggle was already Off** -- confirmed
independently by Bill's screenshot of Personalization -> Lock screen, which
shows **Widgets: Off** and **Suggest widgets for your lock screen: Off** on both
machines.

**So there was nothing on the lock screen to disappear.** Bill ran it, saw the
PIN prompt, and that was the correct behaviour for the state the machine was
already in. **A test whose two branches produce the same observation is not a
test.** This is the "check a proposed test could actually fail" rule, and the
design failed it -- not the execution.

**It also produced a false lead.** What Bill described first -- a weather button
on the **taskbar** opening to weather, sports and "Suggested for you" -- is the
Widgets **board**, a different feature on a different key.
***measured on CGDELL:*** `HKLM\SOFTWARE\Policies\Microsoft\Dsh` is **absent**
and `TaskbarDa = 1`, both consistent with the board being available. Lock screen
and taskbar are two separate switches that have both been called "widgets."

---

## 2. THE CORRECTED TEST, AND WHAT IT RETURNED

**Design:** turn the Widgets toggle **On**, Win+L, look; turn it **Off**, Win+L,
look. Both branches can differ, so the test can fail.

**Run by Bill on CGDELL, 2026-08-26. His observation, in his words:**

> "a little weather screen with just citi and temp appeared with a see full
> forecast selection at the bottom of it whole screen is a button. if you select
> it you are asked for your pin and and msn.com screen appears in a browsers
> with the full weather information screeen you turn of widgets and the little
> weather screen went away and no new browser screen."

***measured on CGDELL 2026-08-26 10:30:45 ET, after Bill restored the toggle:***
`LockScreenWidgetsEnabled = 0`, `LockScreenWidgetsSystemCurationEnabled = 0`,
`AutoSelectWidgetsOnLockScreen = 1`. **The machine is exactly as it was.**

### Conclusion 1 -- the control is effective

Content appeared with the toggle On and was gone with it Off. **The sourced
caution that the lock-screen CSP was Insider-only and ignored on stable builds
does not apply to this build.** `LockScreenWidgetsEnabled` is a per-user DWORD,
writable without elevation, **and it changes what the lock screen renders.**

**FT-162 does not apply here.** That defect was a command accepted and silently
ignored while the log printed `[GOOD]`. This value was proven by looking at the
result, not by the absence of an error.

### Conclusion 2 -- the widget is an active surface, not a display

Three separate things, all from Bill's run:

1. **It shows the city and the temperature on a locked machine.** Live content,
   fetched while locked. Anyone walking past learns roughly where the PC is,
   with no PIN.
2. **The entire panel is a button**, not a small link. Accidental activation is
   easy, and a non-technical user has no reason to expect a lock screen to be
   clickable.
3. **Activating it prompts for the PIN and then opens a browser at msn.com.**
   An unrequested browser launch to a Microsoft content property, initiated
   from the lock screen.

**This is the argument for the setting, and it is stronger than the tidiness
argument the copy currently rests on.** It is a small privacy leak plus an
accidental-launch path. Stated at that level -- not inflated into a
vulnerability, because it is not one.

---

## 3. WHAT THIS CHANGES

**Setting 14's three-way choice, corrected. Row 3 only.**

| | Checkup can do it? | Basis |
|---|---|---|
| Widgets on/off | **NO per-user route.** Only the machine-wide `Dsh` policy | *measured* -- `TaskbarDa` write refused |
| Discover feed off | **NO** | *measured* -- old value absent, no replacement found |
| **Lock screen widgets off** | **YES -- effect proven in the field** | ***measured 2026-08-26***, this document |
| "Fun facts" promos off | **YES** | *measured* writable |

**For the ascii44 build:** the lock-screen third of setting 14 becomes a real
automated step with a real Revert string, rather than a manual instruction. The
other two thirds are unchanged and still manual.

**For the guide:** describe what the widget actually does -- city and temperature
visible while locked, whole panel clickable, opens a browser after the PIN.
Bill's own sentence is close to publishable as-is.

---

## 4. ONE MEASUREMENT THAT CONTRADICTS AN ASSUMPTION STILL IN USE

***measured on CGDELL 2026-08-26:*** `RotatingLockScreenOverlayEnabled` is
**absent** from the Lock Screen key. Bill's screenshot of the same page shows
**"Get fun facts, tips, tricks, and more on your lock screen"** is **ticked**.

**Absent is not off.** The research doc measured this value at **1** on
2026-08-24; it is absent two days later while the feature is still on. This is
the same "absent = default" assumption recorded in `CLAUDE.md` as having broken
on Edge settings on the second machine. **Any check that reads this family of
values must treat absent as unknown, never as disabled.**

**A likely cause surfaced later the same day, and it does not weaken the rule.**
***measured 17:03:*** CGDELL installed **KB5121003 on 2026-08-26**, and the
Lock Screen key's last write is **2026-08-26 04:16:03**. **An update plausibly
removed the value.** *Inferred, not measured* -- the key's write time covers any
value in it, so it cannot name which one changed.

**Either way the conclusion is the same, and it is the more important half:
a value can go from present to absent without the user touching anything, while
the feature it names stays on.** Whether Windows Update did it or something
else, a check that reads absent as "off" reports a state that was never true.

---

## 5. BOTH REMAINING GAPS CLOSED ON SANDY, 90 MINUTES LATER

**This section previously read "what is still not measured" and listed two
things. Both were measured on SANDY the same morning, before this document was
a day old.**

### The Settings toggle writes the value, and writes nothing else

**This was labelled *inferred* above. It is now *measured*, and isolated.**

Bill ran `Tool2\Run-SandyChecks.bat` on SANDY four times: three with lock screen
widgets **on**, one after turning them **off** in Settings.

***measured, full-file diff of `Test_Results\SandyChecks-SANDY-2026-08-26_11-07.txt`
against `SandyChecks-SANDY-2026-08-26_11-14.txt`:***

```
5c5
<   run at    : 2026-08-26 11:07:17
>   run at    : 2026-08-26 11:14:05
118c118
<       LockScreenWidgetsEnabled             1
>       LockScreenWidgetsEnabled             0
```

**Two lines differ in a 6,953-byte report: the run timestamp, and the value.**
`LockScreenWidgetsEnabled` read **1** at 11:00, 11:06 and 11:07, and **0** at
11:14. Nothing else in the system moved.

**So the direction is settled: the Settings toggle is what writes this value.**
Not a coincidence of two readings agreeing -- a before/after pair with a single
isolated change, on a **second machine** and a **different Windows edition**
(SANDY is Home, CGDELL is Pro).

### SANDY is measured

***measured, `SandyChecks-SANDY-2026-08-26_11-14.txt`:*** Windows 11 **Home**,
build **26200.9168**, display version **25H2** -- identical build to CGDELL.
Local account (`Panther`). `TaskbarDa = 1`, `WidgetService` running, the
`Widgets` process **not** running.

---

## 6. WHAT ELSE THOSE FOUR RUNS SETTLED, UNRELATED TO WIDGETS

**Recorded here because the runs were taken for the widgets question and these
came free. Each one changes something already on a list.**

- **~~SANDY's Windows Update is NOT paused, CGDELL still is.~~ CLOSED THE SAME
  DAY -- NEITHER MACHINE IS PAUSED.**
  ***measured on SANDY 11:14:*** all four `Pause*` values **absent**. This
  document then said the standing "un-pause **both** machines" job was really
  one machine, CGDELL, paused to 2026-09-06 -- **five days after launch.**
  ***measured on CGDELL 17:03 the same afternoon:*** all six `Pause*` values
  **absent**, and **KB5121003 installed 2026-08-26** -- the mandatory update
  CGDELL had been a month behind on at 26200.8875.
  **Both machines: 25H2, build 26200.9168.** CGDELL Pro, SANDY Home. The job is
  closed and the launch-spanning pause is gone.

- **Setting 6 cannot apply on either machine.** ***measured on SANDY:***
  `WTDS\Components` returns **"CANNOT READ -- Requested registry access is not
  allowed"** *while elevated*. The check's own note predicted the consequence:
  *"On CGDELL this refuses even when elevated. If it also refuses here, Checkup's
  setting 6 cannot apply on either machine."* **It also refuses here.** The
  setting 6 rename is on the ascii44 list; this says the rename may be the
  smaller half of the problem.

- **The Wake-on-LAN miss is explained, and it is not the Realtek driver.**
  ***measured:*** SANDY's active adapter is a **TP-Link Wireless Nano USB
  Adapter**, reporting `MagicPacket=Unsupported`, `Pattern=Unsupported`, and
  **no wake-related advanced properties at all**. The Realtek Ethernet is
  `Disconnected`. The earlier theory was "the Realtek driver uses different
  property names." The adapter that matters simply has no wake support.

- **SANDY's unencrypted starting state is intact.** ***measured:*** TPM
  present / ready / enabled **True / True / True**; `PreventDeviceEncryption = 0`;
  **C: and D: both `FullyDecrypted`, protection Off, key protectors NONE.**
  **D: exists** -- the F4 target drive. This is the one-shot resource the ascii43
  field run needs, and nothing has spent it.

- **Both Defender and Malwarebytes are registered on SANDY.** ***measured:***
  Malwarebytes `state 0x060000`, Windows Defender `state 0x061100`;
  `AMRunningMode Normal`, `RealTimeProtectionEnabled True`, `PassiveMode 0`,
  `IsTamperProtected True`. Defender is primary and not passive.

### Still needing Bill's eyes on SANDY, and they are cheap on the same trip

The report leaves five questions with dotted lines to write on: the Device
encryption entry under Privacy & security; the Phishing protection section and
its checkbox count; and M-3 (the Lock screen Widgets section's exact on-screen
label), M-4 (a Dashboards or Discover control in the board's settings), M-5
(does the board open on hover without clicking).
