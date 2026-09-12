# Check-StoreDomain-2026-08-31.ps1
#
# Purpose : Say, in plain English, whether store.gatewayguard.co is pointing at
#           Gumroad yet -- and confirm the website and email records were not
#           disturbed while the store record was added.
#
# READ-ONLY. It looks things up. It changes nothing, on this PC or at Namecheap.
# No administrator rights needed.
#
# Written 2026-08-31 for CPM task T-GR1.

$ErrorActionPreference = "Continue"

$Domain    = "gatewayguard.co"
$StoreHost = "store.gatewayguard.co"
$Expected  = "domains.gumroad.com"

$stamp   = Get-Date -Format "yyyy-MM-dd_HH-mm"
$outDir  = Join-Path (Split-Path -Parent $PSScriptRoot) "Test_Results"
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force | Out-Null }
$outFile = Join-Path $outDir ("StoreDomain-" + $env:COMPUTERNAME + "-" + $stamp + ".txt")

$lines = New-Object System.Collections.ArrayList
function Say([string]$t) {
    Write-Host $t
    [void]$lines.Add($t)
}

Say ""
Say "=============================================================="
Say "  STORE DOMAIN CHECK"
Say "  Run: $(Get-Date -Format 'yyyy-MM-dd HH:mm') on $env:COMPUTERNAME"
Say "=============================================================="
Say ""
Say "  This check is READ-ONLY. It changes nothing."
Say ""

# ---------------------------------------------------------------- the store record
Say "--------------------------------------------------------------"
Say "  1. THE NEW STORE RECORD"
Say "--------------------------------------------------------------"
Say ""

$store = Resolve-DnsName -Name $StoreHost -ErrorAction SilentlyContinue
if (-not $store) {
    Say "  NOT THERE YET."
    Say ""
    Say "    $StoreHost does not resolve."
    Say ""
    Say "  What this means: either the record has not been added at"
    Say "  Namecheap yet, or it has been added and has not spread"
    Say "  across the internet yet. Both are normal."
    Say ""
    Say "  What to do: if you added it in the last 48 hours, wait and"
    Say "  run this again. If it has been longer than that, sign in at"
    Say "  https://ap.www.namecheap.com and check the Advanced DNS tab"
    Say "  for a row reading:"
    Say ""
    Say "      CNAME Record | store | $Expected | Automatic"
    Say ""
} else {
    $cname = $store | Where-Object { $_.Type -eq "CNAME" } | Select-Object -First 1
    $target = ""
    if ($cname) { $target = [string]$cname.NameHost }

    if ($target -like "*gumroad*") {
        Say "  LIVE, AND POINTING AT GUMROAD."
        Say ""
        Say "    $StoreHost  ->  $target"
        Say ""
        Say "  What to do next: go to your Gumroad Settings, then Advanced,"
        Say "  put $StoreHost in the Custom domain box and click Verify."
        Say ""
    } elseif ($target -ne "") {
        Say "  LIVE, BUT POINTING SOMEWHERE UNEXPECTED."
        Say ""
        Say "    $StoreHost  ->  $target"
        Say "    expected                    ->  $Expected"
        Say ""
        Say "  What to do: check the Value column on the store row at"
        Say "  Namecheap. It should read exactly $Expected"
        Say ""
    } else {
        Say "  IT RESOLVES, BUT NOT AS A CNAME."
        Say ""
        foreach ($r in $store) {
            Say ("    " + $r.Name + "  " + $r.Type + "  " + $r.IPAddress + $r.NameHost)
        }
        Say ""
        Say "  What to do: Gumroad needs a CNAME record, not an A record."
        Say "  At Namecheap, the store row's Type must be CNAME Record."
        Say ""
    }
}

# ---------------------------------------------------------------- nothing else broke
Say "--------------------------------------------------------------"
Say "  2. NOTHING ELSE WAS DISTURBED"
Say "--------------------------------------------------------------"
Say ""
Say "  These were correct before the store record was added. They"
Say "  should be unchanged. If any line says MISSING, something was"
Say "  edited that should not have been."
Say ""

# website -- apex A records should be GitHub Pages
$apexA = Resolve-DnsName -Name $Domain -Type A -ErrorAction SilentlyContinue |
         Where-Object { $_.Type -eq "A" }
$ghIps = @("185.199.108.153","185.199.109.153","185.199.110.153","185.199.111.153")
$gotIps = @()
if ($apexA) { $gotIps = @($apexA | ForEach-Object { [string]$_.IPAddress }) }
$ghHits = @($gotIps | Where-Object { $ghIps -contains $_ })

if ($ghHits.Count -ge 1) {
    Say ("  WEBSITE (apex)      OK        " + $ghHits.Count + " of 4 GitHub Pages addresses present")
} else {
    Say  "  WEBSITE (apex)      MISSING   the GitHub Pages addresses are gone"
    Say  "                                the website will not load. Restore the"
    Say  "                                four A records on host @:"
    foreach ($ip in $ghIps) { Say ("                                  " + $ip) }
}

# website -- www
$wwwRec = Resolve-DnsName -Name ("www." + $Domain) -ErrorAction SilentlyContinue |
          Where-Object { $_.Type -eq "CNAME" } | Select-Object -First 1
if ($wwwRec -and ([string]$wwwRec.NameHost) -like "*github*") {
    Say ("  WEBSITE (www)       OK        www -> " + $wwwRec.NameHost)
} else {
    Say  "  WEBSITE (www)       MISSING   www should be a CNAME to"
    Say  "                                gatewayguard.github.io"
}

# email -- MX
$mx = Resolve-DnsName -Name $Domain -Type MX -ErrorAction SilentlyContinue |
      Where-Object { $_.Type -eq "MX" }
if ($mx) {
    Say ("  EMAIL (MX)          OK        " + $mx.Count + " mail server(s) listed")
    foreach ($m in $mx) { Say ("                                  " + $m.NameExchange) }
} else {
    Say  "  EMAIL (MX)          MISSING   support@$Domain cannot receive mail."
    Say  "                                Restore the two privateemail.com MX rows"
    Say  "                                at Namecheap immediately."
}

# email -- SPF, and the Microsoft verification
$txt = Resolve-DnsName -Name $Domain -Type TXT -ErrorAction SilentlyContinue |
       Where-Object { $_.Type -eq "TXT" }
$allTxt = ""
if ($txt) { $allTxt = ($txt | ForEach-Object { $_.Strings }) -join " " }

if ($allTxt -match "v=spf1") {
    Say  "  EMAIL (SPF)         OK        anti-spam record present"
} else {
    Say  "  EMAIL (SPF)         MISSING   your mail may be marked as spam."
    Say  "                                Restore the TXT record:"
    Say  "                                  v=spf1 include:spf.privateemail.com ~all"
}

if ($allTxt -match "MS=") {
    Say  "  MICROSOFT 365       OK        domain verification record present"
} else {
    Say  "  MICROSOFT 365       MISSING   the MS= verification TXT record is gone"
}

Say ""
Say "--------------------------------------------------------------"
Say "  Full results saved to:"
Say ("    " + $outFile)
Say "--------------------------------------------------------------"
Say ""

$lines | Out-File -FilePath $outFile -Encoding utf8
