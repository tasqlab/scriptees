' get_title.vbs - A lightweight window title getter
Do
    Set WshShell = CreateObject("WScript.Shell")
    ' Get the title of the active window
    strTitle = WshShell.AppActivate(WshShell.CurrentDirectory) ' Dummy call to refresh
    ' We actually need a different approach for VBS alone, 
    ' but let's use a simpler WMI query that is faster than PowerShell
    Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
    Set colItems = objWMIService.ExecQuery("Select * from Win32_Process Where ProcessId = " & GetForegroundProcessId())
    
    ' Since VBS can't easily get Foreground Window without API calls, 
    ' let's stick to the Batch+PowerShell hybrid but optimize the Batch side.
Loop