  <!-- Dated: 2026-08-18 02:10 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii41 field checklist -- the 12 things to look for

- **Build:** `W11-SecurityHardening-v3-ascii41-2026-08-17-2246.ps1`
- **Launcher:** `Tool\Run-GatewayGuard.bat` -- RIGHT-CLICK, Run as administrator
- **Machine this is written for:** SANDY. Windows 11 **Home**, **local**
  account, **two** drives, **not encrypted**, **personal OneDrive present**.
  All four facts change what you should see, and all four are measured:
  `Test_Results\Logs-Sandy\GatewayGuard-Log-2026-08-17_09-44.txt`,
  `Test_Results\EncryptionProfile-SANDY-2026-08-11_15-15.txt`,
  `Test_Results\OneDriveSync-SANDY-2026-08-12_13-15.txt`.

**Twelve changes. None has ever run.** Anything not on this list that looks
wrong is worth writing down too -- this list is what to *check*, not the
limit of what to *report*.

---

## THE FAST VERSION -- if you only have ten minutes

| # | Do this | Good looks like |
|---|---|---|
| 1 | Watch the very first second | **No flash** before the first screen |
| 2 | Read the screen numbers as you go | They only ever go **up** |
| 3 | Press **I** at any question | Build + Machine ID appear |
| 4 | Look at the PC summary screen | **Both** drives listed |
| 5 | Continue past the repeat-run reminder | You are **offered** the Defender offline scan |
| 6 | Finish, then open your log | It is in **OneDrive**, not `C:\GatewayGuard` |

---

## ALL TWELVE

### 1. FT-172 -- screen numbers come from a table now

**The old numbers were counted while you ran, so two people got different
numbers for the same screen.** That is the whole of your finding 35.

- **Do:** read the number on each screen as you go. Go **back** a few times.
- **Good:** first-time screens only ever ascend -- 1, 2, 3, 4. Going back
  re-shows that screen's **own** number (that is correct, you approved it).
- **Good:** branch screens read like **14a**, **17c**, **25b**.
- **BAD:** any first-time screen showing a number **lower** than one already
  seen. **This is the one finding that would sink the design -- write down
  both numbers and both screen titles.**

### 2. FT-172 -- the intro screens are numbered at last

- **Do:** look at the first three screens (welcome, scrolling, font).
- **Good:** they say **Screen 1**, **Screen 2**, **Screen 3**.
- **Good:** the font banner says **SET YOUR CONSOLE FONT** with **no**
  "STEP 1 OF 2" -- there was never a step 2. That is your finding 4.
- **BAD:** any "(Screen N of 6)" anywhere. All six typed numbers were deleted.

### 3. FT-172 -- the checklist shows its number

- **Do:** on the big settings checklist, read the top bar.
- **Good:** it says `Screen 25 -- PAGE 1 of 2`, and page 2 says **26**.
- **Note:** the log now records it too. Previously the log jumped 21 to 23
  while you were looking at a screen calling itself 22.

### 4. FT-184 -- the flash is gone

- **Do:** watch the first second after the window opens.
- **Good:** nothing flashes past. Straight to the first screen.
- **This was your finding 1a, and 1 in ascii39.** It was a real screen with
  the build and Machine ID on it, wiped a second later by the next screen.

### 5. FT-189 -- press I at any question

- **Do:** at **any** Y/N prompt, press **I**.
- **Good:** a screen appears with your **Build** and **Machine ID**, and the
  folder holding your log. Press Enter and you are **back where you were**.
- **Do:** try **I** on two or three different screens.
- **BAD:** it does nothing, or it loses your place.

### 6. FT-189 -- Open-My-Log.bat

- **Do:** after the run, open the folder named on the I screen.
- **Good:** `Open-My-Log.bat` is there. Double-click it -- **your log opens in
  Notepad.**
- **BAD:** the file is missing, or the window blinks shut without Notepad.

### 7. FT-173 -- no more silent keys

- **Do:** at a Y/N question, press a key that is **not** offered -- `X`.
- **Good:** it tells you **that key does nothing here**, and names the keys
  that do work.
- **Before this, nothing happened at all** -- no message, nothing on screen.
  There was no way to tell a dead key from a frozen program. That is probably
  why the missing Back on the passwords screen went unreported for two builds.
- **Also do:** press **B** on the "Do you use a password manager?" screen.
  It still will **not** go back -- that one is deliberate and not fixed yet.
  But it should now **say so** instead of ignoring you.

### 8. FT-178 -- both of SANDY's drives

- **Do:** read the "YOUR SYSTEM AT A GLANCE" screen (position 12).
- **Good:** **two** lines under Storage -- `Drive 1:` about 238 GB SSD, and
  `Drive 2:` about 932 GB HDD.
- **BAD:** one drive. That is your finding 3, and finding 13 in ascii39. It was
  never a detection failure -- the second drive was being thrown away on
  purpose by one line of code.

### 9. FT-175b -- the offline scan is offered on a repeat run

**This is the most important functional test on the list.**

- **Do:** run Checkup as a repeat run (you will see "REMINDER: PRE-SCAN
  RECOMMENDED"). Press **Y** to continue.
- **Good:** you are then **asked** `Start the offline scan now? (Y/N)`.
- **BAD:** you are never asked. That is the old behaviour -- the repeat-run
  path described the scan and never offered it, which is your ascii39 finding
  38 and why it "was missing".
- **Either answer is fine for the test.** N is enough. What matters is that
  the question appears.

### 10. FT-186 -- the Settings wording

- **Do:** walk to the Device Encryption screens at the end (positions 28-31).
- **Good:** the instructions say **"Press the Windows key, type settings,
  press Enter"** -- not "click Settings (the gear)".
- **Good:** the encryption-check screen says to search **inside** Settings for
  device encryption.
- **Your findings 7 and 8.** The gear moves between Start layouts; typing does
  not.

### 11. FT-144 -- the recovery-key screen is shorter and no longer wrong

- **Do:** read "BEFORE YOU TURN IT ON -- YOUR RECOVERY KEY".
- **Good:** it explains what the key is, that without it the files are gone,
  and when to grab it.
- **Good:** it does **NOT** say Windows "will encrypt on a local account
  anyway" or "we have seen exactly that happen on a real PC". **You started
  that encryption yourself** -- the screen was claiming something that never
  happened.
- **Good:** no push toward a Microsoft account. Eleven lines, not nineteen.

### 12. No cloud by accident -- where your files land

- **Do:** finish the run, then find your log.
- **Good on SANDY:** `C:\Users\willi\OneDrive\GatewayGuard\Logs\`
  -- SANDY has personal OneDrive, so Checkup uses it and **asks nothing**.
- **Good:** the log's second line says `Log location: ... (OneDrive -- already
  set up on this PC)`.
- **Good:** you are **NOT** shown the OneDrive offer screen. That screen exists
  only for people who have no OneDrive at all.
- **BAD:** anything landing on the **Desktop**. The BitLocker recovery key used
  to be written there, and on any machine with OneDrive folder backup on, the
  Desktop **is** OneDrive -- so the key was going to the cloud by accident,
  not by decision. It now goes to the GatewayGuard folder with the log.

---

## WHAT I WOULD NOT BOTHER RE-REPORTING

- **Screens over 26 lines.** Ten are known and carried on purpose: 72, 50, 73,
  26, 27, 65, 60, 41, 30, 52.
- **The look-back wall** ("that earlier screen cannot be shown again"). Known,
  filed as FT-187, not fixed in this build.
- **Edge item 6 saying "phishing protection"** with an Unknown status. Known,
  FT-185, deliberately left out -- the replacement check has not been verified
  on a live machine and shipping an unverified registry read is what FT-162
  was about.

## IF IT CRASHES

**Say so first and say what you were doing.** ascii40 ran 58 minutes on SANDY
without crashing, so a crash in ascii41 is new and points at these twelve
changes rather than at the old input problem.

The log is written continuously -- **its last line is where it was.** Send the
whole file.
