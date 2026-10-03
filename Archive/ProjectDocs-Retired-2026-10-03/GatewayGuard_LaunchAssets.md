# GatewayGuard Launch Assets
**Created:** 28-Jun-2026
**Contents:** Reddit/forum introductory pitch + Local community flyer outline

---

## ASSET 1: REDDIT / FORUM INTRODUCTORY PITCH

### Target subreddits (post in this order, space out by several days each)
1. r/Windows11 (largest, most mainstream)
2. r/privacy (GDPR/zero-data angle resonates)
3. r/techsupport (Family IT Heroes hang out here)
4. r/sysadmin ("home lab" / personal use angle)
5. r/pcmasterrace (enthusiasts who audit code)

### Post Title Options (pick based on subreddit)
- "I got tired of cleaning up after Windows 11's default security settings, so I built a free tool that fixes it -- looking for people to audit the script"
- "Built a free, open PowerShell script that checks and fixes 20+ Windows 11 security settings -- explains everything in plain English. Would love feedback."
- "Free Windows 11 security checker -- explains what it found, why it matters, asks permission before changing anything. Source code included."

---

### FULL POST DRAFT

**Title:** I built a free, open Windows 11 security tool that explains everything before it changes anything -- looking for people to audit it

Hey everyone,

I've spent the last few months building something I wished existed:
a free tool that checks your Windows 11 security settings, tells you
in plain English what it found and why it matters, and asks your
permission before changing anything.

**Why I built this:**

Windows 11 has solid security features built in -- Defender, BitLocker,
SmartScreen, Tamper Protection, and more. The problem is some of them
aren't turned on by default, and most people (myself included, before
I went down this rabbit hole) have no idea which ones matter or how
to check.

I looked at what's out there already:
- Enterprise tools (Defender for Endpoint, CIS-CAT) -- built for IT
  departments, not home users
- Privacy/debloat tools (ShutUp10++, Win11Debloat) -- good for telemetry
  and bloatware, but don't touch real security settings
- NoID Privacy (~$43) -- applies 630+ changes automatically with no
  explanation of what each one does

None of them explain anything in plain language or let you decide
item by item. So I built one.

**What it does:**

- Checks 20+ Windows 11 settings (Defender config, Firewall, BitLocker,
  SmartScreen, Phishing Protection, privacy settings, and more)
- For each one: states what it found, explains why it matters in plain
  English, and asks Y/N before changing anything
- Every change is reversible
- Runs completely offline -- collects zero data, no account, no telemetry
- It's a PowerShell script (.ps1), not a compiled .exe -- you can open
  it in Notepad and read every single line before running it

**What I'm asking from this community:**

I'd genuinely love for people here to look at the script and tell me
what I got wrong, what's missing, or what could be done better.
I'm not a security professional by trade -- I've researched this
deeply but I know this community will catch things I missed.

Link to the script and a short writeup of every setting it touches:
[gatewayguard.co/source]

If you run it and it's useful, great. If you find something I should
fix, even better -- that's exactly what I'm hoping for.

Thanks for reading this far.

---

### POST GUIDELINES (read before posting)
- Post during weekday mornings (US Eastern) for best visibility
- Respond to EVERY comment within the first few hours -- this is critical
- If someone finds an issue, thank them publicly and fix it visibly
- Never argue with critics -- ask clarifying questions instead
- Do not mention pricing or the paid tiers in this post -- free/audit only
- If asked about business model, answer honestly: "Currently free.
  Planning a paid tier later for untested hardware support and
  assisted setup sessions, but the core tool will always be free
  for tested/listed hardware."
- Update the post with an edit if significant bugs are found and fixed:
  "EDIT: Thanks to feedback from u/username, fixed [issue] in the
  latest version. Updated link above."

### FOLLOW-UP COMMENT TEMPLATES

**If someone asks "is this safe / not malware":**
"Totally fair question. It's a plain-text PowerShell script -- no
compiled binary, nothing hidden. Open it in Notepad or VS Code and
you can read every line before running it. It also doesn't make any
network calls -- runs 100% offline, so there's nothing to intercept
or verify with a sandbox if you want extra peace of mind."

**If someone asks "what's the catch / how do you make money":**
"Right now it's free for any PC on the tested hardware list, which
is growing through people like you trying it on different setups.
Eventually I'll add a small one-time fee for untested hardware and
an optional paid session if someone wants hands-on help, but the
core checking/explaining tool will always be free."

**If someone finds a bug:**
"Appreciate you catching that -- can you share what PowerShell version
and Windows build you're on? Want to reproduce it before pushing a fix."

**If someone compares to NoID or another tool:**
"NoID's a solid tool for people comfortable with 600+ automated changes.
This is aimed more at people who want to understand each setting as
they go rather than trust a black box of changes. Different audiences,
both valid approaches."

---

## ASSET 2: LOCAL COMMUNITY "DIGITAL SAFETY" FLYER OUTLINE

**Format:** Single page, front only, printable on standard 8.5x11"
**Purpose:** Library presentations, community boards, Nextdoor posts,
            senior centers, ACB bridge clubs

---

### FLYER LAYOUT OUTLINE

**HEADER (top 20% of page):**
```
[GatewayGuard shield icon]

IS YOUR WINDOWS 11 COMPUTER
ACTUALLY SECURE?

Find out for free. No strings attached.
```

**SECTION 1 -- The Hook (next 20%):**
```
Most Windows 11 computers have powerful built-in security
features. Many people don't realize some of them aren't
turned on by default.

GatewayGuard checks your PC, tells you in plain English what
it finds, and helps you turn on what you need -- with your
permission every step of the way.
```

**SECTION 2 -- Three Quick Facts (middle 25%, use icons):**
```
[Lock icon]     FREE for most Windows 11 PCs

[Eye icon]      Explains everything in plain language --
                no tech jargon

[Shield icon]   We collect ZERO data. Nothing is sent
                anywhere. Ever.
```

**SECTION 3 -- How to Get Started (next 20%):**
```
THREE WAYS TO GET STARTED:

1. SCAN THE QR CODE below for our free guide
2. VISIT gatewayguard.co
3. NOT SURE WHERE TO START? We offer free help sessions --
   we'll walk you through it together, step by step.
   Email: support@gatewayguard.co
```

**SECTION 4 -- QR Code and Footer (bottom 15%):**
```
[QR code linking to gatewayguard.co/guide]

GatewayGuard LLC | Brunswick, Maine | gatewayguard.co

"Stop paying for something you already own.
We'll set it up and secure it correctly."
```

---

### DESIGN NOTES
- Navy blue and white color scheme (matches brand)
- Large, readable font -- minimum 14pt body text (older audience)
- QR code minimum 1.5" x 1.5" for easy phone scanning
- Leave white space -- avoid a cluttered look
- Print on card stock if used for library/event handouts
- Consider a tear-off tab at the bottom with the URL for bulletin boards

### DISTRIBUTION CHECKLIST
- [ ] Curtis Memorial Library community board
- [ ] Brunswick senior center
- [ ] ACB Maine chapter bulletin board (if exists)
- [ ] Local Facebook community groups (digital version)
- [ ] Nextdoor neighborhood posts (digital version)
- [ ] Leave-behinds after any library/community presentation
- [ ] Local coffee shop community boards
- [ ] Bridge club locations (with permission)

### TWO VERSIONS NEEDED
1. **Print version** -- PDF, designed for physical handout/posting
2. **Digital version** -- same content reformatted as a single image
   for Facebook/Nextdoor posts (square or vertical format)

---

## NEXT STEPS
- [ ] Finalize Reddit post copy and choose first subreddit (recommend r/Windows11)
- [ ] Set gatewayguard.co/source page live before posting (GitHub or hosted)
- [ ] Design flyer in Canva or similar (free tier available)
- [ ] Generate QR code linking to gatewayguard.co/guide
- [ ] Print test flyer to check readability before mass printing
- [ ] Schedule first Reddit post for a weekday morning
