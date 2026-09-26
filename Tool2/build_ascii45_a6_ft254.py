"""build_ascii45_a6_ft254 -- the time-sync fix stops printing success after
four calls that could never fail, and drops an undocumented flag.

Dated: 2026-09-26 12:31 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block A, item A6.

FT-254 (raised in ascii44, carried): Test-TimeDateSync ran Set-Service,
Start-Service and Set-ItemProperty with -EA SilentlyContinue and
`w32tm /resync /force | Out-Null`, then printed "Time sync settings
corrected." in green unconditionally. None of the four could fail visibly.

ALSO FOUND, FT-162 CLASS (measured 2026-09-26 on CGDELL):
  `w32tm /?` documents /resync [/computer] [/nowait] [/rediscover] [/soft].
  THERE IS NO /force. With W32Time running, w32tm silently ignores it
  (exit 0 with or without it). With W32Time stopped (it is trigger-start and
  stops itself), `w32tm /resync` exits -2147023834 (0x80070426, "The service
  has not been started") -- the failure the old | Out-Null hid.

FIX: each step has its own -EA Stop / exit-code check; the documented
`w32tm /resync`; then a RE-READ of both settings. Green "corrected" only when
the re-read confirms both; otherwise yellow, naming what did not take and the
Settings path to do it by hand.

Run from Tool2/:  python build_ascii45_a6_ft254.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "#           result is no longer red; long text wraps (Write-GGWrapped).\n",
        "#           result is no longer red; long text wraps (Write-GGWrapped).\n"
        "#   FT-254: TIME SYNC PRINTED \"CORRECTED\" AFTER FOUR CALLS THAT COULD NOT\n"
        "#           FAIL (-EA SilentlyContinue, | Out-Null). Each step now checked,\n"
        "#           then both settings re-read; green only when confirmed. Also\n"
        "#           dropped `w32tm /resync /force`: w32tm /? has no /force\n"
        "#           (measured CGDELL 2026-09-26; ignored when running, and the\n"
        "#           real failure -- service stopped, 0x80070426 -- was hidden).\n",
        count=1,
        why="change log: FT-254",
    )
    e.replace(
        "            try {\n"
        "                Set-Service -Name \"W32Time\" -StartupType Automatic -EA SilentlyContinue\n"
        "                Start-Service -Name \"W32Time\" -EA SilentlyContinue\n"
        "                w32tm /resync /force | Out-Null\n"
        "                Set-ItemProperty -Path \"HKLM:\\SYSTEM\\CurrentControlSet\\Services\\tzautoupdate\" -Name \"Start\" -Value 3 -EA SilentlyContinue\n"
        "                Write-Host \"  Time sync settings corrected.\" -ForegroundColor Green\n"
        "                Write-Log -Message \"Time/timezone auto-sync corrected\" -Status \"FIXED\"\n"
        "            } catch {\n"
        "                Write-Host \"  Could not correct automatically -- see Settings > Time & Language.\" -ForegroundColor Yellow\n"
        "                Write-Log -Message \"Time/timezone auto-fix failed: $_\" -Status \"WARN\"\n"
        "            }\n",
        "            # FT-254 (ascii45): every step can now fail visibly, and success is\n"
        "            # printed only after a re-read confirms it.\n"
        "            $ggTSFail = @()\n"
        "            try { Set-Service -Name \"W32Time\" -StartupType Automatic -EA Stop } catch { $ggTSFail += \"time service start-up type: $($_.Exception.Message)\" }\n"
        "            try { Start-Service -Name \"W32Time\" -EA Stop } catch { $ggTSFail += \"time service start: $($_.Exception.Message)\" }\n"
        "            try {\n"
        "                # VERIFIED 2026-09-26 measured on CGDELL: `w32tm /?` documents\n"
        "                # /resync [/computer] [/nowait] [/rediscover] [/soft] -- no /force.\n"
        "                # Exit 0 = resync accepted (\"The command completed successfully.\");\n"
        "                # -2147023834 (0x80070426) = W32Time not started.\n"
        "                $ggRs = (w32tm /resync 2>&1 | Out-String)\n"
        "                if ($LASTEXITCODE -ne 0) { $ggTSFail += \"clock resync (exit $LASTEXITCODE): $(($ggRs -replace '\\s+', ' ').Trim())\" }\n"
        "            } catch { $ggTSFail += \"clock resync: $($_.Exception.Message)\" }\n"
        "            try { Set-ItemProperty -Path \"HKLM:\\SYSTEM\\CurrentControlSet\\Services\\tzautoupdate\" -Name \"Start\" -Value 3 -EA Stop } catch { $ggTSFail += \"automatic time zone: $($_.Exception.Message)\" }\n"
        "            # Re-read the two settings the check above judged by.\n"
        "            $ggTzNow  = (Get-ItemProperty -Path \"HKLM:\\SYSTEM\\CurrentControlSet\\Services\\tzautoupdate\" -Name \"Start\" -EA SilentlyContinue).Start\n"
        "            $ggW32Now = Get-Service -Name \"W32Time\" -EA SilentlyContinue\n"
        "            $ggTSOK   = ($ggW32Now -and $ggW32Now.StartType -ne \"Disabled\" -and $ggTzNow -ne 4)\n"
        "            if ($ggTSOK -and $ggTSFail.Count -eq 0) {\n"
        "                Write-Host \"  Time sync settings corrected -- checked again and confirmed.\" -ForegroundColor Green\n"
        "                Write-Log -Message \"Time/timezone auto-sync corrected and re-read confirmed\" -Status \"FIXED\"\n"
        "            } elseif ($ggTSOK) {\n"
        "                Write-Host \"  Automatic time is now turned on, but the clock could not be\" -ForegroundColor Yellow\n"
        "                Write-Host \"  re-checked right now. Windows will do it on its own later.\" -ForegroundColor Yellow\n"
        "                Write-Log -Message \"Time/timezone settings confirmed on; not every step succeeded: $($ggTSFail -join ' | ')\" -Status \"WARN\"\n"
        "            } else {\n"
        "                Write-Host \"  Checkup could not turn automatic time back on. Please do it\" -ForegroundColor Yellow\n"
        "                Write-Host \"  yourself: Settings > Time & Language > Date & time > turn on\" -ForegroundColor Yellow\n"
        "                Write-Host \"  'Set time automatically' and 'Set time zone automatically'.\" -ForegroundColor Yellow\n"
        "                Write-Log -Message \"Time/timezone auto-fix NOT confirmed on re-read (W32Time=$($ggW32Now.StartType), tzautoupdate=$ggTzNow): $($ggTSFail -join ' | ')\" -Status \"WARN\"\n"
        "            }\n",
        count=1,
        why="FT-254: guarded steps, documented w32tm, re-read before claiming success",
    )
print("A6 applied")
