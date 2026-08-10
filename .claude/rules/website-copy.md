---
description: Website and guide copy must match the written guide, in the guide's own words. Pointer only -- the rule itself lives in WebSite/Rules/website-copy.md
paths:
  - "WebSite/**"
  - "**/*.html"
  - "ProjectDocs/**guide**"
  - "ProjectDocs/**Website**"
---

# Website Copy Rule -- POINTER ONLY

**The rule itself is in `WebSite\Rules\website-copy.md`. Read that file.**

This stub exists only to keep the path trigger working. It is not the rule and
must never be allowed to grow into a second copy of it.

## Why the rule moved (2026-08-09)

`.claude` is a dot-folder. Dot-folders are routinely filtered out of file
pickers as hidden, so the rule may not have been selectable when connecting
Claude Cloud to the repository -- and a rule Cloud cannot see is a rule Cloud
does not follow. `WebSite/` is in the connector scope, so the rule now lives
where both Claudes can reach it.

Claude Code still loads this stub automatically on website work, via the
`paths:` frontmatter above, which only functions from `.claude/rules/`. That is
the whole reason this file still exists.

**One copy of the rule, one pointer to it.** If you find yourself pasting rule
text into this file, stop -- that is the "state every fact exactly once"
violation this arrangement was built to avoid.

## The one line worth carrying everywhere

**The guide wins on substance, plain English wins on expression** -- and jargon
gets deleted, not explained.

Full rule: `WebSite\Rules\website-copy.md`. Also WebsiteStandards RULE W-07,
delivery gate H-4.
