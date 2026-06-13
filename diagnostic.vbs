Dim objShell, choice
Set objShell = CreateObject("WScript.Shell")

' Phase 1: Security Warning Popup
choice = MsgBox("Critical signature detected. Initialize defense grid?", 4 + 48, "System Security Alert")

' 4 + 48 means "Yes/No" buttons with an Exclamation icon
If choice = 6 Then ' 6 means the user clicked "Yes"
    
    ' Phase 2: Success Message
    MsgBox "Access Granted. Initializing Overdrive Protocol...", 0 + 64, "Grid Status"
    
    ' Phase 3: Automatically open a command prompt and run a visual command
    objShell.Run "cmd.exe /k color 0c & title OVERDRIVE ACTIVE & echo [!] SYSTEM SECURITY OVERRIDE ACTIVE... & tree c:\windows"

Else ' If the user clicked "No"
    
    MsgBox "Protocol Aborted. System remaining in standby mode.", 0 + 16, "Grid Status"

End If