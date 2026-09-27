# Test-WtCtrlC-2026-09-27.ps1
# Dated: 2026-09-27 10:57 ET
# Editor: Claude Code (CGDELL)
# Purpose: ascii45 C7 (FT-270, Ctrl+C ends with no confirmation). Checkup guards
#          Ctrl+C by telling Windows to hand it over as an ordinary key
#          ([Console]::TreatControlCAsInput, re-asserted before every read), and
#          then asks "are you sure?". This measures whether that guard works in
#          a full-screen Windows Terminal window, the way ascii45 will start.
#   Step 1: Ctrl+C with NOTHING highlighted -- caught as a key, or does it end
#           the program? (The 2026-09-27 10:49 copy test had no guard and ended.)
#   Step 2: Ctrl+C WITH text highlighted -- copied, and is it ALSO seen as a key?
# READ-ONLY. Changes nothing. Does not need administrator.
# Output: Test_Results\WtCtrlC-<machine>-<stamp>.txt

$outDir  = Join-Path (Split-Path -Parent $PSScriptRoot) "Test_Results"
if (-not (Test-Path $outDir)) { $outDir = $PSScriptRoot }
$outFile = Join-Path $outDir ("WtCtrlC-" + $env:COMPUTERNAME + "-" + (Get-Date -Format "yyyy-MM-dd_HH-mm") + ".txt")
$log = New-Object System.Collections.Generic.List[string]
function Note($s) { $log.Add(("[{0:HH:mm:ss}] " -f (Get-Date)) + $s) }
Note "Ctrl+C guard test -- $env:COMPUTERNAME -- Windows Terminal: $([bool]$env:WT_SESSION)"
$finished = $false

function Read-OneKey {
    try { [Console]::TreatControlCAsInput = $true } catch { Note "TreatControlCAsInput could not be set: $_" }
    return $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

try {
    Clear-Host
    Write-Host ""
    Write-Host "  CTRL+C TEST -- nothing on your PC is changed" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  STEP 1: Do NOT highlight anything. Press Ctrl+C once." -ForegroundColor White
    Write-Host "          (If this window closes, that is the answer -- it is recorded.)" -ForegroundColor Gray
    Write-Host ""
    $k = Read-OneKey
    if ($k.Character -eq [char]3) { Note "STEP 1: Ctrl+C with nothing highlighted arrived as a KEY -- the guard works (Checkup can ask first)"; Write-Host "  Got it -- Ctrl+C was caught. Checkup could ask 'are you sure?' here." -ForegroundColor Green }
    else { Note ("STEP 1: a different key arrived: VK " + $k.VirtualKeyCode) ; Write-Host "  That was a different key -- noted." -ForegroundColor Yellow }

    Write-Host ""
    Write-Host "  STEP 2: With the mouse, highlight THIS LINE, then press Ctrl+C once." -ForegroundColor White
    Write-Host "          Then press Enter." -ForegroundColor White
    Write-Host ""
    $sawCtrlC = $false
    do {
        $k = Read-OneKey
        if ($k.Character -eq [char]3) { $sawCtrlC = $true; Write-Host "  (Ctrl+C also arrived as a key)" -ForegroundColor DarkGray }
    } while ($k.VirtualKeyCode -ne 13)
    Note ("STEP 2: Ctrl+C with text highlighted ALSO arrived as a key: " + $sawCtrlC)
    try {
        $clip = Get-Clipboard -Raw -EA Stop
        Note ("STEP 2: clipboard now: " + (($clip -replace "\s+", " ").Trim()))
        Note ("STEP 2: copy worked (clipboard holds the step 2 line): " + [bool]($clip -match "highlight THIS LINE"))
    } catch { Note "STEP 2: clipboard could not be read: $_" }
    $finished = $true
    Write-Host ""
    Write-Host "  Done. This window closes in 3 seconds." -ForegroundColor Green
    Start-Sleep -Seconds 3
} finally {
    if (-not $finished) { Note "ENDED EARLY -- the program was stopped before the test finished (Ctrl+C was NOT caught)" }
    $log | Out-File -FilePath $outFile -Encoding UTF8
}
