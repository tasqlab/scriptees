@echo off
echo [+] Starting Test...

:: Test 1: Can we get the idle time?
echo [+] Checking Idle Time...
for /f "tokens=*" %%i in ('powershell -command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SystemInformation]::IdleTime"') do set "idle_ms=%%i"
echo [+] Raw Idle MS: %idle_ms%

:: Test 2: Can we find curl?
echo [+] Checking for Curl...
where curl >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] ERROR: Curl not found! 
    echo Please install curl or provide the full path to curl.exe
    pause
    exit
)
echo [+] Curl found.

:: Test 3: Send one packet
echo [+] Sending test packet...
curl -v -X POST ^
     -H "Content-Type: application/json" ^
     -d "{\"test\": \"hello_world\", \"idle\": \"%idle_ms%\"}" ^
     "https://webhook.site/2c7348c4-f3c8-4021-bd78-95b6c172ad05"

echo.
echo [+] Done. Check your webhook site.
pause