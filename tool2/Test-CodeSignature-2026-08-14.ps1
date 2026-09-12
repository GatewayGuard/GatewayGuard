# Test-CodeSignature-2026-08-14.ps1
# Dated: 2026-08-14 17:05 ET
#
# WHAT IT DOES: signs a THROWAWAY file with the GatewayGuard code signing
# certificate, then verifies the signature came out valid. This is launch plan
# item B4.
#
# WHY IT EXISTS: the DigiCert certificate was issued 2026-08-14 and has never
# signed anything. A certificate that cannot be demonstrated to sign is not yet
# an asset. Finding that out on feature-freeze day costs hours; finding it out
# now costs minutes.
#
# IT DOES NOT TOUCH THE BUILD. It signs a file it creates itself, in
# Test_Results\SignTest-<stamp>\, and never opens any ascii*.ps1.
#
# DOES NOT NEED ADMINISTRATOR.
#
# YOU WILL BE ASKED FOR THE TOKEN PASSWORD. SafeNet shows its own window when
# the private key is used. That is the eToken asking, not this script, and it
# is the expected behaviour -- the key lives on the token and never leaves it.
#
# PS 5.1 COMPATIBLE: -join only, no Join-String, no ternary.

$ErrorActionPreference = 'Stop'

# The certificate issued 2026-08-14.
# VERIFIED 2026-08-14 measured on CGDELL: Get-ChildItem Cert:\CurrentUser\My
#   returned this thumbprint for CN=GatewayGuard LLC, HasPrivateKey True.
$THUMBPRINT = '0995F50D9496116A36624D8A81B404439C55B796'

# Timestamping is what keeps a signature valid AFTER the certificate expires
# on 2027-08-16. Without it, everything signed stops verifying that day.
# sourced: DigiCert's published RFC 3161 timestamp endpoint.
$TIMESTAMP = 'http://timestamp.digicert.com'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projRoot  = Split-Path -Parent $scriptDir
$stamp     = (Get-Date).ToString('yyyy-MM-dd-HHmm')
$outDir    = Join-Path (Join-Path $projRoot 'Test_Results') ("SignTest-" + $stamp)
$report    = Join-Path $outDir 'SignTest-Report.txt'

$L = New-Object System.Collections.Generic.List[string]
function Say([string]$t) { Write-Host $t; $L.Add($t) }

Say ""
Say "=== CODE SIGNING TEST -- launch plan B4 ==="
Say ("    Run: " + (Get-Date).ToString('yyyy-MM-dd HH:mm') + " ET")
Say ""

# --- 1. find the certificate --------------------------------------------
$cert = @(Get-ChildItem -Path Cert:\CurrentUser\My |
          Where-Object { $_.Thumbprint -eq $THUMBPRINT })

if ($cert.Count -eq 0) {
    Say "STOPPED. No certificate with that thumbprint in Cert:\CurrentUser\My."
    Say ("  Looking for: " + $THUMBPRINT)
    Say ""
    Say "  Most likely the eToken is not plugged in, or SafeNet Authentication"
    Say "  Client is not running. Plug the token in and run this again."
    Say ""
    Read-Host "Press Enter to close"
    return
}
$cert = $cert[0]

Say "STEP 1 -- certificate found"
Say ("  Subject     : " + $cert.Subject)
Say ("  Issuer      : " + $cert.Issuer)
Say ("  Serial      : " + $cert.SerialNumber)
Say ("  Valid to    : " + $cert.NotAfter.ToString('yyyy-MM-dd'))
Say ("  Private key : " + $cert.HasPrivateKey)
Say ""

if (-not $cert.HasPrivateKey) {
    Say "STOPPED. The certificate is present but its private key is not reachable."
    Say "  Nothing can be signed in this state. Check the token is unlocked."
    Say ""
    Read-Host "Press Enter to close"
    return
}

# --- 2. make a throwaway file -------------------------------------------
New-Item -ItemType Directory -Path $outDir -Force | Out-Null
$victim = Join-Path $outDir 'throwaway-DO-NOT-SHIP.ps1'

$body = @(
    "# Throwaway file. Created only to prove the certificate can sign.",
    "# Not part of GatewayGuard Checkup. Safe to delete.",
    ("# Created " + (Get-Date).ToString('yyyy-MM-dd HH:mm') + " ET"),
    "Write-Host 'If you are reading this, the signing test wrote its test file.'"
) -join "`r`n"

Set-Content -LiteralPath $victim -Value $body -Encoding UTF8

Say "STEP 2 -- throwaway file written"
Say ("  " + $victim)
Say ""

# --- 3. sign it ----------------------------------------------------------
Say "STEP 3 -- signing"
Say "  SafeNet will now ask for the TOKEN PASSWORD in its own window."
Say "  That prompt is the eToken, not this script. The key never leaves it."
Say ""

$signed = $null
$signErr = ''
try {
    $signed = Set-AuthenticodeSignature -FilePath $victim -Certificate $cert `
                  -TimestampServer $TIMESTAMP -HashAlgorithm SHA256
} catch {
    $signErr = $_.Exception.Message
}

if ($signErr -ne '') {
    Say "  FAILED to sign."
    Say ("  " + $signErr)
    Say ""
    Say "  Common causes, in order of likelihood:"
    Say "    - wrong token password, or the password has expired (it expires 2026-09-13)"
    Say "    - token removed, or SafeNet client not running"
    Say "    - the timestamp server was unreachable -- check the internet connection"
    $L -join "`r`n" | Set-Content -LiteralPath $report -Encoding UTF8
    Say ("  Report: " + $report)
    Say ""
    Read-Host "Press Enter to close"
    return
}

Say ("  Set-AuthenticodeSignature returned: " + $signed.Status)
Say ""

# --- 4. verify independently ---------------------------------------------
# Reading the signature back is a different operation from writing it. A write
# that reports success and a read that disagrees is exactly the failure class
# this project keeps hitting -- [GOOD] printed over a command that never ran.
Say "STEP 4 -- reading the signature back"
$check = Get-AuthenticodeSignature -LiteralPath $victim

Say ("  Status         : " + $check.Status)
Say ("  Status message : " + $check.StatusMessage)
if ($check.SignerCertificate) {
    Say ("  Signed by      : " + $check.SignerCertificate.Subject)
    Say ("  Thumbprint     : " + $check.SignerCertificate.Thumbprint)
}
if ($check.TimeStamperCertificate) {
    Say ("  Timestamped by : " + $check.TimeStamperCertificate.Subject)
} else {
    Say "  Timestamped by : NOTHING -- see the warning below"
}
Say ""

# --- 5. the verdict -------------------------------------------------------
$okStatus = ($check.Status.ToString() -eq 'Valid')
$okSigner = $false
if ($check.SignerCertificate) {
    $okSigner = ($check.SignerCertificate.Thumbprint -eq $THUMBPRINT)
}
$okStamp  = ($check.TimeStamperCertificate -ne $null)

Say "=== VERDICT ==="
if ($okStatus -and $okSigner -and $okStamp) {
    Say ""
    Say "  PASS. The certificate signs, and the signature verifies."
    Say ""
    Say "  B4 is done. Signing the real build is the same command against the"
    Say "  build file instead of the throwaway."
} else {
    Say ""
    Say "  NOT A CLEAN PASS. Details:"
    if (-not $okStatus) { Say ("    - status is " + $check.Status + ", wanted Valid") }
    if (-not $okSigner) { Say  "    - the signer thumbprint does not match the expected certificate" }
    if (-not $okStamp)  {
        Say  "    - NO TIMESTAMP. The signature is unstamped, so it stops"
        Say  "      verifying when the certificate expires on 2027-08-16."
        Say  "      Everything shipped must be timestamped. Do not sign the"
        Say  "      real build until this succeeds."
    }
}
Say ""
Say ("  Throwaway file and this report are in: " + $outDir)
Say "  Nothing in the build was touched. The folder is safe to delete."
Say ""

$L -join "`r`n" | Set-Content -LiteralPath $report -Encoding UTF8
Write-Host ("  Report written: " + $report)
Write-Host ""
Read-Host "Press Enter to close"
