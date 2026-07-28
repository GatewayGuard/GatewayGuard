# GatewayGuard -- .ps1 file-integrity gate
# Runs automatically after every Write/Edit to a .ps1 file.
#
# Enforces DefectPreventionPlaybook CLASS 7, earned by the 2026-07-25
# ascii34 corruption (341 KB / 5,574 lines -> 13.7 MB / 228,739 lines,
# unparseable). Brace balance alone did NOT catch that -- the corrupt file
# measured 47,232/47,232, perfectly balanced. The checks that DID catch it
# were the parse check and the size check, so both are enforced here.
#
# Reads the hook payload as JSON on stdin. Exits silently for non-.ps1 files.

$ErrorActionPreference = 'Stop'

function Write-HookResult($obj) { $obj | ConvertTo-Json -Depth 5 -Compress }

try {
    $raw = [Console]::In.ReadToEnd()
    if (-not $raw) { exit 0 }
    $data = $raw | ConvertFrom-Json

    $path = $null
    if ($data.tool_input -and $data.tool_input.file_path)      { $path = $data.tool_input.file_path }
    elseif ($data.tool_response -and $data.tool_response.filePath) { $path = $data.tool_response.filePath }

    if (-not $path)                          { exit 0 }
    if ($path -notmatch '\.ps1$')            { exit 0 }
    if (-not (Test-Path -LiteralPath $path)) { exit 0 }

    # Plausibility bounds for this project. ascii36 = 6,134 total lines / ~380 KB.
    # Generous headroom (~2.4x); the 2026-07-25 corruption was 37x over.
    $MaxLines = 15000
    $MaxBytes = 1500000

    $e = $null; $t = $null
    [System.Management.Automation.Language.Parser]::ParseFile($path, [ref]$t, [ref]$e) | Out-Null
    $parseErrors = @($e).Count

    # NOTE: two line metrics on purpose. Measure-Object -Line skips blank lines;
    # ReadAllLines counts them. Project convention (Playbook Appendix A) is that
    # the figure quoted in headers and CLAUDE.md is the NON-BLANK number.
    $nonBlank = (Get-Content -LiteralPath $path | Measure-Object -Line).Lines
    $total    = [System.IO.File]::ReadAllLines($path).Length
    $bytes    = (Get-Item -LiteralPath $path).Length
    $txt      = [System.IO.File]::ReadAllText($path)
    $open     = ([regex]::Matches($txt, '\{')).Count
    $close    = ([regex]::Matches($txt, '\}')).Count

    $name    = Split-Path $path -Leaf
    $summary = "$name -- parse errors: $parseErrors | lines: $nonBlank non-blank / $total total | bytes: $bytes | braces: $open open / $close close"

    $fail = @()
    if ($parseErrors -gt 0)   { $fail += "PARSE FAILED ($parseErrors errors)" }
    if ($open -ne $close)     { $fail += "BRACE IMBALANCE ($open open / $close close)" }
    if ($total -gt $MaxLines) { $fail += "LINE COUNT IMPLAUSIBLE ($total lines, limit $MaxLines)" }
    if ($bytes -gt $MaxBytes) { $fail += "BYTE SIZE IMPLAUSIBLE ($bytes bytes, limit $MaxBytes)" }

    if ($fail.Count -gt 0) {
        $reason = ($fail -join '; ') + " -- $summary. " +
                  "Playbook Class 7 rule 5: STOP. Do NOT hand-patch this file -- " +
                  "that compounds the damage and destroys evidence of the mechanism. " +
                  "Recover byte-for-byte from a known-good copy (Claude Code file history " +
                  "at C:\Users\willi\.claude\file-history, or the prior build under Tool\), " +
                  "confirm by line count and parse check, and preserve the damaged copy."
        Write-HookResult @{
            decision      = 'block'
            reason        = $reason
            systemMessage = "BLOCKED -- .ps1 integrity check failed: " + ($fail -join '; ')
        }
        exit 0
    }

    Write-HookResult @{
        suppressOutput     = $true
        hookSpecificOutput = @{
            hookEventName     = 'PostToolUse'
            additionalContext = "PS1 INTEGRITY OK -- $summary"
        }
    }
    exit 0
}
catch {
    Write-HookResult @{ systemMessage = "PS1 integrity hook error: $($_.Exception.Message)" }
    exit 0
}
