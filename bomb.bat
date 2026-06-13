@echo off
title Launching..
color 0a

:: If this file was launched as a sub-process for the loop, jump straight to it
if "%1"=="honored_one" goto honored_one

echo Ready to launch the stuff?
pause

:: Loop exactly 35 times
for /L %%i in (1,1,35) do (

    :: Windows 1-8: Green "Matrix" style running file directories
    if %%i LSS 9 (
        start wt -w -1 cmd /k "color 02 & title Node Segment %%i & echo [!] ACTIVE DIRECTORY READOUT %%i... & tree c:\windows"
    )

    :: Windows 9-16: Red "Network Alert" style displaying IP configurations
    if %%i GEQ 9 if %%i LSS 17 (
        start wt -w -1 cmd /k "color 04 & title Network Subnet %%i & echo [!] READING GATEWAY PATH %%i... & ipconfig /all"
    )

    :: Windows 17-24: Aqua "Data Streaming" style outputting computer hardware info
    if %%i GEQ 17 if %%i LSS 25 (
        start wt -w -1 cmd /k "color 0b & title Core Telemetry %%i & echo [!] POLLUTION MATRIX ANALYSIS %%i... & systeminfo"
    )

    :: Windows 25-29: Yellow "Security Firewall" style running active connection logs
    if %%i GEQ 25 if %%i LSS 30 (
        start wt -w -1 cmd /k "color 0e & title Tunnel Integrity %%i & echo [!] CHECKING PORT ASSIGNMENTS %%i... & netstat -an"
    )

    :: Windows 30-35: The Ultimate Standout Windows (Spammy Text + Color Flash Fixed)
    if %%i GEQ 30 (
        start wt -w -1 cmd /c "%~f0" honored_one %%i
    )

    :: Tiny 100ms pause so your CPU can render the windows smoothly without freezing
    pathping 127.0.0.1 -n -q 1 -p 100 >nul
)

exit

:: =========================================================================
:: THIS IS THE WORKING LOOP FUNCTION AT THE BOTTOM OF THE FILE
:: =========================================================================
:honored_one
title the honored one %2
:spamloop
color 0A
echo chirag alone stands at the top!!
color 0C
echo chirag alone stands at the top
color 0E
echo chirag alone stands at the top
color 0B
echo chirag alone stands at the top
goto spamloop

:: This batch file will open 30 Windows Terminal windows with different styles and commands to simulate a "hacker" environment. Each window will display different system information, such as directory structures, network configurations, hardware info, and active connections. The windows will be color-coded for visual effect.
:: Note: This script is for entertainment purposes only and should not be used for any malicious activities. Always ensure you have permission to access and run commands on any system.

:: To stop the script, simply run `taskkill /f /im WindowsTerminal.exe`

:: Disclaimer: Running this script may cause high CPU usage due to the number of windows being opened. Use with caution and close the windows if your system becomes unresponsive.
:: Enjoy the "hacker" aesthetic!
