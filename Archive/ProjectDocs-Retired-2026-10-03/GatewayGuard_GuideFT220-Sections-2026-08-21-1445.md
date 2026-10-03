<!-- Dated: 2026-08-21 14:45 ET -->
<!-- Editor: Claude Cloud -->
# Guide — the four FT-220 settings, verified and strengthened

- **Document Name:** GatewayGuard_GuideFT220-Sections
- **Last Modified:** 2026-08-21 14:45 ET
- **Last Editor:** Claude Cloud
- **Status:** Drop-in sections for `GatewayGuard_GuideRewrite-Draft-2026-08-19-1753.md`.
  **Not a rewrite.** The draft stands; these replace or extend four parts of it.
- **Answers:** `GatewayGuard_CloudRequest-GuideRewrite-2026-08-21.md`
- **Unblocks:** FT-220, which is ascii44 scope gated on the guide
  (`GatewayGuard_ascii43BuildPlan-2026-08-21.md`, section 6)

**Change History Log:**
- 2026-08-21 14:45: Created. Written against freshness stamp `58e7ee0`.
  **Section 6 lists eleven claims that must be measured on a live Windows 11
  machine before this ships.** They are marked *VERIFY* in the copy itself.

---

## 1. WHAT WAS FOUND IN THE DRAFT

Read from `GatewayGuard_GuideRewrite-Draft-2026-08-19-1753.md`, not from memory.

| Setting | What the draft already has | What FT-220 asks for and the draft does not say |
|---|---|---|
| **9** Windows Hello | The PIN-versus-password explanation, and it is good: a PIN only works on this PC, a password works from anywhere | **Why a Microsoft account comes into it at all, and what is worse on a local account.** The draft tells the reader to turn on *"only allow Windows Hello sign-in for Microsoft accounts"* and never says why |
| **12** Diagnostic Data | Little. The website page carries the substance | **What Windows actually sends on the default**, and why the default is a problem rather than a taste |
| **13** Edge Startup Boost | Present, framed as a memory and speed item | **What is running when the reader believes Edge is closed** |
| **17** Password on Wake | One paragraph, and it is the right paragraph | Depth, and no guide reference exists in the tool — FT-226 |

**The setting 9 gap is the one Bill reported in the field**, word for word:
*"Does not explain here or in the guide why they should do this, why they need
to use the MS account, and why not using the MS account is bad."*

---

## 2. SETTING 9 — WINDOWS HELLO

**Where it goes:** Phase 1, in the sign-in section, immediately after the
existing *"Keep your password as a fallback"* line and **before** the
*"At the bottom of the screen"* instruction. Everything already in the draft
stays.

---

### Why a Microsoft account comes into this

**Setting up a PIN does not require a Microsoft account.** *VERIFY.* A PIN
works on a computer that uses a local account. When you create the PIN,
Windows asks for your account password first — that is a one-time identity
check, not a sign-up.

**The Microsoft account matters for one thing: getting back in.**

**If you forget your PIN.** With a Microsoft account, you prove who you are
from your phone and set a new one. On a local account, there is nobody to
prove yourself to. If you have also lost the account password, there is no
reset link and no phone number to call.

**If the drive is encrypted — setting 8.** Encryption keeps a stranger out of
your files. The recovery key is what lets *you* back in after a repair, a
hardware change, or an update that unsettles the computer. A Microsoft account
keeps a copy of that key on your account page. A local account keeps a copy
nowhere at all — only where you personally saved it. **If you saved it
nowhere, and the computer asks for it, the files are gone.** Not "call
somebody" gone. Gone.

### The trade-off, said plainly

A Microsoft account means Microsoft holds a copy of your recovery key and knows
this computer is yours. **That is a real cost and some people will not want to
pay it.** A local account keeps everything on your desk and gives you no safety
net.

**Neither choice is wrong.** What goes wrong is choosing the local account and
never writing the recovery key down.

**If you stay on a local account, do these two things today:**

1. **Print the BitLocker recovery key** and put the paper somewhere you would
   look for an insurance policy — not in a drawer beside the computer.
2. **Write the account password down** and keep it in the same place. On a
   local account it is the only way in.

> **A note on the last option on this screen.** *VERIFY.* Near the bottom you
> may find **For improved security, only allow Windows Hello sign-in for
> Microsoft accounts on this device**. On a computer that uses a Microsoft
> account, turn it on with your permission. **On a local account this option
> may be greyed out or have no effect** — that is normal and nothing is wrong.

---

## 3. SETTING 12 — DIAGNOSTIC DATA

**Where it goes:** replaces the diagnostic-data passage in Phase 3 (the privacy
step) in its entirety.

---

### Diagnostic Data — Required only

**Windows sends information about itself back to Microsoft. There are two
levels, and the computer arrives set to the larger one.**

**What the smaller level sends.** *VERIFY.* Basic facts about the machine, the
settings it is running, and reports when something goes wrong. Windows needs
this to deliver the right updates.

**What the larger level adds.** *VERIFY.* How you use apps and features, the
sites visited in Microsoft's own browser, and fuller crash reports — which can
carry a piece of whatever was on the screen when the crash happened.

**Your updates are identical either way.** Nothing on this computer works
better because the larger level is on.

### Why this is more than a preference

**Nobody is reading your day.** The point is smaller and more stubborn than
that: **a record exists.** A list of what you did on your own computer, held
somewhere you cannot see it, for as long as somebody decides to keep it.

**You were never asked.** The larger level was chosen for you when the
computer was set up, and it has been on since.

**A record that exists can be handed on** — to a company that buys another
company, or to whoever asks with the right piece of paper. Turning the setting
down does not erase what is already there. It stops the list getting longer.

**GatewayGuard Checkup can make this change for you, with your permission.**
It takes a moment and needs no restart.

> **Do it by hand:** press the **Windows key**, type **Diagnostics & feedback**,
> press **Enter**, and under **Diagnostic data** choose **Required diagnostic
> data**.

---

## 4. SETTING 13 — EDGE STARTUP BOOST AND BACKGROUND RUNNING

**Where it goes:** replaces the Edge Startup Boost passage in Phase 2, Step 6.

---

### What is running when you think Edge is closed

**Closing the browser window does not always close the browser.**

Two settings arrive turned on:

- **Startup Boost** loads part of Edge when Windows starts — **even on days you
  never open it.**
- **Continue running background apps** keeps part of Edge alive after you close
  the last window.

**Why that is more than wasted memory.** Anything still running is still
working. Add-ons keep running. Sync keeps going. A page you left open can keep
loading on its own. **And an add-on you did not mean to install keeps doing
whatever it does, on a computer you believe is idle.**

**The honest cost of turning both off:** Edge opens a second or two slower.
That is the whole of it.

**This one is your decision** — Checkup asks and does not change it without
your permission.

> **Do it by hand:** open Edge, click the three dots (⋯) at the top right,
> click **Settings**, then **System and performance**. Turn off **Startup
> boost** and turn off **Continue running background extensions and apps**.
> *VERIFY the exact wording of the second one.*

---

## 5. SETTING 17 — PASSWORD REQUIRED ON WAKE

**Where it goes:** replaces the existing *"Password Required on Wake — setting
17"* paragraph. The existing text is kept and built on.

---

### Password Required on Wake — setting 17

On the same **Sign-in options** screen, near the top, find **If you've been
away, when should Windows require you to sign in again?** Set it to **When PC
wakes up from sleep**. **This one you set yourself; Checkup cannot set it for
you.**

**Why it matters.** Closing the lid is how most people put a computer away.
**A sleeping computer is not an off computer.** It is on, you are still signed
in, and everything you had open is still open. If it wakes straight to your
desktop, then the only thing protecting your email, your bank tab and your
files is the room the computer is sitting in.

**That room is not always your room.** A repair shop. A hotel. A car. A house
with a new roof crew in it. **The one place a laptop is most likely to be
opened by a stranger is the place you were not standing.**

With this set, waking the computer asks for the PIN — which takes about two
seconds and is the entire cost.

> **Sleep and hibernate are not the same thing**, and hibernate is the safer of
> the two on an encrypted computer. *VERIFY against Microsoft's own
> documentation before this line ships* — it is a claim about how Windows
> handles the encryption key in memory, and gate 24 applies.

---

## 6. WHAT MUST BE MEASURED BEFORE THIS SHIPS

**Eleven claims, all marked *VERIFY* above.** None is written from a source
Cloud can cite, and every one is a claim about how Microsoft's software
behaves. **This is Claude Code's work on a live Windows 11 machine**, and it
belongs on the schedule rather than in a closing sentence — the same point
`GatewayGuard_ReviewOfCloudDrafts-2026-08-18.md` made about the other nineteen.

1. A Windows Hello PIN can be created on a local account.
2. Windows asks for the account password once at PIN creation.
3. A Microsoft account can reset a forgotten PIN from another device.
4. A local account cannot, without the account password.
5. BitLocker recovery keys are saved to a Microsoft account automatically, and
   are not saved anywhere automatically on a local account.
6. The behaviour of **only allow Windows Hello sign-in for Microsoft accounts
   on this device** on a machine using a local account — greyed out, or present
   and inert.
7. What Required diagnostic data sends.
8. What Optional adds, specifically the browsing and crash-content claims.
9. Updates are unaffected at either level.
10. The exact current label of Edge's background-apps setting.
11. The sleep-versus-hibernate claim about the encryption key in memory.

**Items 5 and 11 are the two that would do real harm if wrong.** Item 5 tells a
reader their files are unrecoverable; item 11 gives security advice about
closing a lid.

---

## 7. TWO THINGS THIS CREATES ELSEWHERE

**RULE W-07 collision, and it is not optional to resolve.** The free website
page `WebSite/html/diagnostic-data.html` says *"This is a privacy preference,
not a security requirement... your PC is not less secure either way."*
`widgets.html` says the same of setting 14. **Section 3 above argues the
opposite.** The guide and the site cannot both be right in front of the same
reader. **Cloud's recommendation: the page moves to the guide's position** —
the current page shrugs at a setting the product changes, which reads as the
product not believing its own advice.

**FT-226 — setting 17 has no guide reference in the tool.** That is a data fix
in the settings table and does not wait on this document; the build plan
already puts it in ascii43. This document supplies the text it should point to.
