@echo off
title Asset Synchronization Protocol...
color 0b
cls

echo Ready to synchronize assets and launch the visual array?
pause
cls

:: SECTION 1: Clean Asset Download
echo [+] Connecting to remote asset pipeline...
:: Downloads the webp file quietly into your Windows Temp folder
curl -s -o "%temp%\marcus.webp" "https://tuffcdn.pages.dev/marcus.webp"

:: Check if the file successfully downloaded before proceeding
if not exist "%temp%\marcus.webp" (
    echo [!] Error: Asset download failed. Check your internet connection.
    pause
    exit
)

echo [+] Asset secured successfully. Preparing deployment...
pathping 127.0.0.1 -n -q 1 -p 500 >nul
cls

:: SECTION 2: The Image Summoning Loop
echo [+] Deploying visual array...
echo.

for /L %%i in (1,1,15) do (
    echo [!] Spawning Node Aspect %%i...
    
    :: Launches the image
    start "" "%temp%\marcus.webp"
    
    :: A microscopic 80ms delay to stagger the windows neatly across the screen
    pathping 127.0.0.1 -n -q 1 -p 10 >nul
)

echo.
echo =================================================================
echo [DEPLOYMENT COMPLETE] 15 asset layers successfully summoned.
echo =================================================================
echo.

pause
exit