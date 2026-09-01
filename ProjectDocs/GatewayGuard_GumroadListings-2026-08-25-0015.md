<!-- Dated: 2026-08-25 00:15 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Gumroad listings -- copy to fill in, both products

- **Document Name:** GatewayGuard_GumroadListings
- **Last Modified:** 2026-09-01 14:35 ET
- **For:** Bill, filling in the Gumroad product pages
- **Fields taken from:** Bill's screenshots of `gumroad.com/products/baeofh/edit`,
  2026-08-25 -- Name, Description, URL, Summary, Additional details, Call to
  action, Pricing, and the Settings toggle **"Specify a refund policy for this
  product"**
- **Checked against:** the live pricing section, `CLAUDE.md` product rules, and
  the 30-day refund decision

---

## BEFORE ANYTHING ELSE -- TWO THINGS THE SCREENSHOTS SHOW

**1. THE PAYOUT METHOD IS NOT CONNECTED.** Your own page says it:

> *"You haven't connected a payout method yet, so you won't be able to publish
> this product for sale."*

**Nothing can go live until that is done, so it is on the critical path** and it
is not on tomorrow's list yet. **Do it before the copy** -- the copy is useless
on a product that cannot publish.

**2. THE REFUND SETTING IS RIGHT THERE, AND IT IS OFF.** Settings section,
**"Specify a refund policy for this product"** -- currently **off** in your
screenshot. **So it is per-product, not account-wide**, which settles the
contradiction the 22 August decision document recorded and could not resolve.
**You will set it twice -- once per product.**

---

## ACCOUNT EMAIL, AND THE USERNAME THAT DID NOT CHANGE WITH IT

**Added 2026-09-01. Bill: the Gumroad account email is now
`admin@gatewayguard.co`.**

**That fits the split the project already uses.** ***measured across
`ProjectDocs\`, `WebSite\` and `CLAUDE.md`:*** `support@gatewayguard.co`
appears **46 times** and is the customer-facing address named in the licence
and the log footer; `admin@gatewayguard.co` appears **14 times** and is the
business address already given to LegalZoom, the bank, and the attorney. A
payment account is business, not support, so `admin@` is the right one.

### CONFIRM THE MAILBOX ACTUALLY DELIVERS -- IT IS NOW THE RECOVERY PATH FOR THE MONEY

***measured 2026-08-31:*** the domain's mail records are healthy --
`mx1` / `mx2.privateemail.com`, with a matching SPF record. **That proves the
domain can receive mail. It does not prove the `admin@` mailbox exists**, and
that cannot be checked from outside.

**Why it matters more than it looks.** That address now receives Gumroad's
account verification, **password resets, payout notifications and tax
documents**. If it does not deliver, the account that takes the money has no
recovery path -- and it would be discovered at the worst possible moment.

**Send a message to `admin@gatewayguard.co` from an outside address and confirm
it arrives.** Two minutes, and it closes the question permanently.

**Also check the change completed.** Gumroad normally emails the *new* address
to confirm an account-email change. If that confirmation was never opened, the
change may not have taken effect.

### DONE 2026-09-01 -- USERNAME AND BOTH SLUGS CHANGED

**Bill changed the username to `gatewayguard` and the slugs to `checkup` and
`guide`, before anything was published.** That was the free window, and it is
now closed behind him -- from here, changing either breaks live links.

***measured 2026-09-01 14:35 ET, from outside:***

| URL | Result |
|---|---|
| `gatewayguard.gumroad.com` | **HTTP 200** |
| `store.gatewayguard.co` | **HTTP 200** -- the custom domain serves |
| `store.gatewayguard.co/l/checkup` | **HTTP 200** -- "GatewayGuard Checkup" |
| `store.gatewayguard.co/l/guide` | **HTTP 200** |
| HTTPS certificate | **issued** -- Let's Encrypt, `CN=store.gatewayguard.co`, to 2026-11-30 |

**The account email is `admin@gatewayguard.co` and the mailbox is confirmed
working** -- Gumroad's confirmation message arrived in it on 2026-09-01. The
open question in the previous version of this section is closed.

### OPEN -- THE GUIDE'S PRODUCT NAME DOES NOT MATCH THE LICENCE

***measured 2026-09-01, from the live product page:*** the Guide is listed as
**`GatewayGuard Windows 11 Security Companion`**.

***measured across `ProjectDocs\`:*** the word "Companion" appears **nowhere**
as a name for this product. The record calls it the **GatewayGuard Windows
Security Walkthrough Guide** -- including in **the licence, where it is a
defined contractual term**:

> *The Guide: the GatewayGuard Windows Security Walkthrough Guide, a PDF
> document. Covered in Section 5.*

Present in three licence versions and in
`AttorneyConsult2-Revised-RefundAndGumroad-2026-08-25-1010.md`.

**So a buyer would accept a licence defining the product by a name that is not
on the page they bought it from.** Not fatal, but it is the kind of gap that
matters most in exactly the situation a licence exists for.

**Two fixes, Bill's choice:** rename the product to match the licence, or
change the licence's defined term to match the product. **The second is
cheaper today**, because the licence is already going to the attorney and this
can ride along instead of becoming a later amendment. **Decide before the
first sale.**

---

# PRODUCT 1 -- CHECKUP

### Name
```
GatewayGuard Checkup
```
*The full name here, because this is first mention to someone who has never
heard of us. The page and the receipts say "Checkup" after that.*

### URL
```
checkup
```
***DONE 2026-09-01.*** It was `baeofh`, the random slug Gumroad assigned. The
buyer sees this in the receipt and the download link, and the live URL is now
**`store.gatewayguard.co/l/checkup`**, where `baeofh` read like a mistake.

### Summary
```
Checks 19 Windows 11 security settings and fixes the ones you approve. For one PC.
```

### Call to action
```
I want this!
```
*Leave the default. It is a dropdown; nothing on the list beats it for this
buyer.*

### Description

```
Your Windows 11 PC has dozens of security settings. Most people never
see them, because Windows does not put them in one place.

GatewayGuard Checkup finds the 19 that matter, tells you in plain
words what it found, and asks your permission before it changes
anything. If you say no, nothing happens.

WHAT IT DOES

Checkup walks you through your PC one setting at a time. For each
one it tells you what the setting is for, what your PC is set to
now, and what it recommends. You decide. Nothing is changed without
you saying yes.

Where Windows will not let any program make a change, Checkup shows
you the exact steps and waits while you do it yourself. There are
two settings like that, and Checkup says so rather than pretending.

It covers Microsoft Defender (USA), your firewall, drive encryption,
sign-in, and the privacy settings that decide what your PC sends to
Microsoft. If you use Malwarebytes Free (USA), Checkup recognises it
and adjusts what it recommends.

WHAT IT IS NOT

Checkup is not an antivirus and it does not replace one. It is not
a subscription. It does not run in the background -- you start it
when you want it, and it stops when you close it.

YOU CAN READ EVERY LINE OF IT

Checkup is a plain text script. Not a compiled program you have to
trust -- a file you or anyone you trust can open and read. It is
digitally signed, so Windows can confirm it came from us and has
not been altered.

WHAT YOU NEED

Windows 11 Home or Pro. That is all. No account to create, no
sign-up, nothing to install.

WHAT YOU GET

Checkup v3.1, for one PC. A log of every choice you made, saved on
your own computer. If we issue a fix for the version you bought, it
is free.

Using more than one PC? There are packs for 3, 5 and 10 at
gatewayguard.co -- that is .co, not .com.
```

### Additional details
*Gumroad's "Add detail" fields are label-and-value pairs. Four is enough:*

| Label | Value |
|---|---|
| `Works on` | `Windows 11 Home and Pro` |
| `Settings checked` | `19` |
| `Licence` | `One PC. Yours to keep.` |
| `Source` | `Plain text you can read. Digitally signed.` |

### Pricing
```
19.99
```
*Already correct in your screenshot.*

### Refund policy -- turn the toggle ON, then:

**Policy**
```
30-day money back guarantee
```

**Fine print**
```
If Checkup is not what you expected, write to us within 30 days of
buying and we will refund you in full. You do not have to give a
reason.

You do not need to prove anything, send us a log file, or let us
try to fix the problem first. Email support@gatewayguard.co from
the address you bought with and give us your order number. We aim
to answer within two business days.
```

*This is the same wording as Section 9 of the licence and the pricing page.
**Three places, one sentence** -- keep it that way.*

---

# PRODUCT 2 -- THE SECURITY GUIDE

### Name
```
GatewayGuard Windows Security Walkthrough Guide
```

### URL
```
guide
```

### Summary
```
A plain-English PDF that walks you through your Windows 11 security settings. Five print sizes.
```

### Call to action
```
I want this!
```

### Description

```
A PDF you download and work through at your own pace.

The GatewayGuard Windows Security Walkthrough Guide covers the
settings that matter on a Windows 11 PC -- what each one does, why
it matters, and how to check and change it yourself.

WRITTEN TO BE READ, NOT DECODED

Every step says what you should see on your screen, what it should
say, and what to do if it says something else. Where a setting is
in a different place on Windows 11 Home than on Pro, both routes
are given. No step ends with "and then configure it" and leaves
you there.

FIVE SIZES, SAME WORDS

The Guide comes in five print sizes, from compact to extra-large.
Pick the one that is easiest on your eyes. The words are identical
in all five -- only the type size changes.

YOU DO NOT NEED CHECKUP TO USE IT

The Guide stands on its own. Every setting it covers can be done by
hand, and it shows you how. If you would rather have the work done
for you, GatewayGuard Checkup does the same job and asks your
permission at each step -- but the Guide is complete without it.

WHAT YOU NEED

Windows 11 Home or Pro, and a PDF reader. Every Windows 11 PC
already has one.

WHAT YOU GET

The Guide in five print sizes. Yours to keep, and yours to print.
```

### Additional details

| Label | Value |
|---|---|
| `Format` | `PDF, five print sizes` |
| `Works on` | `Windows 11 Home and Pro` |
| `Print it` | `Yes -- printing is allowed and encouraged` |
| `Needs Checkup?` | `No. The Guide is complete on its own.` |

### Pricing
```
12.99
```

### Refund policy -- same toggle, same words

**Policy**
```
30-day money back guarantee
```

**Fine print**
```
If the Guide is not what you expected, write to us within 30 days
of buying and we will refund you in full. You do not have to give
a reason.

You do not need to prove anything or explain what was wrong. Email
support@gatewayguard.co from the address you bought with and give
us your order number. We aim to answer within two business days.
```

---

## WHAT I DELIBERATELY DID NOT WRITE, AND WHY

**No claim that Checkup makes a PC safe.** It changes settings the user
approves. **Every superlative is a claim, and the banned-claims rule covers
"the only", "most" and "everyone".**

**No page counts and no setting counts for the Guide.** *The marketing plan
bans page counts*, and the Guide's own count has moved twice this month.

**"Plain text you can read", never "open source".** That term requires a public
repository and an OSI licence, and this repository is private. **Banned claim,
and Gumroad's Discover page is exactly where someone would check.**

**"If we issue a fix ... it is free" replaced "Free updates within the same
version" on 2026-08-25.** The original line promised a right the licence did not
grant -- the same store-promises-more-than-the-contract defect as the website's
Tamper Protection claim, and I wrote it. Licence v2.4 now grants free
corrections to the version you bought, in Section 2 under **Fixes to your
version**, so the store line is true as written and matches the contract word
for word.

**No mention of the annual update in either description.** It is a separate
product at $12.99 a year, and putting it in the sales copy for a one-time
purchase invites the buyer to wonder what they are really signing up for.
**FP-21 -- how a buyer receives and pays for a yearly update -- is still
open**, so selling it before it works would be the worst kind of promise.

**"gatewayguard.co -- that is .co, not .com"**, spelled out, because it is the
one line a reader may retype.

---

## AFTER YOU FILL THESE IN

**Three things, in this order.** *(This section was first written in the sort
of language this project bans -- "chain", "end to end", "no rehearsal". Bill
caught it. Rewritten plainly, because a rule you only apply to customer copy is
not a rule.)*

**Three things, in this order:**

1. **Connect the payout method.** Nothing publishes without it.
2. **Set both refund toggles.** Two products, two toggles.
3. **Buy your own product yourself, with your own credit card, exactly the way
   a customer would. Then give yourself the refund.**

   **Nobody has ever bought anything from our store.** Not once. So we do not
   know that the payment goes through. We do not know that the download arrives
   in the buyer's email. We do not know that the refund button does what it
   says.

   **Buying it yourself is the only way to find out.** Use a real card, not a
   test one -- a test card does not prove a real one works.

   **If something is broken, we want to be the ones who find it.** Not the
   first person who trusts us with $19.99.
