<!-- Dated: 2026-08-24 23:30 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# CPM -- the final week. 8 days to 1 September.

- **Document Name:** GatewayGuard_CPM_FinalWeek
- **Last Modified:** 2026-08-24 23:30 ET
- **Requested:** Bill, 2026-08-24 -- *"prepare a CPM list of things for us to
  work on tomorrow so we can meet the 9/1/2026 target"*
- **Supersedes for the final week:** `GatewayGuard_CPM_Schedule-2026-08-02-1201.md`,
  whose critical path was calculated from 03-Aug and has been overtaken. **The
  older document is still the baseline** -- this is the re-cut against the real
  calendar.

---

## THE NUMBERS

| | |
|---|---|
| Today | **Monday 24 August 2026** |
| Launch | **Tuesday 15 September 2026** *(moved 2026-08-30 from 1 September)* |
| Calendar days remaining | **8** |
| Weekdays remaining | **6** -- Tue 25, Wed 26, Thu 27, Fri 28, Mon 31, Tue 1 |

**The 02-Aug CPM predicted completion on 22-Aug with ten days of buffer. It is
the 24th and the critical chain has not started.** The buffer is spent. **That
is the honest position, and it is recoverable -- but only if tomorrow goes on
the critical path and nothing else.**

---

## WHAT IS ALREADY DONE -- THE LONGEST POLE IS GONE

**The code-signing certificate is issued, installed and proven.** DigiCert, on
the SafeNet token, valid 2026-08-14 to 2027-08-16, **test-signed and verified
with a timestamp on 2026-08-14 17:17.** Track B of the launch plan is closed.

**That was the item most likely to sink the date, and it is not a risk any
more.** Everything remaining is work we control.

---

## THE CRITICAL PATH -- ONE CHAIN, AND EVERYTHING WAITS ON IT

```
  FINISH ascii43  ->  FIELD RUN on SANDY  ->  FIX FINDINGS  ->  FREEZE
        |                                                          |
        |                                                          v
        |                                                     SIGN THE BUILD
        |                                                          |
        |                                                          v
        |                                              SCREENSHOTS (19 settings)
        |                                                          |
        v                                                          v
  WEBSITE COPY  ------------------------------------------>  SITE QA -> HASH
                                                                   |
                                                                   v
                                                          FINAL QA -> LAUNCH
```

**The one dependency people forget, and it is on the critical path:**
***screenshots must be taken from the FINAL SIGNED build.*** They cannot be
done early. **Every day the freeze slips, the screenshots slip, and the site
cannot be finished.**

**The second serial constraint, and it is a one-way door:**
**SANDY must be field-run BEFORE it is encrypted.** It is the only unencrypted
machine, and encrypting it ends the starting condition permanently.

---

# TOMORROW -- TUESDAY 25 AUGUST

**The whole day has one purpose: get ascii43 finished and onto SANDY.**
Everything below either serves that or costs nothing.

## BILL -- FIRST THING, BEFORE ANYTHING ELSE (30 minutes total)

| # | Task | Why it is first |
|---|---|---|
| **B-1** | **Un-pause Windows Update on CGDELL and SANDY** | *measured:* both paused since 1 Aug, until 6 Sep. **Five weeks unpatched, through launch week, on the machines building a security product.** Settings > Windows Update > Resume updates |
| **B-2** | **Set Gumroad's refund window to 30 days** | Account-wide, browser only. **The EULA and the website now both promise 30 days. Until this is set, we are promising something the platform is not configured to honour** |
| **B-3** | **Win+L test** -- I set `LockScreenWidgetsEnabled = 0`, you lock the screen and look | Twenty seconds. Decides whether the lock screen step is automatic or manual, which changes setting 14's copy |

**B-1 and B-2 are not optional and neither takes ten minutes. Do them before
the day starts, because both are outward-facing promises we are currently
breaking.**

## CLAUDE CODE -- THE BUILD, IN THIS ORDER

| # | Task | Est | Notes |
|---|---|---|---|
| **A-1** | **F6 wording block** | 0.5 d | **~20 items + FT-222, plus today's additions.** Biggest block, entirely unblocked, pure wording. **Start here because it is the largest and has no dependencies** |
| **A-2** | **F4 -- the second drive / full scan** | 0.3 d | **UNBLOCKED TODAY.** Bill decided: run the full scan with approval. `Start-MpScan -ScanType FullScan -AsJob`, gate-24 comment written, screen text drafted. *sourced:* full scan covers all fixed and removable drives, so route 3's wording is unblocked |
| **A-3** | **F5 remnants** | 0.2 d | FT-195a, FT-175b, FT-225 -- scoped to the one inconsistent screen |
| **A-4** | **Setting 1 -- detect paused updates** | 0.2 d | *measured:* nothing reads `PauseUpdatesExpiryTime`. **Bill's own machines prove why it matters** -- setting 1 would report Windows Update healthy on both today |
| **A-5** | **Setting 14 -- Revert string + the three-way choice** | 0.3 d | Text is written and ready to drop in |
| **A-6** | **Setting 6 -- rename** | 5 min | *"Edge Phishing Protection"* describes the wrong feature |
| **A-7** | **Run all gates**, increment to **ascii44**, present | 0.3 d | Gates 12, 12b, 24, screen coverage, ASCII, duplicate functions |

**That is a full day and it is achievable.** Every item has its text or its
measurement already written -- **today's work was the preparation for
tomorrow's build.**

## WHAT MUST NOT HAPPEN TOMORROW

- **No new settings.** Decided tonight. Nineteen.
- **No guide VERIFY work.** It has float -- see below.
- **No website copy.** It has float.
- **Do not encrypt SANDY.** Not before the field run.

---

# THE REST OF THE WEEK

| Day | Bill | Claude Code |
|---|---|---|
| **Wed 26** | **FIELD RUN ascii44 on SANDY** -- the whole morning. Use `GatewayGuard_FieldChecklist`. **Then run `Run-SandyChecks.bat`** -- six read-only measurements, same trip | Fix findings as they arrive |
| **Thu 27** | Review fixes. **FEATURE FREEZE by end of day** | Finish fixes. Apply website copy items 8, 13, 19. Guide: close the two VERIFY markers that can cost a reader their files |
| **Fri 28** | **SIGN THE BUILD.** SmartScreen smoke test. Gumroad product page live | `download.html`, `index.html` banner removed, publish the 19 pages |
| **Sat 29 / Sun 30** | **SCREENSHOTS -- all 19 settings, from the signed build** | Site QA, hash published, guide page numbers |
| **Mon 31** | **Test purchase end to end -- Gumroad's TEST card, never a real one (`GatewayGuard_GumroadTestPurchase-2026-09-02-1040.md`).** Final read of the EULA | Final integration QA across all three machines |
| **Tue 1 Sep** | **LAUNCH** | Standby |

---

## FLOAT -- WHAT CAN SLIP AND WHAT CANNOT

**ZERO FLOAT -- slipping any of these moves the launch date:**

- Finish ascii43/44 → field run → fix → freeze → sign → screenshots → QA
- **Gumroad live and a test purchase.** *There is no launch without a
  working checkout*, and it has never been tested end to end. ***Corrected
  2026-09-02: with Gumroad's test card, not a real one -- see `GatewayGuard_GumroadTestPurchase-2026-09-02-1040.md`.***

**HAS FLOAT -- can land after 1 September:**

- **The attorney's refund-clause review.** The clause is written and the
  policy is decided. **A consult that refines wording is not a launch
  blocker** -- but the Gumroad setting (B-2) is
- **27 of the 29 guide VERIFY markers.** *The two that can cost a reader their
  files are not on this list* -- those ship correct or the guide does not ship
- **Items 20, 21, 24** -- Wake on LAN detail, Widgets copy, the accessibility
  rule W-09
- **Cloud's remaining research** and the whole future-settings list
- **FT-220** -- already ascii44+ scope

---

## THE THREE REAL RISKS, NAMED

**1. The field run finds something structural.** ascii43 has **never been
run**, and it carries five families of changes. *measured, ascii41's run:* 38
findings. *measured, ascii42's:* 32. **A build with that much new code will
find things.** The Thursday freeze has one day of fix allowance and no more.
**If Wednesday produces a structural defect, the date is at risk and Thursday
is when we will know.**

**2. Screenshots are serial and nobody has costed them.** Nineteen settings,
from the signed build, matching the final wording. **They cannot start before
Friday** and they are on the critical path. **If the freeze slips to Monday,
the screenshots have nowhere to go.**

**3. The checkout has never been tested.** Gumroad is not live, the refund
window is not set, and no test purchase has been made. **This is
the only chain that has had no rehearsal at all**, and it is the one that takes
the money.

---

## THE HONEST ASSESSMENT

**1 September is achievable, and it needs tomorrow to go entirely on the
build.**

The certificate is done, the guide is written, the 19 pages exist, the licence
is rewritten, and **every item on tomorrow's list already has its text or its
measurement prepared.** What remains is assembly, one field run, and a checkout
nobody has tested.

**The single decision that protects the date: freeze on Thursday whatever the
state of the wording.** Cosmetic defects ship. Structural ones do not.
**Wording can be fixed in a yearly update -- the screenshots, the signature and
the hash cannot be redone in a week.**
