<!-- Dated: 2026-09-28 19:10 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# For Cloud: what changed in ascii45 since your 09-26 guide check, and what the guide must now say

- **Build:** `Tool/W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1`, commit `b3e7e58` (2026-09-28 18:36).
- **Your last check:** `GatewayGuard_GuideVsAscii45-BlocksABC1-2026-09-26-1459.md`, which covered Blocks A, B and C1 only.
- **Since then:** C2-C9, D, E, F, the renumber, Block H, FT-282 to FT-309. Plan: `GatewayGuard_ascii45BuildPlan-2026-09-25-1638.md`. SANDY run triage: `GatewayGuard_FieldTestTriage-ascii45run1-2026-09-28-1639.md`.
- **Your rules apply:** name your base from `CURRENT.md`, read the build, and verify each point below against it -- this list is a map, not a source.

## A. Facts the guide must match (each measured; where recorded is given)

| # | Topic | What is true now | Where recorded |
|---|---|---|---|
| A1 | **Setting 9, Windows Hello** | Checkup reads how the account last signed in or unlocked (PIN, face or fingerprint count). If it cannot confirm, it asks the reader to press **Windows key + L**: "Enter PIN" = set; asks for a password = set up a PIN. **Settings can say Hello is "not available" on a PC where the PIN works** (CGDELL). | plan Block H, H1; `GatewayGuard_HelloAndPUA-Research-2026-09-27-0946.md` |
| A2 | **Setting 17, password on wake** | GOOD only when required **both** plugged in and on battery (two separate Windows values); the place to see it is Settings -> Accounts -> Sign-in options -> "If you've been away...". Also FT-294 (the away time) -- read the build. | H2; FT-294 in CLAUDE.md |
| A3 | **Setting 12, diagnostic data** | Read from the Settings switch when there is no policy: **1 = optional data off (GOOD), 3 = on.** | FT-282, Block G |
| A4 | **Unwanted-app blocking** (new start step) | Windows Security -> App & browser control -> Reputation-based protection settings -> **Potentially unwanted app blocking**, two boxes: **Block apps** (Defender -- Checkup offers to turn it on, with permission) and **Block downloads** (Edge only -- Checkup does not touch it). Defender's default on home PCs is **audit mode = records, does not block** (CGDELL measured 2). Microsoft's own pages contradict each other on the default. | research note above |
| A5 | **The 09-07/08 test "Defender 0 of 6, Malwarebytes 6 of 6"** | Taken with blocking in **audit mode** -- so it may measure the setting, not the product (inferred). **Do not let the guide say Defender is weak on unwanted programs** (CLAUDE.md already forbids it). A rerun with blocking on would settle it. | research note |
| A6 | **Device Encryption on a LOCAL account** (SANDY) | It encrypts both drives but **cannot turn protection on**, because the recovery key cannot be saved to a Microsoft account (Windows log: "Failed to backup ... to your Microsoft account", then "Failed to automatically enable Device Encryption", at every sign-in). **Settings says protection "will resume at next restart" -- it did not, across three restarts.** Cause of the start on 09-20 18:22 not determined; Checkup was idle. | H7 / FT-289; `Test_Results/EncryptionStart-SANDY-2026-09-27_17-00.txt` |
| A7 | **Protection history** | The link Checkup opened goes to Windows Security's antivirus page, not Protection history (SANDY, twice). The guide must give the route by hand: **Virus & threat protection -> Protection history**, and tell the reader to **write down** any name listed. | FT-277 |
| A8 | **Setting 14, Widgets** | Checkup's change works on Pro (CGDELL, value 0) but **Windows refused it on Home (SANDY, twice)**. Home users turn it off by hand: Windows key -> type *taskbar settings* -> Enter -> Widgets Off. | FT-283, open |
| A9 | **Full screen** | Checkup opens **full screen in Windows Terminal** (both PCs have it). No X to click: leave with **X** at a question (Checkup asks first) or **Alt+F4**; **Alt+Enter** shows other windows. **Copy: highlight with the mouse, then Ctrl+C** (it does not pause Checkup). Text size: **Ctrl and +**, **Ctrl and -**, **Ctrl and 0**, then **F**. Ctrl+C with nothing highlighted asks before closing. | C7, C9 |
| A10 | **Keys** | **B** = back one step, **L** = look at the previous screen, **F** = fix the screen, **X** = exit (asks first), **N** = no only. | C1-C6 |
| A11 | **Start order and scans** | Tamper Protection -> virus protection -> unwanted-app blocking -> Windows Update (installs with permission, restarts, repeats) -> virus definitions -> offline scan offer (save your work first; after the restart, **sign in and run Checkup again, choose R**) -> a **full scan of every drive** in the background (can take hours on a large hard drive). | Block E, F12 |
| A12 | **An installed-but-off antivirus** | Checkup names it but no longer treats it as in charge (SANDY's Malwarebytes Free). Guide wording about "another antivirus" should mean one that is **running**. | FT-303 |

## B. Wording rules from Bill's SANDY run (2026-09-28) that apply to the guide too

- **Stop saying "nothing has been changed"** where the reader was offered no change -- Bill: it "will actually make some users suspicious." Bill's note 14: *"search checkup and security draft throughout eliminating these redundant phrases and 'nothing has been changed'."*
- Do not suggest the reader should reconsider changes ("how to put each one back" was taken off screen 25).
- Guide references in Checkup are now **"Setting N"** (F5) -- the guide's setting numbers must stay stable; **Setting 5 does not exist** (retired, never renumbered).
- No third-party product names in Checkup's own copy or the guide (CLAUDE.md, 09-25).

## C. What Claude Code needs back from Cloud

1. **F10:** the final guide text for Parts 4-5, so FT-220 can be built and Bill's note 18 ("did we tell users everything at the end?") can be checked against screens 34, 35 and 37.
2. **A findings file** like your 09-26 one: every sentence in Guide Parts 1-5 (and the website pages) that contradicts A1-A12, with the replacement text.
3. **The note-14 sweep** of the guide draft for "nothing has been changed" and repeated phrases.
