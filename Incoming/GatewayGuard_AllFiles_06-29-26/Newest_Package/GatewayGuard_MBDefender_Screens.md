# GatewayGuard -- MB / Defender State Explanation Screens
**Written:** June 24, 2026  
**Based on:** SANDY test results (HP Laptop 17-by1xxx)  
**For use in:** ascii21

---

## DETECTION MATRIX

| State | WinDefend | MB | AMRunningMode | Registry | Screen |
|-------|-----------|----|---------------|----------|--------|
| 1 - Healthy | Running/Auto | FreeCompanion | Normal | 0,0 | Green GOOD |
| 2 - MB Sole AV | Stopped/Manual | Sole AV | Not running | 1,1 | Screen A |
| 3 - MB Trial | Passive | Primary AV | Passive Mode | varies | Screen B |
| 4 - No AV | Stopped | Not installed | Not running | 1,1 | Screen D |
| 5 - 3rd Party AV | Passive/Stopped | Not installed | Passive/Off | varies | Screen E |

---

## SCREEN A -- MB FREE AS SOLE AV (current SANDY state)
**Trigger:** MB in SC2 + WinDefend Stopped + DisableAntiVirus=1 + AMRunningMode="Not running"

```
+==============================================================+
|  IMPORTANT -- YOUR ANTIVIRUS SETUP NEEDS ATTENTION           |
+==============================================================+
|  WHAT WAS FOUND ON YOUR PC:                                  |
|                                                              |
|  Malwarebytes Free:   INSTALLED -- registered as your AV     |
|  Microsoft Defender:  STOPPED -- not currently running       |
|  Defender Firewall:   ON -- all 3 networks protected (OK)    |
+==============================================================+
|  WHAT THIS MEANS:                                            |
|                                                              |
|  When Malwarebytes Free installed, it registered itself      |
|  with Windows Security as your antivirus. Windows then       |
|  automatically disabled Microsoft Defender to avoid          |
|  conflicts between two AV programs running at once.          |
|                                                              |
|  Right now, Malwarebytes Free is your ONLY real-time         |
|  virus protection. Microsoft Defender is stopped.            |
|                                                              |
|  ABOUT YOUR FIREWALL:                                        |
|  Your Defender Firewall IS protecting all 3 networks         |
|  (Domain, Private, Public). This is correct. The            |
|  firewall runs as a completely separate Windows service      |
|  from the Defender antivirus engine. Stopping the AV         |
|  does NOT stop the firewall -- they are independent.         |
+==============================================================+
|  IS THIS A PROBLEM?                                          |
|                                                              |
|  Malwarebytes Free is a reputable product and is             |
|  providing real-time protection. However, the recommended    |
|  setup for Windows 11 is:                                    |
|                                                              |
|    PRIMARY:   Microsoft Defender (always-on, built-in,       |
|               free, updated by Microsoft automatically)      |
|    COMPANION: Malwarebytes Free (manual scans for PUPs       |
|               and adware Defender sometimes misses)          |
|                                                              |
|  Running both this way gives you the best of both            |
|  tools with no conflict between them.                        |
+==============================================================+
|  WHAT GATEWAYGUARD CAN DO:                                   |
|                                                              |
|  GatewayGuard can restore the recommended setup:             |
|    1. Clear the registry flags that disabled Defender        |
|    2. Set Defender service to start automatically            |
|    3. Start the Defender AV engine                           |
|    4. Malwarebytes Free stays installed as companion         |
|                                                              |
|  Y = Fix this now (recommended)                              |
|      Restores Defender as primary -- MB stays installed      |
|  N = Leave as-is                                             |
|      Continue with Malwarebytes Free as your sole AV         |
|  Q = Exit -- I want to research this before deciding         |
+==============================================================+
```

---

## SCREEN B -- MB PREMIUM TRIAL ACTIVE (State 3)
**Trigger:** MB in SC2 + MB in FirewallProduct + AMRunningMode="Passive Mode"

```
+==============================================================+
|  MALWAREBYTES PREMIUM TRIAL IS ACTIVE                        |
+==============================================================+
|  WHAT WAS FOUND ON YOUR PC:                                  |
|                                                              |
|  Malwarebytes Premium Trial:  ACTIVE -- managing your AV     |
|  Microsoft Defender AV:       PASSIVE -- standing by         |
|  Defender Firewall:           ON -- all 3 networks (OK)      |
+==============================================================+
|  WHAT THIS MEANS:                                            |
|                                                              |
|  Your Malwarebytes Premium Trial is active. During the       |
|  trial, Malwarebytes becomes your primary real-time AV       |
|  and puts Defender into passive mode (installed but          |
|  not actively scanning in real-time).                        |
|                                                              |
|  When the trial ends or you deactivate it, Defender          |
|  automatically resumes as your primary AV.                   |
|                                                              |
|  ABOUT YOUR FIREWALL:                                        |
|  Defender Firewall is still ON and protecting all 3          |
|  networks. The Premium Trial does not affect the firewall    |
|  -- it runs independently from the AV engine.               |
+==============================================================+
|  YOUR OPTIONS:                                               |
|                                                              |
|  Y = Continue -- GatewayGuard will harden other settings.   |
|      Note: Some Defender-specific checks (Tamper             |
|      Protection, Periodic Scanning) may show differently     |
|      while the trial is active. Re-run GatewayGuard          |
|      after the trial ends for a full clean check.            |
|                                                              |
|  N = Deactivate trial first, then re-run GatewayGuard        |
|      TO DEACTIVATE:                                          |
|      1. Open Malwarebytes                                    |
|      2. Click Settings (gear icon) -> Account               |
|      3. Click Deactivate Premium Trial                       |
|      4. Restart your PC                                      |
|      5. Re-run GatewayGuard for a clean full check           |
|                                                              |
|  Q = Exit -- I want to research this before deciding         |
+==============================================================+
```

---

## SCREEN C -- HEALTHY SETUP (State 1 -- goal state)
**Trigger:** Defender RT=ON + MB registered in SC2 + AMRunningMode=Normal

```
+==============================================================+
|  OK  ANTIVIRUS STATUS -- HEALTHY SETUP                       |
+==============================================================+
|  WHAT WAS FOUND ON YOUR PC:                                  |
|                                                              |
|  Microsoft Defender:  ACTIVE -- primary real-time AV         |
|  Malwarebytes Free:   INSTALLED -- manual-scan companion      |
|  Defender Firewall:   ON -- all 3 networks protected         |
+==============================================================+
|  THIS IS THE RECOMMENDED SETUP:                              |
|                                                              |
|  Defender provides always-on real-time protection and        |
|  is maintained automatically by Windows Update.             |
|                                                              |
|  Malwarebytes Free adds manual scan capability for           |
|  catching PUPs (potentially unwanted programs) and           |
|  adware that Defender sometimes misses.                      |
|                                                              |
|  ABOUT WHAT YOU SEE IN WINDOWS SECURITY:                     |
|  Both apps appear under Virus & threat protection.           |
|  Defender shows as ON -- this is correct.                    |
|  Malwarebytes shows as installed but is NOT your             |
|  primary AV shield -- it is a companion tool only.           |
|  This dual listing is normal and expected.                   |
+==============================================================+
```

---

## SCREEN D -- NO AV AT ALL (State 4)
**Trigger:** WinDefend Stopped + No MB + No 3rd party AV in SC2

```
+==============================================================+
|  !!  CRITICAL -- NO ANTIVIRUS PROTECTION DETECTED            |
+==============================================================+
|  WHAT WAS FOUND ON YOUR PC:                                  |
|                                                              |
|  Microsoft Defender:  STOPPED -- not running                 |
|  Other antivirus:     None detected                          |
|  Defender Firewall:   ON -- firewall still protecting        |
+==============================================================+
|  YOUR PC HAS NO ACTIVE ANTIVIRUS RIGHT NOW.                  |
|                                                              |
|  This means viruses, ransomware, and malware can             |
|  infect your PC without being detected or blocked.           |
|                                                              |
|  ABOUT YOUR FIREWALL:                                        |
|  Your Defender Firewall is still ON -- it blocks             |
|  unauthorized network connections. However, firewall         |
|  does NOT scan files or detect viruses. You need             |
|  BOTH firewall AND antivirus for full protection.            |
+==============================================================+
|  GATEWAYGUARD CAN FIX THIS:                                  |
|                                                              |
|  Y = Re-enable Microsoft Defender now (recommended)          |
|      Defender is free, built-in, and will be active          |
|      immediately after enabling.                             |
|  Q = Exit -- I want to install a different AV first          |
+==============================================================+
```

---

## AFTER-TRIAL CHECKLIST (run on SANDY when trial expires)
Run these commands and upload results to confirm which scenario occurred:

```powershell
Get-MpComputerStatus | Select-Object RealTimeProtectionEnabled, AntivirusEnabled, AMRunningMode
Get-Service WinDefend | Select-Object Name, Status, StartType
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows Defender" | Select-Object DisableAntiSpyware, DisableAntiVirus
Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct | Select-Object displayName, productState
```

**Expected if MB releases Defender cleanly (Scenario 1 -- ideal):**
- AMRunningMode = Normal
- WinDefend = Running / Automatic
- DisableAntiSpyware = 0, DisableAntiVirus = 0
- SC2 shows both MB and Defender, Defender primary
- GatewayGuard should show: Screen C (Healthy Setup)

**Expected if MB does NOT release Defender (Scenario 2 -- needs fix):**
- AMRunningMode = Not running
- WinDefend = Stopped / Manual
- DisableAntiSpyware = 1, DisableAntiVirus = 1
- GatewayGuard should show: Screen A (offer Option A fix)

**Expected partial release (Scenario 3):**
- AMRunningMode = Passive Mode
- WinDefend = Running but passive
- MB still in SC2 as primary
- GatewayGuard should show: Screen B variant

---

## FIREWALL NOTE (important for user education)
Defender Firewall (service: MpsSvc) and Defender AV (service: WinDefend) are TWO SEPARATE services.
- Stopping WinDefend (AV) does NOT stop MpsSvc (Firewall)
- This is why SANDY shows Firewall ON across all 3 networks even with Defender AV stopped
- GatewayGuard must explain this distinction clearly in every AV warning screen
- Users will be confused seeing "Defender Firewall ON" and assume all of Defender is working
