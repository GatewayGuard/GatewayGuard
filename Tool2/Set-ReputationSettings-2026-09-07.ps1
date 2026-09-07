# =====================================================================
#  Set-ReputationSettings-2026-09-07.ps1
#
#  TURNS ON THE REPUTATION-BASED PROTECTION SETTINGS, and writes an undo
#  file first so every one of them can be put back exactly as it was.
#
#  THIS CHANGES SECURITY SETTINGS ON A LIVE MACHINE. Undo:
#  Run-RestoreReputationSettings.bat, which reads the undo file this
#  writes and restores each value, including deleting the ones that did
#  not exist before.
#
#  Bill, 2026-09-07: "turn on all the reputation settings".
#
#  WHY THESE EXACT KEYS. Four of the five come straight out of Checkup's
#  own source, so this turns them on the same way the product does
#  rather than inventing a parallel method:
#      SmartScreenEnabled = "Warn"   -- build line 6498
#      WTDS\Components (4 values)    -- build lines 6527-6533
#  The fifth, Store-app SmartScreen, Checkup does not touch.
#
#  ONE IS DELIBERATELY LEFT ALONE: "Block downloads", the second half of
#  potentially-unwanted-app blocking. The only way to set it from a
#  script is an Edge POLICY key, which marks the browser as managed by an
#  organisation and greys the setting out in Edge's own options. That is
#  a worse outcome than a tick box. Tick it by hand in Windows Security
#  -- App and browser control -> Reputation-based protection.
#
#  TAMPER PROTECTION IS ON. It can refuse some of these writes. This
#  script tells BLOCKED and WRITTEN apart and never claims a write it did
#  not verify by reading the value back -- the FT-141 rule.
# =====================================================================

param(
    [switch]$WhatIfOnly
)

$ErrorActionPreference = "Continue"

$ggStamp  = Get-Date -Format "yyyy-MM-dd_HH-mm"
$ggRoot   = Split-Path $PSScriptRoot -Parent
$ggOutDir = Join-Path $ggRoot "Test_Results"
if (-not (Test-Path $ggOutDir)) { New-Item -ItemType Directory -Path $ggOutDir -Force | Out-Null }
$ggOut  = Join-Path $ggOutDir "ReputationSettings-$env:COMPUTERNAME-$ggStamp.txt"
$ggUndo = Join-Path $ggOutDir "ReputationSettings-UNDO-$env:COMPUTERNAME-$ggStamp.json"

$ggLines = New-Object System.Collections.ArrayList
function Add-Line { param([string]$T = "") ; $null = $ggLines.Add($T) ; Write-Host $T }
function Save-Now { ($ggLines -join "`r`n") | Out-File -FilePath $ggOut -Encoding UTF8 }

Add-Line "======================================================================"
Add-Line "  TURN ON REPUTATION-BASED PROTECTION"
Add-Line "  $env:COMPUTERNAME   $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Add-Line "======================================================================"
Add-Line ""

$ggId   = [Security.Principal.WindowsIdentity]::GetCurrent()
$ggElev = (New-Object Security.Principal.WindowsPrincipal($ggId)).IsInRole(
            [Security.Principal.WindowsBuiltInRole]::Administrator)
Add-Line ("  Administrator: {0}" -f $ggElev)
if (-not $ggElev) {
    Add-Line ""
    Add-Line "  STOPPED. Right-click Run-SetReputationSettings.bat and choose"
    Add-Line "  'Run as administrator'. Nothing has been changed."
    Save-Now ; exit 1
}
Add-Line ""

# ---- the settings, with the screen label the user sees ---------------
$ggSet = @(
  @{ Label = "Check apps and files (SmartScreen)"
     Path  = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"
     Name  = "SmartScreenEnabled" ; Value = "Warn" ; Type = "String" }

  @{ Label = "Phishing protection -- service"
     Path  = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components"
     Name  = "ServiceEnabled" ; Value = 1 ; Type = "DWord" }

  @{ Label = "Phishing protection -- warn on malicious app"
     Path  = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components"
     Name  = "NotifyMalicious" ; Value = 1 ; Type = "DWord" }

  @{ Label = "Phishing protection -- warn on password reuse"
     Path  = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components"
     Name  = "NotifyPasswordReuse" ; Value = 1 ; Type = "DWord" }

  @{ Label = "Phishing protection -- warn on unsafe app"
     Path  = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components"
     Name  = "NotifyUnsafeApp" ; Value = 1 ; Type = "DWord" }

  @{ Label = "SmartScreen for Microsoft Store apps"
     Path  = "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost"
     Name  = "EnableWebContentEvaluation" ; Value = 1 ; Type = "DWord" }
)

# ---- 1. record what is there NOW, so it can all be put back ----------
Add-Line "----------------------------------------------------------------------"
Add-Line "  BEFORE -- and this is the undo record"
Add-Line "----------------------------------------------------------------------"
$ggBefore = New-Object System.Collections.ArrayList
foreach ($s in $ggSet) {
    $had = $false ; $old = $null
    try {
        $item = Get-ItemProperty -Path $s.Path -Name $s.Name -EA Stop
        $old = $item.($s.Name) ; $had = $true
    } catch { $had = $false }
    [void]$ggBefore.Add([PSCustomObject]@{
        Label = $s.Label ; Path = $s.Path ; Name = $s.Name
        Existed = $had ; OldValue = $old ; Type = $s.Type })
    Add-Line ("  {0,-46} {1}" -f $s.Label, $(if ($had) { "was: $old" } else { "was: NOT SET" }))
}
$ggBefore | ConvertTo-Json -Depth 4 | Out-File -FilePath $ggUndo -Encoding UTF8
Add-Line ""
Add-Line ("  Undo file written: {0}" -f $ggUndo)
Add-Line ""

if ($WhatIfOnly) {
    Add-Line "  -WhatIfOnly given. Nothing was changed."
    Save-Now ; exit 0
}

# ---- 2. write them, then READ EACH ONE BACK --------------------------
Add-Line "----------------------------------------------------------------------"
Add-Line "  WRITING -- every value is read back before it is called done"
Add-Line "----------------------------------------------------------------------"
$ggOK = 0 ; $ggBad = 0
foreach ($s in $ggSet) {
    $err = ""
    try {
        if (-not (Test-Path $s.Path)) { New-Item -Path $s.Path -Force -EA Stop | Out-Null }
        New-ItemProperty -Path $s.Path -Name $s.Name -Value $s.Value -PropertyType $s.Type -Force -EA Stop | Out-Null
    } catch { $err = $_.Exception.Message }

    $now = $null
    try { $now = (Get-ItemProperty -Path $s.Path -Name $s.Name -EA Stop).($s.Name) } catch { }

    if ("$now" -eq "$($s.Value)") {
        Add-Line ("  ON      {0}" -f $s.Label)
        Add-Line ("          read back as: {0}" -f $now)
        $ggOK++
    } else {
        Add-Line ("  FAILED  {0}" -f $s.Label)
        if ($err -ne "") { Add-Line ("          {0}" -f $err) }
        Add-Line ("          reads back as: {0}" -f $(if ($null -eq $now) { "still NOT SET" } else { $now }))
        Add-Line  "          Tamper Protection can refuse this. Set it by hand in"
        Add-Line  "          Windows Security if it will not take."
        $ggBad++
    }
}
Add-Line ""
Add-Line ("  Written and verified: {0} of {1}" -f $ggOK, $ggSet.Count)
Add-Line ""

# ---- 3. the one left for Bill ----------------------------------------
Add-Line "----------------------------------------------------------------------"
Add-Line "  ONE SETTING LEFT FOR YOU, ON PURPOSE"
Add-Line "----------------------------------------------------------------------"
Add-Line ""
Add-Line "  'Block downloads' -- the second half of potentially unwanted app"
Add-Line "  blocking. Setting it from a script means an Edge policy key, which"
Add-Line "  marks your browser as managed by an organisation and greys the"
Add-Line "  setting out in Edge's own options. A tick box is better."
Add-Line ""
Add-Line "  Windows Security -> App and browser control ->"
Add-Line "  Reputation-based protection settings -> Potentially unwanted app"
Add-Line "  blocking -> tick 'Block downloads'."
Add-Line ""
Add-Line "  'Block apps', the other half, is already on."
Add-Line ""

# ---- 4. what Windows Defender thinks now -----------------------------
Add-Line "----------------------------------------------------------------------"
Add-Line "  AFTER"
Add-Line "----------------------------------------------------------------------"
$st = Get-MpComputerStatus
$pf = Get-MpPreference
Add-Line ("  Real-time protection : {0}" -f $st.RealTimeProtectionEnabled)
Add-Line ("  PUA blocking         : {0}" -f $pf.PUAProtection)
Add-Line ("  Tamper protection    : {0}" -f $st.IsTamperProtected)
Add-Line ""
Add-Line "  Some of these take effect only after Windows Security is reopened,"
Add-Line "  and phishing protection may need a restart. Check the screen."
Add-Line ""
Add-Line "======================================================================"
Add-Line "  UNDO: Run-RestoreReputationSettings.bat"
Add-Line ("  It reads {0}" -f (Split-Path $ggUndo -Leaf))
Add-Line "======================================================================"
Add-Line ""
Add-Line ("  Saved to: {0}" -f $ggOut)
Save-Now
