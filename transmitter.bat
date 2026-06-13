@echo off
title Asset Pipeline Text Transmitter
color 0b
cls

echo =================================================================
echo                    CUSTOM TEXT TRANSMITTER
echo =================================================================
echo.

:: Section 1: Capture User Input
echo  _____________
echo ^|enter your text^|
echo  -------------------
echo.
set /p user_text="> "

:: Check if the user entered empty text
if "%user_text%"=="" (
    echo [!] Error: No text entered. Exiting.
    pause
    exit
)

cls
echo =================================================================
echo [+] Preparing transmission...
echo [+] Target: Webhook Pipeline
echo =================================================================
echo.

:: Section 2: Send the data via curl
:: -d sends the data as a standard POST body
:: -s runs curl in silent mode to keep the interface clean
curl -s -d "text=%user_text%" "https://webhook.site/2c7348c4-f3c8-4021-bd78-95b6c172ad05"

echo.
echo =================================================================
echo [SUCCESS] Data payload successfully transmitted to target gateway.
echo =================================================================
echo.

pause
exit