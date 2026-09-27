<!-- Dated: 2026-09-27 09:46 ET -->
<!-- Editor: Claude Code (CGDELL), from a research agent's report -->
# Windows Hello detection and unwanted-app blocking -- what is confirmed

Asked by Bill 2026-09-27: "do deep research to see what we can determine has
been confirmed about this in the real world" (item 9), and "App Blocking --
are we talking about settings? Which ones? How do I check it?"

Labels: **SOURCED** (URL given), **MEASURED** (CGDELL, 2026-09-26/27),
**UNCONFIRMED** (no source found).

## Item 9 -- Windows Hello

| Question | Finding |
|---|---|
| `LastLoggedOnProvider` documented? | **No official Microsoft doc.** A Microsoft Q&A answer recommends it for exactly this check: https://learn.microsoft.com/en-us/answers/questions/1103769/detect-if-logged-into-windows-hello-for-business-i . Intune MVP: "the credential provider that is used for the current sign in": https://petervanderwoude.nl/post/excluding-the-password-credential-provider/ . Updates on unlock too: **MEASURED only** (Bill's Win+L test). No known stale cases found. |
| Provider IDs | **SOURCED**, Microsoft Learn (multifactor / trusted-signal unlock): PIN `{D6886603-9D2F-4EB2-B667-1971041FA96B}`, fingerprint `{BEC09223-B018-416D-A0AC-523971B639F5}`, face `{8AF662BF-65A0-4D0A-A540-A338A999D36F}`. Biometrics require a PIN. Password `{60B78E88-...}`: blog only. **Built into ascii45 2026-09-27 -- all three count.** |
| `dsregcmd` NgcSet | Defined as "a Windows Hello key is set for the current logged-in user", and must run in the user's context: https://learn.microsoft.com/en-us/entra/identity/devices/troubleshoot-device-dsregcmd . Checkup runs elevated, so **unreliable for Checkup**. Explains CGDELL's `NO`. |
| An API for "user has Hello" | `UserConsentVerifier.CheckAvailabilityAsync` -- `NotConfiguredForUser` is Microsoft's documented "no PIN set up" answer: https://learn.microsoft.com/en-us/uwp/api/windows.security.credentials.ui.userconsentverifieravailability . **MEASURED: returns `Available` on CGDELL from elevated PowerShell 5.1, no prompt.** **NOT measured: the no-PIN case.** `KeyCredentialManager.IsSupportedAsync` documented as needing a Microsoft account -- rejected. The NGC folder is machine-wide (`C:\Windows\ServiceProfiles\LocalService\...`) -- rejected. |
| Settings "not available" after switching to a local account; `DevicePasswordLessBuildVersion` | The Microsoft-accounts-only option "is only available when you sign in with your Microsoft account": https://support.microsoft.com/en-us/accounts-billing/security/sign-in-options-in-windows . Value meaning (2 = on) from Winaero only. **No confirmed cause or fix for CGDELL's state.** |
| Sign-in box labelled "PIN" / "Password"? | **UNCONFIRMED.** Community answers mention an "I forgot my PIN" link under the PIN box. **MEASURED by Bill on CGDELL 2026-09-27:** Win+L shows "Enter PIN" with a Sign-in options link; choosing the password option shows an "enter password" box. Item 9's question now uses exactly this (commit `55dce36`). |

**Recommended next step (not built):** GOOD only when the last sign-in used a
Hello provider for this account **and** `CheckAvailabilityAsync` returns
`Available`. `NotConfiguredForUser` = not set up. Anything else = ask the
person. **Needs one measurement first:** a user with no PIN (CGDELL's
`localuser` account) must read `NotConfiguredForUser` when elevated.

## Unwanted-app blocking

- **Where:** Windows Security -> App & browser control -> Reputation-based
  protection settings -> Potentially unwanted app blocking. Two tick boxes.
  https://support.microsoft.com/en-us/security/protect-your-pc-from-potentially-unwanted-applications
- **Block apps** = Defender `PUAProtection` (inferred, community-supported).
  Values, **SOURCED**
  (https://learn.microsoft.com/en-us/defender-endpoint/detect-block-potentially-unwanted-apps-microsoft-defender-antivirus):
  0 off, 1 on (blocks), **2 audit = "detects ... but takes no action"**.
- **Block downloads** = Microsoft Edge only, per-user
  `HKCU\Software\Microsoft\Edge\SmartScreenPuaEnabled`; the Edge policy is
  "turned off by default": https://learn.microsoft.com/en-us/deployedge/microsoft-edge-policies/smartscreenpuaenabled
- **Default: Microsoft contradicts itself.** Learn: home PCs default to audit
  (2). One Support page: off by default. Another: on by default since August
  2021 (https://support.microsoft.com/en-us/security/potentially-unwanted-apps-are-blocked-by-default).
- **MEASURED on CGDELL:** `PUAProtection` = 2 (audit -- nothing blocked);
  Edge `SmartScreenPuaEnabled` = 0 (off). So on this PC, by default, **nothing
  is blocked**.
- **Consequence to test (inferred):** the 2026-09-07/08 result -- Defender
  flagged 0 of 6 unwanted programs, Malwarebytes 6 of 6 -- was taken in audit
  mode. Re-running it with blocking on would show if Defender's result was the
  setting, not the product. That bears on what the guide may say (CLAUDE.md,
  Approved Products).
- Checkup (E3) turns on **Block apps** only. **Block downloads** (Edge) is not
  touched -- a candidate for later.
