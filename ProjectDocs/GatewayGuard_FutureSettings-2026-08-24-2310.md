<!-- Dated: 2026-08-24 23:10 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Future additions to Checkup -- the standing candidate list

- **Document Name:** GatewayGuard_FutureSettings
- **Last Modified:** 2026-08-24 23:10 ET
- **Created because:** Bill, 2026-08-24 -- *"they are out and add them and any
  new other new possible settings to future additions to our checkup."*
- **Authority for the freeze:** `GatewayGuard_Decision-NoNewSettings-2026-08-24-2255.md`
- **Status:** **THE LIST. Add to it; do not start another one.**

---

## THE RULE THIS LIST EXISTS UNDER

**Checkup ships with nineteen settings. Nothing is added before launch.**
Anything found worth adding lands here, with its evidence, and is considered
for a future update.

**Nothing on this list is in the product.** A candidate here is a candidate, not
a commitment.

---

## HOW TO USE THIS LIST -- READ BEFORE ADDING

**Every entry carries four things**, and an entry missing them is not ready to
be judged later:

1. **Where it came from** -- the item number, the field report, the session.
2. **The evidence**, labelled *measured* / *sourced* / *inferred* / *guess*.
3. **Can Checkup actually do it?** A setting Windows will not let a program
   change is a guide entry, not a Checkup setting.
4. **Why it is not in today.** Timing, merit, or blocked.

**REJECTED ENTRIES STAY ON THE LIST, MARKED REJECTED.** Deleting them is how a
settled question gets re-raised six months later by whoever notices it missing
-- which is exactly what happened with the multi-year pre-pay question, asked
and answered twice.

---

## CANDIDATES -- WORTH ADDING, NOT ADDED

### C-1. Cloud protection *(Microsoft Defender)*

- **From:** Q4, item 5. **Bill answered *"Add them"* on 2026-08-24**, then froze
  the count the same evening. **Out on timing, not merit.**
- **Evidence:** *sourced, Microsoft Defender full scan best practices* -- the
  recommended configuration is *"quick scan together with always-on real-time
  protection and cloud protection."* **Microsoft treats the three as a set,
  and Checkup already does two of them.**
- **Can Checkup do it?** *not measured.* `Set-MpPreference -MAPSReporting` is
  the likely route. **Run it before committing to it** -- today produced two
  recommendations that a ten-second test killed.
- **Priority: highest on this list.** It is the missing third of a
  Microsoft-recommended trio the product already half-implements.

### C-2. Automatic sample submission

- **From:** Q4, item 5. Same answer, same reversal.
- **Evidence:** documented alongside cloud protection; the two are configured
  together.
- **Can Checkup do it?** *not measured.* Likely
  `Set-MpPreference -SubmitSamplesConsent`.
- **Note the tension, and it must be resolved before this ships:** sample
  submission **sends files to Microsoft**. That is the same objection
  GatewayGuard raises against the phishing-protection content-collection
  checkbox (see R-2). **Adding one while warning about the other needs a
  reason that survives a reader noticing both.**

### C-3. Lock screen status -- automate it

- **From:** M-3, 2026-08-24.
- **Evidence:** ***measured*** -- **both test machines are set to "Weather and
  more"**, which puts news and adverts on the lock screen **before sign-in**,
  and neither was set that way deliberately. **Checkup does nothing about it
  today.**
- **Can Checkup do it?** **Unknown, and there is a lead.** *measured:*
  `LockScreenWidgetsEnabled` (HKCU DWORD) **accepts a write**. *sourced:* an
  official Group Policy **"Disable Widgets On Lock Screen"** now exists. **But
  writable is not effective** -- a sourced caution says the CSP did not work on
  stable builds. **One twenty-second test settles it: set the value, press
  Win+L, look.**
- **For launch:** the steps go in the guide and on the page, inside setting 14.
  **Automating it is the future candidate.**

### C-4. Windows Update -- "Notify me when a restart is required"

- **From:** Q8 / item 23. **Bill deferred the whole area** with his own
  reasoning, 2026-08-24.
- **Evidence:** *measured on CGDELL* -- `RestartNotificationsAllowed2 = 1`,
  which is already the Windows default. **Of the three Advanced options, this
  is the only one worth recommending.**
- **Can Checkup do it?** *measured writable* in the same key family.
- **Priority: low.** It is already on by default, so the setting would confirm
  rather than change. **That is a thin reason to spend a slot.**

### C-5. Widgets -- change it per user instead of machine-wide

- **From:** setting 14 review, 2026-08-24.
- **Evidence:** ***measured*** -- writing `TaskbarDa` throws *"Attempted to
  perform an unauthorized operation"* **even elevated**, while the same key
  accepts other values and the ACL grants FullControl. **Windows protects that
  one value.**
- **Can Checkup do it?** **No, today.** **BLOCKED ON WINDOWS**, not on us.
- **Why it is still listed:** if Microsoft ever exposes a supported per-user
  route, setting 14 should take it. **Bill's decision to keep the machine-wide
  policy stands and is correct while this is blocked** -- an administrator
  deciding for their own PC, with an approval screen.

### C-6. Widgets -- turn the Discover feed off automatically

- **From:** path (b) of the three-way choice, 2026-08-24.
- **Evidence:** ***measured*** -- the historical control
  (`ShellFeedsTaskbarViewMode`) **is absent**; the `Feeds` key holds only
  `EdgeMUID`. The only working registry control disables Widgets **entirely**,
  which is the opposite of what path (b) needs.
- **Can Checkup do it?** **No route found.** **BLOCKED ON WINDOWS.**
- **For launch:** four clicks, shown to the user. **It works; it just is not
  automatic.**

---

## REJECTED -- DECIDED AGAINST, KEPT SO THEY ARE NOT RE-RAISED

### R-1. Advanced firewall settings, especially inbound rules

- **From:** Q6, item 10.
- **BILL, 2026-08-24: *"Forget about it."*** **Closed.**
- **The reasoning, kept because it is good:** inbound rules are where a
  non-technical user locks themselves out of their own network, and the three
  profiles being On is the 95% win. **Do not re-open without a new reason.**

### R-2. Reputation-based protection -- the fourth item

- **From:** item 15.
- **What it is:** *"Automatically collect website or app content when
  additional analysis is needed to help identify security threats."*
- **REJECTED as a setting. Explained on the page instead.**
- **Evidence:** *sourced, Microsoft* -- it collects *"the content displayed,
  sounds played, and application memory"*, and its default is **Enabled for
  domain-joined and MDM devices, Disabled for all other devices**. **Microsoft
  ships it off for our audience.** Recommending it on would contradict a
  product that turns off the Advertising ID and caps Diagnostic data.

### R-3. Windows Update -- "Get me up to date"

- **From:** Q8.
- **REJECTED.** It restarts the PC as soon as possible after an update,
  **overriding active hours**, and delivers feature updates earlier. **A PC
  that restarts itself outside active hours is exactly the surprise this
  audience must not get**, and it does not improve security -- quality updates
  arrive on the same schedule either way.

### R-4. Windows Update -- "Download updates over metered connections"

- **From:** Q8. *measured on CGDELL: currently **On**, which is not the Windows
  default.*
- **REJECTED as a recommendation, because it is a genuine trade-off with no
  single right answer.** Off protects a data allowance; on means a laptop that
  only ever sees a hotspot still gets patched. **Explain it in the guide; do
  not decide it for them.**

---

## NOT ON THIS LIST, AND DELIBERATELY

**Defects in the existing nineteen are not future settings.** They are F6 work
and they belong in the build plan:

- **Setting 1** cannot see paused updates. *measured:* nothing in the build
  reads `PauseUpdatesExpiryTime`, so it can report Windows Update healthy on a
  machine unpatched for weeks.
- **Setting 14's Revert string** at line 6830 names a route the policy write
  makes impossible.
- **Setting 6's name** -- *"Edge Phishing Protection"* -- describes the wrong
  feature.
- **F4's full scan**, now decided: run it with approval.

**The distinction matters.** A frozen count does not freeze fixes, and filing a
defect here would quietly turn a bug into a feature request.

---

## WHAT THE CUSTOMER IS TOLD

Approved wording, from the no-new-settings decision:

> **More settings are coming.** Checkup covers nineteen settings today. There
> are others we are still testing, and we will not add one until we are
> confident it helps and cannot cause you a problem. When a setting earns its
> place, it arrives in the yearly update along with an explanation of what it
> does and why.

**This list is what makes that sentence true rather than a promise.**
