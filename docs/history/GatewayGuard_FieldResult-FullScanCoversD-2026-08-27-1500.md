# F4 is unblocked: the full scan covered D:, proven three ways

# Dated: 2026-08-27 15:00 ET

**This closes the gate-24 prerequisite that has held F4 since 2026-08-22.**

The standing block, from `GatewayGuard_SessionLog`: *"that a full scan completes
and actually covers `D:` is **not measured** and must be, **on SANDY**, before
any screen text claims coverage."* **It is measured now.**

**Evidence file:** `Test_Results\FullScanCoverage-SANDY-2026-08-27_13-13.txt`,
produced by `Tool2\Run-FullScanCoverageCheck.bat` run elevated on SANDY.

---

## 1. THE FULL SCAN RAN, AND IT WAS A FULL SCAN

***measured on SANDY 2026-08-27 13:13, elevated:***

```
FullScanStartTime : 08/27/2026 10:52:29
FullScanEndTime   : 08/27/2026 12:15:02
DURATION          : 01:22:33
FullScanAge (days): 0

8/27/2026 10:52:29 AM  id 1000  Antimalware Full Scan
8/27/2026 12:15:03 PM  id 1001  Antimalware Full Scan
```

**Two independent sources agree** -- `Get-MpComputerStatus` and Defender's own
event log -- and the event text says **"Antimalware Full Scan"** in words, not
inferred from a parameter. **One hour twenty-two minutes**, which matches Bill's
"a little over an hour."

**Drives present:** `C:` 237.3 GB, **`D:` 931.5 GB, Fixed.** So D: is a real
fixed drive, not removable, and it is four times the size of C:.

---

## 2. IT TOUCHED D: -- 59 LINES, AND THEY ARE SCANNER LINES

***measured, from `MPLog-20260624-114417.log`, 21.7 MB:***

```
D:  YES -- 59 matching line(s)
  2026-08-27T15:29:37.413 ExpensiveFile:Scan time for `\\?\D:\Documents and Settings\Documents\LOANS\Downloads\KindleForPC-installer-1.19.46095.exe`
  2026-08-27T15:30:24.582 ExpensiveFile:Scan time for `\\?\D:\Documents and Settings\Documents - Copy\bookmarks.html`
  2026-08-27T15:32:42.182 ExpensiveContainer:Scan time for `\\?\D:\Documents and Settings\Documents\Samsung - Copy\recovery\WindowsRE\WinRE.wim`
```

**`ExpensiveFile:Scan time for` is a scanner record.** It is emitted when the
engine scans a file and measures how long it took. It is not a process-monitoring
line.

**That distinction is the whole reason this check carries a caveat**, and the
caveat earned itself on the first run: ***measured on CGDELL***, the same check
found exactly **one** D: line, and it was
`$f = "D:\GG-Recovered\Signmycode_Code-RECOVERED-2026-08-21.txt"` -- **a command
line string from a real-time-monitored process, not a scan at all.** A naive
"D: appears in MPLog, therefore it was scanned" would have passed CGDELL, where
no full scan has ever run.

---

## 3. THE TIMESTAMPS LOOKED WRONG, AND CHECKING WHY IS WHAT MADE THIS CONCLUSIVE

**The D: entries read 15:29, 15:30, 15:32. The scan ended at 12:15.** Read
naively, every one of them lands **after** the scan -- which would have meant
something else touched D: afterwards, and F4 would still be blocked.

**MPLog timestamps are UTC. The rest of the report is local.**

***measured on CGDELL 2026-08-27 14:49, which settles it without guessing:***

```
last MPLog entry   : 2026-08-27T18:49:02
current local time : 2026-08-27T14:49:05
current UTC time   : 2026-08-27T18:49:05     <- the log matches UTC
timezone           : Eastern, DST active, so UTC-4
```

**Converting SANDY's D: lines to local:**

| MPLog (UTC) | Local (EDT) | Inside 10:52:29 -- 12:15:02? |
|---|---|---|
| 15:29:37 | **11:29:37** | **yes** |
| 15:30:24 | **11:30:24** | **yes** |
| 15:32:42 | **11:32:42** | **yes** |

**All three fall inside the scan window.** Scanner-emitted lines, naming D:
paths, timestamped during the full scan. **That is the proof.**

**The check script should convert this itself** rather than leaving a reader to
notice. Filed as a small fix to
`Tool2\Check-FullScanCoverage-2026-08-27.ps1`: print MPLog times in local, or
print both, and say which is which. **A report that requires a timezone
correction to read correctly will eventually be read incorrectly.**

---

## 4. WHAT THIS UNBLOCKS, AND WHAT IT DOES NOT

### Unblocked

- **F4 can be built.** The screen may say **"full scan of all your drives"** --
  and must never say "offline scan," because ***measured 2026-08-22***
  `Start-MpWDOScan` has no scope parameter and cannot be aimed at a volume.
  `Start-MpScan -ScanType FullScan` is the call.
- **The pricing page's claim becomes true once F4 ships.**
  `WebSite\html\GatewayGuard_PricingSectionHtml-2026-08-23-1816.html:185` says
  the annual update *"scans your drives again"* -- knowingly left standing as a
  purchase page promising what the product could not do. **The measurement it
  waited on is now taken.** The claim is still false until F4 is in a build.

### NOT proven, and the distinction matters

**This proves the full scan READ files on D:. It does not prove it would DETECT
a threat there.** Those are different claims, and a customer is buying the
second one.

---

## 5. THE EICAR KIT WAS PLANTED AFTER THE SCAN, SO IT TESTED NOTHING YET

***measured:*** `Test_Results\AVTestKit-Manifest-SANDY-2026-08-27_13-17.txt` --
**13:17. The scan ended at 12:15.** The specimens were not on disk while the
scan ran, so **this run does not test scan coverage.** A second full scan is
needed, with the specimens already in place.

### But the plant itself produced a real result

| Placement | C: | D: |
|---|---|---|
| plain file | KEPT | KEPT |
| renamed extension `.dat` | KEPT | KEPT |
| deeply nested | KEPT | KEPT |
| hidden + system | KEPT | KEPT |
| **inside ZIP** | **EATEN** | **EATEN** |
| **ADS (alternate data stream)** | **EATEN** | **EATEN** |

**Real-time protection is live on D:, not only C:** -- it removed the ZIP and
the ADS specimen on D: at write time, exactly as it did on C:. **D: is not a
blind spot for real-time protection.** That is worth knowing on its own and was
not previously measured.

**The four KEPT placements on each drive want an explanation before the next
scan.** A plain EICAR `.txt` surviving on disk is not the expected behaviour --
***not measured:*** whether a Defender exclusion covers `C:\AVTestKit` and
`D:\AVTestKit`. **Check `Get-MpPreference -ExclusionPath` on SANDY before
reading the next scan's results**, because an exclusion would make the whole
kit report a false negative.

---

## 6. WHAT TO DO

1. **Eight EICAR specimens are on SANDY's disks right now** -- four on C:, four
   on D:. Inert, but they are there. **Either run the test or clean up**;
   do not leave them.
2. **Check `Get-MpPreference -ExclusionPath` first.** If `AVTestKit` is
   excluded, the next scan proves nothing.
3. **Then a second full scan** -- another ~1h22m. It can run during the ascii43
   field session; it needs no attention while it works.
4. **`Tool2\Run-AVTestKitCleanup.bat`** when done.
5. **Build F4 in ascii44.** The gate-24 evidence for the wording now exists.
