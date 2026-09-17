<!-- Dated: 2026-09-16 16:27 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Copilot's Guide Rewrite -- Part 3 (Additional Security and Privacy), verbatim

- **Document Name:** GatewayGuard_CoPilotGuidePart3-2026-09-16-1627
- **Dated:** 2026-09-16 16:27 ET
- **Editor:** Claude Code (CGDELL)
- **Purpose:** a verbatim `.md` twin of `Co-Pilot part 3 Additional Security and Priv-2026-09-16-1448.txt`, made because Claude Cloud's project-knowledge search did not surface any of the seven Copilot `.txt` files this session -- the same failure this project already fixed once for `.docx`/`.pdf` (Step 5, `CLAUDE.md`), showing up here for `.txt` instead.
- **Nothing cut, nothing reworded below.** The `.txt` file named above remains the file of record; this exists only so Cloud's connector can read the same words.

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

With your approval, Checkup will make this change for you.

Many home users do not need Remote Desktop.

How To Check
Open Settings.
Select System.
Select Remote Desktop.

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

If enabled, use a strong password and Windows Hello whenever possible.

Setting 11: Advertising ID
What It Is

Windows assigns a unique advertising identifier to your user account.

Applications can use this identifier to personalize advertisements and recommendations.

Why It Matters

Advertising IDs do not directly improve computer security.

However, disabling them can reduce some forms of activity tracking and ad personalization.

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

Diagnostic data can help Microsoft improve Windows.

However, many users prefer to limit information sharing when possible.

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

Users participating in troubleshooting or preview programs may choose to provide additional diagnostic information.

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

Widgets are primarily a convenience feature.

Disabling them can reduce distractions and background activity.

GatewayGuard Recommendation

Recommended: Off

With your approval, Checkup will make this change for you.

How To Check
Right-click the taskbar.
Select Taskbar Settings.
How To Change It

Turn Widgets off.

What To Expect

The Widgets button will disappear from the taskbar.

You can re-enable it at any time.

When You Might Choose Differently

Users who regularly use weather forecasts, news updates, or calendar information may prefer to keep Widgets enabled.

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

Disable password saving if another password manager is your primary solution.

What To Expect

Edge will stop offering to save new passwords.

When You Might Choose Differently

If you do not use a password manager, Edge password saving remains significantly better than reusing weak passwords or storing them in unsecured locations.

Setting 18: Fast Startup
What It Is

Fast Startup combines elements of shutdown and hibernation to reduce boot time.

Why It Matters

Fast Startup can occasionally interfere with:

Maintenance tasks
Dual-boot systems
Certain updates
Troubleshooting procedures
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

What To Expect

Computer startup may take slightly longer.

Shutdown and restart behavior often becomes more predictable.

When You Might Choose Differently

Users with older hardware may prefer the faster boot times provided by Fast Startup.

Setting 19: Wake on LAN
What It Is

Wake on LAN allows another device on the network to turn on your computer remotely.

Why It Matters

Many home users never use this capability.

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

You may leave Wake on LAN enabled if:

You remotely access your computer.
You use network backup software.
You administer multiple computers.
A Note About Gray or Locked Controls

Occasionally Windows may display messages such as:

This setting is managed by your organization

or

This setting is managed by Smart App Control

In these situations, the setting may not be editable.

This does not necessarily indicate a problem. Windows security features, system policies, or other configuration controls can sometimes manage a setting automatically.

If GatewayGuard reports that the setting is already configured correctly, no further action is usually required.

Part 4: Making Changes Safely

Now that you understand each GatewayGuard recommendation, the next section explains how to apply changes safely, create backups when appropriate, and recover from common mistakes.