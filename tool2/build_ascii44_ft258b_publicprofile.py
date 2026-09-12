"""build_ascii44_ft258b_publicprofile -- FT-258 correction: the Public profile.

Bill, 2026-09-07: "I thought there were 3 and now you mentioned four."

HE WAS RIGHT, AND I HAD DOUBLE-COUNTED ONE PROFILE UNDER TWO NAMES.

THERE ARE THREE FIREWALL PROFILES. ***Measured on CGDELL 2026-09-07,
Get-NetFirewallProfile:*** Domain, Private, Public.

THE REGISTRY CALLS "PRIVATE" BY ITS OLD NAME, "STANDARD". ***Measured, the
firewall's own live store,
HKLM\\SYSTEM\\CurrentControlSet\\Services\\SharedAccess\\Parameters\\FirewallPolicy:***
the three subkeys are DomainProfile, StandardProfile and PublicProfile.
StandardProfile IS Private -- one profile, two names.

So "Domain and Standard", which FT-258 wired, already covered Domain AND
Private. The only profile missing was PUBLIC. Saying "Private and Public are
not wired" counted Private twice and was simply wrong.

WHY NO ADMX DECLARES THE PUBLIC PROFILE. ***Measured: the string
"PublicProfile" appears in NO .admx file on this machine***, and the two
policies that ARE declared carry
`<supportedOn ref="windows:SUPPORTED_WindowsXPSP2" />`. That template is the
Windows XP SP2-era firewall, and XP had exactly two profiles -- Domain, and
Standard meaning "not on a domain". The Private/Public split arrived with
Vista, and modern firewall policy is configured through the Windows Firewall
with Advanced Security snap-in rather than that ADMX. So the ADMX is not a
complete list of the policy paths, and I treated it as one.

That is the lesson worth keeping: THE SOURCE I VERIFIED AGAINST WAS REAL BUT
NOT COMPLETE, and I reported its silence as evidence of absence. Checking a
second source -- the firewall's own live store -- settled it in one command.

WHAT THIS ADDS. PublicProfile, same key shape, same value name. Basis is
stated honestly in the comment: the live firewall store on this machine uses
exactly that name alongside the two the ADMX declares, and the policy branch
mirrors the local branch. It is NOT declared in any ADMX here, and the comment
says so rather than implying a verification that was not made.

AND PUBLIC IS THE ONE THAT MATTERS MOST TO THE CUSTOMER. It is the profile
that applies on untrusted networks -- hotel and coffee-shop wifi -- which is
exactly where a laptop needs its firewall and exactly the profile a "speed up
my wifi" tweak is most likely to have switched off.

The failure mode if this path were still wrong is benign and one-directional:
the read finds nothing and the helper reports nothing. It can never invent a
finding.

Run from Tool2/:  python build_ascii44_ft258b_publicprofile.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

OLD_BLOCK = (
    '                7 {\n'
    '                    $ggLock = Get-GGPolicyLock @(\n'
    '                        @{ Path = "HKLM:\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile";            Name = "EnableFirewall";            OffWhen = 0 },\n'
    '                        @{ Path = "HKLM:\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\StandardProfile";          Name = "EnableFirewall";            OffWhen = 0 })\n'
    '                }\n'
)

NEW_BLOCK = (
    '                7 {\n'
    '                    # THREE profiles, not two, and one of them wears an old\n'
    '                    # name. Measured 2026-09-07: Get-NetFirewallProfile\n'
    '                    # returns Domain, Private and Public, while the\n'
    '                    # firewall\'s own registry calls Private "Standard" --\n'
    '                    # the name it had on Windows XP, which had only two\n'
    '                    # profiles. StandardProfile IS Private.\n'
    '                    # Domain and Standard are declared in Windows\' own\n'
    '                    # WindowsFirewall.admx. PUBLIC IS NOT IN ANY ADMX ON\n'
    '                    # THIS MACHINE -- that template is the XP-era one and\n'
    '                    # predates the Private/Public split. Public is included\n'
    '                    # on the basis of the firewall\'s live store, which uses\n'
    '                    # exactly this name and value beside the other two.\n'
    '                    # Public matters most to our customer: it is the profile\n'
    '                    # that applies on hotel and coffee-shop wifi.\n'
    '                    $ggLock = Get-GGPolicyLock @(\n'
    '                        @{ Path = "HKLM:\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\DomainProfile";            Name = "EnableFirewall";            OffWhen = 0 },\n'
    '                        @{ Path = "HKLM:\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\StandardProfile";          Name = "EnableFirewall";            OffWhen = 0 },\n'
    '                        @{ Path = "HKLM:\\SOFTWARE\\Policies\\Microsoft\\WindowsFirewall\\PublicProfile";            Name = "EnableFirewall";            OffWhen = 0 })\n'
    '                }\n'
)

with PS1Edit(TARGET) as e:
    e.replace(
        OLD_BLOCK, NEW_BLOCK, count=1,
        why="FT-258b: add the Public firewall profile; Standard was already Private",
    )
