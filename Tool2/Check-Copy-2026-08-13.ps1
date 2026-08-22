# Dated: 2026-08-13 10:18 ET
# FILE:    Check-Copy-2026-08-13.ps1
# Editor:  Claude Code (CGDELL)
#
# GATE 25 -- THE COPY GATE. Mechanical enforcement of the plain-language rules.
#
# READ-ONLY. Parses text and prints findings. Changes nothing.
#
# WHY THIS EXISTS
# ---------------
# ascii39 field finding 12: "Is there a free app, maybe grammarly or word that
# can check all of these kind of things before we publish?"
#
# No, and that is the point. Grammarly and Word check grammar. They cannot
# check "whether", "switch" as a verb for a setting, "GatewayGuard Checkup"
# more than once per page, unverified superlatives, or the open-source ban --
# and those are the rules this project actually breaks. On 2026-08-13 a
# 30-line matcher found 18 breaches across 19 pages in about a second, and
# separately found 7 open-source references in a document the briefing
# recorded as having 3.
#
# It checks the TOOL and the WEBSITE in one pass, which is the whole point:
# RULE W-07 exists because the two drift apart, and on 2026-08-13 they did --
# the website's "single most common scam" claim was corrected and sourced
# while the build still says the old thing.
#
# WHAT IT DOES NOT DO
# -------------------
# It cannot judge meaning. H-4 -- naming the guide section a page's wording
# came from -- is still a human gate and still the only one that protects
# meaning.
#
# SUPPRESSION
# -----------
# A deliberate, defensible use is marked on the SAME line:
#     ... open-source ...   <!-- COPYCHECK-OK: describes Bitwarden, not us -->
#     "...switch..."        # COPYCHECK-OK: the noun, the control on screen
# Mirrors gate 24's "# GATE24-OK:".

[CmdletBinding()]
param(
    [string[]]$Path,
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

if (-not $Path -or $Path.Count -eq 0) {
    $Path = @(
        (Join-Path $root 'WebSite\html')
        (Join-Path $root 'Tool')
    )
}

# Governing documents STATE the rules, so they contain every banned word by
# design. Scanning them reports the rulebook as a violation -- which is the
# V-6 error, and it is how a "0 remaining" check gets taught to be ignored.
$excludeName = @(
    'GatewayGuard_ProjectInstructions-*', 'GatewayGuard_CodingStandards-*',
    'GatewayGuard_WebsiteStandards-*', 'GatewayGuard_DefectPreventionPlaybook-*',
    'CLAUDE*.md', 'website-copy*.md', '_READ-FIRST-Briefing-*',
    'GatewayGuard_SessionLog-*', 'GatewayGuard_FieldTestPlan-*',
    'GatewayGuard_TestHistory-*', 'GatewayGuard_ScreenContents-*',
    'GatewayGuard_NamingStandard-*', 'GatewayGuard_SyncPlan-*',
    'GatewayGuard_SyncSetupSteps-*', 'GatewayGuard_MarketingSourcePack-*',
    'GatewayGuard_ProjectPanelSnapshot-*', 'Check-Copy-*'
)

# name, regex, rule, note
$RULES = @(
    @{ Name = 'whether';       Rx = '\bwhether\b';                 Rule = 'PL-1'; Note = 'hedges -- use "if"' }
    @{ Name = 'whereas';       Rx = '\bwhereas\b';                 Rule = 'PL-1'; Note = 'legalistic' }
    @{ Name = 'switch-as-verb';Rx = '\bswitch(es|ed|ing)?\s+(it|them|this|that|the\s+\w+\s+|\w+\s+)?(on|off)\b';
                                                                   Rule = 'PL-2'; Note = 'use turn on/off. The NOUN is allowed' }
    @{ Name = 'open-source';   Rx = 'open[\s\-]?source';           Rule = 'ACCURACY NOTE'; Note = 'repo is private -- source-visible / fully auditable' }
    @{ Name = 'superlative';   Rx = '\b(most|everyone|no one else|the only|always)\b';
                                                                   Rule = 'PL-4'; Note = 'needs a named source, or soften' }
    @{ Name = 'assisted-live'; Rx = '(?<!planned[^.]{0,40})\bassisted session';
                                                                   Rule = 'BUSINESS MODEL'; Note = 'must read planned/roadmap' }
)

function Get-Body {
    param([string]$File)
    $raw = Get-Content -LiteralPath $File -Raw -ErrorAction Stop
    if ($File -match '\.html?$') {
        # Change-history comments legitimately quote old wording while
        # describing its removal. Matching them is the V-6 error.
        #
        # But a suppression marker is ALSO written as an HTML comment, so
        # stripping comments outright deletes the very thing the suppression
        # check is looking for -- and the marker silently does nothing. A
        # comment carrying the marker therefore leaves a sentinel behind on
        # the same line, and every other comment still vanishes.
        $raw = [regex]::Replace($raw, '(?s)<!--(.*?)-->', {
            param($m)
            if ($m.Groups[1].Value -match 'COPYCHECK-OK') { ' COPYCHECK-OK ' } else { ' ' }
        })
        $raw = [regex]::Replace($raw, '(?s)<script.*?</script>', ' ')
        $raw = [regex]::Replace($raw, '(?s)<style.*?</style>', ' ')
        # Tags become a single space, not nothing -- otherwise words fuse.
        $raw = [regex]::Replace($raw, '<[^>]+>', ' ')
        # ...but then collapse runs, or "<b>GatewayGuard</b> Checkup" becomes
        # a double space and a two-word match silently misses it. Measured
        # 2026-08-13: that exact bug undercounted the name rule 19 -> 3.
        $raw = [regex]::Replace($raw, '[ \t]+', ' ')
    }
    return $raw
}

$files = @()
foreach ($p in $Path) {
    if (Test-Path -LiteralPath $p -PathType Container) {
        $files += Get-ChildItem -LiteralPath $p -Recurse -File -Include *.html, *.htm, *.md, *.ps1 -ErrorAction SilentlyContinue
    } elseif (Test-Path -LiteralPath $p) {
        $files += Get-Item -LiteralPath $p
    }
}
$files = $files | Where-Object {
    $n = $_.Name; -not ($excludeName | Where-Object { $n -like $_ })
} | Sort-Object FullName -Unique

Write-Host ""
Write-Host "============================================================"
Write-Host " GATE 25 -- COPY CHECK"
Write-Host " Run: $(Get-Date -Format 'yyyy-MM-dd HH:mm') ET"
Write-Host " Files: $($files.Count)"
Write-Host "============================================================"

# V-2: prove every matcher fires on a control that MUST match, before any
# zero from it is believed. An absence produced by a broken matcher looks
# exactly like a clean build.
$control = "whether whereas switch it off open-source most everyone assisted session"
$badRx = @()
foreach ($r in $RULES) {
    if ($control -notmatch $r.Rx) { $badRx += $r.Name }
}
if ($badRx.Count -gt 0) {
    Write-Host ""
    Write-Host "  CONTROL FAILED for: $($badRx -join ', ')" -ForegroundColor Red
    Write-Host "  A matcher that cannot match its own control proves nothing."
    Write-Host "  No result below is valid. Fix the pattern first."
    exit 2
}
Write-Host "  V-2 control: all $($RULES.Count) matchers fire. Results are meaningful."

$findings = @()
$nameIssues = @()

foreach ($f in $files) {
    try { $body = Get-Body -File $f.FullName } catch { continue }
    $lines = $body -split "`n"

    foreach ($r in $RULES) {
        $mm = [regex]::Matches($body, $r.Rx, 'IgnoreCase')
        foreach ($m in $mm) {
            # Which line, so the suppression marker can be found on it.
            $upto = $body.Substring(0, $m.Index)
            $lineNo = ($upto -split "`n").Count
            $line = if ($lineNo -le $lines.Count) { $lines[$lineNo - 1] } else { '' }
            if ($line -match 'COPYCHECK-OK') { continue }

            $a = [Math]::Max(0, $m.Index - 55)
            $len = [Math]::Min(130, $body.Length - $a)
            $ctx = ($body.Substring($a, $len) -replace '\s+', ' ').Trim()

            $findings += [pscustomobject]@{
                File = $f.Name; Line = $lineNo; Rule = $r.Rule
                Check = $r.Name; Note = $r.Note; Context = $ctx
            }
        }
    }

    # CHECKUP NAME RULE -- the full name exactly once per page, and never
    # "Checkup" before it has appeared.
    #
    # $body has already had tags removed, so it is what the READER sees. That
    # distinction is the whole check: a full name sitting in a <meta
    # description> attribute satisfies a raw text search and satisfies nothing
    # for the reader. Measured 2026-08-13 -- 15 of the 19 guide pages were in
    # exactly that state, and a raw grep called all 19 compliant.
    if ($f.Extension -match 'html?') {
        $rawAll  = Get-Content -LiteralPath $f.FullName -Raw
        $fullVis = ([regex]::Matches($body,   'GatewayGuard Checkup')).Count
        $fullAny = ([regex]::Matches($rawAll, 'GatewayGuard Checkup')).Count
        $bare    = ([regex]::Matches($body,   '(?<!GatewayGuard )\bCheckup\b')).Count

        $issue = $null
        if ($fullVis -eq 0 -and $bare -gt 0) {
            $issue = if ($fullAny -gt 0) {
                'full name ONLY in metadata -- the reader never sees it introduced'
            } else {
                'full name never appears at all'
            }
        } elseif ($fullVis -gt 1) {
            $issue = "full name appears $fullVis times in visible copy, max 1"
        }

        if ($issue) {
            $nameIssues += [pscustomobject]@{
                File = $f.Name; Full = $fullVis; Bare = $bare; Issue = $issue
            }
        }
    }
}

Write-Host ""
if ($findings.Count -eq 0 -and $nameIssues.Count -eq 0) {
    Write-Host "GATE 25: PASS -- no copy-rule breaches found." -ForegroundColor Green
    exit 0
}

if ($findings.Count -gt 0) {
    Write-Host "BREACHES BY RULE"
    Write-Host "----------------"
    foreach ($g in ($findings | Group-Object Check | Sort-Object Count -Descending)) {
        Write-Host ("  {0,4}  {1,-16} {2}" -f $g.Count, $g.Name, $g.Group[0].Note)
    }
    if (-not $Quiet) {
        Write-Host ""
        Write-Host "DETAIL"
        Write-Host "------"
        foreach ($g in ($findings | Group-Object File | Sort-Object Name)) {
            Write-Host ""
            Write-Host ("  {0}" -f $g.Name)
            foreach ($x in $g.Group) {
                Write-Host ("    line {0,-5} [{1}] {2}" -f $x.Line, $x.Rule, $x.Check)
                Write-Host ("       > ...{0}..." -f $x.Context)
            }
        }
    }
}

if ($nameIssues.Count -gt 0) {
    Write-Host ""
    Write-Host "CHECKUP NAME RULE"
    Write-Host "-----------------"
    foreach ($n in $nameIssues) {
        Write-Host ("  {0,-32} full:{1} bare:{2}  -- {3}" -f $n.File, $n.Full, $n.Bare, $n.Issue)
    }
}

Write-Host ""
Write-Host ("GATE 25: FAIL -- {0} breach(es) in {1} file(s), {2} name-rule issue(s)." -f `
    $findings.Count, ($findings | Select-Object -Expand File -Unique).Count, $nameIssues.Count) -ForegroundColor Red
Write-Host ""
Write-Host "  A deliberate use is marked on the SAME line with COPYCHECK-OK:"
Write-Host "     <!-- COPYCHECK-OK: describes Bitwarden, not GatewayGuard -->"
Write-Host ""
Write-Host "  This gate cannot judge meaning. H-4 -- naming the guide section"
Write-Host "  a page's wording came from -- is still yours to run."
exit 1
