<!-- Dated: 2026-09-16 16:27 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Copilot's Guide Rewrite -- Part 3 (Additional Security and Privacy), verbatim

- **Document Name:** GatewayGuard_CoPilotGuidePart3-2026-09-16-1627
- **Dated:** 2026-09-16 16:27 ET
- **Editor:** Claude Code (CGDELL)
- **Purpose:** a verbatim `.md` twin of `Co-Pilot part 3 Additional Security and Priv-2026-09-16-1448.txt`, made because Claude Cloud's project-knowledge search did not surface any of the seven Copilot `.txt` files this session -- the same failure this project already fixed once for `.docx`/`.pdf` (Step 5, `CLAUDE.md`), showing up here for `.txt` instead.
- **No longer verbatim.** Reconciliation pack R-01 to R-29 applied 2026-09-17; Bill's inline comments (left in the `.txt` above, in single quotes) applied 2026-09-24 -- Remote Desktop/Quick Assist, Advertising ID, Diagnostic Data, Widgets and the taskbar weather, other browsers' password setting, Wake on LAN's backup reason, locked controls, and the Part 4 lead-in. This `.md` is now the live text; the `.txt` is the record of Copilot's original plus Bill's comments.

---

Part 3: Additional Security and Privacy Settings

The settings in this section are still important, but they generally have less impact on overall security than the protections covered in Part 2.

These settings involve a balance of:

Security
Privacy
Convenience
Performance

In some cases, reasonable people may choose different options based on how they use their computers.

Setting 10: Remote Desktop
What It Is

Remote Desktop allows someone to connect to and control your computer from another device.

Why It Matters

When enabled, Remote Desktop creates an additional way to access your computer.

If not properly secured, remote access services can increase security risks.

GatewayGuard Recommendation

Recommended: Off

On Windows 11 Pro, with your approval, Checkup will turn this off for you. On Windows 11 Home there is nothing to turn off, and Checkup will not ask.

Windows 11 Home cannot be reached by Remote Desktop, so there is nothing to turn off. Home can still connect out to another PC, for example a work computer, using the Remote Desktop Connection app.

To let a family member help you, use Quick Assist, which is built into Windows. Press Ctrl + Windows key + Q, or click Start and type Quick Assist. The helper clicks Help someone and reads you a code. You type that code, click Submit, then click Allow. You can end the session at any time by clicking Leave.

Only do this when you called the helper. Never do it for someone who called you.

⚠ VERIFY -- Quick Assist keys and button labels (Help someone, Submit, Allow, Leave) read off a live screen; currently from Microsoft's pages.

How To Check
Open Settings.
Select System.
Select Remote Desktop.

It should say Off. If it says On, turn it off.

If Settings > System has no Remote Desktop entry, your computer is Windows 11 Home and cannot accept these connections. There is nothing to turn off.

⚠ VERIFY -- exact on-screen path and label on Pro; what Home shows (page absent, or present and greyed).

How To Change It

Turn Remote Desktop off unless you actively use it.

What To Expect

Disabling Remote Desktop prevents remote connections from other devices.

When You Might Choose Differently

You may leave it enabled if:

You remotely access your computer.
You provide remote support to family members.
You use your computer from another location.

If you leave it on, use a strong password.

Setting 11: Advertising ID
What It Is

Windows assigns a unique advertising identifier to your user account.

Applications can use this identifier to personalize advertisements and recommendations.

Why It Matters

This is a privacy setting, not a security risk.

The advertising ID is a number apps can use to pick ads for you. It has no effect on web searches or websites.

Turning it off does not reduce the number of ads you see. Apps simply can no longer use this number to tailor them to you.

This is more than a taste. The tracking number lets apps build a record of what you do across programs and hand it to advertisers. Turning it off stops that record getting longer.

GatewayGuard Recommendation

Recommended: Off

With your approval, Checkup will make this change for you.

How To Check
Open Settings.
Select Privacy & Security.
Select Recommendations and offers.
How To Change It

Turn off:

Let apps show me personalized ads by using my advertising ID.

What To Expect

You may still see advertisements.

The advertisements may simply be less personalized.

When You Might Choose Differently

Users who prefer personalized recommendations may choose to leave this enabled.

Setting 12: Diagnostic Data
What It Is

Windows sends diagnostic information to Microsoft to help identify bugs, compatibility issues, and reliability problems.

Why It Matters

This is a privacy setting. It does not weaken your security.

Windows always sends Microsoft a basic report on your PC's health. The extra Optional level adds the websites you visit in Edge, which programs you use, and copies of memory when a program crashes. Those copies can include parts of a file you had open.

Windows Update and your protection work exactly the same at either level.

GatewayGuard Recommendation

Recommended: Required Diagnostic Data Only

With your approval, Checkup will make this change for you.

How To Check
Open Settings.
Select Privacy & Security.
Select Diagnostics & Feedback.
How To Change It

Choose:

Required Diagnostic Data


rather than:

Optional Diagnostic Data

What To Expect

Windows will continue sending information necessary to maintain and update the operating system.

⚠ VERIFY -- Windows sends the larger level unless told otherwise; updates are identical at either level.

When You Might Choose Differently

If Microsoft support has asked you to send more information, or you have joined the Windows Insider Program on purpose, you may choose the higher level.

Setting 13: Edge Startup Boost
What It Is

Edge Startup Boost and Background Running are two separate toggles in Edge's settings, and Checkup treats them as one setting.

Startup boost pre-loads part of Microsoft Edge when your PC starts, so the browser opens faster.

Continue running background extensions and apps keeps Edge running in the background after you close it.

⚠ VERIFY -- the running-after-close claim, and the exact current label of Edge's background-apps toggle.

Why It Matters

Startup Boost can make Edge launch faster.

However, it also consumes memory and background resources even when the browser is not being used.

GatewayGuard Recommendation

Recommended: Off

With your approval, Checkup will make this change for you.

The performance benefit is usually small on modern hardware.

How To Check
Open Microsoft Edge.
Open Settings.
Select System and Performance.
Open Startup boost first, or the toggles do not appear.
Review Startup boost and Continue running background extensions and apps.
How To Change It

Turn off Startup boost and Continue running background extensions and apps.

What To Expect

Edge may take slightly longer to start after a reboot.

Many users will not notice a significant difference.

When You Might Choose Differently

You may leave Startup Boost enabled if:

You open Edge frequently throughout the day.
Faster browser startup is important to you.
Setting 14: Windows Widgets
What It Is

Widgets display news, weather, sports, and other information on the Windows taskbar.

Why It Matters

Widgets is the weather button on the left of your taskbar and the news panel that opens from it.

The news panel carries advertising. Ads placed in Microsoft's news feed in the Edge browser have been used to send people to fake "call this number" warning pages.

GatewayGuard Recommendation

Recommended: Off

With your approval, Checkup will make this change for you.

How To Check
Right-click the taskbar.
Select Taskbar Settings.
How To Change It

Turn Widgets off.

What To Expect

The Widgets button disappears from the taskbar, and the temperature on the taskbar goes with it.

The panel still opens if you press Windows key + W, and you can turn Widgets back on at any time.

When You Might Choose Differently

If you check the weather on your taskbar every day, you may prefer to keep Widgets on and turn off only the news. Open the panel, click the settings button, and under Dashboards turn Discover off.

Checkup turns Widgets off entirely. If you want the weather only, answer No when Checkup offers this change, then do the step above yourself.

⚠ VERIFY -- Windows key + W with Widgets off, and Dashboards > Discover, read off a live screen.

Setting 15: Edge Password Saving
What It Is

Microsoft Edge can store usernames and passwords for websites you visit.

Why It Matters

Built-in password storage is convenient.

However, many users already use a dedicated password manager that provides:

Cross-device synchronization
Secure sharing
Additional security features

Using multiple password managers can create confusion.

GatewayGuard Recommendation

Recommended: Off When Using A Dedicated Password Manager

Checkup asks first if you use a password manager, and only offers this change if you do. With your approval, Checkup will make this change for you.

How To Check
Open Microsoft Edge.
Open Settings.
Select Passwords.
How To Change It

Turn off password saving if another password manager is your primary solution.

Microsoft Edge is Microsoft's own browser. It is built on the same underlying browser engine as Google Chrome, which is why the two look alike, but it is a separate product. Other browsers have the same setting:

Chrome: three-dot menu > Passwords and autofill > Google Password Manager > Settings > Offer to save passwords and passkeys.

Firefox: Settings > Privacy & Security > Ask to save passwords.

⚠ VERIFY -- the Chrome and Firefox labels, read off live copies of each browser.

What To Expect

Edge will stop offering to save new passwords.

When You Might Choose Differently

If you do not use a password manager, Edge password saving remains significantly better than reusing weak passwords or storing them in unsecured locations.

Setting 18: Fast Startup
What It Is

Fast Startup combines elements of shutdown and hibernation to reduce boot time.

Why It Matters

With Fast Startup on, Shut down does not fully shut the computer down. Windows saves part of itself to disk and reloads it the next time. Some updates and repairs only finish after a real shutdown, so problems can carry over from one day to the next.

⚠ VERIFY -- which updates and repairs need a full shutdown to finish.

GatewayGuard Recommendation

Recommended: Off

With your approval, Checkup will make this change for you.

How To Check
Open Control Panel.
Select Power Options.
Select Choose what the power buttons do.
Select Change settings that are currently unavailable.
How To Change It

Untick Turn on fast startup (recommended).

Windows labels this "recommended". That is Microsoft's default, not GatewayGuard's advice.

What To Expect

Computer startup may take slightly longer.

Shutdown and restart behavior often becomes more predictable.

When You Might Choose Differently

Users with older hardware may prefer the faster boot times provided by Fast Startup.

Setting 19: Wake on LAN
What It Is

Wake on LAN allows another device on the network to turn on your computer remotely.

Why It Matters

Many home users never need this capability.

Leaving unnecessary remote-management features disabled reduces complexity and potential exposure.

GatewayGuard Recommendation

Recommended: Off

With your approval, Checkup will make this change for you.

How To Check
Open Device Manager.
Select Network adapters.
Right-click each adapter and select Properties.
Select the Power Management tab.
How To Change It

Untick Allow this device to wake the computer, on each network adapter, if you do not intentionally use remote wake functionality.

What To Expect

Your computer can no longer be powered on remotely from another device.

When You Might Choose Differently

Keep Wake on LAN on only if another device in your home, such as a network storage box, has been set up to wake this PC.

Backup programs that run on this PC wake it with their own timer and do not need Wake on LAN. Windows Update does not need it either.
A Note About Gray or Locked Controls

Occasionally Windows may display messages such as:

This setting is managed by your organization

or

This setting is managed by Smart App Control

In these situations, the setting may not be editable.

This is not a fault. Windows itself, or a security feature that is already protecting you, is holding that setting in place.

Checkup tells you when a Windows policy on your computer is forcing Microsoft Defender real-time protection, SmartScreen, or the Firewall. When that happens, Checkup says so instead of asking you to change something Windows will not let you change.

If Windows says a setting is managed by Smart App Control, that setting is already protected and cannot be changed there. This is normal, not a fault.

Part 4: Before and After You Make Changes

Every change in Parts 2 and 3 can be put back. Part 4 shows how for each one, and what to do if something does not look right afterward.