# GatewayGuard — Environment Hardening Plan
**Created:** 30-Jun-2026
**Status:** Planning — not yet implemented
**Scope:** Development machines, test fleet, website infrastructure, and tool code integrity
**Owner:** William F. Burns III
**Entity:** GatewayGuard LLC — Maine LLC filed via Form MLLC-6, FedExed, fee paid. Noncommercial Registered Agent at Brunswick ME address. EIN and business bank account still pending.

---

## SCOPE DEFINITION

Four distinct environments require hardening:

1. **Dev machine** — Lenovo IdeaPad (primary build environment)
2. **Test fleet** — HP SANDY (Win 11 Home), Dell Latitude 5430 (Win 11 Pro)
3. **Website** — gatewayguard.co (static HTML, hosting TBD)
4. **Tool code integrity** — the GatewayGuard .ps1 and .bat files themselves

---

## GUIDING PRINCIPLE

Nothing is impenetrable. The goal is:
- **Raise the cost of attack** above the value of the target
- **Minimize attack surface** by design, not by bolt-on
- **Detect and recover fast** when something gets through
- **Build user trust** by demonstrating GatewayGuard LLC practices what it preaches

---

## 1. DEVELOPMENT MACHINE (IdeaPad)

### Current State
- Windows 11 Home
- Defender primary, Malwarebytes companion (RT off)
- USB keyboard workaround (built-in broken)
- OneDrive sync active for all project files
- Known hardware faults (keyboard/E-key)

### Hardening Actions

| Priority | Action | Notes |
|----------|--------|-------|
| High | Run GatewayGuard against itself — apply all recommended settings to IdeaPad | Practice what we preach |
| High | Enable BitLocker / Device Encryption on OS drive | Protects source code if machine is lost or stolen |
| High | Verify OneDrive versioning is on | Ransomware recovery — restore previous file versions |
| High | Enable Windows Hello PIN or biometric login | Remove password-on-wake gap |
| Medium | Code-signing certificate for .ps1 and .bat | See Section 4 |
| Medium | Dedicated GatewayGuard build account (separate Windows user) | Isolates dev environment from personal browsing |
| Medium | VS Code workspace trust settings reviewed | Prevent malicious extensions from touching project files |
| Low | Hardware replacement plan for IdeaPad | Single point of failure — USB keyboard is a workaround, not a fix |

---

## 2. TEST FLEET (SANDY + Dell Latitude 5430)

### Current State
- SANDY: Win 11 Home, MB Free + Defender, Wi-Fi stabilized
- Dell: Win 11 Pro, OOBE in progress as of 30-Jun-2026 — on "Just a moment" screen, dots spinning, no intervention needed

### Hardening Actions

| Priority | Action | Notes |
|----------|--------|-------|
| High | Run GatewayGuard on both machines after ascii23 is final | Dogfood the product |
| High | Dell: local account only, no Microsoft account sync | Test machine — keep clean and isolated |
| High | Dell: BitLocker full encryption (Pro feature) | Different from Home Device Encryption — verify via Get-BitLockerVolume |
| High | Dell: Hyper-V enabled for VM testing | Allows Win 11 Pro VM snapshots — revert to clean state between test runs |
| Medium | SANDY: verify DNS over HTTPS is stable after June 26 fix | Already applied — confirm no regression |
| Medium | Both machines: separate user accounts for GatewayGuard test runs vs personal use | Prevents personal browser state from affecting test results |
| Medium | Snapshot/image both machines after clean baseline setup | Use Hyper-V on Dell; Macrium Reflect Free on SANDY |
| Low | Network segmentation — consider dedicated VLAN or guest network for test machines | Limits blast radius if test run triggers something unexpected |

---

## 3. WEBSITE (gatewayguard.co)

### Current State
- Domain secured, DNS not yet configured
- Site: 0% built as of 30-Jun-2026
- Hosting: TBD (GitHub Pages recommended in WebsitePrePlan.md)

### Architecture Decision — Security by Design

**GitHub Pages (static HTML) is the correct choice for security**, not just cost:
- No database = no SQL injection surface
- No server-side code = no remote code execution risk
- No login system = no credential theft vector
- No payment processing on-site = no PCI scope
- GitHub's infrastructure handles DDoS mitigation, SSL, and uptime

### Hardening Actions

| Priority | Action | Notes |
|----------|--------|-------|
| High | HTTPS only — enforce via GitHub Pages settings | Free via Let's Encrypt, automatic with GitHub Pages custom domain |
| High | HSTS header enabled | Forces browsers to only connect via HTTPS, even if user types http:// |
| High | Content Security Policy (CSP) header | Blocks inline scripts and unauthorized external resources |
| High | No third-party scripts | No Google Analytics, no Facebook pixel, no CDN-hosted JS unless absolutely necessary — each one is an attack surface |
| High | Payment processing via established third party only | Stripe or equivalent — never handle card data directly |
| High | Beta tester form: use established form service | Netlify Forms, Formspree, or similar — never roll your own form handler |
| Medium | X-Frame-Options header | Prevents clickjacking |
| Medium | Referrer-Policy header | Limits information leakage in referrer headers |
| Medium | Subresource Integrity (SRI) on any CDN assets | Ensures CDN-delivered files haven't been tampered with |
| Medium | Regular link-rot and content integrity checks | Automated or manual monthly check that download links still serve the correct files |
| Low | robots.txt configured | Limit what crawlers index — especially the download directory |
| Low | Security.txt file at /.well-known/security.txt | Published responsible disclosure contact — standard practice, builds trust |

### Download File Integrity
- Publish SHA-256 hash of each released .ps1 and .bat file on the download page
- Users can verify the downloaded file matches the published hash
- Regenerate and republish hash with every new build release

---

## 4. TOOL CODE INTEGRITY (.ps1 AND .bat FILES)

### The Encryption Reality
PowerShell cannot be truly encrypted in a way that survives execution. The runtime must read the plaintext to run it — any "encrypted" PS1 is trivially reversible by anyone motivated enough. **Obfuscation is not security.**

### What Actually Works: Code Signing

**Code signing with a trusted certificate:**
- Proves the script came from GatewayGuard LLC and has not been modified since signing
- Windows displays publisher name in the UAC prompt instead of "Unknown Publisher"
- PowerShell execution policy can be set to require valid signatures
- Users can verify the signature themselves

**Options:**
| Option | Cost | Trust Level | Notes |
|--------|------|-------------|-------|
| Self-signed certificate | Free | Low — triggers warnings | Acceptable for beta, not for launch |
| Sectigo / DigiCert Code Signing | ~$200-400/yr | High — trusted by Windows | Correct choice for commercial launch |
| Microsoft Trusted Root program | Free but complex | Highest | Not practical for a solo vendor at launch stage |

**Recommendation:** Budget for a commercial code-signing certificate from Sectigo or DigiCert before 1-Sep-2026 launch. This is a launch prerequisite, not a nice-to-have — "Unknown Publisher" on the UAC prompt will crater user trust for a security tool specifically.

### Additional Code Integrity Measures

| Action | Notes |
|--------|-------|
| SHA-256 hash published on website for every build | Users can verify download integrity independently |
| Build numbering never reused (ascii convention) | Already enforced per CodingStandards.md |
| Source stored in OneDrive with versioning | Recovery path if source is corrupted or ransomed |
| Consider private GitHub repo for source control | Git history + offsite backup + branch protection |

---

## 5. OPEN QUESTIONS (to resolve before launch)

1. **EIN** — LLC is filed; EIN application still needed (IRS.gov, free, ~5 minutes online).
2. **Business bank account** — open in GatewayGuard LLC name after EIN is in hand.
3. **Domain transfer to LLC** — gatewayguard.co currently registered personally; transfer to LLC name before launch per checklist.
4. **Code-signing certificate vendor and cost** — needs to be budgeted and purchased. Lead time on identity verification can be 1-5 business days.
5. **Website form handler** — Netlify Forms vs Formspree vs other for beta tester signup. Decision needed before beta.html is built.
6. **Analytics** — WebsitePrePlan.md says "optional basic analytics." If used, must be privacy-respecting (Plausible, Fathom, or none). No Google Analytics — contradicts the no-tracking-pixel commitment on the home page spec.
7. **Incident response plan** — what happens if a build is found to contain a bug that harms a user's system? Need a defined process before public launch.
8. **Annual Updates pricing** — still TBD; must be locked before T15 (launch prep) as it appears in marketing materials.
9. **GitHub repo** — private source repo separate from any public-facing assets. Worth setting up now before the codebase grows further.

---

## 6. SEQUENCING RELATIVE TO CPM SCHEDULE

These hardening tasks do not all need to be complete before 1-Sep-2026 launch, but the following are **launch prerequisites:**

| Task | Must complete by |
|------|-----------------|
| EIN obtained from IRS | Immediately — prerequisite for bank account |
| Business bank account opened (GatewayGuard LLC) | Before T15 (launch prep) |
| Domain gatewayguard.co transferred to LLC name | Before T15 (launch prep) |
| Code-signing certificate obtained and applied to ascii23+ builds | Before T15 (launch prep) — order early, 1-5 day verification lead time |
| HTTPS + HSTS + CSP on gatewayguard.co | Before T12 (website QA) |
| SHA-256 hashes published on download page | Before T16 (launch) |
| Dev machine (IdeaPad) BitLocker / Device Encryption enabled | Before T4 (ascii23 build) |
| Dell baseline snapshot via Hyper-V | Before T3 (first ascii22 test run on Dell) |
| Annual Updates pricing locked | Before T15 (launch prep) |

All other items are post-launch hardening, prioritized by risk.

---

*This document is a living plan. Update as decisions are made on code signing vendor, hosting, and form handler.*
