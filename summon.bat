@echo off
title Initializing Networked Matrix...
color 0b
cls

echo Ready to synchronize assets and launch?
pause
cls

:: SECTION 1: Automatic Asset Download
echo [+] Establishing connection to remote asset pipeline...
:: This uses curl to download the webp file directly into your Windows Temp directory
curl -s -o "%temp%\marcus.webp" "https://tuffcdn.pages.dev/marcus.webp"

if exist "%temp%\marcus.webp" (
    echo [+] Asset downloaded successfully.
) else (
    echo [!] Warning: Download failed or blocked. Proceeding with text arrays only.
)
pathping 127.0.0.1 -n -q 1 -p 500 >nul
cls

:: SECTION 2: Spawn Customized Notepad Windows
echo [+] Deploying text arrays...
for /L %%i in (1,1,10) do (
    echo CHIRAG ALONE STANDS AT THE TOP. > "%temp%\matrix_%%i.txt"
    echo THE HONORED ONE HAS AWOKEN. >> "%temp%\matrix_%%i.txt"
    start notepad.exe "%temp%\matrix_%%i.txt"
    pathping 127.0.0.1 -n -q 1 -p 50 >nul
)

:: SECTION 3: Launch the Downloaded Image Panels
if exist "%temp%\marcus.webp" (
    echo [+] Launching downloaded imagery...
    start "" "%temp%\marcus.webp"
    start "" "%temp%\marcus.webp"
)

:: SECTION 4: Spawn Terminal Telemetry Grids
echo [+] Streaming telemetry grids...
for /L %%x in (1,1,8) do (
    if %%x LSS 5 (
        start wt -w -1 cmd /k "color 04 & title Overdrive %%x & echo [!] WARNING: MATRIX OVERLOAD %%x & tree c:\windows"
    )
    if %%x GEQ 5 (
        start wt -w -1 cmd /k "color 0e & title Grid Layer %%x & echo [+] GRID STATUS: STABLE %%x & netstat -an"
    )
    pathping 127.0.0.1 -n -q 1 -p 100 >nul
)

echo.
echo =================================================================
echo [DEPLOYMENT COMPLETE] All nodes active.
echo To close the terminal grids instantly, run:
echo taskkill /f /im WindowsTerminal.exe
echo =================================================================
echo.

pause
exit