<!-- Dated: 2026-08-06 17:27 ET -->
# GatewayGuard M365 Migration Plan

- **Document Name:** GatewayGuard_M365MigrationPlan
- **Last Modified:** 2026-08-06 17:27 ET
- **Last Editor:** Claude.ai
- **Status:** Cumulative Master Document
- **Supersedes:** `GatewayGuard_M365MigrationPlan-2026-08-06-1425.md` and
  `M365-Business-Basic-Migration-Plan-2026-08-05.md` -- retire both

## Change History Log

- **2026-08-06 17:27:** Added `CLAUDE.md` as required reading before Phase 4B, and
  embedded its **never-rename identifier list** into that step -- `C:\GatewayGuard\`,
  `Run-GatewayGuard.bat`, the MachineID hash salt, and the Task Scheduler task names
  will all surface in the path grep and none of them may be changed.
  `C:\GatewayGuard\` is the specific trap: it is a real hardcoded path, but it is the
  customer-machine path and is unaffected by the dev tree moving.
- **2026-08-06 17:27:** **Corrected Phase 4 -- it instructed an increment to
  ascii40, which violates the UNRUN BUILD RULE, because ascii39 has never had
  a field run.** Split the path work into a read-only grep (Phase 4A) that can
  run immediately and an edit/build step (Phase 4C) gated behind an ascii39
  field log. Added Phase 0 -- run the grep and the ascii39 field test **before**
  the tree moves, so a post-move defect cannot be confused with a path problem.
  Added the Files On-Demand precondition and the backup-path note to Phase 3.
  Added the "add your own DNS records" warning to Phase 5. Scoped SANDY (the
  HP) explicitly out, with the one caveat that applies when it next powers on.
  Corrected the prior file's timestamp: it was stamped 14:25 when the clock
  had not yet reached it.
- **2026-08-06 14:25:** *(prior file)* Renamed to project naming convention.
  Corrected plan name from Business Basic to Business Standard. Marked CGDELL
  business OneDrive setup COMPLETE. Restructured into six phases with stop-gates.
  Added domain-verification phase (TXT only, MX deferred).
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

## CURRENT STATE (as of 2026-08-06 17:27 ET)

| Item | Status |
|---|---|
| Personal OneDrive sync failure | **RESOLVED** -- space freed, both machines re-synced |
| Both migration machines on build ascii39, no divergence | **CONFIRMED** |
| **ascii39 field run with uploaded log** | **NOT DONE** -- gates Phase 4C |
| M365 Business Standard tenant created | **DONE** -- `WilliamBurnsIII@GatewayGuardLLC.onmicrosoft.com` |
| Desktop Office installed and activated, CGDELL | **DONE** -- Microsoft 365 Apps for business |
| Business OneDrive sync client, CGDELL | **DONE** -- both folders present, tree intact |
| Business OneDrive sync client, Sandy3 | **IN PROGRESS** -- Phase 1 |
| Hardcoded path grep (read-only) | **NOT STARTED** -- Phase 0, no blockers |
| Tree migration | **NOT STARTED** -- Phase 3 |
| Hardcoded path fixes | **NOT STARTED** -- Phase 4C, gated |
| Domain verification | **NOT STARTED** -- Phase 5 |
| University subscription cancellation | **NOT STARTED** -- Phase 6, must be last |

**Machines in scope:** CGDELL and **Sandy3** (Lenovo IdeaPad).

**SANDY (the HP Notebook) is out of scope.** It is shut down and holds no recent
files. It needs no phase. **One caveat:** when it is next powered on, if it syncs
the personal OneDrive account it will process the tree's removal from that account.
Let it finish syncing before touching anything on it. The GatewayGuard folder
disappearing from personal OneDrive there is Phase 3 working correctly, not data
loss -- the tree lives in the business account.

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
7. **Test before you move, not after.** A defect found after the tree relocates is
   ambiguous -- real bug, or path breakage? Establish the known-good baseline first.
   This is what Phase 0 exists for.

---

## PHASE 0 -- BASELINE BEFORE ANYTHING MOVES (NEW)

Both steps are non-destructive and can start immediately. Neither depends on
Phase 1.

### 0A. Read-only path grep on CGDELL

Phase 4 has always assumed hardcoded paths exist. **Nobody has checked.** If the
Checkup script uses `$PSScriptRoot` and relative paths throughout -- which is how
it should be written -- then relocating the tree changes nothing in the code and
the path-fix work is empty. Find out before planning around it.

In Claude Code on CGDELL, grep `.ps1`, `.psm1`, `.bat`, and `.md` for:

- `\OneDrive\`
- `$env:USERPROFILE`
- `C:\Users\`
- `CGDELL`
- `SANDY3`

**Read only. Change nothing.** Produce the hit list and review it.

### 0B. ascii39 field run -- on SANDY, not CGDELL

Required before launch regardless of this migration, and required by the UNRUN
BUILD RULE before any ascii40 exists.

**It belongs on SANDY.** SANDY is Home edition, local account, and **not
encrypted** -- the only machine in the fleet that can reach item 8's
Home-unencrypted-enable branch (FT-110) and the FT-144 danger case. CGDELL is
fully encrypted and cannot reach that branch at all.

Before powering SANDY on:

- Plug in the **TP-Link Archer T2U Nano** USB adapter. The internal RTL8821CE
  Wi-Fi is a confirmed hardware failure -- no network without it.
- If it comes up with no internet, check **Malwarebytes filtering is set to
  none** and Windows Firewall is at defaults before suspecting the adapter.
  MB blocking DHCP was the cause last time.

Copy the ascii39 `.ps1` and `Run-GatewayGuard.bat` pair to SANDY by USB.

**Exercise item 8 all the way through screens 62, 79, 80, 81, 82 and the decline
flow (58, 68) -- then stop before encryption actually starts.** That yields the
log and validates every screen FT-156 rebuilt, while leaving SANDY unencrypted
and reusable. Actually letting encryption run is a separate, one-way decision
that permanently spends the fleet's only unencrypted machine. Do not spend it to
satisfy this phase.

Upload the log.

**STOP GATE for Phase 4C only.** Phases 1 through 3 may proceed in parallel with
Phase 0.

---

## PHASE 1 -- Sandy3 BUSINESS ONEDRIVE SETUP

1. On Sandy3, find the OneDrive **cloud icon** in the system tray -- right edge near
   the clock. Click the up-arrow if it is hidden.
2. Click the cloud icon, then the **gear** icon in the panel that opens, then
   **Settings**.
3. Click the **Account** tab.
4. Click **Add an account**.
5. Sign in as `WilliamBurnsIII@GatewayGuardLLC.onmicrosoft.com`.
6. Accept the default folder location. Never point it at the existing personal
   OneDrive folder -- two accounts must not share one folder.
7. When it offers folder choices, take everything -- the business drive is empty.
8. Confirm File Explorer's sidebar shows both `OneDrive` and
   `OneDrive - GatewayGuard LLC` as two separate entries.
9. Wait for both accounts to show **Up to date**.

**Warning:** this is the OneDrive client's Settings, reached from the tray icon.
It is **not** Windows Settings > Accounts. Adding an account in Windows Settings
creates a new Windows login profile, which is not wanted. The OneDrive dialog is
identifiable by its storage-usage display and its "Choose folders" button.

**Disk space:** Sandy3 measured 290 GB free on 2026-08-06. Not a constraint.

**STOP GATE:** do not proceed to Phase 2 until both folders exist on Sandy3 and
both accounts read Up to date.

---

## PHASE 2 -- BACKUPS

1. On CGDELL, confirm the personal OneDrive account reads **Up to date**.
2. Copy the entire GatewayGuard tree to a backup folder. A real local copy, not a
   shortcut.
   - `C:\GatewayGuard-Backup-2026-08-06\` works but prompts for admin, since
     Windows 11 requires elevation to create a folder at the root of C:.
   - `C:\Users\willi\GatewayGuard-Backup-2026-08-06\` avoids the prompt and is
     still outside both OneDrive folders, which is the only thing that matters.
     Either is acceptable.
3. Copy the same tree to a USB drive.
4. Verify both copies open, and that `W11-SecurityHardening-v3-ascii39-*.ps1` is
   present in each.
5. Eject the USB and set it aside.

**STOP GATE:** do not proceed without both backups verified.

---

## PHASE 3 -- MOVE THE TREE (CGDELL ONLY)

**Sandy3 stays untouched throughout this phase.**

**Precondition -- Files On-Demand.** If any of the tree is cloud-only (blue cloud
icon rather than a green check), moving it between two synced folders can move a
placeholder or stall mid-download. **Basis: inferred -- not tested on your
machines.** Before step 2, right-click the GatewayGuard tree in personal OneDrive
and choose **Always keep on this device**. Wait for solid green checks throughout,
then move.

**What this move actually is.** Moving between two separately synced accounts is
not a server-side move. It is a delete from the personal cloud and a full re-upload
to the business cloud. **Basis: inferred.** Expect a slow first sync, and expect the
personal cloud copy to land in that account's recycle bin. **Do not empty the
personal OneDrive recycle bin until this phase's stop gate passes.**

1. On Sandy3: tray cloud icon, then gear, then **Pause syncing** -- 8 hours.
2. On CGDELL, move the GatewayGuard tree from `C:\Users\willi\OneDrive\` to
   `C:\Users\willi\OneDrive - GatewayGuard LLC\`.
3. Watch the business OneDrive icon. Wait for **Up to date**. First upload of a
   full tree can take a while.
4. Sign into office.com as the business account and verify the tree is fully there.
5. Only after that confirms: on Sandy3, **resume syncing**.
6. Let Sandy3 pull the tree down into its business folder. Wait for **Up to date**.
7. Compare file counts on both machines. They must match.

**STOP GATE:** file counts must match on both machines before Phase 4.

---

## PHASE 4 -- PATH CORRECTIONS

**Phase 4A -- the grep -- is Phase 0A and may already be done.** If it found
nothing, Phases 4B and 4C are empty and the migration is finished at Phase 5.

### 4B. Review

**Read `CLAUDE.md` before reviewing the hit list.** Its never-rename identifier
list governs this step directly.

Review the full hit list before editing anything. Distinguish:

- **Real hardcoded paths** that break when the tree moves -- must fix
- **Machine names in comments, logs, or test notes** -- usually harmless, leave
- **`$env:USERPROFILE`** -- often correct as written; the profile path did not change
- **Identifiers that must NEVER be changed** -- see below

#### NEVER-RENAME LIST -- these will appear in the grep results

Per `CLAUDE.md`, the following are **identifiers and recovery points, not
prose.** They are not affected by the tree moving and must survive this
migration byte-for-byte:

| Identifier | Why it cannot change |
|---|---|
| `C:\GatewayGuard\` | Fixed install/log path on customer machines -- not the dev tree, and not under OneDrive |
| `Run-GatewayGuard.bat` | Launcher filename, referenced by the paired .ps1 (CROSS-FILE SYNC) |
| `"GatewayGuard\|"` | MachineID hash salt -- changing it changes every machine's ID |
| `GatewayGuard - Quarterly...` | Task Scheduler task name -- renaming orphans the existing task |
| `GatewayGuard - Monthly...` | Task Scheduler task name -- same |
| `gatewayguard.co` | Live domain |
| GatewayGuard LLC | Legal entity name |

**`C:\GatewayGuard\` is the trap in this phase.** It looks like a hardcoded path
and it is one -- but it is the *customer-machine* path, deliberately fixed, and
has nothing to do with where the dev tree lives. Moving the tree does not affect
it. **Do not "correct" it.**

**A blanket find-and-replace on "GatewayGuard" would corrupt every machine's ID
and orphan every scheduled task on every customer machine.** The migration
standing rule "no blind find-and-replace" exists for exactly this.

### 4C. Edit and build -- GATED

**Do not increment to ascii40 until Phase 0B has produced an ascii39 field log.**
The UNRUN BUILD RULE is not waivable for a migration. If path fixes are needed
before that log exists, the options are: run Phase 0B first, or patch the ascii39
file in place without incrementing the build number. **Do not create an ascii40
that has an unrun ascii39 behind it.**

Once ascii39 has a field log:

1. Apply the reviewed corrections and increment to **ascii40**.
2. Run the Appendix A pre-build audit and PSScriptAnalyzer. Both must pass.
3. Confirm `Run-GatewayGuard.bat` points at the correct current `.ps1` filename
   (CROSS-FILE SYNC rule).
4. Field-run ascii40 and upload the log before scoping anything further.

**STOP GATE:** ascii40 field-run with uploaded log before any further build work.

---

## PHASE 5 -- DOMAIN VERIFICATION (MAIL-SAFE)

1. In the M365 admin center, begin adding `gatewayguard.co` and copy the **TXT**
   verification record.
2. At Namecheap, add **only** that TXT record.
3. Verify the domain in M365.

**Choose the manual DNS path.** Microsoft will offer to add all DNS records for
you, or to "connect the domain automatically." **Do not accept either.** Look for
**More options** and choose to **add your own DNS records**. The automatic path
writes the MX record, which is exactly what must not happen yet.

**Do not add the MX record.** The DigiCert OV code-signing certificate is approved
but still processing, and DigiCert sends issuance mail to `admin@gatewayguard.co`.
That address is delivered by Namecheap mail forwarding. Adding Microsoft's MX record
(`gatewayguard-co.mail.protection.outlook.com`, priority 0, host `@`) would break
forwarding and bounce the certificate mail.

**MX changeover happens after the certificate is in hand, and after launch.**

---

## PHASE 6 -- CANCEL UNIVERSITY SUBSCRIPTION (LAST)

Only after Phases 1 through 4 are confirmed working.

1. Confirm Sandy3 has desktop Office activated under the business account -- the
   university subscription currently governs Office activation there, and
   cancelling it deactivates Office on that machine.
2. Sign into the university Microsoft account.
3. Confirm nothing still needed lives on its 1 TB.
4. Cancel the $4.99/month subscription.

---

## VERIFICATION CHECKLIST

Work top to bottom. Every line must be checked before the migration counts as done.

- [ ] Path grep run on CGDELL, hit list produced, nothing edited yet
- [ ] ascii39 field-run on SANDY, item 8 screens exercised, encryption NOT started
- [ ] ascii39 log uploaded
- [ ] Sandy3 shows both OneDrive folders in File Explorer
- [ ] Both accounts read Up to date on both machines
- [ ] Backup folder verified openable
- [ ] USB backup verified openable
- [ ] ascii39 build present in both backups
- [ ] Tree set to Always keep on this device before the move
- [ ] Tree moved on CGDELL, business account Up to date
- [ ] Tree confirmed at office.com under business account
- [ ] Sandy3 pulled tree down, Up to date
- [ ] File counts match on both machines
- [ ] Personal OneDrive recycle bin NOT emptied until counts matched
- [ ] Path hit list reviewed before any edit
- [ ] ascii40 built ONLY after ascii39 log exists
- [ ] Appendix A audit passed, PSScriptAnalyzer clean
- [ ] Run-GatewayGuard.bat points at correct ascii40 filename
- [ ] ascii40 field-run, log uploaded
- [ ] TXT record added at Namecheap via manual DNS path, domain verified in M365
- [ ] MX record NOT changed
- [ ] Sandy3 Office activated under business account
- [ ] University subscription cancelled

---

## OPEN ITEMS OUTSIDE THIS MIGRATION

- Word shortcut on CGDELL still opens web Word. Workaround: Windows+R, `winword`.
  Pin desktop Word to the taskbar and remove the old web shortcut.
- Verify GatewayGuard table formatting (Garamond 14 pt, black-filled headers,
  white bold text) renders correctly in the newly installed desktop Word before
  relying on it for deliverables.
- SANDY (HP) encryption state is the fleet's only unencrypted slot. Decide
  deliberately when -- or if -- to spend it by letting encryption complete there.
