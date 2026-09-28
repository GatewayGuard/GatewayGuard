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
        } catch {}
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
exit 0
