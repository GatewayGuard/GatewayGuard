# Dated: 2026-09-28 14:06 ET
# Editor: Claude Code (CGDELL)
# Check-SimpleMistakes -- gate 27. READ-ONLY. Runs by itself before every commit
# (the git pre-commit hook calls it) and can be run by hand:
#   Tool2\Run-SimpleMistakesCheck.bat          -- checks every tracked launcher/script
#   powershell -File Check-SimpleMistakes.ps1 -Staged   -- what the hook runs
#
# Bill, 2026-09-28: "HOW CAN WE AVOID THESE SIMPLE MISTAKES, OTHERWISE WE MAY ONE
# DAY RELEASE AN EXECUTABLE PS1 WITH ONE OF THEM IN IT."
# Each check below is a mistake that actually happened, with the date:
#   L1-L5  launchers    -- 2026-09-28: ">nul" became ">/dev/null" in three .bat
#                          files; "The system cannot find the path specified" on
#                          SANDY and CGDELL. 2026-09-27: sed turned a .bat to LF.
#   S1     stamps       -- 2026-09-28: seven "Dated:" times typed, not read off the
#                          clock, up to 27 minutes in the future.
#   P1-P3  PowerShell   -- parse errors, Linux paths, Join-String (PS 5.1).
#   B1-B3  the build    -- non-ASCII, duplicate functions, gates 12 and 24.
#   X1     secrets      -- 2026-09-28: a registry dump holding a Microsoft sign-in
#                          record reached Test_Results and was nearly committed.
#   C1     big commits  -- 2026-09-03, commit 17fc9fa: 665 files in one commit.
# Added 2026-09-30 16:21 (Bill: "why do we keep having these mistakes"):
#   S2     placeholder  -- a stamp.py placeholder left unfilled.
#   S3     typed stamp  -- a NEW file whose "Dated:" is more than a minute before,
#                          or two after, the minute it was created. Stamps were
#                          typed 1-14 minutes wrong on 09-27..09-30; S1 only
#                          caught the future. Use Tool2\stamp.py, never type.
#   A1     CURRENT.md   -- regenerated and added to the commit, by itself, when
#                          the commit touches ProjectDocs\ (it was 2 days stale).
#   W1     session log  -- WARNING (not a stop) when the build or ProjectDocs\
#                          change and the session log has no entry for today.
# A FAIL stops the commit. Fix the file and commit again. Never skip the hook.

param([switch]$Staged)

$ErrorActionPreference = "Continue"
$repo = Split-Path $PSScriptRoot -Parent
Set-Location $repo
$fails = New-Object System.Collections.Generic.List[string]
$notes = New-Object System.Collections.Generic.List[string]
function Fail([string]$f, [string]$m) { $fails.Add(("FAIL  " + $f + " -- " + $m)) }

if ($Staged) {
    $files = @(git diff --cached --name-only --diff-filter=ACMR 2>$null)
    if ($files.Count -gt 60) { $fails.Add("FAIL  C1 -- this commit adds or changes " + $files.Count + " files (limit 60). Stage the files the work touched, by name.") }
} else {
    $files = @(git ls-files 2>$null | Where-Object { $_ -match '\.(bat|ps1|py)$' -and $_ -notmatch '^(Archive|Builds|Migration|Notes)/' })
}
$files = @($files | Where-Object { $_ -and (Test-Path -LiteralPath $_) })
$added = @()
if ($Staged) { $added = @(git diff --cached --name-only --diff-filter=A 2>$null) }
$tokNow = "@@" + "NOW" + "@@"; $tokStamp = "@@" + "STAMP" + "@@"   # built from pieces: this file must not hold them whole

function Get-Text([string]$f) {
    if ($Staged) { return ((git show (":" + $f) 2>$null) -join "`n") }
    return [IO.File]::ReadAllText((Join-Path $repo $f))
}
function Get-Bytes([string]$f) {
    if ($Staged) {
        $tmp = [IO.Path]::GetTempFileName()
        cmd /c ("git show "":" + $f + """ > """ + $tmp + """") 2>$null
        $b = [IO.File]::ReadAllBytes($tmp); Remove-Item $tmp -EA SilentlyContinue; return $b
    }
    return [IO.File]::ReadAllBytes((Join-Path $repo $f))
}

$now = Get-Date
foreach ($f in $files) {
    $ext = [IO.Path]::GetExtension($f).ToLower()
    $isText = $ext -in @(".bat", ".ps1", ".py", ".md", ".txt", ".html", ".css", ".js", ".json")
    if (-not $isText) { continue }
    $t = Get-Text $f
    if ($null -eq $t) { continue }

    # This file holds the patterns it searches for -- it is exempt from the
    # pattern checks (X1, P2, P3), never from the parse check (P1).
    $self = ($f -eq 'Tool2/Check-SimpleMistakes.ps1')

    # ---------- X1: secrets ----------
    if (-not $self -and $t -match 'AQAAANCMnd8BFdERjHoAwE' -or $t -match 'login\.microsoftonline\.com\s+::' -or $t -match '(?i)-----BEGIN (RSA |EC )?PRIVATE KEY') {
        Fail $f "X1 holds what looks like a sign-in record or private key. Do not commit it; commit a trimmed extract."
    }

    # ---------- S1: stamps in the future ----------
    $head = ($t -split "`n" | Select-Object -First 12) -join "`n"
    foreach ($m in [regex]::Matches($head, 'Dated:\s*(\d{4}-\d{2}-\d{2})\s+(\d{2}):(\d{2})')) {
        try {
            $d = [datetime]::ParseExact(($m.Groups[1].Value + " " + $m.Groups[2].Value + ":" + $m.Groups[3].Value), "yyyy-MM-dd HH:mm", $null)
            if ($d -gt $now.AddMinutes(2)) { Fail $f ("S1 is stamped " + $d.ToString("yyyy-MM-dd HH:mm") + ", later than the clock (" + $now.ToString("HH:mm") + "). Run 'date' and use what it says.") }
            # S3 (2026-09-30): a NEW file's "Dated:" must be the minute it was made.
            if ($added -contains $f) {
                $c = (Get-Item -LiteralPath (Join-Path $repo $f)).CreationTime
                $cMin = [datetime]::new($c.Year, $c.Month, $c.Day, $c.Hour, $c.Minute, 0)
                $gap = ($d - $cMin).TotalMinutes
                if ($gap -lt -1 -or $gap -gt 2) {
                    Fail $f ("S3 is stamped " + $d.ToString("HH:mm") + " but the file was created at " + $c.ToString("HH:mm") + " -- a typed time? Write the placeholder and run: python Tool2/stamp.py " + $f)
                }
            }
        } catch {}
    }

    # ---------- S2: an unfilled stamp.py placeholder ----------
    if ($f -ne 'Tool2/stamp.py' -and ($t.Contains($tokNow) -or $t.Contains($tokStamp) -or $f.Contains($tokStamp))) {
        Fail $f ("S2 still holds a stamp placeholder. Run: python Tool2/stamp.py " + $f)
    }

    # ---------- launchers ----------
    if ($ext -eq ".bat") {
        $b = Get-Bytes $f
        $lf = 0; $crlf = 0
        for ($i = 0; $i -lt $b.Length; $i++) { if ($b[$i] -eq 10) { if ($i -gt 0 -and $b[$i - 1] -eq 13) { $crlf++ } else { $lf++ } } }
        if ($lf -gt 0) { Fail $f ("L1 has " + $lf + " line(s) ending in LF only. cmd.exe needs CRLF.") }
        if ($t -match '/dev/null') { Fail $f "L2 contains /dev/null (a Linux path). In a .bat it is >nul." }
        if ($t -match '(?im)^\s*pause\s*$') { Fail $f "L3 uses cmd's pause, which prints 'press any key'. Use: set /p _x=Press Enter to close this window..." }
        if ($t -match '(?i)-Verb\s+RunAs|\brunas\b|ShellExecute.*runas') { Fail $f "L4 elevates itself. Launchers never self-elevate (Malwarebytes flag)." }
        if ($t -notmatch '(?i)cd /d "%~dp0"') { Fail $f 'L5 has no cd /d "%~dp0" -- it would run from System32 when started as administrator.' }
    }

    # ---------- PowerShell ----------
    if ($ext -eq ".ps1") {
        $errs = $null
        [void][System.Management.Automation.Language.Parser]::ParseInput($t, [ref]$null, [ref]$errs)
        if ($errs.Count -gt 0) { Fail $f ("P1 does not parse: " + $errs[0].Message + " (line " + $errs[0].Extent.StartLineNumber + ")") }
        if (-not $self -and $t -match '[^\w]/dev/null|\s2>/dev/') { Fail $f "P2 contains /dev/null. In PowerShell it is `$null or Out-Null." }
        if (-not $self -and $t -match '(?m)^[^#]*\bJoin-String\b') { Fail $f "P3 uses Join-String -- not in PowerShell 5.1. Use -join." }
    }

    # ---------- the build ----------
    if ($f -match '^Tool/W11-SecurityHardening-.*\.ps1$') {
        $b = Get-Bytes $f
        $start = if ($b.Length -ge 3 -and $b[0] -eq 0xEF -and $b[1] -eq 0xBB -and $b[2] -eq 0xBF) { 3 } else { 0 }
        $na = 0; for ($i = $start; $i -lt $b.Length; $i++) { if ($b[$i] -gt 127) { $na++ } }
        if ($na -gt 0) { Fail $f ("B1 has " + $na + " non-ASCII byte(s). Every character must be ASCII.") }
        $dups = @([regex]::Matches($t, '(?m)^function\s+([\w-]+)') | ForEach-Object { $_.Groups[1].Value } | Group-Object | Where-Object { $_.Count -gt 1 } | ForEach-Object { $_.Name })
        if ($dups.Count -gt 0) { Fail $f ("B2 defines these functions twice: " + ($dups -join ", ")) }
        if (-not $Staged -or (Test-Path (Join-Path $repo $f))) {
            $g12 = & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "Check-ScreenCoverage-2026-07-30.ps1") -Path (Join-Path $repo $f) 2>&1 | Out-String
            if ($g12 -notmatch 'GATE 12: PASS' -or $g12 -notmatch 'GATE 12b: PASS') { Fail $f "B3 fails gate 12/12b (screens). Run Tool2\Run-ScreenCoverageCheck.bat." }
            $g24 = & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "Check-ExternalCommands-2026-08-02.ps1") -Path (Join-Path $repo $f) 2>&1 | Out-String
            if ($g24 -notmatch 'GATE 24: PASS') { Fail $f "B3 fails gate 24 (external commands). Run Tool2\Run-ExternalCommandCheck.bat." }
        }
    }
}

Write-Host ("GATE 27 (simple mistakes): " + $files.Count + " file(s) checked" + $(if ($Staged) { " -- staged for commit" } else { " -- all tracked launchers and scripts" }))
foreach ($x in $fails) { Write-Host ("  " + $x) -ForegroundColor Red }
if ($fails.Count -gt 0) {
    Write-Host ("GATE 27: FAIL -- " + $fails.Count + " problem(s). Fix them; do not skip this check.") -ForegroundColor Red
    exit 1
}
Write-Host "GATE 27: PASS" -ForegroundColor Green

if ($Staged) {
    $docs  = @($files | Where-Object { $_ -match '^ProjectDocs/' -and $_ -ne 'ProjectDocs/CURRENT.md' })
    $build = @($files | Where-Object { $_ -match '^Tool/' })

    # ---------- W1: the session log has an entry for today ----------
    if ($docs.Count -gt 0 -or $build.Count -gt 0) {
        # The TRACKED log only: an untracked OneDrive conflict copy
        # (...-Sandy.md) sorts after the real one and fooled the first version
        # of this check on its own proof run (2026-09-30).
        $log = @(git ls-files "ProjectDocs/GatewayGuard_SessionLog-*.md" 2>$null | Sort-Object) | Select-Object -Last 1
        $first = $null
        if ($log) { $first = Select-String -LiteralPath (Join-Path $repo $log) -Pattern '^## Session:' | Select-Object -First 1 }
        if (-not $first -or $first.Line -notmatch [regex]::Escape($now.ToString("yyyy-MM-dd"))) {
            Write-Host ("  W1 WARNING -- the session log's newest entry is not dated today (" + $now.ToString("yyyy-MM-dd") + "). Add one before the day ends.") -ForegroundColor Yellow
        }
    }

    # ---------- A1: CURRENT.md regenerated and added, by itself ----------
    if ($docs.Count -gt 0) {
        $uc = & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "Update-Current.ps1") 2>&1 | Out-String
        if (Test-Path (Join-Path $repo "ProjectDocs\CURRENT.md")) {
            git add "ProjectDocs/CURRENT.md" 2>$null
            Write-Host "  A1 CURRENT.md regenerated and added to this commit (ProjectDocs changed)." -ForegroundColor Green
        } else {
            Write-Host "  A1 WARNING -- CURRENT.md could not be regenerated. Run Tool2\Update-Current.ps1 by hand." -ForegroundColor Yellow
        }
    }
}
exit 0
