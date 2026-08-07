<!-- Dated: 2026-08-05 14:52 ET -->

# Microsoft 365 Business Basic — Purchase, Setup, and GatewayGuard Migration

**File:** M365-Business-Basic-Migration-Plan-2026-08-05.md
**Prepared for:** Panther (William F. Burns III), GatewayGuard LLC
**Machines:** Dell Latitude 5430 (CGDELL) and Lenovo IdeaPad (SANDY3)

---

## Why This Migration

GatewayGuard's build tree currently syncs between two machines through a **free 5 GB personal Microsoft account**. That account reached 98% capacity and sync stopped. It was cleared and both machines are now in agreement at build ascii39, but the underlying fragility remains: 5 GB will fill again, and a sync failure in the final weeks before the September 1, 2026 launch would be costly.

A separate 1 TB exists on a university subscription ($4.99/month, 0.1 GB used), but that account's affiliation has ended and it can be deprovisioned by the institution without notice. It also governs desktop Office activation on the IdeaPad.

**Target state:** storage and Office licensing under GatewayGuard LLC's own control.

---

## Plan Selected

**Microsoft 365 Business Basic — annual commitment**

| | **Business Basic** | Business Standard |
|---|---|---|
| Annual cost per user | **$84** | $168 |
| Monthly billing alternative | $8.40/mo | Higher than annual |
| OneDrive storage | **1 TB** | 1 TB |
| Web Word, Excel, PowerPoint | **Yes** | Yes |
| Desktop Word, Excel, PowerPoint | No | Yes |
| Custom domain email | **Yes** | Yes |
| Admin controls | **Yes** | Yes |

**Basic was chosen over Standard** because the machine where most GatewayGuard work is performed — CGDELL — has only ever run web-based Office, and that has been sufficient. Desktop Office currently exists on SANDY3 via the university subscription, but it is not central to the workflow. Builds are PowerShell and require no Office at all.

**Upgrade path:** If desktop Office proves necessary later, upgrading Basic to Standard is a plan change made in the Microsoft 365 admin center. It requires no migration, no data movement, and no new tenant. Starting on Basic and upgrading if needed costs nothing extra beyond the price difference from the date of upgrade.

**Consequence to accept:** Cancelling the university subscription (Part 8) removes desktop Word, Excel, and PowerPoint from SANDY3. Web versions remain available on all machines.

Purchase page: `https://www.microsoft.com/en-us/microsoft-365/business/microsoft-365-business-basic`

**Note on pricing:** A July 1, 2026 price increase raised Business Basic from $72 to $84 per user per year and Business Standard from $150 to $168. The widely cited "$7/user/month" figure refers to Business Basic on annual commitment at the pre-increase rate. Verify current pricing on the Microsoft page at time of purchase.

---

## Critical Sequencing Rule

**Do not cancel the university subscription until the new setup is fully verified.**

Cancelling early risks losing access mid-migration before the new tenant is confirmed working. One month of overlap costs approximately $5. Accept that cost.

Note that cancellation will also remove desktop Office from SANDY3 permanently. This is a known and accepted consequence of choosing Basic.

Cancellation is the **final** step, not the first.

---

## Decisions Required Before Starting

Two values are set during signup and **cannot be changed afterward**. Decide both before opening the purchase page.

**1. Tenant name** — becomes `[name].onmicrosoft.com` permanently.
Recommended: `gatewayguard`
Result: `gatewayguard.onmicrosoft.com`

**2. Admin username** — your identity within the tenant.
Recommended: `william`
Result: `william@gatewayguard.onmicrosoft.com`

If `gatewayguard` is unavailable, have a fallback ready rather than improvising at the prompt.

---

## Information to Have on Hand

- **EIN:** 42-3920627
- **Business name:** GatewayGuard LLC
- **Business address:** Brunswick, Maine (full street address)
- **Payment card**
- **Phone number** for verification
- **Alternate email** for account recovery — use the personal Microsoft account address

---

## Part 1 — Purchase Business Basic

**Step 1.** Go to `https://www.microsoft.com/en-us/microsoft-365/business/microsoft-365-business-basic`

**Step 2.** Select **Buy now**. Choose **annual commitment** billing, not month-to-month.

**Step 3.** Quantity: **1 user**.

**Step 4.** When prompted to sign in, select the option to **create a new account**. Do not sign in with the existing personal Microsoft account — business signup creates a separate work identity.

**Step 5.** Enter business details: GatewayGuard LLC, Brunswick address, EIN, phone.

**Step 6.** At the tenant name prompt, enter the value decided above. Confirm the full address shown matches expectation before continuing.

**Step 7.** Create the admin username and a strong password. **Store both in Proton Pass immediately** — this account controls everything that follows and has no easy recovery path if lost.

**Step 8.** Complete phone verification and payment.

**Step 9.** Record the renewal date. Annual commitment auto-renews.

---

## Part 2 — Verify the Tenant

**Step 1.** Sign in at `https://admin.microsoft.com` with the new admin account.

**Step 2.** Navigate to **Users → Active users**. Confirm your account appears.

**Step 3.** Click your account → **Licenses and apps**. Confirm:
- Microsoft 365 Business Basic is checked
- **OneDrive** appears and is enabled in the apps list beneath it
- Office web apps appear and are enabled

**Step 4.** Go to `https://www.office.com`, sign in with the new account, click **OneDrive**. OneDrive provisions on first access — this click is required.

**Step 5.** Confirm storage reads **1 TB**. Do not proceed until it does. If it does not appear within 30 minutes, return to Step 3 and re-check license assignment.

---

## Part 3 — Email Setup

The tenant provides email at `william@gatewayguard.onmicrosoft.com` immediately. This works but is not a professional-looking address.

**Custom domain is deferred.** The `gatewayguard.com` domain is not currently available — it expires January 4, 2027 and is under a separate acquisition watch. Attaching a custom domain can be done at any time later via **admin.microsoft.com → Settings → Domains → Add domain**, without disruption to the account.

**Step 1.** Access email at `https://outlook.office.com` with the new account.

**Step 2.** Decide whether to use this mailbox operationally now or defer until a real domain is attached. Existing correspondence runs through `william.wfbiii@gmail.com` — there is no urgency to switch.

**Step 3.** If deferring, no further action. The mailbox exists and can be adopted later.

---

## Part 4 — Verify Web App Access

Business Basic provides web and mobile versions of Office. There is no desktop installation step.

**Step 1.** Sign in at `https://www.office.com` with the new business account.

**Step 2.** Open **Word** from the app list. Confirm it opens in a browser tab and a new blank document can be created.

**Step 3.** Repeat for **Excel** and **PowerPoint**.

**Step 4.** Create a test document. Apply Garamond 14pt and insert a bordered table to confirm the formatting controls needed for GatewayGuard documentation are reachable in the web version.

**Step 5.** Save the test document to the new OneDrive and confirm it appears.

### Note on SANDY3 desktop Office

Desktop Word, Excel, and PowerPoint currently run on SANDY3 under the university subscription. **These will stop working when that subscription is cancelled in Part 8.** Web versions remain available on all three machines.

If, on reflection, desktop Office turns out to be needed, upgrade to Business Standard in **admin.microsoft.com → Billing → Your products → Upgrade** before completing Part 8. The upgrade is a billing change only and does not affect any other step in this plan.

---

## Part 5 — Add the New OneDrive Account

Perform on **CGDELL first**, then SANDY3.

**Step 1.** Right-click the OneDrive cloud icon in the system tray.

**Step 2.** Select **Settings** → **Account** tab.

**Step 3.** Select **Add an account**.

**Step 4.** Sign in with the new business account.

**Step 5.** Accept the default folder location when prompted. A second folder appears in File Explorer named similar to `OneDrive - GatewayGuard LLC`, alongside the existing personal `OneDrive` folder.

**Step 6.** Confirm both accounts now appear in the OneDrive settings Account tab.

**Step 7.** Repeat Steps 1–6 on SANDY3.

**Do not remove the personal account yet.** Both run in parallel until migration is verified.

---

## Part 6 — Migrate the GatewayGuard Tree

**Sequencing is critical. Move on one machine only. Let it fully upload. Then let the second machine pull it down. Never move simultaneously on both — that produces conflict copies.**

### Pre-migration backup

**Step 1.** On CGDELL, copy the entire GatewayGuard tree to a local non-OneDrive path:

```
C:\GatewayGuard-Backup-2026-08-05\
```

**Step 2.** Copy the same tree to an external USB drive.

**Step 3.** Verify both copies open correctly. Confirm build ascii39 is present in each.

### Migration

**Step 4.** On **CGDELL only**, move the GatewayGuard folder from the personal OneDrive path into the new business OneDrive folder.

**Step 5.** Watch the OneDrive tray icon. Wait for upload to complete — green check, no pending count. **This may take some time. Do not interrupt it, and do not touch SANDY3 during this step.**

**Step 6.** Verify on the web: sign in at `office.com` with the business account, open OneDrive, confirm the full tree is present and file count looks correct.

**Step 7.** On **SANDY3**, wait for the business OneDrive folder to populate. Confirm the tree arrives complete.

**Step 8.** Confirm build ascii39 is present and identical on both machines.

**Step 9.** Create a test file on SANDY3. Confirm it appears on CGDELL. Then delete it. This verifies two-way sync.

---

## Part 7 — Update Hardcoded Paths

Every reference to the old OneDrive path will now be wrong. This is the step most likely to break the launcher if skipped.

**Perform on CGDELL, where Claude Code is installed** (`C:\Users\willi\.local\bin\claude.exe`). Run on one machine only — the tree syncs to the other.

**Step 1.** Confirm the Windows username on the machine:

```
echo %USERNAME%
```

**Step 2.** Open Claude Code in the GatewayGuard project directory.

**Step 3.** Paste this prompt:

```
Search this project tree for every hardcoded OneDrive path
in .ps1, .psm1, .bat, and .md files. For each hit, show me:
- the file
- the line number
- the current path
- what the new path would be

Also look for paths assembled from variables, such as
$env:USERPROFILE + "\OneDrive\...", and any references to
machine names CGDELL or SANDY3.

Do not change anything yet. I'll confirm the new root path
after I see the full list.
```

**Step 4.** Review the complete list before authorizing any edit. Do not permit a blind find-and-replace across the build tree.

**Step 5.** Provide the new root path and authorize the edits.

**Step 6.** Pay particular attention to any launcher file referencing a build script by exact filename — per standing project rules, when a referenced path changes, the reference must be updated in the same pass.

**Step 7.** Run a full build to confirm nothing broke. Increment to **ascii40** — build numbers always increment and are never reused.

---

## Part 8 — Cancel the University Subscription

**Only after Parts 1 through 7 are complete and verified.**

**Step 1.** Confirm all of the following are true:
- Web Office apps work from the business account
- The GatewayGuard tree is fully present in business OneDrive
- Both machines sync two-way through the business account
- A full build completes successfully from the new paths
- Local and USB backups exist

**Step 2.** Sign in at `https://account.microsoft.com/services` using the **university** account, in a private browser window.

**Step 3.** Locate the Microsoft 365 subscription → **Manage** → **Cancel subscription**.

**Step 4.** Note the end-of-access date. Access typically continues to the end of the paid period.

**Step 5.** Before that date, review the university OneDrive (0.1 GB used) for anything worth retaining. Download it if so.

**Step 6.** Contact university IT to request the account be closed, if it is not already scheduled for deprovisioning.

---

## Part 9 — Optional Cleanup

**Personal OneDrive account.** Currently at ~30% of 5 GB and functioning. It can remain as a personal-use account. If any GatewayGuard remnants persist there, remove them after confirming the business copy is authoritative.

**Unlinking is not required** and is not recommended while any personal files still depend on it.

---

## Verification Checklist

Complete before considering the migration done.

- [ ] Business Basic purchased, annual commitment, renewal date recorded
- [ ] Tenant name and admin credentials stored in Proton Pass
- [ ] admin.microsoft.com shows license assigned with OneDrive and Office enabled
- [ ] OneDrive web shows 1 TB
- [ ] Web Word, Excel, and PowerPoint open from business account
- [ ] Garamond 14pt and bordered table formatting verified in web Word
- [ ] Accepted that desktop Office on SANDY3 ends at cancellation
- [ ] Business OneDrive account added on both machines
- [ ] Local backup created at `C:\GatewayGuard-Backup-2026-08-05\`
- [ ] USB backup created and verified
- [ ] Tree migrated, upload completed, verified on web
- [ ] Tree present and identical on both machines at ascii39
- [ ] Two-way sync tested
- [ ] Hardcoded paths found and updated via Claude Code
- [ ] Launcher-to-script filename references checked and updated
- [ ] Full build completed successfully at ascii40
- [ ] University subscription cancelled
- [ ] University OneDrive reviewed and cleared

---

## Risks and Notes

**Timing.** This is being performed under four weeks before the September 1, 2026 launch. Allow a full working session rather than fitting it between build tasks. The migration itself is straightforward; the path updates in Part 7 are where unexpected time is usually spent.

**Do not skip the backup steps.** Parts 6 and 8 both involve operations that are difficult to reverse.

**Custom domain.** Business email remains at `.onmicrosoft.com` until `gatewayguard.com` is acquired. Domain status is due for review in December 2026, with expiration January 4, 2027. Attaching a domain later requires no rework of this setup.

**Renewal.** Annual commitment auto-renews at $168. Calendar the renewal date.
