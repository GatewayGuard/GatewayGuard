# Field result: setting 6 -- the copy is right, the instruction is not, and CanAuto is a lie

# Dated: 2026-08-26 11:30 ET

**Source:** Bill's eyes on both machines, 2026-08-26, answering the
`Check-SandyQuestions` items *"Is there a 'Phishing protection' section?"* and
*"how many checkboxes under it? 3 / 4"*.

**His answer, verbatim:** *"both cgdell and sandy have all 4 phishing boxes and
Sandy has all 4 on as I selected them"* and *"only the first three say warn, the
4th starts with automatically collect."*

---

## 1. THE QUESTION MICROSOFT'S TABLE COULD NOT ANSWER IS ANSWERED, IN THE BUILD'S FAVOUR

`Check-SandyQuestions` raised this as a live doubt: *"Microsoft's edition table
does not list Home. Checkup applies setting 6 on Home anyway (`SkipOnHome` is
false)."*

***measured:*** SANDY is **Windows 11 Home** and has the **full Phishing
protection section with all four boxes.**

**The edition table is incomplete. `SkipOnHome=$false` on line 5623 was right and
needs no change.** THE FIELD WINS.

---

## 2. THE "ALL 3" COPY IS CORRECT. I WAS WRONG TO SUSPECT IT

**Six user-facing strings in the build say "3":**

| Line | String |
|---|---|
| 5623 | setting name -- `"Edge Phishing Protection (all 3)"` |
| 5623 | description -- *"password reuse, unsafe password storage, and malicious sites"* |
| 5961 | `"Not configured -- all 3 need to be enabled"` |
| 5970 | `"Service OFF -- all 3 need attention"` |
| 6398 | `"All 3 phishing protection options enabled -- GOOD"` |
| 6406 | `"3. Under Phishing protection -> turn ON all 3 options"` |

**When Bill first said "4 boxes" I read it as a six-place copy defect.** It is
not. The fourth box begins **"Automatically collect"** -- it is a **data
collection** box, not a protection box. The three that say **"Warn me about"**
are the three the build means, and they are the three it names.

**Two readings fitted the same evidence and I did not publish the first one.**
That is the rule working. The thing that separated them cost one question: *what
do the four boxes actually say?*

---

## 3. BUT THE INSTRUCTION IS UNSAFE AS WORDED, AND THE FIELD PROVED IT IMMEDIATELY

Line 6406, shown on screen when the registry write is refused:

> `3. Under Phishing protection -> turn ON all 3 options`

**Four boxes are visible. The instruction names none of them.** A user counts
four, is told "all 3", and resolves the mismatch however they like.

***This is not hypothetical. It happened during this measurement.*** Bill turned
on **all four**, including the collection box, on SANDY.

**And the fourth box is one this product argues against elsewhere in itself:**

| Checkup setting | What it does |
|---|---|
| **ID=11** `"Advertising ID -- Turn Off"` | *"Stops Windows from tracking you for ad targeting."* |
| **ID=12** `"Diagnostic Data -- Required Only"` | *"Limits data sent to Microsoft to the minimum required."* |

And `WebSite\html\diagnostic-data.html`: *"The change is that Microsoft receives
less information about how you use your PC."*

**So Checkup spends two of its nineteen settings reducing what Microsoft
collects, and setting 6's instruction can talk a user into switching a
collection box on.** The two settings are not in conflict -- the *instruction*
is.

### What the build actually writes -- and this half is right

The apply block, lines 6392-6397, sets exactly four values:
`ServiceEnabled`, `NotifyMalicious`, `NotifyPasswordReuse`, `NotifyUnsafeApp`
-- the master plus the three warns. **Checkup does not write the collection
box.** Its behaviour is correct. Only its wording is loose.

### The fix, and it is small

Name the three boxes with their literal on-screen labels, and say to leave the
fourth alone. This is **D-18** -- reuse the words on the user's own screen --
and `NotifyUnsafeApp` already carries an FT-142 comment (line 5975) warning that
the registry name and the screen label differ.

**Not measured: the exact wording of the fourth box beyond its opening,
"Automatically collect".** Get the full label before writing the replacement
line, so the instruction can name it exactly.

---

## 4. `CanAuto=$true` ON SETTING 6 IS NOT TRUE ON EITHER MACHINE

***measured on CGDELL 2026-08-26, elevated:***

```
Test-Path  HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components  ->  True
Get-ItemProperty                                          ->  System.Security.SecurityException
                                                              "Requested registry access is not allowed."
```

***measured on SANDY, elevated,*** `SandyChecks-SANDY-2026-08-26_11-14.txt`:
`WTDS\Components  CANNOT READ -- Requested registry access is not allowed.`

**The key exists on both machines and can be read on neither.**

Line 5623 declares setting 6 **`CanAuto=$true`**. Setting 3, Tamper Protection,
honestly declares **`CanAuto=$false`** because Windows forbids programmatic
change. **Setting 6 is in the same position and has not admitted it.**

The build's own comment, line 5931, states why this can never come right:

> *"Checkup RECOMMENDS turning Tamper Protection ON (item 3). Every user who
> follows our own advice makes this read fail permanently. The method is
> unusable for a correctly-hardened machine, not merely fragile."*

**So on every machine Checkup finishes with, setting 6 reports "Unknown --
verify by hand" and its apply takes the manual path.**

**Recommended for ascii44: `CanAuto=$false`.** It costs no capability -- the
user already receives the manual steps -- and it stops the checklist promising
an automatic action that cannot happen.

### One suspicion checked and dismissed

The detect block treats both `SecurityException` **and**
`UnauthorizedAccessException` as blocked; the apply block catches only
`SecurityException`. If the thrown type were the other one, apply would fall to
the generic catch and the numbered manual steps would never appear.

***measured:*** the type thrown is **`System.Security.SecurityException`** --
the one apply catches. **The manual-steps screen does fire. No defect here.**

**Not measured: whether the WRITE is refused, only the read.** Testing it would
change the machine. The refusal is near-certain but is not recorded as measured.

---

## 5. SANDY'S STATE CHANGED BEFORE THE FIELD RUN

**Bill enabled all four boxes on SANDY, including collection.** Settings 11 and
12 will run on that machine during the ascii43 field test.

**Turn the fourth box back off before the run**, or the field log will record a
starting state nobody intended and the two privacy settings will be read against
it.
