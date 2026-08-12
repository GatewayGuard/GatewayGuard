---
description: Website and guide copy must match the written guide, in the guide's own words, at the plain-English standard.
paths:
  - "WebSite/**"
  - "**/*.html"
  - "ProjectDocs/**guide**"
  - "ProjectDocs/**Website**"
---

# Website Copy Must Match the Written Guide

Moved out of the always-loaded `CLAUDE.md` on 2026-08-02 because it applies
only when writing website or guide pages. It loads automatically whenever a
file matching the paths above is in play, so nothing is lost — it simply
stops costing context during tool builds.

The website and the written guide are read by the same person, often side
by side. **They must say the same things in the same words.**

- Before writing any guide page, read the actual guide section for that
  setting and match its wording — not a summary of it.
- `GatewayGuard_SettingsToGuideMap.md` is an **index**, not a content
  source. It tells you which guide section covers a setting. Use it to
  find the section, then read the section.
- **The guide wins on substance. Plain English wins on expression.**
  Match the guide's facts, recommendations, terminology, setting names
  and menu paths exactly — never a different claim or a different path.
  But write the sentences to the plain-English standard, because the
  reader is a non-technical senior.
- **Remove technical jargon — don't explain it, delete it.** Leave the
  plain English version only. Glossing a hard word still leaves a hard
  word in front of the reader. Standing substitutions: *kernel* → "this
  part"; *sealed room* → "locked file location"; *hypervisor*, *VBS*,
  *virtualization* → cut entirely, describe the effect instead.
- **Keep literal on-screen labels exact** — "Memory integrity", "Core
  isolation", "Device security", "Device Manager". Those are names the
  reader must find on their own screen, not jargon. Also keep process
  names they may actually see (vmmem, vmwp).
- Load-bearing phrases stay verbatim — warnings, exact setting names,
  exact paths, and anything that changes meaning if reworded
  ("leave Off — forcing it can break boot").
- If the guide is wrong or unclear, fix the guide first, then carry it
  across — never let the two drift.
- Where the tool already says something on screen, reuse the tool's
  wording rather than writing a parallel version (the D-18 principle).
- **Exception:** a few settings have no guide coverage at all (Fast
  Startup #18, Wake on LAN #19). Original copy is correct there — flag it
  in the page header and feed it back into the guide when next revised.

Full rule: WebsiteStandards RULE W-07, enforced by delivery gate H-4.
