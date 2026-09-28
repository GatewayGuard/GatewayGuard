"""build_ascii45_F3b_pages_names -- Block F, batch 3b: the last unnumbered
antivirus pages (F4 / FT-275, F20 / FT-298) and password-manager names.

Dated: 2026-09-28 08:22 ET (commit time; the 08:31 first typed here was not read off a clock)
Editor: Claude Code (CGDELL)

FT-275 / FT-298: Test-DefenderPrimary opened with Clear-Host and "Checking
antivirus status...", which wiped screen 97 (the start progress screen) and
left an unnumbered page. Removed -- screen 97 already says what is being
checked. The "could not verify Defender" path was a pause with no box; it is
now a NOTE line on screen 97 and 14g, same words.
The other FT-275 pages, measured 2026-09-28 in this build: the resume tip
(Show-ResumePrompt) and the post-scan question (Show-PostScanGuidance) print
below their own boxes (25 and 40) with no Clear-Host, so the number is on
screen; the password re-ask after B on 23 now redraws box 53. The per-item
run pages are F1.

CLAUDE.md, Product Rules (Bill, 2026-09-25): no password-manager product
named anywhere. Measured 2026-09-28: four sites named Bitwarden, 1Password or
KeePass (screens 22 and 22a, item 15's Why text, and its explanation page).

Run from Tool2/:  python build_ascii45_F3b_pages_names.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "#   F20 (FT-298): the power check page gets a box (98). F6: two-step sign-in.\n",
        "#   F20 (FT-298): the power check page gets a box (98). F6: two-step sign-in.\n"
        "#   FT-275: the antivirus check no longer clears screen 97; \"could not verify\"\n"
        "#           is a NOTE line. No password-manager product is named (CLAUDE.md).\n",
        count=1, why="change log: batch 3b")

    e.replace(
        "function Test-DefenderPrimary {\n"
        "    Clear-Host\n"
        "    Write-Host \"\"\n"
        "    Write-Host \"  Checking antivirus status...\" -ForegroundColor Cyan\n"
        "    Write-Host \"\"\n",
        "function Test-DefenderPrimary {\n"
        "    # FT-275 (ascii45): no Clear-Host here -- it wiped screen 97, which\n"
        "    # already says this check is running.\n",
        count=1, why="FT-275: keep screen 97 up")

    e.replace(
        "            Write-Host \"\"\n"
        "            Write-Host \"  Could not verify Defender's status just now -- this is usually\" -ForegroundColor Yellow\n"
        "            Write-Host \"  temporary. To check yourself: open Windows Security and look\" -ForegroundColor Yellow\n"
        "            Write-Host \"  under Virus & threat protection.\" -ForegroundColor Yellow\n"
        "            Write-Log -Message \"Defender state unverifiable -- informational message shown, continuing\" -Status \"WARN\"\n"
        "            Pause-ForUser\n",
        "            # FT-275 (ascii45): was an unnumbered page; now a line on 97 and 14g.\n"
        "            Add-GGReady \"AV\" \"  NOTE  Could not read virus protection just now (usually temporary). To look: Windows Security -> Virus & threat protection.\"\n"
        "            Write-Log -Message \"Defender state unverifiable -- NOTE line shown, continuing\" -Status \"WARN\"\n",
        count=1, why="FT-275: unverifiable path")

    # no password-manager names
    e.replace(
        "            \"  (an app such as Bitwarden, 1Password, or KeePass).         \",\n",
        "            \"  (a separate app that stores your passwords safely).       \",\n",
        count=1, why="names: screen 74")
    e.replace(
        "        \"  Do you use a PASSWORD MANAGER -- a separate app such as     \",\n"
        "        \"  Bitwarden, 1Password, or KeePass -- to store your           \",\n"
        "        \"  passwords?                                                  \",\n",
        "        \"  Do you use a PASSWORD MANAGER -- a separate app that         \",\n"
        "        \"  stores your passwords safely and fills them in for you?     \",\n"
        "        \"                                                              \",\n",
        count=1, why="names: screen 53")
    e.replace(
        "A dedicated password manager (Bitwarden, 1Password) uses stronger",
        "A separate password manager app uses stronger",
        count=1, why="names: item 15 Why")
    e.replace(
        "                            Write-Host \"  manager (Bitwarden, 1Password, etc.) uses stronger\" -ForegroundColor Gray\n",
        "                            Write-Host \"  manager app uses stronger\" -ForegroundColor Gray\n",
        count=1, why="names: item 15 page")
