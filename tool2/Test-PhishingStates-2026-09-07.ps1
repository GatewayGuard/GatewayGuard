# =====================================================================
#  Test-PhishingStates-2026-09-07.ps1
#
#  WHAT WILL CHECKUP SAY, IN EVERY POSSIBLE CIRCUMSTANCE?
#
#  Bill, 2026-09-07: "set up a test to make sure we know what will happen
#  in all possible circumstances."
#
#  READ-ONLY ON THE REAL SETTING. It never writes to the real phishing
#  protection key -- it cannot, because Tamper Protection refuses, and it
#  should not want to. The only key it writes is a throwaway of its own
#  under HKCU, which it deletes and verifies gone.
#
#  WHY THIS TEST EXISTS
#  --------------------
#  Bill's screen, 2026-09-07: Windows Security shows ALL FOUR phishing
#  protection boxes TICKED. Measured the same minute: every one of the
#  four registry values Checkup reads is NOT SET, and the key that holds
#  them exists but is empty.
#
#  So ABSENT DOES NOT MEAN OFF. It means "Windows default", and the
#  default is on. Checkup assumes the opposite, and its own comment says
#  an absent key means not configured "which for an absent key is true".
#  The screen says it is not true.
#
#  HOW IT WORKS, IN TWO HALVES
#  ---------------------------
#  PART 1, the logic table. It pulls Checkup's REAL item 6 check out of
#  the built .ps1 by regex -- so the test cannot drift from the shipped
#  code -- points it at a throwaway registry key, and runs it against
#  every state that key can be in. That answers "what will Checkup say"
#  for cases we may never be able to produce on a real machine, including
#  a read refused by Tamper Protection.
#
#  PART 2, the reality map. Tamper Protection means these values can only
#  be changed by Windows itself, through the Windows Security window. So
#  the real-world half cannot be automated: Bill sets a combination of
#  switches on screen, runs this, and it records what the registry then
#  holds and what Checkup would say about it. Every run appends one row,
#  so the map builds up over several runs.
#
#  THE POINT OF PAIRING THEM: part 1 says what the code does with a given
#  registry state. Part 2 says which registry states real machines
#  actually reach. A verdict is only wrong when both halves are known.
# =====================================================================

param(
    [string]$Label = "",
    [switch]$SkipLogicTable
)

$ErrorActionPreference = "Continue"

$ggReal   = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components"
$ggTest   = "HKCU:\Software\GGPhishStateTest"

$ggStamp  = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ggRoot   = Split-Path $PSScriptRoot -Parent
$ggOutDir = Join-Path $ggRoot "Test_Results"
if (-not (Test-Path $ggOutDir)) { New-Item -ItemType Directory -Path $ggOutDir -Force | Out-Null }
$ggOut = Join-Path $ggOutDir "PhishingStates-$env:COMPUTERNAME-$ggStamp.txt"
$ggMap = Join-Path $ggOutDir "PhishingStates-RealityMap-$env:COMPUTERNAME.csv"

$ggLines = New-Object System.Collections.ArrayList
function Add-Line { param([string]$T = "") ; $null = $ggLines.Add($T) ; Write-Host $T }

Add-Line "======================================================================"
Add-Line "  PHISHING PROTECTION -- WHAT CHECKUP SAYS IN EVERY CIRCUMSTANCE"
Add-Line "  $env:COMPUTERNAME   $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Add-Line "======================================================================"
Add-Line ""
Add-Line "  The real setting is only READ. Tamper Protection means nothing but"
Add-Line "  Windows can change it, which is why part 2 needs you at the screen."
Add-Line ""

# ---- pull Checkup's real check out of the built file -----------------
$ggBuild = @(Get-ChildItem (Join-Path $ggRoot "Tool") -Filter "W11-SecurityHardening-v3-*.ps1" -EA SilentlyContinue |
             Sort-Object LastWriteTime -Descending)
if ($ggBuild.Count -eq 0) {
    Add-Line "  STOPPED -- no build .ps1 found in Tool\."
    ($ggLines -join "`r`n") | Out-File -FilePath $ggOut -Encoding UTF8 ; exit 1
}
$ggBuildPath = $ggBuild[0].FullName
Add-Line ("  Testing the check inside: {0}" -f (Split-Path $ggBuildPath -Leaf))

$ggSrc   = Get-Content -LiteralPath $ggBuildPath -Raw
$ggMatch = [regex]::Match($ggSrc, '(?s)                try \{\r?\n                    \$pp = \$null.*?\r?\n                \} catch \{ \$s\.Status = "Unknown -- could not check; verify by hand" \}')
if (-not $ggMatch.Success) {
    Add-Line "  STOPPED -- could not find item 6's check in the build. If the code"
    Add-Line "  was reshaped, update the pattern in this script to match."
    ($ggLines -join "`r`n") | Out-File -FilePath $ggOut -Encoding UTF8 ; exit 1
}
$ggBlock = $ggMatch.Value
Add-Line ("  Extracted item 6's check: {0} characters, verbatim from the build." -f $ggBlock.Length)
Add-Line ""

function Invoke-GGCheck {
    param([string]$Path)
    $code = $ggBlock.Replace($ggReal, $Path)
    $s = [PSCustomObject]@{ Status = 'Pending' }
    function Write-Log { param($Message, $Status) }
    & ([scriptblock]::Create($code))
    return [string]$s.Status
}

# =====================================================================
#  PART 1 -- THE LOGIC TABLE
# =====================================================================
if (-not $SkipLogicTable) {
    Add-Line "----------------------------------------------------------------------"
    Add-Line "  PART 1 -- WHAT THE CODE DOES WITH EVERY REGISTRY STATE"
    Add-Line "----------------------------------------------------------------------"
    Add-Line ""
    Add-Line "  Run against a throwaway key, not the real one. The 4 values are"
    Add-Line "  ServiceEnabled / NotifyMalicious / NotifyPasswordReuse /"
    Add-Line "  NotifyUnsafeApp, shown in that order. '-' means the value is absent."
    Add-Line ""

    $ggCases = @(
        @{ Name = "key does not exist at all";            Make = "nokey"; V = $null }
        @{ Name = "key exists but is EMPTY  <-- CGDELL";  Make = "empty"; V = $null }
        @{ Name = "1 1 1 1   all four written on";        Make = "vals";  V = @(1,1,1,1) }
        @{ Name = "0 0 0 0   all four written off";       Make = "vals";  V = @(0,0,0,0) }
        @{ Name = "0 1 1 1   service off, rest on";       Make = "vals";  V = @(0,1,1,1) }
        @{ Name = "1 0 1 1   malicious sites off";        Make = "vals";  V = @(1,0,1,1) }
        @{ Name = "1 1 0 1   password reuse off";         Make = "vals";  V = @(1,1,0,1) }
        @{ Name = "1 1 1 0   unsafe storage off";         Make = "vals";  V = @(1,1,1,0) }
        @{ Name = "1 0 0 0   service on, all warns off";  Make = "vals";  V = @(1,0,0,0) }
        @{ Name = "1 1 1 -   one value simply absent";    Make = "vals";  V = @(1,1,1,$null) }
        @{ Name = "-  1 1 1  service value absent";       Make = "vals";  V = @($null,1,1,1) }
    )

    foreach ($c in $ggCases) {
        if (Test-Path $ggTest) { Remove-Item -LiteralPath $ggTest -Recurse -Force -EA SilentlyContinue }
        if ($c.Make -ne "nokey") {
            New-Item -Path $ggTest -Force | Out-Null
            if ($c.Make -eq "vals") {
                $names = @("ServiceEnabled","NotifyMalicious","NotifyPasswordReuse","NotifyUnsafeApp")
                for ($i = 0; $i -lt 4; $i++) {
                    if ($null -ne $c.V[$i]) {
                        New-ItemProperty -Path $ggTest -Name $names[$i] -Value $c.V[$i] -PropertyType DWord -Force | Out-Null
                    }
                }
            }
        }
        $verdict = Invoke-GGCheck -Path $ggTest
        $flag = ""
        if ($verdict -match "GOOD") { $flag = "" }
        Add-Line ("  {0,-38} -> {1}{2}" -f $c.Name, $verdict, $flag)
    }

    if (Test-Path $ggTest) { Remove-Item -LiteralPath $ggTest -Recurse -Force -EA SilentlyContinue }
    Add-Line ""
    Add-Line ("  throwaway key removed: {0}" -f (-not (Test-Path $ggTest)))
    Add-Line ""
    Add-Line "  NOT REPRODUCIBLE HERE: a read REFUSED by Tamper Protection. The"
    Add-Line "  code answers that with 'Unknown -- Tamper Protection blocks this"
    Add-Line "  check; verify by hand', which is the right answer and was put"
    Add-Line "  there by FT-141. It cannot be provoked on a throwaway key,"
    Add-Line "  because only the real key is protected."
    Add-Line ""
}

# =====================================================================
#  PART 2 -- THE REALITY MAP
# =====================================================================
Add-Line "----------------------------------------------------------------------"
Add-Line "  PART 2 -- WHAT THIS MACHINE ACTUALLY HOLDS, RIGHT NOW"
Add-Line "----------------------------------------------------------------------"
Add-Line ""
if ($Label -ne "") { Add-Line ("  What the screen was set to: {0}" -f $Label) ; Add-Line "" }

$ggKeyThere = Test-Path $ggReal
Add-Line ("  key exists : {0}   ({1})" -f $ggKeyThere, $ggReal)
$ggNow = Get-ItemProperty -Path $ggReal -EA SilentlyContinue
$ggVals = @()
foreach ($n in @("ServiceEnabled","NotifyMalicious","NotifyPasswordReuse","NotifyUnsafeApp")) {
    $v = if ($ggNow -and $null -ne $ggNow.$n) { $ggNow.$n } else { "-" }
    $ggVals += "$v"
    Add-Line ("    {0,-22} {1}" -f $n, $(if ("$v" -eq "-") { "NOT SET" } else { $v }))
}
Add-Line ""

$ggVerdict = Invoke-GGCheck -Path $ggReal
Add-Line ("  CHECKUP WOULD SAY:  {0}" -f $ggVerdict)
Add-Line ""

# ---- append one row to the cumulative map ----------------------------
$ggRow = [PSCustomObject]@{
    When            = (Get-Date -Format "yyyy-MM-dd HH:mm")
    ScreenSetTo     = $(if ($Label -eq "") { "(not stated)" } else { $Label })
    KeyExists       = $ggKeyThere
    RegistryValues  = ($ggVals -join " ")
    CheckupSays     = $ggVerdict
}
if (Test-Path $ggMap) { $ggRow | Export-Csv -LiteralPath $ggMap -NoTypeInformation -Append }
else                  { $ggRow | Export-Csv -LiteralPath $ggMap -NoTypeInformation }

Add-Line "----------------------------------------------------------------------"
Add-Line "  THE MAP SO FAR -- every run of this test, oldest first"
Add-Line "----------------------------------------------------------------------"
Add-Line ""
foreach ($r in @(Import-Csv -LiteralPath $ggMap -EA SilentlyContinue)) {
    Add-Line ("  {0}  screen: {1}" -f $r.When, $r.ScreenSetTo)
    Add-Line ("     registry [{0}]  ->  {1}" -f $r.RegistryValues, $r.CheckupSays)
}
Add-Line ""
Add-Line ("  Map file: {0}" -f $ggMap)
Add-Line ""
Add-Line "----------------------------------------------------------------------"
Add-Line "  HOW TO FILL IN THE REST"
Add-Line "----------------------------------------------------------------------"
Add-Line ""
Add-Line "  Only Windows can change these values, so each combination has to be"
Add-Line "  set on screen and then read here. In Windows Security ->"
Add-Line "  App and browser control -> Reputation-based protection settings ->"
Add-Line "  Phishing protection."
Add-Line ""
Add-Line "  Worth capturing, in this order:"
Add-Line "    1. all four ON            (the normal machine)"
Add-Line "    2. the service OFF        (the top switch off)"
Add-Line "    3. service ON, one warning OFF"
Add-Line "    4. back to all four ON    (leave the machine safe)"
Add-Line ""
Add-Line "  Run this after each change. Every run adds a row above, so the"
Add-Line "  screen-to-registry map builds up as you go."
Add-Line ""
Add-Line "  ** Put the machine back to all four ON when finished. **"
Add-Line ""
Add-Line "======================================================================"
Add-Line ("  Saved to: {0}" -f $ggOut)
Add-Line "======================================================================"

($ggLines -join "`r`n") | Out-File -FilePath $ggOut -Encoding UTF8
