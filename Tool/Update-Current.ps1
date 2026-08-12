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
# NO EXTERNAL COMMANDS -- nothing for gate 24 to verify.
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
    @{ Label = 'Field test plan';             Pattern = 'GatewayGuard_FieldTestPlan-*.md' },
    @{ Label = 'Test history';                Pattern = 'GatewayGuard_TestHistory-*.md' },
    @{ Label = 'Sync plan';                   Pattern = 'GatewayGuard_SyncPlan-*.md' },
    @{ Label = 'Sync setup steps';            Pattern = 'GatewayGuard_SyncSetupSteps-*.md' }
)

# Resolve every pattern BEFORE writing anything. Newest by the DATE IN THE
# FILENAME -- sorting by Name does that, because every name ends -YYYY-MM-DD[-HHMM].
$resolved = @()
$missing  = @()
foreach ($w in $wanted) {
    $hits = @(Get-ChildItem -LiteralPath $docs -Filter $w.Pattern -File -EA SilentlyContinue |
              Sort-Object Name)
    if ($hits.Count -eq 0) {
        $missing += $w.Pattern
    } else {
        $resolved += [pscustomobject]@{
            Label = $w.Label
            Name  = $hits[$hits.Count - 1].Name
            Count = $hits.Count
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

$L = New-Object System.Collections.Generic.List[string]
$L.Add('<!-- GENERATED FILE -- DO NOT EDIT BY HAND. -->')
$L.Add('<!-- Written by Tool\Update-Current.ps1. Hand edits are lost on the next run. -->')
$L.Add(('<!-- Generated: ' + $stamp + ' ET -->'))
$L.Add('')
$L.Add('# CURRENT -- which file is the live one')
$L.Add('')
$L.Add(('**Generated ' + $stamp + ' ET by `Tool\Update-Current.ps1`.**'))
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
    $older = $r.Count - 1
    $L.Add(('| ' + $r.Label + ' | `' + $r.Name + '` | ' + $older + ' |'))
}
$L.Add('')
$L.Add('Also read `CLAUDE.md`, at the repository root. That name never changes.')
$L.Add('')
$L.Add('## If you are Claude Cloud, do this check first')
$L.Add('')
$L.Add('Quote the sentence in the briefing about SANDY and a local account named')
$L.Add('`panther`. It exists only in the current version. **If you cannot find it,')
$L.Add('you are reading an old snapshot -- say so and stop.** Do not report on a')
$L.Add('document you could not confirm you are actually reading.')
$L.Add('')
$L.Add('## Why this file is generated and not written')
$L.Add('')
$L.Add('Claude Code can glob a folder and take the newest by filename date. Cloud')
$L.Add('cannot list or sort a directory at all, so it was searching by relevance')
$L.Add('across five briefings and reporting the winner as current. This file gives')
$L.Add('it one fixed name to follow. It is regenerated at session end; a pointer')
$L.Add('kept by hand is the failure it exists to prevent.')

Set-Content -LiteralPath $outFile -Value ($L -join "`r`n") -Encoding UTF8

Write-Host ""
Write-Host "  CURRENT.md written -- $($resolved.Count) documents resolved."
foreach ($r in $resolved) {
    Write-Host ("    " + $r.Label.PadRight(30) + $r.Name)
}
Write-Host ""
Write-Host ("  " + $outFile)
Write-Host ""
