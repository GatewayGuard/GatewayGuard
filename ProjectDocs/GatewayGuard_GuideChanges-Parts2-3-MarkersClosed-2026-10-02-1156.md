<!-- Dated: 2026-10-02 11:56 ET -->
<!-- Stamped by Claude Code: the time this file arrived on CGDELL (file creation time, measured). -->
<!-- Editor: Claude Cloud -->
# Guide Parts 2 and 3 -- closing the last VERIFY markers

- **Document Name:** GatewayGuard_GuideChanges-Parts2-3-MarkersClosed
- **From:** Claude Cloud
- **For:** Claude Code applies Section A to the twins, asserting each old string. Bill reads Section B.
- **Status:** CHANGE LIST (Working Rule 3).
  - **Markers before:** Part 2 has 2, Part 3 has 5.
  - **After this list:** Part 2 has 0, Part 3 has 2. The two that stay need a second PC (R7) or Widgets switched on (R8).

---

## PROVENANCE

1. **Stamp:** `CURRENT.md` Generated **2026-09-30 16:43 ET**, commit **`6f3ab29`**, made 16:23 ET, subject *"Gate 27 extended: A1 regenerates CURRENT.md into any ProjectDocs commit, W1 warns on no session-log entry today, S2/S3 refuse unfilled or typed stamps; Tool2/stamp.py writes the clock time"*.
2. **Bases:**
   - `GatewayGuard_CoPilotGuidePart2-2026-09-16-1627.md` and `GatewayGuard_CoPilotGuidePart3-2026-09-16-1627.md` (rows in `CURRENT.md`). **Confirmed in my snapshot:** P2-1 to P2-3 and P3-1 to P3-8 are applied. Part 3 Setting 10's How To Check now quotes the Home message, and Setting 13 carries the briefcase line.
   - `GatewayGuard_Research-Q7-BitLockerMicrosoftAccount-2026-08-24-0300.md`, which quotes Microsoft Support.
   - Brief A6 / build plan H7 / FT-289, ***measured*** on SANDY: `Test_Results/EncryptionStart-SANDY-2026-09-27_17-00.txt`.
3. **How read:** the twins' Setting 8, 12, 13, 15 and 18 sections in full, from this snapshot.
4. **Carried forward as fact:** nothing from a draft. Every new sentence names its source in its row.
5. **Not seen:**
   - Quick Assist's **Allow** and **Leave** (R7).
   - The Widgets panel's settings (R8).

---

## A. NUMBERED CHANGES

### Part 2

**P2-5 · Setting 8, What It Is**
- **Old:**
  > Windows 11 Pro typically uses BitLocker.
  >
  > Windows 11 Home may use Device Encryption.
  >
  > ⚠ VERIFY -- Home/Pro split and whether Device Encryption on Home requires a Microsoft account. BitLocker Test 2 on SANDY answers this; sentence held until then.
- **New:**
  > Windows 11 Pro uses **BitLocker**.
  >
  > Windows 11 Home uses **Device encryption**, on computers that support it. If you sign in with a Microsoft account, Windows can turn it on for you. If you sign in with a local account (one that is not a Microsoft account), it does not.
  >
  > On our test computer, which uses a local account, Device encryption scrambled the drive but could not switch protection on, because Windows had nowhere to save the recovery key. Settings said protection would resume at the next restart. It did not, across three restarts. Checkup tells you if your computer is in this state.
- **Checked against:**
  - *sourced*, Microsoft Support via Research-Q7: *"If you're using a local account, Device Encryption isn't turned on automatically."* With a Microsoft account, it turns on and the key is attached to the account. If the Device encryption page is missing, the hardware does not support it.
  - ***measured***, SANDY, A6 / FT-289: Windows logged "Failed to backup ... to your Microsoft account" and then "Failed to automatically enable Device Encryption". Settings said "resume at next restart", and three restarts later protection was still off.
  - ***measured***, build: screen 96 handles the encrypted-but-not-protected state.

**P2-6 · Setting 8, What To Expect**
- **Old:**
  > A recovery key will be generated.
  >
  > ⚠ VERIFY -- on a Microsoft account the key is saved to the account automatically; on a local account it is saved nowhere automatically. One of the two claims that can cost a reader their files.
- **New:**
  > Windows makes a **recovery key**. With a Microsoft account, Windows saves a copy to that account. **With a local account, nothing saves it for you.** Save it yourself: to a USB flash drive, to a file kept somewhere other than this computer, or on paper.
- **Checked against:**
  - *sourced*, Microsoft Support, "Back up your BitLocker recovery key" (Research-Q7 §3): the four places are Microsoft account, USB flash drive, file, and paper.
  - "Somewhere other than this computer" is from the same research's caution: a file saved on the encrypted drive is useless.
  - ***measured***, SANDY, A6: on a local account the backup to a Microsoft account failed.

### Part 3

**P3-9 · Setting 10, the Quick Assist marker** -- no text change. The marker stays and points to **R7**.
- **Old:**
  > ⚠ VERIFY -- **Allow** and **Leave**, which need a real session with a second device; and that sharing works after answering **No** to the camera box.
- **New:**
  > ⚠ VERIFY -- **Allow** and **Leave**, which need a real session with a second device; and that sharing works after answering **No** to the camera box (reading R7).

**P3-10 · Setting 12, Why It Matters, and its marker**
- **Old (two places):**
  > Windows Update and your protection work exactly the same at either level.

  and, under What To Expect:
  > ⚠ VERIFY -- Windows sends the larger level unless told otherwise; updates are identical at either level.
- **New:**
  > Microsoft says the Required level is the minimum it needs to keep Windows secure and up to date.

  The marker is removed. The "larger level unless told otherwise" claim is **not** in the text, so nothing replaces it.
- **Checked against:** *sourced*, Microsoft:
  - privacy.microsoft.com/data-collection-Windows: *"Required diagnostic data is minimum data necessary to help keep the Windows operating system ... secure, up to date and performing as expected."*
  - support.microsoft.com/help/4468236: *"We use Required diagnostic data to keep Windows devices up to date."*

**P3-11 · Setting 14, the Dashboards marker** -- no text change. The marker stays and points to **R8**.
- **Old:**
  > ⚠ VERIFY -- Dashboards > Discover, read off a live screen with Widgets on.
- **New:**
  > ⚠ VERIFY -- Dashboards > Discover, read off a live screen with Widgets on (reading R8).

**P3-12 · Setting 15, the Firefox line and the marker**
- **Old:**
  > Firefox: Settings > Privacy & Security > Ask to save passwords.
  >
  > ⚠ VERIFY -- the Chrome and Firefox labels, read off live copies of each browser.
- **New:**
  > Firefox: Settings > Passwords and autofill (in older versions, Privacy & Security) > Ask to save passwords.

  The marker is removed.
- **Checked against:** *sourced*:
  - **Chrome:** support.google.com/chrome/answer/95606 (already the source in `GuidePart3-Sources-2026-09-25-1320`).
  - **Firefox:** support.mozilla.org/kb/disable-password-saving-firefox and /kb/autofill-logins-firefox. Current versions open **Privacy & Security > Passwords and autofill**, and the box is **Ask to save passwords**. Older versions put it under Privacy & Security.
  - These are the vendors' own pages, not a live read. That is enough for a label the guide does not ship in Checkup.

**P3-13 · Setting 18, Why It Matters, and its marker**
- **Old:**
  > Some updates and repairs only finish after a real shutdown, so problems can carry over from one day to the next.
  >
  > ⚠ VERIFY -- which updates and repairs need a full shutdown to finish.
- **New:**
  > Microsoft says some Windows updates can only finish after a full shutdown. **Restart** always does a full shutdown, even with Fast Startup on.
- **Checked against:** *sourced*:
  - Microsoft Learn KB 4011287: *"Installation of some Windows updates can be completed only when starting your computer after a full shutdown."*
  - support.microsoft.com/help/3211190: *"The Fast Startup setting doesn't apply to Restart."*
  - **"Repairs" and "problems can carry over" are dropped.** Neither page says them.
  - *Inferred:* KB 4011287 is written for Windows 10. The hybrid shutdown is the same mechanism on 11.

---

## B. FOR BILL -- found while reading, not changed

1. **Setting 18:** the same Microsoft page (3211190) says *"Disabling Fast Startup is not recommended."* The guide already says Windows' "(recommended)" label is Microsoft's default, not GatewayGuard's advice. That stays honest, but it is a disagreement with Microsoft, and a reviewer may find this page.
2. **Setting 13, Why It Matters:** *"it also consumes memory and background resources even when the browser is not being used"* carries no marker. Nothing in the repo measures it, and the Widgets measurement showed how wrong memory claims can be. Suggested replacement, using Edge's own label: *"With it on, part of Edge keeps running after you close it."* Your call.
3. **Setting 15:** Chrome's path still names *"Google Password Manager"*, the menu label the reader must click. This is open question 6 from 09-26: is it a literal screen label, or covered by the no-names rule?

---

## C. READINGS STILL NEEDED -- one line each

R1-R6 are in the Part 1/4/5 final file. R7 and R8 are the two for Parts 2-3.

| # | PC | Open and read |
|---|---|---|
| R1 | CGDELL | Windows key > *Create a restore point* > Enter > **Create...**. Read the name box's title, its button, the message after it finishes, and the button that closes it. |
| R2 | CGDELL | **System Restore...** > **Next >** > click your restore point > **Next >**. Read the page heading and every button, then **Cancel**. |
| R3 | CGDELL | On the restore-point list, click an entry > **Scan for affected programs**. Read the headings and what it lists, then close it. |
| R4 | CGDELL | Claude Code drops the harmless EICAR test file (as on 09-08). Then Windows Security > Virus & threat protection > **Protection history** > click the entry. Read the status words and every button. |
| R5 | CGDELL | After a Checkup run, delete **StartupBoostEnabled** and **BackgroundModeEnabled** under `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge`, then reopen Edge > System and performance > Startup boost. Is the briefcase gone, and can both switches turn on? Put them back with Checkup. |
| R6 | CGDELL | After a Checkup run: Diagnostics & feedback (can **Optional diagnostic data** be chosen? any "managed by your organization" line?), then Taskbar settings (can **Widgets** be turned On?). |
| R7 | CGDELL + a second PC | Second PC: Quick Assist > **Help someone**, read the code aloud. CGDELL: Ctrl + Windows key + Q > answer **No** to the camera box > type the code under **Security code from assistant** > **Submit**. Read the next button (**Allow**?) and the button that ends the session (**Leave**?). Does screen sharing work? |
| R8 | CGDELL | Turn Widgets On > click the weather on the taskbar > the panel's settings (gear). Read **Dashboards** and **Discover** exactly as shown, then turn Widgets back Off. |

---

## FOR CLAUDE CODE

```
Apply P2-5, P2-6, P3-9 to P3-13 to the Part 2 and Part 3 twins,
old -> new, asserting each old string. Report which applied.
Then grep -c "VERIFY" on each twin: expect Part 2 = 0, Part 3 = 2.
B-1 to B-3 wait on Bill. Readings R1-R8: Bill at CGDELL (R7 also
needs a second PC); R4 needs the EICAR file from you first.
```
