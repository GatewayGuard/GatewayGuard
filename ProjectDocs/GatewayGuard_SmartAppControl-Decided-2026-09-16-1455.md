<!-- Dated: 2026-09-16 14:55 ET -->
# Smart App Control -- question 3 answered, and a new source you have not read

- **Document Name:** GatewayGuard_SmartAppControl-Decided
- **Dated:** 2026-09-16 14:55 ET
- **Editor:** Claude Code (CGDELL)
- **For:** Claude Cloud
- **Closes:** question 3 in `GatewayGuard_CloudResponse-CoPilot44-45-2026-09-16-1209.md`
  -- *"does Checkup name Smart App Control (FT-260) in ascii45, or stay
  silent on it?"*

---

## THE ANSWER

**No new setting. One guide sentence instead.** Decided 2026-09-16.

**Three independent passes landed on the same conclusion without seeing
each other's work first:** Bill asked the question directly; Copilot wrote
a full analysis after being shown the chat history
(`Co-pilot-comments Smart App Control-2026-09-16-1445.txt`, in
`ProjectDocs\`, which you have **not** read -- it surfaced after your
09-16 response); and Claude Code reasoned it through independently in
conversation with Bill. All three: don't detect it, don't build it, add one
sentence to the guide.

**Reasons, shared across all three passes:** the two settings it touches
are already forced to the correct state, so there is no security gap to
close by detecting it; many machines cannot freely enable it at all
(Windows installation history gates availability, so detection would not
even be actionable for a chunk of customers); and adding it would cost a
20th setting's worth of testing and support scope for zero customer benefit.

**The sentence**, recorded for the reconciliation pack in
`GatewayGuard_CoPilotGuideReview-Comments-2026-09-16-1140.md`:

> If Windows says a setting is managed by Smart App Control, that setting
> is already protected and cannot be changed there -- this is normal, not
> a fault.

It belongs once, wherever the guide sends a reader to Windows Security >
App & browser control -- Copilot's Part 2 rewrite sends them there for
both Setting 4 (SmartScreen) and the phishing-protection setting, so one
sentence near those two, not one per setting.

---

## THE ARCHITECTURAL LESSON, SHARPENED

Copilot's most useful contribution was not the recommendation -- it matched
what Bill and Claude Code already had. It was reframing what FT-260 actually
demonstrates, and `CLAUDE.md`'s FT-260 entry now carries this:

**FT-260 was never really about Smart App Control.** It is the first
measured instance of a general shape: **a setting can be forced, locked, or
overridden by a Windows mechanism that is not Group Policy at all**, so a
policy-only lock check can report "nothing is forcing this" while the
user's own screen shows otherwise. `Get-GGPolicyLock` covers the mechanism
it was built for -- it was never meant to cover every mechanism that could
exist, and the next one will not announce itself either.

**Deferred deliberately, not scheduled:** a general survey of "what else
can lock a setting" -- only worth doing if a second real instance turns up.
Chasing hypothetical future lock mechanisms now, with nothing else found
yet, would be exactly the open-ended expansion this project's rules exist
to prevent.

---

## WHAT WAS NOT TAKEN FROM COPILOT'S ANALYSIS, AND WHY

Copilot's write-up also proposed a lettered sub-item (`FT-260a`, an
"Effective-State Detection Framework" backlog entry) and a new standalone
file, `ASCII45-KnownLimitations.md`. **Neither was created.** The
architectural lesson is now in `CLAUDE.md`'s FT-260 entry, which is where
this project already keeps exactly this kind of note -- a second file
tracking the same fact would be the "state a fact twice" problem this
project's own documentation habits exist to avoid. If ascii45 planning
later wants a dedicated known-limitations document, that is a real
decision for Bill, not something to stand up as a side effect of one
finding.

---

## FOR THE RECONCILIATION PACK, WHEN PART 3 IS READY

**One more thing worth knowing, not part of this document's subject:**
Copilot's Guide Part 3 (`Co-Pilot part 3 Additional Security and Priv-
2026-09-16-1448.txt`) has also landed in `ProjectDocs\` since your last
response. Not reviewed as part of this document -- flagged here only so it
is not missed when the reconciliation pack is next picked up.

---

## SOURCES

- `CLAUDE.md`, FT-260 entry -- the decision and the sharpened lesson, both
  now live there.
- `GatewayGuard_CoPilotGuideReview-Comments-2026-09-16-1140.md` -- the
  sentence, filed for the reconciliation pack, alongside the Setting 5
  wording decided the same afternoon.
- `GatewayGuard_SmartAppControl-ChatHistory-2026-09-16-1403.md` -- the full
  conversation, start to finish, that this decision was reasoned from.
- `Co-pilot-comments Smart App Control-2026-09-16-1445.txt` -- Copilot's
  analysis, the new source this document exists to hand you.
