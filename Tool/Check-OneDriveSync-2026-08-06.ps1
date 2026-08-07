# Dated: 2026-08-06 22:12 ET
# File: Check-OneDriveSync-2026-08-06.ps1
#
# WHAT THIS ANSWERS: which OneDrive accounts are set up on THIS machine, and
# whether the GatewayGuide project tree is present and fully on disk under each
# one. Run it on all three machines (CGDELL, SANDY, SANDY3) and compare the
# FINGERPRINT line at the bottom. If the fingerprints match, the machines are
# carrying the same tree. If they differ, sync has not finished or has not been
# set up on that machine.
#
# WHY IT EXISTS: the M365 migration plan Phase 3 steps 5-7 assume the business
# account syncs to SANDY3 and that file counts match across machines. Nobody has
# checked that. This checks it, without guessing.
#
# READ-ONLY. It reads the registry and counts files. It changes NOTHING on this
# computer, moves nothing, and deletes nothing. The only thing it writes is its
# own results file, so nothing on screen can be truncated or lost.
#
# DOES NOT NEED ADMINISTRATOR.
#
# NO EXTERNAL COMMANDS. Git state is read straight out of the .git folder as
# plain text rather than by running git.exe, so gate 24 has nothing to verify
# and this runs on a machine with no git installed.
#
# PS 5.1 COMPATIBLE: -join only, no Join-String, no ternary, no null-coalescing.

$ErrorActionPreference = 'Continue'

# ---------- where results go ----------
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$outDir    = Join-Path (Split-Path -Parent $scriptDir) 'Test_Results'
if (-not (Test-Path -LiteralPath $outDir)) { $outDir = $scriptDir }
$stamp   = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$outFile = Join-Path $outDir ("OneDriveSync-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

$L = New-Object System.Collections.Generic.List[string]
function Add-Line { param([string]$Text) $L.Add($Text); Write-Host $Text }

Add-Line ""
Add-Line "================================================================"
Add-Line " ONEDRIVE SYNC CHECK -- read-only, changes nothing"
Add-Line "================================================================"
Add-Line ("  Computer : " + $env:COMPUTERNAME)
Add-Line ("  User     : " + $env:USERNAME)
Add-Line ("  Run date : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))

# ---------- Windows edition, so the three machines are told apart ----------
$os = $null
try { $os = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop } catch { }
if ($os) {
    Add-Line ("  Windows  : " + $os.Caption + "  (build " + $os.BuildNumber + ")")
}

# ---------- is the OneDrive client even running ----------
Add-Line ""
Add-Line "---- OneDrive client ----"
$od = @(Get-Process -Name 'OneDrive' -ErrorAction SilentlyContinue)
if ($od.Count -gt 0) {
    Add-Line ("  OneDrive.exe RUNNING -- " + $od.Count + " process(es)")
} else {
    Add-Line "  OneDrive.exe IS NOT RUNNING."
    Add-Line "  Nothing can be syncing right now. Start it from the Start menu"
    Add-Line "  (type OneDrive), then run this check again."
}

# ---------- accounts configured ----------
Add-Line ""
Add-Line "---- OneDrive accounts set up on this machine ----"
$folders = New-Object System.Collections.Generic.List[string]
$base = 'HKCU:\Software\Microsoft\OneDrive\Accounts'
if (Test-Path $base) {
    $found = $false
    foreach ($k in (Get-ChildItem $base -ErrorAction SilentlyContinue)) {
        $p = Get-ItemProperty $k.PSPath -ErrorAction SilentlyContinue
        if ($p -and $p.UserFolder) {
            $found = $true
            $kind = "PERSONAL"
            if ($k.PSChildName -like 'Business*') { $kind = "BUSINESS" }
            Add-Line ("  [" + $kind + "] " + $k.PSChildName)
            Add-Line ("     Email  : " + $p.UserEmail)
            Add-Line ("     Folder : " + $p.UserFolder)
            $exists = Test-Path -LiteralPath $p.UserFolder
            Add-Line ("     Folder exists on disk : " + $exists)
            if ($exists) { $folders.Add($p.UserFolder) }
        }
    }
    if (-not $found) { Add-Line "  No account with a sync folder was found." }
} else {
    Add-Line "  No OneDrive accounts key in the registry."
    Add-Line "  OneDrive has never been set up for this Windows user."
}

# ---------- the project tree under each account ----------
Add-Line ""
Add-Line "---- The GatewayGuide project tree ----"

$treeReports = New-Object System.Collections.Generic.List[string]

foreach ($root in $folders) {
    $tree = Join-Path $root 'GatewayGuide'
    Add-Line ""
    Add-Line ("  " + $tree)
    if (-not (Test-Path -LiteralPath $tree)) {
        Add-Line "     NOT PRESENT under this account."
        continue
    }

    $files = @(Get-ChildItem -LiteralPath $tree -Recurse -File -Force -ErrorAction SilentlyContinue)
    $bytes = 0
    foreach ($f in $files) { $bytes = $bytes + $f.Length }

    # 0x400000 = RECALL_ON_DATA_ACCESS -- the file is in the cloud only, NOT on
    # this disk. 0x80000 = PINNED -- "Always keep on this device".
    $cloudOnly = 0
    $pinned    = 0
    foreach ($f in $files) {
        $a = [int]$f.Attributes
        if ($a -band 0x400000) { $cloudOnly = $cloudOnly + 1 }
        if ($a -band 0x80000)  { $pinned    = $pinned    + 1 }
    }

    Add-Line ("     Files on disk        : " + $files.Count)
    Add-Line ("     Total size           : " + ("{0:N1}" -f ($bytes/1MB)) + " MB")
    Add-Line ("     Cloud-only (NOT here): " + $cloudOnly)
    Add-Line ("     Pinned (always local): " + $pinned)
    if ($cloudOnly -gt 0) {
        Add-Line "     NOTE: some files are online only. They will download when"
        Add-Line "     opened. To force them local: right-click the GatewayGuide"
        Add-Line "     folder and choose 'Always keep on this device'."
    }

    # the current build -- the single file that matters most
    $build = @(Get-ChildItem -LiteralPath (Join-Path $tree 'Tool') -Filter 'W11-SecurityHardening-v3-*.ps1' -File -ErrorAction SilentlyContinue |
               Sort-Object Name -Descending)
    if ($build.Count -gt 0) {
        $h = Get-FileHash -LiteralPath $build[0].FullName -Algorithm SHA256
        Add-Line ("     Newest build         : " + $build[0].Name)
        Add-Line ("     Its SHA256 (first 16): " + $h.Hash.Substring(0,16))
    } else {
        Add-Line "     Newest build         : NONE FOUND in Tool\"
    }

    # git position, read as plain text -- no git.exe needed
    $headFile = Join-Path $tree '.git\HEAD'
    $gitPos   = "no .git folder"
    if (Test-Path -LiteralPath $headFile) {
        $head = (Get-Content -LiteralPath $headFile -ErrorAction SilentlyContinue | Select-Object -First 1)
        if ($head -like 'ref:*') {
            $refPath = Join-Path $tree ('.git\' + ($head -replace '^ref:\s*','') -replace '/','\')
            if (Test-Path -LiteralPath $refPath) {
                $sha = (Get-Content -LiteralPath $refPath | Select-Object -First 1)
                $gitPos = ($head -replace '^ref:\s*','') + " at " + $sha.Substring(0,7)
            } else {
                $gitPos = ($head -replace '^ref:\s*','') + " (see packed-refs)"
            }
        } else {
            $gitPos = "detached at " + $head
        }
    }
    Add-Line ("     Git position         : " + $gitPos)

    $treeReports.Add($tree + " => " + $files.Count + " files, " + ("{0:N1}" -f ($bytes/1MB)) + " MB")
}

# ---------- free space ----------
Add-Line ""
Add-Line "---- Free space on C: ----"
try {
    $d = Get-PSDrive -Name C -ErrorAction Stop
    Add-Line ("  Free : " + ("{0:N1}" -f ($d.Free/1GB)) + " GB    Used : " + ("{0:N1}" -f ($d.Used/1GB)) + " GB")
} catch {
    Add-Line "  Could not read drive C:."
}

# ---------- the comparison line ----------
Add-Line ""
Add-Line "================================================================"
Add-Line " FINGERPRINT -- compare this line across all three machines"
Add-Line "================================================================"
if ($treeReports.Count -eq 0) {
    Add-Line ("  " + $env:COMPUTERNAME + " : NO GatewayGuide TREE ON THIS MACHINE")
} else {
    foreach ($r in $treeReports) { Add-Line ("  " + $env:COMPUTERNAME + " : " + $r) }
}

Add-Line ""
Add-Line "---- The one thing this cannot read ----"
Add-Line "  Windows does not let a program ask OneDrive 'are you up to date'."
Add-Line "  Check it by eye, on each machine:"
Add-Line "    1. Click the cloud icon in the notification area, bottom right."
Add-Line "       If you cannot see it, click the small arrow to show hidden icons."
Add-Line "    2. It should say 'Your files are synced' or 'Up to date'."
Add-Line "    3. If it says syncing, or shows a number of files remaining, wait"
Add-Line "       for it to finish before moving or copying anything."
Add-Line "    4. If it shows a red X or asks you to sign in, sync is STOPPED on"
Add-Line "       that account and nothing is reaching the cloud from this machine."
Add-Line "  With two accounts you get TWO cloud icons. Check both."

Add-Line ""
Add-Line ("  Results saved to: " + $outFile)
Add-Line ""

Set-Content -LiteralPath $outFile -Value ($L -join "`r`n") -Encoding ASCII
