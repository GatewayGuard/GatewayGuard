# Update-Current.ps1
# Dated: 2026-08-12 17:05 ET
#
# WHAT IT DOES: writes ProjectDocs\CURRENT.md, naming the newest version of
# each governing document.
#
# WHY IT EXISTS: Claude Code can glob a folder and pick the newest by filename
# date. CLAUDE CLOUD CANNOT -- it can neither list a directory nor sort one.
# With five briefings in ProjectDocs it searches by relevance and returns
# whichever ranks highest, then reports that as success. So Cloud is given one
# FIXED filename it can be told, and this script keeps that file honest.
#
# THE FILE IS GENERATED, NEVER TYPED. A hand-written pointer is exactly the
# thing this project has been bitten by -- 15 of 49 filename references had
# gone dead. A pointer that lies is worse than no pointer.
#
# IT REFUSES TO WRITE A LIE: if any pattern below matches nothing, the script
# stops and leaves the existing CURRENT.md alone rather than publishing a file
# with a gap in it.
#
# READ-ONLY except for ProjectDocs\CURRENT.md.
# DOES NOT NEED ADMINISTRATOR.
# EXTERNAL COMMANDS: three read-only git calls for the freshness stamp, each
#   carrying a VERIFIED comment beside it per gate 24. (This header claimed
#   "no external commands" until 2026-08-12, when the stamp was added -- the
#   claim was true when written and false the moment the file changed. A
#   header assertion about a file's own contents decays like any other fact.)
# PS 5.1 COMPATIBLE: -join only, no Join-String, no ternary.

$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projRoot  = Split-Path -Parent $scriptDir
$docs      = Join-Path $projRoot 'ProjectDocs'
$outFile   = Join-Path $docs 'CURRENT.md'
$stamp     = (Get-Date).ToString('yyyy-MM-dd HH:mm')

if (-not (Test-Path -LiteralPath $docs)) {
    Write-Host ""
    Write-Host "  STOPPED. ProjectDocs was not found at:"
    Write-Host ("    " + $docs)
    Write-Host "  Put this script back in the project's Tool folder and run it again."
    Write-Host ""
    return
}

# Each entry: the label Cloud sees, and the filename pattern to resolve.
$wanted = @(
    @{ Label = 'Briefing -- read this first'; Pattern = '_READ-FIRST-Briefing-*.md' },
    @{ Label = 'Session log';                 Pattern = 'GatewayGuard_SessionLog-*.md' },
    @{ Label = 'Project instructions';        Pattern = 'GatewayGuard_ProjectInstructions-2*.md' },
    @{ Label = 'Coding standards';            Pattern = 'GatewayGuard_CodingStandards-*.md' },
    @{ Label = 'Defect prevention playbook';  Pattern = 'GatewayGuard_DefectPreventionPlaybook-*.md' },
    @{ Label = 'Website standards';           Pattern = 'GatewayGuard_WebsiteStandards-*.md' },
    # 'Field test plan' removed 2026-08-22: superseded by 'Field checklist
    # (current build)' below. Its pattern only ever resolved to the ascii40 plan
    # (no 41/42/43 plan was ever written), so the row named a stale build --
    # Cloud flagged it. The checklist row is the live field artifact.
    @{ Label = 'Test history';                Pattern = 'GatewayGuard_TestHistory-*.md' },
    @{ Label = 'Sync plan';                   Pattern = 'GatewayGuard_SyncPlan-*.md' },
    @{ Label = 'Sync setup steps';            Pattern = 'GatewayGuard_SyncSetupSteps-*.md' },
    @{ Label = 'Cloud Project Instructions';  Pattern = 'GatewayGuard_CloudProjectInstructions-*.md' },
    # Added 2026-08-15. The Launch Plan is the schedule Bill works from and the
    # one document he hands Cloud to say what happens next -- it is built from
    # the CPM's critical path and float, re-ordered against the real calendar.
    # It was tracked and pushed since 2026-08-14 and Cloud could read it, but
    # it was NOT named here, so Cloud had no way to know it was the current
    # plan. That is the exact failure this file exists to prevent, applied to
    # the one document whose whole purpose is telling everyone what to do next.
    @{ Label = 'Launch plan';                 Pattern = 'GatewayGuard_LaunchPlan-*.md' },
    # The CPM the Launch Plan is built from. Named so the derivation is
    # visible: if the two ever disagree, the Launch Plan is the newer reading
    # of the same critical path and the CPM is the baseline it was measured
    # against.
    @{ Label = 'CPM schedule';                Pattern = 'GatewayGuard_CPM_Schedule-2*.md' },
    # Added 2026-08-15. FT-172 is the last blocker on the critical path and its
    # design is in discussion, not built. Named here so neither Cloud nor the
    # next Claude Code session picks up the SUPERSEDED flat-numbering proposal
    # (ScreenNumberTable) and starts building from it.
    @{ Label = 'Screen numbering design';     Pattern = 'GatewayGuard_ScreenNumberDesign-*.md' },
    # Added 2026-08-17. The walk that answered design question 3, and the
    # as-built table -- generated from Tool\build_ascii41_ft172.py so the
    # document cannot drift from the code it describes.
    @{ Label = 'Screen numbering table';      Pattern = 'GatewayGuard_ScreenNumberTable-*.md' },
    # Added 2026-08-17. Bill's 11 ascii40 field findings, triaged and located
    # in source. This is the document a session should read before touching
    # ascii41 -- it is the reason every fix in that build exists.
    @{ Label = 'Field test triage (latest)';  Pattern = 'GatewayGuard_FieldTestTriage-*.md' },
    # Added 2026-08-18. The at-the-keyboard checklist for the current build --
    # what to check, what good looks like, and what not to re-report.
    @{ Label = 'Field checklist (current build)'; Pattern = 'GatewayGuard_FieldChecklist-*.md' },
    # Added 2026-08-22. Cloud reported these missing: the build plan for the
    # current build, the FT-220 guide drop-in sections, and the Cloud request
    # handoffs. All were tracked and synced but unnamed here, so Cloud could not
    # open them -- the exact failure this file exists to prevent.
    @{ Label = 'Build plan (current)';        Pattern = 'GatewayGuard_ascii*BuildPlan-*.md' },
    @{ Label = 'Guide FT-220 sections';       Pattern = 'GatewayGuard_GuideFT220-Sections-*.md' },
    # Cloud requests are distinct handoffs, not versions of one file, so ALL are
    # listed (Multi = newest-sorted), never just the newest one.
    @{ Label = 'Cloud request';               Pattern = 'GatewayGuard_CloudRequest-*.md'; Multi = $true },
    # --- THE THREE SOURCE PACKS, added 2026-08-15 -------------------------
    # Each is a readable extraction of material Cloud cannot otherwise reach,
    # and each was invisible to Cloud for the same reason the Launch Plan was:
    # it is in scope, but its name carries a date and CLOUD CANNOT GLOB. A file
    # Cloud cannot name is a file Cloud cannot open, however well it is synced.
    #
    # Website pack: the 19 guide pages live in WebSite\html\, which is OUTSIDE
    # the connector scope entirely -- so Cloud could read the RULE governing
    # website copy (WebSite\Rules\website-copy.md, in scope) and not one line of
    # the copy itself. Every website review it has given was made blind.
    @{ Label = 'Marketing plan (current)';    Pattern = 'GatewayGuard_MarketingPlan-*.md' },
    @{ Label = 'Guide rewrite draft (current)'; Pattern = 'GatewayGuard_GuideRewrite-Draft-*.md' },
    @{ Label = 'Website source pack (19 guide pages)'; Pattern = 'GatewayGuard_WebsiteSourcePack-*.md' },
    # Guide pack: the .docx master is in Masters\, out of scope, and Cloud has
    # never surfaced a .docx path even when one was in scope. Measured 2026-08-13.
    @{ Label = 'Guide v9 source pack';        Pattern = 'GatewayGuard_GuideV9-SourcePack-*.md' },
    # Marketing pack: Marketing\ and Presentation\ are out of scope on purpose --
    # adding them would spend capacity on 9.3 MB of saved-webpage junk.
    @{ Label = 'Marketing source pack';       Pattern = 'GatewayGuard_MarketingSourcePack-*.md' },
    # --- Added 2026-08-22. NINE DOCUMENTS THAT WERE IN SCOPE AND UNNAMED ---
    # Cloud reported PricingCopy invisible and asked for one pattern. Checking
    # the whole folder against this list found eight more live documents in the
    # same state: tracked, pushed, synced, and impossible for Cloud to open
    # because it cannot glob. Adding a row costs nothing -- the file is already
    # in the payload either way; the row only makes it nameable.
    #
    # PRICING. The copy is quoted from two sources, so both are named with it.
    # A price quoted without its source is the unlabelled-claim failure applied
    # to money.
    #
    # SORTING HAZARD, read before adding to this family: the resolver below
    # takes the LAST name in an ascending Name sort, which only means "newest"
    # while every name in the family ends in its date. It does not here --
    # 'GatewayGuard_PricingCopy-Draft-2026-08-21-1445.md' sorts AFTER a plain
    # 'GatewayGuard_PricingCopy-2026-08-22-1000.md', because 'D' > '2'. A newer
    # plain-dated file would lose to an older -Draft- one and nothing would say
    # so. Keep the -Draft- token or drop it from both; never mix the two forms.
    @{ Label = 'Pricing copy (website)';      Pattern = 'GatewayGuard_PricingCopy-*.md' },
    @{ Label = 'Annual price decision';       Pattern = 'GatewayGuard_PriceDecision-Annual-*.md' },
    # Added 2026-08-22. Bill's refund policy and the annual-only decision. Both
    # belong to documents Cloud is actively rewriting, so they are filed here
    # instead -- a decision written only into a file about to be re-delivered is
    # a decision that can vanish.
    @{ Label = 'Refund policy and terms';     Pattern = 'GatewayGuard_Decisions-RefundAndTerms-*.md' },
    @{ Label = 'Pricing reconciliation (one-time packs)'; Pattern = 'PricingReconciliation-*.md' },
    # The v9 extraction that CLOSES retrieval gaps G1-G6 in the guide rewrite
    # draft. Built and committed 2026-08-22 12:24 -- and unnamed here, so Cloud
    # could not open the one file that answers its own open item.
    @{ Label = 'Guide gap-fill (G1-G6, v9 source)'; Pattern = 'GatewayGuard_GuideGapFill-*.md' },
    @{ Label = 'Marketing plan amendment';    Pattern = 'GatewayGuard_MarketingPlanAmendment-*.md' },
    # Added 2026-08-22. Claude Code's response to Cloud's defect pass -- the
    # verdict on each of its ten findings, with the measurement behind each, and
    # what is left for whom. Cloud must be able to open the answer to its own
    # pass by name.
    @{ Label = 'Defect pass response';        Pattern = 'GatewayGuard_DefectPassResponse-*.md' },
    # Added 2026-08-22. Bill's field review of all 19 website pages, 24 items.
    # The .docx and .txt live in Test_Results, which is NOT in connector scope,
    # and the .txt is cp1252 besides -- so without this readable twin in
    # ProjectDocs, Cloud cannot see one word of it.
    @{ Label = 'Website review (Bill, 19 pages)'; Pattern = 'GatewayGuard_HtmlWebsiteReview-*.md' },
    # The two measurements that unblock F4, the second drive: Start-MpWDOScan
    # has no scope parameter, so D: coverage needs a full ONLINE scan and the
    # screen wording must say so. Gate 24 blocks the text until this is read.
    @{ Label = 'Offline scan research';       Pattern = 'GatewayGuard_OfflineScanResearch-*.md' },
    @{ Label = 'AV scan coverage test';       Pattern = 'GatewayGuard_AVScanCoverageTest-*.md' },
    # FT-203: both scheduled reminders carry DisallowStartIfOnBatteries, so on
    # a laptop on battery they never run -- while the log writes [GOOD]. Carries
    # one product decision for Bill.
    @{ Label = 'Scheduled task defects (FT-203)'; Pattern = 'GatewayGuard_ScheduledTaskDefects-*.md' },
    # Which five of the ascii41 run's 38 findings ascii42 actually fixed, and
    # why so few. Named in the briefing; unopenable by Cloud until now.
    @{ Label = 'ascii41 findings -- fixed or not'; Pattern = 'GatewayGuard_ascii41Findings-*.md' }
)

# Resolve every pattern BEFORE writing anything. Newest by the DATE IN THE
# FILENAME -- sorting by Name does that, because every name ends -YYYY-MM-DD[-HHMM].
$resolved = @()
$missing  = @()
# --- THE SORT KEY: THE DATE IN THE NAME, NOT THE WHOLE NAME --------------
# Sorting by Name means "newest" ONLY while every name in a family ends in its
# date. That premise held until 2026-08-22, when it broke in the field:
#   GatewayGuard_PricingCopy-2026-08-22-1000.md        <- the new one
#   GatewayGuard_PricingCopy-Draft-2026-08-21-1445.md  <- sorts LAST, 'D' > '2'
# The OLDER file won, CURRENT.md pointed Cloud at superseded pricing, and
# nothing said so. A silent wrong answer is the one failure this whole file
# exists to prevent, so the premise is now enforced instead of assumed: pull
# the trailing date out of the name and sort on THAT.
# A name with no date sorts first and can only ever win if it is alone.
function Get-GGNameDate {
    param([string]$Name)
    $m = [regex]::Matches($Name, '(\d{4}-\d{2}-\d{2})(?:-(\d{4}))?')
    if ($m.Count -eq 0) { return '0000-00-00-0000' }
    $last = $m[$m.Count - 1]
    $time = if ($last.Groups[2].Success) { $last.Groups[2].Value } else { '0000' }
    return ($last.Groups[1].Value + '-' + $time)
}

foreach ($w in $wanted) {
    $hits = @(Get-ChildItem -LiteralPath $docs -Filter $w.Pattern -File -EA SilentlyContinue |
              Sort-Object @{ Expression = { Get-GGNameDate $_.Name } }, Name)
    if ($hits.Count -eq 0) {
        $missing += $w.Pattern
    } elseif ($w.ContainsKey('Multi') -and $w.Multi) {
        # A collection of distinct docs sharing a prefix (e.g. Cloud requests).
        # List every one, newest-sorted -- they are not versions of each other.
        foreach ($h in $hits) {
            $resolved += [pscustomobject]@{ Label = $w.Label; Name = $h.Name; Count = 1; Multi = $true }
        }
    } else {
        $resolved += [pscustomobject]@{
            Label = $w.Label
            Name  = $hits[$hits.Count - 1].Name
            Count = $hits.Count
            Multi = $false
        }
    }
}

if ($missing.Count -gt 0) {
    Write-Host ""
    Write-Host "  STOPPED -- CURRENT.md was NOT changed."
    Write-Host "  These patterns matched no file in ProjectDocs:"
    foreach ($m in $missing) { Write-Host ("    " + $m) }
    Write-Host ""
    Write-Host "  Writing the file anyway would publish a pointer with a hole in it,"
    Write-Host "  which is worse than an out-of-date one. The old CURRENT.md is intact."
    Write-Host ""
    return
}

# --- the sentinel, GENERATED not typed -----------------------------------
# Cloud is asked to quote a phrase that exists only in a current snapshot.
# That phrase must MOVE, or it decays into "proves the snapshot is newer than
# some day in the past" and quietly passes for weeks. So it is lifted from the
# top entry of the live session log every time this file is written.
$logName = ($resolved | Where-Object { $_.Label -eq 'Session log' }).Name
$logPath = Join-Path $docs $logName
$sessionHead = ''
$hit = @(Select-String -LiteralPath $logPath -Pattern '^## Session:' -SimpleMatch:$false |
         Select-Object -First 1)
if ($hit.Count -gt 0) { $sessionHead = $hit[0].Line.Trim() }

if ($sessionHead -eq '') {
    Write-Host ""
    Write-Host "  STOPPED -- CURRENT.md was NOT changed."
    Write-Host "  No '## Session:' heading was found in:"
    Write-Host ("    " + $logName)
    Write-Host ""
    Write-Host "  The sentinel is copied from that heading. Without it this file"
    Write-Host "  would tell Cloud to prove itself against nothing, and Cloud"
    Write-Host "  would pass. The old CURRENT.md is intact."
    Write-Host ""
    return
}

# --- the freshness stamp -------------------------------------------------
# Claude Cloud reads a SYNCED COPY of this repository, of unknown age, with no
# way to see how old it is. Confirmed by Anthropic support 2026-08-12: the
# GitHub connector syncs files into project knowledge and exposes no live repo
# tool, and there is no documented way to see which commit a snapshot reflects.
#
# So the stamp travels INSIDE the payload. Reading this file IS reading the
# sync date. Cloud's own proposal, and better than the sentinel phrase it
# replaces: a sentinel says stale or not stale, a stamp says stale BY HOW MUCH.
#
# The hash is HEAD at generation time -- i.e. the commit BEFORE the one that
# carries this file. That is the honest label and it is what to compare.
# VERIFIED 2026-08-12 measured on CGDELL: returned "795caf0"
$headHash  = (git rev-parse --short HEAD  2>$null)
# VERIFIED 2026-08-12 measured on CGDELL: returned "2026-08-12 21:46"
$headDate  = (git log -1 --format='%ad' --date=format:'%Y-%m-%d %H:%M' 2>$null)
# VERIFIED 2026-08-12 measured on CGDELL: returned the HEAD commit subject line
$headSubj  = (git log -1 --format='%s'   2>$null)
if (-not $headHash) { $headHash = 'unknown'; $headDate = 'unknown'; $headSubj = 'not a git working tree' }

$L = New-Object System.Collections.Generic.List[string]
$L.Add('<!-- GENERATED FILE -- DO NOT EDIT BY HAND. -->')
$L.Add('<!-- Written by Tool\Update-Current.ps1. Hand edits are lost on the next run. -->')
$L.Add(('<!-- Generated: ' + $stamp + ' ET -->'))
$L.Add(('<!-- Commit: ' + $headHash + ' -->'))
$L.Add('')
$L.Add('# CURRENT -- which file is the live one')
$L.Add('')
$L.Add('## FRESHNESS STAMP -- read this out before anything else')
$L.Add('')
$L.Add(('- **Generated:** ' + $stamp + ' ET'))
$L.Add(('- **Commit at generation:** `' + $headHash + '`'))
$L.Add(('- **That commit was made:** ' + $headDate + ' ET'))
$L.Add(('- **Its subject line:** ' + $headSubj))
$L.Add('')
$L.Add('**If you are reading a synced copy rather than the live repository --')
$L.Add('Claude Cloud always is -- state these four values in your first reply.**')
$L.Add('Bill compares them against what Claude Code last pushed. A mismatch is')
$L.Add('one line instead of five searches.')
$L.Add('')
$L.Add('**Why this is here.** Anthropic support confirmed 2026-08-12 that the')
$L.Add('GitHub connector syncs into project knowledge, exposes no live repository')
$L.Add('tool, and offers no way to see which commit a snapshot reflects. So the')
$L.Add('stamp travels inside the payload: reading this file IS reading the sync')
$L.Add('date. It replaces a sentinel phrase that could only say stale or not')
$L.Add('stale -- this says stale **by how much**.')
$L.Add('')
$L.Add('*The hash is HEAD at generation time, so it is the commit before the one')
$L.Add('carrying this file. That is deliberate and it is the value to compare.*')
$L.Add('')
$L.Add('---')
$L.Add('')
$L.Add('This filename never changes, so it can be named in an instruction without')
$L.Add('going stale. The filenames BELOW change constantly -- always take them from')
$L.Add('here rather than from memory or from any other document.')
$L.Add('')
$L.Add('All paths are relative to `ProjectDocs/`.')
$L.Add('')
$L.Add('| What it is | The current file | Older versions present |')
$L.Add('|---|---|---|')
foreach ($r in $resolved) {
    if ($r.Multi) {
        $L.Add(('| ' + $r.Label + ' | `' + $r.Name + '` | -- |'))
    } else {
        $older = $r.Count - 1
        $L.Add(('| ' + $r.Label + ' | `' + $r.Name + '` | ' + $older + ' |'))
    }
}
$L.Add('')
$L.Add('Also read `CLAUDE.md`, at the repository root. That name never changes.')
$L.Add('')
$L.Add('## If you are Claude Cloud, do this check first')
$L.Add('')
$L.Add('**Quote the heading below back, word for word, from the session log --')
$L.Add('not from this file.** It is the newest entry in the log, so it can only')
$L.Add('be found in a snapshot taken after that session was filed.')
$L.Add('')
$L.Add('```')
$L.Add($sessionHead)
$L.Add('```')
$L.Add('')
$L.Add('**If it is not in your copy of the session log, you are reading an old')
$L.Add('snapshot. Say so and stop.** Do not report on a document you could not')
$L.Add('confirm you are actually reading.')
$L.Add('')
$L.Add('This heading is COPIED FROM the live log when this file is generated, so')
$L.Add('it moves forward on its own. The version before 2026-08-14 named a fixed')
$L.Add('sentence about SANDY and a local account called `panther`, which proved')
$L.Add('only that the snapshot post-dated the day that sentence was written --')
$L.Add('the same pointer-that-lies failure this script exists to prevent, wearing')
$L.Add('a different hat.')
$L.Add('')
$L.Add('## Why this file is generated and not written')
$L.Add('')
$L.Add('Claude Code can glob a folder and take the newest by filename date. Cloud')
$L.Add('cannot list or sort a directory at all, so it was searching by relevance')
$L.Add('across five briefings and reporting the winner as current. This file gives')
$L.Add('it one fixed name to follow. It is regenerated at session end; a pointer')
$L.Add('kept by hand is the failure it exists to prevent.')

# UTF8 with NO byte-order mark. Set-Content -Encoding UTF8 in PowerShell 5.1
# writes a BOM, and 63 of the 67 .md files in ProjectDocs have none -- so the
# BOM is the odd one out, not the convention. Measured 2026-08-12.
[System.IO.File]::WriteAllText($outFile, (($L -join "`r`n") + "`r`n"),
    (New-Object System.Text.UTF8Encoding($false)))

Write-Host ""
Write-Host "  CURRENT.md written -- $($resolved.Count) documents resolved."
foreach ($r in $resolved) {
    Write-Host ("    " + $r.Label.PadRight(30) + $r.Name)
}
Write-Host ""
Write-Host ("  " + $outFile)
Write-Host ""
