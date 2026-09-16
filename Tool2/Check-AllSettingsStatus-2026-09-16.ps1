# =====================================================================
#  CHECK ALL SETTINGS STATUS -- Copilot's P5-2 idea, built the safe way:
#  calls Checkup's OWN status-detection code, not a separate rewrite of it.
#
#  Bill, 2026-09-16: "Build the automatic" -- the "does every setting still
#  give the right answer" checker. Cloud's own framing: a 9,800-line file
#  edited only through assert-guarded Python is safe to refactor exactly
#  when a harness can prove the 19 status reads return the same answers
#  before and after. This is that harness's first version.
#
#  WHY IT PULLS FUNCTIONS OUT INSTEAD OF DOT-SOURCING THE BUILD: the build
#  file has no library/main split -- its own bottom third is one big
#  try/catch that IS the interactive program, prompts and all. Dot-sourcing
#  it would launch Checkup itself. Measured 2026-09-16: everything below
#  line ~5860 mixes function definitions and top-level executable code.
#  So this reads the build's OWN AST (the same technique
#  Show-AllScreens.bat already uses, precisely so it cannot drift from the
#  real screens) and pulls out BY NAME only the pieces Get-AllStatuses
#  actually calls -- five helper functions, one variable, one array -- then
#  runs Get-AllStatuses exactly as Checkup itself would.
#
#  READ-ONLY. Runs Checkup's status-detection code, which only reads system
#  state. Never calls Apply-Setting or anything that writes. No elevation
#  requested (admin-only reads report through the same "Unknown"/"needs
#  admin" paths Checkup itself uses when not elevated).
# =====================================================================

param(
    [string]$BuildPath = (Join-Path (Split-Path -Parent $PSScriptRoot) "Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1")
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $BuildPath)) {
    Write-Host "  ERROR: build file not found at:" -ForegroundColor Red
    Write-Host "    $BuildPath" -ForegroundColor Red
    Write-Host "  Pass -BuildPath if the current build has a different name." -ForegroundColor Yellow
    return
}

$stamp   = Get-Date -Format 'yyyy-MM-dd_HH-mm'
$outDir  = Join-Path (Split-Path -Parent $PSScriptRoot) 'Test_Results'
if (-not (Test-Path $outDir)) { $outDir = $PSScriptRoot }
$outFile = Join-Path $outDir ("AllSettingsStatus-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

$L = New-Object System.Collections.Generic.List[string]
function W([string]$t) { Write-Host $t; $L.Add($t) }

# --- parse the build's own AST, exactly like Show-AllScreens.bat does ---
$src = Get-Content -LiteralPath $BuildPath -Raw
$tokens = $null; $parseErrs = $null
$ast = [System.Management.Automation.Language.Parser]::ParseInput($src, [ref]$tokens, [ref]$parseErrs)
if ($parseErrs.Count -gt 0) {
    W "  ERROR: the build file has $($parseErrs.Count) parse error(s). Not safe to extract from. Stopping."
    $L | Set-Content -LiteralPath $outFile -Encoding UTF8
    return
}

function Get-GGFunctionText {
    param($Ast, [string]$Name)
    $fn = $Ast.Find({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] -and $n.Name -eq $Name }, $true)
    if (-not $fn) { throw "Function '$Name' not found in the build -- it may have been renamed. Update this script's dependency list." }
    return $fn.Extent.Text
}

function Get-GGVariableAssignText {
    param($Ast, [string]$VarName)
    # Finds the first top-level "$Name = ..." assignment and returns its
    # full statement text, so an array literal comes out complete.
    $assign = $Ast.Find({ param($n)
        $n -is [System.Management.Automation.Language.AssignmentStatementAst] -and
        $n.Left -is [System.Management.Automation.Language.VariableExpressionAst] -and
        $n.Left.VariablePath.UserPath -eq $VarName
    }, $true)
    if (-not $assign) { throw "Variable assignment for `$$VarName not found in the build. Update this script's dependency list." }
    return $assign.Extent.Text
}

W "======================================================================"
W "  ALL SETTINGS STATUS -- via Checkup's OWN detection code"
W ("  machine  : " + $env:COMPUTERNAME)
W ("  user     : " + $env:USERNAME)
W ("  run at   : " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
W ("  build    : " + (Split-Path -Leaf $BuildPath))
W ""
W "  READ-ONLY. This calls Checkup's real status-detection functions."
W "  It never calls Apply-Setting. Nothing on this PC is changed."
W ""

# Dependencies of Get-AllStatuses, named explicitly -- see the header note
# on how this list was derived (measured 2026-09-16, function-by-function).
$neededFunctions = @(
    'Get-GGPolicyLock', 'Get-WinEdition', 'Get-GGConsoleLockState',
    'Get-TamperProtectionState', 'Get-MalwarebytesState',
    'Get-GGEdgeEffectiveBool', 'Get-AllStatuses'
)

try {
    foreach ($fname in $neededFunctions) {
        $text = Get-GGFunctionText -Ast $ast -Name $fname
        Invoke-Expression $text
    }
    $settingsText     = Get-GGVariableAssignText -Ast $ast -VarName 'Settings'
    $highRiskAVText   = Get-GGVariableAssignText -Ast $ast -VarName 'HighRiskAVList'
    Invoke-Expression $highRiskAVText
    Invoke-Expression $settingsText
} catch {
    W ("  ERROR extracting from the build: " + $_.Exception.Message)
    W "  Nothing was run. This is a bug in this script, not in Checkup."
    $L | Set-Content -LiteralPath $outFile -Encoding UTF8
    W ""
    W ("  Saved to: " + $outFile)
    return
}

# Stub -- the real Write-Log writes to the build's own log file, which this
# harness has no reason to create. Status functions call it only for
# messages, never for control flow, so a no-op is safe.
function Write-Log { param([string]$Message, [string]$Status) }

# $global:IsAdmin -- computed directly rather than via Test-AdminAccess,
# because that function also DRAWS A SCREEN AND WAITS FOR A KEYPRESS on a
# non-admin machine, which this read-only harness must never do.
$global:IsAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")
Get-WinEdition | Out-Null   # sets $global:WinEdition as a side effect, same as the real build

W ("  Administrator : " + $global:IsAdmin)
W ("  Windows edition: " + $global:WinEdition)
W ""

Get-AllStatuses

W "----------------------------------------------------------------------"
W "  RESULT -- one line per setting, straight from Checkup's own code"
W "----------------------------------------------------------------------"
W ""
foreach ($s in ($Settings | Sort-Object ID)) {
    W ("  [" + $s.ID.ToString().PadLeft(2) + "]  " + $s.Name.PadRight(38) + " " + $s.Status)
}
W ""
W "----------------------------------------------------------------------"
W "  HOW TO USE THIS"
W "----------------------------------------------------------------------"
W ""
W "  Run this BEFORE a build change and save the output. Run it again"
W "  AFTER the change, on the same machine. Any line that reads"
W "  differently than expected is worth a look before shipping -- it"
W "  means the change touched a setting it was not supposed to."
W ""
W "  This is Checkup's real code, not a separate guess at what it should"
W "  say -- so a difference here is a difference in the build itself."
W ""

$L | Set-Content -LiteralPath $outFile -Encoding UTF8
W ("  Saved to: " + $outFile)
