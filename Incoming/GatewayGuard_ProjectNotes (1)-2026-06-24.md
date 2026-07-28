# GatewayGuard Project Notes
**Last Updated:** June 23, 2026
**Current Build:** ascii20
**Test Machine:** HP Laptop 17-by1xxx (SANDY)

---

## CURRENT BUILD STATUS

| Build | Lines | Status |
|-------|-------|--------|
| ascii13 | 2,436 | Archive |
| ascii14 | 2,530 | Archive |
| ascii15 | 2,675 | Archive |
| ascii16 | 2,873 | Archive |
| ascii17 | 2,938 | Archive |
| ascii18 | 3,114 | Archive |
| ascii19 | 3,310 | Archive |
| ascii20 | 3,339 | **CURRENT -- ready to test** |

---

## TESTED HARDWARE REGISTRY

### #1 -- HP Laptop 17-by1xxx (SANDY)
- **OS:** Windows 11 Home (EditionID: Core, Build 26200)
- **CPU:** Intel Core i5-8265U @ 1.60GHz
- **RAM:** 7.9 GB
- **Storage:** 238GB SSD (primary) + 932GB HDD + 7.5GB recovery partition
- **Battery:** Yes -- laptop, BatteryStatus 2 = AC connected
- **AV:** Malwarebytes Free (productState=0x061000) + Windows Defender
- **Key finding:** MB Free sets 0x1000 productState bit even as companion -- fixed in ascii20
- **First tested:** ascii13
- **Latest test:** ascii20 (pending)

### #2 -- Lenovo IdeaPad (William's daily driver)
- **OS:** Windows 11 Home
- **Battery:** Yes -- laptop
- **Notes:** Used for development only, not full test runs
- **Status:** Not formally tested

---

## PENDING TEST ITEMS (ascii20)
When you get back to the HP, watch for:
1. Malwarebytes detected correctly as FreeCompanion (not TrialActive)
2. Defender shown as ON and primary
3. Tamper Protection reading correctly from registry
4. Battery % showing on AC power screen
5. Edition showing "Core -- Windows 11 Home"
6. Convenience feature review working one at a time at end
7. Screen timeout showing "Found: X min"
8. Box text not cut off on any screen
9. Useless pauses gone after Y confirmations

---

## KNOWN BUGS / FIXED IN ascii20
- [FIXED ascii20] MB Free productState 0x1000 bit unreliable -- now uses Get-MpComputerStatus directly
- [FIXED ascii19] Tamper Protection unreadable when MB present -- now reads registry directly
- [FIXED ascii19] Draw-Box colors -- all white/black now, color only for status
- [FIXED ascii19] Screen timeout said "active" -- now says "Found: X min"
- [FIXED ascii19] Edition showed "Core" only -- now "Core -- Windows 11 Home"
- [FIXED ascii19] Useless pauses after Y confirmations -- removed
- [FIXED ascii18] Battery said "no battery risk" on laptop -- now shows laptop vs desktop
- [FIXED ascii18] httpUsbBridge / Brother flagged as suspicious -- added to TrustedPublishers

---

## FUTURE FEATURES / IDEAS TO BUILD

### High Priority
- [ ] Pull system info at startup and display hardware profile to user
  - Make/Model, CPU, RAM, Storage type, Battery Y/N, Edition
  - Compare against tested hardware registry
  - Flag "Untested hardware" if not on list

### Beta Tester Program
- [ ] Build beta tester signup on gatewayguard.co
- [ ] Screen checklist for known problem configurations before accepting
- [ ] Remote session process: screen share only + text back and forth
- [ ] After session: log hardware profile to tested registry
- [ ] Offer: free hardening session in exchange for being a test subject
- [ ] Build "Untested hardware" warning screen in tool that offers beta program

### Tested Hardware Registry (in-tool)
- [ ] Decide: separate document vs built into tool
- [ ] If built-in: show "Tested on your hardware" vs "Untested -- beta"
- [ ] Track: Make/Model, OS edition, known quirks, first/last build tested

### Windows 11 Pro Support
- [ ] Test on Pro edition machine
- [ ] Verify Group Policy settings work correctly
- [ ] Remote Desktop section currently N/A on Home -- enable for Pro
- [ ] Verify BitLocker full encryption (Pro) vs Device Encryption (Home)

### Other Editions
- [ ] Windows 11 Education
- [ ] Windows 11 Enterprise
- [ ] Note: currently only Home confirmed tested

### Tool Improvements
- [ ] Add Pro edition wording throughout (currently Home focused)
- [ ] Consider GUI improvements based on test feedback
- [ ] Scheduled scan verification screen -- confirm tasks were created

---

## PROJECT SETUP
- **Files location:** OneDrive -> GatewayGuard folder
- **Launcher:** Run-GatewayGuard.bat (always same folder as .ps1)
- **Log:** Saved to Desktop after each run
- **Claude Project:** GatewayGuard (this project)
- **Website:** gatewayguard.co

---

## SESSION NOTES -- June 23, 2026
- William's keyboard broke on broken PC (IdeaPad)
- Used on-screen keyboard to get back in
- Recovered full project via Untitled.txt export from broken PC browser
- Moved to wife's PC for this session (logged into same Claude account)
- Files synced to OneDrive
- HP system info collected -- revealed MB detection bug
- Built ascii18, ascii19, ascii20 in this session
