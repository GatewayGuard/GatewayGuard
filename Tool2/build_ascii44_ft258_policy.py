"""build_ascii44_ft258_policy -- FT-258, the Group Policy override check.

Bill, 2026-09-07: "add the policy check to checkup".

WHAT A POLICY DOES, AND WHY IT MATTERS TO A HOME USER
-----------------------------------------------------
A value under HKLM\\SOFTWARE\\Policies wins over the setting the user can
reach in Windows Security. When one is present and hostile, the user opens
Windows Security, clicks the switch, and NOTHING HAPPENS -- it bounces back or
is greyed out. They conclude they did it wrong.

They usually did not put it there. On a home machine the realistic sources
are, in order: a work or school account signed into Windows; a "debloat",
"privacy" or "speed up Windows" tool run once and forgotten; a technician; a
third-party antivirus that switched Defender off by policy and never put it
back on uninstall; and malware.

EVERY KEY BELOW WAS READ OUT OF WINDOWS' OWN POLICY DEFINITIONS ON THIS
MACHINE -- not remembered, not inferred. C:\\Windows\\PolicyDefinitions\\*.admx
declares, for each policy, the exact key, the exact value name, and the
numbers that mean enabled and disabled. Measured 2026-09-07 on CGDELL:

  WindowsExplorer.admx  policy EnableSmartScreen
      Software\\Policies\\Microsoft\\Windows\\System\\EnableSmartScreen
      enabled=1  disabled=0
  WindowsDefender.admx  policy DisableAntiSpywareDefender
      Software\\Policies\\Microsoft\\Windows Defender\\DisableAntiSpyware
      enabled=1  disabled=0        (1 = Defender turned OFF by policy)
  WindowsDefender.admx  policy DisableRealtimeMonitoring
      Software\\Policies\\Microsoft\\Windows Defender\\Real-Time Protection\\
      DisableRealtimeMonitoring     enabled=1  disabled=0
  WindowsFirewall.admx  policies WF_EnableFirewall_Name_1 and _2
      SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile\\EnableFirewall
      SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\StandardProfile\\EnableFirewall
      enabled=1  disabled=0

WHY ONLY THREE SETTINGS, AND WHY EACH IS TREATED DIFFERENTLY
-----------------------------------------------------------
This was scoped by reading what each check already does, not by assuming.

  Item 4, SmartScreen -- THE VERDICT ITSELF IS WRONG WITHOUT THIS. The check
  reads HKLM\\...\\Explorer\\SmartScreenEnabled, which is the USER's value. The
  policy lives somewhere else entirely and overrides it, so the check can read
  "Warn" and report GOOD while SmartScreen is off. Here the policy decides the
  verdict.

  Item 2, Defender real-time, and item 7, firewall -- THE VERDICT IS ALREADY
  RIGHT. Both read the EFFECTIVE state (Get-MpComputerStatus and
  Get-NetFirewallProfile), which already reflects any policy. What they cannot
  say is WHY it is off, and that clicking the switch will not fix it. So the
  policy is added as an explanation and never changes GOOD to BAD or back.

  Items 12, 13, 14 and 15 are DELIBERATELY EXCLUDED. Checkup sets those
  through policy keys itself -- build lines 6631-6665. A policy check on them
  would report Checkup's own work as an outside override, which is worse than
  no check at all.

ONE INSERTION POINT, NOT THREE. The pass runs after every status is probed
and before the auto-deselect, so an ON-by-policy GOOD still gets deselected by
the existing loop. Putting three separate edits inside the big switch branches
would have been three chances to break a working check for no gain.

FIREWALL PROFILES: only DomainProfile and StandardProfile are wired, because
those are the only two Windows' own template declares. Private and Public
profiles are written by a different mechanism (Windows Firewall with Advanced
Security) and are NOT included, because nothing on this machine let me verify
their key shape. An unverified path here costs nothing when absent but would
be a claim I could not stand behind. Raised, not guessed.

A BLOCKED READ SAYS NOTHING. If the policy key itself cannot be read, the
helper moves on rather than reporting a state it did not establish -- FT-120,
FT-141 and FT-257, the same rule three times over.

Run from Tool2/:  python build_ascii44_ft258_policy.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

# ---------------------------------------------------------------- 1. helper
HELPER_ANCHOR = (
    '# ============================================================\n'
    '# STEP 3: ADMIN CHECK\n'
    '# ============================================================\n'
)

HELPER = (
    '# ============================================================\n'
    '# GROUP POLICY OVERRIDE CHECK  (FT-258)\n'
    '# ============================================================\n'
    '# A value under HKLM\\SOFTWARE\\Policies BEATS the setting the user can\n'
    '# reach in Windows Security. When one is present and hostile the user\n'
    '# clicks the switch and nothing happens -- it bounces back or is greyed\n'
    '# out -- and they conclude they did it wrong. Checkup should say so.\n'
    '#\n'
    '# On a home machine these arrive from a work or school account signed\n'
    '# into Windows, a "debloat" or "privacy" tool run once and forgotten, a\n'
    '# technician, an old antivirus that switched Defender off by policy and\n'
    '# never put it back, or malware.\n'
    '#\n'
    '# Every key passed to this is read out of Windows own policy definitions\n'
    '# in C:\\Windows\\PolicyDefinitions -- see build_ascii44_ft258_policy.py\n'
    '# for the exact ADMX file, policy name and numbers behind each one.\n'
    '#\n'
    '# Returns "OFF" if a policy forces the setting off, "ON" if a policy\n'
    '# forces it on, and $null if no policy applies. A key that cannot be\n'
    '# READ returns nothing for that entry rather than a guess -- FT-120,\n'
    '# FT-141 and FT-257 are all the same rule: a check that did not\n'
    '# establish the state never invents a definite answer.\n'
    '#\n'
    '# Each entry in -Checks is a hashtable:\n'
    '#     @{ Path = "HKLM:\\SOFTWARE\\Policies\\..."   # the policy key\n'
    '#        Name = "EnableSmartScreen"              # the value name\n'
    '#        OnWhen  = 1                             # optional\n'
    '#        OffWhen = 0 }                           # optional\n'
    'function Get-GGPolicyLock {\n'
    '    param(\n'
    '        [Parameter(Mandatory=$true)][array]$Checks\n'
    '    )\n'
    '    foreach ($ggC in $Checks) {\n'
    '        $ggVal = $null\n'
    '        try {\n'
    '            $ggVal = (Get-ItemProperty -Path $ggC.Path -Name $ggC.Name -EA Stop).($ggC.Name)\n'
    '        } catch {\n'
    '            # Missing key, missing value, or a refused read. All three mean\n'
    '            # "this entry tells us nothing", so move on.\n'
    '            continue\n'
    '        }\n'
    '        if ($null -eq $ggVal) { continue }\n'
    '        # Compared as text so a REG_SZ policy cannot throw a cast error.\n'
    '        if ($null -ne $ggC.OffWhen -and "$ggVal" -eq "$($ggC.OffWhen)") { return "OFF" }\n'
    '        if ($null -ne $ggC.OnWhen  -and "$ggVal" -eq "$($ggC.OnWhen)")  { return "ON" }\n'
    '    }\n'
    '    return $null\n'
    '}\n'
    '\n'
) + HELPER_ANCHOR

# ------------------------------------------------------------- 2. the pass
PASS_ANCHOR = (
    '    # Auto-deselect items already at recommended setting\n'
    '    foreach ($s in $Settings) {\n'
    '        if ($s.Status -match "GOOD") { $s.Selected = $false }\n'
    '    }\n'
)

PASS = (
    '    # FT-258: SAY WHEN A GROUP POLICY IS THE REASON.\n'
    '    # Runs after every status is probed and BEFORE the auto-deselect\n'
    '    # below, so an ON-by-policy GOOD is still deselected by the existing\n'
    '    # loop and nothing has to be duplicated here.\n'
    '    # Three settings only, and each for a measured reason:\n'
    '    #   4  the verdict is WRONG without this -- the check reads the USER\'s\n'
    '    #      SmartScreenEnabled value, and the policy lives elsewhere and\n'
    '    #      overrides it, so it can read "Warn" while SmartScreen is off.\n'
    '    #   2  and 7 already read the EFFECTIVE state (Get-MpComputerStatus,\n'
    '    #      Get-NetFirewallProfile), so their verdict is already right. The\n'
    '    #      policy is added only as the REASON, and never turns a GOOD into\n'
    '    #      a BAD or back.\n'
    '    # Items 12-15 are excluded on purpose: Checkup sets those through\n'
    '    # policy keys itself, so a check would report our own work as an\n'
    '    # outside override.\n'
    '    foreach ($s in $Settings) {\n'
    '        $ggLock = $null\n'
    '        try {\n'
    '            switch ($s.ID) {\n'
    '                2 {\n'
    '                    $ggLock = Get-GGPolicyLock @(\n'
    '                        @{ Path = "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows Defender";                          Name = "DisableAntiSpyware";        OffWhen = 1 },\n'
    '                        @{ Path = "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Real-Time Protection";     Name = "DisableRealtimeMonitoring"; OffWhen = 1 })\n'
    '                }\n'
    '                4 {\n'
    '                    $ggLock = Get-GGPolicyLock @(\n'
    '                        @{ Path = "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\System";                           Name = "EnableSmartScreen";         OnWhen = 1; OffWhen = 0 })\n'
    '                }\n'
    '                7 {\n'
    '                    $ggLock = Get-GGPolicyLock @(\n'
    '                        @{ Path = "HKLM:\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile";            Name = "EnableFirewall";            OffWhen = 0 },\n'
    '                        @{ Path = "HKLM:\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\StandardProfile";          Name = "EnableFirewall";            OffWhen = 0 })\n'
    '                }\n'
    '            }\n'
    '        } catch { $ggLock = $null }\n'
    '\n'
    '        if ($ggLock -eq "OFF") {\n'
    '            # Applying cannot work while the policy stands, so do not offer\n'
    '            # it as a fix -- tell the user what is holding it instead.\n'
    '            if ($s.ID -eq 4) {\n'
    '                $s.Status = "OFF by a policy on this PC -- Checkup cannot change it"\n'
    '            } elseif ([string]$s.Status -notmatch "policy") {\n'
    '                $s.Status = [string]$s.Status + " -- held OFF by a policy on this PC"\n'
    '            }\n'
    '            $s.Selected = $false\n'
    '            try { Write-Log -Message ("$($s.Name) | held OFF by a Group Policy -- the switch in Windows Security will not stick (FT-258)") -Status "WARN" } catch {}\n'
    '        } elseif ($ggLock -eq "ON" -and $s.ID -eq 4) {\n'
    '            $s.Status = "ON by a policy on this PC -- GOOD"\n'
    '            try { Write-Log -Message ("$($s.Name) | held ON by a Group Policy (FT-258)") -Status "GOOD" } catch {}\n'
    '        }\n'
    '    }\n'
    '\n'
) + PASS_ANCHOR

with PS1Edit(TARGET) as e:
    e.replace(
        HELPER_ANCHOR, HELPER, count=1,
        why="FT-258: Get-GGPolicyLock helper, inserted before the admin check",
    )
    e.replace(
        PASS_ANCHOR, PASS, count=1,
        why="FT-258: policy pass for items 2, 4 and 7, before the auto-deselect",
    )
