# Dated: 2026-08-20 00:55 ET
# File: Check-RepoHealth-2026-08-20.ps1
#
#   WHY THIS EXISTS: the GatewayGuard repository sits inside a OneDrive folder
#   that syncs to a second PC. OneDrive has already written conflict copies of
#   git's own index, config and branch references -- measured 2026-08-20, seven
#   of them, dated 08-02 to 08-09. Nothing was damaged, but nothing was
#   watching either, and they went unnoticed for eleven days.
#
#   Run this at session end. It answers three questions:
#     1. Is the repository still sound?
#     2. Has OneDrive written any new conflict copies?
#     3. Is everything pushed, so a broken repository is only a re-clone?
#
#   READ-ONLY. It changes nothing and needs no administrator.

$ErrorActionPreference = "Continue"

$repo = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $repo

$stamp   = Get-Date -Format "yyyy-MM-dd_HH-mm"
$results = Join-Path $repo "Test_Results"
if (-not (Test-Path $results)) { New-Item -ItemType Directory -Path $results -Force | Out-Null }
$outFile = Join-Path $results ("RepoHealth-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

$L = New-Object System.Collections.ArrayList
function W([string]$t) { [void]$L.Add($t); Write-Host $t }

$problems = 0

W ("=" * 70)
W "  REPOSITORY HEALTH"
W ("=" * 70)
W ("  repository     : " + $repo)
W ("  machine        : " + $env:COMPUTERNAME)
W ("  run at         : " + (Get-Date -Format "yyyy-MM-dd HH:mm:ss"))
W ""

# ------------------------------------------------------- 1. is git intact
W "-- 1. IS THE REPOSITORY SOUND ----------------------------------------"
# VERIFIED 2026-08-20 measured on CGDELL: "git fsck --no-progress" prints
# "dangling blob <sha>" lines and nothing else on a healthy repository.
# Dangling objects are normal leftovers and are NOT damage. Real damage
# prints "missing", "broken link" or "error".
$fsck = @(& git fsck --no-progress 2>&1 | ForEach-Object { $_.ToString() })
$real = @($fsck | Where-Object { $_ -notmatch '^dangling ' -and $_ -notmatch '^notice:' -and $_.Trim() -ne "" })
W ("  dangling objects (normal, ignored) : " + ($fsck.Count - $real.Count))
if ($real.Count -eq 0) {
    W "  RESULT: sound. No missing objects, no broken links."
} else {
    $problems++
    W "  RESULT: PROBLEM. git reports real damage:"
    foreach ($r in $real) { W ("      " + $r) }
    W "  WHAT TO DO: everything is on GitHub. Rename this folder and clone"
    W "              a fresh copy rather than trying to repair it."
}
W ""

# --------------------------------------------- 2. OneDrive conflict copies
W "-- 2. HAS ONEDRIVE WRITTEN ANY CONFLICT COPIES -----------------------"
W "  A conflict copy is a file whose name gained a machine name, sitting"
W "  beside the real file. That is what OneDrive writes when two PCs change"
W "  the same file and it will not choose between them."
$names = @("Sandy", "SANDY", "CGDELL", "cgdell")
$found = New-Object System.Collections.ArrayList
foreach ($f in (Get-ChildItem -LiteralPath $repo -Recurse -File -Force -ErrorAction SilentlyContinue)) {
    $base = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
    $ext  = [System.IO.Path]::GetExtension($f.Name)
    foreach ($n in $names) {
        $suffix = "-" + $n
        if ($base.EndsWith($suffix)) {
            $twin = Join-Path $f.DirectoryName ($base.Substring(0, $base.Length - $suffix.Length) + $ext)
            # Only a conflict copy if the ORIGINAL still sits beside it.
            # This is what keeps ordinary names such as
            # HomeDiagnostic-SANDY-2026-07-30.txt out of the report.
            if (Test-Path -LiteralPath $twin) {
                [void]$found.Add($f.FullName.Substring($repo.Length + 1) + "   (" + $f.LastWriteTime + ")")
            }
            break
        }
    }
}
if ($found.Count -eq 0) {
    W "  RESULT: none. Nothing new since the last check."
} else {
    $problems++
    W ("  RESULT: " + $found.Count + " conflict copy(ies) present:")
    foreach ($x in $found) { W ("      " + $x) }
    W "  WHAT TO DO: compare each against the file beside it. Keep the newer"
    W "              content, then remove the copy with the machine name."
}
W ""

# ------------------------------------------------------- 3. is it pushed
W "-- 3. IS EVERYTHING PUSHED -------------------------------------------"
W "  This is what makes the rest survivable. If the local repository is ever"
W "  damaged, a pushed repository is a re-clone and nothing is lost."
$unpushed = (& git rev-list --count origin/main..HEAD 2>&1 | Select-Object -First 1)
W ("  commits not yet on GitHub : " + $unpushed)
if ("$unpushed" -eq "0") {
    W "  RESULT: safe. GitHub holds every commit."
} else {
    $problems++
    W "  RESULT: PROBLEM. Those commits exist only on this PC."
}
$dirty = @(& git status --porcelain 2>&1 | Where-Object { $_ -match '^ ?[MD]' })
W ("  tracked files changed or missing on disk : " + $dirty.Count)
foreach ($d in ($dirty | Select-Object -First 12)) { W ("      " + $d) }
W ""

# ----------------------------------------------- 4. the standing condition
W "-- 4. THE STANDING RISK ----------------------------------------------"
$g = Get-Item (Join-Path $repo ".git") -Force -ErrorAction SilentlyContinue
if ($g -and ($g.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
    W "  .git is INSIDE the synced OneDrive folder. Every commit rewrites five"
    W "  of git's internal files, OneDrive replicates all five to the other PC,"
    W "  and it can write a conflict copy of any of them. This does not need"
    W "  anyone to run git on the second machine -- measured 2026-08-09, five"
    W "  conflict copies appeared at 14:39:27, the exact second of a commit made"
    W "  on CGDELL."
    W "  This is why sections 1 and 3 above are worth running every session."
} else {
    W "  .git is not managed by OneDrive on this PC. Nothing to watch."
}
W ""

W ("=" * 70)
if ($problems -eq 0) { W "  ALL CLEAR" } else { W ("  " + $problems + " THING(S) NEED ATTENTION -- see above") }
W ("=" * 70)

Set-Content -LiteralPath $outFile -Value ($L -join "`r`n") -Encoding UTF8
Write-Host ""
Write-Host ("  Saved to: " + $outFile) -ForegroundColor Green
Write-Host ""
