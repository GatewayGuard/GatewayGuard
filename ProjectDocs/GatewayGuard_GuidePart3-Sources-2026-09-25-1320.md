<!-- Dated: 2026-09-25 13:20 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Guide Part 3 -- the sources behind the 2026-09-24 edits

- **Document Name:** GatewayGuard_GuidePart3-Sources
- **Dated:** 2026-09-25 13:20 ET
- **Editor:** Claude Code (CGDELL)
- **Purpose:** the evidence for every factual sentence added to
  `GatewayGuard_CoPilotGuidePart3-2026-09-16-1627.md` on 2026-09-24 in answer
  to Bill's inline comments. **Written because Cloud's 09-25 review
  (`GatewayGuard_CloudReview-ascii44Triage-GuidePart3-Part4-2026-09-25-1308.md`,
  Part B) flagged B-11b, B-12b, B-14a and B-19a as unsourced -- the sources
  existed, but only in a research pass inside a Claude Code session, never in
  the repository.** A source Cloud cannot see is a source T-VF1 cannot check.
- **Labels:** **sourced** (URL given) / **measured** (CGDELL, Windows 11 Pro
  build 26200, read-only, 2026-09-24) / **inferred**. Nothing here was changed
  on the machine.
- **What is NOT settled** is listed at the end, and those sentences carry a
  VERIFY marker in the twin.

---

## Setting 10 -- Remote Desktop and Quick Assist

- **sourced:** the remote PC "must be running Windows Pro edition"; a Home PC
  can connect *out* with the Remote Desktop app. Pro path: Start > Settings >
  System > Remote Desktop, toggle labelled **Remote Desktop**.
  https://support.microsoft.com/en-us/windows/how-to-use-remote-desktop-5fe128d5-8fb1-7a23-3b8a-41e636865e8c
- Our own `WebSite\html\remote-desktop.html` already says Home "connects out,
  and it does not let anything connect in."
- **sourced (Quick Assist):** open with Ctrl + Windows key + Q or Start >
  *Quick Assist*; the helper selects **Help someone** and needs a Microsoft
  account; the person getting help enters the code under **Security code from
  assistant**, selects **Submit**, then **Allow**; Microsoft warns "Only allow
  a Helper to connect to your device if you initiated the interaction."
  https://learn.microsoft.com/en-us/windows/client-management/client-tools/quick-assist
  https://support.microsoft.com/en-us/windows/solve-pc-problems-remotely-using-quick-assist-b077e31a-16f4-2529-1a47-21f6a9040bf3
- **measured:** `mstsc.exe` present; Quick Assist installed
  (`MicrosoftCorporationII.QuickAssist 2.0.56.0`) -- on Pro. Home not checked.
- **Still VERIFY (W-07):** the button labels were read from Microsoft's pages,
  not off a live screen.

## Setting 11 -- Advertising ID

- **sourced:** Windows "generates a unique advertising ID for each user on a
  device, which app developers and advertising networks can then use...
  including providing more relevant advertising in apps." Turning it off "will
  not reduce the number of ads you see, but it may mean that ads are less
  interesting and relevant." It "does not apply to other methods of
  interest-based advertising... such as cookies used to provide interest-based
  display ads on websites." **This last quote is the source for "It has no
  effect on web searches or websites" (Cloud's B-11b).**
  https://support.microsoft.com/en-us/windows/general-privacy-settings-in-windows-7c7f6a09-cebd-5589-c376-7f505e5bf65a
- **Path note:** that Microsoft page still says Privacy & security > General.
  The twin keeps **Recommendations and offers**, the path reconciled on
  2026-09-17 (R-21). The build's `Revert` string still says "General" -- Cloud
  B / Part 4 §4.2 flags this for ascii45.
- **measured:** `HKCU\...\AdvertisingInfo\Enabled` = 0 on CGDELL.
- **Stance:** Bill's 2026-08-21 call (`GatewayGuard_CloudRequest-GuideSetting11-2026-08-21.md`)
  is "more than a preference / a record exists," and "do not claim it is a
  literal security requirement." The 09-24 wording kept the second half and
  dropped the first -- Cloud's B-11a is right.

## Setting 12 -- Diagnostic Data

- **sourced:** Optional adds "App activity, such as which programs are
  launched... how long they run," "Browser activity, including browsing
  history and search terms, in Microsoft browsers," and full crash memory
  dumps that "may unintentionally contain user content, such as parts of a
  file you were using." Required is the "minimum data required to keep the
  device secure, up to date, and performing as expected." **This is the source
  for the crash-memory sentence (Cloud's B-12b).**
  https://learn.microsoft.com/en-us/windows/privacy/configure-windows-diagnostic-data-in-your-organization
- **sourced:** "Regardless of whether you choose to send Optional diagnostic
  data, your device will be just as secure and will operate normally."
  https://support.microsoft.com/en-us/windows/diagnostics-feedback-and-privacy-in-windows-28808a2b-a31b-dd73-dcd3-4559a5199319
- Typing and handwriting are a **separate** setting (*Improve inking &
  typing*), not part of Optional -- same support page.
- **measured:** `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection\AllowTelemetry`
  = 3 (Optional) on CGDELL.
- **NOT settled:** which level a new *consumer* install defaults to. Microsoft
  Learn says Required is the default, but that page is written for managed
  PCs; third-party sources say setup pre-selects Optional. The existing VERIFY
  marker stays.

## Setting 14 -- Widgets

- **sourced:** the taskbar entry point shows "weather information on the
  taskbar most of the time" -- **the temperature IS the Widgets button.** Path:
  Taskbar settings > Taskbar items > Widgets. With the button removed the panel
  still opens with **Windows key + W**. The news feed can be turned off on its
  own: panel settings > **Dashboards > Discover**.
  https://support.microsoft.com/en-us/windows/experience/personalization/stay-up-to-date-with-widgets-in-windows
- **sourced:** the "Allow widgets" policy "applies to the entire widgets
  experience, including content on the taskbar."
  https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-newsandinterests
- **sourced (the scam ads, Cloud's B-14a):** tech-support-scam ads were placed
  in the Microsoft Edge news feed and removed by Microsoft; also in
  `GatewayGuard_CloudResearch-WidgetsAndAccessibility-2026-08-24-1015.md` §2.4.
  https://www.techradar.com/news/microsoft-edge-news-feed-infiltrated-by-tech-support-scammers
  **inferred, not sourced:** that the *Widgets* Discover feed carries the same
  ad inventory. The guide sentence should name the Edge news feed or be hedged.
- **measured today:** `TaskbarDa` is **absent** (it read 1 on 2026-09-17), so
  Windows is on its default (on). `Widgets.exe` 73 MB, `WidgetService` 29 MB.
  **No memory claim should be published** -- nobody has measured what stops
  when Widgets is turned off.
- **Still VERIFY (W-07):** Windows key + W and Dashboards > Discover have not
  been read off a live screen.

## Setting 15 -- Edge password saving, other browsers, Bitwarden

- **sourced:** Microsoft moved Edge onto Chromium (announced 2018-12-06,
  released 2020-01-15).
  https://blogs.windows.com/windowsexperience/2018/12/06/microsoft-edge-making-the-web-better-through-more-open-source-collaboration/
  https://blogs.windows.com/windowsexperience/2020/01/15/new-year-new-browser-the-new-microsoft-edge-is-out-of-preview-and-now-available-for-download/
- **sourced (Chrome):** three-dot menu > Passwords and autofill > Google
  Password Manager > Settings > **Offer to save passwords and passkeys**.
  https://support.google.com/chrome/answer/95606
- **Firefox:** Settings > Privacy & Security > Passwords > **Ask to save
  passwords** -- from Mozilla's support search result only; the page itself
  did not load. **VERIFY.** https://support.mozilla.org/en-US/kb/disable-password-saving-firefox
- **Bitwarden, facts only -- naming it is Bill's decision (Cloud B-15c
  recommends naming no product):** free personal plan with "unlimited devices,
  unlimited passwords" (https://bitwarden.com/pricing/); Bitwarden, Inc., Santa
  Barbara, CA, USA (https://bitwarden.com/privacy/); audited by Cure53
  2018-2025 and others (https://bitwarden.com/help/is-bitwarden-audited/).

## Setting 19 -- Wake on LAN

- **sourced (Cloud's B-19a):** backup programs that run on the PC wake it with
  **wake timers**, not Wake on LAN --
  Veeam: https://helpcenter.veeam.com/docs/agentforwindows/userguide/schedule_wakeup.html ;
  Macrium ("Wake the computer to run this task" depends on *Allow wake
  timers*): https://knowledgebase.macrium.com/display/KNOWX/PC+wont+wake+from+Sleep+to+run+a+backup
- **sourced:** Windows' own maintenance and Update Orchestrator wake the PC
  with wake timers.
  https://learn.microsoft.com/en-us/troubleshoot/windows-client/setup-upgrade-and-drivers/desktop-wakes-up-unexpectedly-from-sleep-hibernation
  The only Microsoft product found using Wake on LAN for updates is
  Configuration Manager (business):
  https://learn.microsoft.com/en-us/intune/configmgr/core/clients/deploy/configure-wake-on-lan
- **community source, not vendor:** Synology Active Backup has no built-in
  wake; users script it. https://community.synology.com/enu/forum/1/post/154688
- **sourced:** Device Manager labels *Allow this device to wake the computer*
  and *Only allow a magic packet to wake the computer*.
  https://learn.microsoft.com/en-us/troubleshoot/windows-client/networking/unwanted-wake-up-events
- **measured (CGDELL):** Ethernet WakeOnMagicPacket = Disabled; Wi-Fi
  WakeOnMagicPacket = Enabled, WakeOnPattern = Enabled.
- **Checkup already turns this off with permission:** setting 19,
  `CanAuto=$true`, `Apply-Setting` ~line 7051 (`Set-NetAdapterPowerManagement`).

## Locked controls note

- **measured (build):** `Get-GGPolicyLock` (line 3632) checks Group Policy
  locks for items 2 (Defender real-time), 4 (SmartScreen) and 7 (Firewall).
  It does **not** detect Smart App Control (FT-260). The note says exactly
  that and carries the FT-260 sentence Bill approved 2026-09-16.

---

## Open -- still VERIFY in the twin

1. Quick Assist button labels, read off a live screen.
2. Windows key + W and Dashboards > Discover, read off a live screen.
3. Chrome and Firefox password-setting labels, read off live browsers.
4. Default diagnostic-data level on a new consumer install.
5. Which of the 19 settings a System Restore actually puts back (Cloud Part 4 §4.3).
