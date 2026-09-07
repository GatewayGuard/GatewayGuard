# =====================================================================
#  Restore-ReputationSettings-2026-09-07.ps1
#
#  PUTS THE REPUTATION SETTINGS BACK exactly as Set-ReputationSettings
#  found them -- including DELETING the values that did not exist before.
#
#  It reads the newest ReputationSettings-UNDO-*.json in Test_Results,
#  or the file named with -UndoFile.
#
#  Needs administrator. Never elevates itself.
# =====================================================================

param(
    [string]$UndoFile = ""
)

$ErrorActionPreference = "Continue"

$ggStamp  = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ggRoot   = Split-Path $PSScriptRoot -Parent
$ggOutDir = Join-Path $ggRoot "Test_Results"
$ggOut = Join-Path $ggOutDir "ReputationRestore-$env:COMPUTERNAME-$ggStamp.txt"

$ggLines = New-Object System.Collections.ArrayList
function Add-Line { param([string]$T = "") ; $null = $ggLines.Add($T) ; Write-Host $T }

Add-Line "======================================================================"
Add-Line "  RESTORE REPUTATION SETTINGS"
Add-Line "  $env:COMPUTERNAME   $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Add-Line "======================================================================"
Add-Line ""

$ggId   = [Security.Principal.WindowsIdentity]::GetCurrent()
$ggElev = (New-Object Security.Principal.WindowsPrincipal($ggId)).IsInRole(
            [Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $ggElev) {
    Add-Line "  STOPPED -- needs administrator. Nothing changed."
    ($ggLines -join "`r`n") | Out-File -FilePath $ggOut -Encoding UTF8 ; exit 1
}

if ($UndoFile -eq "") {
    $c = @(Get-ChildItem -LiteralPath $ggOutDir -Filter "ReputationSettings-UNDO-*.json" -EA SilentlyContinue |
           Sort-Object LastWriteTime -Descending)
    if ($c.Count -eq 0) {
        Add-Line "  No undo file found in Test_Results. Nothing to restore."
        ($ggLines -join "`r`n") | Out-File -FilePath $ggOut -Encoding UTF8 ; exit 1
    }
    $UndoFile = $c[0].FullName
}
Add-Line ("  Undo file: {0}" -f $UndoFile)
Add-Line ""

$ggRows = @(Get-Content -LiteralPath $UndoFile -Raw | ConvertFrom-Json)
foreach ($r in $ggRows) {
    if ($r.Existed) {
        try {
            Set-ItemProperty -Path $r.Path -Name $r.Name -Value $r.OldValue -Force -EA Stop
            Add-Line ("  restored  {0,-46} back to {1}" -f $r.Label, $r.OldValue)
        } catch {
            Add-Line ("  FAILED    {0}  -- {1}" -f $r.Label, $_.Exception.Message)
        }
    } else {
        try {
            Remove-ItemProperty -Path $r.Path -Name $r.Name -Force -EA Stop
            Add-Line ("  removed   {0,-46} (it did not exist before)" -f $r.Label)
        } catch {
            $still = $null
            try { $still = (Get-ItemProperty -Path $r.Path -Name $r.Name -EA Stop).($r.Name) } catch { }
            if ($null -eq $still) { Add-Line ("  removed   {0,-46} (already gone)" -f $r.Label) }
            else { Add-Line ("  FAILED    {0}  -- still reads {1}" -f $r.Label, $still) }
        }
    }
}
Add-Line ""
Add-Line "  Note: 'Block downloads' was never changed by these scripts, so"
Add-Line "  there is nothing to put back for it."
Add-Line ""
Add-Line ("  Saved to: {0}" -f $ggOut)
($ggLines -join "`r`n") | Out-File -FilePath $ggOut -Encoding UTF8
