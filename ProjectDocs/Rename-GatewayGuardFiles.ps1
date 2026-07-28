# Rename-GatewayGuardFiles.ps1
# Dated: 2026-07-02
#
# Purpose: Standardize filenames to the GatewayGuard convention
#          (append -YYYY-MM-DD before the extension, based on
#          the file's LastWriteTime) and insert a "Dated:" comment
#          at the top of code/text files going forward.
#
# SAFE BY DEFAULT: Runs as a dry run (preview only) unless you pass -Apply.
#
# USAGE EXAMPLES:
#   Preview only (no changes):
#     .\Rename-GatewayGuardFiles.ps1 -Path "D:\GatewayGuard\Incoming" -Recurse
#
#   Actually rename files:
#     .\Rename-GatewayGuardFiles.ps1 -Path "D:\GatewayGuard\Incoming" -Recurse -Apply
#
#   Rename AND insert date-header comments into code/text files:
#     .\Rename-GatewayGuardFiles.ps1 -Path "D:\GatewayGuard\Incoming" -Recurse -Apply -AddHeaders

param(
    [Parameter(Mandatory=$true)]
    [string]$Path,

    [switch]$Recurse,

    [switch]$Apply,

    [switch]$AddHeaders,

    # Extensions that get a "Dated:" comment inserted at the top
    [string[]]$HeaderExtensions = @(".ps1", ".psm1", ".bat", ".md", ".txt")
)

# ISO 8601 date pattern check - so we don't double-date a file that already has one
$DatePattern = '\d{4}-\d{2}-\d{2}'

function Get-CommentSyntax {
    param([string]$Extension)
    switch ($Extension.ToLower()) {
        ".ps1"  { return "#" }
        ".psm1" { return "#" }
        ".bat"  { return "REM" }
        ".md"   { return "<!--DATEEND-->" }  # handled specially below
        ".txt"  { return "" }                 # plain line, no comment marker
        default { return "#" }
    }
}

function Add-DateHeader {
    param(
        [string]$FilePath,
        [string]$DateStamp
    )
    $ext = [System.IO.Path]::GetExtension($FilePath)
    $content = Get-Content -Path $FilePath -Raw -ErrorAction Stop

    # Skip if a date comment already exists in the first 3 lines
    $firstLines = ($content -split "`r?`n" | Select-Object -First 3) -join "`n"
    if ($firstLines -match $DatePattern) {
        return $false  # already has a date, skip
    }

    $headerLine = switch ($ext.ToLower()) {
        ".bat"  { "REM Dated: $DateStamp" }
        ".md"   { "<!-- Dated: $DateStamp -->" }
        ".txt"  { "Dated: $DateStamp" }
        default { "# Dated: $DateStamp" }
    }

    $newContent = "$headerLine`r`n$content"
    Set-Content -Path $FilePath -Value $newContent -NoNewline -ErrorAction Stop
    return $true
}

# --- Main ---

if (-not (Test-Path $Path)) {
    Write-Host "ERROR: Path not found: $Path" -ForegroundColor Red
    exit 1
}

$getArgs = @{ Path = $Path; File = $true }
if ($Recurse) { $getArgs["Recurse"] = $true }

$files = Get-ChildItem @getArgs

if ($files.Count -eq 0) {
    Write-Host "No files found under $Path" -ForegroundColor Yellow
    exit 0
}

Write-Host ""
if (-not $Apply) {
    Write-Host "=== DRY RUN (no files will be changed) ===" -ForegroundColor Cyan
    Write-Host "Add -Apply to actually rename / edit files." -ForegroundColor Cyan
} else {
    Write-Host "=== APPLY MODE (files will be renamed/edited) ===" -ForegroundColor Yellow
}
Write-Host ""

$renamedCount = 0
$skippedCount = 0
$headerAddedCount = 0

foreach ($file in $files) {
    $baseName = $file.BaseName
    $ext = $file.Extension
    $dateStamp = $file.LastWriteTime.ToString("yyyy-MM-dd")

    # Skip if filename already contains an ISO date
    if ($baseName -match $DatePattern) {
        Write-Host "SKIP (already dated): $($file.Name)" -ForegroundColor DarkGray
        $skippedCount++
    } else {
        $newName = "$baseName-$dateStamp$ext"
        $newPath = Join-Path $file.DirectoryName $newName

        if (Test-Path $newPath) {
            Write-Host "CONFLICT (target exists, skipped): $newName" -ForegroundColor Red
        } else {
            Write-Host "$($file.Name)  ->  $newName"
            if ($Apply) {
                Rename-Item -Path $file.FullName -NewName $newName -ErrorAction Stop
                $renamedCount++
            }
        }
    }

    # Header insertion (only for text-based files, only if requested)
    if ($AddHeaders -and ($HeaderExtensions -contains $ext.ToLower())) {
        $targetPath = if ($Apply -and (Test-Path $newPath)) { $newPath } else { $file.FullName }
        if ($Apply) {
            try {
                $added = Add-DateHeader -FilePath $targetPath -DateStamp $dateStamp
                if ($added) {
                    Write-Host "  + header added" -ForegroundColor Green
                    $headerAddedCount++
                }
            } catch {
                Write-Host "  ! could not add header to $targetPath : $_" -ForegroundColor Red
            }
        } else {
            Write-Host "  (would check/add date header)" -ForegroundColor DarkCyan
        }
    }
}

Write-Host ""
Write-Host "=== SUMMARY ===" -ForegroundColor Cyan
Write-Host "Files scanned:   $($files.Count)"
Write-Host "Already dated:   $skippedCount"
if ($Apply) {
    Write-Host "Renamed:         $renamedCount"
    if ($AddHeaders) { Write-Host "Headers added:   $headerAddedCount" }
} else {
    Write-Host "(Dry run only - nothing was changed. Add -Apply to execute.)"
}
Write-Host ""
