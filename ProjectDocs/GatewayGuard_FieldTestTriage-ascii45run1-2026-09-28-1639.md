<!-- Dated: 2026-09-28 16:39 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii45 -- SANDY test run 2026-09-28, triage

- **Bill's notes:** `Test_Results\Ascii45-TestRun-2026-09-28-1421.txt` (20 points).
- **Logs (SANDY, HP Laptop 17, Windows 11 Home, Windows Terminal):**
  `OneDrive\GatewayGuard\Logs\GatewayGuard-Log-2026-09-28_14-18.txt` (start to
  the offline-scan restart, 14:18-14:30) and `...2026-09-28_14-40.txt` (resume
  after the restart to the end, 14:40-16:29). Run finished; checkpoint cleared.
- **Next free FT on entry: 302.** Used here: **302-309.** Next free after: **310**.
- Labels: **DEFECT** (code is wrong), **WORDING** (text change), **QUESTION**
  (Bill asked; answer below), **KNOWN** (already on file).

## The one defect behind notes 3, 4 and 17 -- fix first

**FT-303 -- an antivirus that is only INSTALLED is treated as IN CHARGE.**
***Measured:*** `Get-GGOtherAV` returns every non-Defender product registered
with Windows Security (build `Get-GGOtherAV`), with no check that it is
running. SANDY has Malwarebytes Free installed and **off**; Defender is on
(log 14:23:54 "Defender active as primary AV"). Because of it:
- **Unwanted-app blocking was never checked** (no "PUAProtection read" line in
  the log; checkpoint PUA saved at 14:24:08 with no screen) -- note 4.
- **Virus definitions were never checked** (same branch).
- **The full scan was never offered** (log 14:44:59 "Full scan offer skipped --
  Malwarebytes is the antivirus").
- **Screen 15 said Malwarebytes is your antivirus** -- note 3.
**Fix:** those three skip only when Defender's own real-time protection is
**off** (another antivirus really in charge), read with `Get-MpComputerStatus`
as screen 14b already does. Installed-but-off products get named, not obeyed.

**FT-307 -- screen 14b showed the other antivirus with NO NAME** -- note 17.
***Measured:*** log 14:23:54 "Also registered (not in charge): " -- blank.
Code: `$ggAlso = $nonDefender[0].displayName` in `Test-DefenderPrimary`.
*Inferred:* with ONE other product `$nonDefender` is a single WMI object, not a
list, and `[0]` on it asks the object for a property named "0" -- empty.
**Fix:** `@($nonDefender)[0].displayName`, and a test with one product.

## Note by note

| # | Bill's note (short) | Evidence | Class | What to do |
|---|---|---|---|---|
| 1 | Screen 10: pressed I, had to press Space twice to go back | Log 14:20:28 I at `Get-WinEdition` (screen 9), 14:20:34 screen 10 | **DEFECT FT-302** (to confirm) | After the I screen, the screen you were on should come back and ONE key should continue. Check if the redraw works in Windows Terminal (it restores a picture of the buffer, FT-259 family) |
| 2 | "Checking Windows Update" -- say it can take a while | SANDY: 38 s (14:24:08-14:24:46) | WORDING | "Checking Windows Update -- this can take a while." |
| 3 | Screen 15: "Malwarebytes is your antivirus" -- wrong | above | **DEFECT FT-303** | above |
| 4a | Was app blocking checked and approved? | Not checked | **DEFECT FT-303** | above |
| 4b | Offline scan: bottom message should say "awaiting restart"; took ~5 min | Log 14:30:47 Y, restart 5 s later | WORDING | "Waiting for Windows to restart..." |
| 5 | Had to sign back in; was the user told what to do after the restart? | Screen 17 text | WORDING | Say plainly: "After the restart, sign in as usual, then run Checkup again and choose R." |
| 6 | Protection-history link opened the antivirus page, not history; rewrite: what to do, take notes, point to the guide | Also measured 09-27 (Block G4) | **KNOWN FT-277** | 17a gives the route by hand: Windows Security -> Virus & threat protection -> Protection history; "write down any name you see"; "Guide: Setting 2" |
| 7 | Screen 20: readings or recommendations? "Nothing was changed" makes no sense -- nothing was offered | Screen 20 is report-only (F3) | WORDING + FT-304 | Head the columns "Now" and "Recommended"; drop the line |
| 8 | Screen 22: "a checklist in this window" -> "a checklist will appear later"; stop saying "nothing has been changed" where nothing was offered -- it will make users suspicious | Screens 22, 24, 25 and others | WORDING, **FT-304** | Sweep every "nothing has been changed / changed nothing" on screens that offer no change; keep it only where a change WAS offered and declined |
| 9 | Screen 24: "risky features" -- are they explained? say they will be | Screen 24 | WORDING | "Each one is explained when you reach it." Drop "nothing changed" (FT-304) |
| 10 | Screen 25: "at the end Checkup shows what changed and how to put each one back" reads as second-guessing; "for all available settings"; "sleep active" line -- why, and it contradicts the 5-minute advice | Screen 25 | WORDING | Keep "what changed", drop "how to put it back" from this screen; the sleep line says what it means: "Checkup keeps your PC awake while it runs; your own sleep setting comes back when it closes" |
| 11 | Screen 26: move the Setting/Status line left; item 6 status: "Blocked by Tamper Protection -- check by hand -- Checkup will show you how" | Log 15:49:16 "name 101, status 62" on a 174-wide window | **DEFECT FT-305** + WORDING | The name column should be only as wide as the longest name (51 here), so the status gets the rest |
| 12 | Screen 27: status too far right; is there more screen-28 wording? | Log 15:56:03 "name 130 (needed 41)" | **FT-305** / QUESTION | Same fix. Answer: no |
| 13 | Screen 28: appends below instead of a new screen; "(may need to select turn on)" on reputation-based protection; "does not need it" -> "recommends you turn it off"; "registry is protected" -> "settings are protected" | Item 6 run, 16:03:42-16:09:39 | WORDING + DEFECT (clear the screen before applying) | as Bill wrote |
| 14 | Item 6: "Working on this item" -> "Do this:"; remove the repeated phishing line, "enable annually", the extra "press Enter" and the repeated "manual required"; sweep these repeats | Item 6 output | WORDING, FT-304 | as Bill wrote |
| 15 | Item 14 (Widgets): says it disables the panel, but it is still on the taskbar; "unauthorized operation" error | Log 16:11:31 ERROR at build line 7594 (`Set-ItemProperty ...Dsh AllowNewsAndInterests`); SANDY ACL measured 09-27: Administrators FullControl | **KNOWN FT-283**, still open | The write is refused although the key's permissions allow it. Until the cause is found, item 14 gives the manual steps (Settings -> Personalization -> Taskbar -> Widgets Off) and never says "disabled" |
| 16 | Screen 33 "All selected items processed" -- incorrect | Log: item 6 manual, item 14 ERROR, then screen 33 at 16:27:22 | **DEFECT FT-306** | Say what happened: "Done: N. Needs you: N. Could not be done: N." |
| 17 | Screen 17: Malwarebytes installed, not recognized | above | **DEFECT FT-307** | above |
| 18 | At the end: did we tell the user everything they need to know and do? | Screens 34, 35, 37 | QUESTION | To check against the guide when F10 lands: every manual item in 35, and 37 lists the rest |

## Found in the logs, not in the notes

| FT | Evidence | Class | Fix |
|---|---|---|---|
| **FT-308** | Log 16:29:47 `[ERROR] SILENT ERROR` at build line 8279 (`Remove-GGOldMBReminder`: `Get-ScheduledTask ... -EA SilentlyContinue`) -- "No MSFT_ScheduledTask objects found" **after** the removal was read back as gone | DEFECT (log noise, looks like a failure in the file customers email) | Clear the expected "not found" from `$Error`, as FT-285 did for registry reads |
| **FT-309** | Log 15:31:58 five `[INFO] NOT SET (expected) -- fault at ... 4034` lines (`Get-GGPolicyLock` reading absent policy keys) | WORDING (log) | Handled correctly, but the "fault at" wording reads like an error. Say "policy not set (normal)" in one line |
| -- | Checklist line 15:52:51 "key ignored ()" -- blank key name | minor | Name non-printing keys ("key code N") as the other readers now do (C2) |

## Worked as intended in this run (measured, same logs)

Resume after the offline-scan restart went straight to 17a with no screens 10/11
replayed and the personal-PC question skipped (Machine ID matched); item 9 read
Windows Hello from the last sign-in; item 12 read the Settings value (1 = off,
GOOD); item 4 read all three parts; F redrew the checklist; the old monthly
Malwarebytes reminder was removed and read back gone; the run cleared its
checkpoint at the end.
