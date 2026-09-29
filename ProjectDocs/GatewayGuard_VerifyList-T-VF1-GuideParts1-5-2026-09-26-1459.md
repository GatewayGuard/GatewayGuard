<!-- Dated: 2026-09-26 14:59 ET -->
<!-- Editor: Claude Cloud -->
# T-VF1 -- every VERIFY marker in Guide Parts 1-5, and where each is settled

- **Document Name:** GatewayGuard_VerifyList-T-VF1-GuideParts1-5
- **Dated:** 2026-09-26 14:59 ET (supplied by Bill)
- **From:** Claude Cloud
- **For:** Bill at the keyboard; Claude Code for the source checks
- **Status:** WORKING LIST. A marker comes out only with its measurement written beside it -- never by deletion.

---

## PROVENANCE

1. **Stamp:** Generated **2026-09-26 12:14 ET**, commit **`4fb5596`**, made **2026-09-26 12:10 ET**, subject *"ascii45 C9 full-screen launch in scope; copy/selection test and SANDY Windows Terminal check added"*. Session-log heading match confirmed.
2. **Base files:** Guide Parts 1-3 twins (`GatewayGuard_CoPilotGuidePart1/2/3-2026-09-16-1627.md`, rows in `CURRENT.md`); Parts 1 addition, 4 and 5 from `GatewayGuard_GuideDraft-Part1SafetyNet-Part4-Part5-2026-09-26-1459.md` (filed alongside; no row yet); sources doc `GatewayGuard_GuidePart3-Sources-2026-09-25-1320.md`.
3. **How read:** fragments via `project_knowledge_search`. **I cannot grep.** Every marker in Parts 1-3 that surfaced is below. **Part 2 Setting 6 and the opening of Setting 7 did not surface** -- if either carries a marker it is missing from this list. **Claude Code: grep `VERIFY` across the three twins and compare the count with 10.**
4. **Carried forward as fact:** nothing. Each row quotes a marker; the markers are, by definition, unmeasured.
5. **What this changes about "29":** T-VF1 was sized at **29 markers in the old draft** (`GuideRewrite-Draft-2026-08-22-1000`). **Parts 1-3 now carry 10.** Of the rest, many went with text Copilot's rewrite dropped, and some return in Parts 4-5 (old Phase 3). **I cannot reconcile the 29 one by one without the old draft's full marker list.** That is a Claude Code grep, not a Cloud read.

**Totals:** Parts 1-3: **10 markers**. Part 1 addition, 4 and 5: **13 markers covering 12 claims** (the restore-point scope appears in Part 1 and in 4.3). **22 claims to settle.**

**Labels:** ***measured*** / *sourced* / *inferred* / *guess*.

---

## ONE SITTING AT CGDELL (Windows 11 Pro) -- 13 checks

**Do the read-only ones first, then the three that flip a setting and put it back.** *Guess:* 40 to 60 minutes.

**Before you start:** do not click Finish in System Restore, do not turn encryption off, and do not start an offline scan.

| # | Guide location | The sentence | What to read or do | Write down |
|---|---|---|---|---|
| C1 | Part 1 addition, steps 1-4 | Windows key, *Create a restore point*, Enter; **Create**; name it; **Close** | Do it for real -- making a restore point is harmless. Also note whether **Create** was greyed out | Each label exactly as shown; greyed or not |
| C2 | 4.3, *To use a restore point* | **System Restore** > **Next** > choose > **Next** > **Finish** | Open System Restore and step through **up to, not including, Finish**. Cancel | Each label; the sentence Windows shows about personal files |
| C3 | 4.1 | the log is a file in your GatewayGuard folder | Open the folder the way a customer would | The full path as you would type it; whether `Open-My-Log.bat` is there |
| C4 | 4.2, Setting 1 | Windows Update lets you pause updates | Settings > Windows Update. **Read only** | The pause button's exact label, and the longest period offered |
| C5 | 4.2, Setting 8 | the path to turn encryption off on Pro | Control Panel > BitLocker Drive Encryption. **Read only -- do not click** | The link's exact wording |
| C6 | 4.2, Setting 17 | choose **Never** | Settings > Accounts > Sign-in options > *If you've been away...*. Open the list, press Esc | Every option in the list, exact wording |
| C7 | 4.5, Step 1 | Settings > Apps > Installed apps, three dots, Uninstall | Open it; click the three dots on any app; press Esc | The path; the menu's wording |
| C8 | 4.5, Step 3 | Protection history statuses | Windows Security > Protection history. ***Measured 2026-09-08:*** CGDELL still holds a quarantine record for the EICAR test file | The status words exactly as shown on that entry |
| C9 | 5.3 | Windows key + L locks the computer | Press it | Locks, yes or no |
| C10 | Part 3, Setting 10 | Settings > System > Remote Desktop; toggle labelled **Remote Desktop** | Read only | Exact path and label on Pro |
| C11 | Part 3, Setting 10 | Quick Assist: Ctrl + Windows key + Q; **Help someone**; **Security code from assistant**; **Submit**; **Allow**; **Leave** | Open Quick Assist. Read what the first screen shows. **Submit / Allow / Leave need a real session with a second device** -- note if you cannot reach them today | Every label you can see; which ones you could not reach |
| C12 | Part 3, Setting 13 | *Continue running background extensions and apps* keeps Edge running after close; exact label | Edge > Settings > System and performance > **open Startup boost first**. Read both labels. Then, with the background toggle **on**, close Edge and look in Task Manager for Edge processes. Put both toggles back as they were | Both labels exactly; Edge processes present after close, yes or no |
| C13 | Part 3, Setting 14 | Windows key + W still opens the panel with Widgets off; Dashboards > Discover turns off the news | Taskbar settings > Widgets **Off**. Press Windows key + W. Open the panel's settings and find Dashboards. Then **Widgets back On** | Panel opened, yes or no; exact wording of Dashboards and Discover |

---

## SANDY (Windows 11 Home, local account) -- read-only, safe before the ascii45 run

**Nothing below turns encryption on.** The field checklist says SANDY must stay unencrypted for the 10-03 run; these are reads only.

| # | Guide location | The sentence | What to read | Write down |
|---|---|---|---|---|
| S1 | Part 2, Setting 8 | Pro typically uses BitLocker; Home may use Device Encryption; does Home's need a Microsoft account? | Settings > Privacy & security. Is **Device encryption** listed? Open it. **Do not turn it on.** | Present or absent; any message about a Microsoft account |
| S2 | Part 2, Setting 9 | a PIN works on a local account; a local account cannot reset a forgotten PIN without the account password | Lock the screen (Windows key + L). Click **I forgot my PIN**. Read the first screen. **Cancel** | What it asks for first |
| S3 | Part 3, Setting 10 | what Home shows for Remote Desktop | Settings > System. Scroll the whole list | Remote Desktop absent, or present and greyed |
| S4 | Part 1 addition | restore point steps, and whether restore points are switched off on Home | Same as C1, **stop at step 2**. Note whether **Create** is greyed out | Labels; greyed or not |
| S5 | 4.2, Setting 8 | the path to turn Device Encryption off on Home | Only if S1 found the page. Read the toggle's label | Exact label |

## SANDY -- during or after the ascii45 field run, not before

| # | Guide location | The claim | When and how |
|---|---|---|---|
| S6 | 4.5, Step 2 | offline scan takes 10 to 20 minutes (Checkup's own reminder says about 15) | **Time it during the field run.** Note the clock when you press Y, and when the desktop comes back |
| S7 | Part 1 addition **and** 4.3 | which Part 2-3 settings a System Restore puts back; that encryption is left on; whether Checkup's reminder task survives | **After the field run and its triage.** Make a restore point, run Checkup, restore, then run Checkup again read-only (`Tool2\Run-SettingsStatus.bat`) and compare. **Bill's call whether SANDY or CGDELL** -- a restore on CGDELL can also take back development tools (question 2) |

---

## SOURCE CHECKS -- a browser, or Claude Code

Not screen readings. Each needs a named primary source, or a live copy of software the project machines do not have.

| # | Guide location | The claim | Where to settle it | Status |
|---|---|---|---|---|
| B1 | Part 2, Setting 8 | the recovery key is saved to a Microsoft account automatically; on a local account it is saved nowhere automatically | Microsoft Learn, BitLocker / Device Encryption recovery | `GatewayGuard_Research-Q7-BitLockerMicrosoftAccount-2026-08-24-0300.md` covers this. **Claude Code: check whether it cites a Microsoft page for both halves.** If it does, the marker can come out with that link |
| B2 | Part 3, Setting 12 | Windows sends the larger level unless told otherwise; updates are identical at either level | Microsoft Learn says Required is the default, but that page is for managed PCs; third-party sources say setup pre-selects Optional (*sourced*, `GuidePart3-Sources-2026-09-25-1320`). **Not settleable on an existing install.** Needs a Microsoft consumer-setup source, or a read during a fresh install | Open |
| B3 | Part 3, Setting 15 | Chrome: *Offer to save passwords and passkeys*; Firefox: *Ask to save passwords* | Chrome's is *sourced* (support.google.com/chrome/answer/95606). Firefox's came from a search result only. **Firefox is not on CGDELL (*measured* 09-25).** Needs any PC with each browser | Open |
| B4 | Part 3, Setting 18 | which updates and repairs need a full shutdown to finish | Microsoft Learn, Fast Startup / hybrid shutdown | Open |
| B5 | 4.6 | do not pay a ransom | CISA or FBI ransomware guidance, current at export | Open |

---

## PARTS 1-3 MARKERS, BY LOCATION (the 10 that surfaced)

| Part / Setting | Marker text (short) | Row |
|---|---|---|
| 2 / 8 | Home/Pro split; does Home need a Microsoft account | S1 |
| 2 / 8 | recovery key saved to account / nowhere | B1 |
| 2 / 9 | PIN on a local account; reset needs the password | S2 |
| 3 / 10 | Quick Assist keys and labels | C11 |
| 3 / 10 | Remote Desktop path on Pro; what Home shows | C10, S3 |
| 3 / 12 | default level; updates identical | B2 |
| 3 / 13 | running after close; background toggle label | C12 |
| 3 / 14 | Windows key + W; Dashboards > Discover | C13 |
| 3 / 15 | Chrome and Firefox labels | B3 |
| 3 / 18 | which updates need a full shutdown | B4 |

Part 1 carries **no** markers that surfaced.

---

## FOR CLAUDE CODE

```
T-VF1 list for Guide Parts 1-5 is in
GatewayGuard_VerifyList-T-VF1-GuideParts1-5-2026-09-26-1459.md.
1. grep -c "VERIFY" on the three CoPilotGuidePart twins. Cloud counts 10;
   Part 2 Setting 6 and Setting 7's opening did not surface to Cloud.
2. Reconcile the old draft's 29 markers against this list: which were
   dropped with text, which return in Parts 4-5, which are lost.
3. B1: does Research-Q7-BitLockerMicrosoftAccount cite a Microsoft page
   for both halves of the recovery-key claim?
4. C3: answer from the build -- the log folder path, and does
   Open-My-Log.bat ship?
File into ProjectDocs\, add a row, regenerate
CURRENT.md last, commit, push.
```

## QUESTIONS, HELD TO THE END

1. ~~Date and time~~ -- supplied by Bill: 2026-09-26 14:59 ET.
2. **Bill:** S7, the System Restore test -- SANDY after the field run, or CGDELL? A restore on CGDELL can also take back development tools installed since the restore point.
