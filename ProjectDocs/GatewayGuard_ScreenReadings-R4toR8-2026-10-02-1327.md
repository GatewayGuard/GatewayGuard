<!-- Dated: 2026-10-02 13:27 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Screen readings R4-R8 (Cloud's 10-02 list) -- from Bill's screenshots 36-43

- **Source:** `OneDrive\Personal\Pictures\Screenshots\` 36-43, 2026-10-02 12:31-13:24,
  CGDELL (Windows 11 Pro, account "Dad", Local Account) except 42 (SANDY).
- Companion: `GatewayGuard_ScreenReadings-R1toR3-2026-10-02-1207.md`.
- ***Measured*** = read off the screenshot or the registry. Quotes are exact on-screen text.

## R4 -- Protection history entry (screenshot 43)

Test file planted by Claude Code 12:23:52 (`Downloads\GG-R4-eicar-test.txt`, the standard
harmless EICAR string). The entry, expanded:
- Heading **"Threat quarantined"**, "10/2/2026 12:23 PM", severity **"Severe"**.
- "Detected: Virus:DOS/EICAR_Test_File"
- "Status: Quarantined"
- "Quarantined files are in a restricted area where they can't harm your device. They will be removed automatically."
- "Date: 10/2/2026 12:24 PM"
- "Details: This program is dangerous and replicates by infecting other files."
- "Affected items:" then "file: C:\Users\willi\Downloads\GG-R4-eicar-test.txt"
- Link **"Learn more"**; button **"Actions"** (a drop-down -- its choices not opened).
- Page: "Protection history", "View the latest protection actions and recommendations from Windows Security.", "All recent items", **"Filters"**.

## R5 -- Edge after the two policy values are removed (screenshots 36-38)

Claude Code deleted `StartupBoostEnabled` and `BackgroundModeEnabled` (both 0) under
`HKLM\SOFTWARE\Policies\Microsoft\Edge` at Bill's request (backup:
`Test_Results\R5-EdgePolicy-UNDO-CGDELL.reg`). Bill reopened Edge:
- **No briefcase / "managed by your organization" mark** on the page (Bill: "neither item there").
- edge://settings/system/manageSystem -- "System and performance / System":
  **"Startup boost"** "Opens Edge faster when you start your device." -- switch **On**, can be changed;
  **"Continue running background extensions and apps when Edge is closed"** -- switch **On**, can be changed.
- edge://settings/system -- "System and performance": quick links **Hardware Acceleration, Background mode,
  Startup boost, Proxy settings**; rows **System** ("Adjust system settings like background mode and
  graphics acceleration"), **Performance**.
- **For the guide's undo row for 13:** removing the two values gives the switches back to the user,
  and both came back **On** (Edge's default).

## R6 -- after a Checkup run (screenshots 39-41)

**Diagnostics & feedback (39, 40):**
- Banner: **"Some of these settings are managed by your organization."**
- Diagnostic data -- **"Sending required data"**; under it: **"Your organization only allows sending
  required diagnostic data to Microsoft."**
- "Send optional diagnostic data" -- switch shows **Off**. Bill: "diagnostics can be turned on".
- ***Measured cause:*** `HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection` **AllowTelemetry = 1**
  -- the policy value Checkup's item 12 writes. That is why Windows says "your organization".
- **For the guide:** after item 12, Settings says the computer is managed by "your organization". The
  undo for 12 must remove that policy value; the switch alone is not the undo.

**Taskbar (41):**
- Banner: **"Some of these settings are managed by your organization."**
- **"Widgets"** -- greyed out, **Off**, cannot be turned on.
- ***Measured cause:*** `HKLM\SOFTWARE\Policies\Microsoft\Dsh` **AllowNewsAndInterests = 0**
  -- Checkup's item 14.
- **For the guide's undo row for 14:** the Taskbar switch cannot undo it; the policy value must go.

## R7 -- Quick Assist (screenshot 42, SANDY)

- SANDY, "Help someone": signed in as the business account; heading **"Share this security code"**;
  "You'll stay on this screen until the person you're helping enters the code."; code **XY9W2E**,
  "Code expires in 09:43"; links **"Copy code"**, **"Give instructions"**; "Sign in with a different account".
- Bill also noted CGDELL's code **3T9164**.
- **Allow screen, CGDELL (screenshot 45, 13:44)** -- after entering SANDY's code:
  helper shown as **"William B."**; heading **"Allow screen sharing?"**;
  "If this person contacted you unexpectedly and asked to connect to your device, this might be a scam.";
  links "Privacy statement", "Terms of use"; a **tick box "I understand the security implications of
  sharing my screen"**; buttons **Allow** (**greyed out until the box is ticked**) and **Decline**.
- **For the guide:** the reader must **tick the box first** -- Allow cannot be clicked until then.
- Bill: the session connected and SANDY saw CGDELL's screen.
- **Bill, 2026-10-02: on SANDY (Windows 11 Home) Quick Assist had to be downloaded, installed and opened first** -- it was not ready to use. **For the guide:** the helper's PC may need Quick Assist installed (Microsoft Store) before the session; say so, with the steps. Not measured: whether CGDELL's was preinstalled or installed earlier.
- **During the session, CGDELL (screenshots 46-49, identical, 13:54):** a Quick Assist bar across the top: **"Screen sharing on"**, a chat button, a pause button, and a blue **"Leave"** button. R7 is complete.
- Also seen (screenshots 44, 44-CGDELL): choosing "Help someone" on both PCs gives both a code and they
  cannot connect -- the side being helped must type the code instead.

### R7 research -- does Quick Assist come with Windows? (Bill: "I believe quick assist came installed. but research it")

- ***Measured, CGDELL (Windows 11 Pro 25H2, build 26200):*** Quick Assist is a Store-style app,
  `MicrosoftCorporationII.QuickAssist` 2.0.56.0, and it is **provisioned in the Windows image**
  (`Get-AppxProvisionedPackage` lists it) -- so on CGDELL it **came with Windows**, as Bill thought.
  The old built-in program (`System32\quickassist.exe`) is gone.
- ***Measured, SANDY (Bill):*** it had to be downloaded and installed before it would open. Not measured
  why -- SANDY's Windows image may not include it, or it was removed earlier.
- *Sourced, Microsoft Learn* (learn.microsoft.com/windows/client-management/client-tools/quick-assist,
  updated 2025-09-30): Quick Assist is installed **from the Microsoft Store** ("Download the new version of
  Quick Assist by visiting the Microsoft Store ... When the installation is complete, Install changes to Open").
  Start it by typing *Quick Assist* in Windows search, **Ctrl + Windows + Q**, or Start > All apps > Quick Assist.
- *Sourced, same page:* **"The helper must have a Microsoft account. The sharer doesn't have to
  authenticate."** -- the person being helped needs no account; the helper does.
- *Sourced, same page:* the sharer sees "only an abbreviated version of the helper's name (first name, last
  initial)" -- matches screenshot 45 ("William B.").
- *Sourced, same page:* "Only allow a Helper to connect to your device if you initiated the interaction" --
  the scam warning the guide should repeat.
- *Sourced, support.microsoft.com "Solve PC problems remotely using Quick Assist":* Store path -- Start > All
  apps > Microsoft Store > search Quick Assist > Get or Install > Open.
- **For the guide:** "Quick Assist usually comes with Windows 11. If it does not open, install it free from the
  Microsoft Store: open Microsoft Store, search for Quick Assist, click Get." Plus: the helper needs a
  Microsoft account; you do not.

## R8 -- Widgets panel settings

- **Blocked:** Widgets cannot be turned on (R6, policy `AllowNewsAndInterests = 0`). Dashboards and
  Discover cannot be read until that value is removed.
