@echo off
:: FixInternet.bat -- SANDY Wi-Fi Recovery Tool
:: Run this when browsers can't reach any sites after Wi-Fi reconnects
:: Double-click and run as Administrator

echo.
echo Fixing internet connection...
echo.

:: Flush stale DNS cache
ipconfig /flushdns
echo DNS cache cleared.

:: Force Wi-Fi to get a fresh IPv4 address from router
ipconfig /renew "Wi-Fi"
echo.

:: Show current IP to confirm it worked
echo Current IP address:
ipconfig | findstr /i "IPv4"
echo.
echo Done! Try your browser now.
echo If still not working, restart SANDY completely.
echo.
pause
