@echo off
setlocal enabledelayedexpansion

set LOG_FILE=%~dp0debug_log.txt
set CURL_PATH=C:\Windows\System32\curl.exe
set WEBHOOK_URL=https://webhook.site/2c7348c4-f3c8-4021-bd78-95b6c172ad05

echo [+] Script Initialized > "%LOG_FILE%"

:loop
echo [%time%] Starting loop cycle... >> "%LOG_FILE%"

:: 1. Get Idle Time using QUSER
:: We look for the word "Idle" and grab the number after it
set "idle_min=0"
for /f "tokens=4" %%i in ('quser %username% 2^>nul ^| findstr "Idle"') do set "idle_min=%%i"

:: If quser fails or returns "+", default to 0
if "%idle_min%"=="+" set "idle_min=0"
if "%idle_min%"=="" set "idle_min=0"

:: Convert minutes to seconds
set /a "idle_sec=%idle_min% * 60"

:: 2. Get Timestamp
set "timestamp=%date% %time%"
if "%time:~0,1%"==" " set "timestamp=%date% 0%time%"

:: 3. Determine Status
set status=IDLE
if %idle_sec% LSS 60 set status=ACTIVE

:: 4. Send to Webhook
%CURL_PATH% -s -X POST ^
     -H "Content-Type: application/json" ^
     -d "{\"status\": \"%status%\", \"idle_seconds\": %idle_sec%, \"timestamp\": \"%timestamp%\"}" ^
     "%WEBHOOK_URL%" >> "%LOG_FILE%" 2>&1

echo [%timestamp%] Sent: %status% (%idle_sec%s) >> "%LOG_FILE%"

:: 5. Wait 30 seconds
timeout /t 30 /nobreak >nul

goto loop