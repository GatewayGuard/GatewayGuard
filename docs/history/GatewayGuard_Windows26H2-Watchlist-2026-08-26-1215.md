# Windows 11 version 26H2 -- what is in it, and what it costs us

# Dated: 2026-08-26 12:15 ET

**Status: FIRST PASS, AND DELIBERATELY INCOMPLETE. Read section 0 before using
anything here.**

---

## 0. WHAT THIS DOCUMENT IS NOT, AND WHY

**Bill asked for a list built from a PCMag article and every article linked
beside it:**
`https://www.pcmag.com/news/spy-on-me-no-more-the-shocking-windows-11-upgrade-every-pc-user-needs`

**That article could not be read, and neither could its link list.**

- ***measured 2026-08-26:*** `WebFetch` on that URL returns
  **"Claude Code is unable to fetch from www.pcmag.com"**. PCMag's server
  blocks the crawler.
- ***measured:*** a web search on the exact headline returns Steam forums, two
  Yahoo syndication pages and an AnandTech thread. **The article is not in the
  index.**

**So nothing in this document comes from PCMag, and the list of "all the rest
listed at this url" is not here.** It cannot be reconstructed by guessing, and
guessing at it would be inventing a citation.

**To finish the job Bill asked for, one of these:** paste the headlines, save
the page as HTML or PDF into `ProjectDocs\`, or name the specific claim to
check and it can be verified against Microsoft directly.

**What IS here comes from Microsoft's own release notes**, which are fetchable,
dated, and a better foundation for guide copy than a magazine. Every row carries
its build number, date and link.

---

## 1. THE ONE FACT THAT MATTERS MOST FOR PLANNING

**26H2 is not a rebuild. It arrives on the machines you already have, through an
enablement package, on the same servicing branch as 25H2.**

*Sourced,* Microsoft Learn, every 26300 release-notes page:
> *"Updates are based on Windows 11, version 26H2 via an enablement package
> (Build 26300.xxxx)."*

The enablement-package KB referenced is **KB5054156**.

**Versioning flipped to 26H2 in build 26300.8697, released 19 June 2026** --
*sourced:* *"Windows Insiders in the Experimental channel will see the
versioning updated under Settings > System > About (and winver) to version
26H2."*

### What that means here

- **Both machines are on 25H2, build 26200.9168** (*measured 2026-08-26:*
  CGDELL and SANDY identical). **26H2 is build 26300.** They are one enablement
  package apart, not one reinstall apart.
- **A 26H2 rollout can land on a customer's PC mid-life without warning**, the
  same way KB5121003 did in August. Checkup has to keep working across it.
- **The 25H2/26H2 shared-branch design means most 26H2 features also reach
  25H2.** *Inferred* from the shared servicing branch and the enablement-package
  mechanism; **not confirmed feature-by-feature.** Do not tell a customer their
  25H2 machine will or will not get a given feature.

---

## 2. CHANGES CONFIRMED AGAINST MICROSOFT'S OWN RELEASE NOTES

**Every row below was read directly from the linked page. Anything I could not
read that way is in section 3, labelled as such.**

### Build 26300.9032 -- 31 July 2026
[Release notes](https://learn.microsoft.com/en-us/windows-insider/release-notes/experimental/preview-build-26300-9032)

| Change | Exact detail | Touches us? |
|---|---|---|
| **Search auto-expands its own indexing scope** | *"Windows Search can now automatically expand its indexing scope based on your activity, using signals like recent files and frequently accessed locations."* Managed at **Settings > Privacy & security > Search** | **YES -- see 4.1** |
| **Windows Spotlight on the lock screen** | *"Made some underlying changes to help improve reliability for Windows Spotlight on the lock screen."* | **YES -- see 4.2** |
| Adaptive hibernate policy | Less hibernation above 80% battery, hibernates sooner below 10% | **YES -- see 4.3** |
| Settings app search | Surfaces results from more areas, improved ranking | Minor -- see 4.4 |
| File Explorer / DFS Mark of the Web | Files on a DFS mapped drive could be wrongly treated as internet-origin, producing *"The file you are attempting to preview could harm your computer"* | No -- enterprise DFS |
| Phone Link in Start | Hover a recent message or notification to preview it in Start | No |
| Start menu, Taskbar, Storage/SMB File History | Bug fixes | No |
| Insider flight certificate | Expires 11 Aug 2026 | No -- Insider only |

### Build 26300.8935 -- 20 July 2026
[Release notes](https://learn.microsoft.com/en-us/windows-insider/release-notes/experimental/preview-build-26300-8935)

| Change | Exact detail | Touches us? |
|---|---|---|
| **Widgets -- animated taskbar icons** | *"expanding support for animated icons on the Widgets taskbar entry point... a broader set of dynamically updated animated content from supported widget providers"* | **YES -- see 4.5** |
| Desktop background persistence | Cosmetic changes to **Settings > Personalization > Background** | No |
| File Explorer | Faster deletion of large fragmented files; faster Home; touch scrolling | No |
| Run / Taskbar / Search box / Input | F4 expands Run suggestions; search box 4px taller; cursor and voice-typing fixes | No |
| Windows Update | Fixed flights failing with 0xc0000409 | No |

### Build 26300.8697 -- 19 June 2026
[Release notes](https://learn.microsoft.com/en-us/windows-insider/release-notes/experimental/preview-build-26300-8697)

| Change | Exact detail | Touches us? |
|---|---|---|
| **Version string becomes 26H2** | **Settings > System > About**, and **winver** | **YES -- see 4.6** |
| File Explorer Copy dialog, Start menu, Taskbar, Settings > Apps > Startup | Reliability and dark-mode fixes | No |
| Virtualization | Fixes HYPERVISOR_ERROR (0x20001) and KMODE_EXCEPTION_NOT_HANDLED (0x1E) bugchecks | No |

---

## 3. REPORTED BUT NOT YET CONFIRMED -- DO NOT QUOTE THESE

**These surfaced in a search summary that aggregated across builds. I opened
three build pages looking for them and found none of them there.** They may be
real and in a build I have not read, or the summary may have misattributed them.
**Treat every line as *unverified*.**

- **Native Sysmon** -- system event monitoring built into Windows, custom
  config files, events to the Windows event log. *If true: not consumer-facing,
  no impact on Checkup.*
- **Secure Boot badges in Windows Security** -- *"green, yellow, and red icon
  badges and new text"* under **Windows Security > Device security > Secure
  Boot**. **If true this is the highest-impact item on the page for us** -- see
  4.7.
- **Privacy & security page redesign** -- new header with an entry point to the
  Windows Security app, and at-a-glance detail for location, camera and
  microphone. **If true it changes screenshots and click paths in the guide.**
- **FAT32 command-line format limit raised from 32GB to 2TB.** No impact.
- **Point Indicator accessibility setting resumed.** No impact.
- **Feedback Hub refresh**, single unified template. No impact.

**Each is one page-read away from being settled.** They are listed rather than
dropped so the next session does not re-derive them from scratch.

---

## 4. IMPACT -- CHECKUP, THE GUIDE, THE WEBSITE

### 4.1 Search indexing auto-expansion -- a NEW privacy setting Checkup does not cover
**Settings > Privacy & security > Search.** Windows will widen what it indexes
on its own, from your activity.

- **Checkup has nineteen settings, frozen, and none of them is this one.**
- It belongs in **`FutureSettings`**, not ascii44. **Nineteen settings are
  frozen and this is not a launch blocker.**
- **The honest position for launch:** the guide already tells the reader Checkup
  covers nineteen named things. It does not claim to cover everything Windows
  will ever add. **No copy is made wrong by this.**

### 4.2 Windows Spotlight on the lock screen
Directly adjacent to today's lock-screen widget work
(`GatewayGuard_FieldResult-LockScreenWidgets-2026-08-26-1030.md`).

- ***measured this morning on CGDELL:*** `RotatingLockScreenOverlayEnabled` is
  **absent** while its feature is visibly **on**, having measured **1** two days
  earlier. **The lock-screen value set is already moving underneath us**, and
  26H2 touches the same component.
- **Consequence: any check reading this family must treat absent as UNKNOWN.**
  That rule was written from a CGDELL measurement. This is a second reason for
  it.

### 4.3 Adaptive hibernate policy
Checkup's power settings (the `powercfg` block -- **34 external calls, gate 24
baseline**) advise on sleep and screen-off behaviour.

- ***measured on SANDY, `SandyChecks-SANDY-2026-08-26_11-14.txt`:*** the
  existing screen-off finding reads *"Found: NEVER (your existing setting)"*.
- **26H2 changes when Windows hibernates, not what `powercfg` reports.** No
  Checkup change indicated. **Worth one line in the guide's battery section if
  a reader asks why their laptop now behaves differently below 10%.**

### 4.4 Settings app search ranking
The guide sends readers to Settings pages by name. **Improved search ranking can
only help.** No action.

### 4.5 Widgets -- animated taskbar icons
More visually insistent widget content on the taskbar entry point.

- **Setting 14 is already being rebuilt** as a three-way, and today's field
  result moved the lock-screen third from MAYBE to **YES, proven**.
- **This strengthens the case for the setting, and it is guide material, not
  build material.** The taskbar third is still **NO -- no per-user route**
  (*measured:* `TaskbarDa` write refused; only the machine-wide `Dsh` policy).

### 4.6 The version string changes to 26H2 -- CHECKED, AND CHECKUP IS IMMUNE

**This was written up as "the one that can break something mechanically." It
cannot. Measured, not assumed.**

***measured on the ascii43 source, 2026-08-26:*** the build contains **zero**
reads of `DisplayVersion`, `CurrentBuild`, `BuildNumber`, `OSVersion` or
`Get-ComputerInfo`, and **no comparison against any version string** -- no
`22H2`, `23H2`, `24H2`, `25H2` or build number anywhere in 9,002 lines.

**The only OS branch in the whole tool is EDITION, and it is read once:**

```
line 3539   $caption = (Get-WmiObject Win32_OperatingSystem -EA Stop).Caption
line 3567   $isHome = $global:WinEdition -notmatch "Pro|Enterprise|Education|Business"
```

That idiom repeats at lines 5788, 6288, 7774 and drives `SkipOnHome`, the
Remote Desktop message, and the BitLocker/Device Encryption path.

**26H2 does not change edition names.** A Home machine's `Caption` stays
*"Microsoft Windows 11 Home"* -- ***measured on SANDY,***
`SandyChecks-SANDY-2026-08-26_11-14.txt`, which reports edition
**"Microsoft Windows 11 Home"** on build 26200.9168.

**Conclusion: the 26H2 version flip cannot break Checkup's logic.** The risk
this section was opened for does not exist. **What remains is copy, not code**
-- if a screen or the guide ever prints a version number, it would go stale, and
***measured:*** none does. The 19 website pages promise **"Windows 11 Home and
Pro"** and no version.

**One residual worth knowing, not worth acting on:** the edition test is a
negative match. A future edition whose name contains none of
`Pro|Enterprise|Education|Business` would be treated as Home. That is correct
behaviour for every edition Microsoft currently ships.

### 4.7 Secure Boot badges -- IF confirmed, the biggest one here
**Unverified (section 3).** If Windows Security starts showing green / yellow /
red badges and new text for Secure Boot:

- **The guide's Secure Boot steps describe a screen that would have changed.**
- CLAUDE.md records CGDELL as having **Secure Boot off** -- so this is a state
  the reader will actually meet, in colour, with wording we did not write.
- **D-18 applies: the guide must use the label on the user's own screen.** New
  badges mean new labels.
- **Settle this before the guide's Secure Boot section is final.**

---

## 5. WHAT TO DO, IN ORDER

1. ~~Grep the build for Windows version comparisons (4.6).~~ **DONE 2026-08-26 --
   Checkup never compares versions. It branches on EDITION only. No action.**
2. **Confirm or kill the three unverified items** in section 3 -- Secure Boot
   badges first, since it is the only one that reaches the guide.
3. **Get the PCMag list from Bill** (section 0) so the original request can
   actually be completed.
4. **File search-indexing auto-expansion into `FutureSettings`.** Not ascii44.

**None of this blocks the ascii43 field run on SANDY, and none of it unfreezes
the nineteen settings.**
