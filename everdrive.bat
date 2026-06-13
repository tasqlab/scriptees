@echo off
title MATRIX OVERDRIVE ACTIVE
color 0a
cls

echo Ready to push the matrix to maximum velocity?
pause
cls

:: SECTION 1: Quiet Asset Download
echo [+] Fetching remote assets...
curl -s -o "%temp%\marcus.webp" "https://tuffcdn.pages.dev/marcus.webp"

:: SECTION 2: Spawn 5 Image Anchors
if exist "%temp%\marcus.webp" (
    for /L %%i in (1,1,5) do (
        start "" "%temp%\marcus.webp"
        pathping 127.0.0.1 -n -q 1 -p 50 >nul
    )
)

cls
echo [+] SIMULATION STACK OVERFLOW REVERBERATION...
pathping 127.0.0.1 -n -q 1 -p 500 >nul

:: SECTION 3: The Glitch Loop (Changes window size dynamically)
:glitch
:: Dynamically resize the window instantly to throw off the layout
mode con: cols=80 lines=20
color 0a
echo  [!] CHIRAG ALONE STANDS AT THE TOP [!]
echo %random%%random%%random%%random%
pathping 127.0.0.1 -n -q 1 -p 10 >nul

mode con: cols=100 lines=30
color 0c
echo  [!] THE HONORED ONE HAS OVERRIDDEN THE NODE [!]
echo %random%%random%%random%%random%
pathping 127.0.0.1 -n -q 1 -p 10 >nul

mode con: cols=50 lines=15
color 0e
echo  [!] MATRIX REBOOT INBOUND [!]
echo %random%%random%%random%%random%
pathping 127.0.0.1 -n -q 1 -p 10 >nul

goto glitch