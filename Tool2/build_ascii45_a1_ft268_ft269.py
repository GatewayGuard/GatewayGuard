"""build_ascii45_a1_ft268_ft269 -- password on wake: read it with /qh, and
never print success without a confirmed re-read.

Dated: 2026-09-26 11:20 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block A, items A1 and A2.

FT-268: Get-GGConsoleLockState ran `powercfg /query`, which omits HIDDEN power
settings. CONSOLELOCK is hidden, so the read was NO_INDEX on every machine,
always. `powercfg /qh` includes hidden settings.
VERIFIED 2026-09-24 and 2026-09-25 measured on CGDELL (elevated):
  /query SCHEME_CURRENT SUB_NONE CONSOLELOCK -> scheme header only
  /qh    SCHEME_CURRENT SUB_NONE CONSOLELOCK -> "Current AC Power Setting
         Index: 0x00000001" and the DC line
  Test_Results\\SandyForAscii45-CGDELL-2026-09-25_16-36.txt, section 5.

FT-269: two apply paths printed success with nothing confirmed --
  Apply-PowerSettings printed a green "OK Password on wake" and logged APPLIED
  whatever the re-read said; Apply-Setting case 17 returned "... -- GOOD"
  with no re-read at all. Both now re-read through the one shared reader and
  say GOOD/OK only when it returns REQUIRED. An unconfirmed result starts with
  "NOTE:", which the run loop colours yellow (line ~9284), and avoids every
  word that colours green ("GOOD|enabled|disabled|set to|Already").

Run from Tool2/:  python build_ascii45_a1_ft268_ft269.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    # --- change log -------------------------------------------------------
    e.replace(
        "#   (entries are added here, one family per commit)\n",
        "#   (entries are added here, one family per commit)\n"
        "#   FT-268: PASSWORD ON WAKE WAS NEVER READABLE ON ANY MACHINE. The\n"
        "#           read used `powercfg /query`, which leaves out hidden\n"
        "#           settings, and CONSOLELOCK is hidden. Now `/qh`. Measured on\n"
        "#           CGDELL 2026-09-24/25: /query returns the header only, /qh\n"
        "#           returns AC and DC index 0x1.\n"
        "#   FT-269: NO SUCCESS WITHOUT A CONFIRMED RE-READ. Screen 19's apply\n"
        "#           printed green OK / logged APPLIED whatever the re-read said;\n"
        "#           item 17 returned GOOD with no re-read at all. Both now re-read\n"
        "#           through Get-GGConsoleLockState and say GOOD only on REQUIRED.\n",
        count=1,
        why="change log: FT-268, FT-269",
    )

    # --- A1 / FT-268: the reader -------------------------------------------
    e.replace(
        "    # VERIFIED 2026-09-08 measured on CGDELL, elevated: powercfg /query\n"
        "    # SCHEME_CURRENT SUB_NONE CONSOLELOCK returned the scheme header and NO\n"
        "    # \"Current AC Power Setting Index:\" line at all.\n"
        "    # Test_Results\\SettingsStatus-CGDELL-2026-09-08_21-29.txt\n",
        "    # FT-268 (ascii45): the root cause of that NO_INDEX was the switch, not\n"
        "    # the machine. `/query` leaves out HIDDEN power settings, and\n"
        "    # CONSOLELOCK is hidden, so every machine answered NO_INDEX.\n"
        "    # VERIFIED 2026-09-25 measured on CGDELL, elevated: powercfg /qh\n"
        "    # SCHEME_CURRENT SUB_NONE CONSOLELOCK returns \"Current AC Power Setting\n"
        "    # Index: 0x00000001\" and the DC line; /query returns the header only.\n"
        "    # Test_Results\\SandyForAscii45-CGDELL-2026-09-25_16-36.txt, section 5.\n",
        count=1,
        why="FT-268: VERIFIED comment for the /qh read (gate 24)",
    )
    e.replace(
        "        $ggQ   = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>&1\n",
        "        $ggQ   = powercfg /qh SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>&1\n",
        count=1,
        why="FT-268: /query -> /qh in Get-GGConsoleLockState",
    )

    # --- A2 / FT-269, site 1: Apply-PowerSettings (screen 19) ---------------
    e.replace(
        "            $ggNow = \"could not re-read -- check manually\"\n"
        "            try {\n"
        "                $ggQ = powercfg /query SCHEME_CURRENT SUB_NONE CONSOLELOCK 2>&1\n"
        "                # FT-255 (ascii44): powercfg returns an ARRAY. On an array -match is a\n"
        "        # FILTER and does NOT populate $Matches -- measured on CGDELL\n"
        "        # 2026-09-06. Out-String makes it a scalar match, which is the\n"
        "        # pattern already used at the screen-timeout and battery reads.\n"
        "                if (($ggQ | Out-String) -match \"Current AC Power Setting Index: 0x(\\w+)\") {\n"
        "                    $ggNow = if ([Convert]::ToUInt32($Matches[1], 16) -eq 1) { \"REQUIRED\" } else { \"still NOT required\" }\n"
        "                } else {\n"
        "                    # FT-246/FT-256 (ascii44): the parse found nothing. Log the RAW\n"
        "                    # output so the next field run says WHY, instead of only\n"
        "                    # \"could not re-read\". Measured on CGDELL 2026-09-06: this\n"
        "                    # query can return the scheme header and no setting block at\n"
        "                    # all, which is FT-256 and is not fixed by any parse change.\n"
        "                    $ggRaw = ((($ggQ | Out-String) -replace \"\\s+\", \" \").Trim())\n"
        "                    if ($ggRaw.Length -gt 300) { $ggRaw = $ggRaw.Substring(0, 300) + \"...\" }\n"
        "                    Write-Log -Message \"Password on wake re-read found no setting index (FT-256). Raw powercfg output: $ggRaw\" -Status \"WARN\"\n"
        "                }\n"
        "            } catch {\n"
        "                Write-Log -Message \"Password on wake re-read threw: $_\" -Status \"WARN\"\n"
        "            }\n"
        "            Write-Host \"  OK  Password on wake\" -ForegroundColor Green\n"
        "            Write-Host \"      Was:  $ggWas\" -ForegroundColor Gray\n"
        "            Write-Host \"      Now:  $ggNow\" -ForegroundColor Cyan\n"
        "            Write-Log -Message \"Password on wake: was '$ggWas' -> now '$ggNow'\" -Status \"APPLIED\"\n",
        "            # FT-269 (ascii45): re-read through the one shared reader (FT-268's\n"
        "            # /qh), and print OK / log APPLIED only when it confirms REQUIRED.\n"
        "            # Before this, the green OK printed whatever the re-read said.\n"
        "            $ggRe = Get-GGConsoleLockState\n"
        "            switch ($ggRe.State) {\n"
        "                \"REQUIRED\"     { $ggNow = \"REQUIRED\" }\n"
        "                \"NOT_REQUIRED\" { $ggNow = \"still NOT required\" }\n"
        "                default        { $ggNow = \"could not confirm -- check by hand\" }\n"
        "            }\n"
        "            if ($ggRe.State -eq \"REQUIRED\") {\n"
        "                Write-Host \"  OK  Password on wake\" -ForegroundColor Green\n"
        "                Write-Host \"      Was:  $ggWas\" -ForegroundColor Gray\n"
        "                Write-Host \"      Now:  $ggNow\" -ForegroundColor Cyan\n"
        "                Write-Log -Message \"Password on wake: was '$ggWas' -> now '$ggNow' (re-read confirmed)\" -Status \"APPLIED\"\n"
        "            } else {\n"
        "                Write-Host \"  WARN Password on wake\" -ForegroundColor Yellow\n"
        "                Write-Host \"      Was:  $ggWas\" -ForegroundColor Gray\n"
        "                Write-Host \"      Now:  $ggNow\" -ForegroundColor Yellow\n"
        "                Write-Log -Message \"Password on wake: was '$ggWas' -> now '$ggNow' -- NOT confirmed ($($ggRe.State)). Raw powercfg output: $($ggRe.Raw)\" -Status \"WARN\"\n"
        "            }\n",
        count=1,
        why="FT-269: Apply-PowerSettings re-reads via Get-GGConsoleLockState; OK only on REQUIRED",
    )

    # --- A2 / FT-269, site 2: Apply-Setting case 17 --------------------------
    e.replace(
        "                powercfg /S SCHEME_CURRENT | Out-Null\n"
        "                $result = \"Password required on wake -- enabled for both AC and battery -- GOOD\"\n",
        "                powercfg /S SCHEME_CURRENT | Out-Null\n"
        "                # FT-269 (ascii45): this returned GOOD with no re-read at all.\n"
        "                # Re-read through the shared reader; GOOD only on REQUIRED. The\n"
        "                # other two answers start NOTE:/ERROR: and avoid every word the\n"
        "                # run loop colours green (GOOD|enabled|disabled|set to|Already).\n"
        "                $ggRe17 = Get-GGConsoleLockState\n"
        "                if ($ggRe17.State -eq \"REQUIRED\") {\n"
        "                    $result = \"Password required on wake -- enabled for both AC and battery -- confirmed -- GOOD\"\n"
        "                } elseif ($ggRe17.State -eq \"NOT_REQUIRED\") {\n"
        "                    $result = \"ERROR: Windows did not keep the change -- a password is still not required on wake. Check by hand: Settings -> Accounts -> Sign-in options -> 'If you've been away, when should Windows require you to sign in again?' -> When PC wakes up from sleep.\"\n"
        "                } else {\n"
        "                    $result = \"NOTE: Checkup asked Windows to require a password on wake, but could not read it back to confirm. Check by hand: Settings -> Accounts -> Sign-in options -> 'If you've been away, when should Windows require you to sign in again?' -> When PC wakes up from sleep.\"\n"
        "                }\n"
        "                try { Write-Log -Message \"Item 17 re-read after apply: $($ggRe17.State). Raw powercfg output: $($ggRe17.Raw)\" -Status \"INFO\" } catch {}\n",
        count=1,
        why="FT-269: Apply-Setting case 17 re-reads; GOOD only on REQUIRED",
    )
print("A1/A2 applied")
