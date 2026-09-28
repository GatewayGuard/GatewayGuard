"""build_ascii45_F2batch_power -- Block F, batch 2: screen 19 report-only (F3),
sleep-prevention wording (F13), the screen-timeout line (F15), Wake on LAN log
noise and logging (F14/F7), items 13 and 14 "Unknown" wording (F17).

Dated: 2026-09-28 08:14 ET
Editor: Claude Code (CGDELL)
Bill, 2026-09-28: "build block F and the renumber pass".

F3 / Decision 12: screen 19 keeps its full review but no longer asks about 1-3
(password on wake, Fast Startup, Wake on LAN) -- the checklist (items 17, 18,
19) is the one place they change. Critical battery keeps its question (it is
not a checklist item).
F13 / FT-291: MEASURED, code -- Enable-SleepPrevention only calls
SetThreadExecutionState; no setting changes. The wording that said "SET BY
THIS TOOL ... your original sleep setting will be restored" is replaced.
F15 / FT-293: the screen-timeout advisory no longer prints after the answers;
it stays in the review box, marked "Checkup never changes this".
F14 / FT-292: MEASURED 2026-09-27 19:53 -- 4 "[ERROR] SILENT ERROR" lines from
Get-NetAdapterAdvancedProperty -DisplayName <name the adapter lacks>. Now each
adapter's properties are read once and filtered. (FT-292's claim that the
checklist would keep saying Enabled was WRONG -- measured 2026-09-28 08:1x:
item 19 reads "DISABLED -- GOOD".)
F7 / FT-281: every adapter's wake properties are now logged at both reads.
F17 / FT-295: items 13 and 14 say what "Unknown" means for the user.

Run from Tool2/:  python build_ascii45_F2batch_power.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"


def region(e, start, stop, pairs, why):
    t = e.text
    s = t.index(start)
    end = t.index(stop, s)
    old = t[s:end]
    new = old
    for o, n, c in pairs:
        assert new.count(o) == c, (why, o, new.count(o))
        new = new.replace(o, n)
    e.replace(old, new, count=1, why=why)


with PS1Edit(TARGET) as e:
    e.replace(
        "#           (display only). F11: screen 7 lists the new order.\n",
        "#           (display only). F11: screen 7 lists the new order.\n"
        "#   F3/F15: SCREEN 19 IS A REPORT -- items 17-19 change on the checklist\n"
        "#           only; the screen-timeout line stays in the box as advice.\n"
        "#   F13 (FT-291): the stay-awake wording no longer claims a setting changed.\n"
        "#   F14/F7: Wake on LAN apply reads each adapter once (no error noise);\n"
        "#           every adapter's wake settings are logged. F17: 13/14 wording.\n",
        count=1, why="change log: batch 2")

    # ---------- F13: Test-PowerStatus ----------
    e.replace(
        "            \"  Sleep prevention is now ACTIVE for this session.         \"\n",
        "            \"  Checkup keeps your PC awake while it runs (F13).         \"\n",
        count=1, why="F13: battery box line")
    e.replace(
        "        Write-Host \"  OK  Sleep prevention: SET BY THIS TOOL for this session.\" -ForegroundColor Green\n"
        "        Write-Host \"      Your original sleep setting will be restored automatically when Checkup exits.\" -ForegroundColor White\n",
        "        # F13 / FT-291 (ascii45): Enable-SleepPrevention changes NO setting --\n"
        "        # it only asks Windows not to sleep while Checkup runs.\n"
        "        Write-Host \"  OK  Checkup keeps your PC awake while it runs.\" -ForegroundColor Green\n"
        "        Write-Host \"      Your sleep settings are not changed. When Checkup closes, your\" -ForegroundColor White\n"
        "        Write-Host \"      PC goes to sleep as it normally does.\" -ForegroundColor White\n",
        count=1, why="F13: power page lines")

    # ---------- F3 / F13 / F15: the review box ----------
    e.replace(
        "        \"  Review each one below -- changes are optional.             \",\n",
        "        \"  Checkup changes 1-3 only on the security checklist        \",\n"
        "        \"  (items 17, 18 and 19), and only the ones you select.      \",\n",
        count=1, why="F3: box intro")
    e.replace(
        "        \"      System -> Power & sleep. (Advisory only -- not changed.)\",\n"
        "        \"      NOTE: this is DIFFERENT from the temporary stay-awake    \",\n"
        "        \"      protection Checkup turned on for this session --         \",\n"
        "        \"      that one is automatic and undoes itself when the tool    \",\n"
        "        \"      exits. Screen timeout is yours to set once, by hand.     \",\n",
        "        \"      System -> Power & sleep. Checkup never changes this --   \",\n"
        "        \"      it is yours to set once, by hand.                        \",\n",
        count=1, why="F15: screen timeout advice")
    e.replace(
        "        \"  Sleep prevention (this session): SET BY THIS TOOL          \",\n"
        "        \"  -- not your previous setting. Your own sleep setting is    \",\n"
        "        \"  put back when the tool exits.                              \",\n"
        "        \"  Normal sleep resumes after you exit or the tool finishes.   \"\n",
        "        \"  While Checkup runs it keeps your PC awake. It does not    \",\n"
        "        \"  change your sleep settings -- when Checkup closes, your   \",\n"
        "        \"  PC goes to sleep as it normally does.                     \"\n",
        count=1, why="F13: box sleep lines")

    # ---------- F3 / F15: no questions for 1-3; no timeout line after answers ----------
    t = e.text
    s = t.index("    Write-Host \"  Review each setting below and choose Y/N individually.\" -ForegroundColor Yellow\n")
    end = t.index("    if ($results[\"CriticalBattery\"] -notmatch \"GOOD|N/A|HIBERNATE|SHUTDOWN\") {\n", s)
    old = t[s:end]
    for must in ('$powerChoices["PasswordOnWake"] = (Read-ValidKey', '$powerChoices["FastStartup"] = (Read-ValidKey',
                 '$powerChoices["WakeOnLAN"] = (Read-ValidKey', 'Write-Host "  [4] Screen timeout:'):
        assert must in old, must
    new = ("    # F3 / Decision 12 (ascii45): report only. The checklist (items 17, 18, 19)\n"
           "    # is the one place these change. F15: the screen-timeout advice stays in\n"
           "    # the box above -- it no longer prints after an answer.\n"
           "    Write-Host \"  Items 1-3 above change only on the security checklist (items 17-19),\" -ForegroundColor Yellow\n"
           "    Write-Host \"  and only if you select them there. Nothing is changed here.\" -ForegroundColor Gray\n"
           "    Write-Host \"\"\n"
           "    $powerChoices = @{ PasswordOnWake = $false; FastStartup = $false; WakeOnLAN = $false }\n"
           "\n")
    e.replace(old, new, count=1, why="F3: screen 19 questions for 1-3 removed")

    # ---------- F14: apply loops read each adapter once ----------
    e.replace(
        "                    foreach ($dn in @('Wake on Magic Packet','Wake on Pattern Match','Wake from S0ix on Magic Packet')) {\n"
        "                        $prop = Get-NetAdapterAdvancedProperty -Name $a.Name -DisplayName $dn -EA SilentlyContinue\n",
        "                    # F14 / FT-292 (ascii45): read the adapter once and filter -- asking for a\n"
        "                    # name it lacks left an error behind (4 SILENT ERROR lines, 2026-09-27).\n"
        "                    $ggAllProps = @(Get-NetAdapterAdvancedProperty -Name $a.Name -EA SilentlyContinue)\n"
        "                    foreach ($dn in @('Wake on Magic Packet','Wake on Pattern Match','Wake from S0ix on Magic Packet')) {\n"
        "                        $prop = $ggAllProps | Where-Object { $_.DisplayName -eq $dn } | Select-Object -First 1\n",
        count=1, why="F14: checklist apply loop")
    e.replace(
        "                foreach ($dn in @('Wake on Magic Packet','Wake on Pattern Match','Wake from S0ix on Magic Packet')) {\n"
        "                    $prop = Get-NetAdapterAdvancedProperty -Name $a.Name -DisplayName $dn -EA SilentlyContinue\n",
        "                # F14 / FT-292 (ascii45): read the adapter once and filter (no error noise).\n"
        "                $ggAllProps = @(Get-NetAdapterAdvancedProperty -Name $a.Name -EA SilentlyContinue)\n"
        "                foreach ($dn in @('Wake on Magic Packet','Wake on Pattern Match','Wake from S0ix on Magic Packet')) {\n"
        "                    $prop = $ggAllProps | Where-Object { $_.DisplayName -eq $dn } | Select-Object -First 1\n",
        count=1, why="F14: screen 19 apply loop")

    # ---------- F7: log every adapter at both reads ----------
    e.replace(
        "                        $props = @(Get-NetAdapterAdvancedProperty -Name $a.Name -EA SilentlyContinue |\n"
        "                            Where-Object { $_.DisplayName -match 'Wake on Magic Packet|Wake on Pattern Match|Wake from S0ix' })\n",
        "                        $props = @(Get-NetAdapterAdvancedProperty -Name $a.Name -EA SilentlyContinue |\n"
        "                            Where-Object { $_.DisplayName -match 'Wake on Magic Packet|Wake on Pattern Match|Wake from S0ix' })\n"
        "                        try { Write-Log -Message (\"Wake on LAN read: \" + $a.Name + \" [\" + $a.InterfaceDescription + \"] \" + $(if ($props.Count) { ($props | ForEach-Object { $_.DisplayName + \"=\" + $_.DisplayValue }) -join \"; \" } else { \"no named wake settings\" })) -Status \"INFO\" } catch {}   # F7\n",
        count=1, why="F7: checklist read logs adapters")
    e.replace(
        "            $props = @(Get-NetAdapterAdvancedProperty -Name $a.Name -EA SilentlyContinue |\n"
        "                Where-Object { $_.DisplayName -match 'Wake on Magic Packet|Wake on Pattern Match|Wake from S0ix' })\n",
        "            $props = @(Get-NetAdapterAdvancedProperty -Name $a.Name -EA SilentlyContinue |\n"
        "                Where-Object { $_.DisplayName -match 'Wake on Magic Packet|Wake on Pattern Match|Wake from S0ix' })\n"
        "            try { Write-Log -Message (\"Wake on LAN read: \" + $a.Name + \" [\" + $a.InterfaceDescription + \"] \" + $(if ($props.Count) { ($props | ForEach-Object { $_.DisplayName + \"=\" + $_.DisplayValue }) -join \"; \" } else { \"no named wake settings\" })) -Status \"INFO\" } catch {}   # F7\n",
        count=1, why="F7: screen 19 read logs adapters")

    # ---------- F17: items 13 and 14 ----------
    region(e,
           "\n            13 {\n",
           "\n            15 {\n",
           [("\"Unknown -- could not check\"", "\"Unknown -- nothing stored; select it to set it off\"", 5)],
           "F17: items 13 and 14 Unknown wording")
