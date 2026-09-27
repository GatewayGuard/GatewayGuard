# Test-CtrlCRepro-2026-09-27.ps1
# Dated: 2026-09-27 14:53 ET
# Editor: Claude Code (CGDELL)
# Purpose: Bill, 2026-09-27: in full-screen ascii45 "tried copy and control c ...
#          and it ended the program" (log GatewayGuard-Log-2026-09-27_14-29.txt:
#          no Ctrl+C line, no confirm screen, PowerShell exited 14:31:57).
#          The 11:27 test that PASSED had only the CancelKeyPress handler. Checkup
#          also has the FT-150 console handler and a key reader that re-asserts
#          TreatControlCAsInput. This loads Checkup's OWN functions from the build
#          and waits for keys exactly as Checkup does.
#   -Mode Built    (launcher A): Register-ConsoleCtrl + Enable-GGCtrlCGuard +
#                  Read-GGKey, exactly as built
#   -Mode NoTreat  (launcher B): the same, but TreatControlCAsInput is never set
# READ-ONLY. Changes nothing. Run by Bill with Run-TestCtrlCRepro-A.bat / -B.bat.
# Output: Test_Results\CtrlCRepro-<mode>-<machine>-<stamp>.txt

param([string]$Mode = "Built")
$root = Split-Path -Parent $PSScriptRoot
$Build = Get-ChildItem (Join-Path $root "Tool") -Filter "W11-SecurityHardening-v3-ascii*.ps1" | Sort-Object LastWriteTime | Select-Object -Last 1 -ExpandProperty FullName
$outFile = Join-Path $root ("Test_Results\CtrlCRepro-" + $Mode + "-" + $env:COMPUTERNAME + "-" + (Get-Date -Format "yyyy-MM-dd_HH-mm-ss") + ".txt")
$script:logFile = $outFile
function Write-Log { param($Message, $Status) Add-Content -Path $script:logFile -Value ("[{0:HH:mm:ss}] [{1}] {2}" -f (Get-Date), $Status, $Message) }
Write-Log "Ctrl+C reproduction, mode $Mode, Windows Terminal: $([bool]$env:WT_SESSION), build: $(Split-Path -Leaf $Build)" "START"
$finished = $false
try {
    $ast = [System.Management.Automation.Language.Parser]::ParseFile($Build, [ref]$null, [ref]$null)
    foreach ($n in "Register-ConsoleCtrl","Enable-GGCtrlCGuard","Read-GGKey") {
        $fn = $ast.FindAll({ param($a) $a -is [System.Management.Automation.Language.FunctionDefinitionAst] -and $a.Name -eq $n }, $true)
        . ([scriptblock]::Create($fn[0].Extent.Text))
    }
    Register-ConsoleCtrl -Path $outFile
    Enable-GGCtrlCGuard
    if ($Mode -eq "NoTreat") {
        function Read-GGKey {
            while ($true) {
                $c = 0; try { $c = [GGCtrlC]::Count } catch {}
                if ($c -gt $script:GGCtrlCHandled) { $script:GGCtrlCHandled = $c; return (New-Object System.Management.Automation.Host.KeyInfo -ArgumentList 67, ([char]3), ([System.Management.Automation.Host.ControlKeyStates]::LeftCtrlPressed), $true) }
                if ($Host.UI.RawUI.KeyAvailable) { return $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") }
                Start-Sleep -Milliseconds 50
            }
        }
    }
    function Wait-Key($step) {
        do { $k = Read-GGKey } while ($k.VirtualKeyCode -in @(16, 17, 18))
        $caught = ($k.Character -eq [char]3)
        Write-Log ("step " + $step + ": key code " + $k.VirtualKeyCode + ", char " + [int][char]$k.Character + $(if ($caught) { "  <-- Ctrl+C CAUGHT (Checkup would ask first)" } else { "" })) "KEY"
        return $caught
    }
    Clear-Host
    Write-Host ""
    Write-Host "  CTRL+C TEST $(if ($Mode -eq 'Built') { 'A (as Checkup is built)' } else { 'B (one setting removed)' }) -- nothing is changed" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  STEP 1: Do NOT highlight anything. Press Ctrl+C once." -ForegroundColor White
    Write-Host "          If this window closes, that is the answer -- it is recorded." -ForegroundColor Gray
    Write-Host ""
    if (Wait-Key 1) { Write-Host "  Caught -- the program is still running." -ForegroundColor Green } else { Write-Host "  A different key arrived -- noted." -ForegroundColor Yellow }
    Write-Host ""
    Write-Host "  STEP 2: Highlight THIS LINE with the mouse, then press Ctrl+C once." -ForegroundColor White
    Write-Host "          Then press Enter." -ForegroundColor White
    Write-Host ""
    do { $k = Read-GGKey; if ($k.Character -eq [char]3) { Write-Log "step 2: Ctrl+C ALSO arrived as a key while text was highlighted" "KEY" } } while ($k.VirtualKeyCode -ne 13)
    try { $clip = Get-Clipboard -Raw -EA Stop; Write-Log ("step 2: copied: " + [bool]($clip -match "highlight THIS LINE") + " -- clipboard starts: " + (($clip -replace "\s+", " ").Trim()).Substring(0, [Math]::Min(60, (($clip -replace "\s+", " ").Trim()).Length))) "KEY" } catch { Write-Log "step 2: clipboard not readable" "KEY" }
    $finished = $true
    Write-Log "finished normally -- the program survived both steps" "DONE"
    Write-Host ""
    Write-Host "  Done. This window closes in 3 seconds." -ForegroundColor Green
    Start-Sleep -Seconds 3
} catch {
    Write-Log ("error: " + $_) "ERROR"
} finally {
    if (-not $finished) { Write-Log "ENDED EARLY -- the program was stopped before the test finished" "EXIT" }
}
