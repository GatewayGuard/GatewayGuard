import sys
sys.path.insert(0, r"C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\Tool2")
from gg_edit import PS1Edit

PS1 = r"C:\Users\willi\OneDrive - GatewayGuard LLC\GatewayGuard\Tool\W11-SecurityHardening-v3-ascii44-2026-09-06-1214.ps1"

OLD = '''    if (-not $global:IsAdmin) {
        Clear-Host
        Write-Host ""
        Draw-Box -ScreenId "33" -Color White -Lines @(
            "  !  ADMINISTRATOR ACCESS REQUIRED                          ",
            "---",
            "  This tool is running as a STANDARD USER.                  ",
            "  Most security settings require Administrator access.       ",
            "                                                             ",
            "  TO RUN WITH FULL ACCESS:                                   ",
            "  * Close this window                                        ",
            "  * Right-click the tool -> Run as Administrator             ",
            "  * Enter admin password if prompted                         ",
            "                                                             ",
            "  WHAT YOU CAN STILL DO WITHOUT ADMIN:                      ",
            "  * Run Defender and Malwarebytes scans                      ",
            "  * Check Windows Update status                              ",
            "  * Review installed apps list                               ",
            "  * Turn off Advertising ID (your account only)              ",
            "                                                             ",
            "  LIMITED MODE will now run -- admin-only settings           ",
            "  will be skipped and flagged in the log.                    "
        )
        Write-Host ""
        do {
            $cont = Read-ValidKey -ValidKeys @("Y","N") -Prompt "Continue in Limited Mode? (Y = Continue / N = Exit): "
            if ($cont.ToUpper() -eq "N") {
                Write-Host "  Close this window and right-click -> Run as Administrator." -ForegroundColor Yellow
                Save-Log; exit
            }
        } while ($cont.ToUpper() -ne "Y")
        Write-Log -Message "Running in Limited Mode (no admin access)" -Status "WARN"
    } else {'''

NEW = '''    if (-not $global:IsAdmin) {
        Clear-Host
        Write-Host ""
        Draw-Box -ScreenId "33" -Color White -Lines @(
            "  !  ADMINISTRATOR ACCESS REQUIRED                          ",
            "---",
            "  This tool is running as a STANDARD USER.                  ",
            "  Checkup must be run as Administrator to work properly.     ",
            "                                                             ",
            "  HOW TO RUN AS ADMINISTRATOR:                               ",
            "  * Close this window                                        ",
            "  * Right-click the tool -> Run as Administrator             ",
            "  * Enter admin password if prompted                         "
        )
        Write-Host ""
        Pause-ForUser "  Press Enter or Space to CLOSE this window, then re-run as Administrator..."
        Write-Log -Message "Not running as Administrator -- instructions shown, tool closed" -Status "EXIT"
        Disable-SleepPrevention; Save-Log; exit
    } else {'''

with PS1Edit(PS1) as e:
    e.replace(
        OLD, NEW, count=1,
        why="Bill 2026-09-17: 'don't let checkup run without administrative rights'. "
            "Test-AdminAccess's resume-path 'Continue in Limited Mode?' prompt contradicted "
            "FT-25 (2026-07-11), which already removed Limited Mode from the fresh-run gate "
            "(Show-FontInstructions) for the same reason: running without admin meant settings "
            "silently could not apply. The resume path was the one gap left open. Also dropped "
            "the stale 'Run Defender and Malwarebytes scans' line -- Malwarebytes is out of "
            "Checkup entirely, decided 2026-09-08."
    )

print("Edit applied and file parsed clean.")
