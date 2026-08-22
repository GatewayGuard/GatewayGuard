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
Write-Host ""
Write-Host " Note: specimens that AV already quarantined are held by the AV," -ForegroundColor Gray
Write-Host " not on disk. Clear those from Defender or Malwarebytes directly." -ForegroundColor Gray
Write-Host ""
