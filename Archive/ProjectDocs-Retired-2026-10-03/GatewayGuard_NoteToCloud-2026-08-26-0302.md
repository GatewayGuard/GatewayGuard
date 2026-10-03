<!-- Dated: 2026-08-26 03:02 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Note to Cloud -- session close, 2026-08-26 03:02 ET

- **Document Name:** GatewayGuard_NoteToCloud
- **Last Modified:** 2026-08-26 03:02 ET
- **Last Editor:** Claude Code (CGDELL)
- **Machine:** CGDELL
- **Status:** HANDOFF. Not a governing document. Amends no rule.
- **Replaces:** `GatewayGuard_NoteToCloud-2026-08-25-1620.md`
- **Written under:** `GatewayGuard_CloudWorkingRules-2026-08-25-1400.md`

---

## FIRST, THE THING YOU NEED TO KNOW ABOUT YOUR OWN WORK

**Your licence research was delivered, and then it sat outside the repository
for twelve hours.**

`GatewayGuard_CloudResearch-Licence-2026-08-25-1435.md`, 1,261 lines, answering
all fourteen questions of the brief. ***measured at session start,
2026-08-25 16:41:*** `git status` reported it **untracked**. It was on disk in
`ProjectDocs\` and it was in no commit, so it was in no push, so it was in no
sync. **It is committed and pushed now.**

**Nothing you did caused this and there was nothing you could have done about
it.** You wrote the file and said so. **Step 4 of GETTING A FILE TO CLAUDE
CLOUD is mine** -- commit it, push it, verify the push landed -- and the
session that received your work closed at 16:20 without doing it.

**Why it is worth your reading rather than just mine.** The rule in `CLAUDE.md`
was rewritten on 2026-08-25 *specifically* because it used to leave out the
handoffs, and it says in as many words: *"A file can sit in `ProjectDocs\`
indefinitely while everyone believes it is done."* **It then happened the same
day, to the largest file of the day.** The rule was right, and writing a rule
is not the same as running it.

**What this means for you operationally: do not assume a document you delivered
is in a later snapshot.** If you need to build on your own earlier output, name
it and say you could not confirm it synced, exactly as Rule 6 has you do for a
base file.

---

## SECOND -- YOUR RESEARCH LANDED, AND IT CHANGED A DECISION

I have read it. **Three things in it are load-bearing and I am recording that
they were acted on, not just received.**

**1. The acceptance question is answered, and it is not a build change.**
Your Gumroad **Terms** custom field finding moves item 5 on Bill's list from
*"a decision that gates the build"* to *"a form field somebody has to fill
in."* That was the one item with a deadline attached to the build freeze.
**The deadline is gone.** Bill's list now says so.

**2. Your section 6.7 finding reframes the whole thing, and I want to confirm I
read it the way you meant it.** The position today is not neutral but
**negative**: Gumroad's terms oblige the supplier to provide end-user licence
terms and warrant they are current, and we have supplied none. **That is a
stronger statement than "we have not got round to it" and Bill's list carries
it in your words, not softened.**

**3. The dated item nobody had flagged is now on Bill's list as its own row.**
Gumroad's terms updated 2026-08-17, existing accounts bound **2026-09-16**,
launch **2026-09-01**. Bill sells his first copies under terms his account is
not yet bound by. **Good catch, and it was outside what the brief asked you.**

**One thing you asked me to establish, and I have not yet.** You wrote, on the
licence-move fee: *"Claude Code should establish what a licence move consists of
operationally before a price is attached to it."* **Not done. It is not
forgotten** -- it is on Bill's list under the fee item, with your reasoning
attached. ***measured on ascii43 and unchanged:*** `Get-MachineIdentity`
(line 3140) computes a hash, displays it, logs it, and never compares it to
anything, so there is still nothing to unbind.

---

## THIRD -- WINDOWS CHANGED SOMETHING UNDER THE WEBSITE COPY

**This is the whole of the rest of this session's technical work, and it
matters to you because you write guide and page copy.**

Bill asked what the pending Windows update changes for Checkup.

***sourced,*** KB5101684 (2026-07-28 preview) and KB5121003 (2026-08-11
mandatory, which **includes** KB5101684):

> *"This update also simplifies the Lock screen Widgets experience. For new
> users, Weather is now the only widget shown on the Lock screen by default."*

**Nothing shipped is made wrong by it.** ***measured on ascii43:*** setting 14
writes `Policies\Microsoft\Dsh` (line 5631) -- the **taskbar** Widgets board,
not the lock screen -- and its Revert string names
`Settings -> Personalization -> Taskbar -> Widgets` (line 6830). ***measured:***
**zero occurrences of "lock screen" in the build, in the guide draft, or in
`widgets.html`.**

**What it touches is copy that does not exist yet.** `FutureSettings` C-3 says
the lock-screen steps go in the guide and on the page at launch, inside setting
14. **When you or I write those steps they must now hold for two starting
states** -- an older PC on *"Weather and more"*, a newer one on Weather only.
C-3 records this; the entry is committed.

**Do not write that copy yet.** The measurement it depends on -- Bill's Win+L
test of `LockScreenWidgetsEnabled` -- has not been run, and it should be run on
the **updated** machines so the answer describes the Windows customers will
have. Bill is rebooting into that update now.

**Also checked and clear, so you do not need to re-check them:** Defender,
BitLocker, Device Encryption, TPM, Secure Boot state, Memory integrity,
advertising ID, Edge, scheduled tasks, PowerShell and console host behaviour,
and Settings page names. The one August removal -- the Drop Tray setting under
**Settings > System > Multitasking** -- appears **nowhere** in the build, the 20
website pages, or the guide draft. ***measured.***

---

## WHAT IS TRUE ABOUT THE BUILD, SO YOU DO NOT INFER IT

**ascii43 is unchanged this session and remains half built and never field
run.** F4, the F5 remnants and the F6 wording block are not built. **9,002
non-blank / 9,382 total.** Next free screen ID **90**. Next free FT **238**.

**No build ran. No screen changed. No gate was run**, because nothing was
edited that a gate governs.

---

## THE ONE RULE I WOULD ASK YOU TO KEEP LEANING ON

Rule 6, provenance, and specifically the half of it that says **how** you read
the base. Your provenance block on the licence research did the thing that made
the rest of it trustworthy: it said the `.docx` master could not be opened, that
the twin was assembled from relevance-ranked fragments rather than read whole,
and it **named the four passages you could not see**. That is what let me use
your recommendations without re-deriving them.

**It also let me notice what you had not been able to check, which is the only
reason the fee item is still marked open rather than closed.**

---

## ONE THING NOT TO START ON

Bill typed **Item 24** into `ProjectDocs/Q2 - Checkup offers to run
windows.txt` during this session: *"Deep Research and them implement their
suggestions/functionality for our documents, the website and maybe Checkup if
available in PS mode."*

**It is committed as typed and it is not actioned.** One reading is *implement
what Cloud's delivered research recommends* -- **which would be you.** The other
is *run a fresh deep-research pass first.* **Do not pick one.** It is question
10 on Bill's list and it needs one sentence from him.

---

## FRESHNESS -- QUOTE THESE FOUR BACK BEFORE YOU DO ANYTHING

Read them out of `CURRENT.md`, not out of this file. If `CURRENT.md` in your
snapshot does not carry the session heading below, **you are reading an old
snapshot -- say so and stop.**

The newest session-log heading, which is in the payload only if the sync
arrived:

```
## Session: 2026-08-25 16:41 to 2026-08-26 03:02 [Claude Code -- CGDELL] -- A WINDOWS UPDATE MEASURED AGAINST THE BUILD, AND CLOUD'S RESEARCH FOUND SITTING OUTSIDE THE REPOSITORY
```
