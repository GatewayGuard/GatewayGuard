"""build_ascii43_f3 -- F3 the log (FT-231).

FT-231: the log filename is stamped once at launch and every entry carried a
time-only prefix, so a multi-day session read as if the clock ran backwards and
"today's log" appeared missing. The cheapest correct fix is a full date in the
one entry formatter in Write-Log.

FT-188 is NOT in this commit because it is ALREADY DONE (ascii41, line 3117-
3129): absent policy keys log INFO / "NOT SET (expected)", real errors log
ERROR. The build plan listed it open; the source shows otherwise. Verified,
not assumed.

Run from the Tool/ directory:  python build_ascii43_f3.py
"""
from gg_edit import PS1Edit

TARGET = r"W11-SecurityHardening-v3-ascii43-2026-08-21-1752.ps1"

with PS1Edit(TARGET) as e:
    e.replace(
        '''    $entry = "[$(Get-Date -Format 'HH:mm:ss')] [$Status] $Message"''',
        '''    $entry = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] [$Status] $Message"''',
        count=1,
        why="FT-231: every log entry carries the date, so a multi-day log reads in order",
    )
