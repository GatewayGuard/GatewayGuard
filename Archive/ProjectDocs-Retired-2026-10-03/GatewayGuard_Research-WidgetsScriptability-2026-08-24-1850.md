<!-- Dated: 2026-08-24 18:50 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# The two "probably nots", researched -- and one of them killed my own recommendation

- **Document Name:** GatewayGuard_Research-WidgetsScriptability
- **Last Modified:** 2026-08-24 18:50 ET
- **Question, Bill 2026-08-24:** *"research the two probably nots"*
- **Amends:** `GatewayGuard_WidgetsThreeWayChoice-2026-08-24-1745.md`, whose
  **central build recommendation is now withdrawn**
- **Status:** Both answered. **One test outstanding that only Bill can run, and
  it takes twenty seconds.**

---

## THE HEADLINE -- I RECOMMENDED SOMETHING THAT CANNOT BE DONE

This morning I told Bill that setting 14 should stop writing the machine-wide
policy and **write the per-user value `TaskbarDa` instead**. I recommended it
without testing it.

***measured 2026-08-24 on CGDELL, elevated:***

```
Set-ItemProperty ...\Explorer\Advanced -Name TaskbarDa
  -> Attempted to perform an unauthorized operation.
```

**`TaskbarDa` cannot be written. The recommendation is withdrawn.**

**And it is the value specifically, not the key.** *measured, three ways:*

| Test | Result |
|---|---|
| Write a new test value in the same key | **OK** |
| Rewrite `TaskbarSn` (the search box) to its own value | **OK** |
| Read the key's ACL | `CGDELL\willi` has **FullControl** |
| Write `TaskbarDa` | **Unauthorized operation** |

So Windows applies a protection to that one value. The forum claim I found --
*"they still exist in the registry but no longer act as writable switches...
the Shell enforces the UI state at runtime"* -- **is correct, and I would have
shipped a defect if I had not tested it.**

**This is the FT-162 shape exactly**: a plausible mechanism, written into a
build, that silently does nothing while the log says it worked.

---

## PROBABLY-NOT #1 -- THE DISCOVER FEED: **CONFIRMED, NO SCRIPTED ROUTE**

**Nothing found, and the old route is gone.**

*sourced:* the historical control was
`HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds\ShellFeedsTaskbarViewMode = 2`
-- the Windows 10 "News and Interests" setting.

***measured on CGDELL:*** the `Feeds` key exists but contains **only
`EdgeMUID`**. **`ShellFeedsTaskbarViewMode` is absent.** That control does not
exist on this build.

**The only registry control that works is the wrong one.**
`HKLM\SOFTWARE\Policies\Microsoft\Dsh\AllowNewsAndInterests = 0` disables
**Widgets entirely** -- the whole feature for every user. It cannot turn off the
feed while keeping the weather, which is exactly what path (b) needs.

**Conclusion: path (b) is show-the-steps. There is no way for Checkup to do it.**

That is not fatal. The steps are four clicks and they are the same on Home and
Pro. **But the page and the tag line must say Checkup shows you this rather than
does it** -- the `CanAuto` honesty that Tamper Protection taught us.

---

## PROBABLY-NOT #2 -- THE LOCK SCREEN: **BETTER NEWS, WITH A CAVEAT THAT MATTERS**

**I was wrong to say "no registry value found". There is one, and it writes.**

***measured on CGDELL:***

```
HKCU\Software\Microsoft\Windows\CurrentVersion\Lock Screen
  LockScreenWidgetsEnabled  (DWORD)
```

Absent by default here. **I created it as 0, read it back as 0, and removed it
again** -- the machine is exactly as it was. **The value can be written, without
elevation, per user.**

**And there is now an official policy**, *sourced:* **"Disable Widgets On Lock
Screen"**, under Computer Configuration → Administrative Templates → Windows
Components → **Widgets**. It was added specifically so administrators could
turn off lock-screen widgets **without** disabling Widgets everywhere else --
which is precisely the distinction path (b) needs.

**Two more values, both writable** *(measured, rewritten to their own values
without error)*:

| Value | Current on CGDELL | What it is |
|---|---|---|
| `RotatingLockScreenEnabled` | 0 | Windows Spotlight itself |
| `RotatingLockScreenOverlayEnabled` | 1 | the "fun facts, tips, tricks" promos |

### THE CAVEAT, AND IT IS THE WHOLE REASON THIS IS NOT SETTLED

**Writable is not the same as effective.**

*sourced, and it is a direct warning:* the CSP for disabling lock-screen widgets
**was Insider-only at one point, and the policy did not work on stable release
builds.** So a value that accepts a write may still be ignored by the lock
screen.

**Writing a setting that Windows ignores, and reporting success, is FT-162
again** -- `MpCmdRun -ScanType 4` accepted the command line, returned in 0.0
seconds, did nothing, and the log printed `[GOOD]` for months.

**I will not put `LockScreenWidgetsEnabled` in a build on the strength of it
accepting a write.**

### THE TEST THAT SETTLES IT -- TWENTY SECONDS, AND ONLY BILL CAN DO IT

I can write the value. I cannot see the lock screen.

1. Note what the lock screen shows now -- *measured: CGDELL's **Lock screen
   status** is set to **"Weather and more"**, so it should be showing weather
   and feed content.*
2. Set `LockScreenWidgetsEnabled = 0`.
3. Press **Windows key + L**.
4. **Look. Is the weather-and-more content gone?**

**If yes**, path (a) gets a real automated step and Checkup can protect the
lock screen. **If no**, the value is decorative and the guide shows the manual
steps instead.

**Say the word and I will write it, lock the screen for you, and put it back
either way** -- it is one per-user value and removing it restores the current
state exactly.

---

## WHERE THIS LEAVES SETTING 14

**The three-way choice still stands as a design. What changes is how much of it
Checkup can perform.**

| | Checkup can do it? | Basis |
|---|---|---|
| **Widgets on/off** | **NO per-user route.** Only the machine-wide `Dsh` policy | **measured** -- `TaskbarDa` write refused |
| **Discover feed off** | **NO** | **measured** -- old value absent, no replacement found |
| **Lock screen widgets off** | **MAYBE** -- writable, effect unproven | **measured** writable; **sourced** caution that it may be ignored |
| **"Fun facts" promos off** | **YES** | **measured** writable |

### AND THAT REOPENS THE QUESTION I THOUGHT I HAD CLOSED

I said the machine-wide policy was the problem and the per-user value was the
fix. **The per-user value does not exist as an option.** So setting 14's real
choice is:

- **Keep the machine-wide policy** -- it works, but it changes Widgets for
  every account on the PC and greys out the switch our own instructions name.
  **The dead end is inherent, not a bug we can fix.**
- **Stop changing it programmatically at all, and show the steps** -- four
  clicks, per user, no side effects on anyone else, and the revert instructions
  we already publish become true.

**My recommendation is now the second one, and it is the opposite of what I
said this morning.** Widgets is a preference, not a security control; the whole
research finding is that its risk is an advertising surface. **A preference is
exactly the kind of thing to show someone how to change rather than change for
them across every account on their computer.**

**That also makes setting 14 consistent with itself for the first time:** the
page, the manual steps, the Revert string and what Checkup actually does would
all describe the same four clicks.

---

## WHAT I GOT WRONG TODAY, AND WHY IT KEEPS HAPPENING

**Two recommendations in one day that a ten-second test would have killed:**

1. *"Switch setting 14 to `TaskbarDa`"* -- the value is protected.
2. *"No registry value found for the lock screen"* -- there is one, and it
   writes.

**Both were confident, both were about mechanisms, and neither was tested
before it was written down.** The rule in CLAUDE.md covers claims about state;
these were claims about **what is possible**, which feel like reasoning rather
than assertion and slip past the same guard.

**The version of the rule that would have caught both: if a recommendation
names a registry value, a cmdlet or a flag, run it before recommending it.**
Not "verify the claim" -- *run the thing*. Both of today's errors would have
died in one command.
