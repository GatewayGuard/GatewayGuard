# Test-WtCtrlC2-2026-09-27.ps1
# Dated: 2026-09-27 11:13 ET
# Editor: Claude Code (CGDELL)
# Purpose: ascii45 C7 (FT-270), second method. MEASURED 2026-09-27 11:09
#          (Test_Results\WtCtrlC-CGDELL-2026-09-27_11-09.txt): in Windows
#          Terminal, Checkup's current guard -- [Console]::TreatControlCAsInput
#          -- does NOT work; Ctrl+C ended the program before any key arrived.
#          This tries the other way: catch the Ctrl+C SIGNAL itself
#          (Console.CancelKeyPress, handled in compiled code so it needs no
#          PowerShell thread) and cancel it, so Checkup can ask first.
#   Step 1 and step 2: press Ctrl+C with nothing highlighted, twice.
# READ-ONLY. Changes nothing. Does not need administrator.
# Output: Test_Results\WtCtrlC2-<machine>-<stamp>.txt

$outDir  = Join-Path (Split-Path -Parent $PSScriptRoot) "Test_Results"
if (-not (Test-Path $outDir)) { $outDir = $PSScriptRoot }
$outFile = Join-Path $outDir ("WtCtrlC2-" + $env:COMPUTERNAME + "-" + (Get-Date -Format "yyyy-MM-dd_HH-mm") + ".txt")
$log = New-Object System.Collections.Generic.List[string]
function Note($s) { $log.Add(("[{0:HH:mm:ss}] " -f (Get-Date)) + $s) }
Note "Ctrl+C signal test -- $env:COMPUTERNAME -- Windows Terminal: $([bool]$env:WT_SESSION)"
$finished = $false

try {
    Add-Type -TypeDefinition @"
using System;
public static class GGCtrlC {
    public static volatile int Count = 0;
    static bool armed = false;
    public static void Arm() {
        if (armed) return;
        armed = true;
        Console.CancelKeyPress += delegate(object s, ConsoleCancelEventArgs e) { e.Cancel = true; Count++; };
    }
}
"@
    [GGCtrlC]::Arm()
    Note "Handler armed. TreatControlCAsInput = $([Console]::TreatControlCAsInput)"

    function Wait-CtrlC($step) {
        $start = [GGCtrlC]::Count
        $t0 = Get-Date
        while (((Get-Date) - $t0).TotalSeconds -lt 60) {
            if ([GGCtrlC]::Count -gt $start) { return $true }
            try { while ($Host.UI.RawUI.KeyAvailable) { $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown,AllowCtrlC") } } catch {}
            Start-Sleep -Milliseconds 100
        }
        return $false
    }

    Clear-Host
    Write-Host ""
    Write-Host "  CTRL+C TEST (second method) -- nothing on your PC is changed" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  STEP 1: Do NOT highlight anything. Press Ctrl+C once." -ForegroundColor White
    Write-Host "          If this window closes, that is the answer -- it is recorded." -ForegroundColor Gray
    Write-Host ""
    if (Wait-CtrlC 1) {
        Note "STEP 1: Ctrl+C CAUGHT and cancelled -- the program kept running"
        Write-Host "  Got it -- Ctrl+C was caught and the program kept running." -ForegroundColor Green
    } else { Note "STEP 1: no Ctrl+C within 60 s" ; Write-Host "  No Ctrl+C seen in 60 seconds -- noted." -ForegroundColor Yellow }

    Write-Host ""
    Write-Host "  STEP 2: Press Ctrl+C once more." -ForegroundColor White
    Write-Host ""
    if (Wait-CtrlC 2) {
        Note "STEP 2: Ctrl+C CAUGHT again -- it works every time, not just once"
        Write-Host "  Caught again. This window closes in 3 seconds." -ForegroundColor Green
    } else { Note "STEP 2: no Ctrl+C within 60 s"; Write-Host "  No Ctrl+C seen -- noted. Closing in 3 seconds." -ForegroundColor Yellow }
    $finished = $true
    Start-Sleep -Seconds 3
} finally {
    if (-not $finished) { Note "ENDED EARLY -- the program was stopped (Ctrl+C was NOT caught by this method either)" }
    Note ("Ctrl+C signals counted: " + $(try { [GGCtrlC]::Count } catch { "n/a" }))
    $log | Out-File -FilePath $outFile -Encoding UTF8
}
