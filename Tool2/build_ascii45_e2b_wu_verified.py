"""build_ascii45_e2b_wu_verified -- E2: the Windows Update download and
install calls are now measured; their comments say so.

Dated: 2026-09-27 10:31 ET
Editor: Claude Code (CGDELL)

Bill, 2026-09-27: "ok run your windows install test on cgdell".
MEASURED 10:22-10:31, elevated, Tool2\Measure-WUInstall-2026-09-27.ps1 ->
Test_Results\WUInstall-CGDELL-2026-09-27_10-22.txt:
  search 2 updates (MSRT KB890830, Defender definitions KB2267602);
  UpdateColl.Count 2; Download ResultCode 2 in 2.9 s; Install ResultCode 2,
  RebootRequired False, 453.9 s; both per-update results 2; search again 0.
Comments only. The restart path stays sourced (no restart was needed).

Run from Tool2/:  python build_ascii45_e2b_wu_verified.py
"""
from gg_edit import PS1Edit

TARGET = r"..\Tool\W11-SecurityHardening-v3-ascii45-2026-09-26-1059.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        "#           loop across restarts (FT-252 -- DOWNLOAD/INSTALL NOT YET\n"
        "#           MEASURED); E3 unwanted-app blocking (FT-248); E4 virus\n",
        "#           loop across restarts (FT-252 -- download/install measured on\n"
        "#           CGDELL 2026-09-27); E3 unwanted-app blocking (FT-248); E4 virus\n",
        count=1, why="change log: E2 measured")
    e.replace(
        "    #   Download and install -- NOT YET MEASURED. They install real updates, so\n"
        "    #   they need Bill's approval to run on CGDELL. Do not ship until they are.\n",
        "    #   Download and install -- VERIFIED measured on CGDELL (below), with Bill's\n"
        "    #   approval. Install took 454 s with no output: the \"may look still\"\n"
        "    #   wording on screen 91 is needed.\n"
        "    #   Restart -- sourced only (no restart was needed in the measurement).\n",
        count=1, why="E2 status block")
    e.replace(
        "            # NOT YET MEASURED (see VERIFY STATUS above): UpdateColl, Download, Install.\n",
        "            # VERIFIED 2026-09-27 measured on CGDELL, elevated: UpdateColl.Add x2,\n"
        "            # CreateUpdateDownloader().Download() -> ResultCode 2 (2.9 s),\n"
        "            # CreateUpdateInstaller().Install() -> ResultCode 2, RebootRequired False\n"
        "            # (453.9 s), GetUpdateResult(i) -> 2 for both; search afterwards: 0 left.\n"
        "            # Test_Results\\WUInstall-CGDELL-2026-09-27_10-22.txt\n",
        count=1, why="E2 install: VERIFIED")
