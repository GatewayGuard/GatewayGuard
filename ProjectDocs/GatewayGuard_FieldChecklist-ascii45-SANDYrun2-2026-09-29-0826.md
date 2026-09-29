<!-- Dated: 2026-09-29 08:26 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# ascii45 -- SANDY run 2: what to watch for

This covers the fixes made after run 1 (commits `32ee2d2` and `b3e7e58`, 2026-09-28).
Run it the same way as run 1: `Run-GatewayGuard.bat`, as administrator.
Tick each line, or write what you saw instead. Save your notes to `Test_Results\` as before.

## Start

- [ ] **Screen 9:** press **I**, then one key. You should be back on screen 9, and **one** key should move you on, not two. (FT-302)
- [ ] **Ctrl+C with nothing highlighted:** Checkup should ask before closing, not close.
- [ ] **Highlight text with the mouse, then press Ctrl+C:** it should copy, and Checkup keeps running.
- [ ] **Screen 14b:** Malwarebytes is named (not blank), and is described as installed but not in charge. (FT-307)
- [ ] **Screen 15:** it must NOT say Malwarebytes is your antivirus. (FT-303)
- [ ] **Unwanted-app blocking is checked**, with its own screen. (FT-303)
- [ ] **Virus definitions are checked.** (FT-303)
- [ ] **Windows Update line:** it says it "can take a while". (Note 2)
- [ ] **Offline scan:** the bottom line says "Awaiting restart -- this can take several minutes". Screen 17 tells you to sign in after the restart, run Checkup and choose **R**. (Notes 4b, 5)
- [ ] **After the restart:**
  - 17a gives the route by hand: Virus & threat protection -> Protection history. (Note 6)
  - **The full scan is offered.** (FT-303)

## Middle screens

- [ ] Screens 20, 22, 24 and 25 no longer say "nothing has been changed". (FT-304)
- [ ] Screen 20 has the columns "Now" and "Recommended".
- [ ] Screen 24 says each item is explained when you reach it.
- [ ] **Checklist (screens 26/27):**
  - The status column sits right after the setting names, with no big gap. (FT-305)
  - Item 6's status reads "Blocked by Tamper Protection -- check by hand; Checkup will show you how".
- [ ] **After the review, the screen clears** before items are applied. No output appended underneath. (Note 13)

## Items

- [ ] **Item 6:**
  - Starts with "Do this:", and you press Enter once.
  - No repeated phishing line, and no "enable manually".
  - Says "(you may need to click Turn on)" and "Checkup recommends you leave it off".
- [ ] **Item 14 (Widgets):**
  - No "unauthorized operation" error.
  - Gives you the steps to turn Widgets off yourself.
  - Never says it was disabled. (FT-283)

## End

- [ ] **Screen 33:** shows counts, for example "done: N  need you: N  could not be done: N", or "ALL SELECTED ITEMS DONE". (FT-306)
- [ ] **Screens 34 and 35:**
  - 34 lists what changed.
  - 35 shows each thing left for you, one per screen.
  - Anything missing? (Note 18)
- [ ] **In the log, afterwards:**
  - No `SILENT ERROR` about the Malwarebytes reminder task. (FT-308)
  - No "fault at" lines; you should see "Not set -- normal on a home PC" instead. (FT-309)
