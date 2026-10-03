<!-- Dated: 2026-08-19 08:18 ET -->
# Turning on Hibernate -- Windows 11

- **Document Name:** GatewayGuard_HibernateInstructions
- **Last Modified:** 2026-08-19 08:18 ET
- **Last Editor:** Claude Cloud (claude.ai)
- **Status:** Working instructions -- not a governing document
- **Applies to:** SANDY (HP Notebook 17-by1955cl, Win 11 Home) and Sandy3
  (Lenovo IdeaPad, Win 11 Home). Same procedure on both.
- **Purpose:** enable hibernation and add the Hibernate entry to the Start
  menu power button.

---

## BEFORE YOU START

- Run these steps **on the machine itself**, not remotely.
- You must be signed in as an **administrator**.
- Parts 1 and 2 are both required. Part 1 turns the feature on. Part 2 adds
  the button to the menu. Doing only Part 1 leaves hibernation enabled but
  invisible.

---

## PART 1 -- TURN HIBERNATION ON

1. Press the **Windows key**.
2. Type `powershell`.
3. In the results list, right-click **Windows PowerShell** and choose
   **Run as administrator**.
4. A User Account Control box appears.
   - If it asks **Yes / No**: click **Yes**, and continue to step 5.
   - If it asks for a **username and password**: you are signed in as a
     standard user. Stop. Sign out, sign in as an administrator, and start
     again at step 1.
5. In the blue PowerShell window, type this and press **Enter**:

   ```
   powercfg /hibernate on
   ```

6. Nothing prints if it worked. Silence here is success, not failure.
7. To confirm, type this and press **Enter**:

   ```
   powercfg /a
   ```

8. Read the output.
   - If **Hibernate** appears under *The following sleep states are available
     on this system*: it worked. Continue to step 10.
   - If **Hibernate** appears under *The following sleep states are not
     available on this system*: it did not work. The reason is printed beside
     it. Stop here, copy the whole output, and get help before going further.
9. Optional -- see how much disk space the hibernation file uses:

   ```
   cmd /c dir /a:h C:\hiberfil.sys
   ```

   The size is shown in bytes. *(Inferred, not measured: on an 8 GB machine
   expect roughly 3-4 GB. The command gives the real figure -- use that.)*
10. Type `exit` and press **Enter** to close PowerShell.

---

## PART 2 -- ADD HIBERNATE TO THE POWER MENU

1. Press the **Windows key**.
2. Type `control panel` and press **Enter**.
3. Set **View by** (top right of the window) to **Category** if it is not
   already set that way.
4. Click **Hardware and Sound**.
5. Click **Power Options**.
6. In the left-hand column, click **Choose what the power buttons do**.
7. Near the top of the page, click **Change settings that are currently
   unavailable**. If a User Account Control box appears, click **Yes**.

   The greyed-out checkboxes at the bottom of the page become editable. This
   step is easy to miss and nothing below will work until it is done.
8. Under **Shutdown settings**, tick the box marked **Hibernate**.
9. Optional, on the same screen -- **Turn on fast startup (recommended)**:
   - **Leave it ticked:** "Shut down" will not fully shut the machine down.
     It saves part of memory to disk so the next start is faster.
   - **Untick it:** "Shut down" fully shuts the machine down.

   Hibernate works either way. Turning hibernation on in Part 1 also switches
   Fast Startup on, so if you do not want Fast Startup you must untick it here.
10. Click **Save changes**. The window closes.

---

## PART 3 -- VERIFY

1. Click **Start**.
2. Click the **power icon**.
3. **Hibernate** should now be listed alongside Sleep, Shut down and Restart.

**If Hibernate is not listed:** return to Part 2 step 7. The **Change settings
that are currently unavailable** link must be clicked before the Hibernate
checkbox will accept a tick. This is the most common reason for the entry not
appearing.

---

## OPTIONAL -- HIBERNATE AUTOMATICALLY

To have the machine hibernate on its own after a period of inactivity:

1. Control Panel -> Hardware and Sound -> **Power Options**.
2. Beside your selected plan, click **Change plan settings**.
3. Click **Change advanced power settings**.
4. Expand **Sleep**, then expand **Hibernate after**.
5. Set a value in minutes for **On battery** and for **Plugged in**.
   - Setting a number: the machine hibernates after that many idle minutes.
   - Setting **Never** (or 0): the machine never hibernates on its own; you
     must choose Hibernate from the power menu each time.
6. Click **OK**.

---

## NOTES

- **Sandy3 has BitLocker active.** Hibernation writes the contents of memory
  to `hiberfil.sys` on the encrypted volume, so it stays encrypted at rest.
  There is no conflict. If firmware or boot configuration changes between
  hibernating and resuming, BitLocker may ask for the recovery key on resume
  -- the same as it would on any boot. Have the recovery key available before
  changing boot-related settings.
- **Hibernate versus Sleep.** Sleep keeps memory powered and drains the
  battery; the machine wakes in seconds. Hibernate writes memory to disk and
  uses no power at all; the machine takes longer to resume but can sit for
  weeks without losing state.
- **To reverse everything in this document,** run the following in an
  administrator PowerShell window. This turns hibernation off, deletes
  `hiberfil.sys`, reclaims the disk space, removes Hibernate from the power
  menu, and disables Fast Startup:

  ```
  powercfg /hibernate off
  ```

---

## BASIS OF CLAIMS

- Steps and command syntax: **sourced** -- documented `powercfg` and Windows
  11 Power Options behavior.
- Hibernation file size on an 8 GB machine: **inferred**. Measure it with the
  command in Part 1 step 9 rather than relying on the estimate.
- Machine specifications for SANDY and Sandy3: **from project records**, not
  measured in this session.
