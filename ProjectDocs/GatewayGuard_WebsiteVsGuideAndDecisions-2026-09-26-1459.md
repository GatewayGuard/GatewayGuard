<!-- Dated: 2026-09-26 14:59 ET -->
<!-- Editor: Claude Cloud -->
# Website -- every WebSite\html page that must change, and which guide index ships

- **Document Name:** GatewayGuard_WebsiteVsGuideAndDecisions
- **Dated:** 2026-09-26 14:59 ET (supplied by Bill)
- **From:** Claude Cloud
- **For:** Bill, then Claude Code
- **Status:** FINDINGS. Changes nothing.

---

## PROVENANCE

1. **Stamp:** Generated **2026-09-26 12:14 ET**, commit **`4fb5596`**, made **2026-09-26 12:10 ET**, subject *"ascii45 C9 full-screen launch in scope; copy/selection test and SANDY Windows Terminal check added"*. Session-log heading match confirmed.
2. **Base files:**
   - The pages themselves, read as `WebSite/html/*.html` in project knowledge.
   - Guide Parts 1-3 twins; the Part 4-5 draft filed alongside.
   - Bill's decisions of 2026-09-26, **as pasted in this conversation**. The session log records the password-manager question as open ("his call"); the screen 17/17a/17c exception is from Bill's message, not yet from the repository.
   - The retirement commit `90c1897` as described in the session log, 2026-09-26, "Then, same session (11:27-11:53)".
3. **How read:** fragments. **Read in the live `WebSite/html` copy** (***measured***, source path `WebSite/html/...`): `defender-realtime`, `password-manager`, `phishing-protection`, `widgets`, `advertising-id`, `diagnostic-data`, `memory-integrity`. **Not surfaced from `WebSite/html`:** the other eleven setting pages and every non-guide page. For those I name what to check, not what the page says.
4. **Carried forward:** nothing from a draft. **`GatewayGuard_WebsiteSourcePack-2026-08-22-2235.md` is NOT used as evidence of current page text** -- it predates `90c1897` and still carries `periodic-scanning.html`.
5. **Not seen, and what it changes:** `Index-Builds\` never surfaced in any search. **I cannot read `guide-index-2026-08-02-2031.html` or any other index build.** Section C is therefore a recommendation, not a reading.

**Correction from earlier in this conversation:** I said `WebSite\html\` was outside Cloud's scope, citing `Review-of-HtmlWebsiteReview-2026-08-22-2220md.md` and `SyncSetupSteps`. ***Measured today:*** `WebSite/html/` pages are in project knowledge. **Both documents are stale on this point.**

**Labels:** ***measured*** (page text in the snapshot, or Claude Code's count, named) / *sourced* / *inferred* / *guess*.

---

## A. PAGES THAT MUST CHANGE -- READ TODAY, EVIDENCE QUOTED

Ordered by cost of being wrong.

| # | Page | What it says now (***measured***, snapshot) | Conflicts with | Change |
|---|---|---|---|---|
| **W1** | `password-manager.html` | *"A dedicated password manager like Bitwarden (free) or 1Password..."*; a note box headed *"Recommended free alternative: Bitwarden"*, which also names three browsers; *"A browser password manager is a convenient single point of failure."* | **Bill, 2026-09-26: no password-manager names on the website.** Also the guide's position (Part 3, Setting 15): *"If you do not use a password manager, Edge password saving remains significantly better than reusing weak passwords..."* and Checkup only offers the change to someone who already has one | **Rewrite, not edit.** Remove every product name and the recommendation box. Take the guide's stance: Edge saving plus a PIN is a good choice for one PC; turn it off only if you already use a separate password manager |
| **W2** | `phishing-protection.html` | *"a dedicated password manager (such as Bitwarden, which is free) is the right tool for that job"* | same decision | Cut the parenthesis. *"...a password manager is the right tool for that job"* |
| **W3** | `widgets.html` | *"Widgets uses the Edge browser engine (WebView2) to run even when you are not looking at it. Turning it off frees up that memory..."*; *"Your PC will use slightly less memory..."*; *"tracks which stories you read, how long you spend on them, and what you click on"* | ***Measured 2026-08-24 (`WidgetsMeasurements-M1toM6`):*** Widgets uses **27.2 MB**, the smallest WebView2 user on the machine. `GuidePart3-Sources` says **no memory claim should be published.** Cloud's 08-24 research: the "tracks..." line is more specific than any source. Guide Part 3 Setting 14 now gives the scam-ad reason, the weather-is-the-button fact, Windows key + W, and Dashboards > Discover | Rewrite *Why* to match Part 3 Setting 14. Remove both memory sentences. Soften the tracking line to what Microsoft says (the feed becomes more personalised over time). Add the weather-only option |
| **W4** | `defender-realtime.html` | *"consistently rated by independent labs as one of the best antivirus engines available"*; header *"Setting 2 of 19"* | SOURCING rule; PL-4, no unverified superlatives | Remove the sentence, or source it to a named lab result current at export. See W-all for the "of 19" |
| **W5** | `diagnostic-data.html` | *"It does not affect performance or updates in any way."* (source pack text; **re-check the live page**, question 3); framing moved on 08-21 to the FT-220 "more than a taste" position | Guide Part 3 Setting 12 carries a **VERIFY** on *"updates are identical at either level"*, and since 09-24 frames 12 as *"a privacy setting. It does not weaken your security."* | Remove the updates sentence until T-VF1 B2 settles it. Align the framing with Part 3 Setting 12 |
| **W6** | `advertising-id.html` | Change-history comment: *"KNOWN TEMPORARY DIVERGENCE FROM THE GUIDE"* -- the page took the "more than a taste" position on 08-21 | Guide Part 3 Setting 11 **now says both** *"a privacy setting, not a security risk"* and *"This is more than a taste"* (Job 3, G2) | **Waits on Bill's G2 ruling**, then page and guide say one thing. Also confirm the page's path reads **Recommendations and offers**, not General |

**W-all -- every setting page.** ***Measured on `defender-realtime.html`:*** *"Setting 2 of 19"*. There are 18 settings, and the IDs run to 19 with 5 unused.

- **Recommendation:** drop "of 19" and print **"Setting 2"** alone. It stays true whatever the count is, and it matches the guide, which never says "of".
- **Claude Code:** grep `of 19` across `WebSite/html` for the count.
- *Inferred:* the same pages may carry duplicated titles (*"... - GatewayGuard Security Guide - GatewayGuard Security Guide"* in the 08-22 source pack). Check in the same pass.

---

## B. PAGES I COULD NOT READ TODAY -- WHAT TO CHECK ON EACH

Each check is a guide sentence the page must not contradict.

| # | Page (name from the 08-22 source pack and `SettingsToGuideMap`) | Check against | Specifically |
|---|---|---|---|
| W7 | `edge-startup.html` | Part 3, Setting 13 | Covers **both** toggles; says **open Startup boost first**; does not state the running-after-close claim as fact (it carries a VERIFY in the guide) |
| W8 | `remote-desktop.html` | Part 3, Setting 10 | Home cannot be reached, can connect out; Quick Assist, with *only when you called them*; nothing stated as fact that the guide marks VERIFY |
| W9 | `fast-startup.html` | Part 3, Setting 18 | Path includes **Change settings that are currently unavailable**; the *"(recommended)"* note; no dual-boot jargon |
| W10 | `wake-on-lan.html` | Part 3, Setting 19 | One path: Device Manager > Network adapters > each adapter > Power Management; the backup-timer sentence (*sourced* in `GuidePart3-Sources`) |
| W11 | `bitlocker.html` | Part 2, Setting 8 | **W-07:** must not state as fact the two claims the guide marks VERIFY (recovery key saved to a Microsoft account automatically / nowhere on a local account; Home needs a Microsoft account) -- **the claim that can cost a reader their files** |
| W12 | `windows-hello.html` | Part 2, Setting 9 | Same W-07 check: a PIN on a local account; reset needs the password |
| W13 | `password-on-wake.html` | Part 2, Setting 17 | The literal label *If you've been away, when should Windows require you to sign in again?* > *When PC wakes up from sleep*. The 08-22 source pack shows *"Require sign-in"* / *"When PC wakes from sleep"* -- older wording |
| W14 | `memory-integrity.html` (read in part) | Part 2, Setting 16 | The page states *vmmem / vmwp use about 150-300 MB* as fact. Part 2 no longer carries that figure. **Source it or cut it** |
| W15 | `tamper-protection.html` | Part 2, Setting 3; `90c1897` | ***Measured by Claude Code:*** no Malwarebytes left. Check the permission line is the Shape-B wording ("Checkup checks this and shows you the steps") |
| W16 | `windows-update.html`, `smartscreen.html`, `firewall.html` | Part 2, Settings 1, 4, 7 | Names per the Naming Standard; SmartScreen's four toggles named; "of 19" |

**Non-guide pages** -- `index.html` (home), `download.html`, `tips.html`, `beta.html`, `compatible.html`. None surfaced. **Claude Code: one grep across all of `WebSite/html` for each of:**

| Term | Why |
|---|---|
| `GUI`, `two modes`, `option 2`, `window mode` | B1 removed GUI mode. The build plan asked for this grep; the session log does not record the result |
| `press N`, `N to exit`, `N = exit` | C1: X = Exit |
| `schedul` | Scans are **reminders** (FT-175), not schedules |
| `Malwarebytes`, `Bitwarden`, `1Password`, `KeePass`, `Norton`, `McAfee`, `Avira`, `LastPass` | Bill's decision. `90c1897` measured Malwarebytes only |
| `19 settings`, `of 19` | 18 settings |
| `Phase `, `Step ` followed by a digit | Cross-references to the old guide structure |

---

## C. WHICH GUIDE INDEX SHIPS

**The answer is: nothing in the repository says, and the one file named cannot ship as it is.**

- ***Measured by Claude Code, 2026-09-26:*** `Index-Builds\guide-index-2026-08-02-2031.html` still lists setting 5. The session log records that *"which index ships is not recorded"* and that Claude Code asked Cloud.
- **I cannot read `Index-Builds\`.** It never surfaced in any search, so it is probably outside the connector scope. I cannot compare the index builds or say which is newest in content.
- ***Measured:*** every setting page links `/guide/index.html`. So whatever ships must deploy to that one path.

**Recommendation (*inferred*):**

1. **Do not ship `guide-index-2026-08-02-2031.html`.** It predates the 09-08 removal of setting 5, the 09-24 guide changes, and today's decisions.
2. **Claude Code builds one new index from the 18 pages now in `WebSite/html`**, after W1-W6 land:
   - 18 cards, no setting 5, "Setting N" with no "of 19";
   - each card's category tag taken from the page's own tag, not re-derived;
   - no product names.
3. **Give it a `CURRENT.md` row** -- *"Website guide index (ships as /guide/index.html)"* -- so the question never has to be asked again.
4. **Retire the older `Index-Builds\` files to `Archive\`** once the new one is live.

---

## FOR CLAUDE CODE

```
Cloud's website findings: GatewayGuard_WebsiteVsGuideAndDecisions-2026-09-26-1459.md.
Order by cost of being wrong:
 1. W1 password-manager.html -- rewrite; no product names; guide Setting 15 stance.
 2. W2 phishing-protection.html -- cut "(such as Bitwarden, which is free)".
 3. W3 widgets.html -- remove both memory sentences (M-2: 27.2 MB);
    align Why with Guide Part 3 Setting 14.
 4. W4 defender-realtime.html -- remove or source the "best engines" line.
 5. W5 diagnostic-data.html -- confirm the live text; remove the
    "does not affect ... updates" sentence while the guide carries VERIFY.
 6. W6 advertising-id.html -- after Bill rules on guide G2.
 7. The six greps in section B across all of WebSite\html; report counts.
 8. W7-W16: read each against the guide sentence named; fix or report.
 9. Section C: build a new guide index from WebSite\html; add a CURRENT.md row.
10. Correct Review-of-HtmlWebsiteReview and SyncSetupSteps: WebSite/html/
    IS in the connector scope (measured 2026-09-26).
One page per commit. File into ProjectDocs\, add a row,
regenerate CURRENT.md last, commit, push.
```

## QUESTIONS, HELD TO THE END

1. **Bill:** "Setting 2" with no "of 19" on every page -- agree?
2. **Bill:** the new index built from the 18 live pages, rather than choosing among the `Index-Builds\` files -- agree?
3. **Claude Code:** W5 -- is *"It does not affect performance or updates in any way"* still on the live `diagnostic-data.html`? The snapshot fragment did not show the page body.
