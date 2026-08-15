<!-- Dated: 2026-08-15 14:40 ET -->
<!-- Editor: Claude Code (CGDELL) -->
# Masters -- the binary originals, deliberately OUT of Claude Cloud's scope

**Do not move anything in here back into `ProjectDocs\`.**

## What this folder is

The `.docx` and `.pptx` **master copies** of project documents. They are
tracked in git, versioned normally, and fully recoverable. They are simply not
in the folder the GitHub connector syncs into Claude Cloud's project knowledge.

## Why they are not in ProjectDocs

**Claude Cloud cannot read a `.docx`, `.pdf` or `.pptx`. At all.**

**measured 2026-08-13, a controlled result:** `GatewayGuard_MarketResearch.docx`
and `GatewayGuard_MarketResearch.md` sat in the same folder, the same connector
scope and the same commit. **Only the `.md` ever surfaced** -- across roughly a
dozen searches Cloud never once returned a `.docx` path.

So a binary in `ProjectDocs\` is the worst of both worlds: it **spends
connector capacity** and **returns nothing**. On 2026-08-14 project knowledge
hit **390% of capacity**, and 21 of `ProjectDocs`' 24 MB was files Cloud could
not read. The guide `.docx` was committed, pushed and completely invisible for
**sixteen days** on exactly this basis.

**Moved here 2026-08-15**, 19 masters. `ProjectDocs\` tracked content went from
**2,168 KB to 1,641 KB**, and there is now **no binary in connector scope at
all**.

## The rule

> **A file Cloud cannot read does not belong in a folder Cloud syncs.**
> Keep it in the repository. Keep it out of scope.

## How the readable copies are produced

Every master here has a readable `.md` in `ProjectDocs\`, and **that is the
copy Cloud reads and rewrites from.** Three generators keep them in step:

| Generator | Covers |
|---|---|
| `Tool\build_readable_twins.py` | sweeps **this folder**, writes `*-TEXT.md` into `ProjectDocs\` |
| `Tool\build_guide_sourcepack.py` | `windows_security_walkthrough_guide_v9.docx` -> `GatewayGuard_GuideV9-SourcePack-*.md` |
| `Tool\build_marketing_sourcepack.py` | the marketing masters in `Marketing\` |

**Run them after editing any master here.** A master changed without its twin
regenerated is a document Cloud is reading an old version of, with nothing on
screen to say so.

**Checked 2026-08-15: all 19 masters have readable coverage. Zero orphans.**
That check is worth repeating after any change, and it is one line:

```
for each file in Masters\ -- is there a matching .md or -TEXT.md in ProjectDocs\?
```

## The one file here that is not what it claims

`GatewayGuard_CommunityFlyer.docx` **is not a Word document.** measured
2026-08-15: its first bytes are `**IS YOUR HOME C`, not a ZIP signature. It is
2,238 bytes of plain Markdown with the wrong extension, which is why every
binary-aware tool in this repository skipped it and why the extractor dies on
it with `BadZipFile`.

**That mislabelling is the entire reason Cloud never read the flyer.** Its twin
is written directly at `ProjectDocs\GatewayGuard_CommunityFlyer.md`.
**Renaming the master to `.md` and retiring the `.docx` is the right fix** --
nothing in it needs Word.

## Other folders already outside scope

`Guide\`, `Marketing\`, `Presentation\`, `Certificates\`, `MB\`, `Notes\`,
`Builds\`, `Test_Results\`. Same reasoning applies to all of them.
