' start_hidden_logger.vbs (The version that should be on GitHub)
Set WshShell = CreateObject("WScript.Shell") 
' This finds the folder where THIS vbs file is located (AppData)
strPath = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
WshShell.Run "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & strPath & "\safe_logger.ps1""", 0
Set WshShell = Nothing