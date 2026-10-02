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
- **Still not captured:** the **Allow** screen and the **Leave** button on the side being helped. R7 stays open.

## R8 -- Widgets panel settings

- **Blocked:** Widgets cannot be turned on (R6, policy `AllowNewsAndInterests = 0`). Dashboards and
  Discover cannot be read until that value is removed.
