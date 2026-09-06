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

## 2. WHAT THIS SETTLES

**The build's own open note is answered.** ***Measured, ascii44 line 646:***
the header carries `note 14 ... Edge phishing vs SmartScreen needs research`.

**They are one feature under two names.** Edge's control is a front end for
Microsoft Defender SmartScreen -- Edge says so in its own subtitle. So
Checkup's **setting 4 (SmartScreen)** and **setting 6 (Edge phishing
protection)** are not two protections; they are the Windows-level switch and
the Edge-level switch for the same engine.

---

## 3. WHAT IT PUTS IN DOUBT -- AND THIS NEEDS CHECKING BEFORE ANY COPY MOVES

***Measured, ascii44 line 6533:*** after applying setting 6, Checkup tells the
user:

```
All 3 phishing protection options enabled -- GOOD
```

**Bill's write-up describes ONE toggle, not three.**

Two explanations, and I have not separated them:

1. **Edge changed its layout.** The three separate options were consolidated
   into one control, and our message is describing a page that no longer
   exists.
2. **The message is counting registry values, not screen controls.** Checkup
   writes several policy values and the message counts those -- which would be
   an internal count shown to a user as if it described their screen.

**Either way it is a breach of the literal-on-screen-labels rule**: a senior
told "3 options" who then finds one switch does not know if the tool worked.

**Do not change the message on the strength of this document.** It is an
unverified Gemini answer. **The check is to open `edge://settings/privacy/security`
on a real machine and count what is actually there.**

---

## 4. WHY THIS ALSO MATTERS TO SETTING 20

Bill's answer to question 3 was **B: nuisance-software (PUA) blocking becomes
setting 20**. That setting has an Edge half that Windows does not let a program
change, so Checkup must show the steps.

***The Edge PUA control lives on this same page*** -- the Security section of
`edge://settings/privacy/security`. So the wording written for setting 20's
manual steps and the wording checked for setting 6 describe the same screen,
and they must be written together or they will disagree.

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
