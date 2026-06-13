@echo off
title Alexa, Intruder Alert...
color 0f
cls

echo =================================================================
echo                 SYSTEM SECURITY MONITOR ACTIVE
echo =================================================================
echo.
echo [STATUS] Scan complete. Security perimeter established.
echo.
set /p threat="Type 'intruder' to test tactical response array: "

if /i "%threat%"=="intruder" goto lockdown
echo [SAFE] False alarm. Exiting protocol.
pause
exit

:lockdown
cls
color 0c
title [!] CRITICAL OVERRIDE ACTIVE [!]
echo =================================================================
echo [!] ALERT: DETECTING METAHUMAN SIGNATURE IN SECTOR 4 [!]
echo =================================================================
echo.
echo Launching defense anthem...

:: Opens the working track link in your default browser
start "" "https://www.youtube.com/watch?v=6gNr0RwciEY"

timeout /t 2 >nul
cls
echo.
echo [ALEXA]: "So you have chosen death..."
echo.
timeout /t 2 >nul

:: SECTION 1: Fetch the Meme Defense Assets
echo [+] Synchronizing tactical drone assets...
:: Asset 1: The warning sign / target image
curl -s -o "%temp%\warning.webp" "https://tuffcdn.pages.dev/marcus.webp"

:: SECTION 2: Deploy the Drone Swarm (Ultra-fast 10ms cascade)
echo [!] ENGAGING HOME DEFENSE MATRIX...
for /L %%i in (1,1,20) do (
    
    :: Alternate opening the downloaded roomba/target image
    if exist "%temp%\warning.webp" (
        start "" "%temp%\warning.webp"
    )
    
    :: Spawn high-velocity telemetry windows simulating the defensive drone network
    start wt -w -1 cmd /k "color 04 & title Tactical Drone Node %%i & echo [!] ENFORCING PERIMETER NODE %%i... & tree c:\windows"
    
    :: Your custom 10ms speed delay
    pathping 127.0.0.1 -n -q 1 -p 10 >nul
)

cls
echo =================================================================
echo [PERIMETER SECURED] All tactical counter-measures fully deployed.
echo To recall all active drone windows instantly, run:
echo taskkill /f /im WindowsTerminal.exe
echo =================================================================
echo.
pause
exit