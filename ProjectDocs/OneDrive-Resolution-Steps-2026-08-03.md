<!-- Dated: 2026-08-03 22:51 ET -->

# OneDrive Sync Failure — Resolution Steps

**File:** OneDrive-Resolution-Steps-2026-08-03.md
**Prepared for:** Panther (William F. Burns III)
**Machine affected:** Lenovo IdeaPad (primary dev machine)

---

## Situation Summary

OneDrive reports storage full and stops syncing. Cause identified: the OneDrive sync client is signed into a **personal Microsoft account** on the free 5 GB tier. The 1 TB entitlement belongs to a **university account** whose affiliation has ended. A separate monthly charge exists that has not yet been located.

**Confirmed:** Files of value are already stored on a second computer and a USB drive. No data recovery step is required.

---

## Part 1 — Locate the Monthly Charge

University accounts are institution-funded. The monthly charge is therefore a **separate subscription**, most likely attached to the personal Microsoft account.

**Step 1.** Open a private/incognito browser window (Ctrl+Shift+N in Chrome or Edge). This prevents the browser from auto-signing in with cached credentials.

**Step 2.** Go to `account.microsoft.com/services`

**Step 3.** Sign in with the **personal** Microsoft account — the one showing 5 GB.

**Step 4.** Record what appears under Services & subscriptions:
- Subscription name
- Renewal date
- Billing amount

**If nothing is listed**, the charge originates elsewhere. Check the card or bank statement for the merchant name, then see Part 2B.

---

## Part 2A — Cancel (Billed Directly by Microsoft)

**Step 1.** From `account.microsoft.com/services`, locate the subscription.

**Step 2.** Select **Manage**.

**Step 3.** Select **Cancel subscription**, or turn off recurring billing.

**Step 4.** Confirm the cancellation.

**Step 5.** Note the end-of-access date. Access normally continues until the current paid period expires.

---

## Part 2B — Cancel (Billed by a Third Party)

Microsoft cannot cancel a subscription billed through another vendor. Cancel where the payment originates.

| Billing source | Where to cancel |
|---|---|
| Apple | Device Settings → your name → Subscriptions |
| Google Play | Play Store → Payments & subscriptions |
| GoDaddy, Amazon, or other reseller | That vendor's account portal |

---

## Part 3 — Close the University Account

The account is institutional property and cannot be self-deleted.

**Step 1.** Contact the university IT help desk.

**Step 2.** State that the affiliation has ended and request the account be closed.

**Step 3.** If the account already fails to authenticate, deprovisioning is likely underway. No action required — it will lapse on the institution's schedule.

---

## Part 4 — Clean Up the Lenovo IdeaPad

**Step 1.** Right-click the OneDrive cloud icon in the system tray.

**Step 2.** Select **Settings**.

**Step 3.** Open the **Account** tab.

**Step 4.** Select **Unlink this PC**.

Unlinking stops syncing only. Files already on the local disk remain in place and are not deleted.

**Note on paths:** The commands below assume the Windows username on the IdeaPad is `willi`. Confirm with `echo %USERNAME%` at a command prompt and substitute if it differs.

**Step 5.** Open `C:\Users\willi\OneDrive\` and review the contents. Confirm nothing remains there that is not already duplicated on the second computer or USB drive.

**Step 6.** Search project files for hardcoded OneDrive paths:

```
findstr /s /i /m "OneDrive" C:\Users\willi\*.ps1 C:\Users\willi\*.bat C:\Users\willi\*.md
```

Any file returned by that command references a OneDrive path that will no longer resolve correctly. Update those references before the next GatewayGuard build.

---

## Part 5 — Replacement Storage (Decision Required)

GatewayGuard LLC currently has no storage under its own control. Options:

| Option | Cost | Notes |
|---|---|---|
| Microsoft 365 Business Basic | ~$6–7/user/month | 1 TB OneDrive, business email on owned domain, fully under GatewayGuard LLC control |
| Local + external drive only | $0 | No cloud redundancy; single point of failure |
| Alternate cloud provider | Varies | Requires separate evaluation |

**Note:** Microsoft retired new sign-ups for standalone OneDrive for Business plans on 31 May 2026. The current path for business storage is a Microsoft 365 Business plan.

Decision pending. Not required before the September 1, 2026 launch, but recommended before commercial distribution begins.

---

## Reference — Diagnostic Steps Already Completed

Retained for record. These were performed and their results led to the conclusions above.

| Check | Result |
|---|---|
| Quota shown at onedrive.live.com | 5 GB — free tier confirmed |
| Account type | Personal Microsoft account, no subscription attached |
| Admin portal access (admin.microsoft.com) | Refused — requires organizational credentials |
| Source of 1 TB entitlement | University tenant, affiliation ended |
| onedrive.cloud.microsoft | Not yet live for this tenant; domain migration is staged through 2027 |

---

## Items That Did Not Apply

Recorded so they are not retried unnecessarily.

- **Emptying the OneDrive web recycle bin** — relevant only when quota is correct but usage is inflated. Not the cause here.
- **`onedrive.exe /reset`** — clears stale cached quota. Not applicable; the reported quota was accurate.
- **Unlink/relink to refresh quota** — would have reconnected the same 5 GB account.
- **Microsoft 365 Family seat assignment** — no Family subscription exists.
