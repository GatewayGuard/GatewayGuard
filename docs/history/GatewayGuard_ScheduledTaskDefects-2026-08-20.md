<!-- Dated: 2026-08-20 01:20 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# FT-203 -- both scheduled reminders are off by default on a laptop

- **Asked by Bill 2026-08-20**, from a question about leaving a PC in
  hibernate overnight: do the two GatewayGuard tasks still fire?
- **Answer: often not, and nothing says so.**
- **Build:** ascii42, lines 7154-7157 and 7212-7214.

---

## WHAT THE TWO TASKS ARE

Both are **reminder popups**, not scans. That part is right and is the FT-175
fix -- Checkup no longer pretends to run a scan it cannot run.

| Task | Fires | Shows |
|---|---|---|
| `GatewayGuard - Quarterly Defender Offline Scan` | 1st of Jan/Apr/Jul/Oct, 10:00 | Steps to run the offline scan |
| `GatewayGuard - Monthly Malwarebytes Reminder` | 1st of each month, 10:00 | The Custom Scan and Deep Scan steps |

Both are created the same way:

```
schtasks /create /f /tn "<name>" /tr "<powershell -File ...>" /sc monthly /d 1 /st 10:00
```

---

## THE DEFECT, MEASURED

**Throwaway task created on CGDELL 2026-08-20 with the identical command shape,
settings read back, task deleted and deletion verified:**

| Setting | schtasks default | What it means |
|---|---|---|
| `StartWhenAvailable` | **False** | If the PC is off, asleep or hibernating at 10:00, the reminder is **skipped entirely and never shown later** |
| `WakeToRun` | **False** | It will not wake the machine |
| `DisallowStartIfOnBatteries` | **True** | **On a laptop running on battery, it does not run at all** |
| `StopIfGoingOnBatteries` | **True** | Unplug mid-popup and it is killed |

**`DisallowStartIfOnBatteries = True` is the one that matters most.** SANDY is
an HP laptop. A senior with a laptop, unplugged at ten in the morning, gets no
reminder -- and because `StartWhenAvailable` is False, it is not shown when
they plug in either. The quarter simply passes.

**Nothing reports this.** The log writes `[GOOD] Scheduled task created`,
which is true. The task exists. It just does not fire.

---

## WHY IT IS THIS WAY, AND IT IS NOT AN OVERSIGHT IN THE CODE

**`schtasks.exe` cannot set any of these.** Measured -- the complete switch
list from `schtasks /create /?` is:

```
/S /U /P /RU /RP /XML /SC /MO /D /M /I /TN /TR /ST /RI /ET /DU /K
/SD /ED /EC /IT /NP /Z /F /RL /DELAY /HRESULT
```

There is no switch for a missed start, for waking, or for battery. The only
route through `schtasks` is `/XML`.

And the build is on `schtasks` for a real reason: **FT-93/93b** abandoned
`New-ScheduledTask*` after C-14 (`$false` passed positionally to switch
parameters) and C-14a (`-Once` triggers expiring after a year), and **FT-109**
proved that raw `ProcessStartInfo` is the only construction whose `/tr`
quoting survives a path with a space. None of that should be undone.

---

## THE FIX, AND ONE PRODUCT DECISION INSIDE IT

**Recommended: keep `Invoke-SchTasksCreate` exactly as it is, then adjust the
three settings afterwards** with `Set-ScheduledTask -Settings
(New-ScheduledTaskSettingsSet ...)`, using **named** parameters only. This does
not reintroduce C-14: that defect was `$false` passed *positionally*, which is
a different thing from a named switch.

```
StartWhenAvailable         False -> True     show it at the next opportunity
DisallowStartIfOnBatteries True  -> False    run on battery
StopIfGoingOnBatteries     True  -> False    do not kill a popup mid-read
WakeToRun                  False -> LEAVE IT FALSE
```

**`WakeToRun` should stay off, and that is a product call, not a technical
one.** Waking a senior's laptop out of hibernate at ten in the morning to
throw up a message box is the behaviour people uninstall software over. With
`StartWhenAvailable` on, the reminder appears the next time they turn the PC
on -- which is what they want and is the same thing Windows Update does.

**Read the settings back after setting them and log what was read, not what
was intended.** That is the FT-162 lesson exactly: `ScanType 4` logged
`[GOOD] Scheduled task created` for months while returning
`0x80070667 -- Invalid command line argument`. A gate with no check is a wish.

---

## WHAT IS NOT KNOWN

- **Neither task is present on CGDELL** (measured -- `Get-ScheduledTask`
  returns nothing matching `*GatewayGuard*`). So no field data on whether they
  have ever fired on any machine.
- **SANDY has not been checked.** `Tool\Run-ScheduledTasksCheck.bat` exists and
  would answer it; the last result on file is
  `Test_Results\ScheduledTasks-SANDY-2026-08-02_06-24.txt`, before the FT-175
  rewrite.
