<!-- Dated: 2026-09-25 15:03 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Firefox Addendum -- standalone draft, for Bill's live test

- **Document Name:** GatewayGuard_FirefoxAddendum-Draft
- **Dated:** 2026-09-25 15:03 ET
- **Editor:** Claude Code (CGDELL)
- **Status:** DRAFT. **NOT part of the 2026-10-15 guide** -- Bill,
  2026-09-25: *"make the firefox changes and then i will test it. keep it out
  of the guide."* It can go back in a later guide revision once every step
  has been checked on a real copy of Firefox.
- **Source:** `GatewayGuard_GuideRewrite-Draft-2026-08-22-1000.md`, lines
  1615-1760 (*Addendum -- Firefox*). The old draft is not changed.
- **Working document:** plain Markdown, used at the keyboard. Formatting
  standards for deliverables do not apply until it goes back into the guide.

## What changed from the old draft

| Step | Change | Why |
|---|---|---|
| F2 | Tracking Protection: **Standard**, not Strict. Strict mentioned as an option | Strict can stop some websites working, and a reader would not know why |
| F2, F7 | One plain line added under each technical label | The labels must stay (they are the words on Firefox's screen), but each needs to say what it does |
| F8 | Pointer changed from *Getting help* to *Part 4, Getting help* | The new guide structure (Part 4 outline, approved 2026-09-25) |
| F10 | Now matches guide **Setting 15**: turn password saving off **only if** you already use a separate password manager. "Move them to a password manager -- see Phase 5" removed | It told everyone to turn it off; Phase 5 no longer exists; no product names (Bill, 2026-09-25) |
| F12 | **Removed** | It named a Mozilla add-on; no product names. It was optional and nothing depended on it |
| Table | Updated to match | -- |

## How to test it

1. Install Firefox on the test machine.
2. Work through F1 to F11 below. **Read each bold label on your screen.**
3. Under each step, fill in the **Bill's check** line: *Yes* if every label and
   location matches, or write down exactly what the screen says instead.
4. Note the Firefox version: open the menu (three lines, top right) > Help >
   About Firefox.

**Firefox version tested:** ______  **Machine:** ______  **Date:** ______

---

# Addendum -- Firefox

**Skip this whole section if Firefox is not on the computer.** Checkup does
not check or change anything in Firefox. This section is here so you can do
it yourself.

Firefox arranges its settings differently from Edge and Chrome, so it gets its
own pages. **Every step below starts the same way:** click into the address bar
at the top of Firefox, paste the address given, and press Enter.

> **⚠ VERIFY -- the whole addendum, before it goes back into the guide.**
> None of the labels or locations below has yet been read off a live copy of
> Firefox. They come from an earlier source guide.

### F1 -- Extensions

Paste `about:addons` and press Enter, then click **Extensions** on the left.

**Every extension should be one you chose deliberately.** Remove anything
called *Coupon*, *Shopping helper*, *Search helper*, *Wave* or *Shift*,
anything from a maker you have never heard of, and anything you do not
recognize.

**Click Themes and Plugins as well.** The same rule applies.

*Bill's check:* ______________________________

### F2 -- Tracking protection and dangerous sites

Paste `about:preferences#privacy`.

- **Enhanced Tracking Protection** should be set to **Standard**. It stops
  many websites from following you from one site to the next. **Strict**
  blocks more, but some websites stop working properly with it; choose it
  only if you are comfortable turning it back to Standard when a site
  misbehaves.
- Scroll to **Deceptive Content and Dangerous Software Protection**. **All four
  boxes should be ticked.** If any is unticked, tick it. These warn you before
  you open a site or a download that is known to be dangerous.
- Scroll to **HTTPS-Only Mode** and turn it on **in all windows**. This makes
  Firefox use the secure version of every website, and warns you before
  opening one that has no secure version.

*Bill's check:* ______________________________

### F3 -- Search engine

Paste `about:preferences#search`.

**The default should be a name you know** -- Google, Bing, DuckDuckGo, or
similar. **Not** *myway*, *search-redirect*, or anything unfamiliar.

Below it, remove unfamiliar entries from the list of other search engines.

**Optional:** turn off **Provide search suggestions** if you would rather your
typing did not go to the search engine as you type.

*Bill's check:* ______________________________

### F4 -- Stop Firefox reopening yesterday's tabs

Paste `about:preferences`. Under **Startup**, **Open previous windows and
tabs** should be **unticked**.

**Optional:** untick **Always check if Firefox is your default browser** to
stop the reminder appearing, if you have decided not to use Firefox as your
main browser.

*Bill's check:* ______________________________

### F5 -- Data collection

Paste `about:preferences#privacy` and scroll to **Firefox Data Collection and
Use**. **Untick all three:**

- Allow Firefox to send technical and interaction data to Mozilla
- Allow Firefox to install and run studies
- Allow Firefox to send backlogged crash reports on your behalf

*Bill's check:* ______________________________

### F6 -- Sponsored content

Paste `about:preferences#home` and untick **Recommended by Pocket**,
**Sponsored stories**, and **Sponsored shortcuts**.

Then paste `about:preferences#search` again and untick **Show search
suggestions from sponsors** if it is there.

*Bill's check:* ______________________________

### F7 -- Encrypted address lookups

Paste `about:preferences#privacy` and scroll to the bottom, to **DNS over
HTTPS**.

When you type a website's name, your computer first looks up where that
website is. This setting keeps those lookups private, so your internet
provider cannot see which websites you are asking for.

**Increased Protection** is the setting to choose.

**Max Protection stops you reaching websites** at all if the private lookup
is unavailable. Choose it only if you want that.

*Bill's check:* ______________________________

### F8 -- Profiles

Paste `about:profiles`.

**There should be one profile**, or only ones you created yourself. **If you
see one you do not recognize, do not remove it yet** -- write down where it says
it is stored and turn to *Part 4, Getting help*. A second profile is one of the
ways this kind of program hides.

*Bill's check:* ______________________________

### F9 -- Updates

Paste `about:preferences#general` and scroll to **Firefox Updates**.

**Automatically install updates** should be **on**. Leave it on.

**Optional, on a computer with 8 GB of memory or less:** untick **Use a
background service to install updates**. Updates still install -- they install
when Firefox is open instead of in the background.

*Bill's check:* ______________________________

### F10 -- Passwords saved in Firefox

Paste `about:preferences#privacy` and scroll to **Logins and Passwords**.

**If you already use a separate password manager**, untick **Ask to save
logins and passwords for websites**, so your passwords are kept in one place.

**If you do not use a separate password manager, leave it ticked.** Letting
Firefox save your passwords is safer than reusing the same password or
writing them down. This matches guide Setting 15.

Click **Saved Logins** to see what is already stored.

*Bill's check:* ______________________________

### F11 -- If Firefox feels slow

- `about:performance` -- shows which tab or extension is doing the work.
- `about:memory` -- click **Measure** for a detailed breakdown.
- `about:support` -- the page to show somebody who is helping you.

*Bill's check:* ______________________________

### Firefox at a glance

| Setting | Where | Should be |
|---|---|---|
| Open previous windows and tabs | `about:preferences` › Startup | Unticked |
| Enhanced Tracking Protection | `about:preferences#privacy` | Standard |
| Deceptive content protection, all four boxes | `about:preferences#privacy` | All ticked |
| HTTPS-Only Mode | `about:preferences#privacy` | On in all windows |
| Data collection, studies, crash reports | `about:preferences#privacy` | All unticked |
| Pocket and sponsored content | `about:preferences#home` | All unticked |
| Default search engine | `about:preferences#search` | A name you know |
| DNS over HTTPS | `about:preferences#privacy` | Increased Protection |
| Ask to save logins and passwords | `about:preferences#privacy` | Unticked only if you use a separate password manager |
| Background update service | `about:preferences#general` | Off, on 8 GB computers |
| Profiles | `about:profiles` | Only ones you know about |
