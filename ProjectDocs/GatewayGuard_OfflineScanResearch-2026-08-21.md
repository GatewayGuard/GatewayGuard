<!-- Dated: 2026-08-21 13:40 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Defender Offline Scan -- what it actually covers, and two defects the research found

- **Document Name:** GatewayGuard_OfflineScanResearch
- **Last Modified:** 2026-08-21 13:40 ET
- **Last Editor:** Claude Code (CGDELL)
- **Asked for by Bill, 2026-08-21:** research the Microsoft offline scan with
  experts, forums and Microsoft support.
- **Closes:** ascii41 finding 16, open since 2026-08-18 and recorded then as
  *"research you asked for and I have not done."* It is done.

**Every claim below is labelled measured or sourced. Nothing here is
inferred.** Gate 24 applies -- a claim about what an external program scans is
a claim about an external program.

---

## 1. THE SHORT ANSWER

**The offline scan cannot be pointed at a second drive. There is no parameter,
and there is no setting. That is not a limitation to work around -- it is the
right design, and the fix is a different scan entirely.**

| Question | Answer | Basis |
|---|---|---|
| Can `Start-MpWDOScan` be scoped to `D:`? | **No. No scope parameter exists.** | **measured** on CGDELL + **sourced** |
| Does the offline scan cover `D:`? | **Not stated by Microsoft anywhere.** Its documented purpose is firmware, rootkits and the MBR | **sourced** |
| Does anything cover `D:`? | **Yes -- a full scan, explicitly** | **sourced** |
| Does Checkup ever run a full scan? | **No. Never.** | **measured** |

---

## 2. THE CMDLET SURFACE -- MEASURED, NOT ASSUMED

**measured on CGDELL 2026-08-21**, Defender module 1.0:

```
Start-MpWDOScan [-CimSession <CimSession[]>] [-ThrottleLimit <int>] [-AsJob] [<CommonParameters>]

Start-MpScan [-ScanPath <string>] [-ScanType <ScanType>] [-CimSession <CimSession[]>]
             [-ThrottleLimit <int>] [-AsJob] [<CommonParameters>]

ScanType valid values: FullScan, QuickScan, CustomScan
```

**`Start-MpWDOScan` takes no path, no drive, no scope of any kind.** The three
parameters it has are about remoting and job control. This matches the
Microsoft Learn cmdlet reference exactly.

**`Start-MpScan` is the one with `-ScanPath`.** That is the cmdlet that can be
aimed at a drive.

---

## 3. WHAT MICROSOFT ACTUALLY SAYS

### The offline scan is about the boot path, not about files everywhere

> *"The scan runs from outside the normal Windows kernel so it can target
> malware that attempts to bypass the Windows shell, such as viruses and
> rootkits that infect or overwrite the master boot record (MBR)."*

> *"The protection for Microsoft Defender Offline Scan focuses on firmware and
> rootkits."*

**sourced:** Microsoft Learn, *Microsoft Defender Offline scan in Windows*.

**The page never states which drives are scanned.** That silence is
consistent: the threat it exists for -- something that loads before Windows
and hides from a running system -- lives on the **system** drive. A data drive
has no boot sector in use.

### The full scan is where drive coverage is stated

> *"A full scan starts with a quick scan, and then continues with a sequential
> file scan of all the fixed and removable network drives that are mounted."*

**sourced:** Microsoft Learn, *Microsoft Defender Antivirus full scan
considerations and best practices*.

**That is the sentence that answers Bill's question.** Full scan covers all
mounted fixed drives. `D:` included.

### What the forums are worth here -- almost nothing

The Tom's Hardware thread on exactly this question produced, from a user
badged Expert:

> *"One would have to imagine/speculate a full scan would hit all connected
> drives..."*

**Imagine and speculate.** The moderator on the same thread described the
custom-scan UI without answering the question. **No forum source measured
anything**, and none is used as a basis in this document. Recorded because
Bill asked for the forum angle: the forums do not know, and where they sound
confident they are guessing.

---

## 4. SO THE FIX FOR FT-230 IS NOT WHAT I PROPOSED

**The ascii42 triage offered three routes and recommended "warn once on one
screen that Checkup does not check `D:`." The research makes that the wrong
answer -- it tells the user about a gap while leaving the gap open.**

**measured on the ascii42 source:** the build contains **no `Start-MpScan`, no
`FullScan`, no `CustomScan` and no `-ScanPath`.** The only scan Checkup ever
starts is `Start-MpWDOScan`. So on SANDY, with a 931.5 GB `D:`, **nothing
Checkup does has ever looked at that drive** -- and a full scan, which
Microsoft documents as covering it, is one cmdlet the build never calls.

**Revised recommendation for F4:**

1. **Keep the offline scan exactly as it is.** It is correct for what it does.
2. **Add a full scan to the scan plan** when more than one fixed drive is
   present -- `Start-MpScan -ScanType FullScan`, which Microsoft documents as
   covering all mounted fixed drives.
3. **Say plainly what each scan covers**, on the screens that offer them.
4. **Warn about the time.** A full scan of ~1.2 TB on SANDY's hardware is
   hours, not minutes. It belongs on the overnight path, not in the middle of
   a session.

This is strictly better than warning about a gap, and it costs one cmdlet call
that is already documented and already safe.

---

## 5. TWO DEFECTS THE RESEARCH FOUND, BOTH WORSE THAN THE QUESTION

### FT-233 -- DOWNGRADED BY THE FIELD, 2026-08-21. Not the defect I first wrote.

**I published this as a near-certainty and Bill refuted it from the field in
one sentence:** *"we have never needed our recovery key on sandy3 and cgdell
both fully encrypted."*

**He is right. Measured on CGDELL, 2026-08-21:**

```
Event ID 2030 (Defender offline scan configured for next reboot):
    2026-07-01, 07-04, 07-06, 07-07, 07-09      -- five occasions

manage-bde -protectors -get C:
    TPM
    Numerical Password  x4
```

**Five offline scans configured on a fully encrypted machine over nine days,
and the recovery key was never demanded.** Sandy3 is also fully encrypted with
the same result.

**The mechanism I missed.** The drive carries a **TPM protector**. WinRE is a
signed Microsoft environment, so booting into it does not change the
measurement the TPM seals against -- the key is released unattended and the
user sees nothing. That is the normal path on any machine with a working TPM
and Secure Boot, which is every machine on this fleet.

**What the source actually said, and what I did with it.** Microsoft's page
says *"you **may** be prompted."* I wrote it up as though it said *will*, and
then escalated to "it looks exactly like ransomware." **The word doing the
work in that sentence was one I had read and not weighted.**

**What survives, and it is much smaller.** The prompt is real, but only where
the TPM cannot release the key by itself:

- BitLocker configured with **no TPM protector** -- password or USB startup
  key only. Common on older or self-configured machines, **not present on this
  fleet.**
- A machine whose boot measurement has changed since encryption -- a firmware
  update, or Secure Boot being turned on or off between the two events.

**Revised recommendation: no code change in ascii43.** Checkup does not create
TPM-less BitLocker configurations -- it uses the Windows path, which uses the
TPM. **Worth one line in the guide** for readers who encrypted their machine
some other way, and nothing more.

**Why this entry is kept rather than deleted.** The reasoning failure is more
useful than the finding was. A documented caution was read, its hedge was
dropped, and the result was published with a severity the evidence never
supported -- while three machines sat in the next room disproving it. **THE
FIELD WINS is in CLAUDE.md precisely for this, and it took Bill to apply it.**

### FT-234 -- if WinRE is off, the offline scan silently does nothing

**sourced, Microsoft Learn:**

> *"If WinRE is disabled, the Windows Defender Offline scan doesn't run and no
> error messages are displayed. Nothing happens even if the machine is
> restarted manually."*

**Checkup already knows how to check this.** `Test-DeviceEncryptionPrereq`
reads `reagentc /info` and parses `Windows RE status: Enabled` -- lines
7456-7457. **measured: that check is used only on the encryption path.
`Invoke-OfflineScanOffer` does not call it.**

So on a machine with WinRE disabled, Checkup tells the user their computer
will restart and scan, the reboot achieves nothing, **no error appears
anywhere**, and the log records that the scan was started.

**This is FT-162 exactly.** That was `MpCmdRun.exe -ScanType 4`, which did not
exist, returned an error in 0.0 seconds, and printed `[GOOD]` for months. Same
shape, different cause: a scan that never runs, and a log that says otherwise.

**Fix:** call the WinRE check before offering or scheduling the offline scan.
The function already exists. If WinRE is disabled, say so and give the fix --
`reagentc /enable`, which is in Microsoft's own page.

### One more, smaller

**sourced:** offline scan *updates* require that *"Microsoft Defender
Antivirus must be your primary antivirus software (not in passive mode)."*
Checkup already establishes this -- the SANDY log reads *"Defender active as
primary AV. MB Free installed as companion."* **No defect. Recorded so the
next person does not re-research it.**

---

## 6. WHAT CHANGED, AND WHY THE RESEARCH WAS WORTH IT

**The question was "can the offline scan cover the second drive."** The answer
is no, and it does not matter, because a full scan covers it and Checkup never
runs one.

**Two defects were found on the way that nobody had asked about**, both in the
class this project keeps getting caught by -- **an action that reports success
while doing nothing, or that has a consequence nobody was told about.** FT-162
is the same class. So is FT-203. So is FT-230.

**Neither would have been found by reading the build.** They are properties of
an external program, documented on Microsoft's own page, and the only way to
find them was to go and read it.

**Next free FT number: 235.**

---

## SOURCES

- [Microsoft Defender Offline scan in Windows -- Microsoft Learn](https://learn.microsoft.com/en-us/defender-endpoint/microsoft-defender-offline)
- [Start-MpWDOScan cmdlet reference -- Microsoft Learn](https://learn.microsoft.com/en-us/powershell/module/defender/start-mpwdoscan)
- [Microsoft Defender Antivirus full scan considerations and best practices -- Microsoft Learn](https://learn.microsoft.com/en-us/defender-endpoint/mdav-scan-best-practices)
- [Does Windows Defender scan all hard drives? -- Microsoft Q&A](https://learn.microsoft.com/en-us/answers/questions/2742750/does-windows-defender-scan-all-hard-drives)
- [Does Defender Full Scan check external drives as well as internal? -- Tom's Hardware Forum](https://forums.tomshardware.com/threads/does-defender-full-scan-check-external-drives-as-well-as-internal.3678787/) *(speculation only -- not used as a basis)*
