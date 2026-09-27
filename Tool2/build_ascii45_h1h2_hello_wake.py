"""build_ascii45_h1h2_hello_wake -- FT-286 (item 9, Windows Hello) and
FT-287 (item 17, password on wake while on battery).

Dated: 2026-09-27 08:00 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block H, items H1 and H2.

FT-286. Item 9 tested `$env:LOCALAPPDATA\\Microsoft\\NGC`. MEASURED on CGDELL
2026-09-26: that folder does not exist, yet Bill signs in with a PIN every
day, so Checkup said "Not set up" to a PIN user. Settings ("not available")
and dsregcmd (NgcSet NO) are wrong on the same PC, so neither can be the read.
NEW READ: HKLM\\...\\Authentication\\LogonUI LastLoggedOnProvider. Flip-tested
by Bill 2026-09-26: PIN sign-in 14:49:33 -> Hello provider; password sign-in
14:53:51 -> password provider; Win+L then PIN unlock 15:04:21 -> Hello
provider. GOOD only when it is the Hello provider AND LastLoggedOnUserSID is
the account Checkup runs as. Anything else is never GOOD: the person is asked.

FT-287. Get-GGConsoleLockState read only the AC (plugged-in) value. A laptop
on battery uses the DC value. REQUIRED now needs AC = 1 and, when Windows
reports a DC line, DC = 1. Both apply sites already set both.

Run from Tool2/:  python build_ascii45_h1h2_hello_wake.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

HELLO_FN = r'''function Get-GGHelloSignIn {
    # FT-286 (ascii45). Item 9 used to test "$env:LOCALAPPDATA\Microsoft\NGC".
    # Measured on CGDELL 2026-09-26: that folder does not exist while the user
    # signs in with a PIN every day. Settings said Hello was "not available"
    # and dsregcmd said NgcSet NO on the same PC -- neither can be the read.
    #
    # This reads HOW THIS ACCOUNT LAST SIGNED IN OR UNLOCKED.
    # VERIFIED 2026-09-26 measured on CGDELL (flip test by Bill):
    #   PIN sign-in 14:49:33      -> LastLoggedOnProvider {D6886603-...} (Hello)
    #   password sign-in 14:53:51 -> {60B78E88-EAD8-445C-9CFD-0B87F74EA6CD}
    #   Win+L, PIN unlock 15:04:21 -> {D6886603-...} again
    # Registry read only; no external command.
    #
    # Returns HELLO only when the Hello provider was used AND the record is
    # this account's. Everything else is NOT_CONFIRMED -- never a GOOD.
    # Known limits: a user who has a PIN but last used a password is asked
    # (safe); a PIN removed since the last sign-in or unlock still reads HELLO
    # until the next one.
    $ggHelloProvider = "{D6886603-9D2F-4EB2-B667-1971041FA96B}"
    try {
        $ggLU  = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" -EA Stop
        $ggMe  = [Security.Principal.WindowsIdentity]::GetCurrent().User.Value
        $ggPrv = "$($ggLU.LastLoggedOnProvider)"
        $ggSid = "$($ggLU.LastLoggedOnUserSID)"
        if ($ggSid -ne $ggMe) {
            return @{ State = "NOT_CONFIRMED"; Why = "last sign-in was another account ($ggSid)" }
        }
        if ($ggPrv -eq $ggHelloProvider) {
            return @{ State = "HELLO"; Why = "last sign-in used Windows Hello" }
        }
        return @{ State = "NOT_CONFIRMED"; Why = "last sign-in used provider $ggPrv" }
    } catch {
        return @{ State = "NOT_CONFIRMED"; Why = "could not read the sign-in record: $_" }
    }
}

function Get-GGOtherAV {'''

ASK = ("MANUAL CHECK -- Checkup cannot confirm this one. Do you sign in to Windows "
       "with a short PIN, your face or your fingerprint? If yes, you are set. If you "
       "type your full password, set up a PIN: Settings -> Accounts -> Sign-in options "
       "-> PIN (Windows Hello). See Guide: Phase 1, Step 4")

with PS1Edit(TARGET) as e:
    e.replace(
        "#           now say FT-268 superseded them. Comments only.\n",
        "#           now say FT-268 superseded them. Comments only.\n"
        "#   FT-286: ITEM 9 (WINDOWS HELLO) SAID \"NOT SET UP\" TO A PIN USER. It tested\n"
        "#           a folder that does not exist on CGDELL. Now reads how this account\n"
        "#           last signed in or unlocked (Get-GGHelloSignIn), flip-tested by Bill\n"
        "#           2026-09-26. GOOD only on a Hello sign-in by this account;\n"
        "#           otherwise the person is asked. Never a guessed GOOD.\n"
        "#   FT-287: PASSWORD ON WAKE ON BATTERY. REQUIRED now needs the DC\n"
        "#           (battery) value as well as AC, when Windows reports one.\n",
        count=1, why="change log: FT-286, FT-287")

    e.replace("function Get-GGOtherAV {", HELLO_FN, count=1,
              why="FT-286: add Get-GGHelloSignIn")

    # status read
    e.replace(
        "                $ngc = Test-Path \"$env:LOCALAPPDATA\\Microsoft\\NGC\"\n"
        "                $s.Status = if ($ngc) { \"Configured -- GOOD\" } else { \"Not set up -- manual action needed\" }\n",
        "                # FT-286 (ascii45): was Test-Path on a folder that does not exist.\n"
        "                $ggH9 = Get-GGHelloSignIn\n"
        "                $s.Status = if ($ggH9.State -eq \"HELLO\") { \"You sign in with Windows Hello -- GOOD\" } else { \"Not confirmed -- Checkup will ask you\" }\n"
        "                try { Write-Log -Message \"Item 9 (Windows Hello): $($ggH9.State) -- $($ggH9.Why)\" -Status \"INFO\" } catch {}\n",
        count=1, why="FT-286: item 9 status read")

    # apply case
    e.replace(
        "            $ngc = Test-Path \"$env:LOCALAPPDATA\\Microsoft\\NGC\"\n"
        "            if ($ngc) {\n"
        "                $result = \"Windows Hello is already configured -- GOOD, no action needed\"\n"
        "            } else {\n"
        "                $result = \"NOT CONFIGURED -- Manual setup: Settings -> Accounts -> Sign-in options -> set up PIN or fingerprint/face. A PIN is the minimum. See Guide: Phase 1, Step 4\"\n"
        "            }\n",
        "            # FT-286 (ascii45): Windows gives no reliable \"PIN is set up\" read, so\n"
        "            # when the sign-in record cannot confirm it, ASK the person.\n"
        "            if ((Get-GGHelloSignIn).State -eq \"HELLO\") {\n"
        "                $result = \"You sign in with Windows Hello -- GOOD, no action needed\"\n"
        "            } else {\n"
        "                $result = \"" + ASK + "\"\n"
        "            }\n",
        count=1, why="FT-286: item 9 apply text")

    e.replace(
        "    # own switch case (Malwarebytes/trial-aware for 3, an NGC check for 9),\n",
        "    # own switch case (Malwarebytes/trial-aware for 3, a sign-in check for 9),\n",
        count=1, why="comment: item 9 no longer an NGC check")

    # FT-287: AC and DC
    e.replace(
        "    if ($ggOut -match \"Current AC Power Setting Index:\\s*0x(\\w+)\") {\n"
        "        $ggVal = [Convert]::ToUInt32($Matches[1], 16)\n"
        "        if ($ggVal -eq 1) { return @{ State = \"REQUIRED\";     Value = $ggVal; Raw = $ggRaw } }\n"
        "        return @{ State = \"NOT_REQUIRED\"; Value = $ggVal; Raw = $ggRaw }\n"
        "    }\n",
        "    # FT-287 (ascii45): read AC (plugged in) AND DC (battery). Measured on\n"
        "    # CGDELL 2026-09-25: /qh prints both lines. A laptop on battery uses DC,\n"
        "    # so REQUIRED needs both. If Windows prints no DC line, AC decides.\n"
        "    if ($ggOut -match \"Current AC Power Setting Index:\\s*0x(\\w+)\") {\n"
        "        $ggVal = [Convert]::ToUInt32($Matches[1], 16)\n"
        "        $ggDC  = $null\n"
        "        if ($ggOut -match \"Current DC Power Setting Index:\\s*0x(\\w+)\") {\n"
        "            $ggDC = [Convert]::ToUInt32($Matches[1], 16)\n"
        "        }\n"
        "        if ($ggVal -eq 1 -and ($null -eq $ggDC -or $ggDC -eq 1)) {\n"
        "            return @{ State = \"REQUIRED\";     Value = $ggVal; DC = $ggDC; Raw = $ggRaw }\n"
        "        }\n"
        "        return @{ State = \"NOT_REQUIRED\"; Value = $ggVal; DC = $ggDC; Raw = $ggRaw }\n"
        "    }\n",
        count=1, why="FT-287: AC and DC")
