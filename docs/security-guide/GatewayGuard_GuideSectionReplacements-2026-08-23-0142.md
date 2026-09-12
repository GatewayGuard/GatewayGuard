<!-- Dated: 2026-08-23 01:42 ET -->
# Guide — drop-in section replacements, pack 1

- **Document Name:** GatewayGuard_GuideSectionReplacements
- **Last Modified:** 2026-08-23 01:42 ET
- **Last Editor:** Claude.ai (Cloud)
- **Machine:** CGDELL
- **Applies to:** `GatewayGuard_GuideRewrite-Draft-2026-08-22-1000.md`
- **Sources:** `GatewayGuard_GuideGapFill-fromV9-2026-08-22-1224.md` (G1, G2 blocks,
  read in full) and `GatewayGuard_DefectPassResponse-2026-08-22-1525.md` (line
  numbers for G-1, G-2, G-4, and the spelling list)
- **Status:** Drop-in replacements. **The draft is not rewritten.** Claude Code
  applies each block at the stated location and commits.
- **Written against freshness stamp:** `e4a4654`, generated 2026-08-23 01:36 ET

**Change History Log:**

- 2026-08-23 01:42: **Reissued. Content unchanged; pointers corrected.** Four
  source documents were renamed with `-HHMM` suffixes in commit `e4a4654`, so
  every reference in the 2307 issue pointed at a filename that no longer
  exists. Gap-fill -> `-1224`, defect pass response -> `-1525`. Section 8's
  closing action also corrected: the gap-fill has a CURRENT.md row and is
  readable, so the obstacle is retrieval of all 524 lines, not nameability.
  **Supersedes `GatewayGuard_GuideSectionReplacements-2026-08-22-2307.md`.**

- 2026-08-22 23:07: Created. Closes **G1 and G2**, writes the missing
  **setting 10** section, applies **G-1, G-2 and G-4**, folds four items into
  **Getting help**, and lists the **seven British spellings**. G3, G4, G5 and G6
  remain open — see section 8.

---

## 1. WHAT IS IN THIS PACK, AND WHAT IS NOT

| Item | State |
|---|---|
| **G1** — Phase 1 Step 3, device encryption | **CLOSED.** Section 3 below |
| **G2** — Phase 1 Step 4, accounts and sign-in | **CLOSED.** Section 4 below. The finished Windows Hello copy is preserved and not overwritten |
| **G-2** — setting 10 has no body section | **WRITTEN.** Section 5 below |
| **G-1** — the closed W-07 collision | **APPLIED.** Section 6 |
| **G-4** — the TOC placeholder that will print | **APPLIED.** Section 6 |
| Seven British spellings | **LISTED.** Section 7 |
| *When to call for help* — four missing pieces | **FOLDED IN.** Section 6 |
| **G3, G4, G5, G6** | **STILL OPEN.** Retrieved only in part — section 8 |

**Setting 11 is not touched.** Claude Code corrected both the label and the path
in the draft, and the instruction is not to revert it. Nothing in this pack goes
near it.

---

## 2. THE RULE THAT GOVERNED EVERY WORD BELOW

*Recorded because it changed what I wrote, more than once.*

> **Where a written instruction and a measurement of the build disagree, the
> build wins and the instruction gets re-asked.**

The v9 source is an instruction, and it was written for a technician working on
somebody else's PC. It is not a measurement. So where v9 states something about
Windows behavior that nobody has measured, it appears below **marked VERIFY**
rather than smoothed into confident prose.

**Three places where v9 would have misled a reader, and what I did instead:**

1. **v9 sends every reader to `account.microsoft.com/devices/recoverykey`.**
   That page only has a key if the PC signs in with a Microsoft account.
   **A local-account reader is sent to an empty page at the exact moment they
   are frightened.** Rewritten so the local-account path comes first.
2. **v9 says *"ask the user first"*** about an unfamiliar account. A senior
   sitting alone has nobody to ask. Rewritten as something they can do
   themselves.
3. **v9 recommends a second standard account** and calls it the *"biggest single
   reduction in malware blast radius"* — a PL-4 breach section 0.1 already
   removed elsewhere. Kept the advice, dropped the superlative.

---

## 3. G1 — REPLACES THE `⧗ RETRIEVAL GAP G1` BLOCK

*Delete the entire quoted gap block under `## Step 3 — Device encryption` and
put this in its place. The heading itself stays.*

---

**What this does.** Encryption scrambles everything on the drive so it can only
be read by someone who can sign in. Without it, a person who has the computer in
their hands can take the drive out, connect it to another machine, and read
every file on it. Your password does not stop that. Encryption does.

**This matters most for a laptop**, which can be left behind or taken.

### Is it already on?

**Go to Settings › Privacy & security › Device encryption.**

- **If you see a switch and it says On** — this is done. Skip to *Save your
  recovery key* below, because you still need the key.
- **If the switch says Off** — turn it on. Encryption runs quietly in the
  background and you can keep using the computer while it works.
- **If there is no Device encryption page at all**, your computer uses the other
  version of this feature. Click Start, type `Manage BitLocker`, and press
  Enter. Turn BitLocker on for drive C: at least. If you have a second drive
  with your own files on it, turn it on for that one too.

### Save your recovery key — do this before you go any further

**The recovery key is a 48-digit number, printed as eight blocks of six
digits.** Windows asks for it when something changes on the computer and it
wants proof you are the owner — after certain repairs, hardware changes, or
firmware updates.

**Without the key, and with no other way to sign in, the files are gone.** Not
locked. Gone. Nobody can recover them, including us and including Microsoft.

**Where your key is depends on how you sign in to this computer.** Check which
one you have at **Settings › Accounts › Your info** — if an email address is
shown under your name, that is a Microsoft account.

**If you sign in with a Microsoft account:** on your phone or another computer,
go to `account.microsoft.com/devices/recoverykey` and sign in with that same
account. Your key should be listed there under this computer's name. *VERIFY.*

**If you sign in with a local account** — no email address under your name —
**there is no online copy and nobody is holding one for you.** Click Start, type
`Manage BitLocker`, press Enter, and choose **Back up your recovery key**. Then
save it two ways, using the next section.

**If the online page is empty and you expected a key to be there**, do the same:
Start › `Manage BitLocker` › **Back up your recovery key** › **Save to your
Microsoft account**. Then check the page again to confirm it arrived. *VERIFY.*

### Two copies, and one rule about where they go

Save the key in **two** places:

1. **On paper.** Print it, or write it out by hand, and keep it with your
   important documents. A password manager entry works too.
2. **On a USB stick** that you keep somewhere other than the computer bag.

**The rule: never save the only copy on the computer the key unlocks.** If the
drive will not open, the key sitting on that drive cannot be reached. That is
the whole problem the key exists to solve.

> **⚠ VERIFY — this section, before the guide ships.**
> Three claims here have not been measured on a live machine, and this is one of
> the two places in the guide where being wrong costs a reader their files:
>
> 1. That `account.microsoft.com/devices/recoverykey` lists a key for a
>    Microsoft-account PC with Device Encryption on.
> 2. That **Back up your recovery key** appears under `Manage BitLocker` on
>    **Windows 11 Home**, and what options it offers on a **local account**.
> 3. Whether Device Encryption can be switched on at all on a Home machine using
>    a local account, or whether Windows requires a Microsoft account first.
>
> **Claim 3 decides the shape of this section.** If Home requires a Microsoft
> account, the local-account path above is wrong and the reader needs to be told
> to create one first. **Sandy3 covers the Microsoft-account case (encryption is
> already on). SANDY covers the local-account case.**
>
> **Order matters — run the ascii43 field test on SANDY first.** SANDY's
> unencrypted state can only be spent once, and encrypting it for this
> measurement destroys the field test's starting condition. One trip settles
> both if the field run goes first.

---

## 4. G2 — REPLACES THE `⧗ RETRIEVAL GAP G2` BLOCK

*Delete the quoted gap block under `## Step 4 — Your account and how you sign
in`. **Keep everything from `### Windows Hello — setting 9` onward exactly as it
is** — that copy is finished. This text goes above it.*

---

**Two things are worth knowing about your account: who can sign in to this
computer, and how you get back in if you are locked out.**

### Who can sign in

**Go to Settings › Accounts › Other users.**

**What you should see: only people who actually use this computer.** On a
computer one person uses, the cleanest result is nobody listed here at all.

**If you see a name or an email address you do not recognize, do not delete it
yet.** Deleting an account can take that account's files with it, and some
entries are put there by Windows itself or by the shop that set the computer up.
Write down exactly what it says, then remove it only once you are sure it is not
someone in your household and not something you set up and forgot. **If you are
not sure, that is a good reason to call someone** — see *Getting help* at the
back of this guide.

### Your own account type

**Go to Settings › Accounts › Your info.**

**Administrator** is normal on a home computer and there is nothing to fix.

**If you want an extra layer**, you can make a second account of the type
**Standard** and use that one day to day, signing in to the administrator
account only when you install something. Software that arrives by accident can
do less damage from a standard account. **This is optional.** If it makes the
computer annoying to use, skip it — an unused precaution protects nothing.

### If you forget how to get in

**This is the part people wish they had read first.**

At **Settings › Accounts › Your info**, look under your name:

- **An email address is shown.** You sign in with a Microsoft account. If you
  forget your PIN or password, you can prove who you are from your phone and set
  a new one.
- **No email address.** You sign in with a local account. **There is no reset
  link and no support line.** *VERIFY.* If you forget the password, the usual
  answer is reinstalling Windows, which means losing anything on the computer
  that is not saved somewhere else.

**If you use a Microsoft account, turn on two-step verification.** It means
somebody who learns your password still cannot get in without your phone. Do
this part on your phone, not on the computer:

1. Go to `account.microsoft.com/security` and sign in.
2. Find **Two-step verification** and turn it **On**.
3. Set up **two** ways to be reached. The Microsoft Authenticator app is the
   best one; a text message to your phone is a good second.
4. On the same page, open **Advanced security options**, find **Recovery code**,
   and choose **Generate**.

**Save that recovery code with your BitLocker key**, in the same two places —
on paper, and on the USB stick. **Without it, losing your phone can lock you out
of the account permanently**, and that account may be holding the only copy of
your encryption key.

> **⚠ VERIFY.** The local-account claim above — no reset path, reinstall as the
> usual answer — is one of the eleven. It also appears in the Windows Hello
> section below, so **both must say the same thing after the measurement**, and
> the same trip that settles section 3 settles this.

---

## 5. G-2 — NEW SECTION FOR SETTING 10, REMOTE DESKTOP

*Insert as the first setting section of Phase 4, ahead of setting 11, so the
phase runs 10, 11, 12, 13, 14, 15, 17, 18, 19. **This closes the gap that
blocks FT-226's class fix** — five of the six settings had somewhere to point
and setting 10 did not.*

---

### Remote Desktop — setting 10

**Where it lives:** **Settings › System › Remote Desktop**.

**What it is.** Remote Desktop lets somebody sitting at another computer take
over this one — see your screen, move your mouse, open your files — across a
network or the internet.

**Why it should be off.** It is a legitimate tool that businesses use. On a home
computer, it is a door that almost nobody needs, and a door nobody uses is a door
worth closing.

**What you should see: Remote Desktop set to Off.** If it is On and you do not
knowingly use it, turn it off.

**If the setting is not there at all, that is the answer, not a problem.**
Windows 11 Home cannot accept incoming Remote Desktop connections — the feature
is not built in. There is nothing to turn off and nothing more to do here. *This
is why Checkup skips this item on Home machines.*

> **⚠ VERIFY — original copy, no v9 source.** The gap-fill has no v9 text for
> this setting, so unlike the rest of this pack it is written rather than
> carried across. Two things to confirm on a live machine:
>
> 1. **The exact on-screen path and label on Windows 11 Pro.** RULE W-07 needs
>    the literal words the reader will see, and CGDELL is the Pro machine.
> 2. **What Home actually shows** — whether the Remote Desktop page is absent,
>    or present and greyed out. The wording above says absent, and the two need
>    different sentences.
>
> The Home behavior is sourced from Checkup's own `SkipOnHome=$true` for this
> setting, which is the build's position rather than a measurement of the
> screen.

---

## 6. SMALL BLOCKS — G-1, G-4, AND THE GETTING HELP FOLD-IN

### 6a. G-1 — delete the closed collision, two places

**Delete lines 1050–1057 in full**, the RECONCILIATION paragraph beginning
*"One collision is still open and is not resolved here."* It asks Bill for a
decision that no longer exists: the website says **Select Required diagnostic
data** and the guide says **Choose Required**, which agree.

**Delete item 3 of WHAT MUST HAPPEN BEFORE THIS SHIPS**, which repeats it.

**Renumber the remaining items** in that list so it runs 1, 2, 3 with no gap.

**Same stale claim in `GatewayGuard_PricingCopy-2026-08-22-1000.md`, line 188** —
*"it has a live W-07 collision with the guide's setting 12."* Delete that clause.

### 6b. G-4 — delete the placeholder, and correct the claim that it was fixed

**Delete line 134 entirely:**

```
*In Word: right-click this line and choose Update Field.*
```

**Keep** the line beneath it about the outline being always visible.

**Then correct the section 0.1 row at line 48.** It claims the TOC placeholder
defect was fixed. **v9 had two of these lines and this draft has one**, so the
row overstates what landed. Replace the row's second cell with:

```
v9 shipped with "Right-click here and choose Update Field" twice. One survived into the 08-22 draft at line 134 and was removed 2026-08-22.
```

**And a convention worth restoring while the block is open.** The 08-19 draft
wrapped producer instructions as `*[FORMATTING: ...]*`, which is greppable and
unmistakably not reader text. This draft dropped that for the TOC block, which
is how the line came to read as body copy. **Any instruction meant for whoever
produces the PDF should go back inside those brackets.**

### 6c. Fold four items into the existing `Getting help` back matter

*Do not add a section. These go into the section that is already there, in
second person. The v9 source is written for a technician and says "the user"
four times in 34 lines.*

**Add, under a heading of `Signs that something is already wrong`:**

```
Some things mean the problem has already happened, and they are worth acting
on the same day:

- You are told about a sign-in you did not make, from a place you have never
  been.
- There is mail in your Sent folder that you did not send.
- Your email is forwarding copies somewhere you did not set up. In Outlook.com
  this is under Settings › Mail › Forwarding.
- Money has moved that you cannot account for.

Any one of these is a reason to change your password from a different device —
a phone, or another computer — rather than from the one you are worried about.
```

**Add to the existing "when to call someone" material:**

```
There is a point where doing this alone stops making sense. If a scan finds
more than about fifty items, or the computer behaves strangely in ways that
keep changing, stop and get someone to look at it. That is not a failure. It
is the same call you would make about a noise in the car.

If any account on this computer belongs to an employer — a work email, a
company file store — tell their IT people. They may be required to act, and
they will need to know sooner rather than later.
```

**Add, as its own short paragraph:**

```
If you think a particular person is watching your computer, your phone, or
your accounts, the advice in this guide is not the right advice. Changing
settings can warn the person watching before it stops them. That situation
needs people trained for it — a domestic violence advocate, or a service that
handles technology-facilitated abuse — and they are reachable before you
change anything.
```

> **Bill's call, not mine:** whether to name specific organizations and phone
> numbers in that last paragraph. Naming one makes it useful; naming a wrong or
> dead number in a printed guide is worse than naming none. **RESEARCH BEFORE
> STATING applies** — anything named needs to be confirmed current at the time
> the guide is exported, not now.

---

## 7. THE SEVEN BRITISH SPELLINGS

Lines **181, 486, 509, 548, 595, 687, 699**. Sweep `recognise` → `recognize`
and `recognisable` → `recognizable`.

**Mechanical, but check each hit rather than replacing blind.** None is an
on-screen label today, so no rule is breached — but if any of the seven sits
inside quoted Windows wording, the screen is the dictionary and the quote must
match the screen instead. That is the lesson from the Advertising ID label,
where **the guide was closest and still wrong by a single letter**, and a reader
scanning for *personalised* does not find *personalized*.

---

## 8. WHAT IS STILL OPEN, AND WHY I STOPPED

**G3, G4, G5 and G6 are not closed, and I will not write them from what I have.**

| Gap | What I retrieved | What is missing |
|---|---|---|
| **G3** | Step 6 Parts B, C, D and the start of the Edge block; Parts G and H; the Phase 3 residue cleanup (G3b) | **Parts E and F**, and the middle of D |
| **G4** | The opening of Phase 5 — install habits, password manager | **The rest of the hardening list, performance hygiene, and the quick decision tree**, which is the part the draft asks for twice |
| **G5** | Nothing | **The entire Firefox addendum, F1 to F12** |
| **G6** | Nothing | **The entire glossary and index** |

The gap-fill is 524 lines and search returns it in fragments. **Writing the
missing parts from partial retrieval is exactly the fabrication the markers were
put there to prevent**, and it would produce a section that reads finished and
is not — which is worse than a marker, because a marker gets fixed.

**The one action that closes all four:** upload
`GatewayGuard_GuideGapFill-fromV9-2026-08-22-1224.md` into the chat. Then I have
all 524 lines at once instead of whatever search ranks highest, and pack 2
finishes the guide.

**A CURRENT.md row is not the fix here, and that is worth being precise about.**
The gap-fill already has a row and is already in `ProjectDocs/`, so it is
nameable and openable — the problem is different. Search returns a 524-line
document in whichever fragments rank highest for a query, and no number of
queries guarantees the whole file. **Being able to name a file and being able to
read all of it are two different capabilities**, and only the first one was
fixed on 2026-08-23.

---

## 9. WHAT THIS PACK DOES NOT CHANGE

- **Setting 11.** Corrected by Claude Code; untouched here.
- **The quick-reference table**, including setting 10's row, which already
  exists at line 209 and now has a section to point at.
- **The nine remaining VERIFY claims** outside sections 3 and 4.
- **The `.html` copy pass** — items 2, 3, 6, 8, 13, 18, 19, 21 — held until the
  item 2 phrasing is picked, as instructed.

---

*End of pack 1.*
