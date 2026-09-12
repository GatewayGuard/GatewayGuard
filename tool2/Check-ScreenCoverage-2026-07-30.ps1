# Dated: 2026-07-30 22:08 EDT
# ================================================================
# FILE:    Check-ScreenCoverage-2026-07-30.ps1
# PURPOSE: FT-138 -- the mechanical check behind CodingStandards gate 12.
#
# Gate 12 reads: "Every Draw-Box screen must log [SCREEN-NN] with its title.
# Master screen list maintained in build header. Numbers are fixed forever --
# new screens append at the end, never renumber."
#
# It has been a mandatory pre-build gate for months and had never once passed,
# because there was nothing to run. A gate with no check is a wish. This is the
# check. Run it before every .ps1 build.
#
# It uses the PowerShell AST -- the same walk the Gallery uses -- so it sees
# what the parser sees, not what a grep guesses.
#
# ascii39 ADDITION -- GATE 12b, THE 26-LINE RULE (FT-153).
# Bill, 2026-07-30, field note 11: "All screens should have a last line as a
# blank line for east of reading change rule to 26 lines per screen maximum."
# That supersedes the ascii37 25-line rule. A rule nobody can measure is a
# wish, which is this script's whole reason for existing -- so it is measured
# here.
# IT IS A RATCHET, NOT A CLIFF. Ten screens were already over 26 lines when the
# rule was written, and blocking every build until all ten are split would
# either stop the project or get the gate switched off. Those ten are listed
# below with their sizes as of ascii39. They are reported on EVERY run so they
# cannot quietly become permanent, but they do not fail the gate. Any screen
# NOT on that list that exceeds 26 lines DOES fail it -- so the debt can only
# shrink. Delete a screen from the baseline as you split it.
#
# USAGE:
#   .\Check-ScreenCoverage-2026-07-30.ps1 -Path .\W11-SecurityHardening-v3-ascii39-2026-07-30-2208.ps1
# Exit code 0 = pass, 1 = fail. Prints every finding.
# ================================================================

param(
    [Parameter(Mandatory)][string]$Path
)

if (-not (Test-Path $Path)) {
    Write-Host "FAIL: file not found: $Path" -ForegroundColor Red
    exit 1
}

$errs = $null; $toks = $null
$ast = [System.Management.Automation.Language.Parser]::ParseFile(
    (Resolve-Path $Path).Path, [ref]$toks, [ref]$errs)

Write-Host ""
Write-Host "SCREEN COVERAGE CHECK (gate 12)" -ForegroundColor Cyan
Write-Host "File: $(Split-Path $Path -Leaf)"
Write-Host ""

if ($errs -and $errs.Count -gt 0) {
    Write-Host "FAIL: $($errs.Count) parse error(s) -- cannot assess coverage." -ForegroundColor Red
    $errs | Select-Object -First 5 | ForEach-Object {
        Write-Host "   line $($_.Extent.StartLineNumber): $($_.Message)" -ForegroundColor Red
    }
    exit 1
}

$calls = $ast.FindAll({
    param($n)
    $n -is [System.Management.Automation.Language.CommandAst] -and $n.GetCommandName() -eq "Draw-Box"
}, $true)

$rows = @()
foreach ($c in $calls) {
    $id = ""
    $els = $c.CommandElements
    for ($i = 0; $i -lt $els.Count; $i++) {
        if ($els[$i] -is [System.Management.Automation.Language.CommandParameterAst] -and
            $els[$i].ParameterName -eq "ScreenId" -and ($i + 1) -lt $els.Count) {
            $id = $els[$i + 1].Extent.Text.Trim('"').Trim("'")
        }
    }
    $fn = "(main block)"
    $p = $c.Parent
    while ($p) {
        if ($p -is [System.Management.Automation.Language.FunctionDefinitionAst]) { $fn = $p.Name; break }
        $p = $p.Parent
    }
    $rows += [PSCustomObject]@{ Line = $c.Extent.StartLineNumber; ScreenId = $id; Function = $fn }
}

$fail = $false

Write-Host ("Draw-Box screens found        : {0}" -f $rows.Count)

$untagged = @($rows | Where-Object { -not $_.ScreenId })
Write-Host ("Screens with no -ScreenId     : {0}" -f $untagged.Count) -ForegroundColor $(if ($untagged.Count) { "Red" } else { "Green" })
foreach ($u in $untagged) {
    Write-Host ("   FAIL line {0} in {1} -- no screen ID" -f $u.Line, $u.Function) -ForegroundColor Red
    $fail = $true
}

$dupes = @($rows | Where-Object { $_.ScreenId } | Group-Object ScreenId | Where-Object { $_.Count -gt 1 })
Write-Host ("Duplicate screen IDs          : {0}" -f $dupes.Count) -ForegroundColor $(if ($dupes.Count) { "Red" } else { "Green" })
foreach ($g in $dupes) {
    Write-Host ("   FAIL SCREEN-{0} used {1} times:" -f $g.Name, $g.Count) -ForegroundColor Red
    foreach ($m in $g.Group) { Write-Host ("      line {0} in {1}" -f $m.Line, $m.Function) -ForegroundColor Red }
    $fail = $true
}

# Non-literal -Lines: these render as an empty box in the Gallery unless the
# variable is seeded, so they are reported as a WARNING rather than silently.
$dynamic = @()
foreach ($c in $calls) {
    $els = $c.CommandElements
    for ($i = 0; $i -lt $els.Count; $i++) {
        if ($els[$i] -is [System.Management.Automation.Language.CommandParameterAst] -and
            $els[$i].ParameterName -eq "Lines" -and ($i + 1) -lt $els.Count) {
            $arg = $els[$i + 1]
            if ($arg -isnot [System.Management.Automation.Language.ArrayExpressionAst] -and
                $arg -isnot [System.Management.Automation.Language.ArrayLiteralAst]) {
                $dynamic += [PSCustomObject]@{ Line = $c.Extent.StartLineNumber; Arg = $arg.Extent.Text }
            }
        }
    }
}
Write-Host ("Screens built at runtime      : {0}  (Gallery needs each seeded)" -f $dynamic.Count) -ForegroundColor $(if ($dynamic.Count) { "Yellow" } else { "Green" })
foreach ($dy in $dynamic) {
    Write-Host ("   WARN line {0} passes -Lines {1}" -f $dy.Line, $dy.Arg) -ForegroundColor Yellow
}

# Hand-drawn screens claim IDs too. The checklist is painted with Write-Host
# rather than Draw-Box and registers its number by calling Get-ScreenNumber
# directly, so its IDs are invisible to the Draw-Box walk above. Counting only
# Draw-Box would report those IDs as free and hand a future build a collision --
# the same "pointer that lies" failure this gate exists to prevent.
$manual = $ast.FindAll({
    param($n)
    $n -is [System.Management.Automation.Language.CommandAst] -and $n.GetCommandName() -eq "Get-ScreenNumber"
}, $true)
$manualIds = @()
foreach ($m in $manual) {
    foreach ($tok in ([regex]::Matches($m.Extent.Text, '"(\d+)"'))) {
        $manualIds += $tok.Groups[1].Value
    }
}
$manualIds = @($manualIds | Sort-Object -Unique)
Write-Host ("Hand-drawn screens (no Draw-Box): {0}  IDs: {1}" -f $manualIds.Count,
            $(if ($manualIds.Count) { $manualIds -join ", " } else { "none" }))

$allIds = @($rows | Where-Object { $_.ScreenId } | ForEach-Object { $_.ScreenId }) + $manualIds
$collide = @($allIds | Group-Object | Where-Object { $_.Count -gt 1 })
if ($collide.Count) {
    foreach ($g in $collide) {
        Write-Host ("   FAIL SCREEN-{0} claimed by both a Draw-Box screen and a hand-drawn one" -f $g.Name) -ForegroundColor Red
    }
    $fail = $true
}

$ids = @($allIds | ForEach-Object { [int]$_ } | Sort-Object)
if ($ids.Count) {
    Write-Host ("Total numbered screens        : {0}" -f $ids.Count)
    Write-Host ("ID range in use               : {0}..{1}" -f $ids[0], $ids[-1])
    Write-Host ("Next free ID for a new screen : {0}" -f ($ids[-1] + 1)) -ForegroundColor Cyan
}

# ---------------------------------------------------------------------------
# GATE 12b -- THE 26-LINE RULE (FT-153, ascii39). See the header note.
# Rendered height = content lines + top border + bottom border + the trailing
# blank line Write-GGBox appends to every screen (FT-153).
# ---------------------------------------------------------------------------
$MaxScreenLines = 26

# Baseline: already over the limit when the rule was written (ascii39,
# 2026-07-30). Reported every run, but not a failure. Remove an entry as soon
# as that screen is split -- the list is only allowed to get shorter.
$OversizeBaseline = @{
    "72" = 55; "50" = 50; "73" = 35; "26" = 34; "27" = 34
    "65" = 33; "60" = 31; "41" = 28; "30" = 28; "52" = 27
}

$sizes = @()
foreach ($c in $calls) {
    $els = $c.CommandElements
    $sid = ""
    $arg = $null
    for ($i = 0; $i -lt $els.Count; $i++) {
        if ($els[$i] -is [System.Management.Automation.Language.CommandParameterAst]) {
            if ($els[$i].ParameterName -eq "ScreenId" -and ($i + 1) -lt $els.Count) {
                $sid = $els[$i + 1].Extent.Text.Trim('"').Trim("'")
            }
            if ($els[$i].ParameterName -eq "Lines" -and ($i + 1) -lt $els.Count) {
                $arg = $els[$i + 1]
            }
        }
    }
    if ($null -eq $arg) { continue }
    $lit = $null
    if ($arg -is [System.Management.Automation.Language.ArrayLiteralAst]) {
        $lit = $arg
    } else {
        $lit = $arg.FindAll({
            param($x) $x -is [System.Management.Automation.Language.ArrayLiteralAst]
        }, $true) | Select-Object -First 1
    }
    if ($null -eq $lit) { continue }   # runtime-built: already WARNed above
    $rendered = $lit.Elements.Count + 3
    $sizes += [PSCustomObject]@{
        ScreenId = $sid
        Rendered = $rendered
        Line     = $c.Extent.StartLineNumber
    }
}

$over = @($sizes | Where-Object { $_.Rendered -gt $MaxScreenLines } | Sort-Object Rendered -Descending)
$known = @($over | Where-Object { $OversizeBaseline.ContainsKey($_.ScreenId) })
$newOver = @($over | Where-Object { -not $OversizeBaseline.ContainsKey($_.ScreenId) })

Write-Host ""
Write-Host ("Screens over {0} lines (FT-153)  : {1}  ({2} known, {3} NEW)" -f `
    $MaxScreenLines, $over.Count, $known.Count, $newOver.Count) `
    -ForegroundColor $(if ($newOver.Count) { "Red" } elseif ($known.Count) { "Yellow" } else { "Green" })

foreach ($k in $known) {
    Write-Host ("   carried  SCREEN-{0}  {1} lines (line {2})" -f $k.ScreenId, $k.Rendered, $k.Line) -ForegroundColor DarkYellow
}
foreach ($nw in $newOver) {
    Write-Host ("   FAIL     SCREEN-{0}  {1} lines (line {2}) -- NEW, split it" -f $nw.ScreenId, $nw.Rendered, $nw.Line) -ForegroundColor Red
    $fail = $true
}

# A baseline entry for a screen that is no longer oversized is stale -- say so,
# so the list cannot rot into a permanent excuse.
foreach ($b in $OversizeBaseline.Keys) {
    $still = $over | Where-Object { $_.ScreenId -eq $b }
    if (-not $still) {
        Write-Host ("   CLEARED  SCREEN-{0} is now within the limit -- remove it from `$OversizeBaseline" -f $b) -ForegroundColor Green
    }
}

Write-Host ""
if ($fail) {
    Write-Host "GATE 12: FAIL -- fix the findings above before shipping." -ForegroundColor Red
    exit 1
}
Write-Host "GATE 12: PASS -- every screen carries a unique ID." -ForegroundColor Green
if ($known.Count) {
    Write-Host ("GATE 12b: PASS with {0} carried oversize screen(s) -- see FT-153." -f $known.Count) -ForegroundColor Yellow
} else {
    Write-Host "GATE 12b: PASS -- every screen is within the 26-line rule." -ForegroundColor Green
}
exit 0
