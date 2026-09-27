"""build_ascii45_c9_fullscreen_screens -- C9, the build half: the screens say
what is true in full-screen Windows Terminal.

Dated: 2026-09-27 14:22 ET
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block C, item C9 (Bill 2026-09-26:
"add full screen to ascii45"). The launcher half is Tool2\\Run-GatewayGuard.bat.

Checkup notes at start-up if it is inside Windows Terminal ($env:WT_SESSION --
MEASURED present in Windows Terminal, Test_Results\\WtCopySelect-CGDELL-
2026-09-27_10-49.txt). Screens that give window instructions then show the
Windows Terminal version; the classic console keeps today's text unchanged.

Every instruction below is MEASURED on CGDELL 2026-09-27:
  Windows Terminal 1.24 defaults.json -- Ctrl+plus / Ctrl+minus / Ctrl+0 font
  size; Ctrl+Shift+PgUp/PgDn scroll a page; Alt+Enter and F11 full screen;
  Alt+F4 closes.
  Bill's copy test 10:49 -- highlighting does not pause the program; Ctrl+C
  with text highlighted copies it and clears the highlight.
  Bill's Ctrl+C tests 11:09/11:27 -- Ctrl+C with nothing highlighted is caught
  (C7) and Checkup asks first.
Box line counts are unchanged, so no screen grows (gate 12b).

Run from Tool2/:  python build_ascii45_c9_fullscreen_screens.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"


def cond(old_lines, wt_lines, indent):
    """Turn a run of box lines into per-line $(if) choices -- same count."""
    assert len(old_lines) == len(wt_lines), (len(old_lines), len(wt_lines))
    out = []
    for o, w in zip(old_lines, wt_lines):
        assert len(w) <= 64, (len(w), w)
        out.append('%s$(if ($script:GGInWT) { "%s" } else { "%s" }),\n' % (indent, w, o))
    return "".join(out)


with PS1Edit(TARGET) as e:
    e.replace(
        "#           and CGDELL 2026-09-27).\n",
        "#           and CGDELL 2026-09-27).\n"
        "#   C9:     FULL-SCREEN WINDOWS TERMINAL. The launcher opens Checkup full\n"
        "#           screen; screens 1, 2, 3, 5, 6 and 8, screen 12's scroll hint and\n"
        "#           the copy tips say what is true there ($script:GGInWT). The\n"
        "#           classic console keeps its old text.\n",
        count=1, why="change log: C9")

    # ---- where it is known ----
    e.replace(
        "\nEnable-GGCtrlCGuard   # C7 / FT-270: before the first question\n",
        "\n$script:GGInWT = [bool]$env:WT_SESSION   # C9: running inside Windows Terminal?\n"
        "Write-Log -Message (\"Window: \" + $(if ($script:GGInWT) { \"Windows Terminal\" } else { \"classic console\" })) -Status \"INFO\"\n"
        "Enable-GGCtrlCGuard   # C7 / FT-270: before the first question\n",
        count=1, why="C9: detect Windows Terminal")

    # ---- the copy tip, one helper ----
    e.replace(
        "function Show-ScrollCopyTip {\n",
        "function Write-GGCopyTip {\n"
        "    # C9 (ascii45): the copy tip for the window Checkup is in. The classic\n"
        "    # console text is CLAUDE.md's standard tip, word for word.\n"
        "    param([System.ConsoleColor]$Color = \"DarkCyan\")\n"
        "    if ($script:GGInWT) {\n"
        "        Write-Host \"  Tip: To copy text -- highlight it with the mouse, then press Ctrl+C.\" -ForegroundColor $Color\n"
        "    } else {\n"
        "        Write-Host \"  Tip: To copy text from this window -- press Alt+Space, then E, then M --\" -ForegroundColor $Color\n"
        "        Write-Host \"       drag or use Shift+arrows to select -- press Enter to copy.\" -ForegroundColor $Color\n"
        "        Write-Host \"       Press Esc to exit without copying.\" -ForegroundColor $Color\n"
        "    }\n"
        "}\n"
        "\n"
        "function Show-ScrollCopyTip {\n",
        count=1, why="C9: Write-GGCopyTip")
    e.replace(
        "            Write-Host \"  Tip: To copy text from this window -- press Alt+Space, then E, then M --\" -ForegroundColor DarkCyan\n"
        "            Write-Host \"       drag or use Shift+arrows to select -- press Enter to copy.\" -ForegroundColor DarkCyan\n"
        "            Write-Host \"       Press Esc to exit without copying.\" -ForegroundColor DarkCyan\n",
        "            Write-GGCopyTip -Color DarkCyan   # C9\n",
        count=1, why="C9: resume copy tip")
    e.replace(
        "                    Write-Host \"  Tip: To copy text from this window -- press Alt+Space, then E, then M --\" -ForegroundColor Cyan\n"
        "                    Write-Host \"       drag or use Shift+arrows to select -- press Enter to copy.\" -ForegroundColor Cyan\n"
        "                    Write-Host \"       Press Esc to exit without copying.\" -ForegroundColor Cyan\n",
        "                    Write-GGCopyTip -Color Cyan   # C9\n",
        count=1, why="C9: BitLocker copy tip")

    # ---- resume: the maximize tip only where there is something to maximize ----
    e.replace(
        "            Write-Host \"  Tip: press Windows+Up Arrow, or click the maximize box\" -ForegroundColor Gray\n"
        "            Write-Host \"  (top-right corner), to make this window full-screen again.\" -ForegroundColor Gray\n",
        "            if (-not $script:GGInWT) {   # C9: already full screen in Windows Terminal\n"
        "                Write-Host \"  Tip: press Windows+Up Arrow, or click the maximize box\" -ForegroundColor Gray\n"
        "                Write-Host \"  (top-right corner), to make this window full-screen again.\" -ForegroundColor Gray\n"
        "            }\n",
        count=1, why="C9: resume maximize tip")

    # ---- screen 12's scroll hint ----
    e.replace(
        "    Write-Host \"     press Alt+Spacebar, then E, then M, then use the Up/Down\" -ForegroundColor Yellow\n"
        "    Write-Host \"     arrow keys. Press Esc when done -- the tool will continue.\" -ForegroundColor Yellow\n",
        "    if ($script:GGInWT) {   # C9\n"
        "        Write-Host \"     use your mouse wheel, or press F to fit the screen.\" -ForegroundColor Yellow\n"
        "    } else {\n"
        "        Write-Host \"     press Alt+Spacebar, then E, then M, then use the Up/Down\" -ForegroundColor Yellow\n"
        "        Write-Host \"     arrow keys. Press Esc when done -- the tool will continue.\" -ForegroundColor Yellow\n"
        "    }\n",
        count=1, why="C9: screen 12 scroll hint")

    # ---- screen 1 (85) ----
    e.replace(
        "            Write-Host \"  For the best experience, please maximize this window now\" -ForegroundColor White\n"
        "            Write-Host \"  by clicking the square button in the upper right corner\" -ForegroundColor White\n"
        "            Write-Host \"  of this window, or hold the Windows key and press the\" -ForegroundColor White\n"
        "            Write-Host \"  Up arrow.\" -ForegroundColor White\n",
        "            if ($script:GGInWT) {   # C9\n"
        "                Write-Host \"  Checkup fills the whole screen. There is no X to click in the\" -ForegroundColor White\n"
        "                Write-Host \"  corner. To leave at any time, press X at a question -- Checkup\" -ForegroundColor White\n"
        "                Write-Host \"  asks you first -- or press Alt+F4.\" -ForegroundColor White\n"
        "                Write-Host \"  To see your other windows, press Alt+Enter; press it again to\" -ForegroundColor White\n"
        "                Write-Host \"  come back to full screen.\" -ForegroundColor White\n"
        "            } else {\n"
        "                Write-Host \"  For the best experience, please maximize this window now\" -ForegroundColor White\n"
        "                Write-Host \"  by clicking the square button in the upper right corner\" -ForegroundColor White\n"
        "                Write-Host \"  of this window, or hold the Windows key and press the\" -ForegroundColor White\n"
        "                Write-Host \"  Up arrow.\" -ForegroundColor White\n"
        "            }\n",
        count=1, why="C9: screen 1")

    # ---- screen 2 (86) ----
    e.replace(
        "            Write-Host \"  Now scroll to the TOP and BOTTOM of this window AND\" -ForegroundColor White\n"
        "            Write-Host \"  FOLLOWING WINDOWS -- use your mouse wheel, or click the\" -ForegroundColor White\n"
        "            Write-Host \"  little arrows on the right side of the window -- so you\" -ForegroundColor White\n"
        "            Write-Host \"  don't miss anything.\" -ForegroundColor White\n",
        "            if ($script:GGInWT) {   # C9\n"
        "                Write-Host \"  On every screen, scroll to the TOP and BOTTOM with your mouse\" -ForegroundColor White\n"
        "                Write-Host \"  wheel so you don't miss anything. Or hold Ctrl and Shift and\" -ForegroundColor White\n"
        "                Write-Host \"  press Page Up or Page Down to move a whole page at a time.\" -ForegroundColor White\n"
        "            } else {\n"
        "                Write-Host \"  Now scroll to the TOP and BOTTOM of this window AND\" -ForegroundColor White\n"
        "                Write-Host \"  FOLLOWING WINDOWS -- use your mouse wheel, or click the\" -ForegroundColor White\n"
        "                Write-Host \"  little arrows on the right side of the window -- so you\" -ForegroundColor White\n"
        "                Write-Host \"  don't miss anything.\" -ForegroundColor White\n"
        "            }\n",
        count=1, why="C9: screen 2")

    # ---- screen 3 (87): font -> text size ----
    border = "  +==============================================================+"
    title_old = "  |  SET YOUR CONSOLE FONT (takes 30 seconds)                    |"
    title_wt = "  |  MAKE THE TEXT EASY TO READ (takes 30 seconds)               |"
    assert len(title_old) == len(border) == len(title_wt), (len(title_old), len(border), len(title_wt))
    e.replace(
        "            Write-Host \"%s\" -ForegroundColor Yellow\n" % title_old,
        "            Write-Host $(if ($script:GGInWT) { \"%s\" } else { \"%s\" }) -ForegroundColor Yellow   # C9\n" % (title_wt, title_old),
        count=1, why="C9: screen 3 title")
    e.replace(
        "            Write-Host \"  Checkup uses box-drawing characters. For best display:\" -ForegroundColor White\n"
        "            Write-Host \"\"\n"
        "            Write-Host \"  1. Right-click the title bar of this window\" -ForegroundColor Cyan\n"
        "            Write-Host \"  2. Click Properties (or Defaults)\" -ForegroundColor Cyan\n"
        "            Write-Host \"  3. Click the Font tab\" -ForegroundColor Cyan\n"
        "            Write-Host \"  4. Set Font to: Consolas  or  Lucida Console\" -ForegroundColor Cyan\n"
        "            Write-Host \"  5. Set Size to: 14  (or larger if text is hard to read)\" -ForegroundColor Cyan\n"
        "            Write-Host \"  6. Click OK\" -ForegroundColor Cyan\n"
        "            Write-Host \"\"\n"
        "            Write-Host \"  WHY: Without the right font, boxes may show as question marks\" -ForegroundColor Gray\n"
        "            Write-Host \"  or garbled characters. Checkup works either way -- this just\" -ForegroundColor Gray\n"
        "            Write-Host \"  makes it easier to read.\" -ForegroundColor Gray\n",
        "            if ($script:GGInWT) {   # C9: Windows Terminal's own keys (defaults.json, measured)\n"
        "                Write-Host \"  Is the text too small or too big? You can change it any time:\" -ForegroundColor White\n"
        "                Write-Host \"\"\n"
        "                Write-Host \"  Bigger:          hold Ctrl and press  +  (plus)\" -ForegroundColor Cyan\n"
        "                Write-Host \"  Smaller:         hold Ctrl and press  -  (minus)\" -ForegroundColor Cyan\n"
        "                Write-Host \"  Back to normal:  hold Ctrl and press  0  (zero)\" -ForegroundColor Cyan\n"
        "                Write-Host \"\"\n"
        "                Write-Host \"  After changing the size, press F -- Checkup redraws the screen\" -ForegroundColor Gray\n"
        "                Write-Host \"  to fit the new size.\" -ForegroundColor Gray\n"
        "            } else {\n"
        "                Write-Host \"  Checkup uses box-drawing characters. For best display:\" -ForegroundColor White\n"
        "                Write-Host \"\"\n"
        "                Write-Host \"  1. Right-click the title bar of this window\" -ForegroundColor Cyan\n"
        "                Write-Host \"  2. Click Properties (or Defaults)\" -ForegroundColor Cyan\n"
        "                Write-Host \"  3. Click the Font tab\" -ForegroundColor Cyan\n"
        "                Write-Host \"  4. Set Font to: Consolas  or  Lucida Console\" -ForegroundColor Cyan\n"
        "                Write-Host \"  5. Set Size to: 14  (or larger if text is hard to read)\" -ForegroundColor Cyan\n"
        "                Write-Host \"  6. Click OK\" -ForegroundColor Cyan\n"
        "                Write-Host \"\"\n"
        "                Write-Host \"  WHY: Without the right font, boxes may show as question marks\" -ForegroundColor Gray\n"
        "                Write-Host \"  or garbled characters. Checkup works either way -- this just\" -ForegroundColor Gray\n"
        "                Write-Host \"  makes it easier to read.\" -ForegroundColor Gray\n"
        "            }\n",
        count=1, why="C9: screen 3 body")

    # ---- screen 5 (29): items 1 and 2 ----
    old29 = [
        "  1. IF YOU HAVEN'T MAXIMIZED THIS WINDOW YET, DO IT NOW!      ",
        "     Click the small SQUARE icon at the TOP RIGHT of this      ",
        "     window (next to the X close button) to go full screen.    ",
        "     OR press Windows key + Up arrow.                          ",
    ]
    wt29 = [
        "  1. CHECKUP FILLS THE WHOLE SCREEN. There is no X in the     ",
        "     corner: to leave, press X at a question (Checkup asks    ",
        "     first), or press Alt+F4. Alt+Enter shows other windows.  ",
        "     Text too small? Hold Ctrl and press + to make it bigger. ",
    ]
    old29b = [
        "     Scroll arrows also appear at the TOP RIGHT and BOTTOM     ",
        "     RIGHT corners of the window. If the bottom arrow          ",
        "     disappears, move your mouse to the bottom right corner    ",
        "     and it will reappear.                                     ",
        "     PAGE UP / PAGE DOWN keys also scroll quickly.             ",
    ]
    wt29b = [
        "     Or hold Ctrl and Shift and press Page Up or Page Down     ",
        "     to move a whole page at a time. (Page Up and Page Down    ",
        "     on their own do not scroll here.)                         ",
        "     If the screen ever looks cut off after you change the     ",
        "     text size, press F to fit it to the window.               ",
    ]
    ind = "                "
    e.replace("".join('%s"%s",\n' % (ind, o) for o in old29), cond(old29, wt29, ind), count=1, why="C9: screen 5 item 1")
    e.replace("".join('%s"%s",\n' % (ind, o) for o in old29b), cond(old29b, wt29b, ind), count=1, why="C9: screen 5 item 2")

    # ---- screen 6 (78): item 7 ----
    old78 = [
        "  7. IF YOU CLICK THE X BY ACCIDENT: Checkup closes, but it    ",
        "     finishes writing your log first, and nothing is left      ",
    ]
    wt78 = [
        "  7. IF CHECKUP CLOSES BY ACCIDENT: it finishes writing your   ",
        "     log first, and nothing is left half-changed. Just run     ",
    ]
    e.replace("".join('%s"%s",\n' % (ind, o) for o in old78), cond(old78, wt78, ind), count=1, why="C9: screen 6 item 7a")
    e.replace(
        '                "     half-changed. Just run it again."\n',
        '                $(if ($script:GGInWT) { "     it again." } else { "     half-changed. Just run it again." })\n',
        count=1, why="C9: screen 6 item 7b")

    # ---- screen 8 (02) ----
    old02 = [
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
    ]
    wt02 = [
        "  TO SCROLL BACK AND RE-READ EARLIER TEXT:                   ",
        "  Use your mouse wheel. Or hold Ctrl and Shift and press     ",
        "  Page Up or Page Down to move a whole page at a time.       ",
        "                                                             ",
        "  TO COPY TEXT:                                              ",
        "  1. Hold the left mouse button and drag across the text,    ",
        "     so it is highlighted.                                   ",
        "  2. Press Ctrl+C. The highlight goes away -- that means it  ",
        "     was copied. Paste it wherever you like with Ctrl+V.     ",
        "                                                             ",
        "  Highlighting does NOT pause Checkup. Ctrl+C with something ",
        "  highlighted only copies -- it does not close Checkup.      ",
        "  Ctrl+C with nothing highlighted asks if you want to close  ",
        "  Checkup, and waits for your answer.                        ",
        "                                                             ",
    ]
    ind2 = "        "
    e.replace("".join('%s"%s",\n' % (ind2, o) for o in old02), cond(old02, wt02, ind2), count=1, why="C9: screen 8")
