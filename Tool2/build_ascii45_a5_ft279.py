"""build_ascii45_a5_ft279 -- the run loop says what actually happened, not
"applying it now", and long text wraps.

Dated: 2026-09-26 11:06 ET (commit time. The first stamp, 12:08, was typed, not read off the clock -- corrected 2026-09-26 11:10.)
Editor: Claude Code (CGDELL)
Plan: ascii45BuildPlan-2026-09-25-1638, Block A, item A5.

FT-279 (measured, triage note 28; ascii44 lines 9246, 9268-9275, 6756-6758):
  1. "You selected this item, so Checkup is applying it now." / "Applying..."
     printed before EVERY CanAuto item -- including items 11-15, which
     Apply-Setting then defers ("Saved for your individual review..."), and
     item 6, which Tamper Protection blocks. Bill: "which is it".
     Now: "Working on this item..." before, and the Result line says what
     happened.
  2. The deferred result matched none of the colour rule's words, so it was
     printed RED, like a failure. It now has its own colour (Cyan).
  3. Item 9's instructions (and any long result) ran off the right edge.
     New helper Write-GGWrapped wraps to the live window width.
Decision 4 (F1) later applies 11-15 in the main run; the deferred branch
becomes unreachable then and is removed with it.

Run from Tool2/:  python build_ascii45_a5_ft279.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

WRITE_LOG = (
    "function Write-Log {\n"
    "    param([string]$Message, [string]$Status = \"INFO\")\n"
    "    $entry = \"[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] [$Status] $Message\"\n"
    "    $LogEntries.Add($entry)\n"
    "    if (Test-Path (Split-Path $LogPath -Parent) -ErrorAction SilentlyContinue) {\n"
    "        try { $entry | Out-File -FilePath $LogPath -Append -Encoding UTF8 -ErrorAction SilentlyContinue } catch {}\n"
    "    }\n"
    "}\n"
)

WRAPPED = (
    "\n"
    "function Write-GGWrapped {\n"
    "    # FT-279 (ascii45): long results and hand-steps ran off the right edge\n"
    "    # (item 9 on SANDY). Wraps on word boundaries to the LIVE window width,\n"
    "    # read at call time, never cached (FT-217 family).\n"
    "    param([string]$Text, [string]$Color = \"White\", [int]$Indent = 2)\n"
    "    $ggW = 78\n"
    "    try { $ggW = [Console]::WindowWidth - 2 } catch {}\n"
    "    if ($ggW -lt 40) { $ggW = 40 }\n"
    "    $ggPad = \" \" * $Indent\n"
    "    $ggMax = $ggW - $Indent\n"
    "    $ggLine = \"\"\n"
    "    foreach ($ggWord in ($Text -split '\\s+')) {\n"
    "        if ($ggWord.Length -eq 0) { continue }\n"
    "        if ($ggLine.Length -eq 0) { $ggLine = $ggWord }\n"
    "        elseif (($ggLine.Length + 1 + $ggWord.Length) -le $ggMax) { $ggLine += \" \" + $ggWord }\n"
    "        else { Write-Host ($ggPad + $ggLine) -ForegroundColor $Color; $ggLine = $ggWord }\n"
    "    }\n"
    "    if ($ggLine.Length -gt 0) { Write-Host ($ggPad + $ggLine) -ForegroundColor $Color }\n"
    "}\n"
)

with PS1Edit(TARGET) as e:
    e.replace(
        "#           scans (they are reminder popups, FT-175). Box widths kept.\n",
        "#           scans (they are reminder popups, FT-175). Box widths kept.\n"
        "#   FT-279: THE RUN LOOP SAID \"APPLYING IT NOW\" BEFORE ITEMS IT THEN PUT\n"
        "#           OFF (11-15) OR COULD NOT CHANGE (6). Now \"Working on this\n"
        "#           item...\" and the Result says what happened; the put-off\n"
        "#           result is no longer red; long text wraps (Write-GGWrapped).\n",
        count=1,
        why="change log: FT-279",
    )
    e.replace(WRITE_LOG, WRITE_LOG + WRAPPED, count=1,
              why="FT-279: add Write-GGWrapped after Write-Log")
    e.replace(
        "                        $r = Apply-Setting -Setting $s\n"
        "                        Write-Host \"  INSTRUCTIONS: $r\" -ForegroundColor Yellow\n",
        "                        $r = Apply-Setting -Setting $s\n"
        "                        Write-GGWrapped -Text \"INSTRUCTIONS: $r\" -Color Yellow   # FT-279\n",
        count=1,
        why="FT-279: hand-steps wrap instead of running off the edge",
    )
    e.replace(
        "                    Write-Host \"  You selected this item, so Checkup is applying it now.\" -ForegroundColor Cyan\n"
        "                    Write-Host \"  Applying...\" -ForegroundColor Cyan\n"
        "                    $result = Apply-Setting -Setting $s\n"
        "                    $resultColor = if ($result -match \"GOOD|enabled|disabled|set to|Already\") { \"Green\" } elseif ($result -match \"NOTE:|MANUAL|manual\") { \"Yellow\" } else { \"Red\" }\n"
        "                    Write-Host \"\"\n"
        "                    Write-Host \"  Result: $result\" -ForegroundColor $resultColor\n",
        "                    # FT-279 (ascii45): no promise before the outcome is known --\n"
        "                    # 11-15 are put off to their own review and 6 can be blocked.\n"
        "                    Write-Host \"  Working on this item...\" -ForegroundColor Cyan\n"
        "                    $result = Apply-Setting -Setting $s\n"
        "                    $resultColor = if ($result -match \"GOOD|enabled|disabled|set to|Already\") { \"Green\" } elseif ($result -match \"NOTE:|MANUAL|manual\") { \"Yellow\" } elseif ($result -match \"Saved for your individual review\") { \"Cyan\" } else { \"Red\" }\n"
        "                    Write-Host \"\"\n"
        "                    Write-GGWrapped -Text \"Result: $result\" -Color $resultColor\n",
        count=1,
        why="FT-279: 'Working on this item', honest colour for put-off items, wrapped result",
    )
print("A5 applied")
