"""build_ascii45_ft294_ft297_items17_8 -- the two false results from Bill's
CGDELL test runs: item 17 (FT-294) and item 8 (FT-297).

Dated: 2026-09-28 07:52 ET
Editor: Claude Code (CGDELL)
Bill, 2026-09-28: "fix item 8 and item 17 first".

FT-294 -- item 17 said "REQUIRED -- GOOD" while a wake within 15 minutes needs
no password. MEASURED on CGDELL 2026-09-27: HKCU\\Control Panel\\Desktop
DelayLockInterval = 900, matching Settings' "If you've been away ... 15
minutes" (Bill); powercfg /a: Modern Standby. SOURCED (Winaero, ElevenForum):
DelayLockInterval 0 = every time, 60/180/300/900 = 1/3/5/15 min,
0xFFFFFFFF = never. Get-GGConsoleLockState now returns DELAYED when
CONSOLELOCK is on but DelayLockInterval is set and not 0 -- never GOOD --
and the two applies set it to 0 (only where the value exists) and re-read.

FT-297 -- item 8 on an already-encrypted drive ran Enable-BitLocker, which only
added a recovery key, and then claimed encryption had started. MEASURED on
CGDELL 2026-09-28 07:33: FullyEncrypted, protection Off, Tpm + FIVE
RecoveryPassword protectors. Item 8's status now tells "encrypted, protection
off" apart, and Show-BitLockerScreen stops before any command when the drive
is not FullyDecrypted, showing screen 96 instead: how to turn protection back
on and keep the existing key. No new command is introduced.

Run from Tool2/:  python build_ascii45_ft294_ft297_items17_8.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

SCREEN96 = r'''function Show-GGEncryptedNotProtected {
    # FT-297 (ascii45): the drive is already encrypted but protection is off.
    # Measured on CGDELL 2026-09-28 (FullyEncrypted, protection Off) and SANDY
    # 2026-09-27 (same state; a local account could not finish it -- FT-289).
    # Checkup must NOT run Enable-BitLocker here: on CGDELL it only added a
    # fifth recovery key and then reported that encryption had started.
    param($Volume)
    $ggHome = $global:WinEdition -notmatch "Pro|Enterprise|Education|Business"
    Clear-Host
    Write-Host ""
    Draw-Box -ScreenId "96" -Color Yellow -Lines @(
        "  YOUR DRIVE IS ALREADY ENCRYPTED -- PROTECTION IS OFF        ",
        "---",
        "  Your drive is already encrypted, but its protection is     ",
        "  turned off. Until protection is on, the drive is not       ",
        "  locked: someone who took it out of this PC could read it.  ",
        "                                                             ",
        "  Checkup does NOT start encryption again -- it is already   ",
        "  done -- and it does NOT make another recovery key.         ",
        "                                                             ",
        "  TO TURN PROTECTION BACK ON:                                ",
        $(if ($ggHome) { "  1. Press the Windows key, type  Device encryption , Enter. " } else { "  1. Press the Windows key, type  Manage BitLocker , Enter.  " }),
        $(if ($ggHome) { "  2. Turn Device encryption On. On a local account (one that " } else { "  2. Next to drive C:, click  Resume protection.             " }),
        $(if ($ggHome) { "     is not a Microsoft account) Windows may not be able to " } else { "  3. On the same page, click  Back up your recovery key,     " }),
        $(if ($ggHome) { "     finish this -- it needs somewhere to save the key.     " } else { "     and keep it somewhere safe that is NOT this PC.         " }),
        "                                                             ",
        "  Checkup checks this again on your next run.                "
    )
    Write-Log -Message ("Item 8: drive already encrypted (" + $Volume.VolumeStatus + ", " + $Volume.EncryptionPercentage + "%) with protection " + $Volume.ProtectionStatus + " -- no encryption command run, no key made; manual steps shown (FT-297)") -Status "MANUAL"
    Write-Host ""
    Pause-ForUser "  Press Enter or Space to continue..."
}

function Show-BitLockerScreen {'''

with PS1Edit(TARGET) as e:
    e.replace(
        "#           Ctrl+C (measured, tests A-D, 2026-09-27).\n",
        "#           Ctrl+C (measured, tests A-D, 2026-09-27).\n"
        "#   FT-294: ITEM 17 SAID GOOD WHILE A WAKE WITHIN 15 MINUTES NEEDS NO\n"
        "#           PASSWORD (Modern Standby, DelayLockInterval). Now DELAYED -- never\n"
        "#           GOOD -- and applying item 17 sets the delay to 0 and re-reads.\n"
        "#   FT-297: ITEM 8 ON AN ALREADY-ENCRYPTED DRIVE added a recovery key and\n"
        "#           said encryption had started. Now \"encrypted, protection off\" is\n"
        "#           its own state and gets screen 96 -- no command, no new key.\n",
        count=1, why="change log: FT-294, FT-297")

    # ---------- FT-294: the reader ----------
    e.replace(
        "        if ($ggVal -eq 1 -and ($null -eq $ggDC -or $ggDC -eq 1)) {\n"
        "            return @{ State = \"REQUIRED\";     Value = $ggVal; DC = $ggDC; Raw = $ggRaw }\n"
        "        }\n",
        "        if ($ggVal -eq 1 -and ($null -eq $ggDC -or $ggDC -eq 1)) {\n"
        "            # FT-294 (ascii45): on Modern Standby PCs Settings' \"If you've been\n"
        "            # away\" choice is DelayLockInterval (seconds; 0 = every time,\n"
        "            # 0xFFFFFFFF = never -- sourced, Winaero/ElevenForum; CGDELL read 900 =\n"
        "            # Bill's \"15 minutes\", measured 2026-09-27). Any delay is not GOOD.\n"
        "            $ggDelay = $null\n"
        "            try { $ggDelay = (Get-ItemProperty \"HKCU:\\Control Panel\\Desktop\" -EA Stop).DelayLockInterval } catch {}\n"
        "            if ($null -ne $ggDelay -and [uint32]$ggDelay -eq [uint32]4294967295) {\n"
        "                return @{ State = \"NOT_REQUIRED\"; Value = $ggVal; DC = $ggDC; Delay = $ggDelay; Raw = $ggRaw }\n"
        "            }\n"
        "            if ($null -ne $ggDelay -and [uint32]$ggDelay -gt 0) {\n"
        "                return @{ State = \"DELAYED\"; Value = $ggVal; DC = $ggDC; Delay = [uint32]$ggDelay; Minutes = [math]::Round([uint32]$ggDelay / 60); Raw = $ggRaw }\n"
        "            }\n"
        "            return @{ State = \"REQUIRED\";     Value = $ggVal; DC = $ggDC; Delay = $ggDelay; Raw = $ggRaw }\n"
        "        }\n",
        count=1, why="FT-294: DELAYED state")

    # ---------- FT-294: screen 19 read ----------
    e.replace(
        "        \"NOT_REQUIRED\" { $results[\"PasswordOnWake\"] = \"NOT required -- change recommended\" }\n",
        "        \"NOT_REQUIRED\" { $results[\"PasswordOnWake\"] = \"NOT required -- change recommended\" }\n"
        "        \"DELAYED\"      { $results[\"PasswordOnWake\"] = (\"Only after \" + $ggCL.Minutes + \" min away -- change recommended\") }   # FT-294\n",
        count=1, why="FT-294: screen 19 read")

    # ---------- FT-294: the two applies set the delay to 0 ----------
    set0_19 = ("            # FT-294 (ascii45): also ask for a password on EVERY wake (Modern Standby).\n"
               "            try { if ($null -ne (Get-ItemProperty \"HKCU:\\Control Panel\\Desktop\" -EA Stop).DelayLockInterval) { Set-ItemProperty -Path \"HKCU:\\Control Panel\\Desktop\" -Name DelayLockInterval -Value 0 -Type DWord -Force -EA Stop } } catch {}\n")
    e.replace(
        "            $ggWas = [string]$Results[\"PasswordOnWake\"]\n"
        "            powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null\n"
        "            powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null\n",
        "            $ggWas = [string]$Results[\"PasswordOnWake\"]\n"
        "            powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null\n"
        "            powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null\n" + set0_19,
        count=1, why="FT-294: screen 19 apply sets delay 0")
    set0_17 = ("                # FT-294 (ascii45): also ask for a password on EVERY wake (Modern Standby).\n"
               "                try { if ($null -ne (Get-ItemProperty \"HKCU:\\Control Panel\\Desktop\" -EA Stop).DelayLockInterval) { Set-ItemProperty -Path \"HKCU:\\Control Panel\\Desktop\" -Name DelayLockInterval -Value 0 -Type DWord -Force -EA Stop } } catch {}\n")
    e.replace(
        "            try {\n"
        "                powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null\n"
        "                powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null\n",
        "            try {\n"
        "                powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null\n"
        "                powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 1 | Out-Null\n" + set0_17,
        count=1, why="FT-294: item 17 apply sets delay 0")

    # ---------- FT-294: re-read after the screen 19 apply ----------
    e.replace(
        "                \"NOT_REQUIRED\" { $ggNow = \"still NOT required\" }\n",
        "                \"NOT_REQUIRED\" { $ggNow = \"still NOT required\" }\n"
        "                \"DELAYED\"      { $ggNow = (\"still only after \" + $ggRe.Minutes + \" min away\") }   # FT-294\n",
        count=1, why="FT-294: screen 19 re-read")

    # ---------- FT-294: checklist status ----------
    e.replace(
        "                    \"NOT_REQUIRED\" { \"Not required -- needs attention\" }\n"
        "                    default        { \"Unknown -- could not read; check by hand\" }\n"
        "                }\n"
        "                if (@(\"REQUIRED\",\"NOT_REQUIRED\") -notcontains $ggCL17.State) {\n",
        "                    \"NOT_REQUIRED\" { \"Not required -- needs attention\" }\n"
        "                    \"DELAYED\"      { \"Only after \" + $ggCL17.Minutes + \" min away -- needs attention\" }   # FT-294\n"
        "                    default        { \"Unknown -- could not read; check by hand\" }\n"
        "                }\n"
        "                if (@(\"REQUIRED\",\"NOT_REQUIRED\",\"DELAYED\") -notcontains $ggCL17.State) {\n",
        count=1, why="FT-294: checklist status")

    # ---------- FT-294: checklist apply re-read ----------
    e.replace(
        "                } elseif ($ggRe17.State -eq \"NOT_REQUIRED\") {\n",
        "                } elseif ($ggRe17.State -eq \"DELAYED\") {\n"
        "                    $result = \"ERROR: Windows still asks for a password only after \" + $ggRe17.Minutes + \" minutes away. Change it by hand: Settings -> Accounts -> Sign-in options -> 'If you've been away, when should Windows require you to sign in again?' -> Every Time.\"\n"
        "                } elseif ($ggRe17.State -eq \"NOT_REQUIRED\") {\n",
        count=1, why="FT-294: checklist apply re-read")

    # ---------- FT-297: item 8 status ----------
    e.replace(
        "$s.Status = if ($bl.ProtectionStatus -eq \"On\") { \"ENCRYPTED -- GOOD\" } else { \"NOT Encrypted -- action available\" } }\n",
        "$s.Status = if ($bl.ProtectionStatus -eq \"On\") { \"ENCRYPTED -- GOOD\" } elseif ([string]$bl.VolumeStatus -ne \"FullyDecrypted\") { \"Encrypted, protection OFF -- needs attention\" } else { \"NOT Encrypted -- action available\" } }   # FT-297\n",
        count=1, why="FT-297: item 8 status")

    # ---------- FT-297: the encryption screen stops first ----------
    e.replace("function Show-BitLockerScreen {", SCREEN96, count=1, why="FT-297: screen 96 function")
    e.replace(
        "            Write-Log -Message \"BitLocker already enabled -- no change needed\" -Status \"GOOD\"\n"
        "            Pause-ForUser\n"
        "            return\n"
        "        }\n"
        "    } catch {}\n",
        "            Write-Log -Message \"BitLocker already enabled -- no change needed\" -Status \"GOOD\"\n"
        "            Pause-ForUser\n"
        "            return\n"
        "        }\n"
        "        # FT-297 (ascii45): encrypted (or encrypting) but protection off --\n"
        "        # never run Enable-BitLocker on it. Covers Home and Pro alike.\n"
        "        if ([string]$vol.VolumeStatus -ne \"FullyDecrypted\") {\n"
        "            Show-GGEncryptedNotProtected -Volume $vol\n"
        "            return\n"
        "        }\n"
        "    } catch {}\n",
        count=1, why="FT-297: stop before any encryption command")

    # ---------- screen table ----------
    e.replace(
        "    \"95\" = \"16a\"          # Full scan of every drive (E6) -- interim label\n",
        "    \"95\" = \"16a\"          # Full scan of every drive (E6) -- interim label\n"
        "    \"96\" = \"27f\"          # Drive already encrypted, protection off (FT-297) -- interim\n",
        count=1, why="table: 96")
