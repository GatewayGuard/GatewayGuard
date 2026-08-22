"""build_ascii42 -- FT-193 and FT-194.

Dated: 2026-08-19 18:30 ET
Editor: Claude Code (CGDELL)

FT-193 -- ONE STRAY KEY REPAINTS THE WHOLE CHECKLIST, SILENTLY
---------------------------------------------------------------
measured, Logs-Sandy-ascii41\\GatewayGuard-Log-2026-08-18_16-18.txt at
17:35:15: the checklist repaints TEN TIMES INSIDE ONE SECOND with no [KEY]
line between any of them. Ninety minutes earlier every repaint is preceded by
an accepted key. Accepted keys peak at two per second across the whole run.

Three causes were proposed for what fed those events. **It does not matter
which was right, and that is the point.** Mouse events reaching ReadKey,
a right-click paste in Windows Terminal (Bill's finding 9 proves this one
happened -- he reached the I screen without pressing I), or Bill's own
explanation, the mouse body resting on SANDY's keyboard while he moved it.
All three deliver the same thing: characters that are not checklist commands.

**The defect is what Checkup does with them**, at line 8202:

    } else {
        $userInput = ""  # Invalid -- swallow silently
        Write-Host ""
    }

Falls through, loops, and Clear-Host repaints the entire screen. No message,
no log line. One stray character = one full repaint. A burst = the chaos Bill
described.

THREE CHANGES, and the third is the one that matters:

  1. Re-assert the input gate on the checklist. Reset-GGInputGate has exactly
     ONE call site -- inside Draw-Box -- and the checklist is the only screen
     that does not use Draw-Box. FT-171f's claim was "console flags asserted
     before EVERY screen"; it was implemented centrally so no new screen could
     forget, and it has exactly one hole, which is the screen the user spends
     most of the run on.
  2. Say what was ignored, and log it. FT-173's lesson, applied to the second
     reader. Rate-limited so a flood cannot fill the log.
  3. DO NOT REPAINT on an unmatched key. Re-prompt in place instead. This
     alone would have made Bill's whole session calm whatever was hitting the
     keys, and it also flushes the rest of the burst.

FT-194 -- THE I KEY IS DEAD ON 71 OF 127 SCREENS
-------------------------------------------------
measured: Pause-ForUser accepts VirtualKeyCode 13 and 32 only. I added the I
key to Read-ValidKey -- 56 sites, every one of them a QUESTION -- and not to
Pause-ForUser, which is 71 sites and nearly every PAGE.

That is the exact mirror of the Back defect I had spent that same morning
analysing and writing up: Back works on pages and not questions. I then put
the new key in the reader with the fewest screens. Bill's finding 33: "your
number 5-7 not active due to 'I' not working" -- three checklist items could
not be tested at all.
"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from gg_edit import PS1Edit, EditError  # noqa: E402

TOOL = Path(__file__).parent
TARGET = TOOL / "W11-SecurityHardening-v3-ascii42-2026-08-19-1830.ps1"
OLD_NAME = "W11-SecurityHardening-v3-ascii41-2026-08-17-2246.ps1"
NEW_NAME = "W11-SecurityHardening-v3-ascii42-2026-08-19-1830.ps1"


def main() -> int:
    text = TARGET.read_text(encoding="utf-8-sig").replace("\r\n", "\n")
    src = text.split("\n")

    def block(a, b):
        return "\n".join(src[a - 1:b])

    def find_one(needle):
        hits = [l for l in src if needle in l]
        if len(hits) != 1:
            raise EditError(f"expected 1 line containing {needle!r}, found {len(hits)}")
        return hits[0]

    with PS1Edit(TARGET) as e:

        # ---- build identity ------------------------------------------------
        e.replace(f"# FILE:    {OLD_NAME}", f"# FILE:    {NEW_NAME}",
                  count=1, why="build id: FILE header")
        e.replace("# BUILD:   ascii41  |  Version 3.1",
                  "# BUILD:   ascii42  |  Version 3.1",
                  count=1, why="build id: BUILD header")
        e.replace('$BuildID        = "ascii41"', '$BuildID        = "ascii42"',
                  count=1, why="build id: $BuildID")

        # ---- FT-193 part 1: assert the gate, and open the re-prompt loop ----
        e.replace(
            '        Write-Host "  Enter command (R/A/N/Q/P or item number 1-19): " -ForegroundColor White -NoNewline\n'
            '        $userInput = ""',

            "        # FT-193 (ascii42): ASSERT THE INPUT GATE HERE.\n"
            "        # Reset-GGInputGate had exactly one call site -- inside Draw-Box --\n"
            "        # and the checklist is the only screen that does not use Draw-Box.\n"
            "        # FT-171f's claim was \"console flags asserted before EVERY screen\",\n"
            "        # implemented centrally so that no NEW screen could forget it. It had\n"
            "        # one hole, and the hole was the screen the user spends most of the\n"
            "        # run on. A central fix protects what is routed through the centre.\n"
            "        Reset-GGInputGate\n"
            "\n"
            "        # FT-193: re-prompt WITHOUT repainting. Before this, an unmatched key\n"
            "        # fell through to the bottom of checklistLoop and Clear-Host repainted\n"
            "        # the entire screen -- so one stray character was one full repaint, and\n"
            "        # a burst was ten repaints a second. Measured 2026-08-18 at 17:35:15.\n"
            "        $ggBadKeys = 0\n"
            "        :keyLoop while ($true) {\n"
            '        Write-Host "  Enter command (R/A/N/Q/P or item number 1-19): " -ForegroundColor White -NoNewline\n'
            '        $userInput = ""',
            count=1, why="FT-193: input gate + non-repainting re-prompt loop")

        # ---- FT-193 part 2: valid single letter leaves the loop -------------
        e.replace(
            '        if ($firstCh -in @("R","A","N","Q","P")) {\n'
            "            $userInput = $firstCh\n"
            "            Write-Host $userInput -ForegroundColor Cyan\n"
            '        } elseif ($firstCh -match "[1-9]") {',

            '        if ($firstCh -in @("R","A","N","Q","P")) {\n'
            "            $userInput = $firstCh\n"
            "            Write-Host $userInput -ForegroundColor Cyan\n"
            "            break keyLoop\n"
            '        } elseif ($firstCh -match "[1-9]") {',
            count=1, why="FT-193: accepted command exits the re-prompt loop")

        # ---- FT-193 part 3: the swallow becomes a message, not a repaint ----
        e.replace(
            "            } else {\n"
            "                $userInput = $firstCh\n"
            '                Write-Host ""\n'
            "            }\n"
            "        } else {\n"
            '            $userInput = ""  # Invalid -- swallow silently\n'
            '            Write-Host ""\n'
            "        }",

            "            } else {\n"
            "                $userInput = $firstCh\n"
            '                Write-Host ""\n'
            "            }\n"
            "            break keyLoop\n"
            "        } else {\n"
            "            # FT-193 (ascii42): was '$userInput = \"\"  # Invalid -- swallow\n"
            "            # silently', which fell through and repainted the whole screen.\n"
            "            # Now: say so, log it, drain the rest of the burst, and ask again\n"
            "            # IN PLACE. Nothing is redrawn, so a held key or a pasted line\n"
            "            # cannot turn into an avalanche.\n"
            "            $ggBadKeys++\n"
            '            Write-Host ""\n'
            "            if ($ggBadKeys -le 3) {\n"
            '                Write-Host "  That key does nothing here. Press R, A, N, Q, P or an item number 1-19." -ForegroundColor Yellow\n'
            "                # Rate-limited: a flood must not fill the log, but the FIRST\n"
            "                # few must appear or a future flood is invisible again --\n"
            "                # which is exactly why FT-193 could not be diagnosed from the\n"
            "                # ascii40 logs.\n"
            '                try { Write-Log -Message ("Checklist: key ignored (" + $(if ($firstCh) { $firstCh } else { "non-printing" }) + ")") -Status "KEY" } catch {}\n'
            "            } elseif ($ggBadKeys -eq 4) {\n"
            '                Write-Host "  Ignoring repeated keys. Something may be resting on the keyboard." -ForegroundColor Yellow\n'
            '                try { Write-Log -Message "Checklist: 4+ ignored keys in one prompt -- burst suppressed (FT-193)" -Status "WARN" } catch {}\n'
            "            }\n"
            "            # Drain whatever else arrived with it. One stray key is a typo;\n"
            "            # a queue behind it is a paste, a held key, or a mouse on the keys.\n"
            "            try { Clear-PendingKeys } catch {}\n"
            "            continue keyLoop\n"
            "        }\n"
            "        }   # end :keyLoop (FT-193)",
            count=1, why="FT-193: message + drain + re-prompt, no repaint")

        # ---- FT-194: the I key on every page, not just every question -------
        e.replace(
            "            $ggCh = \"\"\n"
            "            try { $ggCh = $k.Character.ToString().ToUpper() } catch {}\n"
            '            if ($ggCanBack -and $ggCh -eq "B") {',

            "            $ggCh = \"\"\n"
            "            try { $ggCh = $k.Character.ToString().ToUpper() } catch {}\n"
            "            # FT-194 (ascii42): I was added to Read-ValidKey in ascii41 -- 56\n"
            "            # sites, every one a QUESTION -- and not here, which is 71 sites\n"
            "            # and nearly every PAGE. The exact mirror of the Back defect\n"
            "            # analysed the same morning: Back works on pages and not\n"
            "            # questions. Bill's finding 33: \"your number 5-7 not active due\n"
            "            # to 'I' not working\" -- three checklist items were untestable.\n"
            '            if ($ggCh -eq "I") {\n'
            "                try { Write-Log -Message (\"Info screen opened at: \" + (Get-PSCallStack)[1].Command) -Status \"KEY\" } catch {}\n"
            "                Show-CheckupInfo\n"
            "                # Same rule as the B path below: a key that returns to its own\n"
            "                # prompt must RE-RENDER, never append (FT-65).\n"
            "                if (-not (Restore-ScreenSnapshot -Snapshot $script:GGSnapshots[$script:GGSnapshots.Count - 1])) {\n"
            "                    Clear-Host\n"
            '                    Write-Host ""\n'
            '                    Write-Host "  (Returning to where you were. Nothing has changed.)" -ForegroundColor Yellow\n'
            "                }\n"
            '                Write-Host ""\n'
            "                Write-Host $Message -ForegroundColor White\n"
            "                continue\n"
            "            }\n"
            '            if ($ggCanBack -and $ggCh -eq "B") {',
            count=1, why="FT-194: I works on pages, not only questions")

        e.commit()

    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except EditError as exc:
        print(f"\nABORTED: {exc}", file=sys.stderr)
        sys.exit(1)
