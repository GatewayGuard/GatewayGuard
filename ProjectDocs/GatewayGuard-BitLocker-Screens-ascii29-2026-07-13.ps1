# ============================================================
# GatewayGuard -- BitLocker Decision Screens (for build ascii29)
# Dated: 2026-07-13 22:47 ET
# William F. Burns III | GatewayGuard | gatewayguard.co
# Purpose: Drop-in functions for the encryption decision flow:
#          decline HEADS UP -> full explanation -> final decline
#          -> or go back, select, and see the pre-run write-up.
# Compatibility: Windows PowerShell 5.1, ASCII only, -join only
# Integration: paste these functions into the ascii29 build and
#          wire per the INTEGRATION NOTES at the bottom.
# ============================================================

# ------------------------------------------------------------
# Read-GGKey -- hardened key reader
# Fixes two ascii28 field problems in one place:
#   1) Flushes the input buffer BEFORE reading, so held-down or
#      buffered keys (the 52 'S' flood in the 07-13 log) cannot
#      auto-answer prompts.
#   2) Detects Ctrl+C and returns 'CTRLC' so the caller can do a
#      clean exit (restore sleep settings, close log) instead of
#      Ctrl+C doing nothing.
# ------------------------------------------------------------
function Read-GGKey {
    param([string[]]$Allowed)   # e.g. @('Y','N','S')
    $Host.UI.RawUI.FlushInputBuffer()
    while ($true) {
        $k = [Console]::ReadKey($true)
        if (($k.Modifiers -band [ConsoleModifiers]::Control) -and $k.Key -eq 'C') {
            return 'CTRLC'
        }
        $ch = ([string]$k.KeyChar).ToUpper()
        if ($Allowed -contains $ch) { return $ch }
        # ignore anything else; do not consume buffered repeats
        $Host.UI.RawUI.FlushInputBuffer()
    }
}

# ------------------------------------------------------------
# Screen: full explanation and recommendation (the 'S' screen)
# ------------------------------------------------------------
function Show-BitLockerExplanation {
    Clear-Host
    $lines = @(
        '============================================================'
        '  DRIVE ENCRYPTION (BitLocker) -- WHAT IT IS, WHY IT MATTERS'
        '============================================================'
        ''
        '  WHAT IT DOES'
        '  BitLocker is built into Windows 11 Pro. It scrambles'
        '  (encrypts) everything on your hard drive. Only this'
        '  computer, unlocked with your normal sign-in, can'
        '  unscramble it.'
        ''
        '  WHY WE RECOMMEND IT'
        '  If your laptop is ever lost or stolen, a thief can pull'
        '  out the drive, connect it to another computer, and read'
        '  every file on it -- taxes, banking, passwords, photos --'
        '  without ever knowing your Windows password.'
        '  Encryption closes that door. A stolen encrypted drive is'
        '  unreadable scrambled data.'
        ''
        '  WHAT IT COSTS YOU'
        '  - One overnight run. You can keep using the PC while it'
        '    works, but overnight is easiest. It never needs to run'
        '    again.'
        '  - No noticeable slowdown on a modern PC.'
        '  - You MUST keep your recovery key. This tool saves it for'
        '    you and shows you exactly where. Keep a copy somewhere'
        '    OFF this computer -- printed, or in your password'
        '    manager.'
        ''
        '  THE ONE REAL RISK'
        '  If Windows ever asks for the recovery key at startup and'
        '  you cannot find it, the files stay locked. That is why'
        '  saving the key is step one -- BEFORE anything is'
        '  encrypted.'
        ''
        '  RECOMMENDATION: Turn this ON. For a laptop, this is one'
        '  of the most valuable protections in this entire tool.'
        ''
        '  Press any key to return...'
    )
    $lines | ForEach-Object { Write-Host $_ }
    $Host.UI.RawUI.FlushInputBuffer()
    [Console]::ReadKey($true) | Out-Null
}

# ------------------------------------------------------------
# Screen: first decline (encryption not selected at review)
# Returns: 'Skip' or 'GoBack' or 'CTRLC'
# ------------------------------------------------------------
function Show-BitLockerDeclineHeadsUp {
    while ($true) {
        Clear-Host
        $lines = @(
            '============================================================'
            '  HEADS UP -- YOU HAVE NOT SELECTED DRIVE ENCRYPTION'
            '============================================================'
            ''
            '  Drive encryption (BitLocker) is not selected.'
            ''
            '  Everything else this tool does protects a computer that'
            '  is in your hands. Encryption is the one item that'
            '  protects your files if the computer LEAVES your hands --'
            '  lost, stolen, or sold without being wiped.'
            ''
            '  Without it, anyone holding this laptop can read your'
            '  files by connecting the drive to another computer. Your'
            '  Windows password does not stop that.'
            ''
            '  Y = Continue WITHOUT encryption'
            '  N = Go back and select encryption'
            '  S = See the full explanation'
        )
        $lines | ForEach-Object { Write-Host $_ }
        $key = Read-GGKey -Allowed @('Y','N','S')
        if ($key -eq 'CTRLC') { return 'CTRLC' }
        if ($key -eq 'S') { Show-BitLockerExplanation; continue }
        if ($key -eq 'N') { return 'GoBack' }
        # Y -> second-level confirmation
        $final = Show-BitLockerFinalDecline
        if ($final -eq 'GoBack') { return 'GoBack' }
        return $final   # 'Skip' or 'CTRLC'
    }
}

# ------------------------------------------------------------
# Screen: final decline (they pressed Y at the HEADS UP)
# Returns: 'Skip' or 'GoBack' or 'CTRLC'
# ------------------------------------------------------------
function Show-BitLockerFinalDecline {
    Clear-Host
    $lines = @(
        '============================================================'
        '  YOUR CHOICE IS NOTED -- NO ENCRYPTION WILL BE APPLIED'
        '============================================================'
        ''
        '  That is entirely your call -- this is your computer, and'
        '  this tool never applies anything you did not choose.'
        ''
        '  Two things worth knowing:'
        ''
        '  1. You can turn encryption on any time. Run this tool'
        '     again and select the Drive Encryption item. One'
        '     overnight run and it is done.'
        ''
        '  2. Until then, treat this laptop like a wallet: know'
        '     where it is, especially when traveling.'
        ''
    )
    # Log notice: shown ONCE per session only
    if (-not $script:GGLogNoticeShown) {
        $lines += '  For your protection, your choices can be reviewed in'
        $lines += '  your log.'
        $lines += ''
        $script:GGLogNoticeShown = $true
    }
    $lines += '  Y = Confirm: continue without encryption'
    $lines += '  N = Actually, go back and select encryption'
    $lines | ForEach-Object { Write-Host $_ }

    $key = Read-GGKey -Allowed @('Y','N')
    if ($key -eq 'CTRLC') { return 'CTRLC' }
    if ($key -eq 'N')     { return 'GoBack' }

    # NOTED status only -- never WARN -- per customer wording rules
    $msg = -join ('NOTED: User chose not to apply: Drive Encryption (BitLocker)',
                  ' -- Status: C: not encrypted -- can be enabled later by re-running the tool')
    Write-GGLog 'NOTED' $msg
    return 'Skip'
}

# ------------------------------------------------------------
# Screen: pre-run write-up (encryption IS selected, about to run)
# Returns: 'Run' or 'GoBack' or 'CTRLC'
# ------------------------------------------------------------
function Show-BitLockerPreRun {
    while ($true) {
        Clear-Host
        $lines = @(
            '============================================================'
            '  DRIVE ENCRYPTION (BitLocker) -- READY TO RUN'
            '============================================================'
            ''
            '  Here is exactly what happens next, in order:'
            ''
            '  1. Your recovery key is created and saved to a file on'
            '     your Desktop FIRST, before anything is encrypted.'
            '     Copy it to your password manager or print it.'
            ''
            '  2. Encryption starts (XTS-AES 256, full drive). It runs'
            '     quietly in the background -- overnight is ideal.'
            '     Keep the laptop plugged in. If Windows restarts,'
            '     encryption picks up where it left off.'
            ''
            '  3. When finished, the drive shows FULLY ENCRYPTED and'
            '     protection is ON. Nothing about how you use the PC'
            '     changes. It never needs to run again.'
            ''
            '  Y = Save my recovery key and start encryption'
            '  N = Go back'
            '  S = See the full explanation'
        )
        $lines | ForEach-Object { Write-Host $_ }
        $key = Read-GGKey -Allowed @('Y','N','S')
        if ($key -eq 'CTRLC') { return 'CTRLC' }
        if ($key -eq 'S') { Show-BitLockerExplanation; continue }
        if ($key -eq 'N') { return 'GoBack' }
        return 'Run'
    }
}

# ============================================================
# INTEGRATION NOTES (ascii29)
# ------------------------------------------------------------
# 1. Review stage: if the BitLocker item is deselected, call
#    Show-BitLockerDeclineHeadsUp. 'GoBack' -> reopen selection
#    with the Drive Encryption item highlighted. 'Skip' ->
#    continue to review. 'CTRLC' -> clean-exit routine.
# 2. Execution stage: before running item 8, call
#    Show-BitLockerPreRun. Only 'Run' proceeds.
# 3. Replace Write-GGLog with the tool's logger if named
#    differently. Logger must use Out-File -Append -Encoding UTF8
#    per PowerShell standards.
# 4. $script:GGLogNoticeShown must be initialized $false at
#    session start (once-only log notice rule). If the main
#    scope disclaimer already shows the log notice, leave this
#    guard in place -- it prevents a second display.
# 5. Adopt Read-GGKey for ALL prompts, not just these screens.
#    It fixes the buffered-key flood and dead Ctrl+C globally.
# 6. Open bugs still requiring the ascii28 source to fix:
#    a) Resume redirects logging into the PREVIOUS session's log
#       file (checkpoint restores the old log path) -- this is
#       the 07-12 log containing 07-13 entries.
#    b) No top-level error trap: crashes leave no [ERROR] line.
#    c) Per-item skip gauntlet at Test-NonRecommendedSelections
#       needs a Skip All option.
# ============================================================
