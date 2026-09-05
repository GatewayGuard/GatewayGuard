# FILE:   Check-RepoBloat-2026-09-04-2159.ps1
# Dated:  2026-09-04 21:59 ET
#
# GATE 26 -- THE SESSION-START REPO REVIEW.
#
# READ-ONLY. It measures and reports. It moves nothing and deletes nothing.
#            No administrator needed.
#
# WHY THIS EXISTS, and it is one specific failure:
#
#   On 2026-09-03, commit 17fc9fa added 665 files in one go -- 402 from
#   Store_TestFiles, 262 from ProjectDocs. 256 of those were a saved PCMag
#   web article and its _files folder, 14.6 MB, dropped straight into the
#   folder Claude Cloud reads. The commit message described Gumroad receipt
#   defects and said nothing about 665 files or a web page. It was a Claude
#   Code session that did it, with a broad git add.
#
#   Nobody noticed for a day, and what noticed was Cloud refusing to sync
#   because project knowledge was full. By then the article was 79% of
#   everything Cloud could see.
#
#   The lesson this project keeps re-learning is that a rule with no check
#   is a wish. So the rule "review and clean out the repo at session start"
#   gets this script, and the script gets run, or the rule will rot like the
#   others did.
#
# WHAT IT REPORTS -- five things, in order of how much trouble they cause:
#
#   1. The size of what Cloud can see, against a budget.
#   2. Files in Cloud's scope that Cloud CANNOT READ -- .docx, .pdf, .pptx,
#      images. They spend the budget and give nothing back.
#   3. Files in Cloud's scope that CURRENT.md does not name. Not proof of
#      anything, but it is where dead weight hides.
#   4. Recent commits that added a lot of files at once. This is the check
#      that would have caught 17fc9fa on the day.
#   5. Folders that look like a saved web page -- a _files directory, which
#      is what a browser's "Save page as" produces.
#
# PS 5.1 COMPATIBLE: -join only, no Join-String, no ternary.

[CmdletBinding()]
param(
    # Cloud's scope. Change these only if the connector scope changes.
    [string[]]$CloudPaths = @('ProjectDocs', 'Tool', 'WebSite/Rules', 'CLAUDE.md'),
    # Budget in KB for everything Cloud can see. 4 MB leaves real headroom.
    [int]$BudgetKB = 4096,
    # A commit adding more than this many files gets reported.
    [int]$BulkAddThreshold = 60,
    # How many recent commits to look back over.
    [int]$LookBack = 40
)

$ErrorActionPreference = 'Continue'

$repo = Split-Path $PSScriptRoot -Parent
Push-Location $repo

$stamp   = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$outDir  = Join-Path $repo 'Test_Results'
if (-not (Test-Path -LiteralPath $outDir)) { $outDir = $PSScriptRoot }
$outFile = Join-Path $outDir ("RepoBloat-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

$log = New-Object System.Collections.Generic.List[string]
function Say([string]$t) { Write-Host $t; $log.Add($t) }

$problems = 0

Say "======================================================================"
Say "  GATE 26 -- SESSION-START REPO REVIEW"
Say "======================================================================"
Say ("  repository : " + $repo)
Say ("  run at     : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Say ""
Say "  READ-ONLY. Nothing is moved, deleted or committed."
Say ""

# ------------------------------------------------- gather the tracked list
$tracked = @(git ls-files)
if ($tracked.Count -eq 0) {
    Say "  Could not read the file list from git. Is this a repository?"
    Pop-Location
    return
}

function Get-SizeKB([string]$p) {
    if (Test-Path -LiteralPath $p -PathType Leaf) {
        return [int]((Get-Item -LiteralPath $p).Length / 1KB)
    }
    return 0
}

function In-CloudScope([string]$p) {
    foreach ($c in $CloudPaths) {
        $n = $c.Replace('\', '/')
        if ($p -eq $n) { return $true }
        if ($p.StartsWith($n + '/')) { return $true }
    }
    return $false
}

$cloudFiles = @($tracked | Where-Object { In-CloudScope $_ })

# ================================================================= 1. SIZE
Say "----------------------------------------------------------------------"
Say "  1. WHAT CLOUD CAN SEE"
Say "----------------------------------------------------------------------"
Say ""

$cloudKB = 0
foreach ($f in $cloudFiles) { $cloudKB += Get-SizeKB $f }

Say ("  scope   : " + ($CloudPaths -join ', '))
Say ("  files   : " + $cloudFiles.Count)
Say ("  size    : " + $cloudKB + " KB")
Say ("  budget  : " + $BudgetKB + " KB")
Say ""

if ($cloudKB -gt $BudgetKB) {
    $problems++
    $pct = [math]::Round(($cloudKB / $BudgetKB) * 100)
    Say ("  OVER BUDGET -- " + $pct + "% of it. Cloud will refuse to sync when")
    Say "  project knowledge fills up. Sections 2 and 3 name the candidates."
} else {
    $pct = [math]::Round(($cloudKB / $BudgetKB) * 100)
    Say ("  Within budget -- " + $pct + "% used.")
}
Say ""

# ====================================================== 2. UNREADABLE FILES
Say "----------------------------------------------------------------------"
Say "  2. IN CLOUD'S SCOPE BUT CLOUD CANNOT READ THEM"
Say "----------------------------------------------------------------------"
Say ""
Say "  Cloud reads text. A .docx or .pdf spends the budget and delivers"
Say "  nothing -- which is why this project generates .md twins."
Say ""

$binExt = @('.docx', '.doc', '.pdf', '.pptx', '.ppt', '.xlsx', '.zip',
            '.png', '.jpg', '.jpeg', '.gif', '.bmp', '.mp4', '.pyc')
$bins = @()
foreach ($f in $cloudFiles) {
    $e = [IO.Path]::GetExtension($f).ToLower()
    if ($binExt -contains $e) {
        $bins += [PSCustomObject]@{ Path = $f; KB = (Get-SizeKB $f) }
    }
}

if ($bins.Count -eq 0) {
    Say "  None. Good."
} else {
    $problems++
    $binKB = 0
    foreach ($b in $bins) { $binKB += $b.KB }
    Say ("  " + $bins.Count + " files, " + $binKB + " KB of unreadable weight:")
    Say ""
    foreach ($b in ($bins | Sort-Object KB -Descending | Select-Object -First 15)) {
        Say ("    " + ([string]$b.KB).PadLeft(6) + " KB  " + $b.Path)
    }
    if ($bins.Count -gt 15) { Say ("    ... and " + ($bins.Count - 15) + " more") }
}
Say ""

# ================================================== 3. NOT NAMED IN CURRENT
Say "----------------------------------------------------------------------"
Say "  3. IN SCOPE, OVER 20 KB, AND CURRENT.md DOES NOT NAME THEM"
Say "----------------------------------------------------------------------"
Say ""
Say "  Not proof of anything -- CURRENT.md does not list every working file."
Say "  It is simply where dead weight hides. Look, decide, move to Archive."
Say ""

$curPath = Join-Path $repo 'ProjectDocs\CURRENT.md'
if (-not (Test-Path -LiteralPath $curPath)) {
    Say "  CURRENT.md not found -- skipping this check."
} else {
    $cur = Get-Content -LiteralPath $curPath -Raw
    $orphans = @()
    foreach ($f in $cloudFiles) {
        $kb = Get-SizeKB $f
        if ($kb -lt 20) { continue }
        $base = Split-Path $f -Leaf
        if ($cur.IndexOf($base, [StringComparison]::OrdinalIgnoreCase) -lt 0) {
            $orphans += [PSCustomObject]@{ Path = $f; KB = $kb }
        }
    }
    if ($orphans.Count -eq 0) {
        Say "  None. Everything sizeable in scope is named in CURRENT.md."
    } else {
        $oKB = 0
        foreach ($o in $orphans) { $oKB += $o.KB }
        Say ("  " + $orphans.Count + " files, " + $oKB + " KB:")
        Say ""
        foreach ($o in ($orphans | Sort-Object KB -Descending | Select-Object -First 20)) {
            Say ("    " + ([string]$o.KB).PadLeft(6) + " KB  " + $o.Path)
        }
        if ($orphans.Count -gt 20) { Say ("    ... and " + ($orphans.Count - 20) + " more") }
    }
}
Say ""

# ======================================================== 4. BULK ADDITIONS
Say "----------------------------------------------------------------------"
Say "  4. COMMITS THAT ADDED A LOT OF FILES AT ONCE"
Say "----------------------------------------------------------------------"
Say ""
Say ("  Anything over " + $BulkAddThreshold + " added files in one commit. This is the check")
Say "  that would have caught the PCMag article on the day it landed."
Say ""

$hashes = @(git log -n $LookBack --format="%h")
$bulk = @()
foreach ($h in $hashes) {
    $added = @(git show --diff-filter=A --name-only --format="" $h) | Where-Object { $_ -ne '' }
    if ($added.Count -gt $BulkAddThreshold) {
        $subj = (git log -1 --format="%s" $h)
        $when = (git log -1 --format="%ad" --date=short $h)
        $bulk += [PSCustomObject]@{ Hash = $h; Count = $added.Count; Date = $when; Subject = $subj }
    }
}

if ($bulk.Count -eq 0) {
    Say ("  None in the last " + $LookBack + " commits.")
} else {
    Say ("  " + $bulk.Count + " found in the last " + $LookBack + " commits:")
    Say ""
    foreach ($b in $bulk) {
        Say ("    " + $b.Hash + "  " + $b.Date + "  " + ([string]$b.Count).PadLeft(4) + " files added")
        Say ("              " + $b.Subject)
    }
    Say ""
    Say "  A commit message that does not account for its own file count is"
    Say "  the warning sign. Check what actually went in."
}
Say ""

# ==================================================== 5. SAVED WEB PAGES
Say "----------------------------------------------------------------------"
Say "  5. SAVED WEB PAGES ANYWHERE IN THE REPOSITORY"
Say "----------------------------------------------------------------------"
Say ""
Say "  A folder ending _files is what a browser's Save Page As produces."
Say "  These are third-party pages. They are never project documents."
Say ""

$saved = @{}
foreach ($f in $tracked) {
    $parts = $f.Split('/')
    foreach ($p in $parts) {
        if ($p -like '*_files') {
            $key = $p
            if (-not $saved.ContainsKey($key)) { $saved[$key] = @{ N = 0; KB = 0; Where = $f } }
            $saved[$key].N++
            $saved[$key].KB += (Get-SizeKB $f)
        }
    }
}

if ($saved.Keys.Count -eq 0) {
    Say "  None tracked. Good."
} else {
    $problems++
    foreach ($k in $saved.Keys) {
        $inScope = 'outside Cloud scope'
        if (In-CloudScope $saved[$k].Where) { $inScope = 'IN CLOUD SCOPE' }
        Say ("  " + $k)
        Say ("    " + $saved[$k].N + " files, " + $saved[$k].KB + " KB -- " + $inScope)
    }
}
Say ""

# ================================================================= VERDICT
Say "======================================================================"
if ($problems -eq 0) {
    Say "  NOTHING TO CLEAN OUT. The repository is in good shape."
} else {
    Say ("  " + $problems + " thing(s) worth acting on. Nothing was changed -- move")
    Say "  anything you retire to Archive with git mv, so it stays in the"
    Say "  repository and stays recoverable."
}
Say "======================================================================"

$log | Set-Content -LiteralPath $outFile -Encoding UTF8
Say ""
Say ("  Saved to: " + $outFile)

Pop-Location
