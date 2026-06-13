# Live Network Traffic Monitor
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "                 LIVE TRAFFIC MONITOR" -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "[+] Monitoring active network connections..." -ForegroundColor Green
Write-Host "[!] Press Ctrl+C to stop." -ForegroundColor Yellow
Write-Host ""

while ($true) {
    Clear-Host
    Write-Host "=================================================================" -ForegroundColor Cyan
    Write-Host "                 LIVE TRAFFIC MONITOR" -ForegroundColor Cyan
    Write-Host "=================================================================" -ForegroundColor Cyan
    Write-Host "Time: $(Get-Date -Format 'HH:mm:ss')" -ForegroundColor Gray
    Write-Host ""

    # Get all established TCP connections
    $connections = Get-NetTCPConnection -State Established -ErrorAction SilentlyContinue | Select-Object RemoteAddress, RemotePort, OwningProcess

    if ($connections) {
        Write-Host ("{0,-40} {1,-10} {2,-20}" -f "Domain/IP", "Port", "Process") -ForegroundColor Blue
        Write-Host ("{0,-40} {1,-10} {2,-20}" -f "----------------------", "----", "-------") -ForegroundColor Blue

        foreach ($conn in $connections) {
            $remoteIP = $conn.RemoteAddress
            $port = $conn.RemotePort
            $procID = $conn.OwningProcess
            
            # Try to get Process Name
            try {
                $procName = (Get-Process -Id $procID -ErrorAction SilentlyContinue).ProcessName
            } catch {
                $procName = "Unknown"
            }

            # Try to resolve IP to Domain Name
            $domain = $remoteIP
            try {
                $hostEntry = [System.Net.Dns]::GetHostEntry($remoteIP)
                if ($hostEntry.HostName) {
                    $domain = $hostEntry.HostName
                }
            } catch {
                # If reverse DNS fails, keep the IP
            }

            # Filter out local/private IPs if you want (optional)
            if ($domain -notmatch "^192\.168\.|^10\.|^127\.") {
                Write-Host ("{0,-40} {1,-10} {2,-20}" -f $domain, $port, $procName) -ForegroundColor White
            }
        }
    } else {
        Write-Host "No active external connections found." -ForegroundColor Gray
    }

    # Wait 3 seconds before refreshing
    Start-Sleep -Seconds 3
}