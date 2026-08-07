<!-- Dated: 2026-08-06 14:25 ET -->
# GatewayGuard M365 Migration Plan

- **Document Name:** GatewayGuard_M365MigrationPlan
- **Last Modified:** 2026-08-06 14:25 ET
- **Last Editor:** Claude.ai
- **Status:** Cumulative Master Document
- **Supersedes:** `M365-Business-Basic-Migration-Plan-2026-08-05.md` (retire that file --
  wrong naming convention, and titled "Basic" when the purchased plan is Standard)

## Change History Log

- **2026-08-06 14:25:** Renamed to project naming convention. Corrected plan name from
  Business Basic to **Business Standard** (actual purchase). Marked CGDELL business
  OneDrive setup **COMPLETE**. Restructured into six sequential phases with explicit
  stop-gates. Added domain-verification phase (TXT only, MX deferred until DigiCert
  cert issues).
- **2026-08-05:** Original migration plan drafted (9 parts).

---

## PURPOSE

Move the GatewayGuard build tree off a personal Microsoft account (free 5 GB tier)
onto LLC-controlled storage under the GatewayGuard LLC Microsoft 365 Business
Standard tenant.

**Why this matters:** the personal 5 GB tier already filled once and broke sync.
The university account that carries the current 1 TB can be deprovisioned without
notice now that the affiliation has ended. Neither is acceptable exposure for a
commercial product with a **September 1, 2026** launch.

---

## CURRENT STATE (as of 2026-08-06 14:25 ET)

| Item | Status |
|---|---|
| Personal OneDrive sync failure | **RESOLVED** -- space freed, both machines re-synced |
| Both machines on build ascii39, no divergence | **CONFIRMED** |
| M365 Business Standard tenant created | **DONE** -- `WilliamBurnsIII@GatewayGuardLLC.onmicrosoft.com` |
| Desktop Office installed and activated, CGDELL | **DONE** -- licensed to Microsoft 365 Apps for business |
| Business OneDrive sync client, CGDELL | **DONE** -- both folders present, tree intact |
| Business OneDrive sync client, SANDY3 | **NOT STARTED** -- Phase 1 |
| Tree migration | **NOT STARTED** -- Phase 3 |
| Hardcoded path fixes | **NOT STARTED** -- Phase 4 |
| Domain verification | **NOT STARTED** -- Phase 5 |
| University subscription cancellation | **NOT STARTED** -- Phase 6, must be last |

**Folder layout now on CGDELL:**

```
C:\Users\willi\OneDrive                        <- personal, holds GatewayGuard tree today
C:\Users\willi\OneDrive - GatewayGuard LLC     <- business, empty
```

---

## STANDING RULES FOR THIS MIGRATION

1. **One machine at a time.** Never move or modify the tree on both machines at once.
   Simultaneous writes produce conflict copies with machine names appended.
2. **Backups before any move.** Local copy plus USB copy, both verified openable.
3. **Wait for "Up to date."** Never start the next step while either OneDrive account
   is still syncing.
4. **No blind find-and-replace.** Path corrections get reviewed as a list before any
   file is edited.
5. **Cancel the university subscription last.** It is cheap insurance while the
   migration is in flight.
6. **MX record stays at Namecheap** until the DigiCert certificate is issued.

---

## PHASE 1 -- SANDY3 BUSINESS ONEDRIVE SETUP

1. On SANDY3, find the OneDrive **cloud icon** in the system tray -- right edge near
   the clock. Click the up-arrow if it is hidden.
2. Click the cloud icon, then the **gear** icon in the panel that opens, then
   **Settings**.
3. Click the **Account** tab.
4. Click **Add an account**.
5. Sign in as `WilliamBurnsIII@GatewayGuardLLC.onmicrosoft.com`.
6. Accept the default folder location.
7. When it offers folder choices, take everything -- the business drive is empty.
8. Confirm File Explorer's sidebar shows both `OneDrive` and
   `OneDrive - GatewayGuard LLC`.
9. Wait for both accounts to show **Up to date**.

**Warning:** this is the OneDrive client's Settings, reached from the tray icon.
It is **not** Windows Settings > Accounts. Adding an account in Windows Settings
creates a new Windows login profile, which is not wanted. The OneDrive dialog is
identifiable by its storage-usage display and its "Choose folders" button.

**STOP GATE:** do not proceed to Phase 2 until both folders exist on SANDY3 and
both accounts read Up to date.

---

## PHASE 2 -- BACKUPS

1. On CGDELL, confirm the personal OneDrive account reads **Up to date**.
2. Copy the entire GatewayGuard tree to `C:\GatewayGuard-Backup-2026-08-06\`.
   A real local copy, not a shortcut.
3. Copy the same tree to a USB drive.
4. Verify both copies open, and that `W11-SecurityHardening-v3-ascii39-*.ps1` is
   present in each.
5. Eject the USB and set it aside.

**STOP GATE:** do not proceed without both backups verified.

---

## PHASE 3 -- MOVE THE TREE (CGDELL ONLY)

**SANDY3 stays untouched throughout this phase.**

1. On SANDY3: tray cloud icon, then gear, then **Pause syncing** -- 8 hours.
2. On CGDELL, move the GatewayGuard tree from `C:\Users\willi\OneDrive\` to
   `C:\Users\willi\OneDrive - GatewayGuard LLC\`.
3. Watch the business OneDrive icon. Wait for **Up to date**. First upload of a
   full tree can take a while.
4. Sign into office.com as the business account and verify the tree is fully there.
5. Only after that confirms: on SANDY3, **resume syncing**.
6. Let SANDY3 pull the tree down into its business folder. Wait for **Up to date**.
7. Compare file counts on both machines. They must match.

**STOP GATE:** file counts must match on both machines before Phase 4.

---

## PHASE 4 -- FIX HARDCODED PATHS

1. Open Claude Code on CGDELL.
2. Grep `.ps1`, `.psm1`, `.bat`, and `.md` files for:
   - `\OneDrive\`
   - `$env:USERPROFILE`
   - `CGDELL`
   - `SANDY3`
3. **Review the full list before editing anything.**
4. Apply corrections and increment the build to **ascii40**.
5. Run the Appendix A pre-build audit and PSScriptAnalyzer. Both must pass.
6. Confirm `Run-GatewayGuard.bat` points at the correct current `.ps1` filename
   (CROSS-FILE SYNC rule).
7. Field-run ascii40 on CGDELL and upload the log before scoping anything further
   (UNRUN BUILD RULE).

**STOP GATE:** ascii40 field-run with uploaded log before any further build work.

---

## PHASE 5 -- DOMAIN VERIFICATION (MAIL-SAFE)

1. In the M365 admin center, begin adding `gatewayguard.co` and copy the **TXT**
   verification record.
2. At Namecheap, add **only** that TXT record.
3. Verify the domain in M365.

**Do not add the MX record.** The DigiCert OV code-signing certificate is approved
but still processing, and DigiCert sends issuance mail to `admin@gatewayguard.co`.
That address is delivered by Namecheap mail forwarding. Adding Microsoft's MX record
(`gatewayguard-co.mail.protection.outlook.com`, priority 0, host `@`) would break
forwarding and bounce the certificate mail.

**MX changeover happens after the certificate is in hand, and after launch.**

---

## PHASE 6 -- CANCEL UNIVERSITY SUBSCRIPTION (LAST)

Only after Phases 1 through 4 are confirmed working.

1. Confirm SANDY3 has desktop Office activated under the business account -- the
   university subscription currently governs Office activation there, and
   cancelling it deactivates Office on that machine.
2. Sign into the university Microsoft account.
3. Confirm nothing still needed lives on its 1 TB.
4. Cancel the $4.99/month subscription.

---

## VERIFICATION CHECKLIST

Work top to bottom. Every line must be checked before the migration counts as done.

- [ ] SANDY3 shows both OneDrive folders in File Explorer
- [ ] Both accounts read Up to date on both machines
- [ ] Local backup at `C:\GatewayGuard-Backup-2026-08-06\` verified openable
- [ ] USB backup verified openable
- [ ] ascii39 build present in both backups
- [ ] Tree moved on CGDELL, business account Up to date
- [ ] Tree confirmed at office.com under business account
- [ ] SANDY3 pulled tree down, Up to date
- [ ] File counts match on both machines
- [ ] Path grep list reviewed before edits
- [ ] ascii40 built, Appendix A audit passed, PSScriptAnalyzer clean
- [ ] Run-GatewayGuard.bat points at correct ascii40 filename
- [ ] ascii40 field-run on CGDELL, log uploaded
- [ ] TXT record added at Namecheap, domain verified in M365
- [ ] MX record NOT changed
- [ ] SANDY3 Office activated under business account
- [ ] University subscription cancelled

---

## OPEN ITEMS OUTSIDE THIS MIGRATION

- Word shortcut on CGDELL still opens web Word. Workaround: Windows+R, `winword`.
  Pin desktop Word to the taskbar and remove the old web shortcut.
- Verify GatewayGuard table formatting (Garamond 14 pt, black-filled headers,
  white bold text) renders correctly in the newly installed desktop Word before
  relying on it for deliverables.
