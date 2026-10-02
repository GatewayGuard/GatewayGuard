<!-- Dated: 2026-10-02 11:56 ET -->
<!-- Stamped by Claude Code: the time this file arrived on CGDELL (file creation time, measured). -->
<!-- Editor: Claude Cloud -->
# Website changes so the site matches the guide

- **Document Name:** GatewayGuard_WebsiteChanges-ToMatchGuide
- **From:** Claude Cloud
- **For:** Claude Code, in `WebSite/html/`. One page per commit; re-run the page gates.
- **Status:** CHANGE LIST. Rule W-07: the guide wins.
- **How to read the "Old" text:** it is the text Claude Code extracted on 2026-09-28 (`ForCopilot-2`), plus the live `password-manager.html`. **In the HTML, dashes and quotes are entities** (`&#8212;`, `&#8217;`), so match on the entity form.

---

## PROVENANCE

1. **Stamp:** `CURRENT.md` Generated **2026-09-30 16:43 ET**, commit **`6f3ab29`**, made 16:23 ET, subject *"Gate 27 extended: A1 regenerates CURRENT.md into any ProjectDocs commit..."*.
2. **Bases:**
   - **The pages:**
     - `WebSite/html/password-manager.html`, read live.
     - `GatewayGuard_ForCopilot-2-WebsitePages-2026-09-28-2123.md`, which holds text extracted from `WebSite/html/` on 09-28, for `phishing-protection`, `widgets`, `defender-realtime`, `diagnostic-data` and `advertising-id`.
     - `widgets.html`'s *Why* section, from the 08-22 source pack. **Re-check it against the live page before applying.**
   - **The work list:** `CLAUDE.md`, Approved Products, which lists the five pages with product names. Triage W-a to W-f.
   - **The text the pages must match:**
     - Guide Parts 2-3 twins, after the companion change list.
     - The final Part 1/4/5 file.
3. **The five pages in `CLAUDE.md`, and where each stands** (***measured*** by Claude Code at `90c1897`, 2026-09-26):

   | Page | Status |
   |---|---|
   | `periodic-scanning.html` | **Retired** to `Archive\` |
   | `defender-realtime.html` | Clean of product names (W-d still applies) |
   | `tamper-protection.html` | Clean of product names |
   | `password-manager.html` | **Still names products: W1** |
   | `phishing-protection.html` | **Still names a product: W2** |

4. **Carried forward:** nothing from a draft. New sentences are the guide's own words, or name their source.
5. **Not seen:** `windows-hello.html` in full (W-g below comes from its extracted text), `remote-desktop.html`, `edge-startup.html`, `bitlocker.html`.

---

## ALL SETTING PAGES

**W-0 ·** Every *"Setting N of 19"* becomes *"Setting N"*. Claude Code: grep `of 19` across `WebSite/html` and report the count before and after.

---

## THE PRODUCT-NAME PAGES

### W1 · `password-manager.html` (with W-a)

**1. Intro line**
- **Old:**
  > Edge offers to save your passwords so it can fill them in automatically. It is convenient, but it stores all your passwords in one place tied to your browser — if your PC is compromised, every saved password goes with it.
- **New:**
  > Edge offers to save your passwords so it can fill them in automatically. If you do not use a separate password manager, letting Edge save your passwords is much better than reusing weak passwords or keeping them where others can find them. Checkup turns this off only if you tell it you already use a separate password manager.
- **Checked against:** Guide Part 3, Setting 15, *When You Might Choose Differently*, and its permission line.

**2. *Why you might want this off* (both paragraphs)**
- **Old:**
  > A browser password manager is a convenient single point of failure. If someone gets into your Windows account — either by sitting down at your PC or by malware running on it — they can export every password Edge has saved in a few clicks. All your banking, email, and shopping accounts go at once.
  >
  > A dedicated password manager like Bitwarden (free) or 1Password keeps your passwords in an encrypted vault...
- **New:**
  > If you already use a separate password manager, having Edge save passwords too means two places holding the same passwords, and one is easier to keep track of.
  >
  > If someone gets into your Windows account, they may be able to get at the passwords saved in your browser. A separate password manager keeps your passwords behind its own master password.
- **Checked against:**
  - Triage W-a, in its own suggested words.
  - Guide Part 3, Setting 15 ("Using multiple password managers can create confusion").
  - **No product names.**

**3. The *"Recommended free alternative: Bitwarden"* note box**
- **Delete the whole `note-box` div**, including its COPYCHECK comment.
- **Checked against:** Bill, 2026-09-25: no password-manager names anywhere.

### W2 · `phishing-protection.html` (with W-b)

**1. The product name**
- **Old:**
  > ...a dedicated password manager (such as Bitwarden, which is free) is the right tool for that job.
- **New:**
  > ...a password manager is the right tool for that job.

**2. The FBI figure**
- **Old:**
  > In 2025, people aged 60 and over filed more than 200,000 complaints with the FBI’s Internet Crime Complaint Center, and phishing and spoofing were among the most reported.
  >
  > Source: FBI Internet Crime Complaint Center, 2025 Internet Crime Report .
- **New:**
  > In 2025, people aged 60 and over filed more than 200,000 complaints with the FBI’s Internet Crime Complaint Center.
  >
  > Source: FBI Internet Crime Complaint Center, *2025 Internet Crime Report*, page 4.
- **Checked against:**
  - *sourced*, the 2025 IC3 Report: complaints by age, **60+: 201,266 complaints, $7.7 billion in losses**, in the section headed *IC3 Complaints in 2025*, page 4 of the report's own numbering.
  - **The phishing clause is dropped.** I found it only in secondary write-ups, not in the report text I could read.
  - **Claude Code:** open the PDF at ic3.gov and confirm the page number before publishing.

---

## TRIAGE W-c TO W-f

### W-c · `widgets.html`

**1. Intro line**
- **Old:**
  > Windows Widgets is the news, weather, and sports panel that appears on your taskbar. It sends information about what you read and click back to Microsoft. Turning it off removes the panel and stops that data sharing.
- **New:**
  > Windows Widgets is the news and weather panel on the left of your taskbar. Turning it off removes the button and the panel.

**2. *Why you might want this off* (both paragraphs: "Widgets sends your reading and browsing habits..." and the WebView2 memory paragraph)**
- **New:**
  > The news part of the panel carries advertising, and scam adverts have appeared in Microsoft's news feed. Microsoft also says the feed becomes more personalised the longer you use it.
- **Checked against:**
  - Guide Part 3, Setting 14.
  - *sourced* in `GuidePart3-Sources-2026-09-25-1320` (scam ads), and in Cloud's 08-24 Widgets research (Microsoft on personalisation).
  - **Memory:** ***measured*** at 27.2 MB (M-2), so no memory claim.

**3. Add, after the permission line**
- **New:**
  > On Windows 11 Home, Windows may not let Checkup make this change. Checkup then shows you the steps: press the Windows key, type **taskbar settings**, press Enter, and turn **Widgets** Off.
- **Checked against:** ***measured***, FT-283 (SANDY, twice); brief A8.

**4. *What to expect***
- **Old:**
  > With Widgets off, the weather and news icon disappears from your taskbar. Your PC will use slightly less memory in the background. Everything else on your PC works exactly the same...
- **New:**
  > With Widgets off, the weather and news button disappears from your taskbar. To confirm it is off, press the Windows key and W together. Nothing should open. Everything else on your PC works exactly the same...
- **Checked against:** ***measured*** C13.

**5. The closing paragraph**
- **Old:**
  > This is more than a taste. The panel builds a record of what you read and click, and Microsoft says it becomes more personalised the longer you use it. Checkup turns it off with your permission...
- **New:**
  > Checkup turns it off with your permission, and you can turn it back on whenever you like.

### W-d · `defender-realtime.html`

- **Old:**
  > Defender is free, built-in, and consistently rated by independent labs as one of the best antivirus engines available. You don’t need to pay for a separate product — you just need to make sure Defender is on and set up correctly.
- **New:**
  > Defender is free and built into Windows. What matters is that it is on and set up correctly.
- **Why:**
  - The lab claim has no named, current test behind it (PL-4; triage W-d).
  - *"You don't need to pay for a separate product"* is also dropped. ***Measured*** on CGDELL 2026-09-07/08: Defender flagged 0 of 6 unwanted programs that another product caught (`CLAUDE.md`). The site should not promise more than the guide does.

### W-e · `diagnostic-data.html`

**1. *Action taken*, second and third sentences**
- **Old:**
  > This is the minimum level Windows needs to function and receive updates. It does not affect performance or updates in any way.
- **New:**
  > Microsoft says the Required level is the minimum it needs to keep Windows secure and up to date.

**2. *Why you might want the minimum* (both paragraphs)**
- **New:**
  > Windows sends Microsoft a basic report on your PC's health at either level. The Optional level adds the websites you visit in Edge, which programs you use, and copies of memory when a program crashes. Those copies can include parts of a file you had open.
  >
  > This is a privacy choice. Choosing Required does not weaken your security.
- **Checked against:**
  - Guide Part 3, Setting 12, word for word where possible.
  - *sourced*, privacy.microsoft.com/data-collection-Windows and support.microsoft.com/help/4468236.

**3. *What to expect***
- **Old:**
  > No restart required. Windows continues to receive all updates and works exactly the same. The change is that Microsoft receives less information about how you use your PC.
- **New:**
  > No restart required. Windows keeps receiving updates. The change is that Microsoft receives less information about how you use your PC.

**4. The *"This is more than a taste..."* paragraph**
- **New:**
  > Checkup makes this change with your permission.

### W-f · `advertising-id.html` -- **apply after Bill rules on guide G2**

Guide Part 3, Setting 11 still says **both** *"This is a privacy setting, not a security risk"* and *"This is more than a taste."* The page must say what the guide says.

- **If Bill keeps only the first:** apply all four changes below.
- **If he keeps "more than a taste":** apply 1 to 3. In 4, keep one instance of that sentence and delete the others.

**1. Intro line**
- **Old:**
  > Windows assigns your PC a unique tracking number that apps use to follow your activity and show you targeted ads. Turning it off removes that number and stops apps from tracking you across different programs.
- **New:**
  > Windows gives your account an advertising number that apps can use to pick ads for you. Turning it off means apps can no longer use that number.

**2. *Why*, first paragraph**
- **New:**
  > The Advertising ID is a number Windows assigns to your account. Apps that use it can recognise you across different programs and use that to pick the ads you see. Think of it like a loyalty card number that you did not sign up for.

**3. *Why*, second paragraph**
- **New:**
  > Turning it off does not reduce the number of ads you see. Apps simply can no longer use this number to tailor them to you.

**4. *What to expect*, last paragraph**
- **New:**
  > Checkup turns it off with your permission, and you can turn it back on whenever you like.

**Checked against:** Guide Part 3, Setting 11, *Why It Matters*. Triage W-f keeps the loyalty card and drops "advertisers you have never heard of" and the repeated "record of what you do".

---

## FOUND WHILE READING -- the guide wins here too

**W-g · `windows-hello.html` contradicts what was just read off the screen.**

- **What the page says** (08-22 source pack and the live page fragment): *"Forgot your PIN? On the sign-in screen, click I forgot my PIN. Windows will verify your Microsoft account password..."*, and in the setup steps, *"Windows will ask you to verify your Microsoft account password first."*
- **What was measured:**
  - S2: the lock screen shows **Enter your PIN** and **Sign-in options**, and **no "I forgot my PIN" link**.
  - Most readers are on a **local** account.
- **Change:**
  - Replace the *Forgot your PIN?* box with Guide Part 2, Setting 9's line: *"If you ever forget your PIN, click Sign-in options, choose the key symbol, and sign in with your password."*
  - Replace *How to check* with Setting 9's Windows key + L check.
  - Drop "Microsoft account" from the setup step: *"Windows will ask for your password first."*
- **Why it matters:** this is a page a reader opens at the moment they are locked out.

**Pages to check against the new guide text, not read here:**

| Page | Check against | What to check |
|---|---|---|
| `remote-desktop.html` | Part 3 Setting 10 | The Home message, and the Quick Assist camera line |
| `edge-startup.html` | Part 3 Setting 13 | The briefcase line, and both toggle labels |
| `bitlocker.html` | P2-5 and P2-6 | The local-account sentences, and where the key goes |
| `fast-startup.html` | P3-13 | "Restart always does a full shutdown" |

---

## FOR CLAUDE CODE

```
Website changes: GatewayGuard_WebsiteChanges-ToMatchGuide-<stamp>.md.
Order: W1, W2 (product names) -> W-g (locked-out reader) -> W-c, W-e, W-d
-> W-0 (all pages) -> W-f after Bill's G2 ruling -> the four pages to check.
Match Old text in its entity form. One page per commit; page gates after
each. Then re-grep WebSite\html for Bitwarden|1Password|KeePass|Malwarebytes|
Norton|McAfee|Avira|LastPass (expect 0) and "of 19" (expect 0).
W2: confirm the IC3 2025 report's page number at ic3.gov first.
```
