# Dated: 2026-08-15 13:10 EDT
# File: Get-ScreenInventory-2026-08-15.ps1
# Launcher: Run-ScreenInventory.bat
#
#  WHAT THIS IS: the raw material for the FT-172 screen-number table.
#
#  Bill's requirement, 2026-08-15: "each screen must have a unique number so
#  when a user refers to it we know exactly which screen he is talking about."
#  Numbers run 1..X across the whole program, assigned at BUILD time from the
#  viewing order, continuing straight through every branch. Exactly one
#  screen 6 exists in a build.
#
#  WHY A SCRIPT AND NOT A HAND-TYPED LIST. A table typed by hand is a second
#  copy of the truth, and this project's whole defect record is second copies
#  going stale. This reads the build's own source through the AST, so the
#  inventory cannot drift from the screens that actually exist. The ORDER
#  still has to be decided by a human -- source order is not viewing order --
#  but the SET of screens, their IDs and their branch conditions are measured.
#
#  READ-ONLY. It parses the .ps1 and writes one report. It changes nothing,
#  and it does not touch the build.
#
#  DOES NOT NEED ADMINISTRATOR.
#
#  WHAT IT FINDS, and the last column is the point:
#    * every Draw-Box screen, with its stable ScreenId
#    * every screen painted some OTHER way -- these are the ones the current
#      counter has never seen, and they are why Bill's field numbers read low
#    * whether each screen sits inside an if/switch, i.e. is a branch screen
#    * the enclosing function, which is the unit the viewing order is built from
#
#  -NoPause skips the closing wait so a build script can call it.

param([switch]$NoPause)

$ErrorActionPreference = "Stop"
Set-Location -Path $PSScriptRoot

# FT-264 (2026-09-17): searched $PSScriptRoot (Tool2\), which has held no
# build .ps1 since the 2026-08-22 Tool/Tool2 split -- Get-ChildItem returned
# nothing, so ParseFile got a null path and reported "1 error(s)", not zero
# screens. The four launchers the split explicitly fixed did not include
# this one. Build lives in ..\Tool\.
$ggBuild = Get-ChildItem -Path (Join-Path $PSScriptRoot "..\Tool") -Filter "W11-SecurityHardening-v3-*.ps1" |
           Sort-Object LastWriteTime -Descending | Select-Object -First 1

$ggOut = Join-Path $PSScriptRoot ("..\Test_Results\ScreenInventory-" +
         ($ggBuild.BaseName -replace '^W11-SecurityHardening-v3-', '') + ".txt")

$ggLines = New-Object System.Collections.Generic.List[string]
function Say { param([string]$Text = "") ; Write-Host $Text ; $ggLines.Add($Text) }

$ggErr = $null; $ggTok = $null
$ggAst = [System.Management.Automation.Language.Parser]::ParseFile($ggBuild.FullName, [ref]$ggTok, [ref]$ggErr)
if ($ggErr -and $ggErr.Count -gt 0) {
    Write-Host "STOP: the build does not parse ($($ggErr.Count) error(s))."
    exit 1
}

Say "============================================================"
Say " SCREEN INVENTORY -- raw material for the FT-172 table"
Say " Build : $($ggBuild.Name)"
Say " Run   : $(Get-Date -Format 'yyyy-MM-dd HH:mm') ET"
Say " READ-ONLY. Nothing was changed."
Say "============================================================"
Say ""

# -- helpers ---------------------------------------------------------------
function Get-Enclosing {
    param($Node, [string]$Type)
    $p = $Node.Parent
    while ($null -ne $p) {
        if ($Type -eq 'Function' -and $p -is [System.Management.Automation.Language.FunctionDefinitionAst]) { return $p.Name }
        if ($Type -eq 'Branch' -and (
                $p -is [System.Management.Automation.Language.IfStatementAst] -or
                $p -is [System.Management.Automation.Language.SwitchStatementAst])) { return $true }
        $p = $p.Parent
    }
    if ($Type -eq 'Branch') { return $false }
    return "(top level)"
}

function Get-ArgValue {
    param($CommandAst, [string]$Name)
    $els = $CommandAst.CommandElements
    for ($i = 0; $i -lt $els.Count - 1; $i++) {
        if ($els[$i] -is [System.Management.Automation.Language.CommandParameterAst] -and
            $els[$i].ParameterName -eq $Name) {
            $v = $els[$i + 1]
            if ($v -is [System.Management.Automation.Language.StringConstantExpressionAst]) { return $v.Value }
            return "(expression)"
        }
    }
    return ""
}

# -- 1. every screen-painting call ----------------------------------------
$ggPainters = @('Draw-Box', 'Write-GGBox', 'Write-GalleryBox')
$ggRows = New-Object System.Collections.Generic.List[object]

foreach ($c in $ggAst.FindAll({ param($n) $n -is [System.Management.Automation.Language.CommandAst] }, $true)) {
    $name = $c.GetCommandName()
    if ($ggPainters -notcontains $name) { continue }
    $ggRows.Add([PSCustomObject]@{
        Line     = $c.Extent.StartLineNumber
        Painter  = $name
        ScreenId = (Get-ArgValue -CommandAst $c -Name 'ScreenId')
        Function = (Get-Enclosing -Node $c -Type 'Function')
        Branch   = (Get-Enclosing -Node $c -Type 'Branch')
    })
}

$ggRows = $ggRows | Sort-Object Line

Say "SCREENS PAINTED THROUGH A BOX FUNCTION"
Say "--------------------------------------"
Say ("  {0,-6} {1,-16} {2,-8} {3,-8} {4}" -f "line", "painter", "id", "branch?", "function")
foreach ($r in $ggRows) {
    Say ("  {0,-6} {1,-16} {2,-8} {3,-8} {4}" -f $r.Line, $r.Painter,
         $(if ($r.ScreenId) { $r.ScreenId } else { "--" }),
         $(if ($r.Branch) { "BRANCH" } else { "main" }), $r.Function)
}
Say ""
Say ("  total box screens : " + $ggRows.Count)
Say ("  branch screens    : " + (@($ggRows | Where-Object Branch).Count))
Say ("  main-line screens : " + (@($ggRows | Where-Object { -not $_.Branch }).Count))
Say ("  with no ScreenId  : " + (@($ggRows | Where-Object { -not $_.ScreenId }).Count))
Say ""

# -- 2. THE ONES THE COUNTER HAS NEVER SEEN -------------------------------
# A screen the user reads but that never reaches Draw-Box does not increment
# Get-ScreenNumber. Every screen after it then reads LOW by one, permanently.
# That is the mechanism behind field findings 3, 4, 6, 7 and 9 -- "Scr 3 ->
# 4 of 6" is a constant offset, not a random misnumbering.
Say "SCREENS THE COUNTER CANNOT SEE -- hand-typed 'N of M' in screen text"
Say "-------------------------------------------------------------------"
Say "  These carry a number the author typed. It cannot agree with a counted"
Say "  number except by luck, and it is what the user actually reads."
Say ""
$ggSrc = Get-Content -LiteralPath $ggBuild.FullName
$ggTyped = 0
for ($i = 0; $i -lt $ggSrc.Count; $i++) {
    $ln = $ggSrc[$i]
    if ($ln -match '^\s*#') { continue }
    if ($ln -match '"[^"]*\b(Screen|page|PAGE)\s+\d+\s+of\s+\d+') {
        $ggTyped++
        Say ("  line {0,-6} {1}" -f ($i + 1), $ln.Trim())
    }
}
Say ""
Say ("  hand-typed screen numbers in user-visible text : " + $ggTyped)
Say ""

# -- 3. what the table must cover -----------------------------------------
Say "WHAT THE TABLE MUST COVER"
Say "-------------------------"
Say "  Every row above needs exactly one number, 1..X, in viewing order."
Say "  The SET is measured here. The ORDER is a human decision and cannot be"
Say "  read off the file, because functions are DEFINED in one order and"
Say "  CALLED in another. Source order is not viewing order."
Say ""
Say "  So the next step is walking the call flow from the entry point, not"
Say "  reading this list top to bottom. This list is what that walk must"
Say "  account for -- if the walk misses a row here, the walk is wrong."
Say ""

$ggFns = ($ggRows | Group-Object Function | Sort-Object Name)
Say "SCREENS PER FUNCTION -- the unit the viewing order is assembled from"
Say "-------------------------------------------------------------------"
foreach ($g in $ggFns) {
    $ids = ($g.Group | ForEach-Object { if ($_.ScreenId) { $_.ScreenId } else { "--" } }) -join ", "
    Say ("  {0,-34} {1,2} screen(s)  ids: {2}" -f $g.Name, $g.Count, $ids)
}
Say ""
Say "============================================================"
Say " Nothing was changed. This is input to a decision, not a decision."
Say "============================================================"

$ggLines -join "`r`n" | Out-File -FilePath $ggOut -Encoding ASCII
Write-Host ""
Write-Host "  Report written to: $ggOut"
if (-not $NoPause) {
    Write-Host ""
    Write-Host "  Press Enter to close this window."
    $null = Read-Host
}
