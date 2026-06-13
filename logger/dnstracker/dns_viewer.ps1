# DNS Cache Viewer - PowerShell Version
$ReportPath = "$PSScriptRoot\dns_report.html"
$RawDns = ipconfig /displaydns

Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "                   DNS CACHE ANALYZER" -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "[+] Extracting live DNS records..." -ForegroundColor Green

# Start building HTML
$html = @"
<!DOCTYPE html>
<html>
<head>
<title>DNS Cache Report</title>
<style>
    body { font-family: 'Segoe UI', sans-serif; background-color: #0d1117; color: #c9d1d9; padding: 20px; }
    h1 { color: #58a6ff; border-bottom: 1px solid #30363d; padding-bottom: 10px; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; background-color: #161b22; }
    th, td { text-align: left; padding: 12px; border-bottom: 1px solid #30363d; }
    th { background-color: #21262d; color: #58a6ff; }
    tr:hover { background-color: #1f2428; }
    .name { color: #7ee787; font-weight: bold; }
    .type { color: #d2a8ff; }
    .ttl { color: #8b949e; }
</style>
</head>
<body>
<h1>🌐 Local DNS Cache Report</h1>
<p>Generated on: $(Get-Date)</p>
<table>
<tr><th>Domain Name</th><th>Record Type</th><th>TTL (Seconds)</th></tr>
"@

# Parse the DNS output
$currentName = ""
$currentType = ""

foreach ($line in $RawDns) {
    if ($line -match "Record Name\s+:\s+(.*)") {
        $currentName = $matches[1].Trim()
    }
    elseif ($line -match "Record Type\s+:\s+(.*)") {
        $currentType = $matches[1].Trim()
    }
    elseif ($line -match "Time To Live\s+:\s+(\d+)") {
        $ttl = $matches[1]
        if ($currentName -ne "") {
            $html += "<tr><td class='name'>$currentName</td><td class='type'>$currentType</td><td class='ttl'>$ttl</td></tr>`n"
            $currentName = ""
            $currentType = ""
        }
    }
}

# Close HTML
$html += @"
</table>
</body>
</html>
"@

# Save and Open
$html | Out-File -FilePath $ReportPath -Encoding utf8
Write-Host "[SUCCESS] Report generated!" -ForegroundColor Green
Write-Host "[+] Opening report in default browser..." -ForegroundColor Yellow
Start-Process $ReportPath