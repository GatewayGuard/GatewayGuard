# Test-WtCopySelect-2026-09-26.ps1
# Dated: 2026-09-26 12:07 ET
# Editor: Claude Code (CGDELL)
# Purpose: ascii45 C9 (full-screen launch). Two things must be MEASURED in
#          Windows Terminal before screens 3, 4 and 8 are rewritten:
#   A. Does selecting text PAUSE the program? (In the classic console it did --
#      FT-63.) Every tick's time is written to the results file, so a pause
#      shows up as a gap, whatever anyone remembers.
#   B. What does Ctrl+C do? With text selected it should copy (the script then
#      checks the clipboard itself); with nothing selected it stops the program
#      (the results file records where it stopped).
# READ-ONLY. Changes nothing on the PC. Launched by Run-TestWtCopySelect.bat in a
#          full-screen Windows Terminal window, the way Checkup will start.
# Output: Test_Results\WtCopySelect-<machine>-<stamp>.txt

param([int]$Seconds = 120)

$outDir  = Join-Path (Split-Path -Parent $PSScriptRoot) "Test_Results"
if (-not (Test-Path $outDir)) { $outDir = $PSScriptRoot }
$outFile = Join-Path $outDir ("WtCopySelect-" + $env:COMPUTERNAME + "-" + (Get-Date -Format "yyyy-MM-dd_HH-mm") + ".txt")
$ticks = New-Object System.Collections.Generic.List[datetime]
$stoppedEarly = $true

Clear-Host
Write-Host ""
Write-Host "  COPY AND SELECTION TEST -- Windows Terminal, full screen" -ForegroundColor Cyan
Write-Host "  Nothing on your PC is changed. The numbers below keep counting." -ForegroundColor Gray
Write-Host ""
Write-Host "  STEP 1: With the mouse, drag across some of the lines below so they" -ForegroundColor White
Write-Host "          are highlighted. Keep them highlighted for about 5 seconds." -ForegroundColor White
Write-Host "  STEP 2: While they are still highlighted, press Ctrl+C once." -ForegroundColor White
Write-Host "  STEP 3: Click once on an empty part of the window (the highlight goes)," -ForegroundColor White
Write-Host "          wait 5 seconds, then press Ctrl+C once more." -ForegroundColor White
Write-Host ""
Write-Host "  After step 3 the window may close by itself. That is expected." -ForegroundColor Gray
Write-Host "  If it does not, it closes on its own after $Seconds seconds." -ForegroundColor Gray
Write-Host ""

$start = Get-Date
try {
    $n = 0
    while (((Get-Date) - $start).TotalSeconds -lt $Seconds) {
        $n++
        $ticks.Add((Get-Date))
        Write-Host ("  tick {0,4}   {1}" -f $n, (Get-Date -Format "HH:mm:ss.fff"))
        Start-Sleep -Milliseconds 500
    }
    $stoppedEarly = $false
} finally {
    # Runs even when Ctrl+C stops the script.
    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add("Windows Terminal copy/selection test -- $env:COMPUTERNAME -- started $($start.ToString('yyyy-MM-dd HH:mm:ss'))")
    try { $lines.Add("Host: WT_SESSION present = $([bool]$env:WT_SESSION)  (True means it really ran inside Windows Terminal)") } catch {}
    $lines.Add("Ticks written: $($ticks.Count)   (one every 0.5 s when nothing pauses the program)")
    $lines.Add("Ended: $(if ($stoppedEarly) { 'STOPPED EARLY -- by Ctrl+C or the window closing' } else { 'ran the full ' + $Seconds + ' seconds' }) at $((Get-Date).ToString('HH:mm:ss'))")
    $maxGap = 0; $gapAt = ""
    for ($i = 1; $i -lt $ticks.Count; $i++) {
        $g = ($ticks[$i] - $ticks[$i-1]).TotalSeconds
        if ($g -gt $maxGap) { $maxGap = $g; $gapAt = $ticks[$i-1].ToString('HH:mm:ss') }
    }
    $lines.Add(("Longest gap between ticks: {0:N2} s (starting {1}). Normal is about 0.5 s; a gap of several seconds while text was highlighted means selecting PAUSES the program." -f $maxGap, $gapAt))
    try {
        $clip = Get-Clipboard -Raw -EA Stop
        $hasTick = ($clip -match 'tick\s+\d+')
        $lines.Add("Clipboard now holds tick lines: $hasTick  (True means step 2's Ctrl+C COPIED the highlighted text)")
        if ($clip) { $lines.Add("Clipboard starts: " + (($clip -split "`n")[0]).Trim()) }
    } catch { $lines.Add("Clipboard: could not read -- $($_.Exception.Message)") }
    $lines | Out-File -FilePath $outFile -Encoding UTF8
}
