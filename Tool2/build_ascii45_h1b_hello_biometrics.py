"""build_ascii45_h1b_hello_biometrics -- FT-286 follow-up: face and
fingerprint sign-ins count as Windows Hello too.

Dated: 2026-09-27 09:46 ET
Editor: Claude Code (CGDELL)

Research 2026-09-27, SOURCED: Microsoft Learn lists three Windows Hello
credential provider IDs -- PIN {D6886603-...}, fingerprint {BEC09223-...},
facial recognition {8AF662BF-...}
(learn.microsoft.com/windows/security/identity-protection/hello-for-business/multifactor-unlock).
Get-GGHelloSignIn matched only the PIN's, so a face or fingerprint user was
never GOOD (safe direction, but wrong). Biometrics need a PIN behind them
(same doc), so any of the three means Hello is set up.

Run from Tool2/:  python build_ascii45_h1b_hello_biometrics.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "    $ggHelloProvider = \"{D6886603-9D2F-4EB2-B667-1971041FA96B}\"\n",
        "    # Sourced 2026-09-27, Microsoft Learn (Windows Hello multifactor unlock):\n"
        "    # PIN, fingerprint and facial recognition each have their own provider ID.\n"
        "    # Biometrics require a PIN, so any of the three means Hello is set up.\n"
        "    $ggHelloProviders = @(\n"
        "        \"{D6886603-9D2F-4EB2-B667-1971041FA96B}\",   # PIN (also measured, CGDELL)\n"
        "        \"{BEC09223-B018-416D-A0AC-523971B639F5}\",   # fingerprint\n"
        "        \"{8AF662BF-65A0-4D0A-A540-A338A999D36F}\"    # facial recognition\n"
        "    )\n",
        count=1, why="three Hello providers")
    e.replace(
        "        if ($ggPrv -eq $ggHelloProvider) {\n",
        "        if ($ggHelloProviders -contains $ggPrv.ToUpper()) {\n",
        count=1, why="match any of the three")
    e.replace(
        "#           otherwise the person is asked. Never a guessed GOOD.\n",
        "#           otherwise the person is asked. Never a guessed GOOD.\n"
        "#           Face and fingerprint sign-ins count too (their own provider IDs,\n"
        "#           sourced Microsoft Learn 2026-09-27).\n",
        count=1, why="change log")
