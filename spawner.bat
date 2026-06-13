@echo off
title Launching Ultimate Visual Array...
color 0b
echo Ready to launch the full visual layout?
pause

:: SECTION 1: Spawn 15 Distinct Data Terminal Windows
for /L %%i in (1,1,15) do (
    if %%i LSS 6 (
        start wt -w -1 cmd /k "color 02 & title Diagnostic Matrix %%i & echo [+] MONITORING PATH %%i... & tree c:\windows"
    )
    if %%i GEQ 6 if %%i LSS 11 (
        start wt -w -1 cmd /k "color 04 & title Live Port Scan %%i & echo [!] CAPTURING PORTS %%i... & netstat -an"
    )
    if %%i GEQ 11 (
        start wt -w -1 cmd /k "color 0e & title Core Telemetry %%i & echo [!] LOGGING SYSTEM PROFILE %%i... & ipconfig /all"
    )
    :: Microscopic delay so Windows can smoothly space the windows out
    pathping 127.0.0.1 -n -q 1 -p 50 >nul
)

:: SECTION 2: Spawn 5 System Graphics Panels
:: This launches native Windows diagnostic apps to change up the window shapes
start control
start dxdiag
start taskmgr
start systempropertiesadvanced
start resmon

:: SECTION 3: Spawn 5 Separate Image Pop-ups
:: Make sure you have an image file named "meme.jpg" in the exact same folder!
start "" "meme.jpg"
start "" "meme.jpg"
start "" "meme.jpg"
start "" "meme.jpg"
start "" "meme.jpg"

exit
