<!-- Dated: 2026-09-06 16:00 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Password managers -- the research Bill asked for, and what it costs to build

- **Document Name:** GatewayGuard_PasswordManagerResearch
- **Asked for by Bill, 2026-09-06**, answer 4 in `Bills 16 Decisions.txt`
- **Status:** research done. **The build change is scoped and not started.**

---

## WHAT BILL ASKED FOR, RESTATED SO HE CAN CHECK I HAVE IT

1. **A good non-browser password manager: leave them alone.** Let them keep
   using it.
2. **Otherwise they keep the browser manager, and we tell them how to run it
   properly** -- find out which browser, then give the minimum settings.
3. **Research what Microsoft and the experts say** about saving passwords in a
   browser -- and specifically **one browser, or all the ones they use.**
4. **If the answer is "only one": find which one they use most, and tell them
   why one.** If it is "all are fine": minimum settings for each.

**All four are answerable. Here they are.**

---
---

# PART 1 -- WHAT THE EXPERTS ACTUALLY SAY

## The finding that matters most: WE HAVE BEEN OVERSTATING THE RISK

*Sourced, the UK's National Cyber Security Centre, "Top tips for staying
secure online -- password managers":* **if convenience is the most important
thing, the NCSC recommends using the password manager provided by your browser
or device manufacturer** to generate and manage your passwords. It describes
first-party browser managers as *"a handy tool ... due to their deep
integration with a platform's security"*, and notes that stored password data
is protected by device security chips, encryption, or both.

**That is a national cyber security agency telling our exact customer that the
thing built into their browser is a reasonable choice.** Our current copy
describes it as a convenient single point of failure and steers the reader to
buy something.

**Bill's instruction 2 is better advice than what we ship.**

## THE ONE REAL RISK, AND IT IS NOT THE ONE WE HAVE BEEN NAMING

*Sourced, comparative reviews of Chrome, Edge and Firefox password stores:*
all three **encrypt saved passwords at rest**. But the protection has a limit
that matters far more than the encryption does:

> **Anyone who can get into your signed-in Windows session can read your saved
> passwords, because the browser decrypts them on demand for whoever is
> sitting there.**

**So the thing that protects a senior's saved passwords is not the browser. It
is the lock on their Windows account.**

### AND THAT IS TWO SETTINGS CHECKUP ALREADY HAS

| Checkup setting | What it actually does for this |
|---|---|
| **17 -- Password required on wake** | Stops a walk-up from reaching the session where the passwords decrypt on demand |
| **9 -- Windows Hello** | The face or fingerprint that makes locking the machine painless enough to actually happen |

**This is the honest version of the advice, and it is better than what we have
now:** *"Saving passwords in your browser is a reasonable choice. What makes it
safe is that nobody else can get into your PC -- which is why Checkup checks
that your PC asks for a password when it wakes."*

**It connects two settings the customer already agreed to, instead of selling
them a subscription.** That is the product doing its job.

---

## ONE BROWSER, OR ALL OF THEM? -- ONE, AND THE REASON IS NOT SECURITY

**Bill's question 3, answered: use one.**

**But the reason is not hacking. It is lockout**, and for a senior it is the
more likely harm by a wide margin.

*Sourced, comparative reviews:* the main problem with passwords saved in
several browsers is **duplicate credentials that drift apart**. Change a
password on a website today, and the browser you changed it in learns the new
one. **Every other browser keeps offering the old one.** Weeks later they open
the other browser, the saved password fails, and they have no way to tell which
of the two stored passwords is the real one.

**Three attempts with a stale saved password is how accounts get locked.**

> **The sentence for the guide:** *"Pick one browser to save your passwords in
> -- the one you use most. If you save them in two, then the day you change a
> password, one of them is quietly wrong, and you will not know which."*

**No jargon, states the desired state, states what happens if you do not.**

---

## WHICH ONE DO THEY USE MOST -- AND CHECKUP CAN JUST ASK

**I looked at measuring it and I am recommending against it.** Windows records
the default browser, but a default is not the same as the one they use, and
reading browsing history to count visits is exactly the kind of thing a
security product must never do. **We would be reading a senior's browsing
history to give them filing advice.**

> **Ask them.** *"Which browser do you use most -- Edge, Chrome, or
> Firefox?"* One screen, three keys. It is accurate, it takes four seconds,
> and it does not require Checkup to read anything private.

---
---

# PART 2 -- THE MINIMUM SETTINGS, PER BROWSER

**These are what "run it properly" means.** The same four ideas in each
browser, in that browser's own words.

## Microsoft Edge

*Sourced, Microsoft's Edge password manager guidance:*

| Turn this on | Where | Why |
|---|---|---|
| **Ask to save passwords** | Settings -> Profiles -> Passwords | Nothing gets saved unless it is on |
| **Suggest strong passwords** | same page | The generator is the actual benefit |
| **Require device sign-in before filling or showing a password** | same page | **This is the important one.** It closes the walk-up gap above -- Windows Hello or the PIN is demanded before a password is shown or filled |
| **Microsoft Defender SmartScreen stays on** | Settings -> Privacy, search and services -> Security | A saved password is only safe if the page asking for it is real |

**Note for us:** *sourced, Microsoft:* Edge's password manager needs the
profile signed in with a personal Microsoft account, and syncing should only be
on where the device has a real lock. **Both of those are things Checkup can
already see.**

## Google Chrome

Same four, different labels: **Offer to save passwords**, **Suggest strong
passwords**, and Chrome's own equivalent of the device-sign-in prompt under
Google Password Manager -> Settings. Safe Browsing stays on.

## Mozilla Firefox

Firefox is the one that differs, and in our favour: it has a **Primary
Password**. Set one, and the saved passwords cannot be read without it **even
by someone already sitting at the unlocked PC**. *Sourced: Microsoft publishes
a matching `PrimaryPasswordSetting` policy for Edge, so the concept is not
fringe.*

> **If a customer uses Firefox, "set a Primary Password" is the single
> highest-value sentence we can give them**, and it costs nothing.

---
---

# PART 3 -- WHAT THIS COSTS TO BUILD, AND WHAT I RECOMMEND

## What Checkup knows today

***Measured, ascii44:*** **zero references to Firefox. Three to Chrome, and
none of them are the browser** -- two are the word "chrome" meaning window
furniture, one is Chrome Remote Desktop in an unrelated list.

**Checkup is an Edge-only tool where browsers are concerned.** Setting 15
writes one Edge policy value.

## So there are two very different jobs here

| | The guide and website | The screens |
|---|---|---|
| **Cost** | **Low.** Text. All three browsers, no detection needed. | **High.** Detect the browser, branch the advice, three sets of steps, three sets of screens to keep inside 26 lines. |
| **Risk** | None | A new branch in the middle of the run, two weeks from launch |
| **Value to the customer** | **Most of it.** They can read it at their own pace and copy the steps. | The convenience of not looking it up |

> **My recommendation, and it follows Bill's own instruction 2 exactly:**
>
> 1. **Write all of it into the guide now** -- all three browsers, the minimum
>    settings, the Primary Password tip, and the "pick one browser" rule. This
>    is the bulk of the value and it carries no build risk.
> 2. **In the tool, add one question and one answer.** *"Which browser do you
>    use most?"* -> the minimum settings for that one, and a pointer to the
>    guide page for the rest. **One screen, not a branch through the run.**
> 3. **Rewrite the reasoning wherever it appears** -- screens, website, guide
>    -- to the honest version: a browser manager is a reasonable choice, what
>    makes it safe is that nobody else can get into your PC, and here is the
>    Checkup setting that ensures that.
>
> **Item 3 is the one that should not wait**, because it is the part that is
> currently *wrong* rather than merely missing, and it is pure copy.

## WHAT DOES NOT CHANGE

***Measured, ascii44 lines 6665-6689:*** Checkup asks *"Do you use a password
manager?"* before the checklist, and if the answer is no it **leaves Edge
password saving switched on** and says why.

**That behaviour is correct and this research reinforces it.** Switching off a
senior's saved passwords when they have nothing to replace them with is how
someone ends up locked out of their own email. **Nothing in Part 3 touches
it.**

---

**Sources:**
[NCSC -- password managers](https://www.ncsc.gov.uk/collection/top-tips-for-staying-secure-online/password-managers) |
[NCSC -- what does the NCSC think of password managers?](https://www.ncsc.gov.uk/blog-post/what-does-ncsc-think-password-managers) |
[NCSC -- trusting the tech: password managers and passkeys](https://www.ncsc.gov.uk/blog-post/trust-the-tech-using-password-managers-passkeys-to-help-you-stay-secure-online) |
[Microsoft Learn -- Edge PrimaryPasswordSetting policy](https://learn.microsoft.com/en-us/deployedge/microsoft-edge-browser-policies/primarypasswordsetting) |
[Comparing browser password managers](https://rndpass.com/en/blog/browser-password-manager-comparison)
