@echo off
title Multi-Asset Synchronization Protocol...
color 0b
cls

echo Ready to synchronize multiple assets and launch the cycling array?
pause
cls

:: SECTION 1: Quietly Fetch All Assets
echo [+] Connecting to remote asset pipeline...

curl -s -o "%temp%\chcury.webp" "https://tuffcdn.pages.dev/chcury.webp"
curl -s -o "%temp%\chirag.webp" "https://tuffcdn.pages.dev/chirag.webp"
curl -s -o "%temp%\chiragc.webp" "https://tuffcdn.pages.dev/chiragc.webp"
curl -s -o "%temp%\chiragnottuff.webp" "https://tuffcdn.pages.dev/chiragnottuff.webp"
curl -s -o "%temp%\csmoke.webp" "https://tuffcdn.pages.dev/csmoke.webp"
curl -s -o "%temp%\ehay.webp" "https://tuffcdn.pages.dev/ehay.webp"
curl -s -o "%temp%\ruler.webp" "https://tuffcdn.pages.dev/ruler.webp"

echo [+] Assets secured successfully. Preparing deployment...
pathping 127.0.0.1 -n -q 1 -p 500 >nul
cls

:: SECTION 2: The Image Summoning Loop (Set to 20)
echo [+] Deploying visual array...
echo.

for /L %%i in (1,1,20) do (
    echo [!] Spawning Node Aspect %%i...
    
    :: This divides the current loop number by 7 and gets the remainder (0 to 6)
    :: This forces the script to cycle through the images perfectly
    set /a "choice=%%i %% 7"
    
    setlocal enabledelayedexpansion
    if !choice!==0 start "" "%temp%\chcury.webp"
    if !choice!==1 start "" "%temp%\chirag.webp"
    if !choice!==2 start "" "%temp%\chiragc.webp"
    if !choice!==3 start "" "%temp%\chiragnottuff.webp"
    if !choice!==4 start "" "%temp%\csmoke.webp"
    if !choice!==5 start "" "%temp%\ehay.webp"
    if !choice!==6 start "" "%temp%\ruler.webp"
    endlocal
    
    :: 10ms speed delay
    pathping 127.0.0.1 -n -q 1 -p 10 >nul
)

echo.
echo =================================================================
echo [DEPLOYMENT COMPLETE] 20 asset layers successfully summoned.
echo =================================================================
echo.

pause
exit