<!-- Dated: 2026-09-30 16:36 ET -->
<!-- Editor: Claude Cloud -->
<!-- Stamp corrected by Claude Code 2026-09-30: this file arrived on CGDELL at 16:36 (file creation time, measured). The 18:31 it carried was about two hours in the future. -->
# Guide changes from the screen readings -- Parts 2 and 3 change list, and what changed in Parts 1, 4 and 5

- **Document Name:** GatewayGuard_GuideChanges-Parts2-3-ScreenReadings
- **Dated:** 2026-09-30 16:36 ET (arrival time on CGDELL; the 18:31 supplied was two hours ahead -- corrected by Claude Code)
- **From:** Claude Cloud
- **For:** Claude Code applies Section A to the twins; Bill reads Section B
- **Status:** CHANGE LIST. **Section A** (Parts 2-3) is a numbered old -> new list against the twins, per Working Rule 3. Claude Code applies each change with an assertion and reports which were applied. **Section B** logs what changed in `GatewayGuard_GuideDraft-Part1SafetyNet-Part4-Part5-2026-09-30-1636.md`, which Cloud wrote in full because it is Cloud's own draft.

---

## PROVENANCE

1. **Stamp -- stale.** `CURRENT.md`: Generated **2026-09-28 08:38 ET**, `da15aea`, made 08:35 ET, subject *"Renumber pass: main line 1-37 with no gaps..."*. Bill reports last commit **`bd90d2f`**. **Bill named the bases directly on 2026-09-30;** that stands in for the missing rows.
   - **Re-confirmed after regeneration:** `CURRENT.md` Generated **2026-09-30 15:51 ET**, commit **`bd90d2f`**, made **2026-09-30 15:35 ET**, subject *"Screen readings: S4 System Restore wizard page 2 read -- all readings done; finding 12 for Part 1"*. 90 rows. **Now rowed:** the screen readings, the Copilot triage, ForCopilot 1-3 and the 09-28 brief. **Still not rowed:** the 09-26 guide draft and its three companions (84 -> 90 is exactly the six new rows). `ForCopilot-1` is rowed and carries the same text the triage quotes, so the base is unchanged. Nothing in this file changed on re-reading.
2. **Bases:**
   - `GatewayGuard_CoPilotGuidePart2-2026-09-16-1627.md` and `GatewayGuard_CoPilotGuidePart3-2026-09-16-1627.md`. These have `CURRENT.md` rows as of `da15aea`, and Part 3's header says the `.md` is the live text.
   - `GatewayGuard_ScreenReadings-Checklist-2026-09-29-1931.md`: findings 1-12 and the rows they cite.
   - The ascii45 build.
3. **How read:**
   - Part 2, Settings 6, 7, 8 and 9: in full.
   - Part 3, Settings 10 to 15: in full.
   - The readings: as listed in the draft's provenance.
4. **Carried forward as fact:** nothing from a draft. **Every "new" text below quotes a reading by its row code, or the build.**
5. **Not seen:** Part 2 Settings 1-4, 16 and 17 bodies this session. None of findings 1-12 touches them except 17, which is an undo row in Part 4, not Part 2.

**Labels:** ***measured*** (reading row, or build text) / *sourced* / *inferred* / *guess*.

---

## A. PARTS 2 AND 3 -- NUMBERED CHANGES AGAINST THE TWINS

Each change gives the old text, the new text, and the evidence the new text rests on (the "checked against" base).

### Part 2

**P2-1 · Setting 8, How To Check** · *Finding 4*
- **Old:**
  > Windows 11 Home / Open Settings. / Search for Device Encryption. / Windows 11 Pro / Open Control Panel. / Open BitLocker Drive Encryption.
- **New:**
  > **Windows 11 Home:** Open Settings > Privacy & security > **Device encryption**. The switch is labelled **Device encryption**.
  >
  > **Windows 11 Pro:** Open Control Panel > **BitLocker Drive Encryption**. It should say **Windows (C:) BitLocker on**. **If it says BitLocker suspended, click Resume protection.**
- **Checked against:** ***measured.*** C5 (Pro: "Windows (C:) BitLocker suspended", link **Resume protection**) and the S5 note read on CGDELL ("BitLocker on" after Bill resumed it). S5 on SANDY gives the Home switch label **Device encryption**.

**P2-2 · Setting 9, How To Check** · *Finding 8*
- **Old:**
  > Open Settings. / Select Accounts. / Select Sign-In Options.
- **New:**
  > **The quickest check:** press the **Windows key** and **L** together. If the screen says **Enter your PIN**, you are set -- type your PIN to sign back in. If it asks for your password, sign back in, then set up a PIN: Settings > Accounts > Sign-in options.
  >
  > Below the box, **Sign-in options** shows a key symbol (your password) and a keypad symbol (your PIN). If you ever forget your PIN, click **Sign-in options**, choose the key symbol, and sign in with your password.
  >
  > Settings can say Windows Hello is not available on a computer where the PIN works. **The lock screen is the one to believe.**
- **Checked against:** ***measured.*** S2, Bill's phone photo of CGDELL, 2026-09-30: "Enter your PIN", a PIN box, "Sign-in options" with a key symbol (password) and a keypad symbol (PIN). **No "I forgot my PIN" link. No Cancel.** Build item 9's manual-check text says the same ("If it says Enter your PIN ... If it asks for your password ..."). The "not available" sentence: ***measured*** CGDELL, build plan Block H, H1 (Settings says every Hello option is unavailable; the PIN works).
- **Nothing tells the reader to press Cancel.**

**P2-3 · Setting 9, the VERIFY marker** · *Finding 8*
- **Old:**
  > ⚠ VERIFY -- a PIN can be created on a local account; a local account cannot reset a forgotten PIN without the account password.
- **New:** remove the marker. Add nothing in its place. P2-2 carries the forgotten-PIN route, and it is read off the screen.
- **Checked against:**
  - First half ***measured*** (H1): CGDELL's "Dad" is a local account that signs in with a PIN every day.
  - Second half: **dropped, not settled.** It assumed a "forgot PIN" link the screen does not have.

**P2-4 · Setting 6** · *Finding 9* -- **no change.** The twin already uses the three exact labels, and it already says to leave *Automatically collect website or app content...* unticked.
- **Checked against:** ***measured*** C14.
- *Noted for Bill, no guide change:* on CGDELL the password reuse and unsafe storage boxes are unticked while the fourth box is ticked. That is the reverse of the recommendation, and it is consistent with the twin's permission line ("On some computers Windows blocks it").

### Part 3

**P3-1 · Setting 10, the Quick Assist paragraph** · *Finding 7*
- **Old:**
  > To let a family member help you, use Quick Assist, which is built into Windows. Press Ctrl + Windows key + Q, or click Start and type Quick Assist. The helper clicks Help someone and reads you a code. You type that code, click Submit, then click Allow. You can end the session at any time by clicking Leave.
- **New:**
  > To let a family member help you, use Quick Assist, which is built into Windows. Press **Ctrl + Windows key + Q**, or click Start and type Quick Assist.
  >
  > **If a box asks "Let Quick Assist access your camera?", click No.**
  >
  > The window has two halves. Your helper uses **Help someone** on their computer and reads you a code. On yours, under **Get help**, type that code in the box under **Security code from assistant** and click **Submit**. Then click **Allow**. You can end the session at any time by clicking **Leave**.
- **Checked against:** ***measured*** C11 (CGDELL, 11:56). It gives **Get help**, **Security code from assistant**, **Submit**, **Help someone**, and the camera box ("Let Quick Assist access your camera? ... Yes / No").
- **Allow and Leave were not reachable** without a second device.

**P3-2 · Setting 10, the Quick Assist VERIFY marker** · *Finding 7*
- **Old:**
  > ⚠ VERIFY -- Quick Assist keys and button labels (Help someone, Submit, Allow, Leave) read off a live screen; currently from Microsoft's pages.
- **New:**
  > ⚠ VERIFY -- **Allow** and **Leave**, which need a real session with a second device; and that sharing works after answering **No** to the camera box.
- **Checked against:** C11 (as above). The camera answer is *inferred*: nothing read shows the session working after No. Hence the narrower marker.

**P3-3 · Setting 10, How To Check, and its VERIFY marker** · *Finding 11*
- **Old:**
  > It should say Off. If it says On, turn it off. / If Settings > System has no Remote Desktop entry, your computer is Windows 11 Home and cannot accept these connections. There is nothing to turn off. / ⚠ VERIFY -- exact on-screen path and label on Pro; what Home shows (page absent, or present and greyed).
- **New:**
  > **Windows 11 Pro:** the page has a switch labelled **Remote Desktop**. It should say **Off**. If it says On, turn it off.
  >
  > **Windows 11 Home:** the page has no switch. It says: *"Your Home edition of Windows 11 doesn't support Remote Desktop."* **That means this computer is already protected. There is nothing to do.**
  >
  > (marker removed)
- **Checked against:** ***measured.*** C10 (Pro, 11:55: "Remote Desktop -- Connect to and use this PC from another device using the Remote Desktop app", switch **Off**). S3 (SANDY Home, screenshot 27: the entry **is** in Settings > System; the page has no switch and shows the quoted sentence). It matches Checkup's Home result.
- **The old "no entry" sentence was wrong:** the entry exists on Home.

**P3-4 · Setting 13, What It Is, and its VERIFY marker** · *Finding 5 (labels, C12)*
- **Old:**
  > Continue running background extensions and apps keeps Edge running in the background after you close it. / ⚠ VERIFY -- the running-after-close claim, and the exact current label of Edge's background-apps toggle.
- **New:**
  > **Continue running background extensions and apps when Edge is closed** does what its name says: it keeps parts of Edge running after you close it.
  >
  > (marker removed)
- **Checked against:** ***measured*** C12. Edge's own labels are "**Startup boost** -- Opens Edge faster when you start your device." and "**Continue running background extensions and apps when Edge is closed**". The running-after-close claim now rests on Edge's own wording, not on a measurement of processes. That is the claim the guide makes, and no more.

**P3-5 · Setting 13, How To Check, last line** · *C12*
- **Old:**
  > Review Startup boost and Continue running background extensions and apps.
- **New:**
  > Review **Startup boost** and **Continue running background extensions and apps when Edge is closed**.
- **Checked against:** ***measured*** C12.

**P3-6 · Setting 13, What To Expect -- add** · *Finding 5*
- **New:**
  > After Checkup turns these off, Edge shows a **briefcase icon** beside both switches, and you cannot turn them back on in Edge. That is expected. To put them back, see **Part 4, 4.2, Setting 13**.
- **Checked against:**
  - ***measured*** C12: both switches Off with a briefcase icon, after Checkup.
  - ***measured*** build: item 13 writes `HKLM\SOFTWARE\Policies\Microsoft\Edge` `StartupBoostEnabled` = 0 and `BackgroundModeEnabled` = 0.
  - "Cannot turn them back on in Edge" is finding 5's statement. It is carried under the Part 4 VERIFY marker until someone tries.

**P3-7 · Setting 14, What To Expect** · *Finding 10*
- **Old:**
  > The panel still opens if you press Windows key + W, and you can turn Widgets back on at any time.
- **New:**
  > To confirm Widgets is off, press the **Windows key** and **W** together. Nothing should open. You can turn Widgets back on at any time.
- **Checked against:** ***measured*** C13, Bill: "Windows key + W does nothing." **The old sentence was wrong.**

**P3-8 · Setting 14, its VERIFY marker** · *Finding 10*
- **Old:**
  > ⚠ VERIFY -- Windows key + W with Widgets off, and Dashboards > Discover, read off a live screen.
- **New:**
  > ⚠ VERIFY -- Dashboards > Discover, read off a live screen with Widgets on.
- **Checked against:** C13 settled the Windows key + W half. Nothing opened, so Dashboards and Discover were never on screen.

---

## B. WHAT CHANGED IN THE PART 1 / PART 4 / PART 5 DRAFT

**Base:** `GatewayGuard_GuideDraft-Part1SafetyNet-Part4-Part5-2026-09-26-1459.md`. **New file:** `...-2026-09-30-1636.md`.

| # | Where | Change | Checked against |
|---|---|---|---|
| D1 | Part 1, *Make a restore point first* | Rewritten as four steps. Step 2 handles a grey **Create...** and quotes the window's own sentence. Step 3 is new: **Windows (C:)** > **Configure...** > **Turn on system protection** > **OK**. "About a minute" becomes "a few minutes" | ***measured*** C1, C1b (finding 1). Step 4 (the Create dialog) keeps a VERIFY: never read |
| D2 | Part 1, *What a restore point is* | *"Some of them it puts back and some it does not"* becomes *"It may put some of these settings back and not others, so do not count on it for them."* | Triage G1, in its suggested words. Scope VERIFY kept |
| D3 | Part 1, *Using a restore point* (new) | Five steps: **System Restore...**, the page heading **Restore system files and settings**, Windows' own sentence about documents and programs, **Next >**, the list (**Date and Time / Description / Type**), click an entry, **Scan for affected programs** first, then **Next >** and **Finish** | ***measured*** S4, screenshots 28-29 (finding 12). Steps 4 and 5 keep a VERIFY: the scan result and the pages after Next were not read |
| D4 | 4.1 | *"Keep the record."* becomes *"Keep the log file Checkup saves."* | Triage G2. The path stays VERIFY: no C3 reading surfaced |
| D5 | 4.2, Setting 1 | The pause line now quotes **Pause updates** / *"Select the date to pause updates until"*, a calendar up to about five weeks ahead, and **Resume updates**. VERIFY removed | ***measured*** C4 (finding 2). Nov 3 offered on 09-29 = 35 days |
| D6 | 4.2, Setting 6 | "untick the *Warn me about* boxes" becomes the three exact labels | ***measured*** C14 (finding 9) |
| D7 | 4.2, Setting 8 | Pro: **Turn off BitLocker**. Home: switch **Device encryption** Off. *"either way"* becomes *"with encryption on or off"*. VERIFY removed | ***measured*** C5, S5; triage G3 |
| D8 | 4.2, Setting 10 | Adds the Home line: nothing to put back, with the page's own sentence | ***measured*** S3 (finding 11) |
| D9 | 4.2, Setting 13 | Rewritten. **You cannot turn these back on in Edge**; the **briefcase icon**; the way back is to remove the policy (two named values under the named key), done with a helper; then turn both on in Edge | Finding 5; ***measured*** C12 and build item 13. **New VERIFY:** the briefcase's meaning (source) and that deleting the values restores the switches |
| D10 | 4.2, Setting 14 | Adds that on Home the reader may have turned it off themselves | Brief A8 / FT-283 (***measured*** on SANDY by Claude Code; I have not read the triage row itself) |
| D11 | 4.2, Setting 17 | *"choose Never"* becomes the full list of six choices; choose the one you had before; Checkup's log shows it on the line *Password on wake: was*; **Checkup recommends leaving sign-in required**. VERIFY removed | ***measured*** C6 (finding 3); triage G4; ***measured*** build: the apply code logs `Password on wake: was '...' -> now '...'`. **I used the log, not the "What Checkup changed" screen, because that screen is not built yet (F10)** |
| D12 | 4.2, new VERIFY (12 and 14) | *Inferred* risk: item 12 is also set by a Windows policy (build: `...\Policies\Microsoft\Windows\DataCollection`), so its Settings choice may be locked like Edge's. Setting 14 may be the same on Pro | Build text. Not in findings 1-12; **raised because finding 5's logic applies** |
| D13 | 4.3 | The restore steps move to Part 1 (Bill: Part 1 needs them); 4.3 points there. *"Your documents, photos and emails are not changed"* becomes Windows' own words, which do not mention email, plus the warning about programs and drivers | ***measured*** S4 (finding 12). "Emails" dropped: Windows does not say it |
| D14 | 4.4, last row | Adds the briefcase icon and a pointer to 4.2, Setting 13 | Finding 5 |
| D15 | 4.5, Step 1 | *"If you know which program it is"* becomes *"If you are sure which program it is"*; menu is **...**; VERIFY removed | Triage G5; ***measured*** C7 (**Advanced options**, **Move**, **Uninstall**) |
| D16 | 4.5, Step 2 | The four-times-a-year reminder sentence is removed and noted. Duration VERIFY kept | Brief A11 changes the scan flow; S6 points at a log I did not read |
| D17 | 4.5, Step 3 | Route is now **Virus & threat protection** > **Protection history**. **No recent actions** means nothing to deal with. Write down any name listed. *"should say"* kept. Status-word VERIFY kept | ***measured*** C8, S7 (finding 6); brief A7; triage G6 (reject "indicate") |
| D18 | 4.6 | *"Where your Checkup record is"* becomes *"Where your Checkup log file is"*; the list also points to 4.5 Step 3 | Follows D4, D17 |
| D19 | 5.3 | Windows key + L: VERIFY removed; the screen's words **Enter your PIN** added | ***measured*** C9 (09-27) and S2 photo |

**Markers:** 13 on 09-26, now **10**.
- **Removed (5):** 4.2 Settings 1, 8 and 17; 4.5 Step 1; 5.3.
- **Added (2):** 4.2 Setting 13; 4.2 Settings 12 and 14.
- **Reworded (1):** Part 1 now has one marker on the Create dialog and a second on the restore-use steps.

---

## C. NOT DONE HERE, AND WHY

- **The 09-28 brief's asks C1-C3** are not in this pass: F10's final Parts 4-5 text, the A1-A12 findings file, and the note-14 "nothing has been changed" sweep. This pass is findings 1-12 plus G1-G6, as asked. The draft above is the base F10 should take.
- **Offered, not applied** (Bill's call, question 3):
  - **Brief A6** settles half of Part 2 Setting 8's first VERIFY: on a local account, Device Encryption encrypts but cannot turn protection on.
  - **Brief A8** makes Part 3 Setting 14's permission line untrue on Home, where Windows refused Checkup's change.
  - Both are measured by Claude Code, but neither is in findings 1-12, and A8's triage row I have not read.
- **Website W-a to W-f:** wait for this wording to settle, per the triage.

---

## FOR CLAUDE CODE

```
Cloud's screen-readings pass:
  GatewayGuard_GuideDraft-Part1SafetyNet-Part4-Part5-2026-09-30-1636.md
    (supersedes the 09-26-1459 draft; full text)
  GatewayGuard_GuideChanges-Parts2-3-ScreenReadings-2026-09-30-1636.md
    (this file)
1. Apply P2-1 to P2-3 and P3-1 to P3-8 to the Part 2 and Part 3 twins,
   old -> new, asserting each old string. P2-4 is no change. Report which
   applied.
2. CURRENT.md has not been regenerated since da15aea (09-28 08:38).
   Run Tool2\Update-Current.ps1 LAST, after filing these, and give the
   09-26 and 09-30 guide drafts, the ScreenReadings checklist, the
   09-28 brief, the ForCopilot set and the triage their rows.
3. Tell Cloud: S6 -- the offline-scan start and desktop-return times from
   the CGDELL Checkup log Bill pointed to. C3 -- the log folder path, and
   does Open-My-Log.bat ship?
4. Build question, Bill's call first: should Checkup offer an undo for
   item 13 (and 12) instead of the guide sending a reader to Registry
   Editor with a helper?
File into ProjectDocs\, commit, push.
```

## QUESTIONS, HELD TO THE END

1. ~~Date and time~~ -- supplied as 18:31; corrected by Claude Code to the file's arrival time, 2026-09-30 16:36 ET.
2. **Bill:** Setting 13's way back is Registry Editor, with a helper. That is the only route today, and it is a poor one for this reader. Should Checkup offer to undo item 13 itself? The same may apply to 12 (D12).
3. **Bill:** apply brief A6 (Setting 8, local account) and A8 (Setting 14 on Home) in this pass, or hold them for the A1-A12 findings file?
4. **Bill:** the restore-point steps now live in Part 1, and 4.3 points back to them, as you asked. The cost is that a reader in trouble at 4.3 turns back to Part 1. Keep it, or put the steps in both places?
