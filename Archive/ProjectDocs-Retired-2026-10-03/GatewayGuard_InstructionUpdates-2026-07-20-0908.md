<!-- Dated: 2026-07-20 09:08 EDT -->
# GatewayGuard Instruction Updates
- **Document Name:** GatewayGuard_InstructionUpdates
- **Last Modified:** 2026-07-20 09:08 EDT
- **Status:** Cumulative Master Document (supersedes all prior dates)
- **Change History Log:**
  - 2026-07-20: Initial file. Consolidates the new FILE NAMING &
    VERSIONING rule into ready-to-paste text for both Profile
    Instructions and Project Instructions.

---

## PURPOSE

This file contains the exact replacement text for the FILE NAMING,
FILE HEADERS, and related versioning rules in both the Profile
Instructions and Project Instructions. Copy and paste each section
into the appropriate location.

---

## PROFILE INSTRUCTIONS -- REPLACEMENT TEXT

Replace the existing FILE NAMING, FILE HEADERS, and any revision-suffix
language in the Profile Instructions with the following block:

---

FILE NAMING & VERSIONING: One unique filename per document type,
forever. The core descriptive name of a file never changes. Filename
syntax: [ProjectName]_[DocumentType]-YYYY-MM-DD-HHMM.ext (example:
GatewayGuard_CodingStandards-2026-07-20-0908.md). Date AND time are
always required in the filename -- date alone is not sufficient because
multiple versions can be produced on the same day. When a file is
updated, both the date and time in the filename change to reflect the
current edit. No -r2, -r3, _addendum, _additions, _patch, or any
other variant suffix, ever. Every update is a complete replacement
file with the new date-time; it supersedes the prior version. Every
file maintains a cumulative Change History Log in its header so all
history lives inside the file, not in separate patch files. Before
producing any file, Claude must ask Bill for the current date and
time -- both the filename and the internal header come from that
answer. Claude never infers the date or time from UTC chat metadata,
system clocks, or conversation context. UTC timestamps routinely
differ from US Eastern Time by hours or a calendar day. A wrong
date-time in the filename is a wrong version label. No exceptions:
if the date and time have not been provided in this session, Claude
asks before producing any output file.

FILE HEADERS: Every file's internal header must show current DATE AND
TIME in US Eastern Time -- "# Dated: YYYY-MM-DD HH:MM ET" for
.ps1/.psm1, "REM Dated: YYYY-MM-DD HH:MM ET" for .bat,
"<!-- Dated: YYYY-MM-DD HH:MM ET -->" for .md, and a visible
date+time line for .docx/.pptx. Filename date and internal header
date+time must always match -- when either changes, update BOTH in
the same edit, never one without the other.

TIME ZONE: Always use US Eastern Time -- automatically Eastern Daylight
Time (EDT, UTC-4) from mid-March to early November, and Eastern
Standard Time (EST, UTC-5) the rest of the year. Label the timestamp
with "ET" (or "EDT"/"EST" if precision matters), not a raw UTC offset.

CROSS-FILE SYNC: When one file references another by exact filename
(e.g., Run-GatewayGuard.bat referencing a .ps1 build file), check and
update that reference in the same response whenever the referenced
filename changes. Never leave a file pointing to a superseded filename.

---

## PROJECT INSTRUCTIONS -- REPLACEMENT TEXT

Replace the existing FILE NAMING, FILE HEADERS, and revision-suffix
rules in the Project Instructions with the following block:

---

FILE NAMING & VERSIONING (effective 2026-07-20): One unique filename
per document type, forever. The core descriptive name never changes.
Filename syntax: [ProjectName]_[DocumentType]-YYYY-MM-DD-HHMM.ext
(example: GatewayGuard_CodingStandards-2026-07-20-0908.md). Date AND
time are always required in the filename -- date alone is not
sufficient because multiple versions can be produced on the same day.
When a file is updated, both the date and time in the filename change.
No -r2, -r3, _addendum, _additions, _patch, or any other variant
suffix, ever. Every update is a complete replacement file with the new
date-time, uploaded to replace the prior version. Every file maintains
a cumulative Change History Log in its header -- all history lives
inside the file, never in separate patch files. Before producing any
file, Claude must ask Bill for the current date and time -- both the
filename and the internal header come from that answer. Claude never
infers the date or time from UTC chat metadata, system clocks, or
conversation context. UTC timestamps routinely differ from US Eastern
Time by hours or a calendar day. A wrong date-time in the filename is
a wrong version label. If the date and time have not been provided in
this session, Claude asks before producing any output file. No
exceptions.

This rule supersedes the prior same-day revision (-r2/-r3) convention
in WebsiteStandards-2026-07-18 and all other docs. Those docs drop
the revision-suffix language on their next update.

FILE HEADERS: Every file's internal header must show current DATE AND
TIME in US Eastern Time -- "# Dated: YYYY-MM-DD HH:MM ET" for
.ps1/.psm1, "REM Dated: YYYY-MM-DD HH:MM ET" for .bat,
"<!-- Dated: YYYY-MM-DD HH:MM ET -->" for .md. Filename date and
internal header date+time must always match -- update BOTH in the
same edit, never one without the other.

TIME ZONE: Always use US Eastern Time. EDT (UTC-4) mid-March to early
November; EST (UTC-5) the rest of the year. Label timestamps "ET"
(or "EDT"/"EST" if precision matters). Never hardcode a fixed offset.

CROSS-FILE SYNC: Run-GatewayGuard.bat references its paired .ps1
build file by exact filename. Any time the .ps1 is renamed or rebuilt,
the .bat's filename reference must be corrected in the SAME response.
Never leave a .bat pointing to a superseded or deleted filename.
Before ending any turn touching a .ps1 build file, explicitly confirm
whether Run-GatewayGuard.bat still points to the correct filename.

---

## NOTES ON EXISTING FILES TO CLEAN UP

These files currently violate the new rule and should be updated on
their next edit:

| File | Violation | Fix on next edit |
|------|-----------|-----------------|
| GatewayGuard_WebsiteStandards-2026-07-18.md | Contains "-r2/-r3 suffix" language in its own naming section | Remove revision-suffix references |
| guide-index-2026-07-18-r2.html | Has -r2 in filename | Supersede with guide-index-2026-07-20.html when next edited |
| guide-index-2026-07-18-r4.html | Has -r4 in filename | Same -- only one guide-index file should exist |
| guide-index-2026-07-18-r7.html | Has -r7 in filename | This is the current one -- rename to guide-index-2026-07-20.html on next edit |
| CodingStandards_Additions-2026-07-17.md | Should never have been a separate file | Content absorbed into GatewayGuard_CodingStandards-2026-07-20.md; original can be deleted |
| GatewayGuard_ProjectNotes-2026-07-11-r4.md | Has -r4 in filename | Dated snapshot; leave as archive, apply new rule going forward |
