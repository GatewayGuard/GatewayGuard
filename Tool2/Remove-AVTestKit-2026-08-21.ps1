# Dated: 2026-08-21 14:10 ET
# ================================================================
# FILE:    Remove-AVTestKit-2026-08-21.ps1
# PURPOSE: Delete everything Make-AVTestKit-2026-08-21.ps1 staged.
#          Read-only except for removing the AVTestKit folders it created.
#          Does not self-elevate. Reports what it removed.
# ================================================================

$ErrorActionPreference = "Continue"
$removed = 0
Write-Host ""
Write-Host " Removing AV test kit specimens..." -ForegroundColor Cyan
foreach ($d in @("C","D","E","F")) {
    $base = ($d + ":\AVTestKit")
    if (Test-Path $base) {
        try {
            # clear hidden/system attributes first so Remove-Item can take them
            Get-ChildItem $base -Recurse -Force -ErrorAction SilentlyContinue | ForEach-Object {
                try { $_.Attributes = 'Normal' } catch {}
            }
            Remove-Item $base -Recurse -Force -ErrorAction Stop
            Write-Host ("  REMOVED  " + $base) -ForegroundColor Green
            $removed++
        } catch {
            Write-Host ("  COULD NOT REMOVE  " + $base + "  -- " + $_.Exception.Message) -ForegroundColor Yellow
            Write-Host "  If a specimen is in AV quarantine, delete it from the AV app instead." -ForegroundColor Gray
        }
    }
}
if ($removed -eq 0) { Write-Host "  Nothing to remove -- no AVTestKit folders found." -ForegroundColor Gray }

# ----------------------------------------------------------------
# ADDED 2026-08-28. The kit also drops a working copy in the user's
# Temp folder each time it runs -- eicar_<date>_<time>.txt. Both of
# them turned up in Defender's detection list on SANDY, and this
# script did not touch them. Bill: "revise cleanup so it gets rid of
# everything."
# ----------------------------------------------------------------
Write-Host ""
Write-Host " Removing working copies from the Temp folder..." -ForegroundColor Cyan
$tmpRemoved = 0
$tmpFailed  = 0
foreach ($tdir in @($env:TEMP, $env:TMP, "$env:SystemRoot\Temp") | Select-Object -Unique) {
    if (-not $tdir -or -not (Test-Path $tdir)) { continue }
    Get-ChildItem $tdir -Filter 'eicar_*' -File -Force -ErrorAction SilentlyContinue | ForEach-Object {
        try {
            $_.Attributes = 'Normal'
            Remove-Item $_.FullName -Force -ErrorAction Stop
            Write-Host ("  REMOVED  " + $_.FullName) -ForegroundColor Green
            $tmpRemoved++
        } catch {
            Write-Host ("  COULD NOT REMOVE  " + $_.FullName + "  -- " + $_.Exception.Message) -ForegroundColor Yellow
            $tmpFailed++
        }
    }
}
if ($tmpRemoved -eq 0 -and $tmpFailed -eq 0) {
    Write-Host "  None found -- either already cleared, or the AV took them." -ForegroundColor Gray
}

Write-Host ""
Write-Host (" SUMMARY: " + $removed + " AVTestKit folder(s) and " + $tmpRemoved + " Temp file(s) removed.") -ForegroundColor Cyan
Write-Host ""
Write-Host " Note: specimens that AV already quarantined are held by the AV," -ForegroundColor Gray
Write-Host " not on disk. Clear those from Defender or Malwarebytes directly." -ForegroundColor Gray
Write-Host ""
