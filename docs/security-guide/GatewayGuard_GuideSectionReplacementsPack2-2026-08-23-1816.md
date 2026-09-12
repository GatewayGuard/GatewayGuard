<!-- Dated: 2026-08-23 18:16 ET -->
# Guide — drop-in section replacements, pack 2

- **Document Name:** GatewayGuard_GuideSectionReplacementsPack2
- **Last Modified:** 2026-08-23 18:16 ET
- **Last Editor:** Claude.ai (Cloud)
- **Machine:** CGDELL
- **Applies to:** `GatewayGuard_GuideRewrite-Draft-2026-08-22-1000.md`, **as it
  stands after pack 1** — 1,293 lines, Last Modified 2026-08-23 12:40 ET.
- **Sources:** `GatewayGuard_GuideGapFill-fromV9-2026-08-22-1224.md`, **uploaded
  into the chat and read in full**; plus two project-knowledge retrievals of
  `GatewayGuard_GuideV9-SourcePack-2026-08-15-1436.md` for source lines
  713–737, which the gap-fill does not carry — see section 2.
- **Status:** Drop-in replacements. **The draft is not rewritten.** Claude Code
  applies each block at the stated location and commits.
- **Written against freshness stamp:** `dd916d0`, generated 2026-08-23 12:47 ET.

**Change History Log:**

- 2026-08-23 18:16: Created. Closes **G3, G4, G5 and G6** — every remaining
  retrieval gap. Adds **three new VERIFY markers** and touches none of the
  existing twelve. Records one gap in the gap-fill itself (section 2) and four
  corrections made to the v9 text on the way in (section 11).

---

## 1. WHAT IS IN THIS PACK

| Block | Gap | Replaces | State |
|---|---|---|---|
| **G3-A** | Step 6 Parts B to H | Draft lines **691–709** | **CLOSED** |
| **G3-B** | Phase 3 Step 3, residue | Draft lines **792–798** | **CLOSED** |
| **G4-A** | Phase 5 in full, decision tree included | Draft lines **1146–1159** | **CLOSED** |
| **G4-B** | Advanced — optional | Draft lines **1168–1171** | **CLOSED** |
| **G5** | Firefox addendum F1–F12 | Draft lines **1241–1244** | **CLOSED** |
| **G6-A** | Glossary | Draft lines **1250–1256** | **CLOSED** |
| **G6-B** | Index | Draft lines **1262–1264** | **CLOSED** as a build list |
| **Bookkeeping** | 0.2, 0.4 and *What must happen* | Section 10 | Applied |

**Every block below is a whole replacement for the marker blockquote at that
location.** Line numbers are given for convenience; **the anchor text quoted
with each block is the authority**, in case the file has moved under an edit.

**Nothing in this pack touches:** setting 11, the quick-reference table, the
eleven original VERIFY claims, setting 10's twelfth, or the `.html` pages.

---

## 2. THE DECISION TREE WAS NOT IN THE GAP-FILL, AND HOW IT WAS CLOSED ANYWAY

**Measured in the uploaded file.** G4a carries v9 source lines **681–712**.
G4b resumes at **747**. Source lines **713–746 are absent** — the *Quick
decision tree* (713–737) and *When to call for help* (738–746). The gap-fill's
own G4 note says of the tree: *"ALREADY IN SCOPE. Carry it, no decision
needed."* **The note is right and the extraction does not contain it.** That is
worth a line in the gap-fill's history, because the next reader of that file
will trust its line ranges the same way I did.

**I closed it from project knowledge, and completeness is provable rather than
assumed.** Two independent searches returned the block, overlapping, and both
of its boundaries are known from the gap-fill:

- **The line before it** is the last line of *Performance hygiene* — *"it's
  usually a leaked tab or extension"* — which is source line 712, the last line
  of G4a.
- **The line after it** is `## When to call for help`, source line 738.

Both anchors are present in the retrieved text, with the ten rows of the table
between them and nothing elided. **That is a bounded block, not a fragment**,
which is the distinction I refused to blur last time.

**The *When to call for help* material needs no block.** Its four missing
pieces were folded into *Getting help* by pack 1 and are in the draft now at
lines 1195–1224 — active-compromise signs, the fifty-item threshold, employer
IT, and the paragraph on being watched by a particular person. **Verified in
the uploaded draft, not assumed.** Nothing further is carried across.

---

## 3. BLOCK G3-A — Step 6, Parts B to H

**Location:** `GatewayGuard_GuideRewrite-Draft-2026-08-22-1000.md`, lines
**691–709**.
**Anchor — first line to delete:** `> ### ⧗ RETRIEVAL GAP G3 — Parts B to H`
**Anchor — last line to delete:** `> — disabling is reversible.**`
**It sits between** Part A's *"anything from a maker you have never heard of."*
and `### Part I — The browser's own password store`.

**Replace the whole blockquote with:**

```markdown
### Part B — The search engine your browser uses

**Chrome:** type `chrome://settings/searchEngines` into the address bar and
press Enter.

**Edge:** click the three dots at the top right, then **Settings**, then
**Privacy, search, and services**, and scroll to **Address bar and search**.
*VERIFY.*

**It should say Google, Bing, or DuckDuckGo** — a name you know.

**Treat these as findings:** *search-redirect*, *yahoo-search*, *myway*,
*ask.com*, or anything else you do not recognize. **A plain *Yahoo* entry is
the real thing and is fine.**

**If it is set to something unfamiliar**, change it back to one you know, then
look at the list of other search engines on the same page and remove the
unfamiliar entries.

### Part C — What opens when you start the browser

**Chrome:** type `chrome://settings/onStartup` and press Enter.

**Edge:** three dots › **Settings** › **Start, home, and new tabs**. *VERIFY.*

**Either of these is fine:** *Open the New Tab page*, or *Continue where you
left off*.

**This one is worth a look:** *Open a specific page or set of pages*, with an
address you do not recognize. **Remove that address.** If the page is one you
put there yourself, leave it.

**If a site keeps reopening every time you start the browser**, it is one of
three things:

1. **The tab is pinned.** Right-click the tab and choose **Unpin**.
2. **It is set as a startup page.** Remove it on this screen.
3. **An extension is opening it.** Go back to Part A.

### Part D — Stop the browsers restarting themselves

Edge and Chrome both keep pieces of themselves running after you close them,
and both can start when Windows starts. That is why the browser sometimes
seems to be open when you never opened it, and it is one of the reasons a
computer feels slow.

**Microsoft Edge:**

1. Open Edge, click the three dots at the top right, then **Settings**.
2. Click **System and performance** on the left — or type
   `edge://settings/system` into the address bar and press Enter.
3. **Startup boost** should be **off**. If it is on, turn it off.
4. **Continue running background extensions and apps when Microsoft Edge is
   closed** should be **off**. If it is on, turn it off.
5. Optional: **Save resources with sleeping tabs** can be turned **on**. It
   frees up memory and changes nothing else.
6. Close Edge completely.

**Google Chrome:**

1. Open Chrome, click the three dots, then **Settings**.
2. Click **System** on the left — or type `chrome://settings/system`.
3. **Continue running background apps when Google Chrome is closed** should be
   **off**. If it is on, turn it off.
4. Optional: type `chrome://settings/performance` and turn **Memory Saver**
   on. On a computer with 8 GB of memory or less, set it to **Maximum**.
5. Close Chrome completely.

**Mozilla Firefox**, if you have it:

1. Open Firefox, click the three lines at the top right, then **Settings**.
2. On the **General** page, under **Startup**, **Open previous windows and
   tabs** should be **unticked**.
3. Close Firefox completely.

**Chrome has nothing equivalent to Edge's Startup boost.** The background-apps
setting above is the only one of its kind in Chrome. **If Chrome still starts
by itself when Windows starts after you have done this, the cause is in
Windows rather than in Chrome — that is Part G.**

### Part E — Which browser Windows uses for links

Even with everything in Part D turned off, **Windows opens Edge** when you
click a link from Start menu search, the Widgets panel, Outlook, Teams, or a
notification — unless you have told Windows to use a different browser.

**If Edge is the browser you want, there is nothing to do here.**

**If you want a different one:**

1. Press the **Windows key**, type `Default apps`, and press Enter.
2. Find your browser in the list and click it.
3. Click **Set default** at the top. That covers every kind of link in one
   click.

### Part F — Windows Widgets

**Right-click an empty part of the taskbar › Taskbar settings.** **Widgets**
should be **off**. If it is on, turn it off.

**Why it belongs here.** The Widgets panel fetches news and weather using Edge
in the background, even if you never open it.

**This is the same setting as *Windows Widgets, setting 14* in Phase 4.** If
you have already turned it off there, it is done.

### Part G — Browsers in the Windows startup list

Windows keeps its own list of programs that start with the computer, separate
from anything inside the browser.

1. Open **Task Manager** — hold **Ctrl** and **Shift** and press **Esc**.
2. Click the **Startup apps** tab.
3. Look for **Microsoft Edge**, **MicrosoftEdgeUpdate**, **Google Chrome**,
   **GoogleUpdate**, anything beginning **GoogleChromeAutoLaunch**, or anything
   else that is plainly a browser.
4. Each of those should say **Disabled**. If one says Enabled, right-click it
   and choose **Disable**.

**Leave everything else alone.** Other things in this list belong to programs
you use.

### Part H — Edge's scheduled tasks

Edge also books itself into the Windows task scheduler, which is how it can
come back after you have done Parts D, F and G.

1. Press the **Windows key**, type `Task Scheduler`, and press Enter.
2. On the left, click **Task Scheduler Library**.
3. Look down the list for entries with **MicrosoftEdge** in the name. They are
   usually called something like *MicrosoftEdgeUpdateBrowserReplacement*,
   *MicrosoftEdgeUpdateTaskMachineCore*, and
   *MicrosoftEdgeUpdateTaskMachineUA*.
4. Right-click each one and choose **Disable**.

**Choose Disable, not Delete.** Disabling can be undone from the same screen by
choosing **Enable**. Deleting cannot.

> **⚠ VERIFY — Part H, before the guide ships.**
> **Does disabling those tasks stop Edge receiving its own security updates?**
> The tasks carry *Update* in their names. If they are what fetches Edge's
> patches, then this step trades a background annoyance for an unpatched
> browser, and it must either say so plainly or come out.
>
> **Measure it on a live machine:** disable the tasks, then open Edge and go to
> `edge://settings/help` and confirm it still checks for and installs an
> update.
>
> **Parts B and C also carry VERIFY**, on the two Edge routes. Chrome's routes
> are exact addresses and need no check; Edge's are click paths that nobody has
> walked. **Do not guess them — read them off the screen.**

### Check that it worked

1. **Restart the computer.**
2. **Before opening any browser**, open Task Manager.
3. On the **Processes** tab, sort by name and look for **Microsoft Edge** and
   **Google Chrome**.

**There should be none.** If Edge is still there, one of Part F, Part G or
Part H was missed.
```

---

## 4. BLOCK G3-B — Phase 3 Step 3, clearing what is left behind

**Location:** lines **792–798**.
**Anchor — first line to delete:** `> ### ⧗ RETRIEVAL GAP — part of G3`
**Anchor — last line to delete:** `> computer if followed carelessly.`
**It sits between** `## Step 3 — Clear what is left behind` and
`## Step 4 — A second opinion`.

**Replace the whole blockquote with:**

```markdown
**This is the one step in this guide that can damage a working computer if it
is done carelessly.** Read the whole step before you start. **If you are not
sure at any point, stop and turn to *Getting help* at the back.** Nothing gets
worse for waiting.

Windows Defender removes the program. It does not always remove the folders it
left behind.

### Look in these eight places, one at a time

Open **File Explorer**, click into the address bar at the top, paste one of
these, and press Enter:

```
%UserProfile%\PDFEditor
%UserProfile%\AppSuite
%AppData%\PDFEditor
%AppData%\AppSuite
%LocalAppData%\PDFEditor
%LocalAppData%\AppSuite
%ProgramData%\PDFEditor
%ProgramData%\AppSuite
```

**Most of them will say the location does not exist. That is the answer you
want**, and it means there is nothing to do for that one.

### If a folder does open

**Look at what is inside before you delete anything.**

- **You should see program files** — names like `ffmpeg.dll` and `icudtl.dat`,
  files ending in `.pak`, and a folder called **Resources**. That is what this
  program looks like from the inside.
- **If instead you see your own documents, photographs, or anything you
  recognize as yours, stop.** Close the window and leave it alone. **Only these
  eight exact locations, and only if the contents look like the list above.**

**To remove it:**

1. Close every File Explorer window that is showing the inside of that folder.
2. Go up one level, so you can see the folder itself.
3. Right-click the folder and choose **Delete**.
4. **If Windows says the folder is in use, or that access is denied**, restart
   the computer and do it again. Do not force it.
5. **Empty the Recycle Bin** so the files are actually gone.

### Then check again

Paste each of the eight locations back into the address bar. **Every one
should now say the location does not exist.** If one still opens, restart the
computer and repeat the step for that one.
```

---

## 5. BLOCK G4-A — Phase 5 in full

**Location:** lines **1146–1159**.
**Anchor — first line to delete:** `> ### ⧗ RETRIEVAL GAP G4`
**Anchor — last line to delete:** `> All of it must be carried across from v9.`
**It sits directly under** `# Phase 5 — Habits worth keeping`.

**Replace the whole blockquote with:**

```markdown
**Do these regardless of what Phase 2 turned up.** They are what keeps the
computer in the state the rest of this guide just put it in.

## Habits worth keeping

**Be careful where free programs come from.** A lot of this trouble arrives
through search results for *"free PDF editor"* and the like. Stick to makers
whose names you already know, or to the **Microsoft Store**. **Edge already
opens PDFs and lets you fill them in and sign them**, which covers most of the
reason people go looking.

**Use a real password manager rather than the browser's.** Look for one that
offers:

- **Encryption that the company itself cannot undo**, so nobody there can read
  what you have stored.
- **A free level, or clear published pricing**, and apps for every device you
  use — computer, phone, and browser.
- **A record of independent security audits**, and a plain account of anything
  that has gone wrong in the past.
- **Support for passkeys and for two-step verification codes.**

This is an area where the products change, so search for *password manager
comparison* and read a review from this year rather than an old one.

**Run a second-opinion scan once a month.** Phase 3 Step 4 explains it.
Decline the paid trial, and afterwards check that **Microsoft Defender** is
still your antivirus.

**Run the offline scan every three months**, and any time something feels
wrong — the computer slows down for no reason, unfamiliar windows appear, or
the browser sends you somewhere you did not ask for. Phase 3 Step 2 explains
it.

**Put both of those in your phone.** Set two repeating reminders — one monthly,
one every three months. **A check you have to remember is a check that stops
happening.**

**Turn on two-step verification everywhere it is offered.** An authenticator
app on your phone is the best of the three; a text message is next; email is
last. **Save the recovery codes** for every account that gives you one, with
the other papers you keep safe.

**Look through your browser extensions every few months.** They can see
everything you do in the browser, and they are easy to forget.

**Keep the encryption recovery key somewhere other than the computer it
unlocks.** Phase 1 Step 3 covers this.

**Check every few months that the browser settings held.** Edge's **Startup
boost** and its background setting should still be off, and your chosen
browser should still be the default. **An update can put them back.**

**These names travel together:** AppSuite, ManualFinder, OneLaunch, Wave,
Shift, TamperedChef. If you meet a new one that behaves like them, treat it the
same way.

## Keeping the computer quick

**This belongs in a security guide** because a slow, overloaded computer is
what persuades people to turn protection off.

- **Look at the startup list every three months.** Task Manager › **Startup
  apps**. Anything you do not actively use can be **Disabled** — music
  players, games launchers, chat programs, and the extras that came with the
  computer. Nothing there is required for Windows to start.
- **Pick one browser and use it.** Running three at once can take several
  gigabytes on its own.
- **On a computer with 8 GB of memory or less**, set Chrome's **Memory Saver**
  to **Maximum**, and close chat and music programs when you are not using
  them. Each of those can hold several hundred megabytes.
- **If one browser is showing several gigabytes in Task Manager**, close it and
  open it again. It is usually one tab or one extension.

## If something looks wrong

**Use this to decide what to do next.** Anything marked *urgent* means the same
day, not the weekend.

| If you find this | What to do |
|---|---|
| A program you do not recognize, but from a maker you do | Probably arrived with something else. Note the name and leave it for now. |
| A program you do not recognize, with a generic name and a maker you have never heard of | Search for the maker's name together with the word *malware*. If that turns up results, treat it as one. |
| Anything from **AppSuite**, or a *PDF Editor* or *ManualFinder* with no real maker behind it | Confirmed. **Go to Phase 3.** |
| Your browser's search engine has changed to something unfamiliar | Set it back and remove the unfamiliar entry — Step 6, Part B. |
| A device you do not recognize listed on your Google or Microsoft account | Possible break-in. Sign that device out, change the password **from your phone**, and turn on two-step verification. **Urgent.** |
| An email forwarding rule you did not set up | Somebody else is reading your mail. Remove the rule, change the email password, sign out everywhere. **Urgent — see *Getting help*.** |
| A sign-in from a place you have never been | Same as above. **Urgent.** |
| Windows Security says **Action needed** or **Failed** on something it quarantined | Click the entry and do what it asks. |
| Edge keeps coming back after you close it | Step 6, Parts D, F, G and H — in that order. |
| A browser using several gigabytes of memory for no reason | Usually one tab or one extension. Close the browser, open it again, and look at the extensions — Step 6, Part A. |
```

---

## 6. BLOCK G4-B — Advanced, optional

**Location:** lines **1168–1171**.
**Anchor — first line to delete:** `> ### ⧗ RETRIEVAL GAP — part of G4`
**Anchor — last line to delete:** `> walled off as decided. Not retrieved.`
**It sits under** the *"Nothing in this section is required"* paragraph.

**Replace the whole blockquote with:**

```markdown
**These are shortcuts to the same places the guide has already been.** They do
nothing the earlier steps did not do. Skip the section entirely if you would
rather not.

### Typing commands

Right-click the **Start** button and choose **Terminal**. Type one line and
press Enter.

**List the Store apps whose name contains a word you are looking for** —
replace `word` with the word:

```
Get-AppxPackage *word* | Select Name, Publisher, PackageFullName
```

**Remove one Store app by its exact name** — replace `exactname`:

```
Get-AppxPackage *exactname* | Remove-AppxPackage
```

**Only use the second one on a name you have already identified.** Settings ›
Apps › Installed apps does the same job with a confirmation step in front of
it, which is why the guide uses that instead.

### Settings pages you can reach by typing

Paste any of these into the browser's address bar and press Enter.

**Microsoft Edge:**

```
edge://settings/system      background running and Startup boost
edge://settings/help        version, and check for updates
edge://extensions           the extensions list
```

**Google Chrome:**

```
chrome://settings/system         background running
chrome://settings/performance    Memory Saver
chrome://settings/onStartup      what opens at startup
chrome://settings/searchEngines  search engines
chrome://settings/help           version, and check for updates
chrome://extensions              the extensions list
```

### Folders you can reach by typing

Paste into the File Explorer address bar:

```
%UserProfile%     your own folder
%AppData%         settings kept by programs
%LocalAppData%    more of the same, for this computer only
%ProgramData%     settings shared by everyone on the computer
```

### Websites used in this guide

```
account.microsoft.com/devices/recoverykey   your encryption recovery key
account.microsoft.com/security              two-step verification, recovery codes
account.live.com/Activity                   recent sign-ins to your Microsoft account
myaccount.google.com                        the same, for a Google account
mysignins.microsoft.com                     a work or school account
haveibeenpwned.com                          check an email address against known breaches
```

*[FORMATTING: confirm every address in this section still resolves on the day
the guide is exported. A dead address in a printed guide is worse than no
address. Same rule as the organizations paragraph in Getting help.]*
```

---

## 7. BLOCK G5 — the Firefox addendum

**Location:** lines **1241–1244**.
**Anchor — first line to delete:** `> ### ⧗ RETRIEVAL GAP G5`
**Anchor — last line to delete:** `> Firefox-Specific Hardening (F1–F12)"* and must be carried across in full.`
**It sits directly under** `# Addendum — Firefox`.

**Replace the whole blockquote with:**

```markdown
**Skip this whole section if Firefox is not on the computer.**

Firefox arranges its settings differently from Edge and Chrome, so it gets its
own pages. **Every step below starts the same way:** click into the address bar
at the top of Firefox, paste the address given, and press Enter.

> **⚠ VERIFY — the whole addendum, before the guide ships.**
> **None of the labels or locations below has been read off a live copy of
> Firefox.** They come from the source guide, which is an instruction rather
> than a measurement. **Open Firefox once and walk F1 to F12**, correcting any
> label that does not match what is on the screen. Nothing here can cost a
> reader their files, which is why it is one marker over the section rather
> than twelve.

### F1 — Extensions

Paste `about:addons` and press Enter, then click **Extensions** on the left.

**Every extension should be one you chose deliberately.** Remove anything
called *Coupon*, *Shopping helper*, *Search helper*, *Wave* or *Shift*,
anything from a maker you have never heard of, and anything you do not
recognize.

**Click Themes and Plugins as well.** The same rule applies.

### F2 — Tracking protection and dangerous sites

Paste `about:preferences#privacy`.

- **Enhanced Tracking Protection** should be set to **Strict**. **Standard**
  is acceptable and weaker. Choose **Custom** only if you want to set each
  piece yourself.
- Scroll to **Deceptive Content and Dangerous Software Protection**. **All four
  boxes should be ticked.** If any is unticked, tick it.
- Scroll to **HTTPS-Only Mode** and turn it on **in all windows**.

### F3 — Search engine

Paste `about:preferences#search`.

**The default should be a name you know** — Google, Bing, DuckDuckGo, or
similar. **Not** *myway*, *search-redirect*, or anything unfamiliar.

Below it, remove unfamiliar entries from the list of other search engines.

**Optional:** turn off **Provide search suggestions** if you would rather your
typing did not go to the search engine as you type.

### F4 — Stop Firefox reopening yesterday's tabs

Paste `about:preferences`. Under **Startup**, **Open previous windows and
tabs** should be **unticked**.

**Optional:** untick **Always check if Firefox is your default browser** to
stop the reminder appearing, if you have decided not to use Firefox as your
main browser.

### F5 — Data collection

Paste `about:preferences#privacy` and scroll to **Firefox Data Collection and
Use**. **Untick all three:**

- Allow Firefox to send technical and interaction data to Mozilla
- Allow Firefox to install and run studies
- Allow Firefox to send backlogged crash reports on your behalf

### F6 — Sponsored content

Paste `about:preferences#home` and untick **Recommended by Pocket**,
**Sponsored stories**, and **Sponsored shortcuts**.

Then paste `about:preferences#search` again and untick **Show search
suggestions from sponsors** if it is there.

### F7 — Encrypted address lookups

Paste `about:preferences#privacy` and scroll to the bottom, to **DNS over
HTTPS**.

**Increased Protection** is the setting to choose. It hides which websites you
are asking for from your internet provider.

**Max Protection stops you reaching websites** at all if the encrypted lookup
is unavailable. Choose it only if you want that.

### F8 — Profiles

Paste `about:profiles`.

**There should be one profile**, or only ones you created yourself. **If you
see one you do not recognize, do not remove it yet** — write down where it says
it is stored and turn to *Getting help*. A second profile is one of the ways
this kind of program hides.

### F9 — Updates

Paste `about:preferences#general` and scroll to **Firefox Updates**.

**Automatically install updates** should be **on**. Leave it on.

**Optional, on a computer with 8 GB of memory or less:** untick **Use a
background service to install updates**. Updates still install — they install
when Firefox is open instead of in the background.

### F10 — Passwords saved in Firefox

Paste `about:preferences#privacy` and scroll to **Logins and Passwords**.

**Ask to save logins and passwords for websites** should be **unticked**.

Click **Saved Logins** to see what is already stored. **Move them to a password
manager first**, then remove them from Firefox — see Phase 5 for what to look
for in one.

### F11 — If Firefox feels slow

- `about:performance` — shows which tab or extension is doing the work.
- `about:memory` — click **Measure** for a detailed breakdown.
- `about:support` — the page to show somebody who is helping you.

### F12 — Optional: keeping accounts apart

Mozilla publishes an extension called **Multi-Account Containers**. It keeps
each tab's sign-ins separate, so a personal account and a work account on the
same website do not mix. Install it from `addons.mozilla.org` if that is useful
to you. **It is optional and nothing else depends on it.**

### Firefox at a glance

| Setting | Where | Should be |
|---|---|---|
| Open previous windows and tabs | `about:preferences` › Startup | Unticked |
| Enhanced Tracking Protection | `about:preferences#privacy` | Strict |
| Deceptive content protection, all four boxes | `about:preferences#privacy` | All ticked |
| HTTPS-Only Mode | `about:preferences#privacy` | On in all windows |
| Data collection, studies, crash reports | `about:preferences#privacy` | All unticked |
| Pocket and sponsored content | `about:preferences#home` | All unticked |
| Default search engine | `about:preferences#search` | A name you know |
| DNS over HTTPS | `about:preferences#privacy` | Increased Protection |
| Ask to save logins and passwords | `about:preferences#privacy` | Unticked |
| Background update service | `about:preferences#general` | Off, on 8 GB computers |
| Profiles | `about:profiles` | Only ones you know about |
```

---

## 8. BLOCK G6-A — the Glossary

**Location:** lines **1250–1256**.
**Anchor — first line to delete:** `> ### ⧗ RETRIEVAL GAP G6`
**Anchor — last line to delete:** `> not sweep it.**`
**It sits directly under** `# Glossary`.

**The four decided cuts are made:** SO-DIMM, DDR4/DDR5, MPN and page file are
not below. **The Chromium entry keeps "open-source"** — it names a third
party's licensing correctly and is not a breach of the ban. **Two spellings
corrected on the way in:** *MalwareBytes* to **Malwarebytes**, and *behaviour*
to *behavior*.

**Replace the whole blockquote with:**

```markdown
**Plain definitions for the terms used in this guide.** You do not need to
read this section — it is here for when a word turns up and you want to know
what it means.

**Two-step verification (also called 2FA)** — Signing in with two things
instead of one: your password, plus a code from your phone. It is the single
most useful thing you can turn on for an account.

**AppSuite** — The name of the maker behind a known malicious family of
programs. Anything signed by AppSuite, especially a *PDF Editor*, should be
treated as dangerous.

**Authenticator app** — A phone app that produces a fresh code every thirty
seconds for two-step verification. Safer than receiving codes by text message.

**Backdoor** — A program that gives somebody else ongoing access to your
computer, usually while pretending to be something ordinary.

**BitLocker** — Microsoft's encryption for the whole drive. It protects what is
on the computer if the computer is lost or stolen.

**BitLocker recovery key** — A 48-digit number Windows creates when encryption
is turned on. Windows asks for it if it cannot unlock the drive the usual way.
**It must be kept somewhere other than the drive it unlocks.**

**Chromium** — The open-source browser engine that Chrome, Edge and several
others are built on. Programs that include it — Slack, Teams, Discord — carry
its appetite for memory with it.

**Cloud-delivered protection** — A part of Windows Security that asks
Microsoft about a suspicious file rather than waiting for an update. Should be
on.

**Controlled folder access** — A part of Windows Security that stops unknown
programs changing files in your Documents and Pictures. Useful against programs
that lock up your files for money.

**Core isolation / Memory integrity** — A Windows feature that walls off the
most sensitive parts of Windows from everything else.

**Defender (Microsoft Defender)** — The antivirus, firewall and protection
built into Windows. On a home computer it is enough on its own.

**Offline scan** — A Defender scan that runs before Windows fully starts, so it
can find things that hide once Windows is running.

**DNS over HTTPS** — Encrypts the lookup your computer does to find a website,
so your internet provider cannot see which sites you asked for.

**Edge** — Microsoft Edge, the browser that comes with Windows.

**Electron app** — A desktop program built on browser technology — Slack,
Teams, Discord, Spotify. Each typically uses several hundred megabytes of
memory.

**Enhanced Tracking Protection** — Firefox's setting for blocking trackers.
Three levels: Standard, Strict, Custom.

**Firewall** — Controls which connections in and out of the computer are
allowed. Windows includes one.

**Gigabyte (GB)** — A measure of memory or storage. Windows 11 is comfortable
with 8 to 16 GB of memory.

**Hyper-V** — The Windows feature underneath Memory integrity and several
others.

**Malwarebytes** — A separate anti-malware program, useful as a second opinion
because it catches nuisance software Defender leaves alone. The free version is
enough.

**Memory Saver (Chrome)** — Puts tabs you are not using to sleep, to free
memory.

**Pinned tab** — A tab locked to the left-hand end of the row. Pinned tabs
reopen every time the browser starts.

**PowerShell** — The window where you can type commands to Windows. Used in the
Advanced section, and nowhere else in this guide.

**Potentially unwanted program (PUP)** — Not quite malicious, but not wanted
either: fake cleaners, scare-you-into-paying tools, and programs that arrive
attached to something else.

**Ransomware** — A program that locks up your files and demands money.
Backups and Controlled folder access are the defenses that work.

**Real-time protection** — Defender checking files as you open, download or
change them. Should always be on.

**Startup boost (Edge)** — An Edge setting that starts Edge quietly when
Windows starts. Turn it off if you do not want Edge running on its own.

**Tamper Protection** — Stops other software, including malicious software,
turning Defender off. **Keep it on.**

**TamperedChef** — The family of malicious programs distributed as fake
utilities: PDF Editor, ManualFinder, OneLaunch, Wave, Shift. Capable of taking
passwords and giving somebody else control of the computer.

**Task Manager** — The Windows window that shows what is running. Open it with
Ctrl + Shift + Esc.

**Task Scheduler** — The Windows list of things set to run at particular times.
Edge and other programs add entries here.

**TPM** — A chip in the computer that holds encryption keys safely. BitLocker
and your Windows PIN both rely on it.

**UEFI / BIOS** — The firmware that runs before Windows starts. It controls
what the computer boots from.

**WebView2** — A Microsoft component that lets ordinary programs display web
pages using the Edge engine. Outlook, Teams and Widgets all use it.

**Widgets** — The news and weather panel on the taskbar. It uses Edge in the
background even if you never open it.

**Windows Hello** — Signing in with a PIN, a fingerprint or your face. The PIN
is tied to this computer and cannot be used from anywhere else.

**Windows Update** — How Windows keeps itself patched. It should always be up
to date.
```

**Two questions for Bill, neither of which I decided:**

1. **v9's glossary has an entry for Extended Security Updates**, which is a
   Windows 10 program. **It is not above.** This guide is Windows 11
   throughout and never mentions it. **Say if you want it back.**
2. **v9 also has entries for WSL, WSA, vmmem, vmwp and VBS.** They exist to
   explain a note in Step 2 about Memory integrity. **They are not above**,
   because they are the deepest jargon in the document and the rule is to
   delete jargon rather than explain it. **If Step 2's note names any of them,
   they have to come back** — that is the no-dead-ends rule, and it beats the
   no-jargon rule where the two meet. **I could not settle it from the draft.**

---

## 9. BLOCK G6-B — the Index

**Location:** lines **1262–1264**.
**Anchor — first line to delete:** `> ### ⧗ RETRIEVAL GAP G6`
**Anchor — last line to delete:** `> **Not retrieved.** Rebuild at export, once page numbers exist.`

**What changed and why.** The draft's instruction — *rebuild at export, once
page numbers exist* — stands. But *rebuild from what* had no answer, and v9's
index cannot be the answer: **every second line of it carries a broken Word
field** (`PAGEREF bm_… \h #`), and its destinations are v9's section names,
which this rewrite has renamed. **So the block below is the build list**, with
the dead fields stripped and each topic pointed at a section that exists in
this document. **Verified against the draft's own headings**, not from memory.

**Replace the whole blockquote with:**

```markdown
*[FORMATTING: build the index from the list below at export, once page numbers
exist. Each entry is a topic and the sections it appears in. Replace the
section names with page numbers. Add nothing that does not have a destination.]*

- **Two-step verification** — Quick-reference table; Step 4; Phase 5
- **AppSuite** — Step 5, *Names to treat as serious*; Phase 3; Phase 5, *If
  something looks wrong*
- **Avira** — Step 5, *Names that are merely unwanted*
- **BitLocker and device encryption** — Quick-reference table; Step 3; Phase 5;
  Glossary
- **Browsers restarting by themselves** — Step 6, Parts D, E, F, G and H
- **Browser extensions** — Step 6, Part A; Firefox addendum F1; Phase 5
- **Chrome — Memory Saver** — Step 6, Part D; Phase 5, *Keeping the computer
  quick*
- **Chrome — saved passwords** — Step 6, Part I; Phase 3 Step 8
- **Core isolation / Memory integrity** — Step 2; Quick-reference table;
  Glossary
- **Defender** — Step 2; Phase 3 Step 2; Phase 3 Step 4; Glossary
- **Defender offline scan** — Phase 3 Step 2; Phase 5
- **Diagnostic data** — setting 12, Phase 4
- **Edge — Startup boost** — Quick-reference table; Step 6, Part D; setting 13,
  Phase 4
- **Edge — scheduled tasks** — Step 6, Part H
- **Edge — saved passwords and cards** — Step 6, Part I; setting 15, Phase 4
- **Email forwarding rules** — Phase 3 Step 6; Phase 5, *If something looks
  wrong*; Getting help
- **Fast startup** — setting 18, Phase 4
- **Firefox** — the whole addendum; Step 6, Part D
- **Firewall** — Step 2; Quick-reference table
- **Malwarebytes** — Phase 3 Step 4; Phase 5; Glossary
- **Microsoft account and signing in** — Step 4; Phase 3 Step 5;
  Quick-reference table
- **Password manager** — Step 6, Parts I and J; Phase 3 Step 7; Phase 5
- **Potentially unwanted programs** — Step 5, *Names that are merely
  unwanted*; Phase 5, *If something looks wrong*; Glossary
- **Quick-reference table** — front matter
- **Ransomware** — Getting help; Glossary
- **Remote Desktop** — setting 10, Phase 4
- **Residue left behind after removal** — Phase 3 Step 3
- **Search engine hijacking** — Step 6, Part B; Firefox addendum F3; Phase 5,
  *If something looks wrong*
- **SmartScreen** — Step 2; Quick-reference table
- **Startup apps** — Step 6, Part G; Phase 5, *Keeping the computer quick*
- **Tamper Protection** — Step 2; Quick-reference table; Glossary
- **TamperedChef** — Step 5, *Names to treat as serious*; Phase 3; Glossary
- **Task Manager** — Step 6, Part G; Phase 5; Glossary
- **Task Scheduler** — Step 6, Part H; Glossary
- **TPM** — Step 4; Glossary
- **Wake on LAN** — setting 19, Phase 4
- **Widgets** — Step 6, Part F; setting 14, Phase 4; Glossary
- **Windows Hello** — Step 4; Quick-reference table; Glossary
- **Windows Update** — Step 1; Quick-reference table; Glossary
```

**One entry was dropped and you should know which.** v9's index has **Avira
removal — Phase 4 — Avira-Specific Removal**. **There is no such section in
this guide.** Avira appears once, in Step 5's list of merely unwanted programs,
and that is where the entry above points. **If a full Avira removal procedure
is meant to exist, it is a gap nobody has filed** — it is not in the six.

---

## 10. BOOKKEEPING — three small edits that follow from the above

**10a. Section 0.2, the gaps table.** Every row now reads CLOSED. Replace the
four open rows with:

```markdown
| G3 | **Step 6 Parts B–H**, full body | Phase 2 | **CLOSED** 2026-08-23 |
| G4 | **Phase 5 — hardening, habits, performance hygiene, decision tree** | Phase 5 | **CLOSED** 2026-08-23 |
| G5 | **Firefox addendum F1–F12** | Addendum | **CLOSED** 2026-08-23 |
| G6 | **Glossary and Index** | Back matter | **CLOSED** 2026-08-23 |
```

**And the paragraph beginning *"How to close the remaining four"* is now
history rather than instruction.** Replace it with:

```markdown
**All six are closed.** G1 and G2 by pack 1; G3 to G6 by pack 2, written after
the gap-fill was uploaded into the chat as a file. **The upload was the whole
fix**, and it is worth recording why: connector search returns a 524-line
document in whichever fragments rank highest, and no number of queries
guarantees the whole file. **Being able to name a file and being able to read
all of it are two different capabilities.**
```

**10b. Section 0.4, the VERIFY count.** It says eleven; pack 1 added a twelfth
for setting 10; **this pack adds three more**, and none of them touches the
original eleven:

| New | Where | What has to be measured |
|---|---|---|
| 13 | Step 6, Parts B and C | The two **Edge** click paths — search engine, and what opens at startup |
| 14 | Step 6, Part H | **Does disabling the MicrosoftEdgeUpdate tasks stop Edge getting security updates?** |
| 15 | Firefox addendum | Every label and location in F1 to F12, none read off a live copy |

**Number 14 is the one that matters.** If disabling those tasks stops Edge
patching itself, the guide would be telling a reader to trade a background
annoyance for an unpatched browser. **It is five minutes at a keyboard and it
decides if Part H ships as written.**

**10c. *What must happen before this ships*, item 1.** Replace with:

```markdown
1. **The retrieval gaps are closed.** G1 and G2 by pack 1, G3 to G6 by pack 2,
   both applied 2026-08-23. **No marker remains in this document.**
```

---

## 11. FOUR CORRECTIONS MADE TO THE v9 TEXT ON THE WAY IN

*Recorded because they are changes to the source, not to the wording.*

1. **v9's Part D points at the wrong Part.** It says that if Chrome still
   launches at boot, *"the cause is in Windows Startup apps (see Part E)"* —
   but Part E is the default browser, and startup apps are **Part G**. **The
   block above says Part G.**
2. **The eight residue paths used `C:\Users\<username>\`.** A reader has to
   know to substitute their own account name, and getting it wrong lands them
   somewhere real. **Changed to `%UserProfile%\`**, which is the same folder
   and needs no substitution — and it matches the other six paths, which were
   already written that way.
3. **`Get-WmiObject -Class Win32_Product` is not in the Advanced section.**
   v9 lists it to enumerate installed programs. **Settings › Apps › Installed
   apps does the same job**, is already the guide's own route in Step 5, and
   has a confirmation step in front of it. **A command in a senior's guide
   needs to earn its place against the menu that does the same thing.**
4. **v9's closing provenance line is not carried** — *"Generated based on real
   cleanup procedures… Updated May 2026…"*. It is a note about the document
   rather than text for the reader, and it carries a date that will re-stale.

**Two extraction artifacts in the gap-fill were not carried either** — `Sh /
ould be` in Part B and `why is m / y PC slow?` in Part D are line-wrap damage
in the extraction, not v9 text.

---

## 12. WHAT THIS PACK DOES NOT CHANGE

- **Setting 11.** Corrected by Claude Code; untouched.
- **The quick-reference table**, including the twenty page numbers still at
  `00` and the six settings pointing at *"Keep vs. Disable Table"*.
- **The twelve existing VERIFY claims.** Not one is resolved, softened or
  moved.
- **The BILL'S CALL note in *Getting help*** about naming organizations.
- **The `.html` copy pass and the marketing plan** — jobs 2 and 3, still to
  come in this session.

---

*End of pack 2.*
