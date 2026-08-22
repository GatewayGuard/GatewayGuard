# Dated: 2026-08-15 09:20 EDT
# File: Test-InputGate-2026-08-15.ps1
# Launcher: Run-InputGateTest.bat
#
#  WHAT THIS IS: the check for FT-171a, 171b and 171f in ascii40.
#
#  READ-ONLY IN THE SENSE THAT MATTERS: it changes the console input mode of
#  THIS window only, exactly as Checkup does, and puts it back before it
#  finishes. It touches no file, no registry key and no setting. Closing the
#  window at any point also restores the mode, because console modes do not
#  outlive the console.
#
#  DOES NOT NEED ADMINISTRATOR.
#
#  WHY IT EXISTS. FT-162's lesson, written in this project's own instructions:
#  a rule with no check is a wish. ascii40 claims three things about the
#  console that ascii39 also appeared to claim and did not deliver:
#
#    171a  ENABLE_MOUSE_INPUT is cleared, not just QuickEdit. ascii39's mask
#          cleared bit 6 and left bit 4 alone, and SANDY ran the whole
#          2026-08-11 field session with mouse reporting on.
#    171b  the drain is FlushConsoleInputBuffer, not a 256-read loop against a
#          256-record buffer.
#    171f  the flags are asserted before EVERY screen. In ascii39 the only two
#          calls were both inside Get-AllStatuses, most of the way through the
#          run.
#
#  IT READS THE FUNCTIONS OUT OF THE BUILD ITSELF, via the PowerShell AST,
#  rather than carrying its own copy. A test with its own copy of the code
#  proves the copy works. This one cannot drift from what ships.

#  -NoPause skips the closing Enter-to-close wait, so the check can be run
#  from a build script as well as by double-clicking the launcher. The
#  launcher does not pass it.
param([switch]$NoPause)

$ErrorActionPreference = "Stop"
Set-Location -Path $PSScriptRoot

$ggBuild = Get-ChildItem -Path $PSScriptRoot -Filter "W11-SecurityHardening-v3-*.ps1" |
           Sort-Object LastWriteTime -Descending | Select-Object -First 1

$ggOut = Join-Path $PSScriptRoot ("..\Test_Results\InputGate-" + $env:COMPUTERNAME + "-" +
         (Get-Date -Format "yyyy-MM-dd_HH-mm") + ".txt")

$ggLines = New-Object System.Collections.Generic.List[string]
function Say { param([string]$Text = "")
    Write-Host $Text
    $ggLines.Add($Text)
}

Say "============================================================"
Say " INPUT GATE CHECK -- FT-171a / 171b / 171f"
Say " Machine : $env:COMPUTERNAME"
Say " Run     : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ET"
Say " Build   : $($ggBuild.Name)"
Say " Changes the console mode of THIS window only, and puts it back."
Say "============================================================"
Say ""

# -- 1. Lift the three functions out of the build by AST ------------------
$ggErr = $null; $ggTok = $null
$ggAst = [System.Management.Automation.Language.Parser]::ParseFile($ggBuild.FullName, [ref]$ggTok, [ref]$ggErr)
if ($ggErr -and $ggErr.Count -gt 0) {
    Say "STOP: the build does not parse ($($ggErr.Count) error(s)). Nothing else here is meaningful."
    $ggLines -join "`r`n" | Out-File -FilePath $ggOut -Encoding ASCII
    exit 1
}

$ggWanted = @("Disable-QuickEdit", "Clear-PendingKeys", "Reset-GGInputGate")
$ggFound  = @{}
foreach ($ggFn in $ggAst.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true)) {
    if ($ggWanted -contains $ggFn.Name) { $ggFound[$ggFn.Name] = $ggFn.Extent.Text }
}

Say "FUNCTIONS LIFTED FROM THE BUILD"
Say "-------------------------------"
$ggMissing = @()
foreach ($ggW in $ggWanted) {
    if ($ggFound.ContainsKey($ggW)) { Say ("  found    " + $ggW) }
    else { Say ("  MISSING  " + $ggW); $ggMissing += $ggW }
}
Say ""
if ($ggMissing.Count -gt 0) {
    Say "STOP: $($ggMissing.Count) function(s) missing from the build. FAIL."
    $ggLines -join "`r`n" | Out-File -FilePath $ggOut -Encoding ASCII
    exit 1
}

# A stub for the one thing these functions call outward. Keeps the test
# honest -- it records the log lines instead of swallowing them, so the test
# can assert on what the build SAYS as well as what it does.
$script:GGLogged = New-Object System.Collections.Generic.List[string]
function Write-Log { param([string]$Message, [string]$Status = "")
    $script:GGLogged.Add("[$Status] $Message")
}

foreach ($ggW in $ggWanted) { . ([scriptblock]::Create($ggFound[$ggW])) }

# -- 2. Read the mode before -------------------------------------------------
$ggSig = @'
[DllImport("kernel32.dll", SetLastError=true)]
public static extern IntPtr GetStdHandle(int nStdHandle);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool GetConsoleMode(IntPtr hConsoleHandle, out uint lpMode);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool SetConsoleMode(IntPtr hConsoleHandle, uint dwMode);
'@
$ggProbe = Add-Type -MemberDefinition $ggSig -Name "InputGateProbe" -Namespace "GGTest" -PassThru

$ggH = $ggProbe::GetStdHandle(-10)
$ggBefore = [uint32]0
$ggHaveConsole = $ggProbe::GetConsoleMode($ggH, [ref]$ggBefore)

if (-not $ggHaveConsole) {
    Say "STOP: this window has no real console input handle -- input is redirected."
    Say "      Run this by double-clicking Run-InputGateTest.bat, not from a"
    Say "      script host or a piped session. Nothing was changed."
    $ggLines -join "`r`n" | Out-File -FilePath $ggOut -Encoding ASCII
    exit 2
}

$QUICKEDIT = [uint32]64
$MOUSE     = [uint32]16
$EXTENDED  = [uint32]128

Say ("CONSOLE MODE BEFORE : 0x{0:X8}  ({1})" -f $ggBefore, $ggBefore)
Say ("  ENABLE_QUICK_EDIT_MODE : " + $(if ($ggBefore -band $QUICKEDIT) { "SET" } else { "clear" }))
Say ("  ENABLE_MOUSE_INPUT     : " + $(if ($ggBefore -band $MOUSE)     { "SET" } else { "clear" }))
Say ""

# -- 3. Run the build's own Disable-QuickEdit and read the mode back ---------
$script:GGK32 = $null
$script:GGQuickEditLogged = $false
Disable-QuickEdit

$ggAfter = [uint32]0
[void]$ggProbe::GetConsoleMode($ggH, [ref]$ggAfter)

Say ("CONSOLE MODE AFTER  : 0x{0:X8}  ({1})" -f $ggAfter, $ggAfter)
Say ("  ENABLE_QUICK_EDIT_MODE : " + $(if ($ggAfter -band $QUICKEDIT) { "SET" } else { "clear" }))
Say ("  ENABLE_MOUSE_INPUT     : " + $(if ($ggAfter -band $MOUSE)     { "SET" } else { "clear" }))
Say ("  ENABLE_EXTENDED_FLAGS  : " + $(if ($ggAfter -band $EXTENDED)  { "SET" } else { "clear" }))
Say ""

$ggPass = 0; $ggFail = 0
function Check { param([string]$Name, [bool]$Ok, [string]$Detail = "")
    if ($Ok) { Say ("  PASS  " + $Name); $script:ggPass++ }
    else     { Say ("  FAIL  " + $Name + $(if ($Detail) { " -- $Detail" } else { "" })); $script:ggFail++ }
}

Say "ASSERTIONS"
Say "----------"
Check "171a  ENABLE_MOUSE_INPUT is clear after Disable-QuickEdit" (($ggAfter -band $MOUSE) -eq 0) `
      "this is the ascii39 defect -- the mask left bit 4 alone"
Check "      ENABLE_QUICK_EDIT_MODE is clear (FT-01, unchanged from ascii39)" (($ggAfter -band $QUICKEDIT) -eq 0)
Check "      ENABLE_EXTENDED_FLAGS is set (required for the other two to stick)" (($ggAfter -band $EXTENDED) -ne 0)
Check "171b  the cached P/Invoke type exposes FlushConsoleInputBuffer" `
      ($null -ne ($script:GGK32 | Get-Member -Static -Name FlushConsoleInputBuffer -ErrorAction SilentlyContinue)) `
      "Clear-PendingKeys would silently fall back to the capped read loop"

# -- 4. Exercise the flush and the gate --------------------------------------
$ggThrew = $null
try { Clear-PendingKeys } catch { $ggThrew = $_ }
Check "171b  Clear-PendingKeys runs without throwing" ($null -eq $ggThrew) "$ggThrew"

$ggThrew = $null
try { Reset-GGInputGate } catch { $ggThrew = $_ }
Check "171e  Reset-GGInputGate runs without throwing" ($null -eq $ggThrew) "$ggThrew"
Check "171e  Reset-GGInputGate stamps the render tick" ($script:GGScreenRenderTicks -gt 0)

# 171f: the gate must re-assert the flags, so that setting them back and
# calling it again leaves them cleared. This is the part ascii39 did not do.
[void]$ggProbe::SetConsoleMode($ggH, [uint32]($ggAfter -bor $MOUSE -bor $QUICKEDIT))
$ggDirty = [uint32]0
[void]$ggProbe::GetConsoleMode($ggH, [ref]$ggDirty)
Reset-GGInputGate
$ggRegated = [uint32]0
[void]$ggProbe::GetConsoleMode($ggH, [ref]$ggRegated)
Say ""
Say ("  (re-assert probe: forced mode to 0x{0:X8}, gate returned 0x{1:X8})" -f $ggDirty, $ggRegated)
Check "171f  Reset-GGInputGate RE-ASSERTS both flags on a dirtied console" `
      ((($ggRegated -band $MOUSE) -eq 0) -and (($ggRegated -band $QUICKEDIT) -eq 0)) `
      "the console host resets input mode on its own reads -- this is why it must re-assert"

# -- 5. Put the console back exactly as it was -------------------------------
[void]$ggProbe::SetConsoleMode($ggH, $ggBefore)
$ggRestored = [uint32]0
[void]$ggProbe::GetConsoleMode($ggH, [ref]$ggRestored)
Say ""
Say ("CONSOLE MODE RESTORED: 0x{0:X8}  (was 0x{1:X8})" -f $ggRestored, $ggBefore)
Check "      the console was left exactly as it was found" ($ggRestored -eq $ggBefore)

Say ""
Say "WHAT THE BUILD LOGGED WHILE THIS RAN"
Say "------------------------------------"
if ($script:GGLogged.Count -eq 0) { Say "  (nothing)" }
foreach ($ggL in $script:GGLogged) { Say ("  " + $ggL) }

Say ""
Say "============================================================"
Say (" $ggPass passed, $ggFail failed")
Say "============================================================"
Say ""
Say "STILL TO BE PROVED IN THE FIELD, ON SANDY, AND NOT BY THIS SCRIPT:"
Say "  * the mouse wheel still scrolls the window with bit 4 cleared."
Say "    sourced reasoning says it will; the opposite was written down"
Say "    first and was wrong, so it gets measured rather than argued."
Say "  * right-click, mouse drag and wheel spin at a live prompt no"
Say "    longer advance, answer or end the session."
Say ""

$ggLines -join "`r`n" | Out-File -FilePath $ggOut -Encoding ASCII
Write-Host "  Report written to: $ggOut"
Write-Host ""
if (-not $NoPause) {
    Write-Host "  Press Enter to close this window."
    $null = Read-Host
}

if ($ggFail -gt 0) { exit 1 }
exit 0
