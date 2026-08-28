# ascii43 field run 1 -- findings

# Dated: 2026-08-28 09:30 ET

**RUN IN PROGRESS. Bill is not finished with SANDY.** This file is opened now
rather than at the end so findings are not carried in anyone's head. Append as
the run continues.

- **Machine:** SANDY -- HP Laptop 17-by1xxx, Windows 11 Home, 25H2, 26200.9168,
  Machine ID `F7F13A97D58D`
- **Build:** ascii43
- **Logs:** `C:\Users\willi\OneDrive\GatewayGuard\Logs\` -- **personal OneDrive,
  not `Test_Results\`.** Worth writing down; a session looked in `Test_Results`
  and concluded the field run had not happened.
- **Runs so far:** `2026-08-26_18-07` (109 lines), `2026-08-26_19-43` (86),
  `2026-08-27_10-45` (328 -- the substantial one, opened 10:45:32 and exited
  06:14:26 the next morning via `Confirm-Exit`)
- **Screens reached:** 15 distinct, highest **screen 26**. Review, applying and
  the encryption path are all still ahead.

---

## FT-236 -- 192 TRUNCATION WARNINGS. THE CONSOLE WAS 60 COLUMNS

**Severity: high. This one contaminates the rest of the run if it is not fixed
before continuing.**

***measured, `GatewayGuard-Log-2026-08-27_10-45.txt`:*** **192 of the log's 328
lines** are:

```
[WARN] Write-GGBox: a line was truncated to fit the window (60 cols) -- FT-217
```

**96% of the log is this one warning.**

### The mechanism, measured

`Write-GGBox`, lines 2135-2141:

```powershell
try { if ([Console]::WindowWidth -gt 0) { $ggWin = [Console]::WindowWidth } } catch {}
$ggMaxContent = $ggWin - 4
if ($ggMaxContent -lt 16) { $ggMaxContent = 16 }
...
if (line.Length -gt $ggMaxContent) {
    $Lines[$ggWi] = line.Substring(0, $ggMaxContent - 2) + ".."
    Write-Log -Message ("... truncated ... (" + $ggWin + " cols) -- FT-217") -Status "WARN"
}
```

At **60 columns**, `$ggMaxContent` is **56**. ***measured:*** box content lines
run to about **61 characters**, and the header comment at line 827 records that
boxes reach **80 columns**. **So roughly 7 characters were cut from the right of
every long line, on every screen, for the whole run.**

### FT-217 is not the defect. It is the thing that noticed

**The guard worked exactly as designed** -- it truncated rather than corrupting
the box, and it logged every instance. **Without FT-217 this run would have
produced 192 silently mangled screens and no record.**

### The defect is that nothing told the user

Screen 1 is the maximize screen, and FT-27 (line 1424) records the wording
*"IF YOU HAVEN'T MAXIMIZED THIS WINDOW."* **That is advice. Nothing verifies it
happened, and nothing re-checks it at any later screen.**

The tool truncated 192 lines and **never said a word on screen.** The user sees
sentences ending in `..` with no explanation, on a security tool whose whole
promise is telling you plainly what is going on.

**A customer will hit this.** Not everyone maximizes, terminals get resized
mid-run, and `[Console]::WindowWidth` is re-read every render precisely because
it can change.

### Proposed fix -- for ascii44, not now

Check the width where the user can still act on it, and say so on screen:
**"This window is 60 characters wide. Checkup needs about 84 to show its screens
without cutting them off. Press Windows key + Up arrow to maximize, then press
Enter."** Re-check on each render is already happening; the missing half is
telling the person.

### ACTION BEFORE BILL CONTINUES

**Widen the console to at least 84 columns; maximize if possible** -- line 1365
records the wider layouts switching on at **>=116 cols**. **Screens 25 and 26
carry five of the six F1 keyboard checks and are still ahead.** Continuing at
60 columns measures truncation instead of content.

---

## FT-237 -- SETTING 6 LOGS AN [ERROR] ON A HEALTHY MACHINE

**Severity: medium. Customer-visible, and it is visible in the one artifact we
tell customers to send us.**

***measured:***

```
[2026-08-27 12:52:21] [ERROR] SILENT ERROR at Show-ScopeDisclaimer:
Requested registry access is not allowed.
| At ...W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1:5946 char:31
```

**Line 5946 is the setting 6 WTDS read**, inside `Get-AllStatuses`
(function starts line 5783):

```powershell
$pp = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components" -EA Stop
```

### The FT-141 fix is working. Something else is not

The setting-6 detect block catches this correctly and sets
**"Unknown -- Tamper Protection blocks this check; verify by hand"**, which is
the right answer and is why the *status* is not a finding. **But a global error
trap logs the same refusal as `[ERROR] SILENT ERROR` anyway.**

***measured on both machines, elevated:*** `WTDS\Components` cannot be read on
either. **So every run, on every correctly-hardened machine, writes an ERROR
into the customer's log for a condition that is normal and expected.**

**Section 9 of the licence and the log footer both tell the customer to email
this file to `support@gatewayguard.co`.** The file will contain a red ERROR
line. That is a support call we manufacture ourselves, every single run.

**This is the same family as F3's testable bullet** -- *"absent registry keys
read as INFO, not ERROR in your log."* That bullet covers **absent** keys; this
is a **blocked** key. The principle is identical and the blocked case was not
covered.

### And the location is wrong

The line says **`at Show-ScopeDisclaimer`** -- which is at **line 6601**, not
5946. It is a navigation breadcrumb naming where the user last was, not where
the error occurred. The real line number is in the text, so it is recoverable
-- but the function name sends a reader to the wrong place, and the comment at
line 701 shows this breadcrumb has misled before.

---

## FT-238 -- THE OFFLINE SCAN RESULT NEEDS ITS TIMELINE, NOT AN ALARM

**Severity: none yet. Recorded so it is not misread later.**

Bill: *"ran offline scan - did not find anything."*

***measured, same log:*** screen **14b "WELCOME BACK -- OFFLINE SCAN COMPLETE"**
rendered at **10:46:50 on 2026-08-27**, resuming from an `OfflineScanPending`
checkpoint. ***measured:*** the EICAR kit was not planted until **13:17 that
day**, and re-planted **06:06 on 08-28**.

**If that is the scan in question, finding nothing is the correct result --
there was nothing on disk to find.** It is not evidence of a scan blind spot.

**If a second offline scan was run after 06:06 on 08-28, with twelve specimens
present, then finding nothing is a serious result** and outranks everything
else in this file.

**Not measured: which one.** The distinction is a reboot and a timestamp.

---

## THE EXPERIMENT NOW RUNNING

Bill has real-time protection **off** -- **deliberately, and correctly.** With
it on, ***measured 2026-08-27 13:17***, Defender ate the ZIP and ADS specimens
on write, so the scan could never reach them. With it off,
***measured 2026-08-28 06:06***, all twelve survive. **That is the right
experimental setup, not a mistake.**

***measured on CGDELL:*** zero Defender exclusions of any kind, and the check
now reports SANDY's too, so an exclusion is not silently voiding the result.

**A full scan is running now. What each outcome means:**

| Outcome | Reading |
|---|---|
| Finds specimens on **C: and D:** | Scan coverage proven. **F4 fully cleared** |
| Finds **C: only** | `D:` is a scan blind spot -- serious, and exactly what F4 exists to fix |
| **Finds nothing** | The scan engine is not detecting. Outranks every other item here |

**Two things the moment it finishes:** turn real-time protection back **on**,
and run `Tool2\Run-AVTestKitCleanup.bat`. **SANDY is unprotected until then.**

---

## STILL AHEAD IN THIS RUN

Screens **27** (review), **27a** (applying), **28-31** (encryption, slowly, for
FT-229), **33** (scan schedule). And the five `Run-SandyChecks` questions that
need Bill's eyes: the Device encryption entry, and M-3 / M-4 / M-5.

---

## FT-239 -- WINDOWS TURNED REAL-TIME PROTECTION BACK ON BY ITSELF

**Bill, 2026-08-28:** *"MS turned on real-time protection when I started the
full scan."*

**This voids the second full-scan test, and it is also a product finding in its
own right.**

***measured, `SandyChecks-SANDY-2026-08-26_11-14.txt`:*** SANDY has
`IsTamperProtected True`. Tamper Protection exists precisely to stop real-time
protection staying off, and it did its job.

### Why this test cannot be run the way it was set up

**Real-time protection always reaches a file before an on-demand scan does.**
That is the whole point of it. So:

- **With real-time protection ON**, the specimens are caught at write time and
  the scan never sees them. ***measured 2026-08-27 13:17:*** exactly this --
  eleven detections in six seconds, in the kit's own write order.
- **With it OFF**, Windows turns it back on. ***measured 2026-08-28:*** exactly
  this, at the moment the scan started.
- **An exclusion** would hide the folders from real-time protection **and from
  the scan**, so it answers nothing.

**There is no clean way to run this test on a machine with Tamper Protection
on -- and Checkup RECOMMENDS Tamper Protection on.** Same shape as FT-141: the
tool's own advice makes a measurement impossible. That is not a defect, it is
the security model working.

### STOP. THE QUESTION F4 NEEDED ANSWERED IS ALREADY ANSWERED

**Gate 24 requires evidence for a SCREEN CLAIM. The claim is "full scan of all
your drives" -- a statement about SCOPE, not about detection capability.**

***Scope is measured.*** `FullScanCoverage-SANDY-2026-08-27_13-13.txt`: the
full scan ran 10:52:29 to 12:15:02, and MPLog carries 59 `D:` lines of the form
`ExpensiveFile:Scan time for \?\D:\...`, which the engine emits when it scans
a file and measures it. Converted from UTC, they fall inside the scan window.
**The full scan read files on D:. That is the claim, and it is evidenced.**

### The remaining question does not need answering, and here is the reasoning

*Inferred, from two measured facts, with the mechanism named:*

1. ***measured:*** the full scan reads files on D:.
2. ***measured:*** Defender detects `Virus:DOS/EICAR_Test_File` on D: -- eleven
   detections including five D: placements, and separately an offline scan that
   found and quarantined EICAR.

**Defender uses one engine and one signature set for real-time protection,
on-demand scans and the offline scan.** There is no mechanism by which it would
read a file on D: during a full scan and fail to match a signature it matches
on that same drive seconds earlier. **A test that cannot fail is not worth
82 minutes**, and this one has now cost two attempts and been voided twice by
the security model.

**Labelled honestly: scope is *measured*, detection-on-D-by-full-scan is
*inferred*. The screen wording claims scope. Ship it.**

### THE PRODUCT FINDING, WHICH IS THE PART WORTH KEEPING

***measured on the ascii43 source:*** two occurrences of re-enable wording in
the build, and ***measured:*** **zero** in `WebSite\html\defender-realtime.html`.

**Nothing tells the user that Windows turns real-time protection back on by
itself.** A senior who turns it off -- to install something, on someone's advice
-- and later finds it on again has been given a reason to think something else
changed their settings. **Ours is a product whose central promise is that
nothing changes without their permission.**

**For the guide's real-time protection page:** say that Windows turns this back
on by itself, that this is Tamper Protection doing its job, and that it is a
good thing. One short paragraph. It costs nothing and it pre-empts a support
call from a frightened customer.

### WHAT BILL SHOULD DO NOW

1. **Leave real-time protection ON.** Windows has already restored it; nothing
   to undo.
2. **Run `Tool2\Run-AVTestKitCleanup.bat`.** Whatever survives is being eaten
   as we speak; clean up the folders.
3. **Do not run a third full scan for this.** It will be voided the same way.
4. **Carry on with the ascii43 field run** -- widen the console to at least
   84 columns first (FT-236).
