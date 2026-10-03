# Note to Claude Cloud -- 2026-08-28

# Dated: 2026-08-28 13:00 ET

**Read `CURRENT.md` first, then this. Base every factual sentence on something
you can name.** Three of my own claims were wrong this session and the pattern
is in section 4 -- it is worth your attention before you write anything about
the field checklist.

---

## 1. THE THING THAT CHANGED MOST: THE SECOND DRIVE IS PROVEN

**F4 was blocked from 2026-08-22 on a measurement nobody had taken. It is
taken.**

***measured, SANDY 2026-08-28:*** Defender full scan **06:25:40 to 07:47:17**,
every detection logged **07:47:16**, **12 of 12 specimens, six on each drive**,
including inside a ZIP where the report names the file *within* the archive.
Malwarebytes independently agrees: **12 of 12, 1 hour 12 minutes, 719,478
files**, both drives ticked.

**The ZIP is what makes it unambiguous.** Real-time protection never caught it
-- it does not practically open archives on write. Only a scan does.

**So the screen may say "full scan of all your drives."** It must never say
"offline scan" -- ***measured 2026-08-22***, `Start-MpWDOScan` has no scope
parameter. The call is `Start-MpScan -ScanType FullScan`.

**Consequence for the website:** the pricing page's *"scans your drives again"*
was knowingly left standing as a claim the product could not meet. **The
measurement it waited on now exists.** It is still false until F4 is in a build,
so do not quietly treat it as fixed.

---

## 2. WHAT THIS DOES NOT MEAN -- TWO ATTEMPTS WERE VOIDED FIRST

**Do not read any earlier detection record as scan evidence.** The 2026-08-27
record shows eleven detections in **six seconds, in the test kit's own write
order**. That is real-time protection catching files as they are written. I read
it as scan evidence once and withdrew it.

**And the second attempt was voided by the security model, not by error.** Bill
turned real-time protection off so specimens would survive; **Windows turned it
back on when the scan started.** SANDY is `IsTamperProtected True`, and Checkup
*recommends* Tamper Protection -- so the tool's own advice makes that
measurement impossible. Same shape as FT-141.

**The discriminator was the SHAPE of the timestamps, not their presence.** A
scan reports at completion; real-time protection reports per file as written.

---

## 3. SIX NEW FINDINGS -- FT-236 TO FT-241

Full detail: `ProjectDocs\GatewayGuard_FieldTestTriage-ascii43run1-2026-08-28-0930.md`.
**The run is not finished** -- Bill reached screen 26 of the journey.

- **FT-236 (high).** 192 of 328 log lines are one warning: a line truncated to
  fit a **60-column** window. **FT-217 is not the defect -- it is the thing that
  noticed.** The defect is that nothing told the user; screen 1's maximize
  wording is advice and nothing verifies it.
- **FT-237 (medium).** Setting 6 logs `[ERROR] SILENT ERROR` on a healthy
  machine. **That log is the file we tell customers to email support.**
- **FT-239.** Windows restores real-time protection by itself, and ***measured:***
  **zero** mentions of that in `defender-realtime.html`. **Guide work, and it is
  yours if you are writing that page.**
- **FT-240 (medium).** *"About 25 minutes to an hour"* on a screen that four
  lines earlier says tick every drive. ***measured: 1 hour 12 minutes***, and
  SANDY's second drive is **92% empty**. A full 1 TB drive is several times over.
  **The harm is not inaccuracy** -- three lines below, the screen warns that
  closing the results without quarantining means scanning again. A wrong number
  makes them cancel, directly above a warning never to cancel.
- **FT-241 (low).** *"Takes about 5-10 minutes"* never says what takes 5-10
  minutes.
- **FT-238.** An offline-scan scare, resolved by timeline. No action.

---

## 4. THREE OF MY OWN ROWS WERE WRONG. READ THIS BEFORE TRUSTING ANY TABLE I BUILT

I built a twelve-row table mapping findings to screens. **The screen mapping was
mechanical and right in all twelve. The description column was right in the
seven rows whose source comment I had opened and wrong in all three I had not.**
I also cited **two FT numbers that do not exist**.

**The mechanism: the mapping answered WHERE, and I let it stand in for WHAT.**
Two findings can share a function and do unrelated jobs -- FT-219 and FT-221 both
live in the apply path and are a permission rule and a password-manager guard.

**Worse: the 2026-08-22 checklist already had all four right, with line
numbers.** I replaced verified sentences with guesses while rebuilding. **If you
are ever regenerating a document that already exists, carry the verified
sentences forward rather than re-deriving them.**

**A gate now exists: `Tool2\Run-ChecklistClaimsCheck.bat`.** It proves every
finding cited exists in the build **or** in another project document
(corroboration -- absence from the build is legitimate for a never-built
finding), lists findings sharing a function, and **prints each finding's real
source comment beside the citation** because no machine can judge whether prose
matches intent. **Run it against anything you write that cites FT numbers.**

---

## 5. BILL'S TWO INSTRUCTIONS THIS SESSION -- THEY APPLY TO YOU TOO

1. **"Stop assuming and always check before answering or research if
   necessary."**
2. **"Provide me with layman non-technical explanations without the FTs and
   Gates you quote."**

**The second is the plain-language rule pointed inward.** The product forbids
jargon on the website, in the guide and on screen. It applies to what we say to
Bill. **Keep reference numbers in documents where he will quote them; keep them
out of explanations.**

---

## 6. OPEN, AND WHERE YOU CAN HELP

**Unverified and yours if you want it** -- six items in
`GatewayGuard_Windows26H2-Watchlist-2026-08-26-1215.md` section 3 came from a
search summary I could not confirm against three Microsoft build pages. **Secure
Boot badges in Windows Security is the one that reaches the guide**: if Microsoft
is adding green/yellow/red badges under Device security, our Secure Boot steps
describe a screen that changed, and the literal-on-screen-labels rule applies.

**The licence.** Ours covers 13 of Malwarebytes' 16 sections. **Two genuine gaps:
a Feedback clause, and privacy -- the word appears zero times and no policy
exists**, while the plan includes an email list scaling to 100,000 addresses.
Four more (arbitration, entire-agreement, assignment, export) are already in our
own Appendix marked "confirm they were declined rather than simply not reached."

**`gatewayguard.co/compatible` does not exist**, and Section 6's warranty is
defined by reference to it. **`gatewayguard.co/license` does not exist either**,
and the Gumroad checkout plan depends on it.

**Two website items still open:** the pricing page's second-drive claim (above),
and **two index files differing by 102 lines** with nobody having said which is
live.

---

## 7. WHAT I WOULD NOT TOUCH

**The nineteen settings are frozen.** Search indexing auto-expansion
(`Settings > Privacy & security > Search`, new in 26H2) belongs in
`FutureSettings`, not in a build.

**ascii43 is half built and is not the shipping build.** ascii44 is. Do not
write copy that assumes F4, the F6 wording block or the F5 remnants exist.
