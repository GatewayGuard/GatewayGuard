# Dated: 2026-09-06 12:14 ET
# ================================================================
# FILE:    W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1
# BUILD:   ascii44  |  Version 3.1
# CHANGES FROM ascii43 (2026-09-06 -- ASCII44):
#   FT-242: NINE REGISTRY WRITES COULD NOT FAIL. Without -EA Stop a
#           refused Set-ItemProperty raises a non-terminating error --
#           the catch never fires, and the next line sets
#           $result = "... GOOD". The customer's support file recorded
#           a success for a change the machine rejected. Bill caught it
#           on screen 34: "I checked edge startup boost no change,
#           still off", against a log reading
#           "Before: Unknown -- could not check | Result: ... GOOD".
#           Eight sites were in Apply-Setting; a ninth was found in
#           Apply-PowerSettings, a second apply path for setting 18
#           that the triage's line range never covered.
#           NOT changed: Suspend-ScreenSaver and Restore-ScreenSaver
#           (1574-1587), where -EA SilentlyContinue is correct -- a
#           cosmetic failure must not abort a security run.
#           FT-254 raised for Test-TimeDateSync (3931), same class,
#           four calls that need deciding together.
#
#   FT-203: BOTH REMINDERS WERE OFF BY DEFAULT ON A LAPTOP. schtasks.exe
#           has no switch for a missed start, for waking, or for battery,
#           so every task it creates carries
#           DisallowStartIfOnBatteries=True and StartWhenAvailable=False.
#           A senior on battery at 10:00 got no reminder, and it was not
#           shown when they plugged in either -- while the log said
#           [GOOD] Scheduled task created, which was true. The task
#           existed; it could not fire. New Set-GGTaskSettings runs after
#           the create, mutates the three properties on the task's own
#           settings object, and LOGS WHAT IT READS BACK.
#           WakeToRun stays False on purpose -- product decision.
#
#   BACK KEY: B IS NOW THE ONLY BACK KEY. Bill, 2026-08-30: "N always
#           means no and B should always be used to say back." Measured
#           on ascii43, N meant three different things across 30 of the
#           47 Read-ValidKey sites -- No at 12, Back at 7, Exit at 11 --
#           so nobody could predict it. Five sites where N actually
#           navigated backward are now B: the resume re-check, the
#           critical-deselected review, the encryption decline, the
#           BitLocker decline, and screen 27's "Ready to proceed?",
#           which is the one Bill hit.
#           NOT changed: "Still correct?", where N already means no and
#           navigates nowhere. Label fixed at the Sleep/Display question,
#           where N said "go back" but actually left the flow.
#           THE 11 N = EXIT SITES ARE UNTOUCHED -- X = Exit is not
#           decided, and changing two of N's three meanings at once is
#           how the confusion returns wearing a different letter.
#
#   FT-244: SCREEN 32 WAS DRAWN AND NEVER PAUSED. Setup-ScheduledTasks
#           begins with Clear-Host, so SCREEN-69 was painted and wiped
#           in the same second -- measured 16:09:43, 2026-08-30, two
#           renders one second apart with no keypress between them.
#           Bill: "Is there a screen 32." Same family: Show-ManualSteps
#           (SCREEN-72) was the only wrap-up screen with no Clear-Host,
#           so it painted on top of the previous one -- Bill: "Scr 34 -
#           appeared at a bottom of Scr 3b."
#   FT-243: THE REQUIRED LOG NOTICE WAS ON A SCREEN HALF THE USERS NEVER
#           REACH. The rule says it goes on the review screen, once. It
#           was inside Show-BitLockerFinalDecline -- screen 25e, reached
#           only by DECLINING encryption -- so anyone who accepted
#           encryption never saw it. Bill, screen 27: "Did not see this
#           on the Screen." The once-only guard was correct all along;
#           it was guarding the wrong screen.
#
#   FT-255: FIVE PARSES COULD NEVER POPULATE $Matches. powercfg returns an
#           ARRAY, and on an array -match is a FILTER: it returns the
#           matching element, so the `if` passes, but it NEVER sets
#           $Matches. Measured on CGDELL 2026-09-06. So the next
#           expression read a $Matches this statement did not set --
#           $null, or whatever an unrelated earlier match had left. A
#           number from a stale $Matches is worse than no number. The
#           correct pattern, ($x | Out-String) -match, was already in this
#           file at two other reads. NOT a site: the manage-bde read,
#           which is piped through Out-String at assignment already.
#   FT-246: the password-on-wake re-read is one of those five, which
#           explains two failures and makes the one success suspect.
#           What is still unknown is INSTRUMENTED, not guessed: when the
#           parse finds nothing the raw powercfg output is now logged.
#   FT-256: RAISED, NOT FIXED. Measured on CGDELL, elevated: this query
#           can return the scheme header and NO setting block at all --
#           and the status read then reports "NOT required" from a read
#           that produced nothing, which is the FT-120/FT-123 shape.
#           No parse change fixes that; it needs its own work.
#   FT-245: the silent-error breadcrumb said "at Show-ScopeDisclaimer",
#           where the USER was, not where the fault was. Wording only --
#           severity unchanged, because an access denial logged as INFO
#           is how a real failure becomes invisible.
#
#   SCREEN 12: THE SSD IS NOW DRIVE 1, at Bill's request. The list was
#           sorted by DeviceId -- hardware enumeration order, which means
#           nothing to the customer, on the first screen that tells them
#           anything about their own machine. SSDs first, the rest after,
#           DeviceId as the tiebreak. Deliberately not a plain reverse,
#           which is only correct with exactly two drives in exactly the
#           wrong order. NOT VERIFIED ON A MULTI-DRIVE MACHINE: measured
#           on CGDELL 2026-09-06, Get-PhysicalDisk returns one disk, so
#           the output here is unchanged. Check screen 12 on SANDY.
#
# CHANGES FROM ascii39 (2026-08-15 -- ASCII40: THE THREE FIELD BLOCKERS):
#   SCOPE NOTE. Two of the three blockers are in this build. FT-172 (the
#   shown-as screen numbers) is held pending Bill's approval of the
#   $script:GGScreenOrder approach -- see the field test plan, question 2.
#   Playbook Class 6 rule 3 asks for one change class per build; this build
#   carries two (input handling, and one wrong external command), which is
#   already better attribution than ascii39's three.
#
#   ---- FT-171: THE INPUT PATH. FIVE PARTS, ALL FIVE IN. ----
#
#   The 2026-08-11 SANDY run ended twice on a right-click and was written up
#   as a crash. It was not a crash. PowerShell's own event log recorded no
#   event at the time of either ending, which is what an external process kill
#   or a deliberate exit path looks like, and not what a fault looks like.
#
#   171a  ENABLE_MOUSE_INPUT IS NOW CLEARED TOO. measured on SANDY
#         2026-08-14 22:25 (Test_Results\ConsoleInputMode-SANDY-2026-08-14_22-25.txt):
#         the console mode was 0x01B7 -- QuickEdit already OFF, and
#         ENABLE_MOUSE_INPUT still ON, because ascii39's mask (4294967231)
#         clears bit 6 and leaves bit 4 alone. With bit 4 set, every mouse
#         move, click and wheel tick over the window becomes an INPUT_RECORD
#         in the same buffer keypresses use.
#         Checkup NEVER reads a mouse event, so clearing the flag discards
#         records nothing was going to use. sourced, SetConsoleMode: the flag
#         decides whether mouse events are REPORTED or DISCARDED -- it does
#         not create wheel scrolling. CONFIRM THE WHEEL STILL SCROLLS IN
#         PHASE 3 rather than trusting either side of that argument.
#   171b  THE DRAIN IS A FLUSH, NOT A COUNTED READ. Clear-PendingKeys looped
#         `while KeyAvailable` up to 256 reads / 200 ms. A 256-record buffer
#         and a 256-read cap is a coin toss. FlushConsoleInputBuffer empties
#         it in one call and cannot hit a cap.
#   171c  A CAP IS NEVER REPORTED AS A COUNT. The fallback path (used only if
#         the P/Invoke is unavailable) now logs "drain stopped at its cap --
#         events may remain" when it stops at the ceiling. A number that
#         cannot exceed its own limit is not a measurement. That is FT-162's
#         lesson -- [GOOD] printed over a command that had failed -- applied
#         to the thing next door.
#   171d  NO SINGLE KEYSTROKE ENDS THE SESSION. Show-ResumeReverify exited on
#         a bare N. CLAUDE.md has said "no accidental exits without
#         confirmation" since ascii28 and this screen broke it. N now asks.
#   171e  THE ANSWER IS TIMESTAMP-GATED -- Reset-GGInputGate, called at the
#         end of Write-GGBox, so EVERY screen gets it and a new screen cannot
#         forget it. Anything sitting in the buffer when the box finishes
#         painting arrived BEFORE the user could read the question, so it is
#         discarded. That closes the class, not just the one screen.
#         WHY THIS IS NOT FT-29: FT-29 flushed immediately BEFORE THE READ,
#         after the prompt had been on screen, so it ate the key of anyone who
#         answered promptly -- reported five or more times as "had to press
#         twice". This flush happens BEFORE THE PROMPT IS PRINTED. The window
#         it discards from is the paint itself. Nothing typed in answer to a
#         question the user has actually seen can be inside it.
#   171f  AND THE CONSOLE FLAGS ARE ASSERTED BEFORE EVERY SCREEN, not once
#         deep into the run. Found while reading for 171a: measured on the
#         ascii39 source, Disable-QuickEdit had two call sites and BOTH were
#         inside Get-AllStatuses, which runs most of the way through the
#         session. Every screen before it -- the personal-computer question
#         and the resume re-check among them -- ran with the console in
#         whatever state it started in, and SCREEN-02 announced that mouse
#         highlighting was off several screens before anything turned it off.
#         Reset-GGInputGate asserts them, so 171a actually applies from the
#         first screen instead of from the middle.
#
#   ---- FT-175: THE QUARTERLY SCAN THAT HAS NEVER RUN ----
#
#   FT-162, observed in the field for the first time (findings 38 and 43).
#   The quarterly task ran `MpCmdRun.exe -Scan -ScanType 4`. measured on
#   CGDELL 2026-08-15, MpCmdRun.exe -? documents ScanType 0-3 and no 4;
#   ScanType 4 returns 0x80070667 "Invalid command line argument" in 0.0
#   seconds. The log printed [GOOD] Scheduled task created every time,
#   because schtasks had indeed created a task -- one whose command was junk.
#
#   THE OBVIOUS FIX IS WRONG AND WAS NOT MADE. Start-MpWDOScan is the correct
#   call and is already in this file, but sourced, Microsoft's own cmdlet
#   reference: "This command causes the computer to start in Windows Defender
#   offline and begin the scan." It REBOOTS. It does not queue anything for a
#   later restart. Putting it in a task that runs as SYSTEM at 2AM would
#   restart a sleeping senior's computer unannounced, four times a year, to
#   run a scan nobody asked for that morning. That is the opposite of the
#   promise this product is sold on.
#
#   SO THE QUARTERLY TASK IS NOW A REMINDER, on the pattern of the monthly
#   Malwarebytes reminder already in this file: a popup that tells the user
#   the offline scan is due and gives the steps. The user starts it, having
#   been told the machine restarts. The interactive path (SCREEN-38) is
#   unchanged -- it already called Start-MpWDOScan correctly and already said
#   the computer would restart.
#
#   The screen text that described the old behaviour is replaced. It was
#   wrong twice over: it named a command line at the user (gate 24b) and the
#   mechanism it described never happened.
#
# CHANGES FROM ascii38 (2026-07-30 -- ASCII39: THE SURVIVAL AND TRUTHFULNESS PASS):
#   SCOPE NOTE -- READ THIS FIRST. This build deliberately mixes THREE change
#   classes (console/input handling, detection truthfulness, and copy/layout).
#   Playbook Class 6 rule 3 says one class per build and the ascii38
#   TestHistory recommended splitting. Bill scoped all 20 open items into one
#   build on 2026-07-30 and that is what shipped. Recorded here so that if a
#   field failure appears, the first question is WHICH CLASS it came from --
#   the attribution this rule exists to protect is weaker in this build than
#   in ascii38, and the next round should know that going in.
#
#   ---- BLOCKERS: THE TOOL MUST SURVIVE THE USER ----
#
#   FT-150 + FT-160: ONE MECHANISM CLOSES BOTH. A console control handler is
#           now registered with SetConsoleCtrlHandler (Register-ConsoleCtrl).
#           FT-150: Ctrl+C pressed in Mark mode KILLED the tool. Our own copy
#           tip tells users to enter Mark mode, so the tool's own guidance led
#           them into it (field note 21, 2026-07-30). TreatControlCAsInput is
#           re-asserted before every read, but entering Mark mode resets the
#           console mode underneath us (the FT-46 mechanism), so Ctrl+C arrived
#           as a SIGNAL rather than as input and the process died.
#           FT-160: clicking the window's X killed the tool with NO FOOTER.
#           Confirmed as the cause of the 13:52 crash on 2026-07-30 -- the
#           PowerShell event log contains no event at all at that moment, which
#           is the signature of CTRL_CLOSE_EVENT, not of an exception.
#           WHY ONE MECHANISM: both are console control signals. Class 6 rule 1
#           asks whether the cause can be removed rather than compensated for;
#           the cause is that this process never told Windows it wanted to
#           handle those signals.
#           WHAT IT DOES: Ctrl+C / Ctrl+Break are swallowed and the tool keeps
#           running (the ordinary Ctrl+C-as-input path through Invoke-CtrlCExit
#           is unaffected and still opens the exit confirmation). Close, logoff
#           and shutdown write the log footer during the grace period Windows
#           allows, so the log can never again end mid-sentence.
#           WHY IT IS WRITTEN IN C#: the handler runs on a thread Windows
#           injects into the process. That thread has no PowerShell runspace,
#           so calling a PowerShell function from it is unreliable. The handler
#           therefore does its own file append via System.IO and touches
#           nothing else.
#           COULD CAUSE: a double footer if both this and Save-Log ran. Guarded
#           -- FooterDone is a single shared flag that both sides set and check.
#           CANNOT DO: prevent the close. Windows terminates regardless. The
#           promise here is only that the log survives it.
#
#   FT-149: KEYPRESSES QUEUED AND SKIPPED SCREENS. Log 2026-07-30 11:27:39-42
#           shows MB DETECTED -> N -> Continue -> power -> N -> N -> Continue
#           -> apps audit -> Continue inside THREE SECONDS. The tester cannot
#           have read those screens. Field note 7: "Space bar caused something
#           to flash by perhaps more then one screen." A user can skip past
#           security decisions without ever seeing them.
#           CAUSE: keys pressed while the tool is busy sit in the console input
#           buffer and are then handed out, one each, to the next several
#           readers.
#           FIX: Clear-PendingKeys -- a TARGETED POST-ACCEPT DRAIN, called
#           AFTER a key is accepted, in all three hardened readers. This is the
#           FT-65 sanctioned pattern, already proven at the HEADS UP screen.
#           IT IS NOT the FT-29 global pre-read flush, which ate legitimate
#           first keypresses and stays removed: draining after an accept can
#           only discard keys typed BEFORE the user saw the next screen.
#           COULD CAUSE: a user deliberately pressing Space twice quickly to
#           move two screens gets one screen. That is the intended trade --
#           one press, one screen -- and it is what note 7 asked for.
#
#   FT-159: A REAL ERROR THE TOOL HID. One 4100 Warning, "Error Message =
#           System error.", at 13:42:57 on 2026-07-30 -- the HEADS UP to review
#           handoff. Nothing about it reached the Checkup log. Class 1.
#           NOT FIXED BY GUESSING AT THE CALL. The source was not identified
#           from the evidence available, and inventing one would be the FT-116
#           proxy-fix mistake. Instead the whole CLASS is closed:
#           Write-PendingErrors drains any new entries from PowerShell's own
#           $Error collection into the log at every prompt, naming the screen
#           they came from. The next run reports what this one swallowed --
#           and every future swallowed error too, not just this one.
#           Bounded to 5 per prompt so a repeating error cannot flood the log.
#
#   FT-148: 20 C# COMPILATIONS PER RUN -- a regression introduced by ascii38.
#           Disable-QuickEdit called Add-Type -MemberDefinition every time,
#           compiling the same kernel32 P/Invoke wrapper from source. ascii38's
#           FT-135 fix calls it once per item, so Get-AllStatuses compiled it
#           19-20 times. Windows' own event log confirms it: dozens of 4104
#           plus 4103 CommandInvocation(Add-Type) inside one second at
#           13:42:32-33. Costly on the 8 GB Home machines we target, and it
#           floods both our log and the OS event log.
#           FIX: the compiled type is cached in $script:GGK32 and reused; the
#           QuickEdit log line is written once per session, not once per item.
#
#   FT-147: UNGUARDED ReadKey IN Show-LookBack -- the exact ascii23 FT-01
#           defect. Latent, not the cause of the 13:52 crash (see FT-160), but
#           it would bite on a focus loss eventually. Now carries the same
#           protection pattern as every other reader: try/catch, mode re-assert
#           before each read, and a fallback that returns rather than throws.
#
#   FT-146: LOOK-BACK OFFERED WHERE IT COULD NOT DELIVER. Field notes 4, 5, 6:
#           "can't go back because screen size was changed", a Back offer that
#           immediately answers "this is as far back as you can go", and space
#           returning the user to "is this your personal computer?" to answer
#           it again. The snapshot primitive works; the navigation around it
#           did not.
#           DECISION: harden and GATE, do not redesign. The offer is now made
#           only when there is a restorable previous screen AT THE CURRENT
#           BUFFER WIDTH -- so the dead ends the tester hit cannot be reached,
#           because the offer is not made. A redesign against a screen-history
#           model is a build of its own and is listed as deferred below.
#           This is the honest-degradation rule already in this file: no
#           promise, no broken promise.
#
#   ---- DETECTION TRUTHFULNESS: THE FT-120 FAMILY ----
#
#   FT-140: MALWAREBYTES DETECTION USED SecurityCenter2 REGISTRATION AS A PROXY
#           FOR "INSTALLED" -- and MB DEREGISTERS FROM SC2 WHEN ITS TRIAL
#           EXPIRES. Confirmed on two machines 2026-07-29: the Dell has MB
#           5.6.3.277 installed with MBAMService running, is absent from SC2,
#           and Checkup reported NOT DETECTED and offered a download of
#           software already on the PC. THE BUG IS INVISIBLE DURING EVALUATION
#           AND UNIVERSAL AFTERWARDS -- every user reaches trial expiry.
#           FIX: four independent installed-checks, tried in order -- SC2, the
#           MBAMService service, the uninstall registry entries in both hives,
#           and the install directory. SC2 registration is now used only for
#           what it actually means (is MB currently registered as an AV), never
#           as the installed test.
#
#   FT-141: ITEM 6 REPORTED A DEFINITE BAD FROM A CHECK THAT WAS BLOCKED. The
#           WTDS\Components key is read with -EA SilentlyContinue; on a machine
#           with Tamper Protection ON the read is refused, $null falls through,
#           and the user is told "Not configured -- all 3 need to be enabled".
#           Reproduced on BOTH machines. Since Checkup RECOMMENDS turning
#           Tamper Protection on, this read can never succeed for a correctly
#           hardened user -- the method is unusable, not merely fragile.
#           FIX: the blocked case is now distinguished from the absent case and
#           reports Unknown with manual steps. Same rule as FT-120 and FT-123:
#           a check that did not establish the state reports Unknown and never
#           invents a definite answer.
#
#   FT-143: SECURE BOOT WAS ONLY EVER CHECKED ON HOME, inside the Device
#           Encryption prerequisite block. On Pro that code never runs -- so
#           Secure Boot being OFF on the Dell has gone unreported for 38
#           builds. It is now read on every edition and shown in the system
#           baseline.
#           REPORTED, NOT CHANGED, AND DELIBERATELY SO: turning Secure Boot on
#           for an already-encrypted machine can trigger a BitLocker recovery
#           prompt at the next boot. A user who cannot produce the recovery key
#           at that prompt loses the machine. Checkup states the finding and
#           the precondition; the user acts.
#
#   FT-142: THE THIRD PHISHING TOGGLE WAS CALLED "unsafe apps". The label on
#           the user's own screen is "Warn me about unsafe password storage"
#           (captured from Sandy, field note 20). CLAUDE.md requires literal
#           on-screen labels be exact -- the reader has to find it.
#
#   FT-144: HOME DEVICE ENCRYPTION CAN START WITH NO RECOVERY KEY ANYWHERE.
#           Field-confirmed 2026-07-29: Sandy encrypted on a LOCAL account with
#           no key in any Microsoft account. Windows prompts for a Microsoft
#           account but does not require one before encrypting. An encrypted
#           drive whose key exists nowhere is a data-loss event waiting for a
#           firmware update.
#           FIX: the account type is detected (local vs Microsoft) and the key
#           is treated as a PRECONDITION, not a follow-up. The user is also
#           told they must be ONLINE when it turns on, or the key cannot be
#           uploaded even with the right account.
#
#   FT-145: WINDOWS SHOWS A PROGRESS BAR WHEN ENCRYPTING AND NOTHING WHEN
#           DECRYPTING, leaving the tester unable to tell whether it was safe
#           to reboot. Checkup now reports ConversionStatus and
#           EncryptionPercentage directly, filling a gap Windows leaves open on
#           the exact edition our users have.
#
#   FT-157: REMOTE DESKTOP ON HOME -- the tester supplied two sources
#           contradicting our claim and was half right. RESEARCHED 2026-07-30
#           (Microsoft Learn): Windows 11 Home cannot ACCEPT incoming Remote
#           Desktop connections -- that is Pro and above. Home CAN run the
#           Remote Desktop Connection client to connect OUT to other PCs, which
#           is what his sources describe and is not a risk to this PC. The copy
#           now says exactly that instead of the flat "not available".
#
#   ---- LAYOUT AND COPY ----
#
#   FT-151: FT-117 RECURRENCE -- the status column truncated at BOTH widths.
#           Missing characters on items 6, 8 and 9, and on 7b at the left.
#           CAUSE: the 60/40 split was FIXED, not content-driven, so at window
#           width 86 the name column held 45 columns of slack the status column
#           needed for a 41-character string. The tester: "need to expand/widen
#           to accommodate length. there is room." He was right.
#           FIX: both columns are measured from the actual content of the page
#           being drawn, including the header row, every render. When they do
#           not both fit, THE STATUS COLUMN WINS -- statuses are gate-consumed
#           strings read by the colour rules and the HEADS UP filter; names are
#           recognisable when shortened. The name column keeps a 24-column
#           floor so it can never collapse.
#
#   FT-153: SCREENS STILL TOO LONG, AND A NEW RULE FROM BILL: 26 LINES MAXIMUM
#           PER SCREEN, AND EVERY SCREEN ENDS WITH A BLANK LINE. Supersedes the
#           ascii37 25-line rule.
#           The blank line is implemented ONCE, in Write-GGBox, rather than by
#           editing 58 screens -- so it cannot be forgotten on a screen added
#           later. Splits: intro window setup (field note 3, "to lomg separate
#           into 2 pages") is now two screens and the intro is 6 screens, not
#           5; the "what this tool does" page 1 closing line is three bullets
#           with air around it (note 10); Device Encryption is rebuilt as four
#           screens (note 22).
#
#   FT-152: THE RENAME WAS INCOMPLETE. Screens still said "this tool" where
#           they meant Checkup (field note 6). 19 user-facing occurrences
#           corrected. Log messages are left alone -- they are not user-facing
#           and changing them would break log greps across builds.
#
#   FT-154: THE PRE-SCAN REMINDER STILL LISTED MALWAREBYTES BEFORE DEFENDER.
#           Carried from ascii37 note 6, reported again as ascii38 note 7.
#           Defender is the primary product and must read first.
#
#   FT-155: ITEM 6 IS NOW NAMED "Edge Phishing Protection" (field note 14).
#           The setting is Edge-specific and the old name did not say so.
#
#   FT-156: THE DEVICE ENCRYPTION SCREEN WAS INADEQUATE. Field note 22, at
#           length: no step-by-step for signing in to a Microsoft account; no
#           answer for a user who does not have one; never says whether the
#           recovery key is saved before or after encryption; never says how to
#           tell whether encryption is running; never says whether to reboot or
#           quit. "Users will feel lost." Rebuilt as four screens that answer
#           each of those questions in order.
#
#   ---- DEFERRED, WITH REASONS (gate 19) ----
#   FT-137 Gallery mode: untested in the field. Not touched this build so that
#          the next run can exercise it as shipped in ascii38.
#   FT-146 look-back REDESIGN (screen-history model): gated this build instead.
#          A navigation redesign needs its own build and its own field run.
#   FT-158 Ctrl+Z in the admin terminal: an environment behaviour, not a
#          Checkup defect. Recorded so it is not re-reported.
#   FT-109 scheduled tasks: NOT closed by this build and not touched. Gate 21 --
#          it stays open until Task Scheduler is opened on SANDY and both tasks
#          are confirmed present with correct actions.
#   FT-110 second half: the recovery key reaching account.microsoft.com has
#          still never been observed. FT-144's precondition check is the
#          groundwork; the observation is still owed.
#   Console host detection ($env:WT_SESSION): measured 2026-07-30, SANDY runs
#          classic conhost, so the Mark-mode copy tip is correct THERE. Whether
#          it is correct under Windows Terminal is unresolved and the tip is
#          locked verbatim in three places by CLAUDE.md -- changing it is a
#          documentation decision, not a code one.
#
# CHANGES FROM ascii37 (2026-07-29 -- ASCII38: THE NAVIGATION AND REVIEW PASS):
#   One change class, per Class 6 rule 3. Everything here serves a single goal:
#   let the tester see and review every screen, and cite screens unambiguously.
#   Copy rewrites, screen splits and the per-setting approval flow are held for
#   ascii39 precisely BECAUSE this build rewrites navigation -- mixing copy
#   edits into a control-flow build makes a field failure unattributable.
#
#   FT-132: SCREEN NUMBERS NOW TRACK POSITION, NOT IDENTITY. ascii37 displayed
#           the stable internal ID, so the 6th screen reached announced itself
#           as "Screen 02". Field notes 1, 3 and 4 (2026-07-28) all called that
#           misnumbering and all three were right: ascii36 note 5 had already
#           stated the requirement -- "screens can change position, but then
#           there screen number must chang with it."
#           ascii37 did the opposite because CodingStandards gate 12 says
#           "numbers are fixed forever, never renumber". Gate 12 exists for LOG
#           reconstruction and still governs the log; it was never a statement
#           about what the user should see. Letting it override an explicit
#           field note was the FT-116 proxy-fix mistake repeated one build after
#           citing FT-116 as the reason not to repeat it.
#           THE SPLIT: on screen, position in this user's journey ("Screen 6").
#           In the log, the stable ID plus the position it was shown as --
#           "[SCREEN-02] (shown as screen 6) Rendered: ..." -- so a note saying
#           "screen 6" maps to a log line without guessing, and cross-build
#           reconstruction still works. Revisits re-show the SAME number via the
#           seen-table, so the count never skips, jumps or repeats (the C-15
#           property that actually mattered).
#           NO "of N" TOTAL on screen: the flow is conditional, so a Pro/AC/
#           admin run reaches roughly half the screens. A total would climb
#           partway and stop, which is worse than no total. The Gallery does
#           show "of N", because there the total is real.
#           Verified: SCREEN-02, rendered 6th, now displays "Screen 6".
#
#   FT-133: LOOK-BACK -- the oldest unmet request in the project. Asked in
#           ascii20 (#6), ascii21 (#4), ascii31 (#4), ascii36 (notes 5 and 10),
#           ascii37 (note 1: "Tried to go back and couldn't. Will restart from
#           beginning") and carried in CLAUDE.md as a standing rule. Never
#           delivered because there is no "previous screen" to return to: the
#           flow is a linear sequence of function calls, and the four screens
#           that DO have Back only manage it by each sitting in its own
#           do/while loop.
#           MECHANISM: a snapshot of the actual console buffer, taken at the
#           moment the user is prompted, restored on B. It captures whatever
#           painted the screen -- Draw-Box or bare Write-Host alike.
#           WHY NOT REPLAY THE BOX DEFINITIONS: measured on ascii37, only 12 of
#           the 54 pause screens sit directly after a Draw-Box. The other 42 mix
#           box output with loose Write-Host lines, so replaying definitions
#           would silently drop those lines, and a Back that loses content is
#           worse than no Back. An earlier plan in this session promised "Back
#           on all 34 read-only screens" from box replay; that promise was
#           withdrawn once measured, before any code was written on it.
#           WHAT IT IS NOT: an undo. It executes nothing and reads no system
#           state, so it is safe on every screen INCLUDING those after a change
#           was applied -- and the prompt says so in those words. A Back that
#           appeared to reverse a registry write would be a far worse defect
#           than no Back at all.
#           NOT COVERED: re-opening a decision. Back shows you a Y/N screen you
#           already answered; it does not re-ask it. Re-opening decisions needs
#           real state rollback and is a separate build.
#           SELF-DISABLING: the dangerous failure mode is not an exception --
#           it is GetBufferContents returning SUCCESS with a blank region,
#           measured in a redirected ConsoleHost on 2026-07-29. Look-back checks
#           that its capture contains what was just painted and turns ITSELF off
#           with a logged WARN if not, rather than presenting a Back key that
#           shows blank screens. Class 1 rule 4.
#           PROVEN ON THE TARGET CONSOLE before shipping, via
#           Tool\\Test-LookBack-2026-07-29.ps1: box and loose Write-Host line
#           both restored. The mechanism was not verifiable in the build
#           environment and was not shipped on assumption.
#
#   FT-134: 27 OF 54 PAUSE SCREENS HAD NO MESSAGE. They fell back to a bare
#           "Press Enter or Space to continue...", so half the read-only screens
#           never said what continuing would do -- breaking the standing input
#           rule ("ALWAYS provide an explicit message") and the User-Facing
#           Clarity Rule with it. Fixed in ONE place: the default now states the
#           outcome, and every call site gains the Back offer without being
#           edited. Call sites with their own message keep it.
#           Also: TreatControlCAsInput is now re-asserted before EVERY read in
#           the loop rather than once before it (FT-46) -- ascii37 re-read with
#           the flag already cleared after any swallowed key.
#
#   FT-135: THE 15-MINUTE STALL. Field note 15 (2026-07-28): "Seems stalled on
#           7 of 19 ... its been 10+ minutes will hit enter key. Soon as i hit
#           key it flashed something of 19 and went to next screen." Confirmed
#           in the log: 18:02:06 to 18:17:48 with no line in between -- 15
#           minutes 42 seconds inside Get-AllStatuses.
#           This is FT-63 (Mark/QuickEdit selection freezes a process on WRITE)
#           and it exposes a hole in the standing mitigation: the rule is
#           "re-assert console flags before every READ", but this function is 19
#           probes with no read anywhere, so nothing re-asserted for the whole
#           15 minutes. QuickEdit-off is now re-asserted once per item.
#           WHAT THIS FIXES: a stray click part-way through the loop is undone
#           at the next item, so a freeze lasts one item instead of the rest of
#           the function.
#           WHAT IT DOES NOT FIX: it cannot release a write already blocked
#           (nothing runs while frozen), and it does not defeat Mark mode
#           entered deliberately with Alt+Space,E,M. Both still need a keypress,
#           which is what note 15 did. Stated plainly because half a fix
#           recorded as a whole one is how FT-120 survived into a second
#           subsystem. A completion line is now logged either way, so the next
#           stall is bounded in the log instead of inferred from a timestamp gap.
#
#   FT-136: THE TOOL IS NAMED CHECKUP. Note 17 (2026-07-28): "we should call it
#           something distinctive as we will have other tools in the future. We
#           decided on Checkup." Form certified by Bill 2026-07-29:
#           "GatewayGuard Checkup" on first mention, "Checkup" thereafter.
#           GatewayGuard is the COMPANY; Checkup is the TOOL. 32 strings
#           changed: 9 first-mention contexts (log header, first screen, startup
#           banner, mode selector, GUI titles, closing dialog, and the monthly
#           reminder popup -- which fires weeks later with no prior context and
#           therefore gets the full name), 23 running-text references.
#           TEN OCCURRENCES DELIBERATELY NOT RENAMED, because they are
#           identifiers rather than prose. Two of them would have done real
#           damage:
#             "GatewayGuard|"  -- the SALT in the MachineID hash. Renaming it
#                                 changes every machine's ID and breaks
#                                 continuity with every historical log and the
#                                 whole FT-19 machine-identity trail.
#             "GatewayGuard - Quarterly ..." and "- Monthly ..." -- Task
#                                 Scheduler task NAMES. Renaming orphans tasks
#                                 created by earlier builds and breaks the
#                                 FT-109 verification step ("look for two
#                                 'GatewayGuard' tasks").
#           Also kept: -Namespace "GatewayGuard" (.NET namespace),
#           C:\\GatewayGuard\\ and ProgramData\\GatewayGuard (state and log
#           paths), Run-GatewayGuard.bat, gatewayguard.co, GatewayGuard LLC,
#           and the GatewayGuard-Log-*.txt filename pattern.
#           A blanket find-and-replace would have hit the hash salt and the task
#           names. Every replacement is individually asserted and every keep is
#           verified by count.
#           WIDTH RE-MEASURED AFTER: widest box is now 74 columns (the mode
#           selector, up from 70). Nothing exceeds 80.
#
#   FT-137: SCREEN GALLERY (-Gallery). Bill, 2026-07-29: "I also need a
#           methodology that will allow me to see every screen Checkup has so my
#           review will be more complete." Asked four times before -- ascii27
#           #14 and #15, ascii31 #10, ascii36 note 3 -- and never answered,
#           because no amount of running the tool can answer it. Most screens
#           are conditional and six are mutually exclusive by construction:
#           Test-DefenderPrimary renders exactly one of six per run, so five of
#           them are unreachable on any given machine in any given state.
#           THE ANTI-DRIFT REQUIREMENT: a hand-built gallery would be a second
#           copy of the screen content and would rot into a document that lies.
#           So the Gallery contains NO screen content. It parses THIS SCRIPT'S
#           OWN SOURCE with the PowerShell AST at runtime, finds every Draw-Box
#           call, and invokes each one. There is no second copy to drift from --
#           add, edit or delete a screen and the Gallery reflects it next run.
#           Walk it with Next / Back / Jump-to-number / Quit. Runs no checks,
#           reads no system state, changes nothing; the values shown are seeded
#           and marked EXAMPLE so a Gallery screen cannot be mistaken for a real
#           reading of the machine. Roughly 20 minutes for all 58 screens --
#           the ascii37 field run took from 16:43 to 13:28 the next day and
#           still did not finish.
#           It is a switch, not a menu option, so a real user never sees it and
#           cannot land in it by accident.
#
#   FT-138: GATE 12 PASSES FOR THE FIRST TIME. CodingStandards gate 12 ("every
#           Draw-Box screen must log [SCREEN-NN]; master list maintained") has
#           been mandatory for months and has never once passed. It now has a
#           mechanical check -- Check-ScreenCoverage-2026-07-29.ps1 -- built on
#           the same AST walk the Gallery uses: it counts Draw-Box calls,
#           verifies every one carries a -ScreenId, and fails on any duplicate
#           or missing ID. Current result: 58 calls, 58 tagged, 0 duplicates.
#           A gate with no check is a wish; this is the check.
#
#   FT-139 (LOGGED, NOT FIXED): COLOUR IS CARRYING MEANING ALONE. Bill,
#           2026-07-29, reviewing the look-back test: the yellow line characters
#           are hard to distinguish from the white ones. Yellow marks warnings
#           and "needs attention" throughout this file; if yellow reads as white
#           the warning does not land. The accessibility rule is that colour
#           must never be the ONLY signal, and for a tool aimed at non-technical
#           seniors that is a product requirement, not a nicety.
#           Largely already satisfied -- status strings say "needs attention" in
#           words, warning titles carry "!" and "!!" -- but it has never been
#           audited, and the checklist legend ("Green = Already correct  Yellow
#           = Needs attention  Red = Security risk") is useless to a reader who
#           cannot tell them apart. Needs a full pass over every
#           -ForegroundColor that carries meaning, plus a non-colour cue in the
#           checklist status column. Deferred to ascii39 because it is a copy
#           and layout change and this is a control-flow build; the checklist
#           column in particular is FT-117 territory.
#
#   BUILD METHOD: assert-guarded Python wrapper, five staged passes each
#           verified before the next. Every text replacement bounded with an
#           explicit count and preceded by a count assertion; every line-indexed
#           edit asserting the content of the line it touched. Post-edit: parse
#           check, size assertion, brace balance, unique-string spot checks,
#           non-ASCII scan, duplicate-function scan, analyzer run, and a
#           re-measure of every box width. Not retyped from scratch -- that
#           would discard the field-earned contents of Read-ValidKey,
#           Pause-ForUser, Read-NavKey and Invoke-CtrlCExit, which between them
#           encode FT-01, FT-24, FT-29, FT-46, FT-65 and FT-69.
#           Three of this session's own spot-check expectations were wrong on
#           first run and each was traced to its source rather than adjusted to
#           pass, per PYTHON EDITING RULES rule 5.
#
#   NOT IN THIS BUILD, from the ascii37 notes (gate 19 -- nothing dropped):
#     note 2/3/4  SCREEN-26, 27 and the 1-5 of 5 set exceed 25 lines and need
#                 splitting. Eight screens still exceed it; all eight are listed
#                 in the ascii37 header. Copy work, ascii39.
#     note 5      scan-report and quarantine guidance.
#     note 6      SCREEN-39 bullet order (Defender first, then Malwarebytes),
#                 and the guide checked for the same order.
#     note 7      font size 20 did not take.
#     note 8      MALWAREBYTES NOT DETECTED while MB is installed. Now traceable
#                 for the first time: all six AV screens carry IDs, so the log
#                 names which branch ran.
#     note 9      Test-PowerStatus sleep wording -- FT-128 fixed
#                 Apply-PowerSettings only. Bill also asked for the previous
#                 wording back.
#     note 10     "Checking power-related security settings..." is unnumbered:
#                 it is a progress message, not a Draw-Box screen.
#     note 11     SCREEN-50 needs splitting into per-setting approve/disapprove
#                 (FT-100/D-07, open since ascii32, requested a fourth time).
#     note 12     APPS AUDIT copy; behaviour with Fortect / other AVs untested.
#     note 13     VPN coverage.
#     note 14     Checkup cannot change widgets and advertising ID
#                 automatically; Edge phishing vs SmartScreen needs research.
#     note 19     tell the user to fully Windows Update first, and research
#                 which updates revert settings.
#     FT-131      Back that RE-OPENS a decision (as opposed to look-back).
#     3.6, 3.8    MB branch-logic trace; Get-MpPreference 0x800106ba on a
#                 stopped-Defender machine.
#     FT-109..119, D-15..D-21 -- the ascii34 backlog.
#
#   STILL UNRUN: ascii34, 35 and 36 have no TestHistory document, and ascii37's
#   Dell run stopped at the checklist without reaching the checklist run, HEADS
#   UP, BitLocker, scheduled tasks or the convenience review. The Home machines
#   have never run any build: the HP is now WiFi-ready and the IdeaPad (Sandy3)
#   is Home and already encrypted, which covers FT-115 and the Home branch but
#   NOT FT-110 -- an already-encrypted machine never reaches the Home enable
#   path, which is the same state-matrix gap ascii33 recorded.
# CHANGES FROM ascii36 (2026-07-28 -- ASCII37):
#   Scope is the three items Bill ordered on 2026-07-28 (briefing gate,
#   screen numbering, false-BAD detections) plus every other ascii36 field
#   note that could be closed without inventing behaviour, plus two safety
#   fixes without which the next field run's data cannot be trusted.
#   Ten items. Everything not done is listed under DEFERRED with a reason --
#   nothing is silently dropped (gate 19).
#
#   FT-121: THE BRIEFING GATE. Two defects one line apart. Between them they
#           are the root cause of field note 3 AND a silent loss of the
#           user's resume point.
#           (a) "Briefing" was saved as a checkpoint but was never a member
#               of $global:CheckpointOrder. Test-CheckpointReached hit
#               IndexOf -> -1 and returned $false forever, and saving it
#               OVERWROTE the valid "Baseline" checkpoint written moments
#               earlier. Show-ResumePrompt guards with
#               ($saved -in $global:CheckpointOrder), which "Briefing"
#               failed -- so the resume prompt never appeared and the user
#               silently lost their place. Class 1 invisible failure: the
#               checkpoint system reported nothing wrong while doing nothing.
#           (b) The two screens that explain Defender and Malwarebytes
#               (SCREEN-26, SCREEN-27) were gated on $global:IsFirstRun. The
#               2026-07-27 session was a repeat run, so BOTH were skipped --
#               which is why field note 3 read the Defender/Malwarebytes
#               screens as "out of order" and asked that the tool explain
#               Defender and MB before asking about the offline scan. IT
#               ALREADY DOES. The tester was never receiving the
#               explanation. THIRD occurrence: the ascii34 test plan already
#               recorded SCREEN-26/27 as "not observed in any of four
#               ascii33 logs".
#           Fix: "Briefing" added to CheckpointOrder between "Baseline" and
#           "PreScanPrep"; the $global:IsFirstRun gate removed. The
#           checkpoint alone now controls the skip, which is the correct
#           mechanism -- it skips what this user already saw in THIS
#           run-through, not what an earlier run showed them weeks ago.
#           Closes field notes 2 and 3 (root cause).
#
#   FT-122: SCREEN NUMBERING -- LAUNCH REQUIREMENT (Bill 2026-07-25 and
#           2026-07-27; on-screen display ruled in by Bill 2026-07-28).
#           Field note 3: "we need screen numbering and then a digital
#           document listing all screens in order". Field note 5: "We need
#           screen numbers and back buttons on all screens, screens can
#           change position, but then there screen number must chang with
#           it."
#           BEFORE: 56 Draw-Box screens. 11 logged a [SCREEN-NN] ID from a
#           hand-written Write-Log line next to the call. 45 (80%) had no ID
#           and left no trace in any log. SCREEN-13 named two different
#           Malwarebytes screens. Nothing was ever shown to the user.
#           NOW: one mechanism. Draw-Box takes -ScreenId; it stamps
#           "[ Screen NN ]" into the top border and emits
#           "[SCREEN-NN] Rendered: <title>" to the log. All 58 screens in
#           this build pass an ID (56 inherited, plus 74 and 75 added by
#           FT-127 and FT-129). The 11 hand-written Write-Log lines are
#           deleted -- they were also making those screens log their title
#           twice on every render.
#           WHY THE BORDER, NOT A CONTENT LINE: a content-line prefix widens
#           the box, and box width is already the subject of an open defect
#           (FT-117). The tag overwrites border characters that were already
#           there, so a numbered box and an unnumbered box are byte-for-byte
#           the same width. This change cannot regress FT-117.
#           ID ASSIGNMENT: existing IDs are untouched, so every historical
#           log stays readable. SCREEN-13 stays with "MALWAREBYTES NOT
#           DETECTED" -- the older assignment, and the one that appears in
#           the 2026-07-27 log; "MALWAREBYTES DETECTED ON THIS PC" takes new
#           ID 73. New IDs 28-75 are assigned in journey order for
#           readability only. IDs ARE IDENTIFIERS, NOT POSITIONS: SCREEN-25
#           renders first and SCREEN-01 second, which is correct and must
#           never be "fixed" by renumbering. Per gate 12 they are fixed
#           forever; new screens append.
#           STANDARDS CONFLICT, DECLARED NOT HIDDEN: this contradicts
#           CodingStandards gate 18 / C-15, "No screen, prompt, or message
#           ever shows an internal ID to user." Bill overruled that on
#           2026-07-28 -- a user on a support call must be able to say which
#           screen they are on. C-15 needs amending with that date and
#           reason. The "Section -- Step N" runtime counter is unchanged and
#           still counts 1, 2, 3 with no gaps; the screen number is a
#           separate, stable identifier serving a different purpose.
#           KNOWN GAP, flagged not hidden: Run-GUIMode (mode 2) has never
#           been inventoried. Every field log to date is mode 1. Its screens
#           carry IDs only where they share a Draw-Box call with mode 1.
#
#   FT-123: ITEMS 13, 14 AND 15 REPORTED A FALSE BAD. Field note 10
#           (2026-07-27): "boost was off and widgets were off and tool said
#           they were enabled ... also passwords saves was off and tool said
#           it was enabled. what are you reading?"
#           It was reading, for all three, ONLY the HKLM policy key that
#           this tool itself writes:
#             13 Edge Startup Boost   -> Policies\Microsoft\Edge
#             14 Widgets              -> Policies\Microsoft\Dsh
#             15 Edge password saving -> Policies\Microsoft\Edge
#           A user who turns these off through Edge's or Windows' own
#           settings never touches those keys. The read returned null and
#           null fell through the else into "Enabled (default) -- needs
#           attention". The tool was reporting THE ABSENCE OF A POLICY as
#           THE STATE OF THE SETTING.
#           This is FT-120 INVERTED -- same root cause, opposite direction.
#           FT-120 turned a check that FAILED into a false GOOD; this turned
#           a policy that was NEVER SET into a false BAD. One rule closes
#           both: a check that did not establish the state reports Unknown,
#           and never invents a definite answer.
#           Fix: all three resolve null to "Unknown -- could not check".
#           That string does not match the auto-deselect patterns, so the
#           item stays offered to the user instead of being silently
#           skipped -- which is the correct handling for "we do not know".
#   FT-123b (CARRIED, NOT FIXED): reading the real effective state means
#           parsing the Edge profile Preferences JSON (items 13 and 15) and
#           HKCU\...\Explorer\Advanced\TaskbarDa (item 14). Those are claims
#           about external software behaviour: RESEARCH BEFORE STATING and
#           gate 13 (documented state-matrix test) both apply and neither is
#           satisfied yet. Reporting Unknown is honest in the meantime. The
#           false BAD was not -- which is why the half that IS provable
#           ships now rather than waiting.
#
#   FT-124: ENTER SILENTLY MEANT YES AT 32 PROMPTS. Read-ValidKey mapped
#           VK 13 to "Y" whenever "Y" was in ValidKeys. Enter means "I have
#           read this" at all 56 Pause-ForUser screens and meant "yes,
#           change my system" at every Y/N prompt -- and no prompt in this
#           file ever said so, so the outcome of the key could not be
#           predicted before pressing it. That is a direct violation of the
#           User-Facing Clarity Rule and the most likely cause of field note
#           10's "somehow all selections were removed while I was typing
#           notes."
#           Fix: the mapping is removed; the user presses the letter.
#           Verified before removal: no prompt string anywhere in this file
#           instructs the user to press Enter at a Read-ValidKey prompt.
#           Pause-ForUser is a separate reader and is unchanged.
#           WHY THIS IS IN SCOPE: until it is fixed, every field run
#           produces selection data that cannot be trusted -- including the
#           run that is meant to verify everything else in this build.
#
#   FT-125: THE CHECKLIST LOOP LOGGED NOTHING -- and field note 14's crash
#           happened inside it. "selected N to turn off all selections and
#           screen flickered for a few seconds and then displayed screen
#           showing R had been selected and when i hit space bar pgm
#           crashed."
#           GatewayGuard-Log-2026-07-27_19-08.txt ends dead at
#           "[19:14:07] [KEY] Nav 'NEXT' at: Show-ScopeDisclaimer" with no
#           error line and no footer. That is the last call before the
#           checklist loop, and the loop emitted no render line, no keypress
#           line and no command line -- so the reported sequence can be
#           neither confirmed nor refuted from the evidence.
#           THIS IS A KNOWN CRASH SITE THAT HAS RECURRED. The comment on the
#           status line in that loop already reads "Status crashes here on
#           page flip after N", written during ascii30 as FT-71. Class 6
#           rule 5 therefore applies with force: a fix aimed by inference
#           has already been shipped once at this exact line and did not
#           hold. NO SUCH CLAIM IS MADE HERE. What ships is evidence, plus
#           the two typing gaps FT-71 left behind:
#           (a) A render breadcrumb at the top of every loop iteration,
#               written to disk BEFORE the render is attempted (Class 1 rule
#               2), carrying page number, measured window width and
#               selection count -- the three variables every surviving
#               hypothesis turns on.
#           (b) A [KEY] breadcrumb for every accepted command. Empty input
#               is not logged, so a held invalid key cannot flood the file.
#           (c) [int] casts on $ggNameW / $ggStatW. [Math]::Floor returns a
#               double and both were being handed to Substring(Int32, Int32)
#               and PadRight(Int32). Class 4 rule 2.
#           (d) [string] cast on $s.Name. The ascii30 header claims the
#               FT-71 cast went to "ALL four" property accesses in this
#               renderer. It did not -- the name column was missed while the
#               status column beside it was hardened. Gate 14.
#           (e) The bare Pause-ForUser on the "nothing selected" path -- the
#               exact screen note 14 describes reaching -- now carries an
#               explicit message, per the standing input rule.
#           EXPECTED OUTCOME: if it crashes again, the log names the page,
#           the width and the last command. That is precisely what was
#           missing both previous times.
#
#   FT-126: A LITERAL "+" PRINTED ON SCREEN inside the SECURITY CRITICAL
#           warning box. PowerShell argument mode does not concatenate, so
#           Write-Host "...".PadRight(63) + "!!" -ForegroundColor Red
#           printed the plus sign raw and the box's right edge never lined
#           up. Rebuilt as one expression at the same 63-column width as the
#           four rows around it, truncated so a long item name cannot push
#           the edge out.
#
#   FT-127: THE PASSWORD-MANAGER QUESTION WAS ASKED ON EVERY RESUME. Field
#           note 11 (2026-07-27): "Resume took me right back to console mode
#           selection. However still asked a second time about P/W mgr. fix
#           this no need to ask twice." Open since ascii32 as FT-107, logged
#           then as "asked on every resume (3x in one morning); answer not
#           persisted with checkpoint."
#           Fix: the answer is saved beside the checkpoint (line 2 of the
#           state file, "PM=Y" or "PM=N") and restored when the user
#           resumes. LINE 1 IS STILL THE CHECKPOINT NAME AND NOTHING ELSE,
#           so a state file written by ascii36 or earlier reads back
#           identically. On resume the user sees a new screen (74) showing
#           what was remembered, with Y to keep it and N to be asked again.
#           WHY THIS IS NOT A CLASS 5 VIOLATION: Class 5 rule 1 bars
#           persisting PRESENTATION state and facts about the previous
#           session's ENVIRONMENT -- things that may have changed under us
#           and must be re-measured. This is neither. It is an answer the
#           user gave about themselves, and re-asking does not make it more
#           accurate; it only makes them answer the same question three
#           times in a morning. Class 5 rule 4 (resumption re-verifies) is
#           honoured by SHOWING the remembered answer and offering to change
#           it rather than silently assuming it.
#
#   FT-128: THE POWER SCREENS NEVER SAID WHAT THEY FOUND OR WHAT THEY
#           CHANGED IT TO. Field note 8: "checking power status screen --
#           still doesn't say what it found and what it changed it to. Fix
#           this." Field note 9: "same problems in power settings screen.
#           apparently nothing was fixed from the previous two test runs
#           ascii32 & 33. need to find out if ascii 36 was updated using the
#           wrong file. Please check."
#           CHECKED, AND THE ANSWER IS NO. ascii35 and ascii36 were each
#           scoped to Wake on LAN alone (FT-120, FT-120b) and never touched
#           these lines. Nothing was reverted and no wrong file was used --
#           the item had simply never been picked up in either build. Note 9
#           deserves a straight answer and that is it.
#           The old messages announced an intention ("Password on wake --
#           enabled") without naming the previous value or re-reading to
#           confirm the change landed. That is the same shape as FT-120,
#           which reported success in this very function while changing
#           nothing. Each item now prints "Was: <found>" and "Now:
#           <re-read>", and the re-read -- not the intention -- is what goes
#           in the log. Applied to Password on Wake, Fast Startup, Wake on
#           LAN and Critical Battery. Skipped items now say "skipped,
#           nothing changed" rather than a bare "skipped".
#
#   FT-129: SCREENS LONGER THAN 25 LINES. Field note 12: "What this tool
#           does screen is to long -- any screen longer then 25 lines must
#           be split into two screens."
#           "WHAT THIS TOOL DOES AND DOES NOT DO" was 39 content lines. It
#           is now two screens: page 1 of 2 (how this works, what it
#           changes, what it checks but cannot change) and page 2 of 2 (the
#           convenience items reviewed at the end, what the tool does not
#           do, and this PC's status). BOTH PAGES CARRY BACK, which also
#           chips at the oldest unmet request in the notes.
#           This is also the last screen that rendered before the field note
#           14 crash, so shortening it removes one variable from that
#           investigation.
#           MEASURED, FULL DISCLOSURE: eight other screens still exceed 25
#           content lines -- AUTOMATED STEPS COMPLETE (52), POWER SETTINGS
#           -- SECURITY REVIEW (47, one more than before because FT-129b
#           rewrapped two over-wide lines into three there), MALWAREBYTES
#           DETECTED ON THIS PC (32),
#           BEFORE YOU START -- WINDOW SETUP (32), THE SCANS WE RECOMMEND
#           (31), YOUR PC'S SECURITY TOOLS (31), BEFORE ENABLING BITLOCKER
#           (30), DRIVE ENCRYPTION -- WHAT IT IS (28). Each split is its own
#           copy decision with its own Back wiring, and doing eight of them
#           blind in one build is exactly the "extra machinery" Class 6
#           warns about. They are listed here so the count is known and the
#           work is scoped, not forgotten.
#   FT-129b: THE POWER SETTINGS BOX OVERFLOWED AN 80-COLUMN CONSOLE BY ONE
#           COLUMN. Two lines in it were 79 and 78 characters wide, forcing
#           the box to 81 columns including borders while every other box in
#           the file fits in 70. Rewrapped to three shorter lines. FT-117
#           family, found by measuring rather than by report.
#
#   FT-130: A RECORD CORRECTION, because a wrong finding in the notes is
#           worse than no finding. The 2026-07-28 session handoff records as
#           its "strongest single lead" that one box is 173 columns wide and
#           "loses more than half its content off the right edge" on an
#           80-column window, and ties field notes 10 and 14 and FT-117 to
#           it. THAT MEASUREMENT IS AN ARTIFACT. It counted PowerShell
#           SOURCE length, including embedded $(if ...) subexpressions, not
#           rendered output. The line in question --
#           "  Power:   $(if ($global:OnBattery) {...} else {...})  Sleep:
#           $(if ...)" -- is 173 characters of source and renders as roughly
#           37 characters. Re-measured properly across all 56 screens:
#           exactly one box exceeded 80 columns and it did so by one column
#           (fixed as FT-129b above); every other box fits in 70. Runaway
#           box width is NOT the mechanism behind note 14, and building on
#           that lead would have burned a build.
#
#   BUILD METHOD: assert-guarded Python wrapper (CodingStandards PYTHON
#           EDITING RULES). Python 3.12.10 is a real interpreter on this
#           machine as of 2026-07-28 -- ascii35 and ascii36 had to use a
#           PowerShell splice because it was still the Microsoft Store stub.
#           Every text replacement is bounded with an explicit count and
#           preceded by a count assertion; every line-indexed edit asserts
#           the content of the line it touches; the two block replacements
#           assert both boundary lines and are applied bottom-up so indices
#           stay valid. Post-edit: size assertion, parse check, brace
#           balance and unique-string spot checks -- all four run and all
#           four reported, per Class 7.
#           NOT DONE BY HAND-RETYPING THE FILE. A from-scratch rewrite would
#           have discarded the field-earned contents of Read-ValidKey,
#           Pause-ForUser, Read-NavKey and Invoke-CtrlCExit, which between
#           them encode FT-01, FT-24, FT-29, FT-46, FT-65 and FT-69. The
#           Playbook's carry-forward kit is explicit that rewriting those
#           from memory re-earns those bugs. ascii37 is a complete
#           replacement file produced by transforming ascii36's bytes.
#
#   DEFERRED, WITH REASONS (gate 19 -- nothing silently dropped):
#     note 1   "mB" should read "MB" on the pre-scan screen. Copy pass;
#              batched with the other copy items rather than shipped alone.
#     note 4   MB permission box flashed and vanished. Needs a reproduction
#              before any code changes -- there is nothing in either log.
#     note 13  Wake on LAN needs an independent live test to confirm the
#              state the tool reports. That is a test-procedure item, not a
#              code change: FT-120b already made the verdict truthful, and
#              note 13 asks us to PROVE it, which needs the run.
#     note 14  ROOT CAUSE REMAINS OPEN. FT-125 makes it diagnosable. This
#              build does not claim to fix it and must not be recorded as
#              having done so.
#     FT-131   BACK ON EVERY SCREEN. The oldest unmet request in the whole
#              corpus -- asked in ascii20 (#6), ascii21 (#4), ascii31 (#4,
#              "no B switch"), ascii36 (notes 5 and 10) -- and a standing
#              rule in CLAUDE.md ("Back option at every prompt -- no dead
#              ends"). Measured: 44 Read-ValidKey call sites, of which 2
#              accept "B". Closing it means giving 32 Y/N prompts a defined
#              back target and teaching each caller to handle the return.
#              That is a structural change across the whole file and it is
#              its own build. It is NOT bolted onto this one, because a
#              half-wired Back that silently does nothing is precisely the
#              FT-116 failure -- a ticket closed while the user's problem
#              stays exactly where it was. Two pages of Back were added
#              inside FT-129 where the navigation already existed.
#     3.6      "MALWAREBYTES NOT DETECTED" while MB is installed and
#              running. Confirmed a branch-logic bug, not a detection-method
#              gap: the 2026-07-16 capture shows MB registered in
#              SecurityCenter2 on this machine with productState 397312.
#              Needs a branch trace from a run, not a redesign -- and FT-122
#              now numbers all six mutually-exclusive AV screens, which is
#              what makes that trace possible for the first time.
#     3.8      Get-MpPreference throws 0x800106ba when Defender is stopped;
#              any -EA SilentlyContinue around it is a Class 1 risk. Only
#              reproducible on the HP, which has never run.
#     FT-109 to FT-119, D-15 to D-21 -- the whole ascii34 backlog.
#
#   STILL UNRUN: ascii34, ascii35 and ascii36 have no TestHistory document.
#   ascii37 is the FOURTH build to stack unrun, against Class 6 rule 3. The
#   required Home machine (HP Notebook, SANDY) has never run any of them, so
#   FT-110 and FT-115 remain unverified on the only hardware that can test
#   them. For most items in this file "fixed" currently means "written", not
#   "confirmed" -- which is exactly what field note 9 was reporting.
# CHANGES FROM ascii35 (2026-07-27 -- ASCII36 SCOPE: FT-120b only):
#   FT-120b: FT-120 was fixed in only ONE of the two subsystems that read
#           and write Wake on LAN. ascii35 fixed Run-PowerSettingsCheck /
#           Apply-PowerSettings (the Power Settings section) and left the
#           MAIN CHECKLIST item 19 untouched, still carrying all three
#           original faults verbatim:
#           (a) Get-AllStatuses case 19 filtered adapters to Status -eq
#               "Up", read only WakeOnMagicPacket, read it only through
#               Get-NetAdapterPowerManagement with -EA SilentlyContinue,
#               and let the resulting null fall through to
#               "DISABLED -- GOOD". On the Dell Latitude 5430 that is a
#               FALSE GOOD -- Ethernet has Magic Packet, Pattern Match and
#               S0ix all Enabled, and its link is Disconnected so the one
#               adapter that mattered was skipped outright.
#           (b) That false GOOD then hit the auto-deselect at the end of
#               Get-AllStatuses, so item 19 was silently skipped and the
#               user was never offered the fix. A wrong verdict that also
#               removes the remedy.
#           (c) Apply-Setting case 19 called Set-NetAdapterPowerManagement
#               with -EA SilentlyContinue on Up adapters only, for Magic
#               Packet only, then returned "-- GOOD" unconditionally,
#               which the ascii23 logStatus mapping records as [APPLIED].
#               On hardware where the Set- cmdlet throws, the tool
#               reported success and wrote APPLIED having changed nothing.
#           Both are now brought in line with the ascii35 fix: every
#           physical adapter regardless of link state, all three wake
#           settings, Get-NetAdapterAdvancedProperty primary with
#           PowerManagement as fallback, "Unknown -- could not check"
#           instead of GOOD when nothing could be read, and an apply
#           result that counts what actually changed, logs each failure,
#           and tells the user the change takes effect after restart.
#           NOT CHANGED: item 19 keeps Selected=$false by default. Wake
#           on LAN is a keep-or-disable choice (Guide: Keep vs. Disable
#           Table), not an unconditional harden. This build makes the
#           verdict truthful and the item reachable; whether it should
#           default to selected is a separate product decision.
#   BUILD METHOD: assert-guarded splice, same contract as ascii35 (Python
#           on this machine is still the Microsoft Store stub, not a real
#           interpreter -- verified again 2026-07-27). 10 boundary
#           assertions before splicing, exact line-range replacement,
#           line-count assertion, parse check, brace balance, and
#           unique-string spot checks after.
# CHANGES FROM ascii34 (2026-07-26 -- ASCII35 SCOPE: FT-120 only):
#   FT-120: Wake on LAN reported a FALSE "DISABLED -- GOOD". BLOCKER.
#           A security-critical item told the user they were safe while
#           the feature was ENABLED. Worse than a false alarm.
#           Field-verified on Dell Latitude 5430 / Win 11 Pro on
#           2026-07-26: Ethernet had Wake on Magic Packet = Enabled,
#           Wake on Pattern Match = Enabled, Wake from S0ix on Magic
#           Packet = Enabled; Wi-Fi had Wake on Pattern Match = Enabled.
#           ascii34 reported "DISABLED -- GOOD".
#           Three compounding causes, all fixed:
#           (a) DETECTION: Get-NetAdapterPowerManagement throws
#               CimException on this hardware. With -EA SilentlyContinue
#               the null result fell straight through to the else branch
#               and was reported as GOOD -- a failed check reported as a
#               passed check. Playbook Class 1, the FT-37 pattern.
#               There was no distinction between "checked and clean" and
#               "could not check". Now returns "Unknown" when nothing
#               could be read, and NEVER "GOOD".
#           (b) SCOPE: adapters were filtered to Status -eq "Up", so a
#               disconnected Ethernet -- exactly where WoL was enabled on
#               the Dell -- was never examined. Now every physical
#               adapter is checked regardless of link state.
#           (c) COVERAGE: only WakeOnMagicPacket was read. Wake on
#               Pattern Match and Wake from S0ix on Magic Packet were
#               ignored and both were Enabled. All three are now read.
#           Primary method changed to Get-NetAdapterAdvancedProperty,
#           which works on the affected hardware and matches what the
#           user sees in the GUI (the Dell has NO Power Management tab;
#           these settings live under Advanced -- 39 properties on
#           Ethernet, 23 on Wi-Fi). PowerManagement is kept as fallback.
#           REMEDIATION had the same three faults plus one worse: it
#           printed "OK Wake on LAN -- disabled" in green unconditionally,
#           so on hardware where the Set- cmdlet throws, the tool reported
#           success having changed nothing. It now counts what actually
#           changed, warns on partial failure, logs each failure, and
#           tells the user the change takes effect after restart
#           (-NoRestart is used deliberately: resetting the adapter mid-run
#           would drop the user's Wi-Fi connection).
#   KNOWN EXCEPTION TO PLAYBOOK CLASS 6 RULE 3: ascii34 is superseded
#           WITHOUT EVER HAVING BEEN FIELD-RUN. The rule says never let
#           two builds stack unrun (the ascii26 lesson). Accepted here
#           deliberately: FT-120 makes ascii34's Wake on LAN verdict
#           false, so field-running ascii34 would teach nothing on that
#           item. ascii35 is the build to field-test. Documented rather
#           than slid past.
#   BUILD METHOD NOTE: CodingStandards requires assert-guarded PYTHON
#           replacements for .ps1 edits. Python is not installed on this
#           machine (python.exe on PATH is the Microsoft Store stub). The
#           same safety contract was implemented in PowerShell instead:
#           boundary assertions before splicing, exact line-range
#           replacement, size assertion, parse check, brace balance, and
#           unique-string spot check. Results: 0 parse errors,
#           5900 -> 5957 lines (+57, matching the spliced block sizes),
#           braces 1152/1152 -> 1164/1164, FT-116 count unchanged at 2,
#           UTF-8 BOM preserved.
# PSSCRIPTANALYZER (CodingStandards Gate #1, run 2026-07-25 21:42 ET,
#   re-run after the FT-110 edit below):
#   656 findings, all but 1 pre-existing (inherited unchanged from
#   ascii33/ascii32 -- this branch has not yet had a lint pass; the FT-110
#   edit below added exactly one new $global: reference). Documented
#   justification, per Gate #1, to ship without fixing them this build:
#   426 PSAvoidUsingWriteHost, 149 PSAvoidGlobalVars -- by design; this
#     is a single-file interactive console wizard, not a module/library.
#     Write-Host is the correct tool for direct colored console output
#     (color-coded GOOD/red/yellow status is core UX); $global: state is
#     shared across the wizard's screens in a single flat script.
#   40 PSAvoidUsingEmptyCatchBlock, 18 PSAvoidUsingWMICmdlet,
#   9 PSUseApprovedVerbs, 6 PSUseSingularNouns, 2 PSAvoidUsingInvokeExpression,
#   2 PSUseDeclaredVarsMoreThanAssignments, 2 PSReviewUnusedParameter,
#   1 PSAvoidAssignmentToAutomaticVariable, 1 PSUseShouldProcessForStateChangingFunctions
#     -- knowingly deferred, NOT fixed this build. ascii34's scope was
#     blockers only (FT-109/111/112 per the ascii33 test history); a
#     full lint pass on this branch is open work for a future build.
#     NOTE: Class 1 of DefectPreventionPlaybook.md says empty catch is
#     only acceptable for cosmetic/best-effort code paths -- the 40 here
#     have NOT been individually reviewed against that rule this build;
#     treat as unverified, not pre-cleared.
# PRODUCT: GatewayGuard Windows 11 Security Hardening Tool
# AUTHOR:  William F. Burns III
#          Former ISO, Port Authority of NY & NJ
#          Senior InfoSec, PSEG of NJ
#          Computer Forensics: EnCase Enterprise, FTK
# WEBSITE: gatewayguard.co
# USE:     Personal computers only. Run as Administrator.
# CHANGES FROM ascii33 (2026-07-25 -- ASCII34 SCOPE blockers only, per
#   GatewayGuard_TestHistory-ascii33-2026-07-21-1009.md):
#   FT-110/D-20: Windows 11 Home BitLocker/Device Encryption, researched
#           then implemented (2026-07-25, primary sources cited below).
#           Root cause: 0x8031005A = FVE_E_NO_FEATURE_LICENSE --
#           Enable-BitLocker/full manage-bde is licensed to Pro/
#           Enterprise/Education only; there is no supported way to make
#           it work on Home (field-confirmed HP SANDY, 2026-07-21). Home
#           has Device Encryption instead: same underlying encryption,
#           but Windows arms it automatically once hardware prereqs are
#           met AND the user is signed in with a Microsoft account --
#           per support.microsoft.com/windows/device-encryption-in-
#           windows-cf7e2b6f-3e70-4882-9532-18633605b7df. Fix: new
#           Show-BitLockerScreen edition branch (reusing the existing
#           $isHome idiom already used elsewhere in this file) -- Home
#           NEVER calls Enable-BitLocker. New Show-BitLockerHomeScreen +
#           Test-DeviceEncryptionPrereq check the 3 prerequisites with
#           reliable, non-edition-gated cmdlets (Get-Tpm, Confirm-
#           SecureBootUEFI, reagentc /info for WinRE) -- empirically
#           verified these three run cleanly on this dev machine.
#           Deliberately does NOT try to reimplement Windows' full
#           eligibility logic (DMA-capable bus / PCR7 binding checks
#           aren't documented as script-queryable) -- defers to
#           msinfo32's own "Device Encryption Support" field for that,
#           same C-27/D-11 philosophy of not guessing what the OS
#           already knows. Screen also tells the user to verify their
#           recovery key actually lands at account.microsoft.com/
#           devices/recoverykey after signing in -- ties off the same
#           gap FT-108 found (a drive can end up encrypted with no
#           recoverable key anywhere under a local account).
#           Get-BitLockerVolume (read-only status, used earlier in the
#           same function) is unaffected -- only the enable/manage
#           cmdlets are Pro-only, so already-encrypted detection on
#           Home is unchanged. STILL NEEDS FIELD VERIFICATION on an
#           actual Home machine (per C-25) -- researched and logically
#           verified, not field-tested.
#   FT-113: Abnormal exits left no log footer and an empty "(called from: )"
#           caller. Root cause: Save-Log (footer) was only ever called via
#           Confirm-Exit's normal flow or the top-level global catch -- an
#           exit that reached neither left no footer at all; and
#           Disable-SleepPrevention's dynamic Get-PSCallStack caller lookup
#           returns empty when called from inside the PowerShell.Exiting
#           engine-event action (that scriptblock doesn't populate the call
#           stack like a normal function call). Fixed: Save-Log is now
#           idempotent ($script:GGFooterWritten guard) and is also called
#           from the engine-event handler as a last-resort safety net;
#           Disable-SleepPrevention takes an optional -CallerHint (passed
#           explicitly from the engine-event call site) and never prints a
#           blank caller.
#   FT-114: HEADS UP screen flagged a healthy "Defender Real-Time: ON" item
#           as a not-selected security concern. Root cause: that one status
#           string (Malwarebytes-Free-companion case) omitted the locked
#           "GOOD" token (Status-String Contract, Gate #23), so it failed
#           auto-deselect, the HEADS UP filter, AND the checklist color-match
#           simultaneously -- all three key on that token. Fixed at the
#           source (the status string itself) rather than special-casing
#           three separate consumers. Also removed an unreachable
#           "TrialActive" branch on the same line (the outer if/else already
#           fully handles that case).
#   FT-115: Memory Integrity showed "Status: Unknown" on HP. Same fix
#           pattern as FT-105 (Tamper Protection): Win32_DeviceGuard
#           (SecurityServicesRunning -contains 2) is the reliable RUNTIME-
#           state check, now primary; the original registry key read is
#           kept as fallback. "Unknown" only fires if both fail now.
#           Verified working on this dev machine (Pro edition); could not
#           reproduce the exact HP gap directly since this isn't the
#           affected configuration -- needs field verification.
#   FT-118: Diagnostic Data checklist status ("Required Only -- GOOD") read
#           ambiguously as a bare status with no verb. Added "Should Send"
#           so it reads as a complete assertion: "Should Send Required Only
#           -- GOOD". The locked "Required Only" substring (Status-String
#           Contract, Gate #23) is unchanged, so every -match consumer
#           still finds it -- grepped all occurrences to confirm.
#   FT-119: Final screen didn't plainly say the program was ending. Both
#           exit paths now say so explicitly: Show-ManualSteps' own screen
#           content states GatewayGuard is finished and will close (while
#           correctly noting the scheduled scans still run later, unlike
#           everything else); the console exit prompt now reads "Press
#           Enter or Space to close GatewayGuard..." instead of the
#           generic "...to exit..." used for routine screen transitions
#           elsewhere; the GUI-mode completion dialog says "GatewayGuard
#           will now close" and its title says "-- GatewayGuard Closing".
#   D-17:   BitLocker prep checklist ("BEFORE ENABLING BITLOCKER, YOU
#           MUST:") was Recovery-Key-and-power focused and never told the
#           user to back up their actual files first. Added as new item 1;
#           renumbered the existing 5 items to 2-6. Initial pass only said
#           "back up your files" with no actual steps -- caught in review
#           and followed up with the same treatment D-18 got: concrete
#           step-by-step instructions (USB/external drive via File
#           Explorer, drag-and-drop or Ctrl+C/Ctrl+V) plus a OneDrive
#           callout, not just a generic instruction.
#   D-18:   Manual-steps final screen's Malwarebytes item just said "manual
#           scans only" with no instructions. Reused the same
#           field-verified Custom Scan / Deep Scan steps already shipped
#           in the Monthly Malwarebytes Reminder popup (Setup-
#           ScheduledTasks) instead of writing new copy -- same source of
#           truth in both places now.
#   FT-116: Step counter ("Section -- Step N") was invisible throughout a
#           field run. Checked every Show-StepHeader call site the field
#           session actually reached (Baseline, PowerReview, TaskSetup) --
#           all structurally correct (Clear-Host before it, nothing wipes
#           it after). Root cause was visibility, not logic: it rendered in
#           DarkCyan, this file's own convention for de-emphasized
#           background chrome (version footer, Mark-mode copy tip) -- never
#           for anything meant to be noticed. Changed to plain Cyan, matching
#           every other active status/progress message in this file.
#   FT-117: Checklist text still got cut off on HP despite FT-56/58's
#           earlier width adaptation. Root cause: that "adaptation" was a
#           two-tier GUESS (63/38 columns above 116-wide consoles, else a
#           fixed 42/28) -- not an actual measurement. The 42/28 preset (+9
#           border/padding chars = 79 total) fits an 80-column console with
#           zero margin to spare. Fixed: column widths are now computed
#           directly from the measured console width every render (60/40
#           split with sane floors and a safety margin), not picked from two
#           hardcoded presets. Verified the formula fits at 70/80/100/116/150
#           columns on this dev machine.
#   FT-109: schtasks.exe /tr quoting fixed for BOTH scheduled tasks.
#           Root cause empirically confirmed (throwaway test task created
#           and deleted on this dev machine, 2026-07-25): PowerShell's own
#           native-argument marshalling (both the `&` call operator and
#           Start-Process -ArgumentList) mangles a /tr value that is
#           itself quoted and also contains a space (e.g. a "Program
#           Files" path), splitting it mid-path -- reproduced the exact
#           field error "Invalid argument/option - 'Files\Windows'".
#           Fix: new Invoke-SchTasksCreate helper bypasses PowerShell's
#           argument marshalling entirely via a direct
#           System.Diagnostics.Process call with a hand-built argument
#           string (real Win32 CommandLineToArgvW backslash-quote
#           escaping). Verified against both tasks' argument shapes.
#           STILL NEEDS FIELD VERIFICATION (per C-25): open Task
#           Scheduler after a real run and confirm both GatewayGuard
#           tasks exist -- empirical testing here confirms the argument
#           parsing is correct, not the end-to-end field behavior.
#   FT-111: BitLocker overnight option no longer claims "Sleep and
#           display are set to Never" when the auto-set attempt actually
#           failed (it used to print that line unconditionally,
#           contradicting the failure notice already shown above it on
#           the same screen). On failure, the screen now shows manual
#           steps and requires a Y/N confirmation before proceeding with
#           an unattended overnight run; N backs out safely.
#   FT-112: Ctrl+C during the main checklist's two-digit item-number entry
#           (e.g. typing "1" then Ctrl+C before a second digit for items
#           10-19) killed the process instantly instead of opening
#           Confirm-Exit. Root cause: TreatControlCAsInput is reset by
#           the console host after every read (FT-46) and the reassert-
#           before-every-read pattern used at every other input site in
#           this file was missing for this specific second-digit read.
#           Fixed by adding the same reassert + [char]3 check used
#           everywhere else. This is also the likely root cause of
#           FT-113 (abnormal exit, empty log caller) from the same field
#           session, since an instant kill bypasses Confirm-Exit's
#           Save-Log/Disable-SleepPrevention cleanup entirely.
# CHANGES FROM ascii32 (2026-07-19 field logs 07:43/08:09/08:57 + MB
#   scan verification on all three machines):
#   FT-93:  Scheduled tasks: $false passed positionally to switch params
#           (C-14) -> both tasks failed. FT-93b: -Once triggers died at
#           year end + could fire at creation. BOTH tasks rewritten to
#           schtasks.exe native monthly scheduling (C-14a).
#   FT-94:  ConvenienceReview restructured ASK-BEFORE-APPLY: convenience
#           items (11-15) are no longer applied in the main run; each is
#           explained and approved individually BEFORE it is applied.
#   FT-95:  ConvenienceReview copy rewritten -- every key states its
#           outcome (Y = Make this change / N = Skip it).
#   FT-96/97: Long/jargon status strings shortened to plain English that
#           fits the checklist column (STATUS-STRING CONTRACT honored:
#           GOOD/Required Only match tokens preserved).
#   FT-98:  User-facing step counter (C-15): "Section -- Step N" shown on
#           major screens, counted live per rendered screen; internal
#           SCREEN-NN stays log-only.
#   FT-101: Mark-mode tip no longer renders as a standalone blank screen
#           before BitLocker; tip prints inline, no Clear-Host/pause.
#   FT-102: Manual steps checklist honors $global:HasPasswordManager.
#   FT-105: Tamper Protection detection now uses Get-MpComputerStatus
#           IsTamperProtected (verified True on Dell) with registry
#           fallback; "Unknown" only when both fail.
#   D-06:   NEW SCREEN-26 (Your Security Tools) + SCREEN-27 (The Scans
#           We Recommend) briefing before the scan flow; Defender check
#           now runs BEFORE the Malwarebytes screen; D-13 log location
#           told early; C-20 skip acknowledgements.
#   D-15:   Scan guidance rewritten: monthly = Custom Scan (all drives,
#           "Scan for rootkits" CHECKED) first, Deep Scan after --
#           overnight verified safe with NO settings changes (MBAMService
#           holds a SYSTEM power request; screen may sleep, system does
#           not). Deep Scan does NOT check rootkits (report-verified).
#           PUP setting check added. "Sleep to Never" instruction REMOVED.
# CHANGES FROM ascii31 (2026-07-16 field logs 10:15-22:39):
#   FT-80:  Pre-scan DEFENDER OFFLINE SCAN screen: N mislabeled as exit
#           action; user expected "skip" not "exit". N now exits with
#           clear message; screen copy updated to make S=Skip prominent.
#   FT-81:  MB URL changed from gatewayguard.co/malwarebytes (SSL not
#           configured, returned ERR_CERT_COMMON_NAME_INVALID) to
#           https://www.malwarebytes.com/ -- a cert error on a security
#           tool is unacceptable. gatewayguard.co redirect deferred to
#           post-launch when hosting is live.
#   FT-83:  System Baseline screen: added explicit scroll indicator line
#           before the prompt; 3 baseline lines were hidden below the
#           fold with no indication. Full split deferred -- indicator
#           resolves the immediate FT-83 risk at lowest change cost.
#   FT-88:  Test-PersonalComputer: removed extra Clear-Host call before
#           the function -- previous screen was flashing briefly before
#           the Quick Question P/W screen appeared.
#   G-01:   Screen numbering: every Draw-Box screen now logs [SCREEN-NN]
#           with its title. Screen numbers are fixed to their title.
#           Master screen list maintained in header comments below.
#   G-02:   Three Mark mode copy reminders added:
#           (a) Checklist legend line (always visible on checklist)
#           (b) Before BitLocker prep screen (before Show-BitLockerScreen)
#           (c) Resume flow (in Show-ResumePrompt after maximize tip)
#           Wording: "Tip: To copy text from this window -- press
#           Alt+Space, then E, then M -- drag or use Shift+arrows to
#           select -- press Enter to copy. Press Esc to exit without
#           copying."
#   G-03:   Periodic scanning status copy rewritten to neutral framing.
#           Prior copy implied MB is superior to Defender; new copy
#           explains each state factually without comparison language.
# MASTER SCREEN LIST (G-01 -- numbers are fixed; never renumber):
#   SCREEN-01  Welcome / Font Instructions
#   SCREEN-02  Scroll & Copy Tip
#   SCREEN-03  Window Setup
#   SCREEN-04  Tool Overview
#   SCREEN-05  Important -- Personal Computer Check
#   SCREEN-06  Domain Check (shown only if domain-joined)
#   SCREEN-07  Administrator Check (shown only if not admin)
#   SCREEN-08  Battery / Power Check (shown only if on battery)
#   SCREEN-09  System Baseline Summary
#   SCREEN-10  Before We Scan Your PC (first run only)
#   SCREEN-11  Defender Offline Scan (first run only)
#   SCREEN-12  Post-Scan Guidance (resume after offline scan)
#   SCREEN-13  Malwarebytes Guidance
#   SCREEN-26  Your Security Tools (briefing 1 of 2) -- NEW ascii33
#   SCREEN-27  The Scans We Recommend (briefing 2 of 2) -- NEW ascii33
#   SCREEN-14  Defender Status
#   SCREEN-15  Power Settings Check
#   SCREEN-16  Apps Audit
#   SCREEN-17  Passwords Check
#   SCREEN-18  Mode Selection (Console / GUI)
#   SCREEN-19  Scope Disclaimer
#   SCREEN-20  Console Checklist (Page 1 and 2 -- same screen number)
#   SCREEN-21  BitLocker Prep (before enabling)
#   SCREEN-22  BitLocker Options
#   SCREEN-23  Convenience Review
#   SCREEN-24  Summary / What Was Done
#   SCREEN-25  Welcome Back (resume prompt)
# CHANGES FROM ascii30 (2026-07-14 field logs 08:45-09:31):
#   FT-73: global try extended to cover full launch (Ctrl+C at Welcome).
#   FT-74: Convenience counter fixed ($ci.ID -> loop index).
#   FT-75: Recovery key Desktop path -- GetFolderPath for OneDrive compat.
#   FT-76: -Monthly trigger rewritten to -Once arrays (PS 5.1 compat).
#   FT-77: BitLocker prep screen now tells user next screen handles it.
#   FT-79: Removed Sleep calls in ConvenienceReview (Alt-Tab focus loss).
# CHANGES FROM ascii29 (2026-07-14 field logs 06:20 and 07:05):
#   FT-71:  Checklist table renderer crash on P (page flip) root-caused.
#           $s.Status.Length called without [string] cast in the TABLE
#           renderer -- the FT-68 guard landed only in the review-listing
#           block, not here. When N deselects all items, a page-2 item
#           (Wake-on-LAN, item 19) carried a null/array Status from the
#           fresh deselect path; .Length on null threw inside the local
#           Run-ConsoleMode trap, which exited but could not log the ERROR
#           because the trap's own Write-Log also failed on the bad Status.
#           Fix: [string] cast applied to ALL four Status/.Name/.etc
#           property accesses in the table renderer, not just the two in
#           the review block. Same rule, applied uniformly.
#   FT-72:  Midnight session (00:00 log): tool froze at passwords screen
#           for 6 hours, then Disable-SleepPrevention fired with empty
#           call-stack ('called from: '). Root: Mark mode froze the
#           console; when the host eventually killed the frozen read,
#           the local trap caught it but Get-PSCallStack was empty at
#           that point. No code change needed -- FT-63's WARN (already
#           firing) is the mitigation. Documented for the record.
# CHANGES FROM ascii28 (2026-07-13 night-session logs, 22:11 and 22:16):
#   FT-65:  S-key flood at the security-critical HEADS UP screen root-
#           caused: the menu said 'S = Show me what each item does' but
#           the PROMPT said 'S = Skip' -- contradictory labels. Tester
#           pressed/held S expecting to skip; each buffered auto-repeat
#           re-dumped every explanation with no screen clear and no exit
#           except Y/N (52 accepted 'S' keys in ~2.5 min in the 22:16
#           log). Labels now agree, S clears and re-renders the screen,
#           and buffered repeats are drained AFTER an accepted S -- a
#           targeted post-accept drain, NOT the FT-29 global pre-read
#           flush (which ate first keypresses and stays removed).
#   FT-66:  GLOBAL ERROR TRAP added. Both 7/13 sessions died with NO
#           error line in the log -- a terminating error closes the
#           console instantly when launched from the .bat. The whole
#           main flow now runs in one try/catch: unhandled errors are
#           logged with location + stack trace, the log footer is
#           written, cleanup runs, and the window stays open.
#   FT-67:  BitLocker decision flow added at review (console mode):
#           if the drive is NOT encrypted and item 8 is not selected,
#           a dedicated HEADS UP explains what encryption protects
#           against, S shows the full plain-English write-up, and a
#           second confirmation screen notes the decline (NOTED) --
#           with a go-back path at every step to select item 8.
#   FT-68:  Review-listing hardening: Status now [string]-cast before
#           .Length/.Substring (an array or null Status could throw
#           with no trap -- the switch-Wildcard duplicate-array lesson),
#           plus a breadcrumb log line bracketing the review listing.
#   FT-69:  Ctrl+C now opens the exit confirmation (Confirm-Exit)
#           instead of being silently ignored. FT-24 stopped Ctrl+C
#           from KILLING the tool; testers then reported 'Ctrl+C does
#           nothing'. It now asks 'Are you sure you want to exit?' --
#           an accidental copy attempt still cannot end the session.
#   FT-70:  Show-ConvenienceReview was called TWICE back-to-back at the
#           end of console mode -- users saw the screen twice. Deduped.
# CHANGES FROM ascii27 (round-5 field test + 7-log analysis, 2026-07-12/13):
#   FT-46:  Ctrl+C REGRESSION root-caused -- the PowerShell console host
#           resets console input mode on its own reads, silently undoing
#           TreatControlCAsInput set once at startup. Now RE-ASSERTED
#           inside every key-reading routine, immediately before each read.
#   FT-47:  Resume no longer replays the personal-PC / admin / power
#           screens in a flash -- ONE quiet re-check screen instead
#           (Show-ResumeReverify). Full screens still show on problems.
#   FT-63:  Startup selection-freeze made visible: launch-to-init delays
#           over 60s now log a WARN (the 84-minute frozen launch in the
#           7/12 logs would have self-diagnosed). New scroll/copy tip
#           screen teaches Mark mode AND that it pauses the program.
#   FT-41/45: Scroll & copy tip screen added after window setup --
#           QuickEdit-off killed mouse copy by design; Mark mode
#           (Alt+Space, E, M ... Esc) is the sanctioned method.
#   FT-61:  Screen-timeout / critical-battery readers rebuilt: stderr
#           captured (2>&1) instead of hidden, hex parsed UNSIGNED
#           ([Convert]::ToUInt32 -- the 0x80000003 lesson again),
#           0xFFFFFFFF treated as Never, and raw powercfg output logged
#           BEFORE anything that can throw (FT-36's diagnostic never
#           fired because the throw happened first).
#   FT-38:  Malwarebytes-detected screen now recommends the DEEP scan
#           with rootkit checking, with click-by-click instructions;
#           trial box corrected -- Deep Scan also works on Free.
#   FT-39:  Wake-on-LAN review now pairs with Remote Desktop: both
#           'let someone in from outside' features strongly recommended
#           OFF, with the tech-support-scam warning spelled out.
#   FT-42:  Immediate 'Confirmed -- checking this PC...' feedback after
#           the personal-PC Y (users pressed Enter again during the
#           silent WMI pause; the stray Enter then skipped a screen).
#   FT-43:  Screen-timeout wording untangled from the tool's temporary
#           sleep-prevention (they read as contradicting each other).
#   FT-44:  Critical-battery message no longer implies the hibernate
#           FEATURE was toggled -- it sets the critical-battery ACTION.
#   FT-52:  Back navigation extended: scope screen (B returns to the
#           password question) and two-page checklist (P = other page).
#   FT-54:  'Checking setting N of 19...' live progress during status
#           checks (blinking cursor looked like a hang).
#   FT-55:  'What this tool does' claims corrected -- Tamper Protection,
#           Windows Hello, and screen timeout moved to a new 'checks but
#           cannot change -- shows you the steps' section.
#   FT-56:  Checklist width adapts to the window -- Setting column
#           42->63, Status 28->38 on maximized consoles (>=116 cols).
#   FT-58:  Checklist split into two pages (room to grow past 19 items);
#           Tamper status wording: 'check again after the trial ends'.
#   FT-60:  Periodic-scanning status wording fixed (manual toggle;
#           steps on the item's own screen).
#   FT-49/64: Instrumentation -- every Draw-Box screen renders a [SCREEN]
#           log line; the console-mode error trap now LOGS the error and
#           line number before exiting (the 16:11 silent exit wrote the
#           error to screen only); Disable-SleepPrevention logs its
#           caller; mode selection wrapped in Select-Mode so key logs
#           name the screen, not the script file.
# CHANGES FROM ascii26 (log analysis, 2026-07-12 -- ascii26 never field-run):
#   FT-37:  ROOT CAUSE of both Defender false alarms: "return if (...)" is
#           invalid PowerShell -- threw at runtime, swallowed by catch,
#           Get-MalwarebytesState returned "Unknown" whenever Defender RT
#           was off. Fixed; trial detection now actually runs.
#   FT-35:  Resume prompt now skipped in non-admin sessions -- an
#           accidental non-admin launch could previously START OVER and
#           wipe a real checkpoint (seen in the 22:30 field log)
#   FT-36:  powercfg parse failures (Screen timeout / Critical battery
#           "Could not read" on the Dell) now log raw powercfg output
#           so the next log shows exactly why
# CHANGES FROM ascii25 (round-4 field test, 2026-07-11 10:50 PM ET):
#   FT-29:  KEY-EATING FIX -- input-buffer flush removed from all prompts
#           (it was swallowing the first keypress; "press twice" reports).
#           QuickEdit-off + Ctrl+C handling remain the walk-away protections
#   FT-30:  Defender-off alarm now checks Security Center first: if
#           Malwarebytes is registered as the active AV, a calm handoff
#           explanation shows instead of the alarm (round-4 repeat fixed)
#   FT-31:  Password manager question added before the checklist; without
#           one, Edge Password Saving [E] is deselected and left ON
#   FT-32:  Status table cuts now marked with ".." + legend (was silently
#           chopping text on items 3,5,6,7,12,13,14,17)
#   FT-33:  Status #2 fall-through fixed (unknown MB states left
#           "Checking..." on screen)
#   Item 21: Status #5 healthy wording now "OFF is correct here -- GOOD"
#           (periodic scanning OFF is right when Defender is primary)
#   Items 9/10: scroll-to-top warning before the power settings screen +
#           scroll-down review reminder near its bottom
#   Items 13/14/16: "(ends in .co -- NOT .com)" on mode screen; SCROLL UP
#           AND THEN DOWN notices before the scope and checklist screens
#   Item 19: after-trial Tamper Protection reminder in the MB trial box
#   Item 26: Edge password manual check path added to setting description
# CHANGES FROM ascii24 (round-3 field test, 2026-07-11 ~1:30 PM ET):
#   FT-21:  Time check -- after answering N, the follow-up "open Settings?"
#           question is now in a yellow box (was easy to miss)
#   FT-22:  Malwarebytes launch confirmed elevated (inherits admin from
#           this tool); manual-launch fallback now includes right-click
#           Run-as-administrator steps
#   FT-23:  FALSE ALARM FIX -- a failed Defender status check used to be
#           treated as "Defender is OFF" and fired the scary warning;
#           unknown state now gets a calm informational message instead
#   FT-24:  Ctrl+C no longer kills the program (TreatControlCAsInput);
#           WINDOW SETUP now tells users everything is saved in the log
#           so nothing needs copying off screens
#   FT-25:  Not running as admin now shows instructions then CLOSES
#           (limited mode removed); select-then-right-click wording added
#   FT-26:  Immediate "Please wait -- checking your system..." at launch
#           (3-5 s hardware query gap looked like a hang)
#   FT-27:  WINDOW SETUP item 1: "IF YOU HAVEN'T MAXIMIZED THIS WINDOW
#           YET, DO IT NOW!"
#   FT-28:  Time screen explains the "(UTC-05:00)" winter-label confusion
#   FT-11+: Overnight deep-scan recommendation added after Malwarebytes
#           launch (field evidence: deep scan found 6 items quick scans
#           missed)
# CHANGES FROM ascii23 (see FieldTestNotes-2026-07-11 for full detail):
#   FT-01:  Session-ending mitigations -- input buffer flushed before every
#           key prompt (stale keys from focus switches discarded), console
#           QuickEdit mode disabled at launch, every accepted keypress now
#           logged with its screen name for diagnosis
#   FT-04:  Screen order fixed -- Welcome/maximize FIRST, then scroll
#           instruction, THEN font setup, then window setup, then overview
#   FT-05/06: Final scroll wording ("AND FOLLOWING WINDOWS", mouse wheel /
#           little arrows on the right side); WINDOW SETUP item 3 now says
#           "TOP and BOTTOM"
#   FT-10:  Maximize wording now includes Windows key + Up arrow
#   FT-18:  Back navigation (B key) added across the intro sequence --
#           full app-wide Back deferred to a future build
#   FT-19:  Machine make/model + unique machine ID (hash of hardware UUID,
#           ties only to this PC) shown at launch and written into the log
#           header; log is written to disk continuously from launch
#   FT-20:  Visible S = Skip on the "Before we scan your PC" gate
# ================================================================
#Requires -Version 5.1
<#
.SYNOPSIS
    Windows 11 Security Hardening Tool v3.1
    Developed by William F. Burns III
    Former Information Security Officer, Port Authority of New York & New Jersey

.DESCRIPTION
    Automates security settings from the Windows 11 Security Walkthrough Guide.
    FOR PERSONAL COMPUTERS ONLY. No changes made without user approval.
    All actions logged to <your user folder>\GatewayGuard\Logs\ -- Bill,
    2026-08-18, no cloud. The profile ROOT is used because OneDrive Known
    Folder Move redirects Desktop and Documents into the cloud silently.
    (with a backup copy in
    C:\ProgramData\GatewayGuard\Logs).

.NOTES
    Run as Administrator for full functionality.
    Compatible with Windows 11 Home and Pro editions.
#>

# ============================================================
# GLOBALS & INITIALIZATION
# ============================================================
# FT-137 (ascii38): -Gallery walks every screen in this file without running
# any checks or changing anything. It is a review tool, not part of the user
# journey, so it is a switch rather than a menu option -- a real user never
# sees it and cannot land in it by accident. Launch:
#   powershell -NoProfile -ExecutionPolicy Bypass -File <this file> -Gallery
# or double-click Show-AllScreens.bat.
param(
    [switch]$Gallery
)

$ScriptVersion  = "3.1"
$BuildID        = "ascii44"
$GuideURL       = "gatewayguard.co"

# STATE/RESUME SYSTEM (UX-05, UX-06) -- survives the offline-scan reboot
$StateDir       = "C:\GatewayGuard"
# Bill, 2026-08-18: "No cloud and just use local user's account drive."
# The PROFILE ROOT, deliberately -- not Desktop and not Documents, because
# OneDrive Known Folder Move redirects both of those INTO the cloud, and it
# does it silently. measured on CGDELL 2026-08-18: Desktop resolved to
# C:\Users\willi\OneDrive\Desktop while still reading as a local path.
# The profile root is never redirected by KFM.
# $StateDir itself does NOT move -- CLAUDE.md, it is an identifier and a
# recovery point, and the scheduled tasks and checkpoint file live there.
# ---- WHERE THE LOG AND THE RECOVERY KEY GO (Bill, 2026-08-18) ----
# Three tiers: OneDrive if it is already set up, local if it is not, and
# local permanently if the user is offered OneDrive and declines.
#
# NO QUESTION IS ASKED WHEN ONEDRIVE EXISTS. Bill: "if they are using
# OneDrive they already understand the benefit." Asking a second time is
# the needless prompt this project has a standing rule against.
#
# This runs at LOAD, before any screen can be drawn, because the log header
# is written in the first instant of launch (FT-63) so that an abnormal
# exit still leaves a log with a header. The destination therefore cannot
# be a question -- detection has to answer it.
#
# measured on CGDELL 2026-08-18: $env:OneDriveConsumer is the personal
# folder, and HKCU:\Software\Microsoft\OneDrive\Accounts\Personal carries
# UserFolder and UserEmail. Both are checked, and the folder must actually
# EXIST -- a stale registry entry from a removed account would otherwise
# send the log somewhere that is not there.
#
# The DECLINE is remembered in the state file so the offer is made once.
function Get-GGOneDriveFolder {
    try {
        $ggOD = $env:OneDriveConsumer
        if (-not $ggOD) {
            $ggK = 'HKCU:\Software\Microsoft\OneDrive\Accounts\Personal'
            if (Test-Path $ggK) { $ggOD = (Get-ItemProperty $ggK -EA SilentlyContinue).UserFolder }
        }
        if ($ggOD -and (Test-Path -LiteralPath $ggOD)) { return $ggOD }
    } catch {}
    return $null
}
$global:GGOneDrive     = Get-GGOneDriveFolder
$global:GGUsingOneDrive = [bool]$global:GGOneDrive
$GGUserDir = if ($global:GGUsingOneDrive) {
    Join-Path $global:GGOneDrive "GatewayGuard"
} else {
    Join-Path $env:USERPROFILE "GatewayGuard"
}
$StateFilePath  = "$StateDir\gg_state.txt"

# AFFILIATE LINK PLACEHOLDERS -- replace with actual affiliate URLs before publishing
$AffiliateMalwarebytes = "https://www.malwarebytes.com/"            # FT-81: gatewayguard.co redirect deferred; SSL not yet configured
$AffiliateMicrosoft    = "https://gatewayguard.co/microsoft365"      # AFFILIATE PLACEHOLDER

$LogPath        = Join-Path $GGUserDir ("Logs\GatewayGuard-Log-" + (Get-Date -Format 'yyyy-MM-dd_HH-mm') + ".txt")
$FirstRunFlag   = "$env:USERPROFILE\AppData\Local\W11Hardening\firstrun.flag"
$LogEntries     = [System.Collections.Generic.List[string]]::new()

$global:BitLockerKeyGenerated = $false
$global:BitLockerKeyPath      = ""
$global:IsAdmin               = $false
$global:WinEdition            = "Unknown"
$global:IsFirstRun            = $true
$global:RAMGB                 = 0
$global:OnBattery             = $false
$global:SleepPrevented        = $false
$script:GGLogNoticeShown      = $false   # FT-67 (ascii29): once-per-session log notice
$script:GGInConfirmExit       = $false   # FT-69 (ascii29): Ctrl+C recursion guard
$script:GGFooterWritten       = $false   # FT-113 (ascii34): Save-Log idempotence guard

# ============================================================
# STARTUP: CMD scroll buffer + screen saver suspension
# ============================================================
# Increase CMD/PowerShell scroll buffer so user can scroll back
try {
    $buf = $Host.UI.RawUI.BufferSize
    if ($buf.Height -lt 3000) { $buf.Height = 3000; $Host.UI.RawUI.BufferSize = $buf }
} catch {}

# Save and disable screen saver for this session
$global:OrigScreenSaverActive  = $null
$global:OrigScreenSaverTimeout = $null
$global:OrigVideoIdle          = $null
function Suspend-ScreenSaver {
    try {
        $desk = "HKCU:\Control Panel\Desktop"
        $global:OrigScreenSaverActive  = (Get-ItemProperty $desk -EA SilentlyContinue).ScreenSaveActive
        $global:OrigScreenSaverTimeout = (Get-ItemProperty $desk -EA SilentlyContinue).ScreenSaveTimeOut
        Set-ItemProperty $desk -Name ScreenSaveActive  -Value "0" -Force -EA SilentlyContinue
        Set-ItemProperty $desk -Name ScreenSaveTimeOut -Value "0" -Force -EA SilentlyContinue
        # Also set display timeout to Never for this session
        $global:OrigVideoIdle = (powercfg /query SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 2>$null) -match "Current AC.*0x(\w+)" | Out-Null
        powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0 2>$null | Out-Null
        powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0 2>$null | Out-Null
        powercfg /S SCHEME_CURRENT 2>$null | Out-Null
    } catch {}
}
function Restore-ScreenSaver {
    try {
        $desk = "HKCU:\Control Panel\Desktop"
        if ($null -ne $global:OrigScreenSaverActive)  { Set-ItemProperty $desk -Name ScreenSaveActive  -Value $global:OrigScreenSaverActive  -Force -EA SilentlyContinue }
        if ($null -ne $global:OrigScreenSaverTimeout) { Set-ItemProperty $desk -Name ScreenSaveTimeOut -Value $global:OrigScreenSaverTimeout -Force -EA SilentlyContinue }
        # Note: display timeout restore left to user -- too risky to guess original value
    } catch {}
}

# ============================================================
# SLEEP PREVENTION API
# ============================================================
Add-Type -Name "PowerMgmt" -Namespace "W11Hardening" -MemberDefinition @"
    [System.Runtime.InteropServices.DllImport("kernel32.dll")]
    public static extern uint SetThreadExecutionState(uint esFlags);
"@ -ErrorAction SilentlyContinue

function Enable-SleepPrevention {
    try {
        # BUGFIX ascii23 (2026-07-09, take 3): confirmed root cause via
        # actual test log -- PowerShell parses the HEX literal 0x80000003
        # as a NEGATIVE signed Int32 (-2147483645) first, and [uint32]
        # performs a CHECKED conversion that rejects negative values
        # outright (it does not reinterpret bits). Using the equivalent
        # DECIMAL literal instead avoids the sign ambiguity entirely --
        # PowerShell parses a bare decimal > Int32.MaxValue as a positive
        # Int64, which casts to [uint32] cleanly.
        $flags = [uint32]2147483651   # decimal equivalent of 0x80000003
        [W11Hardening.PowerMgmt]::SetThreadExecutionState($flags) | Out-Null
        $global:SleepPrevented = $true
        Write-Log -Message "Sleep/shutdown prevention activated" -Status "OK"
    } catch {
        Write-Log -Message "Could not activate sleep prevention: $_" -Status "WARN"
    }
}

function Disable-SleepPrevention {
    param([string]$CallerHint)
    try {
        if ($global:SleepPrevented) {
            $flags = [uint32]2147483648   # decimal equivalent of 0x80000000 -- see Enable-SleepPrevention note
            [W11Hardening.PowerMgmt]::SetThreadExecutionState($flags) | Out-Null
            $global:SleepPrevented = $false
            # FT-49 instrumentation (ascii28): name the caller -- this line was
            # the ONLY trace of the 16:11 silent exit in the 7/12 logs.
            # FT-113 (ascii34): the dynamic Get-PSCallStack lookup returns an
            # EMPTY Command value when called from inside the
            # PowerShell.Exiting engine-event action below -- that scriptblock
            # does not populate the call stack the same way a normal function
            # call does. Field-confirmed as the blank "(called from: )" caller
            # in the 2026-07-21 HP logs. That call site now passes an explicit
            # -CallerHint; everything else still uses the dynamic lookup, with
            # a never-blank fallback in case some other unknown path also
            # produces an empty call stack.
            $ggSpCaller = if ($CallerHint) { $CallerHint } else { try { (Get-PSCallStack)[1].Command } catch { "unknown" } }
            if (-not $ggSpCaller) { $ggSpCaller = "unknown (empty call stack)" }
            Write-Log -Message "Sleep prevention deactivated -- normal power management restored (called from: $ggSpCaller)" -Status "OK"
        }
    } catch {}
}

$null = Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action {
    Disable-SleepPrevention -CallerHint "PowerShell.Exiting engine event (last-resort cleanup)"
    # FT-113 (ascii34): Save-Log (footer + its own backup copy) previously
    # ran ONLY via Confirm-Exit's normal flow or the top-level global catch.
    # An abnormal exit that reached NEITHER of those (field-confirmed
    # 2026-07-21, HP SANDY: two sessions ended with no footer at all) left
    # the log looking cut off mid-write with no record that the session
    # actually ended. Save-Log is now idempotent (see $script:GGFooterWritten
    # guard inside it), so calling it here is a no-op if the footer was
    # already written normally, and a safety net if it wasn't -- this
    # replaces the old inline best-effort copy below, which only copied
    # whatever was already on disk (no footer) rather than writing one.
    try { Save-Log } catch {}
}

# ============================================================
# LOGGING
# ============================================================
function Initialize-LogFile {
    # Writes the session header IMMEDIATELY at launch, not retroactively at
    # the end (Save-Log's old behavior). This ensures every log file has a
    # header even if the session ends abnormally (crash, forced close, or
    # the FT-01 Alt-Tab session-ending bug) -- previously, an abnormal exit
    # meant Save-Log never ran and the log was left with no header at all.
    try {
        $logDir = Split-Path $LogPath -Parent
        if (-not (Test-Path $logDir)) { New-Item -Path $logDir -ItemType Directory -Force | Out-Null }
        # FT-189 (ascii41): write the log opener beside the logs, every launch.
        # Bill, 2026-08-17: "or a file the user can open in Notepad." The file
        # half of that request was already 90% built and 0% delivered -- the log
        # header has carried the build, computer, Machine ID and run date since
        # ascii28, at a path no senior is going to navigate to. This puts a
        # double-clickable opener next to it. Rewritten every run so a damaged
        # or deleted copy repairs itself. Read-only: it opens Notepad, nothing
        # more. NEVER self-elevates -- the Malwarebytes exploit-payload flag
        # from 2026-07-04 stands.
        try {
            if (-not (Test-Path $GGUserDir)) { New-Item -Path $GGUserDir -ItemType Directory -Force | Out-Null }
            $ggOpenerBody = @'
@echo off
REM  GatewayGuard -- opens your most recent Checkup log in Notepad.
REM  Written automatically by Checkup. Safe to double-click at any time.
REM  This file only READS your log. It changes nothing on your PC.
cd /d "%~dp0"
set "GGLOG="
for /f "delims=" %%F in ('dir /b /o-d "Logs\GatewayGuard-Log-*.txt" 2^>nul') do (
  if not defined GGLOG set "GGLOG=Logs\%%F"
)
if not defined GGLOG (
  echo.
  echo   No Checkup log was found in this folder:
  echo     %~dp0Logs
  echo.
  echo   A log is created the first time you run Checkup.
  echo   If you have run Checkup before, the folder may have been moved.
  echo.
  echo   Press Enter to close this window.
  set /p "GGCLOSE="
  exit /b 1
)
start "" notepad.exe "%GGLOG%"
'@
            $ggOpenerBody | Out-File -FilePath (Join-Path $GGUserDir "Open-My-Log.bat") -Encoding ascii -Force
        } catch {}
        $header = @"
============================================================
  GatewayGuard Checkup -- Windows 11 Security Hardening v$ScriptVersion
  Build: $BuildID
  William F. Burns III | Former ISO, Port Authority NY & NJ
  Website: $GuideURL
  Run Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
  Computer: $env:COMPUTERNAME
  Machine:  $global:MachineMake $global:MachineModel
  Machine ID: $global:MachineID (unique to this PC -- a code derived from
              this computer's hardware; it identifies this PC only)
  NOTE: This log is written continuously from launch until the program
        finishes or stops -- if the program ends unexpectedly, the LAST
        LINE below shows exactly where it was.
============================================================

"@
        $header | Out-File -FilePath $LogPath -Encoding UTF8
    } catch {}
}

function Write-Log {
    param([string]$Message, [string]$Status = "INFO")
    $entry = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] [$Status] $Message"
    $LogEntries.Add($entry)
    if (Test-Path (Split-Path $LogPath -Parent) -ErrorAction SilentlyContinue) {
        try { $entry | Out-File -FilePath $LogPath -Append -Encoding UTF8 -ErrorAction SilentlyContinue } catch {}
    }
}

function Save-Log {
    # Header is now written by Initialize-LogFile at launch -- this only
    # appends the closing footer for a clean/normal session end.
    # FT-113 (ascii34): idempotent via $script:GGFooterWritten -- Save-Log is
    # now also called from the PowerShell.Exiting last-resort handler as a
    # safety net, and must be a no-op there if a normal exit already wrote
    # the footer (otherwise the footer would be appended twice).
    if ($script:GGFooterWritten) { return }
    try {
        $logDir = Split-Path $LogPath -Parent
        if (-not (Test-Path $logDir)) { New-Item -Path $logDir -ItemType Directory -Force | Out-Null }
        "`n============================================================"  | Out-File -FilePath $LogPath -Append -Encoding UTF8
        "Log complete. Keep this file -- it is your record of all changes made." | Out-File -FilePath $LogPath -Append -Encoding UTF8
        "If you need support, email this file to: support@gatewayguard.co"       | Out-File -FilePath $LogPath -Append -Encoding UTF8
        "============================================================"           | Out-File -FilePath $LogPath -Append -Encoding UTF8
        $script:GGFooterWritten = $true
        # FT-160 (ascii39): tell the console control handler the footer exists,
        # so a window-close landing between here and process exit cannot append
        # a second one. Shared flag, both sides set and check it.
        try { [GatewayGuard.CtrlHandler]::FooterDone = $true } catch {}
        try {
            $backupDir = "C:\ProgramData\GatewayGuard\Logs"
            if (-not (Test-Path $backupDir)) { New-Item -Path $backupDir -ItemType Directory -Force | Out-Null }
            Copy-Item -Path $LogPath -Destination ($backupDir + "\" + (Split-Path $LogPath -Leaf)) -Force -EA SilentlyContinue
        } catch {}
    } catch {
        Write-Host "  Note: Could not save log file: $_" -ForegroundColor Yellow
    }
}

# ============================================================
# HELPER: DRAW BOX
# ============================================================
# ============================================================
# SCREEN NUMBERING AND LOOK-BACK (ascii38)
# ============================================================
# FT-132 (ascii38): SCREEN NUMBERS NOW TRACK POSITION, NOT IDENTITY.
# ascii37 displayed the stable internal ID, so the 6th screen the user reached
# announced itself as "Screen 02". Field notes 1, 3 and 4 (2026-07-28) all
# reported that as misnumbering, and they were right -- ascii36 note 5 had
# already specified the requirement: "screens can change position, but then
# there screen number must chang with it."
# ascii37 implemented the opposite because CodingStandards gate 12 says
# "numbers are fixed forever, never renumber". Gate 12 exists for LOG
# reconstruction, and it still governs the log. It was never a statement about
# what the user should see, and letting it override an explicit field note was
# the FT-116 proxy-fix mistake repeated.
# THE SPLIT, which serves both needs:
#   ON SCREEN -> position in this user's journey  ("Screen 6")
#   IN THE LOG -> the stable ID, unchanged        ("[SCREEN-02]")
# Revisits re-show the SAME number via the seen-table, so the count never
# skips, jumps or repeats -- the C-15 property that mattered is preserved.
# NO "of N" TOTAL: the flow is conditional, so a Pro/AC/admin run sees roughly
# half the screens. A total would climb partway and stop, which is worse than
# no total. The Gallery does show "of N", because there the total is real.
# ============================================================
# FT-172 (ascii41): THE SCREEN NUMBER TABLE.
#
# Before this, Get-ScreenNumber COUNTED AT RUNTIME in encounter order,
# so the number was a property of THE RUN and not of THE SCREEN. Two
# users got different numbers for the same screen. That is Bill's
# finding 35: "so when a user refers to it we know exactly which screen
# he is talking about."
#
# THE SCHEME, approved by Bill 2026-08-17:
#   * Integers  = the canonical journey. A first run, Console mode,
#                 Home edition, nothing skipped.
#   * Letters   = a departure from it. ONE LEVEL ONLY -- there is no
#                 8a1. A branch inside a branch takes the next letter.
#   * Revisits are exempt. Only FIRST encounters must ascend, so the
#                 checklist hub keeps its own number however often the
#                 user returns to it.
#   * A screen reachable from everywhere (the I screen) takes NO
#                 number, because any number would be a lie about
#                 where the user is.
#
# THE ORDER BELOW IS VIEWING ORDER, not ID order and not source order.
# It is written that way so a human reviewer can see a decrease. The
# call-flow walk that produced it, and the proof that no user ever meets
# a first-encounter decrease, are in
# ProjectDocs\GatewayGuard_ScreenNumberTable-2026-08-17.md.
#
# ADDING A SCREEN: give it an ID, put it in this table in the position
# the user reaches it, and renumber. Do NOT type a number into screen
# text -- that is cause 3 of this defect and it is now gone.
# ============================================================
$script:GGScreenLabels = @{
    # -- the canonical journey ------------------------------------
    "85" = "1"            # Welcome / maximize
    "86" = "2"            # Scrolling
    "87" = "3"            # Set your console font
    "28" = "4"            # FONT CHECK
    "29" = "5"            # Before you start -- your window
    "78" = "6"            # Before you start -- your keyboard
    "30" = "7"            # What happens next
    "02" = "8"            # How to scroll back and copy
    "05" = "9"            # Important -- read before continuing
    "34" = "10"           # Windows edition detected
    "35" = "11"           # Your PC -- RAM
    "09" = "12"           # Your system at a glance
    "26" = "13"           # Your PC's security tools
    "27" = "14"           # The scans we recommend
    "10" = "15"           # Pre-scan prep checklist
    "38" = "16"           # Defender offline scan
    "43" = "17"           # Antivirus status -- healthy setup
    "73" = "18"           # Malwarebytes detected
    "50" = "19"           # Power settings -- security review
    "51" = "20"           # Apps audit results
    "52" = "21"           # Mode selector
    "53" = "22"           # Quick question -- your passwords
    "54" = "23"           # What Checkup does and does not do (1 of 2)
    "75" = "24"           # What Checkup does and does not do (2 of 2)
    "76" = "25"           # The security checklist, page 1
    "77" = "26"           # The security checklist, page 2
    "55" = "27"           # Review your selections
    "61" = "28"           # Final item: device encryption
    "62" = "29"           # Your PC meets the requirements
    "79" = "30"           # Before you turn it on -- your recovery key
    "81" = "31"           # How to tell if encryption is running
    "69" = "32"           # All selected items processed
    "70" = "33"           # Automated scan schedule setup
    "72" = "34"           # Automated steps complete
    # -- branches, one level deep ---------------------------------
    "25" = "1a"           # Welcome back -- a checkpoint exists
    "31" = "1b"           # Quick re-check before resuming
    "83" = "1c"           # Are you sure you want to close Checkup?
    "01" = "3a"           # Not administrator -- how to run Checkup correctly
    "32" = "9a"           # Domain-joined warning
    "33" = "9b"           # Administrator access required
    "36" = "11a"          # Time and date -- check
    "37" = "11b"          # Time and date -- out of sync
    "39" = "14a"          # Reminder: pre-scan recommended (repeat run)
    "40" = "14b"          # Welcome back -- offline scan complete
    "41" = "17a"          # Antivirus -- alternative state
    "42" = "17b"          # Antivirus -- alternative state
    "44" = "17c"          # Antivirus -- alternative state
    "45" = "17d"          # Antivirus -- alternative state
    "46" = "17e"          # Antivirus -- alternative state
    "13" = "18a"          # Malwarebytes -- alternative state
    "47" = "18b"          # Malwarebytes -- alternative state
    "48" = "18c"          # Malwarebytes -- alternative state
    "49" = "18d"          # Power / battery warning
    "74" = "22a"          # Your passwords -- we remembered your answer
    "56" = "25a"          # Non-recommended selections
    "57" = "25b"          # Non-recommended -- confirm
    "58" = "25c"          # Heads up -- skipping encryption
    "60" = "25d"          # Why encrypt?
    "68" = "25e"          # Encryption declined
    "59" = "27a"          # Applying your changes
    "64" = "27b"          # BitLocker (Windows 11 Pro)
    "65" = "27c"          # BitLocker -- what will happen (Pro)
    "66" = "27d"          # BitLocker -- confirm (Pro)
    "67" = "27e"          # BitLocker enabled (Pro)
    "63" = "28a"          # Device encryption may not be available on this PC
    "82" = "30a"          # Already signed in with a Microsoft account
    "80" = "30b"          # How to sign in with a Microsoft account
    "23" = "33a"          # Convenience review
    "71" = "33b"          # Convenience review -- result
    "88" = "33c"          # OneDrive offer -- shown only when there is no OneDrive
    "89" = "33d"          # How to set up OneDrive
    # -- reachable from everywhere, so deliberately unnumbered ----
    "84" = ""             # About this Checkup run (the I key)
}

# Counts DISTINCT screens shown this run. Not the displayed number --
# that comes from the table above. Kept because the look-back snapshot
# uses it as an ordinal.
$script:GGScreenNo   = 0
$script:GGScreenSeen = @{}

function Get-ScreenNumber {
    param([string]$ScreenId)
    if (-not $ScreenId) { return "" }
    if (-not $script:GGScreenSeen.ContainsKey($ScreenId)) {
        $script:GGScreenNo++
        $script:GGScreenSeen[$ScreenId] = $true
    }
    # A screen missing from the table shows NO number rather than a
    # wrong one. Gate 12 fails the build for it, which is where that
    # belongs -- the user should never be the one who finds out.
    if ($script:GGScreenLabels.ContainsKey($ScreenId)) {
        return $script:GGScreenLabels[$ScreenId]
    }
    return ""
}

# FT-133 (ascii38): LOOK-BACK. Field note 1 (2026-07-28): "Tried to go back and
# couldn't. Will restart from beginning." Back has been requested in every test
# round since ascii20 (#6), ascii21 (#4), ascii31 (#4), ascii36 (notes 5, 10),
# and CLAUDE.md carries it as a standing rule ("Back option at every prompt --
# no dead ends"). It has never been delivered because there is no "previous
# screen" to return to: the flow is a linear sequence of function calls, and
# the 4 screens that DO have Back only manage it because each sits in its own
# do/while loop.
#
# WHAT THIS MECHANISM IS: a snapshot of the actual console buffer, taken at the
# moment the user is prompted. Restoring it repaints exactly what they saw --
# regardless of whether Draw-Box or a bare Write-Host painted it.
# WHY NOT REPLAY THE BOX DEFINITIONS: measured on ascii37, only 12 of the 54
# pause screens sit directly after a Draw-Box. The other 42 mix box output with
# loose Write-Host lines, so replaying box definitions would silently drop
# those lines. A Back that loses content is worse than no Back.
# PREVENTS: restarting a run from the beginning to re-read one screen.
# COULD CAUSE: memory growth, bounded by $GGSnapCap below; and a wrong repaint
# if the window is resized between capture and restore, which is caught and
# reported rather than painted.
# WHAT IT IS NOT: an undo. It executes nothing and reads no system state, so it
# is safe on every screen INCLUDING those after a change was applied -- and the
# prompt says so in those words, because a Back that appeared to undo a
# registry write would be a far worse defect than no Back at all.
# DEGRADES HONESTLY: hosts that do not support buffer capture (ISE, redirected
# console) simply are not offered Back. No promise, no broken promise.
$script:GGSnapshots = New-Object System.Collections.ArrayList
$script:GGSnapCap   = 12
$script:GGSnapOK    = $true

function Save-ScreenSnapshot {
    if (-not $script:GGSnapOK) { return }
    try {
        $ggUI = $Host.UI.RawUI
        # Capture the WHOLE VISIBLE WINDOW -- NOT "rows 0 down to the cursor".
        # Measured 2026-07-29: CursorPosition.Y is not reliably updated by
        # Write-Host in every host; it stayed frozen at one value across three
        # consecutive writes in a redirected ConsoleHost. A capture bounded by
        # the cursor therefore returns an empty region and look-back silently
        # never works -- which would have been a Class 1 invisible failure
        # inside the mechanism built to answer a Class 1 complaint. Window
        # height is always correct, and over-capturing trailing blank rows
        # costs nothing.
        $ggH = $ggUI.WindowSize.Height
        # If content scrolled past the bottom of the window, take the taller
        # of the two so nothing the user scrolled through is lost.
        if ($ggUI.CursorPosition.Y -ge $ggH) { $ggH = $ggUI.CursorPosition.Y + 1 }
        if ($ggH -gt $ggUI.BufferSize.Height) { $ggH = $ggUI.BufferSize.Height }
        if ($ggH -lt 2) { return }
        $ggRect = New-Object System.Management.Automation.Host.Rectangle 0, 0, ($ggUI.BufferSize.Width - 1), ($ggH - 1)
        $ggCells = $ggUI.GetBufferContents($ggRect)
        # Record the last row that actually has content, so a restore can put
        # the cursor immediately below it instead of at the window bottom
        # (which would scroll the restored screen straight back off view).
        $ggLast = 0
        for ($ggY = 0; $ggY -lt $ggCells.GetLength(0); $ggY++) {
            for ($ggX = 0; $ggX -lt $ggCells.GetLength(1); $ggX++) {
                if ($ggCells[$ggY, $ggX].Character -ne ' ') { $ggLast = $ggY; break }
            }
        }
        # SELF-CHECK: the capture must actually contain what was just painted.
        # Every real screen in this tool is at least a box plus a prompt, so a
        # capture whose last non-blank row is near the top means this host is
        # not painting into the console buffer we just read -- GetBufferContents
        # returned SUCCESS and gave back a blank region. Measured on 2026-07-29
        # in a redirected ConsoleHost: no exception, 21 rows, nothing in them.
        # In that state, offering Back would show the user a blank screen. So
        # look-back turns ITSELF off and says so in the log, rather than
        # shipping a feature that appears to work and does not.
        if ($ggLast -lt 3) {
            $script:GGSnapOK = $false
            try { Write-Log -Message "Look-back DISABLED -- console buffer capture returned no content (last non-blank row $ggLast). This host does not paint into the readable buffer." -Status "WARN" } catch {}
            return
        }
        $null = $script:GGSnapshots.Add([PSCustomObject]@{
            Number   = $script:GGScreenNo
            Width    = $ggUI.BufferSize.Width
            LastRow  = $ggLast
            Cells    = $ggCells
        })
        while ($script:GGSnapshots.Count -gt $script:GGSnapCap) { $script:GGSnapshots.RemoveAt(0) }
    } catch {
        # One failure is enough to know this host cannot do it -- stop trying,
        # and stop offering Back, rather than failing once per screen.
        $script:GGSnapOK = $false
        try { Write-Log -Message "Look-back unavailable in this host: $_" -Status "WARN" } catch {}
    }
}

function Restore-ScreenSnapshot {
    param($Snapshot)
    try {
        $ggUI = $Host.UI.RawUI
        if ($Snapshot.Width -ne $ggUI.BufferSize.Width) { return $false }
        Clear-Host
        $ggOrigin = New-Object System.Management.Automation.Host.Coordinates 0, 0
        $ggUI.SetBufferContents($ggOrigin, $Snapshot.Cells)
        # A raw buffer write does not move the cursor -- put it just below the
        # restored content so anything printed next does not overwrite it, and
        # so the screen does not immediately scroll (which is what parking the
        # cursor at the window bottom would do).
        $ggRow = $Snapshot.LastRow + 1
        if ($ggRow -ge $ggUI.BufferSize.Height) { $ggRow = $ggUI.BufferSize.Height - 1 }
        $ggUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates 0, $ggRow
        return $true
    } catch {
        return $false
    }
}

function Show-LookBack {
    # Walks backwards through the snapshots. Returns once the user comes
    # forward; the caller then restores the screen they were actually on.
    #
    # FT-147 (ascii39): EVERY ReadKey IN HERE IS NOW GUARDED. ascii38 shipped a
    # bare $Host.UI.RawUI.ReadKey with no try/catch -- the exact ascii23 FT-01
    # defect that the checklist loop carries a long comment about, reintroduced
    # in new code four builds later. It did NOT cause the 2026-07-30 crash (see
    # FT-160: that was the window's X), but a focus loss or a resize during
    # look-back would have ended the session with no footer and no explanation.
    # It now carries the same protection as Read-ValidKey and Pause-ForUser:
    # try/catch, console mode re-asserted before each read, and a failure that
    # RETURNS the user to their screen rather than throwing out of the program.
    #
    # FT-146 (ascii39): the "as far back as you can go" dead end is gone. It was
    # never reachable by accident -- it was reachable because Pause-ForUser
    # OFFERED Back when there was nothing restorable behind the user (field
    # notes 4, 5, 6). The offer is now gated at the call site, so this function
    # is only ever entered when it has something to show.
    $ggIdx = $script:GGSnapshots.Count - 1        # index of the current screen
    while ($true) {
        if ($ggIdx -le 0) {
            # Reached only if snapshots were trimmed mid-look-back. Say so
            # plainly and go back to the screen the user was on.
            Write-Host ""
            Write-Host "  That is as far back as Checkup kept. Everything from this run" -ForegroundColor Yellow
            Write-Host "  is in your log file:" -ForegroundColor Yellow
            Write-Host "    $LogPath" -ForegroundColor Gray
            Write-Host ""
            Write-Host "  Returning you to the screen you were on." -ForegroundColor White
            return
        }
        $ggIdx--
        if (-not (Restore-ScreenSnapshot -Snapshot $script:GGSnapshots[$ggIdx])) {
            # Width changed since capture. Do not paint a wrong screen.
            Clear-Host
            Write-Host ""
            Write-Host "  That earlier screen cannot be shown again -- this window was" -ForegroundColor Yellow
            Write-Host "  resized after it was displayed. It is in your log file:" -ForegroundColor Yellow
            Write-Host "    $LogPath" -ForegroundColor Gray
        }
        Write-Host ""
        Write-Host "  LOOKING BACK -- nothing on your PC has been changed or undone." -ForegroundColor Yellow
        if ($ggIdx -gt 0) {
            Write-Host "  [B]              Look back one more screen" -ForegroundColor White
        } else {
            Write-Host "  This is the earliest screen Checkup still has." -ForegroundColor DarkCyan
        }
        Write-Host "  [Enter or Space] Return to the screen you were on" -ForegroundColor White
        Write-Host ""
        $ggDone = $false
        while (-not $ggDone) {
            # FT-147: guarded read. FT-46: mode re-asserted before EVERY read.
            try { [Console]::TreatControlCAsInput = $true } catch {}
            $ggK = $null
            try {
                $ggK = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            } catch {
                # The console refused the read (focus loss, resize, redirected
                # host). Returning hands the user back to their own screen,
                # which the caller repaints -- never throw out of look-back.
                try { Write-Log -Message ("Look-back read failed, returning to current screen (FT-147): " + $_) -Status "WARN" } catch {}
                return
            }
            if ($null -eq $ggK) { return }
            if ($ggK.Character -eq [char]3) { Invoke-CtrlCExit; continue }
            if ($ggK.VirtualKeyCode -in @(13, 32)) { return }
            $ggC = ""
            try { $ggC = $ggK.Character.ToString().ToUpper() } catch {}
            if ($ggC -eq "B" -and $ggIdx -gt 0) { $ggDone = $true }
        }
    }
}

function Write-GGBox {
    # Paints a box. NO logging, NO snapshot -- shared by Draw-Box (the live
    # render) and by the Gallery, so a Gallery screen is identical to the real
    # one by construction and cannot drift from it.
    param(
        [string[]]$Lines,
        [System.ConsoleColor]$Color = "White",
        [System.ConsoleColor]$TextColor = "White",
        [string]$Number = "",
        [string]$Total = ""
    )
    # FT-217 (ascii43): a $Lines entry can contain an embedded newline -- the
    # convenience items wrap their prose with `n. .Length and PadRight treat
    # such a string as ONE long line, so a 328-char string with a newline in
    # the middle painted a 378-column box into an 86-column window. Split every
    # entry on its newlines FIRST, so each becomes its own box line.
    $ggExpanded = New-Object System.Collections.Generic.List[string]
    foreach ($ggLn in $Lines) {
        if ($ggLn -eq "---") { $ggExpanded.Add("---"); continue }
        foreach ($ggPart in ([string]$ggLn -split "`n")) { $ggExpanded.Add(($ggPart -replace "`r$", "")) }
    }
    $Lines = $ggExpanded.ToArray()
    # FT-217: never paint wider than the window. Reserve the "|..|" frame.
    # Reuse the checklist's window measure (it logs "window 86") rather than
    # inventing a second one (D-18). Truncate an over-long line with ".." and
    # log it, instead of silently ballooning the box.
    $ggWin = 80
    try { if ([Console]::WindowWidth -gt 0) { $ggWin = [Console]::WindowWidth } } catch {}
    $ggMaxContent = $ggWin - 4
    if ($ggMaxContent -lt 16) { $ggMaxContent = 16 }
    for ($ggWi = 0; $ggWi -lt $Lines.Count; $ggWi++) {
        if ($Lines[$ggWi] -ne "---" -and ([string]$Lines[$ggWi]).Length -gt $ggMaxContent) {
            $Lines[$ggWi] = ([string]$Lines[$ggWi]).Substring(0, $ggMaxContent - 2) + ".."
            try { Write-Log -Message ("Write-GGBox: a line was truncated to fit the window (" + $ggWin + " cols) -- FT-217") -Status "WARN" } catch {}
        }
    }
    $Width = 44
    foreach ($line in $Lines) {
        if ($line -ne "---" -and ([string]$line).Length -gt $Width) { $Width = ([string]$line).Length }
    }
    $border = "+" + ("=" * $Width) + "+"
    # FT-122 (ascii37): the number is stamped INTO the top border, never into a
    # content line, so a numbered box and an unnumbered box are exactly the
    # same width and FT-117 cannot regress through it.
    $topBorder = $border
    if ($Number) {
        $ggTag = if ($Total) { "[ Screen " + $Number + " of " + $Total + " ]" } else { "[ Screen " + $Number + " ]" }
        if (($ggTag.Length + 4) -le $Width) {
            $topBorder = "+==" + $ggTag + ("=" * ($Width - $ggTag.Length - 2)) + "+"
        }
    }
    # FT-153 (ascii39): EVERY SCREEN ENDS WITH A BLANK LINE. Field note 11
    # (2026-07-30): "Screen 20 2 of 2 = blank line at end. All screens should
    # have a last line as a blank line for east of reading." Done HERE, once,
    # rather than by editing 58 screen definitions -- a screen added next build
    # gets it automatically and cannot forget it. Screens that already end
    # blank are left alone, so nothing gains a double gap.
    if ($Lines.Count -gt 0) {
        $ggTail = [string]$Lines[$Lines.Count - 1]
        if ($ggTail.Trim() -ne "" -and $ggTail.Trim() -ne "---") { $Lines = $Lines + @("") }
    }
    $isHeader = $true
    Write-Host $topBorder -ForegroundColor $Color
    foreach ($line in $Lines) {
        if ($line -eq "---") {
            Write-Host $border -ForegroundColor $Color
            $isHeader = $false
        } else {
            $lineColor = if ($isHeader) { $Color } else { $TextColor }
            Write-Host ("|" + ([string]$line).PadRight($Width) + "|") -ForegroundColor $lineColor
        }
    }
    Write-Host $border -ForegroundColor $Color
    # FT-171e (ascii40): the timestamp gate, applied centrally so that every
    # screen has it and no new screen can forget it. See Reset-GGInputGate for
    # why this is not the FT-29 pre-read flush.
    Reset-GGInputGate
}

function Get-AllScreenDefinitions {
    # Parses THIS script's own source and returns every Draw-Box call in file
    # order. Returns the call's source text, its ScreenId, and the function it
    # lives in. NO screen content is stored anywhere in this function -- that is
    # the whole point. If a screen is added, edited or removed, this sees the
    # change on the next run because it reads the file, not a copy of it.
    param([string]$Path)
    $ggErr = $null; $ggTok = $null
    $ggAst = [System.Management.Automation.Language.Parser]::ParseFile($Path, [ref]$ggTok, [ref]$ggErr)
    if ($ggErr -and $ggErr.Count -gt 0) {
        Write-Host "  Cannot read screen list: this file has $($ggErr.Count) parse error(s)." -ForegroundColor Red
        return @()
    }
    $ggCalls = $ggAst.FindAll({
        param($n)
        $n -is [System.Management.Automation.Language.CommandAst] -and $n.GetCommandName() -eq "Draw-Box"
    }, $true)
    $ggOut = New-Object System.Collections.ArrayList
    foreach ($ggC in $ggCalls) {
        # the -ScreenId value, read straight off the call
        $ggId = ""
        $ggEls = $ggC.CommandElements
        for ($ggI = 0; $ggI -lt $ggEls.Count; $ggI++) {
            $ggEl = $ggEls[$ggI]
            if ($ggEl -is [System.Management.Automation.Language.CommandParameterAst] -and
                $ggEl.ParameterName -eq "ScreenId" -and ($ggI + 1) -lt $ggEls.Count) {
                $ggId = $ggEls[$ggI + 1].Extent.Text.Trim('"').Trim("'")
            }
        }
        # the enclosing function, by walking up the tree
        $ggFn = "(main block)"
        $ggP = $ggC.Parent
        while ($ggP) {
            if ($ggP -is [System.Management.Automation.Language.FunctionDefinitionAst]) { $ggFn = $ggP.Name; break }
            $ggP = $ggP.Parent
        }
        $null = $ggOut.Add([PSCustomObject]@{
            ScreenId = $ggId
            Function = $ggFn
            Line     = $ggC.Extent.StartLineNumber
            Source   = $ggC.Extent.Text
        })
    }
    return $ggOut
}

function Show-ScreenGallery {
    # Walks every screen with Next / Back / Jump / Quit. Runs no checks, reads
    # no system state, changes nothing. Representative values are seeded below
    # so screens that interpolate a variable render with something readable
    # instead of a blank.
    Clear-Host
    $ggDefs = @(Get-AllScreenDefinitions -Path $PSCommandPath)
    $ggTotal = $ggDefs.Count
    if ($ggTotal -eq 0) {
        Write-Host "  No screens found. Nothing to show." -ForegroundColor Red
        return
    }

    # Representative values -- NOT read from this PC. Clearly fake on purpose,
    # so nobody mistakes a Gallery screen for a real reading of their machine.
    $global:WinEditionFriendly = "Windows 11 Pro (EXAMPLE)"
    $global:WinEdition         = "Professional"
    $global:RAMGB              = 16
    $global:IsAdmin            = $true
    $global:OnBattery          = $false
    $global:SleepPrevented     = $true
    $global:MachineID          = "EXAMPLE00000"
    $global:MachineMake        = "Example"
    $global:MachineModel       = "Test PC"
    $global:HasPasswordManager = $true
    $global:IsFirstRun         = $true
    # One screen (Show-SystemBaselineSummary) passes -Lines a VARIABLE it built
    # at runtime rather than a literal array. Verified by AST: it is the only
    # one. Without a seed it renders as an empty box in the Gallery, which would
    # look like a defect in the screen rather than a limit of the Gallery -- so
    # it is seeded and labelled instead of left blank.
    $lines = @(
        "  YOUR SYSTEM AT A GLANCE                                   ",
        "---",
        "  This screen builds its contents from your PC while the     ",
        "  tool is running, so the Gallery shows an EXAMPLE of its     ",
        "  layout rather than your real readings.                     ",
        "                                                            ",
        "  Edition:  Windows 11 Pro (EXAMPLE)                        ",
        "  RAM:      16 GB (EXAMPLE)                                 ",
        "  Defender: Active (EXAMPLE)                                "
    )

    $ggIdx = 0
    while ($true) {
        $ggD = $ggDefs[$ggIdx]
        Clear-Host
        Write-Host ""
        Write-Host ("  SCREEN GALLERY -- screen " + ($ggIdx + 1) + " of " + $ggTotal +
                    "   (log ID: SCREEN-" + $ggD.ScreenId + ")") -ForegroundColor Cyan
        Write-Host ("  Defined in " + $ggD.Function + ", source line " + $ggD.Line) -ForegroundColor DarkGray
        Write-Host "  REVIEW ONLY -- nothing on this PC is read or changed." -ForegroundColor DarkGray
        Write-Host ""
        # Render the real call. -NoHistory keeps Gallery screens out of the
        # look-back history, and the position number is passed explicitly so the
        # box shows its Gallery position rather than consuming a journey number.
        try {
            $ggSrc = $ggD.Source -replace "Draw-Box", "Write-GalleryBox"
            Invoke-Expression $ggSrc
        } catch {
            Write-Host "  (This screen could not be rendered outside the live flow:" -ForegroundColor Yellow
            Write-Host "   $($_.Exception.Message))" -ForegroundColor Yellow
            Write-Host ""
            Write-Host "  Its source begins:" -ForegroundColor DarkGray
            foreach ($ggL in ($ggD.Source -split "`n" | Select-Object -First 6)) {
                Write-Host ("    " + $ggL.Trim()) -ForegroundColor DarkGray
            }
        }
        Write-Host ""
        Write-Host "  [Enter, Space or right arrow] Next    [B or left arrow] Previous" -ForegroundColor White
        Write-Host "  [J] Jump to a screen number           [Q] Quit the gallery" -ForegroundColor White
        Write-Host "  [A] Print ALL screens in one list -- then you can scroll and copy" -ForegroundColor White
        Write-Host ""
        # FT-201 (ascii42): this is the THIRD hand-rolled reader in this file to
        # discard an unrecognised key in silence. Read-ValidKey was the first
        # (fixed ascii41), the checklist loop the second (FT-193, fixed above).
        # Here it cost Bill the whole feature: 2026-08-19, "I ran all
        # screen.bat and it only showed me one screed". The gallery was working
        # perfectly -- measured, "SCREEN GALLERY -- screen 1 of 67" rendered and
        # waited -- but it advanced ONLY on Enter or Space, and any other key
        # did nothing and said nothing. A tool that ignores you looks broken.
        #
        # Arrow keys are now accepted because they are what a person reaches for
        # in a "next / previous" viewer, and N because the checklist next to it
        # uses letters. The rule this file keeps re-learning: a reader must
        # never swallow a key without saying so.
        $ggNav = ""
        $ggGalBad = 0
        while ($ggNav -eq "") {
            try { [Console]::TreatControlCAsInput = $true } catch {}
            $ggK = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            $ggVK = $ggK.VirtualKeyCode
            # Enter, Space, right arrow, down arrow, PageDown
            if ($ggVK -in @(13, 32, 39, 40, 34)) { $ggNav = "NEXT"; break }
            # Left arrow, up arrow, PageUp
            if ($ggVK -in @(37, 38, 33)) { $ggNav = "B"; break }
            if ($ggVK -eq 27) { $ggNav = "Q"; break }   # Esc
            $ggCh = ""
            try { $ggCh = $ggK.Character.ToString().ToUpper() } catch {}
            if ($ggCh -eq "N") { $ggNav = "NEXT"; break }
            if ($ggCh -in @("A", "B", "J", "Q")) { $ggNav = $ggCh; break }
            # Nothing matched. SAY SO -- do not swallow it.
            $ggGalBad++
            if ($ggGalBad -le 2) {
                Write-Host "  That key does nothing here. Press Enter, Space or the right arrow for the next screen." -ForegroundColor Yellow
            } elseif ($ggGalBad -eq 3) {
                Write-Host "  Still nothing. [Q] or Esc closes the gallery." -ForegroundColor Yellow
            }
        }
        switch ($ggNav) {
            "Q" { Clear-Host; Write-Host ""; Write-Host "  Gallery closed. Nothing was changed." -ForegroundColor Green; Write-Host ""; return }
            "A" {
                # FT-202 (ascii42). Bill, 2026-08-19: the gallery "would not
                # scroll or accept mouse clicks". Both are true and neither is a
                # navigation fault. There is nothing to scroll TO -- the loop
                # Clear-Hosts every screen, so the one before it is gone -- and
                # there is nothing to click, because the gallery is keyboard-only
                # and never said so.
                #
                # measured: gallery mode never calls Disable-QuickEdit, so console
                # text selection is left ON and copying works normally. What was
                # missing was anything worth selecting, because each screen wiped
                # the last.
                #
                # This prints every screen in one continuous list with no clearing
                # at all. That is what "show me all the screens" should mean:
                # scroll the window back through the lot, select any of it, copy it.
                Clear-Host
                Write-Host ""
                Write-Host ("  ALL " + $ggTotal + " SCREENS, IN ORDER -- nothing is cleared, so you can") -ForegroundColor Cyan
                Write-Host "  scroll back through the whole list and copy any of it." -ForegroundColor Cyan
                Write-Host "  REVIEW ONLY -- nothing on this PC is read or changed." -ForegroundColor DarkGray
                Write-Host ""
                $ggI = 0
                foreach ($ggA in $ggDefs) {
                    $ggI++
                    Write-Host ""
                    Write-Host ("  ---- screen " + $ggI + " of " + $ggTotal +
                                "   (log ID: SCREEN-" + $ggA.ScreenId + ")  " +
                                $ggA.Function + ", line " + $ggA.Line + " ----") -ForegroundColor DarkCyan
                    Write-Host ""
                    try {
                        Invoke-Expression ($ggA.Source -replace "Draw-Box", "Write-GalleryBox")
                    } catch {
                        Write-Host ("  (could not render outside the live flow: " + $_.Exception.Message + ")") -ForegroundColor Yellow
                    }
                }
                Write-Host ""
                Write-Host ("  End of all " + $ggTotal + " screens. SCROLL BACK to read them.") -ForegroundColor Cyan
                Write-Host "  To copy: drag over the text, then press Ctrl+C." -ForegroundColor Cyan
                Write-Host ""
                Write-Host "  Press Enter to return to the gallery, or Q then Enter to close: " -ForegroundColor White -NoNewline
                $ggAfter = Read-Host
                if ($ggAfter.ToUpper().Trim() -eq "Q") {
                    Write-Host ""
                    Write-Host "  Gallery closed. Nothing was changed." -ForegroundColor Green
                    Write-Host ""
                    return
                }
            }
            "B" { if ($ggIdx -gt 0) { $ggIdx-- } }
            "J" {
                Write-Host ""
                Write-Host "  Type a screen number between 1 and $ggTotal, then press Enter:" -ForegroundColor White
                $ggJump = ""
                while ($true) {
                    try { [Console]::TreatControlCAsInput = $true } catch {}
                    $ggK2 = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
                    if ($ggK2.VirtualKeyCode -eq 13) { break }
                    if ($ggK2.VirtualKeyCode -eq 8) {
                        if ($ggJump.Length -gt 0) { $ggJump = $ggJump.Substring(0, $ggJump.Length - 1); Write-Host "`b `b" -NoNewline }
                        continue
                    }
                    $ggC2 = ""
                    try { $ggC2 = $ggK2.Character.ToString() } catch {}
                    if ($ggC2 -match "[0-9]" -and $ggJump.Length -lt 3) { $ggJump += $ggC2; Write-Host $ggC2 -NoNewline -ForegroundColor Cyan }
                }
                if ($ggJump -match "^[0-9]+$") {
                    $ggN = [int]$ggJump
                    if ($ggN -ge 1 -and $ggN -le $ggTotal) { $ggIdx = $ggN - 1 }
                }
            }
            default { if ($ggIdx -lt ($ggTotal - 1)) { $ggIdx++ } else { $ggIdx = 0 } }
        }
    }
}

function Write-GalleryBox {
    # Draw-Box stand-in for the Gallery: identical painting via Write-GGBox, but
    # no log line, no look-back snapshot, and the number shown is the Gallery
    # position rather than a journey position. Accepts and ignores -ScreenId so
    # the real call text can be invoked unmodified apart from the name.
    param(
        [string[]]$Lines,
        [System.ConsoleColor]$Color = "White",
        [System.ConsoleColor]$TextColor = "White",
        [string]$ScreenId = "",
        [switch]$NoHistory,
        [string]$Total = ""
    )
    Write-GGBox -Lines $Lines -Color $Color -TextColor $TextColor -Number ""
}

function Draw-Box {
    param(
        [string[]]$Lines,
        [System.ConsoleColor]$Color = "White",
        [System.ConsoleColor]$TextColor = "White",
        [string]$ScreenId = ""
    )
    # FT-132 (ascii38): the user sees the POSITION number; the log keeps the
    # stable ID. Painting is delegated to Write-GGBox so the Gallery renders
    # through the identical code path and cannot drift from the real screen.
    $ggNum = ""
    if ($ScreenId) { $ggNum = Get-ScreenNumber -ScreenId $ScreenId }
    Write-GGBox -Lines $Lines -Color $Color -TextColor $TextColor -Number $ggNum
    # FT-49 instrumentation (ascii28): every rendered box logs its title so
    # an unexpected exit shows exactly which screen was on-screen last.
    # FT-122 (ascii37): the [SCREEN-NN] prefix now comes from THIS one place
    # instead of 11 hand-written Write-Log lines sitting next to 11 of the 56
    # call sites. Those are deleted in this build. One mechanism means the
    # number on the user's screen, the ID in the log and the screen title
    # cannot disagree, and no screen can be added without an ID. Two
    # hand-maintained lists is how SCREEN-13 came to name two different
    # screens while 45 screens had no ID at all -- and how those 11 screens
    # came to log their title twice on every render.
    try {
        if ($Lines -and $Lines[0] -ne "---") {
            $ggTitle = ([string]$Lines[0]).Trim()
            if ($ScreenId) {
                # FT-132 (ascii38): BOTH numbers in the log line -- the stable
                # ID for cross-build reconstruction (gate 12) and the position
                # the user actually saw, so a field note saying "screen 6" can
                # be matched to a log line without guessing.
                Write-Log -Message ("[SCREEN-" + $ScreenId + "] (shown as screen " + $ggNum + ") Rendered: " + $ggTitle) -Status "SCREEN"
            } else {
                Write-Log -Message ("Rendered: " + $ggTitle) -Status "SCREEN"
            }
        }
    } catch {}
}

# ============================================================
# HELPER: PAUSE (Enter or Space only)
# ============================================================
# ============================================================
# USER-FACING STEP COUNTER (C-15 / FT-98, ascii33)
# Internal SCREEN-NN IDs are LOG-ONLY. The user sees a live counter:
# "Section -- Step N", counted per rendered screen on their actual
# path. Revisits (Back nav, resume) re-show the SAME number via the
# seen-key table -- the count never skips, jumps, or repeats.
# ============================================================
$script:GGStep = 0
$script:GGStepSeen = @{}
function Show-StepHeader {
    param([string]$Key, [string]$Section)
    if (-not $script:GGStepSeen.ContainsKey($Key)) {
        $script:GGStep++
        $script:GGStepSeen[$Key] = $script:GGStep
    }
    $ggN = $script:GGStepSeen[$Key]
    # FT-116 (ascii34): call sites were already correct (verified against
    # every screen the 2026-07-21 HP field session actually visited --
    # Baseline, PowerReview, TaskSetup -- Clear-Host runs BEFORE this, and
    # nothing wipes it after). The gap is visibility, not logic: DarkCyan is
    # this file's own convention for de-emphasized background chrome (the
    # version footer, the Mark-mode copy tip, throwaway detail lines) --
    # never for anything meant to be noticed. The step counter was styled
    # identically to throwaway text despite being the primary progress
    # indicator. Changed to plain Cyan, matching the color already used
    # everywhere else in this file for active status/progress messages.
    Write-Host "  $Section -- Step $ggN" -ForegroundColor Cyan
    Write-Host ""
}

function Pause-ForUser {
    param(
        [string]$Message = "",
        [switch]$NoBack
    )
    # FT-134 (ascii38): 27 of the 54 call sites in ascii37 passed NO message and
    # fell back to a bare "Press Enter or Space to continue..." -- half the
    # read-only screens never said what continuing would do. That breaks the
    # standing input rule ("ALWAYS provide an explicit message -- never use the
    # default") and the User-Facing Clarity Rule with it. Rather than edit 54
    # call sites, the default now states the outcome, and every call site gets
    # the Back offer for free. Call sites with their own message keep it.
    if (-not $Message) { $Message = "  Press Enter or Space to go on to the next screen..." }

    # FT-159 (ascii39): report anything PowerShell swallowed on the way here,
    # naming the screen, BEFORE the user is asked to move past it.
    try { Write-PendingErrors -Where ((Get-PSCallStack)[1].Command) } catch {}

    # FT-133 (ascii38): capture what the user is looking at BEFORE the prompt is
    # printed, so look-back restores the screen and not the screen-plus-prompt.
    Save-ScreenSnapshot

    # FT-146 (ascii39): OFFER BACK ONLY WHERE IT CAN ACTUALLY DELIVER. ascii38
    # offered it whenever a second snapshot existed, so the user was invited to
    # go back and then told "this is as far back as you can go" (field notes 4
    # and 6), or told the window had been resized AFTER accepting the offer
    # (note 4). Both are dead ends the offer itself created. The previous
    # snapshot must exist AND have been captured at the current buffer width,
    # or no offer is made. Honest degradation: no promise, no broken promise.
    $ggCanBack = (-not $NoBack) -and $script:GGSnapOK -and ($script:GGSnapshots.Count -gt 1)
    if ($ggCanBack) {
        try {
            $ggPrev = $script:GGSnapshots[$script:GGSnapshots.Count - 2]
            if ($ggPrev.Width -ne $Host.UI.RawUI.BufferSize.Width) { $ggCanBack = $false }
        } catch { $ggCanBack = $false }
    }

    Write-Host ""
    Write-Host $Message -ForegroundColor White
    if ($ggCanBack) {
        Write-Host "  Or press B to look back at the previous screen (nothing is undone)." -ForegroundColor DarkCyan
    }
    try {
        # FT-29 (2026-07-12): buffer flush REMOVED -- it was eating the first
        # keypress whenever the user pressed a key during screen pacing
        # (field-reported 5+ times as "had to press twice"). QuickEdit-off
        # and Ctrl+C handling remain as the FT-01 walk-away protections.
        while ($true) {
            # FT-46 (ascii28): the console host RESETS input mode on its own
            # reads, undoing TreatControlCAsInput -- re-assert before EVERY
            # read. ascii37 asserted once before the loop; a look-back or any
            # swallowed key then read again with the flag already cleared.
            try { [Console]::TreatControlCAsInput = $true } catch {}
            $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            # FT-69 (ascii29): Ctrl+C opens the exit confirmation
            if ($k.Character -eq [char]3) { Invoke-CtrlCExit; continue }
            # Accept: Enter (13), Space (32), Numpad Enter (13 via numpad)
            if ($k.VirtualKeyCode -in @(13, 32)) { break }
            $ggCh = ""
            try { $ggCh = $k.Character.ToString().ToUpper() } catch {}
            # FT-194 (ascii42): I was added to Read-ValidKey in ascii41 -- 56
            # sites, every one a QUESTION -- and not here, which is 71 sites
            # and nearly every PAGE. The exact mirror of the Back defect
            # analysed the same morning: Back works on pages and not
            # questions. Bill's finding 33: "your number 5-7 not active due
            # to 'I' not working" -- three checklist items were untestable.
            if ($ggCh -eq "I") {
                try { Write-Log -Message ("Info screen opened at: " + (Get-PSCallStack)[1].Command) -Status "KEY" } catch {}
                Show-CheckupInfo
                # Same rule as the B path below: a key that returns to its own
                # prompt must RE-RENDER, never append (FT-65).
                if (-not (Restore-ScreenSnapshot -Snapshot $script:GGSnapshots[$script:GGSnapshots.Count - 1])) {
                    Clear-Host
                    Write-Host ""
                    Write-Host "  (Returning to where you were. Nothing has changed.)" -ForegroundColor Yellow
                }
                Write-Host ""
                Write-Host $Message -ForegroundColor White
                continue
            }
            if ($ggCanBack -and $ggCh -eq "B") {
                try { Write-Log -Message ("Look-back opened at: " + (Get-PSCallStack)[1].Command) -Status "KEY" } catch {}
                Show-LookBack
                # FT-65 (ascii29): a key that loops back to its own prompt must
                # CLEAR and RE-RENDER -- appending turns auto-repeat into an
                # avalanche. Restoring the snapshot is that re-render, and it is
                # exact, so nothing the user was reading is lost.
                if (-not (Restore-ScreenSnapshot -Snapshot $script:GGSnapshots[$script:GGSnapshots.Count - 1])) {
                    Clear-Host
                    Write-Host ""
                    Write-Host "  (Returning -- this screen could not be redrawn exactly." -ForegroundColor Yellow
                    Write-Host "   Nothing has changed. Your log file has the full detail.)" -ForegroundColor Yellow
                }
                Write-Host ""
                Write-Host $Message -ForegroundColor White
                Write-Host "  Or press B to look back at the previous screen (nothing is undone)." -ForegroundColor DarkCyan
            }
            # Every other key is silently swallowed, exactly as before.
        }
        # FT-01 diagnostic breadcrumb: log every accepted continue key with
        # the screen (calling function) it came from.
        try { Write-Log -Message ("Continue accepted at: " + (Get-PSCallStack)[1].Command) -Status "KEY" } catch {}
        # FT-149 (ascii39): targeted POST-ACCEPT drain -- see Clear-PendingKeys.
        Clear-PendingKeys
    } catch {
        # Fallback if RawUI unavailable -- use Read-Host silently
        $null = Read-Host
    }
}

# -- READ-VALIDKEY: locked input -- only accepts specified valid keys --
# All other keypresses silently swallowed -- no accidental triggers
# Crash-protected with try/catch fallback
function Show-CheckupInfo {
    # FT-189 (ascii41): reachable by pressing I at ANY prompt.
    # Bill, 2026-08-17: "no senior including me is going to remember that.
    # Better you provide a button the user can select and read it right off
    # the screen, or a file the user can open in Notepad." Both, because
    # they serve different moments -- this screen is for the call in
    # progress, the .bat is for the call three days later.
    # Re-entrancy guard: this screen's own pause must not offer itself.
    if ($script:GGInInfo) { return }
    $script:GGInInfo = $true
    try {
        Clear-Host
        Write-Host ""
        Draw-Box -ScreenId "84" -Color White -Lines @(
            "  ABOUT THIS CHECKUP RUN                                     ",
            "---",
            "  If you telephone for help, you will be asked for these:    ",
            "                                                             ",
            ("  Build:       " + $BuildID),
            ("  Machine ID:  " + $global:MachineID),
            "                                                             ",
            "  You do not have to write them down or remember them.       ",
            "  They are saved in your log file, and you can open it       ",
            "  any time -- during this run or weeks from now:             ",
            "                                                             ",
            ("  Open this folder:  " + $GGUserDir),
            "  and double-click  Open-My-Log.bat  -- your log opens in    ",
            "  Notepad. The build and Machine ID are in the first lines.  ",
            "                                                             ",
            "  Nothing on your PC has been changed by this screen, and    ",
            "  nothing has been sent anywhere.                            "
        )
        Write-Host ""
        Pause-ForUser "  Press Enter or Space to go back to where you were..." -NoBack
    } finally {
        $script:GGInInfo = $false
    }
}

function Read-ValidKey {
    param(
        [string[]]$ValidKeys,
        [string]$Prompt = ""
    )
    if ($Prompt) { Write-Host "  $Prompt" -ForegroundColor White -NoNewline }
    # FT-159 (ascii39): surface anything swallowed before this decision point.
    try { Write-PendingErrors -Where ((Get-PSCallStack)[1].Command) } catch {}
    try {
        # FT-29 (2026-07-12): buffer flush removed -- was eating first keypress
        # FT-46 (ascii28): re-assert Ctrl+C-as-input before every read
        try { [Console]::TreatControlCAsInput = $true } catch {}
        do {
            $k = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            $ch = $k.Character.ToString().ToUpper()
            # FT-69 (ascii29): Ctrl+C opens the exit confirmation
            if ($k.Character -eq [char]3) { Invoke-CtrlCExit }
            # FT-189 (ascii41): I fetches the build and Machine ID from any
            # prompt. Free everywhere -- measured 2026-08-17, the keys in use
            # as valid keys anywhere in this file are B, E, N, Q, R, S and Y,
            # plus the checklist's P and A and the digits 1-3.
            # FT-173 (ascii41): an unrecognised key used to fall straight
            # through to the `while` and be discarded with NO output at all.
            # Nothing on screen distinguished "that key does nothing here"
            # from "the program has frozen", which is the fear this tool's
            # readers already have -- and it is why the missing Back option on
            # SCREEN-53 went unreported through two builds. Say so instead.
            # Deliberately NOT a blanket Back: some questions correctly have
            # none. Telling the user which keys work is the fix; inventing a
            # Back on "are you sure you want to close Checkup" is not.
            if ($ch -notin $ValidKeys) {
                if ($ch -eq "I") {
                    Show-CheckupInfo
                    if ($Prompt) { Write-Host "  $Prompt" -ForegroundColor White -NoNewline }
                } elseif ($k.Character -match '\S') {
                    Write-Host ""
                    Write-Host ("  That key does nothing here. Please press " + ($ValidKeys -join " or ") + ".") -ForegroundColor Yellow
                    Write-Host "  Press I at any time to see your build and Machine ID." -ForegroundColor DarkGray
                    Write-Host "  To leave Checkup at any time, press Ctrl+C." -ForegroundColor DarkGray
                    if ($Prompt) { Write-Host "  $Prompt" -ForegroundColor White -NoNewline }
                }
            }
            # FT-124 (ascii37): REMOVED -- Enter used to be silently mapped to
            # "Y" whenever "Y" was in ValidKeys. That is 32 Y/N prompts in
            # this file, i.e. "yes, change my system", triggered by the same
            # key that means "I have read this" at all 56 Pause-ForUser
            # screens. Field note 10 (2026-07-27): "somehow all selections
            # were removed while I was typing notes." A stray Enter was a
            # silent yes and nothing on screen ever said so.
            # It also broke the User-Facing Clarity Rule head-on: no prompt in
            # this file tells the user Enter means Yes, so the outcome of the
            # key could not be predicted before pressing it -- which is the
            # whole test that rule sets. Enter is now ignored here and the
            # user presses the letter.
            # Verified before removal: no prompt string anywhere in this file
            # instructs the user to press Enter at a Read-ValidKey prompt.
            # Pause-ForUser (Enter or Space to continue) is a separate reader
            # and is unchanged -- Enter still means "continue" on read-only
            # screens, which is the only thing it ever visibly claimed to do.
        } while ($ch -notin $ValidKeys)
        Write-Host $ch -ForegroundColor Cyan
        # FT-01 diagnostic breadcrumb
        try { Write-Log -Message ("Key '" + $ch + "' accepted at: " + (Get-PSCallStack)[1].Command) -Status "KEY" } catch {}
        # FT-149 (ascii39): targeted POST-ACCEPT drain -- see Clear-PendingKeys.
        Clear-PendingKeys
        return $ch
    } catch {
        # Fallback: use Read-Host if RawUI unavailable (e.g. ISE, redirected console)
        Write-Host ""
        do {
            $fallback = (Read-Host "  Enter choice ($($ValidKeys -join '/'))").ToUpper().Trim()
        } while ($fallback -notin $ValidKeys)
        return $fallback
    }
}

# -- READ-NAVKEY (FT-18, 2026-07-11): forward/back navigation --
# Returns "NEXT" for Enter/Space, "BACK" for B. All other keys ignored.
function Read-NavKey {
    param([string]$Prompt = "  Press Enter or Space to continue, or B to go back one screen: ")
    if ($Prompt) { Write-Host $Prompt -ForegroundColor White }
    try {
        # FT-29 (2026-07-12): buffer flush removed -- was eating first keypress
        # FT-46 (ascii28): re-assert Ctrl+C-as-input before every read
        try { [Console]::TreatControlCAsInput = $true } catch {}
        do {
            $k  = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            $vk = $k.VirtualKeyCode
            $ch = $k.Character.ToString().ToUpper()
            # FT-69 (ascii29): Ctrl+C opens the exit confirmation
            if ($k.Character -eq [char]3) { Invoke-CtrlCExit }
        } while (($vk -notin @(13, 32)) -and ($ch -ne "B"))
        $result = "NEXT"
        if ($ch -eq "B") { $result = "BACK" }
        try { Write-Log -Message ("Nav '" + $result + "' at: " + (Get-PSCallStack)[1].Command) -Status "KEY" } catch {}
        # FT-149 (ascii39): targeted POST-ACCEPT drain -- see Clear-PendingKeys.
        Clear-PendingKeys
        return $result
    } catch {
        Write-Host ""
        do {
            $fb = (Read-Host "  Type B then Enter to go back, or just press Enter to continue").ToUpper().Trim()
        } while ($fb -notin @("", "B"))
        if ($fb -eq "B") { return "BACK" }
        return "NEXT"
    }
}

# -- DISABLE-QUICKEDIT (FT-01 mitigation, 2026-07-11) --
# Console QuickEdit mode: a single CLICK inside the window enters text-
# selection mode, which PAUSES the program and swallows the next keypress.
# A user clicking back into the window after using Notepad hits this every
# time. Disabling it for this session removes a whole class of "the program
# froze/ended when I came back" reports.
function Disable-QuickEdit {
    # FT-148 (ascii39): THE COMPILED TYPE IS CACHED. This function used to call
    # Add-Type -MemberDefinition on EVERY call, which compiles the kernel32
    # P/Invoke wrapper from C# source each time. ascii38's FT-135 fix calls this
    # once per checklist item, so Get-AllStatuses compiled the same type 19-20
    # times in a row. Windows' own event log recorded it: dozens of 4104
    # "Creating Scriptblock text" plus 4103 CommandInvocation(Add-Type) inside a
    # single second at 13:42:32-33 on 2026-07-30. On an 8 GB Home machine -- the
    # exact class of machine this tool targets -- that is real time and real
    # memory spent recompiling something that never changes.
    # PREVENTS: 20 C# compilations per run, and 20 identical log lines.
    # COULD CAUSE: nothing observable. The type is immutable once built; the
    # handle and the mode are still read fresh on every call, so the actual
    # QuickEdit re-assert (the FT-135 protection) is unchanged in behaviour.
    try {
        if ($null -eq $script:GGK32) {
            $sig = @'
[DllImport("kernel32.dll", SetLastError=true)]
public static extern IntPtr GetStdHandle(int nStdHandle);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool GetConsoleMode(IntPtr hConsoleHandle, out uint lpMode);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool SetConsoleMode(IntPtr hConsoleHandle, uint dwMode);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool FlushConsoleInputBuffer(IntPtr hConsoleHandle);
'@
            $script:GGK32 = Add-Type -MemberDefinition $sig -Name "ConsoleMode" -Namespace "GatewayGuard" -PassThru
        }
        $handle = $script:GGK32::GetStdHandle(-10)   # STD_INPUT_HANDLE
        $mode = [uint32]0
        if ($script:GGK32::GetConsoleMode($handle, [ref]$mode)) {
            # Clear ENABLE_QUICK_EDIT_MODE (64) AND ENABLE_MOUSE_INPUT (16),
            # keep ENABLE_EXTENDED_FLAGS (128).
            # DECIMAL literals only -- hex literals near the sign bit caused the
            # ascii23 0x80000003 bug (PowerShell parses hex as SIGNED Int32).
            # 4294967231 = all bits set except bit 6 (QuickEdit).
            # 4294967279 = all bits set except bit 4 (ENABLE_MOUSE_INPUT).
            #
            # FT-171a (ascii40): THE SECOND MASK IS THE NEW ONE. ascii39 cleared
            # QuickEdit and left mouse input alone, so SANDY ran the whole
            # 2026-08-11 field session with mouse reporting ON -- measured
            # 2026-08-14 22:25, mode 0x01B7, QuickEdit already off and
            # ENABLE_MOUSE_INPUT still set. Every mouse move over the window was
            # landing in the same 256-record input buffer the tool reads answers
            # from. Checkup never reads a mouse event, so this discards records
            # nothing was going to use.
            # COULD CAUSE: nothing Checkup uses. sourced, SetConsoleMode -- the
            # flag decides whether mouse events are reported to the application
            # or discarded, and does not control wheel scrolling by the console
            # host. That last part is worth CONFIRMING IN THE FIELD (phase 3)
            # rather than believed, because the opposite claim was written down
            # here first and was wrong.
            $newMode = [uint32](($mode -band [uint32]4294967231 -band [uint32]4294967279) -bor [uint32]128)
            [void]$script:GGK32::SetConsoleMode($handle, $newMode)
            # FT-148: once per session, not once per item.
            if (-not $script:GGQuickEditLogged) {
                Write-Log -Message "QuickEdit AND mouse input reporting disabled for this session (FT-01, FT-171a) -- re-asserted silently from here on" -Status "OK"
                $script:GGQuickEditLogged = $true
            }
        }
    } catch {
        if (-not $script:GGQuickEditLogged) {
            Write-Log -Message "Could not disable QuickEdit mode (non-fatal): $_" -Status "WARN"
            $script:GGQuickEditLogged = $true
        }
    }
}

# -- REGISTER-CONSOLECTRL (FT-150 + FT-160, ascii39) --
# TWO FIELD BLOCKERS, ONE MECHANISM.
#
# FT-150: Ctrl+C pressed while the console is in Mark (text-selection) mode
#   KILLED the tool. The tool's own copy tip tells users to enter Mark mode to
#   copy text, so our guidance walked them into it (field note 21, 2026-07-30:
#   "turned on Mark but it would not copy hit cntl 'C' and pgm ended").
#   TreatControlCAsInput is re-asserted before every read, but entering Mark
#   mode resets the console mode underneath us -- the same host behaviour FT-46
#   is written about -- so Ctrl+C arrived as a control SIGNAL, not as input,
#   and nothing was listening for signals.
#
# FT-160: clicking the window's X killed the tool with no footer at all.
#   Confirmed cause of the 2026-07-30 13:52 crash: the PowerShell Operational
#   log has NO event of any kind at that moment. An unhandled exception would
#   have written a 4100. Nothing did. That is CTRL_CLOSE_EVENT, which bypasses
#   even the PowerShell.Exiting engine event that FT-113 relies on.
#
# WHY ONE MECHANISM FOR BOTH: they are the same thing -- console control
# signals this process never told Windows it wanted to handle. Class 6 rule 1
# asks whether the CAUSE can be removed instead of compensated for, and it can.
#
# WHY C# AND NOT A POWERSHELL SCRIPTBLOCK: Windows invokes the handler on a
# thread it injects into the process. That thread has no PowerShell runspace,
# so calling Write-Log or Save-Log from it is unreliable at best. The handler
# writes the footer itself with System.IO and touches nothing else.
#
# WHAT IT CANNOT DO: stop the close. Windows terminates the process after a
# short grace period no matter what the handler returns. The only promise made
# here is that the log survives it -- which is the whole of FT-160.
#
# COULD CAUSE: a duplicated footer if this and Save-Log both ran. Guarded by
# FooterDone, a single flag both sides set and check.
$script:GGCtrlHandlerOK = $false

function Register-ConsoleCtrl {
    param([string]$Path)
    try {
        if (-not ([System.Management.Automation.PSTypeName]'GatewayGuard.CtrlHandler').Type) {
            Add-Type -TypeDefinition @'
using System;
using System.IO;
using System.Runtime.InteropServices;

namespace GatewayGuard {
  public static class CtrlHandler {
    public delegate bool Routine(uint ctrlType);

    [DllImport("kernel32.dll", SetLastError = true)]
    private static extern bool SetConsoleCtrlHandler(Routine handler, bool add);

    // The delegate MUST be held in a static field. If it is collected, the
    // address Windows holds becomes invalid and the next signal faults the
    // process -- which would turn a fix for two crashes into a third.
    private static Routine _kept;

    public static string LogPath = "";
    public static bool FooterDone = false;
    public static int LastEvent = -1;
    private static int _ctrlCount = 0;

    private static bool Handle(uint t) {
      LastEvent = (int)t;
      // 0 = CTRL_C, 1 = CTRL_BREAK, 2 = CTRL_CLOSE, 5 = CTRL_LOGOFF, 6 = CTRL_SHUTDOWN
      if (t == 2 || t == 5 || t == 6) {
        WriteFooter(t);
      } else {
        // FT-150: swallow it and keep running. Returning true means handled,
        // so Windows does not terminate us. Logged the first few times only,
        // so a held Ctrl+C cannot flood the file.
        _ctrlCount++;
        if (_ctrlCount <= 3) {
          Append("[" + DateTime.Now.ToString("HH:mm:ss") +
                 "] [KEY] Ctrl+C arrived as a console signal (Mark mode) -- ignored, session continues. FT-150\r\n");
        }
      }
      return true;
    }

    private static void Append(string s) {
      try {
        if (!string.IsNullOrEmpty(LogPath)) { File.AppendAllText(LogPath, s); }
      } catch { }
    }

    private static void WriteFooter(uint t) {
      if (FooterDone) { return; }
      FooterDone = true;
      string why = (t == 2) ? "the window's X (close button) was clicked"
                 : (t == 5) ? "the user signed out of Windows"
                            : "Windows is shutting down";
      Append("\r\n[" + DateTime.Now.ToString("HH:mm:ss") +
             "] [EXIT] SESSION ENDED EARLY -- " + why +
             ". Nothing was left half-applied: Checkup applies one setting at a time." +
             "\r\n============================================================" +
             "\r\nLog complete. Keep this file -- it is your record of all changes made." +
             "\r\nIf you need support, email this file to: support@gatewayguard.co" +
             "\r\n============================================================\r\n");
    }

    public static bool Install() {
      _kept = new Routine(Handle);
      return SetConsoleCtrlHandler(_kept, true);
    }
  }
}
'@
        }
        [GatewayGuard.CtrlHandler]::LogPath = $Path
        $ggInstalled = [GatewayGuard.CtrlHandler]::Install()
        $script:GGCtrlHandlerOK = [bool]$ggInstalled
        if ($script:GGCtrlHandlerOK) {
            Write-Log -Message "Console control handler registered -- Ctrl+C in Mark mode can no longer end the session (FT-150), and closing the window still writes the log footer (FT-160)" -Status "OK"
        } else {
            Write-Log -Message "Console control handler could NOT be registered -- SetConsoleCtrlHandler returned false. Ctrl+C in Mark mode and the window X may still end the session without a footer." -Status "WARN"
        }
    } catch {
        $script:GGCtrlHandlerOK = $false
        Write-Log -Message "Console control handler unavailable in this host (non-fatal): $_" -Status "WARN"
    }
}

# -- CLEAR-PENDINGKEYS (FT-149, ascii39) --
# TARGETED POST-ACCEPT DRAIN. Called AFTER a key has been accepted, never
# before a read.
#
# WHAT IT FIXES: keys pressed while the tool is busy sit in the console input
# buffer and are then handed out one each to the next several readers. The
# 2026-07-30 log shows eight screens advancing in three seconds (11:27:39-42) --
# MB DETECTED, N, Continue, power settings, N, N, Continue, apps audit. The
# tester cannot have read them. Field note 7: "Space bar caused something to
# flash by perhaps more then one screen." A user can skip security decisions
# without ever seeing them, which makes this a safety defect and not an
# annoyance.
#
# WHY THIS IS NOT FT-29: FT-29 was a GLOBAL PRE-READ FLUSH that ran before
# every read and ate the legitimate first keypress of anyone who typed while a
# screen was still painting -- field-reported five or more times as "had to
# press twice". It stays removed. Draining AFTER an accept can only ever
# discard keys typed before the user saw the screen they are now on. This is
# the same pattern already proven at the HEADS UP screen (FT-65).
#
# COULD CAUSE: a user who deliberately double-taps Space to move two screens
# moves one. That is the intended trade and it is what note 7 asked for.
# BOUNDED: at most 256 keys and 200 ms, so a jammed key cannot spin here.
#
# FT-171b (ascii40): IT IS A FLUSH NOW, NOT A COUNTED READ. ascii39 read up to
# 256 events or 200 ms, whichever came first. The console input buffer holds
# 256 records. A 256-record buffer drained by a 256-read cap is a coin toss,
# and with mouse reporting on (FT-171a) the buffer could be full of records
# that were never keypresses at all. FlushConsoleInputBuffer empties it in one
# call, cannot hit a cap, and cannot spin.
#
# FT-171c (ascii40): AND IT NO LONGER REPORTS A CAP AS A COUNT. The old log
# line said "Discarded N keypress(es)" where N could only ever be 256, because
# 256 was the ceiling. That is FT-162 in miniature -- a number that cannot
# exceed its own limit is not a measurement, and printing it as one is how
# [GOOD] came to sit over a command that had returned an error. The flush path
# does not claim a count at all. The fallback path, used only if the P/Invoke
# is unavailable, says plainly when it stopped at its ceiling.
function Clear-PendingKeys {
    try {
        # Preferred path: one call, no cap, no count to misreport.
        if ($null -ne $script:GGK32) {
            $ggH = $script:GGK32::GetStdHandle(-10)   # STD_INPUT_HANDLE
            if ($script:GGK32::FlushConsoleInputBuffer($ggH)) {
                return
            }
        }
    } catch {}
    # Fallback only. Reached if Add-Type never ran, or the flush returned false.
    try {
        $ggDrained = 0
        $ggSw = [System.Diagnostics.Stopwatch]::StartNew()
        while ($Host.UI.RawUI.KeyAvailable -and $ggDrained -lt 256 -and $ggSw.ElapsedMilliseconds -lt 200) {
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            $ggDrained++
        }
        $ggSw.Stop()
        $ggHitCap = ($ggDrained -ge 256) -or ($ggSw.ElapsedMilliseconds -ge 200)
        if ($ggHitCap) {
            try { Write-Log -Message ("Input drain stopped at its cap -- events may remain. Stopped after " + $ggDrained + " read(s) / " + $ggSw.ElapsedMilliseconds + " ms (FT-171c)") -Status "WARN" } catch {}
        } elseif ($ggDrained -gt 0) {
            try { Write-Log -Message ("Discarded " + $ggDrained + " keypress(es) that were already queued before this screen appeared (FT-149)") -Status "KEY" } catch {}
        }
    } catch {}
}

# -- RESET-GGINPUTGATE (FT-171e, ascii40) --
# THE TIMESTAMP GATE, AND IT IS THE PART THAT CLOSES THE CLASS.
#
# Called at the end of Write-GGBox, so it runs once per screen, on every screen,
# automatically -- a screen added next build gets it without being told, in the
# same way FT-153's trailing blank line is produced centrally rather than at 58
# call sites.
#
# WHAT IT DOES: anything sitting in the input buffer at the instant the box
# finishes painting arrived BEFORE the user could have read the question. It is
# discarded, and the render tick is stamped so the log can say which screen the
# accepted key belongs to.
#
# WHY THIS IS NOT FT-29, AND THE DISTINCTION IS THE WHOLE DESIGN: FT-29 was a
# flush IMMEDIATELY BEFORE THE READ -- after the prompt had been printed and
# the user had had time to answer it. It ate the legitimate first keypress of
# anyone who typed promptly, field-reported five or more times as "had to press
# twice", and it stays removed. This flush happens BEFORE THE PROMPT IS
# PRINTED. The only window it discards from is the paint itself. A key typed in
# answer to a question the user has actually seen cannot be inside that window.
#
# COULD CAUSE: a user who has learned the screens by heart and types the answer
# during the paint loses that keystroke and presses again. That is the intended
# trade, and it is the same trade FT-65 and FT-149 already make after an accept.
#
# IT ALSO RE-ASSERTS THE CONSOLE FLAGS, AND THAT PART FIXES A SEPARATE DEFECT
# FOUND WHILE READING FOR FT-171 (ascii40). measured on the ascii39 source:
# Disable-QuickEdit had exactly TWO call sites, both inside Get-AllStatuses --
# which does not run until the user is most of the way through the session. So
# every screen before it, INCLUDING the personal-computer question and the
# resume re-check, ran with QuickEdit and mouse reporting in whatever state the
# console started in. SCREEN-02 told the user "mouse highlighting and
# right-click copy are switched OFF in this window" several screens BEFORE any
# code had switched them off. The screen was telling the truth about the
# intent and not about the machine.
# Asserting here means the flags are set before EVERY screen, which is what
# CLAUDE.md's standing rule has asked for all along ("console flags must be
# re-asserted before every read, not once at startup"). It is also what makes
# the flush above work at all, since Disable-QuickEdit is what builds the
# cached P/Invoke type the flush calls through.
function Reset-GGInputGate {
    try {
        Disable-QuickEdit
        $script:GGScreenRenderTicks = [System.Diagnostics.Stopwatch]::GetTimestamp()
        Clear-PendingKeys
    } catch {}
}

# -- WRITE-PENDINGERRORS (FT-159, ascii39) --
# CLASS 1: A REAL ERROR THE TOOL HID. On 2026-07-30 at 13:42:57 -- precisely
# the HEADS UP to review handoff -- PowerShell recorded a 4100 Warning, "Error
# Message = System error." Nothing about it reached the Checkup log. The tool
# generated a real error and carried on silently.
#
# THIS DOES NOT GUESS AT THE CALL THAT THREW. The evidence available does not
# identify it, and picking a plausible candidate and calling it fixed is
# exactly the FT-116 proxy-fix mistake this project has already paid for once.
# Instead the CLASS is closed: PowerShell keeps every non-terminating error in
# $Error whether or not anything reported it, so at each prompt anything new
# since the last prompt is written to the log with the screen it came from.
# The next run tells us what this one swallowed -- and so does every run after.
#
# PREVENTS: a silent failure being invisible in the one artifact we get back
# from the field.
# COULD CAUSE: log noise from harmless errors inside -EA SilentlyContinue
# probes, which this file uses heavily. Accepted deliberately: an ignorable
# line in the log is recoverable, an invisible failure is not. Bounded to 5 per
# prompt so one repeating error cannot fill the file.
$script:GGErrSeen = 0

function Write-PendingErrors {
    param([string]$Where = "")
    try {
        if ($null -eq $Error) { return }
        $ggNow = @($Error).Count
        if ($ggNow -le $script:GGErrSeen) { $script:GGErrSeen = $ggNow; return }
        $ggNew = $ggNow - $script:GGErrSeen
        $script:GGErrSeen = $ggNow
        if ($ggNew -gt 5) { $ggNew = 5 }
        for ($ggI = $ggNew - 1; $ggI -ge 0; $ggI--) {
            try {
                $ggE   = $Error[$ggI]
                $ggMsg = [string]$ggE
                $ggAt  = ""
                try { $ggAt = [string]$ggE.InvocationInfo.PositionMessage } catch {}
                if ($ggAt) { $ggAt = ($ggAt -split "\r?\n")[0].Trim() }
                if ($ggMsg.Length -gt 300) { $ggMsg = $ggMsg.Substring(0, 300) + "..." }
                # FT-188 (ascii41): three of the four lines this produced on a
                # clean SANDY run were absent policy keys -- HKLM\...\Edge and
                # HKLM\...\Dsh -- which are SUPPOSED to be absent on a home PC
                # and which the caller already handles by reporting Unknown.
                # Nothing was wrong and the user saw nothing wrong, but the log
                # said ERROR four times. That log is the file we tell the
                # customer to email support, so a clean run must not read like
                # a broken one. Expected-absent keys log INFO; all else ERROR.
                $ggBenign = (($ggMsg -match 'because it does not exist') -or
                             ($ggMsg -match 'Cannot find path'))
                $ggStatus = if ($ggBenign) { "INFO" } else { "ERROR" }
                $ggLabel  = if ($ggBenign) { "NOT SET (expected)" } else { "SILENT ERROR" }
                # FT-245 (ascii44): $Where is where the USER was, not where the
                # fault was -- every line read "SILENT ERROR at
                # Show-ScopeDisclaimer" and sent readers to the wrong function.
                # The real location is the position message. Wording only:
                # severity is NOT reclassified, because turning an access
                # denial into INFO is how a real failure becomes invisible.
                $ggFault = if ($ggAt) { $ggAt } else { "location not recorded" }
                Write-Log -Message ($ggLabel + " -- fault at: " + $ggFault + " -- user was at: " + $Where + " -- " + $ggMsg) -Status $ggStatus
            } catch {}
        }
    } catch {}
}

# -- GET-MACHINEIDENTITY (FT-19, 2026-07-11) --
# Identifies the machine make/model and derives a short unique ID from the
# hardware UUID. The ID is a truncated SHA-256 HASH -- it ties only to this
# specific PC but never exposes the raw hardware UUID/serial in a log the
# user might share. Same fingerprint concept planned for licensing.
function Get-MachineIdentity {
    $global:MachineMake  = ""
    $global:MachineModel = ""
    $global:MachineID    = "UNKNOWN"
    try {
        $cs = Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop
        $global:MachineMake  = ("" + $cs.Manufacturer).Trim()
        $global:MachineModel = ("" + $cs.Model).Trim()
    } catch {}
    try {
        $uuid = (Get-CimInstance -ClassName Win32_ComputerSystemProduct -ErrorAction Stop).UUID
        if ($uuid) {
            $sha   = [System.Security.Cryptography.SHA256]::Create()
            $bytes = $sha.ComputeHash([System.Text.Encoding]::UTF8.GetBytes("GatewayGuard|" + $uuid))
            $hex   = -join ($bytes | ForEach-Object { $_.ToString("X2") })
            $global:MachineID = $hex.Substring(0, 12)
        }
    } catch {}
}

# ============================================================
# HELPER: CONFIRM EXIT
# ============================================================
function Confirm-Exit {
    param([string]$Reason = "")
    Write-Host ""
    Write-Host "  Are you sure you want to exit? No changes will be saved." -ForegroundColor Yellow
    if ($Reason) { Write-Host "  $Reason" -ForegroundColor Gray }
    $c = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Exit now? (Y/N): "
    if ($c.ToUpper() -eq "Y") {
        Write-Log -Message "User confirmed exit" -Status "EXIT"
        Disable-SleepPrevention
        Restore-ScreenSaver
        Save-Log
        exit
    }
}

# FT-69 (ascii29): Ctrl+C -> exit confirmation. FT-24 made Ctrl+C an
# ordinary input key so it could no longer KILL the tool mid-session;
# field feedback then flipped to 'Ctrl+C does nothing'. Middle ground:
# Ctrl+C now opens Confirm-Exit, which asks before exiting -- so an
# accidental copy attempt still cannot end the session. The guard flag
# prevents recursion (Ctrl+C pressed AT the exit prompt is ignored).
function Invoke-CtrlCExit {
    if ($script:GGInConfirmExit) { return }
    $script:GGInConfirmExit = $true
    try { Confirm-Exit "You pressed Ctrl+C." } finally { $script:GGInConfirmExit = $false }
}

# ============================================================
# SCREEN 0: FONT INSTRUCTIONS (VERY FIRST SCREEN)
# ============================================================
function Show-FontInstructions {
    Clear-Host
    Write-Host ""

    # -- ADMIN CHECK: If not running as admin, show clear instructions --
    if (-not $global:IsAdmin) {
        Draw-Box -ScreenId "01" -Color White -Lines @(
            "  IMPORTANT -- HOW TO RUN GATEWAYGUARD CORRECTLY              ",
            "---",
            "  Checkup must be run as Administrator to work properly.      ",
            "                                                               ",
            "  HOW TO RUN AS ADMINISTRATOR:                                ",
            "  1. Close this window                                        ",
            "  2. Find the Run-GatewayGuard.bat file in your folder        ",
            "  3. Click it ONCE to select it, then RIGHT-CLICK on it       ",
            "     (right-clicking always shows the administrator option)    ",
            "  4. Select 'Run as administrator'                             ",
            "  5. Click YES when Windows asks 'Do you want to allow        ",
            "     this app to make changes to your device?'                ",
            "                                                               ",
            "  ABOUT THE 'UNKNOWN PUBLISHER' WARNING:                      ",
            "  Windows may show a blue or orange warning saying             ",
            "  'Windows protected your PC' or 'Unknown publisher'.         ",
            "  This is normal for downloaded .bat files.                   ",
            "  Click 'More info' then 'Run anyway' to continue.            ",
            "  Checkup's full source code is visible -- open the           ",
            "  .ps1 file in Notepad to see exactly what it does.           "
        )
        Write-Host ""
        # FT-25 (2026-07-11): limited mode REMOVED -- running without admin
        # meant settings silently could not apply. The tool now closes so
        # the user relaunches it correctly.
        Pause-ForUser "  Press Enter or Space to CLOSE this window, then re-run as Administrator..."
        Write-Log -Message "Not running as Administrator -- instructions shown, tool closed" -Status "EXIT"
        Disable-SleepPrevention; Save-Log; exit
    }

    # -- INTRO SEQUENCE (FT-04 order fix + FT-18 Back navigation, 2026-07-11) --
    # Order: 1 Welcome/maximize  2 Scroll  3 Font  4 Window setup  5 Overview.
    # B goes back one screen (except on the first screen).
    $introScreens = @(
        {   # Screen 1 of 5: Welcome + maximize (FT-10 final wording)
            # FT-172 (ascii41): this screen and the two below never reached
            # Draw-Box, so the counter had never seen them and EVERY screen
            # after them read low by a constant. That is the arithmetic Bill
            # reported five separate times in ascii39 -- "Scr 3 -> 4 of 6",
            # "Scr 4 -> 5 of 6", "Scr 5 = 5 of 6" -- one defect, not five.
            # They now carry IDs and read the same table as everything else.
            Write-Host ("  Welcome to GatewayGuard Checkup.  (Screen " + (Get-ScreenNumber -ScreenId "85") + ")") -ForegroundColor Cyan
            Write-Host ""
            Write-Host "  For the best experience, please maximize this window now" -ForegroundColor White
            Write-Host "  by clicking the square button in the upper right corner" -ForegroundColor White
            Write-Host "  of this window, or hold the Windows key and press the" -ForegroundColor White
            Write-Host "  Up arrow." -ForegroundColor White
        },
        {   # Screen 2 of 5: Scroll instruction (FT-05/06 final wording)
            Write-Host ("  SCROLLING  (Screen " + (Get-ScreenNumber -ScreenId "86") + ")") -ForegroundColor Cyan
            Write-Host ""
            Write-Host "  Now scroll to the TOP and BOTTOM of this window AND" -ForegroundColor White
            Write-Host "  FOLLOWING WINDOWS -- use your mouse wheel, or click the" -ForegroundColor White
            Write-Host "  little arrows on the right side of the window -- so you" -ForegroundColor White
            Write-Host "  don't miss anything." -ForegroundColor White
        },
        {   # Screen 3 of 5: Font setup (FT-04: now AFTER the welcome screens)
            Write-Host "  +==============================================================+" -ForegroundColor Yellow
            Write-Host "  |  SET YOUR CONSOLE FONT (takes 30 seconds)                    |" -ForegroundColor Yellow
            Write-Host "  +==============================================================+" -ForegroundColor Yellow
            Write-Host ("  (Screen " + (Get-ScreenNumber -ScreenId "87") + ")") -ForegroundColor DarkGray
            Write-Host ""
            Write-Host ("  Running: " + (Split-Path -Leaf $PSCommandPath)) -ForegroundColor DarkCyan
            Write-Host "  Version: GatewayGuard Checkup v$ScriptVersion  Build: $BuildID" -ForegroundColor DarkCyan
            Write-Host ("  This PC: " + $global:MachineMake + " " + $global:MachineModel + "  |  Machine ID: " + $global:MachineID) -ForegroundColor DarkCyan
            Write-Host ""
            Write-Host "  Checkup uses box-drawing characters. For best display:" -ForegroundColor White
            Write-Host ""
            Write-Host "  1. Right-click the title bar of this window" -ForegroundColor Cyan
            Write-Host "  2. Click Properties (or Defaults)" -ForegroundColor Cyan
            Write-Host "  3. Click the Font tab" -ForegroundColor Cyan
            Write-Host "  4. Set Font to: Consolas  or  Lucida Console" -ForegroundColor Cyan
            Write-Host "  5. Set Size to: 14  (or larger if text is hard to read)" -ForegroundColor Cyan
            Write-Host "  6. Click OK" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "  WHY: Without the right font, boxes may show as question marks" -ForegroundColor Gray
            Write-Host "  or garbled characters. Checkup works either way -- this just" -ForegroundColor Gray
            Write-Host "  makes it easier to read." -ForegroundColor Gray
            Write-Host ""
            Write-Host "  If the boxes below look correct, you are all set:" -ForegroundColor White
            Write-Host ""
            Draw-Box -ScreenId "28" -Color White -Lines @(
                "  FONT CHECK: If this box has clean lines, you are ready.   ",
                "  +--+  Good: straight lines and corners                    ",
                "  |  |  Good: text is a comfortable reading size            "
            )
        },
        {   # Screen 4 of 6: Window setup, part 1 (FT-153: split -- see below)
            # FT-153 (ascii39): SPLIT INTO TWO SCREENS. Field note 3
            # (2026-07-30): "ext screen 4 of 5 - to lomg separate into 2
            # pages." It carried six numbered instructions in one box, well
            # past the 26-line rule. Items 1-3 (the window itself) are here;
            # items 4-6 (keys, going back, copying) are the next screen.
            Draw-Box -ScreenId "29" -Color White -Lines @(
        "  BEFORE YOU START -- YOUR WINDOW                                      ",
                "---",
                "  1. IF YOU HAVEN'T MAXIMIZED THIS WINDOW YET, DO IT NOW!      ",
                "     Click the small SQUARE icon at the TOP RIGHT of this      ",
                "     window (next to the X close button) to go full screen.    ",
                "     OR press Windows key + Up arrow.                          ",
                "                                                               ",
                "  2. SCROLLING: Some screens are longer than your window.      ",
                "     To scroll UP or DOWN use your mouse scroll wheel.         ",
                "     Scroll arrows also appear at the TOP RIGHT and BOTTOM     ",
                "     RIGHT corners of the window. If the bottom arrow          ",
                "     disappears, move your mouse to the bottom right corner    ",
                "     and it will reappear.                                     ",
                "     PAGE UP / PAGE DOWN keys also scroll quickly.             ",
                "                                                               ",
                "  3. ALWAYS scroll to the TOP and BOTTOM of every screen       ",
                "     before pressing Enter or Space to continue -- there may   ",
                "     be important information beyond what you can first see.   "
            )
        },
        {   # Screen 5 of 6: Window setup, part 2 (FT-153 split)
            Draw-Box -ScreenId "78" -Color White -Lines @(
        "  BEFORE YOU START -- YOUR KEYBOARD                                    ",
                "---",
                "  4. KEYBOARD: Use ENTER or SPACE BAR to continue on screens   ",
                "     that just need you to read and move on. When asked for    ",
                "     a choice (Y/N/B etc) press that letter key only --        ",
                "     no need to press Enter afterwards.                        ",
                "                                                               ",
                "  5. GOING BACK: On these setup screens, press B to go back    ",
                "     one screen if you missed something. Later on, Checkup     ",
                "     offers B whenever it can show you the previous screen     ",
                "     exactly as it was. If B is not offered, that screen       ",
                "     cannot be redrawn -- but everything is in your log file.  ",
                "                                                               ",
                "  6. COPYING: You never need to copy anything off these        ",
                "     screens -- everything is saved automatically to your      ",
                "     log file in your GatewayGuard folder. Press I to see it.  ",
                "                                                               ",
                "  7. IF YOU CLICK THE X BY ACCIDENT: Checkup closes, but it    ",
                "     finishes writing your log first, and nothing is left      ",
                "     half-changed. Just run it again."
            )
        },
        {   # Screen 6 of 6: What happens next
            Draw-Box -ScreenId "30" -Color White -Lines @(
        "  WHAT HAPPENS NEXT -- PLEASE READ                                  ",
                "---",
                "  Checkup runs a series of quick checks before reaching     ",
                "  the main security settings. Some screens appear briefly   ",
                "  and move on automatically -- this is normal.              ",
                "                                                             ",
                "  PRE-FLIGHT CHECKS (you will see these in order):          ",
                "  1. Personal computer confirmation                          ",
                "  2. Domain / corporate network check                       ",
                "  3. Administrator access check                             ",
                "  4. Windows edition detection (Home vs Pro)                ",
                "  5. RAM check                                              ",
                "  6. First-run vs returning user check                      ",
                "  7. Security scan confirmation (Defender + Malwarebytes)   ",
                "  8. Antivirus detection and status                         ",
                "  9. Battery / power status check                           ",
                " 10. Power settings (optional)                              ",
                " 11. Apps audit (installed apps review)                     ",
                "                                                             ",
                "  Screens that require your input will PAUSE and wait.      ",
                "  Quick status confirmations (green OK messages) will show  ",
                "  briefly and move on -- nothing is skipped silently.       ",
                "                                                             ",
                "  After all checks pass, you reach the main security        ",
                "  settings checklist where YOU control what gets changed.   "
            )
        }
    )

    $screenIdx = 0
    while ($screenIdx -lt $introScreens.Count) {
        Clear-Host
        Write-Host ""
        & $introScreens[$screenIdx]
        Write-Host ""
        if ($screenIdx -eq 0) {
            Pause-ForUser "  Press Enter or Space to continue..."
            $screenIdx++
        } else {
            $nav = Read-NavKey
            if ($nav -eq "BACK") { $screenIdx-- } else { $screenIdx++ }
        }
    }
}

# ============================================================
# STEP 1: COMPANY COMPUTER WARNING
# ============================================================
function Test-PersonalComputer {
    Clear-Host
    Write-Host ""
    Show-StepHeader -Key "PersonalPC" -Section "Getting Ready"
    Draw-Box -ScreenId "05" -Color White -Lines @(
        "  !  IMPORTANT -- READ BEFORE CONTINUING                    ",
        "---",
        "  THIS TOOL IS FOR PERSONAL COMPUTERS ONLY.                 ",
        "                                                             ",
        "  DO NOT run Checkup on:                                     ",
        "  * A computer owned or managed by your employer             ",
        "  * A school or university-managed computer                  ",
        "  * Any computer you do not personally own                   ",
        "  * Computers connected to a corporate network or domain     ",
        "                                                             ",
        "  WHY: This tool modifies Windows security settings at the   ",
        "  system level. On a company PC, these changes may:          ",
        "  * Violate your employer's IT policy                        ",
        "  * Break access to company systems and VPN                  ",
        "  * Trigger security alerts on corporate networks            ",
        "  * Put you in violation of your employment agreement        ",
        "                                                             ",
        "  NOTE: Having a work email added to your personal PC does   ",
        "  NOT make it a company computer -- only if your employer's  ",
        "  IT department manages the PC itself.                       ",
        "                                                             ",
        "  By continuing, you confirm this is YOUR personal PC        ",
        "  and you have the right to modify its settings.             "
    )
    Write-Host ""
    do {
        $confirm = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Is this YOUR personal computer? (Y = Yes / N = Exit): "
        if ($confirm.ToUpper() -eq "N") {
            Write-Host ""
            Write-Host "  Exiting. No changes made." -ForegroundColor Yellow
            Write-Host "  To secure a company PC, contact your IT department." -ForegroundColor Gray
            Write-Host ""
            Write-Log -Message "User confirmed not personal PC -- exit" -Status "EXIT"
            Save-Log
            exit
        }
    } while ($confirm.ToUpper() -ne "Y")
    # FT-42 (ascii28): the next checks run silently for a second or two --
    # without immediate feedback, users pressed Enter again thinking the Y
    # hadn't registered, and that stray Enter then skipped the next screen.
    Write-Host ""
    Write-Host "  Confirmed -- checking this PC..." -ForegroundColor Green
    Write-Log -Message "Personal computer confirmed by user" -Status "CONFIRM"
}

# ============================================================
# STEP 2: DOMAIN CHECK
# ============================================================
function Test-DomainJoin {
    try {
        $cs = Get-WmiObject Win32_ComputerSystem -ErrorAction Stop
        if ($cs.PartOfDomain) {
            $domainName = $cs.Domain
            Clear-Host
            Write-Host ""
            Draw-Box -ScreenId "32" -Color White -Lines @(
                "  !  THIS PC APPEARS TO BE DOMAIN-JOINED                    ",
                "---",
                "  Domain detected: $domainName",
                "                                                             ",
                "  This usually means the PC is managed by an employer,      ",
                "  school, or organization. This tool should NOT be run       ",
                "  on managed or corporate computers.                         ",
                "                                                             ",
                "  If you set up a home lab domain yourself and this IS       ",
                "  your personal PC, you may continue -- but some settings    ",
                "  may conflict with your home domain configuration.          ",
                "                                                             ",
                "  If this PC was provided by an employer or school,          ",
                "  exit now and contact your IT department.                   "
            )
            Write-Host ""
            do {
                $confirm = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue? (Y = This is my personal PC / N = Exit): "
                if ($confirm.ToUpper() -eq "N") {
                    Write-Host ""
                    Write-Host "  Exiting. No changes made." -ForegroundColor Yellow
                    Save-Log; exit
                }
            } while ($confirm.ToUpper() -ne "Y")
            Write-Log -Message "Domain-joined PC ($domainName) -- user confirmed personal use" -Status "WARN"
        } else {
            Write-Log -Message "Domain check passed -- not domain joined" -Status "OK"
        }
    } catch {
        Write-Log -Message "Domain check error: $_" -Status "WARN"
    }
}

# ============================================================
# STEP 3: ADMIN CHECK
# ============================================================
function Test-AdminAccess {
    $global:IsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")

    if (-not $global:IsAdmin) {
        Clear-Host
        Write-Host ""
        Draw-Box -ScreenId "33" -Color White -Lines @(
            "  !  ADMINISTRATOR ACCESS REQUIRED                          ",
            "---",
            "  This tool is running as a STANDARD USER.                  ",
            "  Most security settings require Administrator access.       ",
            "                                                             ",
            "  TO RUN WITH FULL ACCESS:                                   ",
            "  * Close this window                                        ",
            "  * Right-click the tool -> Run as Administrator             ",
            "  * Enter admin password if prompted                         ",
            "                                                             ",
            "  WHAT YOU CAN STILL DO WITHOUT ADMIN:                      ",
            "  * Run Defender and Malwarebytes scans                      ",
            "  * Check Windows Update status                              ",
            "  * Review installed apps list                               ",
            "  * Turn off Advertising ID (your account only)              ",
            "                                                             ",
            "  LIMITED MODE will now run -- admin-only settings           ",
            "  will be skipped and flagged in the log.                    "
        )
        Write-Host ""
        do {
            $cont = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue in Limited Mode? (Y = Continue / N = Exit): "
            if ($cont.ToUpper() -eq "N") {
                Write-Host "  Close this window and right-click -> Run as Administrator." -ForegroundColor Yellow
                Save-Log; exit
            }
        } while ($cont.ToUpper() -ne "Y")
        Write-Log -Message "Running in Limited Mode (no admin access)" -Status "WARN"
    } else {
        Write-Host ""
        Write-Host "  OK  Administrator access confirmed -- full access available." -ForegroundColor Green
        Write-Log -Message "Administrator access confirmed" -Status "OK"
        Pause-ForUser
    }
}

# ============================================================
# STEP 4: WINDOWS EDITION DETECTION
# NOTE: Uses WMI ONLY -- Get-WindowsEdition -Online causes infinite loop
# ============================================================
function Get-WinEdition {
    try {
        # Use registry -- fastest and no loop risk
        $regEdition = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -EA Stop).EditionID
        $global:WinEdition = if ($regEdition) { $regEdition } else { "Unknown" }
    } catch {
        try {
            $caption = (Get-WmiObject Win32_OperatingSystem -EA Stop).Caption
            $global:WinEdition = if ($caption -match "Pro") { "Professional" }
                                 elseif ($caption -match "Home") { "Home" }
                                 elseif ($caption -match "Enterprise") { "Enterprise" }
                                 elseif ($caption -match "Education") { "Education" }
                                 else { "Unknown" }
        } catch {
            $global:WinEdition = "Unknown"
        }
    }
    # Build friendly edition label: keep EditionID (Core, Professional etc) + add Windows 11 label
    # BUGFIX ascii23 (2026-07-10): missing 'break' meant "Professional" matched
    # BOTH *Professional* and *Pro* cases -- switch-as-expression returned both
    # results as an array, which then printed as duplicated text when
    # interpolated into a string ("Professional -- Windows 11 Pro Professional
    # -- Windows 11 Pro"). Added explicit break to each case.
    $global:WinEditionFriendly = switch -Wildcard ($global:WinEdition) {
        "*Core*"           { "$global:WinEdition -- Windows 11 Home"; break }
        "*Home*"           { "$global:WinEdition -- Windows 11 Home"; break }
        "*Professional*"   { "$global:WinEdition -- Windows 11 Pro"; break }
        "*Pro*"            { "$global:WinEdition -- Windows 11 Pro"; break }
        "*Enterprise*"     { "$global:WinEdition -- Windows 11 Enterprise"; break }
        "*Education*"      { "$global:WinEdition -- Windows 11 Education"; break }
        default            { $global:WinEdition }
    }

    Write-Log -Message "Windows Edition: $global:WinEditionFriendly" -Status "INFO"

    $isHome = $global:WinEdition -notmatch "Pro|Enterprise|Education|Business"
    if ($isHome) {
        Clear-Host
        Write-Host ""
        Draw-Box -ScreenId "34" -Color White -Lines @(
            "  WINDOWS EDITION DETECTED                                          ",
            "---",
            "  Edition: $global:WinEditionFriendly                              ",
            "                                                                    ",
            "  Remote Desktop hosting is not available on Home Edition.          ",
            "  BitLocker uses Device Encryption on Home -- handled               ",
            "  automatically by Checkup.                                         "
        )
        Write-Host ""
        Write-Log -Message "Home edition -- Remote Desktop and Group Policy unavailable" -Status "INFO"
        Pause-ForUser
    } else {
        Write-Host ""
        Write-Host "  OK  Windows Edition: $global:WinEditionFriendly" -ForegroundColor Green
        Write-Host ""
        # Sleep removed (ascii32): per no-Sleep-in-Show rule; user reads the message, next screen follows
    }
}

# ============================================================
# STEP 5: RAM CHECK
# ============================================================
function Get-RAMStatus {
    try {
        $ramBytes = (Get-WmiObject Win32_ComputerSystem).TotalPhysicalMemory
        $global:RAMGB = [math]::Round($ramBytes / 1GB)
        if ($global:RAMGB -le 8) {
            Clear-Host
            Write-Host ""
            Draw-Box -ScreenId "35" -Color White -Lines @(
                "  YOUR PC -- RAM: $($global:RAMGB) GB",
                "---",
                "  All security settings in Checkup will run fine.            ",
                "                                                              ",
                "  EXCEPTION -- BITLOCKER ENCRYPTION:                         ",
                "  BitLocker can take several hours on this PC.               ",
                "  Schedule it to run overnight -- select option 2            ",
                "  (Enable overnight) when you reach the BitLocker screen.    ",
                "  Plug into AC power and set Sleep to Never before leaving.  "
            )
            Write-Host ""
            Write-Log -Message "RAM: $($global:RAMGB) GB (minimal)" -Status "WARN"
            Pause-ForUser
        } elseif ($global:RAMGB -le 16) {
            Write-Host ""
            Write-Host "  Your PC has $($global:RAMGB) GB RAM -- most operations will run smoothly." -ForegroundColor Cyan
            Write-Host "  Tip: Schedule scans during idle or overnight times for best results." -ForegroundColor Gray
            Write-Host ""
            # Sleep removed (ascii32): per no-Sleep-in-Show rule
            Write-Log -Message "RAM: $($global:RAMGB) GB (moderate)" -Status "INFO"
        } else {
            Write-Log -Message "RAM: $($global:RAMGB) GB (ample)" -Status "INFO"
        }
    } catch {
        $global:RAMGB = 0
        Write-Log -Message "Could not determine RAM: $_" -Status "WARN"
    }
}

# ============================================================
# STEP 6: FIRST RUN CHECK
# ============================================================
function Test-FirstRun {
    $global:IsFirstRun = -not (Test-Path $FirstRunFlag)
}

function Set-FirstRunComplete {
    $dir = Split-Path $FirstRunFlag
    if (-not (Test-Path $dir)) { New-Item -Path $dir -ItemType Directory -Force | Out-Null }
    "$(Get-Date)" | Out-File -FilePath $FirstRunFlag -Encoding UTF8
}

# ============================================================
# STATE / RESUME SYSTEM (UX-05, UX-06)
# Survives the offline-scan reboot. Ordered checkpoints -- when
# resuming, we skip everything at or before the saved checkpoint
# and jump straight back into the flow at the right spot.
# ============================================================
$global:CheckpointOrder = @(
    "Baseline",
    "Briefing",
    "PreScanPrep",
    "OfflineScanPending",
    "OfflineScanDone",
    "Malwarebytes",
    "DefenderAV",
    "PowerSettings",
    "AppsAudit"
)

function Save-Checkpoint {
    param([Parameter(Mandatory)][string]$Checkpoint)
    if (-not (Test-Path $StateDir)) { New-Item -Path $StateDir -ItemType Directory -Force | Out-Null }
    # FT-127 (ascii37): LINE 1 IS STILL THE CHECKPOINT NAME AND NOTHING ELSE.
    # That contract is unchanged, so a state file written by ascii36 or
    # earlier reads back identically here. Line 2, when present, carries the
    # user's password-manager answer so a resume does not ask for it a third
    # time (field note 11; open since ascii32 as FT-107). Nothing about the
    # previous session's ENVIRONMENT is persisted -- Class 5 rule 1 stands.
    $ggState = @($Checkpoint)
    if ($null -ne $global:HasPasswordManager) {
        $ggState += ("PM=" + $(if ($global:HasPasswordManager) { "Y" } else { "N" }))
        # FT-191 (ascii41): the OneDrive decline rides the SAME state file as
        # the password-manager answer rather than inventing a second store
        # for one boolean. Same shape, same restore path, one thing to break.
        if ($global:GGOneDriveDeclined) { $ggState += "OD=N" }
    }
    ($ggState -join "`r`n") | Out-File -FilePath $StateFilePath -Encoding UTF8 -Force
    Write-Log -Message "Checkpoint saved: $Checkpoint" -Status "STATE"
}

function Get-SavedCheckpoint {
    # FT-127 (ascii37): the state file may now carry a second line (PM=Y/N),
    # so read the FIRST line only. A one-line file from an earlier build
    # returns exactly what it always did.
    if (Test-Path $StateFilePath) {
        try {
            $ggFirst = @(Get-Content -Path $StateFilePath -EA Stop)
            if ($ggFirst.Count -gt 0) { return ([string]$ggFirst[0]).Trim() }
            return $null
        } catch { return $null }
    }
    return $null
}

function Restore-SessionAnswers {
    # FT-127 (ascii37): restore the answers the user already gave, so a resume
    # does not re-interrogate them. Currently just the password-manager
    # answer. Silent failure is correct here: if nothing is stored, the
    # question is simply asked normally, which is the pre-ascii37 behaviour.
    try {
        $ggAll = @(Get-Content -Path $StateFilePath -EA Stop)
        foreach ($ggLine in $ggAll) {
            if ($ggLine -match '^\s*OD=N\s*$') {
                $global:GGOneDriveDeclined = $true
                Write-Log -Message "Restored saved answer: OneDrive declined" -Status "STATE"
            }
            if ($ggLine -match '^\s*PM=([YN])\s*$') {
                $global:HasPasswordManager = ($Matches[1] -eq "Y")
                Write-Log -Message "Restored saved answer: password manager = $($global:HasPasswordManager)" -Status "STATE"
            }
        }
    } catch {}
}

function Clear-Checkpoint {
    if (Test-Path $StateFilePath) { Remove-Item -Path $StateFilePath -Force -EA SilentlyContinue }
}

function Test-CheckpointReached {
    # Returns $true if $global:ResumeFrom checkpoint is at or before $Checkpoint
    # in CheckpointOrder -- meaning this step should be SKIPPED because it was
    # already completed before the reboot.
    param([Parameter(Mandatory)][string]$Checkpoint)
    if (-not $global:ResumeFrom) { return $false }
    $resumeIdx = $global:CheckpointOrder.IndexOf($global:ResumeFrom)
    $checkIdx  = $global:CheckpointOrder.IndexOf($Checkpoint)
    if ($resumeIdx -lt 0 -or $checkIdx -lt 0) { return $false }
    return $checkIdx -le $resumeIdx
}

function Show-ResumePrompt {
    # Checks for a saved checkpoint at launch. If found, asks the user
    # whether to resume or start fresh. Sets $global:ResumeFrom accordingly.
    # FT-35 (2026-07-12): non-admin sessions exit at the intro anyway, but
    # this prompt ran BEFORE that gate -- so an accidental non-admin
    # double-click could START OVER and wipe a real checkpoint (happened in
    # the 2026-07-11 22:30 field log). Non-admin runs now skip this prompt
    # and leave the checkpoint untouched.
    if (-not $global:IsAdmin) { return }
    $saved = Get-SavedCheckpoint
    if ($saved -and ($saved -in $global:CheckpointOrder)) {
        Clear-Host
        Write-Host ""
        Draw-Box -ScreenId "25" -Color White -Lines @(
            "  WELCOME BACK                                              ",
            "---",
            "  It looks like you've run Checkup before and were           ",
            "  partway through -- possibly right before a restart for a  ",
            "  Defender Offline Scan.                                    ",
            "                                                            ",
            "  [R] Resume where you left off (recommended)              ",
            "  [S] Start over from the beginning                        "
        )
        Write-Host ""
        $choice = Read-ValidKey -ValidKeys @("R","S") -Prompt "Resume or start over? (R/S): "
        if ($choice.ToUpper() -eq "R") {
            $global:ResumeFrom = $saved
            Write-Log -Message "User chose to RESUME from checkpoint: $saved" -Status "STATE"
            Restore-SessionAnswers   # FT-127 (ascii37)
            # FT-08: resuming skips the original maximize/scroll instructions
            # entirely, so the reminder needs to happen here instead.
            Write-Host ""
            Write-Host "  Tip: press Windows+Up Arrow, or click the maximize box" -ForegroundColor Gray
            Write-Host "  (top-right corner), to make this window full-screen again." -ForegroundColor Gray
            Write-Host ""
            # G-02c (ascii32): Mark mode reminder in resume flow
            Write-Host "  Tip: To copy text from this window -- press Alt+Space, then E, then M --" -ForegroundColor DarkCyan
            Write-Host "       drag or use Shift+arrows to select -- press Enter to copy." -ForegroundColor DarkCyan
            Write-Host "       Press Esc to exit without copying." -ForegroundColor DarkCyan
            Write-Host ""
            Pause-ForUser
        } else {
            $global:ResumeFrom = $null
            Clear-Checkpoint
            Write-Log -Message "User chose to START OVER -- checkpoint cleared" -Status "STATE"
        }
    } else {
        $global:ResumeFrom = $null
    }
}

# ============================================================
# RESUME QUICK RE-CHECK (FT-47, ascii28)
# ============================================================
function Show-ResumeReverify {
    # FT-47 (ascii28): resuming used to replay Test-PersonalComputer,
    # Test-AdminAccess, and Test-PowerStatus as full flashing screens
    # (every resume run in the 7/12 logs). Re-verifying is right; the
    # flash was not. One quiet screen now; full screens only on problems.
    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "31" -Color White -Lines @(
        "  QUICK RE-CHECK BEFORE RESUMING                            ",
        "---",
        "  Because you're resuming, we re-verify the basics on this   ",
        "  ONE screen instead of replaying each earlier screen:       ",
        "  your personal-PC answer, Administrator access, and         ",
        "  power/battery state.                                       "
    )
    Write-Host ""
    $rc = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Still YOUR personal computer? (Y = Yes / N = Exit): "
    if ($rc.ToUpper() -eq "N") {
        # FT-171d (ascii40): N USED TO END THE SESSION ON ITS OWN. One key, no
        # confirmation, everything closed -- against CLAUDE.md's standing rule
        # that there are no accidental exits without confirmation. On a machine
        # whose input buffer was accepting stray events (FT-171a), a single
        # stray N was all it took, and that is the shape of the two 2026-08-11
        # SANDY endings that were written up as crashes.
        Write-Host ""
        Draw-Box -ScreenId "83" -Color Yellow -Lines @(
            "  ARE YOU SURE YOU WANT TO CLOSE CHECKUP?                   ",
            "---",
            "  You answered that this is NOT your own personal computer. ",
            "  Checkup is only for computers you own, so it will close.  ",
            "                                                             ",
            "  Nothing on your computer has been changed.                ",
            "                                                             ",
            "  Press Y to close Checkup now.                             ",
            "  Press B to go back -- it IS your computer and you want    ",
            "  to carry on where you left off.                           "
        )
        Write-Host ""
        $rcSure = Read-ValidKey -ValidKeys @("Y","B") -Prompt "Close Checkup? (Y = close / B = go back): "
        if ($rcSure.ToUpper() -eq "Y") {
            Write-Host ""
            Write-Host "  Exiting. No changes made." -ForegroundColor Yellow
            Write-Log -Message "Resume re-check: user said not personal PC, and confirmed the exit -- exit" -Status "EXIT"
            Disable-SleepPrevention
            Save-Log
            exit
        }
        Write-Log -Message "Resume re-check: N was not confirmed -- carrying on (FT-171d)" -Status "CONFIRM"
        Write-Host ""
        Write-Host "  Carrying on where you left off." -ForegroundColor Green
    }
    Write-Host "  Confirmed -- re-checking this PC..." -ForegroundColor Green
    Write-Log -Message "Resume re-check: personal computer reconfirmed" -Status "CONFIRM"
    Test-DomainJoin   # stays silent unless a domain problem is found
    if ($global:IsAdmin) {
        Write-Host "  OK  Administrator access confirmed." -ForegroundColor Green
        Write-Log -Message "Resume re-check: administrator access confirmed" -Status "OK"
    } else {
        Test-AdminAccess   # a real problem -- worth the full screen
    }
    # Power/battery -- quiet unless on battery (that warning matters)
    try {
        $rvBatt = Get-WmiObject -Class Win32_Battery -ErrorAction SilentlyContinue
        $global:HasBattery = ($null -ne $rvBatt)
        $global:OnBattery  = ($global:HasBattery -and $rvBatt.BatteryStatus -eq 1)
        $global:BatteryPct = if ($global:HasBattery -and $rvBatt.EstimatedChargeRemaining) { "$($rvBatt.EstimatedChargeRemaining)%" } else { "N/A" }
    } catch { $global:OnBattery = $false; $global:HasBattery = $false; $global:BatteryPct = "Unknown" }
    Enable-SleepPrevention
    if ($global:OnBattery) {
        Test-PowerStatus   # full battery warning screen -- worth showing
    } else {
        Write-Host "  OK  AC power confirmed (battery: $($global:BatteryPct)). Sleep prevention active." -ForegroundColor Green
        Write-Log -Message "Resume re-check: AC power confirmed ($($global:BatteryPct)). Sleep prevention active." -Status "OK"
    }
    Write-Host ""
    Pause-ForUser "  All re-checked. Press Enter or Space to continue where you left off..."
}

# ============================================================
# SCROLL & COPY TIP (FT-41/FT-45/FT-63, ascii28)
# ============================================================
function Show-ScrollCopyTip {
    # QuickEdit is OFF on purpose (FT-01 walk-away fix) -- which also turns
    # off mouse highlighting and right-click copy. Mark mode is the
    # sanctioned method, and it PAUSES the program while active -- that must
    # be taught, or it reads as a hang (FT-63: the 84-minute frozen launch).
    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "02" -Color White -Lines @(
        "  HOW TO SCROLL BACK (AND COPY) IN THIS WINDOW              ",
        "---",
        "  Mouse highlighting and right-click copy are turned OFF     ",
        "  in this window ON PURPOSE -- a stray click used to freeze  ",
        "  the program mid-run. Here is the safe way instead:         ",
        "                                                             ",
        "  TO SCROLL BACK AND RE-READ EARLIER TEXT:                   ",
        "  1. Press Alt + Spacebar (a small menu opens, top-left)     ",
        "  2. Press E, then M                                         ",
        "  3. Up/Down arrows and Page Up/Page Down now scroll         ",
        "  4. Press Esc when you are done                             ",
        "                                                             ",
        "  IMPORTANT: while you are scrolling this way, the program   ",
        "  PAUSES and waits for you. It is not stuck -- press Esc     ",
        "  and it carries on exactly where it was. (Ctrl+Arrow        ",
        "  scrolling does NOT work in this window -- use the steps    ",
        "  above.)                                                    ",
        "                                                             ",
        "  AND RELAX: everything on every screen is also saved into   ",
        "  your log file automatically -- you never NEED to copy      ",
        "  anything off the screen by hand.                           "
    )
    Write-Host ""
    Pause-ForUser
    Clear-Host   # FT-88 (ascii32): wipe this screen so it does not flash briefly before the next screen renders
}

# ============================================================
# TIME & DATE SYNC CHECK (UX-08)
# ============================================================
function Test-TimeDateSync {
    Write-Host ""
    Write-Host "  Checking your computer's time and date settings..." -ForegroundColor Cyan

    try {
        $tzAuto = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\tzautoupdate" -Name "Start" -EA SilentlyContinue).Start
        $w32Time = Get-Service -Name "W32Time" -EA SilentlyContinue
        $timeAutoOK = ($w32Time -and $w32Time.StartType -ne "Disabled")
        $tzAutoOK   = ($tzAuto -ne 4)   # 4 = disabled, 3 = automatic

        if (-not $timeAutoOK -or -not $tzAutoOK) {
            Write-Host ""
            Draw-Box -ScreenId "36" -Color White -Lines @(
                "  !  TIME/DATE SYNC ISSUE DETECTED                          ",
                "---",
                "  Your computer's automatic time or time zone setting is    ",
                "  turned off. This can affect Windows Update, security      ",
                "  certificates, and scheduled scans.                        ",
                "                                                            ",
                "  Checkup will turn these back on now.                      "
            )
            try {
                Set-Service -Name "W32Time" -StartupType Automatic -EA SilentlyContinue
                Start-Service -Name "W32Time" -EA SilentlyContinue
                w32tm /resync /force | Out-Null
                Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\tzautoupdate" -Name "Start" -Value 3 -EA SilentlyContinue
                Write-Host "  Time sync settings corrected." -ForegroundColor Green
                Write-Log -Message "Time/timezone auto-sync corrected" -Status "FIXED"
            } catch {
                Write-Host "  Could not correct automatically -- see Settings > Time & Language." -ForegroundColor Yellow
                Write-Log -Message "Time/timezone auto-fix failed: $_" -Status "WARN"
            }
        }

        $currentTime = Get-Date -Format "dddd, MMMM d, yyyy -- h:mm tt"
        $currentTZ   = (Get-TimeZone).DisplayName
        Write-Host ""
        Write-Host "  Detected time: $currentTime" -ForegroundColor White
        Write-Host "  Time zone:     $currentTZ" -ForegroundColor White
        Write-Host ""
        $confirm = Read-ValidKey -ValidKeys @("Y","N") -Prompt "  Does this look correct? (Y/N): "

        if ($confirm.ToUpper() -eq "N") {
            # FIX (2026-07-10): previously this just told the user to go fix
            # it manually with no actual help. Now offers to open Windows'
            # own Date & Time settings panel -- a real GUI, already trusted,
            # already handles time zone and DST correctly. Applies to BOTH
            # Console and GUI mode since this function runs once centrally
            # before mode selection.
            Write-Log -Message "User flagged time/date as INCORRECT after auto-fix attempt" -Status "WARN"
            # FT-21 (2026-07-11): after answering N, the follow-up question was
            # easy to miss ("it blinked and just sat there") -- now boxed.
            Write-Host ""
            Draw-Box -ScreenId "37" -Color Yellow -Lines @(
                "  FIX THE TIME NOW?                                         ",
                "---",
                "  Checkup can open Windows' own Date & Time settings        ",
                "  so you can correct it, then come right back here.         "
            )
            Write-Host ""
            $openSettings = Read-ValidKey -ValidKeys @("Y","N") -Prompt "  Open Date & Time settings now? (Y = Open / N = Skip): "

            if ($openSettings.ToUpper() -eq "Y") {
                Start-Process "ms-settings:dateandtime"
                Write-Host ""
                Write-Host "  Windows Settings should now be open. Make your correction," -ForegroundColor White
                Write-Host "  then come back here." -ForegroundColor White
                Pause-ForUser "  Press Enter or Space once you've corrected the time..."

                # Re-check after giving them a chance to fix it
                $recheckTime = Get-Date -Format "dddd, MMMM d, yyyy -- h:mm tt"
                $recheckTZ   = (Get-TimeZone).DisplayName
                Write-Host ""
                Write-Host "  Time now shows: $recheckTime" -ForegroundColor White
                Write-Host "  Time zone:      $recheckTZ" -ForegroundColor White
                Write-Host ""
                # FT-28 (2026-07-11): the "(UTC-05:00)" in the zone name is the
                # zone's WINTER offset label -- it never changes, even in summer
                # when clocks are one hour ahead. Field-confirmed confusion.
                Write-Host "  NOTE: The '(UTC-05:00)' part is just the zone's winter label --" -ForegroundColor Gray
                Write-Host "  it stays the same all year. In summer, Windows automatically" -ForegroundColor Gray
                Write-Host "  runs one hour ahead. If the day, date, and time above are" -ForegroundColor Gray
                Write-Host "  right, everything is correct." -ForegroundColor Gray
                Write-Host ""
                $reconfirm = Read-ValidKey -ValidKeys @("Y","N") -Prompt "  Does this look correct now? (Y/N): "
                if ($reconfirm.ToUpper() -eq "Y") {
                    Write-Log -Message "Time/date corrected by user via Settings panel: $recheckTime $recheckTZ" -Status "FIXED"
                    Write-Host "  Great -- time and date look correct now." -ForegroundColor Green
                } else {
                    Write-Log -Message "Time/date still flagged incorrect after Settings panel -- continuing anyway" -Status "WARN"
                    Write-Host "  Continuing anyway -- you can fix this anytime in Settings > Time & Language." -ForegroundColor Yellow
                }
            } else {
                Write-Host "  Continuing without correcting -- you can fix this anytime in Settings > Time & Language." -ForegroundColor Gray
                Write-Log -Message "User declined to open Date & Time settings" -Status "SKIP"
            }
        } else {
            Write-Log -Message "Time/date confirmed correct by user: $currentTime $currentTZ" -Status "OK"
        }
    } catch {
        Write-Host "  Could not verify time/date settings -- continuing." -ForegroundColor Yellow
        Write-Log -Message "Time/date check error: $_" -Status "WARN"
    }
}

# ============================================================
# SYSTEM BASELINE SUMMARY (UX-10)
# Shown once, up front, before any security checks. Builds trust
# that GatewayGuard knows what machine it's working on, and
# captures baseline state for troubleshooting.
# Reference: GatewayGuard_SystemBaseline_Diagnostic.ps1
# ============================================================
function Show-SystemBaselineSummary {
    Clear-Host
    Write-Host ""
    Write-Host "  Gathering system information..." -ForegroundColor Cyan
    Write-Host ""

    Show-StepHeader -Key "Baseline" -Section "Getting Ready"
    $lines = @("  YOUR SYSTEM AT A GLANCE                                   ", "---")

    try {
        $cs = Get-CimInstance -ClassName Win32_ComputerSystem -EA SilentlyContinue
        $lines += "  Make/Model:   $($cs.Manufacturer) $($cs.Model)"
    } catch { $lines += "  Make/Model:   Could not detect" }

    $lines += "  Windows:      $global:WinEdition"
    $lines += "  RAM:          $($global:RAMGB) GB"

    try {
        $cpu = Get-CimInstance -ClassName Win32_Processor -EA SilentlyContinue | Select-Object -First 1
        $lines += "  Processor:    $($cpu.Name)"
    } catch { $lines += "  Processor:    Could not detect" }

    try {
        # FT-178 (ascii41): this read Win32_DiskDrive | Select-Object -First 1
        # and threw every other disk away. SANDY has two and this screen has
        # always shown one. Reported twice from the field -- ascii39 finding
        # 13 and ascii40 run 1 finding 3 -- because it was never a detection
        # failure. The second disk was discarded by construction.
        # VERIFIED 2026-08-17 measured on CGDELL: Get-PhysicalDisk exposes
        # Size and a MediaType of 'SSD'. Win32_DiskDrive reports that same
        # drive as 'Fixed hard disk media', which is why the type is read
        # from Get-PhysicalDisk and not from WMI.
        # ascii44, Bill's request: THE SSD IS DRIVE 1. This was
        # Sort-Object DeviceId -- hardware enumeration order, which means
        # nothing to the customer, and it is the first thing screen 12
        # tells them about their own machine. SSDs first, everything else
        # after, DeviceId as the tiebreak inside each group. Sorting on
        # MediaType uses only the property already read two lines below.
        # NOT a plain reverse: that is right only with exactly two drives
        # in exactly the wrong order, and wrong with three.
        # NOT VERIFIED ON A MULTI-DRIVE MACHINE -- measured on CGDELL
        # 2026-09-06, Get-PhysicalDisk returns one disk, so the output is
        # unchanged here. Check screen 12 on SANDY during the field run.
        $ggDisks = @(Get-PhysicalDisk -EA SilentlyContinue |
                     Sort-Object @{ Expression = { if ([string]$_.MediaType -eq "SSD") { 0 } else { 1 } } },
                                 @{ Expression = { $_.DeviceId } })
        if ($ggDisks.Count -eq 0) {
            $lines += "  Storage:      Could not detect"
        } else {
            $ggDN = 0
            foreach ($ggD in $ggDisks) {
                $ggDN++
                $ggDGB  = [math]::Round($ggD.Size / 1GB, 0)
                $ggDTyp = if ($ggD.MediaType) { [string]$ggD.MediaType } else { "type unknown" }
                $ggDLbl = if ($ggDN -eq 1) { "  Storage:      " } else { "                " }
                if ($ggDisks.Count -eq 1) {
                    $lines += ($ggDLbl + $ggDGB + " GB (" + $ggDTyp + ")")
                } else {
                    $lines += ($ggDLbl + "Drive " + $ggDN + ": " + $ggDGB + " GB (" + $ggDTyp + ")")
                }
            }
        }
    } catch { $lines += "  Storage:      Could not detect" }

    try {
        $batt = Get-CimInstance -ClassName Win32_Battery -EA SilentlyContinue
        if ($batt) {
            $lines += "  Battery:      $($batt.EstimatedChargeRemaining)% charged"
            if ($batt.EstimatedChargeRemaining -lt 50 -and -not $global:OnBattery) {
                $lines += "                (Consider plugging in before scans/BitLocker)"
            }
        } else {
            $lines += "  Battery:      Desktop (no battery detected)"
        }
    } catch { $lines += "  Battery:      Could not detect" }

    try {
        $av = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
        $avNames = ($av | Select-Object -ExpandProperty displayName) -join ", "
        $lines += "  Antivirus:    $(if ($avNames) { $avNames } else { 'None registered' })"
    } catch { $lines += "  Antivirus:    Could not detect" }

    try {
        $wu = Get-Service -Name "wuauserv" -EA SilentlyContinue
        $lines += "  Windows Update service: $($wu.Status)"
    } catch { $lines += "  Windows Update service: Could not detect" }

    try {
        $bl = Get-BitLockerVolume -MountPoint "C:" -EA SilentlyContinue
        $blStatus = if ($bl) { $bl.ProtectionStatus } else { "Not available (Home edition uses Device Encryption instead)" }
        $lines += "  BitLocker/Encryption: $blStatus"
    } catch { $lines += "  BitLocker/Encryption: Could not detect" }

    # FT-143 (ascii39): SECURE BOOT IS NOW CHECKED ON EVERY EDITION.
    # It was only ever read inside Test-DeviceEncryptionPrereq, which runs on
    # HOME ONLY. On Pro that code never executes -- so Secure Boot being OFF on
    # the Dell has gone unreported for 38 builds, on a machine that has been the
    # primary test box the whole time. A check that only runs on half the
    # machines is not a check.
    # REPORTED, NOT CHANGED, AND DELIBERATELY SO: turning Secure Boot on for an
    # already-encrypted machine can trigger a BitLocker recovery prompt at the
    # next boot. A user who cannot produce the recovery key at that prompt loses
    # the machine. So Checkup states the finding and the precondition, and the
    # user acts. This is C-27's principle applied to firmware.
    try {
        $ggSB = $null
        try { $ggSB = Confirm-SecureBootUEFI -EA Stop } catch { $ggSB = $null }
        if ($ggSB -eq $true) {
            $lines += "  Secure Boot:  ON -- GOOD"
        } elseif ($ggSB -eq $false) {
            $lines += "  Secure Boot:  OFF -- worth turning on, but read this first:"
            $lines += "                if this PC is already encrypted, turning Secure"
            $lines += "                Boot on can make Windows ask for your recovery"
            $lines += "                key at the next start-up. Find that key BEFORE"
            $lines += "                you change it. Checkup does not change this."
        } else {
            $lines += "  Secure Boot:  Could not read (common on older BIOS PCs)"
        }
        Write-Log -Message ("Secure Boot state read on all editions (FT-143): " + $(if ($null -eq $ggSB) { "unreadable" } else { [string]$ggSB })) -Status "INFO"
    } catch { $lines += "  Secure Boot:  Could not detect" }

    Draw-Box -ScreenId "09" -Color White -Lines $lines
    Write-Host ""
    # FT-83 (ascii32): three baseline lines were hidden below the fold with a
    # live-but-invisible prompt. Explicit scroll notice added before the prompt.
    Write-Host "  ** If any lines above look cut off, SCROLL UP to see them:" -ForegroundColor Yellow
    Write-Host "     press Alt+Spacebar, then E, then M, then use the Up/Down" -ForegroundColor Yellow
    Write-Host "     arrow keys. Press Esc when done -- the tool will continue." -ForegroundColor Yellow
    Write-Host ""
    Write-Log -Message "System Baseline Summary displayed" -Status "INFO"
    Pause-ForUser "  Press Enter or Space to continue..."
}

# ============================================================
# STEP 7: PRE-SCAN GATE
# ============================================================
# ============================================================
# SCREEN-26 + SCREEN-27: SECURITY TOOLS BRIEFING (D-06, ascii33)
# Plain-English introduction to Defender + Malwarebytes + the scan
# plan BEFORE any scan screens. Includes D-13 (log location told
# early), the 14-day trial explanation, and the field-verified
# rootkit/Custom Scan guidance (2026-07-19, all three machines).
# ============================================================
function Show-SecurityToolsBriefing {
    Clear-Host
    Write-Host ""
    Show-StepHeader -Key "Briefing1" -Section "Scans"
    Draw-Box -ScreenId "26" -Color White -Lines @(
        "  YOUR PC'S SECURITY TOOLS -- A QUICK INTRODUCTION           ",
        "---",
        "  Before we change anything, here is what protects your PC   ",
        "  and how the pieces fit together.                           ",
        "                                                             ",
        "  WINDOWS DEFENDER (already on your PC)                      ",
        "  Windows comes with a built-in antivirus called Microsoft   ",
        "  Defender. It is free, already installed, and watches your  ",
        "  PC in real time -- every file you open, every download,    ",
        "  every program you run. Checkup will make sure it is        ",
        "  set up correctly.                                          ",
        "                                                             ",
        "  MALWAREBYTES (we recommend adding it)                      ",
        "  Malwarebytes is a separate free program that works         ",
        "  alongside Defender. Defender watches in real time;         ",
        "  Malwarebytes runs deeper scans when you ask for one --     ",
        "  looking for threats that hide from real-time scanners.     ",
        "  They work together without conflict.                       ",
        "                                                             ",
        "  ABOUT THE 14-DAY TRIAL (important -- please read)          ",
        "  When you first install Malwarebytes, it starts a free      ",
        "  14-day trial of the paid version. After 14 days the trial  ",
        "  ends BY ITSELF -- you do not need to do anything, and      ",
        "  nothing breaks. Malwarebytes switches to its free mode,    ",
        "  Defender takes back real-time protection, and the deeper   ",
        "  scans stay available to you permanently, at no cost.       ",
        "                                                             ",
        "  YOUR RECORDS                                               ",
        "  Checkup keeps a record of everything it does, saved        ",
        "  in your own GatewayGuard folder. If you need help, that   ",
        "  file shows exactly what happened on your PC.               "
    )
    Write-Host ""
    Pause-ForUser "  Press Enter or Space to continue..."
}

function Show-ScanPlanBriefing {
    Clear-Host
    Write-Host ""
    Show-StepHeader -Key "Briefing2" -Section "Scans"
    Draw-Box -ScreenId "27" -Color White -Lines @(
        "  THE SCANS WE RECOMMEND -- AND WHY                          ",
        "---",
        "  Before hardening your settings, we want your PC confirmed  ",
        "  clean. A scan AFTER hardening cannot undo an infection     ",
        "  that is already there.                                     ",
        "                                                             ",
        "  SCAN 1: DEFENDER OFFLINE SCAN (15-20 minutes)              ",
        "  Runs BEFORE Windows loads -- so threats cannot hide the    ",
        "  way they can once Windows is running. Your PC restarts     ",
        "  by itself, scans, and comes back. Checkup picks up         ",
        "  right where you left off.                                  ",
        "                                                             ",
        "  SCAN 2: MALWAREBYTES CUSTOM SCAN (25 min to an hour)       ",
        "  After installing Malwarebytes you will run a Custom Scan   ",
        "  with 'Scan for rootkits' CHECKED and ALL drives selected.  ",
        "  We will give you the exact steps when it is time.          ",
        "                                                             ",
        "  What is a rootkit? One of the sneakiest kinds of           ",
        "  malicious software. It buries itself deep inside Windows   ",
        "  -- deeper than most security programs can see -- then      ",
        "  hides itself, and often hides other malicious programs     ",
        "  too. Your PC can be infected and everything still LOOKS    ",
        "  normal. The Custom Scan looks in the places rootkits hide. ",
        "                                                             ",
        "  LATER, MONTHLY: run that same Custom Scan, then a Deep     ",
        "  Scan overnight. Overnight scans are safe -- Malwarebytes   ",
        "  keeps the PC awake by itself. Just plug in and leave the   ",
        "  lid open; the screen may go dark, the scan keeps going.    ",
        "                                                             ",
        "  Already ran your scans today? You can skip ahead on the    ",
        "  next screen.                                               "
    )
    Write-Host ""
    Pause-ForUser "  Press Enter or Space to continue..."
}

function Show-PreScanGate {
    # If resuming right after an offline-scan reboot, skip straight to
    # post-scan guidance (UX-07) instead of showing the whole gate again.
    if ($global:ResumeFrom -eq "OfflineScanPending") {
        Show-PostScanGuidance
        return
    }

    Clear-Host
    Write-Host ""

    if ($global:IsFirstRun) {
        # Pre-scan prep checklist (UX-11)
        Show-StepHeader -Key "PreScanPrep" -Section "Scans"
        Draw-Box -ScreenId "10" -Color White -Lines @(
            "  BEFORE WE SCAN YOUR PC                                     ",
            "---",
            "  Before applying any security settings, your PC must be     ",
            "  confirmed CLEAN of malware and viruses. Applying hardening ",
            "  settings on an infected PC can hide malware and make it    ",
            "  HARDER to detect later.                                    ",
            "                                                             ",
            "  Before we begin scanning, please:                         ",
            "  1. Close all open programs and browser windows            ",
            "  2. Plug in your power adapter if you are on a laptop      ",
            "  3. Do not use the computer while scanning                 ",
            "  4. Do not turn off or restart the computer during the scan",
            "                                                             ",
            "  Already scanned this PC recently? Press S to skip the      ",
            "  scanning step. Only skip if scans came back clean.         "
        )
        Write-Host ""
        # FT-20 (2026-07-11): visible S = Skip, for repeat runs / testing
        # FT-80 (ascii32): N was exiting the program with no warning; testers
        # expected N to mean "not ready yet," not "quit." N now explains that
        # it exits and asks for confirmation before actually exiting.
        do {
            Write-Host "  Y = Ready to scan now" -ForegroundColor DarkGray
            Write-Host "  S = Already scanned recently and it came back clean -- skip the scan" -ForegroundColor DarkGray
            Write-Host "  N = Not ready yet -- exit Checkup so you can prepare first" -ForegroundColor DarkGray
            Write-Host ""
            $ready = Read-ValidKey -ValidKeys @("Y","N","S") -Prompt "Your choice (Y = Scan now / S = Skip scan / N = Exit to prepare): "
            if ($ready.ToUpper() -eq "N") {
                Write-Host ""
                Write-Host "  N exits Checkup so you can close programs and get ready." -ForegroundColor Yellow
                Write-Host "  Nothing is changed on your PC. Relaunch Checkup when ready." -ForegroundColor Yellow
                Write-Host ""
                # LABEL CONSISTENCY (FT-65 rule): Y/N would flip meaning here
                # (outer Y = scan, inner Y = exit) -- so this confirm uses E/R.
                $exitConfirm = Read-ValidKey -ValidKeys @("E","R") -Prompt "Confirm: (E = Exit the tool / R = Return to the question above): "
                if ($exitConfirm.ToUpper() -ne "E") {
                    Write-Host ""
                    continue   # back to the Y/S/N prompt -- no exit
                }
                Write-Host ""
                Write-Host "  Take your time. Relaunch Checkup when you're ready." -ForegroundColor Yellow
                Write-Log -Message "User exited at pre-scan prep checklist (FT-80: confirmed exit)" -Status "EXIT"
                Disable-SleepPrevention; Save-Log; exit
            }
            if ($ready.ToUpper() -eq "S") {
                Write-Host ""
                Write-Host "  Skipping the scanning step. Only do this if this PC was" -ForegroundColor Yellow
                Write-Host "  already scanned recently and came back clean." -ForegroundColor Yellow
                Write-Log -Message "Scan gate SKIPPED by user (S key)" -Status "WARN"
                Pause-ForUser
                return
            }
        } while ($ready.ToUpper() -ne "Y")

        Invoke-OfflineScanOffer

    } else {
        Draw-Box -ScreenId "39" -Color White -Lines @(
            "  REMINDER: PRE-SCAN RECOMMENDED                             ",
            "---",
            "  This is a repeat run of Checkup.                           ",
            "  For ongoing protection:                                    ",
            "  * Defender Offline Scan -- quarterly, or any time you      ",
            "    think something may be wrong                             ",
            "  * Malwarebytes scan -- monthly (Checkup can launch it      ",
            "    for you)                                                 ",
            "  Guide: Phase 5 -- Scheduled Scanning                       "
        )
        Write-Host ""
        do {
            $cont = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue with Checkup? (Y = Continue / N = Exit): "
            if ($cont.ToUpper() -eq "N") { Save-Log; exit }
        } while ($cont.ToUpper() -ne "Y")
        Write-Log -Message "Repeat run -- user confirmed to continue" -Status "CONFIRM"
        # FT-175b (ascii41): THE OFFER WAS NEVER HERE. This branch runs on
        # every repeat run and every resume. It DESCRIBED the offline scan
        # without ever offering to start one, so a returning user could not
        # run it from Checkup at all. ascii39 finding 38 asked for exactly
        # this and guessed the cause correctly -- "check if running resume
        # had anything to do with it not running". It did.
        # Proven again 2026-08-17: the SANDY log shows SCREEN-39, no
        # SCREEN-38, and no [SKIP] User skipped Defender Offline Scan line,
        # because the question was never asked.
        Invoke-OfflineScanOffer
    }
}

# ============================================================
# DEFENDER OFFLINE SCAN OFFER (FT-175b, ascii41)
# Extracted verbatim from the first-run branch of Show-PreScanGate so
# that BOTH branches can call it. Duplicating it was the alternative
# and was rejected: the reason this defect survived an entire build is
# that the offer lived in one branch and the other silently had none.
# ============================================================
function Invoke-OfflineScanOffer {
    # Automated offline scan confirmation (UX-04, UX-09)
    Clear-Host
    Write-Host ""
    Show-StepHeader -Key "DefOffline" -Section "Scans"
    Draw-Box -ScreenId "38" -Color White -Lines @(
        "  DEFENDER OFFLINE SCAN                                      ",
        "---",
        "  Checkup can start a Windows Defender Offline Scan          ",
        "  for you now. This scan runs BEFORE Windows loads, so it    ",
        "  catches rootkits and malware that hide during normal use.  ",
        "                                                             ",
        "  IMPORTANT -- WHAT WILL HAPPEN:                            ",
        "  * Your computer will restart automatically                ",
        "  * This Checkup window will close during the restart       ",
        "  * A blue scan screen will run for 10-20 minutes            ",
        "  * Your computer will then restart again to the desktop    ",
        "  * When you're back at the desktop, run Checkup again      ",
        "    -- it will automatically pick up right where you left   ",
        "    off. You do NOT need to start over.                     ",
        "                                                             ",
        "  Scan time varies by computer. A fast scan on a clean       ",
        "  machine is normal. A slower scan just means more files to  ",
        "  check -- that's normal too. Please be patient.             "
    )
    Write-Host ""
    $scanConfirm = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Start the offline scan now? (Y/N): "

    if ($scanConfirm.ToUpper() -eq "Y") {
        Save-Checkpoint -Checkpoint "OfflineScanPending"
        Write-Log -Message "Starting Defender Offline Scan -- reboot expected" -Status "INFO"
        Write-Host ""
        Write-Host "  Starting the offline scan. Your computer will restart" -ForegroundColor Green
        Write-Host "  in a few seconds. See you on the other side!" -ForegroundColor Green
        Start-Sleep -Seconds 5   # intentional countdown -- gives user time to read "restarting" message; not an interactive loop
        Disable-SleepPrevention
        Start-MpWDOScan
        # Script effectively ends here -- the reboot takes over.
        exit
    } else {
        Write-Host ""
        Write-Host "  Offline scan skipped. You can run this from Checkup" -ForegroundColor Gray
        Write-Host "  anytime, or manually via Windows Security > Virus & threat" -ForegroundColor Gray
        Write-Host "  protection > Scan options." -ForegroundColor Gray
        Write-Log -Message "User skipped Defender Offline Scan" -Status "SKIP"
        Pause-ForUser "  Press Enter or Space to continue..."
    }
}

# ============================================================
# POST-SCAN GUIDANCE (UX-07)
# Runs when resuming right after the offline-scan reboot.
# ============================================================
function Show-PostScanGuidance {
    Clear-Host
    Write-Host ""
    Show-StepHeader -Key "PostScan" -Section "Scans"
    Draw-Box -ScreenId "40" -Color White -Lines @(
        "  WELCOME BACK -- OFFLINE SCAN COMPLETE                     ",
        "---",
        "  Your Defender Offline Scan has finished. Here's how to     ",
        "  see the results:                                          ",
        "                                                             ",
        "  1. We'll open Windows Security to Protection History now   ",
        "  2. Look for any items listed under Recent Actions          ",
        "                                                             ",
        "  WHAT TO LOOK FOR:                                          ",
        "  * 'Quarantined' or 'Removed' -- good news, Defender         ",
        "    already handled it. No action needed.                   ",
        "  * 'Allowed' -- Defender saw something suspicious but        ",
        "    didn't block it. If you don't recognize it, we'll run    ",
        "    Malwarebytes next as a second opinion.                  ",
        "  * 'No Recent Actions' -- your scan came back clean.        "
    )
    Write-Host ""
    Pause-ForUser "  Press Enter or Space to open Protection History..."
    Start-Process "windowsdefender://protectionhistory"
    Start-Sleep -Seconds 2   # intentional: allows Protection History window to open before next prompt

    Write-Host ""
    do {
        $result = Read-ValidKey -ValidKeys @("Y","N") -Prompt "  Did you find any items needing action? (Y/N): "
    } while ($result.ToUpper() -notin @("Y","N"))

    if ($result.ToUpper() -eq "Y") {
        Write-Host ""
        Write-Host "  Write down the threat name shown in Protection History." -ForegroundColor Yellow
        Write-Host "  We'll continue with Malwarebytes next as a second opinion." -ForegroundColor Yellow
        Write-Log -Message "Post-scan: user found items needing action in Protection History" -Status "WARN"
    } else {
        Write-Log -Message "Post-scan: Protection History clean or already handled" -Status "OK"
    }
    Pause-ForUser "  Press Enter or Space to continue..."
}

# ============================================================
# STEP 8: VERIFY DEFENDER IS PRIMARY AV
# Uses SecurityCenter2 WMI ONLY -- no registry
# ============================================================
function Test-DefenderPrimary {
    Clear-Host
    Write-Host ""
    Write-Host "  Checking antivirus status..." -ForegroundColor Cyan
    Write-Host ""

    try {
        $avProducts = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -ErrorAction Stop
        $defender   = $avProducts | Where-Object { $_.displayName -match "Windows Defender|Microsoft Defender" }
        $nonDefender = $avProducts | Where-Object { $_.displayName -notmatch "Windows Defender|Microsoft Defender" }
        $mbFree     = $avProducts | Where-Object { $_.displayName -match "Malwarebytes" }

        # -- Detect Russian / Chinese AV -- strong uninstall recommendation --
        $riskyAV = $avProducts | Where-Object {
            $dn = $_.displayName
            ($HighRiskAVList | Where-Object { $dn -match $_ }).Count -gt 0
        }
        if ($riskyAV) {
            $riskyName = if ($riskyAV[0].displayName) { $riskyAV[0].displayName } else { "A high-risk antivirus" }
            Clear-Host
            Write-Host ""
            Draw-Box -ScreenId "41" -Color White -Lines @(
                "  !!!!!  CRITICAL SECURITY WARNING  !!!!!                    ",
                "---",
                "  HIGH-RISK ANTIVIRUS DETECTED: $riskyName",
                "---",
                "  This antivirus is made by a company based in RUSSIA or     ",
                "  CHINA. The U.S. Cybersecurity and Infrastructure Security  ",
                "  Agency (CISA), FBI, and independent security researchers   ",
                "  have documented these products:                            ",
                "                                                              ",
                "  * Sending files and browsing data to foreign servers       ",
                "  * Providing access to foreign government intelligence       ",
                "  * Operating as spyware while appearing as protection       ",
                "                                                              ",
                "  !! YOU ARE AT RISK AS LONG AS THIS SOFTWARE IS INSTALLED  ",
                "                                                              ",
                "  WHAT TO DO -- RIGHT NOW:                                   ",
                "  1. UNINSTALL: Settings -> Apps -> $riskyName -> Uninstall",
                "  2. RESTART your PC after uninstalling                      ",
                "  3. Confirm Microsoft Defender is active in Windows Security",
                "  4. Optional companion: Malwarebytes FREE (manual scans)   ",
                "     $AffiliateMalwarebytes",
                "     (Free version only -- do NOT activate real-time)        ",
                "                                                              ",
                "  Microsoft Defender is a fully capable, FREE antivirus      ",
                "  built into Windows. You do not need a paid foreign product."
            )
            Write-Host ""
            Write-Log -Message "HIGH-RISK AV detected: $riskyName" -Status "WARN"
            do {
                $cont = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue anyway? (Y = Continue / N = Exit to uninstall first): "
                if ($cont.ToUpper() -eq "N") {
                    Write-Host ""
                    Write-Host "  Uninstall $riskyName, then relaunch Checkup." -ForegroundColor Yellow
                    Disable-SleepPrevention; Save-Log; exit
                }
            } while ($cont.ToUpper() -ne "Y")
            Pause-ForUser
        }

        if ($mbFree) {
            # Check if MB took over real-time -- use Get-MpComputerStatus (reliable)
            # NOT productState 0x1000 bit -- MB Free also sets that bit (confirmed HP 17-by1xxx)
            $defRT = $false
            try { $defRT = (Get-MpComputerStatus -EA Stop).RealTimeProtectionEnabled } catch {}
            if (-not $defRT -and -not $defender) {
                Clear-Host
                Write-Host ""
                # FT-12 (2026-07-10): reframed from "this needs to be fixed"
                # to "this is expected and fine" -- a Malwarebytes trial
                # temporarily taking over real-time protection is a normal,
                # temporary state, not a problem. Defender resumes control
                # automatically once the trial ends or is deactivated.
                Draw-Box -ScreenId "42" -Color White -Lines @(
                    "  MALWAREBYTES TRIAL IS CURRENTLY HANDLING PROTECTION      ",
                    "---",
                    "  Malwarebytes started a Premium trial and is temporarily   ",
                    "  handling real-time protection instead of Defender.       ",
                    "  THIS IS NORMAL AND OK -- not a problem to fix right now.  ",
                    "                                                            ",
                    "  Windows only allows ONE app to handle real-time           ",
                    "  protection at a time. Microsoft Defender will              ",
                    "  automatically become active again once the Malwarebytes  ",
                    "  trial ends (or if you deactivate it early).              ",
                    "                                                            ",
                    "  IN THE MEANTIME: you can still run daily Malwarebytes    ",
                    "  scans manually for protection.                           ",
                    "                                                            ",
                    "  If you'd like Defender back sooner (optional):           ",
                    "  Open Malwarebytes -> Settings (gear) -> Account ->        ",
                    "  Deactivate Premium Trial                                  ",
                    "                                                            ",
                    "  Tamper Protection is a SEPARATE setting from real-time    ",
                    "  protection -- worth checking it's still ON in Windows     ",
                    "  Security regardless of which AV is currently active.      ",
                    "  Guide: Phase 3, Step 4                                   "
                )
                Write-Host ""
                do {
                    $cont = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue? (Y = Continue / N = I'll deactivate the trial first): "
                    if ($cont.ToUpper() -eq "N") {
                        Write-Host "  Take your time -- relaunch Checkup once you're ready." -ForegroundColor Yellow
                        Write-Log -Message "Exited -- user chose to deactivate MB trial first" -Status "INFO"
                        Disable-SleepPrevention; Save-Log; exit
                    }
                } while ($cont.ToUpper() -ne "Y")
                Write-Log -Message "Continuing -- Malwarebytes trial active as primary AV (expected, not an error)" -Status "OK"
                Pause-ForUser
                return
            }
        }

        # Check actual Defender real-time state directly -- most reliable source of truth
        # FT-23 (2026-07-11): a FAILED check used to default to "off" and fire
        # the scary DEFENDER IS OFF alarm even when Defender was fine
        # (field-confirmed false alarm right after the Malwarebytes check).
        # Unknown is now tracked separately and gets a calm message instead.
        $defenderRTUnknown = $false
        try {
            $mpStatus = Get-MpComputerStatus -EA Stop
            $defenderRTOn = $mpStatus.RealTimeProtectionEnabled
        } catch {
            $defenderRTOn = $false
            $defenderRTUnknown = $true
            Write-Log -Message "Get-MpComputerStatus failed -- Defender state UNKNOWN, not assuming OFF: $_" -Status "WARN"
        }

        # Determine if MB Free is the only non-Defender AV (companion scenario -- OK)
        $nonMbNonDefender = $nonDefender | Where-Object { $_.displayName -notmatch "Malwarebytes" }

        if ($defenderRTOn) {
            # Defender real-time IS on -- this is the healthy state
            if ($mbFree) {
                # MB registered in SC2 but Defender RT is on -- MB is companion only
                Clear-Host
                Write-Host ""
                Draw-Box -ScreenId "43" -Color White -Lines @(
                    "  OK  ANTIVIRUS STATUS -- HEALTHY SETUP                    ",
                    "---",
                    "  Microsoft Defender: ACTIVE as primary real-time AV       ",
                    "  Malwarebytes Free:  Installed as manual-scan companion    ",
                    "                                                            ",
                    "  This is the RECOMMENDED setup:                           ",
                    "  * Defender provides always-on real-time protection        ",
                    "  * Malwarebytes Free adds manual scan capability for       ",
                    "    catching PUPs and adware Defender sometimes misses      ",
                    "  * Malwarebytes Free does NOT interfere with Defender      ",
                    "                                                            ",
                    "  What you see in Windows Security:                        ",
                    "  Both apps may appear under Virus & threat protection.    ",
                    "  Defender is listed as 'On' -- this is correct.           ",
                    "  Malwarebytes shows as installed but is NOT your primary  ",
                    "  AV shield -- it is a companion tool only.                "
                )
                Write-Host ""
                Write-Log -Message "Defender active as primary AV. MB Free installed as companion." -Status "OK"
                Pause-ForUser
            } else {
                Write-Host ""
                Write-Host "  OK  Microsoft Defender is active as primary AV." -ForegroundColor Green
                Write-Log -Message "Defender confirmed as primary AV" -Status "OK"
                Pause-ForUser
            }
        } elseif ($nonMbNonDefender) {
            # A different 3rd-party AV is active, not MB
            $avName = $nonMbNonDefender[0].displayName
            Clear-Host
            Write-Host ""
            Draw-Box -ScreenId "44" -Color White -Lines @(
                "  !  MICROSOFT DEFENDER IS NOT YOUR PRIMARY ANTIVIRUS     ",
                "---",
                "  Active AV detected: $avName",
                "                                                           ",
                "  Microsoft Defender is not currently the active           ",
                "  real-time protection on this PC.                         ",
                "                                                           ",
                "  You may continue without fixing this, but some           ",
                "  Defender settings may not apply correctly.               ",
                "  Guide: Phase 3, Step 4                                   "
            )
            Write-Host ""
            do {
                $cont = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue anyway? (Y = Continue / N = Fix first then re-run): "
                if ($cont.ToUpper() -eq "N") {
                    Write-Host "  Fix Defender status and relaunch the tool." -ForegroundColor Yellow
                    Write-Log -Message "Exited -- non-Defender AV active: $avName" -Status "WARN"
                    Disable-SleepPrevention; Save-Log; exit
                }
            } while ($cont.ToUpper() -ne "Y")
            Write-Log -Message "Continuing with non-Defender AV active: $avName" -Status "WARN"
            Pause-ForUser
        } elseif ($defenderRTUnknown) {
            # FT-23: could not VERIFY Defender -- do not alarm, do not block
            Write-Host ""
            Write-Host "  Could not verify Defender's status just now -- this is usually" -ForegroundColor Yellow
            Write-Host "  temporary. To check yourself: open Windows Security and look" -ForegroundColor Yellow
            Write-Host "  under Virus & threat protection." -ForegroundColor Yellow
            Write-Log -Message "Defender state unverifiable -- informational message shown, continuing" -Status "WARN"
            Pause-ForUser
        } elseif ($nonDefender | Where-Object { $_.displayName -match "Malwarebytes" }) {
            # FT-30 (2026-07-12): Defender RT is off but MALWAREBYTES is
            # registered in Security Center -- MB has taken over real-time
            # protection (normal during a Premium trial). Round-4 field test
            # showed the scary alarm firing here because the MB state check
            # missed the trial. This is a handoff, not an emergency.
            Write-Log -Message ("FT-30 context: mbState=" + (Get-MalwarebytesState) + " SC2=[" + (($nonDefender | ForEach-Object { $_.displayName }) -join "; ") + "]") -Status "INFO"
            Clear-Host
            Write-Host ""
            Draw-Box -ScreenId "45" -Color White -Lines @(
                "  ANTIVIRUS STATUS -- MALWAREBYTES IS ON DUTY               ",
                "---",
                "  Malwarebytes is currently providing your real-time         ",
                "  protection, so Windows Defender's real-time shield is       ",
                "  standing down. This is NORMAL -- Windows only allows one    ",
                "  real-time antivirus at a time, and your PC IS protected.    ",
                "                                                              ",
                "  When the Malwarebytes trial ends, Defender takes over       ",
                "  again automatically. Two things to check at that point:     ",
                "  1. Defender real-time protection is back ON                 ",
                "  2. Tamper Protection is ON (the trial can leave it off)     ",
                "  Both live in Windows Security -> Virus & threat protection. "
            )
            Write-Host ""
            Write-Log -Message "Defender RT off, Malwarebytes registered in SC2 -- handoff explanation shown (no alarm)" -Status "OK"
            Pause-ForUser
        } else {
            # Defender real-time is CONFIRMED off and NOTHING registered to replace it
            Write-Log -Message ("Defender-off ALARM context: mbState=" + (Get-MalwarebytesState) + " SC2 count=" + (@($nonDefender).Count)) -Status "WARN"
            Clear-Host
            Write-Host ""
            Draw-Box -ScreenId "46" -Color White -Lines @(
                "  !!  DEFENDER REAL-TIME PROTECTION IS OFF                 ",
                "---",
                "  Microsoft Defender real-time protection is not active.   ",
                "  Your PC may be unprotected from malware and viruses.     ",
                "                                                            ",
                "  TO CHECK AND FIX:                                        ",
                "  1. Open Windows Security (Start -> search 'Windows Security')",
                "  2. Click Virus & threat protection                        ",
                "  3. Under Virus & threat protection settings, click Manage settings",
                "  4. Turn Real-time protection ON                           ",
                "                                                            ",
                "  If Tamper Protection is on, you may need to toggle it    ",
                "  off briefly, enable real-time protection, then re-enable  ",
                "  Tamper Protection.                                        "
            )
            Write-Host ""
            do {
                $cont = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue anyway? (Y = Continue / N = Fix Defender first): "
                if ($cont.ToUpper() -eq "N") {
                    Write-Host "  Enable Defender real-time protection, then relaunch." -ForegroundColor Yellow
                    Write-Log -Message "Exited -- Defender real-time protection is OFF" -Status "WARN"
                    Disable-SleepPrevention; Save-Log; exit
                }
            } while ($cont.ToUpper() -ne "Y")
            Write-Log -Message "Continuing with Defender real-time OFF" -Status "WARN"
            Pause-ForUser
        }
    } catch {
        Write-Host "  Could not verify AV status -- continuing with caution." -ForegroundColor Yellow
        Write-Log -Message "AV status check error: $_" -Status "WARN"
        # Sleep removed (ascii32): per no-Sleep-in-Show rule
    }
}

# ============================================================
# MALWAREBYTES DETECT-AND-LAUNCH FOLLOW-UP (UX-06, OBS-01)
# Replaces ascii22's manual-only Malwarebytes instructions.
# Note: Malwarebytes has no officially documented cmdlet to trigger
# a scan (unlike Defender's Start-MpWDOScan) -- this launches the
# app to the scan screen; the user still clicks "Scan" themselves.
# ============================================================
function Show-MalwarebytesFollowUp {
    Clear-Host
    Write-Host ""
    Write-Host "  Checking for Malwarebytes..." -ForegroundColor Cyan
    Write-Host ""

    $mbState = Get-MalwarebytesState

    if ($mbState -eq "NotInstalled") {
        Draw-Box -ScreenId "13" -Color White -Lines @(
            "  MALWAREBYTES NOT DETECTED                                 ",
            "---",
            "  Malwarebytes Free is a companion scanner that catches      ",
            "  PUPs and adware Defender sometimes misses. It's optional   ",
            "  but recommended -- takes about 5-10 minutes.               "
        )
        Write-Host ""
        $getMb = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Open the Malwarebytes download page now? (Y/N): "
        if ($getMb.ToUpper() -eq "Y") {
            Start-Process $AffiliateMalwarebytes
            Write-Host ""
            Write-Host "  A PERMISSIONS BOX MAY APPEAR during install -- please respond" -ForegroundColor Yellow
            Write-Host "  to it promptly. It will disappear after a few minutes if left" -ForegroundColor Yellow
            Write-Host "  unanswered. If that happens, search 'Malwarebytes' in the" -ForegroundColor Yellow
            Write-Host "  Windows search bar to bring the box back." -ForegroundColor Yellow
            Write-Log -Message "User opened Malwarebytes download page" -Status "INFO"
            Write-Host ""
            Write-Host "  Once it's installed, come back and run Checkup again" -ForegroundColor White
            Write-Host "  to continue with a scan." -ForegroundColor White
        } else {
            Write-Log -Message "User skipped Malwarebytes install" -Status "SKIP"
        }
        Pause-ForUser "  Press Enter or Space to continue..."

    } else {
        # Already installed (FreeCompanion, TrialActive, or Unknown-but-present)
        Draw-Box -ScreenId "73" -Color White -Lines @(
            "  MALWAREBYTES DETECTED ON THIS PC                          ",
            "---",
            "  Checkup can open Malwarebytes now. Run the CUSTOM          ",
            "  SCAN -- it is the only scan where YOU control rootkit      ",
            "  checking, and the only one we could verify checks          ",
            "  rootkits (confirmed on our own test machines).             ",
            "                                                             ",
            "  ONE-TIME CHECK FIRST (once Malwarebytes opens):            ",
            "  Click the gear icon (Settings) -> Security -> make sure    ",
            "  'Potentially unwanted items' is set to ALWAYS. This makes  ",
            "  sure junk programs get offered for removal, not just       ",
            "  listed.                                                    ",
            "                                                             ",
            "  HOW TO RUN THE CUSTOM SCAN:                                ",
            "  1. Next to the Scan button, click the three dots           ",
            "     (do NOT click Scan itself -- that runs a quicker scan   ",
            "     that does NOT check rootkits)                           ",
            "  2. Click Advanced Scan, then Custom Scan                   ",
            "  3. CHECK the box 'Scan for rootkits'                       ",
            "  4. CHECK ALL your drives (C:, D:, and any others)          ",
            "  5. Start the scan -- about 25 minutes to an hour           ",
            "                                                             ",
            "  WHEN IT FINISHES -- THIS PART MATTERS:                     ",
            "  If anything was found, click QUARANTINE right then, on     ",
            "  that results screen. If you close it first, Malwarebytes   ",
            "  only keeps a record -- you would have to scan all over     ",
            "  again to remove anything. Finding is not fixing --         ",
            "  quarantining is fixing.                                    ",
            "                                                             ",
            "  Afterward you can confirm rootkits were checked: open the  ",
            "  scan report -- under 'Scan Options' it should say          ",
            "  'Rootkits: Enabled'.                                       "
        )
        Write-Host ""
        $runMb = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Open Malwarebytes now? (Y/N): "
        if ($runMb.ToUpper() -eq "Y") {
            Write-Host ""
            Write-Host "  A PERMISSIONS BOX MAY APPEAR -- please respond promptly." -ForegroundColor Yellow
            Write-Host "  It will disappear after a few minutes if left unanswered." -ForegroundColor Yellow
            Write-Host "  If that happens, search 'Malwarebytes' in the Windows" -ForegroundColor Yellow
            Write-Host "  search bar to bring it back." -ForegroundColor Yellow
            Write-Host ""

            $mbPaths = @(
                "$env:ProgramFiles\Malwarebytes\Anti-Malware\mbam.exe",
                "${env:ProgramFiles(x86)}\Malwarebytes\Anti-Malware\mbam.exe"
            )
            $mbExe = $mbPaths | Where-Object { Test-Path $_ } | Select-Object -First 1

            if ($mbExe) {
                # FT-22 (2026-07-11): this tool runs elevated, and a program
                # started from an elevated process INHERITS Administrator --
                # so Malwarebytes launched here is already running as admin.
                Start-Process $mbExe
                Write-Host "  Malwarebytes should now be open (with Administrator rights," -ForegroundColor Green
                Write-Host "  inherited from Checkup). Click 'Scan' to check for threats." -ForegroundColor Green
                Write-Log -Message "Launched Malwarebytes at $mbExe (elevated, inherited from tool)" -Status "INFO"
                Write-Host ""
                Write-Host "  The scan may take 5-45 minutes depending on your computer." -ForegroundColor Gray
                Write-Host "  A fast scan on a clean machine is normal." -ForegroundColor Gray

                # FT-11: Malwarebytes trial-specific guidance -- the upgrade
                # nag box and Deep Scan availability are both trial-only
                # behaviors that need explaining, or users may be tempted to
                # pay for an upgrade they don't need, or miss the deeper
                # scan option entirely once the trial ends.
                if ($mbState -eq "TrialActive") {
                    Write-Host ""
                    Draw-Box -ScreenId "47" -Color White -Lines @(
                        "  MALWAREBYTES TRIAL -- WHAT TO EXPECT                     ",
                        "---",
                        "  You may see a box asking you to upgrade to Premium.       ",
                        "  You do NOT need to upgrade -- just click the X to close   ",
                        "  that box. Windows Defender (already explained earlier)    ",
                        "  is your primary protection either way.                    ",
                        "                                                            ",
                        "  The DEEPER scan works during the trial AND on the free    ",
                        "  version after the trial ends -- confirmed on our own test  ",
                        "  machines. To use it: click Scan options, then choose Deep  ",
                        "  Scan or a Custom Scan with all drives checked.             ",
                        "                                                            ",
                        "  AFTER THE TRIAL ENDS: open Windows Security and check      ",
                        "  that Tamper Protection is back ON -- the trial handoff     ",
                        "  can leave it off.                                          "
                    )
                    Write-Log -Message "Malwarebytes trial detected -- showed upgrade-nag and Deep Scan guidance" -Status "INFO"
                }

                # FT-11 extension (2026-07-11, field evidence): on a test PC
                # already scanned CLEAN by Defender and a Malwarebytes quick
                # scan, a deeper scan later found 6 more detections. The quick
                # scan is a start -- the deep scan is the real answer.
                Write-Host ""
                # D-15 (ascii33): "Sleep to Never" REMOVED -- field-verified
                # 2026-07-19: MBAMService holds a SYSTEM power request during
                # scans (powercfg /requests). The PC cannot sleep mid-scan.
                # Screen-off is normal and harmless (observed on two machines).
                Draw-Box -ScreenId "48" -Color White -Lines @(
                    "  AFTER THE CUSTOM SCAN -- RUN THE DEEP SCAN OVERNIGHT      ",
                    "---",
                    "  The Deep Scan examines everything more thoroughly. Run     ",
                    "  it after the Custom Scan -- overnight is perfect.          ",
                    "                                                             ",
                    "  TONIGHT, BEFORE BED:                                       ",
                    "  1. Open Malwarebytes -- three dots next to Scan ->         ",
                    "     Advanced Scan -> Deep Scan                              ",
                    "  2. Plug the computer in to power                           ",
                    "  3. Leave the lid OPEN (on a laptop)                        ",
                    "  4. Start the scan and go to bed                            ",
                    "                                                             ",
                    "  You do NOT need to change any sleep settings --            ",
                    "  Malwarebytes keeps the PC awake by itself while it         ",
                    "  scans. Your screen may go dark to save power; that is      ",
                    "  normal, the scan keeps running underneath. Do not press    ",
                    "  the power button -- just check the results in the          ",
                    "  morning.                                                   ",
                    "                                                             ",
                    "  On a PC with 8 GB of memory or less: run one scan per      ",
                    "  night -- Custom Scan tonight, Deep Scan tomorrow night.    "
                )
                Write-Log -Message "Overnight Deep Scan guidance shown (D-15: verified no settings changes needed)" -Status "INFO"
            } else {
                # FT-22 (2026-07-11): manual-launch fallback now includes the
                # right-click step so it still runs as Administrator.
                Write-Host "  Malwarebytes is installed but wasn't found at the usual" -ForegroundColor Yellow
                Write-Host "  location. To open it with full rights:" -ForegroundColor Yellow
                Write-Host "  1. Click Start and type: Malwarebytes" -ForegroundColor White
                Write-Host "  2. Click it ONCE to select it, then RIGHT-CLICK it" -ForegroundColor White
                Write-Host "  3. Choose 'Run as administrator'" -ForegroundColor White
                Write-Log -Message "Malwarebytes detected but executable not found at expected paths -- manual run-as-admin steps shown" -Status "WARN"
            }
        } else {
            Write-Log -Message "User skipped Malwarebytes scan (already installed, state: $mbState)" -Status "SKIP"
        }
        Pause-ForUser "  Press Enter or Space to continue..."
    }
}

# ============================================================
# STEP 9: POWER CHECK & BATTERY DETECTION
# ============================================================
function Test-PowerStatus {
    Clear-Host
    Write-Host ""
    Write-Host "  Checking power status..." -ForegroundColor Cyan

    try {
        $battery = Get-WmiObject -Class Win32_Battery -ErrorAction SilentlyContinue
        $hasBattery = ($null -ne $battery)
        $global:HasBattery = $hasBattery   # Store globally for power settings screen
        $global:OnBattery = ($hasBattery -and $battery.BatteryStatus -eq 1)
        $batteryPct = if ($hasBattery -and $battery.EstimatedChargeRemaining) { "$($battery.EstimatedChargeRemaining)%" } else { "N/A" }
        $global:BatteryPct = $batteryPct   # Store globally for power settings screen
    } catch {
        $global:OnBattery = $false
        $batteryPct = "Unknown"
        $hasBattery = $false
    }

    Enable-SleepPrevention

    if ($global:OnBattery) {
        Write-Host ""
        Draw-Box -ScreenId "49" -Color White -Lines @(
            "  !  RUNNING ON BATTERY POWER                              ",
            "---",
            "  Battery level: $batteryPct",
            "                                                            ",
            "  Most settings apply in seconds and are safe on battery.  ",
            "                                                            ",
            "  EXCEPTION -- BITLOCKER:                                   ",
            "  BitLocker can take several hours. If the PC loses power   ",
            "  mid-encryption, the drive may be unrecoverable.           ",
            "  Plug in AC power before running BitLocker.                ",
            "                                                            ",
            "  Sleep prevention is now ACTIVE for this session.         "
        )
        Write-Host ""
        Write-Log -Message "Running on battery -- battery level: $batteryPct" -Status "WARN"
        do {
            $cont = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue on battery? (Y = Continue / N = Plug in and relaunch): "
            if ($cont.ToUpper() -eq "N") {
                Write-Host ""
                Write-Host "  Plug in AC power and relaunch the tool." -ForegroundColor Yellow
                Disable-SleepPrevention; Save-Log; exit
            }
        } while ($cont.ToUpper() -ne "Y")
    } else {
        Write-Host ""
        if ($hasBattery) {
            Write-Host "  OK  Plugged into AC power." -ForegroundColor Green
            Write-Host "      Battery: $batteryPct charged and plugged in" -ForegroundColor White
            Write-Host "      Safe to run all settings including BitLocker." -ForegroundColor White
        } else {
            Write-Host "  OK  AC power -- desktop PC (no battery detected)." -ForegroundColor Green
        }
        Write-Host "  OK  Sleep prevention: SET BY THIS TOOL for this session." -ForegroundColor Green
        Write-Host "      Your original sleep setting will be restored automatically when Checkup exits." -ForegroundColor White
        Write-Log -Message "AC power confirmed. Battery present: $hasBattery ($batteryPct). Sleep prevention active." -Status "OK"
        Pause-ForUser "  Press Enter or Space to continue..."
    }
}

# ============================================================
# STEP 10: POWER SETTINGS CHECK
# ============================================================
function Run-PowerSettingsCheck {
    Clear-Host
    Write-Host ""
    Write-Host "  Checking power-related security settings..." -ForegroundColor Cyan
    # Sleep removed (ascii32): per no-Sleep-in-Run rule

    $results = @{}

    # 1. Password on wake
    try {
        $pw = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>$null
        # FT-255 (ascii44): powercfg returns an ARRAY. On an array -match is a
        # FILTER and does NOT populate $Matches -- measured on CGDELL
        # 2026-09-06. Out-String makes it a scalar match, which is the
        # pattern already used at the screen-timeout and battery reads.
        $acVal = if (($pw | Out-String) -match "Current AC Power Setting Index: 0x(\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { $null }
        $results["PasswordOnWake"] = if ($acVal -eq 1) { "REQUIRED -- GOOD" } else { "NOT required -- change recommended" }
    } catch { $results["PasswordOnWake"] = "Unknown" }

    # 2. Fast Startup
    try {
        $fs = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -EA Stop).HiberbootEnabled
        $results["FastStartup"] = if ($fs -eq 0) { "DISABLED -- GOOD" } else { "ENABLED -- change recommended" }
    } catch { $results["FastStartup"] = "Unknown" }

    # 3. Wake on LAN
    # FT-120 (ascii35): ascii34 reported a FALSE "DISABLED -- GOOD" here.
    #  (a) Get-NetAdapterPowerManagement throws CimException on some
    #      hardware (field-confirmed Dell Latitude 5430, 2026-07-26). With
    #      -EA SilentlyContinue the null fell through to the else branch,
    #      so a FAILED CHECK was reported as a PASSED CHECK (Class 1).
    #  (b) The list was filtered to Status -eq "Up", so a disconnected
    #      Ethernet -- exactly where WoL was enabled -- was never examined.
    #  (c) Only WakeOnMagicPacket was read; "Wake on Pattern Match" and
    #      "Wake from S0ix on Magic Packet" were ignored, both Enabled.
    # Primary method is now Get-NetAdapterAdvancedProperty: it works on the
    # affected hardware and matches what the user sees in the GUI.
    # Returns "Unknown" when nothing could be read -- NEVER "GOOD".
    try {
        $adapters = @(Get-NetAdapter -Physical -EA Stop)
        $wolEnabled = $false
        $wolChecked = $false
        foreach ($a in $adapters) {
            $props = @(Get-NetAdapterAdvancedProperty -Name $a.Name -EA SilentlyContinue |
                Where-Object { $_.DisplayName -match 'Wake on Magic Packet|Wake on Pattern Match|Wake from S0ix' })
            if ($props.Count -gt 0) {
                $wolChecked = $true
                foreach ($p in $props) {
                    if ($p.DisplayValue -eq "Enabled") { $wolEnabled = $true }
                }
            } else {
                $pm = Get-NetAdapterPowerManagement -Name $a.Name -EA SilentlyContinue
                if ($pm) {
                    $wolChecked = $true
                    if ($pm.WakeOnMagicPacket -eq "Enabled" -or $pm.WakeOnPattern -eq "Enabled") { $wolEnabled = $true }
                }
            }
        }
        if (-not $wolChecked) {
            $results["WakeOnLAN"] = "Unknown -- could not read adapter settings"
        } elseif ($wolEnabled) {
            $results["WakeOnLAN"] = "ENABLED -- change recommended"
        } else {
            $results["WakeOnLAN"] = "DISABLED -- GOOD"
        }
    } catch { $results["WakeOnLAN"] = "Unknown" }

    # 4. Screen timeout (READ ONLY -- this tool does not change screen timeout)
    # FT-61 (ascii28): both powercfg reads failed on the Dell and the FT-36
    # diagnostic never fired -- the parse could THROW before reaching the
    # logging line (hex-to-Int32 conversion: the 0x80000003 lesson again),
    # and 2>$null hid powercfg's own error text. Fix: capture stderr via
    # 2>&1, convert hex UNSIGNED, treat 0xFFFFFFFF as Never, and log raw
    # output BEFORE anything that can throw.
    try {
        $st = cmd /c "powercfg /query SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 2>&1"
        if (($st | Out-String) -match "Current AC Power Setting Index: 0x([0-9A-Fa-f]+)") {
            $acTimeout = [Convert]::ToUInt32($Matches[1], 16)
            if ($acTimeout -eq [uint32]4294967295) { $acTimeout = [uint32]0 }   # 0xFFFFFFFF = Never
        } else {
            $stRaw = (($st | Select-Object -First 4) -join " | ")
            Write-Log -Message "FT-61 powercfg VIDEOIDLE gave no readable value. Raw: $stRaw" -Status "WARN"
            throw "no readable value from powercfg"
        }
        $minutes = [math]::Round($acTimeout / 60)
        # NOTE: prefix "Found:" makes clear this was READ from system, not set by this tool
        $results["ScreenTimeout"] = if ($acTimeout -eq 0) { "Found: NEVER (your existing setting) -- recommend 5 min: Settings -> System -> Power & sleep" }
                                    elseif ($minutes -le 5) { "Found: ${minutes} min -- GOOD (this is your existing setting -- tool did not change it)" }
                                    else { "Found: ${minutes} min (your existing setting) -- recommend reducing to 5 min: Settings -> System -> Power & sleep" }
    } catch { $results["ScreenTimeout"] = "Could not read -- check manually in Settings -> System -> Power & sleep" }

    # 5. Critical battery action (laptop only -- skip gracefully on desktops)
    # Use $global:HasBattery set during step 9 power check -- avoids re-querying WMI
    try {
        $hasBatteryPS = if ($null -ne $global:HasBattery) { $global:HasBattery } else {
            $null -ne (Get-WmiObject -Class Win32_Battery -EA SilentlyContinue)
        }
        if (-not $hasBatteryPS) {
            $results["CriticalBattery"] = "N/A -- desktop (no battery)"
        } else {
            # FT-61 (ascii28): same rebuild as the screen-timeout read above --
            # 2>&1 capture, unsigned hex, raw output logged BEFORE any throw.
            $cb = cmd /c "powercfg /query SCHEME_CURRENT SUB_BATTERY BATACTIONCRIT 2>&1"
            $cbVal = $null
            if (($cb | Out-String) -match "Current DC Power Setting Index: 0x([0-9A-Fa-f]+)") {
                $cbVal = [Convert]::ToUInt32($Matches[1], 16)
            } else {
                $cbRaw = (($cb | Select-Object -First 6) -join " | ")
                Write-Log -Message "FT-61 powercfg BATACTIONCRIT gave no readable value. Raw: $cbRaw" -Status "WARN"
            }
            $results["CriticalBattery"] = switch ($cbVal) {
                0       { "DO NOTHING -- change to Hibernate recommended" }
                1       { "Sleep -- Hibernate preferred for data safety" }
                2       { "HIBERNATE -- GOOD" }
                3       { "SHUTDOWN -- GOOD" }
                default { "Unknown -- check manually in Power settings" }
            }
        }
    } catch { $results["CriticalBattery"] = "Could not read -- check manually in Power settings" }

    # FT-34 (2026-07-12): warn BEFORE the long screen appears
    Write-Host ""
    Write-Host "  Power settings check complete. The NEXT screen is a long one --" -ForegroundColor Yellow
    Write-Host "  BE SURE TO SCROLL UP TO THE TOP of it before reading." -ForegroundColor Yellow
    Pause-ForUser "  Press Enter or Space to see the power settings review..."

    # Display results
    Clear-Host
    Write-Host ""
    Show-StepHeader -Key "PowerReview" -Section "Your Settings"
    Draw-Box -ScreenId "50" -Color White -Lines @(
        "  POWER SETTINGS -- SECURITY REVIEW                          ",
        "---",
        "  These settings affect your PC's security between sessions. ",
        "  Review each one below -- changes are optional.             ",
        "---",
        "  [1] Password required on wake:   $($results['PasswordOnWake'])",
        "      WHY: Without this, anyone can open your PC from sleep. ",
        "---",
        "  [2] Fast Startup:                $($results['FastStartup'])",
        "      WHY: Fast Startup skips a full shutdown, which means   ",
        "      Windows does not fully reset between sessions. Disabling",
        "      ensures a clean security state every time you boot.     ",
        "---",
        "  [3] Wake on LAN:                 $($results['WakeOnLAN'])",
        "      WHY: Lets your PC be woken up remotely. Wake on LAN and ",
        "      REMOTE DESKTOP are the two 'let someone in from outside'",
        "      features -- almost no home user needs either one, and we",
        "      strongly recommend BOTH be OFF. (Remote Desktop gets its ",
        "      own item on the security checklist coming up.)           ",
        "      IF ANYONE EVER PHONES YOU and asks you to turn remote    ",
        "      access ON or to install a remote-control program --      ",
        "      hang up. That is the single most common scam used        ",
        "      against home computer users today.                       ",
        "---",
        "  [4] Screen timeout (AC power):   $($results['ScreenTimeout'])",
        "      WHY: A screen that never turns off leaves your PC       ",
        "      visually accessible. Set to 5 min in Settings ->        ",
        "      System -> Power & sleep. (Advisory only -- not changed.)",
        "      NOTE: this is DIFFERENT from the temporary stay-awake    ",
        "      protection Checkup turned on for this session --         ",
        "      that one is automatic and undoes itself when the tool    ",
        "      exits. Screen timeout is yours to set once, by hand.     ",
        "---",
        "  [5] Critical battery action:     $($results['CriticalBattery'])",
        "      WHY: If the battery dies mid-operation, open files are  ",
        "      lost unless an action is set. Hibernate saves your      ",
        "      session before power runs out. (Desktop PCs show N/A -- ",
        "      laptops will show current setting and offer to change.)  ",
        "---",
        "  SCROLL DOWN and REVIEW EACH setting above before you        ",
        "  continue -- each one shows its current state and WHY it      ",
        "  matters.                                                     ",
        "---",
        "  Sleep prevention (this session): SET BY THIS TOOL          ",
        "  -- not your previous setting. Your own sleep setting is    ",
        "  put back when the tool exits.                              ",
        "  Normal sleep resumes after you exit or the tool finishes.   "
    )
    Write-Host ""
    Write-Log -Message "Power settings: PW=$($results['PasswordOnWake']) FastStart=$($results['FastStartup']) WOL=$($results['WakeOnLAN']) Screen=$($results['ScreenTimeout']) CritBatt=$($results['CriticalBattery'])" -Status "INFO"

    Write-Host "  Review each setting below and choose Y/N individually." -ForegroundColor Yellow
    Write-Host "  All are optional -- choose what fits your situation." -ForegroundColor Gray
    Write-Host ""

    $powerChoices = @{}

    # 1. Password on wake
    if ($results["PasswordOnWake"] -notmatch "GOOD|N/A") {
        Write-Host "  [1] Password required on wake" -ForegroundColor White
        Write-Host "      Current:  $($results['PasswordOnWake'])" -ForegroundColor Gray
        Write-Host "      Change to: REQUIRED -- prevents unlocked screen access" -ForegroundColor Cyan
        $powerChoices["PasswordOnWake"] = (Read-ValidKey -ValidKeys @("Y","N") -Prompt "Apply? (Y/N): ") -eq "Y"
        Write-Host ""
    } else {
        Write-Host "  [1] Password on wake -- $($results['PasswordOnWake']), no change needed." -ForegroundColor Green
        $powerChoices["PasswordOnWake"] = $false
        Write-Host ""
    }

    # 2. Fast Startup
    if ($results["FastStartup"] -notmatch "GOOD|N/A") {
        Write-Host "  [2] Fast Startup" -ForegroundColor White
        Write-Host "      Current:  $($results['FastStartup'])" -ForegroundColor Gray
        Write-Host "      Change to: DISABLED -- ensures clean boot security state" -ForegroundColor Cyan
        $powerChoices["FastStartup"] = (Read-ValidKey -ValidKeys @("Y","N") -Prompt "Apply? (Y/N): ") -eq "Y"
        Write-Host ""
    } else {
        Write-Host "  [2] Fast Startup -- $($results['FastStartup']), no change needed." -ForegroundColor Green
        $powerChoices["FastStartup"] = $false
        Write-Host ""
    }

    # 3. Wake on LAN
    if ($results["WakeOnLAN"] -notmatch "GOOD|N/A") {
        Write-Host "  [3] Wake on LAN" -ForegroundColor White
        Write-Host "      Current:  $($results['WakeOnLAN'])" -ForegroundColor Gray
        Write-Host "      Change to: DISABLED -- removes remote wake attack surface" -ForegroundColor Cyan
        Write-Host "      Note: Only disable if you do not use remote wake features." -ForegroundColor DarkYellow
        $powerChoices["WakeOnLAN"] = (Read-ValidKey -ValidKeys @("Y","N") -Prompt "Apply? (Y/N): ") -eq "Y"
        Write-Host ""
    } else {
        Write-Host "  [3] Wake on LAN -- $($results['WakeOnLAN']), no change needed." -ForegroundColor Green
        $powerChoices["WakeOnLAN"] = $false
        Write-Host ""
    }

    # 4. Screen timeout (advisory only)
    Write-Host "  [4] Screen timeout: $($results['ScreenTimeout'])" -ForegroundColor Yellow
    Write-Host "      Advisory only -- set manually in:" -ForegroundColor Gray
    Write-Host "      Settings -> System -> Power & sleep -> Screen timeout" -ForegroundColor Gray
    Write-Host ""

    # 5. Critical battery (skip if desktop)
    if ($results["CriticalBattery"] -notmatch "GOOD|N/A|HIBERNATE|SHUTDOWN") {
        Write-Host "  [5] Critical battery action" -ForegroundColor White
        Write-Host "      Current:  $($results['CriticalBattery'])" -ForegroundColor Gray
        Write-Host "      Change to: HIBERNATE -- saves your session if battery dies" -ForegroundColor Cyan
        $powerChoices["CriticalBattery"] = (Read-ValidKey -ValidKeys @("Y","N") -Prompt "Apply? (Y/N): ") -eq "Y"
        Write-Host ""
    } else {
        Write-Host "  [5] Critical battery: $($results['CriticalBattery']), no change needed." -ForegroundColor Green
        $powerChoices["CriticalBattery"] = $false
        Write-Host ""
    }

    Apply-PowerSettings -Results $results -Choices $powerChoices
    Pause-ForUser "  Power settings complete. Press Enter or Space to continue..."
}

function Apply-PowerSettings {
    param($Results, $Choices)
    Write-Host ""

    # FT-128 (ascii37): SAY WHAT WAS FOUND AND WHAT IT IS NOW. Field notes 8
    # and 9 (2026-07-27): "checking power status screen -- still doesn't say
    # what it found and what it changed it to. Fix this" and "same problems in
    # power settings screen. apparently nothing was fixed from the previous
    # two test runs ascii32 & 33."
    # Note 9 also asks whether ascii36 was built from the wrong file. It was
    # not: ascii35 and ascii36 were scoped to Wake on LAN only (FT-120 and
    # FT-120b) and never touched these lines, so nothing was reverted -- the
    # item had simply never been picked up. Recorded plainly because "nothing
    # was fixed" deserves a straight answer.
    # The old messages announced an intention ("Password on wake -- enabled")
    # without ever naming the previous value or re-reading to confirm the
    # change landed. That is the same shape as FT-120, which reported success
    # in this very function while changing nothing. Each item now prints
    # "Was: <found>  ->  Now: <re-read>", and the re-read is what is logged.
    if ($Choices["PasswordOnWake"]) {
        try {
            $ggWas = [string]$Results["PasswordOnWake"]
            powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null
            powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null
            powercfg /S SCHEME_CURRENT | Out-Null
            $ggNow = "could not re-read -- check manually"
            try {
                $ggQ = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>&1
                # FT-255 (ascii44): powercfg returns an ARRAY. On an array -match is a
        # FILTER and does NOT populate $Matches -- measured on CGDELL
        # 2026-09-06. Out-String makes it a scalar match, which is the
        # pattern already used at the screen-timeout and battery reads.
                if (($ggQ | Out-String) -match "Current AC Power Setting Index: 0x(\w+)") {
                    $ggNow = if ([Convert]::ToUInt32($Matches[1], 16) -eq 1) { "REQUIRED" } else { "still NOT required" }
                } else {
                    # FT-246/FT-256 (ascii44): the parse found nothing. Log the RAW
                    # output so the next field run says WHY, instead of only
                    # "could not re-read". Measured on CGDELL 2026-09-06: this
                    # query can return the scheme header and no setting block at
                    # all, which is FT-256 and is not fixed by any parse change.
                    $ggRaw = ((($ggQ | Out-String) -replace "\s+", " ").Trim())
                    if ($ggRaw.Length -gt 300) { $ggRaw = $ggRaw.Substring(0, 300) + "..." }
                    Write-Log -Message "Password on wake re-read found no setting index (FT-256). Raw powercfg output: $ggRaw" -Status "WARN"
                }
            } catch {
                Write-Log -Message "Password on wake re-read threw: $_" -Status "WARN"
            }
            Write-Host "  OK  Password on wake" -ForegroundColor Green
            Write-Host "      Was:  $ggWas" -ForegroundColor Gray
            Write-Host "      Now:  $ggNow" -ForegroundColor Cyan
            Write-Log -Message "Password on wake: was '$ggWas' -> now '$ggNow'" -Status "APPLIED"
        } catch { Write-Host "  ERROR Password on wake: $_" -ForegroundColor Red; Write-Log -Message "Password on wake error: $_" -Status "ERROR" }
    } else { Write-Host "  --  Password on wake -- skipped, nothing changed" -ForegroundColor Gray }

    if ($Choices["FastStartup"]) {
        try {
            $ggWas = [string]$Results["FastStartup"]
            Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name HiberbootEnabled -Value 0 -Type DWord -Force -EA Stop
            $ggNow = "could not re-read -- check manually"   # FT-128 (ascii37)
            try {
                $ggV = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -EA Stop).HiberbootEnabled
                $ggNow = if ($ggV -eq 0) { "DISABLED" } else { "still enabled" }
            } catch {}
            Write-Host "  OK  Fast Startup" -ForegroundColor Green
            Write-Host "      Was:  $ggWas" -ForegroundColor Gray
            Write-Host "      Now:  $ggNow" -ForegroundColor Cyan
            Write-Log -Message "Fast Startup: was '$ggWas' -> now '$ggNow'" -Status "APPLIED"
        } catch { Write-Host "  ERROR Fast Startup: $_" -ForegroundColor Red; Write-Log -Message "Fast Startup error: $_" -Status "ERROR" }
    } else { Write-Host "  --  Fast Startup -- skipped, nothing changed" -ForegroundColor Gray }

    if ($Choices["WakeOnLAN"]) {
        try {
            # FT-120 (ascii35): ascii34 filtered to Status -eq "Up", used
            # Set-NetAdapterPowerManagement with -EA SilentlyContinue, then
            # printed "OK ... disabled" unconditionally -- so on hardware
            # where that cmdlet throws it reported success having changed
            # nothing. Now every physical adapter is attempted, all three
            # wake properties are cleared, and the message reflects reality.
            $changed = 0
            $failed  = 0
            foreach ($a in @(Get-NetAdapter -Physical -EA Stop)) {
                foreach ($dn in @('Wake on Magic Packet','Wake on Pattern Match','Wake from S0ix on Magic Packet')) {
                    $prop = Get-NetAdapterAdvancedProperty -Name $a.Name -DisplayName $dn -EA SilentlyContinue
                    if ($prop -and $prop.DisplayValue -eq "Enabled") {
                        try {
                            Set-NetAdapterAdvancedProperty -Name $a.Name -DisplayName $dn -DisplayValue "Disabled" -NoRestart -EA Stop
                            $changed++
                        } catch { $failed++; Write-Log -Message "WoL disable failed on $($a.Name) / $dn : $_" -Status "ERROR" }
                    }
                }
            }
            $ggWas = [string]$Results["WakeOnLAN"]   # FT-128 (ascii37)
            if ($failed -gt 0) {
                Write-Host "  WARN Wake on LAN" -ForegroundColor Yellow
                Write-Host "      Was:  $ggWas" -ForegroundColor Gray
                Write-Host "      Now:  $changed setting(s) turned off, $failed could NOT be changed" -ForegroundColor Yellow
                Write-Host "      Takes effect after your next restart." -ForegroundColor Gray
                Write-Log -Message "Wake on LAN: was '$ggWas' -> $changed disabled, $failed failed" -Status "APPLIED"
            } elseif ($changed -gt 0) {
                Write-Host "  OK  Wake on LAN" -ForegroundColor Green
                Write-Host "      Was:  $ggWas" -ForegroundColor Gray
                Write-Host "      Now:  turned off ($changed setting(s))" -ForegroundColor Cyan
                Write-Host "      Takes effect after your next restart." -ForegroundColor Gray
                Write-Log -Message "Wake on LAN: was '$ggWas' -> disabled ($changed settings)" -Status "APPLIED"
            } else {
                Write-Host "  OK  Wake on LAN -- already off, nothing to change" -ForegroundColor Green
                Write-Log -Message "Wake on LAN already disabled" -Status "APPLIED"
            }
        } catch { Write-Host "  ERROR Wake on LAN: $_" -ForegroundColor Red; Write-Log -Message "Wake on LAN error: $_" -Status "ERROR" }
    } else { Write-Host "  --  Wake on LAN -- skipped" -ForegroundColor Gray }

    if ($Choices["CriticalBattery"]) {
        try {
            powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_BATTERY BATACTIONCRIT 2 | Out-Null
            powercfg /S SCHEME_CURRENT | Out-Null
            Write-Host "      Was:  $([string]$Results['CriticalBattery'])" -ForegroundColor Gray   # FT-128 (ascii37)
            Write-Host "  OK  Critical battery ACTION set: if the battery ever runs" -ForegroundColor Green
            Write-Host "      critically low, the PC will HIBERNATE (save your session" -ForegroundColor Green
            Write-Host "      safely first). NOTE: this does NOT turn the hibernate" -ForegroundColor Green
            Write-Host "      feature itself on or off -- it only sets what happens" -ForegroundColor Green
            Write-Host "      when the battery is nearly empty." -ForegroundColor Green
            Write-Log -Message "Critical battery ACTION set to Hibernate (FT-44: does not toggle the hibernate feature itself)" -Status "APPLIED"
        } catch { Write-Host "  ERROR Critical battery: $_" -ForegroundColor Red; Write-Log -Message "Critical battery error: $_" -Status "ERROR" }
    } else { Write-Host "  --  Critical battery -- skipped" -ForegroundColor Gray }
}

# ============================================================
# KNOWN BAD APPS (PUP publishers)
# Trusted publishers are whitelisted and will NOT be flagged
# ============================================================
$TrustedPublishers = @(
    # Microsoft & Windows
    "Microsoft Corporation", "Microsoft Windows", "Microsoft",
    # Intel
    "Intel Corporation", "Intel(R) Corporation", "Intel(R) pGFX", "Intel",
    # GPU / Graphics
    "NVIDIA Corporation", "NVIDIA",
    "AMD", "Advanced Micro Devices",
    # PC Manufacturers / OEMs
    "Dell", "Dell Inc", "HP", "HP Inc.", "Hewlett-Packard", "Hewlett Packard",
    "Lenovo", "ASUS", "ASUSTek", "Acer", "Samsung", "LG Electronics",
    "MSI", "Micro-Star International", "Razer", "Corsair", "GIGABYTE",
    # Audio / Network / Peripherals
    "Qualcomm", "Qualcomm Technologies",
    "Realtek Semiconductor", "Realtek",
    "Logitech", "SteelSeries", "Razer USA",
    # Printers / Scanners
    "Brother Industries", "Brother", "Brother International",
    "Canon", "Canon Inc.", "Epson", "Seiko Epson",
    "Xerox", "Lexmark", "Ricoh", "Kyocera",
    "HP LaserJet", "HP DeskJet", "HP OfficeJet",
    # USB / Connectivity utilities (OEM-bundled)
    "Netzlink Informationstechnik", "Netzlink",   # httpUsbBridge / USB Network Gate publisher
    "Electronic Team", "Electronic Team Inc",      # USB over Network / httpUsbBridge
    "FabulaTech", "FabulaTech LLC",                # USB redirectors
    "IOGEAR", "Plugable Technologies", "Plugable",
    "StarTech.com", "StarTech",
    # Apple / Google
    "Apple Inc.", "Google LLC", "Google Inc.",
    # Browsers / Productivity
    "Mozilla Corporation", "Mozilla Foundation",
    "Adobe", "Adobe Systems",
    "LibreOffice", "The Document Foundation",
    "OpenOffice", "Apache Software Foundation",
    # Security / Utilities
    "Malwarebytes Corporation", "Malwarebytes",
    "Zoom Video Communications",
    # Gaming
    "Valve Corporation", "Epic Games", "EA Games", "Electronic Arts",
    "Ubisoft", "Activision", "Blizzard Entertainment",
    # Cloud / Sync
    "Dropbox", "Dropbox Inc.", "Box Inc.",
    "Slack Technologies",
    # Communication / Email
    "Proton AG", "ProtonMail", "Proton Mail", "Proton",
    "Zoom Video Communications", "Zoom",
    "Microsoft Teams", "Skype",
    # Remote Access (legitimate)
    "Google LLC",  # Chrome Remote Desktop
    "RealVNC", "TeamViewer", "AnyDesk",
    # Card / Hobby software
    "Software Enterprises",  # Convention card editors
    "Bridge Baron", "Deep Finesse",
    # Brother specific
    "Brother Industries", "Brother",
    "Brother PowerEngage", "PowerEngage"
)

# AV products based in Russia or China -- strong uninstall recommendation
$HighRiskAVList = @(
    "Kaspersky","KAV","KIS","Kaspersky Lab",
    "Dr.Web","drweb",
    "360 Total Security","Qihoo","360 Security",
    "Baidu Antivirus","Baidu",
    "Tencent","Tencent Security",
    "Rising Antivirus","Rising Internet Security",
    "Comodo"   # flagged for deceptive practices
)

$KnownBadApps = @(
    "Fortect","Reimage","MyCleanPC","OneLaunch","Wave Browser",
    "WaveBrowser","AppSuite","PC Optimizer","Driver Booster",
    "Driver Updater","WinZip Driver","Advanced SystemCare","IObit",
    "PC Accelerate","PC HelpSoft","Segurazo","TotalAV Toolbar",
    "SearchMine","Search Mine","MySearch","MyWay","Conduit",
    "BrowserModifier","Adware","PUP.Optional","OpenCandy",
    "Babylon","Ask Toolbar","Mindspark","Fun Web Products"
)

# ============================================================
# STEP 11: APPS AUDIT
# ============================================================
function Run-AppsAudit {
    Clear-Host
    Write-Host ""
    Write-Host "  Running Apps Audit -- please wait..." -ForegroundColor Cyan
    Write-Log -Message "=== Apps Audit Started ===" -Status "START"

    $installedApps = [System.Collections.Generic.List[PSCustomObject]]::new()
    $cutoffDate = (Get-Date).AddDays(-90)

    $regPaths = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )

    foreach ($path in $regPaths) {
        try {
            Get-ItemProperty $path -ErrorAction SilentlyContinue |
            Where-Object { $_.DisplayName -and $_.DisplayName -ne "" } |
            ForEach-Object {
                $lastUsed = $null
                if ($_.InstallDate) {
                    try { $lastUsed = [datetime]::ParseExact($_.InstallDate, "yyyyMMdd", $null) } catch {}
                }
                $installedApps.Add([PSCustomObject]@{
                    Name        = $_.DisplayName
                    Publisher   = if ($_.Publisher) { $_.Publisher } else { "" }
                    InstallDate = $lastUsed
                    Source      = "Win32"
                    UninstallCmd= $_.UninstallString
                })
            }
        } catch {}
    }

    try {
        Get-AppxPackage -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -notmatch "^Microsoft\." -and $_.SignatureKind -ne "System" } |
        ForEach-Object {
            $installedApps.Add([PSCustomObject]@{
                Name         = $_.Name
                Publisher    = $_.Publisher
                InstallDate  = $null
                Source       = "Store/UWP"
                UninstallCmd = "Remove-AppxPackage -Package '$($_.PackageFullName)'"
            })
        }
    } catch {}

    $redApps    = [System.Collections.Generic.List[PSCustomObject]]::new()
    $yellowApps = [System.Collections.Generic.List[PSCustomObject]]::new()
    $greenApps  = [System.Collections.Generic.List[PSCustomObject]]::new()

    foreach ($app in $installedApps) {
        # Check if publisher is trusted -- skip flagging if so
        $isTrusted = $false
        if ($app.Publisher) {
            foreach ($trusted in $TrustedPublishers) {
                if ($app.Publisher -match [regex]::Escape($trusted)) { $isTrusted = $true; break }
            }
        }

        $isBad = $false
        if (-not $isTrusted) {
            foreach ($bad in $KnownBadApps) {
                if ($app.Name -match [regex]::Escape($bad) -or ($app.Publisher -and $app.Publisher -match [regex]::Escape($bad))) {
                    $isBad = $true; break
                }
            }
        }

        if ($isBad) {
            $redApps.Add($app)
        } elseif ($isTrusted) {
            # Never flag trusted publisher apps as unused -- add to green
            $greenApps.Add($app)
        } elseif ($app.InstallDate -and $app.InstallDate -lt $cutoffDate) {
            $yellowApps.Add($app)
        } else {
            $greenApps.Add($app)
        }
    }

    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "51" -Color White -Lines @(
        "  APPS AUDIT RESULTS                                          ",
        "---",
        "  RED    = Known suspicious/PUP publisher -- review now       ",
        "  YELLOW = Not used in 90+ days -- consider removing          ",
        "  GREEN  = Recently installed or used -- no action needed     "
    )
    Write-Host ""

    if ($redApps.Count -gt 0) {
        Write-Host "  ----------------------------------------------------------" -ForegroundColor Red
        Write-Host "  RED -- REVIEW IMMEDIATELY ($($redApps.Count) found)" -ForegroundColor Red
        Write-Host "  ----------------------------------------------------------" -ForegroundColor Red
        foreach ($app in $redApps) {
            Write-Host "  * $($app.Name)" -ForegroundColor Red
            if ($app.Publisher) { Write-Host "    Publisher: $($app.Publisher)" -ForegroundColor DarkRed }
            Write-Host "    Recommendation: Uninstall. See Guide: Phase 2" -ForegroundColor DarkRed
        }
        Write-Host ""
        # FIX: Join-String -> -join for PS 5.1 compatibility
        $redNames = ($redApps | ForEach-Object { $_.Name }) -join ", "
        Write-Log -Message "RED apps found: $redNames" -Status "WARN"
    } else {
        Write-Host "  RED -- No known suspicious apps found." -ForegroundColor Green
        Write-Host ""
    }

    if ($yellowApps.Count -gt 0) {
        Write-Host "  ----------------------------------------------------------" -ForegroundColor Yellow
        Write-Host "  YELLOW -- NOT USED IN 90+ DAYS ($($yellowApps.Count) found)" -ForegroundColor Yellow
        Write-Host "  ----------------------------------------------------------" -ForegroundColor Yellow
        foreach ($app in $yellowApps) {
            $daysSince = if ($app.InstallDate) { [int]((Get-Date) - $app.InstallDate).TotalDays } else { "Unknown" }
            Write-Host "  * $($app.Name)" -ForegroundColor Yellow
            Write-Host "    Last activity: ~$daysSince days ago" -ForegroundColor DarkYellow
        }
        Write-Host ""
        Write-Log -Message "YELLOW apps (90+ days): $($yellowApps.Count) found" -Status "INFO"
    } else {
        Write-Host "  YELLOW -- No apps unused for 90+ days found." -ForegroundColor Green
        Write-Host ""
    }

    Write-Host "  GREEN -- $($greenApps.Count) recently used or installed apps -- no action needed." -ForegroundColor Green
    Write-Host ""

    # Uninstall prompts -- RED
    if ($redApps.Count -gt 0) {
        Clear-Host
        Write-Host ""
        Write-Host "  ----------------------------------------------------------" -ForegroundColor Red
        Write-Host "  UNINSTALL -- Suspicious Apps" -ForegroundColor Red
        Write-Host "  Your approval is required for each." -ForegroundColor Gray
        Write-Host "  ----------------------------------------------------------" -ForegroundColor Red
        Write-Host ""

        foreach ($app in $redApps) {
            Write-Host "  App: $($app.Name)" -ForegroundColor White
            if ($app.Publisher) { Write-Host "  Publisher: $($app.Publisher)" -ForegroundColor Gray }
            Write-Host "  ! Matches a known suspicious publisher. See Guide: Phase 2" -ForegroundColor Red
            Write-Host ""
            $uninstall = Read-ValidKey -ValidKeys @("Y","N","S") -Prompt "Uninstall $($app.Name)? (Y = Yes / N = Skip / S = Skip all): "
            if ($uninstall.ToUpper() -eq "S") {
                Write-Log -Message "User chose to skip all uninstalls" -Status "SKIP"
                break
            }
            if ($uninstall.ToUpper() -eq "Y") {
                try {
                    if ($app.Source -eq "Store/UWP") {
                        Invoke-Expression $app.UninstallCmd -ErrorAction Stop
                        Write-Host "  OK  Removed: $($app.Name)" -ForegroundColor Green
                        Write-Log -Message "Uninstalled: $($app.Name)" -Status "REMOVED"
                    } elseif ($app.UninstallCmd) {
                        Start-Process cmd -ArgumentList "/c `"$($app.UninstallCmd)`"" -Wait -ErrorAction Stop
                        Write-Host "  OK  Uninstall launched for: $($app.Name)" -ForegroundColor Green
                        Write-Log -Message "Uninstall launched: $($app.Name)" -Status "REMOVED"
                    } else {
                        Write-Host "  Manual uninstall needed: Settings -> Apps -> Installed apps" -ForegroundColor Yellow
                        Write-Log -Message "Manual uninstall needed: $($app.Name)" -Status "MANUAL"
                    }
                } catch {
                    Write-Host "  Error during uninstall: $_" -ForegroundColor Red
                    Write-Host "  Try: Settings -> Apps -> Installed apps -> uninstall manually." -ForegroundColor Gray
                    Write-Log -Message "Uninstall error for $($app.Name): $_" -Status "ERROR"
                }
            } else {
                Write-Log -Message "Skipped uninstall: $($app.Name)" -Status "SKIP"
            }
            Write-Host ""
        }
    }

    if ($yellowApps.Count -gt 0) {
        Write-Host ""
        $reviewYellow = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Review unused apps for removal? (Y/N): "
        if ($reviewYellow.ToUpper() -eq "Y") {
            Write-Host ""
            foreach ($app in $yellowApps) {
                $daysSince = if ($app.InstallDate) { [int]((Get-Date) - $app.InstallDate).TotalDays } else { "Unknown" }
                Write-Host "  App: $($app.Name)" -ForegroundColor White
                Write-Host "  Last activity: ~$daysSince days ago" -ForegroundColor Gray
                $uninstall = Read-ValidKey -ValidKeys @("Y","N","S") -Prompt "Uninstall? (Y = Yes / N = Skip / S = Skip remaining): "
                if ($uninstall.ToUpper() -eq "S") { Write-Log -Message "User skipped remaining yellow app review" -Status "SKIP"; break }
                if ($uninstall.ToUpper() -eq "Y") {
                    try {
                        if ($app.Source -eq "Store/UWP") {
                            Invoke-Expression $app.UninstallCmd -ErrorAction Stop
                            Write-Host "  OK  Removed: $($app.Name)" -ForegroundColor Green
                            Write-Log -Message "Uninstalled unused app: $($app.Name)" -Status "REMOVED"
                        } elseif ($app.UninstallCmd) {
                            Start-Process cmd -ArgumentList "/c `"$($app.UninstallCmd)`"" -Wait -ErrorAction Stop
                            Write-Host "  OK  Uninstall launched for: $($app.Name)" -ForegroundColor Green
                            Write-Log -Message "Uninstall launched (unused): $($app.Name)" -Status "REMOVED"
                        } else {
                            Write-Host "  Manual uninstall needed: Settings -> Apps -> Installed apps" -ForegroundColor Yellow
                            Write-Log -Message "Manual uninstall needed (unused): $($app.Name)" -Status "MANUAL"
                        }
                    } catch {
                        Write-Host "  Error: $_" -ForegroundColor Red
                        Write-Log -Message "Uninstall error (unused) $($app.Name): $_" -Status "ERROR"
                    }
                } else { Write-Log -Message "Skipped removal of unused app: $($app.Name)" -Status "SKIP" }
                Write-Host ""
            }
        }
    }

    Write-Log -Message "=== Apps Audit Complete ===" -Status "DONE"
    Pause-ForUser "  Apps Audit complete. Press Enter or Space to continue..."
}

# ============================================================
# SETTINGS DEFINITIONS (19 settings)
# ============================================================
$Settings = @(
    [PSCustomObject]@{ ID=1;  Name="Windows Update";                    Description="Ensures security patches are current and auto-update is on.";                              GuideRef="Phase 1, Step 1";          Selected=$true;  RequiresAdmin=$false; SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=2;  Name="Defender Real-Time VP (Virus Protection)";     Description="Your primary virus and malware shield. Should always be On.";                              GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=3;  Name="Tamper Protection (Defender)";        Description="Prevents malware from disabling Defender. Manual toggle required in Windows Security.";   GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$false; SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=4;  Name="SmartScreen";                       Description="Blocks known malicious websites and downloads.";                                          GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=5;  Name="Defender Periodic Scanning";        Description="Enables Defender background scans if a 3rd-party AV is your primary protection.";        GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=6;  Name="Edge Phishing Protection (all 3)";       Description="Warns about password reuse, unsafe password storage, and malicious sites in Microsoft Edge.";               GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=7;  Name="Defender Firewall Protection (all profiles)";   Description="Network traffic shield -- Domain, Private, and Public profiles all enabled.";            GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=8;  Name="BitLocker / Device Encryption";     Description="Encrypts your drive. Protects data if PC is lost or stolen.";                            GuideRef="Phase 1, Step 3";          Selected=$false; RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=9;  Name="Windows Hello (check only)";        Description="Checks if PIN or biometrics are configured. Setup done manually -- see Guide.";          GuideRef="Phase 1, Step 4";          Selected=$true;  RequiresAdmin=$false; SkipOnHome=$false; CanAuto=$false; SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=10; Name="Remote Desktop -- Disable";         Description="Stops other PCs connecting IN to this one. Windows 11 Home cannot accept incoming connections at all, so there is nothing to turn off there.";                    GuideRef="Keep vs. Disable Table";   Selected=$false; RequiresAdmin=$true;  SkipOnHome=$true;  CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=11; Name="Advertising ID -- Turn Off";        Description="Stops Windows from tracking you for ad targeting.";                                      GuideRef="Keep vs. Disable Table";   Selected=$true;  RequiresAdmin=$false; SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=12; Name="Diagnostic Data -- Required Only";  Description="Limits data sent to Microsoft to the minimum required.";                                 GuideRef="Keep vs. Disable Table";   Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=13; Name="Edge Startup Boost and Background"; Description="Stops Edge pre-loading at boot and running in background after close. Saves RAM.";       GuideRef="Phase 1, Step 6, Part D"; Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=14; Name="Windows Widgets -- Disable";        Description="Disables news/weather panel that runs background Edge processes.";                       GuideRef="Phase 1, Step 6, Part F"; Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=15; Name="Edge Password Saving -- Disable";   Description="Turns off Edge password storage. Use a dedicated password manager instead. Check manually: Edge -> Settings -> Profiles -> Passwords.";            GuideRef="Phase 1, Step 6, Part I"; Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=16; Name="Memory Integrity (Core Isolation)"; Description="Blocks untrusted code from high-security processes. RESTART required after enabling.";  GuideRef="Phase 1, Step 2";          Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$true;  Status='Pending' },
    [PSCustomObject]@{ ID=17; Name="Password Required on Wake";         Description="Requires password when PC wakes from sleep. Prevents unlocked screen access.";          GuideRef="Keep vs. Disable Table";   Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=18; Name="Fast Startup -- Disable";           Description="Fast Startup skips a full shutdown. Disabling ensures a clean security state on boot.";  GuideRef="Keep vs. Disable Table";   Selected=$true;  RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' },
    [PSCustomObject]@{ ID=19; Name="Wake on LAN -- Disable";            Description="Prevents PC from being remotely woken over the network. Disable if not needed.";         GuideRef="Keep vs. Disable Table";   Selected=$false; RequiresAdmin=$true;  SkipOnHome=$false; CanAuto=$true;  SecurityCritical=$false; Status='Pending' }
)

$GoodPatterns = "GOOD|ALL ON|ENCRYPTED|CONFIGURED|Required Only|primary AV|N/A on Home|Already"

# ============================================================
# STATUS CHECKS
# ============================================================
# ============================================================
# MALWAREBYTES STATE DETECTION
# ============================================================
function Get-TamperProtectionState {
    # FT-105 (ascii33): primary = Get-MpComputerStatus IsTamperProtected
    # (field-verified True on Dell while registry method said Unknown).
    # Fallback = registry. "Unknown" only when BOTH methods fail.
    # Returns: "On" / "Off" / "Unknown"
    try {
        $mpTP = (Get-MpComputerStatus -EA Stop).IsTamperProtected
        if ($mpTP -eq $true)  { return "On" }
        if ($mpTP -eq $false) { return "Off" }
    } catch { }
    try {
        $tp = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Defender\Features" -Name "TamperProtection" -EA Stop
        switch ($tp.TamperProtection) {
            5 { return "On" }
            4 { return "Off" }
            0 { return "Off" }
            default { return "Unknown" }
        }
    } catch { return "Unknown" }
}

function Get-MalwarebytesState {
    # Returns: NotInstalled / FreeCompanion / TrialActive / Unknown
    #
    # FreeCompanion = MB Free installed -- Defender is still primary RT protection
    # TrialActive   = MB Premium Trial active -- took over RT from Defender
    #
    # DETECTION METHOD (revised ascii20):
    #   The productState 0x1000 bit is NOT reliable -- MB Free also sets it on some
    #   systems (confirmed HP Laptop 17-by1xxx: MB Free productState=0x061000).
    #
    #   Primary: Check Defender RT directly via Get-MpComputerStatus.
    #     If Defender RT is ON  -> MB is FreeCompanion regardless of productState
    #     If Defender RT is OFF -> MB likely took over -> check further for TrialActive
    #
    #   Secondary (when Defender RT is off): firewall registration + service state
    try {
        # Step 1: IS MALWAREBYTES INSTALLED?
        #
        # FT-140 (ascii39): THIS USED TO ASK SecurityCenter2 AND NOTHING ELSE --
        # "not registered in SC2" was taken to mean "not installed".
        # MALWAREBYTES DEREGISTERS ITSELF FROM SC2 WHEN ITS TRIAL EXPIRES, so
        # that test fails on every machine past day 14.
        # Field-confirmed on two machines, 2026-07-29: the Dell has MB 5.6.3.277
        # installed with MBAMService running, is absent from SC2, and Checkup
        # reported NOT DETECTED and offered to download software already on the
        # PC. Sandy, still registered (productState 393216), was detected fine.
        # THAT IS WHY THIS SURVIVED 38 BUILDS: the bug is invisible during
        # evaluation and universal afterwards. Every user reaches trial expiry,
        # and no test run had ever crossed it.
        # FOUR INDEPENDENT CHECKS, any one of which proves installation. SC2 is
        # still consulted, but only for what it actually means further down --
        # whether MB is currently registered as an antivirus product -- and
        # never again as the installed test.
        $avProducts = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
        $mbAV = $avProducts | Where-Object { $_.displayName -match "Malwarebytes" }

        $mbInstalled = $false
        $mbHow = ""
        if ($mbAV) { $mbInstalled = $true; $mbHow = "registered in SecurityCenter2" }
        # (b) The service MB installs and leaves running regardless of licence
        #     state. This is the one that catches the trial-expired machine.
        if (-not $mbInstalled) {
            try {
                $mbSvcChk = Get-Service -Name "MBAMService" -EA Stop
                if ($mbSvcChk) { $mbInstalled = $true; $mbHow = "MBAMService present (status: " + $mbSvcChk.Status + ")" }
            } catch {}
        }
        # (c) Uninstall entries -- BOTH hives. A 32-bit installer on 64-bit
        #     Windows lands in WOW6432Node, and checking one hive only is how
        #     half-detections happen.
        if (-not $mbInstalled) {
            foreach ($mbHive in @("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
                                  "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*")) {
                try {
                    $mbReg = Get-ItemProperty -Path $mbHive -EA SilentlyContinue |
                             Where-Object { $_.DisplayName -match "Malwarebytes" }
                    if ($mbReg) { $mbInstalled = $true; $mbHow = "uninstall entry found"; break }
                } catch {}
            }
        }
        # (d) The program itself on disk.
        if (-not $mbInstalled) {
            foreach ($mbPath in @("$env:ProgramFiles\Malwarebytes\Anti-Malware\mbam.exe",
                                  "${env:ProgramFiles(x86)}\Malwarebytes\Anti-Malware\mbam.exe")) {
                try { if (Test-Path $mbPath) { $mbInstalled = $true; $mbHow = "program file present"; break } } catch {}
            }
        }

        if (-not $mbInstalled) { return "NotInstalled" }
        if (-not $mbAV) {
            # Installed but not registered as an AV -- the normal state once the
            # 14-day trial has expired. Logged so the field can see WHICH check
            # found it, rather than having to infer it from behaviour.
            try { Write-Log -Message ("Malwarebytes detected by fallback (" + $mbHow + ") -- installed but NOT registered in SecurityCenter2. Normal after the 14-day trial expires (FT-140).") -Status "INFO" } catch {}
        }

        # Step 2: Check Defender real-time state directly -- most reliable source of truth
        try {
            $mp = Get-MpComputerStatus -EA Stop
            $defenderRT = $mp.RealTimeProtectionEnabled
        } catch {
            $defenderRT = $false
        }

        if ($defenderRT) {
            # Defender RT is ON -- MB is not taking over real-time, it is a companion
            return "FreeCompanion"
        }

        # Step 3: Defender RT is OFF -- check if MB Premium Trial actually took over
        $mbPremium = $false

        # MB WFC (Windows Firewall Control) only registers as FirewallProduct during Premium Trial
        try {
            $fwProducts = Get-WmiObject -Namespace "root\SecurityCenter2" -Class FirewallProduct -EA SilentlyContinue
            $mbFW = $fwProducts | Where-Object { $_.displayName -match "Malwarebytes" }
            if ($mbFW) { $mbPremium = $true }
        } catch {}

        # MBAMService running + Defender RT off is a strong indicator of Premium Trial
        try {
            $mbSvc = Get-Service "MBAMService" -EA Stop
            if ($mbSvc.Status -eq "Running") { $mbPremium = $true }
        } catch {}

        # FT-37 (2026-07-12): was "return if (...)" -- INVALID PowerShell that
        # threw at runtime, got swallowed by the outer catch, and made this
        # function return "Unknown" whenever Defender RT was off. That single
        # line caused BOTH field-reported Defender false alarms (state:
        # Unknown in the 2026-07-11 logs, Dell Latitude 5430).
        if ($mbPremium) { return "TrialActive" } else { return "FreeCompanion" }

    } catch { return "Unknown" }
}

function Get-AllStatuses {
    foreach ($s in $Settings) {
        $s | Add-Member -NotePropertyName Status -NotePropertyValue "Checking..." -Force -ErrorAction SilentlyContinue
    }

    $isHome = $global:WinEdition -notmatch "Pro|Enterprise|Education|Business"

    # FT-54 (ascii28): the checks took long enough that a blinking cursor
    # looked like a hang -- live progress line added.
    $ggChkNum = 0
    foreach ($s in $Settings) {
        $ggChkNum++
        # FT-135 (ascii38): re-assert QuickEdit-off ONCE PER ITEM. This whole
        # function is a write-only stretch -- 19 probes with no read anywhere --
        # so the standing "re-assert before every READ" protection has no
        # opportunity to fire for its entire duration. Field note 15 lost 15
        # minutes 42 seconds inside this loop (log: 18:02:06 -> 18:17:48).
        # WHAT THIS FIXES: a stray click landing the console in selection mode
        # part-way through the loop now gets undone at the next item, so the
        # freeze lasts one item instead of the rest of the function.
        # WHAT THIS DOES NOT FIX: it cannot release a write that is ALREADY
        # blocked (nothing runs while the process is frozen), and it does not
        # defeat Mark mode entered deliberately with Alt+Space,E,M. Those need
        # the user to press a key, which is what happened in note 15. Said
        # plainly because half a fix recorded as a whole one is how FT-120
        # survived into a second subsystem.
        try { Disable-QuickEdit } catch {}
        try { Write-Host ("`r  Checking setting $ggChkNum of $($Settings.Count)...   ") -ForegroundColor Cyan -NoNewline } catch {}
        # FT-157 (ascii39): "N/A on Home Edition" was accurate but said
        # nothing, and the tester supplied two Microsoft sources he read as
        # contradicting it (field note 6). RESEARCHED 2026-07-30 against
        # Microsoft Learn: Windows 11 Home cannot ACCEPT incoming Remote Desktop
        # connections -- hosting is Pro and above. Home CAN run the Remote
        # Desktop Connection client to connect OUT to other PCs, which is what
        # both of his sources describe, and which is not a risk to this PC. He
        # was half right and so were we; the copy now says which half.
        # The locked token "N/A on Home" is preserved (gate 23).
        if ($s.SkipOnHome -and $isHome) { $s.Status = "N/A on Home -- GOOD (Home cannot accept incoming connections)"; continue }
        if ($s.RequiresAdmin -and -not $global:IsAdmin) { $s.Status = "Requires Admin Access"; continue }

        switch ($s.ID) {
            1 {
                try { $svc = Get-Service wuauserv -EA Stop; $s.Status = if ($svc.StartType -ne 'Disabled') { "Enabled -- GOOD" } else { "DISABLED -- needs attention" } }
                catch { $s.Status = "Unknown" }
            }
            2 {
                try {
                    $mbSt2 = Get-MalwarebytesState
                    $avP2  = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
                    $mp2   = Get-MpComputerStatus -EA Stop

                    if ($mbSt2 -eq "TrialActive") {
                        # MB Premium Trial took over real-time from Defender
                        $s.Status = "Malwarebytes Premium Trial active -- Defender real-time inactive (by design while trial runs)"
                    } else {
                        # FT-33 (2026-07-12): was elseif on three named states --
                        # any OTHER value fell through leaving "Checking..." on
                        # screen. Now everything non-trial checks Defender directly.
                        # MB Free companion, not installed, or unknown -- check actual Defender state directly
                        if ($mp2.RealTimeProtectionEnabled) {
                            # FT-114 (ascii34): the FreeCompanion status string used to omit
                            # the locked "GOOD" token (Status-String Contract, Gate #23) --
                            # it read "ON -- Defender RT-VP active (...)" with no GOOD anywhere,
                            # so auto-deselect, the HEADS UP filter (Test-NonRecommendedSelections),
                            # AND the checklist color-match all failed to recognize this as a
                            # healthy state. Field-confirmed (HP SANDY, 2026-07-21): Defender
                            # Real-Time showed as ON yet was still flagged as a not-selected
                            # security-critical concern on the HEADS UP screen. Also removed an
                            # unreachable "TrialActive" branch here -- the outer if/else above
                            # already fully handles TrialActive and never falls through to this
                            # inner check.
                            $s.Status = if ($mbSt2 -eq "FreeCompanion") { "ON -- GOOD  (Malwarebytes Free installed as a manual-scan companion; Defender remains primary)" } else { "ON -- GOOD" }
                        } else {
                            # Defender real-time is actually off -- check if a different 3rd-party AV is primary
                            $nd2 = $avP2 | Where-Object { $_.displayName -notmatch "Windows Defender|Microsoft Defender|Malwarebytes" }
                            if ($nd2) {
                                $n2    = if ($nd2[0].displayName) { $nd2[0].displayName } else { "A 3rd-party AV" }
                                $isHR2 = ($HighRiskAVList | Where-Object { $n2 -match $_ }).Count -gt 0
                                $s.Status = if ($isHR2) { "!! CRITICAL RISK: $n2 (Russian/Chinese AV)" } else { "$n2 is active as primary AV -- Defender real-time is off" }
                            } else {
                                $s.Status = "OFF -- needs attention"
                            }
                        }
                    }
                } catch { $s.Status = "Unknown -- could not read Defender status" }
            }
            3 {
                # Tamper Protection is always readable via registry regardless of which AV is active
                $tpState = Get-TamperProtectionState
                $mbSt3   = Get-MalwarebytesState
                switch ($tpState) {
                    "On"  {
                        $s.Status = if ($mbSt3 -eq "FreeCompanion") {
                            "ON -- GOOD"
                        } elseif ($mbSt3 -eq "TrialActive") {
                            "ON -- GOOD  (Malwarebytes trial active)"
                        } else {
                            "ON -- GOOD"
                        }
                    }
                    "Off" {
                        $s.Status = if ($mbSt3 -eq "TrialActive") {
                            "OFF during Malwarebytes trial -- recheck after trial ends"
                        } else {
                            "OFF -- turn on in Windows Security (see guide)"
                        }
                    }
                    default { $s.Status = "Could not read -- check in Windows Security" }
                }
            }
            4 {
                try { $ss = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -EA SilentlyContinue).SmartScreenEnabled; $s.Status = if ($ss -ne "Off") { "ON -- GOOD" } else { "OFF -- needs attention" } }
                catch { $s.Status = "Unknown" }
            }
            5 {
                try {
                    $mbSt5   = Get-MalwarebytesState
                    $avP5    = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA Stop
                    $nd5     = $avP5 | Where-Object { $_.displayName -notmatch "Windows Defender|Microsoft Defender" }

                    if ($mbSt5 -eq "FreeCompanion") {
                        # MB Free -- Defender is still primary -- no periodic scan needed
                        $s.Status = "OFF is correct here -- GOOD"   # Defender primary; MB Free is manual-scan companion only
                    } elseif ($mbSt5 -eq "TrialActive") {
                        # MB Premium Trial took over real-time -- periodic scanning IS recommended
                        try {
                            $ps = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows Defender" -EA SilentlyContinue).PassiveMode
                            # FT-60 (ascii28): the toggle is MANUAL-ONLY (no supported
                            # scripted method) -- say so, and point at the steps.
                            $s.Status = "MB Trial is primary -- turn ON by hand (steps on this item's screen)"
                        } catch { $s.Status = "MB Trial is primary -- turn ON by hand (steps on this item's screen)" }
                    } elseif ($nd5) {
                        # Other 3rd-party AV
                        try {
                            $ps = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows Defender" -EA SilentlyContinue).PassiveMode
                            $s.Status = if ($ps -eq 1) { "3rd-party AV active -- enable periodic scanning" } else { "3rd-party AV detected -- check Defender settings" }
                        } catch { $s.Status = "3rd-party AV active -- check Defender settings" }
                    } else {
                        $s.Status = "OFF is correct here -- GOOD"   # G-03 (ascii32): neutral -- Defender is primary, periodic scanning is for when a 3rd-party AV handles real-time protection
                    }
                } catch { $s.Status = "Unknown" }
            }
            6 {
                # FT-141 (ascii39): THIS REPORTED A DEFINITE BAD FROM A CHECK
                # THAT WAS NEVER ALLOWED TO RUN. The WTDS\Components key is
                # Tamper Protected. With -EA SilentlyContinue the refusal became
                # $null, $null fell into the else, and the user was told "Not
                # configured -- all 3 need to be enabled" on a machine where the
                # setting may be perfectly fine. Reproduced on BOTH machines,
                # 2026-07-29.
                # WHY IT COULD NEVER SELF-CORRECT: Checkup RECOMMENDS turning
                # Tamper Protection ON (item 3). Every user who follows our own
                # advice makes this read fail permanently. The method is
                # unusable for a correctly-hardened machine, not merely fragile.
                # THE RULE, the same one as FT-120 and FT-123: a check that did
                # not establish the state reports Unknown and never invents a
                # definite answer. BLOCKED and ABSENT are now told apart, using
                # -EA Stop and a catch that inspects the exception, instead of a
                # silent null that could mean either one.
                try {
                    $pp = $null
                    $ppBlocked = $false
                    try {
                        $pp = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components" -EA Stop
                    } catch [System.Security.SecurityException] {
                        $ppBlocked = $true
                    } catch [System.UnauthorizedAccessException] {
                        $ppBlocked = $true
                    } catch {
                        # A genuinely absent key (ItemNotFound) leaves $pp null
                        # and $ppBlocked false, and is handled below as "not
                        # configured" -- which for an absent key is true.
                        if ($_.Exception -is [System.Security.SecurityException]) { $ppBlocked = $true }
                    }
                    if ($ppBlocked) {
                        $s.Status = "Unknown -- Tamper Protection blocks this check; verify by hand"
                        try { Write-Log -Message "Item 6 (Edge phishing protection): registry read BLOCKED by Tamper Protection -- reporting Unknown rather than a fault (FT-141)" -Status "INFO" } catch {}
                    } elseif ($null -eq $pp) {
                        $s.Status = "Not configured -- all 3 need to be enabled"
                    } else {
                        $svcOn  = ($pp.ServiceEnabled -eq 1)
                        $malOn  = ($pp.NotifyMalicious -eq 1)
                        $pwOn   = ($pp.NotifyPasswordReuse -eq 1)
                        $appOn  = ($pp.NotifyUnsafeApp -eq 1)
                        if ($svcOn -and $malOn -and $pwOn -and $appOn) {
                            $s.Status = "All 3 ON -- GOOD"
                        } elseif (-not $svcOn) {
                            $s.Status = "Service OFF -- all 3 need attention"
                        } else {
                            $missing = @()
                            if (-not $malOn) { $missing += "malicious sites" }
                            if (-not $pwOn)  { $missing += "password reuse" }
                            # FT-142 (ascii39): the registry VALUE is named
                            # NotifyUnsafeApp, but the label on the user's own
                            # screen reads "Warn me about unsafe password
                            # storage" (captured from Sandy, field note 20).
                            # CLAUDE.md requires literal on-screen labels be
                            # exact -- this is a name the reader has to find.
                            if (-not $appOn) { $missing += "unsafe password storage" }
                            $s.Status = "Partial -- missing: $($missing -join ', ')"
                        }
                    }
                } catch { $s.Status = "Unknown -- could not check; verify by hand" }
            }
            7 {
                try {
                    $fw    = Get-NetFirewallProfile -EA Stop
                    $allOn = ($fw | Where-Object { -not $_.Enabled }).Count -eq 0
                    $mbSt7 = Get-MalwarebytesState
                    if ($mbSt7 -eq "TrialActive") {
                        # MB WFC manages the firewall UI during Premium Trial
                        # Underlying Windows Firewall engine should still be ON
                        $s.Status = if ($allOn) { "ALL ON -- GOOD  (Malwarebytes WFC managing interface)" } else { "One or more profiles OFF -- needs attention  (Malwarebytes WFC detected)" }
                    } else {
                        $s.Status = if ($allOn) { "ALL ON -- GOOD" } else { "One or more profiles OFF -- needs attention" }
                    }
                } catch { $s.Status = "Unknown" }
            }
            8 {
                try { $bl = Get-BitLockerVolume -MountPoint $env:SystemDrive -EA Stop; $s.Status = if ($bl.ProtectionStatus -eq "On") { "ENCRYPTED -- GOOD" } else { "NOT Encrypted -- action available" } }
                catch { $s.Status = "Check manually in Windows Security" }
            }
            9 {
                $ngc = Test-Path "$env:LOCALAPPDATA\Microsoft\NGC"
                $s.Status = if ($ngc) { "Configured -- GOOD" } else { "Not set up -- manual action needed" }
            }
            10 {
                try { $rd = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -EA Stop).fDenyTSConnections; $s.Status = if ($rd -eq 1) { "DISABLED -- GOOD" } else { "Enabled -- consider disabling" } }
                catch { $s.Status = "Unknown" }
            }
            11 {
                try { $ai = (Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -EA Stop).Enabled; $s.Status = if ($ai -eq 0) { "OFF -- GOOD" } else { "ON -- needs attention" } }
                catch { $s.Status = "ON (default) -- needs attention" }
            }
            12 {
                # FT-118 (ascii34): "Required Only -- GOOD" read ambiguously
                # on the checklist as a bare status (Required Only... what?).
                # Added the verb "Should Send" to make it read as a complete
                # assertion, per field feedback. The literal substring
                # "Required Only" is unchanged, so this stays safe under the
                # Status-String Contract (Gate #23) -- every -match consumer
                # (color-match at the checklist, etc.) still finds the token.
                try { $dd = (Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -EA SilentlyContinue).AllowTelemetry; $s.Status = if ($null -ne $dd -and $dd -le 1) { "Should Send Required Only -- GOOD" } else { "Sending extra data -- we will limit it" } }
                catch { $s.Status = "Sending extra data -- we will limit it" }
            }
            13 {
                # FT-123 (ascii37): this read ONLY the HKLM policy key
                # Policies\Microsoft\Edge -- a key nothing but this tool ever
                # writes. A user who turns Startup Boost off in Edge's own
                # settings leaves that key absent, the read returns null, and
                # null fell through the else into "Enabled (default) -- needs
                # attention". Field note 10 (2026-07-27): "boost was off and
                # widgets were off and tool said they were enabled ... what
                # are you reading?" It was reading the policy key, and
                # reporting THE ABSENCE OF A POLICY as THE STATE OF THE
                # SETTING.
                # This is FT-120 INVERTED -- same root cause, opposite
                # direction. FT-120 turned a check that FAILED into a false
                # GOOD; this turned a policy that was NEVER SET into a false
                # BAD. One rule closes both: a check that did not establish
                # the state reports Unknown, and never invents a definite
                # answer.
                # NOT FIXED HERE, deliberately -- see FT-123b in the header.
                try {
                    $ep = Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -EA SilentlyContinue
                    $s.Status = if ($ep -and $ep.StartupBoostEnabled -eq 0 -and $ep.BackgroundModeEnabled -eq 0) { "DISABLED -- GOOD" }
                                elseif ($ep -and ($null -ne $ep.StartupBoostEnabled -or $null -ne $ep.BackgroundModeEnabled)) { "Enabled -- needs attention" }
                                else { "Unknown -- could not check" }
                }
                catch { $s.Status = "Unknown -- could not check" }
            }
            14 {
                # FT-123 (ascii37): identical defect to item 13 -- this read
                # only the HKLM policy value AllowNewsAndInterests, which
                # nothing but this tool writes. A user who turned Widgets off
                # from the taskbar left that value absent and was told Widgets
                # were "Enabled (default)". Field note 10 (2026-07-27):
                # "widgets were off and tool said they were enabled." Null now
                # reports Unknown instead of a definite wrong answer.
                try {
                    $w = (Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -EA SilentlyContinue).AllowNewsAndInterests
                    $s.Status = if ($null -eq $w) { "Unknown -- could not check" }
                                elseif ($w -eq 0)  { "DISABLED -- GOOD" }
                                else               { "Enabled -- needs attention" }
                }
                catch { $s.Status = "Unknown -- could not check" }
            }
            15 {
                # FT-123 (ascii37): identical defect to items 13 and 14. Field
                # note 10 (2026-07-27): "also passwords saves was off and tool
                # said it was enabled." The policy value was absent because
                # the user turned password saving off in Edge's own settings,
                # and absent was being reported as enabled.
                try {
                    $ep = (Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -EA SilentlyContinue).PasswordManagerEnabled
                    $s.Status = if ($null -eq $ep) { "Unknown -- could not check" }
                                elseif ($ep -eq 0)  { "DISABLED -- GOOD" }
                                else                { "Enabled -- needs attention" }
                }
                catch { $s.Status = "Unknown -- could not check" }
            }
            16 {
                # FT-115 (ascii34): same fix pattern as FT-105 (Tamper Protection) --
                # Win32_DeviceGuard reports the RUNTIME state (is the security
                # service actually running) rather than a registry key that may
                # not be populated on every hardware/driver configuration even
                # when Memory Integrity is genuinely on. Registry kept as
                # fallback; "Unknown" now only fires if BOTH fail. Field-
                # confirmed gap (HP SANDY, 2026-07-21): this setting showed
                # "Status: Unknown" with the registry-only check. Verified
                # working (2026-07-25, this dev machine): Win32_DeviceGuard
                # returned SecurityServicesRunning={2,7}, matching the registry
                # value of 1 -- could not reproduce the HP gap directly since
                # this machine isn't the affected configuration; needs field
                # verification on Home/affected hardware before closing.
                try {
                    $dg = Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard -EA Stop
                    $s.Status = if ($dg.SecurityServicesRunning -contains 2) { "ON -- GOOD" } else { "OFF -- needs attention" }
                } catch {
                    try {
                        $mi = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -EA Stop).Enabled
                        $s.Status = if ($mi -eq 1) { "ON -- GOOD" } else { "OFF -- needs attention" }
                    } catch {
                        $s.Status = "Unknown"
                    }
                }
            }
            17 {
                try { $pw = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>$null; $acVal = if (($pw | Out-String) -match "Current AC Power Setting Index: 0x(\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { $null }; $s.Status = if ($acVal -eq 1) { "REQUIRED -- GOOD" } else { "Not required -- needs attention" } }   # FT-255: Out-String -- -match on an array never sets $Matches
                catch { $s.Status = "Unknown" }
            }
            18 {
                try { $fs = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -EA Stop).HiberbootEnabled; $s.Status = if ($fs -eq 0) { "DISABLED -- GOOD" } else { "Enabled -- needs attention" } }
                catch { $s.Status = "Unknown" }
            }
            19 {
                # FT-120b (ascii36): this checklist path still carried all three
                # ascii34 faults after ascii35 fixed only Run-PowerSettingsCheck.
                # It reported "DISABLED -- GOOD" on the Dell Latitude 5430 while
                # that machine's Ethernet had Wake on Magic Packet, Wake on
                # Pattern Match and Wake from S0ix all Enabled -- and because the
                # verdict said GOOD, the auto-deselect below then skipped the item
                # so the user was never offered the fix. Same three causes and the
                # same fix as Run-PowerSettingsCheck: read every physical adapter
                # regardless of link state, read all three wake settings through
                # Get-NetAdapterAdvancedProperty (PowerManagement kept as
                # fallback), and NEVER report GOOD from a check that read nothing.
                try {
                    $adapters = @(Get-NetAdapter -Physical -EA Stop)
                    $wolOn = $false
                    $wolChecked = $false
                    foreach ($a in $adapters) {
                        $props = @(Get-NetAdapterAdvancedProperty -Name $a.Name -EA SilentlyContinue |
                            Where-Object { $_.DisplayName -match 'Wake on Magic Packet|Wake on Pattern Match|Wake from S0ix' })
                        if ($props.Count -gt 0) {
                            $wolChecked = $true
                            foreach ($p in $props) { if ($p.DisplayValue -eq "Enabled") { $wolOn = $true } }
                        } else {
                            $pm = Get-NetAdapterPowerManagement -Name $a.Name -EA SilentlyContinue
                            if ($pm) {
                                $wolChecked = $true
                                if ($pm.WakeOnMagicPacket -eq "Enabled" -or $pm.WakeOnPattern -eq "Enabled") { $wolOn = $true }
                            }
                        }
                    }
                    $s.Status = if (-not $wolChecked)  { "Unknown -- could not check" }
                                elseif ($wolOn)        { "Enabled -- consider disabling" }
                                else                   { "DISABLED -- GOOD" }
                } catch { $s.Status = "Unknown" }
            }
        }
    }
    try { Write-Host ("`r  All $($Settings.Count) settings checked.                    ") -ForegroundColor Green } catch {}
    # FT-135 (ascii38): field note 15 (2026-07-28) -- "Seems stalled on 7 of 19.
    # Been at least 3 minutes ... its been 10+ minutes will hit enter key. Soon
    # as i hit key it flashed something of 19 and went to next screen."
    # Confirmed in the log: 18:02:06 "Mode selected: Console" to 18:17:48
    # SCREEN-53 is 15 minutes 42 seconds with no log line in between.
    # This is FT-63 -- console Mark/QuickEdit selection freezes a process on
    # WRITE -- and it exposes a hole in the existing mitigation. The standing
    # rule is "re-assert console flags before every READ", but this function is
    # a long write-only stretch: 19 status probes with no read anywhere, so
    # there was no re-assert opportunity for the whole 15 minutes. The user's
    # keypress released the frozen write, which is exactly the FT-63 signature.
    # The per-item re-assert at the top of the loop above is the part that
    # actually narrows the freeze window; this call just leaves the console in
    # a known state on the way out. The completion log line matters
    # independently: ascii37 wrote NOTHING between "Mode selected" and the next
    # screen, so a 15-minute stall inside this function was invisible in the
    # log and had to be inferred from the gap between two timestamps.
    try { Disable-QuickEdit } catch {}
    try { Write-Log -Message "Get-AllStatuses complete -- all $($Settings.Count) settings probed" -Status "DONE" } catch {}

    # Auto-deselect items already at recommended setting
    foreach ($s in $Settings) {
        if ($s.Status -match "GOOD") { $s.Selected = $false }
    }
    # BitLocker -- never auto-select
    ($Settings | Where-Object { $_.ID -eq 8 }).Selected = $false

    # -- Auto-deselect items already at recommended state --
    # GOOD items show green and are skipped by default
    # User can still manually select [number] to re-apply if needed
    foreach ($s in $Settings) {
        if ($s.Status -match "-- GOOD|N/A on Home|ENCRYPTED -- GOOD|ALL ON -- GOOD") {
            $s.Selected = $false
        }
    }
}

# ============================================================
# NON-RECOMMENDED WARNING  (Y / N / S)
# ============================================================
function Test-NonRecommendedSelections {
    param([string]$Stage = "checklist")

    $criticalDeselected = $Settings | Where-Object {
        $_.SecurityCritical -and
        -not $_.Selected -and
        $_.Status -notmatch "GOOD|N/A|Requires Admin|ENCRYPTED|primary AV"
    }

    if ($criticalDeselected.Count -eq 0) { return $true }

    # FT-65 (ascii29): the prompt label said 'S = Skip' while the menu
    # said 'S = Show me what each item does' -- contradictory labels
    # (root cause of the 2026-07-13 52-keypress S flood). Labels now
    # agree, S clears and re-renders instead of piling text, and any
    # buffered auto-repeat keys are drained AFTER S is accepted so one
    # held key cannot answer the next prompt. This is a targeted post-
    # accept drain -- NOT the FT-29 global pre-read flush, which ate
    # first keypresses and stays removed.
    do {
        Clear-Host
        Write-Host ""
        Draw-Box -ScreenId "56" -Color White -Lines @(
            "  HEADS UP -- SOME SECURITY-CRITICAL ITEMS ARE NOT SELECTED  ",
            "---",
            "  The items below are not selected for this run.             ",
            "  These are flagged as important security settings.          ",
            "                                                             ",
            "  That is completely fine -- you know your setup best.       ",
            "  We just want to make sure these are intentional choices    ",
            "  and not accidental ones.                                   "
        )
        Write-Host ""
        foreach ($item in $criticalDeselected) {
            Write-Host "  Item $($item.ID): $($item.Name)" -ForegroundColor White
            Write-Host "         Status: $($item.Status)" -ForegroundColor Red
            Write-Host "         Guide:  $($item.GuideRef)" -ForegroundColor Gray
            Write-Host ""
        }
        Write-Host "  Y = These are intentional -- continue" -ForegroundColor White
        Write-Host "  B = Go back and review my selections" -ForegroundColor White
        Write-Host "  S = Show me what each item does before I decide" -ForegroundColor White
        Write-Host ""
        $resp = Read-ValidKey -ValidKeys @("Y","B","S") -Prompt "Your choice (Y = Continue / B = Go back / S = Show me each item): "
        if ($resp.ToUpper() -eq "S") {
            # Drain buffered auto-repeats of the accepted key (FT-65)
            try { while ($Host.UI.RawUI.KeyAvailable) { $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") } } catch {}
            Clear-Host
            Write-Host ""
            Draw-Box -ScreenId "57" -Color White -Lines @(
                "  WHAT EACH ITEM DOES -- AND WHY IT IS RECOMMENDED         ",
                "---",
                "  Details for each item you have not selected:             "
            )
            Write-Host ""
            foreach ($item in $criticalDeselected) {
                Write-Host "  Item $($item.ID): $($item.Name)" -ForegroundColor Yellow
                Write-Host "  Why recommended: $($item.Description)" -ForegroundColor Gray
                Write-Host "  Guide reference: $($item.GuideRef)" -ForegroundColor Cyan
                Write-Host ""
            }
            Pause-ForUser "  Press Enter or Space to return to the HEADS UP screen..."
        }
    } while ($resp.ToUpper() -eq "S")

    if ($resp.ToUpper() -eq "Y") {
        foreach ($item in $criticalDeselected) {
            Write-Log -Message "NOTED: User chose not to apply: $($item.Name) -- Status: $($item.Status)" -Status "NOTED"
        }
        Write-Log -Message "User confirmed intentional skip of security-critical items at stage: $Stage" -Status "NOTED"
        return $true
    }
    return $false   # B = go back and review selections
}

# ============================================================
# APPLY SETTING
# ============================================================
function Apply-Setting {
    param([PSCustomObject]$Setting)

    # FT-94 (ascii33): convenience items (11-15) are NEVER applied in the
    # main run -- they are deferred to Show-ConvenienceReview, which asks
    # the user BEFORE applying each one. $script:GGConvPhase is set only
    # inside that review. This guard intercepts every apply path
    # (console loop, GUI loop, apply-all) with a single rule.
    if ($Setting.ID -in 11,12,13,14,15 -and -not $script:GGConvPhase) {
        Write-Log -Message "$($Setting.Name) | Deferred to individual convenience review (FT-94)" -Status "INFO"
        return "Saved for your individual review -- you will approve or skip this one next"
    }

    $before = $Setting.Status
    $isHome = $global:WinEdition -notmatch "Pro|Enterprise|Education|Business"

    if ($Setting.Status -match "GOOD") {
        Write-Log -Message "$($Setting.Name) | Already correct: $before" -Status "GOOD"
        return "Already at recommended setting -- GOOD, no change needed"
    }
    if (-not $Setting.CanAuto) {
        Write-Log -Message "$($Setting.Name) | Manual action required" -Status "MANUAL"
        return "Manual action required -- see Guide: $($Setting.GuideRef)"
    }
    if ($Setting.RequiresAdmin -and -not $global:IsAdmin) {
        Write-Log -Message "$($Setting.Name) | Skipped -- no admin" -Status "SKIP"
        return "Skipped -- Administrator access required"
    }
    if ($Setting.SkipOnHome -and $isHome) {
        Write-Log -Message "$($Setting.Name) | Skipped -- Home edition" -Status "SKIP"
        return "Skipped -- not available on Windows 11 Home"
    }

    $result = "No change"

    switch ($Setting.ID) {
        1 {
            try {
                Set-Service -Name wuauserv -StartupType Automatic -EA Stop
                Start-Service -Name wuauserv -EA SilentlyContinue
                Set-Service -Name UsoSvc -StartupType Automatic -EA SilentlyContinue
                $result = "Windows Update service set to Automatic and started -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        2 {
            try {
                $mbSt2a  = Get-MalwarebytesState
                $avPA2   = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
                $ndA2    = $avPA2 | Where-Object { $_.displayName -notmatch "Windows Defender|Microsoft Defender" }

                if ($mbSt2a -eq "FreeCompanion") {
                    # MB Free is NOT blocking Defender -- enable Defender RT normally
                    Set-MpPreference -DisableRealtimeMonitoring $false -EA Stop
                    $result = "Defender Real-Time Protection enabled -- GOOD  (Malwarebytes Free companion remains installed for manual scans)"
                } elseif ($mbSt2a -eq "TrialActive") {
                    $result = "NOTE: Malwarebytes Premium Trial is currently handling real-time protection. Defender cannot run simultaneously. TO FIX: Open Malwarebytes -> Settings (gear icon) -> Account -> Deactivate Premium Trial. Defender will automatically become primary AV. Then rerun Checkup to confirm. See Guide: Phase 3, Step 4"
                } elseif ($ndA2) {
                    $avName   = if ($ndA2[0].displayName) { $ndA2[0].displayName } else { "A 3rd-party antivirus" }
                    $isHiRisk = ($HighRiskAVList | Where-Object { $avName -match $_ }).Count -gt 0
                    if ($isHiRisk) {
                        $result = "!! CRITICAL SECURITY RISK: $avName is a Russian or Chinese antivirus. This software may be sending your files and browsing data to foreign government servers. ACTION REQUIRED: (1) Uninstall $avName -- Settings -> Apps -> $avName -> Uninstall. (2) Restart your PC. (3) Confirm Defender is active in Windows Security. Microsoft Defender is a fully capable free AV -- you do not need this product. See Guide: Phase 3, Step 4"
                    } else {
                        $result = "$avName is registered as an antivirus. Defender real-time cannot run simultaneously with another active AV. See Guide: Phase 3, Step 4"
                    }
                } else {
                    Set-MpPreference -DisableRealtimeMonitoring $false -EA Stop
                    $result = "Defender Real-Time Protection enabled -- GOOD"
                }
            } catch { $result = "ERROR: $_ -- If a 3rd-party AV is active, Defender real-time cannot be enabled simultaneously" }
        }
        3 {
            $mbSt3a = Get-MalwarebytesState
            $avPA3  = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
            $ndA3   = $avPA3 | Where-Object { $_.displayName -notmatch "Windows Defender|Microsoft Defender" }

            if ($mbSt3a -eq "FreeCompanion") {
                # MB Free does NOT interfere with Defender -- give normal Tamper Protection instructions
                $result = "MANUAL ACTION REQUIRED: Windows Security -> Virus & threat protection -> Virus & threat protection settings -> Tamper Protection -> On. (Malwarebytes Free does not affect this setting.) See Guide: Phase 1, Step 2"
            } elseif ($mbSt3a -eq "TrialActive") {
                $result = "Malwarebytes Premium Trial is active -- Tamper Protection cannot be verified while the trial holds real-time AV control. EASIEST PATH: wait for the trial to end (it reverts to Free automatically -- nothing to do), then check again: Windows Security -> Virus & threat protection settings -> Tamper Protection -> On. In a hurry? End the trial early inside Malwarebytes: Settings (gear icon) -> Account -> Deactivate Premium Trial. See Guide: Phase 1, Step 2"
            } elseif ($ndA3) {
                $avName = if ($ndA3[0].displayName) { $ndA3[0].displayName } else { "A 3rd-party antivirus" }
                $result = "NOTE: $avName is registered as an AV. Tamper Protection cannot be verified while another AV is active. Fix AV status first, then: Windows Security -> Virus & threat protection settings -> Tamper Protection -> On. See Guide: Phase 1, Step 2"
            } else {
                $result = "MANUAL ACTION REQUIRED: Windows Security -> Virus & threat protection -> Virus & threat protection settings -> Tamper Protection -> On. See Guide: Phase 1, Step 2"
            }
        }
        4 {
            try {
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name SmartScreenEnabled -Value "Warn" -Force -EA Stop
                $result = "SmartScreen set to Warn (recommended) -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        5 {
            try {
                $mbSt5a = Get-MalwarebytesState
                $avPA5  = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
                $ndA5   = $avPA5 | Where-Object { $_.displayName -notmatch "Windows Defender|Microsoft Defender" }

                if ($mbSt5a -eq "FreeCompanion") {
                    # MB Free -- Defender is primary real-time AV -- no periodic scan needed
                    $result = "Defender is your primary AV -- real-time protection covers this. Malwarebytes Free is installed as a companion for manual scans (which is good). No change needed -- GOOD"
                } elseif ($mbSt5a -eq "TrialActive") {
                    # G-03 (ascii32): neutral framing -- describe the state factually, no comparison language
                    $result = "Malwarebytes Premium Trial is currently handling real-time virus protection on this PC. Turning on Defender Periodic Scanning adds a second layer of background checks. To enable: Windows Security -> Virus & threat protection -> Microsoft Defender Antivirus options -> Periodic scanning -> On. When the trial ends, Malwarebytes switches to Free mode and Defender takes over real-time protection automatically. See Guide: Phase 1, Step 2"
                } elseif ($ndA5) {
                    $avName = if ($ndA5[0].displayName) { $ndA5[0].displayName } else { "another antivirus program" }
                    # G-03 (ascii32): neutral framing -- state what was found and what the action is
                    $result = "$avName is registered as your real-time antivirus. To add Defender as a background second check: Windows Security -> Virus & threat protection -> Microsoft Defender Antivirus options -> Periodic scanning -> On. See Guide: Phase 1, Step 2. MANUAL ACTION NEEDED."
                } else {
                    $result = "Defender is your primary AV -- real-time protection covers this. No change needed -- GOOD"
                }
            } catch { $result = "ERROR: $_" }
        }
        6 {
            # Enhanced Phishing Protection -- WTDS registry
            # Key may be Tamper Protected -- catch PermissionDenied and show manual steps
            try {
                $rp = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components"
                if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                Set-ItemProperty -Path $rp -Name ServiceEnabled      -Value 1 -Type DWord -Force -EA Stop
                Set-ItemProperty -Path $rp -Name NotifyMalicious      -Value 1 -Type DWord -Force -EA Stop
                Set-ItemProperty -Path $rp -Name NotifyPasswordReuse  -Value 1 -Type DWord -Force -EA Stop
                Set-ItemProperty -Path $rp -Name NotifyUnsafeApp      -Value 1 -Type DWord -Force -EA Stop
                $result = "All 3 phishing protection options enabled -- GOOD"
            } catch [System.Security.SecurityException] {
                $result = "MANUAL REQUIRED -- registry is protected on this PC (Tamper Protection)"
                Write-Host ""
                Write-Host "  NOTE: Phishing Protection registry is protected on this PC." -ForegroundColor Yellow
                Write-Host "  Enable manually:" -ForegroundColor Yellow
                Write-Host "  1. Windows Security -> App & browser control" -ForegroundColor Gray
                Write-Host "  2. Reputation-based protection settings" -ForegroundColor Gray
                Write-Host "  3. Under Phishing protection -> turn ON all 3 options" -ForegroundColor Gray
                Write-Host "  Full guide: gatewayguard.co/guide/phishing-protection" -ForegroundColor Cyan
                Write-Host ""
                Pause-ForUser "  Press Enter or Space to continue..."
            } catch {
                $result = "Could not enable -- check manually in Windows Security -> App & browser control"
            }
        }
        7 {
            try {
                Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True -EA Stop
                $mbSt7a = Get-MalwarebytesState
                if ($mbSt7a -eq "TrialActive") {
                    $result = "All firewall profiles confirmed ON (Domain, Private, Public) -- GOOD. NOTE: Malwarebytes Windows Firewall Control (WFC) is managing the firewall interface during your Premium Trial -- this is normal. The underlying Windows Firewall engine remains active and your PC is protected."
                } else {
                    $result = "All firewall profiles enabled (Domain, Private, Public) -- GOOD"
                }
            } catch { $result = "ERROR: $_" }
        }
        8 {
            $result = "BitLocker is handled via the dedicated BitLocker screen at the end of this run."
        }
        9 {
            $ngc = Test-Path "$env:LOCALAPPDATA\Microsoft\NGC"
            if ($ngc) {
                $result = "Windows Hello is already configured -- GOOD, no action needed"
            } else {
                $result = "NOT CONFIGURED -- Manual setup: Settings -> Accounts -> Sign-in options -> set up PIN or fingerprint/face. A PIN is the minimum. See Guide: Phase 1, Step 4"
            }
        }
        10 {
            try {
                Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name fDenyTSConnections -Value 1 -Force -EA Stop
                Disable-NetFirewallRule -DisplayGroup "Remote Desktop" -EA SilentlyContinue
                $result = "Remote Desktop disabled -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        11 {
            try {
                $rp = "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
                if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                Set-ItemProperty -Path $rp -Name Enabled -Value 0 -Type DWord -Force -EA Stop
                $result = "Advertising ID disabled -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        12 {
            try {
                $rp = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
                if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                Set-ItemProperty -Path $rp -Name AllowTelemetry -Value 1 -Type DWord -Force -EA Stop
                $result = "Diagnostic data set to Required Only -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        13 {
            try {
                $rp = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
                if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                Set-ItemProperty -Path $rp -Name StartupBoostEnabled   -Value 0 -Type DWord -Force -EA Stop
                Set-ItemProperty -Path $rp -Name BackgroundModeEnabled  -Value 0 -Type DWord -Force -EA Stop
                $result = "Edge startup boost and background mode disabled -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        14 {
            try {
                $rp = "HKLM:\SOFTWARE\Policies\Microsoft\Dsh"
                if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                Set-ItemProperty -Path $rp -Name AllowNewsAndInterests -Value 0 -Type DWord -Force -EA Stop
                $result = "Windows Widgets disabled -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        15 {
            try {
                # FT-221 (ascii43): never disable Edge password saving while the
                # user has no password manager -- that would leave them with no
                # password store at all. The checklist deselects item 15 when the
                # user says they have no manager, but a manual re-select could
                # still reach here, so the guard lives at the point of change.
                if (-not $global:HasPasswordManager) {
                    $result = "LEFT ON -- set up a password manager first, or your saved passwords would have nowhere to live. See Guide: Phase 5 at $GuideURL"
                    Write-Log -Message "Edge Password Saving (ID 15) NOT disabled -- no password manager (FT-221)" -Status "SKIP"
                } else {
                    $rp = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
                    if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                    Set-ItemProperty -Path $rp -Name PasswordManagerEnabled -Value 0 -Type DWord -Force -EA Stop
                    $result = "Edge password saving disabled. Use a dedicated password manager. See Guide: Phase 5 at $GuideURL"
                }
            } catch { $result = "ERROR: $_" }
        }
        16 {
            try {
                $avP16  = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct -EA SilentlyContinue
                $nd16   = $avP16 | Where-Object { $_.displayName -notmatch "Windows Defender|Microsoft Defender" }
                $av16   = if ($nd16 -and $nd16[0].displayName) { $nd16[0].displayName } else { "" }
                $drNote = if ($av16) { " NOTE: $av16 drivers may conflict with Memory Integrity. If Windows shows driver compatibility errors after restart, temporarily disable Memory Integrity (same path) until $av16 updates its drivers." } else { "" }

                $rp = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"
                if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
                Set-ItemProperty -Path $rp -Name Enabled -Value 1 -Type DWord -Force -EA Stop
                $result = "Memory Integrity enabled -- RESTART REQUIRED to take effect.$drNote See Guide: Phase 1, Step 2"
            } catch { $result = "ERROR: $_" }
        }
        17 {
            try {
                powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null
                powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null
                powercfg /S SCHEME_CURRENT | Out-Null
                $result = "Password required on wake -- enabled for both AC and battery -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        18 {
            try {
                Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name HiberbootEnabled -Value 0 -Type DWord -Force -EA Stop
                $result = "Fast Startup disabled -- full clean shutdown now active -- GOOD"
            } catch { $result = "ERROR: $_" }
        }
        19 {
            # FT-120b (ascii36): this apply path reported success having changed
            # nothing. Set-NetAdapterPowerManagement was called with
            # -EA SilentlyContinue, on Up adapters only, for Magic Packet only,
            # and "-- GOOD" was then returned unconditionally -- which also logged
            # the item as [APPLIED]. Now every physical adapter is visited, all
            # three wake settings are handled, every failure is counted and
            # logged, and the result text states what actually changed.
            # -NoRestart is deliberate: resetting the adapter mid-run would drop
            # the user's Wi-Fi connection, so the change takes effect at restart.
            try {
                $wolChanged = 0
                $wolFailed  = 0
                $wolSeen    = 0
                foreach ($a in @(Get-NetAdapter -Physical -EA Stop)) {
                    $adapterSeen = 0
                    foreach ($dn in @('Wake on Magic Packet','Wake on Pattern Match','Wake from S0ix on Magic Packet')) {
                        $prop = Get-NetAdapterAdvancedProperty -Name $a.Name -DisplayName $dn -EA SilentlyContinue
                        if ($prop) {
                            $adapterSeen++
                            $wolSeen++
                            if ($prop.DisplayValue -eq "Enabled") {
                                try {
                                    Set-NetAdapterAdvancedProperty -Name $a.Name -DisplayName $dn -DisplayValue "Disabled" -NoRestart -EA Stop
                                    $wolChanged++
                                } catch {
                                    $wolFailed++
                                    Write-Log -Message "Wake on LAN: could not disable '$dn' on $($a.Name) -- $_" -Status "ERROR"
                                }
                            }
                        }
                    }
                    if ($adapterSeen -eq 0) {
                        $pm = Get-NetAdapterPowerManagement -Name $a.Name -EA SilentlyContinue
                        if ($pm) {
                            $wolSeen++
                            if ($pm.WakeOnMagicPacket -eq "Enabled") {
                                try {
                                    Set-NetAdapterPowerManagement -Name $a.Name -WakeOnMagicPacket Disabled -NoRestart -EA Stop
                                    $wolChanged++
                                } catch {
                                    $wolFailed++
                                    Write-Log -Message "Wake on LAN: could not disable Magic Packet on $($a.Name) -- $_" -Status "ERROR"
                                }
                            }
                        }
                    }
                }
                if ($wolSeen -eq 0) {
                    $result = "ERROR: could not read Wake on LAN settings on any network adapter -- nothing was changed"
                } elseif ($wolChanged -eq 0 -and $wolFailed -gt 0) {
                    $result = "ERROR: Wake on LAN -- none of the $wolFailed setting(s) could be changed -- see log"
                } elseif ($wolFailed -gt 0) {
                    $result = "NOTE: Wake on LAN -- $wolChanged setting(s) turned off, $wolFailed could NOT be changed (see log) -- takes effect after restart"
                } elseif ($wolChanged -gt 0) {
                    $result = "Wake on LAN turned off -- $wolChanged setting(s) changed -- takes effect after restart -- GOOD"
                } else {
                    $result = "Wake on LAN was already off on every network adapter -- GOOD"
                }
            } catch { $result = "ERROR: $_" }
        }
    }

    # BUGFIX ascii23 (2026-07-10): status was hardcoded to "APPLIED" no matter
    # what actually happened -- a setting blocked by a 3rd-party AV, requiring
    # manual action, or erroring out was still logged as [APPLIED], which
    # contradicts the Result text and misleads anyone reading the log.
    $logStatus = if ($result -match "^ERROR:") { "ERROR" }
                 elseif ($result -match "^!! CRITICAL") { "CRITICAL" }
                 elseif ($result -match "^MANUAL ACTION REQUIRED") { "MANUAL" }
                 elseif ($result -match "^NOTE:|cannot run simultaneously|cannot be verified|cannot be enabled simultaneously") { "BLOCKED" }
                 elseif ($result -match "-- GOOD") { "APPLIED" }
                 else { "INFO" }
    Write-Log -Message "$($Setting.Name) | Before: $before | Result: $result" -Status $logStatus
    return $result
}

# ============================================================
# SCOPE DISCLAIMER
# ============================================================
function Show-ScopeDisclaimer {
    # Ensure sleep prevention is active (in case it failed at startup)
    if (-not $global:SleepPrevented) { Enable-SleepPrevention }

    # FT-31 (2026-07-12): ask about a password manager BEFORE the checklist.
    # Turning off Edge's password saving only makes sense if passwords live
    # somewhere safer. Without a manager, that change could lock people out
    # of their own accounts -- so the [E] item adapts to this answer.
    #
    # FT-127 (ascii37): the answer is now REMEMBERED. Field note 11
    # (2026-07-27): "Resume took me right back to console mode selection.
    # However still asked a second time about P/W mgr. fix this no need to ask
    # twice." Open since ascii32 as FT-107, where it was logged as "asked on
    # every resume (3x in one morning); answer not persisted with checkpoint".
    # It is saved beside the checkpoint and restored when the user resumes.
    # WHY THIS IS NOT A CLASS 5 VIOLATION: Class 5 rule 1 bars persisting
    # PRESENTATION state and facts about the previous session's ENVIRONMENT --
    # things that may have changed under us and must be re-measured. This is
    # neither. It is an answer the user gave, about themselves, and re-asking
    # it does not make it more accurate; it only makes the user answer the
    # same question three times in a morning. Class 5 rule 4 (resumption
    # re-verifies) is honoured by SHOWING the remembered answer and offering
    # to change it, rather than silently assuming it.
    $ggPMKnown = ($null -ne $global:HasPasswordManager)
    if ($ggPMKnown) {
        Clear-Host
        Write-Host ""
        $ggPMWas = if ($global:HasPasswordManager) { "DO use" } else { "do NOT use" }
        Draw-Box -ScreenId "74" -Color White -Lines @(
            "  YOUR PASSWORDS -- WE REMEMBERED YOUR ANSWER                ",
            "---",
            "  Last time, you told us you $ggPMWas a password manager",
            "  (an app such as Bitwarden, 1Password, or KeePass).         ",
            "                                                            ",
            "  We saved that answer so you do not have to give it again.  ",
            "  Nothing on your PC has been changed by this screen.        ",
            "                                                            ",
            "  [Y] That is still correct -- continue to the next screen   ",
            "  [N] That has changed -- ask me the full question again     "
        )
        Write-Host ""
        $ggPMStill = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Still correct? (Y = yes, continue / N = no, ask me again): "
        if ($ggPMStill.ToUpper() -eq "N") {
            $global:HasPasswordManager = $null
            $ggPMKnown = $false
            Write-Log -Message "Password-manager answer discarded by user -- re-asking" -Status "INFO"
        } else {
            Write-Log -Message "Password-manager answer reused from saved state: $($global:HasPasswordManager)" -Status "INFO"
            # Mirror the original effect exactly: no manager means the Edge
            # password-saving change (ID 15) is left alone. Only deselect --
            # never select -- so a GOOD item is not force-selected here.
            if (-not $global:HasPasswordManager) {
                $ggE = $Settings | Where-Object { $_.ID -eq 15 }
                if ($ggE) { $ggE.Selected = $false }
            }
        }
    }

    if (-not $ggPMKnown) {
    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "53" -Color White -Lines @(
        "  QUICK QUESTION -- YOUR PASSWORDS                            ",
        "---",
        "  Do you use a PASSWORD MANAGER -- a separate app such as     ",
        "  Bitwarden, 1Password, or KeePass -- to store your           ",
        "  passwords?                                                  ",
        "                                                              ",
        "  WHY WE ASK: One of the later settings turns OFF the web     ",
        "  browser's built-in password saving, because browsers are    ",
        "  a common target for password-stealing malware. But that     ",
        "  only makes sense if your passwords already live somewhere   ",
        "  safer. If you don't have a password manager yet, we will    ",
        "  LEAVE the browser's password saving alone so you don't      ",
        "  lose access to your accounts."
    )
    Write-Host ""
    $pmAns = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Do you use a password manager? (Y = yes / N = no): "
    $global:HasPasswordManager = ($pmAns.ToUpper() -eq "Y")
    if (-not $global:HasPasswordManager) {
        $eSetting = $Settings | Where-Object { $_.ID -eq 15 }
        if ($eSetting) { $eSetting.Selected = $false }
        Write-Host ""
        Write-Host "  Understood -- Edge's password saving will be LEFT ON for now." -ForegroundColor Green
        Write-Host "  When you're ready, a password manager is strongly recommended --" -ForegroundColor Gray
        Write-Host "  see the Guide for how to set one up, then re-run Checkup." -ForegroundColor Gray
        Write-Log -Message "No password manager -- Edge Password Saving (ID 15) deselected, left ON" -Status "INFO"
    } else {
        Write-Log -Message "User has a password manager -- Edge Password Saving change stays available" -Status "INFO"
    }
    Write-Host ""
    Pause-ForUser "  Press Enter or Space to continue to what Checkup does..."
    }

    # FT-52/FT-55 (ascii28): B on this screen returns to the password
    # question above (testers asked for it); claims corrected -- items the
    # tool cannot change are now listed as exactly that.
    #
    # FT-129 (ascii37): SPLIT INTO TWO SCREENS. Field note 12 (2026-07-27):
    # "What this tool does screen is to long -- any screen longer then 25
    # lines must be split into two screens." This screen was 39 content lines
    # against a rule of 25, and it is the last screen that rendered before the
    # field note 14 crash. It is now page 1 of 2 (what the tool changes, and
    # what it checks but cannot change) and page 2 of 2 (the convenience items
    # you will be asked about at the end, what the tool does NOT do, and this
    # PC's status). Both pages carry Back, which also chips at the oldest
    # unmet request in the notes -- Back on every screen, asked for in every
    # round since ascii20 and still not met everywhere (see FT-131, deferred).
    # PREVENTS: a screen the user cannot read in one window.
    # COULD CAUSE: one extra keypress on the way to the checklist. Accepted --
    # note 12 is explicit that splitting is what is wanted.
    $ggScopePage = 1
    while ($true) {
        Clear-Host
        Write-Host ""
        if ($ggScopePage -eq 1) {
            Draw-Box -ScreenId "54" -Color White -Lines @(
                "  WHAT CHECKUP DOES AND DOES NOT DO   (page 1 of 2)                ",
                "---",
                "  HOW THIS WORKS:                                                   ",
                "  The previous pre-flight screens READ your current settings.       ",
                "  What you saw was what was FOUND on your PC -- nothing was         ",
                "  changed yet. Changes only happen after you approve each item      ",
                "  in the security checklist on the next screen.                     ",
                "                                                                    ",
                "  WHAT IT CHANGES (each one only with your approval):              ",
                "  * Security features ON  (Defender virus protection, SmartScreen, ",
                "    Firewall, Memory Integrity, BitLocker if you choose it)        ",
                "  * Risky features OFF    (Remote Desktop, Wake-on-LAN,            ",
                "    Fast Startup)                                                  ",
                "  * Privacy settings      (Advertising ID, Diagnostic Data)        ",
                "                                                                    ",
                "  WHAT IT CHECKS BUT CANNOT CHANGE -- Windows insists a human      ",
                "  does these; Checkup shows you the exact steps instead:           ",
                "                                                                   ",
                "  * Tamper Protection                                              ",
                "  * Windows Hello (PIN)                                            ",
                "  * Screen timeout                                                 ",
                "                                                                   "
            )
            Write-Host ""
            $ggScopeNav = Read-NavKey -Prompt "  Press Enter or Space for page 2 of 2, or B to go back to the password question: "
            if ($ggScopeNav -eq "BACK") {
                # Re-ask the password-manager question, then return to page 1
                Clear-Host
                Write-Host ""
                $pmAns2 = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Do you use a password manager? (Y = yes / N = no): "
                $global:HasPasswordManager = ($pmAns2.ToUpper() -eq "Y")
                $eSetting2 = $Settings | Where-Object { $_.ID -eq 15 }
                if ($eSetting2) { $eSetting2.Selected = $global:HasPasswordManager }
                Write-Log -Message "Password-manager answer revised via Back: $($global:HasPasswordManager)" -Status "INFO"
            } else {
                $ggScopePage = 2
            }
        } else {
            Draw-Box -ScreenId "75" -Color White -Lines @(
                "  WHAT CHECKUP DOES AND DOES NOT DO   (page 2 of 2)                ",
                "---",
                "  CONVENIENCE FEATURES -- YOU WILL BE ASKED AT THE END:            ",
                "  The following are RECOMMENDED to turn off for security/privacy.   ",
                "  After all settings run, you will review each one individually     ",
                "  and decide if you want to KEEP the change or REVERT it:          ",
                "                                                                    ",
                "  [A] Advertising ID      -- Stops Windows tracking you for ads    ",
                "  [B] Diagnostic Data     -- Limits data sent to Microsoft         ",
                "  [C] Edge Startup Boost  -- Stops Edge loading on every boot      ",
                "  [D] Windows Widgets     -- Stops background Edge/news processes  ",
                $(if ($global:HasPasswordManager) { "  [E] Edge Password Save  -- Keeps passwords out of the browser    " } else { "  [E] Edge Password Save  -- SKIPPED: set up a password manager 1st" }),
                "                                                                    ",
                "  WHAT IT DOES NOT DO:                                             ",
                "  * Does not uninstall apps (only flags suspicious ones for you)   ",
                "  * Does not change your browser, passwords, or accounts           ",
                "  * Does not affect your files, documents, or personal data        ",
                "  * Does not make changes you cannot reverse                       ",
                "                                                                    ",
                "  Edition: $global:WinEditionFriendly",
                "  Admin:   $(if ($global:IsAdmin) { 'Full access -- all settings available' } else { 'Limited -- some settings skipped' })",
                "  Power:   $(if ($global:OnBattery) { 'BATTERY -- plug in before BitLocker' } else { 'AC power OK' })  Sleep: $(if ($global:SleepPrevented) { 'ACTIVE' } else { 'inactive' })"
            )
            Write-Host ""
            $ggScopeNav = Read-NavKey -Prompt "  Press Enter or Space for the security checklist, or B to go back to page 1 of 2: "
            if ($ggScopeNav -eq "BACK") { $ggScopePage = 1 } else { break }
        }
    }
}

# ============================================================
# CONVENIENCE FEATURES REVIEW (end of run -- option B: one at a time)
# ============================================================
function Show-ConvenienceReview {
    $convItems = @(
        @{
            ID      = 11
            Name    = "Advertising ID"
            What    = "Turn OFF the Advertising ID -- Windows will stop tracking your activity for ad targeting."
            Why     = "Windows assigns each account an Advertising ID and shares it across apps`n  and websites to serve targeted ads. Turning it off stops this tracking.`n  You still see ads -- they just won't be personalized to you."
            Revert  = "Settings -> Privacy & security -> General -> Let apps use advertising ID -> On"
            RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
            RegName = "Enabled"
            RevertVal = 1
            RevertType = "DWord"
        },
        @{
            ID      = 12
            Name    = "Diagnostic Data"
            What    = "Limit diagnostic data to REQUIRED ONLY -- Windows will send Microsoft only the minimum it needs."
            Why     = "By default Windows sends detailed usage, browsing habits and error reports`n  to Microsoft. Required Only limits this to the minimum for Windows to work.`n  Windows continues to function normally with this setting."
            Revert  = "Settings -> Privacy & security -> Diagnostics & feedback -> Diagnostic data -> Full"
            RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
            RegName = "AllowTelemetry"
            RevertVal = 3
            RevertType = "DWord"
        },
        @{
            ID      = 13
            Name    = "Edge Startup Boost and Background Running"
            What    = "Stop Edge from launching at every startup and from running after you close it."
            Why     = "Edge Startup Boost launches background Edge processes every time your PC`n  boots, even if you never open Edge. Background mode keeps Edge running`n  after you close it. Both waste RAM and CPU. Edge still works normally`n  when you open it -- it just won't pre-load without you asking."
            Revert  = "Open Edge -> Settings (three dots) -> System and performance ->`n           Startup boost -> On  AND  Continue running background apps -> On"
            RegPath = $null  # Edge settings via registry are user-specific -- manual revert only
            RegName = $null
            RevertVal = $null
            RevertType = $null
        },
        @{
            ID      = 14
            Name    = "Windows Widgets"
            What    = "Turn off the Widgets news/weather panel."
            Why     = "The Widgets panel runs background Edge WebView2 processes at all times,`n  consuming RAM even when the panel is closed. It also sends browsing`n  behavior data to Microsoft. Disabling Widgets does NOT affect the`n  taskbar, Start menu, or any other feature."
            Revert  = "Settings -> Personalization -> Taskbar -> Widgets -> On"
            RegPath = $null
            RegName = $null
            RevertVal = $null
            RevertType = $null
        },
        @{
            ID      = 15
            Name    = "Edge Password Saving"
            What    = "Stop Edge from offering to save your passwords (your password manager does this job better)."
            Why     = "Browser-saved passwords are stored with minimal encryption and are`n  vulnerable if someone accesses your PC or if Edge is compromised.`n  A dedicated password manager (Bitwarden, 1Password) uses stronger`n  encryption and works across all browsers and devices.`n  NOTE: This does NOT delete any passwords already saved in Edge."
            Revert  = "Open Edge -> Settings -> Passwords -> Offer to save passwords -> On"
            RegPath = $null
            RegName = $null
            RevertVal = $null
            RevertType = $null
        }
    )

    # FT-94 (ascii33): ASK BEFORE APPLY. Items 11-15 were NOT applied in
    # the main run (see the guard in Apply-Setting). Here each SELECTED
    # item is explained, and NOTHING happens until the user says Y.
    $ggConvSel = $Settings | Where-Object { $_.ID -in (11,12,13,14,15) -and $_.Selected }
    if (-not $ggConvSel -or @($ggConvSel).Count -eq 0) { return }  # none selected -- skip

    Clear-Host
    Write-Host ""
    Show-StepHeader -Key "ConvIntro" -Section "Wrapping Up"
    Draw-Box -ScreenId "23" -Color White -Lines @(
        "  CONVENIENCE CHOICES -- NOTHING CHANGED YET                       ",
        "---",
        "  The next few screens cover privacy and convenience settings.     ",
        "  All are RECOMMENDED, but they are YOUR choice.                   ",
        "                                                                   ",
        "  NO change is made until you approve it. For each item:           ",
        "    Y = Make this change now (recommended)                         ",
        "    N = Skip it -- leave that setting exactly as it is             "
    )
    Write-Host ""
    Pause-ForUser "  Press Enter or Space to see the first item..."

    $ggConvSelIDs = @($ggConvSel | ForEach-Object { $_.ID })
    $ggCITotal = @($ggConvSelIDs).Count
    $ggCIIdx   = 0
    $script:GGConvPhase = $true   # FT-94: unlocks Apply-Setting for 11-15
    foreach ($ci in $convItems) {
        if ($ci.ID -notin $ggConvSelIDs) { continue }
        $ggSetting = $Settings | Where-Object { $_.ID -eq $ci.ID }

        $ggCIIdx++
        Clear-Host
        Write-Host ""
        Draw-Box -ScreenId "71" -Color White -Lines @(
            "  YOUR CHOICE [$ggCIIdx of $ggCITotal]: $($ci.Name)          ",
            "---",
            "  WHAT THIS CHANGE WILL DO (nothing done yet):                ",
            "  $($ci.What)                                                 ",
            "---",
            "  WHY WE RECOMMEND IT:                                        ",
            "  $($ci.Why)                                                  ",
            "---",
            "  IF YOU EVER WANT TO UNDO IT LATER:                          ",
            "  $($ci.Revert)                                               "
        )
        Write-Host ""
        Write-Host "  Y = Make this change now (recommended)" -ForegroundColor White
        Write-Host "  N = Skip it -- leave this setting exactly as it is" -ForegroundColor White
        Write-Host ""

        do {
            $resp = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Your choice (Y = Make the change / N = Skip it): "
        } while ($resp.ToUpper() -notin @("Y","N"))

        if ($resp.ToUpper() -eq "Y") {
            $ggConvResult = Apply-Setting -Setting $ggSetting
            Write-Host ""
            Write-Host "  Done: $ggConvResult" -ForegroundColor Green
            Write-Log -Message "User approved convenience change: $($ci.Name) -- $ggConvResult" -Status "OK"
        } else {
            Write-Host ""
            Write-Host "  Skipped: $($ci.Name) was left exactly as it was." -ForegroundColor Yellow
            Write-Log -Message "User skipped convenience change: $($ci.Name) -- no change made" -Status "SKIP"
        }
    }
    $script:GGConvPhase = $false

    Write-Host ""
    Write-Host "  Convenience choices complete -- only the items you approved were changed." -ForegroundColor White
    Write-Host ""
    Pause-ForUser "  Press Enter or Space to see your manual steps checklist..."
}

# ============================================================
# MANUAL STEPS REMINDER
# ============================================================
function Show-OneDriveOffer {
    # FT-191 (ascii41). Shown ONLY when no OneDrive folder was found.
    if ($global:GGUsingOneDrive) { return }
    if ($global:GGOneDriveDeclined) {
        Write-Log -Message "OneDrive offer skipped -- user declined on an earlier run" -Status "SKIP"
        return
    }
    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "88" -Color Yellow -Lines @(
        "  ONE THING CHECKUP CANNOT PROTECT YOU FROM                 ",
        "---",
        "  Everything on the checklist protects THIS computer. None  ",
        "  of it helps if the computer itself is gone -- stolen, or  ",
        "  dropped, or the drive simply stops one morning.           ",
        "                                                            ",
        "  It also does not stop RANSOMWARE -- where your own files  ",
        "  are locked and money is demanded. That needs no weakness   ",
        "  in Windows, only one wrong click. A second copy of your    ",
        "  files, somewhere that is not this PC, is what defeats it.  ",
        "                                                            ",
        "  Windows already includes that: OneDrive. It is free for   ",
        "  5 GB, it is made by Microsoft, and it is already on this  ",
        "  PC -- it has just never been set up. Your files copy      ",
        "  themselves as you work, and you can reach them from a     ",
        "  phone or any other computer.                              ",
        "                                                            ",
        "  Checkup would also keep your log and your encryption      ",
        "  recovery key there. A recovery key saved only on the      ",
        "  encrypted PC is no use on the day that PC will not start. ",
        "                                                            ",
        "  [Y] Show me how to set up OneDrive                        ",
        "  [N] No thank you -- keep everything on this PC only       "
    )
    Write-Host ""
    $ggODAns = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Set up OneDrive? (Y = show me how / N = no thank you): "
    if ($ggODAns.ToUpper() -eq "Y") {
        Write-Log -Message "User asked for OneDrive setup" -Status "INFO"
        Clear-Host
        Write-Host ""
        Draw-Box -ScreenId "89" -Color White -Lines @(
            "  HOW TO SET UP ONEDRIVE                                    ",
            "---",
            "  1. Press the Windows key, type  onedrive  and press Enter ",
            "  2. Sign in. If you have no Microsoft account, click       ",
            "     'Create one' -- it is free and takes a minute.         ",
            "  3. Accept the folder it offers. That is the right one.    ",
            "  4. When it asks which folders to back up, tick Desktop,   ",
            "     Documents and Pictures.                                ",
            "                                                            ",
            "  YOU DO NOT HAVE TO DO IT NOW. Nothing here is waiting on  ",
            "  it and Checkup will finish either way.                    ",
            "                                                            ",
            "  This run's log has already been written to this PC, so    ",
            "  Checkup starts using OneDrive the NEXT time you run it.   "
        )
        Write-Host ""
        try { Start-Process "onedrive.exe" -EA Stop; Write-Log -Message "OneDrive setup launched" -Status "INFO" }
        catch { Write-Log -Message ("Could not launch OneDrive: " + $_) -Status "WARN" }
        Pause-ForUser
    } else {
        $global:GGOneDriveDeclined = $true
        # Re-save the CURRENT checkpoint so the decline reaches the state file
        # without inventing a checkpoint name. Save-Checkpoint's -Checkpoint is
        # mandatory and line 1 of that file must stay the checkpoint and nothing
        # else (FT-127), so the existing value is read back and rewritten.
        $ggCurCp = Get-SavedCheckpoint
        if ($ggCurCp) { Save-Checkpoint -Checkpoint $ggCurCp }
        Write-Log -Message "User declined OneDrive -- log and key stay on this PC only" -Status "SKIP"
        Write-Host ""
        Write-Host "  Understood. Your log and recovery key stay on this PC only." -ForegroundColor Gray
        Write-Host "  You will not be asked again." -ForegroundColor Gray
        Write-Host ""
        Pause-ForUser
    }
}

function Show-ManualSteps {
    # FT-244 (ascii44): this was the ONLY wrap-up screen with no
    # Clear-Host -- Setup-ScheduledTasks and Show-OneDriveOffer both
    # clear. So SCREEN-72 painted on top of whatever was already on
    # screen. Bill: "Scr 34 - appeared at a bottom of Scr 3b. Fix this."
    Clear-Host
    Write-Host ""
    Show-StepHeader -Key "ManualSteps" -Section "Wrapping Up"
    Draw-Box -ScreenId "72" -Color White -Lines @(
        "  AUTOMATED STEPS COMPLETE                                  ",
        "  These items require YOUR personal action:                 ",
        "---",
        "  [ ] Tamper Protection  -- Windows Security -> V&T          ",
        "      protection settings -> Tamper Protection -> ON          ",
        "      Guide: Phase 1, Step 2                                ",
        "                                                            ",
        "  [ ] Windows Hello      -- Settings -> Accounts ->          ",
        "      Sign-in options -> set up PIN or biometrics           ",
        "      Guide: Phase 1, Step 4                                ",
        "                                                            ",
        "  [ ] Malwarebytes Free  -- Helpful companion for scans.    ",
        "      Not required, but catches what Defender misses.       ",
        "      Skip the real-time trial -- manual scans only.        ",
        "      $AffiliateMalwarebytes",
        "      Guide: Phase 3, Step 4                                ",
        "                                                            ",
        "      SCAN 1 -- CUSTOM SCAN (checks for rootkits):           ",
        "        1. Open Malwarebytes                                ",
        "        2. Next to the Scan button, click the three dots    ",
        "           (do NOT click Scan itself)                       ",
        "        3. Click Advanced Scan, then Custom Scan            ",
        "        4. CHECK the box 'Scan for rootkits'                ",
        "        5. CHECK ALL your drives (C:, D:, and any others)   ",
        "        6. Start the scan -- about 25 min to an hour        ",
        "        7. If anything is found: click QUARANTINE right     ",
        "           then                                             ",
        "      SCAN 2 -- DEEP SCAN (run it overnight):                ",
        "        Three dots -> Advanced Scan -> Deep Scan.            ",
        "        Start it before bed and leave the lid open. The     ",
        "        screen may go dark -- the scan keeps running.       ",
        "                                                            ",
        $(if ($global:HasPasswordManager) { "  [x] Password Manager   -- You said you already use one.    " } else { "  [ ] Password Manager   -- Install, migrate passwords.     " }),
        $(if ($global:HasPasswordManager) { "      Good -- keep using it for every account.              " } else { "      Guide: Phase 5                                        " }),
        "                                                            ",
        "  [ ] 2FA                -- Enable on all important accounts.",
        "      Authenticator app preferred. Guide: Phase 5           ",
        "                                                            ",
        "  [ ] Scheduled Scans    -- AUTOMATED: Checkup set up       ",
        "      Quarterly Defender Offline Scan (Jan/Apr/Jul/Oct)     ",
        "      + monthly reminder to run your Malwarebytes scans     ",
        "      (Custom Scan with rootkits, then Deep Scan overnight) ",
        "      Verify: Task Scheduler -> GatewayGuard tasks          ",
        "---",
        "  Log saved to: $(Split-Path $LogPath -Parent)",
        "  Guide and support: $GuideURL",
        "---",
        "  GATEWAYGUARD IS NOW FINISHED FOR THIS SESSION.               ",
        "  The program will close after this screen -- complete the    ",
        "  items above on your own time. Your scheduled scans (above)  ",
        "  will still run automatically later -- everything else       ",
        "  requires you to run Checkup again.                          "
    )
    Write-Host ""
}


# ============================================================
# SCHTASKS.EXE INVOCATION (FT-109, ascii34)
# ============================================================
# PowerShell's own native-argument marshalling -- both the `&` call operator
# and Start-Process -ArgumentList -- was empirically confirmed (2026-07-25,
# throwaway test task, deleted immediately after) to mangle a /tr value that
# is itself quoted AND contains a space, e.g. a path under "Program Files".
# The only tested-working approach is to bypass PowerShell's argument
# marshalling entirely: build the full argument string by hand using the
# real Win32 CommandLineToArgvW escaping convention (backslash-escaped
# quotes, `\"..\"`, around any inner path/value that needs its own quoting),
# and invoke schtasks.exe directly via System.Diagnostics.Process.
function Set-GGTaskSettings {
    # FT-203 (ascii44): schtasks.exe has no switch for a missed start, for
    # waking, or for battery -- the complete /create switch list has none of
    # them, so every task it makes is off by default on a laptop. This runs
    # AFTER the task exists and adjusts the three that matter.
    #
    # VERIFIED 2026-09-06 measured on CGDELL (Tool2\Test-TaskSettings-2026-09-06.ps1):
    #   as created  StartWhenAvailable False / DisallowStartIfOnBatteries True /
    #               StopIfGoingOnBatteries True / WakeToRun False
    #   after this  True / False / False / False, confirmed by read-back.
    #
    # Mutates the EXISTING settings object rather than building a new one with
    # New-ScheduledTaskSettingsSet, which would reset every setting not named.
    #
    # WakeToRun is deliberately left False. Product decision: waking a sleeping
    # laptop to show a message box is what people uninstall software over.
    #
    # Returns a hashtable: Ok, and the four values AS READ BACK.
    param([string]$TaskName)

    $out = @{ Ok = $false; StartWhenAvailable = $null; DisallowStartIfOnBatteries = $null
              StopIfGoingOnBatteries = $null; WakeToRun = $null; Error = "" }
    try {
        $ggTask = Get-ScheduledTask -TaskName $TaskName -EA Stop
        $ggSet  = $ggTask.Settings
        $ggSet.StartWhenAvailable         = $true
        $ggSet.DisallowStartIfOnBatteries = $false
        $ggSet.StopIfGoingOnBatteries     = $false
        Set-ScheduledTask -TaskName $TaskName -Settings $ggSet -EA Stop | Out-Null

        # READ BACK. Report what the task store says, never what was intended.
        $ggAfter = (Get-ScheduledTask -TaskName $TaskName -EA Stop).Settings
        $out.StartWhenAvailable         = $ggAfter.StartWhenAvailable
        $out.DisallowStartIfOnBatteries = $ggAfter.DisallowStartIfOnBatteries
        $out.StopIfGoingOnBatteries     = $ggAfter.StopIfGoingOnBatteries
        $out.WakeToRun                  = $ggAfter.WakeToRun
        $out.Ok = ($ggAfter.StartWhenAvailable -eq $true -and
                   $ggAfter.DisallowStartIfOnBatteries -eq $false -and
                   $ggAfter.StopIfGoingOnBatteries -eq $false)
    } catch {
        $out.Error = "$_"
    }
    return $out
}

function Invoke-SchTasksCreate {
    param([string]$Arguments)
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "schtasks.exe"
    $psi.Arguments = $Arguments
    $psi.UseShellExecute = $false
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $proc = [System.Diagnostics.Process]::Start($psi)
    $out = $proc.StandardOutput.ReadToEnd() + $proc.StandardError.ReadToEnd()
    $proc.WaitForExit()
    return [PSCustomObject]@{ ExitCode = $proc.ExitCode; Output = $out.Trim() }
}

# ============================================================
# SCHEDULED SECURITY TASKS
# ============================================================
function Setup-ScheduledTasks {
    Clear-Host
    Write-Host ""
    Show-StepHeader -Key "TaskSetup" -Section "Wrapping Up"
    Draw-Box -ScreenId "70" -Color White -Lines @(
        "  AUTOMATED SCAN SCHEDULE SETUP                            ",
        "  Setting up automatic security scans...                   ",
        "---",
        "  (1) Quarterly Defender Offline Scan                      ",
        "      Runs BEFORE Windows loads -- catches deeply hidden   ",
        "      threats. Scheduled: 1st of Jan / Apr / Jul / Oct 2AM ",
        "                                                            ",
        "  (2) Monthly reminder to run your Malwarebytes scans      ",
        "      A popup on the 1st of each month reminding you to    ",
        "      run the Custom Scan (with rootkit checking) and the  ",
        "      Deep Scan. The popup includes the exact steps.       "
    )
    Write-Host ""
    Write-Host "  Setting up tasks -- please wait..." -ForegroundColor Yellow
    Write-Host ""

    $results = @()

    # --- Task 1: Quarterly Defender Offline Scan REMINDER ---
    # FT-175 (ascii40): THIS TASK HAS NEVER RUN A SCAN ON ANY MACHINE.
    # It used to schedule `MpCmdRun.exe -Scan -ScanType 4`.
    # VERIFIED 2026-08-15 measured on CGDELL: `MpCmdRun.exe -?` documents
    # -ScanType 0 (default), 1 (quick), 2 (full) and 3 (file). THERE IS NO 4.
    # ScanType 4 returns 0x80070667 "Invalid command line argument" in 0.0
    # seconds and does nothing -- while this function logged
    # "[GOOD] Scheduled task created", because schtasks had genuinely created a
    # task. The task was real. Its command was junk. Field findings 38 and 43.
    #
    # AND THE CORRECT CALL CANNOT GO IN A SCHEDULED TASK EITHER.
    # VERIFIED 2026-08-15 sourced, Microsoft's Start-MpWDOScan reference:
    # "This command causes the computer to start in Windows Defender offline
    # and begin the scan." It reboots the machine there and then; it does not
    # queue anything for the next restart. As a SYSTEM task at 2AM that would
    # restart a sleeping user's computer without warning, four times a year.
    # https://learn.microsoft.com/en-us/powershell/module/defender/start-mpwdoscan
    #
    # So the quarterly task is a REMINDER, exactly like the monthly
    # Malwarebytes one below: it tells the user the scan is due, tells them the
    # computer will restart, and lets them start it. The user's permission is
    # what starts an offline scan -- which is what SCREEN-38 already does
    # correctly in the interactive run, using Start-MpWDOScan.
    try {
        $scanDir = "C:\ProgramData\GatewayGuard"
        if (-not (Test-Path $scanDir)) { New-Item -Path $scanDir -ItemType Directory -Force | Out-Null }

        $offlineCode = @"
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show(
    "QUARTERLY SECURITY REMINDER -- GatewayGuard Checkup``n``n" +
    "Your Microsoft Defender Offline Scan is due.``n``n" +
    "This scan runs BEFORE Windows loads, so it catches things``n" +
    "that hide while the computer is running normally.``n``n" +
    "HOW TO START IT:``n" +
    "  1. Press the Windows key and type: Windows Security``n" +
    "  2. Open it, then click Virus and threat protection``n" +
    "  3. Under Current threats, click Scan options``n" +
    "  4. Choose Microsoft Defender Antivirus (offline scan)``n" +
    "  5. Click Scan now``n``n" +
    "WHAT WILL HAPPEN:``n" +
    "  Your computer restarts, a blue scan screen runs for about``n" +
    "  15 minutes, and then it restarts back to your desktop.``n``n" +
    "SAVE YOUR WORK FIRST. Start it when you do not need the``n" +
    "computer for half an hour. Nothing starts without you.",
    "GatewayGuard -- Quarterly Defender Offline Scan Due",
    [System.Windows.Forms.MessageBoxButtons]::OK,
    [System.Windows.Forms.MessageBoxIcon]::Information
) | Out-Null
"@
        $offlineCode | Out-File -FilePath "$scanDir\OfflineScanReminder.ps1" -Encoding UTF8 -Force

        # FT-93/93b (ascii33): schtasks.exe replaces New-ScheduledTask* --
        # (C-14) $false was passed positionally to switch params = the
        # logged "positional parameter" error; (C-14a) -Once triggers die
        # after their year. schtasks /sc monthly recurs forever.
        # The task NAME is unchanged on purpose. CLAUDE.md lists the two
        # GatewayGuard task names as identifiers and recovery points, not
        # prose: renaming this one would orphan the task on every machine
        # that already has it.
        $ggT1Name = "GatewayGuard - Quarterly Defender Offline Scan"
        # FT-109 (ascii34): the /tr value quotes the -File argument because its
        # path can contain a space. PowerShell's own native-argument
        # marshalling for `&`-invoked exes mangles an already-quoted argument
        # that ALSO contains a space, splitting it mid-path -- this produced
        # the field error "Invalid argument/option - 'Files\Windows'".
        # Empirically confirmed 2026-07-25 (throwaway test task, since
        # deleted) that invoking via Invoke-SchTasksCreate (raw
        # ProcessStartInfo, bypassing PowerShell's argument marshalling
        # entirely) is the only tested fix that survives correctly -- see that
        # function for detail.
        # NO /ru SYSTEM here any more. The reminder is a popup and has to
        # appear on the user's own desktop, so it runs as the current
        # interactive user -- the same reason task 2 below has no /ru. A
        # SYSTEM task would put the popup on a desktop nobody is looking at.
        $ggT1Tr = 'powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File \"' + "$scanDir\OfflineScanReminder.ps1" + '\"'
        $ggT1Args = "/create /f /tn `"$ggT1Name`" /tr `"$ggT1Tr`" /sc monthly /m JAN,APR,JUL,OCT /d 1 /st 10:00"
        $ggT1Result = Invoke-SchTasksCreate -Arguments $ggT1Args
        if ($ggT1Result.ExitCode -ne 0) { throw "schtasks exit $($ggT1Result.ExitCode) -- $($ggT1Result.Output)" }

        # FT-203 (ascii44): the task exists, but schtasks left it unable to
        # run on battery and unable to catch up a missed start. Fix the three
        # settings, then LOG WHAT WAS READ BACK.
        $ggSetT1 = Set-GGTaskSettings -TaskName $ggT1Name
        if ($ggSetT1.Ok) {
            Write-Log -Message ("Reminder settings confirmed by read-back -- runs on battery: yes, catches a missed start: yes, wakes the PC: no (T1)") -Status "GOOD"
        } elseif ($ggSetT1.Error) {
            $results += @{ Text = "  [!] Reminder created, but its battery settings could not be adjusted -- it may not run on battery"; Color = "Yellow" }
            Write-Log -Message ("Reminder settings NOT adjusted (T1) -- $($ggSetT1.Error)") -Status "WARN"
        } else {
            $results += @{ Text = "  [!] Reminder created, but its battery settings did not take -- it may not run on battery"; Color = "Yellow" }
            Write-Log -Message ("Reminder settings read back WRONG (T1) -- StartWhenAvailable=$($ggSetT1.StartWhenAvailable) DisallowStartIfOnBatteries=$($ggSetT1.DisallowStartIfOnBatteries) StopIfGoingOnBatteries=$($ggSetT1.StopIfGoingOnBatteries)") -Status "WARN"
        }

        $results += @{ Text = "  [OK] Quarterly offline-scan reminder scheduled (Jan/Apr/Jul/Oct, 1st @ 10AM)"; Color = "Green" }
        Write-Log -Message "Scheduled task created: GatewayGuard - Quarterly Defender Offline Scan (reminder popup -- FT-175)" -Status "GOOD"
    } catch {
        $results += @{ Text = "  [!] Quarterly scan reminder -- could not create: $_"; Color = "Yellow" }
        Write-Log -Message "Scheduled task ERROR: Quarterly Defender Offline Scan reminder -- $_" -Status "ERROR"
    }

    # --- Task 2: Monthly Malwarebytes Reminder ---
    try {
        $scriptDir = "C:\ProgramData\GatewayGuard"
        if (-not (Test-Path $scriptDir)) { New-Item -Path $scriptDir -ItemType Directory -Force | Out-Null }

        # D-15 (ascii33): popup carries the field-verified Custom Scan
        # steps. "Scan Now" removed -- that runs a Threat Scan, which
        # does NOT check rootkits (report-verified 2026-07-19).
        $reminderCode = @"
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show(
    "MONTHLY SECURITY REMINDER -- GatewayGuard Checkup``n``n" +
    "Time to run your two Malwarebytes scans this month.``n``n" +
    "SCAN 1 -- CUSTOM SCAN (checks for rootkits):``n" +
    "  1. Open Malwarebytes``n" +
    "  2. Next to the Scan button, click the three dots``n" +
    "     (do NOT click Scan itself)``n" +
    "  3. Click Advanced Scan, then Custom Scan``n" +
    "  4. CHECK the box 'Scan for rootkits'``n" +
    "  5. CHECK ALL your drives (C:, D:, and any others)``n" +
    "  6. Start the scan -- about 25 minutes to an hour``n" +
    "  7. If anything is found: click QUARANTINE right then``n``n" +
    "SCAN 2 -- DEEP SCAN (run it overnight):``n" +
    "  Three dots -> Advanced Scan -> Deep Scan.``n" +
    "  Start it before bed and leave the lid open.``n" +
    "  The screen may go dark -- the scan keeps running.``n``n" +
    "Malwarebytes does NOT scan by itself on the free version.``n" +
    "This reminder is your prompt to run the scans yourself.",
    "GatewayGuard -- Monthly Malwarebytes Scan Reminder",
    [System.Windows.Forms.MessageBoxButtons]::OK,
    [System.Windows.Forms.MessageBoxIcon]::Information
) | Out-Null
"@
        $reminderCode | Out-File -FilePath "$scriptDir\MBReminder.ps1" -Encoding UTF8 -Force

        # FT-93/93b (ascii33): schtasks.exe -- native monthly recurrence,
        # runs as the current interactive user so the popup shows on
        # their desktop (no /ru = current user).
        # FT-109 (ascii34): this task's /tr happened to survive in the field
        # (its exe, "powershell.exe", has no space in its own path -- only
        # the -File argument does), but it uses the exact same fragile
        # construction as Task 1 above. Switched to Invoke-SchTasksCreate
        # for both, per the codebase's own rule to fix a pattern everywhere
        # once found, not just where it's been observed failing.
        $ggT2Name = "GatewayGuard - Monthly Malwarebytes Reminder"
        $ggT2Tr = 'powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File \"' + "$scriptDir\MBReminder.ps1" + '\"'
        $ggT2Args = "/create /f /tn `"$ggT2Name`" /tr `"$ggT2Tr`" /sc monthly /d 1 /st 10:00"
        $ggT2Result = Invoke-SchTasksCreate -Arguments $ggT2Args
        if ($ggT2Result.ExitCode -ne 0) { throw "schtasks exit $($ggT2Result.ExitCode) -- $($ggT2Result.Output)" }

        # FT-203 (ascii44): the task exists, but schtasks left it unable to
        # run on battery and unable to catch up a missed start. Fix the three
        # settings, then LOG WHAT WAS READ BACK.
        $ggSetT2 = Set-GGTaskSettings -TaskName $ggT2Name
        if ($ggSetT2.Ok) {
            Write-Log -Message ("Reminder settings confirmed by read-back -- runs on battery: yes, catches a missed start: yes, wakes the PC: no (T2)") -Status "GOOD"
        } elseif ($ggSetT2.Error) {
            $results += @{ Text = "  [!] Reminder created, but its battery settings could not be adjusted -- it may not run on battery"; Color = "Yellow" }
            Write-Log -Message ("Reminder settings NOT adjusted (T2) -- $($ggSetT2.Error)") -Status "WARN"
        } else {
            $results += @{ Text = "  [!] Reminder created, but its battery settings did not take -- it may not run on battery"; Color = "Yellow" }
            Write-Log -Message ("Reminder settings read back WRONG (T2) -- StartWhenAvailable=$($ggSetT2.StartWhenAvailable) DisallowStartIfOnBatteries=$($ggSetT2.DisallowStartIfOnBatteries) StopIfGoingOnBatteries=$($ggSetT2.StopIfGoingOnBatteries)") -Status "WARN"
        }

        $results += @{ Text = "  [OK] Monthly Malwarebytes scan reminder scheduled (1st of each month @ 10AM)"; Color = "Green" }
        Write-Log -Message "Scheduled task created: GatewayGuard - Monthly Malwarebytes Reminder" -Status "GOOD"
    } catch {
        $results += @{ Text = "  [!] Monthly MB reminder task -- could not create: $_"; Color = "Yellow" }
        Write-Log -Message "Scheduled task ERROR: Monthly Malwarebytes Reminder -- $_" -Status "ERROR"
    }

    foreach ($r in $results) { Write-Host $r.Text -ForegroundColor $r.Color }

    Write-Host ""
    Write-Host "  IMPORTANT -- HOW THE QUARTERLY REMINDER WORKS:" -ForegroundColor White
    Write-Host "  Four times a year -- January, April, July and October -- a" -ForegroundColor Gray
    Write-Host "  message appears telling you your offline scan is due, with" -ForegroundColor Gray
    Write-Host "  the steps for starting it. YOU choose when to start it." -ForegroundColor Gray
    Write-Host "  Checkup never starts a scan, and never restarts your" -ForegroundColor Gray
    Write-Host "  computer, without your permission." -ForegroundColor Gray
    Write-Host "  The scan itself runs before Windows loads, which is how it" -ForegroundColor Gray
    Write-Host "  catches things that hide while the computer is running." -ForegroundColor Gray
    Write-Host ""
    Write-Host "  To confirm they were created: press the Windows key, type" -ForegroundColor DarkGray
    Write-Host "  Task Scheduler, open it, and look for two 'GatewayGuard' tasks." -ForegroundColor DarkGray
    Write-Host ""
    Pause-ForUser
}

# ============================================================
# BITLOCKER TIME ESTIMATE
# ============================================================
function Get-BitLockerTimeEstimate {
    try {
        $cDrive = Get-PSDrive C -EA Stop
        $driveGB = [math]::Round(($cDrive.Used + $cDrive.Free) / 1GB)
        # FT-178b (ascii41): was Get-PhysicalDisk | Select-Object -First 1,
        # i.e. the first ENUMERATED disk, which on a two-disk PC need not be
        # the one being encrypted. The estimate is about C:, so find C:.
        # VERIFIED 2026-08-17 measured on CGDELL: Get-Partition -DriveLetter C
        # | Get-Disk returns disk number 0, and the physical disk with that
        # DeviceId reports MediaType 'SSD'. Falls back to the old behaviour
        # if the Storage module is unavailable, so nothing regresses.
        $disk = $null
        try {
            $ggSysDisk = Get-Partition -DriveLetter C -EA Stop | Get-Disk -EA Stop
            $disk = Get-PhysicalDisk -EA Stop | Where-Object { $_.DeviceId -eq [string]$ggSysDisk.Number }
        } catch { $disk = $null }
        if (-not $disk) { $disk = Get-PhysicalDisk -EA SilentlyContinue | Select-Object -First 1 }
        $isSSD = ($disk -and $disk.MediaType -match "SSD|Solid")
        $ramGB = if ($global:RAMGB -gt 0) { $global:RAMGB } else { 8 }

        if ($isSSD) {
            if ($ramGB -le 8)      { $estimate = "1-3 hours";     $severity = "medium" }
            elseif ($ramGB -le 16) { $estimate = "45 min-2 hours"; $severity = "medium" }
            else                   { $estimate = "20-60 minutes";  $severity = "low" }
        } else {
            $minH = [math]::Max(2, [math]::Round($driveGB / 200))
            $maxH = [math]::Max(4, [math]::Round($driveGB / 80))
            $estimate = "$minH-$maxH hours"
            $severity = if ($maxH -ge 6) { "high" } else { "medium" }
        }

        return [PSCustomObject]@{
            DriveGB   = $driveGB
            DriveType = if ($isSSD) { "SSD (solid state)" } elseif ($disk) { "HDD (hard drive)" } else { "Unknown type" }
            RAMGB     = $ramGB
            Estimate  = $estimate
            Severity  = $severity
        }
    } catch {
        return [PSCustomObject]@{ DriveGB=0; DriveType="Unknown"; RAMGB=$global:RAMGB; Estimate="several hours"; Severity="high" }
    }
}

function Save-BitLockerKey {
    param($Key)
    # Bill, 2026-08-18: no cloud. This wrote to GetFolderPath('Desktop'),
    # which on any machine with OneDrive Known Folder Move resolves INTO
    # OneDrive -- measured on CGDELL, C:\Users\willi\OneDrive\Desktop.
    # The recovery key is the most sensitive file Checkup produces and it
    # has been going to the cloud on every such machine by accident. The
    # user is taken to this folder on screen, so it is no harder to find.
    if (-not (Test-Path $GGUserDir)) { New-Item -Path $GGUserDir -ItemType Directory -Force | Out-Null }
    $global:BitLockerKeyPath = Join-Path $GGUserDir ("BitLocker-Recovery-Key-" + (Get-Date -Format 'yyyy-MM-dd') + ".txt")   # FT-75
    @"
========================================================
  BITLOCKER / DEVICE ENCRYPTION RECOVERY KEY
  Generated: $(Get-Date)
  Computer:  $env:COMPUTERNAME
  Windows:   $global:WinEdition
========================================================

  Recovery Key ID: $($Key.KeyProtectorId)
  Recovery Key:    $($Key.RecoveryPassword)

========================================================
  !  YOU MUST DO BOTH OF THE FOLLOWING:

  1. COPY THIS FILE TO A USB DRIVE
     Store the USB somewhere SAFE -- NOT near this PC.

  2. PRINT THIS PAGE
     Store the printout SEPARATELY from the computer.
     Suggested: fireproof box, safe, or bank.

  IF WINDOWS ASKS FOR THIS KEY AT STARTUP AND YOU
  CANNOT PROVIDE IT, YOUR FILES CANNOT BE RECOVERED.
  There are NO exceptions. No one can help you.

  See Guide: Phase 1, Step 3 at $GuideURL
========================================================
"@ | Out-File -FilePath $global:BitLockerKeyPath -Encoding UTF8
}

# ============================================================
# BITLOCKER DEDICATED SCREEN (always LAST)
# ============================================================
# ============================================================
# BITLOCKER DECISION FLOW (FT-67, ascii29)
# Shown at review (console mode) when the drive is NOT encrypted
# and item 8 is not selected: HEADS UP -> full write-up (S) ->
# final confirmation. N at either screen returns to the checklist.
# ============================================================
function Show-BitLockerWhyEncrypt {
    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "60" -Color White -Lines @(
        "  DRIVE ENCRYPTION (BitLocker) -- WHAT IT IS, WHY IT MATTERS ",
        "---",
        "  WHAT IT DOES                                               ",
        "  BitLocker is built into Windows. It scrambles (encrypts)   ",
        "  everything on your hard drive. Only this computer,         ",
        "  unlocked with your normal sign-in, can unscramble it.      ",
        "                                                             ",
        "  WHY WE RECOMMEND IT                                        ",
        "  If your laptop is ever lost or stolen, a thief can pull    ",
        "  out the drive, connect it to another computer, and read    ",
        "  every file on it -- taxes, banking, photos -- without      ",
        "  ever knowing your Windows password. Encryption closes      ",
        "  that door: a stolen encrypted drive is unreadable.         ",
        "                                                             ",
        "  WHAT IT COSTS YOU                                          ",
        "  * One overnight run. It never needs to run again.          ",
        "  * No noticeable slowdown on a modern PC.                   ",
        "  * You MUST keep your recovery key. The tool saves it for   ",
        "    you and shows you where. Keep a copy OFF this computer   ",
        "    -- printed, or in your password manager.                 ",
        "                                                             ",
        "  THE ONE REAL RISK                                          ",
        "  If Windows ever asks for the recovery key at startup and   ",
        "  you cannot find it, your files stay locked. That is why    ",
        "  saving the key is step one, BEFORE anything is encrypted.  ",
        "                                                             ",
        "  RECOMMENDATION: Turn this ON. For a laptop, this is one    ",
        "  of the most valuable protections in this entire tool.      "
    )
    Pause-ForUser "  Press Enter or Space to return..."
}

function Show-BitLockerFinalDecline {
    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "68" -Color White -Lines @(
        "  YOUR CHOICE IS NOTED -- NO ENCRYPTION WILL BE APPLIED      ",
        "---",
        "  That is entirely your call -- this is your computer, and   ",
        "  Checkup never applies anything you did not choose.         ",
        "                                                             ",
        "  Two things worth knowing:                                  ",
        "                                                             ",
        "  1. You can turn encryption on any time. Run Checkup        ",
        "     again and select item 8, Drive Encryption. One          ",
        "     overnight run and it is done.                           ",
        "                                                             ",
        "  2. Until then, treat this laptop like a wallet: know       ",
        "     where it is, especially when traveling.                 "
    )
    Write-Host ""
    # FT-243 (ascii44): the log notice used to live here. This screen is
    # reached ONLY by declining encryption, so a user who accepted it
    # never saw the notice at all -- and the rule says it belongs on the
    # review screen. Moved there; the once-only guard moved with it.
    $fd = Read-ValidKey -ValidKeys @("Y","B") -Prompt "Continue WITHOUT encryption? (Y = Yes, continue / B = Go back and select it): "
    if ($fd.ToUpper() -eq "B") { return "GoBack" }
    Write-Log -Message "NOTED: User chose not to apply: Drive Encryption (BitLocker) -- Status: not encrypted -- can be enabled later by re-running the tool" -Status "NOTED"
    return "Skip"
}

function Show-BitLockerDeclineHeadsUp {
    do {
        Clear-Host
        Write-Host ""
        Draw-Box -ScreenId "58" -Color White -Lines @(
            "  HEADS UP -- YOU HAVE NOT SELECTED DRIVE ENCRYPTION        ",
            "---",
            "  Drive encryption (item 8, BitLocker) is not selected.     ",
            "                                                            ",
            "  Everything else Checkup does protects a computer that     ",
            "  is in your hands. Encryption is the one item that         ",
            "  protects your files if the computer LEAVES your hands --  ",
            "  lost, stolen, or sold without being wiped.                ",
            "                                                            ",
            "  Without it, anyone holding this laptop can read your      ",
            "  files by connecting the drive to another computer.        ",
            "  Your Windows password does not stop that.                 "
        )
        Write-Host ""
        Write-Host "  Y = Continue WITHOUT encryption" -ForegroundColor White
        Write-Host "  B = Go back and select encryption" -ForegroundColor White
        Write-Host "  S = Show me the full explanation" -ForegroundColor White
        Write-Host ""
        $bd = Read-ValidKey -ValidKeys @("Y","B","S") -Prompt "Your choice (Y = Continue / B = Go back / S = Show me): "
        if ($bd.ToUpper() -eq "S") {
            # Drain buffered auto-repeats of the accepted key (FT-65)
            try { while ($Host.UI.RawUI.KeyAvailable) { $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") } } catch {}
            Show-BitLockerWhyEncrypt
        }
    } while ($bd.ToUpper() -eq "S")
    if ($bd.ToUpper() -eq "B") { return "GoBack" }
    return Show-BitLockerFinalDecline
}

# FT-110/D-20 (ascii34): checks the three Device Encryption prerequisites
# that have simple, reliable, non-edition-gated PowerShell checks (TPM,
# Secure Boot, WinRE). Deliberately does NOT try to reimplement Windows'
# full "Device Encryption Support" eligibility logic (which also covers
# DMA-capable bus/device checks and PCR7 binding that Microsoft does not
# document a script-friendly way to query) -- per RESEARCH BEFORE STATING,
# GatewayGuard defers to msinfo32's own "Device Encryption Support" field
# as the authoritative source for anything beyond these three, rather than
# guess at Microsoft's internal criteria (same C-27/D-11 philosophy: don't
# replicate what the OS already knows how to determine for itself).
function Test-DeviceEncryptionPrereq {
    $result = [PSCustomObject]@{ TpmReady = $false; SecureBoot = $false; WinRE = $false }
    try {
        $tpm = Get-Tpm -EA Stop
        $result.TpmReady = [bool]($tpm.TpmPresent -and $tpm.TpmEnabled -and $tpm.TpmActivated -and $tpm.TpmReady)
    } catch { Write-Verbose "Non-fatal: $_" }
    try {
        $result.SecureBoot = [bool](Confirm-SecureBootUEFI -EA Stop)
    } catch { Write-Verbose "Non-fatal: $_" }
    try {
        $reInfo = reagentc /info 2>&1 | Out-String
        $result.WinRE = ($reInfo -match "Windows RE status:\s*Enabled")
    } catch { Write-Verbose "Non-fatal: $_" }
    return $result
}

function Get-SignInAccountType {
    # FT-144 (ascii39): LOCAL ACCOUNT vs MICROSOFT ACCOUNT.
    # Field-confirmed 2026-07-29: Sandy encrypted itself while signed in to a
    # LOCAL account, so the recovery key existed in no Microsoft account and
    # nowhere else. Windows PROMPTS for a Microsoft account but does not
    # REQUIRE one before encrypting. An encrypted drive whose key exists
    # nowhere is a data-loss event waiting for a firmware update.
    # Returns: "Microsoft" / "Local" / "Unknown"
    # RESEARCH BEFORE STATING: two independent methods, and Unknown when
    # neither answers. This decides what the user is told about their key, so
    # guessing here is worse than admitting the gap.
    try {
        $ggU = Get-LocalUser -Name $env:USERNAME -EA Stop
        $ggPS = [string]$ggU.PrincipalSource
        if ($ggPS -match "MicrosoftAccount") { return "Microsoft" }
        if ($ggPS -match "Local")            { return "Local" }
    } catch {}
    try {
        # An MSA-linked profile leaves identity keys behind; a purely local
        # account does not.
        $ggIdp = Get-ChildItem "HKCU:\Software\Microsoft\IdentityCRL\UserExtendedProperties" -EA Stop
        if ($ggIdp -and @($ggIdp).Count -gt 0) { return "Microsoft" }
        return "Local"
    } catch {}
    return "Unknown"
}

function Get-EncryptionProgress {
    # FT-145 (ascii39): WINDOWS SHOWS A PROGRESS BAR WHEN ENCRYPTING AND
    # NOTHING AT ALL WHEN DECRYPTING. Field note (2026-07-29): the tester was
    # left unable to work out whether it was safe to reboot. Checkup can answer
    # that in three lines, and it fills a gap Windows leaves open on the exact
    # edition our users have.
    # Returns an object: State (plain words), Percent (or -1), Raw.
    $ggR = [PSCustomObject]@{ State = "Unknown"; Percent = -1; Raw = "" }
    try {
        $ggV = Get-BitLockerVolume -MountPoint $env:SystemDrive -EA Stop
        $ggR.Raw = [string]$ggV.VolumeStatus
        $ggR.Percent = [int]$ggV.EncryptionPercentage
        switch -Wildcard ([string]$ggV.VolumeStatus) {
            "FullyEncrypted"      { $ggR.State = "Encrypted"; break }
            "FullyDecrypted"      { $ggR.State = "Not encrypted"; break }
            "EncryptionInProgress"{ $ggR.State = "Encrypting now"; break }
            "DecryptionInProgress"{ $ggR.State = "Removing encryption now"; break }
            default               { $ggR.State = "Unknown"; break }
        }
        return $ggR
    } catch {}
    try {
        # Home machines can refuse the cmdlet. manage-bde is present on Home.
        # Class 4 rule 4: capture stderr and log the RAW output before parsing.
        $ggOut = & manage-bde.exe -status $env:SystemDrive 2>&1 | Out-String
        $ggR.Raw = ($ggOut -replace "\s+", " ").Trim()
        if ($ggOut -match "Percentage Encrypted:\s*([0-9.]+)") { $ggR.Percent = [int][double]$Matches[1] }
        if     ($ggOut -match "Conversion Status:\s*Fully Encrypted")        { $ggR.State = "Encrypted" }
        elseif ($ggOut -match "Conversion Status:\s*Fully Decrypted")        { $ggR.State = "Not encrypted" }
        elseif ($ggOut -match "Conversion Status:\s*Encryption in Progress") { $ggR.State = "Encrypting now" }
        elseif ($ggOut -match "Conversion Status:\s*Decryption in Progress") { $ggR.State = "Removing encryption now" }
    } catch {}
    return $ggR
}

function Show-BitLockerHomeScreen {
    # FT-156 (ascii39): REBUILT. Field note 22 (2026-07-30) is the longest
    # single complaint in the ascii38 round and every sentence of it is a
    # separate gap: no step-by-step for signing in to a Microsoft account; no
    # answer for a user who does not have one; never says whether the recovery
    # key is saved before or after encryption; never says how to tell whether
    # encryption is running; never says whether to reboot or quit Checkup.
    # "Users will feel lost." They were right to.
    # The old version was ONE screen carrying all of that badly. It is now four
    # screens that each answer one question, under the 26-line rule (FT-153).
    Clear-Host
    Write-Host ""
    $ggEnc = Get-EncryptionProgress
    $ggAcct = Get-SignInAccountType
    Write-Log -Message ("Device Encryption state: " + $ggEnc.State + " (" + $ggEnc.Percent + "%), account type: " + $ggAcct + " -- raw: " + $ggEnc.Raw) -Status "INFO"

    # ---- Screen 1 of 4: what this is, and what YOUR PC is doing right now ----
    $ggNowLine = switch ($ggEnc.State) {
        "Encrypted"               { "  RIGHT NOW: this PC IS encrypted." }
        "Not encrypted"           { "  RIGHT NOW: this PC is NOT encrypted yet." }
        "Encrypting now"          { "  RIGHT NOW: encryption is RUNNING -- " + $ggEnc.Percent + "% done." }
        "Removing encryption now" { "  RIGHT NOW: encryption is being REMOVED -- " + $ggEnc.Percent + "% left." }
        default                   { "  RIGHT NOW: Checkup could not read the encryption state." }
    }
    Draw-Box -ScreenId "61" -Color White -Lines @(
        "  FINAL ITEM: DEVICE ENCRYPTION (Windows 11 Home)          ",
        "  Guide: Phase 1, Step 3  |  $GuideURL",
        "---",
        "  Encryption scrambles everything on your drive so that a  ",
        "  thief who takes the PC cannot read your files.           ",
        "                                                           ",
        "  Windows 11 Home calls it Device Encryption. It is the    ",
        "  same protection as BitLocker on Pro, but Windows turns   ",
        "  it on itself -- Checkup cannot turn it on for you, and   ",
        "  does not try.                                            ",
        "                                                           ",
        $ggNowLine
    )
    Write-Host ""
    Pause-ForUser "  Press Enter or Space to see if this PC can use it..."

    # ---- Screen 2 of 4: the three requirements ----
    Clear-Host
    Write-Host ""
    Write-Host "  Checking this PC's requirements for Device Encryption..." -ForegroundColor Cyan
    $prereq = Test-DeviceEncryptionPrereq
    Write-Host ""
    Write-Host "  TPM (security chip):      $(if ($prereq.TpmReady)   { 'READY -- GOOD' }       else { 'NOT READY' })" -ForegroundColor $(if ($prereq.TpmReady)   { 'Green' } else { 'Yellow' })
    Write-Host "  Secure Boot:              $(if ($prereq.SecureBoot) { 'ON -- GOOD' }          else { 'OFF' })" -ForegroundColor $(if ($prereq.SecureBoot) { 'Green' } else { 'Yellow' })
    Write-Host "  Windows Recovery (WinRE): $(if ($prereq.WinRE)      { 'CONFIGURED -- GOOD' }  else { 'NOT CONFIGURED' })" -ForegroundColor $(if ($prereq.WinRE) { 'Green' } else { 'Yellow' })
    Write-Host ""

    $allGood = $prereq.TpmReady -and $prereq.SecureBoot -and $prereq.WinRE
    Write-Log -Message "Device Encryption prereq check -- TPM: $($prereq.TpmReady), SecureBoot: $($prereq.SecureBoot), WinRE: $($prereq.WinRE)" -Status $(if ($allGood) { "GOOD" } else { "INFO" })

    if (-not $allGood) {
        Draw-Box -ScreenId "63" -Color Yellow -Lines @(
            "  DEVICE ENCRYPTION MAY NOT BE AVAILABLE ON THIS PC        ",
            "---",
            "  One or more requirements above are not met. Some PCs     ",
            "  cannot use Device Encryption no matter what you change.  ",
            "                                                           ",
            "  To see the exact reason for THIS PC:                     ",
            "  1. Press the Windows key, type  msinfo32  and press Enter",
            "  2. Look for 'Device Encryption Support' in the list      ",
            "  3. It states the specific reason if it is not supported  ",
            "                                                           ",
            "  Nothing is wrong with your PC if it cannot do this. It   ",
            "  is a hardware feature, and every other setting Checkup   ",
            "  offers still protects you."
        )
        Write-Host ""
        Write-Log -Message "BitLocker/Device Encryption: Home edition -- prerequisites not met, manual path shown, no changes made by Checkup" -Status "SKIP"
        Pause-ForUser
        return
    }

    Draw-Box -ScreenId "62" -Color Green -Lines @(
        "  YOUR PC MEETS THE REQUIREMENTS                            ",
        "---",
        "  All three checks above passed, so this PC can use Device  ",
        "  Encryption.                                               ",
        "                                                            ",
        "  The next two screens matter more than this one. Please    ",
        "  read them before you turn anything on -- they are about   ",
        "  your RECOVERY KEY, which is the only way back in if       ",
        "  Windows ever asks for it."
    )
    Write-Host ""
    Pause-ForUser "  Press Enter or Space to read about your recovery key..."

    # ---- Screen 3 of 4: the recovery key, as a PRECONDITION (FT-144) ----
    Clear-Host
    Write-Host ""
    # FT-144 REMOVED (ascii41, Bill 2026-08-17). The account-type line and
    # the warning it introduced are gone -- see build_ascii41_ft144.py for
    # the full reasoning. Get-SignInAccountType is still called above: it
    # is logged, and it still decides between SCREEN-80 and SCREEN-82.
    Draw-Box -ScreenId "79" -Color Yellow -Lines @(
        "  BEFORE YOU TURN IT ON -- YOUR RECOVERY KEY                ",
        "---",
        "  A recovery key is a long number Windows may ask for when  ",
        "  you start the PC -- after a firmware update, a repair, or ",
        "  a hardware change. WITHOUT IT, THE FILES ARE GONE. Not    ",
        "  locked. Gone. Nobody can recover them, including us and   ",
        "  including Microsoft.                                      ",
        "                                                            ",
        "  Windows shows you the key when encryption STARTS, not     ",
        "  when it finishes. Look for it as soon as it begins --     ",
        "  not hours later. Print it, or copy it to a USB drive,     ",
        "  and keep that away from this computer.                    "
    )
    Write-Host ""
    Pause-ForUser "  Press Enter or Space for the step-by-step sign-in..."

    # ---- Screen 4 of 4: step by step, both cases, and how to check ----
    Clear-Host
    Write-Host ""
    if ($ggAcct -eq "Microsoft") {
        Draw-Box -ScreenId "82" -Color White -Lines @(
            "  YOU ARE ALREADY SIGNED IN WITH A MICROSOFT ACCOUNT       ",
            "---",
            "  Nothing to change. Windows turns Device Encryption on    ",
            "  by itself, usually within a few minutes of meeting the   ",
            "  requirements. You do NOT need to reboot, and you do NOT  ",
            "  need to leave Checkup open.                              ",
            "                                                           ",
            "  CONFIRM YOUR KEY WAS SAVED -- do this today:             ",
            "  1. Open a web browser                                    ",
            "  2. Go to  account.microsoft.com/devices/recoverykey      ",
            "  3. Sign in with the same Microsoft account               ",
            "  4. Check that THIS PC is listed there                    ",
            "                                                           ",
            "  If it is NOT listed, the key is not saved. Do not rely   ",
            "  on encryption until it appears."
        )
    } else {
        Draw-Box -ScreenId "80" -Color White -Lines @(
            "  HOW TO SIGN IN WITH A MICROSOFT ACCOUNT                  ",
            "---",
            "  1. Press the Windows key, type  settings  and press      ",
            "  2. Click Accounts                                        ",
            "  3. Click 'Your info'                                     ",
            "  4. Click 'Sign in with a Microsoft account instead'      ",
            "  5. Enter your email address and password                 ",
            "  6. Windows asks for your CURRENT Windows password once   ",
            "                                                           ",
            "  IF THAT LINK IS NOT THERE: you are already signed in     ",
            "  with a Microsoft account. Nothing to do.                 ",
            "                                                           ",
            "  IF YOU DO NOT HAVE A MICROSOFT ACCOUNT: you can make one ",
            "  free at  account.microsoft.com  -- click 'Create one'.   ",
            "  It needs an email address you can receive mail at. Any   ",
            "  address works; it does not have to be an outlook.com     ",
            "  one. This is the same account that stores your key, so   ",
            "  use one you will still have access to in five years."
        )
    }
    Write-Host ""
    Pause-ForUser "  Press Enter or Space for how to check it is working..."

    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "81" -Color White -Lines @(
        "  HOW TO TELL IF ENCRYPTION IS ACTUALLY RUNNING            ",
        "---",
        "  Windows shows a progress bar while it encrypts and shows  ",
        "  NOTHING while it removes encryption, which is why this is ",
        "  confusing. Here is how to look it up yourself, any time:  ",
        "                                                            ",
        "  1. Press the Windows key, type  settings, press Enter     ",
        "  2. In Settings, search for  device encryption             ",
        "     Look at the switch. It should say On.                  ",
        "     If it does not, turn it on.                            ",
        "                                                            ",
        "  IF THAT PAGE IS NOT THERE, use this instead:              ",
        "  1. Press the Windows key, type  cmd                       ",
        "  2. Press Enter, then type:  manage-bde -status            ",  # GATE24-OK: the user is told to type this. It is the Home-edition fallback when the Device Encryption page is absent, so removing it leaves that user a dead end.
        "  3. Read the line 'Percentage Encrypted'                   ",
        "                                                            ",
        "  DO YOU NEED TO REBOOT OR QUIT CHECKUP? No, to both.       ",
        "  Encryption runs in the background and you can keep        ",
        "  using the PC. An hour or more is normal on a big drive.   ",
        "                                                            ",
        "  Run Checkup again any time and this screen will tell you  ",
        "  where it got to."
    )
    Write-Host ""
    Write-Log -Message "BitLocker/Device Encryption: Home edition -- manual path shown across 4 screens, no changes made by Checkup" -Status "SKIP"
    Pause-ForUser
}

function Show-BitLockerScreen {
    try {
        $vol = Get-BitLockerVolume -MountPoint $env:SystemDrive -EA Stop
        if ($vol.ProtectionStatus -eq "On") {
            Write-Host ""
            Write-Host "  BitLocker / Device Encryption: Already enabled -- GOOD" -ForegroundColor Green
            Write-Log -Message "BitLocker already enabled -- no change needed" -Status "GOOD"
            Pause-ForUser
            return
        }
    } catch {}

    # FT-110/D-20 (ascii34): Enable-BitLocker/manage-bde full management is
    # licensed to Pro/Enterprise/Education only -- on Home it throws
    # 0x8031005A (FVE_E_NO_FEATURE_LICENSE), field-confirmed on HP SANDY
    # (2026-07-21). Home has Device Encryption instead: same underlying
    # encryption, but it activates automatically once hardware prereqs are
    # met AND the user is signed in with a Microsoft account -- there is no
    # supported Enable-BitLocker path on Home at all. Get-BitLockerVolume
    # (read-only status, checked above) is not edition-gated and still
    # works; only the enable/manage cmdlets are Pro-only. Never call
    # Enable-BitLocker below this point on Home.
    $isHome = $global:WinEdition -notmatch "Pro|Enterprise|Education|Business"
    if ($isHome) {
        Show-BitLockerHomeScreen
        return
    }

    # --- Re-check power status NOW (may have changed since pre-flight) ---
    try {
        $blBatt = Get-WmiObject -Class Win32_Battery -EA SilentlyContinue
        $blOnBattery = ($null -ne $blBatt -and $blBatt.BatteryStatus -eq 1)
        $blBattPct   = if ($null -ne $blBatt -and $blBatt.EstimatedChargeRemaining) { "$($blBatt.EstimatedChargeRemaining)%" } else { "N/A" }
        $global:OnBattery = $blOnBattery
    } catch {
        $blOnBattery = $global:OnBattery
        $blBattPct   = "Unknown"
    }

    # --- If on battery, require AC power BEFORE showing options ---
    if ($blOnBattery) {
        Clear-Host
        Write-Host ""
        Draw-Box -ScreenId "64" -Color White -Lines @(
            "  !!  BITLOCKER REQUIRES AC POWER                       ",
            "---",
            "  You are currently running on BATTERY ($blBattPct).    ",
            "                                                         ",
            "  BitLocker can take several hours. If your PC loses     ",
            "  power mid-encryption, the drive may be unrecoverable.  ",
            "                                                         ",
            "  Please plug into AC power before continuing.           "
        )
        Write-Host ""
        Write-Host "  Plug in AC power, then press Enter or Space to continue..." -ForegroundColor Yellow
        Write-Host "  Or press S to skip BitLocker for now." -ForegroundColor Gray
        Write-Host ""
        # BUGFIX ascii23 (2026-07-10, FT-01): same unprotected-ReadKey issue
        # as the main checklist -- see note there for full explanation.
        # FT-46 (ascii28): re-assert Ctrl+C-as-input before every read
        try { [Console]::TreatControlCAsInput = $true } catch {}
        try {
            $blKey = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        } catch {
            Write-Log -Message "ReadKey failed on BitLocker battery screen (focus loss?) -- falling back: $_" -Status "WARN"
            $blFallback = Read-Host
            $blKey = [PSCustomObject]@{ Character = if ($blFallback.Length -gt 0) { $blFallback.Substring(0,1) } else { "" } }
        }
        # FT-69 (ascii29): Ctrl+C opens the exit confirmation
        if ($blKey.Character -eq [char]3) { Invoke-CtrlCExit }
        if ($blKey.Character -match "^[Ss]$") {
            Write-Host "  BitLocker skipped. Enable later via Settings -> Privacy & security -> Device encryption." -ForegroundColor Yellow
            Write-Log -Message "BitLocker skipped -- on battery, user chose to skip" -Status "SKIP"
            Pause-ForUser
            return
        }
        # Re-check after user plugged in
        $blBatt2 = Get-WmiObject -Class Win32_Battery -EA SilentlyContinue
        if ($null -ne $blBatt2 -and $blBatt2.BatteryStatus -eq 1) {
            Write-Host ""
            Write-Host "  Still on battery -- skipping BitLocker for safety." -ForegroundColor Red
            Write-Log -Message "BitLocker skipped -- still on battery after prompt" -Status "SKIP"
            Pause-ForUser
            return
        }
        $global:OnBattery = $false
        $blOnBattery = $false
    }

    $info = Get-BitLockerTimeEstimate
    $blPowerStatus = if ($blOnBattery) { "BATTERY ($blBattPct) -- plug in AC power" } else { "AC power -- OK to proceed" }

    # Pre-BitLocker prep checklist (UX-11) -- explicit confirmation required
    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "65" -Color White -Lines @(
        "  BEFORE ENABLING BITLOCKER, YOU MUST:                      ",
        "---",
        "  1. Back up your important files first -- copy anything     ",
        "     you cannot afford to lose, BEFORE encryption starts.    ",
        "     Simplest way -- copy to a USB or external drive:        ",
        "       a. Plug in the USB or external drive                 ",
        "       b. Press the Windows key + E to open File Explorer    ",
        "       c. Open your Documents, Pictures, Desktop, and        ",
        "          Downloads folders                                 ",
        "       d. Select the files, then drag them onto your USB     ",
        "          drive (listed under 'This PC') -- or copy them     ",
        "          [Ctrl+C], open the drive, and paste [Ctrl+V]       ",
        "       e. Wait for the copy to finish before removing the    ",
        "          drive                                              ",
        "     Already use OneDrive? Files inside your OneDrive        ",
        "     folder are already backed up automatically.             ",
        "  2. Save your Recovery Key -- you will need it if you ever  ",
        "     get locked out                                         ",
        "  3. Print your Recovery Key and store it with your          ",
        "     important documents (birth certificate, passport,       ",
        "     insurance papers) -- NOT near your computer             ",
        "  4. Also save it to your Microsoft account as a backup      ",
        "  5. Plug in your power adapter -- encryption can take a     ",
        "     long time                                               ",
        "  6. Do not turn off, restart, or close the lid during       ",
        "     encryption                                              ",
        "                                                             ",
        "  WARNING: If you lose your Recovery Key and get locked out, ",
        "  your data CANNOT be recovered by anyone -- not even        ",
        "  Microsoft.                                                 "
    )
    Write-Host ""
    # FT-77 (ascii31): tell user next screen handles everything
    Write-Host ""
    Write-Host "  The next screen lets Checkup save your key and start" -ForegroundColor Cyan
    Write-Host "  encryption for you -- no manual steps needed." -ForegroundColor Cyan
    Write-Host ""
    $blPrepConfirm = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Ready to continue? (Y = Show me my options / N = Skip for now): "
    if ($blPrepConfirm.ToUpper() -eq "N") {
        Write-Host ""
        Write-Host "  No problem. Run Checkup again when you are ready." -ForegroundColor Yellow
        Write-Log -Message "BitLocker skipped -- user not ready for Recovery Key prep" -Status "SKIP"
        Pause-ForUser
        return
    }

    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "66" -Color White -Lines @(
        "  FINAL ITEM: BitLocker / Device Encryption",
        "  Guide: Phase 1, Step 3  |  $GuideURL",
        "---",
        "  BitLocker encrypts your entire drive. If your PC is lost",
        "  or stolen, no one can read your files without your",
        "  password. A recovery key will be saved to your Desktop.",
        "  You MUST copy it to USB and print it before finishing.",
        "---",
        "  YOUR PC:",
        "  RAM:    $($info.RAMGB) GB $(if ($info.RAMGB -le 8) { '(minimal -- encryption will be slow)' } elseif ($info.RAMGB -le 16) { '(moderate)' } else { '(ample)' })",
        "  Drive:  $($info.DriveGB) GB $($info.DriveType)",
        "  Time estimate: $($info.Estimate)",
        "  Power:  $blPowerStatus"
    )
    Write-Host ""

    switch ($info.Severity) {
        "low"    { Write-Host "  [1] Enable now -- $($info.Estimate), minimal impact" -ForegroundColor Green }
        "medium" { Write-Host "  [1] Enable now -- $($info.Estimate), some slowdown while encrypting" -ForegroundColor Yellow }
        "high"   { Write-Host "  [1] Enable now -- $($info.Estimate), significant slowdown expected" -ForegroundColor Red }
    }
    Write-Host "      Sleep will be set to Never automatically. PC must stay ON and plugged in." -ForegroundColor DarkGray
    Write-Host ""

    switch ($info.Severity) {
        "low"    { Write-Host "  [2] Enable overnight -- fine if you prefer" -ForegroundColor White }
        "medium" { Write-Host "  [2] Enable overnight -- convenient for this time estimate" -ForegroundColor White }
        "high"   { Write-Host "  [2] Enable overnight -- RECOMMENDED for your PC" -ForegroundColor Cyan }
    }
    Write-Host "      Sleep will be set to Never automatically. Check your GatewayGuard log in the morning." -ForegroundColor DarkGray
    Write-Host ""

    Write-Host "  [3] Skip for now -- enable manually when ready:" -ForegroundColor White
    Write-Host "      Settings -> Privacy & security -> Device encryption -> On" -ForegroundColor DarkGray
    Write-Host ""

    $choice = Read-ValidKey -ValidKeys @("1","2","3") -Prompt "Choose option (1, 2, or 3): "

    if ($choice -eq "3") {
        Write-Host ""
        Write-Host "  BitLocker skipped. Enable later via Device encryption in Settings." -ForegroundColor Yellow
        Write-Log -Message "BitLocker skipped by user. Drive: $($info.DriveGB)GB $($info.DriveType), RAM: $($info.RAMGB)GB, Estimate: $($info.Estimate)" -Status "SKIP"
        Pause-ForUser
        return
    }

    # --- Set sleep/display to Never before starting BitLocker ---
    Write-Host ""
    Write-Host "  Setting Sleep and Display to Never for encryption..." -ForegroundColor Cyan
    try {
        # Save original AC sleep and display timeout values
        $blOrigSleepRaw = powercfg /query SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 2>$null
        $blOrigDisplayRaw = powercfg /query SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 2>$null
        # FT-255 (ascii44): powercfg returns an ARRAY. On an array -match is a
        # FILTER and does NOT populate $Matches -- measured on CGDELL
        # 2026-09-06. Out-String makes it a scalar match, which is the
        # pattern already used at the screen-timeout and battery reads.
        # These two are the values RESTORED after an overnight encryption
        # run, so a wrong read here leaves the machine on the wrong timeouts.
        $blOrigSleep = if (($blOrigSleepRaw | Out-String) -match "Current AC Power Setting Index: 0x(\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { 0 }
        $blOrigDisplay = if (($blOrigDisplayRaw | Out-String) -match "Current AC Power Setting Index: 0x(\w+)") { [Convert]::ToUInt32($Matches[1], 16) } else { 0 }

        # Set both to Never (0 = never)
        powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0 | Out-Null
        powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0 | Out-Null
        powercfg /S SCHEME_CURRENT | Out-Null
        Write-Host "  Sleep: Never  |  Display: Never  (will restore after encryption)" -ForegroundColor Green
        $blSleepChanged = $true
    } catch {
        Write-Host "  Note: Could not auto-set sleep -- set manually if leaving overnight." -ForegroundColor Yellow
        $blSleepChanged = $false
        $blOrigSleep = 0
        $blOrigDisplay = 0
    }
    Write-Host ""

    if ($choice -eq "2") {
        if ($blSleepChanged) {
            Write-Host "  Starting encryption -- PC will continue overnight." -ForegroundColor Cyan
            Write-Host "  Sleep and display are set to Never. Check your GatewayGuard log in the morning." -ForegroundColor Yellow
        } else {
            # FT-111 (ascii34): sleep/display auto-set failed above (the Yellow
            # "Could not auto-set" note already printed) -- this line used to
            # claim "are set to Never" anyway, directly contradicting that
            # notice on the same screen (field-observed). An overnight run
            # with sleep NOT actually disabled risks the PC sleeping mid-
            # encryption, so require the user to confirm they set it manually
            # (or back out) instead of proceeding on a false assumption.
            Write-Host "  Sleep and display could NOT be set automatically." -ForegroundColor Red
            Write-Host "  Before leaving this overnight, set them manually:" -ForegroundColor Yellow
            Write-Host "  Settings -> System -> Power & sleep -> set both to Never" -ForegroundColor Yellow
            Write-Host ""
            $blSleepAck = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Have you set Sleep and Display to Never manually? (Y = Yes, continue / N = No, not yet): "
            if ($blSleepAck.ToUpper() -eq "N") {
                Write-Host ""
                Write-Host "  Set Sleep and Display to Never in Settings, then run Checkup again to enable BitLocker." -ForegroundColor Yellow
                Write-Log -Message "BitLocker overnight declined -- sleep could not be auto-set and user did not confirm manual change" -Status "SKIP"
                Pause-ForUser
                return
            }
            Write-Host ""
        }
    }

    try {
        Enable-BitLocker -MountPoint $env:SystemDrive -RecoveryPasswordProtector -EA Stop | Out-Null
        $key = (Get-BitLockerVolume -MountPoint $env:SystemDrive).KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }
        Save-BitLockerKey -Key $key
        $global:BitLockerKeyGenerated = $true
        Write-Log -Message "BitLocker enabled. Drive: $($info.DriveGB)GB $($info.DriveType), RAM: $($info.RAMGB)GB, Estimate: $($info.Estimate), Mode: $(if ($choice -eq '2') { 'overnight' } else { 'now' })" -Status "APPLIED"

        Write-Host ""
        Draw-Box -ScreenId "67" -Color White -Lines @(
            "  !  BITLOCKER RECOVERY KEY -- CRITICAL ACTION REQUIRED    ",
            "---",
            "  Recovery key saved to your Desktop:                      ",
            "  $(Split-Path $global:BitLockerKeyPath -Leaf)",
            "                                                           ",
            "  YOU MUST DO BOTH OF THE FOLLOWING RIGHT NOW:            ",
            "                                                           ",
            "  1. COPY the file to a USB drive stored AWAY from this   ",
            "     PC -- not in a drawer next to it.                     ",
            "                                                           ",
            "  2. PRINT the file and store the printout separately      ",
            "     from your PC -- fireproof box, safe, or bank.         ",
            "                                                           ",
            "  IF WINDOWS ASKS FOR THIS KEY AT STARTUP AND YOU         ",
            "  CANNOT PROVIDE IT, YOUR FILES CANNOT BE RECOVERED.      ",
            "  No exceptions. No one can help you without this key.    "
        )
        Write-Host ""
        Pause-ForUser "  Press Enter or Space ONLY after you have SAVED and PRINTED the recovery key..."
        $global:BitLockerKeyGenerated = $false
    } catch {
        Write-Host ""
        Write-Host "  ERROR: $_" -ForegroundColor Red
        Write-Host "  To enable manually: Settings -> Privacy & security -> Device encryption" -ForegroundColor Yellow
        Write-Log -Message "BitLocker error: $_" -Status "ERROR"
        Pause-ForUser
    }

    # --- Restore original sleep/display settings ---
    if ($blSleepChanged) {
        try {
            powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_SLEEP STANDBYIDLE $blOrigSleep | Out-Null
            powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE $blOrigDisplay | Out-Null
            powercfg /S SCHEME_CURRENT | Out-Null
            $restoreMsg = if ($blOrigSleep -eq 0) { "Never" } else { "$([math]::Round($blOrigSleep/60)) min" }
            Write-Log -Message "BitLocker: restored sleep to original setting ($restoreMsg)" -Status "INFO"
        } catch {
            Write-Log -Message "BitLocker: could not restore sleep settings -- $_" -Status "WARN"
        }
    }
}

# ============================================================
# MODE SELECTOR
# ============================================================
function Show-ModeSelector {
    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "52" -Color White -Lines @(
        "  GatewayGuard Checkup -- Windows 11 Security Hardening v$ScriptVersion ",
        "  William F. Burns III                                     ",
        "  Former Information Security Officer                       ",
        "  Port Authority of New York & New Jersey                   ",
        "---",
        "  No changes are made without your approval.                ",
        "  A complete log is saved to your GatewayGuard folder each run.     ",
        "  Guide and support: $GuideURL  (ends in .co -- NOT .com)   ",
        "---",
        "  SELECT A MODE:                                            ",
        "                                                            ",
        "  [1] CONSOLE MODE                                          ",
        "      Text-based checklist in this window. Shows each       ",
        "      setting, its live status, and asks Y/N before any     ",
        "      change. Fast and fully transparent.                   ",
        "                                                            ",
        "  [2] GUI MODE                                              ",
        "      Opens a visual window with checkboxes and color-coded ",
        "      status indicators. Recommended for first time users.  ",
        "                                                            ",
        "  [3] EXIT                                                  ",
        "                                                            ",
        "  Admin status: $(if ($global:IsAdmin) { 'FULL ACCESS OK' } else { 'LIMITED MODE -- some settings unavailable' })",
        "  Edition: $global:WinEditionFriendly"
    )
    Write-Host ""
}

# ============================================================
# CONSOLE MODE
# ============================================================
function Run-ConsoleMode {
    trap {
        # FT-49 (ascii28): this trap used to write the error to the SCREEN
        # only -- an unattended or missed error produced the 7/12 'silent
        # exit' with nothing in the log but the sleep-prevention line.
        # The log now records the error, the line, and the exit reason.
        try {
            Write-Log -Message ("Console mode error: " + $_.Exception.Message + " (line " + $_.InvocationInfo.ScriptLineNumber + ")") -Status "ERROR"
            Write-Log -Message "Exiting via console-mode error trap" -Status "EXIT"
        } catch {}
        Write-Host ""
        Write-Host "  ERROR: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "  Line: $($_.InvocationInfo.ScriptLineNumber)" -ForegroundColor Red
        Pause-ForUser "  Press Enter or Space to exit..."
        Disable-SleepPrevention
        Save-Log
        exit
    }

    Clear-Host
    Write-Host ""
    Write-Host "  Checking current settings -- please wait..." -ForegroundColor Yellow
    Get-AllStatuses
    Write-Host ""
    Write-Host "  SCROLL UP AND THEN DOWN ON THE NEXT SCREEN -- it explains" -ForegroundColor Yellow
    Write-Host "  exactly what Checkup does and does not do." -ForegroundColor Yellow
    # Sleep removed (ascii32): per no-Sleep-in-Run rule; message is shown then ScopeDisclaimer renders
    Show-ScopeDisclaimer

    :checklistLoop while ($true) {
        Clear-Host
        # FT-125 (ascii37): the checklist loop logged NOTHING -- not a render,
        # not a keypress, not a command. It is the screen the user spends the
        # most time on and the screen field note 14's crash happened on, and
        # BOTH 2026-07-27 logs are completely silent from "Nav 'NEXT' at:
        # Show-ScopeDisclaimer" until whatever came after the loop. That
        # silence is why note 14 cannot be root-caused from the evidence, and
        # it is why the FT-71 patch at this same spot in ascii30 had to be
        # aimed by inference -- and it has now recurred.
        # Class 1 rule 2: log BEFORE the operation that can throw. Write-Log
        # appends to disk on every call, so this line survives an abrupt death
        # and leaves behind the page number, the measured window width and the
        # selection count -- the three variables every surviving hypothesis
        # about note 14 turns on.
        # PREVENTS: a third undiagnosable crash on this screen.
        # COULD CAUSE: one extra log line per redraw, so a held key lengthens
        # the log. That is the price of having evidence, and it is bounded by
        # one short line per render.
        try {
            if (-not $script:ChecklistPage) { $script:ChecklistPage = 1 }
            $ggLogW = 0
            try { $ggLogW = $Host.UI.RawUI.WindowSize.Width } catch {}
            $ggSelN = @($Settings | Where-Object { $_.Selected }).Count
            # FT-172 (ascii41): the checklist logged NO position, so the log
        # jumped 21 -> 23 while the user was looking at a header bar that
        # said 22. Bill called it "screen 22" in his ascii40 findings and
        # the log support would read had no such screen. It logs it now.
        Write-Log -Message ("[SCREEN-" + $(if ($script:ChecklistPage -eq 1) { "76" } else { "77" }) + "] (shown as screen " + (Get-ScreenNumber -ScreenId $(if ($script:ChecklistPage -eq 1) { "76" } else { "77" })) + ") Checklist render: page " + $script:ChecklistPage + ", window width " + $ggLogW + ", " + $ggSelN + " item(s) selected") -Status "SCREEN"
        } catch {}
        Write-Host ""
        # FT-56/FT-58 (ascii28): the ascii23-era table was fixed at 79 chars
        # for unmaximized 80-column consoles -- on the maximized window this
        # tool INSISTS on, that used barely half the width. Width was made to
        # adapt to the real window, and the list is split into two pages
        # (P = other page) with room to grow past 19 items.
        # FT-117 (ascii34): that "adapts" was really a two-tier GUESS (63/38
        # above 116 columns, else a fixed 42/28) -- not a measurement. The
        # 42/28 preset (+9 chars of border/padding = 79 total) only just
        # fits an 80-column console with zero margin; field-confirmed (HP
        # SANDY, 2026-07-21) truncation on a narrower buffer than 80/116.
        # Now computed directly from the ACTUALLY measured width every time,
        # with a safety margin and sane floors, instead of picking between
        # two hardcoded presets.
        $ggRealWidth = 80
        try { if ($Host.UI.RawUI.WindowSize.Width -gt 0) { $ggRealWidth = $Host.UI.RawUI.WindowSize.Width } } catch {}
        $ggAvailable = $ggRealWidth - 9 - 2   # 9 = border/padding chars (see $ggBorder below), 2 = safety margin
        if ($ggAvailable -lt 35) { $ggAvailable = 35 }   # floor: never below a bare-minimum readable table
        if (-not $script:ChecklistPage) { $script:ChecklistPage = 1 }
        $ggPageItems = if ($script:ChecklistPage -eq 1) { $Settings | Where-Object { $_.ID -le 10 } } else { $Settings | Where-Object { $_.ID -ge 11 } }
        # FT-151 (ascii39): BOTH COLUMNS ARE NOW SIZED FROM THE ACTUAL CONTENT
        # OF THE PAGE BEING DRAWN, on every render.
        # WHAT WAS WRONG: ascii34's FT-117 fix replaced two hardcoded presets
        # with a real measurement of the WINDOW -- and then split that
        # measurement between the two columns by a FIXED 60/40 ratio. The ratio
        # was the bug. At window width 86 it gives name 45 / status 30, while
        # "Not configured -- all 3 need to be enabled" is 41 characters: the
        # status column truncated while the name column sat on slack it did not
        # need. Field note 14 (2026-07-30) reported missing characters on items
        # 6, 8 and 9 in the status column and 7b cut on the left. The tester:
        # "need to expand/widen to accomdate length. there is room." He was
        # right, and the room was in the column beside it.
        # WHY STATUS WINS WHEN BOTH CANNOT FIT: status strings are consumed by
        # gate logic -- the colour rules below, the $GoodPatterns matches, and
        # the HEADS UP filter all read them (Status-String Contract, gate 23).
        # A truncated status can change what the user is told. A truncated NAME
        # is still recognisable ("[X] 15. Edge Password Saving --.."), so the
        # name column is the one that gives way. It keeps a 24-column floor so
        # it can never collapse to nothing.
        # PREVENTS: FT-117 recurring at a third window width.
        # COULD CAUSE: the table width changes as statuses change during a run.
        # That is correct behaviour, not drift -- the fixed ratio that held the
        # width steady is precisely what caused this defect.
        $ggWantName = ("GatewayGuard Checkup v" + $ScriptVersion).Length
        $ggWantStat = ("Screen 00 -- PAGE 0 of 2").Length
        foreach ($ggItem in $ggPageItems) {
            $ggAuto = if (-not $ggItem.CanAuto) { "*" } elseif ($ggItem.RequiresAdmin -and -not $global:IsAdmin) { "!" } else { "" }
            $ggNm = ("{0} {1,2}. {2}" -f "[X]", $ggItem.ID, (([string]$ggItem.Name) + $ggAuto))
            if ($ggNm.Length -gt $ggWantName) { $ggWantName = $ggNm.Length }
            $ggSt = [string]$ggItem.Status
            if ($ggSt.Length -gt $ggWantStat) { $ggWantStat = $ggSt.Length }
        }
        $ggNameW = $ggWantName
        $ggStatW = $ggWantStat
        if (($ggNameW + $ggStatW) -gt $ggAvailable) {
            $ggNameW = $ggAvailable - $ggStatW
            if ($ggNameW -lt 24) {
                $ggNameW = 24
                $ggStatW = $ggAvailable - $ggNameW
                if ($ggStatW -lt 15) { $ggStatW = 15 }
            }
        } else {
            # Everything fits -- hand the leftover room to the name column so
            # nothing is shortened that did not have to be.
            $ggNameW = $ggAvailable - $ggStatW
        }
        # FT-125 (ascii37): [int] casts kept. These come from .Length so they
        # are already Int32, but the casts are what Class 4 rule 2 asks for at a
        # computed boundary feeding Substring(Int32, Int32) and PadRight(Int32).
        $ggNameW = [int]$ggNameW
        $ggStatW = [int]$ggStatW
        $ggBorder = "  +" + ("-" * ($ggNameW + 2)) + "+" + ("-" * ($ggStatW + 2)) + "+"
        try { Write-Log -Message ("Checklist columns: window " + $ggRealWidth + ", name " + $ggNameW + " (content needed " + $ggWantName + "), status " + $ggStatW + " (content needed " + $ggWantStat + ")") -Status "INFO" } catch {}
        Write-Host $ggBorder -ForegroundColor White
        # FT-132 (ascii38): the checklist is drawn by hand, not by Draw-Box, so
        # it never received a screen number -- and it is the screen the user
        # spends the most time on. Field note 20 (2026-07-28): "Next screen -
        # not numbered - Console 1 of 2". Each page is its own screen from the
        # user's point of view (P moves between them), so each gets its own
        # number, registered through the same seen-table as every other screen
        # so revisits keep their number. The number goes in the RIGHT column,
        # inside the existing padding, so the table width is unchanged --
        # FT-117 territory, not to be widened.
        $ggChkNo = Get-ScreenNumber -ScreenId $(if ($script:ChecklistPage -eq 1) { "76" } else { "77" })
        Write-Host ("  | " + "GatewayGuard Checkup v$ScriptVersion".PadRight($ggNameW) + " | " + ("Screen $ggChkNo -- PAGE $($script:ChecklistPage) of 2").PadRight($ggStatW) + " |") -ForegroundColor White
        Write-Host $ggBorder -ForegroundColor White
        Write-Host ("  | " + "Setting".PadRight($ggNameW) + " | " + "Status".PadRight($ggStatW) + " |") -ForegroundColor White
        Write-Host $ggBorder -ForegroundColor White

        foreach ($s in $ggPageItems) {
            $chk      = if ($s.Selected) { "[X]" } else { "[ ]" }
            $auto     = if (-not $s.CanAuto) { "*" } elseif ($s.RequiresAdmin -and -not $global:IsAdmin) { "!" } else { "" }
            # FT-125 (ascii37): [string] cast on Name. FT-71 (ascii30) hardened
            # $s.Status on the status line below and left $s.Name here
            # untouched -- the two columns are built by the same pattern and
            # only one of them was hardened. The ascii30 header claims that
            # cast went to "ALL four" property accesses in this renderer. It
            # did not, and this is the one it missed. Gate 14, fix everywhere.
            $nameStr  = ("{0} {1,2}. {2}" -f $chk, $s.ID, (([string]$s.Name) + $auto))
            # FT-32 (2026-07-12): long text was being cut off with no warning
            # (field: items 3,5,6,7,12,13,14,17 looked garbled). Cuts are now
            # marked with ".." and the legend explains where the full text is.
            $nameStr  = if ($nameStr.Length -gt $ggNameW) { $nameStr.Substring(0, $ggNameW - 2) + ".." } else { $nameStr.PadRight($ggNameW) }
            $statusStr = [string]$s.Status; $statusStr = if ($statusStr.Length -gt $ggStatW) { $statusStr.Substring(0, $ggStatW - 2) + ".." } else { $statusStr.PadRight($ggStatW) }   # FT-71 (ascii30): [string] cast -- null/array Status crashes here on page flip after N
            $statusColor = if ($statusStr -match "GOOD") { "Green" }
                           elseif ($statusStr -match "needs attention|OFF --") { "Yellow" }
                           elseif ($statusStr -match "ERROR|risk") { "Red" }
                           else { "Gray" }   # FT-71 (ascii30): use already-cast $statusStr
            $nameColor = if ($s.SecurityCritical -and -not $s.Selected -and $statusStr -notmatch "GOOD|N/A|ENCRYPTED|primary") { "Red" } else { "White" }   # FT-71 (ascii30): use cast $statusStr
            Write-Host "  | " -ForegroundColor White -NoNewline
            Write-Host $nameStr -ForegroundColor $nameColor -NoNewline
            Write-Host " | " -ForegroundColor White -NoNewline
            Write-Host $statusStr -ForegroundColor $statusColor -NoNewline
            Write-Host " |" -ForegroundColor White
        }

        Write-Host $ggBorder -ForegroundColor White
        Write-Host ""
        Write-Host ("  Showing items $(if ($script:ChecklistPage -eq 1) { '1-10. Press P to see items 11-19.' } else { '11-19. Press P to see items 1-10.' }) Selections on BOTH pages count.") -ForegroundColor Yellow
        Write-Host "  * = Manual action only   ! = Requires admin   [X] = Will be applied" -ForegroundColor DarkGray
        Write-Host "  .. = text shortened to fit -- the full status appears on that item's" -ForegroundColor DarkGray
        Write-Host "       own screen when it runs (and in your log file)" -ForegroundColor DarkGray
        Write-Host "  Green = Already correct   Yellow = Needs attention   Red = Security risk" -ForegroundColor DarkGray
        Write-Host ""
        Write-Host "  Commands:" -ForegroundColor Yellow
        Write-Host "    R = Run selected items     [number] = toggle item on/off" -ForegroundColor Yellow
        Write-Host "    A = Select all             C = Clear all       Q = Quit" -ForegroundColor Yellow
        Write-Host "    P = show the other page of the list" -ForegroundColor Yellow
        Write-Host "    I = show build and Machine ID" -ForegroundColor Yellow
        Write-Host "    Item numbers: 1-9 then Enter; 10-19 apply on the second digit." -ForegroundColor DarkGray
        Write-Host ""

        # Main command input -- special handler for R/A/N/Q + multi-digit numbers
        # BUGFIX ascii23 (2026-07-10, FT-01): these two ReadKey calls had NO
        # try/catch, unlike every other ReadKey in the script. If ReadKey
        # throws (observed when the console loses/regains focus, e.g. after
        # Alt-Tab), this was an UNCAUGHT terminating error -- which ends the
        # whole script. This is very likely the real cause of "session ends
        # unexpectedly" reported multiple times on this exact screen (the
        # main checklist, where users spend the most time and are most
        # likely to Alt-Tab away to check something). Now wrapped with the
        # same safe fallback pattern already used in Read-ValidKey/Pause-ForUser.
        # FT-193 (ascii42): ASSERT THE INPUT GATE HERE.
        # Reset-GGInputGate had exactly one call site -- inside Draw-Box --
        # and the checklist is the only screen that does not use Draw-Box.
        # FT-171f's claim was "console flags asserted before EVERY screen",
        # implemented centrally so that no NEW screen could forget it. It had
        # one hole, and the hole was the screen the user spends most of the
        # run on. A central fix protects what is routed through the centre.
        #
        # THE REASON THIS MATTERS IS THE FLUSH, NOT THE FLAGS. Measured on
        # SANDY 2026-08-19 (MarkModeReset-SANDY-2026-08-19_18-14.txt): the
        # ascii41 mask DOES clear ENABLE_MOUSE_INPUT (0x1F7 -> 0x1A7), and
        # using Mark mode does NOT hand it back (0x1A7 before and after). The
        # theory that the console mode was being reset behind Checkup's back
        # is DISPROVEN and must not be repeated. What this call is actually
        # worth here is Clear-PendingKeys: anything queued before the screen
        # was drawn gets discarded, which is FT-171e's purpose applied to the
        # one screen that never received it.
        Reset-GGInputGate

        # FT-193: re-prompt WITHOUT repainting. Before this, an unmatched key
        # fell through to the bottom of checklistLoop and Clear-Host repainted
        # the entire screen -- so one stray character was one full repaint, and
        # a burst was ten repaints a second. Measured 2026-08-18 at 17:35:15.
        $ggBadKeys = 0
        :keyLoop while ($true) {
        Write-Host "  Enter command (R/A/C/Q/P or item number 1-19): " -ForegroundColor White -NoNewline
        $userInput = ""
        $firstKey = $null   # FT-69 (ascii29): never test a stale key object
        # FT-46 (ascii28): re-assert Ctrl+C-as-input before every read
        try { [Console]::TreatControlCAsInput = $true } catch {}
        try {
            $firstKey = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            $firstCh = $firstKey.Character.ToString().ToUpper()
        } catch {
            Write-Log -Message "ReadKey failed (focus loss?) -- falling back to Read-Host: $_" -Status "WARN"
            $fallbackInput = (Read-Host).ToUpper().Trim()
            $firstCh = if ($fallbackInput.Length -gt 0) { $fallbackInput.Substring(0,1) } else { "" }
        }

        # FT-69 (ascii29): Ctrl+C opens the exit confirmation
        if ($firstKey -and $firstKey.Character -eq [char]3) { Invoke-CtrlCExit; continue checklistLoop }

        if ($firstCh -in @("R","A","C","Q","P")) {
            $userInput = $firstCh
            Write-Host $userInput -ForegroundColor Cyan
            break keyLoop
        } elseif ($firstCh -match "[1-9]") {
            Write-Host $firstCh -ForegroundColor Cyan -NoNewline
            # Could be 1-9 or start of 10-19
            # FT-112 (ascii34): the $firstKey read above resets TreatControlCAsInput
            # (FT-46 -- the console host undoes it on every read) -- re-assert here
            # too, or a Ctrl+C typed as the second digit killed the process instantly
            # instead of opening Confirm-Exit (root cause of FT-112/FT-113).
            try { [Console]::TreatControlCAsInput = $true } catch {}
            $secondKey = $null   # FT-69 pattern: never test a stale key object
            try {
                $secondKey = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
                $secondCh = $secondKey.Character.ToString()
                $secondVK = $secondKey.VirtualKeyCode
            } catch {
                Write-Log -Message "ReadKey failed on second digit (focus loss?) -- treating as Enter: $_" -Status "WARN"
                $secondCh = ""
                $secondVK = 13
            }
            # FT-112 (ascii34): Ctrl+C opens the exit confirmation here too
            if ($secondKey -and $secondKey.Character -eq [char]3) { Invoke-CtrlCExit; continue checklistLoop }
            if ($secondCh -match "[0-9]") {
                $userInput = "$firstCh$secondCh"
                Write-Host $secondCh -ForegroundColor Cyan
            } elseif ($secondVK -in @(13,32)) {
                # Enter or Space after single digit
                $userInput = $firstCh
                Write-Host ""
            } else {
                $userInput = $firstCh
                Write-Host ""
            }
            break keyLoop
        } elseif ($firstCh -eq "I") {
            # FT-206 (ascii43): I works on the checklist too. FT-189 promised
            # "at any time" and this hand-rolled reader was the one prompt
            # where it failed -- the screen the user spends most of the run on.
            Write-Host ""
            Show-CheckupInfo
            continue keyLoop
        } else {
            # FT-193 (ascii42): was '$userInput = ""  # Invalid -- swallow
            # silently', which fell through and repainted the whole screen.
            # Now: say so, log it, drain the rest of the burst, and ask again
            # IN PLACE. Nothing is redrawn, so a held key or a pasted line
            # cannot turn into an avalanche.
            $ggBadKeys++
            Write-Host ""
            if ($ggBadKeys -le 3) {
                Write-Host "  That key does nothing here. Press R, A, C, Q, P, I or an item number 1-19." -ForegroundColor Yellow
                # Rate-limited: a flood must not fill the log, but the FIRST
                # few must appear or a future flood is invisible again --
                # which is exactly why FT-193 could not be diagnosed from the
                # ascii40 logs.
                try { Write-Log -Message ("Checklist: key ignored (" + $(if ($firstCh) { $firstCh } else { "non-printing" }) + ")") -Status "KEY" } catch {}
            } elseif ($ggBadKeys -eq 4) {
                Write-Host "  Ignoring repeated keys. Something may be resting on the keyboard." -ForegroundColor Yellow
                try { Write-Log -Message "Checklist: 4+ ignored keys in one prompt -- burst suppressed (FT-193)" -Status "WARN" } catch {}
            }
            # Drain whatever else arrived with it. One stray key is a typo;
            # a queue behind it is a paste, a held key, or a mouse on the keys.
            try { Clear-PendingKeys } catch {}
            continue keyLoop
        }
        }   # end :keyLoop (FT-193)

        # FT-125 (ascii37): log the accepted command. Every other prompt in
        # this file writes a [KEY] breadcrumb through Read-ValidKey /
        # Pause-ForUser / Read-NavKey; the checklist has its own hand-rolled
        # reader (it must, to accept two-digit item numbers) and never gained
        # one. Field note 14 reads "selected N to turn off all selections and
        # screen flickered ... then displayed screen showing R had been
        # selected and when i hit space bar pgm crashed" -- none of N, R or
        # the space appears in either log, so the reported sequence can be
        # neither confirmed nor refuted. Empty input (an invalid key, swallowed
        # silently) is NOT logged, so a held-down invalid key cannot flood the
        # file.
        if ($userInput -ne "") {
            try { Write-Log -Message ("Checklist command '" + $userInput.ToUpper() + "' accepted at: Run-ConsoleMode") -Status "KEY" } catch {}
        }

        switch ($userInput.ToUpper()) {
            "P" { $script:ChecklistPage = if ($script:ChecklistPage -eq 1) { 2 } else { 1 } }
            "A" { $Settings | ForEach-Object { $_.Selected = $true } }
            "C" {
                # FT-204 (ascii43): clearing every selection is the only
                # destructive command on this screen and used to be N -- the
                # safe key everywhere else -- with no confirmation. It wiped
                # 19 selections five seconds after they were made (field,
                # 2026-08-21). Moved to C and gated behind a Y/N.
                $selCount = ($Settings | Where-Object { $_.Selected }).Count
                if ($selCount -eq 0) {
                    Write-Host ""
                    Write-Host "  Nothing is selected -- nothing to clear." -ForegroundColor Yellow
                    Pause-ForUser "  Press Enter or Space to return to the checklist..."
                } else {
                    Write-Host ""
                    $clearResp = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Clear all $selCount selection(s)? (Y = Clear / N = Keep them): "
                    if ($clearResp.ToUpper() -eq "Y") {
                        $Settings | ForEach-Object { $_.Selected = $false }
                        try { Write-Log -Message "Checklist: all selections cleared (C, confirmed)" -Status "KEY" } catch {}
                    }
                }
            }
            "Q" { Confirm-Exit "All changes from this session would be lost."; continue checklistLoop }
            "R" {
                $selectedCount = ($Settings | Where-Object { $_.Selected }).Count
                if ($selectedCount -eq 0) {
                    Write-Host ""
                    # FT-125 (ascii37): this is the exact screen field note 14
                    # describes reaching after pressing N and then R. The bare
                    # Pause-ForUser broke the standing input rule "ALWAYS
                    # provide an explicit message -- never use the default",
                    # so the user got the generic "Press Enter or Space to
                    # continue..." with no statement of where continuing led.
                    Write-Host "  Nothing is selected, so there is nothing to run." -ForegroundColor Yellow
                    Write-Host "  Type an item number to select that item, or A to select all." -ForegroundColor Yellow
                    Pause-ForUser "  Press Enter or Space to go back to the list..."
                    continue checklistLoop
                }

                $proceed = Test-NonRecommendedSelections -Stage "review"
                if (-not $proceed) { continue checklistLoop }

                # FT-67 (ascii29): dedicated BitLocker decision flow --
                # only when the drive is NOT encrypted and item 8 is
                # not selected. N at either screen returns here so the
                # user can type 8 and select it.
                $blItem = $Settings | Where-Object { $_.ID -eq 8 } | Select-Object -First 1
                # FT-224 (ascii43): this decline heads-up was shown on EVERY R
                # press -- the run log caught SCREEN-58 rendered three times, each
                # after the decline was already noted. Once the user chooses to
                # continue without encryption, remember it for the session and do
                # not re-ask. A GoBack does not set the flag: they have not
                # decided to skip, so the reminder stands until they either select
                # item 8 or acknowledge declining.
                if ($blItem -and -not $blItem.Selected -and $blItem.Status -match "NOT Encrypted" -and -not $script:GGBitLockerDeclineAcknowledged) {
                    $blDecision = Show-BitLockerDeclineHeadsUp
                    if ($blDecision -eq "GoBack") {
                        Write-Host ""
                        Write-Host "  Back at the checklist -- type 8 to select Drive Encryption." -ForegroundColor Cyan
                        Pause-ForUser "  Press Enter or Space to return to the checklist..."
                        continue checklistLoop
                    }
                    $script:GGBitLockerDeclineAcknowledged = $true
                }

                Clear-Host
                Write-Host ""
                Draw-Box -ScreenId "55" -Color White -Lines @(
                    "  REVIEW YOUR SELECTIONS -- NO CHANGES MADE YET           ",
                    "---",
                    "  Items marked [X] WILL be applied.                       ",
                    "  Items marked [ ] will be SKIPPED.                       ",
                    "  BitLocker (if selected) is always handled last.         "
                )
                Write-Host ""
                # Group items for clarity: WILL APPLY / ALREADY GOOD / SKIPPED
                Write-Host "  WILL BE APPLIED:" -ForegroundColor White
                $applyItems = $Settings | Where-Object { $_.Selected }
                if ($applyItems) {
                    foreach ($s in $applyItems) {
                        $statusShort = [string]$s.Status; if ($statusShort.Length -gt 28) { $statusShort = $statusShort.Substring(0,28) }   # FT-68 (ascii29): [string] guard
                        Write-Host ("  [X] APPLYING  {0,2}. {1,-38} {2}" -f $s.ID, $s.Name, $statusShort) -ForegroundColor White
                    }
                } else {
                    Write-Host "  (none selected)" -ForegroundColor DarkGray
                }
                Write-Host ""
                Write-Host "  ALREADY GOOD -- no change needed:" -ForegroundColor Green
                $goodItems2 = $Settings | Where-Object { -not $_.Selected -and $_.Status -match "-- GOOD|ENCRYPTED -- GOOD|ALL ON -- GOOD|N/A on Home" }
                if ($goodItems2) {
                    foreach ($s in $goodItems2) {
                        $statusShort = [string]$s.Status; if ($statusShort.Length -gt 28) { $statusShort = $statusShort.Substring(0,28) }   # FT-68 (ascii29): [string] guard
                        Write-Host ("  [ ] GOOD      {0,2}. {1,-38} {2}" -f $s.ID, $s.Name, $statusShort) -ForegroundColor Green
                    }
                }
                Write-Host ""
                $critSkipped = $Settings | Where-Object { -not $_.Selected -and $_.Status -notmatch "-- GOOD|ENCRYPTED|ALL ON|N/A" -and $_.SecurityCritical }
                if ($critSkipped) {
                    Write-Host "  SECURITY RISK -- deselected:" -ForegroundColor Red
                    foreach ($s in $critSkipped) {
                        Write-Host ("  [ ] !! RISK   {0,2}. {1}" -f $s.ID, $s.Name) -ForegroundColor Red
                    }
                    Write-Host ""
                }
                Write-Host ""
                Write-Host "  $selectedCount item(s) will be applied -- selecting them was your approval. Any that need a manual step will show you how." -ForegroundColor Yellow
                Write-Host ""
                # FT-243 (ascii44): the required notice, on the review
                # screen the rule names. Bill, screen 27: "Did not see
                # this on the Screen -- choices can be reviewed in your
                # log." It was on screen 25e, which only appears if you
                # decline encryption. The once-only guard is unchanged.
                if (-not $script:GGLogNoticeShown) {
                    Write-Host "  For your protection, your choices can be reviewed in your log." -ForegroundColor Gray
                    Write-Host ""
                    $script:GGLogNoticeShown = $true
                }
                Write-Log -Message "Review listing rendered -- awaiting Ready-to-proceed" -Status "INFO"   # FT-68 (ascii29): brackets the listing loop in the log

                do {
                    $finalCheck = Read-ValidKey -ValidKeys @("Y","B","Q") -Prompt "Ready to proceed? (Y = Start / B = Go back / Q = Quit): "
                    switch ($finalCheck.ToUpper()) {
                        "Q" { Confirm-Exit; continue checklistLoop }
                        "B" { continue checklistLoop }
                    }
                } while ($finalCheck.ToUpper() -ne "Y")

                $proceed2 = Test-NonRecommendedSelections -Stage "final"
                if (-not $proceed2) { continue checklistLoop }

                Write-Host ""
                Write-Host "  Starting -- $selectedCount item(s) to process..." -ForegroundColor Cyan
                Write-Log -Message "=== Console Mode Hardening Run Started ===" -Status "START"

                $goodItems = [System.Collections.Generic.List[PSCustomObject]]::new()

                foreach ($s in ($Settings | Where-Object { $_.Selected -and $_.ID -ne 8 })) {
                    if ($s.Status -match "GOOD") {
                        Write-Host ""
                        Write-Host "  ----------------------------------------------------------------" -ForegroundColor DarkGray
                        Write-Host "  [$($s.ID)] $($s.Name)" -ForegroundColor White
                        Write-Host "  Current: $($s.Status)" -ForegroundColor Green
                        Write-Host "  What:    $($s.Description)" -ForegroundColor Gray
                        Write-Host ""
                        Write-Host "  This setting is already at the recommended state." -ForegroundColor Green
                        Write-Host "  N = Skip   Y = Change this setting   B = Back to checklist" -ForegroundColor White
                        $goodResp = Read-ValidKey -ValidKeys @("Y","N","B") -Prompt "Choice (Y = Re-apply / N = Skip / B = Back): "
                        switch ($goodResp.ToUpper()) {
                            "B" { continue checklistLoop }
                            "Y" {
                                Write-Host ""
                                if ($s.SecurityCritical) {
                                    Write-Host "  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" -ForegroundColor Red
                                    Write-Host "  !!  SECURITY CRITICAL WARNING                             !!" -ForegroundColor Red
                                    # FT-126 (ascii37): PowerShell argument mode does
                                    # not concatenate -- this printed a literal " + !!"
                                    # on screen inside the SECURITY CRITICAL warning
                                    # box, and the box's right edge never lined up.
                                    # Rebuilt as one expression at the same 63-column
                                    # width as the four rows around it, and truncated
                                    # so a long item name cannot push the edge out.
                                    $ggCrit = "  !!  " + ([string]$s.Name) + " is a critical security protection."
                                    if ($ggCrit.Length -gt 61) { $ggCrit = $ggCrit.Substring(0, 61) }
                                    Write-Host ($ggCrit.PadRight(61) + "!!") -ForegroundColor Red
                                    Write-Host "  !!  Changing or disabling this WILL reduce your security.!!" -ForegroundColor Red
                                    Write-Host "  !!  Only proceed if you have a specific technical reason. !!" -ForegroundColor Red
                                    Write-Host "  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" -ForegroundColor Red
                                } else {
                                    Write-Host "  !! WARNING: This setting is already correctly configured." -ForegroundColor Yellow
                                    Write-Host "     Changing it may reduce your security protection." -ForegroundColor Yellow
                                    Write-Host "     Only continue if you have a specific reason to change it." -ForegroundColor Yellow
                                }
                                Write-Host ""
                                $warnResp = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue and change this setting? (Y = Yes I understand / N = Cancel): "
                                if ($warnResp.ToUpper() -eq "Y") {
                                    Write-Host "  Applying..." -ForegroundColor Cyan
                                    $result = Apply-Setting -Setting $s
                                    Write-Host "  Result: $result" -ForegroundColor Cyan
                                    Write-Log -Message "$($s.Name) -- changed by user despite GOOD status" -Status "CHANGED"
                                    Pause-ForUser
                                } else {
                                    Write-Host "  Cancelled -- no change made." -ForegroundColor Gray
                                    $goodItems.Add($s)
                                    Write-Log -Message "$($s.Name) -- already correct, user cancelled change" -Status "GOOD"
                                }
                            }
                            default {
                                $goodItems.Add($s)
                                Write-Log -Message "$($s.Name) -- already correct, skipped" -Status "GOOD"
                            }
                        }
                        continue
                    }

                    Write-Host ""
                    Write-Host "  ----------------------------------------------------------------" -ForegroundColor DarkGray
                    Write-Host "  [$($s.ID)] $($s.Name)" -ForegroundColor White
                    Write-Host "  Guide:   $($s.GuideRef)" -ForegroundColor Yellow
                    Write-Host "  Current: $($s.Status)" -ForegroundColor $(if ($s.Status -match "GOOD") { "Green" } elseif ($s.Status -match "needs") { "Yellow" } else { "Gray" })
                    Write-Host "  What:    $($s.Description)" -ForegroundColor Gray

                    # -- Convenience feature WHY explanation --
                    switch ($s.ID) {
                        11 {
                            Write-Host ""
                            Write-Host "  WHY TURN THIS OFF:" -ForegroundColor Cyan
                            Write-Host "  Windows assigns each account an Advertising ID and uses it" -ForegroundColor Gray
                            Write-Host "  to track your activity across apps and websites to serve" -ForegroundColor Gray
                            Write-Host "  targeted ads. Turning it off stops this tracking entirely." -ForegroundColor Gray
                            Write-Host "  You still see ads -- they just won't be targeted to you." -ForegroundColor Gray
                        }
                        12 {
                            Write-Host ""
                            Write-Host "  WHY RESTRICT THIS:" -ForegroundColor Cyan
                            Write-Host "  By default, Windows sends detailed diagnostic data to" -ForegroundColor Gray
                            Write-Host "  Microsoft including app usage, browsing habits, and" -ForegroundColor Gray
                            Write-Host "  error reports. 'Required Only' limits this to the minimum" -ForegroundColor Gray
                            Write-Host "  needed for Windows to function. Windows continues to work" -ForegroundColor Gray
                            Write-Host "  normally -- Microsoft just receives less about your usage." -ForegroundColor Gray
                        }
                        13 {
                            Write-Host ""
                            Write-Host "  WHY TURN THIS OFF:" -ForegroundColor Cyan
                            Write-Host "  Edge Startup Boost launches Edge processes in the background" -ForegroundColor Gray
                            Write-Host "  every time your PC boots, even if you never open Edge." -ForegroundColor Gray
                            Write-Host "  Background mode keeps Edge running after you close it." -ForegroundColor Gray
                            Write-Host "  Both waste RAM and CPU. Turning them off does NOT remove" -ForegroundColor Gray
                            Write-Host "  Edge -- it just stops it from running when you don't use it." -ForegroundColor Gray
                        }
                        14 {
                            Write-Host ""
                            Write-Host "  WHY DISABLE WIDGETS:" -ForegroundColor Cyan
                            Write-Host "  The Windows Widgets panel (news, weather, stocks) runs" -ForegroundColor Gray
                            Write-Host "  background Edge WebView2 processes at all times, consuming" -ForegroundColor Gray
                            Write-Host "  RAM even when the panel is closed. It also sends browsing" -ForegroundColor Gray
                            Write-Host "  behavior data to Microsoft. Disabling Widgets does NOT" -ForegroundColor Gray
                            Write-Host "  affect the taskbar, Start menu, or any other feature." -ForegroundColor Gray
                        }
                        15 {
                            Write-Host ""
                            Write-Host "  WHY DISABLE EDGE PASSWORD SAVING:" -ForegroundColor Cyan
                            Write-Host "  Browser-saved passwords are stored with minimal encryption" -ForegroundColor Gray
                            Write-Host "  and are vulnerable if someone gains access to your PC or" -ForegroundColor Gray
                            Write-Host "  if Edge is compromised by malware. A dedicated password" -ForegroundColor Gray
                            Write-Host "  manager (Bitwarden, 1Password, etc.) uses stronger" -ForegroundColor Gray
                            Write-Host "  encryption and works across all browsers and devices." -ForegroundColor Gray
                            Write-Host "  Turning this off does NOT delete saved passwords -- it" -ForegroundColor Gray
                            Write-Host "  just stops Edge from saving new ones going forward." -ForegroundColor Gray
                        }
                    }

                    if ($s.ID -eq 16) {
                        Write-Host "  NOTE: Memory Integrity requires a RESTART after enabling." -ForegroundColor Yellow
                    }

                    if (-not $s.CanAuto) {
                        Write-Host ""
                        Write-Host "  This one needs you to do it by hand -- Checkup will show you the steps." -ForegroundColor Red
                        $r = Apply-Setting -Setting $s
                        Write-Host "  INSTRUCTIONS: $r" -ForegroundColor Yellow
                        Pause-ForUser
                        continue
                    }
                    if ($s.RequiresAdmin -and -not $global:IsAdmin) {
                        Write-Host "  SKIPPED: Administrator access required." -ForegroundColor Gray
                        Write-Log -Message "$($s.Name) skipped -- no admin" -Status "SKIP"
                        continue
                    }
                    if ($s.SkipOnHome -and ($global:WinEdition -notmatch "Pro|Enterprise|Education")) {
                        Write-Host "  SKIPPED: Not available on Windows 11 Home." -ForegroundColor Gray
                        Write-Log -Message "$($s.Name) skipped -- Home edition" -Status "SKIP"
                        continue
                    }

                    # FT-219 (ascii43): selecting an item on the checklist IS your
                    # approval to apply it (Bill, 2026-08-21), and the whole run was
                    # confirmed at the review gate. A setting Checkup can apply is
                    # applied now, with no second "Apply? Y/N". The ONLY exception is
                    # a setting that needs you to act by hand -- handled above
                    # (-not $s.CanAuto), where Checkup shows the steps rather than
                    # changing anything itself.
                    Write-Host ""
                    Write-Host "  You selected this item, so Checkup is applying it now." -ForegroundColor Cyan
                    Write-Host "  Applying..." -ForegroundColor Cyan
                    $result = Apply-Setting -Setting $s
                    $resultColor = if ($result -match "GOOD|enabled|disabled|set to|Already") { "Green" } elseif ($result -match "NOTE:|MANUAL|manual") { "Yellow" } else { "Red" }
                    Write-Host ""
                    Write-Host "  Result: $result" -ForegroundColor $resultColor
                    Pause-ForUser
                }

                if ($goodItems.Count -gt 0) {
                    Write-Host ""
                    Draw-Box -ScreenId "59" -Color White -Lines @(
                        "  ALREADY CORRECT -- AUTO-SKIPPED ($($goodItems.Count) items)            ",
                        "---",
                        "  These settings were already at the recommended state     ",
                        "  and did not need to be changed:                          "
                    )
                    foreach ($item in $goodItems) {
                        Write-Host "  OK  $($item.ID). $($item.Name) -- $($item.Status)" -ForegroundColor Green
                    }
                    Write-Host ""
                    $changeGood = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Want to review or change any of these? (Y/N): "
                    if ($changeGood.ToUpper() -eq "Y") {
                        foreach ($item in $goodItems) {
                            Write-Host ""
                            Write-Host "  $($item.ID). $($item.Name)" -ForegroundColor White
                            Write-Host "  Status: $($item.Status)" -ForegroundColor Green
                            Write-Host "  Description: $($item.Description)" -ForegroundColor Gray
                            $reapply = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Force re-apply anyway? (Y/N): "
                            if ($reapply.ToUpper() -eq "Y") {
                                $item.Status = "Forced re-apply by user"
                                $result = Apply-Setting -Setting $item
                                Write-Host "  Result: $result" -ForegroundColor Cyan
                            }
                        }
                    }
                    Pause-ForUser
                }

                $blSetting = $Settings | Where-Object { $_.ID -eq 8 }
                if ($blSetting -and $blSetting.Selected) {
                    # G-02b rev (ascii33, FT-101): tip prints inline right before
                    # the BitLocker screen -- no standalone blank screen, no pause
                    Write-Host ""
                    Write-Host "  Tip: To copy text from this window -- press Alt+Space, then E, then M --" -ForegroundColor Cyan
                    Write-Host "       drag or use Shift+arrows to select -- press Enter to copy." -ForegroundColor Cyan
                    Write-Host "       Press Esc to exit without copying." -ForegroundColor Cyan
                    Show-BitLockerScreen
                }

                Write-Host ""
                Draw-Box -ScreenId "69" -Color White -Lines @(
                    "  ALL SELECTED ITEMS PROCESSED                           ",
                    "  Log saved to your GatewayGuard folder.                       ",
                    "  See manual steps below for items needing your action.  "
                )
                # FT-244 (ascii44): Setup-ScheduledTasks begins with
                # Clear-Host, so without this pause screen 32 was drawn
                # and wiped in the same second -- measured 16:09:43,
                # 2026-08-30. Bill: "Is there a screen 32."
                Write-Host ""
                Pause-ForUser "  Press Enter or Space to continue..."
                Setup-ScheduledTasks
                Show-ConvenienceReview   # FT-70 (ascii29): was called twice back-to-back -- deduped
                Show-OneDriveOffer       # FT-191: only if no OneDrive
                Show-ManualSteps
                Disable-SleepPrevention
                Restore-ScreenSaver
                Save-Log
                Set-FirstRunComplete
                # FT-119 (ascii34): "Press Enter or Space to exit..." is used
                # for routine screen transitions elsewhere too -- it didn't
                # read as distinctly FINAL here. Now names the program and
                # says "close" explicitly, matching Show-ManualSteps' own
                # closing statement above it.
                Pause-ForUser "  Press Enter or Space to close Checkup..."
                return
            }
            default {
                if ($userInput -match '^\d+$') {
                    $id = [int]$userInput
                    $item = $Settings | Where-Object { $_.ID -eq $id }
                    if ($item) {
                        $item.Selected = -not $item.Selected
                    } else {
                        # FT-232 (ascii43): an out-of-range number was logged as
                        # accepted and did nothing -- worse than an unknown key,
                        # because it looked like it worked. Reject it out loud.
                        $maxId = ($Settings | Measure-Object -Property ID -Maximum).Maximum
                        Write-Host ""
                        Write-Host "  There is no item $id. Item numbers run 1 to $maxId." -ForegroundColor Yellow
                        try { Write-Log -Message ("Checklist: item number out of range (" + $id + ") -- rejected") -Status "KEY" } catch {}
                        Pause-ForUser "  Press Enter or Space to return to the checklist..."
                    }
                }
            }
        }
    }
}

# ============================================================
# GUI MODE  (Garamond font throughout)
# ============================================================
function Run-GUIMode {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    Write-Host "  Checking current settings -- please wait..." -ForegroundColor Yellow
    Get-AllStatuses

    $form = New-Object System.Windows.Forms.Form
    $form.Text    = "GatewayGuard Checkup -- Windows 11 Security Hardening v$ScriptVersion -- $global:WinEditionFriendly"
    $form.Size    = New-Object System.Drawing.Size(900, 780)
    $form.StartPosition = "CenterScreen"
    $form.BackColor = [System.Drawing.Color]::FromArgb(28, 28, 28)
    $form.ForeColor = [System.Drawing.Color]::White
    $form.Font    = New-Object System.Drawing.Font("Garamond", 9)
    $form.FormBorderStyle = "FixedDialog"
    $form.MaximizeBox = $false

    $form.Add_FormClosing({
        param($sender, $e)
        $resp = [System.Windows.Forms.MessageBox]::Show(
            "Are you sure you want to exit?`n`nNo changes will be saved unless you clicked Run Selected.",
            "Confirm Exit", "YesNo", "Question"
        )
        if ($resp -eq "No") { $e.Cancel = $true }
        else { Disable-SleepPrevention; Save-Log }
    })

    $lblTitle = New-Object System.Windows.Forms.Label
    $lblTitle.Text = "GatewayGuard Checkup -- Windows 11 Security Hardening v$ScriptVersion"
    $lblTitle.Font = New-Object System.Drawing.Font("Garamond", 14, [System.Drawing.FontStyle]::Bold)
    $lblTitle.ForeColor = [System.Drawing.Color]::FromArgb(0,180,255)
    $lblTitle.Location = New-Object System.Drawing.Point(15, 10)
    $lblTitle.Size = New-Object System.Drawing.Size(860, 28)
    $form.Controls.Add($lblTitle)

    $lblAuthor = New-Object System.Windows.Forms.Label
    $lblAuthor.Text = "William F. Burns III  |  Former ISO, Port Authority of NY & NJ  |  $GuideURL"
    $lblAuthor.Font = New-Object System.Drawing.Font("Garamond", 9)
    $lblAuthor.ForeColor = [System.Drawing.Color]::Silver
    $lblAuthor.Location = New-Object System.Drawing.Point(15, 42)
    $lblAuthor.Size = New-Object System.Drawing.Size(860, 18)
    $form.Controls.Add($lblAuthor)

    $adminColor = if ($global:IsAdmin) { [System.Drawing.Color]::FromArgb(0,200,100) } else { [System.Drawing.Color]::Orange }
    $lblStatus = New-Object System.Windows.Forms.Label
    $lblStatus.Text = "Edition: $global:WinEdition  |  Admin: $(if ($global:IsAdmin) { 'Full Access OK' } else { 'Limited Mode -- some settings unavailable' })"
    $lblStatus.Font = New-Object System.Drawing.Font("Garamond", 9, [System.Drawing.FontStyle]::Italic)
    $lblStatus.ForeColor = $adminColor
    $lblStatus.Location = New-Object System.Drawing.Point(15, 62)
    $lblStatus.Size = New-Object System.Drawing.Size(860, 18)
    $form.Controls.Add($lblStatus)

    $lblNote = New-Object System.Windows.Forms.Label
    $lblNote.Text = "Select settings to apply. No changes made without approval. Log saved to your GatewayGuard folder after run."
    $lblNote.Font = New-Object System.Drawing.Font("Garamond", 9, [System.Drawing.FontStyle]::Italic)
    $lblNote.ForeColor = [System.Drawing.Color]::FromArgb(255,200,0)
    $lblNote.Location = New-Object System.Drawing.Point(15, 82)
    $lblNote.Size = New-Object System.Drawing.Size(860, 18)
    $form.Controls.Add($lblNote)

    $lblScope = New-Object System.Windows.Forms.Label
    $lblScope.Text = "This tool turns risky features OFF and security features ON. Features can be re-enabled in Windows Settings at any time."
    $lblScope.Font = New-Object System.Drawing.Font("Garamond", 8, [System.Drawing.FontStyle]::Italic)
    $lblScope.ForeColor = [System.Drawing.Color]::FromArgb(180,180,180)
    $lblScope.Location = New-Object System.Drawing.Point(15, 102)
    $lblScope.Size = New-Object System.Drawing.Size(860, 16)
    $form.Controls.Add($lblScope)

    $sep = New-Object System.Windows.Forms.Label
    $sep.BorderStyle = "Fixed3D"
    $sep.Location = New-Object System.Drawing.Point(10, 122)
    $sep.Size = New-Object System.Drawing.Size(864, 2)
    $form.Controls.Add($sep)

    $panel = New-Object System.Windows.Forms.Panel
    $panel.Location = New-Object System.Drawing.Point(10, 126)
    $panel.Size = New-Object System.Drawing.Size(864, 570)
    $panel.AutoScroll = $true
    $panel.BackColor = [System.Drawing.Color]::FromArgb(28, 28, 28)
    $form.Controls.Add($panel)

    # BUGFIX ascii23 (2026-07-10): with ~20 rows x 6 controls each (~120+
    # child controls) inside a scrollable panel, WinForms can visibly
    # flicker, go blank, or freeze during scroll without double-buffering
    # and layout suspension. DoubleBuffered is a protected property, so it
    # needs reflection to set from PowerShell.
    try {
        $dbFlags = [System.Reflection.BindingFlags]::SetProperty -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::NonPublic
        $panel.GetType().InvokeMember("DoubleBuffered", $dbFlags, $null, $panel, @($true)) | Out-Null
    } catch {}
    $panel.SuspendLayout()

    foreach ($col in @(
        @{Text="Select"; X=5; W=50},
        @{Text="Setting (click row for details)"; X=60; W=530},
        @{Text="Current Status"; X=605; W=245}
    )) {
        $lbl = New-Object System.Windows.Forms.Label
        $lbl.Text = $col.Text
        $lbl.Font = New-Object System.Drawing.Font("Garamond", 11, [System.Drawing.FontStyle]::Bold)
        $lbl.ForeColor = [System.Drawing.Color]::FromArgb(0,180,255)
        $lbl.Location = New-Object System.Drawing.Point($col.X, 5)
        $lbl.Size = New-Object System.Drawing.Size($col.W, 22)
        $panel.Controls.Add($lbl)
    }

    # Shared tooltip control -- shows Description + Guide Reference on hover.
    # Long AutoPopDelay so it stays up long enough to actually read.
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.AutoPopDelay = 15000
    $tooltip.InitialDelay = 400
    $tooltip.ReshowDelay = 200
    $tooltip.IsBalloon = $true

    $checkboxes = @{}
    $yPos = 28
    # DIAGNOSTIC (2026-07-10): if the yPos bug recurs, this will tell us
    # exactly what it actually is at the moment of first use, instead of
    # guessing from a downstream error message.
    Write-Log -Message "DIAG: yPos initialized as type $($yPos.GetType().FullName), value=$yPos, count=$(@($yPos).Count)" -Status "INFO"

    foreach ($s in $Settings) {
        $isSkipped = ($s.SkipOnHome -and ($global:WinEdition -notmatch "Pro|Enterprise|Education")) -or ($s.RequiresAdmin -and -not $global:IsAdmin)

        $rowBg = New-Object System.Windows.Forms.Panel
        # BUGFIX ascii23 (2026-07-09): $yPos was intermittently becoming
        # System.Object[] instead of a scalar int, causing "op_Subtraction
        # not found" crashes. Root cause not pinned down via static review --
        # forcing an explicit [int] cast here makes the crash structurally
        # impossible regardless of cause, and will throw a clearer error
        # pointing at the real culprit if something upstream is still wrong.
        if (@($yPos).Count -gt 1) {
            Write-Log -Message "DIAG: yPos CORRUPTED at row for '$($s.Name)' -- type=$($yPos.GetType().FullName) value=$($yPos -join ',')" -Status "WARN"
        }
        # UX REDESIGN (2026-07-10): rows now show only Name + Status, in much
        # larger text. Description and Guide Reference are no longer always
        # visible -- shown via a hover tooltip AND a click popup (both, since
        # hover alone isn't discoverable for everyone). Row height shrunk from
        # 56 to 40 accordingly.
        $rowBg.Location = New-Object System.Drawing.Point(0, ([int]@($yPos)[0] - 2))
        $rowBg.Size = New-Object System.Drawing.Size(848, 40)
        $rowBg.BackColor = if ($isSkipped) { [System.Drawing.Color]::FromArgb(35,35,35) } elseif ($s.ID % 2 -eq 0) { [System.Drawing.Color]::FromArgb(38,38,38) } else { [System.Drawing.Color]::FromArgb(28,28,28) }
        $rowBg.Cursor = [System.Windows.Forms.Cursors]::Hand
        $panel.Controls.Add($rowBg)

        $cb = New-Object System.Windows.Forms.CheckBox
        $cb.Checked = $s.Selected -and -not $isSkipped
        $cb.Enabled = -not $isSkipped
        $cb.Location = New-Object System.Drawing.Point(15, 9)
        $cb.Size = New-Object System.Drawing.Size(22, 22)
        $cb.Tag = $s.ID
        $rowBg.Controls.Add($cb)
        $checkboxes[$s.ID] = $cb

        $nameText = "$($s.ID). $($s.Name)$(if (-not $s.CanAuto) { ' *' })$(if ($isSkipped) { ' [UNAVAILABLE]' })"
        $lblName = New-Object System.Windows.Forms.Label
        $lblName.Text = $nameText
        $lblName.Font = New-Object System.Drawing.Font("Garamond", 13, [System.Drawing.FontStyle]::Bold)
        $lblName.ForeColor = if ($isSkipped) { [System.Drawing.Color]::DimGray } else { [System.Drawing.Color]::White }
        $lblName.Location = New-Object System.Drawing.Point(45, 7)
        $lblName.Size = New-Object System.Drawing.Size(545, 26)
        $lblName.Cursor = [System.Windows.Forms.Cursors]::Hand
        $rowBg.Controls.Add($lblName)

        $statusColor = if ($s.Status -match "ON|OK|GOOD|ENCRYPTED|CONFIGURED|ALL ON|DISABLED -- GOOD|Required Only|primary|N/A") {
            [System.Drawing.Color]::FromArgb(0,200,100)
        } elseif ($s.Status -match "OFF|NOT SET|PARTIAL|FULL|DEFAULT|action needed|Enabled \(default\)") {
            [System.Drawing.Color]::FromArgb(255,100,100)
        } elseif ($isSkipped) {
            [System.Drawing.Color]::DimGray
        } else {
            [System.Drawing.Color]::Orange
        }

        $lblStat = New-Object System.Windows.Forms.Label
        $lblStat.Text = $s.Status
        $lblStat.Font = New-Object System.Drawing.Font("Garamond", 12, [System.Drawing.FontStyle]::Bold)
        $lblStat.ForeColor = $statusColor
        $lblStat.Location = New-Object System.Drawing.Point(600, 9)
        $lblStat.Size = New-Object System.Drawing.Size(245, 24)
        $rowBg.Controls.Add($lblStat)

        # Hover tooltip -- attach to row, name, and status so it works no
        # matter where on the row the cursor lands.
        $detailText = "$($s.Description)`n`nGuide: $($s.GuideRef)"
        $tooltip.SetToolTip($rowBg, $detailText)
        $tooltip.SetToolTip($lblName, $detailText)
        $tooltip.SetToolTip($lblStat, $detailText)

        # Click popup -- more discoverable than hover for many users.
        # Attached to row, name, and status labels so clicking anywhere on
        # the row works, not just an exact pixel-perfect spot.
        $detailPopupHandler = {
            [System.Windows.Forms.MessageBox]::Show(
                "$($s.Description)`n`nGuide reference: $($s.GuideRef)",
                "$($s.ID). $($s.Name)",
                "OK", "Information"
            ) | Out-Null
        }.GetNewClosure()
        $rowBg.Add_Click($detailPopupHandler)
        $lblName.Add_Click($detailPopupHandler)
        $lblStat.Add_Click($detailPopupHandler)

        $yPos = [int](@($yPos)[0]) + 44
    }

    $panel.ResumeLayout($true)

    $lblLegend = New-Object System.Windows.Forms.Label
    $lblLegend.Text = "* = Manual action required    UNAVAILABLE = Not supported on this edition or requires admin"
    $lblLegend.Font = New-Object System.Drawing.Font("Garamond", 8, [System.Drawing.FontStyle]::Italic)
    $lblLegend.ForeColor = [System.Drawing.Color]::Silver
    $lblLegend.Location = New-Object System.Drawing.Point(45, ([int](@($yPos)[0]) + 4))
    $lblLegend.Size = New-Object System.Drawing.Size(790, 14)
    $panel.Controls.Add($lblLegend)

    $btnCheckAll = New-Object System.Windows.Forms.Button
    $btnCheckAll.Text = "Check All"
    $btnCheckAll.Location = New-Object System.Drawing.Point(10, 707)
    $btnCheckAll.Size = New-Object System.Drawing.Size(100, 32)
    $btnCheckAll.BackColor = [System.Drawing.Color]::FromArgb(50,50,50)
    $btnCheckAll.ForeColor = [System.Drawing.Color]::White
    $btnCheckAll.FlatStyle = "Flat"
    $btnCheckAll.Add_Click({ $checkboxes.Values | Where-Object { $_.Enabled } | ForEach-Object { $_.Checked = $true } })
    $form.Controls.Add($btnCheckAll)

    $btnClear = New-Object System.Windows.Forms.Button
    $btnClear.Text = "Clear All"
    $btnClear.Location = New-Object System.Drawing.Point(118, 707)
    $btnClear.Size = New-Object System.Drawing.Size(100, 32)
    $btnClear.BackColor = [System.Drawing.Color]::FromArgb(50,50,50)
    $btnClear.ForeColor = [System.Drawing.Color]::White
    $btnClear.FlatStyle = "Flat"
    $btnClear.Add_Click({ $checkboxes.Values | ForEach-Object { $_.Checked = $false } })
    $form.Controls.Add($btnClear)

    $btnRun = New-Object System.Windows.Forms.Button
    $btnRun.Text = "RUN SELECTED"
    $btnRun.Location = New-Object System.Drawing.Point(648, 707)
    $btnRun.Size = New-Object System.Drawing.Size(140, 32)
    $btnRun.BackColor = [System.Drawing.Color]::FromArgb(0,120,60)
    $btnRun.ForeColor = [System.Drawing.Color]::White
    $btnRun.FlatStyle = "Flat"
    $btnRun.Font = New-Object System.Drawing.Font("Garamond", 10, [System.Drawing.FontStyle]::Bold)
    $form.Controls.Add($btnRun)

    $btnExit = New-Object System.Windows.Forms.Button
    $btnExit.Text = "Exit"
    $btnExit.Location = New-Object System.Drawing.Point(796, 707)
    $btnExit.Size = New-Object System.Drawing.Size(78, 32)
    $btnExit.BackColor = [System.Drawing.Color]::FromArgb(120,30,30)
    $btnExit.ForeColor = [System.Drawing.Color]::White
    $btnExit.FlatStyle = "Flat"
    $btnExit.Add_Click({
        $resp = [System.Windows.Forms.MessageBox]::Show(
            "Are you sure you want to exit?`n`nNo changes will be saved unless you clicked Run Selected.",
            "Confirm Exit", "YesNo", "Question"
        )
        if ($resp -eq "Yes") { Disable-SleepPrevention; Save-Log; $form.Close() }
    })
    $form.Controls.Add($btnExit)

    $btnRun.Add_Click({
        $selectedIDs = $checkboxes.Keys | Where-Object { $checkboxes[$_].Checked }
        if ($selectedIDs.Count -eq 0) {
            [System.Windows.Forms.MessageBox]::Show("No settings selected. Please check at least one.", "Nothing Selected", "OK", "Warning")
            return
        }

        Write-Log -Message "=== GUI Mode Hardening Run Started ===" -Status "START"
        $btnRun.Enabled = $false
        $btnRun.Text = "Running..."

        foreach ($id in ($selectedIDs | Sort-Object)) {
            if ($id -eq 8) { continue }
            $s = $Settings | Where-Object { $_.ID -eq $id }

            if ($s.Status -match "GOOD") {
                Write-Log -Message "$($s.Name) -- already correct, skipped" -Status "GOOD"
                continue
            }

            if (-not $s.CanAuto) {
                [System.Windows.Forms.MessageBox]::Show(
                    "$($s.Name) requires manual action.`n`n$($s.Description)`n`nSee Guide: $($s.GuideRef) at $GuideURL",
                    "Manual Action Required -- $($s.Name)", "OK", "Information"
                )
                Write-Log -Message "$($s.Name) -- Manual action required" -Status "MANUAL"
                continue
            }

            $msg = "Apply: $($s.Name)?`n`n$($s.Description)`n`nCurrent status: $($s.Status)`n`nGuide: $($s.GuideRef)"
            $confirm = [System.Windows.Forms.MessageBox]::Show($msg, "Confirm -- $($s.Name)", "YesNo", "Question")

            if ($confirm -eq "Yes") {
                $result = Apply-Setting -Setting $s
                [System.Windows.Forms.MessageBox]::Show("Result:`n$result", "Applied -- $($s.Name)", "OK", "Information")
            } else {
                Write-Log -Message "$($s.Name) -- Skipped by user" -Status "SKIP"
            }
        }

        if ($checkboxes.ContainsKey(8) -and $checkboxes[8].Checked) {
            $form.Hide()
            # G-02b rev (ascii33, FT-101): inline tip, no blank screen, no pause
            Write-Host ""
            Write-Host "  Tip: To copy text from this window -- press Alt+Space, then E, then M --" -ForegroundColor Cyan
            Write-Host "       drag or use Shift+arrows to select -- press Enter to copy." -ForegroundColor Cyan
            Write-Host "       Press Esc to exit without copying." -ForegroundColor Cyan
            Show-BitLockerScreen
        }

        Save-Log
        Set-FirstRunComplete
        Disable-SleepPrevention
        $form.Hide()
        Setup-ScheduledTasks
        Show-ManualSteps

        # FT-119 (ascii34): explicitly state GatewayGuard is closing after
        # this dialog, matching the console-mode ending (Show-ManualSteps'
        # own closing statement + the "close GatewayGuard" exit prompt).
        [System.Windows.Forms.MessageBox]::Show(
            "All selected settings processed. Checkup will now close.`n`nLog: $(Split-Path $LogPath -Leaf)`n`nSee the console window for your manual steps checklist -- complete those on your own time.`n`nGuide: $GuideURL",
            "Run Complete -- Checkup Closing", "OK", "Information"
        )
        $form.Close()
    })

    $form.ShowDialog() | Out-Null
}

# ============================================================
# MAIN ENTRY POINT
# Pre-flight sequence (in order):
# 0. Resume check  1. Opening/maximize/scroll (UX-01,02,03)  2. Font instructions
# 3. Company PC warning  4. Domain check  5. Admin check
# 6. Edition detection  7. RAM check  8. Time/date check (UX-08)
# 9. System Baseline Summary (UX-10)  10. First run  11. Pre-scan gate
# 12. Defender AV check  13. Power check  14. Power settings  15. Apps audit
# Then: mode selection -> Run-ConsoleMode or Run-GUIMode
# BitLocker is always LAST inside the mode functions
# ============================================================
# FT-66+73 (ascii31): global try covers entire launch including Disable-
# QuickEdit and Show-ResumePrompt -- ascii29 had a gap here.
try {

# FT-26: show immediately.
Clear-Host
Write-Host ""
Write-Host "  Please wait -- checking your system..." -ForegroundColor Cyan

# FT-19 (2026-07-11): identify the machine BEFORE anything renders or logs,
# so the launch header and the log header both carry it from line one.
Get-MachineIdentity

Clear-Host
Write-Host ""
# FT-184 (ascii41): the four-line identity banner that stood here was
# painted and then wiped by Show-ResumePrompt's Clear-Host about a
# second later -- Bill's ascii39 finding 1 and ascii40 finding 1a,
# "something flashes by before you get to screen 1".
# On the proposal to give it a pause instead, Bill 2026-08-17: "no
# senior including me is going to remember that." That disposes of the
# fix rather than adjusting it -- the build number and Machine ID are
# wanted on a support call days later, so no screen shown at launch can
# serve the purpose. FETCH beats DISPLAY. Replaced by FT-189.
# Nothing is lost by deleting it: intro screen 3 already prints the
# same version, build and Machine ID, and it pauses.
Write-Host ""
Initialize-LogFile

# FT-150 + FT-160 (ascii39): register the console control handler AS SOON AS the
# log file exists and BEFORE any screen renders. It needs the log path, and the
# whole point of it is that the log survives an abrupt close -- so every moment
# between Initialize-LogFile and this call is a moment the footer could still be
# lost. There is no user interaction before this point, so the window is as
# small as it can be made.
Register-ConsoleCtrl -Path $LogPath

# FT-63 (ascii28): the log FILENAME is stamped in the first instant of
# launch; this header moments later. The 7/12 logs showed an 84-minute gap
# between the two -- the console was frozen in text-selection (Mark) mode,
# which pauses the program whenever it writes. Make that self-diagnosing.
try {
    $ggLaunchStamp = [datetime]::ParseExact((([System.IO.Path]::GetFileNameWithoutExtension($LogPath)) -replace '^GatewayGuard-Log-',''), 'yyyy-MM-dd_HH-mm', $null)
    $ggInitDelaySec = ((Get-Date) - $ggLaunchStamp).TotalSeconds
    if ($ggInitDelaySec -gt 60) {
        Write-Log -Message ("FT-63: startup was delayed {0:N0} minute(s) between launch and initialization -- console was likely frozen in text-selection (Mark) mode; Esc releases it" -f ($ggInitDelaySec/60)) -Status "WARN"
    }
} catch {}
# FT-137 (ascii38): the Gallery runs INSTEAD of the tool and exits. Placed
# after logging is initialised so the review session is recorded, and before any
# system check runs so nothing on this PC is read or touched.
if ($Gallery) {
    Write-Log -Message "SCREEN GALLERY opened (review mode -- no checks run, nothing changed)" -Status "START"
    Show-ScreenGallery
    Write-Log -Message "SCREEN GALLERY closed" -Status "EXIT"
    Save-Log
    exit
}

Write-Log -Message "Tool launched v$ScriptVersion build $BuildID" -Status "START"
Write-Log -Message ("Log location: " + (Split-Path $LogPath -Parent) + $(if ($global:GGUsingOneDrive) { "  (OneDrive -- already set up on this PC)" } else { "  (local -- no OneDrive found)" })) -Status "INFO"
Write-Log -Message "Machine: $global:MachineMake $global:MachineModel | MachineID: $global:MachineID" -Status "INFO"

# Detect admin status IMMEDIATELY -- must happen before Show-FontInstructions,
# which checks $global:IsAdmin. (BUGFIX ascii23: this used to run too late,
# so the "run as Administrator" warning showed even when already elevated.)
$global:IsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")

# Activate sleep/screen prevention immediately -- before any screen is shown
Enable-SleepPrevention
Suspend-ScreenSaver

# 0. Resume check (UX-05, UX-06) -- must happen before anything else renders
Show-ResumePrompt

# 1-2. Intro sequence (FT-04 order, 2026-07-11): Welcome/maximize -> scroll
# -> font setup -> window setup -> overview, with B = Back navigation
# (FT-18). Skipped entirely if resuming -- the user has already seen it.
if (-not $global:ResumeFrom) {
    Show-FontInstructions
    # FT-41/45 (ascii28): scroll & copy instructions, incl. the Mark-mode
    # pause behavior (FT-63)
    Show-ScrollCopyTip
}

# 3-5. Computer / domain / admin checks. FT-47 (ascii28): on RESUME these
# used to replay as full flashing screens -- one quiet re-check screen now.
# Fresh runs still get the full sequence.
if ($global:ResumeFrom) {
    Show-ResumeReverify
} else {
    Test-PersonalComputer
    Test-DomainJoin
    Test-AdminAccess
}

# 6. Edition detection (WMI ONLY -- no Get-WindowsEdition)
Get-WinEdition

# 7. RAM check
Get-RAMStatus

# 8. Time & date sync check (UX-08) -- skip if already done before reboot
if (-not (Test-CheckpointReached -Checkpoint "Baseline")) {
    Test-TimeDateSync
}

# 9. System Baseline Summary (UX-10) -- Step 0 concept, shown once up front
if (-not (Test-CheckpointReached -Checkpoint "Baseline")) {
    Show-SystemBaselineSummary
    Save-Checkpoint -Checkpoint "Baseline"
}

# 10. First run flag
Test-FirstRun

# 10b. D-06 (ascii33): security tools + scan plan briefing -- ALWAYS
# before any scan screen. Checkpointed so resume paths skip it (C-20
# acknowledgement printed when skipped on resume).
#
# FT-121 (ascii37): TWO defects, one line apart.
#
# (1) "Briefing" was SAVED as a checkpoint below but was never a MEMBER of
#     $global:CheckpointOrder. Test-CheckpointReached "Briefing" therefore
#     hit IndexOf -> -1 and returned $false forever, so this condition
#     collapsed to just $global:IsFirstRun. Worse, saving it OVERWROTE the
#     valid "Baseline" checkpoint written a few lines above, and
#     Show-ResumePrompt guards with ($saved -in $global:CheckpointOrder),
#     which "Briefing" failed -- so the resume prompt never appeared and the
#     user silently lost their place. A Class 1 invisible failure: the
#     checkpoint system reported nothing wrong while doing nothing.
#     "Briefing" is now a real member of CheckpointOrder, between "Baseline"
#     and "PreScanPrep", so both the skip test and the resume guard work.
#
# (2) The $global:IsFirstRun gate is REMOVED. It meant the two screens that
#     explain Defender and Malwarebytes rendered on a FIRST RUN ONLY. The
#     2026-07-27 session was a repeat run, so both were skipped -- which is
#     why field note 3 read the Defender/Malwarebytes screens as "out of
#     order" and asked that the tool "first explain about defender and MB and
#     then ask about running defender offline". IT ALREADY DOES THAT. The
#     tester was simply never receiving the explanation. This is the THIRD
#     occurrence: the ascii34 test plan already recorded SCREEN-26/27 as "not
#     observed in any of four ascii33 logs".
#     The checkpoint alone now controls the skip, which is the correct
#     mechanism -- it skips what this user has already seen in THIS
#     run-through, not what some earlier run showed them weeks ago.
#
# Class 6 rule 5 note: this closes field note 3's ROOT CAUSE only. Note 3
# also asked for screen numbering and two screen documents; those are FT-122
# and the two documents delivered 2026-07-28, tracked separately and
# deliberately NOT closed by this fix.
if (-not (Test-CheckpointReached -Checkpoint "Briefing")) {
    Show-SecurityToolsBriefing
    Show-ScanPlanBriefing
    Save-Checkpoint -Checkpoint "Briefing"
} elseif ($global:ResumeFrom) {
    # C-20: acknowledge skipped content -- never silent
    Write-Host ""
    Write-Host "  (Resuming -- your earlier progress is saved, so we are skipping" -ForegroundColor DarkGray
    Write-Host "   straight past the parts you already completed.)" -ForegroundColor DarkGray
}

# 11. Pre-scan gate -- now a real automated flow (UX-04,05,06,07,09,11),
# replaces ascii22's old manual-instructions-only version.
if (-not (Test-CheckpointReached -Checkpoint "OfflineScanDone")) {
    Show-PreScanGate
}

# 12. Defender primary AV check -- MOVED BEFORE Malwarebytes (D-06,
# ascii33): confirm Defender is your active antivirus first, then add
# the companion scanner. Was after MB through ascii32.
if (-not (Test-CheckpointReached -Checkpoint "DefenderAV")) {
    Test-DefenderPrimary
    Save-Checkpoint -Checkpoint "DefenderAV"
}

# 12b. Malwarebytes detect-and-launch (UX-06 standalone checkpoint)
if (-not (Test-CheckpointReached -Checkpoint "Malwarebytes")) {
    Show-MalwarebytesFollowUp
    Save-Checkpoint -Checkpoint "Malwarebytes"
}

# 13. Power check and sleep prevention (FT-47: a resume already did this
# quietly inside Show-ResumeReverify)
if (-not $global:ResumeFrom) { Test-PowerStatus }

# 14. Power settings review
if (-not (Test-CheckpointReached -Checkpoint "PowerSettings")) {
    Run-PowerSettingsCheck
    Save-Checkpoint -Checkpoint "PowerSettings"
}

# 15. Apps audit
if (-not (Test-CheckpointReached -Checkpoint "AppsAudit")) {
    Run-AppsAudit
    Save-Checkpoint -Checkpoint "AppsAudit"
}

# Mode selection (FT-64, ascii28: wrapped in a function so the key log names
# the screen -- it used to print the script filename as the location)
function Select-Mode {
    Show-ModeSelector
    do {
        $smChoice = Read-ValidKey -ValidKeys @("1","2","3") -Prompt "Enter choice (1, 2, or 3): "
    } while ($smChoice -notin "1","2","3")
    return $smChoice
}
$choice = Select-Mode

Write-Log -Message "Mode selected: $(if ($choice -eq '1') { 'Console' } elseif ($choice -eq '2') { 'GUI' } else { 'Exit' })" -Status "INFO"

switch ($choice) {
    "1" { Run-ConsoleMode }
    "2" { Run-GUIMode }
    "3" {
        Write-Host ""
        Write-Host "  Exiting. No changes made." -ForegroundColor Gray
        Write-Host ""
        Write-Log -Message "User exited at mode selection" -Status "EXIT"
        Disable-SleepPrevention
        Save-Log
        exit
    }
}


# FT-66 (ascii29): global error trap -- see comment at try above
} catch {
    try {
        Write-Log -Message ("UNHANDLED ERROR: " + $_.Exception.Message) -Status "ERROR"
        Write-Log -Message ("Location: " + (($_.InvocationInfo.PositionMessage -split "\r?\n")[0])) -Status "ERROR"
        Write-Log -Message ("Stack: " + $_.ScriptStackTrace) -Status "ERROR"
    } catch {}
    try { Save-Log } catch {}
    try { Disable-SleepPrevention } catch {}
    try { Restore-ScreenSaver } catch {}
    Write-Host ""
    Write-Host "  Something went wrong and the program cannot continue." -ForegroundColor Red
    Write-Host "  The details were saved to your log file:" -ForegroundColor Yellow
    Write-Host "  $LogPath" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  Press Enter or Space to close this window..." -ForegroundColor White
    try { do { $ggErrKey = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") } while ($ggErrKey.VirtualKeyCode -notin @(13, 32)) } catch { $null = Read-Host }
}
# ============================================================
# PRE-BUILD AUDIT: Verify all 15 required functions are present
# (run this block manually to verify before shipping)
# ============================================================
# $requiredFunctions = @(
#     'Enable-SleepPrevention','Disable-SleepPrevention','Get-RAMStatus',
#     'Get-WinEdition','Test-DefenderPrimary','Get-AllStatuses','Apply-Setting',
#     'Run-ConsoleMode','Run-GUIMode','Show-BitLockerScreen','Write-Log',
#     'Save-Log','Draw-Box','Test-PersonalComputer','Test-AdminAccess'
# )
# $defined = (Get-Command -CommandType Function).Name
# $requiredFunctions | ForEach-Object {
#     $status = if ($_ -in $defined) { 'OK' } else { 'MISSING' }
#     Write-Host "  $status  $_"
# }
