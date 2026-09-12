"""build_ascii44_screens -- FT-244 and FT-243. Two screens the user could not read.

FT-244 -- SCREEN 32 IS DRAWN AND NEVER PAUSED
---------------------------------------------
Bill, screen 33: "Is there a screen 32." Yes, and he never got to read it.

MEASURED, log 2026-08-30_11-04, both at 16:09:43, the same second, with no
keypress between them:
    [SCREEN-69] (shown as screen 32) Rendered: ALL SELECTED ITEMS PROCESSED
    [SCREEN-70] (shown as screen 33) Rendered: AUTOMATED SCAN SCHEDULE SETUP

The box is drawn and Setup-ScheduledTasks is called on the next line, which
clears the screen. CLAUDE.md, Screen / UX Standards: "All screens need pauses
before proceeding."

SAME FAMILY, SAME RUN -- Bill: "Scr 34 - appeared at a bottom of Scr 3b. Fix
this." MEASURED, source: Show-ManualSteps (SCREEN-72, shown as screen 34) is
the ONLY one of the wrap-up screens that does not begin with Clear-Host --
Setup-ScheduledTasks clears, Show-OneDriveOffer clears, Show-ManualSteps does
not. So it painted on top of whatever the convenience review had left on
screen, which is exactly what Bill saw.

FT-243 -- THE REQUIRED LOG NOTICE IS ON THE WRONG SCREEN
--------------------------------------------------------
The rule, CLAUDE.md Product Rules: "For your protection, your choices can be
reviewed in your log" -- shown ONCE ONLY, ON THE REVIEW SCREEN.

Bill, screen 27: "Did not see this on the Screen -- choices can be reviewed
in your log."

MEASURED, ascii43: exactly one occurrence, inside Show-BitLockerFinalDecline
-- screen 25e, "YOUR CHOICE IS NOTED -- NO ENCRYPTION WILL BE APPLIED". That
is the screen you reach ONLY by declining drive encryption, so a user who
ACCEPTS encryption never saw the notice at all.

The "once only" half was implemented correctly -- $script:GGLogNoticeShown
guards it. It was guarding the wrong screen. The guard moves with the line, so
a user who declines encryption and then reaches the review screen still sees
it exactly once.

Run from Tool2/:  python build_ascii44_screens.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

with PS1Edit(TARGET) as e:

    # -- FT-244a: pause screen 32 before the next function clears it ---------
    e.replace(
        '                Setup-ScheduledTasks\n',
        '                # FT-244 (ascii44): Setup-ScheduledTasks begins with\n'
        '                # Clear-Host, so without this pause screen 32 was drawn\n'
        '                # and wiped in the same second -- measured 16:09:43,\n'
        '                # 2026-08-30. Bill: "Is there a screen 32."\n'
        '                Write-Host ""\n'
        '                Pause-ForUser "  Press Enter or Space to continue..."\n'
        '                Setup-ScheduledTasks\n',
        count=1,
        why="FT-244: pause screen 32 (SCREEN-69) before the next screen clears it",
    )

    # -- FT-244b: screen 34 painted on top of the previous screen ------------
    e.replace(
        'function Show-ManualSteps {\n'
        '    Write-Host ""\n',
        'function Show-ManualSteps {\n'
        '    # FT-244 (ascii44): this was the ONLY wrap-up screen with no\n'
        '    # Clear-Host -- Setup-ScheduledTasks and Show-OneDriveOffer both\n'
        '    # clear. So SCREEN-72 painted on top of whatever was already on\n'
        '    # screen. Bill: "Scr 34 - appeared at a bottom of Scr 3b. Fix this."\n'
        '    Clear-Host\n'
        '    Write-Host ""\n',
        count=1,
        why="FT-244: Show-ManualSteps (SCREEN-72) drew over the previous screen",
    )

    # -- FT-243: take the notice off the decline-only screen ------------------
    e.replace(
        '    Write-Host ""\n'
        '    if (-not $script:GGLogNoticeShown) {\n'
        '        Write-Host "  For your protection, your choices can be reviewed in your log." -ForegroundColor Gray\n'
        '        Write-Host ""\n'
        '        $script:GGLogNoticeShown = $true\n'
        '    }\n'
        '    $fd = Read-ValidKey',
        '    Write-Host ""\n'
        '    # FT-243 (ascii44): the log notice used to live here. This screen is\n'
        '    # reached ONLY by declining encryption, so a user who accepted it\n'
        '    # never saw the notice at all -- and the rule says it belongs on the\n'
        '    # review screen. Moved there; the once-only guard moved with it.\n'
        '    $fd = Read-ValidKey',
        count=1,
        why="FT-243: remove the notice from the decline-only screen (25e)",
    )

    # -- FT-243: put it on the review screen, where the rule says it goes -----
    e.replace(
        '                Write-Host "  $selectedCount item(s) will be applied -- selecting them was your approval. Any that need a manual step will show you how." -ForegroundColor Yellow\n'
        '                Write-Host ""\n',
        '                Write-Host "  $selectedCount item(s) will be applied -- selecting them was your approval. Any that need a manual step will show you how." -ForegroundColor Yellow\n'
        '                Write-Host ""\n'
        '                # FT-243 (ascii44): the required notice, on the review\n'
        '                # screen the rule names. Bill, screen 27: "Did not see\n'
        '                # this on the Screen -- choices can be reviewed in your\n'
        '                # log." It was on screen 25e, which only appears if you\n'
        '                # decline encryption. The once-only guard is unchanged.\n'
        '                if (-not $script:GGLogNoticeShown) {\n'
        '                    Write-Host "  For your protection, your choices can be reviewed in your log." -ForegroundColor Gray\n'
        '                    Write-Host ""\n'
        '                    $script:GGLogNoticeShown = $true\n'
        '                }\n',
        count=1,
        why="FT-243: log notice onto the review screen, where the product rule puts it",
    )

    # -- header change record -------------------------------------------------
    e.replace(
        "# CHANGES FROM ascii39 (2026-08-15 -- ASCII40: THE THREE FIELD BLOCKERS):",
        "#   FT-244: SCREEN 32 WAS DRAWN AND NEVER PAUSED. Setup-ScheduledTasks\n"
        "#           begins with Clear-Host, so SCREEN-69 was painted and wiped\n"
        "#           in the same second -- measured 16:09:43, 2026-08-30, two\n"
        "#           renders one second apart with no keypress between them.\n"
        "#           Bill: \"Is there a screen 32.\" Same family: Show-ManualSteps\n"
        "#           (SCREEN-72) was the only wrap-up screen with no Clear-Host,\n"
        "#           so it painted on top of the previous one -- Bill: \"Scr 34 -\n"
        "#           appeared at a bottom of Scr 3b.\"\n"
        "#   FT-243: THE REQUIRED LOG NOTICE WAS ON A SCREEN HALF THE USERS NEVER\n"
        "#           REACH. The rule says it goes on the review screen, once. It\n"
        "#           was inside Show-BitLockerFinalDecline -- screen 25e, reached\n"
        "#           only by DECLINING encryption -- so anyone who accepted\n"
        "#           encryption never saw it. Bill, screen 27: \"Did not see this\n"
        "#           on the Screen.\" The once-only guard was correct all along;\n"
        "#           it was guarding the wrong screen.\n"
        "#\n"
        "# CHANGES FROM ascii39 (2026-08-15 -- ASCII40: THE THREE FIELD BLOCKERS):",
        count=1,
        why="FT-244/FT-243: header change record",
    )
