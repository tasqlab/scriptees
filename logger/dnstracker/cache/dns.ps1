# Clean DNS Cache Viewer
$ReportPath = "$PSScriptRoot\dns_cache_report.html"

Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "                 DNS CACHE VIEWER" -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "[+] Fetching live DNS cache..." -ForegroundColor Green

# Get the cache and sort it
$cache = Get-DnsClientCache | Select-Object Entry, Data, Type, TimeToLive | Sort-Object Entry

if ($cache) {
    # Start HTML
    $html = @"
<!DOCTYPE html>
<html>
<head>
<title>DNS Cache Report</title>
<style>
    body { font-family: 'Segoe UI', sans-serif; background-color: #0d1117; color: #c9d1d9; padding: 20px; }
    h1 { color: #58a6ff; border-bottom: 1px solid #30363d; padding-bottom: 10px; }
    input { width: 100%; padding: 10px; margin-bottom: 20px; background: #161b22; border: 1px solid #30363d; color: white; border-radius: 5px; }
    table { width: 100%; border-collapse: collapse; background-color: #161b22; }
    th, td { text-align: left; padding: 12px; border-bottom: 1px solid #30363d; }
    th { background-color: #21262d; color: #58a6ff; position: sticky; top: 0; }
    tr:hover { background-color: #1f2428; }
    .entry { color: #7ee787; font-weight: bold; }
    .data { color: #d2a8ff; }
    .ttl { color: #8b949e; font-size: 0.9em; }
</style>
</head>
<body>
<h1>🌐 Local DNS Cache</h1>
<p>Total Records: $($cache.Count)</p>
<input type="text" id="searchBox" onkeyup="filterTable()" placeholder="Search for a domain...">
<table id="dnsTable">
<tr><th>Domain (Entry)</th><th>IP Address (Data)</th><th>Type</th><th>TTL (s)</th></tr>
"@

    # Add rows
    foreach ($item in $cache) {
        $html += "<tr>"
        $html += "<td class='entry'>$($item.Entry)</td>"
        $html += "<td class='data'>$($item.Data)</td>"
        $html += "<td>$($item.Type)</td>"
        $html += "<td class='ttl'>$($item.TimeToLive)</td>"
        $html += "</tr>`n"
    }

    # Add Search Script and Close
    $html += @"
</table>
<script>
function filterTable() {
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("searchBox");
    filter = input.value.toUpperCase();
    table = document.getElementById("dnsTable");
    tr = table.getElementsByTagName("tr");
    for (i = 1; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[0];
        if (td) {
            txtValue = td.textContent || td.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }       
    }
}
</script>
</body>
</html>
"@

    # Save and Open
    $html | Out-File -FilePath $ReportPath -Encoding utf8
    Write-Host "[SUCCESS] Report generated!" -ForegroundColor Green
    Start-Process $ReportPath
} else {
    Write-Host "[!] No DNS cache entries found." -ForegroundColor Yellow
}