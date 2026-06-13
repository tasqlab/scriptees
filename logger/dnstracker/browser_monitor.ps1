# Smart Browser Monitor with IP-to-Name Resolution
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "                 SMART DOMAIN TRACKER" -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "[+] Resolving IPs to Company Names..." -ForegroundColor Green
Write-Host ""

# Simple local database for common IPs that don't have good DNS names
$knownIPs = @{
    "8.8.8.8" = "Google DNS"; "8.8.4.4" = "Google DNS"
    "1.1.1.1" = "Cloudflare DNS"; "1.0.0.1" = "Cloudflare DNS"
}

while ($true) {
    Clear-Host
    Write-Host "=================================================================" -ForegroundColor Cyan
    Write-Host "                 ACTIVE WEBSITES" -ForegroundColor Cyan
    Write-Host "=================================================================" -ForegroundColor Cyan
    Write-Host "Time: $(Get-Date -Format 'HH:mm:ss')" -ForegroundColor Gray
    Write-Host ""

    $connections = Get-NetTCPConnection -State Established -ErrorAction SilentlyContinue | Where-Object {
        $proc = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue
        $proc.ProcessName -match "chrome|msedge|firefox" -and $_.RemoteAddress -notmatch ":"
    } | Select-Object RemoteAddress, RemotePort, OwningProcess

    if ($connections) {
        Write-Host ("{0,-35} {1,-8} {2,-15}" -f "Website / Service", "Port", "Browser") -ForegroundColor Blue
        Write-Host ("{0,-35} {1,-8} {2,-15}" -f "-------------------------------", "----", "-------") -ForegroundColor Blue

        $seen = @{}

        foreach ($conn in $connections) {
            $remoteIP = $conn.RemoteAddress
            $port = $conn.RemotePort
            $procID = $conn.OwningProcess
            
            try { $procName = (Get-Process -Id $procID -ErrorAction SilentlyContinue).ProcessName } catch { continue }

            $key = "$remoteIP-$port"
            if ($seen.ContainsKey($key)) { continue }
            $seen[$key] = $true

            $displayName = $remoteIP

            # 1. Check Local Known List
            if ($knownIPs.ContainsKey($remoteIP)) {
                $displayName = $knownIPs[$remoteIP]
            } 
            # 2. Try Standard DNS
            else {
                try {
                    $hostEntry = [System.Net.Dns]::GetHostEntry($remoteIP)
                    if ($hostEntry.HostName) {
                        # Clean up Google/Cloudflare internal names
                        $name = $hostEntry.HostName
                        if ($name -match "1e100.net") { $displayName = "Google Services (YouTube/Search)" }
                        elseif ($name -match "google.com") { $displayName = "Google" }
                        elseif ($name -match "webhook.site") { $displayName = "Webhook.site" }
                        elseif ($name -match "microsoft.com") { $displayName = "Microsoft" }
                        else { $displayName = $name }
                    }
                } catch {
                    # 3. Fallback: Use a free IP info API for unknown IPs (Rate limited, so use sparingly)
                    # For this script, we'll just label it as "Cloud Service" if it's a known range
                    if ($remoteIP -like "8.219.*" -or $remoteIP -like "8.212.*") { $displayName = "Alibaba Cloud" }
                    elseif ($remoteIP -like "198.252.*") { $displayName = "StackPath CDN" }
                    elseif ($remoteIP -like "4.237.*") { $displayName = "Microsoft Azure" }
                    else { $displayName = "Unknown Server ($remoteIP)" }
                }
            }

            $color = "White"
            if ($displayName -match "Google|YouTube") { $color = "Red" }
            if ($displayName -match "Webhook") { $color = "Yellow" }
            if ($displayName -match "Microsoft|Azure") { $color = "Blue" }
            if ($displayName -match "Cloud|CDN") { $color = "DarkCyan" }

            Write-Host ("{0,-35} {1,-8} {2,-15}" -f $displayName, $port, $procName) -ForegroundColor $color
        }
    } else {
        Write-Host "No active browser connections found." -ForegroundColor Gray
    }

    Start-Sleep -Seconds 2
}