"""build_ascii45_F3a_numbers_2fa -- Block F, batch 3a: unnumbered pages
(F4 / FT-274, FT-275; F20 / FT-298) and the two-step sign-in line (F6).

Dated: 2026-09-28 08:18 ET
Editor: Claude Code (CGDELL)

FT-274: screen 3's FONT CHECK sample box carried its own ScreenId (28), so a
second number ("Screen 4") printed inside screen 3. The sample is now drawn
without a number and 28 leaves the table. Screens 1-3 (IDs 85-87) now write a
SCREEN line to the log -- they left no trace (triage, note 1).
FT-275: the "the NEXT screen is a long one -- scroll up" pause before screen
19 was an unnumbered page. Dropped: full screen (C9) and F (C6) cover long
screens.
FT-298: the power check after the scans (plugged in / battery / stay awake)
was a pause with no box -- Bill, 2026-09-28: "first screen after 15 (has no
scr #)". It gets a box, ID 98.
F6 / Decision 7: screen 34's "2FA" line becomes plain words pointing at the
guide, Part 5.

Run from Tool2/:  python build_ascii45_F3a_numbers_2fa.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "#           every adapter's wake settings are logged. F17: 13/14 wording.\n",
        "#           every adapter's wake settings are logged. F17: 13/14 wording.\n"
        "#   F4 (FT-274/275): screen 3's sample box has no number of its own; screens\n"
        "#           1-3 are logged; the \"next screen is long\" pause is gone.\n"
        "#   F20 (FT-298): the power check page gets a box (98). F6: two-step sign-in.\n",
        count=1, why="change log: batch 3a")

    # FT-274: the sample box, no number
    e.replace(
        "            Draw-Box -ScreenId \"28\" -Color White -Lines @(\n"
        "                \"  FONT CHECK: If this box has clean lines, you are ready.   \",\n",
        "            # FT-274 (ascii45): a sample, not a screen -- drawn with no number, so\n"
        "            # screen 3 no longer shows \"Screen 4\" inside itself.\n"
        "            Write-GGBox -Color White -Lines @(\n"
        "                \"  FONT CHECK: If this box has clean lines, you are ready.   \",\n",
        count=1, why="FT-274: sample box without a number")
    e.replace(
        "    \"28\" = \"4\"            # FONT CHECK\n",
        "",
        count=1, why="FT-274: 28 out of the table")

    # screens 1-3 logged
    e.replace(
        "        & $introScreens[$screenIdx]\n",
        "        & $introScreens[$screenIdx]\n"
        "        # FT-274 (ascii45): screens 1-3 are drawn by hand and left no log line.\n"
        "        if ($screenIdx -le 2) {\n"
        "            $ggIntroId = @(\"85\", \"86\", \"87\")[$screenIdx]\n"
        "            try { Write-Log -Message (\"[SCREEN-\" + $ggIntroId + \"] (shown as screen \" + $script:GGScreenLabels[$ggIntroId] + \") Rendered: intro screen \" + ($screenIdx + 1)) -Status \"SCREEN\" } catch {}\n"
        "        }\n",
        count=1, why="FT-274: log screens 1-3")

    # FT-275: the pre-page before 19
    e.replace(
        "    Write-Host \"  Power settings check complete. The NEXT screen is a long one --\" -ForegroundColor Yellow\n"
        "    Write-Host \"  BE SURE TO SCROLL UP TO THE TOP of it before reading.\" -ForegroundColor Yellow\n"
        "    Pause-ForUser \"  Press Enter or Space to see the power settings review...\"\n",
        "    # FT-275 (ascii45): the unnumbered \"next screen is long -- scroll up\" pause\n"
        "    # is gone; full screen (C9) and F (C6) handle long screens.\n",
        count=1, why="FT-275: pre-page dropped")

    # FT-298: the power check page gets a box
    e.replace(
        "        Write-Host \"\"\n"
        "        if ($hasBattery) {\n"
        "            Write-Host \"  OK  Plugged into AC power.\" -ForegroundColor Green\n"
        "            Write-Host \"      Battery: $batteryPct charged and plugged in\" -ForegroundColor White\n"
        "            Write-Host \"      Safe to run all settings including BitLocker.\" -ForegroundColor White\n"
        "        } else {\n"
        "            Write-Host \"  OK  AC power -- desktop PC (no battery detected).\" -ForegroundColor Green\n"
        "        }\n"
        "        # F13 / FT-291 (ascii45): Enable-SleepPrevention changes NO setting --\n"
        "        # it only asks Windows not to sleep while Checkup runs.\n"
        "        Write-Host \"  OK  Checkup keeps your PC awake while it runs.\" -ForegroundColor Green\n"
        "        Write-Host \"      Your sleep settings are not changed. When Checkup closes, your\" -ForegroundColor White\n"
        "        Write-Host \"      PC goes to sleep as it normally does.\" -ForegroundColor White\n",
        "        # FT-298 (ascii45): this page had no box and no number (Bill, 2026-09-28).\n"
        "        # F13 / FT-291: Enable-SleepPrevention changes NO setting -- it only asks\n"
        "        # Windows not to sleep while Checkup runs.\n"
        "        Clear-Host\n"
        "        Write-Host \"\"\n"
        "        Draw-Box -ScreenId \"98\" -Color White -Lines @(\n"
        "            \"  POWER CHECK                                                \",\n"
        "            \"---\",\n"
        "            $(if ($hasBattery) { (\"  OK  Plugged in. Battery: \" + $batteryPct + \" charged.\") } else { \"  OK  Plugged in -- desktop PC (no battery).                \" }),\n"
        "            \"      Safe to run every setting, including encryption.       \",\n"
        "            \"                                                            \",\n"
        "            \"  OK  Checkup keeps your PC awake while it runs.            \",\n"
        "            \"      Your sleep settings are not changed. When Checkup     \",\n"
        "            \"      closes, your PC goes to sleep as it normally does.    \"\n"
        "        )\n"
        "        Write-Host \"\"\n",
        count=1, why="FT-298: power check page box")
    e.replace(
        "    \"95\" = \"16a\"          # Full scan of every drive (E6) -- interim label\n",
        "    \"95\" = \"16a\"          # Full scan of every drive (E6) -- interim label\n"
        "    \"98\" = \"18\"           # Power check -- plugged in, stay awake (FT-298) -- interim\n",
        count=1, why="table: 98")

    # F6: two-step sign-in
    e.replace(
        "        \"  [ ] 2FA                -- Enable on all important accounts.\",\n"
        "        \"      Authenticator app preferred. Guide: Phase 5           \",\n",
        "        \"  [ ] Two-step sign-in   -- Turn it on for email and bank. \",\n"
        "        \"      A code from your phone as well as your password.     \",\n"
        "        \"      See the guide, Part 5.                               \",\n",
        count=1, why="F6: two-step sign-in line")
