# =====================================================================
# FILE:    Check-ChecklistClaims-2026-08-28.ps1
# PURPOSE: Verify the FT claims in a checklist or triage document against
#          the build source.
#
#          Written 2026-08-28 after three rows of the ascii43 FT table were
#          found wrong and two FT numbers were found to be invented. Bill:
#          "how do we know there aren't more false FTs or more errors
#          waiting to be found. Are there checks you can do?"
#
# WHAT IT CAN PROVE MECHANICALLY:
#   1. Every FT cited in the document EXISTS in the build source.
#      An FT that exists nowhere was invented. That is a hard failure.
#   2. Every screen number cited exists in $script:GGScreenLabels.
#   3. Which function each FT lives in -- so two FTs sharing a function
#      are visible at a glance. That is the trap that produced the
#      FT-219 / FT-221 mix-up.
#
# WHAT IT CANNOT PROVE, AND WILL NOT PRETEND TO:
#   Whether the document's DESCRIPTION of an FT matches what the FT
#   actually does. That is a judgement. So instead of guessing, it prints
#   the source comment beside the citation, so a human compares them in
#   one pass instead of running twelve greps.
#
# READ-ONLY. Reads two files and writes one report into Test_Results.
# DOES NOT NEED ADMINISTRATOR.
# =====================================================================

param(
    [string]$Doc,
    [string]$Build
)

$ErrorActionPreference = 'Continue'
$root = Split-Path $PSScriptRoot -Parent

if (-not $Doc) {
    $Doc = Get-ChildItem (Join-Path $root 'ProjectDocs') -Filter 'GatewayGuard_FieldChecklist-ascii*.md' |
           Sort-Object Name -Descending | Select-Object -First 1 -ExpandProperty FullName
}
if (-not $Build) {
    $Build = Get-ChildItem (Join-Path $root 'Tool') -Filter 'W11-SecurityHardening-v3-*.ps1' |
             Sort-Object Name -Descending | Select-Object -First 1 -ExpandProperty FullName
}

$stamp   = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$outDir  = Join-Path $root 'Test_Results'
$outFile = Join-Path $outDir "ChecklistClaims-$stamp.txt"

$out = New-Object System.Collections.Generic.List[string]
function W([string]$s) { $out.Add($s); Write-Host $s }

W ("=" * 74)
W "  CHECKLIST CLAIMS CHECK -- do the FTs cited actually exist?"
W ("=" * 74)
W ("  document : " + (Split-Path $Doc -Leaf))
W ("  build    : " + (Split-Path $Build -Leaf))
W ("  run at   : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
W ""

if (-not (Test-Path $Doc))   { W "  ERROR: document not found."; $out | Set-Content $outFile -Encoding UTF8; exit 1 }
if (-not (Test-Path $Build)) { W "  ERROR: build not found.";    $out | Set-Content $outFile -Encoding UTF8; exit 1 }

$docLines   = Get-Content $Doc
$buildLines = Get-Content $Build

# --- function index, for "which function does this FT live in" ---------
$funcs = @()
for ($i = 0; $i -lt $buildLines.Count; $i++) {
    if ($buildLines[$i] -match '^function\s+([A-Za-z0-9-]+)') {
        $funcs += [pscustomobject]@{ Line = $i + 1; Name = $Matches[1] }
    }
}
function Get-FuncAt([int]$ln) {
    $f = '<top-level>'
    foreach ($x in $funcs) { if ($x.Line -le $ln) { $f = $x.Name } else { break } }
    return $f
}

# --- screen label table -----------------------------------------------
$labels = @{}
foreach ($l in $buildLines) {
    if ($l -match '^\s*"(\d+)"\s*=\s*"([0-9a-z]*)"') { $labels[$Matches[1]] = $Matches[2] }
}
$validShown = @($labels.Values | Where-Object { $_ }) + @('none')

# --- every FT cited in the document ------------------------------------
$cited = @{}
for ($i = 0; $i -lt $docLines.Count; $i++) {
    foreach ($m in [regex]::Matches($docLines[$i], 'FT-(\d+[a-z]?)')) {
        $k = 'FT-' + $m.Groups[1].Value
        if (-not $cited.ContainsKey($k)) { $cited[$k] = @() }
        $cited[$k] += ($i + 1)
    }
}

# --- every FT present in the build -------------------------------------
$inBuild = @{}
for ($i = 0; $i -lt $buildLines.Count; $i++) {
    foreach ($m in [regex]::Matches($buildLines[$i], 'FT-(\d+[a-z]?)')) {
        $k = 'FT-' + $m.Groups[1].Value
        if (-not $inBuild.ContainsKey($k)) { $inBuild[$k] = @() }
        $inBuild[$k] += ($i + 1)
    }
}

W ("-" * 74)
W "  1. INVENTED FTs -- cited in the document, present NOWHERE in the build"
W ("-" * 74)
# Absent from the build is NOT proof of invention -- a finding that was
# never built is legitimately absent. The discriminator is whether any
# OTHER project document knows the number. A real finding was triaged
# somewhere; an invented one exists only in the document under test.
$notInBuild = @($cited.Keys | Where-Object { -not $inBuild.ContainsKey($_) } | Sort-Object)
$docName    = Split-Path $Doc -Leaf
$corpus     = Get-ChildItem (Join-Path $root 'ProjectDocs') -Filter '*.md' -EA SilentlyContinue |
              Where-Object { $_.Name -ne $docName }

$elsewhere = @{}
foreach ($f in $corpus) {
    $txt = Get-Content $f.FullName -Raw -EA SilentlyContinue
    if (-not $txt) { continue }
    foreach ($k in $notInBuild) {
        if (-not $elsewhere.ContainsKey($k)) { $elsewhere[$k] = @() }
        if ($txt -match ('\b' + [regex]::Escape($k) + '\b')) { $elsewhere[$k] += $f.Name }
    }
}

# A citation that is ITSELF the correction -- "FT-224b does not exist" --
# must not fail the gate forever. Same idea as gate 24's "# GATE24-OK:".
# Suppressed only when EVERY line citing it says so.
# Markdown wraps, so the retraction is often on the NEXT line, not the one
# carrying the number. Check a small window either side. Found by this gate
# failing on its own document's correction note, 2026-08-28.
function Test-Retracted([string]$k) {
    $hits = @($cited[$k])
    if ($hits.Count -eq 0) { return $false }
    foreach ($n in $hits) {
        $lo = [Math]::Max(0, $n - 3)
        $hi = [Math]::Min($docLines.Count - 1, $n + 1)
        $window = ($docLines[$lo..$hi] -join ' ')
        if ($window -notmatch '(?i)does not exist|do not exist|invented|do not cite|no FT number') {
            return $false          # one bare citation is enough to fail
        }
    }
    return $true
}

$invented   = @($notInBuild | Where-Object { $elsewhere[$_].Count -eq 0 -and -not (Test-Retracted $_) })
$retracted  = @($notInBuild | Where-Object { $elsewhere[$_].Count -eq 0 -and (Test-Retracted $_) })
$notBuiltOk = @($notInBuild | Where-Object { $elsewhere[$_].Count -gt 0 })
if ($retracted.Count -gt 0) {
    W ("    retracted in-document (not failed) : " + ($retracted -join ', '))
}

W ("    cited but absent from the build : " + $notInBuild.Count)
W ("    of those, known to other docs   : " + $notBuiltOk.Count + "   <- legitimate 'not built' findings")
W ("    of those, known NOWHERE ELSE    : " + $invented.Count + "   <- INVENTED")
W ""
if ($invented.Count -eq 0) {
    W "    PASS -- every FT cited is corroborated by the build or another document."
} else {
    W "    *** FAIL. These numbers exist only in this document. ***"
    W "    Bill would cite them in a finding and nobody could resolve them."
    W ""
    foreach ($k in $invented) {
        W ("      " + $k + "   at document line(s): " + (($cited[$k] | Select-Object -First 6) -join ', '))
    }
}
W ""
W ("    (The " + $notBuiltOk.Count + " legitimate ones are listed here for completeness:)")
foreach ($k in $notBuiltOk) {
    W ("      " + $k + "   also in: " + (($elsewhere[$k] | Select-Object -First 2) -join ', '))
}
W ""

W ("-" * 74)
W "  2. SHARED FUNCTIONS -- two FTs in one function is where descriptions swap"
W ("-" * 74)
$byFunc = @{}
foreach ($k in ($inBuild.Keys | Where-Object { $cited.ContainsKey($_) })) {
    foreach ($ln in $inBuild[$k]) {
        $f = Get-FuncAt $ln
        if ($f -eq '<top-level>') { continue }
        if (-not $byFunc.ContainsKey($f)) { $byFunc[$f] = @{} }
        $byFunc[$f][$k] = $true
    }
}
$shared = @($byFunc.Keys | Where-Object { $byFunc[$_].Keys.Count -gt 1 } | Sort-Object)
if ($shared.Count -eq 0) { W "    none." }
foreach ($f in $shared) {
    W ("    " + $f + "  ->  " + (($byFunc[$f].Keys | Sort-Object) -join ', '))
}
W ""
W "    These share a function and may do UNRELATED jobs. FT-219 and FT-221"
W "    are the case that earned this section: one is a permission rule, the"
W "    other a password-manager safety guard. Read both comments in full."
W ""

W ("-" * 74)
W "  3. SCREEN NUMBERS CITED -- do they exist in the label table?"
W ("-" * 74)
$badScreens = @()
foreach ($l in $docLines) {
    foreach ($m in [regex]::Matches($l, '\*\*(\d{1,2}[a-e]?)\s*(?:/\s*\d{1,2}[a-e]?)?\*\*')) {
        $v = $m.Groups[1].Value
        if ($v -notin $validShown) { $badScreens += $v }
    }
}
$badScreens = @($badScreens | Sort-Object -Unique)
W ("    screen labels defined in the build : " + $validShown.Count)
if ($badScreens.Count -eq 0) {
    W "    every bolded screen-like number in the document resolves. "
} else {
    W ("    NOT in the label table: " + ($badScreens -join ', '))
    W "    (Some will be item numbers or key presses, not screens -- eyeball these.)"
}
W ""

W ("-" * 74)
W "  4. THE SOURCE COMMENT FOR EVERY CITED FT -- compare against the document"
W ("-" * 74)
W "    This is the part no machine can judge. Read each one against what the"
W "    document says it does. Three rows were wrong on 2026-08-28 and every"
W "    one of them would have died here."
W ""
foreach ($k in ($cited.Keys | Sort-Object { [int]($_ -replace 'FT-|[a-z]', '') })) {
    if (-not $inBuild.ContainsKey($k)) {
        W ("    " + $k + " -- NOT IN BUILD (see section 1)")
        W ""
        continue
    }
    $ln = $inBuild[$k][0]
    W ("    " + $k + "   line " + $ln + "   in " + (Get-FuncAt $ln))
    for ($j = $ln - 1; $j -lt [Math]::Min($ln + 4, $buildLines.Count); $j++) {
        $t = ($buildLines[$j] -replace '^\s*#\s?', '').TrimEnd()
        if ($t.Length -gt 96) { $t = $t.Substring(0, 96) + '...' }
        if ($t.Trim()) { W ("        " + $t) }
    }
    W ""
}

W ("=" * 74)
W "  DONE -- read-only, nothing was changed."
W ("=" * 74)

if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force | Out-Null }
$out | Set-Content -Path $outFile -Encoding UTF8
Write-Host ""
Write-Host ("  Report written to: " + $outFile)
