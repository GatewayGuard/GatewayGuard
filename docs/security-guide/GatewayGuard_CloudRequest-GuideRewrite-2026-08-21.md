<!-- Dated: 2026-08-21 13:05 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Cloud Request -- Guide rewrite from v9 (on the critical path)

> **READ ORDER: 2 of 3.** Read after
> `GatewayGuard_CloudRequest-Review-2026-08-21.md` (1 of 3), before
> `GatewayGuard_CloudRequest-PricingCopy-2026-08-21.md` (3 of 3). This is the
> launch-critical one -- FT-220 blocks the tool build -- so do not skip it.

- **Document Name:** GatewayGuard_CloudRequest-GuideRewrite
- **For:** Claude Cloud
- **From:** Claude Code (CGDELL), 2026-08-21
- **How to use:** Bill syncs, then tells Cloud to read this file. No paste.
- **Why it is urgent:** the tool build (ascii43/44) waits on this for FT-220.

---

Before anything else, open ProjectDocs/CURRENT.md and read back the four
values at the top: Generated, Commit at generation, That commit was made,
and Its subject line. If they do not match what Claude Code last pushed,
say so and stop -- your snapshot is stale.

CORRECTION FROM CLAUDE CODE, 2026-08-21: this file first asked you to
"rewrite the guide from v9." That was wrong -- you ALREADY DID that rewrite.
It is `ProjectDocs/GatewayGuard_GuideRewrite-Draft-2026-08-19-1753.md`,
1,553 lines, and it already covers all four settings below, several with a
"Why this matters" paragraph. Claude Code missed that it existed. Do not
redo it.

TASK, REVISED: VERIFY and, where thin, STRENGTHEN the four FT-220 settings
in the existing draft. This is on the critical path for the next tool build.

Work from `GatewayGuard_GuideRewrite-Draft-2026-08-19-1753.md` (the draft),
checking it against `GatewayGuard_GuideV9-SourcePack-2026-08-15-1436.md`
(the source) only where the draft looks incomplete. Do not work from memory.

WHY THIS IS THE BLOCKING ITEM. The tool has four settings that tell the
user WHAT will change but never WHY their current state is bad. Claude Code
logged that as FT-220 in
`GatewayGuard_FieldTestTriage-ascii42run1-2026-08-21.md`. The rule here is
that the guide settles substance and the screens follow it, so the tool
cannot write those explanations until the guide says them. The draft
mostly does -- this task is to confirm each of the four is complete, not to
start over.

THE FOUR THAT ARE BLOCKING. For each, the guide must answer plainly, for
a non-technical American senior:

  Setting 9  -- Windows Hello / PIN.
     What it is. Why a PIN is safer than a password, not less safe --
     this is counter-intuitive and seniors ask about it. Why a Microsoft
     account gets involved at all, and what is actually worse if they
     stay on a local account. Say the real trade-off; do not just
     recommend.

  Setting 12 -- Diagnostic Data, Required Only.
     What Windows sends on the default setting. What stops being sent.
     Why the default is a privacy problem rather than just a preference.

  Setting 13 -- Edge Startup Boost and background processes.
     What is running when they think Edge is closed. Why that matters on
     an 8 GB machine. What they lose by turning it off -- be honest,
     Edge does open a little slower.

  Setting 17 -- it currently has NO guide page reference at all and no
     explanation anywhere. Tell me what it should say and where it goes
     in the guide.

FOR EVERY ONE, the guide must state: what the setting does, what the bad
outcome is if it stays as it is, what the user gives up by changing it,
and how they undo it later.

HOUSE RULES THAT APPLY TO EVERY WORD YOU WRITE:

  - Never use "whether" or "whereas". Use "if".
  - Never use "switch" as a verb for a setting. It is "turn on" and
    "turn off", because that is what Windows says and what the tool
    says. The noun -- the switch you click -- is fine.
  - First mention is "GatewayGuard Checkup", after that just "Checkup".
    GatewayGuard is the company.
  - Every sentence describing what Checkup does to a setting must say
    the user gave permission. That is the product's central promise.
  - No jargon. Delete it, do not explain it.
  - No dead ends. If you say do something, say how, and say what to do
    when that route is not available.
  - Every step states the desired state AND the fix: not "look at the
    setting" but "it should say On. If it does not, turn it on."
  - No unverified superlatives -- most, only, everyone, no one else --
    unless you name a source. For seniors at home the right sources are
    FBI IC3 and FTC, not enterprise breach reports.
  - "Open-source" is BANNED for GatewayGuard. The repository is private.
    Say source-visible, fully auditable, or transparent plaintext code.
    Naming a third party's licence correctly is fine.

DELIVER AS MARKDOWN, in one file, so I can hand it straight to Claude
Code to commit. You cannot write to the repository yourself. If any
decision ends up only in this chat and not in the file, say so
explicitly.

If you need to know what a screen currently says before you write the
guide text for it, ask me and I will get it from Claude Code. Do not
guess at the tool's wording -- the guide and the screens have to agree,
and that is the whole reason this is blocking.

