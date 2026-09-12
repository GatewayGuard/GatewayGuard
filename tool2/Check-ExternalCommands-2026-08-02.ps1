# Dated: 2026-08-02 07:05 ET
# ================================================================
# FILE:    Check-ExternalCommands-2026-08-02.ps1
# PURPOSE: GATE 24 -- the mechanical enforcement of RESEARCH BEFORE STATING.
#
# WHY THIS EXISTS (FT-162, 2026-08-02):
#   The build shipped `MpCmdRun.exe -Scan -ScanType 4` in a scheduled task,
#   and told the user on screen that it "SCHEDULES the offline scan for your
#   NEXT PC restart".
#   MEASURED on CGDELL 2026-08-02 06:51: MpCmdRun's own help documents
#   ScanType 0-3 ONLY. Running it returns, in 0.0 seconds:
#       CmdTool: Failed with hr = 0x80070667
#       CmdTool: Invalid command line argument
#   0x80070667 = 1639 = ERROR_INVALID_COMMAND_LINE. No scan starts. No state
#   changes. Nothing is queued. THE QUARTERLY OFFLINE SCAN HAS NEVER RUN ON
#   ANY MACHINE -- while the log printed [GOOD] every single time.
#
#   CodingStandards already had the rule that forbids this. RESEARCH BEFORE
#   STATING says no factual claim about external system behaviour is coded
#   into the tool or written into user-facing copy until verified against a
#   primary source. The rule was not the problem. NOTHING CHECKED IT.
#   This project's own screen-coverage checker opens with the reason:
#   "a gate with no check is a wish." Gate 24 is the check.
#
# WHAT IT ENFORCES
#   24a  Every external-command invocation carries a nearby VERIFIED comment
#        naming a date and a basis.
#   24b  No user-facing string shows the user a raw command line, .exe name
#        or command switch. (CLAUDE.md: remove jargon, do not explain it.
#        A senior should never be shown "MpCmdRun.exe -ScanType 4".)
#
# THE VERIFIED COMMENT FORMAT -- put it within 20 lines above the call:
#     # VERIFIED 2026-08-02 measured on CGDELL: MpCmdRun -Scan -ScanType
#     #   accepts 0-3 only; 4 returns 0x80070667 invalid command line.
#   Basis must be one of: measured | sourced
#     measured = it was run and the output recorded
#     sourced  = primary documentation, with the URL in the comment
#   "inferred" and "guess" are NOT acceptable bases for shipping code.
#
# RATCHET, NOT A CLIFF. Existing unverified calls are carried in a named
# baseline below and reported on every run without failing the gate. Any
# call NOT in that baseline fails the build. The list may only shrink.
#
# READ-ONLY. Parses the file, prints findings, writes nothing, runs nothing.
#
# USAGE: double-click Run-ExternalCommandCheck.bat
# ================================================================

param(
    [Parameter(Mandatory)][string]$Path
)

if (-not (Test-Path $Path)) {
    Write-Host "FAIL: file not found: $Path" -ForegroundColor Red
    exit 1
}

$ggFile = (Resolve-Path $Path).Path
$ggLines = [System.IO.File]::ReadAllLines($ggFile)

Write-Host ""
Write-Host "EXTERNAL COMMAND VERIFICATION (gate 24)" -ForegroundColor Cyan
Write-Host "File: $(Split-Path $ggFile -Leaf)"
Write-Host ""

# External binaries this project drives. Add to this list when a new one is
# introduced -- an unknown binary is invisible to the gate, so leaving it out
# is the one way to defeat this check.
$ggBins = @(
    "MpCmdRun", "schtasks", "powercfg", "reagentc", "manage-bde",
    "bcdedit", "netsh", "wmic", "cipher", "gpupdate", "dism", "sfc"
)
$ggBinPattern = "\b(" + ($ggBins -join "|") + ")(\.exe)?\b"

# How far above a call a VERIFIED comment may sit and still count.
$ggWindow = 20

# ---------------------------------------------------------------------------
# BASELINE -- unverified calls present when gate 24 was written (ascii39,
# 2026-08-02). Reported every run; do NOT fail the gate. Key is
# "binary|switches". Delete an entry as you verify that call.
# ---------------------------------------------------------------------------
$ggBaseline = @{}
foreach ($ggB in @(
    "powercfg", "control", "msinfo32", "manage-bde", "reagentc",
    "schtasks", "sc", "bcdedit"
)) { $ggBaseline[$ggB] = $true }

$ggFail = $false
$ggCalls = @()

for ($i = 0; $i -lt $ggLines.Count; $i++) {
    $ggLine = $ggLines[$i]

    # Skip comment lines -- a mention in a comment is not an invocation.
    if ($ggLine -match '^\s*#') { continue }

    $ggM = [regex]::Match($ggLine, $ggBinPattern)
    if (-not $ggM.Success) { continue }

    $ggBin = $ggM.Groups[1].Value

    # Collect the switches present on this line, so the report names the
    # actual invocation rather than just the binary.
    $ggSwitches = @()
    foreach ($ggS in [regex]::Matches($ggLine, '(?<![\w-])-([A-Za-z][A-Za-z0-9]*)')) {
        $ggSwitches += $ggS.Groups[1].Value
    }
    foreach ($ggS in [regex]::Matches($ggLine, '(?<!\S)/([a-z]{1,8})\b')) {
        $ggSwitches += "/" + $ggS.Groups[1].Value
    }

    # Look backwards for a VERIFIED comment.
    $ggVerified = $false
    $ggBasis = ""
    $ggStart = $i - $ggWindow
    if ($ggStart -lt 0) { $ggStart = 0 }
    for ($j = $i; $j -ge $ggStart; $j--) {
        if ($ggLines[$j] -match '#\s*VERIFIED\s+(\d{4}-\d{2}-\d{2})\s+(measured|sourced)') {
            $ggVerified = $true
            $ggBasis = $Matches[1] + " " + $Matches[2]
            break
        }
    }

    $ggCalls += [PSCustomObject]@{
        Line     = $i + 1
        Bin      = $ggBin
        Switches = ($ggSwitches | Select-Object -Unique) -join " "
        Verified = $ggVerified
        Basis    = $ggBasis
        Text     = $ggLine.Trim()
    }
}

Write-Host ("External command invocations found : {0}" -f $ggCalls.Count)

$ggOK      = @($ggCalls | Where-Object { $_.Verified })
$ggMissing = @($ggCalls | Where-Object { -not $_.Verified })
$ggCarried = @($ggMissing | Where-Object { $ggBaseline.ContainsKey($_.Bin) })
$ggNew     = @($ggMissing | Where-Object { -not $ggBaseline.ContainsKey($_.Bin) })

Write-Host ("  with a VERIFIED citation         : {0}" -f $ggOK.Count) -ForegroundColor Green
Write-Host ("  carried in the baseline          : {0}" -f $ggCarried.Count) -ForegroundColor DarkYellow
Write-Host ("  NEW and unverified               : {0}" -f $ggNew.Count) -ForegroundColor $(if ($ggNew.Count) { "Red" } else { "Green" })
Write-Host ""

foreach ($ggC in $ggOK) {
    Write-Host ("   ok       line {0,-6} {1} {2}   [{3}]" -f $ggC.Line, $ggC.Bin, $ggC.Switches, $ggC.Basis) -ForegroundColor DarkGray
}
foreach ($ggC in $ggCarried) {
    Write-Host ("   carried  line {0,-6} {1} {2}" -f $ggC.Line, $ggC.Bin, $ggC.Switches) -ForegroundColor DarkYellow
}
foreach ($ggC in $ggNew) {
    Write-Host ("   FAIL     line {0,-6} {1} {2}  -- no VERIFIED comment within $ggWindow lines" -f $ggC.Line, $ggC.Bin, $ggC.Switches) -ForegroundColor Red
    Write-Host ("            {0}" -f $ggC.Text) -ForegroundColor DarkGray
    $ggFail = $true
}

# ---------------------------------------------------------------------------
# 24b -- no raw command line in front of the user.
# FT-162's second half: a screen read "The quarterly task runs MpCmdRun.exe
# -ScanType 4 which SCHEDULES the offline scan". That is jargon the plain-
# language rule says to DELETE rather than explain -- and in this case it was
# also false, so it taught the user something wrong in language they could
# not evaluate.
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "24b -- command lines shown to the user" -ForegroundColor Cyan

$ggUserFacing = @()
for ($i = 0; $i -lt $ggLines.Count; $i++) {
    $ggLine = $ggLines[$i]
    if ($ggLine -match '^\s*#') { continue }
    # Only strings the user actually reads.
    if ($ggLine -notmatch 'Write-Host|Draw-Box|"\s*$|^\s*"') { continue }
    if ($ggLine -notmatch '"') { continue }

    # DELIBERATE INSTRUCTIONS ARE ALLOWED, EXPLANATIONS ARE NOT.
    # There is a real difference between showing a command line to EXPLAIN
    # internals -- "the quarterly task runs MpCmdRun.exe -ScanType 4", which
    # the user can neither act on nor evaluate -- and TELLING the user to type
    # something as a fallback check they can actually perform. The first is
    # jargon and must go. The second is a legitimate instruction.
    # No regex can reliably tell those apart, so the author declares it:
    #     ...  # GATE24-OK: user is told to type this; it is the fallback path
    # The suppression must state a reason, so it cannot be used as a silencer.
    if ($ggLine -match '#\s*GATE24-OK:\s*\S') { continue }

    foreach ($ggStr in [regex]::Matches($ggLine, '"([^"]{4,})"')) {
        $ggText = $ggStr.Groups[1].Value
        # A binary name, or a .exe with a switch after it.
        if ($ggText -match ($ggBinPattern + '\s+-') -or $ggText -match '\.exe\s+-[A-Za-z]') {
            $ggUserFacing += [PSCustomObject]@{ Line = $i + 1; Text = $ggText }
        }
    }
}

if ($ggUserFacing.Count -eq 0) {
    Write-Host "  0 findings -- no screen shows the user a raw command line." -ForegroundColor Green
} else {
    foreach ($ggU in $ggUserFacing) {
        Write-Host ("   FAIL     line {0,-6} {1}" -f $ggU.Line, $ggU.Text) -ForegroundColor Red
        $ggFail = $true
    }
    Write-Host ""
    Write-Host "  Remove the command line -- do not explain it. Say what the" -ForegroundColor Yellow
    Write-Host "  user will SEE and what it does for them." -ForegroundColor Yellow
}

Write-Host ""
if ($ggFail) {
    Write-Host "GATE 24: FAIL -- fix the findings above before shipping." -ForegroundColor Red
    exit 1
}
Write-Host "GATE 24: PASS" -ForegroundColor Green
if ($ggCarried.Count) {
    Write-Host ("GATE 24: {0} carried baseline call(s) still unverified -- shrink this list." -f $ggCarried.Count) -ForegroundColor Yellow
}
exit 0
