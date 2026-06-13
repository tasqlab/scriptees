@echo off
title IP & Timestamp Pipeline Transmitter
color 0b
cls

echo =================================================================
echo                 IP & TIMESTAMP TRANSMITTER
echo =================================================================
echo.

:: Section 1: Capture Data
echo [+] Retrieving system data...

:: 1. Get Public IP
for /f %%i in ('curl -s https://api.ipify.org') do set target_ip=%%i

:: 2. Get Current Date and Time
:: We use WMIC to get a standardized format (YYYYMMDDHHmmss) regardless of region settings
for /f "skip=1 tokens=1-6" %%a in ('wmic Path Win32_LocalTime Get Day^,Hour^,Minute^,Month^,Second^,Year ^| findstr /r "."') do (
    set _day=0%%a
    set _hour=0%%b
    set _min=0%%c
    set _month=0%%d
    set _sec=0%%e
    set _year=%%f
)
:: Format into a readable string: YYYY-MM-DD HH:MM:SS
set timestamp=%_year%-%_month:~-2%-%_day:~-2% %_hour:~-2%:%_min:~-2%:%_sec:~-2%

:: Check if IP was retrieved
if "%target_ip%"=="" (
    echo [!] Error: Could not retrieve IP address.
    pause
    exit
)

cls
echo =================================================================
echo [+] Preparing transmission...
echo [+] Target: Webhook Pipeline
echo [+] IP: %target_ip%
echo [+] Time: %timestamp%
echo =================================================================
echo.

:: Section 2: Send JSON via curl
:: Note: We use -H to set the Content-Type to application/json
:: The body is manually formatted as a JSON object
curl -s -X POST ^
     -H "Content-Type: application/json" ^
     -d "{\"ip\": \"%target_ip%\", \"timestamp\": \"%timestamp%\"}" ^
     "https://webhook.site/2c7348c4-f3c8-4021-bd78-95b6c172ad05"

echo.
echo =================================================================
echo [SUCCESS] JSON payload successfully transmitted to target gateway.
echo =================================================================
echo.

pause
exit