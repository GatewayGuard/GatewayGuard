<!-- Dated: 2026-09-29 08:20 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Copilot's review of the three ForCopilot documents -- triage

- **Copilot's reply:** `Co-polot_Guide_Review-2026-09-29-0815.txt` (Bill's filename, kept as saved).
- **What it reviewed:** `GatewayGuard_ForCopilot-1/2/3-...-2026-09-28-2123.md`.
- **Every quote below was checked against those files** (grep, 2026-09-29 08:19). All 13 quoted sentences exist where Copilot said.
- **Who acts:** guide text (Parts 1, 4, 5) is **Cloud's**. Website pages go in the W1-W6 pass, **after** the guide wording is settled (rule W-07: the guide wins).

## Not done by Copilot

**Document 3 was reviewed, not carried out.** Copilot said the screen-reading list is "excellent" but read no screens. Those 19 open readings (C1-C8, C10-C14, S2-S7) still need Bill at each PC, with Copilot reading the screen or with screenshots saved to `Test_Results\`.

## Guide (Parts 1, 4, 5) -- for Cloud

| # | Where | Now | Copilot | Verdict |
|---|---|---|---|---|
| G1 | Part 1, restore point (doc 1 line 41) | "Some of them it puts back and some it does not." | "Some settings may be affected by a restore point and some may not." | **Accept the point; change the wording.** Copilot's "may be affected" is vaguer, and the reader still asks "which ones?". Which ones are **not measured**. Suggested: *"It may put some of these settings back and not others, so do not count on it for them."* The next sentence already points to Part 4. |
| G2 | Part 4.1 (line 63) | "**Keep the record.**" | "Keep the record file." | **Accept, and name the thing.** "Record" means two things here: the **What Checkup changed** screen and the log file. Say which one, e.g. *"Keep the log file Checkup saves"*, with where it is. That depends on reading C3 (the folder path and Open-My-Log.bat). |
| G3 | Part 4.2, Setting 8 (line 81) | "Keep your recovery key either way." | "...whether encryption is on or off." | **Accept the point; reject the wording.** "Whether" is a banned word. Use: *"Keep your recovery key, with encryption on or off."* |
| G4 | Part 4.2, Setting 17 (line 90) | Undo: "...choose **Never**." | Add that Checkup does not recommend it | **Accept, and go further.** "Never" is only correct if the reader had Never before. The undo should put back **what they had**: *"choose the time you had before -- the What Checkup changed screen shows it. Checkup recommends leaving sign-in required."* Say "Checkup", not "GatewayGuard". Also re-check this row against the FT-294 fix (item 17 now reads the away time as well as the wake password). |
| G5 | Part 4.5 step 1 (line 142) | "If you know which program it is" | "If you are certain..." | **Accept, as "If you are sure which program it is".** Plainer than "certain". |
| G6 | Part 4.5 step 3 (line 166) | "the status should say it was removed or quarantined" | "should indicate" | **Reject.** "Indicate" is vaguer, and the plain-language rule wants the exact words. S7 and C8 exist to read the real status words off the screen. Put those in, then keep "say". |
| G7 | Parts 1 and 5, several | "It is not an undo button...", "Long beats clever", "Do not change a good password on a schedule", the authenticator line, Part 4.3 | Keep | **Agreed, no change.** |

## Website pages -- for the W1-W6 pass

Copilot's top five include four website items. Its priorities agree with Cloud's 09-26 findings.

| # | Page (doc 2 line) | Now | Verdict |
|---|---|---|---|
| W-a | `password-manager.html` (42) | "they can export every password Edge has saved in a few clicks" | **Accept softening.** *Not measured:* Edge asks for the Windows password or PIN before exporting, which is an obstacle to someone at the keyboard. Malware in the account is a different case. Suggested: *"they may be able to get at the passwords saved in your browser."* The product names are also going (already known). |
| W-b | `phishing-protection.html` (100) | "In 2025, people aged 60 and over filed more than 200,000 complaints with the FBI..." | **Verify or remove.** Needs the FBI IC3 2025 Elder Fraud Report as the named source, with the page number. *Not measured* by Claude Code. Remove it if no source is found. |
| W-c | `widgets.html` (159) | "Widgets sends your reading and browsing habits back to Microsoft..." | **Accept softening** (Cloud flagged it too). The page must also say Checkup cannot turn Widgets off on Windows 11 Home and gives the steps instead (FT-283, measured on SANDY twice). |
| W-d | `defender-realtime.html` (217) | "consistently rated by independent labs as one of the best antivirus engines available" | **Cite a current named test or remove** (Cloud flagged it too). |
| W-e | `diagnostic-data.html` | The "Why you might want the minimum" section | **Rewrite neutrally** (Cloud flagged it too). A1-A3 of the 09-28 Cloud brief give the facts. |
| W-f | `advertising-id.html` (327, 328, 341) | "advertisers you have never heard of", "a record of what you do" (said three times) | **Accept softening.** Keep the loyalty-card comparison and the facts; drop the advocacy tone and the repetition. |

## Next

1. Cloud: G1-G6 in the guide revision (along with F10 and the note-14 sweep in the 09-28 brief).
2. Cloud or Claude Code: W-a to W-f in the website pass, once the guide wording for each setting is settled.
3. Bill: the 19 screen readings in document 3.
