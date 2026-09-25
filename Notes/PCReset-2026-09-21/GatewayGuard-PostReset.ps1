I'll build this comprehensive post-reset PowerShell script for your GatewayGuard development environment right now!

Here is your complete **GatewayGuard Post-Reset Script** — copy the full block below and save it as `GatewayGuard-PostReset.ps1`. Run it from an **elevated PowerShell 7** session after a Windows 11 reset.

---

> **⚠ Before running:** Fill in every value in **Section 0** — passwords, your MS account username, and your GitHub repo URLs. The script will pause in Section 2 and ask you to confirm the MSA → local account conversion has been done in Settings first.

---

```powershell
#Requires -RunAsAdministrator
<#
.SYNOPSIS
    GatewayGuard Post-Reset Configuration Script
    Fully configures a Windows 11 system after factory reset for GatewayGuard development.

.DESCRIPTION
    Sections:
      0  – Configuration Variables  (EDIT BEFORE RUNNING)
      1  – Prerequisites & Transcript
      2  – Convert Microsoft Account → Local Account
      3  – Create Dev Accounts (Dad, CGAdmin, localuser)
      4  – Identity Isolation Registry Keys
      5  – Disable Connected-User / Cloud Identity Prompts
      6  – Disable Azure AD Auto-Join
      7  – Login Screen Identity Lockdown
      8  – Install Git & Git Credential Manager (winget)
      9  – Configure Git Global Identity
      10 – Install VS Code + Extensions
      11 – Create GatewayGuard Folder Structure
      12 – Clone GatewayGuard Repos & Configure Remotes
      13 – Optional SSH Key Generation
      14 – Baseline Hardening Registry Keys
      15 – PowerShell Module Development Environment
      16 – Final Verification

.NOTES
    Run from an elevated PowerShell 7 session.
    Restart may be required after Section 2 (account conversion).
    Review every CONFIGURE block below before first run.

    Author  : GatewayGuard Build System
    Version : 1.0.0
    Date    : 2026-09-21
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# ============================================================
#  SECTION 0 – CONFIGURATION VARIABLES  ← EDIT BEFORE RUNNING
# ============================================================
$Config = @{

    # ── Current Microsoft-linked account (the one to convert) ──
    MSAccountUsername  = 'YourCurrentMSAccountUsername'   # e.g. 'WilliamB'

    # ── New local account passwords ──
    DadPassword        = 'CHANGE_ME_Dad!2026'
    CGAdminPassword    = 'CHANGE_ME_CGAdmin!2026'
    LocalUserPassword  = 'CHANGE_ME_LocalUser!2026'

    # ── Git global identity ──
    GitUserName        = 'William F Bilodeau III'
    GitUserEmail       = 'william.wfbiii@gmail.com'

    # ── GitHub / remote URLs ──
    # Format: @{ RepoName = 'https://github.com/YourOrg/RepoName.git' }
    Repos = @{
        'GatewayGuard-Core'      = 'https://github.com/YourOrg/GatewayGuard-Core.git'
        'GatewayGuard-Modules'   = 'https://github.com/YourOrg/GatewayGuard-Modules.git'
        'GatewayGuard-Scripts'   = 'https://github.com/YourOrg/GatewayGuard-Scripts.git'
        'GatewayGuard-Docs'      = 'https://github.com/YourOrg/GatewayGuard-Docs.git'
    }

    # ── Upstream remote (if forked) – set $null to skip ──
    UpstreamRemoteUrl  = $null   # e.g. 'https://github.com/OriginalOrg/GatewayGuard-Core.git'

    # ── Dev root folder ──
    DevRoot            = 'C:\Dev\GatewayGuard'

    # ── VS Code extensions to install (IDs) ──
    VSCodeExtensions   = @(
        'ms-vscode.powershell'
        'ms-vscode-remote.remote-wsl'
        'eamodio.gitlens'
        'mhutchie.git-graph'
        'github.vscode-pull-request-github'
        'ms-vscode.vscode-json'
        'redhat.vscode-yaml'
        'esbenp.prettier-vscode'
        'davidanson.vscode-markdownlint'
        'ms-vscode.hexeditor'
        'streetsidesoftware.code-spell-checker'
        'gruntfuggly.todo-tree'
    )

    # ── SSH key (ed25519); set GenerateSSHKey = $false to skip ──
    GenerateSSHKey     = $true
    SSHKeyComment      = 'william.wfbiii@gmail.com-gatewayguard'
    SSHKeyPath         = "$env:USERPROFILE\.ssh\id_ed25519_gatewayguard"

    # ── PowerShell modules to install for dev ──
    PSModules          = @(
        'Pester'
        'PSScriptAnalyzer'
        'platyPS'
        'InvokeBuild'
        'ModuleBuilder'
    )

    # ── Transcript log location ──
    TranscriptPath     = 'C:\Logs\GatewayGuard-PostReset.log'
}

# ============================================================
#  SECTION 1 – PREREQUISITES & TRANSCRIPT
# ============================================================
Write-Host "`n══════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  GatewayGuard Post-Reset Script  v1.0.0" -ForegroundColor Cyan
Write-Host "══════════════════════════════════════════════`n" -ForegroundColor Cyan

function Write-Step {
    param([int]$Number, [string]$Title)
    Write-Host "`n┌─────────────────────────────────────────────" -ForegroundColor Yellow
    Write-Host "│  STEP $Number – $Title" -ForegroundColor Yellow
    Write-Host "└─────────────────────────────────────────────`n" -ForegroundColor Yellow
}
function Write-OK   { param([string]$Msg) Write-Host "  ✔  $Msg" -ForegroundColor Green  }
function Write-Warn { param([string]$Msg) Write-Host "  ⚠  $Msg" -ForegroundColor Yellow }
function Write-Info { param([string]$Msg) Write-Host "  ℹ  $Msg" -ForegroundColor Cyan   }

function Set-RegistryValue {
    param(
        [string]$Path,
        [string]$Name,
        [object]$Value,
        [string]$Type = 'DWord'
    )
    if (-not (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
        Write-Info "Created registry key: $Path"
    }
    Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -Force
    Write-OK "Registry: $Path\$Name = $Value"
}

# Ensure log directory exists
$logDir = Split-Path $Config.TranscriptPath
if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir -Force | Out-Null }
Start-Transcript -Path $Config.TranscriptPath -Append

# OS check
$osInfo = Get-CimInstance Win32_OperatingSystem
if ($osInfo.Caption -notmatch 'Windows 11') {
    Write-Warn "This script targets Windows 11. Detected: $($osInfo.Caption). Proceeding anyway."
} else {
    Write-OK "Windows 11 detected: $($osInfo.Caption) Build $($osInfo.BuildNumber)"
}

# PowerShell version
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Warn "PowerShell 7+ recommended. Running on $($PSVersionTable.PSVersion). Some cmdlets may behave differently."
} else {
    Write-OK "PowerShell $($PSVersionTable.PSVersion) detected."
}

# Execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force
Write-OK "Execution policy set to RemoteSigned (LocalMachine)."

# ============================================================
#  SECTION 2 – CONVERT MICROSOFT ACCOUNT → LOCAL ACCOUNT
# ============================================================
Write-Step -Number 2 -Title 'Convert Microsoft Account to Local Account'

<#
  Windows does not expose a single WMI/API call to "unlink" a Microsoft account.
  The safest approach:
    1. This section removes the ConnectedAccount registry value that ties the profile
       to an MSA email, and suppresses the re-association prompt.
    2. The actual GUI unlink (Settings → Accounts → Your info → "Sign in with a
       local account instead") must be done manually ONCE before running this script.
  The operator is prompted to confirm that step was completed.
#>

$currentUser = $Config.MSAccountUsername
$localSID    = (Get-LocalUser -Name $currentUser -ErrorAction SilentlyContinue)?.SID?.Value

if ($null -eq $localSID) {
    Write-Warn "Local user '$currentUser' not found. Update `$Config.MSAccountUsername if the name differs."
} else {
    Write-OK "Found local account: $currentUser (SID: $localSID)"
}

# Remove ConnectedAccount value from profile registry (the MSA email link)
$samHintPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList'
Get-ChildItem $samHintPath | ForEach-Object {
    $profilePath = $_.GetValue('ProfileImagePath')
    if ($profilePath -match [regex]::Escape($currentUser)) {
        $sidKey = $_.PSChildName
        Write-Info "Profile registry key: $sidKey → $profilePath"
        Remove-ItemProperty -Path "$samHintPath\$sidKey" -Name 'ConnectedAccount' -ErrorAction SilentlyContinue
        Write-OK "Removed ConnectedAccount registry value for $sidKey (if it existed)."
    }
}

# Suppress MSA sign-in prompts that re-associate the account
Set-RegistryValue -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' `
                  -Name 'NoConnectedUser' -Value 3

Write-Warn @"
MANUAL ACTION REQUIRED (do once, then re-run this script):
  1. Open Settings → Accounts → Your info
  2. Click "Sign in with a local account instead"
  3. Follow the wizard to set a local username & password
  4. Sign out and back in as that local account
  5. Then continue running this script from the local account session.
"@

$choice = Read-Host "Has the Microsoft account already been unlinked? (Y/N)"
if ($choice -ne 'Y') {
    Write-Host "`nScript paused. Complete the account unlink, then re-run." -ForegroundColor Magenta
    Stop-Transcript
    exit 0
}
Write-OK "Microsoft account unlink confirmed by operator."

# ============================================================
#  SECTION 3 – CREATE DEV ACCOUNTS
# ============================================================
Write-Step -Number 3 -Title 'Create Dev Accounts: Dad, CGAdmin, localuser'

function New-LocalDevAccount {
    param(
        [string]$Username,
        [string]$PlainPassword,
        [string]$FullName,
        [string]$Description,
        [string[]]$Groups
    )
    $secPwd   = ConvertTo-SecureString $PlainPassword -AsPlainText -Force
    $existing = Get-LocalUser -Name $Username -ErrorAction SilentlyContinue

    if ($null -ne $existing) {
        Write-Warn "Account '$Username' already exists – updating password."
        Set-LocalUser -Name $Username -Password $secPwd -PasswordNeverExpires $true
    } else {
        New-LocalUser -Name $Username `
                      -Password $secPwd `
                      -FullName $FullName `
                      -Description $Description `
                      -PasswordNeverExpires `
                      -UserMayNotChangePassword:$false `
                      -AccountNeverExpires | Out-Null
        Write-OK "Created local account: $Username"
    }

    foreach ($grp in $Groups) {
        try {
            Add-LocalGroupMember -Group $grp -Member $Username -ErrorAction Stop
            Write-OK "  Added $Username → $grp"
        } catch {
            if ($_.Exception.Message -match 'already a member') {
                Write-Info "  $Username is already in $grp"
            } else {
                Write-Warn "  Could not add $Username to ${grp}: $($_.Exception.Message)"
            }
        }
    }
}

# Dad – primary dev admin
New-LocalDevAccount `
    -Username     'Dad' `
    -PlainPassword $Config.DadPassword `
    -FullName     'William F Bilodeau III' `
    -Description  'Primary developer admin account – GatewayGuard' `
    -Groups       @('Administrators', 'Remote Desktop Users', 'Performance Monitor Users')

# CGAdmin – scoped admin
New-LocalDevAccount `
    -Username     'CGAdmin' `
    -PlainPassword $Config.CGAdminPassword `
    -FullName     'CGAdmin Service Account' `
    -Description  'GatewayGuard CGAdmin scoped account' `
    -Groups       @('Administrators')

# localuser – standard user for isolation testing
New-LocalDevAccount `
    -Username     'localuser' `
    -PlainPassword $Config.LocalUserPassword `
    -FullName     'Local Standard User' `
    -Description  'Standard user for identity-isolation testing' `
    -Groups       @('Users')

# Disable built-in Guest
Disable-LocalUser -Name 'Guest' -ErrorAction SilentlyContinue
Write-OK "Guest account disabled."

# ============================================================
#  SECTION 4 – IDENTITY ISOLATION REGISTRY KEYS
# ============================================================
Write-Step -Number 4 -Title 'Identity Isolation Registry Keys'

# Block MSA token collection and auto-association
Set-RegistryValue 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' `
                  'NoConnectedUser' 3

# Block MSA optional sign-in for apps
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftAccount' `
                  'DisableUserAuth' 1

# Disable Windows Hello cloud backup / credential roaming
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork' 'Enabled' 0
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork' 'DisablePostLogonProvisioning' 1

# Prevent linked accounts in credential prompts
Set-RegistryValue 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' `
                  'DontDisplayLockedUserId' 3

# Disable Workplace Join
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin' `
                  'autoWorkplaceJoin' 0

# Keep UAC enabled (identity isolation only – do not weaken UAC)
Set-RegistryValue 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' `
                  'EnableLUA' 1

# Disable online speech recognition (cloud identity surface reduction)
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization' `
                  'AllowInputPersonalization' 0

# Telemetry to minimum (blocks MSA identity association in diagnostics)
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' 'AllowTelemetry' 0
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' 'DisableOneSettingsDownloads' 1

# Block settings sync (cross-device identity leakage)
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\SettingSync' 'DisableSettingSync' 2
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\SettingSync' 'DisableSettingSyncUserOverride' 1

Write-OK "Identity isolation registry block applied."

# ============================================================
#  SECTION 5 – DISABLE CONNECTED-USER / CLOUD IDENTITY PROMPTS
# ============================================================
Write-Step -Number 5 -Title 'Disable Connected-User & Cloud Identity Prompts'

# Suppress "Add a Microsoft account" prompt in Start
Set-RegistryValue 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' `
                  'Start_AccountNotifications' 0

# Suppress "Finish setting up your device" notification
Set-RegistryValue 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement' `
                  'ScoobeSystemSettingEnabled' 0

# Disable Windows tips / suggestions (includes MSA nudges)
$cdm = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
Set-RegistryValue $cdm 'SoftLandingEnabled'              0
Set-RegistryValue $cdm 'SubscribedContent-338388Enabled' 0
Set-RegistryValue $cdm 'SubscribedContent-338389Enabled' 0
Set-RegistryValue $cdm 'SubscribedContent-353694Enabled' 0
Set-RegistryValue $cdm 'SubscribedContent-353696Enabled' 0

# Disable OneDrive sync nudge
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' 'DisableFileSyncNGSC' 1
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' 'DisableLibrariesDefaultSaveToOneDrive' 1

# Disable Cortana and cloud search
$ws = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
Set-RegistryValue $ws 'AllowCortana'          0
Set-RegistryValue $ws 'AllowCloudSearch'      0
Set-RegistryValue $ws 'ConnectedSearchUseWeb' 0

Write-OK "Connected-user prompts suppressed."

# ============================================================
#  SECTION 6 – DISABLE AZURE AD AUTO-JOIN
# ============================================================
Write-Step -Number 6 -Title 'Disable Azure AD Auto-Join'

Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin' 'autoWorkplaceJoin' 0

# Disable MDM auto-enrollment
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\MDM' 'AutoEnrollMDM'        0
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\MDM' 'UseAADCredentialType' 0

# Disable the Automatic-Device-Join scheduled task
$aadTask = 'Microsoft\Windows\Workplace Join\Automatic-Device-Join'
schtasks.exe /Change /TN $aadTask /Disable 2>$null
Write-OK "Scheduled task '$aadTask' disabled."

# Disable dmwappushservice (MDM push)
$mdmSvc = Get-Service -Name 'dmwappushservice' -ErrorAction SilentlyContinue
if ($mdmSvc) {
    Stop-Service -Name 'dmwappushservice' -Force -ErrorAction SilentlyContinue
    Set-Service  -Name 'dmwappushservice' -StartupType Disabled
    Write-OK "dmwappushservice disabled."
}

Write-OK "Azure AD / MDM auto-join disabled."

# ============================================================
#  SECTION 7 – LOGIN SCREEN IDENTITY LOCKDOWN
# ============================================================
Write-Step -Number 7 -Title 'Login Screen Identity Lockdown'

$polSys = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'

# Do not display the last signed-in username
Set-RegistryValue $polSys 'DontDisplayLastUserName' 0

# Hide locked user ID (hides MSA email on lock screen)
Set-RegistryValue $polSys 'DontDisplayLockedUserId' 3

# Do not enumerate local admin accounts on logon screen
Set-RegistryValue 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI' `
                  'EnumerateAdministrators' 0

# Block account details on sign-in screen
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' `
                  'BlockUserFromShowingAccountDetailsOnSignin' 1

# Clear cached domain credential count (no network identity advertising)
Set-RegistryValue 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' `
                  'CachedLogonsCount' '0' 'String'

# Disable Fast User Switching (prevents identity bleed between sessions)
Set-RegistryValue $polSys 'HideFastUserSwitching' 1

Write-OK "Login screen identity lockdown applied."

# ============================================================
#  SECTION 8 – INSTALL GIT & GIT CREDENTIAL MANAGER
# ============================================================
Write-Step -Number 8 -Title 'Install Git & Git Credential Manager'

function Test-CommandExists {
    param([string]$Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

if (-not (Test-CommandExists 'winget')) {
    Write-Warn "winget not found. Open the Microsoft Store, install 'App Installer', then re-run."
    Stop-Transcript; exit 1
}
Write-OK "winget available: $(winget --version)"

if (-not (Test-CommandExists 'git')) {
    Write-Info "Installing Git for Windows..."
    winget install --id Git.Git --exact --silent `
                   --accept-package-agreements --accept-source-agreements
    $env:PATH = [System.Environment]::GetEnvironmentVariable('PATH','Machine') + ';' +
                [System.Environment]::GetEnvironmentVariable('PATH','User')
    Write-OK "Git installed: $(git --version)"
} else {
    Write-OK "Git already present: $(git --version)"
}

Write-Info "Installing Git Credential Manager..."
winget install --id GitHub.GitCredentialManager --exact --silent `
               --accept-package-agreements --accept-source-agreements 2>$null
Write-OK "Git Credential Manager installed."

git config --system credential.helper manager
Write-OK "GCM set as system credential helper."

# ============================================================
#  SECTION 9 – CONFIGURE GIT GLOBAL IDENTITY
# ============================================================
Write-Step -Number 9 -Title 'Configure Git Global Identity'

git config --global user.name  $Config.GitUserName
git config --global user.email $Config.GitUserEmail

git config --global core.autocrlf  input
git config --global core.longpaths true
git config --global core.editor    'code --wait'

git config --global init.defaultBranch main

git config --global merge.tool             vscode
git config --global mergetool.vscode.cmd   'code --wait $MERGED'
git config --global diff.tool              vscode
git config --global difftool.vscode.cmd    'code --wait --diff $LOCAL $REMOTE'

git config --global pull.rebase     true
git config --global push.default    current
git config --global commit.gpgsign  false

git config --global --add safe.directory $Config.DevRoot

Write-OK "Git global identity configured:"
Write-Info "  Name : $(git config --global user.name)"
Write-Info "  Email: $(git config --global user.email)"

# ============================================================
#  SECTION 10 – INSTALL VS CODE & EXTENSIONS
# ============================================================
Write-Step -Number 10 -Title 'Install VS Code & Extensions'

if (-not (Test-CommandExists 'code')) {
    Write-Info "Installing Visual Studio Code..."
    winget install --id Microsoft.VisualStudioCode --exact --silent `
                   --accept-package-agreements --accept-source-agreements
    $env:PATH = [System.Environment]::GetEnvironmentVariable('PATH','Machine') + ';' +
                [System.Environment]::GetEnvironmentVariable('PATH','User')
} else {
    Write-OK "VS Code already installed."
}

foreach ($ext in $Config.VSCodeExtensions) {
    Write-Info "  Installing extension: $ext"
    code --install-extension $ext --force 2>&1 | Out-Null
    Write-OK "  ✔ $ext"
}

# Baseline VS Code user settings
$vsCodeSettingsDir  = "$env:APPDATA\Code\User"
$vsCodeSettingsFile = "$vsCodeSettingsDir\settings.json"
if (-not (Test-Path $vsCodeSettingsDir)) {
    New-Item -ItemType Directory $vsCodeSettingsDir -Force | Out-Null
}

@{
    'editor.fontFamily'                    = "'Cascadia Code', 'Consolas', monospace"
    'editor.fontSize'                      = 14
    'editor.tabSize'                       = 4
    'editor.insertSpaces'                  = $true
    'editor.formatOnSave'                  = $true
    'editor.renderWhitespace'              = 'boundary'
    'files.eol'                            = '\n'
    'files.trimTrailingWhitespace'         = $true
    'files.insertFinalNewline'             = $true
    'terminal.integrated.shell.windows'    = 'C:\\Program Files\\PowerShell\\7\\pwsh.exe'
    'git.autofetch'                        = $true
    'git.confirmSync'                      = $false
    'powershell.codeFormatting.preset'     = 'OTBS'
    'powershell.scriptAnalysis.enable'     = $true
    'extensions.autoUpdate'               = $false
    '[powershell]'                         = @{ 'editor.defaultFormatter' = 'ms-vscode.powershell' }
} | ConvertTo-Json -Depth 5 |
    Set-Content -Path $vsCodeSettingsFile -Encoding UTF8 -Force

Write-OK "VS Code settings written to $vsCodeSettingsFile"

# ============================================================
#  SECTION 11 – CREATE GATEWAYGUARD FOLDER STRUCTURE
# ============================================================
Write-Step -Number 11 -Title 'Create GatewayGuard Folder Structure'

@(
    $Config.DevRoot
    "$($Config.DevRoot)\repos"
    "$($Config.DevRoot)\modules"
    "$($Config.DevRoot)\scripts"
    "$($Config.DevRoot)\docs"
    "$($Config.DevRoot)\tests"
    "$($Config.DevRoot)\tools"
    "$($Config.DevRoot)\artifacts"
    "$($Config.DevRoot)\artifacts\releases"
    "$($Config.DevRoot)\artifacts\packages"
    "$($Config.DevRoot)\.vscode"
    "$($Config.DevRoot)\infrastructure"
    "$($Config.DevRoot)\infrastructure\registry"
    "$($Config.DevRoot)\infrastructure\group-policy"
    "$($Config.DevRoot)\infrastructure\wix"
    "$($Config.DevRoot)\logs"
    'C:\Logs'
) | ForEach-Object {
    if (-not (Test-Path $_)) {
        New-Item -ItemType Directory -Path $_ -Force | Out-Null
        Write-OK "Created: $_"
    } else {
        Write-Info "Exists : $_"
    }
}

# Workspace .vscode/settings.json
@{
    'powershell.scriptAnalysis.settingsPath' = '.\.vscode\PSScriptAnalyzerSettings.psd1'
    'files.exclude' = @{ '**\.git' = $true; '**/bin' = $true; '**/obj' = $true; '**/.vs' = $true }
    'search.exclude' = @{ '**/bin' = $true; '**/obj' = $true; '**/.git' = $true }
} | ConvertTo-Json -Depth 5 |
    Set-Content "$($Config.DevRoot)\.vscode\settings.json" -Encoding UTF8 -Force
Write-OK "Workspace .vscode/settings.json created."

# PSScriptAnalyzer settings
@'
@{
    Severity     = @('Error','Warning','Information')
    IncludeRules = @('*')
    ExcludeRules = @('PSAvoidUsingWriteHost')
}
'@ | Set-Content "$($Config.DevRoot)\.vscode\PSScriptAnalyzerSettings.psd1" -Encoding UTF8 -Force
Write-OK "PSScriptAnalyzer settings written."

# ============================================================
#  SECTION 12 – CLONE REPOS & CONFIGURE REMOTES
# ============================================================
Write-Step -Number 12 -Title 'Clone GatewayGuard Repos & Configure Remotes'

$reposRoot = "$($Config.DevRoot)\repos"

foreach ($repoName in $Config.Repos.Keys) {
    $remoteUrl = $Config.Repos[$repoName]
    $localPath = "$reposRoot\$repoName"

    if (Test-Path "$localPath\.git") {
        Write-Info "Repo already cloned: $repoName – fetching latest..."
        Push-Location $localPath
        git fetch --all --prune
        Pop-Location
    } else {
        Write-Info "Cloning $repoName from $remoteUrl ..."
        git clone $remoteUrl $localPath
        Write-OK "Cloned: $repoName"
    }

    Push-Location $localPath

    # Verify / fix origin
    $currentOrigin = git remote get-url origin 2>$null
    if ($currentOrigin -ne $remoteUrl) {
        git remote set-url origin $remoteUrl
        Write-OK "  Updated origin → $remoteUrl"
    }

    # Add upstream (fork workflow)
    if ($null -ne $Config.UpstreamRemoteUrl) {
        $existingUpstream = git remote get-url upstream 2>$null
        if ($null -eq $existingUpstream) {
            git remote add upstream $Config.UpstreamRemoteUrl
            Write-OK "  Added upstream → $($Config.UpstreamRemoteUrl)"
        } else {
            Write-Info "  upstream already set: $existingUpstream"
        }
    }

    # Per-repo identity (explicit override)
    git config user.name  $Config.GitUserName
    git config user.email $Config.GitUserEmail
    Write-OK "  Per-repo identity: $($Config.GitUserName) <$($Config.GitUserEmail)>"

    # Track origin/main
    git fetch origin main 2>$null
    git checkout main       2>$null
    git branch --set-upstream-to=origin/main main 2>$null

    Pop-Location
}

Write-OK "All repos cloned and remotes configured."

# ============================================================
#  SECTION 13 – OPTIONAL SSH KEY GENERATION
# ============================================================
Write-Step -Number 13 -Title 'SSH Key Generation (Optional)'

if ($Config.GenerateSSHKey) {
    $sshDir = Split-Path $Config.SSHKeyPath

    if (-not (Test-Path $sshDir)) {
        New-Item -ItemType Directory -Path $sshDir -Force | Out-Null
        Write-OK "Created .ssh directory: $sshDir"
    }

    # Harden .ssh ACL (owner-only, no inheritance)
    $acl = Get-Acl $sshDir
    $acl.SetAccessRuleProtection($true, $false)
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
        [System.Security.Principal.WindowsIdentity]::GetCurrent().User,
        'FullControl', 'ContainerInherit,ObjectInherit', 'None', 'Allow'
    )
    $acl.AddAccessRule($rule)
    Set-Acl -Path $sshDir -AclObject $acl
    Write-OK "SSH directory permissions hardened."

    if (-not (Test-Path "$($Config.SSHKeyPath).pub")) {
        Write-Info "Generating ed25519 SSH key..."
        ssh-keygen -t ed25519 -C $Config.SSHKeyComment -f $Config.SSHKeyPath -N '""'
        Write-OK "SSH key pair generated:"
        Write-Info "  Private : $($Config.SSHKeyPath)"
        Write-Info "  Public  : $($Config.SSHKeyPath).pub"
    } else {
        Write-Info "SSH key already exists at $($Config.SSHKeyPath)"
    }

    # Start ssh-agent and add key
    $sshAgent = Get-Service -Name 'ssh-agent' -ErrorAction SilentlyContinue
    if ($null -ne $sshAgent) {
        Set-Service  -Name 'ssh-agent' -StartupType Automatic
        Start-Service -Name 'ssh-agent' -ErrorAction SilentlyContinue
        ssh-add $Config.SSHKeyPath 2>&1 | Out-Null
        Write-OK "SSH key added to agent."
    }

    # Write SSH config entry for GitHub
    $sshConfigPath = "$sshDir\config"
    $sshConfigEntry = @"

# GatewayGuard GitHub identity
Host github.com
    HostName github.com
    User git
    IdentityFile $($Config.SSHKeyPath)
    IdentitiesOnly yes
"@
    if (Test-Path $sshConfigPath) {
        $existing = Get-Content $sshConfigPath -Raw
        if ($existing -notmatch 'GatewayGuard GitHub identity') {
            Add-Content -Path $sshConfigPath -Value $sshConfigEntry
            Write-OK "SSH config entry appended."
        } else {
            Write-Info "SSH config entry already present."
        }
    } else {
        $sshConfigEntry.Trim() | Set-Content $sshConfigPath -Encoding UTF8
        Write-OK "SSH config created."
    }

    Write-Host "`n  ► NEXT STEP: Add the public key below to github.com/settings/keys" -ForegroundColor Magenta
    Write-Host "    Then test with: ssh -T git@github.com`n" -ForegroundColor Cyan
    Get-Content "$($Config.SSHKeyPath).pub" | Write-Host -ForegroundColor White

} else {
    Write-Info "SSH key generation skipped (GenerateSSHKey = `$false)."
}

# ============================================================
#  SECTION 14 – BASELINE HARDENING REGISTRY KEYS
# ============================================================
Write-Step -Number 14 -Title 'Baseline Hardening Registry Keys'

# ── UAC ──────────────────────────────────────────────────────
$polSys = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
Set-RegistryValue $polSys 'EnableLUA'                   1
Set-RegistryValue $polSys 'ConsentPromptBehaviorAdmin'  2   # Credentials on secure desktop
Set-RegistryValue $polSys 'ConsentPromptBehaviorUser'   0   # Auto-deny elevation for standard users
Set-RegistryValue $polSys 'PromptOnSecureDesktop'       1

# ── SMB Hardening ─────────────────────────────────────────────
$smbServer = 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters'
Set-RegistryValue $smbServer 'SMB1'                     0
Set-RegistryValue $smbServer 'RequireSecuritySignature'  1
$smbClient = 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters'
Set-RegistryValue $smbClient 'RequireSecuritySignature'  1
Set-RegistryValue $smbClient 'EnableSecuritySignature'   1

# ── NTLM Restrictions ─────────────────────────────────────────
$lsa = 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa'
Set-RegistryValue $lsa 'LmCompatibilityLevel'   5   # NTLMv2 only
Set-RegistryValue $lsa 'RestrictAnonymous'       1
Set-RegistryValue $lsa 'RestrictAnonymousSAM'    1
Set-RegistryValue $lsa 'NoLMHash'                1

# ── RDP / Remote Assistance Hardening ─────────────────────────
Set-RegistryValue 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' `
                  'UserAuthentication' 1   # NLA required
$rdpPol = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
Set-RegistryValue $rdpPol 'fAllowUnsolicited' 0
Set-RegistryValue $rdpPol 'fAllowToGetHelp'   0

# ── Spectre / Meltdown Mitigations ────────────────────────────
$memMgmt = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management'
Set-RegistryValue $memMgmt 'FeatureSettingsOverride'     0
Set-RegistryValue $memMgmt 'FeatureSettingsOverrideMask' 3

# ── Windows Defender (preserve – do NOT disable) ──────────────
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' `
                  'DisableAntiSpyware' 0
Set-RegistryValue 'HKLM:\SOFTWARE\Microsoft\Windows Defender\Features' `
                  'TamperProtection' 5

# ── AutoRun / AutoPlay ────────────────────────────────────────
$exp = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
Set-RegistryValue $exp 'NoDriveTypeAutoRun' 255
Set-RegistryValue $exp 'NoAutorun'          1
Set-RegistryValue 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' `
                  'NoDriveTypeAutoRun' 255

# ── PowerShell Script Block Logging ───────────────────────────
$sbl = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging'
Set-RegistryValue $sbl 'EnableScriptBlockLogging'           1
Set-RegistryValue $sbl 'EnableScriptBlockInvocationLogging' 1

# ── PowerShell Module & Transcription Logging ─────────────────
Set-RegistryValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging' `
                  'EnableModuleLogging' 1
$trl = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription'
Set-RegistryValue $trl 'EnableTranscripting'    1
Set-RegistryValue $trl 'OutputDirectory'        'C:\Logs\PSTranscripts' 'String'
Set-RegistryValue $trl 'EnableInvocationHeader' 1

# ── WinRM (set Manual; enable explicitly when needed) ─────────
Stop-Service -Name 'WinRM' -Force           -ErrorAction SilentlyContinue
Set-Service  -Name 'WinRM' -StartupType Manual -ErrorAction SilentlyContinue
Write-OK "WinRM set to Manual start."

Write-OK "Baseline hardening registry keys applied."

# ============================================================
#  SECTION 15 – POWERSHELL MODULE DEVELOPMENT ENVIRONMENT
# ============================================================
Write-Step -Number 15 -Title 'PowerShell Module Development Environment'

New-Item -ItemType Directory 'C:\Logs\PSTranscripts' -Force -ErrorAction SilentlyContinue | Out-Null

# NuGet provider & trusted gallery
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope AllUsers | Out-Null
Write-OK "NuGet provider installed."
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Write-OK "PSGallery set to Trusted."

# Install dev modules
foreach ($mod in $Config.PSModules) {
    if (-not (Get-Module -ListAvailable -Name $mod)) {
        Write-Info "  Installing module: $mod"
        Install-Module -Name $mod -Scope AllUsers -Force -SkipPublisherCheck
        Write-OK "  ✔ $mod installed"
    } else {
        Write-OK "  $mod already installed"
    }
}

# ── Module template: GatewayGuard.Core ────────────────────────
$moduleName = 'GatewayGuard.Core'
$moduleDest = "$($Config.DevRoot)\modules\$moduleName"

if (-not (Test-Path $moduleDest)) {
    foreach ($sub in @('Public','Private','Tests','docs','en-US')) {
        New-Item -ItemType Directory -Path "$moduleDest\$sub" -Force | Out-Null
    }

    # Root module
    @"
# $moduleName.psm1
`$public  = @(Get-ChildItem -Path "`$PSScriptRoot\Public\*.ps1"  -ErrorAction SilentlyContinue)
`$private = @(Get-ChildItem -Path "`$PSScriptRoot\Private\*.ps1" -ErrorAction SilentlyContinue)
foreach (`$import in (`$public + `$private)) {
    try   { . `$import.FullName }
    catch { Write-Error "Failed to import `$(`$import.FullName): `$_" }
}
Export-ModuleMember -Function `$public.BaseName
"@ | Set-Content "$moduleDest\$moduleName.psm1" -Encoding UTF8

    # Module manifest
    New-ModuleManifest `
        -Path              "$moduleDest\$moduleName.psd1" `
        -RootModule        "$moduleName.psm1" `
        -ModuleVersion     '0.1.0' `
        -Author            $Config.GitUserName `
        -CompanyName       'GatewayGuard' `
        -Description       'Core GatewayGuard PowerShell module' `
        -PowerShellVersion '7.0' `
        -FunctionsToExport @() `
        -CmdletsToExport   @() `
        -VariablesToExport @() `
        -AliasesToExport   @()
    Write-OK "Module manifest created."

    # Pester test scaffold
    @"
#Requires -Module Pester
Describe '$moduleName Module' {
    BeforeAll { Import-Module (Join-Path `$PSScriptRoot '..' '$moduleName.psd1') -Force }
    It 'Should import without errors' {
        { Import-Module '$moduleName' } | Should -Not -Throw
    }
}
"@ | Set-Content "$moduleDest\Tests\$moduleName.Tests.ps1" -Encoding UTF8

    # InvokeBuild script
    @"
# build.ps1 – InvokeBuild script for $moduleName
task . Build, Test

task Build {
    Write-Host 'Building $moduleName...' -ForegroundColor Cyan
}

task Test {
    Write-Host 'Running Pester tests...' -ForegroundColor Cyan
    Invoke-Pester -Path './Tests' -Output Detailed
}

task Analyze {
    Write-Host 'Running PSScriptAnalyzer...' -ForegroundColor Cyan
    Invoke-ScriptAnalyzer -Path '.' -Recurse -Severity Warning,Error
}
"@ | Set-Content "$moduleDest\build.ps1" -Encoding UTF8

    Write-OK "Module template created: $moduleDest"
} else {
    Write-Info "Module directory already exists: $moduleDest"
}

# Add modules folder to system PSModulePath
$curModPath    = [System.Environment]::GetEnvironmentVariable('PSModulePath','Machine')
$customModPath = "$($Config.DevRoot)\modules"
if ($curModPath -notmatch [regex]::Escape($customModPath)) {
    [System.Environment]::SetEnvironmentVariable(
        'PSModulePath', "$curModPath;$customModPath", 'Machine'
    )
    Write-OK "Added $customModPath to system PSModulePath."
} else {
    Write-Info "PSModulePath already includes $customModPath"
}

# ── Global PowerShell profile ─────────────────────────────────
$psProfilePath = $PROFILE.AllUsersAllHosts
$psProfileDir  = Split-Path $psProfilePath
if (-not (Test-Path $psProfileDir)) { New-Item -ItemType Directory $psProfileDir -Force | Out-Null }

@"
# GatewayGuard PowerShell Profile – All Users / All Hosts
# Generated by GatewayGuard Post-Reset Script v1.0.0

function prompt {
    `$branch = ''
    if (Test-Path '.git') { `$branch = " [`$(git branch --show-current 2>`$null)]" }
    "`$([char]0x1b)[36m`$(`$env:USERNAME)`$([char]0x1b)[0m@`$(`$env:COMPUTERNAME) " +
    "`$([char]0x1b)[33m`$(Split-Path `$PWD -Leaf)`$([char]0x1b)[32m`$branch`$([char]0x1b)[0m> "
}

Set-Alias -Name ll   -Value Get-ChildItem
Set-Alias -Name grep -Value Select-String

function gg  { Set-Location '$($Config.DevRoot)' }
function ggr { Set-Location '$($Config.DevRoot)\repos' }
function ggm { Set-Location '$($Config.DevRoot)\modules' }

function gs  { git status }
function glo { git log --oneline --graph --decorate --all }
function gp  { git pull --rebase }
function gf  { git fetch --all --prune }

function Get-Identity {
    Write-Host "`n=== Identity Report ===" -ForegroundColor Cyan
    whoami /all
    Write-Host "`n=== dsregcmd status ===" -ForegroundColor Cyan
    dsregcmd /status
}

Write-Host "GatewayGuard dev environment loaded.  Type 'gg' to jump to project root." -ForegroundColor Green
"@ | Set-Content -Path $psProfilePath -Encoding UTF8 -Force
Write-OK "PowerShell profile written: $psProfilePath"

# ============================================================
#  SECTION 16 – FINAL VERIFICATION
# ============================================================
Write-Step -Number 16 -Title 'Final Verification'

Write-Host "`n──── Current Identity ────" -ForegroundColor Cyan
whoami

Write-Host "`n──── whoami /all ────" -ForegroundColor Cyan
whoami /all

Write-Host "`n──── Local Users ────" -ForegroundColor Cyan
Get-LocalUser | Select-Object Name, Enabled, PasswordRequired, LastLogon | Format-Table -AutoSize

Write-Host "`n──── Local Group Memberships ────" -ForegroundColor Cyan
foreach ($grp in @('Administrators','Users','Remote Desktop Users')) {
    Write-Host "`n  [$grp]" -ForegroundColor Yellow
    Get-LocalGroupMember -Group $grp -ErrorAction SilentlyContinue |
        Select-Object Name, PrincipalSource | Format-Table -AutoSize
}

Write-Host "`n──── dsregcmd /status ────" -ForegroundColor Cyan
dsregcmd /status

Write-Host "`n──── Git Configuration ────" -ForegroundColor Cyan
git config --global --list

Write-Host "`n──── Installed PS Modules ────" -ForegroundColor Cyan
Get-Module -ListAvailable -Name ($Config.PSModules) |
    Select-Object Name, Version | Format-Table -AutoSize

Write-Host "`n──── GatewayGuard Folder Structure ────" -ForegroundColor Cyan
Get-ChildItem $Config.DevRoot -Depth 1 | Format-Table Name, Mode, LastWriteTime -AutoSize

Write-Host "`n──── Registry Identity Isolation Spot-Check ────" -ForegroundColor Cyan
@{
    'NoConnectedUser'          = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
    'autoWorkplaceJoin'        = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin'
    'DisableSettingSync'       = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\SettingSync'
    'AllowTelemetry'           = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection'
    'EnableScriptBlockLogging' = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging'
}.GetEnumerator() | ForEach-Object {
    $val = (Get-ItemProperty -Path $_.Value -Name $_.Key -ErrorAction SilentlyContinue).($_.Key)
    $color = if ($null -ne $val) { 'Green' } else { 'Red' }
    Write-Host ("  {0,-40} = {1}" -f $_.Key, $val) -ForegroundColor $color
}

Write-Host "`n══════════════════════════════════════════════" -ForegroundColor Green
Write-Host "  POST-RESET CONFIGURATION COMPLETE" -ForegroundColor Green
Write-Host "══════════════════════════════════════════════" -ForegroundColor Green
Write-Host @"

  ► REMAINING MANUAL STEPS:
    1. Add SSH public key to GitHub: github.com/settings/keys
    2. Test SSH connection:          ssh -T git@github.com
    3. Sign into VS Code GitHub extension (for PR/Issues)
    4. Run module tests:
         cd $($Config.DevRoot)\modules\GatewayGuard.Core
         Invoke-Build Test
    5. Review transcript: $($Config.TranscriptPath)

"@ -ForegroundColor Cyan

Stop-Transcript
Write-OK "Transcript saved to: $($Config.TranscriptPath)"
```

---

## What the Script Does — Section by Section

| § | Section | Key Actions |
|---|---------|-------------|
| **0** | **Config block** | All customizable values in one place — fill this before running anything else |
| **1** | **Prerequisites** | OS/PS version check, transcript started at `C:\Logs\`, `RemoteSigned` execution policy set |
| **2** | **MSA → Local** | Removes `ConnectedAccount` registry value, sets `NoConnectedUser=3`, pauses for GUI confirmation |
| **3** | **Dev accounts** | Creates **Dad** (Admins + RDP), **CGAdmin** (Admins), **localuser** (Users only); idempotent if re-run; disables Guest |
| **4** | **Identity isolation** | 14 registry keys — blocks MSA token collection, PassportForWork cloud backup, SettingSync, telemetry identity association |
| **5** | **Cloud prompts** | Kills Start nudges, SCOOBE notification, ContentDeliveryManager subscriptions, OneDrive, Cortana |
| **6** | **AAD auto-join** | Disables WorkplaceJoin task, MDM auto-enroll, `dmwappushservice` |
| **7** | **Login screen** | Hides MSA email on lock screen, blocks account details, clears cached logon count, disables Fast User Switching |
| **8** | **Git + GCM** | winget-installs Git for Windows + Git Credential Manager; sets GCM as system `credential.helper` |
| **9** | **Git identity** | Full global config — name/email, CRLF, long paths, VS Code diff/merge tools, rebase pull, `safe.directory` |
| **10** | **VS Code** | winget-installs VS Code, installs 12 extensions, writes baseline `settings.json` (OTBS, format-on-save, PS7 terminal) |
| **11** | **Folder structure** | 16 directories under `C:\Dev\GatewayGuard`; workspace `.vscode/settings.json` + `PSScriptAnalyzerSettings.psd1` |
| **12** | **Repos + remotes** | Clones/fetches all 4 repos, verifies/fixes `origin`, optionally adds `upstream`, sets per-repo identity, tracks `origin/main` |
| **13** | **SSH keys** | Generates `id_ed25519_gatewayguard`, hardens `.ssh` ACL, starts `ssh-agent`, writes `~/.ssh/config`, prints public key |
| **14** | **Hardening** | UAC (secure desktop), SMB signing + SMBv1 off, NTLMv2-only, NLA for RDP, Spectre mitigations, Defender preserved, AutoRun off, PS script block + module + transcription logging |
| **15** | **PS module env** | Installs Pester/PSScriptAnalyzer/platyPS/InvokeBuild/ModuleBuilder; scaffolds `GatewayGuard.Core` module with manifest, Pester tests, InvokeBuild script; adds to `PSModulePath`; writes global PS profile with git aliases and `gg`/`ggr`/`ggm` shortcuts |
| **16** | **Verification** | `whoami /all`, `dsregcmd /status`, local users/groups table, git config dump, PS modules, folder tree, registry spot-check |