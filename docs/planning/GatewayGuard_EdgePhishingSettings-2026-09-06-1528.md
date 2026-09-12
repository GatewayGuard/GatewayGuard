<!-- Dated: 2026-09-06 15:28 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Edge phishing / SmartScreen settings -- the write-up Cloud asked for twice

- **Document Name:** GatewayGuard_EdgePhishingSettings
- **Supplied by:** Bill, 2026-09-06, in `ProjectDocs\Bills 16 Decisions.txt`
  answer 15. **This is the "See below gemini write up" referenced at screen 25
  of the ascii43 field notes, which did not survive into that file.**
- **Basis:** *unverified as supplied* -- it is a Gemini answer, reproduced
  below exactly as Bill gave it. **It has not yet been checked against a real
  Edge settings page.** That check is item 3 on my list.

---

## 1. AS SUPPLIED, VERBATIM

> To locate and manage phishing and security protection settings in Microsoft
> Edge, follow these steps:
>
> Open Microsoft Edge.
>
> Type or paste `edge://settings/privacy/security` directly into your Edge
> address bar to jump straight to the security settings page.
>
> Scroll down to the **Security** section.
>
> Locate **Protect from harmful sites and downloads** -- *Uses Microsoft
> Defender SmartScreen* -- and turn it **On** or **Off** to protect against
> phishing scams and malicious sites.

---

## 2. WHAT THIS SETTLES -- THERE ARE THREE CONTROLS HERE, NOT TWO

**I first read this as confirming that setting 4 and setting 6 are the same
engine under two names. That was wrong, and checking the source settled it in
about a minute.** There are **three separate controls**, and Checkup handles
two of them.

| | What it is | Where the user finds it | Checkup |
|---|---|---|---|
| **Setting 4** | Windows SmartScreen for apps and downloads | Windows Security -> App & browser control | ***measured, ascii44 line 6498:*** writes `HKLM\...\Explorer\SmartScreenEnabled` |
| **Setting 6** | **Windows Enhanced Phishing Protection** | Windows Security -> App & browser control -> **Reputation-based protection -> Phishing protection** | ***measured, ascii44 lines 6527-6533:*** writes four values under `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components` |
| **What Bill's write-up describes** | **Edge's own** "Protect from harmful sites and downloads" | `edge://settings/privacy/security` | ***measured: nothing. There is not one reference to an Edge policy key in the whole build.*** |

**So the write-up names a control Checkup does not check at all.** That is the
useful finding in it, and it is worth more than the confirmation I first
thought it was.

---

## 3. THE "ALL 3" MESSAGE IS CORRECT. THE SETTING'S NAME IS NOT.

***Measured, ascii44 line 6533:*** after applying setting 6, Checkup says
*"All 3 phishing protection options enabled -- GOOD."*

**I flagged this as a possible mismatch with Bill's one-toggle description. It
is not a mismatch -- I had aimed it at the wrong feature.** *Sourced, Windows
11 documentation and coverage of Reputation-based protection:* the **Phishing
protection** panel carries exactly **three** switches -- warn about malicious
apps and sites, warn about password reuse, warn about unsafe password storage.
Checkup writes those three plus the master `ServiceEnabled`. **The message
matches what the user sees on that panel.**

### THE REAL DEFECT IS THE NAME, AND THE USER READS THE NAME

***Measured, ascii44 line 5758:*** the setting is called

```
Name = "Edge Phishing Protection (all 3)"
```

**It has nothing to do with Edge.** It writes Windows WTDS values, and its own
manual-steps text correctly sends the user to **Windows Security -> App &
browser control -> Reputation-based protection**, which does not mention Edge
either.

**And the website already has it right.** ***Measured,
`WebSite\html\phishing-protection.html`:*** the page title is **"Enhanced
Phishing Protection -- Setting 6"**, and the only time it says "Edge" is when
referring to setting 15. It names App & browser control and Reputation-based
protection, exactly as the panel does.

> **So the build and the website disagree about the name of setting 6, and the
> build is the one that is wrong.** That is a RULE W-07 / D-18 failure running
> in the unusual direction -- normally the website drifts from the tool.
>
> **Why it matters to a customer, not just to us:** the checklist row is what
> a senior reads when deciding what to leave selected. Someone who uses Chrome
> can reasonably deselect a row labelled "Edge Phishing Protection" -- and
> deselect a protection that has nothing to do with which browser they use.
>
> **The fix is the name, in one place, to match the website and the panel:**
> `Enhanced Phishing Protection (all 3)`. Same length class, no box-width
> risk, no behaviour change.

---

## 4. WHY THIS MATTERS TO SETTING 20

Bill's answer to question 3 was **B: nuisance-software (PUA) blocking becomes
setting 20**. Its Edge half is a control Windows does not let a program change,
so Checkup must show the steps.

***That Edge half lives on the page Bill's write-up describes*** -- the
Security section of `edge://settings/privacy/security` -- **which is the same
page as the Edge SmartScreen toggle Checkup does not currently check.**

**So one screen in Edge carries two things we care about**, and setting 20's
manual steps will be walking the user to it. **Write both at once.** Sending a
senior to that page twice, in two builds, with two different explanations, is
how the guide and the screens drift apart.

**An open question this raises, and I am not deciding it:** if Checkup is
already sending the user to that page for setting 20, should it also read and
report the Edge SmartScreen toggle sitting three lines above? It is one more
read of a browser we already read four other things from. **It is a question
for after the ascii44 field run, not a change to make now.**

---

## 5. HOW TO VERIFY THE SETTING ACTUALLY WORKS

*Sourced, AMTSO (Anti-Malware Testing Standards Organization):* there is a
**PUA test file** the security industry has agreed to detect **only when PUA
blocking is enabled**, and a **phishing test page** on the same site. Neither
is malicious. If the PUA file downloads successfully, PUA blocking is off.

- [AMTSO Security Features Check tools](https://www.amtso.org/security-features-check/)
- [AMTSO Feature Settings Check -- Potentially Unwanted Applications](https://www.amtso.org/feature-settings-check-potentially-unwanted-applications/)

**This gives setting 20 something none of the other nineteen have: a
yes/no proof, on the customer's own machine, that the setting took effect.**
